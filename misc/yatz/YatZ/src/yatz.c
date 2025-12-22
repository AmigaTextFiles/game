/*
  Auto: cc   -3 <path><file> +l
  Auto: ln  <path><file>.o -lc +lcdb <path>sound.o -lc16
 */
#include <exec/types.h>
#include <intuition/intuition.h>
#include <libraries/dos.h>
#define DICE 0x30
#define CLOSED 1
#define ROLL 0x40
#define SCORE 3
#define THREEOFAKIND 9
#define FOUROFAKIND 10
#define FULLHOUSE 11
#define SMSTRAIGHT 12
#define LGSTRAIGHT 13
#define YATZ 14
#define CHANCE 15
#define SOME 20
#define NONE 21
#define BONUS 19
#define TOTALLEFT 18
#define INTUITION_REV 33
#define GRAPHICS_REV 33
#define YOFFSET 6
#define DIEMULT 27
#include <dh2:aztec52/progs/yatz/src/yatz.h>        /* make sure this path is */
                                              /* set right!             */
struct IntuitionBase *IntuitionBase = NULL;
struct GfxBase *GfxBase = NULL;
struct Window  *window1 = NULL;
struct RastPort *rp;
char            diepic[6][3][3] =
{"   ",
 " o ",
 "   ",

 "o  ",
 "   ",
 "  o",

 "o  ",
 " o ",
 "  o",

 "o o",
 "   ",
 "o o",

 "o o",
 " o ",
 "o o",

 "o o",
 "o o",
 "o o"};
LONG            seed;
USHORT          FINISHFLAG = 0;
int             GadFlag = 0;
char            grandstr[20];
int             diceroll[6];
int             highscore;
USHORT          leaveprog = FALSE;
int             rollcount = 0;
USHORT          havesound = TRUE;
int             scores[20] =
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
short           scoretable[15] =
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
int             dicegad[6] =
{0, 0, 0, 0, 0, 0};
struct TextAttr myAttr =
{(UBYTE *) "topaz.font", 8, 0, 0};
struct TextFont *tf;

VOID 
cleanExit(returnValue)
    int             returnValue;
{
    if (havesound)
     cleanup();
    if (window1)
	CloseWindow(window1);
    if (tf)
     CloseFont (tf);
    if (GfxBase)
	CloseLibrary((struct Library *) GfxBase);
    if (IntuitionBase)
	CloseLibrary((struct Library *) IntuitionBase);
    exit(returnValue);
}


VOID 
OpenAll(VOID)
{
    int             hs;
    struct RastPort *rp;
    IntuitionBase = (struct IntuitionBase *)
	OpenLibrary("intuition.library", INTUITION_REV);
    if (IntuitionBase == NULL)
	cleanExit(RETURN_WARN);
    GfxBase = (struct GfxBase *)
	OpenLibrary("graphics.library", GRAPHICS_REV);
    if (GfxBase == NULL)
	cleanExit(RETURN_WARN);

    window1 = (struct Window *) OpenWindow(&NewWindowStructure1);
    if (window1 == NULL)
	cleanExit(RETURN_WARN);
    if ((hs = fopen("yatz.hs", "r")) != NULL) {
	fscanf(hs, "%d", &highscore);
	fclose(hs);
    } else {
	if ((hs = fopen("yatz.hs", "w")) != NULL) {
	    highscore = 0;
	    fprintf(hs, "%d", highscore);
	    fclose(hs);
	}
    }
    if (loadSound("diceroll") == 20)
            havesound = FALSE; 
    rp = window1->RPort;
    tf = (struct TextFont *)OpenFont (&myAttr);
    if (tf == NULL) cleanExit (RETURN_WARN);
    SetFont(rp, tf);
}

VOID 
ShowHighScore()
{
    Move(rp, 352, 145+YOFFSET);
    SetDrMd(rp, JAM2);
    if (highscore < 10)
	sprintf(grandstr, "  %d", highscore);
    else if (highscore < 100)
	sprintf(grandstr, " %d", highscore);
    else
	sprintf(grandstr, "%d", highscore);
    Text(rp, grandstr, 3);
}

VOID 
RollAllDice()
{
    int             counter;
    for (counter = 1; counter < 6; counter++)
	diceroll[counter] = RollDie(counter);
    if (havesound == TRUE)
        soundSound();
}


