/* ---------------------------------------------------------- */
/*  gamemain.c                                                */
/* ---------------------------------------------------------- */

/*--------------------------------------------------------*/
/*                                                        */
/* TCGS - BLOCK for PSP                                   */
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

/*-------------------------------*/
/* local value                   */
/*-------------------------------*/

/* --- ブロック形状データのファイル名 */
char *block_file[MAX_STAGE] = {
#ifdef __AMIGA__
  "data/block_01.dat",
  "data/block_02.dat",
  "data/block_03.dat",
  "data/block_04.dat",
  "data/block_05.dat",
  "data/block_06.dat",
  "data/block_07.dat",
  "data/block_08.dat",
  "data/block_09.dat",
  "data/block_10.dat",
#else
  "block_01.dat",
  "block_02.dat",
  "block_03.dat",
  "block_04.dat",
  "block_05.dat",
  "block_06.dat",
  "block_07.dat",
  "block_08.dat",
  "block_09.dat",
  "block_10.dat",
#endif
};

/* --- ステージ難易度 */
int ball_speed[MAX_STAGE] = {
  2048, 2048, 2700, 2700, 3400, 
  3400, 4100, 4100, 4400, 4700, 
};
int ball_speed_max[MAX_STAGE] = {
  4096, 4500, 4500, 5000, 5000,
  6000, 6000, 6500, 6500, 7000,
};

/*-------------------------------*/
/* local function                */
/*-------------------------------*/

void  disp_title(TGameMain *class);
void  disp_high_score(TGameMain *class);
void  disp_erase_title(TGameMain *class);
void  read_stage_graphic(TGameMain *class);
void  disp_ending(TGameMain *class);
void  read_hiscore(TGameMain *class);
void  write_hiscore(TGameMain *class);

/* -------------------------------------------------------------- */
/* --- ゲームメインステップ                                       */
/* -------------------------------------------------------------- */

/* ---------------------------------------- */
/* --- コンストラクタ・デストラクタ         */
TGameMain *TGameMain_Create(TGameScreen *mainscreen)
{
  TGameMain *class;

  class = malloc(sizeof(TGameMain));
  if (class == NULL) return(0);

  class->screen = mainscreen;
  class->step = StartUp;
  class->game = 0;
  class->hi_score[0] = 0;
  class->hi_score[1] = 0;
  class->hi_score[2] = 0;
  class->hi_score[3] = 0;
  class->hi_score[4] = 0;

  /* --- ステージグラフィックのファイル名取得 */
  read_stage_graphic(class);

  /* --- ハイスコアデータの読み込み */
  read_hiscore(class);

  return(class);
}

void TGameMain_Destroy(TGameMain *class)
{
  if (class == NULL) return;

  /* - 何かありましたら */
  if (class->game != 0) {
    TBlockGame_Destroy(class->game);
  }

  /* --- インスタンスの解放 */
  free(class);
}


