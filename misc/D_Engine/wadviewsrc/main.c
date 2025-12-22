/* This file contains empty template routines that
 * the IDCMP handler will call uppon. Fill out these
 * routines with your code or use them as a reference
 * to create your program.
 */

#include <exec/types.h>
#include <exec/exec.h>
#include <proto/exec.h>
#include <dos/dos.h>
#include <libraries/gadtools.h>
#include <proto/gadtools.h>
#include <proto/dos.h>
#include <proto/alib.h>
#include <clib/alib_stdio_protos.h>
#include <intuition/intuition.h>
#include "wadview.h"

void fail(UBYTE *s);
BPTR fh;
ULONG lumpc;
struct direntry
{
	ULONG offset;
	ULONG length;
	UBYTE name[8];
}*dirraw;
		
UBYTE *strings;
struct List liste;
UWORD pal[256*3*2+3];
ULONG playpal[] =
{
	0x0000001f,0x170b170f,0x074b4b4b,0xffffff1b,0x1b1b1313,0x130b0b0b,
	0x0707072f,0x371f232b,0x0f171f07,0x0f17004f,0x3b2b4733,0x233f2b1b,
	0xffb7b7f7,0xababf3a3,0xa3eb9797,0xe78f8fdf,0x8787db7b,0x7bd37373,
	0xcb6b6bc7,0x6363bf5b,0x5bbb5757,0xb34f4faf,0x4747a73f,0x3fa33b3b,
	0x9b333397,0x2f2f8f2b,0x2b8b2323,0x831f1f7f,0x1b1b7717,0x17731313,
	0x6b0f0f67,0x0b0b5f07,0x075b0707,0x5307074f,0x00004700,0x00430000,
	0xffebdfff,0xe3d3ffdb,0xc7ffd3bb,0xffcfb3ff,0xc7a7ffbf,0x9bffbb93,
	0xffb383f7,0xab7befa3,0x73e79b6b,0xdf9363d7,0x8b5bcf83,0x53cb7f4f,
	0xbf7b4bb3,0x7347ab6f,0x43a36b3f,0x9b633b8f,0x5f378757,0x337f532f,
	0x774f2b6b,0x47275f43,0x23533f1f,0x4b371b3f,0x2f17332b,0x132b230f,
	0xefefefe7,0xe7e7dfdf,0xdfdbdbdb,0xd3d3d3cb,0xcbcbc7c7,0xc7bfbfbf,
	0xb7b7b7b3,0xb3b3abab,0xaba7a7a7,0x9f9f9f97,0x97979393,0x938b8b8b,
	0x8383837f,0x7f7f7777,0x776f6f6f,0x6b6b6b63,0x63635b5b,0x5b575757,
	0x4f4f4f47,0x47474343,0x433b3b3b,0x3737372f,0x2f2f2727,0x27232323,
	0x77ff6f6f,0xef6767df,0x5f5fcf57,0x5bbf4f53,0xaf474b9f,0x3f439337,
	0x3f832f37,0x732b2f63,0x2327531b,0x1f431717,0x330f1323,0x0b0b1707,
	0xbfa78fb7,0x9f87af97,0x7fa78f77,0x9f876f9b,0x7f6b937b,0x638b735b,
	0x836b577b,0x634f775f,0x4b6f5743,0x67533f5f,0x4b375743,0x33533f2f,
	0x9f83638f,0x7753836b,0x4b775f3f,0x6753335b,0x472b4f3b,0x2343331b,
	0x7b7f636f,0x7357676b,0x4f5b6347,0x53573b47,0x4f333f47,0x2b373f27,
	0xffff73eb,0xdb57d7bb,0x43c39b2f,0xaf7b1f9b,0x5b138743,0x07732b00,
	0xffffffff,0xdbdbffbb,0xbbff9b9b,0xff7b7bff,0x5f5fff3f,0x3fff1f1f,
	0xff0000ef,0x0000e300,0x00d70000,0xcb0000bf,0x0000b300,0x00a70000,
	0x9b00008b,0x00007f00,0x00730000,0x6700005b,0x00004f00,0x00430000,
	0xe7e7ffc7,0xc7ffabab,0xff8f8fff,0x7373ff53,0x53ff3737,0xff1b1bff,
	0x0000ff00,0x00e30000,0xcb0000b3,0x00009b00,0x00830000,0x6b000053,
	0xffffffff,0xebdbffd7,0xbbffc79b,0xffb37bff,0xa35bff8f,0x3bff7f1b,
	0xf37317eb,0x6f0fdf67,0x0fd75f0b,0xcb5707c3,0x4f00b747,0x00af4300,
	0xffffffff,0xffd7ffff,0xb3ffff8f,0xffff6bff,0xff47ffff,0x23ffff00,
	0xa73f009f,0x3700932f,0x00872300,0x4f3b2743,0x2f1b3723,0x132f1b0b,
	0x00005300,0x00470000,0x3b00002f,0x00002300,0x00170000,0x0b000000,
	0xff9f43ff,0xe74bff7b,0xffff00ff,0xcf00cf9f,0x009b6f00,0x6ba76b6b,
};

