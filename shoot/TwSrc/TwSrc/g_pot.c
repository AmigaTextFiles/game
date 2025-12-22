#include "g_local.h"
#include "m_player.h"

// Player Operated Code By: Demolisher with help
// from: DuhRoach of Armaggedon ,scumm of Power Cubes, and 
// whoever i don't remember that helped me.
//
// Also much thanks to Qdevels for all the helpfull tutorials
// http://www.planetquake.com/qdevels/

void Dummy_Think (edict_t *ent)
{
   //This is just here because the temp origin needed a think function
   //and firing needs a delay
   ent->fstat=3;
}

/*===================================
Check_If_Close = Used by Cmd_Turret_f to determine if the player is
close enough to the turret to turn it on and off.
=====================================*/
void Check_If_Close(edict_t *ent)
{
  edict_t *trc = NULL;

  while ((trc = findradius(trc, ent->s.origin, 50)) != NULL)
  {
      if (trc->control==1)
      {
         if (!ent->client->tstat)
             ent->client->tstat=1;
      }
  }
}

/*===================================
Turret_Cmd = Used for determining if the player is trying
to move forward, back, up, down, or turning. This is used
to figure out which way the turret should go. The main control
is ent->client->turaction, it passes the direction to Turret_Move.
=====================================*/
void Turret_Cmd (edict_t *ent, usercmd_t *ucmd)
{
     int otura;
     int vangle;
     int tview;

     //used int instead of float to prevent the turret from rapidly
     //turning the player, this would keep the turret on and turning
     vangle = ent->client->v_angle[YAW];
     tview = ent->client->toldview[YAW];

     //check for negatives
     if (vangle < 0)
         vangle += 360;
     if (tview < 0)
         tview += 360;

     if (ent->client->tstat==2) // check if on
     {
        if (ucmd->buttons & BUTTON_ATTACK) // check if attacking
        {
           ent->client->turmovec=1;
           ucmd->buttons &= ~BUTTON_ATTACK;
           Turret_Fire (ent);
        }
        else
           ent->client->turmovec=0;

        if (vangle != tview || ucmd->forwardmove || ucmd->upmove) // check if player has moved
        {
             otura = ent->client->turaction;

             // up/down movements
             if (ucmd->forwardmove < 0)
                  ent->client->turaction=3;
             else if (ucmd->forwardmove > 0)
                  ent->client->turaction=4;

             //door control
             else if (ucmd->upmove > 0)
                  ent->client->turaction=8;
             else if (ucmd->upmove < 0)
                  ent->client->turaction=9;
 
             // turning control
             else if (vangle != tview)
             {
                if (vangle < 90 && tview > 270 && otura == 1) //check for passing 360
                    ent->client->turaction=1;
                else if (vangle > 270 && tview < 90 && otura == 2) //check for passing 360
                    ent->client->turaction=2;
                else if (tview==0) //check for start
                {
                     if (vangle < 90)
                         ent->client->turaction=1;
                     else if (vangle > 270)
                         ent->client->turaction=2;
                }
                else //regular turning
                {
                    if (vangle < tview)
                        ent->client->turaction=2;
                    else if (vangle > tview)
                        ent->client->turaction=1;
                }
             }
             //code to handle rapid changes in turaction
             if (otura != ent->client->turaction && (otura && otura !=10))
                  ent->client->turaction=10;
        }
        else
          ent->client->turaction=10;
     }

      //zoom control check
      if (ent->zoom == 1)
      {
          ent->client->turaction=13;
          ent->zoom=0;
      }

     Turret_Move (ent); // main move

     VectorCopy (ent->client->v_angle, ent->client->toldview);

     if (ent->client->tursnap==1)
        Turret_Snap (ent); // snap
}

