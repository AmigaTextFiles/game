/* ---------------------------------------------------------- */
/*  bulletmaker.cpp                                           */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		弾幕作成マネージャ
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
#include "bulletmaker.h"

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
BulletMaker::BulletMaker()
{
  /* --- 初期化 */
  m_Level = 1;
  m_Step = 0;
  m_Aim = NULL;
  m_Manager = NULL;
  m_Enemy = NULL;
}


/**
 * デストラクタ(後始末)
 */
BulletMaker::~BulletMaker()
{
}



/*------------------------------------------------------*/
/* interface                                            */
/*------------------------------------------------------*/

/* ----------------------------------------- */
/* --- Tick() */
/**
 * 弾オブジェクトとしての 1フレーム移動と弾生成作業
 *
 * @return true ならオブジェクト生存中、false で処理終了
 *
 */
bool BulletMaker::Tick()
{
  bool  alive;

  /* --- 自身が弾として移動 */
  alive = BulletBase::Tick();

  /* --- 弾幕生成シークェンス */
  if (m_Type > 0) {
    switch(m_Type) {
    case 1:
      make_bullet_001();
      break;
    case 2:
      make_bullet_002();
      break;
    case 3:
      make_bullet_003();
      break;
    case 4:
      make_bullet_004();
      break;
    default:
      make_bullet_001();
      break;
    }
  }

  /* --- おしまい */
  return(alive);
}

/* ----------------------------------------- */
/* --- SetEnemyObject() */
/**
 * 弾の生成依頼をしている敵オブジェクト
 *
 * @param enemy [in] 敵オブジェクトのインスタンス
 * @return 無し
 *
 */
void  BulletMaker::SetEnemyObject(EnemyObject *enemy)
{
  m_Enemy = enemy;
}


/* ----------------------------------------- */
/* --- SetMyShip() */
/**
 * 自機狙い弾のために自機位置情報が必要なので自機のインスタンス
 *
 * @param myship [in] 自機オブジェクトのインスタンス
 * @return 無し
 *
 */
void  BulletMaker::SetMyShip(MyShipManage *myship)
{
  m_Aim = myship;
}



/* ----------------------------------------- */
/* --- SetManager() */
/**
 * 生成した弾を管理するマネージャ
 *
 * @param manager [in] 弾管理クラスのインスタンス
 * @return 無し
 *
 */
void  BulletMaker::SetManager(void *manager)
{
  m_Manager = manager;
}


/* ----------------------------------------- */
/* --- Setlevel() */
/**
 * 弾の難易度があるならそれを指定する
 *
 * @param level [in] 弾幕難易度
 * @return 無し
 *
 */
void  BulletMaker::SetLevel(int level)
{
  m_Level = level;
}


/* ----------------------------------------- */
/* --- RequestEffect() */
/**
 * 撃墜エフェクトの表示リクエスト
 *
 * @param level [in] エフェクトの量と飛び散る広さ
 * @param x [in] エフェクトの中心となる座標 x
 * @param y [in] エフェクトの中心となる座標 y
 * @return 無し
 *
 */
void  BulletMaker::RequestEffect(int level, float x, float y)
{
  int  num, life, roll;
  float  speed;
  BulletMaker  *obj;
  BulletManage *man;
  int  i;

  man = (BulletManage*)m_Manager;

  /* --- 指定レベルによって数とかを決定 */
  switch(level) {
    /* - 通常敵向け */
  case 1:
    num = 20;
    life = 20;
    speed = 1.0;
    roll = 0;
    break;

    /* - Bonus ship 向け */
  case 2:
    num = 80;
    life = 30;
    speed = 2.0;
    roll = 300;
    break;

  default:
    num = 10;
    life = 30;
    speed = 2.0;
    roll = 0;
    break;
  }

  /* --- エフェクトオブジェクトの生成 */
  for(i=0; i<num; i++) {
    obj = new BulletMaker;
    obj->m_Type = 0;
    obj->m_PosX = x;
    obj->m_PosY = y;
    obj->m_PosCenter = true;
    obj->m_SizeW = 8;
    obj->m_SizeH = 8;
    obj->m_RollZ = 65535.0 * LunaMath::RandF();
    obj->m_Priority = BS_DEPTH_BULLET;
    obj->m_Blend = 0.5;
    obj->m_TexU = 128 + (8 * LunaMath::Rand(0, 2));
    obj->m_TexV = 0;
    obj->m_TexW = 8;
    obj->m_TexH = 8;
    obj->m_RollZ = 0;
    obj->m_Working = true;
    obj->m_Visible = true;
    obj->m_EnemyObject = m_Enemy;
    obj->m_Direction = 65535.0 * LunaMath::RandF();
    obj->m_Speed = speed + (2.0 * LunaMath::RandF());
    obj->m_SpeedR = (float)roll;
    obj->m_AddRoll = 3000 + LunaMath::Rand(0, 1000);
    obj->m_Accelerator = -0.02 - (0.01 * LunaMath::RandF());
    obj->m_Limit = 5.0;
    obj->m_LimitR = 30000;
    obj->m_LifeTime = life;
    obj->m_HitEnable = false;
    obj->m_GrazeEnable = false;
    obj->SetLunaSprite(m_LunaSprite);
    man->AddBullet(obj);
  }
}


