/*
    Bantumi
    Copyright 2005 - 2007 Martin Storsjö

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

    Martin Storsjö
    martin@martin.st
*/

#include "bantumigl.h"
#include "glwrapper.h"
#include <math.h>
#include "hand.h"
#include "mesh.h"
#include <string.h>
#include <stdio.h>
#include "grid.h"
#include "matrix.h"
#include "quat.h"
#include "glfont.h"
#include <stdlib.h>

#ifndef M_PI
#define M_PI 3.141592654
#endif

void debug(const char *str);

#ifdef _STRICT_ANSI
#define hypot(x, y) sqrt((x)*(x) + (y)*(y))
#endif

#define DROPLENGTH 200
#define MOVELENGTH 250
#define PICKUPLENGTH 250
#define THINKLOOPLENGTH 800
#define PUSHLENGTH 50
#define FADELENGTH 150
#define POINTLENGTH 150
#define TIMEOUTLENGTH 1100

enum AnimType { MOVEHAND, HANDZ, HANDPOSE, PICKUP, COLLECTSPHERES, STARTDROP, DROP, WAIT, THINK, PUSH, FADE, POINTHAND, TIMEOUT };

class AnimEvent {
public:
	int startTime;
	int endTime;
	AnimType type;
	AnimEvent *next;
	union {
		struct {
			int end;
		} moveHand;
		struct {
			float start, end;
		} handZ;
		struct {
			float start, end;
		} handPose;
		struct {
			int num;
			float bounceHeight;
		} drop;
		struct {
			bool last;
		} startDrop;
		struct {
			float start, end;
			bool setStart;
			bool initTitle;
		} fade;
		struct {
			bool stop;
		} think;
	};
};

static void setIdentity(GLTYPE *matrix) {
	memset(matrix, 0, sizeof(GLTYPE)*16);
	matrix[0] = matrix[5] = matrix[10] = matrix[15] = F(1);
}

static const GLTYPE clearC[] = { F(0), F(0.4), F(0), F(0) };
static const GLTYPE bowlC1[] = { F(0.3), F(0.3), F(0.6), F(1) };
static const GLTYPE bowlC2[] = { F(0.1), F(0.1), F(0.35), F(1) };
static const GLTYPE bowlC3[] = { F(0.6), F(0.3), F(0.3), F(1) };
static const GLTYPE bowlC4[] = { F(0.35), F(0.1), F(0.1), F(1) };

static const GLTYPE sphereC1[] = { F(0), F(0), F(1), F(1) };
static const GLTYPE sphereC2[] = { F(0.2), F(0.2), F(1), F(1) };
static const GLTYPE sphereC3[] = { F(1), F(0), F(0), F(1) };
static const GLTYPE sphereC4[] = { F(1), F(0.2), F(0.2), F(1) };

static const GLTYPE handC[] = { F(0.85), F(0.61), F(0.41), F(1) };
static const GLTYPE circleC[] = { F(1), F(1), F(1), F(1) };
static const GLTYPE textC[] = { F(0), F(0), F(0), F(1) };
static const GLTYPE titleTextFrontC[] = { F(1), F(1), F(1), F(1) };
static const GLTYPE titleTextShadowC[] = { F(0), F(0), F(0), F(1) };

static const float initBowlR1 = 0.7;
static const float initBowlR2 = 0.8;
static const float initBowlR3 = 0.95;
static const float initBowlH = 0.2;

BantumiGL::BantumiGL(int w, int h) {
	hand = new Hand();

	circle = bowl = sphere = NULL;
	circles = bowls = spheres = NULL;

	bowlR1 = initBowlR1;
	bowlR2 = initBowlR2;
	bowl = new BowlMesh(4, true, initBowlR1, initBowlR2, initBowlR3, initBowlH);

	textPos = new GLTYPE[3*14];
	grid = new Grid();
	for (int i = 0; i < 14; i++)
		fillGrid[i] = NULL;
	spheres = NULL;
	colors = NULL;

	handMovePos = 0;
	handStart = 0;
	handEnd = 1;

	lastTime = -1;
	relTime = 0;
	events = lastEvent = NULL;
	animEnd = 0;
	handSpheres = new int[5*12];
	started = false;

	fade = false;
	playedEarlier = false;
	lastFade = true;
	scissor = false;
	showSplash = true;

	diffLevels = 4;
	multiplayer = false;
#ifdef MULTIPLAYER
	multiplayer = true;
#endif
	selected[0] = 1;
	selected[1] = 1;
	selected[2] = 0;
	levelLen[0] = 3;
	levelLen[1] = diffLevels + (multiplayer?1:0);
	levelLen[2] = 2;
	levelStart[0] = 0;
	levelStart[1] = levelLen[0];
	levelStart[2] = levelStart[1]+levelLen[1];
	choice = -1;

	reinitGL(w, h);
}

BantumiGL::~BantumiGL() {
	for (int i = 0; i < 14; i++)
		delete fillGrid[i];
	delete grid;
	delete hand;
	delete spheres;
	delete sphere;
	delete bowls;
	delete bowl;
	delete circles;
	delete circle;
	delete [] textPos;
	delete [] colors;
	delete [] handSpheres;
	AnimEvent *e = events;
	while (e != NULL) {
		AnimEvent *next = e->next;
		delete e;
		e = next;
	}
}

void BantumiGL::setNumFont(GLFont *f) {
	numFont = f;
}

void BantumiGL::setTextFont(GLFont *f) {
	textFont = f;
}

void BantumiGL::useScissor(bool s) {
	scissor = s;
}

void BantumiGL::setProjMatrix(float l, float r, float b, float t, float n, float f) {
	memset(projMatrix, 0, sizeof(GLTYPE)*16);
	projMatrix[0] = F(2*n/(r-l));
	projMatrix[5] = F(2*n/(t-b));
	projMatrix[8] = F((r+l)/(r-l));
	projMatrix[9] = F((t+b)/(t-b));
	projMatrix[10] = F(-(f+n)/(f-n));
	projMatrix[11] = F(-1);
	projMatrix[14] = F(-2*f*n/(f-n));
	glMultMatrix(projMatrix);
}

void BantumiGL::project(GLTYPE *out, const GLTYPE *pos) {
	GLTYPE pos4[4], temp[4];
	memcpy(pos4, pos, sizeof(GLTYPE)*3);
	pos4[3] = 1;
	multVect4(temp, projMatrix, pos4);
	GLTYPE invz = F(1/TOFLOAT(temp[3]));
	MULBY(temp[0], invz);
	MULBY(temp[1], invz);
	MULBY(temp[2], invz);
	MULBY(temp[0], F(0.5));
	MULBY(temp[1], F(0.5));
	MULBY(temp[2], F(0.5));
	temp[0] += F(0.5);
	temp[1] += F(0.5);
	temp[2] += F(0.5);
	out[0] = temp[0]*width;
	out[1] = temp[1]*height;
	out[2] = temp[2];
}

void BantumiGL::reinitGL(int w, int h) {
	width = w;
	height = h;

	glViewport(0, 0, width, height);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	zNear = 10;
	zFar = 15;
	float yAngle = 35;
	float nh = zNear*tan((yAngle/2)*M_PI/180);
	float nw = nh*width/height;
	if (h > w) {
		float xAngle = 35;
		nw = zNear*tan((xAngle/2)*M_PI/180);
		nh = nw*height/width;
	}
	setProjMatrix(-nw, nw, -nh, nh, zNear, zFar);
//	glFrustum(-nw, nw, -nh, nh, zNear, zFar);
	yMax = zFar*nh/zNear;
	xMax = zFar*nw/zNear;
	longEdge = 2*xMax;
	shortEdge = 2*yMax;
	if (h > w) {
		longEdge = 2*yMax;
		shortEdge = 2*xMax;
	}

	glShadeModel(GL_SMOOTH);
	glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_FASTEST);


	glEnable(GL_COLOR_MATERIAL);
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_NORMAL_ARRAY);

	scaleScenery();
}

