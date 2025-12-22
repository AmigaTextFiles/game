/*
THE COMPUTER CODE CONTAINED HEREIN IS THE SOLE PROPERTY OF PARALLAX
SOFTWARE CORPORATION ("PARALLAX").  PARALLAX, IN DISTRIBUTING THE CODE TO
END-USERS, AND SUBJECT TO ALL OF THE TERMS AND CONDITIONS HEREIN, GRANTS A
ROYALTY-FREE, PERPETUAL LICENSE TO SUCH END-USERS FOR USE BY SUCH END-USERS
IN USING, DISPLAYING,  AND CREATING DERIVATIVE WORKS THEREOF, SO LONG AS
SUCH USE, DISPLAY OR CREATION IS FOR NON-COMMERCIAL, ROYALTY OR REVENUE
FREE PURPOSES.  IN NO EVENT SHALL THE END-USER USE THE COMPUTER CODE
CONTAINED HEREIN FOR REVENUE-BEARING PURPOSES.  THE END-USER UNDERSTANDS
AND AGREES TO THE TERMS HEREIN AND ACCEPTS THE SAME BY USE OF THIS FILE.  
COPYRIGHT 1993-1998 PARALLAX SOFTWARE CORPORATION.  ALL RIGHTS RESERVED.
*/
/* $Source: /usr/CVS/descent/main/inferno.c,v $
 * $Revision: 1.30 $
 * $Author: nobody $
 * $Date: 1999/03/10 23:26:55 $
 *
 * main() for Inferno  
 *
 * $Log: inferno.c,v $
 * Revision 1.30  1999/03/10 23:26:55  nobody
 * Warp3D V2 adaption
 *
 * Revision 1.29  1999/02/23 23:50:33  nobody
 * *** empty log message ***
 *
 * Revision 1.28  1998/12/21 17:12:33  nobody
 * *** empty log message ***
 *
 * Revision 1.27  1998/09/26 15:10:01  nobody
 * Added Warp3D support
 *
 * Revision 1.26  1998/08/09 23:04:27  tfrieden
 * Gave Arnje the due credits
 *
 * Revision 1.25  1998/08/08 15:44:26  nobody
 * Activated the Editior
 *
 * Revision 1.24  1998/04/25 08:39:35  nobody
 * *** empty log message ***
 *
 * Revision 1.23  1998/04/24 14:28:37  tfrieden
 * Some changes for serial/socket
 *
 * Revision 1.22  1998/04/14 23:54:00  tfrieden
 * Intermediate version
 *
 * Revision 1.21  1998/04/13 17:51:17  tfrieden
 * Kali stuff added
 *
 * Revision 1.20  1998/04/11 22:46:05  hfrieden
 * added serial stuff initalization
 *
 * Revision 1.19  1998/04/09 17:06:25  hfrieden
 * Added new ViRGE options and init call
 *
 * Revision 1.18  1998/04/09 16:17:57  tfrieden
 * Inserted -errorverbose
 *
 * Revision 1.17  1998/04/05 17:35:12  tfrieden
 * Bumped revision in VER string
 *
 * Revision 1.16  1998/04/01 21:19:36  tfrieden
 * Erm, empty log message ?
 *
 * Revision 1.15  1998/03/31 17:08:30  hfrieden
 * Added an error message for failed audio init
 *
 * Revision 1.14  1998/03/31 14:35:46  tfrieden
 * vecmat_init call added
 *
 * Revision 1.13  1998/03/30 18:44:42  hfrieden
 * Bumped AmigaOS version string
 *
 * Revision 1.12  1998/03/30 18:37:03  hfrieden
 * Added new error message for sound
 *
 * Revision 1.11  1998/03/28 23:07:48  tfrieden
 * Library open code now part of main
 *
 * Revision 1.10  1998/03/27 00:59:20  tfrieden
 * Added a standard Amiga Version string
 *
 * Revision 1.9  1998/03/25 22:39:30  hfrieden
 * ** Empty log message ***
 *
 * Revision 1.8  1998/03/25 21:35:09  tfrieden
 * New g3_project_point with fpu support
 *
 * Revision 1.7  1998/03/22 19:21:59  tfrieden
 * added fix_init call
 *
 * Revision 1.6  1998/03/22 15:25:38  tfrieden
 * Some more changes in fixpoint specific stuff
 *
 * Revision 1.5  1998/03/22 01:44:32  hfrieden
 * Texture cache commandline added
 *
 * Revision 1.4  1998/03/22 01:41:50  tfrieden
 * various bugfixes, new switches
 *
 * Revision 1.3  1998/03/18 23:20:58  tfrieden
 * Profiling and Credits
 *
 * Revision 1.2  1998/03/13 23:52:12  tfrieden
 * various changes with sound, joystick, shareware, notwork
 *
 * Revision 1.1.1.1  1998/03/03 15:12:25  nobody
 * reimport after crash from backup
 *
 * Revision 1.3  1998/02/28 00:45:07  tfrieden
 * aga support
 *
 * Revision 1.2  1998/02/18 14:57:38  hfrieden
 * few fixes
 *
 * 
 */

