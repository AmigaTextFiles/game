#include <math.h>
#include <power.h>

#define WIDTH 320
#define HEIGHT 256

#define M_PI PI

int sintab[450];
unsigned char framebuffer[WIDTH*HEIGHT];

int main(int argc,char *argv[])
{
        unsigned int x,y,i;
        unsigned int tx,ty,tx2,ty2;
        int aktsin,aktcos;
        int alpha=0;
        unsigned char *pic;
        unsigned char *pal;
        struct PDisplay *display;

        PInit(argc,argv);
        for(i=0;i<450;i++)
                sintab[i]=sin(i*2*M_PI/360)*32768;
        pic=PLoadFile("cat2.bpl",0);
        pal=PLoadFile("cat.pal",0);
        display=POpenDisplay(WIDTH,HEIGHT,8);
        PSetPalette(display,&pal[0x14]);
        while(!PLMBStatus())
        {
                PWaitRaster2(150);
                PTimeShare(0xf00);
                aktsin=2*sintab[alpha%360];
                aktcos=2*sintab[alpha%360+90];
                alpha++;
                tx2=-100*sintab[(5*alpha+23)%360];
                ty2=-100*sintab[(7*alpha+71)%360+90];
                for(y=0;y<HEIGHT;y++)
                {
                        tx=tx2;
                        ty=ty2;
                        for(x=0;x<WIDTH;x++)
                        {
                                framebuffer[y*WIDTH+x]=pic[((ty>>9)&(0x7f<<7))+((tx>>16)&0x7f)];
                                tx+=aktsin;
                                ty+=aktcos;
                        }
                        tx2+=aktcos;
                        ty2-=aktsin;
                        aktsin-=1<<8;
                        aktcos+=1<<8;
                }
                PTimeShare(0x0f0);
                PBltChkHidden(display,framebuffer,0,0,WIDTH,HEIGHT);
                PSwapDisplay(display);
                //PTimeShare(0x0f0);
        }
        PFreeMem(pic);
        PFreeMem(pal);
        PCloseDisplay(display);
        PDeinit();
        return 0L;
}
