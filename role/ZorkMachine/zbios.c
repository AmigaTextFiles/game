/*:ts=8
*	@(#)zbios.c	2.24
*	Basic input/output System for ZMACHINE
*	all machine dependent functions are collected
*	in this file.
*/

#include	<fcntl.h>
#include	<ctype.h>
#ifdef	OSK
#include	<modes.h>
#endif
#include	"zmachine.h"
#include	"keys.h"

#ifdef AMIGA
#include <libraries/iffparse.h>
#include <clib/iffparse_protos.h>

#include <stdlib.h>

extern long StdOut;

char *sysname = "Amiga";
int con_is_open;

#endif	/* AMIGA */

#ifdef GEMDOS
char	*sysname = "Atari ST";

#include <sys\osbind.h>
#endif

#if defined(unix) || defined(OSK)
#ifdef unix
char	*sysname = "u**x";

#include <sgtty.h>
#include <signal.h>
#include <sys/types.h>

struct sgttyb otermio,ntermio;
#endif
#ifdef OSK
char	*sysname = "OS9/68000";

#include <sgstat.h>
#define	fputc(a,b)	putc(a,b)
#define gtty(FD,ADR)     getstat(0,FD,ADR)
#define stty(FD,ADR)     setstat(0,FD,ADR)
#define CHRAW(X)    chraw( & X)
struct sgbuf nstate, ostate;

#define PC PC_
int ospeed = 0;

chraw(x)
struct sgbuf *x;
{
	x->sg_case = 0;
	x->sg_backsp = 0;
	x->sg_echo = 0;
	x->sg_alf = 0;
	x->sg_pause = 0;
	x->sg_bspch = 0x80;
	x->sg_dlnch = 0x80;
	x->sg_eorch = 0x80;
	x->sg_eofch = 0x80;
	x->sg_rlnch = 0x80;
 	x->sg_dulnch = 0x80;
	x->sg_psch = 0x80;
	x->sg_kbich = 0x80;
	x->sg_kbach = 0x80;
	x->sg_bsech = 0x80;
	x->sg_bellch = 0x80;
	x->sg_tabcr = 0x80;
	x->sg_xon = 0x11;
	x->sg_xoff = 0x13;
}
#endif

char tcapbuf[1024];
char *CM = NULL, *CL = NULL, *BC = NULL, *UP = NULL, *DL = NULL, *TI = NULL, *TE = NULL, *SE = NULL, *SO = NULL, PC = '\0', *VS = NULL, *VE = NULL;
char *KS = NULL, *KE = NULL;


struct fkencode
	{
		struct fkencode *nextchar;    /* next char in string */
		struct fkencode *nextstring;  /* next string         */
		int fkc;		      /* current char
					         > 0x100 = return    */
	} *fkroot = NULL;

struct
	{
		char *name;
		int code;
	} keylist[] = {
		{ "kl", CLEFT },
		{ "kr", CRIGHT },
		{ "ku", CUP },
		{ "kd", CDOWN },
		{ "kb", BACKDEL },

		{ "k0", FSTART + F01 },
		{ "k1", FSTART + F02 },
		{ "k2", FSTART + F03 },
		{ "k3", FSTART + F04 },
		{ "k4", FSTART + F05 },
		{ "k5", FSTART + F06 },
		{ "k6", FSTART + F07 },
		{ "k7", FSTART + F08 },
		{ "k8", FSTART + F09 },
		{ "k9", FSTART + F10 },
		{ NULL, 0 }
	};

struct fkencode *insertc(fk, c)
struct fkencode *fk; int c;
{
	if (!fk)
	{
		if (!(fk = (struct fkencode *)malloc(sizeof(struct fkencode))))
			no_mem_error();
		fk->nextchar = fk->nextstring = NULL;
		fk->fkc = c;
		return(fk);
	}
	else
	{
		if (fk->fkc == c)
			return(fk);
		else
		{
			if (!fk->nextstring)
			{
				fk->nextstring = insertc(NULL, c);
				fk = fk->nextstring;
			}
			else
				fk = insertc(fk->nextstring, c);

			return(fk);
		}
	}
}

