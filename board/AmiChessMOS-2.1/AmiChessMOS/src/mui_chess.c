#include <clib/alib_protos.h>
#include <clib/dos_protos.h>
#include <clib/exec_protos.h>
#include <clib/intuition_protos.h>
#include <clib/muimaster_protos.h>
#include <libraries/asl.h>
#include <libraries/gadtools.h>
#include <mui/NListview_mcc.h>
#include <mui/NList_mcc.h>
#include <emul/emulregs.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "common.h"
#include "catalog.h"

void LoadPieces(char *name);
void LoadBoard(char *name);
void PlaySound(Object *snd,BOOL);

extern char *pieces_folder;
extern struct Screen *wbscreen;
extern struct MUI_CustomClass *MUI_Board_Class;
extern struct MUI_CustomClass *MUI_Edit_Class;
extern Object *snd_move;
extern ULONG voice, promotepiece, pix_x;

static Object *mui_menu;

#define find(id) ((Object *)DoMethod(mui_menu,MUIM_FindUData,id))

#define NotifyWinCloseSelf(obj) DoMethod(obj, MUIM_Notify, MUIA_Window_CloseRequest, MUIV_EveryTime, MUIV_Notify_Self, 3, MUIM_Set, MUIA_Window_Open, FALSE)

struct Data
{
Object *win,*col,*mymove,*think,*board,*lv_white,*lv_black;
Object *timewin,*timem,*timet,*times;
Object *promotewin;
Object *tx_nodes,*tx_moves,*tx_score;
Object *evalwin;
Object *tx_w_mat1,*tx_w_mat2,*tx_w_mat3;
Object *tx_b_mat1,*tx_b_mat2,*tx_b_mat3;
Object *tx_eval_score;
Object *editwin;

struct FileRequester *filereq;
};

enum
{
ID_MENU_New=1,
ID_MENU_OpenEPD,
ID_MENU_OpenPGN,
ID_MENU_SaveEPD,
ID_MENU_SavePGN,
ID_MENU_Autoplay,
ID_MENU_Supervisor,
ID_MENU_Swap,
ID_MENU_Switch,
ID_MENU_Undo,
ID_MENU_Remove,
ID_MENU_ShowThinking,
ID_MENU_NullMove,
ID_MENU_UseHash,
ID_MENU_BookAdd,
ID_MENU_BookOff,
ID_MENU_BookOn,
ID_MENU_BookBest,
ID_MENU_BookWorst,
ID_MENU_BookRandom,
ID_MENU_Depth0,
ID_MENU_Depth1,
ID_MENU_Depth2,
ID_MENU_Depth3,
ID_MENU_Depth4,
ID_MENU_Depth5,
ID_MENU_Depth6,
ID_MENU_Depth7,
ID_MENU_Depth8,
ID_MENU_Depth9,
ID_MENU_Depth10,
ID_MENU_Time,
ID_MENU_EditBoard,
ID_MENU_ReverseBoard,
ID_MENU_BoardSmall,
ID_MENU_BoardMedium,
ID_MENU_BoardLarge,
ID_MENU_Board,
ID_MENU_Pieces,
ID_MENU_Voice,
ID_MENU_Eval,
ID_MENU_Stats,
ID_Promote_Queen,
ID_Promote_Rook,
ID_Promote_Bishop,
ID_Promote_Knight,
ID_MENU_About,
ID_MENU_AboutMUI
};

struct MUI_CustomClass *MUI_Chess_Class;

static ULONG playcol[][3]={{0xffffffff,0xffffffff,0xffffffff},{0,0,0}};

