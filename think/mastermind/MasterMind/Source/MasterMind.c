/* 
   MasterMind.c © Kamran Karimi.
   Written with SAS/C 6.50 on an A1200. 
*/
#include "misc.h"


#define ConstMaxColors 16
#define ConstMaxColumns 16

UWORD Private,Pens[] = {0xFFFF};
UBYTE PubName[] = "MasterMind";
struct TagItem MyTags[]  = { {SA_Pens,(ULONG)Pens},
                             {SA_PubName,(ULONG)PubName},
                             {SA_DisplayID,DEFAULT_MONITOR_ID | HIRES_KEY},
                             {SA_Overscan,OSCAN_TEXT},
                             {SA_AutoScroll,TRUE},
                             {TAG_END,NULL} };

ULONG NormalMaxColumns = 9,NormalMaxRows;
ULONG MaxColumns = 9,MinColumns = 1;
ULONG MaxColors = 12,MinColors = 2;
LONG NumColors = 6,PrevNumColors;
LONG NumColumns = 4,PrevNumColumns;
LONG NumRows = 0,PrevNumRows;
LONG MaxRows,MaxNoLaceRows,MinRows = 1;

ULONG GID,ShouldClear = FALSE;
APTR IAddress;
ULONG OS,ForcePal = FALSE,Public = TRUE,UseLace = TRUE;

UBYTE AllocatedColor[ConstMaxColors]; /* 4 reserved colors */
UBYTE Cheated[ConstMaxColumns];

ULONG Blacks,Whites,MemAlloc1 = FALSE,MemAlloc2 = FALSE;
ULONG SelectedColor,LowRow,PrevLowRow,NumCheated,FastClean = FALSE;
ULONG CurrentRow = 1,Added = FALSE,Lace = FALSE,Pal;  
USHORT X,Y;/* for Result Borders */

struct Remember *ColorRem = NULL,*BoardRem =NULL;
 
VOID Error(ULONG Err),MyMessage(int Mes),CompResBorder(VOID);
VOID ClearBoard(VOID),UpDateAcceptGadget(LONG Where),CheckBounds(VOID);
VOID DrawCircles(LONG Whites,LONG Blacks),GoUp(VOID),ComputeResults(VOID);
VOID GetRandColors(VOID),ProcessBoardGadget(struct Gadget *GadAddr);
VOID ClickOtherColorGads(LONG ID),FillMyColorGadgets(VOID),MyOpenLibs(int);
VOID DrawMyGadgets(VOID),DoConfiguration(VOID),MyEvent(LONG event);
VOID FreeMyGadgets(struct Remember *MyStructRem,struct Gadget *GadToDo);
VOID StartNewGame(VOID),OpenAll(VOID),FreeResources(VOID),WaitForUser(VOID);
int AllocMyGadgets(LONG GadgetNum,struct Remember *MyStructRem,
                                                     struct Gadget *GadToDo);
VOID OpenDragableColor(VOID),CloseDragableColor(VOID);
VOID HandleDragableColor(VOID),GetNewVals(VOID),CleanClean(VOID);
ULONG Permute(ULONG,ULONG);
VOID Cheat(VOID),GetArgs(int,char **);
LONG CheckNoRep(VOID),CheckAllSelected(VOID);
VOID CompatibleSetOPen(struct RastPort *rp,ULONG Color);
ULONG CompatibleGetAPen(struct RastPort *rp),CloseScr(VOID);
VOID CompatibleLoadRGB(struct ViewPort *vp);


main(int argc,char *argv[])
{
 int done = FALSE,ConfigDone = 0;
 struct Gadget *CurGad;

 IconBase = NULL;
 MyOpenLibs(argc);

 OS = ((struct Library *)IntuitionBase)->lib_Version;
 if(((struct Library *)GfxBase)->lib_Version >= 36)
  if(GfxBase->ChipRevBits0 & GFXF_HR_DENISE) 
   if(GfxBase->ChipRevBits0 & GFXF_HR_AGNUS) ForcePal = TRUE;
 GetArgs(argc,argv);
 if(OS < 36) UseLace = TRUE;
 if(ForcePal) Pal = TRUE;
 else Pal = (GfxBase->DisplayFlags & PAL);
 if(OS >= 36) MaxColumns = 12;
 NormalMaxRows  = (Pal) ? 24 : 18;
 if(OS >= 36) MaxRows = 99;
 else MaxRows = NormalMaxRows;
 MaxNoLaceRows = (Pal) ? 11 : 8;
 if(!NumRows) NumRows = (Pal) ? 10 : 8;
 NewScr.Height = (Pal) ? 256 : 200;
 MyNewWindow.Height = NewScr.Height;
 if(!Public) MyTags[1].ti_Tag = TAG_IGNORE; 

 ((struct StringInfo *)CMGadget.SpecialInfo)->LongInt = NumColumns;
 ((struct StringInfo *)CRGadget.SpecialInfo)->LongInt = NumColors;
 ((struct StringInfo *)RWGadget.SpecialInfo)->LongInt = NumRows;
 PrevNumRows = NumRows;
 PrevNumColumns = NumColumns;
 PrevNumColors = NumColors;
 GetNewVals();
 StartNewGame();
              
 while (done == FALSE)
 {
  WaitForUser(); 
  if ((GID >= 100) && (GID < 116))  
  {
   ClickOtherColorGads(GID);
   MyMessage(Colorize);
   CurGad = (struct Gadget *)IAddress;
   if(CurGad->Flags & GFLG_SELECTED)
    SelectedColor = GID - 96; /* colors start with 4 */
   else SelectedColor = 0;
  }
  if((GID <= NumColumns) && (GID > 0)) ProcessBoardGadget(IAddress);
  switch(GID)
  {
   case 0:
             break;
   case 300:
             if(!CheckAllSelected())
             {
              if(CheckNoRep())
              {
               MyMessage(NoRep);
               break;
              }
              else
              {
               ComputeResults();
               if(Blacks == NumColumns) 
               {
                MyEvent(UserWon);
                MyMessage(ChooseCol);
                StartNewGame(); 
                break;
               }
               if(CurrentRow != NumRows) 
               {
                MyMessage(AfterDone);
                CurrentRow++;
                GoUp();
               }
               else 
               {
                NewGadget.GadgetText = &NewText;
                RefreshGList(&NewGadget,MyWindow,NULL,1);
                MyEvent(GameDone);
                MyMessage(ChooseCol);
                StartNewGame(); 
               }
              }
             }
             else MyMessage(FillFirst);  
             break;

   case 500: Cheat();
             break;

   case 501:
             if((OS >= 36) && Public)
             {
              Private = PubScreenStatus(MyScreen,PSNF_PRIVATE);
              if(Private & 0x0001) done = TRUE;
              else MyMessage(Visitors);
             }
             else done = TRUE;
             break;

   case 502: 
             if(NewGadget.GadgetText == &AbortText)
             {
              NewGadget.GadgetText = &NewText;
              RefreshGList(&NewGadget,MyWindow,NULL,1);
              MyEvent(GameDone);
              MyMessage(ChooseCol);
              StartNewGame(); 
             }
             else 
             {
              MyMessage(ChooseCol);
              StartNewGame();
             }
             break;

   case 503:
             if(ConfigDone)  
             {
              RemoveGList(MyWindow,&RWGadget,3);
              GetNewVals();
              StartNewGame();
             }
             else  
             {
              if(ColorWindow && (ColorWindow != MyWindow)) 
               CloseDragableColor();
              DoConfiguration();
              MyMessage(ChangeConf);
             }
             ConfigDone = ~ConfigDone;
             break;
 
   case 1000: 
             NumColumns = ((struct StringInfo *)CMGadget.SpecialInfo)->LongInt;
             break; 

   case 1001: 
             NumColors = ((struct StringInfo *)CRGadget.SpecialInfo)->LongInt;
             break;

   case 1002: 
             NumRows = ((struct StringInfo *)RWGadget.SpecialInfo)->LongInt;
             break;
  }
 }
 FreeResources();
 exit(0);
}