struct fkencode *insertkey(fk, s, c)
struct fkencode *fk; char *s; int c; 
{
	struct fkencode *root;

	if (fk)
	{
		root = fk;
		fk = insertc(fk, *s++);
	}
	else
		root = fk = insertc(NULL, *s++);

	while(*s)
	{
		if (fk->nextchar)
			fk = insertc(fk->nextchar, *s++);
		else
		{
			fk->nextchar = insertc(NULL, *s++);
			fk = fk->nextchar;
		}
	}

	fk->nextchar = insertc(NULL, c);
	return(root);
}
#endif


int	story	= -1;
int	save	= -1;

struct	{
		int x, y, lline, lchar;
	} con;

struct dev *screen;

void	icon_str();
void	icon_chr();
/*
*	long random()	-	return a random number (range 0 - min 0x7fff)
*/

long zrandom()
{
#ifdef AMIGA
	static int init = 1;
	if (init)
	{
		init = 0;
		srand((int)time(NULL));
	}
	return rand();
#endif
#ifdef GEMDOS
	return(Random());
#endif
#if defined(unix) || defined(OSK)
	extern void srand();
	extern long rand();
	extern long time();

	static int init = 1;

	if (init)
	{
		init = 0;
		srand((int)time(NULL));
	}

	return(rand());
#endif
}

/*
*	con_flush()	-	flush the console output buffer
*/

void con_flush()
{
#if defined(unix) || defined(OSK) 
	fflush(stdout);
#endif
}

/*
*	con_chr(c)	-	output the single character c to
*	char c;			the console-device
*/

void con_chr(c)
char c;
{
	int x,y;
	if (c == '\r')
	{
		gotoXY(0, con.y);
		return;
	}
	else if (con.x++ >= con.lchar)
	{
		storeXY(&x, &y);
#ifndef AMIGA
		/* Is autmatically done by Amiga COnsole device */
		con_crlf();
#endif
		if (y >= con.lline)
			y = con.lline-1;
		gotoXY(con.lchar, y);
#ifdef AMIGA
		cursorOFF();
		ConPutC(c);
#else
#ifdef GEMDOS
		Bconout(2,c);
#else
		putchar(c);
#endif
#endif
		gotoXY(0,y+1);
#ifdef AMIGA
		cursorON();
#endif
	}
	else
#ifdef AMIGA
		ConPutC(c);
#else
#ifdef GEMDOS
		Bconout(2,c);
#else
		putchar(c);
#endif
#endif
}

/*
*	con_str1(p)		-	output a '\0' terminated string to
*	char *p;			the console-device
*/

void con_str1(p)
register char *p;
#ifdef AMIGA
	{
	ConPutS((UBYTE *)p);

	con.x += strlen(p);
	}
#else
{	while(*p)
		con_chr(*p++);
}
#endif

/*
*	con_str2(p,q)		-	output the string p with the
*	char *p, *q;			endaddress q to the console-device
*
*/

void con_str2(p,q)
register char *p,*q;
#ifdef AMIGA
	{
	ConPutS2((UBYTE *)p,(UBYTE *)q);
	con.x += q - p;
	}
#else
{
	while(p < q)
		con_chr(*p++);
}
#endif

/*
*	con_crlf()		-	scroll all lines but first
*					status_len lines (if possible).
*					goto first column of next line.
*/

void con_crlf()
{
	extern int status_len;
#if defined(unix) || defined(OSK) || defined(AMIGA)
	int x,y;
#endif
	if (con.y >= con.lline)
	{
#ifdef AMIGA
		storeXY(&x,&y);
		cursorOFF();
		gotoXY(0, status_len);
		icon_str("\033[M");
		x = 0; y = con.lline;
		gotoXY(x,y);
		cursorON();
#endif
#ifdef GEMDOS
		icon_str("\033j\033f\033Y");
		icon_chr(' ' + status_len);
		icon_str(" \033M\033k\r\033e");
#endif
#if defined(unix) || defined(OSK)
		storeXY(&x,&y);
		cursorOFF();
		if (DL)
		{
			gotoXY(0,status_len);
			putpad(DL);
		}
		else
		{
			gotoXY(0, con.lline);
#ifdef OSK
			icon_str("\012");
#else
			icon_str("\n");
#endif
		}
		x = 0;
		gotoXY(x,y);
		cursorON();
#endif
	}
	else
	{
#ifdef OSK
		icon_str("\015\012");
#else
		icon_str("\r\n");
#endif
		con.y++;
	}
	con.x = 0;
}

