#include "syscall.h"
#include "pga.h"

/******************************************************************************/
#ifndef NULL
#define NULL 0
#endif


//#define PGA_CHANNELS 1
//#define PGA_SAMPLES 256*4
#define PGA_CHANNELS 1	//3
#define PGA_SAMPLES 512	//256
#define MAXVOLUME 0x8000

static int pga_ready=0;
static int pga_handle[PGA_CHANNELS];

static short pga_sndbuf[PGA_CHANNELS][2][PGA_SAMPLES*2];
static int pga_volumes[PGA_CHANNELS][2];

static void (*pga_channel_callback[PGA_CHANNELS])(void *buf, unsigned int reqn);

static int pga_threadhandle[PGA_CHANNELS];


volatile int pga_terminate=0;

int pgaVolume(int ch,int lvol,int rvol)
{
	pga_volumes[ch][0] = lvol;
	pga_volumes[ch][1] = rvol;
}

int pgaOutBlocking(unsigned int channel,unsigned int vol1,unsigned int vol2,void *buf);

static int pga_channel_thread(int args, void *argp)
{
	volatile int bufidx=0;
	int channel=*(int *)argp;

	while (pga_terminate==0) {
		void *bufptr=&pga_sndbuf[channel][bufidx];
		void (*callback)(void *buf, unsigned reqn);
		callback=pga_channel_callback[channel];
		if (callback) {
			callback(bufptr,PGA_SAMPLES);
		} else {
			unsigned int *ptr=bufptr;
			int i;
			for (i=0; i<PGA_SAMPLES; ++i) *(ptr++)=0;
		}
		pgaOutBlocking(channel,pga_volumes[channel][0],pga_volumes[channel][1],bufptr);
		bufidx=(bufidx?0:1);
	}
	sceKernelExitThread(0);
	return 0;
}

/*
void pga_channel_thread_callback(int channel, void *buf, unsigned int reqn)
{
	void (*callback)(void *buf, unsigned int reqn);
	callback=pga_channel_callback[channel];
}
*/

void pgaSetChannelCallback(int channel, void (*callback)(void*,unsigned))
{
	pga_channel_callback[channel]=callback;
}



/******************************************************************************/



int pgaInit()
{
	int i,ret;
	int failed=0;
	char str[32];

	pga_terminate=0;
	pga_ready=0;

	for (i=0; i<PGA_CHANNELS; i++) {
		pga_handle[i]=-1;
		pga_threadhandle[i]=-1;
		pga_channel_callback[i]=0;
		pga_volumes[i][0]=MAXVOLUME;
		pga_volumes[i][1]=MAXVOLUME;
	}
	for (i=0; i<PGA_CHANNELS; i++) {
		if ((pga_handle[i]=sceAudio_3(-1,PGA_SAMPLES,0))<0) failed=1;
	}
	if (failed) {
		for (i=0; i<PGA_CHANNELS; i++) {
			if (pga_handle[i]!=-1) sceAudio_4(pga_handle[i]);
			pga_handle[i]=-1;
		}
		return -1;
	}
	pga_ready=1;

	strcpy(str,"pgasnd0");
	for (i=0; i<PGA_CHANNELS; i++) {
		str[6]='0'+i;
		pga_threadhandle[i]=sceKernelCreateThread(str,(pg_threadfunc_t)&pga_channel_thread,0x12,0x10000,0,NULL);
		if (pga_threadhandle[i]<0) {
			pga_threadhandle[i]=-1;
			failed=1;
			break;
		}
		ret=sceKernelStartThread(pga_threadhandle[i],sizeof(i),&i);
		if (ret!=0) {
			failed=1;
			break;
		}
	}
	if (failed) {
		pga_terminate=1;
		for (i=0; i<PGA_CHANNELS; i++) {
			if (pga_threadhandle[i]!=-1) {
				sceKernelWaitThreadEnd(pga_threadhandle[i],NULL);
				sceKernelDeleteThread(pga_threadhandle[i]);
			}
			pga_threadhandle[i]=-1;
		}
		pga_ready=0;
		return -1;
	}
	return 0;
}


void pgaTermPre(void)
{
	pga_ready=0;
	pga_terminate=1;
}


void pgaTerm(void)
{
	int i;
	pga_ready=0;
	pga_terminate=1;

	for (i=0; i<PGA_CHANNELS; i++) {
		if (pga_threadhandle[i]!=-1) {
			sceKernelWaitThreadEnd(pga_threadhandle[i],NULL);
			sceKernelDeleteThread(pga_threadhandle[i]);
		}
		pga_threadhandle[i]=-1;
	}

	for (i=0; i<PGA_CHANNELS; i++) {
		if (pga_handle[i]!=-1) {
			sceAudio_4(pga_handle[i]);
			pga_handle[i]!=-1;
		}
	}
}



int pgaOutBlocking(unsigned int channel,unsigned int vol1,unsigned int vol2,void *buf)
{
	if (!pga_ready) return -1;
	if (channel>=PGA_CHANNELS) return -1;
	if (vol1>MAXVOLUME) vol1=MAXVOLUME;
	if (vol2>MAXVOLUME) vol2=MAXVOLUME;
	return sceAudio_2(pga_handle[channel],vol1,vol2,buf);
}
