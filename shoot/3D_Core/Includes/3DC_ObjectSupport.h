/***************************************/
/***    3D Sprite Object Support     ***/
/*** Copyright (c) J.Gregory 1995-98 ***/
/***      Version 1.57  14/03/98     ***/
/***************************************/


/**************************************/
/*** Load a Object Definition Group ***/
/**************************************/

/* Returns 0 on success
           1 on other ObjDefs currently loaded
          -1 on load failure or wrong type
*/

WORD C3D_LoadObjDefs(UBYTE *file) {
   BPTR handle = NULL;
   LONG len,len1;
   WORD ret;
   struct DefHeader1 header;

   if(FirstObjDef) {
       printf("Must free old ObjDefs before loading new\n");
       return 1;
       };

   handle = Open(file,MODE_OLDFILE);           /*** Open ObjDef file ***/
   if(!handle) {
       printf("Could not open Object Definitions file\n");
       return -1;
       }

   len = Read(handle,&header,DEFHEAD1SIZE);     /*** Read file header ***/
   if(len != DEFHEAD1SIZE) {
       Close(handle);
       printf("Could not read Object Defintions file\n");
       return -1;
       }
       
   if(header.Magic != OBJDEFMAGIC) {           /*** Check file Type ***/
       Close(handle);
       printf("File is not and Object Definition file\n");
       return -1;
       } 

   len1 = OBJDEFSIZE * header.Count;           /*** Calc ram required ***/
   
   FirstObjDef = AllocVec(len1,MEMF_PUBLIC);   /*** Allocate memory ***/
   if(!FirstObjDef) {
       Close(handle);
       printf("Could not allocate RAM to ObjDefs\n"); 
       return -1;
       }

   len = Read(handle,FirstObjDef,len1);        /*** Load ObjDef's ***/  
   if(len != len1) {
       Close(handle);
       C3D_FreeObjDefs();
       printf("Object Definitions file truncated\n");
       return -1;
       }

   ObjDefCount = header.Count;
   ret = C3D_FixObjDefImages(ObjDefCount);

   Close(handle);
   if(ret == -1) C3D_FreeObjDefs();
   return ret;
   }

/*************************************/
/*** Free currently loaded ObjDefs ***/
/*************************************/

void C3D_FreeObjDefs(void) {
   if(FirstObjDef) {
       FreeVec(FirstObjDef);
       FirstObjDef = NULL;
       ObjDefCount = 0;
       }
   }

/***********************************************/
/*** Resolve ObjDEf ChnkImg ID's to Pointers ***/
/***********************************************/

/* Returns 0 on success -1 on failure */

/* If wall type image found flag ObjDef as wall ObjDef */

WORD C3D_FixObjDefImages(LONG defcount) {
  WORD n,m;
  struct ObjDef   *od;
  struct ChnkImg  *ci;

  for(n=0;n<defcount;n++) {                     /* Loop through ObjDefs */
    od = &FirstObjDef[n];
       
    if(od->Frames < 1 || od->Frames > 37) {
      printf("ObjDef has invalid frame count\n");
      return -1;
      }
       
    for(m=0;m<32;m++) {
     if(od->ImgID[m] != 0) {
       ci = C3D_FindChnkImg(od->ImgID[m]); 
         if(!ci) {
           printf("Failed to resolve ID %d to image.\n",od->ImgID[m]);
           return -1;
           }
         od->ImgID[m] = (ULONG) ci;
         if(ci->Flags & WALLIMG_TYPE) od->Flags |= WALLIMG_TYPE;
         }
       }
     }

   return 0;
   }

/*******************************************************/
/*** Allocate memory etc related to object resources ***/
/*******************************************************/

/* Returns -1 on allocation.load error
           -2 if allready loaded/allocated
         or 0 on success

   NOTE - Also loads trig SIN,COS & Heading tables 
*/

WORD C3D_InitObjects(void) {
  BPTR handle = NULL;
  LONG length;

  /*** Check that resources not allready allocated ***/

  if(SinCosTab) {
    printf("SinCos.Tables Allready Loaded !\n");
    return -2; 
    }

  if(HeadingTab) {
    printf("Headinf.Table Allready loaded !\n");
    return -2;
    }

  if(WObject) {
    printf("WObject Array allready allocated\n");
    return -2;
    }
       
  if(ActObj) {
    printf("ActObj Array allready allocated\n");
    return -2;
    }

  if(ColArea) {
    printf("ColArea Array allready allocated\n");
    return -2;
    }

  if(DepthList) {
    printf("DepthList allready allocated\n");
    return -2;
    }

  if(LOSTab) {
    printf("LOS Sort Table allready allocated\n");
    return -2;
    }

  /*** Allocate memory & load trig tables ***/
  
  SinCosTab = AllocVec(TRIGTABSIZE, MEMF_PUBLIC | MEMF_CLEAR);
  if(SinCosTab == NULL) {
    printf("Could not allocate RAM for Trig tables\n");
    return -1;
    }

  handle = Open(TRIGTABNAME,MODE_OLDFILE);
  if(handle == NULL) {
    C3D_FreeObjects();
    printf("Failed to Open %s\n",TRIGTABNAME);
    return -1;
    }
       
  length = Read(handle,SinCosTab,TRIGTABSIZE);
  if(length != TRIGTABSIZE) {
    Close(handle);
    C3D_FreeObjects();
    printf("%s appears to be truncated !\n",TRIGTABNAME);
    return -1;
    }
       
  Close(handle);

  /*** Allocate Memory & load headings table ***/

  HeadingTab = AllocVec(HEADINGTABSIZE, MEMF_PUBLIC | MEMF_CLEAR);
  if(HeadingTab == NULL) {
    C3D_FreeObjects();
    printf("Could not allocate RAM for headings table!\n");
    return -1;
    }

  handle = Open(HEADINGTABNAME,MODE_OLDFILE);
  if(handle == NULL) {
    C3D_FreeObjects();
    printf("Failed to open %s\n",HEADINGTABNAME);
    return -1;
    }

  length = Read(handle,HeadingTab,HEADINGTABSIZE);
  if(length != HEADINGTABSIZE) {
    Close(handle);
    C3D_FreeObjects();
    printf("%s appears to be truncated !\n", HEADINGTABNAME);
    return -1;
    }

  Close(handle);

  /*** Allocate Memory & load tangents table ***/
  
  HP_TanTab = AllocVec(TANTABSIZE, MEMF_PUBLIC | MEMF_CLEAR);
  if(HP_TanTab == NULL) {
    C3D_FreeObjects();
    printf("Could not allocate RAM for tangents table!\n");
    return -1;
    }
  HP_CosTab = (WORD *) (HP_TanTab + 1024L);

  handle = Open(TANTABNAME,MODE_OLDFILE);
  if(handle == NULL) {
    C3D_FreeObjects();
    printf("Failed to open %s\n", TANTABNAME);
    return -1;
    }

  length = Read(handle,HP_TanTab,TANTABSIZE);
  if(length != TANTABSIZE) {
    Close(handle);
    C3D_FreeObjects();
    printf("%s appears to be truncated !\n", TANTABNAME);
    return -1;
    }

  Close(handle);

  /*** Allocate memory for WObject, ActObj ColObj arrays ***/
   
  WObject = AllocVec((MAXWOBJECT+1)*WOBJECTSIZE, MEMF_PUBLIC | MEMF_CLEAR);
  if(!WObject) {
    C3D_FreeObjects();
    printf("Could not allocate RAM for Object array\n");
    return -1;
    }
       
  ActObj = AllocVec((MAXACTOBJ+1)*ACTOBJSIZE, MEMF_PUBLIC | MEMF_CLEAR);
  if(!ActObj) {
    C3D_FreeObjects();    
    printf("Could not allocate RAM for Active Object array\n");
    return -1;
    }      

  ColArea = AllocVec((MAXCOLAREA+1)*COLAREASIZE, MEMF_PUBLIC | MEMF_CLEAR);
  if(!ColArea) {
    C3D_FreeObjects();
    printf("Could not allocate RAM for Collision Area array\n");
    return -1;
    }

  C3D_ClearObjects();     /* Init WObject,ColObj & ActObj arrays */

  /*** Allocate memory for DepthEntry array ***/
   
  DepthList = AllocVec(MAXACTOBJ * DEPENTSIZE, MEMF_PUBLIC | MEMF_CLEAR);
  if(!DepthList) {
    C3D_FreeObjects();
    printf("Could not allocate RAM for depth list\n");
    return -1;
    }

  /*** Allocate memory for LOS depth sort table ***/
  
  LOSTab = AllocVec(LOSTABSIZE, MEMF_PUBLIC | MEMF_CLEAR);
  if(!LOSTab) {
    C3D_FreeObjects();
    printf("Could not allocate RAM for LOS Sort Table\n");
    return -1;
    }

  /*** Allocate Collision Work Space Data Block ***/

  ColWork = AllocVec(sizeof(struct ColWork), MEMF_PUBLIC | MEMF_CLEAR);
  if(!ColWork) {
    C3D_FreeObjects();
    printf("Could not allocate RAM for ColWork\n");
    return -1;
    } 

  ColWork->XMin      = WORLDXMIN;   /* Set World Collision Boundst    */
  ColWork->XMax      = WORLDXMAX;
  ColWork->YMin      = WORLDYMIN;
  ColWork->YMax      = WORLDYMAX;
  ColWork->HMin      = WORLDHMIN;
  ColWork->HMax      = WORLDHMAX;      

  return 0;
  }


