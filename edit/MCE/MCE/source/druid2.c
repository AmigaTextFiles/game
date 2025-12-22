// 1.  INCLUDES -----------------------------------------------------------

#ifdef __amigaos4__
    #ifndef __USE_INLINE__
        #define __USE_INLINE__ // define this as early as possible
    #endif
#endif
#ifdef __LCLINT__
    typedef char* STRPTR;
    typedef char* CONST_STRPTR;
    typedef char  TEXT;
    #define ASM
    #define REG(x)
    #define __inline
#endif

#include <exec/types.h>
#include <exec/memory.h>
#include <dos/dos.h>
#include <intuition/intuition.h>
#include <libraries/iffparse.h>
#include <datatypes/pictureclass.h>
#define ALL_REACTION_CLASSES
#define ALL_REACTION_MACROS
#include <reaction/reaction.h>

#ifdef __MORPHOS__
#define GETCOLOR_GetClass() LP0(30, Class*, GETCOLOR_GetClass, , \
GetColorBase, 0, 0, 0, 0, 0, 0)
//Class* GETCOLOR_GetClass();
#define GetColorObject         NewObject(GETCOLOR_GetClass(), NULL
#define GetColorEnd            TAG_END)
#define GCOLOR_REQUEST         (0x630001)
#define GETCOLOR_Dummy         (REACTION_Dummy + 0x43000)
#define GETCOLOR_Screen        (GETCOLOR_Dummy +  2)
#define GETCOLOR_Color         (GETCOLOR_Dummy +  3)
#define GETCOLOR_ShowRGB       (GETCOLOR_Dummy + 17)
#define GETCOLOR_ShowHSB       (GETCOLOR_Dummy + 18)
#else
#include <gadgets/getcolor.h>
#include <proto/getcolor.h>
#endif

#include <proto/dos.h>
#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/iffparse.h>
#include <proto/intuition.h>
#include <clib/alib_protos.h>

#include <ctype.h>
#include <stdio.h>                           /* FILE, printf() */
#include <stdlib.h>                          /* EXIT_SUCCESS, EXIT_FAILURE */
#include <string.h>
#include <assert.h>

#ifdef LATTICE
    #include <dos.h>                         // geta4()
#endif

#include "mce.h"

// 2. DEFINES ------------------------------------------------------------

// #define SHOWOFFSETS
// whether to show the addresses (offsets) of things on map

#define GID_DRUID2_LY1   0 // root layout
#define GID_DRUID2_SB1   1 // toolbar
#define GID_DRUID2_ST1   2 // 1st  name
#define GID_DRUID2_ST2   3
#define GID_DRUID2_ST3   4
#define GID_DRUID2_ST4   5
#define GID_DRUID2_ST5   6
#define GID_DRUID2_ST6   7
#define GID_DRUID2_ST7   8
#define GID_DRUID2_ST8   9
#define GID_DRUID2_ST9  10
#define GID_DRUID2_ST10 11 // 10th name
#define GID_DRUID2_IN1  12 // 1st  score
#define GID_DRUID2_IN2  13
#define GID_DRUID2_IN3  14
#define GID_DRUID2_IN4  15
#define GID_DRUID2_IN5  16
#define GID_DRUID2_IN6  17
#define GID_DRUID2_IN7  18
#define GID_DRUID2_IN8  19
#define GID_DRUID2_IN9  20
#define GID_DRUID2_IN10 21 // 10th score
#define GID_DRUID2_BU1  22 // clear high scores
#define GID_DRUID2_BU2  23 // clear level
#define GID_DRUID2_SP1  24 // map
#define GID_DRUID2_SP2  25 // tiles
#define GID_DRUID2_SC1  26 // map   horizontal scroller
#define GID_DRUID2_SC2  27 // map   vertical   scroller
#define GID_DRUID2_SC3  28 // tiles horizontal scroller
#define GID_DRUID2_CH1  29 // file type
#define GID_DRUID2_RA1  30 // edit mode
#define GID_DRUID2_LY2  31 // map
#define GID_DRUID2_ST11 32 // bg      code value
#define GID_DRUID2_ST12 33 // fg      code value
#define GID_DRUID2_ST13 34 // monster code value
#define GID_DRUID2_ST14 35 // bg      code addr
#define GID_DRUID2_ST15 36 // fg      code addr
#define GID_DRUID2_ST16 37 // monster code addr
#define GID_DRUID2_GC1  38
#define GID_DRUID2_GC16 53
#define GIDS_DRUID2     GID_DRUID2_GC16

// MAXWIDTH and MAXHEIGHT will need to increase if you increase these
#define MAXWIDENESS   (32 * 32)
#define MAXTALLNESS   (16 * 32)
#define MINWIDENESS   ( 8 * 32)
#define MINTALLNESS   ( 4 * 32)

#define FILETYPE_HISCORES  0
#define FILETYPE_LEVEL     1

#define EDITMODE_BG        0
#define EDITMODE_FG        1
#define EDITMODE_MONSTERS  2

#define NUMBGTILES        30
#define NUMFGTILES       210
#define NUMPOWERUPS       40

#define DARKGREY          17
#define LIGHTGREY         18
#define WHITE             19
#define COLOURS           32

#define AddColour(x) LAYOUT_AddChild, gadgets[GID_DRUID2_GC1 + x] = (struct Gadget*) GetColorObject, \
    GA_ID,            GID_DRUID2_GC1 + x, \
    GA_RelVerify,     TRUE,               \
    GETCOLOR_Screen,  ScreenPtr,          \
    GETCOLOR_ShowRGB, TRUE,               \
    GETCOLOR_ShowHSB, TRUE,               \
GetColorEnd

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void sortscores(void);
MODULE void clearscores(void);
MODULE void updatetiles(void);
MODULE FLAG load_iff(struct IFFHandle* iff, STRPTR filename, int height, int depth, int howmany, UBYTE* tiledata);
MODULE void druid2_drawmappart(int x, int y);
MODULE void stampit(SWORD mousex, SWORD mousey);
MODULE void drawmonster(int x, int y);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode,
                            stringextra;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT LONG                 gamesize,
                            pens[PENS];
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT UBYTE               *byteptr1[DISPLAY1HEIGHT],
                           *byteptr2[DISPLAY2HEIGHT];
IMPORT struct Hook          ToolHookStruct;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Window*       MainWindowPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct DrawInfo*     DrawInfoPtr;
IMPORT struct Image        *aissimage[AISSIMAGES],
                           *image[BITMAPS];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT Object*              WinObject;
IMPORT struct RastPort      wpa8rastport[2];
IMPORT __aligned UBYTE      display1[DISPLAY1SIZE],
                            display2[DISPLAY2SIZE];
IMPORT struct Library*      GetColorBase;

// function pointers
IMPORT FLAG (* tool_open)  (FLAG loadas);
IMPORT void (* tool_save)  (FLAG saveas);
IMPORT void (* tool_close) (void);
IMPORT void (* tool_loop)  (ULONG gid, ULONG code);
IMPORT void (* tool_exit)  (void);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE FLAG                 gotallpens         = FALSE,
                            gotpen[COLOURS],
                            lmb;
MODULE TEXT                 Gfx_Pathname[MAX_PATH + 1]; // we should probably share this with silent.c for efficiency
MODULE UBYTE                convert[256],
                            druid2_stamp       = 0,
                            BGTileData[NUMBGTILES][32][32],
                            FGTileData[NUMFGTILES][32][32],
                            MaskData[NUMFGTILES][32][4];
MODULE ULONG                editmode           = EDITMODE_FG,
                            filetype,
                            gadcolour[16];
MODULE int                  numtiles,
                            scrollx            = 0,
                            scrolly            = 0,
                            tallness           = MINTALLNESS,
                            tilex              = 0,
                            wideness           = MINWIDENESS;
MODULE const STRPTR
EditModeOptions[3 + 1] =
{ "Background",
  "Foreground",
  "Monsters",
  NULL
}, FiletypeOptions[2 + 1] =
{ "High score table",
  "Level",
  NULL
};

