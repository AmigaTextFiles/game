/* input.c
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
 * $Header: RCS/input.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include <string.h>
#include <errno.h>
#include <ctype.h>

#include "infocom.h"

#ifdef NEED_ERRNO
extern int errno;
#endif

static word    coded[2];

static word
convert A1(char, ch)
{
    extern char     table[];

    char            *ptr;
    word            code;

    ptr = table;
    while ((*ptr != ch) && (*ptr != 0))
        ++ptr;
    if (*ptr == 0)
        return (0);
    code = (ptr - table) + 6;
    while (code >= 0x20)
        code -= 0x1A;
    return (code);
}

static word
find_mode A1(char, ch)
{
    if (ch == 0)
        return (3);
    if ((ch >= 'a') && (ch <= 'z'))
        return (0);
    if ((ch >= 'A') && (ch <= 'Z'))
        return (1);
    return (2);
}

static void
encode A1(byte*, the_word)
{
    word    data[6];
    word    mode;
    word    offset;
    byte    *ptr;
    byte    ch;
    int     count;

    count = 0;
    ptr = the_word;
    while (count < 6)
    {
        ch = *ptr++;
        if (ch == 0)
        {
            /* Finished, so fill with blanks */

            while (count < 6)
                data[count++] = 5;
        }
        else
        {
            /* Get Character Print-Mode */

            mode = find_mode(ch);
            if (mode != 0)
                data[count++] = mode + 3;

            /* Get offset of character in Table[] */

            if (count < 6)
            {
                offset = convert(ch);
                if (offset == 0)
                {
                    /* Character not in Table[], so use ASCII */

                    data[count++] = 6;
                    if (count < 6)
                        data[count++] = ch >> 5;
                    if (count < 6)
                        data[count++] = ch & 0x1F;
                }
                else
                    data[count++] = offset;
            }
        }
    }

    /* Encrypt */

    coded[0] = (data[0] << 10) | (data[1] << 5) | data[2];
    coded[1] = (data[3] << 10) | (data[4] << 5) | data[5];
    coded[1] |= 0x8000;
}

void
ti_escape A1(char *, cmd)
{
    char *cp;
    int val = -1;

    /*
     * If no arg was given, print the possibilities
     */
    if (*cmd == '\0')
    {
        char buf[81];

        scr_putline("Interpreter command list:");
        scr_putline("");

        F2_SETB(B_FIXED_FONT);

        sprintf(buf, "  atest:  %s  Attribute test display",
                gflags.pr_atest ? "[on] " : "[off]");
        scr_putline(buf);

        sprintf(buf, "  attr:   %s  Attribute assignment display",
                gflags.pr_attr ? "[on] " : "[off]");
        scr_putline(buf);

        sprintf(buf, "  echo:   %s  Input line echoing",
                gflags.echo ? "[on] " : "[off]");
        scr_putline(buf);

        sprintf(buf, "  pager:  %s  Output paging",
                gflags.paged ? "[on] " : "[off]");
        scr_putline(buf);

        sprintf(buf, "  prompt: %s  Alternate prompt flag",
                F1_IS_SET(B_ALT_PROMPT) ? "[on] " : "[off]");
        scr_putline(buf);

        sprintf(buf, "  status: %s  Status line display",
                gflags.pr_status ? "[on] " : "[off]");
        scr_putline(buf);

        sprintf(buf, "  tandy:  %s  Tandy license flag",
                F1_IS_SET(B_TANDY) ? "[on] " : "[off]");
        scr_putline(buf);

        sprintf(buf, "  xfers:  %s  Object transfer display",
                gflags.pr_xfers ? "[on] " : "[off]");
        scr_putline(buf);

        F2_RESETB(B_FIXED_FONT);
        scr_putline("");

        return;
    }

    /*
     * Lowercase the command and find the end of it (it might have
     * arguments: none do currently but...).
     */
    for (cp=cmd; isalpha(*cp); ++cp)
        *cp = isupper(*cp) ? tolower(*cp) : *cp;
    *(cp++) = '\0';

    if (!strcmp(cmd, "tandy"))
    {
        cp = "tandy";
        if (F1_IS_SET(B_TANDY))
        {
            F1_RESETB(B_TANDY);
            val = 0;
        }
        else
        {
            F1_SETB(B_TANDY);
            val = 1;
        }
    }
    else if (!strcmp(cmd, "prompt"))
    {
        cp = "prompt";
        if (F1_IS_SET(B_ALT_PROMPT))
        {
            F1_RESETB(B_ALT_PROMPT);
            val = 0;
        }
        else
        {
            F1_SETB(B_ALT_PROMPT);
            val = 1;
        }
    }
    else if (!strcmp(cmd, "status"))
    {
        cp = "status";
        val = gflags.pr_status = !gflags.pr_status;
    }
    else if (!strcmp(cmd, "pager"))
    {
        cp = "pager";
        val = gflags.paged = !gflags.paged;
    }
    else if (!strcmp(cmd, "echo"))
    {
        cp = "echo";
        val = gflags.echo = !gflags.echo;
    }
    else if (!strcmp(cmd, "attr"))
    {
        cp = "attr";
        val = gflags.pr_attr = !gflags.pr_attr;
    }
    else if (!strcmp(cmd, "atest"))
    {
        cp = "atest";
        val = gflags.pr_atest = !gflags.pr_atest;
    }
    else if (!strcmp(cmd, "xfers"))
    {
        cp = "xfers";
        val = gflags.pr_xfers = !gflags.pr_xfers;
    }
    else
    {
        char buf[81];

        sprintf(buf, "Invalid interpreter command: `%s'", cmd);
        scr_putmesg(buf, 1);
    }

    if (val >= 0)
    {
        char buf[80];

        sprintf(buf, "[%s := %s]", cp, val ? "ON" : "OFF");
        scr_putline(buf);
        scr_putline("");
    }
}