static ULONG mNew(struct IClass *cl,Object *obj,struct opSet *msg)
{
Object *win,*col,*mymove,*think,*board,*lv_white,*lv_black;
Object *timewin,*timem,*timet,*times;
Object *promotewin,*promote_q,*promote_r,*promote_b,*promote_n;
Object *statswin,*tx_nodes,*tx_moves,*tx_score;
Object *evalwin,*tx_w_mat1,*tx_w_mat2,*tx_w_mat3;
Object *tx_b_mat1,*tx_b_mat2,*tx_b_mat3,*tx_eval_score;
Object *editwin,*bt_edit_clear,*bt_edit_ok;

#define NM(x) (STRPTR)(x+1)

static struct NewMenu nm[]={
{NM_TITLE,NM(MSG_MENU_PROJECT)},
{NM_ITEM,NM(MSG_MENU_NEW),0,0,0,(APTR)ID_MENU_New},
{NM_ITEM,NM(MSG_MENU_OPENEPD),0,0,0,(APTR)ID_MENU_OpenEPD},
{NM_ITEM,NM(MSG_MENU_OPENPGN),0,0,0,(APTR)ID_MENU_OpenPGN},
{NM_ITEM,NM(MSG_MENU_SAVEEPD),0,0,0,(APTR)ID_MENU_SaveEPD},
{NM_ITEM,NM(MSG_MENU_SAVEPGN),0,0,0,(APTR)ID_MENU_SavePGN},
{NM_ITEM,NM_BARLABEL},
{NM_ITEM,"About...",0,0,0,(APTR)ID_MENU_About},
{NM_ITEM,"About MUI...",0,0,0,(APTR)ID_MENU_AboutMUI},
{NM_ITEM,NM(MSG_MENU_QUIT),0,0,0,(APTR)MUIV_Application_ReturnID_Quit},
{NM_TITLE,NM(MSG_MENU_GAME)},
{NM_ITEM,NM(MSG_MENU_AUTOPLAY),0,CHECKIT|MENUTOGGLE,0,(APTR)ID_MENU_Autoplay},
{NM_ITEM,NM(MSG_MENU_SUPERVISOR),0,CHECKIT|MENUTOGGLE,0,(APTR)ID_MENU_Supervisor},
{NM_ITEM,NM(MSG_MENU_SWAP),0,0,0,(APTR)ID_MENU_Swap},
{NM_ITEM,NM(MSG_MENU_SWITCH),0,0,0,(APTR)ID_MENU_Switch},
{NM_ITEM,NM(MSG_MENU_UNDO),0,0,0,(APTR)ID_MENU_Undo},
{NM_ITEM,NM(MSG_MENU_REMOVE),0,0,0,(APTR)ID_MENU_Remove},
{NM_ITEM,NM_BARLABEL},
{NM_ITEM,NM(MSG_MENU_BOOK)},
{NM_SUB,NM(MSG_MENU_BOOKADD),0,0,0,(APTR)ID_MENU_BookAdd},
{NM_SUB,NM_BARLABEL},
{NM_SUB,NM(MSG_MENU_BOOKOFF),0,CHECKIT,~0x04,(APTR)ID_MENU_BookOff},
{NM_SUB,NM(MSG_MENU_BOOKON),0,CHECKIT|CHECKED,~0x08,(APTR)ID_MENU_BookOn},
{NM_SUB,NM(MSG_MENU_BOOKBEST),0,CHECKIT,~0x10,(APTR)ID_MENU_BookBest},
{NM_SUB,NM(MSG_MENU_BOOKWORST),0,CHECKIT,~0x20,(APTR)ID_MENU_BookWorst},
{NM_SUB,NM(MSG_MENU_BOOKRANDOM),0,CHECKIT,~0x40,(APTR)ID_MENU_BookRandom},
{NM_ITEM,NM(MSG_MENU_DEPTH)},
{NM_SUB,NM(MSG_MENU_DEPTH0),0,CHECKIT|CHECKED,~0x01,(APTR)ID_MENU_Depth0},
{NM_SUB," 1",0,CHECKIT,~0x02,(APTR)ID_MENU_Depth1},
{NM_SUB," 2",0,CHECKIT,~0x04,(APTR)ID_MENU_Depth2},
{NM_SUB," 3",0,CHECKIT,~0x08,(APTR)ID_MENU_Depth3},
{NM_SUB," 4",0,CHECKIT,~0x10,(APTR)ID_MENU_Depth4},
{NM_SUB," 5",0,CHECKIT,~0x20,(APTR)ID_MENU_Depth5},
{NM_SUB," 6",0,CHECKIT,~0x40,(APTR)ID_MENU_Depth6},
{NM_SUB," 7",0,CHECKIT,~0x80,(APTR)ID_MENU_Depth7},
{NM_SUB," 8",0,CHECKIT,~0x100,(APTR)ID_MENU_Depth8},
{NM_SUB," 9",0,CHECKIT,~0x200,(APTR)ID_MENU_Depth9},
{NM_SUB,"10",0,CHECKIT,~0x400,(APTR)ID_MENU_Depth10},
{NM_ITEM,NM(MSG_MENU_TIME),0,0,0,(APTR)ID_MENU_Time},
{NM_ITEM,NM_BARLABEL},
{NM_ITEM,NM(MSG_MENU_SHOWTHINKING),0,CHECKIT|CHECKED|MENUTOGGLE,0,(APTR)ID_MENU_ShowThinking},
{NM_ITEM,NM(MSG_MENU_NULL),0,CHECKIT|CHECKED|MENUTOGGLE,0,(APTR)ID_MENU_NullMove},
{NM_ITEM,NM(MSG_MENU_USEHASH),0,CHECKIT|CHECKED|MENUTOGGLE,0,(APTR)ID_MENU_UseHash},
{NM_TITLE,NM(MSG_MENU_DISPLAY)},
{NM_ITEM,NM(MSG_MENU_BOARDSIZE)},
{NM_SUB,NM(MSG_MENU_BOARDSMALL),0,0,0,(APTR)ID_MENU_BoardSmall},
{NM_SUB,NM(MSG_MENU_BOARDMEDIUM),0,0,0,(APTR)ID_MENU_BoardMedium},
{NM_SUB,NM(MSG_MENU_BOARDLARGE),0,0,0,(APTR)ID_MENU_BoardLarge},
{NM_ITEM,NM(MSG_MENU_BOARDDESIGN),0,0,0,(APTR)ID_MENU_Board},
{NM_ITEM,NM(MSG_MENU_PIECES),0,0,0,(APTR)ID_MENU_Pieces},
{NM_ITEM,NM_BARLABEL},
{NM_ITEM,NM(MSG_MENU_EDITBOARD),0,0,0,(APTR)ID_MENU_EditBoard},
{NM_ITEM,NM(MSG_MENU_REVERSEBOARD),0,CHECKIT|MENUTOGGLE,0,(APTR)ID_MENU_ReverseBoard},
{NM_ITEM,NM(MSG_MENU_VOICE),0,CHECKIT|MENUTOGGLE,0,(APTR)ID_MENU_Voice},
{NM_TITLE,NM(MSG_MENU_EXTRAS)},
{NM_ITEM,NM(MSG_MENU_EVALUATE),0,0,0,(APTR)ID_MENU_Eval},
{NM_ITEM,NM(MSG_MENU_STATISTICS),0,0,0,(APTR)ID_MENU_Stats},
{NM_END}};

ULONG i;
for(i=0;;i++)
        {
        ULONG lab;
        struct NewMenu *n=&nm[i];
        if(n->nm_Type==NM_END) break;
        lab=(ULONG)n->nm_Label;
        if(lab==(ULONG)NM_BARLABEL||lab>MSG_END) continue;
        if(lab) n->nm_Label=getstr(lab-1);
        }

obj=DoSuperNew(cl,obj,
        MUIA_Application_Title,"AmiChess",
        MUIA_Application_Base,"AmiChess",
        MUIA_Application_Author,"Achim Stegemann",
        MUIA_Application_Copyright,"Based on GnuChess 5.06",
        MUIA_Application_Version,"$VER: AmiChess 2.1 (18.1.2004)",
        MUIA_Application_Description,"Amiga port of GNUChess 5.06",
        MUIA_Application_Menustrip,mui_menu=MUI_MakeObject(MUIO_MenustripNM,nm,MUIO_MenustripNM_CommandKeyCheck),
        SubWindow,win=WindowObject,
                MUIA_Window_Title,"AmiChess 2.1 by Achim Stegemann",
                MUIA_Window_ID, 0x43285353,
                WindowContents,VGroup,
                        Child,VGroup,
                                GroupFrame,
                                MUIA_Background,MUII_GroupBack,
                                Child,HGroup,
                                        Child,col=ColorfieldObject,
                                                TextFrame,
                                                MUIA_FixWidthTxt,"W",
                                                MUIA_FixHeightTxt,"W",
                                                MUIA_Colorfield_RGB,playcol[0],
                                        End,
                                        Child,Label1(getstr(MSG_MYMOVE)),
                                        Child,mymove=TextObject,
                                                TextFrame,
                                                MUIA_Font,MUIV_Font_Fixed,
                                                MUIA_Background,MUII_TextBack,
                                                MUIA_Text_PreParse,MUIX_PH,
                                        End,
                                End,
                                Child,HGroup,
                                        Child,Label1(getstr(MSG_BESTLINE)),
                                        Child,think=TextObject,
                                                TextFrame,
                                                MUIA_Font,MUIV_Font_Fixed,
                                                MUIA_Background,MUII_TextBack,
                                                MUIA_Text_PreParse,MUIX_PH,
                                        End,
                                End,
                        End,
                        Child,HGroup,
                                GroupFrame,
                                MUIA_Background,MUII_GroupBack,
                                Child,board=NewObject(MUI_Board_Class->mcc_Class,0,TAG_END),
                                Child,lv_white=NListviewObject,
                                        ReadListFrame,
                                        MUIA_NListview_NList,NListObject,
                                                MUIA_Font,MUIV_Font_Fixed,
                                                MUIA_NList_Input,0,
                                                MUIA_NList_ConstructHook,MUIV_NList_ConstructHook_String,
                                                MUIA_NList_DestructHook,MUIV_NList_DestructHook_String,
                                                MUIA_NList_Title,getstr(MSG_WHITE),
                                        End,
                                End,
                                Child,lv_black=NListviewObject,
                                        ReadListFrame,
                                        MUIA_NListview_NList,NListObject,
                                                MUIA_Font,MUIV_Font_Fixed,
                                                MUIA_NList_Input,0,
                                                MUIA_NList_ConstructHook,MUIV_NList_ConstructHook_String,
                                                MUIA_NList_DestructHook,MUIV_NList_DestructHook_String,
                                                MUIA_NList_Title,getstr(MSG_BLACK),
                                        End,
                                End,
                        End,
                End,
        End,
        SubWindow,timewin=WindowObject,
                MUIA_Window_Title,getstr(MSG_TIMESETTINGS),
                MUIA_Window_ID, 0x4348534D,
                MUIA_Window_Screen,wbscreen,
                WindowContents,VGroup,
                        Child,HGroup,
                                Child,timem=StringObject,
                                        StringFrame,
                                        MUIA_CycleChain,1,
                                        MUIA_String_Accept,"0123456789",
                                        MUIA_String_MaxLen,4,
                                        MUIA_String_Integer,0,
                                End,
                                Child,Label2(getstr(MSG_MOVESIN)),
                                Child,timet=StringObject,
                                        StringFrame,
                                        MUIA_CycleChain,1,
                                        MUIA_String_Accept,"0123456789",
                                        MUIA_String_MaxLen,4,
                                        MUIA_String_Integer,0,
                                End,
                                Child,Label2(getstr(MSG_MINUTES)),
                        End,
                        Child,HGroup,
                                Child,Label2(getstr(MSG_SEARCHITIME)),
                                Child,times=StringObject,
                                        StringFrame,
                                        MUIA_CycleChain,1,
                                        MUIA_String_Accept,"0123456789",
                                        MUIA_String_MaxLen,4,
                                        MUIA_String_Integer,5,
                                End,
                        End,
                End,
        End,
        SubWindow,promotewin=WindowObject,
                MUIA_Window_Title,getstr(MSG_PROMOTEPAWN),
                MUIA_Window_ID, 0x43485350,
                WindowContents,VGroup,
                        Child,HGroup,
                                Child,promote_q=ImageObject,
                                        ImageButtonFrame,
                                        MUIA_CycleChain,1,
                                        MUIA_FixWidth,56,
                                        MUIA_FixHeight,56,
                                        MUIA_Image_FreeVert,1,
                                        MUIA_InputMode,MUIV_InputMode_RelVerify,
                                        MUIA_Image_FreeVert,1,
                                        MUIA_Image_FreeHoriz,1,
                                        MUIA_Image_Spec,"5:PROGDIR:Promote/Queen",
                                End,
                                Child,promote_r=ImageObject,
                                        ImageButtonFrame,
                                        MUIA_CycleChain,1,
                                        MUIA_FixWidth,56,
                                        MUIA_FixHeight,56,
                                        MUIA_InputMode,MUIV_InputMode_RelVerify,
                                        MUIA_Image_FreeVert,1,
                                        MUIA_Image_FreeHoriz,1,
                                        MUIA_Image_Spec,"5:PROGDIR:Promote/Rook",
                                End,
                                Child,promote_b=ImageObject,
                                        ImageButtonFrame,
                                        MUIA_CycleChain,1,
                                        MUIA_FixWidth,56,
                                        MUIA_FixHeight,56,
                                        MUIA_InputMode,MUIV_InputMode_RelVerify,
                                        MUIA_Image_FreeVert,1,
                                        MUIA_Image_FreeHoriz,1,
                                        MUIA_Image_Spec,"5:PROGDIR:Promote/Bishop",
                                End,
                                Child,promote_n=ImageObject,
                                        ImageButtonFrame,
                                        MUIA_CycleChain,1,
                                        MUIA_FixWidth,56,
                                        MUIA_FixHeight,56,
                                        MUIA_InputMode,MUIV_InputMode_RelVerify,
                                        MUIA_Image_FreeVert,1,
                                        MUIA_Image_FreeHoriz,1,
                                        MUIA_Image_Spec,"5:PROGDIR:Promote/Knight",
                                End,
                        End,
                End,
        End,
        SubWindow,statswin=WindowObject,
                MUIA_Window_Title,getstr(MSG_STATISTICS),
                MUIA_Window_ID, 0x43485354,
                MUIA_Window_Width,MUIV_Window_Width_Screen(25),
                WindowContents,VGroup,
                        Child,VGroup,
                                MUIA_Background,MUII_TextBack,
                                Child,tx_nodes=TextObject,
                                        MUIA_Text_Contents,getstr(MSG_STAT_INIT0),
                                End,
                                Child,tx_moves=TextObject,
                                        MUIA_Text_Contents,getstr(MSG_STAT_INIT1),
                                End,
                                Child,tx_score=TextObject,
                                        MUIA_Text_Contents,getstr(MSG_STAT_INIT2),
                                End,
                        End,
                End,
        End,
        SubWindow,evalwin=WindowObject,
                MUIA_Window_Title,getstr(MSG_POSEVAL),
                MUIA_Window_ID, 0x43485345,
                MUIA_Window_Width,MUIV_Window_Width_Screen(25),
                WindowContents,VGroup,
                        Child,VGroup,
                                GroupFrameT(getstr(MSG_WHITE)),
                                MUIA_Background,MUII_TextBack,
                                Child,tx_w_mat1=TextObject,
                                        MUIA_Text_Contents,getstr(MSG_POSEVAL_INIT1),
                                End,
                                Child,tx_w_mat2=TextObject,
                                        MUIA_Text_Contents,getstr(MSG_POSEVAL_INIT2),
                                End,
                                Child,tx_w_mat3=TextObject,
                                        MUIA_Text_Contents,getstr(MSG_POSEVAL_INIT3),
                                End,
                        End,
                        Child,VGroup,
                                GroupFrameT(getstr(MSG_BLACK)),
                                MUIA_Background,MUII_TextBack,
                                Child,tx_b_mat1=TextObject,
                                        MUIA_Text_Contents,getstr(MSG_POSEVAL_INIT1),
                                End,
                                Child,tx_b_mat2=TextObject,
                                        MUIA_Text_Contents,getstr(MSG_POSEVAL_INIT2),
                                End,
                                Child,tx_b_mat3=TextObject,
                                        MUIA_Text_Contents,getstr(MSG_POSEVAL_INIT3),
                                End,
                        End,
                        Child,RectangleObject,
                                MUIA_VertWeight,0,
                                MUIA_Rectangle_HBar,1,
                        End,
                        Child,tx_eval_score=TextObject,
                                TextFrame,
                                MUIA_Background,MUII_TextBack,
                        End,
                End,
        End,
        SubWindow,editwin=WindowObject,
                MUIA_Window_Title,"Edit board",
                MUIA_Window_ID, 0x43485344,
                WindowContents,VGroup,
                        Child,ColGroup(6),
                                Child,NewObject(MUI_Edit_Class->mcc_Class,0,MUIA_UserData,106,TAG_END),
                                Child,NewObject(MUI_Edit_Class->mcc_Class,0,MUIA_UserData,108,TAG_END),
                                Child,NewObject(MUI_Edit_Class->mcc_Class,0,MUIA_UserData,109,TAG_END),
                                Child,NewObject(MUI_Edit_Class->mcc_Class,0,MUIA_UserData,107,TAG_END),
                                Child,NewObject(MUI_Edit_Class->mcc_Class,0,MUIA_UserData,110,TAG_END),
                                Child,NewObject(MUI_Edit_Class->mcc_Class,0,MUIA_UserData,111,TAG_END),
                        End,
                        Child,ColGroup(6),
                                Child,NewObject(MUI_Edit_Class->mcc_Class,0,MUIA_UserData,100,TAG_END),
                                Child,NewObject(MUI_Edit_Class->mcc_Class,0,MUIA_UserData,102,TAG_END),
                                Child,NewObject(MUI_Edit_Class->mcc_Class,0,MUIA_UserData,103,TAG_END),
                                Child,NewObject(MUI_Edit_Class->mcc_Class,0,MUIA_UserData,101,TAG_END),
                                Child,NewObject(MUI_Edit_Class->mcc_Class,0,MUIA_UserData,104,TAG_END),
                                Child,NewObject(MUI_Edit_Class->mcc_Class,0,MUIA_UserData,105,TAG_END),
                        End,
                        Child,bt_edit_clear=TextObject,
                                ButtonFrame,
                                MUIA_Background,MUII_ButtonBack,
                                MUIA_InputMode,MUIV_InputMode_RelVerify,
                                MUIA_ControlChar,'c',
                                MUIA_Text_HiChar,'c',
                                MUIA_Text_PreParse,MUIX_C,
                                MUIA_Text_Contents,"_Clear board",
                        End,
                        Child,HVSpace,
                        Child,bt_edit_ok=TextObject,
                                ButtonFrame,
                                MUIA_Background,MUII_ButtonBack,
                                MUIA_InputMode,MUIV_InputMode_RelVerify,
                                MUIA_ControlChar,'o',
                                MUIA_Text_HiChar,'o',
                                MUIA_Text_PreParse,MUIX_C,
                                MUIA_Text_Contents,"_Ok",
                        End,
                End,
        End,
TAG_MORE,msg->ops_AttrList);
if(obj)
        {
        ULONG i;
        struct Data *data=(struct Data *)INST_DATA(cl,obj);
        struct FileInfoBlock *fib;
        Object *menu,*sub;
        BPTR lock;
        data->win=win;
        data->col=col;
        data->mymove=mymove;
        data->think=think;
        data->lv_white=lv_white;
        data->lv_black=lv_black;
        data->board=board;
        data->timewin=timewin;
        data->timem=timem;
        data->timet=timet;
        data->times=times;
        data->promotewin=promotewin;
        data->tx_nodes=tx_nodes;
        data->tx_moves=tx_moves;
        data->tx_score=tx_score;
        data->evalwin=evalwin;
        data->tx_w_mat1=tx_w_mat1;
        data->tx_w_mat2=tx_w_mat2;
        data->tx_w_mat3=tx_w_mat3;
        data->tx_b_mat1=tx_b_mat1;
        data->tx_b_mat2=tx_b_mat2;
        data->tx_b_mat3=tx_b_mat3;
        data->tx_eval_score=tx_eval_score;
        data->editwin=editwin;
        NotifyWinCloseSelf(evalwin);
        NotifyWinCloseSelf(statswin);
        NotifyWinCloseSelf(timewin);
        NotifyWinCloseSelf(editwin);
        DoMethod(find(ID_MENU_New),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Chess_New);
        DoMethod(find(ID_MENU_OpenEPD),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Chess_OpenEPD);
        DoMethod(find(ID_MENU_OpenPGN),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Chess_OpenPGN);
        DoMethod(find(ID_MENU_SaveEPD),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Chess_SaveEPD);
        DoMethod(find(ID_MENU_SavePGN),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Chess_SavePGN);
        DoMethod(find(ID_MENU_AboutMUI),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Application_AboutMUI);
        DoMethod(find(ID_MENU_About),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Chess_About);
        DoMethod(find(ID_MENU_Autoplay),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_Autoplay,MUIV_TriggerValue);
        DoMethod(find(ID_MENU_Supervisor),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_Supervisor,MUIV_TriggerValue);
        DoMethod(find(ID_MENU_Swap),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Chess_SwapSides);
        DoMethod(find(ID_MENU_Switch),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Chess_SwitchSides);
        DoMethod(find(ID_MENU_Undo),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Chess_Undo);
        DoMethod(find(ID_MENU_Remove),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Chess_Remove);
        DoMethod(find(ID_MENU_ShowThinking),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_Post,MUIV_TriggerValue);
        DoMethod(find(ID_MENU_NullMove),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_NullMove,MUIV_TriggerValue);
        DoMethod(find(ID_MENU_UseHash),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_UseHash,MUIV_TriggerValue);
        DoMethod(find(ID_MENU_BookAdd),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Chess_BookAdd);
        DoMethod(find(ID_MENU_BookOff),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,1,MUIM_Chess_BookOff);
        DoMethod(find(ID_MENU_BookOn),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,1,MUIM_Chess_BookOn);
        DoMethod(find(ID_MENU_BookBest),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,1,MUIM_Chess_BookBest);
        DoMethod(find(ID_MENU_BookWorst),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,1,MUIM_Chess_BookWorst);
        DoMethod(find(ID_MENU_BookRandom),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,1,MUIM_Chess_BookRandom);
        DoMethod(find(ID_MENU_Depth0),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_Depth,0);
        DoMethod(find(ID_MENU_Depth1),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_Depth,1);
        DoMethod(find(ID_MENU_Depth2),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_Depth,2);
        DoMethod(find(ID_MENU_Depth3),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_Depth,3);
        DoMethod(find(ID_MENU_Depth4),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_Depth,4);
        DoMethod(find(ID_MENU_Depth5),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_Depth,5);
        DoMethod(find(ID_MENU_Depth6),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_Depth,6);
        DoMethod(find(ID_MENU_Depth7),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_Depth,7);
        DoMethod(find(ID_MENU_Depth8),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_Depth,8);
        DoMethod(find(ID_MENU_Depth9),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_Depth,9);
        DoMethod(find(ID_MENU_Depth10),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_Depth,10);
        DoMethod(find(ID_MENU_Time),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,timewin,3,MUIM_Set,MUIA_Window_Open,1);
        DoMethod(find(ID_MENU_EditBoard),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,editwin,3,MUIM_Set,MUIA_Window_Open,1);
        DoMethod(find(ID_MENU_ReverseBoard),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,2,MUIM_Chess_ReverseBoard,MUIV_TriggerValue);
        DoMethod(find(ID_MENU_Voice),MUIM_Notify,MUIA_Menuitem_Checked,MUIV_EveryTime,obj,3,MUIM_WriteLong,MUIV_TriggerValue,&voice);
        DoMethod(find(ID_MENU_Eval),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Chess_Eval);
        DoMethod(find(ID_MENU_Stats),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,statswin,3,MUIM_Set,MUIA_Window_Open,1);
        DoMethod(find(ID_MENU_BoardSmall),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Chess_BoardSmall);
        DoMethod(find(ID_MENU_BoardMedium),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Chess_BoardMedium);
        DoMethod(find(ID_MENU_BoardLarge),MUIM_Notify,MUIA_Menuitem_Trigger,MUIV_EveryTime,obj,1,MUIM_Chess_BoardLarge);
        DoMethod(win,MUIM_Notify,MUIA_Window_CloseRequest,1,obj,2,MUIM_Application_ReturnID,MUIV_Application_ReturnID_Quit);
        DoMethod(timem,MUIM_Notify,MUIA_String_Acknowledge,MUIV_EveryTime,obj,2,MUIM_Chess_Time,0);
        DoMethod(timet,MUIM_Notify,MUIA_String_Acknowledge,MUIV_EveryTime,obj,2,MUIM_Chess_Time,1);
        DoMethod(times,MUIM_Notify,MUIA_String_Acknowledge,MUIV_EveryTime,obj,2,MUIM_Chess_Time,2);
        DoMethod(promotewin,MUIM_Notify,MUIA_Window_CloseRequest,1,obj,2,MUIM_Application_ReturnID,ID_Promote_Queen);
        DoMethod(promote_q,MUIM_Notify,MUIA_Pressed,0,obj,2,MUIM_Application_ReturnID,ID_Promote_Queen);
        DoMethod(promote_r,MUIM_Notify,MUIA_Pressed,0,obj,2,MUIM_Application_ReturnID,ID_Promote_Rook);
        DoMethod(promote_b,MUIM_Notify,MUIA_Pressed,0,obj,2,MUIM_Application_ReturnID,ID_Promote_Bishop);
        DoMethod(promote_n,MUIM_Notify,MUIA_Pressed,0,obj,2,MUIM_Application_ReturnID,ID_Promote_Knight);
        SetAttrs(promotewin,MUIA_Window_ActiveObject,promote_q,TAG_END);
        DoMethod(bt_edit_clear,MUIM_Notify,MUIA_Pressed,0,obj,1,MUIM_Chess_EditClear);
        DoMethod(bt_edit_ok,MUIM_Notify,MUIA_Pressed,0,obj,1,MUIM_Chess_EditOk);
        data->filereq=(struct FileRequester *)MUI_AllocAslRequestTags(ASL_FileRequest,ASLFR_RejectIcons,TAG_END);
        if((fib=(struct FileInfoBlock *)AllocDosObject(DOS_FIB,0)))
                {
                if((lock=Lock("PROGDIR:Boards",SHARED_LOCK)))
                        {
                        if(Examine(lock,fib)!=DOSFALSE)
                                {
                                i=0;
                                menu=find(ID_MENU_Board);
                                while(ExNext(lock,fib)!=DOSFALSE)
                                        {
                                        if(fib->fib_DirEntryType>0)
                                                {
                                                char *str;
                                                str=malloc(strlen(fib->fib_FileName)+1);
                                                strcpy(str,fib->fib_FileName);
                                                sub=MenuitemObject,
                                                        MUIA_Menuitem_Checkit,1,
                                                        MUIA_Menuitem_Checked,strcmp(fib->fib_FileName,"Default")?0:1,
                                                        MUIA_Menuitem_Title,str,
                                                        MUIA_Menuitem_Exclude,~(1<<i),
                                                End;
                                                DoMethod(menu,OM_ADDMEMBER,sub);
                                                DoMethod(sub,MUIM_Notify,MUIA_Menuitem_Checked,1,obj,2,MUIM_Chess_Board,sub);
                                                i++;
                                                }
                                        }
                                }
                        UnLock(lock);
                        }
                FreeDosObject(DOS_FIB,fib);
                }
        if((fib=(struct FileInfoBlock *)AllocDosObject(DOS_FIB,0)))
                {
                if((lock=Lock(pieces_folder,SHARED_LOCK)))
                        {
                        if(Examine(lock,fib)!=DOSFALSE)
                                {
                                i=0;
                                menu=find(ID_MENU_Pieces);
                                while(ExNext(lock,fib)!=DOSFALSE)
                                        {
                                        char *str;
                                        str=malloc(strlen(fib->fib_FileName)+1);
                                        strcpy(str,fib->fib_FileName);
                                        sub=MenuitemObject,
                                                MUIA_Menuitem_Checkit,1,
                                                MUIA_Menuitem_Checked,strcmp(fib->fib_FileName,"Default")?0:1,
                                                MUIA_Menuitem_Title,str,
                                                MUIA_Menuitem_Exclude,~(1<<i),
                                        End;
                                        DoMethod(menu,OM_ADDMEMBER,sub);
                                        DoMethod(sub,MUIM_Notify,MUIA_Menuitem_Checked,1,obj,2,MUIM_Chess_Pieces,sub);
                                        i++;
                                        }
                                }
                        UnLock(lock);
                        }
                FreeDosObject(DOS_FIB,fib);
                }
        }
return (ULONG)obj;
}

