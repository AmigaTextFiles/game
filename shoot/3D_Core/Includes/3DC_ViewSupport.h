/**************************************************/
/****** Low level View/Viewport Support code ******/
/******        13/03/98 Version 2.05         ******/
/******  Copyright(c) Jon Gregory 1995-1998  ******/
/**************************************************/



/********************/
/*** Load My View ***/
/********************/

/* NOTE - Turns sprite DMA off */

void C3D_LoadView(void) {
  if(!C3D_ViewStatus) {               /* Check my view is not loaded */
    MakeVPort(&view0, &viewport0);    /* Make VP0 temp copper lists */
    MakeVPort(&view0, &viewport2);    /* Make VP2 temp copper lists */
    MrgCop(&view0);                   /* Merge VP0 lists into View0 list */

    MakeVPort(&view1, &viewport1);    /* Make VP1 temp copper lists */
    MrgCop(&view1);                   /* Merge VP1 lists into View1 list */

    WaitTOF();                        /* Wait for top of field */
    LoadView(&view0);                 /* Load game view */
       
    C3D_ViewStatus = 1;               /* Set my view loaded flag */
    C3D_ActPlane0  = bmap1.Planes[0]; /* Set active bmap pointer */

    custom->dmacon = DMAF_SPRITE;     /* Dissable Sprite DMA */
    }
  }

/********************************************/
/*** Un-load My View freeing copper lists ***/
/********************************************/

/* NOTE - turns sprite DMA on */

void C3D_FreeView(void) {
  if(C3D_ViewStatus) {                /* Check my views loaded        */
    custom->dmacon=
        DMAF_SETCLR | DMAF_SPRITE;    /* Enable Sprite DMA            */

    LoadView(oldview);                /* Load WB View                 */
    WaitTOF();                        /* Wait for top of display      */

    FreeCprList(view0.LOFCprList);    /* Free view0 copper lists      */
	
    if(view0.SHFCprList)
      FreeCprList(view0.SHFCprList);  /* If interlace free short list */
		
    FreeVPortCopLists(&viewport0);    /* Free VP0 temp lists          */

    FreeCprList(view1.LOFCprList);    /* Free view1 copper lists      */

    if(view1.SHFCprList)
      FreeCprList(view1.SHFCprList);  /* If interlace free short list */
		
    FreeVPortCopLists(&viewport1);    /* Free VP1 temp lists          */
    FreeVPortCopLists(&viewport2);    /* Free VP2 temp lists          */
    C3D_ViewStatus = 0;               /* Clear my view loaded flag    */
    C3D_ActPlane0  = NULL;            /* Clear active bmap pointer    */ 
    }
  }


/***************************************/
/*** Swap view ports (double buffer) ***/
/***************************************/

void C3D_SwapView(void) {
  switch (C3D_ViewStatus) {
    case 1:
      LoadView(&view1);
      C3D_ViewStatus = 2;
      C3D_ActPlane0  = bmap0.Planes[0]; 
      break;
    case 2:
      LoadView(&view0);
      C3D_ViewStatus = 1;
      C3D_ActPlane0  = bmap1.Planes[0]; 
      break;
    }
  }

/*****************************/
/*** Setup View Port Gumph ***/
/*****************************/