static byte
*read_line A2(byte*, prompt, byte*, buffer)
{
    extern char script_fn[];

    static FILE *sfp = NULL;
    char *cp;

    set_score();

    if ((sfp != NULL) && !F2_IS_SET(B_SCRIPTING))
    {
        scr_close_sf(script_fn, sfp, SF_SCRIPT);
        sfp = NULL;
    }

 retry:
    cp = (char *)&buffer[1];
    scr_getline((char *)prompt, *buffer, cp);

    /*
     * If we're echoing, print the command.
     */
    if (gflags.echo)
        scr_putline(cp);

    /*
     * Lowercase all the input, then return a ptr to the end of the
     * buffer.  ANSI C tolower() accepts non-uppercase chars and does
     * the right thing, but not everyone does...
     */
    for (; *cp != '\0'; ++cp)
        *cp = isupper((int)*cp) ? tolower((int)*cp) : *cp;

    /*
     * If we're not already scripting and the command is not "script"
     * we're done.  Otherwise call scr_open_sf().  If it succeeds,
     * we're done.  If not, print a failure and get a new command
     */
    if (sfp == NULL)
    {
        extern word vocab_entry_size;
        const char *pp;

        pp = (char *)&buffer[1];
        if (!strncmp(pp, "script", 6))
        {
            pp += 6;

            /*
             * In v3 games chuck any chars after 6: i.e., the user
             * could type "scriptydoo" and the interpreter would see
             * just "script".
             */
            if (vocab_entry_size <= 7)
                while ((*pp != '\0') && !isspace(*pp))
                    ++pp;
            /*
             * Skip any ending whitespace
             */
            while ((*pp != '\0') && isspace(*pp))
                ++pp;

            if ((*pp == '\0')
                && ((sfp = scr_open_sf( MAXPATHLEN+1,
                                        script_fn,
                                        SF_SCRIPT )) == NULL))
            {
                if (errno != 0)
                    f_error(errno, "Cannot open script file `%s'", script_fn);
                scr_putline("Failed.");
                scr_putline("");
                goto retry;
            }
        }
    }

    return ((byte *)cp);
}

