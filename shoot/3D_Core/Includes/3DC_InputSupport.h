/***************************************/
/*** Input handler Support Functions ***/
/***   Copyright(c) J.Gregory 1995+  ***/
/***     Version 1.03   12/03/98     ***/
/***************************************/

/****** Initialise Input Handler ******/

/* Returns -1 on failure */

WORD C3D_InitIHandler(void) {

  C3D_FreeIHandler();                 /* Free if allready allocated */
   
  InPort = CreatePort(NULL,NULL);     /* Create message port for IO */
  if(!InPort) {
    printf("Failed to open port for IO\n");
    return(-1);
    }
   
  IHandler = AllocVec(sizeof(struct Interrupt),MEMF_CLEAR | MEMF_PUBLIC);
  if(!IHandler) {
    C3D_FreeIHandler();
    printf("Failed to allocate IHandler memory\n");
    return(-1);
    } 
   
  InReq=(struct IOStdReq *) CreateExtIO(InPort,sizeof(struct IOStdReq));
  if(!InReq) {
    C3D_FreeIHandler();
    printf("Failed to create IO request\n");
    return(-1);
    }

  DevStat = OpenDevice("input.device",NULL,(struct IORequest *) InReq, NULL);
  if(DevStat) {
    C3D_FreeIHandler();
    printf("Failed to open unput.device\n");
    return(-1);
    }

  IHandler->is_Code = ASM_InputHandler;    /* Pointer to ASM handler */
  IHandler->is_Data = C3D_Keys;            /* Pointer to key buffer  */
  IHandler->is_Node.ln_Pri=100;            /* Pri > intuition        */
  IHandler->is_Node.ln_Name="3DC_Handler"; /* Input handler name     */
   
  InReq->io_Data    = (APTR) IHandler;     /* IO data is handler ptr */
  InReq->io_Command = IND_ADDHANDLER;      /* Command = ADD handler  */
  DoIO((struct IORequest *) InReq);        /* Install handler        */

  return(0);                               /* return success */
  }

/****** Remove input device handler & free resources ******/

void C3D_FreeIHandler(void) {

  if(!DevStat) {
    InReq->io_Data    = (APTR) IHandler;     /* IO data is handler ptr */
    InReq->io_Command = IND_REMHANDLER;      /* CMD = remove handler   */
    DoIO((struct IORequest *) InReq);        /* Remove input handler   */ 
    CloseDevice((struct IORequest *) InReq); /* Close input device     */
    DevStat = -1;                            /* Flag device as closed  */     
    }

  if(InReq)     DeleteExtIO((struct IORequest *) InReq);
  if(IHandler)  FreeVec(IHandler);
  if(InPort)    DeletePort(InPort);

  InReq    = NULL;                           /* Clear Pointers */
  IHandler = NULL;
  InPort   = NULL;
  }

void C3D_EnableIHandler(void) {
   C3D_Keys[0] = 0;                /* Clear key status array */
   C3D_Keys[1] = 0;
   C3D_Keys[2] = 0;
   C3D_Keys[3] = 0;
   
   C3D_Keys[4] |= 1;               /* Set enable handler bit */
   }

void C3D_DissableIHandler(void) {
   C3D_Keys[4] &= 0xFFFFFFFE;      /* Clear enable handler bit */
   }


/****** Return Last Keydown Code ******/

/* Note clear last key once read, 0 is non key press */

WORD C3D_LastKey(void) {
  WORD key;
  BYTE *ptr;
  
  ptr = (BYTE *) &C3D_Keys[4];
  key = ptr[0];
  ptr[0] = 0;
  
  return key;
  }


/****** Freeze Game & Display Menu ******/

/* The menu options are contained in one string and
   each option must be terminated with a '\n'
   
   NOTE - A maximum of 8 options will be displayed correctly
          (i.e. title + 7 items)
   keys = string of key codes allowable (Null terminated
   bgnd = image ID to use as background for menu (0=black)
    cs1 = title (item 1) colour shift
    cs2 = other items colour shift
      
   Returns item number selected ir 0 if "ESC" hit
*/

WORD C3D_ActionMenu(BYTE *itemstr,BYTE *keys,WORD bgnd,WORD cs1,WORD cs2) {
  LONG vbold = VBD.Count;
  WORD items=0,n=0,m,x,y,ret=0;
  BYTE *item[]={NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL};
  struct ChnkImg *chnk=NULL;  

  item[0]=itemstr; items++;               /* Parse Options String */

  while(itemstr[n] != 0 && items<9) {
    if(itemstr[n]=='\n') {
      itemstr[n]=0;
      item[items++]=itemstr+n+1;
      }
    n++;
    }

  if(bgnd) chnk=C3D_FindChnkImg(bgnd);    /* Display Backdrop */
    
  if(!chnk) ASM_FillMemLong(ChunkyScr,(WIDTH*HEIGHT)>>2,0L);
  else ASM_DrawClipChunky(chnk,ChunkyTab,0,0,1L);    


  for(n=0;n<items;n++) {                  /* Display Option Strings */
    x=(WIDTH-(strlen(item[n])*6))>>1;
    y=(n*11)+20;
    if(n==0) m=cs1; else m=cs2;
    C3D_Text6x9(item[n],x,y,m);
    }

  ASM_ConvScreen(ChunkyScr,C3D_ActPlane0);
  C3D_SwapView();
  C3D_LastKey();                          /* Clear Last Key Buffer */

  while(!ret) {                           /* Wait for Key Press */
    Delay(5);
    ret = C3D_LastKey();

    n=0; m=0;                             /* Filter valid keypresses */
    while(keys[n]!=0) {
      if(keys[n]==ret) m=ret;
      n++;
      }
    ret=m;
    }

  n=1; m=0;                               /* Repair Options String */
  while(n<items) {
    if(itemstr[m]==0) {
      itemstr[m]='\n';
      n++;
      }
    m++;
    }
  VBD.Count = vbold;
  C3D_LastKey();                          /* Clear Last Key Buffer */

  return ret;
  }
