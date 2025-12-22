//-------------------------------------------------------------------------
/*
Copyright (C) 1996, 2003 - 3D Realms Entertainment

This file is part of Duke Nukem 3D version 1.5 - Atomic Edition

Duke Nukem 3D is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

Original Source: 1996 - Todd Replogle
Prepared for public release: 03/21/2003 - Charlie Wiederhold, 3D Realms
Modifications for JonoF's port by Jonathon Fowler (jonof@edgenetwk.com)
*/
//-------------------------------------------------------------------------

// Removed the || RMB in line 1709 so "Load last save game" waits
// Added second_tics
// Added GetMapName
// Remove Show startup window
// Remove disabling of menu stuff ps[myconnectindex].gm&MODE_GAME
// Renamed keys setup to keyboard setup and change color
// Removed Atomic tectures in Menu
// Added only 'maps' folders for user maps
// Added More Video Options menu
// Fixed Screen sizes
// Renamed keyboard setup back to keys setup
// Added max/min/off crosshair
// Moved Screen Size and Statusbar size to Video Options
// Added Screen Messages option
// Added WeaponIcons option
// Added Multiplayer fix
// Added RandomMusic
// Added MapMusic
// Added autosave option when add health/shield
// Added MusicDir
// Added GetMusicFiles
// Added change game10.sav to gamex.asv for playduke
// Added AutoSave manual mode
// Added small icon for saved games
// Version 4.1.0 - JUNE - 2009
// Modified for MinGW/Msys
// Added extra AUTOSAVED GAME to menu
// Added Startup menu option
// Added Duke3dw version to Options Menu
// Changed myname to playernamearg
// Added fix for multiplay maps
// Added several multiplay stuff
// Added no USER MAP display if bGrp
// Added back original small hud with extras
// Added range on brightness from step 8 to 4
// Added medium size sliders and nuke
// Version 4.1.3
// Added MenuBypass for batchfile or playduke
// Added Quit to Start menu option
// Added new multiplayer code
// Added new multiplayer menu
// Added Playername and Color
// Added multiplayer scoreboard F1 case 1234:
// 4.1.4
// Added MusicDir (scan for music directory)
// Added Select Music menu
// Fixed music volume
// 4.1.5
// Moved weapon icons to video options
// Added invisible player weapon option
// 4.1.6
// Added MusicList for music files not needing all 3 types
// Added svgame for each .grp addon
// Increased default skill to come get some
// 4.2.0
// Added save game desc last line
// 4.2.1
// Added vsync
//

#include "duke3d.h"
#include "mouse.h"
#include "animlib.h"
#include "osd.h"
#include <sys/stat.h>


struct savehead
{
    char name[19];
    int32 numplr,volnum,levnum,plrskl;
    char boardfn[BMAX_PATH];
};
int xCol = 0;             // test only colors at GAME autoaim
short iLast=0;

extern char **HEAD2W;
extern char MapMusic[128];
extern char MusicFolder[80];

int  MusicList = 0;   // for currentlist
int  MusicDir = 0;
int  GetRandom(short num);
int  GetMusicFiles(void);
int  MusicNum = 0;
int  MusicCur = 0;
int  MusicPos = 0;
char MusicFiles[301][32];
char MusicName[128]="";
char MyMusic[12][32];

extern void SendPlayerInfo(void);
extern int32 bGrp;
extern short MenuBypass;
extern int32 bHost;
extern int vsync;

char *NetworkType[2]  = {"NETWORK CLIENT","NETWORK HOST"};
char *PlayerColor[10] = {"Auto","Blue","Red","Olive","White","Gray","Green","Brown","Navy","Yellow"};

extern char inputloc;
extern int recfilep;
//extern char vgacompatible;
short probey=0,lastprobey=0,last_menu,globalskillsound=-1;
short sh,onbar,buttonstat,deletespot;
short last_zero,last_fifty,last_threehundred = 0;

static char fileselect = 1, menunamecnt, menuname[256][64], curpath[80], menupath[80];

static CACHE1D_FIND_REC *finddirs=NULL, *findfiles=NULL, *finddirshigh=NULL, *findfileshigh=NULL;
static int numdirs=0, numfiles=0;
static int currentlist=0;

static int function, whichkey;
static int changesmade, newvidmode, curvidmode, newfullscreen;
static int vidsets[16] = { -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1 }, curvidset, newvidset = 0;

static char *mousebuttonnames[] = { "Left", "Right", "Middle", "Thumb", "Wheel Down", "Wheel Up" };


void cmenu(short cm)
{
    current_menu = cm;

    if( (cm >= 1000 && cm <= 1009) )
        return;

    if( cm == 0 )
        probey = last_zero;
    else if(cm == 50)
        probey = last_fifty;
    else if(cm >= 300 && cm < 400)
        probey = last_threehundred;
    else if(cm == 110)
        probey = 2;                                                  // wxsk
    else probey = 0;
    lastprobey = -1;
}


void savetemp(char *fn,long daptr,long dasiz)
{
    FILE *fp;

    if ((fp = fopen(fn,"wb")) == (FILE *)NULL)
        return;

    fwrite((char *)daptr,dasiz,1,fp);

    fclose(fp);
}

void getangplayers(short snum)
{
    short i,a;

    for(i=connecthead;i>=0;i=connectpoint2[i])
    {
        if(i != snum)
        {
            a = ps[snum].ang+getangle(ps[i].posx-ps[snum].posx,ps[i].posy-ps[snum].posy);
            a = a-1024;
            rotatesprite(
                (320<<15) + (((sintable[(a+512)&2047])>>7)<<15),
                (320<<15) - (((sintable[a&2047])>>8)<<15),
                klabs(sintable[((a>>1)+768)&2047]<<2),0,APLAYER,0,ps[i].palookup,0,0,0,xdim-1,ydim-1);
        }
    }
}

int loadpheader(char spot, struct savehead *saveh)
{
    long i;
    char fn[40];
    long fil;
    long bv;
    short ln = strlen(svgame);

    if (spot == 10)                                                  // wxas
        Bsprintf(fn, "%sgamex.asv", svgame);
    else
    {
        Bsprintf(fn, "%sgame0.sav", svgame);                         // wxvg
        fn[4+ln] = spot+'0';
    }

    if ((fil = kopen4load(fn,0)) == -1) return(-1);

    walock[TILE_LOADSHOT] = 255;

    if (kdfread(&bv,4,1,fil) != 1) goto corrupt;
    if(bv != BYTEVERSION)
    {
        FTA(114,&ps[myconnectindex]);
        kclose(fil);
        return 1;
    }

    if (kdfread(&saveh->numplr,sizeof(int32),1,fil) != 1) goto corrupt;

    if (kdfread(saveh->name,19,1,fil) != 1) goto corrupt;
    if (kdfread(&saveh->volnum,sizeof(int32),1,fil) != 1) goto corrupt;
    if (kdfread(&saveh->levnum,sizeof(int32),1,fil) != 1) goto corrupt;
    if (kdfread(&saveh->plrskl,sizeof(int32),1,fil) != 1) goto corrupt;
    if (kdfread(saveh->boardfn,BMAX_PATH,1,fil) != 1) goto corrupt;

    if (waloff[TILE_LOADSHOT] == 0) allocache(&waloff[TILE_LOADSHOT],320*200,&walock[TILE_LOADSHOT]);
    tilesizx[TILE_LOADSHOT] = 200; tilesizy[TILE_LOADSHOT] = 320;
    if (kdfread((char *)waloff[TILE_LOADSHOT],320,200,fil) != 200) goto corrupt;
    invalidatetile(TILE_LOADSHOT,0,255);

    kclose(fil);

    return(0);
corrupt:
    kclose(fil);
    return 1;
}

int loadplayer(signed char spot)
{
     short k;
     char fn[40];
     char mpfn[13];
     char *fnptr, scriptptrs[MAXSCRIPTSIZE];
     long fil, bv, i, j, x;
     int32 nump;
     short ln = strlen(svgame);

     if (spot == 10)
     {
        if (ud.multimode > 1)
            return -1;
        Bsprintf(fn, "%sgamex.asv", svgame);
     }
     else
     {
        Bsprintf(fn, "%sgame0.sav", svgame);                         // wxvg
     }

     strcpy(mpfn, "gameA_00.sav");

     if (spot < 0)
     {
        multiflag = 1;
        multiwhat = 0;
        multipos = -spot-1;
        return -1;
     }

     if ( multiflag == 2 && multiwho != myconnectindex )
     {
         fnptr = mpfn;
         mpfn[4] = spot + 'A';

         if (ud.multimode > 9)
         {
             mpfn[6] = (multiwho/10) + '0';
             mpfn[7] = (multiwho%10) + '0';
         }
         else mpfn[7] = multiwho + '0';
     }
     else
     {
        fnptr = fn;
        if (spot < 10)
            fn[4+ln] = spot + '0';
     }

     if ((fil = kopen4load(fnptr,0)) == -1) return(-1);

     ready2send = 0;

     if (kdfread(&bv,4,1,fil) != 1) return -1;
     if(bv != BYTEVERSION)
     {
        FTA(114,&ps[myconnectindex]);
        kclose(fil);
        ototalclock = totalclock;
        ready2send = 1;
        return 1;
     }

     if (kdfread(&nump,sizeof(nump),1,fil) != 1) return -1;
     if(nump != numplayers)
     {
        kclose(fil);
        ototalclock = totalclock;
        ready2send = 1;
        FTA(124,&ps[myconnectindex]);
        return 1;
     }

     if (numplayers > 1)
     {
         pub = NUMPAGES;
         pus = NUMPAGES;
         vscrn();
         drawbackground();
         menutext(160,100,0,0,"LOADING...");
         nextpage();
    }

     waitforeverybody(11);                                            // wxdm

     FX_StopAllSounds();
     clearsoundlocks();
     stopmusic();

     if (numplayers > 1)
        {
        if (kdfread(&buf,19,1,fil) != 1)
            goto corrupt;
        }
     else
        {
        if (spot == 10)
           {
           if (kdfread(&ud.autobuff[0][0],19,1,fil) != 1)
               goto corrupt;
           }
        else
        if (kdfread(&ud.savegame[spot][0],19,1,fil) != 1)
            goto corrupt;
        }

//     music_changed = (music_select != (ud.volume_number*11) + ud.level_number);

         if (kdfread(&ud.volume_number,sizeof(ud.volume_number),1,fil) != 1) goto corrupt;
         if (kdfread(&ud.level_number,sizeof(ud.level_number),1,fil) != 1) goto corrupt;
         if (kdfread(&ud.player_skill,sizeof(ud.player_skill),1,fil) != 1) goto corrupt;
     if (kdfread(&boardfilename[0],BMAX_PATH,1,fil) != 1) goto corrupt;

         ud.m_level_number = ud.level_number;
         ud.m_volume_number = ud.volume_number;
         ud.m_player_skill = ud.player_skill;

                 //Fake read because lseek won't work with compression
     walock[TILE_LOADSHOT] = 1;
     if (waloff[TILE_LOADSHOT] == 0) allocache(&waloff[TILE_LOADSHOT],320*200,&walock[TILE_LOADSHOT]);
     tilesizx[TILE_LOADSHOT] = 200; tilesizy[TILE_LOADSHOT] = 320;
     if (kdfread((char *)waloff[TILE_LOADSHOT],320,200,fil) != 200) goto corrupt;
     invalidatetile(TILE_LOADSHOT,0,255);

         if (kdfread(&numwalls,2,1,fil) != 1) goto corrupt;
     if (kdfread(&wall[0],sizeof(walltype),MAXWALLS,fil) != MAXWALLS) goto corrupt;
         if (kdfread(&numsectors,2,1,fil) != 1) goto corrupt;
     if (kdfread(&sector[0],sizeof(sectortype),MAXSECTORS,fil) != MAXSECTORS) goto corrupt;
         if (kdfread(&sprite[0],sizeof(spritetype),MAXSPRITES,fil) != MAXSPRITES) goto corrupt;
         if (kdfread(&spriteext[0],sizeof(spriteexttype),MAXSPRITES,fil) != MAXSPRITES) goto corrupt;
         if (kdfread(&headspritesect[0],2,MAXSECTORS+1,fil) != MAXSECTORS+1) goto corrupt;
         if (kdfread(&prevspritesect[0],2,MAXSPRITES,fil) != MAXSPRITES) goto corrupt;
         if (kdfread(&nextspritesect[0],2,MAXSPRITES,fil) != MAXSPRITES) goto corrupt;
         if (kdfread(&headspritestat[0],2,MAXSTATUS+1,fil) != MAXSTATUS+1) goto corrupt;
         if (kdfread(&prevspritestat[0],2,MAXSPRITES,fil) != MAXSPRITES) goto corrupt;
         if (kdfread(&nextspritestat[0],2,MAXSPRITES,fil) != MAXSPRITES) goto corrupt;
         if (kdfread(&numcyclers,sizeof(numcyclers),1,fil) != 1) goto corrupt;
         if (kdfread(&cyclers[0][0],12,MAXCYCLERS,fil) != MAXCYCLERS) goto corrupt;
     if (kdfread(ps,sizeof(ps),1,fil) != 1) goto corrupt;
     if (kdfread(po,sizeof(po),1,fil) != 1) goto corrupt;
         if (kdfread(&numanimwalls,sizeof(numanimwalls),1,fil) != 1) goto corrupt;
         if (kdfread(&animwall,sizeof(animwall),1,fil) != 1) goto corrupt;
         if (kdfread(&msx[0],sizeof(long),sizeof(msx)/sizeof(long),fil) != sizeof(msx)/sizeof(long)) goto corrupt;
         if (kdfread(&msy[0],sizeof(long),sizeof(msy)/sizeof(long),fil) != sizeof(msy)/sizeof(long)) goto corrupt;
     if (kdfread((short *)&spriteqloc,sizeof(short),1,fil) != 1) goto corrupt;
     if (kdfread((short *)&spriteqamount,sizeof(short),1,fil) != 1) goto corrupt;
     if (kdfread((short *)&spriteq[0],sizeof(short),spriteqamount,fil) != spriteqamount) goto corrupt;
         if (kdfread(&mirrorcnt,sizeof(short),1,fil) != 1) goto corrupt;
         if (kdfread(&mirrorwall[0],sizeof(short),64,fil) != 64) goto corrupt;
     if (kdfread(&mirrorsector[0],sizeof(short),64,fil) != 64) goto corrupt;
     if (kdfread(&show2dsector[0],sizeof(char),MAXSECTORS>>3,fil) != (MAXSECTORS>>3)) goto corrupt;
     if (kdfread(&actortype[0],sizeof(char),MAXTILES,fil) != MAXTILES) goto corrupt;

     if (kdfread(&numclouds,sizeof(numclouds),1,fil) != 1) goto corrupt;
     if (kdfread(&clouds[0],sizeof(short)<<7,1,fil) != 1) goto corrupt;
     if (kdfread(&cloudx[0],sizeof(short)<<7,1,fil) != 1) goto corrupt;
     if (kdfread(&cloudy[0],sizeof(short)<<7,1,fil) != 1) goto corrupt;

     if (kdfread(&scriptptrs[0],1,MAXSCRIPTSIZE,fil) != MAXSCRIPTSIZE) goto corrupt;
     if (kdfread(&script[0],4,MAXSCRIPTSIZE,fil) != MAXSCRIPTSIZE) goto corrupt;
     for(i=0;i<MAXSCRIPTSIZE;i++)
        if( scriptptrs[i] )
     {
         j = (long)script[i]+(long)&script[0];
         script[i] = j;
     }

     if (kdfread(&actorscrptr[0],4,MAXTILES,fil) != MAXTILES) goto corrupt;
     for(i=0;i<MAXTILES;i++)
         if(actorscrptr[i])
     {
        j = (long)actorscrptr[i]+(long)&script[0];
        actorscrptr[i] = (long *)j;
     }

     if (kdfread(&scriptptrs[0],1,MAXSPRITES,fil) != MAXSPRITES) goto corrupt;
     if (kdfread(&hittype[0],sizeof(struct weaponhit),MAXSPRITES,fil) != MAXSPRITES) goto corrupt;

     for(i=0;i<MAXSPRITES;i++)
     {
        j = (long)(&script[0]);
        if( scriptptrs[i]&1 ) T2 += j;
        if( scriptptrs[i]&2 ) T5 += j;
        if( scriptptrs[i]&4 ) T6 += j;
     }

         if (kdfread(&lockclock,sizeof(lockclock),1,fil) != 1) goto corrupt;
     if (kdfread(&pskybits,sizeof(pskybits),1,fil) != 1) goto corrupt;
     if (kdfread(&pskyoff[0],sizeof(pskyoff[0]),MAXPSKYTILES,fil) != MAXPSKYTILES) goto corrupt;

         if (kdfread(&animatecnt,sizeof(animatecnt),1,fil) != 1) goto corrupt;
         if (kdfread(&animatesect[0],2,MAXANIMATES,fil) != MAXANIMATES) goto corrupt;
         if (kdfread(&animateptr[0],4,MAXANIMATES,fil) != MAXANIMATES) goto corrupt;
     for(i = animatecnt-1;i>=0;i--) animateptr[i] = (long *)((long)animateptr[i]+(long)(&sector[0]));
         if (kdfread(&animategoal[0],4,MAXANIMATES,fil) != MAXANIMATES) goto corrupt;
         if (kdfread(&animatevel[0],4,MAXANIMATES,fil) != MAXANIMATES) goto corrupt;

         if (kdfread(&earthquaketime,sizeof(earthquaketime),1,fil) != 1) goto corrupt;
     if (kdfread(&ud.from_bonus,sizeof(ud.from_bonus),1,fil) != 1) goto corrupt;
     if (kdfread(&ud.secretlevel,sizeof(ud.secretlevel),1,fil) != 1) goto corrupt;
     if (kdfread(&ud.respawn_monsters,sizeof(ud.respawn_monsters),1,fil) != 1) goto corrupt;
     ud.m_respawn_monsters = ud.respawn_monsters;
     if (kdfread(&ud.respawn_items,sizeof(ud.respawn_items),1,fil) != 1) goto corrupt;
     ud.m_respawn_items = ud.respawn_items;
     if (kdfread(&ud.respawn_inventory,sizeof(ud.respawn_inventory),1,fil) != 1) goto corrupt;
     ud.m_respawn_inventory = ud.respawn_inventory;

     if (kdfread(&ud.god,sizeof(ud.god),1,fil) != 1) goto corrupt;
     if (kdfread(&ud.auto_run,sizeof(ud.auto_run),1,fil) != 1) goto corrupt;
     if (kdfread(&ud.crosshair,sizeof(ud.crosshair),1,fil) != 1) goto corrupt;
     if (kdfread(&ud.monsters_off,sizeof(ud.monsters_off),1,fil) != 1) goto corrupt;
     ud.m_monsters_off = ud.monsters_off;
     if (kdfread(&ud.last_level,sizeof(ud.last_level),1,fil) != 1) goto corrupt;
     if (kdfread(&ud.eog,sizeof(ud.eog),1,fil) != 1) goto corrupt;

     if (kdfread(&ud.coop,sizeof(ud.coop),1,fil) != 1) goto corrupt;
     ud.m_coop = ud.coop;
     if (kdfread(&ud.marker,sizeof(ud.marker),1,fil) != 1) goto corrupt;
     ud.m_marker = ud.marker;
     if (kdfread(&ud.ffire,sizeof(ud.ffire),1,fil) != 1) goto corrupt;
     ud.m_ffire = ud.ffire;

     if (kdfread(&camsprite,sizeof(camsprite),1,fil) != 1) goto corrupt;
     if (kdfread(&connecthead,sizeof(connecthead),1,fil) != 1) goto corrupt;
     if (kdfread(connectpoint2,sizeof(connectpoint2),1,fil) != 1) goto corrupt;
     if (kdfread(&numplayersprites,sizeof(numplayersprites),1,fil) != 1) goto corrupt;
     if (kdfread((short *)&frags[0][0],sizeof(frags),1,fil) != 1) goto corrupt;

     if (kdfread(&randomseed,sizeof(randomseed),1,fil) != 1) goto corrupt;
     if (kdfread(&global_random,sizeof(global_random),1,fil) != 1) goto corrupt;
     if (kdfread(&parallaxyscale,sizeof(parallaxyscale),1,fil) != 1) goto corrupt;

     kclose(fil);

     if(ps[myconnectindex].over_shoulder_on != 0)
     {
         cameradist = 0;
         cameraclock = 0;
         ps[myconnectindex].over_shoulder_on = 1;
     }

     screenpeek = myconnectindex;

     clearbufbyte(gotpic,sizeof(gotpic),0L);
     clearsoundlocks();
     cacheit();

     if (MapMusic[0] != 0)                                           // wxmm
        {
        strcpy(tempbuf, MapMusic);
        }
     else
     if (MusicName[0] != 0)                                           // wxmc
        {
        strcpy(tempbuf, MusicName);
        }
     else
        {
        j = ud.level_number;                                         // wxrm
        if (RandomMusic == 1 && ud.m_level_number == 7 && ud.m_volume_number == 0)
           {
           if (MusicDir == 1)                                        // wxmc
              {
              j = GetMusicFiles();
              strcpy(tempbuf, MusicFiles[j]);
              goto playp;
              }
           j = GetRandom(11);
           }
        music_select = (ud.volume_number*11) + j;
        strcpy(tempbuf, &music_fn[0][music_select][0]);
        }
playp:
     stopmusic();
     playmusic(tempbuf);
     initprintf("Playing Music: %s\n", tempbuf);

     ps[myconnectindex].gm = MODE_GAME;
         ud.recstat = 0;

     if(ps[myconnectindex].jetpack_on)
         spritesound(DUKE_JETPACK_IDLE,ps[myconnectindex].i);

     restorepalette = 1;
     setpal(&ps[myconnectindex]);
     vscrn();

     FX_SetReverb(0);

     if(ud.lockout == 0)
     {
         for(x=0;x<numanimwalls;x++)
             if( wall[animwall[x].wallnum].extra >= 0 )
                 wall[animwall[x].wallnum].picnum = wall[animwall[x].wallnum].extra;
     }
     else
     {
         for(x=0;x<numanimwalls;x++)
             switch(wall[animwall[x].wallnum].picnum)
         {
             case FEMPIC1:
                 wall[animwall[x].wallnum].picnum = BLANKSCREEN;
                 break;
             case FEMPIC2:
             case FEMPIC3:
                 wall[animwall[x].wallnum].picnum = SCREENBREAK6;
                 break;
         }
     }

     numinterpolations = 0;
     startofdynamicinterpolations = 0;

     k = headspritestat[3];
     while(k >= 0)
     {
        switch(sprite[k].lotag)
        {
            case 31:
                setinterpolation(&sector[sprite[k].sectnum].floorz);
                break;
            case 32:
                setinterpolation(&sector[sprite[k].sectnum].ceilingz);
                break;
            case 25:
                setinterpolation(&sector[sprite[k].sectnum].floorz);
                setinterpolation(&sector[sprite[k].sectnum].ceilingz);
                break;
            case 17:
                setinterpolation(&sector[sprite[k].sectnum].floorz);
                setinterpolation(&sector[sprite[k].sectnum].ceilingz);
                break;
            case 0:
            case 5:
            case 6:
            case 11:
            case 14:
            case 15:
            case 16:
            case 26:
            case 30:
                setsectinterpolate(k);
                break;
        }

        k = nextspritestat[k];
     }

     for(i=numinterpolations-1;i>=0;i--) bakipos[i] = *curipos[i];
     for(i = animatecnt-1;i>=0;i--)
         setinterpolation(animateptr[i]);

     show_shareware = 0;
     everyothertime = 0;

     clearbufbyte(playerquitflag,MAXPLAYERS,0x01010101);

     resetmys();

     ready2send = 1;

     flushpackets();
     clearfifo();
     waitforeverybody(12);                                            // wxdm

     resettimevars();

     return(0);
corrupt:
     Bsprintf(tempbuf,"Save game file \"%s\" is corrupt.",fnptr);
     gameexit(tempbuf);
     return -1;
}

