#version 330 core

in vec2 vtexCoord;
in vec4 frontColor;
out vec4 fragColor;

void main()
{
	int strips = 9;
	float a = 1.0/strips;
	float f = mod(vtexCoord.s,1);
    fragColor = vec4(vec3(1.0,1.0-int(mod(f,2*a)>a),0.0),1.0);
}
 
