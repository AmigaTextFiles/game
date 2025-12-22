/* file.c
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
 * $Header: RCS/file.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>

#include "infocom.h"

#ifdef NEED_ERRNO
extern int errno;
#endif

static const char *fname_lst[] = {FNAME_LST,0};
static const char *fext_lst[] = {"",FEXT_LST,0};

static FILE *game_file;
static char gname[MAXPATHLEN + 1];

char sname[MAXPATHLEN + 1];

#ifdef SCRIPT_FILE
char script_fn[MAXPATHLEN+1] = SCRIPT_FILE;
#else
char script_fn[MAXPATHLEN+1];
#endif


void
f_error A3(int, erno, const char *, err, const char *, arg1)
{
    char buf[256];
    char *bp;

    sprintf(buf, err, arg1);
    bp = buf + strlen(buf);

    if (erno)
    {
#ifndef NO_STRERROR
        extern char *strerror P((int));
        char *cp = strerror(erno);

        sprintf(bp, ": %o: %s", erno, cp == NULL ? "<unknown>" : cp);
#else
        sprintf(bp, ": %o", erno);
#endif
    }

    if (gflags.game_state == NOT_INIT)
    {
        fputs(buf, stderr);
        putc('\n', stderr);
        putc('\n', stderr);
    }
    else
    {
        scr_putmesg(buf, 1);
    }
}

static void
assign A2(header_t*, head, const header_t*, buffer)
{
    const byte  *ptr;
    int         i;

    /*
     * Process the raw header data in "buffer" and put
     * it into the appropriate fields in "head". This
     * processing is required because of the way different
     * machines internally represent 'words'.
     */
    ptr = (const byte *)buffer;

    head->z_version       = Z_TO_BYTE_I(ptr);
    head->flags_1         = Z_TO_BYTE_I(ptr);
    head->release         = Z_TO_WORD_I(ptr);
    head->resident_bytes  = Z_TO_WORD_I(ptr);
    head->game_o          = Z_TO_WORD_I(ptr);
    head->vocab_o         = Z_TO_WORD_I(ptr);
    head->object_o        = Z_TO_WORD_I(ptr);
    head->variable_o      = Z_TO_WORD_I(ptr);
    head->save_bytes      = Z_TO_WORD_I(ptr);
    head->flags_2         = Z_TO_WORD_I(ptr);
    for (i = 0; i < 6; ++i)
        head->serial_no[i] = Z_TO_BYTE_I(ptr);
    head->common_word_o   = Z_TO_WORD_I(ptr);
    head->verify_length   = Z_TO_WORD_I(ptr);
    head->verify_checksum = Z_TO_WORD_I(ptr);
    for (i = 0; i < 8; ++i)
        head->padding1[i] = Z_TO_WORD_I(ptr);
    head->fkey_o          = Z_TO_WORD_I(ptr);
    for (i = 0; i < 2; ++i)
        head->padding2[i] = Z_TO_WORD_I(ptr);
    head->alphabet_o      = Z_TO_WORD_I(ptr);
    for (i = 0; i < 5; ++i)
        head->padding3[i] = Z_TO_WORD_I(ptr);
}

/*
 * Function:    read_header()
 *
 * Description:
 *      This function reads in the game data file's header info.  We
 *      only do this between scr_setup() and scr_begin(), so just use
 *      normal printf()'s if we find an error, and just exit if we
 *      can't continue.
 *
 * Notes:
 *      This routine does not read the data-file header directly into
 *      a header structure because certain machines like the VAX
 *      11/780 store integers in a different way to machines based on
 *      processors like the 68000 (a 68000 stores the high byte first,
 *      while a VAX stores the low byte first).  Consequently, if the
 *      header is read directly into a structure, the integer values
 *      are interpreted differently by the two machines.
 */
void
read_header A1(header_t*, head)
{
    extern void exit P((int));
    header_t  buffer;

    if (fseek(game_file, 0L, 0) < 0)
    {
        f_error(errno, "Failed to seek to beginning of file `%s'", gname);
        exit(1);
    }

    if (fread(&buffer, sizeof(header_t), 1, game_file) != 1)
    {
        f_error(errno, "Failed to read header of `%s'", gname);
        exit(1);
    }

    assign(head, &buffer);

    if (head->flags_1 & 0x01)
    {
        f_error(0, "Invalid header in file `%s'", gname);
        exit(1);
    }
}

