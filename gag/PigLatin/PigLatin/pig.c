#include "exec/types.h"               /*Filename: pig.c                  */
#include "lattice/stdio.h"
#include "lattice/ctype.h"            /* Copyright March, 1986 by        */
#include "libraries/translator.h"     /* Thomas W. Clement.              */
#include "devices/narrator.h"         /* Licence is hereby given for     */
#include "exec/exec.h"                /* the non-commercial use and      */
#include "exec/nodes.h"               /* duplication of all or part of   */
#include "exec/memory.h"              /* this program, expressly         */
#include "exec/interrupts.h"          /* conditioned, however, upon the  */
#include "exec/ports.h"               /* inclusion of this copyright     */
#include "exec/libraries.h"           /* notice and licencing agreement  */
#include "exec/io.h"                  /* in any copy made.               */
#include "exec/execbase.h"

#define REVISION 1

struct   MsgPort     *writeport      = 0;      /* Write reply port.       */
struct   narrator_rb *writeNarrator  = 0;      /* Pointer to IORB.        */
struct   Library     *TranslatorBase = 0;      /* Ptr to Translator fn.   */

extern   struct   MsgPort   *CreatePort();     /* External functions      */
extern   struct   Library   *OpenLibrary();    /* are declared here.      */

char  obuff[1024];                     /* Buffer sent to translate device.*/
char  phonemeBuff[2048];               /* Buffer for translated string.   */
char  *pobuff;                         /* Pointer to obuff.               */

int   error;                           /* Error code.                     */

UWORD Rate     = 100;                  /* Rate of speaking voice. (Slower */
                                       /* than usual default value.)      */
UWORD Pitch    = DEFPITCH;             /* Pitch of speaking voice. (110)  */
UWORD Sex      = DEFSEX;               /* Sex of speaking voice.  (Male)  */
UWORD Mode     = DEFMODE;              /* Mode of voice.       (Natural)  */
UWORD Sampfreq = 25000;                /* Sampling freq. (A bit higher.)  */

char  audChanMasks[4] = { 3, 5, 10, 12 };      /* Audio chan. allocation  */
                                               /* map. see ch 12 ROM K.M. */

/*    This program accepts characters from stdin until a ".", "!", or "?" is
*     seen, then prints the piglatin equivalent to standard output and
*     uses the AMIGA's speaking abilities to say the piglatin equivalent.
*/

main()
{
      /* Main() assembles characters into words which are passed on to
      *  pig() for conversion into pig latin.  An imbedded apostrophe
      *  is considered a part of the word.  When a sentence is assembled,
      *  it is passed on to sayit() for enunciation.
      */

      char  wbuff[64];                    /* Single word buffer.        */
      char  *pwbuff;                      /* Pointer to wbuff.          */
      int   c;                            /* Current character.         */
      int   nopig = 0;                    /* Flag for regular speech.   */
      void  setup_speech();               /* Declare function.          */
      void  cleanup();                    /* Declare cleanup function.  */
      void  set_voice();                  /* Declare voice specifier.   */

      pobuff = obuff;                     /* Initialize pobuff.         */

      printf( "Do you want to set voice characteristics? ( y or n ): " );
      gets( wbuff );
      if( *wbuff == 'y' || *wbuff == 'Y' )
      {
         set_voice();                     /* Routine to change voice.   */
      }

      printf( "Piglatin or regular speech? ( 'p' or 'r' ) :" );
      gets( wbuff );
      if( *wbuff == 'r' || *wbuff == 'R' )
      {
         nopig = -1;                      /* Set flag for normal speech.*/
      }

      setup_speech();                     /* Initialize speech stuff.   */

      printf( "Enter sentences ending with \".\", \"!\" or \"?\".\n" );

      wbuff[0] = '\0';                    /* Buffer starts at wbuff[1]. */
      c = getchar();                      /* Get first character.       */

      while( c != EOF )                   /* Exit cleanly on EOF.       */
      {
         if( Chk_Abort() )                /* Exit cleanly on ^C or ^D.  */
         {
            printf( "** Break **\n" );    /* Announce break on ^C or ^D.*/
            break;                        /* Gets to cleanup routines.  */
         }
         pwbuff = wbuff + 1;              /* Pointer to 1st wbuff char. */
         if( !isalpha(c) )                /* Skip all non-alphabetics.  */
         {
            *pobuff++ = c;                /* Add the character to obuff.*/

            if( c == '.' | c == '?' | c == '!' )   /* End of sentence?  */
            {
               *pobuff = '\0';            /* Null terminate obuff.      */

               if( !nopig )
               {
                  printf("%s\n", obuff);  /* Print what's in the buffer.*/
               }
               sayit();                   /* Call speech routine.       */
               pobuff = obuff;            /* Reset output buffer ptr.   */
            }
            c = getchar();                /* Update current character.  */
         }
         else                             /* Collect & pass word to pig.*/
         {

            while( isalpha(c) || c == '\'' )
            {
               *pwbuff++ = c;             /* Word - alphabetic chars &   */
               c = getchar();             /* imbedded apostrophes.       */
            }
            *pwbuff = '\0';               /* Terminate word w/ null.     */

            if( nopig )
            {
               strcpy( pobuff, wbuff + 1 );          /* Copy word to     */
               pobuff += pwbuff - ( wbuff + 1 );     /* obuff w/o change.*/
            }
            else
            {
               pig( wbuff + 1 );          /* Sooeey.   ( Call pig. )    */
            }
         }
      }
      cleanup();                          /* Close devices,ports, libs. */
      exit( 0 );
}