static void
look_up A2(byte*, the_word, byte*, word_ptr)
{
    extern word     num_vocab_words;
    extern word     vocab_entry_size;
    extern byte     *base_ptr;
    extern byte     *strt_vocab_table;
    extern byte     *end_vocab_table;

    byte    *vocab_strt;
    byte    *v_ptr;
    word    first;
    word    second;
    word    shift;
    word    chop;
    word    offset;
    Bool    found;

    encode(the_word);
    shift = num_vocab_words;
    chop = vocab_entry_size;
    shift >>= 1;
    do
    {
        chop <<= 1;
        shift >>= 1;
    }
    while (shift != 0);
    vocab_strt = strt_vocab_table + chop - vocab_entry_size;

    found = 0;
    do
    {
        chop >>= 1;
        v_ptr = vocab_strt;
        first = Z_TO_WORD_I(v_ptr);
        if (first == coded[0])
        {
            second = Z_TO_WORD_I(v_ptr);
            if (second == coded[1])
                found = 1;
            else
            {
                if (coded[1] > second)
                {
                    vocab_strt += chop;
                    if (vocab_strt > end_vocab_table)
                        vocab_strt = end_vocab_table;
                }
                else
                    vocab_strt -= chop;
            }
        }
        else
        {
            if (coded[0] > first)
            {
                vocab_strt += chop;
                if (vocab_strt > end_vocab_table)
                    vocab_strt = end_vocab_table;
            }
            else
                vocab_strt -= chop;
        }
    }
    while ((chop >= vocab_entry_size) && (!found));

    if (!found)
        offset = 0;
    else
        offset = vocab_strt - base_ptr;

    *(word_ptr + 1) = (byte)offset;
    *word_ptr = (byte)(offset >> 8);
}

static void
parse A3(byte*, inb_strt, byte*, inb_end, byte*, word_buff_strt)
{
    extern byte     *wsbf_strt;
    extern byte     *end_of_sentence;

    byte    *last_word;
    byte    *word_ptr;
    byte    *char_ptr;
    byte    *ws;
    byte    the_word[8];
    byte    word_count;
    byte    ch;
    int     i;
    Bool    white_space;

    word_count = 0;
    char_ptr = inb_strt + 1;
    word_ptr = word_buff_strt + 2;

    i = 0;
    while ((char_ptr != inb_end) || (i != 0))
    {
        i = 0;
        last_word = char_ptr;
        white_space = 0;
        while ((char_ptr != inb_end) && (!white_space))
        {
            ch = *char_ptr++;
            ws = wsbf_strt;
            while ((*ws != ch) && (*ws != '\0'))
                ++ws;
            if (*ws == ch)
            {
                white_space = 1;
                if (i != 0)
                    --char_ptr;
                if ((i == 0) && (ws < end_of_sentence))
                    the_word[i++] = ch;
            }
            else
            {
                if (i < 6)
                    the_word[i++] = ch;
            }
        }

        if (i != 0)
        {

            /* First byte of buffer contains the buffer length */

            if (word_count == *word_buff_strt)
            {
                scr_putline("Too many words typed. Flushing: ");
                *inb_end = 0;
                scr_putline((char *)last_word);
                *inb_end = 0;

                new_line();
                *(word_buff_strt + 1) = *word_buff_strt;
                return;
            }
            else
            {
                ++word_count;
                *(word_ptr + 2) = (byte)(char_ptr - last_word);
                *(word_ptr + 3) = (byte)(last_word - inb_strt);
                the_word[i] = 0;
                look_up(the_word, word_ptr);
                word_ptr += 4;
            }
        }
    }

    word_buff_strt[1] = word_count;
}

void
input A2(word, char_offset, word, word_offset)
{
    extern print_buf_t  *pbf_p;
    extern byte         *base_ptr;

    byte *inb_strt;
    byte *inb_end;

    /*
     * Get an input line and parse it
     */
    pbf_p->buf[pbf_p->len] = '\0';

    inb_strt = base_ptr + char_offset;
    inb_end = read_line(pbf_p->buf, inb_strt);
    parse(inb_strt, inb_end, base_ptr + word_offset);

    pbf_p->len = 0;
}
