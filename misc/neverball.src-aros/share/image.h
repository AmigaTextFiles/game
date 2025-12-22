#ifndef IMAGE_H
#define IMAGE_H

#include <stdio.h>
#ifdef __AROS__
#include <SDL/SDL.h>
#include <SDL/SDL_ttf.h>
#else
#include <SDL.h>
#include <SDL_ttf.h>
#endif

#include "glext.h"
#include "base_image.h"

/*---------------------------------------------------------------------------*/

void   image_snap(const char *);

GLuint make_image_from_file(const char *);
GLuint make_image_from_font(int *, int *,
                            int *, int *, const char *, TTF_Font *);

SDL_Surface *load_surface(const char *);

/*---------------------------------------------------------------------------*/

#endif
