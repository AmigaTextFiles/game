//-------------------------------------------------------------------------
/*                              gamep.h
                  Additional code for Duke3dw by ProAsm
                 Created June 2009 for MinGW compiling etc
*/
//-------------------------------------------------------------------------
/*
Watcom 1.8 changes:

1. Remark out boolen in rpcndr.h line 40
2. Remove #define WIN32_LEAN_AND_MEAN in compat.c line 16

    -Wno-packed-bitfield-compat
    -Wno-mudflap

Logo  Brett Salsbury - DISRUPTOR
doom5duke10@hotmail.com

//-------------------------------------------------------------------------
DNBLUKEY - adds the Blue key.
DNREDKEY - adds the Red key.
DNYELKEY - adds the Yellow key.
DNGOD - God mode
DNGUN#
Where # =
2 - Adds pistol with 20 ammo
3 - Adds shotgun with 10 ammo
4 - Adds chaingun with 20 ammo
5 - Adds rpg with 5 ammo
6 - Adds handbomb with 6 ammo
7 - Adds shrinker with 5 ammo
8 - Adds devistator with 10 ammo
9 - Adds lazermines with 3 ammo
0 - Adds freezer with 10 ammo

DNFLY - Adds jetpack with 25% flight
DNMEDIC - Adds healthbox with 25% health
DNSWIM - Adds scuba tanks with 25% air

HRP loading process..........................
1. Search for duke3d_hrp.zip
2. If (1) not found, search for duke3d_lrp.zip
3. If (1) or (2) not found, search for Highres/duke3d_hrp.def
4. If (1), (2) or (3) not found, search for Lowres/duke3d_lrp.def

*/
//-------------------------------------------------------------------------
// hicsetpalettetint(30, red[offset], grn[offset], blu[offset], 0);
//
// Host     P2P: Duke3dw.exe /name Nick /net /n1 192.168.0.5
// Client   P2P: Duke3dw.exe /name Nick /net 192.168.0.1 /n1
// Master/Slave: Duke3dw.exe /name Nick /net /n0:4
// Slave/Master: Duke3dw.exe /name Nick /net /n0 192.168.0.1
//
/*
 -col #
0   = Auto
9   = Blue
10  = Red
11  = Olive
12  = White
13  = Grey
14  = Green
15  = Brown
16  = Navy
23  = Yellow
*/

#ifndef _WIN32
#include <sys/stat.h>
#include <unistd.h>
#endif

#define d3wver "4.2.2"
#define d3wrev " - Revision  331.262.85"  //build/duke/jaudiolib
#define d3wcop "By ProAsm - http://www.proasm.com\n"

char **HEAD2W = "Duke3dw - Version "d3wver;
char Userconfilename[128];
char Addonconfilename[128];
char MapsPlayed[2000][40];

char mename[128];
char mypath[128];

int sbak;

int32 bGrp = 0;
int32 bMap = 0;
int32 bFake = 0;
int32 bHost = 0;
short iLowres = 0;

char *svgame[40];
char *bf[128];
char UserAddon[64];
char Mapname[64];
char MapMusic[128];
char MapMusicPath[128];
char boardmapname[80] = {0};
long autotick=0;
short iJet=0, iMedic=0, iTank=0;

int NoHrp;
int DnwGrp;
static char *userdef = "";
long save_totalclock;

extern int   is_vista;
extern int   MusicDir;
extern char  MusicFiles[301][32];
extern char  MusicName[128];

extern char  MusicFolder[80];
extern char  MapsFolder[80];
extern char  GameFolder[80];

extern int   Mapnum;
extern char  MenuMap[80];
extern char  MenuMusic[80];
extern char  MenuGame[80];
extern char  GameMap[40];

extern short UserSavenum;
extern short iDedicated;
extern short iLevelNum;
extern short iSkill;
extern short iSpawn;
extern short iType;
extern short iColr;

extern char  Botname[8][32];
extern char  IPAddress[32];
extern short SelectMulti;
extern short HostMulti;
extern short FakePlayer;
extern short NumBots;
extern short PlayerNum;

const char **argvline;

//-------------------------------------------------------------------------

void microtext(int x, int y, char *t, long p, short sb)
{
    short ac;
    char ch;

	if (!Bstrncasecmp(t, "0", 1))
        return;

	sb &= 255;

    while(*t)
    {
        ch = Btoupper(*t);
        if (ch == 32) {x += 5; t++; continue;}
        else
            ac = ch - '!' + MINIFONT;

		rotatesprite(sbarx(x),sbary(y),sbarsc(32768L),0,ac,0,p,sb,0,0,xdim-1,ydim-1);
        x += 2;
        t++;
    }
}

