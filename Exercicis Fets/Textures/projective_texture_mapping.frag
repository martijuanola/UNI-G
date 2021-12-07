#version 330 core

in vec2 vtexCoord;
in vec3 N;
out vec4 fragColor;

uniform sampler2D sampler0;

void main()
{
    fragColor = texture(sampler0,vtexCoord) * N.z;
}
