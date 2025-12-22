/************************************/
/***    Misc Support Functions    ***/
/*** Copyright (c) J.Gregory 1996 ***/
/***    Version 1.08  17/01/98    ***/
/************************************/


/****** Initialise Misc Resources ******/

/* Returns 0 on success, otherwise -1 */

WORD C3D_InitMisc(void) {
  WORD ret;
  
  ret = C3D_LoadRand();

  return ret;
  }

/****** Free Misc Resources ******/

void C3D_FreeMisc(void) {

  if(RandTable) {
    FreeVec(RandTable);
    RandTable = NULL;
    }  
  }

/****** Load Random Number Table ******/

/* Returns 0 on success, otherwise -1 */

WORD C3D_LoadRand(void) {
  BPTR handle = NULL;
  LONG len;

  if(RandTable) FreeVec(RandTable);
  RandTable = NULL;
  RandSeed  = 0;
  
  handle = Open(RANDTABNAME, MODE_OLDFILE);
  if(!handle) {
    printf("Could not open random table: %s\n",RANDTABNAME);
    return -1;
    }

  RandTable = AllocVec(RANDTABSIZE, MEMF_PUBLIC | MEMF_CLEAR);
  if(!RandTable) {
    printf("Failed to Allocate random table RAM\n");
    Close(handle);
    return -1;
    }

  len = Read(handle,RandTable,RANDTABSIZE);
  if(len != RANDTABSIZE) {
    printf("Failed to load random table: %s\n",RANDTABNAME);
    Close(handle);
    FreeVec(RandTable);
    RandTable = NULL;
    return -1;
    }

  RandSeed=0;
  Close(handle);
   
  return 0;  
  }


/****** Get Random Number 0->2047 ******/

/* Returns Pseudo Random Number */

WORD C3D_GetRand(void) {
  WORD ret;

  ret = RandTable[RandSeed];
  RandSeed++;
  if(RandSeed >= (RANDTABSIZE>>1)) RandSeed = 0;

  return ret;
  }
  
  
/****** Read Resource Script & Load Files ******/

/* Returns 0 on success, otherwise -1 */
  
WORD C3D_LoadResource(BYTE *filename) {  
  BPTR handle=NULL;
  BYTE line[128], *type=NULL, *value=NULL;
  WORD pos, ret=0;
  
  handle = Open(filename, MODE_OLDFILE);
  if(!handle) {
    printf("Could not open resource script: %s\n",filename);
    return -1;
    }
    
  type = FGets(handle,line,128);
  while(type!=NULL && ret==0) {
    value = strchr(line,'=');
    if(value) {
      value[0] = 0;
      value++;
      pos = 0;
      while(value[pos] != 0) {
        if(value[pos] == '\n') value[pos] = 0;
        pos++;
        }          
      if(!strcmpi(type,"IMAGE"))          ret=C3D_LoadImage(value);
      if(!strcmpi(type,"SAMPLE"))         ret=C3D_LoadSample(value);
      if(!strcmpi(type,"OBJDEF"))         ret=C3D_LoadObjDefs(value);
      if(!strcmpi(type,"MAP"))            ret=C3D_LoadWobjMap(value);
      if(!strcmpi(type,"INITVP"))         ret=C3D_InitVP(value);
      if(!strcmpi(type,"FLROBJDENSITY"))  ret=C3D_InitFlrObjSys(value);
      if(!strcmpi(type,"FLROBJRANGE"))    ret=C3D_SetFlrObjRange(value);
      if(!strcmpi(type,"FLROBJ"))         ret=C3D_SetFlrObjTemp(value);
      if(!strcmpi(type,"SKYIMAGE"))       ret=C3D_SetSkyImage(value);
      if(!strcmpi(type,"FLRIMAGE"))       ret=C3D_SetFlrImage(value);
      if(!strcmpi(type,"FONT6X9IMAGE"))   ret=C3D_Set6x9Image(value);
      if(!strcmpi(type,"ACTRANGE"))       ret=C3D_SetActRange(value);
      if(!strcmpi(type,"LOADCT64"))       ret=C3D_LoadCT64(value);

      if(!strcmpi(type,"TEMPLATES")) {
        ret=C3D_BuildTemplates();
        if(!ret) ret=C3D_AllocFlrObj();
        }

      if(!strcmpi(type,"FLUSH")) {
        C3D_FreeObjDefs();
        C3D_ClearObjects();
        C3D_FreeImages();
        C3D_FreeSamples();
        C3D_ClearTemplateBases();
        }
      if(ret) printf ("Failed %s=%s\n",type,value);
      }
    type = FGets(handle,line,128);
    }

  if(VP==NULL && !ret) {
    printf("No INITVP command in script !!\n");
    ret = -1;
    }

  if(!ret) ret=C3D_CheckFlrObj();

  Close(handle);
  return ret;
  }

