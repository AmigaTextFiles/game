/* ---------------------------------------------------------- */
/*  bulletmanage.cpp                                          */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		弾や効果の管理クラス
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
#include "bulletmanage.h"

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
BulletManage::BulletManage()
{
  /* --- 初期化 */
  m_BulletNum = 0;
  m_ListHead = NULL;
  m_ListTail = NULL;
}


/**
 * デストラクタ(後始末)
 */
BulletManage::~BulletManage()
{
  BulletMaker*  obj;
  BulletMaker*  next;

  /* --- 弾幕リストに積んであるオブジェクト全て解放 */
  obj = (BulletMaker*)m_ListHead;
  try {
    while(obj != NULL) {
      next = (BulletMaker*)obj->m_ListNext;
      delete obj;
      obj = next;
    }
  }
  catch(...) {
  }
}



/*------------------------------------------------------*/
/* interface                                            */
/*------------------------------------------------------*/

/* ----------------------------------------- */
/* --- Init() */
/**
 * 強制初期化(ゲームオーバー時とかに)
 *
 * @return 無し
 *
 */
void  BulletManage::Init()
{
  BulletMaker  *obj, *next;

  /* --- 弾幕リストに積んであるオブジェクト全て解放 */
  obj = (BulletMaker*)m_ListHead;
  try {
    while(obj != NULL) {
      next = (BulletMaker*)obj->m_ListNext;
      delete obj;
      obj = next;
    }
  }
  catch(...) {
  }
  /* --- メンバクリア */
  m_BulletNum = 0;
  m_ListHead = NULL;
  m_ListTail = NULL;
}


/* ----------------------------------------- */
/* --- Tick() */
/**
 * 全てのオブジェクトを 1フレーム分移動する
 *
 * @return true で通常終了、false の時はオブジェクトが無かった
 *
 */
bool  BulletManage::Tick()
{
  BulletMaker  *obj, *next;
  bool result;

  /* --- オブジェクトが無いっぽいですよ */
  if (m_BulletNum == 0) {
    return(false);
  }

  /* --- 弾幕リストに積んであるオブジェクト全て */
  obj = (BulletMaker*)m_ListHead;
  try {
    while(obj != NULL) {
      next = (BulletMaker*)obj->m_ListNext;
      result = obj->Tick();
      if (result == false) {
	/* 寿命が尽きたオブジェクトを破棄 */
	delete_bullet(obj);
      }
      /* - 次へ */
      obj = next;
    }
  }
  catch(...) {
  }

  return(true);
}


/* ----------------------------------------- */
/* --- Display() */
/**
 * 全てのオブジェクトをプリミティブとして
 * スプライトバッファに積む
 *
 * @return 実際に作業したオブジェクト数
 *
 */
int  BulletManage::Display()
{
  BulletMaker  *obj, *next;
  int  i, n;

  /* --- 表示数はバッファの最大数までです */
  obj = (BulletMaker*)m_ListHead;
  n = 0;
  for(i=0; i<BS_SPBUF_BULLET; i++) {
    if (obj == NULL) {
      /* おしまい */
      break;
    }
    next = (BulletMaker*)obj->m_ListNext;
    obj->Display();
    /* - 次へ */
    obj = next;
    n += 1;
  }

  return(n);
}


/* ----------------------------------------- */
/* --- AddBullet() */
/**
 * オブジェクトをリストに追加する
 *
 * @return 実際に作業したオブジェクト数
 *
 */
bool  BulletManage::AddBullet(void* obj)
{
  BulletMaker *mobj, *tail;
  bool  result;

  mobj = (BulletMaker*)obj;
  result = true;
  /* --- バッファの数より多くなりそうだったら積まない */
  if (m_BulletNum < BS_SPBUF_BULLET) {
    if (m_ListHead == NULL) {
      /* - 最初の一発目は先頭にも記録する */
      m_ListHead = (void*)obj;
    }
    /* - リスト最後尾に追加 */
    mobj->m_ListPrev = m_ListTail;
    mobj->m_ListNext = NULL;
    if (m_ListTail) {
      tail = (BulletMaker*)m_ListTail;
      tail->m_ListNext = (void*)mobj;
    }
    m_ListTail = (void*)mobj;
    m_BulletNum += 1;
  }
  else {
    result = false;
  }

  return(result);
}


