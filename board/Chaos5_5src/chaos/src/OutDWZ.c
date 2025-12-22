/*  Chaos:                  The Chess HAppening Organisation System     V5.3
    Copyright (C)   1993    Jochen Wiedmann

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


    $RCSfile: OutDWZ.c,v $
    $Revision: 3.2 $
    $Date: 1994/12/03 18:02:26 $

    This file contains the functions that compute and print the DWZ-ratings.

    Computer:   Amiga 1200                  Compiler:   Dice 2.07.54 (3.0)

    Author:     Jochen Wiedmann
		Am Eisteich 9
	  72555 Metzingen
		Tel. 07123 / 14881
		Internet: jochen.wiedmann@zdv.uni-tuebingen.de
*/


#ifndef CHAOS_H
#include "chaos.h"
#endif

#include <math.h>
#include <time.h>


#ifdef _DCC
extern __far const int PercentToDWZTab[];
#else
#ifdef __SASC
extern const int __far PercentToDWZTab[];
#else
extern const int PercentToDWZTab[];
#endif
#endif
extern const double DWZtoPercentTab[];


struct DWZ
  { struct DWZ *Next;
    struct Player *t;
    short R0;
    short Rn;
    long  Rc;
    double W;
    double We;
    short RH;
    short E;
    short J;
    short n;
  };




/*
    This converts a string into a tm structure. Why isn't this part of the
    Dice library?

    Inputs: strptr  - pointer to the string to be converted
	    tmptr   - pointer to the tm structure where the result will be
		      stored

    Result: TRUE, if the string is valid, FALSE otherwise
	    (Only marginal checks are done)
*/
int atotm(char *strptr, struct tm *tmptr)

{ long mday, month, year;
  int i;
  static short daypermonth[] = {31,29,31,30,31,30,31,31,30,31,30,31};

  if ((i = StrToLong((STRPTR) strptr, &mday)) < 0  ||  strptr[i] == '\0')
  { return(FALSE);
  }
  strptr = strptr+(i+1);
  if ((i = StrToLong((STRPTR) strptr, &month)) < 0  ||  strptr[i] == '\0')
  { return(FALSE);
  }
  strptr = strptr+(i+1);
  if ((i = StrToLong((STRPTR) strptr, &year)) < 0)
  { return(FALSE);
  }
  if (year < 1  ||  month < 1  ||  month > 12  ||
      mday < 1  ||  mday > daypermonth[month-1])
  { return(FALSE);
  }
  if (year<100)
  { year+=1900;
  }
  tmptr->tm_year = year-1900;
  tmptr->tm_mon = month-1;
  tmptr->tm_mday = mday;
  return(TRUE);
}




/*
    The following function compares two dates.

    Inputs: tm1, tm2: pointer to tm structures

    Result: <0 : tm1 < tm2
	    =0 : tm1 = tm2
	    >0 : tm1 > tm2
*/
static int CmpDates(struct tm *tm1, struct tm *tm2)

{
  if (tm1->tm_year != tm2->tm_year)
  { return(tm1->tm_year - tm2->tm_year);
  }
  if (tm1->tm_mon != tm2->tm_mon)
  { return(tm1->tm_mon - tm2->tm_mon);
  }
  return(tm1->tm_mday - tm2->tm_mday);
}




/*
    The following function computes the mean value in points corresponding
    to the value R0 of the player.

    Inputs: mode    - 0 = Simple computation
		      1 = Advanced computation (special ratings and
			  ratings for players without old rating)
*/
static void GetWe(struct DWZ *tDWZ, int mode)

{ struct Game *g;
  short gdwz, DWZDiff;

  /*
      Compute mean value
  */
  tDWZ->n = 0;
  tDWZ->We = tDWZ->W = 0.0;
  tDWZ->Rc = 0;
  for (g = tDWZ->t->First_Game;  g != NULL;  g = g->Next)
  { if (g->Opponent == NULL  ||  (g->Flags & GMFLAGSF_NOFIGHT) != 0  ||
	tdwz(g->Opponent) == 0  ||  g->Result < 0)
    { continue;
    }
    gdwz = tdwz(g->Opponent);
    if (mode == 1  &&
	((struct DWZ *) g->Opponent->Helpptr)->RH > gdwz + 200  &&
	 (tDWZ->R0 == 0  ||  tDWZ->R0 + 200 >= tDWZ->RH))
    { gdwz = ((struct DWZ *) g->Opponent->Helpptr)->RH;
    }
    tDWZ->Rc += gdwz;
    if ((DWZDiff = tDWZ->R0 - gdwz) >= 0)
    { tDWZ->We += (DWZDiff > 735) ? 1.0 : DWZtoPercentTab[DWZDiff];
    }
    else
    { tDWZ->We += (DWZDiff < -735) ? 0.0 : 1.0-DWZtoPercentTab[-DWZDiff];
    }
    tDWZ->W += g->Result/2.0;
    ++tDWZ->n;
  }
}



