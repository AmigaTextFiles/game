/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * lin_dsp.h
 *
 * Native linux implementation
 */
#ifndef LIN_DSP_H_
#define LIN_DSP_H_

#include "AL/alc.h"

/* native linux (/dev/dsp) stuff */
void *grab_read_native(void);
void *grab_write_native(void);

ALboolean set_read_native(void *handle,
		     unsigned int *bufsiz,
		     unsigned int *fmt,
		     unsigned int *speed);
ALboolean set_write_native(void *handle,
		     unsigned int *bufsiz,
		     unsigned int *fmt,
		     unsigned int *speed);

void native_blitbuffer(void *handle, void *data, int bytes);
void release_native(void *handle);

float get_nativechannel(void *handle, ALCenum channel);
int set_nativechannel(void *handle, ALCenum channel, float volume);

void pause_nativedevice(void *handle);
void resume_nativedevice(void *handle);

/* capture data from the audio device */
void capture_nativedevice(void *handle, void *capture_buffer, int bufsiz);

#endif
