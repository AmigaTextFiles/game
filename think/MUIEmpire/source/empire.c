#include "defines.h"
#include "guidefines.h"
#include "struct.h"
#include "externalprototypes.h"
#include "MUIEmpire_rev.h"
near long __stack = 20000L;
struct Library *MUIMasterBase;
void fail (APTR,char *);

#ifdef _DCC

int brkfunc(void) { return(0); }

int wbmain(struct WBStartup *wb_startup)
{
        extern int main(int argc, char *argv[]);
        return (main(0, NULL));
}

#endif


#ifdef __SASC
int CXBRK(void) { return(0); }
int _CXBRK(void) { return(0); }
void chkabort(void) {}
#endif


static VOID init(VOID)
{
#ifdef _DCC
        onbreak(brkfunc);
#endif

#ifndef _DCC
        if (!(MUIMasterBase = OpenLibrary(MUIMASTER_NAME,MUIMASTER_VMIN)))
                fail(NULL,"Failed to open "MUIMASTER_NAME".");
#endif


#ifndef _DCC
        if (!(UtilityBase = OpenLibrary("utility.library",37)))
                fail(NULL,"Failed to open Utility Library");
#endif
}


#ifndef __SASC
static VOID stccpy(char *dest,char *source,int len)
{
        strncpy(dest,source,len);
        dest[len-1]='\0';
}
#endif


#ifndef MAKE_ID
#define MAKE_ID(a,b,c,d) ((ULONG) (a)<<24 | (ULONG) (b)<<16 | (ULONG) (c)<<8 | (ULONG) (d))
#endif



#define DEBUG FALSE

  
const char  *popitem[] = {
                          "Credits",            
                          "Fuel",
                          "Troops",
                          "Planetary Scanner I",
                          "Machinery", 
                          "Space Mine I", 
                          "Space Mine II",      
                          "Space Mine III",     
                          "Space Mine IV",        
                          "Steel",              
                          "Gold",               
                          "Iron",               
                          "Wool",                        
                          "Grain",              
                          "Uranium",            
                          "Plutonium",          
                          "Textile",            
                          "Rubber",             
                          "Mainframes",         
                          "Spices",
                          "Technology",             
                          "Alcohol",            
                          "Narcotics",          
                          "Refinery",           
                          "HyperGate",          
                          "Plasma Torpedo",      
                          "High Energy Laser",  
                          "Disruptor",          
                          "Torpedo",            
                          "Vaporizer",          
                          "10 Shield Energy",   
                          "50 Shield Energy",   
                          "100 Shield Energy",  
                          "200 Shield Energy",  
                          "400 Shield Energy",  
                          "600 Shield Energy",                                           
                          NULL,};
                          
const char *pages2[] = {"Automatic Navigation","Automatic Trade",NULL,};
const char *pages3[] = {"Planet Information","Fleet Information","Sector Information","Player Information",NULL,};
const char *pages4[] = {"Planet Inventory","Sector Inventory",NULL,};
const char *pages5[] = {"Sector Inventory","Fleet Inventory",NULL,};
const char *contact1[] = {"Patrol Mission","Trade Mission",NULL,};
const char *contact2[] = {"New Orders","Keep Orders","Cycle Orders",NULL,};
char *players[] = { NULL };

  



extern struct Image mapimages1;
extern struct Image mapimages2;
extern struct Image mapimages3;
extern struct Image mapimages4;
extern struct Image mapimages5;
extern struct Image mapimages6;
extern LONG GALAXY;
extern int planetnumber;
extern int playernumber;
extern struct player *currentplayer;
extern struct planet **planetlist;
extern struct sector **SECTOR;
extern struct computerplayer *currentcomputerplayer;
extern struct MsgPort *client;

APTR tx1,tx2,tx3,tx4,tx5,tx6,tx7,tx8,tx9,tx10,tx11,tx12,tx13,tx14; 
APTR tx15,tx16,tx17,tx18,tx19,tx20,tx21,tx22,tx23,tx24,tx25,tx26,tx27;
APTR tx28,tx29,tx30,tx31,tx32;
APTR lv1,lv2,lv3,lv4,lv5,lv6,pcy1,pgr1,pcy2,pgr2;
APTR lv7,lv8,lv9,lv10,lv11,lv12,lv13,lv14,lv15,lv16,lv17,lv18;
APTR str5,str6,str7,str8,str9,str10,str11,str12;
APTR app,sc1,str1,str2,str3,str4,im1,BT_NextPlanet,BT_LastPlanet,BT_NextPlayer;
APTR BT_Hyper,BT_Movement,BT_ApplyTrade,BT_CancelTrade;
APTR WI_Movement, WI_Purchase, WI_PlanetCargo, WI_Player, WI_Mainwindow;
APTR WI_FleetCargo,WI_ShipDesign;
APTR WI_Map,WI_Configuration,WI_Gauge,ra1,ra2,ck1,ck2;
APTR cy2,sl1,sl2,sl3,sl4,sl5,sl6,sl7,sl8,sl9,sl10,sl11,sl12,sl13;
APTR sl14,sl15,sl16,sl17,sl18,sl19,sl20,sl21,sl22,sl30,sl31,sl32,sl33,sl34;
APTR sl35,sl36,sl37,sl38,sl39,sl40,sl41,sl42,sl43,sl44;
APTR strip,pop1,pop2,gauge1,SuperClass;
APTR Hypergroup;
APTR BT_AutoFuel;
APTR BT_Sellship,BT_Showships;
APTR MyObj,reg1,reg2;
APTR BT_Purchase, BT_Quit,BT_LastPlayer;
APTR BT_FleetCargo,BT_Map,BT_Cancel,BT_PlanetCargo;
APTR BT_Done,BT_LoadGame,BT_AddPlayer,BT_RemovePlayer;
APTR BT_ClearCourse;
APTR BT_NextForce,BT_LastForce,BT_MakePurchase,BT_PlotCourse;
APTR BT_NextFleet,BT_LastFleet;
APTR BT_PurchaseShip,BT_ShipDesign,BT_PurchaseDesign;
APTR BT_SectorTransferFle;
APTR BT_SectorTransferPla;
APTR BT_PlanetTransferSec;
APTR BT_FleetTransferSec;
APTR BT_SellGoods;
APTR BT_SendPartial;
APTR BT_SendMessage;
APTR BT_ClearMessage;
APTR BT_JoinFleet,WI_Login,str13,str14,str15,BT_PlayGame,tx33,tx34,vi1;   
APTR BT_SetProduction,BT_ClearProduction,tx35;
APTR WI_Fleet,WI_Sector,WI_Message;
ULONG memory=0;
struct IClass *MyClass;
extern struct Image mapbackground;

/*
 * prototypes
 */
extern int core (void);
extern BOOL insector(int,int,int);
extern int cleanmemory (void);
LONG guiRequest(LONG);
static ULONG MUIM_xxx_CallRedraw(struct IClass *TheClass, Object *TheObject, Msg Message);

__saveds __asm struct temp *consfleet(register __a0 struct Hook *hook,
                                      register __a2 APTR mem_pool,
                                      register __a1 struct force *fleet);
__saveds __asm LONG desfleet(register __a0 struct Hook *hook,
                             register __a2 APTR mem_pool,
                             register __a1 struct temp *fleet);
__saveds __asm LONG dispfleet(register __a0 struct Hook *hook,
                             register __a2 char **array,
                             register __a1 struct temp *fleet);

__saveds __asm struct tagchar *constag  (register __a0 struct Hook *hook,
                                        register __a2 APTR mem_pool,
                                        register __a1 struct tagchar *tag);
__saveds __asm LONG destag  (register __a0 struct Hook *hook,
                             register __a2 APTR mem_pool,
                             register __a1 struct tagchar *tag);
__saveds __asm LONG disptag (register __a0 struct Hook *hook,
                             register __a2 char **array,
                             register __a1 struct tagchar *tag);
__saveds __asm LONG disppurch (register __a0 struct Hook *hook,
                               register __a2 char **array,
                               register __a1 struct tagchar *tag);
__saveds __asm LONG dispship(register __a0 struct Hook *hook, 
                            register __a2 char **array,
                            register __a1 struct shiptag *ship);
__saveds __asm struct shiptag *consship(register __a0 struct Hook *hook,
                                        register __a2 APTR mem_pool,
                                        register __a1 struct ship *ship);
__saveds __asm LONG desship (register __a0 struct Hook *hook,
                             register __a2 APTR mem_pool,
                             register __a1 struct shiptag *ship);




