/* Prototypes for functions defined in
Sound2.c
 */

extern long BUFSIZE;

extern struct DiskObject * infofile;

extern struct IOAudio * sound[4];

extern struct Filehandle * sFile;

extern struct FileLock * lock;

extern struct FileLock * savelock;

extern long sactual;

extern long sstart;

extern long vol;

extern long fade;

extern long sps;

extern long cycles;

extern long startvol;

extern long endvol;

extern long fadevol;

extern short k;

extern short stereo;

extern short left;

extern short right;

extern short compflag;

extern short statusline;

extern short direct;

extern UBYTE sunit[4];

extern UBYTE sunitL[2];

extern UBYTE sunitR[2];

extern BOOL help;

extern char * sbuffer;

extern char title[108];

extern char * cbuf[4];

extern char sname[108];

extern char * portname[4];

extern char comptable[16];

extern short svol;

void snd_quit(char * );

void cleanup(char * );

void doSound(char * , short );

char * SafeAllocMem(long , long );

short decomp(char * , long , long , short );

void loadSound(char * );

void soundSound(void);

char * ltoa(long );

