/* Combat.c: Combat commands and utilities */
#include <stdio.h>
#include "defs.h"
#include "structs.h"
#include "vars.h"
#include "protos.h"

/* Player attack at star. Assumes warships and enemy planet present */
void playerattack(int starnum)
{
  boolean battle;
  char command;
  struct stplanet *pplanet;

  point(33,20);
  printf("Attack at star %c", starnum+'A'-1);
  while (battle)
  {
    point(50,1);
    print_star(starnum);
    clear_field();
    point(1,18);
    printf("P?                            ");
    point(3,18);

    command = get_char();
    switch (command) 
    {
     case 'S':
      starsum();
      break;
     case 'M': 
      printmap();
      break;
     case 'H': 
      help(3);
      pause();
      break;
     case 'N': 
      make_tf();
      break;
     case 'J': 
      join_tf();
      break;
     case 'C': 
      print_col();
      break;
     case 'R': 
      ressum();
      break;
     case 'T': 
      tfsum();
      break;
     case 'G': 
     case ' ': 
      battle = play_salvo(starnum);
      break;
     case 'B': 
      printf("reak off attack");
      battle = FALSE;
      break;
     default:
      clear_left();
      error(" !Illegal command");
      break;
    } /*switch */
  }

  for (pplanet = stars[starnum].first_planet; pplanet; pplanet = pplanet->next)
    pplanet->under_attack = false;

  point(1,24);
  printf("Planet attack concluded       ");

  revolt(starnum);
}

/* Battle between tf's. Assumes ships from both sides and >0 warships present*/
void tf_battle(int starnum)
{
  int ennum, plnum, new_tf, i, dstar; 
  float enodds, plodds, slist[MAX_NUM_STARS+1]; 
  boolean battle, pla_loss, ene_loss, fin, first;
  char ch;

  board[stars[starnum].x][ stars[starnum].y].enemy = '!';
  update_board(stars[starnum].x, stars[starnum].y, left);

  ennum = 1;
  while ((tf[ENEMY][ennum].dest!=starnum) ||
	 (tf[ENEMY][ennum].eta!=0))
    ennum++;

  plnum = 1;
  if (tf_stars[starnum][player]>1)
  {
    new_tf = get_tf(player,starnum);
    for (i=1; i<=26; i++)
    {
      if ((tf[player][i].dest == starnum) && 
	  (tf[player][i].eta == 0) &&
	  (i != new_tf))
	joinsilent(player, &tf[player][new_tf], &tf[player][i]);
    }
    tf_stars[starnum][player] = 1;
    plnum = new_tf;
  } 
  else
  {
    while ((tf[player][plnum].dest!=starnum)||
	   (tf[player][plnum].eta!=0)) 
      plnum++;
  }

  battle = display_forces(ennum, plnum, &enodds, &plodds);

  pause();

  first = TRUE;
  while (battle)
  {
    if (left_line[24])
    {
      point(1,24);
      printf(blank_line);
      left_line[24] = false;
    }

    pla_loss = FALSE;
    ene_loss = FALSE;
    point(1,21);
    printf(" Enemy losses:                ");
    point(1,22);
    printf("Player losses:                ");

    /* Fight until there are losses, but not first time */
    do
    {
      point(15,21);
      ene_loss |= lose(&tf[ENEMY][ennum].t,'t',enodds);
      ene_loss |= lose(&tf[ENEMY][ennum].s,'s',enodds);
      ene_loss |= lose(&tf[ENEMY][ennum].c,'c',enodds);
      ene_loss |= lose(&tf[ENEMY][ennum].b,'b',enodds);
      point(15,22);
      pla_loss |= lose(&tf[player][plnum].t,'t',plodds);
      pla_loss |= lose(&tf[player][plnum].s,'s',plodds);
      pla_loss |= lose(&tf[player][plnum].c,'c',plodds);
      pla_loss |= lose(&tf[player][plnum].b,'b',plodds);
    }
    while (!first && !ene_loss && !pla_loss);
    first = FALSE;

    if (!ene_loss)
    {
      point(15,21);
      printf("(none)");
    }
    if (!pla_loss)
    {
      point(15,22);
      printf("(none)");
    }

    battle = display_forces(ennum,plnum,&enodds,&plodds);

    if (battle)
    {
      /* Withdraw the bad guys */
      new_tf = get_tf(ENEMY,starnum);
      if ((tf[player][plnum].c>0) || (tf[player][plnum].b>0))
      {
	tf[ENEMY][new_tf].t = tf[ENEMY][ennum].t;
	tf[ENEMY][new_tf].s = tf[ENEMY][ennum].s;

	if (best_withdraw_plan(starnum, enodds))
	{
	  tf[ENEMY][new_tf].c = tf[ENEMY][ennum].c;
	  tf[ENEMY][new_tf].b = tf[ENEMY][ennum].b;
	}
      }

      /* If any need to be withdrawn */
      if((tf[ENEMY][new_tf].t + tf[ENEMY][new_tf].s +
	  tf[ENEMY][new_tf].c + tf[ENEMY][new_tf].b) > 0) 
      {
	/* Find a place to withdraw to */
	get_stars(starnum,slist);
	do
	{
	  dstar = rnd(nstars);
	} 
	while (slist[dstar] <= 0);

	tf[ENEMY][new_tf].dest = dstar;
	tf[ENEMY][new_tf].eta = (int)((slist[dstar]-0.01)/vel[ENEMY])+1;
	tf[ENEMY][new_tf].xf=stars[starnum].x;
	tf[ENEMY][new_tf].yf=stars[starnum].y;
      } 
      else 
	tf[ENEMY][new_tf].dest = 0;
      
      fin = false;
      do
      {
	point(1,18);
	printf("B?                            ");
	point(3,18);
	ch = get_char();
	switch ( ch ) 
	{
	 case 'M':
	  printmap();
	  break;
	 case 'H': 
	  help(2);
	  break;
	 case 'S':
	  starsum();
	  break;
	 case 'T': 
	  tfsum();
	  break;
	 case 'C':
	  print_col();
	  break;
	 case '?': 
	  break;
	 case 'R':
	  ressum();
	  break;
	 case 'O': 
	  battle = display_forces(ennum,plnum,&enodds, &plodds);
	  break;
	 case 'W': 
	  withdraw(starnum,plnum);
	  battle = display_forces(ennum,plnum,&enodds,&plodds);
	  break;
	 case ' ': 
	 case 'G': 
	  fin = true;
	  break;
	 default: 
	  printf("!illegal command");
	} /*switch (*/
      } 
      while (!fin && battle);

      zero_tf(ENEMY,new_tf);
      zero_tf(player,plnum);

      if (tf[ENEMY][new_tf].dest != 0) 
      {
	point(1, 23);
	printf("en withdraws");
	point(14, 23);
	disp_tf(&tf[ENEMY][new_tf]);

	tf[ENEMY][ennum].t = tf[ENEMY][ennum].t - tf[ENEMY][new_tf].t;
	tf[ENEMY][ennum].s = tf[ENEMY][ennum].s - tf[ENEMY][new_tf].s;
	tf[ENEMY][ennum].c = tf[ENEMY][ennum].c - tf[ENEMY][new_tf].c;
	tf[ENEMY][ennum].b = tf[ENEMY][ennum].b - tf[ENEMY][new_tf].b;

	zero_tf(ENEMY,ennum);

	battle = display_forces (ennum, plnum, &enodds, &plodds);
      }
    }
  }

  zero_tf(ENEMY, ennum);
  zero_tf(player, plnum);

  revolt(starnum);

  on_board(stars[starnum].x, stars[starnum].y);
}

