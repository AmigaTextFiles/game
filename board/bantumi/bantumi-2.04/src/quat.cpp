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

#include "quat.h"
#include <math.h>
#include "matrix.h"
#include <string.h>
#include <stdio.h>

#ifndef M_PI
#define M_PI 3.141592654
#endif

void matrixToAAf(float *aa, const float *matrix) {
	float c = (matrix[0] + matrix[5] + matrix[10] - 1)/2;
	aa[0] = acos(c);
	float s = sin(aa[0]);
	if (s > 0.0001) {
		aa[1] = (matrix[6] - matrix[9])/(2*s);
		aa[2] = (matrix[8] - matrix[2])/(2*s);
		aa[3] = (matrix[1] - matrix[4])/(2*s);
	} else if (c < 0) {
		aa[1] = (matrix[0] - c)/(1-c);
		aa[2] = (matrix[5] - c)/(1-c);
		aa[3] = (matrix[10] - c)/(1-c);
	} else {
		aa[1] = aa[2] = aa[3] = 0;
	}
}

void matrixToAAx(GLfixed *aa, const GLfixed *matrix) {
	float c = FIXTOFLOAT(matrix[0] + matrix[5] + matrix[10] - TOFIX(1))/2;
	float angle = acos(c);
	aa[0] = TOFIX(angle);
	float s = sin(angle);
	if (s > 0.0001) {
		aa[1] = GLfixed((matrix[6] - matrix[9])/(2*s));
		aa[2] = GLfixed((matrix[8] - matrix[2])/(2*s));
		aa[3] = GLfixed((matrix[1] - matrix[4])/(2*s));
	} else if (c < 0) {
		aa[1] = GLfixed((matrix[0] - TOFIX(c))/(1-c));
		aa[2] = GLfixed((matrix[5] - TOFIX(c))/(1-c));
		aa[3] = GLfixed((matrix[10] - TOFIX(c))/(1-c));
	} else {
		aa[1] = aa[2] = aa[3] = 0;
	}
}

void matrixToQuatf(float *quat, const float *matrix) {
	float aa[4];
	matrixToAAf(aa, matrix);
	aaToQuatf(quat, aa);
}

void matrixToQuatx(GLfixed *quat, const GLfixed *matrix) {
	GLfixed aa[4];
	matrixToAAx(aa, matrix);
	aaToQuatx(quat, aa);
}

void aaToQuatf(float *quat, const float *aa) {
	quat[0] = cos(aa[0]/2);
	float s = sin(aa[0]/2);
	quat[1] = aa[1]*s;
	quat[2] = aa[2]*s;
	quat[3] = aa[3]*s;
}

void aaToQuatx(GLfixed *quat, const GLfixed *aa) {
	float angle = FIXTOFLOAT(aa[0]);
	quat[0] = TOFIX(cos(angle/2));
	GLfixed s = TOFIX(sin(angle/2));
	quat[1] = FIXMUL(aa[1], s);
	quat[2] = FIXMUL(aa[2], s);
	quat[3] = FIXMUL(aa[3], s);
}

void quatToAAf(float *aa, const float *quat) {
	aa[0] = 2*acos(quat[0]);
	float s = sin(aa[0]/2);
	if (s > 0) {
		aa[1] = quat[1]/s;
		aa[2] = quat[2]/s;
		aa[3] = quat[3]/s;
	} else
		aa[1] = aa[2] = aa[3] = 0;
	if (aa[0] > M_PI)
		aa[0] -= 2*M_PI;
}

void quatToAAx(GLfixed *aa, const GLfixed *quat) {
	float angle = acos(FIXTOFLOAT(quat[0]));
	aa[0] = TOFIX(2*angle);
	float s = sin(angle);
	if (s > 0) {
		GLfixed invs = TOFIX(1/s);
		aa[1] = FIXMUL(quat[1], invs);
		aa[2] = FIXMUL(quat[2], invs);
		aa[3] = FIXMUL(quat[3], invs);
	} else
		aa[1] = aa[2] = aa[3] = 0;
	if (aa[0] > TOFIX(M_PI))
		aa[0] -= TOFIX(2*M_PI);
}

void quatInvf(float *out, const float *in) {
	float temp[4];
	quatConjf(out, in);
	quatMulf(temp, in, out);

	out[0] /= temp[0];
	out[1] /= temp[0];
	out[2] /= temp[0];
	out[3] /= temp[0];
}

