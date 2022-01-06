#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;
uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewProjectionMatrixInverse;

const vec4 black = vec4(0,0,0,1);
const vec4 cian = vec4(0,1,1,1);

float d = 0.01;

void main( void )
{
	if(gl_PrimitiveIDIn == 0) {	
		float R = length(boundingBoxMax-boundingBoxMin)/2;
		vec3 C = (boundingBoxMax + boundingBoxMin)/2;
		
		gl_Position = modelViewProjectionMatrix*vec4(C.x-R,boundingBoxMin.y-d,C.z-R,1); gfrontColor = cian; EmitVertex();
		gl_Position = modelViewProjectionMatrix*vec4(C.x-R,boundingBoxMin.y-d,C.z+R,1); gfrontColor = cian; EmitVertex();
		gl_Position = modelViewProjectionMatrix*vec4(C.x+R,boundingBoxMin.y-d,C.z+R,1); gfrontColor = cian; EmitVertex();
		EndPrimitive();
		gl_Position = modelViewProjectionMatrix*vec4(C.x-R,boundingBoxMin.y-d,C.z-R,1); gfrontColor = cian; EmitVertex();
		gl_Position = modelViewProjectionMatrix*vec4(C.x+R,boundingBoxMin.y-d,C.z+R,1); gfrontColor = cian; EmitVertex();
		gl_Position = modelViewProjectionMatrix*vec4(C.x+R,boundingBoxMin.y-d,C.z-R,1); gfrontColor = cian; EmitVertex();
		EndPrimitive();
	}
	
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();
    
    for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = black;
		vec4 aux = modelViewProjectionMatrixInverse * gl_in[i].gl_Position;
		aux.y = boundingBoxMin.y;
		gl_Position = modelViewProjectionMatrix * aux;
		EmitVertex();
	}
    EndPrimitive();
}
