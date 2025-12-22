#ifndef GS_SOUNDPROTO
#define GS_SOUNDPROTO

int gs_open_sound(int,int,int,int);
void gs_close_sound(void);
void gs_start_sound(struct sound_struct *,int);
void gs_stop_sound(int);
void gs_set_volume(int,int);
void gs_set_period(int,int);
int gs_load_raw_sound(struct sound_struct *,char *);
int gs_load_iff_sound(struct sound_struct *,struct sound_struct *,char *);
void gs_free_sound(struct sound_struct *);
int gs_sound_check(void);

#endif