static ULONG mDispose(struct IClass *cl,Object *obj,Msg msg)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
if(data->filereq) MUI_FreeAslRequest(data->filereq);
return DoSuperMethodA(cl,obj,msg);
}

static void mChessNewgame(struct IClass *cl,Object *obj)
{
InitVars();
NewPosition();
myrating=opprating=0;
DoMethod(obj,MUIM_Chess_ShowThinking,0);
DoMethod(obj,MUIM_Chess_MyMove,0);
SetAttrs(find(ID_MENU_Autoplay),MUIA_Menuitem_Checked,0,TAG_END);
SetAttrs(find(ID_MENU_Supervisor),MUIA_Menuitem_Checked,0,TAG_END);
DoMethod(obj,MUIM_Chess_ClearList);
DoMethod(obj,MUIM_Chess_ShowBoard);
}

static void mChessAbout(struct IClass *cl,Object *obj)
{
  Object *awindow, *button;
  ULONG signals;
  BOOL running = TRUE;

  if ((awindow = MUI_NewObject(MUIC_Window,
   MUIA_Window_Title, (ULONG)"About AmiChess",
   MUIA_Window_RootObject, MUI_NewObject(MUIC_Group,
    MUIA_Group_Child, MUI_NewObject(MUIC_Group,
     MUIA_Frame, MUIV_Frame_Text,
     MUIA_Group_Child, MUI_NewObject(MUIC_Text,
      MUIA_Text_Contents, (ULONG)"\33c ",
     TAG_END),
     MUIA_Group_Child, MUI_NewObject(MUIC_Text,
      MUIA_Font, MUIV_Font_Big,
      MUIA_Text_Contents, (ULONG)"\33cAmiChess 2.1",
     TAG_END),
     MUIA_Group_Child, MUI_NewObject(MUIC_Text,
      MUIA_Text_Contents, (ULONG)"\33c\nwritten by\nAchim Stegemann\n\nMorphOS port by\nGrzegorz \"Krashan\" Kraszewski\n\33i<krashan@teleinfo.pb.bialystok.pl> \n",
      MUIA_Text_SetMax, TRUE,
     TAG_END),
    TAG_END),
    MUIA_Group_Child,(ULONG)(button = MUI_NewObject(MUIC_Text,
     MUIA_Background, MUII_ButtonBack,
     MUIA_Font, MUIV_Font_Button,
     MUIA_Frame, MUIV_Frame_Button,
     MUIA_Text_Contents, (ULONG)"OK",
     MUIA_Text_PreParse, (ULONG)"\33c",
     MUIA_CycleChain, TRUE,
     MUIA_InputMode, MUIV_InputMode_RelVerify,
    TAG_END)),
   TAG_END),
  TAG_END)))
  {
    DoMethod(obj, OM_ADDMEMBER, awindow);
    DoMethod(awindow, MUIM_Notify, MUIA_Window_CloseRequest, MUIV_EveryTime, obj, 2,
     MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit);
    DoMethod(button, MUIM_Notify, MUIA_Pressed, FALSE, obj, 2,
     MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit);
    SetAttrs(awindow, MUIA_Window_Open, TRUE);

    while (running)
    {
      if (DoMethod(obj, MUIM_Application_NewInput, &signals) ==
       MUIV_Application_ReturnID_Quit) running = FALSE;
      if (signals) signals = Wait(signals);
    }

    SetAttrs(awindow, MUIA_Window_Open, FALSE);
    DoMethod(obj, OM_REMMEMBER, awindow);
    MUI_DisposeObject(awindow);
  }
}