/*===================================
Cmd_Turret_f = main turret switch, the only key that needs
bining is "turret switch". This function turn the turret on/off.
====================================*/
void Cmd_Turret_f (edict_t *ent)
{
     Check_If_Close (ent);

     if (Q_stricmp (gi.argv(1), "switch") == 0)
     {
        if (ent->client->tstat==1)
        {
           //set snap on, set on flag, run main move to copy to default angles
           ent->client->tursnap=1;
           ent->client->tstat=2;
           ent->client->turaction=11;
           Turret_Move (ent);
        }
        else if (ent->client->tstat==2)
        {
           //Set everything off and run main move twice, once to turn off
           //and a second time to restore angles
           ent->client->tursnap=0;
           ent->client->tstat=0;
           ent->client->turmovec=0;
           ent->client->turaction=10;
           Turret_Move (ent);
           ent->client->turaction=12;
           Turret_Move (ent);
           ent->client->turaction=0;
           ent->client->oturaction=0;
           ent->client->ps.stats[16] = 0;
           ent->client->ps.fov = 90;
        }
     }
     else if (Q_stricmp (gi.argv(1), "zoom") == 0)
             ent->zoom =1;
}
/*=================================
Turret_RF = Range finder control.
Most of the code for the range finder is found
on qdevels(http://www.planetquake.com/qdevels/)
==================================*/
void Turret_RF (edict_t *ent, edict_t *trmove)
{
  edict_t *rfpos = NULL;

  trace_t tr;

  vec3_t end;
  vec3_t f, r,u;
  vec3_t start;

  //range finder
  if (trmove->findrange)
  {
     rfpos = G_Find (NULL,FOFS(targetname),trmove->findrange);
 
     //adjusts the info_notnull's position to include the turret movement
     VectorSubtract (rfpos->s.origin, trmove->s.origin, rfpos->move_origin);
                    
     //Same fix as with the laser
     rfpos->move_origin[YAW] = trmove->s.origin[YAW] - rfpos->s.origin[YAW];

     AngleVectors (trmove->s.angles,f,r,u);
     VectorMA (trmove->s.origin, rfpos->move_origin[0],f,start);
     VectorMA (start, rfpos->move_origin[1],r,start);
     VectorMA (start, rfpos->move_origin[2],u,start);

     VectorMA(start, 8192, f, end);
     tr = gi.trace(start, NULL, NULL, end, ent, MASK_SHOT|CONTENTS_SLIME|CONTENTS_LAVA);
     // check for sky and max the range if found
     if ( tr.surface && (tr.surface->flags & SURF_SKY) )
         ent->client->ps.stats[16] = 9999;
     else
         ent->client->ps.stats[16] = (int)(tr.fraction * 8192);
  }
}
/*=================================
Turret_Snap = snaps player to an info_notnull.
==================================*/
void Turret_Snap (edict_t *ent)
{
  edict_t *trmove = NULL;
  edict_t *trc = NULL;
  edict_t *trsnap = NULL;
 
  vec3_t f, r, u;
  vec3_t start;
  vec3_t tempangles;

  pmove_t pm;

  while ((trc = findradius(trc, ent->s.origin, 50)) != NULL)
  {
      if (trc->control==1) //find control
      {
         while ((trmove = findradius(trmove, ent->s.origin, trc->range)) != NULL)
         {
               if (!strcmp(trmove->classname, "turret")) //find turret
               {
                  if (trmove->turtype==2) // check for snap type
                  {
                      if (trmove->target) //check for target
                      {
                          //check for custom viewheight
                          if (!trmove->cview)
                             trmove->cview=22;

                          //snap
                          trsnap = G_Find (NULL,FOFS(targetname),trmove->target);

                          //freeze player
                          ent->client->ps.pmove.pm_type = PM_FREEZE;
                            
                          VectorClear (tempangles); //clear temp

                          //i don't know why but i had to put a second set of
                          //ifs for snapa, apearantly if i adjusted with the 
                          //player's origin after the angle ifs i had offsets
                          if (trmove->snapa & 1)
                              tempangles[YAW] = trmove->s.angles[YAW];
                          if (trmove->snapa & 2)
                              tempangles[PITCH] = trmove->s.angles[PITCH];
                          if (trmove->snapa & 3)
                              tempangles[ROLL] = trmove->s.angles[ROLL];

                          //adjust player origin as moved with the turret on the
                          //chosen snap axies
                          VectorSubtract (trsnap->s.origin, trmove->s.origin, trsnap->move_origin);
                          trsnap->move_origin[YAW] = trmove->s.origin[YAW] - trsnap->s.origin[YAW];
                          AngleVectors (tempangles,f,r,u);
                          VectorMA (trmove->s.origin, trsnap->move_origin[0],f,start);
                          VectorMA (start, trsnap->move_origin[1],r,start);
                          VectorMA (start, trsnap->move_origin[2],u,start);

                          VectorCopy (start, ent->s.origin);

                          //Copy to various angles, adjust viewheight, prep 
                          //angles for player's origin adjustment
                          if (trmove->snapa & 1)
                          {
                             ent->s.angles[YAW] = trmove->s.angles[YAW];
                             ent->client->v_angle[YAW] = trmove->s.angles[YAW];
                             pm.viewangles[YAW] = trmove->s.angles[YAW];
                             tempangles[YAW] = trmove->s.angles[YAW];
                             ent->viewheight = trmove->cview;
                          }
                          if (trmove->snapa & 2)
                          {
                             ent->s.angles[PITCH] = trmove->s.angles[PITCH];
                             ent->client->v_angle[PITCH] = trmove->s.angles[PITCH]*3;
                             pm.viewangles[PITCH] = trmove->s.angles[PITCH];
                             tempangles[PITCH] = trmove->s.angles[PITCH];
                             ent->viewheight = trmove->cview;
                          }
                          if (trmove->snapa & 4)
                          {
                             ent->s.angles[ROLL] = trmove->s.angles[ROLL];
                             ent->client->v_angle[ROLL] = trmove->s.angles[ROLL];
                             pm.viewangles[ROLL] = trmove->s.angles[ROLL];
                             tempangles[ROLL] = trmove->s.angles[ROLL];
                             ent->viewheight = trmove->cview;
                          }
                          //view is fully copied even if model angles aren't
                          VectorCopy (trmove->s.angles, ent->client->ps.viewangles);

                          //model anim fixes
                          ent->client->anim_priority = ANIM_ATTACK;
                          ent->s.frame = FRAME_stand01;
                          ent->client->anim_end = FRAME_stand40;
                          ent->client->ps.pmove.pm_flags = 0;
                          VectorClear (ent->velocity);
                      }
                  }
               }
         }
      }
  }
}     

