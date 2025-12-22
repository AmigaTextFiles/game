#include "frobnitz.h"

/*******************************************************************/
/*  Funktion: WhichGame                                            */
/*******************************************************************/

/*  corresponds to Infocom Fact Sheet 4.3 of April 19, 1993        */
/*  (only the versions I own)                                      */

int
WhichGame (void)
{
  static long version_table[] =
  {
    1, 23, 820428,
    1, 25, 820515,
    1, 28, 821013,
    1, 30, 830330,
    1, 75, 830929,
    1, 76, 840509,
    1, 88, 840726,
    1, 52, 871125,		/* Zork I */

    2, 17, 820427,
    2, 18, 820517,
    2, 22, 830331,
    2, 48, 840904,		/* Zork II */

    3, 10, 820818,
    3, 15, 830331,
    3, 15, 840518,
    3, 17, 840727,		/* Zork III */

    4, 15, 820901,
    4, 17, 821021,		/* Starcross */

    5, 26, 821108,
    5, 27, 831005,		/* Deadline */

    6, 7, 830419,
    6, 8, 830521,
    6, 8, 840521,		/* Suspended */

    7, 13, 830524,
    7, 20, 831119,
    7, 21, 831208,
    7, 22, 840924,		/* Witness */

    8, 20, 830708,
    8, 29, 840118,
    8, 37, 851003,
    8, 10, 880531,		/* Planetfall */

    9, 10, 830810,
    9, 16, 831118,
    9, 24, 851118,
    9, 29, 860820,		/* Enchanter */

    10, 22, 830916,		/* Infidel */

    11, 15, 840501,
    11, 15, 840522,
    11, 16, 850515,
    11, 16, 850603,		/* Seastalker */

    12, 4, 840131,
    12, 6, 840508,
    12, 13, 851021,
    12, 15, 851108,
    12, 18, 860904,		/* Sorcerer */

    13, 23, 840809,		/* Cutthroats */

    14, 47, 840914,
    14, 56, 841221,
    14, 58, 851002,
    14, 59, 851108,
    14, 31, 871119,		/* Hitchhiker */

    15, 14, 841005,		/* Suspect */

    16, 68, 850501,
    16, 69, 850920,
    16, 23, 880706,		/* Wishbringer */

    17, 77, 850814,
    17, 79, 851122,		/* AMFV */

    18, 63, 850916,
    18, 87, 860904,		/* Spellbreaker */

    19, 97, 851218,		/* Ballyhoo */

    20, 11, 860509,
    20, 12, 860926,		/* Trinity */

    21, 59, 860730,
    21, 4, 880405,		/* LGOP */

    22, 4, 860918,
    22, 9, 861022,		/* Moonmist */

    23, 37, 861215,		/* Hollywood Hijinx */

    24, 86, 870212,
    24, 116, 870602,		/* Bureaucracy */

    25, 107, 870430,		/* Stationfall */

    26, 203, 870506,
    29, 219, 870912,
    26, 221, 870918,		/* Lurking Horror */

    27, 26, 870730,		/* Plundered Hearts */

    28, 19, 870722,		/* Nord And Bert */

    29, 47, 870915,
    29, 49, 870917,
    29, 51, 870923,
    29, 57, 871221,		/* Beyond Zork */

    30, 9, 871008,		/* Border Zone */

    31, 21, 871214,
    31, 26, 880127,		/* Sherlock */

    32, 296, 881019,
    32, 366, 890323,
    32, 393, 890714,		/* Zork Zero */

    33, 295, 890321,
    33, 322, 890706,		/* Shogun */

    34, 30, 890322,
    34, 83, 890706,		/* Journey */

    35, 54, 890606,
    35, 74, 890714,		/* Arthur */

    0, 0, 0			/* UNKNOWN */
  };

  long release, revision;
  long t_game, t_release, t_revision;
  int count = 0;

  release = header.release;
  revision = atol (header.rev_date);

  while (t_game != 0)
    {
      t_game = version_table[count++];
      t_release = version_table[count++];
      t_revision = version_table[count++];

      if ((release == t_release) && (revision == t_revision))
	break;
    }

  return (t_game);
}

/*******************************************************************/
/*  Funktion: PrintGame                                            */
/*******************************************************************/

void
PrintGame (int number)
{
  static char *game_name[] =
  {
    "Unknown (...please contact me!)",
    "Zork I - The Great Underground Empire",
    "Zork II - The Wizard Of Frobozz",
    "Zork III - The Dungeon Master",
    "Starcross",
    "Deadline",
    "Suspended",
    "The Witness",
    "Planetfall",
    "Enchanter",
    "Infidel",
    "Seastalker",
    "Sorcerer",
    "Cutthroats",
    "The Hitchhiker's Guide To The Galaxy",
    "Suspect",
    "Wishbringer - The Magick Stone Of Dreams",
    "A Mind Forever Voyaging",
    "Spellbreaker",
    "Ballyhoo",
    "Trinity",
    "Leather Goddesses Of Phobos",
    "Moonmist",
    "Hollywood Hijinx",
    "Bureaucracy",
    "Stationfall",
    "The Lurking Horror",
    "Plundered Hearts",
    "Nord And Bert Couldn't Make Head Or Tail Of It",
    "Beyond Zork",
    "Border Zone",
    "Sherlock - The Riddle Of The Crown Jewels",
    "Zork Zero - The Revenge Of Megaboz",
    "James Clavell's Shogun",
    "Journey",
    "Arthur - The Quest For Excalibur"
  };

  printf ("GAME:\n\n");
  if (is_savefile)
    printf ("Savefile of \"");
  printf ("%s", game_name[number]);
  if (is_savefile)
    printf ("\" (level %d)", header_level);
  newline ();
}
