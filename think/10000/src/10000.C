/* TEN THOUSAND */
#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <time.h>
#include <string.h>
#include <math.h>
#include <ctype.h>
#define AMI 1
#if(AMI)
#include "10000ami.h"
#else
#include "10000ibm.h"
#endif

/*** DEFINE EXTERNALS ***/
int min = 1000, psc[8], sr[5], dice[5], n[6], nhp, np, cp, dtr, rt, poss,
  hs, tt, analyse (int), ran (int), legal[5], oldrt, olddtr, sel, compdec (void),
  playsleft, new (void), fob, pob;
void putbox (int), drawbox (int), activatebox (int), roll (void), instr (void),
  quit (int), wait (int), drawbutton (int, int, char[], int), itsa2000 (void),
  zonk (void), wazoo (void), throwback (void), updatert (void);
char pnm[8][8] =
{"ÄÄÄÄÄÄÄ", "ÄÄÄÄÄÄÄ", "ÄÄÄÄÄÄÄ", "ÄÄÄÄÄÄÄ", "ÄÄÄÄÄÄÄ", "ÄÄÄÄÄÄÄ",
 "ÄÄÄÄÄÄÄ", "ÄÄÄÄÄÄÄ"};
char pbox[4][10] =
{"ÚÄÄÄÄÄÄÄ¿", "³       ³", "³       ³", "ÀÄÄÄÄÄÄÄÙ"};
char rollbox[3][12] =
{"ÚÄÄÄÄÄÄÄÄÄ¿", "³         ³", "ÀÄÄÄÄÄÄÄÄÄÙ"};
char scorebox[3][12] =
{"ÜÜÜÜÜÜÜÜÜÜÜ", "Û         Û", "ßßßßßßßßßßß"};
char button[3][20] =
{"ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·", "³                 º", "ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"};
char activebutton[3][20] =
{"ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ", "ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ", "ßßßßßßßßßßßßßßßßßßß"};
char die1a[12] = "ÜÜÜÜÜÜÜÜÜÜÜ", die1b[12] = "İÜÜÜÜÜÜÜÜÜŞ", die2[12] = "İÛÛÛÛÛÛÛÛÛŞ",
  die3a[12] = "İßßßßßßßßßŞ", die3b[12] = "ßßßßßßßßßßß";
char die[6][3][12] =
{
  {"İÛÛÛÛÛÛÛÛÛŞ", "İÛÛÛÛ ÛÛÛÛŞ", "İÛÛÛÛÛÛÛÛÛŞ"},
  {"İÛ ÛÛÛÛÛÛÛŞ", "İÛÛÛÛÛÛÛÛÛŞ", "İÛÛÛÛÛÛÛ ÛŞ"},
  {"İÛ ÛÛÛÛÛÛÛŞ", "İÛÛÛÛ ÛÛÛÛŞ", "İÛÛÛÛÛÛÛ ÛŞ"},
  {"İÛ ÛÛÛÛÛ ÛŞ", "İÛÛÛÛÛÛÛÛÛŞ", "İÛ ÛÛÛÛÛ ÛŞ"},
  {"İÛ ÛÛÛÛÛ ÛŞ", "İÛÛÛÛ ÛÛÛÛŞ", "İÛ ÛÛÛÛÛ ÛŞ"},
  {"İÛ ÛÛÛÛÛ ÛŞ", "İÛ ÛÛÛÛÛ ÛŞ", "İÛ ÛÛÛÛÛ ÛŞ"}};
char strangename[8][8] =
{"Sven", "Helga", "Sigmund", "Buffy", "Dweezil", "Claude", "Ursula", "Arturo"};

