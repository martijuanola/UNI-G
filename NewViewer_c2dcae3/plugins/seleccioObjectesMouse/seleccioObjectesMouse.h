#ifndef _SELECCIOOBJECTESMOUSE_H
#define _SELECCIOOBJECTESMOUSE_H

#include "plugin.h" 

class SeleccioObjectesMouse: public QObject, public Plugin
{
	Q_OBJECT
	Q_PLUGIN_METADATA(IID "Plugin") 
	Q_INTERFACES(Plugin)

  public:
	 void onPluginLoad();

	 void mouseReleaseEvent(QMouseEvent *);
	 
  private:
	QOpenGLShaderProgram* program;
    QOpenGLShader *fs, *vs;
    
    void encodeID(int,GLubyte *);
    int decodeID(GLubyte *);
};

#endif
