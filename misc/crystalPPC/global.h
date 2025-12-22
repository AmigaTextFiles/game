#ifndef GLOBAL_H
#define GLOBAL_H

#ifdef DJGPP
 typedef int BOOL;
#endif
#ifndef USE_ALLEGRO
// allegro has this type
 typedef long fixed;
#endif
typedef unsigned char byte;
typedef unsigned short word;
typedef unsigned long dword;

#endif // GLOBAL_H
