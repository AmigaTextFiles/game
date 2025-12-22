/* Commands.c: Getting user commands */
#include <stdio.h>
#include "defs.h"
#include "structs.h"
#include "vars.h"
#include "protos.h"

void blast_planet()
{
  int tf_num, planet_num;
  tplanet *pplanet; 
  int factors,starnum; 
  char iline[81]; 
  int ind = 1, amount; 

  printf("last");
  clear_left();
  point(1,19);
  printf("Firing TF:");

  tf_num = get_char() - 'A' + 1;

  if ((tf_num < 1) || (tf_num > 26))
  {
    error(" !Illegal tf");
    return;
  }

  if (tf[player][tf_num].dest == 0) 
  {
    error(" !Nonexistent tf");
    return;
  }
  
  if (tf[player][tf_num].eta != 0)
  {
    error(" !Tf is not in normal space   ");
    return;
  }
  
  if (tf[player][tf_num].blasting)
  {
    error(" !Tf is already blasting     ");
    return;
  }

  if ((tf[player][tf_num].b == 0) && (tf[player][tf_num].c == 0)) 
  {
    error(" !Tf has no warships         ");
    return;
  }

  starnum = tf[player][tf_num].dest;
  pplanet = stars[starnum].first_planet;
  
  if (pplanet == NULL)
  {
    error(" !No planets at star %c       ", starnum + 'A' - 1);
    return;
  }

  point(1,20);
  printf("Target colony ");

  if (pplanet->next== nil) /* Only planet at star */
    printf("%2d",pplanet->number);
  else
  {
    printf(":");
    planet_num = get_char() - '0';
    
    for (;(pplanet->number != planet_num) && (pplanet->next); 
	 pplanet = pplanet->next);

    if (pplanet->number != planet_num) 
    {
      error(" !No such planet at this star ");
      return;
    }
  }
  
  if (pplanet->team == ENEMY)
  {
    error(" !Conquer it first!");
    return;
  }
  
  if ((pplanet->team == player) && (!pplanet->conquered)) 
  {
    error(" !That is a human colony!!    ");
    return;
  }
  
  factors = weapons[player] 
    * ((tf[player][tf_num].c * c_guns) +
       (tf[player][tf_num].b * b_guns));
  
  point(1,21);
  printf("Units (max %3d) :", factors/4);
  point(18,21);
  get_line(iline);
  get_token(iline,&amount);
  
  if (amount < 0)
    factors = 0;
  else
    if (amount > 0)
      factors = min(factors, amount * 4);
  
  tf[player][tf_num].blasting = true;
  point(1,22);
  printf("Blasting %3d units", factors/4);

  blast(pplanet,factors);

  point(1,23);
  left_line[23] = true;
  putchar(pplanet->pstar+'A'-1);

  pplanet->psee_capacity = pplanet->capacity;

  if (((y_cursor > 21) && (x_cursor >= 50)) || (y_cursor > 24))
  {
    pause();
    clear_field();
    point(50,1);
  }

  printf("%d:%2d                         ", 
	 pplanet->number, pplanet->psee_capacity);
  point(x_cursor + 5, y_cursor);
  x_cursor = x_cursor - 5;  
  if (pplanet->psee_capacity == 0)
    printf(" Decimated");
  else if ((pplanet->team == none))
    printf(" No colony");
  else if (pplanet->team == player) /* This must be a conquered planet! */
  {
    printf("(%2d,/%3d)", pplanet->inhabitants, pplanet->iu);
    printf("Con");
    /*    else
      printf("   ");
    if ( pplanet->mb!=0 )
      printf("%2dmb", pplanet->mb);
    else
      printf("    ");
    if ( pplanet->amb!=0 )
      printf("%2damb", pplanet->amb);*/
  } /* Impossible that we have blasted at an enemy */
  /* And besides, this should be a generic routine */
  /*
  else if ((pplanet->team==ENEMY) && see)
  {
    printf("*EN*");
    if ( see && pplanet->conquered )
    {
      printf("Conquered");
    } 
	else
	  printf("   ");
	if ( pplanet->under_attack )
	{
	  if ( pplanet->mb != 0 )
	    printf("%2dmb", pplanet->mb);
	  else
	    printf("    ");
	  if ( pplanet->amb != 0 )
	    printf("%2damb", pplanet->amb);
	}
      }
      point(x_cursor,y_cursor + 1);
  */      
}

