/************************************************************************
*									*
* China Challenge III - the C Version					*
*									*
* author	: Gunther Nikl						*
* created	: 8-may-94						*
* last change	: 2-nov-95						*
*									*
************************************************************************/

/* our include file */

#include "cc3.h"

/* init functions */

VOID InitMusic()
{
  ULONG rlen;
  BPTR file;

  AudioPort.mp_Node.ln_Type=NT_MSGPORT;
  if ((BYTE)(AudioPort.mp_SigBit=AllocSignal(-1L))>=0)
  {
    AudioPort.mp_SigTask=FindTask(NULL);
    NEWLIST(&AudioPort.mp_MsgList);

    AudioIO.ioa_Request.io_Message.mn_Node.ln_Type=NT_MESSAGE;
    AudioIO.ioa_Request.io_Message.mn_Node.ln_Pri=ADALLOC_MAXPREC;
    AudioIO.ioa_Request.io_Message.mn_ReplyPort=&AudioPort;
    AudioIO.ioa_Request.io_Flags=ADIOF_NOWAIT;
    AudioIO.ioa_Data=ChannelMap;
    AudioIO.ioa_Length=sizeof(ChannelMap);
    if (!OpenDevice(AudioName,0,&AudioIO.ioa_Request,0))
    {
      AudioOpen++;
      if ((SampleBuf=AllocMem(SAMPLESIZE,MEMF_CHIP|MEMF_PUBLIC)))
      {
        if ((file=Open(SampleName,MODE_OLDFILE)))
        {
          rlen=Read(file,SampleBuf,SAMPLESIZE);
          Close(file);
          if (rlen==SAMPLESIZE)
          {
            if (!(ciaa.ciapra & CIAF_LED))
            {
              ciaa.ciapra |= CIAF_LED; AudioOpen++;
            }
            OptMusic();
            if (!AudioIO.ioa_Request.io_Error)
              return;
          }
        }
      }
    }
    FreeMusic();
  }
  MenuItems[7].Flags &= ~(CHECKED|ITEMENABLED|CHECKIT);
}

LONG MakeGfx()
{
  PLANEPTR *planes;
  int i;

  if ((ScrPtr=OpenScreen(&NewScreen)))
  {
    NewWindow.Screen=ScrPtr;
    if ((WinPtr=OpenWindow(&NewWindow)))
    {
      SetMenuStrip(WinPtr,&MenuStrip[0]);
      ShowTitle(ScrPtr,FALSE);
      LoadRGB4(&ScrPtr->ViewPort,&ColorTab[0],1<<DEPTH);
      InitRastPort(&RastPort);
      SetFont(&RastPort,WinPtr->IFont);
      InitBitMap(&BitMap,DEPTH,WIDTH,HEIGHT);
      for (planes=&BitMap.Planes[0],i=DEPTH; i!=0 ; --i)
       {
         if (!(*planes++=AllocRaster(WIDTH,HEIGHT))) return;
       }
      RastPort.BitMap=&BitMap;
      CurrentTime((ULONG *)&EntryTable[0],(ULONG *)&RandVal);
      MakeDragon();
      ScreenToFront(ScrPtr);
      return 1;
    }
  }
  /* return 0; */
}

/* the main loop */

LONG Main()
{
  volatile struct IntuiMessage *imsg;
  ULONG imClass;
  UWORD imCode;

  if (MakeGfx())
  {
    InitMusic();
    for (;;)
     {
       if (!(imsg=(struct IntuiMessage *)GetMsg(WinPtr->UserPort)))
         WaitPort(WinPtr->UserPort);
       else
       {
         imClass = imsg->Class; imCode  = imsg->Code;
         ReplyMsg((struct Message *)imsg);
         DoIDCMP(imClass,imCode);
         if (EndAll)
           break;
       }
     }
  }
  FreeMusic();
  CloseGfx();
  return (0);
}

