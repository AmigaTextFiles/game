/*
 * MORTAR
 *
 * -- header for emulated unix functions missing from Amiga.
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1999 by Frank Wille, Eero Tamminen
 */

#include <stdlib.h>

struct stat {
  size_t st_size;
};

extern int init_amiga(void);

/* unix unistd.h & sys/time.h stuff */
extern void usleep(unsigned long timeout);
extern unsigned int sleep(unsigned int seconds);
extern int stat(char *name,struct stat *st);
extern int chdir(char *path);
extern void srandom(unsigned int x);
extern long random(void);

#define SRND(x) srandom(x)
#define RND(x) (random() % (x))
