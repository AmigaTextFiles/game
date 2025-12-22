/**
***  simple kbhit() replacement
***
***  Jochen Wiedmann, 22-Feb-95
***
***  This is in the public domain, use it as you want.
**/


/****************************************************************
    This file uses the auto initialization possibilities of
    Dice, gcc and SAS/C, respectively.

    Dice does this by using the keywords __autoinit and
    __autoexit, SAS uses names beginning with _STI or
    _STD, respectively. gcc uses the asm() instruction,
    to emulate C++ constructors and destructors.
****************************************************************/


#if defined(__SASC)
#define __autoinit
#define __autoexit
#elif defined(__GNUC__)
#define __autoinit
#define __autoexit
__asm ("  .text;  .stabs \"___CTOR_LIST__\",22,0,0,__STIInitKbhit");
__asm ("  .text;  .stabs \"___DTOR_LIST__\",22,0,0,__STDTermKbhit");
#elif defined(_DCC)
extern void _AutoFail0(void);
#else
#error "Don't know how to handle your compiler."
#endif

#include <stdlib.h>
#include <errno.h>

#include <dos/dosextens.h>
#include <proto/dos.h>
#include <proto/exec.h>


STATIC struct MsgPort *kbhitPort    = NULL;
STATIC struct DosPacket *dosPacket  = NULL;


__autoinit LONG _STIInitKbhit(void)

{ if ((dosPacket = AllocDosObject(DOS_STDPKT, NULL)))
  { if ((kbhitPort = CreateMsgPort()))
    { return(FALSE);
    }
    FreeDosObject(DOS_STDPKT, dosPacket);
    dosPacket = NULL;
  }
#if defined(__GNUC__)
  abort();
#elif defined(_DCC)
  _AutoFail0();
#endif
  return(TRUE);
}


__autoexit VOID _STDTermKbhit(VOID)

{ if (dosPacket)
  { FreeDosObject(DOS_STDPKT, dosPacket);
    dosPacket = NULL;
  }
  if (kbhitPort)
  { DeleteMsgPort(kbhitPort);
    kbhitPort = NULL;
  }
}


int kbhit(void)

{ BPTR cis = Input();
  struct FileHandle *fh = BADDR(cis);
  struct Message *msg;

  dosPacket->dp_Type = ACTION_WAIT_CHAR;
  dosPacket->dp_Arg1 = 0;
  SendPkt(dosPacket, fh->fh_Type, kbhitPort);
  WaitPort(kbhitPort);
  msg = GetMsg(kbhitPort);
  return(((struct DosPacket *) msg->mn_Node.ln_Name)->dp_Res1);
}
