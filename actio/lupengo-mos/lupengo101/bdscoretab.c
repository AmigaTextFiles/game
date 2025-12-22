///////////////////////////////////////////////////////////////////////////////
// File         : bdbdscoretab.c
// Info         : Build score table descriptor
// Written by   : Carlo Borreo borreo@softhome.net
///////////////////////////////////////////////////////////////////////////////

// How to use:
// Link this with the main program, and call CreateScoreTab()
// It will create scoretab.tmp, containing the string array ScoreTabDesc
// Then cut and paste the content into scoretab.c
// This file will no more be needed

#include "lupengo.h"

#define SCORETABFILENAME "stdesc.tmp"

FILE *fp ;

#define PicturePutScreen(A,B,C) fprintf( fp, "\t\"P%d %d %d\",\n", (A), (B), (C) )
#define PictureClearAll() fprintf( fp, "\t\"C\",\n" )
#define mydelay(A) fprintf( fp, "\t\"D%d\",\n", (A) )
#define showit(A) fprintf( fp, "\t\"S%s\",\n", (A) )
#define xputscreen(A,B,C) { mydelay(200);PicturePutScreen(A,B,C); }

static void xmove( int x0, int y0, int x1, int y1, int shape ) ;
static void show_crush( void ) ;
static void show_stun( void ) ;
static void show_tris( void ) ;
static void show_2p( void ) ;
void showtable( void ) ;

static void xmove( int x0, int y0, int x1, int y1, int shape )
	{
	xputscreen(x0,y0,shape);
	while(x0!=x1 || y0!=y1) {
		xputscreen(x0,y0,BLANK);
		if ( x0 > x1 )
			x0 -- ;
		else if ( x0 < x1 )
			x0 ++ ;
		if ( y0 > y1 )
			y0 -- ;
		else if ( y0 < y1 )
			y0 ++ ;
		PicturePutScreen(x0,y0,shape);
		}
	}

static void show_crush( void )
	{
	int i, j;
	char buf[80];
	int pics[]={ W400, W1600, W6400, W25600 } ;
	int pts[]={ 400, 1600, 6400, 25600 } ;

	for (i=0; i<4; i++) {
		PictureClearAll();
		showit(strcrushen);
		PicturePutScreen(4, 2, CARLONID);
		PicturePutScreen(5, 5, WALL);
		for (j=10-i; j<=10; j++)
			PicturePutScreen(j, 5, LUPONEL);
		PicturePutScreen(11, 5, WALL);
		xmove(4, 2, 4, 5, CARLONID);
		xputscreen(4, 5, CARLONIR);
		xmove(5, 5, 10, 5, WALL);
		xputscreen(10, 5, pics[i]);
		sprintf(buf, "%d %s", pts[i], strpoints);
		showit(buf);
		mydelay(1000);
		}
	}

static void show_stun( void )
	{
	int i;
	char buf[80];

	PictureClearAll();
	showit(strstunen);
	for (i=1; i<=15; i++)
		PicturePutScreen(i, 5, BORDER);
	PicturePutScreen(10, 4, LUPONEL);
	PicturePutScreen(5, 1, CARLONID);
	xmove(5, 1, 5, 4, CARLONID);
	for (i=1; i<=15; i++)
		PicturePutScreen(i, 5, ICEY);
	PicturePutScreen(10, 4, DOWN);
	mydelay(200);
	for (i=1; i<=15; i++)
		PicturePutScreen(i, 5, BLACK);
	mydelay(200);
	xmove(5, 4, 11, 4, CARLONIR);
	sprintf(buf, "100 %s", strpoints);
	showit(buf);
	for (i=1; i<=15; i++)
		PicturePutScreen(i, 5, BORDER);
	mydelay(2000);
	}

static void show_tris( void )
	{
	char buf[80];

	PictureClearAll();
	showit(str3inarow);
	PicturePutScreen(4, 2, CARLONID);
	PicturePutScreen(5, 5, TRIS);
	PicturePutScreen(10, 5, TRIS);
	PicturePutScreen(11, 5, TRIS);
	xmove(4, 2, 4, 5, CARLONID);
	xputscreen(4, 5, CARLONIR);
	xmove(5, 5, 9, 5, TRIS);
	sprintf(buf, "???? %s", strpoints);
	showit(buf);
	mydelay(2000);
	}

static void show_2p( void )
	{
	int i;
	char buf[80];

	PictureClearAll();
	showit(str2better);
	for (i=1; i<=15; i++)
		PicturePutScreen(i, 5, BORDER);
	PicturePutScreen(10, 4, LUPONEL);
	PicturePutScreen(12, 4, PIGL);
	PicturePutScreen(5, 1, CARLONID);
	xmove(5, 1, 5, 4, CARLONID);
	for (i=1; i<=15; i++)
		PicturePutScreen(i, 5, ICEY);
	PicturePutScreen(10, 4, DOWN);
	mydelay(200);
	for (i=1; i<=15; i++)
		PicturePutScreen(i, 5, BLACK);
	xmove(12, 4, 9, 4, PIGL);
	sprintf(buf, "100 %s", strpoints);
	showit(buf);
	for (i=1; i<=15; i++)
		PicturePutScreen(i, 5, BORDER);
	mydelay(2000);
	}

void CreateScoreTab( void )
	{
	fp = fopen( SCORETABFILENAME, "w" ) ;
	if ( fp == NULL )
		{
		fprintf( stderr, "Can't fopen " SCORETABFILENAME " file for w\n" ) ;
		return ;
		}
	fprintf( fp, "static char *ScoreTabDesc[] = {\n" ) ;
	show_crush();
	show_stun();
	show_tris();
	show_2p();
	fprintf( fp, "\tNULL\n\t} ;\n" ) ;
	fclose( fp ) ;
	}
