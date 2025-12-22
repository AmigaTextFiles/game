/* print.c
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
 * $Header: RCS/print.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include <stdio.h>
#include <string.h>

#include "infocom.h"

#define BUFMIN              80
#define LONG_SCORE_WIDTH    60
#define MAX_MOVES           1599
#define STATLEN             24

int     print_mode;     /* General Printing Mode           */
int     single_mode;    /* Mode for printing the next char */

static word word_bank;  /* There are 3 banks of common     */
                        /* words, each 32 words long.      */

static print_buf_t text, room;

static char score_buf[STATLEN+1];

void
print_init()
{
    extern print_buf_t  *pbf_p;
    extern char         *ti_location;
    extern char         *ti_status;

    text.len = 0;
    text.max = BUFMIN * 5;
    text.buf = (byte *)xmalloc(text.max + 1);
    pbf_p = &text;

    room.max = BUFMIN;
    room.buf = (byte *)xmalloc(room.max + 1);
    room.buf[0] = ' ';
    room.len = 1;

    ti_location = (char *)room.buf;
    ti_status = (char *)score_buf;
}

void
print_num A1(word, number)
{
    Bool    neg;
    int     num;
    char    buf[15], *cp;

    num = (signed_word)number;
    if (neg = (num < 0))
        num = -num;

    cp = buf;
    do
    {
        *(cp++) = '0' + (num % 10);
        num /= 10;
    }
    while (num > 0);

    if (neg)
        *cp = '-';
    else
        --cp;

    for (; cp >= buf; --cp)
        print_char((word)*cp);
}

/*
 * Print a hex number in a fixed-width space -- NOTE: this function
 * cannot be called with a value > 0xff if !is_eobj, or 0xffff if
 * is_eobj.
 */
char *
print_hnum A1(word, num)
{
    static char buf[10];
    char *cp;

    cp = &buf[(objd.is_eobj+1) * 2];
    cp[1] = '\0';
    do
    {
        int i;

        i = num % 16;
        *(cp--) = i > 9 ? 'a'+(i-10) : '0'+i;
        num /= 16;
    }
    while (num > 0);

    while (cp > buf)
        *(cp--) = '0';
    *cp = '$';

    return (buf);
}

void
print_str A1(const char *, str)
{
    while (*str != '\0')
        print_char((word)*str++);
}

void
print2 A1(word, address)
{
    word    page;
    word    offset;

    page = address >> 8;
    offset = (address & 0xFF) << 1;
    prt_coded(&page, &offset);
}

void
print1 A1(word, address)
{
    word    page;
    word    offset;

    page = address / BLOCK_SIZE;
    offset = address % BLOCK_SIZE;
    prt_coded(&page, &offset);
}

void
p_obj A1(word, obj_num)
{
    object_t    *obj;
    word        address;
    word        page;
    word        offset;

    obj = obj_addr(obj_num);
    address = Z_TO_WORD(obj->data);
    page = address / BLOCK_SIZE;
    offset = address % BLOCK_SIZE;

    /*
     * The first byte at the address is the length of the data: if
     * it's 0 then there's nothing to print, so don't.
     */
    if (get_byte(&page, &offset) > 0)
    {
        prt_coded(&page, &offset);
    }
}

void
wrt()
{
    extern word     pc_page;
    extern word     pc_offset;

    prt_coded(&pc_page, &pc_offset);
    fix_pc();
}

void
writeln()
{
    wrt();
    new_line();
    rtn(1);
}

void
new_line()
{
    extern print_buf_t  *pbf_p;

    pbf_p->buf[pbf_p->len] = '\0';
    scr_putline((char *)pbf_p->buf);
    pbf_p->len = 0;
}

const char *
chop_buf A2(const char *, buf, int, max)
{
    const char *ptr;
    int len;

    /*
     * Find the current length; if it's <= max already then we're done.
     */
    if ((len = strlen(buf)) <= max)
        return (&buf[len]);

    /*
     * Find the last space at or before buf[max]
     */
    for (ptr = &buf[max]; (*ptr != ' ') && (ptr > buf); --ptr)
    {}

    /*
     * If the word takes up the whole line then search forward for the
     * next space (it won't fit, but if they're asking for such a small
     * width as to give 1 word per line, whaddaya gonna do?)
     */
    if (ptr == buf)
        for (ptr = &buf[max+1]; (*ptr != ' ') && (*ptr != '\0'); ++ptr)
        {}

    return (ptr);
}

void
print_char A1(word, ch)
{
    extern print_buf_t *pbf_p;

    /*
     * If we're at the end of the buffer then get some more memory...
     */
    if (pbf_p->len == pbf_p->max)
    {
        pbf_p->max += BUFMIN;
        pbf_p->buf = (byte *)xrealloc(pbf_p->buf, pbf_p->max + 1);
    }

    pbf_p->buf[pbf_p->len++] = (byte)ch;
}

