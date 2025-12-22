/* ---------------------------------------------------------- */
/*  panelmanage.cpp                                           */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		スコアパネル表示、管理クラス
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.13.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

/*-------------------------------*/
/* include                       */
/*-------------------------------*/
#include "panelmanage.h"

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
PanelManage::PanelManage()
{
  /* --- 初期化 */
  m_LunaSprite = 0;
  m_Score = 0;
  m_HighScore = 0;
  m_Graze = 0;
  m_Stage = 0;
  m_Timer = 0;

}


/**
 * デストラクタ(後始末)
 */
PanelManage::~PanelManage()
{
}



/*------------------------------------------------------*/
/* interface                                            */
/*------------------------------------------------------*/

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
void PanelManage::SetLunaSprite(LSPRITE sp_handle)
{
  int  i;

  m_LunaSprite = sp_handle;
  for(i=0; i<BS_SPBUF_PANEL; i++) {
    m_PanelSprite[i].SetLunaSprite(sp_handle);
  }
}

/* ----------------------------------------- */
/* --- SetScore() */
/**
 * スコアとして表示する値をセットする
 *
 * @param score [in] スコア
 * @return 無し
 *
 */
void  PanelManage::SetScore(int score)
{
  m_Score = score;
}

/* ----------------------------------------- */
/* --- SetHighScore() */
/**
 * ハイスコアとして表示する値をセットする
 *
 * @param hiscore [in] ハイスコア
 * @return 無し
 *
 */
void  PanelManage::SetHighScore(int hiscore)
{
  m_HighScore = hiscore;
}

/* ----------------------------------------- */
/* --- SetGraze() */
/**
 * かすりポイントとして表示する値をセットする
 *
 * @param graze [in] かすりポイント
 * @return 無し
 *
 */
void  PanelManage::SetGraze(int graze)
{
  m_Graze = graze;
}

/* ----------------------------------------- */
/* --- SetStage() */
/**
 * ステージ数として表示する値をセットする
 *
 * @param stage [in] ステージ
 * @return 無し
 *
 */
void  PanelManage::SetStage(int stage)
{
  m_Stage = stage;
}


/* ----------------------------------------- */
/* --- SetGameOver() */
/**
 * ゲームオーバーを表示する
 *
 * @param gameover [in] 表示フラグ
 * @return 無し
 *
 */
void  PanelManage::SetGameOver(bool gameover)
{
  m_GameOver = gameover;
}


/* ----------------------------------------- */
/* --- Tick() */
/**
 * 表示準備としてスプライトを設定する(実際に表示は行わない)
 * なにかパネル内でアニメーションがあるならここで制御
 * (今回はない)
 *
 * @return 常に true
 *
 */
