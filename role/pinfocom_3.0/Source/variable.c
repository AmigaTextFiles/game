/* variable.c
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
 * $Header: RCS/variable.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include    "infocom.h"

void
get_var A1(word, var)
{
    store(load_var(var));
}

word
load_var A1(word, var)
{
    extern byte     *global_ptr;
    extern word     *stack_var_ptr;
    extern word     *stack;

    byte            *ptr;

    if (var == 0)
        return (*stack);
    else
    {
        if (var < LOCAL_VARS)
        {
            return (*(stack_var_ptr - (var - 1)));
        }
        else
        {
            ptr = global_ptr + ((var - LOCAL_VARS) << 1);
            return (Z_TO_WORD(ptr));
        }
    }
}

void
put_var A2(word, var, word, value)
{
    extern byte     *global_ptr;
    extern word     *stack_var_ptr;
    extern word     *stack;

    word            *svp;
    byte            *ptr;

    if (var == 0)
        *stack = value;
    else
    {
        if (var < LOCAL_VARS)
        {
            svp = stack_var_ptr - (var - 1);
            *svp = value;
        }
        else
        {
            ptr = global_ptr + ((var - LOCAL_VARS) << 1);
            *ptr++ = value >> 8;
            *ptr = value;
        }
    }
}

void
push A1(word, value)
{
    extern word     *stack;

    *(--stack) = value;
}

void
pop A1(word, var)
{
    extern word     *stack;

    put_var(var, *stack++);
}

void
inc_var A1(word, var)
{
    put_var(var, load_var(var) + 1);
}

void
dec_var A1(word, var)
{
    put_var(var, load_var(var) - 1);
}

void
inc_chk A2(word, var, word, threshold)
{
    word    value;

    value = load_var(var) + 1;
    put_var(var, value);
    if ((signed_word)value > (signed_word)threshold)
        ret_value(1);
    else
        ret_value(0);
}

void
dec_chk A2(word, var, word, threshold)
{
    word    value;

    value = load_var(var) - 1;
    put_var(var, value);
    if ((signed_word)value < (signed_word)threshold)
        ret_value(1);
    else
        ret_value(0);
}

word
load A1(int, mode)
{
    extern word     *stack;

    word            var;

    /*
     * Mode 0 = Immediate Word;
     * Mode 1 = Immediate Byte;
     * Mode 2 = Variable;
     */

    --mode;
    if (mode < 0)
        return (next_word());
    if (mode == 0)
    {
        byte b;

        NEXT_BYTE(b);
        return ((word)b);
    }

    NEXT_BYTE(var);

    if (var == 0)
        return (*stack++);
    else
        return (load_var(var));
}
