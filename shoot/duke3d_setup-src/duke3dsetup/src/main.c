#define SETUPVERSION    2

#include <stdio.h>
#include <string.h>

#include <exec/exec.h>
#include <dos/dos.h>
#include <intuition/intuition.h>
#include <graphics/gfx.h>
#include <libraries/asl.h>
#include <libraries/gadtools.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/asl.h>
#include <proto/gadtools.h>

#include "dukesetupgui.h"
#include "amigasetupstructs.h"
#include "mainsetup.h"
#include "soundsetup.h"
#include "screensetup.h"
#include "mousesetup.h"
#include "kbsetup.h"

struct IntuitionBase *IntuitionBase;
struct GfxBase       *GfxBase;
struct Library       *GadToolsBase;
struct Library       *AslBase;
struct DosLibrary    *DOSBase;
struct Library       *LowLevelBase;

int screeninit;

SetupData setupdata;

char *gamefunctions[] =
{
    "Move_Forward",
    "Move_Backward",
    "Turn_Left",
    "Turn_Right",
    "Strafe",
    "Fire",
    "Open",
    "Run",
    "AutoRun",
    "Jump",
    "Crouch",
    "Look_Up",
    "Look_Down",
    "Look_Left",
    "Look_Right",
    "Strafe_Left",
    "Strafe_Right",
    "Aim_Up",
    "Aim_Down",
    "Weapon_1",
    "Weapon_2",
    "Weapon_3",
    "Weapon_4",
    "Weapon_5",
    "Weapon_6",
    "Weapon_7",
    "Weapon_8",
    "Weapon_9",
    "Weapon_10",
    "Inventory",
    "Inventory_Left",
    "Inventory_Right",
    "Holo_Duke",
    "Jetpack",
    "NightVision",
    "MedKit",
    "TurnAround",
    "SendMessage",
    "Map",
    "Shrink_Screen",
    "Enlarge_Screen",
    "Center_View",
    "Holster_Weapon",
    "Show_Opponents_Weapon",
    "Map_Follow_Mode",
    "See_Coop_View",
    "Mouse_Aiming",
    "Toggle_Crosshair",
    "Steroids",
    "Quick_Kick",
    "Next_Weapon",
    "Previous_Weapon",
    "(none)",
};

char *kbnames[128];

void error_exit(STRPTR errormessage);
void startup(void);
void shutdown(void);

/*****************************************************************************
    request
 *****************************************************************************/
LONG request(STRPTR title, STRPTR bodytext, STRPTR reqtext)
{
    struct EasyStruct req=
    {
	sizeof( struct EasyStruct ),
	0,
	title,
	bodytext,
	reqtext,
    };

    return(EasyRequest( NULL, &req, NULL, NULL ));
}

/*****************************************************************************
    error_exit
 *****************************************************************************/
void error_exit( STRPTR errormessage )
{
    request("ERROR!",errormessage,"OK");

    shutdown();
    exit(20);
}

/*****************************************************************************
    startup
 *****************************************************************************/
