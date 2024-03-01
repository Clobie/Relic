shader_type canvas_item;
render_mode unshaded;

void fragment() {
	float avg = COLOR.r * 0.299 + COLOR.g * 0.587 + COLOR.b * 0.114;
	COLOR = vec4(vec3(avg), COLOR.a);
}
