/*
 * Amtris © 1991-94 David Kinder
 *
 * A game which is almost, but not quite, entirely unlike Tetris.
 *
 */

#define WINX 25L
#define WINY 20L
#define W_WIDE 312
#define W_HIGH 149

SHORT Piece1a[] =
{ 2,1,0,0,1,0,1,1,2,1,-1 };

SHORT Piece1b[] =
{ 1,2,1,0,0,1,1,1,0,2,-1 };

SHORT Piece2a[] =
{ 1,1,0,0,1,0,0,1,1,1,-1 };

SHORT Piece3a[] =
{ 2,1,0,0,1,0,2,0,2,1,-1 };

SHORT Piece3b[] =
{ 1,2,1,0,1,1,0,2,1,2,-1 };

SHORT Piece3c[] =
{ 2,1,0,0,0,1,1,1,2,1,-1 };

SHORT Piece3d[] =
{ 1,2,0,0,1,0,0,1,0,2,-1 };

SHORT Piece4a[] =
{ 0,2,0,0,0,1,0,2,-1 };

SHORT Piece4b[] =
{ 2,0,0,0,1,0,2,0,-1 };

SHORT Piece5a[] =
{ 2,1,2,0,0,1,1,1,2,1,-1 };

SHORT Piece5b[] =
{ 1,2,0,0,0,1,0,2,1,2,-1 };

SHORT Piece5c[] =
{ 2,1,0,0,1,0,2,0,0,1,-1 };

SHORT Piece5d[] =
{ 1,2,0,0,1,0,1,1,1,2,-1 };

SHORT Piece6a[] =
{ 2,1,1,0,2,0,0,1,1,1,-1 };

SHORT Piece6b[] =
{ 1,2,0,0,0,1,1,1,1,2,-1 };

UBYTE obst0[] =
{ 2,0,0,0,0,0,0,0,0,2,
  2,0,0,0,0,0,0,0,0,2,
  2,0,0,0,0,0,0,0,0,2,
  2,0,0,0,0,0,0,0,0,2,
  2,0,0,0,0,0,0,0,0,2,
  2,0,0,0,0,0,0,0,0,2 };

UBYTE obst1[] =
{ 0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,
  1,0,1,0,1,1,0,1,0,1,
  0,3,0,3,0,0,3,0,3,0,
  1,0,1,0,1,1,0,1,0,1 };

UBYTE obst2[] =
{ 0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,
  0,0,1,1,0,0,1,1,0,0,
  3,3,3,0,0,0,0,3,3,3,
  2,2,0,0,0,0,0,0,2,2,
  1,0,0,0,0,0,0,0,0,1 };

UBYTE obst3[] =
{ 0,0,0,0,0,0,0,0,0,0,
  3,3,3,3,0,0,3,3,3,3,
  0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0 };

UBYTE obst4[] =
{ 0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,1,1,0,0,0,0,
  0,0,0,2,2,2,2,0,0,0,
  0,0,3,3,3,3,3,3,0,0 };

#define FLAGSON  CLOSEWINDOW|INTUITICKS|RAWKEY
#define FLAGSOFF CLOSEWINDOW

struct NewWindow MyNewWindow =
{
   (640-W_WIDE)/2,15,W_WIDE,W_HIGH,0,1,FLAGSON,
   SMART_REFRESH|WINDOWCLOSE|WINDOWDRAG|WINDOWDEPTH|ACTIVATE|RMBTRAP,
   NULL,NULL,(UBYTE *)"Amtris v1.0",NULL,NULL,0,0,0,0,WBENCHSCREEN
};

SHORT Points[] =
{ 0,0,0,120,163,120,163,0,162,0,162,120,1,120,1,0 };

struct Border MyBorder =
{ -2,0,1,1,JAM1,8,Points,NULL };

struct TextAttr NormText =
{ (UBYTE *)"topaz.font",8,FS_NORMAL,FPF_DESIGNED|FPF_ROMFONT };

struct TextAttr BoldText =
{ (UBYTE *)"topaz.font",8,FSF_BOLD,FPF_ROMFONT };

struct TextAttr BText =
{ (UBYTE *)"topaz.font",9,FS_NORMAL,FPF_DESIGNED|FPF_ROMFONT };

struct IntuiText StartText1 =
{ 1,0,JAM2,36,60,&BText,(UBYTE *)"Press any",NULL };

struct IntuiText StartText2 =
{ 1,0,JAM2,21,70,&BText,(UBYTE *)"key to start",&StartText1 };

struct IntuiText StartText3 =
{ 1,0,JAM2,31,80,&BText,(UBYTE *)"a new game",&StartText2 };

struct IntuiText StartText4 =
{ 3,0,JAM2,36,30,&BText,(UBYTE *)"Game Over",&StartText3 };

struct IntuiText RowText =
{ 1,0,JAM2,184,60,&NormText,(UBYTE *)"Rows :",NULL };

struct IntuiText LevText =
{ 1,0,JAM2,184,70,&NormText,(UBYTE *)"Level:",&RowText };

struct IntuiText LivesText =
{ 1,0,JAM2,184,80,&NormText,(UBYTE *)"Lives:",&LevText };

struct IntuiText HiScText =
{ 1,0,JAM2,184,100,&NormText,(UBYTE *)"Hi-Sc:",&LivesText };

struct IntuiText ScoreText =
{ 1,0,JAM2,184,90,&NormText,(UBYTE *)"Score:",&HiScText };

struct IntuiText NextText =
{ 1,0,JAM2,184,5,&NormText,(UBYTE *)"Next Piece",&ScoreText };

struct IntuiText ActRowText =
{ 3,0,JAM2,234,60,&NormText,(UBYTE *)"   ",NULL };

struct IntuiText ActLevText =
{ 3,0,JAM2,234,70,&NormText,(UBYTE *)"   ",&ActRowText };

struct IntuiText ActLivText =
{ 3,0,JAM2,234,80,&NormText,(UBYTE *)" ",&ActLevText };

struct IntuiText ActHiText =
{ 3,0,JAM2,234,100,&NormText,(UBYTE *)"0    ",&ActLivText };

struct IntuiText ActScText =
{ 3,0,JAM2,234,90,&NormText,(UBYTE *)"0    ",&ActHiText };

struct IntuiText Help7 =
{ 3,0,JAM1,14,100,&NormText,(UBYTE *)"Press a key to return...",NULL };

struct IntuiText Help6 =
{ 1,0,JAM1,60,80,&NormText,(UBYTE *)"<Space> lets it fall freely.",&Help7 };

struct IntuiText Help5 =
{ 1,0,JAM1,60,70,&NormText,(UBYTE *)"<Return> rotates the shape, &",&Help6 };

struct IntuiText Help4 =
{ 1,0,JAM1,60,60,&NormText,(UBYTE *)"'s' moves the shape right,",&Help5 };

struct IntuiText Help3 =
{ 1,0,JAM1,14,50,&NormText,(UBYTE *)"Keys: 'a' moves the shape left,",
   &Help4 };

struct IntuiText Help2 =
{ 2,0,JAM1,14,30,&NormText,(UBYTE *)"Written with the NorthC 'C' compiler",
   &Help3 };

struct IntuiText Help1 =
{ 1,0,JAM1,14,20,&NormText,(UBYTE *)"(c) 1991-94 David Kinder",&Help2 };

struct IntuiText Help =
{ 3,0,JAM1,14,10,&BoldText,(UBYTE *)"Amtris v1.0",&Help1 };
