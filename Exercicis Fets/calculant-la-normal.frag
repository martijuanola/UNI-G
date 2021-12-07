#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec3 p;

void main()
{
	vec3 N = normalize(cross(dFdx(p), dFdy(p)));
    fragColor = frontColor * N.z;
}
