/* ---------------------------------------------------------- */
/*  convoymanage.cpp                                          */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		敵群体の移動と管理を行うクラス
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.16.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/

/*-------------------------------*/
/* include                       */
/*-------------------------------*/
#include "convoymanage.h"
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
ConvoyManage::ConvoyManage()
{
  /* --- 初期化 */
  m_Convoy = new EnemyObject[CV_COLUMN * CV_ROW];
  m_BulletMaker = NULL;
}


/**
 * デストラクタ(後始末)
 */
ConvoyManage::~ConvoyManage()
{
  delete  m_Convoy;
  delete  m_BulletMaker;
}



/*------------------------------------------------------*/
/* interface                                            */
/*------------------------------------------------------*/

/* ----------------------------------------- */
/* --- Init() */
/**
 * 群体の初期化、配列
 *
 * @return 無し
 *
 */
void ConvoyManage::Init(int level)
{
  /* --- メンバー初期化 */
  m_Level = level;
  m_WalkStat = ENEMY_WALK_SEQ_RIGHT;
  m_WalkMember = 0;
  m_WalkPattern = 0;
  m_Wait = 0;
  m_HitWait = 0;
  m_Timer = 0;
  /* --- コンボイ初期化 */
  set_enemy();
  /* --- 弾幕生成にもレベルを設定 */
  m_BulletMaker->SetLevel(level);
}


/* ----------------------------------------- */
/* --- Tick() */
/**
 * 群体の移動、通常処理
 *
 * @return false で通常、true で歩行音いっこ鳴らす
 *
 */
bool  ConvoyManage::Tick()
{
  bool  walk;
  float  min, max;
  int  i, j;

  /* --- 弾ヒットによるウェイト */
  for(i=0; i<CV_ROW; i++) {
    for(j=0; j<CV_COLUMN; j++) {
      m_Convoy[j+(i*CV_COLUMN)].Tick();
    }
  }
  if (m_HitWait > 0) {
    m_HitWait -= 1;
    if (m_HitWait == 0) {
      /* 弾に当たっていた敵消去 */
      for(i=0; i<CV_ROW; i++) {
	for(j=0; j<CV_COLUMN; j++) {
	  if (m_Convoy[j+(i*CV_COLUMN)].m_IsHit == true) {
	    m_Convoy[j+(i*CV_COLUMN)].m_Visible = false;
	    m_Convoy[j+(i*CV_COLUMN)].m_Working = false;
	    m_Convoy[j+(i*CV_COLUMN)].m_HitEnable = false;
	    m_Convoy[j+(i*CV_COLUMN)].m_IsHit = false;
	  }
	}
      }
    }
    /* --- 群体オブジェクト表示 */
    for(i=0; i<CV_ROW; i++) {
      for(j=0; j<CV_COLUMN; j++) {
	m_Convoy[j+(i*CV_COLUMN)].Display();
      }
    }
    /* 即終了 */
    return(false);
  }

  /* --- 群体オブジェクト管理 */
  walk = false;
  i = m_WalkMember;
  while(i < (CV_COLUMN * CV_ROW)) {
    if (m_Convoy[i].m_Working == true) {
      /* - 動かす */
      switch(m_WalkStat) {
      case ENEMY_WALK_SEQ_RIGHT:
	m_Convoy[i].m_PosX += 6.0;
	m_Convoy[i].SetWalkPattern(m_WalkPattern);
	break;

      case ENEMY_WALK_SEQ_DOWN1:
	m_Convoy[i].m_PosY += 8.0;
	m_Convoy[i].SetWalkPattern(m_WalkPattern);
	break;

      case ENEMY_WALK_SEQ_LEFT:
	m_Convoy[i].m_PosX -= 6.0;
	m_Convoy[i].SetWalkPattern(m_WalkPattern);
	break;

      case ENEMY_WALK_SEQ_DOWN2:
	m_Convoy[i].m_PosY += 8.0;
	m_Convoy[i].SetWalkPattern(m_WalkPattern);
	break;
      }
      break;
    }
    i++;
  }
  if (i == (CV_COLUMN * CV_ROW)) {
    /* - 一巡した */
    walk = true;
    m_WalkPattern ^= 1;
    m_WalkMember = 0;
    /* 端っこ判定 */
    min = max = (GAMEFIELD_W / 2);
    for(i=0; i<CV_ROW; i++) {
      for(j=0; j<CV_COLUMN; j++) {
	if (m_Convoy[j+(i*CV_COLUMN)].m_Working == true) {
	  if (m_Convoy[j+(i*CV_COLUMN)].m_PosX <= min) {
	    min = m_Convoy[j+(i*CV_COLUMN)].m_PosX;
	  }
	  if (m_Convoy[j+(i*CV_COLUMN)].m_PosX >= max) {
	    max = m_Convoy[j+(i*CV_COLUMN)].m_PosX;
	  }
	}
      }
    }
    /* 次ステップへ移るかどうか判断 */
    switch(m_WalkStat) {
    case ENEMY_WALK_SEQ_RIGHT:
      if (max > 428) {
	m_WalkStat += 1;
      }
      break;

    case ENEMY_WALK_SEQ_LEFT:
      if (min < 20) {
	m_WalkStat += 1;
      }
      break;
	
    case ENEMY_WALK_SEQ_DOWN1:
	m_WalkStat += 1;
      break;

    case ENEMY_WALK_SEQ_DOWN2:
	m_WalkStat = ENEMY_WALK_SEQ_RIGHT;
      break;
    }
  }
  else {
    m_WalkMember = (i + 1);
  }

  /* --- 群体オブジェクト表示 */
  for(i=0; i<CV_ROW; i++) {
    for(j=0; j<CV_COLUMN; j++) {
      m_Convoy[j+(i*CV_COLUMN)].Display();
    }
  }
  

  /* --- 攻撃のタイミング */
  m_Timer += 1;
  if (m_Level < 2) {
    if ((m_Timer % 100) == 0) {
      attack_enemy();
    }
  }
  else if (m_Level < 4) {
    if ((m_Timer % 80) == 0) {
      attack_enemy();
    }
  }
  else {
    if ((m_Timer % 60) == 0) {
      attack_enemy();
    }
  }


  return(walk);
}


