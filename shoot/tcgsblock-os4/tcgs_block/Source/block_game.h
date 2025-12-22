/* ---------------------------------------------------------- */
/*  block_game.h                                              */
/* ---------------------------------------------------------- */

/*--------------------------------------------------------*/
/*                                                        */
/* TCGS - BLOCK for PSP                                   */
/*                        Fumi2Kick                       */
/*                        1st Maintaner  rerofumi.        */
/*                                                        */
/*   block_game.h                                         */
/*     ブロック崩しのゲーム本体                           */
/*                                                        */
/*--------------------------------------------------------*/

#ifndef BLOCK_GAME_H
#define BLOCK_GAME_H

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include "SDL.h"
#include "grp_screen.h"

/*-------------------------------*/
/* define                        */
/*-------------------------------*/

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

/* --- ゲームステップのラベル */
enum {
  STEP_STARTUP,
  STEP_PLAYING,
  STEP_CLEAR,
  STEP_GAMEOVER,
  STEP_DONE
} BlockGameStep;

/* --- ゲーム終了理由 */
enum {
  REASON_PLAYING,
  REASON_CLEAR,
  REASON_GAMEOVER,
  REASON_ERROR
} ReturnReason;

/* --- ゲーム開始時の持ち玉数 */
#define MYBALLMAX  10

/* --- ボール形が変化する閾値 */
#define MYBALLVISUAL  3

/* --- ブロックの最大数 */
#define BLOCKMAX  512

/* --- 得点表示アイテムの最大数 */
#define POINTMAX  128
#define POINT_SPEED_MAX  (1024*7)

/* --- フレームサイズ */
#define FRAME_W  480
#define FRAME_H  272

/* --- フィールドサイズ */
#define FIELD_W  (480-8)
#define FIELD_H  (272-16)

/* --- ブロック表示開始位置(縦方向の一番上) */
#define BLOCK_START_POS  (480-64-8-8)

/* --- ブロックエリアの縦横サイズ */
#define BLOCK_W  8
#define BLOCK_H  24

#define BLOCK_SIZE_W 32
#define BLOCK_SIZE_H 16

/* --- パドル移動スピード(1024 で 1pixel) */
#define PADDLE_SPEED_LOW  (1024*3) 
#define PADDLE_SPEED_HIGH  (1024*6)

/* --- パドルの長さ */
#define PADDLE_SIZE_MAX 56
#define PADDKE_SIZE_MIN 16

/* --- ボールの大きさ */
#define BALL_SIZE_W 12
#define BALL_SIZE_H 12

/* --- ボールの加速度合い */
#define BALL_ACCELERATOR 100

/* --- ボールの最大鈍角 */
#define BALL_ANGLE_MAX  60

/* --- ステージ表示が出ている時間 */
#define DISP_STAGE_TIME  90

/*-------------------------------*/
/* SPTITE                        */
/*-------------------------------*/


#define SPRITE_GRAPHIC  0

#define SPRITE_SHADOW  100
#define SPRITE_BLOCK   300
#define SPRITE_POINT   600
#define SPRITE_BALL    880
#define SPRITE_PADDLE  896
#define SPRITE_FRAME   900
#define SPRITE_SCORE   910
#define SPRITE_INFO    935

/*-------------------------------*/
/* struct                        */
/*-------------------------------*/



/* --------------------------------------- */
/* --- ボール情報 */
typedef struct {
  int  sw;
  int  w, h;
  int  x, y;
  int  speed;
  int  dir;
  int  type;
} SBlockBall, *PSBlockBall;

/* --------------------------------------- */
/* --- パドル情報 */
typedef struct {
  int  w;
  int  x, y;
  int  dir;
} SBlockPaddle, *PSBlockPaddle;

/* --------------------------------------- */
/* --- ブロック情報 */
typedef struct {
  int  sw;
  int  w, h;
  int  x, y;
  int  color;
  int  score;
} SBlockItem, *PSBlockItem;

/* --------------------------------------- */
/* --- 得点情報 */
typedef struct {
  int  sw;
  int  x, y;
  int  timer;
  int  speed;
  int  dir;
  int  score;
} SBlockPoint, *PSBlockPoint;



/* --------------------------------------- */
/* --- ブロック崩しクラス */
typedef struct {

  /* --- 進行ステップ */
  int  step;
  int  step_timer;

  /* --- ゲーム終了の理由 */
  int  reason;

  /* --- スコア */
  int  score;

  /* --- 残りボールの数 */
  int  ball_rest;
  int  ball_alive;

  /* --- ボールのスピード制御 */
  int  ball_speed;
  int  ball_speed_max;

  /* --- 現在のステージ */
  int  stage;

  /* --- 有効なブロックの数 */
  int  block_num;
  int  block_max;

  /* --- BGM 鳴らしているよフラグ*/
  int  bgm_playing;

  /* --- ステージ情報 */
  SBlockPaddle  pad;
  SBlockItem    block[BLOCKMAX];
  SBlockBall    ball[MYBALLMAX];
  SBlockPoint   point[POINTMAX];

  /* --- スクリーンクラスへのアクセスポインタ */
  TGameScreen *screen;

} TBlockGame, *PTBlockGame;

/* ---------------------------------------------- */
/* --- extern                                  -- */
/* ---------------------------------------------- */

TBlockGame *TBlockGame_Create(TGameScreen *mainscreen);
void TBlockGame_Destroy(TBlockGame *class);

void TBlockGame_Init(TBlockGame *class);
void TBlockGame_StageStart(TBlockGame *class,
			   char *block_file,
			   char *graphic_file,
			   int speed,
			   int speed_max,
			   int stage_num);
void TBlockGame_SetScore(TBlockGame *class, int score);
int TBlockGame_GetScore(TBlockGame *class);
int TBlockGame_Poll(TBlockGame *class);


#endif //BLOCK_GAME_H
