/* ---------------------------------------------------------- */
/*  shootingobject.cpp                                        */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		当たり判定付きスプライト
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.14.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

/*-------------------------------*/
/* include                       */
/*-------------------------------*/
#include "shootingobject.h"

/*-------------------------------*/
/* define                        */
/*-------------------------------*/

/*-------------------------------*/
/* global value                  */
/*-------------------------------*/

/*-------------------------------*/
/* local routine                 */
/*-------------------------------*/

/*-------------------------------*/
/* implementatiion               */
/*-------------------------------*/

/*------------------------------------------------------*/
/* constructor/destructor                               */
/*------------------------------------------------------*/

/**
 * コンストラクタ
 */
ShootingObject::ShootingObject()
{
  /* --- 初期化 */
  m_GrazeEnable = false;
  m_HitEnable = false;
  m_HitR = 0.0;
  m_HitPow = 0.0;
  m_GrazeR = 0.0;
  m_GrazePow = 0.0;
}


/**
 * デストラクタ(後始末)
 */
ShootingObject::~ShootingObject()
{
}



/*------------------------------------------------------*/
/* interface                                            */
/*------------------------------------------------------*/

/* ----------------------------------------- */
/* --- SetHitSize() */
/**
 * このオブジェクトの当たり判定半径をセットする
 *
 * @param r [in] オブジェクト当たり判定の半径
 * @return 無し
 *
 */
void ShootingObject::SetHitSize(float r)
{
  m_HitR = r;
  m_HitPow = r * r;
}


/* ----------------------------------------- */
/* --- SetGrazeSize() */
/**
 * このオブジェクトのかすり判定半径をセットする
 *
 * @param r [in] オブジェクトかすり判定の半径
 * @return 無し
 *
 */
void ShootingObject::SetGrazeSize(float r)
{
  m_GrazeR = r;
  m_GrazePow = r * r;
}

/* ----------------------------------------- */
/* --- CheckCollision() */
/**
 * オブジェクト同士の当たり判定
 * 大まかに矩形で判別した後近そうなら円の衝突判定
 *
 * @return 問題なく表示処理完了したら true 失敗で false
 *
 */
bool ShootingObject::CheckCollision(ShootingObject* obj)
{
  float  dx, dy, dr;
  bool quick;

  /* --- 判定有効なオブジェクトでなかったら終了 */
  if (m_HitEnable == false) {
    return(false);
  }
  if (obj->m_HitEnable == false) {
    return(false);
  }
  quick = true;
  dr = m_HitR + obj->m_HitR;
  dx = m_PosX - obj->m_PosX;
  dy = m_PosY - obj->m_PosY;
  /* --- 簡易判定その1 */
  if (dx < 0) {
    dx *= (-1.0);
    if (dx > dr) {
      quick = false;
    }
  }
  else {
    if (dx > dr) {
      quick = false;
    }
  }
  /* - x の開きが大きい、さっさと終了 */
  if (quick == false) {
    return(false);
  }
  /* --- 簡易判定その2 */
  if (dy < 0) {
    dy *= (-1.0);
    if (dy > dr) {
      quick = false;
    }
  }
  else {
    if (dy > dr) {
      quick = false;
    }
  }
  /* - y の開きが大きい、さっさと終了 */
  if (quick == false) {
    return(false);
  }
  /* --- 普通に円の距離で判定 */
  dx *= dx;
  dy *= dy;
  dr *= dr;
  dx += dy;
  if (dr < dx) {
    return(false);
  }

  return(true);
}


/* ----------------------------------------- */
/* --- CheckGraze() */
/**
 * オブジェクトのかすり判定
 * 相手の当たり距離とこちらのかすり距離で判定
 *
 * @return 問題なく表示処理完了したら true 失敗で false
 *
 */
bool ShootingObject::CheckGraze(ShootingObject* obj)
{
  float  dx, dy, dr;
  bool quick;

  /* --- 判定有効なオブジェクトでなかったら終了 */
  if (m_GrazeEnable == false) {
    return(false);
  }
  if (obj->m_GrazeEnable == false) {
    return(false);
  }

  quick = true;
  dr = m_GrazeR + obj->m_GrazeR;
  dx = m_PosX - obj->m_PosX;
  dy = m_PosY - obj->m_PosY;
  /* --- 簡易判定その1 */
  if (dx < 0) {
    dx *= (-1.0);
    if (dx > dr) {
      quick = false;
    }
  }
  else {
    if (dx > dr) {
      quick = false;
    }
  }
  /* - x の開きが大きい、さっさと終了 */
  if (quick == false) {
    return(false);
  }
  /* --- 簡易判定その2 */
  if (dy < 0) {
    dy *= (-1.0);
    if (dy > dr) {
      quick = false;
    }
  }
  else {
    if (dy > dr) {
      quick = false;
    }
  }
  /* - y の開きが大きい、さっさと終了 */
  if (quick == false) {
    return(false);
  }
  /* --- 普通に円の距離で判定 */
  dx *= dx;
  dy *= dy;
  dr *= dr;
  dx += dy;
  if (dr < dx) {
    return(false);
  }

  return(true);
}

/*------------------------------------------------------*/
/* local work                                           */
/*------------------------------------------------------*/

