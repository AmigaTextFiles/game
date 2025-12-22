// Emacs style mode select   -*- C++ -*-
//-----------------------------------------------------------------------------
//
// $Id: i_video.c,v 1.12 1998/05/03 22:40:35 killough Exp $
//
//  BOOM, a modified and improved DOOM engine
//  Copyright (C) 1999 by
//  id Software, Chi Hoang, Lee Killough, Jim Flynn, Rand Phares, Ty Halderman
//
//  This program is free software; you can redistribute it and/or
//  modify it under the terms of the GNU General Public License
//  as published by the Free Software Foundation; either version 2
//  of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
//  02111-1307, USA.
//
// DESCRIPTION:
//      DOOM graphics stuff
//
//-----------------------------------------------------------------------------



static const char rcsid[] = "$Id: i_video.c,v 1.12 1998/05/03 22:40:35 killough Exp $";


#include "z_zone.h"  /* memory allocation wrappers -- killough */

#include "doomstat.h"
#include "v_video.h"
#include "i_video.h"
#include "d_main.h"
#include "lprintf.h"  // jff 08/03/98 - declaration of lprintf


// Amiga includes.
#include <libraries/asl.h>

#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
#include <proto/asl.h>
#include <proto/dos.h>
#include <clib/keymap_protos.h>
#include <clib/lowlevel_protos.h>
#include <clib/alib_protos.h>



#include "amiga_keyboard_codes.h"

#include "amiga_c2p_aga.h"



/** Hardware window */
static struct Window *_hardwareWindow = NULL;

/** Hardware screen */
static struct Screen *_hardwareScreen = NULL;

// Hardware double buffering.
static struct ScreenBuffer *_hardwareScreenBuffer[2];
static BYTE _currentScreenBuffer = 0;




static ULONG _agaPalette[1 + 3 * 256 + 1];
static boolean _paletteDirty = false;

static UWORD _emptypointer[] = {
  0x0000, 0x0000,    /* reserved, must be NULL */
  0x0000, 0x0000,     /* 1 row of image data */
  0x0000, 0x0000    /* reserved, must be NULL */
};


// AGA C2P.
void *c2p[2] = {NULL, NULL};




#define VIDEO_DEPTH 8





static int _xlate[104] = {
  '`', '1', '2', '3', '4', '5', '6', '7',
  '8', '9', '0', KEYD_MINUS, KEYD_EQUALS, '\\', 0, '0',
  'q', 'w', 'e', 'r', 't', 'y', 'u', 'i',
  'o', 'p', KEYD_F11, KEYD_F12, 0, '0', '2', '3',
  'a', 's', 'd', 'f', 'g', 'h', 'j', 'k',
  'l', ';', '\'', KEYD_ENTER, 0, '4', '5', '6',
  KEYD_RSHIFT, 'z', 'x', 'c', 'v', 'b', 'n', 'm',
  ',', '.', '/', 0, '.', '7', '8', '9',
  ' ', KEYD_BACKSPACE, KEYD_TAB, KEYD_ENTER, KEYD_ENTER, KEYD_ESCAPE, KEYD_F11,
  0, 0, 0, KEYD_MINUS, 0, KEYD_UPARROW, KEYD_DOWNARROW, KEYD_RIGHTARROW, KEYD_LEFTARROW,
  KEYD_F1, KEYD_F2, KEYD_F3, KEYD_F4, KEYD_F5, KEYD_F6, KEYD_F7, KEYD_F8,
  KEYD_F9, KEYD_F10, '(', ')', '/', '*', KEYD_EQUALS, KEYD_PAUSE,
  KEYD_RSHIFT, KEYD_RSHIFT, 0, KEYD_RCTRL, KEYD_LALT, KEYD_RALT, 0, KEYD_RCTRL
};




void I_FinishUpdate(void) {

	c2p8_stub(c2p[_currentScreenBuffer], _hardwareScreenBuffer[_currentScreenBuffer]->sb_BitMap, (UBYTE*)screens[0],(SCREENWIDTH * SCREENHEIGHT));

	// Check whether the palette was changed.
	if (_paletteDirty) {
        LoadRGB32(&_hardwareScreen->ViewPort, _agaPalette);

		// Reset.
		_paletteDirty = false;
	}

    if (ChangeScreenBuffer(_hardwareScreen, _hardwareScreenBuffer[_currentScreenBuffer])) {
        // Flip.
	   _currentScreenBuffer = _currentScreenBuffer ^ 1;
    }
}