WORD C3D_InitDisplay(void) {
	
	WORD  c;
	LONG  size;

  struct TextAttr cpfont = {"topaz.font",8,0,0};

  ScrnRect.X1 = 0;       /* Define Screen Rectangle */
  ScrnRect.Y1 = 0;
  ScrnRect.X2 = WIDTH;
  ScrnRect.Y2 = HEIGHT;

  ClipRect.X1 = 0;       /* Define Cliping Rectangle */
  ClipRect.Y1 = 0;
  ClipRect.X2 = WIDTH-1;
  ClipRect.Y2 = HEIGHT-1;

  C3D_FreeDisplay();    /* Free if allready allocated */

  /*** Initialise Screen Line Start/End Table ***/
  
  ScrnWork = AllocVec(HEIGHT * 8, MEMF_CLEAR | MEMF_PUBLIC);
  if(ScrnWork == NULL) {
    printf("Could not allocate Screens Polygon Work Table\n");
    return(-1);
    }

	/*** Initialise Views & Store old ***/
	
	oldview=GfxBase->ActiView;		/* Store current view info */

	InitView(&view0);				/* Initialise View0 structure */
	view0.DxOffset = C3DPrefs->DxOffset;
	view0.DyOffset = C3DPrefs->DyOffset;

	InitView(&view1);				/* Initialise View1 structure */
	view1.DxOffset = C3DPrefs->DxOffset;
	view1.DyOffset = C3DPrefs->DyOffset;
	
	/*** Initialise BitMap structure ***/

	InitBitMap(&bmap0,PLANES,WIDTH,HEIGHT);		/* Initialise Bit Maps */
	InitBitMap(&bmap1,PLANES,WIDTH,HEIGHT);	
	for(c=0;c<8;c++) {
		bmap0.Planes[c]=NULL;		/* Init plane pointers */
		bmap1.Planes[c]=NULL;
		}

	/*** Intialise Control Panel BitMap structure ***/

	InitBitMap(&bmap2,CTRLPLANES,CTRLWIDTH,CTRLHEIGHT);
	for(c=0;c<8;c++) bmap2.Planes[c]=NULL;

	/*** Allocate blocks of RAM for contiguous bitplanes ***/
	
	size = RASSIZE(WIDTH,HEIGHT);
	bmap0.Planes[0] = AllocVec(PLANES * size, MEMF_CHIP | MEMF_CLEAR);	
	bmap1.Planes[0] = AllocVec(PLANES * size, MEMF_CHIP | MEMF_CLEAR);	
	if(bmap0.Planes[0] == NULL || bmap1.Planes[0] == NULL) {
		printf("Could not allocate bitplane memory");
		return(-1);
		};

	for(c=1;c<PLANES;c++) {
		bmap0.Planes[c] = bmap0.Planes[0]+(c*size);
		bmap1.Planes[c] = bmap1.Planes[0]+(c*size);
		}	

	/*** Allocate control panel screen contiguous bit planes ***/ 

	size = RASSIZE(CTRLWIDTH,CTRLHEIGHT);
	bmap2.Planes[0] = AllocVec(CTRLPLANES * size, MEMF_CHIP | MEMF_CLEAR);
	if(bmap2.Planes[0] == NULL) {
		printf("Could not allocate bitplane memory");
		return(-1);
		};

	for(c=1;c<CTRLPLANES;c++) bmap2.Planes[c] = bmap2.Planes[0]+(c*size);
	
	/*** Initialise RasInfo structures ***/
	
	rasinfo0.BitMap   = &bmap0;
	rasinfo0.RxOffset = 0;
	rasinfo0.RyOffset = 0;
	rasinfo0.Next     = NULL;
	
	rasinfo1.BitMap   = &bmap1;
	rasinfo1.RxOffset = 0;
	rasinfo1.RyOffset = 0;
	rasinfo1.Next     = NULL;

	rasinfo2.BitMap   = &bmap2;
	rasinfo2.RxOffset = 0;
	rasinfo2.RyOffset = 0;
	rasinfo2.Next     = NULL;

	/*** Intialise ViewPorts ***/
	
	InitVPort(&viewport0);
	view0.ViewPort	   = &viewport0;
	viewport0.RasInfo  = &rasinfo0;
	viewport0.DWidth   = WIDTH;
	viewport0.DHeight  = HEIGHT;
	viewport0.Modes	   |= EXTRA_HALFBRITE;
	viewport0.DxOffset = 0;
	viewport0.DyOffset = 1;
	viewport0.Next	   = &viewport2;
	
	InitVPort(&viewport1);
	view1.ViewPort	   = &viewport1;
	viewport1.RasInfo  = &rasinfo1;
	viewport1.DWidth   = WIDTH;
	viewport1.DHeight  = HEIGHT;
	viewport1.Modes	   |= EXTRA_HALFBRITE;
	viewport1.DxOffset = 0;
	viewport1.DyOffset = 1;
	viewport1.Next	   = &viewport2;
	
	InitVPort(&viewport2);
	viewport2.RasInfo  = &rasinfo2;
	viewport2.DWidth   = CTRLWIDTH;
	viewport2.DHeight  = CTRLHEIGHT;
	viewport2.DxOffset = 0;
	viewport2.DyOffset = 137;
	viewport2.Next	   = NULL;
		
	/*** Initialise colour map ***/
	
	cmap0 = GetColorMap((ULONG) 1L<<PLANES);
	cmap1 = GetColorMap((ULONG) 1L<<PLANES);
	cmap2 = GetColorMap((ULONG) 1L<<CTRLPLANES);
	if(cmap0 == NULL || cmap1 == NULL || cmap2 == NULL) {
		printf("Could not allocate colour map\n");
		return(-1);
		}
		
	viewport0.ColorMap = cmap0;
	viewport1.ColorMap = cmap1;
	viewport2.ColorMap = cmap2;

	if(C3D_LoadIFFCMap(ScrCMap,&viewport0,0)) return(-1);
	if(C3D_LoadIFFCMap(ScrCMap,&viewport1,0)) return(-1);
	if(C3D_LoadIFFCMap(PnlCMap,&viewport2,0)) return(-1);

  CPRPort = C3D_BuildRastPort(&bmap2, &cpfont);
  if(!CPRPort) return(-1); 

	return(0);
	}

