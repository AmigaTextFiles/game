#include "amiga/dos/dos.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "structs.h"
#include "m_swap.h"

#define MAPFILE_MAX_SIZE	2000

char *wad1text[MAPFILE_MAX_SIZE];
char *wad2text[MAPFILE_MAX_SIZE];


void *GetMemory( size_t size)
{
	void *ret = malloc( size);
	if (!ret)
	{
		printf( "out of memory (cannot allocate %u bytes)", size);
		exit(0);
	}

   return ret;
}

struct directory* FindDirEntry (FILE *wad, struct wad_header *wad_hdr, char *name)
{
	struct directory *dir_entry = GetMemory( sizeof( struct directory));
	char namestr[]= "\0\0\0\0\0\0\0\0\0";
	int n;


	fseek (wad, SWAPLONG(wad_hdr->dir_start), SEEK_SET);
	for (n = 0; n < SWAPLONG(wad_hdr->num_entries); n++)
	{
		fread (dir_entry, sizeof( struct directory), 1, wad);
		strncpy (namestr, dir_entry->name, 8);
		if (strcmp (namestr, name) == 0)
			return (dir_entry);
	}

	return (NULL);
}


void GetFloorTexts (FILE *wad, struct wad_header *wad_hdr, char *textures[])
{
	struct directory *dir_entry = GetMemory( sizeof( struct directory));
	char buf[9] = "\0\0\0\0\0\0\0\0\0";
	char *p;
	long int i;


	dir_entry = FindDirEntry(wad, wad_hdr, "F_START");

	for( i = 0; i < SWAPLONG(wad_hdr->num_entries); i++)
	{
		fread (dir_entry, sizeof( struct directory), 1, wad);
		strncpy (buf, dir_entry->name, 8);
		if (strcmp (buf, "F_END") == 0)
			break;

		if (strcmp (buf, "F1_START") == 0 || strcmp (buf, "F1_END") == 0 ||
		    strcmp (buf, "F2_START") == 0 || strcmp (buf, "F2_END") == 0 ||
		    strcmp (buf, "F3_START") == 0 || strcmp (buf, "F3_END") == 0)
			continue;

		p = GetMemory (strlen (buf) + 1);
		strcpy (p, buf);
		*textures++ = p;
	}

	p = GetMemory (3);
	strcpy (p, "");
	*textures = p;
	return;
}


void GetWallPatches (FILE *wad, struct wad_header *wad_hdr, char *textures[])
{
	struct directory *dir_entry = GetMemory( sizeof( struct directory));
	char buf[9] = "\0\0\0\0\0\0\0\0\0";
	char *p;
	long int i;


	dir_entry = FindDirEntry(wad, wad_hdr, "P_START");

	for( i = 0; i < SWAPLONG(wad_hdr->num_entries); i++)
	{
		fread (dir_entry, sizeof( struct directory), 1, wad);
		strncpy (buf, dir_entry->name, 8);
		if (strcmp (buf, "P_END") == 0)
			break;

		if (strcmp (buf, "P1_START") == 0 || strcmp (buf, "P1_END") == 0 ||
		    strcmp (buf, "P2_START") == 0 || strcmp (buf, "P2_END") == 0 ||
		    strcmp (buf, "P3_START") == 0 || strcmp (buf, "P3_END") == 0)
			continue;

		p = GetMemory (strlen (buf) + 1);
		strcpy (p, buf);
		*textures++ = p;
	}

	p = GetMemory (3);
	strcpy (p, "");
	*textures = p;
	return;
}


void GetSounds (FILE *wad, struct wad_header *wad_hdr, char *textures[])
{
	struct directory *dir_entry = GetMemory( sizeof( struct directory));
	char buf[9] = "\0\0\0\0\0\0\0\0\0";
	char *p;
	long int i;


	fseek (wad, SWAPLONG(wad_hdr->dir_start), SEEK_SET);

	for( i = 0; i < SWAPLONG(wad_hdr->num_entries); i++)
	{
		fread (dir_entry, sizeof( struct directory), 1, wad);
		strncpy (buf, dir_entry->name, 8);
		if (buf[0] == 'D' && (buf[1] == 'P' || buf[1] == 'S'))
		{
			p = GetMemory (strlen (buf) + 1);
			strcpy (p, buf);
			*textures++ = p;
		}
	}

	p = GetMemory (3);
	strcpy (p, "");
	*textures = p;
	return;
}


void GetSprites (FILE *wad, struct wad_header *wad_hdr, char *textures[])
{
	struct directory *dir_entry = GetMemory( sizeof( struct directory));
	char buf[9] = "\0\0\0\0\0\0\0\0\0";
	char *p;
	long int i;


	dir_entry = FindDirEntry(wad, wad_hdr, "S_START");

	for( i = 0; i < SWAPLONG(wad_hdr->num_entries); i++)
	{
		fread (dir_entry, sizeof( struct directory), 1, wad);
		strncpy (buf, dir_entry->name, 8);
		if (strcmp (buf, "S_END") == 0)
			break;

		p = GetMemory (strlen (buf) + 1);
		strcpy (p, buf);
		*textures++ = p;
	}

	p = GetMemory (3);
	strcpy (p, "");
	*textures = p;
	return;
}


