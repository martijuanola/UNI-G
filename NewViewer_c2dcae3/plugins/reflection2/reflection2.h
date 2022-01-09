#ifndef _REFLECTION2_H
#define _REFLECTION2_H

#include "plugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>  

class Reflection2 : public QObject, public Plugin
{
     Q_OBJECT
     Q_PLUGIN_METADATA(IID "Plugin")   
     Q_INTERFACES(Plugin)

 public:
    void onPluginLoad();
    bool paintGL();
 
 private:
    QOpenGLShaderProgram* program;
    QOpenGLShader* vs;
    QOpenGLShader* fs;  
    GLuint textureId1;
    GLuint textureId2;
    GLuint textureId3;
 };
 
 #endif

