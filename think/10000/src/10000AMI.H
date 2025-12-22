/* The routines listed below are specific to an Amiga using the GWIN.library.
   See dox for further details.

   This header file is (C)1995 D.R. Commander and Titane-Mammoth Productions */

#include "gwin.user.h"

/*** CHECKS TO SEE IF A KEY IS WAITING IN THE INPUT STREAM (FOR ABORTING
     COMPUTER-PLAYED GAMES ***/
int 
checkinput (void)
{
  float x, y;
  struct uuevent uuev;
  ugrina (G, &x, &y, &uuev);
  return ((int) (toupper (uuev.key)) - 48);
}

/*** FETCH A MOUSE CLICK OR KEYPRESS ***/
int 
getinput (void)
{
  float x, y;
  struct uuevent uuev;
  ugrinc (G, &x, &y, &uuev);
  return ((int) (toupper (uuev.key)) - 48);
}

/*** CLEAR SCREEN ***/
void 
cls (void)
{
  upset (G, "ccol", 0.0);
  uerase (G);
}

/*** PROMPTS THE USER FOR INPUT ON ROW n (DISPLAYS REQUESTER) ***/
void 
prompt (int line, char prompt[], char response[], int length)
{
  float width = ((float) strlen (prompt) + 2.) * 1.25;
  char text[255];
  if (line % 26 > 21)
    line = 21;
  ugetstring (G, 50. - width / 2., 96.0 - (float) (line % 26 - 1) * 4.0, width, prompt, text);
  strncpy (response, text, length);
  response[length] = '\0';
}

/*** CHANGE THE CURRENT TEXT COLOUR ***/
void 
colour (int fg, int bg)
{
  upset (G, "colo", (float) fg);
  upset (G, "bcol", (float) bg);
}

/*** DISPLAY A LINE OF TEXT AT A SET CURSOR POSITION ***/
void 
display (int vpos, int hpos, char input[])
{
  float x = (float) ((hpos - 1) % 80) * 1.25 + .1, y = 96.0 - (float) ((vpos - 1) % 25) * 4.0;
  umove (G, x, y);
  uprnt1 (G, "text", input);
}

/*** DISPLAY AN INTEGER AT A SET CURSOR POSITION ***/
void 
displayint (int vpos, int hpos, int input)
{
  char temp[80];
  int len;
  float x = (float) ((hpos - 1) % 80) * 1.25 + .1, y = 96.0 - (float) ((vpos - 1) % 25) * 4.0;
  len = stci_d (temp, input);
  temp[len] = '\0';
  umove (G, x, y);
  uprnt1 (G, "text", temp);
}

/*** PAUSE FOR A MOUSE CLICK ***/
void 
pause (void)
{
  float x, y;
  void centre (int line, char text[]);
  void clear (int line);
  centre (25, "°±² BANG THE LEFT MOUSE BUTTON TO CONTINUE ²±°");
  ugrin (G, &x, &y);
  clear (25);
}

/*** CLEAR ONE LINE OF THE DISPLAY ***/
void 
clear (int line)
{
  colour (0, 0);
  display (line, 1, "                                                                                ");
}

/*** CLEAR LINES m THROUGH n ***/
void 
clearlines (int m, int n)
{
  int i;
  colour (0, 0);
  for (i = m; i <= n; i++)
    {
      display (i, 1, "                                                                                ");
    }
}

/*** POP A YES/NO REQUESTER AND RETURN TRUE OR FALSE BASED ON THE ANSWER ***/
int 
ask (int line, char question[])
{
  float width = ((float) strlen (question) + 4.) * 1.25;
  return (uyorn (G, question, "Maybe so", "Guess not", width, 50.));
}

/*** SET UP A 640x200x16 SCREEN WITH THE PROPER IBM PALETTE AND FONT ***/
void 
setupamigascreen (void)
{
  USTART ("high1.backdrop", 0., 640., 0., 200.);
  usetrgb (G, 0., 0., 0., 0.);
  usetrgb (G, 1., 10., 0., 0.);
  usetrgb (G, 2., 0., 10., 0.);
  usetrgb (G, 3., 10., 6., 0.);
  usetrgb (G, 4., 0., 0., 10.);
  usetrgb (G, 5., 10., 0., 10.);
  usetrgb (G, 6., 0., 10., 10.);
  usetrgb (G, 7., 11., 11., 11.);
  usetrgb (G, 8., 6., 6., 6.);
  usetrgb (G, 9., 15., 0., 0.);
  usetrgb (G, 10., 0., 15., 0.);
  usetrgb (G, 11., 15., 15., 0.);
  usetrgb (G, 12., 0., 0., 15.);
  usetrgb (G, 13., 15., 0., 15.);
  usetrgb (G, 14., 0., 15., 15.);
  usetrgb (G, 15., 15., 15., 15.);
  ufont (G, "CleanIBM.font", 8.);
}

