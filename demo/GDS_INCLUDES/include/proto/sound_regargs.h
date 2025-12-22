#ifndef GS_SOUNDREGPROTO
#define GS_SOUNDREGPROTO

int __asm _gs_open_sound(register __d0 int,
  register __d1 int,register __d2 int,register __d3 int);
void __asm _gs_close_sound(void);
void __asm _gs_start_sound(register __a1 struct sound_struct *,
  register __d0 int);
void __asm _gs_stop_sound(register __d0 int);
void __asm _gs_set_volume(register __d0 int,register __d1 int);
void __asm _gs_set_period(register __d0 int,register __d1 int);
int __asm _gs_load_raw_sound(register __a0 struct sound_struct *,
  register __a1 char *);
int __asm _gs_load_iff_sound(register __a0 struct sound_struct *,
  register __d0 struct sound_struct *,register __a1 char *);
void __asm _gs_free_sound(register __a0 struct sound_struct *);
int _gs_sound_check(void);

#endif