#pragma off (unreferenced)
static char rcsid[] = "$Id: inferno.c,v 1.30 1999/03/10 23:26:55 nobody Exp $";
static char copyright[] = "DESCENT   COPYRIGHT (C) 1994,1995 PARALLAX SOFTWARE CORPORATION";
static char version[] = "$VER: Amiga Descent 0.8 (21 Dec 1998) © Parallax Software/Thomas & Hans-Jörg Frieden";
#pragma on (unreferenced)

#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include <inline/cybergraphics.h>
#include <cybergraphics/cybergraphics.h>
#include <inline/intuition.h>
#include <intuition/intuition.h>
#include <inline/graphics.h>
#include <graphics/gfx.h>
#include <inline/utility.h>
#include <utility/utility.h>
#include <inline/exec.h>
#include <exec/exec.h>
#include <clib/asl_protos.h>
#include <libraries/asl.h>
#include <inline/asl.h>


#include "gr.h"
#include "ui.h"
#include "mono.h"
#include "key.h"
#include "timer.h"
#include "3d.h"
#include "bm.h"
#include "inferno.h"
#include "error.h"
#include "cflib.h"
// #include "div0.h"
#include "game.h"
#include "segment.h"        //for Side_to_verts
#include "mem.h"
#include "textures.h"
#include "segpoint.h"
#include "screens.h"
#include "texmap.h"
#include "texmerge.h"
#include "menu.h"
#include "wall.h"
#include "switch.h"
#include "polyobj.h"
#include "effects.h"
#include "digi.h"
#include "iff.h"
#include "pcx.h"
#include "palette.h"
#include "args.h"
#include "sounds.h"
#include "titles.h"
#include "player.h"
#include "text.h"
#include "ipx.h"
#include "newdemo.h"
#include "victor.h"
#include "network.h"
#include "modem.h"
#include "gamefont.h"
#include "kconfig.h"
#include "arcade.h"
#include "coindev.h"
#include "mouse.h"
#include "joy.h"
#include "newmenu.h"
#include "desc_id.h"
#include "config.h"
#include "joydefs.h"
#include "multi.h"
#include "iglasses.h"
#include "songs.h"
#include "cfile.h"
#include "cdrom.h"
#include "gameseq.h"

#ifdef EDITOR
#include "editor/editor.h"
#include "editor/kdefs.h"
#endif

#include "vers_id.h"

#ifdef VIRGIN
extern void MakeBitValues(void);
#endif

#ifdef DEBUG_PROFILE
fix profile_full_time = 0;          //  Game execution times
fix profile_mtn_time = 0;
int profile_mtn_called = 0;
fix profile_mtsx_time = 0;
int profile_mtsx_called = 0;
fix profile_glrm_time = 0;
int profile_glrm_called = 0;
fix profile_glrmf_time = 0;
int profile_glrmf_called = 0;
fix profile_dt_time = 0;
int profile_dt_called = 0;
fix profile_fa2_time = 0;
int profile_fa2_called = 0;
fix profile_fd_time = 0;
int profile_fd_called = 0;
fix profile_fm_time = 0;
int profile_fm_called = 0;
fix profile_fmd_time = 0;
int profile_fmd_called = 0;
#endif

extern int Game_simuleyes_flag;

extern struct Screen *scr;
extern struct Window *win;
extern struct Library *CyberGfxBase, *IntuitionBase, *GfxBase;

static const char desc_id_checksum_str[] = DESC_ID_CHKSUM;
char desc_id_exit_num = 0;

int Function_mode=FMODE_MENU;       //game or editor?
int Screen_mode=-1;                 //game screen or editor screen?
int Automap_large_screen = 0;       //  Use a large automapper screen
//--unused-- grs_bitmap Inferno_bitmap_title;

int WVIDEO_running=0;       //  debugger can set to 1 if running
int Network_linux = 1;      //
#ifdef EDITOR
int Inferno_is_800x600_available = 0;
#endif

//--unused-- int Cyberman_installed=0;          // SWIFT device present

void check_joystick_calibration(void);
void show_order_form(void);


extern fix minrate, maxrate;

#ifndef NDEBUG
do_heap_check()
{
}
#endif

int registered_copy=0;
char name_copy[sizeof(DESC_ID_STR)];

struct Library *CyberGfxBase = NULL;
struct Library *IntuitionBase = NULL;
struct Library *GfxBase = NULL;
struct Library *AslBase = NULL;
extern struct Library *SysBase;
#ifdef VIRGIN
struct Library *CGX3DVirginBase = NULL;
#endif
struct Library *UtilityBase = NULL;
#ifdef WARP3D
struct Library *Warp3DBase;
#endif


void CloseLibs(void)
{

	if (CyberGfxBase)       CloseLibrary(CyberGfxBase);
	if (IntuitionBase)      CloseLibrary(IntuitionBase);
	if (GfxBase)            CloseLibrary(GfxBase);
	if (AslBase)            CloseLibrary(AslBase);
	if (UtilityBase)        CloseLibrary(UtilityBase);
#ifdef VIRGIN
	if (CGX3DVirginBase)    CloseLibrary(CGX3DVirginBase);
#endif
#ifdef WARP3D
	if (Warp3DBase)         CloseLibrary(Warp3DBase);
#endif
}

