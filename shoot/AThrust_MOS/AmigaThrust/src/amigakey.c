/*
 * amigakey.c
 * Amiga specific keyboard routines for Thrust.
 * Written by Frank Wille, frank@phoenix.owl.de
 *
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <stdio.h>
#include <string.h>

#include <exec/types.h>
#include <exec/libraries.h>
#include <exec/io.h>
#include <devices/inputevent.h>
#include <intuition/intuition.h>
#include <libraries/mui.h>
#include <proto/exec.h>
#include <proto/keymap.h>

#include "keyboard.h"
#include "ksyms.h"
#include "amigakey.h"

#include "morphos.h"

extern APTR display;

#define NR_KEYS (0x68)

int scancode[5] = {
  SCANCODE_A,
  SCANCODE_S,
  SCANCODE_RIGHTALT,
  SCANCODE_ENTER,
  SCANCODE_SPACE
};

static char keys[NR_KEYS];
static char *keynames[NR_KEYS];
#ifdef __MORPHOS__
static char *qualifiernames[] = {
  "Shift_L","Shift_R","Caps_Lock","Control",
  "Alt_L","Alt_R","Command_L","Command_R"
};
#else
static char *qualifiernames[] = {
  "Shift_L","Shift_R","Caps_Lock","Control",
  "Alt_L","Alt_R","Amiga_L","Amiga_R"
};
#endif



static int rawkeyconv(char *buf,int bufsize,unsigned char code)
{
    static struct InputEvent ie =
    {
        NULL, IECLASS_RAWKEY, 0, 0, 0, NULL
    };

    int rc = 0;

    if (code & 0x80)
        return rc;

    ie.ie_Code = (UWORD)code;
//    ie.ie_Qualifier = 0;
//    ie.ie_position.ie_addr = NULL;  /* ??? @@@@ */
    return (MapRawKey(&ie,(UBYTE *)buf,(LONG)bufsize,NULL));
}


static void flushbuffer()
{
    APTR obj = display;

    if (obj)
    {
        ULONG   code;

        while (DoMethod(obj, MUIM_Display_GetKey, &code))
        {
            keys[code & 0x7f] = !(code & 0x80);
        }
    }
}


static void clearmatrix()
{
  int i = NR_KEYS+1;
  char *k = keys;

  while (--i)
    *k++ = 0;
}


void singlekey(void)
{
  flushbuffer();
}


void multiplekeys(void)
{
  clearmatrix();
}


int getonemultiplekey(void)
{
    APTR obj = display;
    int i, gotkey=999;

    if (!obj) return 0;

  for (i=0; i<NR_KEYS; i++) {
    if (keys[i]) {
      gotkey = i;
      break;
    }
  }

    while (gotkey == 999)
    {
        ULONG   code;

        usleep(50000L);
        while (DoMethod(obj, MUIM_Display_GetKey, &code))
        {
            i = code & 0x7f;

            if (keys[i] = !(code & 0x80))
            {
                if (i < gotkey)
                    gotkey = i;
            }
        }
    }

    while (keys[gotkey])
    {
        usleep(50000L);
        flushbuffer();
    }
    return (gotkey);
}


int getkey(void)
{
    APTR obj = display;
    ULONG code;
    int c = 0;
    char buf[8];

    if (!obj) return 0;

    while (DoMethod(obj, MUIM_Display_GetKey, &code))
    {
        keys[code & 0x7f] = !(code & 0x80);
        if (!(code & 0x80))

        if (rawkeyconv(buf,8,(unsigned char)(code & 0x7f)) == 1)
        {
            if (buf[0])
            {
                c   = buf[0];
                break;
            }
        }
    }
    return (c);
}


unsigned char getkeys(void)
{
  unsigned char keybits=0;

  flushbuffer();
  if (keys[SCANCODE_P])
    keybits |= pause_bit;
  else if (keys[SCANCODE_ESCAPE] || keys[SCANCODE_Q])
    keybits |= escape_bit;
  if (keys[scancode[0]])
    keybits |= left_bit;
  if (keys[scancode[1]])
    keybits |= right_bit;
  if (keys[scancode[2]])
    keybits |= thrust_bit;
  if (keys[scancode[3]])
    keybits |= fire_bit;
  if (keys[scancode[4]])
    keybits |= pickup_bit;

  return keybits;
}


char *keystring(int key)
{
  static char keybuffer[100];
  int i;

  if(key<0 || key>=NR_KEYS)
    return NULL;

  strncpy(keybuffer, keynames[key], 99);
  keybuffer[99] = '\0';
  for(i=0; i<strlen(keybuffer); i++)
    if(keybuffer[i] == '_')
      keybuffer[i] = ' ';

  return keybuffer;
}


int keycode(char *keyname)
{
  static char keybuffer[100];
  int i;

  strncpy(keybuffer, keyname, 99);
  keybuffer[99] = '\0';
  for(i=0; i<strlen(keybuffer); i++)
    if(keybuffer[i] == ' ')
      keybuffer[i] = '_';

  for(i=0; i<NR_KEYS; i++) {
    if(!strcasecmp(keynames[i], keybuffer))
      return(i);
  }

  return(0);
}


void flushkeyboard(void)
{
  flushbuffer();
  clearmatrix();
}


int keywaiting(void)
{
  int i = NR_KEYS+1;
  char *k = keys;

  while (--i) {
    if (*k++)
      return (1);
  }
  return (0);
}


int keyinit(void)
{
    static char *unknown = "unknown";
    char buf[8];
    int i,n;

    /* determine key names */

      for (i=0; i<NR_KEYS; i++) {
        keys[i] = 0;
        keynames[i] = unknown;
        if (i >= 0x60) {
          keynames[i] = qualifiernames[i-0x60];
        }
        else if (i>=0x50 && i<=0x59) {
          keynames[i] = syms[1].table[i-0x50];
        }
        else if ((n = rawkeyconv(buf,8,(unsigned char)i)) > 0) {
          if (n == 1) {
            switch ((unsigned char)buf[0]) {
              case 13:
                if (i & 1)
                  keynames[i] = "KP_Enter";
                else
                  keynames[i] = "Return";
                break;
              default:
#if 0
                if (i==0x0f || (i>=0x1d&&i<0x20) || (i>=0x2d&&i<0x30)
                    || (i>=0x3c&&i<0x40) || i==0x4a || (i>=0x5a && i<0x60)) {
                  keynames[i] = /* keypad symbol... */
#endif
                keynames[i] = syms[0].table[(unsigned char)buf[0]];
                if (*keynames[i] == 0)
                  keynames[i] = unknown;
                break;
            }
          }
          else {
            if ((unsigned char)buf[0] == 0x9b) {
              switch (buf[1]) {
                case 0x41:
                  keynames[i] = "Cursor_Up";
                  break;
                case 0x42:
                  keynames[i] = "Cursor_Down";
                  break;
                case 0x43:
                  keynames[i] = "Cursor_Right";
                  break;
                case 0x44:
                  keynames[i] = "Cursor_Left";
                  break;
              }
            }
          }
        }
      }

    return (0);
}


int keyclose(void)
{
  return (0);
}


char *keyname(void)
{
  static char name[] = "RDCMP";

  return name;
}