/* cleanup functions */

VOID CloseGfx()
{
  PLANEPTR *planes,p;
  int i;

  for (planes=&BitMap.Planes[0],i=DEPTH; i!=0 ; i--)
   {
     if ((p=*planes++))
       FreeRaster(p,WIDTH,HEIGHT);
   }
  if (WinPtr)
  {
    ClearMenuStrip(WinPtr); CloseWindow(WinPtr);
  }
  if (ScrPtr)
    CloseScreen(ScrPtr);
}

VOID FreeMusic()
{
  if (AudioOpen)
    CloseDevice(&AudioIO.ioa_Request);
  if ((BYTE)AudioPort.mp_SigBit>0)
  {
    FreeSignal(AudioPort.mp_SigBit); AudioPort.mp_SigBit=0;
  }
  if (SampleBuf)
  {
    FreeMem(SampleBuf,SAMPLESIZE); SampleBuf=NULL;
    if (--AudioOpen)
      ciaa.ciapra &= ~CIAF_LED;
    AudioOpen=0;
  }
}

/* process all messages */

VOID DoIDCMP(ULONG imClass, ULONG imCode)
{
  LONG index,pos;

  if (imClass == MENUPICK)
  {
    ShowTitle(ScrPtr,FALSE);
    for (;;)
     {
       SetAPen(&ScrPtr->RastPort,4);
       Move(&ScrPtr->RastPort,0,0);
       Draw(&ScrPtr->RastPort,WIDTH-1,0);
       if ((UWORD)imCode == MENUNULL)
         break;
       switch (MENUNUM(imCode))
       {
         case 0: switch (ITEMNUM(imCode))
                 {
                   case 0: ProjectAbout(); break;
                   case 1: EndAll=~0; break;
                 }
                 break;

         case 1: switch (ITEMNUM(imCode))
                 {
                   case 0: MakeDragon(); break;
                   case 1: OptUndoMove(); break;
                   case 2: OptUndoAll(); break;
                   case 3: OptLoadDragon(); break;
                   case 4: OptSaveDragon(); break;
                   case 5: OptMusic(); break;
                 }
                 break;
       }
       imCode=(ULONG)(ItemAddress(&MenuStrip[0],imCode))->NextSelect;
       if (EndAll)
         break;
     }
  }
  else
    if ((imClass==MOUSEBUTTONS) && (imCode==IECODE_LBUTTON) && (pos=CheckPos())>=0)
    {
      if (TwoSelected && (PiecePos2 == pos || PiecePos1 == pos))
      {
        index=(MAXCOUNT-PieceCount)/2; PieceCount-=2;
        NewDragon.PieceTable[PiecePos1] |= 0x80; NewDragon.UndoTable[index].pos1 = PiecePos1;
        NewDragon.PieceTable[PiecePos2] |= 0x80; NewDragon.UndoTable[index].pos2 = PiecePos2;
        ShowDragon();
      }
      else
      {
        if (OnePiece)
        {
          if (PiecePos1==pos)
            return;
          if (NewDragon.PieceTable[PiecePos1]==NewDragon.PieceTable[pos])
          {
            TwoSelected=1; PiecePos2=pos;
          }
          else
          {
            OnePiece=1; PiecePos1=pos;
          }
        }
        else
        {
          OnePiece=1; PiecePos1=pos;
        }
        DrawImage(WinPtr->RPort,&Images[NewDragon.PieceTable[pos]],(TwoSelected ? 291:3),85);
      }
    }
}

/* project function(s) */

