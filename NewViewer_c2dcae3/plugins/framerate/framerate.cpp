#include "framerate.h"
#include "glwidget.h"

void Framerate::printFPS() {
	cout << "Frames/s = " << FrameCount << endl;
}

void Framerate::onPluginLoad() {
	elapsedTimer.start();
	lastPrint = 0;
	
	/**
	 * Alternativa per exectuar sense tot lo de post frame
	 * 
	 * FrameCOunt=0;
	 * QTimer *frameTimer=new QTimer(this);
	 * connect(frameTimer, SIGNAL(timeout()), this, SLOT(printFPS()));
	 * frameTimer->start(1000);
    */
}

void Framerate::postFrame()
{
	FrameCount++;
	float t = elapsedTimer.elapsed()/1000.0f;
	if(t > lastPrint+1) {
		printFPS();
		lastPrint++;
		FrameCount = 0;
	}	
}
 
