#include <clib/gadtools_protos.h>
#include <clib/intuition_protos.h>
#include <exec/types.h>
#include <intuition/gadgetclass.h>
#include <stdio.h>
#include <string.h>

#include "defines.h"


/*	This function calculates all gadgetsizes and creates all gadgets
	for this window.
*/

BOOL CreateControlPanel (void)
{	struct Gadget *Gad;
	LONG Width;

	Gad = CreateContext (&(Panel.GList));

	CalcCheckbox (GAD_LIVES);
	CalcCheckbox (GAD_GUN);
	CalcCheckbox (GAD_INVIS);
	CalcCheckbox (GAD_THERMO);
	CalcCheckbox (GAD_BOUNCY);
	CalcCheckbox (GAD_GUNBOOST);

	CalcLabel (LAB_LIVES,   "Infinite lives");
	CalcLabel (LAB_GUN,     "Maximum gun power");
	CalcLabel (LAB_INVIS,   "Infinite invisibility");
	CalcLabel (LAB_THERMO,  "Infinite thermo glasses");
	CalcLabel (LAB_BOUNCY,  "Infinite bouncy bullets");
	CalcLabel (LAB_GUNBOOST,"Super gun boosts");

	CalcLabel (LAB_TRAINERS,"Trainers:");
	CalcButton (GAD_PLAY, "_Play");
	CalcButton (GAD_CANCEL, "_Cancel");
	CalcBlank (GAD_BLANK1, "|");

	Width = MAX(AllGads[GAD_PLAY].Width, AllGads[GAD_CANCEL].Width);
	AllGads[GAD_PLAY].Width   = Width;
	AllGads[GAD_CANCEL].Width = Width;

	BeginWindow (HORIZONTAL, WINDOWTITLE);
		PushColumn ();
			PushColumn ();
				GadgetAdd (LAB_TRAINERS);
			PopColumn ();
		PopColumn ();
		PushColumn ();
			PushColumn ();
				GadgetAdd (GAD_LIVES);
				GadgetAdd (GAD_GUN);
				GadgetAdd (GAD_INVIS);
				GadgetAdd (GAD_THERMO);
				GadgetAdd (GAD_BOUNCY);
				GadgetAdd (GAD_GUNBOOST);
				GadgetAdd (GAD_BLANK1);
			PopColumn ();
			PushColumn ();
				GadgetAdd (LAB_LIVES);
				GadgetAdd (LAB_GUN);
				GadgetAdd (LAB_INVIS);
				GadgetAdd (LAB_THERMO);
				GadgetAdd (LAB_BOUNCY);
				GadgetAdd (LAB_GUNBOOST);
				GadgetAdd (GAD_BLANK1);
			PopColumn ();
		PopColumn ();
		PushColumn ();
			GadgetAdd (GAD_PLAY);
			GadgetAdd (GAD_CANCEL);
		PopColumn ();
		AlignToRight (GAD_CANCEL);
	EndWindow ();

	// Create the actual gadgets
	CreateLabel (&Gad, LAB_TRAINERS);

	CreateCheckbox (&Gad, GAD_LIVES);
	CreateCheckbox (&Gad, GAD_GUN);
	CreateCheckbox (&Gad, GAD_INVIS);
	CreateCheckbox (&Gad, GAD_THERMO);
	CreateCheckbox (&Gad, GAD_BOUNCY);
	CreateCheckbox (&Gad, GAD_GUNBOOST);

	CreateLabel (&Gad, LAB_LIVES);
	CreateLabel (&Gad, LAB_GUN);
	CreateLabel (&Gad, LAB_INVIS);
	CreateLabel (&Gad, LAB_THERMO);
	CreateLabel (&Gad, LAB_BOUNCY);
	CreateLabel (&Gad, LAB_GUNBOOST);

	CreateButton (&Gad, GAD_PLAY);
	CreateButton (&Gad, GAD_CANCEL);

	// All gadgets have been added
	if (!Gad) return FALSE;

	return TRUE;
}
