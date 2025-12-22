#include <exec/exec.h>
#include <rexx/rxslib.h>

#include <proto/exec.h>
#include <proto/rexxsyslib.h>

#include "quakedef.h"
#include "mp3_player.h"

/* Local functions */

static qboolean SendAmplifierMessage(char *string, void **result)
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
				dport = FindPort("AMPLIFIER.1");
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

void Amplifier_Execute_f()
{
	Com_Printf("Unable to execute Amplifier\n");
}

void Amplifier_Prev_f()
{
	SendAmplifierMessage("PLAYPREV", 0);
}

void Amplifier_Play_f()
{
	SendAmplifierMessage("PLAY", 0);
}

void Amplifier_Pause_f()
{
	SendAmplifierMessage("PLAYPAUSE", 0);
}

void Amplifier_Stop_f()
{
	SendAmplifierMessage("STOP", 0);
}

void Amplifier_Next_f()
{
	SendAmplifierMessage("PLAYNEXT", 0);
}

void Amplifier_FadeOut_f()
{
}

void Amplifier_FastForward_f()
{
	void *p;
	int i;
	char buf[12];

	if (SendAmplifierMessage("GETTIME", &p) != 0)
	{
		i = atoi(p);

		i+= 5;

		snprintf(buf, 12, "SEEK %d", i);

		SendAmplifierMessage(buf, 0);
	}
}

void Amplifier_Rewind_f()
{
	SendAmplifierMessage("STOP", 0);
	SendAmplifierMessage("PLAY", 0);
}

int Amplifier_GetStatus()
{
	void *p;
	int i;

	if (SendAmplifierMessage("PLAYSTATE", &p) != 0)
	{
		i = atoi(p);

		if (i == 3)
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

qboolean Amplifier_OnChange_mp3_volume(cvar_t *var, char *s)
{
	return false;
}

void Amplifier_Repeat_f()
{
}

void Amplifier_Shuffle_f()
{
}

void Amplifier_ToggleRepeat_f()
{
	SendAmplifierMessage("SONGREPEAT TOGGLE", 0);
}

void Amplifier_ToggleShuffle_f()
{
	SendAmplifierMessage("SHUFFLE TOGGLE", 0);
}

char *Amplifier_Macro_MP3Info()
{
	return "Amplifier_Macro_MP3Info";
}

qboolean Amplifier_GetOutputtime(int *elapsed, int *total)
{
	void *p;

	if (SendAmplifierMessage("GETTIME", &p) != 0)
	{
		*elapsed = atoi(p);
		if (SendAmplifierMessage("GETLENGTH", &p) != 0)
		{
			*total = atoi(p);
			return 1;
		}
	}


	return 0;
}

qboolean Amplifier_GetToggleState(int *shuffle, int *repeat)
{
	void *p;

	if (SendAmplifierMessage("RANDOM", &p) != 0)
	{
		*shuffle = atoi(p);

		if (SendAmplifierMessage("REPEAT", &p) != 0)
		{
			*repeat = atoi(p);
			return 1;
		}
	}

	return 0;
}

void Amplifier_GetPlaylistInfo(int *current, int *length)
{
}

void Amplifier_PrintPlaylist_f()
{
}

void Amplifier_PlayTrackNum_f()
{
}

void Amplifier_SongInfo_f()
{
}

void Amplifier_LoadPlaylist_f()
{
}

char *Amplifier_Menu_SongtTitle()
{
	return "Amplifier_Menu_SongtTitle";
}

