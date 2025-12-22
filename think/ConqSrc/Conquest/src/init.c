/* Init.c: Initializations routines. */
#include <stdio.h>
#include <sgtty.h>
#include <stdlib.h>

#include "defs.h"
#include "structs.h"
#include "vars.h"
#include "protos.h"

void initmach();

void setup_term()
{
  char *termname;
  struct sgttyb ttyinfo;
  
  if ((termname = getenv("TERM")) != NULL) /* Some kind of TERM set */
  {
    printf("Terminal type is %s.\n", termname);
    if (termname == "xterm") terminal_type = xterm;
    if (termname == "vt100") terminal_type = vt100;
    if (termname == "vt52") terminal_type = vt52;
    if (termname == "adm3") terminal_type = adm3;
    if (termname == "vis400") terminal_type = vis400;
    if (termname == "hpterm") terminal_type = hpterm;
    if (termname == "vi") terminal_type = vi; /* WHY??? */
    if (termname == "concept") terminal_type = concept;
    if (termname == "hardcopy") terminal_type = hardcopy;
    if (terminal_type == unknown)
    {
      printf("Unknown terminal type %s - using vt100.\n", termname);
      terminal_type = vt100;
    }
  }
  else
    terminal_type = vt100; /* For systems without $TERM */

  raw_fd = stdin;
  ioctl(fileno(raw_fd), TIOCGETP, &ttyinfo);
  ttyinfo.sg_flags |= RAW;
  ioctl(fileno(raw_fd), TIOCSETP, &ttyinfo);
  setbuf(raw_fd, NULL);
}

void startup()
{
  printf("\n *** CONQUEST *** \n");
  read_config(".conquestrc");
  
  setup_term();
  
  printf("\n* Welcome to CONQUEST! *\n\n");
  printf("Amiga version 1.2.1\n");
  printf("Hit return to continue\n");
  get_char();
  
  printf("\33<");
  
  srand(time(0));

  initconst();
  
  init_player();

  initmach();

  /* Put player on board */
  point(50,1);
  print_star(tf[PLAYER][1].dest);
  clear_field();

  /* And fight if in same place */
  if (tf[ENEMY][1].dest == tf[PLAYER][1].dest)
  {
    clear_left();
    battle();
  }
}

void assign_planets(tstar *ustar, int starnum)
{
  int i1, nplanets;
  tplanet *pplanet;
  
  nplanets=rnd(4)-2;
  if (nplanets < 0) nplanets = 1;
  if (nplanets!=0)
  {
    if ((pplanet = (tplanet *)calloc(1, sizeof(tplanet))) == NULL)
    {
      printf("Out of memory. Sorry.\n");
      exit(1);
    }
    ustar->first_planet=pplanet;
    for (i1=1 ; i1<=nplanets; i1++)
    {
      pplanet->number = rnd(2) + (2*i1) - 2;
      if (rnd(4)>2) pplanet->capacity = 10 * (rnd(4) + 2);
      else pplanet->capacity = 5 * rnd(3);
      pplanet->psee_capacity = pplanet->capacity;
      pplanet->esee_def = 1;
      pplanet->esee_team = NONE;
      pplanet->pstar = starnum;
      pplanet->team = NONE;
      if (i1 < nplanets)
      {
	if ((pplanet->next = (tplanet *)calloc(1, sizeof(tplanet))) == NULL)
	{
	  printf("Out of memory. Sorry.\n");
	  exit(1);
	}
	pplanet=pplanet->next;
      }
    }
  }
}

void initconst()
{
  int i1,x,y;

  /*init stars*/
  for (i1 = 1; i1<=nstars; i1++) 
  {
    do 
    {
      x=rnd(bdsize);  
      y=rnd(bdsize);
    } 
    while (board[x][y].star != '.');
    stars[i1].x=x;     
    stars[i1].y=y;

    board[x][y].star = 'A'+i1-1;
    board[x][y].enemy = '?';
    assign_planets(&stars[i1],i1);
  }

  /*initialize task forces*/
  tf[ENEMY][1].x = 1; 
  tf[ENEMY][1].y = 1;

  for (i1 = ENEMY ; i1<=PLAYER; i1++ )
    tf[i1][1].t = initunit;

  /* Small cheats for the enemy */
  switch (rnd(3)) 
  {
   case 1: weapons[ENEMY] = rnd(4) + 2;
    break;
    
   case 2: vel[ENEMY] = rnd(3);
    break;
    
   case 3: growth_rate[ENEMY] = (float)(rnd(4) + 3) / 10.0;
    break;
  }
}

