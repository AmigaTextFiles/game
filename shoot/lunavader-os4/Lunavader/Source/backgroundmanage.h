/* ---------------------------------------------------------- */
/*  backgroundmanage.h                                        */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		ゲーム中の背景を表示します
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.18.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

#ifndef BACKGROUNDMANAGE_H
#define BACKGROUNDMANAGE_H

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include "lunavader.h"
#include "SpriteItem.h"

/*-------------------------------*/
/* define                        */
/*-------------------------------*/

#define  BACKGROUND_LAYER  2

/*-------------------------------*/
/* struct                        */
/*-------------------------------*/

/*-------------------------------*/
/* class                         */
/*-------------------------------*/

/**
 * @brief ゲーム中の背景を表示するクラス
 *        凝ればカッコイイ背景演出になるけど
 *        ま、そこはそれ
 *
 * @todo -
 * @bug -
 */
class BackGroundManage
{
  /* ----------------------------------- */
  /* --- コンストラクタ・デストラクタ */
 public:
  BackGroundManage();
  virtual  ~BackGroundManage();

  /* ----------------------------------- */
  /* --- パブリックメンバ */
 public:

  /* ----------------------------------- */
  /* --- プライベートメンバ */
 private:
  //! 現在の透明度
  float  m_BackBlend;
  //! 背景に使うスプライトハンドル
  LSPRITE  m_LunaSprite;
  //! スプライトオブジェクト
  SpriteItem  *bg[BACKGROUND_LAYER];

  /* ----------------------------------- */
  /* --- パブリックメソッド */
 public:
  void Init();
  bool Tick();
  bool Display();
  void SetLunaSprite(LSPRITE sp_handle);
  void SetBlend(float  blend);

  /* ----------------------------------- */
  /* --- プライベートメソッド */
 private:

};


#endif

