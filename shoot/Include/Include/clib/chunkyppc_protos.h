#ifndef CLIB_CHUNKYPPC_H
#define CLIB_CHUNKYPPC_H
#ifndef EXEC_LIBRARIES_H
#include <exec/libraries.h>
#endif
#ifndef GRAPHICS_GFX_H
#include <graphics/gfx.h>
#endif
#include <intuition/intuition.h>
#include <libraries/asl.h>
#include <cybergraphx/cybergraphics.h>

#ifdef __PPC
#include <powerpc/warpup_macros.h>
#endif

extern struct Library *ChunkyPPCBase;

#ifndef __INLINE_MACROS_H
#ifdef __PPC
#include <powerup/ppcinline/macros.h>
#else
#include <inline/macros.h>
#endif
#endif /* !__INLINE_MACROS_H */

#ifndef CHUNKYPPC_BASE_NAME
#define CHUNKYPPC_BASE_NAME ChunkyPPCBase
#endif /* !CHUNKYPPC_BASE_NAME */

#define ChunkyInit68k(Mode_Screen_, srcformat) \
    LP2(0xc6, int, ChunkyInit68k, struct Mode_Screen *, Mode_Screen_, a0, int, srcformat, d0, \
    , CHUNKYPPC_BASE_NAME,0,0,0,0,0,0)

#define CloseGraphics(Mode_Screen_, shutdownlibs) \
    LP2NR(0xd2, CloseGraphics, struct Mode_Screen *, Mode_Screen_, a0, int, shutdownlibs, d0, \
    , CHUNKYPPC_BASE_NAME,0,0,0,0,0,0)

#define DoubleBuffer(Mode_Screen_) \
    LP1NR(0xde, DoubleBuffer, struct Mode_Screen *, Mode_Screen_, a0, \
    , CHUNKYPPC_BASE_NAME,0,0,0,0,0,0)

#define LoadColors(Mode_Screen_, Table) \
    LP2NR(0xd8, LoadColors, struct Mode_Screen *, Mode_Screen_, a0, ULONG *, Table, a1, \
    , CHUNKYPPC_BASE_NAME,0,0,0,0,0,0)

#define OpenGraphics(Title, Mode_Screen_, override) \
    LP3(0xcc, struct Mode_Screen *, OpenGraphics, char *, Title, a0, struct Mode_Screen *, Mode_Screen_, a1, int, override, d0, \
    , CHUNKYPPC_BASE_NAME,0,0,0,0,0,0)

#define BIT16 1
#define BIT16_SWAP 2
#define BIT16_ROT 4
#define BIT16_SWAP_ROT 8
#define BIT24 16
#define BIT24_ROT 32
#define BIT32 64
#define BIT32_SWAP 128
#define BIT32_ROT 256
#define BIT32_SWAP_ROT 512
#define BIT32_ROT_REVERSE 1024
#define BIT32_SWAP_ROT_REVERSE 2048
#define BIT8 4096

struct Soff
{
 int x,y;
};

struct Buffers
{
 UBYTE *address;
 UBYTE *mask;
};

struct Mode_Screen
{
    struct Screen *video_screen;
    struct Window *video_window;
    int bpr;
    int wb_int;
    int pip_int;
    int dbuf_int;
    int oldstyle_int;
    char pubscreenname[512];
    int mode;
    int SCREENWIDTH;
    int SCREENHEIGHT;
    int MS_MAXWIDTH;
    int MS_MAXHEIGHT;
    int MINDEPTH;
    int MAXDEPTH;
    int format;
    int video_depth;
    UWORD *emptypointer;
    struct BitMap *video_tmp_bm;
    int video_is_native_mode;
    int video_is_cyber_mode;
    unsigned char *screen;
    int video_oscan_height;
    int bufnum;
    struct RastPort *video_rastport;
    struct BitMap *bitmapa;
    struct BitMap *bitmapb;
    struct BitMap *bitmapc;
    struct BitMap *thebitmap;
    struct RastPort *video_temprp;
    struct ScreenModeRequester *video_smr;
    int ham_int;
    UBYTE *wbcolors;
    UBYTE *transtable;
    unsigned long *WBColorTable;
    unsigned long *ColorTable;
    int pal_changed;
    int pen_obtained;
    unsigned char *screenb;
    unsigned char *screenc;
    int numbuffers;
    int rtgm_int;
    struct ScreenBuffer *Buf1;
    struct ScreenBuffer *Buf2;
    struct ScreenBuffer *Buf3;
    void * (*algo)(struct Mode_Screen *ms,unsigned char *dest,unsigned char *src, int srcformat,void *(*hook68k)(unsigned char *data),unsigned char *data);
    void (*Internal1)(void);
    void (*Internal2)(void);
    int onlyptr;
    int likecgx;
};

