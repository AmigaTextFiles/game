/***************************************************************************
 *     Paranoid --- The newest game from 7087                              *
 *     Feel free to copy the source code                                   *
 ***************************************************************************/
#include <intuition/intuition.h>
#include <graphics/gfxbase.h>
#include <graphics/sprite.h>
#include <graphics/gfxmacros.h>
#include <libraries/dosextens.h>
#include <exec/memory.h>

/**************************************************************************
 *    Feststehende Daten,die sich nicht mehr veraendern (Sprites...)      *
 **************************************************************************/

/* ColorTable fuer die Steine */
long sc1[]={ 0l,27l,19l,19l,20l,19l,19l,30l,23l};
long sc2[]={ 0l,23l,17l,27l,21l,30l,31l,26l,28l};
long sc3[]={ 0l,28l,18l,23l,29l,26l,16l,24l,28l};

UWORD platte1_img [] = {
0x0000,0x0000,0x3fff,0x3000,0x6000,0x7fff,0x8000,0xffff,0x9fff,0xf000,
0xffff,0xf000,0x7fff,0x7000,0x3fff,0x3000,0x0000,0x0000 };

UWORD platte2_img [] = {
0x0000,0x0000,0xfffc,0x000c,0x0006,0xfffe,0x0001,0xffff,0xfff9,0x000f,
0xffff,0x000f,0xfffe,0x000e,0xfffc,0x000c,0x0000,0x0000 };

UWORD ball_img [] = {
0x0000,0x0000,
0x7000,0x1000,
0x7800,0xb800,
0x7800,0x9000,
0x3800,0xc000,
0x1000,0x6000,
0x0000,0x0000 };

UWORD mouse_pointer [] = {
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 };

UWORD sound2[]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 };

struct SimpleSprite platte1_spr= { platte1_img,7l };
struct SimpleSprite platte2_spr= { platte2_img,7l };
struct SimpleSprite ball_spr= { ball_img,5l };

/**************************************************************************
 * einige Variablen fuer Spiel + System                                   *
 **************************************************************************/
short platte1_nr,platte2_nr,ball_nr,GetSprite();
long spr_offset,horpos,verpos,mousemove;
char oldmouse;
float ballwinkel,speed,rad(),sin(),cos(),ran();
float sinwert,coswert;
long ballx,bally,newx,newy;
long xcheck,ycheck;
UBYTE oldscore[5];
UBYTE newscore[5];
short stage,lives,stone,score;
long stonecount;

struct Level
{
 short p_num;
 UBYTE stones [320];
};
struct Level level;

struct HighScore
{
 short punkte;
 char name[30];
};
struct HighScore highscore[10];

/**************************************************************************
 *               Variablen fuer das System                                *
 **************************************************************************/
struct Screen *scr,*MasterScreen();
struct ViewPort *vp;
struct RastPort *rp;
struct BitMap *bm; long bm5base;
struct FileHeader *fh,*Open();
struct ColorMap *GetColorMap(),*cmap;
UBYTE *button=(UBYTE *) 0xbfe001; 
UBYTE *key=(UBYTE *) 0xbfec01;
struct Window *win,*MasterWindow();
struct IntuitionBase *IntuitionBase;
long AllocMem(),soundbuffer,s1,s2;
short soundflag=0;
UWORD pattern[1024];
struct BitMap hitmap;
UBYTE hitbit[1280];
long hitnr=0l,hitdel=0l;
short hitflag=0;

/**************************************************************************
 *   Vorspann und HauptMenu                                               *
 **************************************************************************/