/***************************/
/*** Load IFF Colour Map ***/
/***************************/

/* Flags : 0-CMAP Only  1-Image & CMAP (Not supported yet)

   Returns -1 on failure otherwise 0 

   NOTE - HAM un-supported, EHB requires a 32 colour CMAP chunk
          Colour 0 is allways set to RGB 0,0,0
*/

WORD C3D_LoadIFFCMap(BYTE *file, struct ViewPort *vp, UBYTE flags) {
	WORD	n,ret = 0;
	UWORD	cols,*ctab = NULL;
	UBYTE	red,grn,blu;

	struct	IFFHandle 		*iff	= NULL;
	struct	StoredProperty 	*sp		= NULL;
	struct	BitmapHeader	*bmhd	= NULL;
	
	if(vp->Modes & EXTRA_HALFBRITE) cols = 32;	/* EHB so cols = 32 */	
	else cols = 1<<vp->RasInfo->BitMap->Depth;	/* Calc no. of cols required */
	
	iff = AllocIFF();							/* Allocate IFF Handle */
	if(iff == NULL) {
		printf("AllocIFF failed\n");
		return(-1);
		}
		
	iff->iff_Stream = Open(file, MODE_OLDFILE);	/* Open IFF file */
	if(iff->iff_Stream == NULL) {
		printf("Could not open IFF CMAP file %s\n",file);
		ret = -1;
		goto LICM_Cleanup;
		}
		
	ctab = AllocVec(cols*2, MEMF_PUBLIC | MEMF_CLEAR); /* Allocate CMAP memory */
	if(ctab == NULL) {
		printf("Temp memory allocation failed (CMAP)\n");
		ret = -1;
		goto LICM_Cleanup;
		} 	
		
	InitIFFasDOS(iff);							/* Init IFFParse for DOS file */

	if(OpenIFF(iff,IFFF_READ)) {				/* Open read session */
		printf("OpenIFF failed\n");
		ret = -1;
		goto LICM_Cleanup;
		} 	
	else {
		PropChunk(iff,ID_ILBM,ID_CMAP);			/* Setup chunks to retrieve */
		PropChunk(iff,ID_ILBM,ID_BMHD);
		StopOnExit(iff,ID_ILBM,ID_FORM);		/* Set stop at end of FORM */
		
		ParseIFF(iff, IFFPARSE_SCAN);			/* Do parsing scan */

		sp = FindProp(iff,ID_ILBM,ID_BMHD);		/* Found a BMHD chunk ? */
		if(sp == NULL) {
			printf("No BMHD found\n");
			ret = -1;
			}
		else bmhd = (struct BitmapHeader *) sp->sp_Data;

		sp = FindProp(iff,ID_ILBM,ID_CMAP);		/* Found a CMAP chunk ? */
		if(sp == NULL) {
			printf("No CMAP found\n");
			ret = -1;
			}
		
		if(sp && bmhd) {						/* If CMAP & BMHD ok continue */
			if(cols != (1<<bmhd->nPlanes)) {
				printf("CMAP has wrong number of colours\n");
				ret = -1;
				}
			else {
				for(n=0;n<cols;n++) {
					red = (UBYTE) sp->sp_Data[(n*3)+0];	/* Get R,G,B Data         */
					grn = (UBYTE) sp->sp_Data[(n*3)+1];
					blu = (UBYTE) sp->sp_Data[(n*3)+2];
					red >>= 4;            							/* Mask out high bits     */
					grn >>= 4;
					blu >>= 4;
          if(n==0) red=grn=blu=0;             /* Colour 0 allways black */
					ctab[n]=(red<<8) | (grn<<4) | blu;	/* Write colour table     */
					}				
				LoadRGB4(vp , ctab, cols);    				/* Load colour table      */
				}
			}
		CloseIFF(iff);
		}

LICM_Cleanup:									/* Cleanup prior to return */
	if(ctab != NULL) FreeVec(ctab);
	if(iff->iff_Stream != NULL) Close(iff->iff_Stream);
	FreeIFF(iff);
	return(ret);
	}

