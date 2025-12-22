#include "communic.h"
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

void error(const char *msg)
{
  fprintf(stderr, "goboss: %s\n", msg);
  abort();
}


ComPipe *com_pipe_new () {

  ComPipe *com = (ComPipe*)malloc (sizeof (ComPipe));

  com->length = 0;
  com->verbose = 0;

  if (pipe(com->pfd_a) == -1)
    error("can't open pipe a");
  if (pipe(com->pfd_b) == -1)
    error("can't open pipe b");
  switch(vfork()) {
  case -1:
    error("fork failed (try chopsticks)");
  case 0:
    /* Attach pipe a to stdin */
    if (dup2(com->pfd_a[0], 0) == -1)
      error("dup pfd_a[0] failed");
    /* attach pipe b to stdout" */
    if (dup2(com->pfd_b[1], 1) == -1)
      error("dup pfd_b[1] failed");
    execlp("gnugo", "gnugo", "--mode", "gtp", "--quiet", NULL);
    error("execlp failed");
  }
  /* We use stderr to communicate with the client since stdout is needed. */
  /* Attach pipe a to to_gnugo_stream  */
  com->to_gnugo_stream = fdopen(com->pfd_a[1], "w");
  /* Attach pipe b to from_gnugo_stream */
  com->from_gnugo_stream = fdopen(com->pfd_b[0], "r");

  return com;
}


void ASK_GNUGO(ComPipe *com, char *x) {

  do {
    if (!fgets(x, 128, com->from_gnugo_stream))
      error("can't get response");
    if (com->verbose)
      fprintf (stderr, "%s", x);
  } while (*x=='\n');
}


void TELL_GNUGO(ComPipe *com, char *x)

{
  if (com->verbose)
    fprintf(stderr, "%s", x);
  if (fprintf(com->to_gnugo_stream, "%s", x) < 0)
    error ("can't write command in to_gnugo_stream");
  fflush(com->to_gnugo_stream);
}


char *getMessageIn (char *s) {

  char *t;
  while (!isalpha(*s)) s++;
  t=s;
  while (t && (*t != '\n')) t++;
  *t = 0;
  return s;
}
