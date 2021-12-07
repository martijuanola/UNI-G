#version 330 core

in vec3 P;
in vec3 N;
out vec4 fragColor;

// V, N, P, lightPos han d'estar al mateix espai de coordenades
// V Ès el vector unitari cap a l'observador
// N Ès la normal
// P Ès la posiciÛ 
// lightPos Ès la posiciÛ de la llum
// lightColor Ès el color de la llum
vec4 light(vec3 V, vec3 N, vec3 P, vec3 lightPos, vec3 lightColor)
{
	const float shininess = 100.0;
	const float Kd = 0.5;
	N = normalize(N);
	vec3 L = normalize(lightPos - P);
	vec3 R = reflect(-L, N);
	float NdotL = max(0.0, dot(N,L));
	float RdotV = max(0.0, dot(R,V));
	float spec =  pow( RdotV, shininess);
	return vec4(Kd*lightColor*NdotL + vec3(spec),0);
}

uniform bool rotate = true;

uniform vec3 verd = vec3(0.0,1.0,0.0);
uniform vec3 groc = vec3(1.0,1.0,0.0);
uniform vec3 blau = vec3(0.0,0.0,1.0);
uniform vec3 vermell = vec3(1.0,0.0,0.0);

uniform vec3 posVerd = vec3(0,10,0); // en eye space
uniform vec3 posGroc = vec3(0,-10,0);
uniform vec3 posBlau = vec3(10,0,0);
uniform vec3 posVermell = vec3(-10,0,0);

uniform mat4 modelViewMatrixInverse;

uniform float time;

void main() {
	
	//pel rotate
	float angle = 0;
	if(rotate) angle = time;
	mat3 r = mat3(vec3(cos(angle),sin(angle),0),vec3(-sin(angle),cos(angle),0),vec3(0,0,1));
	
	//posicions de llum 
	vec3 p1 = vec3(modelViewMatrixInverse * vec4(r * posVerd,1.0)).xyz;
	vec3 p2 = vec3(modelViewMatrixInverse * vec4(r * posGroc,1.0)).xyz;
	vec3 p3 = vec3(modelViewMatrixInverse * vec4(r * posBlau,1.0)).xyz;
	vec3 p4 = vec3(modelViewMatrixInverse * vec4(r * posVermell,1.0)).xyz;
	
	//V
	vec3 V = normalize(modelViewMatrixInverse[3].xyz - P);
	
    fragColor = light(V,N,P,p1,verd) + light(V,N,P,p2,groc) + light(V,N,P,p3,blau) + light(V,N,P,p4,vermell);
}