/*************************************************/
/*** Free Memory Allocated to Object Resources ***/
/*************************************************/

void C3D_FreeObjects(void) {

  C3D_ClearObjects();     /* Init WObject,ColObj & ActObj arrays */

  if(SinCosTab) {
    FreeVec(SinCosTab);
    SinCosTab = NULL;
    }

  if(HeadingTab) {
    FreeVec(HeadingTab);
    HeadingTab = NULL;
    }

  if(HP_TanTab) {
    FreeVec(HP_TanTab);
    HP_TanTab = NULL;
    HP_CosTab = NULL;
    }

  if(WObject) {
    FreeVec(WObject);
    WObject = NULL;
    }

  if(ActObj) {
    FreeVec(ActObj);
    ActObj = NULL;
    }

  if(ColArea) {
    FreeVec(ColArea);
    ColArea = NULL;
    }

  if(DepthList) {
    FreeVec(DepthList);
    DepthList = NULL;
    }

  if(LOSTab) {
    FreeVec(LOSTab);
    LOSTab = NULL;
    }

  if(ColWork) {
    FreeVec(ColWork);
    ColWork = NULL;
    }

  if(Binder) C3D_FreeBinders();

  C3D_FreeSPTables();
  }

/*************************************/
/*** Clear all Objects from Arrays ***/
/*************************************/

/* Clear WObject & ActObj Arrays of all important refs 

NOTE - MovFunc, ColFunc & Data pointers must be cleared
       when object free'd as some functions may rely on this.
       Adds all WObjects to free list & NULL's used list.
*/

void C3D_ClearObjects(void) {
  LONG    n;
  struct  WObject *obj  = WObject;
  struct  WObject *prev = NULL;
  struct  ActObj  *aob  = ActObj;
  struct  ColArea *ca   = ColArea;

  if(obj) {
    for(n=MAXWOBJECT-1;n>=0;n--) {
      obj=&WObject[n];            /* Get address of current WObject */
      obj->Next    = prev;        /* Set next free WObject pointer  */
      obj->Prev    = NULL;        /* Free list has no back pointer  */
      obj->Size    = 0;           /* Mark WObject as free (size=0)  */
      obj->ActObj  = 0xFFFF;      /* Set to inactive (not visible)  */
      obj->Speed   = 0;           /* Clear speed setting            */
      obj->MovFunc = NULL;        /* Clear handler vectors          */ 
      obj->ColFunc = NULL;
      prev=obj;      
      if(obj->Data) {             /* Clear extended data pointer    */
        FreeVec(obj->Data);
        obj->Data = NULL;
        }
      }
    FreeWObHead=WObject;          /* Set First free WObject         */
    UsedWObHead=NULL;             /* Set used object list to empty  */
    }

  if(aob) {
    for(n=0;n<MAXACTOBJ;n++) {
      aob->Obj = NULL;            /* Free if allocated      */
      aob++;                      /* Move on to next ActObj */
      }
    }

  if(ca) {
    for(n=0;n<MAXCOLAREA;n++) {
      ca->Wx = 0;                 /* Free ColArea (Wx=0)         */
      ca++;                       /* Move on to next ColArea     */     
      }
    }

  FlrObjDensity = 0;              /* Dissable FloorObj System           */
  FirstFlrWOb   = NULL;           /* Clear FlrObj reserved area ptr     */
  FirstMapWOb   = NULL;           /* Clear First Map WObject ptr        */
  FirstColWOb   = NULL;           /* Clear First Collision obj ptr      */
  LastNMovWOb   = NULL;           /* Clear last non movable obj ptr     */
  LastPermAct   = -1;             /* Clear Last Permanent Active ActObj */

  C3D_FreeSPTables();             /* Free Space Partitioning Tables     */
  }

/*********************************************************/
/*** Find first free WObject struct in array/link list ***/
/*********************************************************/

/* Returns 0xFFFF on failure, otherwise index of free object

NOTE - WObject designated as free by 0 size & in a link list
       of index values stored in the Next  field
*/

UWORD C3D_FindFreeObject(void) {
  UWORD idx;
  struct WObject *tobj;

  if(FreeWObHead==NULL) return 0xFFFF;

  tobj = UsedWObHead;

  if(UsedWObHead)
      UsedWObHead->Prev = FreeWObHead;    /* Set prev on old 1st item    */
  UsedWObHead=FreeWObHead;                /* Set used head to new used   */

  idx = FreeWObHead-WObject;              /* Get current head of list    */
  FreeWObHead = FreeWObHead->Next;        /* Set new head of free list   */

  UsedWObHead->Next = tobj;
  UsedWObHead->Prev = NULL;

  WObject[idx].IntID = NextWobID++;       /* Alloc WObject an ID         */

  return idx;
  }

/**********************************************/
/*** Find first free actobj struct in array ***/
/**********************************************/

/* Returns 0xFFFF on failure, otherwise index of free actobj */

UWORD C3D_FindFreeActObj(void) {   
  UWORD n=0,i=0xFFFF;
  struct ActObj *aob = ActObj;
   
  if(aob) {
    while(n<MAXACTOBJ && i==0xFFFF) {
      if(aob->Obj == NULL) i=n;
      aob++;
      n++;
      }
    }
   
  return i;
  }


/************************************************/
/*** Find First free Collsion Area in array ***/
/************************************************/

/* Return 0xFFFF on failure, otherwise index of free ColArea */

UWORD C3D_FindFreeColArea(void) {
  UWORD n=0,i=0xFFFF;
  struct ColArea *ca = ColArea;

  if(ca) {
    while(n<MAXCOLAREA && i==0xFFFF) {
      if(ca->Wx <= 0) i=n;
      ca++;
      n++;
      }
    }

  return i;
  }

/****************************************/
/*** Find Specified Object Definition ***/
/****************************************/ 

/* returns NULL on failure, otherwise ObjDEf pointer */

struct ObjDef *C3D_FindObjDef(ULONG ID) {

   struct ObjDef *odf = FirstObjDef;
   ULONG c = 0;
   
   while(c < ObjDefCount && odf->ID != ID) {   
       c++;
       odf++;
       }

   if(c == ObjDefCount) odf = NULL;
   
   return odf;
   }

/*****************************/
/*** Free ActObj Specified ***/
/*****************************/

/* Params - index - index of ActObj to free */

void C3D_FreeActObj(UWORD index) {
   
   struct ActObj *aob = &ActObj[index];
   
   if(aob->Obj != NULL) {
       aob->Obj->ActObj = 0xFFFF;   /* Clear link to ActObj from WObject */
       aob->Obj=NULL;               /* Clear link to WObject from ActObj */
       }
   }

/***********************************/
/*** Free World Object Specified ***/
/***********************************/

/* Params - index   - index of WObject to free
            
   NOTE - If using pointer set index to 0xFFFF
*/

void C3D_FreeWObject(UWORD index, struct WObject *obj ) {

  if(index==0xFFFF) {
    index = obj-WObject;
    }
  else {
    obj = &WObject[index];
    }
   
  if(obj->ActObj != 0xFFFF) {
    ActObj[obj->ActObj].Obj = NULL;   /* Clr link from ActObj to WObject */
    obj->ActObj = 0xFFFF;             /* Clr link from WObject to ActObj */
    }

  obj->Size    = 0;                   /* Mark WObject as free (size=0)   */
  obj->ActObj  = 0xFFFF;              /* Set to inactive (not visible)   */
  obj->Speed   = 0;                   /* Clear speed setting             */
  obj->MovFunc = NULL;                /* Clear handler vectors           */
  obj->ColFunc = NULL;
  if(obj->Data) {                     /* Free extended data memory       */
    FreeVec(obj->Data);
    obj->Data = NULL;
    }

  if(obj->Prev!=NULL) obj->Prev->Next=obj->Next; /* Unlink from used list*/
  if(obj->Next!=NULL) obj->Next->Prev=obj->Prev;
  if(obj==UsedWObHead) UsedWObHead=obj->Next;
    
  obj->Next    = FreeWObHead;         /* Set next free item pointer      */
  obj->Prev    = NULL;
  FreeWObHead  = obj;                 /* Make object new head of list    */
  }

/******************************/
/*** Free ColArea specified ***/
/******************************/

/* Params - index - index of ColArea to free */

