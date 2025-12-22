/*
 * OS-dependent module for Amiga run-time.
 *
 * David Kinder
 */

#include <ctype.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "os.h"
#include "osgen.h"
#include "trd.h"
#include "voc.h"

#define COLOUR_NORMAL  0
#define COLOUR_REVERSE 1
#define COLOUR_BOLD    2

int InputRow,InputCol;
int CursorX,CursorY;

char SwapName[256];
osfildef* SwapFile = NULL;

void amiga_exit(void);
void amiga_putchar(int c);
void amiga_move(int x,int y);
void ossclr(int top, int left, int bottom, int right, int blank_color);

int brk(void)
{
	amiga_move(0,G_oss_screen_height-1);
	printf("\033[0m\n***Break\n");
	amiga_exit();
	exit(0);
}

void amiga_exit(void)
{
	if (SwapFile)
	{
		osfcls(SwapFile);
		osfdel(SwapName);
	}
}

int os_init(int *argc, char *argv[], const char *prompt, char *buf, int bufsiz)
{
	G_oss_screen_width = 76;
	G_oss_screen_height = 20;

	sdesc_color = COLOUR_REVERSE;
	text_color  = COLOUR_NORMAL;

	osssbini(4096);
	ossclr(0,0,0,0,0);
	status_mode = 1;
	os_printz("TADS");
	status_mode = 0;
	os_score(0,0);

	//onbreak(brk);
	return 0;
}

void os_term(int status)
{
	amiga_move(0,G_oss_screen_height-1);
	putchar('\n');
	amiga_exit();
	exit(status);
}

void os_waitc(void)
{
	os_getc();
}

int os_getc(void)
{
int c;

	printf("\033[0m");
	amiga_move(InputCol,InputRow);
	c = getchar();
	if (c == '\n')
		c = '\r';
	return c;
}

void ossdsp(int y, int x, int color, const char *msg)
{
int i;

	amiga_move(x,y);
	switch (color)
	{
		case COLOUR_REVERSE:
			printf("\033[7m");
			break;
		case COLOUR_BOLD:
			printf("\033[1m");
			break;
		default:
			printf("\033[0m");
			break;
	}
	for (i = 0; i < strlen(msg); i++)
		amiga_putchar(*(msg+i));
}

void ossclr(int top, int left, int bottom, int right, int blank_color)
{
	printf("\x0C");
}

void ossscu(int top, int left, int bottom, int right, int blank_color)
{
}

void ossscr(int top, int left, int bottom, int right, int blank_color)
{
	fflush(stdout);
	amiga_move(0,top);
	printf("\033[M");
	amiga_move(CursorX,CursorY);
}

void ossloc(int row, int col)
{
	InputRow = row;
	InputCol = col;
}

void amiga_putchar(int c)
{
	putchar(c);
	CursorX++;
}

void amiga_move(int x, int y)
{
	CursorX = x;
	CursorY = y;
	fflush(stdout);
	printf("\033[%d;%dH",y+1,x+1);
}

char *strlwr(char *s)
{
	char *s1 = s;

	while (*s)
	{
		if (isupper(*s))
			*s = tolower(*s);
		s++;
	}
	return s1;
}

char *os_strlwr(char *s)
{
	return strlwr(s);
}

void os_get_tmp_path(char *s)
{
	strcpy(s,"T:");
}

void os_defext(char *fn, const char *ext)
{
char *p;

	p = fn+strlen(fn);
	while (p > fn)
	{
		p--;
		if ( *p=='.' ) return;
		if ( *p=='/' || *p==':') break;
	}
	strcat(fn,".");
	strlwr(ext);
	strcat(fn,ext);
}

void os_remext(char *fn)
{
	char *p = fn+strlen(fn);
	while (p > fn)
	{
		p--;
		if ( *p=='.' )
		{
			*p = '\0';
			return;
		}
		if ( *p=='/' || *p==':') return;
	}
}

