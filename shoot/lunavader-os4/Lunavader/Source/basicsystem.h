/* ---------------------------------------------------------- */
/*  BasicSystem.h                                             */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		Luna system の隠蔽と抽象化
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.12.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.

 Convert to PSP - Oct.15.2006
 ------------------------------------------------------*/

#ifndef BASICSYSTEM_H
#define BASICSYSTEM_H

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include "lunavader.h"
#include "input.h"
#include "sound.h"
#include "debug.h"
#include "grp_screen.h"

/*-------------------------------*/
/* define                        */
/*-------------------------------*/

//! プレイヤー入力のビット列
#define  BS_INPUT_UP       IN_Up
#define  BS_INPUT_DOWN     IN_Down
#define  BS_INPUT_LEFT     IN_Left
#define  BS_INPUT_RIGHT    IN_Right
#define  BS_INPUT_BUTTON1  IN_Button1
#define  BS_INPUT_BUTTON2  IN_Button2
#define  BS_INPUT_BUTTON3  IN_Button3
#define  BS_INPUT_BUTTON4  IN_Button4

//! 自機表示用のスプライトバッファのサイズ
#define  BS_SPBUF_MYSHIP  1
//! 自弾表示用のスプライトバッファのサイズ
#define  BS_SPBUF_MYSHOT  1
//! 敵群体表示用のスプライトバッファのサイズ
#define  BS_SPBUF_ENEMY   50
//! ボーナス船表示用のスプライトバッファのサイズ
#define  BS_SPBUF_BONUSSHIP  1
//! 敵弾幕やエフェクトのスプライトバッファのサイズ
#define  BS_SPBUF_BULLET  800
//! 背景表示用のスプライトバッファのサイズ
#define  BS_SPBUF_BACKGROUND  10
//! スコアパネル表示用のスプライトバッファのサイズ
#define  BS_SPBUF_PANEL  50
//! タイトル画面表示用のスプライトバッファのサイズ
#define  BS_SPBUF_TITLE  10

//! 自機表示用のスプライト深度
#define  BS_DEPTH_MYSHIP  10
//! 自弾表示用のスプライト深度
#define  BS_DEPTH_MYSHOT  8
//! 敵群体表示用のスプライト深度
#define  BS_DEPTH_ENEMY   15
//! ボーナス船表示用のスプライト深度
#define  BS_DEPTH_BONUSSHIP  15
//! 敵弾幕やエフェクトのスプライト深度
#define  BS_DEPTH_BULLET  5
//! 背景表示用のスプライト深度
#define  BS_DEPTH_BACKGROUND  100
//! スコアパネル表示用のスプライト深度
#define  BS_DEPTH_PANEL  5
//! スコアパネル上の文字表示用のスプライト深度
#define  BS_DEPTH_PANELITEM  6
//! タイトル画面表示用のスプライト深度
#define  BS_DEPTH_TITLE  50


/*-------------------------------*/
/* struct                        */
/*-------------------------------*/

/*-------------------------------*/
/* class                         */
/*-------------------------------*/

/**
 * @brief system コントロールクラス
 *        元々は Luna ライブラリへのアクセスを隠蔽するクラス
 *        ソレを自前 SDLシステムに移し替えた物
 *
 * @todo -
 * @bug -
 */
class BasicSystem
{
  /* ----------------------------------- */
  /* --- コンストラクタ・デストラクタ */
 public:
  BasicSystem();
  virtual  ~BasicSystem();

  /* ----------------------------------- */
  /* --- パブリックメンバ */
 public:
  //! ゲームスコア
  long  m_Score;
  //! ゲームハイスコア
  long  m_HighScore;

  //! スクリーンハンドル
  TGameScreen  *screen;

  /* ----------------------------------- */
  /* --- プライベートメンバ */
 private:

  /* ----------------------------------- */
  /* --- パブリックメソッド */
 public:
  void Init();
  void Release();
  void Tick();
  void DisplayUpdate();
  TGameSprite *GetSpriteNext();
  unsigned long GetKeyInput();
  unsigned long GetKeyInputTriger();
  void PlaySoundEffect(int num);
  void PlayMusic(int num);
  void StopMusic();
  void AddDebugMessage(unsigned char *line);


  /* ----------------------------------- */
  /* --- プライベートメソッド */
 private:

};


#endif

