/* ---------------------------------------------------------- */
/*  myshipmanage.h                                            */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		自機管理クラス
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.14.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

#ifndef MYSHIPMANAGE_H
#define MYSHIPMANAGE_H

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include "lunavader.h"
#include "basicsystem.h"
#include "shootingobject.h"
/*  #include "myshotmanage.h" */

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
 * @brief 自機管理用クラス
 *        自機の位置とかスプライトのインスタンスとか
 *        移動管理とかそんな感じ
 *
 * @todo -
 * @bug -
 */
class MyShipManage : public ShootingObject
{
  /* ----------------------------------- */
  /* --- コンストラクタ・デストラクタ */
 public:
  MyShipManage();
  virtual  ~MyShipManage();

  /* ----------------------------------- */
  /* --- パブリックメンバ */
 public:

  /* ----------------------------------- */
  /* --- プライベートメンバ */
 private:
  //! 自機弾管理インスタンスへのポインタ
  //  MyShotMan  m_ShotMan;
  //! 弾に当たってしまったか？すなわちゲームオーバー
  bool  m_IsHit;
  //! ゲームオーバーから実際に終了するまでのウェイト
  int  m_Wait;
  //! アクションローカルタイマー
  int  m_Timer;
  //! 左右移動時の傾き表現 (future reserve)
  float  m_Bank;

  /* ----------------------------------- */
  /* --- パブリックメソッド */
 public:
  //  void  SetMyShotMan(MyShotManage*  shot);
  void  Init();
  bool  SetHitState(bool hit);
  bool  GetHitState();
  bool  Tick(unsigned long  inkey,
	     unsigned long  inkey_triger);

  /* ----------------------------------- */
  /* --- プライベートメソッド */
 private:

};


#endif