int 
RollDie(diepos)
    USHORT          diepos;
{
    int             die;
    die = rand();
    die = die / 5462;
    die++;
    SetDrMd(rp, JAM2);
    Move(rp, 22, (DIEMULT * diepos) - 2 + YOFFSET);
    Text(rp, &diepic[die - 1][0], 3);
    Move(rp, 22, (DIEMULT * diepos) + 5 + YOFFSET);
    Text(rp, &diepic[die - 1][1], 3);
    Move(rp, 22, (DIEMULT * diepos) + 12 + YOFFSET);
    Text(rp, &diepic[die - 1][2], 3);

    return die;
}

VOID 
UnGhostDice()
{
    RemoveGList(window1, &Gadget8, 5);
    Gadget8.Flags = Gadget8.Flags & ~GADGDISABLED;
    Gadget9.Flags = Gadget9.Flags & ~GADGDISABLED;
    Gadget10.Flags = Gadget10.Flags & ~GADGDISABLED;
    Gadget11.Flags = Gadget11.Flags & ~GADGDISABLED;
    Gadget12.Flags = Gadget12.Flags & ~GADGDISABLED;
    AddGList (window1, &Gadget8, 0, 5, NULL);
    SetDrMd(rp, JAM2 | INVERSVID);
    RectFill(rp, 15, 15 + YOFFSET, 54, 150 + YOFFSET);
    RefreshGList(&Gadget8, window1, NULL, 5);
}

VOID 
GhostDice()
{
    RemoveGList(window1, &Gadget8, 5);
    Gadget8.Flags = Gadget8.Flags | GADGDISABLED;
    Gadget9.Flags = Gadget9.Flags | GADGDISABLED;
    Gadget10.Flags = Gadget10.Flags | GADGDISABLED;
    Gadget11.Flags = Gadget11.Flags | GADGDISABLED;
    Gadget12.Flags = Gadget12.Flags | GADGDISABLED;
    AddGList (window1, &Gadget8, 0, 5, NULL);
    RefreshGList(&Gadget8, window1, NULL, 5);
}

SHORT 
RollSelected()
{
    int             counter;
    int             status = NONE;
    for (counter = 1; counter < 6; counter++)
	if (dicegad[counter] == 1) {
	    dicegad[counter] = 0;
	    switch (counter) {
	    case 1:
		RefreshGList(&Gadget8, window1, NULL, 1);
		Gadget8.Flags = NULL;
		status = SOME;
		break;
	    case 2:
		RefreshGList(&Gadget9, window1, NULL, 1);
		Gadget9.Flags = NULL;
		status = SOME;
		break;
	    case 3:
		RefreshGList(&Gadget10, window1, NULL, 1);
		Gadget10.Flags = NULL;
		status = SOME;
		break;
	    case 4:
		RefreshGList(&Gadget11, window1, NULL, 1);
		Gadget11.Flags = NULL;
		status = SOME;
		break;
	    case 5:
		RefreshGList(&Gadget12, window1, NULL, 1);
		Gadget12.Flags = NULL;
		status = SOME;
		break;
	    }
	    diceroll[counter] = RollDie(counter);
	}
    if ((rollcount == 1) && (status == SOME))
         GhostDice();
    if ( (status == SOME) && (havesound == TRUE) )
	soundSound();
    return status;

}

USHORT 
handleIDCMP(struct Window * win)
{
    int             flag = 0;
    struct IntuiMessage *message = NULL;
    int             code;
    USHORT          id;
    int             dicenum;
    ULONG           class;
    struct Gadget  *g;
    while (message = (struct IntuiMessage *) GetMsg(win->UserPort)) {
	class = message->Class;
	code = message->Code;
	g = (struct Gadget *) (message->IAddress);
	ReplyMsg((struct Message *) message);
	switch (class) {
	case CLOSEWINDOW:
	    flag = CLOSED;
	    break;
	case GADGETDOWN:
	    id = g->GadgetID;
	    dicenum = id - DICE;
	    dicenum++;
	    if ((dicegad[dicenum]) == 1)
		dicegad[dicenum] = 0;
	    else
		dicegad[dicenum] = 1;
	    break;
	case GADGETUP:
	    flag = g->GadgetID;
	    break;
	}
    }
    return (flag);
}

VOID 
DoDigits()
{
    int             digit, counter;
    char            temp[20];
    digit = GadFlag - 2;
    scores[digit] = 0;
    for (counter = 1; counter < 6; counter++)
	if (diceroll[counter] == digit)
	    scores[digit]++;
    scores[digit] = scores[digit] * digit;
    Move(rp, 198, 11 + (14 * digit) + YOFFSET);
    if (scores[digit] < 10)
	sprintf(temp, " %d", scores[digit]);
    else
	sprintf(temp, "%d", scores[digit]);
    Text(rp, temp, 2);
}

