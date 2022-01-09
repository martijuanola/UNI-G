#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

out vec4 gfrontColor;
out vec2 textCoord;

uniform float side = 0.01;
uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform mat4 projectionMatrix;
uniform vec3 boundingBoxMax;
uniform vec3 boundingBoxMin;

void main( void )
{
	float side2 = side/2;
	vec3 c = (boundingBoxMax + boundingBoxMin)/2;
	
	gfrontColor = vec4(1,0,0,1);
	vec4 pos = modelViewMatrix*gl_in[0].gl_Position;
	textCoord = vec2(0.0,0.0);
	gl_Position = projectionMatrix*(pos + vec4(-side2,-side2,0,0));EmitVertex();
	textCoord = vec2(0.0,1.0);
	gl_Position = projectionMatrix*(pos + vec4(-side2,+side2,0,0));EmitVertex();
	textCoord = vec2(1.0,0.0);
	gl_Position = projectionMatrix*(pos + vec4(+side2,-side2,0,0));EmitVertex();
	textCoord = vec2(1.0,1.0);
	gl_Position = projectionMatrix*(pos + vec4(+side2,+side2,0,0));EmitVertex();
    EndPrimitive();

}
