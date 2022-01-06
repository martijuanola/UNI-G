#include "showDegree.h"
#include "glwidget.h"

void ShowDegree::preFrame()
{
	const Object &obj = scene()->objects()[0];
	const int faces = obj.faces().size();
	const int vertexs = obj.vertices().size();
	degree = float(faces*3)/vertexs;
}

void ShowDegree::postFrame()
{
	QFont font;
	font.setPixelSize(12);
	painter.begin(glwidget());
	painter.setFont(font);
	
	painter.drawText(15, 20, QString("Degree: %1").arg(degree)); 
    painter.end();
	
}
