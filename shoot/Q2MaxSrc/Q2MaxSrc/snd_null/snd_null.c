/*
**  snd_null.c
**
**  null sound driver
**
**
*/


#include "../client/client.h"
#include "../client/snd_loc.h"
#include "../amiga/snddll.h"
#include "dll.h"


sndimport_t si;

void NULLSND_Shutdown(dma_t *dma)
{
}

qboolean NULLSND_Init(dma_t *dma)
{
    dma->buffer 	  = 0;
    dma->channels 	  = 0;
    dma->speed 		  = 0;
    dma->samplebits 	  = 0;
    dma->samples 	  = 0;
    dma->submission_chunk = 0;
    dma->samplepos 	  = 0;

    return false;
}

int NULLSND_GetDMAPos(dma_t *dma)
{
    return 0;
}

/* ========== EXPORTED FUNCTIONS ================================================ */

sndexport_t GetSndAPI(sndimport_t simp)
{
    sndexport_t se;

    si = simp;

    se.api_version      = SND_API_VERSION;
    se.Init             = NULLSND_Init;
    se.Shutdown         = NULLSND_Shutdown;
    se.GetDMAPos        = NULLSND_GetDMAPos;
    se.BeginPainting    = NULL;
    se.Submit           = NULL;

    return se;
}

void*  dllFindResource(int id, char *pType)
{
    return NULL;
}

void* dllLoadResource(void *pHandle)
{
    return NULL;
}

void dllFreeResource(void *pHandle)
{
    return;
}


dll_tExportSymbol DLL_ExportSymbols[] =
{
    {dllFindResource,"dllFindResource"},
    {dllLoadResource,"dllLoadResource"},
    {dllFreeResource,"dllFreeResource"},
    {GetSndAPI,"GetSndAPI"},
    {0,0},
};

dll_tImportSymbol DLL_ImportSymbols[] =
{
    {0,0,0,0}
};

int DLL_Init(void)
{
    return 1;
}

void DLL_DeInit(void)
{
}


