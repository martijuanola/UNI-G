#version 330 core

in vec2 vtexCoord;
in vec4 frontColor;
out vec4 fragColor;

uniform sampler2D colorMap;
uniform float slice = 1.0/30.0;
uniform int fx = 8;
uniform int fy = 6;
uniform float time;

void main()
{
	int frames = fx*fy;
	float ybit = 1.0/fy;
	float xbit = 1.0/fx;
	int frame = int(mod(time/slice,frames));
	vec2 t = vec2((vtexCoord.x + (frame%fx))*xbit,(vtexCoord.y + (fy-1-frame/fx))*ybit);
    fragColor = texture(colorMap, t);
    fragColor = fragColor.a * fragColor;
}
