/***********************************************************
* Mirror Magic -- McDuffin's Revenge                       *
*----------------------------------------------------------*
* (c) 1994-2001 Artsoft Entertainment                      *
*               Holger Schemel                             *
*               Detmolder Strasse 189                      *
*               33604 Bielefeld                            *
*               Germany                                    *
*               e-mail: info@artsoft.org                   *
*----------------------------------------------------------*
* files.h                                                  *
***********************************************************/

#include <ctype.h>

#ifdef __MORPHOS__
#include <machine/types.h>
#endif

#include <dirent.h>
#include <sys/stat.h>

#include "libgame/libgame.h"

#include "files.h"
#include "tools.h"

#define MAX_FILENAME_LEN	256	/* maximal filename length   */
#define MAX_LINE_LEN		1000	/* maximal input line length */
#define CHUNK_ID_LEN		4	/* IFF style chunk id length */
#define CHUNK_SIZE_UNDEFINED	0	/* undefined chunk size == 0  */
#define CHUNK_SIZE_NONE		-1	/* do not write chunk size    */
#define FILE_VERS_CHUNK_SIZE	8	/* size of file version chunk */
#define LEVEL_HEADER_SIZE	80	/* size of level file header */
#define LEVEL_HEADER_UNUSED	19	/* unused level header bytes */

/* file identifier strings */
#define LEVEL_COOKIE_TMPL	"MIRRORMAGIC_LEVEL_FILE_VERSION_x.x"
#define SCORE_COOKIE		"MIRRORMAGIC_SCORE_FILE_VERSION_1.4"
#define SETUP_COOKIE		"MIRRORMAGIC_SETUP_FILE_VERSION_1.4"
#define LEVELSETUP_COOKIE	"MIRRORMAGIC_LEVELSETUP_FILE_VERSION_1.4"
#define LEVELINFO_COOKIE	"MIRRORMAGIC_LEVELINFO_FILE_VERSION_1.4"

/* file names and filename extensions */
#if !defined(PLATFORM_MSDOS)
#define LEVELSETUP_DIRECTORY	"levelsetup"
#define SETUP_FILENAME		"setup.conf"
#define LEVELSETUP_FILENAME	"levelsetup.conf"
#define LEVELINFO_FILENAME	"levelinfo.conf"
#define LEVELFILE_EXTENSION	"level"
#define SCOREFILE_EXTENSION	"score"
#else
#define LEVELSETUP_DIRECTORY	"lvlsetup"
#define SETUP_FILENAME		"setup.cnf"
#define LEVELSETUP_FILENAME	"lvlsetup.cnf"
#define LEVELINFO_FILENAME	"lvlinfo.cnf"
#define LEVELFILE_EXTENSION	"lvl"
#define SCOREFILE_EXTENSION	"sco"
#endif

/* sort priorities of level series (also used as level series classes) */
#define LEVELCLASS_TUTORIAL_START	10
#define LEVELCLASS_TUTORIAL_END		99
#define LEVELCLASS_CLASSICS_START	100
#define LEVELCLASS_CLASSICS_END		199
#define LEVELCLASS_CONTRIBUTION_START	200
#define LEVELCLASS_CONTRIBUTION_END	299
#define LEVELCLASS_USER_START		300
#define LEVELCLASS_USER_END		399
#define LEVELCLASS_BD_START		400
#define LEVELCLASS_BD_END		499
#define LEVELCLASS_EM_START		500
#define LEVELCLASS_EM_END		599
#define LEVELCLASS_SP_START		600
#define LEVELCLASS_SP_END		699
#define LEVELCLASS_DX_START		700
#define LEVELCLASS_DX_END		799

#define LEVELCLASS_TUTORIAL		LEVELCLASS_TUTORIAL_START
#define LEVELCLASS_CLASSICS		LEVELCLASS_CLASSICS_START
#define LEVELCLASS_CONTRIBUTION		LEVELCLASS_CONTRIBUTION_START
#define LEVELCLASS_USER			LEVELCLASS_USER_START
#define LEVELCLASS_BD			LEVELCLASS_BD_START
#define LEVELCLASS_EM			LEVELCLASS_EM_START
#define LEVELCLASS_SP			LEVELCLASS_SP_START
#define LEVELCLASS_DX			LEVELCLASS_DX_START

#define LEVELCLASS_UNDEFINED		999

#define NUM_LEVELCLASS_DESC	8
char *levelclass_desc[NUM_LEVELCLASS_DESC] =
{
  "Tutorial Levels",
  "Classic Originals",
  "Contributions",
  "Private Levels",
  "Boulderdash",
  "Emerald Mine",
  "Supaplex",
  "DX Boulderdash"
};

#define IS_LEVELCLASS_TUTORIAL(p) \
	((p)->sort_priority >= LEVELCLASS_TUTORIAL_START && \
	 (p)->sort_priority <= LEVELCLASS_TUTORIAL_END)
#define IS_LEVELCLASS_CLASSICS(p) \
	((p)->sort_priority >= LEVELCLASS_CLASSICS_START && \
	 (p)->sort_priority <= LEVELCLASS_CLASSICS_END)
#define IS_LEVELCLASS_CONTRIBUTION(p) \
	((p)->sort_priority >= LEVELCLASS_CONTRIBUTION_START && \
	 (p)->sort_priority <= LEVELCLASS_CONTRIBUTION_END)
#define IS_LEVELCLASS_USER(p) \
	((p)->sort_priority >= LEVELCLASS_USER_START && \
	 (p)->sort_priority <= LEVELCLASS_USER_END)
#define IS_LEVELCLASS_BD(p) \
	((p)->sort_priority >= LEVELCLASS_BD_START && \
	 (p)->sort_priority <= LEVELCLASS_BD_END)
#define IS_LEVELCLASS_EM(p) \
	((p)->sort_priority >= LEVELCLASS_EM_START && \
	 (p)->sort_priority <= LEVELCLASS_EM_END)
#define IS_LEVELCLASS_SP(p) \
	((p)->sort_priority >= LEVELCLASS_SP_START && \
	 (p)->sort_priority <= LEVELCLASS_SP_END)
#define IS_LEVELCLASS_DX(p) \
	((p)->sort_priority >= LEVELCLASS_DX_START && \
	 (p)->sort_priority <= LEVELCLASS_DX_END)

#define LEVELCLASS(n)	(IS_LEVELCLASS_TUTORIAL(n) ? LEVELCLASS_TUTORIAL : \
			 IS_LEVELCLASS_CLASSICS(n) ? LEVELCLASS_CLASSICS : \
			 IS_LEVELCLASS_CONTRIBUTION(n) ? LEVELCLASS_CONTRIBUTION : \
			 IS_LEVELCLASS_USER(n) ? LEVELCLASS_USER : \
			 IS_LEVELCLASS_BD(n) ? LEVELCLASS_BD : \
			 IS_LEVELCLASS_EM(n) ? LEVELCLASS_EM : \
			 IS_LEVELCLASS_SP(n) ? LEVELCLASS_SP : \
			 IS_LEVELCLASS_DX(n) ? LEVELCLASS_DX : \
			 LEVELCLASS_UNDEFINED)