void startup( void )
{
    /* open needed libs */
    if(!(DOSBase=(struct DosLibrary *)OpenLibrary("dos.library", 39L)))
	error_exit("Couldn't open DOS V39!");

    if(!(AslBase=(struct Library *)OpenLibrary("asl.library", 38L)))
	error_exit("Couldn't open ASL V38!");

    if(!(IntuitionBase=(struct IntuitionBase *)OpenLibrary("intuition.library", 39L)))
	error_exit("Couldn't open Intuition V39!");

    if(!(GfxBase=(struct GfxBase *)OpenLibrary("graphics.library", 39L)))
	error_exit("Couldn't open Graphics V39!");

    if(!(GadToolsBase=(struct Library *)OpenLibrary("gadtools.library", 37L)))
	error_exit("Couldn't open Gadtools V37!");

    if(!(LowLevelBase=(struct Library *)OpenLibrary("lowlevel.library", 40L)))
	error_exit("Couldn't open LowLevel V40!");

    if((screeninit=SetupScreen()))
	error_exit("Couldn't initialize Screen!");

    /* generate list of key names */
    kbnames[AMIKB_1] = "1";
    kbnames[AMIKB_2] = "2";
    kbnames[AMIKB_3] = "3";
    kbnames[AMIKB_4] = "4";
    kbnames[AMIKB_5] = "5";
    kbnames[AMIKB_6] = "6";
    kbnames[AMIKB_7] = "7";
    kbnames[AMIKB_8] = "8";
    kbnames[AMIKB_9] = "9";
    kbnames[AMIKB_0] = "0";
    kbnames[AMIKB_A] = "A";
    kbnames[AMIKB_B] = "B";
    kbnames[AMIKB_C] = "C";
    kbnames[AMIKB_D] = "D";
    kbnames[AMIKB_E] = "E";
    kbnames[AMIKB_F] = "F";
    kbnames[AMIKB_G] = "G";
    kbnames[AMIKB_H] = "H";
    kbnames[AMIKB_I] = "I";
    kbnames[AMIKB_J] = "J";
    kbnames[AMIKB_K] = "K";
    kbnames[AMIKB_L] = "L";
    kbnames[AMIKB_M] = "M";
    kbnames[AMIKB_N] = "N";
    kbnames[AMIKB_O] = "O";
    kbnames[AMIKB_P] = "P";
    kbnames[AMIKB_Q] = "Q";
    kbnames[AMIKB_R] = "R";
    kbnames[AMIKB_S] = "S";
    kbnames[AMIKB_T] = "T";
    kbnames[AMIKB_U] = "U";
    kbnames[AMIKB_V] = "V";
    kbnames[AMIKB_W] = "W";
    kbnames[AMIKB_X] = "X";
    kbnames[AMIKB_Y] = "Y";
    kbnames[AMIKB_Z] = "Z";
    kbnames[AMIKB_F1] = "F1";
    kbnames[AMIKB_F2] = "F2";
    kbnames[AMIKB_F3] = "F3";
    kbnames[AMIKB_F4] = "F4";
    kbnames[AMIKB_F5] = "F5";
    kbnames[AMIKB_F6] = "F6";
    kbnames[AMIKB_F7] = "F7";
    kbnames[AMIKB_F8] = "F8";
    kbnames[AMIKB_F9] = "F9";
    kbnames[AMIKB_F10] = "F10";
    kbnames[AMIKB_ESCAPE] = "Escape";
    kbnames[AMIKB_BACKSPACE] = "BakSpc";
    kbnames[AMIKB_TAB] = "Tab";
    kbnames[AMIKB_RETURN] = "Enter";
    kbnames[AMIKB_LCTRL] = "LCtrl";
    kbnames[AMIKB_RCTRL] = "RCtrl";
    kbnames[AMIKB_LSHIFT] = "LShift";
    kbnames[AMIKB_RSHIFT] = "RShift";
    kbnames[AMIKB_LALT] = "LAlt";
    kbnames[AMIKB_RALT] = "RAlt";
    kbnames[AMIKB_SPACE] = "Space";
    kbnames[AMIKB_CAPSLOCK] = "CapLck";
    kbnames[AMIKB_HOME] = "Home";
    kbnames[AMIKB_END] = "End";
    kbnames[AMIKB_UP] = "Up";
    kbnames[AMIKB_DOWN] = "Down";
    kbnames[AMIKB_RIGHT] = "Right";
    kbnames[AMIKB_LEFT] = "Left";
    kbnames[AMIKB_INSERT] = "Insert";
    kbnames[AMIKB_DEL] = "Delete";
    kbnames[AMIKB_DELETE] = "Kpad.";
    kbnames[AMIKB_MINUS] = "-";
    kbnames[AMIKB_EQUALS] = "=";
    kbnames[AMIKB_LEFTBRACKET] = "[";
    kbnames[AMIKB_RIGHTBRACKET] = "]";
    kbnames[AMIKB_SEMICOLON] = ";";
    kbnames[AMIKB_QUOTE] = "'";
    kbnames[AMIKB_BACKQUOTE] = "`";
    kbnames[AMIKB_BACKSLASH] = "\\";
    kbnames[AMIKB_COMMA] = ",";
    kbnames[AMIKB_PERIOD] = ".";
    kbnames[AMIKB_SLASH] = "/";
    kbnames[AMIKB_KP_MINUS] = "Kpad-";
    kbnames[AMIKB_KP_PLUS] = "Kpad+";
    kbnames[AMIKB_KP_ENTER] = "KpdEnt";
    kbnames[AMIKB_KP8] = "Kpad8";
    kbnames[AMIKB_KP4] = "Kpad4";
    kbnames[AMIKB_KP5] = "Kpad5";
    kbnames[AMIKB_KP6] = "Kpad6";
    kbnames[AMIKB_KP2] = "Kpad2";
    kbnames[AMIKB_KP_DIVIDE] = "Kpad/";
    kbnames[AMIKB_PRINT] = "PrtScn";
    kbnames[AMIKB_PAGEUP] = "PgUp";
    kbnames[AMIKB_PAGEDOWN] = "PgDn";
    kbnames[AMIKB_SCROLLOCK] = "ScrLock";
    kbnames[AMIKB_NUMLOCK] = "NumLock";
}

