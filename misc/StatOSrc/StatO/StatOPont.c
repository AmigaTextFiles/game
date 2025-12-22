
/*****************************************************/
/*                StatOPont V1.1                     */
/*   A card game of pontoon which uses intuition as  */
/* it's user interface.                              */
/* Please note that this is my first attempt at      */
/* using intuition, so I am sure that there are      */
/* inefficient parts to this program. If you see     */
/* anything that may be modified to increase         */
/* efficiency, i'd appreciate it if you would let me */
/* know about it.                                    */
/*    I don't intend to make any further additions   */
/* to the game, but if I get a few requests, then I  */
/* may decide to add a little more to the game.      */
/*    If you would like to make a version 1.2 or 2.0 */
/* of this game, then feel free to contact me and    */
/* will probably let you release it (once there is   */
/* a significant change made to the game). I may     */
/* request a look at the game before I allow anyone  */
/* to release another version. This is to protect    */
/* other Aminet downloaders from seeing a load of    */
/* duplicates of basically the same game on their    */
/* ftp/bbs site ( I'm not really bothered about the  */
/* copyright of the game otherwise ).                */
/*    The executable can be found on any of the      */
/* aminet mirrors e.g. ftp.wustl.edu                 */
/*    /pub/aminet/game/misc/StatOPont.lha            */
/*    If you want to use *any* of the functions in   */
/* this program in any of your own programs, you     */
/* have my permission to do so.                      */
/*        *** Compiled under DICE C ***              */
/*        by Chris Mc Carthy (© 1994)                */
/*        cmccarth@icl.rtc-cork.ie                   */
/*****************************************************/


/* Standard includes */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/* Amiga specific includes */

#include <intuition/intuition.h>
#include <exec/exec.h>

#define HEARTS   "Hearts"     /* The four suits */
#define DIAMONDS "Diamonds"
#define CLUBS    "Clubs"
#define SPADES   "Spades"

#define HEARTS_STR   "Hearts\0"     /* The four suits with the string */
#define DIAMONDS_STR "Diamonds\0"   /* terminator attached, needed for */
#define CLUBS_STR    "Clubs\0"      /* use of strcmp()                 */
#define SPADES_STR   "Spades\0"

#define INITIAL_DEAL 2          /* No. of cards in initial deal */
#define MAX_CARD 52             /* Index value of max card */

#define PONTOON 21              /* Value of Pontoon/BlackJack */
#define BURN_VALUE 14           /* Value at which a 'burn' is offered */
#define COMP_STICK 16           /* The computer will stick at this value */
                                /* or higher,otherwise it will twist */

#define PICTURE_VALUE 10        /* Value of all picture cards */

#define PICTURE_MIN1 11         /* Index of Jack of first suit */
#define PICTURE_MAX1 13         /* Index of King of suit 1 */
#define PICTURE_MAX2 26         /* Index of King of suit 2 */
#define PICTURE_MAX3 39         /* Index of King of suit 3 */

#define ACE_DIFF 10             /* Difference between Ace's 2 values, */
                                /* it can be either 11 or 1           */
#define ACE_MAX_VALUE 11        /* Max Value of Ace, Min value is 1 */

#define ACE 1                   /* Index of FaceValue of Ace */
#define JACK 11                 /* Index of FaceValue of Jack */
#define QUEEN 12                /* Index of FaceValue of Queen */
#define KING 13                 /* Index of FaceValue of King */


/* I reckon there is a more efficient way of managing output to two */
/* sections in a window than the way I have done it here, but this  */
/* is the best I can do for the moment                              */

#define RPX_UPPER 20    /* RastPort x co-ord on upper window section */
#define RPY_UPPER 30    /* RastPort y co-ord on upper window section */
#define RPX_LOWER 20    /* RastPort x co-ord on lower window section */
#define RPY_LOWER 120   /* RastPort y co-ord on lower window section */
#define RPXR_UPPER 195  /* RastPort x co-ord on RIGHT upper window   */
                        /* section (used to print computer's hand )  */
#define RPXR_LOWER 190


      /* BLANK_STRING, used for blanking over text on window */

                      /*  0        1         2         3         4        */
                      /*  12345678901234567890123456789012345678901234567 */
#define BLANK_STRING     "                                             "




   /* User option, recieved from the IDCMP */
enum UserOptions {STICK, TWIST, PLAY, BURN, STATO, QUIT};

struct TextAttr my_font = 
{
   "topaz.font",
   TOPAZ_EIGHTY,
   FS_NORMAL,
   FPF_ROMFONT
};


/*
** Must now declare the 5 gadgets to be used, i.e. Stick, Twist, Play,
** StatO and Quit,
** and must also declare the text to be used by those gadgets.
*/


/*
** First declare the text to be used by each gadget and the font to be 
** used.
*/

/*********** STICK *************/
struct IntuiText stick_gadget_text = 
{
   2,1,
   JAM1,
   5,5,
   &my_font,
   "Stick",
   NULL
};

/************ TWIST *************/
struct IntuiText twist_gadget_text = 
{
   2,0,
   JAM1,
   5,5,
   &my_font,
   "Twist",
   NULL
};

/************* PLAY **************/
struct IntuiText play_gadget_text = 
{
   2,0,
   JAM1,
   5,5,
   &my_font,
   "Play",
   NULL
};

/************** BURN ****************/
struct IntuiText burn_gadget_text = 
{
   2,0,
   JAM1,
   5,5,
   &my_font,
   "Burn",
   NULL
};

