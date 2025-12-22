// #define TRACKEXIT
#define TRACKDELAY 10

#define SCAN_A1             1
#define SCAN_A2             2
#define SCAN_A3             3
#define SCAN_A4             4
#define SCAN_A5             5
#define SCAN_A6             6
#define SCAN_A7             7
#define SCAN_A8             8
#define SCAN_E             18
#define SCAN_R             19
#define SCAN_T             20
#define SCAN_P             25
#define SCAN_A             32
#define SCAN_S             33
#define SCAN_H             37
#define SCAN_J             38
#define SCAN_B             53
#define SCAN_ENTER         67
#define SCAN_RETURN        68
#define SCAN_ESCAPE        69
#define SCAN_MI            74 // numeric -
#define SCAN_RIGHT         78
#define SCAN_LEFT          79
#define SCAN_PL            94 // numeric +
#define SCAN_HELP          95
#define KEYUP             128

#define MAX_PATH          512
#define WM_APP              0

#define GID_LY1             0 // main window root layout
#define GID_SP1             1 // playfield
#define GID_ST1             2 // 1st robot name
#define GID_ST2             3
#define GID_ST3             4
#define GID_ST4             5
#define GID_ST5             6
#define GID_ST6             7
#define GID_ST7             8
#define GID_ST8             9 // 8th robot name
#define GID_ST9            10 // 1st robot message
#define GID_ST10           11
#define GID_ST11           12
#define GID_ST12           13
#define GID_ST13           14
#define GID_ST14           15
#define GID_ST15           16
#define GID_ST16           17 // 8th robot message
#define GID_ST17           18 // 1st robot velocity
#define GID_ST18           19
#define GID_ST19           20
#define GID_ST20           21
#define GID_ST21           22
#define GID_ST22           23
#define GID_ST23           24
#define GID_ST24           25 // 8th robot velocity
#define GID_ST25           26 // 1st robot actual acceleration
#define GID_ST26           27
#define GID_ST27           28
#define GID_ST28           29
#define GID_ST29           30
#define GID_ST30           31
#define GID_ST31           32
#define GID_ST32           33 // 8th robot actual acceleration
#define GID_IN1            34 // 1st robot X-location
#define GID_IN2            35
#define GID_IN3            36
#define GID_IN4            37
#define GID_IN5            38
#define GID_IN6            39
#define GID_IN7            40
#define GID_IN8            41 // 8th robot X-location
#define GID_IN9            42 // 1st robot Y-location
#define GID_IN10           43
#define GID_IN11           44
#define GID_IN12           45
#define GID_IN13           46
#define GID_IN14           47
#define GID_IN15           48
#define GID_IN16           49 // 8th robot Y-location
#define GID_IN17           50 // 1st robot atomics
#define GID_IN18           51
#define GID_IN19           52
#define GID_IN20           53
#define GID_IN21           54
#define GID_IN22           55
#define GID_IN23           56
#define GID_IN24           57 // 8th robot atomics
#define GID_IN25           58 // 1st robot bombs
#define GID_IN26           59
#define GID_IN27           60
#define GID_IN28           61
#define GID_IN29           62
#define GID_IN30           63
#define GID_IN31           64
#define GID_IN32           65 // 8th robot bombs
#define GID_IN33           66 // 1st robot cannons
#define GID_IN34           67
#define GID_IN35           68
#define GID_IN36           69
#define GID_IN37           70
#define GID_IN38           71
#define GID_IN39           72
#define GID_IN40           73 // 8th robot cannons
#define GID_IN41           74 // 1st robot missiles
#define GID_IN42           75
#define GID_IN43           76
#define GID_IN44           77
#define GID_IN45           78
#define GID_IN46           79
#define GID_IN47           80
#define GID_IN48           81 // 8th robot missiles
#define GID_IN49           82 // 1st robot cur dmg
#define GID_IN50           83
#define GID_IN51           84
#define GID_IN52           85
#define GID_IN53           86
#define GID_IN54           87
#define GID_IN55           88
#define GID_IN56           89 // 8th robot cur dmg
#define GID_IN57           90 // 1st robot max dmg
#define GID_IN58           91
#define GID_IN59           92
#define GID_IN60           93
#define GID_IN61           94
#define GID_IN62           95
#define GID_IN63           96
#define GID_IN64           97 // 8th robot max dmg
#define GID_IN65           98 // 1st robot cur shd
#define GID_IN66           99
#define GID_IN67          100
#define GID_IN68          101
#define GID_IN69          102
#define GID_IN70          103
#define GID_IN71          104
#define GID_IN72          105 // 8th robot cur shd
#define GID_IN73          106 // 1st robot max shd
#define GID_IN74          107
#define GID_IN75          108
#define GID_IN76          109
#define GID_IN77          110
#define GID_IN78          111
#define GID_IN79          112
#define GID_IN80          113 // 8th robot max shd
#define GID_IN81          114 // 1st robot cur egy
#define GID_IN82          115
#define GID_IN83          116
#define GID_IN84          117
#define GID_IN85          118
#define GID_IN86          119
#define GID_IN87          120
#define GID_IN88          121 // 8th robot cur egy
#define GID_IN89          122 // 1st robot max egy
#define GID_IN90          123
#define GID_IN91          124
#define GID_IN92          125
#define GID_IN93          126
#define GID_IN94          127
#define GID_IN95          128
#define GID_IN96          129 // 8th robot max egy
#define GID_CT1           130
#define GID_PA1           131
#define GID_LY2           132 // 1st robot
#define GID_LY3           133
#define GID_LY4           134
#define GID_LY5           135
#define GID_LY6           136
#define GID_LY7           137
#define GID_LY8           138
#define GID_LY9           139 // 8th robot
 // 1-4 (OS3/MOS) or 1-2 (OS4)
