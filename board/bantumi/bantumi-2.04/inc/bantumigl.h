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

#ifndef __BANTUMIGL_H
#define __BANTUMIGL_H

#include "bantumi.h"
#include "glwrapper.h"

class Hand;
class Mesh;
class Grid;
class FillGrid;
class AggregateMesh;
class AnimEvent;
class GLFont;

class BantumiGL : public BantumiFrontEnd {
public:
	BantumiGL(int w, int h);
	~BantumiGL();

	void reinitGL(int w, int h);
	void draw(int time, bool pick = false);

	void setNumFont(GLFont *f);
	void setTextFont(GLFont *f);

	// BantumiFrontEnd
	void init(int num);
	bool animating();
	void moveTo(int bowl);
	void pickUp();
	void dropLast();
	void dropAll(int n);
	void dropOne();
	void showEnd(int numPlayer, int numComputer);
	void startThink();
	void stopThink();
	void showTitle();
	bool start();
	int getNum();
	int getLevel();
	void pressed(Key key);
	int click(int x, int y);
	bool exit();

	void setLevel(int l);
	void setNum(int n);

	void useScissor(bool s);

	void resetLastTime();

private:
	int width, height;
	float zNear, zFar;
	float xMax, yMax;
	float longEdge, shortEdge;

	Hand *hand;
	Mesh *sphere;
	Mesh *bowl;
	AggregateMesh *bowls;
	AggregateMesh *spheres;
	float bowlSize, bowlHeight;
	float bowlR1, bowlR2;
	GLTYPE bowlMatrices[16*17];
	Grid *grid;
	FillGrid *fillGrid[14];
	float sphereSize;
	GLTYPE *colors;
	GLTYPE handMatrix[16];
	int displayNum[14];
	GLTYPE projMatrix[16];
	GLTYPE origProjMatrix[16];
	int nTexts;

	bool fade;
	float fadePos;
	bool lastFade;
	int lastDisplayNum[14];
	GLTYPE lastHandCorner[12];
	bool scissor;

	void setProjMatrix(float l, float r, float b, float t, float n, float f);
	void project(GLTYPE *out, const GLTYPE *pos);
	GLFont *numFont;
	GLFont *textFont;
	GLTYPE *textPos;

	GLTYPE titlePos[3];
	float titleHeight;
	float subtitleHeight;
	GLTYPE subtitlePos1[3];
	GLTYPE subtitlePos2[3];
	GLTYPE subtitlePos22[3];
	GLTYPE subtitlePos3[3];
	float choiceOffset;
	int choice;
	void dim(GLTYPE *pos, float w, float h, float fact);
	void dim(int x1, int y1, int x2, int y2, float fact);
	void drawPickRect(GLTYPE width, GLTYPE height, GLTYPE x, GLTYPE y, GLTYPE z, int index);
	int selected[3];
	int selectedLevel;
	int levelStart[3], levelLen[3];
	bool doExit, doStart;
	bool playedEarlier;
	int diffLevels;
	bool multiplayer;

	Mesh *circle;
	AggregateMesh *circles;
	float circleSize;

	bool started;
	bool showSplash;

	float handMovePos;
	int handStart, handEnd;
	float handPose;
	float handHeight;
	float handMaxHeight;

	void scaleScenery();
	void makeBowlMatrices();
	void updateBowlsSpheres();

	int lastTime;
	int relTime;
	int animEnd;
	int animHandPos;

	AnimEvent* events;
	AnimEvent* lastEvent;
	void updateAnim();
	void pushEvent(AnimEvent *e);
	int animStartTime();
	void clearAnims();
	void insertSortedQueue(AnimEvent *&endQueue, AnimEvent *e);

	void doPickUp(int time);
	void collectSpheres(float pos);
	void collectSpheresEnd();
	int *handSpheres;
	int nHandSpheres;
	void doDrop(bool last, int time);
	void setSphereDrop(int num, float pos, float height);
	void doAnim(AnimEvent *e, float pos);
	void endAnim(AnimEvent *e);
	void addThink();
	void setHandPose(float pos);
	void pushChoice();
	void startFade(float start, float end, bool setStart = false, bool initTitle = false);
	void handPoint();
	void doPoint(float pos);

	void initTitle();
	void initSplash();
	void startTimeout();
};


#endif
