/*****************************************/
/***  3D_Core Image Support Functions  ***/
/***    Copyright (c) J.Gregory 1995+  ***/
/***       Version 1.11  30/08/97      ***/
/*****************************************/



/******************************************************/
/*** Load 3D_Core Sprite file into appropriate list ***/
/******************************************************/

/* Returns -1 on failure otherwise 0 */

WORD C3D_LoadImage(UBYTE *file) {
	BPTR   handle = NULL;
	struct ImgHead ih;						
	LONG   len;
  WORD   ret = 0;
	
	handle = Open(file,MODE_OLDFILE);		  /* Open file */
	if(handle == NULL) return(-1);			  /* return error if failed */
	
	len = Read(handle,&ih,IMGHEAD_SIZE);	/* read header */
	if(len != IMGHEAD_SIZE) {				      /* if not read return error */
		Close(handle);
		return(-1);
		}
		
	if(ih.Magic == IMG_ID_CHNK) {			    /* Calc size image & load */
		len = ih.Width * ih.Height;
		ret = C3D_LoadChunky(handle,len,&ih);
		}

	if(ih.Magic == IMG_ID_PLAN) {
		len = ih.Width * ih.Height * ih.Depth;
		ret = C3D_LoadPlannar(handle,len,&ih);
		}
	
	Close(handle);							          /* Close file */
	return(ret);							            /* Return success */
	}

/*** Load & Link Chunky Image into List ***/

WORD C3D_LoadChunky(BPTR handle, LONG size, struct ImgHead *ih) {
	LONG len,block;
	struct ChnkImg *cimg;
  WORD n;
  UBYTE *ptr;

  cimg = C3D_FindChnkImg(ih->ID);            /* Is image allready loaded */
  if(cimg) {
    printf("Image %ld is allready loaded !!\n",ih->ID);
    return(-1);
    } 
	
	block=size+CHNKIMG_SIZE+(ih->Height*4);    /* Calc block size required */
	
 	cimg = AllocVec(block, MEMF_PUBLIC|MEMF_CLEAR);     /* Allocate memory */
	if(cimg == NULL) return(-1);
 
	Seek(handle, 0L, OFFSET_BEGINNING);		     /* Reset file ptr to start  */

	len = Read(handle,cimg,IMGHEAD_SIZE);      /* Read Disk File Header    */
	if(len != IMGHEAD_SIZE) {				           /* Check read O.K           */
		FreeVec(cimg);
		return(-1);
		}
	
	len = Read(handle,&cimg[1],size);		       /* Read image data block    */
	if(len != size) {						               /* Check read O.K.          */
		FreeVec(cimg);
		return(-1);
		}
	
  cimg->Size 	 = size;				               /* Fill in misc info        */
  cimg->Data   = (ULONG *) &cimg[1];         /* Calc pointer to data     */
  cimg->Next 	 = FirstChnkImg;		           /* Link into chunky chain   */
  cimg->Prev   = NULL;
  FirstChnkImg = cimg;                       /* Record as new 1st item   */
  
  if(cimg->Next) cimg->Next->Prev = cimg;    /* If next set backward ptr */
   
  /*** Calculate line table information ***/
   
	cimg->LineTab = (ULONG *) (((UBYTE *) cimg) + CHNKIMG_SIZE + size);
   
  ptr = (UBYTE *) cimg->Data;
      
  for(n=0;n<ih->Height;n++) {
    cimg->LineTab[n] = (ULONG) ptr;
    ptr += ih->Width;    
    }
   
	return(0);								                 /* Return success           */
 	}

/*** Load & Link Plannar Image into List ***/

WORD C3D_LoadPlannar(BPTR handle, LONG size, struct ImgHead *ih) {
	LONG len,block;
	struct PlanImg *pimg;

  pimg = C3D_FindPlanImg(ih->ID);            /* Is image allready loaded */
  if(pimg) {
    printf("Image %ld is allready loaded !!\n",ih->ID);
    return(-1);
    } 
	
	block = size+PLANIMG_SIZE;				         /* Calc block size required */
	
 	pimg = AllocVec(block, MEMF_PUBLIC|MEMF_CLEAR); /* Allocate memory     */
	if(pimg == NULL) return(-1);
 
	Seek(handle, 0L, OFFSET_BEGINNING);		     /* Reset file ptr to start  */
	
	len = Read(handle,pimg,IMGHEAD_SIZE);	     /* Read Disk File Header    */
	if(len != IMGHEAD_SIZE) {				           /* Check read O.K.          */
		FreeVec(pimg);
		return(-1);
		}

	len = Read(handle,&pimg[1],size);		       /* Read image data          */
	if(len != size) {						               /* Check read O.K.          */
		FreeVec(pimg);
		return(-1);
		}
	
	pimg->Size 	 = size / pimg->Depth;		     /* Fill in misc info        */
	pimg->Next 	 = FirstPlanImg;			         /* Link into plannar chain  */
  pimg->Prev   = NULL;
	FirstPlanImg = pimg;                       /* Record as new 1st item   */
	
  if(pimg->Next) pimg->Next->Prev = pimg;    /* If next set previous ptr */
   
	return(0);								                 /* Return success           */
 	}

