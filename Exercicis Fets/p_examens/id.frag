#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D colorMap;

float x(float i, float size , int n) {
	return mix(n*0.1,(n+1)*0.1,mod(vtexCoord.x,size)/size);
}

void main() {
	vec4 C;
    if(vtexCoord.x < 1.0/6.0) C = texture(colorMap,vec2(x(0,1/6.0,4),vtexCoord.y));
	else if(vtexCoord.x < 1.0/3.0) C = texture(colorMap,vec2(x(1/6.0,1/6.0,1),vtexCoord.y));
	else if(vtexCoord.x < 1.0/2.0) C = texture(colorMap,vec2(x(1/3.0,1/6.0,6),vtexCoord.y));
	else if(vtexCoord.x < 2.0/3.0) C = texture(colorMap,vec2(x(1/2.0,1/6.0,7),vtexCoord.y));
	else if(vtexCoord.x < 5.0/6.0) C = texture(colorMap,vec2(x(2/3.0,1/6.0,7),vtexCoord.y));
	else C = texture(colorMap,vec2(x(5/6.0,1/6.0,9),vtexCoord.y));

	if(C.a < 0.5) discard;
	else fragColor = vec4(0,0,1.0,1.0);
}
 
