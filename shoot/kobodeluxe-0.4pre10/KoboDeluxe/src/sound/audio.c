/*(GPL)
---------------------------------------------------------------------------
	audio.c - Public Audio Engine Interface
---------------------------------------------------------------------------
 * Written for SGI DMedia API by Masanao Izumo <mo@goice.co.jp>
 * Mostly rewritten by David Olofson <do@reologica.se>, 2001
 *
 * Copyright (C) 19??, Masanao Izumo
 * Copyright (C) 2001-2003, David Olofson
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2.1 of the License, or (at your
 * option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include "a_globals.h"
#include "config.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#ifdef HAVE_OSS
#include <pthread.h>
#include <unistd.h>
#include <sys/ioctl.h>
#ifdef OSS_USE_SOUNDCARD_H
#include <soundcard.h>
#else
#include <sys/soundcard.h>
#endif
#include "audiodev.h"
#endif

#include "SDL.h"
#include "SDL_audio.h"

#include "a_struct.h"
#include "a_commands.h"
#include "a_control.h"
#include "a_pitch.h"
#include "a_filters.h"
#include "a_limiter.h"
#include "a_midicon.h"
#include "a_midi.h"
#include "a_midifile.h"
#include "a_sequencer.h"
#include "a_agw.h"
#include "a_events.h"


/*----------------------------------------------------------
	Engine stuff
----------------------------------------------------------*/

#ifdef HAVE_OSS
static audiodev_t adev;
static pthread_t engine_thread;
#endif

static int using_oss = 0;
static int using_midi = 0;
static int using_polling = 0;

int _audio_pause = 1;
static int master_vol = DEFAULT_VOL;
static int master_rvb = DEFAULT_RVB;

/*
 * Note that a_settings.buffersize is in stereo samples!
 */
static int *mixbuf = NULL;
static int *busbufs[AUDIO_MAX_BUSSES];

limiter_t limiter;

/* Silent buffer for plugins */
int *audio_silent_buffer = NULL;

#if defined(AUDIO_LOCKING) && defined(HAVE_OSS)
static pthread_mutex_t _audio_mutex = PTHREAD_MUTEX_INITIALIZER;
static int _audio_mutex_locked = 0;
#endif


/*----------------------------------------------------------
	Engine code
----------------------------------------------------------*/

static int waiting = 0;

/*
 * This is where buffered asynchronous commands are
 * processed. Some of them turn directly into timestamped
 * events right here.
 */
static void _run_commands(int dt)
{
	DBG2(printf("---- buffer ----\n"));

/*	if(waiting > dt)
	{
		waiting -= dt;
		return;
	}
	else
	{
		dt -= waiting;
		waiting = 0;
	}
*/
	while(sfifo_used(&commands) >= sizeof(command_t))
	{
		command_t cmd;
		if(sfifo_read(&commands, &cmd, (unsigned)sizeof(cmd)) < 0)
		{
			fprintf(stderr, "audio.c: Engine failure!\n");
			_audio_running = 0;
			return;
		}
		switch(cmd.action)
		{
		  case eCMD_STOP:
			DBG2(printf("Got eCMD_STOP.\n"));
			(void)ce_stop(channeltab + cmd.cid, 0, cmd.tag, 32768);
			break;
		  case eCMD_STOP_ALL:
			DBG2(printf("Got eCMD_STOP_ALL.\n"));
			channel_stop_all();
			break;
		  case eCMD_PLAY:
			DBG2(printf("Got eCMD_PLAY.\n"));
			(void)ce_start(channeltab + cmd.cid, 0,
					cmd.tag, cmd.arg1, cmd.arg2);
			break;
		  case eCMD_CCONTROL:
			DBG2(printf("Got eCMD_CCONTROL.\n"));
			(void)ce_control(channeltab + cmd.cid, 0,
					cmd.tag, cmd.index, cmd.arg1);
			break;
		  case eCMD_GCONTROL:
			DBG2(printf("Got eCMD_GCONTROL.\n"));
			acc_group_set((unsigned)cmd.cid, cmd.index, cmd.arg1);
			break;
		  case eCMD_MCONTROL:
			DBG2(printf("Got eCMD_MCONTROL.\n"));
			bus_ctl_set((unsigned)cmd.cid, (unsigned)cmd.arg1,
					cmd.index, cmd.arg2);
			break;
		  case eCMD_WAIT:
			DBG2(printf("Got eCMD_WAIT.\n"));
/*			waiting = cmd.arg1;
			if(waiting > dt)
			{
				waiting -= dt;
				return;
			}
			else
			{
				dt -= waiting;
				waiting = 0;
				break;
			}
*/
		}
	}
}