/* ----------------------------------------- */
/* --- CheckHit() */
/**
 * 自機と弾幕とのヒット判定(かすりも判定)
 *
 * @return 自機に弾があたっているとき true, それ以外 false
 *
 */
bool  BulletManage::CheckHit(ShootingObject* ship)
{
  BulletMaker  *obj, *next;
  bool  result;

  result = false;
  /* --- かすり判定のクリア */
  m_Graze = 0;
  /* --- 弾幕リストに積んであるオブジェクト全て */
  obj = (BulletMaker*)m_ListHead;
  try {
    while(obj != NULL) {
      next = (BulletMaker*)obj->m_ListNext;
      /* - 当たり判定がある弾が対象 */
      if (obj->m_HitEnable) {
	/* 当たり判定 */
	if (obj->CheckCollision(ship)) {
	  result = true;
	}
	/* かすり判定 */
	else if (obj->CheckGraze(ship)) {
	  m_Graze += 1;
	  /* かすった弾は二度と判断されないように */
	  obj->m_GrazeEnable = false;
	}
      }
      /* - 次へ */
      obj = next;
    }
  }
  catch(...) {
  }

  return(result);
}


/* ----------------------------------------- */
/* --- GetGraze() */
/**
 * かすり判定の結果を渡す
 *
 * @return かすり得点
 *
 */
int  BulletManage::GetGraze()
{
  return(m_Graze);
}


/* ----------------------------------------- */
/* --- DisableAllBullet() */
/**
 * 現在画面上に残っている弾のボーナスクリア
 *
 * @return 残弾ボーナス
 *
 */
int  BulletManage::DisableAllBullet()
{
  BulletMaker  *obj, *next;
  int  score;

  score = 0;
  /* --- 弾幕リストに積んであるオブジェクト全て */
  obj = (BulletMaker*)m_ListHead;
  try {
    while(obj != NULL) {
      next = (BulletMaker*)obj->m_ListNext;
      /* - 当たり判定がある弾が対象 */
      if (obj->m_HitEnable) {
	obj->m_HitEnable = false;
	obj->m_LifeTime = 15;
	obj->m_Blend = 0.3;
	score += 100;
      }
      /* - 次へ */
      obj = next;
    }
  }
  catch(...) {
  }

  return(score);
}


/*------------------------------------------------------*/
/* local work                                           */
/*------------------------------------------------------*/

void  BulletManage::delete_bullet(void *obj)
{
  BulletMaker *mobj, *prevobj, *nextobj;

  mobj = (BulletMaker*)obj;

  /* --- リストから切り離す */
  if (m_ListHead == mobj) {
    m_ListHead = mobj->m_ListNext;
  }
  if (m_ListTail == mobj) {
    m_ListTail = mobj->m_ListPrev;
  }
  prevobj = (BulletMaker*)mobj->m_ListPrev;
  nextobj = (BulletMaker*)mobj->m_ListNext;
  if (prevobj) {
    prevobj->m_ListNext = mobj->m_ListNext;
  }
  if (nextobj) {
    nextobj->m_ListPrev = mobj->m_ListPrev;
  }
  /* --- オブジェクトのリリース */
  delete mobj;
  m_BulletNum -= 1;
}


void*  BulletManage::get_next_bullet(void* obj)
{
  BulletMaker *mobj;

  mobj = (BulletMaker*)obj;
  /* --- 必要なのかこのメソッド？ */
  return((void*)mobj->m_ListNext);
}