pig( word )
char  *word;
{
      /* Pig() takes a pointer to a word passed from main(), and assembles
      *  the pig latin equivalent.
      */

      char  *sword = word;                /* Pointer to word.            */
      int   length;                       /* Length of string.           */

      if( *( sword + 1 ) == '\0' )        /* Don't change single letter  */
      {                                   /* words.                      */
         *pobuff++ = *sword;                     /* Add to output buff.  */
         if( *sword == 'a' || *sword == 'A' )    /* Add more if word was */
         {                                       /* "A" or "a"-- make it */
            (void)strcpy( pobuff, "n-yay" );     /* "an-yay". (The next  */
            pobuff += 5;                         /* word will start with */
         }                                       /* a vowel.)            */
      }
      else if( isvowel( sword ) )         /* If it begins with a vowel   */
      {                                   /* pigword is word with "yay"  */
         length = strlen( word );         /* added to the end.           */
         (void)strcpy( pobuff, word );    /* Copy word to obuff.         */
         pobuff += length;                /* Advance pobuff.             */
         (void)strcpy( pobuff, "-yay" );  /* Copy "-yay" to obuff.       */
         pobuff += 4;                     /* Advance pobuff.             */
      }
      else                                /* Consonant starts a word.    */
      {
         while( !isvowel( sword ) && *sword != '\0' )  /* Find 1st vowel */
         {                                             /* or word end.   */
            ++sword;
         }

         if( *sword == '\0' )              /* If there are no vowels in  */
         {                                 /* the word, don't change it. */
            length = strlen( word );
            (void)strcpy( pobuff, word );  /* Copy the word to obuff.    */
            pobuff += length;              /* Advance pobuff.            */
         }
         else
         {
            if( isupper( *word ) )         /* If upper case,             */
            {
               *word += 32;                /* change to lower case, and  */
               *sword = toupper( *sword ); /* change new 1st lett to UC. */
            }
            length = strlen( sword );      /* Get length of substring.   */
            (void)strcpy( pobuff, sword ); /* Copy it to obuff.          */
            pobuff += length;              /* Advance pobuff.            */
            *pobuff++ = '-';               /* Add a hyphen for clarity.  */
            *sword = '\0';                 /* Terminate consonant part.  */
            length = strlen( word );       /* Get length of cons part.   */
            (void)strcpy( pobuff, word );  /* Copy cons part to obuff.   */
            pobuff += length;              /* Advance pobuff.            */
            (void)strcpy( pobuff, "ay" );  /* Add "ay" to the string.    */
            pobuff += 2;                   /* Advance pobuff.            */
         }
      }
}

isvowel( p )
char  *p;
{
      /* This routine returns true if the character is a vowel.
      *  For the purposes of this program, 'u' is not considered a
      *  vowel if it follows a 'q'.  'Y' is considered a vowel if it
      *  is followed by a consonant.  Notice that 'y' will be treated
      *  as a vowel in the program only where either:
      *     1. It starts a word and is followed by a consonant, or
      *     2. It is preceeded by a string of only consonants and is
      *        followed by a consonant.
      */

      char c;           /* Current character, ( pointer to by p ).      */

      if( ( c = tolower( *p ) ) == 'a' || c == 'e' || c == 'i' || c == 'o'
            || ( c == 'u' && tolower( *( p-1 ) ) != 'q' )
            || ( c == 'y' && !isvowel( p + 1 ) ) )
      {
         return 1;      /* Return true if a "vowel" as we define it.    */
      }
      return 0;         /* Otherwise return false. */
}


