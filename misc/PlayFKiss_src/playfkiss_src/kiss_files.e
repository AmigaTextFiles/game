/*
** Kiss file headers definions by Michal Durys
** Send comments to misha@femina.com.pl
*/

OPT MODULE
OPT EXPORT

-> File header
OBJECT kiss_fileheader
  id:LONG
  mark:CHAR
ENDOBJECT

-> Palette file header
OBJECT kiss_palettefileheader
  id:LONG
  mark:CHAR
  bitspercolor:CHAR
  reserved01:INT
  colors:INT
  groups:INT
  reserved02[20]:ARRAY OF CHAR
ENDOBJECT

-> Cel file header
OBJECT kiss_celfileheader
  id:LONG
  mark:CHAR
  bitsperpixel:CHAR
  reserved01:INT
  width:INT
  height:INT
  xoffset:INT
  yoffset:INT
  reserved02[16]:ARRAY OF CHAR
ENDOBJECT

-> Cel file header
OBJECT kiss_celrawfileheader
  width:INT
  height:INT
ENDOBJECT

CONST KISS_ID="KiSS",
      FILEMARK_PALETTE=$10,
      FILEMARK_CEL=$20,
      FILEMARK_CHERRYCEL=$21,
      SIZEOF_KISSHEADER=32
