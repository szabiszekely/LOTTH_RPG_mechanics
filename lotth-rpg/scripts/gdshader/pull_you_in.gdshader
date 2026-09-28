shader_type canvas_item;
// Star Wars-style hyperspace jump — put this on a full-screen ColorRect
// (objs/hyperspace.tscn wraps it with the enter/exit sequence). Stars fly
// outward from a vanishing point and each one is drawn as the streak it
// would leave over a fixed span of camera travel, so streaks stretch and
// accelerate toward the screen edge the way real perspective does instead
// of just being lines that scale.
//
//   warp    0 = ship idling: near-stationary star dots
//           1 = full jump: long hot-white streaks, blue tails, bright core
//   tunnel  the swirling blue tunnel layered over the streaks
//   flash   white-out that covers the moment of jumping in / dropping out
//   opacity fades the whole overlay over whatever is behind it
//
// Motion comes from `travel`, which a script accumulates (so speed can
// ramp up without the streaks jumping). Leave `auto_speed` above 0 to let
// the shader animate itself off TIME when nothing is feeding `travel`.
// Assumes the rect fills the viewport — aspect comes from
// SCREEN_PIXEL_SIZE.

uniform float warp : hint_range(0.0, 1.0) = 1.0;
uniform float tunnel : hint_range(0.0, 1.0) = 1.0;
uniform float flash : hint_range(0.0, 1.0) = 0.0;
uniform float opacity : hint_range(0.0, 1.0) = 1.0;

uniform float travel = 0.0;
uniform float auto_speed = 1.0;
uniform vec2 center = vec2(0.5, 0.5);
uniform float shake : hint_range(0.0, 0.02) = 0.002;   // rumble on the vanishing point, scaled by warp

uniform float star_density : hint_range(20.0, 300.0) = 80.0;   // angular slices in the sparsest layer (the other two are denser)
uniform float star_amount : hint_range(0.0, 1.0) = 0.65;       // fraction of slices that actually hold a star
uniform float streak_length : hint_range(0.05, 1.0) = 0.4;     // tail length at full warp, in depth units
uniform float star_thickness : hint_range(0.0005, 0.01) = 0.0025;
uniform float star_brightness : hint_range(0.0, 3.0) = 1.4;

uniform vec4 star_color : source_color = vec4(0.92, 0.96, 1.0, 1.0);        // white-hot head
uniform vec4 tail_color : source_color = vec4(0.3, 0.55, 1.0, 1.0);         // what the streak cools to
uniform vec4 core_color : source_color = vec4(0.35, 0.6, 1.0, 1.0);
uniform vec4 tunnel_color : source_color = vec4(0.1, 0.3, 0.9, 1.0);
uniform vec4 background_color : source_color = vec4(0.0, 0.0, 0.025, 1.0);
uniform float core_strength : hint_range(0.0, 3.0) = 1.3;

float hash11(float n) {
	return fract(sin(n * 127.1) * 43758.5453123);
}

