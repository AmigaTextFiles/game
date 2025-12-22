/* ---------------------------------------------------------- */
/*  bulletmanage.h                                            */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		弾やエフェクトの管理クラス
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.17.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#ifndef BULLETMANAGE_H
#define BULLETMANAGE_H

#include "lunavader.h"
#include "basicsystem.h"
#include "bulletmaker.h"



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
 * @brief 弾幕を管理するクラス
 *        オブジェクトの発生と消失を司る
 *
 * @todo -
 * @bug -
 */
class BulletManage
{
  /* ----------------------------------- */
  /* --- コンストラクタ・デストラクタ */
 public:
  BulletManage();
  virtual  ~BulletManage();

  /* ----------------------------------- */
  /* --- パブリックメンバ */
 public:

  /* ----------------------------------- */
  /* --- プライベートメンバ */
 private:
  //! 現在の弾オブジェクト数
  int  m_BulletNum;
  //! オブジェクトリストの先頭
  void *m_ListHead;
  //! オブジェクトリストの最後尾
  void *m_ListTail;
  //! かすり判定の合計数
  int  m_Graze;

  /* ----------------------------------- */
  /* --- パブリックメソッド */
 public:
  void  Init();
  bool  Tick();
  int  Display();
  bool  AddBullet(void *obj);
  bool  CheckHit(ShootingObject* ship);
  int  GetGraze();
  int  DisableAllBullet();

  /* ----------------------------------- */
  /* --- プライベートメソッド */
 private:
  void delete_bullet(void *obj);
  void* get_next_bullet(void *obj);

};


#endif