/*************************************************/
/**** Initialise ViewPoint (Parse INITVP args ****/
/*************************************************/

/* Returns -1 on failure or 0 on success */

WORD C3D_InitVP(char *str0) {
  WORD ret;
  LONG c,n,x,y,h,head,l0,l1,l2,l3;
  char *str1,*str2,*str3;
  
  n=c=0;
  str1=str2=str3=NULL;
  
  while(str0[n]!=0 && c<3) {
    if(str0[n]==',') {
      str0[n]=0;
      c++;
      if(c==1) str1=&str0[n+1];
      if(c==2) str2=&str0[n+1];
      if(c==3) str3=&str0[n+1];
      }
    n++;
    }
  
  if(c!=3) {
    printf("Invalid arg count. (INITVP=x,y,h,head)\n");
    return -1;
    }
  
  l0=StrToLong(str0,&x);
  l1=StrToLong(str1,&y);
  l2=StrToLong(str2,&h);
  l3=StrToLong(str3,&head);
  
  if(l0<1 || l1<1 || l2<1 || l3<1) {
    printf("Invalid parameter. (INITVP=x,y,h,head\n");
    return -1;
    }

  x<<=MAPSCALESHIFT;
  y<<=MAPSCALESHIFT;
  h<<=MAPSCALESHIFT;

  if(x<WORLDXMIN || x>WORLDXMAX) {
    printf("X must be between %ld & &ld\n",WORLDXMIN,WORLDXMAX);
    return -1;
    }    

  if(y<WORLDYMIN || y>WORLDYMAX) {
    printf("Y must be between %ld & &ld\n",WORLDYMIN,WORLDYMAX);
    return -1;
    }    
  
  if(h<WORLDHMIN || h>WORLDHMAX) {
    printf("Height must be between %ld & &ld\n",WORLDHMIN,WORLDHMAX);
    return -1;
    }    

  if(head<0 || head>1023) {
    printf("Heading must be between 0 & 1023\n");
    return -1;
    }
  
  ret = VPTemplate(x,y,h,head);
  if(ret) return -1;
  
  return 0;
  }

/********************************************/
/****** Initialise Floor Object System ******/
/********************************************/

/* Returns -1 on failure or 0 on success */

WORD C3D_InitFlrObjSys(char *str) {

  if(FlrObjDensity!=0) {
    printf("FLROBJDENSITY Allready set (Try FLUSH=TRUE)\n");
    return -1;
    }  
  
  StrToLong(str,&FlrObjDensity);

  if(FlrObjDensity<0 || FlrObjDensity > (MAXACTOBJ/2)) {
    printf("FLROBJDENSITY Out or range\n");
    return -1;
    }    
  
  FlrObjCount = 0;  /* Zero number of templates specified */
  
  return 0;
  }

/****** Set Floor Object Clipping Range ******/

WORD C3D_SetFlrObjRange(char *str) {

  if(FlrObjDensity<=0) {
    printf("FLROBJDENSITY must be set first set\n");
    return -1;
    }

  StrToLong(str,&FlrObjRange);
  
  if(FlrObjRange<=8192) {
    printf("FLROBJRANGE must be greater than 8192\n");
    return -1;
    } 

  return 0;
  }

/****** Set Floor Object Template Details ******/

WORD C3D_SetFlrObjTemp(char *str) {
  WORD n=0;
  LONG obdf,hght,len;  
  struct ObjDef *objdef;

  if(FlrObjDensity<=0) {
    printf("FLROBJDENSITY must be set first set\n");
    return -1;
    }

  if(FlrObjCount >= 10) {
    printf("Maximum FLROBJ templates is 10\n");
    return -1;
    }

  while(str[n]!=',' && str[n]!=0) n++;

  if(str[n]==0) {
    printf("FLROBJ=ObjDefID,Height incomplete\n");
    return -1;
    }

  str[n++]=0;

  len = StrToLong(str,&obdf);
  if(len<1) {
    printf("FLROBJ invalid <ObjDefID> parameter\n");
    return -1;
    }

  len = StrToLong(str+n,&hght);
  if(len<1) {
    printf("FLROBJ invalid <Height> parameter\n");
    return -1;
    }  
  
  objdef = C3D_FindObjDef((ULONG) obdf);
  if(objdef==NULL) {
    printf("ObjDef does not exist: %ld\n",obdf);
    return -1;
    }
  
  FlrObjTemp[FlrObjCount].Height = hght << MAPSCALESHIFT;
  FlrObjTemp[FlrObjCount].Obdf   = objdef;
  
  FlrObjCount++;

  return 0;
  }

