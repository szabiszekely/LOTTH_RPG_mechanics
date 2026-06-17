shader_type canvas_item;
render_mode blend_mix;
// The speed of the horizontal flame movement (sway)
uniform float sway_speed : hint_range(0.1, 5.0) = 1.0;
// How far the texture is displaced horizontally
uniform float sway_strength : hint_range(0.0, 0.15) = 0.01;
// Scales the noise to control the size of the waves/flickers
uniform float noise_scale : hint_range(1.0, 40.0) = 5.0;

// NEW: This uniform will hold the time offset for this specific flame instance.
uniform float time_offset : hint_range(0.0, 100.0) = 0.0;
uniform float color_alpha : hint_range(0.0, 1.0) = 1.0;
uniform bool work = true;

// Simple noise function (adapted from common GLSL techniques)
float noise1(vec2 p, float t) { // Pass the time 't' as an argument
    // We use the passed-in time 't' instead of the global TIME
    float n = sin(p.x * 2.0 + t * sway_speed) * 0.5;
    n += sin(p.y * 5.0 + t * sway_speed * 1.5) * 0.3;
    return n;
}

void fragment() {
    // 1. Calculate the INSTANCE TIME: TIME + offset
    float instance_time = TIME + time_offset;

    vec2 distorted_uv = UV;

    // 2. Call the noise function with the instance-specific time
    float displacement = noise1(UV * noise_scale, instance_time) * sway_strength;

    // 3. Apply the displacement
    distorted_uv.x += displacement;

    // 4. Sample the original texture
    vec4 color = texture(TEXTURE, distorted_uv);


	vec4 tint_color = vec4(0.0, 0.0, 0.0, color_alpha);
	vec4 texture_color = texture(TEXTURE, UV);
	if (work) {
    	COLOR = color + texture_color * tint_color;

	} else {
		COLOR = texture_color * tint_color;
	}

}