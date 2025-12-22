#include "main.h"

typedef struct {
	NODE node;
	struct AHIRequest *io;
	int busy;
} channel;

static struct MsgPort *AHImp;
static LIST AHIchan;

channel *AllocChan ();
void FreeChan (channel *ch);

int InitAudioEngine () {
	int numChannels;
	channel *ch;
	numChannels = CFGInteger("CHANNELS", 4);
	AHImp = CreateMsgPort();
	if (!AHImp) return FALSE;
	NewMinList(&AHIchan);
	while (numChannels--) {
		ch = AllocChan();
		if (!ch) {
			CleanupAudioEngine();
			return FALSE;
		}
		AddTail((struct List *)&AHIchan, (struct Node *)ch);
	}
	return TRUE;
}

void CleanupAudioEngine () {
	channel *ch;
	while (ch = (channel *)RemHead((struct List *)&AHIchan)) FreeChan(ch);
	DeleteMsgPort(AHImp);
}

channel *AllocChan () {
	channel *ch;
	struct AHIRequest *io;

	ch = CreateNode(sizeof(channel));
	if (!ch) return NULL;

	ch->io = io = (struct AHIRequest *)CreateIORequest(AHImp, sizeof(struct AHIRequest));
	if (io) {
		io->ahir_Version = 6;
		if (!OpenDevice("ahi.device", AHI_DEFAULT_UNIT, (struct IORequest *)io, 0))
			return ch;
		else
			io->ahir_Std.io_Device = NULL;
	}

	FreeChan(ch);
	return NULL;
}

void FreeChan (channel *ch) {
	struct AHIRequest *io;
	if (!ch) return;
	io = ch->io;
	if (io) {
		if (io->ahir_Std.io_Device) {
			if (ch->busy) {
				if (!CheckIO((struct IORequest *)io)) AbortIO((struct IORequest *)io);
				WaitIO((struct IORequest *)io);
			}
			CloseDevice((struct IORequest *)io);
		}
		DeleteIORequest((struct IORequest *)io);
	}
	DeleteNode(ch);
}

sound *LoadSnd (char *name) {
	sound *snd;
	snd = LoadSnd_WAV(name);
	if (snd) {
		if (snd->channels == 1) {
			switch (snd->samplesize) {
				case 8:
					snd->type = AHIST_M8S;
					break;
				case 16:
					snd->type = AHIST_M16S;
					break;
				case 32:
					snd->type = AHIST_M32S;
					break;
			}
		} else {
			switch (snd->samplesize) {
				case 8:
					snd->type = AHIST_S8S;
					break;
				case 16:
					snd->type = AHIST_S16S;
					break;
				case 32:
					snd->type = AHIST_S32S;
					break;
			}
		}
		#if 0
		{
			BPTR file;
			file = Open("RAM:crap", MODE_NEWFILE);
			if (file) {
				Write(file, snd->samples, snd->length);
				Close(file);
			}
		}
		#endif
	}
	return snd;
}

void FreeSnd (sound *snd) {
	if (!snd) return;
	FreeVec(snd->samples);
	FreeMem(snd, sizeof(*snd));
}

sound **LoadSndArray (char **filenames) {
	sound **array;
	char **name;
	int32 i, num;
	for (name = filenames, num = 0; *name; name++) num++;
	array = AllocVec(sizeof(uint32) + sizeof(APTR)*(num+1), MEMF_ANY|MEMF_CLEAR);
	if (array) {
		*(uint32 *)array = num;
		array = (sound **)((uint32 *)array + 1);
		
		for (i = 0; i < num; i++) {
			array[i] = LoadSnd(filenames[i]);
			if (!array[i]) {
				FreeSndArray(array);
				return NULL;
			}
		}
	}
	return array;
}

void FreeSndArray (sound **array) {
	sound **tmp;
	if (!array) return;
	for (tmp = array; *tmp; tmp++) FreeSnd(*tmp);
	FreeVec((uint32 *)array - 1);
}

static void SoundIO () {
	struct Message *msg;
	channel *ch, *nch;
	while (msg = GetMsg(AHImp)) {
		for (ch = (channel *)AHIchan.mlh_Head; nch = (channel *)ch->node.mln_Succ; ch = nch) {
			if (ch->io == (struct AHIRequest *)msg) {
				ch->busy = FALSE;
				Remove((struct Node *)ch);
				AddHead((struct List *)&AHIchan, (struct Node *)ch);
				break;
			}
		}
	}
}

void PlaySnd (sound *snd, int32 volume, int32 position) {
	channel *ch;
	struct AHIRequest *io;
	SoundIO();
	ch = (channel *)AHIchan.mlh_Head;
	io = ch->io;
	if (ch->busy) {
		io = ch->io;
		if (!CheckIO((struct IORequest *)io)) AbortIO((struct IORequest *)io);
		WaitIO((struct IORequest *)io);
		ch->busy = FALSE;
	}
	io->ahir_Std.io_Command = CMD_WRITE;
	io->ahir_Std.io_Data = snd->samples;
	io->ahir_Std.io_Length = snd->length*(snd->samplesize >> 3)*snd->channels;
	io->ahir_Std.io_Offset = 0;
	io->ahir_Type = snd->type;
	io->ahir_Frequency = snd->freq;
	io->ahir_Volume = volume;
	io->ahir_Position = position;
	BeginIO((struct IORequest *)io);
	ch->busy = TRUE;
	Remove((struct Node *)ch);
	AddTail((struct List *)&AHIchan, (struct Node *)ch);
}

void StopSnd () {
	channel *ch, *nch;
	struct AHIRequest *io;
	for (ch = (channel *)AHIchan.mlh_Head; nch = (channel *)ch->node.mln_Succ; ch = nch) {
		if (ch->busy) {
			io = ch->io;
			if (!CheckIO((struct IORequest *)io)) AbortIO((struct IORequest *)io);
			WaitIO((struct IORequest *)io);
			ch->busy = FALSE;
		}
	}
}
