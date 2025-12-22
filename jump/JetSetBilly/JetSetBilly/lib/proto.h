/*	lib/proto.h */

#ifndef _NIILO_PROTO_H
#define _NIILO_PROTO_H

#include <exec/types.h>

/*
 *	amiga.c
 */
void	CloseWindowSafely(struct Window *);
void	StripIntuiMessages(struct MsgPort *, struct Window *);
void	StartFrame(void);
void	EndFrame(void);
void	openup(SHORT, SHORT, SHORT, USHORT, char *, ULONG);
void	cleandown(int);
void	panic(char *);
void	at(int,int);
int	verify_quit(void);
void	WaitIDCMP(void);
void	HandleIDCMP(void);
void	ConPuts(char *);
void	ConWrite(char *,LONG);
void	ConPutChar(char);
void	flush_inkey(int);
char	getch(void);
char	*get_string(int);
BOOL	yn(void);
void	more(void);

/*
 *	ilbmraw.c
 */
struct Picture *SimpleLoadILBM(char *filename);
void FreePicture(struct Picture *picture);

/*
 *	weekday.c
 */
long	julday(int, int, int);
char	*weekday(int, int, int);

/*
 *	rnd.s
 */
void	RandomSeed(long);
int	Random(long);

#endif /* _NIILO_PROTO_H */
