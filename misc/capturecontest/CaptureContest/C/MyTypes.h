
/*###########*/
/* MyTypes.h */    /* 9.1.2011 */
/*###########*/

#ifndef MyTypes_h
#define MyTypes_h

#ifndef boolean
typedef enum {F, T}        boolean;
#else
#error MyTypes Definition Duplication
#endif

#ifndef uint
typedef unsigned int       uint;
#else
#error MyTypes Definition Duplication
#endif

#endif

