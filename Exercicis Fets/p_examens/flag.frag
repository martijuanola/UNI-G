#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

void main() {
	bool white = false;
    
    float x = vtexCoord.x;
    float y = vtexCoord.y;
    
    if(x > 0.5 && x < 0.5+1/3.0 && y > 0.25 && y < 0.75) white = true;
    
    vec2 P1 = vec2(0.5,0.5);
    vec2 P2 = vec2(0.4,0.5);
    
    if(distance(vtexCoord,P1) > 0.35 && distance(vtexCoord,P2) < 0.35) white = true;
    
     
    
    if(white) fragColor = vec4(1.0,1.0,1.0,1.0);
    else fragColor = vec4(0.5,0.7,0.5,1.0);
}