static struct NewMenu MenuData1[] = {
  {NM_TITLE, "Project"        , 0 , 0 , 0      ,(APTR)0},
  {NM_ITEM,  "About"          ,"?", 0 , 0      ,(APTR)ID_ABOUT},
  {NM_ITEM,  NM_BARLABEL      , 0 , 0 , 0      ,(APTR)0},
  {NM_ITEM,  "Save Game"      ,"S", 0 , 0      ,(APTR)MEN_SAVEGAME},
  {NM_ITEM,  "Save Game as.." , 0 , 0 , 0      ,(APTR)MEN_SAVEGAMEAS},
  {NM_ITEM,  NM_BARLABEL      , 0 , 0 , 0      ,(APTR)0},
  {NM_ITEM,  "Quit"           ,"Q", 0 , 0      ,(APTR)ID_QUIT},
  {NM_TITLE, "Windows"        , 0 , 0 , 0      ,(APTR)0},
  {NM_ITEM,  "Fleet Window"   , 0 , 0 , 0      ,(APTR)ID_FLEETWINDOW},
  {NM_ITEM,  "Sector Window"  , 0 , 0 , 0      ,(APTR)ID_SECTORWINDOW},
  {NM_ITEM,  "Message window" , 0 , 0 , 0      ,(APTR)ID_MESSAGEWINDOW},
  /*
  {NM_TITLE, "Settings"       , 0 , 0 , 0      ,(APTR)0},
  {NM_ITEM,  "Show Ships"     , 0 , 0 , 0      ,(APTR)MEN_SHOWSHIPS},   
  */
  {NM_END,    NULL            , 0 , 0 , 0      ,(APTR)0},
  };
  
  
static struct Hook fleet_list_dsphook = {
        {NULL, NULL},
        (void *)dispfleet,
        NULL, NULL
};
static struct Hook fleet_list_deshook = {
        {NULL, NULL},
        (void *)desfleet,
        NULL, NULL
};
static struct Hook fleet_list_conhook = {
        {NULL, NULL},
        (void *)consfleet,
        NULL, NULL
};
static struct Hook ship_list_dsphook = {
        {NULL, NULL},
        (void *)dispship,
        NULL, NULL
};
static struct Hook ship_list_deshook = {
        {NULL, NULL},
        (void *)desship,
        NULL, NULL
};
static struct Hook ship_list_conhook = {
        {NULL, NULL},
        (void *)consship,
        NULL, NULL
};

static struct Hook fleet_list_dsptag = {
        {NULL, NULL},
        (void *)disptag,
        NULL, NULL
};

static struct Hook fleet_list_dsppurch = {
        {NULL, NULL},
        (void *)disppurch,
        NULL, NULL
};

static struct Hook fleet_list_destag = {
        {NULL, NULL},
        (void *)destag,
        NULL, NULL
};
static struct Hook fleet_list_contag = {
        {NULL, NULL},
        (void *)constag,
        NULL, NULL
};

struct MyData {
   LONG dummy;
};



SAVEDS ULONG mAskMinMax(struct IClass *cl,Object *obj,struct MUIP_AskMinMax *msg){
        DoSuperMethodA(cl,obj,msg);
        msg->MinMaxInfo->MinWidth  += (GALAXY*30);
        msg->MinMaxInfo->DefWidth  += (GALAXY*30);
        msg->MinMaxInfo->MaxWidth  += (GALAXY*30);
        msg->MinMaxInfo->MinHeight += (GALAXY*30);
        msg->MinMaxInfo->DefHeight += (GALAXY*30);
        msg->MinMaxInfo->MaxHeight += (GALAXY*30);
        return(0);
}
SAVEDS ULONG mDraw(struct IClass *cl,Object *obj,struct MUIP_Draw *msg){
        int x,n,m,y,z;
        BOOL enemy=FALSE,friendly=FALSE;
        struct force *fleet;
        struct TagItem *tag;
        
        DoSuperMethodA(cl,obj,msg);

        if (!(msg->flags & MADF_DRAWOBJECT)) return(0);

        SetAPen(_rp(obj),_dri(obj)->dri_Pens[FILLPEN]);
   
        y = _mtop(obj);
        z = _mleft(obj);
        
        DrawImage(_rp(obj),&mapbackground,z,y);  
        
        for (n=1;n<=GALAXY;n++) {
           Move(_rp(obj),z+n*30,y);
           Draw(_rp(obj),z+n*30,y+GALAXY*30);
        }
        
        for (n=1;n<=GALAXY;n++) {
           Move(_rp(obj),z,y+n*30);
           Draw(_rp(obj),z+GALAXY*30,y+n*30);
        }

        SetAPen(_rp(obj),_dri(obj)->dri_Pens[TEXTPEN]); 
        for (x = 0;x<planetnumber;x++) {
          m = planetlist[0][x].x;
          n = planetlist[0][x].y;
          
          if (currentplayer->id == planetlist[0][x].id) DrawImage(_rp(obj),&mapimages1,z+(m*30),y+(n*30));
          /* should be set to currentplayer->id */
          else if (planetlist[currentplayer->id][x].id == 0)
               DrawImage(_rp(obj),&mapimages5,z+(m*30),y+(n*30));
               else DrawImage(_rp(obj),&mapimages6,z+(m*30),y+(n*30));
                          
          PrintIText(_rp(obj),&planetlist[currentplayer->id][x].textattribute,z+(m*30),y+(n*30));        
        }
        
        for (n=0;n<GALAXY;n++) {
          for (m=0;m<GALAXY;m++) {
          if (insector(currentplayer->id,n,m)) {
            tag = SECTOR[n][m].TAGITEM;
            if (NextTagItem(&tag))   
              DrawImage(_rp(obj),&mapimages4,z+(n*30),y+(m*30));
            fleet = SECTOR[n][m].FLEET;
            friendly = enemy = FALSE;
            while (fleet) {
              if (fleet->id == currentplayer->id) friendly = TRUE;
              else enemy = TRUE;
              fleet = fleet->sectornext;
            }
            if (friendly) DrawImage(_rp(obj),&mapimages2,z+(n*30),y+(m*30));
            if (enemy)    DrawImage(_rp(obj),&mapimages3,z+(n*30),y+(m*30));
          }
        }
      }
 
   return(0);
}

SAVEDS ULONG mSetup(struct IClass *cl,Object *obj,struct MUIP_HandleInput *msg)
{
        if (!(DoSuperMethodA(cl,obj,msg)))
                return(FALSE);

        MUI_RequestIDCMP(obj,IDCMP_MOUSEBUTTONS|IDCMP_RAWKEY);

        return(TRUE);
}


SAVEDS ULONG mCleanup(struct IClass *cl,Object *obj,struct MUIP_HandleInput *msg)
{
        MUI_RejectIDCMP(obj,IDCMP_MOUSEBUTTONS|IDCMP_RAWKEY);
        return(DoSuperMethodA(cl,obj,msg));
}



static ULONG mHandleInput(
        struct IClass *cl,
        Object *obj,
        struct MUIP_HandleInput *msg)
{
#define _between(a,x,b) ((x)>=(a) && (x)<=(b))
#define _isinobject(x,y) (_between(_mleft(obj),(x),_mright (obj)) && _between(_mtop(obj) ,(y),_mbottom(obj)))
  int n,m,a,b;
     
  struct Data *data = INST_DATA(cl,obj);
     
  if (msg->imsg)
     {
     switch (msg->imsg->Class)
       {
       case IDCMP_MOUSEBUTTONS:
         {
         if (msg->imsg->Code==SELECTDOWN)
           {
           if (_isinobject(msg->imsg->MouseX,msg->imsg->MouseY))
             {
             data->x = msg->imsg->MouseX;
             data->y = msg->imsg->MouseY;
             guiget(client,INT,SC1,MUIA_Virtgroup_Top,&a);
             guiget(client,INT,SC1,MUIA_Virtgroup_Left,&b);
             n = (data->x)+b-16;
             m = (data->y)+a-16;
             if (n > 0) n = n/30;
             if (m > 0) m = m/30;
             if ((m <GALAXY && m >= 0) && (n <GALAXY && n >= 0)) {
               guiset(client,INT,SL41,MUIA_Slider_Level,n);
               guiset(client,INT,SL42,MUIA_Slider_Level,m);
               if (SECTOR[n][m].PLANET) {
                 if (currentplayer) {
                    currentplayer->currentplanet = &planetlist[currentplayer->id][SECTOR[n][m].PLANET->ID];
                    DoMethod(app,MUIM_Application_ReturnID,ID_SETPLANET);
                 }
                 /*
                 guiset(client,INT,LV1,MUIA_List_Active,SECTOR[n][m].PLANET->ID);
                 /* to planet list */
                 guiset(client,INT,LV3,MUIA_List_Active,SECTOR[n][m].PLANET->ID);
                 */
               }
             }
           }                           
         }
         else MUI_RejectIDCMP(obj,IDCMP_MOUSEMOVE);
       }
       break;        
    }
    /* passing MUIM_HandleInput to the super class is only necessary
    if you rely on area class input handling (MUIA_InputMode). */
  }
  return(0);
}