#define LEVELCOLOR(n)	(IS_LEVELCLASS_TUTORIAL(n) ?		FC_BLUE : \
			 IS_LEVELCLASS_CLASSICS(n) ?		FC_RED : \
			 IS_LEVELCLASS_BD(n) ?			FC_GREEN : \
			 IS_LEVELCLASS_EM(n) ?			FC_YELLOW : \
			 IS_LEVELCLASS_SP(n) ?			FC_GREEN : \
			 IS_LEVELCLASS_DX(n) ?			FC_YELLOW : \
			 IS_LEVELCLASS_CONTRIBUTION(n) ?	FC_GREEN : \
			 IS_LEVELCLASS_USER(n) ?		FC_RED : \
			 FC_BLUE)

#define LEVELSORTING(n)	(IS_LEVELCLASS_TUTORIAL(n) ?		0 : \
			 IS_LEVELCLASS_CLASSICS(n) ?		1 : \
			 IS_LEVELCLASS_BD(n) ?			2 : \
			 IS_LEVELCLASS_EM(n) ?			3 : \
			 IS_LEVELCLASS_SP(n) ?			4 : \
			 IS_LEVELCLASS_DX(n) ?			5 : \
			 IS_LEVELCLASS_CONTRIBUTION(n) ?	6 : \
			 IS_LEVELCLASS_USER(n) ?		7 : \
			 9)

char *getLevelClassDescription(struct LevelDirInfo *ldi)
{
  int position = ldi->sort_priority / 100;

  if (position >= 0 && position < NUM_LEVELCLASS_DESC)
    return levelclass_desc[position];
  else
    return "Unknown Level Class";
}

static void SaveUserLevelInfo();		/* for 'InitUserLevelDir()' */
static char *getSetupLine(char *, int);		/* for 'SaveUserLevelInfo()' */

static char *getUserLevelDir(char *level_subdir)
{
  static char *userlevel_dir = NULL;
  char *data_dir = getUserDataDir();
  char *userlevel_subdir = LEVELS_DIRECTORY;

  if (userlevel_dir)
    free(userlevel_dir);

  if (strlen(level_subdir) > 0)
    userlevel_dir = getPath3(data_dir, userlevel_subdir, level_subdir);
  else
    userlevel_dir = getPath2(data_dir, userlevel_subdir);

  return userlevel_dir;
}

static char *getScoreDir(char *level_subdir)
{
  static char *score_dir = NULL;
#ifndef __MORPHOS__
  char *data_dir = options.rw_base_directory;
#else
  char *data_dir = "Progdir:";
#endif
  char *score_subdir = SCORES_DIRECTORY;

  if (score_dir)
    free(score_dir);

  if (strlen(level_subdir) > 0)
    score_dir = getPath3(data_dir, score_subdir, level_subdir);
  else
    score_dir = getPath2(data_dir, score_subdir);

  return score_dir;
}

static char *getLevelSetupDir(char *level_subdir)
{
  static char *levelsetup_dir = NULL;
  char *data_dir = getUserDataDir();
  char *levelsetup_subdir = LEVELSETUP_DIRECTORY;

  if (levelsetup_dir)
    free(levelsetup_dir);

  if (strlen(level_subdir) > 0)
    levelsetup_dir = getPath3(data_dir, levelsetup_subdir, level_subdir);
  else
    levelsetup_dir = getPath2(data_dir, levelsetup_subdir);

  return levelsetup_dir;
}

static char *getLevelFilename(int nr)
{
  static char *filename = NULL;
  char basename[MAX_FILENAME_LEN];

  if (filename != NULL)
    free(filename);

  sprintf(basename, "%03d.%s", nr, LEVELFILE_EXTENSION);
  filename = getPath3((leveldir_current->user_defined ?
		       getUserLevelDir("") :
		       options.level_directory),
		      leveldir_current->fullpath,
		      basename);

  return filename;
}

static char *getScoreFilename(int nr)
{
  static char *filename = NULL;
  char basename[MAX_FILENAME_LEN];

  if (filename != NULL)
    free(filename);

  sprintf(basename, "%03d.%s", nr, SCOREFILE_EXTENSION);
  filename = getPath2(getScoreDir(leveldir_current->filename), basename);

  return filename;
}

static void InitScoreDirectory(char *level_subdir)
{
  createDirectory(getScoreDir(""), "main score", PERMS_PUBLIC);
  createDirectory(getScoreDir(level_subdir), "level score", PERMS_PUBLIC);
}

static void InitUserLevelDirectory(char *level_subdir)
{
  if (access(getUserLevelDir(level_subdir), F_OK) != 0)
  {
    createDirectory(getUserDataDir(), "user data", PERMS_PRIVATE);
    createDirectory(getUserLevelDir(""), "main user level", PERMS_PRIVATE);
    createDirectory(getUserLevelDir(level_subdir), "user level",PERMS_PRIVATE);

    SaveUserLevelInfo();
  }
}

static void InitLevelSetupDirectory(char *level_subdir)
{
  createDirectory(getUserDataDir(), "user data", PERMS_PRIVATE);
  createDirectory(getLevelSetupDir(""), "main level setup", PERMS_PRIVATE);
  createDirectory(getLevelSetupDir(level_subdir), "level setup",PERMS_PRIVATE);
}

static void ReadChunk_VERS(FILE *file, int *file_version, int *game_version)
{
  int file_version_major, file_version_minor, file_version_patch;
  int game_version_major, game_version_minor, game_version_patch;

  file_version_major = fgetc(file);
  file_version_minor = fgetc(file);
  file_version_patch = fgetc(file);
  fgetc(file);		/* not used */

  game_version_major = fgetc(file);
  game_version_minor = fgetc(file);
  game_version_patch = fgetc(file);
  fgetc(file);		/* not used */

  *file_version = VERSION_IDENT(file_version_major,
				file_version_minor,
				file_version_patch);

  *game_version = VERSION_IDENT(game_version_major,
				game_version_minor,
				game_version_patch);
}

static void WriteChunk_VERS(FILE *file, int file_version, int game_version)
{
  int file_version_major = VERSION_MAJOR(file_version);
  int file_version_minor = VERSION_MINOR(file_version);
  int file_version_patch = VERSION_PATCH(file_version);
  int game_version_major = VERSION_MAJOR(game_version);
  int game_version_minor = VERSION_MINOR(game_version);
  int game_version_patch = VERSION_PATCH(game_version);

  fputc(file_version_major, file);
  fputc(file_version_minor, file);
  fputc(file_version_patch, file);
  fputc(0, file);	/* not used */

  fputc(game_version_major, file);
  fputc(game_version_minor, file);
  fputc(game_version_patch, file);
  fputc(0, file);	/* not used */
}