bool  PanelManage::Tick()
{
  /* --- パネル表示 */
  m_PanelSprite[0].m_PosX = PANELPOSX;
  m_PanelSprite[0].m_PosY = PANELPOSY;
  m_PanelSprite[0].m_SizeW = 96;
  m_PanelSprite[0].m_SizeH = 240;
  m_PanelSprite[0].m_Priority = BS_DEPTH_PANEL;
  m_PanelSprite[0].m_Blend = 1.0;
  m_PanelSprite[0].m_TexU = 416;
  m_PanelSprite[0].m_TexV = 0;
  m_PanelSprite[0].m_TexW = 96;
  m_PanelSprite[0].m_TexH = 240;
  m_PanelSprite[0].m_RollX = 0.0;
  m_PanelSprite[0].m_RollY = 0.0;
  m_PanelSprite[0].m_RollZ = 0.0;
  m_PanelSprite[0].m_Working = true;
  m_PanelSprite[0].m_Visible = true;
  m_PanelSprite[0].m_PosCenter = false;

  /* --- スコア表示 */
  m_PanelSprite[1].m_PosX = PANELPOSX + PANELSCOREX;
  m_PanelSprite[1].m_PosY = PANELPOSY + PANELSCOREY;
  m_PanelSprite[1].m_SizeW = 32;
  m_PanelSprite[1].m_SizeH = 8;
  m_PanelSprite[1].m_Priority = BS_DEPTH_PANEL;
  m_PanelSprite[1].m_Blend = 1.0;
  m_PanelSprite[1].m_TexU = 176;
  m_PanelSprite[1].m_TexV = 8;
  m_PanelSprite[1].m_TexW = 32;
  m_PanelSprite[1].m_TexH = 8;
  m_PanelSprite[1].m_RollX = 0.0;
  m_PanelSprite[1].m_RollY = 0.0;
  m_PanelSprite[1].m_RollZ = 0.0;
  m_PanelSprite[1].m_Working = true;
  m_PanelSprite[1].m_Visible = true;
  dec_display_fill(m_Score, 8, 2,
		   (PANELPOSX + PANELSCOREX),
		   (PANELPOSY + PANELSCOREY + 18));
  /* --- ハイスコア表示 */
  m_PanelSprite[10].m_PosX = PANELPOSX + PANELHISCOREX;
  m_PanelSprite[10].m_PosY = PANELPOSY + PANELHISCOREY;
  m_PanelSprite[10].m_SizeW = 40;
  m_PanelSprite[10].m_SizeH = 8;
  m_PanelSprite[10].m_Priority = BS_DEPTH_PANEL;
  m_PanelSprite[10].m_Blend = 1.0;
  m_PanelSprite[10].m_TexU = 176;
  m_PanelSprite[10].m_TexV = 16;
  m_PanelSprite[10].m_TexW = 40;
  m_PanelSprite[10].m_TexH = 8;
  m_PanelSprite[10].m_RollX = 0.0;
  m_PanelSprite[10].m_RollY = 0.0;
  m_PanelSprite[10].m_RollZ = 0.0;
  m_PanelSprite[10].m_Working = true;
  m_PanelSprite[10].m_Visible = true;
  m_PanelSprite[10].m_PosCenter = false;
  dec_display_fill(m_HighScore, 8, 11,
		   (PANELPOSX + PANELHISCOREX),
		   (PANELPOSY + PANELHISCOREY + 18));
  /* --- かすりポイント表示 */
  m_PanelSprite[20].m_PosX = PANELPOSX + PANELGRAZEX;
  m_PanelSprite[20].m_PosY = PANELPOSY + PANELGRAZEY;
  m_PanelSprite[20].m_SizeW = 32;
  m_PanelSprite[20].m_SizeH = 8;
  m_PanelSprite[20].m_Priority = BS_DEPTH_PANEL;
  m_PanelSprite[20].m_Blend = 1.0;
  m_PanelSprite[20].m_TexU = 176;
  m_PanelSprite[20].m_TexV = 24;
  m_PanelSprite[20].m_TexW = 32;
  m_PanelSprite[20].m_TexH = 8;
  m_PanelSprite[20].m_RollX = 0.0;
  m_PanelSprite[20].m_RollY = 0.0;
  m_PanelSprite[20].m_RollZ = 0.0;
  m_PanelSprite[20].m_Working = true;
  m_PanelSprite[20].m_Visible = true;
  m_PanelSprite[20].m_PosCenter = false;
  dec_display(m_Graze, 6, 21,
	      (PANELPOSX + PANELGRAZEX),
	      (PANELPOSY + PANELGRAZEY + 18));
  /* --- ステージ表示 */
  m_PanelSprite[30].m_PosX = PANELPOSX + PANELSTAGEX;
  m_PanelSprite[30].m_PosY = PANELPOSY + PANELSTAGEY;
  m_PanelSprite[30].m_SizeW = 32;
  m_PanelSprite[30].m_SizeH = 8;
  m_PanelSprite[30].m_Priority = BS_DEPTH_PANEL;
  m_PanelSprite[30].m_Blend = 1.0;
  m_PanelSprite[30].m_TexU = 176;
  m_PanelSprite[30].m_TexV = 32;
  m_PanelSprite[30].m_TexW = 32;
  m_PanelSprite[30].m_TexH = 8;
  m_PanelSprite[30].m_RollX = 0.0;
  m_PanelSprite[30].m_RollY = 0.0;
  m_PanelSprite[30].m_RollZ = 0.0;
  m_PanelSprite[30].m_Working = true;
  m_PanelSprite[30].m_Visible = true;
  m_PanelSprite[30].m_PosCenter = false;
  dec_display(m_Stage, 6, 31,
	      (PANELPOSX + PANELSTAGEX),
	      (PANELPOSY + PANELSTAGEY + 18));
  /* --- ゲームオーバー表示 */
  m_PanelSprite[38].m_PosX = 224;
  m_PanelSprite[38].m_PosY = 240;
  m_PanelSprite[38].m_PosCenter = true;
  m_PanelSprite[38].m_SizeW = 100;
  m_PanelSprite[38].m_SizeH = 16;
  m_PanelSprite[38].m_Priority = BS_DEPTH_PANEL;
  m_PanelSprite[38].m_Blend = 1.0;
  m_PanelSprite[38].m_TexU = 176;
  m_PanelSprite[38].m_TexV = 42;
  m_PanelSprite[38].m_TexW = 100;
  m_PanelSprite[38].m_TexH = 16;
  m_PanelSprite[38].m_RollX = 0.0;
  m_PanelSprite[38].m_RollY = 0.0;
  m_PanelSprite[38].m_RollZ = 0.0;
  m_PanelSprite[38].m_Working = true;
  m_PanelSprite[38].m_Visible = m_GameOver;
  m_PanelSprite[38].m_PosCenter = false;

  /* --- おしまい */
  m_Timer += 1;
  return(true);
}

