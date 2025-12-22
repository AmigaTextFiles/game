/* readline.c
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
 * $Header: RCS/readline.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */
#include <string.h>
#include <ctype.h>
#include <stdio.h>
#include <errno.h>
#include <readline/readline.h>
#include <readline/history.h>

#include "infocom.h"


#ifndef free
extern void free();
#endif


#define LIST_INC        5
#define HIST_VAR        "PI_HIST"
#define COMP_VAR        "PI_WORD"

#define BIND_WORD() (rl_completion_entry_function=(Function *)tcrl_generator)
#define BIND_FILE() (rl_completion_entry_function=(Function *)NULL)


extern int rl_bind_key P((int, Function *));

static char *hist_file = NULL;
static char *comp_file = NULL;
static char **wordlist;
static int wl_len;
static int wl_max;


/*
 * Function:    irl_generator()
 *
 * Arguments:
 *      text    Token to be matched against
 *      state   New word flag
 *
 * Returns:
 *      the next string in the wordlist of which text is a
 *      prefix, or NULL if the list is exhausted
 *
 * Description:
 *      This function is called repeatedly by readline's internal
 *      command completion routine to build a list of possible
 *      completions for the current input
 *
 * Notes:
 *      Readline will free the character pointer we pass back to it
 *      so it is necessary to allocate space for the match.
 */
static char *
tcrl_generator A2(char *, text, int, state)
{
    static int list_index, len;
    char *name = NULL;
    char **cpp;

    /*
     * If we're starting new then reset...
     */
    if (!state)
    {
        list_index = 0;
        len = strlen(text);
    }

    /*
     * Return the next name which partially matches from the word list.
     */
    for (cpp = &wordlist[list_index++]; *cpp != NULL; ++cpp, ++list_index)
        if (!strncmp(*cpp, text, len))
            break;

    if (*cpp != NULL)
    {
        name = (char *)xmalloc(strlen(*cpp) + 1);
        strcpy(name, *cpp);
    }

    return (name);
}

/*
 * Add a new word to the completion list.
 */
static int
tcrl_add A1(const char *, wrd)
{
    char **cpp;
    int len;
    int ret = 1;

    while (isspace(*wrd))
        ++wrd;

    if (*wrd == '\0')
    {
        scr_putmesg("You need to supply a word to @add", 1);
        return (0);
    }

    if (wl_len+1 == wl_max)
    {
        wl_max += LIST_INC;
        wordlist = (char **)xrealloc(wordlist, sizeof(char *) * wl_max);
    }

    for (cpp=wordlist; *cpp != NULL; ++cpp)
        if (!strcmp(*cpp, wrd))
            break;

    if (*cpp != NULL)
    {
        char buf[81];

        sprintf(buf, "`%s' already exists in the word list", wrd);
        scr_putmesg(buf, 0);
        ret = 0;
    }
    else
    {
        len = strlen(wrd) + 1;
        wordlist[wl_len] = xmalloc(sizeof(char) * len);
        strcpy(wordlist[wl_len++], wrd);
        wordlist[wl_len] = NULL;
    }

    return (ret);
}

/*
 * Delete a word to the completion list.
 */
static int
tcrl_delete A1(const char *, wrd)
{
    char **cpp;
    int ret = 1;

    while (isspace(*wrd))
        ++wrd;

    if (*wrd == '\0')
    {
        scr_putmesg("You need to supply a word to @del", 1);
        return (0);
    }

    for (cpp=wordlist; *cpp != NULL; ++cpp)
        if (!strcmp(*cpp, wrd))
            break;

    if (*cpp == NULL)
    {
        char buf[81];

        sprintf(buf, "`%s' not found in the word list", wrd);
        scr_putmesg(buf, 0);
        ret = 0;
    }
    else
    {
        free(*cpp);
        for (; *cpp != NULL; ++cpp)
            cpp[0] = cpp[1];
        --wl_len;
    }

    return (ret);
}

/*
 * Set the history filename
 */
