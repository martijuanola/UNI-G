#include "animateVertices.h"
#include "glwidget.h"

void AnimateVertices::onPluginLoad()
{
	QString vs_src = 
		"#version 330 core\n"
		"layout (location = 0) in vec3 vertex;"
		"layout (location = 1) in vec3 normal;"
		"layout (location = 2) in vec3 color;"
		"out vec4 frontColor;"
		"uniform mat4 modelViewProjectionMatrix;"
		"uniform mat3 normalMatrix;"
		"uniform float amplitude = 0.1;"
		"uniform float freq = 1;" 
		"uniform float time;"
		"void main() {"
		"	vec3 N = normalize(normalMatrix * normal);"
		"	frontColor = vec4(1.0,1.0,1.0,1.0) * N.z;"
		"	gl_Position = modelViewProjectionMatrix * vec4(vertex+normal*amplitude*sin(2*3.1415926*freq*time), 1.0);"
		"}";
	
	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceCode(vs_src);
	cout << "VS log:" << vs->log().toStdString() << endl;
	
	QString fs_src = 
		"#version 330 core\n"
		"in vec4 frontColor;"
		"out vec4 fragColor;"
		"void main() {"
		"	fragColor = frontColor;"
		"}";
	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceCode(fs_src);
	cout << "FS log:" << fs->log().toStdString() << endl;
	
	program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
    cout << "Link log:" << program->log().toStdString() << endl;
    elapsedTimer.start();
}

void AnimateVertices::preFrame()
{
	program->bind();
    program->setUniformValue("n", 10);
    program->setUniformValue("time", float(elapsedTimer.elapsed()/1000.0f));
    QMatrix4x4 MVP = camera()->projectionMatrix() * camera()->viewMatrix();
    program->setUniformValue("modelViewProjectionMatrix", MVP); 
    QMatrix3x3 NM = camera()->viewMatrix().normalMatrix();
    program->setUniformValue("normalMatrix", NM); 
}

void AnimateVertices::postFrame()
{
	program->release();	
}