/*
 * Open a file for reading; if the parameter is NULL then look through
 * the name,extension list pairs to try to find one there.  Return a
 * pointer to it, whatever it is.
 */
const char *
open_file A1(const char*, filename)
{
    const char *fn = gname;
    char *endp = gname;

    if (filename != NULL)
    {
        const char **exp;

        strcpy(gname, filename);
        endp = &gname[strlen(gname)];

        if ((game_file = fopen(gname, "rb")) != NULL)
        {
            int len;

            for (exp=fext_lst; *exp != NULL; ++exp)
            {
                if (((len = strlen(*exp)) != 0) && !strcmp(endp - len, *exp))
                    break;
            }

            if (*exp != NULL)
                endp -= len;

            goto done;
        }

        for (exp = fext_lst; *exp != NULL; ++exp)
        {
            strcpy(endp, *exp);
            if ((game_file = fopen(gname, "rb")) != NULL)
                goto done;
        }

        f_error(errno, "Cannot open file `%s'", filename);
        fn = NULL;
    }
    else
    {
        const char **nmp;

        for (nmp = fname_lst; *nmp != NULL; ++nmp)
        {
            const char **exp;

            strcpy(gname, *nmp);
            endp = &gname[strlen(gname)];

            for (exp = fext_lst; *exp != NULL; ++exp)
            {
                strcpy(endp, *exp);
                if ((game_file = fopen(gname, "rb")) != NULL)
                    goto done;
            }
        }

        f_error(0, "Could not find a game to play!", NULL);
        fn = NULL;
    }

 done:
    *endp = '\0';

    strcpy(sname, gname);
#ifdef SAVE_EXT
    strcat(sname, SAVE_EXT);
#endif
#ifdef SCRIPT_EXT
    sprintf(script_fn, "%s%s", gname, SCRIPT_EXT);
#endif

    return (fn);
}

void
close_file()
{
    if (fclose(game_file))
        scr_putline("Cannot Close Game File");
}

void
load_page A3(word, block, word, num_blocks, byte*, ptr)
{
    extern file_t   file_info;

    long found;
    long offset;
    long num_bytes;

    /*
     * Read "num_block" blocks from Game File, starting with block
     * "block", into the location pointed to by "ptr".
     */
    offset = (long)block * BLOCK_SIZE;
    num_bytes = (long)num_blocks * BLOCK_SIZE;

    if (fseek(game_file, offset, 0) < 0)
    {
        f_error(errno, "Failed to seek to required offset in `%s'", gname);
        quit();
    }
    else if ((found = fread(ptr, 1, num_bytes, game_file)) < num_bytes)
    {
        /*
         * Check if this is the last block: some games (notably
         * MS-DOS) don't have the full last block on the disk.  If
         * this isn't the last block, print an error.  Otherwise, zero
         * out the rest of the page.
         */
        if ((found / BLOCK_SIZE != num_blocks - 1)
            || (block + num_blocks - 1 != file_info.pages))
        {
            f_error(errno, "Failed to load required blocks in `%s'", gname);
            quit();
        }

        for (ptr += found; found < num_bytes; ++found, ++ptr)
            *ptr = '\0';
    }
}

void
save()
{
    extern byte     *base_ptr;
    extern word     save_blocks;
    extern byte     *end_res_p;
    extern word     *stack;
    extern word     *stack_base;
    extern word     *stack_var_ptr;
    extern word     pc_page;
    extern word     pc_offset;

    FILE    *fp;
    int     ret = 0;

    /*
     * We save the the program counter, the stack offset, the
     * stack_var offset, the stack itself, and finally the resident
     * impure storage.  This overwrites the lowest 8 bytes of the
     * stack; hopefully those aren't being used...
     */
    if ((fp = scr_open_sf(MAXPATHLEN+1, (char *)sname, SF_SAVE)) == NULL)
    {
        if (errno != 0)
            f_error(errno, "Cannot open save file `%s'", sname);
    }
    else
    {
        word *sp;

        sp = (word *)end_res_p;
        *(sp++) = pc_page;
        *(sp++) = pc_offset;
        *(sp++) = stack_base - stack;
        *sp     = stack_base - stack_var_ptr;

        if ((fwrite(end_res_p, sizeof(byte), STACK_SIZE, fp) != STACK_SIZE)
            || (fwrite(base_ptr, BLOCK_SIZE, save_blocks, fp) != save_blocks))
        {
            f_error(errno, "Cannot write save file `%s'", sname);
            fclose(fp);
        }
        else
        {
            scr_close_sf(sname, fp, SF_SAVE);
            ret = 1;
        }
    }

    ret_value(ret);
}