void withdraw(int starnum, int plnum)
{
  int withnum;
  boolean error;

  printf("ithdraw ");
  clear_left();
  point(1,19);
  withnum = split_tf(plnum);

  if ( tf[player][withnum].dest != 0 ) 
  {
    point(1,20);
    error = set_des(withnum);
    if (error) 
    {
      tf[player][plnum].dest = starnum;
      joinsilent(player, &tf[player][plnum], &tf[player][withnum]);
      tf_stars[starnum][player] = 1;
    } 
    else
      /* FOO: Shouldn't this be a return code? Or is it used otherwhere */
      tf[player][withnum].withdrew = true;
  }
}

void blast(tplanet *planet, int factors)
{
  int killed;
  
  killed = min(planet->capacity,factors / 4);

  planet->inhabitants = min(planet->inhabitants, planet->capacity) - killed;
  planet->iu = min(planet->iu - killed, planet->inhabitants * iu_ratio);
  planet->capacity = planet->capacity - killed;

  /* Totally destroyed... */
  if (planet->inhabitants <= 0) 
  {
    planet->inhabitants = 0;
    planet->iu = 0;
    planet->mb = 0;
    planet->amb = 0;

    if (planet->team != none)
    {
      col_stars[planet->pstar][planet->team]--;

      planet->team = none;
      planet->esee_team = none;
      planet->conquered = false;

      on_board(stars[planet->pstar].x, stars[planet->pstar].y);
    }
  }
}

