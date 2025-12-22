#ifndef _GELTOOLS_H
#define _GELTOOLS_H

#if 0
/* Define own stuff before including gels.h */
struct MyVSpriteStuff
{
	short	no;
	short	sprx, spry, sprdx, sprdy;
};

#define VUserStuff struct MyVSpriteStuff
#endif

#ifndef _EXEC_TYPES_H
#include <exec/types.h>
#endif /* _EXEC_TYPES_H */

/*
 * Data structure to hold information for a new vsprite
 *
 */
typedef struct NewVSprite
{
	UWORD	*nvs_Image;
	UWORD	*nvs_ColorSet;
	SHORT	nvs_WordWidth;
	SHORT	nvs_LineHeight;
	SHORT	nvs_ImageDepth;
	SHORT	nvs_X;
	SHORT	nvs_Y;
	SHORT	nvs_Flags;
} NEWVSPRITE;

/*
 * Data structure to hold information for a new bob
 *
 */
typedef struct NewBob
{
	UWORD	*nb_Image;
	SHORT	nb_WordWidth;
	SHORT	nb_LineHeight;
	SHORT	nb_ImageDepth;
	SHORT	nb_PlanePick;
	SHORT	nb_PlaneOnOff;
	SHORT	nb_BFlags;
	SHORT	nb_DBuf;
	SHORT	nb_RasDepth;
	SHORT	nb_X;
	SHORT	nb_Y;
} NEWBOB;

/* Prototypes */
struct GelsInfo *setupGelSys(struct RastPort *rp, UBYTE reserved);
void cleanupGelSys(struct GelsInfo *ginfo, struct RastPort *rp);
struct VSprite *makeVSprite(struct NewVSprite *nVSprite, UBYTE mode);
void freeVSprite(struct VSprite *vs, UBYTE mode);
struct Bob *makeBob(struct NewBob *nbob, UBYTE mode);
void freeBob(struct Bob *bob, LONG rasdepth, UBYTE mode);

/* Modes */
#define NO_MASKS	0x01

#endif /* _GELTOOLS_H */