#define MONSTERS 12
MODULE const TEXT MonsterData[][24][24 + 1] =
{ { // empty ($00)
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
"                        ",
}, { // head ($01)
"                     f  ",
"   fffe              f  ",
"  ffffae            fa  ",
" fffafff            fa  ",
"fffffffff          faa  ",
"ffeaffff1         faaaaa",
"feeaaaco        ffaaa   ",
" feaaaa o      faaaa    ",
" feeaa         faa      ",
"  feaa         faa      ",
"  feea          feaa    ",
"   feea          feaa   ",
"    feea          feaa  ",
"     feaa          feaa ",
"      feaa        faeaa ",
"       fea  feffefeeaa  ",
"       faaafeaeeaeaaa   ",
"        feaeaaaaaaa     ",
"      fffeaaa           ",
"    feeaeaa             ",
"   feaaafea             ",
"   feeffeaaaaa          ",
"    feeeaaaaaaaa        ",
"      aaaaaaaa          ",
}, { // frankie ($02)
"          aaaa          ",
"         aaaaaa         ",
"         agafae         ",
"         aggfee    ge   ",
"   ge    agagae   geee  ",
"  geee   aggfee    he e ",
" g eh    gfggfe    hh   ",
"   hh  j agffea   ihh   ",
"   hhihjiiafeeahjhhh    ",
"   hihiiiiahhaaihhih    ",
"   hhhhihihhhhhhihh h   ",
"   h hhhhhhiahhhh h     ",
"      h hiiihahh h h    ",
"     h  hhihahhh        ",
"        hhahhhhh        ",
"       hhhhahhhaa       ",
"       hhhaahhahh       ",
"        hhh hhhha       ",
"       efee  hhhhaaaaa  ",
"        fef ahhhaaaaaaa ",
"         aaaaefeaaaaaaa ",
"          aaaaefeaaaaa  ",
"             aaaaaaa    ",
"                        ",
}, { // orc ($03)
"  d                d    ",
"  cdd    ooon    ddc    ",
"   ccdddonnnnkdddcc     ",
"    bccononnnnkccb      ",
"     bbonnnnnnkbb       ",
"       aknnnnka         ",
"       ooakkaoo         ",
"   ooooalkllklakoon     ",
" oonnnnaallllaaknnnkk   ",
" mmnnnnnocaackknnkklk   ",
" mmmlkkonnokknnkkllllk  ",
" mmlklknnnoknnnk  mmlk  ",
" mmkl  nnonkknk    mlk  ",
" mml   kknnnnkk    mmlk ",
" mml   mmkkkklk     mll ",
" mll   mmllklllk   dcc  ",
"  dcc mmllkkkllk  d  cb ",
" dc  cmmlk llmllk     b ",
" d    dll    mmlk    c  ",
"  c   dcc     mlk       ",
"     dccc  aaadmbaaaa   ",
"      aaaaaaaadcbaaaaaa ",
"              dcbaaaaa  ",
"               aaa      ",
}, { // slime ($04)
"                gg      ",
"         ggg ggggffff   ",
"       ggggggg  fffffe  ",
"    gggggggffee   fffe  ",
"   ggggfgffffe    ffe   ",
"  gggggggfffeee fffee   ",
" gggfffgffffeffffffe    ",
" ggggfffffgffggfffee    ",
" gggfgfgfgffgfffffe     ",
"  ggggggggfffgffffe     ",
"    ffgfffgfffeeffeee   ",
"    gfeefefffffeeeefeee ",
"   ggffffffgfffffffffeee",
"  ggffgggggfgfeffeffeeee",
" ggggffffffffffeeefeeee ",
"  ggffffggffffffeefee   ",
"  gfffggffeeeeeefeee    ",
"   fffffffeffeefee      ",
"      ffffffefeee  f    ",
"      fffeefeeeeeggfe   ",
"       feefeeee ggfee   ",
"        eeeeeee  fee    ",
"           eee    e     ",
"                        ",
}, { // phoenix ($05)
"            p           ",
"          opp           ",
"          pp ppo        ",
"    p   p   p pop       ",
"    p   p  np oop       ",
"    ppo   oppno p p     ",
"  o p o ppppnno  p      ",
"     p  pnppnnop p      ",
"        ppppnnop po     ",
" o po  pnpnonnnp     o p",
" o o   pnpnnoppo   poo p",
" p o  ppnopnoppop npo p ",
" po p ppnopnnpnoppnnppo ",
" po o npponnpononpnnopo ",
"  pp nnnonnnponpoppnnpo ",
"  pnpnknpnpnnnpnpnknpp  ",
"  npppnkkppnnnppkknnpoo ",
"   ppppdkkppnppkkdnppo  ",
"   onpdddkkpnpkkdddpp   ",
"    onndabkkpkkbadnpo   ",
"     knnbadnkndabnnk    ",
"      kkknnononnkk      ",
"         kkkkkkk        ",
"                        ",
}, { // treeoid ($06)
"             m          ",
"    mm   ml m   mm      ",
"   mllm   mlm  mlll     ",
"  ml  lm   ml ml lm     ",
"  ml       m  l  ll     ",
"  ll       ml    ml     ",
"  llmm    mlk   mlm     ",
" ml l     mlk     ll    ",
" ll    m  lllkm   lm    ",
" ml     mmllmm    ll    ",
" ll      lmmlk    lm    ",
" mm      allal    ll    ",
"  llm    lkkll   mlk    ",
"  kllmm mmlklk  mlk     ",
"   klllmmlklllkmlk      ",
"    kklmllkkllklk       ",
"      kmlkaaklkk        ",
"       mkaaaalk         ",
"    mmmlaakkakllm       ",
"   mkkklklllkkkkkllll   ",
"  mkaalkkkkkkklaakaaaa  ",
"llka lkaaalaaaklaaaaaaaa",
"     la lla  aaalllaaaa ",
"                        ",
}, { // skeleton ($07)
"                    dbc ",
"          ddddc     bcbd",
" cbd     ddcdcdc    bdb ",
"dbcb     dddcddc    b   ",
" bdb     dcdddbc    c   ",
"   b     dcadacc   c    ",
"    c     ddadc    c    ",
"    d      ddd    db    ",
"    bdcccc cbc cdb      ",
"         ddcbcdd        ",
"          ddcdc         ",
"        dd  b  dd       ",
"         bddcdcb        ",
"        dd bb  d        ",
"         cdccdc         ",
"        c bccbc         ",
"       d      d         ",
"      b       b         ",
"       cd     d         ",
"     dddd     c         ",
"      aaaaaaadccaaaaaaa ",
"            aadddaaaaaaa",
"               aaaa aaa ",
"                        ",
}, { // fungus ($08)
"          oooo          ",
"      oooonnnnnnnn      ",
"    ooononnonnnnnnnn    ",
"  ooonnnnonnnnnnnnnnnn  ",
" ooonononnnnnnnnnnnnnnn ",
" oonnnnnnnnnnnnnnnnknnk ",
"oononnnooonnnnooonknknkk",
"ooonnnaaaaknnkaaaannkknk",
"onononkkffakkaffkknkknkk",
"oonnnnnnkkknnkkknnnnkkkk",
"  onnnnnnnnnnnknnnnkkk  ",
"    nnnnnnnnnknnkkkk    ",
"        kkkkkkkk        ",
"        kkkkkkkk        ",
"        lkkkkkkk        ",
"       mmmlllkkkk       ",
"      mmmmmmllkkkk      ",
"      mmmmmmmlkkkka     ",
"      mmmmmmmlkkkkaaaa  ",
"        mmmlllkkaaaaaaa ",
"         amlkkaaaaaaaaaa",
"        aaaaaaaaaaaaaaa ",
"             aaaaaaaaa  ",
"                        ",
}, { // eyeball ($09)
"                        ",
"           a            ",
"      a  a a  a  a      ",
"    a  a akkkka a       ",
"  a  akkkkkkkkkkkk a  a ",
"a  akkkkooooooookkka a  ",
" aknkkoomddddmmdookkkk a",
"  nkkomddddjjjdmddokkka ",
" kkkomdddjjjjjjddddokkk ",
"knkoddddjjjjjddddmodokkk",
"nkodod jjjjaadddddmdookk",
"nkoododjjjaaddjjjmdodokk",
"kkomddddjjaaaajjjddmdokk",
"nnkomoddjjjaajjjddodoknk",
"kkkkomdddjjjjjjddmmokkkk",
" nnkkomddddjjddddmonnkk ",
"  nkkkoommddddmmookkkaaa",
"    kkkkooooooookkkkaaaa",
"      kkkkkkkkkkkkaaaaa ",
"       akkkkkkkkaaaaaa  ",
"        aaaaaaaaaaaaa   ",
"           aaaaaaa      ",
"                        ",
"                        ",
}, { // spider ($0A)
"                        ",
"           c            ",
"          lkk    k      ",
"    l    cccbb   ka     ",
"    la  llkkkkk  ka     ",
" l  la  ccccbbba  k     ",
"  l  l  llkkkkka  ka k  ",
"  la la  cccbbaa kkak a ",
"   l lk   lkkaakl aaka  ",
"    llakkk caak aa k a  ",
"     akkakkkak alkk a   ",
"       akkkakakk aaa    ",
"      kk kkkakaalkk     ",
"    ll kkmakamk  aak    ",
"   l lk aamlm akl   k   ",
"  l alaalkmlmkk akk ka  ",
"  la la ljimjika  ka k  ",
" l al a  ihkihaa  ka  a ",
"  a la   blklaa  k a    ",
"    la  bclalcb  ka     ",
"     a  cbaa bca ka     ",
"        bca  cba  a     ",
"         aa   aa        ",
"                        ",
}, { // robot ($0B)
"          mmkk          ",
"        mmmllkkk        ",
"      mmlmllllklkk      ",
"     mmlmllllllklkk     ",
"  mmmmmaaaonkaaaakkkkk  ",
"mmmmmmmlmllllllklkkkkkkk",
"jihmmmmmlmllllklkkkkkjih",
"jiihhhhmmlmllklkkjiihhhh",
"dcccbbbbmmllllkkdcccbbbb",
" dcccbbbbmmmkkkdcccbbbb ",
" jiiihhhhhmllkjiiihhhhh ",
"  jiiihhhhmmkkjiiihhhh  ",
"  dcccbbbbmllkdcccbbbb  ",
"   dccbbbbmmkkdccbbbb   ",
"   jiihhhhmllkjiihhhh   ",
"    jiihhhmmkkjiihhh    ",
"     dccbbmllkdccbb     ",
"      dcbbmmkkdcbb      ",
"        jmmllkkj        ",
"        mmlmklkk        ",
"      mmmlmllklkkkaaaa  ",
"       mlmllllklkaaaaaaa",
"        lllllllaaaaaaa  ",
"           aaaaaaa      ",
}, { // $13
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"ddddddaddddaddaaaadddddd",
"dddddaaaaddaddddddaddddd",
"ddddadaddddaddddddaddddd",
"dddddaaadddaddaaaadddddd",
"ddddddadaddaddddddaddddd",
"ddddaaaadddaddddddaddddd",
"ddddddaddddaddaaaadddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
}, { // $14
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"ddddddaddddadddddadddddd",
"dddddaaaaddaddddaadddddd",
"ddddadaddddadddadadddddd",
"dddddaaadddadddadadddddd",
"ddddddadaddaddaaaaaddddd",
"ddddaaaadddadddddadddddd",
"ddddddaddddadddddadddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
}, { // $15
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"ddddddaddddaddaaaaaddddd",
"dddddaaaaddaddaddddddddd",
"ddddadaddddaddaddddddddd",
"dddddaaadddaddaaaadddddd",
"ddddddadaddaddddddaddddd",
"ddddaaaadddaddddddaddddd",
"ddddddaddddaddaaaadddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
}, { // $16
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"ddddddaddddadddaaaaddddd",
"dddddaaaaddaddaddddddddd",
"ddddadaddddaddaddddddddd",
"dddddaaadddaddaaaadddddd",
"ddddddadaddaddadddaddddd",
"ddddaaaadddaddadddaddddd",
"ddddddaddddadddaaadddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
}, { // $58
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"ddddaddddaaaaadddaaadddd",
"dddaaaaddaddddddadddaddd",
"ddadaddddaddddddadddaddd",
"dddaaadddaaaaddddaaadddd",
"ddddadaddddddaddadddaddd",
"ddaaaadddddddaddadddaddd",
"ddddaddddaaaaddddaaadddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
}, { // all others
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"ddddddddddaaaddddddddddd",
"dddddddddadddadddddddddd",
"dddddddddddddadddddddddd",
"dddddddddddaaddddddddddd",
"dddddddddddadddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddadddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
"dddddddddddddddddddddddd",
} };

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct
{   ULONG amount;
    TEXT  name[5 + 1];
} score[10];

