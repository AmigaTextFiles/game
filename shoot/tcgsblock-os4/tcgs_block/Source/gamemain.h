/* ---------------------------------------------------------- */
/*  gamemain.h                                                */
/* ---------------------------------------------------------- */

/*--------------------------------------------------------*/
/*                                                        */
/* TCGS - BLOCK for PSP                                   */
/*                        Fumi2Kick                       */
/*                        1st Maintaner  rerofumi.        */
/*                                                        */
/*   gamemain.h                                           */
/*     ゲームの本体フロー                                 */
/*                                                        */
/*--------------------------------------------------------*/

#ifndef GAMEMAIN_H
#define GAMEMAIN_H

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include "SDL.h"
#include "grp_screen.h"
#include "block_game.h"

/*-------------------------------*/
/* define                        */
/*-------------------------------*/

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

/* --- 最大ステージ数 */
#define  MAX_STAGE  10



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
/* struct                        */
/*-------------------------------*/

typedef struct {
  int  titletimer;
  SDL_Surface  *tex;
  TGameScreen  *screen;
  int  step;

  /* ----- ここから下は各ゲーム専用のワークとして使ってください */

  /* --- ブロックゲーム本体のインスタンス */
  TBlockGame *game;

  /* --- 現在のステージ */
  int  stage;

  /* --- プレイヤーのスコア */
  int  score;

  /* --- ハイスコアランキング */
  int  hi_score[5];

  /* --- 背景テクスチャのファイル名 */
  char graphic_file[MAX_STAGE][256];

} TGameMain, *PTGameMain;

/* ---------------------------------------------- */
/* --- extern                                  -- */
/* ---------------------------------------------- */

TGameMain *TGameMain_Create(TGameScreen *mainscreen);
void TGameMain_Destroy(TGameMain *class);

int TGameMain_Poll(TGameMain *class,
		   int  counter);


#endif //GAMEMAIN_H