void smalltext(int x, int y, char *t, long p, short sb)
{
    short ac;
    char ch;

	if (!Bstrncasecmp(t, "0", 1))
        return;

	sb &= 255;

    while(*t)
    {
        ch = Btoupper(*t);
        if (ch == 32) {x += 5; t++; continue;}
        else
            ac = ch - '!' + MINIFONT;

		rotatesprite(sbarx(x),sbary(y),sbarsc(52000L),0,ac,0,p,sb,0,0,xdim-1,ydim-1);
        x += 3;
        t++;
    }
}

void UpdateMiniBarWeapons(struct player_struct *p, short Weapnum)    // wxwp
{
    short i, x, y;
    int   weaps[10] = {21, 28, 22, 23, 26, 25, 29, 27, 24, 32};
    int   wsize[10] = {20000,14000,15000,15000,8000,12000,18000,22000,18000,12000};
    short xp[10] = {124,146,168,192,212,232,256,278,300,212};
    int   wp[10], wc[10];
    float f;

    if (!ud.weaponicons)
        return;

    if (Weapnum == 11)     // expander
        Weapnum = 6;       // show shrinker

    for (i=0; i<10; i++)
    {
        f = ud.statusbarscale;
        f = f / 100;
        f = wsize[i] * f;
        wsize[i] = f;
        wp[i] = 32;
        wc[i] = 0;
        if (p->gotweapon[i])
        {
           if (p->ammo_amount[i] > 0)
           {
              wp[i] = 22;
              wc[i] = 14;
           }
        }
    }
    if  (Weapnum > 0 && Weapnum < 10)
    {
        wp[Weapnum] = 0;
        wc[Weapnum] = 13;
    }

    // rotatesprite(long sx, long sy, long z, short a, short picnum, signed char dashade, char dapalnum, char dastat, long cx1, long cy1, long cx2, long cy2)
    // Pistol
    x = 120;
    y = 191;
        rotatesprite(sbarx(x),sbary(y+1),wsize[0], 0, weaps[0],   wp[1], wc[1], 10+16, 0, 0, xdim - 1, ydim - 1);
    // Shotgun
    x = 139;
    y = 192;
        rotatesprite(sbarx(x),sbary(y+1),wsize[1], 0, weaps[1],  wp[2], wc[2], 10+16, 0, 0, xdim - 1, ydim - 1);
    // Chaingun
    x = 162;
    y = 191;
        rotatesprite(sbarx(x),sbary(y),wsize[2], 0, weaps[2], wp[3], wc[3], 10+16, 0, 0, xdim - 1, ydim - 1);
    // RPG
    x = 186;
    y = 192;
        rotatesprite(sbarx(x),sbary(y),wsize[3], 0, weaps[3],   wp[4], wc[4], 10+16, 0, 0, xdim - 1, ydim - 1);
    // Handbomb
    x = 208;
    y = 191;
        rotatesprite(sbarx(x),sbary(y+1),wsize[4], 0, weaps[4], wp[5], wc[5], 10+16, 0, 0, xdim - 1, ydim - 1);
    // Shrinker
    x = 225;
    y = 192;
    if (p->curr_weapon == GROW_WEAPON) // Expander
    {
        y = 189;
        rotatesprite(sbarx(x),sbary(y),wsize[9], 0, weaps[9], wp[6], wc[6], 10+16, 0, 0, xdim - 1, ydim - 1);
    }
    else
        rotatesprite(sbarx(x),sbary(y),wsize[5], 0, weaps[5], wp[6], wc[6], 10+16, 0, 0, xdim - 1, ydim - 1);
    // Devistator
    x = 247;
    y = 191;
        rotatesprite(sbarx(x),sbary(y),wsize[6], 0, weaps[6], wp[7], wc[7], 10+16, 0, 0, xdim - 1, ydim - 1);
    // Lazermine
    x = 274;
    y = 192;
        rotatesprite(sbarx(x),sbary(y),wsize[7], 0, weaps[7], wp[8], wc[8], 10+16, 0, 0, xdim - 1, ydim - 1);
    // Freezer
    x = 291;
    y = 190;
       rotatesprite(sbarx(x),sbary(y),wsize[8], 0, weaps[8],   wp[9], wc[9], 10+16, 0, 0, xdim - 1, ydim - 1);

    for (i=0; i<9; i++)
    {
         sprintf(bf, "%d", p->ammo_amount[i+1]);
         x = 22;
         if (Weapnum == i+1)
             x = 6;
         microtext(xp[i],193,bf,x,10+16+256);
    }
}

int CheckScreenMode(void)                                           // wierd - must stay
{
    if (DnwGrp == 0 || ScreenBPP == 8 || usehightile == 0)
        ud.weaponicons = 1;
    return 0;
}

