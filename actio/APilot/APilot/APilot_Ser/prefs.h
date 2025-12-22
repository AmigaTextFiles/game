/************************************************************************
 *
 * prefs.h -- Header file containing user modifications
 *
 *-----------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)  
 *
 */

/* 
 * Maximum/minimum screensize supported so far, probably not cool playing with
 * same aspect ratio and bigger than 1280x1024.
 */
#define MAXResX 1280
#define MAXResY 1024
#define MINResX 320
#define MINResY 256

#define DEF_SERIALDEVICE    "serial.device"
#define DEF_SERIALUNIT      0
#define DEF_SERIALBPS       9600

/*
 * This structure is used to store info about the surroundings
 */
typedef struct _UserPrefs {
  char  *ser_dev;       /* Pointer to serial device name */
  ULONG ser_unitnr;     /* Serial device unit number */
  ULONG ser_bps;        /* Speed of serial port */
  BOOL  noserial;       /* Set if the user just wants to play by himself */
  char  *mapname;       /* Pointer to filename of map */
  int   dpy_width;      /* Display sizes */
  int   dpy_height;
  BOOL  native_mode;    /* Default display is default */
  ULONG dpy_modeid;     /* Display mode */
  ULONG dpy_autoscroll; /* Are we autoscrolling? */
  ULONG dpy_oscan;      /* Overscan type */
} UserPrefs;

extern UserPrefs prefs;

#ifdef DYN_SCR
#define SCR_WIDTH       prefs.dpy_width
#define SCR_HEIGHT      prefs.dpy_height
#else
#define SCR_WIDTH       641     /* These values should be set to the         */
#define SCR_HEIGHT      513     /* highest resolution needed, as the opened  */
                                /* screen will have this size.               */
                                /* Note: Must be smaller than MAXRes[XY]     */
#endif