// For key bindings, the values stored in the key_* variables       // phares
// are the internal Doom Codes. The values stored in the default.cfg
// file are the keyboard codes. I_ScanCode2DoomCode converts from
// keyboard codes to Doom Codes. I_DoomCode2ScanCode converts from
// Doom Codes to keyboard codes, and is only used when writing back
// to default.cfg. For the printable keys (i.e. alphas, numbers)
// the Doom Code is the ascii code.

int I_ScanCode2DoomCode (int a) {

	if (a < 104)
      return _xlate[a];
	else
      return 0;

}

// Automatic caching inverter, so you don't need to maintain two tables.
// By Lee Killough

int I_DoomCode2ScanCode (int a) {

  static int inverse[104], cache;

  for (;cache<104;cache++)
    inverse[I_ScanCode2DoomCode(cache)]=cache;

  return inverse[a];
}

int xlate_key(UWORD rawkey, struct IntuiMessage *imsg)
{
	char buffer[4], c;
	struct InputEvent ie;


	// '1'..'9', no SHIFT French keyboards
    if (rawkey > 0x00 && rawkey < 0x0a)
      return '0' + rawkey;

	if (rawkey == 0x0a)            // '0'
      return '0';

    if (rawkey < 0x40) {
      ie.ie_Class = IECLASS_RAWKEY;
      ie.ie_Code = rawkey;
      ie.ie_Qualifier = imsg->Qualifier;
      ie.ie_EventAddress = imsg->IAddress;
      if (MapRawKey (&ie, buffer, sizeof(buffer), NULL) > 0) {
        c = buffer[0];
        if (c >= '0' && c <= '9')       /* numeric pad */
          switch (c) {
          case '0':
            return ' ';
          case '1':
            return ',';
          case '2':
            return KEYD_RCTRL;
          case '3':
            return '.';
          case '4':
            return KEYD_LEFTARROW;
          case '5':
            return KEYD_DOWNARROW;
          case '6':
            return KEYD_RIGHTARROW;
          case '7':
            return ',';
          case '8':
            return KEYD_UPARROW;
          case '9':
            return '.';
          }
        else if (c >= 'A' && c <= 'Z')
          return c - 'A' + 'a';
        else if (c == '<')
          return ',';
        else if (c == '>')
          return '.';
        else if (c == '-')
          return KEYD_MINUS;
        else if (c == '=')
          return KEYD_EQUALS;
        else if (c == '[')
          return KEYD_F11;
        else if (c == ']')
          return KEYD_F12;
        else if (c == '\r')
          return KEYD_ENTER;
        else if (c == '\n')
          return KEYD_ENTER;
        else
          return c;
      } else
        return 0;
    }


	if (rawkey < 0x68)
      return _xlate[rawkey];


	return 0;
}



void I_GetEvent(void) {

	event_t event;
	static event_t mouseevent = {0};
	UWORD code;
	WORD mousex, mousey;
	struct IntuiMessage *imsg;
	int doomkey;


	if (_hardwareWindow != NULL) {
        while (imsg = (struct IntuiMessage *)GetMsg(_hardwareWindow->UserPort)) {

            ReplyMsg((struct Message *)imsg);

			code = imsg->Code;

            switch (imsg->Class) {
                case IDCMP_MOUSEMOVE:
					mousex = imsg->MouseX;
					mousey = imsg->MouseY;
					mouseevent.type = ev_mouse;
					mouseevent.data2 = (mousex << 2);// << 3);
					mouseevent.data3 = -(mousey);// << 5
					D_PostEvent (&mouseevent);
					break;

				case IDCMP_MOUSEBUTTONS:
					mouseevent.type = ev_mouse;
					switch (code) {
					  case SELECTDOWN:
						mouseevent.data1 |= 1;
						break;
					  case SELECTUP:
						mouseevent.data1 &= ~1;
						break;
					  case MENUDOWN:
						mouseevent.data1 |= 2;
						break;
					  case MENUUP:
						mouseevent.data1 &= ~2;
						break;
					  case MIDDLEDOWN:
						mouseevent.data1 |= 4;
						break;
					  case MIDDLEUP:
						mouseevent.data1 &= ~4;
						break;
					  default:
						break;
					}
					D_PostEvent (&mouseevent);
					break;

				case IDCMP_RAWKEY:
                    event.type = (code & IECODE_UP_PREFIX) ? ev_keyup : ev_keydown;
					code &= ~IECODE_UP_PREFIX;


					doomkey = xlate_key(code, imsg);
					if (doomkey != 0) {
						event.data1 = doomkey;
						D_PostEvent(&event);
					}

					break;
			}
        }
    }
}