main (int argc, char argv[])
{
  int i, j;
  char temp[80], temp2[2], temp3[5];
  srand ((int) time (NULL));
  for (i = 1; i <= ran (20); i++)
    ran (i);	/*** This eliminates the preliminary repetition in the random # generator ***/
#if(AMI)
    {
      setupamigascreen ();
      uamenu (G, 1, 0, 0, "Ten Thousand", ' ', 0, MIDRAWN | MENUENABLED, 0);
      uamenu (G, 1, 1, 0, "Quit programme", 'Q', 0, MIDRAWN | ITEMTEXT | HIGHBOX | ITEMENABLED | COMMSEQ, (int (*)()) quit);
    }
#endif

NEWGAME:
  cls ();
  drawpic ();
  colour (15, 2);
  if (ask (23, "Dost thou require instructions"))
    instr ();
clear(23);
  do
    {
      colour (5, 0);
      prompt (23, "How many human players are there (0-8 or [Q]uit)?", temp2, 1);
      if (toupper (temp2[0]) == 'Q')
	quit (23);
      nhp = (int) temp2[0] - 48;
    }
  while (nhp < 0 || nhp > 8);
  if (nhp > 0) {clear(23);
    for (i = 1; i <= nhp; i++)
      {
	colour (11, 2);
	sprintf (temp, "Name of player #%1d (7 characters max.):", i);
	prompt (23, temp, pnm[i - 1], 7);
	pnm[i - 1][0] = toupper (pnm[i - 1][0]);
      }}
  if (nhp < 8)
    {clear(23);
      sprintf (temp, "How many computer players (0-%1d or [Q]uit)?", 8 - nhp);
      do
	{
	  colour (12, 0);
	  prompt (23, temp, temp2, 1);
	  if (toupper (temp2[0]) == 'Q')
	    quit (23);
	  np = (int) temp2[0] - 48;
	}
      while (np < 0 || np > (8 - nhp));
      np = nhp + np;
      if (np == 0)
	{ clear(23);
	  colour (15, 0);
	  centre (23, "No players selected!  Exiting...");
	  wait (2);
	  #if(AMI)
	      UEND ();
	  #else
	    cls ();
	  #endif
	  exit (1);
	}
      if ((np - nhp) == 1)
	strcpy (pnm[np - 1], "Hal");
      else
	for (i = nhp + 1; i <= np; i++)
	  strcpy (pnm[i - 1], strangename[i - nhp - 1]);
    }

/*** SET UP SCREEN ***/
  cls ();
  cp = 0;
  for (i = 1; i <= np; i++)
    {
      psc[i - 1] = 0;
      drawbox (i);
    }
  fob = 0;
  pob = 0;
  colour (7, 0);
  display (25, 1, "°±² RUNNING TOTAL  =      ²±°");
  display (25, 51, "°±² TOTAL POSSIBLE =      ²±°");
  drawbutton (1, 5, "[N]ew game", 0);
  drawbutton (2, 6, "keep [R]olling", 0);
  drawbutton (3, 2, "[S]top/take score", 0);
  drawbutton (4, 3, "[Q]uit programme", 0);

NEXTPLAYER:
  if (tt)
    {
      playsleft--;
      if (playsleft == 0)
	{
	  activatebox (hs);
	  clearlines (6, 21);
	  drawbutton (1, 3, pnm[hs - 1], 1);
	  drawbutton (2, 2, "IS", 0);
	  drawbutton (3, 6, "THE", 0);
	  drawbutton (4, 5, "WINNER", 1);
	  clear (25);
	  colour (11, 4);
	  pause ();
	  if (new ())
	    goto NEWGAME;
	  else
	    {
	      #if(AMI)
		  UEND ();
	      #else
		cls ();
	#endif
	      exit (1);
	    }
	}
    }
  cp++;
  if (cp > np)
    cp = 1;
  if (fob != 0 && cp == fob && pob >= 0)
    pob++;
  if (pob == 5)
    {
      pob = -1;
      colour (10, 0);
      centre (21, "Minimum to get on the board is now 500.");
      min = 500;
      wait (3);
    }
  rt = 0;
  activatebox (cp);
  dtr = 5;

ROLLSOMEDICE:
  oldrt = rt;
  if (dtr <= 0)
    dtr = 5;
  roll ();
  olddtr = dtr;
  poss = analyse (0);
  sel = 0;
  for (i = 0; i <= dtr - 1; i++)
    {
      if ((dice[i] == 1) || (dice[i] == 5))
	legal[i] = 1;
      else if ((n[dice[i] - 1] >= 3) && (sel < 3))
	{
	  legal[i] = 1;
	  sel++;
	}
    }
  colour (15, 0);
  sprintf (temp3, "%.4d", poss);
  display (25, 72, temp3);
  if (poss == 2000)
    itsa2000 ();
  else if (poss == 0)
    {
      if (dtr == 5)
	wazoo ();
      else
	zonk ();
      drawbox (cp);
      goto NEXTPLAYER;
    }
  for (i = 1; i <= olddtr; i++)
    putbox (i);
  updatert ();
  clear (21);
  colour (0, 7);
  centre (21, "ÄÄ Select dice to score or re-roll ÄÄ");
  drawbutton (2, 6, "keep [R]olling", 0);
  drawbutton (3, 2, "[S]top/take score", 0);

GETKEY:
  if (cp > nhp)
    {
      if (compdec ())
	j = 35;
      else
	j = 34;
      for (i = 1; i <= olddtr; i++)
	if (sr[i - 1])
	  {
	    putbox (i);
	    dtr--;
	  }
      wait (2);
      #if(AMI)
	  i = checkinput ();
	  if (i == 30 || i == 33)
	    j = i;
      #endif
    }
  else
    j = getinput ();
  if ((j >= 1) && (j <= olddtr))
    {
      if (legal[j - 1])
	{
	  sr[j - 1] = 1 - sr[j - 1];
	  updatert ();
	  putbox (j);
	  dtr = dtr - 2 * sr[j - 1] + 1;
	}
      goto GETKEY;
    }
  else if (j == 33)
    {
      drawbutton (4, 3, "[Q]uit programme", 1);
      quit (21);
      drawbutton (4, 3, "[Q]uit programme", 0);
      goto GETKEY;
    }
  else if (j == 34)
    {
      drawbutton (2, 6, "keep [R]olling", 1);
      if (dtr == olddtr)
	{
	  clear (21);
	  colour (15, 0);
	  centre (21, "You must keep at least one die!");
	  wait (2);
	  drawbutton (2, 6, "keep [R]olling", 0);
	  goto GETKEY;
	}
      goto ROLLSOMEDICE;
    }
  else if (j == 35)
    {
      drawbutton (3, 2, "[S]top/take score", 1);
      if (rt == 0)
	{
	  clear (21);
	  colour (15, 0);
	  centre (21, "Your running total is zero!");
	  wait (2);

	}
      else if ((psc[cp - 1] + rt) < min)
	{
	  colour (15, 0);
	  sprintf (temp, "You need at least %1d to get on the board!", min);
	  centre (21, temp);
	  wait (2);
	}
      else
	{
	  if (fob == 0)
	    fob = cp;
	  psc[cp - 1] = psc[cp - 1] + rt;
	  if (psc[cp - 1] > psc[hs - 1])
	    hs = cp;
	  activatebox (cp);
	  if (psc[cp - 1] >= 10000)
	    {
	      if (!tt)
		{
		  sprintf (temp, "%s is over 10000.  LAST ROUND OF PLAY!", pnm[cp - 1]);
		  tt = 1;
		  hs = cp;
		  playsleft = np;
		  clear (21);
		  colour (15, 0);
		  centre (21, temp);
		}
	    }
	  drawbox (cp);
	  goto NEXTPLAYER;
	}
      drawbutton (3, 2, "[S]top/take score", 0);
    }
  else if (j == 30)
    {
      drawbutton (1, 5, "[N]ew game", 1);
      if (new ())
	goto NEWGAME;
      drawbutton (1, 5, "[N]ew game", 0);
    }
  goto GETKEY;
}