static void mChessOpenEPD(struct IClass *cl,Object *obj)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
if(MUI_AslRequestTags(data->filereq,ASLFR_InitialPattern,"#?",ASLFR_DoSaveMode,0,TAG_END))
        {
        BPTR lock;
        if((lock=Lock(data->filereq->fr_Drawer,SHARED_LOCK)))
                {
                BPTR olddir=CurrentDir(lock);
                DoMethod(obj,MUIM_Chess_ClearList);
                LoadEPD(data->filereq->fr_File);
                if(!ValidateBoard())
                        {
                        SET(flags,ENDED);
                        DoMethod(obj,MUIM_Chess_ShowThinking,getstr(MSG_BOARDWRONG));
                        }
                CurrentDir(olddir);
                UnLock(lock);
                }
        }
}

static void mChessOpenPGN(struct IClass *cl,Object *obj)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
if(MUI_AslRequestTags(data->filereq,ASLFR_InitialPattern,"#?.pgn",ASLFR_DoSaveMode,0,TAG_END))
        {
        BPTR lock;
        if((lock=Lock(data->filereq->fr_Drawer,SHARED_LOCK)))
                {
                BPTR olddir=CurrentDir(lock);
                PGNReadFromFile(data->filereq->fr_File);
                CurrentDir(olddir);
                UnLock(lock);
                }
        }
}

