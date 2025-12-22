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

#include "thread.h"
#include <SDL.h>
#include <SDL_thread.h>

class Params {
public:
	void (*fn)(void*);
	void *arg;
};

static int threadInit(void *arg) {
	Params *p = (Params*) arg;
	p->fn(p->arg);
	delete p;
	return 0;
}

void *startThread(void (*fn)(void*), void *arg) {
	Params *p = new Params();
	p->fn = fn;
	p->arg = arg;
	SDL_Thread *thread = SDL_CreateThread(threadInit, p);
	return thread;
}

void joinThread(void *id) {
	SDL_Thread *thread = (SDL_Thread*) id;
	int result;
	SDL_WaitThread(thread, &result);
}

void threadSleep(int msec) {
	SDL_Delay(msec);
}

void yield() {
//	SDL_Delay(1);
}


