/* ---------------------------------------------------------- */
/*  myshipmanage.cpp                                          */
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

/*-------------------------------*/
/* include                       */
/*-------------------------------*/
#include "myshipmanage.h"

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
MyShipManage::MyShipManage()
{
  /* --- 初期化 */
  // m_ShotMan = null;
  m_IsHit = false;
  m_Wait = 0;
  m_Timer = 0;
  m_Bank = 0;
}


/**
 * デストラクタ(後始末)
 */
MyShipManage::~MyShipManage()
{
}



/*------------------------------------------------------*/
/* interface                                            */
/*------------------------------------------------------*/

/* ----------------------------------------- */
/* --- SetMyShotMan() */
/**
 * 自機弾の管理インスタンスを受け取る
 *
 * @param shot [in] 自機弾のマネージャインスタンス
 * @return 無し
 *
 */
#if 0
void MyShipManage::SetMyShotMan(MyShotManage* shot)
{
  m_MyShotMan = shot;
}
#endif


/* ----------------------------------------- */
/* --- Init() */
/**
 * 初期化
 * ゲーム開始時に一回だけコール
 *
 * @return 無し
 *
 */
void MyShipManage::Init()
{
  /* --- オブジェクトの初期化 */
  m_SizeW = 16;
  m_SizeH = 24;
  m_Priority = BS_DEPTH_MYSHIP;
  m_Blend = 1.0;
  m_Zoom = 1.0;
  m_TexU = 0;
  m_TexV = 24 * SIENSIDE;
  m_TexW = 16;
  m_TexH = 24;
  m_PosCenter = true;
  m_Working = true;
  m_Visible = true;

  /* --- 当たり判定 */
  SetHitSize(1.0);
  SetGrazeSize(4.0);
  m_HitEnable = true;
  m_GrazeEnable = true;

  /* --- 位置初期化 */
  m_PosX = GAMEFIELD_W / 2;
  m_PosY = GAMEFIELD_H - 8 - (m_SizeH / 2);
  
}


/* ----------------------------------------- */
/* --- SetHitState() */
/**
 * 敵の弾を食らったらここからその旨を教えてやってください
 *
 * @param hit [in] 弾にあたったなら true
 * @return 初めて当たったなら true (SE用のリターン)
 *
 */
bool MyShipManage::SetHitState(bool hit)
{
  bool hitnow;

  hitnow = false;
  if (hit) {
    m_IsHit = hit;
    /* -- 弾くらい SE 用リターン */
    hitnow = true;
  }

  return(hitnow);
}


/* ----------------------------------------- */
/* --- GetHitState() */
/**
 * 敵の弾を食らい済みかどうかを得る
 *
 * @return 弾を食らった後なら true 通常状態で false
 *
 */
bool MyShipManage::GetHitState()
{
  return(m_IsHit);
}


/* ----------------------------------------- */
/* --- Tick() */
/**
 *  自機移動管理
 * 毎フレームコールする
 *
 * @param inkey [in] プレイヤー
 * @return 無し
 *
 */
bool MyShipManage::Tick(unsigned long inkey,
			unsigned long inkey_triger)
{
  m_Timer += 1;

  /* --- ヒット当たりでゲームオーバーまでの余韻 */
  if (m_IsHit == true) {
    m_Wait += 1;
    if (m_Wait >= 45) {
      /* -- ゲーム終了 */
      return(false);
    }
    /* -- もうちょっとウェイト */
    return(true);
  }

  /* --- ショット判定 */
  if (inkey_triger & BS_INPUT_BUTTON1) {
    /* -- MyShotManage を確認、既にいたら打てない */
    /* ===== */
  }

  /* --- 移動処理 */
  if (((inkey & BS_INPUT_LEFT) > 0) &&
      ((inkey & BS_INPUT_RIGHT) > 0)) {
    /* -- 両方押しは無効にする */
    /* 炎のコマ対策(嘘) */
    m_Bank = 0;
  }
  else if(inkey & BS_INPUT_LEFT) {
    /* -- 左移動 */
    if (m_PosX > 24.0) {
      m_PosX -= 4.0;
    }
  }
  else if(inkey & BS_INPUT_RIGHT) {
    /* -- 右移動 */
    if (m_PosX < (GAMEFIELD_W - 24.0)) {
      m_PosX += 4.0;
    }
  }

  return(true);
}





/*------------------------------------------------------*/
/* local work                                           */
/*------------------------------------------------------*/

