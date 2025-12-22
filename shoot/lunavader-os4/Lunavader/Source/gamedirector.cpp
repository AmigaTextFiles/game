/* ---------------------------------------------------------- */
/*  gamedirector.cpp                                          */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		ゲーム本体と進行管理
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
#include "gamedirector.h"
#include "lunamath.h"

/*-------------------------------*/
/* define                        */
/*-------------------------------*/

const  int  enemy_walk_sound[22] = {
  0, 1, 2, 3, 2, 1,
  0, 1, 2, 3, 2, 1,
  0, 1, 2, 3, 2, 1,
  4, 5, 4, 6,
};

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
GameDirector::GameDirector()
{
  /* --- 初期化 */
  m_Score = 0;
  m_HighScore = 0;
  m_Graze = 0;
  m_GameStep = 0;
  m_Wait = 0;
  m_Pause = false;
  m_EnemyWalkCounter = 0;
  /* --- 各クラス */
  m_SystemMan = NULL;
  m_PanelMan = NULL;
  m_MyShipMan = NULL;
  m_MyShotMan = NULL;
  m_EnemyMan = NULL;
  m_BulletMan = NULL;
  m_BonusMan = NULL;
  m_BgMan = NULL;
  m_TitleMan = NULL;
  /* --- ローカルカウンター */
  m_Counter = 0;
}


/**
 * デストラクタ(後始末)
 */
GameDirector::~GameDirector()
{
  if (m_PanelMan) {
    delete m_PanelMan;
  }
  if (m_MyShipMan) {
    delete m_MyShipMan;
  }
  if (m_MyShotMan) {
    delete m_MyShotMan;
  }
  if (m_BulletMan) {
    delete m_BulletMan;
  }
  if (m_BonusMan) {
    delete m_BonusMan;
  }
  if (m_BgMan) {
    delete m_BgMan;
  }
  if (m_TitleMan) {
    delete m_TitleMan;
  }
}



/*------------------------------------------------------*/
/* interface                                            */
/*------------------------------------------------------*/

/* ----------------------------------------- */
/* --- SetBasicSystem() */
/**
 * 上位で作成した BasicSystem インスタンスを渡してもらう
 * スプライト以外の Luna アクセスは渡してもらったインスタンス
 * にてほとんどが隠蔽、抽象化される事になる。
 * 例外は SpriteItem による 1スプライトの描画部分。
 *
 * @param sysclass [in] BasicSystemのインスタンス
 * @return 無し
 *
 */
void GameDirector::SetBasicSystem(BasicSystem* sysclass)
{
  m_SystemMan = sysclass;

}


/* ----------------------------------------- */
/* --- Init() */
/**
 * ゲームの状態を初期化する。
 * コンストラクタとほぼ同じ動作をするが、こちらは
 * 上位でクラスをオープンしたままの状態で新規ゲームを
 * 開始したい場合に有効。
 *
 * @return 無し
 *
 */
void GameDirector::Init()
{
  BulletMaker  *obj;

  /* --- 初期化 */
  m_Score = 0;
  m_HighScore = 0;
  m_Graze = 0;
  m_GameStep = 0;
  m_Wait = 0;
  m_Pause = false;

  /* --- インスタンスの生成 */
  m_PanelMan = new PanelManage;
  m_MyShipMan = new MyShipManage;
  m_MyShotMan = new MyShotManage;
  m_EnemyMan = new ConvoyManage;
  m_BulletMan = new BulletManage;
  m_BonusMan = new BonusShipManage;
  m_BgMan = new BackGroundManage;
  m_TitleMan = new TitleManage;

  /* --- スプライトハンドルの定義 */
  if (m_SystemMan) {
    m_PanelMan->SetLunaSprite(m_SystemMan->screen);
  }
  if (m_SystemMan) {
    m_MyShipMan->SetLunaSprite(m_SystemMan->screen);
  }
  if (m_SystemMan) {
    m_MyShotMan->SetLunaSprite(m_SystemMan->screen);
  }
  if (m_EnemyMan) {
    m_EnemyMan->SetLunaSprite(m_SystemMan->screen);
  }
  if (m_BonusMan) {
    m_BonusMan->SetLunaSprite(m_SystemMan->screen);
  }
  if (m_BgMan) {
    m_BgMan->SetLunaSprite(m_SystemMan->screen);
  }
  if (m_TitleMan) {
    m_TitleMan->SetLunaSprite(m_SystemMan->screen);
  }

  /* --- 敵管理用弾幕生成インスタンス */
  obj = new BulletMaker;
  obj->SetMyShip(m_MyShipMan);
  obj->SetLunaSprite(m_SystemMan->screen);
  obj->SetManager(m_BulletMan);
  m_EnemyMan->SetBulletMaker(obj);

  /* --- クラスの初期化 */
  game_init();

  /* --- ステージの初期化 */
  stage_init();

}