SAVEDS ASM ULONG MyDispatcher(REG(a0) struct IClass *cl,REG(a2) Object *obj,REG(a1) Msg msg)
{
        switch (msg->MethodID) {
                case MUIM_AskMinMax: return(mAskMinMax(cl,obj,(APTR)msg));
                case MUIM_Draw     : return(mDraw     (cl,obj,(APTR)msg));
                case MUIM_HandleInput: return(mHandleInput(cl,obj,(APTR)msg));
                case MUIM_Setup      : return(mSetup      (cl,obj,(APTR)msg));
                case MUIM_Cleanup    : return(mCleanup    (cl,obj,(APTR)msg));
                case MUIM_MyObjRedraw: return(MUIM_xxx_CallRedraw(cl, obj,(APTR) msg));
        }
        return(DoSuperMethodA(cl,obj,msg));
}




main(int argc, char *argv[]) {

     
  init();
  
  if (!(SuperClass=MUI_GetClass(MUIC_Area)))
       fail(NULL,"Superclass for the new class not found.");
  /* create the new class */
  if (!(MyClass = MakeClass(NULL,NULL,SuperClass,sizeof(struct MyData),0)))
    {
    MUI_FreeClass(SuperClass);
    fail(NULL,"Failed to create class.");
    }
  /* set the dispatcher for the new class */
  MyClass->cl_Dispatcher.h_Entry    = (APTR)MyDispatcher;
  MyClass->cl_Dispatcher.h_SubEntry = NULL;
  MyClass->cl_Dispatcher.h_Data     = NULL;
  
  srand48(time(NULL));
  
  

  app = ApplicationObject,
     MUIA_Application_Title,          "MUIEmpire",
     MUIA_Application_Version,        VERSTAG,
     MUIA_Application_Copyright,      "© 1995, by Karl Bellve",
     MUIA_Application_Author,         "Karl Bellve",
     MUIA_Application_Description,    "The unlimited player, unlimited planet, unlimited ship type conquest game",
     MUIA_Application_Base,           "EMPIRE",
      SubWindow, WI_Fleet = WindowObject,
         MUIA_Window_Title, "Empire Fleet Window",
         MUIA_Window_ID, MAKE_ID('F','L','E','E'),
         WindowContents, VGroup,
             Child, VGroup,
                 Child, lv6 = ListviewObject, MUIA_Listview_Input, TRUE, MUIA_Listview_MultiSelect, MUIV_Listview_MultiSelect_Default, MUIA_Listview_List, ListObject, MUIA_List_Title, TRUE,InputListFrame,
                     MUIA_List_Format,"COL=0 MINWIDTH=2,COL=1 MINWIDTH=2,COL=2 MINWIDTH=20,COL=4 MINWIDTH=8,COL=5 MINWIDTH=8,COL=6 MINWIDTH=8,COL=7 MINWIDTH=8,COL=8 MINWIDTH=8,COL=9 MINWIDTH=8,COL=10 MINWIDTH=5,COL=11 MINWIDTH=5, COL=12 MINWIDTH=20",
                     MUIA_List_ConstructHook,&fleet_list_conhook,
                     MUIA_List_DestructHook,&fleet_list_deshook,
                     MUIA_List_DisplayHook,&fleet_list_dsphook,End,
                 End,
                 Child, BT_JoinFleet = KeyButton("Join Fleets",'j'),
             End,
         End,
      End,
         

    SubWindow, WI_Sector = WindowObject,
        MUIA_Window_Title, "Sector Information",
        MUIA_Window_ID, MAKE_ID('S','E','C','T'),
        WindowContents, VGroup,
           Child, HGroup,
             Child, VGroup, MUIA_Weight, 200,                                
               Child, ColGroup (2), 
                  Child, Label("X coor:"),
                  Child, sl41 = SliderObject, MUIA_Slider_Min, 0, MUIA_Slider_Max, 99999, MUIA_Slider_Level, 0, End,
                  Child, Label("Y coor:"),
                  Child, sl42 = SliderObject, MUIA_Slider_Min, 0, MUIA_Slider_Max, 99999, MUIA_Slider_Level, 0, End,
               End,
               Child, lv16 = ListviewObject, MUIA_Listview_Input, TRUE, MUIA_Listview_List, ListObject, MUIA_List_Title, TRUE,InputListFrame,
                   MUIA_List_Format,"COL=2 MINWIDTH=30,COL=3 MINWIDTH=30,COL=4 MINWIDTH=20,COL=5 MINWIDTH=20",
                   MUIA_List_ConstructHook,&fleet_list_conhook,
                   MUIA_List_DestructHook,&fleet_list_deshook,
                   MUIA_List_DisplayHook,&fleet_list_dsphook,End,
               End,
             End,
             Child, lv17=ListviewObject, MUIA_Weight, 50,MUIA_Listview_Input, FALSE, MUIA_Listview_List, ListObject, MUIA_List_Title, TRUE,InputListFrame,
               MUIA_List_Format,"P=/33c MINWIDTH=30,MINWIDTH=70",
               MUIA_List_ConstructHook,&fleet_list_contag,
               MUIA_List_DestructHook,&fleet_list_destag,
               MUIA_List_DisplayHook,&fleet_list_dsptag,End,
             End,              
           End,   
        End,
      End,
     
     SubWindow, WI_Message = WindowObject,
        MUIA_Window_Title, "Empire Message Window",
        MUIA_Window_ID, MAKE_ID('M','E','S','S'),
        WindowContents, HGroup,
             Child, HGroup,                                   
               Child, VGroup, MUIA_Weight, 0,
                 Child, ColGroup(2), GroupFrameT("Player"),  
                   Child, Label("Name:"      ),
                   Child, tx13 = TextObject, MUIA_Text_PreParse, "\33c", MUIA_Text_Contents, NULL, End,
                   Child, Label("Empire:"      ),
                   Child, str5 = StringObject, StringFrame, MUIA_String_MaxLen,20,End,
                   Child, Label("Turn:"),
                   Child, tx22 = TextObject, MUIA_Text_PreParse, "\33c", MUIA_Text_Contents, NULL, End,                             
                 End, 
                 Child, HGroup,
                   Child, BT_SendMessage = KeyButton("Send Message",'m'),                     
                   Child, BT_ClearMessage = KeyButton("Clear Messages",'c'),                     
                 End, 
                 Child, str7 = StringObject, StringFrame, MUIA_String_MaxLen,100,End,
                 Child, lv18 = ListviewObject,MUIA_Listview_MultiSelect, 
                    MUIV_Listview_MultiSelect_Default, 
                    MUIA_List_Title, "Enemy Empires",InputListFrame,                    
                    MUIA_Listview_Input, TRUE, MUIA_Listview_List, 
                    ListObject,
                    MUIA_List_Format,"COL 1",
                    MUIA_List_ConstructHook,&fleet_list_contag,
                    MUIA_List_DestructHook,&fleet_list_destag,
                    MUIA_List_DisplayHook,&fleet_list_dsptag,End,
                 End,
               End,
               Child, lv15 = ListviewObject, MUIA_Weight, 150,MUIA_Listview_Input, FALSE, MUIA_Listview_List, ListObject, MUIA_List_Title, "Game Messages",InputListFrame, 
                 MUIA_List_ConstructHook,MUIV_List_ConstructHook_String,
                 MUIA_List_DestructHook,MUIV_List_DestructHook_String,End,
               End,    
             End,
          End,
     End, 

     SubWindow, WI_Mainwindow = WindowObject,
        MUIA_Window_Title, "Empire Control Window",
        MUIA_Window_ID, MAKE_ID('C','O','N','T'),
        MUIA_Window_Menustrip, strip = MUI_MakeObject(MUIO_MenustripNM,MenuData1,0),
        WindowContents, HGroup,
              Child, HGroup,
                 Child, HGroup,
                   Child, sc1 = ScrollgroupObject, MUIA_HorizWeight, 200,MUIA_Scrollgroup_Contents, vi1 = VGroupV, VirtualFrame,
                       Child, MyObj = NewObject(MyClass,NULL,
                                        MUIA_Background, MUII_BACKGROUND,
                                        TAG_DONE), 
                   End,
                 End,                                                       
                 Child, VGroup, MUIA_HorizWeight, 25,
                    Child, VSpace(0),
                    Child, VGroup, GroupFrameT("Current Planet"),
                       Child, HGroup,
                          Child, BT_LastPlanet = KeyButton("Last",'l'),
                          Child, BT_NextPlanet = KeyButton("Next",'n'), 
                       End,
                       Child, ColGroup(2),
                          Child, Label("Name:"      ),
                          Child, str3 = StringObject, StringFrame, MUIA_String_MaxLen,20,End,
                          Child, Label("Empire:"     ),
                          Child, tx2 = TextObject,MUIA_Text_PreParse, "\33c", MUIA_Text_Contents, "0", End,
                          Child, Label("Population:"),  
                          Child, tx3 = TextObject,MUIA_Text_PreParse, "\33c", MUIA_Text_Contents, "0", End,
                          Child, Label("Technology:"),
                          Child, tx4 = TextObject,MUIA_Text_PreParse, "\33c", MUIA_Text_Contents, "0", End,
                          Child, Label("Fuel:"),
                          Child, tx5 = TextObject,MUIA_Text_PreParse, "\33c", MUIA_Text_Contents, "0", End,
                          Child, Label("Production:"),
                          Child, tx35 = TextObject,MUIA_Text_PreParse, "\33c", MUIA_Text_Contents, "None", End,
                          Child, Label("Tax Rate:"  ),
                          Child, sl32 = SliderObject, MUIA_Slider_Min, 0, MUIA_Slider_Max, 100, MUIA_Slider_Level, 10, End,
                       End,
                    End,
                    Child, ColGroup(2),
                       Child, BT_Purchase = KeyButton("Purchasing",'p'),
                       Child, BT_Movement = KeyButton("Fleet Control",  'f'), 
                       Child, BT_PlanetCargo = KeyButton("Inventory",'i'), 
                       Child, BT_NextPlayer = SimpleButton("Done"), 
                    End,
                    Child, VSpace(0),
                 End,
              End,
          End,
          End,      
     End,
    
    SubWindow, WI_Gauge = WindowObject,
        MUIA_Window_Title, "Computer is thinking ...",
        MUIA_Window_ID, MAKE_ID('C','I','T','H'),
        WindowContents, VGroup, GroupSpacing(1),
            Child, VGroup,
              Child, gauge1 = GaugeObject, GaugeFrame, MUIA_FixWidth, 250, MUIA_Gauge_Horiz,TRUE, MUIA_Gauge_InfoText,"    ",End,
              Child, ScaleObject, End,
            End,
          End,         
        End,
/*
    SubWindow, WI_Login = WindowObject,
        MUIA_Window_Title, "Empire Login",
        MUIA_Window_ID, MAKE_ID('L','O','G','N'),
        WindowContents, VGroup,
              Child, VGroup,
                 Child, ColGroup (2), GroupFrame,
                    Child, Label("Name:"),
                    Child, str13 = StringObject, StringFrame, MUIA_String_MaxLen, 30,End,             
                    Child, Label("Password:"),
                    Child, str14 = StringObject, StringFrame, MUIA_String_Secret,MUIA_String_MaxLen, 30,End,             
                    Child, Label("Game:"),
                    Child, str15 = StringObject, StringFrame, MUIA_String_MaxLen, 30,End,                        
                 End,
                 Child, BT_PlayGame = KeyButton("Play Game",'p'),
              End,   
           End,         
        End,
*/
     SubWindow, WI_PlanetCargo = WindowObject,
        MUIA_Window_Title, "Cargo Operations",
        MUIA_Window_ID, MAKE_ID('P','L','C','A'),
        WindowContents, VGroup,           
              Child, reg2 = RegisterGroup(pages4), 
                 Child, VGroup,
                   Child, VGroup,
                     Child, lv8 = ListviewObject, MUIA_Listview_Input, TRUE, MUIA_Listview_List, ListObject, MUIA_List_Title, TRUE,InputListFrame,
                         MUIA_List_Format,"P=/33c MINWIDTH=30,MINWIDTH=70",
                         MUIA_List_ConstructHook,&fleet_list_contag,
                         MUIA_List_DestructHook,&fleet_list_destag,
                         MUIA_List_DisplayHook,&fleet_list_dsptag,
                         End,
                     End,
                   End,  
                   Child, VGroup,
                     Child, BT_PlanetTransferSec = KeyButton("Transfer to Sector",'t'),
                     Child, BT_SellGoods         = KeyButton("Convert to Credits",'c'),
                     Child, Hypergroup = VGroup, GroupFrame,
                       Child, BT_Hyper = KeyButton("Hyper Transfer",'h'),                     
                       Child, ColGroup (2), GroupFrameT("To Sector"),
                       Child, Label("X coor:"),
                       Child, sl43 = SliderObject, MUIA_Slider_Min, 0, MUIA_Slider_Max, 99999, MUIA_Slider_Level, 0, End,
                       Child, Label("Y coor:"),
                       Child, sl44 = SliderObject, MUIA_Slider_Min, 0, MUIA_Slider_Max, 99999, MUIA_Slider_Level, 0, End,
                     End,
                   End,
                 End,
              End,  
                 Child, VGroup,
                   Child, VGroup,
                     Child, lv7 = ListviewObject, MUIA_Listview_Input, TRUE, MUIA_Listview_List, ListObject, MUIA_List_Title, TRUE,InputListFrame,
                         MUIA_List_Format,"P=/33c MINWIDTH=30,MINWIDTH=70",
                         MUIA_List_ConstructHook,&fleet_list_contag,
                         MUIA_List_DestructHook,&fleet_list_destag,
                         MUIA_List_DisplayHook,&fleet_list_dsptag,
                     End,
                   End,
                   Child, VGroup, 
                     Child, BT_SectorTransferPla = KeyButton("Transfer to Planet",'t'), 
                   End,               
                 End,    
                End,    
              End,
 
            Child, ColGroup(2), GroupFrame,            
                Child, Label("Quantity:"),
                Child, sl33 = SliderObject,  MUIA_Slider_Min, 0, MUIA_Slider_Max, 99999, End,
              End,
          End,
        End,
     
     SubWindow, WI_FleetCargo = WindowObject,
        MUIA_Window_Title, "Cargo Operations",
        MUIA_Window_ID, MAKE_ID('F','L','C','A'),
        WindowContents, VGroup,           
              Child, reg2 = RegisterGroup(pages5),    
                 Child, VGroup,
                   Child, VGroup,
                     Child, lv9 = ListviewObject, MUIA_Listview_Input, TRUE, MUIA_Listview_List, ListObject, MUIA_List_Title, TRUE,InputListFrame,
                         MUIA_List_Format,"P=/33c MINWIDTH=30,MINWIDTH=70",
                         MUIA_List_ConstructHook,&fleet_list_contag,
                         MUIA_List_DestructHook,&fleet_list_destag,
                         MUIA_List_DisplayHook,&fleet_list_dsptag,
                     End,
                   End,
                   Child, HGroup, 
                     Child, BT_SectorTransferFle = KeyButton("Transfer to Fleet",'t'),
                  End,
                 End,  
                 End,    
                 Child, VGroup,
                   Child, VGroup,
                     Child, lv10 = ListviewObject, MUIA_Listview_Input, TRUE, MUIA_Listview_List, ListObject, MUIA_List_Title, TRUE,InputListFrame,
                         MUIA_List_Format,"P=/33c MINWIDTH=30,MINWIDTH=70",
                         MUIA_List_ConstructHook,&fleet_list_contag,
                         MUIA_List_DestructHook,&fleet_list_destag,
                         MUIA_List_DisplayHook,&fleet_list_dsptag,
                     End,
                   End,
                   Child, HGroup, 
                     Child, BT_FleetTransferSec = KeyButton("Transfer to Sector",'t'),
                   End,
                 End,
              End,

            End,
            Child, ColGroup(2), GroupFrame,            
                Child, Label("Quantity:"),
                Child, sl34 = SliderObject,  MUIA_Slider_Min, 0, MUIA_Slider_Max, 99999, End,
              End,
          End,
        End,   
     SubWindow, WI_Configuration = WindowObject,
        MUIA_Window_Title, "Configuration",
        MUIA_Window_ID, MAKE_ID('C','O','N','F'),
        WindowContents, VGroup,
           Child, ColGroup(2),
             Child, Label("Planets:"),
             Child, str6 = StringObject, StringFrame, MUIA_String_Accept,"0123456789",MUIA_String_Integer, 40,MUIA_String_MaxLen,10,End,          
           End,
           Child, VGroup, GroupFrameT("Players"),
             Child, HSpace(0),
             Child, lv2 = ListviewObject,MUIA_Listview_Input, TRUE, MUIA_Listview_List, ListObject, InputListFrame, 
                 MUIA_List_ConstructHook,MUIV_List_ConstructHook_String,
                 MUIA_List_DestructHook,MUIV_List_DestructHook_String,
               End,
             End,
             Child, ColGroup(2), 
               Child, Label2("Name:"),
               Child, str1 = StringObject, StringFrame, MUIA_String_MaxLen,20,End,
             End,
             Child, VSpace(0),
             Child, BT_AddPlayer    = KeyButton("Add Player",'a'),
             Child, BT_RemovePlayer = KeyButton("Remove Player",'r'),
             Child, BT_LoadGame     = KeyButton("Load Game",'l'),
             Child, VSpace(0),
           End,
           Child, HGroup, MUIA_Group_SameSize, TRUE,
             Child, BT_Done   = KeyButton("Done",'d'),
             Child, BT_Cancel = KeyButton("Cancel",'>'),
           End,
        End,
     End,
     
     SubWindow, WI_Purchase = WindowObject,
        MUIA_Window_Title, "Purchasing",
        MUIA_Window_ID, MAKE_ID('P','U','R','C'),
        WindowContents, HGroup,
            Child, VGroup,GroupFrame, MUIA_Weight, 150,
              Child, lv11 = ListviewObject,MUIA_Listview_Input, TRUE, MUIA_Listview_List, ListObject, MUIA_List_Title, TRUE,InputListFrame,
                         MUIA_List_Format,",,,,,,",
                         MUIA_List_ConstructHook,&ship_list_conhook,
                         MUIA_List_DestructHook,&ship_list_deshook,
                         MUIA_List_DisplayHook,&ship_list_dsphook,
                 End,
              End,
              Child, ColGroup(2), GroupFrame,            
                   Child, Label("Name:"      ),
                   Child, str8 = StringObject, StringFrame, MUIA_String_MaxLen,30,End,                           
                   Child, Label("Quantity:"),
                   Child, sl35 = SliderObject,  MUIA_Slider_Min, 0, MUIA_Slider_Max, 99999, End,
              End,  
              Child, HGroup,  
                Child, BT_PurchaseShip    = KeyButton("Purchase Ship",'s'),
                Child, BT_ShipDesign      = KeyButton("Design Ship",'d'),
                Child, BT_SetProduction   = KeyButton("Production",'r'),
                Child, BT_ClearProduction = KeyButton("Clear Production",'c'),
              End,
            End,
            Child, VGroup,GroupFrame, MUIA_Weight, 75, 
              Child, lv4 = ListviewObject, MUIA_Listview_Input, TRUE, MUIA_Listview_List, ListObject, MUIA_List_Title, TRUE,InputListFrame,
                         MUIA_List_Format,"MINWIDTH=30,MINWIDTH=70",
                         MUIA_List_ConstructHook,&fleet_list_contag,
                         MUIA_List_DestructHook,&fleet_list_destag,
                         MUIA_List_DisplayHook,&fleet_list_dsppurch,End,
              End,
              Child, ColGroup(2), GroupFrame,            
                 Child, Label("Quantity:"),
                 Child, sl1 = SliderObject,  MUIA_Slider_Min, 0, MUIA_Slider_Max, 99999, End,
              End,
              Child, HGroup, MUIA_Group_SameSize, TRUE,
                Child, BT_MakePurchase = KeyButton("Purchase Item",'p'),
              End,
            End,        
        End,     
     End,

     SubWindow, WI_Movement = WindowObject,
        MUIA_Window_Title, "Ship Movement",
        MUIA_Window_ID, MAKE_ID('M','O','V','E'),
        WindowContents, VGroup,
          Child, HGroup,
            Child, VGroup,
              Child, ColGroup (2),
                Child, Label("From Sector:"),
                Child, tx25 = TextObject, MUIA_Text_PreParse, "\33c", MUIA_Text_Contents, "                               ", End,             
                Child, Label("To Sector:"),
                Child, tx26 = TextObject, MUIA_Text_PreParse, "\33c", MUIA_Text_Contents, "                               ", End,             
                Child, Label("Distance:"),
                Child, tx27 = TextObject, MUIA_Text_PreParse, "\33c", MUIA_Text_Contents, "0", End,             
                Child, Label("Fuel Required:"),
                Child, tx28 = TextObject, MUIA_Text_PreParse, "\33c", MUIA_Text_Contents, "0", End,             
              End,
              Child, VGroup, GroupFrameT("Current Fleet"),
                Child, BT_Showships = TextObject, MUIA_Text_PreParse, "\33c",MUIA_Frame, MUIV_Frame_Button, MUIA_InputMode, MUIV_InputMode_Toggle,MUIA_Text_Contents, "Show Ships", End,             
                Child, lv12 = ListviewObject, MUIA_Listview_MultiSelect, MUIV_Listview_MultiSelect_Default,MUIA_Listview_Input, TRUE, MUIA_Listview_List, ListObject, MUIA_List_Title, TRUE,InputListFrame,
                    MUIA_List_Format,"COL=1",
                    MUIA_List_ConstructHook,&fleet_list_contag,
                    MUIA_List_DestructHook,&fleet_list_destag,
                    MUIA_List_DisplayHook,&fleet_list_dsptag,End,
                End,
              End, 
            End,
            Child, VGroup,
              Child, pcy2 = Cycle(pages2),
              Child, pgr2 = PageGroup,
                Child, VGroup, GroupFrame,
                  Child, ColGroup (2), GroupFrameT("To Sector"),
                    Child, Label("X coor:"),
                    Child, sl17 = SliderObject, MUIA_Slider_Min, 0, MUIA_Slider_Max, 9999, MUIA_Slider_Level, 0, End,
                    Child, Label("Y coor:"),
                    Child, sl18 = SliderObject, MUIA_Slider_Min, 0, MUIA_Slider_Max, 9999, MUIA_Slider_Level, 0, End,
                  End,
                  Child, lv3 = ListviewObject, MUIA_Frame,MUIV_Frame_InputList, MUIA_Listview_Input, TRUE, MUIA_Listview_List, ListObject, InputListFrame, 
                    MUIA_List_ConstructHook,MUIV_List_ConstructHook_String,
                    MUIA_List_DestructHook,MUIV_List_DestructHook_String, End,             
                  End,
                  Child, BT_PlotCourse = SimpleButton("Plot Course"),
                End,
                Child, VGroup, GroupFrame,
                  Child, ColGroup (2),
                    Child, tx33 = TextObject, MUIA_Text_PreParse, "\33c", MUIA_Text_Contents, "Here:", End,             
                    Child, pop1 = PoplistObject,MUIA_Popstring_String, str11 = String(0,30), MUIA_Popstring_Button, PopButton(MUII_PopUp),MUIA_Poplist_Array,popitem, End,
                    Child, Label("Limit:"),
                    Child, str9 = StringObject, StringFrame, MUIA_String_Accept,"0123456789",MUIA_String_Integer, 1000,MUIA_String_MaxLen,10,End,          
                  End,
                  Child, ColGroup (2), GroupFrame, 
                    Child, tx34 = TextObject, MUIA_Text_PreParse, "\33c", MUIA_Text_Contents, "There:", End,             
                    Child, pop2 = PoplistObject,MUIA_Popstring_String, str12 = String(0,30), MUIA_Popstring_Button, PopButton(MUII_PopUp),MUIA_Poplist_Array,popitem, End,                 
                    Child, Label("Limit:"),
                    Child, str10 = StringObject, StringFrame, MUIA_String_Accept,"0123456789",MUIA_String_Integer, 1000,MUIA_String_MaxLen,10,End,          
                  End,
                  Child, HGroup, MUIA_Group_SameSize, TRUE,
                    Child, BT_ApplyTrade   = KeyButton("Apply Orders" ,'A'),
                    Child, BT_CancelTrade  = KeyButton("Cancel Orders",'C'),
                  End,
                End,
              End,    
            End,
          End,
          Child, HGroup,
            Child, BT_LastForce   = KeyButton("Last Force"  ,'l'),
            Child, BT_NextForce   = KeyButton("Next Force"  ,'n'), 
            Child, BT_FleetCargo  = KeyButton("Freight"     ,'r'),
            Child, BT_AutoFuel    = KeyButton("Fuel Fleet"  ,'g'), 
            Child, BT_ClearCourse = KeyButton("Clear Course",'c'), 
            Child, BT_SendPartial = KeyButton("New Fleet"   ,'f'),
            Child, BT_Sellship    = KeyButton("Sell Ship"   ,'s'),
          End,
      End,
   End,

   SubWindow, WI_ShipDesign = WindowObject,
        MUIA_Window_Title, "Ship Design",
        MUIA_Window_ID, MAKE_ID('S','H','I','P'),
        WindowContents, VGroup,
            Child, ColGroup(2), GroupFrame,            
                 Child, Label2("Ship Class:"),
                 Child, str4 = StringObject, StringFrame, MUIA_String_MaxLen,20,MUIA_String_Contents, "New Ship Class",End,
                 Child, Label("Offense:"),
                 Child, sl36 = SliderObject,  MUIA_Slider_Min, 1, MUIA_Slider_Max, 100, End,
                 Child, Label("Defense:"),
                 Child, sl37 = SliderObject,  MUIA_Slider_Min, 1, MUIA_Slider_Max, 100, End,
                 Child, Label("Cargo:"),
                 Child, sl40 = SliderObject,  MUIA_Slider_Min, 1, MUIA_Slider_Max, 100, End,
                 Child, Label("Speed:"),
                 Child, sl38 = SliderObject,  MUIA_Slider_Min, 1, MUIA_Slider_Max, 10, End,
                 Child, Label("Fuel/Sector:"),
                 Child, sl39 = SliderObject,  MUIA_Slider_Min, 1, MUIA_Slider_Max, 10, End,
                 Child, Label ("Production Cost:"),
                 Child, tx29 = TextObject, MUIA_Text_PreParse, "\33c", MUIA_Text_Contents, "0", End,             
                 Child, Label ("Design Cost:"),
                 Child, tx30 = TextObject, MUIA_Text_PreParse, "\33c", MUIA_Text_Contents, "0", End,             
            End,       
            Child, BT_PurchaseDesign = KeyButton("Purchase Design",'d'),
          End,       
     End, 
   End;     

     
  /* load save settings */
  DoMethod(app,MUIM_Application_Load,MUIV_Application_Load_ENVARC);
  
   
  DoMethod(BT_Purchase      ,MUIM_Notify,MUIA_Pressed,FALSE,WI_Purchase,3,MUIM_Set,MUIA_Window_Open,TRUE);
  DoMethod(BT_FleetCargo    ,MUIM_Notify,MUIA_Pressed,FALSE,WI_FleetCargo,3,MUIM_Set,MUIA_Window_Open,TRUE);
  DoMethod(BT_PlanetCargo   ,MUIM_Notify,MUIA_Pressed,FALSE,WI_PlanetCargo,3,MUIM_Set,MUIA_Window_Open,TRUE);
  DoMethod(BT_Map           ,MUIM_Notify,MUIA_Pressed,FALSE,WI_Map     ,3,MUIM_Set,MUIA_Window_Open,TRUE);
  DoMethod(BT_Movement      ,MUIM_Notify,MUIA_Pressed,FALSE,WI_Movement,3,MUIM_Set,MUIA_Window_Open,TRUE);
  DoMethod(BT_ShipDesign    ,MUIM_Notify,MUIA_Pressed,FALSE,WI_ShipDesign,3,MUIM_Set,MUIA_Window_Open,TRUE);

  DoMethod(WI_Movement      ,MUIM_Notify,MUIA_Window_CloseRequest,TRUE,WI_Movement   ,3,MUIM_Set,MUIA_Window_Open,FALSE);
  DoMethod(WI_PlanetCargo   ,MUIM_Notify,MUIA_Window_CloseRequest,TRUE,WI_PlanetCargo ,3,MUIM_Set,MUIA_Window_Open,FALSE);
  DoMethod(WI_FleetCargo    ,MUIM_Notify,MUIA_Window_CloseRequest,TRUE,WI_FleetCargo ,3,MUIM_Set,MUIA_Window_Open,FALSE);
  DoMethod(WI_Purchase      ,MUIM_Notify,MUIA_Window_CloseRequest,TRUE,WI_Purchase,3,MUIM_Set,MUIA_Window_Open,FALSE);
  DoMethod(WI_Map           ,MUIM_Notify,MUIA_Window_CloseRequest,TRUE,WI_Map,3,MUIM_Set,MUIA_Window_Open,FALSE);
  DoMethod(WI_Configuration ,MUIM_Notify,MUIA_Window_CloseRequest,TRUE,WI_Map,3,MUIM_Set,MUIA_Window_Open,FALSE);
  DoMethod(WI_ShipDesign    ,MUIM_Notify,MUIA_Window_CloseRequest,TRUE,WI_ShipDesign,3,MUIM_Set,MUIA_Window_Open,FALSE);
  DoMethod(WI_Fleet         ,MUIM_Notify,MUIA_Window_CloseRequest,TRUE,WI_Fleet,3,MUIM_Set,MUIA_Window_Open,FALSE);
  DoMethod(WI_Sector        ,MUIM_Notify,MUIA_Window_CloseRequest,TRUE,WI_Sector,3,MUIM_Set,MUIA_Window_Open,FALSE);
  DoMethod(WI_Message       ,MUIM_Notify,MUIA_Window_CloseRequest,TRUE,WI_Message,3,MUIM_Set,MUIA_Window_Open,FALSE);
  
  DoMethod(BT_LoadGame      ,MUIM_Notify,MUIA_Pressed,FALSE,WI_Configuration,3,MUIM_Set,MUIA_Window_Open,FALSE);
  

  DoMethod(WI_Mainwindow,MUIM_Notify,MUIA_Window_CloseRequest,
    TRUE,app,2,MUIM_Application_ReturnID,MUIV_Application_ReturnID_Quit);
  DoMethod(BT_Quit,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_QUIT);
  DoMethod(WI_Configuration,MUIM_Notify,MUIA_Window_CloseRequest,
    TRUE,app,2,MUIM_Application_ReturnID,MUIV_Application_ReturnID_Quit);
  DoMethod(BT_Cancel,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_CANCEL);
  DoMethod(BT_SendPartial,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_SENDPARTIAL); 
  
  DoMethod(BT_ClearCourse,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_CLEARCOURSE);
  
  DoMethod(BT_Hyper,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_HYPER);  
 
  DoMethod(BT_LoadGame,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,MEN_LOADGAME); 
  DoMethod(BT_AutoFuel,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_AUTOFUEL); 
 
  DoMethod(BT_SendMessage,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_SENDMESSAGE);
  DoMethod(BT_ClearMessage,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_CLEARMESSAGE);
  DoMethod(str3,MUIM_Notify,MUIA_String_Acknowledge,
    MUIV_EveryTime,app,2,MUIM_Application_ReturnID,ID_NEWNAME);
  DoMethod(str5,MUIM_Notify,MUIA_String_Acknowledge,
    MUIV_EveryTime,app,2,MUIM_Application_ReturnID,ID_NEWNAME);
  DoMethod(str8,MUIM_Notify,MUIA_String_Acknowledge,
    MUIV_EveryTime,app,2,MUIM_Application_ReturnID,ID_SHIPNAME);
    
  DoMethod(BT_ApplyTrade,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_APPLYTRADE);
  
  DoMethod(BT_CancelTrade,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_CANCELTRADE);
  
  DoMethod(BT_SetProduction,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_SETPRODUCTION);
  DoMethod(BT_ClearProduction,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_CLEARPRODUCTION);
 
  DoMethod(sl32,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime,
   app,2,MUIM_Application_ReturnID,ID_NEWTAX);
  DoMethod(BT_PlanetTransferSec,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_PLANETTRANSFERSEC);
  DoMethod(BT_SectorTransferPla,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_SECTORTRANSFERPLA);  
  DoMethod(BT_FleetTransferSec,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_FLEETTRANSFERSEC);
  DoMethod(BT_PurchaseDesign,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_PURCHASEDESIGN);
  DoMethod(BT_PurchaseShip,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_PURCHASESHIP); 
  DoMethod(BT_SellGoods,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_SELLGOODS);  
  DoMethod(BT_JoinFleet,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_JOINFLEET);    
  
  DoMethod(BT_Sellship,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_SELLSHIP); 
  
  DoMethod(BT_Showships,MUIM_Notify,MUIA_Selected,
    FALSE,lv12,3,MUIM_Set, MUIA_ShowMe, FALSE); 
    
  DoMethod(BT_Showships,MUIM_Notify,MUIA_Selected,
    TRUE,lv12,3,MUIM_Set, MUIA_ShowMe, TRUE);   
  DoMethod(BT_Showships,MUIM_Notify,MUIA_Pressed,
    FALSE,lv12,3,MUIM_Set, MUIA_ShowMe, FALSE); 
  DoMethod(BT_Showships,MUIM_Notify,MUIA_Selected,
    TRUE,BT_Sellship,3,MUIM_Set, MUIA_Disabled, FALSE);  
  DoMethod(BT_Showships,MUIM_Notify,MUIA_Selected,
    TRUE,BT_SendPartial,3,MUIM_Set, MUIA_Disabled, FALSE);  
    
  DoMethod(BT_Showships,MUIM_Notify,MUIA_Selected,
    FALSE,BT_Sellship,3,MUIM_Set, MUIA_Disabled, TRUE);  
  DoMethod(BT_Showships,MUIM_Notify,MUIA_Selected,
    FALSE,BT_SendPartial,3,MUIM_Set, MUIA_Disabled, TRUE); 

    
  DoMethod(BT_SectorTransferFle,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_SECTORTRANSFERFLE);
  DoMethod(BT_MakePurchase,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_PURCHASE);
  DoMethod(BT_PlotCourse,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_PLOTCOURSE);
  DoMethod(BT_Done,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_DONE);
  DoMethod(BT_NextForce,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_NEXTFORCE);
  DoMethod(BT_LastForce,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_LASTFORCE);
  DoMethod(BT_NextPlayer,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_NEXTPLAYER);
  DoMethod(BT_LastPlayer,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_LASTPLAYER);
  DoMethod(str1,MUIM_Notify,MUIA_String_Acknowledge,MUIV_EveryTime,
    app,2,MUIM_Application_ReturnID,ID_ADDPLAYER);
  DoMethod(lv2,MUIM_Notify,MUIA_Listview_DoubleClick,MUIV_EveryTime,
    app,2,MUIM_Application_ReturnID,ID_SETSTRING);
  DoMethod(BT_NextPlanet,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_NEXTPLANET);
  DoMethod(BT_LastPlanet,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_LASTPLANET);
  DoMethod(BT_Movement,MUIM_Notify,MUIA_Pressed,
    FALSE,app,2,MUIM_Application_ReturnID,ID_MOVEMENT);
  DoMethod(lv1,MUIM_Notify,MUIA_List_Active,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_DISPLAY);
  
    
  DoMethod(lv11,MUIM_Notify,MUIA_List_Active,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_BUYSHIP);
    
  DoMethod(lv6,MUIM_Notify,MUIA_List_Active,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_SETFLEET);
  
  DoMethod(lv16,MUIM_Notify,MUIA_List_Active,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_SHOWSHIPS);
  
  DoMethod(sl36,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_DESIGNCOST);
  DoMethod(sl37,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_DESIGNCOST);
  DoMethod(sl38,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_DESIGNCOST);
  DoMethod(sl39,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_DESIGNCOST);
  DoMethod(sl40,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_DESIGNCOST);
  DoMethod(sl41,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_SECTORINFO);
  DoMethod(sl42,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_SECTORINFO);  
    
   
  DoMethod(lv3,MUIM_Notify,MUIA_List_Active,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_TOPLANET);
  DoMethod(lv7,MUIM_Notify,MUIA_List_Active,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_FROMSECTOR1);
  DoMethod(lv8,MUIM_Notify,MUIA_List_Active,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_FROMPLANET);
  DoMethod(lv10,MUIM_Notify,MUIA_List_Active,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_FROMFLEET);
  DoMethod(lv9,MUIM_Notify,MUIA_List_Active,MUIV_EveryTime, 
    app,2,MUIM_Application_ReturnID,ID_FROMSECTOR2);
  DoMethod(BT_AddPlayer,MUIM_Notify,MUIA_Pressed,FALSE, 
    app,2,MUIM_Application_ReturnID,ID_ADDPLAYER);
  DoMethod(sl10,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime,
    app,2,MUIM_Application_ReturnID,ID_FUEL);
  DoMethod(sl11,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime,
    app,2,MUIM_Application_ReturnID,ID_FUEL);
  DoMethod(sl12,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime,
    app,2,MUIM_Application_ReturnID,ID_FUEL);
  DoMethod(sl13,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime,
    app,2,MUIM_Application_ReturnID,ID_FUEL);
  DoMethod(sl14,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime,
    app,2,MUIM_Application_ReturnID,ID_FUEL);
  DoMethod(sl15,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime,
    app,2,MUIM_Application_ReturnID,ID_FUEL);
  DoMethod(sl17,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime,
    app,2,MUIM_Application_ReturnID,ID_DESTINATION);
  DoMethod(sl18,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime,
    app,2,MUIM_Application_ReturnID,ID_DESTINATION);
  DoMethod(sl10,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime,
   app,2,MUIM_Application_ReturnID,ID_CARGO);
  DoMethod(sl8,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime,
   app,2,MUIM_Application_ReturnID,ID_CARGO);
  DoMethod(sl9,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime,
   app,2,MUIM_Application_ReturnID,ID_CARGO);
  DoMethod(sl16,MUIM_Notify,MUIA_Slider_Level,MUIV_EveryTime,
   app,2,MUIM_Application_ReturnID,ID_CARGO);
  DoMethod(lv1,MUIM_Notify,MUIA_List_Active,MUIV_EveryTime,
    app,2,MUIM_Application_ReturnID,ID_ENABLEPURCHASE);
  DoMethod(lv4,MUIM_Notify,MUIA_List_Active,MUIV_EveryTime,
    app,2,MUIM_Application_ReturnID,ID_ITEMCOST);  
  DoMethod(BT_RemovePlayer,MUIM_Notify,MUIA_Pressed,FALSE,
    lv2,2,MUIM_List_Remove,MUIV_List_Remove_Active);


  DoMethod(WI_Configuration,MUIM_Window_SetCycleChain,str6,lv2,str1,
     BT_AddPlayer,BT_RemovePlayer,BT_Done,BT_Cancel,NULL);
  DoMethod(WI_Movement,MUIM_Window_SetCycleChain,lv12,sl17,sl18,lv3,
     BT_LastForce,BT_NextForce,BT_FleetCargo,BT_AutoFuel,BT_ClearCourse,BT_SendPartial,
     BT_Sellship, pop1,str9,pop2,str10,BT_ApplyTrade,BT_CancelTrade,NULL);
    
  DoMethod(WI_Mainwindow,MUIM_Window_SetCycleChain,BT_LastPlanet,
    BT_NextPlanet,str3,sl32,lv1,BT_LastPlayer,BT_NextPlayer,BT_Map,BT_Purchase,
    BT_Movement,BT_PlanetCargo,lv6,str5,sl41,sl42,lv16,lv17,NULL); 
  
  DoMethod(WI_Purchase,MUIM_Window_SetCycleChain,lv11,sl35,BT_PurchaseShip,BT_ShipDesign,lv4,
    sl1,BT_MakePurchase,NULL);   

/*
  DoMethod(pcy1,MUIM_Notify,MUIA_Cycle_Active,MUIV_EveryTime,
     pgr1,3,MUIM_Set,MUIA_Group_ActivePage,MUIV_TriggerValue);
*/  
  DoMethod(pcy2,MUIM_Notify,MUIA_Cycle_Active,MUIV_EveryTime,
     pgr2,3,MUIM_Set,MUIA_Group_ActivePage,MUIV_TriggerValue);
 
  DoMethod(app,MUIM_Application_Load,MUIV_Application_Load_ENVARC);
  
  if (!app) fail(app,"Failed to create application.");
 
  set(BT_Showships,MUIA_Selected,TRUE); 
  core(); 
  
  DoMethod(app,MUIM_Application_Save,MUIV_Application_Save_ENVARC);
  set(WI_Configuration,MUIA_Window_Open,FALSE);         
  set(WI_Mainwindow,MUIA_Window_Open,FALSE);
  
  MUI_DisposeObject(app);
    
  FreeClass(MyClass);          /* free our custom class.         */
  MUI_FreeClass(SuperClass);   /* release super class pointer.   */
  
                               /* save export ids                */
  fail(NULL,NULL);             /* exit, app is already disposed. */
}



