#version 330 core
out vec4 fragColor;

uniform sampler2D colorMap;
uniform float SIZE;

const float A = 0.01;

in vec3 N;

void main()
{
    vec2 st = (gl_FragCoord.xy - vec2(0.5)) / SIZE;
    vec4 textColor = texture2D(colorMap, st)*0.8;
    fragColor = textColor; 
}