/*** UPDATE RUNNING TOTAL ***/
void
updatert (void)
{
  char temp3[5];
  rt = oldrt + analyse (1);
  colour (15, 0);
  sprintf (temp3, "%.4d", rt);
  display (25, 22, temp3);
}

/*** COMPUTER DECISION (YAWN...) ***/
int
compdec (void)
{
  int i;
  sel = 0;
  for (i = 1; i <= olddtr; i++)
    {
      sr[i - 1] = legal[i - 1];
      if (sr[i - 1])
	sel++;
    }
  updatert ();
  if (psc[cp - 1] >= min)
    {
      if (sel == olddtr)
	{
	  if (ran (5) <= 4)
	    return (0);
	  else
	    return (1);
	}
      else if (rt >= 200)
	{
	  if (rand () / (RAND_MAX + 1.0) <= (float) (rt * 5 / (olddtr - sel) * (psc[hs - 1] - psc[cp - 1] + 1)))
	    return (1);
	  else
	    {
	      throwback ();
	      return (0);
	    }
	}
      else
	{
	  throwback ();
	  return (0);
	}
    }
  else
    {
      if (rt >= min)
	{
	  if (sel == olddtr)
	    {
	      if (ran (5) == 3)
		return (0);
	      else
		return (1);
	    }
	  else
	    return (1);
	}
      else
	{
	  if (sel != olddtr)
	    throwback ();
	  return (0);
	}
    }
}

