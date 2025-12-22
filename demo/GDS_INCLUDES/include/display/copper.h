#ifndef GS_USERCOPPER
#define GS_USERCOPPER

struct copper_struct
  {
  unsigned short *list;       /* pointer to list of copper instructions */
  void *copctrl;              /* ptr to controlling struct for user copper lists (UCopList) */
                              /* This is NULL for 1st call & alloced by copper routines */
                              /* Additional calls to copper routines use same struct */
  void *display;              /* ptr to controlling display struct.  This will be either */
  };                          /* an Intuition Screen struct or a ViewPort struct */

/* user copper instructions: */

#define UC_WAIT         1     /* wait for display beam position (y,x) */
#define UC_MOVE         2     /* move data to a hardware register (register,data) */
#define UC_NOSPRITES    3     /* turn sprites off */
#define UC_SPRITES      4     /* turn sprites back on */
#define UC_SETCOLOR     5     /* set a color register (color number,color value) */
#define UC_END          0     /* marks end of copper list.  MUST be last command in table */

#define UCFLAGS_INTUITION  0x01  /* attach copper list to Intuition screen */
#define UCFLAGS_VIEWPORT   0x02  /* attach copper list to custom ViewPort */

#endif
