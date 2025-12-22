/*
    ***********************
    *******         *******
    ******* MazezaM *******
    *******         *******
    ***********************

      Copyright (C) 2002
       Malcolm  Tyrrell
      tyrrelmr@cs.tcd.ie

    Amiga Version (C) 2003-04
     Ventzislav  Tzvetkov
    drHirudo@Amigascne.org
    http://drhirudo.hit.bg

   GameBoy version (C) 2004
     Ventzislav  Tzvetkov

 Oric Atmos version (C) 2004
     Ventzislav  Tzvetkov

compile with: cl65 MazezaM.c -t atmos -o MazezaM.tap
Then: tap2dat MazezaM.tap MazezaM.dat 

  Since CC65 is buggy enough, (or at least the Atmos support),  this
game isn't in pure C. I use asm (""); at the places where I wouldn't
able to bypass the bugs. At the end the code became the mess as it's
now. Sorry about this.

Check for the 4 colors on scanline effect, and this
without losing space for serial bytes!

     This code may be used
     and distributed under
     the terms of the GNU
     General Public Licence.

*/


#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define __ATMOS__ 1
#include <atmos.h>

#define LEFT    1
#define RIGHT   2
#define DOWN    3
#define UP      4
#define LEVELS 10      // Easily extended.

#define CHARSET ((unsigned char*)0xB510) // Location of the modified characters.

#define KEYPRESS ((unsigned char*)0x0208) // Contains code of the last pressed key.

void clear() {asm ("lda #$00\nsta $026B\nsta $BBA4\nsta $0268\nsta $269");
asm ("lda #$07\nsta $026C\njsr $CCCE");}    /* CLS and other misc inits. */

static char PseudoChars[] = {
                      0x1E, 0x35,/*0x2B - alternative */
                      0x1E, 0x2D,/*0x0C - alternative */
                      0x1E, 0x0C,/*0x2D - alternative */
                      0x1E, 0x33, /* Man = " */

                      0x3F,0x35,0x2B,0x35,0x2B,0x35,0x2B,0x3F, // #

                      0x3F,0x35,0x2A,0x35,0x2A,0x35,0x2A,0x3F, // $

                      0x3F,0x15,0x2A,0x15,0x2A,0x15,0x2A,0x3F, // %

                      0x3F,0x15,0x2B,0x15,0x2B,0x15,0x2B,0x3F, // &

                      0x3D,0x3D,0x3D,0x00,0x37,0x37,0x37,0x00, // '

                      0x14,0x3e,0x14,0x3E,0x14,0x3E,0x14,0x3F, // (

                      0x00,0x07,0x38,0x00,0x00,0x23,0x1C,0x00, // )

                      0x3F,0x1F,0x2F,0x3F,0x3F,0x3D,0x3E,0x3F, // *

                      0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x3F, // +

                      0x02,0x02,0x02,0x3F,0x08,0x08,0x08,0x3F, // .

                      0x08,0x2A,0x1C,0x08,0x1C,0x2A,0x08,0x00  // -

};

char Text1[]={0x0a,COLOR_CYAN,'m','a'+' ','z'+' ','e'+' ','z'+' ','a'+' ','m',0x07,0x08,
              COLOR_GREEN,'o','r'+' ','i'+' ','c'+' ',' ','v','e'+' ',
              'r'+' ','s'+' ','i'+' ','o'+' ','n'+' ',' ',0x60,' ','2',
              '0','0','4',COLOR_WHITE,
              COLOR_BLUE,'v','e'+' ','n'+' ','t'+' ','z'+' ','i'+' ','s'+' ','l'+' ',
              'a'+' ','v'+' ',' ','t','z'+' ','v'+' ','e'+' ','t'+' ','k'+' ',
              'o'+' ','v'+' ',COLOR_WHITE,
              COLOR_GREEN,'K','E','Y','S',0xBA,COLOR_MAGENTA,'m','o'+' ','v'+' ','e'+' ',' ','=',' ','a','r'+' ','r'+' ','o'+' ','w'+' ','s'+' ',
              COLOR_RED,'r','e','t','r','y',' ','l','e','v','e','l',' ','=',' ','r'+' ',
              COLOR_RED,'q','u','i','t',' ',' ',' ','g','a','m','e',' ','=',' ','q'+' ',
              COLOR_WHITE,'p','r'+' ','e'+' ','s'+' ','s'+' ',' ','s','p','a','c','e',' ',
              't'+' ','o'+' ',' ','s'+' ','t'+' ','a'+' ','r'+' ','t'+' ',
              COLOR_BLUE+16,COLOR_BLUE,'v','i','s','i','t',' ',COLOR_YELLOW,'h'+' ','t'+' ','t'+' ','p'+' ',':','/','/',
              'd'+' ','r'+' ','h'+' ','i'+' ','r'+' ','u'+' ','d'+' ','o'+' ','.','h'+' ',
              'i'+' ','t'+' ','.','b'+' ','g'+' '};

