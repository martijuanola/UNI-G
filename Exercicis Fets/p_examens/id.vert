#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 3) in vec2 texCoord;

out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main() {
    vtexCoord = texCoord;
    
    mat4 T = mat4(vec4(1.0,0,0,0),vec4(0,0.5,0,0),vec4(0,0,1.0,0),vec4(0,0,0,1.0));
    gl_Position = modelViewProjectionMatrix * T * vec4(vertex, 1.0);
}
