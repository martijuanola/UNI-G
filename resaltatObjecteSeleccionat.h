#ifndef _DRAWBOUNDINGBOX_H
#define _DRAWBOUNDINGBOX_H

#include "plugin.h" 

class DrawBoundingBox: public QObject, public Plugin
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
    
    GLuint VAOcub;
    GLuint VBOvertexs;
    GLuint VBOcolors;
    
};

#endif
