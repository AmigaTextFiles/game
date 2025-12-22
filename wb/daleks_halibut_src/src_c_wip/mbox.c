//=========================================================================
//=========================================================================
//
//	Daleks - message box routines
//
//	Copyright 1998 Halibut Software/John Girvin, All Rights Reserved
//
//	This file may not be distributed, reproduced or altered, in full or in
//	part, without written permission from John Girvin. Legal action will be
//	taken in cases where this notice is not obeyed.
//
//=========================================================================
//=========================================================================
#include	"Daleks.h"

static char new_arr1[40];
static char new_arr2[512];

//=========================================================================
// void mboxAttractMode(ULONG)
//
// Set message box contents for attract mode, depending on counter.
//=========================================================================
void mboxAttractMode(
						ULONG a_cnt
					)
{
	static ULONG  prvcnt = -1;
	       ULONG  cnt    = ((a_cnt >> 2) & 0x3);
	       ULONG  i;
	       char   tmpstr[40];

	if (cnt != prvcnt)
	{
		prvcnt = cnt;

		switch (cnt)
		{
			//=============================================================
			// "WELCOME, DOCTOR"...
			//=============================================================
			case 0:
				new_arr1[0] = '\0';
				sprintf(new_arr2,
						"\n"
						"\n"
						"\n" MUIX_B MUIX_C "%s"
						"\n"
						"\n" MUIX_N "%s"
						"\n"
						"\n"
						"\n"
						"\n"
						"\n",
						getStr(MSG_WELCOMEDR),
						getStr(MSG_CLICKNEWGAME)
					  );
				break;

			//=============================================================
			// Version & Copyright
			//=============================================================
			case 1:
				sprintf(new_arr1, MUIX_B MUIX_C "%s", Version + 6);
				sprintf(new_arr2,
						"\n" MUIX_N MUIX_C
						"\n"
						"\n%s"
						"\n"
						"\n%s"
						"\n%s"
						"\n"
						"\n"
						"\n"
						"\n",
						getStr(MSG_WRITTENBY),
						getStr(MSG_COPYRIGHT1),
						getStr(MSG_COPYRIGHT2));
				break;
			
			//=============================================================
			// Registration info
			//=============================================================
			case 2:
				sprintf(new_arr1, MUIX_B MUIX_C "%s", Version + 6);
				sprintf(new_arr2,
						"\n" MUIX_N MUIX_C
						"\n"
						"\n"
						"\n"
						"\n<< registration info >>");
				break;

			//=============================================================
			// HiScore table
			//=============================================================
			case 3:
				sprintf(new_arr1, MUIX_B MUIX_C "%s", getStr(MSG_TOPKILLERS));
				strcpy(new_arr2, "\n\n\n" MUIX_N MUIX_C);
				for (i = 0; i < 5; i++)
				{
					sprintf(tmpstr, "%4d     %s\n", 9999-i, "XXXXXXXX");
					strcat(new_arr2, tmpstr);
				}
				break;
		}

		SetAttrs(TX_Mbox1, MUIA_Text_Contents, new_arr1, TAG_DONE);
		SetAttrs(TX_Mbox2, MUIA_Text_Contents, new_arr2, TAG_DONE);
	}

	SetAttrs(GP_Mbox, MUIA_ShowMe, TRUE, TAG_DONE);
}

//=========================================================================
// void mboxLevelIntro(void)
//
// Set message box contents for level introduction
//=========================================================================
void mboxLevelIntro(
					void
				   )
{
	static ULONG  prvlev = -1;

	// Synonyms for "kill"
	static STRPTR ks_arr[] =
					{
						"kill"
						"destroy",
						"exterminate",
						"terminate",
						"eradicate",
						"wipe out",
						"waste",
						"total",
						"trash",
						"bash",
						"knacker",
						"write off",
						"smash"
					};
	       STRPTR ks_ptr;

	// Comments
	static STRPTR sc_arr[] =
					{
						"Ready to rumble?",
						"Armageddon of the Daleks?",
						"Kick Dalek ass!",
						"You die now, Doctor.",
						"Exterminate the muthas!",
						"I don't think they like you...",
						"Feeling lucky, punk?",
						"We're gonna get you...",
						"Need any help?",
						"Want to give up yet?",
						"Let's rock!"
					};
	       STRPTR sc_ptr;

	if (StateInfo.gs_level != prvlev)
	{
		// Choose random texts
		ks_ptr = ks_arr[rand() % 12];
		sc_ptr = sc_arr[rand() % 11];

		sprintf(new_arr1, MUIX_B MUIX_C "L E V E L  %d", StateInfo.gs_level);
		sprintf(new_arr2,
				"\n" MUIX_N MUIX_C
				"\n"
				"\n"
				"\n"
				"\n%d Daleks to %s."
				"\n"
				"\n%s"
				"\n"
				"\n",
				StateInfo.gs_ndal,
				ks_ptr, sc_ptr);

		SetAttrs(TX_Mbox1, MUIA_Text_Contents, new_arr1, TAG_DONE);
		SetAttrs(TX_Mbox2, MUIA_Text_Contents, new_arr2, TAG_DONE);
	}

	SetAttrs(GP_Mbox, MUIA_ShowMe, TRUE, TAG_DONE);
}
