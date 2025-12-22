/*
** Virge-Blit-Specific defines and functions
**
** $Id: virge.h,v 1.2 1998/04/09 17:14:33 hfrieden Exp $
** $Author: hfrieden $
** $Revision: 1.2 $
*/
#ifndef __VIRGE_H
#define __VIRGE_H

#include "fix.h"

#define VIRGE_CS_AUTOEXECUTE        1
#define VIRGE_CS_HWCLIP             (1 << 1)

	#define VIRGE_CS_PIXFMT_8       (0 << 2)
	#define VIRGE_CS_PIXFMT_16      (1 << 2)
	#define VIRGE_CS_PIXFMT_24      (2 << 2)

#define VIRGE_CS_DRAW               (1 << 5)
#define VIRGE_CS_MONOSOURCE         (1 << 6)
#define VIRGE_CS_SRCDATA_CPU        (1 << 7)
#define VIRGE_CS_MONOPATTERN        (1 << 8)
#define VIRGE_CS_TRANSPARENT        (1 << 9)

	#define VIRGE_CS_IMG_XFER_ALIGN_1   (0 << 10)
	#define VIRGE_CS_IMG_XFER_ALIGN_2   (1 << 10)
	#define VIRGE_CS_IMG_XFER_ALIGN_4   (2 << 10)

	#define VIRGE_CS_1ST_DWORD_OFF_1 (0 << 12)
	#define VIRGE_CS_1ST_DWORD_OFF_2 (1 << 12)
	#define VIRGE_CS_1ST_DWORD_OFF_3 (2 << 12)
	#define VIRGE_CS_1ST_DWORD_OFF_4 (3 << 12)

#define VIRGE_CS_X_POSITIVE         (1 << 25)
#define VIRGE_CS_Y_POSITIVE         (1 << 26)

	#define VIRGE_CS_COMMAND_BITBLT     (0 << 27)
	#define VIRGE_CS_COMMAND_RECTFILL   (2 << 27)
	#define VIRGE_CS_COMMAND_LINEDRAW   (3 << 27)
	#define VIRGE_CS_COMMAND_POLYFILL   (5 << 27)
	#define VIRGE_CS_COMMAND_NOP        (15 << 27)

#define VIRGE_CS_3D                 (1 << 31)

	// Additional CMD_SET register #defines for Triangle fill
	#define VIRGE_CS_TEXFMT_POS         5
	#define VIRGE_CS_TEXFMT_32          (0 << 5)
	#define VIRGE_CS_TEXFMT_16_4444     (1 << 5)
	#define VIRGE_CS_TEXFMT_16_1555     (2 << 5)
	#define VIRGE_CS_TEXFMT_8_B4A4      (3 << 5)
	#define VIRGE_CS_TEXFMT_4_B4LOW     (4 << 5)
	#define VIRGE_CS_TEXFMT_4_B4HIGH    (5 << 5)
	#define VIRGE_CS_TEXFMT_8_PAL       (6 << 5)
	#define VIRGE_CS_TEXFMT_16_YUYV     (7 << 5)

#define VIRGE_CS_MIPMAP_SIZE_POS        8
#define VIRGE_CS_MIPMAP_SIZE_MSK        (15 << 8)

	#define VIRGE_CS_TEXFILT_POS        12
	#define VIRGE_CS_TEXFILT_MSK        (7 << 12)
	#define VIRGE_CS_TEXFILT_M1TPP      (0 << 12)
	#define VIRGE_CS_TEXFILT_M2TPP      (1 << 12)
	#define VIRGE_CS_TEXFILT_M4TPP      (2 << 12)
	#define VIRGE_CS_TEXFILT_M8TPP      (3 << 12)
	#define VIRGE_CS_TEXFILT_1TPP       (4 << 12)
	#define VIRGE_CS_TEXFILT_V2TPP      (5 << 12)
	#define VIRGE_CS_TEXFILT_4TPP       (6 << 12)

	#define VIRGE_CS_BLEND_POS          15
	#define VIRGE_CS_BLEND_MSK          (3 << 15)
	#define VIRGE_CS_BLEND_COMPLEX      (0 << 15)
	#define VIRGE_CS_BLEND_MODULATE     (1 << 15)
	#define VIRGE_CS_BLEND_DECAL        (2 << 15)

#define VIRGE_CS_FOG                    (1 << 17)

#define VIRGE_CS_ALPHA                  (1 << 19)

	#define VIRGE_CS_ALPHA_TEX          (0 << 18)
	#define VIRGE_CS_ALPHA_SRC          (1 << 18)

	#define VIRGE_CS_ZB_NEVER           (0 << 20)
	#define VIRGE_CS_ZB_G               (1 << 20)
	#define VIRGE_CS_ZB_E               (2 << 20)
	#define VIRGE_CS_ZB_GE              (3 << 20)
	#define VIRGE_CS_ZB_L               (4 << 20)
	#define VIRGE_CS_ZB_NE              (5 << 20)
	#define VIRGE_CS_ZB_LE              (6 << 20)
	#define VIRGE_CS_ZB_ALWAYS          (7 << 20)

#define VIRGE_CS_ZB_UPDATE              (1 << 23)

	#define VIRGE_CS_ZB_NORMAL          (0 << 24)
	#define VIRGE_CS_ZB_MUX_ZB          (1 << 24)
	#define VIRGE_CS_ZB_MUX_DRAW        (2 << 24)

#define VIRGE_CS_TEXTURE_WRAP           (1 << 26)

	#define VIRGE_CS_CMD_GOUTRI         (0 << 27)
	#define VIRGE_CS_CMD_LITTEXTRI      (1 << 27)
	#define VIRGE_CS_CMD_UNLITTEXTRI    (2 << 27)
	#define VIRGE_CS_CMD_LITTEXTRI_P    (5 << 27)
	#define VIRGE_CS_CMD_UNLITTEXTRI_P  (6 << 27)
	#define VIRGE_CS_CMD_3DLINE         (8 << 27)
	#define VIRGE_CS_CMD_NOP            (15 << 27)

	// ROP's
#define VIRGE_ROP_PATCOPY     (0xCC << 17)
#define VIRGE_ROP_NOTDEST     (0x55 << 17)

#define TWO_E_20 (1024.0 * 1024.0)
#define TWO_E_19 (256.0 * 2048.0)

typedef  double             vfloat;
typedef  long               dword;
typedef  long               sdword;

typedef struct {
	vfloat x,y,z,r,g,b,u,v;
	vfloat iz;
} vVertex;

typedef struct {
	fix x,y,z,r,g,b,u,v;
} iVertex;

void VirgeTriangle (const APTR texture, vVertex *p1, vVertex *p2, vVertex *p3);
void VirgeTriangleI(const APTR texture, iVertex *p1, iVertex *p2, iVertex *p3);

#endif
