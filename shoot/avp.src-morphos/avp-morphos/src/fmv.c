/* KJL 15:25:20 8/16/97
 *
 * smacker.c - functions to handle FMV playback
 *
 */
#include "3dc.h"
#include "module.h"
#include "inline.h"
#include "stratdef.h"
#include "gamedef.h"
#include "fmv.h"
#include "avp_menus.h"
#include "avp_userprofile.h"
#include "oglfunc.h" 

#define UseLocalAssert 1
#include "ourasert.h"

int VolumeOfNearestVideoScreen;
int PanningOfNearestVideoScreen;

extern char *ScreenBuffer;
extern int GotAnyKey;
extern void DirectReadKeyboard(void);
extern IMAGEHEADER ImageHeaderArray[];
#if MaxImageGroups>1
extern int NumImagesArray[];
#else
extern int NumImages;
#endif

FMVHandle currentTriggeredSmackHandle = 0;

void PlayFMV(char *filenamePtr);

int SmackerSoundVolume=ONE_FIXED/512;

int MoviesAreActive = 1;
int IntroOutroMoviesAreActive=1;

int FmvColourRed;
int FmvColourGreen;
int FmvColourBlue;

void ReleaseFMVTexture(FMVTEXTURE *ftPtr);
extern void UpdateOGLTexture(D3DTexture* tex, unsigned char* buf, GLuint format);


/* KJL 12:45:23 10/08/98 - FMVTEXTURE stuff */
#define MAX_NO_FMVTEXTURES 10
FMVTEXTURE FMVTexture[MAX_NO_FMVTEXTURES];
int NumberOfFMVTextures;

