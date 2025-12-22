/* ---------------------------------------------------------- */
/*  bulletbase.cpp                                            */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		弾とかの飛んでいくオブジェクトクラス
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.15.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

/*-------------------------------*/
/* include                       */
/*-------------------------------*/
#include "bulletbase.h"

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
BulletBase::BulletBase()
{
  /* --- 初期化 */
  m_EnemyObject = NULL;
  m_Direction = 0.0;
  m_DirectionAdd = 0.0;
  m_Speed = 1.0;
  m_SpeedR = 0.0;
  m_Accelerator = 0.0;
  m_Accelerator = 0.0;
  m_Limit = 0.0;
  m_LimitR = 0.0;
  m_AddRoll = 0.0;
  m_Timer = 0;
  m_LifeTime = 0;
  m_ListPrev = NULL;
  m_ListNext = NULL;
}


/**
 * デストラクタ(後始末)
 */
BulletBase::~BulletBase()
{
}



/*------------------------------------------------------*/
/* interface                                            */
/*------------------------------------------------------*/

/* ----------------------------------------- */
/* --- SetHitSize() */
/**
 * オブジェクトを1フレーム分移動する
 *
 * @return true ならオブジェクト生存中、false で処理終了
 *
 */
bool BulletBase::Tick()
{
  bool  alive;
  float  dx, dy;

  alive = true;

  /* --- 加速処理 */
  /* - 進行速度 */
  if (m_Speed < m_Limit) {
    m_Speed += m_Accelerator;
    if (m_Speed < 0) {
      m_Speed = 0;
    }
  }
  /* - 進行方向変化 */
#if 0
  /* なにやらPSPで演算エラーを起こすので */
  m_SpeedR += m_AcceleratorR;
  if (m_DirectionAdd >= 0) {
    if (m_DirectionAdd < m_LimitR) {
      m_DirectionAdd += m_SpeedR;
    }
  }
  else {
    if (m_DirectionAdd > m_LimitR) {
      m_DirectionAdd += m_SpeedR;
    }
  }
#endif

  /* - キャラクター回転 */
  m_RollZ = (float)((int)(m_RollZ + m_AddRoll) % 65536);

  /* --- 進行方向に1移動 */
  dx = LunaMath::Cos(((long)(m_Direction + m_DirectionAdd) % 65536));
  dy = LunaMath::Sin(((long)(m_Direction + m_DirectionAdd) % 65536));
  dx *= m_Speed;
  dy *= m_Speed;
  m_PosX += dx;
  m_PosY += dy;

  /* --- 表示領域はみ出しチェック */
  if ((m_PosX + (m_SizeW / 2.0)) <= 0) {
    alive = false;
  }
  if ((m_PosX - (m_SizeW / 2.0)) >= GAMEFIELD_W) {
    alive = false;
  }
  if ((m_PosY + (m_SizeH / 2.0)) <= 0) {
    alive = false;
  }
  if ((m_PosY - (m_SizeH / 2.0)) >= GAMEFIELD_H) {
    alive = false;
  }

  /* --- 時限カウンター */
  if (m_LifeTime > 0) {
    m_LifeTime -= 1;
  }
  else {
    m_LifeTime = 0;
    alive = false;
  }

  /* --- おしまい */
  return(alive);
}

/*------------------------------------------------------*/
/* local work                                           */
/*------------------------------------------------------*/

