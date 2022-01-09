#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
in vec3 vnormal[];
out vec4 gfrontColor;

const float speed = 1.2;
const float angSpeed = 8.0;
uniform float time;
uniform mat4 modelViewProjectionMatrix;

void main( void ) {
	vec3 t = speed*time*(vnormal[0]+vnormal[1]+vnormal[2])/3; //son vectors!
	vec3 c = (gl_in[0].gl_Position.xyz + gl_in[1].gl_Position.xyz + gl_in[2].gl_Position.xyz)/3;
	mat3 r = mat3(vec3(cos(angSpeed*time),sin(angSpeed*time),0),vec3(-sin(angSpeed*time),cos(angSpeed*time),0),vec3(0,0,1));
	for(int i = 0 ; i < 3 ; i++) {
		gfrontColor = vfrontColor[i];
		vec3 vertex = gl_in[i].gl_Position.xyz-c;
		vertex = r*vertex;
		vertex = vertex +c +t;
		gl_Position = modelViewProjectionMatrix*vec4(vertex,1.0);
		EmitVertex();
	}
    EndPrimitive();
}    
  
