/*
 * zip.c
 *
 * Z code interpreter main routine. Plays Infocom type 3 and 4 games.
 *
 * Usage: zip story-file-name
 *
 * This is a no bells and whistles Infocom interpreter for type 3 and 4 games.
 * It will automatically detect which type of game you want to play. It should
 * support all type 3 and 4 features and is based loosely on the MS-DOS version
 * with enhancements to aid portability. Read the readme.1st file for
 * information on building this program on your favourite operating system.
 * Please mail me, at the address below, if you find bugs in the code.
 *
 * Special thanks to David Doherty and Olaf Barthel for testing this program
 * and providing invaluable help and code to aid its portability.
 *
 * Mark Howell 28-Jul-92 V1.0 howell_ma@movies.enet.dec.com
 *
 * Disclaimer:
 *
 * You are expressly forbidden to use this program if in so doing you violate
 * the copyright notice supplied with the original Infocom game.
 *
 */

#include "ztypes.h"

#ifdef __STDC__
static void initialize_dictionary (void);
static void configure (void);
#else
static void initialize_dictionary ();
static void configure ();
#endif

/*
 * main
 *
 * Initialise environment, start interpreter, clean up.
 *
 */

#ifdef __STDC__
int main (int argc, char *argv[])
#else
int main (argc, argv)
int argc;
char *argv[];
#endif
{

    process_arguments (argc, argv);

    configure ();

    initialize_screen ();

    load_cache ();

    initialize_dictionary ();

    restart ();

    if (restore_name != NULL && restore ())
        restart ();

    interpret ();

    unload_cache ();

    close_story ();

    close_script ();

    output_nl ();

    reset_screen ();

    exit (EXIT_SUCCESS);

    return (0);

}/* main */

/*
 * initialize_dictionary
 *
 * Load special word separator list and dictionary information.
 *
 */

#ifdef __STDC__
static void initialize_dictionary (void)
#else
static void initialize_dictionary ()
#endif
{
    int i, count, offset;

    offset = h_words_offset;
    count = get_byte (offset);
    for (i = 0, offset++; i < count; )
        punctuation[i++] = get_byte (offset++);
    punctuation[i] = '\0';
    entry_size = get_byte (offset++);
    dictionary_size = get_word (offset);
    dictionary_offset = offset + 2;

}/* initialize_dictionary */

/*
 * configure
 *
 * Initialise global and type specific variables.
 *
 */

#ifdef __STDC__
static void configure (void)
#else
static void configure ()
#endif
{
    zbyte_t header[PAGE_SIZE];

    read_page (0, header);
    datap = header;

    h_type = get_byte (H_TYPE);

    if ((h_type != V3 && h_type != V4) || (get_byte (H_CONFIG) & CONFIG_BYTE_SWAPPED))
        fatal ("wrong game or version");

    if (h_type == V3) {
        story_scaler = 2;
        story_shift = 1;
        property_mask = P3_MAX_PROPERTIES - 1;
        property_size_mask = 0xe0;
    } else {
        story_scaler = 4;
        story_shift = 2;
        property_mask = P4_MAX_PROPERTIES - 1;
        property_size_mask = 0x3f;
    }

    h_version = get_word (H_VERSION);
    h_data_size = get_word (H_DATA_SIZE);
    h_start_pc = get_word (H_START_PC);
    h_words_offset = get_word (H_WORDS_OFFSET);
    h_objects_offset = get_word (H_OBJECTS_OFFSET);
    h_globals_offset = get_word (H_GLOBALS_OFFSET);
    h_restart_size = get_word (H_RESTART_SIZE);
    h_synonyms_offset = get_word (H_SYNONYMS_OFFSET);
    h_file_size = get_word (H_FILE_SIZE);
    if (h_file_size == 0)
        h_file_size = get_story_size ();
    h_checksum = get_word (H_CHECKSUM);

    datap = NULL;

}/* configure */
