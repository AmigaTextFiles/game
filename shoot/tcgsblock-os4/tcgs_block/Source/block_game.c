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

#include "sincos_table_int.h"

/*-------------------------------*/
/* local value                   */
/*-------------------------------*/


/*-------------------------------*/
/* local function                */
/*-------------------------------*/

void  build_display(TBlockGame *class);
void  build_display_clear(TBlockGame *class);
void  build_display_gameover(TBlockGame *class);
void  control_paddle(TBlockGame *class);
void  control_shoot(TBlockGame *class);
void  control_ball(TBlockGame *class);
void  control_ball_clear(TBlockGame *class);
void  control_point(TBlockGame *class);
void  control_point_request(TBlockGame *class, int x, int y, int dir, int point);
void  control_block_hit_bound(SBlockBall *ball, SBlockItem *block);
void  disp_picture(TBlockGame *class);
void  disp_frame(TBlockGame *class);
void  disp_paddle(TBlockGame *class);
void  disp_block(TBlockGame *class);
void  disp_ball(TBlockGame *class);
void  disp_point(TBlockGame *class);
void  disp_score(TBlockGame *class);
void  disp_stage(TBlockGame *class);
void  disp_clear(TBlockGame *class);
void  disp_gameover(TBlockGame *class);
void  load_stage(TBlockGame *class, char *datafile);
void  load_graphic(TBlockGame *class, char *datafile);


/* -------------------------------------------------------------- */
/* --- ゲームメインステップ                                       */
/* -------------------------------------------------------------- */

/* ---------------------------------------- */
/* --- コンストラクタ・デストラクタ         */
TBlockGame *TBlockGame_Create(TGameScreen *mainscreen)
{
  TBlockGame *class;

  class = malloc(sizeof(TBlockGame));
  if (class == NULL) return(0);

  class->screen = mainscreen;
  class->step = StartUp;

  return(class);
}

void TBlockGame_Destroy(TBlockGame *class)
{
  if (class == NULL) return;

  /* - 何かありましたら */

  /* --- インスタンスの解放 */
  free(class);
}


/* ---------------------------------------- */
/* --- ゲーム初期化                       */
/* ---------------------------------------- */
void TBlockGame_Init(TBlockGame *class)
{
  /* --- 持ち玉設定 */
  class->ball_rest = MYBALLMAX;
  /* --- パドル設定 */
  class->pad.x = 24;
  class->pad.y = FIELD_H / 2 * 1024;
  class->pad.dir = 0;
}


/* ---------------------------------------- */
/* --- ステージ初期化                     */
/* ---------------------------------------- */
void TBlockGame_StageStart(TBlockGame *class,
			   char *block_file,
			   char *graphic_file,
			   int speed,
			   int speed_max,
			   int stage_num)
{
  TGameSprite  *spr;
  int i;

  class->stage = stage_num;
  class->step = STEP_STARTUP;
  class->bgm_playing = FALSE;
  load_stage(class, block_file);
  load_graphic(class, graphic_file);

  /* --- スプライトクリア */
  for(i=0; i<SPRITEMAX; i++) {
    spr = TGameScreen_GetSprite(class->screen, i);
    spr->DispSw = FALSE;
  }
  /* --- ボールクリア */
  for(i=0; i<MYBALLMAX; i++) {
    class->ball[i].sw = FALSE;
  }
  class->ball_alive = 0;
  class->ball_speed = speed;
  class->ball_speed_max = speed_max;
  /* --- パドルの長さ初期化 */
  class->pad.w = PADDLE_SIZE_MAX;
  if (class->pad.y < ((class->pad.w / 2) << 10)) {
    class->pad.y = (class->pad.w / 2) << 10;
  }
  if (class->pad.y > ((FIELD_H - (class->pad.w / 2)) << 10)) {
    class->pad.y = ((FIELD_H - (class->pad.w / 2)) << 10);
  }
  /* --- ポイントパネル初期化 */
  for(i=0; i<POINTMAX; i++) {
    class->point[i].sw = FALSE;
  }
}


/* ---------------------------------------- */
/* --- スコアアクセサ                     */
/* ---------------------------------------- */
void TBlockGame_SetScore(TBlockGame *class, int score)
{
  class->score = score;
}

int TBlockGame_GetScore(TBlockGame *class)
{
  return(class->score);
}


