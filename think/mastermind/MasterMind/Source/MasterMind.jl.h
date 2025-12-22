

/*  RawColumn:  1 'Del', 2 'backspaces', 1 '5'. 'return' is
    the last key "pressed". */
struct RawInfo RawColum[] = {   
 {0x46,0}, {0x41,0}, {0x41,0}, {0x5,0}, {0x44,0}
};


struct RawInfo RawColor[] = {
 {0x46,0}, {0x41,0}, {0x41,0}, {0x01,0}, {0x2,0}, {0x44,0}
};


struct RawInfo RawRow[] = {
 {0x46,0}, {0x41,0}, {0x41,0}, {0x4,0}, {0x44,0}
};


char Blank[] = "                                                ";
struct TextAttr ROMFont = {"topaz.font",TOPAZ_EIGHTY,FS_NORMAL,FPF_ROMFONT};

struct IntuiText TextToShow[6] = {
  {1,0,JAM2,10,15,&ROMFont,Blank,NULL},
  {1,0,JAM2,10,25,&ROMFont,Blank,&TextToShow[0]},
  {1,0,JAM2,10,35,&ROMFont,Blank,&TextToShow[1]},
  {1,0,JAM2,10,45,&ROMFont,Blank,&TextToShow[2]},
  {1,0,JAM2,10,55,&ROMFont,Blank,&TextToShow[3]},
  {1,0,JAM2,10,65,&ROMFont,Blank,&TextToShow[4]} };

struct IntuiText BlankLine =  {1,0,JAM2,10,65,&ROMFont,Blank,NULL}; 

struct NewWindow JLNewWindow = { 20,15,552,120,0,1,NULL,WFLG_SIZEGADGET,NULL,
  NULL,"JustLook's Window!",NULL,NULL,80,40,1280,512,CUSTOMSCREEN };

char *Mess[] = {
"             Welcome To MasterMind!             ", /* 1 */
"                                                ",
"         MasterMind is © Kamran Karimi          ",
"This demo was prepared using JustLook routines. ",
"                                                ",
"LEFT Button to Continue    RIGHT Button to Quit ",

"MasterMind is a simple but interesting game: The", /* 2 */
"Amiga will choose some colors randomly and you  ",
"have to guess not only the colors, but also the ",
"columns on which they are put by the Amiga!     ",
"                                                ",
"LEFT Button to Continue    RIGHT Button to Quit ",

"This implementation of the game is quite        ", /* 3 */
"configurable. You can change important prameters",
"of it easily. The game adapts itself to both PAL",
"and NTSC screen characteristics                 ",
"                                                ",
"LEFT Button to Continue    RIGHT Button to Quit ", 
   
"The board has been configured to our likings.   ", /* 4 */
"We can now start playing. To select a color,    ",
"simply click the mouse on it. Then bring the    ",
"pointer over the square you like and click again",
"                                                ",
"LEFT Button to Continue    RIGHT Button to Quit ",

"after you are done with a row, click on the     ", /* 5 */
" '<- Done'  gadget to see the results. all the  ",
"squares in a row should be filled before this,  ",
"otherwise you'll get an error  message          ",
"                                                ",
"LEFT Button to Continue    RIGHT Button to Quit ", 

"So we should fill the remaining square with a   ", /* 6 */
"color...                                        ",
"                                                ",
"                                                ",
"                                                ",
"LEFT Button to Continue    RIGHT Button to Quit ",

"Now all the squares are filled, but wrongly!.   ", /* 7 */
"You should not use a color more than one time in",
"the same row!                                   ",
"                                                ",
"                                                ",
"LEFT Button to Continue    RIGHT Button to Quit ",

"Now it is better!.                              ", /* 8 */
"Lets see what we have done...                   ",
"                                                ",
"                                                ",
"                                                ",
"LEFT Button to Continue    RIGHT Button to Quit ",

"you can also cheat if you want! click on the    ", /* 9 */
"Cheat gadget and it will show  you a color which",
"is among the ones the Amiga has chosen, but it  ",
"won't tell to which column it belongs.          ",
"                                                ",
"LEFT Button to Continue    RIGHT Button to Quit ", 

"This should be enought to show you how to use   ", /* 10 */
"MasterMind. You can stop the game any time by   ",
"clicking on the Abort gadget and that is exaclty",
"what we are going to do now!. Good-Bye          ",
"                                                ",
"                Press Any Button                ",

"Winning in the FIRST try!!!                     ", /* 11 */
"                                                ",
"                                                ",
"                                                ",
"                                                ",
"LEFT Button to Continue    RIGHT Button to Quit "  
};
