#version 330 core

in vec2 vtexCoord;
in vec4 frontColor;
out vec4 fragColor;

uniform sampler2D colorMap;

void main()
{
    fragColor = frontColor * texture(colorMap, vtexCoord);
}