main()
{
 openstuff();
 Disable();
 GetData();
 InitBitMap (&hitmap,5l,16l,16l);
 if (!(s1=AllocMem(68000l,MEMF_CHIP|MEMF_PUBLIC)))
 { printf ("No Memory for sounds\n"); CloseMaster(scr,win); }
 if (!(fh=Open ("Paranoid:music/synt.snd",1004l)))
 { printf ("Sounddata not found\n"); CloseMaster(scr,win); }
 Read (fh,s1,66802l);
 Close (fh);
 if (!(s2=AllocMem(68000l,MEMF_CHIP|MEMF_PUBLIC)))
 { printf ("No Memory for sounds\n"); CloseMaster(scr,win); }
 if (!(fh=Open ("Paranoid:music/loopsynt.snd",1004l)))
 { printf ("loopsynt not found\n"); CloseMaster(scr,win); }
 Read (fh,s2,67325l);
 Close (fh);
 GetPicture ("Paranoid:gfx/titlescreen.dat",320l,200l,5l);
 PlaySound (s1,66802l,358,3,64l+(64l<<8l));
 Delay (50l);
 PlaySound (s2,67325l,358,3,64l+(64l<<8l));
 Delay (300l);
 FreeMem (s1,68000l);
 Enable();
 while (*button&(UBYTE)64);  /* Solange,bis Button unten*/ 
 while (TRUE)
 {
  GetPicture("Paranoid:gfx/mscreen.dat",320l,178l,4l);
  if (s2) { FreeMem (s2,68000l); s2=0l; silence(15); }
  while (TRUE)
  {
   while (!(*button&(UBYTE)64)); /* Solange,bis Button oben */
   while (*button&(UBYTE)64);  /* Solange,bis Button unten */
   if (CheckRange (51,64,60,73))   { playit(); break; }
   if (CheckRange (51,94,60,103))  { editor(); break; }
   if (CheckRange (51,130,60,139))
   { 
    GetPicture ("Paranoid:gfx/highscreen.dat",320l,256l,2l);
    PrintHighScore();
    while (!(*button&(UBYTE)64));
    while (*button&(UBYTE)64);  /* Solange,bis Button unten */
    while (!(*button&(UBYTE)64));
    break;
   }
  }
  Delay (30l);
  if (*key==117) CloseMaster (scr,win);
 }
}