/* ----------------------------------------- */
/* --- RequestBullet() */
/**
 * 弾幕の生成リクエスト
 *
 * @param request [in] 弾幕の種類
 * @return 無し
 *
 */
void  BulletMaker::RequestBullet(int request)
{
  switch(request) {
  case 0:
    request_bullet_001();
    break;
  case 1:
    request_bullet_003();
    break;
  case 2:
    request_bullet_002();
    break;
  case 3:
    request_bullet_004();
    break;
  default:
    request_bullet_001();
    break;
  }
}


/*------------------------------------------------------*/
/* local work                                           */
/*------------------------------------------------------*/

/* ----------------------------------------- */
/* --- aim_ship() */
/**
 * 弾オブジェクトの方向を自分に向かわせる
 *
 * @param bullet [in] 方向を設定する弾オブジェクト
 * @return 無し
 *
 */
void  BulletMaker::aim_ship(BulletBase *bullet,
			    MyShipManage *ship)
{
  float  dx, dy;
  long  dir;

  dx = ship->m_PosX - bullet->m_PosX;
  dy = ship->m_PosY - bullet->m_PosY;
  dir = LunaMath::Atan((long)dy, (long)dx);
  bullet->m_Direction = dir;
}


/* --- アーモンド弾 */
void  BulletMaker::set_obj_001(BulletBase *obj)
{
  obj->m_Type = 0;
  obj->m_PosX = m_PosX;
  obj->m_PosY = m_PosY;
  obj->m_PosCenter = true;
  obj->m_SizeW = 4;
  obj->m_SizeH = 8;
  obj->m_RollZ = 0.0;
  obj->m_Priority = BS_DEPTH_BULLET;
  obj->m_Blend = 1.0;
  obj->m_TexU = 120;
  obj->m_TexV = 16;
  obj->m_TexW = 4;
  obj->m_TexH = 8;
  obj->m_RollZ = 0;
  obj->m_Working = true;
  obj->m_Visible = true;
  obj->m_EnemyObject = m_Enemy;
  obj->m_Direction = (65536 / 4) * 1;
  obj->m_DirectionAdd = 0;
  obj->m_Speed = 3.0;
  obj->m_SpeedR = 0;
  obj->m_AddRoll = 0;
  obj->m_Accelerator = 0;
  obj->m_AcceleratorR = 0;
  obj->m_Limit = 5.0;
  obj->m_LimitR = 30000;
  obj->m_LifeTime = 3600;
  obj->m_HitEnable = true;
  obj->m_GrazeEnable = true;
  obj->SetLunaSprite(m_LunaSprite);
  obj->SetHitSize(4.0);
  obj->SetGrazeSize(11.0);
}

/* --- 白丸(小) */
void  BulletMaker::set_obj_002(BulletBase *obj)
{
  obj->m_Type = 0;
  obj->m_PosX = m_PosX;
  obj->m_PosY = m_PosY;
  obj->m_PosCenter = true;
  obj->m_SizeW = 6;
  obj->m_SizeH = 6;
  obj->m_RollZ = 0.0;
  obj->m_Priority = BS_DEPTH_BULLET;
  obj->m_Blend = 1.0;
  obj->m_TexU = 112;
  obj->m_TexV = 16;
  obj->m_TexW = 6;
  obj->m_TexH = 6;
  obj->m_RollZ = 0;
  obj->m_Working = true;
  obj->m_Visible = true;
  obj->m_EnemyObject = m_Enemy;
  obj->m_Direction = (65536 / 4) * 1;
  obj->m_DirectionAdd = 0;
  obj->m_Speed = 3.0;
  obj->m_SpeedR = 0;
  obj->m_AddRoll = 0;
  obj->m_Accelerator = 0;
  obj->m_AcceleratorR = 0;
  obj->m_Limit = 5.0;
  obj->m_LimitR = 30000;
  obj->m_LifeTime = 3600;
  obj->m_HitEnable = true;
  obj->m_GrazeEnable = true;
  obj->SetLunaSprite(m_LunaSprite);
  obj->SetHitSize(5.0);
  obj->SetGrazeSize(12.0);
}

