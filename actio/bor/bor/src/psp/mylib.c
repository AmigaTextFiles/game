#include "syscall.h"

#include "mylib.h"

unsigned short *vramtop = (void*)0x44000000;

void g_init(void)
{
	sceDisplaySetMode(0,SCREEN_WIDTH,SCREEN_HEIGHT);
	sceDisplaySetFrameBuf((char*)vramtop-0x40000000,SCREEN_PITCH,1,1);
	sceCtrlInit(0);
	sceCtrlSetAnalogMode(1);
}

void g_flip(void)
{
	sceDisplaySetFrameBuf((char*)vramtop-0x40000000,SCREEN_PITCH,1,1);
	vramtop = (unsigned short*)((int)vramtop ^ SCREEN_PITCH*SCREEN_HEIGHT*2);
}

unsigned short* g_vramaddr(int x,int y)
{
	return vramtop + x + y*SCREEN_PITCH;
}

void g_clear(int color)
{
	int i;
	unsigned int *dst = (unsigned int*)vramtop;
	color = color | (color<<16);

	for(i=0;i<SCREEN_PITCH*SCREEN_HEIGHT/8;i++) {
		dst[0] = color;
		dst[1] = color;
		dst[2] = color;
		dst[3] = color;
		dst+=4;
	}
}

void g_fillrect(int x0,int y0,int width,int height,int color)
{
	int x,y;
	unsigned short *dst = g_vramaddr(x0,y0);

	if (((int)dst&3)==0 && (width&1)==0) {
		color = color | (color<<16);
		for(y=0;y<height;y++) {
			for(x=0;x<width/2;x++)
				((long*)dst)[x] = color;
			dst += SCREEN_PITCH;
		}
	} else {
			for(y=0;y<height;y++) {
			for(x=0;x<width;x++)
				dst[x] = color;
			dst += SCREEN_PITCH;
		}
	}
}

void g_bitblt(int x0,int y0,int width,int height,void *data)
{
	int x,y;
	int *dst = (int*)g_vramaddr(x0,y0);
	int *src = data;

		for(y=0;y<height;y++) {
			for(x=0;x<width/8;x++) {
				dst[0] = src[0];
				dst[1] = src[1];
				dst[2] = src[2];
				dst[3] = src[3];
				src+=4;
				dst+=4;
			}
			dst += SCREEN_PITCH-width;
		}
}

int g_getpad(void)
{
	ctrl_data_t paddata;
	sceCtrlRead(&paddata,1);
	return paddata.buttons;
}

int g_gettick(void)
{
	ctrl_data_t paddata;
	sceCtrlRead(&paddata,1);
	return paddata.frame*1000/60;
}

int pgMain(int argc,char *argv)
{
	char path[256];
	strcpy(path,argv);
	char *p = strrchr(path,'/');
	if (p) {
		*p = 0;
		chdir(path);
	}
	g_init();
#if 0
	int tm = sceKernelLibcTime(0);
	while(tm==sceKernelLibcTime(0)) ;
	int clk,frame;
	ctrl_data_t paddata;

	tm = sceKernelLibcTime(0);
	clk = sceKernelLibcClock();
	sceCtrlRead(&paddata,1);
	frame = paddata.frame;

	while(tm==sceKernelLibcTime(0)) ;

	sceCtrlRead(&paddata,1);
	int clkdiff = sceKernelLibcClock()-clk;
	int framediff = paddata.frame-frame;

	printf("clock=%d\n",clk);
	printf("frame=%d\n",frame);


	printf("clock=%d\n",clkdiff);
	printf("frame=%d\n",framediff);

	tm = sceKernelLibcTime(0);
	clk = sceKernelLibcClock();
	sceCtrlRead(&paddata,1);
	frame = paddata.frame;

	while(tm==sceKernelLibcTime(0)) ;

	sceCtrlRead(&paddata,1);
	clkdiff = sceKernelLibcClock()-clk;
	framediff = paddata.frame-frame;

	printf("clock=%d\n",clkdiff);
	printf("frame=%d\n",framediff);

	tm = sceKernelLibcTime(0);
	clk = sceKernelLibcClock();
	sceCtrlRead(&paddata,1);
	frame = paddata.frame;

	while(tm==sceKernelLibcTime(0)) ;

	sceCtrlRead(&paddata,1);
	clkdiff = sceKernelLibcClock()-clk;
	framediff = paddata.frame-frame;

	printf("clock=%d\n",clkdiff);
	printf("frame=%d\n",framediff);

	_exit(0);	
#endif
	_exit(main(1,&argv));
}
