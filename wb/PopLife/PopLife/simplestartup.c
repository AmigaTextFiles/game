#define WB_PARSE		/* Look at the WINDOW tooltype */
#undef  WB_OPEN_NIL		/* Just open NIL: for io if started from Workbench */
#undef  WB_CLOSE_FILES	/* This should normally be set if one of the other */
						/* WB_ flags is */
#undef  CLI_PARSE 		/* Do CLI argument parsing */

/*
 *	This is a simplified startup module for Manx. The only extra module
 *	that is linked is crt0.
 *
 *	This module does NOT support each of the following:
 *	. stdin, stdout, stderr. Use Input() and Output() instead. Don't Close
 *	  these files yourself, however: they are only lended to you.
 *	. Cleanup of malloc()ed memory on exit.
 *
 *	It supports optionally:
 *	. CLI command line parsing: argc, argv.
 *	. Opening window via the WINDOW tooltypes entry, and closing it on exit.
 *
 *	It DOES support:
 *	. CloseLibrary on DOSBase, MathBase, MathTransBase, MathIeeeDoubBasBase,
 *	  if non-NULL.
 *
 *	You can link extra cleanup modules before the rest of exit(), by
 *	setting _cln to your routine, and saving the previous value of _cln.
 *	If it is non-NULL, call it after you have done your extra cleanup.
 *  This pointer is normally used (and ruthlessly overwritten) by malloc().
 */

#include <functions.h>

#include <exec/alerts.h>
#include <exec/memory.h>
#include <libraries/dosextens.h>
/* #include <workbench/icon.h> */
#include <workbench/workbench.h>
#include <workbench/startup.h>


void *SysBase, *DOSBase;
void  *MathBase, *MathTransBase, *MathIeeeDoubBasBase;
void *IconBase;

long _savsp, _stkbase;	/* Initial SP, and stack base */

long   _argcli;		/* Pointer to CLI structure, or NULL (wb) */
char **_argv;		/* Standard C argv (when parsed) */
					/* or (char *)initial-A0 (when not parsed) */
					/* or copy of WBenchMsg (when WorkBench) */
int    _argc;		/* Number of arguments (when parsed) */
					/* or -1 (when not parsed) */
					/* or 0  (when WorkBench) */
int    _arg_len;	/* Length of reconstructed command line (when parsed) */
					/* or length of argument part only (D0) (when not parsed) */
					/* or 0 (when WorkBench) */

struct WBStartup *WBenchMsg;	/* Our Workbench startup message */


#ifdef WB_OPEN_NIL
static char nilname[] = "NIL:";
#else
# ifdef WB_PARSE
static char nilname[] = "NIL:";
# endif
#endif

/*
 *	This routine is called from the _main() routine and is used to
 *	open a window for standard I/O to use. The window is actually
 *	defined by setting the ToolType, "WINDOW", to the desired window
 *	specification. If this is not required, this routine may be
 *	replaced by a stub in the users main program. Note that even if
 *	this code is called by _main(), if the WINDOW tool type is not
 *	defined, there will be no window.
 *
 *	EXAMPLE:	WINDOW=CON:0/0/640/200/Test Window
 */


#ifdef WB_PARSE

_wb_parse(pp, wbm)
register struct Process *pp;
struct WBStartup *wbm;
{
	register char *cp;
	register struct DiskObject *dop;
	register struct FileHandle *fhp;
	register long wind;
	void *_OpenLibrary();
	long _Open();

	if ((IconBase = _OpenLibrary("icon.library", 0L)) == 0)
		return;
	if ((dop = GetDiskObject(wbm->sm_ArgList->wa_Name)) == 0)
		goto closeit;
	if ( (cp = FindToolType(dop->do_ToolTypes, "WINDOW")) && 
		(wind = _Open(cp, MODE_OLDFILE)) )
	{
		fhp = (struct FileHandle *) (wind << 2);
		pp->pr_ConsoleTask = (APTR) fhp->fh_Type;
		pp->pr_CIS = (BPTR) wind;
		pp->pr_COS = (BPTR) _Open("*", MODE_OLDFILE);
	} else {
		pp->pr_CIS = (BPTR)  _Open(nilname, MODE_OLDFILE);
		pp->pr_COS = (BPTR)  _Open(nilname, MODE_OLDFILE);
	}
	FreeDiskObject(dop);
closeit:
	CloseLibrary(IconBase);
	IconBase = 0;
}

#endif /* WB_PARSE */


#ifdef CLI_PARSE

/*
 *	This routine is called from the _main() routine and is used to
 *	parse the arguments passed from the CLI to the program. It sets
 *	up an array of pointers to arguments in the global variables and
 *	and sets up _argc and _argv which will be passed by _main() to
 *	the main() procedure. If no arguments are ever going to be
 *	parsed, this routine may be replaced by a stub routine to reduce
 *	program size.
 *
 *	If _arg_lin is non-zero, the _exit() routine will call FreeMem()
 *	with _arg_lin as the memory to free and _arg_len as the size.
 *
 */

char *_arg_lin;

