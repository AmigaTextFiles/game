/*
 * Copyright (C) 2005 Mark Olsen
 * Copyright (C) 2010 Krzysztof Smiechowicz
 * Copyright (C) 2012 Szilard Biro
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#include <exec/exec.h>
#include <intuition/intuition.h>
#include <dos/dosextens.h>

#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/dos.h>

#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

//#include "../dll/dll.h"
#include <dll.h>

#include "../game/q_shared.h"
#include "../qcommon/qcommon.h"
#include "../renderer/tr_public.h"

void IN_Shutdown(void);
void IN_Init(void);
int IN_GetEvent(sysEvent_t *ev);
// AROS
char *FS_BuildOSPath(const char *base, const char *game, const char *qpath);
qboolean Sys_GetPacket(netadr_t *net_from, msg_t *net_message);
void Sys_SetDefaultCDPath(const char *path);

#include "aros_glimp.h"

#undef vsnprintf

#define MAXIMSGS 32

#ifdef DEDICATED
#define BINNAME "rtcw-sp"
#else
#define BINNAME "rtcwded-sp"
#endif

const char verstring[] = "$VER: "BINNAME" 1.0 (15.8.2010) AROS port based on MorphOS port by Mark Olsen";

static int consoleinput;
static int consoleoutput;
static int consoleoutputinteractive;

static BPTR olddir;

struct Library *SocketBase;

/* For NET_Sleep */
int stdin_active = 0;

static char *pakfiles[] =
{
	"main/pak0.pk3",
	"main/sp_pak1.pk3",
	"main/sp_pak2.pk3",
	"main/sp_pak3.pk3",
	0
};

void Sys_Quit()
{
	CL_Shutdown();
	IN_Shutdown();

	if (SocketBase)
		CloseLibrary(SocketBase);

	if (consoleinput && consoleoutputinteractive)
		SetMode(Input(), 0);

	if (olddir)
	{
		UnLock(CurrentDir(olddir));
	}

	exit(0);
}

static void ErrorMessage(char *string)
{
	char msg[4096];

	snprintf(msg, sizeof(msg), "%s", string);

	if (consoleoutput)
		fprintf(stderr, "%s\n", msg);
	else
	{
		struct EasyStruct es;

		if (msg[strlen(msg)-1] == '\n')
			msg[strlen(msg)-1] = 0;

		es.es_StructSize = sizeof(es);
		es.es_Flags = 0;
		es.es_Title = "Return to Castle Wolfenstein";
		es.es_TextFormat = msg;
		es.es_GadgetFormat = "Quit";

		EasyRequest(0, &es, 0, 0);
	}
}

void Sys_Error(const char *fmt, ...)
{
	va_list va;
	char msg[4096];

	strcpy(msg, "Sys_Error: ");

	va_start(va, fmt);
	vsnprintf(msg+strlen(msg), sizeof(msg)-strlen(msg), fmt, va);
	va_end(va);

	ErrorMessage(msg);

	Sys_Quit();
}

void Sys_Print(const char *msg)
{
	if (consoleoutput)
		fputs(msg, stdout);
}

qboolean Sys_LowPhysicalMemory()
{
	/* This is only used for touching memory, there's really no need for that... */

	return qtrue;
}

void Sys_BeginProfiling()
{
}

void Sys_InitStreamThread()
{
}

void Sys_ShutdownStreamThread()
{
}

void Sys_BeginStreamedFile(fileHandle_t f, int readAhead)
{
}

void Sys_EndStreamedFile(fileHandle_t f)
{
}

int Sys_StreamedRead(void *buffer, int size, int count, fileHandle_t f)
{
	return FS_Read( buffer, size * count, f );
}

void Sys_StreamSeek(fileHandle_t f, int offset, int origin)
{
	FS_Seek(f, offset, origin);
}

char *Sys_GetClipboardData()
{
	return 0;
}

int putenv __P((const char *name))
{
	return 1;
}

sysEvent_t Sys_GetEvent()
{
	sysEvent_t ev;
	static char inbuf[256];
	static int inbufsize;

	msg_t netmsg;
	byte netpacket[MAX_MSGLEN];
	netadr_t adr;

	memset(&ev, 0, sizeof(ev));
	ev.evTime = Sys_Milliseconds();

#ifndef DEDICATED
	if (IN_GetEvent(&ev))
		return ev;
#endif

	if (consoleinput && consoleoutputinteractive)
	{
		while(WaitForChar(Input(), 0) && Read(Input(), inbuf+inbufsize, 10) == 1)
		{
			if (inbuf[inbufsize] == 3)
			{
				Signal(FindTask(0), SIGBREAKF_CTRL_C);
				continue;
			}

			if (inbuf[inbufsize] == 8 && inbufsize != 0)
			{
				FPutC(Output(), 8);
				FPutC(Output(), ' ');
				FPutC(Output(), 8);
				Flush(Output());
				inbufsize--;
				continue;
			}

			if (inbuf[inbufsize] == '\r')
				inbuf[inbufsize] = '\n';
			else if (!isprint(inbuf[inbufsize]))
				continue;

			FPutC(Output(), inbuf[inbufsize]);
			Flush(Output());
			inbufsize++;
			if (inbuf[inbufsize-1] == '\n' || inbufsize == sizeof(inbuf)-11)
			{
				inbuf[inbufsize] = 0;
				ev.evType = SE_CONSOLE;
				ev.evPtr = Z_Malloc(inbufsize+1);
				ev.evPtrLength = inbufsize+1;

				strcpy(ev.evPtr, inbuf);

				inbufsize = 0;

				return ev;
			}
		}
	}
	else if (consoleinput)
	{
		while(WaitForChar(Input(), 0))
		{
			if (FGets(Input(), inbuf, sizeof(inbuf)))
			{
				ev.evType = SE_CONSOLE;
				ev.evPtr = Z_Malloc(strlen(inbuf)+1);
				ev.evPtrLength = strlen(inbuf)+1;

				strcpy(ev.evPtr, inbuf);

				return ev;
			}
		}
	}

	MSG_Init(&netmsg, netpacket, sizeof(netpacket));
	if (Sys_GetPacket(&adr, &netmsg))
	{
		netadr_t *buf;
		int len;

		len = sizeof(netadr_t) + netmsg.cursize;
		buf = Z_Malloc( len );
		*buf = adr;
		memcpy( buf+1, netmsg.data, netmsg.cursize );
		ev.evType = SE_PACKET;
		ev.evPtr = buf;
		ev.evPtrLength = len;

		return ev;
	}

	return ev;
}

