// 1. INCLUDES -----------------------------------------------------------

#ifdef __amigaos4__
    #define __USE_INLINE__ // define this as early as possible
#endif
#ifdef AMIGA
    #include <exec/types.h>
    #include "amiga.h"
#endif
#ifdef WIN32
    #include "ibm.h"
#endif
#ifdef GBA
    #include "gba.h"
#endif

#ifdef AMIGA
    #include <stdlib.h>    // size_t

    #include "shared.h"
#endif
#define EXEC_TYPES_H
#include "ww.h"
#include "engine.h"

#if !defined(ANDROID) && !defined(GBA)
    #define CATCOMP_NUMBERS
    #define CATCOMP_BLOCK
    #include "ww_strings.h"
#endif

#ifdef AMIGA
    #include <proto/exec.h>
    #include <proto/intuition.h>
    #include <proto/locale.h>
#endif

// #define ASSERT
#include <assert.h>
#include <stdio.h>  // sprintf()
#include <stdlib.h> // abs()
#include <string.h> // strcpy(), strlen()

#ifdef AMIGA
    #ifdef __amigaos4__
         #include <sys/socket.h>
         #include <proto/socket.h>
         #include <netdb.h>
         #include <errno.h>
    #endif
    #if !defined(__SASC) && !defined(__VBCC__)
        #include <netinet/in.h>
        #ifndef __MORPHOS__
            #include <proto/bsdsocket.h>
        #else
            #define _SYS_SOCKET_H_
            #include <proto/socket.h>
            #define closesocket(d) CloseSocket(d)
            #include <arpa/inet.h>
        #endif
        #define ioctlsocket(d, request, argp) IoctlSocket(d, request, argp)
    #endif

    #define _IOC(inout,group,num,len) (inout | ((len & IOCPARM_MASK) << 16) | ((group) << 8) | (num))
    #define _IOW(g,n,t)               _IOC(IOC_IN, (g), (n), sizeof(t))
    #define FIONBIO                   _IOW('f', 126, long) /* set/clear non-blocking i/o */
//  #define EAGAIN                    35        /* Resource temporarily unavailable */
    #define EWOULDBLOCK               EAGAIN        /* Operation would block */
    #define WSAEWOULDBLOCK            EWOULDBLOCK
    #ifndef INADDR_ANY
        #define INADDR_ANY            (u_long)0x00000000
    #endif
    #define IOCPARM_MASK              0x1fff /* parameter length, at most 13 bits */
    #define IOC_IN                    0x80000000 /* copy in parameters */
    #ifdef __AROS__
        #define htons(n)              (((((UWORD) (n) & 0x00FF)) << 8) | (((UWORD) (n) & 0xFF00) >> 8))
    #else
        #if !defined(__amigaos4__) && !defined(__MORPHOS__)
            #define htons(n)          (n)
        #endif
    #endif
#endif
#ifdef WIN32
    #define CloseSocket               closesocket
#endif

/* 2. DEFINES ------------------------------------------------------------

(none)

3. EXPORTED VARIABLES ------------------------------------------------- */

EXPORT     FLAG                alwaysrq   = FALSE,
                               tdworms    = FALSE;
#ifdef AMIGA
    EXPORT struct Library*     SocketBase = NULL;
#endif
#ifdef __amigaos4__
    EXPORT struct SocketIFace* ISocket    = NULL;
#endif

EXPORT const UWORD birdframes[BIRDFRAMES + 1] =
{ BIRD,
  FIRSTBIRDFRAME,
  (UWORD) FIRSTBIRDFRAME + 1,
  (UWORD) FIRSTBIRDFRAME + 2,
  (UWORD) FIRSTBIRDFRAME + 3
}, missileframes[4][MISSILEFRAMES + 1] =
{ { FIRSTMISSILE, // green (p1)
    FIRSTMISSILEFRAME,
    (UWORD) FIRSTMISSILEFRAME + 1,
    (UWORD) FIRSTMISSILEFRAME + 2,
    (UWORD) FIRSTMISSILEFRAME + 3,
    (UWORD) FIRSTMISSILEFRAME + 4
  },
  { (UWORD) FIRSTMISSILE + 1,      // red (p2)
    (UWORD) FIRSTMISSILEFRAME + 5,
    (UWORD) FIRSTMISSILEFRAME + 6,
    (UWORD) FIRSTMISSILEFRAME + 7,
    (UWORD) FIRSTMISSILEFRAME + 8,
    (UWORD) FIRSTMISSILEFRAME + 9
  },
  { (UWORD) FIRSTMISSILE + 2,      // blue (p3)
    (UWORD) FIRSTMISSILEFRAME + 10,
    (UWORD) FIRSTMISSILEFRAME + 11,
    (UWORD) FIRSTMISSILEFRAME + 12,
    (UWORD) FIRSTMISSILEFRAME + 13,
    (UWORD) FIRSTMISSILEFRAME + 14,
  },
  { (UWORD) FIRSTMISSILE + 3,      // yellow (p4)
    (UWORD) FIRSTMISSILEFRAME + 15,
    (UWORD) FIRSTMISSILEFRAME + 16,
    (UWORD) FIRSTMISSILEFRAME + 17,
    (UWORD) FIRSTMISSILEFRAME + 18,
    (UWORD) FIRSTMISSILEFRAME + 19
} },
bananaframes[4][BANANAFRAMES] =
{ { FIRSTBANANA,
    (UWORD) FIRSTBANANAFRAME +  0,
    (UWORD) FIRSTBANANAFRAME +  1,
    (UWORD) FIRSTBANANAFRAME +  2,
    (UWORD) FIRSTBANANAFRAME +  3,
    (UWORD) FIRSTBANANAFRAME +  4,
    (UWORD) FIRSTBANANAFRAME +  5,
    (UWORD) FIRSTBANANAFRAME +  6,
  },
  { (UWORD) FIRSTBANANA + 1,
    (UWORD) FIRSTBANANAFRAME +  7,
    (UWORD) FIRSTBANANAFRAME +  8,
    (UWORD) FIRSTBANANAFRAME +  9,
    (UWORD) FIRSTBANANAFRAME + 10,
    (UWORD) FIRSTBANANAFRAME + 11,
    (UWORD) FIRSTBANANAFRAME + 12,
    (UWORD) FIRSTBANANAFRAME + 13,
  },
  { (UWORD) FIRSTBANANA + 2,
    (UWORD) FIRSTBANANAFRAME + 14,
    (UWORD) FIRSTBANANAFRAME + 15,
    (UWORD) FIRSTBANANAFRAME + 16,
    (UWORD) FIRSTBANANAFRAME + 17,
    (UWORD) FIRSTBANANAFRAME + 18,
    (UWORD) FIRSTBANANAFRAME + 19,
    (UWORD) FIRSTBANANAFRAME + 20,
  },
  { (UWORD) FIRSTBANANA + 3,
    (UWORD) FIRSTBANANAFRAME + 21,
    (UWORD) FIRSTBANANAFRAME + 22,
    (UWORD) FIRSTBANANAFRAME + 23,
    (UWORD) FIRSTBANANAFRAME + 24,
    (UWORD) FIRSTBANANAFRAME + 25,
    (UWORD) FIRSTBANANAFRAME + 26,
    (UWORD) FIRSTBANANAFRAME + 27,
} }, squidframes[SQUIDFRAMES + 1] =
{ SQUIDLEFT,
  SQUID,
  SQUIDRIGHT,
  SQUID
}, eelframes[EELFRAMES + 1] =
{ EEL,
  FIRSTEELFRAME,
  (UWORD) FIRSTEELFRAME + 1,
  (UWORD) FIRSTEELFRAME + 2
}, turtleframes[TURTLEFRAMES] =
{ TURTLE,
  FIRSTTURTLEFRAME,
  (UWORD) FIRSTTURTLEFRAME + 1,
  (UWORD) FIRSTTURTLEFRAME + 2
};

// 4. IMPORTED VARIABLES -------------------------------------------------

IMPORT FLAG                      anims,
                                 banging,
                                 enclosed,
                                 isfruit,
                                 superturbo,
                                 turbo;
IMPORT UWORD                     field[MAXFIELDX + 1][MAXFIELDY + 1],
                                 gfxfield[MAXFIELDX + 1][MAXFIELDY + 1],
                                 otherfield[MAXFIELDX + 1][MAXFIELDY + 1];
IMPORT SBYTE                     level,
                                 number,
                                 treasurer,
                                 players,
                                 levels,
                                 reallevel;
IMPORT SWORD                     fieldx, fieldy,
                                 secondsleft,
                                 secondsperlevel;
IMPORT UWORD                     eachworm[4][2][9];
IMPORT ULONG                     difficulty,
                                 r,
                                 quantity[5][3];
IMPORT int                       bonustype,
                                 numberx,
                                 numbery,
                                 showing;
IMPORT struct CreatureStruct     creature[CREATURES + 1];
IMPORT struct PointStruct        point[POINTSLOTS];
IMPORT struct ProtectorStruct    protector[4][PROTECTORS + 1];
IMPORT struct WormStruct         worm[4];
IMPORT struct CreatureInfoStruct creatureinfo[SPECIES + 1];
IMPORT struct TeleportStruct     teleport[2];
IMPORT const int                 sortcreatures[SPECIES + 1];
#ifdef AMIGA
    IMPORT struct Catalog*       CatalogPtr;
    IMPORT struct Window*        MainWindowPtr;
#endif
#ifdef WIN32
    IMPORT int                   CatalogPtr;
#endif

// 5. MODULE VARIABLES ---------------------------------------------------

#if !defined(ANDROID) && !defined(GBA)
MODULE TEXT                      replystring[1000];
#endif

// 6. MODULE STRUCTURES --------------------------------------------------

MODULE EWUNINIT struct
{   int deltax, deltay;
} thedogqueue[CREATURES + 1][DOGQUEUELIMIT + 1];
MODULE EWUNINIT struct
{   int deltax, deltay;
} thewormqueue[4][WORMQUEUELIMIT + 1];
MODULE EWUNINIT struct
{   int   x, y, deltax, deltay;
    FLAG  alive, moved, teleported, visible;
} bullet[13];

