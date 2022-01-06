#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec3 vsN[];
in vec4 vfrontColor[];

out vec3 gsN;

uniform float d = 1.0;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main( void )
{
	vec3 N = (vsN[0]+vsN[1]+vsN[2])/3;
	
	//part de dalt
	gsN = normalize(normalMatrix*N);
	for( int i = 0 ; i < 3 ; i++ )
	{
		gl_Position = modelViewProjectionMatrix*vec4(gl_in[i].gl_Position.xyz + d*N,1);
		EmitVertex();
	}
    EndPrimitive();
    
    //part de baix
	gsN = normalize(normalMatrix*-N);
	for( int i = 0 ; i < 3 ; i++ )
	{
		gl_Position = modelViewProjectionMatrix*vec4(gl_in[i].gl_Position.xyz,1);
		EmitVertex();
	}
    EndPrimitive();
    
    vec3 v1;
    vec3 v2;
   
    
	v1 = (gl_in[0].gl_Position.xyz +d*N) - gl_in[0].gl_Position.xyz;
	v2 = (gl_in[1].gl_Position.xyz) - gl_in[0].gl_Position.xyz;
    gsN = normalize(cross(v1,v2));
    gl_Position = modelViewProjectionMatrix*vec4(gl_in[0].gl_Position.xyz,1); EmitVertex();
    gl_Position = modelViewProjectionMatrix*vec4(gl_in[0].gl_Position.xyz +d*N,1); EmitVertex();
    gl_Position = modelViewProjectionMatrix*vec4(gl_in[1].gl_Position.xyz,1); EmitVertex();
    gl_Position = modelViewProjectionMatrix*vec4(gl_in[1].gl_Position.xyz +d*N,1); EmitVertex();
    EndPrimitive();
    
    v1 = (gl_in[1].gl_Position.xyz +d*N) - gl_in[1].gl_Position.xyz;
	v2 = (gl_in[2].gl_Position.xyz) - gl_in[1].gl_Position.xyz;
    gsN = normalize(cross(v1,v2));
    gl_Position = modelViewProjectionMatrix*vec4(gl_in[1].gl_Position.xyz,1); EmitVertex();
    gl_Position = modelViewProjectionMatrix*vec4(gl_in[1].gl_Position.xyz +d*N,1); EmitVertex();
    gl_Position = modelViewProjectionMatrix*vec4(gl_in[2].gl_Position.xyz,1); EmitVertex();
    gl_Position = modelViewProjectionMatrix*vec4(gl_in[2].gl_Position.xyz +d*N,1); EmitVertex();
    EndPrimitive();
    
    v1 = (gl_in[0].gl_Position.xyz +d*N) - gl_in[0].gl_Position.xyz;
	v2 = (gl_in[2].gl_Position.xyz) - gl_in[0].gl_Position.xyz;
    gsN = normalize(cross(v1,v2));
    gl_Position = modelViewProjectionMatrix*vec4(gl_in[0].gl_Position.xyz,1); EmitVertex();
    gl_Position = modelViewProjectionMatrix*vec4(gl_in[0].gl_Position.xyz +d*N,1); EmitVertex();
    gl_Position = modelViewProjectionMatrix*vec4(gl_in[2].gl_Position.xyz,1); EmitVertex();
    gl_Position = modelViewProjectionMatrix*vec4(gl_in[2].gl_Position.xyz +d*N,1); EmitVertex();
    EndPrimitive();
    
    
}
