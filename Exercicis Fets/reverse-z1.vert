#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0) * abs(N.z);
    float mid = boundingBoxMin.z + (boundingBoxMax.z-boundingBoxMin.z)/2;
    vtexCoord = texCoord;
    vec4 aux = modelViewProjectionMatrix * vec4(vertex, 1.0);
    aux.z = mid-(aux.z-mid);
    gl_Position = aux;
}

