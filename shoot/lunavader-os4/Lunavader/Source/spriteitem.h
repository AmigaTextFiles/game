/* ---------------------------------------------------------- */
/*  SpriteItem.h                                              */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		スプライトクラス
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.13.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

#ifndef SPRITEITEM_H
#define SPRITEITEM_H

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include "lunavader.h"
#include "lunamath.h"
#include "grp_screen.h"

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
 * @brief スプライト管理クラス
 *        スプライト1個に1インスタンス
 *        Luna system を触らずにスプライト表示ができるように
 *
 * @todo -
 * @bug -
 */
class SpriteItem
{
  /* ----------------------------------- */
  /* --- コンストラクタ・デストラクタ */
 public:
  SpriteItem();
  virtual  ~SpriteItem();

  /* ----------------------------------- */
  /* --- パブリックメンバ */
 public:
  //! 表示位置(スプライト中央) X
  float m_PosX;
  //! 表示位置(スプライト中央) Y
  float m_PosY;
  //! 表示サイズ横幅
  int m_SizeW;
  //! 表示サイズ縦幅
  int m_SizeH;
  //! 表示深度(プライオリティ)
  int m_Priority;
  //! α値(1.0 で不透明、0.0 で透明)
  float m_Blend;
  //! 指定表示サイズより大きくしたり小さくしたり
  float m_Zoom;
  //! テクスチャ内座標 U
  int m_TexU;
  //! テクスチャ内座標 V
  int m_TexV;
  //! テクスチャ内座標横幅
  int m_TexW;
  //! テクスチャ内座標縦幅
  int m_TexH;
  //! 通常 Z軸回転
  float m_RollZ;
  //! 特殊3D座標回転 X
  float m_RollX;
  //! 特殊3D座標回転 Y
  float m_RollY;
  //! 座標はスプライトの中心か否か
  bool m_PosCenter;
  //! 使用中か否か(移動すらしない)
  bool m_Working;
  //! 表示されるか否か(移動とかはする)
  bool m_Visible;
  //! 使用するテクスチャ番号
  int  m_TextureID;

  /* ----------------------------------- */
  /* --- プライベートメンバ */
 protected:
  //! プリミティブが納められる LunaSprite ハンドル
  LSPRITE m_LunaSprite;

  /* ----------------------------------- */
  /* --- パブリックメソッド */
 public:
  void SetLunaSprite(LSPRITE sp_handle);
  virtual bool Display();

  /* ----------------------------------- */
  /* --- プライベートメソッド */
 private:

};


#endif