void ScanImagesForFMVs(void)
{
	
	extern void SetupFMVTexture(FMVTEXTURE *ftPtr);
	int i;
	IMAGEHEADER *ihPtr;
	NumberOfFMVTextures=0;

	#if MaxImageGroups>1
	for (j=0; j<MaxImageGroups; j++)
	{
		if (NumImagesArray[j])
		{
			ihPtr = &ImageHeaderArray[j*MaxImages];
			for (i = 0; i<NumImagesArray[j]; i++, ihPtr++)
			{
	#else
	{
		if(NumImages)
		{
			ihPtr = &ImageHeaderArray[0];
			for (i = 0; i<NumImages; i++, ihPtr++)
			{
	#endif
				char *strPtr;
				if((strPtr = strstr(ihPtr->ImageName,"FMVs")))
				{
					char filename[30];
					{
						char *filenamePtr = filename;
						do
						{
							*filenamePtr++ = *strPtr;
						}
						while(*strPtr++!='.');

						*filenamePtr++='s';
						*filenamePtr++='m';
						*filenamePtr++='k';
						*filenamePtr=0;
					} 
					
					FMVHandle smackHandle = 0;
					if(MoviesAreActive)
						smackHandle = CreateBinkFMV(filename);
		
					if(smackHandle)
					{
						FMVTexture[NumberOfFMVTextures].IsTriggeredPlotFMV = 0;
					}
					else
					{
						FMVTexture[NumberOfFMVTextures].IsTriggeredPlotFMV = 1;
					}

					FMVTexture[NumberOfFMVTextures].SmackHandle = smackHandle;
					FMVTexture[NumberOfFMVTextures].ImagePtr = ihPtr;
					FMVTexture[NumberOfFMVTextures].StaticImageDrawn=0;
					SetupFMVTexture(&FMVTexture[NumberOfFMVTextures]);
					NumberOfFMVTextures++;
					if (NumberOfFMVTextures == MAX_NO_FMVTEXTURES)
						break;
				}
			}		
		}
	}


}

void UpdateAllFMVTextures(void)
{	
	int volume = (int) (127.0f * (float)SmackerSoundVolume / (float)(ONE_FIXED/512));
	if(currentTriggeredSmackHandle)
	{
		if(!UpdateBinkFMV(currentTriggeredSmackHandle, volume))
		{
			CloseBinkFMV(currentTriggeredSmackHandle);
			currentTriggeredSmackHandle = 0;
		}
	}

	extern void UpdateFMVTexture(FMVTEXTURE *ftPtr);
	int i = NumberOfFMVTextures;
	while(i--)
	{
		if(FMVTexture[i].IsTriggeredPlotFMV)
			FMVTexture[i].SmackHandle = currentTriggeredSmackHandle;
		else if(FMVTexture[i].SmackHandle)
			UpdateBinkFMV(FMVTexture[i].SmackHandle, volume);
	
		UpdateFMVTexture(&FMVTexture[i]);
	}

}

void ReleaseAllFMVTextures(void)
{	
	if(currentTriggeredSmackHandle)
	{
		CloseBinkFMV(currentTriggeredSmackHandle);
		currentTriggeredSmackHandle = 0;
	}

	extern void UpdateFMVTexture(FMVTEXTURE *ftPtr);
	int i = NumberOfFMVTextures;
	while(i--)
	{
		if(!FMVTexture[i].IsTriggeredPlotFMV && FMVTexture[i].SmackHandle)
			CloseBinkFMV(FMVTexture[i].SmackHandle);

		FMVTexture[i].SmackHandle = 0;
		ReleaseFMVTexture(&FMVTexture[i]);
	}

}


int NextFMVTextureFrame(FMVTEXTURE *ftPtr, void *bufferPtr)
{
	int w = 128;

	if(!ftPtr->StaticImageDrawn)
	{
		int i = w*96/4;
		unsigned int seed = FastRandom();
		int *ptr = (int*)bufferPtr;
		do
		{
			seed = ((seed*1664525)+1013904223);
			*ptr++ = seed;
		}
		while(--i);
		ftPtr->StaticImageDrawn=1;
	}
	return 1;

}

void UpdateFMVTexturePalette(FMVTEXTURE *ftPtr)
{
	int i;
	unsigned int seed = FastRandom();
	for(i=0;i<256;i++)
	{   
		int l = (seed&(seed>>24)&(seed>>16));
		seed = ((seed*1664525)+1013904223);
		ftPtr->SrcPalette[i].peRed=l;
		ftPtr->SrcPalette[i].peGreen=l;
		ftPtr->SrcPalette[i].peBlue=l;
	}	
}

extern void StartTriggerPlotFMV(int number)
{
	if(CheatMode_Active != CHEATMODE_NONACTIVE)
		return;

	if(!MoviesAreActive)
		return;

	//printf("StartFMV %d\n", number);
	
	int i = NumberOfFMVTextures;
	char filename[25];
	sprintf(filename,"FMVs/message%d.smk",number);

	if(currentTriggeredSmackHandle)
		CloseBinkFMV(currentTriggeredSmackHandle);
	
	// todo: precache opening of all trigger-fmv's for the current level.
	currentTriggeredSmackHandle = CreateBinkFMV(filename);
	
	while(i--)
	{
		if (FMVTexture[i].IsTriggeredPlotFMV)
		{
			FMVTexture[i].SmackHandle = currentTriggeredSmackHandle;
			FMVTexture[i].MessageNumber = number;
		}
	}
}

extern void StartFMVAtFrame(int number, int frame)
{
	// used for loading a game which was saved in the middle of playing a triggered FMV.
	// we can ignore it, or just play the FMV from the beginning.
	//StartTriggerPlotFMV(number);
}

extern void GetFMVInformation(int *messageNumberPtr, int *frameNumberPtr)
{
	// used for saving a game while a triggered FMV is playing.
	/*
	int i = NumberOfFMVTextures;
	while(i--)
	{
		if (FMVTexture[i].IsTriggeredPlotFMV)
		{
			if(FMVTexture[i].SmackHandle)
			{
				*messageNumberPtr = FMVTexture[i].MessageNumber;
				*frameNumberPtr = 0;
				return;
			}
		}
	}
	*/
	*messageNumberPtr = 0;
	*frameNumberPtr = 0;
}


extern void InitialiseTriggeredFMVs(void)
{
	if(currentTriggeredSmackHandle)
		CloseBinkFMV(currentTriggeredSmackHandle);
	currentTriggeredSmackHandle = 0;
	
	int i = NumberOfFMVTextures;
	while(i--)
	{
		if (FMVTexture[i].IsTriggeredPlotFMV)
		{
			FMVTexture[i].MessageNumber = 0;
			FMVTexture[i].SmackHandle = 0;
		}
	}
}


void SetupFMVTexture(FMVTEXTURE *ftPtr)
{
	if (ftPtr->PalettedBuf == NULL)
	{
		ftPtr->PalettedBuf = (unsigned char*) malloc(128*128*4);
	}
	
	if (ftPtr->RGBBuf == NULL)
	{
		if (ftPtr->PalettedBuf == NULL)
		{
			return;
		}
		
		ftPtr->RGBBuf = &ftPtr->PalettedBuf[128*128];
	}
}


void UpdateFMVTexture(FMVTEXTURE *ftPtr)
{
	unsigned char *srcPtr;
	unsigned char *dstPtr = 0;
	
	int pixels = 128*96;//64*48;//256*192;
	
	BOOL drawStatic = TRUE;
	if(ftPtr->SmackHandle)
	{
		dstPtr = GetBinkFMVImage(ftPtr->SmackHandle);
		if(dstPtr)
		{  
			UpdateFMVTexturePalette(ftPtr);
			drawStatic = FALSE;
		}
	}


	if(drawStatic)
	{
		NextFMVTextureFrame(ftPtr, &ftPtr->PalettedBuf[0]);
		UpdateFMVTexturePalette(ftPtr);
	
		srcPtr = &ftPtr->PalettedBuf[0];
		dstPtr = &ftPtr->RGBBuf[0];
		
		// not using paletted textures, so convert to rgb manually
		do
		{
			unsigned char source = (*srcPtr++);
			dstPtr[0] = ftPtr->SrcPalette[source].peRed;
			dstPtr[1] = ftPtr->SrcPalette[source].peGreen;
			dstPtr[2] = ftPtr->SrcPalette[source].peBlue; 
			
			dstPtr += 3;
		} while(--pixels);

		dstPtr = &ftPtr->RGBBuf[0];
	}

	if(dstPtr)
	{
		UpdateOGLTexture(ftPtr->ImagePtr->D3DTexture, dstPtr, GL_RGB);
		
		unsigned int totalRed=0;
		unsigned int totalGreen=0;
		unsigned int totalBlue=0;
		int pixels = 128*96;
		unsigned char* bufferPtr = dstPtr;
		do
		{
			totalRed += *bufferPtr++;
			totalGreen += *bufferPtr++;
			totalBlue += *bufferPtr++;
		}
		while(--pixels); 
		FmvColourRed   = totalRed   / 48;		// (int) ((float)255 * (float)totalRed	 / (128.0f*96.0f));
		FmvColourGreen = totalGreen / 48;		// (int) ((float)255 * (float)totalGreen / (128.0f*96.0f));
		FmvColourBlue  = totalBlue  / 48;		// (int) ((float)255 * (float)totalBlue	 / (128.0f*96.0f));
	}
	
}

void ReleaseFMVTexture(FMVTEXTURE *ftPtr)
{
	ftPtr->MessageNumber = 0;

	//if (FMVTexture[i].SrcTexture)
	//{
	//	ReleaseD3DTexture(FMVTexture[i].SrcTexture);
	//	FMVTexture[i].SrcTexture=0;
	//}
	//if (FMVTexture[i].SrcSurface)
	//{
	//	ReleaseDDSurface(FMVTexture[i].SrcSurface);
	//	FMVTexture[i].SrcSurface=0;
	//}
	//if (FMVTexture[i].DestTexture)
	//{	
	//	ReleaseD3DTexture(FMVTexture[i].DestTexture);
	//	FMVTexture[i].DestTexture = 0;
	//}

	if (ftPtr->PalettedBuf != NULL)
	{
		free(ftPtr->PalettedBuf);
		ftPtr->PalettedBuf = NULL;
	}
	
	ftPtr->RGBBuf = NULL;
}
