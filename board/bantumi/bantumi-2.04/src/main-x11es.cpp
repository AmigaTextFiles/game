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

#include "window.h"
#include "bantumi.h"
#include "bantumigl.h"
#include "glfont.h"
#include <sys/time.h>
#include <unistd.h>
#include <stdio.h>
#include <GLES/gl.h>

#define WIDTH 176
#define HEIGHT 208

int main(int argc, char *argv[]) {
	createEGLWindow(WIDTH, HEIGHT, "ESKnot");
	BantumiGL *fe = new BantumiGL(WIDTH, HEIGHT);
	GLFont *f = makeGLFont("", 0, 0, 0, 0, 0);
	fe->setNumFont(f);
	fe->setTextFont(f);
	Bantumi *b = new Bantumi(fe);
	while (1) {
		struct timeval tv;
		gettimeofday(&tv, NULL);
		unsigned int msec = tv.tv_sec*1000 + tv.tv_usec/1000;
		b->update();
		fe->draw(msec);
		glFlush();
		postEGLWindow();
		usleep(1000*10);
	}
	delete b;
	delete fe;
	delete f;
	return 0;
}

