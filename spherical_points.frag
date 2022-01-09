#version 330 core

in vec2 textCoord;

out vec4 fragColor;

uniform sampler2D colorMap;

void main()
{
    fragColor = texture(colorMap,textCoord);
}
