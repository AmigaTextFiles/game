/*
 *     main.c: Ablaufsteuerung
 *
 *     Auto: make Bomber
 *
 */


#include "Bomber.h"

#if 0
# define D(debug) debug
#else
# define D(debug)
#endif



/*------------------------- Externe Daten...*/


extern struct ExecBase	*SysBase;
extern struct Library	*DOSBase;

extern int				time_counter;


/*------------------------- Daten dieses Moduls...*/


long					fenster = 0,	// Signale
						timer = 0,
						audio = 0;

BOOL					ende = FALSE;	// s.a. display.c

struct MsgPort			*timeport;
struct timerequest		*timereq;


/*------------------------- Code-Deklarationen...*/


extern void init_game( void );
extern void init_sound( void );
extern void init_display( void );
extern void init_highscore( void );
extern void close_game( void );
extern void close_sound( void );
extern void close_display( void );
extern void close_highscore( void );

extern BOOL handle_window_event( void );
extern void count_down( void );

extern void handle_audioreply( void );

void close_all( void );


/*------------------------- Code-Definitionen...*/


void sendtimereq( long s, long m )
{
	D(PutStr("sendtimereq\n"));
	timereq->tr_time.tv_secs  = s;
	timereq->tr_time.tv_micro = m;
	SendIO( timereq );
}


void quit( char *msg )
{
	if( msg )
		PutStr( msg );
	
	close_all();
}


void open_all( void )
{
	D(PutStr("init main\n"));
	
	/* Timer-Device-Stuff */
	timeport = CreateMsgPort();
	timer = 1L << timeport->mp_SigBit;
	timereq = CreateIORequest( timeport, sizeof(struct timerequest) );
	OpenDevice( TIMERNAME, UNIT_VBLANK, timereq, 0 );
	timereq->tr_node.io_Command = TR_ADDREQUEST;
	timereq->tr_node.io_Message.mn_ReplyPort = timeport;
	
	init_highscore();
	init_game();
	init_sound();
	init_display();
}


void stop_timer( void )
{
	if( time_counter )
	{
		AbortIO( timereq );
		WaitIO( timereq );
		while( GetMsg(timeport) );
		SetSignal( 0, timer );
		
		time_counter = 0;
	}
}


void close_all( void )
{
	close_display();
	close_sound();
	close_highscore();
	close_game();
	
	D(PutStr("close main\n"));
	
	/* Timer-Device schliessen */
	stop_timer();
	CloseDevice( timereq );
	DeleteIORequest( timereq );
	DeleteMsgPort( timeport );
	
	exit(0);
}


int main( int argc, char *argv[] )
{
	open_all();
	
	while( !ende )
	{
		long signale = Wait( fenster | timer | audio );
		
		if( signale & timer )
		{
			while( GetMsg(timeport) );
			count_down();
		}
		
		if( signale & fenster )
		{
			ende = handle_window_event();
		}
		
		if( signale & audio )
		{
			handle_audioreply();
		}
	}
	
	close_all();
}