/* ---------------------------------------- */
/* --- ゲームメイン                       */
/* ---------------------------------------- */
int TBlockGame_Poll(TBlockGame *class)
{

  /* --- 初期化 */
  class->reason = REASON_PLAYING;

  /* --- ゲームステップ */
  switch(class->step) {
    /* - ステージスタートデモがあったらここで */
  case STEP_STARTUP:
    class->step_timer = 0;
    class->step = STEP_PLAYING;
    break;

    /* - ゲーム本体 */
  case STEP_PLAYING:
    class->step_timer += 1;
    /* paddle control */
    control_paddle(class);
    /* shoot a ball */
    control_shoot(class);
    /* move ball */
    control_ball(class);
    /* point panel */
    control_point(class);
    /* display screen */
    build_display(class);
    /* clear check */
    if (class->block_num == 0) {
      class->step_timer = 0;
      class->step = STEP_CLEAR;
    }
    /* gameover check */
    if ((class->ball_rest == 0) &&
	(class->ball_alive == 0)) {
      class->step_timer = 0;
      class->step = STEP_GAMEOVER;
    }
    break;

    /* - ゲームクリア時Attract */
  case STEP_CLEAR:
    class->step_timer += 1;
    /* paddle control */
    control_paddle(class);
    /* move ball */
    control_ball_clear(class);
    /* point panel */
    control_point(class);
    /* display screen */
    build_display_clear(class);
    /* --- キーが押されたら次へ進む */
    if (class->ball_alive == 0) {
      if ((InputJoyKeyTriger(0) & (IN_Button1|IN_Button2|IN_Button3|IN_Button4)) != 0) {
	class->step = STEP_DONE;
      }
    }
    break;

    /* - ゲームオーバー時Attract */
  case STEP_GAMEOVER:
    class->step_timer += 1;
    /* paddle control */
    control_paddle(class);
    /* point panel */
    control_point(class);
    /* display screen */
    build_display_gameover(class);
    /* --- キーが押されたら次へ進む */
    if (class->step_timer > DISP_STAGE_TIME) {
      if ((InputJoyKeyTriger(0) & (IN_Button1|IN_Button2|IN_Button3|IN_Button4)) != 0) {
	class->step = STEP_DONE;
      }
    }
    break;

    /* - 終了 */
  case STEP_DONE:
    SoundMusicStop();
    if (class->block_num == 0) {
      class->reason = REASON_CLEAR;
    }
    if ((class->ball_rest == 0) &&
	(class->ball_alive == 0)) {
      class->reason = REASON_GAMEOVER;
    }
    break;
  }

  return(class->reason);
}


/* ---------------------------------------- */
/* --- control                              */
/* ---------------------------------------- */

/* -------------------- */
/* --- パドル操作 */
void  control_paddle(TBlockGame *class)
{
  int  speed;
  int  inkey;

  speed = PADDLE_SPEED_LOW;
  inkey = InputJoyKey(0);

  /* --- speed button */
  if ((inkey & (IN_Button3|IN_Button4|IN_Button5|IN_Button6)) != 0) {
    speed = PADDLE_SPEED_HIGH;
  }
  /* --- move */
  class->pad.dir = 0;
  if ((inkey & IN_Up) != 0) {
    class->pad.dir = 1;
    class->pad.y -= speed;
    if (class->pad.y < ((class->pad.w / 2) << 10)) {
      class->pad.y = (class->pad.w / 2) << 10;
    }
  }
  if ((inkey & IN_Down) != 0) {
    class->pad.dir = 2;
    class->pad.y += speed;
    if (class->pad.y > ((FIELD_H - (class->pad.w / 2)) << 10)) {
      class->pad.y = ((FIELD_H - (class->pad.w / 2)) << 10);
    }
  }
}

/* -------------------- */
/* --- ボール打ち込み */
void  control_shoot(TBlockGame *class)
{
  int  i;
  int  inkey;

  if (class->ball_rest == 0) return;

  inkey = InputJoyKeyTriger(0);
  if ((inkey & (IN_Button1|IN_Button2|IN_Right)) != 0) {
    for(i=0; i<MYBALLMAX; i++) {
      if (class->ball[i].sw == FALSE) {
	class->ball[i].sw = TRUE;
	class->ball[i].w = BALL_SIZE_W / 2;
	class->ball[i].h = BALL_SIZE_H / 2;
	class->ball[i].x = (class->pad.x  + class->ball[i].w) << 10;
	class->ball[i].y = class->pad.y;
	class->ball[i].speed = class->ball_speed;
	class->ball[i].dir = 330;
	class->ball[i].type = (class->ball_rest % 3);
	class->ball_alive += 1;
	class->ball_rest -= 1;
	if (class->ball_alive > 2) {
	  class->ball[i].type = (class->ball_rest % 3) + 10;
	}
	if (class->bgm_playing == FALSE) {
	  SoundMusic(class->stage);
	  class->bgm_playing = TRUE;
	}
	break;
      }
    }
  }
}

