#include <exec/types.h>
#include <string.h>

#include "game_proto.h"

#define LZW

#ifdef LZW

#include "rplib.h"

static compress_hash	hassu;

ULONG
pack(UBYTE *src, UBYTE *dst, ULONG len)
{
	return encompress(src, dst, len, hassu);
}

ULONG
unpack(UBYTE *src, UBYTE *dst, ULONG len)
{
	return decompress(src, dst, len);
}

#else

/*
 * run-length compression
 *
 */

static ULONG	*wrk_mem[(256 * 4)];

ULONG
pack(UBYTE *src, UBYTE *dst, ULONG len)
{
	int	i;
	UBYTE	*d, *s, *ed, *es, *em, mx = 0, r;

	em = src + len - 3;
	es = src + len;
	ed = dst + len;
	s = src;

	for(i = 0; i < 256; i++) wrk_mem[i] = 0;

	while(s < es)
		wrk_mem[*s++]++;

	for(i = 0; i < 256; i++)
		if (wrk_mem[i] < wrk_mem[mx]) mx = i;

	s = src;

	d = dst;
	
	*d++ = 0;
	*d++ = mx;

	while (d < ed && s < es) {
		if (s > em || s[0] != s[1] ||
			s[0] != s[2]) {
			*d = *s++;
			if (*d++ == mx) {
				if (s <= em && *s == mx) {
					*d++ = 1;
					s++;
				} else {
					*d++ = 0;
				}
				*d++ = mx;
			}
		} else {
			i = 2; r = *s; s += 3;
			for(;s < es && *s == r && ++i < 255; s++)
				; /* void */
			*d++ = mx; *d++ = i; *d++ = r;
		}
	}

	if (d >= ed) { /* overrun */
		*dst = 1;
		memcpy(&dst[1], src, len);
		return (len + 1);
	}

	return((ULONG)(d - dst));
}

ULONG
unpack(UBYTE *src, UBYTE *dst, ULONG len)
{
	UBYTE mx, i, *d,*es;
	
	es = src + len;
	if (len < 2) return 0;
	if (*src++) {
		memcpy(dst, src, len - 1);
		return(len - 1);
	}
	d = dst;
	mx = *src++;
	while (src < es) {
		if (*src == mx) {
			i = src[1];
			do { *d++ = src[2]; } while(i--);
			src += 3;
		} else {
			*d++ = *src++;
		}
	}
	return((ULONG)(d - dst));
}
#endif /* !LZW */