/* ----------------------------------------- */
/* --- Tick() */
/**
 * ゲーム進行管理実動作部分。
 * 毎フレームごとにコールすること。
 *
 * @return trueでゲーム進行中、false でゲーム終了
 *
 */
bool GameDirector::Tick()
{
  unsigned char  line[128];

  m_Counter += 1;
#ifdef DEBUG
  /* --- 実験用 clock 表示 */
  sprintf((char*)line, "Clock: %d", m_Counter);
  m_SystemMan->AddDebugMessage(line);
#endif


  switch(m_GameStep) {
  case 0:
    m_TitleMan->Init();
    m_GameStep = 1;
    break;

  case 1:
    if (m_TitleMan->Tick(m_SystemMan->GetKeyInputTriger()) == false) {
      m_GameStep = 2;
    }
    if (m_TitleMan->Start()) {
      m_SystemMan->PlaySoundEffect(8);
    }
    m_TitleMan->Display();
    break;
 
  case 2:
    game_init();
    stage_init();
    /* rand seed initialize */
    LunaMath::Initialize(m_Counter);
    m_GameStep = 3;
    break;

  case 3:
    /* --- ゲーム本体 */
    if (game_execute() == false) {
      m_Wait = 90;
      m_GameStep = 4;
    }
    break;

  case 4:
    /* --- ゲームオーバー処理 */
    if (game_over() == false) {
      m_GameStep = 0;
    }
    break;
  }

  return(true);
}


/* ----------------------------------------- */
/* --- Pause() */
/**
 * ゲーム進行の一時停止状態をセットする。
 * 一時停止は毎フレームの Tick() が止められない場合とか
 * 停止はしたいが画面は表示されていて欲しい場合に用いる。
 *
 * @param pause_sw [in] true で一時停止、false で通常進行
 * @return 無し
 *
 */
void GameDirector::Pause(bool pause_sw)
{
}


/*------------------------------------------------------*/
/* local work                                           */
/*------------------------------------------------------*/

/* --- game_init() */
/**
 * ゲーム進行の初期化。
 * コンストラクタや Init() の実体。
 *
 * @return 無し
 *
 */
void GameDirector::game_init()
{
  m_MyShipMan->Init();
  m_BonusMan->SetCharactor(SIENSIDE);
  m_Stage = 1;
  m_Score = 0;
  m_Graze = 0;
  m_PanelMan->SetHighScore(m_HighScore);
  m_PanelMan->SetGameOver(false);
  m_BgMan->Init();
  m_BgMan->SetBlend(0.0);
}

/* --- stage_init() */
/**
 * 1ステージ終了(開始)時の初期化作業。
 * 主に敵の群体初期化と生成。
 *
 * @return 無し
 *
 */
void GameDirector::stage_init()
{
  m_EnemyMan->Init(m_Stage);
  m_BonusTimer = 1200 + LunaMath::Rand(0, 1200);
  m_PanelMan->SetStage(m_Stage);
  m_BulletMan->Init();
}


/* --- game_over() */
/**
 * ゲームオーバー時の表示と進行処理など。
 *
 * @return true で作業中、false で作業終了
 *
 */
bool GameDirector::game_over()
{
  bool result;
  result = false;

  /* --- ゲームオーバーの表示 */
  m_PanelMan->SetGameOver(true);
  m_PanelMan->Tick();

  /* --- スプライト表示 */
  m_BgMan->Display();
  m_MyShotMan->Display();
  m_MyShipMan->Display();
  m_BonusMan->Display();
  m_BulletMan->Display();
  m_PanelMan->Display();

  m_Wait -= 1;
  if (m_Wait == 0) {
    result = false;
    /* -- ハイスコアの更新など */
    if (m_Score > m_HighScore) {
      m_HighScore = m_Score;
    }
  }
  else {
    result = true;
  }

  return(result);
}

/* --- game_execute() */
/**
 * ゲームをゲームたらしめる実装部分。
 * 各オブジェクトの操作と連携を司るゲーム本体部分。
 *
 * @return true で作業中、false でゲーム終了
 *
 */