playit()
{
 long loop;
 float t=sin(1.0);/* Lade Mathtrans.library*/
 spr_offset=8l;
 xcheck=4l;
 ycheck=0l;
 score=stage=0;lives=5;
 for (loop=0l;loop<5l;loop++) oldscore[loop]=0;
 GetPicture("Paranoid:gfx/playscreen.dat",320l,256l,4l);
 SetPointer (win,mouse_pointer,16l,16l,0l,0l);
 RemakeDisplay();
 GetSound();
 SetRGB4 (vp,16l,12l,0l,12l);
 SetRGB4 (vp,17l,10l,10l,10l);
 SetRGB4 (vp,18l,7l,7l,7l);
 SetRGB4 (vp,19l,13l,13l,13l);
 SetRGB4 (vp,20l,6l,6l,15l);
 SetRGB4 (vp,21l,4l,4l,15l);
 SetRGB4 (vp,22l,15l,15l,15l);
 SetRGB4 (vp,23l,14l,2l,2l);
 SetRGB4 (vp,24l,1l,6l,1l);
 SetRGB4 (vp,25l,15l,15l,15l);
 SetRGB4 (vp,26l,3l,9l,3l);
 SetRGB4 (vp,27l,15l,5l,0l);
 SetRGB4 (vp,28l,10l,0l,0l);
 SetRGB4 (vp,29l,0l,0l,11l);
 SetRGB4 (vp,30l,3l,12l,3l);
 SetRGB4 (vp,31l,15l,0l,15l);
 if (!(platte1_nr=GetSprite (&platte1_spr,2l)))
 { printf ("No Sprite 2 allocation\n"); CloseMaster (scr,win); }
 if (!(platte2_nr=GetSprite (&platte2_spr,3l)))
 { printf ("No Sprite 3 allocation\n"); CloseMaster (scr,win); }
 if (!(ball_nr=GetSprite (&ball_spr,1l)))
 { printf ("No Sprite 4 allocation\n"); CloseMaster (scr,win); }
 LoadStage(21l,25l);
 realstart:
 horpos=160l;verpos=237l;ballwinkel=45.0;bally=verpos-5l;speed=4.0;
 newwinkel(45.0);
 PrintStuff();
 GetMouseMove();
 do
 {
  MoveSprite (vp,&platte1_spr,horpos,verpos);
  MoveSprite (vp,&platte2_spr,horpos+spr_offset,verpos);
  MoveSprite (vp,&ball_spr,horpos+10l,bally);
  GetMouseMove();
  WaitTOF ();
 } while (*button&(UBYTE)64);
 ballx=horpos+10l;
 do
 { 
  for (t=1.0;t<=speed;t++)
  {
   newx=ballx+(long)(t*coswert);
   newy=bally-(long)(t*sinwert);
   if (newx<20l)
   {
    silence(1);
    soundflag=1;
    newx++; score++;
    newwinkel(90.0);
    PlaySound (soundbuffer+39028l,5986l,358,1,64l);
    break;
   }
   if (newx>296l)
   {
    silence(2);
    newwinkel(90.0);
    PlaySound (soundbuffer+39028l,5986l,358,2,64l<<8);
    soundflag=2;
    newx--;score++;
    break;
   }
   if (newy<56l)
   {
    silence(3);
    newwinkel(0.0);
    PlaySound (soundbuffer+39028l,5986l,358,3,
               (304l-newx)/5l+((newx/5l)<<8));
    soundflag=3;
    newy++;score++;
    break;
   }    
   if (newy>verpos-5l)
   {
    if ((newx+3l>horpos)&&(newx<horpos+14l+spr_offset))
    {
     silence(12);
     soundflag=12;
     newwinkel(0.0);
     newy--;
     PlaySound (soundbuffer,6130l,250,12,(64l<<16)+(64l<<24));
     break;
    }
   else 
    {
     silence(3);
     MoveSprite (vp,&ball_spr,newx,newy);
     if (ran()>.5)
     PlaySound (soundbuffer+6135l,12412l,406,3,64l<<8);
     else
     PlaySound (soundbuffer+18548l,20480l,298,3,64l);
     Delay (50l*1l);
     shutup(3);
     Delay(60l*1l);
     lives--; if (!(lives)) break;
     goto realstart;
    }
   }
   loop=0l;
   if (loop=pixtest(newx,newy))
   {
    silence(3);
    soundflag=3;
    if ((long)loop==1l) newwinkel (0.0);
    if ((long)loop==2l) newwinkel (90.0);
    KillStone (newx,newy,25l);
    newx=ballx; newy=bally;
    PlaySound (soundbuffer+61398l,1480l,358,3,
               (304l-newx)/5l+((newx/5l)<<8));
    score+=2;
    stonecount--;
    break;
   }
  }
  ballx=newx;bally=newy;
  MoveSprite (vp,&ball_spr,ballx,bally);
  GetMouseMove();
  MoveSprite (vp,&platte1_spr,horpos,verpos);
  MoveSprite (vp,&platte2_spr,horpos+spr_offset,verpos);
  PrintScore();
  if ((++hitdel>1000l)&&((hitdel>>1l)<<1l==hitdel))
  {
   if (hitdel>1200l) hitdel=0l;
   BltBitMapRastPort (&hitmap,0l,0l,rp,281l,223l,16l,16l,0xccl);
   if (++hitnr>=8l) hitnr=0l;
   for (loop=0l;loop<5l;loop++)
   hitmap.Planes[loop]=(UBYTE *)((long)(hitbit)+160l*hitnr+32l*loop);
  }
  if ((hitdel>1000l)&&(horpos+spr_offset+16l>=281l))
  {
   speed=4.0;
   hitflag=0;
   spr_offset=8l;
   hitdel=0l;
   t=ran();
   if (t<.1) spr_offset=16l;
   if ((t>=.1)&&(t<.2)) score+=40; 
   if ((t>=.2)&&(t<.3)) { lives++; PrintStuff(); }
   if ((t>=.3)&&(t<.4)) { stage++; LoadStage(21l,25l); goto realstart;}
   if ((t>=.4)&&(t<.5)) hitflag=1;
   if ((t>=.5)&&(t<.6)) score+=75;
   if ((t>=.6)&&(t<.7)) goto realstart;
   if ((t>=.7)&&(t<.8)) speed=2.0;
   if ((t>=.8)&&(t<.9)) speed=3.0; 
   if (t>=.9) speed=5.0;
  }
  if (hitflag) { ballwinkel+=((ran()-.5)*10.0); newwinkel (ballwinkel);}
  WaitTOF();
  if (soundflag) { shutup(soundflag); soundflag=0; }
  if (lives<1) break;
  if (!(stonecount)) { stage++;LoadStage(21l,25l); goto realstart; }
 } while (*key!=117);
 FreeMem (soundbuffer,64000l);
 FreeSprite (2l);
 FreeSprite (3l);
 FreeSprite (1l);
 ClearPointer (win);
 RethinkDisplay();
 silence(15);
 if (score>highscore[9].punkte) PutHighScore();
}
editor()
{
 short xmouse,ymouse;
 GetPicture ("Paranoid:gfx/escreen.dat",320l,256l,5l);
 DisplayBeep (scr);
 stage=0l;level.p_num=0;stone=1;
 PrintMuster(); PrintRunde ();
 CleanFields();
 while (TRUE)
 {
  while (!(*button&(UBYTE)64));
  while (*button&(UBYTE)64);
  if (CheckRange (2,105,20,113)) break;
  if ((CheckRange (2,90,20,103))&&(stage>0l))
  { stage--; PrintRunde(); continue; }
  if ((CheckRange (2,75,20,88))&&(stage<99l))
  { stage++; PrintRunde(); continue; }
  if ((CheckRange (157,34,168,44))&&(level.p_num>0))
  { level.p_num--; PrintMuster(); continue; }
  if ((CheckRange (144,34,155,44))&&(level.p_num<15))
  { level.p_num++; PrintMuster(); continue; }  
  if (CheckRange (144,9,168,19)) { CleanFields(); continue; }
  if (CheckRange (80,12,95,17)) { stone=1; continue; }
  if (CheckRange (102,12,117,17)) { stone=2; continue; }
  if (CheckRange (124,12,139,17)) { stone=3; continue; }
  if (CheckRange (80,24,95,29)) { stone=4; continue; }
  if (CheckRange (102,24,117,29)) { stone=5; continue; }
  if (CheckRange (124,24,139,29)) {stone=6; continue; }
  if (CheckRange (80,36,95,41)) {stone=7; continue; }
  if (CheckRange (124,36,139,41)) { stone=8; continue; }
  if (CheckRange (102,36,117,41)) { stone=0; continue; }
  if (CheckRange (35,80,306,219)) { paint(); continue; }
  if (CheckRange (2,27,20,44)) { SaveStage(); continue;}
  if (CheckRange (2,9,20,25))
  { LoadStage(32l,35l); PrintRunde(); PrintMuster(); continue;}
 }
}
/*********************************************************************
 *   Hier stehen die Hilfsroutinen                                   *
 *********************************************************************/
