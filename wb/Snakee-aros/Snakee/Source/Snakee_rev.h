#ifndef __VER_REV__
#define __VER_REV__

/*----------------------------------------------------------------------------*
 *                                 Includes                                   *
 *----------------------------------------------------------------------------*/

#include "Snakee_auth.h"

/*----------------------------------------------------------------------------*
 *                                  Defines                                   *
 *----------------------------------------------------------------------------*/

#define VERSION         "0"
#define REVISION        "2"

#define DATE            "24.01.09"

#define NAME            "Snakee"
#define VERS            NAME " "VERSION"."REVISION

#if defined (__MORPHOS__)
   #define VERSSHORT       VERSION"."REVISION" [MorphOS, PowerPC]"
#elif defined (__AROS__)
   #define VERSSHORT       VERSION"."REVISION" [AROS, x86]"
#elif defined (__amigaos4__)
   #define VERSSHORT       VERSION"."REVISION" [AmigaOS, PowerPC]"
#else
   #define VERSSHORT       VERSION"."REVISION" [AmigaOS, 68k]"
#endif


#define VSTRING         VERS" ("DATE") © "VYEARS " " AUTHOR ", " COMPANY
#define VERSTAG         "$VER:" VSTRING
#define VERSTAG_MUI     "$VER: "VERS " ("DATE")"
#define VERSTAG_SCREEN  VERS " ("DATE") "
#define ABOUT           "Snakee is a little MUI-based wormgame\nFirst released as some sort of MUI-tutorial =)\n\nAuthor : "AUTHOR " ("EMAIL")\nVersion : "VERSSHORT"\n\n\ec"URL"\n\n\ec©Copyright "VYEARS " " COMPANY

#endif  /* __VER_REV__ */
