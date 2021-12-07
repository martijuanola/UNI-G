#version 330 core

in vec2 vtexCoord;
in vec4 frontColor;
out vec4 fragColor;

uniform float slice = 0.1;
uniform float time;
uniform float frames = 4;

uniform sampler2D sampler0;
uniform sampler2D sampler1;
uniform sampler2D sampler2;
uniform sampler2D sampler3;

void main()
{
	int frame = int(mod(time/slice,frames));
    
    if(frame == 0) fragColor = texture(sampler0, vtexCoord);
    else if(frame == 1) fragColor = texture(sampler1, vtexCoord);
    else if(frame == 2) fragColor = texture(sampler2, vtexCoord);
    else if(frame == 3) fragColor = texture(sampler3, vtexCoord);
}
