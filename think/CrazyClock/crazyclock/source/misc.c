/*
 * misc.c V1.1
 *
 * miscellaneous support routines
 *
 * (c) 1992-1993 Holger Brunst
 */

#include <CClock.h> 

/* Wait pointer image data */
static __chip const UWORD WaitPointer[] = {
                                           0x0000, 0x0000,

                                           0x0400, 0x07c0,
                                           0x0000, 0x07c0,
                                           0x0100, 0x0380,
                                           0x0000, 0x07e0,
                                           0x07c0, 0x1ff8,
                                           0x1ff0, 0x3fec,
                                           0x3ff8, 0x7fde,
                                           0x3ff8, 0x7fbe,
                                           0x7ffc, 0xff7f,
                                           0x7efc, 0xffff,
                                           0x7ffc, 0xffff,
                                           0x3ff8, 0x7ffe,
                                           0x3ff8, 0x7ffe,
                                           0x1ff0, 0x3ffc,
                                           0x07c0, 0x1ff8,
                                           0x0000, 0x07e0,

                                           0x0000, 0x0000
                                          };

/* Disable a window */
void DisableWindow(struct Window *w)
{
 /* Disable right mouse button */
 w->Flags |= WFLG_RMBTRAP;

 /* Disable IDCMP */
 ModifyIDCMP(w, IDCMP_REFRESHWINDOW);

 /* Set wait pointer */
 SetPointer(w, WaitPointer, 16, 16, -6, 0);
}

/* Enable a window */
void EnableWindow(struct Window *w, ULONG idcmp)
{
 /* Clear wait pointer */
 ClearPointer(w);

 /* Enable IDCMP */
 ModifyIDCMP(w, idcmp);

 /* Enable right mouse button */
 w->Flags &= ~WFLG_RMBTRAP;
}

/* Remove all remaining messages from message port */
static void StripIntuiMessages(struct MsgPort *mp, struct Window *win)
{
 struct IntuiMessage    *msg;
 struct Node            *succ;

 msg = (struct IntuiMessage *) mp->mp_MsgList.lh_Head;

 while (succ = msg->ExecMessage.mn_Node.ln_Succ) {

  if (msg->IDCMPWindow ==  win) {

   /* Intuition is about to free this message.
    * Make sure that we have politely sent it back.
    */
   Remove((struct Node *) msg);
   ReplyMsg((struct Message *) msg);
  }
  msg = (struct IntuiMessage *) succ;
 }
}

/* Close a window safely */
void CloseWindowSafely(struct Window *win)
{
 /* we forbid here to keep out of race conditions with Intuition */
 Forbid();

 /* send back any messages for this window 
  * that have not yet been processed
  */
 StripIntuiMessages(win->UserPort, win);

 /* clear UserPort so Intuition will not free it */
 win->UserPort = NULL;

 /* tell Intuition to stop sending more messages */
 ModifyIDCMP(win, 0L);

 /* turn multitasking back on */
 Permit();

 /* and really close the window */
 CloseWindow(win);
}

/* Create a list of GT gadgets */
struct Gadget *CreateGadgetList(struct GadgetData *gData, ULONG gadNum, ULONG idOffset)
{
 struct Gadget      *ClockGads, *gad;
 struct NewGadget   NewGad;
 ULONG              i;

 /* Create GadTools gadget context */
 ClockGads = NULL;
 if (gad = CreateContext(&ClockGads)) {
  NewGad.ng_TextAttr = &GrntAttr;
  NewGad.ng_VisualInfo = ScreenVI;
  for (i = 0; i < gadNum; i++, gData++) {
   NewGad.ng_LeftEdge=gData->left;
   NewGad.ng_TopEdge=gData->top;
   NewGad.ng_Width=gData->width;
   NewGad.ng_Height=gData->height;
   NewGad.ng_GadgetText=gData->name;
   NewGad.ng_GadgetID=i+idOffset;
   NewGad.ng_Flags=gData->flags;

   /* Create Gadget */  
   if (!(gad =
   CreateGadgetA(gData->type, gad, &NewGad, gData->tags))) break;

   /* Store gadget pointer in GadgetData structure */ 
   gData->gadget=gad;
  }
  /* Gadgets created? */
  if (gad) return (ClockGads); 

  /* Couldn't create gadgets */
  FreeGadgets(ClockGads);
 } 
 /* Return failure */
 return (NULL);
}

/* I was to lousy to write any special kind of routine in order to switch
   between the two sides. So I decided to simply zoom it */ 
