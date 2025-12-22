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

#include "bantumi.h"
#include <stdlib.h>
#include <stdio.h>
#include "thread.h"
#include <string.h>
#include "gui.h"

static const unsigned char headerData[] = "Bantumi\r\n";
#define HEADER_LENGTH() strlen((const char*) headerData)

static void threadWrapper(void *arg) {
	Bantumi *b = (Bantumi*) arg;
	b->threadMain();
}

Bantumi::Bantumi(BantumiFrontEnd *fe) {
	frontEnd = fe;
	started = false;
	frontEnd->showTitle();
	stopThread = false;
	thinkingStarted = false;
	thinkingDone = false;
	aiThread = startThread(threadWrapper, this);
	conn = NULL;
}

void Bantumi::init(int n) {
	started = true;
	frontEnd->init(n);
	for (int i = 0; i < 14; i++)
		num[i] = ((i%7)<6) ? n : 0;
	if (!multiplayer) {
		selected = 0;
		playerStart = 0;
	}
//	playerTurn = true;
	playerTurn = rand()%2;
	gameOver = false;
	thinkingStarted = false;
	thinkingDone = false;
	paused = false;
}

Bantumi::~Bantumi() {
	stopThread = true;
	joinThread(aiThread);
}

void Bantumi::setPaused(bool p) {
	paused = p;
}

void Bantumi::threadMain() {
	while (!stopThread) {
		if (thinkingStarted && !thinkingDone) {
			doChoice();
			thinkingDone = true;
		} else
			threadSleep(50);
	}
}

static int calcOneSide(int first, int end, int *curNum) {
	int sum = 0;
	for (int i = first; i < end; i++) {
		if (curNum[i] > 0) {
			int endbowl1 = i + curNum[i];
			if (endbowl1 < end && curNum[endbowl1] == 0)
				// ends in empty bowl on own side
				sum += 1 + curNum[12 - endbowl1];
			else if ((endbowl1 + 1)%14 >= first && (curNum[endbowl1 + 1] == 0 || curNum[i] == 13))
				// ends in empty bowl on own side
				sum += 1 + curNum[12 - endbowl1] + 1;
			else if (curNum[i] <= end - i)
				// ends in own end bowl or before
				sum += curNum[i];
			else if (curNum[i] - (end-i) > 6)
				// ends on own side
				sum += (end - i) - 6 + (curNum[i] - (end - i) - 6);
			else
				// ends on opponent side
				sum += (end - i) - (curNum[i] - (end - i));
		}

	}
	sum += 2*curNum[end];
	return sum;
}

static int calcOneSideSimple(int first, int end, int *curNum) {
	int sum = 0;
/*	for (int i = first; i < end; i++) {
		if (curNum[i] == end - i)
			sum++;
		if (curNum[i] == 13)
			sum++;
		sum += curNum[i];
	}
*/	sum += 2*curNum[end];
	return sum;
}

void Bantumi::doChoice() {
	if (aiLevel == 1)
		randomAI();
	else {
		int ply[] = { 0, 5, 7, 9 };
#ifndef SYMBIAN
		ply[3] = 14;
#endif
		aiFunc = calcOneSideSimple;
		if (aiLevel-1 >= 3)
			aiFunc = calcOneSide;
		memcpy(numStack, num, sizeof(int)*14);
		aiCounter = 0;
		minMaxAI(-1000, 1000, false, 0, ply[aiLevel-1]);
		choice = choiceStack[0];
	}
}