#define	CLIP_MIN	-32700
#define	CLIP_MAX	32700

#if 0
/*
 * Convert with saturation
 */
static void _clip(Sint32 *inbuf, Sint16 *outbuf, unsigned frames)
{
	unsigned i;
	frames <<= 1;
	for(i = 0; i < frames; i+=2)
	{
		int l = inbuf[i];
		int r = inbuf[i+1];
		if(l < CLIP_MIN)
			outbuf[i] = CLIP_MIN;
		else if(l > CLIP_MAX)
			outbuf[i] = CLIP_MAX;
		else
			outbuf[i] = l;
		if(r < CLIP_MIN)
			outbuf[i+1] = CLIP_MIN;
		else if(r > CLIP_MAX)
			outbuf[i+1] = CLIP_MAX;
		else
			outbuf[i+1] = r;
	}
}
#endif

/*
 * Convert to Sint16; no saturation
 */
static void _s32tos16(Sint32 *inbuf, Sint16 *outbuf, unsigned frames)
{
	unsigned i;
	frames <<= 1;
	for(i = 0; i < frames; i+=2)
	{
		int l = inbuf[i];
		int r = inbuf[i+1];
		outbuf[i] = (Sint16)l;
		outbuf[i+1] = (Sint16)r;
	}
}


#ifdef DEBUG
static void _grab(Sint16 *buf, unsigned frames)
{
	static int locktime = 0;
	static int trig = 0;
	unsigned i = 0;
	if(!trig)
		for(i = 0; i < frames-1; ++i)
		{
			int c1 = buf[i<<1] + buf[(i<<1)+1];
			int c2 = buf[(i<<1)+2] + buf[(i<<1)+3];
			if((c1 > 0) && (c2 < 0))
			{
				trig = 1;
				break;
			}
		}
	if(locktime - SDL_GetTicks() > 200)
		trig = 1;
	if(!trig)
		return;
	for( ; i < frames; ++i)
	{
		oscbufl[oscpos] = buf[i<<1];
		oscbufr[oscpos] = buf[(i<<1)+1];
		++oscpos;
		if(oscpos >= oscframes)
		{
			oscpos = 0;
			trig = 0;
			locktime = SDL_GetTicks();
			break;
		}
	}
}
#endif

#ifdef PROFILE_AUDIO
# define DBGT(x)	x
/*
 * Replace with something else on non-x86 archs, or
 * compilers that don't understand this. Replacement
 * must have better resolution than 1 ms to be useful.
 * Unit is not important as calculations are relative.
 */
# if defined(__GNUC__) && defined(i386)
inline int timestamp(void)
{
	unsigned long long int x;
	__asm__ volatile (".byte 0x0f, 0x31" : "=A" (x));
	return x >> 8;
}
# else
#  ifdef HAVE_GETTIMEOFDAY
#	if TIME_WITH_SYS_TIME
#	 include <sys/time.h>
#	 include <time.h>
#	else
#	 if HAVE_SYS_TIME_H
#	  include <sys/time.h>
#	 else
#	  include <time.h>
#	 endif
#	endif
inline int timestamp(void)
{
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return tv.tv_sec * 1000000 + tv.tv_usec;
}
#  else
inline int timestamp(void)
{
	return SDL_GetTicks();
}
#  endif
# endif
#else
# define DBGT(x)
#endif

#ifdef PROFILE_AUDIO
int audio_cpu_ticks = 333;
float audio_cpu_total = 0.0;
float audio_cpu_function[AUDIO_CPU_FUNCTIONS] = { 0,0,0,0,0,0,0,0,0,0 };
char audio_cpu_funcname[AUDIO_CPU_FUNCTIONS][20] = {
	"Async. Commands",
	"MIDI Input",
	"Sequencer",
	"MIDI -> Control",
	"Channel/Patch Proc.",
	"Voice Mixer",
	"Clearing Master Buf",
	"Bus & Mixdown",
	"Limiter Effect",
	"32 -> 16 bit Conv"
};
#endif


