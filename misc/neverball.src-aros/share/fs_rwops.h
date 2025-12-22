#ifndef FS_RWOPS_H
#define FS_RWOPS_H

#ifdef __AROS__
#include <SDL/SDL_rwops.h>
#else
#include <SDL_rwops.h>
#endif
#include "fs.h"

SDL_RWops *fs_rwops_make(fs_file);
SDL_RWops *fs_rwops_open(const char *path, const char *mode);

#endif