int Bantumi::minMaxAI(int alpha, int beta, bool player, int level, int ply) {
	if (!started) return 0; // user aborted

	int *curNum = &numStack[14*level];
	int first = 0;
	if (!player)
		first = 7;
	int end = first + 6;

	if (checkEnd(player, curNum, false) || ply == 0) {
		int sum = 0;

		int mysum = aiFunc(first, end, curNum);
		int otherfirst = (first + 7)%14;
		int otherend = otherfirst + 6;
		int othersum = aiFunc(otherfirst, otherend, curNum);

		if (player) {
			sum = othersum - mysum;
			return -sum;
		} else {
			sum = mysum - othersum;
			return sum;
		}
	}

	int value = alpha;
	int *nextNum = &numStack[14*(level+1)];
	for (int i = first; i < end && value < beta; i++) {
		if (!started) return 0; // user aborted

		if (curNum[i] == 0) continue;
		memcpy(nextNum, curNum, sizeof(int)*14);
		bool cont = doMove(i, nextNum, false);
		int curvalue;
		if (cont)
			curvalue = minMaxAI(value, beta, player, level+1, ply-1);
		else
			curvalue = -minMaxAI(-beta, -value, !player, level+1, ply-1);

		if (curvalue > value) {
			choiceStack[level] = i;
			value = curvalue;
		}

		aiCounter++;
		if (aiCounter % 500 == 0) {
			yield();
			while (paused)
				threadSleep(50);
		}
	}
	return value;
}

void Bantumi::randomAI() {
	int bowl;
	do {
		bowl = 7 + rand()%6;
	} while (num[bowl] == 0);
	choice = bowl;
}

void Bantumi::update() {
	if (closeConnection && conn) {
		delete conn;
		conn = NULL;
	}
	if (conn && connInited) {
		const char *err;
		if (!conn->read(&err)) {
			if (err == NULL)
				err = "Read error";
		} else if (conn->ready(&err) <= 0) {
			if (err == NULL)
				err = "Connection not ready";
		} else {
			err = NULL;
		}

		if (started) {
			if (gameOver && receivedGameOver) {
				delete conn;
				conn = NULL;
				return;
			}
		}
		if (err) {
			handleCommErr(err);
			return;
		}
	}
	if (started) {
		if (gameOver) return;
		if (!playerTurn && !multiplayer) {
			if (!thinkingStarted) {
				if (frontEnd->animating()) return;
				frontEnd->startThink();
				thinkingStarted = true;
			} else {
				if (thinkingDone) {
					thinkingStarted = false;
					thinkingDone = false;
					frontEnd->stopThink();
					frontEnd->moveTo(choice);
					doAction(choice);
				} else {
					threadSleep(50);
				}
			}
		}
	} else {
		if (conn) {
			const char *err;
			int retval = conn->ready(&err);
			if (retval < 0) {
				handleCommErr(err);
				return;
			}
			if (retval == 0) return;
			if (!connInited) {
				sendHeader();
				connInited = true;
				return;
				// proceed on next update, check for potential errors again
/*				if (!conn) {
					// send failed
					return;
				}
*/
			}
			if (receivedHeader) {
				if (!conn->isClient()) {
					selected = 0;
					playerStart = selected;
					init(frontEnd->getNum());
					sendInit(frontEnd->getNum(), !playerTurn);
				}
			}
			return;
		} else if (frontEnd->start()) {
			if (frontEnd->getLevel() >= 5) {
				conn = showMultiplayerDialog();
				frontEnd->resetLastTime();
				if (conn) {
					conn->setCallback(this);
					closeConnection = false;
					receivedGameOver = false;
					receiveBufferPos = 0;
					receivedHeader = false;
					closeConnection = false;
					connInited = false;
					multiplayer = true;
					selected = 7;
					playerStart = selected;
				} else {
					frontEnd->showTitle();
				}
			} else {
				multiplayer = false;
				init(frontEnd->getNum());
				aiLevel = frontEnd->getLevel();
			}
		}
	}
}

int Bantumi::opposite(int n) {
	return 12-n;
}