static void setLevelInfoToDefaults()
{
  int i, x, y;

  level.file_version = FILE_VERSION_ACTUAL;
  level.game_version = GAME_VERSION_ACTUAL;

  level.encoding_16bit_field = FALSE;	/* default: only 8-bit elements */

  lev_fieldx = level.fieldx = STD_LEV_FIELDX;
  lev_fieldy = level.fieldy = STD_LEV_FIELDY;

  for(x=0; x<MAX_LEV_FIELDX; x++)
    for(y=0; y<MAX_LEV_FIELDY; y++)
      Feld[x][y] = Ur[x][y] = EL_EMPTY;

  level.time = 100;
  level.kettles_needed = 0;
  level.auto_count_kettles = TRUE;
  level.amoeba_speed = 0;
  level.time_fuse = 0;
  level.laser_red = FALSE;
  level.laser_green = FALSE;
  level.laser_blue = TRUE;

  for(i=0; i<MAX_LEVEL_NAME_LEN; i++)
    level.name[i] = '\0';
  for(i=0; i<MAX_LEVEL_AUTHOR_LEN; i++)
    level.author[i] = '\0';

  strcpy(level.name, NAMELESS_LEVEL_NAME);
  strcpy(level.author, ANONYMOUS_NAME);

  for(i=0; i<LEVEL_SCORE_ELEMENTS; i++)
    level.score[i] = 10;

  Feld[0][0] = Ur[0][0] = EL_MCDUFFIN_RIGHT;
  Feld[STD_LEV_FIELDX-1][STD_LEV_FIELDY-1] =
    Ur[STD_LEV_FIELDX-1][STD_LEV_FIELDY-1] = EL_EXIT_CLOSED;

  /* try to determine better author name than 'anonymous' */
  if (strcmp(leveldir_current->author, ANONYMOUS_NAME) != 0)
  {
    strncpy(level.author, leveldir_current->author, MAX_LEVEL_AUTHOR_LEN);
    level.author[MAX_LEVEL_AUTHOR_LEN] = '\0';
  }
  else
  {
    switch (LEVELCLASS(leveldir_current))
    {
      case LEVELCLASS_TUTORIAL:
	strcpy(level.author, PROGRAM_AUTHOR_STRING);
	break;

      case LEVELCLASS_CONTRIBUTION:
	strncpy(level.author, leveldir_current->name,MAX_LEVEL_AUTHOR_LEN);
	level.author[MAX_LEVEL_AUTHOR_LEN] = '\0';
	break;

      case LEVELCLASS_USER:
	strncpy(level.author, getRealName(), MAX_LEVEL_AUTHOR_LEN);
	level.author[MAX_LEVEL_AUTHOR_LEN] = '\0';
	break;

      default:
	/* keep default value */
	break;
    }
  }
}

static int checkLevelElement(int element)
{
  if (element >= EL_FIRST_RUNTIME_EL)
  {
    Error(ERR_WARN, "invalid level element %d", element);
    element = EL_CHAR_FRAGE;
  }

  return element;
}

static int LoadLevel_VERS(FILE *file, int chunk_size, struct LevelInfo *level)
{
  ReadChunk_VERS(file, &(level->file_version), &(level->game_version));

  return chunk_size;
}

static int LoadLevel_HEAD(FILE *file, int chunk_size, struct LevelInfo *level)
{
  int i;
  int laser_color;

  lev_fieldx = level->fieldx = fgetc(file);
  lev_fieldy = level->fieldy = fgetc(file);

  level->time           = getFile16BitInteger(file, BYTE_ORDER_BIG_ENDIAN);
  level->kettles_needed = getFile16BitInteger(file, BYTE_ORDER_BIG_ENDIAN);

  for(i=0; i<MAX_LEVEL_NAME_LEN; i++)
    level->name[i] = fgetc(file);
  level->name[MAX_LEVEL_NAME_LEN] = 0;

  for(i=0; i<LEVEL_SCORE_ELEMENTS; i++)
    level->score[i] = fgetc(file);

  level->auto_count_kettles	= (fgetc(file) == 1 ? TRUE : FALSE);
  level->amoeba_speed		= fgetc(file);
  level->time_fuse		= fgetc(file);

  laser_color			= fgetc(file);
  level->laser_red		= (laser_color >> 2) & 0x01;
  level->laser_green		= (laser_color >> 1) & 0x01;
  level->laser_blue		= (laser_color >> 0) & 0x01;

  level->encoding_16bit_field	= (fgetc(file) == 1 ? TRUE : FALSE);

  ReadUnusedBytesFromFile(file, LEVEL_HEADER_UNUSED);

  return chunk_size;
}

static int LoadLevel_AUTH(FILE *file, int chunk_size, struct LevelInfo *level)
{
  int i;

  for(i=0; i<MAX_LEVEL_AUTHOR_LEN; i++)
    level->author[i] = fgetc(file);
  level->author[MAX_LEVEL_NAME_LEN] = 0;

  return chunk_size;
}

static int LoadLevel_BODY(FILE *file, int chunk_size, struct LevelInfo *level)
{
  int x, y;
  int chunk_size_expected = level->fieldx * level->fieldy;

  /* Note: "chunk_size" was wrong before version 2.0 when elements are
     stored with 16-bit encoding (and should be twice as big then).
     Even worse, playfield data was stored 16-bit when only yamyam content
     contained 16-bit elements and vice versa. */

  if (level->encoding_16bit_field && level->file_version >= FILE_VERSION_2_0)
    chunk_size_expected *= 2;

  if (chunk_size_expected != chunk_size)
  {
    ReadUnusedBytesFromFile(file, chunk_size);
    return chunk_size_expected;
  }

  for(y=0; y<level->fieldy; y++)
    for(x=0; x<level->fieldx; x++)
      Feld[x][y] = Ur[x][y] =
	checkLevelElement(level->encoding_16bit_field ?
			  getFile16BitInteger(file, BYTE_ORDER_BIG_ENDIAN) :
			  fgetc(file));
  return chunk_size;
}