VOID FreeResources(VOID)
{
 if(MemAlloc1)
 {
  RemoveGList(MyWindow,&BoardGadget,NumColumns);
  FreeMyGadgets(BoardRem,&BoardGadget);
 }
 if(MemAlloc2)
 {
  RemoveGList(ColorWindow,&ColorGadget,NumColors);
  FreeMyGadgets(ColorRem,&ColorGadget);
 }
 if(Added) RemoveGList(MyWindow,&ConfiGadget,5);
 if(ColorWindow && (ColorWindow != MyWindow)) CloseWindow(ColorWindow);
 if(MyWindow) CloseWindow(MyWindow);
 if(MyScreen) CloseScreen(MyScreen);
 if(GfxBase) CloseLibrary((struct Library *)GfxBase);
 if(IconBase) CloseLibrary(IconBase);
 if(IntuitionBase) CloseLibrary((struct Library *)IntuitionBase);
}


VOID WaitForUser(VOID)
{
 struct MsgPort *Port;
 struct IntuiMessage *msg;
 UWORD code;
 ULONG class,RecMask;
 ULONG ColorMask = 1L << (ColorWindow->UserPort)->mp_SigBit;
 ULONG MainMask = 1L << (MyWindow->UserPort)->mp_SigBit;

#ifdef DEBUG
 printf("ColorWin = %lx    MyWin = %lx\n",ColorWindow,MyWindow);
 printf("ColorMask = %08lx    MainMask = %08lx\n",ColorMask,MainMask);
#endif
 RecMask = Wait(ColorMask | MainMask);
 if(RecMask & ColorMask) Port = ColorWindow->UserPort;
 else Port = MyWindow->UserPort;
 msg = (struct IntuiMessage *)GetMsg(Port);
 GID = 0;
 class = msg->Class;
 switch(class)
 {
    case IDCMP_GADGETUP: 
                        IAddress = (msg->IAddress);
                        GID = ((struct Gadget *)IAddress)->GadgetID;
                        while(msg)
                        {
                         ReplyMsg((struct Message *)msg);
                         msg = (struct IntuiMessage *)GetMsg(Port);
                        }
                        break;
    case IDCMP_MOUSEBUTTONS:
                        code = msg->Code;
                        while(msg)
                        {
                         ReplyMsg((struct Message *)msg);
                         msg = (struct IntuiMessage *)GetMsg(Port);
                        }
                        if(code == MENUUP)
                         if(ConfiGadget.GadgetText != &DoneText) 
                          HandleDragableColor();
                        break;
 }
}


VOID HandleDragableColor(VOID)
{
 if(ColorWindow == MyWindow) OpenDragableColor();
 else CloseDragableColor();
}


VOID CloseDragableColor(VOID)
{
 int count;
 struct Gadget *CurrGad;

 if((ColorWindow == NULL) || (ColorWindow == MyWindow)) return;
 RemoveGList(ColorWindow,&ColorGadget,NumColors);
 CloseWindow(ColorWindow);
 ColorWindow = MyWindow;
 ColorGadget.LeftEdge = MyScreen->Width - 350;
 ColorGadget.TopEdge = MyScreen->Height - 16;  
 CurrGad = ColorGadget.NextGadget;
 for(count = 1;count < NumColors;count++)
 {
  CurrGad->LeftEdge = ColorGadget.LeftEdge - count * 25;
  CurrGad->TopEdge = ColorGadget.TopEdge;
  CurrGad = CurrGad->NextGadget;
 } 
 AddGList(MyWindow,&ColorGadget,~0,NumColors,NULL);
 DrawBorder(ColorWindow->RPort,&ColBorder[3],
             MyScreen->Width - NumColors * 25 - 328,ColorGadget.TopEdge - 2);
 FillMyColorGadgets();
 RefreshGList(&ColorGadget,MyWindow,NULL,NumColors); 
}


VOID OpenDragableColor(VOID)
{
 int count;
 SHORT Left,Width;
 struct Gadget *CurrGad;

 if((ColorWindow != MyWindow) && (ColorWindow != NULL)) return;
 RemoveGList(MyWindow,&ColorGadget,NumColors);
 SetAPen(MyWindow->RPort,0);
 CompatibleSetOPen(MyWindow->RPort,0);
 RectFill(MyWindow->RPort,2,MyScreen->Height - 22,
                             ColorGadget.LeftEdge + 30,MyScreen->Height);
 NewColorWindow.Width = NumColors * 25 + 40;  
 if(MyScreen->MouseY > 50)
   NewColorWindow.TopEdge = MyScreen->MouseY - 35; 
 else 
  NewColorWindow.TopEdge = MyScreen->MouseY;
  
  NewColorWindow.LeftEdge = (MyScreen->MouseX) - (NewColorWindow.Width/2);
  Left = NewColorWindow.LeftEdge;
  Width = NewColorWindow.Width;
  if(Left + Width >= MyScreen->Width) 
   NewColorWindow.LeftEdge = MyScreen->Width - Width;
  if(Left <= MyScreen->LeftEdge)
   NewColorWindow.LeftEdge = MyScreen->LeftEdge;
  
 ColorGadget.LeftEdge = NewColorWindow.Width - 40;
 ColorGadget.TopEdge = 16;
 CurrGad = ColorGadget.NextGadget;
 for(count = 1;count < NumColors;count++)
 {
  CurrGad->LeftEdge = ColorGadget.LeftEdge - count * 25;
  CurrGad->TopEdge = ColorGadget.TopEdge;
  CurrGad = CurrGad->NextGadget;
 } 
 NewColorWindow.Screen = MyScreen; 
 if((ColorWindow = OpenWindow(&NewColorWindow)) == NULL) Error(NoWindow);
 AddGList(ColorWindow,&ColorGadget,~0,NumColors,NULL);
 DrawBorder(ColorWindow->RPort,&ColBorder[3],22,14);
 FillMyColorGadgets();
 RefreshGList(&ColorGadget,ColorWindow,NULL,NumColors);
} 