/*===============================
Turret_Fire = main firing function.
depends on the fire field in the map.
================================*/
void Turret_Fire (edict_t *ent)
{
  edict_t *trmove = NULL;
  edict_t *trshot = NULL;
  edict_t *trshotd;
  edict_t *trc = NULL;

  vec3_t oldo;

  int fsp;
  int fdmg;
  int fdmgr;

  vec3_t f, r, u;
  vec3_t start;

  while ((trc = findradius(trc, ent->s.origin, 50)) != NULL)
  {
      if (trc->control==1) //check control
      {
         while ((trmove = findradius(trmove, ent->s.origin, trc->range)) != NULL)
         {
               if (!strcmp(trmove->classname, "turret")) //check turret
               {
                  if (ent->client->turmovec==1) //check if fire is on
                  {
                      if(trmove->target && trmove->fire) //check for target/fire/fstat
                      {
                              trshotd = G_Find (NULL,FOFS(classname),trmove->targetname);

                              if (!trshotd)
                              {
                                  trshotd=G_Spawn();
                                  trshotd->classname = trmove->targetname;
                                  VectorCopy (ent->s.origin, trshotd->s.origin);
                                  trshotd->think = Dummy_Think;
                                  if (!trmove->times)
                                      trshotd->nextthink = level.time + 0.1;
                                  else
                                      trshotd->nextthink = level.time + trmove->times;
                                  gi.linkentity(trshotd);
                                  trshotd->fstat=1;
                              }

                              if (trshotd->fstat==1)
                              {
                                  //copy custom firing options
                                  fsp = trmove->fspeed; 
                                  fdmg = trmove->fdamage; 
                                  fdmgr = trmove->fradius; 

                                  //check custom
                                  if (!fsp)
                                       fsp = 100;
                                  if (!fdmg)
                                       fdmg = 10;
                                  if (!fdmgr)
                                       fdmgr = 50;
        
                                  //find info_notnull that is fired from
                                  trshot = G_Find (NULL,FOFS(targetname),trmove->target);
        
                                  VectorCopy (ent->s.origin, oldo);
        
                                  //adjusts the info_notnull's position to include the
                                  //turret movement
                                  VectorSubtract (trshot->s.origin, trmove->s.origin, trmove->move_origin);
                             
                                  //Same fix as with the laser
                                  trmove->move_origin[YAW] = trmove->s.origin[YAW] - trshot->s.origin[YAW];

                                  AngleVectors (trmove->s.angles,f,r,u);
                                  VectorMA (trmove->s.origin, trmove->move_origin[0],f,start);
                                  VectorMA (start, trmove->move_origin[1],r,start);
                                  VectorMA (start, trmove->move_origin[2],u,start);
        
                                  //player origin is switched to start so the fire
                                  //function would come from the player, the old 
                                  //origin is restored after fire is done
                                  VectorCopy (start, ent->s.origin);
        
                                  //check for offsets
                                  if (trmove->zoffset)
                                      f[YAW] -= trmove->zoffset;
        
                                  if (trmove->yoffset)
                                      f[PITCH] -= trmove->yoffset;
        
                                  if (trmove->xoffset)
                                      f[ROLL] -= trmove->xoffset;

                                  if (trmove->fire==1)
                                       fire_blaster (ent, start,f,fdmg,fsp,EF_BLASTER,MOD_BLASTER);
                                  else if (trmove->fire==2)
                                       fire_shotgun (ent, start,f,fdmg,0,500,500,DEFAULT_SHOTGUN_COUNT,MOD_SHOTGUN);
                                  else if (trmove->fire==3)
                                       fire_shotgun (ent, start,f,fdmg,0,500,500,DEFAULT_SSHOTGUN_COUNT/2,MOD_SSHOTGUN);
                                  else if (trmove->fire==4)
                                       fire_bullet (ent, start,f,fdmg,0,DEFAULT_BULLET_HSPREAD,DEFAULT_BULLET_VSPREAD,MOD_MACHINEGUN);
                                  else if (trmove->fire==5)
                                       fire_bullet (ent, start,f,fdmg,0,DEFAULT_BULLET_HSPREAD,DEFAULT_BULLET_VSPREAD,MOD_CHAINGUN);
                                  else if (trmove->fire==6)
                                       fire_grenade (ent, start,f,fdmg,fsp,2,fdmgr);
                                  else if (trmove->fire==7)
                                       fire_rocket (ent, start, f, fdmg, fsp, 150, fdmgr);
                                  else if (trmove->fire==8)
                                       fire_blaster (ent, start,f,fdmg,fsp,EF_HYPERBLASTER,EF_HYPERBLASTER);
                                  else if (trmove->fire==9)
                                       fire_rail (ent, start,f,fdmg,0);
                                  else if (trmove->fire==10)
                                       fire_bfg (ent, start,f,fdmg,fsp,fdmgr);
        
                                  VectorCopy (oldo, ent->s.origin); //restore player origin

                                  if (trmove->times)
                                      trshotd->fstat=2;
                              }
                              else if (trshotd->fstat==3)
                                  G_FreeEdict (trshotd);
                      }
                  }
               }
         }
      }
  }
}
/*================================
Turret_Laser = Laser sight and laser shots support
=================================*/