void LoadLevel(int level_nr)
{
  char *filename = getLevelFilename(level_nr);
  char cookie[MAX_LINE_LEN];
  char chunk_name[CHUNK_ID_LEN + 1];
  int chunk_size;
  FILE *file;

  static struct
  {
    char *name;
    int size;
    int (*loader)(FILE *, int, struct LevelInfo *);
  }
  chunk_info[] =
  {
    { "VERS", FILE_VERS_CHUNK_SIZE,	LoadLevel_VERS },
    { "HEAD", LEVEL_HEADER_SIZE,	LoadLevel_HEAD },
    { "AUTH", MAX_LEVEL_AUTHOR_LEN,	LoadLevel_AUTH },
    { "BODY", -1,			LoadLevel_BODY },
    {  NULL,  0,			NULL }
  };

  /* always start with reliable default values */
  setLevelInfoToDefaults();

  if (!(file = fopen(filename, MODE_READ)))
  {
    Error(ERR_WARN, "cannot read level '%s' - creating new level", filename);
    return;
  }

  getFileChunk(file, chunk_name, NULL, BYTE_ORDER_BIG_ENDIAN);
  if (strcmp(chunk_name, "MMII") == 0)
  {
    getFile32BitInteger(file, BYTE_ORDER_BIG_ENDIAN);	/* not used */

    getFileChunk(file, chunk_name, NULL, BYTE_ORDER_BIG_ENDIAN);
    if (strcmp(chunk_name, "CAVE") != 0)
    {
      Error(ERR_WARN, "unknown format of level file '%s'", filename);
      fclose(file);
      return;
    }
  }
  else	/* check for pre-2.0 file format with cookie string */
  {
    strcpy(cookie, chunk_name);
    fgets(&cookie[4], MAX_LINE_LEN - 4, file);
    if (strlen(cookie) > 0 && cookie[strlen(cookie) - 1] == '\n')
      cookie[strlen(cookie) - 1] = '\0';

    if (!checkCookieString(cookie, LEVEL_COOKIE_TMPL))
    {
      Error(ERR_WARN, "unknown format of level file '%s'", filename);
      fclose(file);
      return;
    }

    if ((level.file_version = getFileVersionFromCookieString(cookie)) == -1)
    {
      Error(ERR_WARN, "unsupported version of level file '%s'", filename);
      fclose(file);
      return;
    }
  }

  while (getFileChunk(file, chunk_name, &chunk_size, BYTE_ORDER_BIG_ENDIAN))
  {
    int i = 0;

    while (chunk_info[i].name != NULL &&
	   strcmp(chunk_name, chunk_info[i].name) != 0)
      i++;

    if (chunk_info[i].name == NULL)
    {
      Error(ERR_WARN, "unknown chunk '%s' in level file '%s'",
	    chunk_name, filename);
      ReadUnusedBytesFromFile(file, chunk_size);
    }
    else if (chunk_info[i].size != -1 &&
	     chunk_info[i].size != chunk_size)
    {
      Error(ERR_WARN, "wrong size (%d) of chunk '%s' in level file '%s'",
	    chunk_size, chunk_name, filename);
      ReadUnusedBytesFromFile(file, chunk_size);
    }
    else
    {
      /* call function to load this level chunk */
      int chunk_size_expected =
	(chunk_info[i].loader)(file, chunk_size, &level);

      /* the size of some chunks cannot be checked before reading other
	 chunks first (like "HEAD" and "BODY") that contain some header
	 information, so check them here */
      if (chunk_size_expected != chunk_size)
      {
	Error(ERR_WARN, "wrong size (%d) of chunk '%s' in level file '%s'",
	      chunk_size, chunk_name, filename);
      }
    }
  }

  fclose(file);
}

static void SaveLevel_HEAD(FILE *file, struct LevelInfo *level)
{
  int i;
  int laser_color;

  fputc(level->fieldx, file);
  fputc(level->fieldy, file);

  putFile16BitInteger(file, level->time,           BYTE_ORDER_BIG_ENDIAN);
  putFile16BitInteger(file, level->kettles_needed, BYTE_ORDER_BIG_ENDIAN);

  for(i=0; i<MAX_LEVEL_NAME_LEN; i++)
    fputc(level->name[i], file);

  for(i=0; i<LEVEL_SCORE_ELEMENTS; i++)
    fputc(level->score[i], file);

  fputc((level->auto_count_kettles ? 1 : 0), file);
  fputc(level->amoeba_speed, file);
  fputc(level->time_fuse, file);

  laser_color = ((level->laser_red   << 2) |
		 (level->laser_green << 1) |
		 (level->laser_blue  << 0));
  fputc(laser_color, file);

  fputc((level->encoding_16bit_field ? 1 : 0), file);

  WriteUnusedBytesToFile(file, LEVEL_HEADER_UNUSED);
}

static void SaveLevel_AUTH(FILE *file, struct LevelInfo *level)
{
  int i;

  for(i=0; i<MAX_LEVEL_AUTHOR_LEN; i++)
    fputc(level->author[i], file);
}

static void SaveLevel_BODY(FILE *file, struct LevelInfo *level)
{
  int x, y;

  for(y=0; y<level->fieldy; y++) 
    for(x=0; x<level->fieldx; x++) 
      if (level->encoding_16bit_field)
	putFile16BitInteger(file, Ur[x][y], BYTE_ORDER_BIG_ENDIAN);
      else
	fputc(Ur[x][y], file);
}

void SaveLevel(int level_nr)
{
  int x, y;
  char *filename = getLevelFilename(level_nr);
  int body_chunk_size;
  FILE *file;

  if (!(file = fopen(filename, MODE_WRITE)))
  {
    Error(ERR_WARN, "cannot save level file '%s'", filename);
    return;
  }

  /* check level field for 16-bit elements */
  level.encoding_16bit_field = FALSE;
  for(y=0; y<level.fieldy; y++) 
    for(x=0; x<level.fieldx; x++) 
      if (Ur[x][y] > 255)
	level.encoding_16bit_field = TRUE;

  body_chunk_size =
    level.fieldx * level.fieldy * (level.encoding_16bit_field ? 2 : 1);

  putFileChunk(file, "MMII", CHUNK_SIZE_UNDEFINED, BYTE_ORDER_BIG_ENDIAN);
  putFileChunk(file, "CAVE", CHUNK_SIZE_NONE,      BYTE_ORDER_BIG_ENDIAN);

  putFileChunk(file, "VERS", FILE_VERS_CHUNK_SIZE, BYTE_ORDER_BIG_ENDIAN);
  WriteChunk_VERS(file, FILE_VERSION_ACTUAL, GAME_VERSION_ACTUAL);

  putFileChunk(file, "HEAD", LEVEL_HEADER_SIZE, BYTE_ORDER_BIG_ENDIAN);
  SaveLevel_HEAD(file, &level);

  putFileChunk(file, "AUTH", MAX_LEVEL_AUTHOR_LEN, BYTE_ORDER_BIG_ENDIAN);
  SaveLevel_AUTH(file, &level);

  putFileChunk(file, "BODY", body_chunk_size, BYTE_ORDER_BIG_ENDIAN);
  SaveLevel_BODY(file, &level);

  fclose(file);

  SetFilePermissions(filename, PERMS_PRIVATE);
}