MODULE struct
{   ULONG red, blue, green;
} idealcolour[COLOURS] = {
// tile colours
{ 0x00000000, 0x00000000, 0x00000000 }, //  0
{ 0x99999999, 0x99999999, 0x99999999 },
{ 0xCCCCCCCC, 0xCCCCCCCC, 0xCCCCCCCC },
{ 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF },
{ 0x11111111, 0x77777777, 0x00000000 },
{ 0x44444444, 0xBBBBBBBB, 0x22222222 }, //  5
{ 0x88888888, 0xFFFFFFFF, 0x55555555 },
{ 0x22222222, 0x22222222, 0xAAAAAAAA },
{ 0x55555555, 0x44444444, 0xCCCCCCCC },
{ 0x88888888, 0x66666666, 0xFFFFFFFF },
{ 0xAAAAAAAA, 0x11111111, 0x00000000 }, // 10
{ 0xCCCCCCCC, 0x66666666, 0x00000000 },
{ 0xFFFFFFFF, 0xCCCCCCCC, 0x00000000 },
{ 0xFFFFFFFF, 0x00000000, 0x00000000 },
{ 0xFFFFFFFF, 0x66666666, 0x22222222 },
{ 0xFFFFFFFF, 0xAAAAAAAA, 0x00000000 }, // 15
// monster colours
{ 0x00000000, 0x00000000, 0x00000000 }, // 16 a
{ 0x44444444, 0x44444444, 0x33333333 }, // 17 b (DARKGREY)
{ 0x88888888, 0x88888888, 0x77777777 }, // 18 c (LIGHTGREY)
{ 0xCCCCCCCC, 0xCCCCCCCC, 0xBBBBBBBB }, // 19 d (WHITE)
{ 0x11111111, 0x44444444, 0x00000000 }, // 20 e
{ 0x22222222, 0x88888888, 0x00000000 }, // 21 f
{ 0x22222222, 0xDDDDDDDD, 0x00000000 }, // 22 g
{ 0x11111111, 0x00000000, 0x44444444 }, // 23 h
{ 0x33333333, 0x00000000, 0x99999999 }, // 24 i
{ 0x77777777, 0x00000000, 0xFFFFFFFF }, // 25 j
{ 0x55555555, 0x22222222, 0x00000000 }, // 26 k
{ 0x77777777, 0x44444444, 0x00000000 }, // 27 l
{ 0xAAAAAAAA, 0x66666666, 0x00000000 }, // 28 m
{ 0xAAAAAAAA, 0x00000000, 0x00000000 }, // 29 m
{ 0xFFFFFFFF, 0x00000000, 0x00000000 }, // 20 o
{ 0xFFFFFFFF, 0x66666666, 0x00000000 }, // 31 p
};

// 8. CODE ---------------------------------------------------------------

EXPORT void druid2_main(void)
{   TRANSIENT int     i;
    TRANSIENT Object* PaletteGroup = NULL;
    PERSIST   FLAG    first        = TRUE;

    if (first)
    {   first = FALSE;

        // druid2_preinit()
        for (i = 0; i < COLOURS; i++)
        {   gotpen[i] = FALSE;
    }   }

    tool_open  = druid2_open;
    tool_loop  = druid2_loop;
    tool_save  = druid2_save;
    tool_close = druid2_close;
    tool_exit  = druid2_exit;

    if (loaded != FUNC_DRUID2 && !druid2_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_DRUID2;

    make_speedbar_list(GID_DRUID2_SB1);
    load_aiss_images(9, 9);

    if (GetColorBase)
    {   PaletteGroup =
        HLayoutObject,
            LAYOUT_Label,                                      "Background & Foreground Colours",
            LAYOUT_SpaceOuter,                                 TRUE,
            LAYOUT_BevelStyle,                                 BVS_SBAR_VERT,
            AddColour(0),
            AddColour(1),
            AddColour(2),
            AddColour(3),
            AddColour(4),
            AddColour(5),
            AddColour(6),
            AddColour(7),
            AddColour(8),
            AddColour(9),
            AddColour(10),
            AddColour(11),
            AddColour(12),
            AddColour(13),
            AddColour(14),
            AddColour(15),
        LayoutEnd;
    }

    InitHook(&ToolHookStruct, (ULONG (*)())ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                         TRUE,
        WA_ThinSizeGadget,                                     TRUE,
        WINDOW_Position,                                       WPOS_CENTERMOUSE,
        WINDOW_ParentGroup,                                    gadgets[GID_DRUID2_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                                 TRUE,
            LAYOUT_SpaceInner,                                 TRUE,
            AddHLayout,
                AddToolbar(GID_DRUID2_SB1),
                AddSpace,
                CHILD_WeightedWidth,                           50,
                AddVLayout,
                    LAYOUT_VertAlignment,                      LALIGN_CENTER,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                                 GID_DRUID2_CH1,
                        GA_Disabled,                           TRUE,
                        CHOOSER_LabelArray,                    &FiletypeOptions,
                    ChooserEnd,
                    Label("File type:"),
                LayoutEnd,
                CHILD_WeightedWidth,                           0,
                AddSpace,
                CHILD_WeightedWidth,                           50,
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
            AddHLayout,
                LAYOUT_BevelStyle,                             BVS_SBAR_VERT,
                LAYOUT_SpaceOuter,                             TRUE,
                LAYOUT_Label,                                  "High Score Table",
                AddVLayout,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST1] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST1,
                        GA_TabCycle,                           TRUE,
                        STRINGA_TextVal,                       score[0].name,
                        STRINGA_MaxChars,                      5 + 1,
                        STRINGA_MinVisible,                    5 + stringextra,
                    StringEnd,
                    Label("#1:"),
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST2] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST2,
                        GA_TabCycle,                           TRUE,
                        STRINGA_TextVal,                       score[1].name,
                        STRINGA_MaxChars,                      5 + 1,
                        STRINGA_MinVisible,                    5 + stringextra,
                    StringEnd,
                    Label("#2:"),
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST3] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST3,
                        GA_TabCycle,                           TRUE,
                        STRINGA_TextVal,                       score[2].name,
                        STRINGA_MaxChars,                      5 + 1,
                        STRINGA_MinVisible,                    5 + stringextra,
                    StringEnd,
                    Label("#3:"),
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST4] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST4,
                        GA_TabCycle,                           TRUE,
                        STRINGA_TextVal,                       score[3].name,
                        STRINGA_MaxChars,                      5 + 1,
                        STRINGA_MinVisible,                    5 + stringextra,
                    StringEnd,
                    Label("#4:"),
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST5] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST5,
                        GA_TabCycle,                           TRUE,
                        STRINGA_TextVal,                       score[4].name,
                        STRINGA_MaxChars,                      5 + 1,
                        STRINGA_MinVisible,                    5 + stringextra,
                    StringEnd,
                    Label("#5:"),
                LayoutEnd,
                AddVLayout,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_IN1] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                 GID_DRUID2_IN1,
                        GA_TabCycle,                           TRUE,
                        INTEGER_Minimum,                       0,
                        INTEGER_Maximum,                       65535,
                        INTEGER_MinVisible,                    5 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_IN2] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                 GID_DRUID2_IN2,
                        GA_TabCycle,                           TRUE,
                        INTEGER_Minimum,                       0,
                        INTEGER_Maximum,                       65535,
                        INTEGER_MinVisible,                    5 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_IN3] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                 GID_DRUID2_IN3,
                        GA_TabCycle,                           TRUE,
                        INTEGER_Minimum,                       0,
                        INTEGER_Maximum,                       65535,
                        INTEGER_MinVisible,                    5 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_IN4] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                 GID_DRUID2_IN4,
                        GA_TabCycle,                           TRUE,
                        INTEGER_Minimum,                       0,
                        INTEGER_Maximum,                       65535,
                        INTEGER_MinVisible,                    5 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_IN5] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                 GID_DRUID2_IN5,
                        GA_TabCycle,                           TRUE,
                        INTEGER_Minimum,                       0,
                        INTEGER_Maximum,                       65535,
                        INTEGER_MinVisible,                    5 + 1,
                    IntegerEnd,
                LayoutEnd,
                AddLabel(" "),
                CHILD_WeightedWidth,                           0,
                AddVLayout,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST6] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST6,
                        GA_TabCycle,                           TRUE,
                        STRINGA_TextVal,                       score[5].name,
                        STRINGA_MaxChars,                      5 + 1,
                        STRINGA_MinVisible,                    5 + stringextra,
                    StringEnd,
                    Label("#6:"),
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST7] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST7,
                        GA_TabCycle,                           TRUE,
                        STRINGA_TextVal,                       score[6].name,
                        STRINGA_MaxChars,                      5 + 1,
                        STRINGA_MinVisible,                    5 + stringextra,
                    StringEnd,
                    Label("#7:"),
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST8] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST8,
                        GA_TabCycle,                           TRUE,
                        STRINGA_TextVal,                       score[7].name,
                        STRINGA_MaxChars,                      5 + 1,
                        STRINGA_MinVisible,                    5 + stringextra,
                    StringEnd,
                    Label("#8:"),
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST9] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST9,
                        GA_TabCycle,                           TRUE,
                        STRINGA_TextVal,                       score[8].name,
                        STRINGA_MaxChars,                      5 + 1,
                        STRINGA_MinVisible,                    5 + stringextra,
                    StringEnd,
                    Label("#9:"),
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST10] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST10,
                        GA_TabCycle,                           TRUE,
                        STRINGA_TextVal,                       score[9].name,
                        STRINGA_MaxChars,                      5 + 1,
                        STRINGA_MinVisible,                    5 + stringextra,
                    StringEnd,
                    Label("#10:"),
                LayoutEnd,
                AddVLayout,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_IN6] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                 GID_DRUID2_IN6,
                        GA_TabCycle,                           TRUE,
                        INTEGER_Minimum,                       0,
                        INTEGER_Maximum,                       65535,
                        INTEGER_MinVisible,                    5 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_IN7] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                 GID_DRUID2_IN7,
                        GA_TabCycle,                           TRUE,
                        INTEGER_Minimum,                       0,
                        INTEGER_Maximum,                       65535,
                        INTEGER_MinVisible,                    5 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_IN8] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                 GID_DRUID2_IN8,
                        GA_TabCycle,                           TRUE,
                        INTEGER_Minimum,                       0,
                        INTEGER_Maximum,                       65535,
                        INTEGER_MinVisible,                    5 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_IN9] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                 GID_DRUID2_IN9,
                        GA_TabCycle,                           TRUE,
                        INTEGER_Minimum,                       0,
                        INTEGER_Maximum,                       65535,
                        INTEGER_MinVisible,                    5 + 1,
                    IntegerEnd,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_IN10] = (struct Gadget*)
                    IntegerObject,
                        GA_ID,                                 GID_DRUID2_IN10,
                        GA_TabCycle,                           TRUE,
                        INTEGER_Minimum,                       0,
                        INTEGER_Maximum,                       65535,
                        INTEGER_MinVisible,                    5 + 1,
                    IntegerEnd,
                LayoutEnd,
                AddLabel(" "),
                CHILD_WeightedWidth,                           0,
                LAYOUT_AddChild,                               gadgets[GID_DRUID2_BU1] = (struct Gadget*)
                ZButtonObject,
                    GA_ID,                                     GID_DRUID2_BU1,
                    GA_RelVerify,                              TRUE,
                    GA_Image,
                    LabelObject,
                        LABEL_Image,                           aissimage[9],
                        CHILD_NoDispose,                       TRUE,
                        LABEL_DrawInfo,                        DrawInfoPtr,
                        LABEL_VerticalAlignment,               LVALIGN_BASELINE,
                        LABEL_Justification,                   LJ_CENTRE,
                        LABEL_Text,                            "\nClear\nHigh\nScores",
                    LabelEnd,
                ButtonEnd,
                CHILD_WeightedWidth,                           0,
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
            AddLabel(""),
            CHILD_WeightedHeight,                              0,
            AddHLayout,
                LAYOUT_Label,                                  "Map Editor",
                LAYOUT_SpaceOuter,                             TRUE,
                LAYOUT_BevelStyle,                             BVS_SBAR_VERT,
                AddVLayout,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_LY2] = (struct Gadget*)
                    VLayoutObject,
                        LAYOUT_BevelStyle,                     BVS_NONE,
                        LAYOUT_AddChild,                       gadgets[GID_DRUID2_SP1] = (struct Gadget*)
                        SpaceObject,
                            GA_ID,                             GID_DRUID2_SP1,
                            GA_Width,                          wideness,
                            GA_Height,                         tallness,
                            SPACE_BevelStyle,                  BVS_NONE,
                            SPACE_Transparent,                 TRUE,
                        SpaceEnd,
                        CHILD_MinWidth,                        MINWIDENESS,
                        CHILD_MinHeight,                       MINTALLNESS,
                        CHILD_MaxWidth,                        MAXWIDENESS,
                        CHILD_MaxHeight,                       MAXTALLNESS,
                    LayoutEnd,
                    CHILD_WeightedWidth,                       100,
                    CHILD_WeightedHeight,                      100,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_SC1] = (struct Gadget*)
                    ScrollerObject,
                        GA_ID,                                 GID_DRUID2_SC1,
                        GA_RelVerify,                          TRUE,
                        SCROLLER_Orientation,                  SORIENT_HORIZ,
                        SCROLLER_Arrows,                       TRUE,
                    ScrollerEnd,
                    CHILD_WeightedWidth,                       100,
                    CHILD_WeightedHeight,                      0,
                LayoutEnd,
                LAYOUT_AddChild,                               gadgets[GID_DRUID2_SC2] = (struct Gadget*)
                ScrollerObject,
                    GA_ID,                                     GID_DRUID2_SC2,
                    GA_RelVerify,                              TRUE,
                    SCROLLER_Orientation,                      SORIENT_VERT,
                    SCROLLER_Arrows,                           TRUE,
                ScrollerEnd,
                CHILD_WeightedWidth,                           0,
                CHILD_WeightedHeight,                          100,
            LayoutEnd,
            AddVLayout,
                LAYOUT_Label,                                  "Tiles",
                LAYOUT_SpaceOuter,                             TRUE,
                LAYOUT_BevelStyle,                             BVS_GROUP,
                AddHLayout,
                    LAYOUT_ShrinkWrap,                         TRUE,
                    LAYOUT_AddChild,
                    VLayoutObject,
                        AddVLayout,
                            LAYOUT_BevelStyle,                 BVS_NONE,
                            LAYOUT_AddChild,                   gadgets[GID_DRUID2_SP2] = (struct Gadget*)
                            SpaceObject,
                                GA_ID,                         GID_DRUID2_SP2,
                                GA_Width,                      wideness,
                                SPACE_BevelStyle,              BVS_NONE,
                                SPACE_Transparent,             TRUE,
                            SpaceEnd,
                            CHILD_MinWidth,                    MINWIDENESS,
                            CHILD_MinHeight,                   32,
                            CHILD_MaxWidth,                    MAXWIDENESS,
                            CHILD_MaxHeight,                   32,
                        LayoutEnd,
                        CHILD_WeightedHeight,                  100,
                        LAYOUT_AddChild,                       gadgets[GID_DRUID2_SC3] = (struct Gadget*)
                        ScrollerObject,
                            GA_ID,                             GID_DRUID2_SC3,
                            GA_RelVerify,                      TRUE,
                            SCROLLER_Orientation,              SORIENT_HORIZ,
                            SCROLLER_Arrows,                   TRUE,
                        ScrollerEnd,
                        CHILD_WeightedHeight,                  0,
                    LayoutEnd,
                    CHILD_WeightedWidth,                       100,
                    AddHLayout,
                        AddSpace,
                    LayoutEnd,
                    CHILD_WeightedWidth,                       0,
                    CHILD_MinWidth,                            13, // this is only an approximation unfortunately
                LayoutEnd,
            LayoutEnd,
            CHILD_WeightedWidth,                               100,
            CHILD_WeightedHeight,                              0,
            AddHLayout,
                AddVLayout,
                    AddSpace,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_RA1] = (struct Gadget*)
                    RadioButtonObject,
                        GA_ID,                                 GID_DRUID2_RA1,
                        GA_RelVerify,                          TRUE,
                        GA_Text,                               EditModeOptions,
                    RadioButtonEnd,
                    Label("_Editing mode:"),
                    CHILD_WeightedHeight,                      0,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedWidth,                           0,
                AddSpace,
                AddVLayout,
                    LAYOUT_VertAlignment,                      LALIGN_CENTER,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST11] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST11,
                        GA_ReadOnly,                           TRUE,
                        STRINGA_TextVal,                       "-",
                        STRINGA_MinVisible,                    5 + 1,
                    StringEnd,
                    Label("Background:"),
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST12] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST12,
                        GA_ReadOnly,                           TRUE,
                        STRINGA_TextVal,                       "-",
                        STRINGA_MinVisible,                    5 + 1,
                    StringEnd,
                    Label("Foreground:"),
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST13] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST13,
                        GA_ReadOnly,                           TRUE,
                        STRINGA_TextVal,                       "-",
                        STRINGA_MinVisible,                    5 + 1,
                    StringEnd,
                    Label("Monster:"),
                LayoutEnd,
                CHILD_WeightedWidth,                           0,
