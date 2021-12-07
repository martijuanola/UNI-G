#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;



void main() {
    frontColor = vec4(color,1.0);
    vec3 newv = vertex;
    if(abs(newv.x) > abs(newv.y) && abs(newv.x) > abs(newv.z)) newv /= abs(newv.x);
    else if(abs(newv.y) > abs(newv.z)) newv /= abs(newv.y);
    else newv /= abs(newv.z);
    
    gl_Position = modelViewProjectionMatrix * vec4(newv, 1.0);
}