VOID Error(ULONG Err)
{
 FreeResources();
 exit(Err);
}

VOID CompatibleSetOPen(struct RastPort *rp,ULONG Color)
{
 if(OS >= 39) SetOutlinePen(rp,Color);
 else SetOPen(rp,(UBYTE)Color);
}

ULONG CompatibleGetAPen(struct RastPort *rp)
{
 return((OS >= 39) ? GetAPen(rp) : rp->FgPen);
}

VOID CompatibleLoadRGB(struct ViewPort *vp)
{
 if(OS >= 39) LoadRGB32(vp,CMap32Bit); 
 else LoadRGB4(vp,CMap4Bit,16);
}

VOID MyMessage(int Mes)
{
 LONG y,Color; 

 strcpy(Row1,Messages[Mes]);
 strcpy(Row2,Messages[Mes + 1]);
 strcpy(Row3,Messages[Mes + 2]);
 y = (Pal) ? 89 : 65;
 Color = 1;
 if(Mes == UserWon) Color = 4;
 else if(Mes == GameDone) Color = 7; 
 if(Mes >= NoAvailMem)
 {
  Color = 8;
  DisplayBeep(MyScreen);
 }
 row1Text.FrontPen = row2Text.FrontPen = row3Text.FrontPen = Color;
 PrintIText(MyWindow->RPort,&row3Text,MyScreen->Width - 180,y);
}


VOID Cheat(VOID)
{
 struct IntuiMessage *msg;
 LONG CheatCol,Column,XMin,YMin,XMax,YMax,cnt;
 struct Gadget *CurGad;
 struct MD *md;

 RemoveGList(MyWindow,&BoardGadget,NumColumns);
 RemoveGList(ColorWindow,&ColorGadget,NumColors);
 OffGadget(&AcceptGadget,MyWindow,NULL);
 OffGadget(&CheatGadget,MyWindow,NULL);
 OffGadget(&NewGadget,MyWindow,NULL);
 CheatCol = (ULONG)(rand() % NumColumns);
 while(Cheated[CheatCol + 4] == TRUE) CheatCol = (CheatCol + 1) % NumColumns;
 NumCheated++;
 Cheated[CheatCol + 4] = TRUE;
 MyMessage(CheatMe);
 MyResWindow.LeftEdge = CheatGadget.LeftEdge;
 MyResWindow.TopEdge = CheatGadget.TopEdge - 100;
 MyResWindow.Screen = MyScreen;
 MyResWindow.Width = 100;
 MyResWindow.Title = "Naughty!";
 if((ResWindow = OpenWindow(&MyResWindow)) == NULL) Error(NoWindow);
 CurGad = &BoardGadget;
 for(Column = 0;Column < CheatCol;Column++) CurGad = CurGad->NextGadget;
 DrawImage(ResWindow->RPort,&MyImage, 33,15);
 XMin = 33 + 9;
 YMin = 20;
 XMax = XMin + 14;
 YMax = YMin + 8;
 md = CurGad->UserData;
 SetAPen(ResWindow->RPort,md->RandomColor);
 CompatibleSetOPen(ResWindow->RPort,md->RandomColor);
 RectFill(ResWindow->RPort,XMin,YMin,XMax,YMax);
 WaitPort(ResWindow->UserPort);
 msg = (struct IntuiMessage *)GetMsg(ResWindow->UserPort);
 while(msg)
 {
  ReplyMsg((struct Message *)msg);
  msg = (struct IntuiMessage *)GetMsg(ResWindow->UserPort);
 }
 CloseWindow(ResWindow);
 CurGad = &ColorGadget;
 for(cnt = 0;cnt < md->RandomColor - 4;cnt++) CurGad = CurGad->NextGadget;
 CheatSign.BackPen = md->RandomColor;
 XMin = CurGad->LeftEdge + 6;
 YMin = CurGad->TopEdge + 1;
 PrintIText(ColorWindow->RPort,&CheatSign,XMin,YMin);
 UpDateAcceptGadget(1);
 OnGadget(&AcceptGadget,MyWindow,NULL);
 XMin = CheatGadget.LeftEdge - 2;
 YMin = CheatGadget.TopEdge - 2;
 XMax = NewGadget.LeftEdge + NewGadget.Width + 2;
 YMax = YMin + NewGadget.Height + 1;
 SetAPen(MyWindow->RPort,0);
 CompatibleSetOPen(MyWindow->RPort,0);
 if(NumCheated < NumColumns) OnGadget(&CheatGadget,MyWindow,NULL);
 else OffGadget(&CheatGadget,MyWindow,NULL);
 RectFill(MyWindow->RPort,XMin,YMin,XMax,YMax);
 SetAPen(MyWindow->RPort,SelectedColor);
 CompatibleSetOPen(MyWindow->RPort,SelectedColor);
 OnGadget(&NewGadget,MyWindow,NULL);
 RefreshGList(&CheatGadget,MyWindow,NULL,1);
 AddGList(MyWindow,&BoardGadget,~0,NumColumns,NULL);
 AddGList(ColorWindow,&ColorGadget,~0,NumColors,NULL);
}

VOID CompResBorder(VOID)
{
 ULONG BigX,BigY,XMin,YMin,XMax,YMax,count;
 
 Y =  19;
 X =  ((NumColumns / 2) + (NumColumns % 2)) * 15; 

 ResLines1[1] = Y;
 ResLines1[4] = X + 1;

 ResLines2[1] = Y - 1;
 ResLines2[2] = X + 1;
 ResLines2[3] = Y - 1;
 ResLines2[4] = X + 1;

 ResLines3[1] = Y - 2;
 ResLines3[4] = X;

 ResLines4[1] = Y;
 ResLines4[2] = X + 2;
 ResLines4[3] = Y;
 ResLines4[4] = X + 2; 
 BigX = X + NumColumns * 33 + 13;
 BigY = LowRow - ((NumRows - 1) * 19 + 5);
 SetAPen(MyWindow->RPort,2);
 Move(MyWindow->RPort,2,LowRow + 23);
 Draw(MyWindow->RPort,2,BigY);
 Draw(MyWindow->RPort,BigX,BigY);
 SetAPen(MyWindow->RPort,1);
 Draw(MyWindow->RPort,BigX,LowRow + 23);
 Draw(MyWindow->RPort,2,LowRow + 23);
 SetAPen(MyWindow->RPort,3); 
 RectFill(MyWindow->RPort,3,BigY + 1,BigX - 1,LowRow + 22);

 SetAPen(MyWindow->RPort,0);
 for(count = 0;count < NumRows;count++)
 {
  XMin = 9;
  YMin = LowRow - count * 19;
  XMax = XMin + X - 1;
  YMax = YMin + Y - 2;
  RectFill(MyWindow->RPort,XMin,YMin,XMax,YMax);
 }
} 

ULONG Permute(ULONG arg1,ULONG arg2)
{
 ULONG count,val = 1;
 
 arg2 = arg1 - arg2;
 for(count = arg2 + 1;count <= arg1;count++)
 {
  val =  val * count;
  if(val > MaxRows) break;
 }
 return(val);
}


