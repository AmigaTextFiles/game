/*
    ***********************
    *******         *******
    ******* MazezaM *******
    *******         *******
    ***********************

      Copyright (C) 2002
       Malcolm  Tyrrell
      tyrrelmr@cs.tcd.ie

     Amiga Version (C) 2003
      Ventzislav  Tzvetkov
     drHirudo@Amigascne.org

     GameBoy version (C) 2004
       Ventzislav  Tzvetkov
     drHirudo@Amigascne.org
     http://drhirudo.hit.bg
     Compile with GBDK and
     following command line:

   lcc MazezaM.c -o MazezaM.gb


     This code may be used
     and distributed under
     the terms of the GNU
     General Public Licence.

*/

#include <gb.h>
#include <drawing.h>
#include <string.h>
#include <rand.h>

int w,h,i,j,l,t,r,rx,lx,lives;

char *a[20][20],b[20][20];

void fadein(){
 BGP_REG = 0x40U;delay(59); BGP_REG = 0x90U;delay(59); BGP_REG = 0xE4U;}

void fadeout() {
 BGP_REG = OBP0_REG = OBP1_REG = 0x90U;
 delay(59); BGP_REG = OBP0_REG = OBP1_REG = 0x40U;
 delay(59);BGP_REG = OBP0_REG = OBP1_REG = 0x00U;}

void Wait(){
wait_vbl_done();wait_vbl_done();wait_vbl_done();wait_vbl_done();
}