/* -------------------- */
/* --- ボール移動 */
void  control_ball(TBlockGame *class)
{
  int  i, j, bl;
  int  d, pd;
  int  dx, dy;

  for(i=0; i<MYBALLMAX; i++) {
    if (class->ball[i].sw == TRUE) {
      /* --- move */
      class->ball[i].x += (ball_cos[class->ball[i].dir] * class->ball[i].speed) >> 10;
      class->ball[i].y += (ball_sin[class->ball[i].dir] * class->ball[i].speed) >> 10;

      /* --- field check */
      if (class->ball[i].x < 0) {
	/* - miss */
	SoundSE(5);
	class->ball[i].sw = FALSE;
	class->ball_alive -= 1;
      }
      if (class->ball[i].x >= ((FIELD_W - (BALL_SIZE_W/2)) << 10)) {
	d = class->ball[i].dir;
	if (d > 180) {
	  d = d - 360;
	}
	class->ball[i].dir = 180 - d;
	class->ball[i].x += (ball_cos[class->ball[i].dir] * class->ball[i].speed) >> 10;
	SoundSE(3);
      }
      if (class->ball[i].y < (class->ball[i].h << 10)) {
	class->ball[i].dir = 360 - class->ball[i].dir;
	class->ball[i].y += (ball_sin[class->ball[i].dir] * class->ball[i].speed) >> 10;
	SoundSE(3);
      }
      if (class->ball[i].y > ((FIELD_H - class->ball[i].h) << 10)) {
	class->ball[i].dir = 360 - class->ball[i].dir;
	class->ball[i].y += (ball_sin[class->ball[i].dir] * class->ball[i].speed) >> 10;
	SoundSE(3);
      }

      /* --- pad check */
      if ((class->ball[i].x <= ((class->pad.x + (BALL_SIZE_W/2)) << 10)) &&
	  (class->ball[i].x > ((class->pad.x - 8 - (BALL_SIZE_W/2)) << 10))) {
	pd = (class->pad.y - class->ball[i].y) / 1024;
	if ((pd < (class->pad.w / 2)) && (pd > -(class->pad.w / 2))) {
	  d = (class->ball[i].dir + 180) % 360;
	  if (d > 180) {
	    d = d - 360;
	  }
	  class->ball[i].dir = (-d + 360) % 360;
	  while(class->ball[i].x < (class->pad.x << 10)) {
	    class->ball[i].x += (ball_cos[class->ball[i].dir] * class->ball[i].speed) >> 10;
	  }
	  /* -- 速度と角度の変化 */
	  class->ball[i].dir = (class->ball[i].dir - (pd * 2) + 360) % 360;
	  if (class->ball[i].dir < 180) {
	    if (class->ball[i].dir > BALL_ANGLE_MAX) {
	      class->ball[i].dir = BALL_ANGLE_MAX;
	    }
	  }
	  else {
	    if (class->ball[i].dir < (360 - BALL_ANGLE_MAX)) {
	      class->ball[i].dir = 360 - BALL_ANGLE_MAX;
	    }
	  }
	  /* - 基本跳ね返すたびに加速 */
	  class->ball[i].speed += BALL_ACCELERATOR;
	  if (class->ball[i].speed > class->ball_speed_max) {
	    class->ball[i].speed = class->ball_speed_max;
	  }
	  SoundSE(2);
	}
      }

      /* --- block check */
      for(bl=0; bl<class->block_max; bl++) {
	if (class->block[bl].sw == FALSE) continue;
	/* -- まず縦方向でずれていたらさっくりドロップ */
	dx = (class->ball[i].x - (class->block[bl].x << 10));
	if (dx < 0) {
	  dx = -dx;
	}
	if (dx < (((BALL_SIZE_H + BLOCK_SIZE_H) / 2) << 10)) {
	  /* - 次に横方向で確認 */
	  dy = (class->ball[i].y - (class->block[bl].y << 10));
	  if (dy < 0) {
	    dy = -dy;
	  }	
	  if (dy < (((BALL_SIZE_W + BLOCK_SIZE_W) / 2) << 10)) {
	    /* --- ブロックに衝突を確認、各種処理 */
	    SoundSE(4);
	    /* 得点の発生 */
	    for(j=0; j<class->ball_alive; j++) {
	      control_point_request(class,
				    class->block[bl].x,
				    class->block[bl].y,
				    class->ball[i].dir,
				    class->block[bl].score);
	    }
	    /* ボールの反射 */
	    control_block_hit_bound(&class->ball[i], &class->block[bl]);
	    /* ブロックの消滅 */
	    class->block[bl].sw = FALSE;
	    class->block_num -= 1;
	  }
	}
      }
    }
  }
}