void fire_salvo(tteam att_team, int tfnum, struct stplanet *planet,
		boolean first_time)
{
  int bases, att_forces, def_forces; 
  boolean a_losses, p_losses;
  float att_odds, def_odds, attack_save, defend_save;
  tteam def_team;
  struct sttf *task = &tf[att_team][tfnum];

  if (left_line[24]) 
  {
    point(1,24);
    printf(blank_line);
    left_line[24] = false;
  }

  if (att_team == ENEMY)
    def_team = player;
  else
    def_team = ENEMY;

  att_forces = weapons[att_team]*(task->c*c_guns + task->b*b_guns);
  def_forces = weapons[def_team]*(planet->mb*c_guns+planet->amb*b_guns);

  if (def_forces > 0)
  {
    att_odds = fmin((((float) def_forces) / att_forces), 14.0);
    attack_save = exp(log(0.8) * (att_odds));
    def_odds = fmin((float)att_forces/def_forces, 14.0);
    defend_save=exp(log(0.8)* (def_odds));

    point(1,20);
    if (att_team == player)
      printf("TF%c", tfnum+'a'-1);
    else
      printf(" EN");
    printf(": %4d(weap %2d)sur: %4.0f", att_forces, 
	   weapons[att_team], attack_save*100);

    point(1,21);
    printf(" %c%d:%4d (weap %2d)sur: %4.0f", planet->pstar+'A'-1, 
	   planet->number, def_forces, weapons[def_team], defend_save*100);

    point(1,22);
    printf("Attacker losses:              ");
    point(1,23);
    left_line[23]=true;
    printf(" Planet losses :              ");

    a_losses = FALSE;
    p_losses = FALSE;

    do 
    {
      point(17,22);
      a_losses |= lose(&task->c, 'c', attack_save);
      a_losses |= lose(&task->b, 'b', attack_save);

      point(17,23);
      bases = planet->mb;
      p_losses |=lose(&planet->mb, 'm', defend_save);
      if ( planet->mb != bases ) printf("b");

      bases = planet->amb;
      p_losses |= lose(&planet->amb,'a',defend_save);
      if ( planet->amb != bases ) printf("mb");
    } 
    while (!first_time && !p_losses && a_losses);

    if (!a_losses) 
    {
      point(17,22);
      printf("(none)");
    }

    if (!p_losses) 
    {
      point(17,23);
      printf("(none)");
    }
  }

  if ((planet->mb+planet->amb == 0) && (any_bc(att_team, planet->pstar)))
  {
    point(1,24);
    printf("Planet %d falls!               ", planet->number);

    planet->team = att_team;
    planet->esee_team = att_team;
    planet->conquered = true;

    col_stars[task->dest][def_team]--;
    col_stars[task->dest][att_team]++;

    point(50,1);
    print_star(planet->pstar);

    clear_field();

    on_board(stars[task->dest].x, stars[task->dest].y);
  }
}

/* Play attack at star. Assumes warships & enemy planet present */
/* Returns TRUE if there is still a battle going on */
boolean play_salvo(int starnum)
{
  int planet_num, tf_num; 
  boolean first_time;
  struct stplanet *pplanet;
  
  printf("Attack planet ");

  pplanet = stars[starnum].first_planet;

  /* If more than one enemy planet, we have to ask which one */
  if ((col_stars[starnum][ENEMY]>1))
  {
    printf(":");
    planet_num = get_char() - '0';
    clear_left();

    for (;(pplanet->number != planet_num) && (pplanet->next);
	 pplanet = pplanet->next)
      ;

    if (pplanet->number != planet_num)
    {
      error("! That is not a useable planet");
      return(TRUE);
    } 
    if (pplanet->team != ENEMY)
    {
      error(" !Not an enemy colony");
      return(TRUE);
    }
  } 
  else 
  {
    while (pplanet->team != ENEMY)
      pplanet = pplanet->next;

    printf("%d", pplanet->number);
    clear_left();
  }

  /* Find out which tf is attacking */
  point(1,19);
  printf(" attacking tf ");

  if (tf_stars[starnum][player]>1) 
  {
    printf(":");
    tf_num = get_char() - 'A' + 1;

    if ((tf_num < 1) || (tf_num > 26))
    {
      error(" !Illegal tf");
      return(TRUE);
    }

    if (tf[player][tf_num].dest == 0)
    {
      error(" !Nonexistent tf");
      return(TRUE);
    }

    if ((tf[player][tf_num].dest!=starnum) || (tf[player][tf_num].eta!=0))
    {
      error(" !Tf is not at this star      ");
      return(TRUE);
    }

    if ((tf[player][tf_num].b+tf[player][tf_num].c) == 0)
    {
      error(" !Tf has no warships");
      return(TRUE);
    }
  } 
  else 
  {
    /* Only one TF - must be the one with warships */
    tf_num = 1;
    while ((tf[player][tf_num].dest != starnum) ||
	   (tf[player][tf_num].eta != 0))
      tf_num++;

    putchar(tf_num+'a'-1);
  }

  first_time = !pplanet->under_attack;
  if (!(pplanet->under_attack))
  {
    pplanet->under_attack = true;
    point(50,1);
    print_star(starnum);
    clear_field();
  }
  fire_salvo(player, tf_num, pplanet, first_time);
  zero_tf(player,tf_num);

  return((col_stars[starnum][ENEMY]>0) && any_bc(player,starnum));
}

void battle()
{
  boolean first;
  int starnum;

  first = true;
  for (starnum = 1; starnum <= NUM_STARS; starnum++)
  {
    if ((tf_stars[starnum][ENEMY] > 0) &&
	(tf_stars[starnum][player] > 0) &&
	(any_bc(ENEMY, starnum) || any_bc(player, starnum)))
    {
      if (first) 
      {
	point(33,20);
	printf("* Tf battle *   ");
	first = false;
      }
      tf_battle(starnum);
    }

    /* By now we know there is only one side left with warships here */
    if ((any_bc(ENEMY,starnum)) && (col_stars[starnum][player] > 0))
      enemy_attack(starnum);

    if ((any_bc(player, starnum)) && (col_stars[starnum][ENEMY] > 0))
      playerattack(starnum);
  }
}
