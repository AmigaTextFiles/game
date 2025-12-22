/* ---------------------------------------------------------- */
/*  GameDirector.h                                            */
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

#ifndef GAMEDIRECTOR_H
#define GAMEDIRECTOR_H

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include "lunavader.h"
#include "basicsystem.h"
#include "panelmanage.h"
#include "myshipmanage.h"
#include "myshotmanage.h"
#include "convoymanage.h"
#include "bulletmanage.h"
#include "bonusshipmanage.h"
#include "backgroundmanage.h"
#include "titlemanage.h"

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
 * @brief ゲーム進行管理クラス
 *        ゲームの進行管理やオブジェクト管理を行い、
 *        実際のゲームがプレイできるように進行を組み立てます
 *
 * @todo -
 * @bug -
 */
class GameDirector
{
  /* ----------------------------------- */
  /* --- コンストラクタ・デストラクタ */
 public:
  GameDirector();
  virtual  ~GameDirector();

  /* ----------------------------------- */
  /* --- パブリックメンバ */
 public:
  //! ゲームスコア
  long  m_Score;
  //! ゲームハイスコア
  long  m_HighScore;
  //! ステージ
  int  m_Stage;

  /* ----------------------------------- */
  /* --- プライベートメンバ */
 private:
  //! ゲームの進行状態を示すステップカウンタ
  int m_GameStep;
  //! 1ゲームにおけるかすりポイントのスコア
  int m_Graze;
  //! ゲーム進行におけるウェイトが必要な時の待機カウンタ
  int m_Wait;
  //! ゲーム進行のポーズ状態を示すフラグ
  bool m_Pause;
  /* -- 関連クラス */
  //! Luna アクセス用インスタンスの保持
  BasicSystem*  m_SystemMan;
  //! スコアパネル表示インスタンス
  PanelManage*  m_PanelMan;
  //! 自機操作管理インスタンスの保持
  MyShipManage*  m_MyShipMan;
  //! 自機発射弾管理インスタンスの保持
  MyShotManage*  m_MyShotMan;
  //! 敵群体管理インスタンスの保持
  ConvoyManage*  m_EnemyMan;
  //! 敵の弾やエフェクトの管理インスタンスの保持
  BulletManage*  m_BulletMan;
  //! UFO管理インスタンスの保持
  BonusShipManage*  m_BonusMan;
  //! 背景管理インスタンスの保持
  BackGroundManage*  m_BgMan;
  //! 背景管理インスタンスの保持
  TitleManage*  m_TitleMan;

  //! 敵歩行音カウンタ
  int m_EnemyWalkCounter;
  //! ローカルタイムカウンター
  int m_Counter;
  //! ボーナス出現タイミング
  int m_BonusTimer;

  /* ----------------------------------- */
  /* --- パブリックメソッド */
 public:
  void SetBasicSystem(BasicSystem* sysclass);
  void Init();
  bool Tick();
  void Pause(bool pause_sw);

  /* ----------------------------------- */
  /* --- プライベートメソッド */
 private:
  void game_init();
  void stage_init();
  bool game_execute();
  bool game_over();

};


#endif