/* -------------------- */
/* --- 得点パネル */
void  control_point(TBlockGame *class)
{
  int  i;
  int  aim_r, dr;
  float  r, dig;

  for(i=0; i<POINTMAX; i++) {
    if (class->point[i].sw == TRUE) {
      class->point[i].x += (ball_cos[class->point[i].dir] * class->point[i].speed) / 1024;
      class->point[i].y += (ball_sin[class->point[i].dir] * class->point[i].speed) / 1024;
      if (class->point[i].timer > 0) {
	if (class->point[i].speed > 512) {
	  class->point[i].speed -= 512;
	}
	class->point[i].timer -= 1;
      }
      /* -- タイマーがあるときは放射移動、0でパドルに吸引 */
      if (class->point[i].timer == 0) {
	if (class->point[i].speed < POINT_SPEED_MAX) {
	  class->point[i].speed += 512;
	}
	/* 方向誘導 */
	dig = atan2((float)(class->point[i].x - (class->pad.x << 10)),
		    (float)(class->point[i].y - class->pad.y));
	r = 360.0 * dig / (3.1415926535 * 2);
	aim_r = (int)r;
	aim_r = (360 - aim_r) + 270;
	aim_r %= 360;
	dr = class->point[i].dir - aim_r;
	if (dr < 0) {
	  dr = -dr;
	}
	if (dr > 180) {
	  dr = class->point[i].dir - aim_r;
	  if (dr < 0) {
	    class->point[i].dir = (class->point[i].dir - 8 + 360) % 360;
	  }
	  else {
	    class->point[i].dir = (class->point[i].dir + 8 + 360) % 360;
	  }
	}
	else {
	  dr = class->point[i].dir - aim_r;
	  if (dr < 0) {
	    class->point[i].dir = (class->point[i].dir + 8 + 360) % 360;
	  }
	  else {
	    class->point[i].dir = (class->point[i].dir - 8 + 360) % 360;
	  }
	}
      }
      /* -- パドルの所まで来たら得点加算＆終了 */
      if (class->point[i].x < (class->pad.x << 10)) {
	class->point[i].sw = FALSE;
	class->score += class->point[i].score;
	SoundSE(1);
      }
    }
  }
}

/* -------------------- */
/* --- 得点パネルの生成 */
void  control_point_request(TBlockGame *class,
			    int x, int y,
			    int dir,
			    int point)
{
  SBlockPoint  *pts;
  int  i;

  /* --- 空きを探す */
  pts = 0;
  for(i=0; i<POINTMAX; i++) {
    if (class->point[i].sw == FALSE) {
      pts = &class->point[i];
      break;
    }
  }
  if (pts == 0) {
    return;
  }
  /* --- オブジェクト設定 */
  pts->sw = TRUE;
  pts->x = x << 10;
  pts->y = y << 10;
  pts->dir = (dir + (rand() % 60) - 30 + 360) % 360;
  pts->speed = 6000 + (rand() % 2000);
  pts->timer = 16;
  pts->score = point;
}

