#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec3 v;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelMatrix;

void main() {
	v = vec3(modelMatrix*vec4(vertex,1.0));
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
