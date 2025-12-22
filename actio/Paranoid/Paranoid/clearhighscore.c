#include <libraries/dosextens.h>

struct HighScore
{
 short punkte;
 char name[30];
};
struct HighScore highscore[10];
char dname[]="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
short dscore=500;
struct FileHandle *fh,*Open();

main()
{
 long loop;
 
 for (loop=0l;loop<10l;loop++)
 {
  highscore[loop].punkte=dscore;
  dscore-=50;
  strcpy (highscore[loop].name,dname);
 }
 if (!(fh=Open ("Paranoid:highscore",1006l)))
 { printf ("Schreibfehler\n"); exit(); }
 Write (fh,highscore,320l);
 Close (fh);
}
