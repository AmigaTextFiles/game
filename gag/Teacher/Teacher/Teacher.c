#include <intuition/intuitionbase.h>
#include <graphics/gfxbase.h>
#include <devices/trackdisk.h>
#include <stdio.h>

struct NewWindow TinyWindow={
	0,0,1,1,-1,-1,NULL,NULL,NULL,NULL,
	"System Request",NULL,NULL,0,0,0,0,WBENCHSCREEN};

struct NewScreen MyScreen={
	0,0,320,0,5,NULL,CUSTOMSCREEN,NULL,NULL,NULL,NULL};

struct NewWindow MyWindow={
	0,0,320,0,-1,-1,NULL,BORDERLESS|ACTIVATE,NULL,NULL,
	NULL,NULL,0,0,0,0,CUSTOMSCREEN};

struct IntuiText guru3={
	0,1,JAM2,15,25,NULL,"Select CANCEL to reset/debug",NULL};
struct IntuiText guru2={
	0,1,JAM2,23,15,NULL,"Finish ALL disk activity",&guru3};
struct IntuiText guru1={
	0,1,JAM2,15,5,NULL,"Software error - task held",&guru2};

struct IntuiText retry={
	0,1,JAM2,7,3,NULL,"Retry",NULL};
struct IntuiText cancel={
	0,1,JAM2,7,3,NULL,"Cancel",NULL};

UBYTE guru[]=
	"\x00\x00\xf           Software Failure.      Press left mouse button to continue.\x00\xff\x00\x00\x20                        Guru Meditation #00000004.00F8F360\x00";

USHORT empty[]={0,0};
BYTE diskbuffer[1024];

struct Window *Window;
struct Screen *Screen, *scr;
struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;
struct ViewPort *vp;
struct Port *diskport;
struct IOStdReq *diskreq;
char confile[]="CON:90/60/460/60/Teacher (Guru!) by Jonathan Potter";
FILE *con;

main(argc,argv)
int argc;
char **argv;
{
	int a,error,x;
	IntuitionBase=OpenLibrary("intuition.library",0);
	GfxBase=OpenLibrary("graphics.library",0);
	Window=OpenWindow(&TinyWindow);
	scr=Window->WScreen;
	MyScreen.Height=scr->Height;
	MyWindow.Height=scr->Height;
	loop:
	error=AutoRequest(Window,&guru1,&retry,&cancel,NULL,NULL,320,72);
	if (error==TRUE) goto loop;
	CloseWindow(Window);
	(VOID) DisplayAlert(RECOVERY_ALERT,guru,42);
	Screen=OpenScreen(&MyScreen);
	MyWindow.Screen=Screen;
	Window=OpenWindow(&MyWindow);
	SetPointer(Window,&empty,0,0,0,0);
	vp=&(Screen->ViewPort);
	SetRGB4(vp,0,0x7,0x7,0x7);
	for (a=0;a<100000;a++);
	SetRGB4(vp,0,0xb,0xb,0xb);
	for (a=0;a<100000;a++);
	SetRGB4(vp,0,0xf,0xf,0xf);
	for (a=0;a<100000;a++);
	diskport=CreatePort(0,0);
	diskreq=CreateStdIO(diskport);
	MoveBlocks(0,2);
	for (a=1;a<100000;a++);
	MoveBlocks(0,20);
	for (a=1;a<3;a++)
		if (DriveThere(a)) MoveBlocks(a,8);
	MoveBlocks(0,10);
	CloseWindow(Window);
	CloseScreen(Screen);
	DeletePort(diskport);
	DeleteStdIO(diskreq);
	CloseLibrary(IntuitionBase);
	CloseLibrary(GfxBase);
	if (argc==0) con=fopen(confile,"w");
	else con=stdout;
	fprintf(con,"\x9B;3mHa Ha Ha Ha Ha!\x9B;0;1m Had you worried, eh?\x9B;0m\n");
	if (argc==0) {
		for (x=0;x<500000;x++);
		fclose(con);
	}
	exit(0);
}

MoveBlocks(drive,h)
int drive,h;
{
	int l;
	OpenDevice("trackdisk.device",drive,diskreq,0);
	for (l=0;l<h;l++) {
		diskreq->io_Command=TD_SEEK;
		diskreq->io_Offset=l*2048;
		DoIO(diskreq);
		diskreq->io_Command=CMD_READ;
		diskreq->io_Length=1024;
		diskreq->io_Data=(APTR)diskbuffer;
		diskreq->io_Offset=l*2048;
		DoIO(diskreq);
	}
	diskreq->io_Length=0;
	diskreq->io_Command=TD_MOTOR;
	DoIO(diskreq);
	CloseDevice(diskreq);
}

DriveThere(drive)
int drive;
{
	if ((OpenDevice("trackdisk.device",drive,diskreq,0))!=0) return(FALSE);
	CloseDevice(diskreq);
	return(TRUE);
}
