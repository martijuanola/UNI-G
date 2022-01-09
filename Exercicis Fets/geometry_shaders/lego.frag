#version 330 core

in vec2 gtexCoord;
in vec3 n;
in vec4 gfrontColor;
in float top;
out vec4 fragColor;

uniform sampler2D sampler0;

const vec4 R = vec4(1,0,0,1);
const vec4 G = vec4(0,1,0,1);
const vec4 B = vec4(0,0,1,1);
const vec4 C = vec4(0,1,1,1);
const vec4 Y = vec4(1,1,0,1);

void main()
{
	vec4 col;
    //fragColor = gfrontColor;
    float distR = distance(gfrontColor,R);
    float distG = distance(gfrontColor,G);
    float distB = distance(gfrontColor,B);
    float distC = distance(gfrontColor,C);
    float distY = distance(gfrontColor,Y);
    float min = min(distR,min(distG,min(distB,min(distC,distY))));
    if(distR == min) col = R;
    else if(distG == min) col = G;
    else if(distB == min) col = B;
    else if(distC == min) col = C;
    else if(distY == min) col = Y;
    
    
    if(top == 1.0) fragColor = col*texture2D(sampler0,gtexCoord)*n.z;
    else if(top == 0.0) fragColor = col*n.z;
}
