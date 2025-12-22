/*
 * fileio.c
 *
 * File manipulation routines. Should be generic.
 *
 * Mark Howell 28-Jul-1992 V1.0
 *
 */

#include "ztypes.h"

/* Static data */

static FILE *gfp = NULL;
static FILE *sfp = NULL;
static char save_name[FILENAME_MAX + 1] = "";
static char script_name[FILENAME_MAX + 1] = "";

/*
 * open_story
 *
 * Open game file for read.
 *
 */

#ifdef __STDC__
void open_story (const char *storyname)
#else
void open_story (storyname)
const char *storyname;
#endif
{

    gfp = fopen (storyname, "rb");
    if (gfp == NULL)
        fatal ("Game file not found");

}/* open_story */

/*
 * close_story
 *
 * Close game file if open.
 *
 */

#ifdef __STDC__
void close_story (void)
#else
void close_story ()
#endif
{

    if (gfp != NULL)
        fclose (gfp);

}/* close_story */

/*
 * get_story_size
 *
 * Calculate the size of the game file. Only used for very old games that do not
 * have the game file size in the header.
 *
 */

#ifdef __STDC__
int get_story_size (void)
#else
int get_story_size ()
#endif
{
    unsigned long file_length;

    /* Seek to end of file to calculate length */

    fseek (gfp, 0L, SEEK_END);
    file_length = (unsigned long) ftell (gfp);
    rewind (gfp);

    /* Calculate length of file in game allocation units */

    file_length = (file_length + (unsigned long) (story_scaler - 1)) / (unsigned long) story_scaler;

    return ((int) file_length);

}/* get_story_size */

/*
 * read_page
 *
 * Read one game file page.
 *
 */

#ifdef __STDC__
void read_page (int page, void *buffer)
#else
void read_page (page, buffer)
int page;
void *buffer;
#endif
{
    unsigned long file_size;
    unsigned int pages, offset;

    /* Seek to start of page */

    fseek (gfp, (long) page * PAGE_SIZE, SEEK_SET);

    /* Read the page */

    if (fread (buffer, PAGE_SIZE, 1, gfp) != 1) {

        /* Read failed. Are we in the last page? */

        file_size = (unsigned long) h_file_size * story_scaler;
        pages = (unsigned int) ((unsigned long) file_size / PAGE_SIZE);
        offset = (unsigned int) ((unsigned long) file_size & PAGE_MASK);
        if ((unsigned int) page == pages) {

            /* Read partial page if this is the last page in the game file */

            fseek (gfp, (long) page * PAGE_SIZE, SEEK_SET);
            if (fread (buffer, offset, 1, gfp) == 1)
                return;
        }
        fatal ("Game file read error");
    }

}/* read_page */

/*
 * verify
 *
 * Verify game ($verify verb). Add all bytes in game file except for bytes in
 * the game file header.
 *
 */

#ifdef __STDC__
void verify (void)
#else
void verify ()
#endif
{
    unsigned long file_size;
    unsigned int pages, offset;
    unsigned int start, end, i, j;
    zword_t checksum = 0;
    zbyte_t buffer[PAGE_SIZE];

    /* Print version banner */

    if (h_type == V3) {
        write_string ("ZIP Interpreter ");
        print_number (get_byte (H_INTERPRETER));
        write_string (", Version ");
        write_char (get_byte (H_INTERPRETER_VERSION));
        write_string (".");
        flush_buffer (TRUE);
    }

    /* Calculate game file dimensions */

    file_size = (unsigned long) h_file_size * story_scaler;
    pages = (unsigned int) ((unsigned long) file_size / PAGE_SIZE);
    offset = (unsigned int) file_size & PAGE_MASK;

    /* Sum all bytes in game file, except header bytes */

    for (i = 0; i <= pages; i++) {
        read_page (i, buffer);
        start = (i == 0) ? 64 : 0;
        end = (i == pages) ? offset : PAGE_SIZE;
        for (j = start; j < end; j++)
            checksum += buffer[j];
    }

    /* Make a conditional jump based on whether the checksum is equal */

    conditional_jump (checksum == h_checksum);

}/* verify */

/*
 * save
 *
 * Save game state to disk.
 *
 */

#ifdef __STDC__
int save (void)
#else
int save ()
#endif
{
    char new_save_name[FILENAME_MAX + 1];
    int status;

    /* Get the file name */

    if (get_file_name (new_save_name, save_name, GAME_SAVE) != TRUE)
        return (1);

    /* Do save operation */

    if (status = save_restore (new_save_name, GAME_SAVE))

        /* Perform error action */

        if (h_type == V3)
            conditional_jump (0);
        else
            store_operand (0);
    else {

        /* Perform success action */

        if (h_type == V3)
            conditional_jump (1);
        else
            store_operand (1);

        /* Cleanup and remember file name */

        file_cleanup (new_save_name, GAME_SAVE);

        strcpy (save_name, new_save_name);

    }

    return (status);

}/* save */

/*
 * restore
 *
 * Restore game state from disk.
 *
 */

#ifdef __STDC__
int restore (void)
#else
int restore ()
#endif
{
    char new_save_name[FILENAME_MAX + 1];
    int status;

    /* Get the file name */

    if (restore_name != NULL) {
        strcpy (new_save_name, restore_name);
        restore_name = NULL;
    } else
        if (get_file_name (new_save_name, save_name, GAME_RESTORE) != TRUE)
            return (1);

    /* Do restore operation */

    if (status = save_restore (new_save_name, GAME_RESTORE))

        /* perform error action */

        if (h_type == V3)
            conditional_jump (0);
        else
            store_operand (0);
    else {

        /* Perform success action */

        if (h_type == V3)
            conditional_jump (1);
        else
            store_operand (2);

        /* Cleanup and remember file name */

        file_cleanup (new_save_name, GAME_RESTORE);

        strcpy (save_name, new_save_name);

    }

    return (status);

}/* restore */

