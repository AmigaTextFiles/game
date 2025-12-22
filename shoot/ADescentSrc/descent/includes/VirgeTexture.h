#ifdef VIRGIN
#ifndef VIRGE_TEXTURE_H
#define VIRGE_TEXTURE_H

#include <exec/types.h>
#include <cybergraphics/cgx3dvirgin.h>
#include "gr.h"
#include "texmap.h"

extern void (*PolygonRenderer)(g3ds_tmap *tmap, const APTR texture);

#define RenderTmap(tmap, texture) (*PolygonRenderer)((tmap),(texture))

void VirgeSetMapper(int i);                 // Sets the polygon mapper

void MakeBitValues(void);                   // From palette.c: Make lookup table

void VirgeClearBuffer(void);                // Clears the current drawing page
void *VirgeFindTexture(grs_bitmap *);       // Find or load a texture
void VirgeInvalidCacheEntry(grs_bitmap *);  // Invalidate the cache entry
void VirgeClearCache(void);                 // Clear the texture cache
void VirgeBilinearOn(void);
void VirgeBilinearOff(void);
void VirgeToggleBilinear(void);             // Toggles filtering
void *VirgeGetBuffer(void);                 // Return address of render buffer
void VirgeSwitchBuffer(void);               // Switch visible and drawing buffers
void VirgeSwitchBufferWait(void);           // Switch and limit frame rate
void VirgeSetupBuffers(void);               // Set up variables for double buffering
void VirgeDrawPoly(VertexV3Dtex **, int, APTR);
											// Draw a textures shaded polygon
void VirgePrintTextureStatistics(void);     // Print texture statistcs
void VirgeDrawLine2D(int, int, int, int);   // Draw a 2D line in the current color
void *VirgeFirstBuffer(void);               // Return address of first buffer and make visible
void VirgeSetFPSLimit(int);                 // Sets the maximum FPS number

#endif /* VIRGE_TEXUTRE_H */
#endif /* VIRGIN */
