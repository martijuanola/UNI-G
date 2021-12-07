#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform int textureSize;
uniform int edgeSize;
uniform float threshold;

uniform sampler2D text;

void main() {
	
	vec4 left = texture(text,vtexCoord+edgeSize*vec2(-1,0)/textureSize);
	vec4 right = texture(text,vtexCoord+edgeSize*vec2(1,0)/textureSize);
	vec4 bottom = texture(text,vtexCoord+edgeSize*vec2(0,-1)/textureSize);
	vec4 top = texture(text,vtexCoord+edgeSize*vec2(0,1)/textureSize);
	
	vec2 G = vec2(length(right-left),length(top-bottom));
	
    if(length(G) > threshold) fragColor = vec4(0.0,0.0,0.0,1.0);
    else fragColor = texture(text,vtexCoord);
}
