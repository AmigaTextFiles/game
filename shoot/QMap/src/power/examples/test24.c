#include <power.h>

#define WIDTH 320
#define HEIGHT 256

unsigned long framebuffer[WIDTH*HEIGHT];

int main(int argc,char *argv[])
{
	struct PDisplay *display;
	int x,y,count=0;

	PInit(argc,argv);
	display=POpenDisplay(WIDTH,HEIGHT,24);
	while(!PLMBStatus())
	{
		PWaitRaster(120);
		//PTimeShare(0xf00);
		for(y=0;y<HEIGHT;y++)
			for(x=0;x<WIDTH;x++)
				framebuffer[y*WIDTH+x]=(x<<16)+(y<<8)+count;
		count++;
		PBlt24Hidden(display,framebuffer,0,0,WIDTH,HEIGHT);
		PSwapDisplay(display);
		//PTimeShare(0x0f0);
	}
	PCloseDisplay(display);
	PDeinit();
	return 0L;
}