void BantumiGL::scaleScenery() {

	if (showSplash) {
		bowlSize = 1;
	} else if (!started) {
		bowlSize = yMax/4;
	} else {
		bowlSize = shortEdge/5.5;
		float bowlSize2 = longEdge/7;
		if (bowlSize2 < bowlSize)
			bowlSize = bowlSize2;
	}

	GLTYPE dim[3];


	if (showSplash) {
		bowlHeight = bowlSize*0.125;
	} else {
		bowlHeight = (zFar - zNear)/25;
	}
	bowl->getDim(dim);
	bowl->scale(F(bowlSize/TOFLOAT(dim[0])), F(bowlSize/TOFLOAT(dim[1])), F(bowlHeight/TOFLOAT(dim[2])));
	bowlR1 *= bowlSize/TOFLOAT(dim[0]);
	bowlR2 *= bowlSize/TOFLOAT(dim[0]);

	if (circle) {
		circleSize = bowlSize/2;
		circle->getDim(dim);
		circle->scale(F(circleSize/TOFLOAT(dim[0])), F(circleSize/TOFLOAT(dim[0])), F(1));
	}

	hand->getDim(dim);
	float scale = 2*bowlR1/TOFLOAT(dim[1]);
	hand->scale(F(scale));

	handMaxHeight = 7.5*bowlHeight;

	sphereSize = 2*bowlR1/5;
	if (sphere) {
		sphere->getDim(dim);
		sphere->scale(F(sphereSize/TOFLOAT(dim[0])), F(sphereSize/TOFLOAT(dim[1])), F(sphereSize/TOFLOAT(dim[2])));
	}

	grid->setShape(bowlR1, bowlR2, bowlHeight);
	grid->setDiam(sphereSize);
	grid->calcPositions(75);
	for (int i = 0; i < 14; i++)
		if (!fillGrid[i])
			fillGrid[i] = new FillGrid(grid);


	GLTYPE lightSpecular[] = { F(1), F(1), F(1), F(1) };
	GLTYPE lightPos[] = { F(-xMax), F(yMax), F(-zFar + 9*handMaxHeight), F(1) };

	if (showSplash) {
		lightPos[0] = F(-5);
		lightPos[1] = F(5);
		lightPos[2] = F(-zFar + 5*handMaxHeight);
	}

	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();

	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	glLightv(GL_LIGHT0, GL_POSITION, lightPos);
	glLightv(GL_LIGHT0, GL_SPECULAR, lightSpecular);

	makeBowlMatrices();

	lastFade = true; // mark the whole screen dirty
}

void BantumiGL::makeBowlMatrices() {
	if (bowls == NULL) return;
	float longUnit = longEdge/6.5;
	float shortUnit = shortEdge/3;
	bool ellipse = false;
	float bowlZ = -zFar + (zFar-zNear)/100;
	if (!started && !showSplash) {
		float circleSpacing = 1.5*bowlSize;
		if (multiplayer)
			circleSpacing = 1.0*bowlSize;
		titleHeight = yMax/6;
		titlePos[0] = F(0);
		titlePos[1] = F(yMax - 1.1*titleHeight);
		titlePos[2] = F(bowlZ);
		subtitleHeight = yMax/9;
		subtitlePos1[0] = F(0);
		subtitlePos1[1] = F(1.3*bowlSize + bowlSize/2 + 1.10*subtitleHeight);
		subtitlePos1[2] = F(bowlZ);
		int lev1SizeLen = levelLen[1] + (multiplayer ? 1 : 0);
		subtitlePos2[0] = F((float(diffLevels - 1)/2 - float(lev1SizeLen - 1)/2)*circleSpacing);
		subtitlePos2[1] = F(-1.1*bowlSize + circleSize/2 + 1.10*subtitleHeight);
		subtitlePos2[2] = F(bowlZ);
		subtitlePos22[0] = F((diffLevels + 0.5 - float(lev1SizeLen - 1)/2)*circleSpacing);
		subtitlePos22[1] = subtitlePos2[1];
		subtitlePos22[2] = subtitlePos2[2];
		subtitlePos3[0] = F(0.97*xMax);
		subtitlePos3[1] = F(-0.90*yMax);
		subtitlePos3[2] = F(bowlZ);
		// bowls
		for (int i = levelStart[0]; i < levelStart[0] + levelLen[0]; i++) {
			GLTYPE *matrix = &bowlMatrices[16*i];
			setIdentity(matrix);
			matrix[12] = F((i-1)*3*bowlSize/2);
			matrix[13] = F(1.3*bowlSize);
			matrix[14] = F(bowlZ);
		}
		// circles
		for (int i = levelStart[1]; i < levelStart[1] + levelLen[1]; i++) {
			GLTYPE *matrix = &bowlMatrices[16*i];
			setIdentity(matrix);
			float offset = 0;
			if (i >= levelStart[1] + diffLevels)
				offset = 0.5;
			matrix[12] = F((i - levelStart[1] + offset - float(lev1SizeLen - 1)/2)*circleSpacing);
			matrix[13] = F(-1.1*bowlSize);
			matrix[14] = F(bowlZ);
		}
		GLTYPE *matrix = &bowlMatrices[16*levelStart[2]];
		setIdentity(matrix);
		matrix[12] = F(-1.9*bowlSize);
		matrix[13] = F(-2.6*bowlSize);
		matrix[14] = F(bowlZ);
		matrix = &bowlMatrices[16*(levelStart[2]+1)];
		setIdentity(matrix);
		matrix[12] = F(1.9*bowlSize);
		matrix[13] = F(-2.6*bowlSize);
		matrix[14] = F(bowlZ);
	} else if (!started && showSplash) {
		GLTYPE *matrix = &bowlMatrices[16*0];
		setIdentity(matrix);
		matrix[12] = F(0);
		matrix[13] = F(0);
		matrix[14] = F(bowlZ);
	} else if (ellipse) {
		float r1 = shortEdge/3;
		float r2 = longUnit*2.5;
		for (int i = 0; i < 14; i++) {
			float angle = 2*M_PI*(i+1)/14;
			float x = -r2*cos(angle);
			float y = -r1*sin(angle);
			float z = bowlZ;
			float len = hypot(x, y);

			GLTYPE *matrix = &bowlMatrices[16*i];
			setIdentity(matrix);

			matrix[4] = F(-x/len);
			matrix[5] = F(-y/len);
			matrix[0] = F(-y/len);
			matrix[1] = F(x/len);

			matrix[12] = F(x);
			matrix[13] = F(y);
			matrix[14] = F(z);
		}
	} else {
		for (int i = 0; i < 14; i++) {
			GLTYPE *matrix = &bowlMatrices[16*i];
			float shortOffset = -shortUnit;
			float longOffset = longUnit*(-2.5+(i%7));
			setIdentity(matrix);
			if ((i%7) == 6) {
				shortOffset = 0;
				longOffset = 2.5*longUnit;
				matrix[0] = F(0);
				matrix[1] = F(1);
				matrix[4] = F(-1);
				matrix[5] = F(0);
			}
			if (i >= 7) {
				shortOffset *= -1;
				longOffset *= -1;
				matrix[0] *= -1;
				matrix[1] *= -1;
				matrix[4] *= -1;
				matrix[5] *= -1;
			}
			float x = longOffset;
			float y = shortOffset;
			float z = bowlZ;
			matrix[12] = F(x);
			matrix[13] = F(y);
			matrix[14] = F(z);
		}
		GLTYPE *matrix = &bowlMatrices[16*14];
		setIdentity(matrix);
		matrix[14] = F(bowlZ);
	}
	if (started && yMax > xMax) {
		for (int i = 0; i < 14; i++) {
			GLTYPE *matrix = &bowlMatrices[16*i];
			GLTYPE tmp;
			tmp = matrix[12];
			matrix[12] = matrix[13];
			matrix[13] = -tmp;
			tmp = matrix[0];
			matrix[0] = matrix[1];
			matrix[1] = -tmp;
			tmp = matrix[4];
			matrix[4] = matrix[5];
			matrix[5] = -tmp;
		}
	}
	if (started) {
		GLTYPE matrix1[16];
		setIdentity(matrix1);
		matrix1[0] = F(-1);
		matrix1[5] = F(-1);
		matrix1[13] = F(2*bowlSize);
		multMatrix(&bowlMatrices[16*15], &bowlMatrices[16*6], matrix1);
		multMatrix(&bowlMatrices[16*16], &bowlMatrices[16*13], matrix1);
	}

	updateBowlsSpheres();
}

