#include "defines.h"
#include "guidefines.h"
#include "struct.h"
#include "externalprototypes.h"

extern ULONG signals;
extern APTR app,tx1;
extern struct MsgPort *client;
ULONG guiinput(void);
int guiset(struct MsgPort *client,LONG datasize,LONG object,LONG method,LONG data); 
int guiget(struct MsgPort *client,LONG datatype,LONG object,LONG method,APTR data); 
int guiDoMethod(struct MsgPort *client, LONG message,LONG pointerlength,LONG object,ULONG data,...);
extern LONG guiRequest(LONG);
void clientsetup(struct MsgPort *);
int  changeplayer(void);
void clientsetup(struct MsgPort *client) {return;}

ULONG guiinput ()
{
    
  return(DoMethod(app,MUIM_Application_Input,&signals));

}

int guiset(struct MsgPort *client,LONG datasize,LONG object,LONG method,LONG data) {

LONG address;
APTR *pointer;
  
  if (!object) return(0);
  address = (LONG)&tx1;
  
  
  address += object*sizeof(LONG); /* first object */     
  pointer  = (APTR *)address;
  set(*pointer,method,data);
    
  return(0);
}  

int guiget(struct MsgPort *client,LONG datatype,LONG object,LONG method,APTR data) {

LONG address;
APTR *pointer;
  
  if (!object) return (0);
  address = (LONG)&tx1;
  
  address += object*sizeof(LONG); /* first object */     
  pointer  = (APTR *)address;
  get(*pointer,method,data);
    
  return(0);
} 

int guiDoMethod(struct MsgPort *client, LONG message, LONG pointerlength,LONG object,ULONG data,...) {

LONG address;
APTR *pointer;

  if (!object) return (0);
  address = (LONG)&tx1;

  address += object*sizeof(LONG); /* first object */
  pointer  = (APTR *)address;
  DoMethodA(*pointer,(Msg)&data); 
  
  return(0);
}
  
int changeplayer() {
  
  int x,n,m;
  char *p;
  struct TagItem *tag,*tstate;
  struct ship *tempship;
  struct player *player;
  struct tagchar *cargo = NULL,cargotag;
  
  if (!client) cleandisplay();
  
  if ((playernumber > 1) && (client == 0)) {
    guiset(client,INT,WI_MOVEMENT,MUIA_Window_Open,FALSE);
    guiset(client,INT,WI_FLEETCARGO,MUIA_Window_Open,FALSE);
    guiset(client,INT,WI_MAP,MUIA_Window_Open,FALSE);
  }
  currentfleet = currentplayer->nextfleet;
  for (x=0;x<planetnumber;x++) {
    n=planetlist[currentplayer->id][x].x;
    m=planetlist[currentplayer->id][x].y;
    p = planetlist[currentplayer->id][x].name;
    SECTOR[n][m].PLANET=&planetlist[currentplayer->id][x];
    guiDoMethod(client,GUI_DOMETHODGET5,SMALLSTRING,LV3,MUIM_List_Insert,&p,1,MUIV_List_Insert_Bottom);
    }
  x = findplanet(-1,1);
  
  currentplayer->currentplanet = &planetlist[currentplayer->id][x];
  fromx = planetlist[0][x].x;
  fromy = planetlist[0][x].y;
  
  if (x>=0) guiset(client,INT,BT_PURCHASE,MUIA_Disabled,FALSE);
  else guiset(client,INT,BT_PURCHASE,MUIA_Disabled,TRUE);
  
  purchase(x);
  displayplanet(x);
  selectplanets();
  display(currentplayer);
  fleetlist(currentplayer->nextfleet);
  displayfleet(currentplayer->nextfleet);
  displaymessages(currentplayer);
  if (currentplayer->next==NULL) guiset(client,SMALLSTRING,BT_NEXTPLAYER,MUIA_Text_Contents,"End Turn");
  else guiset(client,SMALLSTRING,BT_NEXTPLAYER,MUIA_Text_Contents,"Next Player");
     
  /* insert ship information */
  tstate = currentplayer->fleettag;
  guiDoMethod(client,GUI_DOMETHODGET3,0,LV11,MUIM_List_Clear,TRUE); 
  while (tag = NextTagItem (&tstate)) {
    tempship = (struct ship *) tag->ti_Data;
    guiDoMethod(client,GUI_DOMETHODGET5,SHIP,LV11,MUIM_List_Insert,&tempship,1,MUIV_List_Insert_Top);
    } 
  
  guiset(client,INT,LV18,MUIA_List_Quiet,TRUE);
  guiDoMethod(client,GUI_DOMETHODGET3,0,LV18,MUIM_List_Clear,TRUE);
  player = headplayer;  
  while (player) {
     if (currentplayer->id != player->id) {
       strcpy(cargotag.name,player->empire);
       cargotag.tagdata = player->id;
       cargotag.tagname = (ULONG) player;
       cargo = &cargotag;
       guiDoMethod(client,GUI_DOMETHODGET5,CARGO,LV18,MUIM_List_Insert,&cargo,1,MUIV_List_Insert_Bottom);
     }
     player = player->next;  
  }
  guiset(client,INT,LV18,MUIA_List_Quiet,FALSE);
  if(!currentfleet) guiset(NULL,INT,BT_MOVEMENT,MUIA_Disabled,TRUE);
  else guiset(NULL,INT,BT_MOVEMENT,MUIA_Disabled,FALSE);  
  guiset(NULL,INT,WI_MAINWINDOW,MUIA_Window_Open,TRUE);
  guiset(NULL,INT,WI_MESSAGES,MUIA_Window_Open,TRUE);
  guiDoMethod(NULL,GUI_DOMETHODGET3,0,MYOBJ, MUIM_MyObjRedraw,TRUE);

  guiRequest(9);  
  setdisplay(); 
  return(0);
}
