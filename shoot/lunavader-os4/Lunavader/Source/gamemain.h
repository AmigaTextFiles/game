/* ---------------------------------------------------------- */
/*  gamemain.h                                                */
/* ---------------------------------------------------------- */

/*--------------------------------------------------------*/
/*                                                        */
/* Toho ShienSo for PSP                                   */
/*                        Fumi2Kick                       */
/*                        1st Maintaner  rerofumi.        */
/*                                                        */
/*   gamemain.h                                           */
/*     ゲームの本体フロー                                 */
/*                                                        */
/*--------------------------------------------------------*/

#ifndef GAMEMAIN_H
#define GAMEMAIN_H

/*-------------------------------*/
/* include                       */
/*-------------------------------*/

#include "SDL.h"
#include "grp_screen.h"
#include "basicsystem.h"
#include "gamedirector.h"

/*-------------------------------*/
/* define                        */
/*-------------------------------*/

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif


/*-------------------------------*/
/* struct                        */
/*-------------------------------*/

typedef struct {
  int  titletimer;
  SDL_Surface  *tex;
  TGameScreen  *screen;
  int  step;

  /* ----- ここから下は各ゲーム専用のワークとして使ってください */

} TGameMain, *PTGameMain;

/* ---------------------------------------------- */
/* --- extern                                  -- */
/* ---------------------------------------------- */

#ifdef __cplusplus
extern "C" {
#endif	//__cplusplus

TGameMain *TGameMain_Create(TGameScreen *mainscreen);
void TGameMain_Destroy(TGameMain *pclass);

int TGameMain_Poll(TGameMain *pclass,
		   int  counter);

#ifdef __cplusplus
}
#endif  //__cplusplus


#endif //GAMEMAIN_H
