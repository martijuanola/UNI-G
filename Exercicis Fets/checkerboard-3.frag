#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform float n = 8;

void main()
{
	int segments = 10;
	float tile = 1.0/(n*segments);
	int a = int(mod(vtexCoord.s/tile,segments) > 1);
	int b = int(mod(vtexCoord.t/tile,segments) > 1);
    fragColor = vec4(vec3(0.0+0.8*(int(1 < a+b))),1.0);
}
