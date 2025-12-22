#include "g_local.h"
#include "p_nhscoreboard.h"

int findChasePlayerNumber(edict_t *target, int sorted[], int max) {

  int i ;
  edict_t *temp = NULL ;

  for (i = 0; i < max; i++) {

    temp = g_edicts + 1 + sorted[i] ;
    if (temp == target)
      break ;

  }

  if (i == max)
    return -1 ;
  else return (i + 1) ;

}

void NHScoreboardMessage (edict_t *ent, edict_t *killer)
{
	char	entry[SCOREBOARDSIZE];
	char	string[1400];
	int		stringlength;
	int		i, j, k;
	int		sorted[MAX_CLIENTS];
	int		sortedscores[MAX_CLIENTS];
	int		score, total;
	int		picnum;
	int		x, y;
	gclient_t	*cl;
	edict_t		*cl_ent;
	char	*tag;

	char    status[20] ;

	entry[0] = 0 ;
	string[0] = 0 ;
	stringlength = 0 ;
	cl = NULL ;
	cl_ent = NULL ;

	// Alex
	// printf("top %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d\n",strlen(entry),strlen(string),stringlength, i,j,k,sorted[MAX_CLIENTS],sortedscores[MAX_CLIENTS],score,total,picnum,x,y);
	// Alex	


	// sort the clients by score
	total = 0;
	for (i=0 ; i < game.maxclients ; i++)
	{
	  
	  cl_ent = g_edicts + 1 + i;

	  // Don't bother with old entities.
	  if (!cl_ent->inuse)
	    continue;

	  score = game.clients[i].resp.score;

	  // Order current entity against current total.
	  for (j=0 ; j < total ; j++) {

	    if (score > sortedscores[j])
	      break;
	  }

	  // Make room for new player? 
	  for (k = total ; k > j ; k--)	{
	    sorted[k] = sorted[k-1];
	    sortedscores[k] = sortedscores[k-1];
	  }

	  // Add new player to list.
	  sorted[j] = i;
	  sortedscores[j] = score;
	  total++;
	}

	// NH changes: New entry.
	Com_sprintf(entry, sizeof(entry),
		    "xv 32 yv 16 string2 \"#\" "
		    "xv 55 yv 16 string2 \"Player\" "
		    "xv 191 yv 16 string2 \"Score\" "
		    "xv 240 yv 16 string2 \"Ping\" "
		    "xv 280 yv 16 string2 \"Time\" "
		    "xv 325 yv 16 string2 \"Status\" "
		    "xv 32 yv 24 string2 \"--------------------------------------------------\" ") ;
	j = strlen(entry) ;
	if (stringlength + j < SCOREBOARDSIZE) {
	  strcpy(string + stringlength, entry) ;
	  stringlength += j ;
	}

	// add the clients in sorted order
	// NH changes: We could expand this.
	if (total > 12)
		total = 12;

	for (i=0 ; i < total ; i++)
	{
		cl = &game.clients[sorted[i]];
		cl_ent = g_edicts + 1 + sorted[i];

		picnum = gi.imageindex ("i_fixme");

		x = 32 ;
		y = 32 + 8 * i ;

#if 0
		// add a dogtag
		if (cl_ent == ent)
			tag = "-->";
		else if (cl_ent == killer)
			tag = "-X>";
		else
			tag = NULL;

		if (tag) {

   		        Com_sprintf(entry, sizeof(entry),
				    "xv 8 yv %i string \"%s\" ",
				    y, tag) ;
			j = strlen(entry);
			if (stringlength + j > SCOREBOARDSIZE)
				break;
			strcpy (string + stringlength, entry);
			stringlength += j;
		}
#endif

		// Determine the player status
		if (level.framenum & 31) 
		  Com_sprintf(status, sizeof(status), "Intermission") ;
		else if (cl_ent->isPredator) 
		  Com_sprintf(status, sizeof(status), "Predator") ;
		else if (cl_ent->isObserving) 
		  Com_sprintf(status, sizeof(status), "Observing") ;
		else if (cl_ent->isChasing) {

		  int chased = -1 ;

		  // Don't bother if the chase target is defunct.
		  // This statement is position dependent. 
		  if ((cl_ent->client->chase_target) &&
		      (cl_ent->client->chase_target->inuse))
		      chased = findChasePlayerNumber(
				   cl_ent->client->chase_target,
					   sorted, total) ;

		  if (chased == -1) 
		    Com_sprintf(status, sizeof(status), "Chasing...") ;
		  else
		    Com_sprintf(status, sizeof(status),
				"Chasing #%d", chased) ;

		}
		else 
		  Com_sprintf(status, sizeof(status), "Marine") ;

		// send the layout
		if (cl_ent == ent) {


		  // This is the way to do it. 
		  Com_sprintf(entry, sizeof(entry),
			    "xv 32 yv %i string \"%2d %-14.14s  %4i %5i %4i   %s\" ",
			    y, 
			    i + 1, 
			    cl->pers.netname,
			    cl->resp.score,
			    cl->ping,
			    (level.framenum - cl->resp.enterframe)/600,
			    status) ;

#if 0
		  Com_sprintf(entry, sizeof(entry),
			    "xv 32 yv %i string \"%d\" "
			    "xv 55 yv %i string \"%s\" "
			    "xv 191 yv %i string \"%3i\" "
			    "xv 240 yv %i string \"%3i\" "
			    "xv 280 yv %i string \"%3i\" "
			    "xv 325 yv %i string \"%s\" ",
			    y, i + 1,
			    y, cl->pers.netname, 
			    y, cl->resp.score,
			    y, cl->ping,
			    y, (level.framenum - cl->resp.enterframe)/600,
			    y, status) ;
#endif

		}
		else {

		  // This is the way to do it. 
		  Com_sprintf(entry, sizeof(entry),
			    "xv 32 yv %i string2 \"%2d %-14.14s  %4i %5i %4i   %s\" ",
			    y, 
			    i + 1, 
			    cl->pers.netname,
			    cl->resp.score,
			    cl->ping,
			    (level.framenum - cl->resp.enterframe)/600,
			    status) ;
#if 0
		  Com_sprintf(entry, sizeof(entry),
			    "xv 32 yv %i string2 \"%d\" "
			    "xv 55 yv %i string2 \"%s\" "
			    "xv 191 yv %i string2 \"%3i\" "
			    "xv 240 yv %i string2 \"%3i\" "
			    "xv 280 yv %i string2 \"%3i\" "
			    "xv 325 yv %i string2 \"%s\" ",
			    y, i + 1,
			    y, cl->pers.netname, 
			    y, cl->resp.score,
			    y, cl->ping,
			    y, (level.framenum - cl->resp.enterframe)/600,
			    y, status) ;
#endif
		}

		j = strlen(entry);

		if (stringlength + j > SCOREBOARDSIZE) {
			break;
		}
		strcpy (string + stringlength, entry);
		stringlength += j;
	}




	gi.WriteByte (svc_layout);
	
	// Alex
	//	printf("svc_layout is %d\n",svc_layout);
	// printf("mid %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d\n",strlen(entry),strlen(string),stringlength, i,j,k,sorted[MAX_CLIENTS],sortedscores[MAX_CLIENTS],score,total,picnum,x,y);
	// printf("String is %s",string);
	// printf("Entry is %s",entry);
	// Alex
	
	gi.WriteString (string);

	// Alex
	// printf("bot %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d\n",strlen(entry),strlen(string),stringlength, i,j,k,sorted[MAX_CLIENTS],sortedscores[MAX_CLIENTS],score,total,picnum,x,y);
	// Alex	



}

/*
==================
NHScoreboard

Night Hunters custom scoreboard.
==================
*/
void NHScoreboard (edict_t *ent)
{
	NHScoreboardMessage (ent, ent->enemy);
	gi.unicast (ent, true);
}

/*
==================
Cmd_NHScore_f

Display the Night Hunters custom scoreboard
==================
*/
void Cmd_NHScore_f (edict_t *ent)
{
	ent->client->showinventory = false;
	ent->client->showhelp = false;

	// NH change: CTF-like menu.
	// If the menu is showing, close it.
	if (ent->client->menu)
	  PMenu_Close(ent);

	if (!deathmatch->value && !coop->value)
		return;

	if (ent->client->showscores)
	{
		ent->client->showscores = false;
		ent->client->update_chase = true;
		return;
	}

	ent->client->showscores = true;
	NHScoreboard (ent);
}