/*
 * Check to see if a restored game is the same as our current game:
 * note that everything except the serial number, verify length, and
 * verify checksum must be identical.  If they are copy over the new
 * verify length and checksum so $verify will still work...
 */
static Bool
check A1(header_t*, info)
{
#define CMP(_1,_2,_f)   ((_1)->_f == (_2)->_f)

    extern header_t   data_head;

    Bool good = 0;

    if (CMP(info, &data_head, z_version)
        && CMP(info, &data_head, release)
        && CMP(info, &data_head, resident_bytes)
        && CMP(info, &data_head, game_o)
        && CMP(info, &data_head, vocab_o)
        && CMP(info, &data_head, object_o)
        && CMP(info, &data_head, variable_o)
        && CMP(info, &data_head, save_bytes)
        && CMP(info, &data_head, common_word_o)
        && CMP(info, &data_head, fkey_o)
        && CMP(info, &data_head, alphabet_o))
    {
        data_head.flags_1 = info->flags_1;
        data_head.verify_length = info->verify_length;
        data_head.verify_checksum = info->verify_checksum;

        good = 1;
    }

    return (good);
}

void
restore()
{
    extern byte     *base_ptr;
    extern word     save_blocks;
    extern byte     *end_res_p;
    extern word     *stack;
    extern word     *stack_base;
    extern word     *stack_var_ptr;
    extern word     pc_page;
    extern word     pc_offset;

    FILE    *fp;
    int     ret = 0;
    int     len = MAXPATHLEN+1;

    errno = 0;

    /*
     * If we're restoring a game specified on the command line, print
     * a message about it...
     */
    if (gflags.game_state != PLAY_GAME)
    {
        char buf[MAXPATHLEN+30];

        sprintf(buf, "Restoring saved game `%s' ...", sname);
        if (gflags.game_state == NOT_INIT)
            puts(buf);
        else
            scr_putline(buf);
        len = 0;
    }

    /*
     * Ask the user for a saved game filename to restore and open it;
     * if that fails then print an error.
     */
    if ((fp = scr_open_sf(len, (char *)sname, SF_RESTORE)) == NULL)
    {
        if (errno != 0)
            f_error(errno, "Opening saved file ", sname);
        ret = -1 + (gflags.game_state == INIT_GAME);
    }
    /*
     * From here on we're destroying the current game data, so if the
     * restore fails here we have no choice but to restart the game
     * from scratch.  Keep the scripting bit set correctly tho...
     */
    else
    {
        Bool ok;
        Bool scripting;

        scripting = F2_IS_SET(B_SCRIPTING);

        ok = ((fread(end_res_p, sizeof(byte), STACK_SIZE, fp)==STACK_SIZE)
              && (fread(base_ptr, BLOCK_SIZE, save_blocks, fp)==save_blocks));

        if (scripting)
            F2_SETB(B_SCRIPTING);
        else
            F2_RESETB(B_SCRIPTING);

        if (!ok)
            f_error(errno, "Error reading saved game file `%s'", sname);
        else
        {
            header_t    test;

            assign(&test, (header_t *)base_ptr);
            if (!check(&test))
                f_error(0, "Invalid saved game file `%s'", sname);
            else
            {
                word        *sp;

                sp = (word *)end_res_p;
                pc_page         = *(sp++);
                pc_offset       = *(sp++);
                stack           = stack_base - *(sp++);
                stack_var_ptr   = stack_base - *sp;
                fix_pc();
                ret = 1;
            }
        }

        if (ret == 1)
            scr_close_sf(sname, fp, SF_RESTORE);
        else
            fclose(fp);
    }

    if (gflags.game_state != NOT_INIT)
    {
        if (!ret)
        {
            strcpy(sname, gflags.filenm);
#ifdef SAVE_EXT
            strcat(sname, SAVE_EXT);
#endif
            scr_putline("Restarting...");
            restart();
        }
        else
            ret_value(ret > 0);
    }
}