bool Bantumi::doMove(int n, int *data, bool anim) {
	int start = (n/7)*7;
	int end = start + 6;
	int oppend = (end + 7)%14;
	if (anim)
		frontEnd->pickUp();
	int objs = data[n];
	data[n] = 0;
	for (int i = 0; i < objs; i++) {
		n++;
		n = n%14;
		if (n == oppend)
			n = (n+1)%14;
		if (anim)
			frontEnd->moveTo(n);
		bool last = i+1 == objs;
		data[n]++;
		if (last) {
			if (anim)
				frontEnd->dropLast();
			if (data[n] == 1 && n >= start && n < end) {
				data[end] += 1;
				data[n] = 0;
				if (anim) {
					frontEnd->pickUp();
					frontEnd->moveTo(end);
					frontEnd->dropAll(1);
				}

				int opp = opposite(n);
				if (data[opp] > 0) {
					if (anim) {
						frontEnd->moveTo(opp);
						frontEnd->pickUp();
						frontEnd->moveTo(end);
						frontEnd->dropAll(data[opp]);
					}
					data[end] += data[opp];
					data[opp] = 0;
				}
			}
		} else {
			if (anim)
				frontEnd->dropOne();
		}
	}
	return n == end;
}

bool Bantumi::checkEnd(bool player, int *data, bool anim) {
	int start = (player) ? 0 : 7;
	int end = start + 6;
	bool empty1 = true;
	for (int i = start; i < end; i++) {
		if (data[i] > 0) {
			empty1 = false;
			break;
		}
	}
	int oppstart = (start + 7)%14;
	int oppend = oppstart + 6;
	bool empty2 = true;
	for (int i = oppstart; i < oppend; i++) {
		if (data[i] > 0) {
			empty2 = false;
			break;
		}
	}
	if (!empty1 && !empty2) return false;
	for (int i = 0; i < 14; i++) {
		if ((i%7) == 6) continue;
		int curend = 7*(i/7) + 6;
		if (data[i] > 0) {
			if (anim) {
				frontEnd->moveTo(i);
				frontEnd->pickUp();
				frontEnd->moveTo(curend);
				frontEnd->dropAll(data[i]);
			}
			data[curend] += data[i];
			data[i] = 0;
		}
	}
	return true;
}

void Bantumi::doAction(int n) {
	bool cont = doMove(n, num, true);
	if (!cont)
		playerTurn = !playerTurn;
	if (checkEnd(playerTurn, num, true)) {
		gameOver = true;
		frontEnd->showEnd(num[6], num[13]);
		sendGameOver();
		if (receivedGameOver) {
			delete conn;
			conn = NULL;
		}
	} else {
		if (playerTurn) {
			frontEnd->moveTo(selected);
			sendMoveTo(selected);
		}
	}
}

void Bantumi::pressed(Key key) {
	if (key == ESCAPE && (started || conn)) {
		if (conn) {
			delete conn;
			conn = NULL;
		}
		started = false;
		frontEnd->showTitle();
		return;
	}
	if (!started) {
		frontEnd->pressed(key);
		return;
	}

	if (gameOver) {
		if (frontEnd->animating()) return;
		if (!(multiplayer && !receivedGameOver)) {
			frontEnd->showTitle();
			started = false;
		}
		return;
	}

	if (!playerTurn) return;
	if (frontEnd->animating()) return;

	if (key == LEFT || key == UP || key == RIGHT || key == DOWN) {
		if (playerStart == 0) {
			if (key == LEFT || key == UP)
				selected--;
			if (key == RIGHT || key == DOWN)
				selected++;
		} else {
			if (key == LEFT || key == UP)
				selected++;
			if (key == RIGHT || key == DOWN)
				selected--;
		}
		if (selected < playerStart)
			selected = playerStart;
		if (selected >= playerStart + 6)
			selected = playerStart + 5;
		sendMoveTo(selected);
		if (!started) return; // send error
		frontEnd->moveTo(selected);
	} else if (key == SELECT || key == START) {
		if (num[selected] == 0) return;
		sendDoAction(selected);
		if (!started) return; // send error
		doAction(selected);
	}
}