#define GID_LY10          140 // 1-4 (OS3) or 1-2 (MOS/OS4)
#define GID_LY11          141 // 5-8 (OS3) or 3-4 (MOS/OS4)
#define GID_LY12          142 //              5-6 (MOS/OS4)
#define GID_LY13          143 //              7-8 (MOS/OS4)
#define GID_BU1           144
#define GID_BU2           145
#define GID_SL1           146

// splash window
#define GID_LY14          147
#define GID_FG1           148

#define GIDS              GID_FG1

#define BLACK               8 // $0
#define DARKGREY           12 // $4
#define LIGHTGREY          20 // $C
#define WHITE              23 // $F
#define PENS               24

#define OS_ANY     0
// #define OS_12  33
// #define OS_13  34
#define OS_20     36
// #define OS_204 37
#define OS_21     38
// #define OS_30  39
#define OS_31     40
#define OS_32     41
#define OS_35     44
#define OS_39     45
#define OS_40     51
// #define OS_41  53

typedef struct Window*         HWND;

#ifndef __amigaos4__
    #define USED
    #define UNUSED
    #define ZERO (BPTR) NULL

    #define GetHead(x) ((x)->lh_Head) // wants struct List*
    #define GetSucc(x) ((x)->ln_Succ) // wants struct Node*. Note: OS4 version works differently!
    #define GetTail(x) ((x)->lh_Tail) // wants struct List*
#endif

#define ListIsEmpty(x)    (!(((x)->lh_Head)->ln_Succ))
#define ListIsFull(x)     (((x)->lh_Head)->ln_Succ)

#ifndef BITMAP_Transparent          // OS4-only tag
    #define BITMAP_Transparent      (BITMAP_Dummy + 18)
#endif

#define PENS_BLACK     pens[BLACK]
#define PENS_DARKGREY  pens[DARKGREY]
#define PENS_LIGHTGREY pens[LIGHTGREY]
#define PENS_WHITE     pens[WHITE]
