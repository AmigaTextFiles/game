#ifndef GS_UTILITYREG
#define GS_UTILITYREG

unsigned short __asm _gs_random(register __d0 int);   /* random number from 0 to int */

/* -------------------------------------------------------------------- */

int __asm _gs_task_prio(register __d0 int);           /* set task priority */

/* -------------------------------------------------------------------- */

void __asm _gs_LEDon(void);
void __asm _gs_LEDoff(void);

/* -------------------------------------------------------------------- */

void __asm _gs_init_vector(register __d2 int,register __a0 int,
  register __a1 int,register __d0 int,register __d1 int);

/* -------------------------------------------------------------------- */

__asm struct Interrupt *_gs_add_vb_server(register __a0 void *,register __d0 int);
__asm void _gs_remove_vb_server(register __a1 struct Interrupt *);

/* -------------------------------------------------------------------- */

int __asm _gs_version(void);

#endif