/* -------------------- */
/* --- ブロックにあたったときの反射計算 */
void  control_block_hit_bound(SBlockBall *ball, SBlockItem *block)
{
  int  base_line_x, base_line_y;
  int  dx, dy, p, d;
  int  bound_x, bound_y;

  bound_x = bound_y = FALSE;

  /* --- 象限からみてどちらの辺を調査すべきなのか */
  if (ball->dir < 180) {
    base_line_y = block->y - (block->w / 2) - ball->w;
  }
  else {
    base_line_y = block->y + (block->w / 2) + ball->w;
  }
  if ((ball->dir > 270) || (ball->dir <= 90)) {
    base_line_x = block->x - (block->h / 2) - ball->h;
  }
  else {
    base_line_x = block->x + (block->h / 2) + ball->h;
  }
  base_line_y <<= 10;
  base_line_x <<= 10;

  dx = ball_cos[ball->dir];
  dy = ball_sin[ball->dir];

  /* --- 上下のヒットを調査 */
  if (dx != 0) {
    p = ((base_line_x - ball->x) << 10) / dx;
    p = (p * dy) >> 10;
    p += ball->y;
    p -= (block->y << 10);
    if (p < 0) {
      p = -p;
    }
    if (p <= (((BLOCK_SIZE_W + BALL_SIZE_W) / 2) << 10)) {
      /* - 上もしくは下にヒット */
      bound_x = TRUE;
    }
  }

  /* --- 左右のヒットを調査 */
  if (dy != 0) {
    p = ((base_line_y - ball->y) << 10) / dy;
    p = (p * dx) >> 10;
    p += ball->x;
    p -= (block->x << 10);
    if (p < 0) {
      p = -p;
    }
    if (p < (((BLOCK_SIZE_H + BALL_SIZE_H) / 2) << 10)) {
      /* - 上もしくは下にヒット */
      bound_y = TRUE;
    }
  }

  /* --- 実際にボールを反射する */
  if (bound_y == TRUE) {
    ball->dir = 360 - ball->dir;
    ball->y += (ball_sin[ball->dir] * ball->speed) >> 10;
  }
  if (bound_x == TRUE) {
    d = ball->dir;
    if (d > 180) {
      d = d - 360;
    }
    ball->dir = (180 - d + 360) % 360;
    ball->x += (ball_cos[ball->dir] * ball->speed) >> 10;
  }
}


void  control_ball_clear(TBlockGame *class)
{
  int  i;
  int  aim_r, dr;
  float  r, dig;

  /* --- しばらく止まっている */
  if (class->step_timer < DISP_STAGE_TIME) {
    return;
  }

  for(i=0; i<MYBALLMAX; i++) {
    if (class->ball[i].sw == TRUE) {
      /* --- move */
      class->ball[i].x += (ball_cos[class->ball[i].dir] * class->ball[i].speed) >> 10;
      class->ball[i].y += (ball_sin[class->ball[i].dir] * class->ball[i].speed) >> 10;
      if (class->ball[i].speed < POINT_SPEED_MAX) {
	class->ball[i].speed += 256;
      }
      /* 方向誘導 */
      dig = atan2((float)(class->ball[i].x - (class->pad.x << 10)),
		  (float)(class->ball[i].y - class->pad.y));
      r = 360.0 * dig / (3.1415926535 * 2);
      aim_r = (int)r;
      aim_r = (360 - aim_r) + 270;
      aim_r %= 360;
      dr = class->ball[i].dir - aim_r;
      if (dr < 0) {
	dr = -dr;
      }
      if (dr > 180) {
	dr = class->ball[i].dir - aim_r;
	if (dr < 0) {
	  class->ball[i].dir = (class->ball[i].dir - 8 + 360) % 360;
	}
	else {
	  class->ball[i].dir = (class->ball[i].dir + 8 + 360) % 360;
	}
      }
      else {
	dr = class->ball[i].dir - aim_r;
	if (dr < 0) {
	  class->ball[i].dir = (class->ball[i].dir + 8 + 360) % 360;
	}
	else {
	  class->ball[i].dir = (class->ball[i].dir - 8 + 360) % 360;
	}
      }
      /* -- パドルの所まで来たら得点加算＆終了 */
      if (class->ball[i].x < (class->pad.x << 10)) {
	class->ball[i].sw = FALSE;
	class->ball_alive -= 1;
	class->ball_rest += 1;
	SoundSE(1);
      }
    }
  }
}



/* ---------------------------------------- */
/* --- 画面描画                            */
/* ---------------------------------------- */

void  build_display(TBlockGame *class)
{
  disp_picture(class);
  disp_frame(class);
  disp_paddle(class);
  disp_ball(class);
  disp_block(class);
  disp_point(class);
  disp_score(class);
  disp_stage(class);
}

void  build_display_clear(TBlockGame *class)
{
  disp_picture(class);
  disp_frame(class);
  disp_paddle(class);
  disp_ball(class);
  disp_point(class);
  disp_score(class);
  disp_clear(class);
}

void  build_display_gameover(TBlockGame *class)
{
  disp_picture(class);
  disp_frame(class);
  disp_paddle(class);
  disp_ball(class);
  disp_point(class);
  disp_score(class);
  disp_gameover(class);
}