/* ----------------------------------------- */
/* --- SetBulletMaker() */
/**
 * 弾やエフェクトを生成するインスタンスの受け取り
 *
 * @return 無し
 *
 */
void  ConvoyManage::SetBulletMaker(BulletMaker *bulletmaker)
{
  m_BulletMaker = bulletmaker;
}


/* ----------------------------------------- */
/* --- IsInvade() */
/**
 * 侵略によるゲームオーバー判定
 *
 * @return false で通常、true でゲームオーバー
 *
 */
bool  ConvoyManage::IsInvade()
{
  bool result;
  float  max;
  int i, j;

  result = false;
  /* --- 最下端判定 */
  max = 0;
  for(i=0; i<CV_ROW; i++) {
    for(j=0; j<CV_COLUMN; j++) {
      if (m_Convoy[j+(i*CV_COLUMN)].m_Working == true) {
	if (m_Convoy[j+(i*CV_COLUMN)].m_PosY >= max) {
	  max = m_Convoy[j+(i*CV_COLUMN)].m_PosY;
	}
      }
    }
  }
  /* --- 判定 */
  if (max >= 440) {
    result = true;
  }
  
  return(result);
}

/* ----------------------------------------- */
/* --- GetRestEnemy() */
/**
 * 敵の残り数
 *
 * @return 現在の敵総数
 *
 */
int  ConvoyManage::GetRestEnemy()
{
  int  i, j, n;

  n = 0;
  for(i=0; i<CV_ROW; i++) {
    for(j=0; j<CV_COLUMN; j++) {
      if (m_Convoy[j+(i*CV_COLUMN)].m_Working == true) {
	n += 1;
      }
    }
  }

  return(n);
}

/* ----------------------------------------- */
/* --- CheckHit() */
/**
 * 自機弾に対する敵の当たり判定
 *
 * @return ヒットしたときの敵キャラ得点
 *
 */
int  ConvoyManage::CheckHit(MyShotManage* shot)
{
  int  i, j, score;
  
  score = 0;
  for(i=0; i<CV_ROW; i++) {
    for(j=0; j<CV_COLUMN; j++) {
      if (m_Convoy[j+(i*CV_COLUMN)].m_Working == true) {
	if (m_Convoy[j+(i*CV_COLUMN)].CheckCollision(shot)) {
	  /* --- 当たった */
	  m_Convoy[j+(i*CV_COLUMN)].Hit();
	  m_HitWait = ENEMYHIT_WAIT;
	  score = m_Convoy[j+(i*CV_COLUMN)].GetScore();
	  shot->m_Working = false;
	  shot->m_Visible = false;
	  shot->m_HitEnable = false;
	  shot->SetWait(ENEMYHIT_WAIT);
	  /* - 当たりエフェクト */
	  m_BulletMaker->RequestEffect(1,
				       m_Convoy[j+(i*CV_COLUMN)].m_PosX,
				       m_Convoy[j+(i*CV_COLUMN)].m_PosY);
	}
      }
    }
  }
  return(score);
}

/* ----------------------------------------- */
/* --- SetLunaSprite() */
/**
 * スプライトバッファの受け取り
 *
 * @param handle [in] スプライトバッファ
 * @return 無し
 *
 */