/*************** STATO ****************/
struct IntuiText statO_gadget_text = 
{
   2,0,
   JAM1,
   5,5,
   &my_font,
   "StatO",
   NULL
};

/**************** QUIT ***************/
struct IntuiText quit_gadget_text = 
{
   2,0,
   JAM1,
   5,5,
   &my_font,
   "Quit",
   NULL
};

/*
** Now declare the actual gadgets themselves.
*/

/*************** QUIT ****************/
struct Gadget quit_gadget = 
{
   NULL,               /* Next gadget */
   315,205,50,15,      /* L edge, T edge, Width, Height */
   GADGHCOMP,          /* FLAGS */
   GADGIMMEDIATE|      /* ACTIVATION */
   RELVERIFY,
   PROPGADGET,         /* GADGET TYPE */
   NULL,               /* GADGET RENDER */
   NULL,               /* SELECT RENDER */
   &quit_gadget_text,  /* GADGET TEXT */
   NULL,
   NULL,                /* SpecialInfo */
   NULL,
   NULL,
};

/*************** STATO **************/
struct Gadget statO_gadget = 
{
   &quit_gadget,       /* Next gadget */
   255,205,50,15,      /* L edge, T edge, Width, Height */
   GADGHCOMP,          /* FLAGS */
   GADGIMMEDIATE|      /* ACTIVATION */
   RELVERIFY,
   PROPGADGET,         /* GADGET TYPE */
   NULL,               /* GADGET RENDER */
   NULL,               /* SELECT RENDER */
   &statO_gadget_text, /* GADGET TEXT */
   NULL,
   NULL,
   NULL,
   NULL,
};

/**************** BURN *************/
struct Gadget burn_gadget = 
{
   &statO_gadget,      /* Next gadget */
   195,205,50,15,      /* L edge, T edge, Width, Height */
   GADGHCOMP,          /* FLAGS */
   GADGIMMEDIATE|      /* ACTIVATION */
   RELVERIFY,
   PROPGADGET,         /* GADGET TYPE */
   NULL,               /* GADGET RENDER */
   NULL,               /* SELECT RENDER */
   &burn_gadget_text,  /* GADGET TEXT */
   NULL,
   NULL,
   NULL,
   NULL,
};

/************** PLAY ***************/
struct Gadget play_gadget = 
{
   &burn_gadget,       /* Next gadget */
   135,205,50,15,      /* L edge, T edge, Width, Height */
   GADGHCOMP,          /* FLAGS */
   GADGIMMEDIATE|      /* ACTIVATION */
   RELVERIFY,
   PROPGADGET,         /* GADGET TYPE */
   NULL,               /* GADGET RENDER */
   NULL,               /* SELECT RENDER */
   &play_gadget_text,  /* GADGET TEXT */
   NULL,
   NULL,
   NULL,
   NULL,
};

/****************** TWIST **************/
struct Gadget twist_gadget = 
{
   &play_gadget,          /* Next gadget */
   75,205,50,15,          /* L edge, T edge, Width, Height */
   GADGHCOMP,             /* FLAGS */
   GADGIMMEDIATE|         /* ACTIVATION */
   RELVERIFY,
   PROPGADGET,            /* GADGET TYPE */
   NULL,                  /* GADGET RENDER */
   NULL,                  /* SELECT RENDER */
   &twist_gadget_text, 
   NULL,
   NULL,
   NULL,
   NULL,
}; 

/**************** STICK ************/
struct Gadget stick_gadget = 
{
   &twist_gadget,          /* Next gadget */
   15,205,50,15,           /* L edge, T edge, Width, Height */
   GADGHCOMP,              /* FLAGS */
   GADGIMMEDIATE|          /* ACTIVATION */
   RELVERIFY,
   PROPGADGET,             /* GADGET TYPE */
   NULL,                   /* GADGET RENDER */
   NULL,                   /* SELECT RENDER */
   &stick_gadget_text, 
   NULL,
   NULL,
   NULL,
   NULL,
};

/*
** Declare the game window. Every thing to do with input/output with 
** this program goes through this window.
*/ 
    
struct NewWindow InitialWindow = 
{
   10, 10,                                  /* Left Edge, Top Edge */
   380, 225,                                /* Width, Ueight */
   0, 1,                                    /* Display options */
   GADGETUP,                                /* IDCMP flags */
   ACTIVATE |                               /* sys gadgets + other flags */
   WINDOWDRAG |
   WINDOWDEPTH,
   &stick_gadget,                           /* first gadget */
   NULL,
   "      Email: cmccarth@icl.rtc-cork.ie", /* Title */
   NULL,
   NULL,
   380,30,                                  /* Min width, min height */
   380, 205,                                /* Max width, max height */
   WBENCHSCREEN                             /* Type */
};


struct Window *my_window;        /* Game window */
struct IntuiMessage *message;    /* IDCMP message storage */
struct MsgPort *my_port;         /* IDCMP message port */
struct RastPort *rp;             /* RastPort for the window */

struct Library *IntuitionBase;


struct CardNode
   {                              /* Node to store FaceValue and suit */
   struct CardNode *NextNode;    /* and of course a link to the next node */
   int FaceValue;
   char *suit;
   };

typedef struct CardNode *CardPtr; /* pointer to a card node */


struct statistics          /* Structure to hold the game stats which */
{                          /* can be called up by at request of the */
                           /* user */