int saveplayer(signed char spot)
{
     long i, j;
     char fn[40]; //char fn[13];
     char mpfn[13];
     char *fnptr,scriptptrs[MAXSCRIPTSIZE];
         FILE *fil;
     long bv = BYTEVERSION;
     short ln = strlen(svgame);

     if (spot == 10)
     {
        if (ud.autosave == 0 || ud.multimode > 1)
            return -1;
        Bsprintf(fn, "%sgamex.asv", svgame);
     }
     else
     {
        Bsprintf(fn, "%sgame0.sav", svgame);
     }
     strcpy(mpfn, "gameA_00.sav");

     if(spot < 0)
     {
        multiflag = 1;
        multiwhat = 1;
        multipos = -spot-1;
        return -1;
     }

     waitforeverybody(13);                                            // wxdm

     if( multiflag == 2 && multiwho != myconnectindex )
     {
         fnptr = mpfn;
         mpfn[4] = spot + 'A';

         if(ud.multimode > 9)
         {
             mpfn[6] = (multiwho/10) + '0';
             mpfn[7] = multiwho + '0';
         }
         else mpfn[7] = multiwho + '0';
     }
     else
     {
        fnptr = fn;
        if (spot < 10)
            fn[4+ln] = spot + '0';
     }

     if ((fil = fopen(fnptr,"wb")) == 0) return(-1);

     ready2send = 0;

     dfwrite(&bv,4,1,fil);
     dfwrite(&ud.multimode,sizeof(ud.multimode),1,fil);
     if (spot == 10)                                                 // wxas
        {
        strcpy(ud.autobuff[0],"AUTOSAVED GAME");
        dfwrite(&ud.autobuff[0][0],19,1,fil);
        }
     else
         dfwrite(&ud.savegame[spot][0],19,1,fil);
     dfwrite(&ud.volume_number,sizeof(ud.volume_number),1,fil);
     dfwrite(&ud.level_number,sizeof(ud.level_number),1,fil);
     dfwrite(&ud.player_skill,sizeof(ud.player_skill),1,fil);
     dfwrite(&boardfilename[0],BMAX_PATH,1,fil);

     if (!waloff[TILE_SAVESHOT]) {
         walock[TILE_SAVESHOT] = 254;
         allocache((long *)&waloff[TILE_SAVESHOT],200*320,&walock[TILE_SAVESHOT]);
         clearbuf((void*)waloff[TILE_SAVESHOT],(200*320)/4,0);
         walock[TILE_SAVESHOT] = 1;
     }
     dfwrite((char *)waloff[TILE_SAVESHOT],320,200,fil);

     dfwrite(&numwalls,2,1,fil);
     dfwrite(&wall[0],sizeof(walltype),MAXWALLS,fil);
     dfwrite(&numsectors,2,1,fil);
     dfwrite(&sector[0],sizeof(sectortype),MAXSECTORS,fil);
     dfwrite(&sprite[0],sizeof(spritetype),MAXSPRITES,fil);
     dfwrite(&spriteext[0],sizeof(spriteexttype),MAXSPRITES,fil);
     dfwrite(&headspritesect[0],2,MAXSECTORS+1,fil);
     dfwrite(&prevspritesect[0],2,MAXSPRITES,fil);
     dfwrite(&nextspritesect[0],2,MAXSPRITES,fil);
     dfwrite(&headspritestat[0],2,MAXSTATUS+1,fil);
     dfwrite(&prevspritestat[0],2,MAXSPRITES,fil);
     dfwrite(&nextspritestat[0],2,MAXSPRITES,fil);
     dfwrite(&numcyclers,sizeof(numcyclers),1,fil);
     dfwrite(&cyclers[0][0],12,MAXCYCLERS,fil);
     dfwrite(ps,sizeof(ps),1,fil);
     dfwrite(po,sizeof(po),1,fil);
     dfwrite(&numanimwalls,sizeof(numanimwalls),1,fil);
     dfwrite(&animwall,sizeof(animwall),1,fil);
     dfwrite(&msx[0],sizeof(long),sizeof(msx)/sizeof(long),fil);
     dfwrite(&msy[0],sizeof(long),sizeof(msy)/sizeof(long),fil);
     dfwrite(&spriteqloc,sizeof(short),1,fil);
     dfwrite(&spriteqamount,sizeof(short),1,fil);
     dfwrite(&spriteq[0],sizeof(short),spriteqamount,fil);
     dfwrite(&mirrorcnt,sizeof(short),1,fil);
     dfwrite(&mirrorwall[0],sizeof(short),64,fil);
     dfwrite(&mirrorsector[0],sizeof(short),64,fil);
     dfwrite(&show2dsector[0],sizeof(char),MAXSECTORS>>3,fil);
     dfwrite(&actortype[0],sizeof(char),MAXTILES,fil);

     dfwrite(&numclouds,sizeof(numclouds),1,fil);
     dfwrite(&clouds[0],sizeof(short)<<7,1,fil);
     dfwrite(&cloudx[0],sizeof(short)<<7,1,fil);
     dfwrite(&cloudy[0],sizeof(short)<<7,1,fil);

     for(i=0;i<MAXSCRIPTSIZE;i++)
     {
          if( (long)script[i] >= (long)(&script[0]) && (long)script[i] < (long)(&script[MAXSCRIPTSIZE]) )
          {
                scriptptrs[i] = 1;
                j = (long)script[i] - (long)&script[0];
                script[i] = j;
          }
          else scriptptrs[i] = 0;
     }

     dfwrite(&scriptptrs[0],1,MAXSCRIPTSIZE,fil);
     dfwrite(&script[0],4,MAXSCRIPTSIZE,fil);

     for(i=0;i<MAXSCRIPTSIZE;i++)
        if( scriptptrs[i] )
     {
        j = script[i]+(long)&script[0];
        script[i] = j;
     }

     for(i=0;i<MAXTILES;i++)
         if(actorscrptr[i])
     {
        j = (long)actorscrptr[i]-(long)&script[0];
        actorscrptr[i] = (long *)j;
     }
     dfwrite(&actorscrptr[0],4,MAXTILES,fil);
     for(i=0;i<MAXTILES;i++)
         if(actorscrptr[i])
     {
         j = (long)actorscrptr[i]+(long)&script[0];
         actorscrptr[i] = (long *)j;
     }

     for(i=0;i<MAXSPRITES;i++)
     {
        scriptptrs[i] = 0;

        if(actorscrptr[PN] == 0) continue;

        j = (long)&script[0];

        if(T2 >= j && T2 < (long)(&script[MAXSCRIPTSIZE]) )
        {
            scriptptrs[i] |= 1;
            T2 -= j;
        }
        if(T5 >= j && T5 < (long)(&script[MAXSCRIPTSIZE]) )
        {
            scriptptrs[i] |= 2;
            T5 -= j;
        }
        if(T6 >= j && T6 < (long)(&script[MAXSCRIPTSIZE]) )
        {
            scriptptrs[i] |= 4;
            T6 -= j;
        }
    }

    dfwrite(&scriptptrs[0],1,MAXSPRITES,fil);
    dfwrite(&hittype[0],sizeof(struct weaponhit),MAXSPRITES,fil);

    for(i=0;i<MAXSPRITES;i++)
    {
        if(actorscrptr[PN] == 0) continue;
        j = (long)&script[0];

        if(scriptptrs[i]&1)
            T2 += j;
        if(scriptptrs[i]&2)
            T5 += j;
        if(scriptptrs[i]&4)
            T6 += j;
    }

     dfwrite(&lockclock,sizeof(lockclock),1,fil);
     dfwrite(&pskybits,sizeof(pskybits),1,fil);
     dfwrite(&pskyoff[0],sizeof(pskyoff[0]),MAXPSKYTILES,fil);
     dfwrite(&animatecnt,sizeof(animatecnt),1,fil);
     dfwrite(&animatesect[0],2,MAXANIMATES,fil);

     for(i = animatecnt-1;i>=0;i--) animateptr[i] = (long *)((long)animateptr[i]-(long)(&sector[0]));
     dfwrite(&animateptr[0],4,MAXANIMATES,fil);

     for(i = animatecnt-1;i>=0;i--) animateptr[i] = (long *)((long)animateptr[i]+(long)(&sector[0]));
     dfwrite(&animategoal[0],4,MAXANIMATES,fil);
     dfwrite(&animatevel[0],4,MAXANIMATES,fil);
     dfwrite(&earthquaketime,sizeof(earthquaketime),1,fil);
     dfwrite(&ud.from_bonus,sizeof(ud.from_bonus),1,fil);
     dfwrite(&ud.secretlevel,sizeof(ud.secretlevel),1,fil);
     dfwrite(&ud.respawn_monsters,sizeof(ud.respawn_monsters),1,fil);
     dfwrite(&ud.respawn_items,sizeof(ud.respawn_items),1,fil);
     dfwrite(&ud.respawn_inventory,sizeof(ud.respawn_inventory),1,fil);
     dfwrite(&ud.god,sizeof(ud.god),1,fil);
     dfwrite(&ud.auto_run,sizeof(ud.auto_run),1,fil);
     dfwrite(&ud.crosshair,sizeof(ud.crosshair),1,fil);
     dfwrite(&ud.monsters_off,sizeof(ud.monsters_off),1,fil);
     dfwrite(&ud.last_level,sizeof(ud.last_level),1,fil);
     dfwrite(&ud.eog,sizeof(ud.eog),1,fil);
     dfwrite(&ud.coop,sizeof(ud.coop),1,fil);
     dfwrite(&ud.marker,sizeof(ud.marker),1,fil);
     dfwrite(&ud.ffire,sizeof(ud.ffire),1,fil);
     dfwrite(&camsprite,sizeof(camsprite),1,fil);
     dfwrite(&connecthead,sizeof(connecthead),1,fil);
     dfwrite(connectpoint2,sizeof(connectpoint2),1,fil);
     dfwrite(&numplayersprites,sizeof(numplayersprites),1,fil);
     dfwrite((short *)&frags[0][0],sizeof(frags),1,fil);
     dfwrite(&randomseed,sizeof(randomseed),1,fil);
     dfwrite(&global_random,sizeof(global_random),1,fil);
     dfwrite(&parallaxyscale,sizeof(parallaxyscale),1,fil);

     fwrite("d3w",3,1,fil);                                          // 100130
     fwrite(&ud.savegame[spot][0],20,1,fil);

     fclose(fil);

     if (spot == 10)                                                 // wxas
         ud.autodone = 1;
     else
     if (ud.multimode < 2)
     {
         strcpy(fta_quotes[122],"GAME SAVED");
         FTA(122,&ps[myconnectindex]);
     }

     ready2send = 1;

     waitforeverybody(14);                                            // wxdm

     ototalclock = totalclock;

     return(0);
}

#define LMB (buttonstat&1)
#define RMB (buttonstat&2)

ControlInfo minfo;

long mi;

static int probe_(int type,int x,int y,int i,int n)
{
    int size = 65535;                                               // wxpr
    short centre, s;

    if (type == 1)
        size = 32768;
    else
    if (type == 2)
        size = 44000;

    s = 1+(CONTROL_GetMouseSensitivity()>>4);

    {
        CONTROL_GetInput( &minfo );
        mi += minfo.dz;
    }

    if( x == (320>>1) )
        centre = 320>>2;
    else centre = 0;

    if(!buttonstat)
    {
        if( KB_KeyPressed( sc_UpArrow ) || KB_KeyPressed( sc_PgUp ) || KB_KeyPressed( sc_kpad_8 ) ||
            mi < -8192 )
        {
            mi = 0;
            KB_ClearKeyDown( sc_UpArrow );
            KB_ClearKeyDown( sc_kpad_8 );
            KB_ClearKeyDown( sc_PgUp );
            sound(KICK_HIT);

            probey--;
            if(probey < 0) probey = n-1;
            minfo.dz = 0;
        }
        if( KB_KeyPressed( sc_DownArrow ) || KB_KeyPressed( sc_PgDn ) || KB_KeyPressed( sc_kpad_2 )
            || mi > 8192 )
        {
            mi = 0;
            KB_ClearKeyDown( sc_DownArrow );
            KB_ClearKeyDown( sc_kpad_2 );
            KB_ClearKeyDown( sc_PgDn );
            sound(KICK_HIT);
            probey++;
            minfo.dz = 0;
        }
    }

    if(probey >= n)
        probey = 0;

    if(centre)
    {
                                                                     // wxpr
        rotatesprite(((320>>1)+(centre>>1)+70)<<16,(y+(probey*i)-4)<<16,size,0,SPINNINGNUKEICON+6-((6+(totalclock>>3))%7),sh,0,10,0,0,xdim-1,ydim-1);
        rotatesprite(((320>>1)-(centre>>1)-70)<<16,(y+(probey*i)-4)<<16,size,0,SPINNINGNUKEICON+((totalclock>>3)%7),sh,0,10,0,0,xdim-1,ydim-1);
    }
    else                                                                                       // wxpr
        rotatesprite((x<<16)-((tilesizx[BIGFNTCURSOR]-4)<<(16-type)),(y+(probey*i)-(4>>type))<<16,size,0,SPINNINGNUKEICON+(((totalclock>>3))%7),sh,0,10,0,0,xdim-1,ydim-1);

    if( KB_KeyPressed(sc_Space) || KB_KeyPressed( sc_kpad_Enter ) || KB_KeyPressed( sc_Enter ) || (LMB && !onbar) )
    {
        if(current_menu != 110)
            sound(PISTOL_BODYHIT);
        KB_ClearKeyDown( sc_Enter );
        KB_ClearKeyDown( sc_Space );
        KB_ClearKeyDown( sc_kpad_Enter );
        return(probey);
    }
    else if( KB_KeyPressed( sc_Escape ) || (RMB) )
    {
        onbar = 0;
        KB_ClearKeyDown( sc_Escape );
        sound(EXITMENUSOUND);
        return(-1);
    }
    else
    {
        if(onbar == 0) return(-probey-2);
        if ( KB_KeyPressed( sc_LeftArrow ) || KB_KeyPressed( sc_kpad_4 ) || ((buttonstat&1) && minfo.dyaw < -128 ) )
            return(probey);
        else if ( KB_KeyPressed( sc_RightArrow ) || KB_KeyPressed( sc_kpad_6 ) || ((buttonstat&1) && minfo.dyaw > 128 ) )
            return(probey);
        else return(-probey-2);
    }
}
int probe(int x,int y,int i,int n) { return probe_(0,x,y,i,n); }
int probesm(int x,int y,int i,int n) { return probe_(1,x,y,i,n); }
int probemd(int x,int y,int i,int n) { return probe_(2,x,y,i,n); }   // wxpr

int menutext(int x,int y,short s,short p,const char *t)
{
    short i, ac, centre;

    y -= 12;
    i = centre = 0;

    if( x == (320>>1) )
    {
        while( *(t+i) )
        {
            if(*(t+i) == ' ')
            {
                centre += 5;
                i++;
                continue;
            }
            ac = 0;
            if(*(t+i) >= '0' && *(t+i) <= '9')
                ac = *(t+i) - '0' + BIGALPHANUM-10;
            else if(*(t+i) >= 'a' && *(t+i) <= 'z')
                ac = toupper(*(t+i)) - 'A' + BIGALPHANUM;
            else if(*(t+i) >= 'A' && *(t+i) <= 'Z')
                ac = *(t+i) - 'A' + BIGALPHANUM;
            else switch(*(t+i))
            {
                case '-':
                    ac = BIGALPHANUM-11;
                    break;
                case '.':
                    ac = BIGPERIOD;
                    break;
                case '\'':
                    ac = BIGAPPOS;
                    break;
                case ',':
                    ac = BIGCOMMA;
                    break;
                case '!':
                    ac = BIGX;
                    break;
                case '?':
                    ac = BIGQ;
                    break;
                case ';':
                    ac = BIGSEMI;
                    break;
                case ':':
                    ac = BIGSEMI;
                    break;
                default:
                    centre += 5;
                    i++;
                    continue;
            }

            centre += tilesizx[ac]-1;
            i++;
        }
    }

    if(centre)
        x = (320-centre-10)>>1;

    while(*t)
    {
        if(*t == ' ') {x+=5;t++;continue;}
        ac = 0;
        if(*t >= '0' && *t <= '9')
            ac = *t - '0' + BIGALPHANUM-10;
        else if(*t >= 'a' && *t <= 'z')
            ac = toupper(*t) - 'A' + BIGALPHANUM;
        else if(*t >= 'A' && *t <= 'Z')
            ac = *t - 'A' + BIGALPHANUM;
        else switch(*t)
        {
            case '-':
                ac = BIGALPHANUM-11;
                break;
            case '.':
                ac = BIGPERIOD;
                break;
            case ',':
                ac = BIGCOMMA;
                break;
            case '!':
                ac = BIGX;
                break;
            case '\'':
                ac = BIGAPPOS;
                break;
            case '?':
                ac = BIGQ;
                break;
            case ';':
                ac = BIGSEMI;
                break;
            case ':':
                ac = BIGCOLIN;
                break;
            default:
                x += 5;
                t++;
                continue;
        }

        rotatesprite(x<<16,y<<16,65536L,0,ac,s,p,10+16,0,0,xdim-1,ydim-1);
        x += tilesizx[ac];
        t++;
    }
    return (x);
}

int menutextc(int x,int y,short s,short p,const char *t)
{
    short i, ac, centre;

    y -= 12;
    i = centre = 0;

    if( x == (320>>1) )
    {
        while( *(t+i) )
        {
            if(*(t+i) == ' ')
            {
                centre += 5;
                i++;
                continue;
            }
            ac = 0;
            if(*(t+i) >= '0' && *(t+i) <= '9')
                ac = *(t+i) - '0' + BIGALPHANUM-10;
            else if(*(t+i) >= 'a' && *(t+i) <= 'z')
                ac = toupper(*(t+i)) - 'A' + BIGALPHANUM;
            else if(*(t+i) >= 'A' && *(t+i) <= 'Z')
                ac = *(t+i) - 'A' + BIGALPHANUM;
            else switch(*(t+i))
            {
                case '-':
                    ac = BIGALPHANUM-11;
                    break;
                case '.':
                    ac = BIGPERIOD;
                    break;
                case '\'':
                    ac = BIGAPPOS;
                    break;
                case ',':
                    ac = BIGCOMMA;
                    break;
                case '!':
                    ac = BIGX;
                    break;
                case '?':
                    ac = BIGQ;
                    break;
                case ';':
                    ac = BIGSEMI;
                    break;
                case ':':
                    ac = BIGSEMI;
                    break;
                default:
                    centre += 5;
                    i++;
                    continue;
            }

            centre += tilesizx[ac]-1;
            i++;
        }
    }

    if(centre)
        x = (320-centre-10)>>1;

    while(*t)
    {
        if(*t == ' ') {x+=5;t++;continue;}
        ac = 0;
        if(*t >= '0' && *t <= '9')
            ac = *t - '0' + BIGALPHANUM-10;
        else if(*t >= 'a' && *t <= 'z')
            ac = toupper(*t) - 'A' + BIGALPHANUM;
        else if(*t >= 'A' && *t <= 'Z')
            ac = *t - 'A' + BIGALPHANUM;
        else switch(*t)
        {
            case '-':
                ac = BIGALPHANUM-11;
                break;
            case '.':
                ac = BIGPERIOD;
                break;
            case ',':
                ac = BIGCOMMA;
                break;
            case '!':
                ac = BIGX;
                break;
            case '\'':
                ac = BIGAPPOS;
                break;
            case '?':
                ac = BIGQ;
                break;
            case ';':
                ac = BIGSEMI;
                break;
            case ':':
                ac = BIGCOLIN;
                break;
            default:
                x += 5;
                t++;
                continue;
        }
        rotatesprite(x<<16,y<<16,44000L,0,ac,s,p,10+16,0,0,xdim-1,ydim-1);
        x += tilesizx[ac] / 3 * 2 + 1;
        t++;
    }
    return (x);
}
static void bar_(int type, int x,int y,short *p,short dainc,char damodify,short s, short pa)
{
    int size;
    short xloc;
    char rev;

    if (dainc < 0) { dainc = -dainc; rev = 1; }
    else rev = 0;

    size = 65536;                                                    // wxpr
    if (type == 1)
        size = 32768;
    else
    if (type == 2)
    {
        size = 42000;
        type = 1;
        x += 5;
    }

    y-=2;

    if(damodify)
    {
        if(rev == 0)
        {
            if( KB_KeyPressed( sc_LeftArrow ) || KB_KeyPressed( sc_kpad_4 ) || ((buttonstat&1) && minfo.dyaw < -256 ) ) // && onbar) )
            {
                KB_ClearKeyDown( sc_LeftArrow );
                KB_ClearKeyDown( sc_kpad_4 );

                *p -= dainc;
                if(*p < 0)
                    *p = 0;
                sound(KICK_HIT);
            }
            if( KB_KeyPressed( sc_RightArrow ) || KB_KeyPressed( sc_kpad_6 ) || ((buttonstat&1) && minfo.dyaw > 256 ) )//&& onbar) )
            {
                KB_ClearKeyDown( sc_RightArrow );
                KB_ClearKeyDown( sc_kpad_6 );

                *p += dainc;
                if(*p > 63)
                    *p = 63;
                sound(KICK_HIT);
            }
        }
        else
        {
            if( KB_KeyPressed( sc_RightArrow ) || KB_KeyPressed( sc_kpad_6 ) || ((buttonstat&1) && minfo.dyaw > 256 ))//&& onbar ))
            {
                KB_ClearKeyDown( sc_RightArrow );
                KB_ClearKeyDown( sc_kpad_6 );

                *p -= dainc;
                if(*p < 0)
                    *p = 0;
                sound(KICK_HIT);
            }
            if( KB_KeyPressed( sc_LeftArrow ) || KB_KeyPressed( sc_kpad_4 ) || ((buttonstat&1) && minfo.dyaw < -256 ))// && onbar) )
            {
                KB_ClearKeyDown( sc_LeftArrow );
                KB_ClearKeyDown( sc_kpad_4 );

                *p += dainc;
                if(*p > 64)
                    *p = 64;
                sound(KICK_HIT);
            }
        }
    }

    xloc = *p;

    rotatesprite( (x<<16)+(22<<(16-type)),(y<<16)-(3<<(16-type)),size,0,SLIDEBAR,s,pa,10,0,0,xdim-1,ydim-1);
    if(rev == 0)
        rotatesprite( (x<<16)+((xloc+1)<<(16-type)),(y<<16)+(1<<(16-type)),size,0,SLIDEBAR+1,s,pa,10,0,0,xdim-1,ydim-1);
    else
        rotatesprite( (x<<16)+((65-xloc)<<(16-type)),(y<<16)+(1<<(16-type)),size,0,SLIDEBAR+1,s,pa,10,0,0,xdim-1,ydim-1);
}

void bar(int x,int y,short *p,short dainc,char damodify,short s, short pa) { bar_(0,x,y,p,dainc,damodify,s,pa); }
void barsm(int x,int y,short *p,short dainc,char damodify,short s, short pa) { bar_(1,x,y,p,dainc,damodify,s,pa); }
void barmd(int x,int y,short *p,short dainc,char damodify,short s, short pa) { bar_(2,x,y,p,dainc,damodify,s,pa); } // wxpr

#define SHX(X) 0
// ((x==X)*(-sh))
#define PHX(X) 0
// ((x==X)?1:2)
#define MWIN(X) rotatesprite( 320<<15,200<<15,X,0,MENUSCREEN,-16,0,10+64,0,0,xdim-1,ydim-1)
#define MWINXY(X,OX,OY) rotatesprite( ( 320+(OX) )<<15, ( 200+(OY) )<<15,X,0,MENUSCREEN,-16,0,10+64,0,0,xdim-1,ydim-1)


static struct savehead savehead;
//static int32 volnum,levnum,plrskl,numplr;
//static char brdfn[BMAX_PATH];
short lastsavedpos = -1;

void dispnames(void)
{
    short x, c = 160;
    short y = 108;

    c += 64;

    if (ud.autosave > 0 && ud.autodone > 0 && current_menu == 300 && ud.multimode < 2) // wxas
        y = 120;
    for (x = 0; x <= y; x += 12) // for(x = 0;x <= 108;x += 12)      // wxas
         rotatesprite((c+91-64)<<16,(x+56)<<16,65536L,0,TEXTBOX,24,0,10,0,0,xdim-1,ydim-1);

    rotatesprite(22<<16,97<<16,65536L,0,WINDOWBORDER2,24,0,10,0,0,xdim-1,ydim-1);
    rotatesprite(180<<16,97<<16,65536L,1024,WINDOWBORDER2,24,0,10,0,0,xdim-1,ydim-1);
    rotatesprite(99<<16,50<<16,65536L,512,WINDOWBORDER1,24,0,10,0,0,xdim-1,ydim-1);
    rotatesprite(103<<16,144<<16,65536L,1024+512,WINDOWBORDER1,24,0,10,0,0,xdim-1,ydim-1);

    minitext(c,48,ud.savegame[0],2,10+16);
    minitext(c,48+12,ud.savegame[1],2,10+16);
    minitext(c,48+12+12,ud.savegame[2],2,10+16);
    minitext(c,48+12+12+12,ud.savegame[3],2,10+16);
    minitext(c,48+12+12+12+12,ud.savegame[4],2,10+16);
    minitext(c,48+12+12+12+12+12,ud.savegame[5],2,10+16);
    minitext(c,48+12+12+12+12+12+12,ud.savegame[6],2,10+16);
    minitext(c,48+12+12+12+12+12+12+12,ud.savegame[7],2,10+16);
    minitext(c,48+12+12+12+12+12+12+12+12,ud.savegame[8],2,10+16);
    minitext(c,48+12+12+12+12+12+12+12+12+12,ud.savegame[9],2,10+16);
    if (ud.autosave > 0 && ud.autodone > 0 && current_menu == 300 && numplayers < 2) // wxas
        minitext(c,48+12+12+12+12+12+12+12+12+12+12,"AUTOSAVED GAME",2,10+16); // wxag
}

void clearfilenames(void)
{
    klistfree(finddirs);
    klistfree(findfiles);
    finddirs = findfiles = NULL;
    numfiles = numdirs = 0;
}

int getfilenames(char *path, char kind[], short pmode)               // wxrm
{
    CACHE1D_FIND_REC *r;

    pathsearchmode = pmode;
    clearfilenames();
    finddirs = klistpath(path,"*",CACHE1D_FIND_DIR);
    findfiles = klistpath(path,kind,CACHE1D_FIND_FILE);
    for (r = finddirs; r; r=r->next) numdirs++;
    for (r = findfiles; r; r=r->next) numfiles++;
    finddirshigh = finddirs;
    findfileshigh = findfiles;
    currentlist = 0;
    if (findfileshigh)
        currentlist = 1;
    pathsearchmode = 0;
    return(0);
}

long quittimer = 0;

