
#ifndef _G_AUDIO_H
#define _G_AUDIO_H

#include <exec/types.h>
#include "g_8svx.h"

int init_audio(void);
void exit_audio(void);
void play_sample(struct sample_struct *, unsigned char);
void loop_sample(struct sample_struct *, unsigned char);
void stop_loop(unsigned char);

#endif