VOID ProjectAbout()
{
  struct Window *wptr;
  struct RastPort *rp;
  struct About *p;
  int i,j;

  AboutWindow.Screen=ScrPtr;
  if ((wptr=OpenWindow(&AboutWindow)))
  {
    rp=wptr->RPort;
    SetRast(rp,5); SetBPen(rp,5);
    for (i=2; i!=0; i--)
     { for (p=&About[0],j=9; j!=0; p++,j--)
        {
          SetAPen(rp,p->pens[i-1]); Move(rp,p->x+i-1,p->y+i-1); Text(rp,&p->text[0],23);
        }
       SetDrMd(rp,JAM1);
     }
    for (i=2; i!=0; i--)
      DrawImage(rp,&Images[Random(30)+1],(i==2 ? 2:168),23);
    WaitPort(wptr->UserPort);
    CloseWindow(wptr);
  }
}

/* option functions */

VOID OptUndoMove()
{
  LONG index;

  if ((index=(MAXCOUNT-PieceCount)/2-1)>=0)
  {
    PieceCount+=2;
    NewDragon.PieceTable[NewDragon.UndoTable[index].pos1] &= 0x7f;
    NewDragon.PieceTable[NewDragon.UndoTable[index].pos2] &= 0x7f;
    ShowDragon();
  }
}

VOID OptUndoAll()
{
  char *p;
  short i;

  if (PieceCount!=MAXCOUNT)
  {
    PieceCount=MAXCOUNT;
    for (p=&NewDragon.PieceTable[0],i=288; i!=0; *p++ &= 0x7f,i--) ;
    ShowDragon();
  }
}

VOID OptLoadDragon()
{
  WORD header[2];
  BPTR file;

  if ((file=ReqFile(0)))
  {
    Read(file,(APTR)&header[0],sizeof(header));
    if (header[0]==0x4333)
    {
      PieceCount=header[1];
      Read(file,&NewDragon,sizeof(struct Dragon));
      ShowDragon();
    }
    Close(file);
  }
}

VOID OptSaveDragon()
{
  WORD header[2];
  BPTR file;

  if ((file=ReqFile(1)))
  {
    header[0]=0x4333; header[1]=PieceCount;
    Write(file,(APTR)&header[0],sizeof(header));
    Write(file,&NewDragon,sizeof(struct Dragon));
    Close(file);
  }
}

VOID OptMusic()
{
  struct IOAudio *areq;
   BYTE OnOff;
  UWORD cmd;

  if (AudioOpen)
  {
    OnOff=(MenuItems[7].Flags&CHECKED?~0:0);
    if (Music!=OnOff)
    {
      areq=&AudioIO;
      cmd=ADCMD_FINISH;
      if (OnOff)
      {
        areq->ioa_Request.io_Flags=IOF_QUICK|ADIOF_PERVOL;
        areq->ioa_Data=SampleBuf+104L;
        areq->ioa_Length=2*51984;
        areq->ioa_Period=428;
        areq->ioa_Volume=55;
        areq->ioa_Cycles=0;
        cmd=CMD_WRITE;
      }
      areq->ioa_Request.io_Command=cmd;
      BeginIO(&areq->ioa_Request);
      Music=~Music;
    }
  }
}

/* mouseclick valid ? */

LONG CheckPos()
{
  unsigned int x,y,z,d;
  int i;

  for (d=1,i=3; i>=0; d+=3,i--)
   {
     if ( ((y=(WinPtr->MouseY-d)/30)<6) && ((x=(WinPtr->MouseX-d)/25)<12)
          && (NewDragon.PieceTable[z=(6*12*i+12*y+x)]>0) )
     {
       if ( x==0 || x==11 || ((NewDragon.PieceTable[z-1]<=0 || NewDragon.PieceTable[z+1]<=0)
            && (i==3 || NewDragon.PieceTable[12*6+z]<=0)))
       {
         return z;
       }
       break;
     }
   }
  return -1;
}

/* create a new dragon */

