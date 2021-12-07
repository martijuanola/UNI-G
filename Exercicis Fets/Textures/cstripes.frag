#version 330 core

in vec2 vtexCoord;
in vec4 frontColor;
out vec4 fragColor;

uniform int nstripes = 16;
uniform vec2 origin=vec2(0,0);

void main()
{
	float d = distance(origin,vtexCoord);
    fragColor = vec4(vec3(1.0,1.0-int(mod(d,2*1.0/nstripes) < 1.0/nstripes),0.0),1.0);
}
 