void OpenLibs(void)
{

	atexit(CloseLibs);

	IntuitionBase   = OpenLibrary("intuition.library", 0);
	if (!IntuitionBase) {
		printf("Error: Can`t open intuition.library\n", 0);
		exit(1);
	}
	GfxBase         = OpenLibrary("graphics.library", 0L);
	if (!GfxBase) {
		printf("Error: Can`t open graphics.library\n");
		exit(1);
	}
	CyberGfxBase    = OpenLibrary("cybergraphics.library", 0l);
	AslBase         = OpenLibrary("asl.library", 0l);
	if (!AslBase) {
		printf("Error: Can`t open asl.library\n");
		exit(1);
	}
	UtilityBase     = OpenLibrary("utility.library", 39l);
	if (!UtilityBase) {
		printf("Error: Can`t open utility.library version 39\n");
		exit(1);
	}
	#ifdef VIRGIN
	CGX3DVirginBase = OpenLibrary("cgx3dvirgin.library", 2L);
	if (!CGX3DVirginBase) {
		printf("Error: The ViRGE version needs cgx3dvirgin.library\n");
		exit(1);
	}
	#endif

	#ifdef WARP3D
	Warp3DBase = OpenLibrary("Warp3D.library", 0L);
	if (!Warp3DBase) {
		printf("Error: The Warp3D version needs Warp3D installed\n");
		exit(1);
	}
	#endif
}



void
check_id_checksum_and_date()
{
	const char name[] = DESC_ID_STR;
	char time_str[] = DESC_DEAD_TIME;
	int i, found;
	unsigned long *checksum, test_checksum;
	time_t current_time, saved_time;

	saved_time = (time_t)strtol(&(time_str[strlen(time_str) - 10]), NULL, 16);
	if (saved_time == (time_t)0)
		return;

	strcpy(name_copy,name);
	registered_copy = 1;

	current_time = time(NULL);
	if (current_time >= saved_time)
		desc_id_exit_num = 1;

	test_checksum = 0;
	for (i = 0; i < strlen(name); i++) {
		found = 0;    
		test_checksum += name[i];
		if (((test_checksum / 2) * 2) != test_checksum)
			found = 1;
		test_checksum = test_checksum >> 1;
		if (found)
			test_checksum |= 0x80000000;
	}
	checksum = (unsigned long *)&(desc_id_checksum_str[0]);
	if (test_checksum != *checksum)
		desc_id_exit_num = 2;

	printf ("%s %s\n", TXT_REGISTRATION, name);
}

int init_graphics()
{
	int result;

	result=gr_check_mode(SM_320x200C);
#ifdef EDITOR
	if ( result==0 )    
		result=gr_check_mode(SM_800x600V);
#endif

	switch( result )    {
		case  0:        //Mode set OK
#ifdef EDITOR
						Inferno_is_800x600_available = 1;
#endif
						break;
		case  1:        //No VGA adapter installed
						printf("%s\n", TXT_REQUIRES_VGA );
						return 1;
		case 10:        //Error allocating selector for A0000h
						printf( "%s\n",TXT_ERROR_SELECTOR );
						return 1;
		case 11:        //Not a valid mode support by gr.lib
						printf( "%s\n", TXT_ERROR_GRAPHICS );
						return 1;
#ifdef EDITOR
		case  3:        //Monitor doesn't support that VESA mode.
		case  4:        //Video card doesn't support that VESA mode.

						printf( "Your VESA driver or video hardware doesn't support 800x600 256-color mode.\n" );
						break;
		case  5:        //No VESA driver found.
						printf( "No VESA driver detected.\n" );
						break;
		case  2:        //Program doesn't support this VESA granularity
		case  6:        //Bad Status after VESA call/
		case  7:        //Not enough DOS memory to call VESA functions.
		case  8:        //Error using DPMI.
		case  9:        //Error setting logical line width.
		default:
						printf( "Error %d using 800x600 256-color VESA mode.\n", result );
						break;
#endif
	}

	return 0;
}

extern fix fixed_frametime;

// Returns 1 if ok, 0 if failed...
int init_gameport()
{
	// FIXME add joystick module support
}

void change_to_dir(char *cmd_line)
{
	chdir(cmd_line);
}

#define NEEDED_DOS_MEMORY               ( 300*1024)     // 300 K
#define NEEDED_LINEAR_MEMORY            (7680*1024)     // 7.5 MB
#define LOW_PHYSICAL_MEMORY_CUTOFF  (5*1024*1024)   // 5.0 MB
#define NEEDED_PHYSICAL_MEMORY      (2000*1024)     // 2000 KB

extern int piggy_low_memory;

void mem_int_to_string( int number, char *dest )
{
	int i,l,c;
	char buffer[20],*p;

	sprintf( buffer, "%d", number );

	l = strlen(buffer);
	if (l<=3) {
		// Don't bother with less than 3 digits
		sprintf( dest, "%d", number );
		return;
	}

	c = 0;
	p=dest;
	for (i=l-1; i>=0; i-- ) {
		if (c==3) {
			*p++=',';
			c = 0;
		}
		c++;
		*p++ = buffer[i];
	}
	*p++ = '\0';
	strrev(dest);
}