/* ---------------------------------------- */
/* --- ゲームメイン                         */
/* ---------------------------------------- */
int TGameMain_Poll(TGameMain *class,
		    int counter)
{
  int  skip, reason;
  int  i, j;

  if (class == NULL) return(FALSE);

  skip = TRUE;

  /* -------------------------------- */
  /* --- ゲームメインステップ */
  switch(class->step) {

    /* -- タイトル初期化 */
  case StartUp:
#ifdef __AMIGA__
    TGameScreen_LoadTexturePure(class->screen, 0, "data/parts00.png");
#else
    TGameScreen_LoadTexturePure(class->screen, 0, "parts00.png");
#endif
    class->step = TitleInit;
    break;

  case TitleInit:
#ifdef __AMIGA__
    TGameScreen_LoadTexture(class->screen, 1, "data/title01.png");
#else
    TGameScreen_LoadTexture(class->screen, 1, "title01.png");
#endif
    class->titletimer = 0;
    class->step = TitleMain;
    break;

  case TitleMain:
    class->titletimer += 1;
    disp_title(class);
    disp_high_score(class);
    if ((InputJoyKeyTriger(0) & (IN_Button1|IN_Button2|IN_Button3|IN_Button4)) != 0) {
      SoundSE(6);
      class->titletimer = 0;
      class->step = TitleAdvertise;
    }
    break;

  case TitleAdvertise:
    class->titletimer += 4;
    disp_title(class);
    disp_high_score(class);
    if (class->titletimer >(60*4)) {
      disp_erase_title(class);
      class->step = GameInit;
    }
    break;

    /* -- ゲームスタート時の初期化 */
  case GameInit:
    class->game = TBlockGame_Create(class->screen);
    if (class->game == 0) {
      class->step = TitleInit;
      break;
    }
    TBlockGame_Init(class->game);
    class->stage = 1;
    class->score = 0;
    class->step = GameStageSet;
    break;

    /* -- ステージ開始時の初期化 */
  case GameStageSet:
    TBlockGame_StageStart(class->game,
			  block_file[class->stage - 1],
			  class->graphic_file[class->stage -1],
			  ball_speed[class->stage -1],
			  ball_speed_max[class->stage -1],
			  class->stage);
    TBlockGame_SetScore(class->game, class->score);
    class->step = GameMain;
    break;

    /* -- ブロックゲームメインワーク */
  case GameMain:
    reason = TBlockGame_Poll(class->game);
    /* - 終了か */
    switch(reason) {
    case REASON_CLEAR:
      class->score = TBlockGame_GetScore(class->game);
      if (class->stage < 10) {
	class->stage += 1;
	class->step = GameStageSet;
      }
      else {
	class->step = GameEndingInit;
      }
      break;

    case REASON_GAMEOVER:
      class->score = TBlockGame_GetScore(class->game);
      class->step = GameOver;
      break;
    }
    break;

  case GameEndingInit:
#ifdef __AMIGA__
    TGameScreen_LoadTexturePure(class->screen, 1, "ending01.png");
#else
    TGameScreen_LoadTexturePure(class->screen, 1, "ending01.png");
#endif
    class->titletimer = 0;
    class->step = GameEnding;
    disp_erase_title(class);
    disp_ending(class);
    SoundMusicOneshot(11);
    break;

  case GameEnding:
    disp_ending(class);
    class->titletimer += 1;
    if (class->titletimer >= 1000) {
      class->titletimer = 0;
      class->step = GameOver;
    }
    break;

  case GameOver:
    /* --- high score regist */
    for(i=0; i<5; i++) {
      if (class->hi_score[i] <= class->score) {
	for(j=4; j>i; j--) {
	  class->hi_score[j] = class->hi_score[j-1];
	}
	class->hi_score[i] = class->score;
	break;
      }
    }
    write_hiscore(class);
    disp_erase_title(class);
    class->step = TitleInit;
    break;

  }

  return(skip);
}


/* ---------------------------------------- */
/* --- エンディング画面                   */
/* ---------------------------------------- */
void  disp_ending(TGameMain *class)
{
  TGameSprite  *spr;

  /* --- background */
  spr = TGameScreen_GetSprite(class->screen, 0);
  spr->DispSw = TRUE;
  spr->x = 0;
  spr->y = 0;
  spr->w = 480;
  spr->h = 272;
  spr->tx = 512-480;
  spr->ty = 0;
  spr->TextureId = 1;
  spr->Texture = TGameScreen_GetTexture(class->screen, 1);
  spr->alpha = 255;

  /* --- credit */
  spr = TGameScreen_GetSprite(class->screen, 1);
  spr->DispSw = TRUE;
  spr->x = class->titletimer - 440;
  spr->y = 16;
  spr->w = 420;
  spr->h = 240;
  spr->tx = 92;
  spr->ty = 272;
  spr->TextureId = 1;
  spr->Texture = TGameScreen_GetTexture(class->screen, 1);
  spr->alpha = 255;

  /* --- thankyou */
  spr = TGameScreen_GetSprite(class->screen, 2);
  spr->DispSw = TRUE;
  if (class->titletimer < (480 + 200)) {
    spr->x = class->titletimer - 480;
  }
  else {
    spr->x = 200;
  }
  spr->y = 16;
  spr->w = 30;
  spr->h = 240;
  spr->tx = 32;
  spr->ty = 272;
  spr->TextureId = 1;
  spr->Texture = TGameScreen_GetTexture(class->screen, 1);
  spr->alpha = 255;

}