void extractnames(char *pth, char *nm)                               // wxxt
{
    char tmp[128];
    int k;

    tmp[0] = 0;

    if (strchr(pth, '/') == 0)
    {
       if (strchr(pth, '\\') == 0)
           strcpy(tmp, pth);
       else
           strcpy(tmp, strrchr(pth, '\\')+1);
    }
    else
    {
       strcpy(tmp, strrchr(pth, '/')+1);
    }

    strcpy(nm, tmp);
    k = strlen(pth) - strlen(tmp);
    pth[k] = 0;
}

void checkforsaves(char *pth)                                        // wxhp
{
    char tmp[40];
    char mp[6];
    int i;

    strcpy(mypath, pth);
    extractnames(mypath, tmp);
    if (tmp[0] == 0)
        strcpy(tmp, mypath);
    dolower(&tmp);

    if (strstr(tmp, ".grp") || strstr(tmp, ".zip") || (strstr(tmp, ".map") && !bGrp))
    {
        mp[0] = 0;
        if (strstr(tmp, ".map"))
            strcpy(mp, "map-");
        i = strlen(tmp);
        tmp[i-4] = 0;
        sprintf(svgame, "Saves/%s%s-", mp, tmp);

#ifdef _WIN32
        CreateDirectory("Saves", NULL);
#else
        mkdir("Saves", 0777);
#endif
    }
}

void checkforextras(char *pth)                                       // wxhp
{
    char *tmp = pth;
    char px[128];
    int i, k, x;

    dolower(pth);      // convert to lower case                      // wxdl

    if (Bstrncasecmp(tmp, "nam.grp", 7) == 0)                        // wxnm
    {
        NoHrp = 1;
        gametype = 1;
		initprintf("Copyright (c) 1998 GT Interactive. (c) 1996 3D Realms Entertainment\n");
		initprintf("NAM modifications by Matt Saettler\n");
	}

    k = strstr(tmp, ".map");
    if (bGrp && k > 0)                      // incase a .grp has a -map
        return;

    if (strchr(pth,'.') != 0)               // look for .
    {
       strcpy(mypath, pth);
       extractnames(mypath, mename);

       for (i=0; i<128; i++)
            px[i] = 0;
       strcpy(px, mename);
       x = strlen(mename);
       px[x-4] = 0;
       strcat(px, "_hrp.zip");
       k = initgroupfile(px);               // check for TCName/MapName.hrp
       if (k >= 0)
       {
           initprintf("Adding Custom Hrp: %s\n", px);
           for (i=0; i<128; i++)
                px[i] = 0;
           strcpy(px, mename);
           px[x-4] = 0;
           strcat(px, ".def");
           if (!getdeffile(px,0))   // check for custom TCName/MapName.def
               initprintf("Adding Custom Def: %s\n", px);
       }

       for (i=0; i<128; i++)
            px[i] = 0;
       strcpy(px, mename);
       px[x-4] = 0;
       strcat(px, "_addon.zip");
       k = initgroupfile(px);               // check for TCName_addon.zip
       if (k >= 0)
       {
           initprintf("Adding Custom TC_Addon: %s\n", px);
           for (i=0; i<128; i++)
                px[i] = 0;
           strcpy(px, mename);
           px[x-4] = 0;
           strcat(px, "_addon.con");
           tmp = px;
           if (strchr(tmp, '/') != 0)
               strcpy(Addonconfilename, strrchr(tmp, '/')+1);
           else
           if (strchr(tmp, '\\') != 0)
               strcpy(Addonconfilename, strrchr(tmp, '\\')+1);
           else
               strcpy(Addonconfilename, tmp);
           i = kopen4load(Addonconfilename, 0);
           if (i == -1)
               Addonconfilename[0] = 0;
           kclose(i);
       }

       for (i=0; i<128; i++)
            px[i] = 0;
       strcpy(px, mename);
       px[x-4] = 0;
       strcat(px, ".RTS");
       k = kopen4load(px, 0);               // check for tcname or mapname .rts
       if (k >= 0)
           strcpy(ud.rtsname, px);
       kclose(k);
    }
}