void check_memory()
{
}


int Inferno_verbose = 0;
int Int3_error_verbose = 0;
int UseShareware = 0;

extern int digi_timer_rate;

int descent_critical_error = 0;
unsigned descent_critical_deverror = 0;
unsigned descent_critical_errcode = 0;

extern int Network_allow_socket_changes;

extern void vfx_set_palette_sub(ubyte *);

extern int Game_vfx_flag;
extern int Game_victor_flag;
extern int Game_vio_flag;
extern int Game_3dmax_flag;
extern int VR_low_res;
extern void vfx_init();

#ifdef USE_CD
char destsat_cdpath[128] = "";
int find_descent_cd();
#endif

extern int Config_vr_type;
extern int Config_vr_tracking;

#ifdef VIRGIN
extern int VirgeHave320;
#endif

extern int gr_keep_resolution;

int main(int argc,char **argv)
{
	int i,t;
	int a,b;
	ubyte title_pal[768];

	OpenLibs();                 //  Open Amiga system libraries

	error_init(NULL);

	//setbuf(stdout, NULL);   // unbuffered output via printf
		
	InitArgs( argc,argv );

	if ( FindArg( "-verbose" ) )
		Inferno_verbose = 1;

	if ( FindArg( "-errorverbose" ) )
		Int3_error_verbose = 1;

	if ( FindArg( "-shareware") ) {
		printf("Using shareware files\n");
		UseShareware = 1;
	}

	if ( FindArg( "-largemap") ) {
		printf("Using large automap\n");
		Automap_large_screen = 1;
	}

	if ( FindArg( "-keepres") ) {
		printf("Keeping resolution\n");
		gr_keep_resolution = 1;
	}

	fix_init();
	g3_init_math();
	#ifdef VIRGIN
	VirgeInit();
	if ( FindArg("-virge200"))  VirgeHave320 = 1;
	else                        VirgeHave320 = 0;
	#endif
	vecmat_init();

#ifdef USE_CD
	i=find_descent_cd();
	if ( i>0 )      {
		sprintf( destsat_cdpath, "%c:\\descent\\", i +'a' - 1  );
		cfile_use_alternate_hogdir( destsat_cdpath );
	} 
#ifdef REQUIRE_CD
	else {      // NOTE ABOVE LINK!!!!!!!!!!!!!!!!!!
		printf( "\n\n" );
#ifdef DEST_SAT
		printf("Couldn't find the 'Descent: Destination Saturn' CD-ROM.\n" );
#else
		printf("Couldn't find the Descent CD-ROM.\n" );
#endif
		printf("Please make sure that it is in your CD-ROM drive and\n" );
		printf("that your CD-ROM drivers are loaded correctly.\n" );
		exit(1);
	}
#endif
#endif

	load_text();

//  set_exit_message("\n\n%s", TXT_THANKS);

	printf("\nDESCENT   %s\n", VERSION_NAME);
	printf("%s\n%s\n",TXT_COPYRIGHT,TXT_TRADEMARK); 
	printf("\nAmiga version  by\nThomas Frieden\nHans-Jörg Frieden\n");
	printf("C2P functions by Peter McGavin, based on work by James McCoull\n");
	printf("IPX driver by Philip Grosswiler\n");
	printf("KALI support by Arne de Bruijn\n");


	check_id_checksum_and_date();

	if (FindArg( "-?" ) || FindArg( "-help" ) || FindArg( "?" ) )   {

		printf( "%s\n", TXT_COMMAND_LINE_0 );

/*        printf("  -SimulEyes     %s\n",
				"Enables StereoGraphics SimulEyes VR stereo display" );

		printf("  -Iglasses      %s\n", TXT_IGLASSES );
		printf("  -VioTrack <n>  %s n\n",TXT_VIOTRACK );
		printf("  -3dmaxLo       %s\n",TXT_KASAN );
		printf("                 %s\n",TXT_KASAN_2 );
		printf("  -3dmaxHi       %s\n",TXT_3DMAX );*/
		printf( "%s\n", TXT_COMMAND_LINE_1 );
		printf( "%s\n", TXT_COMMAND_LINE_2 );
		printf( "%s\n", TXT_COMMAND_LINE_3 );
		printf( "%s\n", TXT_COMMAND_LINE_4 );
		printf( "%s\n", TXT_COMMAND_LINE_5 );
//      printf( "\n");
		printf( "%s\n", TXT_COMMAND_LINE_6 );
		printf( "%s\n", TXT_COMMAND_LINE_7 );
		printf( "%s\n", TXT_COMMAND_LINE_8 );
//      printf( "\n");
		printf( "\n%s\n",TXT_PRESS_ANY_KEY3);
		getc(stdin);
		printf( "\n" );
		printf( "%s\n", TXT_COMMAND_LINE_9);
		printf( "%s\n", TXT_COMMAND_LINE_10);
		printf( "%s\n", TXT_COMMAND_LINE_11);
		printf( "%s\n", TXT_COMMAND_LINE_12);
		printf( "%s\n", TXT_COMMAND_LINE_13);
		printf( "%s\n", TXT_COMMAND_LINE_14);
		printf( "%s\n", TXT_COMMAND_LINE_15);
		printf( "%s\n", TXT_COMMAND_LINE_16);
		printf( "%s\n", TXT_COMMAND_LINE_17);
		printf( "%s\n", TXT_COMMAND_LINE_18);
	  printf( "  -DynamicSockets %s\n", TXT_SOCKET);
	  printf( "  -NoFileCheck    %s\n", TXT_NOFILECHECK);
//      printf( "  -GamePort       %s\n", "Use Colorado Spectrum's Notebook Gameport" );
		printf( "  -NoDoubleBuffer %s\n", "Use only one page of video memory" );
//        printf( "  -LCDBios        %s\n", "Enables LCDBIOS for using LCD shutter glasses" );
		printf( "  -JoyNice        %s\n", "Joystick poller allows interrupts to occur" );
		set_exit_message("");
		return(0);
	}

	printf("\n%s\n", TXT_HELP); 

	#ifdef PASSWORD
	if ((t = FindArg("-pswd")) != 0) {
		int n;
		byte    *pp = Side_to_verts;
		int ch;
		for (n=0; n<6; n++)
			for (ch=0; ch<strlen(Args[t+1]); ch++)
				*pp++ ^= Args[t+1][ch];
	}
	else 
		Error("Invalid processor");     //missing password
	#endif

	if ( FindArg( "-autodemo" ))
		Auto_demo = 1;

	#ifndef RELEASE
	if ( FindArg( "-noscreens" ) )
		Skip_briefing_screens = 1;
	#endif

	Lighting_on = 1;

	strcpy(Menu_pcx_name, "menu.pcx");  //  Used to be menu2.pcx.

	if (init_graphics()) return 1;

	#ifdef EDITOR
	if (!Inferno_is_800x600_available)  {
		printf( "The editor will not be available, press any key to start game...\n" );
		Function_mode = FMODE_MENU;
		//getch();
	}
	#endif

	#ifndef NDEBUG
		minit();
		mopen( 0, 9, 1, 78, 15, "Debug Spew");
		mopen( 1, 2, 1, 78,  5, "Errors & Serious Warnings");
	#endif

	if (!WVIDEO_running)
		mprintf((0,"WVIDEO_running = %d\n",WVIDEO_running));

	//lib_init("INFERNO.DAT");

	if (Inferno_verbose) printf ("%s", TXT_VERBOSE_1);
	ReadConfigFile();
	if (Inferno_verbose) printf( "\n%s", TXT_VERBOSE_2);

	timer_init();
	timer_set_rate( digi_timer_rate );          // Tell our timer how fast to go (120 Hz)
	joy_set_timer_rate( digi_timer_rate );      // Tell joystick how fast timer is going

	if (Inferno_verbose) printf( "\n%s", TXT_VERBOSE_3);
	key_init();
	if (!FindArg( "-nomouse" )) {
		if (Inferno_verbose) printf( "\n%s", TXT_VERBOSE_4);
		if (FindArg( "-nocyberman" ))
			mouse_init(0);
		else
			mouse_init(1);
	} else {
		if (Inferno_verbose) printf( "\n%s", TXT_VERBOSE_5);
	}
	if (!FindArg( "-nojoystick" ))  {
		if (Inferno_verbose) printf( "\n%s", TXT_VERBOSE_6);
		joy_init();
		if ( FindArg( "-joyslow" )) {
			if (Inferno_verbose) printf( "\n%s", TXT_VERBOSE_7);
			joy_set_slow_reading(JOY_SLOW_READINGS);
		}
		if ( FindArg( "-joypolled" ))   {
			if (Inferno_verbose) printf( "\n%s", TXT_VERBOSE_8);
			joy_set_slow_reading(JOY_POLLED_READINGS);
		}
		if ( FindArg( "-joybios" )) {
			if (Inferno_verbose) printf( "\n%s", TXT_VERBOSE_9);
			joy_set_slow_reading(JOY_BIOS_READINGS);
		}
		if ( FindArg( "-joynice" )) {
			if (Inferno_verbose) printf( "\n%s", "Using nice joystick poller..." );
			joy_set_slow_reading(JOY_FRIENDLY_READINGS);
		}
		if ( FindArg( "-gameport" ))    {
			if ( init_gameport() )  {           
				joy_set_slow_reading(JOY_BIOS_READINGS);
			} else {
				Error( "\nCouldn't initialize the Notebook Gameport.\nMake sure the NG driver is loaded.\n" );
			}
		}
	} else {
		if (Inferno_verbose) printf( "\n%s", TXT_VERBOSE_10);
	}
	if (Inferno_verbose) printf( "\n%s", TXT_VERBOSE_11);
	// div0_init(DM_ERROR); <-- We don need no steenking /0

	//------------ Init sound ---------------
	if (!FindArg( "-nosound" )) {
		if (digi_init())    {
			printf( "Error initializing sound\n%s\n", TXT_PRESS_ANY_KEY3);
			getc(stdin);
		}
	} else {
		if (Inferno_verbose) printf( "\n%s",TXT_SOUND_DISABLED );
	}

	if (FindArg( "-network" ))   {
		int socket=0, showaddress=0;
		int ipx_error;

		if (FindArg("-kali"))   Network_linux = 1;
		else                    Network_linux = 0;
		if (Inferno_verbose) printf( "\n%s ", TXT_INITIALIZING_NETWORK);
		if ((t=FindArg("-socket")))
			socket = atoi( Args[t+1] );
		if ( FindArg("-showaddress") ) showaddress=1;
		if (Network_linux == 0) {
			if ((ipx_error=ipx_init(IPX_DEFAULT_SOCKET+socket,showaddress))==0) {
				if (Inferno_verbose) printf( "%s %d.\n", TXT_IPX_CHANNEL, socket );
				Network_active = 1;
			} else {
				switch( ipx_error ) {
				case 3:     if (Inferno_verbose) printf( "%s\n", TXT_NO_NETWORK); break;
				case -2: if (Inferno_verbose) printf( "%s 0x%x.\n", TXT_SOCKET_ERROR, IPX_DEFAULT_SOCKET+socket); break;
				case -4: if (Inferno_verbose) printf( "%s\n", TXT_MEMORY_IPX ); break;
				default:
					if (Inferno_verbose) printf( "%s %d\n", TXT_ERROR_IPX, ipx_error );
				}
				if (Inferno_verbose) printf( "%s\n",TXT_NETWORK_DISABLED);
				Network_active = 0;     // Assume no network
			}
			ipx_read_user_file( "descent.usr" );
			ipx_read_network_file( "descent.net" );
			if ( FindArg( "-dynamicsockets" ))
				Network_allow_socket_changes = 1;
			else
				Network_allow_socket_changes = 0;
		} else {
			if ((ipx_error=ipx_init_kali(IPX_DEFAULT_SOCKET+socket,showaddress))==0) {
				if (Inferno_verbose) printf( "%s %d.\n", TXT_IPX_CHANNEL, socket );
				Network_active = 1;
			} else {
				switch( ipx_error ) {
				case 3:     if (Inferno_verbose) printf( "%s\n", TXT_NO_NETWORK); break;
				case -2: if (Inferno_verbose) printf( "%s 0x%x.\n", TXT_SOCKET_ERROR, IPX_DEFAULT_SOCKET+socket); break;
				case -4: if (Inferno_verbose) printf( "%s\n", TXT_MEMORY_IPX ); break;
				default:
					if (Inferno_verbose) printf( "%s %d\n", TXT_ERROR_IPX, ipx_error );
				}
				if (Inferno_verbose) printf( "%s\n",TXT_NETWORK_DISABLED);
				Network_active = 0;     // Assume no network
			}
			ipx_read_user_file_kali( "descent.usr" );
			ipx_read_network_file_kali( "descent.net" );
			if ( FindArg( "-dynamicsockets" ))
				Network_allow_socket_changes = 1;
			else
				Network_allow_socket_changes = 0;
		}
	} else {
		if (Inferno_verbose) printf( "\n%s", TXT_NETWORK_DISABLED);
		Network_active = 0;     // Assume no network
	}

	a = FindArg("-noserial");
	b = FindArg("-noip");
	serial_active = 0;
	if (!a && !b)               //  both options may be used
	{
		serial_active = 3;
		amiserial_init();
		socket_init();
	}
	if (!a && b)                //  do not use ip
	{
		serial_active = 1;
		amiserial_init();
	}
	if (a && !b)                //  do not use serial
	{
		serial_active = 2;
		socket_init();
	}

	i = FindArg( "-vfxtrak" );
	if ( i > 0 )
		kconfig_sense_init();
	else if ((Config_vr_type==1)&&(Config_vr_tracking>0))
		kconfig_sense_init();
		
	i = FindArg( "-maxxtrak" );
	if ( i > 0) 
		victor_init_tracking( atoi(Args[i+1]) );
	else if ((Config_vr_type==2)&&(Config_vr_tracking>0))
		victor_init_tracking( Config_vr_tracking );

	// i = FindArg( "-viotrack" );
	{
		int screen_mode = SM_320x200C;
		int screen_width = 320;
		int screen_height = 200;
		int vr_mode = VR_NONE;
		int screen_compatible = 1;
		int use_double_buffer = 0;

		if ( FindArg( "-320x240" )) {
			if (Inferno_verbose) printf( "Using 320x240 ModeX...\n" );
			screen_mode = SM_320x240U; 
			screen_width = 320; 
			screen_height = 240;
			screen_compatible = 0;
			use_double_buffer = 1;
		}
		if ( FindArg( "-320x400" )) {
			if (Inferno_verbose) printf( "Using 320x400 ModeX...\n" );
			screen_mode = SM_320x400U; 
			screen_width = 320; 
			screen_height = 400;
			screen_compatible = 0;
			use_double_buffer = 1;
		}

		if (!Game_simuleyes_flag && FindArg( "-640x400" ))  {
			if (Inferno_verbose) printf( "Using 640x400 VESA...\n" );
			screen_mode = SM_640x400V; 
			screen_width = 640; 
			screen_height = 400;
			screen_compatible = 0;
			use_double_buffer = 1;
		}

		if (!Game_simuleyes_flag && FindArg( "-640x480" ))  {
			if (Inferno_verbose) printf( "Using 640x480 VESA...\n" );
			screen_mode = SM_640x480V; 
			screen_width = 640; 
			screen_height = 480;
			screen_compatible = 0;
			use_double_buffer = 1;
		}
		if (!Game_simuleyes_flag && FindArg( "-800x600" ))  {
			if (Inferno_verbose) printf( "Using 800x600 VESA...\n" );
			screen_mode = SM_800x600V;
			screen_width = 800;
			screen_height = 600;
			screen_compatible = 0;
			use_double_buffer = 1;
		}

		if ( FindArg( "-320x100" )) {
			if (Inferno_verbose) printf( "Using 320x100 VGA...\n" );
			screen_mode = 19; 
			screen_width = 320; 
			screen_height = 100;
			screen_compatible = 0;
		}

		if ( FindArg( "-nodoublebuffer" ) ) {
			if (Inferno_verbose) printf( "Double-buffering disabled...\n" );
			use_double_buffer = 0;
		}
		// -----------
		if (Inferno_verbose) {
			printf("Compatibility : %d\n", screen_compatible);
			printf("DBuffering    : %d\n", use_double_buffer);
			printf("VRMode        : %d\n", vr_mode);
			printf("Screen Mode   : %d\n", screen_mode);
			printf("Screen Width  : %d\n", screen_width);
			printf("Screen Height : %d\n", screen_height);
		}
		// -----------
		if ( vr_mode == VR_INTERLACED ) 
			screen_height /= 2;
		game_init_render_buffers(screen_mode, screen_width, screen_height, use_double_buffer, vr_mode, screen_compatible );
	}

	if (Game_victor_flag) {
		char *vswitch = getenv( "CYBERMAXX" );
		if ( vswitch )  {
			char *p = strstr( vswitch, "/E:R" ); 
			if ( p )    {
				VR_switch_eyes = 1;
			} else 
				VR_switch_eyes = 0;
		} else {        
			VR_switch_eyes = 0;
		}
	}


#ifdef ARCADE
	i = FindArg( "-arcade" );
	if (i > 0 ) {
		arcade_init();
		coindev_init(0);
	}
#endif

#ifdef NETWORK
//  i = FindArg( "-rinvul" );
//  if (i > 0) {
//      int mins = atoi(Args[i+1]);
//      if (mins > 314)
//          mins = 314;
//  control_invul_time = mins/5;
//  }
	control_invul_time = 0;
#endif

	i = FindArg( "-xcontrol" );
	if ( i > 0 )    {
		kconfig_init_external_controls( strtol(Args[i+1], NULL, 0), strtol(Args[i+2], NULL, 0) );
	}

	if (Inferno_verbose) printf( "\n%s\n\n", TXT_INITIALIZING_GRAPHICS);
	if ((t=gr_init( SM_ORIGINAL ))!=0)
		Error(TXT_CANT_INIT_GFX,t);
	// Load the palette stuff. Returns non-zero if error.
	mprintf( (0, "Going into graphics mode..." ));
	gr_set_mode(SM_320x200C);
	mprintf( (0, "\nInitializing palette system..." ));
	gr_use_palette_table( "PALETTE.256" );
	mprintf( (0, "\nInitializing font system..." ));
	gamefont_init();    // must load after palette data loaded.
	songs_play_song( SONG_TITLE, 1 );

	#ifndef RELEASE
	if ( !FindArg( "-notitles" ) ) 
	#endif
	{   //NOTE LINK TO ABOVE!
		show_title_screen( "iplogo1.pcx", 1 );
		show_title_screen( "logo.pcx", 1 );
	}

	{
		grs_bitmap title_bm;
		int pcx_error;
		char filename[14];

		strcpy(filename, "descent.pcx");

		if ((pcx_error=pcx_read_bitmap( filename, &grd_curcanv->cv_bitmap, grd_curcanv->cv_bitmap.bm_type, title_pal ))==PCX_ERROR_NONE)    {
			gr_palette_clear();
			#if defined(VIRGIN) && defined(WARP3D)
			gr_palette_fade_in(title_pal, 1,0);
			#endif
			gr_update(NULL);
			gr_palette_fade_in( title_pal, 32, 0 );
		} else {
			gr_close();
			Error( "Couldn't load pcx file '%s', PCX load error: %s\n",filename, pcx_errormsg(pcx_error));
		}
	}

#ifdef EDITOR
//    if ( !FindArg("-nobm") )
//        bm_init_use_tbl();
//    else
		bm_init();
#else
		bm_init();
#endif

	if ( FindArg( "-norun" ) )
		return(0);

	mprintf( (0, "\nInitializing 3d system..." ));
	g3_init();
	mprintf( (0, "\nInitializing texture caching system..." ));
	i=FindArg("-texcache");
	if (i) {
		int blah = atol(Args[i+1]);
		if (blah<10) blah=10;
		texmerge_init(blah);
	} else {
		texmerge_init( 10 );        // 10 cache bitmaps
	}
	mprintf( (0, "\nRunning game...\n" ));
	set_screen_mode(SCREEN_MENU);

	init_game();
	set_detail_level_parameters(Detail_level);

	Players[Player_num].callsign[0] = '\0';
	if (!Auto_demo)     {
		key_flush();
		RegisterPlayer();       //get player's name
	}

	gr_update(NULL);
	gr_palette_fade_out( title_pal, 32, 0 );

	//check for special stamped version
	if (registered_copy) {
		nm_messagebox("EVALUATION COPY",1,"Continue",
			"This special evaluation copy\n"
			"of DESCENT has been issued to:\n\n"
			"%s\n"
			"\n\n    NOT FOR DISTRIBUTION",
			name_copy);

		gr_palette_fade_out( gr_palette, 32, 0 );
	}

	//kconfig_load_all();

	Game_mode = GM_GAME_OVER;

	if (Auto_demo)  {
		newdemo_start_playback("DESCENT.DEM");      
		if (Newdemo_state == ND_STATE_PLAYBACK )
			Function_mode = FMODE_GAME;
	}

	build_mission_list(0);      // This also loads mission 0.
	while (Function_mode != FMODE_EXIT)
	{
		switch( Function_mode ) {
		case FMODE_MENU:
			if ( Auto_demo )    {
				newdemo_start_playback(NULL);       // Randomly pick a file
				if (Newdemo_state != ND_STATE_PLAYBACK) 
					Error("No demo files were found for autodemo mode!");
			} else {
				check_joystick_calibration();
				gr_update(NULL);
				DoMenu();                                       
#ifdef EDITOR
				if ( Function_mode == FMODE_EDITOR )    {
					create_new_mine();
					SetPlayerFromCurseg();
				}
#endif
			}
			break;
		case FMODE_GAME:
			#ifdef EDITOR
				keyd_editor_mode = 0;
			#endif
			keyboard_update();
			game();
			if ( Function_mode == FMODE_MENU )
				songs_play_song( SONG_TITLE, 1 );
			break;
		#ifdef EDITOR
		case FMODE_EDITOR:
			keyd_editor_mode = 1;
			editor();
//            _harderr( (void *)descent_critical_error_handler );     // Reinstall game error handler
			if ( Function_mode == FMODE_GAME ) {
				Game_mode = GM_EDITOR;
				editor_reset_stuff_on_level();
				N_players = 1;
			}
			break;
		#endif
		default:
			Error("Invalid function mode %d",Function_mode);
		}
	}

	WriteConfigFile();

#ifndef ROCKWELL_CODE
	#ifndef RELEASE
	if (!FindArg( "-notitles" ))
	#endif
		//NOTE LINK TO ABOVE!!
	#ifndef EDITOR
		show_order_form();
	#endif
#endif

	#ifndef NDEBUG
	if ( FindArg( "-showmeminfo" ) )
//      show_mem_info = 1;      // Make memory statistics show
	#endif

	fflush(stdout);
	if (Inferno_verbose) {
		printf("Frametime results (1/1000 s):\nMinimal frametime: %f\nMaximal frametime: %f\n",
			minrate/65.536, maxrate/65.536);
	}

	return(0);      //presumably successful exit
}