//
// I_ReadScreen
//

void I_ReadScreen (byte* scr) {
	CopyMemQuick(screens[0], scr, (SCREENWIDTH * SCREENHEIGHT));
}

void I_SetPalette (byte *palette)
{
	int i;
	int j = 1;


	for(i = 0; i < 256; i++) {
		_agaPalette[j] = (gammatable[usegamma][*palette++]) << 24;
		_agaPalette[j+1] = (gammatable[usegamma][*palette++]) << 24;
		_agaPalette[j+2] = (gammatable[usegamma][*palette++]) << 24;

		j += 3;
	}

	_agaPalette[0] = (256 << 16);

	// Terminator: NEEDED
	_agaPalette[((256 * 3) + 1)] = 0x00000000;

	_paletteDirty = true;
}

struct Screen* createHardwareScreen(ULONG modeId) {

	// Create the hardware screen.
    struct Screen* screen = NULL;
	struct Rectangle clip;

	// Setup clip region.
	clip.MinX = 0;
    clip.MinY = 0;
    clip.MaxX = SCREENWIDTH - 1;
    clip.MaxY = SCREENHEIGHT - 1;

	screen = OpenScreenTags(NULL,
                     SA_Depth, VIDEO_DEPTH,
                     SA_DisplayID, modeId,
                     SA_Width, SCREENWIDTH,
					 SA_Height, SCREENHEIGHT,
                     SA_DClip, (ULONG)&clip,
					 SA_Type, CUSTOMSCREEN,
                     SA_Quiet, TRUE,
					 SA_ShowTitle, FALSE,
					 SA_Draggable, FALSE,
                     SA_Exclusive, TRUE,
					 SA_AutoScroll, FALSE,
                     TAG_END);


    return screen;
}

struct Window* createHardwareWindow(void) {

    return OpenWindowTags(NULL,
                  	    WA_Left, 0,
            			WA_Top, 0,
            			WA_Width, SCREENWIDTH,
            			WA_Height, SCREENHEIGHT,
            			WA_CustomScreen, (ULONG)_hardwareScreen,
            			WA_Backdrop, TRUE,
            			WA_Borderless, TRUE,
            			WA_Activate, TRUE,
            			WA_SimpleRefresh, TRUE,
            			WA_NoCareRefresh, TRUE,
            			WA_ReportMouse, TRUE,
            			WA_RMBTrap, TRUE,
                  	    WA_IDCMP, IDCMP_RAWKEY|IDCMP_MOUSEMOVE|IDCMP_DELTAMOVE|IDCMP_MOUSEBUTTONS,
                  	    TAG_END);
}


void I_ShutdownGraphics(void) {

	// Chunky back buffer.
	if (screens[0]) {
		free(screens[0]);
	}

	if (_hardwareWindow) {
        ClearPointer(_hardwareWindow);
        CloseWindow(_hardwareWindow);
        _hardwareWindow = NULL;
	}

	if (_hardwareScreenBuffer[0]) {
        ChangeScreenBuffer (_hardwareScreen, _hardwareScreenBuffer[0]);
        WaitTOF();
        WaitTOF();
        FreeScreenBuffer (_hardwareScreen, _hardwareScreenBuffer[0]);
        _hardwareScreenBuffer[0] = NULL;
    }

    if (_hardwareScreenBuffer[1]) {
        FreeScreenBuffer (_hardwareScreen, _hardwareScreenBuffer[1]);
        _hardwareScreenBuffer[1] = NULL;
    }


	if (_hardwareScreen) {
        CloseScreen(_hardwareScreen);
        _hardwareScreen = NULL;
    }

    if (c2p[0]) {
        c2p8_deinit_stub(c2p[0]);
        c2p[0] = NULL;
    }

    if (c2p[1]) {
        c2p8_deinit_stub(c2p[1]);
        c2p[1] = NULL;
    }
}