#ifdef SHOWOFFSETS
                AddVLayout,
                    LAYOUT_VertAlignment,                      LALIGN_CENTER,
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST14] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST14,
                        GA_ReadOnly,                           TRUE,
                        STRINGA_TextVal,                       "-",
                        STRINGA_MinVisible,                    5 + 1,
                    StringEnd,
                    Label("at"),
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST15] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST15,
                        GA_ReadOnly,                           TRUE,
                        STRINGA_TextVal,                       "-",
                        STRINGA_MinVisible,                    5 + 1,
                    StringEnd,
                    Label("at"),
                    LAYOUT_AddChild,                           gadgets[GID_DRUID2_ST16] = (struct Gadget*)
                    StringObject,
                        GA_ID,                                 GID_DRUID2_ST16,
                        GA_ReadOnly,                           TRUE,
                        STRINGA_TextVal,                       "-",
                        STRINGA_MinVisible,                    5 + 1,
                    StringEnd,
                    Label("at"),
                LayoutEnd,
                CHILD_WeightedWidth,                           0,
#endif
                AddSpace,
                AddVLayout,
                    AddSpace,
                    ClearButton(GID_DRUID2_BU2, "Clear Level"),
                    CHILD_WeightedHeight,                      0,
                    AddSpace,
                LayoutEnd,
                CHILD_WeightedWidth,                           0,
            LayoutEnd,
            CHILD_WeightedHeight,                              0,
            PaletteGroup ? LAYOUT_AddChild      : TAG_IGNORE,  PaletteGroup,
            PaletteGroup ? CHILD_WeightedHeight : TAG_IGNORE,  0,
        LayoutEnd,
        CHILD_NominalSize,                                     TRUE,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_DRUID2_SB1);

    druid2_getpens();

    setup_bm(0, MAXWIDENESS, MAXTALLNESS, MainWindowPtr);
    setup_bm(1, MAXWIDENESS,          32, MainWindowPtr);

    druid2_resize();
    writegadgets();
    if (filetype == FILETYPE_HISCORES)
    {   DISCARD ActivateLayoutGadget(gadgets[GID_DRUID2_LY1], MainWindowPtr, NULL, (Object) gadgets[GID_DRUID2_ST1]);
    }
    lmb = FALSE;
    loop();
    readgadgets();
    closewindow();
}

EXPORT void druid2_loop(ULONG gid, UNUSED ULONG code)
{   int oldeditmode,
        tileoffset,
        whichtile,
        x, y;

    switch (gid)
    {
    case GID_DRUID2_BU1:
        clearscores();
        writegadgets();
    acase GID_DRUID2_BU2:
        for (x = 0; x < 32; x++)
        {   for (y = 0; y < 16; y++)
            {   // background
                tileoffset =   1030 + (y * 64) + (x * 2);
                IOBuffer[tileoffset    ] = 0;
                IOBuffer[tileoffset + 1] = 9 * 4; // grass

                // foreground
                tileoffset =      6 + (y * 64) + (x * 2);
                whichtile = ((IOBuffer[tileoffset    ] / 5) * 10)
                          +  (IOBuffer[tileoffset + 1] / 4)      ;
                if
                (   (whichtile >= 56 && whichtile <= 59) // exits
                 || (whichtile >= 80 && whichtile <= 82) // spells
                )
                {   ;
                } else
                {   IOBuffer[tileoffset    ] =
                    IOBuffer[tileoffset + 1] = 0; // empty
            }   }

            // monsters
            for (y = 0; y < 8; y++)
            {   tileoffset = 0x1006 + (y * 64) + (x * 2);
                whichtile = (IOBuffer[tileoffset    ] * 256) // this is an assumption
                          +  IOBuffer[tileoffset + 1]       ;
                if
                (   (whichtile >= 0x13 && whichtile <= 0x16)
                 ||  whichtile == 0x58
                )
                {   ;
                } else
                {   IOBuffer[tileoffset    ] =
                    IOBuffer[tileoffset + 1] = 0; // empty
        }   }   }
        druid2_drawmap(FALSE);
    acase GID_DRUID2_SC1:
        DISCARD GetAttr(SCROLLER_Top, (Object*) gadgets[GID_DRUID2_SC1], (ULONG*) &scrollx);
        druid2_drawmap(FALSE);
    acase GID_DRUID2_SC2:
        DISCARD GetAttr(SCROLLER_Top, (Object*) gadgets[GID_DRUID2_SC2], (ULONG*) &scrolly);
        druid2_drawmap(FALSE);
    acase GID_DRUID2_SC3:
        DISCARD GetAttr(SCROLLER_Top, (Object*) gadgets[GID_DRUID2_SC3], (ULONG*) &tilex);
        updatetiles();
    acase GID_DRUID2_RA1:
        oldeditmode = editmode;
        DISCARD GetAttr(RADIOBUTTON_Selected, (Object*) gadgets[GID_DRUID2_RA1], &editmode);
        druid2_resize();
        if (oldeditmode == EDITMODE_MONSTERS || editmode == EDITMODE_MONSTERS) // because fg->bg or bg->fg doesn't need a redraw
        {   druid2_drawmap(TRUE);
        } else
        {   updatetiles();
        }
    adefault:
        if (gid >= GID_DRUID2_GC1 && gid <= GID_DRUID2_GC16)
        {   // assert(GetColorBase);
            if (DoMethod((Object*) gadgets[gid], GCOLOR_REQUEST, MainWindowPtr))
            {   GetAttr(GETCOLOR_Color, (Object*) gadgets[gid], &gadcolour[gid - GID_DRUID2_GC1]);
                idealcolour[gid - GID_DRUID2_GC1].red   = ((gadcolour[gid - GID_DRUID2_GC1] & 0x00F00000) >> 20) * 0x11111111;
                idealcolour[gid - GID_DRUID2_GC1].green = ((gadcolour[gid - GID_DRUID2_GC1] & 0x0000F000) >> 12) * 0x11111111;
                idealcolour[gid - GID_DRUID2_GC1].blue  = ((gadcolour[gid - GID_DRUID2_GC1] & 0x000000F0) >>  4) * 0x11111111;
                druid2_getpens();
                druid2_drawmap(TRUE);
}   }   }   }