void C3D_FreeColArea(UWORD index) {

  struct ColArea *ca = &ColArea[index];

  ca->Wx = -1;           /* -1 as 0 = end of ColObj array    */
  }

/******************************/
/*** Fix Object ObjDef ID's ***/
/******************************/

/* Returns -1 on failure or 0 on success */

WORD C3D_FixWObjID(struct WObject *obj) {
   
   WORD    n;
   ULONG   id,fix;
   
   for(n=0;n<4;n++) {
       id = obj->ObjDef[n];
       if(id != 0) {
           fix = (ULONG) C3D_FindObjDef(id);
           if(fix == NULL) {
               printf("Could not resolve ObjDef ID %ld\n",id);
               return -1;
               }
           obj->ObjDef[n] = fix;
           }
       }
   return 0;
   }

/***************************************/
/**** Load WObject/ColArea Map File ****/
/***************************************/

/* NOTE - Internal co-ords multiplied up for precision */ 

/* return -1 on error otherwise 0 */

WORD C3D_LoadWobjMap(char *mapfile) {
  BPTR handle = NULL;
  LONG len=0;  
  WORD err=-1,ret;
  UWORD n,m,idx,colflag;
  struct DefHeader2  head;
  struct DiskWObj    dwob;
  struct WObject     *wob;
  struct ColArea     *ca;
  struct Binder      *bind;
  struct HandlerInfo *hinfo;

  colflag = 0;
  FirstMapWOb = NULL;
  FirstColWOb = NULL;
  LastNMovWOb = NULL;
          
  handle = Open(mapfile,MODE_OLDFILE);             /* Open Map File      */
  if(handle != NULL) {
    len=Read(handle, &head, DEFHEAD2SIZE);         /* Read file Header   */
    if(len == DEFHEAD2SIZE) {            
      if(head.Magic == WOBJMAGIC) {                /* Check file MAGIC   */

        for(n=0;n<head.Count1;n++) {               /* Get all DiskWObj's */
          len=Read(handle,&dwob,DISKWOBJSIZE);     /* Read each DiskWObj */
          if(len!=DISKWOBJSIZE) {
            printf("WObject Read Failed from file:%s\n",mapfile);
            break;
            }

          if(dwob.ObID >= AHDLRLOID && dwob.ObID <= AHDLRHIID) {

            /* Skip as dwob is an active handler binding object */

            bind = AllocVec(sizeof(struct Binder), MEMF_PUBLIC | MEMF_CLEAR);
            if(!bind) {
              printf("Handler Binding Object Memory Allocation Failure!!\n");
              n = head.Count1+1;                 /* Force Load Count Error */
              break;
              }

            bind->Next = Binder;             /* Link into temp binder list */
            Binder = bind;

            bind->ID       = dwob.ObID;
            bind->Wx       = (dwob.Wx    <<MAPSCALESHIFT);
            bind->Wy       = (dwob.Wy    <<MAPSCALESHIFT);
            bind->Hgt      = (dwob.Height<<MAPSCALESHIFT);
            bind->Head     = dwob.Heading;
            bind->Size     = dwob.Size;
            bind->Radius   = (dwob.Radius<<MAPSCALESHIFT);
            bind->ObjDef[0] = dwob.ObjDef[0];
            bind->ObjDef[1] = dwob.ObjDef[1];
            bind->ObjDef[2] = dwob.ObjDef[2];
            bind->ObjDef[3] = dwob.ObjDef[3];
            }
          else {
            idx=C3D_FindFreeObject();                /* Get next WObject   */
            if(idx==0xFFFF) {
              printf("Load Map failed, no free WObject entry\n");
              n = head.Count1+1;                 /* Force Load Count Error */
              break;
              }          

            wob=&WObject[idx];                 /* Copy DiskWObj to WObject */
            wob->Wx        = (dwob.Wx    <<MAPSCALESHIFT);
            wob->Wy        = (dwob.Wy    <<MAPSCALESHIFT);
            wob->Height    = (dwob.Height<<MAPSCALESHIFT);
            wob->Heading   = dwob.Heading;
            wob->Size      = dwob.Size;
            wob->Radius    = (dwob.Radius<<MAPSCALESHIFT);
            wob->Speed     = (dwob.Speed <<MAPSCALESHIFT);
            wob->ObjDef[0] = dwob.ObjDef[0];
            wob->ObjDef[1] = dwob.ObjDef[1];
            wob->ObjDef[2] = dwob.ObjDef[2];
            wob->ObjDef[3] = dwob.ObjDef[3];
            wob->Speed     = 0;
            wob->Flags     = 0;
            wob->ID        = dwob.ObID;
            wob->Data      = NULL;
            wob->MovFunc   = NULL;

            /* Attach Passive Handler if Required */

            wob->ColFunc = NULL;

            if(wob->ID >= PHDLRLOID && wob->ID <= PHDLRHIID) {
              hinfo = C3D_FindHInfo(wob->ID);
              if(hinfo) wob->ColFunc = hinfo->Handler; 
              }


            ret=C3D_FixWObjID(wob);             /* Fix ObjDef ID's to Ptrs */
            if(ret==-1) break;
          
            if(wob->Radius>0 && !colflag) {     /* Record if 1st Col Wobj  */
              FirstColWOb=wob;
              ColWork->WObject = wob;
              colflag=1;
              }
          
            if(!FirstMapWOb) FirstMapWOb = wob; /* Store First Map WObject */
            }
          }

        LastNMovWOb = wob;           /* Record last map (non move object */
                 
        for(m=0;m<head.Count2;m++) {
          idx=C3D_FindFreeColArea();
          if(idx==0xFFFF) {
            printf("Load Map failed, no free ColArea entry\n");
            break;
            }

          ca=&ColArea[idx];
          
          len=Read(handle,ca,COLAREASIZE);
          if(len!=COLAREASIZE) {
            printf("ColArea Read Failed from file:%s\n",mapfile);
            break;
            }

          ca->Wx  = (ca->Wx  << MAPSCALESHIFT)+1;
          ca->Wy  = (ca->Wy  << MAPSCALESHIFT)+1;
          ca->Wx2 = (ca->Wx2 << MAPSCALESHIFT)+ca->Wx;
          ca->Wy2 = (ca->Wy2 << MAPSCALESHIFT)+ca->Wy;
          }

        if(n==head.Count1 && m==head.Count2) err=0;  /* If all done set Success */
        }
      else printf("File:%s is not a valid map\n",mapfile);
      }
    else printf("Failed to read header of map:%s\n",mapfile);
    Close(handle);
    }
  else printf("Failed to open map:%s\n",mapfile);

  if(err) printf("Did not load complete Map:%s\n",mapfile);
  else {
    ColWork->WObject = LastNMovWOb;
    err=C3D_BuildSPTables();
    if(!err) err = C3D_BindBinders();
    }
    
  return err;
  }

/****************************************/
/*** Setup ActObj's ChnkImg structure ***/
/****************************************/

/* Params - actobj - active object index
          - view   - view or anim frame to use

   Returns -1 on failure or 0 on success
 
   NOTE - Uses current Active ObjDef (ActDef)   
*/

WORD C3D_SetObjImage(UWORD aob, UWORD view) {
  struct ChnkImg *cimg;
  struct ChnkWork *cw;
  UWORD idx=31;

  switch (ActObj[aob].ActDef->Views) {
    case 1:                               /* Single view Object     */
      idx = view;
      ActObj[aob].Frame = view;           /* Record frame on ActObj */
      break;
    case 8:                               /* 8 View Object          */
      idx = (ActObj[aob].Frame<<3)+view;
      break;
    case 16:                              /* 16 View Object         */
      idx = (ActObj[aob].Frame<<4)+view;
      break;
    }
      
  cimg = (struct ChnkImg *) 
    ActObj[aob].ActDef->ImgID[idx];       /* Get pointer to image */   

  if(cimg == NULL) {
    printf("ActObj %u Index %u - image not found\n",aob,idx);
    return -1;
    }

  cw = &ActObj[aob].Chky;           /* Get pointer to ChnkWork          */
  if(cimg->Flags & WALLIMG_TYPE)    /* If Wall object set Virtual Width */
       cw->PxWidth = SLIVERWIDTH;
  else cw->PxWidth = cimg->PxWidth; /* Else use images base width       */

  cw->ID       = cimg->ID;          /* Copy key details from ChnkImg    */
  cw->PxHeight = cimg->PxHeight;
  cw->Size     = cimg->Size;
  cw->XCentre  = 0;                 /* Set X,Y & Scale required         */
  cw->YCentre  = 0;
  cw->Scale    = 0;
  cw->ScWidth  = 0;                 /* Init Scalers work/return vars    */
  cw->ScHeight = 0;
  cw->ScaledX  = 0;
  cw->ScaledY  = 0;
  cw->Data     = cimg->Data;        /* Pointer to Chunky sprite data    */
  cw->LineTab  = cimg->LineTab;     /* Pointer to images line table     */

  return 0;
  }


