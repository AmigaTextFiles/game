
// Sounds.H - header for tying in the game sounds

#define DONK_SOUND   0
#define BOOM_SOUND   1
#define DIE_SOUND    2
#define SMASH_SOUND  3
#define YEAH_SOUND  4
#define MAX_SOUNDS   5

// extern unsigned short __far Donk[], Boom[], DeCry[], Smash[], Yeah[];

struct SoundData {
        long    sps;
        BOOL    stereo;
        long    sactual;
        char    *sbuffer;
        char    *iffraw;
};    /* sdata[MAX_SOUNDS] */

// END OF LISTING