/*
*	reverseON()		-	turn reversemode on
*	reverseOFF()		-	turn reversemode off
*/

void reverseON()
{
#ifdef AMIGA
	icon_str("\033[7m");
#endif
#ifdef GEMDOS
	icon_str("\033p");
#endif
#if defined(unix) || defined(OSK)
	if (SO)  
		putpad(SO);
#endif
}

void reverseOFF()
{
#ifdef AMIGA
	icon_str("\033[0m");
#endif
#ifdef GEMDOS
	icon_str("\033q");
#endif
#if defined(unix) || defined(OSK)
	if (SE)
		putpad(SE);
#endif
}

/*
*	cursorON()		-	turn cursor on
*	cursorOFF()		-	turn cursor off
*/

void cursorON()
{
#ifdef AMIGA
	icon_str("\033[ p");
#endif
#ifdef GEMDOS
	icon_str("\033e");
#endif
}

void cursorOFF()
{
#ifdef AMIGA
	icon_str("\033[0 p");
#endif
#ifdef GEMDOS
	icon_str("\033f");
#endif
}

/*
*	cursorLEFT()		-	move cursor left (with wrap)
*/

void
cursorLEFT()
{
	if (con.x)
	{
#ifdef AMIGA
		icon_str("\33[D");
#endif
#ifdef GEMDOS
		icon_chr(8);
#endif
#if defined(unix) || defined(OSK)
		icon_str(BC);
#endif
		con.x--;
	}
	else
		gotoXY(con.lchar, con.y - 1);
}

/*
*	gotoXY(x,y)		-	goto screen position x,y
*	int x,y;
*/

void gotoXY(x,y)
int x,y;
{
#ifdef AMIGA
	char posstr[20];
	sprintf(posstr,"\033[%d;%dH",y+1,x+1);
	icon_str(posstr);
#endif
#ifdef GEMDOS
	icon_str("\033Y");
	icon_chr(' ' + y);
	icon_chr(' ' + x);
#endif
#if defined(unix) || defined(OSK)
	extern char *tgoto();
	putpad(tgoto(CM, x, y));
#endif
	con.x = x;
	con.y = y;
}

/*
*	storeXY(x,y)		-	store current cursor position to
*	int *x, *y;			x and y
*/

void storeXY(x,y)
int *x, *y;
{
	*x = con.x;
	*y = con.y;
}

/*
*	int con_getc()	-		get a character from the console
*					handle special chars.
*/

