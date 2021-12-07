#version 330 core

in vec3 N;
in vec3 vo;
out vec4 fragColor;

uniform sampler2D noise;
uniform mat4 modelViewMatrix;

vec4 shading(vec3 N, vec3 Pos, vec4 diffuse) {
	vec3 lightPos = vec3(0.0,0.0,2.0);
	vec3 L = normalize( lightPos - Pos );
	vec3 V = normalize( -Pos);
	vec3 R = reflect(-L,N);
	float NdotL = max( 0.0, dot( N,L ) );
	float RdotV = max( 0.0, dot( R,V ) );
	float Ispec = pow( RdotV, 20.0 );
	return diffuse * NdotL + Ispec;
}

void main() {
    vec4 s = 0.3 * vec4(0, 1, -1, 0);
    vec4 t = 0.3 * vec4(-2, -1, 1, 0);
    
    vec2 vtex = vec2(dot(s,vec4(vo,1.0)),dot(t,vec4(vo,1.0)));
    float v = texture(noise,vtex).x;
    if(v > 0.5) v = 1-v;
    vec4 c = mix(vec4(1.0,1.0,1.0,1.0),vec4(0.5,0.2,0.2,1.0),v*2);
    fragColor = shading(N,vec3(modelViewMatrix * vec4(vo,1.0)).xyz,c);
}
