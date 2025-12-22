#include <proto/intuition.h>
#include <proto/graphics.h>
#include <proto/exec.h>

#include <libraries/mui.h>


#define MADMATRIX_TAILLE_MAX 6

/* I know this is ugly ( random values...) */
#define MADMATRIX_TAILLE 566774
#define MADMATRIX_GROUPE 566775

#define MADMATRIX_SHAKE 257180
#define MADMATRIX_RESTART 257181

struct Madmatrix_Data
{
  int taille;
  int ntaille;

  int **matrice;
  int ligne,colonne;

  int font_sx, font_sy;

  Object *groupe;

  int shaking; /* 0 ou 1 */
  int shaked; /* 0 ou 1 */

  int mouvement; /* -1,0 ou 1 */
  double pas;

  int box; /* -1 0 ou 1 */

  char *message;

  struct MsgPort     *port;
  struct timerequest timer_io;
  int timer_ok;
};

#ifndef __MORPHOS__
ULONG __attribute__((regparm(3))) Madmatrix_Dispatcher(struct IClass *cl , void *msg,Object *obj  );
#else
extern struct EmulLibEntry Madmatrix_Dispatcher;
#endif

