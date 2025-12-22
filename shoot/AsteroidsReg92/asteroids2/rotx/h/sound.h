
typedef struct sounddata
{
 ULONG rate;
 ULONG length;
 ULONG volume;
 BYTE *audiodata;
};

#define BODY MAKE_ID('B','O','D','Y')
#define VHDR MAKE_ID('V','H','D','R')
#define ID_8SVX MAKE_ID('8','S','V','X')

struct Voice8Header
{
	ULONG oneShotHiSamples;	/* # samples in the high octave 1-shot part */
	ULONG repeatHiSamples;	/* # samples in the high octave repeat part */
	ULONG samplesPerHiCycle;	/* # samples/cycle in high octave, else 0 */
	UWORD samplesPerSec;	/* data sampling rate */
	UBYTE ctOctave;		/* # of octaves of waveforms */
	UBYTE sCompression;		/* data compression technique used */
	LONG	 volume;			/* playback nominal volume from 0 to Unity
						 * (full volume). Map this value into
						 * the output hardware's dynamic range. */
};

enum	{  L1,R1,L2,R2 };

#define LEFT0F  1
#define RIGHT0F  2
#define RIGHT1F  4
#define LEFT1F  8

#define LEFT_MASK	(LEFT0F | LEFT1F)
#define RIGHT_MASK	(RIGHT0F | RIGHT1F)

UBYTE Channel[] = { LEFT0F | RIGHT0F | LEFT1F | RIGHT1F };