/* -------------------- */
/* --- 背景グラフィック表示 */
void  disp_picture(TBlockGame *class)
{
  TGameSprite  *spr;

  spr = TGameScreen_GetSprite(class->screen, SPRITE_GRAPHIC);
  spr->DispSw = TRUE;
  spr->x = 0; spr->y = 8;
  spr->w = 472; spr->h = 256;
  spr->tx = 40; spr->ty = 0;
  spr->alpha = 255;
  spr->Texture = TGameScreen_GetTexture(class->screen, 1);
}

/* -------------------- */
/* --- 外枠表示 */
void  disp_frame(TBlockGame *class)
{
  TGameSprite  *spr;

  /* 1 */
  spr = TGameScreen_GetSprite(class->screen, SPRITE_FRAME);
  spr->DispSw = TRUE;
  spr->x = 0; spr->y = 0;
  spr->w = FRAME_W - 8; spr->h = 8;
  spr->tx = 32; spr->ty = 496;
  spr->alpha = 255;
  spr->Texture = TGameScreen_GetTexture(class->screen, 0);
  /* 2 */
  spr = TGameScreen_GetSprite(class->screen, SPRITE_FRAME+1);
  spr->DispSw = TRUE;
  spr->x = 0; spr->y = FRAME_H - 8;
  spr->w = FRAME_W - 8; spr->h = 8;
  spr->tx = 32; spr->ty = 504;
  spr->alpha = 255;
  spr->Texture = TGameScreen_GetTexture(class->screen, 0);
  /* 3 */
  spr = TGameScreen_GetSprite(class->screen, SPRITE_FRAME+2);
  spr->DispSw = TRUE;
  spr->x = FRAME_W - 8; spr->y = 0;
  spr->w = 8; spr->h = FRAME_H;
  spr->tx = 504; spr->ty = 240;
  spr->alpha = 255;
  spr->Texture = TGameScreen_GetTexture(class->screen, 0);
}

/* -------------------- */
/* --- パドル表示 */
void  disp_paddle(TBlockGame *class)
{
  TGameSprite  *spr;
  int  timer;

  /* paddle body */
  spr = TGameScreen_GetSprite(class->screen, SPRITE_PADDLE);
  spr->DispSw = TRUE;
  spr->x = class->pad.x - 24;
  spr->y = (class->pad.y >> 10)-(class->pad.w >> 1) + 8;
  spr->w = 24;
  spr->h = class->pad.w;
  spr->alpha = 255;
  spr->Texture = TGameScreen_GetTexture(class->screen, 0);
  /* character */
  timer = (class->step_timer / 10) % 2;
  switch(class->pad.dir) {
  case 0:
    spr->tx = 472;
    spr->ty = 32;
    break;
  case 1:
    spr->tx = 448 - (24 * timer);
    spr->ty = 32;
    break;
  case 2:
    spr->tx = 400 - (24 * timer);
    spr->ty = 32;
    break;
  }
  /* === */
}

/* -------------------- */
/* --- ブロック表示 */
void  disp_block(TBlockGame *class)
{
  TGameSprite  *spr;
  int  i;

  for(i=0; i<class->block_max; i++) {
    spr = TGameScreen_GetSprite(class->screen, SPRITE_BLOCK+i);
    spr->DispSw = class->block[i].sw;
    if (class->block[i].sw == TRUE) {
      spr->x = class->block[i].x - (class->block[i].h >> 1);
      spr->y = class->block[i].y - (class->block[i].w >> 1) + 8;
      spr->w = class->block[i].h;
      spr->h = class->block[i].w;
      spr->tx = 496 - ((class->block[i].color - 1) * BLOCK_SIZE_H);
      spr->ty = 0;
      spr->alpha = 255;
      spr->Texture = TGameScreen_GetTexture(class->screen, 0);
    }
    /* --- shadow */
    spr = TGameScreen_GetSprite(class->screen, SPRITE_SHADOW+i);
    spr->DispSw = class->block[i].sw;
    spr->x = class->block[i].x - (class->block[i].h >> 1) - 3;
    spr->y = class->block[i].y - (class->block[i].w >> 1) + 8 + 3;
    spr->w = class->block[i].h;
    spr->h = class->block[i].w;
    spr->tx = 240;
    spr->ty = 0;
    spr->alpha = 255;
    spr->Texture = TGameScreen_GetTexture(class->screen, 0);
  }
}

