#include "modelInfo.h"
#include "glwidget.h"

void ModelInfo::postFrame()
{
	Scene* s = scene();
	int obj = s->objects().size();
	int pol = 0;
	int vert = 0;
	int t = 0;
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
	
	cout << "Info Post-frame:";
	cout << "[nObj = "<< obj << "]";
	cout << "[nPol = "<< pol << "]";
	cout << "[nVert = "<< vert << "]";
	cout << "[%Tri = "<< t << "]";
	cout << endl;
}