char LText[]={'H','u'+160,'r'+160,'r'+160,'a'+160,'y'+160,161,
              'H','u'+160,'r'+160,'r'+160,'a'+160,'h'+160,161,
              'Y','e'+160,'s'+160,161,
              'G','r'+160,'e'+160,'a'+160,'t'+160,161,
              'Y','e'+160,'e'+160,'a'+160,'h'+160,'a'+160,'h'+160,161,
              'Y','a'+160,'y'+160,161,
              'A','R','G','H',161,
              'G','A','M','E',160,'O','V','E','R',
              COLOR_RED,'y','o'+' ','u'+' ',' ','h'+' ','a'+' ','v'+' ','e'+' ',
              COLOR_RED,'e'+' ','s'+' ','c'+' ','a'+' ','p'+' ','e'+' ','d'+' ','.',
              COLOR_MAGENTA+16,COLOR_BLUE,'w','e','l','l',' ','d','o','n','e','!',COLOR_MAGENTA,
              'd',COLOR_BLACK+16,COLOR_BLACK,'h','u'+' ','r'+' ','r'+' ','a'+' ','y'+' ','!'};

int w,h,i,j,l,t,r,rx,lx,lives,k; //variables
char *a[12],b[20][20],NumberString[]={'0','0',0x00};

