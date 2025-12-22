
// Adjusted for MinGW
// Added bypass dialog for forcesetup = 0
// Added extra gamers, maps, saved to menu
// Added extra multiplay to menu
// Added MenuBypass for batchfile or playduke
// Added Gametype to multiplay
// Added player color to multiplay
// Fixed crash from eduke gameE_00.sav
// Added .ogg and .wav files to search
// Added Disable Hirespacks
// Added NoHrp
// Added pathsearchmode for getfiles
// Added maps played in start menu
// Added addon and maps saved games
// Added hide batch cmd
// Added tab help information
// Added load auto saved game
// Added -by detection to bypass menu / press(x)
// MUI Rewrite

#include "duke3d.h"
#include "sounds.h"

#include "build.h"
#include "compat.h"

#include "grpscan.h"

#include "config.h"

#include <stdio.h>

#define TAB_MEDA 0
#define TAB_GAME 1
#define TAB_MULT 2
#define TAB_HELP 3
#define TAB_MESG 4

int iPage = 0;

static struct
{
	int fullscreen;
	int widescreen;
	int brightness;
	int stereo;
	int xdim, ydim, bpp;
	int forcesetup;
	int usemouse, usejoy;
	char  selectedgrp[BMAX_PATH+1];
	int game;
    int ambience;
    int duketalk;
} settings;

static int done = -1, mode = TAB_MEDA;

//-------------------------- startup menu settings -------------------------

static CACHE1D_FIND_REC *finddirs, *findfiles;                       // wxrm

char  sFolder1[80];                                                  // 20100206
char  sFolder2[80];                                                  // 20100206

char  RootFolder[128];                                               // wxsm
char  MapsFolder[80];                                                // wxsm
char  MusicFolder[80];                                               // wxsm
char  GameFolder[80];                                                // wxsm

char  LastMapsFolder[80];                                            // wxsm
char  LastMusicFolder[80];                                           // wxsm
char  LastGameFolder[80];                                            // wxsm

int   Mapnum = 0;
char  MenuMap[80];                                                   // wxsm
char  MenuMusic[80];                                                 // wxsm
char  MenuGame[80];                                                  // wxsm
char  GameMap[40];                                                   // wxsm
char  LastMap[40];
char  LastGame[40];

char  SaveLabel[80];                                                 //
char  UserSaves[11][80];                                             // wxsm
int   GameSaved[11];                                                 // wxsm
short NumSaves;                                                      // wxsm

short UserSavenum = -1;                                              // wxsm
short iLevelNum = -1;                                                // wxsm
short iSkill = 3;                                                    // wxsm
short MenuBypass;                                                    // wxmb
short iType = 0;                                                     // wxdm
short iColr = 0;                                                     // wxdm
short iSpawn = 0;
short mapvis=0;                                                      // 20100205

char  IPAddress[32];                                                 // wxsm
short SelectMulti = -1;                                              // wxsm
short HostMulti = -1;                                                // wxsm
short PlayerNum = 2;                                                 // wxmp
short iDedicated = -1;                                               // wxmp
short FakePlayer = -1;                                               // wxmp
short NumBots = 1;                                                   // wxmp
short LCD;                                                           // wxga

char *GameTypes[3] = {"Dukematch Spawn", "Cooperative", "Dukematch No Spawn"}; // wxdm
extern char *PlayerColor[10];                                        // wxdm
extern char PlayerNameArg[32];
extern char IPAddressArg[8][40];                                     // wxsm
extern short LcdMon;                                                 // wxga
extern int32 NoHrp;                                                  // wxnh
extern int is_vista;                                                 // wxvi

long PreCache=1, TexCache=0, Tiles=1, Model=1, TexComp=0;

int ivoices[8] = {1,2,4,8,12,16,24,32};
//int isample[7] = {8000, 11025, 16000, 22050, 32000, 44100, 48000};
int isample[5] = {16000, 22050, 32000, 44100, 48000};

char *Player[8] = {"1", "2","3","4","5","6","7","8"};
char *Voices[8] = {"1","2","4","8","12","16","24","32"};
//char *Sample[7] = {"8000", "11025", "16000", "22050", "32000", "44100", "48000"};
char *Sample[5] = {"16000", "22050", "32000", "44100", "48000"};

char *defgames[41] = {"e1l1.map", "e1l2.map", "e1l3.map", "e1l4.map", "e1l5.map", "e1l6.map",
                      "e1l7.map", "e1l8.map", //"e1l9.map", "e1l10.map",  "e1l11.map",
                      "e2l1.map", "e2l2.map", "e2l3.map", "e2l4.map", "e2l5.map", "e2l6.map",
                      "e2l7.map", "e2l8.map", "e2l9.map", "e2l10.map",  "e2l11.map",
                      "e3l1.map", "e3l2.map", "e3l3.map", "e3l4.map", "e3l5.map", "e3l6.map",
                      "e3l7.map", "e3l8.map", "e3l9.map", "e3l10.map",  "e3l11.map",
                      "e4l1.map", "e4l2.map", "e4l3.map", "e4l4.map", "e4l5.map", "e4l6.map",
                      "e4l7.map", "e4l8.map", "e4l9.map", "e4l10.map",  "e4l11.map"};

//--------------------------------------------------------------------------

int startwin_run(void)
{
  initprintf("STUB: startmui.game.c startwin_run()\n");
  return 1;
}

void Showhelp(short x)
{
  initprintf("STUB: startmui.game.c Showhelp()\n");
}