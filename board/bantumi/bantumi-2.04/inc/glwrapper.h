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

#ifndef __GLWRAPPER_H
#define __GLWRAPPER_H


#ifdef GLES

#include <GLES/gl.h>
#define glColor4xv(x) glColor4x((x)[0], (x)[1], (x)[2], (x)[3])
#define glColor4fv(x) glColor4f((x)[0], (x)[1], (x)[2], (x)[3])
#define glTexParameteri glTexParameterx

#define USE_FIXED

#else

#include <SDL_opengl.h>
typedef signed int GLfixed;

#endif


#define FIXMUL(a, b) (((a)>>8)*((b)>>8))
#define FIXMUL2(a, b) ((((a)>>4)*((b)>>4))>>8)
#define TOFIX(x) ((GLfixed)((x)*(1<<16)))
#define FIXTOFLOAT(x) (float(x)/(1<<16))

#ifdef USE_FIXED

#define GLTYPE GLfixed
#define GLTYPETOKEN GL_FIXED
#define F(x) TOFIX(x)
#define TOFLOAT(x) FIXTOFLOAT(x)
#define TOINT(x) ((x)>>16)

#define MUL(a, b) FIXMUL(a, b)

#define multMatrix multMatrixx
#define invertMatrix invertMatrixx
#define multVect3 multVect3x
#define multVect4 multVect4x

#define matrixToAA matrixToAAx
#define matrixToQuat matroxToQuatx
#define quatInv quatInvx
#define quatConj quatConjx
#define quatMul quatMulx
#define quatToAA quatToAAx
#define quatToMatrix quatToMatrixx
#define aaToQuat aaToQuatx
#define aaToMatrix aaToMatrixx
#define matrixInterp matrixInterpx

#define glMultMatrix glMultMatrixx
#define glColor4 glColor4x
#define glColor4v glColor4xv
#define glOrtho glOrthox
#define glLightv glLightxv
#define glClearColor glClearColorx
#define glMaterialv glMaterialxv
#define glMaterial glMaterialx
#define glTranslate glTranslatex

#else

#define GLTYPE GLfloat
#define GLTYPETOKEN GL_FLOAT
#define F(x) float(x)
#define TOFLOAT(x) (x)
#define TOINT(x) int(x)

#define MUL(a, b) ((a)*(b))

#define multMatrix multMatrixf
#define invertMatrix invertMatrixf
#define multVect3 multVect3f
#define multVect4 multVect4f

#define matrixToAA matrixToAAf
#define matrixToQuat matroxToQuatf
#define quatInv quatInvf
#define quatConj quatConjf
#define quatMul quatMulf
#define quatToAA quatToAAf
#define quatToMatrix quatToMatrixf
#define aaToQuat aaToQuatf
#define aaToMatrix aaToMatrixf
#define matrixInterp matrixInterpf

#define glMultMatrix glMultMatrixf
#define glColor4 glColor4f
#define glColor4v glColor4fv
#define glLightv glLightfv
#define glMaterialv glMaterialfv
#define glMaterial glMaterialf
#define glTranslate glTranslatef

#ifdef GLES
#define glOrtho glOrthof
#endif

#endif

#define LEN3(v) sqrt(TOFLOAT(MUL((v)[0], (v)[0]) + MUL((v)[1], (v)[1]) + MUL((v)[2], (v)[2])))
#define LEN4(v) sqrt(TOFLOAT(MUL((v)[0], (v)[0]) + MUL((v)[1], (v)[1]) + MUL((v)[2], (v)[2]) + MUL((v)[3], (v)[3])))
#define NORMALIZE3(v) do {			\
		float len = LEN3(v);		\
		GLTYPE invlen = F(1/len);	\
		(v)[0] = MUL((v)[0], invlen);	\
		(v)[1] = MUL((v)[1], invlen);	\
		(v)[2] = MUL((v)[2], invlen);	\
	} while (0);
#define NORMALIZE4(v) do {			\
		float len = LEN4(v);		\
		GLTYPE invlen = F(1/len);	\
		(v)[0] = MUL((v)[0], invlen);	\
		(v)[1] = MUL((v)[1], invlen);	\
		(v)[2] = MUL((v)[2], invlen);	\
		(v)[3] = MUL((v)[3], invlen);	\
	} while (0);

#define MULBY(a, b) a = MUL(a, b);

#endif
