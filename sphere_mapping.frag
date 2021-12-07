#version 330 core

in vec3 v;
in vec3 n;
out vec4 fragColor;

uniform vec4 lightPosition;
uniform bool worldSpace;
uniform sampler2D text;
uniform mat4 viewMatrix;

vec4 sampleSphereMap(sampler2D sampler, vec3 R) {
	float z = sqrt((R.z+1.0)/2.0);
	vec2 st = vec2((R.x/(2.0*z)+1.0)/2.0, (R.y/(2.0*z)+1.0)/2.0);
	st.y = -st.y;
	return texture(sampler, st);
}


void main(){
	vec3 L = normalize(vec3(lightPosition)-v);
	if(worldSpace) L = normalize(vec3(viewMatrix*lightPosition)-v);
	vec3 R = reflect(L,n);
	fragColor = sampleSphereMap(text,R)	;
}
 