VOID CheckBounds(VOID)
{
 ULONG Perm;

 if(NumColumns < MinColumns) NumColumns = MinColumns;
 else if(NumColumns > MaxColumns) NumColumns = MaxColumns;
 if(NumColors < MinColors) NumColors = MinColors;
 else if(NumColors > MaxColors) NumColors = MaxColors;
 if(NumRows < MinRows) NumRows = MinRows;
 else if(NumRows > MaxRows) NumRows = MaxRows;
 if(NumColors < NumColumns) NumColors = NumColumns;
 Perm = Permute(NumColors,NumColumns) - 1;
 if(NumRows > Perm) NumRows = Perm;
}


ULONG CloseScr(VOID)
{
 ULONG Success = TRUE;

 if(MyScreen)
 {
  if((OS >= 36) && Public)
  {
   Private = PubScreenStatus(MyScreen,PSNF_PRIVATE);
   if(!(Private & 0x0001)) 
   { 
    Success = FALSE; 
    MyMessage(Visitors); 
   }
  }
  if(Success)
  {
   if(MemAlloc1 && MyWindow)
   {
    RemoveGList(MyWindow,&BoardGadget,NumColumns);
    FreeMyGadgets(BoardRem,&BoardGadget);
    MemAlloc1 = FALSE;
   }
   if(MemAlloc2 && ColorWindow)
   {
    RemoveGList(ColorWindow,&ColorGadget,NumColors);
    FreeMyGadgets(ColorRem,&ColorGadget);
    MemAlloc2 = FALSE;
   } 
   if(Added) { RemoveGList(MyWindow,&ConfiGadget,4); Added = FALSE; }
   if(MyWindow) { CloseWindow(MyWindow); ColorWindow = MyWindow = NULL; }
   if(MyScreen) { CloseScreen(MyScreen); MyScreen = NULL; }
  }
 }
 return(Success);
}


VOID GetNewVals(VOID)
{
 ULONG ShouldChange = FALSE;
 UWORD OW,OH,OM;

 NumColumns = ((struct StringInfo *)CMGadget.SpecialInfo)->LongInt;
 NumColors = ((struct StringInfo *)CRGadget.SpecialInfo)->LongInt;
 NumRows = ((struct StringInfo *)RWGadget.SpecialInfo)->LongInt;
 CheckBounds();
 OW = NewScr.Width;
 OH = NewScr.Height;
 OM = NewScr.ViewModes;
 NewScr.DefaultTitle = NormalScrTitle;
 if(NumColumns > NormalMaxColumns)
 {
  NewScr.Width = 640 + (NumColumns - NormalMaxColumns) * 35 + 9;
  NewScr.DefaultTitle = ExtraScrTitle;
 }
 else NewScr.Width = 640; 
 if(UseLace)
 {
  if(NumRows > MaxNoLaceRows)
  {
   NewScr.ViewModes |= LACE;
   MyTags[2].ti_Data |= HIRESLACE_KEY;    
   NewScr.Height = (Pal) ? 512 : 400;
  } 
  else
  {
   NewScr.ViewModes &= ~LACE;
   MyTags[2].ti_Data &= ~HIRESLACE_KEY;
   MyTags[2].ti_Data |= HIRES_KEY;  
   NewScr.Height = (Pal) ? 256 : 200;
  }
  if(NumRows > NormalMaxRows) 
  {
   NewScr.Height += (NumRows - NormalMaxRows) * 20;
   NewScr.DefaultTitle = ExtraScrTitle;
  }
 }
 else
 {
  if(NumRows > MaxNoLaceRows) 
  {
   NewScr.Height = ((Pal) ? 256 : 200) + (NumRows - MaxNoLaceRows) * 20;
   NewScr.DefaultTitle = ExtraScrTitle;  
  }
  else  
  {
   NewScr.Height = (Pal) ? 256 : 200;
   NewScr.DefaultTitle = NormalScrTitle;
  }
 }
 MyNewWindow.Height = NewScr.Height;
 MyNewWindow.Width = NewScr.Width;
 ShouldChange = 
   ((OW != NewScr.Width) || (OH != NewScr.Height) || (OM != NewScr.ViewModes));
 if(ShouldChange || !MyScreen)
 {
  if(CloseScr()) 
  {
   ShouldClear = FALSE;
   AcceptGadget.LeftEdge = 1;
   OpenAll();
   MyMessage(ChooseCol);
  } 
  else
  {
   NumColors = PrevNumColors;
   NumColumns = PrevNumColumns;
   NumRows = PrevNumRows;
   MyNewWindow.Width = NewScr.Width = OW;
   MyNewWindow.Height = NewScr.Height = OH;
   NewScr.ViewModes = OM;
   if(MyScreen) MyMessage(Visitors);
  }
 }
 else MyMessage(ChooseCol); 
#ifdef DEBUG
  printf("Width = %d   Height = %d\n",NewScr.Width,NewScr.Height);
#endif
}


VOID ClearBoard(VOID)
{
 ULONG BigX,BigY,x,y;
 
 SetAPen(MyWindow->RPort,0);
 CompatibleSetOPen(MyWindow->RPort,0);
 RectFill(MyWindow->RPort,2,MyScreen->Height - 22,
                                          MyScreen->Width,MyScreen->Height);
 if(!ShouldClear)
 {
  ShouldClear = TRUE;
  FastClean = FALSE;
 }
 else
 {
  BigX = X + PrevNumColumns * 33 + 13;
  BigY = PrevLowRow - ((PrevNumRows - 1) * 19 + 5);
  if((PrevNumColumns == NumColumns) && (PrevNumRows == NumRows))
  {
   CleanClean();
   FastClean = TRUE;
  }
  else
  { 
   FastClean = FALSE;
   RectFill(MyWindow->RPort,2,BigY,BigX + 1,PrevLowRow + 23);
  }
  x = ConfiGadget.LeftEdge - 2;
  y = ConfiGadget.TopEdge - 2;
  RectFill(MyWindow->RPort,x,y,x + ConfiGadget.Width + 2,
                                                 y + ConfiGadget.Height + 2);
 }
}


VOID UpDateAcceptGadget(LONG Where)
{
 ULONG XMin,YMin,XMax,YMax,OldAPen;
 
 if(!Where) RemoveGList(MyWindow,&AcceptGadget,1);
 XMin = AcceptGadget.LeftEdge - 1;
 YMin = AcceptGadget.TopEdge - 1;
 XMax = XMin + 64;
 YMax = YMin + 13;
 OldAPen = CompatibleGetAPen(MyWindow->RPort);
 SetAPen(MyWindow->RPort,0);
 CompatibleSetOPen(MyWindow->RPort,0);
 RectFill(MyWindow->RPort,XMin,YMin,XMax,YMax);
 SetAPen(MyWindow->RPort,OldAPen);
 if(!Where)  
 {
  AcceptGadget.TopEdge -= 19;
  AddGList(MyWindow,&AcceptGadget,~0,1,NULL);
  RefreshGList(&AcceptGadget,MyWindow,NULL,1);
 }
}


