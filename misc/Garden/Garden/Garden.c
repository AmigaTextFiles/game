/*  Garden  / Slu4ka v Gradinata                             */
/*  By Ventzislav Tzvetkov                                   */
/*  http://drhirudo.hit.bg       drHirudo@Amigascne.org      */
/*  All sources are free to use.                             */
/*  Used the freeware C compiler VBCC by Volker Barthelmann  */
/*  The game is freeware. Enjoy!!                            */
/*  Version 1.3. Better palette. Added sound. Some bugfixes. */
/*  Removed all enforcer hits. Fixed graphics in rezultat.   */
/*  Version 1.2. This version saves the Screen ModeID to a   */
/*  File, also have better random routine, and screenmode    */
/*  Requester, plus some optimizations. All these are        */
/*  Incorporated from my other projects.                     */
/*  Version 1.1. Rewritten in C.                             */

#include <intuition/intuition.h> /* Uses intuition for the display */

/* For saving the HighScores and the ScreenModeID */
#include <libraries/dos.h>

#include <hardware/custom.h>  /* These twos  are  for  */
#include <hardware/cia.h>    /*  the Joystick handler */
/* The Game uses dirty hardware access to read the Joystick positions  */
/* For speed. If this doesn't work under newer AmigaOS releases I will */
/* Change it. For now it will stuck.                                   */

#include <devices/audio.h>

#define CLOCK_CONSTANT 3579545

#define NONSTOP       0 /* Play the sound over and over... */
#define ONCE          1 /* Play the sound once. */ 
#define MAXVOLUME    64 /* Maximum volume. */
#define MINVOLUME     0 /* Minimum volume. */
#define NORMALRATE    0 /* Normal rate. */
#define DO_NOT_WAIT   0 /* Do not wait for the sound to be completed. */ 
#define WAIT          1 /* Wait for the sound to be completed. */

/* Sound priorities: */
#define SOUND_PRI_UNSTOPPABLE  (BYTE)127
#define SOUND_PRI_EMERGENCIES  (BYTE)95
#define SOUND_PRI_ATTENTION    (BYTE)85
#define SOUND_PRI_SPEECH       (BYTE)75
#define SOUND_PRI_INFORMATION  (BYTE)60
#define SOUND_PRI_MUSIC        (BYTE)0
#define SOUND_PRI_EFFECT       (BYTE)-35
#define SOUND_PRI_BACKGROUND   (BYTE)-90
#define SOUND_PRI_SILENCE      (BYTE)-128

/* SoundInfo structure: */
struct SoundInfo
{
  BYTE *SoundBuffer;  /* WaveForm Buffers            */
  UWORD RecordRate;   /* Record Rate                 */
  ULONG FileLength;   /* WaveForm Lengths            */
  UBYTE channel_bit;  /* Audio channel bit position. */
};


/* An IOAudio pointer to each sound channel: */
struct IOAudio *IOA[ 4 ] = { NULL, NULL, NULL, NULL };



typedef LONG Fixed;
typedef struct
{
  ULONG  oneShotHiSamples;  /* #samples in the high octave 1-shot part */
  ULONG  repeatHiSamples;   /* #samples in the high octave repeat part */
  ULONG  samplesPerHiCycle; /* #samples/cycle in high octave, else 0  */
  UWORD  samplesPerSec;     /* Data sampling rate */
  UBYTE  ctOctave;          /* Number of octaves of waveforms */
  UBYTE  sCompression;      /* Data compression technique used */
  Fixed  volume;            /* Playback volume from 0 to 0x10000 */
} Voice8Header;



/* Declare the functions we are going to use: */

BOOL PlaySound(
  struct SoundInfo *info,
  UWORD volume, UBYTE channel,
  BYTE priority, WORD delta_rate,
  UWORD repeat, ULONG start,
  ULONG time, BOOL wait 
);

void StopSound( UBYTE channel );

BOOL PrepareIOA(
  UWORD period, UWORD volume,
  UWORD cycles, UBYTE channel,
  BYTE priority, struct SoundInfo *info,
  ULONG start, ULONG time
);

BOOL PlaySound
(
  struct SoundInfo *info,
  UWORD volume, UBYTE channel,
  BYTE priority, WORD delta_rate,
  UWORD times, ULONG start,
  ULONG time, BOOL wait 
)

{
  /* Before we may play the sound, we must make sure that the sound is */
  /* not already being played. We will therefore call the function     */
  /* StopSound(), in order to stop the sound if it is playing:         */
  StopSound( channel );

  /* Call the PrepareIOA() function that will declare and initialize an */
  /* IOAudio structure:                                 */
  if( PrepareIOA( CLOCK_CONSTANT / info->RecordRate + delta_rate, volume,
                  times, channel, priority, info, start, time ) )
  {
    /* We will now start playing the sound: */
    BeginIO( IOA[ channel ] );

    /* Should we wait for the sound to be completed? */
    if( wait ) WaitIO( IOA[ channel ] );

    return( TRUE );  /* OK! */
  }
  else
    return( FALSE ); /* ERROR! */
}

void StopSound( UBYTE channel )
{
  /* Check if the IOAudio structure exist: */
  if( IOA[ channel ] )
  {
    /* 1. Stop the sound: */
    AbortIO( IOA[ channel ] );
   
    /* 2. If there exist a Sound Device, close it: */
    if( IOA[ channel ]->ioa_Request.io_Device )
    CloseDevice( IOA[ channel ] );

    /* 3. If there exist a Message Port, delete it: */
    if( IOA[ channel ]->ioa_Request.io_Message.mn_ReplyPort )
      DeletePort( IOA[ channel ]->ioa_Request.io_Message.mn_ReplyPort );

    /* 4. Remove the request block: */
    DeleteExtIO( IOA[ channel ], sizeof( struct IOAudio ) );
    
    /* 5. Set the pointer to NULL so we know that this */
    /*    request has now been deleted:                */
    IOA[ channel ] = NULL;
  }
}

BOOL PrepareIOA
(
  UWORD period,
  UWORD volume,
  UWORD cycles,
  UBYTE channel,
  BYTE priority,
  struct SoundInfo *info,
  ULONG start,
  ULONG time
)
{
  /* Store error numbers here: */
  BYTE error;

  /* Declare a pointer to a MsgPort structure: */ 
  struct MsgPort *port;



  /* Get a reply port: (No name, normal priority) */
  port = (struct MsgPort *)
    CreatePort( NULL, 0 );
    
  /* Did we get a reply port? */  
  if( !port )
  {
    /* Bad news! We did not get a reply port. */
    
    /* Return with an error value: */
    return( FALSE );
  }



  /* Create an IOAudio request: */
  IOA[ channel ] = (struct IOAudio *)
    CreateExtIO( port, sizeof( struct IOAudio ) );

  /* Could we allocate enough memory? */
  if( !IOA[ channel ] )
  {
    /* Tough luck! We did not get a request block. */

    /* Close the reply port: */
    DeletePort( port );
    
    /* Return with an error value: */
    return( FALSE );
  }



  /* Initialize the IOAudion structure: */
      
  /* Set priority: */
  IOA[ channel ]->ioa_Request.io_Message.mn_Node.ln_Pri = priority;
    
  /* Set channel: (This program tries to reserve one specific */
  /* audio channel. It does not support an allocation array   */
  /* with several options.)                                   */
  info->channel_bit = 1<<channel;

  /* Give the request block a pointer to our simple allocation array: */
  IOA[ channel ]->ioa_Data = &(info->channel_bit);
    
  /* Set the length of our allocation array: */
  IOA[ channel ]->ioa_Length = sizeof( UBYTE );
    
  /* Open Audio Device: */
  error =  OpenDevice( AUDIONAME, 0, IOA[ channel ], 0);

  /* Have wee successfully opened it? */
  if( error )
  {
    /* Hard times! Could not open the device! */

    /* Delete the request block: */
    DeleteExtIO( IOA[ channel ], sizeof(struct IOAudio) );
    
    /* Close the reply port: */
    DeletePort( port );

    /* Set audio pointer to NULL so we know that */
    /* we do not have any request block here:    */
    IOA[ channel ] = NULL;

    /* Return with an error value: */
    return( FALSE ); /* ERROR! */
  }
 
 

  /* We now have a reply port, a request block, one  */
  /* audio channel reserved and the audio device has */
  /* been opened. Prepare to play:                   */ 


 
  /* Initialize the request block with the users requirements: */
  IOA[ channel ]->ioa_Request.io_Flags = ADIOF_PERVOL;

  /* We want to play sound (write data to the audio device): */
  IOA[ channel ]->ioa_Request.io_Command = CMD_WRITE;

  /* Set period value: */
  IOA[ channel ]->ioa_Period = period;

  /* Set volume: */
  IOA[ channel ]->ioa_Volume = volume;

  /* Number of times the sound wave should be played: */
  IOA[ channel ]->ioa_Cycles = cycles;

  /* If the user has specified a play time we use */
  /* it, else we play the complete sound:         */
  if( time )
    IOA[ channel ]->ioa_Length = time;
  else
    IOA[ channel ]->ioa_Length = info->FileLength;

  /* Set start position in the waveform: */
  IOA[ channel ]->ioa_Data = info->SoundBuffer + start;



  /* Everything has been prepared, return with OK: */
  return( TRUE );
}

#include <libraries/asl.h> /* For the ScreenMode Requester */

#define FIRE   1
#define RIGHT  2
#define LEFT   4
#define DOWN   8
#define UP    16

void Algo();

 struct FileHandle *file_handle;
 long bytes_written;
 long bytes_read;

/* This will automatically be linked to the Custom structure: */
extern struct Custom custom;

/* This will automatically be linked to the CIA A (8520) chip: */
extern struct CIA ciaa;

UBYTE Joystick();

struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;

struct Screen *my_screen;
struct Window *my_window;

int n,x,y,a,b,mx,my,xd,yd,Seed;

UBYTE Title1[]={254,254,198,184,202,218,182,160,254,254,206,254,254,174,196,160,168,178,188,160,200,160,254},
Title2[]={255,255,199,185,203,219,183,161,255,255,207,255,255,175,197,161,169,179,189,161,201,161,255};
struct IntuiMessage *my_message;

ULONG GardenPaletteRGB32[26] =
{
    0x00080000,    /* Record Header */
    0x00000000,0x00000000,0x00000000,
    0x00000000,0x00000000,0xFFFFFFFF,
    0xFFFFFFFF,0x00000000,0xFFFFFFFF,
    0xFFFFFFFF,0x00000000,0x00000000,
    0x77777777,0x33333333,0x00000000,
    0x00000000,0xFFFFFFFF,0x00000000,
    0x00000000,0xBBBBBBBB,0xFFFFFFFF,
    0xFFFFFFFF,0xFFFFFFFF,0x00000000,
    0x00000000    /* Terminator */
};

/* Font for the screen title and menus. */

struct TextAttr my_font=
{
  "topaz.font",                 /* Topaz font. */
  8,                            /* Eight. */
    0,FPF_ROMFONT               /* Exist in ROM. */
};

/******************************************/
/*     FontData prepared by PrintFont     */
/*     ------------------------------     */
/* Anders Bjerin             Amiga C Club */
/*                                        */
/* Font name:                    hap.font */
/* Struct name:                       Hap */
/* Height:                              8 */
/* Characters:                   32 - 255 */
/******************************************/
/* The font data: */
UWORD HapData[616]=
{
  /* Row 0: */
  0x0045,0x0A10,0x039E,0x036F,0xD600,0x0000,0x3843,0x9F09,
  0xF1DF,0x38E0,0x0008,0x020E,0x38E7,0xD219,0xF11F,0x4515,
  0x511D,0x144E,0x7CF7,0x8E7D,0x155E,0x4303,0x9581,0x5452,
  0x1800,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0010,0x0003,0xDB61,0x8053,0xF061,0xF800,
  0x00FD,0x2AB7,0x0007,0xC003,0xEE10,0x4191,0x8E39,0x17D1,
  0x7924,0x8629,0x0115,0x7D04,0x4A45,0x9551,0x5072,0x5144,
  0xE45F,0x3D03,0x907C,0x4441,0x5554,0x3038,0x1555,0x5414,
  0x9500,0xA000,0xFD5F,0x2000,0x093F,0x000D,0xFFFF,0xF700,
  0x000F,0x9803,0x0FF0,0xC3F0,0x0000,
  /* Row 1: */
  0x0045,0x0A3D,0x157F,0x03E8,0x5F00,0x0001,0x44C4,0x4119,
  0x0201,0x4511,0x0410,0x0111,0x4514,0x1229,0x0390,0x4514,
  0x5225,0xB451,0x4514,0x5111,0x1551,0x4104,0x5541,0x5455,
  0x1800,0x0000,0x0000,0x0001,0x0000,0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0010,0x000F,0xDB60,0xC093,0xF0C1,0xF803,
  0x60FC,0x9548,0x0C68,0x1F3C,0x2A1F,0x7DF1,0x8E39,0x17D1,
  0x7924,0x8629,0x0115,0x7D04,0x4A45,0x9551,0x5072,0x5144,
  0xE45F,0x3D03,0x907C,0x4441,0x5554,0x3038,0x1555,0x5414,
  0x95C5,0xF545,0x7DFF,0x1000,0x4DBF,0x004F,0xFFFF,0xFF80,
  0x000F,0x0C06,0x8FC0,0x03F0,0x0100,
  /* Row 2: */
  0x0040,0x1F42,0xA39E,0x0148,0x4F00,0x0003,0x4C40,0x4229,
  0xE402,0x4511,0x0421,0xF081,0x5D14,0x1229,0x0550,0x2934,
  0xD425,0x5451,0x4514,0x5011,0x1551,0x4100,0x5521,0x5455,
  0x0CE7,0xD218,0xE11F,0x8924,0x921D,0xB48E,0x7CF7,0x8E7D,
  0x155E,0x4183,0x9511,0x54BC,0xF880,0x409F,0xF183,0xF807,
  0xF001,0x2577,0x31FB,0xD940,0x2B90,0x4190,0x0045,0x1411,
  0x4524,0x8A7D,0x038E,0x4104,0x5145,0x1452,0x4892,0x5B45,
  0x1451,0x4504,0x5110,0x4441,0x5554,0x1045,0x1555,0x5415,
  0x55EF,0xFFCF,0xFFFF,0x8800,0x6FFF,0x006F,0xFFFF,0xE000,
  0x001E,0x020C,0x0FC0,0x03F0,0x2900,
  /* Row 3: */
  0x0040,0x0A39,0x410C,0x03E8,0x5F01,0xF006,0x5441,0x8648,
  0x1784,0x38F0,0x0040,0x0042,0x55F7,0x9229,0xE550,0x1155,
  0x5825,0x57D1,0x44F7,0x9010,0xF7DE,0x79E1,0x9511,0x53DD,
  0x0014,0x1229,0x1390,0x5124,0x9425,0xF491,0x4594,0x5111,
  0x1551,0x4080,0x5511,0x5570,0xF880,0x009F,0x1103,0x980F,
  0xF800,0x9A88,0xC3FB,0xD958,0x389F,0x4193,0xDF45,0x1411,
  0x4524,0x8A7D,0x038E,0x4104,0x5145,0x1452,0x4892,0x5B45,
  0x1451,0x4504,0x5110,0x4441,0x5554,0x1045,0x1555,0x5415,
  0x553F,0xFFDF,0x7FFF,0xDC01,0x7FFF,0x027F,0xF87F,0xCF80,
  0x0032,0x0218,0x0CC0,0x83F0,0x3300,
  /* Row 4: */
  0x0040,0x1F04,0xA7FF,0x0368,0x4F00,0x000C,0x6442,0x017C,
  0x1448,0x4410,0x0021,0xF084,0x5D14,0x5229,0x0550,0x2996,
  0x5425,0x1451,0x4514,0x1010,0x1551,0x4510,0x5509,0x5055,
  0x00F7,0x9229,0xF550,0x2165,0x9825,0x5791,0x44F7,0x9010,
  0xF7DE,0x78E1,0x9511,0x5743,0x52B0,0x005E,0x1007,0x180F,
  0xF801,0x2AB7,0xC3FB,0xD958,0x0ED0,0x4195,0xAE45,0x141E,
  0x4527,0xCA45,0xF544,0x4102,0x914D,0x14D4,0x4494,0x5545,
  0x1391,0x4504,0x0E10,0x444E,0x5554,0x1004,0xE55F,0x7C15,
  0x527F,0xFFFF,0xFFF0,0x0803,0x7FFF,0x037F,0xF003,0x8F80,
  0x0072,0x0230,0x0CC0,0xC310,0x3F00,
  /* Row 5: */
  0x0000,0x0A79,0x539E,0x5488,0x5F18,0x0198,0x4444,0x1109,
  0x1448,0x4421,0x0410,0x0100,0x4114,0x527D,0x0390,0x4514,
  0x5225,0x1451,0x4514,0x1110,0x1551,0x4514,0x5505,0x5055,
  0x0194,0x527D,0x0390,0x51A6,0x9425,0x1491,0x4454,0x1110,
  0x1551,0x4490,0x5511,0x554F,0x52B0,0x7053,0xF007,0x184F,
  0xF800,0x9548,0x31F8,0x1940,0x021F,0x7DF1,0x8E45,0x141E,
  0x4527,0xCA45,0xF544,0x4102,0x914D,0x14D4,0x4494,0x5545,
  0x1391,0x4504,0x0E10,0x444E,0x5554,0x1004,0xE55F,0x7C15,
  0x52E7,0xFFDF,0x7FF0,0x0413,0xFFFF,0x03FC,0x7003,0x8F80,
  0x00FE,0x0260,0x0CC0,0xE300,0x1E00,
  /* Row 6: */
  0x0040,0x0A12,0x229E,0xAAB8,0x5618,0x01B0,0x38E7,0xCE08,
  0xE388,0x38C1,0x0408,0x0204,0x3D17,0x9F45,0xF110,0x4514,
  0x5145,0x144E,0x4514,0x0E10,0xE55E,0x79E3,0x9F01,0xF052,
  0x00F7,0x9F44,0xF110,0x8924,0x9245,0x148E,0x4494,0x0E10,
  0xE55E,0x78E3,0x9F11,0xF4BC,0xF9E0,0x1873,0xF007,0x38C7,
  0xF0FD,0x2577,0x0C67,0xDF3C,0x0390,0x4192,0x517C,0x0780,
  0x7920,0x4A00,0x0540,0x4001,0x0054,0x0558,0x0090,0x157D,
  0x1011,0x3D04,0x0010,0x03C0,0x7C07,0x9E18,0x0540,0x0407,
  0x40C7,0xFFFF,0xFFF0,0x031B,0xFFFF,0x07F0,0x7803,0xC700,
  0x05CF,0x0CC0,0x1DC0,0xE300,0x4C00,
  /* Row 7: */
  0x0000,0x0000,0x02B3,0x01EF,0xC030,0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0800,0x0000,0x0000,0x0100,0x0000,0x0000,
  0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x1000,
  0x0000,0x0100,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,0x1000,0xF9E0,0x0CD3,0xF00E,0x7943,
  0xE0FC,0x9A88,0x0000,0x0000,0x00DF,0x4194,0x117C,0x0780,
  0x7920,0x4A00,0x0540,0x4001,0x0054,0x0558,0x0090,0x157D,
  0x1011,0x3C04,0x0010,0x03C0,0x7C07,0x9E18,0x0540,0x0407,
  0x40F9,0xF7DF,0x7FF0,0x039F,0xFFFF,0x1F80,0x7E03,0xEFF0,
  0x038F,0x9880,0x3FC0,0xC300,0xC000
};