void
prt_coded A2(word*, page, word*, offset)
{
    word    data;

    /*
     * Print mode = < 0 :   Common Word;
     *              = 0 :   Lower Case Letter;
     *              = 1 :   Upper Case Letter;
     *              = 2 :   Number or Symbol;
     *              = 3 :   ASCII Letter - first byte;
     *              > 3 :   ASCII Letter - second byte;
     */
    print_mode = 0;
    single_mode = 0;

    /* Last word has high bit set */
    do
    {
        data = get_word(page, offset);
        decode(data);
    }
    while ((data & 0x8000) == 0);
}

static void
letter A1(char, ch)
{
    extern char     table[];

    if (ch == 0)
    {
        print_char((word)' ');
        single_mode = print_mode;
        return;
    }

    if (ch <= 3)
    {
        /* Set single_mode to "Common Word" & set word_bank */

        single_mode |= 0x80;
        word_bank = (ch - 1) << 6;
        return;
    }

    if ((ch == 4) || (ch == 5))
    {
        /* Switch printing modes */

        if (single_mode == 0)
            single_mode = ch - 3;
        else
        {
            if (single_mode == ch - 3)
                single_mode = 0;
            print_mode = single_mode;
        }
        return;
    }

    if ((ch == 6) && (single_mode == 2))
    {
        /* Increment printing mode to 3 - ASCII Letter. */

        ++single_mode;
        return;
    }

    if ((ch == 7) && (single_mode == 2))
    {
        /* Print a Carriage Return */

        new_line();
        single_mode = print_mode;
        return;
    }

    /* None of the above, so this must be a single character */

    print_char((word)table[(single_mode * 26) + ch - 6]);
    single_mode = print_mode;
}

void
decode A1(word, data)
{
    extern byte     *common_word_ptr;

    word            page;
    word            offset;
    word            code;
    int             i;
    byte            *ptr;
    char            ch[3];

    /* Reduce word to 3 characters of 5 bits */

    code = data;
    for (i = 0; i <= 2; i++)
    {
        ch[i] = code & 0x1F;
        code >>= 5;
    }

    /* Print each character */

    for (i = 2; i >= 0; i--)
    {
        if (single_mode & 0x80)
        {
            /* Print a Special Word */

            ptr = common_word_ptr + word_bank + (int)(ch[i] << 1);
            page = Z_TO_BYTE_I(ptr);
            offset = Z_TO_BYTE(ptr) << 1;
            prt_coded(&page, &offset);
            single_mode = print_mode;
            continue;
        }
        if (single_mode < 3)
        {
            /* Print a single character */

            letter(ch[i]);
            continue;
        }
        if (single_mode == 3)
        {
            /*
             * Print ASCII character - store the high 3 bits of
             * char in the low 3 bits of the current printing mode.
             */

            single_mode = 0x40 + ch[i];
            continue;
        }
        if (single_mode & 0x40)
        {
            /*
             * Print an ASCII character - consists of the current
             * character as the low 5 bits and the high 3 bits coming
             * from the low 3 bits of the current printing mode.
             */

            ch[i] += (single_mode & 0x03) << 5;
            print_char((word)ch[i]);
            single_mode = print_mode;
        }
    }
}

void
set_score()
{
    static const char *mv_str=NULL, *mv_alt=NULL;
    extern print_buf_t  *pbf_p;

    /*
     * Set the description
     */
    pbf_p = &room;
    room.len = 1;
    p_obj(load_var(0x10));
    room.buf[room.len] = '\0';
    pbf_p = &text;

    /*
     * Fill in the score or time fields...
     */
    if (F1_IS_SET(B_USE_TIME))
    {
        word    hour;
        char    ch;

        hour = load_var(0x11);

        /* Convert 24 hour time to AM/PM */

        ch = 'A';
        if (hour >= 12)
        {
            hour -= 12;
            ch = 'P';
        }
        if (hour == 0)
            hour = 12;

        sprintf(score_buf, "Time: %2hu:%02hu %cM ", hour, load_var(0x12), ch);
    }
    else
    {
        short int moves;

        moves = (short int)load_var(0x12);

        if (mv_str == NULL)
            if (moves > MAX_MOVES)
            {
                mv_str = "GST";
                mv_alt = "T";
            }
            else
            {
                mv_str = "Moves";
                mv_alt = "M";
            }

        if ((text.max < 0) || (text.max > LONG_SCORE_WIDTH))
            sprintf(score_buf, "Score: %-3hd  %s: %-4hd ",
                    (short int)load_var(0x11), mv_str, moves);
        else
            sprintf(score_buf, "S: %-3hd  %s: %-4hd ",
                    (short int)load_var(0x11), mv_alt, moves);
    }
}
