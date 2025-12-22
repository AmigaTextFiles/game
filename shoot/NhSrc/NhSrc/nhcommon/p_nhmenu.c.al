// CTF-like menu for NH

#include "g_local.h"
#include "g_cmd_observe.h"

void ShowNHInfoMenu(edict_t *ent, pmenu_t *p) ;
void ShowNHHelpMenu(edict_t *ent, pmenu_t *p) ;
void ShowNHAdminMenu(edict_t *ent, pmenu_t *p) ;
void ShowNHCreditsMenu(edict_t *ent, pmenu_t *p) ;
void ReturnToNHMainMenu(edict_t *ent, pmenu_t *p) ;
void CloseNHMenu(edict_t *ent, pmenu_t *p) ;
void EnterGame(edict_t *ent, pmenu_t *p) ;
void UpdateMainMenu(edict_t *ent) ;
void ObserveGame(edict_t *ent, pmenu_t *p) ;

// Menu initialization.

pmenu_t NHInfoMenu[20];
//20 lines max - probably too much
char infotext[50][50];

pmenu_t NHHelpMenu[] = {
  { "*Help Menu", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Marine: male", PMENU_ALIGN_CENTER, NULL, NULL},
  { "Predator: female", PMENU_ALIGN_CENTER, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Marine tries to kill predator", PMENU_ALIGN_CENTER, NULL, NULL},
  { "to become predator", PMENU_ALIGN_CENTER, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "bindings:", PMENU_ALIGN_CENTER, NULL, NULL},
  { "flashlight (both)", PMENU_ALIGN_LEFT, NULL, NULL},
  { "gunscope   (pred only)", PMENU_ALIGN_LEFT, NULL, NULL},
  { "flare      (marine only)", PMENU_ALIGN_LEFT, NULL, NULL},
  { "anchor     (pred teleport)", PMENU_ALIGN_LEFT, NULL, NULL},
  { "recall     (pred teleport)", PMENU_ALIGN_LEFT, NULL, NULL},
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL } ,
  { "Back", PMENU_ALIGN_CENTER, NULL, ReturnToNHMainMenu },
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
  { "Majoon can fill this out", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Back", PMENU_ALIGN_CENTER, NULL, ReturnToNHMainMenu },
};

pmenu_t NHMenu[] = {
  { "*Welcome to Night Hunters", PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Info", PMENU_ALIGN_CENTER, NULL, ShowNHInfoMenu},
  { "Help", PMENU_ALIGN_CENTER, NULL, ShowNHHelpMenu},
  { "Admin", PMENU_ALIGN_CENTER, NULL, ShowNHAdminMenu},
  { "Credits", PMENU_ALIGN_CENTER, NULL, ShowNHCreditsMenu },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Observer mode", PMENU_ALIGN_CENTER, NULL, ObserveGame },
  { "Enter game", PMENU_ALIGN_CENTER, NULL, EnterGame },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { NULL, PMENU_ALIGN_CENTER, NULL, NULL },
  { "Esc closes menu", PMENU_ALIGN_CENTER, NULL, NULL },
  { "Tab key twice restarts menu", PMENU_ALIGN_CENTER, NULL, NULL },





};

// Show the NH menu.
void ShowNHMenu (edict_t *ent)
{
		printf("%s started the main menu/inven screen\n",ent->client->pers.netname); //debug stuff

if (ent->client->menu) {		//is menu opened already?  If so, close
	PMenu_Close(ent);
	return;
} 		//Moved from the p_menu.c code for NH.  If menu open, close instead

if (ent->client->showinventory)
	ent->client->showinventory = false;	//close inventory before opening menu

  PMenu_Close(ent);
//  UpdateMainMenu(ent) ;
  PMenu_Open(ent, NHMenu, -1, sizeof(NHMenu) / sizeof(pmenu_t));
} 

void ShowNHInfoMenu(edict_t *ent, pmenu_t *p)
{

	char motd[500];
	char line[80];
	int i=0;
	FILE *motd_file;

		printf("%s opened the menu: Info menu\n",ent->client->pers.netname); //debug stuff

  if (motd_file = fopen("nhunters/motd.txt", "r"))
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
		printf("%s opened the menu: help menu\n",ent->client->pers.netname); //debug stuff

  PMenu_Close(ent) ;
  PMenu_Open(ent, NHHelpMenu, -1, sizeof(NHHelpMenu) / sizeof(pmenu_t)) ;
}

void ShowNHAdminMenu(edict_t *ent, pmenu_t *p)
{
		printf("%s opened the menu: admin menu\n",ent->client->pers.netname); //debug stuff

  PMenu_Close(ent) ;
  PMenu_Open(ent, NHAdminMenu, -1, sizeof(NHAdminMenu) / sizeof(pmenu_t)) ;
}

void CloseNHMenu(edict_t *ent, pmenu_t *p)
{
		printf("%s closed the menu\n",ent->client->pers.netname); //debug stuff

  PMenu_Close(ent) ;
}

void ReturnToNHMainMenu(edict_t *ent, pmenu_t *p) {
		printf("%s returned to main menu\n",ent->client->pers.netname); //debug stuff

  PMenu_Close(ent) ;
  PMenu_Open(ent, NHMenu, -1, sizeof(NHMenu) / sizeof(pmenu_t));
}

void ShowNHCreditsMenu(edict_t *ent, pmenu_t *p) {
		printf("%s opened the menu: credits menu\n",ent->client->pers.netname); //debug stuff

  PMenu_Close(ent) ;
  PMenu_Open(ent, NHCreditsMenu, -1, sizeof(NHCreditsMenu) / sizeof(pmenu_t));
}

void UpdateMainMenu(edict_t *ent) {

  if (ent->isObserving) {

    // The index of the Enter Game/Observe line in the main
    // menu is 9 (start at zero, remember?). 
    // WARNING: This can change when you edit the initialization
    // of NHMenu.
    NHMenu[8].text = "Enter game" ;
    NHMenu[8].SelectFunc = EnterGame ;

  }
  else {

    NHMenu[8].text = "Observe game" ;
    NHMenu[8].SelectFunc = ObserveGame ;

  }

}

void ObserveGame(edict_t *ent, pmenu_t *p) {

		printf("%s choose observer mode from the menu\n",ent->client->pers.netname); //debug stuff


  PMenu_Close(ent) ;
  ClearFlashlight(ent);
  Cmd_Observe_f(ent) ;
}

// Enter the game.
void EnterGame(edict_t *ent, pmenu_t *p) {

  if (ent->isObserving)
  {			//only if currently observing, enter the game
  	// Get rid of the menu.
	PMenu_Close(ent) ;
	Start_Play_f(ent) ;
  }
}

// Start NH as observer. 
qboolean NHStartClient(edict_t *ent)
{

  if (!ent->isObserving) 
    return false ;

  // start as 'observer'
  Start_Observe_f(ent) ;

  // Show the NH menu.
  ShowNHMenu(ent);
  return true;

}