void quatInvx(GLfixed *out, const GLfixed *in) {
	GLfixed temp[4];
	quatConjx(out, in);
	quatMulx(temp, in, out);

	GLfixed inv = TOFIX(1/FIXTOFLOAT(temp[0]));
	out[0] = FIXMUL(out[0], inv);
	out[1] = FIXMUL(out[1], inv);
	out[2] = FIXMUL(out[2], inv);
	out[3] = FIXMUL(out[3], inv);
}

void quatConjf(float *out, const float *in) {
	out[0] = in[0];
	out[1] = -in[1];
	out[2] = -in[2];
	out[3] = -in[3];
}

void quatConjx(GLfixed *out, const GLfixed *in) {
	out[0] = in[0];
	out[1] = -in[1];
	out[2] = -in[2];
	out[3] = -in[3];
}

void quatMulf(float *out, const float *q1, const float *q2) {
	out[0] = q1[0]*q2[0] - q1[1]*q2[1] - q1[2]*q2[2] - q1[3]*q2[3];
	out[1] = q1[0]*q2[1] + q1[1]*q2[0] + q1[2]*q2[3] - q1[3]*q2[2];
	out[2] = q1[0]*q2[2] + q1[2]*q2[0] - q1[1]*q2[3] + q1[3]*q2[1];
	out[3] = q1[0]*q2[3] + q1[3]*q2[0] + q1[1]*q2[2] - q1[2]*q2[1];
}

void quatMulx(GLfixed *out, const GLfixed *q1, const GLfixed *q2) {
	out[0] = FIXMUL(q1[0], q2[0]) - FIXMUL(q1[1], q2[1]) - FIXMUL(q1[2], q2[2]) - FIXMUL(q1[3], q2[3]);
	out[1] = FIXMUL(q1[0], q2[1]) + FIXMUL(q1[1], q2[0]) + FIXMUL(q1[2], q2[3]) - FIXMUL(q1[3], q2[2]);
	out[2] = FIXMUL(q1[0], q2[2]) + FIXMUL(q1[2], q2[0]) - FIXMUL(q1[1], q2[3]) + FIXMUL(q1[3], q2[1]);
	out[3] = FIXMUL(q1[0], q2[3]) + FIXMUL(q1[3], q2[0]) + FIXMUL(q1[1], q2[2]) - FIXMUL(q1[2], q2[1]);
}

void quatToMatrixf(float *matrix, const float *quat) {
	memset(matrix, 0, sizeof(float)*16);
	matrix[0] = quat[0]*quat[0] + quat[1]*quat[1] - quat[2]*quat[2] - quat[3]*quat[3];
	matrix[1] = 2*quat[0]*quat[3] + 2*quat[1]*quat[2];
	matrix[2] = 2*quat[1]*quat[3] - 2*quat[0]*quat[2];
	matrix[4] = 2*quat[1]*quat[2] - 2*quat[0]*quat[3];
	matrix[5] = quat[0]*quat[0] - quat[1]*quat[1] + quat[2]*quat[2] - quat[3]*quat[3];
	matrix[6] = 2*quat[0]*quat[1] + 2*quat[2]*quat[3];
	matrix[8] = 2*quat[0]*quat[2] + 2*quat[1]*quat[3];
	matrix[9] = 2*quat[2]*quat[3] - 2*quat[0]*quat[1];
	matrix[10] = quat[0]*quat[0] - quat[1]*quat[1] - quat[2]*quat[2] + quat[3]*quat[3];
	matrix[15] = 1;
}

void quatToMatrixx(GLfixed *matrix, const GLfixed *quat) {
	memset(matrix, 0, sizeof(GLfixed)*16);
	matrix[0] = FIXMUL(quat[0], quat[0]) + FIXMUL(quat[1], quat[1]) - FIXMUL(quat[2], quat[2]) - FIXMUL(quat[3], quat[3]);
	matrix[1] = 2*FIXMUL(quat[0], quat[3]) + 2*FIXMUL(quat[1], quat[2]);
	matrix[2] = 2*FIXMUL(quat[1], quat[3]) - 2*FIXMUL(quat[0], quat[2]);
	matrix[4] = 2*FIXMUL(quat[1], quat[2]) - 2*FIXMUL(quat[0], quat[3]);
	matrix[5] = FIXMUL(quat[0], quat[0]) - FIXMUL(quat[1], quat[1]) + FIXMUL(quat[2], quat[2]) - FIXMUL(quat[3], quat[3]);
	matrix[6] = 2*FIXMUL(quat[0], quat[1]) + 2*FIXMUL(quat[2], quat[3]);
	matrix[8] = 2*FIXMUL(quat[0], quat[2]) + 2*FIXMUL(quat[1], quat[3]);
	matrix[9] = 2*FIXMUL(quat[2], quat[3]) - 2*FIXMUL(quat[0], quat[1]);
	matrix[10] = FIXMUL(quat[0], quat[0]) - FIXMUL(quat[1], quat[1]) - FIXMUL(quat[2], quat[2]) + FIXMUL(quat[3], quat[3]);
	matrix[15] = TOFIX(1);
}