__saveds __asm struct shiptag *consship(register __a0 struct Hook *hook,
                                        register __a2 APTR mem_pool,
                                        register __a1 struct ship *ship)
{
    struct shiptag *new;
    
    new=AllocVec(sizeof(struct shiptag),MEMF_ANY|MEMF_CLEAR);
    if (new) {
        strcpy(new->name,ship->name);
        new->id=ship->id;
        stci_d(new->attack,ship->attack);
        stci_d(new->defense,ship->defense);
        stci_d(new->speed,ship->speed);
        stci_d(new->cargo,ship->cargo);
        stci_d(new->fuel,ship->fuel);
        stci_d(new->cost,ship->cost);        
        stci_d(new->tech,ship->tech);
        return(new);}    
    return(0);
}

__saveds __asm struct tagchar *constag(register __a0 struct Hook *hook,
                                      register __a2 APTR mem_pool,
                                      register __a1 struct tagchar *tag)
{
    struct tagchar *new;
    
    new=AllocVec(sizeof(struct tagchar),MEMF_ANY|MEMF_CLEAR);
    if (new) {
        strcpy(new->name,tag->name);        
        strcpy(new->amount,tag->amount);       
        new->tagname = tag->tagname;
        new->tagdata = tag->tagdata;
        return(new);}    
    return(0);
}