/* --- 赤丸(中) */
void  BulletMaker::set_obj_003(BulletBase *obj)
{
  obj->m_Type = 0;
  obj->m_PosX = m_PosX;
  obj->m_PosY = m_PosY;
  obj->m_PosCenter = true;
  obj->m_SizeW = 8;
  obj->m_SizeH = 8;
  obj->m_RollZ = 0.0;
  obj->m_Priority = BS_DEPTH_BULLET;
  obj->m_Blend = 1.0;
  obj->m_TexU = 128;
  obj->m_TexV = 16;
  obj->m_TexW = 8;
  obj->m_TexH = 8;
  obj->m_RollZ = 0;
  obj->m_Working = true;
  obj->m_Visible = true;
  obj->m_EnemyObject = m_Enemy;
  obj->m_Direction = (65536 / 4) * 3;
  obj->m_DirectionAdd = 0;
  obj->m_Speed = 3.0;
  obj->m_SpeedR = 0;
  obj->m_AddRoll = 0;
  obj->m_Accelerator = 0;
  obj->m_AcceleratorR = 0;
  obj->m_Limit = 5.0;
  obj->m_LimitR = 30000;
  obj->m_LifeTime = 6000;
  obj->m_HitEnable = true;
  obj->m_GrazeEnable = true;
  obj->SetLunaSprite(m_LunaSprite);
  obj->SetHitSize(7.0);
  obj->SetGrazeSize(14.0);
}


/* --------------------------------------- */
/* --- 下落ち弾 */
void BulletMaker::request_bullet_001()
{
  BulletMaker *obj;
  BulletManage *man;

  man = (BulletManage *)m_Manager;

  obj = new BulletMaker;
  obj->m_Type = 1;
  obj->m_PosX = m_Enemy->m_PosX;
  obj->m_PosY = m_Enemy->m_PosY;
  obj->m_PosCenter = true;
  obj->m_SizeW = 16;
  obj->m_SizeH = 16;
  obj->m_RollZ = 0.0;
  obj->m_Priority = BS_DEPTH_BULLET;
  obj->m_Blend = 1.0;
  obj->m_TexU = 112;
  obj->m_TexV = 32;
  obj->m_TexW = 16;
  obj->m_TexH = 16;
  obj->m_RollZ = 0;
  obj->m_Working = true;
  obj->m_Visible = true;
  obj->m_EnemyObject = m_Enemy;
  obj->m_Direction = 0;
  obj->m_Speed = 0.0;
  obj->m_SpeedR = 0;
  obj->m_AddRoll = 0;
  obj->m_Accelerator = 0;
  obj->m_AcceleratorR = 0;
  obj->m_Limit = 5.0;
  obj->m_LimitR = 30000;
  obj->m_LifeTime = 3;
  obj->m_HitEnable = true;
  obj->m_GrazeEnable = false;
  obj->SetLunaSprite(m_LunaSprite);
  obj->SetManager(man);
  obj->SetMyShip(m_Aim);
  obj->SetEnemyObject(m_Enemy);
  obj->SetLevel(m_Level);
  man->AddBullet(obj);
}

void BulletMaker::make_bullet_001()
{
  BulletMaker *obj;
  BulletManage  *man;
  int  i, n;

  man = (BulletManage*)m_Manager;
  n = m_Level;
  if (n > 5) n = 5;

  if (m_LifeTime == 1) {
    for(i=0; i<n; i++) {
      obj = new BulletMaker;
      set_obj_001(obj);
      obj->m_Type = 0;
      obj->m_PosX = m_PosX;
      obj->m_PosY = m_PosY;
      obj->m_Direction = (65536 / 4) * 1;
      obj->m_Speed = 3.0 - (0.5 * (float)i);
      obj->m_Limit = 5.0;
      obj->m_LifeTime = 3600;
      man->AddBullet(obj);
    }
  }
}



