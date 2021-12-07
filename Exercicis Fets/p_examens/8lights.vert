#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec4 frontColor;
out vec3 N;
out vec3 P;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform mat4 modelMatrixInverse;


void main() {
    N = normalize(vec3(modelMatrixInverse * vec4(normal,1.0)));
    P = vertex;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
