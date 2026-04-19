shader_type canvas_item;

uniform float lod: hint_range(0.0, 5) = 0.0;
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

const float color_factor = 8.0;

void fragment(){
	vec4 original_color = texture(screen_texture, SCREEN_UV, lod);
	// Sample the original screen texture
	///vec4 original_color = texture(screen_texture, SCREEN_UV);
	vec4 new_color = original_color;
	float noise = 0.0;

	// Add noise to the original color
	original_color.rgb *= vec3(color_factor, color_factor, color_factor);
	new_color.rgb = floor(original_color.rgb);
	new_color.rgb /= vec3(color_factor, color_factor, color_factor);

	// Clamp the final color to make sure it stays in the valid range
	COLOR = clamp(new_color, 0.0, 1.0);
}