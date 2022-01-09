#version 330 core
out vec4 fragColor;

uniform sampler2D colorMap;
uniform float time;
uniform float SIZE;

const float A = 0.01;

void main()
{
    vec2 st = (gl_FragCoord.xy - vec2(0.5)) / SIZE;
    st += A*sin(10.0*time+30.0*st.x);    
    fragColor = texture2D(colorMap, st); 
}

