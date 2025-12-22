/* ---------------------------------------------------------- */
/*  bonusshipmanage.h                                         */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		ボーナス船の管理クラス
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.18.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

#ifndef BONUSSHIPMANAGE_H
#define BONUSSHIPMANAGE_H

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include "lunavader.h"
#include "bulletbase.h"

/*-------------------------------*/
/* define                        */
/*-------------------------------*/

/*-------------------------------*/
/* struct                        */
/*-------------------------------*/

/*-------------------------------*/
/* class                         */
/*-------------------------------*/

/**
 * @brief ボーナス船のオブジェクトと移動管理
 *
 * @todo -
 * @bug -
 */
class BonusShipManage : public BulletBase
{
  /* ----------------------------------- */
  /* --- コンストラクタ・デストラクタ */
 public:
  BonusShipManage();
  virtual  ~BonusShipManage();

  /* ----------------------------------- */
  /* --- パブリックメンバ */
 public:

  /* ----------------------------------- */
  /* --- プライベートメンバ */
 private:
  //! 出現中かどうかのフラグ
  bool  m_Appear;
  //! タイミングカウント
  int  m_Timer;
  //! 表示キャラクターの指定 (今のところ 0 or 1)
  int  m_Charactor;
  //! このキャラクターの得点
  int  m_Score;

  /* ----------------------------------- */
  /* --- パブリックメソッド */
 public:
  bool Start();
  bool Tick();
  bool GetState();
  void SetCharactor(int chr);
  void SetScore(int score);
  int GetScore();
  bool CheckHit(ShootingObject *shot);

  /* ----------------------------------- */
  /* --- プライベートメソッド */
 private:

};


#endif

