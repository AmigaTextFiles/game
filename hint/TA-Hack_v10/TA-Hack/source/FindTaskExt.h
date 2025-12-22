#include <exec/tasks.h>

#define FT_NONE    0
#define FT_TASK    1
#define FT_PROCESS 2
#define FT_COMMAND 4

extern struct Task *FindTaskExt(char *name, BOOL casesensitive, ULONG *type);

/* This function will allow you to find tasks/processes.
   name specified the name of the task/process
   if casesensitive are TRUE the name must be exaclty the "name" otherwise
   the search will be case insensitive ("ab" == "AB" == "aB"...)
   with type you could specify the type, you will find. if type is specified,
   after the call, the type will be stand in. (see FT_... above).
   The type FT_COMMAND will mean, it is a process loaded in a CLI, exec´s
   FindTask will never find this process (only the Shell/Mother Process).
   
   have fun.
   
   ©1996 ALeX Kazik (see TA-Hack.readme)
   
   PublicDomain.  */