void BantumiGL::updateBowlsSpheres() {
	if (bowls == NULL)
		return;
	if (!started && !showSplash) {
		for (int i = levelStart[0]; i < levelStart[0] + levelLen[0]; i++) {
			bowls->setVertices(i, &bowlMatrices[16*i]);
		}
		for (int i = levelStart[1]; i < levelStart[1] + levelLen[1]; i++) {
			circles->setVertices(i - levelStart[1], &bowlMatrices[16*i]);
			memcpy(&textPos[3*(i - levelStart[1])], &bowlMatrices[16*i+12], sizeof(float)*3);
		}
	} else if (showSplash) {
		bowls->setVertices(0, &bowlMatrices[16*0]);
	} else {
		for (int i = 0; i < 14; i++) {
			GLTYPE matrix1[16], matrix2[16];
			bowls->setVertices(i, &bowlMatrices[16*i]);

			setIdentity(matrix1);
			matrix1[13] = F(bowlSize/2 + circleSize/2 + circleSize/4);
			multMatrix(matrix2, &bowlMatrices[16*i], matrix1);
			circles->setVertices(i, matrix2);
			memcpy(&textPos[3*i], &matrix2[12], sizeof(GLTYPE)*3);
		}
	}
	int n = 14;
	if (showSplash)
		n = 1;
	else if (!started)
		n = 3;

	for (int i = 0; i < n; i++) {
		if (fillGrid[i] == NULL)
			continue;
		for (int j = 0; j < fillGrid[i]->filled; j++) {
			GLTYPE matrix1[16], matrix2[16];
			setIdentity(matrix1);
			grid->getPos(&matrix1[12], fillGrid[i]->indices[j]);
			multMatrix(matrix2, &bowlMatrices[16*i], matrix1);
			spheres->setVertices(fillGrid[i]->numbers[j], matrix2);
		}
	}
}

void BantumiGL::dim(GLTYPE *pos, float w, float h, float fact) {
	GLTYPE ppos1[3];
	GLTYPE ppos2[3];
	GLTYPE cpos[3];
	cpos[0] = pos[0] - F(w)/2;
	cpos[1] = pos[1] - F(h)/2;
	cpos[2] = pos[2];
	project(ppos1, cpos);
	cpos[0] = pos[0] + F(w)/2;
	cpos[1] = pos[1] + F(h)/2;
	project(ppos2, cpos);
	dim(TOINT(ppos1[0]), TOINT(ppos1[1]), TOINT(ppos2[0]), TOINT(ppos2[1]), fact);
}

void BantumiGL::dim(int x1, int y1, int x2, int y2, float fact) {
	GLTYPE verts[4*2];
	verts[2*0+0] = F(x1);
	verts[2*0+1] = F(y1);
	verts[2*1+0] = F(x2);
	verts[2*1+1] = F(y1);
	verts[2*2+0] = F(x2);
	verts[2*2+1] = F(y2);
	verts[2*3+0] = F(x1);
	verts[2*3+1] = F(y2);
	short faces[] = { 0, 1, 3, 1, 2, 3 }; 
	glColor4(clearC[0], clearC[1], clearC[2], F(fact));
	glVertexPointer(2, GLTYPETOKEN, 0, verts);
	glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, faces);
}

void BantumiGL::drawPickRect(GLTYPE width, GLTYPE height, GLTYPE x, GLTYPE y, GLTYPE z, int index) {
	GLTYPE verts[4*3];
	verts[3*0+0] = x - width/2;
	verts[3*0+1] = y - height/2;
	verts[3*0+2] = z;
	verts[3*1+0] = x + width/2;
	verts[3*1+1] = y - height/2;
	verts[3*1+2] = z;
	verts[3*2+0] = x + width/2;
	verts[3*2+1] = y + height/2;
	verts[3*2+2] = z;
	verts[3*3+0] = x - width/2;
	verts[3*3+1] = y + height/2;
	verts[3*3+2] = z;
	short faces[] = { 0, 1, 3, 1, 2, 3 }; 
	index++;
	int rIndex = (index >> 4) & 3;
	int gIndex = (index >> 2) & 3;
	int bIndex = (index >> 0) & 3;
	GLTYPE r = F(1)*rIndex/3;
	GLTYPE g = F(1)*gIndex/3;
	GLTYPE b = F(1)*bIndex/3;
	glColor4(r, g, b, F(1));
	glVertexPointer(3, GLTYPETOKEN, 0, verts);
	glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, faces);
}

void BantumiGL::resetLastTime() {
	lastTime = -1;
}