void Level(int mazenumber){int k;
char *n[20],*c[20];
gotogxy(0,0);
switch (mazenumber)
   {
   case 1: { n[0]="Humble Origins";c[0]="©Malcolm Tyrrell";w=7;h=2;
   lx=1;rx=1;a[1][0]=" Ä  Ä  ";a[2][0]=" Ä  ÅÉ ";break; }


   case 2: { n[0]="Easy Does It";c[0]="©Malcolm Tyrrell";w=8;h=3;
   lx=3;rx=2;a[1][0]="  Ä  ÅÇÉ";a[2][0]="  Ä Ä Ä ";
   a[3][0]=" Ä Ä Ä  ";break;}

   case 3: { n[0]="Up, Up and Away";c[0]="©Malcolm Tyrrell";w=5;h=11;
   lx=11;rx=1;a[1][0]="  Ä  ";a[2][0]=" Ä ÅÉ";a[3][0]=" ÅÉ  ";
   a[4][0]="Ä Ä  ";a[5][0]=" Ä Ä ";a[6][0]=" ÅÇÉ ";a[7][0]="Ä Ä  ";
   a[8][0]=" Ä Ä ";a[9][0]=" Ä Ä ";a[10][0]="Ä ÅÉ ";a[11][0]=" Ä   ";break;}

   case 4: { n[0]="To and Fro";c[0]="©Malcolm Tyrrell";w=13;h=6;lx=1;rx=1;
   a[1][0]="   ÅÇÇÇÉ     ";a[2][0]="Ä ÅÇÇÇÉ  ÅÇÉ ";a[3][0]=" Ä ÅÇÉ ÅÇÇÉ  ";
   a[4][0]="Ä Ä  ÅÇÇÇÇÇÉ ";a[5][0]=" ÅÇÉ Ä   ÅÉ  ";a[6][0]="Ä Ä Ä ÅÉ  Ä  ";
   break;}

   case 5: { n[0]="Loop-de-Loop";c[0]="©Malcolm Tyrrell";w=14;h=4;lx=2;rx=4;
   a[1][0]=" ÅÇÇÇÉ ÅÉ ÅÉ  ";a[2][0]="   ÅÉ  ÅÉ  ÅÉ ";
   a[3][0]="ÅÉ  Ä ÅÉ ÅÇÉ  ";a[4][0]="   ÅÇÇÇÇÇÇÉ  Ä";break;}

   case 6: { n[0]="Be Prepared";c[0]="©Malcolm Tyrrell";w=7;h=6;lx=5;rx=3;
   a[1][0]="   Ä   ";a[2][0]=" ÅÇÇÉ  ";a[3][0]=" ÅÇÉ ÅÉ";
   a[4][0]=" Ä Ä Ä ";a[5][0]=" Ä ÅÉ  ";a[6][0]="Ä ÅÉ   ";break;}

   case 7: {n[0]="Two Front Doors";c[0]="©Malcolm Tyrrell";
   w=16;h=7;lx=1;rx=7;a[1][0]="       ÅÇÇÇÇÇÉ  ";
   a[2][0]="  ÅÇÇÉ ÅÇÇÉ Ä Ä ";a[3][0]="ÅÉ ÅÉ ÅÇÇÇÇÉ Ä Ä";
   a[4][0]="ÅÉ     Ä Ä      ";a[5][0]="  ÅÇÇÇÇÇÇÇÇÇÇÇÉ ";
   a[6][0]=" Ä ÅÉ    Ä ÅÇÉ  ";a[7][0]="  Ä   ÅÇÉ     ÅÉ";break;}

   case 8: { n[0]="Through, through";
   c[0]="©Malcolm Tyrrell";w=15;h=4;lx=3;rx=1;
   a[1][0]=" ÅÇÇÉ  ÅÇÇÉ  ÅÉ";a[2][0]=" Ä ÅÉ ÅÉ Ä ÅÉ  ";
   a[3][0]=" Ä ÅÉ ÅÇÇÉ ÅÉ  ";a[4][0]=" Ä ÅÉ  ÅÇÇÉ  Ä ";break;}

   case 9: { n[0]="Double Cross";c[0]="©Malcolm Tyrrell";w=9;h=7;lx=7;rx=3;
   a[1][0]=" Ä  ÅÇÇÉ ";a[2][0]=" Ä  Ä ÅÉ ";a[3][0]=" Ä ÅÇÇÉ Ä";
   a[4][0]="Ä ÅÉ  Ä  ";a[5][0]="  Ä   ÅÇÉ";a[6][0]=" ÅÇÇÇÇÉ  ";
   a[7][0]="  Ä      ";break;}

   case 10: { n[0]="Inside Out";c[0]="©Malcolm Tyrrell";w=14;h=10;lx=8;rx=1;
   a[1][0]="            Ä ";a[2][0]=" ÅÇÇÇÇÇÇÇÇÉ  Ä";
   a[3][0]=" ÅÇÉ       ÅÉ ";a[4][0]=" Ä ÅÇÇÇÇÇÇÉ Ä ";
   a[5][0]=" ÅÇÉ ÅÇÉ  ÅÇÉ ";a[6][0]=" ÅÇÉ   Ä  ÅÇÉ ";
   a[7][0]=" Ä ÅÇÇÇÇÇÉ ÅÉ ";a[8][0]=" Ä Ä Ä    ÅÇÉ ";
   a[9][0]=" ÅÇÇÇÇÇÇÇÇÇÇÉ ";a[10][0]="              ";break;}


   default: {fadeout();color(BLACK,WHITE,SOLID);gprint("  ÑÑ                ÑÑÑÑ                ÑÑÑÑ");
   color(LTGREY,WHITE,SOLID);gprint("      You have  ");color(BLACK,WHITE,SOLID);gprint("ÑÑÑÑ");
   color(LTGREY,WHITE,SOLID);gprint("      Escaped.  ");color(BLACK,WHITE,SOLID);gprint("ÑÑÑÑ     ");
   color(DKGREY,BLACK,SOLID);gprint("WELL DONE!");color(BLACK,WHITE,SOLID);
   gprint(" ÑÑÑÑ                ÑÑÑÑ                ÑÑÑÑ                ÑÑÑÑ                ____                ÑÑÑÑ");
   color(DKGREY,WHITE,SOLID);gprint("ÅÇÉ");color(BLACK,LTGREY,SOLID);
   gprint("ááááááááááááá");color(BLACK,WHITE,SOLID);gprint("ÑÑÑÑ   ");
   color(BLACK,LTGREY,SOLID);gprint("ááááááááááááá");
   for (i=0;i<6;i++)
  {color(BLACK,WHITE,SOLID);gprint("ÑÑÑÑ");color(DKGREY,WHITE,SOLID);gprint("ÜÜÜ");
   color(BLACK,LTGREY,SOLID);gprint("ááááááááááááá");}
   fadein();color(BLACK,WHITE,SOLID);
   for (i=0;i<20;i++) {
   if (i<14 || i>16 ) {gotogxy(i,9);gprint("");}
   if (i >= 14 && i <= 16) {gotogxy(i,22-i);gprint("");}
   Wait();
   if (i==15) {gotogxy(12,5);gprint("Hurray!");}
   if (i==18) {gotogxy(12,5);gprint("       ");}
   if (i<4) {gotogxy(i,9);gprint("_");}
   if ((i>3 && i<14) || i>16) {gotogxy(i,9);gprint(" ");}
   if (i >= 14 && i <= 16) {gotogxy(i,22-i);gprint(" ");}
  }
  delay(8200);fadeout();reset();}
 }
for (i=1;i<h+1;i++) strcpy(&b[i][0],a[i][0]);
l=((20-w)/2);t=((20-h)/2);r=20-l-w;color(BLACK,WHITE,SOLID);
gprint("ÑÑ");color(DKGREY,WHITE,SOLID);
gprint("Level ");if (mazenumber<10) gprintf("0%d",mazenumber);
                   else gprintf("%d",mazenumber);
color(BLACK,WHITE,SOLID); gprint("Ñ");color(LTGREY,WHITE,SOLID);
gprint("Lives ");gprintf("%d",lives);
color(BLACK,WHITE,SOLID);gprint("ÑÑ");

for (i=1;i<t+1;i++) gprint("ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ");

for (i=1;i<h+1;i++){
if (i==lx) for (k=0;k<l;k++) gprint("_");
if (i!=lx) for (k=0;k<l;k++) gprint("Ñ");
color(i%2+1,WHITE,SOLID);gprint(a[i][0]);
color(BLACK,WHITE,SOLID);
if (i==rx) for (k=0;k<r;k++) gprint("_");
if (i!=rx) for (k=0;k<r;k++) gprint("Ñ");
}

for (i=t+h+1;i<17;i++) gprint("ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ");

j=strlen(n[0]);
if (!j) gprint("ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ"); else 
   {for (k=0;k<((18-j)/2);k++) gprint("Ñ");
   gprint(" ");gprint(n[0]);gprint(" ");for (k=0;k<((18-j)/2);k++) gprint("Ñ");}

for (i=0;i<l;i++){gotogxy(i,t+lx);gprint("");
Wait();gotogxy(i,t+lx);gprint("_");
}
gotogxy(i-1,t+lx);gprint("Ö");
i=lx;j=1;

}