void Turret_Laser (edict_t *trmove)
{
  edict_t *trlaser = NULL;
  edict_t *trlaserd = NULL; //Dummies to prevent a subtract loop

  vec3_t f, r, u;
  vec3_t start;
  vec3_t tempang; //this is here because g_Setmovedir clears the angle used for it

  VectorCopy (trmove->s.angles, tempang);

  trlaser = G_Find (NULL,FOFS(targetname),trmove->laser);
  trlaserd = G_Find (NULL,FOFS(classname),trmove->targetname);

  //Spawn temporary entity to be stable at the origin while the
  //laser moves. Set up to remove the temp when turning off.
  if (trmove->lstat==1)
  {
     trlaserd=G_Spawn();
     trlaserd->classname=trmove->targetname;
     VectorCopy (trlaser->s.origin, trlaserd->s.origin);
     trlaserd->think = Dummy_Think;
     trlaserd->nextthink = level.time + 0.1;
     trmove->lstat=2;
     gi.linkentity(trlaserd);
  }
  else if (!trmove->lstat)
  {
     VectorCopy (trlaserd->s.origin, trlaser->s.origin);
     trlaserd->think = G_FreeEdict;
  }
  else
  {
     //main laser sight stuff
     if (trlaser && trlaserd)
     {
        //Adjust laser origin    
        VectorSubtract (trlaserd->s.origin, trmove->s.origin, trlaserd->move_origin);

        //A simple fix to stop the laser origin from going from positive 
        //to negative yaw angles when started or moved.
        trlaserd->move_origin[YAW] = trmove->s.origin[YAW] - trlaserd->s.origin[YAW];

        //laser origin adjustment continues
        AngleVectors (trmove->s.angles,f,r,u);
        VectorMA (trmove->s.origin, trlaserd->move_origin[0],f,start);
        VectorMA (start, trlaserd->move_origin[1],r,start);
        VectorMA (start, trlaserd->move_origin[2],u,start);

        //Copy new origin
        VectorCopy (start, trlaser->s.origin);

        //adjust laser pointing and movedir
        G_SetMovedir (tempang, trlaser->movedir);

        //Copy custom damage
        trlaser->dmg = trmove->ldmg;
     }
  }
}

