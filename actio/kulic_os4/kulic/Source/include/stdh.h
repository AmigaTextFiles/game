
#define SOUND_YES

// standart header - precompiled
#ifndef _PRECOMPILED_HEADER_INCLUDED_
#define _PRECOMPILED_HEADER_INCLUDED_

// includy standartni
#include <math.h>
#include <stdio.h>

#include <allegro.h>

#ifdef _POUZIVAM_MICROSOFTI_HNUS
	#include <io.h>
	#include <winalleg.h>
	#include <windows.h> 
	#include <mmsystem.h> 
	extern GUID guid;
#endif

#include "fonts.h"

#include "lang.h"

// includy moje
#include "halleg.h"

#include "GFont.h"

// globalni promene - deklarovanve stdh.cpp
extern HScreen hscreen;

// defines
// matika
#define  PI  3.14  // pi
#define DPI  6.28  // dve pi
#define PI2  1.57  // pi / 2

// pro casovac
extern volatile int tmr; // 10-ms timer


// pro chybova hlaseni
extern char errch[50];
extern DATAFILE *fonts;


// popis grafiky
extern int  DF_X;  // x-ove rozliseni obrazovky == 640
extern int  DF_Y;  // y-ove rozliseni obrazovky == 480
#define  DF_BPP  16  // barevna hloubka

// prototypy
bool    IsOut(int x1, int y1, int x2, int y2, int dst);

void draw_loading();

typedef struct {
	int w;
	int h;
} RECT;


#endif // _PRECOMPILED_HEADER_INCLUDED_