void Title(){
int i;

DISPLAY_ON;
mode (M_TEXT_OUT);
gotogxy(0,0);
color(BLACK,WHITE,SOLID);
gprint("ÑÑ       ÑÑ       ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ    ");
color(LTGREY,WHITE,SOLID);gprint("Mazezam");color(BLACK,WHITE,SOLID);
gprint("     ÑÑÑÑ                ÑÑÑÑ");color(DKGREY,WHITE,SOLID);gprint("Original  Ω 2002");
color(BLACK,WHITE,SOLID);gprint("ÑÑÑÑ                ÑÑÑÑ");color(DKGREY,WHITE,SOLID);gprint("Malcolm  Tyrrell");
color(BLACK,WHITE,SOLID);gprint("ÑÑÑÑ                ÑÑÑÑ                ÑÑÑÑ");color(LTGREY,WHITE,SOLID);
gprint(" Gameboy Ω 2004 ");
color(BLACK,WHITE,SOLID);gprint("ÑÑÑÑ                ÑÑÑÑ");color(LTGREY,WHITE,SOLID);gprint("   by drHirudo  ");
color(BLACK,WHITE,SOLID);gprint("ÑÑÑÑ                ÑÑÑÑ");
gprint("ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ                    Press START to play");fadein();for (;;) { if (joypad() & J_START) break;
i++;
}
initrand(i);
}