EXPORT const UWORD eachtail[4][2][9][9] = {
{ { { (UWORD) GN_SE_NW, (UWORD) GN_SE_N,  (UWORD) GN_SE_NE, // going NW (delta -1, -1)
      (UWORD) GN_SE_W,  (UWORD) GN_W_E,   (UWORD) GN_SE_E,  // (so starting from SE)
      (UWORD) GN_SE_SW, (UWORD) GN_SE_S,  (UWORD) GN_SE_NW
    },
    { (UWORD) GN_S_NW,  (UWORD) GN_S_N,   (UWORD) GN_S_NE,  // going N (delta 0, -1)
      (UWORD) GN_S_W,   (UWORD) GN_W_E,   (UWORD) GN_S_E,   // (so starting from S)
      (UWORD) GN_S_SW,  (UWORD) GN_S_N,   (UWORD) GN_S_SE
    },
    { (UWORD) GN_SW_NW, (UWORD) GN_SW_N,  (UWORD) GN_SW_NE, // going NE (delta 0, 1)
      (UWORD) GN_SW_W,  (UWORD) GN_W_E,   (UWORD) GN_SW_E,  // (so starting from SW)
      (UWORD) GN_SW_NE, (UWORD) GN_SW_S,  (UWORD) GN_SW_SE
    },
    { (UWORD) GN_E_NW,  (UWORD) GN_E_N,   (UWORD) GN_E_NE,  // going W (delta -1, 0)
      (UWORD) GN_E_W,   (UWORD) GN_W_E,   (UWORD) GN_E_W,   // (so starting from E)
      (UWORD) GN_E_SW,  (UWORD) GN_E_S,   (UWORD) GN_E_SE
    },
    { (UWORD) GN_SE_NW, (UWORD) GN_S_N,   (UWORD) GN_SW_NE, // going nowhere (delta 0, 0)
      (UWORD) GN_E_W,   (UWORD) GN_W_E,   (UWORD) GN_W_E,
      (UWORD) GN_NE_SW, (UWORD) GN_N_S,   (UWORD) GN_NW_SE
    },
    { (UWORD) GN_W_NW,  (UWORD) GN_W_N,   (UWORD) GN_W_NE,  // going E (delta 1, 0)
      (UWORD) GN_W_E,   (UWORD) GN_W_E,   (UWORD) GN_W_E,   // (so starting from W)
      (UWORD) GN_W_SW,  (UWORD) GN_W_S,   (UWORD) GN_W_SE
    },
    { (UWORD) GN_NE_NW, (UWORD) GN_NE_N,  (UWORD) GN_NE_NW, // going SW (delta -1, 1)
      (UWORD) GN_NE_W,  (UWORD) GN_W_E,   (UWORD) GN_NE_E,  // (so starting from NE)
      (UWORD) GN_NE_SW, (UWORD) GN_NE_S,  (UWORD) GN_NE_SE
    },
    { (UWORD) GN_N_NW,  (UWORD) GN_N_S,   (UWORD) GN_N_NE,  // going S (delta 0, 1)
      (UWORD) GN_N_W,   (UWORD) GN_W_E,   (UWORD) GN_N_E,   // (so starting from N)
      (UWORD) GN_N_SW,  (UWORD) GN_N_S,   (UWORD) GN_N_SE
    },
    { (UWORD) GN_NW_SE, (UWORD) GN_NW_N,  (UWORD) GN_NW_NE, // going SE (delta 1, 1)
      (UWORD) GN_NW_W,  (UWORD) GN_W_E,   (UWORD) GN_NW_E,  // (so starting from NW)
      (UWORD) GN_NW_SW, (UWORD) GN_NW_S,  (UWORD) GN_NW_SE
  } },
  { { (UWORD) GG_SE_NW, (UWORD) GG_SE_N,  (UWORD) GG_SE_NE, // going NW (delta -1, -1)
      (UWORD) GG_SE_W,  (UWORD) GG_W_E,   (UWORD) GG_SE_E,  // (so starting from SE)
      (UWORD) GG_SE_SW, (UWORD) GG_SE_S,  (UWORD) GG_SE_NW
    },
    { (UWORD) GG_S_NW,  (UWORD) GG_S_N,   (UWORD) GG_S_NE,  // going N (delta 0, -1)
      (UWORD) GG_S_W,   (UWORD) GG_W_E,   (UWORD) GG_S_E,   // (so starting from S)
      (UWORD) GG_S_SW,  (UWORD) GG_S_N,   (UWORD) GG_S_SE
    },
    { (UWORD) GG_SW_NW, (UWORD) GG_SW_N,  (UWORD) GG_SW_NE, // going NE (delta 0, 1)
      (UWORD) GG_SW_W,  (UWORD) GG_W_E,   (UWORD) GG_SW_E,  // (so starting from SW)
      (UWORD) GG_SW_NE, (UWORD) GG_SW_S,  (UWORD) GG_SW_SE
    },
    { (UWORD) GG_E_NW,  (UWORD) GG_E_N,   (UWORD) GG_E_NE,  // going W (delta -1, 0)
      (UWORD) GG_E_W,   (UWORD) GG_W_E,   (UWORD) GG_E_W,   // (so starting from E)
      (UWORD) GG_E_SW,  (UWORD) GG_E_S,   (UWORD) GG_E_SE
    },
    { (UWORD) GG_SE_NW, (UWORD) GG_S_N,   (UWORD) GG_SW_NE, // going nowhere (delta 0, 0)
      (UWORD) GG_E_W,   (UWORD) GG_W_E,   (UWORD) GG_W_E,
      (UWORD) GG_NE_SW, (UWORD) GG_N_S,   (UWORD) GG_NW_SE
    },
    { (UWORD) GG_W_NW,  (UWORD) GG_W_N,   (UWORD) GG_W_NE,  // going E (delta 1, 0)
      (UWORD) GG_W_E,   (UWORD) GG_W_E,   (UWORD) GG_W_E,   // (so starting from W)
      (UWORD) GG_W_SW,  (UWORD) GG_W_S,   (UWORD) GG_W_SE
    },
    { (UWORD) GG_NE_NW, (UWORD) GG_NE_N,  (UWORD) GG_NE_SW, // going SW (delta -1, 1)
      (UWORD) GG_NE_W,  (UWORD) GG_W_E,   (UWORD) GG_NE_E,  // (so starting from NE)
      (UWORD) GG_NE_SW, (UWORD) GG_NE_S,  (UWORD) GG_NE_SE
    },
    { (UWORD) GG_N_NW,  (UWORD) GG_N_S,   (UWORD) GG_N_NE,  // going S (delta 0, 1)
      (UWORD) GG_N_W,   (UWORD) GG_W_E,   (UWORD) GG_N_E,   // (so starting from N)
      (UWORD) GG_N_SW,  (UWORD) GG_N_S,   (UWORD) GG_N_SE
    },
    { (UWORD) GG_NW_SE, (UWORD) GG_NW_N,  (UWORD) GG_NW_NE, // going SE (delta 1, 1)
      (UWORD) GG_NW_W,  (UWORD) GG_W_E,   (UWORD) GG_NW_E,  // (so starting from NW)
      (UWORD) GG_NW_SW, (UWORD) GG_NW_S,  (UWORD) GG_NW_SE
} } },
{ { { (UWORD) RN_SE_NW, (UWORD) RN_SE_N,  (UWORD) RN_SE_NE, // going NW (delta -1, -1)
      (UWORD) RN_SE_W,  (UWORD) RN_W_E,   (UWORD) RN_SE_E,  // (so starting from SE)
      (UWORD) RN_SE_SW, (UWORD) RN_SE_S,  (UWORD) RN_SE_NW,
    },
    { (UWORD) RN_S_NW,  (UWORD) RN_S_N,   (UWORD) RN_S_NE,  // going N (delta 0, -1)
      (UWORD) RN_S_W,   (UWORD) RN_W_E,   (UWORD) RN_S_E,   // (so starting from S)
      (UWORD) RN_S_SW,  (UWORD) RN_S_N,   (UWORD) RN_S_SE
    },
    { (UWORD) RN_SW_NW, (UWORD) RN_SW_N,  (UWORD) RN_SW_NE, // going NE (delta 0, 1)
      (UWORD) RN_SW_W,  (UWORD) RN_W_E,   (UWORD) RN_SW_E,  // (so starting from SW)
      (UWORD) RN_SW_NE, (UWORD) RN_SW_S,  (UWORD) RN_SW_SE
    },
    { (UWORD) RN_E_NW,  (UWORD) RN_E_N,   (UWORD) RN_E_NE,  // going W (delta -1, 0)
      (UWORD) RN_E_W,   (UWORD) RN_W_E,   (UWORD) RN_E_W,   // (so starting from E)
      (UWORD) RN_E_SW,  (UWORD) RN_E_S,   (UWORD) RN_E_SE
    },
    { (UWORD) RN_SE_NW, (UWORD) RN_S_N,   (UWORD) RN_SW_NE, // going nowhere (delta 0, 0)
      (UWORD) RN_E_W,   (UWORD) RN_W_E,   (UWORD) RN_W_E,
      (UWORD) RN_NE_SW, (UWORD) RN_N_S,   (UWORD) RN_NW_SE
    },
    { (UWORD) RN_W_NW,  (UWORD) RN_W_N,   (UWORD) RN_W_NE,  // going E (delta 1, 0)
      (UWORD) RN_W_E,   (UWORD) RN_W_E,   (UWORD) RN_W_E,   // (so starting from W)
      (UWORD) RN_W_SW,  (UWORD) RN_W_S,   (UWORD) RN_W_SE
    },
    { (UWORD) RN_NE_NW, (UWORD) RN_NE_N,  (UWORD) RN_NE_SW, // going SW (delta -1, 1)
      (UWORD) RN_NE_W,  (UWORD) RN_W_E,   (UWORD) RN_NE_E,  // (so starting from NE)
      (UWORD) RN_NE_SW, (UWORD) RN_NE_S,  (UWORD) RN_NE_SE
    },
    { (UWORD) RN_N_NW,  (UWORD) RN_N_S,   (UWORD) RN_N_NE,  // going S (delta 0, 1)
      (UWORD) RN_N_W,   (UWORD) RN_W_E,   (UWORD) RN_N_E,   // (so starting from N)
      (UWORD) RN_N_SW,  (UWORD) RN_N_S,   (UWORD) RN_N_SE
    },
    { (UWORD) RN_NW_SE, (UWORD) RN_NW_N,  (UWORD) RN_NW_NE, // going SE (delta 1, 1)
      (UWORD) RN_NW_W,  (UWORD) RN_W_E,   (UWORD) RN_NW_E,  // (so starting from NW)
      (UWORD) RN_NW_SW, (UWORD) RN_NW_S,  (UWORD) RN_NW_SE
  } },
  { { (UWORD) RG_SE_NW, (UWORD) RG_SE_N,  (UWORD) RG_SE_NE, // going NW (delta -1, -1)
      (UWORD) RG_SE_W,  (UWORD) RG_W_E,   (UWORD) RG_SE_E,  // (so starting from SE)
      (UWORD) RG_SE_SW, (UWORD) RG_SE_S,  (UWORD) RG_SE_NW
    },
    { (UWORD) RG_S_NW,  (UWORD) RG_S_N,   (UWORD) RG_S_NE,  // going N (delta 0, -1)
      (UWORD) RG_S_W,   (UWORD) RG_W_E,   (UWORD) RG_S_E,   // (so starting from S)
      (UWORD) RG_S_SW,  (UWORD) RG_S_N,   (UWORD) RG_S_SE
    },
    { (UWORD) RG_SW_NW, (UWORD) RG_SW_N,  (UWORD) RG_SW_NE, // going NE (delta 0, 1)
      (UWORD) RG_SW_W,  (UWORD) RG_W_E,   (UWORD) RG_SW_E,  // (so starting from SW)
      (UWORD) RG_SW_NE, (UWORD) RG_SW_S,  (UWORD) RG_SW_SE
    },
    { (UWORD) RG_E_NW,  (UWORD) RG_E_N,   (UWORD) RG_E_NE,  // going W (delta -1, 0)
      (UWORD) RG_E_W,   (UWORD) RG_W_E,   (UWORD) RG_E_W,   // (so starting from E)
      (UWORD) RG_E_SW,  (UWORD) RG_E_S,   (UWORD) RG_E_SE
    },
    { (UWORD) RG_SE_NW, (UWORD) RG_S_N,   (UWORD) RG_SW_NE, // going nowhere (delta 0, 0)
      (UWORD) RG_E_W,   (UWORD) RG_W_E,   (UWORD) RG_W_E,
      (UWORD) RG_NE_SW, (UWORD) RG_N_S,   (UWORD) RG_NW_SE
    },
    { (UWORD) RG_W_NW,  (UWORD) RG_W_N,   (UWORD) RG_W_NE,  // going E (delta 1, 0)
      (UWORD) RG_W_E,   (UWORD) RG_W_E,   (UWORD) RG_W_E,   // (so starting from W)
      (UWORD) RG_W_SW,  (UWORD) RG_W_S,   (UWORD) RG_W_SE
    },
    { (UWORD) RG_NE_NW, (UWORD) RG_NE_N,  (UWORD) RG_NE_SW, // going SW (delta -1, 1)
      (UWORD) RG_NE_W,  (UWORD) RG_W_E,   (UWORD) RG_NE_E,  // (so starting from NE)
      (UWORD) RG_NE_SW, (UWORD) RG_NE_S,  (UWORD) RG_NE_SE
    },
    { (UWORD) RG_N_NW,  (UWORD) RG_N_S,   (UWORD) RG_N_NE,  // going S (delta 0, 1)
      (UWORD) RG_N_W,   (UWORD) RG_W_E,   (UWORD) RG_N_E,   // (so starting from N)
      (UWORD) RG_N_SW,  (UWORD) RG_N_S,   (UWORD) RG_N_SE
    },
    { (UWORD) RG_NW_SE, (UWORD) RG_NW_N,  (UWORD) RG_NW_NE, // going SE (delta 1, 1)
      (UWORD) RG_NW_W,  (UWORD) RG_W_E,   (UWORD) RG_NW_E,  // (so starting from NW)
      (UWORD) RG_NW_SW, (UWORD) RG_NW_S,  (UWORD) RG_NW_SE
} } },
{ { { (UWORD) BN_NW_SE, (UWORD) BN_N_SE,  (UWORD) BN_NE_SE, // going NW (delta -1, -1)
      (UWORD) BN_W_SE,  (UWORD) BN_N_S,   (UWORD) BN_E_SE,  // (so starting from SE)
      (UWORD) BN_SW_SE, (UWORD) BN_S_SE,  (UWORD) BN_NW_SE
    },
    { (UWORD) BN_NW_S,  (UWORD) BN_N_S,   (UWORD) BN_NE_S,  // going N (delta 0, -1)
      (UWORD) BN_W_S,   (UWORD) BN_N_S,   (UWORD) BN_E_S,   // (so starting from S)
      (UWORD) BN_S_SW,  (UWORD) BN_N_S,   (UWORD) BN_S_SE
    },
    { (UWORD) BN_NW_SW, (UWORD) BN_N_SW,  (UWORD) BN_NE_SW, // going NE (delta 0, 1)
      (UWORD) BN_W_SW,  (UWORD) BN_N_S,   (UWORD) BN_SW_E,  // (so starting from SW)
      (UWORD) BN_NE_SW, (UWORD) BN_S_SW,  (UWORD) BN_SW_SE
    },
    { (UWORD) BN_NW_E,  (UWORD) BN_N_E,   (UWORD) BN_E_NE,  // going W (delta -1, 0)
      (UWORD) BN_W_E,   (UWORD) BN_N_S,   (UWORD) BN_W_E,   // (so starting from E)
      (UWORD) BN_SW_E,  (UWORD) BN_E_S,   (UWORD) BN_E_SE
    },
    { (UWORD) BN_NW_SE, (UWORD) BN_N_S,   (UWORD) BN_NE_SW, // going nowhere (delta 0, 0)
      (UWORD) BN_W_E,   (UWORD) BN_N_S,   (UWORD) BN_W_E,
      (UWORD) BN_NE_SW, (UWORD) BN_N_S,   (UWORD) BN_NW_SE
    },
    { (UWORD) BN_W_NW,  (UWORD) BN_N_W,   (UWORD) BN_W_NE,  // going E (delta 1, 0)
      (UWORD) BN_W_E,   (UWORD) BN_N_S,   (UWORD) BN_W_E,   // (so starting from W)
      (UWORD) BN_W_SW,  (UWORD) BN_W_S,   (UWORD) BN_W_SE
    },
    { (UWORD) BN_NW_NE, (UWORD) BN_N_NE,  (UWORD) BN_NE_SW, // going SW (delta -1, 1)
      (UWORD) BN_W_NE,  (UWORD) BN_N_S,   (UWORD) BN_E_NE,  // (so starting from NE)
      (UWORD) BN_NE_SW, (UWORD) BN_NE_S,  (UWORD) BN_NE_SE
    },
    { (UWORD) BN_N_NW,  (UWORD) BN_N_S,   (UWORD) BN_N_NE,  // going S (delta 0, 1)
      (UWORD) BN_N_W,   (UWORD) BN_N_S,   (UWORD) BN_N_E,   // (so starting from N)
      (UWORD) BN_N_SW,  (UWORD) BN_N_S,   (UWORD) BN_N_SE
    },
    { (UWORD) BN_SW_SE, (UWORD) BN_N_NW,  (UWORD) BN_NW_NE, // going SE (delta 1, 1)
      (UWORD) BN_W_NW,  (UWORD) BN_N_S,   (UWORD) BN_NW_E,  // (so starting from NW)
      (UWORD) BN_NW_SW, (UWORD) BN_NW_S,  (UWORD) BN_NW_SE
  } },
  { { (UWORD) BG_NW_SE, (UWORD) BG_N_SE,  (UWORD) BG_NE_SE, // going NW (delta -1, -1)
      (UWORD) BG_W_SE,  (UWORD) BG_N_S,   (UWORD) BG_E_SE,  // (so starting from SE)
      (UWORD) BG_SW_SE, (UWORD) BG_S_SE,  (UWORD) BG_NW_SE
    },
    { (UWORD) BG_NW_S,  (UWORD) BG_N_S,   (UWORD) BG_NE_S,  // going N (delta 0, -1)
      (UWORD) BG_W_S,   (UWORD) BG_N_S,   (UWORD) BG_E_S,   // (so starting from S)
      (UWORD) BG_S_SW,  (UWORD) BG_N_S,   (UWORD) BG_S_SE
    },
    { (UWORD) BG_NW_SW, (UWORD) BG_N_SW,  (UWORD) BG_NE_SW, // going NE (delta 0, 1)
      (UWORD) BG_W_SW,  (UWORD) BG_N_S,   (UWORD) BG_SW_E,  // (so starting from SW)
      (UWORD) BG_NE_SW, (UWORD) BG_S_SW,  (UWORD) BG_SW_SE
    },
    { (UWORD) BG_NE_E,  (UWORD) BG_N_E,   (UWORD) BG_NE_E,  // going W (delta -1, 0)
      (UWORD) BG_W_E,   (UWORD) BG_N_S,   (UWORD) BG_W_E,   // (so starting from E)
      (UWORD) BG_SW_E,  (UWORD) BG_E_S,   (UWORD) BG_E_SE
    },
    { (UWORD) BG_NW_SE, (UWORD) BG_N_S,   (UWORD) BG_NE_SW, // going nowhere (delta 0, 0)
      (UWORD) BG_W_E,   (UWORD) BG_N_S,   (UWORD) BG_W_E,
      (UWORD) BG_NE_SW, (UWORD) BG_N_S,   (UWORD) BG_NW_SE
    },
    { (UWORD) BG_NW_W,  (UWORD) BG_N_W,   (UWORD) BG_NE_W,  // going E (delta 1, 0)
      (UWORD) BG_W_E,   (UWORD) BG_N_S,   (UWORD) BG_W_E,   // (so starting from W)
      (UWORD) BG_W_SW,  (UWORD) BG_W_S,   (UWORD) BG_W_SE
    },
    { (UWORD) BG_NW_NE, (UWORD) BG_N_NE,  (UWORD) BG_NE_SW, // going SW (delta -1, 1)
      (UWORD) BG_NE_W,  (UWORD) BG_N_S,   (UWORD) BG_NE_E,  // (so starting from NE)
      (UWORD) BG_NE_SW, (UWORD) BG_NE_S,  (UWORD) BG_NE_SE
    },
    { (UWORD) BG_N_NW,  (UWORD) BG_N_S,   (UWORD) BG_N_NE,  // going S (delta 0, 1)
      (UWORD) BG_N_W,   (UWORD) BG_N_S,   (UWORD) BG_N_E,   // (so starting from N)
      (UWORD) BG_N_SW,  (UWORD) BG_N_S,   (UWORD) BG_N_SE
    },
    { (UWORD) BG_NW_SE, (UWORD) BG_N_NW,  (UWORD) BG_NW_NE, // going SE (delta 1, 1)
      (UWORD) BG_NW_W,  (UWORD) BG_N_S,   (UWORD) BG_NW_E,  // (so starting from NW)
      (UWORD) BG_NW_SW, (UWORD) BG_NW_S,  (UWORD) BG_NW_SE
} } },
{ { { (UWORD) YN_NW_SE, (UWORD) YN_N_SE,  (UWORD) YN_NE_SE, // going NW (delta -1, -1)
      (UWORD) YN_W_SE,  (UWORD) YN_N_S,   (UWORD) YN_E_SE,  // (so starting from SE)
      (UWORD) YN_SW_SE, (UWORD) YN_S_SE,  (UWORD) YN_NW_SE
    },
    { (UWORD) YN_NW_S,  (UWORD) YN_N_S,   (UWORD) YN_NE_S,  // going N (delta 0, -1)
      (UWORD) YN_W_S,   (UWORD) YN_N_S,   (UWORD) YN_S_E,   // (so starting from S)
      (UWORD) YN_S_SW,  (UWORD) YN_N_S,   (UWORD) YN_S_SE
    },
    { (UWORD) YN_NW_SW, (UWORD) YN_N_SW,  (UWORD) YN_NE_SW, // going NE (delta 0, 1)
      (UWORD) YN_W_SW,  (UWORD) YN_N_S,   (UWORD) YN_E_SW,  // (so starting from SW)
      (UWORD) YN_NE_SW, (UWORD) YN_S_SW,  (UWORD) YN_SW_SE
    },
    { (UWORD) YN_NW_E,  (UWORD) YN_N_E,   (UWORD) YN_NE_E,  // going W (delta -1, 0)
      (UWORD) YN_W_E,   (UWORD) YN_N_S,   (UWORD) YN_W_E,   // (so starting from E)
      (UWORD) YN_E_SW,  (UWORD) YN_S_E,   (UWORD) YN_E_SE
    },
    { (UWORD) YN_NW_SE, (UWORD) YN_N_S,   (UWORD) YN_NE_SW, // going nowhere (delta 0, 0)
      (UWORD) YN_W_E,   (UWORD) YN_N_S,   (UWORD) YN_W_E,
      (UWORD) YN_NE_SW, (UWORD) YN_N_S,   (UWORD) YN_NW_SE
    },
    { (UWORD) YN_NW_W,  (UWORD) YN_N_W,   (UWORD) YN_W_NE,  // going E (delta 1, 0)
      (UWORD) YN_W_E,   (UWORD) YN_N_S,   (UWORD) YN_W_E,   // (so starting from W)
      (UWORD) YN_W_SW,  (UWORD) YN_W_S,   (UWORD) YN_W_SE
    },
    { (UWORD) YN_NW_NE, (UWORD) YN_N_NE,  (UWORD) YN_NE_SW, // going SW (delta -1, 1)
      (UWORD) YN_W_NE,  (UWORD) YN_N_S,   (UWORD) YN_NE_E,  // (so starting from NE)
      (UWORD) YN_NE_SW, (UWORD) YN_NE_S,  (UWORD) YN_NE_SE
    },
    { (UWORD) YN_N_NW,  (UWORD) YN_N_S,   (UWORD) YN_N_NE,  // going S (delta 0, 1)
      (UWORD) YN_N_W,   (UWORD) YN_N_S,   (UWORD) YN_N_E,   // (so starting from N)
      (UWORD) YN_N_SW,  (UWORD) YN_N_S,   (UWORD) YN_N_SE
    },
    { (UWORD) YN_NW_SE, (UWORD) YN_N_NW,  (UWORD) YN_NW_NE, // going SE (delta 1, 1)
      (UWORD) YN_NW_W,  (UWORD) YN_N_S,   (UWORD) YN_NW_E,  // (so starting from NW)
      (UWORD) YN_NW_SW, (UWORD) YN_NW_S,  (UWORD) YN_NW_SE
  } },
  { { (UWORD) YG_NW_SE, (UWORD) YG_N_SE,  (UWORD) YG_NE_SE, // going NW (delta -1, -1)
      (UWORD) YG_W_SE,  (UWORD) YG_N_S,   (UWORD) YG_E_SE,  // (so starting from SE)
      (UWORD) YG_SW_SE, (UWORD) YG_S_SE,  (UWORD) YG_NW_SE
    },
    { (UWORD) YG_S_NW,  (UWORD) YG_N_S,   (UWORD) YG_S_NE,  // going N (delta 0, -1)
      (UWORD) YG_W_S,   (UWORD) YG_N_S,   (UWORD) YG_E_S,   // (so starting from S)
      (UWORD) YG_S_SW,  (UWORD) YG_N_S,   (UWORD) YG_S_SE
    },
    { (UWORD) YG_NW_SW, (UWORD) YG_N_SW,  (UWORD) YG_NE_SW, // going NE (delta 0, 1)
      (UWORD) YG_W_SW,  (UWORD) YG_N_S,   (UWORD) YG_E_SW,  // (so starting from SW)
      (UWORD) YG_NE_SW, (UWORD) YG_S_SW,  (UWORD) YG_SW_SE
    },
    { (UWORD) YG_E_NW,  (UWORD) YG_E_N,   (UWORD) YG_E_NE,  // going W (delta -1, 0)
      (UWORD) YG_W_E,   (UWORD) YG_N_S,   (UWORD) YG_W_E,   // (so starting from E)
      (UWORD) YG_E_SW,  (UWORD) YG_E_S,   (UWORD) YG_E_SE
    },
    { (UWORD) YG_NW_SE, (UWORD) YG_N_S,   (UWORD) YG_NE_SW, // going nowhere (delta 0, 0)
      (UWORD) YG_W_E,   (UWORD) YG_N_S,   (UWORD) YG_W_E,
      (UWORD) YG_NE_SW, (UWORD) YG_N_S,   (UWORD) YG_NW_SE
    },
    { (UWORD) YG_W_NW,  (UWORD) YG_N_W,   (UWORD) YG_W_NE,  // going E (delta 1, 0)
      (UWORD) YG_W_E,   (UWORD) YG_N_S,   (UWORD) YG_W_E,   // (so starting from W)
      (UWORD) YG_W_SW,  (UWORD) YG_W_S,   (UWORD) YG_W_SE
    },
    { (UWORD) YG_NW_NE, (UWORD) YG_N_NE,  (UWORD) YG_NE_SW, // going SW (delta -1, 1)
      (UWORD) YG_W_NE,  (UWORD) YG_N_S,   (UWORD) YG_E_NE,  // (so starting from NE)
      (UWORD) YG_NE_SW, (UWORD) YG_S_NE,  (UWORD) YG_NE_SE
    },
    { (UWORD) YG_N_NW,  (UWORD) YG_N_S,   (UWORD) YG_N_NE,  // going S (delta 0, 1)
      (UWORD) YG_N_W,   (UWORD) YG_N_S,   (UWORD) YG_E_N,   // (so starting from N)
      (UWORD) YG_N_SW,  (UWORD) YG_N_S,   (UWORD) YG_N_SE
    },
    { (UWORD) YG_NW_SE, (UWORD) YG_N_NW,  (UWORD) YG_NW_NE, // going SE (delta 1, 1)
      (UWORD) YG_W_NW,  (UWORD) YG_N_S,   (UWORD) YG_E_NW,  // (so starting from NW)
      (UWORD) YG_NW_SW, (UWORD) YG_S_NW,  (UWORD) YG_NW_SE
} } }
};

// 7. MODULE FUNCTIONS ---------------------------------------------------

MODULE void creaturebullet(int x, int y, int deltax, int deltay, UBYTE subspecies, UBYTE creator);
MODULE void creaturecreature(UBYTE which1, UBYTE which2);
MODULE FLAG bouncecreature(UBYTE which, int x, int y);
MODULE void dogqueue(int which, int deltax, int deltay);
MODULE void protcol(int player, int x, int y, SBYTE thisprot);
MODULE void wormbullet(int player);
MODULE void choosediagonal(int* xx, int* yy);
MODULE void chooseorthagonal(int* xx, int* yy);
MODULE void protectorloop1(int player);
MODULE void protectorloop2(int player);
MODULE void turncreature(UBYTE which);
MODULE void reflect(UBYTE which);
MODULE void checkrectangle(int direction, int player, int horizontalsize, int verticalsize);
MODULE void checkdiamond(int direction, int player, int size);
MODULE void checktriangle(int direction, int player, int size);
MODULE void protprot(int x, int y, int player1, int player2);
MODULE void creature_captureorb(int which);
MODULE void worm_captureorb(int player);
MODULE FLAG encloseit(int player, int x, int y);

// 8. CODE ---------------------------------------------------------------

EXPORT void createcreature(UWORD species,
                           UBYTE which,
                           int   x,
                           int   y,
                           int   deltax,
                           int   deltay,
                           int player,
                           UWORD subspecies,
                           UBYTE creator
                          )
{   if (species != ORB && species != CHICKEN && species != SNAKE)
    {   creature[which].deltax  = deltax;
        creature[which].deltay  = deltay;
    }
    if (species != CAMEL)
    {   creature[which].subspecies = subspecies;
    }
    creature[which].visible = (species == MISSILE_C) ? FALSE : TRUE;
    creature[which].last    = field[x][y];
    creature[which].tail    = gfxfield[x][y];
    creature[which].alive   = TRUE;
    creature[which].x       = x;
    creature[which].y       = y;
    creature[which].species = species;
    creature[which].player  = player;
    creature[which].speed   = creatureinfo[sortcreatures[species - FIRSTCREATURE]].speed;
    creature[which].score   = creatureinfo[sortcreatures[species - FIRSTCREATURE]].score;

    switch (species)
    {
    case BIRD:
        creature[which].frame      = 0;
        creature[which].dir        = 1;
    acase BULL:
        if (!arand(1))
        {   creature[which].dir    = 1;
        } else
        {   creature[which].dir    = -1;
        }
        field[x][y] = BULL;
    acase BUTTERFLY:
        creature[which].pos        = 0;
    acase CAMEL:
        creature[which].subspecies = arand(LASTOBJECT);
    acase CYCLONE_C:
        effect(FXGET_CYCLONE);
    acase DOG:
        creature[which].pos      = -1;
        creature[which].dormant  = 0;
    acase EEL:
        creature[which].deltax   = (arand(1) * 2) - 1;
        creature[which].deltay   = (arand(1) * 2) - 1;
        creature[which].pos      = 0;
        creature[which].frame    = 0;
    acase ELEPHANT:
        effect(FXBORN_ELEPHANT);
        creature[which].pos      = 15;
    acase FRAGMENT:
        switch (creature[which].subspecies)
        {
        case BANANA:
            creature[which].player = (SBYTE) arand(3);
            creature[which].score  = POINTS_BANANA;
            creature[which].frame  = 0;
            if (!arand(1))
            {   creature[which].dir = 1;
            } else
            {   creature[which].dir = -1;
            }
        acase CURVER:
            creature[which].pos       = 0;
            creature[which].tonguedir = deltax;
        acase SUPERPULSE:
            creature[which].dormant = (SBYTE) arand(RAND_SUPERPULSE) + ADD_SUPERPULSE;
        }
        creature[which].creator = creator;
    acase FROG:
        if (!arand(2))
        {   creature[which].dir    = 1;
            change2(x, y, FROG, FROGRIGHT);
        } else
        {   creature[which].dir    = -1;
            change2(x, y, FROG, FROGLEFT);
        }
        creature[which].dormant  = 0;
    acase HORSE:
        effect(FXBORN_HORSE);
        creature[which].dir      = (SBYTE) arand(7);
        turncreature(which);
    acase LEMMING:
        if (x < fieldx / 2)
        {   creature[which].deltax = 1;
        } else
        {   creature[which].deltax = -1;
        }
        creature[which].deltay   = 0;
    acase MISSILE_C:
        effect(FXBORN_MISSILE);
        creature[which].frame    = 0;
        creature[which].last     = EMPTY; // not MISSILE_O!
    acase MONKEY:
        effect(FXBORN_MONKEY);
        creature[which].dir      =
        creature[which].pos      = 0;
        creature[which].tonguedir = (SBYTE) arand(2); // 1..2
    acase CHICKEN:
        creature[which].dir      =
        creature[which].pos      = 0;
        creature[which].deltax   = -1;
        creature[which].deltay   = 0;
    acase OCTOPUS:
        creature[which].dir      = -1;
        creature[which].pos      = 0;
    acase ORB:
        creature[which].deltax   = (arand(1) * 2) - 1;
        creature[which].deltay   = (arand(1) * 2) - 1;
        creature[which].kicked   = FALSE;
    acase OTTER:
        if (x == 0)
        {   creature[which].going    = OTTER_DOWN;
            creature[which].journey  = OTTER_RIGHT;
        } else
        {   creature[which].going    = OTTER_UP;
            creature[which].journey  = OTTER_LEFT;
        }
        creature[which].last       = STONE;
    acase PORCUPINE:
        creature[which].dormant = 0;
    acase RABBIT:
        if (deltax == 1)
        {   change2(x, y, RABBIT, RABBITRIGHT);
        } else
        {   assert(deltax == -1);
            change2(x, y, RABBIT, RABBITLEFT);
        }
        // no need to worry about .dir, it is not used for rabbits
    acase RAIN:
        effect(FXBORN_RAIN);
    acase RHINOCEROS:
        effect(FXBORN_RHINO);
    acase SNAKE:
        effect(FXBORN_SNAKE);
        if (!arand(1))
        {   creature[which].deltax = -1;
        } else
        {   creature[which].deltax = 1;
        }
        creature[which].deltay   = 0;
        creature[which].pos      = 0;
    acase SPIDER:
        creature[which].deltax   = 0;
        creature[which].deltay   = 1;
    acase SQUID:
        creature[which].deltax   =
        creature[which].deltay   = 0;
        creature[which].frame    = 0;
    acase TURTLE:
        creature[which].deltax   =
        creature[which].deltay   = 0;
        creature[which].frame    =
        creature[which].dir      = 0;
    }

    if (creature[which].visible)
    {   drawcreature((int) which);
}   }

