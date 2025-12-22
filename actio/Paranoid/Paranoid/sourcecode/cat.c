#include <devices/trackdisk.h>
#include <libraries/dosextens.h>
#include <exec/memory.h>

/* Allgemein verwendete Extern-Variablen */
struct MsgPort  *dport,*CreatePort();
struct IOStdReq *dmsg,*CreateStdIO();
ULONG root[130],buffer[130],store[130];/* Store NUR fuer ReadBlock()*/
UBYTE cache[100][520];
ULONG bcount=0l,wb[84],parent=880l,pfnd=1l;
ULONG filezahl=0l,bytezahl=0l,GetHash(),GetParent();
struct FileInfoBlock *block,*AllocMem();
struct FileLock *Lock(),*lock;
struct CommandLineInterface *cli;
struct Process *proc,*FindTask();
UBYTE dpath[2][300];

/* main liest die Parameter und verzweigt in die jeweiligen Unterprogramme*/
main (argc,argv)
SHORT argc;
UBYTE *argv[];
{
 ULONG loop=10l,block;
 char proz='%';
 strcpy (dpath[0],argv[0]); strcpy(dpath[1],argv[1]);
 if (argc==1) { FindPath(); argc=2; }
 if ((argc>1l)&&(toupper(dpath[1][0])=='D')&&(toupper(dpath[1][1])=='F')&&
     (dpath[1][3]==':')&&(dpath[1][2]-48<4))
 loop=(long)(dpath[1][2])-48l;   /* Fall 1:Laufwerk [+Pfad] */

 if ((argc>1)&&(dpath[1][0]=='#')) 
 { loop=GetParent (dpath[1]); argc=0; } /* Fall 1.1:Laufwerk [+Block] */

 if ((argc>1)&&(dpath[1][0]=='?')) catinfo(); /* Fall 1.2 :Anleitung */

 if ((loop==10l)&&(argc>1))    /* Fall 2:Device   [+Pfad] */
 { 
  if (!(lock=Lock (dpath[1],ACCESS_READ))) { printf ("No Lock\n"); exit();} 
  exdir(); 
 }
 if (!(dport=CreatePort(0l,0l))) exit (FALSE);
 if (!(dmsg=CreateStdIO(dport))) exit (FALSE);
 if (OpenDevice("trackdisk.device",loop,dmsg,0l))
 {printf ("Laufwerk nicht vorhanden!\n"); exit (FALSE);}
 if (argc>1) ChDir (&(dpath[1][4])); pfnd=0l; /* flag fuer DIR gefunden */
 ReadBlock (dmsg,parent,root);
 if ((*root!=2l)||((root[127]!=2l)&&(root[127]!=1l)))
 { printf ("Block %lu ist kein Directoryblock\n",parent); finish(); }
 for (loop=6l;loop<=77l;loop++)
 {
  if (root[loop]==0l) continue;
  else block=root[loop];
  do
  {
   ReadBlock (dmsg,block,buffer);
   HandleBlock (buffer);
   block=buffer[124];
  } while (block);
 }
 printf ("%lu Eintraege - %lu bytes\n",filezahl,bytezahl);
 printf ("%lu%c des Caches wurden gebraucht.\n",bcount,proz);
 finish();
}
/**************************************************************************
 *  Dieses Unterprogramm liest einen gewuenschten Block ein.              *
 *  Zu parent gehoerige Header-Bloecke werden in einen Cache geschrieben  *
 *  Die Speicher cache und store duerfen sonst nicht benutzt werden,da    *
 *  sonst Verwirrungen entstehen.                                         *
 **************************************************************************/
ReadBlock (d,block,addr)
struct IOStdReq *d;
LONG block,*addr;
{
 ULONG start,end,loop;
 for (loop=0l;loop<bcount;loop++) 
 {
  if (wb[loop]==block) 
  { CopyMem (cache[loop],addr,512l); return (); }
 }
 d->io_Command=CMD_READ;
 d->io_Offset=512l*block;
 d->io_Length=512l;
 d->io_Data=(APTR) addr; 
 DoIO (d); 
 end=10l+(start=(block/11l)*11l);
 for (loop=start;loop<=end;loop++)
 {
  d->io_Command=CMD_READ;
  d->io_Offset=512l*loop;
  d->io_Length=512l;
  d->io_Data=(APTR) store; 
  DoIO (d); 
  if ((block!=loop)&&(store[0]==2l)&&((store[125]==parent)||(pfnd)))
  { CopyMem (store,cache[bcount],512l); wb[bcount++]=loop; }
 if (bcount>99l) { printf ("Cache voll\n"); finish(); }
 }
}

/* Ausgabe eines Header-Blockes */
HandleBlock (buffer)
ULONG *buffer;
{
 if (buffer[80]<<28) printf ("*");
 else printf (" ");
 bcprint (&(buffer[108]));  
 printf ("\r\233\63\62\103");
 if (buffer[127]==-3l)
 printf ("%6lu ",buffer[81]);
 else printf (" (dir) ");
 if (!(buffer[126]))
 printf ("BC:%2lu ",buffer[2]);
 else printf ("BC:?? ");
 printf ("HB:%4lu ",buffer[1]);
 printf ("DS:%4lu ",buffer[4]);
 bcprint(&(buffer[82]));
 printf ("\n");
 filezahl++;bytezahl+=buffer[81];
}