   int wins;            /* No. of Human wins */
   int CompWins;        /* No. of Computer wins */
   int ponts;           /* No. of Human Pontoons */
   int CompPonts;       /* No. of Computer Pontoons */
   int busts;           /* No. of Human Busts */
   int CompBusts;       /* No. of Computer Busts */
   int draws;           /* No. of Draws */
   int burns;           /* No. of Human Burns */
   int CompBurns;       /* No. of Computer Burns */
   int games;           /* No. of Games played */
   int SincePont;       /* No. of games since Human's last Pontoon */
   int CompSincePont;   /* No. of games since Computer's last Pontoon */
   int SinceBurn;       /* No. of games since Human's last Burn */
   int CompSinceBurn;   /* No. of games since Computer's last Burn */
};

struct statistics GameStats;

/* Declare variables to store intuition's messages */
ULONG class;                  /* storage variable for message "class" */
APTR address;                 /* same as above, but for message address */

enum UserOptions UserOption;  /* Stick, Twist, Play, StatO or Quit */

void main();
void wbmain(struct WBStartup *wbs);
CardPtr AddCard(CardPtr ListHead, int NewCard, char *NewSuit);
CardPtr DealCard(CardPtr ListHead);
void DisplayCard(int FaceValue, char *suit, int rpx); 
void DisplayHand(CardPtr ListHead, int rpx);
CardPtr FreeList(CardPtr ListHead);
CardPtr DealHand();
BOOL PlayGame();
BOOL CardInHand(CardPtr ListHead, int NewCard, char *NewSuit);
int CalculateScore(CardPtr ListHead);
enum UserOptions GetOption();
BOOL isbust(int score);
BOOL ispicture(int value);
void initialise();
void Closedown();
void ClearWinUpper();
void ClearWinLower();
char *IntToStr2(int number);
void StatO();

int rpyUp;     /* RastPort Upper window section y co-ord index */
int rpyLow;    /* RastPort Lower windwo section y co-ord indec */

BOOL RaceOver = FALSE;  /* Race to 99 wins :-) */
BOOL quit;              /* Quit game */

CardPtr hand = NULL;       /* pointer to first card in Human's hand */
CardPtr CompHand = NULL;   /* pointer to first card in Computer's hand */

/*******************************************************
* ----------------------- Main ---------------------- *
*******************************************************/

/*
** Game has started from the CLI
*/

void main()
{

   srand(clock());      /* This is to aid rand() in returning true */
                        /* random values rather than pseudo random */

   initialise();        /* Open libs & window + other initialisatinn */
   do
      quit = PlayGame();   /* Play game and get result ( Quit or Play ) */
                           /* i.e TRUE or FALSE */
   while (! quit);
   Closedown();            /* Close libs and window */
   exit(0);
}

/************************************************
*-------------- Workbench main------------------*
* This is called if the program is run from     *
* workbench by clicking on the StatOPont icon.  *
************************************************/

/*
** Game is started from WorkBench
*/

void wbmain(struct WBStartup *wbs)
{

   srand(clock());      /* This is to aid rand() in returning true */
                        /* random values rather than pseudo random */
   initialise();        /* Open libs & windwo + other initialisatinn */
   do
      quit = PlayGame();   /* Play game and get result ( Quit or Play ) */
                           /* i.e. TRUE or FALSE */
   while (! quit);
   Closedown();            /* Close libs and window */
   return;   
}




/***************************************
* Shuts down the library and window
***************************************/
   
void Closedown()
{
   CloseLibrary (IntuitionBase);
   CloseWindow (my_window);
}

/*******************************************
* This opens the intuitinn lib and also the
* windww. Also takes care of initialising the RastPort
* rp ( my_window->RPort ), and printing once off
* text to the window.
*******************************************/

void initialise()
{

   IntuitionBase = (struct Library *) OpenLibrary("intuition.library", 0);
   if (IntuitionBase == NULL)
   {
      puts("Couldn't open intuition.library");
      exit(10);
   }
   
   my_window = (struct Window *) OpenWindow(&InitialWindow);
   if (my_window == NULL)
   {
      puts("Could not open window.");
      CloseLibrary(IntuitionBase);
      exit(20);
   }

   my_port = my_window->UserPort;   /* Set up our RastPort to the window */
   rp = (struct RastPort *) my_window->RPort;

   /*
   ** Print essential initial text to the window ;-)
   */
   
   SetAPen(rp, 1);
   Move(rp, 10, 200);
   

   Text(rp, "   StatOPont V1.1 © 1994 Chris Mc Carthy.",40);

   SetAPen(rp, 3);
   Move(rp, 3, 110);    /* Draw dividing line accross the window */
   Draw(rp, 377, 110);

   Move(rp, RPX_UPPER, 20);      /* Heading to show which cards are which */
   Text (rp, "    Your Cards.",15); 
   Move(rp, RPXR_UPPER, 20);
   Text(rp, "Computer's Cards.", 17);

   SetAPen(rp, 2);      /* Pen for rest of text in game */

   /* Initialise all the stats */
     
   GameStats.wins           = 0;
   GameStats.CompWins       = 0;
   GameStats.ponts          = 0;
   GameStats.CompPonts      = 0;
   GameStats.busts          = 0;
   GameStats.CompBusts      = 0;
   GameStats.draws          = 0;
   GameStats.burns          = 0;
   GameStats.CompBusts      = 0;
   GameStats.games          = 0;
   GameStats.SincePont      = 0;
   GameStats.CompSincePont  = 0;
   GameStats.SinceBurn      = 0;
   GameStats.CompSinceBurn  = 0;

}

