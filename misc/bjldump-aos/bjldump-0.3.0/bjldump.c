/*
 *	bjldump.c - dump Bombjack levels
 *	AYM 2001-07-21
 */


/*
This file is copyright André Majorel 2001.

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 59 Temple
Place, Suite 330, Boston, MA 02111-1307, USA.
*/


#include <errno.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <unistd.h>


const char *version = "0.3.0";


/* One Bombjack level. The "payload" size is 26x26. */
#define LEVEL_WIDTH  28
#define LEVEL_HEIGHT 32
typedef struct
{
  char data[LEVEL_HEIGHT][LEVEL_WIDTH];
} level_t;

#define WORLD  (1 << 16)	/* 64 kB, the address space of a Z80 */
#define XOFS   2	/* For some reason, Bombjack adds 2 to x offsets */
#define BOMBS  24	/* 24 bombs in a Bombjack level */
#define LEVELS 16	/* Distinct platform designs and bomb designs */
unsigned pplattable = 0x4c0b;  /* Address of a pointer to the platform table */
unsigned pbombtable = 0x6212;  /* Address of a pointer to the bomb table */


static int  file_dump  (const char *ifile, FILE *ifp);
static void level_init (level_t *level);
static int  level_dump (const level_t *level, FILE *fp);
static void err        (const char *fmt, ...);
static int  getaddr    (const unsigned char *world, size_t horizon,
			unsigned address, unsigned *value);
static int  getbyte    (const unsigned char *world, size_t horizon,
			unsigned address, unsigned char *value);
static int  memis      (const void *mem, char c, size_t len);


int main (int argc, char *argv[])
{
  int         rc         = 0;
  const char *file       = NULL;

  /* Parse the command line */
  if (argc == 2 && strcmp (argv[1], "--help") == 0)
  {
    fputs (
      "Usage:\n"
     "  bjldump --help\n"
     "  bjldump --version\n"
     "  bjldump [-s num] file\n"
     "Options:\n"
     "  --help     Print help to stdout and exit successfully\n"
     "  --version  Print version number to stdout and exit successfully\n",
     stdout);
    exit (0);
  }
  if (argc == 2 && strcmp (argv[1], "--version") == 0)
  {
    puts (version);
    exit (0);
  }
  {
    int g;

    while ((g = getopt (argc, argv, "")) != EOF)
    {
      exit (1);
    }
  }
  if (argc - optind != 1)
  {
    err ("wrong number of arguments");
    exit (1);
  }
  file = argv[optind];
  
  /* Dump all levels */
  if (file_dump (file, NULL) != 0)
    rc = 1;

  exit (rc);
}


/*
 *	file_dump - dump all the levels in a file
 *
 *	Return 0 on success, non-zero on failure.
 */
