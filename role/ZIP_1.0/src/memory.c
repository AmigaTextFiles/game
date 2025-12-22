/*
 * memory.c
 *
 * Code and data caching routines
 *
 * Mark Howell 28-Jul-1992 V1.0
 *
 */

#include "ztypes.h"

/* A cache entry */

typedef struct cache_entry {
    struct cache_entry *flink;
    int page_number;
    zbyte_t data[PAGE_SIZE];
} cache_entry_t;

/* Pages in cache and cache chain anchor */

static unsigned int cache_pages = 0;
static cache_entry_t *cache = NULL;

/* Pseudo translation buffer, one entry each for code and data pages */

static unsigned int current_code_page = 0;
static cache_entry_t *current_code_cachep = NULL;
static unsigned int current_data_page = 0;
static cache_entry_t *current_data_cachep = NULL;

#ifdef __STDC__
static cache_entry_t *update_cache (int);
#else
static cache_entry_t *update_cache ();
#endif

/*
 * load_cache
 *
 * Initialise the cache and any other dynamic memory objects. The memory
 * required can be split into two areas. Firstly, three buffers are required for
 * input, output and status line. Secondly, two data areas are required for
 * writeable data and read only data. The writeable data is the first chunk of
 * the file and is put into non-paged cache. The read only data is the remainder
 * of the file which can be paged into the cache as required. Writeable data has
 * to be memory resident because it cannot be written out to a backing store.
 *
 */

#ifdef __STDC__
void load_cache (void)
#else
void load_cache ()
#endif
{
    unsigned int file_pages, data_pages;
    unsigned int i;
    cache_entry_t *cachep, *lastp = NULL;

    /* Allocate output, input and status line buffers */

    line = (char *) malloc (screen_cols + 1);
    if (line == NULL)
        fatal ("Insufficient memory to play game");
    input = (char *) malloc (screen_cols + 1);
    if (input == NULL)
        fatal ("Insufficient memory to play game");
    status_line = (char *) malloc (screen_cols + 1);
    if (status_line == NULL)
        fatal ("Insufficient memory to play game");

    /* Calculate dynamic cache pages required */

    file_pages = (h_file_size >> (PAGE_SHIFT - story_shift)) + 1;
    data_pages = (h_data_size + PAGE_MASK) >> PAGE_SHIFT;
    cache_pages = file_pages - data_pages;

    /* Allocate static data area and initialise it */

    data_size = data_pages * PAGE_SIZE;
    datap = (zbyte_t *) malloc (data_size);
    if (datap == NULL)
        fatal ("Insufficient memory to play game");
    for (i = 0; i < data_pages; i++)
        read_page (i, &datap[i * PAGE_SIZE]);

    /* Allocate cache pages and initialise them */

    for (i = 0; i < cache_pages; i++) {
        cachep = (cache_entry_t *) malloc (sizeof (cache_entry_t));
        if (cachep == NULL) {
            cache_pages = i;
            i = 512 + 1;
        } else {
            if (i == 0)
                cache = cachep;
            else
                lastp->flink = cachep;
            cachep->flink = NULL;
            cachep->page_number = data_pages + i;
            lastp = cachep;
            read_page (cachep->page_number, cachep->data);
        }
    }

}/* load_cache */

/*
 * unload_cache
 *
 * Deallocate cache and other memory objects.
 *
 */

#ifdef __STDC__
void unload_cache (void)
#else
void unload_cache ()
#endif
{
    cache_entry_t *cachep, *nextp;

    /* Free output buffer, input buffer, status line and data memory */

    free (line);
    free (input);
    free (status_line);
    free (datap);

    /* Free cache memory */

    for (cachep = cache; cachep->flink != NULL; cachep = nextp) {
        nextp = cachep->flink;
        free (cachep);
    }

}/* unload_cache */

/*
 * read_code_word
 *
 * Read a word from the instruction stream.
 *
 */