/*
    The following function computes a players DWZ. See Peter Zoefel,
    Karl-Heinz Glenz; "Das ELO-System", Chapter 10 for the algorithm.

    mode = 0:   Simple computation
    mode = 1:   Advanced computation; see GetWe()

    Result: 0  = User has terminated
	    1  = Don't include player into DWZ-report
	    -1 = O.k.
*/
static int NewDWZ(struct DWZ *tDWZ, int mode)

{ struct Player *t = tDWZ->t;
  struct tm now, birthday;

  tDWZ->R0 = tdwz(t);
  GetWe(tDWZ, mode);

  /*
      Compute DWZ, if possible
  */
  if (tDWZ->n == 0)
  { return(1);
  }


  if (tdwz(t) != 0)
  { /*
	Compute the new DWZ of a player with existing DWZ. (See "Das
	ELO-System, page 88)
    */
    if (mode == 0)
    { /*
	  Get the players age (this is needed for parameter E)
      */
      time_t tmt = clock();
      memcpy(&now, localtime(&tmt), sizeof(now));

Loop: if (!atotm(t->BirthDay, &birthday))
      { switch(AskForBirthday(t))
	{ case 1:
	    tDWZ->J = 5;
	    break;
	  case 2:
	    tDWZ->J = 10;
	    break;
	  case 3:
	    tDWZ->J = 15;
	    break;
	  case 4:
	    if (!ModifyOnePlayer(t, TRUE))
	    { return(0);
	    }
	    goto Loop;
	  case 5:
	    return(1);
	  case 0:
	    return(0);
	}
      }
      else
      { birthday.tm_year += 21;
	if (CmpDates(&birthday, &now) > 0)
	{ tDWZ->J = 5;
	}
	else
	{ birthday.tm_year += 5;
	  tDWZ->J = (CmpDates(&birthday, &now) > 0) ? 10 : 15;
	}
      }
    }
    tDWZ->R0 = tdwz(t);
    { double E = tDWZ->R0/1000.0;
      tDWZ->E = floor(0.5+E*E*E*E+tDWZ->J);
    }
    tDWZ->RH = floor(0.5+(800.0*(tDWZ->W-tDWZ->We))/tDWZ->n+tDWZ->R0);

    tDWZ->Rn = floor(0.5+(double) (tDWZ->E*tDWZ->R0 + tDWZ->n*tDWZ->RH) /
			 (double) (tDWZ->E+tDWZ->n));
  }
  else
  { /*
	Compute new DWZ for a player who wasn't rated yet.
	See "Das ELO-System", page 93)
    */
    int RH;
    struct DWZ tDWZ1, tDWZ2;
    int p;
    double d;

    /*
	We cannot compute a DWZ, if the player has 0% or 100%
    */
    if (tDWZ->W == 0.0  ||  tDWZ->W == (double) tDWZ->n)
    { tDWZ->Rn = 0;
      return(-1);
    }
    p = floor(tDWZ->W/tDWZ->n*1000+0.5);
    d = PercentToDWZTab[999-p];
    tDWZ->R0 = floor(0.5+((double)tDWZ->Rc)/((double)tDWZ->n)+d);

    /*
	Iterate until RH = tDWZ->RH. This is somewhat complicated
	because we need to suppress endless loops.
    */
    tDWZ1 = *tDWZ;
    tDWZ2 = *tDWZ;
    do
    { RH = tDWZ1.RH;
      GetWe(&tDWZ1, mode);
      tDWZ1.R0 = tDWZ1.RH =
		       floor(0.5+tDWZ1.R0+(800*(tDWZ1.W-tDWZ1.We))/tDWZ1.n);
      GetWe(&tDWZ1, mode);
      tDWZ1.R0 = tDWZ1.RH =
		       floor(0.5+tDWZ1.R0+(800*(tDWZ1.W-tDWZ1.We))/tDWZ1.n);
      GetWe(&tDWZ2, mode);
      tDWZ2.R0 = tDWZ2.RH =
		       floor(0.5+tDWZ2.R0+(800*(tDWZ2.W-tDWZ2.We))/tDWZ2.n);
    }
    while (tDWZ1.RH != RH  &&  tDWZ1.RH != tDWZ2.RH);
    *tDWZ = tDWZ1;
    tDWZ->Rn = tDWZ->RH;
  }
  return(-1);
}