/* The location and width of each character: */
static ULONG HapLoc[224]=
{
  0x00000006,0x00060006,0x000C0006,0x00120006,
  0x00180006,0x001E0006,0x00240006,0x002A0006,
  0x00300006,0x00360006,0x003C0006,0x00420006,
  0x00480006,0x004E0006,0x00540006,0x005A0006,
  0x00600006,0x00660006,0x006C0006,0x00720006,
  0x00780006,0x007E0006,0x00840006,0x008A0006,
  0x00900006,0x00960006,0x009C0006,0x00A20006,
  0x00A80006,0x00AE0006,0x00B40006,0x00BA0006,
  0x00C00006,0x00C60006,0x00CC0006,0x00D20006,
  0x00D80006,0x00DE0006,0x00E40006,0x00EA0006,
  0x00F00006,0x00F60006,0x00FC0006,0x01020006,
  0x01080006,0x010E0006,0x01140006,0x011A0006,
  0x01200006,0x01260006,0x012C0006,0x01320006,
  0x01380006,0x013E0006,0x01440006,0x014A0006,
  0x01500006,0x01560006,0x015C0006,0x01620006,
  0x01680006,0x016E0006,0x01740006,0x017A0006,
  0x01800006,0x01860006,0x018C0006,0x01920006,
  0x01980006,0x019E0006,0x01A40006,0x01AA0006,
  0x01B00006,0x01B60006,0x01BC0006,0x01C20006,
  0x01C80006,0x01CE0006,0x01D40006,0x01DA0006,
  0x01E00006,0x01E60006,0x01EC0006,0x01F20006,
  0x01F80006,0x01FE0006,0x02040006,0x020A0006,
  0x02100006,0x02160006,0x021C0006,0x02220006,
  0x02280006,0x022E0006,0x02340006,0x023A0006,
  0x02400006,0x02460006,0x024C0006,0x02520006,
  0x02580006,0x025E0006,0x02640006,0x026A0006,
  0x02700006,0x02760006,0x027C0006,0x02820006,
  0x02880006,0x02880006,0x028E0006,0x02940006,
  0x029A0006,0x02A00006,0x02A60006,0x02AC0006,
  0x02B20006,0x02B20006,0x02B20006,0x02B20006,
  0x02B80006,0x02BE0006,0x02C40006,0x02CA0006,
  0x02D00006,0x02D60006,0x02DC0006,0x02E20006,
  0x02E80006,0x02EE0006,0x02F40006,0x02FA0006,
  0x03000006,0x02FA0006,0x03060006,0x030C0006,
  0x03120006,0x03180006,0x02F40006,0x031E0006,
  0x03240006,0x032A0006,0x03300006,0x03360006,
  0x033C0006,0x03420006,0x03480006,0x034E0006,
  0x03540006,0x034E0006,0x035A0006,0x03600006,
  0x03660006,0x036C0006,0x03720006,0x02EE0006,
  0x03780006,0x02EE0006,0x037E0006,0x03840006,
  0x038A0006,0x02EE0006,0x03900006,0x02EE0006,
  0x03000006,0x03960006,0x039C0006,0x03A20006,
  0x03A80006,0x03AE0006,0x03B40006,0x03BA0006,
  0x03C00006,0x03C60006,0x03000006,0x02FA0006,
  0x03CC0006,0x02FA0006,0x03D20006,0x02FA0006,
  0x03D80006,0x03DE0006,0x03E40006,0x03EA0006,
  0x03E40006,0x03F00006,0x03B40006,0x03F60006,
  0x03FC0006,0x04020006,0x04080006,0x040E0006,
  0x04140006,0x041A0006,0x04200006,0x04260006,
  0x042C0006,0x04320006,0x04380006,0x043E0006,
  0x04440006,0x044A0006,0x04500006,0x04560006,
  0x045C0006,0x04620006,0x04680006,0x046E0006,
  0x04740006,0x047A0006,0x04800006,0x04860006,
  0x048C0006,0x04920006,0x04980006,0x049E0006,
  0x04A40006,0x04AA0006,0x04B00006,0x04B60006,
  0x04BC0006,0x04C20006,0x00000006,0x00000006
};

/* The text font structure: */
struct TextFont HapFont=
{
  { /* Message */
    { /* Node */
      NULL,    /* ln_Succ */
      NULL,    /* ln_Pred */
      NT_FONT, /* ln_Type */
      0,       /* ln_Pri */
      "hap.font" /* ln_Name */
    },
    NULL,      /* mn_ReplyPort */
     2132      /* mn_Length */
  },
      8, /* tf_YSize */
      0, /* tf_Style */
     66, /* tf_Flags */
      6, /* tf_XSize */
      6, /* tf_Baseline */
      1, /* tf_BoldSmear */
      0, /* tf_Accessors */
     32, /* tf_LoChar */
    255, /* tf_HiChar */
  (APTR) &HapData,  /* tf_CharData */
    154, /* tf_Modulo */
  (APTR) &HapLoc,   /* tf_CharLoc */
   NULL, /* tf_CharSpace */
   NULL, /* tf_CharKern */
};

/******************************************/

/* Text for the About Menu Item */
struct IntuiText my_body_text=
{
  0,       /* FrontPen, colour 0 (blue). */
  0,       /* BackPen, not used since JAM1. */
  JAM1,    /* DrawMode, do not change the background. */
  15,      /* LedtEdge, 15 pixels out. */
  5,       /* TopEdge, 5 lines down. */
  NULL,    /* ITextFont, default font. */
  "Copyright © 1989-2003", /* IText, the text . */
  NULL,    /* NextText, no more IntuiText structures link. */
};

/* The OK text: */
struct IntuiText my_ok_text=
{
  0,       /* FrontPen, colour 0 (blue). */
  0,       /* BackPen, not used since JAM1. */
  JAM1,    /* DrawMode, do not change the background. */
  6,       /* LedtEdge, 6 pixels out. */
  3,       /* TopEdge, 3 lines down. */
  NULL,    /* ITextFont, default font. */
  "OK",    /* IText, the text that will be printed. */
  NULL,    /* NextText, no more IntuiText structures link. */
};

struct NewWindow my_new_window=
{
  0,            /* LeftEdge    x position of the window. */
  0,            /* TopEdge     y positio of the window. */
  320,           /* Width       320 pixels wide. */
  256,           /* Height      256 lines high. */
  0,             /* DetailPen   Text should be drawn with colour reg. 0 */
  1,             /* BlockPen    Blocks should be drawn with colour reg. 1 */
  MENUPICK, /* IDCMPFlags. */
  WFLG_BACKDROP|WFLG_SMART_REFRESH|WFLG_BORDERLESS|WFLG_ACTIVATE, /* Flags       Intuition should refresh the window. */ 
  0,/* FirstGadget. */
  NULL,          /* CheckMark   Use Intuition's default CheckMark (v). */
  NULL,          /* Title       Title of the window. */
  NULL,          /* Screen      Connected to the Workbench Screen. */
  NULL,          /* BitMap      No Custom BitMap. */
  0,0,0,0,
  CUSTOMSCREEN   /* Type        Connected to custom Screen. */
};

struct IntuiText my_third_text=
{
  2,          /* FrontPen */
  0,          /* BackPen, not used since JAM1. */
  JAM1,       /* DrawMode, do not change the background. */
  0,          /* LeftEdge, CHECKWIDTH amount of pixels out. */
              /* This will leave enough space for the check mark. */
  1,          /* TopEdge, 1 line down. */
  NULL,       /* TextAttr, default font. */
  "Quit",     /* IText, the string. */
  NULL        /* NextItem, no link to other IntuiText structures. */
};

struct MenuItem my_third_item=
{
  NULL, /* &my_third_item, */  /* NextItem, linked to the third item. */
  0,               /* LeftEdge, 0 pixels out. */
  20,              /* TopEdge, 20 lines down. */
  150,             /* Width, 150 pixels wide. */
  10,              /* Height, 10 lines high. */
  ITEMTEXT|        /* Flags, render this item with text. */
  ITEMENABLED|     /*        this item will be enabled. */
  COMMSEQ|         /*        accessible from the keyboard. */
  HIGHCOMP,        /*        complement the colours when highlihted. */
  0x00000000,      /* MutualExclude, mutualexclude the first item only. */
  (APTR) &my_third_text, /* ItemFill, pointer to the text. */
  NULL,            /* SelectFill, nothing since we complement the col. */
  'Q',               /* Command, no command-key sequence. */
  NULL,            /* SubItem, no subitem list. */
  MENUNULL,        /* NextSelect, no items selected. */
};

struct IntuiText my_second_text=
{
  2,          /* FrontPen, black. */
  0,          /* BackPen, not used since JAM1. */
  JAM1,       /* DrawMode, do not change the background. */
  0,          /* LeftEdge, CHECKWIDTH amount of pixels out. */
              /* This will leave enough space for the check mark. */
  1,          /* TopEdge, 1 line down. */
  NULL,       /* TextAttr, default font. */
  "About",    /* IText, the string. */
  NULL        /* NextItem, no link to other IntuiText structures. */
};

struct MenuItem my_second_item=
{
  &my_third_item,  /* NextItem, linked to the third item. */
  0,               /* LeftEdge, 0 pixels out. */
  10,              /* TopEdge, 10 lines down. */
  150,             /* Width, 150 pixels wide. */
  10,              /* Height, 10 lines high. */
  ITEMTEXT|        /* Flags, render this item with text. */
  ITEMENABLED|     /*        this item will be enabled. */
  COMMSEQ|         /*        accessible from the keyboard. */
  HIGHCOMP,        /*        complement the colours when highlihted. */
  0x00000000,      /* MutualExclude, mutualexclude the first item only. */
  (APTR) &my_second_text, /* ItemFill, pointer to the text. */
  NULL,            /* SelectFill, nothing since we complement the col. */
  'A',               /* Command, no command-key sequence. */
  NULL,            /* SubItem, no subitem list. */
  MENUNULL,        /* NextSelect, no items selected. */
};

struct IntuiText my_first_text=
{
  2,          /* FrontPen, black. */
  0,          /* BackPen, not used since JAM1. */
  JAM1,       /* DrawMode, do not change the background. */
  0, /* LeftEdge, CHECKWIDTH amount of pixels out. */
              /* This will leave enough space for the check mark. */
  1,          /* TopEdge, 1 line down. */
  NULL,       /* TextAttr, default font. */
  "New Game", /* IText, the string. */
  NULL        /* NextItem, no link to other IntuiText structures. */
};

struct MenuItem my_first_item=
{
  &my_second_item, /* NextItem, linked to the second item. */
  0,               /* LeftEdge, 0 pixels out. */
  0,               /* TopEdge, 0 lines down. */
  150,             /* Width, 150 pixels wide. */
  10,              /* Height, 10 lines high. */
  ITEMTEXT|        /* Flags, render this item with text. */
  ITEMENABLED|     /*        this item will be enabled. */
  COMMSEQ|         /*        accessible from the keyboard. */
  HIGHCOMP,        /*        complement the colours when highlihted. */
  0x00000000,      /* MutualExclude, , no mutualexclude. */
  (APTR) &my_first_text, /* ItemFill, pointer to the text. */
  NULL,            /* SelectFill, nothing since we complement the col. */
  'N',             /* Command, no command-key sequence. */
  NULL,            /* SubItem, no subitem list. */
  MENUNULL,        /* NextSelect, no items selected. */
};

struct Menu my_menu=
{
  NULL,          /* NextMenu, no more menu structures. */
  0,             /* LeftEdge, left corner. */
  0,             /* TopEdge, for the moment ignored by Intuition. */
  50,            /* Width, 50 pixels wide. */
  0,             /* Height, for the moment ignored by Intuition. */
  MENUENABLED,   /* Flags, this menu will be enabled. */
  "Garden",/* MenuName, the string. */
  &my_first_item /* FirstItem, pointer to the first item in the list. */
};

