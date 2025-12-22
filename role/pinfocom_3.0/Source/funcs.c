/* functions.c
 *
 *  ``pinfocom'' -- a portable Infocom Inc. data file interpreter.
 *  Copyright (C) 1987-1992  InfoTaskForce
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; see the file COPYING.  If not, write to the
 *  Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/*
 * $Header: RCS/funcs.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include    "infocom.h"

void
plus A2(word, a, word, b)
{
    store(a + b);
}

void
minus A2(word, a, word, b)
{
    store(a - b);
}

void
multiply A2(word, a, word, b)
{
    store(a * b);
}

void
divide A2(word, a, word, b)
{
    store(a / b);
}

void
mod A2(word, a, word, b)
{
    store(a % b);
}

void
pi_random A1(word, num)
{
    extern word     random1;
    extern word     random2;

    word            temp;

    temp = random1 << 1;
    random1 = random2;
    if (random2 & 0x8000)
        ++temp;
    random2 ^= temp;

    if (num)
        store(((word)(random2 & 0x7FFF) % num) + 1);
    else
        store(0);
}

void
LTE A2(word, a, word, b)
{
    ret_value((signed_word)a < (signed_word)b);
}

void
GTE A2(word, a, word, b)
{
    ret_value((signed_word)a > (signed_word)b);
}

void
bit A2(word, a, word, b)
{
    ret_value((b & (~a)) == 0);
}

void
or A2(word, a, word, b)
{
    store(a | b);
}

void
not A1(word, a)
{
    store(~a);
}

void
and A2(word, a, word, b)
{
    store(a & b);
}

void
compare A2(word, num, const word *, param)
{
    const word *pp;
    Bool equal = 0;

    for (pp = &param[1]; num > 1; ++pp, --num)
        equal |= (*param == *pp);

    ret_value(equal);
}

void
cp_zero A1(word, a)
{
    ret_value(a == 0);
}
