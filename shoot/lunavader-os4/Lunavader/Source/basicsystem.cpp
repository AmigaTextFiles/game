/* ---------------------------------------------------------- */
/*  basicsystem.cpp                                           */
/* ---------------------------------------------------------- */

/*------------------------------------------------------------- */
/** @file
    @brief		system の隠蔽と抽象化
    @author		K.Kunikane (れろれろ＠ふみ)
    @since		Feb.12.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2005 rero2@fumi <rero2@yuumu.org>
 All Rights Reserved.

 Convert to PSP - Oct.15.2006
 ------------------------------------------------------*/

/*-------------------------------*/
/* include                       */
/*-------------------------------*/
#include "basicsystem.h"

/*-------------------------------*/
/* define                        */
/*-------------------------------*/

/* --- テクスチャファイル名 */
char* texture_name[] = {
#ifdef __AMIGA__
  "data/texture1.png",
  "data/clip1.png",
#else
  "texture1.png",
  "clip1.png",
#endif
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
BasicSystem::BasicSystem()
{
}


/**
 * デストラクタ(後始末)
 */
BasicSystem::~BasicSystem()
{
  StopMusic();
  /* --- Luna ハンドルの解放(残っていたら) */
  Release();
}



/*------------------------------------------------------*/
/* interface                                            */
/*------------------------------------------------------*/

/* ----------------------------------------- */
/* --- Init() */
/**
 * テクスチャ読み込み等の作業を行う。
 * これら作業は construct 時には行われず Init にて行われる。
 *
 * @return 無し
 *
 */
void BasicSystem::Init()
{
  /* --- サウンドの初期化 */
  SoundMusicStop();
  SoundSEStop();

  /* --- テクスチャの初期化 */
  if (screen != 0) {
#ifdef __PSP__
    TGameScreen_LoadTexture(screen, 0, texture_name[0]);
    TGameScreen_LoadTexture(screen, 1, texture_name[1]);
#else
    TGameScreen_LoadTexturePure(screen, 0, texture_name[0]);
    TGameScreen_LoadTexturePure(screen, 1, texture_name[1]);
#endif
  }
}

/* ----------------------------------------- */
/* --- Release() */
/**
 * Luna が管理するハンドルを解放する
 *
 * @return 無し
 *
 */
void BasicSystem::Release()
{
  /* - なにかありましたら */
}

/* ----------------------------------------- */
/* --- Tick() */
/**
 * 毎フレームごとの作業を行う。
 * 具体的には Input 読み取りとスプライトバッファの一括描画。
 *
 * @return 無し
 *
 */
void BasicSystem::Tick()
{
  /* --- 次フレームに向けたスプライトのリセット */
  TGameScreen_ClearSprite(screen);
}

/* ----------------------------------------- */
/* --- DisplayUpdate() */
/**
 * スプライトバッファの更新作業
 * Sync ウェイトの前に入れてコール
 *
 * @return 無し
 *
 */
void BasicSystem::DisplayUpdate()
{
  /* --- 次フレームに向けたスプライトのアップデート */
}


/* ----------------------------------------- */
/* --- GetSpriteNext() */
/**
 * スプライトオブジェクトを一つ取得する
 *
 * @return 無し
 *
 */
TGameSprite *BasicSystem::GetSpriteNext()
{
  return(TGameScreen_GetSpriteSerial(screen));
}


/* ----------------------------------------- */
/* --- GetKeyInput() */
/**
 * 操作入力を渡す。
 *
 * @return 無し
 *
 */
unsigned long BasicSystem::GetKeyInput()
{
  return(InputJoyKey(0));
}

/* ----------------------------------------- */
/* --- GetKeyInputTriger() */
/**
 * 操作入力のトリガー状況を渡す。
 *
 * @return 無し
 *
 */
unsigned long BasicSystem::GetKeyInputTriger()
{
  return(InputJoyKeyTriger(0));
}


/* ----------------------------------------- */
/* --- PlaySoundEffect() */
/**
 * 指定した番号の効果音を一回鳴らします
 *
 * @param num [in] 鳴らす効果音の番号
 * @return 無し
 *
 */
void BasicSystem::PlaySoundEffect(int num)
{
  SoundSE(num);
}

/* ----------------------------------------- */
/* --- PlayMusic() */
/**
 * 指定した番号のサウンドをストリーム演奏開始する
 *
 * @param num [in] 鳴らす効果音の番号
 * @return 無し
 *
 */
void BasicSystem::PlayMusic(int num)
{
  SoundMusic(num);
}

/* ----------------------------------------- */
/* --- StopMusic() */
/**
 * 現在ストリーム演奏中だったらそれを停止する
 *
 * @return 無し
 *
 */
void BasicSystem::StopMusic()
{
  SoundMusicStop();
}

/* ----------------------------------------- */
/* --- AddDebugMessage() */
/**
 * デバッグ用表示文字列の追加
 *
 * @param line [in] デバッグ表示する string
 * @return 無し
 *
 */
void BasicSystem::AddDebugMessage(unsigned char *line)
{
#ifdef DEBUG
  TDebugPrint((char*)line);
#endif
}


/*------------------------------------------------------*/
/* local work                                           */
/*------------------------------------------------------*/