static int
tcrl_hset A1(const char *, fnm)
{
    while (isspace(*fnm))
        ++fnm;

    if (*fnm == '\0')
    {
        scr_putmesg("You need to supply a filename to @hset", 1);
        return (0);
    }

    if (hist_file)
        free(hist_file);

    hist_file = xmalloc(strlen(fnm) + 1);
    strcpy(hist_file, fnm);

    return (1);
}

/*
 * Set the completion filename
 */
static int
tcrl_cset A1(const char *, fnm)
{
    while (isspace(*fnm))
        ++fnm;

    if (*fnm == '\0')
    {
        scr_putmesg("You need to supply a filename to @cset", 1);
        return (0);
    }

    if (comp_file)
        free(comp_file);

    comp_file = xmalloc(strlen(fnm) + 1);
    strcpy(comp_file, fnm);

    return (1);
}

/*
 * Pre-process command line args: just load any environment variables
 * so they'll be properly overridden by the command line.
 */
int
tcrl_cmdarg A2(int, argc, char ***, argvp)
{
    extern char *getenv P((const char *));

    const char *fnm;

    if ((fnm = getenv(HIST_VAR)) != NULL)
        tcrl_hset(fnm);

    if ((fnm = getenv(COMP_VAR)) != NULL)
        tcrl_cset(fnm);

    return (argc);
}

/*
 * Process command args
 */
void
tcrl_getopt A2(int, c, const char *, arg)
{
    switch (c)
    {
        case 'C':
            tcrl_cset(arg);
            break;

        case 'H':
            tcrl_hset(arg);
            break;
    }
}

/*
 * Set up readline items (load history file, load command completion
 * file, initialize history, etc.
 */
void
tcrl_begin()
{
    /*
     * Initialize the history and, if the user specified one, read in
     * the history file.
     */
    using_history();
    if (hist_file != NULL)
    {
        int err;

        if (((err = read_history(hist_file)) != 0) && (err != 2))
        {
            errno = err;
            perror("read_history");
            exit(1);
        }
    }

    /*
     * Initialize the word completion library.
     */
    wordlist = (char **)xmalloc(sizeof(char *) * LIST_INC);
    *wordlist = NULL;
    wl_max = LIST_INC;

    /*
     * If the user specified a completion file, open and read it
     */
    if (comp_file != NULL)
    {
        FILE *fp;

        if ((fp = fopen(comp_file, "r")) == NULL)
        {
            char buf[81];

            sprintf(buf, "Couldn't open completion file `%s'", comp_file);
            scr_putmesg(buf, 1);
        }
        else
        {
            char buf[256];

            while (fgets(buf, 256, fp) != NULL)
            {
                buf[strlen(buf)-1] = '\0';
                tcrl_add(buf);
            }
            fclose(fp);
        }
    }

    BIND_WORD();
}

/*
 * Finish up readline stuff
 */
void
tcrl_end()
{
    if (hist_file != NULL)
        write_history(hist_file);

    if (comp_file != NULL)
    {
        FILE *fp;

        if ((fp = fopen(comp_file, "w")) == NULL)
        {
            char buf[81];

            sprintf(buf, "Couldn't open completion file `%s'", comp_file);
            scr_putmesg(buf, 1);
        }
        else
        {
            char **cpp;

            for (cpp=wordlist; *cpp != NULL; ++cpp)
            {
                fputs(*cpp, fp);
                fputc('\n', fp);
            }
            fclose(fp);
        }
    }
}

/*
 * Print out any extra escape commands the user can use
 */
void
tcrl_pr_escape()
{
    char buf[81+MAXPATHLEN];

    scr_putline("  add <word>:    Add <word> to completion list");
    scr_putline("  del <word>:    Delete <word> from completion list");

    sprintf(buf, "  hset <file>:   Set history save file name [%s]",
            hist_file == NULL ? "" : hist_file);
    scr_putline(buf);

    sprintf(buf, "  cset <file>:   Set completion save file name [%s]",
            comp_file == NULL ? "" : comp_file);
    scr_putline(buf);

    scr_putline("");
}