__chip BYTE Biiing_data[]=
{
  1,1,1,0,-7,32,-16,-19,42,-54,
  64,-37,8,20,-35,62,-70,48,-30,-6,
  44,-54,103,-59,56,-30,-60,39,-96,89,
  -42,62,42,-38,74,-106,42,-76,-1,41,
  -37,125,-51,75,-41,-44,14,-103,77,-60,
  75,29,-10,77,-91,63,-85,5,5,-48,
  96,-65,92,-40,-3,22,-85,71,-88,66,
  -8,1,77,-67,89,-81,20,-17,-53,73,
  -71,101,-32,31,24,-75,59,-100,57,-26,
  11,70,-53,89,-87,28,-34,-41,67,-62,
  111,-33,42,13,-75,49,-106,62,-33,29,
  64,-48,88,-94,31,-46,-34,63,-60,116,
  -44,47,-4,-69,41,-107,70,-34,31,62,
  -45,87,-92,34,-48,-32,56,-58,111,-42,
  50,-6,-63,39,-106,66,-38,40,63,-34,
  90,-93,30,-58,-39,49,-60,112,-37,55,
  -5,-62,36,-110,64,-40,43,63,-33,92,
  -92,30,-60,-40,47,-62,114,-37,59,2,
  -63,40,-108,62,-41,34,59,-41,88,-90,
  31,-49,-35,58,-54,113,-37,51,3,-66,
  44,-104,64,-34,31,63,-48,85,-91,29,
  -41,-36,65,-58,111,-38,39,2,-77,46,
  -105,65,-23,29,74,-47,88,-86,24,-32,
  -43,69,-63,105,-31,31,14,-80,51,-100,
  60,-16,13,81,-53,89,-83,13,-25,-57,
  74,-67,103,-19,23,32,-83,57,-95,51,
  -5,-3,89,-59,86,-73,-1,-11,-67,77,
  -67,93,-8,11,49,-86,61,-89,30,1,
  -26,92,-62,85,-52,-8,12,-77,79,-68,
  78,10,-6,68,-89,58,-80,8,16,-43,
  102,-59,75,-38,-31,23,-93,76,-61,64,
  28,-18,80,-92,51,-70,-12,31,-57,106,
  -52,69,-11,-44,41,-100,67,-51,38,51,
  -35,91,-89,37,-50,-37,48,-67,105,-36,
  50,14,-63,53,-103,54,-35,9,68,-51,
  95,-75,25,-22,-55,66,-73,94,-23,22,
  34,-80,58,-97,40,-9,-13,90,-57,91,
  -56,3,3,-77,73,-72,78,0,-4,59,
  -90,59,-81,14,17,-38,104,-58,78,-35,
  -31,24,-97,72,-59,57,38,-23,84,-90,
  46,-62,-24,38,-63,105,-46,51,2,-60,
  47,-102,59,-35,21,70,-46,95,-77,22,
  -29,-60,61,-72,96,-15,26,44,-77,59,
  -96,28,-10,-24,90,-56,90,-45,-5,11,
  -82,72,-67,67,14,-13,70,-86,54,-69,
  -3,29,-48,103,-49,69,-9,-39,39,-98,
  61,-49,29,51,-38,88,-79,36,-37,-46,
  51,-67,99,-26,37,30,-68,55,-96,37,
  -17,-10,82,-53,88,-52,2,4,-74,70,
  -66,69,14,-6,68,-83,51,-73,-8,24,
  -47,99,-48,65,-10,-39,39,-93,63,-38,
  29,56,-41,85,-76,23,-32,-52,59,-66,
  91,-18,21,40,-74,55,-88,28,4,-19,
  88,-57,76,-44,-20,14,-84,71,-57,56,
  26,-25,74,-85,43,-55,-20,41,-60,95,
  -44,41,7,-61,50,-91,54,-23,3,69,
  -54,83,-64,7,-7,-66,68,-67,73,0,
  -1,61,-81,56,-72,4,21,-49,93,-54,
  64,-19,-41,39,-91,66,-42,26,52,-44,
  86,-76,29,-26,-49,61,-70,88,-19,18,
  43,-74,62,-82,24,1,-35,87,-59,75,
  -31,-18,31,-85,71,-54,46,34,-32,81,
  -80,42,-41,-32,48,-67,90,-32,33,28,
  -63,60,-86,38,-14,-22,75,-58,81,-42,
  -1,20,-72,70,-62,50,15,-25,66,-77,
  48,-51,-20,37,-62,88,-40,39,18,-51,
  55,-83,41,-21,-12,66,-54,78,-43,6,
  14,-65,63,-61,49,8,-20,64,-70,49,
  -49,-18,32,-57,81,-37,38,18,-46,52,
  -78,37,-19,-13,62,-49,74,-36,3,13,
  -67,57,-56,46,17,-18,67,-64,43,-44,
  -19,31,-56,76,-31,36,23,-46,51,-73,
  30,-15,-20,63,-47,69,-30,-4,18,-69,
  54,-50,34,27,-24,71,-62,35,-31,-34,
  40,-62,71,-20,22,37,-55,53,-69,15,
  -4,-35,71,-46,64,-14,-18,33,-74,50,
  -47,17,36,-36,76,-54,30,-13,-44,49,
  -64,62,-14,3,47,-63,53,-62,1,11,
  -47,76,-44,53,3,-30,45,-78,45,-35,
  -1,51,-46,77,-44,16,4,-58,55,-64,
  48,2,-13,62,-63,51,-45,-13,25,-59,
  75,-34,42,23,-42,52,-76,31,-21,-20,
  60,-48,75,-27,3,19,-68,52,-59,33,
  17,-23,70,-58,43,-31,-25,36,-60,68,
  -24,30,35,-46,53,-69,20,-12,-30,63,
  -44,68,-18,-6,26,-69,48,-53,21,24,
  -26,71,-51,37,-24,-35,35,-61,63,-18,
  23,43,-45,52,-64,12,-8,-35,61,-41,
  63,-10,-8,30,-67,42,-49,13,26,-27,
  71,-45,37,-18,-32,33,-60,56,-20,18,
  40,-42,50,-61,10,-12,-35,56,-40,58,
  -11,-9,25,-65,40,-46,18,27,-22,69,
  -43,33,-23,-35,28,-60,54,-18,24,35,
  -39,48,-57,14,-10,-28,53,-39,60,-9,
  1,25,-60,37,-51,16,14,-20,63,-40,
  40,-23,-25,24,-55,51,-25,26,29,-31,
  47,-56,20,-17,-21,45,-36,61,-17,7,
  13,-53,36,-55,23,3,-12,58,-38,45,
  -30,-13,15,-51,51,-31,35,18,-22,43,
  -58,27,-28,-11,36,-32,64,-25,20,3,
  -46,32,-58,31,-8,1,49,-35,50,-39,
  1,2,-42,48,-37,46,4,-8,34,-57,
  32,-43,3,22,-25,64,-32,34,-12,-30,
  24,-59,41,-21,20,35,-28,51,-48,16,
  -14,-29,41,-39,57,-12,10,21,-50,35,
  -54,19,3,-11,59,-34,49,-27,-12,11,
  -55,45,-35,38,21,-11,49,-52,30,-35,
  -11,27,-34,64,-25,31,4,-36,29,-61,
  33,-17,10,46,-28,57,-41,8,-11,-43,
  39,-42,56,-3,11,33,-48,35,-56,8,
  1,-17,61,-32,49,-19,-15,14,-58,41,
  -36,34,21,-11,52,-50,29,-38,-19,21,
  -38,63,-23,35,9,-31,32,-63,28,-20,
  6,46,-27,59,-40,10,-14,-45,34,-46,
  53,-4,13,36,-45,35,-58,7,-4,-21,
  57,-31,55,-17,-6,11,-57,37,-42,32,
  14,-9,50,-47,32,-40,-17,13,-37,61,
  -24,44,5,-23,26,-63,29,-32,11,32,
  -21,59,-39,22,-21,-31,27,-44,55,-14,
  24,22,-36,34,-60,19,-16,-5,47,-26,
  61,-25,9,-3,-46,32,-46,43,-1,9,
  39,-40,34,-52,2,-3,-19,55,-26,54,
  -14,-6,8,-57,30,-41,34,17,1,51,
  -40,32,-40,-10,8,-30,57,-22,47,-1,
  -16,19,-60,28,-35,21,26,-8,58,-38,
  26,-33,-26,13,-41,55,-17,40,15,-22,
  29,-61,24,-29,9,37,-16,62,-34,21,
  -22,-36,21,-46,53,-11,31,28,-28,35,
  -61,15,-24,-7,43,-23,63,-25,15,-8,
  -43,27,-48,46,-7,18,34,-36,37,-57,
  9,-16,-20,49,-26,62,-17,6,5,-51,
  29,-49,36,2,6,45,-39,38,-50,-2,
  -4,-27,54,-27,55,-10,-4,12,-57,28,
  -48,26,10,-3,52,-38,36,-41,-10,3,
  -34,53,-25,50,-1,-11,17,-60,26,-41,
  22,20,-4,57,-35,31,-38,-20,4,-38,
  52,-21,43,5,-14,21,-58,23,-38,16,
  25,-6,57,-33,28,-33,-23,6,-40,49,
  -18,43,13,-13,24,-57,20,-37,10,23,
  -10,55,-29,27,-31,-24,6,-41,48,-17,
  42,14,-12,25,-55,19,-37,8,23,-9,
  56,-28,28,-27,-21,8,-39,47,-18,40,
  11,-14,21,-56,19,-37,10,22,-8,56,
  -28,30,-27,-20,7,-38,48,-16,42,10,
  -13,21,-55,20,-37,14,24,-4,57,-30,
  30,-32,-21,4,-40,48,-17,44,7,-11,
  20,-56,21,-40,17,20,-1,57,-30,32,
  -36,-17,1,-36,48,-20,48,3,-8,16,
  -56,22,-43,20,17,2,55,-30,32,-40,
  -15,-3,-35,48,-20,50,1,-5,12,-55,
  21,-45,24,14,7,52,-30,33,-44,-10,
  -9,-31,46,-20,56,-3,3,9,-51,21,
  -47,26,6,10,45,-29,33,-46,-6,-14,
  -26,42,-20,58,-7,10,2,-47,18,-49,
  31,-1,16,39,-27,33,-50,4,-19,-15,
  40,-16,60,-15,13,-10,-43,15,-47,39,
  -5,28,35,-20,32,-55,5,-29,-9,33,
  -14,59,-20,21,-18,-36,8,-47,42,-10,
  37,25,-14,27,-56,11,-37,0,24,-8,
  58,-21,28,-25,-24,3,-41,43,-16,43,
  12,-7,18,-54,13,-43,12,15,2,52,
  -23,32,-35,-14,-8,-32,41,-16,52,1,
  3,6,-48,14,-45,24,7,17,46,-20,
  32,-46,-5,-20,-21,35,-13,57,-8,16,
  -8,-40,9,-46,33,-4,31,33,-13,30,
  -50,6,-33,-7,25,-8,57,-15,27,-20,
  -26,2,-41,37,-14,42,16,-3,22,-50,
  12,-43,10,13,3,52,-19,34,-35,-12,
  -11,-31,39,-17,53,-1,9,5,-46,13,
  -48,27,2,17,41,-19,34,-47,1,-24,
  -17,33,-13,60,-13,22,-13,-36,7,-48,
  35,-11,33,25,-11,28,-52,11,-37,1,
  22,-4,58,-20,30,-29,-22,-5,-41,39,
  -17,48,9,1,13,-50,14,-47,18,7,
  11,48,-19,34,-43,-6,-20,-25,34,-15,
  56,-7,15,-6,-40,8,-46,31,-5,30,
  32,-10,28,-49,6,-34,-5,21,-6,54,
  -15,27,-23,-23,-3,-37,35,-13,43,11,
  0,13,-47,10,-43,14,8,9,44,-17,
  30,-37,-7,-17,-22,33,-12,52,-5,13,
  -4,-39,7,-44,29,-1,28,33,-11,27,
  -46,3,-31,-9,24,-4,55,-13,23,-21,
  -28,-1,-39,35,-9,41,20,-2,18,-47,
  9,-39,7,13,3,49,-16,30,-31,-13,
  -9,-29,35,-12,49,4,6,7,-43,10,
  -43,19,3,15,41,-15,29,-41,-4,-19,
  -17,32,-10,53,-5,16,-3,-36,7,-43,
  28,-3,26,31,-11,26,-44,3,-28,-6,
  26,-4,54,-11,21,-18,-30,-1,-40,31,
  -7,37,23,-3,19,-46,5,-37,2,16,
  2,51,-13,26,-27,-21,-9,-34,32,-10,
  42,12,2,11,-44,7,-39,11,11,11,
  47,-13,27,-34,-15,-15,-29,30,-11,47,
  4,7,4,-42,6,-42,17,5,17,42,
  -12,27,-39,-7,-19,-21,29,-10,49,-1,
  12,-3,-39,5,-43,22,2,23,37,-11,
  26,-41,-5,-25,-18,25,-9,52,-3,17,
  -6,-35,3,-42,24,-2,27,32,-8,26,
  -43,-1,-28,-13,24,-7,52,-5,20,-10,
  -30,2,-40,26,-6,28,27,-7,24,-42,
  3,-29,-6,23,-4,51,-8,21,-16,-30,
  -3,-39,27,-7,30,24,-5,21,-42,3,
  -30,-3,22,-1,50,-9,22,-17,-26,-2,
  -37,29,-6,34,23,-3,21,-42,3,-32,
  -3,18,0,48,-10,22,-19,-24,-3,-36,
  29,-7,35,21,-2,19,-42,4,-32,-1,
  17,-1,47,-9,24,-17,-21,-2,-34,29,
  -8,33,18,-4,19,-41,5,-32,-1,16,
  -2,46,-10,23,-16,-21,-1,-34,28,-8,
  31,17,-5,17,-40,5,-30,1,18,-1,
  45,-10,22,-15,-22,0,-34,27,-8,30,
  18,-5,18,-38,6,-27,0,19,-2,44,
  -11,19,-15,-24,0,-34,26,-6,27,20,
  -8,20,-37,3,-24,-5,21,-6,43,-9,
  15,-10,-27,4,-34,24,-4,22,25,-8,
  22,-35,0,-21,-11,22,-8,41,-5,14,
  -4,-27,6,-33,20,-2,15,26,-12,21,
  -33,-3,-16,-15,23,-10,39,-1,10,1,
  -30,8,-32,16,1,10,29,-13,22,-27,
  -4,-10,-17,25,-10,36,1,5,6,-31,
  10,-29,12,5,5,33,-13,22,-22,-8,
  -4,-21,26,-11,31,6,0,11,-32,10,
  -27,8,12,1,35,-13,20,-18,-14,0,
  -26,25,-8,27,13,-3,17,-31,9,-21,
  1,16,-5,36,-11,17,-10,-19,5,-28,
  23,-6,19,19,-8,21,-29,5,-17,-8,
  19,-10,35,-6,13,-1,-23,9,-28,19,
  -1,13,25,-11,22,-26,0,-10,-16,21,
  -12,32,0,7,8,-26,11,-27,11,4,
  2,28,-13,22,-19,-5,-2,-21,23,-12,
  25,5,-1,13,-29,11,-22,4,10,-6,
  31,-11,18,-9,-13,6,-25,21,-9,16,
  14,-8,19,-27,7,-15,-6,17,-11,31,
  -7,12,1,-20,10,-27,15,-4,6,22,
  -12,21,-22,0,-6,-16,21,-13,27,0,
  3,10,-25,12,-23,8,6,-2,28,-12,
  19,-14,-10,1,-24,20,-12,18,9,-5,
  17,-25,9,-16,-3,13,-10,30,-9,13,
  -3,-17,9,-26,16,-5,9,21,-9,22,
  -21,2,-8,-15,18,-13,27,-1,5,9,
  -23,12,-23,7,4,-2,27,-11,20,-12,
  -8,2,-23,18,-11,18,12,-3,19,-23,
  8,-16,-7,12,-11,28,-5,13,3,-17,
  9,-25,13,-3,6,22,-9,22,-16,0,
  -5,-18,17,-13,23,5,3,15,-22,11,
  -20,0,5,-7,27,-8,18,-4,-11,7,
  -24,15,-9,11,15,-5,22,-20,5,-11,
  -13,14,-13,28,-1,10,10,-19,11,-24,
  7,1,0,26,-9,21,-11,-6,1,-23,
  17,-11,18,11,-3,20,-21,9,-15,-7,
  11,-12,28,-6,12,3,-17,10,-26,9,
  -4,2,23,-9,23,-14,-1,-3,-20,16,
  -14,20,6,1,17,-22,10,-20,-4,7,
  -10,28,-7,17,0,-14,7,-27,11,-8,
  6,19,-8,23,-17,1,-7,-17,15,-14,
  22,3,5,14,-20,9,-21,0,5,-6,
  27,-6,18,-3,-11,5,-25,11,-8,8,
  17,-5,21,-16,1,-8,-15,13,-11,22,
  4,6,12,-19,8,-20,0,4,-4,26,
  -5,17,-2,-11,4,-23,10,-6,9,18,
  -4,20,-14,1,-7,-15,13,-10,22,6,
  5,12,-18,7,-19,-2,6,-5,26,-4,
  15,-1,-13,4,-23,9,-4,8,19,-4,
  19,-13,-1,-5,-16,13,-9,20,7,3,
  14,-19,5,-17,-4,8,-5,25,-2,12,
  1,-15,5,-22,8,-1,4,22,-5,18,
  -11,-5,-3,-18,14,-8,17,10,0,15,
  -19,4,-14,-6,11,-7,25,0,10,6,
  -17,6,-22,5,2,1,24,-6,17,-8,
  -8,1,-21,14,-7,13,14,-3,17,-18,
  2,-10,-11,13,-8,24,3,6,8,-20,
  6,-19,2,6,-2,25,-6,14,-5,-13,
  3,-22,12,-4,10,18,-6,17,-16,-2,
  -7,-15,13,-9,21,5,3,10,-20,5,
  -18,-2,7,-4,24,-5,12,-2,-13,4,
  -21,10,-3,7,17,-5,16,-14,-3,-5,
  -14,14,-8,18,6,0,10,-19,4,-15,
  -2,8,-5,22,-3,10,0,-14,4,-19,
  8,-1,5,17,-6,15,-12,-3,-3,-14,
  13,-7,16,7,1,11,-17,5,-13,-2,
  10,-4,23,-2,11,1,-13,5,-18,8,
  0,5,18,-5,15,-11,-3,-2,-13,13,
  -6,17,7,1,11,-16,5,-12,-1,9,
  -3,22,-3,10,-1,-12,6,-17,9,-1,
  7,17,-5,15,-12,-1,-3,-12,14,-6,
  17,5,1,10,-16,6,-13,0,8,-3,
  21,-4,11,-2,-11,5,-16,11,-2,8,
  15,-5,15,-13,0,-4,-10,13,-7,18,
  3,2,7,-16,6,-14,3,6,-1,20,
  -6,12,-5,-9,3,-17,11,-4,9,12,
  -5,13,-15,2,-7,-7,12,-7,19,-1,
  5,4,-16,7,-16,6,3,1,19,-7,
  13,-10,-6,0,-16,13,-6,13,7,-3,
  11,-17,5,-11,-3,9,-6,20,-5,8,
  -1,-13,6,-17,10,-2,5,16,-7,14,
  -13,-1,-4,-12,13,-7,17,3,2,9,
  -16,7,-15,1,5,-4,20,-7,11,-6,
  -9,3,-17,12,-5,11,11,-5,13,-16,
  3,-8,-7,11,-8,20,-3,6,3,-14,
  7,-17,7,0,2,17,-8,14,-11,-2,
  -1,-13,14,-8,16,5,0,11,-16,7,
  -13,0,6,-5,20,-7,12,-3,-8,6,
  -16,13,-5,9,11,-6,14,-15,5,-7,
  -7,12,-8,20,-2,6,5,-13,9,-16,
  8,0,2,17,-8,15,-10,-1,0,-11,
  14,-8,15,3,0,10,-16,9,-13,3,
  7,-3,20,-7,13,-4,-7,5,-15,14,
  -5,11,10,-4,14,-15,5,-8,-4,11,
  -7,19,-5,7,2,-11,8,-15,11,-1,
  4,14,-7,14,-13,1,-4,-9,12,-8,
  17,0,2,5,-14,8,-13,6,3,0,
  16,-7,13,-9,-3,0,-12,12,-7,13,
  3,0,9,-14,7,-12,2,5,-3,16,
  -7,10,-6,-6,3,-13,12,-6,10,6,
  -3,11,-14,6,-9,-1,7,-5,17,-5,
  9,-2,-8,6,-13,11,-4,6,8,-5,
  11,-13,4,-6,-4,9,-7,16,-4,6,
  1,-10,7,-14,9,-3,3,10,-7,12,
  -11,3,-3,-6,11,-8,15,-3,3,4,
  -12,8,-13,7,-1,0,13,-8,12,-10,
  1,0,-8,12,-8,13,0,1,6,-13,
  8,-11,6,3,-1,14,-8,11,-8,-3,
  2,-10,13,-6,12,2,-2,8,-13,8,
  -9,4,5,-2,15,-7,10,-6,-4,4,
  -10,13,-5,10,5,-2,9,-12,7,-8,
  2,6,-4,15,-6,9,-3,-5,4,-10,
  12,-4,9,5,-3,9,-11,7,-5,1,
  8,-3,14,-5,7,-2,-5,6,-10,10,
  -4,7,5,-4,8,-11,5,-5,1,8,
  -4,13,-5,6,-3,-5,4,-9,10,-3,
  7,5,-3,8,-11,5,-6,0,7,-4,
  13,-5,6,-3,-6,4,-9,10,-3,7,
  5,-4,8,-11,5,-6,0,6,-4,12,
  -6,5,-4,-6,4,-9,10,-4,7,5,
  -4,7,-11,5,-6,1,6,-4,12,-6,
  6,-3,-5,5,-8,10,-4,7,3,-3,
  7,-11,5,-6,2,6,-3,12,-7,6,
  -5,-5,3,-8,10,-4,7,3,-3,6,
  -11,6,-6,3,6,-2,12,-7,6,-5,
  -4,3,-7,11,-3,9,3,-2,6,-10,
  7,-6,3,5,-1,12,-6,7,-5,-2,
  3,-7,11,-4,9,2,-1,6,-10,6,
  -6,5,4,-1,10,-6,7,-6,-1,2,
  -5,10,-4,9,0,-1,4,-8,7,-7,
  5,3,1,9,-6,7,-7,1,1,-4,
  9,-4,10,-2,1,2,-8,6,-7,8,
  2,3,8,-5,7,-8,3,0,-1,9,
  -3,11,-3,3,0,-6,6,-7,9,1,
  4,7,-4,7,-8,4,-2,0,7,-3,
  10,-4,4,-1,-5,5,-6,9,-2,6,
  4,-3,6,-9,4,-4,2,6,-2,10,
  -5,5,-3,-2,3,-5,9,-3,7,1,
  -2,4,-8,5,-5,4,3,0,8,-5,
  5,-5,0,1,-4,8,-4,8,-2,0,
  1,-7,5,-6,6,1,2,6,-5,6,
  -7,3,-1,-1,7,-3,9,-4,2,-1,
  -5,4,-6,7,-1,4,3,-4,4,-8,
  3,-4,2,5,-2,8,-5,4,-3,-2,
  3,-4,9,-3,6,1,-2,4,-7,6,
  -5,5,3,0,7,-6,5,-5,1,2,
  -2,9,-3,8,-3,0,1,-6,6,-5,
  7,0,3,5,-5,6,-7,4,-1,0,
  7,-3,9,-4,4,-1,-3,6,-5,9,
  -2,6,3,-3,5,-7,6,-3,4,5,
  -1,8,-6,5,-4,1,3,-3,9,-3,
  7,-2,-1,2,-6,6,-4,7,2,2,
  6,-5,6,-6,4,1,1,8,-3,8,
  -4,3,-1,-3,5,-4,9,-1,5,2,
  -3,4,-7,6,-2,5,5,-1,7,-6,
  5,-4,0,3,-3,9,-3,7,-1,-1,
  2,-6,6,-4,7,2,1,5,-5,5,
  -6,3,1,0,8,-3,7,-4,1,-1,
  -5,5,-5,8,-1,3,3,-5,5,-7,
  4,-2,2,5,-3,7,-6,3,-3,-1,
  4,-4,9,-3,5,-1,-3,3,-7,6,
  -3,5,3,0,7,-6,5,-5,1,2,
  -2,8,-4,7,-2,0,1,-6,6,-5,
  7,0,1,4,-6,5,-6,3,0,0,
  7,-4,7,-4,2,-1,-4,6,-4,8,
  -2,3,2,-4,5,-6,5,-1,3,6,
  -3,8,-5,3,-2,-2,5,-4,9,-3,
  4,1,-3,5,-6,6,-2,4,4,-2,
  7,-5,5,-3,0,4,-3,8,-3,6,
  0,-1,4,-6,7,-3,5,2,-1,6,
  -5,6,-4,2,3,-2,8,-4,7,-2,
  0,3,-5,7,-4,7,1,1,5,-5,
  7,-5,4,2,-1,8,-4,8,-3,2,
  2,-4,7,-4,7,-1,1,4,-5,6,
  -6,5,0,0,7,-4,7,-5,2,0,
  -4,6,-5,7,-2,2,3,-5,6,-6,
  5,-1,0,6,-4,7,-5,3,-1,-3,
  6,-5,8,-2,3,2,-4,6,-7,5,
  -2,1,4,-4,7,-5,4,-1,-1,5,
  -5,7,-3,3,1,-4,5,-6,6,-2,
  2,4,-4,7,-6,4,-1,-1,5,-4,
  7,-4,3,0,-3,5,-5,6,-2,3,
  4,-4,6,-6,4,-2,-1,5,-4,7,
  -4,3,0,-3,5,-5,7,-2,3,3,
  -3,6,-5,5,-2,0,5,-4,7,-4,
  3,0,-2,6,-5,7,-2,3,3,-4,
  6,-5,5,-1,0,5,-4,7,-4,3,
  0,-3,5,-5,7,-2,2,3,-4,6,
  -5,5,0,0,6,-3,7,-3,2,1,
  -3,5,-4,7,0,3,4,-3,6,-4,
  4,1,0,6,-3,6,-3,1,1,-3,
  6,-3,6,1,2,5,-4,5,-4,3,
  1,-1,7,-3,6,-1,1,2,-3,6,
  -3,5,1,0,5,-4,5,-3,2,2,
  -1,6,-3,5,-1,0,3,-4,5,-3,
  4,2,-1,5,-4,4,-3,1,3,-2,
  7,-3,4,-1,-2,3,-5,5,-2,3,
  3,-2,5,-4,4,-2,0,3,-2,7,
  -2,3,0,-3,3,-4,5,-1,2,4,
  -3,5,-4,2,-1,-1,4,-3,6,-2,
  2,1,-4,4,-4,4,0,1,5,-2,
  5,-3,1,0,-3,5,-3,6,0,1,
  2,-4,4,-4,3,1,0,6,-3,4,
  -3,-1,1,-3,5,-2,5,1,0,4,
  -4,3,-3,2,3,-1,6,-2,4,-1,
  -2,3,-4,5,-1,3,3,-1,4,-4,
  3,-2,0,4,-1,7,-1,3,1,-3,
  3,-4,4,0,2,5,-2,4,-3,1,
  0,-1,6,-1,6,0,1,2,-4,4,
  -3,3,2,1,6,-2,4,-2,0,2,
  -3,6,-1,4,2,-1,4,-5,3,-2,
  1,4,-1,6,-2,3,0,-2,3,-3,
  6,1,3,5,-2,5,-4,2,0,0,
  6,-1,6,-1,1,2,-4,4,-3,4,
  2,1,5,-3,4,-3,-1,2,-2,6,
  -1,5,1,-1,3,-4,3,-2,2,4,
  -1,6,-2,3,-1,-2,3,-3,5,0,
  3,4,-2,4,-4,1,0,-1,5,-1,
  6,-1,0,1,-4,3,-3,3,2,0,
  5,-3,3,-3,-2,2,-3,5,-1,4,
  2,-2,3,-5,2,-1,1,4,-1,6,
  -2,1,0,-3,3,-3,5,1,1,4,
  -3,3,-4,0,1,-2,5,-1,4,0,
  -1,2,-5,3,-2,2,4,-1,6,-3,
  2,-1,-2,3,-3,5,0,2,3,-3,
  4,-4,2,1,0,6,-1,5,-1,0,
  2,-4,4,-2,4,3,0,6,-3,3,
  -2,-1,3,-3,7,0,4,2,-3,4,
  -4,3,0,1,6,-1,6,-1,1,1,
  -4,5,-2,5,3,1,6,-3,4,-3,
  0,3,-2,7,-1,4,1,-2,3,-5,
  3,-1,2,5,-1,6,-2,1,0,-3,
  4,-2,6,2,2,5,-3,4,-3,1,
  2,-1,7,-1,5,1,-2,3,-5,4,
  -1,2,5,-1,6,-3,2,0,-3,4,
  -3,6,1,2,4,-3,3,-3,1,2,
  -1,6,-1,4,1,-2,3,-4,4,-1,
  2,4,-1,5,-3,1,-1,-3,4,-3,
  5,1,1,4,-4,3,-4,0,2,-2,
  6,-1,4,0,-3,2,-5,3,-1,1,
  4,-2,5,-3,1,0,-4,4,-2,5,
  2,0,4,-4,2,-3,0,2,-2,5,
  -1,3,1,-3,3,-5,2,-1,1,5,
  -2,5,-2,0,1,-4,4,-2,4,3,
  0,5,-3,2,-2,-1,3,-2,6,0,
  3,3,-3,4,-4,2,1,0,6,-1,
  5,-1,0,2,-3,4,-1,3,3,-1,
  5,-3,2,-2,-2,4,-2,6,1,2,
  3,-3,4,-3,1,2,0,6,-1,4,
  0,-1,3,-4,4,-1,3,4,-1,5,
  -2,2,0,-2,4,-2,5,1,2,4,
  -3,3,-3,1,2,0,6,-1,4,1,
  -1,3,-3,4,0,2,5,0,5,-2,
  1,0,-2,4,-1,5,2,2,4,-3,
  3,-3,1,3,0,6,0,3,1,-1,
  2,-3,3,0,2,4,-1,5,-2,1,
  0,-2,3,-2,4,2,1,4,-3,2,
  -2,0,2,-1,5,-1,3,0,-2,2,
  -4,2,-1,1,4,-1,4,-2,0,0,
  -2,3,-2,4,1,1,3,-3,2,-3,
  0,2,-1,5,-1,3,0,-2,2,-3,
  3,0,2,3,-1,4,-3,0,-1,-2,
  3,-2,4,0,1,2,-3,2,-3,1,
  1,0,5,-1,3,-1,-1,1,-3,3,
  -1,3,3,-1,3,-3,1,-1,-1,3,
  -1,5,1,2,2,-2,2,-3,2,1,
  1,5,0,4,0,0,1,-2,3,-1,
  3,2,0,4,-2,2,-1,0,3,0,
  5,1,3,2,-1,2,-2,3,1,2,
  5,0,4,-1,1,1,-1,4,0,4,
  2,1,3,-2,2,-2,1,3,0,5,
  0,3,0,-1,2,-2,3,1,3,4,
  0,4,-2,2,0,0,4,0,5,1,
  2,2,-2,2,-2,2,1,1,5,-1,
  3,-1,0,1,-2,3,-1,3,2,0,
  3,-3,2,-1,0,3 
};

