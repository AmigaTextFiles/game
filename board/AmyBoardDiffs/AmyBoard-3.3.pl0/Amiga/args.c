/***
***  args.c -- argument parsing system for AmyBoard
***
*** ------------------------------------------------------------------------
***  This program is free software; you can redistribute it and/or modify
***  it under the terms of the GNU General Public License as published by
***  the Free Software Foundation; either version 2 of the License, or
***  (at your option) any later version.
***
***  This program is distributed in the hope that it will be useful,
***  but WITHOUT ANY WARRANTY; without even the implied warranty of
***  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
***  GNU General Public License for more details.
***
***  You should have received a copy of the GNU General Public License
***  along with this program; if not, write to the Free Software
***  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*** ------------------------------------------------------------------------
**/
/**/


/***** ParseArgs() *********************************************************
*
*   NAME
*       ParseArgsA() - universal, tag based ReadArgs() replacement
*
*   SYNOPSIS
*       ULONG Sucess = ParseArgsA(int argc, char *argv[],
*                                 struct TagItem *taglist);
*
*       ULONG Success = ParseArgs(int argc, char *argv[],
*                                 Tag FirstTag, ...);
*
*   FUNCTION
*       ParseArgsA() and its stack based version ParseArgs() try to
*       replace dos.library/ReadArgs(). Unlike ReadArgs() they can
*       scan CLI arguments, icon tooltypes and preferences files
*       with one function call. Arguments are described with tags,
*       thus much more flexible.
*
*       Memory allocations are done with malloc(), you need not
*       free any memory. (If you don't like malloc(), use a
*       Exec-Pool based replacement like dev/misc/mempools.lha
*       from Aminet.)
*
*       These tags are known by ParseArgs():
*
*           PARSEARGS_ARGNAME - argument name (STRPTR); unlike
*               usual tag arrays the order os the tag items is
*               meaningful: Any arguments description must start
*               with a PARSEARGS_ARGNAME tag and certain other
*               tags (PARSEARGS_TYPE, PARSEARGS_VALPTR,
*               PARSEARGS_MULTIARG, PARSEARGS_REQUIRED) always
*               refer to the last PARSEARGS_ARGNAME. The order
*               of the arguments, however is meaningless.
*
*           PARSEARGS_TYPE - argument type (ULONG), one of
*
*               PARSEARGS_TYPE_STRING   string (default)
*
*               PARSEARGS_TYPE_BOOL     boolean value, like
*                   "true", "Yes", "on" (which return TRUE) or
*                   "false", "no" or "off" (which return FALSE)
*
*                   This argument type is handled like a mixture
*                   of the /T and /S switches of ReadArgs():
*                   Just using this argument (like QUIET/S)
*                   toggles the value, but you may explicitly
*                   select a value with "QUIET=true". However,
*                   QUIET "true" won't work, as the program
*                   just doesn't notice, that the following
*                   argument refers to the QUIET switch.
*
*               PARSEARGS_TYPE_INTEGER  integer value
*
*               PARSEARGS_TYPE_FLOAT    float value
*
*       PARSEARGS_VALPTR - pointer (APTR *) where to store the
*           argument value; you might setup default values by
*           just storing them where this pointer points to.
*           If this tag is missing, the respective arguments
*           are just ignored.
*
*       PARSEARGS_REQUIRED - (BOOL) treat it as an error, if
*           this argument wasn't present. (IoErr() will be set
*           to ERROR_REQUIRED_ARG_MISSING in that case.) Note,
*           that it does not make any difference, if the argument
*           was given on the command line or in a prefs file, for
*           example.
*
*       PARSEARGS_MULTIARG - (BOOL) argument may occur more than
*           once, a NULL terminated array of values is returned.
*           (Usually old values are just overwritten.) Note, that
*           it is possible, that a NULL is returned instead of an
*           array, indicating, that the argument wasn't mentioned
*           at all. (You can suppress this by using both
*           PARSEARGS_MULTIARG and PARSEARGS_REQUIRED.)
*
*           It is not possible to use this tag with boolean
*           arguments. (This wouldn't make much sense, IMO.)
*
*       PARSEARGS_PREFSFILE - name of a prefsfile (STRPTR),
*           ParseArgs() will look if the file exists. If it does,
*           it will be opened and its lines will be interpreted as
*           if they were icon tooltypes. You may supply more than
*           one prefs filename, but no more than one will be
*           opened. (Thus the program may look, for example, in
*           S: and ENV: for prefsfiles.)
*
*       PARSEARGS_HELPSTRING - help string (STRPTR) to put out,
*           when the user asks for a CLI template by giving a
*           "?" as the first CLI argument. By default ParseArgs()
*           generates a template like that of ReadArgs().
*
*
*   INPUTS
*       argc, argv - the usual main() arguments; argc = 0 is
*           expected, if, and only if, the program is run from
*           workbench; in that case argv must hold the WBStartup
*           message (this is the usual convention as for SAS/C).
*
*
*   EXAMPLE
*       \**
*       ***  Example similar to
*       ***     FROM=FROMFILE/A/M/K,TO/A/K,QUIET/S,ALL/S
*       **\
*       int main(int argc, char *argv[])
*
*       { STRPTR *from;
*         STRPTR to;
*         ULONG quiet = FALSE, all = FALSE;
*
*         if (!ParseArgs(argc, argv,
*                   PARSEARGS_ARGNAME, "from=fromfile",
*                   PARSEARGS_VALPTR, &from,
*                   PARSEARGS_MULTIARG, TRUE,
*                   PARSEARGS_REQUIRED, TRUE,
*
*                   PARSEARGS_ARGNAME, "to",
*                   PARSEARGS_VALPTR, &to,
*                   PARSEARGS_REQUIRED, TRUE,
*
*                   PARSEARGS_ARGNAME, "quiet",
*                   PARSEARGS_VALPTR, &quiet,
*                   PARSEARGS_TYPE, PARSEARGS_TYPE_BOOL,
*
*                   PARSEARGS_ARGNAME, "all",
*                   PARSEARGS_VALPTR, &all,
*                   PARSEARGS_TYPE, PARSEARGS_TYPE_BOOL,
*
*                   PARSEARGS_PREFSFILE, "ENV:MyPrefs",
*                   PARSEARGS_PREFSFILE, "S:MyPrefs",
*                   TAG_DONE))
*         { printf("Error %ld happened.\n", IoErr());
*           exit(10);
*         }
*
*         \**
*         ***  Not checking from == NULL, as this argument
*         ***  was required.
*         **\
*         while (*from)
*         { printf("from argument: %s\n", *from++);
*         }
*         printf("to argument: %s\n", to);
*         printf("quiet status: %ld, all status %ld.\n");
*       }
*
*       \**
*       ***  Dice's entry point when starting from Workbench.
*       **\
*       #if defined(_DCC)
*       int wbmain(struct WBStartup *wbs)
*       { return(main(0, (char **) argv)); }
*       #endif
*
*
*   BUGS
*       Currently it is not possible to use arguments without
*       argument name. (Like FROM instead of FROM/K.) Just because
*       I was too lazy. Neither are project names used. Both left
*       to the future.
*
*
*   RESULT
*       TRUE for success, FALSE otherwise; you might examine
*       IoErr() in the latter case.
*
*   SEE ALSO
*       dos.library/ReadArgs()
*
***************************************************************************/
/**/




