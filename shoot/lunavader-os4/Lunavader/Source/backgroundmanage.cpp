/* ---------------------------------------------------------- */
/*  backgroundmanage.cpp                                      */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		ゲーム中の背景を管理する
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
#include "basicsystem.h"
#include "backgroundmanage.h"

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
BackGroundManage::BackGroundManage()
{
  int  i;

  /* --- 初期化 */
  m_BackBlend = 0;
  /* --- スプライト */
  for(i=0; i<BACKGROUND_LAYER; i++) {
    bg[i] = new SpriteItem;
  }
}


/**
 * デストラクタ(後始末)
 */
BackGroundManage::~BackGroundManage()
{
  int i;

  for(i=0; i<BACKGROUND_LAYER; i++) {
    delete  bg[i];
  }
}



/*------------------------------------------------------*/
/* interface                                            */
/*------------------------------------------------------*/

/* ----------------------------------------- */
/* --- Init() */
/**
 * 背景スプライトの初期化
 *
 * @return 常に true
 *
 */
void BackGroundManage::Init()
{
  /* - オブジェクトの初期化 その1 */
  bg[0]->m_PosX = GAMEFIELD_W / 2;
  bg[0]->m_PosY = GAMEFIELD_H / 2;
  bg[0]->m_SizeW = 128;
  bg[0]->m_SizeH = 128;
  bg[0]->m_Priority = BS_DEPTH_BACKGROUND;
  bg[0]->m_Blend = 1.0;
  bg[0]->m_Zoom = 2.0;
  bg[0]->m_TexU = 0;
  bg[0]->m_TexV = 64;
  bg[0]->m_TexW = 128;
  bg[0]->m_TexH = 128;
  bg[0]->m_RollZ = 0.0;
  bg[0]->m_PosCenter = true;
  bg[0]->m_Working = true;
  bg[0]->m_Visible = true;
  /* - オブジェクトの初期化 その2 */
  bg[1]->m_PosX = GAMEFIELD_W / 2;
  bg[1]->m_PosY = GAMEFIELD_H / 2;
  bg[1]->m_SizeW = 128;
  bg[1]->m_SizeH = 128;
  bg[1]->m_Priority = BS_DEPTH_BACKGROUND + 1;
  bg[1]->m_Blend = 0.0;
  bg[1]->m_Zoom = 3.0;
  bg[1]->m_TexU = 128;
  bg[1]->m_TexV = 64;
  bg[1]->m_TexW = 128;
  bg[1]->m_TexH = 128;
  bg[1]->m_RollZ = 0.0;
  bg[1]->m_PosCenter = true;
  bg[1]->m_Working = true;
  bg[1]->m_Visible = true;

}


/* ----------------------------------------- */
/* --- Tick() */
/**
 * 背景の動作管理
 *
 * @return 常に true
 *
 */
bool BackGroundManage::Tick()
{
  int  roll;

  /* --- 背景回転 */
  roll = (int)bg[1]->m_RollZ;
  roll = (roll + 100) % 65536;
  bg[1]->m_RollZ = (float)roll;  
  /* --- 透明度変更 */
  if (bg[1]->m_Blend < m_BackBlend) {
    bg[1]->m_Blend += 0.01;
  }
  else {
    bg[1]->m_Blend -= 0.01;
  }

  return(true);
}


/* ----------------------------------------- */
/* --- Display() */
/**
 * スプライトの表示処理
 * パラメータに従ってスプライトプリミティブを LunaSprite に
 * 登録する
 *
 * @return 問題なく表示処理完了したら true 失敗で false
 *
 */
bool BackGroundManage::Display()
{
  int i;

  for(i=0; i<BACKGROUND_LAYER; i++) {
    bg[i]->Display();
  }

  return(true);
}


/* ----------------------------------------- */
/* --- SetLunaSprite() */
/**
 * 上位で作成した LunaSprite ハンドルを渡してもらう
 * このクラスは渡されたハンドルのプリミティブとなる
 *
 * @param sp_handle [in] LunaSpriteハンドル
 * @return 無し
 *
 */
void BackGroundManage::SetLunaSprite(LSPRITE sp_handle)
{
  int i;

  m_LunaSprite = sp_handle;
  for(i=0; i<BACKGROUND_LAYER; i++) {
    bg[i]->SetLunaSprite(sp_handle);
  }
  
}


/* ----------------------------------------- */
/* --- SetBlend() */
/**
 * 背景上位面の半透明目標値を設定
 *
 * @param blend [in] 半透明目標値
 * @return 無し
 *
 */
void BackGroundManage::SetBlend(float  blend)
{
  m_BackBlend = blend;
}





/*------------------------------------------------------*/
/* local work                                           */
/*------------------------------------------------------*/

