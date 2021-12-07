#version 330 core

in vec3 N;
in vec3 P;
out vec4 fragColor;

uniform vec4 lightDiffuse;
uniform vec4 lightSpecular;
uniform vec4 matDiffuse;
uniform vec4 matSpecular;
uniform float matShininess;

vec4 light(vec3 N, vec3 V, vec3 L) {
	L=normalize(L);
	vec3 R = normalize( 2.0*dot(N,L)*N-L );
	float NdotL = max( 0.0, dot( N,L ) );
	float RdotV = max( 0.0, dot( R,V ) );
	float Idiff = NdotL;
	float Ispec = 0;
	if (NdotL>0) Ispec=pow( RdotV, matShininess );
	return
	(matDiffuse * lightDiffuse * Idiff)/2 +
	matSpecular * lightSpecular * Ispec;
}
uniform mat4 modelMatrix;
uniform mat4 modelViewMatrixInverse;
uniform vec3 boundingBoxMin; //cantonada de la capsa englobant
uniform vec3 boundingBoxMax; //cantonada de la capsa englobant

void main() {
    vec4 c = vec4(0,0,0,0);
    vec3 pos = vec3(modelMatrix * vec4(P,1.0));
    vec3 V = normalize(modelViewMatrixInverse[3].xyz - P);
    vec3 lp1 = vec3(boundingBoxMin.x,boundingBoxMin.y,boundingBoxMin.z);
	vec3 lp2 = vec3(boundingBoxMin.x,boundingBoxMin.y,boundingBoxMax.z);
	vec3 lp3 = vec3(boundingBoxMin.x,boundingBoxMax.y,boundingBoxMin.z);
	vec3 lp4 = vec3(boundingBoxMin.x,boundingBoxMax.y,boundingBoxMax.z);
	vec3 lp5 = vec3(boundingBoxMax.x,boundingBoxMin.y,boundingBoxMin.z);
	vec3 lp6 = vec3(boundingBoxMax.x,boundingBoxMin.y,boundingBoxMax.z);
	vec3 lp7 = vec3(boundingBoxMax.x,boundingBoxMax.y,boundingBoxMin.z);
	vec3 lp8 = vec3(boundingBoxMax.x,boundingBoxMax.y,boundingBoxMax.z);
    c += light(N,V,lp1-pos);
    c += light(N,V,lp2-pos);
    c += light(N,V,lp3-pos);
    c += light(N,V,lp4-pos);
    c += light(N,V,lp5-pos); 
    c += light(N,V,lp6-pos);
    c += light(N,V,lp7-pos);
    c += light(N,V,lp8-pos);
    
    fragColor = c;
}