/*
 * Engine callback for SDL_audio and OSS
 */
static void _audio_callback(void *ud, Uint8 *stream, int len)
{
#ifdef PROFILE_AUDIO
	int i;
	int t[AUDIO_CPU_FUNCTIONS+2];
	static int avgt[AUDIO_CPU_FUNCTIONS+1];
	static int avgtotal;
	static int lastt = 0;
	static int last_out = 0;
	int adjust;
	int ticks;
#define	TS(x)	t[x] = timestamp();
#else
#define	TS(x)
#endif
	unsigned frames, bufs;
	Sint16 *outbuf = (Sint16 *)stream;
	float dbt;

	if(_audio_pause)
	{
		memset(stream, 0, (unsigned)len);
		return;
	}

	bufs = len / (a_settings.buffersize * sizeof(Sint16) * 2);
	frames = len / sizeof(Sint16) / 2 / bufs;
	dbt = ceil((float)frames / (float)a_settings.samplerate);
	while(bufs--)
	{
	  TS(0);
	  TS(1);
		aev_client("_run_commands()");
		_run_commands(dbt);
	  TS(2);
		aev_client("midi_process()");
		if(using_midi)
			midi_process();
	  TS(3);
		/* This belongs in the MIDI patch plugin. */
		aev_client("sequencer_process()");
		sequencer_process(frames);
	  TS(4);
		aev_client("midicon_process()");
		midicon_process(frames);
	  TS(5);
		aev_client("channel_process_all()");
		channel_process_all(frames);
	  TS(6);
		aev_client("voice_process_all()");
		voice_process_all(busbufs, frames);
	  TS(7);
		memset(mixbuf, 0, frames * sizeof(int) * 2);
	  TS(8);
		aev_client("bus_process_all()");
		bus_process_all(busbufs, mixbuf, frames);
	  TS(9);
		lims_process(&limiter, mixbuf, mixbuf, frames);
	  TS(10);
		_s32tos16(mixbuf, outbuf, frames);
	  TS(11);
#ifdef DEBUG
		_grab(outbuf, frames);
#endif
#ifdef PROFILE_AUDIO
		adjust = t[1] - t[0];

		avgt[0] += t[1] - lastt;
		lastt = t[1];
		if(!avgt[0])
			avgt[0] = 1;

		for(i = 1; i <= AUDIO_CPU_FUNCTIONS; ++i)
		{
			int tt = t[i+1] - t[i] - adjust;
			if(tt > 0)
			{
				avgt[i] += tt;
				avgtotal += tt;
			}
		}
		ticks = SDL_GetTicks();
		if((ticks-last_out) > audio_cpu_ticks)
		{
			for(i = 1; i <= AUDIO_CPU_FUNCTIONS; ++i)
				audio_cpu_function[i-1] =
						(float)avgt[i] * 100.0 / avgt[0];
			audio_cpu_total = (float)avgtotal * 100.0 / avgt[0];
			memset(avgt, 0, sizeof(avgt));
			avgtotal = 0;
			last_out = ticks;
		}
#undef	TS
#endif
		outbuf += frames * 2;
		aev_advance_timer(frames);
	}
	aev_client("Unknown");
}


#ifdef HAVE_OSS
/*
 * Engine thread for OSS
 */
int	oss_outbufsize = 0;
Sint16	*oss_outbuf = NULL;

void *_audio_engine(void *dummy)
{
	while(_audio_running)
	{
#  ifdef AUDIO_LOCKING
		pthread_mutex_lock(&_audio_mutex);
#  endif
		_audio_callback(NULL, (Uint8 *)oss_outbuf, oss_outbufsize);
#  ifdef AUDIO_LOCKING
		pthread_mutex_unlock(&_audio_mutex);
#  endif
		write(adev.outfd, oss_outbuf, oss_outbufsize);
	}
	audiodev_close(&adev);
	return NULL;
}
#endif