/*=================================
TRdoor_on and TRdoor_off are special functions for turtype 3.
This turret type is a door that appears when the turret
is turned on and disapears when the turret is turned off
Notice that the two functions depend on different edicts.
This is because you cannot find a SOLID_NOT with find radius and
will have to find is through g_find.
===================================*/
void TRdoor_off (edict_t *trmove)
{
   if (!(trmove->svflags & SVF_NOCLIENT))
   {
     //when door is off is it not sent to clients and becomes a non solid
     trmove->svflags |= SVF_NOCLIENT;
     trmove->solid= SOLID_NOT;
   }
}

void TRdoor_on (edict_t *ent)
{
  edict_t *trdoor;
  edict_t *trc = NULL;
  vec3_t ovec; //vector between the two origins

  //you got to be in control range to turn door on
  while ((trc = findradius(trc, ent->s.origin, 50)) != NULL)
  {
      if (trc->control==1)//check control
      {
         while (1)
         {
            trdoor = G_Find (trdoor, FOFS(classname), "turret");

            if (!trdoor)
               break;

            if ((trdoor->turtype == 3) && (trdoor->svflags & SVF_NOCLIENT)) 
            {
                //Get the distance between the door and control and see
                //if its in range
                VectorSubtract (ent->s.origin, trdoor->s.origin, ovec);
                if (VectorLength(ovec) < trc->range)
                {
                     trdoor->svflags &= ~SVF_NOCLIENT;
                     trdoor->solid = SOLID_BSP;
                }
           }
         }
      }
  }
}
/*================================
Turret_Move = Main turret movement code, links the brushes to
a func_rotating and selects a direction and axis for movement.
================================*/
void Turret_Move (edict_t *ent)
{
  edict_t *trmove = NULL;
  edict_t *trc = NULL;

  if (ent->client->turaction == 11)
      TRdoor_on (ent);

  while ((trc = findradius(trc, ent->s.origin, 50)) != NULL)
  {
      if (trc->control==1)//check control
      {
         while ((trmove = findradius(trmove, ent->s.origin, trc->range)) != NULL)
         {
               if (!strcmp(trmove->classname, "turret")) //check turret
               {
                  if (!trmove->accel) //sanity check
                       trmove->accel = trmove->speed;

                  //tranfer targetname for triggering (every turret entity must
                  //have a different targetname to prevent cross-triggering)
                  ent->target = trmove->targetname;
                  
                  //copy min/max to pos1 and pos2
                  trmove->pos1[PITCH]=trmove->maxtpitch;
                  trmove->pos1[YAW]=trmove->maxtyaw;
                  trmove->pos1[ROLL]=trmove->maxtbank;
       
                  trmove->pos2[PITCH]=trmove->mintpitch;
                  trmove->pos2[YAW]=trmove->mintyaw;
                  trmove->pos2[ROLL]=trmove->mintbank;
       
                  if (!trmove->mfire)
                       VectorClear (trmove->movedir);
    
                  if (ent->client->turaction==1) //check if left
                  {
                     if (trmove->pos1[YAW] > trmove->s.angles[YAW])
                     {
                        if (!trmove->mfire)
                        {
                           if (trmove->oaxis == 1 || trmove->oaxis == 3 || trmove->oaxis == 4 || trmove->oaxis == 7)
                           {
                               trmove->movedir[1] = 1.0;
                               trmove->mfire=3;
                           }
                           else
                              trmove->mfire=1;
                        }
                     }
                     else if (trmove->pos1[YAW] < trmove->s.angles[YAW])
                             trmove->s.angles[YAW]=trmove->pos1[YAW];

                     if (trmove->pos1[ROLL] > trmove->s.angles[ROLL])
                     {
                        if (!trmove->mfire)
                        {
                           if (trmove->oaxis == 1 || trmove->oaxis == 2 || trmove->oaxis == 3 || trmove->oaxis == 5)
                           {
                                trmove->movedir[2] = 1.0;
                                trmove->mfire=3;
                           }
                           else
                              trmove->mfire=1;
                         }
                     }
                     else if (trmove->pos1[ROLL] < trmove->s.angles[ROLL])
                           trmove->s.angles[ROLL]=trmove->pos1[ROLL];
                  }
                  else if (ent->client->turaction==2) //check if right
                  {
                     if (trmove->pos2[YAW] < trmove->s.angles[YAW])
                     {
                        if (!trmove->mfire)
                        {
                           if (trmove->oaxis == 1 || trmove->oaxis == 3 || trmove->oaxis == 4 || trmove->oaxis == 7)
                           {
                               trmove->movedir[1] = 1.0;
                               trmove->mfire=3;
                           }
                           else
                              trmove->mfire=1;
                        }
                     }
                     else if (trmove->pos2[YAW] > trmove->s.angles[YAW])
                           trmove->s.angles[YAW]=trmove->pos2[YAW];

                     if (trmove->pos2[ROLL] < trmove->s.angles[ROLL])
                     {
                        if (!trmove->mfire)
                        {
                           if (trmove->oaxis == 1 || trmove->oaxis == 2 || trmove->oaxis == 3 || trmove->oaxis == 5)
                           {
                                trmove->movedir[2] = 1.0;
                                trmove->mfire=3;
                            }
                            else
                               trmove->mfire=1;
                        }
                     }
                     else if (trmove->pos2[ROLL] > trmove->s.angles[ROLL])
                             trmove->s.angles[ROLL]=trmove->pos2[ROLL];
                 }
                 else if (ent->client->turaction==3) //check if up
                 {
                    if (trmove->pos1[PITCH] > trmove->s.angles[PITCH])
                    {
                     if (!trmove->mfire)
                     {
                        if (trmove->oaxis == 1 || trmove->oaxis == 2 || trmove->oaxis == 4 || trmove->oaxis == 6)
                        {
                             trmove->movedir[0] = 1.0;
                             trmove->mfire=3;
                         }
                         else
                            trmove->mfire=1;
                      }
                    }
                    else if (trmove->pos1[PITCH] < trmove->s.angles[PITCH])
                            trmove->s.angles[PITCH]=trmove->pos1[PITCH];
                 }
                 else if (ent->client->turaction==4) //check if down
                 {
                    if (trmove->pos2[PITCH] < trmove->s.angles[PITCH])
                    {
                       if (!trmove->mfire)
                       {
                          if (trmove->oaxis == 1 || trmove->oaxis == 2 || trmove->oaxis == 4 || trmove->oaxis == 6)
                          {
                               trmove->movedir[0] = 1.0;
                               trmove->mfire=3;
                           }
                           else
                              trmove->mfire=1;
                        }
                    }
                    else if (trmove->pos2[PITCH] > trmove->s.angles[PITCH])
                            trmove->s.angles[PITCH]=trmove->pos2[PITCH];
                 }
                 else if (ent->client->turaction==8) //check if door open
                 {
                    if (trmove->turtype==1) //check if door
                    {
                       if (trmove->tdaxis==1) //check door axis
                       {
                          trmove->tdpos1[ROLL]=trmove->tdmaxmove;
                          if (trmove->tdpos1[ROLL] > trmove->s.angles[ROLL])
                          {
                            if (!trmove->mfire)
                            {
                               trmove->movedir[2] = 1.0;
                               trmove->mfire=3;
                            }
                          }
                          else if (trmove->tdpos1[ROLL] < trmove->s.angles[ROLL])
                                  trmove->s.angles[ROLL]=trmove->tdpos1[ROLL];
                       }
                       else if (trmove->tdaxis==2) //check door axis
                       {
                          trmove->tdpos1[PITCH]=trmove->tdmaxmove;
                          if (trmove->tdpos1[PITCH] > trmove->s.angles[PITCH])
                          {
                            if (!trmove->mfire)
                            {
                                trmove->movedir[0] = 1.0;
                                trmove->mfire=3;
                            }
                          }
                          else if (trmove->tdpos1[PITCH] < trmove->s.angles[PITCH])
                               trmove->s.angles[PITCH]=trmove->tdpos1[PITCH];
                       }
                       else if (trmove->tdaxis==3) //check door axis
                       {
                          trmove->tdpos1[YAW]=trmove->tdmaxmove;
                          if (trmove->tdpos1[YAW] > trmove->s.angles[YAW])
                          {
                           if (!trmove->mfire)
                           {
                               trmove->movedir[1] = 1.0;
                               trmove->mfire=3;
                           }
                         }
                         else if (trmove->tdpos1[YAW] < trmove->s.angles[YAW])
                                trmove->s.angles[YAW]=trmove->tdpos1[YAW];
                       }
                    }
                 }
                 else if (ent->client->turaction==9) //check if door close (same axis checks apply)
                 {
                    if (trmove->turtype==1)
                    {
                       if (trmove->tdaxis==1)
                       {
                          trmove->tdpos2[ROLL]=trmove->tdminmove;
                          if (trmove->tdpos2[ROLL] < trmove->s.angles[ROLL])
                          {
                            if (!trmove->mfire)
                            {
                                trmove->movedir[2] = 1.0;
                                trmove->mfire=3;
                            }
                          }
                          else if (trmove->tdpos2[ROLL] > trmove->s.angles[ROLL])
                                 trmove->s.angles[ROLL]=trmove->tdpos2[ROLL];
                       }
                       else if (trmove->tdaxis==2)
                       {
                          trmove->tdpos2[PITCH]=trmove->tdminmove;
                          if (trmove->tdpos2[PITCH] < trmove->s.angles[PITCH])
                          {
                            if (!trmove->mfire)
                            {
                                trmove->movedir[0] = 1.0;
                                trmove->mfire=3;
                            }
                           }
                           else if (trmove->tdpos2[PITCH] > trmove->s.angles[PITCH])
                                  trmove->s.angles[PITCH]=trmove->tdpos2[PITCH];
                       }
                       else if (trmove->tdaxis==3)
                       {
                          trmove->tdpos2[YAW]=trmove->tdminmove;
                          if (trmove->tdpos2[YAW] < trmove->s.angles[YAW])
                          {
                           if (!trmove->mfire)
                           {
                               trmove->movedir[1] = 1.0;
                               trmove->mfire=3;
                           }
                          }
                          else if (trmove->tdpos2[YAW] > trmove->s.angles[YAW])
                                 trmove->s.angles[YAW]=trmove->tdpos2[YAW];
                       }
                    }
                 }
                 if (trmove->mfire==3) //if triggered
                 {
                     G_UseTargets (ent,ent);
                     trmove->mfire=2;

                     //check if going in reverse
                     if ((ent->client->turaction == 2) || (ent->client->turaction == 4) || (ent->client->turaction == 9))
                          VectorNegate (trmove->movedir, trmove->movedir);
                 }

                 //check if going off
                 if (ent->client->turaction==10) //check if turning off
                 {
                     if (trmove->mfire==2) //if triggered, trigger again to turn off
                         G_UseTargets (ent,ent);

                     ent->client->mfire=1;
                     trmove->mfire=0;

                     trmove->moveinfo.current_speed = 0;
                 }
 
                 if (trmove->moveinfo.current_speed < trmove->speed)
                 {
                     trmove->moveinfo.current_speed += trmove->accel; 
                     VectorScale (trmove->movedir, trmove->moveinfo.current_speed, trmove->avelocity);
                 }

                 //Copy first angles to default and turn on laser sight
                 if (ent->client->turaction==11)
                 {
                     VectorCopy (trmove->s.angles, trmove->dangles);
                     VectorCopy (ent->s.origin, ent->dangles);
                     if (trmove->laser && !trmove->lstat)
                     {
                         ent->target = trmove->laser;
                         G_UseTargets (ent,ent);
                         trmove->lstat = 1;
                     }
                     trmove->fstat=0;
                 }

                 //Snap back to default angles and turn laser sight off
                 if (ent->client->turaction==12)
                 {
                     VectorCopy (trmove->dangles, trmove->s.angles);
                     VectorCopy (ent->dangles, ent->s.origin);
                     if ((trmove->laser) && (trmove->lstat==2))
                     {
                         ent->target = trmove->laser;
                         G_UseTargets (ent,ent);
                         trmove->lstat = 0;
                     }
                     if (trmove->turtype == 3)
                         TRdoor_off (trmove);
                     if (trmove->fstat)
                         trmove->fstat=0;
                 }
                 if (ent->client->turaction==13)
                 {
                    //zoom
                    if (trmove->zoom)
                    {
                       if (trmove->zoom == 1)
                          ent->client->ps.fov = 60;
                       else if (trmove->zoom == 2)
                          ent->client->ps.fov = 30;
                       else if (trmove->zoom == 3)
                          ent->client->ps.fov = 10;
                       else if (trmove->zoom == 4)
                          ent->client->ps.fov = 90;
                       else
                       {
                          ent->client->ps.fov = 90;
                          trmove->zoom=0;
                       }
                       //advance zoom by one
                       trmove->zoom += 1;

                       //turn off after zooming
                       ent->client->turaction=10;
                    }
                     
                 }
                 //Check if there is a laser sight on the mover
                 if (trmove->laser)
                     Turret_Laser (trmove);

                 //Check if there is a range finder on the mover
                 if (trmove->findrange)
                     Turret_RF (ent, trmove);
              }   
         }
         if (ent->client->mfire==1)
         {
            //turn turret off
            ent->client->turaction=0;
            ent->client->mfire=0;
         }
      }
  }
}
