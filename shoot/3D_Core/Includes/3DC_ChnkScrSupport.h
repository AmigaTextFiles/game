/*************************************/
/*** 3D_Core Chunky Screen Support ***/
/***  Copyright(c) J.Gregory 1995  ***/
/***     Version 1.01 23/08/97     ***/
/*************************************/



/************************************************************/
/*** Allocate buffers for chunky screen & it's line table ***/
/************************************************************/

/* Paramaters - width and height of chunky screen required */
/* Returns    - -1 on failure otherwise 0                  */

WORD C3D_InitChunkyScr(UWORD width,UWORD height) {
   UWORD n;
   UBYTE *ptr;
   
   C3D_FreeChunky();    /* Free if allready allocated */
   
   /** Allocate memory blocks **/

   ChunkyScr = AllocVec(width*height,MEMF_PUBLIC|MEMF_CLEAR);
   if(ChunkyScr == NULL) return(-1);
   
   ChunkyTab = AllocVec(height*4,MEMF_PUBLIC|MEMF_CLEAR);
   if(ChunkyTab == NULL) {
       C3D_FreeChunky();
       return(01);
       }
       
   /** Fill in chunky yable **/

   ptr = (UBYTE *) ChunkyScr;

   for(n=0;n<height;n++) {
       ChunkyTab[n] = (ULONG) ptr;
       ptr+=width;
       }
           
   return(0);
   }

/*****************************************/
/*** Free chunky screen related memory ***/
/*****************************************/

void C3D_FreeChunky(void) {
  if(ChunkyScr != NULL) FreeVec(ChunkyScr);
  if(ChunkyTab != NULL) FreeVec(ChunkyTab);
  if(ColTran64 != NULL) FreeVec(ColTran64);
  ChunkyScr = NULL; 
  ChunkyTab = NULL;
  ColTran64 = NULL;
  }
