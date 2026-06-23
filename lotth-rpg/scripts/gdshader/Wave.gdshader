shader_type canvas_item;
render_mode blend_mix;

uniform float sway_speed : hint_range(0.1, 5.0) = 1.0;
uniform float sway_strength : hint_range(0.0, 0.15) = 0.01;
uniform float noise_scale : hint_range(1.0, 40.0) = 5.0;
uniform float time_offset : hint_range(0.0, 100.0) = 0.0;

// This is the fade control. 1.0 is fully visible, 0.0 is invisible.
uniform float color_alpha : hint_range(0.0, 1.0) = 1.0;

float noise1(vec2 p, float t) {
    float n = sin(p.x * 2.0 + t * sway_speed) * 0.5;
    n += sin(p.y * 5.0 + t * sway_speed * 1.5) * 0.3;
    return n;
}

void fragment() {
    float instance_time = TIME + time_offset;

    vec2 distorted_uv = UV;
    float displacement = noise1(UV * noise_scale, instance_time) * sway_strength;
    distorted_uv.x += displacement;

    vec4 color = texture(TEXTURE, distorted_uv);

    // Fade the whole thing out by scaling its alpha
    color.a *= color_alpha;

    COLOR = color;
}