/*** DRAW THE EVEN MORE BOFFO INTRO PIC ***/
void 
drawpic (void)
{
  uset (G, "fill");
  upset (G, "colo", 7.);
  urect (G, .625978, 98.994974, 99.374026, 55.276383);
  upset (G, "colo", 15.);
  urect (G, 0., 100., 100., 99.497492);
  urect (G, 0., 98.994974, .469484, 54.271360);
  upset (G, "colo", 8.);
  urect (G, .625978, 54.773870, 100., 54.271360);
  urect (G, 99.530520, 100., 100., 55.276383);
  upset (G, "colo", 5.);
  urect (G, 1.564945, 86.432162, 17.370892, 65.326632);
  upset (G, "colo", 6.);
  urect (G, 21.283255, 86.432162, 37.089204, 65.326632);
  upset (G, "colo", 2.);
  urect (G, 41.001565, 86.432162, 56.807511, 65.326632);
  upset (G, "colo", 3.);
  urect (G, 60.719876, 86.432162, 76.525820, 65.326632);
  upset (G, "colo", 1.);
  urect (G, 80.438189, 86.432162, 96.244135, 65.326632);
  upset (G, "colo", 13.);
  urect (G, 4.068858, 89.447237, 19.561816, 68.844225);
  upset (G, "colo", 14.);
  urect (G, 23.787167, 89.447237, 39.280126, 68.844225);
  upset (G, "colo", 10.);
  urect (G, 43.505479, 89.447237, 58.998437, 68.844225);
  upset (G, "colo", 11.);
  urect (G, 63.223786, 89.447237, 78.716746, 68.844225);
  upset (G, "colo", 9.);
  urect (G, 82.942103, 89.447237, 98.435053, 68.844225);
  upset (G, "colo", 0.);
  urect (G, 7.981221, 87.939699, 13.302035, 86.934679);
  urect (G, 10.328638, 86.432162, 13.302035, 71.859301);
  urect (G, 7.981221, 71.356783, 15.649452, 70.351763);
  urect (G, 25.821597, 87.939699, 37.245698, 70.351763);
  urect (G, 45.383412, 87.939699, 56.964006, 70.351763);
  urect (G, 65.258219, 87.939699, 76.682322, 70.351763);
  urect (G, 84.976526, 87.939699, 96.400629, 70.351763);
  upset (G, "colo", 14.);
  urect (G, 28.951487, 86.432162, 34.115808, 71.859301);
  upset (G, "colo", 10.);
  urect (G, 48.669797, 86.432162, 53.834115, 71.859301);
  upset (G, "colo", 11.);
  urect (G, 68.388109, 86.432162, 73.552431, 71.859301);
  upset (G, "colo", 9.);
  urect (G, 88.106417, 86.432162, 93.270739, 71.859301);
  upset (G, "colo", 0.);
  upset (G, "bcol", 7.);
  centre (2, "°±² T E N   T H O U S A N D ²±°");
  centre (11, "The semi-classic game of chance");
  upset (G, "colo", 5.);
  upset (G, "bcol", 0.);
  centre (13, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ");
  upset (G, "colo", 6.);
  centre (14, "Original programme by B.N. Randall");
  centre (15, "Copyright (C)1986 Champion Wolf Software");
  upset (G, "colo", 2.);
  centre (16, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ");
  upset (G, "colo", 10.);
  centre (17, "Amiga and MS-DOS ANSI C versions by D.R. Commander");
  upset (G, "colo", 7.);
  display (18, 24, "(E-Mail: ");
  upset (G, "colo", 15.);
  uprnt1 (G, "text", "drc76795@tree.egr.uh.edu");
  upset (G, "colo", 7.);
  uprnt1 (G, "text", ")");
  upset (G, "colo", 11.);
  centre (19, "(C)1995 Titane-Mammoth Productions");
  upset (G, "colo", 3.);
  centre (20, "GWIN system (C)1991 Howard C. Anderson");
  upset (G, "colo", 1.);
  centre (21, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ");
}

/*** CENTRE A STRING ON A SPECIFIED LINE ***/
void 
centre (int vpos, char input[])
{
  float x = 50. - (float) strlen (input) * 0.625, y = 96.0 - (float) ((vpos - 1) % 25) * 4.0;
  umove (G, x, y);
  uprnt1 (G, "text", input);
}
