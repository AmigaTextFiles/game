#include <exec/exec.h>
#include <devices/narrator.h>

struct MsgPort       *dport,*CreatePort();
struct narrator_rb   *dmsg,*CreateExtIO();

char *TranslatorBase,*OpenLibrary();
char quelle[150];
char ziel[1000];
UBYTE maske[]= { 9,9,9,9 };

main ()
{
 long loop;
 TranslatorBase=OpenLibrary("translator.library",0l);
 if (!(TranslatorBase)) 
 { printf ("urgh\n"); exit();}
 if (!(dport=CreatePort(0l,0l))) 
 { exit (FALSE); printf ("Port failed\n");}
 if (!(dmsg=CreateExtIO(dport,(long) sizeof (struct narrator_rb))))
 { printf ("IO failed\n"); exit (FALSE);}
 if (OpenDevice("narrator.device",0l,dmsg,0l)) 
 { exit (FALSE); printf ("Device failed\n");}
 while (1)
 {
  printf ("Eingabe:");
  gets (quelle);
  if (quelle[0]==0) break; 
  Translate (quelle,strlen (quelle)+1l,ziel,1000l);
  printf ("%s\n",ziel); 
  (dmsg->message).io_Command=CMD_WRITE;
  (dmsg->message).io_Data=(APTR) ziel; 
  (dmsg->message).io_Length=(long) (strlen(ziel)+1);
  dmsg->ch_masks=maske;
  dmsg->nm_masks=4;
  DoIO (dmsg);
 }
 CloseLibrary (TranslatorBase);
 CloseDevice  (dmsg);
 DeleteExtIO  (dmsg,(long) sizeof (struct narrator_rb));
 DeletePort   (dport);
}

