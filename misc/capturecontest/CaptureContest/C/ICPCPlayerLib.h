
/*#################*/
/* ICPCPlayerLib.h */       /* (9.1.2011) */
/*#################*/

/*Copyright (C) 2010 Thomas Breeden, All Rights Reserved.
                   Aglet Software
                   PO Box 99
                   Free Union, VA 22940

Permission to use, copy, modify and distribute this software and its
documentation for any purpose and without fee is hereby granted, provided that
the above copyright notice appear in all copies and that both the copyright
notice and this permission notice appear in supporting documentation.
Thomas Breeden makes no representations about the suitability of this software
for any purpose. It is provided "as is" without express or implied warranty.
*/

#ifndef ICPCPlayerLib_h
#define ICPCPlayerLib_h

#include "MyTypes.h"

#include "CaptureSpecs.h"
#include "PipeIO.h"

#define LF         '\n'
#define CR         '\r'

#define Vector(v)  float v[2]

typedef enum  {MyColor, HisColor, GreyColor}  GameColours;

struct  PipeInfo  {char      pipeName[34];
                   PipeFile  pipeF;
                  };
typedef struct PipeInfo* PipeInfoPtr;

struct  PuckInfo  {int          num;
                   Vector      (pos);
                   Vector      (speed);
                   GameColours  color;
                  };
typedef struct PuckInfo* PuckInfoPtr;

struct  BumperInfo  {Vector   (pos);
                     Vector   (speed);
                     float     veloc;
                    };
typedef struct BumperInfo* BumperInfoPtr;

struct  SledInfo  {Vector               (pos);
                   float                 direct;    /* radians */
                   int                   TrailNumSegs;
                   Vector                (Trail[TrailMaxSegs]);
                  };
typedef struct SledInfo* SledInfoPtr;

typedef  struct PuckInfo   PucksArray[NumPucks];
typedef  struct BumperInfo BumpersArray[NumBumpers];
typedef  struct SledInfo   SledsArray[NumSleds];

 void DebugReal(char msg[], int i, float r);
 void DebugReal2(char msg[], int i, float r1, float r2);

 void WriteLn(PipeFile f);
 void WriteString(PipeFile f, char s[]);
 void WriteInt(PipeFile f, int i);
 void WriteReal(PipeFile f, float r);
 void WriteVector(PipeFile f, /*Vector*/float p[]);

 void OutGameMove(PipeFile f, /*Vector*/float Bump1Accel[], float Bump2Accel[], float SledTurn);

 void ReadPuck(PuckInfoPtr Puck);
 void ReadBumper(BumperInfoPtr Bumper);
 void ReadSled(SledInfoPtr Sled);

 void InGameState(PipeFile f, int* TurnNum, struct PuckInfo Pucks[], struct BumperInfo Bumpers[], struct SledInfo Sleds[]);

#endif