/*********************************************/
/**** Use Space Partition Tables to Check ****/
/**** If Objects need to be made Active   ****/
/*********************************************/

/* Params  - x,y  - Viewpoint Co-ords
             brad - Block radius (1 block=65536 world units) 

   Returns - -1 on error, otherwise 0
*/

WORD C3D_CheckWObjRange(LONG x, LONG y, LONG brad) {
  LONG  bx,by,xstart,xend;
  LONG  ystart,yend,bwid,bhgt;
  LONG  zone,zstart,zend,n;
  UWORD res;
  struct WObject *wob;
  
  bx = x>>16;                               /* Reduce to block co-ords    */
  by = y>>16;

  xstart = bx-brad;                         /* Build X,Y start end blocks */
  ystart = by-brad;
  xend   = bx+brad;
  yend   = by+brad;
                                            /* De-alloc distant objects   */

  C3D_CheckActiveWOb(xstart<<16,xend<<16,ystart<<16,yend<<16);  
  
  bwid   = (brad<<1)+1;                     /* Calc initial block width   */
  bhgt   = (brad<<1)+1;                     /* and height                 */

  if(xstart < 0) {                          /* Clip X Starting Block      */
    bwid += xstart;
    xstart = 0;
    }

  if(xend >= SPMAXBLOCKS) {                 /* Clip X ending block        */
    bwid = SPMAXBLOCKS-xstart;
    xend = SPMAXBLOCKS-1;
    }

  if(ystart < 0) {                          /* Clip Y Starting Block      */
    bhgt += ystart;
    ystart = 0;
    }

  if(yend >= SPMAXBLOCKS) {                 /* Clip Y ending block        */
    bhgt = SPMAXBLOCKS-ystart;
    yend = SPMAXBLOCKS-1;
    }

  if(bwid<=0 || bhgt<=0) return 0;          /* If not in block map return */

  for(bx=xstart; bx<=xend; bx++) {          /* X Block Loop               */

    for(by=ystart; by<=yend; by++) {        /* Y Block Loop               */
      zone = (by<<7)+bx;                    /* Calculate zone (0->16384)  */

      zstart = SPIndexTab[zone];            /* Get index of 1st WOb ptr   */
      zend   = SPIndexTab[zone+1];                /* Get idx of next zones 1st WOb */

      for(n=zstart; n<zend; n++) {                /* Scan WObjects in Zone         */
        wob = (struct WObject *) SPWObTab[n];
        if(wob->ActObj == 0xFFFF) {               /* If inactive sould be active   */
          res = C3D_AllocAct(wob,0,0);            /* Alloc ActObj & set Vx & Vy    */
          if(res) {
            printf("Failed to make object active\n");
            return -1;
            }    
          }    
        }
      }
    }

  return 0;
  }

/******************************************************&&&&******/
/**** Scan Active Objects & Moveable Objects & Alloc/DeAlloc ****/
/****************************************************************/

/* Params - xl,xh,yl,yh - Bounding box for valid active objects */

void C3D_CheckActiveWOb(LONG xl, LONG xh, LONG yl, LONG yh) {
  LONG n;
  struct ActObj *aob;
  struct WObject *wob;
  
  wob=LastNMovWOb->Prev;      /* Start after last non moveable WObject */ 

  while(wob) {
    if(wob->ActObj==0xFFFF) {
      if(wob->Wx >= xl &&
         wob->Wx <= xh &&
         wob->Wy >= yl &&
         wob->Wy <= yh) C3D_AllocAct(wob,0,0);                  
      }  
    wob = wob->Prev;
    }


  aob=&ActObj[LastPermAct+1]; /* Start after last always active ActObj */
    
  for(n=LastPermAct+1;n<MAXACTOBJ;n++) {
    if(aob->Obj) {
      if(aob->Obj->Wx < xl ||
         aob->Obj->Wx > xh ||
         aob->Obj->Wy < yl ||
         aob->Obj->Wy > yh) C3D_FreeActObj(aob-ActObj);          
      }
    aob++;
    }  
  }


/***********************************************/
/*** Link WObject to a free ActObj structure ***/
/***********************************************/

/* Params - obj   - Pointer to WObject 
            obdf  - Object definition number to use (0-3)
            frame - Initial frame number to use (0-3)
            
   Returns -1 on failure or 0 on success
*/

WORD C3D_AllocAct(struct WObject *obj, UWORD obdf, UWORD frame) {
   
   UWORD aob;

   /*** Attempt to find free ActObj ***/
   
   aob = C3D_FindFreeActObj();
   if(aob == 0xFFFF) {
       printf("No more free ActObj space\n");
       return -1;
       }
   
   /*** Link and init new ActObj ***/

   ActObj[aob].Obj    = obj;
   ActObj[aob].Frame  = frame;
   ActObj[aob].Time   = VBD.Count;
   ActObj[aob].ActDef = (struct ObjDef *) obj->ObjDef[obdf];
   ActObj[aob].Dist   = 0;

   /*** Link WObject to ActObj ***/

   obj->ActObj = aob;
   
   return 0;
   }

/**************************************************/
/**** Reverse Order Plot Contents of DepthList ****/
/**************************************************/

/* Params - Count - Number of ActObj's in depthlist */

void C3D_PlotDepthList(UWORD count,struct WObject *vpt) {
  WORD n,v1;
  LONG x,y,d,s,t,t1,t2;
  struct ObjDef  *obdf;
  struct WObject  *wob;
  struct ActObj   *aob;
  struct ChnkWork  *cw;

  t1=VBD.Count;

  for(n=count-1;n>=0;n--) {           /* Traverse DepthList in rev order */
    aob = DepthList[n].AOb;           /* Get pointer to ActObj           */
    wob = aob->Obj;                   /* Get pointer to WObject          */
    obdf = aob->ActDef;               /* Get object def ptr              */
    x = aob->Rx;                      /* Get rotated x position          */
    y = wob->Height;                  /* Get height                      */
    s = wob->Size;                    /* Get Object size (for scaling)   */
    cw = &aob->Chky;                  /* Get pointer to ChnkWork         */

    if(obdf->Frames > 32) {           /* Anim is frame count sync'd      */
      t2=t1>>obdf->FDelay;            /* Adjust for frame delay          */
      t=t2;
      v1=obdf->Frames - 32;           /* Get frame count (2^n)           */
      t>>=v1;                         /* Calculate frame number          */
      t<<=v1;
      v1=t2-t;                    
      }
    else if(obdf->Views == 8) {       /* Object has 8 views              */
      v1=wob->Heading+63;             /* Get Objects Heading (+63=Centre)*/
      if(v1>1023) v1-=1024;           /* Make sure heading stil bounded  */
      v1+=aob->Angle;                 /* Add WObj=>VP angle value        */
      if(v1>1023) v1-=1024;           /* Make sure heading stil bounded  */
      v1>>=7;                         /* % by 128 Reduce to octant value */
      }
    else if(obdf->Views == 16) {      /* Object has 16 views             */

      aob->VPAng=ASM_FindAngle(aob->Vx,aob->Vy,0,0,HP_TanTab);

      v1=wob->Heading+31;             /* Get Objects Heading (+31=Centre)*/
      if(v1>1023) v1-=1024;           /* Make sure heading stil bounded  */
      v1+=aob->VPAng;                 /* Add WObj=>VP angle value        */
      if(v1>1023) v1-=1024;           /* Make sure heading stil bounded  */
      v1>>=6;                         /* % by 64 Reduce to hextant value */
      }
    else {                            /* Must be a single view object    */
      v1=aob->Frame;                  /* Set view to current anim frame  */
      }
              
    C3D_SetObjImage(wob->ActObj,v1);           /* Setup image data       */
    cw = &aob->Chky;                           /* Get ptr to ChnkWork    */
    if(cw->ID != 0) {                          /* Only draw if image set */
      d = aob->Dist;                           /* Get distance           */
      x = (x<<8)/d;                            /* Calculate Perspective  */
      y = (y<<8)/d;
      if(d>=MAPSCALE) d>>=MAPSCALESHIFT;       /* Bias dist by map scale */
      t = 32767 / d;                           /* Calc scale for dist    */
      t = (t * s) >> 8;                        /* Apply obj size scaling */
      cw->XCentre = HALFWIDTH - x;             /* Calculate Scrn Coords  */
      cw->YCentre = HALFHEIGHT- y;
      cw->Scale   = t;                         /* Set scale value        */
      if(obdf->Flags & WALLIMG_TYPE)
      ASM_ScaleSpriteT(cw, ChunkyTab);         /* Draw as wall sliver    */
      else ASM_ScaleSpriteN(cw, ChunkyTab);    /* Draw as scaled sprite  */
      }              
    else printf("ImgID 0-> cant scale view=%d\n",v1);

    if(obdf->Frames > 1 && obdf->Frames < 33) {     /* Do frame ++ if frames>1 */
      if(VBD.Count >= aob->Time + obdf->FDelay) {   /* Time for frame change ? */
        aob->Time = VBD.Count;                      /* Record frame change     */
        aob->Frame += 1;                            /* Increment frame counter */
        if(aob->Frame>obdf->Frames-1) aob->Frame=0; /* If last frame re-set    */
        }
      }
    }

  }