void LoadScore(int level_nr)
{
  int i;
  char *filename = getScoreFilename(level_nr);
  char cookie[MAX_LINE_LEN];
  char line[MAX_LINE_LEN];
  char *line_ptr;
  FILE *file;

  /* always start with reliable default values */
  for(i=0; i<MAX_SCORE_ENTRIES; i++)
  {
    strcpy(highscore[i].Name, EMPTY_PLAYER_NAME);
    highscore[i].Score = 0;
  }

  if (!(file = fopen(filename, MODE_READ)))
    return;

  /* check file identifier */
  fgets(cookie, MAX_LINE_LEN, file);
  if (strlen(cookie) > 0 && cookie[strlen(cookie) - 1] == '\n')
    cookie[strlen(cookie) - 1] = '\0';

  if (strcmp(cookie, SCORE_COOKIE) != 0)
  {
    Error(ERR_WARN, "wrong file identifier of score file '%s'", filename);
    fclose(file);
    return;
  }

  for(i=0; i<MAX_SCORE_ENTRIES; i++)
  {
    fscanf(file, "%d", &highscore[i].Score);
    fgets(line, MAX_LINE_LEN, file);

    if (line[strlen(line) - 1] == '\n')
      line[strlen(line) - 1] = '\0';

    for (line_ptr = line; *line_ptr; line_ptr++)
    {
      if (*line_ptr != ' ' && *line_ptr != '\t' && *line_ptr != '\0')
      {
	strncpy(highscore[i].Name, line_ptr, MAX_PLAYER_NAME_LEN);
	highscore[i].Name[MAX_PLAYER_NAME_LEN] = '\0';
	break;
      }
    }
  }

  fclose(file);
}

void SaveScore(int level_nr)
{
  int i;
  char *filename = getScoreFilename(level_nr);
  FILE *file;

  InitScoreDirectory(leveldir_current->filename);

  if (!(file = fopen(filename, MODE_WRITE)))
  {
    Error(ERR_WARN, "cannot save score for level %d", level_nr);
    return;
  }

  fprintf(file, "%s\n\n", SCORE_COOKIE);

  for(i=0; i<MAX_SCORE_ENTRIES; i++)
    fprintf(file, "%d %s\n", highscore[i].Score, highscore[i].Name);

  fclose(file);

  SetFilePermissions(filename, PERMS_PUBLIC);
}

#define TOKEN_STR_FILE_IDENTIFIER	"file_identifier"
#define TOKEN_STR_LAST_LEVEL_SERIES	"last_level_series"
#define TOKEN_STR_LAST_PLAYED_LEVEL	"last_played_level"
#define TOKEN_STR_HANDICAP_LEVEL	"handicap_level"
#define TOKEN_STR_PLAYER_PREFIX		"player_"

#define TOKEN_VALUE_POSITION		30

/* global setup */
#define SETUP_TOKEN_PLAYER_NAME		0
#define SETUP_TOKEN_SOUND		1
#define SETUP_TOKEN_SOUND_LOOPS		2
#define SETUP_TOKEN_SOUND_MUSIC		3
#define SETUP_TOKEN_SOUND_SIMPLE	4

#define SETUP_TOKEN_QUICK_DOORS		5
#define SETUP_TOKEN_HANDICAP		6
#define SETUP_TOKEN_TIME_LIMIT		7
#define SETUP_TOKEN_FULLSCREEN		8

/* level directory info */
#define LEVELINFO_TOKEN_NAME		9
#define LEVELINFO_TOKEN_NAME_SHORT	10
#define LEVELINFO_TOKEN_NAME_SORTING	11
#define LEVELINFO_TOKEN_AUTHOR		12
#define LEVELINFO_TOKEN_IMPORTED_FROM	13
#define LEVELINFO_TOKEN_LEVELS		14
#define LEVELINFO_TOKEN_FIRST_LEVEL	15
#define LEVELINFO_TOKEN_SORT_PRIORITY	16
#define LEVELINFO_TOKEN_LEVEL_GROUP	17
#define LEVELINFO_TOKEN_READONLY	18

#define FIRST_GLOBAL_SETUP_TOKEN	SETUP_TOKEN_PLAYER_NAME
#define LAST_GLOBAL_SETUP_TOKEN		SETUP_TOKEN_FULLSCREEN

#define FIRST_LEVELINFO_TOKEN		LEVELINFO_TOKEN_NAME
#define LAST_LEVELINFO_TOKEN		LEVELINFO_TOKEN_READONLY

#define TYPE_BOOLEAN			1
#define TYPE_SWITCH			2
#define TYPE_KEY			3
#define TYPE_INTEGER			4
#define TYPE_STRING			5

static struct SetupInfo si;
static struct LevelDirInfo ldi;
static struct TokenInfo token_info[] =
{
  /* global setup */
  { TYPE_STRING,  &si.player_name,	"player_name"			},
  { TYPE_SWITCH,  &si.sound,		"sound"				},
  { TYPE_SWITCH,  &si.sound_loops,	"repeating_sound_loops"		},
  { TYPE_SWITCH,  &si.sound_music,	"background_music"		},
  { TYPE_SWITCH,  &si.sound_simple,	"simple_sound_effects"		},

  { TYPE_SWITCH,  &si.quick_doors,	"quick_doors"			},
  { TYPE_SWITCH,  &si.handicap,		"handicap"			},
  { TYPE_SWITCH,  &si.time_limit,	"time_limit"			},
  { TYPE_SWITCH,  &si.fullscreen,	"fullscreen"			},

  /* level directory info */
  { TYPE_STRING,  &ldi.name,		"name"				},
  { TYPE_STRING,  &ldi.name_short,	"name_short"			},
  { TYPE_STRING,  &ldi.name_sorting,	"name_sorting"			},
  { TYPE_STRING,  &ldi.author,		"author"			},
  { TYPE_STRING,  &ldi.imported_from,	"imported_from"			},
  { TYPE_INTEGER, &ldi.levels,		"levels"			},
  { TYPE_INTEGER, &ldi.first_level,	"first_level"			},
  { TYPE_INTEGER, &ldi.sort_priority,	"sort_priority"			},
  { TYPE_BOOLEAN, &ldi.level_group,	"level_group"			},
  { TYPE_BOOLEAN, &ldi.readonly,	"readonly"			}
};

static void setLevelDirInfoToDefaults(struct LevelDirInfo *ldi)
{
  ldi->filename = NULL;
  ldi->fullpath = NULL;
  ldi->basepath = NULL;
  ldi->name = getStringCopy(ANONYMOUS_NAME);
  ldi->name_short = NULL;
  ldi->name_sorting = NULL;
  ldi->author = getStringCopy(ANONYMOUS_NAME);
  ldi->imported_from = NULL;
  ldi->levels = 0;
  ldi->first_level = 0;
  ldi->last_level = 0;
  ldi->sort_priority = LEVELCLASS_UNDEFINED;	/* default: least priority */
  ldi->level_group = FALSE;
  ldi->parent_link = FALSE;
  ldi->user_defined = FALSE;
  ldi->readonly = TRUE;
  ldi->color = 0;
  ldi->class_desc = NULL;
  ldi->handicap_level = 0;
  ldi->cl_first = -1;
  ldi->cl_cursor = -1;

  ldi->node_parent = NULL;
  ldi->node_group = NULL;
  ldi->next = NULL;
}

static void setLevelDirInfoToDefaultsFromParent(struct LevelDirInfo *ldi,
						struct LevelDirInfo *parent)
{
  if (parent == NULL)
  {
    setLevelDirInfoToDefaults(ldi);
    return;
  }

  /* first copy all values from the parent structure ... */
  *ldi = *parent;