#ifdef AMIGA
int con_getc()
	{
	int c;
	int test;
	char csistr[256];
	char *csipos;

RETRY:
	csipos = csistr;

	c = ConGetC();

	switch (c) {
		case 0x9b:
			while (1) {
				test = ConGetC();
				*csipos++ = test;
				if (isalpha(test) || test == '|' || test == '~'
						|| test == '@')
						break;
				}
			*csipos = '\0';
			if (strlen(csistr) == 1) {
			    switch(*csistr) {
			      case 'A':
			        return (CUP);
			      case 'B':
			        return (CDOWN);
			      case 'C':
			        return (CRIGHT);
			      case 'D':
			        return (CLEFT);
			      default:
			        goto RETRY;
			      }
			    }
			if (strlen(csistr) == 2) {
			    switch(csistr[1]) {
			      case 'A':
				if (*csistr == ' ')
				  return (START);
			        break;
			      case '@':
				if (*csistr == ' ')
				  return (END);
			        break;
			      case '~':
			        if (*csistr >= '0' && *csistr <= '9')
				  return (FSTART+csistr[0]-'0'+1);
				if (*csistr == '?') /* HELP */
				  return (FPROG);
			        break;
			      }
			    goto RETRY;
			    }
			if (strlen(csistr) == 3) {
			    switch(csistr[2]) {
			      case '~':
			        if (*csistr == '1' && csistr[1] >= '0' 
					&& csistr[1] <= '9')
				  return (FSTART+csistr[1]-'0'+11);
			        break;

			      case 'v':
			        if(csistr[0] == '0' && csistr[1] == ' ')
			        {
			        	STATIC UBYTE		 Buffer[256];

			        	extern UBYTE		*String;

					struct IFFHandle	*Handle;
					LONG			 Bytes = 0,Size = 255;

					if(Handle = AllocIFF())
					{
						if(Handle -> iff_Stream = (ULONG)OpenClipboard(PRIMARY_CLIP))
						{
							InitIFFasClip(Handle);

							if(!OpenIFF(Handle,IFFF_READ))
							{
								if(!StopChunk(Handle,'FTXT','CHRS'))
								{
									if(!ParseIFF(Handle,IFFPARSE_SCAN))
									{
										struct ContextNode *ContextNode;

										if(ContextNode = CurrentChunk(Handle))
										{
											if(Size > ContextNode -> cn_Size)
												Size = ContextNode -> cn_Size;

											if(ReadChunkRecords(Handle,Buffer,Size,1))
												Bytes = Size;
										}
									}
								}

								CloseIFF(Handle);
							}

							CloseClipboard((struct ClipboardHandle *)Handle -> iff_Stream);
						}

						FreeIFF(Handle);
					}

					if(Bytes)
					{
						WORD i;

						Buffer[Bytes] = 0;

						String = Buffer;

						for(i = 0 ; i < Bytes ; i++)
							Buffer[i] = tolower(Buffer[i]);
					}
			        }
			      }
			    goto RETRY;
			    }
			if (csistr[strlen(csistr)-1] == '|') {
			    if (strncmp(csistr,"12",2)==0) {
			    	/* Get a window status report */
				ConPutS((UBYTE *)"\2330 q");
				goto RETRY;
				}
			    }
			if (csistr[strlen(csistr)-1] == 'r') {
			    static int oldcols = 0;
			    int cols, rows;
			    sscanf(csistr,"1;1;%d;%d r",&rows,&cols);
			    con.y = con.y + rows - screen->height;
			    screen->width = cols;
			    screen->height = rows;
			    con.lline = rows - 1;
			    con.lchar = cols - 1;

			    if(oldcols && oldcols < cols)
			       ConPutS((STRPTR)"\f");

			    oldcols = cols;

			    output_status(NULL,NULL);

			    return 0;
			    }

			goto RETRY;

		case 0x01:	/* CTRL-A */
			return(START);

		case 0x1a:	/* CTRL-Z */
			return(END);

		case 0x0c:	/* CTRL-L */
			return(RETYPE);

		case 0x18:	/* CTRL-X */
			return(CLEAR);

		case 0x09:	/* CTRL-I */
			return(INSERT);

		case 0x08:
			return(BACKDEL);

		case 0x7f:
			return(FORWDEL);

		case 0x04:	/* CTRL-D */
			return(FORWDEL);

		case 0x10:	/* CTRL-P */
			return(FPROG);

		case 0x0d:
			return(RETURN);

		default:
			if(c > 127 || c < 0)
				goto RETRY;
			return(tolower(c));
		}
	}