void BantumiGL::draw(int time, bool pick) {
	int diff = time - lastTime;
	if (lastTime == -1)
		diff = 0;
	lastTime = time;
	relTime += diff;

	updateAnim();

	if (pick)
		glClearColor(F(0), F(0), F(0), F(0));
	else
		glClearColor(clearC[0], clearC[1], clearC[2], clearC[3]);

	if (showSplash) {
		float top = 0.7*handMaxHeight;
		handHeight = top*(1 - 0.5*relTime/TIMEOUTLENGTH);
		if (relTime > TIMEOUTLENGTH/2)
			handPose = 0 + 0.4*(relTime - TIMEOUTLENGTH/2)/(TIMEOUTLENGTH/2);
		else
			handPose = 0;

		memcpy(origProjMatrix, projMatrix, sizeof(GLTYPE)*16);
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		float zNear = bowlSize/2;
		float zFar = 4*bowlSize;
		float yAngle = 45;
		float nh = zNear*tan((yAngle/2)*M_PI/180);
		float nw = nh*width/height;
		setProjMatrix(-nw, nw, -nh, nh, zNear, zFar);
		GLTYPE matrix1[16], matrix2[16], rot[16];
		GLTYPE aa1[] = { F(M_PI/2), F(1), F(0), F(0) };
		float angle = -2*M_PI/4 + 3*M_PI/8*relTime/TIMEOUTLENGTH + M_PI;
		GLTYPE aa2[] = { -F(angle), F(0), F(1), F(0) };
		GLTYPE aa3[] = { -F(0.25*M_PI/2), F(1), F(0), F(0) };
		memcpy(matrix1, &bowlMatrices[16*0], sizeof(GLTYPE)*16);
		matrix1[14] = bowlMatrices[14] + F(1.5*top);
		aaToMatrix(rot, aa1);
		multMatrix(matrix2, matrix1, rot);

		aaToMatrix(rot, aa2);
		multMatrix(matrix1, matrix2, rot);

		setIdentity(rot);
		rot[14] = F(1.8*bowlSize);
		multMatrix(matrix2, matrix1, rot);

		aaToMatrix(rot, aa3);
		multMatrix(matrix1, matrix2, rot);
		invertMatrix(matrix2, matrix1);
		multMatrix(matrix1, projMatrix, matrix2);
		memcpy(projMatrix, matrix1, sizeof(GLTYPE)*16);
		glLoadIdentity();
		glMultMatrix(projMatrix);
	}

	matrixInterp(handMatrix, &bowlMatrices[16*handStart], &bowlMatrices[16*handEnd], F(handMovePos));
	handMatrix[14] += F(handHeight);
	if (!started && !showSplash) {
		float offsets[] = { bowlSize, 1.5*circleSize, 1.5*circleSize };
		int lev1 = 0;
		while (handStart >= levelStart[lev1] + levelLen[lev1])
			lev1++;
		int lev2 = 0;
		while (handEnd >= levelStart[lev2] + levelLen[lev2])
			lev2++;
		float offset = offsets[lev1] + handMovePos*(offsets[lev2] - offsets[lev1]);
		handMatrix[13] -= F(offset);
	}
	if (handPose >= 0)
		hand->setPose(F(handPose));
	hand->doPose();



	if (showSplash)
		lastFade = true; // don't use scissor tests

	GLTYPE handDim[3];
	hand->getDim(handDim);
	GLTYPE handCorner[12];
	MULBY(handDim[0], -F(0.8));
	MULBY(handDim[1], -F(0.8));
	MULBY(handDim[2], F(0.8));
	GLTYPE handCPos[3];
	multVect3(handCPos, handMatrix, handDim, F(1));
	project(&handCorner[0], handCPos);
	handDim[0] = -handDim[0];
	multVect3(handCPos, handMatrix, handDim, F(1));
	project(&handCorner[3], handCPos);
	handDim[1] = -handDim[1];
	multVect3(handCPos, handMatrix, handDim, F(1));
	project(&handCorner[6], handCPos);
	handDim[0] = -handDim[0];
	multVect3(handCPos, handMatrix, handDim, F(1));
	project(&handCorner[9], handCPos);

	bool usingScissor = false;
	if (lastFade || fade || !scissor) {
		glDisable(GL_SCISSOR_TEST);
		textFont->setClipping(0, 0, 0, 0);
		numFont->setClipping(0, 0, 0, 0);
	} else {
		usingScissor = true;
		glEnable(GL_SCISSOR_TEST);

		int minX = width;
		int maxX = 0;
		int minY = height;
		int maxY = 0;

#define TESTPOS(v) do {				\
		int x = TOINT((v)[0]);		\
		int y = TOINT((v)[1]);		\
		if (x > maxX) maxX = x;		\
		if (x < minX) minX = x;		\
		if (y > maxY) maxY = y;		\
		if (y < minY) minY = y;		\
	} while (0)

		TESTPOS(&handCorner[0]);
		TESTPOS(&handCorner[3]);
		TESTPOS(&handCorner[6]);
		TESTPOS(&handCorner[9]);
		TESTPOS(&lastHandCorner[0]);
		TESTPOS(&lastHandCorner[3]);
		TESTPOS(&lastHandCorner[6]);
		TESTPOS(&lastHandCorner[9]);

#define TESTSQUARE(v, r) do {				\
		GLTYPE ppos[3], pos[3];			\
		memcpy(pos, v, sizeof(GLTYPE)*3);	\
		pos[0] -= F((r)*0.7);			\
		pos[1] -= F((r)*0.7);			\
		project(ppos, pos);			\
		TESTPOS(ppos);				\
		pos[0] += F((r)*1.4);			\
		pos[1] += F((r)*1.4);			\
		project(ppos, pos);			\
		TESTPOS(ppos);				\
	} while (0)

		if (handStart == handEnd) {
			TESTSQUARE(&bowlMatrices[16*handStart+12], bowlSize);
		}
		if (!started) {
			TESTSQUARE(&handMatrix[12], 1.5*bowlSize);
			minX = 0;
			maxX = width - 1;
			if (choice >= 0)
				TESTSQUARE(&bowlMatrices[16*levelStart[2]+12], subtitleHeight);
		}
		for (int i = 0; i < nTexts; i++) {
			if (lastDisplayNum[i] != displayNum[i]) {
				TESTSQUARE(&textPos[3*i], circleSize);
			}
		}
		glScissor(minX, minY, maxX - minX + 1, maxY - minY + 1);
		textFont->setClipping(minX, minY, maxX, maxY);
		numFont->setClipping(minX, minY, maxX, maxY);
	}
	lastFade = fade;
	memcpy(lastDisplayNum, displayNum, sizeof(int)*14);
	memcpy(lastHandCorner, handCorner, sizeof(GLTYPE)*12);



	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	glDisable(GL_CULL_FACE);

	GLTYPE zero[] = { F(0), F(0), F(0), F(0) };
	glMaterialv(GL_FRONT_AND_BACK, GL_SPECULAR, zero);
	glDisable(GL_DEPTH_TEST);


	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_NORMAL_ARRAY);
	glDisable(GL_LIGHTING);
	glColor4v(circleC);
	if (pick) {
		if (!started) {
			for (int i = levelStart[1]; i < levelStart[1] + levelLen[1]; i++) {
				GLTYPE *matrix = &bowlMatrices[16*i];
				drawPickRect(F(1.4*circleSize), F(1.4*circleSize), matrix[12], matrix[13], matrix[14], i);
			}
		}
	} else
		circles->draw();
	glEnableClientState(GL_NORMAL_ARRAY);

	float fact = 1;
	if (!showSplash) {
		GLTYPE pos1[] = { F(0), F(0), textPos[2] };
		GLTYPE pos2[] = { F(0), F(1), textPos[2] };
		GLTYPE ppos1[3], ppos2[3];
		project(ppos1, pos1);
		project(ppos2, pos2);
		fact = TOFLOAT(ppos2[1] - ppos1[1]);

		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();

		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		glOrtho(F(0), F(width), F(0), F(height), F(-1), F(1));


		glDisable(GL_DEPTH_TEST);

		float textHeight = circleSize*0.4;
		if (!started)
			textHeight = circleSize*0.4;
		textHeight *= fact;

		for (int i = 0; i < nTexts; i++) {
			GLTYPE *pos = &textPos[3*i];
			char buf[5];
			sprintf(buf, "%d", displayNum[i]);
			GLTYPE ppos[3];
			project(ppos, pos);
			if (!pick)
				numFont->draw(buf, F(textHeight), F(TOINT(ppos[0])), F(TOINT(ppos[1])), textC);
		}
	}
	glEnable(GL_LIGHTING);

	if (!started && !showSplash) {

		glDisable(GL_DEPTH_TEST);
		glDisable(GL_LIGHTING);

		GLTYPE ppos[3];
		char buf[25];

		GLTYPE offset = F(subtitleHeight/7);
		offset = GLTYPE(offset*fact);

		project(ppos, titlePos);
		sprintf(buf, "Bantumi GL");
		if (!pick)
			textFont->draw(buf, F(titleHeight*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), titleTextShadowC);
		ppos[0] -= offset;
		ppos[1] += offset;
		if (!pick)
			textFont->draw(buf, F(titleHeight*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), titleTextFrontC);

		project(ppos, subtitlePos1);
		sprintf(buf, "Game type");
		if (!pick)
			textFont->draw(buf, F(subtitleHeight*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), titleTextShadowC);
		ppos[0] -= offset;
		ppos[1] += offset;
		if (!pick)
			textFont->draw(buf, F(subtitleHeight*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), titleTextFrontC);

		project(ppos, subtitlePos2);
		float subtitle2Height = subtitleHeight;
		if (multiplayer) {
			sprintf(buf, "AI level");
			subtitle2Height = 0.5*subtitleHeight;
		} else {
			sprintf(buf, "Level");
		}
#ifdef SYMBIAN
		if (subtitle2Height*fact < 0.035*height)
			subtitle2Height = 0.035*height/fact;
#endif
		if (!pick)
			textFont->draw(buf, F(subtitle2Height*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), titleTextShadowC);
		ppos[0] -= offset;
		ppos[1] += offset;
		if (!pick)
			textFont->draw(buf, F(subtitle2Height*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), titleTextFrontC);

		if (multiplayer) {
			project(ppos, subtitlePos22);
			sprintf(buf, "Multiplayer");
			if (pick)
				drawPickRect(F(1.5*0.8*subtitle2Height*fact*strlen(buf)), F(1.5*subtitle2Height*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), F(0), levelStart[2]-1);
			else
				textFont->draw(buf, F(subtitle2Height*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), titleTextShadowC);
			ppos[0] -= offset;
			ppos[1] += offset;
			if (!pick)
				textFont->draw(buf, F(subtitle2Height*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), titleTextFrontC);
		}

		strcpy(buf, "by Martin Storsjö");
		GLTYPE temp = subtitlePos3[0];
		float credHeight = 0.5*subtitleHeight;
		float ratio = 0.8;
#ifdef SYMBIAN
		credHeight = 0.7*subtitleHeight;
		ratio = 0.65;
#endif
		subtitlePos3[0] -= F(0.5*credHeight*ratio*strlen(buf));
		project(ppos, subtitlePos3);
		if (!pick)
			textFont->draw(buf, F(credHeight*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), titleTextShadowC);
		subtitlePos3[0] = temp;

		project(ppos, &bowlMatrices[16*(levelStart[2]+0)+12]);
		sprintf(buf, "Start");
		if (pick)
			drawPickRect(F(1.5*0.8*subtitleHeight*fact*strlen(buf)), F(1.5*subtitleHeight*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), F(0), levelStart[2]);
		else
			textFont->draw(buf, F(subtitleHeight*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), titleTextShadowC);
		if (choice == 0) {
			ppos[0] -= GLTYPE(choiceOffset*offset);
			ppos[1] += GLTYPE(choiceOffset*offset);
		} else {
			ppos[0] -= offset;
			ppos[1] += offset;
		}
		if (!pick)
			textFont->draw(buf, F(subtitleHeight*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), titleTextFrontC);

		project(ppos, &bowlMatrices[16*(levelStart[2]+1)+12]);
		sprintf(buf, "Exit");
		if (pick)
			drawPickRect(F(1.5*0.8*subtitleHeight*fact*strlen(buf)), F(1.5*subtitleHeight*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), F(0), levelStart[2]+1);
		else
			textFont->draw(buf, F(subtitleHeight*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), titleTextShadowC);
		if (choice == 1) {
			ppos[0] -= GLTYPE(choiceOffset*offset);
			ppos[1] += GLTYPE(choiceOffset*offset);
		} else {
			ppos[0] -= offset;
			ppos[1] += offset;
		}
		if (!pick)
			textFont->draw(buf, F(subtitleHeight*fact), F(TOINT(ppos[0])), F(TOINT(ppos[1])), titleTextFrontC);
		glEnable(GL_LIGHTING);
	}

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glMultMatrix(projMatrix);
	glMatrixMode(GL_MODELVIEW);

	if (showSplash) {
		glEnable(GL_DEPTH_TEST);
		glDisable(GL_CULL_FACE);
	} else {
		glDisable(GL_DEPTH_TEST);
		glEnable(GL_CULL_FACE);
	}
	glLoadIdentity();
	if (pick) {
		glDisable(GL_LIGHTING);
		glDisableClientState(GL_COLOR_ARRAY);
		glDisableClientState(GL_NORMAL_ARRAY);
		if (!started && !showSplash) {
			for (int i = levelStart[0]; i < levelStart[0] + levelLen[0]; i++) {
				GLTYPE *matrix = &bowlMatrices[16*i];
				drawPickRect(F(1.4*bowlSize), F(1.4*bowlSize), matrix[12], matrix[13], matrix[14], i);
			}
		} else if (started) {
			for (int i = 0; i < 14; i++) {
				GLTYPE *matrix = &bowlMatrices[16*i];
				drawPickRect(F(1.05*bowlSize), F(1.05*bowlSize), matrix[12], matrix[13], matrix[14], i);
			}
		}
	} else {
		glEnableClientState(GL_COLOR_ARRAY);
		bowls->draw();
	}
	glDisableClientState(GL_COLOR_ARRAY);

