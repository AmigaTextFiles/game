#ifndef GS_SOUND
#define GS_SOUND

struct sound_struct
  {
  unsigned char *data;        /* ptr to sound data */
  unsigned char *loop;        /* ptr to loop portion of sound data (echo) */
  unsigned long length;       /* length of sound data (in 16 bit words) */
  unsigned short repeat;      /* number of times to play the sample */
  unsigned short count;       /* running total of number of times sample played */
  unsigned short period;      /* tone of the sound (note value) */
  unsigned short volume;      /* volume to play the sample (0 - 64) */
  unsigned short type;        /* sample type (SND_EFX) */
  unsigned short flags;       /* sample flags */
  short volfade;              /* volume fade value (0 for no fade) */
  unsigned short volcnt;      /* number of interrupts before volume decrement, or 0 */
                              /* for fade only after every play of sample */
  short perfade;              /* period fade value (0 for no fade) */
  unsigned short percnt;      /* number of interrupts before period decrement, or 0 */
                              /* for fade only after every play of sample */
  };

/* the sound types */

#define SND_EFX  3            /* only supported sound type as yet */

/* the sound flags */

#define SND_FAST 1		      /* sound data resides in fast RAM */

/* Amiga sound channels */

#define CHANNEL0 1            /* sound channel 0 */
#define CHANNEL1 2            /* sound channel 1 */
#define CHANNEL2 4            /* sound channel 2 */
#define CHANNEL3 8            /* sound channel 3 */

#endif