USHORT 
NumLeftBlanks()
{
    USHORT          counter, blanks = 6;
    for (counter = 0; counter < 7; counter++)
	if (scoretable[counter] == 1)
	    blanks--;
    return blanks;
}

USHORT 
NumRightBlanks()
{
    USHORT          counter, blanks = 7;
    for (counter = 7; counter < 16; counter++)
	if (scoretable[counter] == 1)
	    blanks--;
    return blanks;
}

int 
DoBonus()
{
    int             total = 0;
    USHORT          counter;
    for (counter = 0; counter < 7; counter++)
	total = total + scores[counter];
    return total;
}

VOID 
DoGrand()
{
    int             hs;
    USHORT          counter, totals = 0;
    if ((NumLeftBlanks() == 0) && NumRightBlanks() == 0) {
	FINISHFLAG = 1;
	for (counter = 7; counter < 15; counter++)
	    totals = totals + scores[counter];
	totals = totals + scores[TOTALLEFT];
	totals = totals + scores[BONUS];
	sprintf(grandstr, "%u", totals);
	if (totals < 100)
	    sprintf(grandstr, " %u", totals);
	Move(rp, 352, 132 + YOFFSET);
	Text(rp, grandstr, 3);
	if (totals > highscore)
	    if ((hs = fopen("yatz.hs", "w")) != NULL) {
		highscore = totals;
		fprintf(hs, "%d", highscore);
		fclose(hs);
		ShowHighScore();
	    }
    }
}

VOID 
DoneRolls()
{
    USHORT counter;
    ULONG           signalmask, signals;
    signalmask = 1L << window1->UserPort->mp_SigBit;
    DoGrand();
    for (counter = 1; counter < 6; counter++)
	dicegad[counter] = 0;
    Gadget8.Flags = NULL;
    Gadget9.Flags = NULL;
    Gadget10.Flags = NULL;
    Gadget11.Flags = NULL;
    Gadget12.Flags = NULL;
    SetDrMd(rp, JAM2 | INVERSVID);
    RectFill(rp, 15, 15 + YOFFSET, 54, 150 + YOFFSET);
    RefreshGList(&Gadget8, window1, NULL, 5);	/* Get Rid of Dice */
    GhostDice();
    if (FINISHFLAG != 1) {
	while ((GadFlag != ROLL) && (GadFlag != CLOSED)) {
	    signals = Wait(signalmask);
	    if (signals & signalmask)
		GadFlag = handleIDCMP(window1);
	}
	if (GadFlag != CLOSED) {
	    UnGhostDice();
	    RollAllDice();
	}
    }
}

USHORT 
CheckThree()
{
    char           tempstr[20];
    USHORT          result = 0, counter, total = 0, temp[7] =
    {0, 0, 0, 0, 0, 0, 0};
    for (counter = 1; counter < 6; counter++) {
	temp[diceroll[counter] - 1]++;
	total = total + diceroll[counter];
    }

    for (counter = 0; counter < 6; counter++)
	if (temp[counter] >= 3)
	    result = 1;
    if (result != 1)
	total = 0;
    if (GadFlag != FULLHOUSE) {
	scores[GadFlag - 2] = total;
	Move(rp, 360, 25 + YOFFSET);
	if (total < 10)
	    sprintf(tempstr, " %u", total);
	else
	    sprintf(tempstr, "%u", total);
	Text(rp, tempstr, 2);
    }
    return result;
}


USHORT 
CheckFour()
{
    char           tempstr[20];
    USHORT          result = 0, counter, total = 0, temp[7] =
    {0, 0, 0, 0, 0, 0, 0};
    for (counter = 1; counter < 6; counter++) {
	temp[diceroll[counter] - 1]++;
	total = total + diceroll[counter];
    }

    for (counter = 0; counter < 6; counter++)
	if (temp[counter] >= 4)
	    result = 1;

    if (result != 1)
	total = 0;
    scores[GadFlag - 2] = total;
    Move(rp, 360, 39 + YOFFSET);
    if (total < 10)
	sprintf(tempstr, " %u", total);
    else
	sprintf(tempstr, "%u", total);
    Text(rp, tempstr, 2);
    return result;
}

USHORT 
CheckFullHouse()
{
    USHORT          result = 0, counter, temp[7] =
    {0, 0, 0, 0, 0, 0, 0};
    for (counter = 1; counter < 6; counter++)
	temp[diceroll[counter] - 1]++;

    for (counter = 0; counter < 6; counter++)
	if (temp[counter] == 2)
	    result = 1;

    if ((result == 1) && (CheckThree() == 1)) {
	scores[GadFlag - 2] = 25;
	Move(rp, 360, 53 + YOFFSET);
	Text(rp, "25", 2);
    } else {
	result = 0;
	scores[GadFlag - 2] = 0;
	Move(rp, 360, 53 + YOFFSET);
	Text(rp, " 0", 2);
    }
    return result;
}