void GetTextures (FILE *wad, struct directory *dir_entry, char *textures[])
{
	int i, j, alph;
	char buf[9] = "\0\0\0\0\0\0\0\0\0";
	char *p;

	for ( ; strlen(*textures) != 0; textures++)
		;

	fseek (wad, SWAPLONG(dir_entry->start), SEEK_SET);

	for (i = 0; i < 8; i++)
		buf[i] = getc(wad);

	for ( ; i < SWAPLONG(dir_entry->length); i++)
	{
		for (j = 0; j < 7; j++)
			buf[j] = buf[j+1];
		buf[7] = getc(wad);

		if (isgraph (buf[7]) || buf[7] == '\0')
			alph++;
		else
			alph = 0;

		if (alph >= 8 && isgraph (buf[0]) && isgraph (buf[1])
			 && isgraph (buf[2]) && isgraph (buf[3]))
		{
			alph=0;
			p = GetMemory (strlen (buf) + 1);
			strcpy (p, buf);
			*textures++ = p;
		}
	}
	p = GetMemory (3);
	strcpy (p, "");
	*textures = p;
}


void WriteMappings (FILE *mapfile, char *textlist1[], char *textlist2[], char *Heading)
{
	int i, j, n;

	fprintf (mapfile, "%s\n", Heading);

	for (i = 0; i < MAPFILE_MAX_SIZE; i++)
	{
		if (strlen(textlist1[i]) == 0)
			break;

		for (j = 0; strlen(textlist2[j]) != 0; j++)
		{
			if (strcmp(textlist1[i], textlist2[j]) == 0)
				break;
		}

		if (strlen(textlist2[j]) != 0)
			continue;

		for (n = 7; n > 0; n--)
		{
			for (j = 0; strlen(textlist2[j]) != 0; j++)
			{
				if (strncmp(textlist1[i], textlist2[j], n) == 0)
				{
					fprintf (mapfile, "%-8s %-8s\n", textlist1[i], textlist2[j]);
					break;
				}
			}
			if (strlen(textlist2[j]) != 0)
				break;
		}
	}
	fprintf (mapfile, "\n");
}


void ListAll (char *filename, char *textlist1[], char *textlist2[])
{
	FILE *listfile;
	int i;
	int filedone = 0;

	if ((listfile = fopen(filename, "wb+")) == NULL)
	{
		printf ("Error:  Cannot create %s\n", filename);
		return;
	}

	for (i = 0; i < MAPFILE_MAX_SIZE; i++)
	{
		if (!filedone)
		{
			if (strlen(textlist1[i]) == 0)
				filedone = 1;
			else if (strlen(textlist2[i]) == 0)
				filedone = 2;
			else
				fprintf (listfile, "%-8s %-8s\n", textlist1[i], textlist2[i]);
		}
		if (filedone == 1)
		{
			if (strlen(textlist2[i]) == 0)
				break;
			fprintf (listfile, "         %-8s\n", textlist2[i]);
		}
		if (filedone == 2)
		{
			if (strlen(textlist1[i]) == 0)
				break;
			fprintf (listfile, "%-8s\n", textlist1[i]);
		}
	}
	fclose (listfile);
}



