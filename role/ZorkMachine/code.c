/*
*	@(#)code.c	2.24
*/

#include "zmachine.h"

#ifdef AMIGA
#define TRACE 1
#endif	/* AMIGA */

/*
* decoding/encoding module
*/

char *codetab = 
"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ  0123456789.,!?_#'\"/\\-:()\0";

extern UBYTE *short_cuts;

/*
* decode the string at vaddress a
*/

#ifdef TRACE
void ppdecode(a)
struct address *a;
{
    UWORD op;
    register UWORD d2;
    register UWORD d4 = 0;
    register UWORD d5 = 0;
    register UBYTE *p;
    struct address vaddr;
    UWORD f76 = 0;
    UBYTE b[3];

    do
    {
        op = d2 = fetchw_data(a);
        for (p = b; p - b < 3; p++)
        {
            *p = d2;
            d2 >>= 5;
        }

        while (p - b > 0)
        {
            d2 = *--p & 0x1f;
            if (d4 & 0x8000)
            {
                waddr_to_vaddr(&vaddr, word_get(&short_cuts[(d2 + f76)*2]));
		ppdecode(&vaddr);
                d4 = d5;
            }
            else
            {
                if (d4 == 3)
                    d4 = 0x4000 + d2;
                else if (d4 > 3)
                {
                    d4 &= 3;
                    d4 <<= 5;
                    d4 |= d2;
#ifdef AMIGA
                    DPrintf("%lc",d4);
#else
                    output_chr(d4);
#endif	/* AMIGA */
                    d4 = d5;
                }
                else
                {
                    if (d2 >= 6)
                    {
                        if (d4 == 2)
                        {
                            if (d2 < 7)
                                d4++;
                            else if (d2 == 7)
                            {
#ifdef AMIGA
				DPrintf("\\n");
#else
                                putchar('\n');
#endif	/* AMIGA */
                                d4 = d5;
                            }
                            else
                            {
#ifdef AMIGA
				DPrintf("%lc",codetab[d4 * 0x1a + d2 - 6]);
#else
                                putchar(codetab[d4 * 0x1a + d2 - 6]);
#endif	/* AMIGA */
                                d4 = d5;
                            }
                        }
                        else
                        {
#ifdef AMIGA
                            DPrintf("%lc",codetab[d4 * 0x1a + d2 - 6]);
#else
                            putchar(codetab[d4 * 0x1a + d2 - 6]);
#endif	/* AMIGA */
                            d4 = d5;
                        }
                    }
                    else
                    {
                        if (d2 == 0)
                        {
#ifdef AMIGA
                            DPrintf(" ");
#else
                            putchar(' ');
#endif	/* AMIGA */
                            d4 = d5;
                        }
                        else
                        {
                            if (d2 <= 3)
                            {
                                d4 |= ~0x7fff;
                                f76 = (d2 - 1) << 5;
                            }
                            else
                            {
                                d2 -= 3;
                                if (d4 == 0)
                                    d4 = d2;
                                else
                                {
                                    if (d4 != d2)
                                        d4 = 0;
				    d5 = d4;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    while (!(op & 0x8000));
}

void pdecode(a)
struct address *a;
	{
	struct address b;
	b = *a;
	ppdecode(a);
	*a = b;
	}
#endif


void decode(a)
struct address *a;
{
    UWORD op;
    register UWORD d2;
    register UWORD d4 = 0;
    register UWORD d5 = 0;
    register UBYTE *p;
    struct address vaddr;
    UWORD f76 = 0;
    UBYTE b[3];

    do
    {
        op = d2 = fetchw_data(a);
        for (p = b; p - b < 3; p++)
        {
            *p = d2;
            d2 >>= 5;
        }

        while (p - b > 0)
        {
            d2 = *--p & 0x1f;
            if (d4 & 0x8000)
            {
                waddr_to_vaddr(&vaddr, word_get(&short_cuts[(d2 + f76)*2]));
		decode(&vaddr);
                d4 = d5;
            }
            else
            {
                if (d4 == 3)
                    d4 = 0x4000 + d2;
                else if (d4 > 3)
                {
                    d4 &= 3;
                    d4 <<= 5;
                    d4 |= d2;
                    output_chr(d4);
                    d4 = d5;
                }
                else
                {
                    if (d2 >= 6)
                    {
                        if (d4 == 2)
                        {
                            if (d2 < 7)
                                d4++;
                            else if (d2 == 7)
                            {
                                output_chr('\n');
                                d4 = d5;
                            }
                            else
                            {
                                output_chr(codetab[d4 * 0x1a + d2 - 6]);
                                d4 = d5;
                            }
                        }
                        else
                        {
                            output_chr(codetab[d4 * 0x1a + d2 - 6]);
                            d4 = d5;
                        }
                    }
                    else
                    {
                        if (d2 == 0)
                        {
                            output_chr(' ');
                            d4 = d5;
                        }
                        else
                        {
                            if (d2 <= 3)
                            {
                                d4 |= ~0x7fff;
                                f76 = (d2 - 1) << 5;
                            }
                            else
                            {
                                d2 -= 3;
                                if (d4 == 0)
                                    d4 = d2;
                                else
                                {
                                    if (d4 != d2)
                                        d4 = 0;
				    d5 = d4;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    while (!(op & 0x8000));
}


/* return the code group of c */

UWORD code_group(c)
register char c;
{
	if (!c)
		return(3);

	if (c >= 'a' && c <= 'z')
			return(0);

	if (c >= 'A' && c <= 'Z')
			return(1);

	return(2);
}

/*
* return the index
* of c in the codetab
*/

UWORD code_index(c)
char c;
{
	register char *p;
	register UWORD i;
	char *strchr();

	p = strchr(codetab,c);

	if (p)
	{
		for (i = p - codetab + 6; i >= 0x20; i -= 0x1a)
			;
		return(i);
	}
	else
		return(0);
}


/*
* code a word of
* max 6 chars to dest
*/

void encode(dst, src)
register UWORD *dst; char *src;
{
	register UWORD t, i;
	register UWORD *tp;
	UWORD b[12];
	char c;

	for(tp = b, i = 6; (c = *(src++)) && i; i--)
	{
		if (t = code_group(c))
		{
			t += 3;
			*(tp++) = t;
			if (!--i)
				break;
		}

		if (!(t = code_index(c)))
		{
			*(tp++) = 6;
			if (!--i)
				break;
			*(tp++) = c >> 5;
			if (!--i)
				break;

			t = c & 0x1f;
		}
		*(tp++) = t;
	}

	for (; i; i--)
		*(tp++) = 5;

	for (tp = b, i = 2; i; i--)
	{
		t  = (*tp++ << 10) & (0x1f << 10);
		t |= (*tp++ <<  5) & (0x1f <<  5);
		t |= (*tp++)       & (0x1f);
		*dst++ = t;
	}
	dst[-1] |= 0x8000;
}