#else
#ifdef GEMDOS
int con_getc()
{
	long c;
	static int s = 16;
	c = Bconin(2);
	switch((int)(c >> s))		/* compiler error */
	{
		case 0x004b:
			return(CLEFT);

		case 0x004d:
			return(CRIGHT);

		case 0x0050:
			return(CDOWN);

		case 0x0048:
			return(CUP);

		case 0x0061:
			return(RETYPE);

		case 0x0052:
			return(INSERT);

		case 0x0073:
			return(START);

		case 0x0074:
			return(END);

		default:
			if ((c >> s) > 0x003a && (c >> s) < 0x0045)
				return(FSTART + (c >> s) - 0x003b);

			switch((int)(c&0xff))
			{
				case 0x01:
					return(START);

				case 0x05:
					return(END);

				case 0x19:
					return(RETYPE);

				case 0x0b:
					return(KILL);

				case 0x08:
					return(BACKDEL);

				case 0x7f:
					return(FORWDEL);

				case 0x04:
					return(FORWDEL);

				case 0x02:
					return(CLEFT);

				case 0x06:
					return(CRIGHT);

				case 0x0e:
					return(CDOWN);

				case 0x10:
					return(CUP);

				case 0x09:
					return(FPROG);

				case 0x0d:
					return(RETURN);

				default:
					return(c&0xff);
			}
	}
}
#else
int con_getc()
{
	char c;
RETRY:
	read(0, &c, 1);
	c &= 0x7f;
	for (fk = fkroot; fk;)
	{
		if (fk && c == fk->fkc)
		{
			fk = fk->nextchar;
			if (fk && fk->fkc > 0x100)
				return(fk->fkc);
			else
			{
				read(0, &c, 1);
				c &= 0x7f;
			}
		}
		else
			fk = fk->nextstring;
	}

	switch((int)(c&0xff))
	{
		case 0x18:
			read(0, &c, 1);
			c &= 0x0f;
			if (c > 9)
				goto RETRY;
			return(c + FSTART);

		case 0x01:
			return(START);

		case 0x05:
			return(END);

		case 0x19:
			return(RETYPE);

		case 0x0b:
			return(KILL);

		case 0x7f:
			return(BACKDEL);

		case 0x08:
			return(FORWDEL);

		case 0x04:
			return(FORWDEL);

		case 0x02:
			return(CLEFT);

		case 0x06:
			return(CRIGHT);

		case 0x0e:
			return(CDOWN);

		case 0x10:
			return(CUP);

		case 0x09:
			return(FPROG);

		case '\n':
#ifndef OSK
		case 0x0d:
#endif
			return(RETURN);

		default:
			return(c&0xff);
	}
}
#endif
#endif

/*
*	init_con()		-	initialize console
*					- clear screen
*					- goto last line on screen
*/