/*******************************************
* This adds a new card to the hand. It takes the list head, a random 
* value between 1 and 13 and a suit string as it's inputs,
* and returns the list head with the new card added to the list as a result.
* In the event of the system running out of memory,
* this function will detect it and will exit() there and
* then.
*********************/

CardPtr AddCard(CardPtr ListHead, int NewCard, char *NewSuit)
{
   CardPtr NewNode;
   char *NewSuitPtr;

   /*
   ** Allocate memory for new node.
   */
   
   NewNode = malloc(sizeof(struct CardNode));
   if (NewNode == NULL)
   {
      puts("Sorry, out of memory, no mem for NewNode");
      exit(30);
   }
 

   /* Allocate memory for the suit of the new card suit string */
   
   NewSuitPtr = malloc(strlen((NewSuit) + 1));

   if (NewSuitPtr == NULL) {
      puts("Sorry, out of memory, no mem for suit");
      exit(40);
   }

   /* Put the new suit into the new free space in memory */
   strcpy(NewSuitPtr, NewSuit);

   /* Give the new node their values */
   NewNode->FaceValue = NewCard;
   NewNode->suit = NewSuitPtr;

   /* Insert the NewNode to the top of the global list */
   NewNode->NextNode = ListHead;
   ListHead = NewNode;

   return (ListHead);

}


/**********************************
* This generates a random value between 1 and 13 and a random suit and then
* sends these values to AddCard() which adds them to the list.
****************/

CardPtr DealCard(CardPtr ListHead)
{
   int NewCard;      /* value between 1 and MAX_CARD, contains the */
                     /* FaceValue of the card.                     */

   float RandValue;  /* This is used to hold a value between 0 and 1 */
   char NewSuit[10]; /* New suit of card */
   
   do 
   {
      /* Generate new card, FaceValue and suit, the number is an */
      /* integer between 1 and MAX_CARD. */
      RandValue = (float) rand() / RAND_MAX; 
      NewCard = (int) (1 + (RandValue * (MAX_CARD - 1)));
                     
      /*
      ** Determine which suit the card belongs to and copy the
      ** appropriate suit to the temporary array of char.
      ** Also, Get the Face Value ( value between 1 and 13 ) of the card.
      */
   
      if (NewCard <= PICTURE_MAX1)
         strcpy(NewSuit, DIAMONDS);

      else if (NewCard <= PICTURE_MAX2) 
      {   
         NewCard -= PICTURE_MAX1;
         strcpy(NewSuit, CLUBS);
      }

      else if (NewCard <= PICTURE_MAX3) 
      {
         NewCard -= PICTURE_MAX2;
         strcpy(NewSuit, SPADES);
      }

      else if (NewCard <= 52)
      {
         NewCard -= PICTURE_MAX3;
         strcpy(NewSuit, HEARTS);
      }
      else 
         puts("ERROR***---- DealCard()");

   /* Make sure that the card has not already been dealt */
   } while (CardInHand(ListHead, NewCard, NewSuit) ||
            CardInHand(ListHead, NewCard, NewSuit));

   /* Add card to the list */
   ListHead = AddCard(ListHead, NewCard, NewSuit);
   return ListHead;
}

/***************************************
* This Checks to see if the NewCard has been 
* already dealt. It avoids the embarrasing event
* of the same card turning up twice in the same deal twice.
* Returns TRUE if the card is in the current hand, FALSE otherwise.
*****************/

BOOL CardInHand(CardPtr ListHead, int NewCard, char *NewSuit)


{
   BOOL found = FALSE;  /* Found the card in the hand */
   CardPtr CurrPtr = ListHead;

   while (CurrPtr != NULL && ! found)
   {
      /* If the Face values and the suits are the same */
      if (CurrPtr->FaceValue == NewCard && 
                        strcmp(CurrPtr->suit, NewSuit) == 0)
         found = TRUE;
      CurrPtr = CurrPtr->NextNode;
   }

   if (found)     /* If the card is found in the hand */
      return TRUE;
   else
      return FALSE;

}

/*******************************************
* Calculates the score of the hand ( for the either player ).
* Simply traverses the list and adds the FaceValue to the total at each
* node. Returns the score for the hand
*****************/

int CalculateScore(CardPtr ListHead)
{
   int Aces = 0;     /* No. of aces in the hand */

   CardPtr CurrPtr = ListHead;
   int value = 0; /* Value of hand */
   
   while (CurrPtr != NULL) 
   {
      if (ispicture(CurrPtr->FaceValue))
         value += PICTURE_VALUE;
         
      /*
      ** If card is an ace, give it a value of ACE_MAX_VALUE by default. 
      ** We will check after if it would be better to give the ace a value
      ** of 1. The Ace ( for those who don't know the game ) carries
      ** the best possible value of ACE_MAX_VALUE or 1.
      */

      else if (CurrPtr->FaceValue == 1) 
      {
         Aces++;
         value += ACE_MAX_VALUE;
      }
      else
         value += CurrPtr->FaceValue;
      CurrPtr = CurrPtr->NextNode;
   }

   /*
   ** Now check to see if it's better for any/all aces to carry the lower
   ** value of 1. If the user is bust with the higher value, then reduce it
   ** by ACE_DIFFERENCE and if there are more aces in the deck and the
   ** user is still bust, then repeat the process. You get my drift don't
   ** you :-).
   */

   while (Aces && isbust(value)) /* while there are more aces to take */
   {                             /* account and while the current value */
      Aces--;                    /* is bust */
      value -= ACE_DIFF;
   }

   return value;
}