/* --------------------------------------- */
/* --- 自機狙い n way */
void BulletMaker::request_bullet_002()
{
  BulletMaker *obj;
  BulletManage *man;

  man = (BulletManage *)m_Manager;

  obj = new BulletMaker;
  obj->m_Type = 2;
  obj->m_PosX = m_Enemy->m_PosX;
  obj->m_PosY = m_Enemy->m_PosY;
  obj->m_PosCenter = true;
  obj->m_SizeW = 16;
  obj->m_SizeH = 16;
  obj->m_RollZ = 0.0;
  obj->m_Priority = BS_DEPTH_BULLET;
  obj->m_Blend = 1.0;
  obj->m_TexU = 112;
  obj->m_TexV = 32;
  obj->m_TexW = 16;
  obj->m_TexH = 162;
  obj->m_RollZ = 0;
  obj->m_Working = true;
  obj->m_Visible = true;
  obj->m_EnemyObject = m_Enemy;
  obj->m_Direction = 0;
  obj->m_Speed = 0.0;
  obj->m_SpeedR = 0;
  obj->m_AddRoll = 0;
  obj->m_Accelerator = 0;
  obj->m_AcceleratorR = 0;
  obj->m_Limit = 5.0;
  obj->m_LimitR = 30000;
  obj->m_LifeTime = 60;
  obj->m_HitEnable = true;
  obj->m_GrazeEnable = false;
  obj->SetLunaSprite(m_LunaSprite);
  obj->SetManager(man);
  obj->SetMyShip(m_Aim);
  obj->SetEnemyObject(m_Enemy);
  obj->SetLevel(m_Level);
  man->AddBullet(obj);
}

void BulletMaker::make_bullet_002()
{
  BulletMaker *obj;
  BulletManage  *man;
  int  i, n, f, intarval;
  float r, d1, d2;

  man = (BulletManage*)m_Manager;
  n = m_Level;
  if (n > 5) n = 5;
  switch(n) {
  case 1:
    r = 20 * (65536 / 360);
    f = 1;
    intarval = 29;
    break;
  case 2:
    r = 18 * (65536 / 360);
    f = 2;
    intarval = 29;
    break;
  case 3:
    r = 12 * (65536 / 360);
    f = 3;
    intarval = 20;
    break;
  case 4:
    r = 10 * (65536 / 360);
    f = 4;
    intarval = 18;
    break;
  case 5:
    r = 8 * (65536 / 360);
    f = 5;
    intarval = 12;
    break;
  default:
    r = 8 * (65536 / 360);
    f = 5;
    intarval = 12;
    break;
  }

  if ((m_LifeTime % intarval) == 1) {
    obj = new BulletMaker;
    set_obj_002(obj);
    aim_ship(obj, m_Aim);
    obj->m_Speed = 2.0;
    obj->m_LifeTime = 3600;
    man->AddBullet(obj);
    /* -- 扇状 */
    d1 = d2 = obj->m_Direction;
    for(i=0; i<f; i++) {
      d1 += r;
      d2 -= r;
      /* - */
      obj = new BulletMaker;
      set_obj_002(obj);
      obj->m_Direction = d1;
      obj->m_Speed = 2.0;
      obj->m_LifeTime = 3600;
      man->AddBullet(obj);
      /* - */
      obj = new BulletMaker;
      set_obj_002(obj);
      obj->m_Direction = d2;
      obj->m_Speed = 2.0;
      obj->m_LifeTime = 3600;
      man->AddBullet(obj);
    }
  }
}