void Level(int mazenumber){ // render the level. The actual levels are here.

char *LevelName;
asm ("jsr $CCCE");
CHARSET[1]=0x35;
switch (mazenumber)
   {
   case 1: { LevelName="Humble Origins";w=7;h=2;
   lx=1;rx=1;a[1]=" #  #  ";a[2]=" #  $& ";break; }

   case 2: { LevelName="Easy Does It";w=8;h=3;
   lx=3;rx=2;a[1]="  #  $%&";a[2]="  # # # ";
   a[3]=" # # #  ";break;}

   case 3: { LevelName="Up Up and Away";w=5;h=11;
   lx=11;rx=1;a[1]="  #  ";a[2]=" # $&";a[3]=" $&  ";
   a[4]="# #  ";a[5]=" # # ";a[6]=" $%& ";a[7]="# #  ";
   a[8]=" # # ";a[9]=" # # ";a[10]="# $& ";a[11]=" #   ";break;}

   case 4: { LevelName="To and Fro";w=13;h=6;lx=1;rx=1;
   a[1]="   $%%%&     ";a[2]="# $%%%&  $%& ";a[3]=" # $%& $%%&  ";
   a[4]="# #  $%%%%%& ";a[5]=" $%& #   $&  ";a[6]="# # # $&  #  ";
   break;}

   case 5: { LevelName="Loop de Loop";w=14;h=4;lx=2;rx=4;
   a[1]=" $%%%& $& $&  ";a[2]="   $&  $&  $& ";
   a[3]="$&  # $& $%&  ";a[4]="   $%%%%%%&  #";break;}

   case 6: { LevelName="Be  Prepared";w=7;h=6;lx=5;rx=3;
   a[1]="   #   ";a[2]=" $%%&  ";a[3]=" $%& $&";
   a[4]=" # # # ";a[5]=" # $&  ";a[6]="# $&   ";break;}

   case 7: {LevelName="Two  Front Doors";w=16;h=7;lx=1;rx=7;
   a[1]="       $%%%%%&  ";
   a[2]="  $%%& $%%& # # ";a[3]="$& $& $%%%%& # #";
   a[4]="$&     # #      ";a[5]="  $%%%%%%%%%%%& ";
   a[6]=" # $&    # $%&  ";a[7]="  #   $%&     $&";break;}

   case 8: { LevelName="Through and  through";w=15;h=4;lx=3;rx=1;
   a[1]=" $%%&  $%%&  $&";a[2]=" # $& $& # $&  ";
   a[3]=" # $& $%%& $&  ";a[4]=" # $&  $%%&  # ";break;}

   case 9: { LevelName="Double Cross";w=9;h=7;lx=7;rx=3;
   a[1]=" #  $%%& ";a[2]=" #  # $& ";a[3]=" # $%%& #";
   a[4]="# $&  #  ";a[5]="  #   $%&";a[6]=" $%%%%&  ";
   a[7]="  #      ";break;}

   case 10: { LevelName="Inside Out";w=14;h=10;lx=8;rx=1;
   a[1]="            # ";a[2]=" $%%%%%%%%&  #";
   a[3]=" $%&       $& ";a[4]=" # $%%%%%%& # ";
   a[5]=" $%& $%&  $%& ";a[6]=" $%&   #  $%& ";
   a[7]=" # $%%%%%& $& ";a[8]=" # # #    $%& ";
   a[9]=" $%%%%%%%%%%& ";a[10]="              ";break;}

   default:  /* No more levels. Game Completed. */
   printf ("         ''''              -            ");
   asm ("lda #$3\nsta $BBBB");
   printf (" ''''''''''''         -             -   ");
   asm ("lda #$6\nsta $BBE3");
   printf (" ''''''''''''  -                        ");
   asm ("lda #$4\nsta $BC05");
   printf (" ''''''''''''                           ");
   printf (" ''''''''''''                           ");
   printf (" ''''''''''''            ");
   asm ("ldx #247\nTextA: lda _LText-197,x\njsr putchar\ninc $269\ninx\n bne TextA");
   printf ("       ''''''''''''            ");
   asm ("ldx #247\nTextB: lda _LText-188,x\njsr putchar\ninc $269\ninx\n bne TextB");
   printf ("       ''''''''''''          ");
   asm ("ldx #241\nTextC: lda _LText-173,x\njsr putchar\ninc $269\ninx\n bne TextC");
   printf ("   ''''''''''''            ");
   asm ("ldx #248\nTextD: lda _LText-165,x\njsr putchar\ninc $269\ninx\n bne TextD");
   printf ("        ''''''''''''                           ");
   printf (" ''''''''''''                           ");
   printf (" ''''''''''''                           ");
   printf (" ++++++++++++                           ");
   asm ("lda #$05\njsr putchar\ninc $269");
   for (i=0;i<12;i++) asm ("lda #172\njsr putchar\ninc $269");
   printf ("$%%%%%%%%%%&");for (i=0;i<21;i++) asm ("lda #170\njsr putchar\ninc $0269");
   printf (" ");
   asm ("lda #$05\njsr putchar\ninc $269");

   for (i=0;i<12;i++) asm ("lda #172\njsr putchar\ninc $269");
   asm ("lda #$04\njsr putchar\ninc $269\n");
   printf ("     ");asm ("lda #$05\njsr putchar\ninc $269\n");
   for (i=0;i<21;i++) asm ("lda #170\njsr putchar\ninc $0269");
   for (k=16;k<27;k++) {printf(" ");
   asm ("lda #$04\njsr putchar\ninc $269");
   for (i=0;i<12;i++) asm ("lda #170\njsr putchar\ninc $269");
   printf (")))))))");
   for (i=0;i<21;i++) asm ("lda #170\njsr putchar\ninc $0269");}
   printf(" ");
   asm ("lda #13\nsta $268");
   for (k=1;k<40;k++) {
  asm("lda _k\nsta $269\nlda #34\njsr putchar\n");
  asm("ldy #88\nWaitVBL_done: dex\nbne WaitVBL_done\ndey\nbne WaitVBL_done");
  
  if (k<13) asm("lda #43\njsr putchar\n");
  else asm ("lda #$20\njsr putchar\n");
  if (k>25 && k<29) asm("dec $268");
  if (k==28) {asm ("lda #7\nsta $BD01\njsr $FAE1");/* Print hurray and ZAP.*/}
  if (k==31) asm ("lda #13\nsta $268\nlda #0\nsta $BD01");
  asm ("inc $269");

  if (k%2)  /* Swap Stars Colors */
  asm ("lda #$6\nsta $BBBB\nlda #$4\nsta $BBE3\nlda #$3\nsta $BC05"); else
  asm ("lda #$3\nsta $BBBB\nlda #$6\nsta $BBE3\nlda #$4\nsta $BC05");
}
 for (i=1;i<5000;i++) {asm ("lda $0208\nsta _k");
  if (k==132) break;
  if (i%2)  /* Swap Stars Colors */
  asm ("lda #$6\nsta $BBBB\nlda #$4\nsta $BBE3\nlda #$3\nsta $BC05"); else
  asm ("lda #$3\nsta $BBBB\nlda #$6\nsta $BBE3\nlda #$4\nsta $BC05");}
  clear();
  printf("This  Game is also available  for Amiga;Apple 2; GameBoy and  Sinclair. Visit mywebsite for more information. Thanks forplaying :}");
  for (i=1;i<100;i++) {
  asm("ldy #88\nWaitVBL_end:  dex\nbne WaitVBL_end\ndey\nbne WaitVBL_end");
  asm ("lda $0208\nsta _k");
  if (k==132) break;
 } asm ("ldy #255\nEndWait:  dex\nbne EndWait\ndey\nbne EndWait\njsr _clear");return;
}
if (k) asm("jsr $FA9F");
for (i=1;i<h+1;i++) strcpy(&b[i][0],a[i]);
l=((40-w)/2);t=((28-h)/2);r=38-l-w;
printf(" ''  ");

printf("- Level  ");
NumberString[0]='0'+mazenumber/10;
NumberString[1]='0'+mazenumber%10;
printf(&NumberString);
NumberString[0]='0'+lives/10;
NumberString[1]='0'+lives%10;
printf(" -  ''' - ");printf("Lives ");printf(&NumberString);
printf(" - '' ");
asm("lda #$06\nsta $BBAB\nlda #$01\nsta $BBBF\nlda #$07\nsta $BBBA\nsta $BBCC");

for (i=0;i<t;i++) printf(" '''''''''''''''''''''''''''''''''''''' ");
for (i=1;i<h+1;i++){k=i%6+1;
asm ("lda _k\njsr putchar\ninc $0269");
if (i==lx) {for (k=0;k<l;k++) asm ("lda #43\njsr putchar\ninc $0269");}
if (i!=lx) for (k=0;k<l;k++) asm ("lda #172\njsr putchar\ninc $0269");

for(j=0;j<w;j++) /* Print Level Part */
{k=b[i][j];asm("lda _k\njsr putchar\ninc $269");}

if (i==rx) {for (k=0;k<r;k++) asm ("lda #43\njsr putchar\ninc $0269");
           printf(" ");}
if (i!=rx) {for (k=0;k<r;k++) asm ("lda #172\njsr putchar\ninc $0269");
           printf(" ");}
}
 
for (i=t+h;i<25;i++) printf(" '''''''''''''''''''''''''''''''''''''' ");

j=strlen(LevelName);printf(" ");
for (k=0;k<((38-j)/2);k++) printf("'");k=((mazenumber+3)%6)+1;
asm ("lda _k\njsr putchar\ninc $269");
printf(LevelName);asm ("lda #$07\njsr putchar\ninc $269");
for (k=0;k<((34-j)/2);k++) printf("'");
k=t+lx+1;asm("lda _k\nsta $268");
for (i=1;i<l+1;i++){
asm("lda _i\nsta $269\nlda #34\njsr putchar\n");

asm("ldy #106\nWaitTOF: dex\nbne WaitTOF\ndey\nbne WaitTOF");
asm("lda #43\njsr putchar\n");
}
asm("lda #40\njsr putchar\ninc $269\nlda #34\njsr putchar");
i=lx;j=1;asm ("jsr $FB14");
}