/********************************/
/**** Move specified WObject ****/
/********************************/

/* moves specified object

   mult - is a shift value for multiplying speed
*/

void C3D_MoveWOB(struct WObject *wob, WORD mult) {
  LONG idx,spd;

  if(wob->ActObj != 0xFFFF) ActObj[wob->ActObj].Dist=0;
  
  idx = wob->Heading << 1;
  spd = (wob->Speed * FrameDelay) << mult;
  wob->Wx += ((HeadingTab[idx+0] * spd) >> 16);
  wob->Wy += ((HeadingTab[idx+1] * spd) >> 16);
  }

/**********************************************/
/**** Move All WObjects in Range specified ****/
/**********************************************/

/* Call all WObject MovFunc's (if set) start is an index into 
the WObject array.  he routine scans forwards down the link
list calling move handlers on all objects where set !!!

NOTE - Oldest objects e.g. templates are at end of list so
       scan is from start backwards !!!!, also scans are
       normally started from LastNMovWOb pointer.
*/

void C3D_MoveALL(struct WObject *obj) {

  if(!obj) {
    printf("NULL Passed to C3D_MoveALL !!!\n");
    return;
    }

  while(obj) {  
    if(obj->MovFunc != NULL) obj->MovFunc(obj);
    obj=obj->Prev;
    }
  }

/**************************************/
/**** Allocate & Clone new WObject ****/
/**************************************/

/* returns object index on success
           -1 if no free objects
           -2 if no free ram for extended info

 NOTE - Extended data structures must be an exact
        mutliple of 4 bytes in length.
*/ 

WORD C3D_CloneWObject(struct WObject *src,LONG x,LONG y,LONG hgt,WORD head) {
  UWORD idx;
  ULONG len;
  struct WObject *wob;
  
  idx = C3D_FindFreeObject();
  if(idx == 0xFFFF) return -1;

  wob = &WObject[idx];
  
  wob->Wx        = x;
  wob->Wy        = y;
  wob->Height    = hgt;
  wob->Heading   = head;
  wob->Size      = src->Size;
  wob->Radius    = src->Radius;
  wob->Speed     = src->Speed;
  wob->ObjDef[0] = src->ObjDef[0];
  wob->ObjDef[1] = src->ObjDef[1];
  wob->ObjDef[2] = src->ObjDef[2];
  wob->ObjDef[3] = src->ObjDef[3];
  wob->ActObj    = 0xFFFF;
  wob->Flags     = src->Flags;
  wob->MovFunc   = src->MovFunc;
  wob->ColFunc   = src->ColFunc;

  if(src->Data != NULL) {             /* If extended info then clone */
    len = *(ULONG *) src->Data;      
    wob->Data = AllocVec(len, MEMF_PUBLIC);
    if(wob->Data == NULL) {
      printf("Out of memory during clone !!\n");
      return -2;
      }
    CopyMemQuick(src->Data, wob->Data, len);       
    }
  else wob->Data = NULL;
    
  return (WORD) idx;
  }

/****************************************/
/*** Set WObject handlers based on ID ***/
/****************************************/

/* Sets move & collision handler pointers for all
   WObjects with the specified ID.
   
   Returns number of WObjects found to match

   NOTE - This function scans entire WObject Array by INDEX !!!!
*/

WORD C3D_SetWObjectFunc(LONG id, void *movfunc, void *colfunc) {
  WORD n=0,c=0;
  struct WObject *wob=WObject;    

  if(wob) {
    while(n<MAXWOBJECT) {
      if(wob->ID==id && wob->Size > 0) {
        wob->MovFunc = (void (*) ()) movfunc;
        wob->ColFunc = (WORD (*) ()) colfunc;
        c++; 
        }
      wob++;
      n++;
      }
    }
  return c;
  }

/*********************************************/
/**** Find Next Object with specified ID ****/
/*********************************************/

/* ID   - ID to secan for 
   Prev - Previous object founds index (-1=No prev)

   Returns -1 if no more matches or index number

   NOTE - This function scan entire WObject Array by INDEX !!!!
*/
   
WORD C3D_FindWObject(LONG id,WORD prev) {
  WORD n,ret=-1;
  struct WObject *wob;
  
  if(prev<0) prev=0;
  else prev++;

  wob=&WObject[prev];
  n=prev;

  while(n<MAXWOBJECT) {
    if(wob->ID==id && wob->Size>0) {
      ret=n;
      n=MAXWOBJECT;
      }
    wob++;
    n++;
    }

  return ret;
  }

/********************************************************/
/*** Calculate Quadrant X2,Y2 is in relative to X1,Y1 ***/
/********************************************************/

/* Quandrant map  \2/ --> Increasing X
                  3X1 |
                  /0\ v Increasing Y
*/

WORD C3D_GetQuadrant(LONG x1, LONG y1, LONG x2, LONG y2) {
  LONG dx,dy;  
  WORD q;

  dx = x2 - x1;
  dy = y2 - y1;

  if(dx<0) {
    dx = 0-dx;
    if(dy<0) {
      dy = 0-dy;
      if(dx<dy) q=2;
      else q=3;
      }
    else {
      if(dx<dy) q=0;
      else q=3;      
      }
    }
  else {
    if(dy<0) {
      dy = 0-dy;
      if(dx<dy) q=2;
      else q=1;      
      }
    else {
      if(dx<dy) q=0;
      else q=1;
      }
    }

  return q;
  }


/****************************************/
/**** Draw in SkyLine & Floor Images ****/
/****************************************/

/* This routine assumes 192*65 screen */

void C3D_DrawBackdrop(void) {
  LONG tmphd,x;

  tmphd = VP->Heading + (VP->Heading>>1);           /* Adjust heading  */

  if(SkyImage) {  
    x = 0-(tmphd & 511);                            /* Plot Skyline    */
    ASM_DrawClipChunky(SkyImage,ChunkyTab,x,0,1L);    
    x+=512;
    ASM_DrawClipChunky(SkyImage,ChunkyTab,x,0,1L);  
    }

  if(FloorImage) {                                  /* Plot Floor Fill */
    x = 0-(tmphd & 3);                               
    ASM_DrawClipChunky(FloorImage,ChunkyTab,x,65,1L);    
    }
  }

/*******************************************/
/**** Wait for VBlank & Limit to 25 FPS ****/
/*******************************************/

void C3D_FrameSync(void) {
  LONG t1;

  WaitTOF();

  t1=VBD.Count;                       /* Get current time in VBlanks     */
  if(LastTimeA>=(t1-1)) {             /* Do extra Wait if FPS Liniting   */
    WaitTOF();
    }
  LastTimeA=VBD.Count;

  t1=VBD.Count;                       /* Get current time in VBlanks     */
  FrameDelay=t1-LastTime;             /* Calc time since last Frame done */
  LastTime=t1;                        /* Make Last time = current time   */
  }


/*****************************************/
/**** Build Space Partitioning Tables ****/
/*****************************************/

/* Index Table is one entry (1 word) bigger than it should
be this phantom zone is only present for end of zone wobject
list checking.  As scan for a given zone is from zone start
index to next zone start index minus one.

Returns 0 on success, otherwise -1 */

