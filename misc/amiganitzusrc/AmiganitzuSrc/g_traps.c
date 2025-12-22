/* g_traps.c */
#include <exec/exec.h>
#include "g_headers.h"
#include "g_audio.h"
#include "g_8svx.h"


struct traps_struct traps[10];
extern struct map_struct *map;
extern struct player_struct player;
extern int finished;
extern struct sample_struct sample[NUM_SAMPLES];
extern ULONG vbcounter;

// traps get sprung when a boulder of the player is in the direct path
void check_traps()
{
	int i, y, x;
	
	for(i = 0; i < 10; i++) {
		if(traps[i].empty == 0 && traps[i].flag == TRAP_SET) {
			x = traps[i].orig_x;
			for(y = traps[i].orig_y - 1; y > 0; y--) if(map->t[x][y].type != NOTHING) break;
			if(map->t[x][y].type == PLAYER) {
				traps[i].flag = TRAP_SPRUNG;
				traps[i].time_stamp = vbcounter;
				play_sample(&sample[S_TRAP1], player.audio_channelB);
				if(player.audio_channelB == 0) player.audio_channelB = 1;
				else player.audio_channelB = 0;
			}
		}
	}
}

void move_traps()
{
	int i, x, y;
	unsigned long time;

	for(i = 0; i < 10; i++) {
		if(traps[i].empty == 0) {
			if(traps[i].flag == TRAP_SPRUNG) {
				time = vbcounter;
				if(time > traps[i].time_stamp + 6) {
					traps[i].time_stamp = time;
					x = traps[i].x;
					y = traps[i].y - 1;
					if(y == -1) return;
					if(map->t[x][y].type == NOTHING || map->t[x][y].type == PLAYER)	{
						// move the trap
						if(map->t[x][y].type == PLAYER)	{
							player_dies();
							return;
						}
						traps[i].y = y;
						map->t[x][y].type = SPEARTRAP;
						map->t[x][y].bm = BM_SPEAR1;
						map->t[x][y].sub_type = SPEAR1;
						map->t[x][y].update = 1;
						map->t[x][y + 1].type = SPEARTRAP;
						map->t[x][y + 1].bm = BM_SPEAR2;
						map->t[x][y + 1].sub_type = SPEAR2;
						map->t[x][y + 1].update = 1;
						map->update = 1;
					}
					else traps[i].flag = TRAP_DISABLED;
				}
			}
		}
	}
}
