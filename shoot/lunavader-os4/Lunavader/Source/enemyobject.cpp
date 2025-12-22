/* ---------------------------------------------------------- */
/*  enemyobject.cpp                                           */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		敵侵略者の一体あたりのオブジェクト
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
#include "enemyobject.h"

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
EnemyObject::EnemyObject()
{
  /* --- 初期化 */
  m_IsHit = false;
  m_HitWait = 0;
  m_WalkPattern = 0;
  m_Charactor = 0;
  m_Score = 0;
}


/**
 * デストラクタ(後始末)
 */
EnemyObject::~EnemyObject()
{
}



/*------------------------------------------------------*/
/* interface                                            */
/*------------------------------------------------------*/

/* ----------------------------------------- */
/* --- Init() */
/**
 * 状態初期化
 *
 * @return 無し
 *
 */
void EnemyObject::Init()
{
  m_IsHit = false;
  m_HitWait = 0;
}


/* ----------------------------------------- */
/* --- Tick() */
/**
 * 毎フレームごとの作業(生存証明を返すだけ)
 *
 * @return true なら移動中、false なら消滅
 *
 */
bool EnemyObject::Tick()
{
  bool  result;

  result = true;
  if (m_IsHit == true) {
    /* - ヒットマーク表示 */
    m_TexU = (2 * 16) + 16;
    m_TexV = m_Charactor * 24;
    /* - 弾当たり後のフリーズ時間 */
    if (m_HitWait > 0) {
      m_HitWait -= 1;
    }
    else {
      result = false;
    }
  }

  return(result);
}


/* ----------------------------------------- */
/* --- Hit() */
/**
 * 弾にあたった事を伝える
 *
 * @return 無し
 *
 */
void EnemyObject::Hit()
{
  m_IsHit = true;
  m_HitWait = ENEMYHIT_WAIT;
  /* - 念のため当たり判定なしに */
  m_HitEnable = false;
}


/* ----------------------------------------- */
/* --- SetWalkPattern() */
/**
 * 敵キャラクターの絵を指定する
 *
 * @return 無し
 *
 */
void EnemyObject::SetWalkPattern(int pattern)
{
  int n;

  /* - テクスチャ指定 */
  m_WalkPattern = pattern;
  /* 今回は 2パターンしかない */
  n = pattern % 2;
  m_TexU = (n * 16) + 16;
  m_TexV = m_Charactor * 24;
}


/* ----------------------------------------- */
/* --- SetCharactor() */
/**
 * キャラクターの指定
 *
 * @return 無し
 *
 */
void EnemyObject::SetCharactor(int chara)
{
  m_Charactor = chara;
  /* - すぐに反映 */
  m_TexU = (m_WalkPattern % 2) * 32;
  m_TexV = m_Charactor * 48;
}


/* ----------------------------------------- */
/* --- SetScore() */
/**
 * スコアを設定する
 *
 * @param score [in] このオブジェクトの得点
 * @return 無し
 *
 */
void EnemyObject::SetScore(int score)
{
  m_Score = score;
}


/* ----------------------------------------- */
/* --- GetScore() */
/**
 * スコアを設定する
 *
 * @return 無し
 *
 */
int EnemyObject::GetScore()
{
  return(m_Score);
}




/*------------------------------------------------------*/
/* local work                                           */
/*------------------------------------------------------*/

