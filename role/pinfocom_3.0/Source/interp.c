/* interp.c
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
 * $Header: RCS/interp.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include <stdio.h>
#ifndef NO_SIGNALS
#include <signal.h>
#endif

#include "infocom.h"


static void
execute A3(word, opcode, word, num, word *, param)
{
    switch (opcode)
    {
        case 0x01 : compare(num, param);
                    break;
        case 0x02 : LTE(param[0], param[1]);
                    break;
        case 0x03 : GTE(param[0], param[1]);
                    break;
        case 0x04 : dec_chk(param[0], param[1]);
                    break;
        case 0x05 : inc_chk(param[0], param[1]);
                    break;
        case 0x06 : check_loc(param[0], param[1]);
                    break;
        case 0x07 : bit(param[0], param[1]);
                    break;
        case 0x08 : or(param[0], param[1]);
                    break;
        case 0x09 : and(param[0], param[1]);
                    break;
        case 0x0a : test_attr(param[0], param[1]);
                    break;
        case 0x0b : set_attr(param[0], param[1]);
                    break;
        case 0x0c : clr_attr(param[0], param[1]);
                    break;
        case 0x0d : put_var(param[0], param[1]);
                    break;
        case 0x0e : transfer(param[0], param[1]);
                    break;
        case 0x0f : load_word_array(param[0], param[1]);
                    break;
        case 0x10 : load_byte_array(param[0], param[1]);
                    break;
        case 0x11 : get_prop(param[0], param[1]);
                    break;
        case 0x12 : get_prop_addr(param[0], param[1]);
                    break;
        case 0x13 : next_prop(param[0], param[1]);
                    break;
        case 0x14 : plus(param[0], param[1]);
                    break;
        case 0x15 : minus(param[0], param[1]);
                    break;
        case 0x16 : multiply(param[0], param[1]);
                    break;
        case 0x17 : divide(param[0], param[1]);
                    break;
        case 0x18 : mod(param[0], param[1]);
                    break;
        /*
         * Missing opcode
         */
        case 0x20 : gosub(num, param);
                    break;
        case 0x21 : save_word_array(param[0], param[1], param[2]);
                    break;
        case 0x22 : save_byte_array(param[0], param[1], param[2]);
                    break;
        case 0x23 : put_prop(param[0], param[1], param[2]);
                    break;
        case 0x24 : input(param[0], param[1]);
                    break;
        case 0x25 : print_char(param[0]);
                    break;
        case 0x26 : print_num(param[0]);
                    break;
        case 0x27 : pi_random(param[0]);
                    break;
        case 0x28 : push(param[0]);
                    break;
        case 0x29 : pop(param[0]);
                    break;
        case 0x2a : scr_window(param[0]);
                    break;
        case 0x2b : scr_set_win(param[0]);
                    break;
        /*
         * Missing opcodes
         */
        case 0x33 : break;                  /* SET_PRINT (?) */
        case 0x34 : break;                  /* #RECORD_MODE (?) */
        case 0x35 : scr_putsound(param[0], param[1], param[2], num);
                    break;

        default: error("execute: Invalid Z-code instruction: $%02x", opcode);
    }
}

static void
oper1 A1(word, opcode)
{
    word    param1;

    param1 = load((opcode >> 4) & 0x03);
    switch (opcode & 0x0F)
    {
        case 0x00 : cp_zero(param1);
                    break;
        case 0x01 : get_link(param1);
                    break;
        case 0x02 : get_holds(param1);
                    break;
        case 0x03 : get_loc(param1);
                    break;
        case 0x04 : get_prop_len(param1);
                    break;
        case 0x05 : inc_var(param1);
                    break;
        case 0x06 : dec_var(param1);
                    break;
        case 0x07 : print1(param1);
                    break;
        /*
         * Opcode 0x08: unknown
         */
        case 0x09 : remove_obj(param1);
                    break;
        case 0x0a : p_obj(param1);
                    break;
        case 0x0b : rtn(param1);
                    break;
        case 0x0c : jump(param1);
                    break;
        case 0x0d : print2(param1);
                    break;
        case 0x0e : get_var(param1);
                    break;
        case 0x0f : not(param1);
                    break;
        default   : error("oper1: Invalid Z-code instruction: $%02x", opcode);
    }
}

static void
oper2 A1(word, opcode)
{
    word    param[2];
    int     mode;

    mode = 1 + ((opcode & 0x40) != 0);
    param[0] = load(mode);

    mode = 1 + ((opcode & 0x20) != 0);
    param[1] = load(mode);

    execute((opcode & 0x1F), 2, param);
}

static void
oper3 A1(word, opcode)
{
    word    param[4];
    word    *pp;
    word    num_params;
    byte    modes;
    int     addr_mode;
    int     i;

    NEXT_BYTE(modes);
    num_params = 0;

    for (i=6, pp=param; i >= 0; ++pp, i-=2)
    {
        addr_mode = (modes >> i) & 0x03;
        if (addr_mode == 3)
            break;

        ++num_params;
        *pp = load(addr_mode);
    }

    for (; i >= 0; ++pp, i-=2)
        *pp = 0;

    execute((opcode & 0x3F), num_params, param);
}

void
interp()
{
    word            opcode;

#ifndef NO_SIGNALS
    signal(SIGINT, askq);
#ifdef SIGQUIT
    signal(SIGQUIT, SIG_IGN);
#endif
#endif

    while (gflags.game_state != QUIT_GAME)
    {
        NEXT_BYTE(opcode);
        if (opcode < 0x80)
        {
            oper2(opcode);
            continue;
        }
        if (opcode < 0xb0)
        {
            oper1(opcode);
            continue;
        }
        if (opcode >= 0xc0)
        {
            oper3(opcode);
            continue;
        }

        switch (opcode & 0x0F)
        {
            case 0x00 : rtn(1);
                        break;
            case 0x01 : rtn(0);
                        break;
            case 0x02 : wrt();
                        break;
            case 0x03 : writeln();
                        break;
            case 0x04 : null();
                        break;
            case 0x05 : save();
                        break;
            case 0x06 : restore();
                        break;
            case 0x07 : restart();
                        break;
            case 0x08 : rts();
                        break;
            case 0x09 : pop_stack();
                        break;
            case 0x0a : quit();
                        break;
            case 0x0b : new_line();
                        break;
            case 0x0c : set_score();
                        scr_putscore();
                        break;
            case 0x0d : verify();
                        break;

            default: error("interp: Invalid Z-code instruction: $%02x",opcode);
        }
    }
}
