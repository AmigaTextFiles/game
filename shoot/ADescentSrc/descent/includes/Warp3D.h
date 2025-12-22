/*
 * $Source: /usr/CVS/descent/includes/Warp3D.h,v $
 * $Author: nobody $
 * $Date: 1998/11/09 22:20:21 $
 * $Revision: 1.2 $
 *
 * Warp3D stuff for Descent
 *
 * $Log: Warp3D.h,v $
 * Revision 1.2  1998/11/09 22:20:21  nobody
 * *** empty log message ***
 *
 * Revision 1.1  1998/09/26 15:15:10  nobody
 * Initial version
 *
 *
 *
 */

#ifndef _DESCENT_WARP3D_H
#define _DESCENT_WARP3D_H

#include <Warp3D/Warp3D.h>
#include <intuition/intuition.h>

#define VirgePixelsPerRow       WARP_PixelsPerRow
#define VirgeBytesPerRow        WARP_BytesPerRow
#define VirgeGetBuffer          WARP_GetBufferAddress

void *WARP_GetBufferAddress(void);
void WARP_UpdateTextureCache(void);
void WARP_UpdateState(void);
void WARP_UpdateFog(void);
void WARP_DeleteTextureCache(void);
void WARP_InitTextureCache(void);
void WARP_draw_reticle(void);
void WARP_UpdateHints(void);
W3D_Float WARP_AddLight(W3D_Float , int);


extern ULONG WARP_PixelsPerRow;
extern ULONG WARP_BytesPerRow;
extern ULONG WARP_Buffers[];
extern ULONG WARP_Buffer;
extern UWORD BitValues[];
extern struct Window *WARP_Window;
extern W3D_Texture *WARP_Trans;
extern W3D_Texture *WARP_White;
extern int WARP_FilterMode;
extern int WARP_TMap;
extern int WARP_MipMap;
extern int WARP_Persp;
extern int WARP_TMapSub;
extern int WARP_FogSub;
extern int WARP_Fog;
extern int WARP_wreticle;
extern int WARP_Modulate;
extern W3D_Float WARP_MFactor;
extern W3D_Fog WARP_FogParam;
extern int WARP_Filter;
extern int WARP_Depth;

extern int WARP_HTMap;
extern int WARP_HMMap;
extern int WARP_HBif;
extern int WARP_HDf;
extern int WARP_HPers;
extern int WARP_HBlend;
extern int WARP_HFog;
extern int WARP_HAnti;
extern int WARP_HDith;


#define WARP_GetBufferAddress() (void *)(WARP_Buffers[1-WARP_Buffer])


#endif
