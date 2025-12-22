/*
 * osdepend.c
 *
 * All non screen specific operating system dependent routines.
 *
 * Olaf Barthel 28-Jul-1992 V1.0
 *
 */

#ifdef MAC
#include <console.h>
#endif
#include "ztypes.h"

/* File names will be O/S dependent */

#if defined(amiga)
#define SAVE_NAME "Story.Save"  /* Default save name */
#define SCRIPT_NAME "PRT:"      /* Default script name */
#else /* !defined(amiga) */
#define SAVE_NAME "story.sav"   /* Default save name */
#define SCRIPT_NAME "story.lis" /* Default script name */
#endif /* defined(amiga) */

/*
 * process_arguments
 *
 * Do any argument preprocessing necessary before the game is
 * started. This may include selecting a specific game file or
 * setting interface-specific options.
 *
 */

#ifdef __STDC__
void process_arguments (int argc, char *argv[])
#else
void process_arguments (argc, argv)
int argc;
char *argv[];
#endif
{

#ifdef MAC
    argc = ccommand (&argv);
#endif

    if (argc < 2) {
        fprintf (stderr, "Usage: %s story-file-name [restore-file_name]", argv[0]);
        exit (EXIT_FAILURE);
    }

    open_story (argv[1]);

    if (argc > 2)
        restore_name = argv[2];

}/* process_arguments */

/*
 * file_cleanup
 *
 * Perform actions when a file is successfully closed. Flag can be one of:
 * GAME_SAVE, GAME_RESTORE, GAME_SCRIPT.
 *
 */

#ifdef __STDC__
void file_cleanup (const char *file_name, int flag)
#else
void file_cleanup (file_name, flag)
const char *file_name;
int flag;
#endif
{

}/* file_cleanup */

/*
 * sound
 *
 * Play a sound file or a note.
 *
 * argc = 1: argv[0] = note# (range 1 - 3)
 *
 *           Play note.
 *
 * argc = 2: argv[0] = 0
 *           argv[1] = 3
 *
 *           Stop playing current sound.
 *
 * argc = 2: argv[0] = 0
 *           argv[1] = 4
 *
 *           Free allocated resources.
 *
 * argc = 3: argv[0] = ID# of sound file to replay.
 *           argv[1] = 2
 *           argv[2] = Volume to replay sound with, this value
 *                     can range between 1 and 8.
 *
 *           Play sound file.
 *
 */

#ifdef __STDC__
void sound (int argc, zword_t *argv)
#else
void sound (argc, argv)
int argc;
zword_t *argv;
#endif
{

    /* Generic bell sounder */

    if (argc == 1 || (argc >= 2 && argv[1] == 2))
        display_char ('\007');

}/* sound */

/*
 * get_file_name
 *
 * Return the name of a file. Flag can be one of: GAME_SAVE, GAME_RESTORE or
 * GAME_SCRIPT.
 *
 */

#ifdef __STDC__
int get_file_name (char *file_name, char *default_name, int flag)
#else
int get_file_name (file_name, default_name, flag)
char *file_name;
char *default_name;
int flag;
#endif
{
    int status, saved_scripting_disable;

    if (default_name[0] == '\0')
        if (flag == GAME_SCRIPT)
            strcpy (default_name, SCRIPT_NAME);
        else
            strcpy (default_name, SAVE_NAME);

    saved_scripting_disable = scripting_disable;
    scripting_disable = ON;

    status = TRUE;

    output_stringnl ("Enter a file name.");
    output_string ("(Default is \"");
    output_string (default_name);
    output_string ("\"): ");

    input[0] = (char) (screen_cols - RIGHT_MARGIN - 1 -
        sizeof ("(Default is \"") - strlen (default_name) - sizeof ("\"): "));

    input_line ();

    if (input[1]) {
        input[input[1] + 2] = '\0';
        strcpy (file_name, &input[2]);
    } else
        strcpy (file_name, default_name);

#if !defined(VMS) /* VMS has file version numbers, so cannot overwrite */
    if (flag == GAME_SAVE || flag == GAME_SCRIPT) {
        FILE *tfp;
        char c;

        tfp = fopen (file_name, "r");
        if (tfp != NULL) {
            fclose (tfp);

            output_stringnl ("You are about to write over an existing file.");
            output_string ("Proceed? (Y/N) ");

            do
                c = toupper (input_character ());
            while (c != 'Y' && c != 'N');

            display_char (c);
            scroll_line ();

            if (c == 'N')
                status = FALSE;
        }
    }
#endif /* !defined(VMS) */

    scripting_disable = saved_scripting_disable;

    return (status);

}/* get_file_name */