void init_player()
{
  char str, key; 
  int star_number;
  int balance,cost,amt;
  char iline[81];

  /* Startup */
  printmap();
  point(33,20);
  printf("*Initialization*");

  do 
  {
    point(1,18);
    printf("start at star?\n     ");
    str = get_char();
    point(1,19);
    star_number= str-'A'+1;
  } 
  while ((star_number < 1) || (star_number > nstars));

  tf[PLAYER][1].x=stars[star_number].x;
  tf[PLAYER][1].y=stars[star_number].y;
  tf_stars[star_number][PLAYER]=1;
  tf[PLAYER][1].dest = star_number;

  point(1,20);
  printf("choose your initial fleet.");
  point(1,21);
  printf("you have %d transports", initunit);
  point(1,22);
  printf(" && %d units to spend", initmoney);
  point(1,23);
  printf("on ships or research.");

  print_res('V');
  print_res('R');
  print_res('W');

  balance = initmoney;
  do
  {
    point(1,19);
    print_tf(1);
    point(1,18);
    printf("%3d?                          ", balance);
    point(6,18);
    get_line(iline);
    do
    {
      cost = 0;
      key = get_token(iline,&amt);
      switch (key)
      {
       case 'C':
	cost = amt*c_cost;
	if (cost < amt) break; /* Overflow */
	if (cost <= balance)
	  tf[PLAYER][1].c=tf[PLAYER][1].c+amt;
	break;
       case 'S':
	cost = amt*s_cost;
	if (cost < amt) break; /* Overflow */
	if (cost <= balance)
	  tf[PLAYER][1].s=tf[PLAYER][1].s+amt;
	break;
       case 'B':
	cost = amt*b_cost;
	if (cost < amt) break; /* Overflow */
	if (cost <= balance)
	  tf[PLAYER][1].b=tf[PLAYER][1].b+amt;
	break;
       case 'H': 
	help(0); 
	break;
       case 'W': 
       case 'V': 
       case 'R':
	cost = amt;
	if (cost <= balance)
	{
	  research(PLAYER,key,amt);
	  print_res(key);
	}
	break;
       case ' ': 
	break;
       case '>':
	point(1,18);
	printf(">?      ");
	point(3,18);
	key = get_char();
	switch ( key )
	{
	 case 'M': 
	  printmap(); 
	  break;
	 case 'R': 
	  ressum(); 
	  break;
	 default:
	  error(" !Only M,R during initialize");
	} /*!= switch (*/
	break;
       default:
	error( " !Illegal field %c",key);
      } /*switch (*/
      if (cost <= balance)
	balance = balance - cost;
      else
      {
	error("  !can't afford %d%c",amt, key);
      }
    } 
    while (key != ' ');
  } 
  while (balance >0);
  stars[star_number].visit[PLAYER]=true;
  board[stars[star_number].x][stars[star_number].y].tf = 'a';
  board[stars[star_number].x][stars[star_number].y].enemy=' ';
  on_board(stars[star_number].x,stars[star_number].y);
  point(33,20);
}

void initmach()
{
  int res_amt, maxx, start_star, starnum, count;
  float slist[MAX_NUM_STARS+1];
  
  en_research = 'V';
  tf[ENEMY][1].c = 1;
  tf[ENEMY][1].s = 2;
  res_amt = 2;
  research(ENEMY, en_research, res_amt);

  /* Found out the best place to start (most stars reachable) */
  maxx = 0;
  start_star = 0;
  for (starnum = 1; starnum <= nstars; starnum++)
  {
    count = get_stars(starnum, slist);
    count += rnd(5);
    if (count > maxx)
    {
      maxx = count;
      start_star = starnum;
    }
  }

  tf[ENEMY][1].dest = start_star;
  tf[ENEMY][1].x = stars[start_star].x;
  tf[ENEMY][1].y = stars[start_star].y;
  stars[start_star].visit[ENEMY] = true;
  tf_stars[start_star][ENEMY] = 1;
}