struct TagItem tags[]={{GTLV_Labels,(ULONG)&liste},{TAG_DONE,0}};

UBYTE *LoadLump(ULONG lumpn);
void InitPal(UBYTE *playpal,UWORD pal[]);
void ShowFloor(UBYTE *buffer);
void ShowWall(UBYTE *buffer);
void ShowMap(ULONG selected);
void PlaySample(ULONG selected);

#define swaplong(a) (a=(a&0xff)<<24|(a&0xff00)<<8|(a&0xff0000)>>8|(a&0xff000000)>>24)

int main(int argc,char *argv[])
{
	ULONG r;
	ULONG i;
	ULONG t1,t2;
	struct Node *node;
	NewList(&liste);
	if(argc!=2)
	{
		if((fh=Open("doom.wad",MODE_OLDFILE))==0)
			fail("Doom.wad not found!!\n");
	}
	else
	{
		if((fh=Open(argv[1],MODE_OLDFILE))==0)
			fail("Doom.wad not found!!\n");
	}
	Read(fh,&r,4);
	if((r&0x00ffffff)!=(ULONG)(('W'<<16)+('A'<<8)+'D'))
		fail("Not a real Doom Wad-File!!\n");
	Read(fh,&lumpc,4);
	swaplong(lumpc);
	Read(fh,&r,4);
	swaplong(r);
	dirraw=AllocVec(lumpc*16,MEMF_CLEAR);
	strings=AllocVec(lumpc*32,MEMF_CLEAR);
	Seek(fh,r,OFFSET_BEGINNING);
	Read(fh,dirraw,lumpc*16);
	for(i=0;i<lumpc;i++)
	{
		t1=swaplong(dirraw[i].offset);
		t2=swaplong(dirraw[i].length);
		node=AllocVec(sizeof(struct Node),MEMF_CLEAR);
		sprintf(&strings[i*32],"%4lu %8lu %6lu %.8s",i,t1,t2,dirraw[i].name);
		node->ln_Name=&strings[i*32];
		AddTail(&liste,node);
	}
	InitPal((UBYTE *)playpal,pal);

	if(SetupScreen()==0)
	{
		if(OpenWadviewWindow()==0)
		{
			GT_SetGadgetAttrsA(WadviewGadgets[GD_lv],WadviewWnd,0,tags);
			do
			{
				WaitPort(WadviewWnd->UserPort);
			}while(HandleWadviewIDCMP());
		}
		CloseWadviewWindow();
	}
	CloseDownScreen();
	for(i=0;i<lumpc;i++)
	{
		node=RemHead(&liste);
		FreeVec(node);
	}
	FreeVec(strings);
	FreeVec(dirraw);
	Close(fh);
	return(0);
}