/***************************************
* returns TRUE if the card is a picture card ( Jack/Queen/King ).
* returns FALSE otherwise.
***********/

BOOL ispicture(int value)
{
   if (value >= PICTURE_MIN1 && value <= PICTURE_MAX1)
      return TRUE;
   else 
      return FALSE;
}


/*********************
* This will print the face value
* of the card ( 1 to 13 ), and also the suit.
* I have little doubt at this moment in time that there
* is a better way of doing this.
***********/

void DisplayCard(int FaceValue, char *suit, int rpx)
{

   /*------ Print face value of card -------*/

   switch(FaceValue) 
   {
      case ACE   : Text (rp, "  Ace of ", 9); break;
      case 2     : Text (rp, "    2 of ", 9); break;  
      case 3     : Text (rp, "    3 of ", 9); break;
      case 4     : Text (rp, "    4 of ", 9); break;
      case 5     : Text (rp, "    5 of ", 9); break;
      case 6     : Text (rp, "    6 of ", 9); break;
      case 7     : Text (rp, "    7 of ", 9); break;
      case 8     : Text (rp, "    8 of ", 9); break;
      case 9     : Text (rp, "    9 of ", 9); break;
      case 10    : Text (rp, "   10 of ", 9); break;
      case JACK  : Text (rp, " Jack of ", 9); break;
      case QUEEN : Text (rp, "Queen of ", 9); break;
      case KING  : Text (rp, " King of ", 9); break;
      default    : puts("ERROR ** DisplayCard FaceValue"); break;
   }

   /* ------ Printf the suit of the card ------------_*/
   if (! strcmp(suit, HEARTS_STR))        Text (rp, HEARTS, 6);
   else if (! strcmp(suit, DIAMONDS_STR)) Text (rp, DIAMONDS, 8);
   else if (! strcmp(suit, SPADES_STR))   Text (rp, SPADES, 6);
   else if (! strcmp(suit, CLUBS_STR))    Text (rp, CLUBS, 5);
   else puts("ERROR ** DisplayCard Suit");

   /* Move the rastport y co-ord index down one line */
   rpyUp += 10;
   Move (rp, rpx, rpyUp);

}

/*********************************************
* This clears the text from the upper section 
* of the window, (unefficiently) :-(.
*********************************************/

void ClearWinUpper()
{

   int i;      /* index, number of lines to overwrite */

   for (rpyUp = RPY_UPPER, i = 0 ; i < 8; rpyUp += 10, i++) 
   {
      Move(rp, RPX_UPPER, rpyUp);
      Text(rp, BLANK_STRING, 40);   /* Overwrite present text with blank */
   }                                /* string, */


                                    /* Move the rast port back to the top */
                                    /* of the text windww ( i.e. back to  */
   Move(rp, RPX_UPPER , RPY_UPPER); /* where the text begins )   */
   rpyUp = RPY_UPPER;

}

   
/******************************************
* A list traversal function. Continues 
* traversing the list until it reaches the end.
* Displays the relevent data at each node it visits.
******************************************/

void DisplayHand(CardPtr ListHead, int rpx)
{

   CardPtr CurrPtr = ListHead;

   Move(rp, rpx, RPY_UPPER); /* Position rp suitably */
   while (CurrPtr != NULL) 
   {
      DisplayCard(CurrPtr->FaceValue, CurrPtr->suit, rpx);
      CurrPtr = CurrPtr->NextNode;
   }
}


/********************************************
* Now we can't have the program eating all your memory each
* time it is run without giving it back afterwards can we ;-).
* Takes the list to be freed as it's parameter, returns the empty
* list as a result.
********************************************/

CardPtr FreeList(CardPtr ListHead)
{
   CardPtr TempPtr;  /* Needed to allow the nodes to be deleted */
                              /* while ListHead goes to the next node,   */
                              /* TempPtr can be free()ed                 */
   while (ListHead != NULL)
   {
      TempPtr = ListHead;
      ListHead = ListHead->NextNode;
      free(TempPtr->suit);       /* Free the node's suit string */
      free(TempPtr);             /* Free the node */
   }
   return (ListHead);
}


/*****************************************
* Deals the initial deal for either player,
* returns a pointer to the first card in the hand.
******************************************/

CardPtr DealHand()
{
   int i;      /* index */
   CardPtr ListHead = NULL;

   for(i = 0; i < INITIAL_DEAL; i++)
      ListHead = DealCard(ListHead);
   return (ListHead);
}

/***********************************************************
* Is the value given bust ?????, if so then return TRUE, else FALSE.
******************************************************/

BOOL isbust(int score)
{
   if (score > PONTOON) 
      return TRUE;
   else
      return FALSE;
}

/**************************************
* Get option from user (stick, twist, Play, Burn, StatO or Quit)
* return the option.
***********/

enum UserOptions GetOption()
{


   /* Wait for a message ( for a gadget to be clicked on. */
   Wait ( 1 << my_port->mp_SigBit );

   
   /* We have a message, now collect it. */
   message = (struct IntuiMessage *) GetMsg(my_port);
   
   /* Save the important values in the variables */      
   class = message->Class;
   address = message->IAddress;

   /* We have now saved some important values, and can now reply. */
   ReplyMsg(message);

