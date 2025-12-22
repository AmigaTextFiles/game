/* options.c
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
 * $Header: RCS/options.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include <stdio.h>

#include "infocom.h"

#define Z_CODE_NUM      7

static const char *z_code_table[Z_CODE_NUM] =
{
    "Early Interpreter",
    "Early Interpreter",
    "Early Interpreter",
    "Standard Series Interpreter",
    "Plus Series Interpreter",
    "Solid Gold Interactive Fiction",
    "Graphic Interactive Fiction"
};

void
check_version()
{
    extern void exit P((int));
    extern header_t data_head;

    if (data_head.z_version > 3)
    {
        printf("ERROR: Unsupported Z-code version: %d (%s)\n",
               (int)data_head.z_version,
               (data_head.z_version < Z_CODE_NUM
                ? z_code_table[data_head.z_version]
                : "<unknown Z code version>"));
        exit(1);
    }
}

static void
verify_game()
{
    extern header_t data_head;

    if (data_head.verify_length == 0)
        printf("\nThis game does not support data verification.\n");
    else
    {
        printf("\nVerifying game data... ");
        fflush(stdout);
        if (do_verify())
            printf("successful.\n\n");
        else
            printf("FAILED!\n\n");
    }
}

static void
show_header()
{
    extern header_t data_head;
    extern file_t   file_info;

    printf("\nInfocom Data File Header\n\nZ-Code version : %d (%s)\n",
           (int)data_head.z_version,
           (data_head.z_version < Z_CODE_NUM
            ? z_code_table[data_head.z_version]
            : "<unknown Z code version>"));
    printf("Release number : %hu\n", data_head.release & 0x7ff);
    printf("Serial number  : %.6s\n\n", data_head.serial_no);

    printf("Score/Time     : %s\n", F1_IS_SET(B_USE_TIME) ? "Time" : "Score");
    printf("Tandy License  : %s\n", F1_IS_SET(B_TANDY) ? "On" : "Off");
    printf("Alt. Prompt    : %s\n", F1_IS_SET(B_ALT_PROMPT) ? "On" : "Off");
    printf("Script status  : %s\n", F2_IS_SET(B_SCRIPTING) ? "On" : "Off");
    printf("Has sound      : %s\n\n", F2_IS_SET(B_SOUND) ? "Yes" : "No");

    printf("Resident bytes : $%04hx\n", data_head.resident_bytes);
    printf("Save bytes     : $%04hx\n", data_head.save_bytes);
    printf("Common words   : $%04hx\n", data_head.common_word_o);
    printf("Object offset  : $%04hx\n", data_head.object_o);
    printf("Variable offset: $%04hx\n", data_head.variable_o);
    printf("Vocab offset   : $%04hx\n", data_head.vocab_o);
    printf("Start offset   : $%04hx\n", data_head.game_o);
    printf("Alphabet offset: $%04hx\n", data_head.alphabet_o);
    printf("Fkey offset    : $%04hx\n\n", data_head.fkey_o);

    printf("Game length    : ");
    if (data_head.verify_length == 0)
        printf("<unknown>\n");
    else
        printf("%ld\n",
               ((long)file_info.pages*BLOCK_SIZE) + (long)file_info.offset);
    printf("Verify length  : $%04hx\n", data_head.verify_length);
    printf("Verify check   : $%04hx\n\n", data_head.verify_checksum);
}

static void
wrt_buffer()
{
    extern print_buf_t  *pbf_p;

    pbf_p->buf[pbf_p->len] = '\0';
    puts((char *)pbf_p->buf);
    pbf_p->len = 0;
}

static int
prt_max_coded A3(int, max, word*, page, word*, offset)
{
    extern int  print_mode;
    extern int  single_mode;
    word        data=0;

    print_mode = 0;
    single_mode = 0;

    for (; max > 0; --max)
    {
        data = get_word(page, offset);
        decode(data);
    }

    return (data & 0x8000);
}

static void
show_vocab()
{
    extern print_buf_t  *pbf_p;
    extern word         num_vocab_words;
    extern word         vocab_entry_size;
    extern byte         *wsbf_strt;
    extern byte         *end_of_sentence;
    extern byte         *strt_vocab_table;
    extern byte         *base_ptr;

    byte    *ptr;
    word    page;
    word    offset;
    int     count;
    int     words_per_word;
    int     word_width;
    int     wpl;                    /* words per line */

    printf("\nInfocom Adventure - Vocabulary List\n\nNumber of words: %hd\n\n",
           num_vocab_words);

    fputs("End-of-sentence punctuation: ", stdout);
    for (ptr = wsbf_strt; ptr < end_of_sentence; ++ptr)
    {
        putchar(*ptr);
        putchar(' ');
    }
    putchar('\n');
    putchar('\n');

    words_per_word = vocab_entry_size <= 7 ? 2 : 3;
    word_width = (words_per_word * 3) + 2;
    wpl = pbf_p->max / word_width;

    ptr = strt_vocab_table;
    pbf_p->buf[0] = ' ';
    pbf_p->len = 1;

    for (count = 1; count <= (int)num_vocab_words; ++count)
    {
        int ws;

        page = (ptr - base_ptr) / BLOCK_SIZE;
        offset = (ptr - base_ptr) % BLOCK_SIZE;
        ptr += vocab_entry_size;
        ws = pbf_p->len;

        /*
         * Some data files have bogus vocabulary words in them which
         * don't have the "end-word" bit set properly, so they can't
         * be used in the game: mark these with "[]"...
         */
        if (!prt_max_coded(words_per_word, &page, &offset))
        {
            pbf_p->buf[ws-1] = '[';
            pbf_p->buf[pbf_p->len++] = ']';
        }

        for (; pbf_p->len < ws+word_width; ++pbf_p->len)
            pbf_p->buf[pbf_p->len] = ' ';

        if ((count % wpl) == 0)
        {
            wrt_buffer();
            pbf_p->buf[0] = ' ';
            pbf_p->len = 1;
        }
    }
    if (pbf_p->len > 1)
    {
        wrt_buffer();
    }
    putchar('\n');
}

