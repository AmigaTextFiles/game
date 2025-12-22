
// p_nhmenu.h
//
// Night Hunters menu
//
// Originally coded by DingBat
//
// Copyright (c), 1999 The BatCave. All Rights Reserved.
//============================================================================

// CTF-like menu for NH

#include "g_local.h"
#include "g_cmd_observe.h"

void ShowNHMenu(edict_t *ent) ;
void ShowNHInfoMenu(edict_t *ent, pmenu_t *p) ;
void ShowNHHelpMenu(edict_t *ent, pmenu_t *p) ;
void ShowNHHelpMenu2(edict_t *ent, pmenu_t *p) ;
void ShowNHHelpMenu3(edict_t *ent, pmenu_t *p) ;
void ShowNHHelpMenu4(edict_t *ent, pmenu_t *p) ;
void ShowNHHelpMenu5(edict_t *ent, pmenu_t *p) ;
void ShowNHAdminMenu(edict_t *ent, pmenu_t *p) ;
void ShowNHModelsMenu(edict_t *ent, pmenu_t *p) ;
void ShowNHCreditsMenu(edict_t *ent, pmenu_t *p) ;
void ReturnToNHMainMenu(edict_t *ent, pmenu_t *p) ;
void CloseNHMenu(edict_t *ent, pmenu_t *p) ;
void EnterGame(edict_t *ent, pmenu_t *p) ;
void ObserveGame(edict_t *ent, pmenu_t *p) ;
void ChaseCam(edict_t *ent, pmenu_t *p) ;
void SetupBindings(edict_t *ent, pmenu_t *p);

// Menu initialization.

pmenu_t NHInfoMenu[20];
pmenu_t NHModelsMenu[20];
//20 lines max - probably too much
char infotext[50][50];

pmenu_t NHMenu[] = {
  { "* Night Hunters 1.5", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Server Info", PMENU_ALIGN_LEFT, NULL, ShowNHInfoMenu},
  { "Help/Bindings", PMENU_ALIGN_LEFT, NULL, ShowNHHelpMenu},
  { "Models used", PMENU_ALIGN_LEFT, NULL, ShowNHModelsMenu},
  { "Credits", PMENU_ALIGN_LEFT, NULL, ShowNHCreditsMenu },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Spectator/chase mode", PMENU_ALIGN_LEFT, NULL, ObserveGame },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "*Press your flashlight key", PMENU_ALIGN_CENTER, NULL, NULL },
  { "*to Enter game", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "*Type SETUP at console to", PMENU_ALIGN_CENTER, NULL, NULL },
  { "*set default bindings", PMENU_ALIGN_CENTER, NULL, NULL },

  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "[ and ] to scroll up/down", PMENU_ALIGN_CENTER, NULL, NULL },
  { "ENTER key to select option", PMENU_ALIGN_CENTER, NULL, NULL },
  { "TAB key twice displays menu", PMENU_ALIGN_CENTER, NULL, NULL },
  { "ESC closes menu", PMENU_ALIGN_CENTER, NULL, NULL },

};