EXPORT void creatureloop(UBYTE which)
{   UBYTE bestdistance,
          generated,
          distance;
    UWORD c,
          d;
    int   i, j,
          player,
          whichdir,
          x, xx = 0, xxx, xmin, xmax, // initialized to avoid spurious
          y, yy = 0, yyy, ymin, ymax; // GCC compiler warnings
    FLAG  done;
PERSIST struct
{   int deltax,
        deltay;
} dirs[8] =
{ { -1, -1 }, // northwest
  {  0, -1 }, // north
  {  1, -1 }, // northeast
  { -1,  0 }, // west
  {  1,  0 }, // east
  { -1,  1 }, // southwest
  {  0,  1 }, // south
  {  1,  1 }  // southeast
}, curvepath[] = {
  {  1, -1 },
  {  0, -1 },
  {  1, -1 },
  {  1, -1 },
  {  1,  0 },
  {  1,  1 },
  {  1,  1 },
  {  0,  1 },
  {  1,  1 },
  {  0,  1 }, // 9
};

    x = creature[which].x;
    y = creature[which].y;

    if (!valid(x, y)) // defensive programming
    {   creature[which].alive = FALSE;
        return;

        /* TEXT temp1[SAYLIMIT + 1], temp2[8];

        strcpy(temp1, "BAD CREATURE AT x: ");
        stcl_d(temp2, x);
        strcat(temp1, temp2);
        strcat(temp1, ", y: ");
        stcl_d(temp2, y);
        strcat(temp1, temp2);
        strcat(temp1, "!");
        say(temp1, PURPLE);
        draw(fieldx + 1, 0, creature[which].species); // indicates which creature
        Delay(250);
        clearkybd();
        anykey(FALSE, FALSE); */
    }

    /* decide whether and where to move */

    switch (creature[which].species)
    {
    case ANT:
        do
        {   xx = arand(2) - 1;
            yy = arand(2) - 1;
        } while (!valid(x + xx, y + yy));
        if (xx == 0 && yy == 0)
        {   if (valid(x + creature[which].deltax, y + creature[which].deltay))
            {   xx = creature[which].deltax;
                yy = creature[which].deltay;
            } else
            {   xx = -creature[which].deltax;
                yy = -creature[which].deltay;
        }   }
        creature[which].deltax = xx;
        creature[which].deltay = yy;
    acase BEAR:
    case FISH:
        do
        {   xx = arand(2) - 1;
            yy = arand(2) - 1;
        } while
        (   (xx == 0 && yy == 0)
         || !valid(x + xx, y + yy)
        );
        c = field[x + xx][y + yy];
        if
        (   c == SLIME
         || c == WOOD
         || c == STONE
         || c == METAL
         || (c >= FIRSTTAIL && c <= LASTTAIL)
         || (c >= FIRSTGLOW && c <= LASTGLOW)
        )
        {   creature[which].deltax = xx;
            creature[which].deltay = yy;

            if (creature[which].species == BEAR)
            {   if   (c == STONE                     ) creature[which].nextlast = METAL;
                elif (c == WOOD                      ) creature[which].nextlast = STONE;
                elif (c >= FIRSTTAIL && c <= LASTTAIL) creature[which].nextlast = WOOD;
                elif (c >= FIRSTGLOW && c <= LASTGLOW)
                {   creature[which].nextlast = c - FIRSTGLOW + FIRSTTAIL;
                    creature[which].nexttail = gfxfield[x + xx][y + yy] - 29;
                } else // SLIME
                {   creature[which].nextlast = c;
            }   }
            elif (creature[which].species == FISH)
            {   if (c >= FIRSTTAIL && c <= LASTTAIL)
                {   creature[which].nextlast = c - FIRSTTAIL + FIRSTGLOW;
                    creature[which].nexttail = gfxfield[x + xx][y + yy] + 29;
                } elif (c >= FIRSTGLOW && c <= LASTGLOW)
                {   creature[which].nextlast = c;
                    creature[which].nexttail = gfxfield[x + xx][y + yy];
                } else
                {   creature[which].nextlast = c;
        }   }   }
        else
        {   creature[which].deltax =
            creature[which].deltay = 0;
        }
    acase BIRD:
        if (creature[which].player == -1)
        {   bestdistance = 255;
            for (player = 0; player <= 3; player++)
            {   if (worm[player].lives)
                {   xx = abs(worm[player].x - x);
                    yy = abs(worm[player].y - y);
                    if (xx > yy)
                        distance = (UBYTE) xx;
                    else distance = (UBYTE) yy;
                    if (distance <= DISTANCE_BIRD && distance < bestdistance)
                    {   effect(FXBORN_BIRD);
                        bestdistance = distance;
                        creature[which].player = player;
        }   }   }   }
        if (creature[which].player != -1) // if swooping
        {   assert(creature[which].player >= 0 && creature[which].player <= 3);
            if (worm[creature[which].player].lives)
            {   creature[which].deltax = isign(worm[creature[which].player].x - x);
                creature[which].deltay = isign(worm[creature[which].player].y - y);
            } else
            {   creature[which].player = -1; // return to dormancy
                creature[which].deltax = creature[which].deltay = 0;
        }   }
    acase BUTTERFLY:
        if (creature[which].pos)
        {   creature[which].deltax = arand(2) - 1;
            creature[which].deltay = arand(2) - 1;
            creature[which].pos--;
        } else
        {   creature[which].deltax = creature[which].deltay = 0;
        }
    acase CAMEL:
        xx = x + creature[which].deltax;
        yy = y + creature[which].deltay;
        if
        (   !arand(FREQ_CAMELTURN)
         || ((!creature[which].deltax) && (!creature[which].deltay))
         || !valid(xx, yy)
         || field[xx][yy] < FIRSTEMPTY
         || field[xx][yy] > LASTEMPTY
        )
        {   do
            {   xx = arand(2) - 1;
                yy = arand(2) - 1;
            } while (!valid(x + xx, y + yy));
            c = field[x + xx][y + yy];
            if (c >= FIRSTEMPTY && c <= LASTEMPTY)
            {   creature[which].deltax = xx;
                creature[which].deltay = yy;
            } else
            {   creature[which].deltax = 0;
                creature[which].deltay = 0;
        }   }
        if
        (   (creature[which].deltax || creature[which].deltay)
         && (!arand(FREQ_CAMELDROP))
        )
        {   creature[which].last = creature[which].subspecies;
        } else creature[which].last = EMPTY;
    acase CHICKEN:
        if (creature[which].pos == creature[which].dir)
        {   if (creature[which].deltax == 0 && creature[which].deltay == -1) // if up
            {   creature[which].deltax =  1; // right
                creature[which].deltay =  0;
            } elif (creature[which].deltax == 1 && creature[which].deltay == 0) // if right
            {   creature[which].deltax =  0; // down
                creature[which].deltay =  1;
                creature[which].dir++;
            } elif (creature[which].deltax == 0 && creature[which].deltay == 1) // if down
            {   creature[which].deltax = -1; // left
                creature[which].deltay =  0;
            } else
            {   assert(creature[which].deltax == -1 && creature[which].deltay == 0); // if left
                creature[which].deltax =  0; // up
                creature[which].deltay = -1;
                creature[which].dir++;
            }
            creature[which].pos = 0;
        } else
        {   creature[which].pos++;
        }
    acase CLOUD:
    case SNAKE:
        if
        (   creature[which].x == 0
         || creature[which].x == fieldx
         || field[x + creature[which].deltax][y + creature[which].deltay] == METAL
         || field[x + creature[which].deltax][y + creature[which].deltay] == STONE
         || field[x + creature[which].deltax][y + creature[which].deltay] == WOOD
        )
        {   creature[which].deltax = -creature[which].deltax;
        }
    acase CYCLONE_C:
        /* Cyclones have a slight upwards drift.
        Higher values of WEIGHT make them less buoyant. */

        creature[which].deltax = arand(2) - 1;
        if (!arand(WEIGHT))
            creature[which].deltay = arand(1) - 1;
        else creature[which].deltay = arand(2) - 1;
    acase DOG:
        /* remove a movement from the dog queue */

        if (creature[which].dormant == CHASING)
        {   if (creature[which].pos != -1)
            {   creature[which].deltax = thedogqueue[which][0].deltax;
                creature[which].deltay = thedogqueue[which][0].deltay;
                if (level == 0 && bonustype == BONUSLEVEL_DOGS)
                {   wormscore(creature[which].player, 1);
                }
                creature[which].pos--;
                if (creature[which].pos != -1)
                {   for (i = 0; i <= creature[which].pos; i++)
                    {   thedogqueue[which][i].deltax = thedogqueue[which][i + 1].deltax;
                        thedogqueue[which][i].deltay = thedogqueue[which][i + 1].deltay;
        }   }   }   }
        elif (creature[which].dormant > 0)
        {   creature[which].dormant++;
            drawcreature((int) which);
        }
    acase EEL:
        if
        (   creature[which].x == 0
         || creature[which].x == fieldx
         || field[x + creature[which].deltax][y + creature[which].deltay] == METAL
         || field[x + creature[which].deltax][y + creature[which].deltay] == STONE
         || field[x + creature[which].deltax][y + creature[which].deltay] == WOOD
        )
        {   creature[which].deltax = -creature[which].deltax;
        }
        creature[which].pos += creature[which].deltay;
        if (creature[which].pos == -1)
        {   creature[which].deltay = 1;
        } elif (creature[which].pos == 1)
        {   creature[which].deltay = -1;
        }
    acase ELEPHANT:
        /* 01234
           F   5
           E   6
           D   7
           CBA98 */

        if (creature[which].pos == 15)
        {   creature[which].pos = 0;
        } else creature[which].pos++;

        if (creature[which].pos == 0)
        {   creature[which].deltax =  1;
            creature[which].deltay =  0;
        } elif (creature[which].pos == 4)
        {   creature[which].deltax =  0;
            creature[which].deltay =  1;
        } elif (creature[which].pos == 8)
        {   creature[which].deltax = -1;
            creature[which].deltay =  0;
        } elif (creature[which].pos == 12)
        {   creature[which].deltax =  0;
            creature[which].deltay = -1;
        }
    acase FRAGMENT:
        if (creature[which].subspecies == CURVER)
        {   if (creature[which].tonguedir < 0)
            {   creature[which].deltax = -curvepath[creature[which].pos].deltax;
            } else
            {   creature[which].deltax =  curvepath[creature[which].pos].deltax;
            }
            creature[which].deltay = curvepath[creature[which].pos].deltay;
            if (creature[which].pos < 9)
            {   creature[which].pos++;
        }   }
    acase FROG:
        // creature[which].dormant of 0 means it is idle and might decide to hop
        if (creature[which].deltax != 0 || creature[which].deltay != 0)
        {   creature[which].deltax = 0;
            creature[which].deltay = 0;
        } elif (creature[which].dormant == 0 && !arand(FREQ_FROGMOVE))
        {   xx = arand(6) - 3;
            yy = arand(6) - 3;
            if
            (   (xx != 0 || yy != 0)
             && valid(x + xx, y + yy)
             && field[x + xx][y + yy] >= FIRSTEMPTY
             && field[x + xx][y + yy] <= LASTEMPTY
            )
            {   creature[which].deltax = xx;
                creature[which].deltay = yy;
                if (!arand(1))
                {   creature[which].dir = -1;
                } else
                {   creature[which].dir = 1;
        }   }   }
    acase GOOSE:
        chooseorthagonal(&(creature[which].deltax), &(creature[which].deltay));
    acase HORSE:
        if (!arand(FREQ_HORSETURN))
        {   if (!arand(1))
            {   if (creature[which].dir == 0)
                {   creature[which].dir = 7;
                } else
                {   creature[which].dir--;
            }   }
            else
            {   if (creature[which].dir == 7)
                {   creature[which].dir = 0;
                } else
                {   creature[which].dir++;
            }   }
            turncreature(which);
        }
    acase KOALA:
        do
        {   creature[which].deltax = arand(2) - 1;
            creature[which].deltay = arand(2) - 1;
        } while (creature[which].deltax == 0 && creature[which].deltay == 0);
    acase KANGAROO:
        creature[which].deltax = isign(creature[which].deltax);
        creature[which].deltay = isign(creature[which].deltay);
        if
        (   ((!creature[which].deltax) && (!creature[which].deltay))
         || !arand(FREQ_KANGAROOTURN)
        )
        {   do
            {   xx = arand(2) - 1;
                yy = arand(2) - 1;
            } while (!valid(x + xx, y + yy));
            c = field[x + xx][y + yy];
            if (c >= FIRSTEMPTY && c <= LASTEMPTY)
            {   creature[which].deltax = xx;
                creature[which].deltay = yy;
            } else
            {   creature[which].deltax = 0;
                creature[which].deltay = 0;
        }   }
        else
        {   c = field[xwrap(x + creature[which].deltax)][ywrap(y + creature[which].deltay)];
            if (c < FIRSTEMPTY || c > LASTEMPTY)
            {   c = field[xwrap(x + (creature[which].deltax * 2))][ywrap(y + (creature[which].deltay * 2))];
                if (c >= FIRSTEMPTY && c <= LASTEMPTY)
                {   creature[which].deltax *= 2;
                    creature[which].deltay *= 2;
                } else
                {   c = field[xwrap(x - creature[which].deltax)][ywrap(y - creature[which].deltay)];
                    if (c >= FIRSTEMPTY && c <= LASTEMPTY)
                    {   creature[which].deltax = -creature[which].deltax;
                        creature[which].deltay = -creature[which].deltay;
                    } else
                    {   creature[which].deltax =
                        creature[which].deltay = 0;
        }   }   }   }
    acase MISSILE_C:
        bestdistance = 255;
        for (player = 0; player <= 3; player++)
        {   if (creature[which].player != player && worm[player].lives)
            {   xx = abs(worm[player].x - x);
                yy = abs(worm[player].y - y);
                if (xx < yy)
                {   distance = (UBYTE) xx;
                } else distance = (UBYTE) yy;
                if (distance < bestdistance)
                {   bestdistance = distance;
                    creature[which].deltax = isign(worm[player].x - x);
                    creature[which].deltay = isign(worm[player].y - y);
            }   }
            for (i = 0; i <= CREATURES; i++)
            {   if
                (   creature[i].alive
                 && which != i
                 && creature[i].player != player
                )
                {   xx = abs(creature[i].x - x);
                    yy = abs(creature[i].y - y);
                    if (xx < yy)
                    {   distance = (UBYTE) xx;
                    } else distance = (UBYTE) yy;
                    if (distance < bestdistance)
                    {   bestdistance = distance;
                        creature[which].deltax = isign(creature[i].x - x);
                        creature[which].deltay = isign(creature[i].y - y);
        }   }   }   }
        if (bestdistance == 255)
        {   creature[which].alive = FALSE;
            change1(x, y, EMPTY);
        }
    acase MONKEY:
        creature[which].pos += creature[which].dir;
        if (creature[which].pos == 0) // monkey never stops moving
        {   choosediagonal(&(creature[which].deltax), &(creature[which].deltay));
            creature[which].dir = 1;
        } elif (creature[which].pos == 5)
        {   creature[which].deltax = -creature[which].deltax;
            creature[which].deltay = -creature[which].deltay;
            creature[which].dir = -1;
        }
    acase MOUSE:
        bestdistance = 255;
        if (x - DISTANCE_MOUSE < 0)
        {   xmin = 0;
        } else xmin = x - DISTANCE_MOUSE;
        if (x + DISTANCE_MOUSE > fieldx)
        {   xmax = fieldx;
        } else xmax = x + DISTANCE_MOUSE;
        if (y - DISTANCE_MOUSE < 0)
        {   ymin = 0;
        } else ymin = y - DISTANCE_MOUSE;
        if (y + DISTANCE_MOUSE > fieldy)
        {   ymax = fieldy;
        } else ymax = y + DISTANCE_MOUSE;

        for (xx = xmin; xx <= xmax; xx++)
        {   for (yy = ymin; yy <= ymax; yy++)
            {   assert(valid(xx, yy));
                if (field[xx][yy] <= LASTOBJECT)
                {   xxx = abs(xx - x);
                    yyy = abs(yy - y);
                    if (xxx < yyy)
                    {   distance = (UBYTE) xxx;
                    } else distance = (UBYTE) yyy;
                    if (distance < bestdistance)
                    {   bestdistance = distance;
                        creature[which].deltax = isign(xx - x);
                        creature[which].deltay = isign(yy - y);
        }   }   }   }

        if (bestdistance == 255)
        {   creature[which].deltax =
            creature[which].deltay = 0;
        }
    acase OCTOPUS:
        if (!arand(FREQ_OCTOPUSMOVE))
        {   if (creature[which].pos == 0)
            {   do
                {   creature[which].firex = arand(2) - 1;
                    creature[which].firey = arand(2) - 1;
                } while (creature[which].firex == 0 && creature[which].firey == 0);
                creature[which].deltax = creature[which].firex;
                creature[which].deltay = creature[which].firey;
                creature[which].pos    = 1;
            } else
            {   creature[which].deltax = -creature[which].firex;
                creature[which].deltay = -creature[which].firey;
                creature[which].pos    = 0;
        }   }
        else
        {   creature[which].deltax = 0;
            creature[which].deltay = 0;
        }
    acase OTTER:
        if (secondsleft)
        {   return;
        }
        if (creature[which].journey == OTTER_RIGHT)
        {   switch (creature[which].going)
            {
            case OTTER_DOWN:
                if (creature[which].y == fieldy)
                {   if (creature[which].x == fieldx)
                    {   creature[which].journey = OTTER_LEFT;
                        creature[which].going = OTTER_UP;
                    } else
                    {   creature[which].going = OTTER_RIGHT;
                        creature[which].then  = OTTER_UP;
                }   }
            acase OTTER_RIGHT:
                creature[which].going = creature[which].then;
            acase OTTER_UP:
                if (creature[which].y == 0)
                {   if (creature[which].x == fieldx)
                    {   creature[which].journey = OTTER_LEFT;
                        creature[which].going = OTTER_DOWN;
                    } else
                    {   creature[which].going = OTTER_RIGHT;
                        creature[which].then  = OTTER_DOWN;
        }   }   }   }
        else
        {   assert(creature[which].journey == OTTER_LEFT);
            switch (creature[which].going)
            {
            case OTTER_DOWN:
                if (creature[which].y == fieldy)
                {   if (creature[which].x == 0)
                    {   creature[which].journey = OTTER_RIGHT;
                        creature[which].going = OTTER_UP;
                    } else
                    {   creature[which].going = OTTER_LEFT;
                        creature[which].then  = OTTER_UP;
                }   }
            acase OTTER_LEFT:
                creature[which].going = creature[which].then;
            acase OTTER_UP:
                if (creature[which].y == 0)
                {   if (creature[which].x == 0)
                    {   creature[which].journey = OTTER_RIGHT;
                        creature[which].going = OTTER_DOWN;
                    } else
                    {   creature[which].going = OTTER_LEFT;
                        creature[which].then  = OTTER_DOWN;
        }   }   }   }

        if (creature[which].going == OTTER_RIGHT)
        {   creature[which].deltax = 1;
            creature[which].deltay = 0;
        } elif (creature[which].going == OTTER_LEFT)
        {   creature[which].deltax = -1;
            creature[which].deltay = 0;
        } elif (creature[which].going == OTTER_UP)
        {   creature[which].deltax = 0;
            creature[which].deltay = -1;
        } elif (creature[which].going == OTTER_DOWN)
        {   creature[which].deltax = 0;
            creature[which].deltay = 1;
        }
    acase PANDA:
        bestdistance = 255;
        if (x - DISTANCE_PANDA < 0)
        {   xmin = 0;
        } else xmin = x - DISTANCE_PANDA;
        if (x + DISTANCE_PANDA > fieldx)
        {   xmax = fieldx;
        } else xmax = x + DISTANCE_PANDA;
        if (y - DISTANCE_PANDA < 0)
        {   ymin = 0;
        } else ymin = y - DISTANCE_PANDA;
        if (y + DISTANCE_PANDA > fieldy)
        {   ymax = fieldy;
        } else ymax = y + DISTANCE_PANDA;

        for (i = 0; i <= CREATURES; i++)
        {   if
            (   which != i
             && creature[i].alive
             && creature[i].x >= xmin
             && creature[i].x <= xmax
             && creature[i].y >= ymin
             && creature[i].y <= ymax
            )
            {   xxx = abs(creature[i].x - x);
                yyy = abs(creature[i].y - y);
                if (xxx < yyy)
                {   distance = (UBYTE) xxx;
                } else distance = (UBYTE) yyy;
                if (distance < bestdistance)
                {   bestdistance = distance;
                    creature[which].deltax = isign(creature[i].x - x);
                    creature[which].deltay = isign(creature[i].y - y);
        }   }   }

        if (bestdistance == 255)
        {   xx = creature[which].deltax;
            yy = creature[which].deltay;

            if
            (   (!valid(x + xx, y + yy))
             || (xx == 0 && yy == 0)
             || (field[x + xx][y + yy] > LASTOBJECT && (field[x + xx][y + yy] < FIRSTEMPTY || field[x + xx][y + yy] > LASTEMPTY))
            )
            {   do
                {   xx = arand(2) - 1;
                    yy = arand(2) - 1;
                } while (!valid(x + xx, y + yy));
                if
                (   field[x + xx][y + yy] <= LASTOBJECT
                 || (field[x + xx][y + yy] >= FIRSTEMPTY && field[x + xx][y + yy] <= LASTEMPTY)
                )
                {   creature[which].deltax = xx;
                    creature[which].deltay = yy;
                } else
                {   creature[which].deltax = 0;
                    creature[which].deltay = 0;
        }   }   }
    acase PORCUPINE:
        if (!arand(FREQ_PORCUPINEMOVE))
        {   creature[which].deltax = arand(2) - 1;
            creature[which].deltay = arand(2) - 1;
        } else
        {   creature[which].deltax =
            creature[which].deltay = 0;
        }
    acase RABBIT:
        if (creature[which].deltax < 0)
        {   creature[which].deltax = -1;
        } elif (creature[which].deltax > 0)
        {   creature[which].deltax = 1;
        }
        done = FALSE;
        do
        {   xx = x + creature[which].deltax; // see what's ahead
            if (!valid(xx, y)) // die
            {   creature[which].alive = FALSE;
                change1(x, y, (UWORD) (FIRSTCHERRY + (rand() % 4)));
                done = TRUE;
            } elif
            (    field[xx][y] > LASTOBJECT
             && (field[xx][y] < FIRSTEMPTY || field[xx][y] > LASTEMPTY)
            ) // try to jump
            {   if (creature[which].deltax < 0)
                {   creature[which].deltax--;
                } elif (creature[which].deltax > 0)
                {   creature[which].deltax++;
            }   }
            else
            {   done = TRUE;
        }   }
        while (!done);
    acase RHINOCEROS:
    case SNAIL:
        xx = creature[which].deltax;
        yy = creature[which].deltay;
        if
        (   (!valid(x + xx, y + yy))
         || (xx == 0 && yy == 0)
         || (field[x + xx][y + yy] > LASTOBJECT && (field[x + xx][y + yy] < FIRSTEMPTY || field[x + xx][y + yy] > LASTEMPTY))
        )
        {   do
            {   xx = arand(2) - 1;
                yy = arand(2) - 1;
            } while (!valid(x + xx, y + yy));
            if
            (   field[x + xx][y + yy] <= LASTOBJECT
             || (field[x + xx][y + yy] >= FIRSTEMPTY && field[x + xx][y + yy] <= LASTEMPTY)
            )
            {   creature[which].deltax = xx;
                creature[which].deltay = yy;
            } else
            {   creature[which].deltax = 0;
                creature[which].deltay = 0;
        }   }
    acase SALAMANDER:
        do
        {   choosediagonal(&(creature[which].deltax), &(creature[which].deltay));
        } while (!valid(creature[which].x + creature[which].deltax, creature[which].y + creature[which].deltay));
    acase SPIDER:
        if
        (   !valid(x + creature[which].deltax, y + creature[which].deltay)
         || iswall(x + creature[which].deltax, y + creature[which].deltay)
        )
        {   creature[which].deltay = -creature[which].deltay;
        }
        if (creature[which].deltay < 0)
        {   creature[which].last = EMPTY;
        } else
        {   creature[which].last = SPIDERSILK;
        }
    acase SQUID:
        if (!arand(FREQ_SQUIDTURN))
        {   creature[which].deltax = arand(2) - 1; // -1, 0 or +1
            if (y > 10)
            {   creature[which].deltay = -1;
        }   }
        else
        {   creature[which].deltay = 0;
        }
        if (!valid(x + creature[which].deltax, y))
        {   creature[which].deltax = -creature[which].deltax;
        }
    acase TERMITE:
        done = FALSE;
        whichdir = arand(7); // 0..7
        for (i = 0; i < 8; i++) // 0..7
        {   j = whichdir + i;
            if (j >= 8) j -= 8;
            xx = dirs[j].deltax;
            yy = dirs[j].deltay;
            if (valid(x + xx, y + yy) && field[x + xx][y + yy] == WOOD) // find wood
            {   creature[which].deltax = xx;
                creature[which].deltay = yy;
                done = TRUE;
                break;
        }   }
        if (!done)
        {   for (i = 0; i < 8; i++) // 0..7
            {   j = whichdir + i;
                if (j >= 8) j -= 8;
                xx = dirs[j].deltax;
                yy = dirs[j].deltay;
                if (valid(x + xx, y + yy) && field[x + xx][y + yy] >= FIRSTTAIL && field[x + xx][y + yy] <= LASTTAIL) // find dim tail
                {   creature[which].deltax = xx;
                    creature[which].deltay = yy;
                    done = TRUE;
                    break;
            }   }
            if (!done)
            {   for (i = 0; i < 8; i++) // 0..7
                {   j = whichdir + i;
                    if (j >= 8) j -= 8;
                    xx = dirs[j].deltax;
                    yy = dirs[j].deltay;
                    if (valid(x + xx, y + yy) && field[x + xx][y + yy] >= FIRSTEMPTY && field[x + xx][y + yy] <= LASTEMPTY) // find empty
                    {   creature[which].deltax = xx;
                        creature[which].deltay = yy;
                        done = TRUE;
                        break;
                }   }
                if (!done)
                {   creature[which].deltax = creature[which].deltay = 0; // give up, don't move
        }   }   }
    acase TURTLE:
        if
        (   creature[which].frame == 0
         && creature[which].dir   == 0
         && !arand(FREQ_TURTLEMOVE)
        )
        {   creature[which].deltay = -1;
        } else
        {   creature[which].deltay = 0;
            if (!arand(FREQ_TURTLECHANGE))
            {   if (creature[which].frame == 0)
                {   creature[which].dir = 1;
                } elif (creature[which].frame == 3)
                {   creature[which].dir = -1;
            }   } // else do nothing (already changing)
            creature[which].frame += creature[which].dir;
            if (creature[which].frame == 0 || creature[which].frame == TURTLEFRAMES - 1)
            {   creature[which].dir = 0;
        }   }
    acase ZEBRA:
        if (!valid(x + creature[which].deltax, y + creature[which].deltay))
        {   creature[which].deltax = -creature[which].deltax;
            creature[which].deltay = -creature[which].deltay;
        } elif
        (   (creature[which].deltax == 0 && creature[which].deltay == 0) // they can be created like that
         || (!arand(FREQ_ZEBRATURN))
        )
        {   do
            {   creature[which].deltax = arand(2) - 1;
                creature[which].deltay = arand(2) - 1;
            } while (creature[which].deltax == 0 && creature[which].deltay == 0);
        }
    // adefault: bull, giraffe, orb
    }

    /* now move */

    if (creature[which].deltax || creature[which].deltay)
    {   if (creature[which].visible)
        {   /* erase previous image */
            if
            (   (creature[which].last >= FIRSTDIM  && creature[which].last <= LASTDIM )
             || (creature[which].last >= FIRSTGLOW && creature[which].last <= LASTGLOW)
            )
            {   change2(x, y, creature[which].last, creature[which].tail);
            } else
            {   change1(x, y, creature[which].last);
            }

            switch (creature[which].species)
            {
            case BEAR: case FISH: creature[which].last = creature[which].nextlast;
                                  creature[which].tail = creature[which].nexttail;
            acase GOOSE:          creature[which].last = GOLD;
            acase OCTOPUS:        creature[which].last = FIRSTCHERRY + arand(3);
            acase OTTER:          creature[which].last = STONE;
            adefault:             creature[which].last = EMPTY;
        }   }

        if (creature[which].alive)
        {   creature[which].x += creature[which].deltax;
            creature[which].y += creature[which].deltay;
            if
            (   (creature[which].species == ORB && !creature[which].kicked)
             || creature[which].species == HORSE
             || creature[which].species == MONKEY
            )
            {   creature[which].x = xwrap(creature[which].x);
                creature[which].y = ywrap(creature[which].y);
            } elif (!valid(creature[which].x, creature[which].y))
            {   if (creature[which].species == BULL && level == 0 && bonustype == BONUSLEVEL_BULLS)
                {   wormscore(creature[which].player, POINTS_BULLBONUS);
                }
                creature[which].alive = FALSE;
    }   }   }

    if (creature[which].species == ORB)
    {   creature_captureorb(which);
    }

    creature[which].visible = TRUE;
    x = creature[which].x;
    y = creature[which].y;

    // Collision detection.

    if
    (    creature[which].alive
     &&  creature[which].species != FISH
     &&  creature[which].species != BEAR
     &&  creature[which].species != GIRAFFE
     && (creature[which].deltax || creature[which].deltay)
    )
    {   c = field[x][y];

        if     (c >= FIRSTHEAD && c <= LASTHEAD)
        {   wormcreature((SBYTE) (c - FIRSTHEAD     ), which);
        } elif (c >= FIRSTPROTECTOR && c <= LASTPROTECTOR)
        {   protcreature((SBYTE) (c - FIRSTPROTECTOR), which);
        } elif (c >= FIRSTFRUIT && c <= LASTFRUIT)
        {   isfruit = FALSE;
            updatearrow(y);
        } elif
        (   (c >= FIRSTTAIL && c <= LASTTAIL)
         || (c >= FIRSTGLOW && c <= LASTGLOW)
        )
        {   if (creature[which].species == ORB && !creature[which].kicked)
            {   reflect(which);
        }   }
        elif
        (   (c >= FIRSTNUMBER && c <= LASTNUMBER)
         || (c >= FIRSTGRAVE  && c <= LASTGRAVE )
         ||  c == FROGTONGUE
         ||  c == START
        )
        {   creature[which].alive = FALSE;
        } elif (c == SPIDERSILK)
        {   if (creature[which].species != SPIDER && creature[which].species != OTTER)
            {   creature[which].alive = FALSE;
        }   }
        elif (c >= FIRSTCREATURE && c <= LASTCREATURE)
        {   i = whichcreature(x, y, c, which);
            creaturecreature(which, (UBYTE) i);
        } elif
        (   c == METAL
         || c == STONE
         || c == WOOD
        )
        {   if (!creatureinfo[sortcreatures[creature[which].species - FIRSTCREATURE]].wall)
            {   if
                (   (creature[which].species == ORB && !creature[which].kicked)
                 || (c == METAL && creature[which].species == FRAGMENT)
                )
                {   effect(FXUSE_ARMOUR);
                    reflect(which);
                } elif (creature[which].species == ZEBRA)
                {   bombblast(ORB, (SBYTE) which, creature[which].x, creature[which].y, FALSE, 0);
                    creature[which].alive = FALSE;
                } elif
                (   creature[which].species != OTTER
                 && creature[which].species != CYCLONE_C
                 && creature[which].species != ANT
                 && creature[which].species != MISSILE_C
                 && creature[which].species != TERMITE
                )
                {   creature[which].alive = FALSE;
        }   }   }
        elif (c == TELEPORT)
        {   i = (UBYTE) whichteleport(x, y);
            if (blockedtel((UBYTE) i, creature[which].deltax, creature[which].deltay))
                creature[which].alive = FALSE;
            else
            {   effect(FXUSE_TELEPORT);
                teleportcreature((UBYTE) i, which);

                if (creature[which].species == ORB)
                {   creature[which].x = xwrap(creature[which].x);
                    creature[which].y = ywrap(creature[which].y);
                } else
                {   if (!(valid(creature[which].x, creature[which].y)))
                        creature[which].alive = FALSE;
                    if (creature[which].species == FRAGMENT)
                        creature[which].last = SILVER;
        }   }   }
        elif
        (   c <= LASTOBJECT
         && creature[which].species != MOUSE
         && creature[which].species != OTTER
        )
        {   switch (c)
            {
            case MINIBOMB:
                drawcreature((int) which);
                bombblast(ORB, (SBYTE) which, x, y, FALSE, 0);
            acase SUPERBOMB:
                drawcreature((int) which);
                bombblast(ORB, (SBYTE) which, x, y, TRUE, 0);
            acase PROTECTOR:
                effect(FXGET_OBJECT);
                for (player = 0; player <= 3; player++)
                {   if (worm[player].lives)
                    {   for (i = 0; i <= PROTECTORS; i++)
                        {   if (protector[player][i].alive)
                            {   protector[player][i].alive = FALSE;
                                if (protector[player][i].visible)
                                {   change1(protector[player][i].x, protector[player][i].y, EMPTY);
                }   }   }   }   }
            acase MISSILE_O:
                effect(FXGET_OBJECT);
                for (i = 0; i <= CREATURES; i++)
                {   if (creature[i].alive && creature[i].species == MISSILE_C)
                    {   creature[i].alive = FALSE;
                        change1(creature[i].x, creature[i].y, EMPTY);
                }   }
            acase MULTIPLIER:
                effect(FXGET_OBJECT);
                for (player = 0; player <= 3; player++)
                {   if (worm[player].lives)
                    {   worm[player].multi = 1;
                        stat(player, BONUS);
                }   }
            acase AFFIXER:
                effect(FXGET_OBJECT);
                for (player = 0; player <= 3; player++)
                {   if (worm[player].lives)
                    {   worm[player].affixer = FALSE;
                        icon(player, AFFIXER);
                }   }
            acase BACKWARDS:
                effect(FXGET_POWERUP);
                for (player = 0; player <= 3; player++)
                {   if (worm[player].lives && worm[player].backwards)
                    {   worm[player].backwards = FALSE;
                        icon(player, BACKWARDS);
                }   }
            acase FORWARDS:
                effect(FXGET_POWERUP);
                for (player = 0; player <= 3; player++)
                {   if (worm[player].lives && worm[player].forwards)
                    {   worm[player].forwards = FALSE;
                        icon(player, FORWARDS);
                }   }
            acase GRENADE:
                effect(FXGET_POWERUP);
                for (player = 0; player <= 3; player++)
                {   if (worm[player].lives && worm[player].grenade)
                    {   worm[player].grenade = FALSE;
                        icon(player, GRENADE);
                }   }
            acase REMNANTS:
                effect(FXGET_OBJECT);
                for (player = 0; player <= 3; player++)
                {   if (worm[player].lives)
                    {   worm[player].remnants = FALSE;
                        icon(player, REMNANTS);
                }   }
            acase SIDESHOT:
                effect(FXGET_POWERUP);
                for (player = 0; player <= 3; player++)
                {   if (worm[player].lives && worm[player].sideshot)
                    {   worm[player].sideshot = FALSE;
                        icon(player, SIDESHOT);
                }   }
            acase PUSHER:
                effect(FXGET_OBJECT);
                for (player = 0; player <= 3; player++)
                {   if (worm[player].lives && worm[player].pusher)
                    {   worm[player].pusher = FALSE;
                        icon(player, PUSHER);
                }   }
            acase ENCLOSER:
                effect(FXGET_OBJECT);
                for (player = 0; player <= 3; player++)
                {   if (worm[player].lives && worm[player].encloser)
                    {   worm[player].encloser = FALSE;
                        icon(player, ENCLOSER);
                }   }
            acase GLOW:
                effect(FXGET_OBJECT);
                for (xx = 0; xx <= fieldx; xx++)
                {   for (yy = 0; yy <= fieldy; yy++)
                    {   if (field[xx][yy] >= FIRSTGLOW && field[xx][yy] <= LASTGLOW)
                        {   change1(xx, yy, EMPTY);
                }   }   }
            acase SWITCHER:
                effect(FXGET_OBJECT);
                for (xx = 0; xx <= fieldx; xx++)
                {   for (yy = 0; yy <= fieldy; yy++)
                    {   if (field[xx][yy] >= FIRSTTAIL && field[xx][yy] <= LASTTAIL)
                        {   change1(xx, yy, WOOD);
                }   }   }
            acase GROWER:
                effect(FXGET_GROWER);

                // grow frost
                for (xx = 0; xx <= fieldx; xx++)
                {   for (yy = 0; yy <= fieldy; yy++)
                    {   if (field[xx][yy] == FROST)
                        {   for (xxx = xx - 1; xxx <= xx + 1; xxx++)
                            {   for (yyy = yy - 1; yyy <= yy + 1; yyy++)
                                {   if (valid(xxx, yyy) && field[xxx][yyy] == EMPTY)
                                    {   field[xxx][yyy] = TEMPFROST;
                }   }   }   }   }   }

                // grow wood
                for (xx = 0; xx <= fieldx; xx++)
                {   for (yy = 0; yy <= fieldy; yy++)
                    {   if (field[xx][yy] == WOOD)
                        {   for (xxx = xx - 1; xxx <= xx + 1; xxx++)
                            {   for (yyy = yy - 1; yyy <= yy + 1; yyy++)
                                {   if (valid(xxx, yyy) && (field[xxx][yyy] == EMPTY || field[xxx][yyy] == TEMPFROST))
                                    {   field[xxx][yyy] = TEMPWOOD;
                }   }   }   }   }   }

                // update field
                for (xx = 0; xx <= fieldx; xx++)
                {   for (yy = 0; yy <= fieldy; yy++)
                    {   switch (field[xx][yy])
                        {
                        case TEMPWOOD:
                            change1(xx, yy, WOOD);
                        acase TEMPFROST:
                            change1(xx, yy, FROST);
                }   }   }
            acase AUTOJUMP:
                effect(FXGET_OBJECT);
                for (player = 0; player <= 3; player++)
                {   if (worm[player].lives && worm[player].autojump)
                    {   worm[player].autojump = FALSE;
                        icon(player, AUTOJUMP);
                }   }
            acase AUTOTURN:
                effect(FXGET_OBJECT);
                for (player = 0; player <= 3; player++)
                {   if (worm[player].lives && worm[player].autoturn)
                    {   worm[player].autoturn = FALSE;
                        icon(player, AUTOTURN);
                }   }
            acase CUTTER:
                effect(FXGET_OBJECT);
                for (player = 0; player <= 3; player++)
                {   if (worm[player].lives && worm[player].cutter)
                    {   worm[player].cutter = 0;
                        icon(player, CUTTER);
                }   }
            adefault:
                effect(FXGET_OBJECT);
                creature[which].speed = speedup(creature[which].speed, -1);
    }   }   }

    x = creature[which].x; // These are refreshed in case a
    y = creature[which].y; // fragment has been reflected.

    if
    (   creature[which].alive
     && creature[which].visible
     && (creature[which].deltax || creature[which].deltay || creature[which].species == SQUID || creature[which].species == TURTLE)
    )
    {   drawcreature((int) which);
    }

    if (creature[which].alive)
    {   /* decide whether to fire */
        switch (creature[which].species)
        {
        case CLOUD:
            if (!arand(FREQ_CLOUDFIRE))
            {   creaturebullet(x, y,  0, -1, FRAGMENT, CLOUD);
            }
            if (!arand(FREQ_CLOUDRAIN))
            {   if (creature[which].y != fieldy)
                {   c = field[x][y + 1];
                    if (c >= FIRSTEMPTY && c <= LASTEMPTY)
                    {   for (i = 0; i <= CREATURES; i++)
                        {   if (!creature[i].alive)
                            {   createcreature(RAIN, (UBYTE) i, x, y + 1, 0, 1, (SBYTE) ((r / 16) % 4), ANYTHING, ANYTHING);
                                break;
            }   }   }   }   }
        acase EEL:
            if (!arand(FREQ_EELFIRE))
            {   effect(FXGET_LIGHTNING);
                for (xx = x - 3; xx <= x + 3; xx++)
                {   for (yy = y - 3; yy <= y + 3; yy++)
                    {   if (valid(xx, yy))
                        {   c = field[xx][yy];
                            if (xx == x && yy == y)
                            {   otherfield[xx][yy] = EMPTY;
                            } elif
                            (   (c >= FIRSTTAIL     && c <= LASTTAIL)
                             || (c >= FIRSTGLOW     && c <= LASTGLOW)
                             ||  c == EMPTY
                             ||  c <= LASTOBJECT
                             || (c >= FIRSTCREATURE && c <= LASTCREATURE)
                            )
                            {   otherfield[xx][yy] = TEMPLIGHTNING;
                                if (anims)
                                {   draw(xx, yy, LIGHTNING);
                            }   }
                            elif (c >= FIRSTFRUIT && c <= LASTFRUIT)
                            {   isfruit = FALSE;
                                updatearrow(yy);
                                otherfield[xx][yy] = TEMPLIGHTNING;
                                if (anims)
                                {   draw(xx, yy, LIGHTNING);
                            }   }
                            else
                            {   otherfield[xx][yy] = EMPTY;
                }   }   }   }
                for (xx = x - 3; xx <= x + 3; xx++)
                {   for (yy = y - 3; yy <= y + 3; yy++)
                    {   if (valid(xx, yy))
                        {   if (otherfield[xx][yy] == TEMPLIGHTNING)
                            {   c = field[xx][yy];
                                if (c >= FIRSTCREATURE && c <= LASTCREATURE)
                                {   creature[whichcreature(xx, yy, c, 255)].alive = FALSE;
                                    change1(xx, yy, (UWORD) (FIRSTFLOWER + arand(3)));
                                } elif (c >= FIRSTHEAD && c <= LASTHEAD)
                                {   worm[c - FIRSTHEAD].alive = FALSE;
                                    worm[c - FIRSTHEAD].cause = LIGHTNING;
                                } else
                                {   change1(xx, yy, EMPTY);
            }   }   }   }   }   }
        acase ELEPHANT:
            if (creature[which].pos == 15 || creature[which].pos == 3)
            {   creaturebullet(x, y,  0, -1, FRAGMENT, ELEPHANT); // fire up
            }
            if (creature[which].pos == 15 || creature[which].pos == 11)
            {   creaturebullet(x, y, -1,  0, FRAGMENT, ELEPHANT); // fire left
            }
            if (creature[which].pos == 3 || creature[which].pos == 7)
            {   creaturebullet(x, y,  1,  0, FRAGMENT, ELEPHANT); // fire right
            }
            if (creature[which].pos == 7 || creature[which].pos == 11)
            {   creaturebullet(x, y,  0,  1, FRAGMENT, ELEPHANT); // fire down
            }
        acase FRAGMENT:
            if (creature[which].subspecies == SUPERPULSE && --creature[which].dormant == 0)
            {   effect(FXUSE_BOMB);
                generated = 0;
                for (i = 0; i <= CREATURES; i++)
                {   if (!creature[i].alive && generated <= 7)
                    {   switch (generated)
                        {
                        case 0:
                            xx = 0;
                            yy = -1;
                        acase 1:
                            xx = 1;
                            yy = -1;
                        acase 2:
                            xx = 1;
                            yy = 0;
                        acase 3:
                            xx = 1;
                            yy = 1;
                        acase 4:
                            xx = 0;
                            yy = 1;
                        acase 5:
                            xx = -1;
                            yy = 1;
                        acase 6:
                            xx = -1;
                            yy = 0;
                        acase 7:
                            xx = -1;
                            yy = -1;
                        adefault:
                            assert(0);
                            xx = yy = 0; // to avoid spurious warnings
                        }
                        generated++;
                        if
                        (   valid(x + xx, y + yy)
                         && (   creature[which].creator == LEMMING
                             || xx != creature[which].deltax
                             || yy != creature[which].deltay
                            )
                         && (   creature[which].creator == LEMMING
                             || xx != -creature[which].deltax
                             || yy != -creature[which].deltay
                        )   )
                        {   d = field[x + xx][y + yy];
                            if
                            (  (d >= FIRSTEMPTY && d <= LASTEMPTY)
                            || (d >= FIRSTTAIL  && d <= LASTTAIL )
                            || d <= LASTOBJECT
                            )
                            {   createcreature(FRAGMENT, (UBYTE) i, x + xx, y + yy, xx, yy, -1, MINIPULSE, FRAGMENT);
                }   }   }   }
                creature[which].alive = FALSE;
                change1(x, y, EMPTY);
            }
        acase FROG:
            /* creature[which].dormant of    0 means it is idle and might decide to stick out tongue
               creature[which].dormant of >= 1 means it is sticking out tongue
               Goes 1..foo when pushing out, foo..1 while pulling in */
            if (creature[which].dormant == 0)
            {   if (!arand(FREQ_FROGFIRE))
                {   creature[which].dormant = 1;
                    creature[which].tonguedir = 1;
                    creature[which].tonguex = x;
                    if (creature[which].dir == -1)
                    {   change2(x, y, FROG, FROGMOUTHLEFT);
                    } else
                    {   assert(creature[which].dir == 1);
                        change2(x, y, FROG, FROGMOUTHRIGHT);
            }   }   }
            else
            {   creature[which].dormant += creature[which].tonguedir;
                if (creature[which].tonguedir == 1)
                {   if (valid(creature[which].tonguex + creature[which].dir, y))
                    {   c = field[creature[which].tonguex + creature[which].dir][y];
                        if
                        (    c != TELEPORT
                         &&  c != METAL
                         &&  c != STONE
                         &&  c != WOOD
                         && (c < FIRSTPROTECTOR || c > LASTPROTECTOR)
                         && (c < FIRSTNUMBER    || c > LASTNUMBER   )
                        )
                        {   creature[which].tonguex += creature[which].dir;
                            if (c >= FIRSTCREATURE && c <= LASTCREATURE)
                            {   creature[whichcreature(creature[which].tonguex, y, c, which)].alive = FALSE;
                                change1(creature[which].tonguex, y, FROGTONGUE);
                            } elif (c >= FIRSTHEAD && c <= LASTHEAD && worm[c - FIRSTHEAD].armour == 0)
                            {   worm[c - FIRSTHEAD].cause = FROG;
                                worm[c - FIRSTHEAD].alive = FALSE;
                            } else
                            {   change1(creature[which].tonguex, y, FROGTONGUE);
                        }   }
                        else
                        {   creature[which].tonguedir = -1;
                    }   }
                    else
                    {   creature[which].tonguedir = -1;
                }   }
                else
                {   assert(creature[which].tonguedir == -1);
                    if (creature[which].dormant > 1)
                    {   if (field[creature[which].tonguex][y] == FROGTONGUE)
                        {   change1(creature[which].tonguex, y, EMPTY);
                        }
                        creature[which].tonguex -= creature[which].dir;
                    } else
                    {   if (creature[which].dir == -1)
                        {   change2(x, y, FROG, FROGLEFT);
                        } else
                        {   assert(creature[which].dir == 1);
                            change2(x, y, FROG, FROGRIGHT);
            }   }   }   }
        acase KANGAROO:
            if (!arand(FREQ_KANGAROOFIRE))
            {   creaturebullet(x, y, -1, -1, FRAGMENT, KANGAROO);
                creaturebullet(x, y,  1, -1, FRAGMENT, KANGAROO);
                creaturebullet(x, y, -1,  1, FRAGMENT, KANGAROO);
                creaturebullet(x, y,  1,  1, FRAGMENT, KANGAROO);
            }
        acase KOALA:
            if (!arand(FREQ_KOALAFIRE))
            {   do
                {   xx = arand(2) - 1;
                    yy = arand(2) - 1;
                } while (!xx && !yy);
                creaturebullet(x, y, xx, yy, SUPERPULSE, KOALA);
            }
        acase LEMMING:
            if (!arand(FREQ_LEMMINGFIRE))
            {   creaturebullet(x, y, creature[which].deltax, 0, SUPERPULSE, LEMMING);
            }
        acase MONKEY:
            if (creature[which].pos == 5)
            {   if (creature[which].tonguedir <= 1) // the common orthagonal monkey
                {   chooseorthagonal(&xx, &yy);
                } else // the rarer diagonal monkey
                {   choosediagonal(&xx, &yy);
                }
                creaturebullet(x, y, xx, yy, BANANA, MONKEY);
            }
        acase OCTOPUS:
            if (creature[which].dir == -1)
            {   if (!arand(FREQ_OCTOPUSFIRE))
                {   creature[which].dir = 0;
            }   }
            elif (!arand(FREQ_OCTOPUSSPIN))
            {   /* 7 0 1
                    \|/
                   6-*-2
                    /|\
                   5 4 3 */

                if (creature[which].dir >= 1 && creature[which].dir <= 3)
                {   xx = 1;
                } elif (creature[which].dir >= 5 && creature[which].dir <= 7)
                {   xx = -1;
                } else
                {   assert(creature[which].dir == 0 || creature[which].dir == 4);
                    xx = 0;
                }

                if (creature[which].dir >= 3 && creature[which].dir <= 5)
                {   yy = 1;
                } elif (creature[which].dir <= 1 || creature[which].dir == 7)
                {   yy = -1;
                } else
                {   assert(creature[which].dir == 2 || creature[which].dir == 6);
                    yy = 0;
                }

                creaturebullet(x, y, xx, yy, FRAGMENT, OCTOPUS);
                if (creature[which].dir == 7)
                {   creature[which].dir = -1;
                } else
                {   creature[which].dir++;
            }   }
        acase PORCUPINE:
            if (creature[which].dormant)
            {   switch (creature[which].dormant)
                {
                case 1:  creaturebullet(x, y,  0, -1, FRAGMENT, PORCUPINE);
                acase 2: creaturebullet(x, y,  1, -1, FRAGMENT, PORCUPINE);
                acase 3: creaturebullet(x, y,  1,  0, FRAGMENT, PORCUPINE);
                acase 4: creaturebullet(x, y,  1,  1, FRAGMENT, PORCUPINE);
                acase 5: creaturebullet(x, y,  0,  1, FRAGMENT, PORCUPINE);
                acase 6: creaturebullet(x, y, -1,  1, FRAGMENT, PORCUPINE);
                acase 7: creaturebullet(x, y, -1,  0, FRAGMENT, PORCUPINE);
                acase 8: creaturebullet(x, y, -1, -1, FRAGMENT, PORCUPINE);
                }
                creature[which].dormant += creature[which].tonguedir;
                if (creature[which].dormant == 9)
                {   creature[which].dormant = 1;
                } elif (creature[which].dormant == 0)
                {   creature[which].dormant = 8;
                }
                if (creature[which].going)
                {   creature[which].dormant = 0;
                } elif (creature[which].dormant == creature[which].journey)
                {   creature[which].going = 1;
            }   }
            else
            {   if (!arand(FREQ_PORCUPINEFIRE))
                {   creature[which].dormant = arand(7) + 1; // 1..8
                    creature[which].journey = creature[which].dormant;
                    creature[which].going   = 0;
                    if (arand(1))
                    {   creature[which].tonguedir = -1;
                    } else
                    {   creature[which].tonguedir =  1;
            }   }   }
        acase RHINOCEROS:
            if (!arand(FREQ_RHINOCEROSFIRE))
            {   creaturebullet(x, y,  creature[which].deltax,  creature[which].deltay, FRAGMENT, RHINOCEROS);
                creaturebullet(x, y, -creature[which].deltax, -creature[which].deltay, FRAGMENT, RHINOCEROS);
            }
        acase SALAMANDER:
            if (!arand(FREQ_SALAMANDERFIRE))
            {   chooseorthagonal(&xx, &yy);
                creaturebullet(x, y, xx, yy, FRAGMENT, SALAMANDER);
            }
        acase SNAKE:
            if (creature[which].pos > 0)
            {   creaturebullet(x, y, creature[which].firex, creature[which].firey, FRAGMENT, SNAKE);
                if (creature[which].pos == 4)
                {   creature[which].pos = 0;
                } else creature[which].pos++;
            } elif (!arand(FREQ_SNAKEFIRE))
            {   creature[which].firex =  arand(2)      - 1;
                creature[which].firey = (arand(1) * 2) - 1;
                creaturebullet(x, y, creature[which].firex, creature[which].firey, FRAGMENT, SNAKE);
                creature[which].pos = 1;
            }
        acase SPIDER:
            if (!arand(FREQ_SPIDERFIRE))
            {   if (valid(x - 1, y - 1) && !iswall(x - 1, y - 1)) creaturebullet(x, y, -1, -1, CURVER, SPIDER);
                if (valid(x + 1, y - 1) && !iswall(x + 1, y - 1)) creaturebullet(x, y,  1, -1, CURVER, SPIDER);
            }
        acase SQUID:
            if (!arand(FREQ_SQUIDFIRE))
            {   creature[which].firex = -creature[which].deltax;
                creature[which].firey = 1;
                creaturebullet(x, y, creature[which].firex, creature[which].firey, FRAGMENT, SQUID);
            }
        /* adefault:
            rabbits, snails, turtles, etc. (ie. creatures which do not fire) */
}   }   }

