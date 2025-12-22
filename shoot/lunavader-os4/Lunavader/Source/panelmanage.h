/* ---------------------------------------------------------- */
/*  PanelManage.h                                             */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		スコアパネルの実装クラス
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.13.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

#ifndef PANELMANAGE_H
#define PANELMANAGE_H

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include "lunavader.h"
#include "basicsystem.h"
#include "spriteitem.h"

/*-------------------------------*/
/* define                        */
/*-------------------------------*/

/* --- 画面上でのパネル位置 */
#define PANELPOSX  448
#define PANELPOSY  0

/* --- Score の位置 */
#define PANELSCOREX  32
#define PANELSCOREY  64

/* --- HiScore の位置 */
#define PANELHISCOREX  32
#define PANELHISCOREY  (64 + 60)

/* --- Graze の位置 */
#define PANELGRAZEX  32
#define PANELGRAZEY  (64 + 60 + 60)

/* --- Stage の位置 */
#define PANELSTAGEX  32
#define PANELSTAGEY  (64 + 60 + 60 + 60)

/*-------------------------------*/
/* struct                        */
/*-------------------------------*/

/*-------------------------------*/
/* class                         */
/*-------------------------------*/

/**
 * @brief スコアパネルの表示管理
 *        スコアの表示とかの実装
 *
 * @todo -
 * @bug -
 */
class PanelManage
{
  /* ----------------------------------- */
  /* --- コンストラクタ・デストラクタ */
 public:
  PanelManage();
  virtual  ~PanelManage();

  /* ----------------------------------- */
  /* --- パブリックメンバ */
 public:

  /* ----------------------------------- */
  /* --- プライベートメンバ */
 private:
  LSPRITE  m_LunaSprite;
  //! スプライトオブジェクト
  SpriteItem  m_PanelSprite[BS_SPBUF_PANEL];
  int  m_Score;
  int  m_HighScore;
  int  m_Graze;
  int  m_Stage;
  int  m_Timer;
  bool m_GameOver;

  /* ----------------------------------- */
  /* --- パブリックメソッド */
 public:
  void  SetLunaSprite(LSPRITE sp_handle);
  bool  Tick();
  void  Display();
  void  SetScore(int score);
  void  SetHighScore(int hiscore);
  void  SetGraze(int graze);
  void  SetStage(int stage);
  void  SetGameOver(bool gameover);

  /* ----------------------------------- */
  /* --- プライベートメソッド */
 private:
  void  dec_display(int num,
		    int size,
		    int sprite,
		    int x,
		    int y);
  void  dec_display_fill(int num,
			 int size,
			 int sprite,
			 int x,
			 int y);

};


#endif

