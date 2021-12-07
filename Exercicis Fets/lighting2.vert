#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform vec4 lightAmbient;
uniform vec4 lightDiffuse;
uniform vec4 lightSpecular;
uniform vec4 lightPosition;

uniform vec4 matAmbient;
uniform vec4 matDiffuse;
uniform vec4 matSpecular;
uniform float matShininess;

vec4 Phong(vec3 N, vec4 P) {
	vec4 A, D, S;
	vec3 L, R, V;
	float NL, RVs;
	
	L = vec3(normalize(lightPosition - P).xyz);
	V = normalize(-vec3(P).xyz);
	
	NL = max(0.0,dot(N,L));
	R = normalize(2*NL*N-L);
	RVs = 0;
	if(NL >= 0) RVs = pow(max(0.0,dot(R,V)), matShininess);
	
	
	A = lightAmbient * matAmbient;
	D = lightDiffuse * matDiffuse * NL;
	S = lightSpecular * matSpecular * RVs;

	return A + D + S;
}

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    vec4 P = modelViewMatrix * vec4(vertex, 1.0);
    frontColor = Phong(N,P);
    vtexCoord = texCoord; 
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