VOID DrawCircles(LONG Whites,LONG Blacks)
{ 
 ULONG CoOrd1,CoOrd2,count,count2,Elements;
 struct Image *CurrImage;
 
 CoOrd1 = BoardGadget.LeftEdge;
 CoOrd2 = BoardGadget.TopEdge;
 count = 0;
 Elements = Whites;
 CurrImage = &WCircle; 
 for(count2 = 0;count2 < 2;count2++)
 {
  while(Elements > 0)
  {
   DrawImage(MyWindow->RPort,CurrImage,CoOrd1 - 12,CoOrd2 + 4 );   
   switch(count % 2)
   {
    case 0: CoOrd2 += 6;
            break;

    case 1: CoOrd1 -= 12;
            CoOrd2 -= 6;
            break;
   } 
   count++;
   Elements--;
  }
  Elements = Blacks;
  CurrImage = &BCircle;
 }
}
 

LONG CheckAllSelected(VOID)
{
 struct Gadget *CurGad;
 struct MD *md;
 int count;

 CurGad = &BoardGadget;
 for(count = 1;count <= NumColumns;count++)
 {
  md = (struct MD *)CurGad->UserData;
  if(md->GuessedColor == 0) return(1);
  CurGad = CurGad->NextGadget;
 }
 return(0);
} 


LONG CheckNoRep(VOID)
{
 LONG count,count2;
 struct Gadget *CurGad,*CurGad2; 
 struct MD *md,*md2;

 CurGad = &BoardGadget;
 for(count = 0;count < NumColumns;count++)
 {
  CurGad2 = CurGad->NextGadget;
  for(count2 = count + 1;count2 <= NumColumns; count2++)
  {
   md = (struct MD *)CurGad->UserData;
   md2 = (struct MD *)CurGad2->UserData;
   CurGad2 = CurGad2->NextGadget;
   if((md->GuessedColor == md2->GuessedColor) && 
                                    (md->GuessedColor != 0)) return(RepFound);
  }
  CurGad = CurGad->NextGadget;
 }
 return(0);
}


VOID GoUp(VOID)
{
 int count;
 struct Gadget *CurGad;
 struct MD *md;

 RemoveGList(MyWindow,&BoardGadget,NumColumns);
 CurGad = &BoardGadget;
 for(count = 1;count <= NumColumns;count++)
 {
  CurGad->TopEdge -=  19;
  md = (struct MD *)CurGad->UserData;
  md->GuessedColor = 0;
  CurGad = CurGad->NextGadget;
 }
 AddGList(MyWindow,&BoardGadget,~0,NumColumns,NULL);
 RefreshGList(&BoardGadget,MyWindow,NULL,NumColumns);
 UpDateAcceptGadget(0);
}


VOID ComputeResults(VOID)
{
 LONG count,count2,XMin,YMin,XMax,YMax;
 struct MD *md,*md2;
 struct Gadget *CurGad,*CurGad2;

 Blacks = Whites = 0;
 CurGad = &BoardGadget;

 if(NewGadget.GadgetText != &AbortText)
 {
  NewGadget.GadgetText = &AbortText;
  RefreshGList(&NewGadget,MyWindow,NULL,1);
  OffGadget(&ConfiGadget,MyWindow,NULL);
  OffGadget(&QuitGadget,MyWindow,NULL);
  XMin = CheatGadget.LeftEdge - 2;
  YMin = CheatGadget.TopEdge - 2;
  XMax = XMin + CheatGadget.Width + 4;
  YMax = YMin + CheatGadget.Height + 4;
  SetAPen(MyWindow->RPort,0);
  CompatibleSetOPen(MyWindow->RPort,0);
  RectFill(MyWindow->RPort,XMin,YMin,XMax,YMax);
  if((NumColumns == 1) || (NumColumns == NumColors))
   OffGadget(&CheatGadget,MyWindow,NULL);
  else OnGadget(&CheatGadget,MyWindow,NULL);
  SetAPen(MyWindow->RPort,SelectedColor); 
  CompatibleSetOPen(MyWindow->RPort,SelectedColor);
 }
 for(count = 1;count <= NumColumns; count++) /* first the blacks */
 {
  md = (struct MD *)CurGad->UserData;
  if(md->RandomColor == md->GuessedColor) 
  {
   md->GuessedColor = 0;
   Blacks++;
  }
  CurGad = CurGad->NextGadget;
 }

 CurGad = &BoardGadget;
 for(count = 1;count <= NumColumns;count++)
 {
  md = (struct MD *)CurGad->UserData;
  CurGad2 = &BoardGadget;
  for(count2 = 1; count2 <= NumColumns;count2++)
  {
   md2 = (struct MD *)CurGad2->UserData;
   if(md->RandomColor == md2->GuessedColor) 
   {
    md2->GuessedColor = 0;
    Whites++;
    break;
   }
   CurGad2 = CurGad2->NextGadget;
  }
  CurGad = CurGad->NextGadget;
 }
 CurGad = &BoardGadget;
 for(count = 1;count <= NumColumns;count++)
 {
  md = (struct MD *)CurGad->UserData;
  md->GuessedColor = 0;
  CurGad = CurGad->NextGadget;
 }
 DrawCircles(Whites,Blacks);
#ifdef DEBUG
 printf("whites = %ld  Blacks = %ld\n",Whites,Blacks);
#endif
}

VOID GetRandColors(VOID)
{
 ULONG count,Color;
 ULONG Secs,Mics;
 struct Gadget *CurGad;
 struct MD *md;

#ifdef DEBUG
 printf("Total Colors = %ld\n",NumColors);
 printf("Columns = %d\n",NumColumns);
 printf("Rows = %ld\n",NumRows);
#endif
 
 CurGad = &BoardGadget;
 CurrentTime(&Secs,&Mics);
 srand(Secs + Mics);
 for(count = 1;count <= NumColumns;count++)
 {
  Color = (ULONG)(rand() % NumColors);
  while(AllocatedColor[Color + 4] == TRUE) 
                                       Color = (Color + 1) % NumColors;
  md = (struct MD *)CurGad->UserData;
  md->RandomColor = Color + 4;
  md->GuessedColor = 0;
  AllocatedColor[Color + 4] = TRUE;
  CurGad = CurGad->NextGadget;
#ifdef DEBUG
  printf("Color No. %ld = %ld\n",count,Color);
#endif
 } 
} 


VOID ProcessBoardGadget(struct Gadget *GadAddr)
{
 LONG XMin,YMin,XMax,YMax;
 struct MD *md;

 XMin = GadAddr->LeftEdge + 9;
 YMin = GadAddr->TopEdge + 5;
 XMax = XMin + 14;
 YMax = YMin + 8;
 SetAPen(MyWindow->RPort,SelectedColor);
 CompatibleSetOPen(MyWindow->RPort,SelectedColor);
 RectFill(MyWindow->RPort,XMin,YMin,XMax,YMax);
 if(SelectedColor > 3)
 {
  md = (struct MD *)GadAddr->UserData;
  md->GuessedColor = SelectedColor;
  MyMessage(RepColoring);
 }
}