/*****************************************************************************
    shutdown
 *****************************************************************************/
void shutdown( void )
{
    if(!screeninit) CloseDownScreen();
    if(DOSBase)
    {
	CloseLibrary((struct Library *)DOSBase);
	DOSBase=NULL;
    }
    if(AslBase)
    {
	CloseLibrary((struct Library *)AslBase);
	AslBase=NULL;
    }
    if(IntuitionBase)
    {
	CloseLibrary((struct Library *)IntuitionBase);
	IntuitionBase=NULL;
    }
    if(GfxBase)
    {
	CloseLibrary((struct Library *)GfxBase);
	GfxBase=NULL;
    }
    if(GadToolsBase)
    {
	CloseLibrary((struct Library *)GadToolsBase);
	GadToolsBase=NULL;
    }
    if(LowLevelBase)
    {
	CloseLibrary((struct Library *)LowLevelBase);
	LowLevelBase=NULL;
    }
}

/*****************************************************************************
    ReadPrefs
 *****************************************************************************/
BOOL ReadPrefs(void)
{
    FILE *fp;
    BOOL ret=FALSE;
    LONG version;

    if((fp=fopen("Duke3d:amigaduke.prefs","rb")))
    {
	fread(&version,4,1,fp);
	if(version==SETUPVERSION)
	{
	    fread(&setupdata,sizeof(setupdata),1,fp);
	    ret=TRUE;
	}
	fclose(fp);
    }
    return(ret);
}

/*****************************************************************************
    WriteDukeCFG
 *****************************************************************************/