struct SoundInfo Biiing=
{
  Biiing_data, /* WaveForm Buffers */
     10100, /* Record Rate */
      4896  /* WaveForm Length */
};

__chip BYTE LevelComplete_data[]=
{
  3,1,1,0,3,5,6,13,9,-10,
  -18,-6,8,13,-1,-15,-3,7,7,1,
  -8,-2,8,6,-2,-3,-2,3,1,5,
  12,6,1,6,13,4,-9,-14,1,9,
  1,-6,-3,7,7,-3,-9,-5,2,3,
  1,-2,5,10,-1,-6,-6,7,8,4,
  -4,3,6,3,1,-4,1,3,5,0,
  0,-1,3,1,0,-4,0,2,1,0,
  2,3,2,0,-4,3,2,3,-3,-1,
  -1,2,4,3,2,1,-3,1,2,3,
  -1,-2,-1,3,0,1,-3,1,1,1,
  1,-2,1,0,1,-1,1,0,3,-1,
  0,-1,2,2,0,0,-2,0,0,1,
  -1,1,1,3,4,3,1,3,4,3,
  0,-2,1,1,1,0,0,1,1,1,
  0,1,1,3,2,0,0,1,3,3,
  2,1,1,1,1,-1,-1,0,1,1,
  0,0,0,2,1,0,0,1,1,1,
  0,0,2,2,2,2,2,2,3,2,
  3,2,2,2,2,2,1,1,1,1,
  0,-1,-1,1,-2,1,1,2,1,1,
  1,3,3,1,-1,2,5,5,0,0,
  0,4,5,1,-1,2,4,2,0,-3,
  2,1,0,-2,-1,2,3,3,0,2,
  1,2,1,-1,1,5,6,1,-4,-1,
  3,7,3,-4,-4,0,3,1,-2,-5,
  -2,2,4,0,0,3,5,5,-1,-3,
  2,5,7,0,-1,-4,0,2,6,5,
  -2,-4,-4,4,3,-1,-6,-6,1,4,
  6,-2,-1,-3,5,5,4,-1,-1,1,
  3,2,0,-4,-3,1,1,5,4,-1,
  -3,0,2,4,3,-2,-5,-3,2,2,
  3,-3,-3,1,3,2,2,-2,1,5,
  4,0,-3,-2,2,5,-2,-4,-3,2,
  6,-1,-5,-5,6,7,1,-3,3,6,
  5,0,-2,5,8,-1,-8,-5,5,9,
  0,-8,-6,1,5,1,-3,-1,3,1,
  6,4,8,13,10,-6,-20,-7,8,16,
  -1,-7,-8,2,6,1,-1,2,4,-2,
  -3,0,2,4,-1,1,2,6,5,2,
  1,2,0,-1,8,3,-5,-8,8,16,
  5,-10,-13,-2,23,16,-10,-21,1,18,
  6,-9,-8,2,11,37,2,-45,-2,43,
  8,-24,-23,-4,20,17,-18,-19,7,12,
  3,-7,3,14,23,-6,-25,-3,27,20,
  -11,-18,-1,16,5,-10,-18,-1,16,7,
  -6,-13,-2,10,13,3,-9,-12,5,11,
  19,0,-15,-7,20,10,-7,-4,23,26,
  -22,-36,7,23,-6,-22,-23,6,7,5,
  0,-9,-9,5,7,3,3,-4,7,9,
  9,5,3,0,1,-5,-5,4,8,2,
  -11,-6,-3,6,-7,-8,-11,30,20,-41,
  -33,51,37,-21,-28,-13,13,28,1,-22,
  1,16,2,-11,-16,1,20,2,-20,-3,
  23,17,-12,-33,-18,23,15,-13,-20,23,
  30,-2,-16,-9,7,14,9,-8,-10,10,
  13,3,-8,-15,12,31,5,-18,-29,-10,
  30,35,-3,-19,-2,21,4,-12,-11,8,
  12,-3,-9,-11,1,6,5,6,1,-14,
  -5,18,24,-20,-23,34,42,-21,-39,0,
  43,48,-31,-67,-2,58,38,-13,-64,-27,
  43,49,-16,-48,-25,31,18,-18,-8,18,
  -9,-8,11,12,3,1,0,11,3,-1,
  13,22,-2,-17,-9,3,23,13,-11,-12,
  -1,13,21,-1,-19,7,21,6,-13,-22,
  -7,14,24,-1,-16,-10,4,14,2,-20,
  7,23,20,-5,-36,-18,25,18,-2,-15,
  -17,4,31,-14,-19,38,11,-56,-31,29,
  36,-6,-25,-17,-11,25,16,-21,-18,2,
  -1,24,19,-10,-2,21,9,-3,-2,-4,
  11,12,-4,-11,9,9,-2,-10,3,0,
  -4,-2,24,-3,-20,0,28,8,-12,1,
  14,10,-8,-6,2,16,5,-22,-33,-14,
  18,24,-3,-29,-28,7,27,9,-13,-15,
  0,3,-5,2,11,9,-5,-9,1,4,
  22,28,-8,-13,8,-1,-1,28,17,-13,
  -19,-2,5,11,-3,-7,17,10,-31,-28,
  7,25,12,-11,-13,3,8,20,39,-14,
  -50,-11,29,30,-5,-29,-15,27,16,-11,
  -21,-10,-1,12,19,5,4,5,5,-1,
  -4,-2,16,8,-3,3,-4,-26,5,9,
  3,1,-9,-12,11,7,-3,-18,-10,21,
  32,-9,-21,-6,12,20,-2,-19,0,20,
  20,3,-15,-13,4,18,19,-4,-13,0,
  14,18,18,-3,-9,16,16,2,-22,-6,
  25,27,2,-24,-27,-5,10,9,-15,-16,
  -5,5,1,-10,-11,-6,21,38,-7,-38,
  -20,5,-3,-12,19,27,-13,-35,-30,13,
  32,-2,-22,4,-3,-13,0,4,13,7,
  -12,6,21,22,9,-7,-2,7,17,31,
  8,-6,3,20,11,-1,-9,-5,0,2,
  0,-7,-3,-5,5,-4,-11,-3,-17,-6,
  5,-1,-2,-6,-12,-14,-10,7,10,-2,
  -10,-5,24,15,-20,-27,0,23,25,-3,
  -18,-23,15,34,26,3,-20,-5,23,38,
  13,-19,-19,2,23,27,-10,-28,-11,21,
  28,3,-25,-17,9,26,10,-27,-32,5,
  29,10,-36,-32,9,19,-1,-25,-18,14,
  8,-7,-12,1,9,5,-5,-17,-2,25,
  23,-4,-9,-5,7,28,16,-6,-3,-5,
  12,12,1,7,11,5,-4,1,5,7,
  10,2,-9,-7,4,6,2,-8,4,17,
  18,-8,-20,3,14,1,-5,-1,6,-3,
  -26,-8,19,8,-15,-16,2,6,7,8,
  -5,-9,2,14,13,2,-22,-13,15,32,
  6,-17,-8,4,6,-6,-7,13,24,-8,
  -31,-17,11,32,3,-24,-20,-6,9,17,
  16,-6,-12,14,24,-3,-24,1,35,22,
  -17,-29,-1,27,32,-4,-39,-32,16,42,
  16,-16,-32,-10,13,16,-3,-14,-9,17,
  22,3,-18,-12,19,21,3,-19,-4,14,
  16,-3,-19,-33,-28,8,49,40,-26,-57,
  -18,40,38,0,-17,-9,7,26,28,5,
  -22,-13,14,2,-9,-4,-4,9,-2,-13,
  -15,5,0,4,-8,-9,0,11,9,5,
  -10,-15,-10,-9,6,17,7,-10,-2,11,
  11,9,12,-3,-7,1,20,30,1,-20,
  -16,6,20,6,-14,-12,2,12,6,2,
  -3,1,-2,-1,-1,5,1,-19,-13,3,
  4,12,17,3,-10,-19,5,28,23,6,
  -16,0,15,21,8,-19,-23,4,8,3,
  -4,-3,8,-15,-28,-11,6,15,6,-8,
  -10,-17,-5,3,8,2,-12,14,15,7,
  -4,7,6,19,35,26,2,-17,-5,15,
  21,1,-18,-18,-2,6,1,-14,-17,-3,
  3,1,-24,-17,18,37,14,-10,-12,5,
  24,19,-1,-4,-4,0,12,12,6,6,
  -12,-8,-5,-1,-1,1,-8,-11,-12,-10,
  3,2,-15,-13,3,19,1,-29,-18,31,
  48,16,-20,-18,15,53,28,-21,-37,-5,
  35,41,-1,-34,-24,-5,23,9,-17,-21,
  -10,10,0,-8,-13,1,13,4,-14,-22,
  -12,12,7,-5,-9,-9,-6,-2,-6,-12,
  -12,8,14,6,-3,2,35,32,11,4,
  -9,2,24,14,1,-7,-5,-2,2,1,
  -4,-9,-15,-5,4,10,3,-13,-12,15,
  24,21,-5,-14,-6,8,11,1,-11,-17,
  -5,7,5,-10,-12,-7,16,12,4,-18,
  -17,19,34,15,-1,2,0,7,19,2,
  -8,-16,-5,9,4,-5,-11,-15,-4,14,
  17,11,5,6,9,13,14,5,-12,0,
  -14,-1,-6,-10,-16,-23,-18,5,9,0,
  -1,-15,4,13,13,1,-11,-4,3,1,
  11,19,9,1,6,10,15,6,-7,3,
  18,15,-6,-15,6,10,0,5,6,11,
  14,10,5,2,-10,-18,-15,-9,1,-7,
  -11,-12,-6,-11,-8,-7,9,12,15,3,
  -11,10,27,8,-18,-19,2,29,21,-14,
  -25,-8,35,17,-34,-31,-3,28,23,-7,
  -20,-7,23,36,8,-35,-16,18,43,6,
  -15,-18,3,19,19,1,-7,2,6,4,
  0,-7,-21,-22,-21,-28,-21,13,10,6,
  -16,-30,-5,20,21,0,-6,5,26,18,
  12,6,2,5,12,27,19,-15,-29,3,
  20,32,-10,-28,-19,10,31,-2,-38,-16,
  -1,2,4,-21,-12,-13,-2,15,21,12,
  0,-5,-9,3,7,8,10,13,9,-3,
  -3,-4,-18,1,1,8,-8,-15,-21,22,
  18,-15,-18,-13,5,5,3,-23,15,47,
  19,-25,-21,21,44,21,-25,-22,-1,21,
  27,12,-7,10,15,1,-9,-13,3,15,
  -3,-1,-8,-8,-2,3,-5,-4,-10,-4,
  24,26,6,-5,-8,1,13,17,-1,-23,
  -17,-1,8,15,3,1,18,-9,-24,-17,
  0,8,8,-1,-4,-6,-6,-2,5,10,
  -1,-18,-11,14,40,7,1,-9,-4,18,
  23,1,-8,-15,-1,23,21,10,19,-17,
  -15,2,-9,-15,-21,3,7,21,-3,-15,
  -17,3,16,10,-8,-11,-12,-1,-9,-7,
  -1,7,0,-4,-7,4,11,-13,-24,-27,
  -2,20,30,25,10,-14,-7,4,12,4,
  8,21,15,25,19,12,-2,-5,-5,14,
  5,-33,-34,-20,2,11,-11,-28,-30,10,
  17,28,1,-20,-7,15,27,19,-5,-11,
  -3,3,-9,-27,-4,12,19,3,-19,-18,
  3,22,27,8,-9,2,36,17,-20,-31,
  -7,10,25,4,-24,-25,-13,29,38,10,
  -29,-28,3,42,38,6,-23,-22,0,28,
  33,6,-25,-22,0,28,38,-13,-39,-38,
  -3,23,6,-11,-16,-5,6,14,-2,-3,
  -14,-7,10,20,11,-5,-27,-12,17,31,
  18,10,-12,-19,-3,9,20,-6,-8,-11,
  1,0,-1,1,-14,-4,3,20,18,4,
  -9,-1,1,-2,-9,10,19,8,4,-6,
  -2,7,0,-7,-9,-7,0,9,-1,-27,
  -23,-13,15,25,22,-10,-8,10,30,27,
  23,3,-8,-1,8,20,9,-5,-17,-5,
  8,20,10,-15,-32,-24,-8,6,6,-7,
  -16,11,30,25,22,4,5,-1,-9,-12,
  13,5,-7,-22,-20,-8,-9,-21,-30,-31,
  -19,-1,0,-1,-19,-12,19,24,9,-18,
  -15,-11,13,31,11,-9,-9,13,0,13,
  31,38,18,-4,-2,16,21,-9,-15,-15,
  7,22,12,-9,-17,-5,13,10,1,-6,
  9,20,12,-8,-7,-4,11,21,6,-12,
  -23,-9,-1,5,-6,-9,-16,-13,-1,2,
  7,7,1,-10,-11,-18,-3,6,13,8,
  7,-11,-20,5,16,10,-9,-16,-3,23,
  43,13,-3,-14,1,18,26,12,5,-22,
  1,17,-1,-18,-19,3,24,21,-19,-22,
  -12,11,10,-10,-17,-5,10,11,2,-8,
  -6,-1,13,8,-5,-14,-7,8,15,12,
  -9,-2,2,6,2,-11,-19,-13,-2,36,
  22,5,-9,11,18,17,7,-11,-10,2,
  18,4,-7,-23,-20,15,35,28,-5,-26,
  -24,20,31,22,-3,-27,-11,6,23,0,
  -36,-37,1,22,16,-12,-17,-8,10,13,
  14,0,1,1,-2,8,16,35,10,-16,
  -35,2,39,15,-30,-37,-29,-1,23,7,
  -8,-17,1,13,19,19,18,14,3,6,
  -1,-10,-7,-2,-7,-16,-26,-33,-7,5,
  11,8,-27,-33,-29,10,29,20,3,-9,
  10,17,24,-1,5,12,1,-9,-3,4,
  10,19,3,-18,-17,-3,10,11,1,20,
  21,28,10,-3,-14,3,25,18,1,-25,
  -33,-11,15,11,8,-1,-2,11,12,4,
  -3,-9,5,8,7,-7,-28,-32,-7,7,
  -5,-22,-21,-2,6,-3,-12,-10,-1,6,
  -3,4,11,18,24,1,3,15,23,8,
  17,10,8,21,9,-3,-11,-25,-31,-12,
  0,4,-6,-22,-20,1,17,21,20,8,
  4,-1,3,13,7,-6,-15,-22,-2,31,
  16,-23,-25,5,73,60,11,-48,-45,6,
  29,59,31,-17,-45,-34,-5,14,11,-2,
  -21,-20,-3,12,14,-6,-11,-15,6,12,
  8,-1,2,-7,7,25,24,7,-16,-21,
  -6,11,6,-17,-37,-20,9,17,11,-9,
  -13,-1,8,16,-6,-27,-23,7,31,36,
  13,-12,-13,-5,4,21,24,2,-12,-23,
  -8,18,19,-1,-13,-6,2,10,5,33,
  32,17,-4,-18,-10,13,20,17,-4,-26,
  -27,-12,10,18,-2,-28,-23,0,23,21,
  8,-18,-22,-9,5,16,10,-6,-22,-17,
  -7,7,-3,-12,-16,-20,-13,2,20,18,
  7,-7,7,21,29,11,-26,-21,1,17,
  14,4,-23,-27,-16,-2,5,8,6,4,
  -2,2,7,14,18,13,2,0,14,26,
  33,9,-7,-6,16,4,14,9,11,5,
  0,-7,-21,-13,0,11,3,-6,-19,-12,
  24,16,4,-27,-20,0,19,15,1,-17,
  -17,-9,3,0,-2,-16,-21,-10,7,21,
  3,-4,0,14,33,12,-16,-33,-12,14,
  37,27,0,-13,-13,-7,22,30,11,-5,
  -19,-8,-9,-1,1,-7,-16,-23,-18,-11,
  -3,7,10,-2,-21,-39,-15,46,53,49,
  17,-3,0,9,14,11,9,-3,11,18,
  21,19,6,-17,-17,4,11,3,-18,-32,
  -21,0,15,8,-8,-21,-28,-11,-8,-3,
  -7,4,15,16,9,9,11,5,8,13,
  10,2,3,-4,-21,-25,-8,-1,23,11,
  -8,-23,-18,-1,11,7,2,-13,-16,-15,
  -11,6,17,11,-5,-15,-12,8,13,5,
  -22,-17,6,27,42,32,21,2,-9,2,
  13,20,3,-24,-13,4,38,7,-12,-38,
  -11,21,30,19,-45,-56,-45,12,31,23,
  -12,-32,-17,14,33,57,23,0,-38,-26,
  5,24,15,1,-7,-13,-10,-1,21,35,
  40,-11,-75,-61,-27,32,31,-1,-41,-12,
  26,35,25,-13,-13,1,37,40,33,-9,
  -12,-5,24,24,8,-12,-18,-15,-8,4,
  4,2,-12,-15,-12,-9,-1,-2,-9,-12,
  -5,7,34,25,12,5,2,8,25,32,
  11,-13,-33,-33,-7,16,11,-13,-33,-35,
  -9,4,11,11,-5,-22,-5,10,10,7,
  2,5,22,30,15,10,-8,4,-1,0,
  -6,4,12,26,18,4,-14,-12,8,22,
  21,-3,-34,-27,9,27,20,8,-9,-11,
  -7,6,-2,-6,-7,-13,-3,-22,-15,13,
  22,22,-5,-39,-46,-31,26,32,-1,-52,
  -24,34,68,63,20,-35,-40,-12,26,31,
  1,-36,-40,-25,13,36,29,-10,-34,-35,
  -5,14,21,6,-13,-5,13,28,28,16,
  2,9,12,8,-9,-16,-14,-3,4,-2,
  -9,-14,-5,1,-9,-30,-17,9,62,41,
  -12,-44,-36,8,49,49,24,-11,-38,-30,
  0,24,28,15,-11,-20,-35,-4,25,25,
  9,-10,-25,-14,10,6,21,8,25,14,
  15,-8,-7,-25,-16,8,12,13,-1,-6,
  -13,18,1,-2,-17,-28,-19,-6,4,32,
  0,-13,-23,1,28,59,29,-11,-38,-51,
  -10,27,52,10,-50,-70,-35,28,68,48,
  -2,-41,-45,0,41,55,43,-2,-37,-26,
  -3,30,55,44,7,-34,-45,-20,30,60,
  45,-4,-41,-59,-38,11,37,33,12,-16,
  -20,-17,-5,8,21,24,8,-15,-30,-30,
  2,31,31,2,-32,-31,5,15,15,3,
  -20,-22,-19,-6,25,34,10,-11,-29,-24,
  10,21,40,17,-8,-28,-33,-23,14,12,
  -8,-4,-23,-30,6,13,39,53,24,-22,
  -22,-21,12,53,29,7,-13,-17,15,21,
  2,-18,-28,-35,-18,7,6,10,4,-10,
  -12,-3,-4,7,10,-10,-13,-31,-20,6,
  31,49,41,11,-15,-32,-26,3,28,50,
  36,10,-10,-20,-7,3,23,17,12,-6,
  -21,-43,-34,-12,3,19,9,-11,-22,-6,
  -5,6,13,15,7,-5,2,-4,6,6,
  12,13,12,5,-14,-11,-9,-12,-3,9,
  -1,-5,3,-7,3,4,8,7,16,8,
  3,-11,-21,-17,9,24,22,16,12,33,
  27,13,-4,-63,-39,-23,7,31,22,-17,
  -24,-42,-25,-2,11,20,13,28,28,10,
  -2,5,15,15,1,-21,-24,-7,13,31,
  7,-17,-23,-25,2,19,24,11,-11,-34,
  -23,-9,24,22,-1,-32,-51,-9,26,62,
  51,25,-5,-12,-20,-3,2,5,20,20,
  24,11,-11,-16,-16,3,18,17,4,-1,
  -13,-8,-1,0,1,-7,-17,-21,-15,-5,
  9,6,4,-16,-14,-13,-17,2,14,27,
  33,15,-1,-2,-11,-15,-17,-12,7,11,
  19,10,-6,-19,-14,-8,13,21,45,29,
  10,-27,-34,-25,8,44,52,27,-12,-44,
  -45,-27,9,31,30,12,-10,-19,-15,-7,
  12,21,27,7,-13,-23,-16,4,6,6,
  2,-2,-8,-4,-11,-8,6,3,-3,-9,
  -20,-9,-2,12,20,14,-11,-23,-21,3,
  28,36,21,3,2,-5,-3,6,18,22,
  11,-10,-18,-19,-11,0,5,12,-1,-15,
  -30,-28,-2,15,30,24,5,-4,-10,-13,
  -8,-7,14,21,29,17,-3,-8,-20,5,
  7,13,7,3,-9,-5,-11,-1,3,-3,
  4,9,21,12,9,-3,-8,-7,5,18,
  26,31,14,-3,-18,-22,-22,-6,7,20,
  15,13,1,-5,-6,0,7,0,-2,-17,
  -27,-19,-1,12,18,-1,-13,-17,-15,-2,
  6,22,17,0,-3,-11,1,6,10,10,
  12,13,9,-8,-19,-18,-22,0,0,-4,
  -9,-2,2,8,-4,-6,-6,-2,13,13,
  10,4,12,5,7,4,3,2,10,1,
  0,-2,6,9,10,4,0,5,5,5,
  4,-3,-4,2,-4,-2,1,2,3,1,
  -7,-9,-7,-4,5,3,3,5,-7,-10,
  -7,-12,-4,-3,-1,3,0,-4,-5,-6,
  2,-5,2,5,4,3,4,-5,-2,-1,
  0,16,11,-2,7,-2,7,0,-5,-3,
  3,8,11,4,3,6,7,10,-5,-4,
  -8,-7,0,6,4,3,-6,-12,-12,-8,
  -2,6,7,8,8,2,0,1,-6,-2,
  1,8,4,-1,-5,-1,-1,-1,-1,-1,
  -3,1,3,3,2,4,1,5,7,0,
  1,1,2,6,7,-2,-2,-5,4,2,
  6,-1,1,-2,-2,-1,-3,7,7,7,
  8,2,-5,3,0,8,13,9,1,-3,
  -5,-2,-2,4,7,2,0,-2,-4,1,
  3,2,2,-4,-6,-3,3,5,1,-3,
  -5,-8,-3,-1,-3,-3,-4,-8,-2,1,
  1,3,-1,-4,-1,2,1,3,1,5,
  3,3,3,10,8,2,-1,-1,-1,4,
  4,7,6,5,5,-2,-1,2,4,7,
  6,4,5,4,4,-1,-2,1,-1,0,
  3,5,3,4,-5,-4,0,-1,0,-1,
  -3,1,2,-2,-6,-8,-4,0,6,6,
  1,-2,-5,-4,-3,0,1,1,1,-2,
  3,1,4,1,-6,-6,-5,-6,3,5,
  6,9,6,6,1,-4,-5,-5,-4,2,
  2,4,6,3,1,2,-1,-1,-1,-3,
  3,2,5,6,7,7,6,3,4,4,
  6,2,1,0,1,3,4,3,2,4,
  4,5,3,1,0,2,2,3,1,0,
  0,0,-2,-3,-2,1,3,1,-4,-5,
  -3,1,1,0,-1,-1,1,-1,-1,0,
  2,4,2,-1,0,0,3,3,2,2,
  3,4,3,1,0,3,3,5,8,10,
  9,8,6,5,4,6,6,6,4,2,
  1,0,-1,-2,-2,-2,-3,-5,-5,-5,
  -4,-2,-1,-3,-5,-6,-5,-3,-1,-1,
  -1,-1,-1,-1,0,0,0,1,4,5,
  3,0,0,2,4,4,2,1,0,0,
  1,0,1,1,1,-1,-1,-1,1,1,
  1,1,1,1,2,2,1,0,-2,-5,
  -5,0,5,5,2,-3,-4,-1,0,0,
  -1,-1,-1,-1,-2,-1,0,3,3,3,
  1,0,0,0,0,1,2,3,3,2,
  1,2,3,3,2,1,1,1,1,1,
  2,2,2,1,0,0,-1,-2,-2,-2,
  -1,0,1,1,1,1,0,0,-1,-1,
  -1,-1,-1,-1,2,4,3,2,0,0,
  2,3,3,2,0,0,1,2,3,3,
  3,3,2,1,2,2,2,2,2,1,
  2,2,1,2,3,2,1,1,0,1,
  1,2,1,1,1,1,2,2,1,0,
  0,0,0,0,1,1,2,2,1,2,
  2,2,2,2,2,1,1,1,2,3,
  3,1,1,1,1,2,2,2,2,1,
  1,1,2,2,2,2,1,1,0,0,
  1,1,1,1,0,0,0,1,2,1,
  1,1,1,1,2,1,1,0,0,1,
  1,1,1,1,1,1,0,0,1,1,
  1,1,1,1,1,1,0,0,0,0,
  0,1,0,1,0,0,1,0,0,0,
  0,0,1,1,1,1,1,1,0,0,
  1,1,1,1,1,1,0,0,0,0,
  0,1,1,1,0,0,0,1,1,1,
  1,1,1,0,0,0,0,1,1,2,
  1,1,0,0,0,1,1,1,1,0,
  0,0,0,1,1,1,1,0,0,0,
  1,1,1,1,1,1,1,1,1,1,
  2,1,1,2,2,2,2,2,1,2,
  2,2,2,2,1,1,1,1,2,2,
  2,2,1,1,2,2,2,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,2,2,1,1,1,1,1,1,
  1,2,2,2,2,2,1,1,1,1,
  1,2,2,2,1,1,1,1,1,1,
  1,1,1,1,1,0,1,1,1,1,
  1,0,0,0,1,1,1,1,1,0,
  0,0,1,1,1,1,1,0,0,1,
  1,1,0,0,0,1,1,1,1,0,
  0,0,0,1,1,0,0,0,0,0,
  0,0,0,0,0,0,1,1,1,1,
  1,0,0,0,0,1,1,1,1,1,
  0,0,0,0,1,1,1,1,0,0,
  1,1,1,1,1,1,0,1,1,1,
  1,1,1,0,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,2,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,2,1,1,1,1,1,
  2,2,2,1,1,1,1,2,2,2,
  2,1,1,1,1,2,2,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,2,2,1,1,1,1,2,2,1,
  1,1,1,1,2,2,1,1,1,0,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,0,0,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,0,1,1,1,1,1,1,1,
  0,0,0,1,1,1,1,0,1,0,
  0,1,1,1,1,0,1,1,1,1,
  1,1,1,0,1,1,1,0,0,0,
  0,0,0,1,0,1,0,1,1,1,
  0,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,2,
  2,2,1,1,1,2,2,2,2,2,
  1,1,1,1,1,1,1,1,1,1,
  1,1,2,1,1,1,1,1,1,2,
  2,2,2,2,1,1,2,2,2,1,
  2,2,2,1,1,1,1,1,1,1,
  2,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,0,0,
  0,0,0,0,1,0,0,0,0,0,
  1,0,1,0,0,0,1,0,0,0,
  0,0,0,0,0,0,0,0,0,0,
  0,1,1,0,0,1,1,1,1,0,
  0,0,0,0,0,0,0,1,0,0,
  0,0,0,0,0,0,1,1,0,0,
  0,0,1,0,0,0,0,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,2,2,
  2,2,2,2,2,2,2,2,1,1,
  1,1,1,1,1,1,1,1,2,1,
  1,1,1,1,1,2,2,2,2,2,
  1,2,2,2,2,2,2,2,2,2,
  2,2,2,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,0,1,
  1,1,1,0,0,0,0,0,0,0,
  0,0,0,0,1,1,1,1,1,1,
  1,1,1,0,1,0,1,1,1,0,
  0,0,0,0,0,1,1,1,0,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,2,1,1,1,
  1,1,1,1,1,1,2,2,2,2,
  1,1,2,2,2,2,2,1,2,2,
  2,1,1,1,1,1,1,2,2,2,
  1,1,2,1,1,1,2,1,1,1,
  2,2,1,1,2,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,0,1,1,1,1,1,1,1,
  0,0,0,0,1,0,0,0,1,1,
  1,1,1,1,1,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,1,0,0,
  1,1,1,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,2,
  2,2,2,2,2,2,2,2,1,2,
  2,2,1,1,1,1,1,1,1,1,
  1,2,1,1,1,2,2,2,2,2,
  2,2,2,2,2,2,2,2,2,2,
  1,1,1,2,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,0,0,1,1,1,1,0,
  1,1,0,1,1,1,1,1,1,1,
  1,1,1,1,1,1,0,1,0,0,
  1,1,0,0,0,0,1,0,1,1,
  1,0,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,2,2,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,0,1,1,1,0,
  0,1,1,0,0,0,1,1,0,0,
  0,0,0,0,1,0,0,0,0,0,
  1,1,0,0,0,0,0,0,1,1,
  1,1,1,1,1,1,1,0,0,0,
  0,0,1,0,0,0,0,0,1,1,
  0,0,1,0,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,2,2,1,1,1,
  2,2,2,2,2,1,1,1,2,2,
  1,2,2,1,1,1,1,1,1,1,
  1,1,1,1,2,2,2,2,2,1,
  2,2,2,2,2,2,2,2,2,1,
  2,1,2,2,2,1,1,1,1,2,
  2,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,0,
  1,1,1,1,1,1,1,0,0,0,
  0,0,0,0,0,1,0,1,1,1,
  1,1,1,0,1,1,0,1,0,0,
  1,0,1,1,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,1,1,
  1,0,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,2,1,2,
  2,1,2,2,1,1,2,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,2,1,1,2,2,
  2,2,1,1,1,1,1,1,1,1,
  1,1,2,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,0,1,1,1,1,1,1,1,1,
  1,1,1,1,0,1,1,0,0,0,
  1,0,0,0,0,0,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,0,1,1,
  0,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,2,1,2,1,1,
  1,2,1,2,1,2,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,0,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,0,0,1,
  0,1,0,0,0,1,0,0,0,0,
  0,0,0,0,0,0,0,1,1,1,
  0,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,0,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,2,2,
  1,1,1,2,1,1,1,1,1,1,
  1,1,1,1,1,2,1,1,1,1,
  1,1,1,1,2,2,1,1,2,2,
  2,2,2,1,2,2,1,2,2,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,0,0,0,1,
  0,1,1,1,0,1,1,0,0,0,
  1,0,1,0,1,1,1,0,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,0,1,0,0,0,0,
  0,0,0,0,0,1,1,0,0,1,
  1,1,1,1,0,1,0,0,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,2,2,2,
  2,2,2,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,2,1,1,1,
  1,2,1,2,2,1,1,1,1,2,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,0,1,1,1,0,0,
  0,0,0,1,1,1,0,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,0,0,0,0,0,1,1,
  0,0,1,1,1,0,1,0,1,0,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,2,2,2,2,2,
  2,3,27,106,-10,-29,-69,-51,-52,-7,
  21,24,6,-7,2,0,11,11,14,17,
  15,33,39,23,15,1,-3,1,-17,-35,
  -39,-34,-32,-23,-22,-14,-12,-5,-5,7,
  8,10,13,23,26,24,29,18,17,20,
  27,24,29,35,36,55,17,19,19,18,
  -33,-70,-107,-107,-91,-58,-19,-3,-10,-24,
  -23,-20,-7,7,12,21,35,42,41,39,
  37,38,37,32,37,35,48,50,35,36,
  28,44,41,6,-22,-58,-76,-89,-99,-101,
  -90,-69,-35,-14,1,4,2,-13,-12,2,
  6,13,19,13,13,14,19,25,35,49,
  53,47,38,38,38,36,25,22,25,28,
  34,41,37,24,19,0,3,-16,-53,-90,
  -112,-123,-125,-124,-101,-53,-7,33,57,65,
  54,18,-20,-43,-30,10,39,38,28,10,
  -1,-2,7,15,10,13,12,9,16,29,
  41,51,48,43,37,33,32,35,29,28,
  21,28,30,28,21,16,8,-4,-32,-53,
  -81,-110,-126,-126,-126,-117,-74,-27,21,57,
  75,72,46,7,-34,-49,-39,-11,17,42,
  52,50,33,17,10,12,23,17,16,13,
  19,17,24,19,26,28,17,11,7,13,
  11,1,8,15,19,19,17,13,14,19,
  17,12,13,21,18,17,-4,0,-8,-51,
  -83,-110,-124,-126,-126,-125,-93,-26,54,107,
  125,107,50,-14,-58,-67,-45,-10,37,69,
  80,68,45,21,5,1,3,12,26,35,
  29,14,-1,-7,-3,-2,2,7,5,2,
  -2,-8,-9,-14,-19,-16,-21,-17,-6,5,
  10,12,12,4,-2,-4,1,6,15,18,
  21,19,21,29,24,19,12,3,-2,-12,
  -36,-59,-71,-70,-77,-80,-79,-60,-29,7,
  37,55,59,47,24,-4,-19,-16,-1,18,
  28,33,37,38,30,13,-6,-14,-10,3,
  14,18,18,17,14,8,3,-1,2,6,
  7,5,6,5,3,-3,-9,-9,-5,-2,
  -2,-2,-1,1,0,-4,-8,-9,-8,-6,
  -5,-7,-9,-9,-10,-10,-13,-12,-8,-5,
  -5,-6,-6,-2,3,7,7,5,5,6,
  8,8,7,5,4,5,5,6,8,8,
  9,10,9,9,9,10,8,6,4,3,
  2,-2,-3,-4,-4,-4,-3,-2,1,3,
  2,1,1,1,1,1,0,0,0,-1,
  0,1,3,4,4,2,-1,-3,-5,-6,
  -5,-2,1,3,4,4,3,2,-1,-3,
  -5,-5,-5,-3,-2,-1,0,1,4,5,
  7,8,7,6,5,2,2,2,2,2,
  1,2,2,1,1,1,1,1,0,-1,
  -1,-1,-1,-2,-2,-2,-3,-3,-4,-3,
  -1,1,3,5,7,7,6,4,1,0,
  0,0,1,1,2,1,0,-2,-4,-5,
  -6,-6,-5,-2,2,3,3,3,3,1,
  0,0,0,0,0,0,0,0,1,1,
  1,1,2,1,1,1,3,5,5,5,
  5,3,1,-1,-3,-4,-4,-4,-3,-3,
  -2,-1,0,1,3,3,4,4,4,3,
  2,2,2,2,3,4,4,2,-2,-4,
  -7,-7,-6,-3,1,3,6,7,6,5,
  2,0,-1,-2,-1,-1,1,2,3,4,
  5,5,6,4,3,1,1,1,1,2,
  3,3,2,0,-2,-2,-2,-2,-1,1,
  1,1,1,1,1,2,2,3,3,2,
  1,0,-1,-1,0,1,2,4,5,5,
  4,3,2,0,-1,-3,-3,-3,-2,-2,
  -1,0,1,1,3,4,5,6,7,7,
  7,6,5,3,1,0,-1,0,0,0,
  1,0 
};