VOID CleanClean(VOID)
{
 ULONG XMin,XMax,YMin,YMax,ResYMin,count1,count2;

 YMin = LowRow + 5;
 YMax = YMin + 8;
 SetAPen(MyWindow->RPort,0);
 CompatibleSetOPen(MyWindow->RPort,0);
 for(count1 = 1; count1 <= NumRows; count1++)
 {
  ResYMin = LowRow + 2 - (count1 - 1) * 19;
  RectFill(MyWindow->RPort,10,ResYMin,7 + X - 1,ResYMin + 13);
  XMin = X + 9 + 9;
  XMax = XMin + 14;
  for(count2 = 1;count2 <= NumColumns; count2++)
  {
   RectFill(MyWindow->RPort,XMin,YMin,XMax,YMax);
   XMin = XMin + BoardGadget.Width;
   XMax = XMin + 14;
  }
  YMin = YMin - 19;
  YMax = YMin + 8;
 }
}


VOID ClickOtherColorGads(LONG ID)
{
 int count;
 struct Gadget *CurGad = &ColorGadget;

 for(count = 0;count < NumColors;count++)
 { 
  if((CurGad->Flags & GFLG_SELECTED) && (CurGad->GadgetID != ID))
  {
   CurGad->Flags &= ~GFLG_SELECTED;  
   break;
  }
  CurGad = CurGad->NextGadget;
 }
 RefreshGList(&ColorGadget,ColorWindow,NULL,NumColors);
}


VOID FillMyColorGadgets(VOID)
{
 LONG count,count2,XMin,YMin,XMax,YMax,Color;
 struct Gadget *CurGad = &ColorGadget,*CurGad2;

 for(count = 4;count < NumColors + 4;count++)
 {
  SetAPen(ColorWindow->RPort,count);
  CompatibleSetOPen(ColorWindow->RPort,count);
  XMin = CurGad->LeftEdge;
  YMin = CurGad->TopEdge;
  XMax = XMin + CurGad->Width - 1;
  YMax = YMin + CurGad->Height - 1;
  RectFill(ColorWindow->RPort,XMin,YMin,XMax,YMax);
  CurGad2 = &BoardGadget;
  for(count2 = 0;count2 < NumColumns;count2++)
  {
   Color = ((struct MD *)(CurGad2->UserData))->RandomColor;
   if((Cheated[count2 + 4] == TRUE) && (Color == count))
   { 
    CheatSign.BackPen = count;
    XMin = CurGad->LeftEdge + 6;
    YMin = CurGad->TopEdge + 1;
    PrintIText(ColorWindow->RPort,&CheatSign,XMin,YMin);
   }
   CurGad2 = CurGad2->NextGadget;
  }
  CurGad = CurGad->NextGadget;
 }
}


VOID DrawMyGadgets(VOID)
{
 int Column,Row;

 if(FastClean) return;
 CompResBorder();
 for(Row = 0;Row < NumRows;Row++)
 {
  DrawBorder(MyWindow->RPort,&ResBorder[3],7,LowRow - Row * 19);
  for(Column = 0;Column < NumColumns;Column++)
   DrawImage(MyWindow->RPort,&MyImage,(X + 9 + Column * 33),
                                                          LowRow - Row * 19);
 }
}

 
/* This routine dynamically allocates gadgets. Total gadget number equals 
   the ones allocated here plus the gadget whose pointer is in GadTodo.
   total = [GadgetNum -1] (allocated here) + [1] (GadToDo)
*/

int AllocMyGadgets(LONG GadgetNum,struct Remember *MyStructRem,
                                                      struct Gadget *GadToDo)
{
 struct Gadget *PrevGadget,*NewGad;
 struct MD *Mymd;
 int count;
  
 if(GadToDo == &BoardGadget) GadToDo->LeftEdge = X + 9;
 GadToDo->Flags &= ~GFLG_SELECTED;
 PrevGadget = GadToDo;
 for(count = 1; count < GadgetNum; count++) 
 {
  NewGad = AllocRemember(&MyStructRem,sizeof(struct Gadget),MEMF_ANY);
  if(NewGad == NULL) 
  {
   FreeMyGadgets(MyStructRem,GadToDo);
   return(FALSE);
  }
  CopyMem(GadToDo,NewGad,sizeof(struct Gadget));
  NewGad->GadgetID = PrevGadget->GadgetID + 1;
  if(GadToDo == &BoardGadget)
  {
   NewGad->LeftEdge = PrevGadget->LeftEdge + GadToDo->Width;
   Mymd = AllocRemember(&MyStructRem,sizeof(struct MD),MEMF_ANY|MEMF_CLEAR);
   if(Mymd == NULL) 
   {
    FreeMyGadgets(MyStructRem,GadToDo);
    return(FALSE);
   }
   NewGad->UserData = Mymd;
  }
  else if(GadToDo == &ColorGadget)
   NewGad->LeftEdge = PrevGadget->LeftEdge - GadToDo->Width - 5; 
  PrevGadget->NextGadget = NewGad;
  PrevGadget = NewGad;
 }
 NewGad->NextGadget = NULL;
 return(TRUE);
}

VOID FreeMyGadgets(struct Remember *MyStructRem,struct Gadget *GadToDo)
{
 FreeRemember(&MyStructRem,TRUE);
 MyStructRem = NULL;
 GadToDo->NextGadget = NULL;
}


VOID DoConfiguration(VOID)
{
 LONG y1;

 y1 = (Pal) ? 111 : 90;

 PrevNumColors = NumColors;
 PrevNumRows = NumRows;
 PrevNumColumns = NumColumns;
 PrevLowRow = LowRow;

 if(MemAlloc1)
 {
  RemoveGList(MyWindow,&BoardGadget,NumColumns);
  FreeMyGadgets(BoardRem,&BoardGadget);
 }
 if(MemAlloc2)
 {
  RemoveGList(ColorWindow,&ColorGadget,NumColors);
  FreeMyGadgets(ColorRem,&ColorGadget);
 }
 MemAlloc1 = MemAlloc2 = FALSE;
 ConfiGadget.GadgetText = &DoneText;
 RefreshGList(&ConfiGadget,MyWindow,NULL,1);
 OffGadget(&NewGadget,MyWindow,NULL);
 OffGadget(&QuitGadget,MyWindow,NULL);
 OffGadget(&AcceptGadget,MyWindow,NULL);
 OffGadget(&CheatGadget,MyWindow,NULL);
 CRGadget.GadgetRender = &ConfBorder[3];
 CMGadget.GadgetRender = &ConfBorder[3];
 RWGadget.GadgetRender = &ConfBorder[3];
 BigConfBorder[0].FrontPen = 2;
 BigConfBorder[1].FrontPen = 1;
 DrawBorder(MyWindow->RPort,&BigConfBorder[1],
                             MyScreen->Width - 182,MyScreen->Height - y1 - 1);
 AddGList(MyWindow,&RWGadget,~0,3,NULL);
 RefreshGList(&RWGadget,MyWindow,NULL,3);
}  