void I_InitGraphics(DisplayType_t displayType) {

	ULONG modeId = INVALID_ID;
	ULONG monitorType;
	DisplayInfoHandle handle;
	struct DisplayInfo dispinfo;
	struct DimensionInfo dimsinfo;


	
	// Automatically choose the best mode.
	if (displayType == NTSC) {
		monitorType = NTSC_MONITOR_ID;
	} else {
		monitorType = PAL_MONITOR_ID;
	}

	modeId = BestModeID(BIDTAG_NominalWidth, SCREENWIDTH,
					BIDTAG_NominalHeight, SCREENHEIGHT,
					BIDTAG_DesiredWidth, SCREENWIDTH,
					BIDTAG_DesiredHeight, SCREENHEIGHT,
					BIDTAG_Depth, VIDEO_DEPTH,
					BIDTAG_MonitorID, monitorType,
					TAG_END);


	// Verify the mode choosen.
	if (modeId != INVALID_ID) {
		if ((handle = FindDisplayInfo(modeId)) == NULL) {
			I_Error("Can't FindDisplayInfo() for mode %08x", modeId);
		}

		if (GetDisplayInfoData(handle, (UBYTE *)&dispinfo,
									  sizeof(dispinfo), DTAG_DISP,
									  NULL) == NULL) {
			I_Error("Can't GetDisplayInfoData() for mode %08x", modeId);
		}

		if (GetDisplayInfoData(handle, (UBYTE *)&dimsinfo,
									  sizeof(dimsinfo), DTAG_DIMS,
									  NULL) == NULL) {
			I_Error("Can't GetDisplayInfoData() for mode %08x", modeId);
		}

		if (dimsinfo.MaxDepth != VIDEO_DEPTH) {
		   modeId = INVALID_ID;
		}

		if ((dimsinfo.Nominal.MaxX + 1) != SCREENWIDTH) {
		   modeId = INVALID_ID;
		}

		if ((dimsinfo.Nominal.MaxY + 1) < SCREENHEIGHT) {
		   modeId = INVALID_ID;
		}
	}

	if (modeId == INVALID_ID) {
		if (displayType == PAL) {
			I_Error("Could not find a valid AGA (PAL) screen mode");
		} else {
			I_Error("Could not find a valid AGA (NTSC) screen mode");
		}
	}



	// Create the hardware screen.
	_hardwareScreen = createHardwareScreen(modeId);
	if (!_hardwareScreen ) {
		I_Error("Cound not create a Hardware Screen");
	}

	// Setup double buffering.
	_hardwareScreenBuffer[0] = AllocScreenBuffer (_hardwareScreen, NULL, SB_SCREEN_BITMAP);
	_hardwareScreenBuffer[1] = AllocScreenBuffer (_hardwareScreen, NULL, 0);

	c2p[0] = c2p8_reloc_stub(_hardwareScreenBuffer[0]->sb_BitMap);
	c2p[1] = c2p8_reloc_stub(_hardwareScreenBuffer[1]->sb_BitMap);

	_currentScreenBuffer = 1;



	// Create the hardware window.
	_hardwareWindow = createHardwareWindow();
	if (!_hardwareWindow) {
		I_Error("Cound not create a Hardware Window");
	}

    // Hide WB mouse pointer.
	SetPointer(_hardwareWindow, _emptypointer, 1, 16, 0, 0);


	// Create the chunky back buffer.
	screens[0] = (byte *)calloc(SCREENWIDTH, SCREENHEIGHT);  // killough


	atexit(I_ShutdownGraphics);
}








//----------------------------------------------------------------------------
//
// $Log: i_video.c,v $
// Revision 1.12  1998/05/03  22:40:35  killough
// beautification
//
// Revision 1.11  1998/04/05  00:50:53  phares
// Joystick support, Main Menu re-ordering
//
// Revision 1.10  1998/03/23  03:16:10  killough
// Change to use interrupt-driver keyboard IO
//
// Revision 1.9  1998/03/09  07:13:35  killough
// Allow CTRL-BRK during game init
//
// Revision 1.8  1998/03/02  11:32:22  killough
// Add pentium blit case, make -nodraw work totally
//
// Revision 1.7  1998/02/23  04:29:09  killough
// BLIT tuning
//
// Revision 1.6  1998/02/09  03:01:20  killough
// Add vsync for flicker-free blits
//
// Revision 1.5  1998/02/03  01:33:01  stan
// Moved __djgpp_nearptr_enable() call from I_video.c to i_main.c
//
// Revision 1.4  1998/02/02  13:33:30  killough
// Add support for -noblit
//
// Revision 1.3  1998/01/26  19:23:31  phares
// First rev with no ^Ms
//
// Revision 1.2  1998/01/26  05:59:14  killough
// New PPro blit routine
//
// Revision 1.1.1.1  1998/01/19  14:02:50  rand
// Lee's Jan 19 sources
//
//----------------------------------------------------------------------------