/* ---------------------------------------- */
/* --- タイトル画面                       */
/* ---------------------------------------- */
void  disp_title(TGameMain *class)
{
  TGameSprite  *spr;

  /* --- background */
  spr = TGameScreen_GetSprite(class->screen, 0);
  spr->DispSw = TRUE;
  spr->x = 0;
  spr->y = 0;
  spr->w = 480;
  spr->h = 272;
  spr->tx = 512-480;
  spr->ty = 0;
  spr->TextureId = 1;
  spr->Texture = TGameScreen_GetTexture(class->screen, 1);
  spr->alpha = 255;

  /* --- title */
  spr = TGameScreen_GetSprite(class->screen, 1);
  spr->DispSw = TRUE;
  spr->x = 320;
  spr->y = (272 - 192) / 2;
  spr->w = 76;
  spr->h = 192;
  spr->tx = 228;
  spr->ty = 256;
  spr->TextureId = 0;
  spr->Texture = TGameScreen_GetTexture(class->screen, 0);
  spr->alpha = 255;

  /* --- push start */
  spr = TGameScreen_GetSprite(class->screen, 2);
  if (((class->titletimer / 30) % 2) == 0) {
    spr->DispSw = TRUE;
    spr->x = 64;
    spr->y = (272 - 185) / 2;
    spr->w = 16;
    spr->h = 185;
    spr->tx = 208;
    spr->ty = 256;
    spr->TextureId = 0;
    spr->Texture = TGameScreen_GetTexture(class->screen, 0);
    spr->alpha = 255;
  }
  else {
    spr->DispSw = FALSE;
  }
}

void  disp_erase_title(TGameMain *class)
{
  int i;
  TGameSprite  *spr;

  for(i=0; i<SPRITEMAX; i++) {
    spr = TGameScreen_GetSprite(class->screen, i);
    spr->DispSw = FALSE;
  }
}


void  disp_score_num(TGameMain *class, int x, int y, int n, int o, int score)
{
  TGameSprite  *spr;
  int  i, j;
  int  c;
  int  top;
  int num;

  /* x, y : 表示位置 */
  /* n : 表示文字数 */
  /* o : Obj番号 */
  /* num : 表示する数字 */
  num = score;
  /* --- 数値を表示する */
  top = FALSE;
  j = 1;
  for(i=0; i<n; i++) {
    j = j * 10;
  }
  if (num >= j) num = j - 1;
  for(i=0; i<n; i++) {
    spr = TGameScreen_GetSprite(class->screen, SPRITE_SCORE+o);
    c = num / (j / 10);
    num = num % (j / 10);
    if (c > 9) c = 9;
    if (i == (n - 1)) top = FALSE;
    /* -- 表示 */
    if ((c == 0) && (top == TRUE)) {
      spr->DispSw = FALSE;
    }
    else {
      top = FALSE;
      spr->DispSw = TRUE;
      spr->x = x;
      spr->y = y;
      spr->w = 16;
      spr->h = 14;
      spr->tx = 464;
      spr->ty = 256 + (c * 16);
      spr->TextureId = 0;
      spr->Texture = TGameScreen_GetTexture(class->screen, 0);
      spr->alpha = 255;
    }
    y = y + 14;
    o = o + 1;
    j = j / 10;
  }
}

