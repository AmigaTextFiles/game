#ifndef GADS_H
#include "Gads.h"
#endif

/****************************************************************************

			    M(iga)M(ind)_Proto.h
								1-5-90
								 Ekke
****************************************************************************/


/****************************************************************** Main.c */
void Nop(char *,int);
int HandleSD(struct RastPort *,WORD ,WORD ,int ,int *);
int HandleSysD(struct RastPort *,WORD ,WORD ,int );
int HandleSysU(struct RastPort *,WORD ,WORD ,int ,int );
void GetCode(BYTE *);
int CheckValue(int );
int IsIn(BYTE ,BYTE *);
int WrightColor(int ,BYTE *);
int WrightPosition(int ,BYTE *);
void ShowAnswer(struct RastPort *,BYTE *);

/****************************************************************** Gads.c */
void BaseGad(struct RastPort *,BGAD *);
void DrawSysGad(struct RastPort *,int ,int,int );
WORD GadPosX(int ,int );
WORD GadPosY(int );
void DrawGad(struct RastPort *,int ,int ,int ,int );
int  GetSysID(WORD ,WORD );
int  GetGadTurn(WORD );
int  GetGadID(int ,WORD );
int  GadNr(int ,int );

/***************************************************************** Paint.c */

void Line(struct RastPort *,WORD ,WORD ,WORD ,WORD );
void PaintLines(struct RastPort *);
void HRBorder(struct RastPort *,WORD ,WORD ,WORD ,WORD );
void PaintBorders(struct RastPort *);
void PaintGads(struct RastPort *);
void LayOut(struct RastPort *);
void Block(struct RastPort *,WORD ,WORD );
void PaintWright(struct RastPort *,int,int,int);

/***************************************************************** Lattice */
/* I hate Warnings and I don't know where these proto's are... */
void srand(unsigned int);
int  rand(void);
void XCEXIT(int);
void timer(unsigned int *);







