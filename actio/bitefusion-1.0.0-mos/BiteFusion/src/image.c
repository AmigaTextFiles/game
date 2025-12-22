#include <SDL/SDL.h>
#include <zlib.h>

#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

#include "error.h"
#include "images.h"

static struct
{
  char name[64];
  uint32_t width;
  uint32_t height;
} infos[4096];

static SDL_Surface* surfaces[4096];
static uint32_t image_count = 0;

#if SDL_BYTEORDER == SDL_LIL_ENDIAN
#define swapu32(v)
#else
#define swapu32(v) do { v = (v >> 24) | ((v & 0xFF0000) >> 8) | ((v & 0xFF00) << 8) | (v << 24); } while(0);
#endif

void load_images()
{
  uint32_t i, j, x, y;
  SDL_Surface* s;
  z_stream input;

  memset(&input, 0, sizeof(input));

  input.next_in = (Bytef*) images;
  input.avail_in = size_images;

  if(Z_OK != inflateInit(&input))
    fatal_error("Executable is corrupt");

  input.next_out = (Bytef*) &image_count;
  input.avail_out = 4;

  inflate(&input, Z_SYNC_FLUSH);

  if(!image_count)
  {
    inflateEnd(&input);

    return;
  }

  swapu32(image_count);

  assert(image_count <= sizeof(surfaces) / sizeof(surfaces[0]));

  input.next_out = (Bytef*) infos;
  input.avail_out = image_count * sizeof(infos[0]);
  inflate(&input, Z_SYNC_FLUSH);

  for(i = 0; i < image_count; ++i)
  {
    unsigned char* data;
    unsigned char* dest;

    if(surfaces[i])
      continue;

    swapu32(infos[i].width);
    swapu32(infos[i].height);

    data = malloc(infos[i].width * infos[i].height * 4);

    input.next_out = (Bytef*) data;
    input.avail_out = infos[i].width * infos[i].height * 4;
    inflate(&input, Z_SYNC_FLUSH);

#if SDL_BYTEORDER == SDL_LIL_ENDIAN
    s = SDL_CreateRGBSurface(SDL_SRCALPHA, infos[i].width, infos[i].height, 32, 0x000000ff, 0x0000ff00, 0x00ff0000, 0xff000000);
#else
    s = SDL_CreateRGBSurface(SDL_SRCALPHA, infos[i].width, infos[i].height, 32, 0xff000000, 0x00ff0000, 0x0000ff00, 0x000000ff);
#endif

    surfaces[i] = s;

    SDL_LockSurface(s);

    for(y = 0; y < s->h; ++y)
    {
      dest = (unsigned char*) s->pixels + y * s->pitch;

      for(x = 0; x < s->w * 4; x += 4)
      {
        dest[x] = data[y * s->w * 4 + x];
        dest[x + 1] = data[y * s->w * 4 + x + 1];
        dest[x + 2] = data[y * s->w * 4 + x + 2];
        dest[x + 3] = data[y * s->w * 4 + x + 3];
      }
    }

    SDL_UnlockSurface(surfaces[i]);

    free(data);
  }

  inflateEnd(&input);
}

SDL_Surface* get_image(const char* name)
{
  uint32_t i;

  for(i = 0; i < image_count; ++i)
  {
    if(!strcmp(infos[i].name, name))
      return surfaces[i];
  }

  return 0;
}
