/* property.c
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
 * $Header: RCS/property.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include    "infocom.h"

static property
prop_addr A1(object_t *, obj)
{
    extern byte     *base_ptr;

    property        p;

    p = base_ptr + Z_TO_WORD(obj->data);
    return (p + (Z_TO_BYTE(p) << 1) + 1);
}

static property
next_addr A1(property, p)
{
    return (p + (Z_TO_BYTE(p) >> 5) + 2);
}

void
next_prop A2(word, obj_num, word, prop_num)
{
    property    p;
    word        p_num;

    p = prop_addr(obj_addr(obj_num));
    if (prop_num != 0)
    {
        p_num = *p & 0x1F;

        /* Properties are kept in descending order */

        while (p_num > prop_num)
        {
            p = next_addr(p);
            p_num = *p & 0x1F;
        }
        if (p_num < prop_num)
            error("prop: Error retrieving next property ($%02x)", prop_num);
        else
            p = next_addr(p);
    }

    store((word)(*p & 0x1F));
}

void
put_prop A3(word, obj_num, word, prop_num, word, value)
{
    property        p;
    word            p_num;

    p = prop_addr(obj_addr(obj_num));
    p_num = *p & 0x1F;

    /* Properties are kept in descending order */

    while (p_num > prop_num)
    {
        p = next_addr(p);
        p_num = *p & 0x1F;
    }
    if (p_num < prop_num)
        error("prop: Error storing property ($%02x)", prop_num);
    else
    {
        if ((*p++) & 0x20)
        {
            (*p++) = value >> 8;
            *p = value;
        }
        else
            *p = value;
    }
}

void
get_prop A2(word, obj_num, word, prop_num)
{
    property        p;
    word            p_num;
    word            prop;

    p = prop_addr(obj_addr(obj_num));
    p_num = *p & 0x1F;

    /* Properties are kept in descending order */

    while (p_num > prop_num)
    {
        p = next_addr(p);
        p_num = *p & 0x1F;
    }
    if (p_num < prop_num)
    {
        prop_num = (--prop_num) << 1;
        p = (property) objd.obj_base + prop_num;
        prop = Z_TO_WORD(p);
    }
    else
    {
        if (*(p++) & 0x20)
            prop = Z_TO_WORD(p);
        else
            prop = Z_TO_BYTE(p);
    }
    store(prop);
}

void
get_prop_addr A2(word, obj_num, word, prop_num)
{
    extern byte     *base_ptr;

    property        p;
    word            p_num;

    p = prop_addr(obj_addr(obj_num));
    p_num = *p & 0x1F;

    /* Properties are kept in descending order */

    while (p_num > prop_num)
    {
        p = next_addr(p);
        p_num = *p & 0x1F;
    }
    if (p_num < prop_num)
        store(0);
    else
        store((word)(p + 1 - base_ptr));
}

void
get_prop_len A1(word, prop_num)
{
    extern byte     *base_ptr;

    property        p;

    p = base_ptr + prop_num - 1;
    store((word)((Z_TO_BYTE(p) >> 5) + 1));
}

void
load_word_array A2(word, base, word, offset)
{
    word    page;
    word    page_offset;

    base += (offset << 1);
    page = base / BLOCK_SIZE;
    page_offset = base % BLOCK_SIZE;
    store(get_word(&page, &page_offset));
}

void
load_byte_array A2(word, base, word, offset)
{
    word    page;
    word    page_offset;

    base += offset;
    page = base / BLOCK_SIZE;
    page_offset = base % BLOCK_SIZE;
    store((word)get_byte(&page, &page_offset));
}

void
save_word_array A3(word, base, word, offset, word, value)
{
    extern byte     *base_ptr;

    byte            *ptr;

    /* The quantity added to 'base_ptr' must be a word */

    base += (offset << 1);
    ptr = base_ptr + base;
    (*ptr++) = value >> 8;
    *ptr = value;
}

void
save_byte_array A3(word, base, word, offset, word, value)
{
    extern byte     *base_ptr;

    byte            *ptr;

    /* The quantity added to 'base_ptr' must be a word */

    base += offset;
    ptr = base_ptr + base;
    *ptr = value;
}
