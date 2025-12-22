/* The routines listed below are designed for use on an MS-DOS IBM with
   ANSI.SYS installed or an Amiga BBS programme which allows AmigaDOS doors.

   This header file is (C)1995 D.R. Commander and Titane-Mammoth Productions */
/*
#include <conio.h>
*/
/*** FETCH A KEYPRESS ***/
int 
getinput (void)
{
  char ans;
  ans = getch ();
  return ((int) toupper (ans) - 48);
}

/*** CLEAR SCREEN ***/
void 
cls (void)
{
  printf ("\033[2J\033[1;1f");
}

/*** CLEAR ONE LINE OF THE DISPLAY ***/
void 
clear (int line)
{
  printf ("\033[0m\033[%dH\033[K", line);
}

/*** PROMPTS THE USER FOR INPUT ON ROW n (DISPLAYS INPUT BOX) ***/
void 
prompt (int line, char prompt[], char response[], int length)
{
  int i = 0;
  char ans = '\0';
  printf ("\033[%1d;%1dH%s\033[0;37m Ý\033[%1dCÞ\033[%1dD\033[1m",
	  line, 40 - (int) (strlen (prompt) + length + 2) / 2, prompt, length, length + 1);
  do
    {
      ans = getch ();
      if (ans == '\b')
	{
	  if (i != 0)
	    {
	      i--;
	      response[i] = '\0';
	      printf ("\b \b");
	    }
	}
      else if ((i <= (length - 1)) && (isprint (ans) != 0))
	{
	  printf ("%c", ans);
	  response[i] = ans;
	  i++;
	}
    }
  while ((ans != (char) 13) && (ans != '\n'));
  response[i] = '\0';
  clear (line);
}

/*** CHANGE THE CURRENT TEXT COLOUR ***/
void 
colour (int fg, int bg)
{
  if (fg % 16 < 8)
    printf ("\033[0;3%1d;4%1dm", fg % 16, bg % 8);
  else
    printf ("\033[1;3%1d;4%1dm", fg % 8, bg % 8);
}

/*** DISPLAY A LINE OF TEXT AT A SET CURSOR POSITION ***/
void 
display (int vpos, int hpos, char input[])
{
  printf ("\033[%1d;%1dH%s", vpos, hpos, input);
}

/*** DISPLAY AN INTEGER AT A SET CURSOR POSITION ***/
void 
displayint (int vpos, int hpos, int input)
{
  printf ("\033[%1d;%1dH%1d", vpos, hpos, input);
}

/*** CENTRE A STRING ON A SPECIFIED LINE (NOT SYSTEM-SPECIFIC) ***/
void 
centre (int vpos, char input[])
{
  display (vpos, (int) (40 - strlen (input) / 2), input);
}

/*** PAUSE FOR A KEY PRESS ***/
void 
pause (void)
{
  centre (25, "°±² BANG ANY KEY TO CONTINUE ²±°");
  getch ();
  clear (25);
}

/*** CLEAR LINES m THROUGH n ***/
void 
clearlines (int m, int n)
{
  int x;
  for (x = m; x <= n; x++)
    clear (x);
}

/*** ASK A YES/NO QUESTION AND RETURN TRUE OR FALSE BASED ON THE ANSWER ***/
int 
ask (int line, char question[])
{
  char ans;
  printf ("\033[%1d;%1dH%s (y/N)?", line, (int) (40 - (strlen (question) + 8) / 2), question);
  ans = getch ();
  ans = toupper (ans);
  switch (ans)
    {
    case 'Y':
      {
	printf ("\033[0;1;37m Maybe so");
	return (1);
      }
    default:
      {
	printf ("\033[0;1;37m Guess not");
	return (0);
      }
    }
}