/****************************************************/
/*** Build RastPort and attach to existing BitMap ***/
/****************************************************/

/* Dynamically allocs mem for TmpRas/AreaInfo/areabuffer/work bit plane */ 

/* Returns NULL or pointer to initialised rastport */

struct RastPort *C3D_BuildRastPort(struct BitMap *bm, struct TextAttr *ta) {
   struct RastPort *rp = NULL;
   struct AreaInfo *ai = NULL;
   struct TmpRas   *tr = NULL;
   struct TextFont *ft = NULL;

   BYTE  *ptr = NULL;

   rp = AllocVec(sizeof(struct RastPort),MEMF_CLEAR | MEMF_PUBLIC);
   if(rp) {
       InitRastPort(rp);                   /* Init rastport structure */
       rp->BitMap = bm;                    /* Link to related bitmap  */
       
       /**** Allocate memory for AreaInfo & Vertex buffer ****/
       
       ai = AllocVec(sizeof(struct AreaInfo),MEMF_CLEAR | MEMF_PUBLIC);
       if(ai == NULL) {
           printf("Could not allocate memory for AreaInfo structure");
           C3D_FreeRastPort(rp);
           return(NULL);
           }

       ptr = AllocVec(AREABUFSIZE,MEMF_CLEAR | MEMF_PUBLIC);
       if(ptr == NULL) {
           printf("Could not allocate memory for vertex buffer");
           C3D_FreeRastPort(rp);
           return(NULL);
           }

       InitArea(ai, ptr, AREABUFSIZE/5);   /* Init AreaInfo structure   */
       rp->AreaInfo = ai;                  /* Link AreaInfo to RastPort */
       
       /**** Allocate memory for TmpRas & temp bit plane ****/
       
       tr = AllocVec(sizeof(struct TmpRas),MEMF_CLEAR | MEMF_PUBLIC);
       if(tr == NULL) {
           printf("Could not allocate memory for TmpRas structure");
           C3D_FreeRastPort(rp);
           return(NULL); 
           }
           
       ptr = AllocVec(bm->BytesPerRow * bm->Rows,MEMF_CHIP | MEMF_CLEAR);
       if(ptr == NULL) {
           printf("Could not allocate chip memory for temp raster");
           C3D_FreeRastPort(rp);
           return(NULL);
           }
       
       InitTmpRas(tr, ptr, bm->BytesPerRow * bm->Rows); /* Init TmpRas      */
       rp->TmpRas = tr;                                 /* Link to RastPort */


       ft = OpenDiskFont(ta);              /* Open specified font */
       if(ft == NULL) {
           printf("Could not open specified font !!!");
           C3D_FreeRastPort(rp);
           return(NULL);
           }

       SetFont(rp, ft);                    /* Set font in rastport */
       }
   else printf("Could not allocate memory for RastPort structure");
   return(rp);
   }

   /**************************************************************/
   /*** Free Dynamically allocate RastPort & Related Resources ***/
   /**************************************************************/

