#version 330 core

in vec3 v;
out vec4 fragColor;

uniform vec3 origin = vec3(0,0,0);
uniform vec3 axis = vec3(0,0,1);
uniform float slice = 0.05;

float modul(vec3 A) {
	return sqrt(A.x*A.x+A.y*A.y+A.z+A.z);
}

float distance3D(vec3 A, vec3 B, vec3 C) {
	return modul(cross(A-B,C-B))/modul((C-B));
}

void main() {
    float d = distance(v,origin + axis*dot(v,axis));//distance3D(v,origin,axis+origin);
    if(mod(d,2*slice) < slice) fragColor = vec4(0.0,1.0,1.0,1.0);
    else fragColor = vec4(0.0,0.0,1.0,1.0);
}
