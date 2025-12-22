/* ---------------------------------------------------------- */
/*  ShootingObject.h                                          */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		当たり判定付きスプライトクラス
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.14.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

#ifndef SHOOTINGOBJECT_H
#define SHOOTINGOBJECT_H

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include "lunavader.h"
#include "spriteitem.h"

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
 * @brief シューティング向けスプライトクラス
 *        当たり判定のメソッドを持ったスプライトアイテム
 *        かすり判定もあるよ
 *
 * @todo -
 * @bug -
 */
class ShootingObject : public SpriteItem
{
  /* ----------------------------------- */
  /* --- コンストラクタ・デストラクタ */
 public:
  ShootingObject();
  virtual  ~ShootingObject();

  /* ----------------------------------- */
  /* --- パブリックメンバ */
 public:
  //! オブジェクトタイプ(判別が必要な時に)
  int  m_Type;
  //! かすり判定有効
  bool  m_GrazeEnable;
  //! 当たり判定有効
  bool m_HitEnable;

  /* ----------------------------------- */
  /* --- プライベートメンバ */
 private:
  //! 当たり判定半径
  float  m_HitR;
  //! 当たり判定距離計測用
  float  m_HitPow;
  //! かすり判定半径
  float  m_GrazeR;
  //! かすり判定距離計測用
  float  m_GrazePow;

  /* ----------------------------------- */
  /* --- パブリックメソッド */
 public:
  void  SetHitSize(float r);
  void  SetGrazeSize(float r);
  bool  CheckCollision(ShootingObject *obj);
  bool  CheckGraze(ShootingObject *obj);

  /* ----------------------------------- */
  /* --- プライベートメソッド */
 private:

};


#endif

