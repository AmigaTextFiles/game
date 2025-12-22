#ifndef GS_UTILITY
#define GS_UTILITY

unsigned short gs_random(int);   /* random number from 0 to int */

/* -------------------------------------------------------------------- */

int gs_task_prio(int);           /* set task priority */

/* -------------------------------------------------------------------- */

int gs_file_requestor(struct Screen *,char *,char *,char *,char *,int);

/* -------------------------------------------------------------------- */

void gs_LEDon(void);             /* audio filter on */
void gs_LEDoff(void);            /* audio filter off */

/* -------------------------------------------------------------------- */

void gs_init_vector(int,int,int,int,int);  /* vector number,start X,start Y,end X,end Y */
int gs_step_vector(int,int,int *,int *);   /* vector number,step amount, X ptr, Y ptr */
int gs_ustep_vector(int,int,int *,int *);  /* vector number,step amount, X ptr, Y ptr */

/* -------------------------------------------------------------------- */

struct Interrupt *gs_add_vb_server(void *,int);
void gs_remove_vb_server(struct Interrupt *);

/* -------------------------------------------------------------------- */

int gs_version(void);            /* get GameSmith library version */

#endif