/************************/
/*** Free Image Lists ***/
/************************/

void C3D_FreeImages(void) {
	struct ChnkImg *cimg;
	struct PlanImg *pimg;
	UBYTE *block;
	
	cimg = FirstChnkImg;					/* Get start of list             */
	
	while(cimg != NULL) {					/* De-allocate list contents     */
		block = (UBYTE *) cimg;
		cimg  = cimg->Next;
		FreeVec(block);
		}
		
	FirstChnkImg = NULL;					/* Flag list as empty            */
	
	pimg = FirstPlanImg;					/* Get start of list             */
	
	while(pimg != NULL) {					/* De-allocate list contents     */
		block = (UBYTE *) pimg;
		pimg = pimg->Next;
		FreeVec(block);
		}
	
	FirstPlanImg = NULL;					/* Flag list as empty            */

  SkyImage     = NULL;          /* Clear Backdrop image pointers */
  FloorImage   = NULL;
	}
	
	
/**********************************************/
/*** Find pointer to specified chunky image ***/
/**********************************************/

/* Parameter - ID  - Chunky image id to find           */
/* Returns   - PTR - Pointer to ChnkImg struct or NULL */

struct ChnkImg *C3D_FindChnkImg(UWORD ID) {
  struct ChnkImg *ci = FirstChnkImg;
   
  while(ci != NULL) {
    if(ci->ID == ID) break;
    ci = ci->Next; 
    }
   
  return(ci);
  }
   
/***********************************************/
/*** Find pointer to specified plannar image ***/
/***********************************************/

/* Parameter - ID  - Plannar image id to find          */
/* Returns   - PTR - Pointer to PlanImg struct or NULL */

struct PlanImg *C3D_FindPlanImg(UWORD ID) {
  struct PlanImg *pi = FirstPlanImg;
   
  while(pi != NULL) {
    if(pi->ID == ID) break;
    pi = pi->Next; 
    }
   
  return(pi);
  }
   

/***********************************/
/*** Free specified chunky image ***/
/***********************************/

/* Parameters - ID - Chunky image id to free */

void C3D_FreeChnkImg(UWORD ID) {

  struct ChnkImg *ci;
   
  ci = C3D_FindChnkImg(ID);                    /* Find specified image   */
  if(ci) {                                     /* Handle Floor/Sky Ptrs  */
    if(ci==SkyImage)   SkyImage=NULL;
    if(ci==FloorImage) FloorImage=NULL;
    }

  if(ci) {                                     /* If image found         */
    if(ci->Next) ci->Next->Prev = ci->Prev;    /* Unhook from back chain */
    if(ci->Prev) ci->Prev->Next = ci->Next;    /* Unhook from fwd chain  */

    /*** Un-hook from chain header if 1st item ***/
       
    if(ci == FirstChnkImg) FirstChnkImg = ci->Next;

    FreeVec(ci);                               /* Free allocated memory  */
    }
  }


/************************************/
/*** Free specified plannar image ***/
/************************************/

/* Parameters - ID - Plannar image id to free */

void C3D_FreePlanImg(UWORD ID) {

  struct PlanImg *pi;
   
  pi = C3D_FindPlanImg(ID);                   /* Find specified image    */

  if(pi) {                                    /* If image found          */
    if(pi->Next) pi->Next->Prev = pi->Prev;   /* Un-hook from back chain */
    if(pi->Prev) pi->Prev->Next = pi->Next;   /* Un-hook from fwd chain  */

    /*** Un-hook from chain header if 1st item ***/
       
    if(pi == FirstPlanImg) FirstPlanImg = pi->Next;

    FreeVec(pi);                              /* Free allocated memory   */
    }
  }


/********************************************/
/*** Plot Specified String using 6x9 Font ***/
/********************************************/

/* Params - str    - pointer to NULL terminated string
            x      - starting X co-ord
            y      - starting Y co-ord
            cshift - colour shift value
            
   NOTE - Background is transparant
*/

void C3D_Text6x9(char *str,WORD x, WORD y, WORD cshift) {
  WORD n=0,maxx,maxy,x1,y1;
  BYTE *src, *tgt, pix;
  
  maxx=WIDTH-6;
  maxy=HEIGHT-9;
  
  while(str[n]!=0) {
    if(x>0 && x<maxx && y>0 && y<maxy && str[n]>31) {

      pix=str[n]-32;  
      y1=pix>>4;
      x1=pix-(y1<<4);
      x1*=6;
      y1*=9;
      src=(BYTE *) Font6x9Image->LineTab[y1]+x1;
      tgt=(BYTE *) ChunkyTab[y]+x;

      for(y1=0;y1<9;y1++) {
        for(x1=0;x1<6;x1++) {
          pix = src[x1];
          if(pix) tgt[x1]=pix+cshift;
          }
        src+=Font6x9Image->PxWidth;
        tgt+=WIDTH;
        }
      }  
    x=x+6;
    n++;
    }
  }
