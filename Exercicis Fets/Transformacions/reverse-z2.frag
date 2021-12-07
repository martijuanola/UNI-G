#version 330 core

in vec4 frontColor;
in vec4 gl_FragCoord;
out vec4 fragColor;

void main()
{
    fragColor = abs(frontColor);
    gl_FragDepth = abs(gl_FragCoord.z-1.0);
}
 
