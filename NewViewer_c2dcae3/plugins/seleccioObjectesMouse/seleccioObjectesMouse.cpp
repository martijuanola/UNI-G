#include "seleccioObjectesMouse.h"
#include "glwidget.h"

void SeleccioObjectesMouse::encodeID(int i, GLubyte* color) {
	color[0] = i;
	color[1] = i;
	color[2] = i;
}

void SeleccioObjectesMouse::onPluginLoad()
{
	QString vs_src = 
		"#version 330 core\n"
		"layout (location=0) in vec3 vertex;"
		"uniform mat4 modelViewProjectionMatrix;"
		"void main() {"
		"	gl_Position = modelViewProjectionMatrix * vec4(vertex,1.0);"
		"}";
	
	vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	vs->compileSourceCode(vs_src);
	cout << "VS log:" << vs->log().toStdString() << endl;
	
	QString fs_src = 
		"#version 330 core\n"
		"uniform vec4 color;"
		"out vec4 fragColor;"
		"void main() {"
		"   fragColor=color;"
		"}";
	fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	fs->compileSourceCode(fs_src);
	cout << "FS log:" << fs->log().toStdString() << endl;
	
	program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
    cout << "Link log:" << program->log().toStdString() << endl;
}

void SeleccioObjectesMouse::mouseReleaseEvent(QMouseEvent* e)
{
	GLWidget &g = *glwidget();
    g.makeCurrent();
    
	if (!(e->button() & Qt::RightButton)) return;
	if (e->modifiers() & (Qt::ShiftModifier)) return;
	if (!(e->modifiers() & Qt::ControlModifier)) return;
	
	g.glClearColor(1, 1, 1, 1);
    g.glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    
    program->bind();
    
    QMatrix4x4 MVP=camera()->projectionMatrix()*camera()->viewMatrix();
	program->setUniformValue("modelViewProjectionMatrix", MVP);
	
	for (unsigned int i=0; i<scene()->objects().size(); ++i) {
		GLubyte color[4];
		encodeID(i,color); // trieu la conversió que volgueu
		program->setUniformValue("color", QVector4D(color[0]/255.0,color[1]/255., color[2]/255., 1.0));
		drawPlugin()->drawObject(i);
	}
	
	int x = e->x();
	int y = glwidget()->height() - e->y();
	GLubyte read[4];
	glReadPixels(x, y, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, read);
	
	int seleccionat = read[0]; 
	
	cout << seleccionat << endl;
	if(seleccionat < (int)scene()->objects().size()) {
		cout << "Objecte " << seleccionat << " seleccionat!" << endl;
	}
	else cout << "Cap objecte seleccionat" << endl;
	program->release();	
}