#ifdef __PPC
#define ChunkyNoffFast(v1,v2,v3,v4,v5) PPCLP6NR (ChunkyPPCBase,-30,struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,UBYTE *,5,v2,int,6,v3,int,7,v4,int,8,v5)

#define ChunkyNoffFastest(v1,v2,v3,v4,v5) PPCLP6NR (ChunkyPPCBase,-36,struct Library *,3,ChunkyPPCBase,unsigned char *,4,v1,unsigned char *,5,v2,int,6,v3,int,7,v4,int,8,v5)

#define ChunkyNoffNormal(v1,v2,v3,v4,v5) PPCLP6NR (ChunkyPPCBase,-42,struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,UBYTE *,5,v2,int,6,v3,int,7,v4,int,8,v5)

#define ChunkyFast(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR (ChunkyPPCBase,-48,struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,UBYTE *,5,v2,int,6,v3,int,7,v4,int,8,v5,int,9, v6, int,10, v7)

#define ChunkyFastest(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR (ChunkyPPCBase,-54,struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,UBYTE *,5,v2,int,6,v3,int,7,v4,int,8,v5,int,9,v6,int,10,v7)

#define ChunkyNormal(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR (ChunkyPPCBase,-60,struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,UBYTE *,5,v2,int,6,v3,int,7,v4,int,8,v5,int,9,v6,int,10,v7)

#define ChunkyFastFull(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR (ChunkyPPCBase, -66, struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,UBYTE *,5,v2,struct Soff *,6,v3, struct Soff *,7,v4,int,8,v5,struct Soff *,9,v6,int,10,v7)

#define ChunkyFastestFull(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR (ChunkyPPCBase, -72, struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,UBYTE *,5,v2,struct Soff *,6,v3, struct Soff *,7,v4,int,8,v5,struct Soff *,9,v6,int,10,v7)

#define ChunkyNormalFull(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR (ChunkyPPCBase, -78, struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,UBYTE *,5,v2,struct Soff *,6,v3, struct Soff *,7,v4,int,8,v5,struct Soff *,9,v6,int,10,v7)

#define c2p_1(v1,v2,v3,v4) PPCLP5NR (ChunkyPPCBase, -84, struct Library *,3, ChunkyPPCBase, UBYTE *,4,v1,struct BitMap *,5,v2,int,6,v3,int,7,v4)

#define c2p_2(v1,v2,v3,v4) PPCLP5NR (ChunkyPPCBase, -90, struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,UBYTE *,5,v2,UBYTE *,6,v3,int,7,v4)

#define c2p_3(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR (ChunkyPPCBase, -96, struct Library *,3, ChunkyPPCBase,void *,4,v1,void *,5,v2,int,6,v3,int,7,v4,struct Soff *,8,v5,int,9,v6,int,10,v7)

#define c2p_4(v1,v2,v3,v4,v5,v6) PPCLP7NR (ChunkyPPCBase, -102, struct Library *,3,ChunkyPPCBase,void *,4,v1,UBYTE *,5,v2,UBYTE *,6,v3,struct Soff *,7,v4, struct Soff *,8,v5, struct Soff *,9,v6)

#define ChunkyNoffFastHT(v1,v2,v3,v4,v5,v6) PPCLP7NR(ChunkyPPCBase,-108,struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1, UBYTE *,5,v2,int,6,v3,int,7,v4,int,8,v5,int,9,v6)