/*
 * "Driver" call for polling mode.
 */
void audio_run(void)
{
#ifdef HAVE_OSS
	audio_buf_info info;

	if(!(using_oss && using_polling && _audio_running))
		return;

	ioctl(adev.outfd, SNDCTL_DSP_GETOSPACE, &info);
	while(info.bytes >= oss_outbufsize)
	{
		_audio_callback(NULL, (Uint8 *)oss_outbuf, oss_outbufsize);
		write(adev.outfd, oss_outbuf, oss_outbufsize);
		info.bytes -= oss_outbufsize;
	}
#endif
}


static int _start_oss_output()
{
#ifdef HAVE_OSS
	audiodev_init(&adev);
	adev.rate = a_settings.samplerate;
	adev.fragmentsize = a_settings.output_buffersize *
			sizeof(Sint16) * 2;
	adev.fragments = BUFFERS;
	_audio_running = 1;
	if(audiodev_open(&adev) < 0)
	{
		fprintf(stderr, "audio.c: Failed to open audio!\n");
		_audio_running = 0;
		return -2;
	}

	if(a_settings.output_buffersize > MAX_BUFFER_SIZE)
		a_settings.buffersize = MAX_BUFFER_SIZE;
	else
		a_settings.buffersize = a_settings.output_buffersize;

	mixbuf = calloc(1, a_settings.buffersize * sizeof(int) * 2);
	if(!mixbuf)
		return -1;


	oss_outbufsize = a_settings.output_buffersize * sizeof(Sint16) * 2;
	oss_outbuf = calloc(1, oss_outbufsize);
	if(!oss_outbuf)
	{
		audiodev_close(&adev);
		_audio_running = 0;
		fprintf(stderr, "audio.c: Failed to allocate output buffer!\n");
		return -4;
	}

	if(using_polling)
		return 0;	//That's it!

	if(pthread_create(&engine_thread, NULL, _audio_engine, NULL))
	{
		free(oss_outbuf);
		oss_outbuf = NULL;
		audiodev_close(&adev);
		fprintf(stderr, "audio.c: Failed to start audio engine!\n");
		return -3;
	}
	return 0;
#else
	fprintf(stderr, "OSS audio not compiled in!\n");
	return -1;
#endif
}


static int _start_SDL_output(void)
{
	SDL_AudioSpec as;
	SDL_AudioSpec audiospec;

	if(SDL_InitSubSystem(SDL_INIT_AUDIO) < 0)
		return -2;

	as.freq = a_settings.samplerate;
	as.format = AUDIO_S16SYS;
	as.channels = 2;
	as.samples = (Uint16)a_settings.output_buffersize;
	as.callback = _audio_callback;
	if(SDL_OpenAudio(&as, &audiospec) < 0)
		return -3;

	if(audiospec.format != AUDIO_S16SYS)
	{
		fprintf(stderr, "audio.c: ERROR: Only 16 bit output supported!\n");
		SDL_CloseAudio();
		return -4;
	}

	if(audiospec.channels != 2)
	{
		fprintf(stderr, "audio.c: ERROR: Only stereo output supported!\n");
		SDL_CloseAudio();
		return -5;
	}

	if(a_settings.samplerate != audiospec.freq)
	{
		fprintf(stderr, "audio.c: Warning: Requested fs=%d Hz, but"
				"got %d Hz.\n", a_settings.samplerate,
				audiospec.freq);
		a_settings.samplerate = audiospec.freq;
	}

	if((unsigned)audiospec.samples != a_settings.output_buffersize)
	{
		fprintf(stderr, "audio.c: Warning: Requested %u sample"
				"buffer, but got %u samples.\n",
				a_settings.output_buffersize, audiospec.samples);
		a_settings.output_buffersize = audiospec.samples;
	}

	if(a_settings.output_buffersize > MAX_BUFFER_SIZE)
		a_settings.buffersize = MAX_BUFFER_SIZE;
	else
		a_settings.buffersize = a_settings.output_buffersize;

	mixbuf = calloc(1, a_settings.buffersize * sizeof(int) * 2);
	if(!mixbuf)
	{
		SDL_CloseAudio();
		return -1;
	}

	_audio_running = 1;
	SDL_PauseAudio(0);
	return 0;
}


