#version 330 core

in vec4 gfrontColor;
in vec2 tc;
out vec4 fragColor;

uniform sampler2D text;

void main()
{
    if(tc.x < 0) {
		fragColor = gfrontColor;
	}
	else {
		vec4 color = texture(text, tc);
		if(color.w <= 0.1) discard;
		else fragColor = color;
	}
}
