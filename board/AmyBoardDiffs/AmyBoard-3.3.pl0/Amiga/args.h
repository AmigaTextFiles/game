/**
*** args.h -- Include file for ParseArgs(), an ReadArgs() replacement
*** Copyright 1995, Jochen Wiedmann
***
*** ------------------------------------------------------------------------
*** This program is free software; you can redistribute it and/or modify
*** it under the terms of the GNU General Public License as published by
*** the Free Software Foundation; either version 2 of the License, or
*** (at your option) any later version.
***
*** This program is distributed in the hope that it will be useful,
*** but WITHOUT ANY WARRANTY; without even the implied warranty of
*** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*** GNU General Public License for more details.
***
*** You should have received a copy of the GNU General Public License
*** along with this program; if not, write to the Free Software
*** Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*** ------------------------------------------------------------------------
***
*** See the file ChangeLog for a revision history.
***/

#ifndef _ARGS_H
#define _ARGS_H

#include <utility/tagitem.h>


/**
***  prototypes
**/
extern ULONG ParseArgsA(int argc, char *argv[], struct TagItem *);
extern ULONG ParseArgs(int argc, char *argv[], Tag firsttag, ...);


/**
***  Tag ID's
**/
#define PARSEARGS_BASE (TAG_USER | (86 << 16) | 0x100)

#define PARSEARGS_ARGNAME                   (PARSEARGS_BASE | 0x00)
#define PARSEARGS_TYPE                      (PARSEARGS_BASE | 0x01)
#define PARSEARGS_TYPE_STRING               0
#define PARSEARGS_TYPE_BOOL                 1
#define PARSEARGS_TYPE_INTEGER              2
#define PARSEARGS_TYPE_FLOAT                3
#define PARSEARGS_VALPTR                    (PARSEARGS_BASE | 0x02)
#define PARSEARGS_PREFSFILE                 (PARSEARGS_BASE | 0x03)
#define PARSEARGS_HELPSTRING                (PARSEARGS_BASE | 0x04)
#define PARSEARGS_MULTIARG                  (PARSEARGS_BASE | 0x05)
#define PARSEARGS_REQUIRED                  (PARSEARGS_BASE | 0x06)


#endif  /* !_ARGS_H */