int memicmp(char* s1, char* s2, int len)
{
char *x1, *x2;  
int result;
int i;

	x1 = malloc(len);
	x2 = malloc(len);

	if (!x1 || !x2)
	{
		printf("Out of memory!\n");
		amiga_exit();
		exit(-1);
	}

	for (i = 0; i < len; i++)
	{
		if (isupper(s1[i]))
			x1[i] = tolower(s1[i]);
		else
			x1[i] = s1[i];

		if (isupper(s2[i]))
			x2[i] = tolower(s2[i]);
		else
			x2[i] = s2[i];
	}

	result = memcmp(x1,x2,len);
	free(x1);
	free(x2);
	return result;
}

osfildef *os_exeseek(const char *exefile, const char *typ)
{
	return (osfildef *)0;
}

int os_break(void)
{
	return 0;
}

int os_paramfile(char *buf)
{
	return 0;
}

osfildef *os_create_tempfile(const char *swapname, char *buf)
{
	osfildef *fp;

	if (swapname == 0)
	{
		int try;
		size_t len;
		time_t timer;
		int found;

		os_get_tmp_path(buf);
		len = strlen(buf);

		time(&timer);

		for (try = 0, found = FALSE; try < 100; ++try)
		{
			sprintf(buf + len, "SW%06ld.%03d", (long)timer % 999999, try);

			if (osfacc(buf))
			{
				found = TRUE;
				break;
			}
		}

		if (!found)
			return 0;

		swapname = buf;
	}

	fp = osfoprwtb(swapname, OSFTSWAP);
	os_settype(swapname, OSFTSWAP);
	strcpy(SwapName,swapname);
	SwapFile = fp;
	return fp;
}

#ifdef USE_TIMERAND
void os_rand(long *seed)
{
	time_t t;

	time(&t);
	*seed = (long)t;
}
#endif

void os_tzset()
{
}

#ifdef USE_NULLSTYPE
void os_settype(const char *f, int t)
{
}
#endif

void os_fprintf(osfildef *fp, const char *f, ...)
{
	va_list argptr;

	va_start(argptr, f);
	vfprintf(fp, f, argptr);
	va_end(argptr);
}

void os_vfprintf(osfildef *fp, const char *fmt, va_list argptr)
{
	vfprintf(fp, fmt, argptr);
}

int os_locate(const char *fname, int flen, const char *arg0, char *buf, size_t bufsiz)
{
	if (osfacc(fname) == 0)
	{
		memcpy(buf, fname, flen);
		buf[flen] = 0;
		return(1);
	}

	if (arg0 && *arg0)
	{
		char *p;

		for ( p = arg0 + strlen(arg0);
			p > arg0 && *(p-1) != OSPATHCHAR && !strchr(OSPATHALT, *(p-1));
			--p);

		if (p > arg0)
		{
			size_t len = (size_t)(p - arg0);

			memcpy(buf, arg0, len);
			memcpy(buf+len, fname, flen);
			buf[len+flen] = 0;
			if (osfacc(buf) == 0) return(1);
		}
	}

	return(0);
}

char *osfgets(char *s, int n, osfildef *fp)
{
	char  c, *s0 = s;

	if (n <= 1)
	{
		if (n == 1) *s++ = '\0';
		return s0;
	}

	while ((c = fgetc(fp)) != EOF)
	{
		*s++ = c;
		if (c == '\n' || c == '\r' || --n <= 1)
		{
			if (n >= 1) *s++ = '\0';
			return s0;
		}
	}

	if (ferror(fp))
		return NULL;
	else
	{
		if (s == s0)
			return NULL;
		else
		{
			if (n >= 1) *s++ = '\0';
			return s0;
		}
	}
}

#ifdef fopen
#undef fopen
#endif

void *our_memcpy(void *dst, const void *src, size_t size)
{
register char *d;
register const char *s;
register size_t n;

	if (size == 0) return(dst);

	s = src;
	d = dst;
	if ((char *)s <= d && (char *)s + (size-1) >= d)
	{
		s += size-1;
		d += size-1;
		for (n = size; n > 0; n--) *d-- = *s--;
	}
	else
		for (n = size; n > 0; n--) *d++ = *s++;

	return(dst);
}

FILE *our_fopen(filename, flags)
char *filename;
char *flags;
{
	return fopen(filename,flags);
}