void inputplayer()
{
  char key; 
  boolean fin;

  point(33,20);
  printf("* Movement *    ");

  fin=false;
  do
  {
    point(1,18);
    printf("?                             ");
    point(2,18);
    key = get_char();

    switch (key)
    {
     case 'M': 
      printmap();
      break;
     case 'B': 
      blast_planet();
      break;
     case 'G': 
     case ' ': 
      fin=true;
      break;
     case 'H': 
      help(1);
      break;
     case 'L': 
      land();
      break;
     case 'D': 
      send_tf();
      break;
     case 'S': 
      starsum();
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
     case 'Q':
      fin = true;
      quit();
      break;
     case '?':
      break;
     case 'T': 
      tfsum();
      break;
     case 'E':
      /* Info about enemy - for debugging purposes only! */
#ifdef DEBUG
      point(50,1);
      clear_field();
      point(50,1);
      printf("Enemy status:");
      point(50,2);
      printf("V: %d, R: %d, W: %d, Next: %c", vel[ENEMY], range[ENEMY], weapons[ENEMY], en_research);
      point(50,3);
      printf("C:");
      for (key = 1; key <= MAX_NUM_STARS; key++)
	if (col_stars[key][ENEMY])
	  printf("%c", key + 'A' - 1);
      point(50,4);
      printf("F:");
      for (key = 1; key <= MAX_NUM_STARS; key++)
	if (tf_stars[key][ENEMY])
	  printf("%c", key + 'A' - 1);
      printf(" ");
      for (key = 1; key <= MAX_FLEETS; key++)
	if ((tf[ENEMY][key].dest != 0) && (tf[ENEMY][key].eta > 0))
	  printf("%c%d", tf[ENEMY][key].dest+'A'-1, tf[ENEMY][key].eta);
      break;
#endif
     default:
      error("  !illegal command");
    }  /*switch */
  } 
  while (!fin);
}

void land()
{
  char tfc,planc; 
  int x,y,room_left,tfnum, transports,planet_num;
  int starnum; 
  char iline[81]; 
  struct stplanet *pplanet;

  printf("and tf:");
  tfc = get_char();
  clear_left();
  tfnum = tfc-'A'+1;

  if ((tfnum<1) || (tfnum>26))
  {
    error("  !illegal tf");
    return;
  }

  if ((tf[player][tfnum].dest == 0))
  {
    error("  !nonexistent tf");
    return;
  }

  if ((tf[player][tfnum].eta != 0))
  {
    error("  !tf is not in normal space  ");
    return;
  }

  starnum= tf[player][tfnum].dest;
  pplanet= stars[starnum].first_planet;

  if (pplanet == NULL)
  {
    error("  !no planets at this star    ");
    return;
  }
  
  if (tf_stars[starnum][ENEMY] > 0) 
  {
    error("  !enemy ships present");
    return;
  }

  /* This should be put in a procedure soon */
  point(11,18);
  printf(" planet ");
  if (pplanet->next == NULL) 
  {
    planet_num = pplanet->number;
    printf("%d", planet_num);
  } 
  else 
  {
    printf(":");
    planc = get_char();
    planet_num = planc-'0';

    for (;(pplanet) && (pplanet->number != planet_num); pplanet = pplanet->next);
    
    if (!pplanet)
    {
      error(" !Not a habitable planet ");
      return;
    }
  }
  
  if ((pplanet->team == ENEMY) || 
      ((pplanet->team == player) && (pplanet->conquered)))
  {
    error("  !Enemy infested planet  !!  ");
    return;
  }
  
  /* get the number of transports*/
  room_left = pplanet->capacity - pplanet->inhabitants;
  
  point(1,19);
  printf(" transports:");
  get_line(iline);
  get_token(iline,&transports);

  if (transports == 0) transports = tf[player][tfnum].t;
  
  if (transports < 1)
  {
    error("  !illegal transports");
    return;
  }

  if (transports > tf[player][tfnum].t) 
  {
    error("  !only %2d transports in tf", tf[player][tfnum].t);
    return;
  }
  
  if (transports > room_left)
  {
    error("  !only room for %2d transports", room_left);
    return;
  }
  
  pplanet->team = player;
  if (pplanet->inhabitants == 0)
    col_stars[starnum][player]++;
  pplanet->inhabitants=pplanet->inhabitants+transports;
  pplanet->iu=pplanet->iu + transports;
  tf[player][tfnum].t=tf[player][tfnum].t-transports;

  x=tf[player][tfnum].x; 
  y=tf[player][tfnum].y;
  if (board[x][y].enemy == ' ')
  {
    board[x][y].enemy = '@';
    update_board(x,y,left);
  }
  point(1,20);
  putchar(starnum+'A'-1);
  
  if (((y_cursor > 21) && (x_cursor >= 50)) || (y_cursor > 24))
  {
    pause();
    clear_field();
    point(50,1);
  }

  printf("%d:%2d                         ",
	 pplanet->number, pplanet->psee_capacity);

  point(x_cursor + 5, y_cursor);
  x_cursor = x_cursor - 5;

  printf("(%2d,/%3d)   ", pplanet->inhabitants, pplanet->iu);
  
  if (pplanet->mb != 0)
    printf("%2dmb", pplanet->mb);
  else
    printf("    ");

  if (pplanet->amb!=0)
      printf("%2damb", pplanet->amb);
  
  point(x_cursor,y_cursor + 1);
  
  zero_tf(player,tfnum);
  print_tf(tfnum);
}

