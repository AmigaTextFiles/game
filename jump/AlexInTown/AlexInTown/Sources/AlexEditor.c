/* All this source is free to use. I am not responsible for any damage */
/* this product may make.                                              */
/* New in version 1.2:                                                 */
/*                         - New enemies.                              */
/*                         - Smaller code.                             */
/*                         - Faster Level Renderer.                    */


#include <stdio.h>

#include <intuition/intuition.h>

#include "AlexEditor.h"

/* For saving the Level */
#include <libraries/dos.h>

#include <libraries/asl.h> /* For the ScreenMode Requester */

void NewLevel();
void RendLevel();
void Special();
UWORD Level[32][24];
/* ^ Here we keep the level data - 32*24 Words = 1536 bytes for level */

void grid();

 struct FileHandle *file_handle;
 long bytes_written;
 long bytes_read;

main()
{
BOOL close=FALSE,Grid=FALSE;
UBYTE charfont,APen,BPen,special=0;
UWORD fonts;
SHORT x,y;
struct ScreenModeRequester *ScreenRequest;
ULONG ModeID;

/* Open the Intuition library: */
  IntuitionBase = (struct IntuitionBase *)
    OpenLibrary( "intuition.library", 0 );
  if( !IntuitionBase )
    exit();
/* Open the Graphics library: */
  GfxBase = (struct GfxBase *)
    OpenLibrary( "graphics.library", 0 );
  if( !GfxBase )
  {
  CloseLibrary( IntuitionBase );
  exit();    
  }
/* We will now try to open the screen: */


    if (ScreenRequest=(struct ScreenModeRequester *)AllocAslRequestTags(
                                 ASL_ScreenModeRequest,
                                 ASLSM_TitleText, (ULONG) "Pick 320x256 Screenmode ",
                                 ASLSM_PositiveText, (ULONG) "Ok",
                                 ASLSM_NegativeText, (ULONG) "Cancel",
                                 ASLSM_MinWidth, 320,
                                 ASLSM_MinHeight, 256,
                                 ASLSM_MinDepth, 8,
                                 ASLSM_MaxDepth, 8,
                                 TAG_DONE))
    {
    if (!AslRequestTags(ScreenRequest,    ASLSM_TitleText, (ULONG) "Pick 4Bit 320x256 Screenmode ",
                                 ASLSM_PositiveText, (ULONG) "Ok",
                                 ASLSM_NegativeText, (ULONG) "Cancel",
                                 ASLSM_MinWidth, 320,
                                 ASLSM_MinHeight, 256,
                                 ASLSM_MinDepth, 4,
                                 ASLSM_MaxDepth, 8,
                                 TAG_DONE))
        {
        printf("Error: Invalid ScreenMode\n");
        exit(-1);
        } else {
            ModeID=ScreenRequest->sm_DisplayID;}
    }

 my_screen = (struct Screen *)
 OpenScreenTags( NULL, SA_DisplayID,ModeID,SA_Width,320,
SA_Height, 256, SA_Depth,     4,
SA_Colors,      ScreenColors, SA_Title,"Alex in Town Level Editor",TAG_DONE );


  if( !my_screen )
  {
   CloseLibrary( GfxBase );
   CloseLibrary( IntuitionBase );
   exit();
   }

 my_new_window.Screen = my_screen;
 my_window = (struct Window *) OpenWindow( &my_new_window );

if ( !my_window )
  {
    /* Could NOT open the Window! */
    
    /* Close the Intuition Library since we have opened it: */
   CloseScreen( my_screen );
   CloseLibrary( GfxBase );   
   CloseLibrary( IntuitionBase );
   exit();  
  }

NewLevel();

SetFont( my_window->RPort, &AlexTownFont);
SetMenuStrip( my_window, &my_menu );
SetRast(my_window->RPort,8);
RendLevel();SetAPen(my_window->RPort,15);
for (fonts=128;fonts<157;fonts+=2)
{Move(my_window->RPort,21,(fonts-128)*5+40);
charfont=fonts;
Text(my_window->RPort,&charfont,1);
Move(my_window->RPort,31,(fonts-128)*5+40);
charfont++;
Text(my_window->RPort,&charfont,1);}
charfont++;
Move(my_window->RPort,21,190);Text(my_window->RPort,&charfont,1);
for (fonts=0;fonts<8;fonts++){SetAPen(my_window->RPort,fonts);
RectFill(my_window->RPort,0,fonts*10+32,9,fonts*10+41);SetAPen(my_window->RPort,fonts+8);
RectFill(my_window->RPort,10,fonts*10+32,19,fonts*10+41); }
SetAPen(my_window->RPort,1);SetBPen(my_window->RPort,7);
Move(my_window->RPort,7,199);Text(my_window->RPort,"GRID",4);
Move(my_window->RPort,7,208);Text(my_window->RPort,"CHAR",4);
SetAPen(my_window->RPort,7);SetBPen(my_window->RPort,0);
Move(my_window->RPort,7,124);Text(my_window->RPort,"S",1);
Move(my_window->RPort,7,134);Text(my_window->RPort,"P",1);
Move(my_window->RPort,7,144);Text(my_window->RPort,"E",1);
Move(my_window->RPort,7,154);Text(my_window->RPort,"C",1);
Move(my_window->RPort,7,164);Text(my_window->RPort,"I",1);
Move(my_window->RPort,7,174);Text(my_window->RPort,"A",1);
Move(my_window->RPort,7,184);Text(my_window->RPort,"L",1);

charfont=147;APen=7;BPen=8;


  /* Stay in the while loop until the end */
  while( close == FALSE )
  {
SetAPen(my_window->RPort,APen);SetBPen(my_window->RPort,BPen);
Move(my_window->RPort,19,219);
Text(my_window->RPort,&charfont,1);
fonts=*string_info1.Buffer;
if (fonts>31 && fonts<128) {charfont=fonts;*string_info1.Buffer=0;
SetAPen(my_window->RPort,8);RectFill(my_window->RPort,110,221,263,226);}

/* Heavy code again. Sorry, again no time to optimize it */
if (special>1) {fonts=my_string_info.LongInt;
if (special==2 && fonts>0 && fonts<21){Level[1][23]=fonts;/* A */
special=FALSE;RendLevel();if (Grid) grid();}

if (special==3 && fonts>0 && fonts<28) {
Level[2][23]=fonts;/* CAR */
special=FALSE;RendLevel();if (Grid) grid();}

if (special==4 && fonts>0 && fonts<31){Level[3][23]=fonts;/* GB */
special=FALSE;RendLevel();if (Grid) grid();}

if (special==5 && fonts>0 && fonts<31){Level[4][23]=fonts;/* K1 */
special=FALSE;RendLevel();if (Grid) grid();}

if (special==6 && fonts>0 && fonts<31){Level[5][23]=fonts;/* BI */
special=FALSE;RendLevel();if (Grid) grid();}

if (special==7) {Level[6][23]=1;/* C */
special=FALSE;RendLevel();if (Grid) grid();}
if (special==8) {Level[7][23]=1;/* Three Boys */
special=FALSE;RendLevel();if (Grid) grid();}
}
    /* Wait until we have recieved a message: */
  Wait( 1 << my_window->UserPort->mp_SigBit );

    /* As long as we can collect messages successfully we stay in the */
    /* while-loop: */
  while(my_message = (struct IntuiMessage *) GetMsg(my_window->UserPort))
   { 
    if (close)
       break;
x     = my_message->MouseX; /* X position of the mouse. */
y     = my_message->MouseY; /* Y position of the mouse. */
y+=3;
if (y<40) 
my_window->Flags=SMART_REFRESH|REPORTMOUSE|BACKDROP|BORDERLESS|ACTIVATE;
else 
{my_window->Flags=SMART_REFRESH|REPORTMOUSE|BACKDROP|BORDERLESS|ACTIVATE|RMBTRAP;
if (special && x>119 && y>114 && x<242 && y<215) {
if (my_message->Code == SELECTDOWN) {if (y>191 && y<199) { special=2;SetAPen(my_window->RPort,7);
SetBPen(my_window->RPort,8);Move(my_window->RPort,55,226);
Text(my_window->RPort,"Start at which vertical:",24);
ActivateGadget( &my_gadget, my_window, NULL ); }
if (y<190 && x>192 && y>144) {special=3;
SetAPen(my_window->RPort,7);SetBPen(my_window->RPort,8);
Move(my_window->RPort,56,226);
Text(my_window->RPort,"Car at which horizontal:",24);
ActivateGadget( &my_gadget, my_window, NULL );}
if (y<144 && x>192) {special=4;SetAPen(my_window->RPort,7);SetBPen(my_window->RPort,8);
Move(my_window->RPort,56,226);
Text(my_window->RPort,"Ghost, which horizontal:",24);
ActivateGadget( &my_gadget, my_window, NULL );}
if (y<144 && x<192) {special=5;SetAPen(my_window->RPort,7);SetBPen(my_window->RPort,8);
Move(my_window->RPort,56,226);
Text(my_window->RPort,"Boys - which horizontal:",24);
ActivateGadget( &my_gadget, my_window, NULL );}
if (y>144 && x<192 && y<191) {special=6;
SetAPen(my_window->RPort,7);SetBPen(my_window->RPort,8);
Move(my_window->RPort,56,226);
Text(my_window->RPort,"Can at which horizontal:",24);
ActivateGadget( &my_gadget, my_window, NULL );}
if (y>199 && y<207) special=7;
if (y>207 && y<215) special=8;
                                 }}
else {
if (my_message->Code == SELECTDOWN)
   {
     if (x>39 && x<296 && y<223)
     {SetAPen(my_window->RPort,APen);SetBPen(my_window->RPort,BPen);
     x-=x%8;y-=y%8;Move(my_window->RPort,x,y);
     Text(my_window->RPort,&charfont,1);
     Level[x/8-5][y/8-5]=charfont+APen*4096+BPen*256;}
if (x<40 && y<206 && y>196) {
if (Grid) {RendLevel();Grid=FALSE;} else {grid();Grid=TRUE;}}

if (x<40 && y<216 && y>206) {SetAPen(my_window->RPort,7);
SetBPen(my_window->RPort,8);Move(my_window->RPort,109,226);
Text(my_window->RPort,"Choose character:",17);
ActivateGadget( &gadget1, my_window, NULL ); }

if (x<40 && x>30){if (y<196)charfont=32;if (y<186)charfont=157;
                if (y<176)charfont=155;if (y<166)charfont=153;
                if (y<156)charfont=151;if (y<146)charfont=149;
                if (y<136)charfont=147;if (y<126)charfont=145;
                if (y<116)charfont=143;if (y<106)charfont=141;
                if (y<96) charfont=139;if (y<86) charfont=137;
                if (y<76) charfont=135;if (y<66) charfont=133;
                if (y<56) charfont=131;if (y<46) charfont=129;}
 if (x<30 && x>20){if (y<196)charfont=158;if (y<186)charfont=156;
                if (y<176)charfont=154;if (y<166)charfont=152;
                if (y<156)charfont=150;if (y<146)charfont=148;
                if (y<136)charfont=146;if (y<126)charfont=144;
                if (y<116)charfont=142;if (y<106)charfont=140;
                if (y<96) charfont=138;if (y<86) charfont=136;
                if (y<76) charfont=134;if (y<66) charfont=132;
                if (y<56) charfont=130;if (y<46) charfont=128;}
else if (x<20 && y<196 && y>116) if (special)
{special=FALSE;RendLevel(); if (Grid) grid();}
else {Special();special=TRUE;}

else if (x<20) {if (y<116)APen=15;if (y<106)APen=14;if (y<96) APen=13;
                if (y<86) APen=12;if (y<76) APen=11;if (y<66) APen=10;
                if (y<56) APen=9;if (y<46) APen=8;}

     if (x<10) {if (y<116)APen=7;if (y<106)APen=6;if (y<96) APen=5;
                if (y<86) APen=4;if (y<76) APen=3;if (y<66) APen=2;
                if (y<56) APen=1;if (y<46) APen=0;}

   }

  if (my_message->Code == MENUDOWN) 
   {
     if (x>39 && x<296 && y<223)
      {SetAPen(my_window->RPort,BPen);SetBPen(my_window->RPort,APen);
      x-=x%8;y-=y%8;Move(my_window->RPort,x,y);
      Text(my_window->RPort,&charfont,1);
      Level[x/8-5][y/8-5]=charfont+BPen*4096+APen*256;}

     if (x<20) {if(y<116)BPen=15; if(y<106)BPen=14;if(y<96) BPen=13;
                if (y<86) BPen=12;if(y<76)BPen=11;if(y<66)BPen=10;
                if (y<56) BPen=9; if(y<46) BPen=8;}

     if (x<10) {if (y<116)BPen=7;if (y<106)BPen=6;if (y<96) BPen=5;
                if (y<86) BPen=4;if (y<76) BPen=3;if (y<66) BPen=2;
                if (y<56) BPen=1;if (y<46) BPen=0;}

    }
  }
 }    /* After we have successfully collected the message we can read */
      /* it, and save any important values which we maybe want to check */
      /* later: */

if(my_message->Class == MENUPICK) 
   {

if(my_message->Code == 63488){
SetRGB4( &my_screen->ViewPort, 1,  255,0,0);
if (AutoRequest( my_window, &my_bods_text, &my_positive_text, &my_negative_text, NULL, NULL, 320, 72)){NewLevel();RendLevel();}
SetRGB4( &my_screen->ViewPort, 1,  0,0,204 );}

if (my_message->Code == 63616) close=TRUE;
if(my_message->Code == 63520){
SetRGB4( &my_screen->ViewPort, 1,  204,0,0);
if (AutoRequest( my_window, &my_bods_text, &my_positive_text, &my_negative_text, NULL, NULL, 320, 72)){
/* Opens the Level file */
file_handle = (struct FileHandle *)
Open( "AlexLevel", MODE_READWRITE );
Seek( file_handle, 0, OFFSET_BEGINNING );
bytes_read = Read( file_handle, Level, sizeof( Level ) );
RendLevel();/* Open */
Close( file_handle );}
SetRGB4( &my_screen->ViewPort, 1,  0,0,204 );}

if(my_message->Code == 63552){file_handle = (struct FileHandle *)
Open( "AlexLevel", MODE_READWRITE );
Seek( file_handle, 0, OFFSET_BEGINNING );
bytes_written=Write( file_handle, Level, sizeof( Level ) );
if (file_handle) Close( file_handle );
/* Save */}

if(my_message->Code == 63584) { SetRGB4( &my_screen->ViewPort,1,  255,255,255);
AutoRequest( my_window, &my_body_text, NULL, &my_ok_text, NULL, NULL, 220, 102); /* About */
 SetRGB4( &my_screen->ViewPort, 1,  0,0,204   );}


    }
 ReplyMsg( my_message );}
}

/* We should always close the screens we have opened before we leave: */
 ClearMenuStrip( my_window );

 CloseWindow ( my_window ); 

 CloseScreen( my_screen );
  
/* Close the Graphics Library since we have opened it: */
  CloseLibrary( GfxBase );

  /* Close the Intuition Library since we have opened it: */
  CloseLibrary( IntuitionBase );

  /* THE END */
exit();
}