/*
 * save_restore
 *
 * Common save and restore code. Just save or restore the game stack and the
 * writeable data area.
 *
 */

#ifdef __STDC__
int save_restore (const char *file_name, int flag)
#else
int save_restore (file_name, flag)
const char *file_name;
int flag;
#endif
{
    FILE *tfp;
    int scripting;

    /* Open the save file */

    if (flag == GAME_SAVE) {
        if ((tfp = fopen (file_name, "wb")) == NULL)
            output_stringnl ("Unable to access file");
    } else {
        if ((tfp = fopen (file_name, "rb")) == NULL)
            output_stringnl ("SAVE file not found");
    }
    if (tfp == NULL)
        return (1);

    /* Save state of scripting */

    scripting = get_word (H_FLAGS) & SCRIPTING_FLAG;

    /* Push PC, FP, version and store SP in special location */

    stack[--sp] = (zword_t) (pc / PAGE_SIZE);
    stack[--sp] = (zword_t) (pc % PAGE_SIZE);
    stack[--sp] = fp;
    stack[--sp] = h_version;
    stack[0] = sp;

    /* Save or restore stack */

    if (flag == GAME_SAVE) {
        if (fwrite (stack, sizeof (stack), 1, tfp) != 1) {
            fclose (tfp);
            remove (file_name);
            output_stringnl ("No room for SAVE file");
            tfp = NULL;
        }
    } else {
        if (fread (stack, sizeof (stack), 1, tfp) != 1) {
            fclose (tfp);
            output_stringnl ("Read of SAVE file failed");
            tfp = NULL;
        }
    }

    /* Restore SP, check version, restore FP and PC */

    sp = stack[0];
    if (stack[sp++] != h_version)
        fatal ("Wrong game or version");
    fp = stack[sp++];
    pc = stack[sp++];
    pc += (unsigned long) stack[sp++] * PAGE_SIZE;

    if (tfp == NULL)
        return (1);

    /* Save or restore writeable game data area */

    if (flag == GAME_SAVE) {
        if (fwrite (datap, h_restart_size, 1, tfp) != 1) {
            fclose (tfp);
            remove (file_name);
            output_stringnl ("No room for SAVE file");
            tfp = NULL;
        }
    } else {
        if (fread (datap, h_restart_size, 1, tfp) != 1) {
            fclose (tfp);
            output_stringnl ("Read of SAVE file failed");
            tfp = NULL;
        }
    }

    /* Restore scripting state */

    set_word (H_FLAGS, scripting);

    if (tfp == NULL)
        return (1);

    fclose (tfp);

    return (0);

}/* save_restore */

/*
 * open_script
 *
 * Open the scripting file.
 *
 */

#ifdef __STDC__
void open_script (void)
#else
void open_script ()
#endif
{
    char new_script_name[FILENAME_MAX + 1];

    /* Get scripting file name */

    if (get_file_name (new_script_name, script_name, GAME_SCRIPT) != TRUE)
        return;

    /* Open scripting file */

    sfp = fopen (new_script_name, "w");

    /* Turn off scripting if open failed */

    if (sfp == NULL) {
        set_word (H_FLAGS, get_word (H_FLAGS) & (~SCRIPTING_FLAG));
        output_stringnl ("Script file create failed");
        return;
    }

    /* Remember scripting name */

    strcpy (script_name, new_script_name);

}/* open_script */

/*
 * close_script
 *
 * Close the scripting file.
 *
 */

#ifdef __STDC__
void close_script (void)
#else
void close_script ()
#endif
{

    /* Close scripting file */

    if (sfp != NULL) {
        fclose (sfp);
        sfp = NULL;

        /* Cleanup */

        file_cleanup (script_name, GAME_SCRIPT);
    }
    set_word (H_FLAGS, get_word (H_FLAGS) & (~SCRIPTING_FLAG));

}/* close_script */

/*
 * script_char
 *
 * Write one character to scripting file.
 *
 */

#ifdef __STDC__
void script_char (char c)
#else
void script_char (c)
char c;
#endif
{

    /* Only write character if scripting is on */

    if (get_word (H_FLAGS) & SCRIPTING_FLAG) {

        /* If scripting file is not open then open it */

        if (h_type == V3 && sfp == NULL)
            open_script ();

        /* If scripting file is open then write the character */

        if (sfp != NULL)
            putc (c, sfp);
    } else

        /* Close scripting file if it is open */

        if (h_type == V3 && sfp != NULL)
            close_script ();

}/* script_char */

/*
 * script_line
 *
 * Write a string followed by a new line to the scripting file.
 *
 */

#ifdef __STDC__
void script_line (const char *s)
#else
void script_line (s)
const char *s;
#endif
{

    /* Write string */

    while (*s)
        script_char (*s++);

    /* Write new line */

    script_nl ();

}/* script_line */

/*
 * script_nl
 *
 * Write a new line to the scripting file.
 *
 */

#ifdef __STDC__
void script_nl (void)
#else
void script_nl ()
#endif
{

    script_char ('\n');

}/* script_nl */