/****** Do final FlrObj O.K. Checks ******/

WORD C3D_CheckFlrObj(void) {

  if(FlrObjDensity==0) return 0;
  
  if(FlrObjRange<1) {
    printf("No FLROBJRANGE set\n");
    return -1;
    }

  if(FlrObjCount<1) {
    printf("No FLROBJ templates specified\n");
    return -1;
    }
  
  C3D_PopulateFlrObj();
  
  return 0;
  }

/****** Allocate WObjects block for FlrObjects ******/

/* A> Allocates as single template for all FlrObj's
   B> Reserves block of WObjects for FlrObj's

   Return 0 on success otherwise -1
*/

WORD C3D_AllocFlrObj(void) {
  WORD idx,n;

  if(FlrObjDensity < 1) return 0;   /* Ignore if FlrObj's dissabled */

  /*** Build FlrObj Template ***/

  idx = C3D_FindFreeObject();
  if(idx == -1) {
    printf("No Free Objects for FlrObjTemplate\n");
    return -1;
    }

  FlrTemplate = &WObject[idx];
  FlrTemplate->Wx        = NULLCOORD;
  FlrTemplate->Wy        = NULLCOORD;
  FlrTemplate->Height    = 0;
  FlrTemplate->Heading   = 0;
  FlrTemplate->Radius    = 0;
  FlrTemplate->Size      = 0;
  FlrTemplate->Speed     = 0;
  FlrTemplate->MovFunc   = NULL;
  FlrTemplate->ColFunc   = NULL;
  FlrTemplate->Flags     = WOBMOVED;
  FlrTemplate->ID        = 0;
  FlrTemplate->ObjDef[0] = 0;
  FlrTemplate->ObjDef[1] = 0;
  FlrTemplate->ObjDef[2] = 0;
  FlrTemplate->ObjDef[3] = 0;
  FlrTemplate->Data      = NULL;

  /*** Allocate FlrObj WObject Block ***/
  
  FirstFlrWOb = NULL;
  
  for(n=0;n<FlrObjDensity;n++) {
    idx = C3D_CloneWObject(FlrTemplate,NULLCOORD,NULLCOORD,0,0);
    if(idx<0) {
      printf("Could not allocate object for FlrObj\n");
      return -1;
      }
    if(FirstFlrWOb==NULL) FirstFlrWOb = &WObject[idx];
    }  

  return 0;
  }


/****** Populate FlrObj Block Randomly ******/

void C3D_PopulateFlrObj(void) {
  WORD n;
  LONG base,imgbase,x,y,i;
  struct ObjDef *obdf;
    
  base = FlrObjRange >> 10;             /* Base = (Range*2) / 2048 */
  imgbase = (2048/FlrObjCount)+1;
 
  for(n=0;n<FlrObjDensity;n++) {
    x = C3D_GetRand();
    y = C3D_GetRand();
    i = C3D_GetRand();

    x = (x*base)-FlrObjRange;
    y = (y*base)-FlrObjRange;    
    i /= imgbase;

    obdf = (struct ObjDef *) FlrObjTemp[i].Obdf;
    
    FirstFlrWOb[n].Wx        = VP->Wx + x;
    FirstFlrWOb[n].Wy        = VP->Wy + y;
    FirstFlrWOb[n].Height    = FlrObjTemp[i].Height; 
    FirstFlrWOb[n].Size      = obdf->Size;
    FirstFlrWOb[n].ObjDef[0] = (ULONG) obdf;  

    C3D_AllocAct(&FirstFlrWOb[n],0,0);    /* FlrObj's Permanently Active */
    LastPermAct = FirstFlrWOb[n].ActObj;  /* Record Last Perm Active Obj */
    }    
  }

/****** Update FlrObj's for Current VP x,y ******/

/* Check all entries of FlrObj block to see if within
   FlrObjRange if not the Object is reallocated to random
   location along the boundary oposite the one it crossed
*/