void NewLevel() {
int i,j;
for (i=0;i<32;i++) for (j=0;j<24;j++)
Level[i][j]=0;}

void grid()
{int i;
SetAPen(my_window->RPort,15);for(i=40;i<296;i+=8)
{Move(my_window->RPort,i,34);Draw(my_window->RPort,i,217);}
for(i=41;i<223;i+=8)
{Move(my_window->RPort,40,i);Draw(my_window->RPort,295,i);}}

void RendLevel() {
int i,j;
char Char;
for (i=0;i<32;i++) for (j=0;j<23;j++) 
if (Level[i][j]) {
SetAPen(my_window->RPort,Level[i][j]>>12);
SetBPen(my_window->RPort,Level[i][j]>>8 & 0x000F);
Char=Level[i][j]&0x00FF; Move(my_window->RPort,i*8+40,j*8+40);
Text(my_window->RPort,&Char,1);}

else {SetAPen(my_window->RPort,0);SetBPen(my_window->RPort,0);
Move (my_window->RPort,i*8+40,j*8+40);Text(my_window->RPort," ",1);}

if (Level[1][23]) {/* A */
SetAPen(my_window->RPort,12);
SetBPen(my_window->RPort,0);
Move (my_window->RPort,40,Level[1][23]*8+48);
Text(my_window->RPort,"ë",1);SetAPen(my_window->RPort,14);
Move(my_window->RPort,40,Level[1][23]*8+40);
Text(my_window->RPort,"ê",1);}

if (Level[2][23]) {/* CAR */
SetAPen(my_window->RPort,13);SetBPen(my_window->RPort,0);
Move (my_window->RPort,Level[2][23]*8+40,200);
Text(my_window->RPort," O O ",4);
Move (my_window->RPort,Level[2][23]*8+40,192);
Text(my_window->RPort,"èèèèè",5);
Move (my_window->RPort,Level[2][23]*8+40,184);
SetAPen(my_window->RPort,5);
Text(my_window->RPort," è",2);SetAPen(my_window->RPort,13);
Text(my_window->RPort,"è",1);SetAPen(my_window->RPort,5);
Text(my_window->RPort,"è",1);SetBPen(my_window->RPort,8);
SetAPen(my_window->RPort,13);Text(my_window->RPort," ",1);
Move (my_window->RPort,Level[2][23]*8+40,176);
Text(my_window->RPort," èèè ",5);}

if (Level[3][23]) {/* GB */
SetAPen(my_window->RPort,7);SetBPen(my_window->RPort,0);
Move (my_window->RPort,Level[3][23]*8+40,184);
Text(my_window->RPort,"ë",1);
Move (my_window->RPort,Level[3][23]*8+40,176);
Text(my_window->RPort,"ê",1);}

if (Level[4][23]) {/* K1 */
SetAPen(my_window->RPort,11);SetBPen(my_window->RPort,0);
Move (my_window->RPort,Level[4][23]*8+40,200);
Text(my_window->RPort,"ë",1);SetAPen(my_window->RPort,13);
Move (my_window->RPort,Level[4][23]*8+40,192);
Text(my_window->RPort,"ê",1);SetAPen(my_window->RPort,10);
Move (my_window->RPort,Level[4][23]*8+56,200);
Text(my_window->RPort,"ë",1);SetAPen(my_window->RPort,7);Move (my_window->RPort,Level[4][23]*8+56,192);
Text(my_window->RPort,"ê",1);}

if (Level[5][23]){/* BI */
SetAPen(my_window->RPort,11);
SetBPen(my_window->RPort,8);
Move (my_window->RPort,Level[5][23]*8+40,192);
Text(my_window->RPort,"ö",1);
Move (my_window->RPort,Level[5][23]*8+40,200);
Text(my_window->RPort,"è",1);}

if (Level[6][23]){/* C */
SetAPen(my_window->RPort,6);SetBPen(my_window->RPort,0);
for (i=15;i<21;i++)
{Move(my_window->RPort,104,i*8+40);Text(my_window->RPort,"Ñ",1);} }

if (Level[7][23]) {SetAPen(my_window->RPort,6); /* Three Boys! */
SetBPen(my_window->RPort,0);Move (my_window->RPort,112,200);
Text(my_window->RPort,"ë",1);Move (my_window->RPort,128,200);
Text(my_window->RPort,"ë",1);Move (my_window->RPort,144,200);
Text(my_window->RPort,"ë",1);SetAPen(my_window->RPort,11);
Move(my_window->RPort,112,192);Text(my_window->RPort,"ê",1);
SetAPen(my_window->RPort,12);Move(my_window->RPort,128,192);
Text(my_window->RPort,"ê",1);SetAPen(my_window->RPort,7);
Move(my_window->RPort,144,192);Text(my_window->RPort,"ê",1);
}


SetAPen(my_window->RPort,8);RectFill(my_window->RPort,54,221,243,226);

 }