USHORT 
CheckSmStraight()
{
    USHORT          result = 0, counter, total = 0, temp[7] =
    {0, 0, 0, 0, 0, 0, 0};
    for (counter = 1; counter < 6; counter++)
	temp[diceroll[counter] - 1]++;
    total = 0;
    for (counter = 0; counter < 6; counter++) {
	if (temp[counter] >= 1)
	    total++;
	else {
	    if (temp[counter] == 0)
		total = 0;
	}
	if (total == 4)
	    result = 1;
    }
    if (result == 1) {
	scores[GadFlag - 2] = 30;
	Move(rp, 360, 67 + YOFFSET);
	Text(rp, "30", 2);
    } else {
	scores[GadFlag - 2] = 0;
	Move(rp, 360, 67 + YOFFSET);
	Text(rp, " 0", 2);
    }
    return result;
}

USHORT 
CheckLgStraight()
{
    USHORT          result = 0, counter, total = 0, temp[7] =
    {0, 0, 0, 0, 0, 0, 0};
    for (counter = 1; counter < 6; counter++)
	temp[diceroll[counter] - 1]++;
    total = 0;
    for (counter = 0; counter < 6; counter++) {
	if (temp[counter] >= 1)
	    total++;
	else {
	    if (temp[counter] == 0)
		total = 0;
	}
	if (total == 5)
	    result = 1;
    }
    if (result == 1) {
	scores[GadFlag - 2] = 40;
	Move(rp, 360, 81 + YOFFSET);
	Text(rp, "40", 2);
    } else {
	scores[GadFlag - 2] = 0;
	Move(rp, 360, 81 + YOFFSET);
	Text(rp, " 0", 2);
    }

    return result;
}

USHORT 
CheckYatz()
{
    char           tempstr[20];
    USHORT          result = 0, counter, total = 0, temp[7] =
    {0, 0, 0, 0, 0, 0, 0};
    for (counter = 1; counter < 6; counter++)
	temp[diceroll[counter] - 1]++;
    total = 0;
    for (counter = 0; counter < 6; counter++)
	if (temp[counter] == 5)
	    result = 1;
    if (result == 1) {
	scores[GadFlag - 2] = scores[GadFlag - 2] + 50;
	if (scoretable[GadFlag - 2] == 0)
	    scores[GadFlag - 2] = 50;
	Move(rp, 352, 95 + YOFFSET);
	if (scores[GadFlag - 2] == 50)
	    Text(rp, " 50", 3);
	else {
	    sprintf(tempstr, "%d", scores[GadFlag - 2]);
	    Text(rp, tempstr, 3);
	}
    } else if (scores[GadFlag - 2] == 0) {
	Move(rp, 352, 95 + YOFFSET);
	Text(rp, "  0", 3);
    }
    return result;
}

VOID 
DoChance()
{
    char           tempstr[20];
    USHORT          counter, total = 0;
    for (counter = 1; counter < 6; counter++)
	total = total + diceroll[counter];
    scores[GadFlag - 2] = total;
    Move(rp, 360, 109 + YOFFSET);
    if (total < 10)
	sprintf(tempstr, " %u", total);
    else
	sprintf(tempstr, "%u", total);
    Text(rp, tempstr, 2);
}


VOID 
DoTotal()
{
    USHORT          total;
    char           tempstr[20];
    if ((NumLeftBlanks() == 0) && (scores[TOTALLEFT] == 0)) {
	scores[TOTALLEFT] = DoBonus();

	if (scores[TOTALLEFT] >= 63) {
	    scores[BONUS] = 35;
	    Move(rp, 198, 118 + YOFFSET);
	    Text(rp, "35", 2);
	} else {
	    Move(rp, 198, 118 + YOFFSET);
	    Text(rp, " 0", 2);
	}
	total = scores[TOTALLEFT];
	Move(rp, 190, 109 + YOFFSET);
	if (total < 10)
	    sprintf(tempstr, "  %u", total);
	else
	    sprintf(tempstr, " %u", total);
	Text(rp, tempstr, 3);
    }
}