GetMouseMove()
{
 register char *move=(char *) 0xdff00b;
 register char new,summ;
 new=*move;
 summ=oldmouse-new;
 oldmouse=new;
 mousemove=(long)(-1.2*(float)(summ));
 horpos+=mousemove;
 if (horpos+mousemove<20l) horpos=20l;
 if (horpos+mousemove>284l-spr_offset) horpos=284l-spr_offset;
}
float rad (deg)
float deg;
{
 return (3.141593*deg/180.0);
}
newwinkel(grad)
float grad;
{
 while (grad>=180.0) grad-=180.0;
 while (grad<=-180.0) grad+=180.0;
 ballwinkel=2.0*grad-ballwinkel;
 if (ballwinkel>180.2)  ballwinkel-=360.0;
 if (ballwinkel<-180.2) ballwinkel+=360.0;
 if ((ballwinkel>.0)&&(ballwinkel<=180.0))
 ycheck=0l;
 else  ycheck=4l;
 if ((ballwinkel>-90.0)&&(ballwinkel<=90.0))
 xcheck=4l;
 else  xcheck=0l;
 sinwert=sin(rad(ballwinkel));
 coswert=cos(rad(ballwinkel));
}
PlaySound (start,laenge,rate,channels,volume)
ULONG *start,volume,laenge;
USHORT rate,channels;
{
 USHORT loop,avol;
 USHORT *ctlw,*c0tl,*c0per,*c0vol;
 ULONG  *c0thi;
 c0thi = (ULONG  *) 0xdff0a0;
 c0tl  = (USHORT *) 0xdff0a4;
 c0per = (USHORT *) 0xdff0a6;
 c0vol = (USHORT *) 0xdff0a8;
 ctlw  = (USHORT *) 0xdff096;
 for (loop=1;loop<=8;loop*=2)
 {
  avol=0;
  avol=(UBYTE)(volume>>(8*(loop/2-loop/8)));
  if (loop&channels)
  {
   *c0thi = (ULONG) start;
   *c0tl  = (UWORD) (laenge>>1l);
   *c0vol = avol;
   *c0per = rate;
  }
  c0thi=(ULONG *)((ULONG)(c0thi)+0x10l);
  c0tl=(USHORT *)((ULONG)(c0tl)+0x10l);
  c0per=(UWORD *)((ULONG)(c0per)+0x10l);
  c0vol=(UWORD *)((ULONG)(c0vol)+0x10l);
 }
 *ctlw  = 0x8200+channels;
}
shutup(channels)
UWORD channels;
{
 USHORT loop;
 USHORT *c0tl=(USHORT *) 0xdff0a4;
 ULONG  *c0thi=(ULONG *) 0xdff0a0; 
 for (loop=1;loop<=8;loop*=2)
 {
  if (loop&channels)
  {
   *c0thi = (ULONG) sound2;
   *c0tl  = 20;
  }
  c0thi=(ULONG *)((ULONG)(c0thi)+0x10l);
  c0tl=(USHORT *)((ULONG)(c0tl)+0x10l);
 }
}
silence(channels)
USHORT channels;
{
 USHORT *ctlw=(USHORT *) 0xdff096;
 *ctlw=channels;
}
/* Hier steht pixtest(); */
#asm
	public	_pixtest