static void mChessSaveEPD(struct IClass *cl,Object *obj)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
if(MUI_AslRequestTags(data->filereq,ASLFR_InitialPattern,"#?",ASLFR_DoSaveMode,1,TAG_END))
        {
        BPTR lock;
        if((lock=Lock(data->filereq->fr_Drawer,SHARED_LOCK)))
                {
                BPTR olddir=CurrentDir(lock);
                SaveEPD(data->filereq->fr_File);
                CurrentDir(olddir);
                UnLock(lock);
                }
        }
}

static void mChessSavePGN(struct IClass *cl,Object *obj)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
if(MUI_AslRequestTags(data->filereq,ASLFR_InitialPattern,"#?.pgn",ASLFR_DoSaveMode,1,TAG_END))
        {
        BPTR lock;
        if((lock=Lock(data->filereq->fr_Drawer,SHARED_LOCK)))
                {
                BPTR olddir=CurrentDir(lock);
                PGNSaveToFile(data->filereq->fr_File,resultstr);
                CurrentDir(olddir);
                UnLock(lock);
                }
        }
}

static void mChessAutoplay(struct MUIP_Chess_Autoplay *msg)
{
if(msg->autoplay) SET(flags,AUTOPLAY);
else CLEAR(flags,AUTOPLAY);
}