void init_con()
{
	int len;
	int lines;
	static int init=1;
#if defined(unix) || defined(OSK)
	char *getenv(), *tgetstr();
	char *p, *t, *tv_stype;
	int i;
	void clean_up();
	char tcbuf[1024];
#endif

#ifdef AMIGA
	if (init)
	{
		len = 80;
		lines = 25;
		con_is_open = 0;
		if (!OpenConsoleStuff())
			fatal("Can't open Window!",1);
		con_is_open = 1;
	}
#endif
#ifdef GEMDOS
	if (Getrez())
		len = 80;
	else
		len = 40;
	lines = 25;
#endif

#if defined(unix) || defined(OSK)
	if (init)
	{
#ifdef unix
		ioctl(0, TIOCGETP, &otermio);
		ntermio = otermio;
		ntermio.sg_flags |= RAW;
		ntermio.sg_flags &= ~(ECHO|CRMOD);
		ioctl(0, TIOCSETP, &ntermio);
#endif
#ifdef OSK
		gtty(0, &ostate);
		gtty(0, &nstate);
		CHRAW(nstate);
		stty(0, &nstate);
#endif
		if ((tv_stype = getenv("TERM")) == NULL)
			fatal("Environment variable TERM not defined", NULL);

		if (tgetent(tcbuf, tv_stype) != 1)
			fatal("Unknown terminal type", tv_stype);

		if ((lines = tgetnum("li")) == -1)
			fatal("Termcap entry incomplete (lines)", tv_stype);

		if ((len = tgetnum("co")) == -1)
			fatal("Termcap entry inclomplete (columns)", tv_stype);

		p = tcapbuf;
		t = tgetstr("pc", &p);
		if (t)
			PC = *t;

		CM = tgetstr("cm", &p); /* cursor movement	*/

		CL = tgetstr("cl", &p); /* clear screen 	*/

		UP = tgetstr("up", &p); /* cursor up		*/

		SE = tgetstr("se", &p); /* exit reverse mode	*/

		SO = tgetstr("so", &p); /* enter reverse mode	*/

		BC = tgetstr("bc", &p); /* back space char	*/
		if (!BC)
			BC = "\010";

		DL = tgetstr("dl", &p); /* delete line		*/

		TI = tgetstr("ti", &p); /* terminal init	*/

		TE = tgetstr("te", &p); /* terminal reset	*/

		VS = tgetstr("vs", &p); /* enter visual mode	*/

		VE = tgetstr("ve", &p); /* exit visual mode	*/

		KS = tgetstr("ks", &p); /* enter visual mode	*/

		KE = tgetstr("ke", &p); /* enter visual mode	*/

		if (!CM || !CL || !UP)
			fatal("Termcap entry incomplete", tv_stype);

		for (i = 0; keylist[i].name; i++)
			if ( t = tgetstr(keylist[i].name, &p))
				fkroot = insertkey(fkroot, t, keylist[i].code);

	}
#endif
	if (init)
	{
		con.lline = lines - 1;
		con.lchar = len - 1;
	}
#ifdef AMIGA
	icon_str("\033c");	/* clear screen */
#endif
#ifdef GEMDOS
	icon_str("\033E\033w");		/* cursor on, wrap off */
#endif
#if defined(unix) || defined(OSK)
	if (init)
	{
		if (TI)
			icon_str(TI);

		if (VS)
			icon_str(VS);

		if (KS)
			icon_str(KS);
	}
	icon_str(CL);
#endif
	gotoXY(0, con.lline);
	cursorON();
	if (init)
		screen = init_dev(scr_write, con_crlf, 1000, lines, 1);

	screen->bp = screen->buffer;
	screen->count = 0;
	init = 0;

#ifdef AMIGA
	ConPutS((UBYTE *)"\23312{\2330 q");
	con_getc();
#endif
}

/*
*	open_story		-	open the storyfile specified by the
*					global variable story_name
*/

int open_story()
{
	return((story = open(story_name, O_RDONLY)) < 0);
}

/*
*	close_story		-	close the story file
*/

int close_story()
{
	int st;
	st = close(story);
	story = -1;
	return(st);
}

/*
*	read_story(p, n, bp)	-	read n pages (512 byte) from page no. p
*	unsigned p, n; char *bp;	to the address bp
*/

void read_story(p, n, bp)
unsigned p, n; UBYTE *bp;
{
	if (read_pages(story, p, n, bp))
		fatal("story file read error", story_name);
}

void read_header(p)
struct header *p;
{
	if (read(story, p, sizeof(struct header)) != sizeof(struct header))
		fatal("can't read story header", story_name);
}

/*
*	open_save_w(name)	-	open the save file name for writing
*	char *name;
*/

int open_save_w(name)
char *name;
{
#ifdef OSK
	return((save = creat(name, S_IREAD|S_IWRITE)) < 0);
#else
	return((save = creat(name, 0666)) < 0);
#endif
}

/*
*	open_save_r(name)	-	open the save file name for reading
*	char *name;
*/

int open_save_r(name)
char *name;
{
	return((save = open(name, O_RDONLY)) < 0);
}

/*
*	close_save()		-	close the save file
*/

int close_save()
{
	int st;
	st = close(save);
	save = -1;
#ifdef OSK
	return(0);
#else
	return(st);
#endif
}

/*
*	read_save(p, n, bp)	-	read n pages (512 byte) from page no. p
*	unsigned p, n; char *bp;	to the address bp
*/

int read_save(p, n, bp)
unsigned p, n; UBYTE *bp;
{
	return(read_pages(save, p, n, bp));
}

/*
*	write_save(p, n, bp)	-	write n pages (512 byte) to page no. p
*	unsigned p, n; char *bp;	from the address bp
*/

