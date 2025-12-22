#include        "g_local.h"
#include        "kamikaze.h"

void Start_Kamikaze_Mode(edict_t *the_doomed_one){

	

	/* see if we are already in  kamikaze mode*/

	if (the_doomed_one->client->kamikaze_mode & 1)  {

                gi.cprintf(the_doomed_one, PRINT_MEDIUM, "Already in Kamikaze Mode!! Kiss you butt Goodbye!\n");

		return;		    

	}

	

	/* dont run if in god mode  */

	if (the_doomed_one->flags & FL_GODMODE){

		gi.cprintf(the_doomed_one, PRINT_MEDIUM, "Can't Kamikaze in God Mode, Whats the Point?");

		return;

	}

	/* not in kamikaze mode yet */

	the_doomed_one->client->kamikaze_mode = 1;



	/*  Give us only so long */

	the_doomed_one->client->kamikaze_timeleft = KAMIKAZE_BLOW_TIME;

	the_doomed_one->client->kamikaze_framenum = level.framenum + the_doomed_one->client->kamikaze_timeleft;



	/* Warn the World */

	gi.bprintf (PRINT_MEDIUM,"%s is a Kamikaze - BANZAI!!\n", the_doomed_one->client->pers.netname);
        the_doomed_one->IS_KAMIKAZE = 1;

    gi.sound( the_doomed_one, CHAN_WEAPON, gi.soundindex("makron/rail_up.wav"), 1, ATTN_NONE, 0 );



	return;

}



/* 

Function: Kamikaze_Active

	Are we in Kamikaze Mode? 

	a helper function to see if we are running in Kamikaze Mode



*/

qboolean Kamikaze_Active(edict_t *the_doomed_one){

	return (the_doomed_one->client->kamikaze_mode);

}





/* 

Function: Kamikaze_Cancel

  Canceled for Some Reason

  Call if Player is killed before time is up

*/

void Kamikaze_Cancel(edict_t *the_spared_one){

	/* not in kamikaze mode yet */

	the_spared_one->client->kamikaze_mode = 0;

	/* Give us only so long */

	the_spared_one->client->kamikaze_timeleft = 0;

	the_spared_one->client->kamikaze_framenum = 0;

	

	return;

}



void Kamikaze_Explode(edict_t *the_doomed_one){





    /* A whole Lotta Damage */

    T_RadiusDamage (the_doomed_one, the_doomed_one, KAMIKAZE_DAMAGE, NULL, KAMIKAZE_DAMAGE_RADUIS,MOD_KAMIKAZE);



     /* BANG ! and show the clients */

     gi.WriteByte (svc_temp_entity);

     gi.WriteByte (TE_EXPLOSION1);

     gi.WritePosition(the_doomed_one -> s.origin);

     the_doomed_one->client->pers.cloak = 0;
     gi.multicast (the_doomed_one->s.origin, MULTICAST_PVS);

}
