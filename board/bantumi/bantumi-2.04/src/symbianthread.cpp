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
#include <e32base.h>
#include <stdlib.h>
#include <time.h>

class Thread {
public:
	RThread thread;
	void (*fn)(void*);
	void *arg;
	bool finished;
};

static TInt threadInit(TAny *aPtr) {
	Thread *t = (Thread*) aPtr;
	CTrapCleanup* cleanup = CTrapCleanup::New();
	srand(time(NULL));
	t->fn(t->arg);
	CloseSTDLIB();
	delete cleanup;
	t->finished = true;
	return 0;
}

void *startThread(void (*fn)(void*), void *arg) {
	Thread *t = new Thread();
	t->fn = fn;
	t->arg = arg;
	_LIT(KName, "Bantumi AI thread");
	User::LeaveIfError(t->thread.Create(KName, threadInit, KDefaultStackSize, NULL, t));
	t->finished = false;
	t->thread.Resume();
	return t;
}

void joinThread(void *id) {
	Thread *t = (Thread*) id;
	while (!t->finished)
		threadSleep(5);
	t->thread.Close();
	delete t;
}

void threadSleep(int msec) {
	User::After(1000*msec);
}

void yield() {
	User::After(1);
}