  /* ... then set all fields to default that cannot be inherited from parent.
     This is especially important for all those fields that can be set from
     the 'levelinfo.conf' config file, because the function 'setSetupInfo()'
     calls 'free()' for all already set token values which requires that no
     other structure's pointer may point to them!
  */

  ldi->filename = NULL;
  ldi->fullpath = NULL;
  ldi->basepath = NULL;
  ldi->name = getStringCopy(ANONYMOUS_NAME);
  ldi->name_short = NULL;
  ldi->name_sorting = NULL;
  ldi->author = getStringCopy(parent->author);
  ldi->imported_from = getStringCopy(parent->imported_from);

  ldi->level_group = FALSE;
  ldi->parent_link = FALSE;

  ldi->node_parent = parent;
  ldi->node_group = NULL;
  ldi->next = NULL;
}

static void setSetupInfoToDefaults(struct SetupInfo *si)
{
  si->player_name = getStringCopy(getLoginName());

  si->sound = TRUE;
  si->sound_loops = TRUE;
  si->sound_music = TRUE;
  si->sound_simple = TRUE;
  si->toons = TRUE;
  si->quick_doors = FALSE;
  si->handicap = TRUE;
  si->time_limit = TRUE;
  si->fullscreen = FALSE;
}

static void setSetupInfo(int token_nr, char *token_value)
{
  int token_type = token_info[token_nr].type;
  void *setup_value = token_info[token_nr].value;

  if (token_value == NULL)
    return;

  /* set setup field to corresponding token value */
  switch (token_type)
  {
    case TYPE_BOOLEAN:
    case TYPE_SWITCH:
      *(boolean *)setup_value = get_string_boolean_value(token_value);
      break;

    case TYPE_KEY:
      *(Key *)setup_value = getKeyFromX11KeyName(token_value);
      break;

    case TYPE_INTEGER:
      *(int *)setup_value = get_string_integer_value(token_value);
      break;

    case TYPE_STRING:
      if (*(char **)setup_value != NULL)
	free(*(char **)setup_value);
      *(char **)setup_value = getStringCopy(token_value);
      break;

    default:
      break;
  }
}

static void decodeSetupFileList(struct SetupFileList *setup_file_list)
{
  int i;

  if (!setup_file_list)
    return;

  /* handle global setup values */
  si = setup;
  for (i=FIRST_GLOBAL_SETUP_TOKEN; i<=LAST_GLOBAL_SETUP_TOKEN; i++)
    setSetupInfo(i, getTokenValue(setup_file_list, token_info[i].text));
  setup = si;
}

static int compareLevelDirInfoEntries(const void *object1, const void *object2)
{
  const struct LevelDirInfo *entry1 = *((struct LevelDirInfo **)object1);
  const struct LevelDirInfo *entry2 = *((struct LevelDirInfo **)object2);
  int compare_result;

  if (entry1->parent_link || entry2->parent_link)
    compare_result = (entry1->parent_link ? -1 : +1);
  else if (entry1->sort_priority == entry2->sort_priority)
  {
    char *name1 = getStringToLower(entry1->name_sorting);
    char *name2 = getStringToLower(entry2->name_sorting);

    compare_result = strcmp(name1, name2);

    free(name1);
    free(name2);
  }
  else if (LEVELSORTING(entry1) == LEVELSORTING(entry2))
    compare_result = entry1->sort_priority - entry2->sort_priority;
  else
    compare_result = LEVELSORTING(entry1) - LEVELSORTING(entry2);

  return compare_result;
}

static void createParentLevelDirNode(struct LevelDirInfo *node_parent)
{
  struct LevelDirInfo *leveldir_new = newLevelDirInfo();

  setLevelDirInfoToDefaults(leveldir_new);

  leveldir_new->node_parent = node_parent;
  leveldir_new->parent_link = TRUE;

  leveldir_new->name = ".. (parent directory)";
  leveldir_new->name_short = getStringCopy(leveldir_new->name);
  leveldir_new->name_sorting = getStringCopy(leveldir_new->name);

  leveldir_new->filename = "..";
  leveldir_new->fullpath = getStringCopy(node_parent->fullpath);

  leveldir_new->sort_priority = node_parent->sort_priority;
  leveldir_new->class_desc = getLevelClassDescription(leveldir_new);

  pushLevelDirInfo(&node_parent->node_group, leveldir_new);
}

static void LoadLevelInfoFromLevelDir(struct LevelDirInfo **node_first,
				      struct LevelDirInfo *node_parent,
				      char *level_directory)
{
  DIR *dir;
  struct dirent *dir_entry;
  boolean valid_entry_found = FALSE;

  if ((dir = opendir(level_directory)) == NULL)
  {
    Error(ERR_WARN, "cannot read level directory '%s'", level_directory);
    return;
  }

  while ((dir_entry = readdir(dir)) != NULL)	/* loop until last dir entry */
  {
    struct SetupFileList *setup_file_list = NULL;
    struct stat file_status;
    char *directory_name = dir_entry->d_name;
    char *directory_path = getPath2(level_directory, directory_name);
    char *filename = NULL;

    /* skip entries for current and parent directory */
    if (strcmp(directory_name, ".")  == 0 ||
	strcmp(directory_name, "..") == 0)
    {
      free(directory_path);
      continue;
    }

    /* find out if directory entry is itself a directory */
    if (stat(directory_path, &file_status) != 0 ||	/* cannot stat file */
	(file_status.st_mode & S_IFMT) != S_IFDIR)	/* not a directory */
    {
      free(directory_path);
      continue;
    }

    filename = getPath2(directory_path, LEVELINFO_FILENAME);
    setup_file_list = loadSetupFileList(filename);

    if (setup_file_list)
    {
      struct LevelDirInfo *leveldir_new = newLevelDirInfo();
      int i;

      checkSetupFileListIdentifier(setup_file_list, LEVELINFO_COOKIE);
      setLevelDirInfoToDefaultsFromParent(leveldir_new, node_parent);

      /* set all structure fields according to the token/value pairs */
      ldi = *leveldir_new;
      for (i=FIRST_LEVELINFO_TOKEN; i<=LAST_LEVELINFO_TOKEN; i++)
	setSetupInfo(i, getTokenValue(setup_file_list, token_info[i].text));
      *leveldir_new = ldi;

      DrawInitText(leveldir_new->name, 150, FC_YELLOW);

      if (leveldir_new->name_short == NULL)
	leveldir_new->name_short = getStringCopy(leveldir_new->name);

      if (leveldir_new->name_sorting == NULL)
	leveldir_new->name_sorting = getStringCopy(leveldir_new->name);

      leveldir_new->filename = getStringCopy(directory_name);

      if (node_parent == NULL)		/* top level group */
      {
	leveldir_new->basepath = level_directory;
	leveldir_new->fullpath = leveldir_new->filename;
      }
      else				/* sub level group */
      {
	leveldir_new->basepath = node_parent->basepath;
	leveldir_new->fullpath = getPath2(node_parent->fullpath,
					  directory_name);
      }

      if (leveldir_new->levels < 1)
	leveldir_new->levels = 1;

      leveldir_new->last_level =
	leveldir_new->first_level + leveldir_new->levels - 1;

      leveldir_new->user_defined =
	(leveldir_new->basepath == options.level_directory ? FALSE : TRUE);

      leveldir_new->color = LEVELCOLOR(leveldir_new);
      leveldir_new->class_desc = getLevelClassDescription(leveldir_new);

      leveldir_new->handicap_level =	/* set handicap to default value */
	(leveldir_new->user_defined ?
	 leveldir_new->last_level :
	 leveldir_new->first_level);

      pushLevelDirInfo(node_first, leveldir_new);

      freeSetupFileList(setup_file_list);
      valid_entry_found = TRUE;

      if (leveldir_new->level_group)
      {
	/* create node to link back to current level directory */
	createParentLevelDirNode(leveldir_new);

	/* step into sub-directory and look for more level series */
	LoadLevelInfoFromLevelDir(&leveldir_new->node_group,
				  leveldir_new, directory_path);
      }
    }
    else
      Error(ERR_WARN, "ignoring level directory '%s'", directory_path);

    free(directory_path);
    free(filename);
  }

  closedir(dir);

  if (!valid_entry_found)
    Error(ERR_WARN, "cannot find any valid level series in directory '%s'",
	  level_directory);
}