   /* What has actually happened? */
   if (class == GADGETUP) 
   {
      /* A gadget has been released. */
      /* Which gadget has been clicked on? */

      /*------------ Stick ----------------*/
      if(address == (APTR)&stick_gadget)
         return (STICK);            
         
      /*------------ Twist ---------------*/
      else if (address == (APTR)&twist_gadget)
         return (TWIST);

      /*------------ Play ----------------*/
      else if (address == (APTR)&play_gadget)
         return (PLAY);

      /*------------ Burn ----------------*/
      else if (address == (APTR)&burn_gadget)
         return(BURN);

      /*------------ StatO ---------------*/
      else if (address == (APTR)&statO_gadget)
         return (STATO);

      /*------------ Quit ----------------*/
      else if (address == (APTR)&quit_gadget)
         return (QUIT);
      else
         puts("ERROR***, not a valid gadget ????");
   }
   else puts("ERROR, not a gadget pressed ??????");
    
   
}



/**************************************************************
* This function will change a two dig. integer into a string: 
* There must be a better way ( more efficient ), but for now, 
* this will do the job fine. After all, I'm only a rookie for 
* the moment :-).
**************************************************************/

char *IntToStr2(int number)
{
   char str[2];
   /* Get first character of the string */
   
   if (number >= 99)
   {
      str[0] = '9';
      str[1] = '9';
      return str;
   }      
   else if (number >= 90) str[0] = '9';
   else if (number >= 80) str[0] = '8';
   else if (number >= 70) str[0] = '7';
   else if (number >= 60) str[0] = '6';
   else if (number >= 50) str[0] = '5';
   else if (number >= 40) str[0] = '4';
   else if (number >= 30) str[0] = '3';
   else if (number >= 20) str[0] = '2';
   else if (number >= 10) str[0] = '1';
   else if (number >= 0)  str[0] = ' ';
   else
   {
      puts("ERROR*** number too small");
      str[0] = 0;
      str[1] = 0;
      return str;
   }

   /* Now get second character */
   
   number %= 10;
   switch (number)
   {
      case 0: str[1] = '0';
              break;
      case 1: str[1] = '1';
              break;
      case 2: str[1] = '2';
              break;
      case 3: str[1] = '3';
              break;
      case 4: str[1] = '4';
              break;
      case 5: str[1] = '5';
              break;
      case 6: str[1] = '6';
              break;
      case 7: str[1] = '7';
              break;
      case 8: str[1] = '8';
              break;
      case 9: str[1] = '9';
              break;
      default : puts("Error with second digit??????");
                break;
   }
   return str;
   
      
}

/*****************************************************
* The sister ( or should that be brother ? ) function 
* to ClearWinUpper, clears the text in the Stat area.
* Takes a BOOL as a parameter, this tells it which
* comment to put at the end of the window.
*****************************************************/

void ClearWinLower()
{
   int i; /* Index for the number of lines to be overwritten */

   rpyLow = RPY_LOWER;

   for (i=0;i <= 7; rpyLow += 10, i++)
      {
      Move(rp, RPX_LOWER, rpyLow);
      Text(rp, BLANK_STRING, 43);
      }

   rpyLow = RPY_LOWER;
   Move(rp, RPX_LOWER, RPY_LOWER);
}

/***********************************************
* This displays all those interesting ( or not ) 
* statistics when required to do so by the user.
* StatO keeps a tally of all these numbers, so all
* we do here is print them out.
***********************************************/