/*
	int nBowls = 14;
	if (!started)
		nBowls = 3;
	for (int i = 0; i < nBowls; i++) {
		glLoadIdentity();
		glMultMatrix(&bowlMatrices[16*i]);
		if (i == 6)
			glColor4v(bowlC2);
		else if (i == 13)
			glColor4v(bowlC4);
		else if (i == 0)
			glColor4v(bowlC1);
		else if (i == 7)
			glColor4v(bowlC3);
		bowl->draw();
	}
	glLoadIdentity();
*/



	if (!pick) {
		for (int i = 0; i < nHandSpheres; i++)
			spheres->setVertices(handSpheres[i], handMatrix);

		GLTYPE sphereSpecular[] = { F(0.6), F(0.6), F(0.6), F(1) };
		glMaterialv(GL_FRONT_AND_BACK, GL_SPECULAR, sphereSpecular);
		glMaterial(GL_FRONT_AND_BACK, GL_SHININESS, F(25));
		glEnable(GL_DEPTH_TEST);
		glEnable(GL_CULL_FACE);
		glMatrixMode(GL_MODELVIEW);
		glEnableClientState(GL_COLOR_ARRAY);
		spheres->draw();
		glDisableClientState(GL_COLOR_ARRAY);
	}

/*
	for (int i = 0; i < 14; i++) {
		glLoadIdentity();
		glMultMatrix(&bowlMatrices[16*i]);
		for (int j = 0; j < fillGrid[i]->filled; j++) {
			glColor4v(&colors[3*fillGrid[i]->numbers[j]]);
			GLTYPE pos[3];
			grid->getPos(pos, fillGrid[i]->indices[j]);
			glPushMatrix();
			glTranslate(pos[0], pos[1], pos[2]);
			sphere->draw();
			glPopMatrix();
		}
	}
*/



	if (!started && !showSplash && !pick) {
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		glOrtho(F(0), F(width), F(0), F(height), F(-1), F(1));
		glDisableClientState(GL_COLOR_ARRAY);
		glDisableClientState(GL_NORMAL_ARRAY);
		glEnable(GL_BLEND);
		glDisable(GL_LIGHTING);
		glDisable(GL_DEPTH_TEST);
		glDisable(GL_CULL_FACE);
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

		for (int i = 0; i < levelLen[0]; i++)
			if (selected[0] != i)
				dim(&bowlMatrices[16*i+12], bowlSize*1.2, bowlSize*1.2, 0.5);
		for (int i = 0; i < levelLen[1]; i++)
			if (selected[1] != i)
				dim(&bowlMatrices[16*(i+levelStart[1])+12], circleSize*1.9, circleSize*1.2, 0.5);

		glDisable(GL_BLEND);
		glEnable(GL_LIGHTING);
		glEnableClientState(GL_NORMAL_ARRAY);
		glEnable(GL_DEPTH_TEST);
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		glMultMatrix(projMatrix);
		glMatrixMode(GL_MODELVIEW);
	}


	glMaterialv(GL_FRONT_AND_BACK, GL_SPECULAR, zero);
	glLoadIdentity();
	glMultMatrix(handMatrix);
	glColor4v(handC);
	glEnable(GL_CULL_FACE);
	if (!pick)
		hand->draw();

	if (fade && !pick) {
		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		glOrtho(F(0), F(width), F(0), F(height), F(-1), F(1));
		glDisableClientState(GL_COLOR_ARRAY);
		glDisableClientState(GL_NORMAL_ARRAY);
		glEnable(GL_BLEND);
		glDisable(GL_LIGHTING);
		glDisable(GL_DEPTH_TEST);
		glDisable(GL_CULL_FACE);
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

		dim(0, 0, width, height, 1 - fadePos);

		glDisable(GL_BLEND);
		glEnable(GL_LIGHTING);
		glEnableClientState(GL_NORMAL_ARRAY);
		glEnable(GL_DEPTH_TEST);
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		glMultMatrix(projMatrix);
		glMatrixMode(GL_MODELVIEW);
	}

	if (showSplash) {
		memcpy(projMatrix, origProjMatrix, sizeof(GLTYPE)*16);
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		glMultMatrix(projMatrix);
	}
}

