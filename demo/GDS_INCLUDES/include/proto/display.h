#ifndef GS_DISPLAYPROTO
#define GS_DISPLAYPROTO

struct display_struct *gs_display(int,int,int,int,int,unsigned long *);
int gs_create_display(struct display_struct *);
void gs_show_display(struct display_struct *,int);
void gs_flip_display(struct display_struct *,int);
int gs_scroll_vp(struct display_struct *,int,int,int,int);
int gs_scroll_vp_pf1(struct display_struct *,int,int,int,int);
int gs_scroll_vp_pf2(struct display_struct *,int,int,int,int);
void gs_old_display(struct display_struct *);
void gs_remove_display(struct display_struct *);
int gs_scan_copper(struct display_struct *);
int gs_LoadRGB(struct display_struct *,int,unsigned long *);
int gs_SetRGB(struct display_struct *,int,int,unsigned long);

/* -------------------------------------------------------------------- */

int gs_user_copper(struct copper_struct *,unsigned long);

#endif