MODULE void creaturebullet(int x, int y, int deltax, int deltay, UBYTE subspecies, UBYTE creator)
{   UBYTE i, c;

    for (i = 0; i <= CREATURES; i++)
    {   if (!creature[i].alive)
        {   if (valid(x + deltax, y + deltay))
            {   c = field[x + deltax][y + deltay];
                if
                (   (c >= FIRSTEMPTY && c <= LASTEMPTY)
                 || (c >= FIRSTTAIL  && c <= LASTTAIL )
                 ||  c == ARROWDOWN
                 ||  c == ARROWUP
                )
                {   effect(FXBORN_FRAGMENT);
                    createcreature(FRAGMENT, i, x + deltax, y + deltay, deltax, deltay, -1, subspecies, creator);
            }   }
            break;
}   }   }

EXPORT void wormkillcreature(int player, UBYTE which, FLAG showpoints)
{   int i;

    /* if (which == 255)
    {   say("Attempted to kill invalid creature!", PURPLE);
        Delay(250);
        clearkybd();
        anykey(FALSE, FALSE);
    }
    return; */

    if (creature[which].species == BANANA)
    {   if (creature[which].player == player)
        {   worm[player].lives += 2;
        } else
        {   worm[player].lives++;
        }
        stat(player, MINIHEALER);
    }

    if
    (   creature[which].species        == RAIN
     || (   creature[which].species    == FRAGMENT
         && creature[which].subspecies == BANANA
    )   )
    {   if (creature[which].player == player)
        {   wormscore(player, creature[which].score * 3);
        } else
        {   wormscore(player, creature[which].score);
    }   }
    else
    {   wormscore(player, creature[which].score);
    }
    creature[which].alive = FALSE;

    if (creature[which].species == FRAGMENT)
    {   if (creature[which].subspecies == BANANA)
        {   effect(FXGET_GROWER);
        } else
        {   effect(FXUSE_ARMOUR);
    }   }
    elif (creature[which].species == RAIN)
    {   effect(FXGET_RAIN);
    }

    if (showpoints)
    {   for (i = 0; i < POINTSLOTS; i++)
        {   if (point[i].time == 0)
            {   point[i].time  = POINTDURATION;
                point[i].x     = creature[which].x;
                point[i].y     = creature[which].y;
                point[i].final = (UWORD) (FIRSTFLOWER + player);
                switch (creature[which].score)
                {
                case   25: draw(point[i].x, point[i].y, (UWORD) (FIRST25POINTS  + player));
                acase  50: draw(point[i].x, point[i].y, (UWORD) (FIRST50POINTS  + player));
                acase 100: draw(point[i].x, point[i].y, (UWORD) (FIRST100POINTS + player));
                acase 200: draw(point[i].x, point[i].y, (UWORD) (FIRST200POINTS + player));
                adefault:  draw(point[i].x, point[i].y, (UWORD) (FIRSTFLOWER    + player));
                }
                field[point[i].x][point[i].y] =         (UWORD) (FIRSTFLOWER    + player);
                return;
        }   }
        change1(creature[which].x, creature[which].y, (UWORD) (FIRSTFLOWER + player));
}   }

