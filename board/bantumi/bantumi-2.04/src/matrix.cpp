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

#include "matrix.h"
#include <string.h>
#include <stdio.h>

void multMatrixf(float *out, const float *m1, const float *m2) {
	for (int i = 0; i < 4; i++) {
		for (int j = 0; j < 4; j++) {
			out[4*i+j] = 0;
			for (int k = 0; k < 4; k++)
				out[4*i+j] += m1[4*k+j]*m2[4*i+k];
		}
	}
}

void multMatrixx(GLfixed *out, const GLfixed *m1, const GLfixed *m2) {
	for (int i = 0; i < 4; i++) {
		for (int j = 0; j < 4; j++) {
			out[4*i+j] = 0;
			for (int k = 0; k < 4; k++)
				out[4*i+j] += FIXMUL2(m1[4*k+j], m2[4*i+k]);
		}
	}
}

void invertMatrixf(float *out, const float *in) {
	float T[16], R[16];
	memset(T, 0, sizeof(T));
	memset(R, 0, sizeof(R));
	T[0] = T[5] = T[10] = T[15] = 1;
	R[15] = 1;
	for (int i = 0; i < 3; i++)
		for (int j = 0; j < 3; j++)
			R[4*i+j] = in[4*j+i];
	T[12] = -in[12];
	T[13] = -in[13];
	T[14] = -in[14];
	multMatrixf(out, R, T);
}

void invertMatrixx(GLfixed *out, const GLfixed *in) {
	GLfixed T[16], R[16];
	memset(T, 0, sizeof(T));
	memset(R, 0, sizeof(R));
	T[0] = T[5] = T[10] = T[15] = TOFIX(1);
	R[15] = TOFIX(1);
	for (int i = 0; i < 3; i++)
		for (int j = 0; j < 3; j++)
			R[4*i+j] = in[4*j+i];
	T[12] = -in[12];
	T[13] = -in[13];
	T[14] = -in[14];
	multMatrixx(out, R, T);
}

void multVect3f(float *out, const float *m, const float *v, float w) {
	for (int i = 0; i < 3; i++) {
		out[i] = w*m[12+i];
		for (int j = 0; j < 3; j++)
			out[i] += m[4*j+i]*v[j];
	}
}

void multVect3x(GLfixed *out, const GLfixed *m, const GLfixed *v, GLfixed w) {
	for (int i = 0; i < 3; i++) {
		out[i] = FIXMUL(w, m[12+i]);
		for (int j = 0; j < 3; j++)
			out[i] += FIXMUL(m[4*j+i], v[j]);
	}
}

void multVect4f(float *out, const float *m, const float *v) {
	for (int i = 0; i < 4; i++) {
		out[i] = 0;
		for (int j = 0; j < 4; j++)
			out[i] += m[4*j+i]*v[j];
	}
}

void multVect4x(GLfixed *out, const GLfixed *m, const GLfixed *v) {
	for (int i = 0; i < 4; i++) {
		out[i] = 0;
		for (int j = 0; j < 4; j++)
			out[i] += FIXMUL(m[4*j+i], v[j]);
	}
}

void printMatrixf(const float *m) {
	printf("[%.3f %.3f %.3f %.3f]\n", m[0], m[4], m[8], m[12]);
	printf("[%.3f %.3f %.3f %.3f]\n", m[1], m[5], m[9], m[13]);
	printf("[%.3f %.3f %.3f %.3f]\n", m[2], m[6], m[10], m[14]);
	printf("[%.3f %.3f %.3f %.3f]\n", m[3], m[7], m[11], m[15]);
	printf("\n");
}

void printMatrixx(const GLfixed *m) {
	printf("[%.3f %.3f %.3f %.3f]\n", FIXTOFLOAT(m[0]), FIXTOFLOAT(m[4]), FIXTOFLOAT(m[8]), FIXTOFLOAT(m[12]));
	printf("[%.3f %.3f %.3f %.3f]\n", FIXTOFLOAT(m[1]), FIXTOFLOAT(m[5]), FIXTOFLOAT(m[9]), FIXTOFLOAT(m[13]));
	printf("[%.3f %.3f %.3f %.3f]\n", FIXTOFLOAT(m[2]), FIXTOFLOAT(m[6]), FIXTOFLOAT(m[10]), FIXTOFLOAT(m[14]));
	printf("[%.3f %.3f %.3f %.3f]\n", FIXTOFLOAT(m[3]), FIXTOFLOAT(m[7]), FIXTOFLOAT(m[11]), FIXTOFLOAT(m[15]));
	printf("\n");
}

void printVect4f(const float *v) {
	printf("[%.3f %.3f %.3f %.3f]\n", v[0], v[1], v[2], v[3]);
}

void printVect3f(const float *v) {
	printf("[%.3f %.3f %.3f]\n", v[0], v[1], v[2]);
}

void printVect4x(const GLfixed *v) {
	printf("[%.3f %.3f %.3f %.3f]\n", FIXTOFLOAT(v[0]), FIXTOFLOAT(v[1]), FIXTOFLOAT(v[2]), FIXTOFLOAT(v[3]));
}

void printVect3x(const GLfixed *v) {
	printf("[%.3f %.3f %.3f]\n", FIXTOFLOAT(v[0]), FIXTOFLOAT(v[1]), FIXTOFLOAT(v[2]));
}