/*
    Finally here comes the output function.

    Inputs: filename - destination file; see InitOutput()
	    device   - output device; see InitOutput()
*/
void OutDWZReport(char *filename, int device)

{ struct Player *t;
  void *DWZMem = NULL;
  struct DWZ *FirstDWZ = NULL, *tDWZ, **DWZptr = &FirstDWZ;
  long l;
  short dwz, i;
  char prthead[162];
  char scrhead[81];
  char line1[81], line2[81];
  char dwzold[20], dwznew[20], dwzhelp[20];
  char We[15];

  sprintf(scrhead, "%-30s %-11s %-4s %-3s %-7s %-5s %-11s",
		   MSG_NAME_OUTPUT,
		   " Ro", " W", "  n", "  We", " RH", " Rn");
  sprintf(prthead, "%-30s %-11s %-4s %-3s %-7s %-5s %-11s\n     (%s)",
		   MSG_NAME_OUTPUT, " Ro", " W", "  n",
		   "  We", " RH", " Rn", MSG_BIRTHDAY_OUTPUT);
  if (!InitOutput((char *) MSG_DWZ_TITLE, prthead, scrhead,
		  filename, "#?.dwz", device, 2, 1))
  { goto Terminate;
  }

  /*
      Create list of players for which the DWZ can be computed and do
      the simple computation.
  */
  for (t = (struct Player *) PlayerList.lh_Head;
       t->Tn_Node.ln_Succ != NULL;
       t = (struct Player *) t->Tn_Node.ln_Succ)
  { /*
	Get RAM for player
    */
    if ((tDWZ = GetMem(&DWZMem, sizeof(*tDWZ)))  ==  NULL)
    { goto Terminate;
    }

    tDWZ->t = t;
    t->Helpptr = (struct Player *) tDWZ;
    switch (NewDWZ(tDWZ, 0))
    { case 0:
	goto Terminate;
      case 1:
	continue;
    }
    *DWZptr = tDWZ;
    DWZptr = &(tDWZ->Next);
  }

  /*
      Special algorithms for players whose RH-number is greater than
      their old rating + 200 points.
  */
  for (tDWZ = FirstDWZ;  tDWZ != NULL;  tDWZ = tDWZ->Next)
  { if (NewDWZ(tDWZ, 1) == 0)
    { goto Terminate;
    }
  }

  for (tDWZ = FirstDWZ; tDWZ != NULL;  tDWZ = tDWZ->Next)
  { if ((dwz = tdwz(tDWZ->t)) == 0)
    { sprintf(dwzold, "%11s", "");
      sprintf(dwzhelp, "(%d)", tDWZ->n);
      if (tDWZ->Rn != 0)
      { sprintf(dwznew, "%5d-%-5s", tDWZ->Rn,
			(tDWZ->n > 4) ? "1" : dwzhelp);
      }
      else
      { sprintf(dwznew, "     -%-5s", dwzhelp);
      }
      sprintf(We, "       ");
    }
    else
    { i = StrToLong((STRPTR) tDWZ->t->DWZ, &l);
      if (tDWZ->t->DWZ[i] == '\0'  ||
	  StrToLong((STRPTR) tDWZ->t->DWZ+(i+1), &l) < 0)
      { sprintf(dwzold, "%5d      ", dwz);
	sprintf(dwznew, "%5d      ", tDWZ->Rn);
      }
      else
      { sprintf(dwzold, "%5d-%-5ld", dwz, l);
	sprintf(dwznew, "%5d-%-5ld", tDWZ->Rn, l+1);
      }
      sprintf(We, "%7.3lf", tDWZ->We);
    }

    sprintf(line1, "%-30s %11s %4.1lf %3d %s %5d %11s",
		tDWZ->t->Name, dwzold, tDWZ->W, tDWZ->n, We, tDWZ->RH,
		dwznew);
    sprintf(line2, (*tDWZ->t->BirthDay != '\0')  ?  "     (%s)"  :  "",
	    tDWZ->t->BirthDay);
    if (!lprint(line1)  ||
	(device != DEVICE_Screen  &&  !lprint(line2)))
    { goto Terminate;
    }
  }

  ProcessOutput();

Terminate:
  TerminateOutput();
  PutMemList(&DWZMem);
}