int write_save(p, n, bp)
unsigned p, n; UBYTE *bp;
{
	return(write_pages(save, p, n, bp));
}

/*
*	write_saveb(p, n, bp)	-	write n bytes to page no. p from the
*	unsigned p, n; UBYTE *bp;	address bp
*/

int write_saveb(p, n, bp)
unsigned p, n; UBYTE *bp;
{
	long lseek(), lwrite();
	if (lseek(save, (long)p * 0x200L, 0) != (long)p * 0x200L)
		return(1);

	return(lwrite(save, bp, (long)n) != (long)n);
}

/*
*	read_saveb(p, n, bp)	-	read n bytes from page no. p to the
*	unsigned p, n; UBYTE *bp;	address bp
*/

int read_saveb(p, n, bp)
unsigned p, n; UBYTE *bp;
{
	long lseek(), lread();
	if (lseek(save, (long)p * 0x200L, 0) != (long)p * 0x200L)
		return(1);

	return(lread(save, bp, (long)n) < 0L);
}

/*
*	char *read_rname()	-	ask user for restore file
*/

char *read_rname()
{
#ifdef AMIGA
	extern UBYTE LastFile[256];
	extern BYTE DontAsk;

	if(DontAsk && LastFile[0])
	{
		DontAsk = FALSE;

		return((char *)LastFile);
	}
	else
	{
		DontAsk = FALSE;

		return((char *)GetRestoreName());
	}
#else
	static char name[129];
	static struct hist_buf nam_hist = {256, NULL};

	if (!nam_hist.hb)
	{
		if (!(nam_hist.undo = nam_hist.hb = malloc(nam_hist.len)))
			no_mem_error();
		else
		{
			strcpy(nam_hist.hb,"Story.Save");
			strcpy(nam_hist.undo,"Story.Save");
		}
	}

	name[0] = 128;

	con_str1("Insert your save disk then enter a file name.");
	con_crlf();
	con_str1("(Default is \"");
	con_str1(nam_hist.undo);
	con_str1("\") >");
	read_str(name, &nam_hist);

	return(*nam_hist.undo?nam_hist.undo:NULL);
#endif
}

/*
*	char *read_sname()	-	ask user for save file
*/

char *read_sname()
{
#ifdef AMIGA
	extern UBYTE LastFile[256];
	extern BYTE DontAsk;

	if(DontAsk && LastFile[0])
	{
		DontAsk = FALSE;

		return((char *)LastFile);
	}
	else
	{
		DontAsk = FALSE;

		return((char *)GetSaveName());
	}
#else
	char *name;
	char c;
	if (name = read_rname())
	{
		if (!access(name,0))
		{
			con_str1("You are about to write over an existing file. Proceed? (Y/N) ");
			con_flush();

			do
				c = con_getc();
			while(c != 'Y' && c != 'N' && c != 'y' && c != 'n');

			con_chr(c);
			con_crlf();

			if (c == 'N' || c == 'n')
				return(NULL);
		}
		return(name);
	}
	else
		return(NULL);
#endif
}

/*****************************************************************************/
/*				utility functions			     */

#ifdef GEMDOS
long lread(fd, bp, n)
int fd; UBYTE *bp; long n;
{
	return(Fread(fd, n, bp));
}

long lwrite(fd, bp, n)
int fd; UBYTE *bp; long n;
{
	return(Fwrite(fd, n, bp));
}
#endif

int write_pages(fd, p, n, bp)
int fd; unsigned p, n; UBYTE *bp;
{
	long lseek();
	if (lseek(fd, (long)p * 0x200L, 0) != (long)p * 0x200L)
		return(1);

	return(lwrite(fd, bp, 0x200L * (long)n) != (0x200L * (long)n));
}

int read_pages(fd, p, n, bp)
int fd; unsigned p, n; UBYTE *bp;
{
	if (lseek(fd, (long)p * 0x200L, 0) != (long)p * 0x200L)
		return(1);

	return(lread(fd, bp, 0x200L * (long)n) < 0L);
}

