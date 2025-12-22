#include <exec/exec.h>
#include <rexx/rxslib.h>

#include <proto/exec.h>
#include <proto/rexxsyslib.h>

#include "quakedef.h"
#include "mp3_player.h"

cvar_t mp3_dir = {"mp3_anr_dir", ""};

/* Local functions */

static qboolean IsPlayerRunning()
{
	return (qboolean)FindPort("AMINETRADIO.1");
}

static qboolean SendANRMessage(char *string, void **result)
{
	struct Library *RexxSysBase;
	struct MsgPort *port, *dport;
	struct RexxMsg *rxmsg;
	qboolean success = 0;
	static char buf[256];
	int vidlocked;

	vidlocked = VID_IsLocked();

	if (vidlocked)
		VID_UnlockBuffer(); /* Let's prevent some deadlocks :P */

	RexxSysBase = OpenLibrary("rexxsyslib.library", 0);
	if (RexxSysBase)
	{
		port = CreateMsgPort();
		if (port)
		{
			port->mp_Node.ln_Name = "";

			rxmsg = CreateRexxMsg(port, "rexx", "");
			if (rxmsg)
			{
				rxmsg->rm_Action = RXCOMM|(result?RXFF_RESULT:0);
				rxmsg->rm_Args[0] = string;
				rxmsg->rm_Args[1] = (void *)strlen(string);

				Forbid();
				dport = FindPort("AMINETRADIO.1");
				if (dport)
				{
					PutMsg(dport, (struct Message *)rxmsg);
					Permit();

					success = 1;

					while(GetMsg(port) == 0)
						WaitPort(port);

					if (result)
					{
						strncpy(buf, (char *)rxmsg->rm_Result2, 255);
						buf[255] = 0;
						*result = (void *)buf;
					}
				}
				else
				{
					Permit();
				}

				DeleteRexxMsg(rxmsg);
			}

			DeleteMsgPort(port);
		}

		CloseLibrary(RexxSysBase);
	}

	if (vidlocked)
		VID_LockBuffer();

	return success;
}

/* Externally called functions */

void ANR_Execute_f()
{
	Com_Printf("Unable to execute AmiNetRadio\n");
}

void ANR_Prev_f()
{
	SendANRMessage("PLAY PREV", 0);
}

void ANR_Play_f()
{
	SendANRMessage("PLAY", 0);
}

void ANR_Pause_f()
{
	SendANRMessage("PAUSE", 0);
}

void ANR_Stop_f()
{
	SendANRMessage("STOP", 0);
}

void ANR_Next_f()
{
	SendANRMessage("PLAY NEXT", 0);
}

void ANR_FadeOut_f()
{
}

void ANR_FastForward_f()
{
}

void ANR_Rewind_f()
{
	SendANRMessage("PLAY", 0);
}

int ANR_GetStatus()
{
	void *p;
	int i;

	if (SendANRMessage("PLAYSTATE", &p) != 0)
	{
		i = atoi(p);

		if (i == 1)
			return MP3_PLAYING;
		else if (i == 2)
			return MP3_PAUSED;
		else
			return MP3_STOPPED;
	}
	else
	{
		return MP3_NOTRUNNING;
	}
}

qboolean ANR_OnChange_mp3_volume(cvar_t *var, char *s)
{
	int volume;
	char string[12];

	volume = Q_atof(s)*100;
	if (volume < 0)
		volume = 0;
	else if (volume > 130)
		volume = 130;

	snprintf(string, 12, "VOLUME %d", volume);

	SendANRMessage(string, 0);

	return false;
}

void ANR_Repeat_f()
{
}

void ANR_Shuffle_f()
{
}

void ANR_ToggleRepeat_f()
{
	SendANRMessage("SONGREPEAT TOGGLE", 0);
}

void ANR_ToggleShuffle_f()
{
	SendANRMessage("SHUFFLE TOGGLE", 0);
}

char *ANR_Macro_MP3Info()
{
	void *p;
	int r;
	static char buf[256];

	r = SendANRMessage("CURRENTSONG", &p);
	if (r)
	{
		strncpy(buf, p, 255);
		buf[255] = 0;
	}
	else
		buf[0] = 0;

	return buf;
}

qboolean ANR_GetOutputtime(int *elapsed, int *total)
{
	void *p;

	if (SendANRMessage("TIME", &p) != 0)
	{
		*elapsed = atoi(p);
		if (SendANRMessage("DURATION", &p) != 0)
		{
			*total = atoi(p);
			return 1;
		}
	}


	return 0;
}

qboolean ANR_GetToggleState(int *shuffle, int *repeat)
{
	void *p;

	if (SendANRMessage("SHUFFLE", &p) != 0)
	{
		*shuffle = atoi(p);

		if (SendANRMessage("SONGREPEAT", &p) != 0)
		{
			*repeat = atoi(p);
			return 1;
		}
	}

	return 0;
}

void ANR_GetPlaylistInfo(int *current, int *length)
{
	return;
}

void ANR_PrintPlaylist_f()
{
}

void ANR_PlayTrackNum_f()
{
}

void ANR_SongInfo_f()
{
}

void ANR_LoadPlaylist_f()
{
}

char *ANR_Menu_SongtTitle()
{
	return ANR_Macro_MP3Info();
}

