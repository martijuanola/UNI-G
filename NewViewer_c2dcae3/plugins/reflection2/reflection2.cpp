#include "reflection2.h"
#include <QCoreApplication>

const int IMAGE_WIDTH = 512;
const int IMAGE_HEIGHT = IMAGE_WIDTH;

void Reflection2::onPluginLoad()
{
    GLWidget & g = *glwidget();
    g.makeCurrent();
    // Carregar shader, compile & link 
    vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
    vs->compileSourceFile(g.getPluginPath()+"/../reflection2/reflection2.vert");

    fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
    fs->compileSourceFile(g.getPluginPath()+"/../reflection2/reflection2.frag");

    program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();

    // Setup texture
    g.glActiveTexture(GL_TEXTURE0);
    g.glGenTextures( 1, &textureId1);
    
    //g.glActiveTexture(GL_TEXTURE1);
    g.glGenTextures( 1, &textureId2);
    
    //g.glActiveTexture(GL_TEXTURE2);
    g.glGenTextures( 1, &textureId3);
    
    //t1
    g.glBindTexture(GL_TEXTURE_2D, textureId1);
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,
		      GL_LINEAR_MIPMAP_LINEAR );
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    g.glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, IMAGE_WIDTH, IMAGE_HEIGHT,
		   0, GL_RGB, GL_FLOAT, NULL);
		   
	//t2
    g.glBindTexture(GL_TEXTURE_2D, textureId2);
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,
		      GL_LINEAR_MIPMAP_LINEAR );
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    g.glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, IMAGE_WIDTH, IMAGE_HEIGHT,
		   0, GL_RGB, GL_FLOAT, NULL);
		   
	//t3
    g.glBindTexture(GL_TEXTURE_2D, textureId3);
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,
		      GL_LINEAR_MIPMAP_LINEAR );
    g.glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    g.glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, IMAGE_WIDTH, IMAGE_HEIGHT,
		   0, GL_RGB, GL_FLOAT, NULL);
    
    
    g.glBindTexture(GL_TEXTURE_2D, 0);
    
    // Resize to power-of-two viewport
    g.resize(IMAGE_WIDTH,IMAGE_HEIGHT);
	
}


void drawRect(GLWidget &g, float x, float y, float z, int n)
{
	static bool created[] {false, false, false};
    static GLuint VAO_rect0;
    static GLuint VAO_rect1;
    static GLuint VAO_rect2;

    // 1. Create VBO Buffers
    if (!created[n])
    {
        created[n] = true;
        if(n == 0) {
			// Create & bind empty VAO
			g.glGenVertexArrays(1, &VAO_rect0);
			g.glBindVertexArray(VAO_rect0);
		
			// Create VBO with (x,y,z) coordinates
			float coords[] = { -x, 0, -z,
								-x, 0, z, 
								x, 0, -z,     
								x,  0, z};
			GLuint VBO_coords;
			g.glGenBuffers(1, &VBO_coords);
			g.glBindBuffer(GL_ARRAY_BUFFER, VBO_coords);
			g.glBufferData(GL_ARRAY_BUFFER, sizeof(coords), coords, GL_STATIC_DRAW);
			g.glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0);
			g.glEnableVertexAttribArray(0);
			g.glBindVertexArray(0);
		}
		else if(n == 1) {
			// Create & bind empty VAO
			g.glGenVertexArrays(1, &VAO_rect1);
			g.glBindVertexArray(VAO_rect1);
		
			// Create VBO with (x,y,z) coordinates
			float coords[] = { -x, -y, 0,
								x, -y, 0, 
								-x, y, 0,     
								x,  y, 0};
			GLuint VBO_coords;
			g.glGenBuffers(1, &VBO_coords);
			g.glBindBuffer(GL_ARRAY_BUFFER, VBO_coords);
			g.glBufferData(GL_ARRAY_BUFFER, sizeof(coords), coords, GL_STATIC_DRAW);
			g.glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0);
			g.glEnableVertexAttribArray(0);
			g.glBindVertexArray(0);
		}
		else if(n == 2) {
			// Create & bind empty VAO
			g.glGenVertexArrays(1, &VAO_rect2);
			g.glBindVertexArray(VAO_rect2);
		
			// Create VBO with (x,y,z) coordinates
			float coords[] = { 0, -y, -z,
								0, y, -z, 
								0, -y, z,     
								0,  y, z};
			GLuint VBO_coords;
			g.glGenBuffers(1, &VBO_coords);
			g.glBindBuffer(GL_ARRAY_BUFFER, VBO_coords);
			g.glBufferData(GL_ARRAY_BUFFER, sizeof(coords), coords, GL_STATIC_DRAW);
			g.glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0);
			g.glEnableVertexAttribArray(0);
			g.glBindVertexArray(0);
		}
    }

    // 2. Draw
    if(n == 0) g.glBindVertexArray (VAO_rect0);
    else if(n == 1) g.glBindVertexArray (VAO_rect1);
    else if(n == 2) g.glBindVertexArray (VAO_rect2);
    g.glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    g.glBindVertexArray(0);
} 

