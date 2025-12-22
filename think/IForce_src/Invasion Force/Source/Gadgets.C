
/* Gadgets.H - functions for easy gadget handling */

#include <intuition/intuition.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
#include <graphics/gfxmacros.h>
#include "gadgets_protos.h"

#define FI }
#define OD }

void ZapGadget(gadget,rpt)
struct Gadget *gadget;
struct RastPort *rpt;
{
	short x1,y1,x2,y2;

	x1= gadget->LeftEdge;
	x2= x1+ gadget->Width-1;
	y1= gadget->TopEdge;
	y2= y1+ gadget->Height-1;

	RectFill(rpt,x1,y1,x2,y2);
}

void ZapGList(gadget,window,num)
struct Gadget *gadget;
struct Window *window;
short num;
{
	short ctr;
	struct RastPort *rpt;

	rpt= window->RPort;
	SetDrMd(rpt,JAM1);
	SetAPen(rpt,0);
	for (ctr=0; ctr<num; ctr++) {
		ZapGadget(gadget,rpt);
		gadget= gadget->NextGadget;
		if (gadget==NULL)
			break;
	OD
}

int selected(gadget)
struct Gadget *gadget;
{
	if ( gadget->Flags & SELECTED )
		return TRUE;
	else
		return FALSE;
}

void select(gadget)
struct Gadget *gadget;
{
	if ( !selected(gadget) )
		gadget->Flags += SELECTED;
}

void unselect(gadget)
struct Gadget *gadget;
{
	if ( selected(gadget) )
		gadget->Flags -= SELECTED;
}

int disabled(gadget)
struct Gadget *gadget;
{
	if ( gadget->Flags & GADGDISABLED )
		return TRUE;
	else
		return FALSE;
}

void enable(gadget)
struct Gadget *gadget;
{
	if ( disabled(gadget) )
 		gadget->Flags -= GADGDISABLED;
}

void disable(gadget)
struct Gadget *gadget;
{
	if ( !disabled(gadget) )
		gadget->Flags += GADGDISABLED;
}

void EnableGList(gadget,number)
struct Gadget *gadget;
int number;
{
	int ctr;

	for (ctr=1; ctr<=number; ctr++) {
		enable(gadget);
		gadget= gadget->NextGadget;
	OD
}

void DisableGList(gadget,number)
struct Gadget *gadget;
int number;
{
	int ctr;

	for (ctr=1; ctr<=number; ctr++) {
		unselect(gadget);
		disable(gadget);
		gadget= gadget->NextGadget;
	OD
}

void setselect(gadget,flag)
struct Gadget *gadget;
short flag;
{
	if (flag)
		select(gadget);
	else
		unselect(gadget);
}

void show_depress(gadget,rpt)
struct Gadget *gadget;
struct RastPort *rpt;
{	// show the gadget depressed, as if by the mouse
	short x1,y1,x2,y2;

	x1= gadget->LeftEdge;
	x2= x1+ gadget->Width-1;
	y1= gadget->TopEdge;
	y2= y1+ gadget->Height-1;

	SetWrMsk(rpt,3);
	SetDrMd(rpt,COMPLEMENT);
	RectFill(rpt,x1,y1,x2,y2);
	SetDrMd(rpt,JAM1);
	SetWrMsk(rpt,15);
}

/* end of listing */
