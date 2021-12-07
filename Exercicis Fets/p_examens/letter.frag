#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

void main() {
	int segX = 5, segY = 7;
	float x = vtexCoord.x, y = vtexCoord.y;
	float radi = 0.05;
	bool color = false, lletra = false;
	
	float mx = mod(x,1.0/segX);
	float my = mod(y,1.0/segY);
	vec2 c = vec2(1.0/(segX*2),1.0/(segY*2));
	
	if(x < 1.0/segX || x > 1-(1.0/segX)) lletra = true;
	else if(y > 1-(2*1.0/segY) && y < 1-(1*1.0/segY)) lletra = true;
	else if(x < 1-(2*1.0/segX) && x > 1-(3*1.0/segX) && y > 1-(4*1.0/segY) && y < 1-(1*1.0/segY)) lletra = true;
	
	if(distance(c,vec2(mx,my)) < radi && lletra) fragColor = vec4(0.5,1.0,0.5,1.0);
	else discard;
}
