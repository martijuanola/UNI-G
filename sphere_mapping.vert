#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec3 v;
out vec3 n;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform mat4 viewMatrix;

uniform bool worldSpace;

void main() {
	if(worldSpace) {
		v = vertex;
		n = normal;
	}
	else {
		v = vec3(viewMatrix * vec4(vertex,1.0));
		n = normalMatrix * normal;
	}
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
