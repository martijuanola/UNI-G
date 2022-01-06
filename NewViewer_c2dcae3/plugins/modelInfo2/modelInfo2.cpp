#include "modelInfo2.h"
#include "glwidget.h"


void ModelInfo2::postFrame()
{
	Scene* s = scene();
	int obj = s->objects().size();
	int pol = 0;
	int vert = 0;
	float t = 0;
	for(int i = 0; i < obj; i++) {
		const Object &ob = s->objects()[i];
		for(int j = 0; j < (int)ob.faces().size(); j++) {
			const Face &face = ob.faces()[j];
			int auxvert = face.numVertices();
			vert += auxvert;
			if(auxvert == 3) t++;
			pol++;
		}
	}
	
	t = float(t)/float(pol);
	 
	QFont font;
	font.setPixelSize(12);
	painter.begin(glwidget());
	painter.setFont(font);
	
	painter.drawText(15, 20, QString("Objectes: %1").arg(obj)); 
	painter.drawText(15, 40, QString("Polígons: %1").arg(pol)); 
	painter.drawText(15, 60, QString("Vertex: %1").arg(vert)); 
	painter.drawText(15, 80, QString("%Triangles : %1").arg(t)); 
    painter.end();
}