/* -------------------- */
/* --- ボール表示 */
void  disp_ball(TBlockGame *class)
{
  TGameSprite  *spr;
  int  i;

  for(i=0; i<MYBALLMAX; i++) {
    spr = TGameScreen_GetSprite(class->screen, SPRITE_BALL+i);
    spr->DispSw = class->ball[i].sw;
    if (class->ball[i].sw == TRUE) {
      if (class->ball[i].type < 10) {
	spr->x = (class->ball[i].x >> 10) - class->ball[i].w;
	spr->y = (class->ball[i].y >> 10) - class->ball[i].h + 8;
	spr->w = class->ball[i].w * 2;
	spr->h = class->ball[i].h * 2;
	spr->tx = 468 - (class->ball[i].type * 16);
	spr->ty = 96;
	spr->rotation_z = 0;
      }
      else {
	spr->x = (class->ball[i].x >> 10) - 16;
	spr->y = (class->ball[i].y >> 10) - 16 + 8;
	spr->w = 32;
	spr->h = 32;
	spr->tx = 480 - ((class->ball[i].type - 10) * 32);
	spr->ty = 128;
	spr->rotation_z = 360 - class->ball[i].dir;
      }
      spr->alpha = 255;
      spr->Texture = TGameScreen_GetTexture(class->screen, 0);
    }
  }
}

/* --- 得点チップ表示 */
void  disp_point(TBlockGame *class)
{
  TGameSprite  *spr;
  int  i;

  for(i=0; i<POINTMAX; i++) {
    spr = TGameScreen_GetSprite(class->screen, SPRITE_POINT+i);
    spr->DispSw = class->point[i].sw;
    if (class->point[i].sw == TRUE) {
      spr->x = (class->point[i].x >> 10) - 8;
      spr->y = (class->point[i].y >> 10) - 8;
      spr->w = 16;
      spr->h = 16;
      spr->tx = 496;
      spr->ty = 112;
      spr->alpha = 255;
      spr->Texture = TGameScreen_GetTexture(class->screen, 0);
    }
  }
}

/* --- 得点と残り玉 */
void  disp_score(TBlockGame *class)
{
  TGameSprite  *spr;
  int  i, j;
  int  c;
  int  top;

  int x, y;
  int n, o;
  int num;

  /* --- 表示するSCORE */
  num = class->score;

  /* --- "SCORE" の表示 */
  spr = TGameScreen_GetSprite(class->screen, SPRITE_SCORE);
  spr->DispSw = TRUE;
  spr->x = 480 - 8 - 16;
  spr->y = 12;
  spr->w = 16;
  spr->h = 64;
  spr->tx = 448;
  spr->ty = 256;
  spr->TextureId = 0;
  spr->Texture = TGameScreen_GetTexture(class->screen, 0);
  spr->alpha = 255;
  
  /* x, y : 表示位置 */
  /* n : 表示文字数 */
  /* o : Obj番号 */
  /* num : 表示する数字 */
  o = 1;
  n = 8;
  x = 480 - 8 - 16;
  y = 72;
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

  /* ---------------------------------- */
  /* --- ボールの持ち玉のこり */
  /* --- "REST" の表示 */
  spr = TGameScreen_GetSprite(class->screen, SPRITE_SCORE+10);
  spr->DispSw = TRUE;
  spr->x = 0 + 2;
  spr->y = 12;
  spr->w = 16;
  spr->h = 48;
  spr->tx = 432;
  spr->ty = 256;
  spr->TextureId = 0;
  spr->Texture = TGameScreen_GetTexture(class->screen, 0);
  spr->alpha = 255;
  /* --- ball */
  for(i=0; i<MYBALLMAX; i++) {
    spr = TGameScreen_GetSprite(class->screen, SPRITE_SCORE+11+i);
    if (i <class->ball_rest) {
      spr->DispSw = TRUE;
    }
    else {
      spr->DispSw = FALSE;
    }
    spr->x = 0 + 2;
    spr->y = 12+48+(i*11);
    spr->w = 10;
    spr->h = 10;
    spr->tx = 486;
    spr->ty = 96;
    spr->TextureId = 0;
    spr->Texture = TGameScreen_GetTexture(class->screen, 0);
    spr->alpha = 255;
  }
}