_pixtest:
	movem.l	d1-d7/a0-a6,-(sp)
;60(a7) ist x,64(a7) ist y
	addq.l	#1,60(a7)
	move.l	_ycheck,d0
	add.l	d0,64(a7)
	jsr	offset
; schleife 1 mit d3
	move.l	#2,d3
	move.l	#1,d4
loop1:
	clr.l	d0
	bset	d6,d0
	and.b	(a0),d0
	tst.b	d0
	bne	raus1
	subq.l	#1,d6
	cmp.l	#-1,d6
	bne	loop1on
	move.l	#7,d6
	addq.l	#1,a0
loop1on:
	addq.l	#1,d4
	dbra	d3,loop1
	subq.l	#1,60(a7)
	move.l	_xcheck,d0
	add.l	d0,60(a7)
	move.l	_ycheck,d0
	sub.l	d0,64(a7)
	addq.l	#1,64(a7)	
	jsr	offset
; schleife 1 mit d3
	move.l	#2,d3
	move.l	#1,d4
loop2:
	clr.l	d0
	bset	d6,d0
	and.b	(a0),d0
	tst.b	d0
	bne	raus2
	adda.l	#40,a0	;eventuell anpassen
	addq.l	#1,d4
	dbra	d3,loop2
.pixend
	movem.l	(sp)+,d1-d7/a0-a6
	rts
;offset und bytepos berechnen,x und y sind um vier verschoben
offset:
	move.l	68(a7),d0
	mulu	#40,d0	; eventuell anpassen
	move.l	64(a7),d1
	divu	#8,d1
	add.w	d1,d0
	add.l	_bm5base,d0
	movea.l	d0,a0
	mulu	#8,d1
	addq.l	#7,d1
	sub.l	64(a7),d1
	move.l	d1,d6
	rts
raus1:
	move.l	_newx,_ballx
	move.l	_newy,_bally
	add.l	d4,_newx
	move.l	_ycheck,d1
	add.l	_newy,d1
	move.l	d1,_newy
	move.l	#1,d0
	jmp	.pixend
raus2:
	move.l	_newx,_ballx
	move.l	_newy,_bally
	add.l	d4,_newy
	move.l	_xcheck,d1
	add.l	_newx,d1
	move.l	d1,_newx
	move.l	#2,d0
	jmp	.pixend
#endasm
/************************************************************************
 * Diese Routinen werden auch vom Editor benutzt.                       *
 ************************************************************************/