SAVEDS ASM LONG desfleet(register __a0 struct Hook *hook, 
                         register __a2 APTR mem_pool,
                         register __a1 struct temp *fleet)
{
    FreeVec(fleet);
    return(0);
}

SAVEDS ASM LONG desship(register __a0 struct Hook *hook, 
                         register __a2 APTR mem_pool,
                         register __a1 struct shiptag *ship)
{
    FreeVec(ship);
    return(0);
}


SAVEDS ASM LONG destag  (register __a0 struct Hook *hook, 
                         register __a2 APTR mem_pool,
                         register __a1 struct tagchar *tag)
{
    FreeVec(tag);
    return(0);
}


SAVEDS ASM LONG dispfleet(register __a0 struct Hook *hook, 
                          register __a2 char **array,
                          register __a1 struct temp *fleet)
{
    if (fleet)
      {
      *array++ = fleet->x;
      *array++ = fleet->y;
      *array++ = fleet->planet;
      *array++ = fleet->empire;
      *array++ = fleet->attack;
      *array++ = fleet->defense;
      *array++ = fleet->speed;
      *array++ = fleet->cargo;
      *array++ = fleet->maxcargo;
      *array++ = fleet->range;
      *array++ = fleet->tox;
      *array++ = fleet->toy;
      *array   = fleet->destination;
      
      }
    else {
      *array++ = "X";
      *array++ = "Y";
      *array++ = "Planet";
      *array++ = "Empire";
      *array++ = "Attack";
      *array++ = "Deffense";
      *array++ = "Speed";
      *array++ = "Cargo";
      *array++ = "MaxCargo";
      *array++ = "Range";
      *array++ = "To X";
      *array++ = "To Y";
      *array   = "To Planet";
      
      }
    return(0);
  
}

