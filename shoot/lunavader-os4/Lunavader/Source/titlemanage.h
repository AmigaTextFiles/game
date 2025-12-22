/* ---------------------------------------------------------- */
/*  titlemanage.h                                             */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		タイトル画面の表示とその管理
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.19.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

#ifndef TITLEMANAGE_H
#define TITLEMANAGE_H

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include "lunavader.h"
#include "SpriteItem.h"
#include "basicsystem.h"

/*-------------------------------*/
/* define                        */
/*-------------------------------*/

#define SPRITENUM  5

/*-------------------------------*/
/* struct                        */
/*-------------------------------*/

/*-------------------------------*/
/* class                         */
/*-------------------------------*/

/**
 * @brief タイトル画面の管理
 *
 * @todo -
 * @bug -
 */
class TitleManage
{
  /* ----------------------------------- */
  /* --- コンストラクタ・デストラクタ */
 public:
  TitleManage();
  virtual  ~TitleManage();

  /* ----------------------------------- */
  /* --- パブリックメンバ */
 public:

  /* ----------------------------------- */
  /* --- プライベートメンバ */
 private:
  //! 背景に使うスプライトハンドル
  LSPRITE  m_LunaSprite;
  //! スプライトオブジェクト
  SpriteItem  *sprite[SPRITENUM];
  //! タイトルアクションステップ
  int  m_Step;
  //! カウンター
  int  m_Timer;
  //! カウンター
  bool  m_DoStart;

  /* ----------------------------------- */
  /* --- パブリックメソッド */
 public:
  void Init();
  bool Tick(unsigned long inkey);
  bool Start();
  bool Display();
  void SetLunaSprite(LSPRITE sp_handle);

  /* ----------------------------------- */
  /* --- プライベートメソッド */
 private:

};


#endif