openstuff()
{
 if (!(OpenMaster())) { printf ("Keine Libraries\n"); exit(); }
 SetRast (IntuitionBase->ActiveWindow->RPort,0l);
 if (!(scr=MasterScreen(320,256,31,0l)))
 { printf ("Kein Screen\n"); CloseMaster (0l,0l); }
 if (!(win=MasterWindow (scr,0,0,320,256,0l,BORDERLESS,0l)))
 { printf ("Kein Window\n"); CloseMaster (scr,0l); }
 if (!(cmap=GetColorMap(32l))){printf ("Color Map\n"); CloseMaster (scr,win);}
 vp=&(scr->ViewPort); rp=&(scr->RastPort);
 bm=&(scr->BitMap); bm5base=(long)bm->Planes[4];
}
GetSound()
{
if (!(soundbuffer=AllocMem(64000l,MEMF_CHIP|MEMF_PUBLIC)))
 { printf ("No Memory for sounds\n"); CloseMaster(scr,win); }
 if (!(fh=Open ("Paranoid:music/parsound.dat",1004l)))
 { printf ("Sounddata not found\n"); CloseMaster(scr,win); }
 Disable();
 Read (fh,soundbuffer,62878l);
 Close (fh);
 Enable();
}
GetPicture(name,x,y,planes)
char *name;
long x,y,planes;
{
 long loop;
 if (!(fh=Open(name,1005l)))
 { printf ("No Picture\n"); CloseMaster (scr,win);}
 SetRast (rp,0l);
 ScreenToBack (scr);
 Disable();
 for (loop=0l;loop<planes;loop++)
 Read (fh,bm->Planes[loop],(x*y)/8l);
 Read (fh,cmap->ColorTable,2l*(1l<<planes));
 Close (fh);
 LoadRGB4 (vp,cmap->ColorTable,(1l<<planes));
 RemakeDisplay();
 Enable();
 ScreenToFront (scr);
}
GetData ()
{
 long loop;
 if (!(fh=Open("Paranoid:gfx/muster.dat",1004l)))
 { printf ("No pattern\n"); CloseMaster (scr,win);}
 Read (fh,pattern,2048l);
 Close (fh);
 if (!(fh=Open("Paranoid:gfx/hit.dat",1004l)))
 { printf ("No hit\n"); CloseMaster (scr,win);}
 Read (fh,hitbit,1280l);
 Close (fh);
 for (loop=0l;loop<5l;loop++)
 hitmap.Planes[loop]=(UBYTE *)((long)(hitbit)+32l*loop);
 if (!(fh=Open("Paranoid:highscore",1004l)))
 { printf ("No scorelist\n"); return;}
 Read (fh,highscore,320l);
 Close (fh);
}
SetStone(x,y,num,base)
ULONG x,y,num,base;
{
 long c1,c2,c3;
 c1=sc1[num]; c2=sc2[num]; c3=sc3[num];
 SetAfPt (rp,0l,0);
 SetAPen (rp,c2);
 RectFill (rp,base+17l*x,80l+7l*y,base+17l*x+15l,80l+7l*y+5l);
 SetAPen (rp,c1);
 Move (rp,base+17l*x,80l+7l*y+5l);
 Draw (rp,base+17l*x,80l+7l*y);
 Draw (rp,base+17l*x+15l,80l+7l*y);
 SetAPen (rp,c3);
 Move (rp,base+1l+17l*x,80l+7l*y+5l);
 Draw (rp,base+17l*x+15l,80l+7l*y+5l);
 Draw (rp,base+17l*x+15l,81l+7l*y);
}
KillStone (x,y,base)
long x,y,base;
{
 UWORD *pzeiger=(UWORD *)((long)(pattern)+128l*(long)(level.p_num));
 long xloc,yloc;
 SetAPen (rp,15l);
 SetAfPt (rp,pzeiger,-4);
 xloc=(x-base)/17l;
 yloc=(y-80l)/7l;
 RectFill (rp,base+xloc*17l,80l+yloc*7l,base+xloc*17l+15l,80l+7l*yloc+5l);
 SetAfPt (rp,0l,0);
}
CheckRange (x1,y1,x2,y2)
short x1,y1,x2,y2;
{
 short xm,ym;
 if (*button&(UBYTE)64) return (0);
 xm=scr->MouseX; ym=scr->MouseY;
 if ((xm<x1)||(xm>x2)||(ym<y1)||(ym>y2))
 return (0);
 while (!(*button&(UBYTE)64)); 
 xm=scr->MouseX; ym=scr->MouseY;
 if ((xm<x1)||(xm>x2)||(ym<y1)||(ym>y2))
 return (0);
 else return(1);
}
PrintRunde()
{
 char runde[2];short st=(short)stage;
 runde[0]=48+(char)(st/10);
 st=st-10*(st/10);
 runde[1]=48+(char)st;
 SetAPen (rp,1l);
 Move (rp,4l,55l);
 Text (rp,runde,1l);
 Move (rp,11l,64l);
 Text (rp,&(runde[1]),1l);
}
PrintMuster ()
{
 char ziffer[2];short pn=level.p_num;
 UWORD *pzeiger;
 pzeiger=(UWORD *)((long)(pattern)+128l*(long)(level.p_num));
 SetAPen (rp,15l); SetAfPt (rp,pzeiger,-4);
 RectFill (rp,201l,14l,299l,39l);
 RectFill (rp,176l,16l,191l,31l);
 SetAfPt (rp,0l,0); SetAPen (rp,1l);
 ziffer[0]=48+(char)(pn/10);
 pn=pn-10*(pn/10);
 ziffer[1]=48+(char)pn;
 Move (rp,148l,30l);
 Text (rp,ziffer,1l);
 Move (rp,157l,30l);
 Text (rp,&(ziffer[1]),1l);
}
CleanFields()
{
 long loop;
 UWORD *pzeiger;
 for (loop=0l;loop<320l;loop++) level.stones[loop]=0;
 pzeiger=(UWORD *)((long)(pattern)+128l*(long)(level.p_num));
 SetAPen (rp,15l); SetAfPt (rp,pzeiger,-4);
 RectFill (rp,32l,57l,311l,243l);
 SetAfPt (rp,0l,0);
}
paint()
{
 long xloc,yloc;
 xloc=(long)((scr->MouseX-35l)/17);
 yloc=(long)((scr->MouseY-80l)/7l);
 if (!(stone))
 {
  KillStone ((long)(scr->MouseX),(long)(scr->MouseY),35l); 
  level.stones[xloc+yloc*16]=0;
  return (0l);
 }
 do
 {
  SetStone (xloc,yloc,(long)stone,35l);
  level.stones[xloc+yloc*16]=(UBYTE)stone;
  xloc=(long)((scr->MouseX-35l)/17);
  yloc=(long)((scr->MouseY-80l)/7l);
  if ((scr->MouseX>306)||(scr->MouseX<35)) return;
  if ((scr->MouseY>219)||(scr->MouseY<80)) return;
  while (*button&(UBYTE)64)
  {
   if ((scr->MouseX>306)||(scr->MouseX<35)) return;
   if ((scr->MouseY>219)||(scr->MouseY<80)) return;
  }
 } while (1);
}
SaveStage()
{
 char name[50];
 char ziffer[2];short st=(short)stage;
 ziffer[0]=48+(char)(st/10);
 st=st-10*(st/10);
 ziffer[1]=48+(char)st;
 sprintf (name,"Paranoid:levels/runde%c%c",ziffer[0],ziffer[1]);
 if (!(fh=Open(name,1006l)))
 { printf ("No Save-File\n"); CloseMaster (scr,win);}
 Write (fh,&level,322l);
 Close (fh);
}
LoadStage(b1,b2)
long b1,b2;
{
 long x,y;
 char name[50],ziffer[2];
 short st;
 UWORD *pzeiger;
 begin_load:
 st=(short)stage;
 ziffer[0]=48+(char)(st/10);
 st=st-10*(st/10);
 ziffer[1]=48+(char)st;
 sprintf (name,"Paranoid:levels/runde%c%c",ziffer[0],ziffer[1]);
 if (!(fh=Open(name,1004l)))
 { DisplayBeep (scr); stage=0; goto begin_load; }
 Read (fh,&level,322l);
 Close (fh);
 pzeiger=(UWORD *)((long)(pattern)+128l*(long)(level.p_num));
 SetAPen (rp,15l); SetAfPt (rp,pzeiger,-4);
 RectFill (rp,b1,57l,b1+279l,243l);
 SetAfPt (rp,0l,0);
 stonecount=0l;
 for (y=0l;y<20l;y++)
 {
  for (x=0l;x<16l;x++)
  {
   if (level.stones[y*16l+x])
   { SetStone (x,y,(long)(level.stones[y*16l+x]),b2); stonecount++; }
  }
 }
 if (!(stonecount)) { stage++; goto begin_load; }
}
PrintScore()
{
 long loop,wert=10000l,posn=40l;
 long punkte=(long)score;
 SetAPen (rp,1l);
 for (loop=0l;loop<5l;loop++)
 {
  newscore[loop]=(UBYTE)(48l+punkte/wert);
  punkte=punkte-wert*(punkte/wert);
  wert/=10l;
  if (oldscore[loop]!=newscore[loop])
  {
   Move (rp,posn,23l);
   Text (rp,&(newscore[loop]),1l);
  }
  posn+=9l;
  oldscore[loop]=newscore[loop]; 
 }
}
PrintStuff()
{
 char ziffer[2];short st=stage;
 char qwertz[2];short li=lives;
 ziffer[0]=48+(char)(st/10);
 st=st-10*(st/10);
 ziffer[1]=48+(char)st;
 qwertz[0]=48+(char)(li/10);
 li=li-10*(li/10);
 qwertz[1]=48+(char)li;
 SetAPen (rp,1l);
 Move (rp,110l,23l); Text (rp,ziffer,1l);
 Move (rp,119l,23l); Text (rp,&(ziffer[1]),1l);
 Move (rp,150l,23l); Text (rp,qwertz,1l);
 Move (rp,159l,23l); Text (rp,&(qwertz[1]),1l);
}
/***************************************************************************
 *     Hier stehen die HighScore Routinen                                  *
 ***************************************************************************/
