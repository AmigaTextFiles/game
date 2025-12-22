/*
  Block Rage - the arcade game
  Copyright (C) 1999-2005 Jiri Svoboda

  This file is part of Block Rage.

  Block Rage is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; either version 2
  of the License, or (at your option) any later version.

  Block Rage is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with Block Rage; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

  Jiri Svoboda
  jirik.svoboda@seznam.cz
*/

#ifdef NOSOUND

void sound_fx(int stype) {
}

int sound_init(void) {
  return 1;
}

void sound_done(void) {
}

#else

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <SDL.h>
#include "global.h"
#include "sound.h"

/*typedef struct {
  unsigned char *data;
  long size;
} ucp_t;*/

static ucp_t sfx[4];
//static pid_t child;
//static int sound_pipe[2];

void *mixbuf; 				/* the mixing buffer */
VOICE_INFO voice[MAX_VOICES];
int mixbuf_out_b;

long mixspeed;
long mixfmt;

int mixbuf_size;
int mixbuf_size_b;

int audio_queue_size;

SDL_AudioSpec desired, obtained;

void mix_fillbuf(void);

static void my_audio_callback(void *udata, Uint8 *b_buf, int len) {
  Uint8 *mixbuf8 = (Uint8 *)mixbuf;
  
  int now;
  
  while(len>0) {
    if(mixbuf_out_b>=mixbuf_size_b) {
      mix_fillbuf();
      mixbuf_out_b=0;
    }
    now=mixbuf_size_b-mixbuf_out_b;
    if(now>len) now=len;
    memcpy(b_buf,mixbuf8+mixbuf_out_b,now);    
    b_buf+=now;
    mixbuf_out_b+=now;
    len-=now;
  }
}

void mix_mixvoice_8u(int vn) {
  long bytes,i;
  unsigned char *smp,*buf;
  int c;
  
  buf=(unsigned char *)mixbuf;
  
  if(voice[vn].left>0) {
    bytes=voice[vn].left;
    if(bytes<0) bytes=0;
    if(bytes>mixbuf_size_b) bytes=mixbuf_size_b;
    
    smp=(unsigned char *)voice[vn].sample;
    
    for(i=0;i<bytes;i++) {
      c=buf[i];
      c-=128;
      c+=*smp++;
      buf[i]=c;
    }
      
    voice[vn].sample=(void *)smp;
    
    voice[vn].left-=bytes;
        
    if(voice[vn].left<=0) {
      voice[vn].left=0;
      voice[vn].sample=NULL;
      DEBUG2(printf("blockrage/sound: done playing sfx at voice %d\n",vn);)
    }
  }
}

void mix_mixvoice_s16_le(int vn) {
  long bytes,i;
  signed short *smp,*buf;
  
  buf=(signed short *)mixbuf;
  
  if(voice[vn].left>0) {
    bytes=voice[vn].left;
    if(bytes<0) bytes=0;
    if(bytes>mixbuf_size_b) bytes=mixbuf_size_b;
    
    smp=(signed short *)voice[vn].sample;
    
    for(i=0;i<bytes;i+=2) {
      (*buf++)+=(*smp++)/2;
    }
      
    voice[vn].sample=(void *)smp;
    
    voice[vn].left-=bytes;
        
    if(voice[vn].left<=0) {
      voice[vn].left=0;
      voice[vn].sample=NULL;
      DEBUG2(printf("blockrage/sound: done playing sfx at voice %d\n",vn);)
    }
  }
}

void mix_clearbuf_8u(void) {
  int i;
  unsigned char *buf;
  
  buf=(unsigned char *)mixbuf;
  
  for(i=0;i<mixbuf_size;i++)
      buf[i]=128;
}

void mix_clearbuf_s16_le(void) {
  int i;
  signed short *buf;
  
  buf=(signed short *)mixbuf;
  
  for(i=0;i<mixbuf_size;i++)
      buf[i]=0;
}

void mix_fillbuf(void)
{
  int i;
  
  if(mixfmt==AUDIO_S16LSB) {
    mix_clearbuf_s16_le();
    for(i=0;i<MAX_VOICES;i++) 
      mix_mixvoice_s16_le(i);
    
  } else {
  
    mix_clearbuf_8u();
    for(i=0;i<MAX_VOICES;i++) 
      mix_mixvoice_8u(i);
      
  }
}

void voices_init(void) {
  int i;
  
  for(i=0;i<MAX_VOICES;i++) {
    voice[i].sample=NULL;
    voice[i].left=0;
  }
}

int voices_findidlevoice(void) {
  int i;
  
  for(i=0;i<MAX_VOICES;i++) {
    if(voice[i].left==0) return i;
  }
  
  return -1;
}

void voices_playsample(int vn, ucp_t smp) {
  
  voice[vn].sample=smp.data;
  voice[vn].left=smp.size;

}

void sound_fx(int sfxnum) {
  int v;
  
  if(sfxnum<-1 || sfxnum>3) return;
  v=voices_findidlevoice();
  
  if(v==-1) {
    DEBUG1(printf("blockrage/sound: no free voices\n");)
    return;
  }
  DEBUG2(printf("blockrage/sound: playing sfx at voice %d\n",v);)
  voices_playsample(v,sfx[sfxnum]);
}

void sound_defaults(void) {
  mixspeed=44100;
  mixfmt=AUDIO_S16LSB;

  mixbuf_size = 1024;
  
  audio_queue_size = 2048;
}

int sound_init(void) {
  
  sfx[0].data=file_load("sfx0.snd"); sfx[0].size=fload_len;
  DEBUG2(printf("len:%ld\n",fload_len);)
  sfx[1].data=file_load("sfx1.snd"); sfx[1].size=fload_len;
  DEBUG2(printf("len:%ld\n",fload_len);)
  sfx[2].data=file_load("sfx2.snd"); sfx[2].size=fload_len;
  DEBUG2(printf("len:%ld\n",fload_len);)
  sfx[3].data=file_load("sfx2.snd"); sfx[3].size=fload_len;
  DEBUG2(printf("len:%ld\n",fload_len);)

  sound_defaults();

  desired.freq = mixspeed;
  desired.format = mixfmt;
  desired.channels = 1; /* mono */
  desired.samples = audio_queue_size;
  desired.callback = my_audio_callback;
  desired.userdata = NULL;
  
  mixbuf_out_b=0;
  
  if( SDL_OpenAudio(&desired, &obtained) < 0) {
    fprintf(stderr, "Cannot open audio: %s\n", SDL_GetError());
    return 0;
  }
  
  mixspeed = obtained.freq;
  mixfmt = obtained.format;
  audio_queue_size = desired.samples;
  
  if(mixfmt!=AUDIO_S16LSB && mixfmt!=AUDIO_U8) {
    fprintf(stderr,"unsupported audio output format\n");
    return 0;
  }
  
  mixbuf_size_b = mixbuf_size * (mixfmt==AUDIO_S16LSB ? 2 : 1);
  
  mixbuf=calloc(mixbuf_size_b,1);
  if(!mixbuf) {
    fprintf(stderr,"blockrage/sound: error allocating mixing buffer\n");
    return 0;
  }

  DEBUG2(printf("starting audio\n"));
  SDL_PauseAudio(0);
  return 1;
}

void sound_done(void) {
  DEBUG1(printf("SDL_CloseAudio...\n"));
  SDL_CloseAudio();
  DEBUG1(printf("free mixbuf...\n"));
  free(mixbuf);
  DEBUG1(printf("ok\n"));
}

#endif
