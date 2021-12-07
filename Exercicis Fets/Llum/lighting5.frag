#version 330 core

in vec3 vertex;
in vec3 normal;

in vec3 N;
in vec4 P;

out vec4 fragColor;

uniform mat3 normalMatrix;
uniform mat4 modelViewMatrixInverse;

uniform vec4 lightAmbient;
uniform vec4 lightDiffuse;
uniform vec4 lightSpecular;
uniform vec4 lightPosition;

uniform vec4 matAmbient;
uniform vec4 matDiffuse;
uniform vec4 matSpecular;
uniform float matShininess;

uniform bool world;

vec4 light(vec3 N, vec3 V, vec3 L) {
	N=normalize(N); V=normalize(V); L=normalize(L);
	vec3 R = normalize( 2.0*dot(N,L)*N-L );
	float NdotL = max( 0.0, dot( N,L ) );
	float RdotV = max( 0.0, dot( R,V ) );
	float Idiff = NdotL;
	float Ispec = 0;
	if (NdotL>0) Ispec=pow( RdotV, matShininess );
	return
	matAmbient * lightAmbient +
	matDiffuse * lightDiffuse * Idiff+
	matSpecular * lightSpecular * Ispec;
}

void main() {
	vec3 V, L, NN;
	if(world) {
		NN = normal;
		V = vec3(modelViewMatrixInverse*vec4(0,0,0,1))-vertex;
		L = vec3(modelViewMatrixInverse*lightPosition)-vertex;
	}
	else {
		NN = N;
		V = -vec3(P);
		L = vec3(lightPosition - P);
	}
	fragColor = light(NN,V,L); 
}