static void
show_objects()
{
    extern print_buf_t  *pbf_p;
    extern byte         *base_ptr;

    word            page;
    word            offset;
    byte            *obj;
    int             i=1, j;
    int             address;
    int             parent;
    int             sibling;
    int             child;
    int             n_objs;
    int             aw;

    puts("\nInfocom Adventure - Object List\n");

    pbf_p->len = 0;
    obj = (byte *)obj_addr(i);

    n_objs = (objd.is_eobj
              ? Z_TO_WORD(((eobject_t *)obj)->data)
              : Z_TO_WORD(((object_t *)obj)->data));
    n_objs = (n_objs - (obj - base_ptr)) / objd.obj_size;

    printf("Number of objects: %d\n\n", n_objs);

    aw = 4 + (objd.is_eobj * 2);
    do
    {
        Bool first;

        printf("Object %s : ", print_hnum(i));

        if (objd.is_eobj)
        {
            address = Z_TO_WORD(((eobject_t *)obj)->data);
            parent  = Z_TO_WORD(((eobject_t *)obj)->parent);
            sibling = Z_TO_WORD(((eobject_t *)obj)->sibling);
            child   = Z_TO_WORD(((eobject_t *)obj)->child);
        }
        else
        {
            address = Z_TO_WORD(((object_t *)obj)->data);
            parent  = ((object_t *)obj)->parent;
            sibling = ((object_t *)obj)->sibling;
            child   = ((object_t *)obj)->child;
        }

        page = address / BLOCK_SIZE;
        offset = address % BLOCK_SIZE;
        if (get_byte(&page, &offset) > 0)
            prt_coded(&page, &offset);
        wrt_buffer();

        fputs("    -> attributes : (", stdout);
        first = 1;
        for (j = 0; j < aw*8;)
        {
            int k;

            for (k = 0x80; k; k>>=1, ++j)
                if (obj[j/8] & k)
                    printf(first ? (first=0, "%d") : ",%d", j);
        }

        printf(")\n    -> parent     : %s\n", print_hnum(parent));
        printf("    -> sibling    : %s\n", print_hnum(sibling));
        printf("    -> child      : %s\n", print_hnum(child));

        obj = (byte *)obj_addr(++i);
    }
    while (i <= n_objs);

    putchar('\n');
}

static void
obtree A2(word, a, int, b)
{
    byte    *obj;
    word    address;
    word    child;
    word    sibling;
    word    page;
    word    offset;
    int     c;

    for (c = b*4; c > 0; c--)
        putchar(' ');

    printf("%s : ", print_hnum(a));

    obj = (byte *)obj_addr(a);
    if (objd.is_eobj)
    {
        address = Z_TO_WORD(((eobject_t *)obj)->data);
        sibling = Z_TO_WORD(((eobject_t *)obj)->sibling);
        child   = Z_TO_WORD(((eobject_t *)obj)->child);
    }
    else
    {
        address = Z_TO_WORD(((object_t *)obj)->data);
        sibling = ((object_t *)obj)->sibling;
        child   = ((object_t *)obj)->child;
    }

    page = address / BLOCK_SIZE;
    offset = address % BLOCK_SIZE;
    if (get_byte(&page, &offset) > 0)
        prt_coded(&page, &offset);
    wrt_buffer();

    if (child)
        obtree(child, b+1);
    if (sibling)
        obtree(sibling, b);
}

static void
show_tree()
{
    extern print_buf_t  *pbf_p;
    extern byte         *base_ptr;

    byte            *obj;
    int             i=1;
    int             n_objs;
    int             parent;

    puts("\nInfocom Adventure - Object Tree\n");

    pbf_p->len = 0;
    obj = (byte *)obj_addr(i);

    n_objs = (objd.is_eobj
              ? Z_TO_WORD(((eobject_t *)obj)->data)
              : Z_TO_WORD(((object_t *)obj)->data));
    n_objs = (n_objs - (obj - base_ptr)) / objd.obj_size;

    printf("Number of objects: %d\n\n", n_objs);

    do
    {
        parent = (objd.is_eobj
                  ? Z_TO_WORD(((eobject_t *)obj)->parent)
                  : ((object_t *)obj)->parent);

        if (parent == 0)
        {
            obtree(i, 0);
            putchar('\n');
        }

        obj = (byte *)obj_addr(++i);
    }
    while (i <= n_objs);

    putchar('\n');
}

void
options A5( Bool, verfy,
            Bool, head,
            Bool, objs,
            Bool, vocab,
            Bool, tree )
{
    printf("\nInformation for Infocom data file `%s'\n", gflags.filenm);

    if (verfy)
        verify_game();
    if (head)
        show_header();
    if (vocab)
        show_vocab();
    if (objs)
        show_objects();
    if (tree)
        show_tree();
}
