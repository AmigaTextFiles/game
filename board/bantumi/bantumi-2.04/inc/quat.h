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

#ifndef __QUAT_H
#define __QUAT_H

#include "glwrapper.h"

void matrixToAAf(float *aa, const float *matrix);
void matrixToQuatf(float *quat, const float *matrix);
void quatInvf(float *out, const float *in);
void quatConjf(float *out, const float *in);
void quatMulf(float *out, const float *q1, const float *q2);
void quatToAAf(float *out, const float *in);
void quatToMatrixf(float *matrix, const float *quat);
void aaToQuatf(float *out, const float *in);
void aaToMatrixf(float *out, const float *in);

void matrixToAAx(GLfixed *aa, const GLfixed *matrix);
void matrixToQuatx(GLfixed *quat, const GLfixed *matrix);
void quatInvx(GLfixed *out, const GLfixed *in);
void quatConjx(GLfixed *out, const GLfixed *in);
void quatMulx(GLfixed *out, const GLfixed *q1, const GLfixed *q2);
void quatToAAx(GLfixed *out, const GLfixed *in);
void quatToMatrixx(GLfixed *matrix, const GLfixed *quat);
void aaToQuatx(GLfixed *out, const GLfixed *in);
void aaToMatrixx(GLfixed *out, const GLfixed *in);

void matrixInterpf(float *out, const float *m1, const float *m2, float pos);
void matrixInterpx(GLfixed *out, const GLfixed *m1, const GLfixed *m2, GLfixed pos);

#endif