void Bantumi::click(int x, int y) {
	int hit = frontEnd->click(x, y);
	if (started && playerTurn && !frontEnd->animating()) {
		if (hit >= playerStart && hit < playerStart + 6) {
			if (selected == hit) {
				pressed(SELECT);
			} else {
				selected = hit;
				sendMoveTo(selected);
				if (!started) return; // send error
				frontEnd->moveTo(selected);
			}
		}
	}
}

bool Bantumi::exit() {
	if (started) return false;
	return frontEnd->exit();
}

void Bantumi::handleCommErr(const char *err) {
	showWarning(err);
	delete conn;
	conn = NULL;
	frontEnd->resetLastTime();
	frontEnd->showTitle();
	started = false;
}

void Bantumi::handleRecvErr(const char *err) {
	showWarning(err);
	frontEnd->resetLastTime();
	frontEnd->showTitle();
	started = false;
	closeConnection = true;
}

void Bantumi::sendData(const unsigned char *ptr, int n) {
	if (!conn) return;
	const char *err;
	if (!conn->write(ptr, n, &err)) {
		handleCommErr(err);
	}
}

void Bantumi::sendHeader() {
	sendData(headerData, HEADER_LENGTH());
}

void Bantumi::sendInit(int i, bool turn) {
	unsigned char buf[3] = { 'I', i, (turn ? 1 : 0) };
	sendData(buf, 3);
}

void Bantumi::sendMoveTo(int i) {
	unsigned char buf[2] = { 'M', i };
	sendData(buf, 2);
}

void Bantumi::sendDoAction(int i) {
	unsigned char buf[2] = { 'A', i };
	sendData(buf, 2);
}

void Bantumi::sendGameOver() {
	unsigned char buf[2] = { 'G', 'O' };
	sendData(buf, 2);
}

bool Bantumi::parseReceiveBuffer() {
	int used = 0;
	if (!receivedHeader) {
		if (receiveBufferPos < int(HEADER_LENGTH()))
			return false;
		if (memcmp(receiveBuffer, headerData, HEADER_LENGTH()) != 0) {
			handleRecvErr("Bad peer");
			return false;
		}
		used = HEADER_LENGTH();
		receivedHeader = true;
	} else {
		if (receiveBufferPos < 2)
			return false;
		used = 2;
		if (receiveBuffer[0] == 'M') {
			frontEnd->moveTo(receiveBuffer[1]);
		} else if (receiveBuffer[0] == 'A') {
			doAction(receiveBuffer[1]);
		} else if (receiveBuffer[0] == 'I') {
			if (receiveBufferPos < 3)
				return false;
			used = 3;
			init(receiveBuffer[1]);
			playerTurn = receiveBuffer[2];
			if (playerTurn) {
				frontEnd->moveTo(selected);
				sendMoveTo(selected);
			}
		} else if (receiveBuffer[0] == 'G') {
			if (receiveBuffer[1] != 'O') {
				handleRecvErr("Bad peer");
				return false;
			} else {
				receivedGameOver = true;
			}
		} else {
			handleRecvErr("Bad peer");
			return false;
		}
	}
	int pos = used;
	unsigned char *ptr = receiveBuffer;
	while (pos < receiveBufferPos)
		*ptr++ = receiveBuffer[pos++];
	receiveBufferPos -= used;
	return true;
}

void Bantumi::received(const unsigned char *ptr, int n) {
	if (closeConnection) return;
	const unsigned char *end = ptr+n;
	while (receiveBufferPos < int(sizeof(receiveBuffer)/sizeof(receiveBuffer[0])) && ptr < end)
		receiveBuffer[receiveBufferPos++] = *ptr++;
	if (receiveBufferPos == sizeof(receiveBuffer)/sizeof(receiveBuffer[0])) {
		handleRecvErr("Peer sending bad data");
		return;
	}
	while (parseReceiveBuffer() && !closeConnection);
}