// typ: 0 = -g (grp) | 1 = -x (con) | 2 = -h (def) | 3 = -map | 4 = path only | 5 = music
void checksearchpath(char *pth, int typ)                             // wxph
{
    unsigned char ph[128];
    unsigned char px[128];
    unsigned char nm[128];
    int i, j, k, x;

    px[0] = 0;
    nm[0] = 0;

    if (strchr(pth,'\\') != 0 || strchr(pth,'/') != 0)
    {
        for (i=0; i<128; i++)
        {
            px[i] = 0;
            ph[i] = 0;
            nm[i] = 0;
        }

        strcpy(ph, pth);
        x = strlen(pth);

        for (i=x; i>0; i--)
        {
            if (ph[i] == '\\' || ph[i] == '/')
                break;
        }

        for (j=0; j<i; j++)
        {
            px[j] = ph[j];          // extract the path
        }

        addsearchpath(px);

        i++;
        k = 0;
        for (j=i; j<x; j++)
        {
            nm[k] = ph[j];          // extract the name
            k++;
        }
    }
    else
    {
        strcpy(nm, pth);
    }

    if (typ == 0)     // addon
    {
        strcpy(UserAddon, nm);
        return;
    }

    if (typ == 3)     // mapname
    {
        strcpy(Mapname, nm);
        return;
    }

    if (typ == 4)     // path only
        return;

    if (typ == 5)                                                 // wxmx -music
    {

       x = strlen(nm);
       if (px[0] == 0)
       {
           addsearchpath("music");
           sprintf(bf, "music/%s", nm);
       }
       else
           sprintf(bf, "%s/%s", px, nm);
       i = kopen4load(bf, 0);            // check if it exists
       if (i != -1 && MapMusic[0] == 0)
       {
           strcpy(MapMusicPath, px);     // path or null
           strcat(MapMusicPath, "/");                                // wxmf
           strcpy(MapMusic, nm);         // music file
           strcpy(MusicName, MapMusicPath);
           strcat(MusicName, nm);
       }
       kclose(i);
    }
}

void VerifyConfiles(void)
{
    int i;

    if (Userconfilename[0] != 0)                                      // wxcf
    {
        i = kopen4load(Userconfilename, 0);
        if (i == -1)
        {
            i = strlen(Userconfilename);
            Userconfilename[i-4] = 0;
            strcat(Userconfilename, ".gam");                         // some have .gam
            i = kopen4load(Userconfilename, 0);
            if (i != -1)
            {
                strcpy(confilename, Userconfilename);
            }
        }
        else
        {
            strcpy(confilename, Userconfilename);
        }
        kclose(i);
    }
    if (Addonconfilename[0] != 0)                                     // wxcf
    {
        i = kopen4load(Addonconfilename, 0);
        if (i != -1)
        {
            strcpy(confilename, Addonconfilename);
        }
        kclose(i);
    }
    if (confilename[0] != 0)                                          // wxcf
    {
        i = kopen4load(confilename, 0);
        if (i == -1)
        {
            confilename = "game.con";
        }
        kclose(i);
    }
}

void getboardmapname(char *sMap)                                          // wxmp
{

    if (strchr(sMap, '/') == 0)
    {
       if (strchr(sMap, '\\') == 0)
           strcpy(boardmapname, sMap);
       else
           strcpy(boardmapname, strrchr(sMap, '\\')+1);
    }
    else
       strcpy(boardmapname, strrchr(sMap, '/')+1);
}

void PauseAction(void)
{
    ready2send = 0;
    save_totalclock = totalclock;
}

void ResumeAction(void)
{
    ready2send = 1;
    totalclock = save_totalclock;
}


void AutoSaveGame(short disp)                                        // wxas
{
    long x;

    if (ud.multimode < 2 && ud.autosave > 0)
    {
        if (disp == 1)
        {
           strcpy(fta_quotes[122],"AUTOSAVED GAME");
           FTA(122,&ps[myconnectindex]);
        }
        autotick = totalclock + 200;   // 1.7 second delay
        ud.autodone = 1;
    }
}

void DelayedAutoSave(void)                                           // wxas
{
    if (totalclock >= autotick && autotick > 0)
    {
        autotick = 0;
        PauseAction();
        screencapt = 1;
        displayrooms(myconnectindex,65536);
        screencapt = 0;
        saveplayer(10);
        ResumeAction();
    }
}

int DeleteAutosave(short iEnd, char *asv)                            // wxas
{
    FILE *fil;

    fil = kopen4load(asv, 0);
    if (fil)
    {
        kclose(fil);
        
#ifdef _WIN32
        DeleteFile(asv);
#else
        unlink(asv);
#endif

        if (iEnd == 1 && ud.multimode < 2 && numplayers < 2)
            initprintf("  - Game End: Autosave deleted.\n");
    }
    return 0;
}

long SetupUserMap()
{
    long i;
    char mp[40];

    SetLastPlayed(MenuMap, 1);

    mp[0] = 0;
    if (MenuMusic[0] != 0)
        sprintf(mp,"-music %s%s", MusicFolder, MenuMusic);
    sprintf(bf, "Duke3dw.exe -map %s/%s -s%d %s", MapsFolder, MenuMap, iSkill, mp);
    argvline = strdup(bf);
    i = SetCommandLine(argvline);
    return i;
}