void statO()
{

   char ScoreStr[2];    /* Temporary string to store the score */


   ClearWinLower();
   /*--------- Wins ----------*/

   strcpy(ScoreStr, IntToStr2(GameStats.wins));
   Move(rp, RPX_LOWER, rpyLow);
   Text(rp, "Your wins     = ",16);
   Text(rp, ScoreStr, 2);

   strcpy(ScoreStr, IntToStr2(GameStats.CompWins));
   Move(rp, RPXR_LOWER, rpyLow);
   Text(rp, "Comp Wins        = ", 19);
   Text(rp, ScoreStr, 2);

   rpyLow += 10;  /* Move on to next line */

   /*----------- Pontoons --------*/
   Move(rp, RPX_LOWER, rpyLow);
   strcpy(ScoreStr, IntToStr2(GameStats.ponts));
   Text(rp, "Your Pontoons = ", 16);
   Text(rp, ScoreStr, 2);

   Move(rp, RPXR_LOWER, rpyLow);
   strcpy(ScoreStr, IntToStr2(GameStats.CompPonts));
   Text(rp, "Comp Pontoons    = ", 19);
   Text(rp, ScoreStr, 2);

   rpyLow += 10;
   Move(rp, RPX_LOWER, rpyLow);

   /*----------- Busts -------------*/
   strcpy(ScoreStr, IntToStr2(GameStats.busts));
   Text(rp, "Your busts    = ", 16);
   Text(rp, ScoreStr, 2);

   Move(rp, RPXR_LOWER, rpyLow);
   strcpy(ScoreStr, IntToStr2(GameStats.CompBusts));
   Text(rp, "Comp busts       = ", 19);
   Text(rp, ScoreStr, 2);

   rpyLow += 10;
   Move(rp, RPX_LOWER, rpyLow);

   /*------------ Draws -------------*/
   strcpy(ScoreStr, IntToStr2(GameStats.draws));
   Text(rp, "Draws         = ", 16);
   Text(rp, ScoreStr, 2);

   /*------------ Games --------------*/
   Move(rp, RPXR_LOWER, rpyLow);
   strcpy(ScoreStr, IntToStr2(GameStats.games));
   Text(rp, "Games            = ", 19);
   Text(rp, ScoreStr, 2);

   /*------------ Burns -------------*/
   rpyLow += 10;
   Move(rp, RPX_LOWER, rpyLow);
   strcpy(ScoreStr, IntToStr2(GameStats.burns));
   Text(rp, "Your Burns    = ", 16);
   Text(rp, ScoreStr, 2);

   Move(rp, RPXR_LOWER, rpyLow);
   strcpy(ScoreStr, IntToStr2(GameStats.CompBurns));
   Text(rp, "Comp Burns       = ", 19);
   Text(rp, ScoreStr, 2);

   /*----------- Since Pontoon -------------*/
   rpyLow += 10;
   Move(rp, RPX_LOWER, rpyLow);
   strcpy(ScoreStr, IntToStr2(GameStats.SincePont));
   Text(rp, "Since Pontoon = ", 16);
   Text(rp, ScoreStr, 2);

   Move(rp, RPXR_LOWER, rpyLow);
   strcpy(ScoreStr, IntToStr2(GameStats.CompSincePont));
   Text(rp, "Comp Since Pont  = ", 19);
   Text(rp, ScoreStr, 2);

   /*------------ Since Burn ------------*/
   rpyLow += 10;
   Move(rp, RPX_LOWER, rpyLow);
   strcpy(ScoreStr, IntToStr2(GameStats.SinceBurn));
   Text(rp, "Since Burn    = ", 16);
   Text(rp, ScoreStr, 2);

   Move(rp, RPXR_LOWER, rpyLow);
   strcpy(ScoreStr, IntToStr2(GameStats.CompSinceBurn));
   Text(rp, "Comp Since Burn  = ", 19);
   Text(rp, ScoreStr, 2);

   rpyLow += 10;
   Move(rp, RPX_LOWER, rpyLow);
   /*---------- Continue -------------*/
   Text(rp, "Click ", 6);
   SetAPen(rp, 3);
   Text(rp, "Play", 4);
   SetAPen(rp, 2);
   Text(rp, " to continue ...", 16);

   while (GetOption() != PLAY);
   ClearWinLower();
    
}

   
/********************************************************
* Play a single game.
******************************************/

