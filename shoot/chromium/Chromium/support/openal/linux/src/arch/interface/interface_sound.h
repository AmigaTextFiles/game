/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * interface_sound.h
 *
 * High level prototypes for sound device aquisition and management.
 *
 */
#ifndef INTERFACE_SOUND_H_
#define INTERFACE_SOUND_H_

#include <AL/altypes.h>
#include <AL/alkludge.h>

unsigned int spot(unsigned int spotee);

void      *grab_write_audiodevice(void);
void      *grab_read_audiodevice(void);

ALboolean  set_read_audiodevice(void *handle,
			   unsigned int *bufsiz,
			   unsigned int *fmt,
			   unsigned int *speed);

ALboolean  set_write_audiodevice(void *handle,
			   unsigned int *bufsiz,
			   unsigned int *fmt,
			   unsigned int *speed);

void     (*blitbuffer)(void *handle, void *dataptr, int bytes_to_write);
ALboolean  release_audiodevice(void *handle);

/* get (normalized) audio setting for handle at channel */
float get_audiochannel(void *handle, ALuint channel);
void set_audiochannel(void *handle, ALuint channel, float volume);

/* inform device specified by handle that it's about to get paused */
void pause_audiodevice(void *handle);

/* inform device specified by handle that it's about to get unpaused */
void resume_audiodevice(void *handle);

/* capture data from the audio device */
void capture_audiodevice(void *handle, void *capture_buffer, int bufsiz);

#endif
