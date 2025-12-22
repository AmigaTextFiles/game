/*
    Written by Oliver Gantert

    31.04.2000 - Yeah, this works!
    03.05.2000 - Well, it didn't work as good as expected, but
                 it should be better now.
    04.07.2000 - Use lucyplay.library
*/

#include "orbit.h"

LucyPlaySample *smp[3] = { NULL, NULL, NULL };
int ahi_ok = 0;

int InitSound()
{
  if (lucAudioInit())
  {
    if (smp[0] = lucAudioLoad("sounds/phaser.wav"))
    {
      if (smp[1] = lucAudioLoad("sounds/explosion1.wav"))
      {
        if (smp[2] = lucAudioLoad("sounds/communicator.wav"))
        {
          ahi_ok = -1;
          return(1);
        }
        lucAudioFree(smp[1]);
      }
      lucAudioFree(smp[0]);
    }
    lucAudioKill();
  }
  return(0);
}

int PlayAudio(enum sounds nSound)
{
  if (ahi_ok)
  {
    lucAudioPlay(smp[nSound]);
    return(1);
  }
  return(0);
}

void FinishSound()
{
  if (ahi_ok)
  {
    if (smp[0])
    lucAudioFree(smp[0]);
    if (smp[1])
    lucAudioFree(smp[1]);
    if (smp[2])
    lucAudioFree(smp[2]);
    lucAudioKill();
    ahi_ok = 0;
  }
  if (LucyPlayBase)
    CloseLibrary(LucyPlayBase);
}