bool GameDirector::game_execute()
{
  bool  result;
  int  score, graze;
  int  num;
  float bgblend;

  result = true;

  /* --- 背景 */
  if (m_EnemyMan->GetRestEnemy() == (CV_COLUMN * CV_ROW)) {
    bgblend = 0.0001;
  }
  else {
    bgblend = (float)((CV_COLUMN * CV_ROW) -
		      m_EnemyMan->GetRestEnemy());
    bgblend = bgblend / (float)(CV_COLUMN * CV_ROW);
  }
  m_BgMan->SetBlend(bgblend);
  m_BgMan->Tick();
  m_BgMan->Display();

  /* --- スコアパネル */
  m_PanelMan->SetScore(m_Score);
  m_PanelMan->SetGraze(m_Graze);
  m_PanelMan->Tick();

  /* --- 自機移動 */
  m_MyShipMan->Tick(m_SystemMan->GetKeyInput(),
		    m_SystemMan->GetKeyInputTriger());

  /* --- ショット発射 */
  if (m_SystemMan->GetKeyInputTriger() & BS_INPUT_BUTTON1) {
    if (m_MyShotMan->Shoot(m_MyShipMan)) {
      /* - ショット音 */
      m_SystemMan->PlaySoundEffect(9);
    }
  }
  m_MyShotMan->Tick();

  /* --- 敵移動 */
  if (m_EnemyMan->Tick()) {
    /* - 敵歩行音 */
    m_SystemMan->PlaySoundEffect(enemy_walk_sound[m_EnemyWalkCounter]+1);
    m_EnemyWalkCounter = (m_EnemyWalkCounter + 1) % 22;
  }

  /* --- 自機ショットと敵との判定 */
  score = m_EnemyMan->CheckHit(m_MyShotMan);
  if (score > 0) {
    /* -- 敵に当たった音 */
    m_SystemMan->PlaySoundEffect(11);
    m_Score += score;
  }

  /* --- 弾移動管理 */
  m_BulletMan->Tick();
  if (m_BulletMan->CheckHit(m_MyShipMan)) {
    /* - 敵の弾に当たった */
    m_SystemMan->StopMusic();
    m_SystemMan->PlaySoundEffect(10);
    result = false;
  }
  graze = m_BulletMan->GetGraze();
  if (graze > 0) {
    /* - 弾にかすった音 */
    m_SystemMan->PlaySoundEffect(13);
    m_Graze += graze;
    m_Score += graze * 100;
  }

  /* --- ボーナス船管理 */
  /* 移動と当たり判定 */
  if (m_BonusMan->GetState()) {
    if (m_BonusMan->Tick() == false) {
      m_BonusTimer = 600 + LunaMath::Rand(0, 600);
      m_SystemMan->StopMusic();
    }
    if (m_BonusMan->CheckHit(m_MyShotMan)) {
      m_Score += m_BonusMan->GetScore();
      /* -- Hit エフェクト */
      {
	BulletMaker maker;
	maker.SetLunaSprite(m_SystemMan->screen);
	maker.SetManager(m_BulletMan);
	maker.RequestEffect(2,
			    m_BonusMan->m_PosX,
			    m_BonusMan->m_PosY);
      }
      /* -- 敵に当たった音 */
      m_SystemMan->StopMusic();
      m_SystemMan->PlaySoundEffect(12);
      m_BonusTimer = 600 + LunaMath::Rand(0, 600);
    }
  }
  else {
    if (m_BonusTimer == 0) {
      m_BonusMan->SetScore(5000 *  LunaMath::Rand(1, 6));
      m_BonusMan->Start();
      m_SystemMan->PlayMusic(1);
    }
    else {
      m_BonusTimer -= 1;
    }
  }


  /* - 敵がいなくなったら次の面へ */
  if (m_EnemyMan->GetRestEnemy() == 0) {
    m_Score += m_BulletMan->DisableAllBullet() * 10;
    m_Stage += 1;
    stage_init();
  }

  /* --- スプライト表示 */
  m_MyShotMan->Display();
  m_MyShipMan->Display();
  m_BonusMan->Display();
  num = m_BulletMan->Display();
  m_PanelMan->Display();

#ifdef DEBUG
  /* --- 弾オブジェクトの数 */
  {
    unsigned char *line;
    line = new unsigned char[127];
    sprintf((char*)line, "Bullet Num: %d", num);
    m_SystemMan->AddDebugMessage(line);
    sprintf((char*)line, "Bonus Ship Timer: %d", m_BonusTimer);
    m_SystemMan->AddDebugMessage(line);
    delete line;
  }
#endif

  return(result);
}

