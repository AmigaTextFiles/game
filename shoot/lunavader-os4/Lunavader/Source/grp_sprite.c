/* ---------------------------------------------------------- */
/*  grp_sptite.c                                              */
/* ---------------------------------------------------------- */

/*--------------------------------------------------------*/
/*                                                        */
/* SDL puzzle project - for COMIKET62                     */
/*                        Fumi2Kick/LiMo/omamori-2002     */
/*                        1st Maintaner  Rerorero@fumi.   */
/*                                                        */
/*   grp_sprite.c                                         */
/*     スプライト管理構造体                               */
/*                                                        */
/*--------------------------------------------------------*/

/*------------------------------------------------------------- */
/** @file
    @brief		スプライト管理
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

#include "SDL.h"
#include "grp_sprite.h"


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
TGameSprite *TGameSprite_Create(void)
{
  TGameSprite *pclass;

  pclass = malloc(sizeof(TGameSprite));
  if (pclass == NULL) {
    return(0);
  }
  pclass->Texture = NULL;
  pclass->TextureId = -1;
  pclass->DispSw = FALSE;
  pclass->zoomx = 1.0;
  pclass->zoomy = 1.0;
  pclass->rotation_z = 0.0;

  return(pclass);
}


void TGameSprite_Destroy(TGameSprite *pclass)
{
  if (pclass) {
    free(pclass);
  }
}


/* ---------------------------------------- */
/* --- テクスチャーの登録                   */
/* ---------------------------------------- */
void TGameSprite_SetTextureDirect(TGameSprite *pclass,
				  int  texture_id,
				  SDL_Surface *bitmap)
{
  if (pclass == NULL) return;
  pclass->TextureId = texture_id;
  pclass->Texture = bitmap;
}