void aaToMatrixf(float *matrix, const float *aa) {
	float c = cos(aa[0]);
	float s = sin(aa[0]);
	memset(matrix, 0, sizeof(float)*16);
	matrix[0] = aa[1]*aa[1]*(1-c) + c;
	matrix[1] = aa[2]*aa[1]*(1-c) + aa[3]*s;
	matrix[2] = aa[1]*aa[3]*(1-c) - aa[2]*s;
	matrix[4] = aa[1]*aa[2]*(1-c) - aa[3]*s;
	matrix[5] = aa[2]*aa[2]*(1-c) + c;
	matrix[6] = aa[2]*aa[3]*(1-c) + aa[1]*s;
	matrix[8] = aa[1]*aa[3]*(1-c) + aa[2]*s;
	matrix[9] = aa[2]*aa[3]*(1-c) - aa[1]*s;
	matrix[10] = aa[3]*aa[3]*(1-c) + c;
	matrix[15] = 1;
}

void aaToMatrixx(GLfixed *matrix, const GLfixed *aa) {
	GLfixed c = TOFIX(cos(FIXTOFLOAT(aa[0])));
	GLfixed s = TOFIX(sin(FIXTOFLOAT(aa[0])));
	memset(matrix, 0, sizeof(float)*16);
	matrix[0] = FIXMUL2(FIXMUL2(aa[1], aa[1]), (TOFIX(1) - c)) + c;
	matrix[1] = FIXMUL2(FIXMUL2(aa[2], aa[1]), (TOFIX(1) - c)) + FIXMUL2(aa[3], s);
	matrix[2] = FIXMUL2(FIXMUL2(aa[1], aa[3]), (TOFIX(1) - c)) - FIXMUL2(aa[2], s);
	matrix[4] = FIXMUL2(FIXMUL2(aa[1], aa[2]), (TOFIX(1) - c)) - FIXMUL2(aa[3], s);
	matrix[5] = FIXMUL2(FIXMUL2(aa[2], aa[2]), (TOFIX(1) - c)) + c;
	matrix[6] = FIXMUL2(FIXMUL2(aa[2], aa[3]), (TOFIX(1) - c)) + FIXMUL2(aa[1], s);
	matrix[8] = FIXMUL2(FIXMUL2(aa[1], aa[3]), (TOFIX(1) - c)) + FIXMUL2(aa[2], s);
	matrix[9] = FIXMUL2(FIXMUL2(aa[2], aa[3]), (TOFIX(1) - c)) - FIXMUL2(aa[1], s);
	matrix[10] = FIXMUL2(FIXMUL2(aa[3], aa[3]), (TOFIX(1) - c)) + c;
	matrix[15] = TOFIX(1);
}

void matrixInterpf(float *out, const float *m1, const float *m2, float pos) {
	float temp[16];
	float q1[4], q2[4], qtemp[4];
	matrixToQuatf(q1, m1);
	matrixToQuatf(q2, m2);
	quatInvf(qtemp, q1);
	quatMulf(q1, qtemp, q2);
	quatToAAf(qtemp, q1);
	qtemp[0] *= pos;
	aaToMatrixf(temp, qtemp);
	multMatrixf(out, m1, temp);
	out[12] += pos*(m2[12] - m1[12]);
	out[13] += pos*(m2[13] - m1[13]);
	out[14] += pos*(m2[14] - m1[14]);
}

void matrixInterpx(GLfixed *out, const GLfixed *m1, const GLfixed *m2, GLfixed pos) {
	GLfixed temp[16];
	GLfixed q1[4], q2[4], qtemp[4];
	matrixToQuatx(q1, m1);
	matrixToQuatx(q2, m2);
	quatInvx(qtemp, q1);
	quatMulx(q1, qtemp, q2);
	quatToAAx(qtemp, q1);
	qtemp[0] = FIXMUL(qtemp[0], pos);
	aaToMatrixx(temp, qtemp);
	multMatrixx(out, m1, temp);
	out[12] += FIXMUL(pos, (m2[12] - m1[12]));
	out[13] += FIXMUL(pos, (m2[13] - m1[13]));
	out[14] += FIXMUL(pos, (m2[14] - m1[14]));
}