void check_joystick_calibration(void)   {
	int x1, y1, x2, y2, c;
	fix t1;

	if ( (Config_control_type!=CONTROL_JOYSTICK) &&
		  (Config_control_type!=CONTROL_FLIGHTSTICK_PRO) &&
		  (Config_control_type!=CONTROL_THRUSTMASTER_FCS) &&
		  (Config_control_type!=CONTROL_GRAVIS_GAMEPAD)
		) return;

	joy_get_pos( &x1, &y1 );

	t1 = timer_get_fixed_seconds();
	while( timer_get_fixed_seconds() < t1 + F1_0/100 )
		;

	joy_get_pos( &x2, &y2 );

	// If joystick hasn't moved...
	if ( (abs(x2-x1)<30) &&  (abs(y2-y1)<30) )  {
		if ( (abs(x1)>30) || (abs(x2)>30) ||  (abs(y1)>30) || (abs(y2)>30) )    {
			c = nm_messagebox( NULL, 2, TXT_CALIBRATE, TXT_SKIP, TXT_JOYSTICK_NOT_CEN );
			if ( c==0 ) {
				joydefs_calibrate();
			}
		}
	}

}

void show_order_form()
{
	int pcx_error;
	char title_pal[768];
	char    exit_screen[16];

	gr_set_current_canvas( NULL );
	gr_palette_clear();

	key_flush();        

	if (UseShareware)
		strcpy(exit_screen, "order01.pcx");
	else
		strcpy(exit_screen, "warning.pcx");

	if ((pcx_error=pcx_read_bitmap( exit_screen, &grd_curcanv->cv_bitmap, grd_curcanv->cv_bitmap.bm_type, title_pal ))==PCX_ERROR_NONE) {
		gr_palette_fade_in( title_pal, 32, 0 );
		gr_update(NULL);
		{
			int done=0;
			fix time_out_value = timer_get_approx_seconds()+i2f(60*5);
			while(!done)    {
				if ( timer_get_approx_seconds() > time_out_value ) done = 1;
				if (key_inkey()) done = 1;
			}
		}
		gr_palette_fade_out( title_pal, 32, 0 );        
	}
	key_flush();        
}