EXPORT FLAG druid2_open(FLAG loadas)
{   struct IFFHandle* iff;

    if (gameopen(loadas))
    {   if (gamesize == 4646)
        {   filetype = FILETYPE_LEVEL;
        } elif (gamesize == 80)
        {   filetype = FILETYPE_HISCORES;
        } else
        {   DisplayBeep(NULL);
            return FALSE;
    }   }
    else
    {   return FALSE;
    }

    serializemode = SERIALIZE_READ;
    serialize();

    if (filetype == FILETYPE_HISCORES)
    {   writegadgets();
        return TRUE;
    }

    // assert(filetype == FILETYPE_LEVEL);

    if (!(iff = AllocIFF()))
    {   rq("AllocIFF() failed!");
    }

    memset(&BGTileData[0][0][0], 0, NUMBGTILES * 32 * 32);
    memset(&FGTileData[0][0][0], 0, NUMFGTILES * 32 * 32);
    memset(&MaskData[  0][0][0], 0, NUMFGTILES * 32 *  4);

    if
    (   load_iff(iff, "bgblocks", 128, 4, NUMBGTILES, &BGTileData[0][0][0])
     && load_iff(iff, "fgblocks", 672, 4, NUMFGTILES, &FGTileData[0][0][0])
     && load_iff(iff, "template", 672, 1, NUMFGTILES,   &MaskData[0][0][0])
    )
    {   ;
    }

    FreeIFF(iff);
    druid2_getpens();
    writegadgets();
    return TRUE;
}

MODULE void writegadgets(void)
{   int i;

    if
    (   page != FUNC_DRUID2
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
    druid2_drawmap(TRUE);

    if (GetColorBase)
    {   for (i = 0; i < 16; i++)
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_DRUID2_GC1 + i], MainWindowPtr, NULL,
                GETCOLOR_Color, gadcolour[i],
            TAG_DONE);
            RefreshGadgets((struct Gadget*) gadgets[GID_DRUID2_GC1 + i], MainWindowPtr, NULL); // this might autorefresh
    }   }

    either_ch(GID_DRUID2_CH1, &filetype);
    either_ra(GID_DRUID2_RA1, &editmode);
    for (i = 0; i < 10; i++)
    {   ghost_st(GID_DRUID2_ST1 + i, (filetype != FILETYPE_HISCORES));
        ghost_st(GID_DRUID2_IN1 + i, (filetype != FILETYPE_HISCORES));
    }
    ghost(       GID_DRUID2_BU1    , (filetype != FILETYPE_HISCORES));

    ghost(       GID_DRUID2_SP1    , (filetype != FILETYPE_LEVEL   ));
    ghost(       GID_DRUID2_SP2    , (filetype != FILETYPE_LEVEL   ));
    ghost(       GID_DRUID2_SC1    , (filetype != FILETYPE_LEVEL   ));
    ghost(       GID_DRUID2_SC2    , (filetype != FILETYPE_LEVEL   ));
    ghost(       GID_DRUID2_SC3    , (filetype != FILETYPE_LEVEL   ));
    ghost(       GID_DRUID2_BU2    , (filetype != FILETYPE_LEVEL   ));
    ghost_st(    GID_DRUID2_RA1    , (filetype != FILETYPE_LEVEL   ));
}

MODULE void eithergadgets(void)
{   int i;

    for (i = 0; i < 10; i++)
    {   either_st(GID_DRUID2_ST1 + i,  score[i].name);
        either_in(GID_DRUID2_IN1 + i, &score[i].amount);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int  i, j;
    FLAG clearing;

    offset = 0;

    if (filetype == FILETYPE_HISCORES)
    {   if (serializemode == SERIALIZE_WRITE)
        {   sortscores();

            // add spaces
            for (i = 0; i < 10; i++)
            {   clearing = FALSE;
                for (j = 0; j <= 4; j++)
                {   if (!clearing && score[i].name[j] == EOS)
                    {   clearing = TRUE;
                    }
                    if (clearing)
                    {   score[i].name[j] = ' ';
                }   }
                score[i].name[5] = EOS;
        }   }

        for (i = 0; i < 10; i++)
        {   if (serializemode == SERIALIZE_READ)
            {   zstrncpy(score[i].name, (char*) &IOBuffer[offset], 5); // $0..$5
            } else
            {   // assert(serializemode == SERIALIZE_WRITE);
                zstrncpy((char*) &IOBuffer[offset], score[i].name, 5); // $0..$5
            }
            offset += 6;                                               // $0..$5
            serialize2ulong((ULONG*) &score[i].amount);                // $6..$7
        }

        // remove spaces
        for (i = 0; i < 10; i++)
        {   for (j = 4; j >= 0; j--)
            {   if (score[i].name[j] == ' ')
                {   score[i].name[j] = EOS;
                } else
                {   break;
    }   }   }   }
    else
    {   // assert(filetype == FILETYPE_LEVEL);

        offset = 0x1206;
        if (serializemode == SERIALIZE_READ)
        {   for (i = 0; i < 16; i++)
            {   idealcolour[i].red   = ( IOBuffer[offset    ] & 0x0F      ) * 0x11111111;
                idealcolour[i].green = ((IOBuffer[offset + 1] & 0xF0) >> 4) * 0x11111111;
                idealcolour[i].blue  = ( IOBuffer[offset + 1] & 0x0F      ) * 0x11111111;
                offset += 2;
        }   }
        else
        {   // assert(serializemode == SERIALIZE_WRITE);

            for (i = 0; i < 16; i++)
            {   IOBuffer[offset    ] =  (idealcolour[i].red   & 0xF0000000) >> 28 ;
                IOBuffer[offset + 1] = ((idealcolour[i].green & 0xF0000000) >> 24)
                                     | ((idealcolour[i].blue  & 0xF0000000) >> 28);
                offset += 2;
}   }   }   }

EXPORT void druid2_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    if (filetype == FILETYPE_HISCORES)
    {   gamesave("#?hi_scores#?", "Druid 2", saveas,   80, FLAG_H, FALSE);
    } else
    {   gamesave("level#?"      , "Druid 2", saveas, 4646, FLAG_L, FALSE);
}   }

EXPORT void druid2_close(void) { ; }
EXPORT void druid2_exit(void)  { ; }

MODULE void sortscores(void)
{   int   i, j;
    TEXT  tempstr[5 + 1];
    ULONG tempnum;

    // This bubble sorts them from highest to lowest.

    for (i = 0; i < 10 - 1; i++)
    {   for (j = 0; j < 10 - i - 1; j++)
        {   if
            (   score[j    ].amount
              < score[j + 1].amount
            )
            {   tempnum             = score[j    ].amount;
                score[j    ].amount = score[j + 1].amount;
                score[j + 1].amount = tempnum;

                strcpy(tempstr,           score[j    ].name);
                strcpy(score[j    ].name, score[j + 1].name);
                strcpy(score[j + 1].name, tempstr);
    }   }   }

    writegadgets();
}

MODULE void clearscores(void)
{   int i;

    for (i = 0; i < 10; i++)
    {   score[i].name[0] = EOS;
        score[i].amount  = 0;
}   }

EXPORT void druid2_getpens(void)
{   int i;

    druid2_freepens();

    lockscreen();

    gotallpens = TRUE;
    for (i = 0; i < COLOURS; i++)
    {   pens[i] = (LONG) ObtainPen
        (   ScreenPtr->ViewPort.ColorMap,
            (ULONG) -1,
            idealcolour[i].red,
            idealcolour[i].green,
            idealcolour[i].blue,
            PEN_EXCLUSIVE
        );
        if (pens[i] >= 0 && pens[i] <= 255)
        {   gotpen[i] = TRUE;
            convert[pens[i]] = i;
        } else
        {   gotallpens = FALSE;
            pens[i] = FindColor
            (   ScreenPtr->ViewPort.ColorMap,
                idealcolour[i].red,
                idealcolour[i].green,
                idealcolour[i].blue,
                -1
            );
        }
        if (i < 16)
        {   gadcolour[i] = ((idealcolour[i].red   & 0xFF000000) >>  8)
                         | ((idealcolour[i].green & 0xFF000000) >> 16)
                         | ((idealcolour[i].blue  & 0xFF000000) >> 24);
    }   }

    unlockscreen();
    if (!gotallpens)
    {   druid2_freepens();
}   }
EXPORT void druid2_freepens(void)
{   int i;

    lockscreen();
    for (i = 0; i < COLOURS; i++)
    {   if (gotpen[i])
        {   ReleasePen(ScreenPtr->ViewPort.ColorMap, (ULONG) pens[i]);
            gotpen[i] = FALSE;
    }   }
    unlockscreen();
    gotallpens = FALSE;
}

EXPORT void druid2_uniconify(void)
{   druid2_getpens();
    druid2_resize();
    druid2_drawmap(TRUE);
}