/*** THROW BACK 50's (COMPUTER DECISION) ***/
void
throwback (void)
{
  int i, j = analyse (1);
  if (j == 50 || n[4] == 3)
    return;
  else
    for (i = 1; i <= olddtr; i++)
      {
	if (dice[i - 1] == 5 && sel > 1)
	  {
	    sr[i - 1] = 0;
	    updatert ();
	    sel--;
	    if ((rt - oldrt) == 500)
	      return;
	  }
      }
}

/*** 2000! (WHOOPEE!) ***/
void
itsa2000 (void)
{
  int i;
  colour (11, 5);
  centre (17, "ÖÄÄÄÄÄ·       ÖÄÄÄÄÄ·       ÖÄÄÄÄÄ·       ÖÄÄÄÄÄ·       Ò Ò Ò ·");
  colour (11, 6);
  centre (18, "ÖÄÄÄÄÄ½       º     º       º     º       º     º       Ğ Ğ Ğ Ğ");
  colour (11, 2);
  centre (19, "ÓÄÄÄÄÄ½       ÓÄÄÄÄÄ½       ÓÄÄÄÄÄ½       ÓÄÄÄÄÄ½       Ğ Ğ Ğ Ğ");
  for (i = 0; i <= 4; i++)
    {
      if (cp <= nhp)
	{
	  sr[i] = 1;
	  legal[i] = 0;
	}
      else
	{
	  sr[i] = 0;
	  legal[i] = 1;
	}
    }
  dtr = 0;
  colour (10, 2);
  wait (3);
  clearlines (17, 19);
}

/*** GRAND WAZOO (BUMMER, MAN) ***/
void
wazoo (void)
{
  colour (15, 0);
  centre (17, "Ö     ·       ÖÄÄÄÄÄ·       ÖÄÄÄÄÄ·       ÖÄÄÄÄÄ·       ÖÄÄÄÄÄ·");
  colour (7, 0);
  centre (18, "º  º  º GRAND ÇÄÄÄÄÄ¶ ÄÄÄÄÄ ÖÄÄÄÄÄ½ ÄÄÄÄÄ º     º ÄÄÄÄÄ º     º");
  colour (8, 0);
  centre (19, "ÓÄÄĞÄÄ½       Ó     ½       ÓÄÄÄÄÄÄ       ÓÄÄÄÄÄ½       ÓÄÄÄÄÄ½");
  colour (9, 1);
  wait (3);
}

/*** ZONK! (Swahili for: "hey ya hoser, ya gots no score, eh.") ***/
void
zonk (void)
{
  int i;
  colour (11, 0);
  display (17, 24, "ÚÄÄÄÄÄ¿ ÚÄÄÄÄÄ¿ ÚÄÄ¿  ¿ Ú     ¿");
  colour (3, 0);
  display (18, 24, "ÚÄÄÄÄÄÙ ³     ³ ³  ³  ³ ÃÄÄÄÂÄÙ");
  colour (1, 0);
  display (19, 24, "ÀÄÄÄÄÄÄÄÀÄÄÄÄÄÙÄÀ  ÀÄÄÙÄÀ   ÀÄÄÄ");
  colour (5, 0);
  for (i = 0; i <= 2; i++)
    {
      display (17 + i, 20, "°±²");
      display (17 + i, 59, "²±°");
    }
  wait (2);
}

