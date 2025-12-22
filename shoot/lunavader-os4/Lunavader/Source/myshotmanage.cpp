/* ---------------------------------------------------------- */
/*  myshotmanage.cpp                                          */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		自機の弾管理クラス
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
#include "myshotmanage.h"

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
MyShotManage::MyShotManage()
{
  /* --- 初期化 */
  m_Execute = false;
  m_State = 0;
  m_Timer = 0;
}


/**
 * デストラクタ(後始末)
 */
MyShotManage::~MyShotManage()
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
bool MyShotManage::Tick()
{
  bool  result;

  if (m_Timer == 0) {
    /* --- スーパークラスの Tick 呼び出し */
    result = BulletBase::Tick();
    m_Execute = result;
    if (result == false) {
      m_Working = false;
      m_Visible = false;
      m_HitEnable = false;
    }
  }
  else {
    m_Timer -= 1;
    if (m_Timer <= 0) {
      m_Execute = false;
      m_Working = false;
      m_Visible = false;
      m_HitEnable = false;
      result = false;
    }
    else {
      result = true;
    }
  }

  return(result);
}

/* ----------------------------------------- */
/* --- Shoot() */
/**
 * 発射リクエスト
 *
 * @return true なら発射処理完了、false なら処理中
 *
 */
bool MyShotManage::Shoot(MyShipManage* ship)
{
  bool  alive;

  alive = false;

  if (m_Execute == false) {
    /* --- 自機弾オブジェクトの生成 */
    /* - オブジェクトの初期化 */
    m_SizeW = 8;
    m_SizeH = 16;
    m_Priority = BS_DEPTH_MYSHOT;
    m_Blend = 1.0;
    m_Zoom = 1.0;
    m_TexU = 112 + (8 * SIENSIDE);
    m_TexV = 0;
    m_TexW = 8;
    m_TexH = 16;
    m_RollZ = 0.0;
    m_PosCenter = true;
    m_Working = true;
    m_Visible = true;
    /* - 当たり判定 */
    SetHitSize(4.0);
    SetGrazeSize(4.0);
    m_HitEnable = true;
    /* - 位置初期化 */
    m_PosX = ship->m_PosX;
    m_PosY = ship->m_PosY - 4;
    /* - 移動速度 */
    m_Direction = (65536.0 / 4) * 3;
    m_DirectionAdd = 0.0;
    m_Speed = 1.0;
    m_SpeedR = 0.0;
    m_Accelerator = 0.2;
    m_AcceleratorR = 0.0;
    m_Limit = 20.0;
    m_LimitR = 0.0;
    m_AddRoll = 0.0;
    m_LifeTime = 600;
    m_ListPrev = NULL;
    m_ListNext = NULL;
    /* - 実行中 */
    m_Execute = true;
    alive = true;
  }

  /* --- おしまい */
  return(alive);
}


/* ----------------------------------------- */
/* --- CanShoot() */
/**
 * 弾を発射する事が可能かどうかの確認
 *
 * @return true なら発射可能、false なら不可
 *
 */
bool MyShotManage::CanShoot()
{
  return(!m_Execute);
}

/* ----------------------------------------- */
/* --- SetState() */
/**
 * 弾に関する状態値のセット
 * 取り敢えず未使用だけれども、将来的に何かあるかもしれないので
 *
 * @param stat [in] セットする状態値
 * @return 無し
 *
 */
void MyShotManage::SetState(int stat)
{
  m_State = stat;
}

/* ----------------------------------------- */
/* --- SetState() */
/**
 * 弾に関する状態値を返す
 * 取り敢えず未使用だけれども、将来的に何かあるかもしれないので
 *
 * @return 状態値
 *
 */
int MyShotManage::GetState()
{
  return(m_State);
}

/* ----------------------------------------- */
/* --- SetWait() */
/**
 * 敵に当たった後しばらくのウェイトをかますための設定
 *
 * @param time [in] フリーズしている期間
 * @return 状態値
 *
 */
void  MyShotManage::SetWait(int time)
{
  m_Timer = time;
  m_Visible = false;
}


/*------------------------------------------------------*/
/* local work                                           */
/*------------------------------------------------------*/