SAVEDS ASM LONG dispship(register __a0 struct Hook *hook, 
                          register __a2 char **array,
                          register __a1 struct shiptag *ship)
{
    if (ship)
      {
      *array++ = ship->name;
      *array++ = ship->attack;
      *array++ = ship->defense;
      *array++ = ship->speed;
      *array++ = ship->cargo;
      *array++ = ship->fuel;
      *array   = ship->cost;
      }
    else {
      *array++ = "Type";
      *array++ = "Att";
      *array++ = "Def";
      *array++ = "Spd";
      *array++ = "Carg";
      *array++ = "Fuel";
      *array   = "Cost";
    }
    return(0);
}

SAVEDS ASM LONG disptag  (register __a0 struct Hook *hook, 
                          register __a2 char **array,
                          register __a1 struct tagchar *tag)
{
    if (tag)
      {
      *array++ = tag->amount;
      *array   = tag->name;
      }
    else {
      *array++ = "Number";
      *array   = "Item";
      }
    return(0);
}

SAVEDS ASM LONG disppurch  (register __a0 struct Hook *hook, 
                           register __a2 char **array,
                           register __a1 struct tagchar *tag)
{
    if (tag)
      {
      *array++ = tag->amount;
      *array   = tag->name;
      }
    else {
      *array++ = "Cost";
      *array   = "Item";
      }
    return(0);
}

