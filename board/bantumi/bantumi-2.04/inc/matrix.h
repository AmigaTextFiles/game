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

#ifndef __MATRIX_H
#define __MATRIX_H

#include "glwrapper.h"

void invertMatrixf(float *out, const float *in);
void multMatrixf(float *out, const float *m1, const float *m2);
void multVect3f(float *out, const float *m, const float *v, float w);
void multVect4f(float *out, const float *m, const float *v);
void printMatrixf(const float *m);
void invertMatrixx(GLfixed *out, const GLfixed *in);
void multMatrixx(GLfixed *out, const GLfixed *m1, const GLfixed *m2);
void multVect3x(GLfixed *out, const GLfixed *m, const GLfixed *v, GLfixed w);
void multVect4x(GLfixed *out, const GLfixed *m, const GLfixed *v);
void printMatrixx(const GLfixed *m);

void printVect4f(const float *m);
void printVect3f(const float *m);
void printVect4x(const GLfixed *m);
void printVect3x(const GLfixed *m);

#endif