static int file_dump (const char *ifile, FILE *ifp)
{
  int            rc       = 0;
  int            icloseme = 0;
  unsigned char *world    = NULL;
  size_t         horizon;
  FILE          *ofp      = stdout;
  unsigned       address;
  level_t        level;
  int            x;
  int            y        = 0;
  int            l;

  /* Open input file if necessary */
  if (ifp == NULL)
  {
    icloseme = 1;
    ifp = fopen (ifile, "rb");
    if (ifp == NULL)
    {
      err ("%s: %s", ifile, strerror (errno));
      rc = 1;
      goto byebye;
    }
  }

  /* Do the genesis thing */
  world = malloc (WORLD);
  if (world == NULL)
  {
    err ("%s", strerror (ENOMEM));
    rc = 1;
    goto byebye;
  }
  horizon = fread (world, 1, WORLD, ifp);
  if (horizon < 1 || ferror (ifp))
  {
    err ("%s: read error", ifile);
    rc = 1;
    goto byebye;
  }


  /* Dump all levels */
  for (l = 0; l < LEVELS; l++)
  {
    unsigned first_row;
    unsigned nrows = 0;
    unsigned r;
    unsigned plat_table;
    unsigned plat_routine;
    unsigned plat_design;

    level_init (&level);
    
    if (getaddr (world, horizon, pplattable, &plat_table) != 0)
    {
      err ("%s(%Xh): can't get address of platform table", ifile, pplattable);
      rc = 1;
      goto byebye;
    }
    if (getaddr (world, horizon, plat_table + 2 * l, &plat_routine) != 0)
    {
      err ("%s(%Xh): can't read platform table entry", ifile, plat_table);
      rc = 1;
      goto byebye;
    }
    {
      unsigned a = plat_routine;
      unsigned char b1, b2, b3;

      /* Skip call $7d32 */
      if (getbyte (world, horizon, a + 0, &b1) != 0
       || getbyte (world, horizon, a + 1, &b2) != 0
       || getbyte (world, horizon, a + 2, &b3) != 0)
      {
	err ("%s(%Xh): can't read platform routine", ifile, a);
	rc = 1;
	goto byebye;
      }
      if (! (b1 == 0xcd && b2 == 0x32 && b3 == 0x7d))
      {
	err ("%s(%Xh): expected call $7d32", ifile, a);
	rc = 1;
	goto byebye;
      }
      a += 3;
      if (getbyte (world, horizon, a + 0, &b1) != 0
       || getbyte (world, horizon, a + 1, &b2) != 0
       || getbyte (world, horizon, a + 2, &b3) != 0)
      {
	err ("%s(%Xh): can't read platform routine", ifile, a);
	rc = 1;
	goto byebye;
      }
      a += 3;
      /* Call $00cf : data address follows immediately */
      if (! (b1 == 0xcd && b2 == 0xcf && b3 == 0x00))
	goto platform_end;
      if (getaddr (world, horizon, a + 0, &address) != 0)
      {
	err ("%s(%Xh): can't read platform design address", ifile, a);
	rc = 1;
	goto byebye;
      }
    }

    /* Read platform data header (array of row offsets) */
    if (getaddr (world, horizon, address, &first_row) != 0)
    {
      err ("%s(%Xh): read error row list", ifile, address);
      rc = 1;
      goto byebye;
    }
    address += 2;
    if (first_row < address || first_row > address + 1000)
    {
      err ("%s(%Xh): invalid row address %Xh", ifile, address, first_row);
      rc = 1;
      goto byebye;
    }
    nrows = 1;
    printf ("%Xh: %Xh", address - 2, first_row);
    while (address < first_row)
    {
      unsigned dummy;

      if (getaddr (world, horizon, address, &dummy) != 0)
      {
	err ("%s(%Xh): read error in row list", ifile, address);
	rc = 1;
	goto byebye;
      }
      address += 2;
      if (dummy < address || dummy > address + 1000)
      {
	err ("%s(%Xh): invalid row address %Xh", ifile, address, dummy);
	rc = 1;
	goto byebye;
      }
      nrows++;
      printf (" %Xh", dummy);
    }
    fputc ('\n', stdout);
    if (address != first_row)
    {
      err ("%s(%Xh): got past first row (%Xh)", ifile, address, first_row);
      rc = 1;
      goto byebye;
    }

    /* Read all rows */
    for (r = 0; r < nrows; r++)
    {
      unsigned char c1, c2;

      /* Row header */
      if (getbyte (world, horizon, address,     &c1) != 0
       || getbyte (world, horizon, address + 1, &c2) != 0)
      {
	err ("%s(%Xh): read error in row header", ifile, address);
	rc = 1;
	goto byebye;
      }
      address += 2;
      if (c1 < 0 || c1 >= LEVEL_HEIGHT)
	break;

      if ((c2 - XOFS) < 0 || (c2 - XOFS) >= LEVEL_WIDTH)
	break;

      x = c2 - XOFS;
      y = c1;

      /* Row body */
      for (;;)
      {
	if (getbyte (world, horizon, address,     &c1) != 0
	 || getbyte (world, horizon, address + 1, &c2) != 0)
	{
	  err ("%s(%Xh): read error in row header", ifile, address);
	  rc = 1;
	  goto byebye;
	}
	address += 2;

	if (c2 == 9 && c1 >= 0x60 && c1 <= 0x6f)
	{
	  static const char xcode[16] = "()==^v||####<>T+";
	  level.data[y][x] = xcode[c1 - 0x60];
	  x++;
	}
	else if (c2 == 0xff && (c1 - XOFS) >= 0 && (c1 - XOFS) < LEVEL_WIDTH)
	{
	  x += c1;
	}
	else if (c2 == 0xff && c1 == 0xff)
	{
	  break;
	}
	else if (c2 == 0 && c1 == 0)
	{
	  ;  /* I don't know why there is always 00 00 after a jump */
	}
	else
	{
	  err ("%s(%Xh): unexpected bytes %02Xh %02Xh in row body",
	      ifile, address, c1, c2);
	  rc = 1;
	  goto byebye;
	}
      }
    }
platform_end:

    /* Add bombs */
    {
      unsigned bomb_table;
      unsigned bomb_design;
      int n;
      
      if (getaddr (world, horizon, pbombtable, &bomb_table) != 0)
      {
	err ("%s(%Xh): can't get address of bomb table", ifile, pbombtable);
	rc = 1;
	goto byebye;
      }
      if (getaddr (world, horizon, bomb_table + 2 * l, &bomb_design) != 0)
      {
	err ("%s(%Xh): can't read bomb table entry", ifile, bomb_table);
	rc = 1;
	goto byebye;
      }
      for (n = 0; n < BOMBS; n++)
      {
	unsigned      address = bomb_design + n;
	unsigned char byte;
	int           x;
	int           y;

	if (getbyte (world, horizon, address, &byte) != 0)
	{
	  err ("%s(%Xh): can't read bomb design data", ifile, address);
	  rc = 1;
	  goto byebye;
	}
	x = 1 + 3 * (byte >> 4);
	y = 3 + 3 * (byte & 0x0f);
	level.data[y + 0][x + 0] = '/';
	level.data[y + 0][x + 1] = '\\';
	level.data[y + 1][x + 0] = '\\';
	level.data[y + 1][x + 1] = '/';
      }
    }
 
    level_dump (&level, ofp);
    fputc ('\n', ofp);
  }

byebye:
  if (ifp != NULL && icloseme)
    fclose (ifp);
  if (world != NULL)
    free (world);
  return rc;
}