/*** ANALYSE DICE TO DETERMINE RUNNING TOTAL OR TOTAL POSSIBLE ***/
int
analyse (int isrt)
{
  int i, j = 0;
  for (i = 0; i <= 5; i++)
    n[i] = 0;
  for (i = 0; i <= olddtr - 1; i++)
    n[dice[i] - 1] = n[dice[i] - 1] + isrt * sr[i] + (1 - isrt);
  for (i = 1; i <= 6; i++)
    {
      if (n[i - 1] == 5)
	return (2000);
      else if (n[i - 1] >= 3)
	{
	  j = j + 100 * i;
	  if (i == 1)
	    j = j + 900;
	}
    }
  j = j + 50 * (n[4] % 3);
  j = j + 100 * (n[0] % 3);
  return (j);
}

/*** DRAW A SPECIFIC MENU BUTTON ***/
void
drawbutton (int num, int col, char text[], int act)
{
  int k = (num - 1) * 20 + 1, i;
  colour (col, 0);
  if (act)
    {
      for (i = 0; i <= 2; i++)
	display (22 + i, k, activebutton[i]);
      colour (col + 8, col);
      display (23, k + 9 - (int) strlen (text) / 2, text);
    }
  else
    {
      for (i = 0; i <= 2; i++)
	display (22 + i, k, button[i]);
      colour (col + 8, 0);
      display (23, k + 9 - (int) strlen (text) / 2, text);
    }
}

/*** DRAW SCORE/REROLL BOXES ***/
void
putbox (int j)
{
  int i, k;
  k = 28 - 7 * olddtr + 14 * j;
  if (sr[j - 1])
    {
      colour (2, 0);
      for (i = 0; i <= 2; i++)
	display (17 + i, k, scorebox[i]);
      colour (11, 2);
      display (18, k + 1, "S C O R E");
    }
  else
    {
      colour (1, 0);
      for (i = 0; i <= 2; i++)
	display (17 + i, k, rollbox[i]);
      colour (9, 0);
      display (18, k + 1, "ROLL OVER");
    }
}

/*** DRAW PLAYER BOX (NORMAL) ***/
void
drawbox (int player)
{
  int left = 32 - 5 * np + player * 10, i;
  if (player > nhp)
    colour (4, 0);
  else
    colour (5, 0);
  display (1, left - 1, "          ");
  for (i = 1; i <= 4; i++)
    {
      display (i + 1, left, pbox[i - 1]);
      display (i + 1, left - 1, " ");
    }
  colour (7, 0);
  displayint (3, left + 4 - (int) ((log10 ((float) (psc[player - 1] + 1)) + 1) / 2), psc[player - 1]);
  display (4, left + 4 - (int) (strlen (pnm[player - 1]) / 2), pnm[player - 1]);
}

/*** DRAW PLAYER BOX (ACTIVATED) ***/
void
activatebox (int player)
{
  int i, left = 31 - 5 * np + player * 10;
  if (player > nhp)
    colour (12, 0);
  else
    colour (13, 0);
  for (i = 1; i <= 4; i++)
    display (i, left, pbox[i - 1]);
  colour (15, 0);
  displayint (2, left + 4 - (int) ((log10 ((float) (psc[player - 1] + 1)) + 1) / 2), psc[player - 1]);
  display (3, left + 4 - (int) (strlen (pnm[player - 1]) / 2), pnm[player - 1]);
}

/*** ROLL DICE ***/
void
roll (void)
{
  int i, k;
  char temp[2];
  clearlines (7, 19);
  for (i = 1; i <= dtr; i++)
    {
      if (strcmp (pnm[0], "óğéîù¹µ") == 0)
	{
	  do
	    {
	      prompt (21, "Enter #:", temp, 1);
	    }
	  while (temp[0] < '1' || temp[0] > '6');
	  dice[i - 1] = (int) temp[0] - 48;
	}
      else
	dice[i - 1] = ran (6);
      sr[i - 1] = 0;
      legal[i - 1] = 0;
      k = 28 - 7 * dtr + 14 * i;
      colour (15, 0);
      display (7, k, die1a);
      colour (7, 0);
      display (8, k, die1b);
      display (9, k, die[dice[i - 1] - 1][0]);
      display (10, k, die2);
      display (11, k, die[dice[i - 1] - 1][1]);
      display (12, k, die2);
      display (13, k, die[dice[i - 1] - 1][2]);
      display (14, k, die3a);
      colour (8, 0);
      display (15, k, die3b);
      colour (6, 0);
      displayint (16, k + 5, i);
    }
}