float hash21(vec2 p) {
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

// Value noise that tiles horizontally every `period` cells, so it wraps
// seamlessly around the angle seam of the tunnel.
float tiling_noise(vec2 p, float period) {
	vec2 i = floor(p);
	vec2 f = fract(p);
	f = f * f * (3.0 - 2.0 * f);
	float a = hash21(vec2(mod(i.x, period), i.y));
	float b = hash21(vec2(mod(i.x + 1.0, period), i.y));
	float c = hash21(vec2(mod(i.x, period), i.y + 1.0));
	float d = hash21(vec2(mod(i.x + 1.0, period), i.y + 1.0));
	return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

// One layer of stars. The screen is cut into angular slices around the
// vanishing point, each holding at most one star. A star has a fixed
// lateral distance `rho` and a depth `z` that shrinks as the camera
// travels, so its screen radius is rho / z — it drifts near the center,
// then rips outward as it passes the camera. The streak is everything
// that star covered while its depth went from z to z + trail.
vec3 star_layer(float ang, float r, float layer, float phase, float trail) {
	float slices = floor(star_density * (1.0 + layer * 0.6));
	float a = ang * slices;
	float seed = floor(a) + layer * 137.0 + 1.0;

	float h_alive = hash11(seed + 3.1);
	if (h_alive > star_amount) {
		return vec3(0.0);
	}

	float h_rho = hash11(seed);
	float h_z = hash11(seed + 11.7);
	float h_speed = hash11(seed + 23.3);
	float h_off = hash11(seed + 37.9);
	float h_col = hash11(seed + 51.1);

	// Quarter-step speeds keep `phase` wrapping at 4.0 seamless.
	float speed_mult = 0.75 + 0.25 * floor(h_speed * 4.0);
	float z = fract(h_z - phase * speed_mult);
	float rho = mix(0.02, 0.4, h_rho * h_rho);

	float depth_here = rho / max(r, 0.0001);
	float along = (depth_here - z) / max(trail, 0.0001);   // 0 at the head, 1 at the tail end
	float body = smoothstep(-0.02, 0.02, along) * step(along, 1.0);
	float heat = 1.0 - clamp(along, 0.0, 1.0);

	// Distance from this star's own ray (each star sits a little off its slice's middle).
	float local = fract(a) - 0.5 - (h_off - 0.5) * 0.4;
	float dist = abs(local) * (TAU / slices) * r;
	float width = star_thickness * (0.5 + h_col) * (0.4 + r);
	float streak = 1.0 - smoothstep(0.0, width, dist);
	float halo = 1.0 - smoothstep(0.0, width * 5.0, dist);

	float spawn = 1.0 - smoothstep(0.8, 1.0, z);          // fade in instead of popping at the center
	float approach = 0.35 + 0.65 * (1.0 - z);             // brighter as it gets close
	float clear_center = smoothstep(0.02, 0.12, r);       // keep specks out of the core

	vec3 c = mix(tail_color.rgb, star_color.rgb, heat * heat);
	c = mix(c, vec3(1.0, 0.85, 0.7), step(0.92, h_col) * 0.5);   // the odd warm star
	float intensity = (streak + halo * halo * 0.35) * pow(heat, 1.6) * body * spawn * approach * clear_center;
	return c * intensity;
}

void fragment() {
	vec2 res = 1.0 / SCREEN_PIXEL_SIZE;
	float aspect = res.x / res.y;

	vec2 vp = center + vec2(sin(TIME * 43.0), cos(TIME * 37.0)) * shake * warp;
	vec2 p = (UV - vp) * vec2(aspect, 1.0);
	float r = length(p);
	float ang = atan(p.y, p.x) / TAU + 0.5;

	float phase = travel + TIME * auto_speed;
	float trail = mix(0.006, streak_length, warp * warp);

	vec3 col = vec3(0.0);
	for (int i = 0; i < 3; i++) {
		col += star_layer(ang, r, float(i), phase, trail);
	}
	col *= star_brightness;

	// Tunnel: noise laid out in (angle, depth) space, scrolling outward
	// with travel, so it reads as rushing past instead of sitting on top.
	float depth = 1.0 / max(r, 0.02);
	vec2 tuv = vec2(ang * 6.0, depth * 0.35 + phase * 1.4);
	float swirl = tiling_noise(tuv, 6.0) * 0.6 + tiling_noise(tuv * 2.0 + 7.3, 12.0) * 0.4;
	float tunnel_falloff = exp(-r * 1.7);
	col += tunnel_color.rgb * swirl * swirl * 1.6 * tunnel_falloff * tunnel;

	// Core: the bright vanishing point, growing tighter and hotter with warp.
	float core = exp(-r * mix(9.0, 4.6, warp)) * core_strength * mix(0.15, 1.0, warp);
	col += core_color.rgb * core;
	col += vec3(1.0) * pow(core, 3.0) * 0.6;

	col += vec3(flash);

	COLOR = vec4(background_color.rgb + col, opacity);
}