BOOL WriteDukeCFG(void)
{
    FILE *fp;
    BOOL ret=FALSE;
    LONG version;
    LONG i;

    if((fp=fopen("Duke3D:amigaduke.prefs","wb")))
    {
	version=SETUPVERSION;
	fwrite(&version,4,1,fp);

	fwrite(&setupdata,sizeof(setupdata),1,fp);

	fclose(fp);
    }

    if((fp=fopen("Duke3D:duke3d.cfg","wb")))
    {
	fprintf(fp,"\n[Setup]\n");
	fprintf(fp,"SetupVersion = \"1.3D\"\n");

	fprintf(fp,"\n[Screen Setup]\n");
	fprintf(fp,"ScreenMode = 1\n");
	fprintf(fp,"ScreenWidth = %ld\n",setupdata.screendata.width);
	fprintf(fp,"ScreenHeight = %ld\n",setupdata.screendata.height);
	fprintf(fp,"Shadows = 1\n");
	fprintf(fp,"Environment = \"\"\n");
	fprintf(fp,"Detail = 1\n");
	fprintf(fp,"Tilt = 1\n");
	fprintf(fp,"Messages = 1\n");
	fprintf(fp,"Out = 0\n");
	fprintf(fp,"ScreenSize = 8\n");
	fprintf(fp,"ScreenGamma = 28\n");
	fprintf(fp,"Password = \"\"\n");

	fprintf(fp,"\n[Sound Setup]\n");
	fprintf(fp,"FXDevice = 0\n");
	fprintf(fp,"MusicDevice = 13\n");
	fprintf(fp,"FXVolume = %ld\n",setupdata.sounddata.sfxvolume);
	fprintf(fp,"MusicVolume = %ld\n",setupdata.sounddata.musicvolume);
	fprintf(fp,"NumVoices = %d\n",setupdata.sounddata.numvoices);
	fprintf(fp,"NumChannels = 2\n");
	fprintf(fp,"NumBits = %d\n",setupdata.sounddata.bits);
	fprintf(fp,"MixRate = %ld\n",setupdata.sounddata.freq);
	fprintf(fp,"MidiPort = 0x0\n");
	fprintf(fp,"BlasterAddress = 0x0\n");
	fprintf(fp,"BlasterType = 3\n");
	fprintf(fp,"BlasterInterrupt = 5\n");
	fprintf(fp,"BlasterDma8 = 1\n");
	fprintf(fp,"BlasterDma16 = 5\n");
	fprintf(fp,"BlasterEmu = 0x0\n");
	fprintf(fp,"ReverseStereo = %d\n",setupdata.sounddata.rvstereo);
	fprintf(fp,"SoundToggle = 1\n");
	fprintf(fp,"VoiceToggle = 1\n");
	fprintf(fp,"AmbienceToggle = 1\n");
	fprintf(fp,"MusicToggle = 1\n");

	fprintf(fp,"\n[KeyDefinitions]\n");
	for(i=0;i<52;i++)
	{
	    fprintf(fp,"%s = ",gamefunctions[i]);
	    if(setupdata.kbdata.primary_kbassigns[i]==-1)
		fprintf(fp,"\"\" ");
	    else
		fprintf(fp,"\"%s\" ",kbnames[setupdata.kbdata.primary_kbassigns[i]]);

	    if(setupdata.kbdata.secondary_kbassigns[i]==-1)
		fprintf(fp,"\"\"\n");
	    else
		fprintf(fp,"\"%s\"\n",kbnames[setupdata.kbdata.secondary_kbassigns[i]]);

	}

	fprintf(fp,"\n[Controls]\n");
	fprintf(fp,"ControllerType = 1\n");
	fprintf(fp,"JoystickPort = 0\n");
	fprintf(fp,"MouseSensitivity = %d\n",(32768*setupdata.mousedata.sensi)/100);
	fprintf(fp,"ExternalFilename = \"EXTERNAL.EXE\"\n");
	fprintf(fp,"EnableRudder = 0\n");
	fprintf(fp,"MouseAiming = %d\n",setupdata.mousedata.aimtype);

	fprintf(fp,"MouseButton0 = ");
	if(setupdata.mousedata.sc_l==-1)
	    fprintf(fp,"\"\"\n");
	else
	    fprintf(fp,"\"%s\"\n",gamefunctions[setupdata.mousedata.sc_l]);

	fprintf(fp,"MouseButtonClicked0 = ");
	if(setupdata.mousedata.dc_l==-1)
	    fprintf(fp,"\"\"\n");
	else
	    fprintf(fp,"\"%s\"\n",gamefunctions[setupdata.mousedata.dc_l]);

	fprintf(fp,"MouseButton1 = ");
	if(setupdata.mousedata.sc_r==-1)
	    fprintf(fp,"\"\"\n");
	else
	    fprintf(fp,"\"%s\"\n",gamefunctions[setupdata.mousedata.sc_r]);

	fprintf(fp,"MouseButtonClicked1 = ");
	if(setupdata.mousedata.dc_r==-1)
	    fprintf(fp,"\"\"\n");
	else
	    fprintf(fp,"\"%s\"\n",gamefunctions[setupdata.mousedata.dc_r]);

	fprintf(fp,"MouseButton2 = ");
	if(setupdata.mousedata.sc_m==-1)
	    fprintf(fp,"\"\"\n");
	else
	    fprintf(fp,"\"%s\"\n",gamefunctions[setupdata.mousedata.sc_m]);

	fprintf(fp,"MouseButtonClicked2 = ");
	if(setupdata.mousedata.dc_m==-1)
	    fprintf(fp,"\"\"\n");
	else
	    fprintf(fp,"\"%s\"\n",gamefunctions[setupdata.mousedata.dc_m]);

	fprintf(fp,"JoystickButton0 = \"Fire\"\n");
	fprintf(fp,"JoystickButtonClicked0 = \"\"\n");
	fprintf(fp,"JoystickButton1 = \"Strafe\"\n");
	fprintf(fp,"JoystickButtonClicked1 = \"\"\n");
	fprintf(fp,"JoystickButton2 = \"Next_Weapon\"\n");
	fprintf(fp,"JoystickButtonClicked2 = \"\"\n");
	fprintf(fp,"JoystickButton3 = \"Prev_Weapon\"\n");
	fprintf(fp,"JoystickButtonClicked3 = \"\"\n");
	fprintf(fp,"JoystickButton4 = \"Jump\"\n");
	fprintf(fp,"JoystickButtonClicked4 = \"\"\n");
	fprintf(fp,"JoystickButton5 = \"Open\"\n");
	fprintf(fp,"JoystickButtonClicked5 = \"\"\n");
	fprintf(fp,"JoystickButton6 = \"Aim_Up\"\n");
	fprintf(fp,"JoystickButtonClicked6 = \"\"\n");
	fprintf(fp,"JoystickButton7 = \"Look_Left\"\n");
	fprintf(fp,"JoystickButtonClicked7 = \"\"\n");
	fprintf(fp,"MouseAnalogAxes0 = \"analog_turning\"\n");
	fprintf(fp,"MouseDigitalAxes0_0 = \"\"\n");
	fprintf(fp,"MouseDigitalAxes0_1 = \"\"\n");
	fprintf(fp,"MouseAnalogScale0 = 0\n");
	fprintf(fp,"MouseAnalogAxes1 = \"analog_strafing\"\n");
	fprintf(fp,"MouseDigitalAxes1_0 = \"\"\n");
	fprintf(fp,"MouseDigitalAxes1_1 = \"\"\n");
	fprintf(fp,"MouseAnalogScale1 = 0\n");
	fprintf(fp,"JoystickAnalogAxes0 = \"analog_turning\"\n");
	fprintf(fp,"JoystickDigitalAxes0_0 = \"\"\n");
	fprintf(fp,"JoystickDigitalAxes0_1 = \"\"\n");
	fprintf(fp,"JoystickAnalogDeadzone0 = 5000\n");
	fprintf(fp,"JoystickAnalogScale0 = 0\n");
	fprintf(fp,"JoystickAnalogAxes1 = \"analog_rolling\"\n");
	fprintf(fp,"JoystickDigitalAxes1_0 = \"\"\n");
	fprintf(fp,"JoystickDigitalAxes1_1 = \"\"\n");
	fprintf(fp,"JoystickAnalogDeadzone1 = 5000\n");
	fprintf(fp,"JoystickAnalogScale1 = 0\n");
	fprintf(fp,"JoystickAnalogAxes2 = \"analog_rolling\"\n");
	fprintf(fp,"JoystickDigitalAxes2_0 = \"\"\n");
	fprintf(fp,"JoystickDigitalAxes2_1 = \"\"\n");
	fprintf(fp,"JoystickAnalogDeadzone2 = 5000\n");
	fprintf(fp,"JoystickAnalogScale2 = 0\n");
	fprintf(fp,"JoystickAnalogAxes3 = \"analog_strafing\"\n");
	fprintf(fp,"JoystickDigitalAxes3_0 = \"\"\n");
	fprintf(fp,"JoystickDigitalAxes3_1 = \"\"\n");
	fprintf(fp,"JoystickAnalogDeadzone3 = 5000\n");
	fprintf(fp,"JoystickAnalogScale3 = 0\n");
	fprintf(fp,"JoystickAnalogAxes4 = \"analog_moving\"\n");
	fprintf(fp,"JoystickDigitalAxes4_0 = \"\"\n");
	fprintf(fp,"JoystickDigitalAxes4_1 = \"\"\n");
	fprintf(fp,"JoystickAnalogDeadzone4 = 5000\n");
	fprintf(fp,"JoystickAnalogScale4 = 0\n");
	fprintf(fp,"JoystickAnalogAxes5 = \"analog_rolling\"\n");
	fprintf(fp,"JoystickDigitalAxes5_0 = \"\"\n");
	fprintf(fp,"JoystickDigitalAxes5_1 = \"\"\n");
	fprintf(fp,"JoystickAnalogDeadzone5 = 5000\n");
	fprintf(fp,"JoystickAnalogScale5 = 0\n");
	fprintf(fp,"GamePadDigitalAxes0_0 = \"Turn_Left\"\n");
	fprintf(fp,"GamePadDigitalAxes0_1 = \"Turn_Right\"\n");
	fprintf(fp,"GamePadDigitalAxes1_0 = \"Move_Forward\"\n");
	fprintf(fp,"GamePadDigitalAxes1_1 = \"Move_Backward\"\n");
	fprintf(fp,"MouseAimingFlipped = %d\n",setupdata.mousedata.flipped);
	fprintf(fp,"GameMouseAiming = 1\n");
	fprintf(fp,"AimingFlag = 1\n");

	fprintf(fp,"\n[Comm Setup]\n");
	fprintf(fp,"ComPort = 2\n");
	fprintf(fp,"IrqNumber = 0\n");
	fprintf(fp,"UartAddress = 65535\n");
	fprintf(fp,"PortSpeed = 9600\n");
	fprintf(fp,"ToneDial = 1\n");
	fprintf(fp,"SocketNumber = 65535\n");
	fprintf(fp,"NumberPlayers = 2\n");
	fprintf(fp,"ModemName = \"\"\n");
	fprintf(fp,"InitString = \"ATZ\"\n");
	fprintf(fp,"HangupString = \"ATH0=0\"\n");
	fprintf(fp,"DialoutString = \"\"\n");
	fprintf(fp,"PlayerName = \"DUKE\"\n");
	fprintf(fp,"RTSName = \"DUKE.RTS\"\n");
	fprintf(fp,"PhoneNumber = \"\"\n");
	fprintf(fp,"ConnectType = 0\n");
	fprintf(fp,"CommbatMacro#0 = \"An inspiration for birth control.\"\n");
	fprintf(fp,"CommbatMacro#1 = \"You're gonna die for that!\"\n");
	fprintf(fp,"CommbatMacro#2 = \"It hurts to be you.\"\n");
	fprintf(fp,"CommbatMacro#3 = \"Lucky Son of a Bitch.\"\n");
	fprintf(fp,"CommbatMacro#4 = \"Hmmm....Payback time.\"\n");
	fprintf(fp,"CommbatMacro#5 = \"You bottom dwelling scum sucker.\"\n");
	fprintf(fp,"CommbatMacro#6 = \"Damn, you're ugly.\"\n");
	fprintf(fp,"CommbatMacro#7 = \"Ha ha ha...Wasted!\"\n");
	fprintf(fp,"CommbatMacro#8 = \"You suck!\"\n");
	fprintf(fp,"CommbatMacro#9 = \"AARRRGHHHHH!!!\"\n");
	fprintf(fp,"PhoneName#0 = \"\"\n");
	fprintf(fp,"PhoneNumber#0 = \"\"\n");
	fprintf(fp,"PhoneName#1 = \"\"\n");
	fprintf(fp,"PhoneNumber#1 = \"\"\n");
	fprintf(fp,"PhoneName#2 = \"\"\n");
	fprintf(fp,"PhoneNumber#2 = \"\"\n");
	fprintf(fp,"PhoneName#3 = \"\"\n");
	fprintf(fp,"PhoneNumber#3 = \"\"\n");
	fprintf(fp,"PhoneName#4 = \"\"\n");
	fprintf(fp,"PhoneNumber#4 = \"\"\n");
	fprintf(fp,"PhoneName#5 = \"\"\n");
	fprintf(fp,"PhoneNumber#5 = \"\"\n");
	fprintf(fp,"PhoneName#6 = \"\"\n");
	fprintf(fp,"PhoneNumber#6 = \"\"\n");
	fprintf(fp,"PhoneName#7 = \"\"\n");
	fprintf(fp,"PhoneNumber#7 = \"\"\n");
	fprintf(fp,"PhoneName#8 = \"\"\n");
	fprintf(fp,"PhoneNumber#8 = \"\"\n");
	fprintf(fp,"PhoneName#9 = \"\"\n");
	fprintf(fp,"PhoneNumber#9 = \"\"\n");

	fprintf(fp,"\n[Misc]\n");
	fprintf(fp,"Executions = 0\n");
	fprintf(fp,"RunMode = 1\n");
	fprintf(fp,"Crosshairs = 1\n");
	fprintf(fp,"WeaponChoice0 = 3\n");
	fprintf(fp,"WeaponChoice1 = 4\n");
	fprintf(fp,"WeaponChoice2 = 5\n");
	fprintf(fp,"WeaponChoice3 = 7\n");
	fprintf(fp,"WeaponChoice4 = 8\n");
	fprintf(fp,"WeaponChoice5 = 6\n");
	fprintf(fp,"WeaponChoice6 = 0\n");
	fprintf(fp,"WeaponChoice7 = 2\n");
	fprintf(fp,"WeaponChoice8 = 9\n");
	fprintf(fp,"WeaponChoice9 = 1\n\n");

	fclose(fp);
	ret=TRUE;
    }

    return(ret);
}

/*****************************************************************************
    main
 *****************************************************************************/
int main(int argc, char *argv[])
{
    ULONG res;
    BOOL done=FALSE;

    startup();

    if(!ReadPrefs())
    {
	memset(&setupdata,0,sizeof(SetupData));
	MakeDefaultSoundData(&setupdata.sounddata);
	MakeDefaultScreenData(&setupdata.screendata);
	MakeDefaultMouseData(&setupdata.mousedata);
	MakeDefaultKeyboardData(&setupdata.kbdata);
    }

    do
    {
	res=MainSetup();

	switch(res)
	{
	    case setup_sound:
		SoundSetup(&setupdata.sounddata);
	    break;

	    case setup_screen:
		ScreenSetup(&setupdata.screendata);
	    break;

	    case setup_mouse:
		MouseSetup(&setupdata.mousedata);
	    break;

	    case setup_kb:
		KeyboardSetup(&setupdata.kbdata);
	    break;

	    case setup_ok:
		WriteDukeCFG();
		done=TRUE;
	    break;

	    case setup_cancel:
		if(request("Warning!","Really quit without saving?","Yes, really quit|No")==1)
		    done=TRUE;
	    break;
	 }
    }while(!done);

    shutdown();

    return 0;
}