long SetupUserGame(int gnum)
{
    long i;
    char *con[4];
    char mp[40];
    char mu[80];
    char sBuff[80];
    char gf[80];
    char *gn[6];

    gn[0] = 0;
    if (gnum >= 0)
    {
        if (gnum == 10)
            sprintf(gn, " -asv");
        else
            sprintf(gn, " -%d", gnum);
    }

    i = strlen(MenuGame);   // .grp or .zip
    if (i > 4)
    {
       SetLastPlayed(MenuGame, 0);

       strcpy(sBuff, MenuGame);
       sBuff[i-4] = 0;
       mp[0] = 0;
       mu[0] = 0;

       strcpy(con, "gam");

       sprintf(bf, "%s\\%s.gam", GameFolder, sBuff);

       i = kopen4load(bf,0);       // if a .gam file does not exist
       if (i == -1)
           strcpy(con, "con");     // make it a standard .con
       kclose(i);

       if (MenuMusic[0] != 0)
           sprintf(mu," -music %s%s", MusicFolder, MenuMusic);

       if (strlen(GameMap) > 4)
           sprintf(mp," -map %s -s%d", GameMap, iSkill);

       gf[0] = 0;
       if (GameFolder[0] != 0)
           sprintf(gf, "-j%s ", GameFolder);

       sprintf(bf, "Duke3dw.exe %s-g%s -x%s.%s%s%s%s", gf, MenuGame, sBuff, con, mu, mp, gn);
       argvline = strdup(bf);
       i = SetCommandLine(argvline);
       return i;
    }
    return 0;
}

long SetupUserLevel(short lnum)
{
    long v, i;
    char ubuf[40];

    ubuf[0] = 0;
    if (MenuMusic[0] != 0)
        sprintf(ubuf, " -music %s%s ", MusicFolder, MenuMusic);

    v = 1;
    i = lnum;
    if (lnum > 8)              // lnum = 9
    {
        lnum += 3;             // lnum = 12
        v = lnum / 11;         // v = 12 / 11 = 1
        i = lnum - (v * 11);   // i = 12 - (1 * 11) = 1
        v++;                   // v = 2;
        if (i == 0)
        {
            v--;
            i = 11;
        }
    }
    sprintf(bf, "Duke3dw.exe %s-v%d -l%d -s%d", ubuf, v, i, iSkill);
    argvline = strdup(bf);
    i = SetCommandLine(argvline);
    return i;
}

long SetupUserSavedGame(short snum)
{
    long i;
    char ubuf[40];

    if (MenuGame[0] != 0)
        return SetupUserGame(snum);

    ubuf[0] = 0;
    if (MenuMusic[0] != 0)
        sprintf(ubuf, " -music %s%s ", MusicFolder, MenuMusic);

    if (snum == 10)
        sprintf(bf, "Duke3dw.exe -asv");                             // wxas
    else
        sprintf(bf, "Duke3dw.exe %s-%d", ubuf, snum);
    argvline = strdup(bf);
    i = SetCommandLine(argvline);
    return i;
}

long RemoveMapInfo(long argx)
{
    char xbuf[128];
    short i;

    argvline = NULL;
    strcpy(xbuf, _buildargv[0]);
    for (i=3; i<argx; i++)
    {
         strcat(xbuf, " ");
         strcat(xbuf, _buildargv[i]);
    }

    sprintf(bf, "%s", xbuf);
    argvline = strdup(bf);

    if (strlen(bf) > 20)
    {
        argx = SetCommandLine(argvline);
        _buildargc = argx;
    }

    return argx;
}

int DetectShareware(void)
{
    long L;                                                          // wxsr
    int  h;

    h = kopen4load("duke3d.grp", 0);      // retail 13 = 26524524 | retail 15 = 44356548 | shareware = 11035779
    if (h >= 0)
    {
    L = kfilelength(h);
    if (L == 26524524 || L == 44356548)
        return 0;
    else
       {
	   shareware = 1;
	   kclose(h);
	   return 1;
	   }
    }
    return 0;
}

int gametextsm(int x,int y,char *t,char s,short dabits)              // wxvr
{
    short ac,newx, p;
    char centre, *oldt;

    centre = ( x == (320>>1) );     // s = < 17 then = pal
    newx = 0;                       // s > 16 : p = s - 16 : s = 16
    oldt = t;                       // 0  = normal blue - made orange 2
    p = 2;                          // 1  = pale blue
                                    // 2  = fire orange
    if (s > 0 && s < 17)            // 3  = default blue - also 5 & 9
    {                               // 4  = black
        p = s;                      // 6  = smudge green
        s = 0;                      // 7  = yellow
    }                               // 8  = lime green
    else                            // 10 = red
    if (s > 16 && s < 33)           // 12 = white
    {                               // 13 = silver gray
        p = s - 16;                 // 14 = pale green
        s = 16;                     // 15 = pale pink
    }                               // 16 = dark blue

    if (centre)
    {
        while(*t)
        {
            if (*t == 32)
            {
                newx += 4;
                t++;
                continue;
            }
            else
                ac = *t - '!' + STARTALPHANUM;

            if (ac < STARTALPHANUM || ac > ENDALPHANUM )
                break;
            newx += (tilesizx[ac] / 3 * 2 + 1);
            t++;
        }
        t = oldt;
        x = (320>>1)-(newx>>1);
    }

    while(*t)
    {
        if (*t == 32)
        {
            x += 4;
            t++;
            continue;
        }
        else
            ac = *t - '!' + STARTALPHANUM;

        if (ac < STARTALPHANUM || ac > ENDALPHANUM)
            break;
        rotatesprite(x<<16,y<<16,48000L,0,ac,s,p,dabits,0,0,xdim-1,ydim-1);
        x += (tilesizx[ac] / 3 * 2 + 1);
        t++;
    }
    return (x);
}