void  disp_high_score(TGameMain *class)
{
  TGameSprite  *spr;
  int x, y;
  int obj;
  int  i;

  /* --- "HI-SCORE" の表示 */
  spr = TGameScreen_GetSprite(class->screen, SPRITE_SCORE);
  spr->DispSw = TRUE;
  spr->x = 240 + 32;
  spr->y = 96;
  spr->w = 16;
  spr->h = 80;
  spr->tx = 448;
  spr->ty = 320;
  spr->TextureId = 0;
  spr->Texture = TGameScreen_GetTexture(class->screen, 0);
  spr->alpha = 255;

  /* --- score rank */
  obj = 10;
  x = 240;
  y = 96 - 32;
  for(i=0; i<5; i++) {
    /* - index */
    spr = TGameScreen_GetSprite(class->screen, obj);
    spr->DispSw = TRUE;
    spr->x = x;
    spr->y = y;
    spr->w = 16;
    spr->h = 32;
    spr->tx = 432;
    spr->ty = 304 + (i*32);
    spr->TextureId = 0;
    spr->Texture = TGameScreen_GetTexture(class->screen, 0);
    spr->alpha = 255;
    obj += 1;
    /* - score */
    disp_score_num(class, x, y+32, 8, obj, class->hi_score[i]);
    obj += 8;
    x -= 24;
  }

}


/* ---------------------------------------- */
/* --- 背景画像ファイルリスト読み込み   */
/* ---------------------------------------- */
void  read_stage_graphic(TGameMain *class)
{
  FILE  *fp;
  char *result;
  int i, j;

  /* --- clear */
  for(i=0; i<10; i++) {
    class->graphic_file[i][0] = 0;
  }

  /* --- file read */
#ifdef __AMIGA__
  fp = fopen("data/stagepic.dat", "r");
#else
  fp = fopen("stagepic.dat", "r");
#endif
  if (fp == NULL) {
    /* error */
    printf("File not found - stagepic.dat\n");
    return;
  }

  for(i=0; i<10; i++) {
    result = fgets(class->graphic_file[i], 255, fp);
    if (result == NULL) {
      break;
    }
    /* -- 改行コード消し */
    for(j=0; j<256; j++) {
      if ((class->graphic_file[i][j] == '\n') ||
	  (class->graphic_file[i][j] == '\r') ||
	  (class->graphic_file[i][j] == '\a')) {
	class->graphic_file[i][j] = 0;
	break;
      } 
    }
  }

  /* --- おしまい */
  fclose(fp);
}


/* ---------------------------------------- */
/* --- ハイスコアデータファイル保存     */
/* ---------------------------------------- */
void  write_hiscore(TGameMain *class)
{
  FILE  *fp;
  int  i;

  /* --- file open */
#ifdef __AMIGA__
  fp = fopen("data/hiscore.dat", "w");
#else
  fp = fopen("hiscore.dat", "w");
#endif
  if (fp == NULL) {
    /* error */
    printf("File can't open - hiscore.dat\n");
    return;
  }

  /* --- write */
  for(i=0; i<5; i++) {
    fprintf(fp, "%d\n", class->hi_score[i]);
  }

  /* --- おしまい */
  fclose(fp);
}

/* ---------------------------------------- */
/* --- ハイスコアデータファイル読み出し */
/* ---------------------------------------- */
void  read_hiscore(TGameMain *class)
{
  FILE  *fp;
  int  i, num;

  /* --- file open */
#ifdef __AMIGA__
  fp = fopen("data/hiscore.dat", "r");
#else
  fp = fopen("hiscore.dat", "r");
#endif
  if (fp == NULL) {
    /* error */
    printf("File can't open - hiscore.dat\n");
    for(i=0; i<5; i++) {
      class->hi_score[i] = 0;
    }
    return;
  }

  /* --- write */
  for(i=0; i<5; i++) {
    fscanf(fp, "%d\n", &num);
    class->hi_score[i] = num;
  }

  /* --- おしまい */
  fclose(fp);
}