static int _mixing_open = 0;

static void _close_mixing(void)
{
	int i;
	if(!_mixing_open)
		return;

/* KLUDGE */	lim_close(&limiter);
	for(i = 0; i < AUDIO_MAX_BUSSES; ++i)
	{
		free(busbufs[i]);
		busbufs[i] = NULL;
	}
	free(audio_silent_buffer);
	audio_silent_buffer = NULL;
	_mixing_open = 0;
}

static int _open_mixing(void)
{
	unsigned bytes = a_settings.buffersize * sizeof(int) * 2;
	unsigned i;
	if(_mixing_open)
		return 0;

	for(i = 0; i < AUDIO_MAX_BUSSES; ++i)
	{
		busbufs[i] = calloc(1, bytes);
		if(!busbufs[i])
		{
			_close_mixing();
			return -1;
		}
	}
	audio_silent_buffer = calloc(1, bytes);
	if(!audio_silent_buffer)
	{
		_close_mixing();
		return -2;
	}

/* KLUDGE */	if(lim_open(&limiter, a_settings.samplerate) < 0)
/* KLUDGE */	{
/* KLUDGE */		_close_mixing();
/* KLUDGE */		return -3;
/* KLUDGE */	}
/* KLUDGE */	lim_control(&limiter, LIM_THRESHOLD, DEFAULT_LIM_THRESHOLD);
/* KLUDGE */	lim_control(&limiter, LIM_RELEASE, DEFAULT_LIM_RELEASE);

	_mixing_open = 1;
	return 0;
}


static void _stop_output(void)
{
	_audio_running = 0;
	if(using_oss)
	{
#ifdef HAVE_OSS
		if(!using_polling)
		{
#  ifdef AUDIO_LOCKING
			if(_audio_mutex_locked)
				pthread_mutex_unlock(&_audio_mutex);
#  endif
			pthread_join(engine_thread, NULL);
#  ifdef AUDIO_LOCKING
			pthread_mutex_destroy(&_audio_mutex);
			_audio_mutex_locked = 0;
#  endif
		}
		free(oss_outbuf);
		oss_outbuf = NULL;
#endif
	}
	else
		SDL_CloseAudio();
}


#ifdef AUDIO_LOCKING
/*
 * This sucks. The engine should *never* be locked!
 *
 * Using the API mostly results in single-reader/single-writer
 * situations (the *API* is not guaranteed to be thread safe!),
 * so we just need to do things in the right order.
 */
void audio_lock(void)
{
	if(using_oss)
	{
#ifdef HAVE_OSS
		if(using_polling)
			return;
		if(!_audio_mutex_locked)
			pthread_mutex_lock(&_audio_mutex);
		++_audio_mutex_locked;
#endif
	}
	else
		SDL_LockAudio();
}


void audio_unlock(void)
{
	if(using_oss)
	{
#ifdef HAVE_OSS
		if(using_polling)
			return;
		if(_audio_mutex_locked)
		{
			--_audio_mutex_locked;
			if(!_audio_mutex_locked)
				pthread_mutex_unlock(&_audio_mutex);
		}
#endif
	}
	else
		SDL_UnlockAudio();
}
#endif


/*----------------------------------------------------------
	Open/close code
----------------------------------------------------------*/

static int _wasinit = 0;


int audio_open(void)
{
	if(_wasinit)
		return 0;

	aev_client("audio_open()");

	audio_wave_open();
	audio_patch_open();
	audio_group_open();

	/* NOTE: AGW will auto-initialize if used! */

	_wasinit = 1;
	return 0;
}