/*
 *	level_init - initialize a level_t object
 */
static void level_init (level_t *level)
{
  int x;
  int y;
  int x0 = 0;
  int x1 = LEVEL_WIDTH - 1;
  int y0 = 2;
  int y1 = LEVEL_HEIGHT - 3;

  for (y = 0; y < LEVEL_HEIGHT; y++)
  {
    if (y >= y0 && y <= y1)
      level->data[y][x0] = '@';
    else
      level->data[y][x0] = ' ';
    for (x = x0 + 1; x < x1; x++)
      if (y == y0 || y == y1)
	level->data[y][x] = '@';
      else
	level->data[y][x] = ' ';
    if (y >= y0 && y <= y1)
      level->data[y][x1] = '@';
    else
      level->data[y][x1] = ' ';
  }
}


/*
 *	level_dump - dump a level_t object to file
 *
 *	Return 0 on success, non-zero on failure.
 */
static int level_dump (const level_t *level, FILE *fp)
{
  int y;
  int y0 = 0;
  int y1 = LEVEL_HEIGHT;

  /* If the top two rows and bottom two rows are empty (which is
     normally the case), omit them. */
  for (y0 = 0; y0 < 2; y0++)
    if (! memis (level->data[y0], ' ', LEVEL_WIDTH))
      break;
  for (y1 = LEVEL_HEIGHT; y1 > LEVEL_HEIGHT - 2; y1--)
    if (! memis (level->data[y1 - 1], ' ', LEVEL_WIDTH))
      break;

  for (y = y0; y < y1; y++)
  {
    fwrite (level->data[y], LEVEL_WIDTH, 1, fp);
    fputc ('\n', fp);
  }
  return ferror (fp);
}


/*
 *	err - printf an error message, following by a newline
 */
static void err (const char *fmt, ...)
{
  va_list argp;

  fflush (stdout);
  fputs ("bjldump: ", stderr);
  va_start (argp, fmt);
  vfprintf (stderr, fmt, argp);
  va_end (argp);
  fputc ('\n', stderr);
}


/*
 *	getaddr - read a Z80-format (little-endian) address from memory
 *
 *	Return 0 on success, non-zero on failure.
 */
static int getaddr (const unsigned char *world, size_t horizon,
    unsigned address, unsigned *value)
{
  if (address >= horizon - 1)
    return 1;
  *value = (world[address + 1] << 8) | world[address];
  return 0;
}


/*
 *	getbyte - read a byte from memory
 *
 *	Return 0 on success, non-zero on failure.
 */
static int getbyte (const unsigned char *world, size_t horizon,
    unsigned address, unsigned char *value)
{
  if (address >= horizon)
    return 1;
  *value = world[address];
  return 0;
}


/*
 *	memis - test if memory is filled with a character
 *
 *	Return non-zero if true, zero if false.
 */
static int memis (const void *mem, char c, size_t len)
{
  const char *m    = mem;
  const char *mmax = m + len;

  for (; m < mmax; m++)
    if (*m != c)
      return 0;
  return 1;
}



