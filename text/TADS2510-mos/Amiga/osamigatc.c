/*
 * OS-dependent module for Amiga compiler.
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
#include "tcd.h"
#include "voc.h"

void amiga_exit(void);

#define MAX_SWAP 2
struct SwapFile
{
	char Name[256];
	osfildef* File;
};
struct SwapFile SwapFiles[MAX_SWAP];
int SwapCount = 0;

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
	/* Overlap, must copy right-to-left. */
		s += size-1;
		d += size-1;
		for (n = size; n > 0; n--) *d-- = *s--;
	}
	else
		for (n = size; n > 0; n--) *d++ = *s++;

	return(dst);
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
		if ( *p=='.' ) return;      /* already has an extension */
		if ( *p=='/' || *p==':') break;     /* found a path */
	}
	strcat(fn,".");       /* add a dot */
	strlwr(ext);
	strcat(fn,ext);       /* add the extension */
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

int unix_tc;

void os_waitc(void)
{
	getchar();
}

int os_getc(void)
{
	return getchar();
}

void os_addext(char *fn, const char *ext)
{
	strcat(fn, ".");
	strcat(fn, ext);
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

	if (SwapCount < MAX_SWAP)
	{
		strcpy(SwapFiles[SwapCount].Name,swapname);
		SwapFiles[SwapCount].File = fp;
		SwapCount++;
	}
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

void amiga_exit(void)
{
	int i;
	for (i = 0; i < SwapCount; i++)
	{
		osfcls(SwapFiles[i].File);
		osfdel(SwapFiles[i].Name);
	}
}

int os_yield(void)
{
	return 0;
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

void os_xlat_html4(unsigned int html4_char, char *result, size_t result_len)
{
	/* default character to use for unknown characters */
#define INV_CHAR "·"

	/* 
	 *   Translation table - provides mappings for characters the ISO
	 *   Latin-1 subset of the HTML 4 character map (values 128-255).
	 *   Characters marked "(not used)" are not used by HTML '&' markups.  
	 */
	static const char *xlat_tbl[] =
	{
		INV_CHAR,                                         /* 128 (not used) */
		INV_CHAR,                                         /* 129 (not used) */
		"'",                                                 /* 130 - sbquo */
		INV_CHAR,                                         /* 131 (not used) */
		"\"",                                                /* 132 - bdquo */
		INV_CHAR,                                         /* 133 (not used) */
		INV_CHAR,                                           /* 134 - dagger */
		INV_CHAR,                                           /* 135 - Dagger */
		INV_CHAR,                                         /* 136 (not used) */
		INV_CHAR,                                           /* 137 - permil */
		INV_CHAR,                                         /* 138 (not used) */
		"<",                                                /* 139 - lsaquo */
		"OE",                                                /* 140 - OElig */
		INV_CHAR,                                         /* 141 (not used) */
		INV_CHAR,                                         /* 142 (not used) */
		INV_CHAR,                                         /* 143 (not used) */
		INV_CHAR,                                         /* 144 (not used) */
		"'",                                                 /* 145 - lsquo */
		"'",                                                 /* 146 - rsquo */
		"\"",                                                /* 147 - ldquo */
		"\"",                                                /* 148 - rdquo */
		INV_CHAR,                                         /* 149 (not used) */
		"-",                                                /* 150 - endash */
		"-",                                                /* 151 - emdash */
		INV_CHAR,                                         /* 152 (not used) */
		"(tm)",                                              /* 153 - trade */
		INV_CHAR,                                         /* 154 (not used) */
		">",                                                /* 155 - rsaquo */
		"oe",                                                /* 156 - oelig */
		INV_CHAR,                                         /* 157 (not used) */
		INV_CHAR,                                         /* 158 (not used) */
		"Y",                                                  /* 159 - Yuml */
		INV_CHAR,                                         /* 160 (not used) */
		"¡",                                                 /* 161 - iexcl */
		"¢",                                                  /* 162 - cent */
		"£",                                                 /* 163 - pound */
		INV_CHAR,                                           /* 164 - curren */
		"¥",                                                   /* 165 - yen */
		"|",                                                /* 166 - brvbar */
		INV_CHAR,                                             /* 167 - sect */
		INV_CHAR,                                              /* 168 - uml */
		"©",                                                  /* 169 - copy */
		"ª",                                                  /* 170 - ordf */
		"«",                                                 /* 171 - laquo */
		"¬",                                                   /* 172 - not */
		" ",                                                   /* 173 - shy */
		"®",                                                   /* 174 - reg */
		INV_CHAR,                                             /* 175 - macr */
		"°",                                                   /* 176 - deg */
		"±",                                                /* 177 - plusmn */
		"²",                                                  /* 178 - sup2 */
		"³",                                                  /* 179 - sup3 */
		"'",                                                 /* 180 - acute */
		"µ",                                                 /* 181 - micro */
		INV_CHAR,                                             /* 182 - para */
		"·",                                                /* 183 - middot */
		",",                                                 /* 184 - cedil */
		"¹",                                                  /* 185 - sup1 */
		"º",                                                  /* 186 - ordm */
		"»",                                                 /* 187 - raquo */
		"¼",                                                /* 188 - frac14 */
		"½",                                                /* 189 - frac12 */
		"¾",                                                /* 190 - frac34 */
		"¿",                                                /* 191 - iquest */
		"À",                                                /* 192 - Agrave */
		"Á",                                                /* 193 - Aacute */
		"Â",                                                 /* 194 - Acirc */
		"Ã",                                                /* 195 - Atilde */
		"Ä",                                                  /* 196 - Auml */
		"Å",                                                 /* 197 - Aring */
		"Æ",                                                 /* 198 - AElig */
		"Ç",                                                /* 199 - Ccedil */
		"È",                                                /* 200 - Egrave */
		"É",                                                /* 201 - Eacute */
		"Ê",                                                 /* 202 - Ecirc */
		"Ë",                                                  /* 203 - Euml */
		"Ì",                                                /* 204 - Igrave */
		"Í",                                                /* 205 - Iacute */
		"Î",                                                 /* 206 - Icirc */
		"Ï",                                                  /* 207 - Iuml */
		"Ð",                                                   /* 208 - ETH */
		"Ñ",                                                /* 209 - Ntilde */
		"Ò",                                                /* 210 - Ograve */
		"Ó",                                                /* 211 - Oacute */
		"Ô",                                                 /* 212 - Ocirc */
		"Õ",                                                /* 213 - Otilde */
		"Ö",                                                  /* 214 - Ouml */
		"×",                                                 /* 215 - times */
		"Ø",                                                /* 216 - Oslash */
		"Ù",                                                /* 217 - Ugrave */
		"Ú",                                                /* 218 - Uacute */
		"Û",                                                 /* 219 - Ucirc */
		"Ü",                                                  /* 220 - Uuml */
		"Ý",                                                /* 221 - Yacute */
		"Þ",                                                 /* 222 - THORN */
		"ß",                                                 /* 223 - szlig */
		"à",                                                /* 224 - agrave */
		"á",                                                /* 225 - aacute */
		"â",                                                 /* 226 - acirc */
		"ã",                                                /* 227 - atilde */
		"ä",                                                  /* 228 - auml */
		"å",                                                /* 229 - aring */
		"æ",                                                 /* 230 - aelig */
		"ç",                                                /* 231 - ccedil */
		"è",                                                /* 232 - egrave */
		"é",                                                /* 233 - eacute */
		"ê",                                                 /* 234 - ecirc */
		"ë",                                                  /* 235 - euml */
		"ì",                                                /* 236 - igrave */
		"í",                                                /* 237 - iacute */
		"î",                                                 /* 238 - icirc */
		"ï",                                                  /* 239 - iuml */
		"ð",                                                   /* 240 - eth */
		"ñ",                                                /* 241 - ntilde */
		"ò",                                                /* 242 - ograve */
		"ó",                                                /* 243 - oacute */
		"ô",                                                 /* 244 - ocirc */
		"õ",                                                /* 245 - otilde */
		"ö",                                                  /* 246 - ouml */
		"÷",                                                /* 247 - divide */
		"ø",                                                /* 248 - oslash */
		"ù",                                                /* 249 - ugrave */
		"ú",                                                /* 250 - uacute */
		"û",                                                 /* 251 - ucirc */
		"ü",                                                  /* 252 - uuml */
		"ý",                                                /* 253 - yacute */
		"þ",                                                 /* 254 - thorn */
		"ÿ"                                                   /* 255 - yuml */
	};

	/*
	 *   Map certain extended characters into our 128-255 range.  If we
	 *   don't recognize the character, return the default invalid
	 *   charater value.  
	 */
	if (html4_char > 255)
	{
		switch(html4_char)
		{
		case 338: html4_char = 140; break;
		case 339: html4_char = 156; break;
		case 376: html4_char = 159; break;
		case 352: html4_char = 154; break;
		case 353: html4_char = 138; break;
		case 8211: html4_char = 150; break;
		case 8212: html4_char = 151; break;
		case 8216: html4_char = 145; break;
		case 8217: html4_char = 146; break;
		case 8218: html4_char = 130; break;
		case 8220: html4_char = 147; break;
		case 8221: html4_char = 148; break;
		case 8222: html4_char = 132; break;
		case 8224: html4_char = 134; break;
		case 8225: html4_char = 135; break;
		case 8240: html4_char = 137; break;
		case 8249: html4_char = 139; break;
		case 8250: html4_char = 155; break;
		case 8482: html4_char = 153; break;
		default:
			result[0] = '·';
			result[1] = 0;
			return;
		}
	}
	
	/* 
	 *   if the character is in the regular ASCII zone, return it
	 *   untranslated 
	 */
	if (html4_char < 128)
	{
		result[0] = (unsigned char)html4_char;
		result[1] = '\0';
		return;
	}
	/* look up the character in our table and return the translation */
	strcpy(result, xlat_tbl[html4_char - 128]);
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
	return 0;
}

long os_get_sys_clock_ms(void)
{
	static long timeZero = 0;

	if (timeZero == 0)
		timeZero = time(0);
	return ((time(0) - timeZero) * 1000);
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
	return getchar();
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

void os_fprintz(osfildef *fp, const char *str)
{
	fprintf(fp,"%s",str);
}

int main(int argc, char** argv)
{
	int err;
	extern int unix_tc;

	unix_tc = 1;
	//os_init(&argc,argv,(char *)0,(char *)0,0);
	err = os0main(argc,argv,tcdmain,"i","config.tc");
	//os_term(err);
}