WORD C3D_BuildSPTables(void) {
  WORD *poptab;
  LONG cnt,n,xz,yz,zidx,pidx;
  struct WObject *wob;
  
  C3D_FreeSPTables();                 /* Free existing tables */

  if(!FirstMapWOb || !LastNMovWOb) {
    printf("FirstMapWOb or LastNMovWOb pointers not set !!!\n");
    return -1;
    }

  if(FirstMapWOb > LastNMovWOb) {
    printf("FirstMapWOb > LastNMovWOb !!!\n");
    return -1;
    }

  SPIndexTab = AllocVec(SPINDEXSIZE+2,MEMF_PUBLIC | MEMF_CLEAR);
  if(SPIndexTab==NULL) {
    printf("Could not alloc RAM for SP Index\n");
    return -1;
    }
  
  cnt=(LastNMovWOb-FirstMapWOb)+2;

  SPWObTab = AllocVec(cnt<<2,MEMF_PUBLIC | MEMF_CLEAR);
  if(SPWObTab==NULL) {
    C3D_FreeSPTables();
    printf("Could not allocate RAM for SP WObject Pointers\n");
    return -1;
    }

  poptab=AllocVec(SPINDEXSIZE, MEMF_PUBLIC | MEMF_CLEAR);
  if(poptab==NULL) {
    C3D_FreeSPTables();
    printf("Could not allocate RAM for population table\n");
    return -1;
    }

  wob=FirstMapWOb;
  while(wob<=LastNMovWOb) {
    xz   = wob->Wx >> 16;            /* X Zone = MapX/256 = WorldX/16384 */
    yz   = wob->Wy >> 16;            /* Y Zone = MapY/256 = WorldY/16384 */
    zidx = (yz<<7) + xz;             /* Idx = Y * 128 + X                */
    poptab[zidx]++;                  /* Increment zone population count  */
    wob++;
    }

  SPIndexTab[0]=0;                   /* First Zones 1st pointer = 0      */
  n=0;                               /* Build zone ptr list start ofst's */
  for(n=1;n<=SPZONES;n++) {          /* <= to include phantom end zone   */
    SPIndexTab[n] = SPIndexTab[n-1] + poptab[n-1];
    }
 
  for(n=0;n<SPZONES;n++)
                poptab[n]=0;         /* poptab now zone alloc. counter   */

  wob=FirstMapWOb;                   /* Build zoned WObject Pointer List */
  while(wob<=LastNMovWOb) {
    xz   = wob->Wx >> 16;            /* X Zone = MapX/256 = WorldX/16384 */
    yz   = wob->Wy >> 16;            /* Y Zone = MapY/256 = WorldY/16384 */
    zidx = (yz<<7) + xz;             /* Idx = Y * 128 + X                */
    pidx = SPIndexTab[zidx]+poptab[zidx];  /* Get next free slot in zone */
    poptab[zidx]++;                        /* Inc zone slot popul. count */
    SPWObTab[pidx] = (LONG) wob;     /* Store WObject Ptr into SPWObTab  */
    wob++;
    }

  FreeVec(poptab);                   /* Free Temporary storage table     */
  return 0;
  }


/****************************************/
/**** Free Space Partitioning Tables ****/
/****************************************/

void C3D_FreeSPTables(void) {
  if(SPIndexTab) {
    FreeVec(SPIndexTab);
    SPIndexTab=NULL;
    }

  if(SPWObTab) {
    FreeVec(SPWObTab);
    SPWObTab=NULL;
    }
  }


/****************************************************/
/**** Setup ColWork & Start a New Collision Scan ****/
/****************************************************/

/*  Params - Object Requiring Collision Check Against World
           - Additional WObject to ignore
   Returns - Passes back info from ASM_Collision
*/

LONG  C3D_Collision(struct WObject *wob, struct WObject *ign) {
  LONG x,y,z,z1,z2,z3,z4,ret=0;

  x = wob->Wx>>16;                          /* Convert Coords to Zones   */
  y = wob->Wy>>16;
  z = (y<<7) + x;                           /* Zone = (y*128)+x          */
  
  x = wob->Wx & 0xFFFF;                     /* Get Zone Relative x,y     */
  y = wob->Wy & 0xFFFF;
    
  x>>=15;                                   /* Reduce to Quadrant Coords */
  y>>=15;
 
  if(x) {
    if(y) {
      z1 = z;                               /* Set Zones for x=1,y=1     */
      z2 = z + 1;
      z3 = z + 128;
      z4 = z + 129;
      } 
    else{
      z1 = z + -128;                        /* Set Zones for x=1,y=0     */
      z2 = z + -127;
      z3 = z;
      z4 = z + 1;
      }
    }
  else {
    if(y) {
      z1 = z + -1;                          /* Set Zones for x=0,y=1     */
      z2 = z;
      z3 = z + 127;
      z4 = z + 128;
      } 
    else{
      z1 = z + -129;                        /* Set Zones for x=0,y=0     */
      z2 = z + -128;
      z3 = z + -1;
      z4 = z;
      }
    }

  if(z1<0) z1=0;                            /* Limit to valid zone no's  */
  if(z1>=SPZONES) z1=SPZONES-1;
  if(z2<0) z2=0;
  if(z2>=SPZONES) z2=SPZONES-1;
  if(z3<0) z3=0;
  if(z3>=SPZONES) z3=SPZONES-1;
  if(z4<0) z4=0;
  if(z4>=SPZONES) z4=SPZONES-1;
  
  ColWork->R1Start = SPIndexTab[z1];        /* Start Index Value         */
  ColWork->R1End   = SPIndexTab[z2+1]-1;    /* End Index Value: Last Chk */
  ColWork->R2Start = SPIndexTab[z3];        /* Start Index Value         */
  ColWork->R2End   = SPIndexTab[z4+1]-1;    /* End Index Value: Last Chk */
   
  ColWork->Wx      = wob->Wx;               /* Get Base Objects Details  */
  ColWork->Wy      = wob->Wy;
  ColWork->Height  = wob->Height;
  ColWork->Radius  = wob->Radius;
  ColWork->Ignore1 = wob;                   /* Focus ignores self coll   */
  ColWork->Ignore2 = ign;                   /* Set optional ignore ptr   */
  
  ColWork->WObject = LastNMovWOb->Prev;     /* Set Move WObs scan start  */
  ColWork->SpcPart = SPWObTab;              /* Set SP Pointers Table Base*/
  ColWork->ColArea = ColArea;               /* Set ColArea Array Base    */

  ret = ASM_ChkCol(ColWork);                /* Call ASM Collision Func   */
  
  return ret;
  }

/*****************************************/
/**** Check LOS between x1,y1 & x2,y2 ****/
/*****************************************/

/* Arguments - hgt         - height of LOS line
             - x1,y1 x2,y2 - start and end of LOS

     returns - Pointer to blocking WObject
               or NULL if no block & in-range
               or 1 if out of range
 
NOTE X & Y steps multiplied (<<8) by 256 to keep precision

     Only fixed terrain objects are checked !!!!!

     LOS's > ActiveRange in blocks are ignored as out of range
*/

struct WObject *C3D_CheckLOS(LONG hgt,LONG x1,LONG y1,LONG x2,LONG y2) {
  LONG dx,dy,adx,ady,xadj,yadj,xstep,ystep;
  LONG tx,ty,xdi,ydi,txd,tyd,td,xblk,yblk;
  LONG zone,xbstep,ybstep,b,n,c,t1,t2,tr,blk=0;
  LONG lx,hx,rx,ly,hy,ry,stp,hit,itr;
  struct WObject *wob;

  LONG blocks[30]; 
  
  dx=x2-x1;                     /* Calculate distances                  */
  dy=y2-y1;

  if(dx==0) dx=1;               /* Fix Antipodes                        */
  if(dy==0) dy=1;
  
  adx=dx;                       /* Get absolute distances               */
  if(adx<0) adx=0-adx;
  ady=dy;
  if(ady<0) ady=0-ady;

  td=ActiveRange<<16;           /* Check Object in Vissibility range    */
  if(adx>td || ady>td)
    return (struct WObject *) 1L;
  
  xadj=0;                       /* Calc X/Y Boundary cross adjustments  */
  if(dx>0) xadj=1;
  yadj=0;
  if(dy>0) yadj=1;
  
  
  xstep=(dx<<8)/ady;            /* Calculate X/Y Step Values            */
  ystep=(dy<<8)/adx;
  
  
  tx=x1>>16;                    /*** Calc distance to 1st X intersect ***/
  if(dx>0) tx+=1;
  tx=tx<<16;
  xdi=tx-x1;
  
  td=xdi;                       /* Get absolute distance                */
  if(td<0) td=0-td;

  ty=y1;                        /* Calc co-ords of 1st X intersect      */
  tyd=(ystep*td)>>8;
  ty=ty+tyd;
  adx=adx-td;                   /* Reduce X distance count              */
   
  xblk=(tx>>16)-xadj;           /* Reduce to SP block co-ords           */
  yblk=ty>>16;
  zone=(yblk<<7)+xblk;          /* Write block to block list            */
  if(zone>=0 && zone<SPZONES)
            blocks[blk++]=zone;
  

  ybstep=ystep<<8;              /* ybstep=(ystep*65536)/256             */
  xbstep=65536;                 /* xbstep=world SP block size           */
  if(dx<0) xbstep=0-xbstep;     /* If dist neg then flip x step sign    */

  while(adx>65536) {
    tx=tx+xbstep;               /* Calc next X line intersect co-ords   */
    ty=ty+ybstep;
    adx=adx-65536;              /* Reduce X distance count              */
   
    xblk=(tx>>16)-xadj;         /* Reduce to SP block co-ords           */
    yblk=ty>>16;
    zone=(yblk<<7)+xblk;        /* Write block to block list            */
    if(zone>=0 && zone<SPZONES)
              blocks[blk++]=zone;
    }


  ty=y1>>16;                    /*** Calc distance to 1st Y intersect ***/
  if(dy>0) ty+=1;
  ty=ty<<16;
  ydi=ty-y1;
  
  td=ydi;                       /* Get absolute distance                */
  if(td<0) td=0-td;

  tx=x1;                        /* Calc co-ord of 1st Y intersect       */
  txd=(xstep*td)>>8;
  tx=tx+txd;
  ady=ady-td;                   /* reduce Y distance count              */

