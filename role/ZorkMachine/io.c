/*
*	@(#)io.c	2.24
*/

# ifdef OSK
# include <modes.h>
# endif
# include "zmachine.h"
# include "keys.h"

char	*iovers = "122400";
int	pfile = -1;
FILE	*fopen();
#ifdef AMIGA
char print_name[256] = "prt:";
#else
char print_name[256] = "protocol";
#endif
int printer_width = 80;

/*****************************************************************************/

struct dev *init_dev(out, crlf, l, h, wrap)
void (*out)(); void (*crlf)(); int l, h, wrap;
{
	register struct dev *d;

	if (d = (struct dev *)malloc(sizeof(struct dev) + l))
	{
		d->buffer = d->bp = (char *)d + sizeof(struct dev);
		d->width = l;
		d->height = h;
		d->count = 0;
		d->out_f = out;
		d->crlf_f = crlf;
		d->wrap = wrap;
		return(d);
	}
	else
		no_mem_error();
}

void putc_dev(c, d)
char c; register struct dev *d;
{
	register char *s, *p;

	if (c == '\n' || c == FLUSH)
	{
		(*d->out_f)(d->buffer, d->bp);
		if (c != FLUSH && (d->count != d->width || !d->wrap))
			(*d->crlf_f)();

		con_flush();

		d->count = 0;
		d->bp = d->buffer;
	}
	else
	{
		if (d->width < d->count+1)
		{
			if (c == ' ')
			{
				(*d->out_f)(d->buffer, d->bp);
				if (d->count != d->width || !d->wrap)
					(*d->crlf_f)();
				d->count = 0;
				d->bp = d->buffer;
				return;
			}
			else
			{
				for(s = d->bp; --s > d->buffer;)
					if (*s == ' ')
						break;

				if (s == d->buffer)
				{
					(*d->out_f)(d->buffer, d->bp);
					d->count = 0;
					d->bp = d->buffer;
				}
				else
				{
					(*d->out_f)(d->buffer, s);
					(*d->crlf_f)();
					for (d->count = 0, p = d->buffer;
							 s < d->bp-1;
								d->count++)
						*p++ = *++s;
					d->bp = p;
				}
			}

		}
		*(d->bp++) = c;
		d->count++;
	}
}

void output_chr(c)
char c;
{
	extern int use_line, in_status;
	extern char *line;

	if (c == FLUSH)
		putc_dev(c, screen);
	else if (use_line)
		*line++ = c;
	else
	{
		if (c == 9)
			c = ' ';

		putc_dev(c, screen);

		if (!in_status && (word_get(main_h->reserved5) & 1))
			putc_dev(c, printer);
	}
}

void output_str(p)
register char *p;
{
	while(*p)
		output_chr(*p++);
}

void output_status(room, score)
char *room, *score;
{
	register int i,t;
	int x,y;

#ifdef AMIGA
	STATIC char BackupRoom[80],BackupScore[80];

	if(room)
		strcpy(BackupRoom,room);
	else
		room = BackupRoom;

	if(score)
		strcpy(BackupScore,score);
	else
		score = BackupScore;
#endif

	storeXY(&x, &y);
	cursorOFF();
	gotoXY(0,0);
	reverseON();
	con_str1(room);

	t = screen->width - strlen(score);
	for(i = strlen(room); i < t; i++)
		con_chr(' ');

	con_str1(score);
	reverseOFF();
	cursorON();
	gotoXY(x,y);
}

/*****************************************************************************/

void more_test()
{
	char getc_ne();
	extern int line_cnt, status_len;

	if ((screen->height - status_len) == ++line_cnt)
	{
		status();
		con_str1("[More]");
		con_flush();
		con_getc();
		con_str1("\r      \r");
		line_cnt = 2;
	}
}

void scr_write(a,b)
char *a, *b;
{
	extern int in_status;

	if (!in_status)
		more_test();

	if (b > a)
		con_str2(a,b);

#ifdef AMIGA
	SayMore(a,b);
#endif
}