/* --------------------------------------- */
/* --- 自機狙い one way */
void BulletMaker::request_bullet_003()
{
  BulletMaker *obj;
  BulletManage *man;
  float  r, s;
  int n;

  man = (BulletManage *)m_Manager;

  n = m_Level;
  if (n > 5) n=5;
  switch(n) {
  case 1:
    r = 0;
    s = 0.5;
    break;
  case 2:
    r = 1;
    s = 1.0;
    break;
  case 3:
    r = 200;
    s = 1.5;
    break;
  case 4:
    r = 300;
    s = 2.0;
    break;
  case 5:
    r = 300;
    s = 3.0;
    break;
  default:
    r = 0;
    s = 0.5;
    break;
  }

  obj = new BulletMaker;
  obj->m_Type = 3;
  obj->m_PosX = m_Enemy->m_PosX;
  obj->m_PosY = m_Enemy->m_PosY;
  obj->m_PosCenter = true;
  obj->m_SizeW = 16;
  obj->m_SizeH = 16;
  obj->m_RollZ = 0.0;
  obj->m_Priority = BS_DEPTH_BULLET;
  obj->m_Blend = 1.0;
  obj->m_TexU = 112;
  obj->m_TexV = 32;
  obj->m_TexW = 16;
  obj->m_TexH = 16;
  obj->m_RollZ = 0;
  obj->m_Working = true;
  obj->m_Visible = true;
  obj->m_EnemyObject = m_Enemy;
  obj->m_Direction = (65536 / 4) * 3;
  obj->m_Speed = s;
  obj->m_SpeedR = r;
  obj->m_AddRoll = 0;
  obj->m_Accelerator = 0;
  obj->m_AcceleratorR = 0;
  obj->m_Limit = 5.0;
  obj->m_LimitR = 30000;
  obj->m_LifeTime = 60;
  obj->m_HitEnable = true;
  obj->m_GrazeEnable = false;
  obj->SetLunaSprite(m_LunaSprite);
  obj->SetManager(man);
  obj->SetMyShip(m_Aim);
  obj->SetEnemyObject(m_Enemy);
  obj->SetLevel(m_Level);
  man->AddBullet(obj);
  if (n > 1) {
    obj = new BulletMaker;
    obj->m_Type = 3;
    obj->m_PosX = m_Enemy->m_PosX;
    obj->m_PosY = m_Enemy->m_PosY;
    obj->m_PosCenter = true;
    obj->m_SizeW = 16;
    obj->m_SizeH = 16;
    obj->m_RollZ = 0.0;
    obj->m_Priority = BS_DEPTH_BULLET;
    obj->m_Blend = 1.0;
    obj->m_TexU = 112;
    obj->m_TexV = 32;
    obj->m_TexW = 16;
    obj->m_TexH = 16;
    obj->m_RollZ = 0;
    obj->m_Working = true;
    obj->m_Visible = true;
    obj->m_EnemyObject = m_Enemy;
    obj->m_Direction = (65536 / 4) * 2;
    obj->m_DirectionAdd = (65536 / 4) * 1;
    obj->m_Speed = s;
    obj->m_SpeedR = -r;
    obj->m_AddRoll = 0;
    obj->m_Accelerator = 0;
    obj->m_AcceleratorR = 0;
    obj->m_Limit = 5.0;
    obj->m_LimitR = 30000;
    obj->m_LifeTime = 60;
    obj->m_HitEnable = true;
    obj->m_GrazeEnable = false;
    obj->SetLunaSprite(m_LunaSprite);
    obj->SetManager(man);
    obj->SetMyShip(m_Aim);
    obj->SetEnemyObject(m_Enemy);
    obj->SetLevel(m_Level);
    man->AddBullet(obj);
  }
}

void BulletMaker::make_bullet_003()
{
  BulletMaker *obj;
  BulletManage  *man;
  int  n, intarval;

  man = (BulletManage*)m_Manager;
  n = m_Level;
  if (n > 5) n = 5;
  switch(n) {
  case 1:
    intarval = 29;
    break;
  case 2:
    intarval = 15;
    break;
  case 3:
    intarval = 15;
    break;
  case 4:
    intarval = 12;
    break;
  case 5:
    intarval = 10;
    break;
  default:
    intarval = 15;
    break;
  }

  if ((m_LifeTime % intarval) == 1) {
    obj = new BulletMaker;
    set_obj_003(obj);
    aim_ship(obj, m_Aim);
    obj->m_Speed = 2.5;
    obj->m_LifeTime = 6000;
    man->AddBullet(obj);
  }
}