__saveds __asm struct temp *consfleet(register __a0 struct Hook *hook,
                                      register __a2 APTR mem_pool,
                                      register __a1 struct force *fleet)
{
      
    struct temp *new;
    struct course *sector;
    int x2,y2;
    
    new=AllocVec(sizeof(struct temp),MEMF_ANY|MEMF_CLEAR);
    if (new) {
        stci_d(new->x,fleet->x);
        stci_d(new->y,fleet->y);
        if (SECTOR[fleet->x][fleet->y].PLANET) 
          strcpy(new->planet,SECTOR[fleet->x][fleet->y].PLANET->name);
        else strcpy(new->planet,"\n");
        if (fleet->id==0) strcpy(new->empire,"Independent");
        else strcpy(new->empire,fleet->empire);
        stci_d(new->attack,fleet->attack);
        stci_d(new->defense,fleet->defense);
        stci_d(new->speed,fleet->maxmove);
        stci_d(new->cargo,fleet->cargo);
        stci_d(new->maxcargo,fleet->maxcargo);
        stci_d(new->range,(fleet->fuel/fleet->fuelturn));      
        new->ship = fleet;
        sector = fleet->nextsector;

        if (fleet->planet1 != fleet->planet2) {
          if (fleet->planet1 == SECTOR[fleet->x][fleet->y].PLANET->ID) {   
            x2 = planetlist[0][fleet->planet2].x;
            y2 = planetlist[0][fleet->planet2].y;
            } 
          else {
            x2 = planetlist[0][fleet->planet1].x;
            y2 = planetlist[0][fleet->planet1].y;
            }
          
          stci_d(new->tox,planetlist[0][fleet->planet2].x);
          stci_d(new->toy,planetlist[0][fleet->planet2].y);
          strcpy(new->destination,SECTOR[x2][y2].PLANET->name);                    
        } 
        else {
          while (sector) {
            if (!sector->next) {
              stci_d(new->tox,sector->x);
              stci_d(new->toy,sector->y);
              if (SECTOR[sector->x][sector->y].PLANET) 
              strcpy(new->destination,SECTOR[sector->x][sector->y].PLANET->name);                
            }
          sector = sector->next;
          }
        }

        
        return(new);
      }    
    return(0);
}