qboolean Sys_CheckCD()
{
	return qtrue;
}

char *Sys_GetDLLName(const char *name)
{
	return va("%s_aros_i386.dll", name);
}

void *Sys_LoadDll(const char *name, int (**entryPoint)(int, ...), struct SharedObjectSegments *sos)
{
	void *handle;
	char fname[MAX_OSPATH];
	char *basepath;
	char *gamedir;
	char *fn;
	void (*dllEntry)(int (*syscallptr)(int, ...)); // this isn't even used in Sys_LoadDll, but whatever...

	Q_strncpyz(fname, Sys_GetDLLName(name), sizeof(fname));

	basepath = Cvar_VariableString( "fs_basepath" );
	gamedir = Cvar_VariableString( "fs_game" );

	fn = FS_BuildOSPath( basepath, "", fname );
	Com_Printf( "Sys_LoadDll(%s)...\n", fn );

    //Com_Printf("name: %s, fname: %s, fn: %s\n", name, fname, fn);

	handle = dllLoadLibrary( fn, (char *)fname );

	if (handle == 0)
	{
		Com_Printf("Sys_LoadDll: Failed to load \"%s\"\n", fn);
	}
	else
	{
		// do we need dllEntry here?
		dllEntry = dllGetProcAddress(handle, "dllEntry");
		*entryPoint = dllGetProcAddress( handle, "vmMain");

		if (dllEntry == 0 || *entryPoint == 0)
		{
			Com_Printf("Sys_LoadDll: Missing symbols\n");
		}
		else
		{
			return handle;
		}

		dllFreeLibrary(handle);
	}

	return 0;
}

void Sys_UnloadDll(void *handle)
{
	dllFreeLibrary(handle);	
}

qboolean Sys_InitDll(void *handle, int (*systemcalls)(int, ...))
{
	void (*dllEntry)(int (*syscallptr)(int, ...));

	dllEntry = dllGetProcAddress(handle, "dllEntry");
	if (dllEntry)
	{
		dllEntry(systemcalls);
		return qtrue;
	}

	return qfalse;
}

void Sys_DeinitDll(void *handle)
{
}


static char *ProcessorName()
{
	return "Unknown";
}

void Sys_Init()
{
	Cvar_Set("arch", "aros i386");

	Cvar_Set("sys_cpustring", ProcessorName());

	IN_Init();
}

int main(int argc, char **argv)
{
	int i, len;

	char *cmdline;

	BPTR l;

    struct WBStartup * _WBenchMsg = NULL;
    if (argc == 0)
        _WBenchMsg = (struct WBStartup *)argv;

	BPTR lock;

	if (!_WBenchMsg)
	{
		consoleoutput = 1;
		if (IsInteractive(Output()))
			consoleoutputinteractive = 1;
	}

	l = Lock("PROGDIR:", ACCESS_READ);
	if (l)
		olddir = CurrentDir(l);

	for(i=0;pakfiles[i] != 0;i++)
	{
		lock = Lock(pakfiles[i], ACCESS_READ);
		if (lock)
			UnLock(lock);
		else
			break;
	}

	if (pakfiles[i] != 0)
	{
		ErrorMessage("Incomplete installation. Please run the installer.\n");
		return 0;
	}

	signal(SIGINT, SIG_IGN);

	SocketBase = OpenLibrary("bsdsocket.library", 0);
#ifdef DEDICATED
	if (SocketBase == 0)
	{
		printf("Unable to open bsdsocket.library\n");
		return 0;
	}
#endif

	Sys_SetDefaultCDPath(argv[0]);

	len = 1;
	for(i=1;i<argc;i++)
		len+= strlen(argv[i])+1;

	cmdline = malloc(len);
	if (cmdline == 0)
		Sys_Quit();

	cmdline[0] = 0;

	for(i=1;i<argc;i++)
	{
		strcat(cmdline, argv[i]);
		if (i != argc-1)
			strcat(cmdline, " ");
	}

	Com_Init(cmdline);

	if (SocketBase)
		NET_Init();

	if (!_WBenchMsg && com_dedicated && com_dedicated->value && IsInteractive(Input()))
	{
		consoleinput = 1;
		if (consoleoutputinteractive)
			SetMode(Input(), 1);
	}

	while((SetSignal(0, 0)&SIGBREAKF_CTRL_C) == 0)
	{
		Com_Frame();
#ifndef DEDICATED
		GLimp_Frame();
#endif
	}

	Sys_Quit();

	return 0;
}

qboolean Sys_IsNumLockDown(void)
{
	return qfalse;
}

void Sys_OpenURL(char *url, qboolean doexit)
{
}

void Sys_StartProcess(char *cmdline, qboolean doexit)
{
}