bool Reflection2::paintGL()
{
	camera()->setZfar(100);
	
    GLWidget & g = *glwidget();
	g.makeCurrent();
	
	//textura 1
	QMatrix4x4 mirror = QMatrix4x4();
	mirror.translate(0, scene()->boundingBox().min().y(), 0);
	mirror.scale(1, -1, 1);
	mirror.translate(0, -scene()->boundingBox().min().y(), 0);
	QMatrix4x4 MVP = camera()->projectionMatrix() * camera()->viewMatrix();
    program->setUniformValue("modelViewProjectionMatrix", MVP*mirror);
    
    g.glClearColor(1.0,1.0,1.0,0);
    g.glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
    if (drawPlugin()) drawPlugin()->drawScene();
    // Get texture
    g.glBindTexture(GL_TEXTURE_2D, textureId1);
    g.glCopyTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 0, 0,
			  IMAGE_WIDTH, IMAGE_HEIGHT);
    g.glGenerateMipmap(GL_TEXTURE_2D);
    
    //textura 2
	mirror = QMatrix4x4();
	mirror.translate(0, 0, scene()->boundingBox().min().z());
	mirror.scale(1, 1, -1);
	mirror.translate(0, 0, -scene()->boundingBox().min().z());
	MVP = camera()->projectionMatrix() * camera()->viewMatrix();
    program->setUniformValue("modelViewProjectionMatrix", MVP*mirror);
    
    g.glClearColor(1.0,1.0,1.0,0);
    g.glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
    if (drawPlugin()) drawPlugin()->drawScene();
    // Get texture
    g.glBindTexture(GL_TEXTURE_2D, textureId2);
    g.glCopyTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 0, 0,
			  IMAGE_WIDTH, IMAGE_HEIGHT);
    g.glGenerateMipmap(GL_TEXTURE_2D);
    
    //textura 2
	mirror = QMatrix4x4();
	mirror.translate(scene()->boundingBox().min().x(), 0, 0);
	mirror.scale(-1, 1, 1);
	mirror.translate(-scene()->boundingBox().min().x(), 0, 0);
	MVP = camera()->projectionMatrix() * camera()->viewMatrix();
    program->setUniformValue("modelViewProjectionMatrix", MVP*mirror);
    
    g.glClearColor(1.0,1.0,1.0,0);
    g.glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
    if (drawPlugin()) drawPlugin()->drawScene();
    // Get texture
    g.glBindTexture(GL_TEXTURE_2D, textureId3);
    g.glCopyTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 0, 0,
			  IMAGE_WIDTH, IMAGE_HEIGHT);
    g.glGenerateMipmap(GL_TEXTURE_2D);
    
    
    
     
    //DRAW NORMAL SCENE
    program->setUniformValue("modelViewProjectionMatrix", MVP);
    g.glClearColor(1.0,1.0,1.0,0);
    g.glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
    if (drawPlugin()) drawPlugin()->drawScene();
     
	
	//draw mirror with texture
    program->bind();
    program->setUniformValue("colorMap", 0);
    program->setUniformValue("SIZE", float(IMAGE_WIDTH));
    QMatrix3x3 NM = camera()->viewMatrix().normalMatrix();
    program->setUniformValue("normalMatrix", NM);  
	
	glEnable (GL_CULL_FACE);
	
	float dx = (scene()->boundingBox().max().x() - scene()->boundingBox().min().x()) / 2;
	float dy = (scene()->boundingBox().max().y() - scene()->boundingBox().min().y()) / 2;
	float dz = (scene()->boundingBox().max().z() - scene()->boundingBox().min().z()) / 2;
	QMatrix4x4 t = QMatrix4x4();
	
	g.glBindTexture(GL_TEXTURE_2D, textureId1);
    t.translate(0, scene()->boundingBox().min().y(), 0);
    program->setUniformValue("modelViewProjectionMatrix", MVP*t);
    drawRect(g,dx,dy,dz,0);
    
    
    g.glBindTexture(GL_TEXTURE_2D, textureId2);
    t = QMatrix4x4();
    t.translate(0, 0, scene()->boundingBox().min().z());
    program->setUniformValue("modelViewProjectionMatrix", MVP*t);
    drawRect(g,dx,dy,dz,1);
    
    
    g.glBindTexture(GL_TEXTURE_2D, textureId3);
    t = QMatrix4x4();
    t.translate(scene()->boundingBox().min().x(), 0, 0);
    program->setUniformValue("modelViewProjectionMatrix", MVP*t);
    drawRect(g,dx,dy,dz,2);
   
	glDisable (GL_CULL_FACE);
   
    g.defaultProgram()->bind();
    g.glActiveTexture(GL_TEXTURE0);
    g.glBindTexture(GL_TEXTURE_2D, 0);

    return true;
}