//-------------------------------------- Multiplay --------------------------------------

long SetupMultiPlayer()
{
    char mbuf[80];
    char mgam[80];
    char mcon[80];
    char mspn[10];
    char mtyp[10];
    char brac[2];
    long i;

    mbuf[0] = 0;
    brac[0] = 0;

    if (MapsFolder[0] != 0)
        strcpy(brac, "/");

    mgam[0] = 0;
    if (MenuGame[0] != 0)                                            // wxdm
    {
        i = strlen(MenuGame);
        strcpy(mbuf, MenuGame);
        mbuf[i-4] = 0;
        if (GameFolder[0] != 0)
            sprintf(bf, "-j%s -g%s -x%s.con ", GameFolder, MenuGame, mbuf);
        else
            sprintf(bf, "-g%s -x%.con ", MenuGame, mbuf);

        strcpy(mgam, bf);
        mbuf[0] = 0;
    }

    if (MenuMap[0] != 0)
    {
        sprintf(bf, "-map %s%s%s", MapsFolder, brac, MenuMap);
        strcpy(mbuf, bf);
    }

    if (iLevelNum > -1)                                              // wxdm
    {
        long v, i;
        long lnum = iLevelNum+1;

        v = 1;
        i = lnum;
        if (lnum > 8)
        {
            lnum += 3;
            v = lnum / 11;
            i = lnum - v * 11;
            v++;
            if (i == 0)
            {
                v--;
                i = 11;
            }
        }
        sprintf(bf, "-v%d -l%d ", v, i);
        strcpy(mbuf, bf);
        mgam[0] = 0;
    }

    if (iType == 2)
        sprintf(bf, "/c%d", iType);
    else
        sprintf(bf, "/c%d /m", iType);
    strcpy(mtyp, bf);

    mspn[0] = 0;
    if (iSpawn == 1)
    {
        sprintf(bf, " /t2");
        strcpy(mspn, bf);
    }

    if (iDedicated == 1)
    {
        if (HostMulti == 1)
            sprintf(bf, "Duke3dw.exe %s%s /name %s /col %d %s%s /net /n0:%d", mgam, mbuf, PlayerNameArg, iColr, mtyp, mspn, PlayerNum);
        else
            sprintf(bf, "Duke3dw.exe %s%s /name %s /col %d %s%s /net /n0 %s", mgam, mbuf, PlayerNameArg, iColr, mtyp, mspn, IPAddress);
    }
    else
    {
        if (HostMulti == 1)
            sprintf(bf, "Duke3dw.exe %s%s /name %s /col %d %s%s /net /n1 %s", mgam, mbuf, PlayerNameArg, iColr, mtyp, mspn, IPAddress);
        else
            sprintf(bf, "Duke3dw.exe %s%s /name %s /col %d %s%s /net %s /n1", mgam, mbuf, PlayerNameArg, iColr, mtyp, mspn, IPAddress);
    }

    argvline = strdup(bf);
    i = SetCommandLine(argvline);
    return i;
}

long SetupFakeMultiPlayer()
{
    char musc[80];
    char mbuf[80];
    char mgam[80];
    char mspn[10];
    char brac[2];
    long i;

    mbuf[0] = 0;
    musc[0] = 0;
    brac[0] = 0;

    if (MapsFolder[0] != 0)
        strcpy(brac, "/");

    mgam[0] = 0;
    if (MenuGame[0] != 0)
    {
        i = strlen(MenuGame);
        strcpy(mbuf, MenuGame);
        mbuf[i-4] = 0;
        if (GameFolder[0] != 0)
            sprintf(bf, "-j%s -g%s -x%s.con ", GameFolder, MenuGame, mbuf);
        else
            sprintf(bf, "-g%s -x%.con ", MenuGame, mbuf);

        strcpy(mgam, bf);
        mbuf[0] = 0;
    }

    if (MenuMap[0] != 0)
    {
        sprintf(bf, "-map %s%s%s", MapsFolder, brac, MenuMap);
        strcpy(mbuf, bf);
    }

    if (MenuMusic[0] != 0)
    {
        sprintf(bf, " -music %s%s", MusicFolder, MenuMusic);
        strcpy(musc, bf);
    }

    mspn[0] = 0;
    if (iSpawn == 1)
    {
        sprintf(bf, "/t2 ");
        strcpy(mspn, bf);
    }

    sprintf(bf, "Duke3dw.exe %s%s /name %s %s/q%d /a /m /s%d%s", mgam, mbuf, PlayerNameArg, mspn, NumBots+1, iSkill, musc);

    argvline = strdup(bf);
    i = SetCommandLine(argvline);
    bFake = 1;
    return i;
}