void BantumiGL::init(int num) {
	clearAnims();
	started = true;
	int numSpheres = num;
	delete spheres;
	spheres = new AggregateMesh(6*2*numSpheres, sphere);
	spheres->setFaces();
	int cursphere = 0;
	for (int i = 0; i < 14; i++) {
		displayNum[i] = 0;
		fillGrid[i]->reset();
		if ((i%7) < 6) {
			displayNum[i] = numSpheres;
			for (int j = 0; j < numSpheres; j++)
				fillGrid[i]->add(cursphere++);
		}
	}
	nTexts = 14;
	delete hand;
	hand = new Hand();
	delete circles;
	circles = new AggregateMesh(14, circle);
	circles->setFaces();
	delete bowls;
	bowls = new AggregateMesh(14, bowl);
	bowls->setFaces();
	scaleScenery();
	delete [] colors;
	colors = new GLTYPE[numSpheres*6*2*3];
	for (int i = 0; i < numSpheres*6; i++) {
		const GLTYPE *color = sphereC1;
		if (i % (2*numSpheres) >= numSpheres)
			color = sphereC2;
		memcpy(&colors[3*i], color, sizeof(GLTYPE)*3);
		spheres->setColor(i, &colors[3*i]);
	}
	for (int i = 0; i < numSpheres*6; i++) {
		const GLTYPE *color = sphereC3;
		if (i % (2*numSpheres) >= numSpheres)
			color = sphereC4;
		memcpy(&colors[3*(i+numSpheres*6)], color, sizeof(GLTYPE)*3);
		spheres->setColor(i+numSpheres*6, &colors[3*(i+numSpheres*6)]);
	}

	for (int i = 0; i < 14; i++) {
		if (i < 6)
			bowls->setColor(i, bowlC1);
		else if (i < 7)
			bowls->setColor(i, bowlC2);
		else if (i < 13)
			bowls->setColor(i, bowlC3);
		else
			bowls->setColor(i, bowlC4);
	}

	animHandPos = handStart = handEnd = 0;
	handMovePos = 0;
	handPose = 0;
	handHeight = handMaxHeight;

	nHandSpheres = 0;

	playedEarlier = true;

	doExit = doStart = false;

	startFade(0, 1, false);
}



bool BantumiGL::animating() {
	return events != NULL;
}

void BantumiGL::pushEvent(AnimEvent *e) {
	e->next = NULL;
	if (lastEvent != NULL)
		lastEvent->next = e;
	else
		events = e;
	lastEvent = e;
}

void BantumiGL::collectSpheres(float pos) {
	handPose = pos;
	FillGrid *fg = fillGrid[handStart];
	int n = fg->filled;
	for (int i = 0; i < n; i++) {
		GLTYPE matrix1[16], matrix2[16];
		setIdentity(matrix1);
		GLTYPE initpos[3];
		grid->getPos(initpos, fg->indices[i]);
		GLTYPE endpos[3];
		endpos[0] = endpos[1] = F(0);
		endpos[2] = F(handHeight);
		matrix1[12] = initpos[0] + GLTYPE(pos*(endpos[0] - initpos[0]));
		matrix1[13] = initpos[1] + GLTYPE(pos*(endpos[1] - initpos[1]));
		matrix1[14] = initpos[2] + GLTYPE(pos*(endpos[2] - initpos[2]));
		multMatrix(matrix2, &bowlMatrices[16*handStart], matrix1);
		spheres->setVertices(fg->numbers[i], matrix2);
	}
}

void BantumiGL::collectSpheresEnd() {
	handPose = 1;
	FillGrid *fg = fillGrid[handStart];
	nHandSpheres = fg->filled;
	memcpy(handSpheres, fg->numbers, sizeof(int)*nHandSpheres);
	fg->reset();
}

void BantumiGL::setSphereDrop(int num, float pos, float bounceHeight) {
	if (nHandSpheres > 0 && handSpheres[nHandSpheres-1] == num)
		nHandSpheres--;
	float bouncePos = 0.30;
	GLTYPE matrix1[16], matrix2[16];
	setIdentity(matrix1);
	GLTYPE *sPos = &matrix1[12];
	if (pos <= bouncePos) {
		float start = handHeight;
		float x = pos/bouncePos;
//		float y = 1 - x*x;
		float y = 1 - x;
		float height = bounceHeight + y*(start - bounceHeight);
		sPos[0] = sPos[1] = F(0);
		sPos[2] = F(height);
	} else {
		FillGrid *fg = fillGrid[handStart];
		float x = (pos - bouncePos)/(1 - bouncePos);

		GLTYPE endpos[3];
		grid->getPos(endpos, fg->indices[fg->filled-1]);
		sPos[0] = GLTYPE(x*endpos[0]);
		sPos[1] = GLTYPE(x*endpos[1]);

		// f(x) = ax^3 + bx^2 + cx + d
		// f(0) = A, f(0.5) = B, f(1) = C, f'(0.5) = D
		// => d = A, a = -4A + 4C - D
		//    b = 8A - 4B - 4C + 1.5D
		//    c = -5A + 4A + C - 0.5D
		float A = bouncePos;
		float B = bouncePos + (handHeight - bouncePos)/6;
		float C = TOFLOAT(endpos[2]);
		float D = 0;
		float a = -4*A + 4*C - D;
		float b = 8*A - 4*B - 4*C + 1.5*D;
		float c = -5*A + 4*B + C - 0.5*D;
		float d = A;
		sPos[2] = F(a*x*x*x + b*x*x + c*x + d);
	}
	multMatrix(matrix2, &bowlMatrices[16*handStart], matrix1);
	spheres->setVertices(num, matrix2);
}

void BantumiGL::setHandPose(float pos) {
	float start = 0;
	float end = 0.65;
	if (pos < 0.5)
		pos /= 0.5;
	else {
		start = 0.65;
		end = 0;
		pos = (pos - 0.5)/0.5;
	}
	for (int i = 0; i < 4; i++) {
		float fact = 1*float(i)/3;
		float pose = fact*pos/0.5;
		if (pos > 0.5) {
			fact = 1*(float(i)+3*(pos-0.5)/0.5)/3;
			pose = fact;
		}

		if (pose < 0)
			pose = 0;
		else if (pose > 1)
			pose = 1;
		pose = start + (end-start)*pose;
		for (int j = 1; j < 4; j++)
			hand->setPose(i*4+j, F(pose));
	}
}

void BantumiGL::doPoint(float pos) {
	handPose = -1;
	hand->setPose(F(pos));
	hand->setPose(1, F(0));
	hand->setPose(2, F(0));
	hand->setPose(3, F(0));
	hand->setPose(17, F(0));
	hand->setPose(18, F(0));
	hand->setPose(19, F(0));
}

void BantumiGL::doAnim(AnimEvent *e, float pos) {
	switch (e->type) {
	case MOVEHAND:
		handEnd = e->moveHand.end;
		handMovePos = pos;
		break;
	case HANDZ:
		handHeight = e->handZ.start + (e->handZ.end - e->handZ.start)*pos;
		break;
	case COLLECTSPHERES:
		collectSpheres(pos);
		break;
	case HANDPOSE:
		handPose = e->handPose.start + (e->handPose.end - e->handPose.start)*pos;
		break;
	case DROP:
		setSphereDrop(e->drop.num, pos, e->drop.bounceHeight);
		break;
	case THINK:
		handPose = -1;
		setHandPose(pos);
		break;
	case PUSH:
		if (pos < 0.5)
			choiceOffset = 1 - pos/0.5;
		else
			choiceOffset = (pos - 0.5)/0.5;
		break;
	case FADE:
		fade = true;
		fadePos = e->fade.start + pos*(e->fade.end - e->fade.start);
		break;
	case POINTHAND:
		doPoint(pos);
		break;
	default:
		break;
	}
}

void BantumiGL::endAnim(AnimEvent *e) {
	switch (e->type) {
	case MOVEHAND:
		handStart = handEnd = e->moveHand.end;
		handMovePos = 0;
		if (!started) {
			selected[selectedLevel] = e->moveHand.end - levelStart[selectedLevel];
		}
		break;
	case HANDZ:
		handHeight = e->handZ.end;
		break;
	case PICKUP:
		doPickUp(e->endTime);
		break;
	case COLLECTSPHERES:
		collectSpheresEnd();
		displayNum[handStart] = 0;
		break;
	case HANDPOSE:
		handPose = e->handPose.end;
		break;
	case DROP:
		setSphereDrop(e->drop.num, 1, e->drop.bounceHeight);
		displayNum[handStart]++;
		break;
	case STARTDROP:
		doDrop(e->startDrop.last, e->endTime);
		break;
	case THINK:
		if (!e->think.stop)
			addThink();
		else
			handPose = 0;
		break;
	case PUSH:
		if (choice == 1)
			doExit = true;
		else
			startFade(1, 0, true);
		break;
	case FADE:
		fadePos = e->fade.end;
		fade = fadePos < 1;
		if (e->fade.setStart)
			doStart = true;
		if (e->fade.initTitle)
			initTitle();
		break;
	case POINTHAND:
		doPoint(1);
		break;
	case TIMEOUT:
		startFade(1, 0, false, true);
		break;
	default:
		break;
	}
}