void main() { int mazeno,ModeID,direction,count;

clear(); // So it wouldn't show the modified characters.
asm ("lda #$04\nsta $024E\nlda #$2A\nsta $026A"); //Turn off CAPS and speed keyboard

// redefine characters.
for (ModeID=0;ModeID<96;ModeID++) {CHARSET[ModeID]=PseudoChars[ModeID]; }

for (;;) {                       /* Game's main cycle. We never leave from here. */
mazeno=1;lives=3;clear();

/* Title */

asm ("lda #$27\nsta $BBA8\nsta $BBA9\n");
asm ("sta $BBBB\nsta $BBBC\nsta $BBBD");
asm ("ldx #$83\nprint1: sta $BBCD,x\ndex\nbne print1");
asm ("ldx #$11\nPrintBrick1: sta $BC67,x\nsta $BC8F,x\nsta $BCB7,x\n");
asm ("sta $BCDF,x\nsta $BD07,x\nsta $BD2F,x\nsta $BD57,x\ndex\nbne PrintBrick1");
asm ("ldx #$58\nPrintBrick2: sta $BD7f,x\ndex\nbne PrintBrick2");

asm ("ldx #$0B\nprint3: lda _Text1-1,x\nsta $BC7E,x\nsta $BCA6,x\ndex\nbne print3");
asm ("ldx #$15\nprint4: lda _Text1+10,x\nsta $BCF1,x\nlda _Text1+104,x\nsta $BF48,x\nlda _Text1+31,x\nsta $BD41,x\ndex\nbne print4");
asm ("ldx #$06\nprint5: lda _Text1+52,x\nsta $BE10,x\ndex\nbne print5");

asm ("ldx #$0E\nprint6: lda _Text1+58,x\nsta $BE5C,x\ndex\nbne print6");
asm ("ldx #$10\nprint7: lda _Text1+72,x\nsta $BEAB,x\nlda _Text1+88,x\nsta $BED3,x\ndex\nbne print7");

asm ("ldx #$1f\nprint8: lda _Text1+125,x\nsta $BFB7,x\ndex\nbne print8");
asm ("key: inc _k\nlda $0208\ncmp #$84\nbne key"); //Wait for space.
srand (k);
Level(mazeno); // Start game.

for(;;){
asm ("lda $0208\nsta _k");
direction=0;
if (lives==0) k=177;
switch (k){
    case 145: lives--;if (lives==0) break;
              asm ("jsr $FAB5\ndec $268\ninc $269\ninc $269\n");
              asm("ldx #5\nArgh: lda _LText+35,x\njsr putchar\ndec $269\ndex\nbne Argh");
              for(count=0;count<38;count++)
              {asm("ldy #88\nWaitViBL:  dex\nbne WaitViBL\ndey\nbne WaitViBL");
              asm ("lda $0208\nsta _k");
              if (k==132) break;} 
              if (lives>0) {k=0;Level(mazeno);}break;
    case 156: direction=UP;break;

    case 169: direction=7;break; /* Escape Pressed */

    case 172: direction=LEFT;break;

    case 177: asm ("jsr $facb\nlda #14\n sta $268\nlda #24\nsta $269");
              asm ("lda #48\nsta $BBC8\nsta $BBC9\n");
              asm("ldx #$9\nOver: lda _LText+40,x\njsr putchar\ndec $269\ndex\nbne Over");
              for(count=0;count<50;count++)
              {  
              asm("ldy #88\nWaitVBL_end:  dex\nbne WaitVBL_end\ndey\nbne WaitVBL_end");
              asm ("lda $0208\nsta _k");
              if (k==132) break;   }
              direction=7;break; /* Q pressed */

    case 180: direction=DOWN;break;
    case 188: direction=RIGHT;break;

    default: ModeID++;if (ModeID>1250) CHARSET[1]=0x35;
    if (ModeID>2550) {CHARSET[1]=0x2B;ModeID=0;}break;
}
k=t+i+1;asm("lda _k\nsta $268");
k=l+j;  asm("lda _k\nsta $269");

if (!direction) continue;
if (direction==5) {k=1;Level(++mazeno);ModeID=0;if (mazeno>LEVELS) direction=7; else continue;}

if (direction==RIGHT && (i==rx && j==w)) {
CHARSET[1]=0x35;
asm ("lda #32\njsr putchar\n");l++;
for (i=l+w;i<39;i++){
asm("lda _i\nsta $269\nlda #34\njsr putchar\n");

asm("ldy #106\nWaitVBL: dex\nbne WaitVBL\ndey\nbne WaitVBL");
asm("lda #43\njsr putchar\n");
}
 asm("lda #34\njsr putchar\n");
 asm("dec $268");
 i=rand()%6;
 switch (i)  // Print joytext
{case 0: asm("ldx #$7\ncase0: lda _LText-1,x\njsr  putchar\ndec $269\ndex\n bne case0");break;
 case 1: asm("ldx #$7\ncase1: lda _LText+6,x\njsr  putchar\ndec $269\ndex\n bne case1");break;
 case 2: asm("ldx #$4\ncase2: lda _LText+13,x\njsr putchar\ndec $269\ndex\n bne case2");break;
 case 3: asm("ldx #$6\ncase3: lda _LText+17,x\njsr putchar\ndec $269\ndex\n bne case3");break;
 case 4: asm("ldx #$8\ncase4: lda _LText+23,x\njsr putchar\ndec $269\ndex\n bne case4");break;
 default:asm("ldx #$4\ncase5: lda _LText+31,x\njsr putchar\ndec $269\ndex\n bne case5");break;
} 
 asm ("LDX #$06\nSOUNDL1: LDA #$00\nSTA $02E0,X\nDEX\nBPL SOUNDL1\nINC $02E1\n");
 asm ("SOUND4: LDX #$03\nDEC $2E3\nBPL SOUND3\nLDY #$08");
 asm ("INC $02E5\nJSR $FB40");
 asm ("WAIT:  DEX\nBNE WAIT\nDEY\nBEQ SOUND4\nJMP WAIT");
 asm ("SOUND3:   LDA #$00\nSTA $02E5\nJSR $FB40\n");
 k=1;lives++;Level(++mazeno);ModeID=0;if (mazeno>LEVELS) direction=7; else continue;}

if (direction==7) break;

if (direction==RIGHT && j<w) if (b[i][j]==' '){
j++;asm("lda #$20\njsr putchar\ninc $269\nlda #34\njsr putchar\n");
CHARSET[1]=0x35;ModeID=0;}
else
if (b[i][w-1]==' ') {j++;
for (k=w-1;k>0;k--) b[i][k]=b[i][k-1];
b[i][0]=' ';b[i][w]=0;
k=l+1;asm("lda _k\nsta $269");for(count=0;count<w;count++)
{k=b[i][count];asm("lda _k\njsr putchar\ninc $269");}
k=l+j;asm("lda _k\nsta $269\nlda #34\njsr putchar");
CHARSET[1]=0x35;ModeID=0;}

if (direction==LEFT) if (j>1) if (b[i][j-2]==' '){
j--;
asm("lda #$20\njsr putchar\ndec $269\nlda #34\njsr putchar\n");
CHARSET[1]=0x2B;ModeID=0;} else 
if (b[i][0]==' ') {j--;
for (count=1;count<w;count++) b[i][count-1]=b[i][count];
b[i][w-1]=' ';
k=l+1;asm("lda _k\nsta $269");for(count=0;count<w;count++)
{k=b[i][count];asm("lda _k\njsr putchar\ninc $269");}
k=l+j;asm("lda _k\nsta $269\nlda #34\njsr putchar");
CHARSET[1]=0x2B;ModeID=0;
}

if (direction==DOWN && i<h) if (b[i+1][j-1]==' '){
i++;
asm("lda #$20\njsr putchar\ninc $268\nlda #34\njsr putchar\n");
CHARSET[3]=0x0C;CHARSET[5]=0x2D;ModeID=0;}

if (direction==UP && i>1) if (b[i-1][j-1]==' '){
i--;
asm("lda #$20\njsr putchar\ndec $268\nlda #34\njsr putchar\n");
CHARSET[3]=0x2D;CHARSET[5]=0x0C;ModeID=0;}

if (ModeID){ModeID=0;
 asm ("LDX #$06\nSOUND1: LDA #$00\nSTA $02E0,X\nDEX\nBPL SOUND1\nINC $02E1\nLDA #$46\nSTA $02E3\nLDA #$09\nSTA $02E5\nJSR $FB40\nLDY #$24");}
 else asm ("LDY #105");
 asm ("WAITI:    DEX\nBNE WAITI\nDEY\nBNE WAITI\nLDA #$00\nSTA $02E5\nJSR $FB40\n");

   }
  }
}

/* tap2dat.c Since CC65 doesn't give working with AmOric TAPs 

#include <stdio.h>

unsigned char buf[48*1024];
unsigned char head[14]={0x16,0x16,0x16,0x24,0,0,0x80,0xc7,0,0,0x06,0x0,0,0 };

main(int argc, char **argv)
{
int i;
    unsigned int j, end, lastptr, adr;
    FILE *in,*out;
    if (argc!=3) { 
        perror("Usage : bin2tap outputfile <Oric-Tape-file>\n");
        exit(0);
    }
    in=fopen(argv[1],"r");
    if (in==NULL) { perror("Can't open input file\n"); exit(1); }
    out=fopen(argv[2],"wb");
    if (out==NULL) { perror("Can't open file for writing\n"); exit(1); }
    fseek(in, 0, SEEK_END);
    i=ftell(in);
    rewind(in);
    fseek(in, 14, SEEK_SET);
    fread(buf,1,i-14,in);
    end=0x0600+(i-14); head[8]=end>>8; head[9]=end&0xFF;
    fwrite(head,1,14,out);
    fwrite(buf,1,i-13,out); fclose(out);fclose(in);
}

*/