void  setup_speech()
{
   /* This function sets up the translator library and the speech device of
   *  the AMIGA.  If it fails for some reason, it trys to let you know why.
   */

   if((TranslatorBase = OpenLibrary("translator.library", REVISION)) == NULL)
   {
      printf( "Can't open Translator library.\n" );
      error = 1;
      cleanup();
   }

   if( ( writeport = CreatePort( 0, 0 ) ) == NULL )
   {
      printf( "CreatePort problems.\n" );
      error = 2;
      cleanup();
   }

   /* Note that memory is allocated directly, instead of using the
   *  function CreateExtIO().  This is because I couldn't find this
   *  function anywhere in my release.  Anyway, this seems to work O.K.
   *  so I suppose I can't complain.
   */
   if( ( writeNarrator = (struct narrator_rb *)AllocMem( sizeof(
        struct narrator_rb), MEMF_PUBLIC | MEMF_CLEAR  ) ) == NULL )
   {
      printf( "Can't allocate memory for writeNarrator IORB.\n" );
      error = 3;
      cleanup();
   }

   /* Specify the type of node in the linked list,  the priority of the
   *  message, and the address of the prot created with CreatePort().
   */
   writeNarrator->message.io_Message.mn_Node.ln_Type = NT_MESSAGE;
   writeNarrator->message.io_Message.mn_Node.ln_Pri  = 0;
   writeNarrator->message.io_Message.mn_ReplyPort    = writeport;

   writeNarrator->ch_masks = audChanMasks;           /* Audio channels.   */
   writeNarrator->nm_masks = sizeof( audChanMasks ); /* # of Audio chans. */
   writeNarrator->message.io_Command = CMD_WRITE;    /* Command for IO.   */

   if( OpenDevice( "narrator.device", 0, writeNarrator, 0 ) )
   {
      printf( "Can't open narrator device.\n" );
      error = 4;
      cleanup();
   }
   writeNarrator->rate     = Rate;             /* Set these values to the */
   writeNarrator->pitch    = Pitch;            /* defaults, or the user   */
   writeNarrator->sex      = Sex;              /* specified values if the */
   writeNarrator->mode     = Mode;             /* function set_voice was  */
   writeNarrator->sampfreq = Sampfreq;         /* called.                 */ 

   return;
}

void  cleanup()
{
   if( writeNarrator )                /* If the narrator device had been  */
   {                                  /* close it & free up memory.       */
      CloseDevice( writeNarrator );
      FreeMem( writeNarrator, sizeof( struct narrator_rb ) );
   }

   if( writeport )
   {                                           /* If the port had been    */
      DeletePort( writeport );                 /* created, delete it.     */
   }

   if( TranslatorBase )                        /* If the translator       */
   {                                           /* library had been opened,*/
      CloseLibrary( TranslatorBase );          /* close it.               */
   }

   if( error )                        /* Tell user what went wrong.       */
   {
      fprintf( stderr, "Error #%d, execution terminated.\n", error );
      exit( error );
   }
}


sayit()
{
   /* This function speaks the pig latin.  It translates the string in
   *  obuff, placing the result in phonemeBuff.  It then sets a couple
   *  of fields in the narrator IORB  (Input Output Request Block), and
   *  sends the phonemes into the ether.
   */

   if( Translate( obuff, pobuff-obuff, phonemeBuff, 2048 ) )
   {
      printf( "Translator output buffer overflow.\n" );
      error = 5;
      cleanup();
   }

   writeNarrator->message.io_Data   = (APTR)phonemeBuff;   /* Ph. source. */
   writeNarrator->message.io_Length = strlen(phonemeBuff); /* Length.     */

   if( DoIO( writeNarrator ) )
   {
      printf( "Can't perform DoIO.\n" );
      error = 6;
      cleanup();
   }
}

int   atoi(s)
char  *s;       /* This is a simple version of atoi suitable for our use. */
{               /* ( atoi changes a string into an integer ).             */
   int   n;

   for( n = 0; *s >= '0' && *s <= '9'; s++ )
   {
      n = 10 * n + *s - '0';
   }
   return( n );
}




void set_voice()
{
   char  answer[10];                            /* Char array for answers.*/

   printf( "Male or female? ( m or f ): " );
   gets( answer );
   if( *answer == 'f' || *answer == 'F' )
   {
      Sex = FEMALE;
   }

   printf( "How many words per minute? (40 to 400): " );
   gets( answer );
   if( *answer != '\0' )
   {
      Rate = atoi( answer );                    /* Convert answer to int. */
      Rate = max( Rate, MINRATE );              /* Make Rate >= minimum.  */
      Rate = min( Rate, MAXRATE );              /* Make Rate <= maximum.  */
   }

   printf( "What pitch speech? (65 to 320): " );
   gets( answer );
   if( *answer != '\0' )
   {
      Pitch = atoi( answer );                   /* Convt answer to int.   */
      Pitch = max( Pitch, MINPITCH );           /* Make Pitch >= minimum. */
      Pitch = min( Pitch, MAXPITCH );           /* Make Pitch <= maximum. */
   }

   printf( "What sampling frequency? ( 5000 to 28000 ): " );
   gets( answer );
   if( *answer != '\0' )
   {
      Sampfreq = atoi( answer );                /* Convt answer to int.  */
      Sampfreq = max( Sampfreq, MINFREQ );      /* Ensure that sampling  */
      Sampfreq = min( Sampfreq, MAXFREQ );      /* freq is w/in range.   */
   }

   printf( "What mode of speech? (Natural or Monotone): " );
   gets( answer );
   if ( *answer == 'M' || *answer == 'm' )
   {
      Mode = ROBOTICF0;                         /* Monotone voice.        */
   }
   return;
}