/***  Includes section
***/
#include "amyboard.h"

#include <ctype.h>
#include <utility/tagitem.h>
#include <workbench/startup.h>
#include <workbench/icon.h>
#include <workbench/workbench.h>

#include <proto/utility.h>
#include <proto/icon.h>
/**/


/***  Type definitions
***/
typedef struct
{ STRPTR argName;
  ULONG numNames;
  APTR *valPtr;
  ULONG type;
  ULONG required;
  ULONG multiArgs;
  ULONG numMultiArgs;
  ULONG maxMultiArgs;
} Arg;
/**/



ULONG AddArg(Arg *arg, char *argVal, ULONG argSeen)

{ ULONG val;

  arg->required = FALSE;

  if (!arg->valPtr)
  { return(TRUE);
  }

  if (!argVal  ||  !argSeen)
  { argVal = "";
  }

  switch(arg->type)
  { case PARSEARGS_TYPE_BOOL:
      while(*argVal  &&  isspace(*argVal))
      { ++argVal;
      }
      if (*argVal == '\0')
      { val = !*((ULONG *) arg->valPtr);
      }
      else
      { val = Strnicmp((STRPTR) argVal, (STRPTR) "true", 4) == 0  ||
	      Strnicmp((STRPTR) argVal, (STRPTR) "on", 2) == 0    ||
	      Strnicmp((STRPTR) argVal, (STRPTR) "yes", 3) == 0;
      }
      break;
    case PARSEARGS_TYPE_INTEGER:
      val = (ULONG) atoi(argVal);
      break;
    case PARSEARGS_TYPE_FLOAT:
      val = (ULONG) atof(argVal);
      break;
    default:
      if (!(val = (ULONG) strdup(argVal)))
      { SetIoErr(ERROR_NO_FREE_STORE);
	return(FALSE);
      }
      break;
  }

  if (arg->type == PARSEARGS_TYPE_BOOL  ||
      !arg->multiArgs)
  { *((ULONG *) arg->valPtr) = val;
    return(TRUE);
  }

  /**
  ***  Multi argument handling
  **/
  if (arg->maxMultiArgs < arg->numMultiArgs+2)
  { ULONG newmax = MAX(arg->maxMultiArgs*2, 20);

    *arg->valPtr = realloc(*arg->valPtr, newmax*sizeof(ULONG));
    if (!(*arg->valPtr))
    { SetIoErr(ERROR_NO_FREE_STORE);
      return(FALSE);
    }
    arg->maxMultiArgs = newmax;
  }
  ((ULONG *) (*arg->valPtr))[arg->numMultiArgs++] = val;
  ((ULONG *) (*arg->valPtr))[arg->numMultiArgs] = (ULONG) NULL;
  return(TRUE);
}