VOID MakeDragon()
{
  int i,j,k,l,pos;
  UBYTE *p1,*p2;

  PieceCount=MAXCOUNT;

  for (p1=p2=&EntryTable[0],i=MAXCOUNT/4; i!=0; i--)
   {
     *p1++=i; *p1++=i; *p1++=i; *p1++=i;
   }
  for (p1=&NewDragon.PieceTable[0],j=-1,i=MAXCOUNT; i!=0; i--)
   {
     do
     {
      j++; k=(-8)&j; l=j-k; k=k>>3;
     } while (!(PosTable[k]&1<<l));
     pos=Random(i); p1[j]=p2[pos]; p2[pos]=p2[i-1];
   }
  ShowDragon();
}

/* random number generator */

LONG Random(ULONG Num)
{
  ULONG i,j;

  i=RandVal; j=i>>12; i^=j; j=i<<20; i^=j; RandVal=i; return (i%Num);
}

/* draw the dragon */

VOID ShowDragon()
{
  ULONG *p1;
  BYTE *p2;
  short n;
  int i,j,k,x,y,d;

  TwoSelected=OnePiece=0;

  for (p1=&BackGroundTab[0],i=4; i!=0; i--)
   {
     DrawImage(&RastPort,&Images[0],p1[0],p1[1]); p1++; p1++;
   }
  DrawBorder(&RastPort,&Border[0],0,0);
  for (p2=&NewDragon.PieceTable[0],d=10,i=4; i!=0; d-=3,i--)
    for (y=0,j=6; j!=0; y+=30,j--)
      for (x=0,k=12; k!=0; x+=25,k--)
        if ((n=*p2++)>0)
          DrawImage(&RastPort,&Images[n],x+d,y+d);
  PrintPieces();
  BltBitMapRastPort(&BitMap,0,0,WinPtr->RPort,0,0,WIDTH,HEIGHT-2,0xc0);
}

/* print remaining pieces */

VOID PrintPieces()
{
  int i;

  for (i=3; i!=0; i--)
   {
     SetAPen(&RastPort,APenTab[i]);
     RectFill(&RastPort,278-i,51-i,312+i,60+i);
   }
  sprintf(BlankStr,PieceFmt,PieceCount);
  PrintIText(&RastPort,&MoveIText,0,0);
}

/* select a file and open the file for read or write */

BPTR ReqFile(LONG Type)
{
  struct Library *ArpBase;
  struct ChinaReq *req;
  APTR oldwin,*wptr;
  BPTR file=0;

  wptr=&((struct Process *)FindTask(NULL))->pr_WindowPtr;
  oldwin=*wptr; *wptr=WinPtr; WinPtr->Flags |= RMBTRAP;
  if ((req=(struct ChinaReq *)AllocMem(sizeof(struct ChinaReq),MEMF_CLEAR)))
  {
    if ((ArpBase=OpenLibrary(ArpName,39L)))
    {
      req->FReq.fr_Hail   = (!Type ? LoadDragonStr : SaveDragonStr);
      req->FReq.fr_File   = &req->FileBuf;
      req->FReq.fr_Dir    = &req->DirBuf;
      req->FReq.fr_Window = WinPtr;
      req->FReq.fr_Flags  = 0x28; /* DoColor && NewWindFunc */
      req->FReq.fr_res1   = 1; /* LongPath */ 
      req->FReq.fr_Func   = (VOID (*)())ChangeFunc;
      if (FileRequest(ArpBase,&req->FReq))
      {
        TackOn(ArpBase,&req->DirBuf[0],&req->FileBuf[0]);
        file=ArpOpen(ArpBase,&req->DirBuf[0],MODE_OLDFILE+Type);
      }
      CloseLibrary(ArpBase);
    }
    FreeMem((APTR)req,sizeof(struct ChinaReq));
  }
  WinPtr->Flags &= ~RMBTRAP; *wptr=oldwin;
  return file;
}

VOID ChangeFunc()
{
  register struct NewWindow *new asm("a0");

  new->LeftEdge=10; new->TopEdge=10;
}

/************************************************************************
*									*
* end of China Challenge III - the C Version				*
*									*
************************************************************************/
