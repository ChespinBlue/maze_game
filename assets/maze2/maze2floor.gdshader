shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float r = (sin(TIME*UV.x*30.0) + 1.0) * 0.5;
	float g = (sin(TIME + 2.0) + 1.0) * 0.5;
	float b = (sin(TIME + 4.0) + 1.0) * 0.5;
	ALBEDO = vec3(r, g, b);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
