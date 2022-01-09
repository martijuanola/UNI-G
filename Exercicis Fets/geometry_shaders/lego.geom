#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;
out float top;
out vec2 gtexCoord;
out vec3 n;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float step = 200;

const vec4 grey = vec4(0.8,0.8,0.8,1);

void main( void )
{
	top = 0.0;
	float step2 = step/2;
	vec3 c = (gl_in[0].gl_Position.xyz+gl_in[1].gl_Position.xyz+gl_in[2].gl_Position.xyz)/3;
	c.x = int(c.x/step)*step;
	c.y = int(c.y/step)*step;
	c.z = int(c.z/step)*step;
	
	gfrontColor = (vfrontColor[0]+vfrontColor[1]+vfrontColor[2])/3;
	
	//bottom
	n = normalize(normalMatrix*vec3(0, -1, 0));
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y-step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y-step2,c.z+step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y-step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y-step2,c.z+step2,1);EmitVertex();
	EndPrimitive();
	
	//top
	top = 1.0;
	n = normalize(normalMatrix*vec3(0, 1, 0));
	gtexCoord = vec2(0,0);
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y+step2,c.z-step2,1);EmitVertex();
	gtexCoord = vec2(0,1);
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y+step2,c.z+step2,1);EmitVertex();
	gtexCoord = vec2(1,0);
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y+step2,c.z-step2,1);EmitVertex();
	gtexCoord = vec2(1,1);
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y+step2,c.z+step2,1);EmitVertex();
	EndPrimitive();
	top = 0.0;
	
	n = normalize(normalMatrix*vec3(-1, 0, 0));
	//x fixed1
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y-step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y-step2,c.z+step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y+step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y+step2,c.z+step2,1);EmitVertex();
	EndPrimitive();
	
	//x fixed2
	n = normalize(normalMatrix*vec3(1, 0, 0));
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y-step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y-step2,c.z+step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y+step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y+step2,c.z+step2,1);EmitVertex();
	EndPrimitive();
	
	//z fixed1
	n = normalize(normalMatrix*vec3(0, 0, -1));
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y-step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y+step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y-step2,c.z-step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y+step2,c.z-step2,1);EmitVertex();
	EndPrimitive();
	
	//z fixed2
	n = normalize(normalMatrix*vec3(0, 0, 1));
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y-step2,c.z+step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x-step2,c.y+step2,c.z+step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y-step2,c.z+step2,1);EmitVertex();
	gl_Position = modelViewProjectionMatrix*vec4(c.x+step2,c.y+step2,c.z+step2,1);EmitVertex();
	EndPrimitive();
}
