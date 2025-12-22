#ifndef _COMMUNIC_H
#define _COMMUNIC_H

#include <stdio.h>
#include <stdlib.h>

#include "case.h"

/* communication */


/* structures de bas niveau */
typedef char Msg[128];

typedef struct {
  int pfd_a[2];
  int pfd_b[2];
  int length;
  int verbose;
  FILE *to_gnugo_stream, *from_gnugo_stream;
} ComPipe;

ComPipe *com_pipe_new ();

/* buffer (char*) x de tailles 128 */
void TELL_GNUGO(ComPipe *com, Msg x);
void ASK_GNUGO(ComPipe *com, Msg x);

char *getMessageIn (char *s);

/* fonction de haut niveau */
int getCouleurDansGG (Case c, ComPipe *pipe);


#endif
