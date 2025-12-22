#include <exec/types.h>
#include <exec/memory.h>
#include <stdio.h>
#include <stdlib.h>

#include <libraries/asl.h>

#include <proto/all.h>

#include "game.h"
#include "game_proto.h"

extern struct Window	*window;

struct Library		*AslBase = NULL;
struct FileRequester	*filereq = NULL;
char			error_message[40];

struct TagItem filereqtags[] = {
	{ ASL_Window, NULL },
	{ ASL_Dir, (ULONG)"maps" },
	{ ASL_LeftEdge, 0 },
	{ ASL_TopEdge, (TOP_EDGE - 1) },
	{ ASL_Width, 320 },
	{ ASL_Height, 178 },
	{ TAG_END,	}
};

struct TagItem loadtags[] = {
	{ ASL_Hail, (ULONG)"Load map" },
	{ ASL_OKText, (ULONG)"Load" },
	{ TAG_END, }
};

struct TagItem savetags[] = {
	{ ASL_Hail, (ULONG)"Save map" },
	{ ASL_OKText, (ULONG)"Save" },
	{ TAG_END, }
};

BOOL
load_file(char *filename, UBYTE *dest, ULONG size)
{
	FILE	*fp;

	if ((fp = fopen(filename, "r")) != NULL) {
		(void)fread(dest, size, 1, fp);
		(void)fclose(fp);
		return TRUE;
	}
	return FALSE;
}

BOOL
load_packed_file(char *filename, UBYTE *dest, ULONG size)
{
	UBYTE	*packed;
	FILE	*fp;
	ULONG	s, ups;

	if ((packed = (UBYTE *)AllocMem(size, MEMF_CLEAR)) == NULL) {
		sprintf(error_message, "Out of memory when unpacking file!");
		return FALSE;
	}

	if ((fp = fopen(filename, "r")) != NULL) {
		s = fread(packed, 1, size, fp);
		(void)fclose(fp);

#if 0
fprintf(stderr, "Size %d, read size %d, source %lx, dest %lx\n", size, s, packed, dest);
#endif

		if ((ups = unpack(packed, dest, s)) != size) {
			sprintf(error_message, "File \"%s\" is corrupt!",
				filename);
			return FALSE;
		}
	} else {
		sprintf(error_message, "Can't load \"%s\"!\n", filename);
		FreeMem(packed, size);
		return FALSE;
	}

	FreeMem(packed, size);
	return TRUE;
}

BOOL
save_packed_file(char *filename, UBYTE *src, ULONG size)
{
	FILE	*fp;
	UBYTE	*packed;
	ULONG	s;

	if ((packed = (UBYTE *)AllocMem(size, MEMF_CLEAR)) == NULL) {
		sprintf(error_message, "Out of memory when packing file!\n");
		return FALSE;
	}

	if ((fp = fopen(filename, "w")) != NULL) {

		s = pack(src, packed, size);

		(void)fwrite(packed, s, 1, fp);
		(void)fclose(fp);

	} else {
		FreeMem(packed, size);
		return FALSE;
	}

	FreeMem(packed, size);
	return TRUE;
}

BOOL
filerequest(UBYTE mode)
{
	if (AslBase == NULL || filereq == NULL)
		return FALSE;

	if (mode & FR_SAVE)
		return AslRequest(filereq, savetags);

	return AslRequest(filereq, loadtags);
}

void
setup_asl(void)
{
	if ((AslBase = OpenLibrary(AslName, 37L)) == NULL)
		return;

	filereqtags[0].ti_Data = (ULONG)window;

	if ((filereq = AllocAslRequest(ASL_FileRequest, filereqtags)) == NULL)
		return;
}

void
cleandown_asl(void)
{
	if (filereq) FreeAslRequest(filereq);
	if (AslBase) CloseLibrary(AslBase);
}
