#version 330 core

in vec3 gsN;
out vec4 fragColor;

void main()
{
    fragColor = vec4(gsN.z,gsN.z,gsN.z,1);
}