struct SoundInfo LevelComplete=
{
  LevelComplete_data, /* WaveForm Buffers */
     10100, /* Record Rate */
      7032  /* WaveForm Length */
};

__chip BYTE GameOver_data[]=
{
  0,7,-1,6,-16,-18,1,-1,7,0,
  12,32,17,4,-5,8,33,32,27,12,
  12,24,29,23,-12,-24,-18,8,-3,-36,
  -43,-38,4,28,-6,-33,-38,-37,0,25,
  29,1,-15,-6,23,35,9,1,8,37,
  35,30,29,17,22,44,92,120,107,70,
  53,17,-23,-30,-30,-25,-57,-60,-54,3,
  9,-19,-47,-43,-29,-30,-16,1,5,0,
  -23,-6,26,27,12,-7,0,26,39,53,
  65,49,106,117,111,104,67,39,11,-23,
  -50,-65,-58,-75,-70,-67,-49,65,50,-32,
  -62,-53,-39,-12,-4,-2,-18,-32,-34,-19,
  -17,-14,2,48,50,16,43,115,118,111,
  103,79,70,30,-9,-49,-67,-62,-77,-75,
  -70,-67,-41,-34,-40,-47,-36,-18,-26,-34,
  -44,-18,7,-5,-27,-47,-45,9,54,56,
  61,89,127,119,103,78,100,94,-20,-82,
  -78,-73,-44,-67,-64,-60,-58,-55,-53,-50,
  -48,-46,-41,20,-18,-43,-41,-13,-15,-38,
  -37,51,113,108,125,127,125,117,-22,-64,
  -65,-61,-4,-6,-27,-51,-55,-53,-50,-48,
  -46,-44,-41,41,-1,28,-23,-39,-41,-39,
  -38,9,125,124,125,127,124,24,-51,-62,
  -60,-57,-25,-2,17,22,19,-40,-54,-51,
  -49,-47,-11,68,104,59,40,-43,-54,-51,
  -48,125,127,124,118,110,17,-77,-72,-69,
  -65,-45,24,78,48,29,-68,-65,-61,-59,
  -56,-3,127,123,115,33,-68,-69,-58,115,
  110,103,97,80,-89,-83,-79,-75,-71,37,
  79,78,70,-38,-79,-75,-71,-67,-64,121,
  115,109,49,-73,-72,48,104,99,93,88,
  64,-97,-90,-85,-80,-76,106,100,94,53,
  -54,-87,-82,-78,-73,-69,4,49,97,-20,
  -35,28,104,99,93,88,82,-100,-93,-88,
  -83,-78,53,100,94,89,72,-96,-90,-85,
  -80,-76,-72,-68,-17,-58,6,118,112,106,
  100,93,88,-94,-89,-83,-80,-76,-11,107,
  101,96,87,-73,-88,-82,-78,-73,-9,-68,
  -55,-62,-59,20,79,119,113,107,99,-83,
  -78,-75,-70,-67,-50,118,111,104,99,-53,
  -82,-78,-75,-70,-64,-27,-6,33,51,112,
  106,100,93,-1,-60,-87,-81,-77,-72,-69,
  -65,86,113,106,-5,-77,-72,-22,-12,-55,
  -65,-38,75,28,54,53,109,103,96,-72,
  -81,-77,-72,-69,-66,-23,71,112,106,43,
  78,17,-86,-81,-77,-72,40,107,101,96,
  89,-30,-41,-53,-85,-81,-76,-72,-69,-66,
  -11,15,83,49,28,64,93,90,39,-23,
  -77,13,96,91,86,58,57,-23,-26,-98,
  -92,-87,-82,-78,104,22,22,-81,-43,101,
  97,71,86,54,-97,86,78,17,-73,78,
  44,-104,-98,-92,-87,-81,98,93,-66,60,
  91,86,81,76,71,-73,-106,-99,-92,-60,
  -85,-80,-76,-71,-68,-65,-61,-59,-56,-54,
  -51,-49,-16,48,125,127,122,115,108,101,
  96,90,85,79,75,70,67,62,59,56,
  -83,-123,-117,-109,43,70,47,16,-8,56,
  4,62,60,57,54,-123,-122,-117,-109,-102,
  -96,-90,-85,-80,-76,-72,-69,-17,56,111,
  102,51,15,90,90,86,80,44,-59,-39,
  -57,-92,-87,-82,-78,-73,-70,-67,-64,27,
  118,78,-70,-67,-65,-61,-54,124,118,110,
  22,-76,-23,-16,-35,-68,-65,-61,-59,-56,
  -54,37,65,-55,-53,-50,-48,-20,125,127,
  124,114,-70,-66,-64,-60,-57,-55,-51,-49,
  -47,-45,124,125,127,101,-62,-59,-55,127,
  120,113,106,100,56,-85,-80,-76,-72,-68,
  -65,14,118,111,104,98,92,87,81,77,
  72,68,65,16,-119,-112,-106,-98,83,80,
  30,-76,78,73,70,66,62,58,-36,-122,
  -115,70,67,22,-117,-110,-102,-97,-90,-86,
  -80,-77,-72,-69,-65,118,111,104,99,92,
  87,81,77,72,68,-115,-109,-101,-96,-89,
  -85,-80,-76,-71,-68,-65,28,117,111,99,
  -49,-75,108,102,97,91,-92,-87,-82,-78,
  -73,-70,-67,-64,-60,-57,121,123,115,109,
  102,48,-81,-77,91,100,96,81,-89,-85,
  -79,-76,-71,-68,-65,-61,-58,-56,-48,125,
  123,117,78,29,102,97,91,86,25,-97,
  -90,-85,-80,-76,-72,-69,-66,-62,-59,-56,
  49,81,112,115,109,102,97,91,86,80,
  -101,-94,-89,-46,-72,-78,-73,-70,-25,106,
  108,101,96,90,82,67,77,72,68,56,
  -118,-111,-104,-98,-91,-87,-81,-78,-73,-70,
  -66,89,107,104,97,-48,-60,100,94,90,
  85,-91,-93,-88,-82,-78,-75,-70,-67,-64,
  -60,-57,127,119,113,104,44,-18,99,93,
  88,61,-68,-91,-86,-81,-77,-72,-69,-66,
  -62,-59,-22,13,124,111,8,-57,85,110,
  104,98,92,87,-43,-93,-88,-82,-78,-75,
  -70,-67,-64,-60,-58,-39,-44,-22,-17,125,
  127,119,15,-40,-67,-64,-60,-16,-56,-54,
  -51,-49,-47,-45,-43,-1,125,125,34,11,
  36,125,118,108,-12,-62,-69,-12,-65,-62,
  -59,-57,-54,-51,-49,-39,-45,62,-11,-46,
  -44,-41,121,125,125,127,119,0,-47,-59,
  -44,-59,-58,-55,-53,-50,29,-20,-5,8,
  61,41,26,37,19,125,118,111,25,20,
  60,40,62,-50,-82,-78,-58,-60,-26,-6,
  8,-29,-17,-43,64,109,109,102,97,91,
  86,80,-1,-101,-96,-89,-9,39,-38,53,
  -80,64,-85,-80,-72,-8,104,99,93,87,
  -66,-90,-85,-76,-41,-73,-70,-67,-64,-60,
  -57,-55,-53,-50,-48,-46,69,125,127,123,
  82,-61,-27,4,19,-19,-64,-60,-57,-55,
  -53,-50,-48,108,127,65,-14,-33,-43,127,
  120,113,55,17,-7,59,-34,-77,-73,-69,
  -66,-62,-59,-34,30,39,-7,-35,-56,37,
  127,121,114,107,100,-1,-51,-80,-76,-71,
  -68,-65,-61,-58,-56,-53,-30,-49,-47,-45,
  -25,125,125,127,72,12,33,11,-34,-62,
  -59,-57,-54,-51,-49,-47,-45,22,12,18,
  43,34,123,127,123,115,106,88,56,23,
  -66,-80,-77,-72,-69,-65,-62,-59,-56,-54,
  -51,18,56,101,125,117,107,36,8,46,
  17,-45,-76,-71,-68,-65,-61,-48,-47,-5,
  -22,-17,64,104,122,114,108,101,96,66,
  69,-16,-51,-91,-86,-81,-77,-72,33,13,
  -32,-57,-39,75,97,106,100,93,45,16,
  43,39,-57,-93,-88,-82,-78,-75,-70,-58,
  -64,-6,-29,120,114,109,102,96,90,85,
  80,76,70,-54,-108,-101,-94,-89,-83,-79,
  -75,-71,-68,-65,-57,121,106,108,102,96,
  88,17,11,-68,-89,-83,-79,-75,-71,-67,
  -65,-61,-32,27,111,114,110,104,98,92,
  78,-93,-88,-83,-79,-75,-71,-67,-64,-61,
  -58,-55,18,118,123,117,110,103,97,91,
  8,-92,-87,-81,-78,-73,-70,-67,-64,-60,
  -57,122,123,115,109,102,96,90,85,78,
  -93,-96,-90,-85,-80,-76,-72,-68,-65,-61,
  -33,122,115,109,102,97,90,85,80,-25,
  -100,-94,-89,-83,-79,-75,-71,-68,-65,-34,
  121,115,109,102,97,90,86,80,-2,-101,
  -96,-89,-85,-80,-76,-71,-68,-65,-61,70,
  117,110,103,98,92,87,81,66,-82,-98,
  -92,-87,-82,-78,-73,-70,-67,-62,100,117,
  110,103,97,91,86,81,73,-67,-100,-93,
  -88,-82,-78,-75,-71,-67,-64,4,119,113,
  107,100,94,89,83,76,-30,-101,-94,-89,
  -83,-79,-75,-71,-68,-65,-61,93,118,111,
  104,99,92,87,82,1,-28,-99,-92,-87,
  -82,-78,-73,-70,-67,-64,-15,-4,111,69,
  12,20,66,104,96,58,-3,0,-26,-39,
  -48,-66,-76,-72,-69,-65,-62,-59,-30,-47,
  -40,-50,-32,-5,39,62,60,109,96,117,
  91,104,25,9,-66,-77,-72,-69,-66,-62,
  -59,-57,-54,-51,-17,113,127,122,114,109,
  102,96,79,-46,-88,-82,-79,-75,-70,-67,
  -64,-60,-58,-55,24,127,123,115,109,102,
  97,90,85,-9,-97,-91,-86,-81,-77,-72,
  -69,-66,-62,-59,0,124,118,111,104,98,
  92,87,41,-34,-96,-90,-85,-80,-76,-72,
  -68,-65,-61,-43,109,117,111,104,99,92,
  87,82,46,-59,-98,-92,-87,-81,-77,-73,
  -70,-67,-62,29,104,112,106,100,93,88,
  82,44,-25,-72,-66,-91,-86,-80,-76,-72,
  -69,-65,-14,-3,62,75,109,103,98,92,
  86,35,-13,-70,-68,-87,-82,-78,-73,-70,
  -67,-64,-60,-16,26,81,64,111,85,73,
  56,34,5,-25,-70,-60,-75,-70,-67,-64,
  -60,-57,-55,-36,-5,8,59,35,47,54,
  16,59,-5,29,-32,-28,-55,-58,-56,-54,
  -51,-49,-47,-45,-29,22,57,64,26,36,
  25,8,-6,-12,-34,-49,-47,-45,-43,-41,
  -40,-38,-37,-35,8,41,96,104,62,53,
  29,17,-9,-26,-41,-43,-45,-43,-41,-39,
  -38,-36,-35,-5,32,37,65,71,86,61,
  43,14,-5,-33,-36,-45,-44,-43,-40,-39,
  -37,-3,-1,18,38,72,77,127,71,109,
  39,45,-20,-14,-29,-33,-37,-50,-39,-36,
  0,-19,18,17,59,71,59,80,60,78,
  40,43,-3,-22,-29,-47,-19,-64,-19,-58,
  -3,-38,-1,-1,30,39,47,66,70,79,
  73,81,64,34,23,-23,-17,-60,-45,-60,
  -35,-50,-39,-29,-11,41,43,101,59,96,
  47,69,43,38,2,-25,-54,-68,-71,-67,
  -64,-55,-58,-45,-28,2,23,33,36,46,
  61,67,55,26,11,-19,-26,-60,-57,-66,
  -62,-64,-62,-43,-34,13,-14,48,4,58,
  23,57,44,12,2,-36,-18,-59,-50,-59,
  -46,-49,-48,-45,-29,0,2,54,9,73,
  2,48,3,22,6,-13,-6,-40,-38,-50,
  -48,-46,-45,-43,-35,-20,-27,-7,-7,7,
  29,12,22,-14,-8,-26,-9,-18,-14,-30,
  -30,-34,-33,-32,-29,-28,-25,-8,3,12,
  25,40,53,38,38,8,29,-5,4,-22,
  -24,-26,-33,-22,-30,-16,-26,6,9,43,
  41,50,45,34,29,14,15,26,4,-1,
  -26,-20,-24,-11,-11,-6,6,13,16,27,
  40,49,57,62,50,34,28,8,28,1,
  12,-19,-16,-20,-16,-15,4,4,28,29,
  32,43,39,48,46,34,24,22,7,9,
  -8,-13,-18,-26,-12,-6,-3,14,-9,48,
  18,65,33,54,45,29,34,6,26,-8,
  -1,-24,-13,-25,-16,-19,-14,-3,4,14,
  30,29,40,25,36,22,22,6,-4,-5,
  -19,-19,-29,-27,-30,-30,-26,-17,-4,2,
  17,19,30,20,26,9,18,-2,-3,-12,
  -23,-30,-43,-38,-40,-29,-30,-25,-25,-7,
  -5,9,0,6,-2,5,-1,-12,-9,-25,
  -26,-32,-35,-30,-37,-37,-35,-29,-24,-15,
  1,4,14,7,8,9,7,-1,-5,-4,
  -13,-16,-34,-36,-37,-36,-28,-29,-22,-19,
  -13,-7,-1,8,24,17,20,9,1,-7,
  -9,-15,-18,-26,-30,-32,-26,-26,-19,-6,
  -2,14,7,27,24,32,27,26,20,7,
  0,-17,-16,-25,-19,-22,-19,-15,-14,-8,
  3,7,23,22,35,29,36,28,27,25,
  18,13,-4,-7,-9,-13,-9,-5,7,20,
  15,26,26,36,47,45,56,43,36,19,
  16,14,6,-3,-5,-6,-6,-8,-6,-2,
  5,28,11,57,7,59,4,49,12,43,
  20,26,13,2,5,-7,5,6,2,13,
  2,13,9,16,25,19,30,12,36,6,
  30,4,15,4,-1,-3,-6,-8,-7,-12,
  -1,-7,3,-6,4,4,5,4,8,2,
  9,-9,3,-12,2,-14,-5,-17,-13,-26,
  -17,-23,-8,-14,-1,-15,1,-16,-8,-6,
  -7,4,-18,-6,-26,-11,-22,-7,-13,-15,
  -17,-28,-29,-28,-26,-22,-25,-22,-19,-14,
  -14,-5,-3,3,5,-5,-4,-17,-13,-20,
  -14,-22,-27,-25,-29,-20,-22,-11,-6,1,
  -1,1,-1,11,11,12,14,3,2,-15,
  -18,-19,-23,-19,-19,-18,-15,-17,-7,-2,
  12,16,27,28,26,16,7,7,4,-1,
  -7,-9,-16,-17,-22,-17,-14,-4,4,6,
  23,20,39,29,47,32,25,12,6,1,
  -4,-11,-12,-16,-14,-12,-1,9,23,27,
  32,38,40,50,41,48,34,22,8,2,
  2,4,1,-5,-1,-5,4,4,19,25,
  28,33,29,36,28,27,24,20,13,-2,
  -4,-8,-9,-6,-8,-1,1,2,1,5,
  20,25,32,30,35,17,16,4,8,-3,
  -1,-14,-13,-19,-22,-13,-4,9,12,7,
  12,13,13,18,17,18,11,-3,-9,-17,
  -15,-24,-18,-15,-14,-11,-15,-7,-7,1,
  5,12,9,8,-2,0,-5,-2,-13,-12,
  -18,-23,-30,-33,-26,-14,-16,0,-19,1,
  -16,-3,-1,11,11,-4,-8,-20,-16,-22,
  -23,-16,-19,-17,-27,-15,-17,-9,-8,-6,
  11,-1,5,-9,3,-2,-6,-4,-14,-5,
  -23,-14,-24,-4,-15,-3,-7,-5,-7,-11,
  -4,-6,4,-1,1,-7,-1,-12,-4,-6,
  0,-2,-6,-6,-6,-6,0,-3,15,5,
  12,2,7,6,13,8,12,7,5,2,
  -3,3,2,4,3,12,8,12,8,15,
  16,13,12,15,13,13,7,11,14,13,
  11,11,16,17,17,7,15,7,13,12,
  16,19,13,12,0,16,2,26,12,26,
  23,7,22,3,22,18,13,24,4,15,
  -9,3,1,8,13,4,8,-1,4,3,
  15,17,18,14,8,8,5,5,6,5,
  5,-5,-5,-7,-4,0,-2,7,4,6,
  3,4,11,5,16,-1,7,-12,-6,-4,
  -11,-5,-13,-11,-7,-14,-6,-12,0,-6,
  12,-9,19,-16,17,-16,11,-16,0,-17,
  -15,-17,-28,-16,-26,-8,-13,1,-6,-3,
  0,-5,5,4,4,3,-5,-9,-25,-16,
  -25,-14,-11,-23,-7,-27,-16,-17,-9,4,
  0,4,-6,0,-9,-6,-8,1,-12,-11,
  -24,-19,-24,-18,-17,-7,-7,-3,-9,-5,
  0,2,5,8,8,0,-3,-8,-6,-6,
  -9,-9,-9,-7,-13,-12,-3,-3,9,2,
  14,15,8,15,4,15,8,2,3,-3,
  4,-12,-1,-4,1,0,1,11,13,14,
  14,14,20,22,19,18,22,8,7,-1,
  3,4,0,1,3,3,-2,-4,7,19,
  30,33,26,37,12,19,8,23,23,13,
  4,-2,-4,-9,-1,7,22,16,12,9,
  14,23,24,34,35,27,17,3,2,5,
  2,3,1,3,-5,-2,-1,12,18,17,
  24,18,23,8,12,11,15,13,4,3,
  -1,-5,-8,-8,1,-1,-3,0,-2,5,
  -1,4,13,8,13,1,-1,5,-9,5,
  -19,7,-19,-6,-23,-14,-14,-16,-8,-6,
  -1,0,-13,0,-6,-4,-5,-2,0,-5,
  -14,-23,-17,-25,-16,-19,-8,-12,-16,-20,
  -18,-8,-9,1,-4,1,-9,-17,-15,-13,
  -6,-15,-12,-17,-18,-24,-20,-14,-6,-9,
  -8,-15,-8,-15,-11,-9,-1,-3,-5,-15,
  -12,-14,-14,-13,-7,-4,-9,-9,-13,-3,
  -5,-2,2,1,2,-9,-8,-3,-3,6,
  -4,5,-5,-6,-9,-4,2,5,5,2,
  4,1,1,1,12,16,14,9,9,2,
  5,2,11,15,12,12,2,5,-3,4,
  6,22,19,19,15,7,18,11,22,26,
  17,25,1,9,2,7,14,11,20,9,
  8,14,13,27,22,27,20,20,13,9,
  13,16,17,15,15,14,8,13,15,19,
  18,16,17,9,12,5,11,9,19,9,
  17,8,16,8,11,12,14,7,12,1,
  11,-2,3,0,-1,12,-4,8,0,0,
  4,-3,8,5,4,2,-7,2,-7,2,
  -2,3,3,-4,0,-5,-3,-4,-6,-2,
  -5,-6,-16,-6,-12,1,-8,-2,-4,-12,
  -14,-13,-9,-6,-9,-9,-13,-13,-13,-14,
  -9,-4,-5,-9,-7,-14,-7,-11,-7,-7,
  -7,-14,-15,-19,-16,-23,-13,-15,-7,-11,
  -16,-7,-14,-7,-13,-6,-8,-12,-14,-18,
  -13,-15,-12,-15,-13,-14,-14,-14,-11,-4,
  -2,-5,-3,-6,-4,-12,-1,-2,2,-6,
  -5,-7,-6,-9,-4,-3,-3,-4,-7,-7,
  -3,0,4,8,11,0,3,-3,4,4,
  3,5,0,-2,-4,-4,1,2,8,7,
  8,12,4,14,15,22,19,12,11,2,
  4,3,7,13,8,11,5,9,8,16,
  17,17,20,16,18,12,16,14,13,11,
  7,8,5,12,4,14,8,16,9,18,
  18,18,20,17,20,14,16,7,17,6,
  16,5,9,5,9,1,14,4,18,7,
  12,15,8,17,6,16,11,12,8,4,
  5,0,-2,1,1,6,2,0,2,3,
  1,6,4,8,5,4,2,3,-2,2,
  -6,6,-8,0,-12,-1,-6,-2,0,-5,
  2,-3,-3,3,-5,5,-9,-1,-5,-5,
  -5,-15,-2,-15,-9,-13,-11,-2,-9,-3,
  -6,-1,-2,-5,-1,-6,-4,-14,-12,-11,
  -13,-6,-19,-11,-20,-16,-15,-13,-5,-11,
  -7,-12,-8,-7,-12,-2,-11,-7,-17,-18,
  -14,-12,-13,-9,-15,-11,-19,-17,-8,-9,
  0,-9,-3,-7,-6,-8,-4,-2,-1,-7,
  -11,-9,-11,-12,-5,-7,2,-7,-2,-11,
  2,-5,4,1,8,3,1,-1,3,0,
  5,-1,7,1,-3,0,-4,13,-2,13,
  4,16,8,6,14,13,17,12,7,11,
  1,9,2,20,4,17,0,9,6,15,
  13,19,14,17,9,12,16,15,16,9,
  11,7,5,6,11,15,14,15,9,13,
  17,14,20,16,19,11,11,12,12,12,
  7,12,11,6,14,5,15,4,11,6,
  8,11,8,7,11,11,9,9,5,7,
  2,6,5,4,7,3,5,1,2,2,
  3,4,4,2,1,-3,3,-6,4,-3,
  3,-1,0,-6,-3,-3,-2,1,-5,-1,
  -7,-3,-7,-5,-4,-6,-7,-13,-6,-9,
  -4,-7,-6,-4,-6,-5,-8,-5,-2,-4,
  -5,-8,-9,-11,-14,-8,-8,-4,-9,-7,
  -11,-6,-12,-11,-8,-6,-6,-11,-7,-11,
  -11,-8,-15,-11,-13,-14,-12,-12,-4,-7,
  -7,-4,-8,-6,-6,-6,-4,-5,-8,-9,
  -7,-9,-6,-11,-5,-7,-6,-6,-6,-6,
  0,-5,-2,-3,-4,1,-3,-2,1,-1,
  0,-5,3,-1,-1,-1,-5,7,-1,2,
  6,4,11,11,4,13,0,13,4,9,
  5,5,6,7,8,7,8,9,8,13,
  8,15,11,13,16,14,22,12,12,8,
  8,6,4,6,8,12,11,12,11,12,
  5,12,16,17,18,15,15,9,17,7,
  13,11,12,7 
};

