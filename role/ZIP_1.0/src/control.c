/*
 * control.c
 *
 * Functions that alter the flow of control.
 *
 * Mark Howell 28-Jul-1992 V1.0
 *
 */

#include "ztypes.h"

/*
 * call
 *
 * Call a subroutine. Save PC and FP then load new PC and initialise stack based
 * local arguments.
 *
 */

#ifdef __STDC__
void call (int argc, zword_t *argv)
#else
void call (argc, argv)
int argc;
zword_t *argv;
#endif
{
    zword_t arg;
    int i = 1, args;

    /* Convert calls to 0 as returning FALSE */

    if (argv[0] == 0) {
        store_operand (FALSE);
        return;
    }

    /* Save current PC and FP on stack */

    stack[--sp] = (zword_t) (pc / PAGE_SIZE);
    stack[--sp] = (zword_t) (pc % PAGE_SIZE);
    stack[--sp] = fp;

    /* Create FP for new subroutine and load new PC */

    fp = sp - 1;
    pc = (unsigned long) argv[0] * story_scaler;

    /* Read argument count and initialise local variables */

    args = (unsigned int) read_code_byte ();
    while (--args >= 0) {
        arg = read_code_word ();
        stack[--sp] = (--argc > 0) ? argv[i++] : arg;
    }

}/* call */

/*
 * ret
 *
 * Return from subroutine. Restore FP and PC from stack.
 *
 */

#ifdef __STDC__
void ret (zword_t value)
#else
void ret (value)
zword_t value;
#endif
{

    /* Clean stack */

    sp = fp + 1;

    /* Restore FP and PC */

    fp = stack[sp++];
    pc = stack[sp++];
    pc += (unsigned long) stack[sp++] * PAGE_SIZE;

    /* Return subroutine value */

    store_operand (value);

}/* ret */

/*
 * jump
 *
 * Unconditional jump. Jump is PC relative.
 *
 */

#ifdef __STDC__
void jump (zword_t offset)
#else
void jump (offset)
zword_t offset;
#endif
{

    pc = (unsigned long) (pc + (short) offset - 2);

}/* jump */

/*
 * pop_ret
 *
 * Pop value from stack and return from subroutine with value.
 *
 */

#ifdef __STDC__
void pop_ret (void)
#else
void pop_ret ()
#endif
{

    ret (stack[sp++]);

}

/*
 * pop
 *
 * Pop stack and ignore value
 *
 */

#ifdef __STDC__
void pop (void)
#else
void pop ()
#endif
{

    sp++;

}/* pop */

/*
 * restart
 *
 * Restart game by initialising environment and reloading start PC.
 *
 */

#ifdef __STDC__
void restart (void)
#else
void restart ()
#endif
{
    unsigned int restart_size, i, scripting;

    /* Write any text in output buffer, restart the screen and randomise */

    flush_buffer (TRUE);
    restart_screen ();
    srand ((unsigned int) time (NULL));

    /* Initialise global state variables */

    lines_written = 0;
    status_active = OFF;
    status_size = 0;
    window = TEXT_WINDOW;

    /* Load state of scripting flag */

    scripting = get_word (H_FLAGS) & SCRIPTING_FLAG;

    /* Load restart size and reload writeable data area */

    restart_size = (h_restart_size / PAGE_SIZE) + 1;
    for (i = 0; i < restart_size; i++)
        read_page (i, &datap[i * PAGE_SIZE]);

    /* Reset game header varibles */

    if (h_type == V3)
        set_byte (H_CONFIG, (get_byte (H_CONFIG) | 0x20));
    else
        set_byte (H_CONFIG, 0x3f); /* Turn on all flags */
    set_word (H_FLAGS, scripting);
    set_byte (H_INTERPRETER, 12);
    set_byte (H_INTERPRETER_VERSION, 'A');
    set_byte (H_SCREEN_ROWS, screen_rows);
    set_byte (H_SCREEN_COLUMNS, screen_cols);

    /* Initialise status region */

    if (h_type == V3) {
        set_status_size (1);
        blank_status_line ();
    }

    /* Load start PC, SP and FP */

    pc = h_start_pc;
    sp = STACK_SIZE;
    fp = STACK_SIZE - 1;

}/* restart */