void C3D_UpdateFlrObj(void) {
  WORD n;
  LONG xl,xh,yl,yh,cx,cy;
  
  xl=VP->Wx-FlrObjRange;
  xh=VP->Wx+FlrObjRange;
  yl=VP->Wy-FlrObjRange;
  yh=VP->Wy+FlrObjRange;
 
  for(n=0;n<FlrObjDensity;n++) {
    cx = FirstFlrWOb[n].Wx;
    cy = FirstFlrWOb[n].Wy;
    
    if(cx < xl) FirstFlrWOb[n].Wx += (FlrObjRange<<1);
    else if(cx > xh) FirstFlrWOb[n].Wx -= (FlrObjRange<<1);
    else if(cy < yl) FirstFlrWOb[n].Wy += (FlrObjRange<<1);
    else if(cy > yh) FirstFlrWOb[n].Wy -= (FlrObjRange<<1);
    }
  }

/*******************************************/
/**** Set Pointer to Sky Image (Chunky) ****/
/*******************************************/

/* Returns 0 on success otherwise -1 */

WORD C3D_SetSkyImage(char *str) {
  LONG id,len;

  len = StrToLong(str,&id);
  if(len<1) {
    printf("Invalid value\n");
    return -1;
    }
    
  SkyImage = C3D_FindChnkImg(id);
  if(SkyImage==NULL) {
    printf("Invalid image ID specified\n");
    return -1;
    }

  if(SkyImage->PxWidth!=512 || SkyImage->PxHeight!=65) {
    SkyImage=NULL;
    printf("Sky image must be 512x65\n");
    return -1;
    }
    
  return 0;
  }

/*********************************************/
/**** Set Pointer to Floor Image (Chunky) ****/
/*********************************************/

/* Returns 0 on success otherwise -1 */

WORD C3D_SetFlrImage(char *str) {
  LONG id,len;

  len = StrToLong(str,&id);
  if(len<1) {
    printf("Invalid value\n");
    return -1;
    }
    
  FloorImage = C3D_FindChnkImg(id);
  if(FloorImage==NULL) {
    printf("Invalid image ID specified\n");
    return -1;
    }

  if(FloorImage->PxWidth<196 || FloorImage->PxHeight!=65) {
    FloorImage=NULL;
    printf("Sky image must be >196 wide & 65 high\n");
    return -1;
    }
    
  return 0;
  }

/************************************************/
/**** Set Pointer to 6x9 Font Image (Chunky) ****/
/************************************************/

/* Returns 0 on success otherwise -1 */

WORD C3D_Set6x9Image(char *str) {
  LONG id,len;

  len = StrToLong(str,&id);
  if(len<1) {
    printf("Invalid value\n");
    return -1;
    }
    
  Font6x9Image = C3D_FindChnkImg(id);
  if(Font6x9Image==NULL) {
    printf("Invalid image ID specified\n");
    return -1;
    }

  if(Font6x9Image->PxWidth<=96 || Font6x9Image->PxHeight<=54) {
    Font6x9Image=NULL;
    printf("6x9 Font image must be >96 wide & 54 high\n");
    return -1;
    }
    
  return 0;
  }

/****** Set Object Active Range ******/

WORD C3D_SetActRange(char *str) {

  StrToLong(str,&ActiveRange);
  
  if(ActiveRange<1) {
    printf("ACTRANGE must be at least 1 block\n");
    ActiveRange=SPWOBRNGDEF;
    return -1;
    } 

  if(ActiveRange>SPWOBRNGMAX) {
    printf("ACTRANGE must be less than %d blocks\n",SPWOBRNGMAX);
    ActiveRange=SPWOBRNGDEF;
    return -1;
    }

  return 0;
  }

/****** Load EHB(64) Colour Trans Table ******/

WORD C3D_LoadCT64(char *str) {
  LONG len,magic=0;
  BPTR handle = NULL;

  if(ColTran64 != NULL) {
    FreeVec(ColTran64);
    ColTran64 = NULL;
    }

  handle = Open(str, MODE_OLDFILE);
  if(!handle) {
    printf("Could not open colour trans table %s\n",str);
    return -1;
    }

  len = Read(handle, &magic, 4L);
  if(magic != COLTRAN64ID) {
    printf("Load failed %s in not of type CT64\n",str);
    Close(handle);
    return -1;
    } 

  ColTran64 = AllocVec(COLTRAN64SZ, MEMF_PUBLIC | MEMF_CLEAR);
  if(!ColTran64) {
    printf("Failed to Allocate Colour Trans table RAM\n");
    Close(handle);
    return -1;
    }

  len = Read(handle,ColTran64,COLTRAN64SZ);
  if(len != COLTRAN64SZ) {
    printf("Read Failed on Colour Trans Table %s\n",str);
    Close(handle);
    FreeVec(ColTran64);
    ColTran64 = NULL;
    return -1;
    }

  Close(handle);
  return 0;
  }