void CheckFakePlayers(void)                                          // wxfp
{
    short i;

    if (FakePlayer)
    {
        strcpy(ud.user_name[0], PlayerNameArg);
        for (i=1; i<8; i++)
        {
             if (Botname[i] != 0)
                 strcpy(ud.user_name[i], Botname[i]);
             else
             {
                sprintf(tempbuf, "Bot %d", i);
                strcpy(ud.user_name[i], tempbuf);
             }
        }
    }
}

void CheckMultiplayer(void)                                          // wxpy
{
	int i, l;

	if (numplayers > 1)
	    initprintf("Multiplayer initialized.\n");

	if (netparam)
	    free(netparam);
	netparam = NULL;
	netparamcount = 0;

	//getnames();

     for (l=0; l<sizeof(PlayerNameArg)-1; l++)                       // wxdm
     {
          ud.user_name[myconnectindex][l] = Btoupper(PlayerNameArg[l]);
     }

     if (numplayers > 1)
     {
          buf[0] = 6;
		  buf[1] = myconnectindex;
          buf[2] = BYTEVERSION;
		  l = 3;

			  //null terminated player name to send
		  for (i=0; PlayerNameArg[i]; i++)
		  {
		       buf[l++] = Btoupper(PlayerNameArg[i]);
		  }
		  buf[l++] = 0;

          initprintf("Sending  Playername: %s\n", PlayerNameArg);

          for (i=0; i<10; i++)
          {
               ud.wchoice[myconnectindex][i] = ud.wchoice[0][i];
			   buf[l++] = (char)ud.wchoice[0][i];
          }

		  buf[l++] = ps[myconnectindex].aim_mode = ud.mouseaiming;
		  buf[l++] = ps[myconnectindex].auto_aim = AutoAim;
		  buf[l++] = ps[myconnectindex].weaponswitch = ud.weaponswitch;
          buf[l++] = ps[myconnectindex].palookup = sprite[ps[myconnectindex].i].pal = ud.color;

          if (bHost)
          {
              buf[l++] = ud.m_coop;
              if (ud.m_coop == 1)
              {
                  ud.m_monsters_off = 0;
                  ud.m_player_skill = ud.player_skill = 2;
              }
              else
              {
                  ud.m_monsters_off = 1;
                  ud.m_player_skill = ud.player_skill = 0;
              }
              buf[l++] = ud.m_respawn_items;
          }

          for(i=connecthead; i>=0; i=connectpoint2[i])
		  {
				if (i != myconnectindex)
				    sendpacket(i,&buf[0],l);
				if ((!networkmode) && (myconnectindex != connecthead))
				    break; //slaves in M/S mode only send to master
		  }

          getpackets();
          waitforeverybody(1);                                       // wxdm
    }
    if (cp == 1 && numplayers < 2)
        gameexit("Please put the Duke Nukem 3D Atomic Edition CD in the CD-ROM drive.");
}

void WaitMultiScreen(void)
{
    setgamemode(ScreenMode,ScreenWidth,ScreenHeight,ScreenBPP);
    setview(0,0,xdim-1,ydim-1);
    clearview(0L);
    flushperms();
    KB_FlushKeyboardQueue();
    fadepal(0,0,0, 63,0,-7);
    totalclock = 0;
    rotatesprite(0,0,65536L,0,3245,0,0,2+8+16+64,0,0,xdim-1,ydim-1);
    if (bHost)
    {
        menutextc(95,155,0,0,"MULTIPLAYER HOST");
        gametext(160,170,"WAITING FOR PLAYERS",0,2+8+16);
    }
    else
    {
        menutextc(88,155,0,0,"MULTIPLAYER CLIENT");
        gametext(160,170,"WAITING FOR HOST SERVER",0,2+8+16);
    }
    gametextsm(160,157,"PRESS ESCAPE TO QUIT ",10,2+8+16);
    nextpage();
}