LONG guiRequest(LONG id) {
  
  switch (id) {
     case 1:
       return(MUI_Request(app,WI_Mainwindow,0,"Quiting MUIEmpire...", "Quit|*Cancel", "Are you sure you want to Quit!"));
       break;
     case 2:
       MUI_Request(app,WI_Mainwindow,0,NULL, "OK", "Not enough fuel to load fleet!");
       break;
     case 3:
       MUI_Request(app,WI_Mainwindow,0,NULL, "OK", "You do not have enough cargo space for a full load of fuel!"); 
       break;
     case 4:
       MUI_Request(app,WI_Mainwindow,0,NULL, "OK", "You do not own the planet!");                 
       break; 
     case 5: 
       MUI_Request(app,WI_ShipDesign,0,NULL, "OK", "Not enough credits for ship design");
       break; 
     case 6:
       MUI_Request(app,WI_Mainwindow,0,NULL,  "OK",VSTRING);
       break;
     case 7:
       MUI_Request(app, WI_Mainwindow, 0, NULL, "OK", "ATTENTION!!!, The %s has conquered the galaxy! The Game is Over.", currentplayer->empire);
       break;
     case 8: 
       MUI_Request(app, WI_Mainwindow, 0, NULL, "OK", "ATTENTION!!!, The %s has conquered the puny human players! The Game is Over.", currentcomputerplayer->empire);
       break;
     case 9:
       if (currentplayer) MUI_Request(app, WI_Mainwindow, 0, NULL, "OK", "Attention %s! It is your turn.", currentplayer->name);
       break;
               
          
  }
  return(0);
}

/*************************/
/* Init & Fail Functions */
/*************************/

VOID fail(APTR app2,char *str)
{
  
  
        if (app2)
                MUI_DisposeObject(app2);

#ifndef _DCC
        if (MUIMasterBase)
                CloseLibrary(MUIMasterBase);
        if (UtilityBase)
                CloseLibrary(UtilityBase);

#endif

        if (str)
        {
                puts(str);
                exit(20);
        }
        exit(0);
}

static ULONG MUIM_xxx_CallRedraw(struct IClass *TheClass, Object *TheObject, Msg Message)
{
  /* set up some info in your instancedata, if required */
  MUI_Redraw(MyObj,MADF_DRAWOBJECT);
  return 0;
}