ChDir (addr)
UBYTE *addr;
{
 UBYTE path[50],*pointer;
 ULONG loop,block;
 if (!(*addr)) return();
 for (loop=0l;(*addr!='/')&&(*addr);loop++)
 path[loop]=(UBYTE) toupper(*addr++);
 path[loop]=0;
 ReadBlock (dmsg,parent,buffer);
 block=GetHash(path);
 if (buffer[block]==0l) { printf ("\nPfad nicht gefunden!\n"); finish(); }
 block=buffer[block];
 do
 {
  ReadBlock (dmsg,block,buffer);
  if (buffer[0]!=2l) { printf ("\nProgramm Fehler 1!!!!\n"); finish(); }
  pointer=(UBYTE *) &(buffer[108]);  
  loop=(long)(*pointer++);
  parent=block;
  block=buffer[124];
  pointer[loop]=0;
  bigletter(pointer);
 } while ((strcmp(path,pointer)!=0)&&(block));
 loop=buffer[127];
 if ((strcmp(path,pointer))&&(block==0l))
 { printf ("\nPfad nicht gefunden.\n"); finish(); }
 if (loop!=2l)
 { printf ("\nDateien gehoeren nicht in den Pfad!\n"); finish(); }
 ChDir(++addr);
}
/************************************************************************
 * GetParent () setzt das aktuelle Unterverzeichnis auf den angegebenen *
 * Wert.                                                                *
 ************************************************************************/
ULONG GetParent (addr)
UBYTE *addr;
{
 ULONG drive=0l,mult=1l,block=0l;
 while (*(++addr)=='#') drive++;
 if (!(*addr)) return (drive);
 turn (addr);
 do
 {
  block+=mult*(ULONG)((*addr)-48);
  mult*=10l;
 } while ((mult<=1000l)&&(*(++addr)));
 if (block>1759l){printf("%lu ist keine gueltige Blockzahl\n",block); exit();}
 parent=block;
 return(drive);
}
/* Diese Funktion stoppt den Laufwerksmotor und beendet das Programm */
finish()
{
 dmsg->io_Command=TD_MOTOR;
 dmsg->io_Length=0l;
 DoIO (dmsg);
 CloseDevice (dmsg);
 DeleteStdIO (dmsg);
 DeletePort (dport);
 exit();
}
/* Diese langsamere Variante ist fuer Devices und pfadlose
  Angaben zustaendig */
exdir()
{
 if (!(block=AllocMem (300l,MEMF_CLEAR|MEMF_CHIP)))
 { printf ("Kein Speicher (Gleich koennen Sie meditieren.\n"); exit();}
 if (!(Examine (lock,block))) { printf ("Exa err\n"); exit(); }
 while (ExNext (lock,block)) 
 {
  if ((block->fib_Protection)<<28) printf ("*");
  else printf (" "); 
  printf ("%s\266\r\233\63\62\103",block->fib_FileName);
  if (block->fib_DirEntryType>=0l) printf ("  (dir)");
  else printf (" %6lu",block->fib_Size);
  printf (" BC:%4lu ",block->fib_NumBlocks);
  printf (":%s\266\n",block->fib_Comment);
  filezahl++; bytezahl+=block->fib_Size;
 }
 printf ("%lu Eintraege - %lu bytes\n",filezahl,bytezahl);
 printf ("Der cache wurde nicht benutzt.\n");
 UnLock (lock);
 exit();
}
/***********************************************************************
 *    FindPath () sucht bei angabenlosen Aufrufen den Pfad und ent-    *
 *    scheidet,ob die schnelle oder langsame Routine genommen wird.    *
 ***********************************************************************/
FindPath ()
{
 UBYTE *addr;
 ULONG loop,loop2=0l;
 if (!(proc=FindTask (0l))) { printf ("No Task found\n"); exit(); }
 cli=(struct CommandLineInterface *)BADDR(proc->pr_CLI);
 addr=(UBYTE *)BADDR (cli->cli_SetName);
 for (loop=(ULONG)*addr++;loop2<loop;loop2++) dpath[1][loop2]=*addr++;
 dpath[1][loop2]=0;
 printf ("Pfad:%s\n",dpath[1]);
}
/***********************************************************
 *    catinfo() gibt eine kurze Erklaerung aus             *
 ***********************************************************/
catinfo()
{
 printf ("\233\61;32;40mCat V1.5 von \233\64;33;40mFelix Wente\n");
 printf ("\233\60;31;40mUsage:cat [dfx:[Pfad]][n*#[Block]][Pfad]\n");
 printf ("Feel free to copy the program (for non-commerial use only!)\n");
 exit();
}
/***********************************************************************
*  Hier stehen folgende Hilfsroutinen:                                 *
*  bigletter() wandelt eine Zeichenkette in Grossbuchstaben um         *
*  bcprint  () gibt einen BCPL-String aus (mit C-Adresse !!!!)         *
*  GetHash  () berechnet den Hashwert einer Zeichenkette               *
*  turn     () dreht eine Zeichenkette um                              *
************************************************************************/
bigletter (addr)
char *addr;
{
 short sicherung=0;
 while ((*addr)!=0)
 {
  *addr=toupper(*addr);
  sicherung++;addr++;
  if (sicherung>=30) { printf ("Da ging was schief\n"); exit(); }
 } 
}
bcprint (addr)
char *addr;
{
 short schleife;
 for (schleife=1;schleife<=(short)*addr;schleife++)
 {
  if ((addr[schleife]>31)&&(addr[schleife]<128))
  printf ("%c",addr[schleife]);
  else  printf ("#");
 }
 printf ("\266");
}
ULONG GetHash (addr)
UBYTE *addr;
{
 ULONG laenge,hash;
 laenge=(ULONG)(strlen(addr));
 for (hash=laenge;laenge--;)
  hash=((hash*13l+toupper(*addr++))&0x7ffl);
 return ((LONG)(hash%72l+6l));
}
turn(string)
char *string;
{
 char *start=string,help;
 while (*++string); while (start<=--string)
 { help=*start; *start++=*string; *string=help; }
}