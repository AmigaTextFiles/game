/* ---------------------------------------------------------- */
/*  bulletmaker.h                                             */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		弾やエフェクトを生成するクラス
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

#ifndef BULLETMAKER_H
#define BULLETMAKER_H

#include "lunavader.h"
#include "bulletbase.h"
#include "myshipmanage.h"
#include "bulletmanage.h"
#include "enemyobject.h"



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
 * @brief 弾を発生させるクラス
 *        自らがインスタンスとして弾となることも可能
 *
 * @todo -
 * @bug -
 */
class BulletMaker : public BulletBase
{
  /* ----------------------------------- */
  /* --- コンストラクタ・デストラクタ */
 public:
  BulletMaker();
  virtual  ~BulletMaker();

  /* ----------------------------------- */
  /* --- パブリックメンバ */
 public:

  /* ----------------------------------- */
  /* --- プライベートメンバ */
 private:
  //! 弾幕難易度のレベル
  int  m_Level;
  //! 弾幕シークェンスのステップ
  int  m_Step;
  //! 自機狙い弾にて自機の位置を知るために
  MyShipManage *m_Aim;
  //! 生成した弾やエフェクトを登録するマネージャ
  void  *m_Manager;
  //! 生成を依頼している敵オブジェクト
  EnemyObject  *m_Enemy;

  /* ----------------------------------- */
  /* --- パブリックメソッド */
 public:
  bool  Tick();
  void  SetEnemyObject(EnemyObject *enemy);
  void  SetMyShip(MyShipManage *myship);
  void  SetManager(void *manager);
  void  SetLevel(int level);
  void  RequestEffect(int level, float x, float y);
  void  RequestBullet(int request);

  /* ----------------------------------- */
  /* --- プライベートメソッド */
 private:
  void  aim_ship(BulletBase *bullet, MyShipManage *ship);
  /* -- スプライトの設定 */
  void  set_obj_001(BulletBase *obj);
  void  set_obj_002(BulletBase *obj);
  void  set_obj_003(BulletBase *obj);
  /* -- 弾幕生成プロセス */
  void  request_bullet_001();
  void  make_bullet_001();
  void  request_bullet_002();
  void  make_bullet_002();
  void  request_bullet_003();
  void  make_bullet_003();
  void  request_bullet_004();
  void  make_bullet_004();

};


#endif

