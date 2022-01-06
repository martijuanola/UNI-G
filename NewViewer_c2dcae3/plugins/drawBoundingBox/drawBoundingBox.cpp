#include "drawBoundingBox.h"
#include "glwidget.h"

void DrawBoundingBox::onPluginLoad()
{
	QString vs_src = 
		"#version 330 core\n"

		"layout (location=0) in vec3 vertex;"
		"layout (location=2) in vec3 color;"

		"out vec4 FrontColor;"

		"uniform mat4 modelViewProjectionMatrix;"
		"uniform vec3 boundingBoxMin;"
		"uniform vec3 boundingBoxMax;"

		"void main() {"
		"	FrontColor = vec4(color,1.0);"
		"	mat3 S = mat3(vec3(boundingBoxMax.x-boundingBoxMin.x,0,0),vec3(0,boundingBoxMax.y-boundingBoxMin.y,0),vec3(0,0,boundingBoxMax.z-boundingBoxMin.z));"
		"	vec3 C = (boundingBoxMax + boundingBoxMin)/2;"
		"	gl_Position = modelViewProjectionMatrix * vec4(C + S*(vertex-vec3(0.5)),1.0);"
		"}";
	
	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceCode(vs_src);
	cout << "VS log:" << vs->log().toStdString() << endl;
	
	QString fs_src = 
		"#version 330 core\n"
		"in vec4 FrontColor;"
		"out vec4 fragColor;"
		"void main() {"
		"   fragColor=FrontColor;"
		"}";
	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceCode(fs_src);
	cout << "FS log:" << fs->log().toStdString() << endl;
	
	
	program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
    cout << "Link log:" << program->log().toStdString() << endl;
    
    crearBuffers();
}

void DrawBoundingBox::crearBuffers() {
	GLfloat vertexs[]={
                0,0,0,
                0,0,1,
                0,1,0,
                
                0,0,1,
                0,1,0,
                0,1,1,
                
                1,0,0,
                1,0,1,
                1,1,0,
                
                1,0,1,
                1,1,0,
                1,1,1,
                
                0,0,0,
                0,0,1,
                1,0,0,
                
                0,0,1,
                1,0,0,
                1,0,1,
                
                0,1,0,
                0,1,1,
                1,1,0,
                
                0,1,1,
                1,1,0,
                1,1,1,
                
                0,0,0,
                0,1,0,
                1,0,0,
                
                0,1,0,
                1,0,0,
                1,1,0,
                
                0,0,1,
                0,1,1,
                1,0,1,
                
                0,1,1,
                1,0,1,
                1,1,1
            };
    GLfloat colors[]={
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0,
                1,0,0
            };

	GLWidget& g = *glwidget();
    g.makeCurrent();
        
	g.glGenVertexArrays(1, &VAOcub);//now VAO
	g.glBindVertexArray(VAOcub);//treballar sobre nou VAO
	
	g.glGenBuffers(1,&VBOvertexs); //nou VBO(arestes)
	g.glBindBuffer(GL_ARRAY_BUFFER, VBOvertexs);
	g.glBufferData(GL_ARRAY_BUFFER,sizeof(vertexs), &vertexs[0], GL_STATIC_DRAW);
	g.glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0);
    g.glEnableVertexAttribArray(0);
    
    g.glGenBuffers(1,&VBOcolors); //nou VBO(colors)
	g.glBindBuffer(GL_ARRAY_BUFFER, VBOcolors);
	g.glBufferData(GL_ARRAY_BUFFER,sizeof(colors), &colors[0], GL_STATIC_DRAW);
	g.glVertexAttribPointer(2, 3, GL_FLOAT, GL_FALSE, 0, 0);
    g.glEnableVertexAttribArray(0);
            
	g.glBindVertexArray(0);
}


void DrawBoundingBox::postFrame()
{
	GLWidget& g = *glwidget();
    g.makeCurrent();
    
	program->bind();
	GLint PM;
	g.glGetIntegerv(GL_POLYGON_MODE,&PM);
	g.glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	g.glBindVertexArray(VAOcub);
	//draw shit
	Scene* scn=scene();
    const vector<Object> &obj=scn->objects();
    for(int i = 0; i < (int)obj.size(); i++) {
		//uniforms
		QMatrix4x4 MVP=camera()->projectionMatrix()*camera()->viewMatrix();
		program->setUniformValue("modelViewProjectionMatrix", MVP);
		program->setUniformValue("boundingBoxMin",obj[i].boundingBox().min());
		program->setUniformValue("boundingBoxMax",obj[i].boundingBox().max());
		
		//draw
		g.glDrawArrays(GL_TRIANGLES, 0, 36);
	}
	g.glBindVertexArray(0);
	g.glPolygonMode(GL_FRONT_AND_BACK, PM);
    program->release();
}