static void mChessSwapSides(Object *obj)
{
if(flags&SUPERVISOR) DoMethod(obj,MUIM_Chess_ShowThinking,getstr(MSG_NOTPOSSIBLE));
else
        {
        CLEAR(flags,TIMEOUT);
        CLEAR(flags,ENDED);
        computer=board.side;
        Iterate();
        if(flags&ENDED)
                {
                SetAttrs(find(ID_MENU_Autoplay),MUIA_NoNotify,1,MUIA_Menuitem_Checked,0,TAG_END);
                CLEAR(flags,AUTOPLAY);
                }
        }
}

static void mChessSwitchSides(Object *obj)
{
board.side=1^board.side;
DoMethod(obj,MUIM_Chess_Side);
}

static void mChessUndo(struct IClass *cl,Object *obj)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
if(GameCnt>=0) UnmakeMove(board.side,&Game[GameCnt].move);
else DisplayBeep(0);
MoveLimit[board.side]++;
TimeLimit[board.side]+=Game[GameCnt+1].et;
DoMethod(board.side==white?data->lv_white:data->lv_black,MUIM_NList_Remove,MUIV_NList_Remove_Last);
DoMethod(obj,MUIM_Chess_ShowThinking,0);
DoMethod(obj,MUIM_Chess_Side);
DoMethod(obj,MUIM_Chess_ShowBoard);
}

static void mChessRemove(struct IClass *cl,Object *obj)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
if(GameCnt>=0)
        {
        CLEAR(flags,ENDED);
        CLEAR(flags,TIMEOUT);
        DoMethod(board.side==white?data->lv_white:data->lv_black,MUIM_NList_Remove,MUIV_NList_Remove_Last);
        UnmakeMove(board.side,&Game[GameCnt].move);
        if(GameCnt>=0)
                {
                DoMethod(board.side==white?data->lv_white:data->lv_black,MUIM_NList_Remove,MUIV_NList_Remove_Last);
                UnmakeMove(board.side,&Game[GameCnt].move);
                DoMethod(obj,MUIM_Chess_ShowThinking,0);
                DoMethod(obj,MUIM_Chess_ShowBoard);
                }
        DoMethod(obj,MUIM_Chess_Side);
        }
else DisplayBeep(0);
}

static void mChessSupervisor(struct MUIP_Chess_Supervisor *msg)
{
if(msg->value) SET(flags,SUPERVISOR);
else CLEAR(flags,SUPERVISOR);
}

static void mChessPost(Object *obj,struct MUIP_Chess_Post *msg)
{
if(msg->value) SET(flags,POST);
else
        {
        CLEAR(flags,POST);
        DoMethod(obj,MUIM_Chess_ShowThinking,0);
        }
}

static void mChessBookAdd(struct IClass *cl,Object *obj)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
if(MUI_AslRequestTags(data->filereq,ASLFR_InitialPattern,"#?.pgn",ASLFR_DoSaveMode,0,TAG_END))
        {
        BPTR lock;
        if((lock=Lock(data->filereq->fr_Drawer,SHARED_LOCK)))
                {
                BPTR olddir=CurrentDir(lock);
                BookPGNReadFromFile(data->filereq->fr_File);
                CurrentDir(olddir);
                UnLock(lock);
                }
        }
}

static void mChessBookOn(void)
{
bookmode=BOOKPREFER;
}

static void mChessBookOff(void)
{
bookmode=BOOKOFF;
}

static void mChessBookBest(void)
{
bookmode=BOOKBEST;
}

static void mChessBookWorst(void)
{
bookmode=BOOKWORST;
}

static void mChessBookRandom(void)
{
bookmode=BOOKRAND;
}

static void mChessDepth(struct MUIP_Chess_Depth *msg)
{
SearchDepth=msg->depth;
}

static void mChessTime(struct IClass *cl,Object *obj,struct MUIP_Chess_Time *msg)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
ULONG val;
char text[50];
switch(msg->flag)
        {
        case 0:
                GetAttr(MUIA_String_Integer,data->timem,&val);
                TCMove=val;
                break;
        case 1:
                GetAttr(MUIA_String_Integer,data->timet,&val);
                TCTime=val;
                break;
        default:
                GetAttr(MUIA_String_Integer,data->times,&val);
                if(!val) val=5;
                SearchTime=val;
        }
if(!TCMove&&!TCTime)
        {
        sprintf(text,getstr(MSG_SEARCHTIMESET),SearchTime);
        DoMethod(obj,MUIM_Chess_ShowThinking,text);
        CLEAR(flags,TIMECTL);
        }
else
        {
        if(!TCMove)
                {
                TCMove=35;
                suddendeath=1;
                }
        else suddendeath=0;
        SET(flags,TIMECTL);
        if(!TCTime) SearchTime=TCinc/2; /* TCinc = Fisher increment in secs */
        else
                {
                MoveLimit[white]=MoveLimit[black]=TCMove;
                TimeLimit[white]=TimeLimit[black]=TCTime*60;
                }
        sprintf(text,getstr(MSG_TIMECONTROL),MoveLimit[white],TimeLimit[white]);
        DoMethod(obj,MUIM_Chess_ShowThinking,text);
        }
}

static void mChessWinOpen(struct IClass *cl,Object *obj)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
SetAttrs(data->win,MUIA_Window_Open,1,TAG_END);
}

static void     mChessShowBoard(struct IClass *cl,Object *obj,Msg msg)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
DoMethodA(data->board,msg);
}

static void     mChessShowThinking(struct IClass *cl,Object *obj,struct MUIP_Chess_ShowThinking *msg)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
SetAttrs(data->think,MUIA_Text_Contents,msg->line,TAG_END);
}

static void mChessNullMove(struct MUIP_Chess_NullMove *msg)
{
if(msg->value) SET(flags,USENULL);
else CLEAR(flags,USENULL);
}

static void mChessUseHash(struct MUIP_Chess_UseHash *msg)
{
if(msg->usehash) SET(flags,USEHASH);
else CLEAR(flags,USEHASH);
}