void menus(void)
{
    CACHE1D_FIND_REC *dir;
    short c,x,i,j, shd;                                              // wxdm
    long l,m;
    char *p = NULL;
    long second_tics;                                                // wxst

    getpackets();

    {
        if(buttonstat != 0 && !onbar)
        {
            x = MOUSE_GetButtons()<<3;
            if (x)
                buttonstat = x<<3;
            else
                buttonstat = 0;
        }
        else
            buttonstat = MOUSE_GetButtons();
    }

    if( (ps[myconnectindex].gm&MODE_MENU) == 0 )
    {
        walock[TILE_LOADSHOT] = 1;
        return;
    }


    ps[myconnectindex].gm &= (0xff-MODE_TYPE);
    ps[myconnectindex].fta = 0;

    x = 0;

    sh = 4-(sintable[(totalclock<<4)&2047]>>11);

    if(!(current_menu >= 1000 && current_menu <= 2999 && current_menu >= 300 && current_menu <= 369))
        vscrn();

    switch(current_menu)
    {
        case 25000:
            gametext(160,90,"SELECT A SAVE SPOT BEFORE",0,2+8+16);
            gametext(160,90+9,"YOU QUICK RESTORE.",0,2+8+16);

            x = probe(186,124,0,0);
            if(x >= -1)
            {
                if(ud.multimode < 2 && ud.recstat != 2)
                {
                    ready2send = 1;
                    totalclock = ototalclock;
                }
                ps[myconnectindex].gm &= ~MODE_MENU;
            }
            break;

        case 20000:
            x = probe(326,190,0,0);
            gametext(160,50-8,"YOU ARE PLAYING THE SHAREWARE",0,2+8+16);
            gametext(160,59-8,"VERSION OF DUKE NUKEM 3D.  WHILE",0,2+8+16);
            gametext(160,68-8,"THIS VERSION IS REALLY COOL, YOU",0,2+8+16);
            gametext(160,77-8,"ARE MISSING OVER 75%% OF THE TOTAL",0,2+8+16);
            gametext(160,86-8,"GAME, ALONG WITH OTHER GREAT EXTRAS",0,2+8+16);
            gametext(160,95-8,"AND GAMES, WHICH YOU'LL GET WHEN",0,2+8+16);
            gametext(160,104-8,"YOU ORDER THE COMPLETE VERSION AND",0,2+8+16);
            gametext(160,113-8,"GET THE FINAL TWO EPISODES.",0,2+8+16);

            gametext(160,113+8,"PLEASE READ THE 'HOW TO ORDER' ITEM",0,2+8+16);
            gametext(160,122+8,"ON THE MAIN MENU IF YOU WISH TO",0,2+8+16);
            gametext(160,131+8,"UPGRADE TO THE FULL REGISTERED",0,2+8+16);
            gametext(160,140+8,"VERSION OF DUKE NUKEM 3D.",0,2+8+16);
            gametext(160,149+16,"PRESS ANY KEY...",0,2+8+16);

            if( x >= -1 ) cmenu(100);
            break;

        case 20001:
            rotatesprite(160<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(160,24,0,0,"NETWORK GAME");

            x = probe(160,100-18,18,3);

            if (x == -1) cmenu(0);
            else if (x == 2) cmenu(20010);
            else if (x == 1) cmenu(20020);
            else if (x == 0) cmenu(20002);

            menutext(160,100-18,0,0,"PLAYER SETUP");
            menutext(160,100,0,0,"JOIN GAME");
            menutext(160,100+18,0,0,"HOST GAME");
            break;

        case 20002:
        case 20003:
            rotatesprite(160<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(160,24,0,0,"PLAYER SETUP");

            if (current_menu == 20002)
            {
                x = probe(46,50,20,2);

                if (x == -1)
                    cmenu(20001);
                else
                if (x == 0)
                {
                    strcpy(buf, PlayerNameArg);                      // wxpa
                    inputloc = strlen(buf);
                    current_menu = 20003;

                    KB_ClearKeyDown(sc_Enter);
                    KB_ClearKeyDown(sc_kpad_Enter);
                    KB_FlushKeyboardQueue();
                }
                else
                if (x == 1)
                {
                    // send colour update
                }
            }
            else
            {
                x = strget(40+100,50-9,buf,31,0);
                if (x)
                {
                    if (x == 1)
                    {
                        strcpy(PlayerNameArg,buf);                   // wxpa
                        // send name update
                    }

                    KB_ClearKeyDown(sc_Enter);
                    KB_ClearKeyDown(sc_kpad_Enter);
                    KB_FlushKeyboardQueue();

                    current_menu = 20002;
                }
            }

            menutext(40,50,0,0,"NAME");
            if (current_menu == 20002)
                gametext(40+100,50-9,PlayerNameArg,0,2+8+16);  // wxpa

            menutext(40,50+20,0,0,"COLOR");
            rotatesprite((40+120)<<16,(50+20+(tilesizy[APLAYER]>>1))<<16,65536L,0,APLAYER,0,0,10,0,0,xdim-1,ydim-1);

            break;

        case 20010:
            rotatesprite(160<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(160,24,0,0,"HOST NETWORK GAME");

            x = probe(46,50,80,2);

            if (x == -1)
            {
                cmenu(20001);
                probey = 2;
            }
            else
            if (x == 0)
                cmenu(20011);

            menutext(40,50,0,0,"GAME OPTIONS");
            minitext(90,60,            "GAME TYPE"    ,2,26);
            minitext(90,60+8,          "EPISODE"      ,2,26);
            minitext(90,60+8+8,        "LEVEL"        ,2,26);
            minitext(90,60+8+8+8,      "MONSTERS"     ,2,26);
            if (ud.m_coop == 0)
                minitext(90,60+8+8+8+8,    "MARKERS"      ,2,26);
            else
            if (ud.m_coop == 1)
                minitext(90,60+8+8+8+8,    "FRIENDLY FIRE",2,26);
            minitext(90,60+8+8+8+8+8,  "USER MAP"     ,2,26);

            if (ud.m_coop == 1)
                minitext(90+60,60,"COOPERATIVE PLAY",0,26);
            else
            if (ud.m_coop == 2)
                minitext(90+60,60,"DUKEMATCH (NO SPAWN)",0,26);
            else
                minitext(90+60,60,"DUKEMATCH (SPAWN)",0,26);
            minitext(90+60,60+8,      volume_names[ud.m_volume_number],0,26);
            minitext(90+60,60+8+8,    level_names[11*ud.m_volume_number+ud.m_level_number],0,26);
            if (ud.m_monsters_off == 0 || ud.m_player_skill > 0)
                minitext(90+60,60+8+8+8,  skill_names[ud.m_player_skill],0,26);
            else
                minitext(90+60,60+8+8+8,  "NONE",0,28);
            if (ud.m_coop == 0)
            {
                if (ud.m_marker)
                    minitext(90+60,60+8+8+8+8,"ON",0,26);
                else
                    minitext(90+60,60+8+8+8+8,"OFF",0,26);
            }
            else
            if (ud.m_coop == 1)
            {
                if (ud.m_ffire)
                    minitext(90+60,60+8+8+8+8,"ON",0,26);
                else
                    minitext(90+60,60+8+8+8+8,"OFF",0,26);
            }

            menutext(40,50+80,0,0,"LAUNCH GAME");
            break;

        case 20011:
            c = (320>>1) - 120;
            rotatesprite(160<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(160,24,0,0,"NET GAME OPTIONS");

            x = probe(c,57-8,16,8);

            if (probey==2 && KB_KeyPressed(sc_RightArrow))
            {
                sound(PISTOL_BODYHIT);
                x=2;
            }
            switch(x)
            {
                case -1:
                    cmenu(20010);
                    break;
                case 0:
                    ud.m_coop++;
                    if(ud.m_coop == 3) ud.m_coop = 0;
                    break;
                case 1:
                    if (!VOLUMEONE)
                    {
                       ud.m_volume_number++;
                       if (PLUTOPAK)
                       {
                          if (ud.m_volume_number > 3)
                              ud.m_volume_number = 0;
                       }
                       else
                       {
                          if (ud.m_volume_number > 2)
                              ud.m_volume_number = 0;
                       }
                       if (ud.m_volume_number == 0 && ud.m_level_number > 6)
                           ud.m_level_number = 0;
                       if (ud.m_level_number > 10)
                           ud.m_level_number = 0;
                    }
                    break;
                case 2:
                    ud.m_level_number++;
                    if (!VOLUMEONE)
                    {
                        if(ud.m_volume_number == 0 && ud.m_level_number > 6)
                           ud.m_level_number = 0;
                    }
                    else
                    {
                        if(ud.m_volume_number == 0 && ud.m_level_number > 5)
                           ud.m_level_number = 0;
                    }
                    if (ud.m_level_number > 10)
                        ud.m_level_number = 0;
                    break;
                case 3:
                    if (ud.m_monsters_off == 1 && ud.m_player_skill > 0)
                        ud.m_monsters_off = 0;

                    if (ud.m_monsters_off == 0)
                    {
                        ud.m_player_skill++;
                        if (ud.m_player_skill > 3)
                        {
                            ud.m_player_skill = 0;
                            ud.m_monsters_off = 1;
                        }
                    }
                    else
                        ud.m_monsters_off = 0;
                    break;

                case 4:
                    if(ud.m_coop == 0)
                        ud.m_marker = !ud.m_marker;
                    break;

                case 5:
                    if(ud.m_coop == 1)
                        ud.m_ffire = !ud.m_ffire;
                    break;

                case 6:
                    // pick the user map
                    //cmenu(101);
                    break;

                case 7:
                    cmenu(20010);
                    break;
            }

            c += 40;

            if (ud.m_coop==1)
                gametext(c+70,57-7-9,"COOPERATIVE PLAY",0,2+8+16);
            else
            if (ud.m_coop==2)
                gametext(c+70,57-7-9,"DUKEMATCH (NO SPAWN)",0,2+8+16);
            else
                gametext(c+70,57-7-9,"DUKEMATCH (SPAWN)",0,2+8+16);

            gametext(c+70,57+16-7-9,volume_names[ud.m_volume_number],0,2+8+16);

            gametext(c+70,57+16+16-7-9,&level_names[11*ud.m_volume_number+ud.m_level_number][0],0,2+8+16);

            if (ud.m_monsters_off == 0 || ud.m_player_skill > 0)
                gametext(c+70,57+16+16+16-7-9,skill_names[ud.m_player_skill],0,2+8+16);
            else
                gametext(c+70,57+16+16+16-7-9,"NONE",0,2+8+16);

            if (ud.m_coop == 0)
            {
                if(ud.m_marker)
                   gametext(c+70,57+16+16+16+16-7-9,"ON",0,2+8+16);
                else
                   gametext(c+70,57+16+16+16+16-7-9,"OFF",0,2+8+16);
            }

            if (ud.m_coop == 1)
            {
                if(ud.m_ffire)
                   gametext(c+70,57+16+16+16+16+16-7-9,"ON",0,2+8+16);
                else
                   gametext(c+70,57+16+16+16+16+16-7-9,"OFF",0,2+8+16);
            }

            c -= 44;

            menutext(c,61-9,SHX(-2),PHX(-2),"GAME TYPE");

            sprintf(tempbuf,"EPISODE %ld",ud.m_volume_number+1);
            menutext(c,61+16-9,SHX(-3),PHX(-3),tempbuf);

            sprintf(tempbuf,"LEVEL %ld",ud.m_level_number+1);
            menutext(c,61+16+16-9,SHX(-4),PHX(-4),tempbuf);

            menutext(c,61+16+16+16-9,SHX(-5),PHX(-5),"MONSTERS");

            if (ud.m_coop == 0)
                menutext(c,61+16+16+16+16-9,SHX(-6),PHX(-6),"MARKERS");
            else
                menutext(c,61+16+16+16+16-9,SHX(-6),1,"MARKERS");

            if (ud.m_coop == 1)
                menutext(c,61+16+16+16+16+16-9,SHX(-6),PHX(-6),"FR. FIRE");
            else
                menutext(c,61+16+16+16+16+16-9,SHX(-6),1,"FR. FIRE");

         if (VOLUMEALL)
         {
            menutext(c,61+16+16+16+16+16+16-9,SHX(-7),boardfilename[0] == 0,"USER MAP");
            if( boardfilename[0] != 0 )
                gametext(c+70+44,57+16+16+16+16+16,boardmapname,0,2+8+16); // wxup
         }
         else
         {
            menutext(c,61+16+16+16+16+16+16-9,SHX(-7),1,"USER MAP");
         }

         menutext(c,61+16+16+16+16+16+16+16-9,SHX(-8),PHX(-8),"ACCEPT");
         break;

        case 20020:
        case 20021: // editing server
        case 20022: // editing port
            rotatesprite(160<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(160,24,0,0,"JOIN NETWORK GAME");

            if (current_menu == 20020) {
                x = probe(46,50,20,3);

                if (x == -1) {
                    cmenu(20001);
                    probey = 1;
                } else if (x == 0) {
                    strcpy(buf, "localhost");
                    inputloc = strlen(buf);
                    current_menu = 20021;
                } else if (x == 1) {
                    strcpy(buf, "19014");
                    inputloc = strlen(buf);
                    current_menu = 20022;
                } else if (x == 2) {
                }
                KB_ClearKeyDown(sc_Enter);
                KB_ClearKeyDown(sc_kpad_Enter);
                KB_FlushKeyboardQueue();
            } else if (current_menu == 20021) {
                x = strget(40+100,50-9,buf,31,0);
                if (x) {
                    if (x == 1) {
                        //strcpy(PlayerNameArg,buf);
                    }

                    KB_ClearKeyDown(sc_Enter);
                    KB_ClearKeyDown(sc_kpad_Enter);
                    KB_FlushKeyboardQueue();

                    current_menu = 20020;
                }
            } else if (current_menu == 20022) {
                x = strget(40+100,50+20-9,buf,5,997);
                if (x) {
                    if (x == 1) {
                        //strcpy(PlayerNameArg,buf);
                    }

                    KB_ClearKeyDown(sc_Enter);
                    KB_ClearKeyDown(sc_kpad_Enter);
                    KB_FlushKeyboardQueue();

                    current_menu = 20020;
                }
            }

            menutext(40,50,0,0,"SERVER");
            if (current_menu != 20021) gametext(40+100,50-9,"server",0,2+8+16);

            menutext(40,50+20,0,0,"PORT");
            if (current_menu != 20022) {
                sprintf(tempbuf,"%d",19014);
                gametext(40+100,50+20-9,tempbuf,0,2+8+16);
            }

            menutext(160,50+20+20,0,0,"CONNECT");


            // ADDRESS
            // PORT
            // CONNECT
            break;

        case 15001:
        case 15000:

            if (lastsavedpos >= 0)                                   // wxas
               {
               gametext(160,90,"Load saved game:",0,2+8+16);
               sprintf(tempbuf,"\"%s\"",ud.savegame[lastsavedpos]);
               gametext(160,99,tempbuf,0,2+8+16);
               gametext(160,99+9,"(Y/N)",0,2+8+16);
               }

            if (ud.autosave > 0 && ud.autodone > 0 && ud.multimode < 2) // wxas
                gametext(160,99+45,"Load autosaved game (A)",0,2+8+16);

            if( KB_KeyPressed(sc_Escape) || KB_KeyPressed(sc_N) || (lastsavedpos < 0 && KB_KeyPressed(sc_Space))) // || RMB)  // wxyz
            {
                if(sprite[ps[myconnectindex].i].extra <= 0)
                {
                    if (enterlevel(MODE_GAME)) backtomenu();
                    return;
                }

                KB_ClearKeyDown(sc_N);
                KB_ClearKeyDown(sc_Escape);

                ps[myconnectindex].gm &= ~MODE_MENU;
                if(ud.multimode < 2 && ud.recstat != 2)
                {
                    ready2send = 1;
                    totalclock = ototalclock;
                }
            }

            if (ud.autosave > 0 && ud.multimode < 2 && (KB_KeyPressed(sc_A) || KB_KeyPressed(sc_F9) || RMB)) // wxas
               {
                KB_FlushKeyboardQueue();
                KB_ClearKeysDown();
                FX_StopAllSounds();
                c = loadplayer(10);
                if (c == 0)
                    ps[myconnectindex].gm = MODE_GAME;
               }

            if (KB_KeyPressed(sc_Space) || KB_KeyPressed(sc_Enter) || KB_KeyPressed(sc_kpad_Enter) || KB_KeyPressed(sc_Y) || LMB )
            {
                KB_FlushKeyboardQueue();
                KB_ClearKeysDown();
                FX_StopAllSounds();

                if(ud.multimode > 1)
                {
                    loadplayer(-1-lastsavedpos);
                    ps[myconnectindex].gm = MODE_GAME;
                }
                else
                {
                    c = loadplayer(lastsavedpos);
                    if (c == 0)
                        ps[myconnectindex].gm = MODE_GAME;
                }
            }

            probe(186,124+9,0,0);

            break;

        case 10000:
        case 10001:
            if (NAMGAME) { cmenu(0); break; }

            c = 80;
            rotatesprite(160<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(160,24,0,0,"ADULT MODE");

            x = probe(60,50+16,32,2);
            if (x == -1) { cmenu(202); probey = 6; break; }

            menutext(c,50+16,SHX(-2),PHX(-2),"ADULT MODE");
            menutext(c,50+16+16+16,SHX(-3),PHX(-3),"ENTER PASSWORD");

            if (ud.lockout)
               {
               menutext(c+120+10+5,50+16,0,0,"OFF");
               ud.pwlockout[0] = 0;
               }
            else
                menutext(c+120+10+5,50+16,0,0,"ON");

            if (current_menu == 10001)
            {
                gametext(160,50+16+16+16+16+16-12,"ENTER PASSWORD",0,2+8+16);
                x = strget((320>>1),50+16+16+16+16+16,buf,19, 998);

                if( x )
                {
                    if(ud.pwlockout[0] == 0 || ud.lockout == 0 )
                        strcpy(&ud.pwlockout[0],buf);
                    else if( strcmp(buf,&ud.pwlockout[0]) == 0 )
                    {
                        ud.lockout = 0;
                        buf[0] = 0;

                        for(x=0;x<numanimwalls;x++)
                            if( wall[animwall[x].wallnum].picnum != W_SCREENBREAK &&
                                wall[animwall[x].wallnum].picnum != W_SCREENBREAK+1 &&
                                wall[animwall[x].wallnum].picnum != W_SCREENBREAK+2 )
                                    if( wall[animwall[x].wallnum].extra >= 0 )
                                        wall[animwall[x].wallnum].picnum = wall[animwall[x].wallnum].extra;

                    }
                    current_menu = 10000;
                    KB_ClearKeyDown(sc_Enter);
                    KB_ClearKeyDown(sc_kpad_Enter);
                    KB_FlushKeyboardQueue();
                }
            }
            else
            {
                if(x == 0)
                {
                    if( ud.lockout == 1 )
                    {
                        if(ud.pwlockout[0] == 0)
                        {
                            ud.lockout = 0;
                            for(x=0;x<numanimwalls;x++)
                            if( wall[animwall[x].wallnum].picnum != W_SCREENBREAK &&
                                wall[animwall[x].wallnum].picnum != W_SCREENBREAK+1 &&
                                wall[animwall[x].wallnum].picnum != W_SCREENBREAK+2 )
                                    if( wall[animwall[x].wallnum].extra >= 0 )
                                        wall[animwall[x].wallnum].picnum = wall[animwall[x].wallnum].extra;
                        }
                        else
                        {
                            buf[0] = 0;
                            current_menu = 10001;
                            inputloc = 0;
                            KB_FlushKeyboardQueue();
                        }
                    }
                    else
                    {
                        ud.lockout = 1;

                        for(x=0;x<numanimwalls;x++)
                            switch(wall[animwall[x].wallnum].picnum)
                            {
                                case FEMPIC1:
                                    wall[animwall[x].wallnum].picnum = BLANKSCREEN;
                                    break;
                                case FEMPIC2:
                                case FEMPIC3:
                                    wall[animwall[x].wallnum].picnum = SCREENBREAK6;
                                    break;
                            }
                    }
                }

                else if(x == 1)
                {
                    current_menu = 10001;
                    inputloc = 0;
                    KB_FlushKeyboardQueue();
                }
            }

            break;

        case 1000:
        case 1001:
        case 1002:
        case 1003:
        case 1004:
        case 1005:
        case 1006:
        case 1007:
        case 1008:
        case 1009:

            rotatesprite(160<<16,200<<15,65536L,0,MENUSCREEN,16,0,10+64,0,0,xdim-1,ydim-1);
            rotatesprite(160<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(160,24,0,0,"LOAD GAME");
            rotatesprite(101<<16,97<<16,65536>>1,512,TILE_LOADSHOT,-32,0,4+10+64,0,0,xdim-1,ydim-1);

            dispnames();

              if (savehead.volnum == 0 && savehead.levnum == 7)
                 {
                 getboardmapname(savehead.boardfn);
                 sprintf(tempbuf,"MAPNAME: %s", boardmapname);       // wxmp
                 minitext(10+13,150,tempbuf,0,2+8+16);
                 }
              else
                 {
                 sprintf(tempbuf,"TITLE: %s", &level_names[11*savehead.volnum+savehead.levnum][0]);
                 minitext(10+21,150,tempbuf,0,2+8+16);
                 sprintf(tempbuf,"EPISODE: %d | LEVEL: %d",1+savehead.volnum,1+savehead.levnum);
                 minitext(10+13,171,tempbuf,0,2+8+16);
                 }

            second_tics = (totalclock/120); // 1               // wxst
            sprintf(tempbuf, "Time: %d mins %d secs", (second_tics/60), (second_tics%60)); // wxst
            minitext(10+25,157,tempbuf,0,2+8+16);

            sprintf(tempbuf,"SKILL: %d",savehead.plrskl);
            minitext(10+21,164,tempbuf,0,2+8+16);

            gametext(160,90,"LOAD game:",0,2+8+16);
            sprintf(tempbuf,"\"%s\"",ud.savegame[current_menu-1000]);

            gametext(160,99,tempbuf,0,2+8+16);
            gametext(160,99+9,"(Y/N)",0,2+8+16);

            if( KB_KeyPressed(sc_Space) || KB_KeyPressed(sc_Enter) || KB_KeyPressed(sc_kpad_Enter) || KB_KeyPressed(sc_Y) || LMB )
            {
                lastsavedpos = current_menu-1000;

                KB_FlushKeyboardQueue();
                KB_ClearKeysDown();
                if(ud.multimode < 2 && ud.recstat != 2)
                {
                    ready2send = 1;
                    totalclock = ototalclock;
                }

                if(ud.multimode > 1)
                {
                    if( ps[myconnectindex].gm&MODE_GAME )
                    {
                        loadplayer(-1-lastsavedpos);
                        ps[myconnectindex].gm = MODE_GAME;
                    }
                    else
                    {
                        tempbuf[0] = 126;
                        tempbuf[1] = lastsavedpos;
                        tempbuf[2] = myconnectindex;
                        for(x=connecthead;x>=0;x=connectpoint2[x])
                        {
                             if (x != myconnectindex) sendpacket(x,tempbuf,3);
                             if ((!networkmode) && (myconnectindex != connecthead)) break; //slaves in M/S mode only send to master
                        }
                        getpackets();

                        loadplayer(lastsavedpos);

                        multiflag = 0;
                    }
                }
                else
                {
                    c = loadplayer(lastsavedpos);
                    if(c == 0)
                        ps[myconnectindex].gm = MODE_GAME;
                }

                break;
            }
            if( KB_KeyPressed(sc_N) || KB_KeyPressed(sc_Escape) || RMB)
            {
                KB_ClearKeyDown(sc_N);
                KB_ClearKeyDown(sc_Escape);
                sound(EXITMENUSOUND);
                if(ps[myconnectindex].gm&MODE_DEMO) cmenu(300);
                else
                {
                    ps[myconnectindex].gm &= ~MODE_MENU;
                    if(ud.multimode < 2 && ud.recstat != 2)
                    {
                        ready2send = 1;
                        totalclock = ototalclock;
                    }
                }
            }

            probe(186,124+9,0,0);

            break;

        case 1500:

            if( KB_KeyPressed(sc_Space) || KB_KeyPressed(sc_Enter) || KB_KeyPressed(sc_kpad_Enter) || KB_KeyPressed(sc_Y) || LMB )
            {
                KB_FlushKeyboardQueue();
                cmenu(100);
            }
            if( KB_KeyPressed(sc_N) || KB_KeyPressed(sc_Escape) || RMB)
            {
                KB_ClearKeyDown(sc_N);
                KB_ClearKeyDown(sc_Escape);
                if(ud.multimode < 2 && ud.recstat != 2)
                {
                    ready2send = 1;
                    totalclock = ototalclock;
                }
                ps[myconnectindex].gm &= ~MODE_MENU;
                sound(EXITMENUSOUND);
                break;
            }
            probe(186,124,0,0);
            gametext(160,90,"ABORT this game?",0,2+8+16);
            gametext(160,90+9,"(Y/N)",0,2+8+16);

            break;

        case 2000:
        case 2001:
        case 2002:
        case 2003:
        case 2004:
        case 2005:
        case 2006:
        case 2007:
        case 2008:
        case 2009:

            rotatesprite(160<<16,200<<15,65536L,0,MENUSCREEN,16,0,10+64,0,0,xdim-1,ydim-1);
            rotatesprite(160<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(160,24,0,0,"SAVE GAME");

            rotatesprite(101<<16,97<<16,65536L>>1,512,TILE_LOADSHOT,-32,0,4+10+64,0,0,xdim-1,ydim-1);

            if (savehead.volnum == 0 && savehead.levnum == 7)
               {
               getboardmapname(boardfilename);
               sprintf(tempbuf,"MAPNAME: %s", boardmapname);         // wxmp
               minitext(10+13,150,tempbuf,0,2+8+16);
               }
            else
               {
               sprintf(tempbuf,"TITLE: %s", &level_names[11*ud.m_volume_number+ud.m_level_number][0]);
               minitext(10+21,150,tempbuf,0,2+8+16);
               sprintf(tempbuf,"EPISODE: %d | LEVEL: %d",1+ud.volume_number,1+ud.level_number);
               minitext(10+13,171,tempbuf,0,2+8+16);
               }

            second_tics = (totalclock/120);  // 2              // wxst
            sprintf(tempbuf, "Time: %d mins %d secs", (second_tics/60), (second_tics%60)); // wxst
            minitext(10+25,157,tempbuf,0,2+8+16);

            sprintf(tempbuf,"SKILL: %d",ud.player_skill);
            minitext(10+21,164,tempbuf,0,2+8+16);

            dispnames();

            gametext(160,90,"OVERWRITE previous SAVED game?",0,2+8+16);
            gametext(160,90+9,"(Y/N)",0,2+8+16);

            if( KB_KeyPressed(sc_Space) || KB_KeyPressed(sc_Enter) || KB_KeyPressed(sc_kpad_Enter) || KB_KeyPressed(sc_Y) || LMB )
            {
        inputloc = strlen(&ud.savegame[current_menu-2000][0]);

                cmenu(current_menu-2000+360);

                KB_FlushKeyboardQueue();
                break;
            }
            if( KB_KeyPressed(sc_N) || KB_KeyPressed(sc_Escape) || RMB)
            {
                KB_ClearKeyDown(sc_N);
                KB_ClearKeyDown(sc_Escape);
                cmenu(351);
                sound(EXITMENUSOUND);
            }

            probe(186,124,0,0);

            break;

        case 990:
        case 991:
        case 992:
        case 993:
        case 994:
        case 995:
        case 996:
        case 997:
        case 998:
            c = 160;
            if (!VOLUMEALL || !PLUTOPAK)
            {
                //rotatesprite(c<<16,200<<15,65536L,0,MENUSCREEN,16,0,10+64,0,0,xdim-1,ydim-1);
                rotatesprite(c<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
                menutext(c,24,0,0,current_menu == 998 ? "PORT CREDITS" : "CREDITS");

                l = 8;
            } else {
                l = 3;
            }

            if (KB_KeyPressed(sc_Escape))
            {
                cmenu(0);
                break;
            }

            if (KB_KeyPressed( sc_LeftArrow) ||
                KB_KeyPressed( sc_kpad_4 ) ||
                KB_KeyPressed( sc_UpArrow ) ||
                KB_KeyPressed( sc_PgUp ) ||
                KB_KeyPressed( sc_kpad_8 ) )
            {
                KB_ClearKeyDown(sc_LeftArrow);
                KB_ClearKeyDown(sc_kpad_4);
                KB_ClearKeyDown(sc_UpArrow);
                KB_ClearKeyDown(sc_PgUp);
                KB_ClearKeyDown(sc_kpad_8);

                sound(KICK_HIT);
                current_menu--;
                if (current_menu < 990) current_menu = 990+l;
            }
            else if(
                KB_KeyPressed( sc_PgDn ) ||
                KB_KeyPressed( sc_Enter ) ||
                KB_KeyPressed( sc_Space ) ||
                KB_KeyPressed( sc_kpad_Enter ) ||
                KB_KeyPressed( sc_RightArrow ) ||
                KB_KeyPressed( sc_DownArrow ) ||
                KB_KeyPressed( sc_kpad_2 ) ||
                KB_KeyPressed( sc_kpad_9 ) ||
                KB_KeyPressed( sc_kpad_6 ) )
            {
                KB_ClearKeyDown(sc_PgDn);
                KB_ClearKeyDown(sc_Enter);
                KB_ClearKeyDown(sc_RightArrow);
                KB_ClearKeyDown(sc_kpad_Enter);
                KB_ClearKeyDown(sc_kpad_6);
                KB_ClearKeyDown(sc_kpad_9);
                KB_ClearKeyDown(sc_kpad_2);
                KB_ClearKeyDown(sc_DownArrow);
                KB_ClearKeyDown(sc_Space);
                sound(KICK_HIT);
                current_menu++;
                if(current_menu > 990+l) current_menu = 990;
            }

            if (!VOLUMEALL || !PLUTOPAK)
            {
            switch (current_menu)
            {
                case 990:
                    gametext(c,40,                      "ORIGINAL CONCEPT",0,2+8+16);
                    gametext(c,40+9,                    "TODD REPLOGLE",0,2+8+16);
                    gametext(c,40+9+9,                  "ALLEN H. BLUM III",0,2+8+16);

                    gametext(c,40+9+9+9+9,              "PRODUCED & DIRECTED BY",0,2+8+16);
                    gametext(c,40+9+9+9+9+9,            "GREG MALONE",0,2+8+16);

                    gametext(c,40+9+9+9+9+9+9+9,        "EXECUTIVE PRODUCER",0,2+8+16);
                    gametext(c,40+9+9+9+9+9+9+9+9,      "GEORGE BROUSSARD",0,2+8+16);

                    gametext(c,40+9+9+9+9+9+9+9+9+9+9,  "BUILD ENGINE",0,2+8+16);
                    gametext(c,40+9+9+9+9+9+9+9+9+9+9+9,"KEN SILVERMAN",0,2+8+16);
                    break;
                case 991:
                    gametext(c,40,                      "GAME PROGRAMMING",0,2+8+16);
                    gametext(c,40+9,                    "TODD REPLOGLE",0,2+8+16);

                    gametext(c,40+9+9+9,                "3D ENGINE/TOOLS/NET",0,2+8+16);
                    gametext(c,40+9+9+9+9,              "KEN SILVERMAN",0,2+8+16);

                    gametext(c,40+9+9+9+9+9+9,          "NETWORK LAYER/SETUP PROGRAM",0,2+8+16);
                    gametext(c,40+9+9+9+9+9+9+9,        "MARK DOCHTERMANN",0,2+8+16);
                    break;
                case 992:
                    gametext(c,40,                      "MAP DESIGN",0,2+8+16);
                    gametext(c,40+9,                    "ALLEN H BLUM III",0,2+8+16);
                    gametext(c,40+9+9,                  "RICHARD GRAY",0,2+8+16);

                    gametext(c,40+9+9+9+9,              "3D MODELING",0,2+8+16);
                    gametext(c,40+9+9+9+9+9,            "CHUCK JONES",0,2+8+16);
                    gametext(c,40+9+9+9+9+9+9,          "SAPPHIRE CORPORATION",0,2+8+16);

                    gametext(c,40+9+9+9+9+9+9+9+9,      "ARTWORK",0,2+8+16);
                    gametext(c,40+9+9+9+9+9+9+9+9+9,    "DIRK JONES, STEPHEN HORNBACK",0,2+8+16);
                    gametext(c,40+9+9+9+9+9+9+9+9+9+9,  "JAMES STOREY, DAVID DEMARET",0,2+8+16);
                    gametext(c,40+9+9+9+9+9+9+9+9+9+9+9,"DOUGLAS R WOOD",0,2+8+16);
                    break;
                case 993:
                    gametext(c,40,                      "SOUND ENGINE",0,2+8+16);
                    gametext(c,40+9,                    "JIM DOSE",0,2+8+16);

                    gametext(c,40+9+9+9,                "SOUND & MUSIC DEVELOPMENT",0,2+8+16);
                    gametext(c,40+9+9+9+9,              "ROBERT PRINCE",0,2+8+16);
                    gametext(c,40+9+9+9+9+9,            "LEE JACKSON",0,2+8+16);

                    gametext(c,40+9+9+9+9+9+9+9,        "VOICE TALENT",0,2+8+16);
                    gametext(c,40+9+9+9+9+9+9+9+9,      "LANI MINELLA - VOICE PRODUCER",0,2+8+16);
                    gametext(c,40+9+9+9+9+9+9+9+9+9,    "JON ST. JOHN AS \"DUKE NUKEM\"",0,2+8+16);
                    break;
                case 994:
                    gametext(c,60,                      "GRAPHIC DESIGN",0,2+8+16);
                    gametext(c,60+9,                    "PACKAGING, MANUAL, ADS",0,2+8+16);
                    gametext(c,60+9+9,                  "ROBERT M. ATKINS",0,2+8+16);
                    gametext(c,60+9+9+9,                "MICHAEL HADWIN",0,2+8+16);

                    gametext(c,60+9+9+9+9+9,            "SPECIAL THANKS TO",0,2+8+16);
                    gametext(c,60+9+9+9+9+9+9,          "STEVEN BLACKBURN, TOM HALL",0,2+8+16);
                    gametext(c,60+9+9+9+9+9+9+9,        "SCOTT MILLER, JOE SIEGLER",0,2+8+16);
                    gametext(c,60+9+9+9+9+9+9+9+9,      "TERRY NAGY, COLLEEN COMPTON",0,2+8+16);
                    gametext(c,60+9+9+9+9+9+9+9+9+9,    "HASH INC., FORMGEN, INC.",0,2+8+16);
                    break;
                case 995:
                    gametext(c,49,                      "THE 3D REALMS BETA TESTERS",0,2+8+16);

                    gametext(c,49+9+9,                  "NATHAN ANDERSON, WAYNE BENNER",0,2+8+16);
                    gametext(c,49+9+9+9,                "GLENN BRENSINGER, ROB BROWN",0,2+8+16);
                    gametext(c,49+9+9+9+9,              "ERIK HARRIS, KEN HECKBERT",0,2+8+16);
                    gametext(c,49+9+9+9+9+9,            "TERRY HERRIN, GREG HIVELY",0,2+8+16);
                    gametext(c,49+9+9+9+9+9+9,          "HANK LEUKART, ERIC BAKER",0,2+8+16);
                    gametext(c,49+9+9+9+9+9+9+9,        "JEFF RAUSCH, KELLY ROGERS",0,2+8+16);
                    gametext(c,49+9+9+9+9+9+9+9+9,      "MIKE DUNCAN, DOUG HOWELL",0,2+8+16);
                    gametext(c,49+9+9+9+9+9+9+9+9+9,    "BILL BLAIR",0,2+8+16);
                    break;
                case 996:
                    gametext(c,32,                      "COMPANY PRODUCT SUPPORT",0,2+8+16);

                    gametext(c,32+9+9,                  "THE FOLLOWING COMPANIES WERE COOL",0,2+8+16);
                    gametext(c,32+9+9+9,                "ENOUGH TO GIVE US LOTS OF STUFF",0,2+8+16);
                    gametext(c,32+9+9+9+9,              "DURING THE MAKING OF DUKE NUKEM 3D.",0,2+8+16);

                    gametext(c,32+9+9+9+9+9+9,          "ALTEC LANSING MULTIMEDIA",0,2+8+16);
                    gametext(c,32+9+9+9+9+9+9+9,        "FOR TONS OF SPEAKERS AND THE",0,2+8+16);
                    gametext(c,32+9+9+9+9+9+9+9+9,      "THX-LICENSED SOUND SYSTEM",0,2+8+16);
                    gametext(c,32+9+9+9+9+9+9+9+9+9,    "FOR INFO CALL 1-800-548-0620",0,2+8+16);

                    gametext(c,32+9+9+9+9+9+9+9+9+9+9+9,"CREATIVE LABS, INC.",0,2+8+16);

                    gametext(c,32+9+9+9+9+9+9+9+9+9+9+9+9+9,"THANKS FOR THE HARDWARE, GUYS.",0,2+8+16);
                    break;
                case 997:
                    gametext(c,50,                      "DUKE NUKEM IS A TRADEMARK OF",0,2+8+16);
                    gametext(c,50+9,                    "3D REALMS ENTERTAINMENT",0,2+8+16);

                    gametext(c,50+9+9+9,                "DUKE NUKEM",0,2+8+16);
                    gametext(c,50+9+9+9+9,              "(C) 1996 3D REALMS ENTERTAINMENT",0,2+8+16);

                    if (VOLUMEONE) {
                    gametext(c,106,                     "PLEASE READ LICENSE.DOC FOR SHAREWARE",0,2+8+16);
                    gametext(c,106+9,                   "DISTRIBUTION GRANTS AND RESTRICTIONS",0,2+8+16);
                    }

                    gametext(c,VOLUMEONE?134:115,       "MADE IN DALLAS, TEXAS USA",0,2+8+16);
                    break;
                case 998:
                    l = 10;
                    goto cheat_for_port_credits;
            }
            break;
            }

            // Plutonium pak menus
            switch(current_menu)
            {
                case 990:
                case 991:
                case 992:
                   rotatesprite(160<<16,200<<15,65536L,0,2504+current_menu-990,0,0,10+64,0,0,xdim-1,ydim-1);
                   break;
                case 993:   // JBF 20031220
                   rotatesprite(160<<16,200<<15,65536L,0,MENUSCREEN,0,0,10+64,0,0,xdim-1,ydim-1);
                   menutext(160,28,0,0,"PORT CREDITS");

                   l = 0;
cheat_for_port_credits:
                   gametext(160,35-l,"GAME AND ENGINE PORT",0,2+8+16);
                   p = "Jonathon \"JonoF\" Fowler";
                   minitext(160-(Bstrlen(p)<<1), 35+10-l, p, 12, 10+16+128);

                   gametext(160,55-l,"\"POLYMOST\" 3D RENDERER",0,2+8+16);
                   gametext(160,55+8-l,"NETWORKING, OTHER CODE",0,2+8+16);
                   p = "Ken \"Awesoken\" Silverman";
                   minitext(160-(Bstrlen(p)<<1), 55+8+10-l, p, 12, 10+16+128);

                   p = "Icon and startup graphics by Lachlan \"NetNessie\" McDonald";
                   minitext(160-(Bstrlen(p)<<1), 87-l, p, 9, 10+16+128);

                   {
                        const char *scroller[] =
                        {
                            "This program is free software; you can redistribute it",
                            "and/or modify it under the terms of the GNU General",
                            "Public License as published by the Free Software",
                            "Foundation; either version 2 of the License, or (at your",
                            "option) any later version.",
                            "",
                            "This program is distributed in the hope that it will be",
                            "useful but WITHOUT ANY WARRANTY; without even the implied",
                            "warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR",
                            "PURPOSE. See the GNU General Public License (GPL.TXT) for",
                            "more details.",
                            "",
                            "",
                            "",
                            "",
                            "Thanks to these people for their input and contributions:",
                            "",
                            "Michael Burgwin",
                            "Richard \"TerminX\" Gobeille, ",
                            "Par \"Parkar\" Karlsson",
                            "Matthieu Klein",
                            "Ben \"ProAsm\" Smit",
                            "",
                            "and all those who submitted bug reports and ",
                            "supported the project financially!",
                            "",
                            "",
                            "--x--",
                            "",
                            "",
                            "",
                            ""
                        };
                        const int numlines = sizeof(scroller)/sizeof(char *);
                        for (m=0,i=(totalclock/104)%numlines; m<4; m++,i++)
                        {
                            if (i==numlines) i=0;                                                    //8
                            minitext(160-(Bstrlen(scroller[i])<<1), 92+10+(m*7)-l, (char*)scroller[i], 2, 10+16+128);
                        }
                   }

                   for (i=0;i<2;i++)
                   {
                       switch (i)
                       {
                           case 0: p = "Visit http://jonof.edgenetwork.org/jfduke3d/ for"; break;
                           case 1: p = "the source code, latest news, and updates of this port."; break;
                       }
                       minitext(160-(Bstrlen(p)<<1), 128+10+(i*7)-l, p, 8, 10+16+128);
                   }
                   gametext(160,158-l,"DUKE3DW",0,2+8+16);
                   p = "Programming by Ben \"ProAsm\" Smit";
                   minitext(160-(Bstrlen(p)<<1), 170-l, p, 12, 10+16+128);
                   p = "http://www.proasm.com/";
                   minitext(160-(Bstrlen(p)<<1), 178-l, p, 12, 10+16+128);
                   break;
            }
            break;

        case 0:
            c = (320>>1);
            rotatesprite(c<<16,28<<16,65536L,0,INGAMEDUKETHREEDEE,0,0,10,0,0,xdim-1,ydim-1);
            x = probe(c,67-5,16,6);

            if (x >= 0)
            {
                if( ud.multimode > 1 && x == 0 && ud.recstat != 2)
                {
                    if( movesperpacket == 4 && myconnectindex != connecthead )
                        break;

                    last_zero = 0;
                    cmenu( 600 );
                }
                else
                {
                    last_zero = x;
                    switch(x)
                    {
                        case 0:
                            cmenu(100);
                            break;
                            //case 1: break;//cmenu(20001);break;   // JBF 20031128: I'm taking over the TEN menu option
                        case 1:
                            cmenu(202);
                            break;  // JBF 20031205: was 200
                        case 2:
                            if (movesperpacket == 4 && connecthead != myconnectindex)
                                break;
                            cmenu(300);
                            break;
                        case 3:
                            KB_FlushKeyboardQueue();
                            cmenu(400);
                            break;
                        case 4:
                            cmenu(990);
                            break;
                        case 5:
                            cmenu(500);         // main title menu
                            break;
                    }
                }
            }

            if (KB_KeyPressed(sc_Q))
                cmenu(500);

            if (x == -1)
            {
                ps[myconnectindex].gm &= ~MODE_MENU;
                if(ud.multimode < 2 && ud.recstat != 2)
                {
                    ready2send = 1;
                    totalclock = ototalclock;
                }
            }

            if (movesperpacket == 4)
            {
                if( myconnectindex == connecthead )
                    menutext(c,65,SHX(-2),PHX(-2),"NEW GAME");
                else
                    menutext(c,65,SHX(-2),1,"NEW GAME");
            }
            else
                menutext(c,65,SHX(-2),PHX(-2),"NEW GAME");

                //menutext(c,65+16,0,1,"NETWORK GAME");

            menutext(c,65+16/*+16*/,SHX(-3),PHX(-3),"OPTIONS");

            if (movesperpacket == 4 && connecthead != myconnectindex)
                menutext(c,65+16+16/*+16*/,SHX(-4),1,"LOAD GAME");
            else
                menutext(c,65+16+16/*+16*/,SHX(-4),PHX(-4),"LOAD GAME");

            if (!VOLUMEALL)
            {
               menutext(c,65+16+16+16/*+16*/,SHX(-5),PHX(-5),"HOW TO ORDER");
            }
            else
            {
               menutext(c,65+16+16+16/*+16*/,SHX(-5),PHX(-5),"HELP");
            }
            menutext(c,65+16+16+16+16/*+16*/,SHX(-6),PHX(-6),"CREDITS");

            menutext(c,65+16+16+16+16+16/*+16*/,SHX(-7),PHX(-7),"QUIT");

            break;

        case 50:
            c = (320>>1);
            rotatesprite(c<<16,32<<16,65536L,0,INGAMEDUKETHREEDEE,0,0,10,0,0,xdim-1,ydim-1);
            x = probe(c,67-5,16,8);
            switch(x)
            {
                case 0:
                    if(movesperpacket == 4 && myconnectindex != connecthead)
                        break;
                    if(ud.multimode < 2 || ud.recstat == 2)
                        cmenu(1500);
                    else
                    {
                        cmenu(600);
                        last_fifty = 0;
                    }
                    break;
                case 1:
                    if(movesperpacket == 4 && connecthead != myconnectindex)
                        break;
                    if(ud.recstat != 2)
                    {
                        last_fifty = 1;
                        cmenu(350);
                        setview(0,0,xdim-1,ydim-1);
                    }
                    break;
                case 2:
                    if(movesperpacket == 4 && connecthead != myconnectindex)
                        break;
                    last_fifty = 2;
                    cmenu(300);
                    break;
                case 3:
                    last_fifty = 3;
                    cmenu(202);     // JBF 20031205: was 200
                    break;
                case 4:
                    last_fifty = 4;
                    KB_FlushKeyboardQueue();
                    cmenu(400);
                    break;
                case 5:                                              // wxsm
                    if (numplayers > 1)
                        sendlogoff();
                    gameexit("xxx");
                    break;
                case 6:
                    if (numplayers < 2)
                    {
                        last_fifty = 6;
                        cmenu(501);
                    }
                    break;
                case 7:
                    last_fifty = 7;
                    cmenu(500);
                    break;
                case -1:
                    ps[myconnectindex].gm &= ~MODE_MENU;
                    if(ud.multimode < 2 && ud.recstat != 2)
                    {
                        ready2send = 1;
                        totalclock = ototalclock;
                    }
                    break;
            }

            if( KB_KeyPressed(sc_Q) )
                cmenu(500);

            if(movesperpacket == 4 && connecthead != myconnectindex)
            {
                menutext(c,65                  ,SHX(-2),1,"NEW GAME");
                menutext(c,65+16               ,SHX(-3),1,"SAVE GAME");
                menutext(c,65+16+16            ,SHX(-4),1,"LOAD GAME");
            }
            else
            {
                menutext(c,65                  ,SHX(-2),PHX(-2),"NEW GAME");
                menutext(c,65+16               ,SHX(-3),PHX(-3),"SAVE GAME");
                menutext(c,65+16+16            ,SHX(-4),PHX(-4),"LOAD GAME");
            }

            menutext(c,65+16+16+16         ,SHX(-5),PHX(-5),"OPTIONS");
    if (!VOLUMEALL)
    {
            menutext(c,65+16+16+16+16      ,SHX(-6),PHX(-6),"HOW TO ORDER");
    }
    else
    {
            menutext(c,65+16+16+16+16      ,SHX(-6),PHX(-6)," HELP");
    }
            menutext(c,65+16+16+16+16+16   ,SHX(-8),PHX(-8),"STARTUP MENU"); // wxsm

            if(numplayers > 1)
               menutext(c,65+16+16+16+16+16+16   ,SHX(-7),1,"QUIT TO TITLE");
            else
               menutext(c,65+16+16+16+16+16+16   ,SHX(-7),PHX(-7),"QUIT TO TITLE");
            menutext(c,65+16+16+16+16+16+16+16,SHX(-9),PHX(-9),"QUIT GAME");
            break;

        case 100:
            if (ud.multimode > 1)
            {
                cmenu(600);
                break;
            }
            rotatesprite(160<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(160,24,0,0,"SELECT AN EPISODE");

            if (PLUTOPAK)
            {
                if (!bGrp)                                           // wxbg
                    x = probe(160,60,20,5);
                else
                    x = probe(160,60,20,4);
            }
            else
            {
                 x = probe(160,60,20,VOLUMEONE?3:4);
            }

            if(x >= 0)
            {
    if (VOLUMEONE)
    {
                if(x > 0)
                    cmenu(20000);
                else
                {
                    ud.m_volume_number = x;
                    ud.m_level_number = 0;
                    cmenu(110);
                }
    }

    if (!VOLUMEONE)
    {
                if(!PLUTOPAK && x == 3 /*&& boardfilename[0]*/)
                {
                    //ud.m_volume_number = 0;
                    //ud.m_level_number = 7;
            currentlist = 1;
            cmenu(101);
                }
        else if(PLUTOPAK && x == 4 /*&& boardfilename[0]*/)
                {
                    //ud.m_volume_number = 0;
                    //ud.m_level_number = 7;
            currentlist = 1;
            cmenu(101);
                }

                else
                {
                    ud.m_volume_number = x;
                    ud.m_level_number = 0;
                    cmenu(110);
                }
    }
            }
            else
            if (x == -1)
            {
                if (ps[myconnectindex].gm&MODE_GAME)
                    cmenu(50);
                else
                    cmenu(0);
            }

            menutext(160,60,SHX(-2),PHX(-2),volume_names[0]);

            c = 80;
    if (VOLUMEONE)
    {
        menutext(160,60+20,SHX(-3),1,volume_names[1]);
        menutext(160,60+20+20,SHX(-4),1,volume_names[2]);
        if (PLUTOPAK)
            menutext(160,60+20+20,SHX(-5),1,volume_names[3]);
    }
    else
    {
        menutext(160,60+20,SHX(-3),PHX(-3),volume_names[1]);
        menutext(160,60+20+20,SHX(-4),PHX(-4),volume_names[2]);
        if (PLUTOPAK)
        {
            menutext(160,60+20+20+20,SHX(-5),PHX(-5),volume_names[3]);
           if (!bGrp)                                                // wxbg
               menutext(160,60+20+20+20+20,SHX(-6),PHX(-6),"USER MAP");
        }
        else
        {
            if (!bGrp)                                               // wxbg
                menutext(160,60+20+20+20,SHX(-6),PHX(-6),"USER MAP");
        }
    }
        break;

    case 101:
        if (boardfilename[0] == 0)
            strcpy(boardfilename, "./");
        Bcorrectfilename(boardfilename,1);
        getfilenames(boardfilename,"*.map",0);
        cmenu(102);
        KB_FlushKeyboardQueue();
    case 102:
        rotatesprite(160<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
        menutext(160,24,0,0,"SELECT A USER MAP");

        // black translucent background underneath file lists
        rotatesprite(0<<16, 0<<16, 65536l<<5, 0, BLANK, 0, 0, 10+16+1+32,
                     scale(40-4,xdim,320),scale(12+32-2,ydim,200),
                     scale(320-40+4,xdim,320)-1,scale(12+32+112+4,ydim,200)-1);

        // path
        minitext(44,54,boardfilename,9,26);

        {   // JBF 20040208: seek to first name matching pressed character
            CACHE1D_FIND_REC *seeker = currentlist ? findfiles : finddirs;
            char ch2, ch;

            ch = KB_Getch();
            if (ch > 0 && ((ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z') || (ch >= '0' && ch <= '9')))
            {
                if (ch >= 'a')
                    ch -= ('a'-'A');
                while (seeker)
                {
                    ch2 = seeker->name[0];
                    if (ch2 >= 'a' && ch2 <= 'z')
                        ch2 -= ('a'-'A');
                    if (ch2 == ch)
                        break;
                    seeker = seeker->next;
                }
                if (seeker)
                {
                    if (currentlist)
                        findfileshigh = seeker;
                    else
                        finddirshigh = seeker;
                    sound(KICK_HIT);
                }
            }
        }

        gametext(40+4,12+32,"DIRECTORIES",0,2+8+16);

        if (finddirshigh)
        {
           dir = finddirshigh;
           for (i=0; i<6; i++)
           {
               if (!dir->prev)
                   break;
               else
                   dir=dir->prev;
           }
           for (i=6; i>-6 && dir; i--, dir=dir->next)
           {
               if (dir == finddirshigh)
                   c=0;
               else
                   c=16;
               minitextshade(40+4,18+12+32+8*(6-i),dir->name,c,0,26);
           }
        }

        gametext(180+4,12+32,"MAP FILES",0,2+8+16);

        if (findfileshigh)
           {
           dir = findfileshigh;
           for (i=0; i<6; i++)
              if (!dir->prev)
                  break;
           else
              dir=dir->prev;
           for(i=6; i>-6 && dir; i--, dir=dir->next)
              {
              if (dir == findfileshigh)
                  c=0;
              else
                  c=16;
              minitextshade(184,18+12+32+8*(6-i),dir->name,c,2,26);
              }
           }

        if (KB_KeyPressed(sc_LeftArrow) || KB_KeyPressed(sc_kpad_4) || ((buttonstat&1) && minfo.dyaw < -256 ) ||
            KB_KeyPressed( sc_RightArrow ) || KB_KeyPressed( sc_kpad_6 ) || ((buttonstat&1) && minfo.dyaw > 256 ) ||
            KB_KeyPressed( sc_Tab ) )
            {
                KB_ClearKeyDown( sc_LeftArrow );
                KB_ClearKeyDown( sc_kpad_4 );
                KB_ClearKeyDown( sc_RightArrow );
                KB_ClearKeyDown( sc_kpad_6 );
                KB_ClearKeyDown( sc_Tab );
                currentlist = 1-currentlist;
                sound(KICK_HIT);
            }

        onbar = 0;
        probey = 2;
        if (currentlist == 0)
            x = probesm(45, 12+32+5,0,3);
        else
            x = probesm(185,12+32+5,0,3);

        if (probey == 1)
        {
            if (currentlist == 0)
            {
                if (finddirshigh)
                    if (finddirshigh->prev) finddirshigh = finddirshigh->prev;
            }
            else
            {
                if (findfileshigh)
                    if (findfileshigh->prev)
                        findfileshigh = findfileshigh->prev;
            }
        }
        else
        if (probey == 0)
        {
            if (currentlist == 0)
            {
                if (finddirshigh)
                    if (finddirshigh->next)
                        finddirshigh = finddirshigh->next;
            }
            else
            {
                if (findfileshigh)
                    if (findfileshigh->next)
                        findfileshigh = findfileshigh->next;
            }
        }

        if (x == -1)
        {
            clearfilenames();
            boardfilename[0] = 0;
            if (ud.multimode > 1)
                cmenu(600);
            else
                cmenu(100);
        }
        else
        if (x >= 0)
        {
            if (currentlist == 0)
            {
                if (!finddirshigh)
                    break;
                strcat(boardfilename, finddirshigh->name);
                strcat(boardfilename, "/");
                Bcorrectfilename(boardfilename, 1);
                cmenu(101);
                KB_FlushKeyboardQueue();
            }
            else
            {
                if (!findfileshigh)
                    break;
                strcat(boardfilename, findfileshigh->name);
                ud.m_volume_number = 0;
                ud.m_level_number = 7;
                checkforsaves(boardfilename);
                readsavenames();
                getboardmapname(boardfilename);
                SetLastPlayed(boardmapname, 1);                      // 100202
                if (ud.multimode > 1)                                // wxmu
                {
                   cmenu(600);
                   break;
                }
                cmenu(110);
            }
            clearfilenames();
        }
        break;

        case 110:
            c = (320>>1);
            rotatesprite(c<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(c,24,0,0,"SELECT SKILL");
            x = probe(c,70,19,4);
            if(x >= 0)
            {
                switch(x)
                {
                    case 0: globalskillsound = JIBBED_ACTOR6;break;
                    case 1: globalskillsound = BONUS_SPEECH1;break;
                    case 2: globalskillsound = DUKE_GETWEAPON2;break;
                    case 3: globalskillsound = JIBBED_ACTOR5;break;
                }

                sound(globalskillsound);

                ud.m_player_skill = x+1;
                if (x >= 3)                                          // wxrs
                    ud.m_respawn_monsters = 1;
                else
                    ud.m_respawn_monsters = 0;

                ud.m_monsters_off = ud.monsters_off = 0;

                ud.m_respawn_items = 0;
                ud.m_respawn_inventory = 0;

                ud.multimode = 1;

                if(ud.m_volume_number == 3)
                {
                    flushperms();
                    setview(0,0,xdim-1,ydim-1);
                    clearview(0L);
                    nextpage();
                }

                newgame(ud.m_volume_number,ud.m_level_number,ud.m_player_skill);
                if (enterlevel(MODE_GAME)) backtomenu();
            }
            else if(x == -1)
            {
                cmenu(100);
                KB_FlushKeyboardQueue();
            }

            menutext(c,70,SHX(-2),PHX(-2),skill_names[0]);
            menutext(c,70+19,SHX(-3),PHX(-3),skill_names[1]);
            menutext(c,70+19+19,SHX(-4),PHX(-4),skill_names[2]);
            menutext(c,70+19+19+19,SHX(-5),PHX(-5),skill_names[3]);
            break;

//-----------------------------------------------------------------------------

        case 200:

            rotatesprite(320<<15,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(320>>1,24,0,0,"GAME OPTIONS");

            c = (320>>1)-110;

        {
            int io, ii, yy, d=c+160+20, enabled;
            char *opts[] =
            {
                "Crosshair",
                "Level stats",
                "Auto weapon switch",
                "Auto aiming",
                "Auto Saving",                                       // wxas
                "Run key style",
                "Show Startup Menu",                                 // wxsm
                "Record demo",
                "More Options",
                NULL
            };

            yy = 40;
            for (ii=io=0; opts[ii]; ii++)
            {
                if (io < probey)
                    yy += 12;
                io++;
            }

            onbar = (probey == 2 || probey == 6);
            x = probemd(c-10,yy+3,0,io);

            if (x == -1)
               {
                cmenu(202);
                break;
               }

            if (x == 8)
               {
                cmenu(201);
                break;
               }

#define OFFSHADE 17

            yy = 40;
            for (ii=io=0; opts[ii]; ii++)
            {
                enabled = 1;
                shd = 0;
                switch (io)
                {
                    case 0:
                        if (x==io)
                            ud.crosshair = (ud.crosshair==2)?0:ud.crosshair+1;
                        {
                            char *s[] = { "Off", "Max", "Min" };     // wxch
                            gametext(d,yy,s[ud.crosshair], 0, 2+8+16);
                            break;
                        }
                    case 1:  if (x==io) ud.levelstats = 1-ud.levelstats;
                             gametext(d,yy, ud.levelstats ? "Shown" : "Hidden", 0, 2+8+16); break;
                    case 2: // if (ps[myconnectindex].gm&MODE_GAME || numplayers > 1) enabled = 0; // wxen
                         if (numplayers > 1)
                             enabled = 0;
                         if (enabled && x==io)
                            { ud.weaponswitch = (ud.weaponswitch == 3) ? 0 : ud.weaponswitch+1; }
                            { char *s[] = { "Off", "New", "Empty", "New+Empty" };
                              gametext(d,yy, s[ud.weaponswitch], enabled?0:OFFSHADE, 2+8+16); break; }
                         break;
                    case 3:  //if (ps[myconnectindex].gm&MODE_GAME || numplayers > 1) enabled = 0; // wxen
                         if (numplayers > 1)
                             enabled = 0;
                         if (enabled && x==io)
                         {
                             AutoAim = 1-AutoAim;
                             //xCol++;
                             //if (xCol > 32)
                                 //xCol = 0;
                         }
                         //sprintf(tempbuf, "%d", xCol);              // to display colors only
                         //gametextsm(d,yy, tempbuf, xCol, 2+8+16); break;
                         gametext(d,yy, AutoAim ? "On" : "Off", enabled?0:OFFSHADE, 2+8+16); break;

                    case 4:
                         if (x==io)
                            { ud.autosave = (ud.autosave == 2) ? 0 : ud.autosave+1; }
                            { char *s[] = { "Off", "Auto", "Manual" };
                            ud.autodone = 0;
                            gametext(d,yy, s[ud.autosave], 0, 2+8+16);
                            break;
                            }
                    case 5:
                         if (x==io) ud.runkey_mode = 1-ud.runkey_mode;
                         gametext(d,yy, ud.runkey_mode ? "Classic" : "Modern", 0, 2+8+16); break;
                    case 6: if (x==io) ForceSetup = 1-ForceSetup;
                         gametext(d,yy, ForceSetup ? "Yes" : "No", 0, 2+8+16); break;
                    case 7: if (x==io)
                         {
                                if( (ps[myconnectindex].gm&MODE_GAME) ) closedemowrite();
                                else ud.m_recstat = !ud.m_recstat;
                         }
                             if( (ps[myconnectindex].gm&MODE_GAME) && ud.m_recstat != 1 ) enabled = 0;
                         gametext(d,yy, ud.m_recstat==1 ? "On" : "Off", enabled?0:OFFSHADE, 2+8+16); break;
                    case 8:
                         shd = 12;
                         break;

                    default: break;
                }
                menutextc(c,yy+10,shd,enabled?0:1,opts[ii]);         // wxch
                io++;
                yy += 12;
            }
        }
        break;

        case 201:

            rotatesprite(320<<15,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(320>>1,24,0,0,"GAME OPTIONS");

            c = (320>>1)-110;

        {
            int io, ii, yy, d=c+160+20, enabled;
            char *opts[] =
            {
                "Screen Detail",
                "Screen Shadows",
                "Screen Tilting",
                "Screen Messages",                                   // wxmo
                "Player Weapon",                                     // wxwh
                "Previous Options",
                NULL
            };

            yy = 40;
            for (ii=io=0; opts[ii]; ii++)
            {
                if (io < probey)
                    yy += 12;
                io++;
            }

            onbar = 0; //(probey == 2 || probey == 6);
            x = probemd(c-10,yy+3,0,io);

            if (x == -1 || x == 5)
               {
                probey = 8;
                cmenu(200);
                break;
               }

#define OFFSHADE 17

            yy = 40;
            for (ii=io=0; opts[ii]; ii++)
            {
                enabled = 1;
                shd = 0;
                switch (io)
                {
                    case 0: if (x==io) ud.detail = 1-ud.detail;                             // wxmo
                         gametext(d,yy, ud.detail ? "High" : "Low", 0, 2+8+16); break;
                    case 1: if (x==io) ud.shadows = 1-ud.shadows;
                         gametext(d,yy, ud.shadows ? "On" : "Off", 0, 2+8+16); break;
                    case 2: if (x==io) ud.screen_tilting = 1-ud.screen_tilting;
                         gametext(d,yy, ud.screen_tilting ? "On" : "Off", 0, 2+8+16); break;
                    case 3:  if (x==io) ud.fta_on = 1-ud.fta_on;
                         gametext(d,yy, ud.fta_on ? "On" : "Off", 0, 2+8+16); break;
                    case 4: if (x==io) ud.weaponhide = 1-ud.weaponhide;                     // wxwo
                         gametext(d,yy, ud.weaponhide ? "Hide" : "Show", 0, 2+8+16); break;
                    case 5:
                         shd = 12; break;
                    default: break;
                }
                menutextc(c,yy+10,shd,enabled?0:1,opts[ii]);
                io++;
                yy += 12;
            }
        }
        break;

//------------------------------------------------------------------------------------------------

        // JBF 20031205: Second level options menu selection
    case 202:
            rotatesprite(320<<15,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(320>>1,24,0,0,"OPTIONS");

        c = 200>>1;
        c += 5;

            onbar = 0;
            x = probe(160,c-18-18-18-2,18,8-NAMGAME-NAMGAME);

        switch (x)
        {
        case -1:
              KB_KeyDown[sc_Escape] = 1;
              cmenu(0);
            break;

        case 0:
            cmenu(200);
            break;

        case 1:
            cmenu(700);
            break;

        case 2:
            {
                int dax = xdim, day = ydim, daz;

                curvidmode = newvidmode = checkvideomode(&dax,&day,bpp,fullscreen,0);
                if (newvidmode == 0x7fffffffl) newvidmode = validmodecnt;
                newfullscreen = fullscreen;
                changesmade = 0;

                dax = 0;
                for (day = 0; day < validmodecnt; day++)
                {
                    if (dax == sizeof(vidsets)/sizeof(vidsets[1])) break;
                    for (daz = 0; daz < dax; daz++)
                        if ((validmode[day].bpp|((validmode[day].fs&1)<<16)) == (vidsets[daz]&0x1ffffl)) break;
                    if (vidsets[daz] != -1) continue;
                    if (validmode[day].bpp == 8)
                    {
                        if (ScreenBPP < 16) // dont show classic if > 8 bits
                            vidsets[dax++] = 8|((validmode[day].fs&1)<<16);
                    }
                    else
                        vidsets[dax++] = 0x20000|validmode[day].bpp|((validmode[day].fs&1)<<16);
                }
                for (dax = 0; dax < (long)(sizeof(vidsets)/sizeof(vidsets[1])) && vidsets[dax] != -1; dax++)
                    if (vidsets[dax] == (((getrendermode()>=2)<<17)|(fullscreen<<16)|bpp)) break;
                if (dax < (long)(sizeof(vidsets)/sizeof(vidsets[1]))) newvidset = dax;
                curvidset = newvidset;

                cmenu(203);
            }
            break;

        case 3:
            currentlist = 0;
        case 4:
        case 5:
            if (x==5 && !CONTROL_JoyPresent) break;
            cmenu(204+x-3);
            break;

        case 6:
#ifndef AUSTRALIA
            cmenu(10000);
#endif
            break;
        case 7:
            cmenu(1235);
            break;
        }

        menutext(160,c-18-18-18,0,0,"GAME OPTIONS");
        menutext(160,c-18-18,   0,0,"SOUND OPTIONS");
        menutext(160,c-18,      0,0,"VIDEO OPTIONS");
        menutext(160,c,         0,0,"KEYS SETUP");               // wxky
        menutext(160,c+18,      0,0,"MOUSE SETUP");
        menutext(160,c+18+18,   0,CONTROL_JoyPresent==0,"JOYSTICK SETUP");
        if (!NAMGAME)
        {
#ifndef AUSTRALIA
        menutext(160,c+18+18+18,0,0,"PARENTAL LOCK");
#else
        menutext(160,c+18+18+18,0,1,"PARENTAL LOCK");
#endif
        }
        if (!NAMGAME)
            menutext(160,c+18+18+18+18,0,0,"SELECT MUSIC");              // wxog

        gametextsm(160,1,HEAD2W,13,2+8+16);                          // wxvr
        break;

//--------------------------------------------------------------------------

        // JBF 20031206: Video settings menu
    case 203:
        rotatesprite(320<<15,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
        menutext(320>>1,24,0,0,"VIDEO OPTIONS");

        c = (320>>1)-130;

#if defined(POLYMOST) && defined(USE_OPENGL)
        x = 10;
#else
        x = 9;
#endif

        onbar = (probey == 5 || probey == 6 || probey == 7 || probey == 8);
        if (probey == 0 || probey == 1 || probey == 2 || probey == 3)
            x = probemd(c+26,50-7,12,x);
        else
        if (probey == 4)
            x = probemd(c+36,50-7+12+12+12+12+2,0,x);
        else
            x = probemd(c+26,54-7,12,x);

        if (probey==0 && (KB_KeyPressed(sc_LeftArrow) || KB_KeyPressed(sc_RightArrow)))
        {
            sound(PISTOL_BODYHIT);
            x=0;
        }
        switch (x)
        {
        case -1:
            cmenu(202);
            probey = 2;
            break;

        case 0:
            newfullscreen = !newfullscreen;
            {
                int lastvidset, lastvidmode, safevidmode = -1, safevidset = -1;
                lastvidset = newvidset;
                lastvidmode = newvidmode;
                // find the next vidset compatible with the current fullscreen setting
                while (vidsets[0] != -1)
                {
                    newvidset++;
                    if (newvidset == lastvidset) break;
                    if (newvidset == sizeof(vidsets)/sizeof(vidsets[0]) || vidsets[newvidset] == -1) { newvidset = -1; continue; }
                    if (((vidsets[newvidset]>>16)&1) != newfullscreen) continue;
                    if ((vidsets[newvidset] & 0x2ffff) != (vidsets[lastvidset] & 0x2ffff)) {
                        if ((vidsets[newvidset] & 0x20000) == (vidsets[lastvidset] & 0x20000)) safevidset = newvidset;
                        continue;
                    }
                    break;
                }
                if (newvidset == lastvidset)
                {
                    if (safevidset == -1)
                    {
                        newfullscreen = !newfullscreen;
                        break;
                    }
                    else
                    {
                        newvidset = safevidset;
                    }
                }

                // adjust the video mode to something legal for the new vidset
                do
                {
                    newvidmode++;
                    if (newvidmode == lastvidmode) break;   // end of cycle
                    if (newvidmode >= validmodecnt) newvidmode = 0;
                    if (validmode[newvidmode].bpp == (vidsets[newvidset]&0x0ffff) &&
                        validmode[newvidmode].fs == newfullscreen &&
                        validmode[newvidmode].xdim <= validmode[lastvidmode].xdim &&
                           (safevidmode==-1?1:(validmode[newvidmode].xdim>=validmode[safevidmode].xdim)) &&
                        validmode[newvidmode].ydim <= validmode[lastvidmode].ydim &&
                           (safevidmode==-1?1:(validmode[newvidmode].ydim>=validmode[safevidmode].ydim))
                        )
                        safevidmode = newvidmode;
                }
                while (1);
                if (safevidmode == -1)
                {
                    //OSD_Printf("No best fit!\n");
                    newvidmode = lastvidmode;
                    newvidset = lastvidset;
                    newfullscreen = !newfullscreen;
                }
                else
                {
                    //OSD_Printf("Best fit is %dx%dx%d-%d %d\n",validmode[safevidmode].xdim,validmode[safevidmode].ydim,validmode[safevidmode].bpp,validmode[safevidmode].fs,safevidmode);
                    newvidmode = safevidmode;
                }
                if (newvidset != curvidset) changesmade |= 4; else changesmade &= ~4;
                if (newvidmode != curvidmode) changesmade |= 1; else changesmade &= ~1;
            }
            if (newfullscreen == fullscreen) changesmade &= ~2; else changesmade |= 2;
            break;

        case 1:
            glwidescreen = !glwidescreen;
            onbar = 0;
            break;

        case 2:
            do
            {
                if (KB_KeyPressed(sc_LeftArrow))
                {
                    newvidmode--;
                    if (newvidmode < 0) newvidmode = validmodecnt-1;
                } else {
                    newvidmode++;
                    if (newvidmode >= validmodecnt) newvidmode = 0;
                }
            } while ((validmode[newvidmode].fs&1) != ((vidsets[newvidset]>>16)&1) || validmode[newvidmode].bpp != (vidsets[newvidset] & 0x0ffff));
            //OSD_Printf("New mode is %dx%dx%d-%d %d\n",validmode[newvidmode].xdim,validmode[newvidmode].ydim,validmode[newvidmode].bpp,validmode[newvidmode].fs,newvidmode);
            if ((curvidmode == 0x7fffffffl && newvidmode == validmodecnt) || curvidmode == newvidmode)
                changesmade &= ~1;
            else
                changesmade |= 1;
            KB_ClearKeyDown(sc_LeftArrow);
            KB_ClearKeyDown(sc_RightArrow);
            break;

        case 3:
            {
                int lastvidset, lastvidmode, safevidmode = -1;
                lastvidset = newvidset;
                lastvidmode = newvidmode;
                // find the next vidset compatible with the current fullscreen setting
                while (vidsets[0] != -1) {
                    newvidset++;
                    if (newvidset == sizeof(vidsets)/sizeof(vidsets[0]) || vidsets[newvidset] == -1) { newvidset = -1; continue; }
                    if (((vidsets[newvidset]>>16)&1) != newfullscreen) continue;
                    break;
                }

                if ((vidsets[newvidset] & 0x0ffff) != (vidsets[lastvidset] & 0x0ffff)) {
                    // adjust the video mode to something legal for the new vidset
                    do {
                        newvidmode++;
                        if (newvidmode == lastvidmode) break;   // end of cycle
                        if (newvidmode >= validmodecnt) newvidmode = 0;
                        if (validmode[newvidmode].bpp == (vidsets[newvidset]&0x0ffff) &&
                            validmode[newvidmode].fs == newfullscreen &&
                            validmode[newvidmode].xdim <= validmode[lastvidmode].xdim &&
                               (safevidmode==-1?1:(validmode[newvidmode].xdim>=validmode[safevidmode].xdim)) &&
                            validmode[newvidmode].ydim <= validmode[lastvidmode].ydim &&
                               (safevidmode==-1?1:(validmode[newvidmode].ydim>=validmode[safevidmode].ydim))
                            )
                            safevidmode = newvidmode;
                    } while (1);
                    if (safevidmode == -1) {
                        //OSD_Printf("No best fit!\n");
                        newvidmode = lastvidmode;
                        newvidset = lastvidset;
                    } else {
                        //OSD_Printf("Best fit is %dx%dx%d-%d %d\n",validmode[safevidmode].xdim,validmode[safevidmode].ydim,validmode[safevidmode].bpp,validmode[safevidmode].fs,safevidmode);
                        newvidmode = safevidmode;
                    }
                }
                if (newvidset != curvidset) changesmade |= 4; else changesmade &= ~4;
                if (newvidmode != curvidmode) changesmade |= 1; else changesmade &= ~1;
            }
            break;

        case 4:
            if (!changesmade || validmode[newvidmode].bpp == 8)
            {
                changesmade = 0;
                break;
            }
            //if (!changesmade) break;
            {
                long pxdim, pydim, pfs, pbpp, prend;
                long nxdim, nydim, nfs, nbpp, nrend;

                pxdim = xdim; pydim = ydim; pbpp = bpp; pfs = fullscreen; prend = getrendermode();
                nxdim = (newvidmode==validmodecnt)?xdim:validmode[newvidmode].xdim;
                nydim = (newvidmode==validmodecnt)?ydim:validmode[newvidmode].ydim;
                nfs   = newfullscreen;
                nbpp  = (newvidmode==validmodecnt)?bpp:validmode[newvidmode].bpp;
                nrend = (vidsets[newvidset] & 0x20000) ? (nbpp==8?2:3) : 0;

                if (setgamemode(nfs, nxdim, nydim, nbpp) < 0)
                {
                    if (setgamemode(pfs, pxdim, pydim, pbpp) < 0)
                    {
                        setrendermode(prend);
                        gameexit("Failed restoring old video mode.");
                    }
                    else
                        onvideomodechange(pbpp > 8);
                }
                else
                    onvideomodechange(nbpp > 8);

                vscrn();
                setrendermode(nrend);

                curvidmode = newvidmode; curvidset = newvidset;
                changesmade = 0;

                ScreenMode = fullscreen;
                ScreenWidth = xdim;
                ScreenHeight = ydim;
                ScreenBPP = bpp;
            }
            break;

        case 5:
            break;

        case 6:                                                      // wxvo
            break;

        case 7:                                                      // wxvo
            break;

        case 8:                                                      // wxfv
            break;

#if defined(POLYMOST) && defined(USE_OPENGL)
        case 9:                                                      // wxnm
            if (bpp==8)
                break;
            cmenu(230);
            break;
#endif
        }

        menutextc(c+35,50,0,0,"FULLSCREEN");
        gametext(c+145,50-12,newfullscreen?"ON":"OFF",0,2+8+16);

        menutextc(c+35,50+12,0,0,"WIDESCREEN");                         // glwidescreen
        gametext(c+145,50,glwidescreen?"ON":"OFF",0,2+8+16);

        menutextc(c+35,50+12+12,0,0,"RESOLUTION");
        sprintf(tempbuf,"%ld x %ld",
               (newvidmode==validmodecnt)?xdim:validmode[newvidmode].xdim,
               (newvidmode==validmodecnt)?ydim:validmode[newvidmode].ydim);
        gametext(c+145,50+12,tempbuf,0,2+8+16);

        menutextc(c+35,50+12+12+12,0,0,"VIDEO MODE");
        sprintf(tempbuf, "%dbit %s", vidsets[newvidset]&0x0ffff, (vidsets[newvidset]&0x20000)?"Polymost":"Classic");
        //sprintf(tempbuf,(vidsets[newvidset]&0x20000)?"%dbit Polymost":"Classic", vidsets[newvidset]&0x0ffff);
        gametext(c+145,50+12+12,tempbuf,0,2+8+16);

        menutextc(c+45,50+12+12+12+12+2,0,changesmade==0,"APPLY CHANGES");

        menutextc(c+35,54+12+12+12+12+12,SHX(-6),PHX(-6),"BRIGHTNESS");
        {
            short ss = ud.brightness;
            barmd(c+153,49+12+12+12+12+12,&ss,4,x==5,SHX(-6),PHX(-6));         // wxga
            if (x==5)
            {
                ud.brightness = ss;
                setbrightness(ud.brightness>>2,&ps[myconnectindex].palette[0],0);
            }
        }

        menutextc(c+35,54+12+12+12+12+12+12,SHX(-6),PHX(-6),"SCREEN SIZE");    // wxhd
        {
            short ss = ud.screen_size;
            barmd(c+153,49+12+12+12+12+12+12,&ss,-4,x==6,SHX(-6),PHX(-6));
            if (x == 6)
            {
                ud.screen_size = ss;
                sbak = ud.screen_size;
            }
        }

        menutextc(c+35,54+12+12+12+12+12+12+12,SHX(-6),PHX(-6),"STATUS SIZE"); // wxvo
        {
            short sbs, sbsl;

            sbs = sbsl = scale(max(0,ud.statusbarscale-50),63,100-50);
            barmd(c+153,49+12+12+12+12+12+12+12, (short *)&sbs,9,x==7,SHX(-6),PHX(-6));
            if (x == 7 && sbs != sbsl)
            {
                sbs = scale(sbs,100-50,63)+50;
                setstatusbarscale(sbs);
            }
        }

        menutextc(c+35,54+12+12+12+12+12+12+12+12,SHX(-6),PHX(-6),"FIELD OF VIEW");  // wxfv
        {
            short ss = glfovscreen;

            barmd(c+153,49+12+12+12+12+12+12+12+12,&ss,8,x==8,SHX(-6),PHX(-6));
            if (x == 8)
            {
                glfovscreen = ss;
            }
        }

#if defined(POLYMOST) && defined(USE_OPENGL)
        menutextc(c+35,54+12+12+12+12+12+12+12+12+12,12,bpp==8,"MORE OPTIONS");    // wxnm
#endif
        break;

//---------------------------------------------------------------------------------------

        case 230:                                                              // wxnm
#if defined(POLYMOST) && defined(USE_OPENGL)
            rotatesprite(320<<15,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(320>>1,24,0,0,"VIDEO OPTIONS");

            c = (320>>1)-100;
            onbar = ( probey == 2 || probey == 3 );

            x = probemd(c-10,50-7,12,11);
            switch(x)
            {
                case -1:
                case 10:
                    cmenu(203);
                    probey = 9;
                    break;
                case 0:
                    if (bpp==8)
                        break;
                    switch (gltexfiltermode)
                    {
                    case 0:
                        gltexfiltermode = 3;
                        break;
                    case 3:
                        gltexfiltermode = 5;
                        break;
                    case 5:
                        gltexfiltermode = 0;
                        break;
                    default:
                        gltexfiltermode = 3;
                        break;
                    }
                    gltexapplyprops();
                    onbar = 0;
                    break;
                case 1:
                    vsync = !vsync;
                    onbar = 0;
                    #if defined(USE_OPENGL) && defined(POLYMOST)
                    SetVSync(vsync);
                    #endif
                    break;
                case 2:
                    glanisotropy *= 2;
                    if (glanisotropy > glinfo.maxanisotropy)
                        glanisotropy = 1;
                    onbar = 0;
                    break;
                case 3:
                    useprecache = !useprecache;
                    onbar = 0;
                    break;
                case 4:
                    glusetexcompr = !glusetexcompr;
                    onbar = 0;
                    break;
                case 5:
                    glusetexcache = !glusetexcache;
                    onbar = 0;
                    break;
                case 6:
                    glusetexcachecompression = !glusetexcachecompression;
                    onbar = 0;
                    break;
                case 7:
                    usehightile = !usehightile;
                    onbar = 0;
                    break;
                case 8:
                    usemodels = !usemodels;
                    onbar = 0;
                    break;
                case 9:
                    if (ud.screen_size == 4)
                        ud.weaponicons = 1-ud.weaponicons;                   // wxwo
                    break;
                default:
                    onbar = 0;
                    break;
            }

            menutextc(c,50,0,bpp==8,"FILTERING");
            switch (gltexfiltermode)
            {
            case 0:
                strcpy(tempbuf,"NEAREST");
                break;
            case 3:
                strcpy(tempbuf,"BILINEAR");
                break;
            case 5:
                strcpy(tempbuf,"TRILINEAR");
                break;
            default:
                strcpy(tempbuf,"OTHER");
                break;
            }
            gametext(c+165,50-12,tempbuf,0,2+8+16);

            menutextc(c,50+12,0,0,"VERTICAL SYNC");                               // vsync
            gametext(c+165,50,vsync?"ENABLED":"DISABLED",0,2+8+16);

            menutextc(c,50+12+12,0,0,"ANISOTROPY");
            if (glanisotropy == 1)
                strcpy(tempbuf,"NONE");
            else
                sprintf(tempbuf,"%ld X",glanisotropy);
            gametext(c+165,50+12,tempbuf,0,2+8+16);

            menutextc(c,50+12+12+12,0,0,"PRECACHE TEXTURES");                  // useprecache
            gametext(c+165,50+12+12,useprecache?"ON":"OFF",0,2+8+16);

            menutextc(c,50+12+12+12+12,0,0,"TEXTURE COMPRESSION");             // glusetexcompr  //wx11
            gametext(c+165,50+12+12+12,glusetexcompr?"ON":"OFF",0,2+8+16);

            menutextc(c,50+12+12+12+12+12,0,0,"TEXTURE CACHING");              // glusetexcache
            gametext(c+165,50+12+12+12+12,glusetexcache?"ON":"OFF",0,2+8+16);

            menutextc(c,50+12+12+12+12+12+12,0,0,"CACHE COMPRESSION");         // glusetexcachecompression
            gametext(c+165,50+12+12+12+12+12,glusetexcachecompression?"ON":"OFF",0,2+8+16);

            menutextc(c,50+12+12+12+12+12+12+12,0,0,"HIGH RES TILES");         // usehightile
            gametext(c+165,50+12+12+12+12+12+12,usehightile?"ON":"OFF",0,2+8+16);

            menutextc(c,50+12+12+12+12+12+12+12+12,0,0,"HIGH RES MODELS");     // usemodels
            gametext(c+165,50+12+12+12+12+12+12+12,usemodels?"ON":"OFF",0,2+8+16);

            menutextc(c,50+12+12+12+12+12+12+12+12+12,0,ud.screen_size!=4,"HUD WEAPON ICONS");  // wxwi
            gametext(c+165,50+12+12+12+12+12+12+12+12, ud.weaponicons ? "ON" : "OFF", 0, 2+8+16);

            menutextc(c,50+12+12+12+12+12+12+12+12+12+12,12,0,"PREVIOUS OPTIONS");
#endif
            break;

/*
Texture Compression: (glusetexcompr)
OpenGL texture compression

Texture Caching      (glusetexcache)
OpenGL compressed texture cache

Disk Cache Compression: (glusetexcachecompression)
Compression of files in the OpenGL compressed texture cache

*/

//-----------------------------------------------------------------------------

    case 204:
            rotatesprite(320<<15,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(320>>1,24,0,0,"KEYBOARD SETUP");

        c = (320>>1)-120;

        onbar = 0;
        x = probe(0,0,0,NUMGAMEFUNCTIONS);

        if (x == -1)
        {
            cmenu(202);
            probey = 3;
        }
        else
        if (x >= 0)
        {
            function = probey;
            whichkey = currentlist;
            cmenu(210);
            KB_FlushKeyboardQueue();
            KB_ClearLastScanCode();
            break;
        }

        // the top of our list
        m = probey - 6;
        if (m < 0) m = 0;
        else if (m + 13 >= NUMGAMEFUNCTIONS) m = NUMGAMEFUNCTIONS-13;

        if (probey == gamefunc_Show_Console)
            currentlist = 0;
        else
        if (KB_KeyPressed( sc_LeftArrow ) || KB_KeyPressed( sc_kpad_4 ) ||
            KB_KeyPressed( sc_RightArrow ) || KB_KeyPressed( sc_kpad_6 ) ||
            KB_KeyPressed( sc_Tab )) {
            currentlist ^= 1;
            KB_ClearKeyDown( sc_LeftArrow );
            KB_ClearKeyDown( sc_RightArrow );
            KB_ClearKeyDown( sc_kpad_4 );
            KB_ClearKeyDown( sc_kpad_6 );
            KB_ClearKeyDown( sc_Tab );
            sound(KICK_HIT);
        }
        else
        if (KB_KeyPressed( sc_Delete ))
        {
            KeyboardKeys[probey][currentlist] = 0;
            CONTROL_MapKey( probey, KeyboardKeys[probey][0], KeyboardKeys[probey][1] );
            sound(KICK_HIT);
            KB_ClearKeyDown( sc_Delete );
        }

        for (l=0; l < min(13,NUMGAMEFUNCTIONS); l++)
        {
            p = CONFIG_FunctionNumToName(m+l);
            if (!p) continue;

            strcpy(tempbuf, p);
            for (i=0;tempbuf[i];i++)
                 if (tempbuf[i]=='_')
                     tempbuf[i] = ' ';                                        // wxky
            minitextshade(70,39+l*8,tempbuf,(m+l == probey)?0:16,0,10+16);    // actions

            //strcpy(tempbuf, KB_ScanCodeToString(KeyboardKeys[m+l][0]));
            strcpy(tempbuf, getkeyname(KeyboardKeys[m+l][0]));
            if (!tempbuf[0])
                strcpy(tempbuf, "  -");
            minitextshade(70+100,39+l*8,tempbuf,                              // main
                    (m+l == probey && !currentlist?0:16),18,10+16);

            //strcpy(tempbuf, KB_ScanCodeToString(KeyboardKeys[m+l][1]));
            strcpy(tempbuf, getkeyname(KeyboardKeys[m+l][1]));
            if (!tempbuf[0])
                strcpy(tempbuf, "  -");
            minitextshade(70+120+34,39+l*8,tempbuf,                           // alt
                    (m+l == probey && currentlist?0:16),23,10+16);
        }

        gametext(160,149,"UP/DOWN = SELECT ACTION",24,2+8+16);
        gametext(160,149+9,"LEFT/RIGHT = SELECT LIST",24,2+8+16);
        gametext(160,149+9+9,"ENTER = MODIFY   DELETE = CLEAR",24,2+8+16);

        break;

    case 210:
    {
        int32 sc;

        rotatesprite(320<<15,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
        menutext(320>>1,24,0,0,"KEYBOARD SETUP");

        gametext(320>>1,99,"PRESS THE KEY TO ASSIGN AS",3,2+8+16);
        sprintf(tempbuf,"%s FOR \"%s\"", whichkey?"SECONDARY":"PRIMARY", CONFIG_FunctionNumToName(function));
        gametext(320>>1,99+9,tempbuf,3,2+8+16);
        gametext(320>>1,99+9+9+9,"PRESS \"ESCAPE\" TO CANCEL",3,2+8+16);

        sc = KB_GetLastScanCode();
        if ( sc != sc_None ) {
            if ( sc == sc_Escape ) {
                sound(EXITMENUSOUND);
            } else {
                sound(PISTOL_BODYHIT);

                KeyboardKeys[function][whichkey] = KB_GetLastScanCode();
                if (function == gamefunc_Show_Console)
                    OSD_CaptureKey(KB_GetLastScanCode());
                else
                    CONTROL_MapKey( function, KeyboardKeys[function][0], KeyboardKeys[function][1] );
            }

            cmenu(204);

            currentlist = whichkey;
            probey = function;

            KB_ClearKeyDown(sc);
        }

        break;
    }

//---------------------------------------------------------------------------------

    case 205:
    {
         int io;                            // wx
         rotatesprite(320<<15,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
         menutext(320>>1,24,0,0,"MOUSE SETUP");

        c = 60-4;

        onbar = (probey == (MAXMOUSEBUTTONS-2)*2+2);
        if (probey < (MAXMOUSEBUTTONS-2)*2+2)
            x = probesm(c+12,43,8,(MAXMOUSEBUTTONS-2)*2+2+2+2);
        else
            x = probemd(c+6,127-((MAXMOUSEBUTTONS-2)*2+2)*12,12,(MAXMOUSEBUTTONS-2)*2+2+2+2);

        if (x == -1)
        {
            cmenu(202);
            probey = 4;
            break;
        }
        else
        if (x == (MAXMOUSEBUTTONS-2)*2+2)
        {
            if (!ud.mouseaiming)
                myaimmode = 1-myaimmode;
            break;
        }
        else
        if (x == (MAXMOUSEBUTTONS-2)*2+2+1)
        {
            if (numplayers < 2)
                ud.mouseaiming = !ud.mouseaiming;
            break;
        }
        else
        if (x == (MAXMOUSEBUTTONS-2)*2+2+2)
        {
            ud.mouseflip = 1-ud.mouseflip;
            break;
        }
        if (x == (MAXMOUSEBUTTONS-2)*2+2+2+1)
        {
            //advanced
            cmenu(212);
            break;
        }
        else
        if (x >= 0)
        {
            //set an option
            cmenu(211);
            function = 0;
            whichkey = x;
            if (x < (MAXMOUSEBUTTONS-2)*2)
                probey = MouseFunctions[x>>1][x&1];
            else
                probey = MouseFunctions[x-4][0];
            if (probey < 0)
                probey = NUMGAMEFUNCTIONS-1;
            break;
        }

        for (l=0; l < (MAXMOUSEBUTTONS-2)*2+2; l++)
        {
            tempbuf[0] = 0;
            if (l < (MAXMOUSEBUTTONS-2)*2)
            {
                if (l&1)
                {
                    Bstrcpy(tempbuf, "Double ");
                    m = MouseFunctions[l>>1][1];
                }
                else
                    m = MouseFunctions[l>>1][0];
                Bstrcat(tempbuf, mousebuttonnames[l>>1]);
            }
            else
            {
                Bstrcpy(tempbuf, mousebuttonnames[l-(MAXMOUSEBUTTONS-2)]);
                m = MouseFunctions[l-(MAXMOUSEBUTTONS-2)][0];
            }
            minitextshade(c+20,39+l*8,tempbuf,(l==probey)?0:16,24,10+16);            // wxky

            if (m == -1)
                minitextshade(c+100+40,39+l*8,"  -NONE-",(l==probey)?0:16,23,10+16); // wxky
            else
            {
                strcpy(tempbuf, CONFIG_FunctionNumToName(m));
                for (i=0;tempbuf[i];i++)
                     if (tempbuf[i]=='_')
                         tempbuf[i] = ' ';
                minitextshade(c+100+40,39+l*8,tempbuf,(l==probey)?0:16,18,10+16);    // wxky
            }
        }

        menutextc(c+20,134,0,0,"Mouse Aiming");
        menutextc(c+20,134+12,0,0,"Mouse Aiming Type");
        menutextc(c+20,134+12+12,0,0,"Mouse Invert Aim");
        menutextc(c+20,134+12+12+12,0,0,"Advanced...");

        gametext(c+170,134-12,myaimmode?"ON":"OFF",0,2+8+16);
        gametext(c+170,134,ud.mouseaiming?"HELD":"TOGGLE",0,2+8+16);
        gametext(c+170,134+12,ud.mouseflip?"ON":"OFF",0,2+8+16);

        if (probey < (MAXMOUSEBUTTONS-2)*2+2)
        {
            gametext(160,175,"UP/DOWN = SELECT BUTTON",24,2+8+16);
            gametext(160,175+10,"ENTER = MODIFY",24,2+8+16);
        }
        break;
    }

//---------------------------------------------------------------------------------

    case 211:
         rotatesprite(320<<15,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            if (function == 0)
                menutext(320>>1,24,0,0,"MOUSE SETUP");
            else
            if (function == 1)
                menutext(320>>1,24,0,0,"ADVANCED MOUSE");
            else
            if (function == 2)
                menutext(320>>1,24,0,0,"JOYSTICK BUTTONS");
            else
            if (function == 3)
                menutext(320>>1,24,0,0,"JOYSTICK AXES");

        x = probe(0,0,0,NUMGAMEFUNCTIONS);

        if (x == -1)
        {
            if (function == 0)
            {   // mouse button
                cmenu(205);
                probey = whichkey;
            }
            else
            if (function == 1)
            {   // mouse digital axis
                cmenu(212);
                probey = 3+(whichkey^2);
            }
            else
            if (function == 2)
            {   // joystick button/hat
                cmenu(207);
                probey = whichkey;
            }
            else
            if (function == 3)
            {   // joystick digital axis
                cmenu((whichkey>>2)+208);
                probey = 1+((whichkey>>1)&1)*4+(whichkey&1);
            }
            break;
        }
        else
        if (x >= 0)
        {
            if (x == NUMGAMEFUNCTIONS-1)
                x = -1;

            if (function == 0)
            {
                if (whichkey < (MAXMOUSEBUTTONS-2)*2)
                {
                    MouseFunctions[whichkey>>1][whichkey&1] = x;
                    CONTROL_MapButton( x, whichkey>>1, whichkey&1, controldevice_mouse);
                }
                else
                {
                    MouseFunctions[whichkey-(MAXMOUSEBUTTONS-2)][0] = x;
                    CONTROL_MapButton( x, whichkey-(MAXMOUSEBUTTONS-2), 0, controldevice_mouse);
                }
                cmenu(205);
                probey = whichkey;
            }
            else
            if (function == 1)
            {
                MouseDigitalFunctions[whichkey>>1][whichkey&1] = x;
                CONTROL_MapDigitalAxis(whichkey>>1, x, whichkey&1, controldevice_mouse);
                cmenu(212);
                probey = 3+(whichkey^2);
            }
            else
            if (function == 2)
            {
                if (whichkey < 2*joynumbuttons)
                {
                    JoystickFunctions[whichkey>>1][whichkey&1] = x;
                    CONTROL_MapButton( x, whichkey>>1, whichkey&1, controldevice_joystick);
                }
                else
                {
                    JoystickFunctions[joynumbuttons + (whichkey-2*joynumbuttons)][0] = x;
                    CONTROL_MapButton( x, joynumbuttons + (whichkey-2*joynumbuttons), 0, controldevice_joystick);
                }
                cmenu(207);
                probey = whichkey;
            }
            else
            if (function == 3)
            {
                JoystickDigitalFunctions[whichkey>>1][whichkey&1] = x;
                CONTROL_MapDigitalAxis(whichkey>>1, x, whichkey&1, controldevice_joystick);
                cmenu((whichkey>>2)+208);
                probey = 1+((whichkey>>1)&1)*4+(whichkey&1);
            }
            break;
        }

        gametext(320>>1,34,"SELECT A FUNCTION TO ASSIGN",0,2+8+16);

        if (function == 0)
        {
            if (whichkey < (MAXMOUSEBUTTONS-2)*2)
                sprintf(tempbuf,"TO %s%s", (whichkey&1)?"DOUBLE-CLICKED ":"", mousebuttonnames[whichkey>>1]);
            else
                Bstrcpy(tempbuf, mousebuttonnames[whichkey-(MAXMOUSEBUTTONS-2)]);
        }
        else
        if (function == 1)
        {
            Bstrcpy(tempbuf,"TO DIGITAL ");
            switch (whichkey)
            {
                case 0: Bstrcat(tempbuf, "LEFT"); break;
                case 1: Bstrcat(tempbuf, "RIGHT"); break;
                case 2: Bstrcat(tempbuf, "UP"); break;
                case 3: Bstrcat(tempbuf, "DOWN"); break;
            }
        }
        else
        if (function == 2)
        {
            static char *directions[] = { "UP", "RIGHT", "DOWN", "LEFT" };
            if (whichkey < 2*joynumbuttons)
                Bsprintf(tempbuf,"TO %s%s", (whichkey&1)?"DOUBLE-CLICKED ":"", getjoyname(1,whichkey>>1));
            else
                Bsprintf(tempbuf,"TO HAT %s", directions[whichkey-2*joynumbuttons]);
        }
        else
        if (function == 3)
        {
            Bsprintf(tempbuf,"TO DIGITAL %s %s",getjoyname(0,whichkey>>1),(whichkey&1)?"POSITIVE":"NEGATIVE");
        }

        gametext(320>>1,34+9,tempbuf,0,2+8+16);

        if (KB_KeyPressed( sc_End )) { KB_ClearKeyDown(sc_End); probey = NUMGAMEFUNCTIONS-1; sound(KICK_HIT); }
        else
        if (KB_KeyPressed( sc_Home )) { KB_ClearKeyDown(sc_Home); probey = 0; sound(KICK_HIT); }

        m = probey - 6;
        if (m < 0)
            m = 0;
        else
        if (m + 13 >= NUMGAMEFUNCTIONS)
            m = NUMGAMEFUNCTIONS-13;

        for (l=0; l < min(13,NUMGAMEFUNCTIONS); l++)
        {
            if (l+m == NUMGAMEFUNCTIONS-1)
                strcpy(tempbuf, "  -NONE-");
            else
                strcpy(tempbuf, CONFIG_FunctionNumToName(m+l));

            for (i=0;tempbuf[i];i++) if (tempbuf[i]=='_') tempbuf[i] = ' ';
            minitextshade(100,55+l*8,tempbuf,(m+l == probey)?0:16,24,10+16);   // wxky
        }

        gametext(320>>1,163,"PRESS \"ESCAPE\" TO CANCEL",24,2+8+16);

        break;

//---------------------------------------------------------------------------------

    case 212:
         rotatesprite(320<<15,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
         menutext(320>>1,24,0,0,"ADVANCED MOUSE");

        c = (320>>1)-115;

        onbar = (probey == 0 || probey == 1 || probey == 2);
        if (probey < 3)
            x = probemd(c,33+9,12,7);
        else
        if (probey < 7)
        {
            m=50;
            x = probemd(c,104+9 -(12+12+12),12,7);
        }
        else
        {
            x = probemd(c,160-(12+12+12+12+12+12+12),12,7);
        }

        switch (x)
        {
            case -1:
                cmenu(205);
                probey = (MAXMOUSEBUTTONS-2)*2+2+2+1;
                break;

            case 0:
                // sensitivity
            case 1:
                // x-axis scale
            case 2:
                // y-axis scale
                break;

            case 3:
                // digital up
            case 4:
                // digital down
            case 5:
                // digital left
            case 6:
                // digital right
                function = 1;
                whichkey = (x-3)^2; // flip the actual axis number
                cmenu(211);
                probey = MouseDigitalFunctions[whichkey>>1][whichkey&1];
                if (probey < 0)
                    probey = NUMGAMEFUNCTIONS-1;
                break;
            case 7:
                // analogue x
            case 8:
                // analogue y
                l = MouseAnalogueAxes[x-6];
                if (l == analog_turning)
                    l = analog_strafing;
                else
                if (l == analog_strafing)
                    l = analog_lookingupanddown;
                else
                if (l == analog_lookingupanddown)
                    l = analog_moving;
                else
                if (l == analog_moving)
                    l = -1;
                else
                    l = analog_turning;
                MouseAnalogueAxes[x-7] = l;
                CONTROL_MapAnalogAxis(x-7,l,controldevice_mouse);
                {
                    extern int32 mouseyaxismode;    // player.c
                    mouseyaxismode = -1;
                }
                break;
        }

        l = CONTROL_GetMouseSensitivity()>>10;
        menutextc(c+10,49,0,0,"SENSITIVITY");
        barmd(c+160+30,49-5,&l,4,x == 0,0,0);
        CONTROL_SetMouseSensitivity( l<<10 );
        l = CONTROL_GetMouseSensitivity();
        Bsprintf(tempbuf,"%s%.2f",l>=0?" ":"",(float)l/64512.0*2);
        gametext(c+136,49-12,tempbuf,0,2+8+16);

        menutextc(c+10,49+12,0,0,"X-AXIS SCALE");
        l = (MouseAnalogueScale[0]+262144) >> 13;
        barmd(c+160+30,49+7,(short *)&l,1,x == 1,0,0);
        l = (l<<13)-262144;
        if (l != MouseAnalogueScale[0])
        {
            CONTROL_SetAnalogAxisScale( 0, l, controldevice_mouse );
            MouseAnalogueScale[0] = l;
        }
        Bsprintf(tempbuf,"%s%.2f",l>=0?" ":"",(float)l/65536.0);
        gametext(c+136,49,tempbuf,0,2+8+16);

        menutextc(c+10,49+12+12,0,0,"Y-AXIS SCALE");
        l = (MouseAnalogueScale[1]+262144) >> 13;
        barmd(c+160+30,49+12+7,(short *)&l,1,x == 2,0,0);
        l = (l<<13)-262144;
        if (l != MouseAnalogueScale[1])
        {
            CONTROL_SetAnalogAxisScale( 1, l, controldevice_mouse );
            MouseAnalogueScale[1] = l;
        }
        Bsprintf(tempbuf,"%s%.2f",l>=0?" ":"",(float)l/65536.0);
        gametext(c+136,49+12,tempbuf,0,2+8+16);

        menutext(c+10,49+12+12+12+8,0,-1,"DIGITAL AXES ACTIONS");

        menutextc(c+10,121,0,0,"UP:");
        if (MouseDigitalFunctions[1][0] < 0)
            strcpy(tempbuf, "  -NONE-");
        else
            strcpy(tempbuf, CONFIG_FunctionNumToName(MouseDigitalFunctions[1][0]));
        for (i=0; tempbuf[i]; i++)
             if (tempbuf[i]=='_')
                 tempbuf[i] = ' ';
        gametext(c+60,111,tempbuf,0,2+8+16);

        menutextc(c+10,121+12,0,0,"DOWN:");
        if (MouseDigitalFunctions[1][1] < 0)
            strcpy(tempbuf, "  -NONE-");
        else
            strcpy(tempbuf, CONFIG_FunctionNumToName(MouseDigitalFunctions[1][1]));
        for (i=0; tempbuf[i]; i++)
             if (tempbuf[i]=='_')
                 tempbuf[i] = ' ';
        gametext(c+60,111+12,tempbuf,0,2+8+16);

        menutextc(c+10,121+12+12,0,0,"LEFT:");
        if (MouseDigitalFunctions[0][0] < 0)
            strcpy(tempbuf, "  -NONE-");
        else
            strcpy(tempbuf, CONFIG_FunctionNumToName(MouseDigitalFunctions[0][0]));
        for (i=0; tempbuf[i]; i++)
             if (tempbuf[i]=='_')
                 tempbuf[i] = ' ';
        gametext(c+60,111+12+12,tempbuf,0,2+8+16);

        menutextc(c+10,121+12+12+12,0,0,"RIGHT:");
        if (MouseDigitalFunctions[0][1] < 0)
            strcpy(tempbuf, "  -NONE-");
        else
            strcpy(tempbuf, CONFIG_FunctionNumToName(MouseDigitalFunctions[0][1]));
        for (i=0; tempbuf[i]; i++)
             if (tempbuf[i]=='_')
                 tempbuf[i] = ' ';
        gametext(c+60,111+12+12+12,tempbuf,0,2+8+16);

/* JBF 20040107: It would appear giving these options confuses some tinkerers, so they've
 * been moved to the bottom, and hidden in case I dare to reenable them again.
        menutext(c,116+16+8,0,0,"ANALOG X");
        if (CONFIG_AnalogNumToName( MouseAnalogueAxes[0] )) {
            p = CONFIG_AnalogNumToName( MouseAnalogueAxes[0] );
            if (p) {
                gametext(c+148+4,118+16, strchr(p,'_')+1, 0, 2+8+16 );
            }
        }
        if (probey == 6) gametext(160,158,"Default is \"turning\"",8,2+8+16);

        menutext(c,116+16+16+8,0,0,"ANALOG Y");
        if (CONFIG_AnalogNumToName( MouseAnalogueAxes[1] )) {
            p = CONFIG_AnalogNumToName( MouseAnalogueAxes[1] );
            if (p) {
                gametext(c+148+4,118+16+16, strchr(p,'_')+1, 0, 2+8+16 );
            }
        }
        if (probey == 7) gametext(160,158,"Default is \"moving\"",8,2+8+16);
*/
        break;

//-----------------------------------------------------------------------------

    case 206:
         rotatesprite(320<<15,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(320>>1,24,0,0,"JOYSTICK SETUP");

        x = probe(160,100-18-2,18,3);

        switch (x) {
            case -1:
                cmenu(202);
                probey = 5;
                break;
            case 0:
            case 1:
                cmenu(207+x);
                break;
            case 2:
                cmenu(213);
                break;
        }

        menutext(160,100-18,0,0,"EDIT BUTTONS");
        menutext(160,100,0,0,"EDIT AXES");
        menutext(160,100+18,0,0,"DEAD ZONES");

        break;

    case 207:
         rotatesprite(320<<15,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(320>>1,24,0,0,"JOYSTICK BUTTONS");

        c = 2*joynumbuttons + 4*(joynumhats>0);

        x = probe(0,0,0,c);

        if (x == -1)
        {
            cmenu(206);
            probey = 0;
            break;
        }
        else
        if (x >= 0)
        {
            function = 2;
            whichkey = x;
            cmenu(211);
            if (x < 2*joynumbuttons)
            {
                probey = JoystickFunctions[x>>1][x&1];
            }
            else
            {
                probey = JoystickFunctions[joynumbuttons + (x-2*joynumbuttons)][0];
            }
            if (probey < 0)
                probey = NUMGAMEFUNCTIONS-1;
            break;
        }

        // the top of our list
        if (c < 13)
            m = 0;
        else
        {
            m = probey - 6;
            if (m < 0)
                m = 0;
            else
            if (m + 13 >= c)
                m = c-13;
        }

        for (l=0; l<min(13,c); l++)
        {
            if (m+l < 2*joynumbuttons)
            {
                sprintf(tempbuf, "%s%s", ((l+m)&1)?"Double ":"", getjoyname(1,(l+m)>>1));
                x = JoystickFunctions[(l+m)>>1][(l+m)&1];
            }
            else
            {
                static char *directions[] = { "Up", "Right", "Down", "Left" };
                sprintf(tempbuf, "Hat %s", directions[(l+m)-2*joynumbuttons]);
                x = JoystickFunctions[joynumbuttons + ((l+m)-2*joynumbuttons)][0];
            }
            minitextshade(80-4,41+l*8,tempbuf,(m+l == probey)?0:16,0,10+16);

            if (x == -1)
                minitextshade(176,41+l*8,"  -NONE-",(m+l==probey)?0:16,23,10+16);
            else
            {
                strcpy(tempbuf, CONFIG_FunctionNumToName(x));
                for (i=0;tempbuf[i];i++) if (tempbuf[i]=='_') tempbuf[i] = ' ';
                minitextshade(176,41+l*8,tempbuf,(m+l==probey)?0:16,23,10+16);
            }
        }

        gametext(160,158,"UP/DOWN = SELECT BUTTON",24,2+8+16);
        gametext(160,158+9,"ENTER = MODIFY",24,2+8+16);
        break;

    case 208:
    case 209:
    case 217:
    case 218:
    case 219:
    case 220:
    case 221:
    case 222: {
        int thispage, twothispage;
        rotatesprite(320<<15,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
        menutext(320>>1,24,0,0,"JOYSTICK AXES");

        thispage = (current_menu < 217) ? (current_menu-208) : (current_menu-217)+2;
        twothispage = (thispage*2+1 < joynumaxes);

        onbar = 0;
        switch (probey)
        {
            case 0:
            case 4: onbar = 1; x = probesm(73,52+(probey==4)*64,0,1+(4<<twothispage)); break;
            case 1:
            case 2:
            case 5:
            case 6: x = probesm(157+(probey==2||probey==6)*72,52+15+(probey==5||probey==6)*64,0,1+(4<<twothispage)); break;
            case 3:
            case 7: x = probesm(73,52+15+15+(probey==7)*64,0,1+(4<<twothispage)); break;
            default: x = probe(60,88+79*twothispage,0,1+(4<<twothispage)); break;
        }

        switch (x)
        {
            case -1:
                cmenu(206);
                probey = 1;
                break;
            case 8:
                if (joynumaxes > 2)
                {
                    if (thispage == ((joynumaxes+1)/2)-1) cmenu(208);
                    else
                    {
                        if (current_menu == 209)
                            cmenu(217);
                        else
                            cmenu( current_menu+1 );
                    }
                }
                break;

            case 4: // bar
                if (!twothispage && joynumaxes > 2)
                    cmenu(208);
            case 0: break;

            case 1: // digitals
            case 2:
            case 5:
            case 6:
                function = 3;
                whichkey = ((thispage*2+(x==5||x==6)) << 1) + (x==2||x==6);
                cmenu(211);
                probey = JoystickDigitalFunctions[whichkey>>1][whichkey&1];
                if (probey < 0) probey = NUMGAMEFUNCTIONS-1;
                break;

            case 3: // analogues
            case 7:
                l = JoystickAnalogueAxes[thispage*2+(x==7)];
                if (l == analog_turning) l = analog_strafing;
                else if (l == analog_strafing) l = analog_lookingupanddown;
                else if (l == analog_lookingupanddown) l = analog_moving;
                else if (l == analog_moving) l = -1;
                else l = analog_turning;
                JoystickAnalogueAxes[thispage*2+(x==7)] = l;
                CONTROL_MapAnalogAxis(thispage*2+(x==7),l,controldevice_joystick);
                break;
            default:break;
        }

        menutextc(42,41+5,0,0,getjoyname(0,thispage*2));
        if (twothispage)
            menutextc(42,41+64,0,0,getjoyname(0,thispage*2+1));

        gametext(76,47,"SCALE",0,2+8+16);
        l = (JoystickAnalogueScale[thispage*2]+262144) >> 13;
        barmd(140+56,47+6,(short *)&l,1,x==0,0,0);
        l = (l<<13)-262144;
        if (l != JoystickAnalogueScale[thispage*2])
        {
            CONTROL_SetAnalogAxisScale( thispage*2, l, controldevice_joystick );
            JoystickAnalogueScale[thispage*2] = l;
        }
        Bsprintf(tempbuf,"%s%.2f",l>=0?" ":"",(float)l/65536.0);
        gametext(140,47,tempbuf,0,2+8+16);

        gametext(76,47+15,"DIGITAL",0,2+8+16);
        if (JoystickDigitalFunctions[thispage*2][0] < 0)
            strcpy(tempbuf, "  -NONE-");
        else
            strcpy(tempbuf, CONFIG_FunctionNumToName(JoystickDigitalFunctions[thispage*2][0]));

        for (i=0;tempbuf[i];i++) if (tempbuf[i]=='_') tempbuf[i] = ' ';
        minitext(140+12,47+15,tempbuf,0,10+16);

        if (JoystickDigitalFunctions[thispage*2][1] < 0)
            strcpy(tempbuf, "  -NONE-");
        else
            strcpy(tempbuf, CONFIG_FunctionNumToName(JoystickDigitalFunctions[thispage*2][1]));

        for (i=0;tempbuf[i];i++) if (tempbuf[i]=='_') tempbuf[i] = ' ';
        minitext(140+12+72,47+15,tempbuf,0,10+16);

        gametext(76,47+15+15,"ANALOG",0,2+8+16);
        if (CONFIG_AnalogNumToName( JoystickAnalogueAxes[thispage*2] ))
        {
            p = CONFIG_AnalogNumToName( JoystickAnalogueAxes[thispage*2] );
            if (p)
            {
                gametext(140+12,47+15+15, strchr(p,'_')+1, 0, 2+8+16 );
            }
        }

        if (twothispage)
        {
            gametext(76,47+64,"SCALE",0,2+8+16);
            l = (JoystickAnalogueScale[thispage*2+1]+262144) >> 13;
            barmd(140+56,47+6+64,(short *)&l,1,x==4,0,0);
            l = (l<<13)-262144;
            if (l != JoystickAnalogueScale[thispage*2+1])
            {
                CONTROL_SetAnalogAxisScale( thispage*2+1, l, controldevice_joystick );
                JoystickAnalogueScale[thispage*2+1] = l;
            }
            Bsprintf(tempbuf,"%s%.2f",l>=0?" ":"",(float)l/65536.0);
            gametext(140,47+64,tempbuf,0,2+8+16);

            gametext(76,47+64+15,"DIGITAL",0,2+8+16);
            if (JoystickDigitalFunctions[thispage*2+1][0] < 0)
                strcpy(tempbuf, "  -NONE-");
            else
                strcpy(tempbuf, CONFIG_FunctionNumToName(JoystickDigitalFunctions[thispage*2+1][0]));

            for (i=0;tempbuf[i];i++) if (tempbuf[i]=='_') tempbuf[i] = ' ';
            minitext(140+12,47+15+64,tempbuf,0,10+16);

            if (JoystickDigitalFunctions[thispage*2+1][1] < 0)
                strcpy(tempbuf, "  -NONE-");
            else
                strcpy(tempbuf, CONFIG_FunctionNumToName(JoystickDigitalFunctions[thispage*2+1][1]));

            for (i=0;tempbuf[i];i++) if (tempbuf[i]=='_') tempbuf[i] = ' ';
            minitext(140+12+72,47+15+64,tempbuf,0,10+16);

            gametext(76,47+64+15+15,"ANALOG",0,2+8+16);
            if (CONFIG_AnalogNumToName( JoystickAnalogueAxes[thispage*2+1] ))
            {
                p = CONFIG_AnalogNumToName( JoystickAnalogueAxes[thispage*2+1] );
                if (p)
                {
                    gametext(140+12,47+64+15+15, strchr(p,'_')+1, 0, 2+8+16 );
                }
            }
        }

        if (joynumaxes > 2)
        {
            menutextc(320>>1,twothispage?172:122,SHX(-10),(joynumaxes<=2),"NEXT...");
            sprintf(tempbuf,"Page %d of %d",thispage+1,(joynumaxes+1)/2);
            gametext(320-100,162,tempbuf,0,2+8+16);
        }
        break;
    }

    case 213:
    case 214:
    case 215:
    case 216: { // Pray this is enough pages for now :-|
        int first,last;

         rotatesprite(320<<15,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
         menutext(320>>1,24,0,0,"JOY DEAD ZONES");

            first = 4*(current_menu-213);
            last  = min(4*(current_menu-213)+4,joynumaxes);

            onbar = 1;
            x = probemd(285,53-12,15,2*(last-first)+(joynumaxes>4));         // wx

            if (x==-1)
            {
                cmenu(206);
                probey = 2;
                break;
            }
            else
            if (x==2*(last-first) && joynumaxes>4)
            {
                cmenu( (current_menu-213) == (joynumaxes/4) ? 213 : (current_menu+1) );
                probey = 0;
                break;
            }

            for (m=first;m<last;m++)
            {
                unsigned short odx,dx,ody,dy;
                menutextc(32,48+30*(m-first),0,0,getjoyname(0,m));

                gametext(128,45+30*(m-first)-8,"DEAD",0,2+8+16);
                gametext(128,45+30*(m-first)-8+15,"SATU",0,2+8+16);

                dx = odx = min(64,64l*JoystickAnalogueDead[m]/10000l);
                dy = ody = min(64,64l*JoystickAnalogueSaturate[m]/10000l);

                barmd(217,43+30*(m-first),&dx,4,x==((m-first)*2),0,0);
                barmd(217,43+30*(m-first)+15,&dy,4,x==((m-first)*2+1),0,0);

                Bsprintf(tempbuf,"%3d%%",100*dx/64);
                gametext(217-49,45+30*(m-first)-8,tempbuf,0,2+8+16);
                Bsprintf(tempbuf,"%3d%%",100*dy/64);
                gametext(217-49,45+30*(m-first)-8+15,tempbuf,0,2+8+16);

                if (dx != odx) JoystickAnalogueDead[m]     = 10000l*dx/64l;
                if (dy != ody) JoystickAnalogueSaturate[m] = 10000l*dy/64l;
                if (dx != odx || dy != ody)
                    setjoydeadzone(m,JoystickAnalogueDead[m],JoystickAnalogueSaturate[m]);
            }
        if (joynumaxes>4)
        {
            menutextc(32,48+30*(last-first),0,0,"NEXT...");
            sprintf(tempbuf,"Page %d of %d", 1+(current_menu-213), (joynumaxes+3)/4);
            gametext(320-155,48+27*(last-first),tempbuf,0,2+8+16);
        }
        break;
    }

//---------------------------------------------------------------------------------

        case 700:
        case 701:   // JBF 20041220: A hack to stop the game exiting the menu directly to the game if one is running
            c = (320>>1)-90;
            rotatesprite(320<<15,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(320>>1,24,0,0,"SOUNDS");
            onbar = ( probey == 2 || probey == 3 );

            x = probemd(c-10,50-7,12,8);

            switch(x)
            {
                case -1:
                    if(ps[myconnectindex].gm&MODE_GAME && current_menu == 701)
                    {
                        ps[myconnectindex].gm &= ~MODE_MENU;
                        if(ud.multimode < 2  && ud.recstat != 2)
                        {
                            ready2send = 1;
                            totalclock = ototalclock;
                        }
                    }

                    else cmenu(202);
                    probey = 1;
                    break;
                case 0:
                    if (FXDevice >= 0)
                    {
                        SoundToggle = 1-SoundToggle;
                        if( SoundToggle == 0 )
                        {
                            FX_StopAllSounds();
                            clearsoundlocks();
                        }
                        onbar = 0;
                    }
                    break;
                case 1:
                    if (numplayers < 2)
                    {
                        if (MusicDevice >= 0)
                        {
                           MusicToggle = 1-MusicToggle;
                           if (MusicToggle == 0)
                           {
                               MusicPause(1);
                           }
                           else
                           {
                               if (ud.recstat != 2 && ps[myconnectindex].gm&MODE_GAME)
                               {
                                  if (MapMusic[0] != 0)                      // wxmm
                                  {
                                     strcpy(tempbuf, MapMusic);
                                  }
                                  else
                                  {
                                  i = ud.level_number;                                      // wxrm
                                  if (RandomMusic == 1 && ud.m_level_number == 7 && ud.m_volume_number == 0)
                                     {
                                     if (MusicDir == 1)
                                        {
                                        i = GetMusicFiles();
                                        strcpy(tempbuf, MusicFiles[i]);
                                        goto playp;
                                        }
                                     i = GetRandom(11);
                                     }
                                  music_select = (ud.volume_number*11) + i;
                                  strcpy(tempbuf, &music_fn[0][music_select][0]);
                                  }
playp:
                               playmusic(tempbuf);
                               }
                               MusicPause(0);
                           }
                        }
                    }
                    onbar = 0;
                    break;
                case 4:
                    if(SoundToggle && (FXDevice >= 0)) VoiceToggle = 1-VoiceToggle;
                    onbar = 0;
                    break;
                case 5:
                    if(SoundToggle && (FXDevice >= 0)) AmbienceToggle = 1-AmbienceToggle;
                    onbar = 0;
                    break;
                case 6:
                    if(SoundToggle && (FXDevice >= 0))
                    {
                        ReverseStereo = 1-ReverseStereo;
                        FX_SetReverseStereo(ReverseStereo);
                    }
                    onbar = 0;
                    break;
                case 7:                                              // wxrm
                    if (MusicToggle && (MusicDevice >= 0))
                        RandomMusic = 1-RandomMusic;
                    onbar = 0;
                    break;
                default:
                    onbar = 1;
                    break;
            }

            gametext(c+140,50-12,SoundToggle?"ON":"OFF",(FXDevice>=0)?0:16,2+8+16);
            gametext(c+140,50,MusicToggle&&numplayers<2?"ON":"OFF",(MusicDevice>=0)?0:16,2+8+16);

            menutextc(c,50,0,FXDevice<0,"SOUND");
            menutextc(c,50+12+12,0,FXDevice<0||SoundToggle==0,"SOUND VOLUME");
            {
                l = FXVolume;
                FXVolume >>= 2;
                barmd(c+148,50+12+8,(short *)&FXVolume,4,(FXDevice>=0)&&x==2,SHX(-4),SoundToggle==0||(FXDevice<0));
                if(l != FXVolume)
                    FXVolume <<= 2;
                if(l != FXVolume)
                    FX_SetVolume( (short) FXVolume );
            }
            menutextc(c,50+12,0,MusicDevice<0,"MUSIC");
            menutextc(c,50+12+12+12,0,MusicDevice<0||MusicToggle==0,"MUSIC VOLUME");
            {
                l = MusicVolume;
                MusicVolume >>= 2;
                barmd(c+148,50+12+12+8,(short *)&MusicVolume,4,(MusicDevice>=0) && x==3,SHX(-5),MusicToggle==0||(MusicDevice<0));
                MusicVolume <<= 2;
                if (l != MusicVolume)
                {
                    MusicSetVolume((short) MusicVolume);
                }
            }

            menutextc(c,50+12+12+12+12,0,FXDevice<0||SoundToggle==0,"DUKE TALK");
            menutextc(c,50+12+12+12+12+12,0,FXDevice<0||SoundToggle==0,"AMBIENCE");
            menutextc(c,50+12+12+12+12+12+12,0,MusicDevice<0||MusicToggle==0,"FLIP STEREO");
            menutextc(c,50+12+12+12+12+12+12+12,0,MusicDevice<0||MusicToggle==0,"RANDOM MUSIC");

            gametext(c+140,50+12+12+12,VoiceToggle?"ON":"OFF",(FXDevice>=0&&SoundToggle==1)?0:16,2+8+16);
            gametext(c+140,50+12+12+12+12,AmbienceToggle?"ON":"OFF",(FXDevice>=0&&SoundToggle==1)?0:16,2+8+16);
            gametext(c+140,50+12+12+12+12+12,ReverseStereo?"ON":"OFF",(MusicDevice>=0&&MusicToggle==1)?0:16,2+8+16);
            gametext(c+140,50+12+12+12+12+12+12,RandomMusic?"ON":"OFF",(MusicDevice>=0&&MusicToggle==1)?0:16,2+8+16);

            break;

        case 350:
            cmenu(351);
            screencapt = 1;
            displayrooms(myconnectindex,65536);
            //savetemp("duke3d.tmp",waloff[TILE_SAVESHOT],160*100);
            screencapt = 0;
            break;

        case 360:
        case 361:
        case 362:
        case 363:
        case 364:
        case 365:
        case 366:
        case 367:
        case 368:
        case 369:
        case 351:
        case 300:

            c = 320>>1;
            rotatesprite(c<<16,200<<15,65536L,0,MENUSCREEN,16,0,10+64,0,0,xdim-1,ydim-1);
            rotatesprite(c<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);

            if (current_menu == 300)
                menutext(c,24,0,0,"LOAD GAME");
            else
                menutext(c,24,0,0,"SAVE GAME");

            if (current_menu >= 360 && current_menu <= 369 )
            {

                if (ud.volume_number == 0 && ud.level_number == 7)
                   {
                   getboardmapname(boardfilename);
                   sprintf(tempbuf,"MAPNAME: %s", boardmapname);     // wxmp
                   minitext(10+13,150,tempbuf,0,2+8+16);
                   }
                else
                   {
                   sprintf(tempbuf,"TITLE: %s", &level_names[11*ud.m_volume_number+ud.m_level_number][0]);
                   minitext(10+21,150,tempbuf,0,2+8+16);
                   sprintf(tempbuf,"EPISODE: %d | LEVEL: %d",1+ud.volume_number,1+ud.level_number);
                   minitext(10+13,171,tempbuf,0,2+8+16);
                   }

                second_tics = (totalclock/120); // 3                 // wxst
                sprintf(tempbuf, "Time: %d mins %d secs", (second_tics/60), (second_tics%60)); // wxst
                minitext(10+25,157,tempbuf,0,2+8+16);

                sprintf(tempbuf,"SKILL: %d",ud.player_skill);
                minitext(10+21,164,tempbuf,0,2+8+16);

                x = strget((320>>1),184,&ud.savegame[current_menu-360][0],19, 999 );

                if (x == -1)
                    {
                //        readsavenames();
                        ps[myconnectindex].gm = MODE_GAME;
                        if(ud.multimode < 2  && ud.recstat != 2)
                        {
                            ready2send = 1;
                            totalclock = ototalclock;
                        }
                        goto DISPLAYNAMES;
                    }

                 if ( x == 1 )
                    {
                        if( ud.savegame[current_menu-360][0] == 0 )
                        {
                            KB_FlushKeyboardQueue();
                            cmenu(351);
                        }
                        else
                        {
                        if(ud.multimode > 1)
                           saveplayer(-1-(current_menu-360));
                        else
                           saveplayer(current_menu-360);
                        lastsavedpos = current_menu-360;
                        ps[myconnectindex].gm = MODE_GAME;

                        if(ud.multimode < 2  && ud.recstat != 2)
                        {
                            ready2send = 1;
                            totalclock = ototalclock;
                        }
                        KB_ClearKeyDown(sc_Escape);
                        sound(EXITMENUSOUND);
                    }
                }

                rotatesprite(101<<16,97<<16,65536>>1,512,TILE_SAVESHOT,-32,0,2+4+8+64,0,0,xdim-1,ydim-1);
                dispnames();
                rotatesprite((c+67+strlen(&ud.savegame[current_menu-360][0])*4)<<16,(50+12*probey)<<16,32768L-10240,0,SPINNINGNUKEICON+(((totalclock)>>3)%7),0,0,10,0,0,xdim-1,ydim-1);
                break;
            }

          last_threehundred = probey;

          if (ud.autosave > 0 && current_menu == 300 && ud.autodone > 0 && ud.multimode < 2) // wxas
              x = probesm(c+62,52,12,11); //x = probe(c+68,54,12,11);    // wxsi
          else
              x = probesm(c+62,52,12,10); //x = probe(c+68,54,12,10);

          if (current_menu == 300)
          {
              if (ud.savegame[probey][0])
              {
                  if( lastprobey != probey )
                  {
                     loadpheader(probey,&savehead);
                     lastprobey = probey;
                  }

                  rotatesprite(101<<16,97<<16,65536L>>1,512,TILE_LOADSHOT,-32,0,4+10+64,0,0,xdim-1,ydim-1);

                  if (savehead.volnum == 0 && savehead.levnum == 7)  // Load (4)
                     {
                     getboardmapname(savehead.boardfn);
                     sprintf(tempbuf,"MAPNAME: %s", boardmapname);   // wxmp
                     minitext(10+13,150,tempbuf,23,2+8+16);
                     }
                  else
                     {
                     sprintf(tempbuf,"TITLE: %s", &level_names[11*savehead.volnum+savehead.levnum][0]);
                     minitext(10+21,150,tempbuf,23,2+8+16);
                     sprintf(tempbuf,"EPISODE: %d | LEVEL: %d",1+savehead.volnum,1+savehead.levnum);
                     minitext(10+13,171,tempbuf,23,2+8+16);
                     }

                  second_tics = (totalclock/120);  // 4              // wxst
                  sprintf(tempbuf, "Time: %d mins %d secs", (second_tics/60), (second_tics%60)); // wxst
                  minitext(10+25,157,tempbuf,23,2+8+16);

                  sprintf(tempbuf,"SKILL: %d",savehead.plrskl);
                  minitext(10+21,164,tempbuf,23,2+8+16);

              }
              else
              if (ud.autodone > 0 && probey == 10)
              {
                  if (lastprobey != probey)
                  {
                     loadpheader(probey,&savehead);
                     lastprobey = probey;
                  }
                  rotatesprite(101<<16,97<<16,65536L>>1,512,TILE_LOADSHOT,-32,0,4+10+64,0,0,xdim-1,ydim-1);

                  if (savehead.volnum == 0 && savehead.levnum == 7)  // wxas  (load)
                     {
                     getboardmapname(savehead.boardfn);
                     sprintf(tempbuf,"MAPNAME: %s", boardmapname);   // wxmp
                     minitext(10+13,150,tempbuf,23,2+8+16);
                     }
                  else
                     {
                     sprintf(tempbuf,"TITLE: %s", &level_names[11*savehead.volnum+savehead.levnum][0]);
                     minitext(10+21,150,tempbuf,0,2+8+16);
                     sprintf(tempbuf,"EPISODE: %d | LEVEL: %d",1+savehead.volnum,1+savehead.levnum);
                     minitext(10+13,171,tempbuf,0,2+8+16);
                     }
              }
              else
              {
              if (ud.autosave > 0 && probey == 10 && ud.multimode < 2)
                  menutext(49,70,0,0,"AUTOSAVE");                  // wxas
              else
                  menutext(69,70,0,0,"EMPTY");
              }
          }
          else
          {
              if( ud.savegame[probey][0] )
              {
                  if(lastprobey != probey)
                      loadpheader(probey,&savehead);
                  lastprobey = probey;
                  rotatesprite(101<<16,97<<16,65536L>>1,512,TILE_LOADSHOT,-32,0,4+10+64,0,0,xdim-1,ydim-1);
              }
              else menutext(69,70,0,0,"EMPTY");

              if (ud.volume_number == 0 && ud.level_number == 7)
                 {
                 getboardmapname(boardfilename);
                 sprintf(tempbuf,"MAPNAME: %s", boardmapname);       // wxmp
                 minitext(10+13,150,tempbuf,0,2+8+16);
                 }
              else
                 {
                 sprintf(tempbuf,"TITLE: %s", &level_names[11*ud.m_volume_number+ud.m_level_number][0]);
                 minitext(10+21,150,tempbuf,0,2+8+16);
                 sprintf(tempbuf,"EPISODE: %d | LEVEL: %d",1+ud.volume_number,1+ud.level_number);
                 minitext(10+13,171,tempbuf,0,2+8+16);
                 }

              second_tics = (totalclock/120); // 5                   // wxst
              sprintf(tempbuf, "Time: %d mins %d secs", (second_tics/60), (second_tics%60)); // wxst
              minitext(10+25,157,tempbuf,0,2+8+16);

              sprintf(tempbuf,"SKILL: %d",ud.player_skill);
              minitext(10+21,164,tempbuf,0,2+8+16);
          }

            switch( x )
            {
                case -1:
                    if(current_menu == 300)
                    {
                        if( (ps[myconnectindex].gm&MODE_GAME) != MODE_GAME)
                        {
                            cmenu(0);
                            break;
                        }
                        else
                            ps[myconnectindex].gm &= ~MODE_MENU;
                    }
                    else
                        ps[myconnectindex].gm = MODE_GAME;

                    if(ud.multimode < 2 && ud.recstat != 2)
                    {
                        ready2send = 1;
                        totalclock = ototalclock;
                    }

                    break;
                case 0:
                case 1:
                case 2:
                case 3:
                case 4:
                case 5:
                case 6:
                case 7:
                case 8:
                case 9:
                case 10:
                    if( current_menu == 300)
                    {
                        if (ud.autosave > 0 && x == 10 && ud.autodone > 0 && numplayers < 2) // wxas
                           {
                           loadplayer(10);
                           break;
                           }
                        if( ud.savegame[x][0] )
                            current_menu = (1000+x);
                    }
                    else
                    {
                        if( ud.savegame[x][0] != 0)
                            current_menu = 2000+x;
                        else
                        {
                            KB_FlushKeyboardQueue();
                            current_menu = (360+x);
                            ud.savegame[x][0] = 0;
                            inputloc = 0;
                        }
                    }
                    break;
            }

            DISPLAYNAMES:
            dispnames();
            break;

        case 400:
        case 401:
        if (VOLUMEALL) goto VOLUME_ALL_40x;
        case 402:
        case 403:

            c = 320>>1;

            if( KB_KeyPressed( sc_LeftArrow ) ||
                KB_KeyPressed( sc_kpad_4 ) ||
                KB_KeyPressed( sc_UpArrow ) ||
                KB_KeyPressed( sc_PgUp ) ||
                KB_KeyPressed( sc_kpad_8 ) )
            {
                KB_ClearKeyDown(sc_LeftArrow);
                KB_ClearKeyDown(sc_kpad_4);
                KB_ClearKeyDown(sc_UpArrow);
                KB_ClearKeyDown(sc_PgUp);
                KB_ClearKeyDown(sc_kpad_8);

                sound(KICK_HIT);
                current_menu--;
                if(current_menu < 400) current_menu = 403;
            }
            else if(
                KB_KeyPressed( sc_PgDn ) ||
                KB_KeyPressed( sc_Enter ) ||
                KB_KeyPressed( sc_kpad_Enter ) ||
                KB_KeyPressed( sc_RightArrow ) ||
                KB_KeyPressed( sc_DownArrow ) ||
                KB_KeyPressed( sc_kpad_2 ) ||
                KB_KeyPressed( sc_kpad_9 ) ||
                KB_KeyPressed( sc_Space ) ||
                KB_KeyPressed( sc_kpad_6 ) )
            {
                KB_ClearKeyDown(sc_PgDn);
                KB_ClearKeyDown(sc_Enter);
                KB_ClearKeyDown(sc_RightArrow);
                KB_ClearKeyDown(sc_kpad_Enter);
                KB_ClearKeyDown(sc_kpad_6);
                KB_ClearKeyDown(sc_kpad_9);
                KB_ClearKeyDown(sc_kpad_2);
                KB_ClearKeyDown(sc_DownArrow);
                KB_ClearKeyDown(sc_Space);
                sound(KICK_HIT);
                current_menu++;
                if(current_menu > 403) current_menu = 400;
            }

            if (KB_KeyPressed(sc_Escape))
            {
                if (ps[myconnectindex].gm&MODE_GAME)
                    cmenu(50);
                else
                    cmenu(0);
                return;
            }

            flushperms();
            rotatesprite(0,0,65536L,0,ORDERING+current_menu-400,0,0,10+16+64,0,0,xdim-1,ydim-1);

        break;
VOLUME_ALL_40x:

            c = 320>>1;

            if( KB_KeyPressed( sc_LeftArrow ) ||
                KB_KeyPressed( sc_kpad_4 ) ||
                KB_KeyPressed( sc_UpArrow ) ||
                KB_KeyPressed( sc_PgUp ) ||
                KB_KeyPressed( sc_kpad_8 ) )
            {
                KB_ClearKeyDown(sc_LeftArrow);
                KB_ClearKeyDown(sc_kpad_4);
                KB_ClearKeyDown(sc_UpArrow);
                KB_ClearKeyDown(sc_PgUp);
                KB_ClearKeyDown(sc_kpad_8);

                sound(KICK_HIT);
                current_menu--;
                if(current_menu < 400) current_menu = 401;
            }
            else if(
                KB_KeyPressed( sc_PgDn ) ||
                KB_KeyPressed( sc_Enter ) ||
                KB_KeyPressed( sc_kpad_Enter ) ||
                KB_KeyPressed( sc_RightArrow ) ||
                KB_KeyPressed( sc_DownArrow ) ||
                KB_KeyPressed( sc_kpad_2 ) ||
                KB_KeyPressed( sc_kpad_9 ) ||
                KB_KeyPressed( sc_Space ) ||
                KB_KeyPressed( sc_kpad_6 ) )
            {
                KB_ClearKeyDown(sc_PgDn);
                KB_ClearKeyDown(sc_Enter);
                KB_ClearKeyDown(sc_RightArrow);
                KB_ClearKeyDown(sc_kpad_Enter);
                KB_ClearKeyDown(sc_kpad_6);
                KB_ClearKeyDown(sc_kpad_9);
                KB_ClearKeyDown(sc_kpad_2);
                KB_ClearKeyDown(sc_DownArrow);
                KB_ClearKeyDown(sc_Space);
                sound(KICK_HIT);
                current_menu++;
                if(current_menu > 401) current_menu = 400;
            }

            if (KB_KeyPressed(sc_Escape))                            // wxyz
            {
                if (ps[myconnectindex].gm&MODE_GAME)
                    cmenu(50);
                else
                    cmenu(0);
                return;
            }

/*
            x = probe(0,0,0,1);
            if (x == -1)
            {
                if (ps[myconnectindex].gm&MODE_GAME)
                    cmenu(50);
                else
                    cmenu(0);
                return;
            }
*/
            flushperms();
            switch(current_menu)
            {
                case 400:
                    rotatesprite(0,0,65536L,0,TEXTSTORY,0,0,10+16+64, 0,0,xdim-1,ydim-1);
                    break;
                case 401:
                    rotatesprite(0,0,65536L,0,F1HELP,0,0,10+16+64, 0,0,xdim-1,ydim-1);
                    break;
            }

            break;

        case 500:
            c = 320>>1;

            gametext(c,85,"You sure you want to quit (Y/N)",0,2+8+16);
            if (MenuBypass == 0)                                       // wxmb
                gametext(c,99,"Press (X) for Startup Menu",12,2+8+16); // wxsm

            if (KB_KeyPressed(sc_Space) || KB_KeyPressed(sc_Enter) || KB_KeyPressed(sc_kpad_Enter) || KB_KeyPressed(sc_Y) || LMB )
            {
                KB_FlushKeyboardQueue();

                if( gamequit == 0 && ( numplayers > 1 ) )
                {
                    if (ps[myconnectindex].gm&MODE_GAME)
                    {
                        gamequit = 1;
                        quittimer = totalclock+12;
                    }
                    else
                    {
                        short i;                                     // wxdm

                        buf[0] = 255;
                        buf[1] = myconnectindex;

                        for (i=connecthead; i>=0; i=connectpoint2[i])
                        {
                            if (i != myconnectindex)
                                sendpacket(i,&buf[0],2);
                            if ((!networkmode) && (myconnectindex != connecthead))
                                break;
                        }

                        sendlogoff();
                        gameexit(" ");
                    }
                }
                else
                if (numplayers < 2 )
                    gameexit(" ");

                faketimerhandler();

                if ((totalclock > quittimer ) && (gamequit == 1))
                    gameexit(" "); //gameexit("Timed out.");
            }

            if (KB_KeyPressed(sc_X))                                 // wxsm wxmb
            {
                KB_FlushKeyboardQueue();
                if (numplayers > 1)
                    sendlogoff();
                gameexit("xxx");
            }

            x = probe(186,124,0,0);
            if (x == -1 || KB_KeyPressed(sc_N) || RMB)
            {
                KB_ClearKeyDown(sc_N);
                quittimer = 0;
                if( ps[myconnectindex].gm&MODE_DEMO )
                    ps[myconnectindex].gm = MODE_DEMO;
                else
                if (!(ps[myconnectindex].gm & MODE_GAME || ud.recstat == 2))
                    cmenu(0);
                else
                {
                    ps[myconnectindex].gm &= ~MODE_MENU;
                    if(ud.multimode < 2  && ud.recstat != 2)
                    {
                        ready2send = 1;
                        totalclock = ototalclock;
                    }
                }
            }

            break;
        case 501:
            c = 320>>1;
            gametext(c,90,"Quit to Title?",0,2+8+16);
            gametext(c,99,"(Y/N)",0,2+8+16);

            if( KB_KeyPressed(sc_Space) || KB_KeyPressed(sc_Enter) || KB_KeyPressed(sc_kpad_Enter) || KB_KeyPressed(sc_Y) || LMB )
            {
                KB_FlushKeyboardQueue();
                ps[myconnectindex].gm = MODE_DEMO;
                if(ud.recstat == 1)
                    closedemowrite();
                MenuBypass = 0;                                      // wxmb
                cmenu(0);
            }

            x = probe(186,124,0,0);

            if(x == -1 || KB_KeyPressed(sc_N) || RMB)
            {
                ps[myconnectindex].gm &= ~MODE_MENU;
                if(ud.multimode < 2  && ud.recstat != 2)
                {
                    ready2send = 1;
                    totalclock = ototalclock;
                }
            }

            break;

        case 601:
            displayfragbar();
            rotatesprite(160<<16,26<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(320>>1,31,0,0,&ud.user_name[myconnectindex][0]);

            sprintf(tempbuf,"Waiting for master");
            gametext(160,50,tempbuf,0,2+8+16);
            gametext(160,59,"to select level",0,2+8+16);

            if( KB_KeyPressed(sc_Escape) )
            {
                KB_ClearKeyDown(sc_Escape);
                sound(EXITMENUSOUND);
                cmenu(0);
            }
            break;

        case 602:
            if(menunamecnt == 0)
            {
                getfilenames(".","*.MAP",0);
                if (menunamecnt == 0)
                    cmenu(600);
            }
        case 603:
            c = (320>>1) - 120;

            displayfragbar();
            rotatesprite(320>>1<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
            menutext(320>>1,24,0,0,"USER MAPS");

            for(x=0;x<menunamecnt;x++)
            {
                if(x == fileselect)
                    minitext(15 + (x/15)*54,32 + (x%15)*8,menuname[x],0,26);
                else minitext(15 + (x/15)*54,32 + (x%15)*8,menuname[x],16,26);
            }

            fileselect = probey;
            if( KB_KeyPressed( sc_LeftArrow ) || KB_KeyPressed( sc_kpad_4 ) || ((buttonstat&1) && minfo.dyaw < -256 ) )
            {
                KB_ClearKeyDown( sc_LeftArrow );
                KB_ClearKeyDown( sc_kpad_4 );
                probey -= 15;
                if(probey < 0) probey += 15;
                else sound(KICK_HIT);
            }
            if( KB_KeyPressed( sc_RightArrow ) || KB_KeyPressed( sc_kpad_6 ) || ((buttonstat&1) && minfo.dyaw > 256 ) )
            {
                KB_ClearKeyDown( sc_RightArrow );
                KB_ClearKeyDown( sc_kpad_6 );
                probey += 15;
                if(probey >= menunamecnt)
                    probey -= 15;
                else sound(KICK_HIT);
            }

            onbar = 0;
            x = probe(0,0,0,menunamecnt);

            if (x == -1)
                cmenu(600);
            else
            if (x >= 0)
            {
                tempbuf[0] = 8;
                tempbuf[1] = ud.m_level_number = 6;
                tempbuf[2] = ud.m_volume_number = 0;
                tempbuf[3] = ud.m_player_skill+1;

                if(ud.player_skill == 3)
                    ud.m_respawn_monsters = 1;
                else ud.m_respawn_monsters = 0;

                if(ud.m_coop == 0) ud.m_respawn_items = 1;
                else ud.m_respawn_items = 0;

                ud.m_respawn_inventory = ud.m_respawn_items;         // wxdm

                tempbuf[4] = ud.m_monsters_off;
                tempbuf[5] = ud.m_respawn_monsters;
                tempbuf[6] = ud.m_respawn_items;
                tempbuf[7] = ud.m_respawn_inventory;
                tempbuf[8] = ud.m_coop;
                tempbuf[9] = ud.m_marker;

                x = strlen(menuname[probey]);

                copybufbyte(menuname[probey],tempbuf+10,x);
                copybufbyte(menuname[probey],boardfilename,x+1);

                for(c=connecthead;c>=0;c=connectpoint2[c])
                {
                    if (c != myconnectindex) sendpacket(c,tempbuf,x+10);
                    if ((!networkmode) && (myconnectindex != connecthead)) break; //slaves in M/S mode only send to master
                }

                checkforsaves(boardfilename);

                newgame(ud.m_volume_number,ud.m_level_number,ud.m_player_skill+1);
                if (enterlevel(MODE_GAME)) backtomenu();
            }
            break;

        case 600:
        case 610:
            c = (320>>1) - 123;
            rotatesprite(160<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);

            if (bFake)
                menutext(160,24,0,0,"FAKE MULTIPLAY");                 // wxdm
            else
                menutext(160,24,0,0,NetworkType[bHost]);               // wxdm

            x = 0;
            if (current_menu == 600)
                x = probemd(c+2,43,11,12);                             // wxdm

            switch(x)
            {
                case -1:
                    ud.m_recstat = 0;
                    if (ps[myconnectindex].gm&MODE_GAME)
                        cmenu(50);
                    else
                        cmenu(0);
                    break;
                case 0:
                    if (current_menu == 600)
                    {
                        strcpy(buf, PlayerNameArg);                  // wxpa
                        inputloc = strlen(buf);
                        current_menu = 610;

                        KB_ClearKeyDown(sc_Enter);
                        KB_ClearKeyDown(sc_kpad_Enter);
                        KB_FlushKeyboardQueue();
                    }
                    else
                    {
                        x = strget(c+118,39,buf,31,0);
                        if (x)
                        {
                            if (x == 1)
                            {
                                strcpy(PlayerNameArg,buf);           // wxpa
                                SendPlayerInfo();    // send name/color update

                            }
                            KB_ClearKeyDown(sc_Enter);
                            KB_ClearKeyDown(sc_kpad_Enter);
                            KB_FlushKeyboardQueue();
                            current_menu = 600;
                        }
                    }
                    break;
                case 1:
                    if (!bFake)
                    {
                        ud.color++;
                        if (ud.color == 1)
                            ud.color = 9;
                        else
                        if (ud.color > 16 && ud.color < 23)
                            ud.color = 23;
                        else
                        if (ud.color > 23)
                            ud.color = 0;
                        SendPlayerInfo();
                        sprite[ps[myconnectindex].i].pal = ud.color; // wxdm
                        ps[myconnectindex].palookup = ud.color;
                    }
                    break;
                case 2:
                    if (!bFake)
                    {
                        ud.m_coop++;
                        if (ud.m_coop == 3)
                            ud.m_coop = 0;
                    }
                    break;
                case 3:
                    if (!VOLUMEONE)
                    {
                        ud.m_volume_number++;
                        if (PLUTOPAK)
                        {
                           if (ud.m_volume_number > 3)
                               ud.m_volume_number = 0;
                        }
                        else
                        {
                           if (ud.m_volume_number > 2)
                               ud.m_volume_number = 0;
                        }
                    if (ud.m_volume_number == 0 && ud.m_level_number > 6)
                        ud.m_level_number = 0;
                    if (ud.m_level_number > 10)
                        ud.m_level_number = 0;
                    boardfilename[0] = 0;
                    }
                    break;
                case 4:
                    ud.m_level_number++;
                    if (!VOLUMEONE)
                    {
                        if (ud.m_volume_number == 0 && ud.m_level_number > 6)
                            ud.m_level_number = 0;
                    }
                    else
                    {
                        if (ud.m_volume_number == 0 && ud.m_level_number > 5)
                            ud.m_level_number = 0;
                    }
                    if (ud.m_level_number > 10)
                        ud.m_level_number = 0;
                    boardfilename[0] = 0;
                    break;
                case 5:
                    if(ud.m_monsters_off == 1 && ud.m_player_skill > 0)
                        ud.m_monsters_off = 0;

                    if(ud.m_monsters_off == 0)
                    {
                        ud.m_player_skill++;
                        if(ud.m_player_skill > 3)
                        {
                            ud.m_player_skill = 0;
                            ud.m_monsters_off = 1;
                        }
                    }
                    else
                        ud.m_monsters_off = 0;

                    break;

                case 6:
                    ud.m_respawn_items = !ud.m_respawn_items;
                    break;

                case 7:
                    if(ud.m_coop == 0)
                        ud.m_marker = !ud.m_marker;
                    break;

                case 8:
                    if(ud.m_coop == 1)
                        ud.m_ffire = !ud.m_ffire;
                    break;

                case 9:
                    if(ud.m_coop == 0)
                    {
                        ShowOpponentWeapons = !ShowOpponentWeapons;
                        ud.showweapons = ShowOpponentWeapons;
                    }
                    break;

                case 10:    // USER MAPS
                    if (VOLUMEALL)
                    {
                        cmenu(101);                                  // wxup
                        break;
                    }

                case 11:     // start game
                    tempbuf[0] = 5;
                    tempbuf[1] = ud.m_level_number;
                    tempbuf[2] = ud.m_volume_number;
                    tempbuf[3] = ud.m_player_skill+1;

                    if (ud.m_player_skill == 3)
                        ud.m_respawn_monsters = 1;
                    else
                        ud.m_respawn_monsters = 0;

                    ud.m_respawn_inventory = ud.m_respawn_items;     // wxdm

                    tempbuf[4] = ud.m_monsters_off;
                    tempbuf[5] = ud.m_respawn_monsters;
                    tempbuf[6] = ud.m_respawn_items;
                    tempbuf[7] = ud.m_respawn_inventory;
                    tempbuf[8] = ud.m_coop;
                    tempbuf[9] = ud.m_marker;
                    tempbuf[10] = ud.m_ffire;

                    for (c=connecthead;c>=0;c=connectpoint2[c])
                    {
                        resetweapons(c);
                        resetinventory(c);
                    }

                    for (c=connecthead;c>=0;c=connectpoint2[c])
                    {
                        if (c != myconnectindex)
                            sendpacket(c,tempbuf,11);
                        if ((!networkmode) && (myconnectindex != connecthead))
                            break; //slaves in M/S mode only send to master
                    }

                    SendUserMap();                                   // wxdm
                    SendPlayerInfo();                                // wxdm

                    newgame(ud.m_volume_number,ud.m_level_number,ud.m_player_skill+1);
                    if (enterlevel(MODE_GAME))
                        backtomenu();
                    return;
            }

            c += 48;

            i = ud.color;
            if (i < 9 || i > 23)
            {
                i = 0;
                ud.color = i;
            }
            else
            {
                if (i == 23)
                    i = 17;
                i = i - 8;
            }
            j = ud.color;
            if (j == 11)
                j = 8;
            if (j == 23)
                j = 11;

            if (current_menu == 600)
            {
                gametext(c+70,39,&ud.user_name[myconnectindex][0],j,2+8+16);
            }

            if (bFake)
                gametext(c+70,50,PlayerColor[0],j,2+8+16);
            else
                gametext(c+70,50,PlayerColor[i],j,2+8+16);

            //sprintf(tempbuf, "%d", ud.color);
            //gametext(c+70,50,tempbuf,ud.color,2+8+16);

            if (ud.m_coop==1)
                gametext(c+70,61,"COOPERATIVE PLAY",0,2+8+16);
            else
            if (ud.m_coop==2)
                gametext(c+70,61,NAMGAME?"GRUNTMATCH (NO SPAWN)":"DUKEMATCH (NO SPAWN)",0,2+8+16);
            else
                gametext(c+70,61,NAMGAME?"GRUNTMATCH (SPAWN)":"DUKEMATCH (SPAWN)",0,2+8+16);

            if (VOLUMEONE)
            {
                gametext(c+70,72,volume_names[ud.m_volume_number],0,2+8+16);
            }
            else
            {
                gametext(c+70,72,volume_names[ud.m_volume_number],0,2+8+16);
            }

                gametext(c+70,83,&level_names[11*ud.m_volume_number+ud.m_level_number][0],0,2+8+16);

            if (ud.m_monsters_off == 0 || ud.m_player_skill > 0)
                gametext(c+70,94,skill_names[ud.m_player_skill],0,2+8+16);
            else
                gametext(c+70,94,"NONE",0,2+8+16);

            if (ud.m_respawn_items)
                gametext(c+70,105,"ON",0,2+8+16);
            else
               gametext(c+70,105,"OFF",0,2+8+16);

            if (ud.m_coop == 0)
            {
                if (ud.m_marker)
                    gametext(c+70,116,"ON",0,2+8+16);
                else
                    gametext(c+70,116,"OFF",0,2+8+16);
            }

            if (ud.m_coop == 1)
            {
                if (ud.m_ffire)
                    gametext(c+70,127,"ON",0,2+8+16);
                else
                    gametext(c+70,127,"OFF",0,2+8+16);
            }

            if (ShowOpponentWeapons)
                gametext(c+70,138,"SHOW WEAPONS",0,2+8+16);
            else
                gametext(c+70,138,"HIDE WEAPONS",0,2+8+16);

            c -= 38;

            menutextc(c,50,SHX(-2),PHX(-2),"PLAYER NAME");  // multiplayer

            menutextc(c,61,SHX(-2),bFake,"PLAYER COLOR");

            menutextc(c,72,SHX(-2),bFake,"GAME TYPE");

            if (VOLUMEONE)
            {
                sprintf(tempbuf,"EPISODE %ld",ud.m_volume_number+1);
                menutextc(c,83,SHX(-3),1,tempbuf);
            }
            else
            {
                sprintf(tempbuf,"EPISODE %ld",ud.m_volume_number+1);
                menutextc(c,83,SHX(-3),PHX(-3),tempbuf);
            }

            sprintf(tempbuf,"LEVEL %ld",ud.m_level_number+1);
            menutextc(c,94,SHX(-4),PHX(-4),tempbuf);

            menutextc(c,105,SHX(-5),PHX(-5),"MONSTERS");

            menutextc(c,116,SHX(-6),0,"SPAWN ITEMS");

            if (ud.m_coop == 0)
                menutextc(c,127,SHX(-7),PHX(-6),"MARKERS");
            else
                menutextc(c,127,SHX(-7),1,"MARKERS");

            if (ud.m_coop == 1)
                menutextc(c,138,SHX(-8),PHX(-6),"FR. FIRE");
            else
                menutextc(c,138,SHX(-8),1,"FR. FIRE");

            menutextc(c,149,SHX(-9),0,"OPPONENTS");

            if (VOLUMEALL)
            {
                i = 0;
                if (bGrp || !bHost)
                    i = 1;
                menutextc(c,160,SHX(-10),i,"USER MAP");               // wxdm
                if (boardfilename[0] != 0)
                {
                    getboardmapname(boardfilename);
                    gametext(c+107,149,boardmapname,0,2+8+16);       // wxup
                }
            }
            else
            {
                menutextc(c,160,SHX(-10),1,"USER MAP");
            }

            menutextc(c,171,SHX(-11),!bHost,"START GAME");            // wxdm
            break;

        case 1234:                                                   // wxdm
            {
                short t;
                long i, y, xfragtotal, yfragtotal;

                rotatesprite(0<<16, 0<<16, 65536l<<5, 0, BLANK, 0, 0, 10+16+1+32,
                             scale(25-4,xdim,320),scale(22+7-2,ydim,200),              // left  top
                             scale(320-25+4,xdim,320)-1,scale(37+4+112+4,ydim,200)-1); // right bot

                gametext(160,28+5,"MULTIPLAYER TOTALS",0,2+8+16);

                if (boardmapname[0] != 0)
                    gametext(160,28+15,boardmapname,0,2+8+16);
                else
                    gametext(160,28+15,level_names[(ud.volume_number*11)+ud.last_level-1],0,2+8+16);
                gametext(160,143,"PRESS ESCAPE TO EXIT",0,2+8+16);

                t = 0;
                gametextsm(23,55,"    NAME                                               KILLS",9,2+8+16+128);

                for (i=0; i<playerswhenstarted; i++)
                {
                    sprintf(tempbuf,"%-4ld",i+1);
                    minitext(92+(i*23),55,tempbuf,3,2+8+16+128);
                }

                for (i=0; i<playerswhenstarted; i++)
                {
                    xfragtotal = 0;
                    sprintf(tempbuf,"%ld",i+1);

                    minitext(30,65+t,tempbuf,0,2+8+16+128);
                    minitext(38,65+t,ud.user_name[i],ps[i].palookup,2+8+16+128);

                    for (y=0; y<playerswhenstarted; y++)
                    {
                        if(i == y)
                        {
                            sprintf(tempbuf,"%-4d",ps[y].fraggedself);
                            minitext(92+(y*23),65+t,tempbuf,2,2+8+16+128);
                            xfragtotal -= ps[y].fraggedself;
                        }
                        else
                        {
                            sprintf(tempbuf,"%-4d",frags[i][y]);
                            minitext(92+(y*23),65+t,tempbuf,0,2+8+16+128);
                            xfragtotal += frags[i][y];
                        }
                    }

                    sprintf(tempbuf,"%-4ld",xfragtotal);
                    minitext(86+(8*23),65+t,tempbuf,2,2+8+16+128);

                    t += 7;
                }

                for (y=0; y<playerswhenstarted; y++)
                {
                    yfragtotal = 0;
                    for (i=0; i<playerswhenstarted; i++)
                    {
                        if (i == y)
                            yfragtotal += ps[i].fraggedself;
                        yfragtotal += frags[i][y];
                    }
                    sprintf(tempbuf,"%-4ld",yfragtotal);
                    minitext(92+(y*23),71+(8*7),tempbuf,2,2+8+16+128);
                }

                gametextsm(37,71+(8*7),"DEATHS",9,2+8+16+128);

                x = probesm(160,150,0,0);

                if (x == -1)
                    ps[myconnectindex].gm &= ~MODE_MENU;
            }
            break;

    case 1235:                                                       // wxog
        if (strchr(MusicName,'/') != 0)
            strcpy(tempbuf, strrchr(MusicName, '/')+1);
        else
            strcpy(tempbuf, MusicName);

        GetMusicFiles();
        MusicCur = 0;
        MusicPos = 0;
        cmenu(1236);
        KB_FlushKeyboardQueue();
    case 1236:                                                       // wxog
        rotatesprite(160<<16,19<<16,65536L,0,MENUBAR,16,0,10,0,0,xdim-1,ydim-1);
        menutext(160,24,0,0,"SELECT MUSIC");
        // black translucent background underneath file lists
        rotatesprite(0<<16, 0<<16, 65536l<<5, 0, BLANK, 0, 0, 10+16+1+32,
                     scale(65-4,xdim,320),scale(12+32-5,ydim,200),
                     scale(320-65+4,xdim,320)-1,scale(180,ydim,200)-1);

        minitext(134,54,tempbuf,9,26);
        gametext(114,12+32,"MUSIC FILES",0,2+8+16);
        if (MusicNum > 12)
            minitext(114,160,"Page Down / Page Up",12,26);
        minitext(114,168,"DELETE = STOP MUSIC",9,26);

        j = 0;
        for (i=MusicCur; i<MusicCur+12; i++)
        {
             if (strchr(MusicFiles[i],'/') != 0)
                 strcpy(MyMusic[j], strrchr(MusicFiles[i], '/')+1);
             else
                 strcpy(MyMusic[j], MusicFiles[i]);
            c = 16;
            if (j == MusicPos)
                c = 0;
            minitextshade(134,18+12+32+(8*j),MyMusic[j],c,2,26);
            j++;
        }

        if (KB_KeyPressed(sc_Delete))
        {
            KB_ClearKeyDown(sc_Delete);
            stopmusic();
            initprintf("Stop Playing Music: %s\n", tempbuf);
        }

        if (KB_KeyPressed(sc_PgDn))
        {
            KB_ClearKeyDown(sc_PgDn);
            MusicCur += 11;
            if (MusicCur > MusicNum-12)
            {
               MusicCur = MusicNum-12;
               if (MusicCur < 0)
                   MusicCur = 0;
            }
        }
        else
        if (KB_KeyPressed(sc_PgUp))
        {
            KB_ClearKeyDown(sc_PgDn);
            MusicCur -= 11;
            if (MusicCur < 0)
                MusicCur = 0;
        }

        onbar = 0;
        probey = 2;
        x = probesm(110,12+32+5,0,3);

        if (probey == 1)
        {
            if (MusicPos > 0)
                MusicPos--;
        }
        else
        if (probey == 0)
        {
            if (MusicPos < 11)
                MusicPos++;
        }

        if (x == -1)
        {
            clearfilenames();
            strcpy(MusicName, tempbuf);
            KB_KeyDown[sc_Escape] = 1;
            cmenu(0);
        }
        else
        if (x >= 0)
        {
            if (currentlist == 0)
            {
                strcpy(MusicName, tempbuf);
                KB_KeyDown[sc_Escape] = 1;
                cmenu(0);
                KB_FlushKeyboardQueue();
            }
            else
            {
                if (MusicNum == 0)
                    break;
                strcpy(MusicName, MusicFolder);
                strcat(MusicName, MyMusic[MusicPos]);
                dolower(&MusicName);                                 // wxdl
                if (strstr(MusicName, ".mid") || strstr(MusicName, ".ogg") || strstr(MusicName, ".wav"))
                {
                    stopmusic();
                    strcpy(MapMusic, MusicName);
                    playmusic(MusicName);
                }
                KB_KeyDown[sc_Escape] = 1;
                cmenu(0);
            }
            clearfilenames();
        }
        break;
    }

    if( (ps[myconnectindex].gm&MODE_MENU) != MODE_MENU)
    {
        vscrn();
        cameraclock = totalclock;
        cameradist = 65536L;
    }

}

void palto(char r,char g,char b,long e)
{
    int i;
    char temparray[768];
    long tc;
/*
    for(i=0;i<768;i+=3)
    {
        temparray[i  ] =
            ps[myconnectindex].palette[i+0]+((((long)r-(long)ps[myconnectindex].palette[i+0])*(long)(e&127))>>6);
        temparray[i+1] =
            ps[myconnectindex].palette[i+1]+((((long)g-(long)ps[myconnectindex].palette[i+1])*(long)(e&127))>>6);
        temparray[i+2] =
            ps[myconnectindex].palette[i+2]+((((long)b-(long)ps[myconnectindex].palette[i+2])*(long)(e&127))>>6);
    }
*/

    //setbrightness(ud.brightness>>2,temparray);
    setpalettefade(r,g,b,e&127);
    if (getrendermode() >= 3) pus = pub = NUMPAGES; // JBF 20040110: redraw the status bar next time
    if ((e&128) == 0) {
        nextpage();
        for (tc = totalclock; totalclock < tc + 4; handleevents(), getpackets() );
    }
}


void drawoverheadmap(long cposx, long cposy, long czoom, short cang)
{
        long i, j, k, l, x1, y1, x2=0, y2=0, x3, y3, x4, y4, ox, oy, xoff, yoff;
        long dax, day, cosang, sinang, xspan, yspan, sprx, spry;
        long xrepeat, yrepeat, z1, z2, startwall, endwall, tilenum, daang;
        long xvect, yvect, xvect2, yvect2;
        short p;
        char col;
        walltype *wal, *wal2;
        spritetype *spr;

        xvect = sintable[(-cang)&2047] * czoom;
        yvect = sintable[(1536-cang)&2047] * czoom;
        xvect2 = mulscale16(xvect,yxaspect);
        yvect2 = mulscale16(yvect,yxaspect);

                //Draw red lines
        for(i=0;i<numsectors;i++)
        {
                if (!(show2dsector[i>>3]&(1<<(i&7)))) continue;

                startwall = sector[i].wallptr;
                endwall = sector[i].wallptr + sector[i].wallnum;

                z1 = sector[i].ceilingz; z2 = sector[i].floorz;

                for(j=startwall,wal=&wall[startwall];j<endwall;j++,wal++)
                {
                        k = wal->nextwall; if (k < 0) continue;

                        //if ((show2dwall[j>>3]&(1<<(j&7))) == 0) continue;
                        //if ((k > j) && ((show2dwall[k>>3]&(1<<(k&7))) > 0)) continue;

                        if (sector[wal->nextsector].ceilingz == z1)
                                if (sector[wal->nextsector].floorz == z2)
                                        if (((wal->cstat|wall[wal->nextwall].cstat)&(16+32)) == 0) continue;

                        col = 139; //red
                        if ((wal->cstat|wall[wal->nextwall].cstat)&1) col = 234; //magenta

                        if (!(show2dsector[wal->nextsector>>3]&(1<<(wal->nextsector&7))))
                                col = 24;
            else continue;

                        ox = wal->x-cposx; oy = wal->y-cposy;
                        x1 = dmulscale16(ox,xvect,-oy,yvect)+(xdim<<11);
                        y1 = dmulscale16(oy,xvect2,ox,yvect2)+(ydim<<11);

                        wal2 = &wall[wal->point2];
                        ox = wal2->x-cposx; oy = wal2->y-cposy;
                        x2 = dmulscale16(ox,xvect,-oy,yvect)+(xdim<<11);
                        y2 = dmulscale16(oy,xvect2,ox,yvect2)+(ydim<<11);

                        drawline256(x1,y1,x2,y2,col);
                }
        }

                //Draw sprites
        k = ps[screenpeek].i;
        for(i=0;i<numsectors;i++)
        {
                if (!(show2dsector[i>>3]&(1<<(i&7)))) continue;
                for(j=headspritesect[i];j>=0;j=nextspritesect[j])
                        //if ((show2dsprite[j>>3]&(1<<(j&7))) > 0)
                        {
                spr = &sprite[j];

                if (j == k || (spr->cstat&0x8000) || spr->cstat == 257 || spr->xrepeat == 0) continue;

                                col = 71; //cyan
                                if (spr->cstat&1) col = 234; //magenta

                                sprx = spr->x;
                                spry = spr->y;

                if( (spr->cstat&257) != 0) switch (spr->cstat&48)
                                {
                    case 0: break;

                                                ox = sprx-cposx; oy = spry-cposy;
                                                x1 = dmulscale16(ox,xvect,-oy,yvect);
                                                y1 = dmulscale16(oy,xvect2,ox,yvect2);

                                                ox = (sintable[(spr->ang+512)&2047]>>7);
                                                oy = (sintable[(spr->ang)&2047]>>7);
                                                x2 = dmulscale16(ox,xvect,-oy,yvect);
                                                y2 = dmulscale16(oy,xvect,ox,yvect);

                                                x3 = mulscale16(x2,yxaspect);
                                                y3 = mulscale16(y2,yxaspect);

                                                drawline256(x1-x2+(xdim<<11),y1-y3+(ydim<<11),
                                                                                x1+x2+(xdim<<11),y1+y3+(ydim<<11),col);
                                                drawline256(x1-y2+(xdim<<11),y1+x3+(ydim<<11),
                                                                                x1+x2+(xdim<<11),y1+y3+(ydim<<11),col);
                                                drawline256(x1+y2+(xdim<<11),y1-x3+(ydim<<11),
                                                                                x1+x2+(xdim<<11),y1+y3+(ydim<<11),col);
                        break;

                    case 16:
                        if( spr->picnum == LASERLINE )
                        {
                            x1 = sprx; y1 = spry;
                            tilenum = spr->picnum;
                            xoff = (long)((signed char)((picanm[tilenum]>>8)&255))+((long)spr->xoffset);
                            if ((spr->cstat&4) > 0) xoff = -xoff;
                            k = spr->ang; l = spr->xrepeat;
                            dax = sintable[k&2047]*l; day = sintable[(k+1536)&2047]*l;
                            l = tilesizx[tilenum]; k = (l>>1)+xoff;
                            x1 -= mulscale16(dax,k); x2 = x1+mulscale16(dax,l);
                            y1 -= mulscale16(day,k); y2 = y1+mulscale16(day,l);

                            ox = x1-cposx; oy = y1-cposy;
                            x1 = dmulscale16(ox,xvect,-oy,yvect);
                            y1 = dmulscale16(oy,xvect2,ox,yvect2);

                            ox = x2-cposx; oy = y2-cposy;
                            x2 = dmulscale16(ox,xvect,-oy,yvect);
                            y2 = dmulscale16(oy,xvect2,ox,yvect2);

                            drawline256(x1+(xdim<<11),y1+(ydim<<11),
                                                                                x2+(xdim<<11),y2+(ydim<<11),col);
                        }

                        break;

                    case 32:

                                                tilenum = spr->picnum;
                                                xoff = (long)((signed char)((picanm[tilenum]>>8)&255))+((long)spr->xoffset);
                                                yoff = (long)((signed char)((picanm[tilenum]>>16)&255))+((long)spr->yoffset);
                                                if ((spr->cstat&4) > 0) xoff = -xoff;
                                                if ((spr->cstat&8) > 0) yoff = -yoff;

                                                k = spr->ang;
                                                cosang = sintable[(k+512)&2047]; sinang = sintable[k];
                                                xspan = tilesizx[tilenum]; xrepeat = spr->xrepeat;
                                                yspan = tilesizy[tilenum]; yrepeat = spr->yrepeat;

                                                dax = ((xspan>>1)+xoff)*xrepeat; day = ((yspan>>1)+yoff)*yrepeat;
                                                x1 = sprx + dmulscale16(sinang,dax,cosang,day);
                                                y1 = spry + dmulscale16(sinang,day,-cosang,dax);
                                                l = xspan*xrepeat;
                                                x2 = x1 - mulscale16(sinang,l);
                                                y2 = y1 + mulscale16(cosang,l);
                                                l = yspan*yrepeat;
                                                k = -mulscale16(cosang,l); x3 = x2+k; x4 = x1+k;
                                                k = -mulscale16(sinang,l); y3 = y2+k; y4 = y1+k;

                                                ox = x1-cposx; oy = y1-cposy;
                                                x1 = dmulscale16(ox,xvect,-oy,yvect);
                                                y1 = dmulscale16(oy,xvect2,ox,yvect2);

                                                ox = x2-cposx; oy = y2-cposy;
                                                x2 = dmulscale16(ox,xvect,-oy,yvect);
                                                y2 = dmulscale16(oy,xvect2,ox,yvect2);

                                                ox = x3-cposx; oy = y3-cposy;
                                                x3 = dmulscale16(ox,xvect,-oy,yvect);
                                                y3 = dmulscale16(oy,xvect2,ox,yvect2);

                                                ox = x4-cposx; oy = y4-cposy;
                                                x4 = dmulscale16(ox,xvect,-oy,yvect);
                                                y4 = dmulscale16(oy,xvect2,ox,yvect2);

                                                drawline256(x1+(xdim<<11),y1+(ydim<<11),
                                                                                x2+(xdim<<11),y2+(ydim<<11),col);

                                                drawline256(x2+(xdim<<11),y2+(ydim<<11),
                                                                                x3+(xdim<<11),y3+(ydim<<11),col);

                                                drawline256(x3+(xdim<<11),y3+(ydim<<11),
                                                                                x4+(xdim<<11),y4+(ydim<<11),col);

                                                drawline256(x4+(xdim<<11),y4+(ydim<<11),
                                                                                x1+(xdim<<11),y1+(ydim<<11),col);

                                                break;
                                }
                        }
        }

                //Draw white lines
        for(i=0;i<numsectors;i++)
        {
                if (!(show2dsector[i>>3]&(1<<(i&7)))) continue;

                startwall = sector[i].wallptr;
                endwall = sector[i].wallptr + sector[i].wallnum;

                k = -1;
                for(j=startwall,wal=&wall[startwall];j<endwall;j++,wal++)
                {
                        if (wal->nextwall >= 0) continue;

                        //if ((show2dwall[j>>3]&(1<<(j&7))) == 0) continue;

                        if (tilesizx[wal->picnum] == 0) continue;
                        if (tilesizy[wal->picnum] == 0) continue;

                        if (j == k)
                                { x1 = x2; y1 = y2; }
                        else
                        {
                                ox = wal->x-cposx; oy = wal->y-cposy;
                                x1 = dmulscale16(ox,xvect,-oy,yvect)+(xdim<<11);
                                y1 = dmulscale16(oy,xvect2,ox,yvect2)+(ydim<<11);
                        }

                        k = wal->point2; wal2 = &wall[k];
                        ox = wal2->x-cposx; oy = wal2->y-cposy;
                        x2 = dmulscale16(ox,xvect,-oy,yvect)+(xdim<<11);
                        y2 = dmulscale16(oy,xvect2,ox,yvect2)+(ydim<<11);

                        drawline256(x1,y1,x2,y2,24);
                }
        }

         for(p=connecthead;p >= 0;p=connectpoint2[p])
         {
          if(ud.scrollmode && p == screenpeek) continue;

          ox = sprite[ps[p].i].x-cposx; oy = sprite[ps[p].i].y-cposy;
                  daang = (sprite[ps[p].i].ang-cang)&2047;
                  if (p == screenpeek) { ox = 0; oy = 0; daang = 0; }
                  x1 = mulscale(ox,xvect,16) - mulscale(oy,yvect,16);
                  y1 = mulscale(oy,xvect2,16) + mulscale(ox,yvect2,16);

          if(p == screenpeek || ud.coop == 1 )
          {
                if(sprite[ps[p].i].xvel > 16 && ps[p].on_ground)
                    i = APLAYERTOP+((totalclock>>4)&3);
                else
                    i = APLAYERTOP;

                j = klabs(ps[p].truefz-ps[p].posz)>>8;
                j = mulscale(czoom*(sprite[ps[p].i].yrepeat+j),yxaspect,16);

                if(j < 22000) j = 22000;
                else if(j > (65536<<1)) j = (65536<<1);

                rotatesprite((x1<<4)+(xdim<<15),(y1<<4)+(ydim<<15),j,
                    daang,i,sprite[ps[p].i].shade,sprite[ps[p].i].pal,
                    (sprite[ps[p].i].cstat&2)>>1,windowx1,windowy1,windowx2,windowy2);
          }
         }
}



void endanimsounds(long fr)
{
    switch(ud.volume_number)
    {
        case 0:break;
        case 1:
            switch(fr)
            {
                case 1:
                    sound(WIND_AMBIENCE);
                    break;
                case 26:
                    sound(ENDSEQVOL2SND1);
                    break;
                case 36:
                    sound(ENDSEQVOL2SND2);
                    break;
                case 54:
                    sound(THUD);
                    break;
                case 62:
                    sound(ENDSEQVOL2SND3);
                    break;
                case 75:
                    sound(ENDSEQVOL2SND4);
                    break;
                case 81:
                    sound(ENDSEQVOL2SND5);
                    break;
                case 115:
                    sound(ENDSEQVOL2SND6);
                    break;
                case 124:
                    sound(ENDSEQVOL2SND7);
                    break;
            }
            break;
        case 2:
            switch(fr)
            {
                case 1:
                    sound(WIND_REPEAT);
                    break;
                case 98:
                    sound(DUKE_GRUNT);
                    break;
                case 82+20:
                    sound(THUD);
                    sound(SQUISHED);
                    break;
                case 104+20:
                    sound(ENDSEQVOL3SND3);
                    break;
                case 114+20:
                    sound(ENDSEQVOL3SND2);
                    break;
                case 158:
                    sound(PIPEBOMB_EXPLODE);
                    break;
            }
            break;
    }
}

void logoanimsounds(long fr)
{
    switch(fr)
    {
        case 1:
            sound(FLY_BY);
            break;
        case 19:
            sound(PIPEBOMB_EXPLODE);
            break;
    }
}

void intro4animsounds(long fr)
{
    switch(fr)
    {
        case 1:
            sound(INTRO4_B);
            break;
        case 12:
        case 34:
            sound(SHORT_CIRCUIT);
            break;
        case 18:
            sound(INTRO4_5);
            break;
    }
}

void first4animsounds(long fr)
{
    switch(fr)
    {
        case 1:
            sound(INTRO4_1);
            break;
        case 12:
            sound(INTRO4_2);
            break;
        case 7:
            sound(INTRO4_3);
            break;
        case 26:
            sound(INTRO4_4);
            break;
    }
}

void intro42animsounds(long fr)
{
    switch(fr)
    {
        case 10:
            sound(INTRO4_6);
            break;
    }
}




void endanimvol41(long fr)
{
    switch(fr)
    {
        case 3:
            sound(DUKE_UNDERWATER);
            break;
        case 35:
            sound(VOL4ENDSND1);
            break;
    }
}

void endanimvol42(long fr)
{
    switch(fr)
    {
        case 11:
            sound(DUKE_UNDERWATER);
            break;
        case 20:
            sound(VOL4ENDSND1);
            break;
        case 39:
            sound(VOL4ENDSND2);
            break;
        case 50:
            FX_StopAllSounds();
            break;
    }
}

void endanimvol43(long fr)
{
    switch(fr)
    {
        case 1:
            sound(BOSS4_DEADSPEECH);
            break;
        case 40:
            sound(VOL4ENDSND1);
            sound(DUKE_UNDERWATER);
            break;
        case 50:
            sound(BIGBANG);
            break;
    }
}


void playanm(char *fn,char t)
{
        char *animbuf, *palptr;
    long i, j, k, length=0, numframes=0;
    int32 handle=-1;

//    return;

    if(t != 7 && t != 9 && t != 10 && t != 11)
        KB_FlushKeyboardQueue();

    if( KB_KeyWaiting() )
    {
        FX_StopAllSounds();
        goto ENDOFANIMLOOP;
    }

        handle = kopen4load(fn,0);
        if(handle == -1) return;
        length = kfilelength(handle);

    walock[TILE_ANIM] = 219+t;

        allocache((long *)&animbuf,length,&walock[TILE_ANIM]);

    tilesizx[TILE_ANIM] = 200;
    tilesizy[TILE_ANIM] = 320;

        kread(handle,animbuf,length);
        kclose(handle);

        ANIM_LoadAnim (animbuf);
        numframes = ANIM_NumFrames();

        palptr = ANIM_GetPalette();
        for(i=0;i<256;i++)
        {
            /*
                j = (i<<2); k = j-i;
                tempbuf[j+0] = (palptr[k+2]>>2);
                tempbuf[j+1] = (palptr[k+1]>>2);
                tempbuf[j+2] = (palptr[k+0]>>2);
                tempbuf[j+3] = 0;
                */
            j = i*3;
                tempbuf[j+0] = (palptr[j+0]>>2);
                tempbuf[j+1] = (palptr[j+1]>>2);
                tempbuf[j+2] = (palptr[j+2]>>2);
        }

        //setpalette(0L,256L,tempbuf);
        //setbrightness(ud.brightness>>2,tempbuf,2);
        setgamepalette(&ps[myconnectindex],tempbuf,2);

    ototalclock = totalclock + 10;

        for(i=1;i<numframes;i++)
        {
       while(totalclock < ototalclock)
       {
          if( KB_KeyWaiting() )
              goto ENDOFANIMLOOP;
           handleevents(); getpackets();
       }

       if(t == 10) ototalclock += 14;
       else if(t == 9) ototalclock += 10;
       else if(t == 7) ototalclock += 18;
       else if(t == 6) ototalclock += 14;
       else if(t == 5) ototalclock += 9;
       else if(ud.volume_number == 3) ototalclock += 10;
       else if(ud.volume_number == 2) ototalclock += 10;
       else if(ud.volume_number == 1) ototalclock += 18;
       else                           ototalclock += 10;

       waloff[TILE_ANIM] = FP_OFF(ANIM_DrawFrame(i));
       invalidatetile(TILE_ANIM, 0, 1<<4);  // JBF 20031228
       rotatesprite(0<<16,0<<16,65536L,512,TILE_ANIM,0,0,2+4+8+16+64, 0,0,xdim-1,ydim-1);
       nextpage();

       if(t == 8) endanimvol41(i);
       else if(t == 10) endanimvol42(i);
       else if(t == 11) endanimvol43(i);
       else if(t == 9) intro42animsounds(i);
       else if(t == 7) intro4animsounds(i);
       else if(t == 6) first4animsounds(i);
       else if(t == 5) logoanimsounds(i);
       else if(t < 4) endanimsounds(i);
        }

    ENDOFANIMLOOP:

    ANIM_FreeAnim ();
    walock[TILE_ANIM] = 1;
}

/*
 * vim:ts=4:sw=4:tw=8:enc=utf-8:
 */

int GetMusicFiles(void)                                              // wxmc
{
    short i, j, x = MusicNum;

    if (x == 0)
    {
        clearfilenames();
        strcpy(tempbuf, MusicFolder);
        getfilenames(tempbuf,"*.mid",1);
        MusicList = currentlist;
        while (findfiles)
        {
              Bsprintf(tempbuf,"%s%s", MusicFolder, findfiles->name);
              strcpy(MusicFiles[x], tempbuf);
              x++;
              if (x > 300)
                  break;
              findfiles = findfiles->next;
        }
        if (x < 295)
        {
            strcpy(tempbuf, MusicFolder);
            getfilenames(tempbuf,"*.ogg",1);                             // wxog
            if (MusicList == 0)
                MusicList = currentlist;
            while (findfiles)
               {
                  Bsprintf(tempbuf,"%s%s", MusicFolder, findfiles->name);
                  strcpy(MusicFiles[x], tempbuf);
                  x++;
                  if (x > 300)
                      break;
                  findfiles = findfiles->next;
               }
        }
        if (x < 295)
        {
            strcpy(tempbuf, MusicFolder);
            getfilenames(tempbuf,"*.wav",1);                             // wxog
            if (MusicList == 0)
                MusicList = currentlist;
            while (findfiles)
               {
                  Bsprintf(tempbuf,"%s%s", MusicFolder, findfiles->name);
                  strcpy(MusicFiles[x], tempbuf);
                  x++;
                  if (x > 300)
                      break;
                  findfiles = findfiles->next;
               }
        }
    }

    if (x > 0)
    {
       MusicNum = x;
       j = GetRandom(x);
       x = j;
    }

    currentlist = MusicList;

    return x;
}

int GetRandom(short num)                                             // wxmc
{
    short i, j=0;
    time_t t;

    for (i=0; i<100; i++)
        {
        srand((unsigned) time(&t));
        j = rand()&num;
        if (j >= num)
            j = num - 1;
        if (j > 0 && j != iLast)
            break;
        }
    iLast = j;
    return  j;
}


