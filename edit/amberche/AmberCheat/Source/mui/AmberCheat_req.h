#ifndef EXEC_TYPES_H
#include  <exec/types.h>
#endif

extern int request( STRPTR, APTR, ... );
extern void requestNA( STRPTR, APTR, ... );
extern int requester( STRPTR, STRPTR, APTR, ... );

