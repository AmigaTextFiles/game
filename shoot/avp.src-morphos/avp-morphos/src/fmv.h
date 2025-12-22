#ifndef FMV_H
#define FMV_H

#include "bink.h"

typedef struct
{
	IMAGEHEADER *ImagePtr;
	int SoundVolume;
	int IsTriggeredPlotFMV;
	int StaticImageDrawn;

	int MessageNumber;

	// disabled direct3d stuff
	//LPDIRECTDRAWSURFACE SrcSurface;
	//LPDIRECT3DTEXTURE SrcTexture;
	//LPDIRECT3DTEXTURE DestTexture;
	PALETTEENTRY SrcPalette[256];
	
	FMVHandle SmackHandle;
	
	// buffer used for opengl texture uploads
	unsigned char* PalettedBuf;
	unsigned char* RGBBuf;
	
	int RedScale;
	int GreenScale;
	int BlueScale;

} FMVTEXTURE;


extern int NextFMVTextureFrame(FMVTEXTURE *ftPtr, void *bufferPtr);
extern void UpdateFMVTexturePalette(FMVTEXTURE *ftPtr);
extern void InitialiseTriggeredFMVs(void);
extern void StartTriggerPlotFMV(int number);

extern void StartFMVAtFrame(int number, int frame);
extern void GetFMVInformation(int *messageNumberPtr, int *frameNumberPtr);

void UpdateAllFMVTextures(void);
void ScanImagesForFMVs(void);
void ReleaseAllFMVTextures(void);

#endif
