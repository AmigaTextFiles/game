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
#include <rtgmaster/rtgmaster.h>
#include <rtgmaster/rtgsublibs.h>
#include <proto/exec.h>
#include <proto/rtgmaster.h>
#include <proto/console.h>

#include "keyboard.h"
#include "ksyms.h"
#include "amigakey.h"

#define NR_KEYS (0x68)


extern struct RtgScreen *RtgScreen;  /* from amiga.c */

struct Library *ConsoleDevice = NULL;
static struct IOStdReq *conio;

int scancode[5] = {
  SCANCODE_A,
  SCANCODE_S,
  SCANCODE_RIGHTALT,
  SCANCODE_ENTER,
  SCANCODE_SPACE
};

static char keys[NR_KEYS];
static char *keynames[NR_KEYS];
static char *qualifiernames[] = {
  "Shift_L","Shift_R","Caps_Lock","Control",
  "Alt_L","Alt_R","Amiga_L","Amiga_R"
};



static int rawkeyconv(char *buf,int bufsize,unsigned char code)
{
  static struct InputEvent ie = {
    NULL,IECLASS_RAWKEY,0,0,0
  };

  if (code & 0x80)
    return (0);
  ie.ie_Code = (UWORD)code;
  ie.ie_Qualifier = 0;
  ie.ie_position.ie_addr = NULL;  /* ??? @@@@ */
  return (RawKeyConvert(&ie,(UBYTE *)buf,(LONG)bufsize,NULL));
}


static void flushbuffer()
{
  struct IntuiMessage *imsg;

  while (imsg = (struct IntuiMessage *)RtgGetMsg(RtgScreen)) {
    if (imsg->Class == IDCMP_RAWKEY)
      keys[imsg->Code & 0x7f] = !(imsg->Code & 0x80);
    RtgReplyMsg(RtgScreen,imsg);
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
  struct IntuiMessage *imsg;
  int i, gotkey=999;

  for (i=0; i<NR_KEYS; i++) {
    if (keys[i]) {
      gotkey = i;
      break;
    }
  }
  while (gotkey == 999) {
    usleep(50000L);
    while (imsg = (struct IntuiMessage *)RtgGetMsg(RtgScreen)) {
      if (imsg->Class == IDCMP_RAWKEY) {
        i = imsg->Code & 0x7f;
        if (keys[i] = !(imsg->Code & 0x80)) {
          if (i < gotkey)
            gotkey = i;
        }
      }
      RtgReplyMsg(RtgScreen,imsg);
    }
  }
  while (keys[gotkey]) {
    usleep(50000L);
    flushbuffer();
  }
  return (gotkey);
}


int getkey(void)
{
  struct IntuiMessage *imsg;
  int c = 0;
  char buf[8];

  while (imsg = (struct IntuiMessage *)RtgGetMsg(RtgScreen)) {
    if (imsg->Class == IDCMP_RAWKEY) {
      keys[imsg->Code & 0x7f] = !(imsg->Code & 0x80);
      if (!(imsg->Code & 0x80))
        if (rawkeyconv(buf,8,(unsigned char)(imsg->Code & 0x7f)) == 1)
          c = (int)buf[0];
    }
    RtgReplyMsg(RtgScreen,imsg);
    if (c) break;
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
  struct MsgPort *conport;
  char buf[8];
  int i,n;

  if (RtgInitRDCMP(RtgScreen)) {

    /* open console.device */
    if (conport = CreateMsgPort()) {
      if (conio = CreateIORequest(conport,sizeof(struct IOStdReq))) {
        if (OpenDevice("console.device",-1,
                       (struct IORequest *)conio,0) == 0) {
          ConsoleDevice = (struct Library *)conio->io_Device;
        }
        else {
          DeleteIORequest(conio);
          DeleteMsgPort(conport);
        }
      }
      else
        DeleteMsgPort(conport);
    }

    /* determine key names */
    if (ConsoleDevice) {
      static char *unknown = "unknown";

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
    }
    else {
      printf("Couldn't open console.device.\n");
      return (-1);
    }
  }
  else {
    printf("RDCMP init failed!\n");
    return (-1);
  }
  return (0);
}


int keyclose(void)
{
  if (ConsoleDevice) {
    CloseDevice((struct IORequest *)conio);
    DeleteMsgPort(conio->io_Message.mn_ReplyPort);
    DeleteIORequest(conio);
    ConsoleDevice = NULL;
  }
  return (0);
}


char *keyname(void)
{
  static char name[] = "RDCMP";

  return name;
}
