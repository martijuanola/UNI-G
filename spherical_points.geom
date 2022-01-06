#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

out vec4 gfrontColor;

uniform float side = 1.0;
uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform mat4 ProjectionMatrix;
uniform vec3 boundingBoxMax;
uniform vec3 boundingBoxMin;

void main( void )
{
	float side2 = side/2;
	vec3 c = (boundingBoxMax + boundingBoxMin)/2;
	
	gfrontColor = vec4(1,0,0,1);
	vec4 pos = modelViewMatrix*gl_in[0].gl_Position;
	gl_Position = ProjectionMatrix*(pos + vec4(-side2,-side2,0,0));EmitVertex();
	gl_Position = ProjectionMatrix*(pos + vec4(-side2,+side2,0,0));EmitVertex();
	gl_Position = ProjectionMatrix*(pos + vec4(+side2,-side2,0,0));EmitVertex();
	gl_Position = ProjectionMatrix*(pos + vec4(+side2,+side2,0,0));EmitVertex();
    EndPrimitive();
    
    /*for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vec4(0,1,0,1);
		gl_Position = modelViewProjectionMatrix*gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();*/
}
