/*
 *     sound.c
 *
 */

#include "Bomber.h"
#include <exec/memory.h>
#include <dos/dos.h>
#include <devices/audio.h>
#include "sound.h"


#if DEBUG
# define D(debug) debug
#else
# define D(debug)
#endif


/*------------------------- Externe Daten...*/


extern struct ExecBase	*SysBase;
extern struct Library	*DOSBase;

extern long				audio;


/*------------------------- Daten dieses Moduls...*/


struct Voice8Header
{
	ULONG oneShotHiSamples,
		  repeatHiSamples,
		  samplesPerHiCycle;
	UWORD sampleRate;
	UBYTE ctOctave,
		  sCompression;
	LONG  volume;
};


struct ChunkHeader
{
	ULONG name,
		  length;
};


struct MsgPort			*audioport = NULL;
struct IOAudio			*ioaudio = NULL,
						ioa_samples[ SOUND_ANZAHL ],
						ioa_allocate;

int						pending_sound_plays = 0;

UBYTE					*sample_daten[ SOUND_ANZAHL ];

struct Unit				*units[2];
int						last_unit = 0;


/*------------------------- Code-Definitionen...*/


void load_sound( char *name, int number )
{
	struct Voice8Header		v8h;
	struct ChunkHeader		chunk;
	BPTR					file;
	UBYTE					**mem = & sample_daten[ number ];
	struct IOAudio			*ioa  = & ioa_samples[ number ];
	
	#define VHDR 0x56484452L
	#define BODY 0x424f4459L
	#define CLOCK 3546895
	
	
	file = Open( name, MODE_OLDFILE );
	if( !file ) return;
	
	chunk.length = 12;
	do
	{
		Seek( file, chunk.length, OFFSET_CURRENT );
		Read( file, &chunk, 8 );
	} while( chunk.name != VHDR );
	
	Read( file, &v8h, sizeof(v8h) );
	
	chunk.length -= sizeof(v8h);
	do
	{
		Seek( file, chunk.length, OFFSET_CURRENT );
		Read( file, &chunk, 8 );
	} while( chunk.name != BODY );
	
	*mem = AllocMem( chunk.length, MEMF_CHIP );
	
	if( *mem )
	{
		Read( file, *mem, chunk.length );
		
		*ioa = ioa_allocate;
		
		ioa->ioa_Request.io_Message.mn_ReplyPort = audioport;
		ioa->ioa_Request.io_Command              = CMD_WRITE;
		ioa->ioa_Request.io_Flags                = ADIOF_PERVOL;
		
		ioa->ioa_Length  = chunk.length;
		ioa->ioa_Period  = CLOCK / v8h.sampleRate;
		ioa->ioa_Volume  = v8h.volume / 1024;
		ioa->ioa_Cycles  = 1;
	}
	
	ioa->ioa_Data = *mem;
	
	Close( file );
}


void free_sound( int number )
{
	UBYTE					*mem = sample_daten[ number ];
	struct IOAudio			*ioa = & ioa_samples[ number ];
	
	if( mem ) FreeMem( mem, ioa->ioa_Length );
}


void init_sound( void )
{
	static UBYTE which_channels[] = { 3, 5, 10, 12 };
	
	audioport = CreateMsgPort();
	audio = 1L << audioport->mp_SigBit;
	
	memset( &ioa_samples,  0, sizeof ioa_samples  );
	memset( &ioa_allocate, 0, sizeof ioa_allocate );
	
	ioa_allocate.ioa_Request.io_Message.mn_ReplyPort = audioport;
	
	ioa_allocate.ioa_Request.io_Command = ADCMD_ALLOCATE;
	ioa_allocate.ioa_Request.io_Flags   = ADIOF_NOWAIT;
	ioa_allocate.ioa_Data               = which_channels;
	ioa_allocate.ioa_Length             = sizeof(which_channels);
	
	if( OpenDevice( AUDIONAME, 0, &ioa_allocate.ioa_Request, 0 ) == 0 )
	{
		load_sound( "click.snd",     SOUND_CLICK );
		load_sound( "explosion.snd", SOUND_EXPLOSION );
		load_sound( "sieg.snd",      SOUND_SIEG );
		load_sound( "anfang.snd",    SOUND_ANFANG );
		load_sound( "highscore.snd", SOUND_HIGHSCORE );
		
		// Kanäle ausfiltern
		units[0] = units[1] = ioa_allocate.ioa_Request.io_Unit;
		units[0] = (struct Unit *)((long)units[0] & 6);		// rechter Kanal
		units[1] = (struct Unit *)((long)units[1] & 9);		// linker Kanal
	}
	D( else PutStr( "Audio Open Failure\n" ); )
}


void handle_audioreply( void )
{
	struct IOAudio *m;
	
	while( m = GetMsg(audioport) )
	{
		FreeMem( m, sizeof(*m) );
		--pending_sound_plays;
	}
}


void close_sound( void )
{
	while( pending_sound_plays )
	{
		WaitPort( audioport );
		handle_audioreply();
	}
	
	if( ioa_allocate.ioa_Request.io_Device )
	{
		CloseDevice( &ioa_allocate.ioa_Request );
	}
	
	if( audioport ) DeleteMsgPort( audioport );
	
	free_sound( SOUND_CLICK );
	free_sound( SOUND_EXPLOSION );
	free_sound( SOUND_SIEG );
	free_sound( SOUND_ANFANG );
	free_sound( SOUND_HIGHSCORE );
}


void sound_play( int number )
{
	if( ioaudio = AllocMem( sizeof(*ioaudio), NULL ) )
	{
		*ioaudio = ioa_samples[ number ];
		
		if( ioaudio->ioa_Data )
		{
			last_unit = 1 - last_unit;
			ioaudio->ioa_Request.io_Unit = units[last_unit];
			
			BeginIO( & ioaudio->ioa_Request );
			++pending_sound_plays;
		}
	}
}
