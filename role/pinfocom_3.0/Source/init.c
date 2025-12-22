/* init.c
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
 * $Header: RCS/init.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include "infocom.h"


void
init()
{
    extern word     resident_blocks;
    extern word     save_blocks;
    extern header_t data_head;
    extern file_t   file_info;
    extern byte     *base_ptr;
    extern byte     *base_end;
    extern byte     *vocab;
    extern byte     *global_ptr;
    extern byte     *common_word_ptr;
    extern byte     *end_res_p;
    extern word     *stack_base;

    extern byte     *wsbf_strt;
    extern char     ws_table[];
    extern char     table[];
    extern byte     *end_of_sentence;
    extern word     vocab_entry_size;
    extern word     num_vocab_words;
    extern byte     *strt_vocab_table;
    extern byte     *end_vocab_table;

    unsigned long   i;
    word            num;
    byte            *p, *q;

    read_header(&data_head);

    resident_blocks = data_head.resident_bytes / BLOCK_SIZE;
    if (data_head.resident_bytes % BLOCK_SIZE)
        ++resident_blocks;

    i = data_head.verify_length;
    switch (data_head.z_version)
    {
        case 6: i *= 2;
        case 5:
        case 4: i *= 2;
        default:i *= 2;
    }
    file_info.pages = i / BLOCK_SIZE;
    file_info.offset = i % BLOCK_SIZE;

    /*
     * Try to calculate how much resident storage we'll need.  We need
     * enough for the resident blocks, pluse the stack, plus any extra
     * whitespace characters (say 100 bytes: way too much but...)
     */
    i = (resident_blocks * BLOCK_SIZE) + STACK_SIZE + 100;
    base_ptr = (byte *)xmalloc(i);
    base_end = base_ptr + i;

    /*
     * Load resident memory
     */
    load_page(0, resident_blocks, base_ptr);

    /*
     * Set up pointers into resident storage, and information related
     * to it.
     */
    global_ptr = base_ptr + data_head.variable_o;

    common_word_ptr = base_ptr + data_head.common_word_o;

    save_blocks = data_head.save_bytes / BLOCK_SIZE;
    if (data_head.save_bytes % BLOCK_SIZE)
        ++save_blocks;

    /*
     * Set up object information.  I don't know why there's an offset
     * before the object offset in the file and the actual start of
     * the object list, but there is.  I found the correct values by
     * writing a little loop that tried each value incrementally until
     * one worked! :-)
     */
    objd.obj_base = base_ptr + data_head.object_o;
    if (data_head.z_version > 3)
    {
        objd.obj_size = 14;
        objd.obj_offset = 0x70;
        objd.is_eobj = 1;
    }
    else
    {
        objd.obj_size = 9;
        objd.obj_offset = 0x35;
        objd.is_eobj = 0;
    }

    /*
     * If we have alternate alphabets, then load them in.
     */
    if (data_head.alphabet_o != 0)
    {
        word    page;
        word    offset;

        page = data_head.alphabet_o / BLOCK_SIZE;
        offset = data_head.alphabet_o % BLOCK_SIZE;

        for (i = 0; i < 3 * 26; ++i)
            table[i] = get_byte(&page, &offset);
    }

    /*
     * Now set up information that comes after the resident storage,
     * such as the stack and the whitespace list.
     */
    end_res_p = base_ptr + (resident_blocks * BLOCK_SIZE);

    stack_base = (word *)(end_res_p + STACK_SIZE);

    wsbf_strt = (byte *)stack_base;

    /*
     * Set up the vocabulary information: first read in the
     * end-of-sentence punctuation marks, then get the size of each
     * vocabulary entry and the number of words in it, and mark the
     * start and end of the vocab table.
     */
    vocab = base_ptr + data_head.vocab_o;
    p = vocab;
    num = Z_TO_BYTE_I(p);
    q = wsbf_strt;
    while (num-- > 0)
        *q++ = *p++;
    end_of_sentence = q;

    vocab_entry_size = Z_TO_BYTE_I(p);
    num_vocab_words = Z_TO_WORD_I(p);

    strt_vocab_table = p;
    end_vocab_table = strt_vocab_table +
        (vocab_entry_size * (num_vocab_words-1));

    p = (byte *)ws_table;
    while (*p != 0)
    {
        *q++ = *p++;
    }
    *q = 0;

    /*
     * Set up the page table, random number generator, and print
     * buffers.
     */
    pg_init();
    seed_random();
    print_init();
}