struct SoundInfo GameOver=
{
  GameOver_data, /* WaveForm Buffers */
     10100, /* Record Rate */
      3484  /* WaveForm Length */
};

/* The code starts here. */

main()
{
 struct ScreenModeRequester *ScreenRequest;
 ULONG ModeID;
 UBYTE fl=128, fr=129, SoundChannel=6;
 int l=10,bs=0,hiscore[2]={0,0},i,Score=0,j;
 BOOL close=0;
 char score[5]={48,48,48,48,48},bar=42,
version[]="$VER: Garden V1.3 (23.11.2003) Copyright (1989-2003)";

ULONG class;

UWORD code;

/* Open the Intuition library: */

  IntuitionBase = (struct IntuitionBase *)
    OpenLibrary( "intuition.library", 0 );
  if( !IntuitionBase )
    exit();
/* Open the Graphics library: */
  GfxBase = (struct GfxBase *)
    OpenLibrary( "graphics.library", 0 );
  if( !GfxBase )
  {
  CloseLibrary( IntuitionBase );
  exit();    
  }

/* Opens the highscore file */

file_handle = (struct FileHandle *)
Open( "Garden.sav", MODE_READWRITE );
Seek( file_handle, 0, OFFSET_BEGINNING );

bytes_read = Read( file_handle, hiscore, sizeof( hiscore ) );
bytes_read = Read( file_handle, &ModeID,  sizeof( ModeID  ) );
if (!bytes_read) ModeID=0;

if (!ModeID){
/* We will now try to open the screen: */
    if (ScreenRequest=(struct ScreenModeRequester *)AllocAslRequestTags(
                                 ASL_ScreenModeRequest,
                                 ASLSM_TitleText, (ULONG) "Pick 320x256 Screenmode ",
                                 ASLSM_PositiveText, (ULONG) "Ok",
                                 ASLSM_NegativeText, (ULONG) "Cancel",
                                 /*ASLSM_InitialInfoOpened, TRUE,*/
                                 ASLSM_MinWidth, 320,
                                 ASLSM_MinHeight, 256,
                                 ASLSM_MinDepth, 8,
                                 ASLSM_MaxDepth, 8,
                                 TAG_DONE))
    {
    if (!AslRequestTags(ScreenRequest,    ASLSM_TitleText, (ULONG) "Pick 5Bit 320x256 Screenmode ",
                                 ASLSM_PositiveText, (ULONG) "Ok",
                                 ASLSM_NegativeText, (ULONG) "Cancel",
                                 ASLSM_MinWidth, 320,
                                 ASLSM_MinHeight, 256,
                                 ASLSM_MinDepth, 5,
                                 ASLSM_MaxDepth, 32,
                                 TAG_DONE))
        {
        puts("Error: Invalid ScreenMode");
        exit(-1);
        } else {
            ModeID=ScreenRequest->sm_DisplayID;}
    }
}

  my_screen = (struct Screen *)
 OpenScreenTags( NULL, SA_DisplayID,ModeID,SA_Width,320,
 SA_Height, 256, SA_Depth, 3,
 SA_Colors32, GardenPaletteRGB32,
 SA_Font,&my_font,
 SA_AutoScroll,TRUE,
 SA_Title,"Garden",SA_ShowTitle,FALSE, TAG_DONE );

  if( !my_screen )
  {
   CloseLibrary( GfxBase );
   CloseLibrary( IntuitionBase );
   exit();
   }

 my_new_window.Screen = my_screen;
 my_window = (struct Window *) OpenWindow( &my_new_window );

if ( !my_window )
  {
    /* Could NOT open the Window! */
    
    /* Close the Intuition Library since we have opened it: */
   CloseScreen( my_screen );
   CloseLibrary( GfxBase );   
   CloseLibrary( IntuitionBase );
   exit();
  }

SetFont( my_window->RPort, &HapFont );

SetAPen(my_window->RPort,6);
for (i=1; i<30; i=i+2) {for (j=1; j<53; j=j+2)
 {
SetAPen(my_window->RPort,SoundChannel);
if (SoundChannel==2) SoundChannel=6; else if (SoundChannel==6) SoundChannel=7;
else if (SoundChannel==7) SoundChannel=2;
Move( my_window->RPort,(j-bs)*6,i*8); Text( my_window->RPort, &fl, 1 ); 
SetAPen(my_window->RPort,5);Move( my_window->RPort,(j-bs)*6,(i+1)*8);
Text( my_window->RPort, &fr, 1 );} if (bs==0) bs=-1; else bs=0;}
SetAPen(my_window->RPort,4);
Move( my_window->RPort,102,120);
Text( my_window->RPort, &Title1, 23 );
Move( my_window->RPort,102,128);
Text( my_window->RPort, &Title2, 23 );
while (bs<500) {bs++;Delay(1);if (Joystick()==FIRE) bs=501;Seed++;}

SetMenuStrip( my_window, &my_menu );
srand( Seed ); /* Randomize */
SoundChannel=0;
  /* Stay in the while loop until the end */

  while( close == FALSE )
  {
x=36;y=5;mx=l;my=5;xd=1;yd=0;n=0;
SetRast(my_window->RPort,0);
SetAPen(my_window->RPort,4);
Move( my_window->RPort,24,8); Text( my_window->RPort, "Rezultat",8);
Move( my_window->RPort,144,8); Text( my_window->RPort, "Rekord",6);
bs=Score;
score[0]=(bs/10000)+48;bs=bs%10000;
score[1]=(bs/1000)+48;bs=bs%1000;
score[2]=(bs/100)+48;bs=bs%100;
score[3]=(bs/10)+48;bs=bs%10;
score[4]=bs+48;
Move( my_window->RPort,78,8); Text( my_window->RPort, &score[0],5);
bs=hiscore[1];
score[0]=(bs/10000)+48;bs=bs%10000;
score[1]=(bs/1000)+48;bs=bs%1000;
score[2]=(bs/100)+48;bs=bs%100;
score[3]=(bs/10)+48;bs=bs%10;
score[4]=bs+48;

Move( my_window->RPort,186,8); Text( my_window->RPort, &score[0],5);
SetAPen(my_window->RPort,1);
for (i=4; i<38; i++) {Move ( my_window->RPort,i*6,32);Text( my_window->RPort, &bar,1);Move ( my_window->RPort,246-i*6,168);Text( my_window->RPort, &bar,1);} for (i=4; i<38; i=i+2) {Move ( my_window->RPort,24,16+i*4);Text( my_window->RPort, &bar,1);Move ( my_window->RPort,222,184-i*4);Text( my_window->RPort, &bar,1);}
SetAPen(my_window->RPort,5);
for (i=6; i<21; i++) {Move ( my_window->RPort,30,i*8);Text( my_window->RPort, "((((((((((((((((((((((((((((((((",32);
}

SetAPen(my_window->RPort,6);

for (i=1; i<21; i++){
Move (my_window->RPort,30+(rand()%32)*6,48+(rand()%15)*8);
Text( my_window->RPort, &bar,1);
}

SetAPen(my_window->RPort,2);
i=0;

while (i<l) {
a=rand()%32;
b=rand()%15;
if ( ReadPixel(my_window->RPort,30+a*6,48+b*8)==5 && a!=32 && b!=1) {Move (my_window->RPort,30+a*6,48+b*8);
Text (my_window->RPort, ")",1);
i++;}
}

SetAPen(my_window->RPort,7);
Move (my_window->RPort,x*6,y*8);
Text (my_window->RPort, "&",1);     /* That's You! */
SetAPen(my_window->RPort,3);
Move (my_window->RPort,mx*6,my*8);
Text (my_window->RPort, "'",1);     /* This is Zorak */
for (;;) {a=Joystick(); if (a==LEFT || a==RIGHT || a==UP  || a==DOWN ) break;
  while(my_message = (struct IntuiMessage *) GetMsg(my_window->UserPort))
   { 
      /* After we have successfully collected the message we can read */
      /* it, and save any important values which we maybe want to check */
      /* later: */
    class = my_message->Class;
    code  = my_message->Code;
ReplyMsg( my_message ); /* Work done. Reply. */
  }

      /* After we have successfully collected the message we can read */
      /* it, and save any important values which we maybe want to check */
      /* later: */

if(class == MENUPICK)
{ if (code == 63488) {Score=0;l=10;i=500;code=class=0;break;} /* New Game */
  if (code == 63520) AutoRequest( my_window, &my_body_text, NULL,
                     &my_ok_text, NULL, NULL, 220, 72);  /* About */

 if(code == 63552) {close=TRUE; /* Quit */ break;}
}
code=class=0;
Delay(1);
}

    /* while-loop: */
  for (;;)
   { 
a=x;
b=y;
for (;;) {
if (Joystick() & LEFT && x>5) {x--; break; } 
if (Joystick() & RIGHT && x<36){x++; break;}
if (Joystick() & UP && y>5){y--; break;}
if (Joystick() & DOWN && y<20) y++;
break;
}

if (ReadPixel (my_window->RPort,x*6+4,y*8-2)==2) {Score=Score+10; n++;
PlaySound(&Biiing,MAXVOLUME,SoundChannel,SOUND_PRI_EFFECT,
NORMALRATE,ONCE,0,0,DO_NOT_WAIT);SoundChannel=(SoundChannel+1)*(SoundChannel<3);
}
if (ReadPixel (my_window->RPort,x*6+5,y*8-1)==6) {x=a;y=b;}
if ((b!=y || a!=x) && ReadPixel (my_window->RPort,x*6+5,y*8-1)==5) Score++;
Move (my_window->RPort,a*6,b*8);
Text (my_window->RPort, " ",1);
SetAPen(my_window->RPort,7);
Move (my_window->RPort,x*6,y*8);
Text (my_window->RPort, "&",1);   /* That's You */
SetAPen(my_window->RPort,4);
bs=Score;
score[0]=(bs/10000)+48;bs=bs%10000;
score[1]=(bs/1000)+48;bs=bs%1000;
score[2]=(bs/100)+48;bs=bs%100;
score[3]=(bs/10)+48;bs=bs%10;
score[4]=bs+48;
Move( my_window->RPort,78,8); Text( my_window->RPort, &score[0],5);
Delay(1);

a=mx;b=my;mx=mx+xd;my=my+yd;

for (;;) {
if (mx==x && my==y) {Text (my_window->RPort, " ",1);break;}
if (mx<5 || mx>36 || my>20 || my<5) {mx=a;my=b;Algo();break;}
if ((ReadPixel (my_window->RPort,mx*6+5,my*8-1)!=0) || (ReadPixel (my_window->RPort,mx*6+3,my*8-2)!=0)) {mx=a;my=b;Algo();break;} 

if (xd!=0) {if (my<y) if ((ReadPixel (my_window->RPort,mx*6+5,my*8+7)==0) && (ReadPixel (my_window->RPort,mx*6+3,my*8+6)==0)) {yd=1;xd=0;break;}

if (my>y) if ((ReadPixel (my_window->RPort,mx*6+5,my*8-9)==0) && (ReadPixel (my_window->RPort,mx*6+3,my*8-10)==0)) {yd=-1;xd=0;
break;} 
break;
}


if (mx<x) if ((ReadPixel (my_window->RPort,mx*6+11,my*8-1)==0) && (ReadPixel (my_window->RPort,mx*6+9,my*8-2)==0)) {xd=1;yd=0;break;}
if (mx>x) if ((ReadPixel (my_window->RPort,mx*6-1,my*8-1)==0) && (ReadPixel (my_window->RPort,mx*6-3,my*8-2)==0)) {xd=-1;yd=0;break;}
break;
}

Move (my_window->RPort,a*6,b*8);
Text (my_window->RPort, " ",1);
SetAPen(my_window->RPort,3);
Move (my_window->RPort,mx*6,my*8);
Text (my_window->RPort, "'",1);    /* This is Zorak */

  while(my_message = (struct IntuiMessage *) GetMsg(my_window->UserPort))
   { 
      /* After we have successfully collected the message we can read */
      /* it, and save any important values which we maybe want to check */
      /* later: */
    class = my_message->Class;
    code  = my_message->Code;
ReplyMsg( my_message ); /* Work done. Reply. */
  }

      /* After we have successfully collected the message we can read */
      /* it, and save any important values which we maybe want to check */
      /* later: */

if(class == MENUPICK) { 

if (code == 63488) {Score=0;l=10;code=class=0;break;} /* New Game */
 if(code == 63520)  AutoRequest( my_window, &my_body_text, NULL,
                    &my_ok_text, NULL, NULL, 220, 72);  /* About */

 if(code == 63552) {close=TRUE; /* Quit */break;}}
if (close) break;

if (mx==x && my==y) { SetAPen (my_window->RPort,7);
Move (my_window->RPort,24,184);
Text (my_window->RPort, "Kraj na igrata !",16);
PlaySound(&GameOver,MAXVOLUME,SoundChannel,SOUND_PRI_EFFECT,
NORMALRATE,ONCE,0,0,WAIT);
if (Score>hiscore[1]) {hiscore[1]=Score;
SetAPen (my_window->RPort,3);
Move (my_window->RPort,114,184);
Text (my_window->RPort, "S now rekord !",14); Seek( file_handle, 0, OFFSET_BEGINNING );
bytes_written=Write( file_handle, hiscore, sizeof( hiscore ) );
Write( file_handle, &ModeID,  sizeof( ModeID  ) );
}
Score=0;
for (i=1; i<500; i++)
{
  while(my_message = (struct IntuiMessage *) GetMsg(my_window->UserPort))
   { 
      /* After we have successfully collected the message we can read */
      /* it, and save any important values which we maybe want to check */
      /* later: */
    class = my_message->Class;
    code  = my_message->Code;
ReplyMsg( my_message ); /* Work done. Reply. */
  }


      /* After we have successfully collected the message we can read */
      /* it, and save any important values which we maybe want to check */
      /* later: */

if((class == MENUPICK && code == 63488) || Joystick() & FIRE)
{i=500;l=10;code=class=0;break;} /* New Game */
 if(class == MENUPICK && code == 63520) AutoRequest( my_window, &my_body_text,
                        NULL, &my_ok_text, NULL, NULL, 220, 72);  /* About */

 if(class == MENUPICK && code == 63552)
   {close=TRUE; /* Quit */break;}
code=class=0;
Delay(1);}
}

if (i==500) break;
if (n==l) {PlaySound(&LevelComplete,MAXVOLUME,SoundChannel,SOUND_PRI_EFFECT,
NORMALRATE,ONCE,0,0,WAIT);if (l<35) l++;break;}
code=class=0;
Delay(1);
  }
}
/* Stop any sound playing (Clean exit) */
StopSound(0);StopSound(1);StopSound(2);StopSound(3);

/* We should always close the screens we have opened before we leave: */
 ClearMenuStrip( my_window );

 Close( file_handle );

 CloseWindow ( my_window ); 

 CloseScreen( my_screen );
  
/* Close the Graphics Library since we have opened it: */
  CloseLibrary( GfxBase );

  /* Close the Intuition Library since we have opened it: */
  CloseLibrary( IntuitionBase );

  /* THE END */
exit(0);
}
 