char *os_get_root_name(char *buf)
{
	char *rootname;

	for (rootname = buf; *buf != '\0'; ++buf)
	{
		switch(*buf)
		{
			case '/':
			case ':':
				rootname = buf + 1;
				break;
			default:
				break;
		}
	}
	return rootname;
}

void os_addext(char *fn, const char *ext)
{
	strcat(fn,".");
	strcat(fn,ext);
}

void os_xlat_html4(unsigned int html4_char, char *result, size_t result_len)
{
	if (html4_char < 128)
	{
		result[0] = (unsigned char)html4_char;
		result[1] = '\0';
		return;
	}
	result[0] = '?';
	result[1] = '\0';
}

void os_advise_load_charmap(char *id, char *ldesc, char *sysinfo)
{
}

void os_gen_charmap_filename(char *filename, char *internal_id, char *argv0)
{
	filename = NULL;
}

void os_sleep_ms(long delay_in_milliseconds)
{
	Delay(delay_in_milliseconds/20);
}

int osfdel_temp(const char *fname)
{
	osfdel(fname);
	SwapFile = NULL;
	return 0;
}

long os_get_sys_clock_ms(void)
{
	static long timeZero = 0;

	if (timeZero == 0)
		timeZero = time(0);
	return ((time(0) - timeZero) * 1000);
}

int os_get_event(unsigned long timeout_in_milliseconds, int use_timeout, os_event_info_t *info)
{
	if (use_timeout)
			return OS_EVT_NOTIMEOUT;

	info->key[0] = os_getc();
	if (info->key[0] == 0)
			info->key[1] = os_getc();
	return OS_EVT_KEY;
}

void os_set_title(const char *title)
{
}

int osfrb(osfildef *fp, unsigned char *buf, int bufl)
{
	return (fread(buf, bufl, 1, fp) != 1);
}

int osfwb(osfildef *fp, unsigned char *buf, int bufl)
{
	return (fwrite(buf, bufl, 1, fp) != 1);
}

typedef int (*external_fn)(void *);

external_fn os_exfil(const char *name)
{
	return 0;
}

external_fn os_exfld(osfildef *fp, unsigned len)
{
	return 0;
}

int os_excall(int (*extfn)(void *), void *arg)
{
	return 0;
}

int os_getc_raw(void)
{
	return os_getc();
}

osfildef *osfoprwb(char *fname, int typ)
{
	osfildef *fp;

	fp = fopen(fname,"r+b");
	if (fp != 0)
		return fp;
	return fopen(fname,"w+b");
}

void os_build_full_path(char *fullpathbuf, size_t fullpathbuflen, const char *path, const char *filename)
{
	size_t plen, flen;
	int add_sep;

	plen = strlen(path);
	add_sep = (plen != 0 && path[plen-1] != OSPATHCHAR && strchr(OSPATHALT, path[plen-1]) == 0);

	if (plen > fullpathbuflen - 1)
		plen = fullpathbuflen - 1;
	memcpy(fullpathbuf, path, plen);

	if (add_sep && plen + 2 < fullpathbuflen)
		fullpathbuf[plen++] = OSPATHCHAR;

	flen = strlen(filename);
	if (flen > fullpathbuflen - plen - 1)
		flen = fullpathbuflen - plen - 1;
	memcpy(fullpathbuf + plen, filename, flen);

	fullpathbuf[plen + flen] = '\0';
}

int oss_get_sysinfo(int code, void *param, long *result)
{
	switch(code)
	{
	case SYSINFO_TEXT_COLORS:
		*result = SYSINFO_TXC_PARAM;
		return TRUE;
	case SYSINFO_TEXT_HILITE:
		*result = 1;
		return TRUE;
	}
	return FALSE;
}

int ossgetcolor(int fg, int bg, int attrs, int screen_color)
{
	if (attrs & OS_ATTR_HILITE)
		return COLOUR_BOLD;
	return COLOUR_NORMAL;
}

void os_fprintz(osfildef *fp, const char *str)
{
	fprintf(fp,"%s",str);
}

void oss_raw_key_to_cmd(os_event_info_t *evt)
{
}

int main(int argc, char** argv)
{
	int err;

	os_init(&argc,argv,(char*)0,(char*)0,0);
	err = os0main2(argc,argv,trdmain,"","config.tr",0);
	os_term(err);
}