void LoadLevelInfo()
{
  InitUserLevelDirectory(getLoginName());

  DrawInitText("Loading level series:", 120, FC_GREEN);

  LoadLevelInfoFromLevelDir(&leveldir_first, NULL, options.level_directory);
  LoadLevelInfoFromLevelDir(&leveldir_first, NULL, getUserLevelDir(""));

  leveldir_current = getFirstValidLevelSeries(leveldir_first);

  if (leveldir_first == NULL)
    Error(ERR_EXIT, "cannot find any valid level series in any directory");

  sortLevelDirInfo(&leveldir_first, compareLevelDirInfoEntries);

#if 0
  dumpLevelDirInfo(leveldir_first, 0);
#endif
}

static void SaveUserLevelInfo()
{
  char *filename;
  FILE *file;
  int i;

  filename = getPath2(getUserLevelDir(getLoginName()), LEVELINFO_FILENAME);

  if (!(file = fopen(filename, MODE_WRITE)))
  {
    Error(ERR_WARN, "cannot write level info file '%s'", filename);
    free(filename);
    return;
  }

  /* always start with reliable default values */
  setLevelDirInfoToDefaults(&ldi);

  ldi.name = getLoginName();
  ldi.author = getRealName();
  ldi.levels = 100;
  ldi.first_level = 1;
  ldi.sort_priority = LEVELCLASS_USER_START;
  ldi.readonly = FALSE;

  fprintf(file, "%s\n\n",
	  getFormattedSetupEntry(TOKEN_STR_FILE_IDENTIFIER, LEVELINFO_COOKIE));

  for (i=FIRST_LEVELINFO_TOKEN; i<=LAST_LEVELINFO_TOKEN; i++)
    if (i != LEVELINFO_TOKEN_NAME_SHORT &&
	i != LEVELINFO_TOKEN_NAME_SORTING &&
	i != LEVELINFO_TOKEN_IMPORTED_FROM)
      fprintf(file, "%s\n", getSetupLine("", i));

  fclose(file);
  free(filename);

  SetFilePermissions(filename, PERMS_PRIVATE);
}

void LoadSetup()
{
  char *filename;
  struct SetupFileList *setup_file_list = NULL;

  /* always start with reliable default values */
  setSetupInfoToDefaults(&setup);

  filename = getPath2(getSetupDir(), SETUP_FILENAME);

  setup_file_list = loadSetupFileList(filename);

  if (setup_file_list)
  {
    checkSetupFileListIdentifier(setup_file_list, SETUP_COOKIE);
    decodeSetupFileList(setup_file_list);

    freeSetupFileList(setup_file_list);

    /* needed to work around problems with fixed length strings */
    if (strlen(setup.player_name) > MAX_PLAYER_NAME_LEN)
      setup.player_name[MAX_PLAYER_NAME_LEN] = '\0';
    else if (strlen(setup.player_name) < MAX_PLAYER_NAME_LEN)
    {
      char *new_name = checked_malloc(MAX_PLAYER_NAME_LEN + 1);

      strcpy(new_name, setup.player_name);
      free(setup.player_name);
      setup.player_name = new_name;
    }
  }
  else
    Error(ERR_WARN, "using default setup values");

  free(filename);
}

static char *getSetupLine(char *prefix, int token_nr)
{
  int i;
  static char entry[MAX_LINE_LEN];
  int token_type = token_info[token_nr].type;
  void *setup_value = token_info[token_nr].value;
  char *token_text = token_info[token_nr].text;

  /* start with the prefix, token and some spaces to format output line */
  sprintf(entry, "%s%s:", prefix, token_text);
  for (i=strlen(entry); i<TOKEN_VALUE_POSITION; i++)
    strcat(entry, " ");

  /* continue with the token's value (which can have different types) */
  switch (token_type)
  {
    case TYPE_BOOLEAN:
      strcat(entry, (*(boolean *)setup_value ? "true" : "false"));
      break;

    case TYPE_SWITCH:
      strcat(entry, (*(boolean *)setup_value ? "on" : "off"));
      break;

    case TYPE_KEY:
      {
	Key key = *(Key *)setup_value;
	char *keyname = getKeyNameFromKey(key);

	strcat(entry, getX11KeyNameFromKey(key));
	for (i=strlen(entry); i<50; i++)
	  strcat(entry, " ");

	/* add comment, if useful */
	if (strcmp(keyname, "(undefined)") != 0 &&
	    strcmp(keyname, "(unknown)") != 0)
	{
	  strcat(entry, "# ");
	  strcat(entry, keyname);
	}
      }
      break;

    case TYPE_INTEGER:
      {
	char buffer[MAX_LINE_LEN];

	sprintf(buffer, "%d", *(int *)setup_value);
	strcat(entry, buffer);
      }
      break;

    case TYPE_STRING:
      strcat(entry, *(char **)setup_value);
      break;

    default:
      break;
  }

  return entry;
}

void SaveSetup()
{
  int i;
  char *filename;
  FILE *file;

  InitUserDataDirectory();

  filename = getPath2(getSetupDir(), SETUP_FILENAME);

  if (!(file = fopen(filename, MODE_WRITE)))
  {
    Error(ERR_WARN, "cannot write setup file '%s'", filename);
    free(filename);
    return;
  }

  fprintf(file, "%s\n",
	  getFormattedSetupEntry(TOKEN_STR_FILE_IDENTIFIER, SETUP_COOKIE));
  fprintf(file, "\n");

  /* handle global setup values */
  si = setup;
  for (i=FIRST_GLOBAL_SETUP_TOKEN; i<=LAST_GLOBAL_SETUP_TOKEN; i++)
  {
    fprintf(file, "%s\n", getSetupLine("", i));

    /* just to make things nicer :) */
    if (i == SETUP_TOKEN_PLAYER_NAME)
      fprintf(file, "\n");
  }

  fclose(file);
  free(filename);

  SetFilePermissions(filename, PERMS_PRIVATE);
}