/***  Input hooks
***/
_HOOK_FUNC(int, ParseFile, struct Hook *Hook,
			   FILE **fp,
			   ULONG *error)
{ *error = FALSE;
  return(getc(*fp));
}
struct Hook ParseFileHook =
{ { NULL, NULL },
  (HOOKFUNC) ParseFile,
  NULL,
  NULL
};

_HOOK_FUNC(int, ParseString, struct Hook *hook,
			     char **ptr,
			     ULONG *error)
{ int c;

  *error = FALSE;
  if ((c = **ptr))
  { (*ptr)++;
  }
  else
  { c = EOF;
  }
  return(c);
}
struct Hook ParseStringHook =
{ { NULL, NULL },
  (HOOKFUNC) ParseString,
  NULL,
  NULL
};
/**/


/*** DisplayArgs function (#ifdef DEBUG_ARGS)
***/
#ifdef DEBUG_ARGS
void DisplayArgs(Arg *args, ULONG numArgs)

{ Arg *arg;
  int i;

  for (i = 0, arg = args;  i < numArgs;  i++, arg++)
  { char *names = arg->argName;
    int j;

    kprintf("Arg %ld: Names = %s", i+1, names);
    for (j = 1;  j < arg->numNames;  j++)
    { names += strlen(names) + 1;
      kprintf(", %s", names);
    }

    kprintf("  type = %ld, ", arg->type);

    if (arg->valPtr)
    { kprintf("default value = ");
      switch (arg->type)
      { case PARSEARGS_TYPE_BOOL:
	  kprintf("%s", *((ULONG *) arg->valPtr) ? "TRUE" : "FALSE");
	  break;
	case PARSEARGS_TYPE_INTEGER:
	  kprintf("%ld", *((LONG *) arg->valPtr));
	  break;
	case PARSEARGS_TYPE_FLOAT:
	  kprintf("%f", *((FLOAT *) arg->valPtr));
	  break;
	default:
	  kprintf("%s", *((STRPTR *) arg->valPtr));
	  break;
      }
      kprintf(", argptr = %08lx\n", arg->valPtr);
    }
    else
    { kprintf("Argument not set.\n");
    }
  }
}
#endif
/**/