static void mChessReverseBoard(Object *obj,struct MUIP_Chess_ReverseBoard *msg)
{
if(msg->reverse) SET(flags,REVERSEBOARD);
else CLEAR(flags,REVERSEBOARD);
DoMethod(obj,MUIM_Chess_ShowBoard);
}

static void mChessMyMove(struct IClass *cl,Object *obj,struct MUIP_Chess_MyMove *msg)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
SetAttrs(data->mymove,MUIA_Text_Contents,msg->move,TAG_END);
}

static void mChessSide(struct IClass *cl,Object *obj)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
SetAttrs(data->col,MUIA_Colorfield_RGB,playcol[board.side],TAG_END);
}

static void RestoreBoard(void)
{
struct List *list;
struct Node *node;
Object *sub;
Object *menu=find(ID_MENU_Board);
GetAttr(MUIA_Family_List,menu,(ULONG*)&list);
node=list->lh_Head;
while((sub=NextObject((APTR)&node)))
        {
        ULONG checked;
        GetAttr(MUIA_Menuitem_Checked,sub,(ULONG*)&checked);
        if(checked)
                {
                char *t;
                GetAttr(MUIA_Menuitem_Title,sub,(ULONG*)&t);
                LoadBoard(t);
                break;
                }
        }
menu=find(ID_MENU_Pieces);
GetAttr(MUIA_Family_List,menu,(ULONG*)&list);
node=list->lh_Head;
while((sub=NextObject((APTR)&node)))
        {
        ULONG checked;
        GetAttr(MUIA_Menuitem_Checked,sub,(ULONG*)&checked);
        if(checked)
                {
                char *t;
                GetAttr(MUIA_Menuitem_Title,sub,(ULONG*)&t);
                LoadPieces(t);
                break;
                }
        }
}

static void mChessBoardSmall(struct IClass *cl,Object *obj)
{
if(pix_x!=45)
        {
        struct Data *data=(struct Data *)INST_DATA(cl,obj);
        SetAttrs(data->win,MUIA_Window_Open,0,TAG_END);
        pix_x=45;
        pieces_folder="PROGDIR:Pieces/640";
        RestoreBoard();
        SetAttrs(data->win,MUIA_Window_Open,1,TAG_END);
        }
}

static void mChessBoardMedium(struct IClass *cl,Object *obj)
{
if(wbscreen->Width>=800&&pix_x!=56)
        {
        struct Data *data=(struct Data *)INST_DATA(cl,obj);
        SetAttrs(data->win,MUIA_Window_Open,0,TAG_END);
        pix_x=56;
        pieces_folder="PROGDIR:Pieces/800";
        RestoreBoard();
        SetAttrs(data->win,MUIA_Window_Open,1,TAG_END);
        }
}

static void mChessBoardLarge(struct IClass *cl,Object *obj)
{
if(wbscreen->Width>=1024&&pix_x!=72)
        {
        struct Data *data=(struct Data *)INST_DATA(cl,obj);
        SetAttrs(data->win,MUIA_Window_Open,0,TAG_END);
        pix_x=72;
        pieces_folder="PROGDIR:Pieces/1024";
        RestoreBoard();
        SetAttrs(data->win,MUIA_Window_Open,1,TAG_END);
        }
}

static void mChessBoard(Object *obj,struct MUIP_Chess_Board *msg)
{
char *name;
GetAttr(MUIA_Menuitem_Title,msg->menu,(ULONG*)&name);
LoadBoard(name);
DoMethod(obj,MUIM_Chess_ShowBoard);
}

static void mChessPieces(Object *obj,struct MUIP_Chess_Pieces *msg)
{
char *name;
GetAttr(MUIA_Menuitem_Title,msg->menu,(ULONG*)&name);
LoadPieces(name);
DoMethod(obj,MUIM_Chess_ShowBoard);
}

static void mChessClearFlag(struct MUIP_Chess_ClearFlag *msg)
{
if(msg->flag==AUTOPLAY)
        {
        SetAttrs(find(ID_MENU_Autoplay),MUIA_NoNotify,1,MUIA_Menuitem_Checked,0,TAG_END);
        CLEAR(flags,AUTOPLAY);
        }
}

static void mChessAddMove(struct IClass *cl,Object *obj,struct MUIP_Chess_AddMove *msg)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
Object *lv=msg->side==white?data->lv_white:data->lv_black;
DoMethod(lv,MUIM_NList_InsertSingle,msg->move,MUIV_NList_Insert_Bottom);
DoMethod(lv,MUIM_NList_Jump,MUIV_NList_Jump_Bottom);
}

static void mChessClearList(struct IClass *cl,Object *obj)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
DoMethod(data->lv_white,MUIM_NList_Clear);
DoMethod(data->lv_black,MUIM_NList_Clear);
}

static void mChessPromote(struct IClass *cl,Object *obj)
{
BOOL ok=0;
struct Data *data=(struct Data *)INST_DATA(cl,obj);
SetAttrs(data->win,MUIA_Window_Sleep,1,TAG_END);
SetAttrs(data->promotewin,MUIA_Window_Open,1,TAG_END);
while(!ok)
        {
        ULONG signals,id;
        id=DoMethod(obj,MUIM_Application_NewInput,&signals);
        switch(id)
                {
                case ID_Promote_Queen:
                        promotepiece=0;
                        ok=1;
                        break;
                case ID_Promote_Rook:
                        promotepiece=1;
                        ok=1;
                        break;
                case ID_Promote_Bishop:
                        promotepiece=2;
                        ok=1;
                        break;
                case ID_Promote_Knight:
                        promotepiece=3;
                        ok=1;
                }
        if(signals) signals=Wait(signals);
        }
SetAttrs(data->promotewin,MUIA_Window_Open,0,TAG_END);
SetAttrs(data->win,MUIA_Window_Sleep,0,TAG_END);
}

static void mChessEval(struct IClass *cl,Object *obj)
{
char text[100];
BitBoard *b;
struct Data *data=(struct Data *)INST_DATA(cl,obj);
SetAttrs(data->evalwin,MUIA_Window_Open,1,TAG_END);
phase=PHASE;
GenAtaks();
FindPins(&pinned);
b=board.b[white];
pieces[white]=b[knight]|b[bishop]|b[rook]|b[queen];
b=board.b[black];
pieces[black]=b[knight]|b[bishop]|b[rook]|b[queen];
sprintf(text,getstr(MSG_POSEVAL_FORM1),board.pmaterial[white],board.material[white],ScoreDev(white));
SetAttrs(data->tx_w_mat1,MUIA_Text_Contents,text,TAG_END);
sprintf(text,getstr(MSG_POSEVAL_FORM2),ScoreP(white),ScoreN(white),ScoreB(white));
SetAttrs(data->tx_w_mat2,MUIA_Text_Contents,text,TAG_END);
sprintf(text,getstr(MSG_POSEVAL_FORM3),ScoreR(white),ScoreQ(white),ScoreK(white));
SetAttrs(data->tx_w_mat3,MUIA_Text_Contents,text,TAG_END);
sprintf(text,getstr(MSG_POSEVAL_FORM1),board.pmaterial[black],board.material[black],ScoreDev(black));
SetAttrs(data->tx_b_mat1,MUIA_Text_Contents,text,TAG_END);
sprintf(text,getstr(MSG_POSEVAL_FORM2),ScoreP(black),ScoreN(black),ScoreB(black));
SetAttrs(data->tx_b_mat2,MUIA_Text_Contents,text,TAG_END);
sprintf(text,getstr(MSG_POSEVAL_FORM3),ScoreR(black),ScoreQ(black),ScoreK(black));
SetAttrs(data->tx_b_mat3,MUIA_Text_Contents,text,TAG_END);
sprintf(text,getstr(MSG_POSEVAL_FORM4),(EvaluateDraw()?DRAWSCORE:Evaluate(-INFINITY,INFINITY)));
SetAttrs(data->tx_eval_score,MUIA_Text_Contents,text,TAG_END);
}

