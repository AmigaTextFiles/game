#include <stdio.h>
#include <exec/types.h>
#include <exec/memory.h>
#include <graphics/gfxbase.h>
#include <graphics/copper.h>
#include <graphics/gfxmacros.h>
#include <hardware/custom.h>
#include <intuition/intuition.h>
#include <exec/ports.h>

struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;
struct ViewPort *MyView;
struct UCopList *MyList;
char confile[]="CON:90/60/460/60/HAMCu by Jonathan Potter";
FILE *con;
 
void main(argc,argv)
int argc;
char **argv;
{
	int c=0,x,y,bc;
	struct MsgPort *port;

	if (argc==0) {
		con=fopen(confile,"w+");
		if (con==NULL) exit(10);
	}
	else con=stdout;
	IntuitionBase=(struct IntuitionBase *) OpenLibrary("intuition.library",0);
	GfxBase=(struct GfxBase *)OpenLibrary("graphics.library",0);
	MyView=GfxBase->ActiView->ViewPort;
	MyList=AllocMem(sizeof(struct UCopList),MEMF_PUBLIC|MEMF_CLEAR);
  bc=(((GetRGB4(MyView->ColorMap,0)>>8)&0xf)*256)+
		(((GetRGB4(MyView->ColorMap,0)>>4)&0xf)*16)+
  	((GetRGB4(MyView->ColorMap,0))&0xf);
	fprintf(con,"\n\n\x9B;0;1mHAM\x9B;33mCu\x9B;0m  by Jonathan Potter\n\n");
	if ((port=FindPort("HAMCu.port"))==NULL) {
		if ((port=CreatePort("HAMCu.port",0))==NULL) {
			fprintf(con,"Can't create message port\n");
			for (x=0;x<30000;x++);
			CloseLibrary(GfxBase);
			CloseLibrary(IntuitionBase);
			if (argc==0) fclose(con);
			exit(10);
		}
		fprintf(con,"Please wait.. installing \x9B;0;1;33mCopper\x9B;0m list..\n");
		for (y=0;y<256;y++) {
			for (x=0;x<224;x=x+14) {
				CWAIT(MyList,y,x);
				CMOVE(MyList,custom.color[0],c);
				++c;
				if (c==0x1000) {
					CWAIT(MyList,y,x+14);
					CMOVE(MyList,custom.color[0],bc);
					goto endlist;
				}
			}
		}
		endlist:
		CEND(MyList);
		MyView->UCopIns=MyList;
		RethinkDisplay();
		if (argc==0) fclose(con);
		CloseLibrary(IntuitionBase);
		CloseLibrary(GfxBase);
		exit(0);
	}
	fprintf(con,"Please wait.. removing \x9B;0;1;33mCopper\x9B;0m list..\n");
	for (x=0;x<30000;x++);
	MyView->UCopIns=NULL;
	RethinkDisplay();
	if (argc==0) fclose(con);
	DeletePort(port);
	CloseLibrary(IntuitionBase);
	CloseLibrary(GfxBase);
}
