#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform float n = 8;

void main()
{
	float tile = 1.0/n;
	int a = int(mod(vtexCoord.s/tile,2) > 1);
	int b = int(mod(vtexCoord.t/tile,2) > 1);
    fragColor = vec4(vec3(0.8*(1-(a+b)%2)),1.0);
}

