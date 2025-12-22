#ifndef GS_TIMERREGPROTO
#define GS_TIMERREGPROTO

void __asm _gs_open_vb_timer(void);
void __asm _gs_close_vb_timer(void);
unsigned long __asm _gs_vb_time(void);
void __asm _gs_vb_timer_reset(void);

#endif