/* --------------------------------------- */
/* --- 全方位花火 */
void BulletMaker::request_bullet_004()
{
  BulletMaker *obj;
  BulletManage *man;
  float  r, s;
  int n;

  man = (BulletManage *)m_Manager;

  n = m_Level;
  if (n > 5) n=5;
  switch(n) {
  case 1:
    r = 0;
    s = 0.5;
    break;
  case 2:
    r = 0;
    s = 1.0;
    break;
  case 3:
    r = 200;
    s = 1.5;
    break;
  case 4:
    r = 300;
    s = 2.0;
    break;
  case 5:
    r = 300;
    s = 3.0;
    break;
  default:
    r = 0;
    s = 0.5;
    break;
  }

  obj = new BulletMaker;
  obj->m_Type = 4;
  obj->m_PosX = m_Enemy->m_PosX;
  obj->m_PosY = m_Enemy->m_PosY;
  obj->m_PosCenter = true;
  obj->m_SizeW = 16;
  obj->m_SizeH = 16;
  obj->m_RollZ = 0.0;
  obj->m_Priority = BS_DEPTH_BULLET;
  obj->m_Blend = 1.0;
  obj->m_TexU = 112;
  obj->m_TexV = 32;
  obj->m_TexW = 16;
  obj->m_TexH = 16;
  obj->m_RollZ = 0;
  obj->m_Working = true;
  obj->m_Visible = true;
  obj->m_EnemyObject = m_Enemy;
  obj->m_Direction = (65536 / 4) * 3;
  obj->m_Speed = s;
  obj->m_SpeedR = r;
  obj->m_AddRoll = 0;
  obj->m_Accelerator = 0;
  obj->m_AcceleratorR = 0;
  obj->m_Limit = 5.0;
  obj->m_LimitR = 30000;
  obj->m_LifeTime = 60;
  obj->m_HitEnable = true;
  obj->m_GrazeEnable = false;
  obj->SetLunaSprite(m_LunaSprite);
  obj->SetManager(man);
  obj->SetMyShip(m_Aim);
  obj->SetEnemyObject(m_Enemy);
  obj->SetLevel(m_Level);
  man->AddBullet(obj);
  if (n > 2) {
    obj = new BulletMaker;
    obj->m_Type = 4;
    obj->m_PosX = m_Enemy->m_PosX;
    obj->m_PosY = m_Enemy->m_PosY;
    obj->m_PosCenter = true;
    obj->m_SizeW = 16;
    obj->m_SizeH = 16;
    obj->m_RollZ = 0.0;
    obj->m_Priority = BS_DEPTH_BULLET;
    obj->m_Blend = 1.0;
    obj->m_TexU = 112;
    obj->m_TexV = 32;
    obj->m_TexW = 16;
    obj->m_TexH = 16;
    obj->m_RollZ = 0;
    obj->m_Working = true;
    obj->m_Visible = true;
    obj->m_EnemyObject = m_Enemy;
    obj->m_Direction = (65536 / 4) * 2;
    obj->m_DirectionAdd = (65536 / 4) * 1;
    obj->m_Speed = s;
    obj->m_SpeedR = -r;
    obj->m_AddRoll = 0;
    obj->m_Accelerator = 0;
    obj->m_AcceleratorR = 0;
    obj->m_Limit = 5.0;
    obj->m_LimitR = 30000;
    obj->m_LifeTime = 60;
    obj->m_HitEnable = false;
    obj->m_GrazeEnable = false;
    obj->SetLunaSprite(m_LunaSprite);
    obj->SetManager(man);
    obj->SetMyShip(m_Aim);
    obj->SetEnemyObject(m_Enemy);
    obj->SetLevel(m_Level);
    man->AddBullet(obj);
  }
}

void BulletMaker::make_bullet_004()
{
  BulletMaker *obj;
  BulletManage  *man;
  int  i, n, f, intarval;
  float  dr, s, ms, r, dir;

  man = (BulletManage*)m_Manager;
  n = m_Level;
  if (n > 5) n = 5;
  switch(n) {
  case 1:
    intarval = 40;
    f = 10;
    s = 1.0;
    r = 0;
    ms = 1.5;
    break;
  case 2:
    intarval = 40;
    f = 16;
    s = 1.4;
    r = 50;
    ms = 1.8;
    break;
  case 3:
    intarval = 30;
    f = 24;
    s = 1.4;
    r = 50;
    ms = 2.2;
    break;
  case 4:
    intarval = 25;
    f = 28;
    s = 1.8;
    r = 50;
    ms = 2.6;
    break;
  case 5:
    intarval = 16;
    f = 36;
    s = 1.8;
    r = 100;
    ms = 3.0;
    break;
  default:
    intarval = 16;
    f = 36;
    s = 1.8;
    r = 100;
    ms = 3.0;
    break;
  }

  dr = (65536.0 / (float)f);
  dir = 0;
  if ((m_LifeTime % intarval) == 1) {
    for(i=0; i<f; i++) {
      obj = new BulletMaker;
      set_obj_002(obj);
      obj->m_Speed = s;
      obj->m_SpeedR = r;
      obj->m_Accelerator = 0.1;
      obj->m_Limit = ms;
      obj->m_Direction = dir;
      obj->m_LifeTime = 6000;
      man->AddBullet(obj);
      dir += dr;
    }
  }
}




