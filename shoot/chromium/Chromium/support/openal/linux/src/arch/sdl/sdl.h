/* -*- mode: C; tab-width:8; c-basic-offset:8 -*-
 * vi:set ts=8:
 *
 * sdl.h
 *
 * SDL backend prototypes.
 *
 */
#ifndef SDL_H_
#define SDL_H_

#include <AL/altypes.h>
#include <AL/alkludge.h>

void *grab_read_sdl(void);
void *grab_write_sdl(void);

ALboolean set_write_sdl(void *handle, int *bufsiz, int *fmt, int *speed);
ALboolean set_read_sdl(void *handle, int *bufsiz, int *fmt, int *speed);
void release_sdl(void *handle);

void sdl_blitbuffer(void *handle, void *data, int bytes);
void firsttime_sdl_blitbuffer(void *handle, void *data, int bytes);

#endif /* SDL_H_ */
