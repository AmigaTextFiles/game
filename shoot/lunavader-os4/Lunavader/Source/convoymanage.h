/* ---------------------------------------------------------- */
/*  convoymanage.h                                            */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		敵群体の管理クラス
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.16.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

#ifndef CONVOYMANAGE_H
#define CONVOYMANAGE_H

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include "lunavader.h"
#include "enemyobject.h"
#include "myshotmanage.h"
#include "bulletmaker.h"

/*-------------------------------*/
/* define                        */
/*-------------------------------*/

//! 群体の縦横サイズ
#define  CV_COLUMN  10
#define  CV_ROW     4

//! 歩行シーケンス
enum {
  ENEMY_WALK_SEQ_RIGHT = 0,
  ENEMY_WALK_SEQ_DOWN1,
  ENEMY_WALK_SEQ_LEFT,
  ENEMY_WALK_SEQ_DOWN2
};


/*-------------------------------*/
/* struct                        */
/*-------------------------------*/

/*-------------------------------*/
/* class                         */
/*-------------------------------*/

/**
 * @brief 敵侵略者の群体管理クラス
 *
 * @todo -
 * @bug -
 */
class ConvoyManage
{
  /* ----------------------------------- */
  /* --- コンストラクタ・デストラクタ */
 public:
  ConvoyManage();
  virtual  ~ConvoyManage();

  /* ----------------------------------- */
  /* --- パブリックメンバ */
 public:

  /* ----------------------------------- */
  /* --- プライベートメンバ */
 private:
  //! 敵オブジェクトの配列
  EnemyObject*  m_Convoy;
  //! 弾やエフェクトの生成クラス
  BulletMaker  *m_BulletMaker;
  //! スプライトハンドル
  LSPRITE  m_SpriteHandle;
  //! 難易度
  int  m_Level;
  //! 現在の歩行方向
  int  m_WalkStat;
  //! 現在歩行している敵の番号
  int  m_WalkMember;
  //! 現在の歩行絵
  int  m_WalkPattern;
  //! ウェイト値
  int  m_Wait;
  //! 自機の弾に当たってキャラがやられたときのちょっとウェイト
  int  m_HitWait;
  //! 内部カウンター
  int  m_Timer;

  /* ----------------------------------- */
  /* --- パブリックメソッド */
 public:
  void  Init(int level);
  bool  Tick();
  void  SetBulletMaker(BulletMaker* bulletmaker);
  bool  IsInvade();
  int   GetRestEnemy();
  int  CheckHit(MyShotManage* shot);
  void  SetLunaSprite(LSPRITE handle);

  /* ----------------------------------- */
  /* --- プライベートメソッド */
 private:
  void  set_enemy();
  void  attack_enemy();

};


#endif

