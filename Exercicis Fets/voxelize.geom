#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float step = 0.1;

const vec4 grey = vec4(0.8,0.8,0.8,1);

void main( void )
{
	float step2 = step/2;
	vec3 c = (gl_in[0].gl_Position.xyz+gl_in[1].gl_Position.xyz+gl_in[2].gl_Position.xyz)/3;
	c.x = int(c.x/step)*step;
	c.y = int(c.y/step)*step;
	c.z = int(c.z/step)*step;
	
	//bottom
	gfrontColor = grey * (normalMatrix * vec3(0,-1,0)).z;
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y-step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y-step2,c.z+step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y-step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y-step2,c.z+step2,1);EmitVertex();
	EndPrimitive();
	
	//top
	gfrontColor = grey * (normalMatrix * vec3(0,1,0)).z;
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y+step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y+step2,c.z+step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y+step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y+step2,c.z+step2,1);EmitVertex();
	EndPrimitive();
	
	//x fixed1
	gfrontColor = grey * (normalMatrix * vec3(-1,0,0)).z;
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y-step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y-step2,c.z+step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y+step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y+step2,c.z+step2,1);EmitVertex();
	EndPrimitive();
	
	//x fixed2
	gfrontColor = grey * (normalMatrix * vec3(1,0,0)).z;
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y-step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y-step2,c.z+step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y+step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y+step2,c.z+step2,1);EmitVertex();
	EndPrimitive();
	
	//z fixed1
	gfrontColor = grey * (normalMatrix * vec3(0,0,-1)).z;
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y-step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y+step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y-step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y+step2,c.z-step2,1);EmitVertex();
	EndPrimitive();
	
	//z fixed2
	gfrontColor = grey * (normalMatrix * vec3(0,0,1)).z;
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y-step2,c.z+step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y+step2,c.z+step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y-step2,c.z+step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y+step2,c.z+step2,1);EmitVertex();
	EndPrimitive();
}
