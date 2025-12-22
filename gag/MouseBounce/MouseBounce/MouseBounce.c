#include <intuition/intuitionbase.h>
#include <devices/input.h>
#include <hardware/cia.h>

struct IntuitionBase *IntuitionBase;
struct InputEvent MyEvent;
struct IOStdReq *MyRequest;
struct MsgPort *MyPort;
struct Window *Window;
struct IntuiMessage *Msg;

struct NewWindow win={
	30,20,180,10,-1,-1,CLOSEWINDOW,WINDOWCLOSE|WINDOWDRAG|WINDOWDEPTH,
	NULL,NULL,"MouseBounce",NULL,NULL,0,0,0,0,WBENCHSCREEN};

main()
{
	int x=0,y=0,xs=1,ys=1;
	IntuitionBase=(struct IntuitionBase *) OpenLibrary("intuition.library",0);
	Window=(struct Window *) OpenWindow(&win);
	MyPort=CreatePort(0,0);
	MyRequest=CreateStdIO(MyPort);
	OpenDevice("input.device",0,MyRequest,0);
	MoveMouse(1,1);
	for (;;) {
		MM(xs,ys);
		if (Window->WScreen->MouseX==(Window->WScreen->Width-1) ||
			Window->WScreen->MouseX==0) xs=-xs;
		if (Window->WScreen->MouseY==(Window->WScreen->Height-1) ||
			Window->WScreen->MouseY==0) ys=-ys;
		if (MBut()) {
			if (xs<0) --xs; else ++xs;
			ys=(xs/3)+1;
			while (MBut());
			if (xs>20 || xs<-20) Quit();
		}
		if (Msg=GetMsg(Window->UserPort)) {
			ReplyMsg(Msg);
			Quit();
		}
	}
}

MoveMouse(x,y)
int x,y;
{
	MM(-704,-574);
	MM(x,y);
}

MM(x,y)
int x,y;
{
	MyRequest->io_Command=IND_WRITEEVENT;
	MyRequest->io_Flags=0;
	MyRequest->io_Length=sizeof(struct InputEvent);
	MyRequest->io_Data=(APTR)&MyEvent;
	MyEvent.ie_NextEvent=NULL;
	MyEvent.ie_Class=IECLASS_RAWMOUSE;
	MyEvent.ie_TimeStamp.tv_secs=0;
	MyEvent.ie_TimeStamp.tv_micro=0;
	MyEvent.ie_Code=IECODE_NOBUTTON;
	MyEvent.ie_Qualifier=IEQUALIFIER_RELATIVEMOUSE;
	MyEvent.ie_X=x;
	MyEvent.ie_Y=y;
	DoIO(MyRequest);
	return(0);
}

MBut()
{
	return(!((USHORT)ciaa.ciapra >> 6 & 1));
}

Quit()
{
	CloseWindow(Window);
	CloseDevice(MyRequest);
	DeleteStdIO(MyRequest);
	DeletePort(MyPort);
	CloseLibrary(IntuitionBase);
	exit(0);
}