VOID MyEvent(LONG event)
{
 struct IntuiMessage *msg;
 LONG Column,XMin,YMin,XMax,YMax;
 ULONG class;
 struct Gadget *CurGad;
 struct MD *md;

 RemoveGList(MyWindow,&BoardGadget,NumColumns);
 RemoveGList(ColorWindow,&ColorGadget,NumColors);
 OffGadget(&CheatGadget,MyWindow,NULL);
 OffGadget(&AcceptGadget,MyWindow,NULL);
 if(event == UserWon) 
 {
  MyMessage(UserWon);
  NewGadget.GadgetText = &OKText;
  RefreshGList(&NewGadget,MyWindow,NULL,1);
  do
  {    
   WaitPort(MyWindow->UserPort);
   msg = (struct IntuiMessage *)GetMsg(MyWindow->UserPort);
   class = msg->Class;
   while(msg)
   {
    ReplyMsg((struct Message *)msg);
    msg = (struct IntuiMessage *)GetMsg(MyWindow->UserPort);
   }
  }while(class != IDCMP_GADGETUP);
  NewGadget.GadgetText = &NewText;
  RefreshGList(&NewGadget,MyWindow,NULL,1);
 }
 if(event == GameDone)
 { 
  MyMessage(GameDone);
  OffGadget(&NewGadget,MyWindow,NULL);
  MyResWindow.Width = NumColumns * 33 + 13 + 40;
  MyResWindow.LeftEdge = NewGadget.LeftEdge - MyResWindow.Width + 100;
  MyResWindow.TopEdge = NewGadget.TopEdge - 100;
  MyResWindow.Screen = MyScreen;
  MyResWindow.Title = "Solution";
  if((ResWindow = OpenWindow(&MyResWindow)) == NULL) Error(NoWindow);
  CurGad = &BoardGadget;
  for(Column = 0;Column < NumColumns;Column++)
  {
   DrawImage(ResWindow->RPort,&MyImage, 25 + Column * 33,15);
   XMin = 25 + Column * 33 + 9;
   YMin = 20;
   XMax = XMin + 14;
   YMax = YMin + 8;
   md = CurGad->UserData;
   SetAPen(ResWindow->RPort,md->RandomColor);
   CompatibleSetOPen(ResWindow->RPort,md->RandomColor);
   RectFill(ResWindow->RPort,XMin,YMin,XMax,YMax);
   CurGad = CurGad->NextGadget;
  } 
  WaitPort(ResWindow->UserPort);
  msg = (struct IntuiMessage *)GetMsg(ResWindow->UserPort);
  while(msg)
  {
   ReplyMsg((struct Message *)msg);
   msg = (struct IntuiMessage *)GetMsg(ResWindow->UserPort);
  }
  CloseWindow(ResWindow);
 }
}


VOID StartNewGame(VOID)
{

 LONG y1,count,XMin,YMin,XMax,YMax,X2;

 y1 = (Pal) ? 111 : 90;

 SelectedColor = 0; 
 if(MemAlloc1)
 {
  RemoveGList(MyWindow,&BoardGadget,NumColumns);
  FreeMyGadgets(BoardRem,&BoardGadget);
 }
 if(MemAlloc2)
 {
  RemoveGList(ColorWindow,&ColorGadget,NumColors);
  FreeMyGadgets(ColorRem,&ColorGadget);
 }
 for(count = 0;count < (MaxColors + 4);count++) AllocatedColor[count] = FALSE;
 for(count = 0;count < (MaxColumns + 4);count++) Cheated[count] = FALSE;
 NumCheated = 0;
 CurrentRow = 1;
 LowRow = MyScreen->Height - 24 - (MyScreen->Height - (NumRows * 19)) / 2;
 BoardGadget.TopEdge = LowRow;
 OffGadget(&CheatGadget,MyWindow,NULL); 
 OnGadget(&NewGadget,MyWindow,NULL);
 OnGadget(&QuitGadget,MyWindow,NULL);
 OnGadget(&AcceptGadget,MyWindow,NULL);
 OnGadget(&ConfiGadget,MyWindow,NULL);
 UpDateAcceptGadget(1);
 ClearBoard();
 X2 = NumColors * (20 + 5) + 7;  
 CoLines1[4] = X2;
 CoLines2[2] = X2 - 1;
 CoLines2[4] = X2 - 1;
 CoLines3[4] = X2 - 1;
 CoLines4[2] = X2;
 CoLines4[4] = X2;
 
 if(ColorWindow == MyWindow)
  DrawBorder(ColorWindow->RPort,&ColBorder[3],
            MyScreen->Width - NumColors * 25 - 328,ColorGadget.TopEdge - 2); 
 else
  DrawBorder(ColorWindow->RPort,&ColBorder[3],22,14);
 DrawMyGadgets(); 
 MemAlloc1 = (AllocMyGadgets(NumColumns,BoardRem,&BoardGadget)) ? TRUE:FALSE;
 MemAlloc2 = (AllocMyGadgets(NumColors,ColorRem,&ColorGadget)) ? TRUE:FALSE;
 if(!MemAlloc1 || !MemAlloc2)
 {
  MyMessage(NoAvailMem);
  Delay(300);
  FreeResources();
  exit(20);
 } 
 GetRandColors();
 AddGList(MyWindow,&BoardGadget,~0,NumColumns,NULL);

 AddGList(ColorWindow,&ColorGadget,~0,NumColors,NULL);

 FillMyColorGadgets(); 

 RefreshGList(&BoardGadget,MyWindow,NULL,NumColumns);
 RefreshGList(&ColorGadget,ColorWindow,NULL,NumColors);

 sprintf(crbuf,"%d",NumColors);
 sprintf(cmbuf,"%d",NumColumns);
 sprintf(rwbuf,"%d",NumRows);
 ((struct StringInfo *)CMGadget.SpecialInfo)->LongInt = NumColumns;
 ((struct StringInfo *)CRGadget.SpecialInfo)->LongInt = NumColors;
 ((struct StringInfo *)RWGadget.SpecialInfo)->LongInt = NumRows;
 XMin = CMGadget.LeftEdge - 4;
 YMin = CMGadget.TopEdge - 4;
 XMax = RWGadget.LeftEdge + RWGadget.Width + 2;
 YMax = RWGadget.TopEdge + RWGadget.Height + 2;
 SetAPen(MyWindow->RPort,0);
 CompatibleSetOPen(MyWindow->RPort,0);
 RectFill(MyWindow->RPort,XMin,YMin,XMax,YMax);
 BigConfBorder[0].FrontPen = 1;
 BigConfBorder[1].FrontPen = 2;
 DrawBorder(MyWindow->RPort,&BigConfBorder[1],
                            MyScreen->Width - 182,MyScreen->Height - y1 - 1);
 CRGadget.GadgetRender = NULL;
 CMGadget.GadgetRender = NULL;
 RWGadget.GadgetRender = NULL;
 AddGList(MyWindow,&RWGadget,~0,3,NULL);
 RefreshGList(&RWGadget,MyWindow,NULL,3);
 RemoveGList(MyWindow,&RWGadget,3);
 AcceptGadget.LeftEdge = BoardGadget.LeftEdge + NumColumns * 33  + 9;
 AcceptGadget.TopEdge = LowRow - (CurrentRow - 1) * 19 + 4;
 RefreshGList(&AcceptGadget,MyWindow,NULL,1);
 NewGadget.GadgetText = &NewText;
 RefreshGList(&NewGadget,MyWindow,NULL,2);
 RefreshGList(&CheatGadget,MyWindow,NULL,2);
 ConfiGadget.GadgetText = &ConfigText;
 RefreshGList(&ConfiGadget,MyWindow,NULL,1);
 PrevNumColors = NumColors;
 PrevNumRows = NumRows;
 PrevNumColumns = NumColumns;
 PrevLowRow = LowRow;
}


