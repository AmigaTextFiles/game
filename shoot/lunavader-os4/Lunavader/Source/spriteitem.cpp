/* ---------------------------------------------------------- */
/*  spriteitem.cpp                                          */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		スプライト管理クラス
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.12.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

/*-------------------------------*/
/* include                       */
/*-------------------------------*/
#include "spriteitem.h"

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
SpriteItem::SpriteItem()
{
  /* --- 初期化 */
  m_Working = false;
  m_Visible = false;
  m_PosX = 0.0;
  m_PosY = 0.0;
  m_SizeW = 0;
  m_SizeH = 0;
  m_Priority = 0;
  m_Blend = 1.0;
  m_Zoom = 1.0;
  m_TexU = 0;
  m_TexV = 0;
  m_TexW = 0;
  m_TexH = 0;
  m_RollZ = 0.0;
  m_RollX = 0.0;
  m_RollY = 0.0;
  m_TextureID = 0;
}


/**
 * デストラクタ(後始末)
 */
SpriteItem::~SpriteItem()
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
void SpriteItem::SetLunaSprite(LSPRITE sp_handle)
{
  m_LunaSprite = sp_handle;
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
bool SpriteItem::Display()
{
  TGameSprite  *obj;

  if (m_Visible == true) {
    /* --- オブジェクトポインタ受け取り */
    obj = TGameScreen_GetSpriteSerial(m_LunaSprite);
    obj->Texture = TGameScreen_GetTexture(m_LunaSprite, m_TextureID);

    /* --- オブジェクト表示設定 */
    obj->DispSw = TRUE;
    obj->x = ((int)m_PosX/2) + 80;
    obj->y = ((int)m_PosY/2) + 16;
    if (m_PosCenter == true) {
      obj->x -= (m_SizeW / 2);
      obj->y -= (m_SizeH / 2);
    }
    obj->w = m_SizeW;
    obj->h = m_SizeH;
    obj->tx = m_TexU;
    obj->ty = m_TexV;
    obj->alpha = (int)(255.0 * m_Blend);
    obj->zoomx = m_Zoom;
    obj->zoomy = m_Zoom;
    obj->rotation_z = (360.0 * m_RollZ) / 65536.0;
  }

#if 0
  LUNARECT Dst, Src;
  D3DCOLOR  color;
  float  alpha;

  if (m_LunaSprite == INVALID_SPRITE) {
    return(false);
  }
  if ((m_Visible == false) || (m_Working == false)) {
    return(true);
  }

  /* --- 表示位置 */
  if (m_PosCenter == true) {
    Dst.Set(m_PosX - (F(m_SizeW) / 2.0),
	    m_PosY - (F(m_SizeH) / 2.0),
	    F(m_SizeW),
	    F(m_SizeH));
  }
  else {
    Dst.Set(m_PosX, m_PosY, F(m_SizeW), F(m_SizeH));
  }
  /* --- texture UV */
  Src.Set(F(m_TexU), F(m_TexV), F(m_TexW), F(m_TexH));
  /* --- 透明度の設定 */
  alpha = m_Blend;
  if (alpha > 1.0) {
    alpha = 1.0;
  }
  if (alpha < 0.0) {
    alpha = 0.0;
  }
  alpha *= 255;
  color = (D3DCOLOR)alpha;
  color <<= 24;
  color |= 0xffffff;
  /* --- プリミティブを積む */
  if ((m_RollX == 0.0) && (m_RollY == 0)) {
    if (m_RollZ == 0.0) {
      /* --- ローテート無し */
      LunaSprite::DrawSquare(m_LunaSprite,
			     &Dst,
			     F(m_Priority),
			     &Src,
			     color);
    }
    else {
      /* --- z軸ローテートあり */
      LunaSprite::DrawSquareRotate(m_LunaSprite,
				   &Dst,
				   F(m_Priority),
				   &Src,
				   color,
				   (unsigned long)m_RollZ);
    }
  }
  else {
    /* - 三軸ローテートあり */
    LunaSprite::DrawSquareRotateXYZ(m_LunaSprite,
				    &Dst,
				    F(m_Priority),
				    &Src,
				    color,
				    (unsigned long)m_RollX,
				    (unsigned long)m_RollY,
				    (unsigned long)m_RollZ);
  }
#endif
  return(true);
}



/*------------------------------------------------------*/
/* local work                                           */
/*------------------------------------------------------*/