EXPORT void druid2_resize(void)
{   int y;

    switch (editmode)
    {
    case  EDITMODE_BG:       numtiles = NUMBGTILES;
    acase EDITMODE_FG:       numtiles = NUMFGTILES;
    acase EDITMODE_MONSTERS: numtiles = MONSTERS;
    }

    wideness = gadgets[GID_DRUID2_LY2]->Width;
    tallness = gadgets[GID_DRUID2_LY2]->Height;
    if (wideness >        32 * 32            ) wideness =        32 * 32;
    if (tallness >        16 * 32            ) tallness =        16 * 32;

    if (scrollx  > (      32 * 32) - wideness) scrollx  = (      32 * 32) - wideness;
    if (scrolly  > (      16 * 32) - tallness) scrolly  = (      16 * 32) - tallness;
    if (tilex    > (numtiles * 32) - wideness) tilex    = (numtiles * 32) - wideness;
    if (tilex    <                          0) tilex    =                          0;
    if (druid2_stamp >= numtiles             ) druid2_stamp = numtiles    -        1;

    DISCARD SetGadgetAttrs
    (   gadgets[GID_DRUID2_SC1], MainWindowPtr, NULL,
        SCROLLER_Visible, wideness,
        SCROLLER_Top,     scrollx,
        SCROLLER_Total,   32 * 32,
    TAG_END); // this refreshes automatically
    DISCARD SetGadgetAttrs
    (   gadgets[GID_DRUID2_SC2], MainWindowPtr, NULL,
        SCROLLER_Visible, tallness,
        SCROLLER_Top,     scrolly,
        SCROLLER_Total,   16 * 32,
    TAG_END); // this refreshes automatically
    DISCARD SetGadgetAttrs
    (   gadgets[GID_DRUID2_SC3], MainWindowPtr, NULL,
        SCROLLER_Visible, wideness,
        SCROLLER_Top,     tilex,
        SCROLLER_Total,   numtiles * 32,
    TAG_END);

    for (y = 0; y < tallness; y++)
    {   byteptr1[y] = &display1[GFXINIT(wideness, y)];
    }
    for (y = 0; y <       32; y++)
    {   byteptr2[y] = &display2[GFXINIT(wideness, y)];
}   }

EXPORT void druid2_drawmap(FLAG all)
{   int  tileoffset,
         whichtile,
         x, xx,
         y, yy;
    FLAG ok;
    TEXT whichdata;

    for (y = 0; y < tallness; y++)
    {   for (x = 0; x < wideness; x++)
        {   xx = (scrollx + x) % 32;
            ok = FALSE;
            if (editmode == EDITMODE_MONSTERS && xx >= 4 && xx < 28)
            {   yy = (scrolly + y) % 64;
                if (yy >= 20 && yy < 44)
                {   tileoffset = (((scrolly + y) / 64) * 64) + (((scrollx + x) / 32) * 2);
                    whichtile = (IOBuffer[tileoffset + 0x1006] * 256) // this is an assumption
                              +  IOBuffer[tileoffset + 0x1007];
                    if   (whichtile >= 0x13 && whichtile <= 0x16) whichtile = whichtile - 0x13 + 12; // 19..22 -> 12..15
                    elif (whichtile == 0x58                     ) whichtile =                    16; // 88     -> 16
                    elif (whichtile >=   12                     ) whichtile =                    17; //        -> 17

                    whichdata = MonsterData[whichtile][yy - 20][xx - 4];
                    if (whichdata != ' ')
                    {   whichdata -= 'a';
                        *(byteptr1[y] + x) = (UBYTE) pens[(int) whichdata];
                        ok = TRUE;
            }   }   }
            if (!ok)
            {   yy = (scrolly + y) % 32;
                tileoffset = (((scrolly + y) / 32) * 64) + (((scrollx + x) / 32) * 2);
                // foreground
                whichtile = ((IOBuffer[tileoffset +    6] / 5) * 10)
                          +  (IOBuffer[tileoffset +    7] / 4)      ;

                if (MaskData[whichtile][yy][xx / 8] & (0x80 >> (xx % 8)))
                {   *(byteptr1[y] + x) = pens[(whichtile >= NUMFGTILES) ? 0 : FGTileData[whichtile][yy][xx]];
                } else
                {   // background
                    whichtile = ((IOBuffer[tileoffset + 1030] / 5) * 10)
                              +  (IOBuffer[tileoffset + 1031] / 4)      ;
                    *(byteptr1[y] + x) = pens[(whichtile >= NUMBGTILES) ? 0 : BGTileData[whichtile][yy][xx]];
    }   }   }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_DRUID2_SP1]->LeftEdge,
        gadgets[GID_DRUID2_SP1]->TopEdge,
        gadgets[GID_DRUID2_SP1]->LeftEdge + wideness - 1,
        gadgets[GID_DRUID2_SP1]->TopEdge  + tallness - 1,
        display1,
        &wpa8rastport[0]
    );

    DISCARD SetGadgetAttrs
    (   gadgets[GID_DRUID2_SC1], MainWindowPtr, NULL,
        SCROLLER_Top, scrollx,
    TAG_END); // this refreshes automatically
    DISCARD SetGadgetAttrs
    (   gadgets[GID_DRUID2_SC2], MainWindowPtr, NULL,
        SCROLLER_Top, scrolly,
    TAG_END); // this refreshes automatically

    if (all)
    {   updatetiles();
}   }

MODULE void druid2_drawmappart(int x, int y)
{   int  leftx,
         minx, miny,
         maxx, maxy,
         tileoffset,
         topy,
         whichbg,
         whichfg,
         xx,
         yy;

    leftx      = (x * 32) - scrollx; // left edge of tile in gadget coords
    topy       = (y * 32) - scrolly; // top  edge of tile in gadget coords
    tileoffset = (y * 64) + (x * 2);
    whichfg    = ((IOBuffer[tileoffset +    6] / 5) * 10)
               +  (IOBuffer[tileoffset +    7] / 4)      ;
    whichbg    = ((IOBuffer[tileoffset + 1030] / 5) * 10)
               +  (IOBuffer[tileoffset + 1031] / 4)      ;

    if (leftx      <        0) minx = -leftx               ; else minx =  0;
    if (topy       <        0) miny = -topy                ; else miny =  0;
    if (leftx + 32 > wideness) maxx = -leftx + wideness - 1; else maxx = 31;
    if (topy  + 32 > tallness) maxy = -topy  + tallness - 1; else maxy = 31;

    if (maxx < 0 || maxy < 0 || minx >= 32 || miny >= 32)
    {   return;
    }

    for (yy = miny; yy <= maxy; yy++)
    {   for (xx = minx; xx <= maxx; xx++)
        {   if (MaskData[whichfg][yy][xx / 8] & (0x80 >> (xx % 8)))
            {   *(byteptr1[topy + yy] + leftx + xx) = pens[(whichfg >= NUMFGTILES) ? 0 : FGTileData[whichfg][yy][xx]];
            } else
            {   // background
                *(byteptr1[topy + yy] + leftx + xx) = pens[(whichbg >= NUMBGTILES) ? 0 : BGTileData[whichbg][yy][xx]];
    }   }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_DRUID2_SP1]->LeftEdge,
        gadgets[GID_DRUID2_SP1]->TopEdge  + topy + miny,
        gadgets[GID_DRUID2_SP1]->LeftEdge + wideness - 1,
        gadgets[GID_DRUID2_SP1]->TopEdge  + topy + maxy,
        &display1[GFXINIT(wideness, (topy + miny))],
        &wpa8rastport[0]
    );
}

MODULE void updatetiles(void)
{   int   whichpen,
          x, y,
          xx;
    UBYTE whichtile;
    TEXT  whichdata;

    switch (editmode)
    {
    case EDITMODE_BG:
        for (y = 0; y < 32; y++)
        {   for (x = 0; x < wideness; x++)
            {   whichtile = (tilex + x) / 32;
                xx        = (tilex + x) % 32;
                if (whichtile >= NUMBGTILES)
                {   *(byteptr2[y] + x) = pens[DARKGREY];
                } elif (druid2_stamp == whichtile && (xx < 4 || xx >= 32 - 4 || y < 4 || y >= 32 - 4))
                {   *(byteptr2[y] + x) = pens[WHITE];
                } else
                {   *(byteptr2[y] + x) = pens[BGTileData[whichtile][y][xx]];
        }   }   }
    acase EDITMODE_FG:
        for (y = 0; y < 32; y++)
        {   for (x = 0; x < wideness; x++)
            {   whichtile = (tilex + x) / 32;
                xx        = (tilex + x) % 32;
                if (whichtile >= NUMFGTILES)
                {   *(byteptr2[y] + x) = pens[DARKGREY];
                } elif (druid2_stamp == whichtile && (xx < 4 || xx >= 32 - 4 || y < 4 || y >= 32 - 4))
                {   *(byteptr2[y] + x) = pens[WHITE];
                } elif (MaskData[whichtile][y][xx / 8] & (0x80 >> (xx % 8)))
                {   *(byteptr2[y] + x) = pens[FGTileData[whichtile][y][xx]];
                } else
                {   *(byteptr2[y] + x) = pens[LIGHTGREY];
        }   }   }
    acase EDITMODE_MONSTERS:
        for (x = 0; x < wideness; x++)
        {   whichtile = (tilex + x) / 32;
            if (druid2_stamp == whichtile)
            {   whichpen = WHITE;
            } elif (whichtile >= MONSTERS)
            {   whichpen = DARKGREY;
            } else
            {   whichpen = LIGHTGREY;
            }
            *(byteptr2[ 0] + x) =
            *(byteptr2[ 1] + x) =
            *(byteptr2[ 2] + x) =
            *(byteptr2[ 3] + x) =
            *(byteptr2[28] + x) =
            *(byteptr2[29] + x) =
            *(byteptr2[30] + x) =
            *(byteptr2[31] + x) = pens[whichpen];
        }

        for (x = 0; x < wideness; x++)
        {   whichtile = (tilex + x) / 32;
            for (y = 0; y < 24; y++)
            {   if (whichtile >= MONSTERS)
                {   *(byteptr2[y + 4] + x) = pens[DARKGREY];
                } else
                {   xx        = (tilex + x) % 32;
                    if (xx >= 4 && xx < 28)
                    {   whichdata = MonsterData[whichtile][y][xx - 4];
                        if (whichdata == ' ')
                        {   *(byteptr2[y + 4] + x) = (UBYTE) pens[LIGHTGREY];
                        } else
                        {   whichdata -= 'a';
                            *(byteptr2[y + 4] + x) = (UBYTE) pens[(int) whichdata];
                    }   }
                    else
                    {   *(byteptr2[y + 4] + x) = (UBYTE) pens[(druid2_stamp == whichtile) ? WHITE : LIGHTGREY];
    }   }   }   }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_DRUID2_SP2]->LeftEdge,
        gadgets[GID_DRUID2_SP2]->TopEdge,
        gadgets[GID_DRUID2_SP2]->LeftEdge + wideness - 1,
        gadgets[GID_DRUID2_SP2]->TopEdge  +       32 - 1,
        display2,
        &wpa8rastport[1]
    );

    DISCARD SetGadgetAttrs
    (   gadgets[GID_DRUID2_SC3], MainWindowPtr, NULL,
        SCROLLER_Top,   tilex,
    TAG_END); // this refreshes automatically
}

