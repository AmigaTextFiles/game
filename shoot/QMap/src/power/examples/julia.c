#include <power.h>

#define WIDTH 320
#define HEIGHT 200

void julia(char *);

unsigned char framebuffer[WIDTH*HEIGHT];

int main(int argc,char *argv[])
{
	unsigned char *pal;
	struct PDisplay *display;
	int count=0;

	PInit(argc,argv);
	pal=PLoadFile("julia.pal",0);
	display=POpenDisplay(WIDTH,HEIGHT,8);
	PSetPalette(display,&pal[0x14]);
	while((!PLMBStatus())&&(count++<400))
	{
		//PWaitRaster(70);
		//PTimeShare(0xf00);
		julia(framebuffer);
		//PTimeShare(0x0f0);
		PBltChkHidden(display,framebuffer,0,0,WIDTH,HEIGHT);
		PSwapDisplay(display);
	}
	PFreeMem(pal);
	PCloseDisplay(display);
	PDeinit();
	return 0;
}

// gcc: 68030/68881 25 MHz 27 sec. 256x256
// gcc: 68060 50Mhz 1.5 sec ??? 256x256

#define W WIDTH
#define H HEIGHT
#define MAXITER 50
#define L -2.0
#define R 2.0
#define U  -1.2
#define O  1.2

double juliax=-1.5;
double juliay=0.0;

void julia(char *ptr)
{
	int x,y;
	double dx,dy,r,i,cr,ci,r2,is,rs;
	int it;
	cr=juliax;
	juliax+=0.005;
	ci=juliay;
	juliay+=0.003;
	dx=(R-L)/W;
	dy=(U-O)/H;
	is=O;
	for(y=0;y<H;y++)
	{
		rs=L;
		for(x=0;x<W;x++)
		{
			it=MAXITER;
			//cr=rs;
			//ci=is;
			//r=0.0;
			//i=0.0;
			r=rs;
			i=is;
			while(((r*r+i*i)<4)&&it)
			{
				r2=r*r-i*i+cr;
				i=2*r*i+ci;
				r=r2;
				it--;
			}
			*ptr++=it;
			rs+=dx;
		}
		is+=dy;
	}
}