#ifdef __STDC__
zword_t read_code_word (void)
#else
zword_t read_code_word ()
#endif
{
    zword_t w;

    w = (zword_t) read_code_byte () << 8;
    w |= (zword_t) read_code_byte ();

    return (w);

}/* read_code_word */

/*
 * read_code_byte
 *
 * Read a byte from the instruction stream.
 *
 */

#ifdef __STDC__
zbyte_t read_code_byte (void)
#else
zbyte_t read_code_byte ()
#endif
{
    unsigned int page_number, page_offset;

    /* Calculate page and offset values */

    page_number = (unsigned int) (pc >> PAGE_SHIFT);
    page_offset = (unsigned int) pc & PAGE_MASK;

    /* Load page into translation buffer */

    if (page_number != current_code_page) {
        current_code_cachep = update_cache (page_number);
        current_code_page = page_number;
    }

    /* Update the PC */

    pc++;

    /* Return byte from page offset */

    return (current_code_cachep->data[page_offset]);

}/* read_code_byte */

/*
 * read_data_word
 *
 * Read a word from the data area.
 *
 */

#ifdef __STDC__
zword_t read_data_word (unsigned long *addr)
#else
zword_t read_data_word (addr)
unsigned long *addr;
#endif
{
    zword_t w;

    w = (zword_t) read_data_byte (addr) << 8;
    w |= (zword_t) read_data_byte (addr);

    return (w);

}/* read_data_word */

/*
 * read_data_byte
 *
 * Read a byte from the data area.
 *
 */

#ifdef __STDC__
zbyte_t read_data_byte (unsigned long *addr)
#else
zbyte_t read_data_byte (addr)
unsigned long *addr;
#endif
{
    unsigned int page_number, page_offset;
    zbyte_t value;

    /* Check if byte is in non-paged cache */

    if (*addr < (unsigned long) data_size)
        value = datap[*addr];
    else {

        /* Calculate page and offset values */

        page_number = (int) (*addr >> PAGE_SHIFT);
        page_offset = (int) *addr & PAGE_MASK;

        /* Load page into translation buffer */

        if (page_number != current_data_page) {
            current_data_cachep = update_cache (page_number);
            current_data_page = page_number;
        }

        /* Fetch byte from page offset */

        value = current_data_cachep->data[page_offset];
    }

    /* Update the address */

    (*addr)++;

    return (value);

}/* read_data_byte */

/*
 * update_cache
 *
 * Called on a code or data page cache miss to find the page in the cache or
 * read the page in from disk. The chain is kept as a simple LRU chain. If a
 * page cannot be found then the page on the end of the chain is reused. If the
 * page is found, or reused, then it is moved to the front of the chain.
 *
 */

#ifdef __STDC__
static cache_entry_t *update_cache (int page_number)
#else
static cache_entry_t *update_cache (page_number)
int page_number;
#endif
{
    cache_entry_t *cachep, *lastp;

    /* Search the cache chain for the page */

    for (lastp = cache, cachep = cache;
         cachep->flink != NULL &&
         cachep->page_number &&
         cachep->page_number != page_number;
         lastp = cachep, cachep = cachep->flink)
        ;

    /* If no page in chain then read it from disk */

    if (cachep->page_number != page_number) {

        /* Reusing last cache page, so invalidate cache if page was in use */

        if (cachep->flink == NULL && cachep->page_number) {
            if (current_code_page == (unsigned int) cachep->page_number)
                current_code_page = 0;
            if (current_data_page == (unsigned int) cachep->page_number)
                current_data_page = 0;
        }

        /* Load the new page number and the page contents from disk */

        cachep->page_number = page_number;
        read_page (page_number, cachep->data);
    }

    /* If page is not at front of cache chain then move it there */

    if (lastp != cache) {
        lastp->flink = cachep->flink;
        cachep->flink = cache;
        cache = cachep;
    }

    return (cachep);

}/* update_cache */
