#ifndef GS_LIBPROTO
#define GS_LIBPROTO

int gs_open_libs(int,int);   /* open specified libs at specified version */
void gs_close_libs(void);    /* close all libs opened by open_libs */

#endif
