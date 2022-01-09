#version 330 core
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec3 N;

void main()
{
	N = normalize(normalMatrix * normal);
	gl_Position = modelViewProjectionMatrix * vec4(vertex,1.0);
}