EXPORT void protcreature(int player, UBYTE which)
{   /* Handles collisions between protectors and creatures. */

    switch (creature[which].species)
    {
    case FRAGMENT:
        effect(FXBORN_PROTECTOR);
        if (creature[which].subspecies == BANANA)
        {   wormkillcreature(player, which, FALSE);
        } else
        {   reflect(which);
        }
    acase MISSILE_C:
        if (player != creature[which].player)
        {   effect(FXBORN_PROTECTOR);
            wormkillcreature(player, which, TRUE);
        } else creature[which].visible = FALSE;
    acase BUTTERFLY:
        effect(FXGET_BUTTERFLY);
        creature[which].pos += arand(RAND_BUTTERFLY) + ADD_BUTTERFLY;
        wormscore(player, creature[which].score);
    acase ORB:
        effect(FXUSE_ARMOUR);
        creature[which].deltax = -creature[which].deltax;
        creature[which].deltay = -creature[which].deltay;
        creature[which].speed  = 1;
        creature[which].player = player;
        if (!creature[which].kicked)
        {   creature[which].kicked = TRUE;
            wormscore(player, creature[which].score);
        }
        return;
    adefault: // eg. TURTLE
        effect(FXBORN_PROTECTOR);
        wormkillcreature(player, which, TRUE);
}   }

EXPORT void wormcreature(int player, UBYTE which)
{   int xx, yy;

    /* Handles collisions between worms and creatures. */

    switch (creature[which].species)
    {
    case BUTTERFLY:
        effect(FXGET_BUTTERFLY);
        creature[which].pos += arand(RAND_BUTTERFLY) + ADD_BUTTERFLY;
        wormscore(player, creature[which].score);
        return;
    acase DOG:
        if (creature[which].dormant == 0)
        {   effect(FXBORN_DOG);
            creature[which].dormant = 1; // awakening
            creature[which].player  = player;
            worm[player].last       = DOGAWAKENING;
            return;
        }
    acase FRAGMENT:
        if (creature[which].subspecies == BANANA)
        {   effect(FXGET_GRAVE);
            wormkillcreature(player, which, FALSE);
            return;
        } elif (worm[player].armour)
        {   effect(FXUSE_ARMOUR);
            if (creature[which].subspecies != BANANA)
            {   reflect(which);
            }
            return;
        }
    acase GIRAFFE:
        xx = worm[player].x - (worm[player].deltax * DISTANCE_GIRAFFE);
        yy = worm[player].y - (worm[player].deltay * DISTANCE_GIRAFFE);

        if
        (   valid(xx, yy)
         && !blockedsquare(xx, yy)
        )
        {   worm[player].deltax = -worm[player].deltax;
            worm[player].deltay = -worm[player].deltay;
            worm[player].x = xx;
            worm[player].y = yy;

            if (!worm[player].armour)
            {   worm[player].alive  = FALSE;
                worm[player].cause  = GIRAFFE;
            }

            return;
        }
    acase MISSILE_C:
        if (creature[which].player == player)
        {   creature[which].visible = FALSE;
            return;
        }
    acase RAIN:
        effect(FXGET_RAIN);
        wormkillcreature(player, which, FALSE);
        return;
    acase TURTLE:
        if (creature[which].frame != 3)
        {   effect(FXGET_BUTTERFLY);
            wormkillcreature(player, which, FALSE);
            return;
        }
    acase ORB:
        if (worm[player].armour)
        {   effect(FXUSE_ARMOUR);
            if (worm[player].deltax == 0 && worm[player].deltay == 0)
            {   creature[which].deltax = -creature[which].deltax;
                creature[which].deltay = -creature[which].deltay;
            } else
            {   creature[which].deltax = worm[player].deltax;
                creature[which].deltay = worm[player].deltay;
            }
            creature[which].speed  = 1;
            creature[which].player = player;
            if (!creature[which].kicked)
            {   creature[which].kicked = TRUE;
                wormscore(player, creature[which].score);
            }
            return;
    }   }

    wormkillcreature(player, which, FALSE);

    if (worm[player].armour)
    {   effect(FXUSE_ARMOUR);
    } elif (creature[which].player != player || creature[which].species == DOG)
    {   if (creature[which].species == MISSILE_C)
        {   worm[player].cause = FIRSTMISSILE + creature[which].player;
        } else
        {   worm[player].cause = creature[which].species;
        }
        worm[player].alive = FALSE;
}   }

MODULE void creaturecreature(UBYTE which1, UBYTE which2)
{   if
    (   creature[which1].species == MISSILE_C
     && creature[which2].species != MISSILE_C
    )
    {   wormkillcreature(creature[which1].player, which2, FALSE);
    } elif
    (   creature[which1].species != MISSILE_C
     && creature[which2].species == MISSILE_C
    )
    {   wormkillcreature(creature[which2].player, which1, FALSE);
    } elif
    (   creature[which1].species == FRAGMENT
     && creature[which2].species == OTTER
    )
    {   reflect(which1);
    } elif
    (   creature[which1].species == OTTER
     && creature[which2].species == FRAGMENT
    )
    {   reflect(which2);
    } else
    {   creature[which1].alive =
        creature[which2].alive = FALSE;
        change1(creature[which1].x, creature[which1].y, (UWORD) (FIRSTFLOWER + arand(3)));
}   }

MODULE FLAG bouncecreature(UBYTE which, int x, int y)
{   UWORD c = field[x][y];

    if
    (    c == METAL
     ||  c == STONE
     ||  c == WOOD
     || (c >= FIRSTCREATURE && c <= LASTCREATURE && creatureinfo[sortcreatures[c - FIRSTCREATURE]].wall)
     || (   creature[which].species == ORB
         && (   (c >= FIRSTTAIL && c <= LASTTAIL)
             || (c >= FIRSTGLOW && c <= LASTGLOW)
    )   )   )
    {   return TRUE;
    } else
    {   return FALSE;
}   }

EXPORT UBYTE whichcreature(int x, int y, UWORD species, UBYTE exception)
{   UBYTE i;

    for (i = 0; i <= CREATURES; i++)
    {   if
        (   creature[i].alive
         && creature[i].x       == x
         && creature[i].y       == y
         && creature[i].species == species
         && i                   != exception
        )
        {   return i;
    }   }

/*  say("Attempted to find invalid creature!", PURPLE);
    Delay(250);
    clearkybd();
    anykey(FALSE, FALSE); */

    return 255; /* error code */
}

EXPORT void wormloop(int player)
{   int   bestx = 0, // to avoid spurious warnings
          besty = 0, // to avoid spurious warnings
          distance,
          dirx = 0,  // to avoid spurious warnings
          diry = 0,  // to avoid spurious warnings
          e,
          j,
          x, y;
    SBYTE index1, index2;
    UWORD c;
    SWORD bestgood, good;
    int   i;

   /*  Amiga worm control
       Remove a keystroke from the worm queue
       Move worm (and add a keystroke to the dog queue)
       Check for enclosure
       Move protectors
       Collision detection

    AI: Amiga worm control. */

    if (worm[player].control == THEAMIGA)
    {   bestgood = -128;
        if (worm[player].speed == SPEED_FAST)
        {   distance = DISTANCE_FAST;
        } elif (worm[player].speed == SPEED_NORMAL)
        {   distance = DISTANCE_NORMAL;
        } else
        {   distance = DISTANCE_SLOW;
        }

        for (i = 0; i <= 9; i++)
        {   if (i < 9)
            {   switch (i % 3)
                {
                case 0:
                    dirx = -1;
                acase 1:
                    dirx = 0;
                acase 2:
                    dirx = 1;
            }   }
            switch (i / 3)
            {
            case 0:
                diry = -1;
            acase 1:
                diry = 0;
            acase 2:
                diry = 1;
            acase 3:
                dirx = worm[player].deltax * distance;
                diry = worm[player].deltay * distance;
            }
            if
            (   (   dirx == -worm[player].deltax
                 && diry == -worm[player].deltay
                )
             || (   dirx == 0
                 && diry == 0
            )   )
            {   continue;
            }

            c = field[xwrap(worm[player].x + dirx)][ywrap(worm[player].y + diry)];
            if (c >= FIRSTNUMBER && c <= LASTNUMBER)
                good = POINTS_NUMBER;
            elif (c >= FIRSTFRUIT && c <= LASTFRUIT)
                good = POINTS_FRUIT;
            elif (c >= FIRSTHEAD && c <= LASTHEAD)
                good = -(PAIN_HEAD);
            elif (c <= LASTOBJECT)
                good = (SWORD) POINTS_OBJECT;
            elif (c == FIRSTPROTECTOR + player)
                good = POINTS_EMPTY;
            elif (c >= FIRSTGLOW && c <= LASTGLOW)
            {   if (player == c - FIRSTGLOW)
                    good = -1;
                else good = -(PAIN_GLOW);
            } elif (c >= FIRSTGRAVE && c <= LASTGRAVE)
            {   good = POINTS_GRAVE;
            } elif (c >= FIRSTCHERRY && c <= LASTCHERRY)
            {   good = POINTS_CHERRY; // should really be 2x if friendly
            } elif (c >= FIRSTFLOWER && c <= LASTFLOWER)
            {   good = POINTS_FLOWER; // should really be 2x if friendly
            } elif (c >= FIRSTTAIL && c <= LASTTAIL)
            {   if (worm[player].armour > 10)
                    if (player != c - FIRSTTAIL)
                        good = 2;
                    else good = 0;
                elif (player == c - FIRSTTAIL)
                    good = -(PAIN_FRIENDLYTAIL);
                else good = -(PAIN_ENEMYTAIL);
            } else switch (c)
            {
            case GOLD:
                good = POINTS_GOLD;
            acase SILVER:
                good = POINTS_SILVER;
            acase EMPTY:
                good = POINTS_EMPTY;
            acase SPIDERSILK:
            case FROGTONGUE:
                good = -(PAIN_CREATURE);
            acase DYNAMITE:
            case BANGINGDYNAMITE:
            case BANGEDDYNAMITE:
                good = 1;
            acase SLIME:
                if (worm[player].armour > 0)
                    good = 0;
                else good = -(PAIN_SLIME);
            acase WOOD:
                good = (SWORD) -(PAIN_WOOD  * 3);
            acase STONE:
                good = (SWORD) -(PAIN_STONE * 3);
            acase METAL:
                good = (SWORD) -(PAIN_METAL * 3);
            acase START:
                good = (SWORD) POINTS_NUMBER * 2;
            adefault:
                if (c >= FIRSTCREATURE && c <= LASTCREATURE)
                {   if (creature[whichcreature(xwrap(worm[player].x + dirx), ywrap(worm[player].y + diry), c, 255)].player == player)
                    {   good = (SWORD) creatureinfo[sortcreatures[c - FIRSTCREATURE]].score;
                    } elif (creatureinfo[sortcreatures[c - FIRSTCREATURE]].wall)
                    {   good = (SWORD) -(PAIN_CREATURE * 2);
                    } else good = -PAIN_CREATURE;
                } else
                {   // eg. frost, arrows
                    good = 0;
            }   }

            if
            (   good > bestgood
             || (good == bestgood && dirx == worm[player].deltax && diry == worm[player].deltay)
             || (bestgood <= 0 && good == bestgood && (dirx > 1 || diry > 1))
            )
            {   bestx = dirx;
                besty = diry;
                bestgood = good;
        }   }
        if (bestgood < -2 && !arand(1))
        {   // turn in any of the 8 directions, or fire
            wormqueue
            (   player,
                (arand(1) * 2) - 1,
                (arand(1) * 2) - 1
            );
        } elif (abs(bestx) >= 2 || abs(besty) >= 2)
        {   wormqueue(player, 0, 0); // jump
        } elif (bestx != worm[player].deltax || besty != worm[player].deltay)
        {   wormqueue(player, bestx, besty);
    }   }

    // remove a keystroke from the worm queue
    if (worm[player].queuepos != -1)
    {   if (thewormqueue[player][0].deltax == 0 && thewormqueue[player][0].deltay == 0)
        {   wormbullet(player);
        } elif (!worm[player].frosted)
        {   turnworm(player, thewormqueue[player][0].deltax, thewormqueue[player][0].deltay);
        }
        worm[player].queuepos--;
        if (worm[player].queuepos != -1)
        {   for (i = 0; i <= worm[player].queuepos; i++)
            {   thewormqueue[player][i].deltax = thewormqueue[player][i + 1].deltax;
                thewormqueue[player][i].deltay = thewormqueue[player][i + 1].deltay;
    }   }   }
    worm[player].frosted = FALSE;

    // move worm

    if (!worm[player].speed)
    {   return;
    }

    if (tdworms)
    {   x = worm[player].x;
        y = worm[player].y;
        if (x > 0 && y > 0) // up-left
        {   draw(x - 1, y - 1, gfxfield[x - 1][y - 1]);
        }
        if (y > 0) // up
        {   draw(x    , y - 1, gfxfield[x    ][y - 1]);
        }
        if (x > 0) // left
        {   draw(x - 1, y    , gfxfield[x - 1][y    ]);
    }   }

    if (worm[player].last == FIRSTTAIL + player)
    {   index1 =       worm[player].olddeltax + 1 + (      (worm[player].olddeltay + 1) * 3);
        index2 = isign(worm[player].deltax)   + 1 + ((isign(worm[player].deltay)   + 1) * 3);
        change2(worm[player].x, worm[player].y, (UWORD) (FIRSTTAIL + player), eachtail[player][0][index1][index2]);
    } elif (worm[player].last == FIRSTGLOW + player)
    {   index1 =       worm[player].olddeltax + 1 + (      (worm[player].olddeltay + 1) * 3);
        index2 = isign(worm[player].deltax)   + 1 + ((isign(worm[player].deltay)   + 1) * 3);
        change2(worm[player].x, worm[player].y, (UWORD) (FIRSTGLOW + player), eachtail[player][1][index1][index2]);
    } else
    {   change1(worm[player].x, worm[player].y, worm[player].last);
    }

    worm[player].x = xwrap(worm[player].x + worm[player].deltax);
    worm[player].y = ywrap(worm[player].y + worm[player].deltay);

    if (worm[player].glow)
    {   worm[player].last = FIRSTGLOW + player;
    } else
    {   worm[player].last = FIRSTTAIL + player;
    }

    for (i = 0; i <= CREATURES; i++)
    {   if
        (   creature[i].alive
         && creature[i].species == DOG
         && creature[i].dormant >  0
         && creature[i].player  == player
        )
        {   if (!worm[player].rammed)
            {   dogqueue(i, worm[player].deltax, worm[player].deltay);
    }   }   }

    /* The deltas are not changed back to the range of -1..1 until after
    the dogs have looked at the queue. This enables them to jump properly. */

    worm[player].rammed = FALSE;
    worm[player].deltax = isign(worm[player].deltax);
    worm[player].deltay = isign(worm[player].deltay);
    worm[player].olddeltax = worm[player].deltax;
    worm[player].olddeltay = worm[player].deltay;

    /*  check for enclosure
        #####
        #...#
        #...# . = interior
        #...# # = tail
        ####! ! = head */

    enclosed = FALSE;
    for (e = 1; e <= ENCLOSURE_MAX; e++) // for each size of interior
    {   for (j = 0; j <= 3; j++) // four times, once for each direction
        {   checkdiamond(j, player, e);
            if (e >= 2)
            {   if
                (   difficulty != DIFFICULTY_HARD
                 && difficulty != DIFFICULTY_VERYHARD
                )
                {   checkrectangle(j, player, e, e);
                }
                if (worm[player].encloser)
                {   if
                    (   difficulty != DIFFICULTY_HARD
                     && difficulty != DIFFICULTY_VERYHARD
                    )
                    {   checkrectangle(j, player, e    , e + 1);
                        checkrectangle(j, player, e + 1, e);
                    }
                    checktriangle( j, player, e);
    }   }   }   }
    if (enclosed)
    {   effect(FXDO_ENCLOSE);
    }

    protectorloop1(player);

    // head collision detection
    wormcol(player, worm[player].x, worm[player].y);

    // draw head
    if
    (   (worm[player].glow   > 0 && worm[player].glow   < 10)
     || (worm[player].cutter > 0 && worm[player].cutter < 10)
     || (worm[player].armour > 0 && worm[player].armour < 10)
    )
    {   if (worm[player].flashed) worm[player].flashed = FALSE; else worm[player].flashed = TRUE;
    } else
    {   worm[player].flashed = FALSE;
    }
    change2(worm[player].x, worm[player].y, (UWORD) (FIRSTHEAD + player), getimage_head(player));

    updatearrow(worm[player].arrowy);
    worm[player].arrowy = worm[player].y;
    updatearrow(worm[player].arrowy);

    protectorloop2(player);

    worm_captureorb(player);

    if (worm[player].cutter)
    {   // straight ahead
        x = xwrap(worm[player].x + worm[player].deltax);
        y = ywrap(worm[player].y + worm[player].deltay);
        squareblast(HEAD, player, field[x][y], x, y, TRUE, FALSE);
        // left
        if (!worm[player].deltax || !worm[player].deltay)
        {   // if orthagonal
            x = xwrap(worm[player].x + worm[player].deltay);
            y = ywrap(worm[player].y - worm[player].deltax);
        } else // diagonal
        {   if (worm[player].deltax == worm[player].deltay)
            {   x = xwrap(worm[player].x + worm[player].deltax);
                y = ywrap(worm[player].y - worm[player].deltay);
            } else
            {   x = xwrap(worm[player].x - worm[player].deltax);
                y = ywrap(worm[player].y + worm[player].deltay);
        }   }
        squareblast(HEAD, player, field[x][y], x, y, TRUE, FALSE);
        // right
        if (!worm[player].deltax || !worm[player].deltay)
        {   // if orthagonal
            x = xwrap(worm[player].x - worm[player].deltay);
            y = ywrap(worm[player].y + worm[player].deltax);
        } else // diagonal
        {   if (worm[player].deltax == worm[player].deltay)
            {   x = xwrap(worm[player].x - worm[player].deltax);
                y = ywrap(worm[player].y + worm[player].deltay);
            } else
            {   x = xwrap(worm[player].x + worm[player].deltax);
                y = ywrap(worm[player].y - worm[player].deltay);
        }   }
        squareblast(HEAD, player, field[x][y], x, y, TRUE, FALSE);
        // ahead left
        if (!worm[player].deltax || !worm[player].deltay)
        {   // if orthagonal
            if (worm[player].deltax) // if east or west
            {   x = xwrap(worm[player].x + worm[player].deltax);
                y = ywrap(worm[player].y - worm[player].deltax);
            } else // north or south
            {   x = xwrap(worm[player].x + worm[player].deltay);
                y = ywrap(worm[player].y + worm[player].deltay);
        }   }
        else // diagonal
        {   if (worm[player].deltax == worm[player].deltay)
            {   x = xwrap(worm[player].x + worm[player].deltax);
                y = worm[player].y;
            } else
            {   x = worm[player].x;
                y = ywrap(worm[player].y + worm[player].deltay);
        }   }
        squareblast(HEAD, player, field[x][y], x, y, TRUE, FALSE);
        // ahead right
        if (!worm[player].deltax || !worm[player].deltay)
        {   // if orthagonal
            if (worm[player].deltax) // if east or west
            {   x = xwrap(worm[player].x + worm[player].deltax);
                y = ywrap(worm[player].y + worm[player].deltax);
            } else // north or south
            {   x = xwrap(worm[player].x - worm[player].deltay);
                y = ywrap(worm[player].y + worm[player].deltay);
        }   }
        else // diagonal
        {   if (worm[player].deltax == worm[player].deltay)
            {   x = worm[player].x;
                y = ywrap(worm[player].y + worm[player].deltay);
            } else
            {   x = xwrap(worm[player].x + worm[player].deltax);
                y = worm[player].y;
        }   }
        squareblast(HEAD, player, field[x][y], x, y, TRUE, FALSE);
}   }

