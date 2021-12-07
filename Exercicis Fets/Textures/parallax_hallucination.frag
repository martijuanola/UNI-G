#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform float time;
uniform float a;
uniform sampler2D map;

uniform float pi = 3.1416;
 
void main() {
	float angle = 2*pi*time;
	
    vec4 c = texture(map,vtexCoord);
    float m = c.x;
    if(c.y > m) m = c.y;
    if(c.z > m) m = c.z;
   
    vec2 u = vec2(m,m);
    
    u = mat2(vec2(cos(angle),sin(angle)),vec2(-sin(angle),cos(angle))) * u;
	vec2 offset = vec2(a/100.0,a/100.0) * u;
	
	fragColor = texture(map,vtexCoord+offset);
}
