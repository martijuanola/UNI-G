#ifndef _SELECCIOOBJECTESTECLAT_H
#define _SELECCIOOBJECTESTECLAT_H

#include "plugin.h" 

class SeleccioObjectesTeclat: public QObject, public Plugin
{
	Q_OBJECT
	Q_PLUGIN_METADATA(IID "Plugin") 
	Q_INTERFACES(Plugin)

  public:
	 void onPluginLoad();
	 void postFrame();
	 
  private:
	QOpenGLShaderProgram* program;
    QOpenGLShader *fs, *vs;
    
    void crearBuffers();
    void keyPressEvent(QKeyEvent* e); 
    
    GLuint VAOcub;
    GLuint VBOvertexs;
    GLuint VBOcolors;
};

#endif