void C3D_FreeRastPort(struct RastPort *rp) {
   
   if(rp->Font) CloseFont(rp->Font);

   if(rp->TmpRas) {
       if(rp->TmpRas->RasPtr) FreeVec(rp->TmpRas->RasPtr);
       FreeVec(rp->TmpRas);
       }
   
   if(rp->AreaInfo) {
       if(rp->AreaInfo->VctrTbl) FreeVec(rp->AreaInfo->VctrTbl);
       FreeVec(rp->AreaInfo);
       }
   
   FreeVec(rp);
   }
   
/***************************************/
/*** Free Low Level Display Elements ***/
/***************************************/

void C3D_FreeDisplay(void) {
  if(C3D_ViewStatus)	C3D_FreeView();             /* If view loaded remove it */

  if(CPRPort)         C3D_FreeRastPort(CPRPort);
  if(cmap0)           FreeColorMap(cmap0);        /* Free view related stuff  */
  if(cmap1)           FreeColorMap(cmap1);	
  if(cmap2)           FreeColorMap(cmap2);
  if(bmap0.Planes[0])	FreeVec(bmap0.Planes[0]);
  if(bmap1.Planes[0])	FreeVec(bmap1.Planes[0]);
  if(bmap2.Planes[0])	FreeVec(bmap2.Planes[0]);
  if(ScrnWork)        FreeVec(ScrnWork);          /* Free Poly Work Table */

  CPRPort         = NULL;
  cmap0           = NULL;
  cmap1           = NULL;
  cmap2           = NULL;
  bmap0.Planes[0] = NULL;
  bmap1.Planes[0] = NULL;  
  bmap2.Planes[0] = NULL;
  ScrnWork        = NULL;
	}



/**********************************************/
/*** Hibernate Game Engine & Show Workbench ***/
/**********************************************/

void C3D_Hibernate(void) {
  LONG x,y,oldcount = VBD.Count;
  
  struct Window *win = NULL;
  struct Screen *scr = NULL;
  
  scr = LockPubScreen(NULL);  /* Attempt to open Window */
  if(scr) {
    x = (scr->Width - 200)>>1;
    y = (scr->Height - 40)>>1;
    win = OpenWindowTags(NULL,
                         WA_Left,           x,
                         WA_Top,            y,
                         WA_Width,          200,
                         WA_Height,         40,
                         WA_DragBar,        TRUE,
                         WA_CloseGadget,    TRUE,
                         WA_DepthGadget,    TRUE,
                         WA_SmartRefresh,   TRUE,
                         WA_NoCareRefresh,  TRUE,
                         WA_IDCMP,          IDCMP_CLOSEWINDOW,
                         WA_Title,          "Close to Continue Game",
                         WA_PubScreen,      scr,
                         TAG_END);
    UnlockPubScreen(NULL,scr);
    }                     

  if(win) {
    LoadView(oldview);            /* Enable WB Display & Input Events */
    custom->dmacon=
      DMAF_SETCLR | DMAF_SPRITE;  /* Enable Sprite DMA */

    C3D_DissableIHandler();

    WaitPort(win->UserPort);      /* Wait for Close Gadget & Close Win */
    CloseWindow(win);

    C3D_EnableIHandler();         /* Re-load Game View & Swallow Input */
    custom->dmacon = DMAF_SPRITE; /* Dissable Sprite DMA */
    C3D_SwapView();
    }  
  
  VBD.Count = oldcount;           /* Fool VB interupt counter */
  }