/*** DRAW THE BOFFO INTRO PIC ***/
void 
drawpic (void)
{
  cls ();
  puts ("\033[2H \033[1;37mÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ");
  puts (" \033[0;30;47m10000 10000 10000 10000 10000 10000 10000 10000 10000 10000 10000 10000 10000 \033[0m");
  puts (" \033[37mÛ\033[31mÖÄÄÄÒÄÄÄ·\033[15C\033[1;32mÖÄÄÄÒÄÄÄ·\033[43C\033[47m \033[0m");
  puts (" \033[30;47m1\033[31;40mº   º   º\033[15C\033[1;32mº   º   º \033[0;32mÖÄ   \033[37mThe semi-classic game of chance   \033[1;32mÄ· \033[0;30;47m1\033[0m");
  puts (" \033[30;47m0\033[31;40m    º\033[5C\033[33mÖÄÄÄ· \033[1mÖÄÄÄ·\033[7C\033[32mº\033[5C\033[0;32mÇÄÄÄ· \033[36mÖÄÄÄ· \033[35mÖÄ  ÖÄ\033[31mÖÄÄÄ· \033[33mÖÄÄÄ· \033[1mÖÄÄÄ· \033[32mÖÄÄÄ¶ \033[0;30;47m0\033[0m");
  puts (" \033[30;47m0\033[1;34;40m°±²±\033[0;31mº\033[1;34m±²±°±\033[0;33mº\033[1;34m±°±\033[0;33mº\033[1;34m±\033[33mº\033[34m±²±\033[33mº\033[34m±²±°±²±\033[32mº\033[34m±²±°±\033[0;32mº\033[1;34m±°±\033[0;32mº\033[1;34m±\033[0;36mº\033[1;34m±²±\033[0;36mº\033[1;34m±\033[0;35mº\033[1;34m±°±\033[0;35mº\033[1;34m±\033[0;31mº\033[1;34m±²±°±²±°±\033[0;33mº\033[1;34m±\033[33mº\033[34m±²±\033[33mº\033[34m±\033[32mº\033[34m±°±\033[32mº\033[34m±\033[0;30;47m0\033[0m");
  puts (" \033[30;47m0\033[1;34;40m°±²±\033[0;31mº\033[1;34m±²±°±\033[0;33mÇÄÄÄ½\033[1;34m±\033[33mº\033[34m±²±\033[33mº\033[34m±²±°±²±\033[32mº\033[34m±²±°±\033[0;32mº\033[1;34m±°±\033[0;32mº\033[1;34m±\033[0;36mº\033[1;34m±²±\033[0;36mº\033[1;34m±\033[0;35mº\033[1;34m±°±\033[0;35mº\033[1;34m±\033[0;31mÓÄÄÄ·\033[1;34m±\033[0;33mÖÄÄÄ¶\033[1;34m±\033[33mº\033[34m±²±\033[33mº\033[34m±\033[32mº\033[34m±°±\033[32mº\033[34m±\033[0;30;47m0\033[0m");
  puts (" \033[30;47m0\033[1;34;40m°±²±\033[0;31mº\033[1;34m±²±°±\033[0;33mº\033[1;34m±°±²±\033[33mº\033[34m±²±\033[33mº\033[34m±²±°±²±\033[32mº\033[34m±²±°±\033[0;32mº\033[1;34m±°±\033[0;32mº\033[1;34m±\033[0;36mº\033[1;34m±²±\033[0;36mº\033[1;34m±\033[0;35mº\033[1;34m±°±\033[0;35mº\033[1;34m±°±²±\033[0;31mº\033[1;34m±\033[0;33mº\033[1;34m±°±\033[0;33mº\033[1;34m±\033[33mº\033[34m±²±\033[33mº\033[34m±\033[32mº\033[34m±°±\033[32mº\033[34m±\033[0;30;47m0\033[0m");
  puts (" \033[37mÛ   \033[31mÄÐÄ    \033[33mÓÄÄÄÄÄ\033[1mÓÄ  ÓÄ\033[5C\033[32mÄÐÄ    \033[0;32mÓÄ  ÓÄ\033[36mÓÄÄÄÐÄ\033[35mÓÄÄÄÐÄ\033[31mÓÄÄÄÐÄ\033[33mÓÄÄÄÐÄ\033[1mÓÄ  ÓÄ\033[32mÓÄÄÄÐÄ\033[47m \033[0m");
  puts (" \033[1;32;47m \033[0;30;47m10000 10000 10000 10000 10000 10000 10000 10000 10000 10000 10000 10000 10000\033[0m");
  puts (" \033[1;30mßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß");
  puts ("\033[15C\033[0;35mÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ");
  puts ("\033[23C\033[36mOriginal programme by B.N. Randall");
  puts ("\033[20CCopyright (C)1986 Champion Wolf Software");
  puts ("\033[15C\033[32mÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ");
  puts ("\033[15C\033[1mAmiga and MS-DOS ANSI C versions by D.R. Commander");
  puts ("\033[23C\033[0;37m(E-Mail: \033[1mdrc76795@tree.egr.uh.edu\033[0;37m)");
  puts ("\033[23C\033[1;33m(C)1995 Titane-Mammoth Productions");
  puts ("\033[21C\033[0;33mGWIN system (C)1991 Howard C. Anderson");
  puts ("\033[15C\033[31mÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ\033[0m");
}

void
setupamigascreen (void)
{}

void
UEND (void)
{}

int
checkinput (void)
{return(0);}

#define G 0
#define MIDRAWN 0
#define MENUENABLED 0
#define ITEMTEXT 0
#define HIGHBOX 0
#define ITEMENABLED 0
#define COMMSEQ 0
