#version 330 core

in vec3 N;
in vec4 P;

in vec4 frontColor;
out vec4 fragColor;

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
	R = normalize(2*NL*N-L); // important normalitzar R
	RVs = 0;
	if(NL >= 0) RVs = pow(max(0.0,dot(R,V)), matShininess);
	
	
	A = lightAmbient * matAmbient;
	D = lightDiffuse * matDiffuse * NL;
	S = lightSpecular * matSpecular * RVs;

	return A + D + S;
}

void main() {
   fragColor = Phong(N,P);
}