/*** DoParseArgs function
***/
ULONG DoParseArgs(Arg *args, ULONG numArgs, struct Hook *hook, APTR hookData,
		  ULONG allowComments, ULONG oneArgPerLine)

{ char buffer[512]; /*  Argument names and values must not be longer    */
		    /*  than this.                                      */
  int c;
  int error = FALSE;

#define hget CallHookA(hook, (Object *) &hookData, &error)
#define fillbuffer(p,c)                             \
  { if ((p) != buffer+sizeof(buffer))               \
    { *(p)++ = (c);                                 \
    }                                               \
    else                                            \
    { SetIoErr(ERROR_LINE_TOO_LONG);                \
      return(FALSE);                                \
    }                                               \
  }
#define getarg                                      \
  { if (c == '"')                                   \
    { while ((c = hget) != EOF  &&  c != '"')       \
      { fillbuffer(ptr, c);                         \
      }                                             \
      if (c != EOF)                                 \
      { c = hget;                                   \
      }                                             \
    }                                               \
    else                                            \
    { do                                            \
      { fillbuffer(ptr, c);                         \
	c = hget;                                   \
      }                                             \
      while (c != EOF  &&  !isspace(c));            \
    }                                               \
    *ptr = '\0';                                    \
  }

  while ((c  = hget) != EOF)
  { int argSeen = FALSE;
    char *argVal;
    char *ptr = buffer;
    Arg *thisArg;

    while (isspace(c))
    { if ((c = hget) == EOF)
      { return(!error);
      }
    }

    if (oneArgPerLine)
    { while (c != EOF  &&  c !='\r'  &&   c != '\n')
      { fillbuffer(ptr, c);
	c = hget;
      }
      *ptr = '\0';

      if (error)
      { return(FALSE);
      }

      if ((argVal = strchr(buffer, '=')))
      { *argVal++ = '\0';
      }
      else if ((argVal = strchr(buffer, ' ')))
      { *argVal++ = '\0';
	while(*argVal  &&  isspace(*argVal))
	{ argVal++;
	}
      }
      else
      { argVal = "";
      }
      argSeen = TRUE;
    }
    else
    { getarg;

      if ((argVal = strchr(buffer, '=')))
      { argSeen = TRUE;
	*argVal++ = '\0';
      }
      else
      { argSeen = FALSE;
      }
    }

    /**
    ***  Find argument
    **/
    { int i;

      for (thisArg = args, i = numArgs;
	   i;
	   --i, ++thisArg)
      { int j;
	STRPTR name;

	for (name = thisArg->argName, j = thisArg->numNames;
	     j;
	     --j, name += strlen((char *) name)+1)
	{ if (Stricmp(name, (STRPTR) buffer) == 0  ||
	      (*buffer == '-'  &&
	       Stricmp(name, (STRPTR) (buffer+1)) == 0))
	  { goto Found;
	  }
	}
      }

Found:
      if (!i)
      { /**
	***  Argument not found, ignore it
	**/
	continue;
      }

      if (thisArg->type != PARSEARGS_TYPE_BOOL  &&  !argSeen)
      { /**
	***  Check, if another argument follows
	**/
	while (isspace(c))
	{ c = hget;
	}

	if (c != EOF)
	{ argSeen = TRUE;
	  argVal = ptr;
	  getarg;
	}
	else
	{ if (!error)
	  { SetIoErr(ERROR_KEY_NEEDS_ARG);
	  }
	}
      }
    }

    if (error)
    { return(FALSE);
    }

    if (!AddArg(thisArg, argVal, argSeen))
    { return(FALSE);
    }

  }
  return(!error);
}
/**/


