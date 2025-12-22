// A soundblaster interface. No bugs?

#include "sblaster.h"
#include "pga.h"

// The interface
static char* soundbuff;
static int inited;

void * SB_init(int port, int dma, int hdma, int irq, int buffersize)
{
	soundbuff = buffersize;
	return soundbuff;
}

static void callback(void *buf,unsigned len)
{
//	printf("callback(%p,%p,%d)\n",userdata,stream,len);
	update_sample(buf,len*2*2); //stereo * 16bit
}

int SB_playstart(int stereo, int bits, int samplerate)
{
	if (inited) return 0;

	pgaInit();
	pgaSetChannelCallback(0,callback);
	inited = 1;
	return 1;
}
int SB_getpos()
{
	return 0;
}
void SB_playstop()
{
	if (!inited) return;

	pgaTerm();
	inited = 0;
}

void SB_exit()
{
}

void SB_hook(void (*func)())
{
}

void getSBvars(int *a, int *i, int *d, int *h, int *type)
{
}

/*
char SB_getvolume(char dev)
{
}
*/

char SB_setvolume(char dev, char volume)
{
	switch(dev) {
	case SB_VOICEVOL:
		/* 0-15 to 0-0x8000 */
		pgaVolume(0,volume<<11,volume<<11);
		break;
	}
}


