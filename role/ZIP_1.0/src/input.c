/*
 * input.c
 *
 * Input routines
 *
 * Mark Howell 28-Jul-1992 V1.0
 *
 */

#include "ztypes.h"

/* Statically defined word separator list */

static const char *separators = " \t\n\f.,?";

#ifdef __STDC__
static const char *next_token (const char *, const char **, int *);
static zword_t find_word (int, const char *);
static void get_line (char *);
#else
static const char *next_token ();
static zword_t find_word ();
static void get_line ();
#endif

/*
 * read_character
 *
 * Read one character with optional timeout
 *
 */

#ifdef __STDC__
void read_character (int argc, zword_t *args)
#else
void read_character (argc, args)
int argc;
zword_t *args;
#endif
{

    /* Haven't done timeouts yet */

    if (argc != 1)
        fatal ("Unimplemented timeout function");

    /* Reset line count and character count */

    lines_written = 0;
    char_count = screen_cols - RIGHT_MARGIN;

    /* Read n characters, only 1 supported */

    if (args[0] == 1)
        store_operand (input_character ());
    else
        store_operand (0);

}/* read_character */

/*
 * read_line
 *
 * Read a line of input with optional timeout. The token buffer needs some
 * additional explanation. The first byte is the maximum number of tokens
 * allowed. The second byte is set to the actual number of token read. Each
 * token is composed of 3 fields. The first (word) field contains the word
 * offset in the dictionary, the second (byte) field contains the token length,
 * and the third (byte) field contains the start offset of the token in the
 * character buffer.
 *
 */

#ifdef __STDC__
void read_line (int argc, zword_t *args)
#else
void read_line (argc, args)
int argc;
zword_t *args;
#endif
{
    int words, token_length;
    char *cbuf, *tbuf, *tp;
    const char *cp, *token;
    zword_t word;

    /* Haven't done timeouts yet */

    if (argc != 2)
        fatal ("Unimplemented timeout function");

    /* Refresh status line */

    if (h_type == V3)
        display_status_line ();

    /* Flush any buffered output before read */

    flush_buffer (FALSE);

    /* Reset line count */

    lines_written = 0;

    /* Initialise character and token buffer pointers */

    cbuf = (char *) &datap[args[0]];
    tbuf = (char *) &datap[args[1]];

    /* Read the line then script it */

    get_line (cbuf);
    script_line (&cbuf[1]);

    /* Initialise word count and pointers */

    words = 0;
    cp = cbuf + 1;
    tp = tbuf + 2;

    /* Tokenise the line */

    do {

        /* Skip to next token */

        cp = next_token (cp, &token, &token_length);
        if (token_length)

            /* If still space in token buffer then store word */

            if (words <= tbuf[0]) {

                /* Get the word offset from the dictionary */

                word = find_word (token_length, token);

                /* Store the dictionary offset, token length and offset */

                tp[0] = (char) (word >> 8);
                tp[1] = (char) (word & 0xff);
                tp[2] = (char) token_length;
                tp[3] = (char) (token - cbuf);

                /* Step to next token position and count the word */

                tp += 4;
                words++;
            } else {

                /* Moan if token buffer space exhausted */

                output_string ("Too many words typed, discarding: ");
                output_stringnl (token);
            }
    } while (token_length);

    /* Store word count */

    tbuf[1] = (char) words;

}/* read_line */

/*
 * next_token
 *
 * Find next token in a string. The token (word) is delimited by a statically
 * defined and a game specific set of word separators. The game specific set
 * of separators look like real word separators, but the parser wants to know
 * about them. An example would be: 'grue, take the axe. go north'. The
 * parser wants to know about the comma and the period so that it can correctly
 * parse the line. The 'interesting' word separators normally appear at the
 * start of the dictionary, and are also put in a separate list in the game
 * file.
 *
 */

#ifdef __STDC__
static const char *next_token (const char *s, const char **token, int *length)
#else
static const char *next_token (s, token, length)
const char *s;
const char **token;
int *length;
#endif
{
    int i;

    /* Set the token length to zero */

    *length = 0;

    /* Step through the string looking for separators */

    for (; *s; s++) {

        /* Look for game specific word separators first */

        for (i = 0; punctuation[i] && *s != punctuation[i]; i++)
            ;

        /* If a separator is found then return the information */

        if (punctuation[i]) {

            /* If length has been set then just return the word position */

            if (*length)
                return (s);
            else {

                /* End of word, so set length, token pointer and return string */

                (*length)++;
                *token = s;
                return (++s);
            }
        }

        /* Look for statically defined separators last */

        for (i = 0; separators[i] && *s != separators[i]; i++)
            ;

        /* If a separator is found then return the information */

        if (separators[i]) {

            /* If length has been set then just return the word position */

            if (*length)
                return (++s);
        } else {

            /* If first token character then remember its position */

            if (*length == 0)
                *token = s;
            (*length)++;
        }
    }

    return (s);

}/* next_token */

/*
 * find_word
 *
 * Search the dictionary for a word. Just encode the word and binary chop the
 * dictionary looking for it.
 *
 */

#ifdef __STDC__
static zword_t find_word (int len, const char *cp)
#else
static zword_t find_word (len, cp)
int len;
const char *cp;
#endif
{
    short word[3];
    int offset, word_index, chop, status;

    /* Encode target word */

    encode_text (len, cp, word);

    /* Calculate the binary chop start position */

    word_index = dictionary_size / 2;
    chop = 1;
    do
        chop *= 2;
    while (word_index /= 2);

    /* Set the initial position for the binary chop */

    word_index = chop - 1;

    /* Binary chop until the word is found */

    while (chop) {

        /* Set next chop step */

        chop /= 2;

        /* Calculate dictionary offset */

        offset = dictionary_offset + (word_index * entry_size);

        /* If word matches then return dictionary offset */

        if ((status = word[0] - (short) get_word (offset)) == 0 &&
            (status = word[1] - (short) get_word (offset + 2)) == 0 &&
           (h_type == V3 ||
            (status = word[2] - (short) get_word (offset + 4)) == 0))
            return (offset);

        /* Set next position depending on direction of overshoot */

        if (status > 0) {
            word_index += chop;

            /* Deal with end of dictionary case */

            if (word_index >= (int) dictionary_size)
                word_index = dictionary_size - 1;
        } else {
            word_index -= chop;

            /* Deal with start of dictionary case */

            if (word_index < 0)
                word_index = 0;
        }
    }

    return (0);

}/* find_word */

/*
 * get_line
 *
 * Read a line of input and lower case it.
 *
 */

/* Get rid of macro tolower because of side effects */

#ifdef tolower
#undef tolower
#endif

#ifdef __STDC__
static void get_line (char *buffer)
#else
static void get_line (buffer)
char *buffer;
#endif
{
    const char *srcp;
    char *destp, columns;
    int i;

    /* Set maximum line width to width of screen */

    columns = (screen_cols > 127) ? 127 : screen_cols;
    if (buffer[0] <= (columns - RIGHT_MARGIN - 1))
        input[0] = buffer[0];
    else
        input[0] = (columns - RIGHT_MARGIN - 1);

    /* Read the line */

    input_line ();

    /* Convert line to lowercase */

    srcp = &input[2];
    destp = &buffer[1];
    for (i = 0; i < input[1]; i++)
        *destp++ = (char) tolower (*srcp++);

    /* Zero terminate line */

    *destp = '\0';

}/* get_line */