MODULE void protcol(int player, int x, int y, SBYTE thisprot)
{   UWORD c = field[x][y];

    if
    (   c == EMPTY
     || c == BANGINGDYNAMITE
     || c == BANGEDDYNAMITE
    )
    {   return; // important!
    } elif (c >= FIRSTHEAD && c <= LASTHEAD)
    {   protworm(x, y, player, (int) (c - FIRSTHEAD));
    } elif (c >= FIRSTPROTECTOR && c <= LASTPROTECTOR)
    {   protprot(x, y, player, (int) (c - FIRSTPROTECTOR));
    } elif (c >= FIRSTTAIL && c <= LASTTAIL)
    {   if (player == c - FIRSTTAIL)
        {   protector[player][thisprot].visible = FALSE;
    }   }
    elif
    (   c == STONE
     || c == WOOD
     || c == METAL
     || c == TELEPORT
     || c == FIRSTGLOW + player
     || c == START
    )
    {   protector[player][thisprot].visible = FALSE;
    } elif (c >= FIRSTCREATURE && c <= LASTCREATURE)
    {   protcreature(player, whichcreature(x, y, c, 255));
    } else
    {   bothcol(player, x, y);
}   }

EXPORT void bothcol(int player, int x, int y)
{   UWORD c = field[x][y];
    UBYTE i;

    if (c >= FIRSTNUMBER && c <= LASTNUMBER)
    {   if (!getnumber(player))
        {   putnumber();
    }   }
    elif (c >= FIRSTFLOWER && c <= LASTFLOWER)
    {   effect(FXDING);
        if (player == c - FIRSTFLOWER)
        {   wormscore(player, POINTS_FLOWER * 3);
            worm[player].lives += 3;
        } else
        {   wormscore(player, POINTS_FLOWER);
            worm[player].lives++;
        }
        stat(player, MINIHEALER);

        if (level != 0 && difficulty != DIFFICULTY_HARD && difficulty != DIFFICULTY_VERYHARD)
        {   getnumber(player);
            change1(numberx, numbery, (UWORD) (FIRSTNUMBER + number - 1));
            updatearrow(numbery);
    }   }
    elif (c >= FIRSTCHERRY && c <= LASTCHERRY)
    {   effect(FXDING);
        if (player == c - FIRSTCHERRY)
        {   wormscore(player, POINTS_CHERRY * 3);
        } else
        {   wormscore(player, POINTS_CHERRY);
    }   }
    elif (c >= FIRSTFRUIT && c <= LASTFRUIT)
    {   effect(FXAPPLAUSE);
        wormscore(player, POINTS_FRUIT * (c - FIRSTFRUIT + 1));
        isfruit = FALSE;
        updatearrow(y);
    } elif (c <= LASTOBJECT)
    {   wormscore(player, wormobject(player, x, y));
    } elif (c >= FIRSTGRAVE && c <= LASTGRAVE)
    {   effect(FXGET_GRAVE);
        wormscore(player, POINTS_GRAVE);

        worm[player].multi *= worm[c - FIRSTGRAVE].multi;

        // The following is a workaround for a bug on the IBM-PC version.
        if (worm[player].multi == 0)
        {   worm[player].multi = 1;
        }

        if (worm[player].multi > 1)
        {   if (worm[player].multi > MULTILIMIT)
            {   worm[player].multi = MULTILIMIT;
            }
            stat(player, BONUS);
            worm[c - FIRSTGRAVE].multi = 1;
            stat((SBYTE) (c - FIRSTGRAVE), BONUS);
        }
        worm[player].power += worm[c - FIRSTGRAVE].power;
        if (worm[player].power > 1)
        {   if (worm[player].power > POWERLIMIT)
            {   worm[player].power = POWERLIMIT;
            }
            stat(player, POWER);
            worm[c - FIRSTGRAVE].power = 0;
            stat((SBYTE) (c - FIRSTGRAVE), POWER);
        }
        worm[player].ammo += worm[c - FIRSTGRAVE].ammo;
        if (worm[player].ammo > 0)
        {   if (worm[player].ammo > AMMOLIMIT)
            {   worm[player].ammo = AMMOLIMIT;
            }
            stat(player, AMMO);
            worm[c - FIRSTGRAVE].ammo = 0;
            stat((SBYTE) (c - FIRSTGRAVE), AMMO);
        }
        if (worm[c - FIRSTGRAVE].backwards)
        {   worm[player].backwards = TRUE;
            worm[c - FIRSTGRAVE].backwards = FALSE;
        }
        if (worm[c - FIRSTGRAVE].forwards)
        {   worm[player].forwards = TRUE;
            worm[c - FIRSTGRAVE].forwards = FALSE;
        }
        if (worm[c - FIRSTGRAVE].brakes)
        {   worm[player].brakes = TRUE;
            stat(player, BRAKES);
            worm[c - FIRSTGRAVE].brakes = FALSE;
            worm[c - FIRSTGRAVE].speed = SPEED_NORMAL;
            stat((SBYTE) (c - FIRSTGRAVE), BRAKES);
        }
        if (worm[c - FIRSTGRAVE].affixer)
        {   worm[player].affixer = TRUE;
            worm[c - FIRSTGRAVE].affixer = FALSE;
        }
        if (worm[c - FIRSTGRAVE].grenade)
        {   worm[player].grenade = TRUE;
            worm[c - FIRSTGRAVE].grenade = FALSE;
        }
        if (worm[c - FIRSTGRAVE].remnants)
        {   worm[player].remnants = TRUE;
            worm[c - FIRSTGRAVE].remnants = FALSE;
        }
        if (worm[c - FIRSTGRAVE].sideshot)
        {   worm[player].sideshot = TRUE;
            worm[c - FIRSTGRAVE].sideshot = FALSE;
        }
        if (worm[c - FIRSTGRAVE].pusher)
        {   worm[player].pusher = TRUE;
            worm[c - FIRSTGRAVE].pusher = FALSE;
        }
        if (worm[c - FIRSTGRAVE].encloser)
        {   worm[player].encloser = TRUE;
            worm[c - FIRSTGRAVE].encloser = FALSE;
        }
        if (worm[c - FIRSTGRAVE].autojump)
        {   worm[player].autojump = TRUE;
            worm[c - FIRSTGRAVE].autojump = FALSE;
        }
        if (worm[c - FIRSTGRAVE].autoturn)
        {   worm[player].autoturn = TRUE;
            worm[c - FIRSTGRAVE].autoturn = FALSE;
        }

        if (worm[c - FIRSTGRAVE].armour)
        {   worm[player].armour += worm[c - FIRSTGRAVE].armour;
            if (worm[player].armour > ARMOURLIMIT)
                worm[player].armour = ARMOURLIMIT;
            worm[c - FIRSTGRAVE].armour = 0;
        }
        if (worm[c - FIRSTGRAVE].glow)
        {   worm[player].glow += worm[c - FIRSTGRAVE].glow;
            if (worm[player].glow > GLOWLIMIT)
            {   worm[player].glow = GLOWLIMIT;
            }
            worm[c - FIRSTGRAVE].glow = 0;
        }
        if (worm[c - FIRSTGRAVE].cutter)
        {   worm[player].cutter += worm[c - FIRSTGRAVE].cutter;
            if (worm[player].armour > CUTTERLIMIT)
            {   worm[player].armour = CUTTERLIMIT;
            }
            worm[c - FIRSTGRAVE].cutter = 0;
        }

        for (i = 0; i <= LASTOBJECT; i++)
        {   icon(player, i);
            icon((SBYTE) (c - FIRSTGRAVE), i);
    }   }
    else
    {   switch (c)
        {
        case SILVER:
            wormscore(player, POINTS_SILVER);
        acase GOLD:
            wormscore(player, POINTS_GOLD);
        acase DYNAMITE:
            effect(FXUSE_BOMB);
            banging = TRUE;
            bangdynamite(x, y);
}   }   }

MODULE void wormbullet(int player)
{   FLAG  final    = FALSE, // to avoid spurious SAS/C warnings
          finished,
          first    = TRUE,
          numbered = FALSE,
          ok;
    int   centrex,
          centrey,
          distance,
          strength,
          x, y,
          xx, yy;
    UWORD c;
    UBYTE i, j;

    if (worm[player].ammo && (level != 0 || bonustype != BONUSLEVEL_JUMP))
    {   effect(FXUSE_AMMO);
        worm[player].ammo--;
        stat(player, AMMO);

        if (worm[player].grenade)
        {   strength = ADD_MINIBOMB;
            centrex = worm[player].x + (abs(worm[player].deltax) * (strength + 1));
            centrey = worm[player].y + (abs(worm[player].deltay) * (strength + 1));
            if (valid(centrex, centrey))
            {   bombblast(HEAD, player, centrex, centrey, TRUE, strength);
        }   }

        if (worm[player].sideshot)
        {   bullet[7].alive      = bullet[8].alive      = TRUE;
            bullet[7].teleported = bullet[8].teleported = 0;
            bullet[7].visible    = bullet[8].visible    = FALSE;
            if (!worm[player].deltax && worm[player].deltay)
            {   bullet[7].deltax = -1;
                bullet[8].deltax = 1;
                bullet[7].deltay = bullet[8].deltay = 0;
            } elif (worm[player].deltax && !worm[player].deltay)
            {   bullet[7].deltax = bullet[8].deltax = 0;
                bullet[7].deltay = -1;
                bullet[8].deltay = 1;
            } else /* worm is diagonal */
            {   if (worm[player].deltax == worm[player].deltay)
                {   bullet[7].deltax = 1;
                    bullet[7].deltay = -1;
                } else
                {   bullet[7].deltax = -1;
                    bullet[7].deltay = -1;
                }
                bullet[8].deltax = -bullet[7].deltax;
                bullet[8].deltay = -bullet[7].deltay;
            }
            bullet[7].x = worm[player].x + bullet[7].deltax;
            bullet[7].y = worm[player].y + bullet[7].deltay;
            bullet[8].x = worm[player].x + bullet[8].deltax;
            bullet[8].y = worm[player].y + bullet[8].deltay;
        }

        if (worm[player].forwards)
        {   bullet[9].alive      = bullet[10].alive      = TRUE;
            bullet[9].teleported = bullet[10].teleported = 0;
            bullet[9].visible    = bullet[10].visible    = FALSE;
            if (!worm[player].deltax && worm[player].deltay) // north/south
            {   bullet[9].deltax = -1;
                bullet[10].deltax = 1;
                bullet[9].deltay = bullet[10].deltay = worm[player].deltay;
            } elif (worm[player].deltax && !worm[player].deltay) // east/west
            {   bullet[9].deltax = bullet[10].deltax = worm[player].deltax;
                bullet[9].deltay = -1;
                bullet[10].deltay = 1;
            } else /* worm is diagonal */
            {   if (worm[player].deltay == -1) // nw/ne
                {   bullet[9].deltax = 0;  // n
                    bullet[9].deltay = -1;
                } else // sw/se
                {   bullet[9].deltax = 0;  // s
                    bullet[9].deltay = 1;
                }
                if (worm[player].deltax == -1) // nw/sw
                {   bullet[10].deltax = -1;  // w
                    bullet[10].deltay = 0;
                } else // ne/se
                {   bullet[10].deltax = 1;  // e
                    bullet[10].deltay = 0;
            }   }
            bullet[9].x  = worm[player].x + bullet[9].deltax;
            bullet[9].y  = worm[player].y + bullet[9].deltay;
            bullet[10].x = worm[player].x + bullet[10].deltax;
            bullet[10].y = worm[player].y + bullet[10].deltay;
        }

        if (worm[player].backwards)
        {   bullet[11].alive      = bullet[12].alive      = TRUE;
            bullet[11].teleported = bullet[12].teleported = 0;
            bullet[11].visible    = bullet[12].visible    = FALSE;
            if (!worm[player].deltax && worm[player].deltay) // north/south
            {   bullet[11].deltax = -1;
                bullet[12].deltax = 1;
                bullet[11].deltay = bullet[12].deltay = -worm[player].deltay;
            } elif (worm[player].deltax && !worm[player].deltay) // east/west
            {   bullet[11].deltax = bullet[12].deltax = -worm[player].deltax;
                bullet[11].deltay = -1;
                bullet[12].deltay = 1;
            } else /* worm is diagonal */
            {   if (worm[player].deltay == -1) // nw/ne
                {   bullet[11].deltax = 0;  // s
                    bullet[11].deltay = 1;
                } else // sw/se
                {   bullet[11].deltax = 0;  // n
                    bullet[11].deltay = -1;
                }
                if (worm[player].deltax == -1) // nw/sw
                {   bullet[12].deltax = 1;  // e
                    bullet[12].deltay = 0;
                } else // ne/se
                {   bullet[12].deltax = -1;  // w
                    bullet[12].deltay = 0;
            }   }
            bullet[11].x = worm[player].x + bullet[11].deltax;
            bullet[11].y = worm[player].y + bullet[11].deltay;
            bullet[12].x = worm[player].x + bullet[12].deltax;
            bullet[12].y = worm[player].y + bullet[12].deltay;
        }

        for (i = 0; i <= worm[player].power; i++)
        {   bullet[i].alive      = TRUE;
            bullet[i].teleported = 0;
            bullet[i].visible    = FALSE;
            bullet[i].deltax     = worm[player].deltax;
            bullet[i].deltay     = worm[player].deltay;
            if (i % 2 == 0)
                distance = i / 2;
            else distance = -((i + 1) / 2);
            if (worm[player].deltax == 0)
            {   bullet[i].x = worm[player].x + distance;
                bullet[i].y = worm[player].y + worm[player].deltay;
            } elif (worm[player].deltay == 0)
            {   bullet[i].x = worm[player].x + worm[player].deltax;
                bullet[i].y = worm[player].y + distance;
            } else
            {   switch (i)
                {
                case 0:
                    bullet[i].x = worm[player].x + worm[player].deltax;
                    bullet[i].y = worm[player].y + worm[player].deltay;
                acase 1:
                    bullet[i].x = worm[player].x + worm[player].deltax;
                    bullet[i].y = worm[player].y;
                acase 2:
                    bullet[i].x = worm[player].x;
                    bullet[i].y = worm[player].y + worm[player].deltay;
                acase 3:
                    bullet[i].x = worm[player].x + worm[player].deltax * 2;
                    bullet[i].y = worm[player].y;
                acase 4:
                    bullet[i].x = worm[player].x;
                    bullet[i].y = worm[player].y + worm[player].deltay * 2;
                acase 5:
                    bullet[i].x = worm[player].x + worm[player].deltax * 2;
                    bullet[i].y = worm[player].y - worm[player].deltay;
                acase 6:
                    bullet[i].x = worm[player].x - worm[player].deltax;
                    bullet[i].y = worm[player].y + worm[player].deltay * 2;
        }   }   }

        for (i = 0; i <= 8; i++)
        {   if (bullet[i].alive && (!valid(bullet[i].x, bullet[i].y)))
            {   bullet[i].alive = FALSE;
        }   }

        /* Bullets are now set up. */

        finished = FALSE;
        while (!finished)
        {   finished = TRUE;
            for (i = 0; i <= 12; i++)
            {   if (bullet[i].alive)
                {   if (bullet[i].visible)
                    {   if (worm[player].remnants)
                        {   change2(bullet[i].x, bullet[i].y, (UWORD) (FIRSTGLOW + player), (UWORD) (TAILSOFFSET + 57 + (58 * player)));
                        } else
                        {   change1(bullet[i].x, bullet[i].y, EMPTY);
                    }   }

                    finished = FALSE;
                    bullet[i].visible = TRUE;

                    if (!first)
                    {   bullet[i].x += bullet[i].deltax;
                        bullet[i].y += bullet[i].deltay;
                    }

                    x = bullet[i].x;
                    y = bullet[i].y;
                    if (!(valid(x, y)))
                    {   bullet[i].alive = FALSE;
                        continue;
                    }
                    c = field[x][y];
                    if (x == worm[player].x && y == worm[player].y)
                    {   /* hit by own bullet (doesn't actually occur anymore) */
                        bullet[i].alive = FALSE;
                        if (worm[player].armour == 0)
                        {   worm[player].cause = FIRSTFIRE + player;
                            worm[player].alive = FALSE;
                    }   }
                    elif (c >= FIRSTHEAD && c <= LASTHEAD)
                    {   if (worm[c - FIRSTHEAD].armour == 0)
                        {   worm[c - FIRSTHEAD].cause = FIRSTFIRE + player;
                            worm[c - FIRSTHEAD].alive = FALSE;
                        } else effect(FXUSE_ARMOUR);
                        bullet[i].alive = FALSE;
                    } elif (c >= FIRSTPROTECTOR && c <= LASTPROTECTOR)
                    {   if (player != c - FIRSTPROTECTOR)
                        {   effect(FXBORN_PROTECTOR);
                            bullet[i].alive = FALSE;
                        } else bullet[i].visible = FALSE;
                    } elif (c >= FIRSTNUMBER && c <= LASTNUMBER)
                    {   final = getnumber(player);
                        numbered = TRUE;
                    } elif (c >= FIRSTFRUIT && c <= LASTFRUIT)
                    {   effect(FXAPPLAUSE);
                        wormscore(player, POINTS_FRUIT * (c - FIRSTFRUIT + 1));
                        isfruit = FALSE;
                        updatearrow(y);
                    } elif (c >= FIRSTGRAVE && c <= LASTGRAVE)
                    {   bullet[i].alive = FALSE;
                    } else
                    {   switch (c)
                        {
                        case MINIBOMB:
                            // sets it off, for your benefit
                            bullet[i].alive = FALSE;
                            bombblast(HEAD, player, x, y, FALSE, 0);
                        acase SUPERBOMB:
                            // sets it off, for your benefit
                            bullet[i].alive = FALSE;
                            bombblast(HEAD, player, x, y, TRUE, 0);
                        acase SLIME:
                        case WOOD:
                            // destroys one layer of it
                            bullet[i].alive = FALSE;
                            change1(x, y, EMPTY);
                        acase METAL:
                        case STONE:
                        case START:
                            bullet[i].alive = FALSE;
                        acase TELEPORT:
                            j = whichteleport(bullet[i].x, bullet[i].y);
                            if (bullet[i].teleported == 2 || blockedtel(j, bullet[i].deltax, bullet[i].deltay))
                            {   bullet[i].alive = FALSE;
                            } else
                            {   effect(FXUSE_TELEPORT);
                                bullet[i].visible = FALSE;
                                bullet[i].teleported++;
                                bullet[i].x = teleport[partner(j)].x;
                                bullet[i].y = teleport[partner(j)].y;
                            }
                        adefault:
                            if (c >= FIRSTCREATURE && c <= LASTCREATURE)
                            {   j = whichcreature(x, y, c, 255);
                                bullet[i].alive = FALSE;
                                wormkillcreature(player, j, TRUE);
                            } elif (c <= LASTOBJECT)
                            {   bullet[i].alive = FALSE;
                                change1(x, y, (UWORD) (FIRSTCHERRY + player));
                    }   }   }

                    // x and y need this refreshing here
                    x = bullet[i].x;
                    y = bullet[i].y;
                    if (bullet[i].alive && bullet[i].visible)
                    {   draw(x, y, (UWORD) (FIRSTFIRE + player));
            }   }   }
            first = FALSE;
        }

        if (numbered && !final)
        {   putnumber();
        }
        clearkybd();
    } else
    {   stat(player, BONUS); // why?
        if (worm[player].speed == SPEED_FAST)
        {   distance = DISTANCE_FAST;
        } elif (worm[player].speed == SPEED_NORMAL)
        {   distance = DISTANCE_NORMAL;
        } else
        {   distance = DISTANCE_SLOW;
        }

        x = xwrap(worm[player].x + (sgn(worm[player].deltax) * distance));
        y = ywrap(worm[player].y + (sgn(worm[player].deltay) * distance));
        c = field[x][y];

        if
        (   (c < FIRSTGLOW || c > LASTGLOW || player != c - FIRSTGLOW)
         && (!blockedsquare(x, y))
        )
        {   if (level == 0 && bonustype == BONUSLEVEL_JUMP)
            {   xx = worm[player].x;
                yy = worm[player].y;
                for (i = 1; i < distance; i++)
                {   xx = xwrap(xx + sgn(worm[player].deltax));
                    yy = ywrap(yy + sgn(worm[player].deltay));
                    if (field[xx][yy] == STONE)
                    {   switch (distance)
                        {
                        case  DISTANCE_SLOW:   wormscore(player,  25); c = FIRST25POINTS  + player;
                        acase DISTANCE_NORMAL: wormscore(player,  50); c = FIRST50POINTS  + player;
                        acase DISTANCE_FAST:   wormscore(player, 100); c = FIRST100POINTS + player;
                        }
                        ok = FALSE;
                        for (i = 0; i < POINTSLOTS; i++)
                        {   if (point[i].time == 0)
                            {   ok = TRUE;
                                point[i].time  = POINTDURATION;
                                point[i].x     = xx;
                                point[i].y     = yy;
                                point[i].final = EMPTY;
                                draw(xx, yy, c);
                                field[xx][yy] = EMPTY;
                                break;
                        }   }
                        if (!ok)
                        {   change1(xx, yy, EMPTY);
            }   }   }   }

            worm[player].deltax = sgn(worm[player].deltax) * distance;
            worm[player].deltay = sgn(worm[player].deltay) * distance;
}   }   }

