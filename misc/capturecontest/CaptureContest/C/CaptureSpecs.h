
/*################*/
/* CaptureSpecs.h */        /* $VER: CaptureSpecs.DEF 0.0 (19.12.2010) */
/*################*/

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

#ifndef CaptureSpecs_h
#define CaptureSpecs_h

#include "MyTypes.h"

#define ScreenSize            800.0
#define MaxBumperVelocity      24.0
#define MaxBumperVelocDelta     8.0
#define SledVelocity           15.0
#define MaxSledTurn             0.5  /* ABS(radians) ~28° */
#define MaxSledTrailLen       600.0
#define BumperRadius            8.0
#define BumperMass              8.0
#define PuckRadius              5.0
#define PuckMass                3.0
#define PuckFriction            1.0

#define NumBumpers              4
#define NumPucks              112
#define NumSleds                2
#define NumWalls                4

#define RedSledIndex            0
#define BlueSledIndex           1

enum XY {X,Y};

#define Point(v) float v[2]

struct  LineSeg {Point  (p1);
                 Point  (p2);
                 boolean hidden;
                };

typedef  uint BumperIndices    /*=  [0..NumBumpers-1]*/;
typedef  uint MyBumperIndices  /*=  [0..1]*/;
typedef  uint HisBumperIndices /*=  [2..3]*/;

#define TrailMaxSegs     4*40+15

typedef enum  {RedPlayer, BluePlayer, NoPlayer}    GameColors;
typedef GameColors                                 GamePlayers /*= GameColors[RedPlayer..BluePlayer]*/;

struct  ObjSpecs {Point     (pos);
                  GameColors color;
                  boolean    moved,
                             marked;
                 }; 

struct  SledSpecs {Point            (pos);
                   GameColors        color;
                   float             direct;           /* radians */
                   uint              TrailHeadPos;
                   struct LineSeg    Trail[TrailMaxSegs];
                   uint              TrailNumSegs;
                  };

#define PuckObjsDesc(v)    struct ObjSpecs v[NumPucks]
#define BumperObjsDesc(v)  struct ObjSpecs v[NumBumpers]
#define WallObjsDesc(v)    struct ObjSpecs v[NumWalls]
#define SledObjsDesc(v)    struct ObjSpecs v[NumSleds]

#endif


