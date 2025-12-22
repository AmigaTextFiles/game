/*
        ColorTileMatch 3D
      Written by Bl0ckeduser
*/

#include "libraries.h"
#include "DrawTiles.h"
#include "game.h"
#include "Config.h"
#include <stdio.h>
#include "TileColors.h"

void DrawTileSet(SDL_Surface **screen)
{
	int i, j, colorID;
	SDL_Rect TileRect;
	SDL_PixelFormat *ScreenFormat = (*screen)->format;
	Uint32 TileColor;
	int x, y;

	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	y = -13;
	for(i=(R_TILE_QTY*3)-1; i>=0; i--)
	{
		x = 18;
		for(j=(R_TILE_QTY*4)-1; j>=0; j--)
		{
			colorID = getTileColor(j,i);
			if(colorID)	CTM3D_Cube((GLfloat)x, (GLfloat)y, colorID);
			x -= 2;
		}
		y += 2;
	}

	SDL_GL_SwapBuffers();
}

void CTM3D_Cube(GLfloat x, GLfloat y, int color_code)
{
	static GLfloat angle = 45.0f;
	static int intro_done = 0;

	glLoadIdentity();

	/* special effect at beggining */
	if(angle >= 0)
	{	
		angle -= 0.01;
		glRotatef(angle, 0.0f, 1.0f, 0.0f);
	}
	if(!intro_done && angle<=0)
	{
		angle = 0;
		intro_done = 1;
		introIsDone();
	}

	/* the constants below are guesswork. I have yet
	   to become skillfull at GL programming. */
	glTranslatef(x+1.1f, y-0.75f, -37.32f);

	CTM3D_CubeFace(1, 2, 4, 3, color_code);
	CTM3D_CubeFace(1, 2, 6, 5, color_code);
	CTM3D_CubeFace(5, 6, 8, 7, color_code);
	CTM3D_CubeFace(3, 4, 8, 7, color_code);
	CTM3D_CubeFace(2, 6, 8, 4, color_code);
	CTM3D_CubeFace(1, 5, 7, 3, color_code);
}

void CTM3D_CubeFace(int a, int b, int c, int d, int color_code)
{
	int xcoord[] = { 0, -1, -1, -1, -1, 1, 1, 1, 1 };
	int ycoord[] = { 0, 1, 1, -1, -1, 1, 1, -1, -1 };
	int zcoord[] = { 0, -1, 1, -1, 1, -1, 1, -1, 1 };

	glBegin(GL_QUADS);

	glColor3d(
	    (GLfloat)TileR[color_code] / 255.0f,
	    (GLfloat)TileG[color_code] / 255.0f,
	    (GLfloat)TileB[color_code] / 255.0f);

	glVertex3d(xcoord[a], ycoord[a], zcoord[a]);
	glVertex3d(xcoord[b], ycoord[b], zcoord[b]);
	glVertex3d(xcoord[c], ycoord[c], zcoord[c]);
	glVertex3d(xcoord[d], ycoord[d], zcoord[d]);

	glEnd();
}


