#include <exec/types.h>

#include "MODplayer/modplayer.h"

struct MMD0	*module = NULL;

void
initmusic(void)
{
	if ((module = LoadModule("gamemod.MED")) == NULL) return;

	InitPlayer();
}

void
stopmusic(void)
{
	StopPlayer();
}

void
contmusic(void)
{
	if (module) ContModule(module);
}

void
playmusic(UWORD n)
{
	if (module == NULL) return;

	StopPlayer();
	modnum = n;
	PlayModule(module);
}

void
cleanmusic(void)
{
	if (module == NULL) return;

	StopPlayer();
	UnLoadModule(module);
	RemPlayer();
}