void Special() {SetAPen(my_window->RPort,0);
RectFill(my_window->RPort,120,114,239,217);
SetAPen(my_window->RPort,11);SetBPen(my_window->RPort,0);
Move (my_window->RPort,146,128);Text(my_window->RPort,"ë",1);
SetAPen(my_window->RPort,13);Move (my_window->RPort,146,120);
Text(my_window->RPort,"ê",1);SetAPen(my_window->RPort,10);
Move (my_window->RPort,162,128);Text(my_window->RPort,"ë",1);
SetAPen(my_window->RPort,7);Move (my_window->RPort,162,120);
Text(my_window->RPort,"ê",1);Move (my_window->RPort,126,138);
Text(my_window->RPort,"Two Boys",8);Move (my_window->RPort,132,172);
Text(my_window->RPort,"Moving",6);Move (my_window->RPort,142,180);
Text(my_window->RPort,"CAN",3);Move (my_window->RPort,210,128);
Text(my_window->RPort,"ë",1);Move (my_window->RPort,210,120);
Text(my_window->RPort,"ê",1);Move (my_window->RPort,194,138);
Text(my_window->RPort,"Ghost",5);Move (my_window->RPort,202,180);
Text(my_window->RPort,"CAR",3);Move (my_window->RPort,124,194);
Text(my_window->RPort,"Start Position",14);
Move (my_window->RPort,124,202);
Text(my_window->RPort,"Electric Door",13);
Move (my_window->RPort,124,210);
Text(my_window->RPort,"Three Boys!",11);

SetAPen(my_window->RPort,11);
Move (my_window->RPort,150,154);Text(my_window->RPort,"ö",1);
Move (my_window->RPort,150,162);Text(my_window->RPort,"è",1);
SetAPen(my_window->RPort,13);Move (my_window->RPort,194,172);
Text(my_window->RPort," O O ",4);Move (my_window->RPort,194,164);
Text(my_window->RPort,"èèèèè",5);Move (my_window->RPort,194,156);
SetAPen(my_window->RPort,5);Text(my_window->RPort," è",2);
SetAPen(my_window->RPort,13);Text(my_window->RPort,"è",1);
SetAPen(my_window->RPort,5);Text(my_window->RPort,"è",1);
SetBPen(my_window->RPort,8);SetAPen(my_window->RPort,13);
Text(my_window->RPort," ",1);Move (my_window->RPort,194,148);
Text(my_window->RPort," èèè ",5);}