void quit()
{
  clear_screen();
  printf("Quit game....[verify]\n");

  if (get_char() != 'Y')
    printmap();
  else 
    game_over = true;
}

void send_tf()
{
  char tf_move;
  int tf_num;
  
  printf("estination tf:");

  tf_move = get_char();
  clear_left();
  point(1,19);
  tf_num = tf_move-'A'+1;

  if ((tf_num<1) || (tf_num>26))
  { 
    error(" !illegal tf");
    return;
  } 
  
  if (tf[player][tf_num].dest == 0)
  { 
    error(" !nonexistent tf");
    return;
  } 

  if ((tf[player][tf_num].eta != 0) &&
      ((tf[player][tf_num].eta != tf[player][tf_num].origeta) ||
       (tf[player][tf_num].withdrew))) 
  { 
    error(" !Tf is not in normal space  ");
    return;
  } 
  
  if (tf[player][tf_num].blasting) 
  { 
    error(" !Tf is blasting a planet");
    return;
  } 

  tf[player][tf_num].withdrew = false;
  set_des(tf_num);
}

void inv_player(int x, int y, struct stplanet *planet)
{
  boolean printtf; 
  char iline[81]; 
  char key;
  int cost,amount,ind = 1,new_tf,balance;
  int trash1, trash2;
  
  new_tf = get_tf(player,planet->pstar);
  tf_stars[planet->pstar][player]++;
  printtf = false;

  balance=planet->iu;

  clear_left();
  point(1,19);
  putchar(planet->pstar+'A'-1);
  
  printf("%d:%2d                         ", planet->number, planet->psee_capacity);
  point(x_cursor + 5, y_cursor);
  x_cursor = x_cursor - 5;
  printf("(%2d,/%3d)", planet->inhabitants, planet->iu);

  if (planet->conquered)
    printf("Con");
  else
    printf("   ");

  if (planet->mb != 0)
    printf("%2dmb", planet->mb);
  else
    printf("    ");
  if (planet->amb != 0)
    printf("%2damb", planet->amb);

  point(x_cursor,y_cursor + 1);
  
  do 
  {
    point(1,18);
    printf("%3d?                          ", balance);

    point(5,18);
    get_line(iline);

    do 
    {
      cost = 0;
      
      key = get_token(iline,&amount);
      switch (key)
      {
       case 'A': 

	if (planet->inhabitants == 0) 
	{
	  error("  !abandoned planet");
	  break;
	} 
	
	if (planet->conquered)
	{
	  error(" !No amb  on conquered colony ");
	  break;
	}

	cost = amount*amb_cost;
	if (cost < amount) amount = cost = 0;
	if (cost <= balance)
	  planet->amb=planet->amb+amount;
	break;

       case 'B': 
	cost = amount*b_cost;
	if (cost < amount) amount = cost = 0;
	if (cost <= balance)
	{
	  tf[player][new_tf].b=tf[player][new_tf].b + amount;
	  printtf = true;
	}
	break;
       case 'C': 
	cost = amount*c_cost;
	if (cost < amount) amount = cost = 0;
	if (cost <= balance)
	{
	  tf[player][new_tf].c=tf[player][new_tf].c + amount;
	  printtf = true;
	}
	break;
       case 'H': 
	help(4);
	break;
       case 'M': 
	if (planet->inhabitants == 0)
	{
	  error("  !abandoned planet");
	  break;
	} 
	if (planet->conquered)
	{
	  error(" !No Mb  on conquered colony  ");
	  break;
	} 

	cost=amount * mb_cost;
	if (cost < amount) amount = cost = 0;
	if (cost <= balance)
	  planet->mb = planet->mb+amount;
	break;
       case 'S': 
	cost = amount*s_cost;
	if (cost < amount) amount = cost = 0;
	if (cost <= balance)
	{
	  tf[player][new_tf].s=tf[player][new_tf].s + amount;
	  printtf = true;
	}
	break;
       case 'T': 
	if (planet->conquered)
	{
	  error( "!No transports on conqered col");
	  break;
	} 

	cost = amount;
	if (cost <= balance)
	{
	  if (cost > planet->inhabitants)
	  {
	    error(" ! Not enough people for ( trans");
	    cost=0;
	    break;
	  } 

	  tf[player][new_tf].t = tf[player][new_tf].t+amount;

	  planet->inhabitants = planet->inhabitants-amount;

	  trash1 = planet->iu - amount;
	  trash2 = planet->inhabitants * iu_ratio;
	  planet->iu = min(trash1, trash2);

	  printtf = true;
	  
	  if (planet->inhabitants == 0)
	  {
	    col_stars[planet->pstar][player]--;
	    if (col_stars[planet->pstar][player] == 0)
	    {
	      board[x][y].enemy = ' ';
	      update_board(x,y,left);
	    }

	    planet->team=none;
	    planet->amb=0; 
	    planet->mb=0; 
	    planet->iu=0;
	  }
	}
	break;
       case 'I': 
	if ((amount+planet->iu) > (planet->inhabitants*iu_ratio))
	{
	  error(" !Can't support that many iu's");
	  break;
	} 

	cost = i_cost*amount;
	if (cost < amount) amount = cost = 0;
	if (cost <= balance)
	  planet->iu=planet->iu+amount;
	break;
       case 'R': 
       case 'V': 
       case 'W':
	cost = amount;
	if (cost <= balance)
	{
	  point(1,21);
	  research(player,key,amount);
	}
	print_res(key);
	break;
       case '*': /* Invest as much as needed in one item */
	key = get_token(iline, &amount);
	switch (key)
	{
	 case 'B':
	  amount = max(1, balance/B_COST);
	  cost = amount * B_COST;
	  if (cost <= balance)
	  {
	    tf[player][new_tf].b += amount;
	    printtf = true;
	  }
	  break;
	 case 'C':
	  amount = max(1, balance/C_COST);
	  cost = amount * C_COST;
	  if (cost <= balance)
	  {
	    tf[player][new_tf].c += amount;
	    printtf = true;
	  }
	  break;
	 case 'S':
	  amount = max(1, balance/S_COST);
	  cost = amount * S_COST;
	  if (cost <= balance)
	  {
	    tf[player][new_tf].s += amount;
	    printtf = true;
	  }
	  break;
	 case 'A':
	  if (planet->inhabitants == 0)
	  {
	    error("  !abandoned planet");
	    break;
	  } 
	  if (planet->conquered)
	  {
	    error(" !No AMb  on conquered colony  ");
	    break;
	  } 
	  amount = max(1,balance/AMB_COST);
	  cost = amount*AMB_COST;
	  if (cost <= balance)
	    planet->amb = planet->amb+amount;
	  break;
	 case 'M':
	  if (planet->inhabitants == 0)
	  {
	    error("  !abandoned planet");
	    break;
	  } 
	  if (planet->conquered)
	  {
	    error(" !No Mb  on conquered colony  ");
	    break;
	  } 
	  amount = max(1,balance/MB_COST);
	  cost = amount*MB_COST;
	  if (cost <= balance)
	    planet->mb = planet->mb+amount;
	  break;
	 case 'T':
	  if (planet->conquered)
	  {
	    error( "!No transports on conqered col");
	    break;
	  } 

	  amount = cost = min(planet->inhabitants, balance);

	  tf[player][new_tf].t += amount;
	  planet->inhabitants = planet->inhabitants-amount;

	  trash1 = planet->iu - amount;
	  trash2 = planet->inhabitants * iu_ratio;
	  planet->iu = min(trash1, trash2);

	  printtf = true;
	  
	  if (planet->inhabitants == 0)
	  {
	    col_stars[planet->pstar][player]--;
	    if (col_stars[planet->pstar][player] == 0)
	    {
	      board[x][y].enemy = ' ';
	      update_board(x,y,left);
	    }

	    planet->team=none;
	    planet->amb=0; 
	    planet->mb=0; 
	    planet->iu=0;
	  }
	  break;
	 case 'I':
	  if (planet->inhabitants*IU_RATIO-planet->iu <= 0)
	  {
	    error("!Can't support that many IU's.");
	    break;
	  }
	  amount = min(balance/I_COST,planet->inhabitants*IU_RATIO-planet->iu);
	  amount = max(1,amount);
	  cost = I_COST*amount;
	  if (cost <= balance)
	    planet->iu=planet->iu+amount;
	  break;
	 case 'R':
	 case 'W':
	 case 'V':
	  cost = research_limited(PLAYER, key, balance);
	  print_res(key);
	  break;
	 case ' ':
	  break;
	 default:
	  error("Invalid investment field %c", key);
	  break;
	}
	break;
       case '+': /* Invest as much as possible in attack */
	amount = balance/B_COST;
	if (amount > 0)
	{
	  cost = amount*B_COST;
	  tf[player][new_tf].b += amount;
	  printtf = true;
	}
	amount = (balance-cost)/C_COST;
	if (amount > 0)
	{
	  cost += amount*C_COST;
	  tf[player][new_tf].c += amount;
	  printtf = true;
	}
	break;
       case '-': /* Invest as much as possible in defence */
	if (planet->inhabitants == 0)
	{
	  error("  !abandoned planet");
	  break;
	} 
	if (planet->conquered)
	{
	  error(" !No defense on conquered colony  ");
	  break;
	} 
	amount = balance/AMB_COST;
	if (amount > 0)
	{
	  cost = amount*AMB_COST;
	  planet->amb = planet->amb+amount;
	}
	amount = (balance-cost)/MB_COST;
	if (amount > 0)
	{
	  cost += amount*MB_COST;
	  planet->mb = planet->mb+amount;
	}
	break;
       case ' ': 
	break;
       case '>': 
	point(1,18);
	printf(">?     ");

	point(3,18);
	key = get_char();
	switch (key)
	{
	 case 'M':
	  printmap(); 
	  break;
	 case 'S':
	  starsum(); 
	  break;
	 case 'C':
	  print_col(); 
	  break;
	 case 'R': 
	  ressum(); 
	  break;
	 default:
	  error(" !Only M,S,C,R allowed      ");
	}
	break;
       default:
	error(" !Illegal field %c",key);
      }
      if (cost > balance)
      {
	error(" !can't affort %3d%c", amount, key);
      }
      else
	balance = balance - cost;
    } 
    while (key != ' ');

    clear_left();
    point(1,19);
    putchar(planet->pstar+'A'-1);
    
    printf("%d:%2d                         ", planet->number, planet->psee_capacity);
    point(x_cursor + 5, y_cursor);
    x_cursor = x_cursor - 5;
    printf("(%2d,/%3d)", planet->inhabitants, planet->iu);

    if (planet->conquered)
      printf("Con");
    else
      printf("   ");

    if ( planet->mb!=0 )
      printf("%2dmb", planet->mb);
    else
      printf("    ");
    if ( planet->amb!=0 )
      printf("%2damb", planet->amb);
    point(x_cursor,y_cursor + 1);
    
    if (printtf) 
    {
      point(1,20);
      print_tf(new_tf);
    }
  } 
  while (balance > 0);

  zero_tf(player,new_tf);
  on_board(x,y);
}
