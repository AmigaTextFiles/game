/* ---------------------------------------------------------- */
/*  sound.h                                                   */
/* ---------------------------------------------------------- */

/*--------------------------------------------------------*/
/*                                                        */
/* SDL puzzle project - for COMIKET62                     */
/*                        Fumi2Kick/LiMo/omamori-2002     */
/*                        1st Maintaner  Rerorero@fumi.   */
/*                                                        */
/*   sound.h                                              */
/*     音声マネージャ                                     */
/*                                                        */
/*--------------------------------------------------------*/
/* -- $Id:  $ */


/*------------------------------------------------------------- */
/** @file
    @brief		音声マネージャ
    @author		K.Kunikane (rerofumi)
    @since		Sep.04.2005
    $Revision: 1.1.1.1 $
*/
/*-----------------------------------------------------
 Copyright (C) 2002,2005 rerofumi <rero2@yuumu.org>
 All Rights Reserved.
 ------------------------------------------------------*/


#ifndef SOUND_H
#define SOUND_H

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

/*-------------------------------*/
/* define                        */
/*-------------------------------*/

/* --- サウンド一覧表のファイルネーム */
#ifdef __AMIGA__
#define   SOUND_LIST_FILE "Data/SOUNDDAT.LST"
#else
#define   SOUND_LIST_FILE "SOUNDDAT.LST"
#endif

/* --- BGM の管理最大数 */
#define BGMMAX  32

/* --- SE の管理最大数 */
#define SEMAX   64


/*-------------------------------*/
/* struct                        */
/*-------------------------------*/

/* ---------------------------------------------- */
/* --- extern                                  -- */
/* ---------------------------------------------- */

void  SoundInit(void);
void  SoundFree(void);
void  SoundMusic(int req);
void  SoundMusicOneshot(int req);
void  SoundSE(int req);
void  SoundMusicStop(void);
void  SoundSEStop(void);

#endif //SOUND_H






