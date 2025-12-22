#ifndef GS_GFXPROTO
#define GS_GFXPROTO

int gs_plot(struct BitMap *,int,int,int);  /* bitmap ptr, X coord, Y coord, color number */
int gs_plot_reverse(struct BitMap *,int,int);  /* bitmap ptr, X coord, Y coord */
int gs_plot_test(struct BitMap *,int,int); /* bitmap ptr, X coord, Y coord */

/* -------------------------------------------------------------------- */

struct BitMap *gs_get_bitmap(unsigned long,unsigned long,unsigned long,unsigned long);
void gs_free_bitmap(struct BitMap *);

#endif
