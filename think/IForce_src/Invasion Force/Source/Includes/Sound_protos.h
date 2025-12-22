/* Prototypes for functions defined in
Sound.c
 */

extern struct SoundData sdata[5];

extern struct IOAudio * sound[4];

extern UBYTE sunit[4];

extern BOOL device_open;

extern BOOL toggle;

extern unsigned short playflags;

void freeSounds(void);

char * SafeAllocMem(long , long );

void loadSound(char * , struct SoundData * );

void initSoundMem(void);

void playSound(int , int );

void initSounds(void);

