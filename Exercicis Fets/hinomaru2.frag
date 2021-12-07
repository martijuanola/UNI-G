#version 330 core

in vec2 vtexCoord;
in vec4 frontColor;
out vec4 fragColor;

uniform bool classic;

void main()
{
	float pi = 3.1416;
	vec2 u = vtexCoord-vec2(0.5,0.5);
	float dist = distance(vtexCoord,vec2(0.5,0.5));
	float angle = atan(u.t, u.s);
	
	bool c = bool(step(0.2, dist));
	
	if(!c || (c && !classic && mod(angle/(pi/16) +0.5, 2) < 1)) {
		fragColor = vec4(1.0,0.0,0.0,1.0);
	}
	else {
		fragColor = vec4(1.0,1.0,1.0,1.0);
	}
}
 
 
