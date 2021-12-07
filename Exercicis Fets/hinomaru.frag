#version 330 core

in vec2 vtexCoord;
in vec4 frontColor;
out vec4 fragColor;


void main()
{
    fragColor = vec4(1.0,1.0,1.0,1.0)*step(0.2, distance(vtexCoord,vec2(0.5,0.5))) + 
    vec4(1.0,0.0,0.0,1.0)*(1-step(0.2, distance(vtexCoord,vec2(0.5,0.5))));
}
