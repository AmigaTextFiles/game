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

#ifndef __BANTUMI_H
#define __BANTUMI_H

#include "connection.h"

enum Key { UP, DOWN, LEFT, RIGHT, SELECT, START, ESCAPE };

class BantumiFrontEnd {
public:
	virtual ~BantumiFrontEnd() {}
	virtual void init(int num) = 0;
	virtual bool animating() = 0;
	virtual void moveTo(int bowl) = 0;
	virtual void pickUp() = 0;
	virtual void dropLast() = 0;
	virtual void dropAll(int n) = 0;
	virtual void dropOne() = 0;
	virtual void showEnd(int numPlayer, int numComputer) = 0;
	virtual void startThink() = 0;
	virtual void stopThink() = 0;
	virtual void showTitle() = 0;
	virtual bool start() = 0;
	virtual int getNum() = 0;
	virtual int getLevel() = 0;
	virtual void pressed(Key key) = 0;
	virtual int click(int x, int y) = 0;
	virtual bool exit() = 0;
	virtual void resetLastTime() = 0;
};

class Bantumi : public ReadCallback {
public:
	Bantumi(BantumiFrontEnd *fe);
	~Bantumi();

	void pressed(Key k);
	void click(int x, int y);
	void update();
	bool exit();

	void threadMain();

	void setPaused(bool p);

private:
	BantumiFrontEnd* frontEnd;
	bool playerTurn;
	int num[14];
	int selected;
	bool gameOver;
	bool started;
	bool paused;
	int playerStart;

	bool multiplayer;
	bool receivedGameOver;
	bool receivedHeader;
	bool connInited;

	int aiLevel;
	void *aiThread;
	int choice;
	bool thinkingStarted;
	bool thinkingDone;
	bool stopThread;

	void init(int n);
	int opposite(int n);
	bool doMove(int n, int *data, bool anim);
	bool checkEnd(bool player, int *data, bool anim);
	void doAction(int n);

	void doChoice();
	void randomAI();
	int minMaxAI(int alpha, int beta, bool player, int level, int ply);

	int numStack[14*200];
	int choiceStack[200];
	int aiCounter;
	int (*aiFunc)(int, int, int*);

	Connection *conn;
	unsigned char receiveBuffer[150];
	int receiveBufferPos;
	bool closeConnection;

	void handleCommErr(const char *err);
	void handleRecvErr(const char *err);
	void sendData(const unsigned char *ptr, int n);
	void sendHeader();
	void sendInit(int i, bool turn);
	void sendMoveTo(int i);
	void sendDoAction(int i);
	void sendGameOver();
	bool parseReceiveBuffer();
	void received(const unsigned char *ptr, int n);
};


#endif
