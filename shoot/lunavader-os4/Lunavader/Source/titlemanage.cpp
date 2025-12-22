/* ---------------------------------------------------------- */
/*  titlemanage.cpp                                           */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		タイトル画面を表示する
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.19.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include "titlemanage.h"

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
TitleManage::TitleManage()
{
  int  i;

  /* --- 初期化 */
  m_Step = 0;
  m_Timer = 0;
  m_DoStart = false;
  /* --- スプライト */
  for(i=0; i<SPRITENUM; i++) {
    sprite[i] = new SpriteItem;
  }
}


/**
 * デストラクタ(後始末)
 */
TitleManage::~TitleManage()
{
  int i;

  for(i=0; i<SPRITENUM; i++) {
    delete  sprite[i];
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
void TitleManage::Init()
{

  m_Step = 0;
  m_Timer = 0;

  /* - オブジェクトの初期化 その1 */
  sprite[0]->m_PosX = 320;
  sprite[0]->m_PosY = 240;
  sprite[0]->m_SizeW = 64;
  sprite[0]->m_SizeH = 64;
  sprite[0]->m_Priority = BS_DEPTH_TITLE;
  sprite[0]->m_Blend = 1.0;
  sprite[0]->m_Zoom = 5.5;
  sprite[0]->m_TexU = 0;
  sprite[0]->m_TexV = 448;
  sprite[0]->m_TexW = 64;
  sprite[0]->m_TexH = 64;
  sprite[0]->m_RollZ = 0.0;
  sprite[0]->m_PosCenter = true;
  sprite[0]->m_Working = true;
  sprite[0]->m_Visible = true;
  /* - オブジェクトの初期化 タイトル */
  sprite[1]->m_PosX = 16;
  sprite[1]->m_PosY = -64;
  sprite[1]->m_SizeW = 160;
  sprite[1]->m_SizeH = 32;
  sprite[1]->m_Priority = BS_DEPTH_TITLE - 1;
  sprite[1]->m_Blend = 1.0;
  sprite[1]->m_Zoom = 1.0;
  sprite[1]->m_TexU = 0;
  sprite[1]->m_TexV = 256;
  sprite[1]->m_TexW = 160;
  sprite[1]->m_TexH = 32;
  sprite[1]->m_RollZ = 0.0;
  sprite[1]->m_PosCenter = false;
  sprite[1]->m_Working = true;
  sprite[1]->m_Visible = true;
  /* - オブジェクトの初期化 うどんげ */
  sprite[2]->m_PosX = 640;
  sprite[2]->m_PosY = 80;
  sprite[2]->m_SizeW = 352/2;
  sprite[2]->m_SizeH = 416/2;
  sprite[2]->m_Priority = BS_DEPTH_TITLE - 2;
  sprite[2]->m_Blend = 1.0;
  sprite[2]->m_Zoom = 1.0;
  sprite[2]->m_TexU = 80;
  sprite[2]->m_TexV = 288;
  sprite[2]->m_TexW = 352/2;
  sprite[2]->m_TexH = 416/2;
  sprite[2]->m_RollZ = 0.0;
  sprite[2]->m_PosCenter = false;
  sprite[2]->m_Working = true;
  sprite[2]->m_Visible = true;
  /* - オブジェクトの初期化 うどんげあじ */
  sprite[3]->m_PosX = 32;
  sprite[3]->m_PosY = 80;
  sprite[3]->m_SizeW = 96;
  sprite[3]->m_SizeH = 16;
  sprite[3]->m_Priority = BS_DEPTH_TITLE - 3;
  sprite[3]->m_Blend = 1.0;
  sprite[3]->m_Zoom = 1.0;
  sprite[3]->m_TexU = 160;
  sprite[3]->m_TexV = 256;
  sprite[3]->m_TexW = 96;
  sprite[3]->m_TexH = 16;
  sprite[3]->m_RollZ = 0.0;
  sprite[3]->m_PosCenter = false;
  sprite[3]->m_Working = true;
  sprite[3]->m_Visible = false;
  /* - オブジェクトの初期化 Push Button */
  sprite[4]->m_PosX = 64;
  sprite[4]->m_PosY = 320;
  sprite[4]->m_SizeW = 80;
  sprite[4]->m_SizeH = 16;
  sprite[4]->m_Priority = BS_DEPTH_TITLE - 4;
  sprite[4]->m_Blend = 1.0;
  sprite[4]->m_Zoom = 1.0;
  sprite[4]->m_TexU = 0;
  sprite[4]->m_TexV = 288;
  sprite[4]->m_TexW = 80;
  sprite[4]->m_TexH = 16;
  sprite[4]->m_RollZ = 0.0;
  sprite[4]->m_PosCenter = false;
  sprite[4]->m_Working = true;
  sprite[4]->m_Visible = false;

}


/* ----------------------------------------- */
/* --- Tick() */
/**
 * 背景の動作管理
 *
 * @return 動作中は true、終了したら false
 *
 */
bool TitleManage::Tick(unsigned long keyin)
{
  bool  result;
  int  n;
  m_DoStart = false;
  result = true;

  switch(m_Step) {
  case 0:
    m_Timer = 90;
    m_Step = 1;
    break;

  case 1:
    /* ボタンスキップ */
    if ((keyin & BS_INPUT_BUTTON1) != 0) {
      m_Step = 2;
    }
    /* オブジェのスクロールイン */
    sprite[1]->m_PosY = 16 -
      (80.0 * ((float)m_Timer) / 90.0);
    sprite[2]->m_PosX = (640.0 - 352) + 
      (352.0 * ((float)m_Timer) / 90.0);
    m_Timer -= 1;
    if (m_Timer == 0) {
      m_Step = 2;
    }
    break;

  case 2: 
    sprite[1]->m_PosY = 16;
    sprite[2]->m_PosX = (640.0 - 352.0);
    sprite[3]->m_Visible = true;
    sprite[4]->m_Visible = true;
    m_Timer = 0;
    m_Step = 3;
    break;

  case 3:
    /* ボタンスキップ */
    if ((keyin & BS_INPUT_BUTTON1) != 0) {
      m_DoStart = true;
      m_Timer = 90;
      m_Step = 4;
    }
    m_Timer += 1;
    n = (m_Timer / 30) % 2;
    if (n == 0) {
      sprite[4]->m_Visible = true;
    }
    else {
      sprite[4]->m_Visible = false;
    }
    break;

  case 4:
    /* 点滅 */
    n = (m_Timer / 3) % 2;
    if (n == 0) {
      sprite[4]->m_Visible = true;
    }
    else {
      sprite[4]->m_Visible = false;
    }
    m_Timer -= 1;
    if (m_Timer == 0) {
      m_Step = 5;
      result = false;
    }
    break;

  case 5:
    result = false;
    break;
  }

  return(result);
}

/* ----------------------------------------- */
/* --- Tick() */
/**
 * スタートボタン押し下げ効果音のタイミング
 *
 * @return 常に true
 *
 */
bool TitleManage::Start()
{
  return(m_DoStart);
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
bool TitleManage::Display()
{
  int i;

  for(i=0; i<SPRITENUM; i++) {
    sprite[i]->Display();
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
void TitleManage::SetLunaSprite(LSPRITE sp_handle)
{
  int i;

  m_LunaSprite = sp_handle;
  for(i=0; i<SPRITENUM; i++) {
    sprite[i]->SetLunaSprite(sp_handle);
  }
  
}






/*------------------------------------------------------*/
/* local work                                           */
/*------------------------------------------------------*/