  xblk=tx>>16;                  /* Reduce to SP block co-ords           */
  yblk=(ty>>16)-yadj;
  zone=(yblk<<7)+xblk;          /* Write block to block list            */
  if(zone>=0 && zone<SPZONES)
            blocks[blk++]=zone;
   

  xbstep=xstep<<8;              /* xbstep=(xstep*65536)/256             */
  ybstep=65536;                 /* ybstep=word SP blocks size           */
  if(dy<0) ybstep=0-ybstep;

  while(ady>65536) {
    tx=tx+xbstep;               /* Calc next Y line intersect co-ords   */
    ty=ty+ybstep;
    ady=ady-65536;              /* reduce Y distance count              */
   
    xblk=tx>>16;                /* Reduce to SP block co-ords           */
    yblk=(ty>>16)-yadj;
    zone=(yblk<<7)+xblk;        /* Write block to block list            */
    if(zone>=0 && zone<SPZONES)
              blocks[blk++]=zone; 
    }

  xblk=x2>>16;                  /*** Write extra block for end co-ords  */
  yblk=y2>>16;
  zone=(yblk<<7)+xblk;
  if(zone!=blocks[blk-1] &&
     zone>=0 &&
     zone<SPZONES) blocks[blk++]=zone;

  /**** Remove Duplicate Blocks From List ****/

  if(blk==0) return NULL;       /* terminate if no blocks in list       */

  for(b=0;b<blk;b++) {
    for(n=b+1;n<blk;n++) {
      if(blocks[b]==blocks[n]) blocks[n]=-1;
      }
    }

  /**** Build WOBject List from Block List ****/

  c=0;                          /* Zero LOSTab Contents Index/Counter   */

  adx = dx;                     /* Get Absolute X,Y distances           */
  if(adx<0) adx=0-adx;
  ady = dy;
  if(ady<0) ady=0-ady;
  
  lx=x1; hx=x2; rx=0;           /* Get low,high,rev flag for x & y axis */
  ly=y1; hy=y2; ry=0;
  
  if(lx>hx) {t1=lx; lx=hx; hx=t1; rx=1;}
  if(ly>hy) {t1=ly; ly=hy; hy=t1; ry=1;} 
  

  for(b=0;b<blk;b++) {          /* Loop through SP block list           */
    t1=blocks[b];               /* Get Start & End Index's              */
    if(t1>=0) {                 /* Ignore duplicate blocks              */
      ty=SPIndexTab[t1];
      t1++;
      if(t1>=SPZONES) tx=y1+1;
      else tx=SPIndexTab[t1];
    
      for(n=ty;n<tx;n++) {                  /* Check WObs in block      */
        wob = (struct WObject *) SPWObTab[n];
        if(wob) {
          tr=wob->Radius;
          if(tr<0) tr=0-tr;                 /* Non colWObs have neg rad */

          t1=wob->Height-tr;                /* Calc floor & ceiling     */
          t2=wob->Height+tr;
        
          if(t1<=hgt && t2>=hgt && c<LOSTABCNT-1) {
            if(adx>ady) {
              tx = wob->Wx;
              if(tx>=lx && tx<=hx) {
                if(rx) tx=0-tx; 
                LOSTab[c++] = tx;
                LOSTab[c++] = (LONG) wob;
                }
              }
            else {
              ty = wob->Wy;
              if(ty>=ly && ty<=hy) {
                if(ry) ty=0-ty; 
                LOSTab[c++] = ty;
                LOSTab[c++] = (LONG) wob;
                }
              }
            }
          }
        }
      }
    }
  
  ASM_QuickSort((APTR) LOSTab,c>>1);        /* Sort LOSTab into order    */

  b=0;
  if(dx<0 && dy>=0) b=1;
  if(dy<0 && dx>=0) b=1;

  hit=0;

  if(b==0) {
    if(adx>ady) {
      stp=((ady+1)<<8)/adx;                       
      for(n=0;n<c;n+=2) {
        wob = (struct WObject *) LOSTab[n+1];   
        tr = wob->Radius;
        t1 = wob->Wy-tr;             
        t2 = wob->Wy+tr;             
        itr = (((wob->Wx-lx)*stp)>>8)+ly;     
        if(itr>=t1 && itr<=t2) { hit=1; n=c;}         
        }
      }
    else {
      stp=((adx+1)<<8)/ady;
      for(n=0;n<c;n+=2) {
        wob = (struct WObject *) LOSTab[n+1];   
        tr = wob->Radius;
        t1 = wob->Wx-tr;             
        t2 = wob->Wx+tr;             
        itr = (((wob->Wy-ly)*stp)>>8)+lx;
        if(itr>=t1 && itr<=t2) { hit=1; n=c;}         
        }
      }
    }
  else {
    if(adx>ady) {
      stp=((ady+1)<<8)/adx;                       
      for(n=0;n<c;n+=2) {
        wob = (struct WObject *) LOSTab[n+1];   
        tr = wob->Radius;
        t1 = wob->Wy-tr;             
        t2 = wob->Wy+tr;             
        itr = hy-(((wob->Wx-lx)*stp)>>8);     
        if(itr>=t1 && itr<=t2) { hit=1; n=c;}         
        }
      }
    else {
      stp=((adx+1)<<8)/ady;
      for(n=0;n<c;n+=2) {
        wob = (struct WObject *) LOSTab[n+1];   
        tr = wob->Radius;
        t1 = wob->Wx-tr;             
        t2 = wob->Wx+tr;             
        itr = hx-(((wob->Wy-ly)*stp)>>8);
        if(itr>=t1 && itr<=t2) { hit=1; n=c;}         
        }
      }
    }


  if(!hit) wob=NULL;

  return wob;
  }


/***************************************************/
/*** Check for collsions etc & handle if occured ***/
/***************************************************/

/* Params  - wob1 - WObject to collision check against world
              ign - Additional WObject to ignore (Parent)              

   Returns - -2 - If non-passable collsion
             -1 - If passable collision
              0 - No collision at all

  Collision functions called for all WObjects which have
  ColFunc set (In inter WObject collision)
  
  In WObject->ColArea collision WObjects ColFunc is called
  with the target wob pointer (2nd arg) set to NIL as there
  is no other WObject involved.  Same applies for boundary
  collisions.
*/   

WORD C3D_CheckCollision(struct WObject *wob1, struct WObject *ign) {
  LONG n,type,ref;
  WORD ret,halt = 0;
  struct WObject *wob2;

  C3D_Collision(wob1,ign);                /* Get Collisions List        */
 
  n=0;
  type=ColWork->Ret[n];

  while(type!=0) {                        /* Loop while type != NULL    */
    ref=ColWork->Ret[n+1];                /* Get ref for current item   */

    if(halt==0) halt = -1;                /* Must be passable collision */

    switch(type) {
    case 1:                               /** Handle Boundary Collis'n **/
      halt=-2;                            /* Allways non-passable coll  */

      if(wob1->ColFunc != NULL)           /* If host has ColFunc then   */
        wob1->ColFunc(wob1,NULL);         /* call it.                   */

      break;
    
    case 2:                               /** Handle ColArea Collision **/ 
      halt=-2;                            /* Allways non-passable coll  */

      if(wob1->ColFunc != NULL)           /* If host has ColFunc then   */
        wob1->ColFunc(wob1,NULL);         /* call it.                   */

      break;

    case 3:                               /** Handle Fixed WObject Coll**/
    case 4:                               /** Handle Moveable WOb Coll **/
      wob2=(struct WObject *) ref;        /* Get Pointer to WObject hit */

      C3D_ExchangeDamage(wob1,wob2);      /* Exchange insurance details */

      if(wob2->ColFunc == NULL) {         /* If target has no colfunc   */
        halt=-2;                          /* Return halt                */
        }
      else {                              /* If target has ColFunc then */
        ret = wob2->ColFunc(wob2,wob1);   /* call it.  Halt if other    */
        if(ret) halt=-2;                  /* object requires it (ret!=0)*/
        }

      if(wob1->ColFunc != NULL)           /* If host has ColFunc then   */
        wob1->ColFunc(wob1,wob2);         /* call it.                   */

      break;
      }
    n+=2;                                 /* move to next item          */
    type=ColWork->Ret[n];                 /* Get collisions items type  */
    }
 
  return halt;
  }

/****************************************************/
/*** Do damage exchange between specified objects ***/
/****************************************************/

/* Applies damage to total hitpoints and the quadrant of
   collision unless quadrant 0 contains -1 in which case
   quadrant damage is ignored (faster).
   
   If HP's of quadrant hits 0 (will never go negative)
   then objects total hitpoints are changed to zero as well.
   This makes kill detection easier.

   DAMAGE COULD BE DONE TWICE IN BI-DIRECTIONAL TRANSFERS
*/