/*
 * Read a line from readline.  Maybe add to history; maybe allow
 * history expansion, etc.
 *
 * Returns -1 if we need to re-print the prompt (history listing), or
 * # of chars read into buffer.
 */
int
scr_getstr A4( const char *, prompt,
               int, length,
               char *, buffer,
               Bool, is_filenm )
{
    char *bp = buffer;
    char *command;
    char *cp;
    int len = 0;

    if (is_filenm)
        BIND_FILE();

    /*
     * Get a line of text; if nothing is returned then return an empty
     * buffer.
     */
    if ((cp = readline(prompt)) == NULL)
    {
        *buffer = '\0';
        return (0);
    }

    /*
     * If we're getting a filename history is not allowed so simply
     * copy over the buffer.  Otherwise, perform history processing.
     */
    if (is_filenm)
    {
        BIND_WORD();
        command = cp;
        for (; *cp && (len < length-1); ++len, ++bp, ++cp)
            *bp = *cp;
        *bp = '\0';
    }
    else
    {
        /*
         * I add the command to the history even if it's an invalid
         * history expansion, because I hate the fact that bash, etc.
         * don't: if you screw up you have to retype the thing from
         * scratch!  (isn't the the whole point of history, so you
         * *don't* have to do that?)
         */
        if ((len = history_expand(cp, &command)) == -1)
        {
            printf("history: %s\n\n", command);
            add_history(cp);
            free(command);
            free(cp);
            return (-1);
        }
        free(cp);

        /*
         * If some kind of expansion was done, then print out the
         * resulting command FYI the user...
         */
        if (len)
        {
            printf("(%s)\n", command);
        }

        /*
         * Unfortunately, contrary to the documentation for history,
         * the history_expand() function leaves all backslashes which
         * escape !'s *in* the string; so if we find one we have to
         * skip it.
         */
        for (cp=command, len=0; *cp && (len < length-1); ++len, ++bp, ++cp)
        {
            *bp = *cp;
            if ((*cp == '\\') && (cp[1] == '!'))
            {
                --bp;
                --len;
            }
        }
        *bp = '\0';
    }

    /*
     * If there's more beyond the max length of our buffer,
     * throw it away...
     */
    if (*cp != '\0')
    {
        printf(" [ Input line too long.  Flushing: `%s", cp);
        scr_putline("' ]");
    }

    free(command);

    /*
     * If we got some text and we're not doing filename processing,
     * then check for a history list request and add the command into
     * history.  Also check for an escape line; if we find one process
     * it.
     */
    if (!is_filenm && len)
    {
        if ((len == 1) && (buffer[0] == '?'))
        {
            HIST_ENTRY **hist;

            if ((hist = history_list()) == NULL)
            {
                scr_putline("You have no history.");
            }
            else
            {
                int i;

                for (i=history_base; *hist != NULL; ++i, ++hist)
                {
                    printf("%5d  ", i);
                    scr_putline((*hist)->line);
                }
            }
            return (-1);
        }

        add_history(buffer);

        if ((len > 3) && (buffer[0] == ESC_CHAR[0]))
        {
            int (*fnp) P((const char *)) = NULL;
            char c;

            for (cp = &buffer[1]; (*cp != '\0') && !isspace(*cp); ++cp)
            {}

            c = *cp;
            *cp = '\0';
            if (!strcmp(&buffer[1], "add"))
                fnp = tcrl_add;
            else if (!strcmp(&buffer[1], "del"))
                fnp = tcrl_delete;
            if (!strcmp(&buffer[1], "hset"))
                fnp = tcrl_hset;
            else if (!strcmp(&buffer[1], "cset"))
                fnp = tcrl_cset;
            *cp = c;

            if (fnp != NULL)
            {
                if ((*fnp)(cp))
                    scr_putline("");

                len = -1;
            }
        }
    }

    return (len);
}