/* --- ステージ数表示 */
void  disp_stage(TBlockGame *class)
{
  TGameSprite  *spr;

  /* --- 一定時間で消える */
  if (class->step_timer > DISP_STAGE_TIME) {
    spr = TGameScreen_GetSprite(class->screen, SPRITE_INFO);
    spr->DispSw = FALSE;
    spr = TGameScreen_GetSprite(class->screen, SPRITE_INFO+1);
    spr->DispSw = FALSE;
    return;
  }

  /* --- stage */
  spr = TGameScreen_GetSprite(class->screen, SPRITE_INFO);
  spr->DispSw = TRUE;
  spr->x = 280;
  spr->y = 76;
  spr->w = 32;
  spr->h = 80;
  spr->tx = 368;
  spr->ty = 256;
  spr->TextureId = 0;
  spr->Texture = TGameScreen_GetTexture(class->screen, 0);
  spr->alpha = 255;
  /* --- num */
  spr = TGameScreen_GetSprite(class->screen, SPRITE_INFO+1);
  spr->DispSw = TRUE;
  spr->x = 280;
  spr->y = 76+88;
  spr->w = 32;
  spr->h = 32;
  spr->tx = 336 - (32 * ((class->stage - 1) / 5));
  spr->ty = 256 + (32 * ((class->stage - 1) % 5));
  spr->TextureId = 0;
  spr->Texture = TGameScreen_GetTexture(class->screen, 0);
  spr->alpha = 255;
}

/* --- ステージクリア */
void  disp_clear(TBlockGame *class)
{
  TGameSprite  *spr;

  /* --- 一定時間で消える */
  if (class->step_timer > DISP_STAGE_TIME) {
    spr = TGameScreen_GetSprite(class->screen, SPRITE_INFO);
    spr->DispSw = FALSE;
    return;
  }

  /* --- stage */
  spr = TGameScreen_GetSprite(class->screen, SPRITE_INFO);
  spr->DispSw = TRUE;
  spr->x = 280;
  spr->y = (272 - 202) / 2;
  spr->w = 32;
  spr->h = 202;
  spr->tx = 400;
  spr->ty = 256;
  spr->TextureId = 0;
  spr->Texture = TGameScreen_GetTexture(class->screen, 0);
  spr->alpha = 255;
}

/* --- ゲームオーバー */
void  disp_gameover(TBlockGame *class)
{
  TGameSprite  *spr;

  /* --- gameover logo */
  spr = TGameScreen_GetSprite(class->screen, SPRITE_INFO);
  spr->DispSw = TRUE;
  spr->x = 280;
  spr->y = (272 - 176) / 2;
  spr->w = 32;
  spr->h = 170;
  spr->tx = 176;
  spr->ty = 256;
  spr->TextureId = 0;
  spr->Texture = TGameScreen_GetTexture(class->screen, 0);
  spr->alpha = 255;
}



/* ---------------------------------------- */
/* --- ステージ準備                       */
/* ---------------------------------------- */

/* ---------------------------------------- */
/* --- ブロック形状データ読み込み */
void  load_stage(TBlockGame *class, char *datafile)
{
  FILE  *fp;
  char line[256], *result;
  int i, v, num, type;

  /* --- clear */
  for(i=0; i<BLOCKMAX; i++) {
    class->block[i].sw = FALSE;
  }

  /* --- file read */
  fp = fopen(datafile, "r");
  if (fp == NULL) {
    /* error */
    printf("File not found - %s\n", datafile);
    return;
  }

  /* --- set block */
  num = 0;
  for(v=0; v<BLOCK_H; v++) {
    result = fgets(line, 255, fp);
    if (result == NULL) {
      break;
    }
    for(i=0; i<BLOCK_W; i++) {
      if (line[i] == 0) {
	break;
      }
      if (line[i] != '0') {
	type = (int)(line[i] - '0');
	if (type > 9) {
	  continue;
	}
	/* -- set block */
	class->block[num].sw = TRUE;
	class->block[num].w = BLOCK_SIZE_W;
	class->block[num].h = BLOCK_SIZE_H;
	class->block[num].x = BLOCK_START_POS - (v * BLOCK_SIZE_H) + (BLOCK_SIZE_H / 2);
	class->block[num].y = (i * BLOCK_SIZE_W) + (BLOCK_SIZE_W / 2);
	class->block[num].color = type;
	class->block[num].score = 10;
	num += 1;
      }
    }
  }
  class->block_max = class->block_num = num;
  fclose(fp);
}

/* ---------------------------------------- */
/* --- 背景画像読み込み */
void  load_graphic(TBlockGame *class, char *datafile)
{
  TGameScreen_LoadTexture(class->screen, 1, datafile);
}
