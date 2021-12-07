#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform float time;
uniform sampler2D digits;

void main() {
	int n3 = int(time/100)%10;
	int n2 = int(time/10)%10;
	int n1 = int(time)%10;
    
    vec2 offset;
    if(vtexCoord.x < 1) offset = vec2(mix(n3/10.0,(n3+1)/10.0,mod(vtexCoord.x,1.0)),vtexCoord.y);
    else if(vtexCoord.x < 2) offset = vec2(mix(n2/10.0,(n2+1)/10.0,mod(vtexCoord.x,1.0)),vtexCoord.y);
    else offset = vec2(mix(n1/10.0,(n1+1)/10.0,mod(vtexCoord.x,1.0)),vtexCoord.y);
    
    
    vec4 c = texture(digits,offset);
    
    if(c.a < 0.5) discard;
    else fragColor = vec4(1.0,0.0,0.0,1.0);
}
