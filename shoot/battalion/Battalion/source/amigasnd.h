/* Amiga Sound Interface for Battalion */
/* Written by Frank Wille <frank@phoenix.owl.de> in 1999 */


struct SoundInfo {
  UBYTE *data;      /* converted data in Chip-RAM */
  ULONG length;     /* must be an even number */
  UWORD period;     /* playback period = system-clock / frequency */
  UBYTE loaded;     /* 1, when loaded */
  UBYTE reserved;
};


int amigasnd_init(void);
void amigasnd_exit(void);
void amigasnd_loadau(struct SoundInfo *,char *);
void amigasnd_free(struct SoundInfo *);
void amigasnd_play(struct SoundInfo *,int);
int amigasnd_getchannels(void);
