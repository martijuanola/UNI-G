#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D fbm;
uniform float time;
const float pi = 3.14159;

uniform vec4 vermell = vec4(1.0,0,0,1);
uniform vec4 groc = vec4(1.0,1.0,0,1);
uniform vec4 verd = vec4(0,1.0,0,1);
uniform vec4 cian = vec4(0,1.0,1.0,1);
uniform vec4 blau = vec4(0,0,1.0,1);
uniform vec4 magenta = vec4(1.0,0,1.0,1);

void main() {
    
    float r = texture(fbm,vtexCoord).r;
    float A = 1;
    float f = 0.1;
    float angle = r;
    float v = A*sin(2*pi*(time*f+angle));
    if(v < -1+2/6.0) fragColor = mix(vermell,groc,mod(v+1,2/6.0)/(2/6.0));
    else if(v < -1+2*2/6.0) fragColor = mix(groc,verd,mod(v+1,2/6.0)/(2/6.0));
    else if(v < -1+3*2/6.0) fragColor = mix(verd,cian,mod(v+1,2/6.0)/(2/6.0));
    else if(v < -1+4*2/6.0) fragColor = mix(cian,blau,mod(v+1,2/6.0)/(2/6.0));
    else if(v < -1+5*2/6.0) fragColor = mix(blau,magenta,mod(v+1,2/6.0)/(2/6.0));
    else fragColor = mix(magenta,vermell,mod(v+1,2/6.0)/(2/6.0));
}