void fail(UBYTE *s)
{
	if (fh) Close(fh);
	Printf(s);
	exit(0);
}

int lvClicked( void )
{
	/* routine when gadget "Main Listview" is clicked. */
	return(TRUE);
}

int WadviewCloseWindow( void )
{
	/* routine for "IDCMP_CLOSEWINDOW". */
	return(FALSE);
}

LONG selected;
struct TagItem getsel[]={{GTLV_Selected,(ULONG)&selected},{TAG_DONE,0}};
struct TagItem setsel[]={{GTLV_Selected,~0},{TAG_DONE,0}};
struct TagItem makevis[]={{GTLV_MakeVisible,~0},{TAG_DONE,0}};

int WadviewRawKey( void )
{
	/* routine for "IDCMP_RAWKEY". */
	GT_GetGadgetAttrsA(WadviewGadgets[GD_lv],WadviewWnd,0,getsel);
	switch(WadviewMsg.Code)
	{
		case CURSORDOWN:
			if(WadviewMsg.Qualifier&(IEQUALIFIER_RSHIFT|IEQUALIFIER_LSHIFT))
				selected+=10;
			else
				selected++;
			if(selected>=lumpc)
				selected=lumpc;
			setsel[0].ti_Data=selected;
			makevis[0].ti_Data=selected;
			GT_SetGadgetAttrsA(WadviewGadgets[GD_lv],WadviewWnd,0,setsel);
			GT_SetGadgetAttrsA(WadviewGadgets[GD_lv],WadviewWnd,0,makevis);
			break;

		case CURSORUP:
			if(WadviewMsg.Qualifier&(IEQUALIFIER_RSHIFT|IEQUALIFIER_LSHIFT))
				selected-=10;
			else
				selected--;
			if(selected<0)
				selected=0;
			setsel[0].ti_Data=selected;
			makevis[0].ti_Data=selected;
			GT_SetGadgetAttrsA(WadviewGadgets[GD_lv],WadviewWnd,0,setsel);
			GT_SetGadgetAttrsA(WadviewGadgets[GD_lv],WadviewWnd,0,makevis);
			break;
	}			

	return(TRUE);
}

int WadviewVanillaKey( void )
{
	UBYTE *buffer;
	BPTR fht;
	/* routine for "IDCMP_VANILLAKEY". */
	/*Printf("Vanillakey arrived!!!\n");*/
	GT_GetGadgetAttrsA(WadviewGadgets[GD_lv],WadviewWnd,0,getsel);

	switch (WadviewMsg.Code)
	{
		case 'e':
			buffer=LoadLump(selected);
			fht=Open("ram:test",MODE_NEWFILE);
			Write(fht,buffer,dirraw[selected].length);
			Close(fht);
			FreeVec(buffer);
			break;

		case 13:
			if((dirraw[selected].name[0]=='E')&&
			   (dirraw[selected].name[2]=='M'))
			{
				ShowMap(selected);
				break;
			}
			if((dirraw[selected].name[0]=='M')&&
			   (dirraw[selected].name[1]=='A')&&
			   (dirraw[selected].name[2]=='P'))
			{
				ShowMap(selected);
				break;
			}
			if((dirraw[selected].name[0]=='D')&&
			   (dirraw[selected].name[1]=='S'))
			{
				PlaySample(selected);
				break;
			}
			buffer=LoadLump(selected);
			if (dirraw[selected].length==4096)
				ShowFloor(buffer);
			else
				ShowWall(buffer);
			FreeVec(buffer);
			break;
	}
	/*Printf("Selected:%ld VanillaKey:%ld\n",selected,WadviewMsg.Code);*/
	return(TRUE);
}

UBYTE *LoadLump(ULONG lumpn)
{
	UBYTE *b;
	b=AllocVec(dirraw[lumpn].length,MEMF_CLEAR);
	Seek(fh,dirraw[lumpn].offset,OFFSET_BEGINNING);
	Read(fh,b,dirraw[lumpn].length);
	return(b);
}
