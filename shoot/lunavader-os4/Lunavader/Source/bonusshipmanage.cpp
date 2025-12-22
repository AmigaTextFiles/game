/* ---------------------------------------------------------- */
/*  bonusshipmanage.cpp                                          */
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

/*-------------------------------*/
/* include                       */
/*-------------------------------*/
#include "lunavader.h"
#include "basicsystem.h"
#include "bonusshipmanage.h"

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
BonusShipManage::BonusShipManage()
{
  /* --- 初期化 */
  m_Appear = false;
  m_Timer = 0;
  m_Charactor = 0;
  m_Score = 0;
}


/**
 * デストラクタ(後始末)
 */
BonusShipManage::~BonusShipManage()
{
}



/*------------------------------------------------------*/
/* interface                                            */
/*------------------------------------------------------*/

/* ----------------------------------------- */
/* --- Tick() */
/**
 * 毎フレームごとの作業
 *
 * @return true なら移動中、false なら停止中
 *
 */
bool BonusShipManage::Tick()
{
  bool  result;

  /* --- スーパークラスの Tick 呼び出し */
  result = BulletBase::Tick();
  m_Appear = result;
  if (result == false) {
    m_Working = false;
    m_Visible = false;
    m_HitEnable = false;
  }
  else {
    /* --- 2コマアニメーション */
    m_Timer += 1;
    m_TexU = 64 + (24 * ((m_Timer / 4) % 2));
  }

  return(result);
}

/* ----------------------------------------- */
/* --- Start() */
/**
 * 出撃リクエスト
 *
 * @return true なら発射処理完了、false なら処理中
 *
 */
bool BonusShipManage::Start()
{
  bool  alive;
  int  dir;

  alive = false;

  if (m_Appear == false) {
    /* --- ボーナス船オブジェクトの生成 */
    /* - 進行方向 */
    dir = LunaMath::Rand(0, 1);
    /* - オブジェクトの初期化 */
    m_SizeW = 24;
    m_SizeH = 24;
    m_Priority = BS_DEPTH_BONUSSHIP;
    m_Blend = 1.0;
    m_Zoom = 1.0;
    m_TexU = 64;
    m_TexV = 24 * m_Charactor;
    m_TexW = 24;
    m_TexH = 24;
    m_RollZ = 0.0;
    m_PosCenter = true;
    m_Working = true;
    m_Visible = true;
    /* - 当たり判定 */
    SetHitSize(16.0);
    SetGrazeSize(16.0);
    m_HitEnable = true;
    /* - 位置初期化 */
    if (dir) {
      m_PosX = 1;
      m_Direction = 0.0;
    }
    else {
      m_PosX = GAMEFIELD_W - 2;
      m_Direction = (65535.0 / 2);
    }
    m_PosY = 40;
    /* - 移動速度 */
    m_DirectionAdd = 0.0;
    m_Speed = 2.0;
    m_SpeedR = 0.0;
    m_Accelerator = 0.0;
    m_AcceleratorR = 0.0;
    m_Limit = 5.0;
    m_LimitR = 0.0;
    m_AddRoll = 0.0;
    m_LifeTime = 3600;
    /* - 実行中 */
    m_Timer = 0;
    m_Appear = true;
    alive = true;
  }

  /* --- おしまい */
  return(alive);
}


/* ----------------------------------------- */
/* --- GetState() */
/**
 * 現在出現中かどうかの確認
 *
 * @return true なら出撃中、false なら待機中
 *
 */
bool BonusShipManage::GetState()
{
  return(m_Appear);
}

/* ----------------------------------------- */
/* --- SetCharactor() */
/**
 * 表示するキャラクターを指定
 *
 * @param chr [in] キャラクター
 * @return なし
 *
 */
void BonusShipManage::SetCharactor(int chr)
{
  m_Charactor = chr;
  m_Appear = false;
  m_Working = false;
  m_Visible = false;
  m_HitEnable = false;
}

/* ----------------------------------------- */
/* --- SetScore() */
/**
 * 破壊したときのボーナス得点セット
 *
 * @param score [in] スコア
 * @return なし
 *
 */
void  BonusShipManage::SetScore(int score)
{
  m_Score = score;
}


/* ----------------------------------------- */
/* --- GetScore() */
/**
 * 破壊したときのボーナス得点
 *
 * @return スコア
 *
 */
int  BonusShipManage::GetScore()
{
  return(m_Score);
}


/* ----------------------------------------- */
/* --- CheckHit() */
/**
 * 自機弾が当たったかの判定
 *
 * @return スコア
 *
 */
bool BonusShipManage::CheckHit(ShootingObject *shot)
{
  bool result;

  result = CheckCollision(shot);
  if (result == true) {
    /* -- 弾が当たったら移動停止 */
    m_Working = false;
    m_Visible = false;
    m_HitEnable = false;
    m_Appear = false;
    /* -- 弾のほうも停止 */
    shot->m_Working = false;
    shot->m_Visible = false;
    shot->m_HitEnable = false;
  }

  return(result);
}


/*------------------------------------------------------*/
/* local work                                           */
/*------------------------------------------------------*/

