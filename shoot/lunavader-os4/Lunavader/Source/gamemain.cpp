/* ---------------------------------------------------------- */
/*  gamemain.c                                                */
/* ---------------------------------------------------------- */

/*--------------------------------------------------------*/
/*                                                        */
/* Toho ShienSo for PSP                                   */
/*                        Fumi2Kick                       */
/*                        1st Maintaner  rerofumi.        */
/*                                                        */
/*   gamemain.c                                           */
/*     ゲーム本体のメインフロー                           */
/*                                                        */
/*--------------------------------------------------------*/

/*------------------------------------------------------------- */
/** @file
    @brief		ゲーム本体ステップ
    @author		K.Kunikane (rerofumi)
    @since		Nov.15.2005
*/
/*-----------------------------------------------------
 Copyright (C) 2002,2005 rerofumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include <stdlib.h>
#include <math.h>

#include "gamemain.h"
#include "input.h"
#include "sound.h"
#include "debug.h"


/* --- ゲームステップのラベル */
enum {
  StartUp,
  TitleInit,
  TitleMain,
  TitleAdvertise,
  GameInit,
  GameStageSet,
  GameMain,
  GameEndingInit,
  GameEnding,
  GameOver,
} MainStep;



/*-------------------------------*/
/* local value                   */
/*-------------------------------*/

/* --- ゲーム処理クラス */
BasicSystem  *luna_system;
GameDirector  *lunavader_main;

/*-------------------------------*/
/* local function                */
/*-------------------------------*/

/* -------------------------------------------------------------- */
/* --- ゲームメインステップ                                       */
/* -------------------------------------------------------------- */

/* ---------------------------------------- */
/* --- コンストラクタ・デストラクタ         */
TGameMain *TGameMain_Create(TGameScreen *mainscreen)
{
  TGameMain *pclass;

  pclass = (TGameMain *)malloc(sizeof(TGameMain));
  if (pclass == NULL) return(0);

  pclass->screen = mainscreen;
  pclass->step = StartUp;

  /* --- ゲームクラス初期化 */
  luna_system = new BasicSystem;
  luna_system->screen = mainscreen;
  luna_system->Init();
  lunavader_main = new GameDirector;
  lunavader_main->SetBasicSystem(luna_system);
  lunavader_main->Init();

  return(pclass);
}

void TGameMain_Destroy(TGameMain *pclass)
{
  if (pclass == NULL) return;

  /* - 何かありましたら */
  luna_system->Release();
  delete lunavader_main;
  delete luna_system;

  /* --- インスタンスの解放 */
  free(pclass);
}


/* ---------------------------------------- */
/* --- ゲームメイン                         */
/* ---------------------------------------- */
int TGameMain_Poll(TGameMain *pclass,
		    int counter)
{
  TGameSprite  *obj;
  int skip;

  if (pclass == NULL) return(FALSE);
  skip = TRUE;

  /* -------------------------------- */
  /* --- ゲームメインステップ */
  luna_system->Tick();
  if (lunavader_main->Tick() == false) {
    skip = FALSE;
  }
  luna_system->DisplayUpdate();

  /* --- 額縁表示 */
  obj = TGameScreen_GetSpriteSerial(pclass->screen);
  obj->Texture = TGameScreen_GetTexture(pclass->screen, 1);
  obj->DispSw = TRUE;
  obj->x = 0;
  obj->y = 0;
  obj->w = 480;
  obj->h = 272;
  obj->tx = 0;
  obj->ty = 0;
  obj->alpha = 255;
  obj->zoomx = 1.0;
  obj->zoomy = 1.0;
  obj->rotation_z = 0.0;

  return(skip);
}


/* -------------------------------------------------- */
/*  local routine                                     */
/* -------------------------------------------------- */


