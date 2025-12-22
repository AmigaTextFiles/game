#include <string.h>
#include <ctype.h>

#define _STR_LENGTH_MAX_ 256

#define _CHAR_NULL_     '\0'
#define _CHAR_ENDLINE_  '\40'

typedef char type_string[_STR_LENGTH_MAX_];

#ifndef __strings_h_
#define __strints_h_

int findLastStr (const char *, char *);
int findDir (const char *, char *);

#endif