static USHORT  buf[32];  
void Zoom(struct Screen *s, USHORT *p, short num)
{
 long i, steps;
 struct ColorMap *cm = s->ViewPort.ColorMap;

 /* Read current screen colors */
 for (i = 0; i < num; i++)
  buf[i] = GetRGB4(cm, i);

 /* Change screen colors in 16 steps */
 for (steps = 0; steps < 16; steps++) {
  /* Wait for vertical blank to syncronize zoom function */ 
  WaitTOF();

  /* Change 'num' color registers */
  for (i = 0; i < num; i++) {
   /* increase/decrease RGB values */ 
   if (p[i] != ~0) {
    if ((buf[i] & 0xf00) > (p[i] & 0xf00))		
     buf[i] -= 0x100;
    else if ((buf[i] & 0xf00) < (p[i] & 0xf00))
     buf[i] += 0x100;

    if ((buf[i] & 0xf0) > (p[i] & 0xf0))		
     buf[i] -= 0x10;
    else if ((buf[i] & 0xf0) < (p[i] & 0xf0))
     buf[i] += 0x10;

    if ((buf[i] & 0xf) > (p[i] & 0xf))		
     buf[i] -= 0x1;
    else if ((buf[i] & 0xf) < (p[i] & 0xf))
     buf[i] += 0x1;
   }
  }
  /* Display new pallete */
  LoadRGB4(&s->ViewPort, buf, num); 
 }
}

/* Load Iff-image
   This routine is very stupid but it works with my picture */
struct BitMap *OpenILBM(UBYTE *Name)
{
 UBYTE  *planes;
 USHORT *palette, color;
 long   *iffData;

 short  planeX, numRows;
 long   planeSize, buffer[2];

 REGISTER BYTE		*dest, repByte;
 REGISTER short		byteSum, numBytes;
 REGISTER union {
  BYTE	*B;
  WORD	*W;
  long	*L;
 } uniPtr;

 struct BitMap		*map;
 struct FileHandle	*iffHandle;

 /* Open iff image data */
 if (iffHandle = (struct FileHandle *) Open(Name, MODE_OLDFILE)) {
  /* Read image file */
  if (Read((BPTR) iffHandle, &buffer[0], 8) == 8) {
   /* Iff ? */
   if (buffer[0] == 'FORM') {
    /* Get memory for image */
	if (iffData = AllocMem(buffer[1], MEMF_PUBLIC)) {
     /* Memory for BitMap structure */
	 if (map = (struct BitMap *)
           AllocMem(sizeof (struct BitMap) + 64, MEMF_PUBLIC | MEMF_CLEAR)) {
      /* Read first chunk */
      if (Read((BPTR)iffHandle, iffData, buffer[1]) == buffer[1]) {
       /* Analyse iff */
       uniPtr.L = iffData;
       if (*uniPtr.L++ == 'ILBM') {
        if (*uniPtr.L++ == 'BMHD') {
         InitBitMap(map, uniPtr.B[12], uniPtr.W[2], uniPtr.W[3]);
         uniPtr.B += *uniPtr.L + 4; 
         /* Read color map */
         if (*uniPtr.L == 'CMAP') {
          planes = (UBYTE *) uniPtr.B + 8;		
          palette = (USHORT *) &map->Planes[6];

          for (planeX = 1 << map->Depth; planeX > 0; --planeX) {
           color = *planes++ << 4;
           color |= *planes++;		
           *palette++ = color | *planes++ >> 4;
          }
          /* Find body */
          while (*uniPtr.L != 'BODY') {
           ++uniPtr.L;
           uniPtr.B += *uniPtr.L + 4;
           if (uniPtr.B >= (BYTE *) iffData + buffer[1])
            break;
          }
          /* Read Body */
          if (*uniPtr.L == 'BODY') {
           planeSize = map->BytesPerRow * map->Rows;
           if (planes = (UBYTE *)
                AllocMem(planeSize * map->Depth, MEMF_CHIP)) {
			for (planeX = 0; planeX < map->Depth; ++planeX) 
             map->Planes[planeX] = (PLANEPTR) planes + planeSize * planeX;
             /* Decrunch image */
            uniPtr.L += 2;
            for (numRows = map->Rows; numRows > 0; --numRows) {
	         for (planeX = 0; planeX < map->Depth; ++planeX) {
		      byteSum = map->BytesPerRow;
		      dest = (BYTE *) map->Planes[planeX];
		      do {
			   if ((numBytes = *uniPtr.B++) < 0) {
               numBytes = -numBytes;
               repByte = *uniPtr.B++;

               byteSum -= numBytes+1;
               for (; numBytes > -1; --numBytes)
                *dest++ = repByte;
               }
               else {
				byteSum -= numBytes+1;
				for (; numBytes > -1; --numBytes)
                 *dest++ = *uniPtr.B++;
               }
              } while (byteSum > 0);
              map->Planes[planeX] += map->BytesPerRow;
             }
            }
            for (planeX = 0; planeX < map->Depth; ++planeX) 
             map->Planes[planeX] = map->Planes[planeX] - planeSize;

            Close((BPTR)iffHandle);
			FreeMem(iffData, buffer[1]);

			return (map);
           }		
	      }
         }
        }
       }
	  } FreeMem(map, sizeof (struct BitMap) + 64);
     } FreeMem(iffData, buffer[1]);
    }
   }
  } Close((BPTR)iffHandle);
 } return (FALSE);
}
/* Get rid of the image */
void CloseILBM(map)
struct BitMap *map;
{
 FreeMem(map->Planes[0], map->BytesPerRow * map->Rows * map->Depth);
 FreeMem(map, sizeof (struct BitMap) + 64);
}