PrintHighScore()
{
 long loop;
 char sbuff[10];
 SetAPen (rp,1l);
 for (loop=0l;loop<10l;loop++)
 {
  sprintf (sbuff,"%d",highscore[loop].punkte);
  Move (rp,10l,40l+loop*15l);
  Text (rp,sbuff,(long) strlen(sbuff));
  Move (rp,61l,40l+loop*15l);
  Text (rp,highscore[loop].name,(long) strlen (highscore[loop].name));
 }
}

PutHighScore()
{
 long loop,t;
 GetPicture ("Paranoid:gfx/highscreen.dat",320l,256l,2l);
 for (loop=9l;loop>=0l;loop--)
 {
  if (score<highscore[loop].punkte) break;
 }
 loop++;
 for (t=9l;t>loop;t--)
 {
  highscore[t].punkte=highscore[t-1l].punkte;
  strcpy(highscore[t].name,highscore[t-1l].name);
 }
 highscore[loop].punkte=score;
 PrintHighScore();
 GetName (loop);
 if (!(fh=Open ("Paranoid:highscore",1006l)))
 { printf ("highdata not found\n"); return; }
 Write (fh,highscore,320l);
 Close (fh);
}
GetName (nummer)
long nummer;
{
 long count=0l;
 UBYTE nbuff[40];
 nbuff[0]=0;
 while (1)
 {
  SetAPen (rp,0l);
  RectFill (rp,60l,30l+nummer*15l,300l,43l+nummer*15l);
  SetAPen (rp,1l);
  Move (rp,61l,40l+nummer*15l);
  Text (rp,nbuff,(long)strlen(nbuff));
  if (count>28l) break;
  while (!(*button&(UBYTE)64)); /* Solange,bis Button oben */
  while (*button&(UBYTE)64);  /* Solange,bis Button unten */
  if (CheckRange(220,203,258,244)) break;
  if ((count>0l)&&(CheckRange(61,203,99,244))) { nbuff[--count]=0; continue;}
  if (CheckRange(109,210,212,216))
  {
   nbuff[count]=(UBYTE)(65+(scr->MouseX-109)/8);
   nbuff[++count]=0;
   continue;
  }
  if (CheckRange (109,220,212,226))
  {
   nbuff[count]=(UBYTE)(78+(scr->MouseX-109)/8);
   nbuff[++count]=0;
   continue;
  }
  if (CheckRange (109,230,188,236))
  {
   nbuff[count]=(UBYTE)(48+(scr->MouseX-109)/8);
   nbuff[++count]=0;
   continue;
  }
  if (CheckRange (189,230,196,236))
  { nbuff[count]='-'; nbuff[++count]=0; continue; }
  if (CheckRange (197,230,204,236))
  { nbuff[count]='/'; nbuff[++count]=0; continue; }
  if (CheckRange (205,230,212,236))
  { nbuff[count]='.'; nbuff[++count]=0; continue; }
  if (CheckRange (213,230,220,236))
  { nbuff[count]=' '; nbuff[++count]=0; continue;}
 }
 strcpy (highscore[nummer].name,nbuff);
}