BOOL PlayGame()
{

   CardPtr hand = NULL;   /* Pointer to first human's list */
   CardPtr CompHand = NULL; 

   int score;  /* Human score */
   int CompScore;
   enum UserOptions UserOption;
   char ScoreStr[3];
   BOOL RejectBurn = FALSE;
   
   rpyUp = RPY_UPPER;
   rpyLow = RPY_LOWER;

   GameStats.SinceBurn++;
   GameStats.CompSinceBurn++;

   hand = DealHand();
   DisplayHand(hand, RPX_UPPER);
   while (CalculateScore(hand) == BURN_VALUE && ! RejectBurn)
   {
      GameStats.SinceBurn = 0;

      Move(rp, RPX_LOWER, RPY_LOWER);
      Text(rp, "Click Burn if you wish to redeal", 32);
      rpyLow += 10;
      Move(rp, RPX_LOWER, rpyLow);
      Text(rp, "Click Play if you wish to continue.", 35);

      rpyLow += 10;  /* Comment - Burn or Play */
      Move(rp, RPX_LOWER, rpyLow);
      SetAPen(rp, 3);
      Text(rp, "Burn", 4);
      SetAPen(rp, 2);
      Text(rp, " or ", 4);
      SetAPen(rp, 3);
      Text(rp, "Play", 4);
      SetAPen(rp, 2);
      Text(rp, " ?", 2);

      do 
      {
         UserOption = GetOption();
         if (UserOption == BURN) /* Reject deal and redeal */
         {
            GameStats.burns++;   /* This must be in here to ensure that it */
                                 /* is only incremented once. */
            hand = FreeList(hand);
            hand = DealHand();
            ClearWinUpper();
            DisplayHand(hand, RPX_UPPER);
         }
         else if (UserOption == PLAY)
         {
            RejectBurn = TRUE;
            GameStats.burns++;   /* This must be in here to ensure that it */
                                 /* is only incremented once. */
         }
      } while (UserOption != PLAY && UserOption != BURN);
      ClearWinLower();     /* Clear display */
   }

   do 
   {
      Move(rp, RPX_LOWER, rpyLow);
      SetAPen(rp, 3);
      Text(rp, "Stick", 5);
      SetAPen(rp, 2);
      Text(rp, " or ", 4);
      SetAPen(rp, 3);
      Text(rp, "Twist", 5);
      SetAPen(rp, 2);
      Text(rp, " ?", 2);
      UserOption = GetOption();   /* Stick, Twist, Play, StatO or Quit ? */

      if (UserOption == TWIST) 
      {
         hand = DealCard(hand);
         ClearWinUpper();
         DisplayHand(hand, RPX_UPPER);
      }

      else if (UserOption == STATO) /* Print out the stats */
         statO();

      else if (UserOption == QUIT)  /* Quit the program */
      {
         hand = FreeList(hand);
         CompHand = FreeList(CompHand);
         return TRUE;
      }

   } while (UserOption != STICK && ! isbust(CalculateScore(hand)));

   /*                      */
   /* Play computer's game */
   /*                      */

   CompHand = DealHand();  /* deal computer's hand */
   CompScore = CalculateScore(CompHand);
   while (CompScore == BURN_VALUE)
   {
      CompHand = FreeList(CompHand); /* Reject deal and redeal */
      CompHand = DealHand();
      CompScore = CalculateScore(CompHand);
      GameStats.CompBurns++;
      GameStats.CompSinceBurn = 0;
   }

   while (CompScore < COMP_STICK)
   {
      CompHand = DealCard(CompHand);
      CompScore = CalculateScore(CompHand);
   }

   rpyUp = RPY_UPPER;
   DisplayHand(CompHand, RPXR_UPPER);

   score = CalculateScore(hand);

   GameStats.games++;
   GameStats.SincePont++;
   GameStats.CompSincePont++;

   /*                                          */
   /* Print out the vital stats at the end :-) */
   /*                                          */

   rpyLow = RPY_LOWER;
   Move(rp, RPX_LOWER, rpyLow);

   if (CompScore == PONTOON && score == PONTOON)
   {
      Text(rp, "We both have Pontoons, Cool.", 28);
      GameStats.ponts++;
      GameStats.CompPonts++;
      GameStats.draws++;
      GameStats.SincePont = 0;
      GameStats.CompSincePont = 0;
   }

   else if (CompScore == PONTOON)
   {
      Text(rp, "Pontoon, Computer wins", 22);
      GameStats.CompPonts++;
      GameStats.CompWins++;
      if (isbust(score))      /* Cant let user get away with a bust if  */
         GameStats.busts++;   /* the computer gets a pontoon.           */
      GameStats.CompSincePont = 0;
   }


   else if (score == PONTOON)
   {
      Text(rp, "Pontoon, You win.", 17);
      GameStats.ponts++;
      GameStats.wins++;
      if (isbust(CompScore))      /* Cant let the computer get awat with a */
         GameStats.CompBusts++;   /* bust if the user gets a pontoon.      */
      GameStats.SincePont = 0;
   }


   else if (isbust(score) && isbust(CompScore))
   {
      Text(rp, "We are both bust, a draw ...", 28);
      GameStats.draws++;
      GameStats.busts++;
      GameStats.CompBusts++;
   }

   else if (isbust(CompScore))
   {
      Text(rp, "Computer is bust, you win ...", 29);
      GameStats.CompBusts++;
      GameStats.wins++;
   }

   else if (isbust(score))
   {
      Text(rp, "You are bust, Computer wins ..", 30);
      GameStats.busts++;
      GameStats.CompWins++;
   }

   else if (CompScore > score)
   {
      Text(rp, "Computer wins ...", 17);
      GameStats.CompWins++;
   }

   else if (CompScore < score)
   {
      Text(rp, "You win ...     ", 16);
      GameStats.wins++;
   }

   else
   {
      Text(rp, "It's a draw ... ", 16);
      GameStats.draws++;
   }


   rpyLow += 10;
   Move(rp, RPX_LOWER, rpyLow);
   strcpy(ScoreStr, IntToStr2(score));
   Text(rp, "Your Score     = ", 17);
   Text(rp, ScoreStr, 2);

   rpyLow += 10;
   Move(rp, RPX_LOWER, rpyLow);
   strcpy(ScoreStr, IntToStr2(CompScore));
   Text(rp, "Computer Score = ", 17);
   Text(rp, ScoreStr, 2);

   rpyLow += 10;
   do {

   Move(rp, RPX_LOWER, rpyLow);
   SetAPen(rp, 3);         /* comment - Play or quit */
   Text(rp, "Play", 4);
   SetAPen(rp, 2);
   Text(rp, " or ", 4);
   SetAPen(rp, 3);
   Text(rp, "Quit", 4);
   SetAPen(rp, 2);
   Text(rp, " ?", 2);

   UserOption = GetOption();

   if (UserOption == STATO)
   {                          /* Give user the chance to check the     */
      statO();   /* stats, Supplied by the reliable StatO */
      ClearWinLower();
   }
      /*----------- Congrats -----------*/
      /*        The race to 99 :-)      */

   if (! RaceOver && (GameStats.wins == 99 || GameStats.CompWins == 99))
   {
      RaceOver = TRUE;
      ClearWinLower();
      SetAPen(rp, 2);
      if (GameStats.wins > GameStats.CompWins)
         Text(rp, "Congtatulations, you won", 24);
      else
         Text(rp, "Hard luck, the Computer won", 27);

      rpyLow += 10;
      Move(rp, RPX_LOWER, rpyLow);
      if (GameStats.wins > GameStats.CompWins)
         Text(rp, "the race to 99, Well done.", 26);
      else
         Text(rp, "the race to 99, Nice try.", 25);

      /*--- Wait for user to click PLAY ---*/
      rpyLow += 10;
      Move(rp, RPX_LOWER, rpyLow);
      Text(rp, "Click ", 6);
      SetAPen(rp, 3);
      Text(rp, "Play", 4);
      SetAPen(rp, 2);
      Text(rp, " to continue ...", 16);
      while (GetOption() != PLAY);
      ClearWinLower();
   }

   } while (UserOption != PLAY && UserOption != QUIT);

   hand = FreeList(hand);          /* Release memory */
   CompHand = FreeList(CompHand);

   if (UserOption == QUIT)
      return TRUE;
   else {
      ClearWinLower();
      ClearWinUpper();
      return FALSE;
   }  

}

/* ---------------------------------------------------- *\
**                 THATS ALL FOLKS !!!!                 **
\* ---------------------------------------------------- */