/* Joystick() is a handy, easy and fast but naughty function that hits */
/* the hardware of the Amiga. It returns a bitfield containing the     */
/* position of the stick and the present state of the button.          */
/*                                                                     */
/* Synopsis: value = Joystick();                                       */
/*                                                                     */
/* value:    (UBYTE) If the fire button is pressed, the first bit is   */
/*           set. If the stick is moved to the right, the second bit   */
/*           is set, and if the stick is moved to the left, the third  */
/*           bit is set. The fourth bit is set if the stick is moved   */
/*           down, and the fifth bit is set if the stick is moved up.  */
/*           FIRE==1 RIGHT==2 LEFT==4 DOWN==8 UP==16                   */

UBYTE Joystick()
{
  UBYTE data = 0;
  UWORD joy;
  /* PORT 2 ("JOYSTICK PORT") */
    joy = custom.joy1dat;
    data += !( ciaa.ciapra & 0x0080 ) ? FIRE : 0;

  data += joy & 0x0002 ? RIGHT : 0;
  data += joy & 0x0200 ? LEFT : 0;
  data += (joy >> 1 ^ joy) & 0x0001 ? DOWN : 0;
  data += (joy >> 1 ^ joy) & 0x0100 ? UP : 0;

  return( data );
}

void Algo ()
{
for(;;) {
if (xd!=0) {if (my<20) if ((ReadPixel (my_window->RPort,mx*6+5,my*8+7)==0) && (ReadPixel (my_window->RPort,mx*6+3,my*8+6)==0)) {yd=1;xd=0;break;}

if (my>5) if ((ReadPixel (my_window->RPort,mx*6+5,my*8-9)==0) && (ReadPixel (my_window->RPort,mx*6+3,my*8-10)==0)) { yd=-1;xd=0; break;}
xd=-xd;yd=-yd;break;}

if (mx<31) if ((ReadPixel (my_window->RPort,mx*6+11,my*8-1)==0) && (ReadPixel (my_window->RPort,mx*6+9,my*8-2)==0)) {xd=-1;yd=0;break;}
xd=-xd;yd=-yd;break;
}

}

