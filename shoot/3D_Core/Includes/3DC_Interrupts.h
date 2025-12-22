/************************************/
/***  3D Core Interrupts Support  ***/
/***    Version 1.01  30/08/97    ***/
/*** Copyright (c) J.Gregory 1995 ***/
/************************************/


/******************************************/
/*** Install Interrupt Handlers/Servers ***/
/******************************************/

/* Returns -1 on failure or 0 on success */

WORD C3D_InitInts(void) {

  C3D_FreeInts();                              /* Free if allready installed */
   
  VBInt =  AllocVec(sizeof(struct Interrupt), MEMF_PUBLIC | MEMF_CLEAR);
  if(VBInt == NULL) {
    printf("No RAM for VBlank Interrupt structure\n");
    return -1;
    }

  VBInt->is_Node.ln_Type = NT_INTERRUPT;       /* Setup Interupt Chain Node */
  VBInt->is_Node.ln_Pri  = -60;
  VBInt->is_Node.ln_Name = VBIntName;
  VBInt->is_Data         = (APTR) &VBD.Count;
  VBInt->is_Code         = ASM_VertBServer;
  AddIntServer(INTB_VERTB, VBInt);             /* Install it ! */

  return 0;
  }

/*******************************************/
/*** Remove any installed Interrupt Code ***/
/*******************************************/

void C3D_FreeInts(void) {
  if(VBInt != NULL) {                   /* Remove & Free VB if installed */
    RemIntServer(INTB_VERTB, VBInt);
    FreeVec(VBInt);
    VBInt = NULL;
    }
  }