void LoadLevelSetup_LastSeries()
{
  char *filename;
  struct SetupFileList *level_setup_list = NULL;

  /* always start with reliable default values */
  leveldir_current = getFirstValidLevelSeries(leveldir_first);

  /* ----------------------------------------------------------------------- */
  /* ~/.mirrormagic/levelsetup.conf                                          */
  /* ----------------------------------------------------------------------- */

  filename = getPath2(getSetupDir(), LEVELSETUP_FILENAME);

  if ((level_setup_list = loadSetupFileList(filename)))
  {
    char *last_level_series =
      getTokenValue(level_setup_list, TOKEN_STR_LAST_LEVEL_SERIES);

    leveldir_current = getLevelDirInfoFromFilename(last_level_series);
    if (leveldir_current == NULL)
      leveldir_current = leveldir_first;

    checkSetupFileListIdentifier(level_setup_list, LEVELSETUP_COOKIE);

    freeSetupFileList(level_setup_list);
  }
  else
    Error(ERR_WARN, "using default setup values");

  free(filename);
}

void SaveLevelSetup_LastSeries()
{
  char *filename;
  char *level_subdir = leveldir_current->filename;
  FILE *file;

  /* ----------------------------------------------------------------------- */
  /* ~/.mirrormagic/levelsetup.conf                                          */
  /* ----------------------------------------------------------------------- */

  InitUserDataDirectory();

  filename = getPath2(getSetupDir(), LEVELSETUP_FILENAME);

  if (!(file = fopen(filename, MODE_WRITE)))
  {
    Error(ERR_WARN, "cannot write setup file '%s'", filename);
    free(filename);
    return;
  }

  fprintf(file, "%s\n\n", getFormattedSetupEntry(TOKEN_STR_FILE_IDENTIFIER,
						 LEVELSETUP_COOKIE));
  fprintf(file, "%s\n", getFormattedSetupEntry(TOKEN_STR_LAST_LEVEL_SERIES,
					       level_subdir));

  fclose(file);
  free(filename);

  SetFilePermissions(filename, PERMS_PRIVATE);
}

static void checkSeriesInfo()
{
  static char *level_directory = NULL;
  DIR *dir;
  struct dirent *dir_entry;

  /* check for more levels besides the 'levels' field of 'levelinfo.conf' */

  level_directory = getPath2((leveldir_current->user_defined ?
			      getUserLevelDir("") :
			      options.level_directory),
			     leveldir_current->fullpath);

  if ((dir = opendir(level_directory)) == NULL)
  {
    Error(ERR_WARN, "cannot read level directory '%s'", level_directory);
    return;
  }

  while ((dir_entry = readdir(dir)) != NULL)	/* last directory entry */
  {
    if (strlen(dir_entry->d_name) > 4 &&
	dir_entry->d_name[3] == '.' &&
	strcmp(&dir_entry->d_name[4], LEVELFILE_EXTENSION) == 0)
    {
      char levelnum_str[4];
      int levelnum_value;

      strncpy(levelnum_str, dir_entry->d_name, 3);
      levelnum_str[3] = '\0';

      levelnum_value = atoi(levelnum_str);

      if (levelnum_value < leveldir_current->first_level)
      {
	Error(ERR_WARN, "additional level %d found", levelnum_value);
	leveldir_current->first_level = levelnum_value;
      }
      else if (levelnum_value > leveldir_current->last_level)
      {
	Error(ERR_WARN, "additional level %d found", levelnum_value);
	leveldir_current->last_level = levelnum_value;
      }
    }
  }

  closedir(dir);
}

void LoadLevelSetup_SeriesInfo()
{
  char *filename;
  struct SetupFileList *level_setup_list = NULL;
  char *level_subdir = leveldir_current->filename;

  /* always start with reliable default values */
  level_nr = leveldir_current->first_level;

  checkSeriesInfo(leveldir_current);

  /* ----------------------------------------------------------------------- */
  /* ~/.mirrormagic/levelsetup/<level series>/levelsetup.conf                */
  /* ----------------------------------------------------------------------- */

  level_subdir = leveldir_current->filename;

  filename = getPath2(getLevelSetupDir(level_subdir), LEVELSETUP_FILENAME);

  if ((level_setup_list = loadSetupFileList(filename)))
  {
    char *token_value;

    token_value = getTokenValue(level_setup_list, TOKEN_STR_LAST_PLAYED_LEVEL);

    if (token_value)
    {
      level_nr = atoi(token_value);

      if (level_nr < leveldir_current->first_level)
	level_nr = leveldir_current->first_level;
      if (level_nr > leveldir_current->last_level)
	level_nr = leveldir_current->last_level;
    }

    token_value = getTokenValue(level_setup_list, TOKEN_STR_HANDICAP_LEVEL);

    if (token_value)
    {
      int level_nr = atoi(token_value);

      if (level_nr < leveldir_current->first_level)
	level_nr = leveldir_current->first_level;
      if (level_nr > leveldir_current->last_level + 1)
	level_nr = leveldir_current->last_level;

      if (leveldir_current->user_defined)
	level_nr = leveldir_current->last_level;

      leveldir_current->handicap_level = level_nr;
    }

    checkSetupFileListIdentifier(level_setup_list, LEVELSETUP_COOKIE);

    freeSetupFileList(level_setup_list);
  }
  else
    Error(ERR_WARN, "using default setup values");

  free(filename);
}

void SaveLevelSetup_SeriesInfo()
{
  char *filename;
  char *level_subdir = leveldir_current->filename;
  char *level_nr_str = int2str(level_nr, 0);
  char *handicap_level_str = int2str(leveldir_current->handicap_level, 0);
  FILE *file;

  /* ----------------------------------------------------------------------- */
  /* ~/.mirrormagic/levelsetup/<level series>/levelsetup.conf                */
  /* ----------------------------------------------------------------------- */

  InitLevelSetupDirectory(level_subdir);

  filename = getPath2(getLevelSetupDir(level_subdir), LEVELSETUP_FILENAME);

  if (!(file = fopen(filename, MODE_WRITE)))
  {
    Error(ERR_WARN, "cannot write setup file '%s'", filename);
    free(filename);
    return;
  }

  fprintf(file, "%s\n\n", getFormattedSetupEntry(TOKEN_STR_FILE_IDENTIFIER,
						 LEVELSETUP_COOKIE));
  fprintf(file, "%s\n", getFormattedSetupEntry(TOKEN_STR_LAST_PLAYED_LEVEL,
					       level_nr_str));
  fprintf(file, "%s\n", getFormattedSetupEntry(TOKEN_STR_HANDICAP_LEVEL,
					       handicap_level_str));

  fclose(file);
  free(filename);

  SetFilePermissions(filename, PERMS_PRIVATE);
}