void icon_str(p)
register char *p;
{
#ifdef AMIGA
	ConPutS((UBYTE *)p);
#else
	while(*p)
#ifdef GEMDOS
		Bconout(2,*p++);
#else	/* GEMDOS */
		putchar(*p++);
#endif
#endif	/* AMIGA */
}

void icon_chr(c)
char c;
{
#ifdef AMIGA
		ConPutC(c);
#else
#ifdef GEMDOS
	Bconout(2,c);
#else
	putchar(c);
#endif
#endif
}

void fatal(s1, s2)
char *s1, *s2;
{
#ifdef AMIGA
	if (con_is_open)
	{
		DPrintf("");

		if(s2)
			ConPrintf("ERROR [%s]: %s\n",s2,s1);
		else
			ConPrintf("ERROR: %s\n",s2,s1);

		ConPutS((UBYTE *)"Strike any key to exit.");
		con_getc();
	}
	else
	{
		if (StdOut)
		{
			if(s2)
				FPrintf(StdOut,"ERROR [%s]: %s\n",s2,s1);
			else
				FPrintf(StdOut,"ERROR: %s\n",s2,s1);
		}
	}
#else
	write(2,": ",2);
	write(2,s1,strlen(s1));
	write(2,"ERROR",5);
	if (s2) {
		write(2," [",2);
		write(2,s2,strlen(s2));
		write(2,"]",1);
	}
	write(2,": ",2);
	write(2,s1,strlen(s1));
# ifdef GEMDOS
	write(2,"\n\r",2);
# else
	write(2,"\n",1);
# endif
#endif
	clean_up();
	exit(userexit(1));
}

void clean_up()
{
	if (story >= 0)
		close_save();

	if (save >= 0)
		close_story();

	if (pfile >= 0)
		close(pfile);

#ifdef AMIGA
	if (con_is_open)
		ConCleanup();
#endif
#if defined(unix) || defined(OSK)
	if (TE)
		icon_str(TE);
	if (VE)
		icon_str(VE);

	if (KE)
		icon_str(KE);

#ifdef unix
	if (ntermio.sg_flags & RAW)
		ioctl(0, TIOCSETP, &otermio);
#endif
#ifdef OSK
	if (nstate.sg_tabcr == (char)(0x80))
		stty(0, &ostate);
#endif
	icon_chr('\n');

#endif
}

int userexit(s)
int s;
{
	char *getenv();

#ifdef GEMDOS
	if (!getenv("ARGV"))
	{
		write(2, "\n\rStrike any key to exit ", 24);
		con_getc();
	}
#endif
	return(s);
}

#if defined(unix) || defined(OSK)
putpad(s)
char *s;
{
	tputs(s, 1, icon_chr);
}
#endif

#if !defined(CADMUS) && !defined(minix)
char *lmalloc(n)
long n;
{
	return(malloc(n));
}
#endif

#if !defined(minix)
long lread(a,b,c)
int a; char *b; int c;
{
	return (read(a,b,c));
}

long lwrite(a,b,c)
int a; char *b; int c;
{
	return(write(a,b,c));
}
#else
long lread(fd, bp, cnt)
int fd; char *bp; long cnt;
{
	register int n, b;
	register long bcnt;
	bcnt = cnt;
	while(bcnt)
	{
		n = read(fd, bp, (int)(b = bcnt>31744?31744:bcnt));
		if (n < 0)
			return(n);
		if (n < b)
			return(bcnt - n);
		bcnt -= n;
		bp += n;
	}
	return(cnt);
}

long lwrite(fd, bp, cnt)
int fd; char *bp; long cnt;
{
	register int n, b;
	register long bcnt;
	bcnt = cnt;
	while(bcnt)
	{
		n = write(fd, bp, (int)(b = bcnt>31744?31744:bcnt));
		if (n < 0)
			return(n);
		if (n < b)
			return(bcnt - n);
		bcnt -= n;
		bp += n;
	}
	return(cnt);
}

#endif