_cli_parse(pp, alen, aptr)
struct Process *pp;
long alen;
register char *aptr;
{
	register char *cp;
	register struct CommandLineInterface *cli;
	register int c;
	void *_AllocMem();

	cli = (struct CommandLineInterface *)_argcli;
	cp = (char *)((long)cli->cli_CommandName << 2);
	_arg_len = cp[0]+alen+2;
	if ((_arg_lin = _AllocMem((long)_arg_len, 0L)) == 0)
		return;
	strncpy(_arg_lin, cp+1, cp[0]);
	strcpy(_arg_lin+cp[0], " ");
	strncat(_arg_lin, aptr, (int)alen);
	for (_argc = 0, aptr = cp = _arg_lin; ;_argc++) {
		while ((c=*cp) == ' ' || c == '\t' || c == '\f' ||
				c == '\r' || c == '\n') /* Skip white space */
			cp++;
		if (*cp < ' ')
			break;					/* End of line */
		if (*cp == '"') {
			cp++;					/* Quoted argument */
			while (c = *cp++) {		/* Until end of line */
				*aptr++ = c;
				if (c == '"') {		/* Another quote */
					if (*cp == '"') { /* "" is an imbedded quote */
						cp++;
					} else {
						aptr[-1] = 0; /* End of quoted argument */
						break;
					}	/* end looking at next char */
				}	/* end if second quote */
			}	/* end while */
		}	/* end if first quote */
		else {	/* not a quote */
			while ((c=*cp++) && c != ' ' && c != '\t' && c != '\f' &&
					c != '\r' && c != '\n')	/* Skip until next white space */
				*aptr++ = c;
			*aptr++ = 0;			/* Null-terminate a word */
		}
		if (c == 0)					/* At end of line */
			--cp;					/* backup to the null byte */
	}
	*aptr = 0;
	if ((_argv = _AllocMem((long)(_argc+1)*sizeof(*_argv), 0L)) == 0) {
		_argc = 0;
		return;
	}
	for (c=0, cp=_arg_lin; c < _argc; c++) {
		_argv[c] = cp;				/* Build array of pointers to arguments */
		cp += strlen(cp) + 1;
	}
	_argv[c] = 0;					/* Null-terminate it */
}

#endif /* CLI_PARSE */

/*
 *	This is common startup code for both the CLI and the WorkBench,
 *  parsed or not.
 */

_main(alen, aptr)
long alen;
char *aptr;
{
	register struct Process *pp, *_FindTask();
	void *_OpenLibrary(), *_GetMsg(), *_AllocMem();
	long _Input(), _Output(), _Open();

	_stkbase = _savsp - *((long *)_savsp+1) + 8;

	pp = _FindTask(0L);
	
	if (_argcli = pp->pr_CLI << 2) {
#ifdef CLI_PARSE
		_cli_parse(pp, alen, aptr);
#else
		_argv = (char **)aptr;
		_arg_len = alen;	/* Will not be deallocated since not CLI_PARSE */
		_argc = -1;			/* Who would use this ?? */
		aptr[alen - 1] = '\0';	/* Null-termination is easy */
#endif /* CLI_PARSE */
	} else {
		_WaitPort(&pp->pr_MsgPort);
		WBenchMsg = _GetMsg(&pp->pr_MsgPort);
		if (WBenchMsg->sm_ArgList)
			_CurrentDir(WBenchMsg->sm_ArgList->wa_Lock);
#ifdef WB_PARSE
		_wb_parse(pp, WBenchMsg);	/* May open window */
#else
# ifdef WB_OPEN_NIL
		pp->pr_CIS = (BPTR) _Open(nilname, MODE_OLDFILE);
		pp->pr_COS = (BPTR) _Open(nilname, MODE_OLDFILE);
# endif
#endif
		_argv = (char **)WBenchMsg;
		_arg_len = 0;
	}

	main(_argc, _argv, _argcli);	/* _argcli is sort of environment... */

	exit(0);						/* This IS necessary! */
}



void (*_cln)();

exit(code)
{
	long ret = code;
	register struct Process *pp, *_FindTask();

	if (_cln)
		(*_cln)();

	if (MathTransBase)
		_CloseLibrary(MathTransBase);
	if (MathBase)
		_CloseLibrary(MathBase);
	if (MathIeeeDoubBasBase)
		_CloseLibrary(MathIeeeDoubBasBase);
	{
#asm
	mc68881
	move.l	4,a6				;get ExecBase
	btst.b	#4,$129(a6)			;check for 68881 flag in AttnFlags
	beq		1$					;skip if not
	move.l	a5,-(sp)
	lea		2$,a5
	jsr		-30(a6)				;do it in supervisor mode
	move.l	(sp)+,a5
	bra		1$
2$
	clr.l	-(sp)
	frestore (sp)+				;reset the ffp stuff
	rte							;and return
1$
#endasm
	}
	if (WBenchMsg == 0) {
#ifdef CLI_PARSE
		if (_arg_len) {
			_FreeMem(_arg_lin, (long)_arg_len);
			_FreeMem(_argv, (long)(_argc+1)*sizeof(*_argv));
		}
#endif
	} else {
#ifdef WB_CLOSE_FILES
		pp = _FindTask(0L);
		Close(pp->pr_CIS);	/* Close window opened by startup code */
		Close(pp->pr_CIS);	/* or maybe just NIL: files */
#endif
		_Forbid();
		_ReplyMsg(WBenchMsg);
	}
	if (DOSBase)
		_CloseLibrary(DOSBase);
	{
#asm
		move.l	-4(a5),d0		;pick up return exit code
		move.l	__savsp#,sp		;get back original stack pointer
		rts						;and exit
#endasm
	}
}