#define ChunkyNoffFastestHT(v1,v2,v3,v4,v5,v6) PPCLP7NR(ChunkyPPCBase,-114,struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1, UBYTE *,5,v2,int,6,v3,int,7,v4,int,8,v5,int,9,v6)

#define ChunkyNoffNormalHT(v1,v2,v3,v4,v5,v6) PPCLP7NR(ChunkyPPCBase,-120,struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1, UBYTE *,5,v2,int,6,v3,int,7,v4,int,8,v5,int,9,v6)

#define ChunkyFastHT(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR(ChunkyPPCBase,-126,struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,UBYTE *,5,v2,struct Soff *,6,v3,int,7,v4,int,8,v5,int,9,v6,int,10,v7)

#define ChunkyFastestHT(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR(ChunkyPPCBase,-132,struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,UBYTE *,5,v2,struct Soff *,6,v3,int,7,v4,int,8,v5,int,9,v6,int,10,v7)

#define ChunkyNormalHT(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR(ChunkyPPCBase,-138,struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,UBYTE *,5,v2,struct Soff *,6,v3,int,7,v4,int,8,v5,int,9,v6,int,10,v7)

#define ChunkyFastFullHT(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR(ChunkyPPCBase,-144,struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,UBYTE *,5,v2,struct Soff *,6,v3,struct Soff *,7,v4,struct Soff *,8,v5,struct Soff *,9,v6,int,10,v7)

#define ChunkyFastestFullHT(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR(ChunkyPPCBase,-150,struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,UBYTE *,5,v2,struct Soff *,6,v3,struct Soff *,7,v4,struct Soff *,8,v5,struct Soff *,9,v6,int,10,v7)

#define ChunkyNormalFullHT(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR(ChunkyPPCBase,-156,struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,UBYTE *,5,v2,struct Soff *,6,v3,struct Soff *,7,v4,struct Soff *,8,v5,struct Soff *,9,v6,int,10,v7)

#define ChunkyNoffMask(v1,v2,v3,v4,v5,v6) PPCLP7NR(ChunkyPPCBase,-162,struct Library *,3,ChunkyPPCBase,struct Buffers *,4,v1,UBYTE *,5,v2,int,6,v3,int,7,v4,int,8,v5,int,9,v6)

#define ChunkyMask(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR(ChunkyPPCBase,-168,struct Library *,3,ChunkyPPCBase,struct Buffers *,4,v1,UBYTE *,5,v2,struct Soff *,6,v3,int,7,v4,int,8,v5,int,9,v6,int,10,v7)

#define ChunkyMaskFull(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR(ChunkyPPCBase,-174,struct Library *,3,ChunkyPPCBase,struct Buffers *,4,v1,UBYTE *,5,v2,struct Soff *,6,v3,struct Soff *,7,v4,struct Soff *,8,v5,struct Soff *,9,v6,int,10,v7)

#define c2p_HI(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR(ChunkyPPCBase,-180, struct Library *,3,ChunkyPPCBase,UBYTE *,4,v1,int,5,v2,UBYTE *,6,v3,UBYTE *,7,v4,UBYTE *,8,v5,UBYTE *,9,v6,UBYTE *,10,v7)

#define ham_c2p(v1,v2,v3,v4,v5,v6,v7) PPCLP8NR(ChunkyPPCBase,-186, struct Library *,3,ChunkyPPCBase,unsigned char *,4,v1,unsigned char *,5,v2,int,6,v3,int,7,v4,int,8,v5,int,9,v6,int,10,v7)

#define ChunkyInit(v1,v2) PPCLP3(ChunkyPPCBase,-192,int,struct Library *,3,ChunkyPPCBase,struct Mode_Screen *,4,v1,int,5,v2)

#define CallChunkyCopy(ms,dest,src,srcformat,hook68k,data) PPCLP6(&((struct Mode_Screen *)ms)->algo,-2,void *,struct Mode_Screen *,3,ms,unsigned char *,4,dest,\
                                                                    unsigned char *,5,src,int,6,srcformat,void *,7,hook68k,unsigned char *,8,data)
#endif

#endif