char close=FALSE,TitleBool=FALSE;

void main() {
int mazeno,ModeID,direction,count;

char Txt[20];

mazeno=1;lives=3;

_cpu=DMG_TYPE;
BGP_REG = OBP0_REG = OBP1_REG = 0x00U;
SHOW_BKG;
HIDE_WIN;
disable_interrupts();
Title();Level(mazeno);

for(;;){

direction=joypad();

if (direction==J_SELECT) {lives--;if (lives>0){
       color(BLACK,LTGREY,SOLID);gotogxy(l+j-3,t+i-1);gprint("ARGH!");delay(1500);
          Level(mazeno);}

if (lives==0) {wait_vbl_done();gotogxy(5,8);color(DKGREY,LTGREY,SOLID);gprint("GAME OVER!");Delay(4200);reset();}
}

if (direction == (J_START|J_SELECT|J_A)) {BGP_REG = 0x00U;reset();}

if (direction==J_RIGHT && (i==rx && j==w)) {
gotogxy(l+j-1,t+i);gprint(" ");
for (i=l+w;i<20;i++) {gotogxy(i,t+rx);gprint("");Wait();
gotogxy(i,t+rx);gprint("_");}
color(LTGREY,WHITE,SOLID);
i=rand()%6;
switch (i)
{
case 0: {gotogxy(12,t+rx);gprint("Hurray!A");break;}

case 1: {gotogxy(12,t+rx);gprint("Hurrah!A");break;}

case 2: {gotogxy(15,t+rx);gprint("Yes!A");break;}

case 3: {gotogxy(13,t+rx);gprint("Great!A");break;}

case 4: {gotogxy(11,t+rx);gprint("Yee-hah!A");break;}

default:{gotogxy(15,t+rx);gprint("Yay!A");}
   }
Delay(799);Level(++mazeno);
 direction=0;}
color (BLACK,WHITE,SOLID);
if (direction==J_RIGHT && j<w) if (b[i][j]==' '){
gotogxy(l+j-1,t+i);gprint(" ");j++;
gotogxy(l+j-1,t+i);gprint("");} else

if (b[i][w-1]==' ') {j++;
for (ModeID=w-1;ModeID>0;ModeID--) b[i][ModeID]=b[i][ModeID-1];
b[i][0]=' ';b[i][w]=0;
gotogxy(l,t+i); color ((i%2)+1,WHITE,SOLID);gprint(&b[i][0]);
color (BLACK,WHITE,SOLID);
gotogxy(l+j-1,t+i);gprint("");}

if (direction==J_LEFT && j>1) if (b[i][j-2]==' '){
gotogxy(l+j-1,t+i);gprint(" ");j--;
gotogxy(l+j-1,t+i);gprint("");} else

if (b[i][0]==' ') {j--;
for (ModeID=1;ModeID<w;ModeID++) b[i][ModeID-1]=b[i][ModeID];
b[i][w-1]=' ';
for (count=0;count<w+1;count++) Txt[count]=b[i][count];
gotogxy(l,t+i); color ((i%2)+1,WHITE,SOLID);gprint(&b[i][0]);
color (BLACK,WHITE,SOLID);
gotogxy(l+j-1,t+i);gprint("");}

if (direction==J_DOWN && i<h) if (b[i+1][j-1]==' '){
gotogxy(l+j-1,t+i);gprint(" ");i++;
gotogxy(l+j-1,t+i);gprint("");}

if (direction==J_UP && i>1) if (b[i-1][j-1]==' '){
gotogxy(l+j-1,t+i);gprint(" ");i--;
gotogxy(l+j-1,t+i);gprint("");}

direction=0;

Wait();
}

}