void C3D_ExchangeDamage(struct WObject *wob1, struct WObject *wob2) {
  WORD side,quad;
  struct ExtDatHdr *dat1, *dat2;
  struct HitPoints *hp1,*hp2;       

  if(wob1->Data == NULL) return;
  if(wob2->Data == NULL) return;

  dat1 = wob1->Data;                          /* Get ptrs to ext data    */
  dat2 = wob2->Data;

  if(!dat1->Flags & HDLRFLG_DAMAGE) return;
  if(!dat2->Flags & HDLRFLG_DAMAGE) return;

  hp1 = (struct HitPoints *) &dat1->ExtData;  /* Get ptrs to HitPoints   */
  hp2 = (struct HitPoints *) &dat2->ExtData;

  hp1->TotHP -= hp2->Damage;                  /* Reduce total HitPoints  */
  hp2->TotHP -= hp1->Damage;  

  if(hp1->TotHP < 0) hp1->TotHP = 0;          /* Bound HitPoints to Zero */
  if(hp2->TotHP < 0) hp2->TotHP = 0;  


  if(hp1->QuadHP[0] != -1) {                  /* Skip if no quad damage  */
    quad = C3D_GetQuadrant(wob1->Wx, wob1->Wy, wob2->Wx, wob2->Wy);
  
    side = wob1->Heading+128;                 /* Get heading & Centre    */
    if(side>1023) side-=1024;                 /* Bound centred heading   */
    side>>=8;                                 /* Reduce to quadrant head */
    side+=quad;                               /* Add quadrant direction  */
    if(side>3) side-=4;                       /* Bound quadrant calc     */

    hp1->QuadHP[side] -= hp2->Damage;         /* Damage required side    */
    if(hp1->QuadHP[side] < 0) {               /* If less than 0 HP's     */
      hp1->QuadHP[side] = 0;                  /* Zero quadrants HP's     */
      hp1->TotHP = 0;                         /* Zero total Hit Points   */
      }
    }

  if(hp2->QuadHP[0] != -1) {                  /* Skip if no quad damage  */
    quad = C3D_GetQuadrant(wob2->Wx, wob2->Wy, wob1->Wx, wob1->Wy);
  
    side = wob2->Heading+128;                 /* Get heading & Centre    */
    if(side>1023) side-=1024;                 /* Bound centred heading   */
    side>>=8;                                 /* Reduce to quadrant head */
    side+=quad;                               /* Add quadrant direction  */
    if(side>3) side-=4;                       /* Bound quadrant calc     */

    hp2->QuadHP[side] -= hp1->Damage;         /* Damage required side    */
    if(hp2->QuadHP[side] < 0) {               /* If less than 0 HP's     */
      hp2->QuadHP[side] = 0;                  /* Zero quadrants HP's     */
      hp2->TotHP = 0;                         /* Zero total Hit Points   */
      }
    }
  }


/*********************************************************/
/*** Uni-directional Damage Transfer from Wob1 to Wob2 ***/
/*********************************************************/

/* As prior function but wob1 is only used for calculation of
   side of wob2 damaged.  Damage done is specified in function
   call.
*/

void C3D_Damage(struct WObject *wob1, struct WObject *wob2, WORD damage) {
  WORD side,quad;
  struct ExtDatHdr *dat;
  struct HitPoints *hp;       

  if(wob2->Data == NULL) return;

  dat = wob2->Data;                           /* Get ptrs to ext data    */

  if(!dat->Flags & HDLRFLG_DAMAGE) return;

  hp = (struct HitPoints *) &dat->ExtData;    /* Get ptrs to HitPoints   */

  hp->TotHP -= damage;                        /* Reduce total HitPoints  */
  if(hp->TotHP < 0) hp->TotHP = 0;            /* Bound HitPoints to Zero */

  if(hp->QuadHP[0] != -1) {                   /* Skip if no quad damage  */
    quad = C3D_GetQuadrant(wob2->Wx, wob2->Wy, wob1->Wx, wob1->Wy);
  
    side = wob2->Heading+128;                 /* Get heading & Centre    */
    if(side>1023) side-=1024;                 /* Bound centred heading   */
    side>>=8;                                 /* Reduce to quadrant head */
    side+=quad;                               /* Add quadrant direction  */
    if(side>3) side-=4;                       /* Bound quadrant calc     */

    hp->QuadHP[side] -= damage;               /* Damage required side    */
    if(hp->QuadHP[side] < 0) {                /* If less than 0 HP's     */
      hp->QuadHP[side] = 0;                   /* Zero quadrants HP's     */
      hp->TotHP = 0;                          /* Zero total Hit Points   */
      }
    }
  }


/*****************************/
/*** Free HandlerInfo list ***/
/*****************************/

void C3D_FreeHInfo(void) {
  struct HandlerInfo *next,*cur;

  cur = HandlerInfo;

  while(cur) {
    next=cur->Next;
    FreeVec(cur);
    cur=next;
    }

  HandlerInfo = NULL;
  }


/********************************/
/*** Register Handler in List ***/
/********************************/

/* Returns 0 on success, otherwise non zero

   Active Object Handler ID's are in the range of  500000 to 599999
   defined as AHDLRLOID and AHDLRHIID
   
   Passive Object Handler ID's are in the range of 600000 to 699999
   defined as PHDLRLOID and PHDLRHID
   
   Handler ID ranges can be specified by setting id2
   to anything other than 0, if it's set to zero id2=id

   NOTE No! checking is done to ensure ID ranges/numbers
   do not overlap.
*/

WORD C3D_RegHInfo(LONG id,LONG id2, BYTE *name, APTR hdlr) {
  WORD n=0;
  struct HandlerInfo *hinfo;

  hinfo = AllocVec(sizeof(struct HandlerInfo), MEMF_PUBLIC | MEMF_CLEAR);
  if(!hinfo) {
    printf("Not enough RAM for handler registration !!\n");
    return -1;
    }

  hinfo->Next = HandlerInfo;
  HandlerInfo = hinfo;

  if(id2<id) id2=id;

  hinfo->ID  = id;
  hinfo->ID2 = id2;
  hinfo->Handler = hdlr;

  while(name[n]!=0 && n<24) hinfo->Info[n] = name[n++];
  hinfo->Info[n]=0;

  return 0;
  }


/******************************/
/*** Find a Handler from ID ***/
/******************************/

/* Returns a pointer to the Handler Info structure
   related to the located ID or NULL on failure
*/

struct HandlerInfo *C3D_FindHInfo(LONG id) {
  struct HandlerInfo *hinfo = HandlerInfo;

  while(hinfo) {
    if(id >= hinfo->ID && id <= hinfo->ID2) return hinfo;
    hinfo = hinfo->Next;
    }

  return NULL;
  }


/***********************************/
/*** Printf HandlerInfo Database ***/
/***********************************/

void C3D_ShowHInfo(void) {
  struct HandlerInfo *hinfo = HandlerInfo;

  while(hinfo) {
    printf("%06ld->%06ld = %s\n",hinfo->ID,hinfo->ID2,hinfo->Info);
    hinfo = hinfo->Next;
    }
  }


/**********************************************/
/*** Free Temp Handler Binding Objects List ***/
/**********************************************/

void C3D_FreeBinders(void) {
  struct Binder *next,*bind = Binder;

  while(bind) {
    next = bind->Next;
    FreeVec(bind);
    bind = next;
    }
  Binder = NULL;
  }


/****************************************************/
/*** Bind entries in Handler Binding Objects List ***/
/****************************************************/

/* Returns 0 on success, or non zero otherwise */

WORD C3D_BindBinders(void) {
  struct Binder      *next,*bind = Binder;
  struct HandlerInfo *hinfo;
  struct WObject     *wob;
  UWORD idx;
  WORD ret,err=0;

  while(bind) {
    next = bind->Next;

    hinfo = C3D_FindHInfo(bind->ID);
    if(hinfo) {
      idx = C3D_CloneWObject(hinfo->Handler,bind->Wx,bind->Wy,bind->Hgt,bind->Head);
      if(idx != 0xFFFF) {
        wob = &WObject[idx];
        wob->ID        = bind->ID;
        wob->Size      = bind->Size;
        wob->Radius    = bind->Radius; 
        wob->ObjDef[0] = bind->ObjDef[0];
        wob->ObjDef[1] = bind->ObjDef[1];
        wob->ObjDef[2] = bind->ObjDef[2];
        wob->ObjDef[3] = bind->ObjDef[3];
        ret = C3D_FixWObjID(wob);
        if(ret==-1) {
          err=ret;
          printf("Map Obj -> Handler Bind Failed -> FixWObjID()\n");
          }
        }
      else printf("Map Obj -> Handler Bind Failed -> Clone\n");
      }
    else printf("Map Obj -> Handler Bind Failed -> Bad ID %ld\n",bind->ID);

    FreeVec(bind);
    bind = next;
    }

  Binder = NULL;
  return err;
  }