pmenu_t NHHelpMenu[] = {
  { "*Help Menu - Page 1 of 5", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "As Marine", PMENU_ALIGN_CENTER, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "you hunt", PMENU_ALIGN_CENTER, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "the Mutant-Marine", PMENU_ALIGN_CENTER, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "code name: PREDATOR", PMENU_ALIGN_CENTER, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "to become the Predator", PMENU_ALIGN_CENTER, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { "Next", PMENU_ALIGN_CENTER, NULL, ShowNHHelpMenu2 },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { "Back", PMENU_ALIGN_CENTER, NULL, ReturnToNHMainMenu },
};
pmenu_t NHHelpMenu2[] = {
  { "*Help Menu - Page 2 of 5", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "If you are a Marine,", PMENU_ALIGN_CENTER, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { "do NOT kill", PMENU_ALIGN_CENTER, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "or shoot", PMENU_ALIGN_CENTER, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { "other -Marines- !!!", PMENU_ALIGN_CENTER, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { "Next", PMENU_ALIGN_CENTER, NULL, ShowNHHelpMenu3 },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { "Back", PMENU_ALIGN_CENTER, NULL, ShowNHHelpMenu },
};
pmenu_t NHHelpMenu3[] = {
  { "*Help Menu - Page 3 of 5", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Sample bindings:", PMENU_ALIGN_CENTER, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "*g flashlight", PMENU_ALIGN_LEFT, NULL, NULL},
  { "*v gunscope (pred only)", PMENU_ALIGN_LEFT, NULL, NULL},
  { "*f flare    (marine only)", PMENU_ALIGN_LEFT, NULL, NULL},
  { "*e anchor   (pred teleport)", PMENU_ALIGN_LEFT, NULL, NULL},
  { "*r recall   (pred teleport)", PMENU_ALIGN_LEFT, NULL, NULL},
  { "*o overload (pred only)", PMENU_ALIGN_LEFT, NULL, NULL},
  { "*q spotrep  (marine only)", PMENU_ALIGN_LEFT, NULL, NULL},
  { "*m menu", PMENU_ALIGN_LEFT, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { "More Examples", PMENU_ALIGN_CENTER, NULL, ShowNHHelpMenu4 },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { "Back", PMENU_ALIGN_CENTER, NULL, ShowNHHelpMenu2 },
};
pmenu_t NHHelpMenu4[] = {
  { "*Help Menu - Page 4 of 5", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "For EXAMPLE:", PMENU_ALIGN_CENTER, NULL, NULL},
  { "To bind your keys,", PMENU_ALIGN_CENTER, NULL, NULL},
  { "Open the Quake2 console", PMENU_ALIGN_CENTER, NULL, NULL},
  { "by hitting the ~ <tilde> key", PMENU_ALIGN_CENTER, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "(it's under the ESCape key)", PMENU_ALIGN_CENTER, NULL, NULL},
  { "and type:", PMENU_ALIGN_CENTER, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "bind kp_minus overload", PMENU_ALIGN_LEFT, NULL, NULL},
  { "bind kp_ins flashlight", PMENU_ALIGN_LEFT, NULL, NULL},
  { "bind alt flare", PMENU_ALIGN_LEFT, NULL, NULL},
  { "bind home gunscope", PMENU_ALIGN_LEFT, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { "Next", PMENU_ALIGN_CENTER, NULL, ShowNHHelpMenu5 },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { "Back", PMENU_ALIGN_CENTER, NULL, ShowNHHelpMenu3 },
};

pmenu_t NHHelpMenu5[] = {
  { "*Help Menu - Page 5 of 5", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Type SETUP at the Quake2", PMENU_ALIGN_CENTER, NULL, NULL},
  { "console for the default", PMENU_ALIGN_CENTER, NULL, NULL},
  { "bindings shown on page 3", PMENU_ALIGN_CENTER, NULL, NULL},
  { "*OR", PMENU_ALIGN_CENTER, NULL, NULL},
  { "choose SET BINDINGS", PMENU_ALIGN_CENTER, NULL, NULL},
  { "below", PMENU_ALIGN_CENTER, NULL, NULL},   
  { "*OR", PMENU_ALIGN_CENTER, NULL, NULL},   
  { "bind them yourself by hand", PMENU_ALIGN_CENTER, NULL, NULL},   
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { "*To join the game", PMENU_ALIGN_CENTER, NULL, NULL},
  { "*press your FLASHLIGHT key!!!", PMENU_ALIGN_CENTER, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { "Back", PMENU_ALIGN_CENTER, NULL, ShowNHHelpMenu4 },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { "SET BINDINGS", PMENU_ALIGN_CENTER, NULL, SetupBindings },
};
                                  


pmenu_t NHAdminMenu[] = {
  { "*Admin Menu", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Restricted access", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Back", PMENU_ALIGN_CENTER, NULL, ReturnToNHMainMenu },
};

pmenu_t NHCreditsMenu[] = {
  { "*Credits", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Lead Programmer:", PMENU_ALIGN_CENTER, NULL, NULL },
  { "*dingbat@fragit.net", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Asst Programmer:", PMENU_ALIGN_CENTER, NULL, NULL },
  { "*batmax@fragit.net", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Instigator:", PMENU_ALIGN_CENTER, NULL, NULL },
  { "*batcat@fragit.net", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Original mod by:", PMENU_ALIGN_CENTER, NULL, NULL },
  { "*Majoon", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "www.planetquake.com", PMENU_ALIGN_CENTER, NULL, NULL },
  { "/nighthunters", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Back", PMENU_ALIGN_CENTER, NULL, ReturnToNHMainMenu },
};


// Show the NH menu.
void ShowNHMenu (edict_t *ent)
{

  if (ent->client->menu) {		//is menu opened already?  If so, close
    PMenu_Close(ent);
    return;
  } 		

  //Moved from the p_menu.c code for NH.  If menu open, close instead
  if (ent->client->showinventory)
    ent->client->showinventory = false;	//close inventory before opening menu

  PMenu_Close(ent);

  PMenu_Open(ent, NHMenu, -1, sizeof(NHMenu) / sizeof(pmenu_t));

  //  gi.sound(ent, CHAN_VOICE, 
  //   gi.soundindex("misc/pc_up.wav"), 1, ATTN_STATIC, 0) ;
} 

void ShowNHInfoMenu(edict_t *ent, pmenu_t *p)
{

  char motd[500];
  char line[80];
  int i=0;
  FILE *motd_file;

  if (motd_file = fopen("nhunters/info.txt", "r"))
  {
    // we successfully opened the file "motd.txt"
    if ( fgets(motd, 500, motd_file) )              
        {
	  // we successfully read a line from "motd.txt" into motd
	  // ... read the remaining lines now
	  while (( fgets(line, 80, motd_file) ) && (i <20))
	    {
	      // add each new line to motd, to create a BIG message string.
	      // we are using strcat: STRing conCATenation function here.
	      strcpy(infotext[i],line);
	      NHInfoMenu[i].text=infotext[i];
	      NHInfoMenu[i].align=PMENU_ALIGN_CENTER;
	      NHInfoMenu[i].arg=NULL;
	      NHInfoMenu[i].SelectFunc=NULL;
	      i++; 
	    }
	  
	}
    // be good now ! ... close the file
    fclose(motd_file);
  }
  else
    {
      // can't find motd.txt file, so fill with null..
      i=0;
      while (i <= 20)
  	{
	  NHInfoMenu[i].text=NULL;
	  NHInfoMenu[i].align=PMENU_ALIGN_CENTER;
	  NHInfoMenu[i].arg=NULL;
	  NHInfoMenu[i].SelectFunc=NULL;
	  i++; 
	}
      i=1;
    }
  //if the file wasn't there, we just make up our own motd
  //else
  //	gi.centerprintf (newplayer, "Night Hunters %s\nhttp://nhunters.gameplex.net\n", NHVER);
  
  strcpy(infotext[i],"Back");
  
  NHInfoMenu[i].text=infotext[i];
  NHInfoMenu[i].align=PMENU_ALIGN_CENTER;
  NHInfoMenu[i].arg=NULL;
  NHInfoMenu[i].SelectFunc=ReturnToNHMainMenu;
  i++; 
  
  PMenu_Close(ent);
  
  PMenu_Open(ent, NHInfoMenu, -1, sizeof(NHInfoMenu) / sizeof(pmenu_t)) ;
}


void ShowNHHelpMenu(edict_t *ent, pmenu_t *p)
{

  PMenu_Close(ent) ;
  PMenu_Open(ent, NHHelpMenu, -1, sizeof(NHHelpMenu) / sizeof(pmenu_t)) ;
}
void ShowNHHelpMenu2(edict_t *ent, pmenu_t *p)
{

  PMenu_Close(ent) ;
  PMenu_Open(ent, NHHelpMenu2, -1, sizeof(NHHelpMenu2) / sizeof(pmenu_t)) ;
}
void ShowNHHelpMenu3(edict_t *ent, pmenu_t *p)
{

  PMenu_Close(ent) ;
  PMenu_Open(ent, NHHelpMenu3, -1, sizeof(NHHelpMenu3) / sizeof(pmenu_t)) ;
}
void ShowNHHelpMenu4(edict_t *ent, pmenu_t *p)
{

  PMenu_Close(ent) ;
  PMenu_Open(ent, NHHelpMenu4, -1, sizeof(NHHelpMenu4) / sizeof(pmenu_t)) ;
}
void ShowNHHelpMenu5(edict_t *ent, pmenu_t *p)
{

  PMenu_Close(ent) ;
  PMenu_Open(ent, NHHelpMenu5, -1, sizeof(NHHelpMenu5) / sizeof(pmenu_t)) ;
}

void ShowNHAdminMenu(edict_t *ent, pmenu_t *p)
{

  PMenu_Close(ent) ;
  PMenu_Open(ent, NHAdminMenu, -1, sizeof(NHAdminMenu) / sizeof(pmenu_t)) ;
}

void ShowNHModelsMenu(edict_t *ent, pmenu_t *p)
{
  int i=0;

  NHModelsMenu[i].text="*Models used";
  NHModelsMenu[i].align=PMENU_ALIGN_CENTER;
  NHModelsMenu[i].arg=NULL;
  NHModelsMenu[i].SelectFunc=NULL;
  i++;
  NHModelsMenu[i].text=" ";
  NHModelsMenu[i].align=PMENU_ALIGN_CENTER;
  NHModelsMenu[i].arg=NULL;
  NHModelsMenu[i].SelectFunc=NULL;
  i++;
  NHModelsMenu[i].text="Current predator model is:";
  NHModelsMenu[i].align=PMENU_ALIGN_CENTER;
  NHModelsMenu[i].arg=NULL;
  NHModelsMenu[i].SelectFunc=NULL;
  i++;
  NHModelsMenu[i].text=" ";
  NHModelsMenu[i].align=PMENU_ALIGN_CENTER;
  NHModelsMenu[i].arg=NULL;
  NHModelsMenu[i].SelectFunc=NULL;
  i++;
  NHModelsMenu[i].text = strdup(predator_model->string);
  NHModelsMenu[i].align=PMENU_ALIGN_CENTER;
  NHModelsMenu[i].arg=NULL;
  NHModelsMenu[i].SelectFunc=NULL;
  i++;
  NHModelsMenu[i].text=" ";
  NHModelsMenu[i].align=PMENU_ALIGN_CENTER;
  NHModelsMenu[i].arg=NULL;
  NHModelsMenu[i].SelectFunc=NULL;
  i++;
  if(!Marine_allow_custom)
  {
  	NHModelsMenu[i].text="Current marine model is:";
  	NHModelsMenu[i].align=PMENU_ALIGN_CENTER;
  	NHModelsMenu[i].arg=NULL;
  	NHModelsMenu[i].SelectFunc=NULL;
  	i++;
  	NHModelsMenu[i].text=" ";
  	NHModelsMenu[i].align=PMENU_ALIGN_CENTER;
  	NHModelsMenu[i].arg=NULL;
  	NHModelsMenu[i].SelectFunc=NULL;
  	i++;
  	NHModelsMenu[i].text=" ";
  	NHModelsMenu[i].align=PMENU_ALIGN_CENTER;
  	NHModelsMenu[i].arg=NULL;
  	NHModelsMenu[i].SelectFunc=NULL;
  	i++;
  }
  else
  {
  	NHModelsMenu[i].text = strdup(predator_model->string);
  	NHModelsMenu[i].align=PMENU_ALIGN_CENTER;
  	NHModelsMenu[i].arg=NULL;
  	NHModelsMenu[i].SelectFunc=NULL;
  	i++;
  
 printf("predator_model:%s\n",predator_model->string); 
  PMenu_Close(ent);
  
  PMenu_Open(ent, NHModelsMenu, -1, sizeof(NHModelsMenu) / sizeof(pmenu_t)) ;
}

void CloseNHMenu(edict_t *ent, pmenu_t *p)
{

  PMenu_Close(ent) ;
}

void ReturnToNHMainMenu(edict_t *ent, pmenu_t *p) {

  PMenu_Close(ent) ;
  PMenu_Open(ent, NHMenu, -1, sizeof(NHMenu) / sizeof(pmenu_t));
}

void ShowNHCreditsMenu(edict_t *ent, pmenu_t *p) {

  PMenu_Close(ent) ;
  PMenu_Open(ent, NHCreditsMenu, -1, sizeof(NHCreditsMenu) / sizeof(pmenu_t));
}

void ObserveGame(edict_t *ent, pmenu_t *p) {

  PMenu_Close(ent) ;
  ClearFlashlight(ent);
  clearSafetyMode(ent) ;

  Cmd_Observe_f(ent) ;
}

void SetupBindings(edict_t *ent, pmenu_t *p) {

	Cmd_Setup_f(ent);
}

// Enter the game.
void EnterGame(edict_t *ent, pmenu_t *p) {

  if (ent->isObserving) {
    //only if currently observing or chasecam, enter the game

    // Get rid of the menu.
    PMenu_Close(ent) ;
    Start_Play_f(ent) ;
  }
}

// Start NH as observer. 
qboolean NHStartClient(edict_t *ent)
{

  ent->isFirstConnect = 1;  
  stuffcmd(ent, "spectator 1\n");

  // To make sure you don't get pushed into the game immediately 
  ent->isObserving = true;

  // Hurry up and do it..
  // Don't want to wait for regular cycle to switch the user -
  // can take too long.  
  spectator_respawn(ent); 

  ent->spectator_quick_switch = true;
  ent->SuicidePredator = false;

  // Cheat mode.
  ent->isCheating = false ;

  checkMarineSkin(ent, ent->client->pers.userinfo) ;

  // Set graphics flags.
  gi.dprintf("Stuffing gl_dynamic settings.\n") ;
  stuffcmd(ent, "set gl_dynamic 1; set sw_drawflat 0\n") ;
  		
  // Show the NH menu.
  //ShowNHMenu(ent);
  return true;

}