void BantumiGL::clearAnims() {
	AnimEvent *e = events;
	while (events != NULL) {
		e = e->next;
		delete events;
		events = e;
	}
	lastEvent = NULL;
	events = NULL;
}

void BantumiGL::insertSortedQueue(AnimEvent *&endQueue, AnimEvent *e) {
	AnimEvent *qe = endQueue;
	AnimEvent *prevQueue = NULL;
	while (qe != NULL && qe->endTime <= e->endTime) {
		prevQueue = qe;
		qe = qe->next;
	}
	e->next = qe;
	if (prevQueue)
		prevQueue->next = e;
	else
		endQueue = e;
}

void BantumiGL::updateAnim() {
	AnimEvent *e;
	AnimEvent *endQueue = NULL;
	bool removed;
	do {
		removed = false;
		e = events;
		AnimEvent *last = NULL;
		while (e != NULL) {
			if (relTime >= e->endTime) {
				if (last != NULL)
					last->next = e->next;
				else
					events = e->next;

				if (lastEvent == e)
					lastEvent = last;

				removed = true;

				AnimEvent *next = e->next;
				insertSortedQueue(endQueue, e);

				e = next;
				continue;
			}
			last = e;
			e = e->next;
		}

		if (endQueue) {
			endAnim(endQueue);
			AnimEvent *next = endQueue->next;
			delete endQueue;
			endQueue = next;
		}
	} while (removed || endQueue);

	e = events;
	while (e != NULL) {
		if (relTime >= e->startTime && relTime <= e->endTime) {
			float pos = float(relTime - e->startTime) / (e->endTime - e->startTime);
			doAnim(e, pos);
		}
		e = e->next;
	}
}

int BantumiGL::animStartTime() {
	if (events == NULL)
		return relTime;
	else
		return animEnd;
}

void BantumiGL::moveTo(int bowl) {
	if (animHandPos == bowl) return;

	GLTYPE *startPos = &bowlMatrices[16*animHandPos+12];
	GLTYPE *endPos = &bowlMatrices[16*bowl+12];
	float dist = hypot(TOFLOAT(endPos[0] - startPos[0]), TOFLOAT(endPos[1] - startPos[1]));
	int len = int(MOVELENGTH*dist/bowlSize);
	if (!started)
		len /= 2;

	AnimEvent *event = new AnimEvent();
	event->type = MOVEHAND;
	event->startTime = animStartTime();
	event->endTime = event->startTime + len;
	event->moveHand.end = bowl;
	pushEvent(event);
	animEnd = event->endTime;
	animHandPos = bowl;
}

void BantumiGL::pickUp() {
	int len = PICKUPLENGTH;

	AnimEvent *event = new AnimEvent();
	event->type = PICKUP;
	event->startTime = animStartTime();
	event->endTime = event->startTime;
	pushEvent(event);
	animEnd = event->startTime + 3*len;
}


void BantumiGL::doPickUp(int time) {
	int start = time;
	int len = PICKUPLENGTH;

	float bottom = sphereSize*fillGrid[handStart]->getCeil();

	AnimEvent *e = new AnimEvent();
	e->type = HANDZ;
	e->startTime = start;
	e->endTime = e->startTime + len;
	e->handZ.start = handMaxHeight;
	e->handZ.end = bottom;
	pushEvent(e);

	e = new AnimEvent();
	e->type = COLLECTSPHERES;
	e->startTime = start + len;
	e->endTime = e->startTime + len;
	pushEvent(e);

	e = new AnimEvent();
	e->type = HANDZ;
	e->startTime = start + 2*len;
	e->endTime = e->startTime + len;
	e->handZ.start = bottom;
	e->handZ.end = handMaxHeight;
	pushEvent(e);
}

void BantumiGL::dropLast() {
	int len = DROPLENGTH;
	AnimEvent *e = new AnimEvent();
	e->type = STARTDROP;
	e->startTime = animStartTime();
	e->endTime = e->startTime;
	e->startDrop.last = true;
	pushEvent(e);
	animEnd = e->startTime + 2*len;
}

void BantumiGL::dropAll(int n) {
	for (int i = 0; i < n-1; i++)
		dropOne();
	dropLast();
}

void BantumiGL::dropOne() {
	int len = DROPLENGTH;
	AnimEvent *e = new AnimEvent();
	e->type = STARTDROP;
	e->startTime = animStartTime();
	e->endTime = e->startTime;
	e->startDrop.last = false;
	pushEvent(e);
	animEnd = e->startTime + 3*len;
}

void BantumiGL::doDrop(bool last, int time) {
	int len = DROPLENGTH;

	int num = handSpheres[nHandSpheres-1];
	float bounceHeight = sphereSize/2 + sphereSize*fillGrid[handStart]->getCeil();
	fillGrid[handStart]->add(num);

	AnimEvent *e = new AnimEvent();
	e->type = HANDPOSE;
	e->startTime = time;
	e->endTime = e->startTime + len;
		e->handPose.start = 1;
	if (last)
		e->handPose.end = 0;
	else
		e->handPose.end = 2;
	pushEvent(e);

	e = new AnimEvent();
	e->type = DROP;
	e->startTime = time + 1*len;
	e->endTime = e->startTime + len;
	e->drop.num = num;
	e->drop.bounceHeight = bounceHeight;
	pushEvent(e);

	if (!last) {
		e = new AnimEvent();
		e->type = HANDPOSE;
		e->startTime = time + 2*len;
		e->endTime = e->startTime + len;
		e->handPose.start = 2;
		e->handPose.end = 1;
		pushEvent(e);
	}
}

void BantumiGL::showEnd(int numPlayer, int numComputer) {
	if (numPlayer > numComputer) {
		handPoint();
		moveTo(15);
	} else if (numPlayer < numComputer) {
		handPoint();
		moveTo(16);
	} else {
		moveTo(14);
	}
}

void BantumiGL::startThink() {
	moveTo(14);
	addThink();
}

void BantumiGL::stopThink() {
	AnimEvent *e = events;
	while (e != NULL) {
		if (e->type == THINK)
			e->think.stop = true;
		e = e->next;
	}
}

void BantumiGL::addThink() {
	AnimEvent *e = new AnimEvent();
	e->startTime = animStartTime();
	e->endTime = e->startTime + THINKLOOPLENGTH;
	e->type = THINK;
	e->think.stop = false;
	pushEvent(e);
	animEnd = e->endTime;
}

void BantumiGL::pushChoice() {
	AnimEvent *e = new AnimEvent();
	e->startTime = animStartTime();
	e->endTime = e->startTime + PUSHLENGTH;
	e->type = PUSH;
	pushEvent(e);
	animEnd = e->endTime;
}

void BantumiGL::startFade(float start, float end, bool setStart, bool initTitle) {
	AnimEvent *e = new AnimEvent();
	e->startTime = animStartTime();
	e->endTime = e->startTime + FADELENGTH;
	e->type = FADE;
	e->fade.start = start;
	e->fade.end = end;
	e->fade.setStart = setStart;
	e->fade.initTitle = initTitle;
	pushEvent(e);
	animEnd = e->endTime;
}

void BantumiGL::handPoint() {
	AnimEvent *e = new AnimEvent();
	e->startTime = animStartTime();
	e->endTime = e->startTime + POINTLENGTH;
	e->type = POINTHAND;
	pushEvent(e);
}

