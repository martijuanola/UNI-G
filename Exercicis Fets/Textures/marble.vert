#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec3 N;
out vec3 vo;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main()
{
	vo = vertex;
    N = normalize(normalMatrix * normal);
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
