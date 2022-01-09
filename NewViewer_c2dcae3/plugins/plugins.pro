TEMPLATE=subdirs
SUBDIRS = drawvbong navigate-default render-default
SUBDIRS += shaderLoader pluginLoader

SUBDIRS += effectCRT
SUBDIRS += showHelpNg
SUBDIRS += alphaBlending

# Afegiu a SUBDIRS els vostres plugins!:

#EFFECT PLUGINS
SUBDIRS += modelInfo
SUBDIRS += animateVertices
SUBDIRS += modelInfo2
SUBDIRS += framerate
SUBDIRS += illuminacioFragments
SUBDIRS += showDegree

#DRAW PLUGINS
SUBDIRS += drawBoundingBox

#ACTION PLUGINS
SUBDIRS += resaltatObjecteSeleccionat
SUBDIRS += seleccioObjectesTeclat
SUBDIRS += seleccioObjectesMouse

#RENDER PLUGINS
SUBDIRS += textureSplatting
SUBDIRS += distort
SUBDIRS += reflection