MODULE void dogqueue(int which, int deltax, int deltay)
{   if (creature[which].pos < DOGQUEUELIMIT)
    {   creature[which].pos++;
        thedogqueue[which][creature[which].pos].deltax = deltax;
        thedogqueue[which][creature[which].pos].deltay = deltay;
    } else // go back to sleep
    {   creature[which].pos     = -1;
        creature[which].dormant = 0;
        creature[which].deltax  =
        creature[which].deltay  = 0;
        creature[which].player  = -1;
        drawcreature((int) which);
}   }

/* NAME     wormqueue -- adds a keystroke to the key queue
SYNOPSIS    name(int, int, int);
FUNCTION    Adds a keystroke to the in-game key queue.
INPUTS      player - player that pressed the key
            deltax - the deltax of the key
            deltay - the deltay of the key
IMPLEMENTATION
            thewormqueue[] array has WORMQUEUELIMIT as its last index.
            It is implemented as a FIFO stack rather than LIFO so that
            the keystrokes are processed in the correct order (that is,
            the order in which they were pressed). The oldest keystroke
            is always at index [0], the next oldest at [1], and so on
            upwards to the newest keystroke, at [worm[player].pos].
            Keystrokes are removed from the bottom of the array ([0]),
            and the rest of the array is shuffled down to fill the gap,
            so that the contents of [1] go to [0], the contents of [2]
            go to [1], etc. worm[player].pos is adjusted to always point
            to the newest entry, which is the 'end' of the queue.
MODULE      engine2.c */

#ifdef ANDROID
JNIEXPORT void JNICALL Java_com_amigan_wormwars_GameActivity_enqueue(JNIEnv* env, jobject this, jint deltax, jint deltay)
{   int cdeltax, cdeltay;

    cdeltax = (int) deltax - 1;
    cdeltay = (int) deltay - 1;

    wormqueue(0, cdeltax, cdeltay);
}
#endif
EXPORT void wormqueue(int player, int deltax, int deltay)
{   if (worm[player].queuepos < WORMQUEUELIMIT)
    {   worm[player].queuepos++;
        thewormqueue[player][worm[player].queuepos].deltax = deltax;
        thewormqueue[player][worm[player].queuepos].deltay = deltay;
}   }

EXPORT UWORD getimage_creature(int which)
{   int image;

    image = creature[which].species;

    switch (creature[which].species)
    {
    case  BIRD:      image = birdframes[creature[which].frame];
    acase EEL:       image = eelframes[ creature[which].frame];
    acase MISSILE_C: image = missileframes[creature[which].player][creature[which].frame];
    acase TURTLE:    image = turtleframes[creature[which].frame];
    acase RAIN:      image = FIRSTRAIN + creature[which].player;
    acase BULL:      image = (creature[which].dir    == -1) ? BULLLEFT    : BULLRIGHT;
    acase FROG:      image = (creature[which].dir    == -1) ? FROGLEFT    : FROGRIGHT;
    acase RABBIT:    image = (creature[which].deltax <   0) ? RABBITLEFT  : RABBITRIGHT;
    acase LEMMING:   image = (creature[which].deltax <   0) ? LEMMINGLEFT : LEMMINGRIGHT;
    acase ORB:       image = (creature[which].kicked) ? (FIRSTORB + creature[which].player) : ORB;
    acase DOG:       if   (creature[which].dormant ==       0) image = DOGDORMANT;
                     elif (creature[which].dormant <  CHASING) image = DOGAWAKENING;
                     else                                      image = DOGCHASING;
    acase FRAGMENT:  switch (creature[which].subspecies)
                     {
                     case  BANANA:                             image = bananaframes[creature[which].player][creature[which].frame];
                     acase SUPERPULSE:                         image = CLUSTER;
                     adefault:                                 image = FRAGMENT;
                     }
    acase SQUID:     switch (creature[which].deltax)
                     {
                     case  -1:                                 image = SQUIDLEFT;
                     acase  0:                                 image = anims ? squidframes[creature[which].frame] : SQUID;
                     acase  1:                                 image = SQUIDRIGHT;
    }                }

    return (UWORD) image;
}

EXPORT FLAG blockedsquare(int x, int y)
{   UWORD c = field[x][y];

    if
    (   c == STONE
     || c == METAL
     || c == WOOD
     || (c >= FIRSTCREATURE && c <= LASTCREATURE && creatureinfo[sortcreatures[c - FIRSTCREATURE]].wall)
    )
    {   return TRUE;
    } else
    {   return FALSE;
}   }

MODULE void choosediagonal(int* xx, int* yy)
{   ULONG number;

    number = arand(3);
    switch (number)
    {
    case 0:
        *xx = -1;
        *yy = -1;
    acase 1:
        *xx = -1;
        *yy =  1;
    acase 2:
        *xx =  1;
        *yy = -1;
    acase 3:
        *xx =  1;
        *yy =  1;
}   }
MODULE void chooseorthagonal(int* xx, int* yy)
{   ULONG number;

    number = arand(3);
    switch (number)
    {
    case 0:
        *xx =  0;
        *yy = -1;
    acase 1:
        *xx =  0;
        *yy =  1;
    acase 2:
        *xx = -1;
        *yy =  0;
    acase 3:
        *xx =  1;
        *yy =  0;
}   }

EXPORT void stoppedwormloop(int player)
{   int  i;
    FLAG go = FALSE;

    /* remove a keystroke from the worm queue
    The worm still has deltax and deltay whilst stopped. */

    if (!(r % SPEED_PROTECTOR))
    {   protectorloop1(player);
        protectorloop2(player);
    } // affixer becomes a disadvantage in this situation

    if (worm[player].control == THEAMIGA)
    {   wormqueue(player, arand(2) - 1, arand(2) - 1);
    }

    if (worm[player].queuepos != -1)
    {   if (thewormqueue[player][0].deltax == 0 && thewormqueue[player][0].deltay == 0)
        {   if (!worm[player].ammo)
            {   worm[player].speed = SPEED_SLOW;
            }
            wormbullet(player);
        } elif
        (   thewormqueue[player][0].deltax != -worm[player].deltax
         || thewormqueue[player][0].deltay != -worm[player].deltay
        )
        {   worm[player].speed = SPEED_SLOW;
            stat(player, BRAKES);
            worm[player].deltax = thewormqueue[player][0].deltax;
            worm[player].deltay = thewormqueue[player][0].deltay;
            worm[player].frosted = FALSE;
            go = TRUE;
        }
        if (--worm[player].queuepos != -1)
        {   for (i = 0; i <= worm[player].queuepos; i++)
            {   thewormqueue[player][i].deltax = thewormqueue[player][i + 1].deltax;
                thewormqueue[player][i].deltay = thewormqueue[player][i + 1].deltay;
        }   }
        if (go)
        {   wormloop(player);
            worm[player].wait = TRUE;
}   }   }

MODULE void protectorloop1(int player)
{   int i;

    // move protectors

    for (i = 0; i <= PROTECTORS; i++)
    {   if (protector[player][i].alive)
        {   if (protector[player][i].visible)
            {   change1(protector[player][i].x, protector[player][i].y, protector[player][i].last);
            } else protector[player][i].visible = TRUE;
            protector[player][i].last = EMPTY;
            if (i == NOSE)
            {   protector[player][i].relx = worm[player].deltax * DISTANCE_NOSE;
                protector[player][i].rely = worm[player].deltay * DISTANCE_NOSE;
                if (!worm[player].affixer)
                {   if (worm[player].position == -1)
                        worm[player].posidir = 1;
                    elif (worm[player].position == 1)
                        worm[player].posidir = -1;
                    worm[player].position += worm[player].posidir;
                    if (worm[player].deltax == 0)
                        protector[player][i].relx = worm[player].position;
                    elif (worm[player].deltay == 0)
                        protector[player][i].rely = worm[player].position;
                    elif (worm[player].position == -1)
                        protector[player][i].relx = worm[player].deltax * (DISTANCE_NOSE - 1);
                    elif (worm[player].position == 1)
                        protector[player][i].rely = worm[player].deltay * (DISTANCE_NOSE - 1);
            }   }
            elif (!worm[player].affixer)
            {   if (protector[player][i].relx == 1 && protector[player][i].rely == -1)
                {   protector[player][i].deltax = 0;
                    protector[player][i].deltay = 1;
                } elif (protector[player][i].relx == 1 && protector[player][i].rely == 1)
                {   protector[player][i].deltax = -1;
                    protector[player][i].deltay = 0;
                } elif (protector[player][i].relx == -1 && protector[player][i].rely == 1)
                {   protector[player][i].deltax = 0;
                    protector[player][i].deltay = -1;
                } elif (protector[player][i].relx == -1 && protector[player][i].rely == -1)
                {   protector[player][i].deltax = 1;
                    protector[player][i].deltay = 0;
                }
                protector[player][i].relx += protector[player][i].deltax;
                protector[player][i].rely += protector[player][i].deltay;
            }
            protector[player][i].x = worm[player].x + protector[player][i].relx;
            protector[player][i].y = worm[player].y + protector[player][i].rely;
            if (!valid(protector[player][i].x, protector[player][i].y))
            {   protector[player][i].visible = FALSE;
}   }   }   }

MODULE void protectorloop2(int player)
{   SBYTE thisprot;

    // protector collision detection
    for (thisprot = 0; thisprot <= PROTECTORS; thisprot++)
    {   if (protector[player][thisprot].alive && protector[player][thisprot].visible)
        {   protcol(player, protector[player][thisprot].x, protector[player][thisprot].y, thisprot);

            // we now need to recheck whether the protector should be visible or not
            // this might be defensive programming to hide a bug, or might be legitimate
            if (!valid(protector[player][thisprot].x, protector[player][thisprot].y))
            {   protector[player][thisprot].visible = FALSE;
            }

            // draw protector
            if (protector[player][thisprot].alive && protector[player][thisprot].visible) // in case protector has just been killed, etc.
            {   change1(protector[player][thisprot].x, protector[player][thisprot].y, (UWORD) (FIRSTPROTECTOR + player));
}   }   }   }

MODULE void turncreature(UBYTE which)
{   switch (creature[which].dir)
    {
    case 0:
        creature[which].deltax = 0;
        creature[which].deltay = -1;
    acase 1:
        creature[which].deltax = 1;
        creature[which].deltay = -1;
    acase 2:
        creature[which].deltax = 1;
        creature[which].deltay = 0;
    acase 3:
        creature[which].deltax = 1;
        creature[which].deltay = 1;
    acase 4:
        creature[which].deltax = 0;
        creature[which].deltay = 1;
    acase 5:
        creature[which].deltax = -1;
        creature[which].deltay = 1;
    acase 6:
        creature[which].deltax = -1;
        creature[which].deltay = 0;
    acase 7:
        creature[which].deltax = -1;
        creature[which].deltay = -1;
    adefault:
        assert(0);
        creature[which].deltax = creature[which].deltay = 0; // to avoid spurious warnings
}   }

MODULE void reflect(UBYTE which)
{   int   herex,
          herey,
          xx,
          yy;
    FLAG  xset,
          Xset,
          yset,
          Yset;

    if (creature[which].species == FRAGMENT && creature[which].subspecies == CURVER)
    {   creature[which].subspecies = FRAGMENT;
    }

    herex = xwrap(creature[which].x - creature[which].deltax); // the "2" position
    herey = ywrap(creature[which].y - creature[which].deltay);

    if
    (   field[creature[which].x][creature[which].y] >= FIRSTCREATURE
     && field[creature[which].x][creature[which].y] <= LASTCREATURE
     && creatureinfo[sortcreatures[field[creature[which].x][creature[which].y] - FIRSTCREATURE]].wall
     && creature[whichcreature(creature[which].x, creature[which].y, field[creature[which].x][creature[which].y], which)].species != OTTER
    )
    {   creature[whichcreature(creature[which].x, creature[which].y, field[creature[which].x][creature[which].y], which)].alive = FALSE;
        change1(creature[which].x, creature[which].y, (UWORD) (FIRSTFLOWER + arand(3)));
    }

/*  Xy# 1 Y Y 1 #yX
     2x  2x x2  x2  12#
    1 Y Xy# #yX Y 1

    if making a  90 degree X-flip, "3" will be "X"
    if making a  90 degree Y-flip, "3" will be "Y"
    if making a 180 degree   flip, "3" will be "1" */

    if (creature[which].deltax == 0 || creature[which].deltay == 0)
    {   // orthagonal bounce

        xx = -creature[which].deltax;
        yy = -creature[which].deltay;
    } else
    {   // diagonal bounce

        xset = bouncecreature(which, xwrap(herex + creature[which].deltax),       herey                          );
        yset = bouncecreature(which,       herex                          , ywrap(herey + creature[which].deltay));
        Xset = bouncecreature(which, xwrap(herex - creature[which].deltax), ywrap(herey + creature[which].deltay));
        Yset = bouncecreature(which, xwrap(herex + creature[which].deltax), ywrap(herey - creature[which].deltay));

        if (xset && !Xset && yset && !Yset)
        {   // flip 180�
            xx = -creature[which].deltax;
            yy = -creature[which].deltay;
        } elif (xset && !Xset)
        {   // flip 90� on X-axis
            xx = -creature[which].deltax;
            yy =  creature[which].deltay;
        } elif (yset && !Yset)
        {   // flip 90� on Y-axis
            xx =  creature[which].deltax;
            yy = -creature[which].deltay;
        } else
        {   // flip 180�
            xx = -creature[which].deltax;
            yy = -creature[which].deltay;
    }   }

    creature[which].x = xwrap(creature[which].x - creature[which].deltax + xx);
    creature[which].y = ywrap(creature[which].y - creature[which].deltay + yy);
    creature[which].deltax = xx;
    creature[which].deltay = yy;
}

MODULE void checkrectangle(int direction, int player, int horizontalsize, int verticalsize)
{   TRANSIENT int   i,
                    x, y, leftx, rightx, topy, bottomy;
    PERSIST   struct
    {   const int deltax[4], deltay[4];
    } deltas[4] =
    { { { 0, -1,  0,  1}, // northwest
        {-1,  0,  1,  0}
      },
      { { 0,  1,  0, -1}, // northeast
        {-1,  0,  1,  0}
      },
      { { 0,  1,  0, -1}, // southeast
        { 1,  0, -1,  0}
      },
      { { 0, -1,  0,  1}, // southwest
        { 1,  0, -1,  0}
    } };
    PERSIST struct
    {   int leftx, rightx, topy, bottomy;
    } enclose[4] =
    { {-127,   -1, -127,  -1 }, // northwest
      {   1,  127, -127,  -1 }, // northeast
      {   1,  127,    1, 127 }, // southeast
      {-127,   -1,    1, 127 }  // southwest
    };

    x = worm[player].x;
    y = worm[player].y; // for speed
    for (i = 0; i <= verticalsize; i++)
    {   x += deltas[direction].deltax[0];
        y += deltas[direction].deltay[0];
        if
        (   (!valid(x, y))
         || (   field[x][y] != FIRSTTAIL + player
             && field[x][y] != FIRSTGLOW + player
        )   )
        {   return;
    }   }
    for (i = 0; i <= horizontalsize; i++)
    {   x += deltas[direction].deltax[1];
        y += deltas[direction].deltay[1];
        if
        (   (!valid(x, y))
         || (   field[x][y] != FIRSTTAIL + player
             && field[x][y] != FIRSTGLOW + player
        )   )
        {   return;
    }   }
    for (i = 0; i <= verticalsize; i++)
    {   x += deltas[direction].deltax[2];
        y += deltas[direction].deltay[2];
        if
        (   (!valid(x, y))
         || (   field[x][y] != FIRSTTAIL + player
             && field[x][y] != FIRSTGLOW + player
        )   )
        {   return;
    }   }
    for (i = 0; i <= horizontalsize - 1; i++)
    {   x += deltas[direction].deltax[3];
        y += deltas[direction].deltay[3];
        if
        (   (!valid(x, y))
         || (   field[x][y] != FIRSTTAIL + player
             && field[x][y] != FIRSTGLOW + player
        )   )
        {   return;
    }   }

    if (enclose[direction].leftx < -1)
    {   enclose[direction].leftx = -horizontalsize;
    } elif (enclose[direction].leftx > 1)
    {   enclose[direction].leftx = horizontalsize + 1;
    }
    if (enclose[direction].rightx < -1)
    {   enclose[direction].rightx = -(horizontalsize + 1);
    } elif (enclose[direction].rightx > 1)
    {   enclose[direction].rightx = horizontalsize;
    }
    if (enclose[direction].topy < -1)
    {   enclose[direction].topy = -verticalsize;
    } elif (enclose[direction].topy > 1)
    {   enclose[direction].topy = verticalsize + 1;
    }
    if (enclose[direction].bottomy < -1)
    {   enclose[direction].bottomy = -(verticalsize + 1);
    } elif (enclose[direction].bottomy > 1)
    {   enclose[direction].bottomy = verticalsize;
    }

      leftx = worm[player].x + enclose[direction].leftx;
     rightx = worm[player].x + enclose[direction].rightx;
       topy = worm[player].y + enclose[direction].topy;
    bottomy = worm[player].y + enclose[direction].bottomy;
    assert(leftx >= 0 && rightx <= fieldx && topy >= 0 && bottomy <= fieldy && leftx < rightx && topy < bottomy);

    for (x = leftx; x <= rightx; x++)
    {   for (y = topy; y <= bottomy; y++)
        {   if (encloseit(player, x, y))
            {   enclosed = TRUE;
}   }   }   }

MODULE void checkdiamond(int direction, int player, int size)
{   TRANSIENT int   i, j,
                    x, y, leftx, rightx, topy, bottomy,
                    centrex = 0, centrey = 0, // initialized to avoid spurious GCC compiler warnings
                    distance;
    PERSIST   struct
    {   const int deltax[4], deltay[4];
    } deltas[4] =
    { { {-1, -1,  1,  1}, // west
        {-1,  1,  1, -1}
      },
      { { 1,  1, -1, -1}, // east
        {-1,  1,  1, -1}
      },
      { {-1,  1,  1, -1}, // north
        {-1, -1,  1,  1}
      },
      { {-1,  1,  1, -1}, // south
        { 1,  1, -1, -1}
    } };

    x = worm[player].x;
    y = worm[player].y; // for speed

    for (i = 0; i < 4; i++)
    {   for (j = 0; j <= size; j++)
        {   x += deltas[direction].deltax[i];
            y += deltas[direction].deltay[i];
            if
            (   (!valid(x, y))
             || (   field[x][y] != FIRSTTAIL + player
                 && field[x][y] != FIRSTGLOW + player
            )   )
            {   return;
    }   }   }

    switch (direction)
    {
    case 0: // west
        centrex = worm[player].x - size - 1;
        centrey = worm[player].y;
    acase 1: // east
        centrex = worm[player].x + size + 1;
        centrey = worm[player].y;
    acase 2: // north
        centrex = worm[player].x;
        centrey = worm[player].y - size - 1;
    acase 3: // south
        centrex = worm[player].x;
        centrey = worm[player].y + size + 1;
    }

      leftx = centrex - size;
     rightx = centrex + size;
       topy = centrey - size;
    bottomy = centrey + size;
    assert(leftx >= 0 && rightx <= fieldx && topy >= 0 && bottomy <= fieldy && leftx < rightx && topy < bottomy);

    for (x = leftx; x <= rightx; x++)
    {   for (y = topy; y <= bottomy; y++)
        {   distance = abs(centrey - y);
            if (x < centrex - (size - distance) || x > centrex + (size - distance))
            {   continue;
            }
            if (encloseit(player, x, y))
            {   enclosed = TRUE;
}   }   }   }

