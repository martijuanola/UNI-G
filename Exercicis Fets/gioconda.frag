#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform float time;
uniform sampler2D sampler0;

void main()
{
	fragColor = texture(sampler0, vtexCoord);
	if(fract(time) > 0.5 && distance(vtexCoord,vec2(0.393,0.652)) <= 0.025) {
		fragColor = texture(sampler0, vtexCoord + vec2(0.057,-0.172));
	}
}