VOID MyOpenLibs(int Argc)
{
 if((IntuitionBase = (struct IntuitionBase *)
        OpenLibrary("intuition.library",0)) == NULL) Error(NoIntuition);

 if((GfxBase = (struct GfxBase *)
        OpenLibrary("graphics.library",0)) == NULL) Error(NoGraphics);

 if(!Argc)
  if((IconBase = OpenLibrary("icon.library",33)) == NULL) Error(NoIcon);
}


VOID OpenAll(VOID)
{
 LONG y,y1;
 
 y = (Pal) ? 86 : 62;
 y1 = (Pal) ? 111 : 90;

 if(OS >= 36)
 {
  if(ForcePal) MyTags[2].ti_Data |= PAL_MONITOR_ID;
  if((MyScreen = OpenScreenTagList(&NewScr,MyTags)) == NULL) Error(NoScreen); 
 }
 
 else if((MyScreen = OpenScreen(&NewScr)) == NULL) Error(NoScreen);
 MyNewWindow.Screen = MyScreen;
 if((MyWindow = OpenWindow(&MyNewWindow)) == NULL) Error(NoWindow);
 ColorWindow = MyWindow;
 
 CompatibleLoadRGB(&(MyScreen->ViewPort));

 ColorGadget.LeftEdge = MyScreen->Width - 350;
 ColorGadget.TopEdge = MyScreen->Height - 16;

 QuitGadget.LeftEdge = MyScreen->Width - 90;
 QuitGadget.TopEdge = MyScreen->Height - 15;
 
 NewGadget.LeftEdge = MyScreen->Width - 190;
 NewGadget.TopEdge = MyScreen->Height  - 15;

 CheatGadget.LeftEdge = MyScreen->Width - 290;
 CheatGadget.TopEdge = MyScreen->Height - 15;

 ConfiGadget.LeftEdge = MyScreen->Width - 135;
 ConfiGadget.TopEdge = MyScreen->Height - (y1 - 48);
  
 DrawImage(MyWindow->RPort,&LogoImage,MyScreen->Width - 184, 20);

 PrintIText(MyWindow->RPort,&rwText,
                MyScreen->Width - 183,MyScreen->Height - y1 + 2);

 BigConfBorder[0].FrontPen = 1;
 BigConfBorder[1].FrontPen = 2;
 DrawBorder(MyWindow->RPort,&BigConfBorder[1],
                            MyScreen->Width - 182,MyScreen->Height - y1 - 1);

 DrawBorder(MyWindow->RPort,&MessBorder[3],
                               MyScreen->Width - 180,y);

 CRGadget.LeftEdge = CMGadget.LeftEdge =
                              RWGadget.LeftEdge = MyScreen->Width - 90;

 CMGadget.TopEdge = MyScreen->Height - y1;
 CRGadget.TopEdge = CMGadget.TopEdge + 15;
 RWGadget.TopEdge = CRGadget.TopEdge + 16;
 
 AddGList(MyWindow,&ConfiGadget,~0,5,NULL);
 Added = TRUE;
 if((OS >= 36) && Public)
 {
  Private = PubScreenStatus(MyScreen,0);
  if (!(Private & 0x0001)) Error(NoPub);
 }
}


VOID GetArgs(int argc,char *argv[])
{
 int Temp,count;
 struct WBStartup *WBMessage;
 struct WBArg *WBarg;
 struct DiskObject *DiskObj;
 char **ToolArray,*tt;

 if((argc == 2) && !strcmp(argv[1],"?"))
 {
  printf("\n MasterMind.  © Kamran Karimi\n");
  printf("\nUSAGE: %s [(c|C)#] [(g|G)#] [(t|T)#] [m|M)] [e|E] [n|N]\n",
                                                                   argv[0]);
  printf("         c : Guess among this many 'C'olors\n\
         g : 'G'uess this many Colors\n\
         t : In atmost this many 'T'ries\n\
         m : Use a custo'M' screen (not public)\n\
         e : Don't use interlace ('E'yes at 'E'ase!)\n\
         n : Don't force a PAL screen (for 'N'TSC users)\n");
  exit(0);
 }
 if(argc > 1)
 {
  for(count = 1;count < argc;count++)
  {
   Temp = atoi(argv[count] + 1);
   switch (argv[count][0])
   {
    case 'g':
    case 'G':
             if(Temp > 0) NumColumns = Temp;
             break;
    case 'c':
    case 'C':
             if(Temp > 0) NumColors = Temp;
             break; 
    case 't':
    case 'T':
             if(Temp > 0) NumRows = Temp;
             break;
    case 'm':
    case 'M':
             Public = FALSE;
             break;
    case 'e':
    case 'E':
             UseLace = FALSE;
             break;       
    case 'n':
    case 'N':
             ForcePal = FALSE;
             break;        
   }
  }
 }

 if(!argc)
 {
  WBMessage = (struct WBStartup *)argv;
  WBarg = WBMessage->sm_ArgList;
  DiskObj = GetDiskObject(WBarg->wa_Name);
  ToolArray = (char **)DiskObj->do_ToolTypes; 
  if(tt = (char *)FindToolType(ToolArray,"COLORS")) 
  {
   Temp = atoi(tt);
   if(Temp > 0) NumColors = Temp;
  }
  if(tt = (char *)FindToolType(ToolArray,"GUESS")) 
  {
   Temp = atoi(tt);
   if(Temp > 0) NumColumns = Temp;
  }
  if(tt = (char *)FindToolType(ToolArray,"TRIES")) 
  {
   Temp = atoi(tt);
   if(Temp > 0) NumRows = Temp;
  }
  if(tt = (char *)FindToolType(ToolArray,"CUSTOMSCREEN")) Public = FALSE;
  if(tt = (char *)FindToolType(ToolArray,"NOINTERLACE")) UseLace = FALSE;
  if(tt = (char *)FindToolType(ToolArray,"NOPAL")) ForcePal = FALSE;
  FreeDiskObject(DiskObj);
 }
}