void SendUserMap(void)
{
    if (numplayers > 1)
    {
        short i, j;

        if (boardfilename[0] == 0 && !bHost)
            return;

        buf[0] = 32;
        buf[1] = 0;

        j = 2;

        if (boardfilename[0] != 0)
        {
            getboardmapname(boardfilename);
            j = Bstrlen(boardmapname);
            boardmapname[j++] = 0;
            Bstrcat(buf+1,boardmapname);
            initprintf("Sending Mapname: %s\n",boardmapname);
        }

        for (i=connecthead; i>=0; i=connectpoint2[i])
        {
            if (i != myconnectindex)
            {
                sendpacket(i,&buf[0],j);
            }
            if ((!networkmode) && (myconnectindex != connecthead))
                break; //slaves in M/S mode only send to master
        }
    }
}

void SendLevelInfo(void)                                             // wxdm
{
	int i, l;

     if (numplayers > 1)
     {
          if (bHost)
          {
              buf[0] = 48;
		      buf[1] = myconnectindex;
              buf[2] = 0;
		      l = 2;

              buf[l++] = ud.m_level_number;
              buf[l++] = ud.m_volume_number;
              buf[l++] = ud.m_player_skill;
              buf[l++] = ud.m_monsters_off;
              buf[l++] = ud.m_marker;
              buf[l++] = ud.m_ffire;
              buf[l++] = ud.warp_on;

              for (i=connecthead; i>=0; i=connectpoint2[i])
		      {
				  if (i != myconnectindex)
				      sendpacket(i,&buf[0],l);
				  if ((!networkmode) && (myconnectindex != connecthead))
				      break; //slaves in M/S mode only send to master
		      }
          }
    }
}

void SendPlayerInfo(void)  // name/color
{
    long i,l;

    if (numplayers < 2)
        return;

    for (l=0; (unsigned)l<sizeof(PlayerNameArg)-1; l++)
        ud.user_name[myconnectindex][l] = Btoupper(PlayerNameArg[l]);

    buf[0] = 64;
    buf[1] = myconnectindex;
    buf[2] = ud.color;
    l = 3;

    for (i=0; PlayerNameArg[i]; i++)
	{
	     buf[l++] = Btoupper(PlayerNameArg[i]);
	}
	buf[l++] = 0;

    for (i=connecthead; i>=0; i=connectpoint2[i])
    {
        if (i != myconnectindex)
            sendpacket(i,&buf[0],l);
        if ((!networkmode) && (myconnectindex != connecthead))
            break;
    }
}

int getdeffile(char *fn, int iDef)                                   // wxgd
{
    if (NoHrp == 1 && iDef == 1)
        return -1;
    else
        return loaddefinitionsfile(fn);
}

void dolower(char *cpath)                                            // wxdl
{
    int i;
    char sTemp[128];
    char ch;

    for (i=0; i<128; i++)
         sTemp[i] = 0;

    strcpy(sTemp, cpath);
    for (i=0; i<strlen(sTemp)+1; i++)
    {
         ch = sTemp[i];
         if (ch > 0x40 && ch < 0x5b)   // A - Z
         {
             ch = ch ^ 0x20 ;
             sTemp[i] = ch;
         }
    }
    strcpy(cpath, sTemp);
}

void SetMapPlayed(char *smap)
{
    char buf[80];
    int i, scH;

    if (MapsPlayed[0] == 0 || MapsPlayed[1] == 0)
        GetMapsPlayed();

    if (CheckMapsPlayed(smap))
        return;

    strcpy(MapsPlayed[Mapnum], smap);

    scH = SCRIPT_Init("Duke3dw.mps");
	if (scH < 0)
	    return;

    for (i=0; i<Mapnum+1; i++)
    {
	    Bsprintf(buf,"Map_%d", i);
		SCRIPT_PutString(scH, "Maps Played", buf, MapsPlayed[i]);
    }

	SCRIPT_Save (scH, "Duke3dw.mps");
	SCRIPT_Free (scH);
}

void GetMapsPlayed(void)
{
    char buf[80];
    char tmp[80];
    int i, scH = -1;

	if (SafeFileExists("Duke3dw.mps"))
 	    scH = SCRIPT_Load("Duke3dw.mps");

	if (scH < 0)
	    return;

    for (i=0; i<2000; i++)                                              // wxmp
    {
        Bsprintf(buf,"Map_%d",i);
        tmp[0] = 0;
        SCRIPT_GetString(scH, "Maps Played", buf, &tmp);
        if (strlen(tmp) < 4)
        {
            Mapnum = i;
            break;
        }
        dolower(&tmp);
        strcpy(MapsPlayed[i], tmp);
    }
    SCRIPT_Free (scH);
}

int CheckMapsPlayed(char *smap)                                     // 100128
{
    int i;

    for (i=0; i<2000; i++)
    {
         if (strstr(MapsPlayed[i], smap))
             return TRUE;
         if (i > 10 && strlen(MapsPlayed[i]) < 4)
             break;
    }
    return FALSE;
}