/*** ParseArgsA function
***/
ULONG ParseArgsA(int argc, char *argv[], struct TagItem *tags)

{ ULONG numArgs = 0;
  ULONG namesLen = 0;
  FILE *fp = NULL;
  struct TagItem *ti, *tiptr;
  Arg *args;
  char *helpString = NULL;
  int error = FALSE;

  /**
  ***  First scan of tags: Count the arguments
  **/
  tiptr = tags;
  while ((ti = NextTagItem(&tiptr)))
  { switch(ti->ti_Tag)
    { case PARSEARGS_ARGNAME:
	numArgs++;
	namesLen += strlen((char *) ti->ti_Data) + 1;
	break;
    }
  }

  if (numArgs == 0) /* Something wrong */
  { return(FALSE);
  }

  /**
  ***  Allocate the argument array
  **/
  if (!(args = malloc(sizeof(Arg)*numArgs + namesLen)))
  { return(FALSE);
  }

  /**
  ***  Second scan of tags: Initialize the argument array.
  **/
  tiptr = tags;
  { Arg *arg = &args[-1];
    char *namesPtr = (char *) &args[numArgs];

    while ((ti = NextTagItem(&tiptr)))
    { switch(ti->ti_Tag)
      { case PARSEARGS_ARGNAME:
	  { char *ptr;
	    int len;

	    arg++;
	    arg->argName = (STRPTR) (ptr = namesPtr);
	    strcpy((char *) arg->argName, (char *) ti->ti_Data);
	    len = strlen((char *) arg->argName);
	    namesPtr += len+1;

	    /**
	    ***  Count the number of names and separate them with NUL's.
	    ***  If the name string was looking like "SN=SHORTNAME",
	    ***  we store 'SN\0=SHORTNAME\0'.
	    **/
	    arg->numNames = 1;
	    while ((ptr = strchr(ptr, '=')))
	    { arg->numNames++;
	      *ptr++ = '\0';
	    }

	    arg->valPtr = NULL;
	    arg->type = PARSEARGS_TYPE_STRING;
	    arg->multiArgs = FALSE;
	    arg->required = FALSE;
	    arg->numMultiArgs = 0;
	    arg->maxMultiArgs = 0;
	    break;
	  }
	case PARSEARGS_TYPE:
	  arg->type = ti->ti_Data;
	  break;
	case PARSEARGS_VALPTR:
	  arg->valPtr = (APTR) ti->ti_Data;
	  break;
	case PARSEARGS_MULTIARG:
	  arg->multiArgs = ti->ti_Data;
	  break;
	case PARSEARGS_REQUIRED:
	  arg->required = ti->ti_Data;
	  break;
	case PARSEARGS_PREFSFILE:
	  if (!fp)      /* Open only one prefs file */
	  { fp = fopen((char *) ti->ti_Data, "r");
	  }
	  break;
	case PARSEARGS_HELPSTRING:
	  helpString = (char *) ti->ti_Data;
	  break;
      }
    }
  }

#ifdef DEBUG_ARGS
  kprintf("Default arguments:\n\n");
  DisplayArgs(args, numArgs);
#endif

  /**
  ***  Some initializations.
  **/
  { int i;
    Arg *arg;

    for (i = numArgs, arg = args;  i > 0;  --i, ++arg)
    { if (arg->type == PARSEARGS_TYPE_BOOL)
      { arg->multiArgs = FALSE;
      }
      else if (arg->multiArgs)
      { if (arg->valPtr)
	{ *arg->valPtr = NULL;
	}
      }
    }
  }

  /**
  ***  Parse the prefs file, if open.
  **/
  if (fp)
  { while(!feof(fp))
    { if (!DoParseArgs(args, numArgs, &ParseFileHook, fp, TRUE, TRUE))
      { error = TRUE;
	goto ExitParseArgs;
      }
    }
    fclose(fp);

#ifdef DEBUG_ARGS
    kprintf("\n\nPrefsfile arguments:\n\n");
    DisplayArgs(args, numArgs);
#endif
  }

  /**
  ***  Parse CLI args, if running from CLI.
  **/
  if (argc)
  { char *ptr = (char *) GetArgStr();

    while(isspace(*ptr))
    { ++ptr;
    }

    if (*ptr == '?'  &&  isspace(*(ptr+1)))     /*  User asked for help  */
    { if (helpString)
      { printf(helpString);
      }
      else
      { int i;
	Arg *arg;

	for (i = 0, arg = args;  i < numArgs;  i++, arg++)
	{ printf("%s", arg->argName);
	  switch(arg->type)
	  { case PARSEARGS_TYPE_STRING:
	      printf("/K");
	      break;
	    case PARSEARGS_TYPE_BOOL:
	      printf("/T");
	      break;
	    case PARSEARGS_TYPE_INTEGER:
	      printf("/K/N");
	      break;
	    case PARSEARGS_TYPE_FLOAT:
	      printf("/K (float value)");
	      break;
	  }
	}
      }

      if (!DoParseArgs(args, numArgs, &ParseFileHook, stdin, FALSE, FALSE))
      { error = TRUE;
	goto ExitParseArgs;
      }
    }
    else
    { if (!DoParseArgs(args, numArgs, &ParseStringHook, ptr, FALSE, FALSE))
      { error = TRUE;
	goto ExitParseArgs;
      }
    }
#ifdef DEBUG_ARGS
    kprintf("\n\nCLI arguments:\n\n");
    DisplayArgs(args, numArgs);
#endif
  }
  else  /**
	***  Parse toolkit options, if running from workbench
	**/
  { struct WBStartup *wbenchMsg = (struct WBStartup *) argv;
    struct WBArg *wbarg;
    int i;

    for (i = 0, wbarg = wbenchMsg->sm_ArgList;
	 i < wbenchMsg->sm_NumArgs;
	 i++, wbarg++)
    { BPTR oldDir = (BPTR) NULL; /* Suppress uninitialized warnings */
      ULONG oldDirValid = FALSE;
      struct DiskObject *dobj;

      if (wbarg->wa_Lock)
      { oldDir = CurrentDir(wbarg->wa_Lock);
	oldDirValid = TRUE;
      }

      if (*wbarg->wa_Name  &&
	  (dobj = GetDiskObject((STRPTR) wbarg->wa_Name)))
      { char **toolarray;

	for (toolarray = dobj->do_ToolTypes;  *toolarray;  ++toolarray)
	{ if (!DoParseArgs(args, numArgs, &ParseStringHook, *toolarray, TRUE, TRUE))
	  { error = TRUE;
	    break;
	  }
	}
	FreeDiskObject(dobj);
      }

      if (oldDirValid)
      { CurrentDir(oldDir);
      }
    }

#ifdef DEBUG_ARGS
    kprintf("\n\nWorkbench arguments:\n\n");
    DisplayArgs(args, numArgs);
#endif
  }

  { int i;
    Arg *arg;

    for (i = numArgs, arg = args;  i > 0;  i--, arg++)
    { if (arg->required)
      { SetIoErr(ERROR_REQUIRED_ARG_MISSING);
	break;
      }
    }
  }

ExitParseArgs:

#ifdef DEBUG_ARGS
  if (error)
  { kprintf("Error %ld while parsing arguments.\n", IoErr());
  }
#endif
  return(!error);
}
/**/


/*** ParseArgs function
***/
ULONG ParseArgs(int argc, char *argv[], Tag FirstTag, ...)

{ return(ParseArgsA(argc, argv, (struct TagItem *) &FirstTag));
}
/**/