void  ConvoyManage::SetLunaSprite(LSPRITE handle)
{
  m_SpriteHandle = handle;
}



/*------------------------------------------------------*/
/* local work                                           */
/*------------------------------------------------------*/

/* ----------------------------------------- */
/* --- set_enemy() */
/**
 * ステージ開始時の敵群体位置初期化
 *
 * @return 無し
 *
 */
void  ConvoyManage::set_enemy()
{
  int  i, j;
  int height;

  /* --- スタート位置の高さ (～340) */
  height = 240 + (m_Level * 10);
  if (height > 340) {
    height = 340;
  }
  /* --- 群体オブジェクト初期化 */
  for(i=0; i<CV_ROW; i++) {
    for(j=0; j<CV_COLUMN; j++) {
      /* - オブジェクトの初期化 */
      m_Convoy[j+(i*CV_COLUMN)].m_SizeW = 16;
      m_Convoy[j+(i*CV_COLUMN)].m_SizeH = 24;
      m_Convoy[j+(i*CV_COLUMN)].m_Priority = BS_DEPTH_ENEMY;
      m_Convoy[j+(i*CV_COLUMN)].m_Blend = 1.0;
      m_Convoy[j+(i*CV_COLUMN)].m_Zoom = 1.0;
      m_Convoy[j+(i*CV_COLUMN)].m_TexW = 16;
      m_Convoy[j+(i*CV_COLUMN)].m_TexH = 24;
      m_Convoy[j+(i*CV_COLUMN)].m_RollZ = 0.0;
      m_Convoy[j+(i*CV_COLUMN)].m_PosCenter = true;
      m_Convoy[j+(i*CV_COLUMN)].m_Working = true;
      m_Convoy[j+(i*CV_COLUMN)].m_Visible = true;
      m_Convoy[j+(i*CV_COLUMN)].SetCharactor(SIENSIDE);
      m_Convoy[j+(i*CV_COLUMN)].SetWalkPattern(0);
      /* - 当たり判定 */
      m_Convoy[j+(i*CV_COLUMN)].SetHitSize(8.0);
      m_Convoy[j+(i*CV_COLUMN)].SetGrazeSize(8.0);
      m_Convoy[j+(i*CV_COLUMN)].m_HitEnable = true;
      /* - 位置初期化 */
      m_Convoy[j+(i*CV_COLUMN)].m_PosX = 40 + (j * 40);
      m_Convoy[j+(i*CV_COLUMN)].m_PosY = height;
      /* - スプライト */
      m_Convoy[j+(i*CV_COLUMN)].SetLunaSprite(m_SpriteHandle);
      /* - 得点 */
      m_Convoy[j+(i*CV_COLUMN)].SetScore((i+1)*1000);
    }
    height -= 50;
  }
}


/* ----------------------------------------- */
/* --- attack_enemy() */
/**
 * 弾幕攻撃のリクエスト
 *
 * @return 無し
 *
 */
void  ConvoyManage::attack_enemy()
{
  int  enemy_rest_w[CV_COLUMN];
  int  enemy_attack_list[CV_COLUMN];
  int  line_num;
  int  i, j, n, max, level;

  /* --- 攻撃できる敵キャラクターを探す */
  line_num = 0;
  for(i=0; i<CV_COLUMN; i++) {
    enemy_rest_w[i] = 0;
    enemy_attack_list[i] = 0;
  }
  for(j=0; j<CV_ROW; j++) {
    for(i=0; i<CV_COLUMN; i++) {
      n = i + (j * CV_COLUMN);
      if (m_Convoy[n].m_Working) {
	if (enemy_rest_w[i] < (4-j)) {
	  enemy_rest_w[i] = (4-j);
	}
      }
    }
  }
  for(i=0; i<CV_COLUMN; i++) {
    if (enemy_rest_w[i] > 0) {
      enemy_attack_list[line_num] = i;
      line_num += 1;
    }
  }

  /* --- 攻撃レベル */
  n = GetRestEnemy();
  if (n > 35) {
    max = 1;
  } else if (n > 25) {
    max = 2;
  } else if (n > 15) {
    max = 3;
  } else {
    max = 4;
  }
  level = LunaMath::Rand(0, (max - 1));
  
  /* --- 攻撃するキャラを選択 */
  n = LunaMath::Rand(0, (line_num - 1));
  i = enemy_attack_list[n];
  j = enemy_rest_w[i];
  if (j > 0) {
    n = i + ((4 - j) * CV_COLUMN);
    /* - 攻撃リクエスト */
    m_BulletMaker->SetEnemyObject(&(m_Convoy[n]));
    m_BulletMaker->RequestBullet(level);
  }
}

