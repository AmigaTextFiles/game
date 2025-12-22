/* support.c
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
 * $Header: /usr/opt/contrib/infocom/info/RCS/support.c,v 3.0 1992/10/21 16:56:19 pds Stab pds $
 */

#include <stdio.h>
#include <ctype.h>
#ifndef NO_SIGNALS
#include <signal.h>
#endif

#include "infocom.h"
#include "patchlevel.h"

ptr_t
xmalloc A1(unsigned int, len)
{
#ifndef malloc
    extern ptr_t malloc();
#endif
    ptr_t p;

    if ((p = malloc(len)) == NULL)
    {
        extern void exit P((int));

        fprintf(stderr, "xmalloc(%ud): Out of memory!\n", len);
        exit(1);
    }

    return (p);
}

ptr_t
xrealloc A2(ptr_t, p, unsigned int, len)
{
#ifndef realloc
    extern ptr_t realloc();
#endif

    if ((p = realloc(p, len)) == NULL)
    {
        extern void exit P((int));

        fprintf(stderr, "xrealloc(%ud): Out of memory!\n", len);
        exit(1);
    }

    return (p);
}

void
null()
{
    /* The NULL function */
}

void
change_status()
{
    extern header_t     data_head;
    extern print_buf_t  *pbf_p;
    extern word         save_blocks;
    extern word         pc_page;
    extern word         pc_offset;
    extern word         *stack_base;
    extern word         *stack_var_ptr;
    extern word         *stack;
    extern byte         *base_ptr;

    if (gflags.game_state == RESTART_GAME)
        load_page(0, save_blocks, base_ptr);

    stack_var_ptr = stack_base;
    stack = --stack_var_ptr;

    pbf_p->len = 0;

    /*
     * OK, now *this* is an inane C compiler bug: Aztec C owners, rise
     * up and complain!  The Aztec C compiler doesn't properly
     * interpret the operation:
     *          foo = bar % 0x200
     * if both foo and bar are short unsigned int (16 bits) and bar
     * has a value with the high bit set (i.e., 0x8000 or more).
     *
     * To work around it, we store the short unsigned into a long
     * int and perform the operation like that.  What a pain.
     */
#ifdef AZTEC_C_BUG
    {
        long_word offset;

        pc_page = offset = data_head.game_o / BLOCK_SIZE;
        pc_offset = offset = data_head.game_o % BLOCK_SIZE;
    }
#else
    pc_page = data_head.game_o / BLOCK_SIZE;
    pc_offset = data_head.game_o % BLOCK_SIZE;
#endif
    fix_pc();

    gflags.game_state = PLAY_GAME;
}

void
restart()
{
    Bool scripting;

    scripting = F2_IS_SET(B_SCRIPTING);

    new_line();
    gflags.game_state = RESTART_GAME;
    change_status();

    if (scripting)
        F2_SETB(B_SCRIPTING);
    else
        F2_RESETB(B_SCRIPTING);
}

void
quit()
{
    extern void exit P((int));

    if (gflags.game_state == NOT_INIT)
        exit(1);

    gflags.game_state = QUIT_GAME;
    scr_putline("");
    close_file();
}

Bool
do_verify()
{
    extern word     resident_blocks;
    extern header_t data_head;
    extern file_t   file_info;

    word            page;
    word            offset;
    word            sum;
    word            save_b;

    save_b = resident_blocks;
    resident_blocks = 0;

    page = 0;
    offset = sizeof(header_t);
    sum = 0;
    while ((page < file_info.pages) || (offset < file_info.offset))
        sum += get_byte(&page, &offset);

    resident_blocks = save_b;

    return (sum == data_head.verify_checksum);
}

void
verify()
{
    char            buf[81];

    sprintf(buf,
            "Portable Infocom Datafile Interpreter:  Version %d.%d",
            VERSION, PATCHLEVEL);
    scr_putline(buf);

    ret_value(do_verify());
}

void
store A1(word, value)
{
    extern word     *stack;

    word            var;

    NEXT_BYTE(var);
    if (var == 0)
        *(--stack) = value;
    else
        put_var(var, value);
}

void
ret_value A1(word, result)
{
    extern word     pc_offset;

    word    branch;

    NEXT_BYTE(branch);

    /* Test bit 7 */
    if ((branch & 0x80) != 0)
    {
        /* Clear bit 7 */
        branch &= 0x7F;
        ++result;
    }

    /* Test bit 6 */
    if ((branch & 0x40) == 0)
    {
        byte b;

        NEXT_BYTE(b);
        branch = (branch << 8) + b;
        /* Test bit D. If set, make branch negative. */
        if (branch & 0x2000)
            branch |= 0xC000;
    }
    else
        /* Clear bit 6 */
        branch &= 0xBF;

    if ((--result) != 0)
    {
        switch (branch)
        {
            case 0 :    rtn(0);
                        break;
            case 1 :    rtn(1);
                        break;
            default :   pc_offset += (branch - 2);
                        fix_pc();
        }
    }
}

byte
get_byte A2(word*, page, word*, offset)
{
    extern word     resident_blocks;
    extern byte     *base_ptr;

    byte            *ptr;

    if (*page < resident_blocks)
        ptr = base_ptr + ((long_word)*page * BLOCK_SIZE) + *offset;
    else
        ptr = fetch_page(*page) + *offset;

    ++(*offset);
    if (*offset == BLOCK_SIZE)
    {
        *offset = 0;
        ++(*page);
    }

    return (Z_TO_BYTE(ptr));
}

word
get_word A2(word*, page, word*, offset)
{
    word    temp;

    temp = get_byte(page, offset) << 8;
    return ((word)(temp + get_byte(page, offset)));
}

word
next_word()
{
    word    temp;
    byte    b;

    NEXT_BYTE(b);
    temp = b << 8;
    NEXT_BYTE(b);
    return ((word)(temp + b));
}

void
error A2(const char *, buffer, int, value)
{
    char    buf[81];

    sprintf(buf, buffer, value);
    scr_putmesg(buf, 1);
    quit();
}

void
askq A1(int, sig)
{
    char    cmd[256];

    scr_getline( "\nDo you really want to quit (y/n) [n] ? ",
                 256,
                 cmd );

    if ((*cmd == 'Y') || (*cmd == 'y'))
    {
        extern void exit P((int));

        quit();
        scr_end();
        exit(0);
    }

    setbuf(stdin, NULL);
#ifndef NO_SIGNALS
    signal(SIGINT, askq);
#endif
}
