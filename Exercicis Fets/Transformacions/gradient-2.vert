#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    vtexCoord = texCoord;  
    gl_Position = modelViewProjectionMatrix * vec4(vertex,  1.0);
    
	float escalar = gl_Position.y/gl_Position.w; //provar dividir per la z també
	frontColor = vec4(mix(vec3(float(escalar<0),float(escalar>-0.5),float(escalar>0.5)),vec3(float(escalar<-0.5),float(escalar<0.5),float(escalar>0)),fract(2*escalar+1)),1);
	//nose si està bé per escalar<-1 o escalar >1
	//es pot solucionar multipliant per 0 a traves de escalar per triar el cas que vols
	
	}
	
	/*
	 if(escalar >= 1) frontColor = vec4(0.0,0.0,1.0,1.0);
    else if(escalar >= 0.5) frontColor = vec4(mix(vec3(0.0,1.0,1.0),vec3(0.0,0.0,1.0),fract(2*escalar+1)),1);
    else if(escalar >= 0.0) frontColor = vec4(mix(vec3(0.0,1.0,0.0),vec3(0.0,1.0,1.0),fract(2*escalar+1)),1);
    else if(escalar >= -0.5) frontColor = vec4(mix(vec3(1.0,1.0,0.0),vec3(0.0,1.0,0.0),fract(2*escalar+1)),1);
	else if(escalar >= -1) frontColor = vec4(mix(vec3(1.0,0.0,0.0),vec3(1.0,1.0,0.0),fract(2*escalar+1)),1);
	else frontColor = vec4(1.0,0.0,0.0,1.0);
	*/
