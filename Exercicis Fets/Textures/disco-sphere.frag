#version 330 core

in vec4 veye;
out vec4 fragColor;

uniform sampler2D sampler;

void main()
{
	vec3 N = normalize(cross(dFdx(veye.xyz), dFdy(veye.xyz)));
    fragColor = texture(sampler,vec2(N.x,N.y)) * N.z;
}
