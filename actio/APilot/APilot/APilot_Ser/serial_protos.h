/**************************************************************************
 *
 * serial_protos.h -- Protos for serial.c
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen    (kjetilja@stud.cs.uit.no)
 *
 */

void init_connection(void);
BOOL update_remote(UWORD buf, UWORD nframes);
void ze_wait(void);
void send_local(UWORD nframes);
void send_quit(void);
void close_connection(void);


