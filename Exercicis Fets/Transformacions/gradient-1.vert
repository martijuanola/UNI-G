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
	float escalar = (vertex[1]-boundingBoxMin.y)/(boundingBoxMax.y-boundingBoxMin.y);
	frontColor = vec4(mix(vec3(float(escalar<0.5),float(escalar>0.25),float(escalar>0.75)),vec3(float(escalar<0.25),float(escalar<0.75),float(escalar>0.5)),fract(4*escalar)),1);
    vtexCoord = texCoord;  
    gl_Position = modelViewProjectionMatrix * vec4(vertex,  1.0);
}


/*
 *  vec3 N = normalize(normalMatrix * normal);
	float escalar = (vertex[1]-boundingBoxMin.y)/(boundingBoxMax.y-boundingBoxMin.y);
    if(escalar > 0.75) frontColor = vec4(mix(vec3(0.0,1.0,1.0),vec3(0.0,0.0,1.0),(escalar-0.75) * 4),1);
    else if(escalar > 0.5) frontColor = vec4(mix(vec3(0.0,1.0,0.0),vec3(0.0,1.0,1.0),(escalar-0.5) * 4),1);
    else if(escalar > 0.25) frontColor = vec4(mix(vec3(1.0,1.0,0.0),vec3(0.0,1.0,0.0),(escalar-0.25) * 4),1);
    else frontColor = vec4(mix(vec3(1.0,0.0,0.0),vec3(1.0,1.0,0.0),4 * escalar),1);
    
    
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex,  1.0);
 * 
 * */