void BantumiGL::startTimeout() {
	AnimEvent *e = new AnimEvent();
	e->startTime = animStartTime();
	e->endTime = e->startTime + TIMEOUTLENGTH;
	e->type = TIMEOUT;
	pushEvent(e);
}

void BantumiGL::showTitle() {
	clearAnims();
	if (playedEarlier && started)
		startFade(1, 0, false, true);
	else if (showSplash)
		initSplash();
	else
		initTitle();
}

void BantumiGL::initSplash() {
	delete circle;
	delete bowl;
	delete sphere;
	circle = new CircleMesh(4);
	bowlR1 = initBowlR1;
	bowlR2 = initBowlR2;
	bowl = new BowlMesh(25, true, initBowlR1, initBowlR2, initBowlR3, initBowlH);
#ifdef GLES
	sphere = new SphereMesh(5, 6);
#else
	sphere = new TriSphereMesh(2);
#endif

	delete spheres;
	spheres = new AggregateMesh(4, sphere);
	spheres->setFaces();

	delete bowls;
	bowls = new AggregateMesh(1, bowl);
	bowls->setFaces();

	delete circles;
	circles = new AggregateMesh(0, circle);

	delete [] colors;
	colors = new GLTYPE[4*3];
	for (int i = 0; i < 4; i++) {
		const GLTYPE *color = sphereC1;
		memcpy(&colors[3*i], color, sizeof(GLTYPE)*3);
		spheres->setColor(i, &colors[3*i]);
	}

	nTexts = 0;

	bowls->setColor(0, bowlC3);

	handPose = 0.3;

	nHandSpheres = 0;
	handHeight = 0.7*handMaxHeight;
	handStart = handEnd = 0;
	handMovePos = 0;

	doExit = doStart = false;
	playedEarlier = true;

	fillGrid[0]->reset();
	for (int i = 0; i < 4; i++)
		fillGrid[0]->add(i);

	scaleScenery();

	startTimeout();
}

void BantumiGL::initTitle() {
	started = false;
	showSplash = false;

	delete circle;
	delete bowl;
	delete sphere;
	bowlR1 = initBowlR1;
	bowlR2 = initBowlR2;
#ifdef GLES
	circle = new CircleMesh(8);
	bowl = new BowlMesh(10, true, initBowlR1, initBowlR2, initBowlR3, initBowlH);
	sphere = new TriSphereMesh(0);
#else
	circle = new CircleMesh(20);
#ifdef SCREENSHOT
	bowl = new BowlMesh(50, true, initBowlR1, initBowlR2, initBowlR3, initBowlH);
	sphere = new TriSphereMesh(2);
#else
	bowl = new BowlMesh(20, true, initBowlR1, initBowlR2, initBowlR3, initBowlH);
	sphere = new TriSphereMesh(1);
#endif
#endif
//	sphere = new SphereMesh(10, 20);

	delete spheres;
	spheres = new AggregateMesh(3+4+5, sphere);
	spheres->setFaces();

	delete bowls;
	bowls = new AggregateMesh(3, bowl);
	bowls->setFaces();

	delete circles;
	circles = new AggregateMesh(levelLen[1], circle);
	circles->setFaces();

	int cursphere = 0;
	for (int i = 0; i < 3; i++) {
		fillGrid[i]->reset();
		for (int j = 0; j < i+3; j++)
			fillGrid[i]->add(cursphere++);
	}

	delete [] colors;
	colors = new GLTYPE[(3+4+5)*3];
	for (int i = 0; i < 3+4+5; i++) {
		const GLTYPE *color = sphereC1;
		memcpy(&colors[3*i], color, sizeof(GLTYPE)*3);
		spheres->setColor(i, &colors[3*i]);
	}

	for (int i = 0; i < 3; i++)
		bowls->setColor(i, bowlC3);

	doPoint(1);

	selectedLevel = 0;

	handHeight = sphereSize;
	nHandSpheres = 0;
	animHandPos = handStart = handEnd = levelStart[selectedLevel] + selected[selectedLevel];
	handMovePos = 0;
	choice = -1;

	for (int i = 0; i < diffLevels; i++)
		displayNum[i] = i+1;
	nTexts = diffLevels;
	choiceOffset = 1;


	doExit = doStart = false;

	scaleScenery();

	if (playedEarlier)
		startFade(0, 1, false);
}

bool BantumiGL::start() {
	return doStart;
}

bool BantumiGL::exit() {
	return doExit;
}

int BantumiGL::getNum() {
	return selected[0]+3;
}

int BantumiGL::getLevel() {
	return selected[1]+1;
}

void BantumiGL::setLevel(int l) {
	selected[1] = l-1;
	if (selected[1] >= levelLen[1])
		selected[1] = levelLen[1]-1;
	if (selected[1] < 0)
		selected[1] = 0;
	if (!showSplash) {
		clearAnims();
		animHandPos = handStart = handEnd = levelStart[selectedLevel] + selected[selectedLevel];
	}
}

void BantumiGL::setNum(int n) {
	selected[0] = n-3;
	if (selected[0] >= levelLen[0])
		selected[0] = levelLen[0]-1;
	if (selected[0] < 0)
		selected[0] = 0;
	if (!showSplash) {
		clearAnims();
		animHandPos = handStart = handEnd = levelStart[selectedLevel] + selected[selectedLevel];
	}
}

void BantumiGL::pressed(Key key) {
	if (showSplash) {
		if (!fade) {
			clearAnims();
			startFade(1, 0, false, true);
		}
		return;
	}
	if (animating()) return;
	if (key == LEFT && selected[selectedLevel]-1 >= 0)
		moveTo(levelStart[selectedLevel] + selected[selectedLevel]-1);
	if (key == RIGHT && selected[selectedLevel]+1 < levelLen[selectedLevel])
		moveTo(levelStart[selectedLevel] + selected[selectedLevel]+1);
	if (key == DOWN && selectedLevel+1 < 3) {
		selectedLevel++;
		moveTo(levelStart[selectedLevel] + selected[selectedLevel]);
	}
	if (key == UP && selectedLevel-1 >= 0) {
		selectedLevel--;
		moveTo(levelStart[selectedLevel] + selected[selectedLevel]);
	}
	if (key == SELECT) {
		if (selectedLevel == 2) {
			choice = selected[2];
			pushChoice();
		} else {
			choice = 0;
			pushChoice();
		}
	}
	if (key == START) {
		choice = 0;
		pushChoice();
	}
	if (key == ESCAPE) {
		choice = 1;
		pushChoice();
	}
}

int BantumiGL::click(int x, int y) {
	if (!started && showSplash) {
		pressed(START);
		return -1;
	}
	draw(lastTime, true);
	unsigned char rgba[4];
	glReadPixels(x, height - y - 1, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, rgba);
	lastFade = true; // redraw the whole screen
	int diff = 255/3;
	diff /= 3;
	int rIndex = -1, gIndex = -1, bIndex = -1;
	for (int i = 0; i < 4; i++) {
		if (abs(rgba[0] - 255*i/3) < diff) {
			rIndex = i;
			break;
		}
	}
	for (int i = 0; i < 4; i++) {
		if (abs(rgba[1] - 255*i/3) < diff) {
			gIndex = i;
			break;
		}
	}
	for (int i = 0; i < 4; i++) {
		if (abs(rgba[2] - 255*i/3) < diff) {
			bIndex = i;
			break;
		}
	}
	if (rIndex < 0 || gIndex < 0 || bIndex < 0) {
		printf("bad color\n");
		return -1;
	}
	int index = (rIndex << 4) | (gIndex << 2) | bIndex;
	if (index == 0)
		return -1;
	index--;
	if (!started && !showSplash) {
		for (int i = 0; i < 3; i++) {
			if (index >= levelStart[i] && index < levelStart[i] + levelLen[i]) {
				if (selectedLevel == i && selected[selectedLevel] == index - levelStart[i]) {
					choice = selected[2];
					pushChoice();
				} else {
					selectedLevel = i;
					selected[selectedLevel] = index - levelStart[i];
					moveTo(index);
				}
				break;
			}
		}
	}
	return index;
}