/* Here comes the original AmigaBASIC code, which was written in 1995
 The font now is included in the executable, and it's not external anymore.
 If you need cyrillic font for Amiga try:
http://wuarchive.wustl.edu/~aminet/aminet/text/bfont/BTopaz.lha

SCREEN 1,337,256,4,1:WINDOW 1,"Venci",,1,1:PALETTE 0,0,0,0:PALETTE 1,0,0,0
PALETTE 4,0,9/15,1
PALETTE 9,1,0,0:PALETTE 10,1,1,0
PALETTE 11,10/15,3/15,0
PALETTE 15,0,0,1
DECLARE FUNCTION AskSoftStyle& LIBRARY
DECLARE FUNCTION OpenDiskFont& LIBRARY
DECLARE FUNCTION Execute& LIBRARY
LIBRARY "graphics.library"
LIBRARY "diskfont.library"    
Font "hap.font",8,0,0
SUB Font(fontName$, height%, style%, prefs%) STATIC
  SHARED pFont&                                            
  IF pFont&<>0 THEN CALL CloseFont(pFont&)
  fontName0$=fontName$+CHR$(0)
  textAttr&(0)=SADD(fontName0$)
  textAttr&(1)=height%*65536& + style%*256 + prefs%
  pFont&=OpenDiskFont&(VARPTR(textAttr&(0)))
  IF pFont& <> 0 THEN SetFont WINDOW(8),pFont&      
END SUB
E$="*":GOSUB Title
20 s=0:l=10
30 x=36:y=5:mx=l:my=5:xd=1:yd=0:n=0:CLS
COLOR 8:LOCATE 1,4:PRINT "Rezultat";s:COLOR 9:LOCATE 1,24:PRINT  "Rekord"H
COLOR 15:FOR i=4 TO 37:LOCATE 4,i:PRINT E$:LOCATE 21,41-i:PRINT E$
LOCATE 2+i/2,4:PRINT E$:LOCATE 23-i/2,37:PRINT E$:NEXT
t$="(":FOR i=1 TO 5:t$=t$+t$:NEXT:COLOR 14,1:FOR i=6 TO 20:LOCATE i,5:PRINT t$:NEXT
FOR i=1 TO 20:COLOR 4,0:LOCATE 6+INT(RND(2)*14.9),5+INT(RND(2)*31.9):PRINT "*":NEXT
COLOR 12,1:FOR i=1 TO l
100 b=6+INT(RND(2)*14.9):a=5+INT(RND(2)*31.9)
110 IF POINT(a*6-2,b*8-2)<>14 OR (a=36 AND b=6) THEN 100
120 LOCATE b,a:PRINT ")":NEXT:COLOR 0,0
130 COLOR 10:LOCATE y,x:PRINT "&":COLOR 9:LOCATE my,mx:PRINT "'"
140 IF STICK(2) OR STICK(3) THEN 150
145 GOTO 140
150 GOSUB 260
160 COLOR 8:LOCATE 1,13:PRINT s
170 GOSUB 350
180 IF mx=x AND my=y THEN 220
190 IF n<l THEN 150
200 IF l<35 THEN l=l+1
210 GOTO 30
220 COLOR 5:LOCATE 23,4:PRINT "Kraj na igrata !"
230 IF s>H THEN H=s:COLOR 6:LOCATE 23,19:PRINT "S now rekord !"
240 LOCATE 25,4:PRINT "O}e edna igra ? <D/N>"
241 t$=INKEY$:IF t$="N" OR t$="n" THEN 250
242 IF t$=" " OR t$="D" OR t$="d" OR t$="Y" OR t$="y" THEN 20 ELSE 241
250 SYSTEM                         
260 a=x:b=y:o=STICK(2):p=STICK(3)
IF o<0 AND x>5 THEN x=x+o:GOTO 310
IF o>0 AND x<36 THEN x=x+o:GOTO 310
IF p>0 AND y<20 THEN y=y+p:GOTO 310
IF p<0 AND y>5 THEN y=y+p
310 IF POINT(x*6-2,y*8-2)=12 THEN s=s+10:n=n+1
IF POINT(x*6-1,y*8-1)=4 THEN x=a:y=b
IF (b<>y OR a<>x) AND POINT(x*6-2,y*8-2)=14 THEN s=s+1
LOCATE b,a:PRINT " ":COLOR 10:LOCATE y,x:PRINT "&":RETURN
350 a=mx:b=my:mx=mx+xd:my=my+yd
IF mx=x AND my=y THEN PRINT " ":RETURN
IF mx<5 OR mx>36 OR my>20 OR my<5 THEN mx=a:my=b:GOSUB 460:GOTO 420
IF POINT(mx*6-2,my*8-1)<>0 THEN mx=a:my=b:GOSUB 460:GOTO 420
390 IF xd<>0 THEN GOTO 430
400 IF mx<x THEN IF POINT(mx*6+4,my*8-1)=0 THEN xd=1:yd=0
IF mx>x THEN IF POINT(mx*6-8,my*8-1)=0 THEN xd=-1:yd=0
420 COLOR 0:LOCATE b,a:PRINT " ":COLOR 9:LOCATE my,mx:PRINT "'":RETURN
430 IF my<y THEN IF POINT(mx*6-1,my*8+7)=0 THEN yd=1:xd=0
440 IF my>y THEN IF POINT(mx*6-1,my*8-9)=0 THEN yd=-1:xd=0
450 GOTO 420
460 IF xd<>0 THEN GOTO 490
IF mx<31 THEN IF POINT(mx*6+4,my*8-1)=0 THEN xd=-1:yd=0:RETURN
480 xd=-xd:yd=-yd:RETURN
490 IF my<20 THEN IF POINT(mx*6-1,my*8+7)=0 THEN yd=1:xd=0:RETURN
IF my>5 THEN IF POINT(mx*6-1,my*8-9)=0 THEN yd=-1:xd=0:RETURN
GOTO 480
Title:
CLS:COLOR 12:FOR i=1 TO 28 STEP 2
FOR j=3 TO 53 STEP 2:LOCATE i,j-b:PRINT CHR$(128):LOCATE i+1,j-b:PRINT CHR$(129):NEXT:b=NOT b:NEXT
FOR i=1 TO 23:READ a:a$=a$+CHR$(a+160):b$=b$+CHR$(a+161):NEXT
COLOR 9:LOCATE 13,18:PRINT a$:LOCATE 14,18:PRINT b$
Watt:
i=i+1:IF i=5000 OR STICK(2) OR STICK(3) THEN RETURN ELSE Watt
DATA 94,94,38,24,42,58,22,0,94,94,46,94,94,14,36,0,8,18,28,0,40,0,94

---
Here is the BASIC listing for the Oric Atmos version of the Game.
It competed in the 1K Minigame compo 2003 and placed 18th out of 26.

1 FORG=0TO19:READK$:DOKE46384+G*2,VAL("#"+K$):NEXT:DATA150E,40E,E1F,A0A,3F1E
2 L=10:E=32:DATAC1E,1E3F,331E,,,,2A15,3E36,3E14,836,1E23,213F,2121,2121,3F21
3 POKE618,10:POKE590,4:POKE48036,0:PAPER1:INK2:X=36:Y=5:U=L:W=5:Q=1:Z=0:N=0:CLS
4 PRINT@4,1;"TRONScore:"S:FORI=4TO37:PLOTI,4,42:PLOT41-I,21,42:PLOT4,2+I/2,42
5 PLOT37,23-I/2,42:NEXT:T$="(":FORI=1TO5:T$=T$+T$:NEXT:FORI=6TO20:PLOT5,I,T$
6 NEXT:FORI=1TO20:PLOT5+RND(1)*E,6+RND(2)*14,42:NEXT:FORI=1TOL
7 B=6+RND(2)*15:A=5+RND(2)*E:IFSCRN(A,B)>40THEN7ELSEPLOTA,B,41:NEXT
8 A=X:B=Y:K=PEEK(520)-99:IFK=73THENX=X-1
9 IFK=89THENX=X+1ELSEIFK=81THENY=Y+1ELSEIFK=57THENY=Y-1
10 J=SCRN(X,Y):IFJ=41THENPING:S=S+10:N=N+1
11 IFJ=42THENX=A:Y=BELSEIFJ=40THENS=S+1
12 PLOTA,B,E:PLOTX,Y,38:A=U:B=W:U=U+Q:W=W+Z:IFU=XANDW=YTHEN17
13 IFU<5ORU>36ORW>GORW<5THENU=A:W=B:GOSUBG:GOTO17
14 IFSCRN(U,W)>ETHENU=A:W=B:GOSUBG:GOTO17
15 IFU<XANDSCRN(U+1,W)=ETHENQ=1:Z=0ELSEIFU>XANDSCRN(U-1,W)=ETHENQ=-1:Z=0
16 IFQTHENIFW<YANDSCRN(U,W+1)=ETHENZ=1:Q=0ELSEIFW>YANDSCRN(U,W-1)=ETHENZ=-1:Q=0
17 PLOTA,B,E:PLOTU,W,39:IFU=XANDW=YTHEN24
18 PRINT@11,1;S:IFN<LTHEN8ELSEL=L-(L<35):ZAP:GOTO3
20 IFQTHEN22ELSEIFU<31ANDSCRN(U+1,W)=ETHENQ=1:Z=0:RETURN
21 Q=-Q:Z=-Z:RETURN
22 IFW<GANDSCRN(U,W+1)=ETHENZ=1:Q=0:RETURN
23 IFW>5ANDSCRN(U,W-1)=ETHENZ=-1:Q=0:RETURNELSE21
24 EXPLODE:WAIT99:CALL#F8B8:PRINT"TRONYour Score is"S

---
Here is the BASIC listing for the Sinclair ZX Spectrum version of the Game.

5  RANDOMIZE 0: LET L=10: LET S=0: LET HI=S: BORDER 0: OVER 0
10  FOR F=0  TO 39: READ A: POKE  USR "A"+f,A: NEXT F
20  DATA 28,42,28,73,62,28,20,20,60,255,60,24,126,60,60,102,54,62,20,62,54,8,43,30,255,129,129,129,129,129,129,255
30  DATA 0,0,0,0,0,0,170,85
40  PAPER 0: INK 4: CLS : PRINT : PRINT  INK 5; BRIGHT 1;"            GARDEN"
50  PRINT : PRINT "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE": PRINT : PRINT : PRINT : PRINT  INK 2;" © 2003 by Ventzislav Tzvetkov": PRINT : PRINT  INK 6;"     http://drhirudo.hit.bg"
55  PRINT : PRINT : PRINT  INK 1;"  Pick Flowers from  the  GARDEN  and run away from your pursuer": PRINT : PRINT : PRINT  INK 5;"       Move with Q,A,O,P": PRINT : PRINT : PRINT  INK 7;"          Good LUCK"
60  PRINT : PRINT  PAPER 3; INK 7;"      Press SPACE to Play      "
70  IF  INKEY$  <> " "  THEN  GO TO 70
80  LET X=29: LET Y=5: LET U=L: LET W=5: LET Q=1: LET Z=0: LET N=0: CLS
90  PRINT  AT 1,5; INK 1;"Score:"; INK 7;S; AT 1,18; INK 6;"HiScore:"; INK 2;HI
100  FOR I=2  TO 30: PRINT  AT 4,I; INK 1; BRIGHT 1;"D";  AT 20,32-I;"D"; AT 4+I/2,2;"D"; AT 20-I/2,30;"D": NEXT I
110  FOR I=6  TO 19: PRINT  BRIGHT 1; AT I,3;"EEEEEEEEEEEEEEEEEEEEEEEEEEE": NEXT I
120  FOR I=1  TO 20: PRINT  INK 5; AT 6+ RND *13,3+ RND *26;"D": NEXT I
121  FOR I=1  TO L
122  LET A=3+ RND *26: LET B=7+ RND *12: IF  ATTR (B,A) <> 68  THEN  GO TO 122
123  PRINT  AT B,A; INK 3; BRIGHT 1;"C": NEXT I
130  PRINT  AT Y,X; INK 6;"A"; AT W,U; INK 2;"B"
140  IF  INKEY$  <> ""  THEN  GO TO 150
145  GO TO 140
150  LET A=X: LET B=Y: LET K$= INKEY$ : IF K$="O"  OR K$="o"  THEN  LET X=X-1
151  IF K$="P"  OR K$="p"  THEN  LET X=X+1
152  IF K$="Q"  OR K$="q"  THEN  LET Y=Y-1
153  IF K$="A"  OR K$="a"  THEN  LET Y=Y+1
154  LET J= ATTR (Y,X): IF J=67  THEN  BEEP .1,1: LET S=S+10: LET N=N+1
155  IF J=5  OR J=65  THEN  LET X=A: LET Y=B
156  IF J=68  THEN  LET S=S+1: BEEP .002,7
157  IF A=X AND B=Y THEN  GO TO 159
158  PRINT  AT B,A;" "; AT Y,X; INK 6;"A"
159  LET A=U: LET B=W: LET U=U+Q: LET W=W+Z: IF U=X AND W=Y THEN  GO TO 170
160  IF U<3 OR U>29  OR W>19  OR W<5  THEN  LET U=A: LET W=B: GO SUB 200: GO TO 170
161  IF  ATTR (W,U)>4 THEN  LET U=A: LET W=B: GO SUB 200: GO TO 170
162  IF U<X  AND  ATTR (W,U+1)=4 THEN  LET Q=1: LET Z=0
163  IF U>X AND  ATTR (W,U-1)=4 THEN  LET Q=-1: LET Z=0
164  IF Q  THEN  IF W<Y AND  ATTR (W+1,U)=4 THEN  LET Z=1: LET Q=0
165  IF Q  THEN  IF W>Y AND  ATTR (W-1,U)=4  THEN  LET Z=-1: LET Q=0
170  PRINT  AT B,A;" "; INK 2; AT W,U;"B": IF U=X AND W=Y THEN  GO TO 240
180  PRINT  AT 1,11; INK 7;S: IF N<L THEN  GO TO 150
185  LET L=L+(L<27): FOR I=.1 TO 6 STEP .2: BEEP .01,I: NEXT I: GO TO 80
200  IF Q  THEN  GO TO 220
205  IF U<24 AND  ATTR (W,U+1)=4 THEN  LET Q=1: LET Z=0: RETURN
210  LET Q=-Q: LET Z=-Z: RETURN
220  IF W<18 AND  ATTR (W+1,U)=4 THEN  LET Z=1: LET Q=0: RETURN
230  IF W>5 AND  ATTR (W-1,U)=4 THEN  LET Z=-1: LET Q=0: RETURN
231  GO TO 210
240  PRINT  AT 3,11; INK 2;"Game Over":  FOR J=1 TO 3: FOR I=7 TO 1 STEP -.6: BEEP .01,I: NEXT I: NEXT J
250  IF S>HI  THEN  LET HI=S: PRINT  AT 1,26; INK 2;HI: PRINT  AT 2,10; INK 5; FLASH 1;"New HiScore"
260  PRINT  AT 21,8; INK 3;"Play Again (Y/N)?"
270  IF  INKEY$ ="Y" OR  INKEY$ ="y" THEN  LET L=10: LET S=0: GO TO 80
275  IF  INKEY$ ="N" OR  INKEY$ ="n" THEN  CLS : GO TO 290
280  GO TO 270
290  PRINT : PRINT  BRIGHT 1; INK 5;"  Please Note that this game is also available on Amiga and Oric": PRINT : PRINT  INK 1;"Visit my homepage for more info.": PRINT : PRINT : PRINT "      Thanks for Playing"
300  STOP

*/
