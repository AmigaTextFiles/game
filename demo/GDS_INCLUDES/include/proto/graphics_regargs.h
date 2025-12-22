#ifndef GS_GFXREGPROTO
#define GS_GFXREGPROTO

int __asm _gs_plot(register __a0 struct BitMap *,register __d0 int,
  register __d1 int,register __d1 int);
int __asm _gs_plot_reverse(register __a0 struct BitMap *,register __d0 int,
  register __d1 int);
int __asm _gs_plot_test(register __a0 struct BitMap *,register __d0 int,
	register __d1 int);

#endif