/* ----------------------------------------- */
/* --- Display() */
/**
 * スプライトを表示バッファにセットする
 *
 * @return 無し
 *
 */
void  PanelManage::Display()
{
  int  i;

  for(i=0; i<BS_SPBUF_PANEL; i++) {
    m_PanelSprite[i].Display();
  }
}



/*------------------------------------------------------*/
/* local work                                           */
/*------------------------------------------------------*/

/* ----------------------------------------- */
/* --- dec_display() */
/**
 * 10進数表示を行う
 * 数字がない上位桁は表示無しの左詰めになる
 *
 * @param num [in] 表示する値
 * @param size [in] 表示する最大桁数
 * @param sprite [in] 使用するスプライトワークの先頭番号
 * @param x [in] 表示するパネル内位置 X
 * @param y [in] 表示するパネル内位置 Y
 * @return 無し
 *
 */
void  PanelManage::dec_display(int num,
			       int size,
			       int sprite,
			       int x,
			       int y)
{
  int i, count;
  int n, c;
  bool  start;
  char* dec;

  dec = new char[size];
  n = num;
  for(i=0; i<size; i++) {
    c = n % 10;
    dec[size - 1 - i] = c;
    n = n / 10;
    m_PanelSprite[sprite+i].m_Working = false;
    m_PanelSprite[sprite+i].m_Visible = false;
  }

  start = false;
  count = 0;
  for(i=0; i<size; i++) {
    if ((dec[i] > 0) || (i == (size - 1))) {
      start = true;
    }
    if (start == true) {
      m_PanelSprite[sprite+count].m_PosX = x + (count * 16);
      m_PanelSprite[sprite+count].m_PosY = y;
      m_PanelSprite[sprite+count].m_SizeW = 9;
      m_PanelSprite[sprite+count].m_SizeH = 8;
      m_PanelSprite[sprite+count].m_Priority = BS_DEPTH_PANELITEM;
      m_PanelSprite[sprite+count].m_Blend = 1.0;
      m_PanelSprite[sprite+count].m_TexU = 176+(9 * dec[i]);
      m_PanelSprite[sprite+count].m_TexV = 0;
      m_PanelSprite[sprite+count].m_TexW = 9;
      m_PanelSprite[sprite+count].m_TexH = 8;
      m_PanelSprite[sprite+count].m_RollX = 0.0;
      m_PanelSprite[sprite+count].m_RollY = 0.0;
      m_PanelSprite[sprite+count].m_RollZ = 0.0;
      m_PanelSprite[sprite+count].m_Working = true;
      m_PanelSprite[sprite+count].m_Visible = true;
      m_PanelSprite[sprite+count].m_PosCenter = false;
      count += 1;
    }
  }

  delete dec;
}

/* ----------------------------------------- */
/* --- dec_display_fill() */
/**
 * 10進数表示を行う
 * 数字がない上位桁は 0 になり常に最大桁数分の表示になる
 *
 * @param num [in] 表示する値
 * @param size [in] 表示する最大桁数
 * @param sprite [in] 使用するスプライトワークの先頭番号
 * @param x [in] 表示するパネル内位置 X
 * @param y [in] 表示するパネル内位置 Y
 * @return 無し
 *
 */
void  PanelManage::dec_display_fill(int num,
				    int size,
				    int sprite,
				    int x,
				    int y)
{
  int i;
  int n, c;

  n = num;
  for(i=0; i<size; i++) {
    c = n % 10;
    m_PanelSprite[sprite+i].m_PosX = x + ((size - 1 - i) * 16);
    m_PanelSprite[sprite+i].m_PosY = y;
    m_PanelSprite[sprite+i].m_SizeW = 9;
    m_PanelSprite[sprite+i].m_SizeH = 8;
    m_PanelSprite[sprite+i].m_Priority = BS_DEPTH_PANELITEM;
    m_PanelSprite[sprite+i].m_Blend = 1.0;
    m_PanelSprite[sprite+i].m_TexU = 176+(9 * c);
    m_PanelSprite[sprite+i].m_TexV = 0;
    m_PanelSprite[sprite+i].m_TexW = 9;
    m_PanelSprite[sprite+i].m_TexH = 8;
    m_PanelSprite[sprite+i].m_RollX = 0.0;
    m_PanelSprite[sprite+i].m_RollY = 0.0;
    m_PanelSprite[sprite+i].m_RollZ = 0.0;
    m_PanelSprite[sprite+i].m_Working = true;
    m_PanelSprite[sprite+i].m_Visible = true;
    m_PanelSprite[sprite+i].m_PosCenter = false;
    n = n / 10;
  }
}



