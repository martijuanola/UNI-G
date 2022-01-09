#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;
out vec2 tc;

uniform vec4 lightPosition;
uniform float w = 0.3;
uniform mat4 projectionMatrix;

void main( void )
{
	for( int i = 0 ; i < 3 ; i++ )
	{
		tc = vec2(-1.0,-1.0);
		gfrontColor = vfrontColor[i];
		gl_Position = gl_in[i].gl_Position;
		EmitVertex();
	}
    EndPrimitive();
    
    if(gl_PrimitiveIDIn == 0) {
		tc= vec2(0.0,0.0);
		gl_Position = projectionMatrix*( lightPosition + vec4(-w,-w,0,0)); EmitVertex();
		tc = vec2(0.0,1.0);
		gl_Position = projectionMatrix*( lightPosition + vec4(-w,w,0,0)); EmitVertex();
		tc = vec2(1.0,0.0);
		gl_Position = projectionMatrix*( lightPosition + vec4(w,-w,0,0)); EmitVertex();
		tc = vec2(1.0,1.0);
		gl_Position = projectionMatrix*( lightPosition + vec4(w,w,0,0)); EmitVertex();
		EndPrimitive();
	}
}
