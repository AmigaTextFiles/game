/***************************************/
/***                                 ***/
/***  Chunky 3D Core v1.55 13/03/98  ***/
/*** Copyright(c) J.Gregory  1995-98 ***/
/***                                 ***/
/***************************************/

#include <3D_Core:Includes/3DC_Main.h>

/**************************/
/*** Function Prototype ***/
/**************************/



/************************/
/*** Main Global Data ***/
/************************/



/************/
/*** Main ***/
/************/

void main(void) {
  WORD ret=0;
  
  ret = C3D_Init("LevelA.Res");
               
  while(!ret) {
    C3D_DrawMain();
    if(ASM_KeyStatus(C3D_Keys,0x45)) ret=C3D_OptsMenu();
    } 
    
  C3D_Free();
  }


/********************/
/*** Options Menu ***/
/********************/

/* Returns 0 on continue or non zero if quit required */

WORD C3D_OptsMenu(void) {
  WORD ret,agn=1;


  while(agn) {  
    agn=0;
    ret=C3D_ActionMenu("!!OPTIONS!!\n\n[A]bout\n[C]ontinue\n"
                       "[W]orkbench\n[Q]uit\n",
                       "\x20\x10\x11\x33",
                       501,0,-6);
    if(ret==0x20) {
      C3D_ActionMenu("3D_Core v1.00\nCopyright(c) J.Gregory 1998"
                     "\n[C]continue",
                     "\x33",501,0,-6);
      agn=1;
      }

    if(ret==0x11) { C3D_Hibernate(); agn=1; }
    }

  if(ret!=0x10) ret=0;

  return ret;
  }



/***************************************/
/**** Pre-Move/Draw Stuff Goes Here ****/
/***************************************/

/* This function is called by C3D_DrawMain() prior
   to any other processing
*/

void C3D_PreMove(void) {
                 
  /*** View Repositioning Keys ***/

  if(ASM_KeyStatus(C3D_Keys,0x5A)) {
    view0.DxOffset-=1;
    view1.DxOffset-=1;
    C3D_ViewStatus=0;
    C3D_LoadView();
    }

  if(ASM_KeyStatus(C3D_Keys,0x5B)) {
    view0.DxOffset+=1;
    view1.DxOffset+=1;
    C3D_ViewStatus=0;
    C3D_LoadView();
    }

  if(ASM_KeyStatus(C3D_Keys,0x5C)) {
    view0.DyOffset-=1;
    view1.DyOffset-=1;
    C3D_ViewStatus=0;
    C3D_LoadView();
    }

  if(ASM_KeyStatus(C3D_Keys,0x5D)) {
    view0.DyOffset+=1;
    view1.DyOffset+=1;
    C3D_ViewStatus=0;
    C3D_LoadView();
    }

  }

/*****************************************/
/**** Post Frame Draw Stuff Goes Here ****/
/*****************************************/

/* This routine is called by C3D_DrawMain() after
   main drawing has finished but before C2P & Frame
   Sync procedures
*/

void C3D_DrawHUD(void) {
  struct Rect line;
  char text[20];

  sprintf(text,"H:%ld",VP->Heading);
  C3D_Text6x9(text,10,10,0);
  line.X1=150;
  line.Y1=55;
  line.X2=170;
  line.Y2=75;
  ASM_DrawLine(&line,ChunkyTab,&ScrnRect,0L,01L);
  line.X1=170;
  line.Y1=55;
  line.X2=150;
  line.Y2=75;
  ASM_DrawLine(&line,ChunkyTab,&ScrnRect,0L,01L);
  }

