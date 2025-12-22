#ifndef LIBRARIES_LUCYPLAY_H
#define LIBRARIES_LUCYPLAY_H

#include <exec/types.h>

struct LucyPlaySample
{
  ULONG SampleRate;         /*  sample frequency                */
  ULONG Size;               /*  sample size (in bytes)          */
  ULONG Type;               /*  AHI type (mono/stereo, 8/16bit) */
  UBYTE *SampleData;        /*  pointer to the sample data      */
};
typedef struct LucyPlaySample LucyPlaySample;

struct LucyPlayJoystick
{
  UBYTE   Up;               /*  0 means FALSE,  1 means TRUE    */
  UBYTE   Down;             /*  if (Up == 1) Down = 0;          */
  UBYTE   Left;             /*  Don't forget to check for       */
  UBYTE   Right;            /*   Up/Down + Left/Right combos!   */
  UBYTE   Red;              /*  Standard fire button            */
  UBYTE   Blue;             /*  for 2-button sticks/pads        */
  UBYTE   Green;            /*  for CD32 compatible pads only   */
  UBYTE   Yellow;           /*  for CD32 compatible pads only   */
  UBYTE   Reverse;          /*  for CD32 compatible pads only   */
  UBYTE   Forward;          /*  for CD32 compatible pads only   */
  UBYTE   Play;             /*  for CD32 compatible pads only   */
  UBYTE   Error;            /*  hope this is always FALSE ;)    */
};
typedef struct LucyPlayJoystick LucyPlayJoystick;

#ifndef INVALID_ID
#define INVALID_ID			  ~0
#endif

#define LUC_JOY_RIGHT      1
#define LUC_JOY_LEFT       2
#define LUC_JOY_DOWN       4
#define LUC_JOY_UP         8
#define LUC_JOY_PLAY      16
#define LUC_JOY_REVERSE   32
#define LUC_JOY_FORWARD   64
#define LUC_JOY_GREEN    128
#define LUC_JOY_YELLOW   256
#define LUC_JOY_RED      512
#define LUC_JOY_BLUE    1024

#endif /* LIBRARIES_LUCYPLAY_H */
