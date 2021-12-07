#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float t = 4.0;
uniform float scale = 4.0;

uniform vec3 boundingBoxMin; //cantonada de la capsa englobant
uniform vec3 boundingBoxMax; //cantonada de la capsa englobant

void main() {
	vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0) * N.z;

	float c = mix(boundingBoxMin.y,boundingBoxMax.y,t);
	vec3 newv = vertex;
	
	mat3 trans = mat3(vec3(1.0,0,0),vec3(0,scale,0),vec3(0,0,1));
	float d = c*scale-c;
	mat4 move = mat4(vec4(1,0,0,0),vec4(0,1,0,0),vec4(0,0,1,0),vec4(0,d,0,1));
	
	if(newv.y < c) {
		newv = trans * newv;
		gl_Position = modelViewProjectionMatrix * vec4(newv, 1.0);
	}
	else gl_Position = modelViewProjectionMatrix * move * vec4(newv, 1.0);

    
}
