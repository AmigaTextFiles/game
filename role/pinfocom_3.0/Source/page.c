/* page.c
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
 * $Header: RCS/page.c,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

#include <stdio.h>

#include "infocom.h"


#ifndef malloc
extern ptr_t malloc();
#endif


#ifndef MAX_PAGE_ENTRIES
#define MAX_PAGE_ENTRIES    0x20
#endif
#define MIN_PAGE_ENTRIES    3
#define NO_PAGE             0xFFFF

#define PG_ENTRY_LEN        (BLOCK_SIZE + sizeof(pg_table_t))
#define PG_OFFSET(_n)       (pg_start+((long_word)(_n)*BLOCK_SIZE))


/*
 * This is a page table entry.  The page table is a circular linked
 * list (using array indices instead of pointers to save space), where
 * MRU_pg_p always references the most-recently-used page,
 * pg_table[MRU_pg_p].prev is the least-recently-used page, and
 * pg_table[MRU_pg_p].next, etc. are the rest of the pages.
 */
typedef struct
{
    word    page;
    byte    next;
    byte    prev;
} pg_table_t;


/*
 * Variables:
 *      pg_count    The number of pages in the page table (at least 2)
 *
 *      pg_table    Array of page table entries
 *      pg_start    Ptr to the first page
 *
 *      cur_pg_p    The page currently being executed by the interpreter
 *      MRU_pg_p    The most-recently-used page in the page table
 *
 * Notes:
 *      Variables with suffixes "_page" refer to actual page numbers;
 *      suffixes of "_pg_p" refer to "pointers" (array indices) into
 *      the pg_table.
 *
 *      The cur_pg_p and MRU_pg_p will be the same if the program is
 *      executing paged-in memory, but different if it's executing
 *      resident memory (which isn't stored in the page table, of
 *      course).
 */
static pg_table_t   *pg_table   = 0;
static byte         *pg_start   = 0;

static word         pg_count    = 0;
static word         cur_page    = 0;
static word         MRU_pg_p    = 0;


/*
 * Initialize the page table.  Find out the maximum number of pages we
 * can load, then allocate the memory and initialize the page table.
 * Make sure we have at *least* MIN_PAGE_ENTRIES pages, or things will
 * not work well.  Finally initialize the pointers correctly.
 */
void
pg_init()
{
    extern file_t   file_info;
    extern word     resident_blocks;

    pg_table_t *ptr;
    int i;

    /*
     * Find out how many pages we can successfully allocate (MAX_PAGES
     * or the number of pages in the file, whichever is less, is the
     * most we can use.
     */
    i = file_info.pages - resident_blocks + 1;
    i = (i > MAX_PAGE_ENTRIES
         ? MAX_PAGE_ENTRIES
         : (i < MIN_PAGE_ENTRIES ? MIN_PAGE_ENTRIES : i));

    for (; i>=MIN_PAGE_ENTRIES && pg_start==0; i -= 0x0F)
        pg_start = (byte *)malloc(i * PG_ENTRY_LEN);

    if (pg_start == 0)
    {
        i = MIN_PAGE_ENTRIES;
        pg_start = (byte *)xmalloc(i * PG_ENTRY_LEN);
    }
    else
    {
        i += 0x0F;
    }
    pg_count = i;

    /*
     * Find the start of the page table and entry sections.
     */
    pg_table = (pg_table_t *)pg_start;
    pg_start += (pg_count * sizeof(pg_table_t));

    /*
     * Initialize so that LRU=0, LRU[1]=1, etc.; this speeds up
     * initialization.
     */
    for (i = 0, ptr = pg_table; i < (int)pg_count; ++i, ++ptr)
    {
        ptr->page = NO_PAGE;
        ptr->next = i - 1;
        ptr->prev = i + 1;
    }

    MRU_pg_p = pg_count - 1;

    pg_table[0].next        = MRU_pg_p;
    pg_table[MRU_pg_p].prev = 0;
}


/*
 * Locate new_page in in the page table (or load it into the LRU block
 * if it's not already in the table) and return a pointer to it.
 */
byte *
fetch_page A1(word, new_page)
{
    pg_table_t *mp;
    int pg_p;

    /*
     * If the page we want is already the MRU page, then we're done...
     *
     * Some empirical research (printf's! :-) suggests that a full 33%
     * of all swaps are done between the MRU and the next block.  So,
     * to speed things up still further we check to see if that's the
     * case and if so we don't swap.  This is a double gain since the
     * same research suggests that many of these swaps are done
     * continuously; i.e., block 1 and 2 swap, then swap back next
     * call, then swap back again, etc.
     */
    pg_p = MRU_pg_p;
    mp = &pg_table[pg_p];

    if ((new_page != mp->page)
        && (new_page != pg_table[pg_p = mp->next].page))
    {
        pg_table_t *tp;

        /*
         * Look through the page table (in no particular order) to see
         * if the block we want is already loaded.  If it is,
         * manipulate the list to make it the MRU.
         */
        for (tp = pg_table, pg_p = 0; pg_p < (int)pg_count; ++pg_p, ++tp)
        {
            if (new_page == tp->page)
            {
                pg_table[tp->prev].next = tp->next;
                pg_table[tp->next].prev = tp->prev;

                tp->next = MRU_pg_p;
                tp->prev = mp->prev;

                mp->prev = pg_p;
                pg_table[tp->prev].next = pg_p;

                MRU_pg_p = pg_p;

                break;
            }
        }

        /*
         * If we didn't find the page we want in the page table, then
         * we'll have to load it.  Choose the LRU page to load it
         * into, unless the LRU page is the currently executing page:
         * this could happen if we do lots of get_byte() or get_word()
         * calls (which are basically asyncronous memory requests...)
         * between fix_pc() calls.
         *
         * Once we've loaded it, make the LRU into the MRU.  Since the
         * list is circular we can do this by simply moving the MRU
         * pointer over.  Note that if we had to move an extra space
         * because the LRU is the current page then the current page
         * will now be the 2nd MRU block, but who cares, that's
         * probably a good thing...
         */
        if (pg_p == pg_count)
        {
            pg_p = mp->prev;
            if (pg_table[pg_p].page == cur_page)
                pg_p = pg_table[pg_p].prev;

            load_page(new_page, 1, PG_OFFSET(pg_p));

            pg_table[pg_p].page = new_page;
            MRU_pg_p = pg_p;
        }
    }

    return (PG_OFFSET(pg_p));
}

void
fix_pc()
{
    extern word     pc_page;
    extern word     pc_offset;
    extern word     resident_blocks;
    extern byte     *prog_block_ptr;
    extern byte     *base_ptr;

    /*
     * This must be 32 bits long since 'pc_page'
     * can have any value from $0000 to $FFFF.
     */

    long_word       pc;

    /* The high bit of 'pc_offset' is actually a sign bit. */

    pc = ((long_word)pc_page * BLOCK_SIZE) + (signed_word)pc_offset;
    pc_offset = pc % BLOCK_SIZE;
    pc_page = pc / BLOCK_SIZE;

    /*
     * If the page we want isn't the one we currently have, then get
     * it: if it's in resident memory then set it directly otherwise
     * fetch it from the page table.
     */
    if (pc_page != cur_page)
    {
        cur_page = pc_page;

        if (pc_page < resident_blocks)
            prog_block_ptr = base_ptr + ((long_word)pc_page * BLOCK_SIZE);
        else
            prog_block_ptr = fetch_page(pc_page);
    }
}
