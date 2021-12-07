#version 330 core

in vec3 N;
in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D colormap;

void main()
{
	float radi = 0.05;
	vec2 C1 = vec2(0.34,0.65) - 0.1*N.xy;
	vec2 C2 = vec2(0.66,0.65) - 0.1*N.xy;
	
	if(distance(vtexCoord,C1) < radi || distance(vtexCoord,C2) < radi) {
		fragColor = vec4(0,0,0,1.0);
	}
    else fragColor = texture(colormap,vtexCoord);
}