main (int argc, char *argv[])
{
	FILE *wad1, *wad2, *mapfile;
	struct wad_header *wad1_hdr = GetMemory( sizeof( struct wad_header));
	struct wad_header *wad2_hdr = GetMemory( sizeof( struct wad_header));
	struct directory *dir_entry = GetMemory( sizeof( struct directory));
	int i;
	char buf[9] = "\0\0\0\0\0\0\0\0\0";


	printf ("\n*** Mapfile maker for WAD1TO2 pwad converter v1.0 (c) 1994 Tracy F. Thonn ***\n\n");
	printf ("Amigaversion v1.0 (c) 1998 Anders Bylund\n\n");

	if ((wad1 = fopen("doom.wad", "rb")) == NULL)
	{
		printf ("Error:  Cannot open doom.wad\n");
		return (1);
	}

	if ((wad2 = fopen("doom2.wad", "rb")) == NULL)
	{
		printf ("Error:  Cannot open doom2.wad\n");
		fclose (wad1);
		return (1);
	}

	if ((mapfile = fopen("makemap.map", "wb+")) == NULL)
	{
		printf ("Error:  Cannot create texture.map\n");
		fclose (wad1);
		fclose (wad2);
		return (1);
	}

	fprintf (mapfile, "[Wad1to2 Mapfile]\n");
	fprintf (mapfile, "[by TFT]\n\n");

	printf ("Mapping levels...\n");
	fprintf (mapfile, "[level1  level2]\n");
	for (i = 0; i < 32; i++)
	{
		fprintf (mapfile, "E%1dM%1d     MAP%02d\n", (i / 9) + 1, (i % 9) + 1, i + 1);
	}
	fprintf (mapfile, "\n");


	fread(wad1_hdr, sizeof( struct wad_header), 1, wad1);
	fread(wad2_hdr, sizeof( struct wad_header), 1, wad2);


	printf ("Mapping wall textures...\n");
	dir_entry = FindDirEntry(wad1, wad1_hdr, "TEXTURE1");
	printf ("        texture1: %lu chars at %lu\n", SWAPLONG(dir_entry->length), SWAPLONG(dir_entry->start));
	wad1text[0] = NULL;
	GetTextures (wad1, dir_entry, wad1text);

	dir_entry = FindDirEntry(wad1, wad1_hdr, "TEXTURE2");
	printf ("        texture2: %lu chars at %lu\n", SWAPLONG(dir_entry->length), SWAPLONG(dir_entry->start));
	GetTextures (wad1, dir_entry, wad1text);


	dir_entry = FindDirEntry(wad2, wad2_hdr, "TEXTURE1");
	printf ("        texture1: %lu chars at %lu\n", SWAPLONG(dir_entry->length), SWAPLONG(dir_entry->start));
	GetTextures (wad2, dir_entry, wad2text);


	ListAll ("texture.all", wad1text, wad2text);
	WriteMappings (mapfile, wad1text, wad2text, "[textur1 textur2]");


	printf ("Mapping wall patches...\n");
	GetWallPatches (wad1, wad1_hdr, wad1text);
	GetWallPatches (wad2, wad2_hdr, wad2text);
	ListAll ("wpatch.all", wad1text, wad2text);
	WriteMappings (mapfile, wad1text, wad2text, "[patch1  patch2]");


	printf ("Mapping floor textures...\n");
	GetFloorTexts (wad1, wad1_hdr, wad1text);
	GetFloorTexts (wad2, wad2_hdr, wad2text);
	ListAll ("floortxt.all", wad1text, wad2text);
	WriteMappings (mapfile, wad1text, wad2text, "[floor1  floor2]");


/***
	printf ("Mapping sprites...\n");
	GetSprites (wad1, wad1_hdr, wad1text);
	GetSprites (wad2, wad2_hdr, wad2text);
	ListAll ("sprites.all", wad1text, wad2text);
	WriteMappings (mapfile, wad1text, wad2text, "[sprite1 sprite2]");
***/

	printf ("Mapping sounds...\n");
	GetSounds (wad1, wad1_hdr, wad1text);
	GetSounds (wad2, wad2_hdr, wad2text);
	ListAll ("sounds.all", wad1text, wad2text);
	WriteMappings (mapfile, wad1text, wad2text, "[sound1  sound2]");


	printf ("Mapping music entries...\n");
	fprintf (mapfile, "[music1  music2]\n");
	dir_entry = FindDirEntry(wad2, wad2_hdr, "D_RUNNIN");
	strncpy (buf, dir_entry->name, 8);
	fprintf (mapfile, "D_E1M1   %-8s\n", buf);
	for (i = 1; i < 32; i++)
	{
		fread (dir_entry, sizeof( struct directory), 1, wad2);
		strncpy (buf, dir_entry->name, 8);
		fprintf (mapfile, "D_E%1dM%1d   %-8s\n", (i / 9) + 1, (i % 9) + 1, buf);
	}
	fread (dir_entry, sizeof( struct directory), 1, wad2);
	strncpy (buf, dir_entry->name, 8);
	fprintf (mapfile, "D_VICTOR %-8s\n", buf);
	fread (dir_entry, sizeof( struct directory), 1, wad2);
	strncpy (buf, dir_entry->name, 8);
	fprintf (mapfile, "D_INTRO  %-8s\n", buf);
	fread (dir_entry, sizeof( struct directory), 1, wad2);
	strncpy (buf, dir_entry->name, 8);
	fprintf (mapfile, "D_INTER  %-8s\n", buf);
	fprintf (mapfile, "\n");

	printf ("Mapping old demos...\n");
	fprintf (mapfile, "[demo1   void2]\n");
	fprintf (mapfile, "DEMO1    OLDDEMO1\n");
	fprintf (mapfile, "DEMO2    OLDDEMO2\n");
	fprintf (mapfile, "DEMO3    OLDDEMO3\n");
	fprintf (mapfile, "\n");


	fclose (wad1);
	fclose (wad2);
	fclose (mapfile);

	printf ("\nFiles created...\n");
	printf ("    makemap.map  - starter mapfile for use with wad1to2.exe\n");
	printf ("    texture.all  - list of all wall texture names for Doom1 and Doom2\n");
	printf ("    wpatch.all   - list of all wall patch names for Doom1 and Doom2\n");
	printf ("    floortxt.all - list of all floor and ceiling textures for Doom1 and Doom2\n");
	printf ("    sounds.all   - list of all the sound names for Doom1 and Doom2\n");

	return (0);
}