static void mChessStats(struct IClass *cl,Object *obj)
{
char text[100];
struct Data *data=(struct Data *)INST_DATA(cl,obj);
sprintf(text,getstr(MSG_STAT_FORM0),NodeCnt+QuiesCnt,(ULONG)((NodeCnt+QuiesCnt)/ElapsedTime));
SetAttrs(data->tx_nodes,MUIA_Text_Contents,text,TAG_END);
sprintf(text,getstr(MSG_STAT_FORM1),GenCnt,(ULONG)(GenCnt/ElapsedTime));
SetAttrs(data->tx_moves,MUIA_Text_Contents,text,TAG_END);
sprintf(text,getstr(MSG_STAT_FORM2),maxposnscore[white],maxposnscore[black]);
SetAttrs(data->tx_score,MUIA_Text_Contents,text,TAG_END);
}

static void mChessEditClear(Object *obj)
{
memset(&board,0,sizeof(board));
DoMethod(obj,MUIM_Chess_ShowBoard);
}

static void mChessEditOk(struct IClass *cl,Object *obj)
{
struct Data *data=(struct Data *)INST_DATA(cl,obj);
SetAttrs(data->editwin,MUIA_Window_Open,0,TAG_END);
DoMethod(obj,MUIM_Chess_ShowBoard);
UpdateFriends();
UpdateCBoard();
UpdateMvboard();
CalcHashKey();
phase=PHASE;
}


static LONG mSetup(Class *cl, Object *obj)
{
  return 0;
}


static LONG mCleanup(Class *cl, Object *obj)
{
  return 0;
}


static ULONG Dispatcher(void)
{
Class *cl = (Class*)REG_A0;
Object *obj = (Object*)REG_A2;
Msg msg = (Msg)REG_A1;
ULONG retval = 0;
switch(msg->MethodID)
        {
        case OM_NEW:
                retval=mNew(cl,obj,(struct opSet *)msg);
                break;
        case OM_DISPOSE:
                retval=mDispose(cl,obj,msg);
                break;
        case MUIM_Setup:
                retval=mSetup(cl, obj);
                break;
        case MUIM_Cleanup:
                retval=mCleanup(cl, obj);
                break;
        case MUIM_Chess_WinOpen:
                mChessWinOpen(cl,obj);
                break;
        case MUIM_Chess_New:
                mChessNewgame(cl,obj);
                break;
        case MUIM_Chess_OpenEPD:
                mChessOpenEPD(cl,obj);
                break;
        case MUIM_Chess_OpenPGN:
                mChessOpenPGN(cl,obj);
                break;
        case MUIM_Chess_SaveEPD:
                mChessSaveEPD(cl,obj);
                break;
        case MUIM_Chess_SavePGN:
                mChessSavePGN(cl,obj);
                break;
        case MUIM_Chess_Autoplay:
                mChessAutoplay((struct MUIP_Chess_Autoplay *)msg);
                break;
        case MUIM_Chess_SwapSides:
                mChessSwapSides(obj);
                break;
        case MUIM_Chess_SwitchSides:
                mChessSwitchSides(obj);
                break;
        case MUIM_Chess_Undo:
                mChessUndo(cl,obj);
                break;
        case MUIM_Chess_Remove:
                mChessRemove(cl,obj);
                break;
        case MUIM_Chess_Supervisor:
                mChessSupervisor((struct MUIP_Chess_Supervisor *)msg);
                break;
        case MUIM_Chess_Post:
                mChessPost(obj,(struct MUIP_Chess_Post *)msg);
                break;
        case MUIM_Chess_BookAdd:
                mChessBookAdd(cl,obj);
                break;
        case MUIM_Chess_BookOn:
                mChessBookOn();
                break;
        case MUIM_Chess_BookOff:
                mChessBookOff();
                break;
        case MUIM_Chess_BookBest:
                mChessBookBest();
                break;
        case MUIM_Chess_BookWorst:
                mChessBookWorst();
                break;
        case MUIM_Chess_BookRandom:
                mChessBookRandom();
                break;
        case MUIM_Chess_Depth:
                mChessDepth((struct MUIP_Chess_Depth *)msg);
                break;
        case MUIM_Chess_Time:
                mChessTime(cl,obj,(struct MUIP_Chess_Time *)msg);
                break;
        case MUIM_Chess_ShowBoard:
                mChessShowBoard(cl,obj,msg);
                break;
        case MUIM_Chess_ShowThinking:
                mChessShowThinking(cl,obj,(struct MUIP_Chess_ShowThinking *)msg);
                break;
        case MUIM_Chess_NullMove:
                mChessNullMove((struct MUIP_Chess_NullMove *)msg);
                break;
        case MUIM_Chess_UseHash:
                mChessUseHash((struct MUIP_Chess_UseHash *)msg);
                break;
        case MUIM_Chess_ReverseBoard:
                mChessReverseBoard(obj,(struct MUIP_Chess_ReverseBoard *)msg);
                break;
        case MUIM_Chess_MyMove:
                mChessMyMove(cl,obj,(struct MUIP_Chess_MyMove *)msg);
                break;
        case MUIM_Chess_Side:
                mChessSide(cl,obj);
                break;
        case MUIM_Chess_BoardSmall:
                mChessBoardSmall(cl,obj);
                break;
        case MUIM_Chess_BoardMedium:
                mChessBoardMedium(cl,obj);
                break;
        case MUIM_Chess_BoardLarge:
                mChessBoardLarge(cl,obj);
                break;
        case MUIM_Chess_Board:
                mChessBoard(obj,(struct MUIP_Chess_Board *)msg);
                break;
        case MUIM_Chess_Pieces:
                mChessPieces(obj,(struct MUIP_Chess_Pieces *)msg);
                break;
        case MUIM_Chess_ClearFlag:
                mChessClearFlag((struct MUIP_Chess_ClearFlag *)msg);
                break;
        case MUIM_Chess_AddMove:
                mChessAddMove(cl,obj,(struct MUIP_Chess_AddMove *)msg);
                break;
        case MUIM_Chess_ClearList:
                mChessClearList(cl,obj);
                break;
        case MUIM_Chess_Promote:
                mChessPromote(cl,obj);
                break;
        case MUIM_Chess_Eval:
                mChessEval(cl,obj);
                break;
        case MUIM_Chess_Stats:
                mChessStats(cl,obj);
                break;
        case MUIM_Chess_EditClear:
                mChessEditClear(obj);
                break;
        case MUIM_Chess_EditOk:
                mChessEditOk(cl,obj);
                break;
        case MUIM_Chess_About:
                mChessAbout(cl,obj);
                break;
        default:
                retval=DoSuperMethodA(cl,obj,msg);
        }
return retval;
}

struct EmulLibEntry MUIChessGate = {TRAP_LIB, 0, (void(*)(void))Dispatcher};

void INIT_6_MUI_Chess_Class(void)
{
if(!(MUI_Chess_Class=MUI_CreateCustomClass(0,MUIC_Application,0,sizeof(struct Data),(APTR)&MUIChessGate))) exit(20);
}

void EXIT_6_MUI_Chess_Class(void)
{
if(MUI_Chess_Class) MUI_DeleteCustomClass(MUI_Chess_Class);
}