EXPORT void druid2_lmb(SWORD mousex, SWORD mousey, UWORD code)
{   int x;

    if (filetype != FILETYPE_LEVEL)
    {   return;
    }

    if (code == SELECTUP)
    {   lmb = FALSE;
    } elif (code == SELECTDOWN) // this doesn't repeat
    {   lmb = TRUE;

        if (mouseisover(GID_DRUID2_SP1, mousex, mousey))
        {   stampit(mousex, mousey);
        } elif (mouseisover(GID_DRUID2_SP2, mousex, mousey))
        {   x = (mousex - gadgets[GID_DRUID2_SP2]->LeftEdge + tilex  ) / 32;

            if
            (   (   editmode == EDITMODE_FG
                 && (    x >= NUMFGTILES
                     || (x >= 56 && x <= 59) // exits
                     || (x >= 80 && x <= 82) // spells
                )   )
             || (   editmode == EDITMODE_BG       && x >= NUMBGTILES)
             || (   editmode == EDITMODE_MONSTERS && x >= MONSTERS  )
            )
            {   ;
            } else
            {   druid2_stamp = x;
                updatetiles();
}   }   }   }

MODULE void stampit(SWORD mousex, SWORD mousey)
{   int tileoffset = 0,
        whichtile  = 0, // these are initialized to avoid spurious SAS/C warnings
        x, y;

    x = (mousex - gadgets[GID_DRUID2_SP1]->LeftEdge + scrollx) / 32;
    y = (mousey - gadgets[GID_DRUID2_SP1]->TopEdge  + scrolly) / 32;
    switch (editmode)
    {
    case  EDITMODE_BG:
        tileoffset =   1030 + ( y      * 64) + (x * 2);
        whichtile  = ((IOBuffer[tileoffset    ] / 5) *  10)
                   +  (IOBuffer[tileoffset + 1] / 4);
    acase EDITMODE_FG:
        tileoffset =      6 + ( y      * 64) + (x * 2);
        whichtile  = ((IOBuffer[tileoffset    ] / 5) *  10)
                   +  (IOBuffer[tileoffset + 1] / 4);
    acase EDITMODE_MONSTERS:
        tileoffset = 0x1006 + ((y / 2) * 64) + (x * 2);
        whichtile  =  (IOBuffer[tileoffset    ]      * 256) // this is an assumption
                   +   IOBuffer[tileoffset + 1]     ;
    }

    if
    (   whichtile == druid2_stamp
     || (   editmode == EDITMODE_FG
         && (   (whichtile >=   56 && whichtile <=   59) // exits
             || (whichtile >=   80 && whichtile <=   82) // spells
        )   )
     || (   editmode == EDITMODE_MONSTERS
         && (   (whichtile >= 0x13 && whichtile <= 0x16)
             ||  whichtile == 0x58
    )   )   )
    {   ;
    } else
    {   if (editmode == EDITMODE_MONSTERS)
        {   IOBuffer[tileoffset    ] = 0;
            IOBuffer[tileoffset + 1] = druid2_stamp;
            druid2_drawmappart(x, y);
            if (y % 2)
            {   druid2_drawmappart(x, y - 1);
            } else
            {   druid2_drawmappart(x, y + 1);
            }
            drawmonster(x, y);
        } else
        {   IOBuffer[tileoffset    ] = ((druid2_stamp / 10) * 5);
            IOBuffer[tileoffset + 1] = ((druid2_stamp % 10) * 4);
            druid2_drawmappart(x, y);
}   }   }

MODULE void drawmonster(int x, int y)
{   int  leftx,
         minx, miny,
         maxx, maxy,
         tileoffset,
         topy,
         whichtile,
         xx,
         yy;
    TEXT whichdata;

    y /= 2;
    leftx      = ( x      * 32) - scrollx +  4; // left edge of tile in gadget coords
    topy       = ( y      * 64) - scrolly + 20; // top  edge of tile in gadget coords
    tileoffset = ( y      * 64) + (x * 2);
    whichtile  = (IOBuffer[tileoffset + 0x1006] * 256) // this is an assumption
               +  IOBuffer[tileoffset + 0x1007];
    if   (whichtile >= 0x13 && whichtile <= 0x16) whichtile = whichtile - 0x13 + 12; // 19..22 -> 12..15
    elif (whichtile == 0x58                     ) whichtile =                    16; // 88     -> 16
    elif (whichtile >=   12                     ) whichtile =                    17; //        -> 17

    if (leftx      <            0) minx =      -leftx                     ; else minx =  0;
    if (topy       <            0) miny =      -topy                      ; else miny =  0;
    if (leftx + 24 > wideness    ) maxx =      -leftx      + wideness + 1 ; else maxx = 23;
    if (topy  + 24 > tallness    ) maxy =      -topy       + tallness + 1 ; else maxy = 23;

    for (yy = miny; yy <= maxy; yy++)
    {   for (xx = minx; xx <= maxx; xx++)
        {   whichdata = MonsterData[whichtile][yy][xx];
            if (whichdata != ' ')
            {   whichdata -= 'a';
                *(byteptr1[topy + yy] + leftx + xx) = (UBYTE) pens[(int) whichdata];
    }   }   }

    DISCARD WritePixelArray8
    (   MainWindowPtr->RPort,
        gadgets[GID_DRUID2_SP1]->LeftEdge,
        gadgets[GID_DRUID2_SP1]->TopEdge  + topy + miny,
        gadgets[GID_DRUID2_SP1]->LeftEdge + wideness - 1,
        gadgets[GID_DRUID2_SP1]->TopEdge  + topy + maxy,
        &display1[GFXINIT(wideness, (topy + miny))],
        &wpa8rastport[0]
    );
}

EXPORT void druid2_tick(SWORD mousex, SWORD mousey)
{   TEXT tempstring[5 + 1];
    int  okfg      = 0,
         okbg      = 0,
         okmonster = 0,
         tileoffset,
         whichtile,
         x, y;

    if (mouseisover(GID_DRUID2_SP1, mousex, mousey))
    {   setpointer(TRUE, WinObject, MainWindowPtr, FALSE);

        if (filetype == FILETYPE_LEVEL)
        {   x = (mousex - gadgets[GID_DRUID2_SP1]->LeftEdge + scrollx) / 32;
            y = (mousey - gadgets[GID_DRUID2_SP1]->TopEdge  + scrolly) / 32;

            tileoffset =   1030 + (y * 64) + (x * 2);
            sprintf(tempstring, "$%02X%02X", IOBuffer[tileoffset], IOBuffer[tileoffset + 1]);
            DISCARD SetGadgetAttrs
            (   gadgets[GID_DRUID2_ST11], MainWindowPtr, NULL,
                STRINGA_TextVal, tempstring,
            TAG_END); // this refreshes automatically
#ifdef SHOWOFFSETS
            sprintf(tempstring, "$%04X", tileoffset);
            DISCARD SetGadgetAttrs
            (   gadgets[GID_DRUID2_ST14], MainWindowPtr, NULL,
                STRINGA_TextVal, tempstring,
            TAG_END); // this refreshes automatically
#endif

            tileoffset =      6 + (y * 64) + (x * 2);
            sprintf(tempstring, "$%02X%02X", IOBuffer[tileoffset], IOBuffer[tileoffset + 1]);
            DISCARD SetGadgetAttrs
            (   gadgets[GID_DRUID2_ST12], MainWindowPtr, NULL,
                STRINGA_TextVal, tempstring,
            TAG_END); // this refreshes automatically
#ifdef SHOWOFFSETS
            sprintf(tempstring, "$%04X", tileoffset);
            DISCARD SetGadgetAttrs
            (   gadgets[GID_DRUID2_ST15], MainWindowPtr, NULL,
                STRINGA_TextVal, tempstring,
            TAG_END); // this refreshes automatically
#endif

            tileoffset = 0x1006 + ((y / 2) * 64) + (x * 2);
            sprintf(tempstring, "$%02X%02X", IOBuffer[tileoffset], IOBuffer[tileoffset + 1]);
            DISCARD SetGadgetAttrs
            (   gadgets[GID_DRUID2_ST13], MainWindowPtr, NULL,
                STRINGA_TextVal, tempstring,
            TAG_END); // this refreshes automatically
#ifdef SHOWOFFSETS
            sprintf(tempstring, "$%04X", tileoffset);
            DISCARD SetGadgetAttrs
            (   gadgets[GID_DRUID2_ST16], MainWindowPtr, NULL,
                STRINGA_TextVal, tempstring,
            TAG_END); // this refreshes automatically
#endif

            okbg = okfg = okmonster = 2;
    }   }
    elif (mouseisover(GID_DRUID2_SP2, mousex, mousey))
    {   setpointer(TRUE, WinObject, MainWindowPtr, FALSE);

        if (filetype == FILETYPE_LEVEL)
        {   x = (mousex - gadgets[GID_DRUID2_SP2]->LeftEdge + tilex) / 32;
            if (x < numtiles)
            {   switch (editmode)
                {
                case EDITMODE_BG:
                    whichtile = (((x / 10) * 5) * 256)
                              +  ((x % 10) * 4);
                    sprintf(tempstring, "$%04X", whichtile);
                    DISCARD SetGadgetAttrs
                    (   gadgets[GID_DRUID2_ST11], MainWindowPtr, NULL,
                    STRINGA_TextVal, tempstring,
                    TAG_END); // this refreshes automatically
                    okbg = 1;
                acase EDITMODE_FG:
                    whichtile = (((x / 10) * 5) * 256)
                              +  ((x % 10) * 4);
                    sprintf(tempstring, "$%04X", whichtile);
                    DISCARD SetGadgetAttrs
                    (   gadgets[GID_DRUID2_ST12], MainWindowPtr, NULL,
                        STRINGA_TextVal, tempstring,
                    TAG_END); // this refreshes automatically
                    okfg = 1;
                acase EDITMODE_MONSTERS:
                    sprintf(tempstring, "$%04X", x);
                    DISCARD SetGadgetAttrs
                    (   gadgets[GID_DRUID2_ST13], MainWindowPtr, NULL,
                        STRINGA_TextVal, tempstring,
                    TAG_END); // this refreshes automatically
                    okmonster = 1;
    }   }   }   }
    else
    {   setpointer(FALSE, WinObject, MainWindowPtr, FALSE);
    }

    if (okbg < 2)
    {   if (okbg < 1)
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_DRUID2_ST11], MainWindowPtr, NULL,
                STRINGA_TextVal, "-",
            TAG_END); // this refreshes automatically
        }
