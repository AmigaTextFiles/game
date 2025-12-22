**
** KRSNAke.i
**
** - includes for KRSNAke.library
**

        include 'exec/types.i'

* event codes

SNAKE_QUIT          EQU     23
SNAKE_NEWSCORE      EQU     24
SNAKE_GAMEOVER      EQU     25
SNAKE_NEWGAME       EQU     26
SNAKE_PAUSED        EQU     27
SNAKE_RESTARTED     EQU     28
SNAKE_EATEN         EQU     29
SNAKE_MOVES         EQU     30
SNAKE_NEWCHUNK      EQU     31
SNAKE_HIDEINTERFACE EQU     32
SNAKE_SHOWINTERFACE EQU     33
SNAKE_NEWPREFS      EQU     34

* fill description

    STRUCTURE filldesc,0
    WORD    fd_Type
    LONG    fd_Red
    LONG    fd_Green
    LONG    fd_Blue
    STRUCT  fd_File,256
    STRUCT  fd_Graphic,256
    LABEL   fd_SIZEOF

FILLTYPE_RGB        EQU 0
FILLTYPE_DATATYPE   EQU 1
FILLTYPE_GRAPHIC    EQU 2
FILLTYPE_DRIPEN     EQU 3

FILL_BACK   EQU 0
FILL_LINK   EQU 1
FILL_HEAD   EQU 2
FILL_FRUIT  EQU 3
FILL_FRUIT1 EQU 3
FILL_FRUIT2 EQU 4
FILL_FRUIT3 EQU 5
FILL_FRUIT4 EQU 6

* prefs structure

    STRUCTURE kprefs,0
    LONG    kp_Priority
    ULONG   kp_Flags
    STRUCT  kp_PubScreen,64
    STRUCT  kp_StartGameSound,256
    STRUCT  kp_EatFruitSound,256
    STRUCT  kp_CrashSound,256
    STRUCT  kp_Fill,7*fd_SIZEOF
    STRUCT  kp_PopKey,128
    LABEL   kp_SIZEOF

KPF_LETHAL180   EQU   1
KPB_LETHAL180   EQU   0
KPF_APPICON     EQU   2
KPB_APPICON     EQU   1
KPF_APPMENU     EQU   4
KPB_APPMENU     EQU   2
KPF_FREESOUNDS  EQU   8
KPB_FREESOUNDS  EQU   3
KPF_CONTSOUND   EQU  16
KPB_CONTSOUND   EQU   4

