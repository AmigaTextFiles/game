#ifndef KEYNAMES_H
#define KEYNAMES_H

#ifdef __AROS__
#include <SDL/SDL_keyboard.h>
#else
#include <SDL_keyboard.h>
#endif

const char *pretty_keyname(SDLKey);

#endif
