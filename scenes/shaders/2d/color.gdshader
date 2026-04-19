shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;
const float color_factor = 24.0;

void fragment() {
	// Sample the original screen texture
	vec4 original_color = texture(screen_texture, SCREEN_UV);
	vec4 new_color = original_color;
	float noise = 0.0;

	// Add noise to the original color
	original_color.rgb *= vec3(color_factor, color_factor, color_factor);
	new_color.rgb = floor(original_color.rgb);
	new_color.rgb /= vec3(color_factor, color_factor, color_factor);

	// Clamp the final color to make sure it stays in the valid range
	COLOR = clamp(new_color, 0.0, 1.0);
}