int prot_open()
{
	if (pfile == -1)
	{
#ifdef OSK
		if ((pfile = creat(print_name, S_IREAD|S_IWRITE)) < 0)
#else
		if ((pfile = creat(print_name, 0666)) < 0)
#endif
		{
			con_crlf();
			con_str1("Can't open protocol file");
			con_crlf();
			pfile = -2;
		}
	}
	return(pfile >= 0);
}

void prot_write(a,b)
char *a, *b;
{
	if (prot_open() && (b > a))
		write(pfile, a, b-a);
}

void prot_crlf()
{
	if (prot_open())
# if defined(unix) || defined(OSK)
		write(pfile, "\n", 1);
# else
#ifdef AMIGA
		write(pfile, "\n", 1);
#else
		write(pfile, "\r\n", 2);
#endif
# endif
}

/*****************************************************************************/

char fkeys[10][17];

int save_keys()
{
	extern int save_len;
	return(write_saveb(save_len + 1, 170, fkeys));
}

int restore_keys()
{
	extern int save_len;
	return(read_saveb(save_len + 1, 170, fkeys));
}

char *read_str(p, hist)
char *p; struct hist_buf *hist;
{
	extern int line_cnt;
	register char *q, *src, *dst;
	char *retype;
	char *end;
	register int c;
	register int i, e;
	int x, y;

	static char fbuf[18];
	static char fhmem[36];
	static struct hist_buf fhist = {36, fhmem, fhmem};
	static int imode=1;
	static int init=1;
	static int fprog = 0;

	if (init)
	{
		init = 0;
		fhmem[0] = fhmem[1] = '\0';

		for(i = F01; i < F10; i++)
			fkeys[i][0] = '\0';
	}

	retype = NULL;
	con_flush();

	(*p)--;			/* we need one char more (for '\0')	*/
	line_cnt = 1;
	p[1] = '\0';
	end = p + p[0] + 1;
	q = p + 1;
	while ((c = con_getc()) != RETURN)
	{
		switch(c)
		{
			case CUP:
			case CDOWN:
				if (c == CUP)
				{
					if (!retype)
						retype = hist->undo;
					else if (*(retype + strlen(retype) + 1))
						retype += strlen(retype) + 1;
					else
						break;
				}
				else
				{
					if (!retype)
						retype = hist->undo;
					else if (retype != hist->hb)
						for (retype -= 1;
						  retype != hist->hb &&
						    retype[-1]; retype--)
							;
					else
						break;
				}

			case RETYPE:
				if (!retype)
					retype = hist->undo;

				/* go to start of input line */
				e = q - p - 1;
				cursorOFF();
				for(i = 0; i < e; i++)
					cursorLEFT();

				/* delete to end of input line */
				storeXY(&x, &y);
				e = strlen(p+1);
				for (i = 0; i < e; i++)
					con_chr(' ');
				gotoXY(x, y);

				/* copy old input line and print it */
				strncpy(p + 1, retype, *p);
				*(p + *p + 1) = '\0';
				con_str1(p + 1);
				cursorON();
				q = p + 1 + strlen(p + 1);
				break;

			case CLEFT:
				if (q > p + 1)
				{
					q--;
					cursorLEFT();
				}
				break;

			case CRIGHT:
				if (*q != '\0')
					con_chr(*q++);
				break;

			case START:
				e = q - p - 1;
				cursorOFF();
				for(i = 0; i < e; i++)
					cursorLEFT();
				cursorON();
				q = p + 1;
				break;

			case END:
				cursorOFF();
				con_str1(q);
				cursorON();
				q += strlen(q);
				break;

			case BACKDEL:
				if (q > p + 1)
				{
					cursorLEFT();
					storeXY(&x, &y);
					strcpy(q-1, q);
					q--;
					cursorOFF();
					con_str1(q);
					con_chr(' ');
					gotoXY(x, y);
					cursorON();
				}
				break;

			case FORWDEL:
				if (*q != '\0')
				{
					storeXY(&x, &y);
					strcpy(q, q + 1);
					cursorOFF();
					con_str1(q);
					con_chr(' ');
					gotoXY(x, y);
					cursorON();
				}
				break;

			case CLEAR:
				e = q - p - 1;
				cursorOFF();
				for(i = 0; i < e; i++)
					cursorLEFT();

				storeXY(&x, &y);

				q = p + 1;

				e = strlen(q);

				for (i = 0; i < e; i++)
					con_chr(' ');

				gotoXY(x, y);
				cursorON();

				*q = '\0';
				break;

			case KILL:
				if (*q != '\0')
				{
					storeXY(&x, &y);
					cursorOFF();
					e = strlen(q);
					for (i = 0; i < e; i++)
						con_chr(' ');
					*q = '\0';
					gotoXY(x, y);
					cursorON();
				}
				break;

			case INSERT:
				imode = !imode;
				break;

			case FPROG:
				if(!fprog)
				{
					fprog = 1;
					cursorOFF();
					storeXY(&x, &y);
					gotoXY(0, 0);
					reverseON();
					for (i = 0; i < screen->width; i++)
						con_chr(' ');
					gotoXY(0, 0);
					con_str1("Press function key: ");
					cursorON();
					con_flush();
					do
						c = con_getc();
					while(c < FSTART);
					cursorOFF();
					gotoXY(0, 0);
					con_str1("Enter text:                     ");
					gotoXY(12, 0);
					fbuf[0] = 17;
					cursorON();
					con_flush();
					read_str(fbuf, &fhist);
					cursorOFF();
					status();
					gotoXY(x, y);
					cursorON();
					strcpy(fkeys[c - FSTART], fbuf + 1);
					fprog = 0;
				}
				break;

			default:
				if (strlen(p + 1) < p[0] || (*q && !imode))
				{
					if (c >= ' ' && c < 0x80)
					{
						if (imode)
						{
							for (src = q + strlen(q),
								dst = q + strlen(q) + 1;
								src >= q;
								*dst-- = *src--)
								;
							*q = c;
							cursorOFF();
							con_str1(q++);
							e = strlen(q);
							for(i = 0; i < e; i++)
								cursorLEFT();
							cursorON();
						}
						else
						{
							if (!*q)
								*(q+1) = '\0';
							*q++ = c;
							con_chr(c);
						}
					}
					else if (c >= FSTART)
					{
						if (!*q)
						{
							strncpy(q, fkeys[c - FSTART], end - q);
							cursorOFF();
							con_str1(q);
							cursorON();
							q += strlen(q);
						}
						else if (imode)
						{
							if (end - q - strlen(q) < strlen(fkeys[c - FSTART]))
								dst = end + 1;
							else
								dst = q + strlen(fkeys[c - FSTART]) + strlen(q) + 1;

							cursorOFF();
							for (src = q + strlen(q) + 1; src >= q; *dst-- = *src--)
								;

							for(src = fkeys[c - FSTART]; q <= dst;)
								con_chr(*q++ = *src++);

							con_str1(q);
							e = strlen(q);
							for(i = 0; i < e; i++)
								cursorLEFT();
							cursorON();
						}
						else
						{
							if(strlen(q) < strlen(fkeys[c - FSTART]))
							{
								strncpy(q, fkeys[c - FSTART], end - q);
								dst = q + strlen(fkeys[c - FSTART]);
								dst = (dst < end)?dst:end;
							}
							else
							{
								for(src = fkeys[c - FSTART], dst = q; *src && dst < end; *dst++ = *src++)
									;
							}
							cursorOFF();
							con_str2(q, dst);
							cursorON();
							q = dst;
						}
					}
				}
		}
		con_flush();
	}

	(*p)++;		/* restore original maxlen	*/

	if (!retype)
		retype = hist->undo;

	if (strcmp(retype, p + 1) && strlen(p + 1))
	{
		for (src = hist->hb + hist->len - strlen(p + 1) - 2,
		  dst = hist->hb + hist->len - 1;
		    src >= hist->hb; *dst-- = *src--)
			;

		strcpy(hist->hb, p + 1);

		hist->hb[hist->len - 2] = hist->hb[hist->len - 1] = '\0';
		hist->undo = hist->hb;
	}
	else
		hist->undo = retype;

	cursorOFF();
	con_str1(q);
	cursorON();
	putc_dev('\n', screen);
	con_flush();
	return(p + strlen(p + 1) + 1);
}