VOID 
DoRestart()
{
    ULONG           signalmask, signals;
    int             counter;
    signalmask = 1L << window1->UserPort->mp_SigBit;
    for (counter = 0; counter < 20; counter++)
	scores[counter] = 0;
    for (counter = 0; counter < 15; counter++)
	scoretable[counter] = 0;
    while ((GadFlag != ROLL) && (GadFlag != CLOSED)) {
	signals = Wait(signalmask);
	if (signals & signalmask)
	    GadFlag = handleIDCMP(window1);
    }
    if (GadFlag != CLOSED) {
        RemoveGList(window1, &Gadget8, 5);
        Gadget8.Flags = Gadget8.Flags & ~GADGDISABLED;
        Gadget9.Flags = Gadget9.Flags & ~GADGDISABLED;
        Gadget10.Flags = Gadget10.Flags & ~GADGDISABLED;
        Gadget11.Flags = Gadget11.Flags & ~GADGDISABLED;
        Gadget12.Flags = Gadget12.Flags & ~GADGDISABLED;
        AddGList (window1, &Gadget8, 0, 5, NULL);
        SetDrMd(rp, JAM2 | INVERSVID);
        RectFill(rp, 1, 10 + YOFFSET, 375, 150 + YOFFSET);
        RefreshGList(&Gadget8, window1, NULL, -1);
        ShowHighScore();
	RollAllDice();
    }
     else leaveprog = TRUE;
    FINISHFLAG = 0;
}

VOID 
main()
{
    ULONG           signalmask, signals;
    OpenAll();
    seed = time(NULL);
    srand((USHORT) seed);
    signalmask = 1L << window1->UserPort->mp_SigBit;
    rp = window1->RPort;
    SetAPen(rp, 1);
    ShowHighScore();
    while ((GadFlag != ROLL) && (GadFlag != CLOSED)) {
	signals = Wait(signalmask);
	if (signals & signalmask)
	    GadFlag = handleIDCMP(window1);
    }
    if (GadFlag != CLOSED) {
         UnGhostDice();
	 RollAllDice();
         }
       else
        {
        cleanupsome();
        havesound = FALSE;
        }
	
       	while (GadFlag != CLOSED) {
	    if (FINISHFLAG == 1)
		DoRestart();
            if (leaveprog != TRUE)
          {
	    signals = Wait(signalmask);
	    if (signals & signalmask)
		GadFlag = handleIDCMP(window1);
	    if ((GadFlag == ROLL) && (rollcount < 2)) {
		if (RollSelected() == NONE)
		    rollcount--;
		rollcount++;
	    } else if ((GadFlag >= SCORE) && (GadFlag <= SCORE + 5) && (scoretable[GadFlag - 2] == 0)) {
		DoDigits();
		scoretable[GadFlag - 2] = 1;
		rollcount = 0;
		DoTotal();
		DoneRolls();
	    } else if ((GadFlag == THREEOFAKIND) && (scoretable[GadFlag - 2] == 0)) {
		CheckThree();
		scoretable[GadFlag - 2] = 1;
		rollcount = 0;
		DoneRolls();
	    } else if ((GadFlag == FOUROFAKIND) && (scoretable[GadFlag - 2] == 0)) {
		CheckFour();
		scoretable[GadFlag - 2] = 1;
		rollcount = 0;
		DoneRolls();
	    } else if ((GadFlag == FULLHOUSE) && (scoretable[GadFlag - 2] == 0)) {
		CheckFullHouse();
		scoretable[GadFlag - 2] = 1;
		rollcount = 0;
		DoneRolls();
	    } else if ((GadFlag == SMSTRAIGHT) && (scoretable[GadFlag - 2] == 0)) {
		CheckSmStraight();
		scoretable[GadFlag - 2] = 1;
		rollcount = 0;
		DoneRolls();
	    } else if ((GadFlag == LGSTRAIGHT) && (scoretable[GadFlag - 2] == 0)) {
		CheckLgStraight();
		scoretable[GadFlag - 2] = 1;
		rollcount = 0;
		DoneRolls();
	    } else if ((GadFlag == YATZ) && ((scoretable[GadFlag - 2] == 0)
					     || (scores[GadFlag - 2] > 0))) {
		if ((CheckYatz() == 1) || (scoretable[GadFlag-2] == 0))
                {
		scoretable[GadFlag - 2] = 1;
		rollcount = 0;
		DoneRolls();
                }
	    } else {
		if ((GadFlag == CHANCE) && (scoretable[GadFlag - 2] == 0)) {
		    scoretable[GadFlag - 2] = 1;
		    DoChance();
		    rollcount = 0;
		    DoneRolls();
		}
	    }
         }
    }
    cleanExit(RETURN_OK);
}
