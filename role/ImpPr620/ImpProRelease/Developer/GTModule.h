// Defines for an external Imp Professional module

#ifndef MODULE_H
#define MODULE_H

#include "ImpLib.h"
#include "ImpLib_pragmas.h"

#define BUF              80
#define OK               1

// Structures and typedefs

// Protos for an external Imp Professional module

void 		Open_All(void);
void 		Close_All(char *);

// externs

extern struct Library *ImpBase;
#endif