/*** GENERATE A RANDOM INTEGER BETWEEN 1 AND K ***/
int
ran (int k)
{
  double x = RAND_MAX + 1.0;
  int y;
  y = 1 + rand () * (k / x);
  return (y);
}

/*** INSTRUCTIONS ***/
void
instr (void)
{
  cls ();
  colour (5, 0);
  display (1, 1, "ÚÄÄÄÄÄÄÄÄÄÄ·");
  display (2, 1, "³ THE GAME º");
  display (3, 1, "ÔÍÍÍÍÍÍÍÍÍÍ¼");
  colour (6, 0);
  display (4, 1, "10000 (known as 'Zonk' or 'Zilch' to some) is a game I first learned from my");
  display (5, 1, "grandparents back in the forgotten mists of childhood, but other than that I ");
  display (6, 1, "have no idea from whence it originated.  However, it is a somewhat addictive");
  display (7, 1, "game which I thought deserved some development in the cybernetic realm.  I do");
  display (8, 1, "acknowledge, however, that this idea was not mine originally.  The basic layout");
  display (9, 1, "and operation of this version is horked heavily from my cousin (Brad Randall)");
  display (10, 1, "and his 1986 GWBasic version for the PC, although aside from a few variable");
  display (11, 1, "names my code bears no similarity to his.  This version was written as an");
  display (12, 1, "exercise in cross-platform programming and is unique in that both the IBM and");
  display (13, 1, "Amiga versions share identical code (albeit markedly different include files.)");
  colour (5, 0);
  display (15, 1, "ÚÄÄÄÄÄÄÄÄÄÄÄ·");
  display (16, 1, "³ THE RULES º");
  display (17, 1, "ÔÍÍÍÍÍÍÍÍÍÍÍ¼");
  colour (6, 0);
  display (18, 1, "The rules of play are simple.  Each player starts with 0 (of course) and rolls");
  display (19, 1, "5 dice.  The player holds back at least one scoreable die (this will be");
  display (20, 1, "explained in detail later) and rolls the remaining dice, adding to this running");
  display (21, 1, "total until he/she decides to quit rolling and add the running total to his/her");
  display (22, 1, "score.  If all five dice have been held aside as scoreable (in one or several");
  display (23, 1, "rolls) then all five are rolled again.  Sound easy?  Well, there's a couple of");
  colour (2, 0);
  pause ();
  cls ();
  colour (6, 0);
  display (1, 1, "catches.");
  colour (14, 0);
  display (3, 1, "1) If any roll comes up with zero scoring dice, this is called a 'Zonk' and the");
  display (4, 1, "dice are passed to the next player.  A Zonk which occurs when all five dice are");
  display (5, 1, "rolled is called a 'Grand Wazoo.'  Different name, same result.");

  display (7, 1, "2) Before a player can stop rolling and keep his/her score, he/she must be 'on");
  display (8, 1, "the board.'  The minimum score for being on the board starts at 1000 and");
  display (9, 1, "eventually decreases to 500 after the first person on the board has had 5");
  display (10, 1, "additional turns.  So, before a player can stop and keep his/her running total,");
  display (11, 1, "it must exceed the minimum for being 'on the board.'");
  colour (6, 0);
  display (13, 1, "Once a player's score reaches or exceeds 10000, the other players are given one");
  display (14, 1, "additional turn to try and beat him/her.  At the end of this last round of");
  display (15, 1, "play, the person (or artificially-intelligent computer-generated substitute, as");
  display (16, 1, "the case may be) with the highest score is declared the weiner... uh.. winner.");
  colour (2, 0);
  pause ();
  cls ();
  colour (5, 0);
  display (1, 1, "ÚÄÄÄÄÄÄÄÄÄÄ·");
  display (2, 1, "³ THE DICE º");
  display (3, 1, "ÔÍÍÍÍÍÍÍÍÍÍ¼");
  colour (6, 0);
  display (4, 1, "The following dice (in the combinations listed) are considered 'scoreable.'");
  colour (10, 0);
  display (6, 1, "Combination            Score");
  display (7, 1, "ÄÄÄÄÄÄÄÄÄÄÄ            ÄÄÄÄÄ");
  colour (11, 0);
  display (8, 1, "Each 5                 50");
  display (9, 1, "Each 1                 100");
  display (10, 1, "Three-of-a-kind        100 * value of one die (ie. three 2's = 200)");
  display (11, 1, "Three 1's              1000");
  display (12, 1, "Five-of-a-kind         2000");
  colour (6, 0);
  display (14, 1, "Note: A die cannot be scored more than one way, ie. if you use a 5 as part of");
  display (15, 1, "three-of-a-kind to make 500, you cannot also count it as 50.  Also, for any die");
  display (16, 1, "other than 5 or 1 to be held back as scoreable, it must be held back along with");
  display (17, 1, "either 2 or 4 others like it to make three-of-a-kind or five-of-a-kind.");
  colour (5, 0);
  display (19, 1, "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·");
  display (20, 1, "³ THE STRATEGY º");
  display (21, 1, "ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼");
  colour (6, 0);
  display (22, 1, "Although this is essentially a game of chance, there is the tiniest element of");
  display (23, 1, "strategy involved.  The player can attempt to work the laws of probability");
  colour (2, 0);
  pause ();
  cls ();
  colour (6, 0);
  display (1, 1, "toward his or her favour by carefully deciding which dice to score or re-roll.");
  display (2, 1, "For instance, say I rolled five dice and got");
  colour (11, 0);
  display (4, 1, "   1 - 3 - 2 - 4 - 5");
  colour (6, 0);
  display (6, 1, "Assuming I was on the board, I could keep the 1 and the 5 to add 150 to my");
  display (7, 1, "score, but let's say I was greedy and wanted a bit more.  Instead of keeping");
  display (8, 1, "both the 1 and the 5, a better idea would be to keep just the 1 and roll the");
  display (9, 1, "remaining four dice.  The odds of getting three-of-a-kind or more 1's would");
  display (10, 1, "then be better than if I had kept the 5.  Other finer points of strategy will");
  display (11, 1, "become clear after repeated game play.");
  colour (5, 0);
  display (13, 1, "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·");
  display (14, 1, "³ THE COMPUTER º");
  display (15, 1, "ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼");
  colour (6, 0);
  display (16, 1, "Computerised opponents are ones whose score boxes appear in blue rather than");
  display (17, 1, "purple.  They have been trained to play the game using all of my own personal");
  display (18, 1, "strategies, so playing against them should be equally as difficult as playing");
  display (19, 1, "against a regular opponent.  However, I also programmed a bit of chance into");
  display (20, 1, "their decision-making, so don't set your watch by whether or not the computer");
  display (21, 1, "will make a certain move.  It may surprise you.");
  colour (2, 0);
  pause ();
  cls ();
  colour (5, 0);
  display (1, 1, "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ·");
  display (2, 1, "³ THE ADDRESS º");
  display (3, 1, "ÔÍÍÍÍÍÍÍÍÍÍÍÍÍ¼");
  colour (6, 0);
  display (4, 1, "If you like this game and/or would like to see me develop other cross-platform");
  display (5, 1, "games/applications, drop me a line at");
  colour (15, 0);
  display (7, 1, "          drc@nettap.com or drc76795@tree.egr.uh.edu");
  colour (11, 0);
  display (9, 1, "D.R. Commander");
  display (10, 1, "April 26, 1995");
  colour (2, 0);
  pause ();
  cls ();
  drawpic ();
}

/*** EXIT ROUTINE ***/
void
quit (int line)
{
  clear (line);
  colour (11, 1);
  if (ask (line, "QUIT: Are you absolutely, unequivocally, positively sure"))
    {
      cls ();
      #if (AMI)
	UEND ();
      #endif
      exit (1);
    }
  clear (line);
}

/*** NEW GAME ***/
int
new (void)
{
  colour (11, 5);
  clear(21);
  return (ask (21, "Dost thou want to start a new game"));
}

/*** PAUSE THE EXECUTION FOR A SET # OF SECONDS (NOT SYSTEM-SPECIFIC) ***/
void
wait (int seconds)
{
  time_t time (time_t * storage), begin, end;
  double difftime (time_t end, time_t begin);
  begin = time (NULL);
  do
    end = time (NULL);
  while (difftime (end, begin) < (double) seconds);
}
