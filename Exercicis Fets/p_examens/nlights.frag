#version 330 core

in vec3 P;
in vec3 N;
out vec4 fragColor;

uniform mat4 modelViewMatrixInverse;
uniform int n = 4;
const float pi = 3.141592;

uniform vec4 lightDiffuse;
uniform vec4 lightSpecular;
uniform vec4 matDiffuse;
uniform vec4 matSpecular;
uniform float matShininess;

uniform mat4 modelViewMatrix;

vec4 light(vec3 N, vec3 V, vec3 L) {
	L=normalize(L);
	vec3 R = normalize( 2.0*dot(N,L)*N-L );
	float NdotL = max( 0.0, dot( N,L ) );
	float RdotV = max( 0.0, dot( R,V ) );
	float Idiff = NdotL;
	float Ispec = 0;
	if (NdotL>0) Ispec=pow( RdotV, matShininess );
	return
	(matDiffuse * lightDiffuse * Idiff)/sqrt(n) +
	matSpecular * lightSpecular * Ispec;
}

void main() {
	vec4 c = vec4(0,0,0,0);
	
	vec3 pos = vec3(modelViewMatrix * vec4(P,1.0));
	//v
	vec3 V = -normalize(pos).xyz;
	
	//light color
	vec3 lc = vec3(1.0,1.0,1.0);
	
    for(int i = 0; i < n; i++) {
		//light position
		float angle = i*2*pi/n;
		mat3 r = mat3(vec3(cos(angle),sin(angle),0),vec3(-sin(angle),cos(angle),0),vec3(0,0,1));
		vec3 lp = r * vec3(10,0,0);
		c += light(N,V,lp-pos);
	}
    
    fragColor = c;
}