int audio_start(int rate, int latency, int use_oss, int use_midi, int pollaudio)
{
	int i;

	if(audio_open() < 0)
		return -100;

	audio_stop();

	aev_client("audio_start()");

	a_settings.samplerate = rate;
	using_oss = use_oss;
	using_polling = pollaudio;

	if(sfifo_init(&commands, sizeof(command_t) * MAX_COMMANDS) < 0)
	{
		fprintf(stderr, "audio.c: Failed to set up audio engine!\n");
		return -1;
	}

	if(ptab_init(65536) < 0)
	{
		fprintf(stderr, "audio.c: Failed to set up pitch table!\n");
		sfifo_close(&commands);
		return -2;
	}


	audio_channel_open();
	audio_voice_open();
	audio_bus_open();
	if(aev_open(AUDIO_MAX_VOICES * MAX_BUFFER_SIZE) < 0)
	{
		audio_stop();
		return -1;
	}

	/*
	 * Note: We assume here that SDL also uses 3
	 *       fragments, which may not be true.
	 */
	if(latency > 1000)
		latency = 1000;
	a_settings.output_buffersize = MIN_BUFFER_SIZE;
	while(BUFFERS*a_settings.output_buffersize*1000 /
			 a_settings.samplerate < latency)
		a_settings.output_buffersize <<= 1;
	a_settings.output_buffersize >>= 1;

	/* One event per frame for each voice should do, right...? */
//	if(aev_open(AUDIO_MAX_VOICES * MAX_BUFFER_SIZE) < 0)
//		return -7;

	_audio_pause = 1;	/* Don't touch anything yet! */

	if(using_polling && !using_oss)
	{
		fprintf(stderr, "WARNING: Overriding driver selection!"
				" 'pollaudio' requires OSS.\n");
		using_oss = 1;
	}

	if(using_oss)
		i = _start_oss_output();
	else
		i = _start_SDL_output();
	if(i < 0)
	{
		audio_stop();
		return -6;
	}

	if(_open_mixing() < 0)
	{
		audio_stop();
		return -5;
	}

#ifdef DEBUG
	oscbufl = calloc(1, OSCFRAMES*sizeof(int));
	oscbufr = calloc(1, OSCFRAMES*sizeof(int));
	oscframes = OSCFRAMES;
#endif
	midicon_open((float)a_settings.samplerate, 16);

	if(use_midi)
		using_midi = midi_open(&midicon_midisock) >= 0;
	else
		using_midi = 0;

	sequencer_open(&midicon_midisock, (float)a_settings.samplerate);
	audio_wave_prepare(-1); /* Update "natural speeds" and stuff... */
	aev_reset_timer();	/* Reset event system timer */

	aev_client("Unknown");
	waiting = 0;
	_audio_pause = 0;	/* GO! */
	_wasinit = 1;
	return 0;
}


void audio_stop(void)
{
	if(_audio_running)
	{
		printf("Stopping audio engine... ");
		_audio_pause = 1;
		_stop_output();
	}

	_close_mixing();
	sequencer_close();
	if(using_midi)
		midi_close();
	midicon_close();
	ptab_close();
	sfifo_close(&commands);
#ifdef DEBUG
	oscframes = 0;
	free(oscbufl);
	free(oscbufr);
	oscbufl = NULL;
	oscbufr = NULL;
#endif
	audio_bus_close();
	audio_voice_close();
	audio_channel_close();
	aev_close();
}


void audio_close(void)
{
	if(!_wasinit)
		return;

	audio_stop();

	agw_close();
	audio_group_close();
	audio_patch_close();
	audio_wave_close();

	_wasinit = 0;
}


/*----------------------------------------------------------
	Engine Control
----------------------------------------------------------*/

void audio_master_volume(float vol)
{
	master_vol = (int)(vol * 65536.0);
	DBG3(printf("master_vol = %d\n", master_vol);)
}


/*
FIXME: These two do not belong here..
*/
void audio_master_reverb(float rvb)
{
	master_rvb = (int)(rvb * 65536.0);
	audio_bus_controlf(7, 0, ABC_SEND_MASTER, 0.0);
	audio_bus_control(7, 1, ABC_SEND_MASTER, master_rvb);
	if(master_rvb)
	{
		audio_bus_control(7, 1, ABC_FX_TYPE, AFX_REVERB);
		DBG3(printf("master_rvb = %d\n", master_rvb);)
	}
	else
	{
		audio_bus_control(7, 1, ABC_FX_TYPE, AFX_NONE);
		DBG3(printf("master_rvb off\n");)
	}
}


