
#include "sound.h"

#ifdef NOSOUND

/* dummy implementation */
bool sound::enabled() { return false; }
void sound::mute(bool b) { }
void sound::init() { }
void sound::shutdown () { }
void sound::play(sound_t s) { }

#else


/* real implementation */

#include "escapex.h"
#include "SDL_mixer.h"

/* declare static array sound_data */
#include "sound_decs.h"


static bool sound_available = false;
static bool sound_muted = false;

/* XXX should also halt any sound playing */
void sound::mute(bool b) { sound_muted = b; }

void sound::init() {

  if (audio) {
    /* XXX what frequency to use? */
    /* XXX fall back to mono if stereo fails */

    /* uses 16 bit at system byte order */
    if (-1 == Mix_OpenAudio(22050, MIX_DEFAULT_FORMAT, 2, 1024)) {
      printf("Can't open audio. (%s)\n", Mix_GetError());
      return;
    }
    
    if (-1 == Mix_AllocateChannels(4)) {
      Mix_CloseAudio();
      return;
    }
    
    /* load sound data into memory */
    #include "sound_load.h"
    /* XXX fail gracefully */

    sound_available = true;
  }

}

void sound::play (sound_t s) {
  if (sound_available && !sound_muted) {
    Mix_PlayChannel(-1, sound_data[s], 0);
  }
}

void sound::shutdown () {
  if (sound_available) {
    Mix_CloseAudio();
  }
  sound_available = false;
}

/* XXX this shouldn't happen here, since we need
   to synchronize with delayed animation events */
void sound::start(aevent * ae) {
  switch (ae->t) {
  case tag_fly:
//     play(S_FLY); break;
  case tag_push:
     play(S_PUSH); break;
  case tag_jiggle:
     play(S_JIGGLE); break;
  case tag_breaks:
     play(S_BREAKS); break;
  case tag_swap:
     play(S_SWAP); break;
  case tag_walk:
     play(S_WALK); break;
  case tag_press:
     play(S_PRESS); break;
  case tag_stand:
//     play(S_STAND); break;
  case tag_toggle:
     play(S_TOGGLE); break;
  case tag_button:
     play(S_BUTTON); break;
  case tag_trap:
     play(S_TRAP); break;
  case tag_pushgreen:
     play(S_PUSHGREEN); break;
  case tag_litewire:
//     play(S_LITEWIRE); break;
  case tag_liteup: {
    liteup_t * al = &(ae->u.liteup);

    switch (al->what) {
    default: /* XXX error sound? */ break;
    case T_BLIGHT: play(S_BLUELIGHT); break;
    case T_GLIGHT: play(S_GREENLIGHT); break;
    case T_RLIGHT: play(S_REDLIGHT); break;
    }

    break;
  }
  case tag_opendoor:
     play(S_OPENDOOR); break;
  case tag_lasered:
     play(S_LASERED); break;
  case tag_winner:
     play(S_WINNER); break;
  case tag_botexplode:
//     play(S_BOTEXPLODE); break;
  ;
  }
}

#endif
