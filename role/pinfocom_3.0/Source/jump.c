/* jump.c
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
 * $Header: RCS/jump.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include    "infocom.h"

void
gosub A2(word, num, const word *, param)
{
    extern word     pc_offset;
    extern word     pc_page;
    extern word     *stack_base;
    extern word     *stack_var_ptr;
    extern word     *stack;

    /*
     * The first param is the address to gosub to
     */
    if (param[0] == 0)
        store(param[0]);
    else
    {
        const word *pp;
        byte vars;

        *(--stack) = pc_page;
        *(--stack) = pc_offset;

        /* Push offset of old stack_var_ptr from stack_base onto stack */

        *(--stack) = stack_base - stack_var_ptr;

        pc_page = param[0] >> 8;
        pc_offset = (param[0] & 0xFF) << 1;
        fix_pc();

        /*
            The value of the current stack pointer is the
            new value of stack_var_ptr.
        */

        stack_var_ptr = stack;
        --stack_var_ptr;

        /*
         * Global variables 1 to 15 are Local variables, which
         * reside on the stack (and so are local to each procedure).
         *
         * Get number of local variables to push onto the stack.
         * param[1] through param[num-1], if defined, are the first
         * local variables. There are also bytes reserved after the
         * gosub opcode in the calling procedure to initialise all
         * local variables - including the first 3 local variables
         * (and so are ignored).
         */
        NEXT_BYTE(vars);

        for (--num, pp=&param[1]; (num > 0) && (vars > 0); ++pp, --num, --vars)
        {
            next_word();
            *(--stack) = *pp;
        }

        while (vars-- > 0)
            *(--stack) = next_word();
    }
}

void
rtn A1(word, value)
{
    extern word     pc_offset;
    extern word     pc_page;
    extern word     *stack_base;
    extern word     *stack_var_ptr;
    extern word     *stack;

    stack = stack_var_ptr;
    ++stack;
    stack_var_ptr = stack_base - *stack++;
    pc_offset = *stack++;
    pc_page = *stack++;
    fix_pc();

    store(value);
}

void
jump A1(word, offset)
{
    extern word     pc_offset;

    pc_offset += offset - 2;
    fix_pc();
}

void
rts()
{
    extern word     *stack;

    rtn(*stack++);
}

void
pop_stack()
{
    extern word     *stack;

    ++stack;
}
