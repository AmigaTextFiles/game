#include <GL/glut.h>
#include "scenario.h"

void Text_draw(char *str, int x, int y, float r, float g, float b)
{
    int i,l=strlen(str);
    
    glColor3f(r, g, b);
    //glRasterPos2i(x, y);
    glPushMatrix();
    glTranslatef((float)x, (float)y, 0.0);
    glScalef(0.1,0.1,0);
    for(i=0; i<l; i++)
        //glutBitmapCharacter(GLUT_BITMAP_HELVETICA_12, *str++);
        glutStrokeCharacter(GLUT_STROKE_MONO_ROMAN, *str++);

    glPopMatrix();
}