void audio_set_limiter(float thres, float rels)
{
	int t, r;
	t = (int)(32768.0 * thres);
	if(t < 256)
		t = 256;
	r = (int)(rels * 65536.0);
	lim_control(&limiter, LIM_THRESHOLD, t);
	lim_control(&limiter, LIM_RELEASE, r);
}


void audio_quality(audio_quality_t quality)
{
	a_settings.quality = quality;
}



/*----------------------------------------------------------
	Engine Debugging Stuff
----------------------------------------------------------*/

#ifdef DEBUG
static void print_accbank(accbank_t *ctl, int is_group)
{
	const char names[ACC_COUNT][8] = {
		"GRP",
		"PRI",
		"PATCH",

		"PBUS",
		"SBUS",

		"PAN",
		"PITCH",

		"VOL",
		"SEND",

		"MOD1",
		"MOD2",
		"MOD3",

		"X",
		"Y",
		"Z"
	};
	int i;
	if(is_group)
		i = ACC_PAN;
	else
		i = 0;
	for(; i < ACC_COUNT; ++i)
	{
		printf("%s=", names[i]);
		if(ACC_IS_FIXEDPOINT(i))
			printf("%.4g ", (double)((*ctl)[i]/65536.0));
		else
			printf("%d ", (*ctl)[i]);
	}
}

static void print_vc(audio_voice_t *v)
{
	const char names[VC_COUNT][8] = {
		"WAVE",
		"LOOP",
		"PITCH",

		"RETRIG",
		"RANDTR",

		"PBUS",
		"SBUS"
	};
	const char inames[VIC_COUNT][8] = {
		"LVOL",
		"RVOL",
		"LSEND",
		"RSEND"
	};
	int i;
	for(i = 0; i < VC_COUNT; ++i)
	{
		printf("%s=", names[i]);
		switch(i)
		{
		  case VC_PITCH:
		  case VC_RANDTRIG:
			printf("%.4g ", (double)(v->c[i]/65536.0));
			break;
		  default:
			printf("%d ", v->c[i]);
			break;
		}
	}
	for(i = 0; i < VIC_COUNT; ++i)
	{
		printf("%s=", inames[i]);
		printf("%.4g ", (double)(v->ic[i].v/(65536.0*128.0)));
	}
}

static void print_voices(int channel)
{
	int i;
	for(i = 0; i < AUDIO_MAX_VOICES; ++i)
		if(channel == -1 || (voicetab[i].channel ==
				(channeltab + channel) &&
				(voicetab[i].state != VS_STOPPED)) )
		{
			if((channel == -1) && (voicetab[i].state != VS_STOPPED))
				printf("  ==>");
			else
				printf("    -");
			printf("VOICE %.2d: ", i);
			print_vc(&voicetab[i]);
			printf("\n");
		}
}

static void print_channels(int group)
{
	int i;
	for(i = 0; i < AUDIO_MAX_CHANNELS; ++i)
	{
		if(channeltab[i].ctl[ACC_GROUP] != group)
			continue;
		printf("  -CHANNEL %.2d: ", i);
		print_accbank(&channeltab[i].rctl, 0);
		printf("\n");
		printf("      Transf.: ");
		print_accbank(&channeltab[i].ctl, 0);
		printf("\n");
		print_voices(i);
	}
}

static int group_in_use(int group)
{
	int i;
	for(i = 0; i < AUDIO_MAX_CHANNELS; ++i)
	{
		if(channeltab[i].ctl[ACC_GROUP] == group)
			return 1;
	}
	return 0;
}

void audio_print_info(void)
{
	int i;
	printf("--------------------------------------"
			"--------------------------------------\n");
	printf("Audio Engine Info:\n");
	for(i = 0; i < AUDIO_MAX_GROUPS; ++i)
	{
		if(!group_in_use(i))
			continue;
		printf("-GROUP %.2d-----------------------------"
				"--------------------------------------\n", i);
		printf("  ctl: ");
		print_accbank(&grouptab[i].ctl, 1);
		printf("\n  def: ");
		print_accbank(&grouptab[i].ctl, 1);
		printf("\n");
		print_channels(i);
	}
	printf("--------------------------------------"
			"--------------------------------------\n");
#if 0
	print_voices(-1);
	printf("--------------------------------------"
			"--------------------------------------\n");
#endif
}
#endif
