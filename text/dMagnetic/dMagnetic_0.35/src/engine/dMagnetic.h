/*

Copyright 2023, dettus@dettus.net

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this 
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, 
   this list of conditions and the following disclaimer in the documentation 
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE 
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/
#ifndef DMAGNETIC_H
#define	DMAGNETIC_H
#include "picture.h"


#define	DMAGNETIC_OK	0
#define	DMAGNETIC_OK_QUIT	28844
#define	DMAGNETIC_OK_RESTART	28816
#define	DMAGNETIC_NOK_UNKNOWN_INSTRUCTION	1
#define	DMAGNETIC_NOK_INVALID_PTR		-1
#define	DMAGNETIC_NOK_INVALID_PARAM		-2


// 
int dMagnetic_getsize(int* bytes,int alignment);
int dMagnetic_init(void* pHandle,int alignment,void* pMagBuf,int magsize,void* pGfxBuf,int gfxsize);
int dMagnetic_getGameVersion(void* pHandle,int* version);
int dMagnetic_run(void* pHandle);
int dMagnetic_getVM(void* pHandle,void** pVM,int* vmsize);
int dMagnetic_getVMstate(void* pHandle,unsigned int* aregs,unsigned int* dregs,unsigned int* pcr,unsigned int* sr,unsigned short* lastOpcode);



// config calls
int dMagnetic_configrandom(void* pHandle,char random_mode,unsigned int random_seed);
int dMagnetic_setEGAMode(void* pHandle,int egamode);
int dMagnetic_dumppics(void* pHandle);


// callback pointers.
typedef int (*cbLineAOutputChar)(void* context,char c,unsigned char controlD2,unsigned char flag_headline);
typedef int (*cbLineAOutputString)(void* context,char* string,unsigned char controlD2,unsigned char flag_headline);
typedef int (*cbLineAInputString)(void* context,int* len,char* string);
typedef int (*cbLineADrawPicture)(void* context,tPicture* picture,int mode);
typedef int (*cbLineAReportPicture)(void* context,char* filename,int mode);
typedef int (*cbLineASaveGame)(void* context,char* filename,void* ptr,int len);
typedef int (*cbLineALoadGame)(void* context,char* filename,void* ptr,int len);

int dMagnetic_setCBoutputChar(void* pHandle,cbLineAOutputChar pCB,void *context);
int dMagnetic_setCBoutputString(void* pHandle,cbLineAOutputString pCB,void* context);
int dMagnetic_setCBinputString(void* pHandle,cbLineAInputString pCB,void* context);
int dMagnetic_setCBDrawPicture(void* pHandle,cbLineADrawPicture pCB,void* context);
int dMagnetic_setCBReportPicture(void* pHandle,cbLineAReportPicture pCB,void* context);
int dMagnetic_setCBSaveGame(void* pHandle,cbLineASaveGame pCB,void* context);
int dMagnetic_setCBLoadGame(void* pHandle,cbLineALoadGame pCB,void* context);


#endif
