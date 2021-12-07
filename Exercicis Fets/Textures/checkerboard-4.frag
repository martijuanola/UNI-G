#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform float n = 113 * 2;

void main()
{
	int segments = 10;
	float tile = 1.0/(n*segments);
	int a = int(mod(vtexCoord.s/tile,segments) > 1);
	int b = int(mod(vtexCoord.t/tile,segments) > 1);
    if(1 >= a+b) fragColor = vec4(1.0,0.0,0.0,1.0);
	else discard;
}