#ifdef SHOWOFFSETS
        DISCARD SetGadgetAttrs
        (   gadgets[GID_DRUID2_ST14], MainWindowPtr, NULL,
            STRINGA_TextVal, "-",
        TAG_END); // this refreshes automatically
#endif
    }
    if (okfg < 2)
    {   if (okfg < 1)
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_DRUID2_ST12], MainWindowPtr, NULL,
                STRINGA_TextVal, "-",
            TAG_END); // this refreshes automatically
        }
#ifdef SHOWOFFSETS
        DISCARD SetGadgetAttrs
        (   gadgets[GID_DRUID2_ST15], MainWindowPtr, NULL,
            STRINGA_TextVal, "-",
        TAG_END); // this refreshes automatically
#endif
    }
    if (okmonster < 2)
    {   if (okmonster < 1)
        {   DISCARD SetGadgetAttrs
            (   gadgets[GID_DRUID2_ST13], MainWindowPtr, NULL,
                STRINGA_TextVal, "-",
            TAG_END); // this refreshes automatically
        }
#ifdef SHOWOFFSETS
        DISCARD SetGadgetAttrs
        (   gadgets[GID_DRUID2_ST16], MainWindowPtr, NULL,
            STRINGA_TextVal, "-",
        TAG_END); // this refreshes automatically
#endif
    }
}

EXPORT void druid2_mouse(SWORD mousex, SWORD mousey)
{   if (filetype != FILETYPE_LEVEL)
    {   return;
    }

    if (lmb && mouseisover(GID_DRUID2_SP1, mousex, mousey))
    {   stampit(mousex, mousey);
}   }

EXPORT void druid2_key(UBYTE scancode, UWORD qual, SWORD mousex, SWORD mousey)
{   int oldx, oldy,
        oldtilex;

    if (filetype != FILETYPE_LEVEL)
    {   return;
    }

    oldx     = scrollx;
    oldy     = scrolly;
    oldtilex = tilex;

    if
    (   scancode == SCAN_UP
     || scancode == SCAN_N7
     || scancode == SCAN_N8
     || scancode == SCAN_N9
     || scancode == NM_WHEEL_UP
    )
    {   MOVE_UP(       qual, &scrolly, 1 * 32, 160);
    } elif
    (   scancode == SCAN_DOWN
     || scancode == SCAN_N5
     || scancode == SCAN_N1
     || scancode == SCAN_N2
     || scancode == SCAN_N3
     || scancode == NM_WHEEL_DOWN
    )
    {   MOVE_DOWN(     qual, &scrolly, 1 * 32, 160, (      16 * 32) - tallness);
    }

    if
    (   mouseisover(GID_DRUID2_SP2, mousex, mousey)
     || mouseisover(GID_DRUID2_SC3, mousex, mousey)
    )
    {   if
        (   scancode == SCAN_LEFT
         || scancode == SCAN_N7
         || scancode == SCAN_N4
         || scancode == SCAN_N1
        )
        {   MOVE_LEFT( qual, &tilex  , 1 * 32, 160);
        } elif
        (   scancode == SCAN_RIGHT
         || scancode == SCAN_N9
         || scancode == SCAN_N6
         || scancode == SCAN_N3
        )
        {   MOVE_RIGHT(qual, &tilex  , 1 * 32, 160, (numtiles * 32) - wideness);
    }   }
    else
    {   if
        (   scancode == SCAN_LEFT
         || scancode == SCAN_N7
         || scancode == SCAN_N4
         || scancode == SCAN_N1
        )
        {   MOVE_LEFT( qual, &scrollx, 1 * 32, 160);
        } elif
        (   scancode == SCAN_RIGHT
         || scancode == SCAN_N9
         || scancode == SCAN_N6
         || scancode == SCAN_N3
        )
        {   MOVE_RIGHT(qual, &scrollx, 1 * 32, 160, (        32 * 32) - wideness);
    }   }

    if (scrollx != oldx || scrolly != oldy)
    {   druid2_drawmap(FALSE);
    }
    if (tilex != oldtilex)
    {   updatetiles();
}   }

MODULE FLAG load_iff(struct IFFHandle* iff, STRPTR filename, int height, int depth, int howmany, UBYTE* tiledata)
{   TRANSIENT FLAG                   ok;
    TRANSIENT SBYTE                  t;
    TRANSIENT UBYTE                 *CompressedBuffer,
                                    *UncompressedBuffer;
    TRANSIENT LONG                   actual,
                                     error;
    TRANSIENT int                    i, j,
                                     x, y,
                                     uncompressedsize;
    TRANSIENT struct BitMapHeader*   bmhd;
    TRANSIENT struct ContextNode*    top;
    TRANSIENT struct StoredProperty* sp;
    PERSIST   TEXT                   tempstring1[MAX_PATH + 1], // PERSISTent so as not to blow the stack
                                     tempstring2[MAX_PATH + 1];

    // first look in /game2/
    strcpy(tempstring2, "game2/");
    strcat(tempstring2, filename);
    zstrncpy(tempstring1,   pathname,   (size_t) (PathPart((STRPTR) pathname   ) - (STRPTR) pathname   ));
    zstrncpy(Gfx_Pathname, tempstring1, (size_t) (PathPart((STRPTR) tempstring1) - (STRPTR) tempstring1));
    if
    (   !AddPart(Gfx_Pathname, tempstring2, MAX_PATH)
     || !(iff->iff_Stream = Open(Gfx_Pathname, MODE_OLDFILE))
    )
    {   // try current directory
        strcpy(Gfx_Pathname, tempstring1);
        if (!AddPart(Gfx_Pathname, filename, MAX_PATH))
        {   printf("Can't assemble pathname %s!\n", Gfx_Pathname);
            return FALSE;
        }
        if (!(iff->iff_Stream = Open(Gfx_Pathname, MODE_OLDFILE)))
        {   printf("Can't open file %s for reading!\n", Gfx_Pathname);
            return FALSE;
    }   }
    InitIFFasDOS(iff);

    if ((error = OpenIFF(iff, IFFF_READ)))
    {   Close(iff->iff_Stream);
        printf("OpenIFF() failed!");
        return FALSE;
    }

    PropChunk(iff, ID_ILBM, ID_BMHD);
    StopChunk(iff, ID_ILBM, ID_BODY);
    ParseIFF(iff, IFFPARSE_SCAN);

    if (!(sp = FindProp(iff, ID_ILBM, ID_BMHD)))
    {   CloseIFF(iff);
        Close(iff->iff_Stream);
        printf("Can't find BMHD chunk in %s!\n", Gfx_Pathname);
        return FALSE;
    }
    // should probably check the size of the BMHD chunk
    // perhaps we should also check the CMAP chunk
    ok = FALSE;
    bmhd = (struct BitMapHeader*) sp->sp_Data;
    if   (bmhd->bmh_Width       !=    320) printf("Width of %s must be 320!\n"    , Gfx_Pathname);
    elif (bmhd->bmh_Height      != height) printf("Height of %s must be %d!\n"    , Gfx_Pathname, height);
    elif (bmhd->bmh_Depth       !=  depth) printf("Depth of %s must be %d!\n"     , Gfx_Pathname, depth);
    elif (bmhd->bmh_Compression !=      1) printf("Compression of %s must be 1!\n", Gfx_Pathname);
    else ok = TRUE;
    if (!ok)
    {   CloseIFF(iff);
        Close(iff->iff_Stream);
        return FALSE;
    }

    if (!(top = CurrentChunk(iff)))
    {   CloseIFF(iff);
        Close(iff->iff_Stream);
        printf("Can't find BODY chunk in %s!\n", Gfx_Pathname);
        return FALSE;
    }
    if (!(CompressedBuffer = AllocVec(top->cn_Size, MEMF_ANY)))
    {   CloseIFF(iff);
        Close(iff->iff_Stream);
        printf("Out of memory!\n");
        return FALSE;
    }
    actual = ReadChunkBytes(iff, CompressedBuffer, top->cn_Size);
    if (actual != top->cn_Size)
    {   FreeVec(CompressedBuffer);
        CloseIFF(iff);
        Close(iff->iff_Stream);
        printf("Can't read all bytes from BODY chunk in %s!\n", Gfx_Pathname);
        return FALSE;
    }
    uncompressedsize = 320 * height * depth / 8;
    if (!(UncompressedBuffer = AllocVec(uncompressedsize, MEMF_ANY)))
    {   FreeVec(CompressedBuffer);
        CloseIFF(iff);
        Close(iff->iff_Stream);
        printf("Out of memory!\n");
        return FALSE;
    }

    i = j = 0;
    while (i < top->cn_Size && j < uncompressedsize)
    {   t = (SBYTE) CompressedBuffer[i++];
        if (t >= 0)
        {   memcpy(&UncompressedBuffer[j],       &CompressedBuffer[i],  t + 1);
            i += t + 1;
            j += t + 1;
        } elif (t != -128)
        {   memset(&UncompressedBuffer[j], (int)  CompressedBuffer[i], -t + 1);
            i++;
            j += -t + 1;
    }   }

    if (depth == 1)
    {   for (i = 0; i < howmany; i++)
        {   for (y = 0; y < 32; y++)
            {   for (x = 0; x < 32; x++)
                {   if (UncompressedBuffer[((i /  10) * 40 * 32) // tile offset
                                         + ((i %  10) *  4)
                                         +  (y *  40)            // row offset
                                         +  (x /   8)]           // column offset
                                         & (0x80 >> (x % 8)))
                    {   tiledata[((i * 1024) + (y * 32) + x) / 8] |= (0x80 >> (x % 8));
    }   }   }   }   }
    else
    {   for (i = 0; i < howmany; i++)
        {   for (j = 0; j < depth; j++)
            {   for (y = 0; y < 32; y++)
                {   for (x = 0; x < 32; x++)
                    {   if (UncompressedBuffer[((i /  10) * 40 * depth * 32) // tile offset
                                             + ((i %  10) *  4)
                                             +  (y *  40 * depth) // row offset
                                             +  (j *  40)         // plane offset
                                             +  (x /   8)]        // column offset
                                             & (0x80 >> (x % 8)))
                        {   tiledata[(i * 1024) + (y * 32) + x] |= (1 << j);
    }   }   }   }   }   }

    FreeVec(UncompressedBuffer);
    FreeVec(CompressedBuffer);
    CloseIFF(iff);
    Close(iff->iff_Stream);
    return TRUE;
}
