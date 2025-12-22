/* ---------------------------------------------------------- */
/*  grp_texture.c                                             */
/* ---------------------------------------------------------- */

/*--------------------------------------------------------*/
/*                                                        */
/* SDL puzzle project - for COMIKET62                     */
/*                        Fumi2Kick/LiMo/omamori-2002     */
/*                        1st Maintaner  Rerorero@fumi.   */
/*                                                        */
/*   grp_texture.c                                        */
/*     テクスチャー管理クラス                             */
/*                                                        */
/*--------------------------------------------------------*/

/*------------------------------------------------------------- */
/** @file
    @brief		テクスチャー管理
    @author		K.Kunikane (rerofumi)
    @since		Sep.19.2005
*/
/*-----------------------------------------------------
 Copyright (C) 2002,2005 rerofumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include <stdlib.h>
#include <string.h>
#ifdef __MACOSX__
#include <malloc/malloc.h>
#else
#include <malloc.h>
#endif

#include "SDL.h"
#include "grp_texture.h"

/*-------------------------------*/
/* local define                  */
/*-------------------------------*/

#if (SDL_BYTEORDER == SDL_BIG_ENDIAN)
 #define RMASK 0xff000000
 #define GMASK 0x00ff0000
 #define BMASK 0x0000ff00
 #define AMASK 0x000000ff
 #define RMASK16 0x0000f800
 #define GMASK16 0x000007c0
 #define BMASK16 0x0000003f
 #define AMASK16 0x00000001
#else
 #define RMASK 0x000000ff
 #define GMASK 0x0000ff00
 #define BMASK 0x00ff0000
 #define AMASK 0xff000000
 #define RMASK16 0x0000001f
 #define GMASK16 0x000003e0
 #define BMASK16 0x00007c00
 #define AMASK16 0x00008000
#endif

/*-------------------------------*/
/* local value                   */
/*-------------------------------*/

/*-------------------------------*/
/* local function                */
/*-------------------------------*/

/* -------------------------------------------------------------- */
/* --- テクスチャ管理クラス                                       */
/* -------------------------------------------------------------- */

/* ---------------------------------------- */
/* --- コンストラクタ・デストラクタ         */
TGameTexture *TGameTexture_Create(void)
{
  int  i;
  TGameTexture *pclass;

  pclass = malloc(sizeof(TGameTexture));
  if (pclass == NULL) {
    return(0);
  }
  for(i=0; i<TEXTUREMAX; i++) {
    pclass->texture_id = i;
    pclass->bitmap[i] = NULL;
  }

  return(pclass);
}

void TGameTexture_Destroy(TGameTexture *pclass)
{
  int  i;
  if (pclass == NULL) {
    return;
  }

  /* ----- ロード中のテクスチャを解放する */
  for(i=0; i<TEXTUREMAX; i++) {
    if (pclass->bitmap[i] != NULL) {
      SDL_FreeSurface(pclass->bitmap[i]);
      pclass->bitmap[i] = NULL;
    }
  }

  /* ----- インスタンスの解放 */
  free(pclass);
}


/* ---------------------------------------- */
/* --- テクスチャーの読み込み、登録         */
/* ---------------------------------------- */
void TGameTexture_Load(TGameTexture *pclass,
		       int num,
		       char *filename,
                       SDL_Surface *GameScreen,
                       int preconv)
{
  SDL_Surface  *plane, *standard;
  void *nonalign;
  int  msize, loop;
  unsigned short *pixdst;
  unsigned long  *pixsrc;

  standard = 0;
  nonalign = 0;
  msize = 0;
  loop = 0;
  pixdst = 0;
  pixsrc = 0;
  if (pclass == NULL) {\
    return;
  }

  /* ----- テクスチャ番号が不正だったら終了 */
  if (num < 0) return;
  if (num > TEXTUREMAX) return;

  /* ----- 既にテクスチャがあったら解放 */
  if (pclass->bitmap[num] != NULL) {
    SDL_FreeSurface(pclass->bitmap[num]);
    pclass->bitmap[num] = NULL;
  }

  /* ----- テクスチャーの読み込み */
  plane = IMG_Load(filename);
  if (plane == NULL) {
    pclass->bitmap[num] = NULL;
    return;
  }
#ifdef NOTPSP
  /* --- Normal SDL work for PC */
  if (preconv == TRUE) {
    pclass->bitmap[num] = SDL_ConvertSurface(plane,
					    GameScreen->format,
					    SDL_SWSURFACE|SDL_SRCALPHA);
    if ((plane != NULL) &&
	(plane != pclass->bitmap[num])) {
      SDL_FreeSurface(plane);
    }
  }
  else {
    pclass->bitmap[num] = plane;
  }
#else
  /* --- PSP 向けにテクスチャを加工する */

  /* --- PSP で変換要求があった場合は16bitに落とす */
  pclass->bitmap[num] = plane;

  /* --- PSPではDMA転送で 16byte align に無いと都合が悪いので変換  */
  nonalign = pclass->bitmap[num]->pixels;
  msize = (pclass->bitmap[num]->w * pclass->bitmap[num]->h) * pclass->bitmap[num]->format->BytesPerPixel;
  if ((preconv == TRUE) && (pclass->bitmap[num]->format->BytesPerPixel == 4)) {
    /* --- 16bit 減色して保持 */
    pclass->bitmap[num]->pixels = (void*)memalign(16, (msize / 2));
    msize = (pclass->bitmap[num]->w * pclass->bitmap[num]->h);
    pixdst = (unsigned short *)pclass->bitmap[num]->pixels;
    pixsrc = (unsigned long *)nonalign;
    for(loop=0; loop<msize; loop++) {
      *pixdst =
	(*pixsrc & 0x80000000) >> 16 |
	(*pixsrc & 0x00f80000) >> 9 |
	(*pixsrc & 0x0000f800) >> 6 |
	(*pixsrc & 0x000000f8) >> 3;
      pixdst++;
      pixsrc++;
    }
    pclass->bitmap[num]->format->BytesPerPixel = 2;
    pclass->bitmap[num]->format->BitsPerPixel = 16;
    pclass->bitmap[num]->format->Rmask = RMASK16;
    pclass->bitmap[num]->format->Gmask = GMASK16;
    pclass->bitmap[num]->format->Bmask = BMASK16;
    pclass->bitmap[num]->format->Amask = AMASK16;
  }
  else {
    /* --- 32bit 通常モード */
    pclass->bitmap[num]->pixels = (void*)memalign(16, msize);
    memcpy(pclass->bitmap[num]->pixels, nonalign, msize);
  }
  free(nonalign);

#endif
}


/* ---------------------------------------- */
/* --- テクスチャーの渡し                   */
/* ---------------------------------------- */
SDL_Surface  *TGameTexture_GetTexture(TGameTexture *pclass,
				      int index)
{

  if (pclass == NULL) {
    return(NULL);
  }
  return(pclass->bitmap[index]);
}