MODULE void checktriangle(int direction, int player, int size)
{   TRANSIENT int   i,
                    x, leftx,  rightx, xx,
                    y,  topy, bottomy;
    PERSIST   struct
    {   const int deltax[3], deltay[3];
    } deltas[4] =
    { { { 0, -1,  1}, // northwest triangle (n, sw, e)
        {-1,  1,  0}
      },
      { { 0,  1, -1}, // northeast triangle (n, se, w)
        {-1,  1,  0}
      },
      { { 0,  1, -1}, // southeast triangle (s, ne, w)
        { 1, -1,  0}
      },
      { { 0, -1,  1}, // southwest triangle (s, nw, e)
        { 1, -1,  0}
    } };
    PERSIST struct
    {   int leftx, rightx, topy, bottomy;
    } enclose[4] =
    { {-127,   -1, -127,  -1 }, // northwest
      {   1,  127, -127,  -1 }, // northeast
      {   1,  127,    1, 127 }, // southeast
      {-127,   -1,    1, 127 }  // southwest
    };

    x = worm[player].x;
    y = worm[player].y; // for speed

    // first triangle side (orthagonal)
    for (i = 0; i <= size; i++)
    {   x += deltas[direction].deltax[0];
        y += deltas[direction].deltay[0];
        if
        (   (!valid(x, y))
         || (   field[x][y] != FIRSTTAIL + player
             && field[x][y] != FIRSTGLOW + player
        )   )
        {   return;
    }   }
    // second triangle side (diagonal)
    for (i = 0; i <= size; i++)
    {   x += deltas[direction].deltax[1];
        y += deltas[direction].deltay[1];
        if
        (   (!valid(x, y))
         || (   field[x][y] != FIRSTTAIL + player
             && field[x][y] != FIRSTGLOW + player
        )   )
        {   return;
    }   }
    // third triangle side (orthagonal)
    for (i = 0; i <= size - 1; i++)
    {   x += deltas[direction].deltax[2];
        y += deltas[direction].deltay[2];
        if
        (   (!valid(x, y))
         || (   field[x][y] != FIRSTTAIL + player
             && field[x][y] != FIRSTGLOW + player
        )   )
        {   return;
    }   }

    if (enclose[direction].leftx < -1)
    {   enclose[direction].leftx = -size;
    } elif (enclose[direction].leftx > 1)
    {   enclose[direction].leftx = size + 1;
    }
    if (enclose[direction].rightx < -1)
    {   enclose[direction].rightx = -(size + 1);
    } elif (enclose[direction].rightx > 1)
    {   enclose[direction].rightx = size;
    }
    if (enclose[direction].topy < -1)
    {   enclose[direction].topy = -size;
    } elif (enclose[direction].topy > 1)
    {   enclose[direction].topy = size + 1;
    }
    if (enclose[direction].bottomy < -1)
    {   enclose[direction].bottomy = -(size + 1);
    } elif (enclose[direction].bottomy > 1)
    {   enclose[direction].bottomy = size;
    }

      leftx = worm[player].x + enclose[direction].leftx;
     rightx = worm[player].x + enclose[direction].rightx;
       topy = worm[player].y + enclose[direction].topy;
    bottomy = worm[player].y + enclose[direction].bottomy;
    assert(leftx >= 0 && rightx <= fieldx && topy >= 0 && bottomy <= fieldy && leftx < rightx && topy < bottomy);

    i = 1;
    switch (direction)
    {
    case 0: // northwest
        for (y = bottomy; y >= topy; y--)
        {   xx = leftx + i;
            for (x = xx; x <= rightx; x++)
            {   if (encloseit(player, x, y))
                {   enclosed = TRUE;
            }   }
            i++;
        }
    acase 1: // northeast
        for (y = bottomy; y >= topy; y--)
        {   xx = rightx - i;
            for (x = leftx; x <= xx; x++)
            {   if (encloseit(player, x, y))
                {   enclosed = TRUE;
            }   }
            i++;
        }
    acase 2: // southeast
        for (y = topy; y <= bottomy; y++)
        {   xx = rightx - i;
            for (x = leftx; x <= xx; x++)
            {   if (encloseit(player, x, y))
                {   enclosed = TRUE;
            }   }
            i++;
        }
    acase 3: // southwest
        for (y = topy; y <= bottomy; y++)
        {   xx = leftx + i;
            for (x = xx; x <= rightx; x++)
            {   if (encloseit(player, x, y))
                {   enclosed = TRUE;
            }   }
            i++;
}   }   }

MODULE FLAG encloseit(int player, int x, int y)
{   UWORD c = field[x][y];

    if
    (    (c >= FIRSTEMPTY && c <= LASTEMPTY)
     || ((c >= FIRSTTAIL  && c <= LASTTAIL ) && c != FIRSTTAIL + player)
     || ((c >= FIRSTGLOW  && c <= LASTGLOW ) && c != FIRSTGLOW + player)
    )
    {   change2(x, y, (UWORD) (FIRSTGLOW + player), (UWORD) (TAILSOFFSET + 57 + (player * 58)));
        if (level == 0 && bonustype == BONUSLEVEL_ENCLOSE)
        {   wormscore((SBYTE) player, POINTS_ENCLOSE);
        }
        return TRUE;
    } elif (c >= FIRSTCREATURE && c <= LASTCREATURE)
    {   wormkillcreature(player, whichcreature(x, y, c, 255), TRUE);
        return TRUE;
    } else
    {   return FALSE;
}   }

MODULE void protprot(int x, int y, int player1, int player2)
{   int i,
        p1 = -1, p2 = -1; // to prevent spurious warnings

    /* Find both protectors */

    for (i = 0; i <= PROTECTORS; i++)
    {   if (protector[player1][i].alive && protector[player1][i].x == x && protector[player1][i].y == y)
            p1 = i;
        if (protector[player2][i].alive && protector[player2][i].x == x && protector[player2][i].y == y)
            p2 = i;
    }
    protector[player1][p1].alive = FALSE;
    protector[player2][p2].alive = FALSE;
    change1(x, y, EMPTY);
}

MODULE void worm_captureorb(int player)
{   int which;

    if (level || bonustype != BONUSLEVEL_ORBS)
    {   return;
    }

    for (which = 0; which <= CREATURES; which++)
    {   if
        (   creature[which].alive
         && creature[which].species == ORB
         && creature[which].x >= worm[player].x - 1
         && creature[which].x <= worm[player].x + 1
         && creature[which].y >= worm[player].y - 1
         && creature[which].y <= worm[player].y + 1
        )
        {   wormscore((SBYTE) player, creature[which].score);
            creature[which].alive = FALSE;
            change1(creature[which].x, creature[which].y, EMPTY);

            do
            {   ;
            } while (createprotector(player, (arand(1) * 2) - 1, (arand(1) * 2) - 1) == 1);

            return;
}   }   }

MODULE void creature_captureorb(int which)
{   int player;

    if (level || bonustype != BONUSLEVEL_ORBS)
    {   return;
    }

    for (player = 0; player <= 3; player++)
    {   if
        (   worm[player].lives
         && creature[which].x >= worm[player].x - 1
         && creature[which].x <= worm[player].x + 1
         && creature[which].y >= worm[player].y - 1
         && creature[which].y <= worm[player].y + 1
        )
        {   wormscore((SBYTE) player, creature[which].score);
            creature[which].alive = FALSE;

            do
            {   ;
            } while (createprotector(player, (arand(1) * 2) - 1, (arand(1) * 2) - 1) == 1);

            return;
}   }   }

EXPORT void help_update(void)
{
#if defined(ANDROID) || defined(GBA)
    ;
#else
    double             oldver,
                       newver;
    STRPTR             message;
    int                hSocket = -1,
                       i, j,
                       length;
    char               ip[15 + 1]; // enough for "208.115.246.164"
    TEXT               tempstring[80 + 1];
    struct sockaddr_in INetSocketAddr;
#ifndef __amigaos4__
    struct hostent*    HostAddr;
    struct in_addr**   addr_list;
#endif

    busypointer();

#ifdef AMIGA
    if (!(SocketBase = OpenLibrary("bsdsocket.library", 0)))
    {   normalpointer();
        alwaysrq = TRUE;
        say("Can't open bsdsocket.library!", RED);
        alwaysrq = FALSE;
        goto DONE;
    }
#endif
#ifdef __amigaos4__
    if (!(ISocket = (struct SocketIFace*) GetInterface((struct Library*) SocketBase,  "main", 1, NULL)))
    {   normalpointer();
        alwaysrq = TRUE;
        say("Can't get bsdsocket.library interface!", RED);
        alwaysrq = FALSE;
        goto DONE;
    }

    strcpy(ip, "216.245.218.214"); // was 208.115.246.164
#else
    HostAddr = gethostbyname("amigan.1emu.net");
    if (HostAddr)
    {   // Cast the h_addr_list to in_addr, since h_addr_list also has the IP address in long format only
        addr_list = (struct in_addr**) HostAddr->h_addr_list;
        for (i = 0; addr_list[i] != NULL; i++)
        {   strcpy(ip, inet_ntoa(*addr_list[i]));
    }   }
    else
    {   strcpy(ip, "216.245.218.214"); // was 208.115.246.164
    }
#endif

    hSocket = (int) socket(AF_INET, SOCK_STREAM, 0);
    if (hSocket == -1)
    {   normalpointer();
        alwaysrq = TRUE;
        say("Socket allocation failed!", RED);
        alwaysrq = FALSE;
        goto DONE;
    }

    INetSocketAddr.sin_family      = AF_INET;
    INetSocketAddr.sin_port        = htons(80); // HTTP
#ifdef AMIGA
    INetSocketAddr.sin_len         = 16; // sizeof(INetSocketAddr)
#endif
    INetSocketAddr.sin_addr.s_addr = inet_addr(ip);
    for (i = 0; i < 8; i++)
    {   INetSocketAddr.sin_zero[i] = 0;
    }

#ifdef __amigaos4__
    if (connect(hSocket, (      struct sockaddr*) &INetSocketAddr, 16) == -1)
#else
    if (connect(hSocket, (const struct sockaddr*) &INetSocketAddr, 16) == -1)
#endif
    {   normalpointer();
        alwaysrq = TRUE;
        say("Socket connection failed (no internet connection?)!", RED);
        alwaysrq = FALSE;
        goto DONE;
    }

#ifdef WIN32
    message = "GET /releases/ww-ibm.txt HTTP/1.1\r\nHost: amigan.1emu.net:80\r\n\r\n";
#endif
#ifdef AMIGA
    #ifdef __MORPHOS__
        message = "GET /releases/ww-mos.txt HTTP/1.1\r\nHost: amigan.1emu.net:80\r\n\r\n";
    #else
        #ifdef __AROS__
            message = "GET /releases/ww-aros.txt HTTP/1.1\r\nHost: amigan.1emu.net:80\r\n\r\n";
        #else
            #ifdef __amigaos4__
                message = "GET /releases/ww-os4.txt HTTP/1.1\r\nHost: amigan.1emu.net:80\r\n\r\n";
            #else
                message = "GET /releases/ww-os3.txt HTTP/1.1\r\nHost: amigan.1emu.net:80\r\n\r\n";
            #endif
        #endif
    #endif
#endif

    if (send(hSocket, message, strlen(message), 0) < 0)
    {   normalpointer();
        alwaysrq = TRUE;
        say("Can't send query to server!", RED);
        alwaysrq = FALSE;
        goto DONE;
    }

    length = (int) recv(hSocket, replystring, 1000, 0);
    if (length < 0)
    {   normalpointer();
        alwaysrq = TRUE;
        say("Can't receive response from server!", RED);
        alwaysrq = FALSE;
        goto DONE;
    } else
    {   replystring[length] = EOS;
    }

    length = strlen(replystring);
    i = length - 4;
    j = length;
    while (i >= 0)
    {   if (replystring[i] == CR && replystring[i + 1] == LF && replystring[i + 2] == CR && replystring[i + 3] == LF)
        {   j = i + 4;
            break;
        } else
        {   i--;
    }   }

    if (j == length)
    {   normalpointer();
        alwaysrq = TRUE;
        say("Invalid response from server!", RED);
        alwaysrq = FALSE;
        goto DONE;
    } elif (replystring[j] == 239 && replystring[j + 1] == 187 && replystring[j + 2] == 191) // because sometimes it is prepended with "﻿"
    {   j += 3; // skip crap
    }

    if (replystring[j] < '0' || replystring[j] > '9')
    {   normalpointer();
        alwaysrq = TRUE;
        say("Can't download update file!", RED);
        alwaysrq = FALSE;
        goto DONE;
    }

#ifdef WIN32
    oldver = zatof(DECIMALVERSION);
    newver = zatof(&replystring[j]);
#endif
#ifdef AMIGA
    oldver = atof(DECIMALVERSION);
    newver = atof(&replystring[j]);
#endif

    normalpointer();
    if (newver > oldver)
    {   sprintf(tempstring, "Worm Wars %.2f %s!", (float) newver, LLL(MSG_UPDATE_YES, "is available")); // we would prefer eg. 25.0 instead of 25.00
        alwaysrq = TRUE;
        say(tempstring, BLUE);
        alwaysrq = FALSE;
        openurl("http://amigan.1emu.net/releases/#wormwars");
    }
    else
    {   alwaysrq = TRUE;
        say(LLL(MSG_UPDATE_NO, "You are up to date."), GREEN);
        alwaysrq = FALSE;
    }

DONE:
    if (hSocket != -1)
    {   DISCARD CloseSocket(hSocket);
        // hSocket = -1; (dead assignment)
    }
#ifdef __amigaos4__
    if (ISocket)
    {   DropInterface((struct Interface*) ISocket);
        ISocket = NULL;
    }
#endif
#ifdef AMIGA
    if (SocketBase)
    {   CloseLibrary(SocketBase);
        SocketBase = NULL;
    }
#endif
#endif
}

EXPORT int sgn(int value)
{   if (value >= 1)
    {   return 1;
    } elif (value <= -1)
    {   return -1;
    } else
    {   return 0;
}   }

#if defined(ANDROID) || defined(GBA)
EXPORT void outro(void)
{   int   i, j,
          x, y,
          xoffset, yoffset;
    FLAG  started;
    TEXT  tempstring[6 + 1];
    UWORD image;

#ifdef GBA
    for (y = 1; y <= 11; y++)
    {   for (x = 1; x <= 18; x++)
        {   draw(x, y, EMPTY);
    }   }

    for (x = 1; x <= 18; x++)
    {   draw(x,  0, (UWORD) (GG_W_E + (showing * 58))); // top line
        draw(x, 12, (UWORD) (GG_W_E + (showing * 58))); // bottom line
    }
    for (y = 1; y <= 11; y++)
    {   draw( 0, y, (UWORD) (GG_N_S + (showing * 58))); // left line
        draw(19, y, (UWORD) (GG_N_S + (showing * 58))); // right line
    }
    draw( 0,  0, (UWORD) (GG_E_S + (showing * 58))); // top left
    draw( 0, 12, (UWORD) (GG_N_E + (showing * 58))); // bottom left
    draw(19,  0, (UWORD) (GG_W_S + (showing * 58))); // top right
    draw(19, 12, (UWORD) (GG_N_W + (showing * 58))); // bottom right

    draw( 1,  2,          TREASURE                               );
    if (worm[showing].numbers == 0)
    {   draw(1, 4, (UWORD) (FIRSTPAIN   + showing                  ));
    } else
    {   draw(1, 4, (UWORD) (FIRSTNUMBER + worm[showing].numbers - 1));
    }
    draw( 1,  6,          CLOCK                                  );
    draw( 1,  8, (UWORD) (FIRSTTAIL   + showing                  ));
    draw( 1, 10, (UWORD) (FIRSTGLOW   + showing                  ));

    for (i = 0; i <= 4; i++)
    {   if (i == 2)
        {   draw(5, 6, getdigit( quantity[2][0] / 60      ));
            draw(6, 6, COLON);
            draw(7, 6, getdigit((quantity[2][0] % 60) / 10));
            draw(8, 6, getdigit( quantity[2][0] % 10      ));
        } else
        {   tempstring[0] =  quantity[i][0] / 100000;
            tempstring[1] = (quantity[i][0] % 100000) /  10000;
            tempstring[2] = (quantity[i][0] %  10000) /   1000;
            tempstring[3] = (quantity[i][0] %   1000) /    100;
            tempstring[4] = (quantity[i][0] %    100) /     10;
            tempstring[5] =  quantity[i][0] %     10;
            tempstring[6] = EOS;
            started = FALSE;
            for (j = 0; j < 6; j++)
            {   image = getdigit(tempstring[j]);
                if (image != ZERONUMBER || started || j == 5)
                {   started = TRUE;
                    draw(3 + j, (i * 2) + 2, image);
        }   }   }

        draw(10, (i * 2) + 2, MULTIPLICATION);

        tempstring[0] =  quantity[i][1] / 100000;
        tempstring[1] = (quantity[i][1] % 100000) /  10000;
        tempstring[2] = (quantity[i][1] %  10000) /   1000;
        tempstring[3] = (quantity[i][1] %   1000) /    100;
        tempstring[4] = (quantity[i][1] %    100) /     10;
        tempstring[5] =  quantity[i][1] %     10;
        tempstring[6] = EOS;
        started = FALSE;
        for (j = 0; j < 6; j++)
        {   image = getdigit(tempstring[j]);
            if (image != ZERONUMBER || started || j == 5)
            {   started = TRUE;
                draw(11 + j, (i * 2) + 2, image);
        }   }

        draw(18, (i * 2) + 2, EQUALS);

        tempstring[0] =  quantity[i][2] / 100000;
        tempstring[1] = (quantity[i][2] % 100000) /  10000;
        tempstring[2] = (quantity[i][2] %  10000) /   1000;
        tempstring[3] = (quantity[i][2] %   1000) /    100;
        tempstring[4] = (quantity[i][2] %    100) /     10;
        tempstring[5] =  quantity[i][2] %     10;
        tempstring[6] = EOS;
        started = FALSE;
        for (j = 0; j < 6; j++)
        {   image = getdigit(tempstring[j]);
            if (image != ZERONUMBER || started || j == 5)
            {   started = TRUE;
                draw(11 + j, (i * 2) + 3, image);
    }   }   }
#else
    for (y = 0; y <= fieldy; y++)
    {   for (x = 0; x <= fieldx; x++)
        {   raw_draw(x, y, (UWORD) (FIRSTTAIL + showing));
    }   }

    xoffset = (fieldx + 1 - 27) / 2;
    yoffset = (fieldy + 1 - 13) / 2;
    for (y = 1; y <= 11; y++)
    {   for (x = 1; x <= 25; x++)
        {   raw_draw(xoffset + x, yoffset + y, EMPTY);
    }   }

    for (x = 1; x < 26; x++)
    {   raw_draw(xoffset +  x, yoffset +  0, (UWORD) (GG_W_E + (showing * 58))); // top line
        raw_draw(xoffset +  x, yoffset + 12, (UWORD) (GG_W_E + (showing * 58))); // bottom line
    }
    for (y = 1; y <= 11; y++)
    {   raw_draw(xoffset +  0, yoffset +  y, (UWORD) (GG_N_S + (showing * 58))); // left line
        raw_draw(xoffset + 26, yoffset +  y, (UWORD) (GG_N_S + (showing * 58))); // right line
    }
    raw_draw(    xoffset +  0, yoffset +  0, (UWORD) (GG_E_S + (showing * 58))); // top left
    raw_draw(    xoffset +  0, yoffset + 12, (UWORD) (GG_N_E + (showing * 58))); // bottom left
    raw_draw(    xoffset + 26, yoffset +  0, (UWORD) (GG_W_S + (showing * 58))); // top right
    raw_draw(    xoffset + 26, yoffset + 12, (UWORD) (GG_N_W + (showing * 58))); // bottom right

    raw_draw(    xoffset +  2, yoffset +  2,          TREASURE                               );
    if (worm[showing].numbers == 0)
    {   raw_draw(xoffset +  2, yoffset +  4, (UWORD) (FIRSTPAIN   + showing                  ));
    } else
    {   raw_draw(xoffset +  2, yoffset +  4, (UWORD) (FIRSTNUMBER + worm[showing].numbers - 1));
    }
    raw_draw(    xoffset +  2, yoffset +  6,          CLOCK                                  );
    raw_draw(    xoffset +  2, yoffset +  8, (UWORD) (FIRSTTAIL   + showing                  ));
    raw_draw(    xoffset +  2, yoffset + 10, (UWORD) (FIRSTGLOW   + showing                  ));

    /*  0         1         2     2
        012345678901234567890123456
       0+-------------------------+
       1|                         |
       2| #123456 x123456 =123456 |
       3|                         |
       4| #123456 x123456 =123456 |
       5|                         |
       6| #123456 x123456 =123456 |
       7|                         |
       8| #123456 x123456 =123456 |
       9|                         |
      10| #123456 x123456 =123456 |
      11|                         |
      12+-------------------------+ */

    for (i = 0; i <= 4; i++)
    {   if (i == 2)
        {   raw_draw(xoffset +  5, yoffset + 6, getdigit( quantity[2][0] / 60      ));
            raw_draw(xoffset +  6, yoffset + 6, COLON);
            raw_draw(xoffset +  7, yoffset + 6, getdigit((quantity[2][0] % 60) / 10));
            raw_draw(xoffset +  8, yoffset + 6, getdigit( quantity[2][0] % 10      ));
        } else
        {   tempstring[0] =  quantity[i][0] / 100000;
            tempstring[1] = (quantity[i][0] % 100000) /  10000;
            tempstring[2] = (quantity[i][0] %  10000) /   1000;
            tempstring[3] = (quantity[i][0] %   1000) /    100;
            tempstring[4] = (quantity[i][0] %    100) /     10;
            tempstring[5] =  quantity[i][0] %     10;
            tempstring[6] = EOS;
            started = FALSE;
            for (j = 0; j < 6; j++)
            {   image = getdigit(tempstring[j]);
                if (image != ZERONUMBER || started || j == 5)
                {   started = TRUE;
                    raw_draw(xoffset + 3 + j, yoffset + (i * 2) + 2, image);
        }   }   }

        raw_draw(    xoffset + 10    , yoffset + (i * 2) + 2, MULTIPLICATION);

        tempstring[0] =  quantity[i][1] / 100000;
        tempstring[1] = (quantity[i][1] % 100000) /  10000;
        tempstring[2] = (quantity[i][1] %  10000) /   1000;
        tempstring[3] = (quantity[i][1] %   1000) /    100;
        tempstring[4] = (quantity[i][1] %    100) /     10;
        tempstring[5] =  quantity[i][1] %     10;
        tempstring[6] = EOS;
        started = FALSE;
        for (j = 0; j < 6; j++)
        {   image = getdigit(tempstring[j]);
            if (image != ZERONUMBER || started || j == 5)
            {   started = TRUE;
                raw_draw(xoffset + 11 + j, yoffset + (i * 2) + 2, image);
        }   }

        raw_draw(        xoffset + 18    , yoffset + (i * 2) + 2, EQUALS);

        tempstring[0] =  quantity[i][2] / 100000;
        tempstring[1] = (quantity[i][2] % 100000) /  10000;
        tempstring[2] = (quantity[i][2] %  10000) /   1000;
        tempstring[3] = (quantity[i][2] %   1000) /    100;
        tempstring[4] = (quantity[i][2] %    100) /     10;
        tempstring[5] =  quantity[i][2] %     10;
        tempstring[6] = EOS;
        started = FALSE;
        for (j = 0; j < 6; j++)
        {   image = getdigit(tempstring[j]);
            if (image != ZERONUMBER || started || j == 5)
            {   started = TRUE;
                raw_draw(xoffset + 19 + j, yoffset + (i * 2) + 2, image);
    }   }   }
#endif
}
#endif
