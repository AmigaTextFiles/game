/*
 * text.c
 *
 * Text manipulation routines
 *
 * Mark Howell 28-Jul-1992 V1.0
 *
 */

#include "ztypes.h"

static const char *lookup_table[3] = {
    "abcdefghijklmnopqrstuvwxyz",
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
    "\n 0123456789.,!?_#'\"/\\-:()"
};
static int saved_format_mode = ON;
static int line_pos = 0;
static int story_redirect = OFF;
static int story_buffer = 0;
static int story_pos = 0;
static int story_count = 0;

/*
 * decode_text
 *
 * Convert encoded text to ASCII. Text is encoded by squeezing each character
 * into 5 bits. 3 x 5 bit encoded characters can fit in one word with a spare
 * bit left over. The spare bit is used to signal to end of a string. The 5 bit
 * encoded characters can either be actual character codes or prefix codes that
 * modifier the following code.
 *
 */

#ifdef __STDC__
void decode_text (unsigned long *address)
#else
void decode_text (address)
unsigned long *address;
#endif
{
    int i, synonym_flag = 0, ascii_flag = 0;
    short data, code, sindex = 0;
    short prefix = 0, saved_prefix = 0;
    unsigned long addr;

    /* Loop until high bit set in word */

    do {

        /* Load a word */

        data = read_data_word (address);

        /* Parse each 5 bit code in a word */

        for (i = 10; i >= 0; i -= 5) {
            code = (data >> i) & 0x1f;

            /* If the synonym flag is set then the code specifies a longer
               string which needs to be decoded to get the text */

            if (synonym_flag) {
                synonym_flag = 0;
                addr = (unsigned long) get_word (h_synonyms_offset + sindex + (code * 2)) * 2;
                decode_text (&addr);
                prefix = saved_prefix;
            } else {

                /* If the ascii flag is set then we have an ascii character that
                   is composed of 3 bits from the previous code and 5 bits from
                   the current code to make an 8 bit character */

                if (ascii_flag || prefix == 3) {
                    if (ascii_flag) {
                        ascii_flag = 0;
                        write_char ((char) (((prefix & 3) << 5) | code));
                        prefix = saved_prefix;
                    } else {
                        ascii_flag = 1;
                        prefix = code;
                    }
                } else {
                    if (code >= 6) {
                        if (prefix == 2 && code <= 7) {
                            if (code != 7)
                                prefix++;
                            else {

                                /* Output a newline */

                                flush_buffer (TRUE);
                                prefix = saved_prefix;
                            }
                        } else {

                            /* Convert encoded character to ascii */

                            write_char (lookup_table[prefix][code - 6]);
                            prefix = saved_prefix;
                        }
                    } else {
                        if (code == 0) {

                            /* Output a space */

                            write_char (' ');
                            prefix = saved_prefix;
                        } else {
                            if (code <= 3) {

                                /* Calculate a synonym index */

                                synonym_flag = 1;
                                sindex = (code - 1) * 64;
                            } else {
                                code -= 3;
                                if (prefix == 0)
                                    prefix = code;
                                else {
                                    if (code != prefix)
                                        prefix = 0;
                                    saved_prefix = prefix;
                                }
                            }
                        }   
                    }
                }
            }
        }
    } while (data >= 0);

}/* decode_text */

/*
 * character_to_prefix
 *
 * Convert a character to a prefix type for encoding.
 *
 */

#ifdef __STDC__
static char character_to_prefix (char c)
#else
static char character_to_prefix (c)
char c;
#endif
{
    int i;

    for (i = 0; i < 3; i++)
        if (strchr (lookup_table[i], c) != NULL)
            return ((char) i);

    return (2);

}/* character_to_prefix */

/*
 * character_to_code
 *
 * Convert a character to an encoded character.
 *
 */

#ifdef __STDC__
static char character_to_code (char c)
#else
static char character_to_code (c)
char c;
#endif
{
    int i;
    const char *cp;

    for (i = 0; i < 3; i++)
        if ((cp = strchr (lookup_table[i], c)) != NULL)
            return ((char) ((cp - lookup_table[i]) + 6));

    return (0);

}/* character_to_code */

/*
 * encode_text
 *
 * Pack a string into upto 9 codes or 3 words.
 *
 */

#ifdef __STDC__
void encode_text (int len, const char *s, short *buffer)
#else
void encode_text (len, s, buffer)
int len;
const char *s;
short *buffer;
#endif
{
    int i;
    char code, codes[9];

    for (i = 9; i; s++) {
        if (len-- > 0) {

            /* Calculate prefix for this character */

            code = character_to_prefix (*s);

            /* Store prefix + 3 if enough room and prefix is non zero */

            if (i && code)
                codes[--i] = code + (char) 3;

            /* Calculate code for this character */

            code = character_to_code (*s);

            /* Store code + 6 if enough room and code is non zero */

            if (i && code)
                codes[--i] = code;
            else {

                /* Store and ascii character as prefix (6) + high 3 bits + low 5 bits */

                if (i)
                    codes[--i] = 6;
                if (i)
                    codes[--i] = (char) (*s >> 5) & (char) 0x07;
                if (i)
                    codes[--i] = *s & (char) 0x1f;
            }
        } else

            /* Fill remaining space with code 5 */

            codes[--i] = 5;
    }

    /* Pack codes into buffer */

    buffer[0] = ((short) codes[8] << 10) | ((short) codes[7] << 5) | (short) codes[6];
    buffer[1] = ((short) codes[5] << 10) | ((short) codes[4] << 5) | (short) codes[3];
    buffer[2] = ((short) codes[2] << 10) | ((short) codes[1] << 5) | (short) codes[0];

    /* Set end of string terminator bit */

    if (h_type == V3)
        buffer[1] |= 0x8000;
    else
        buffer[2] |= 0x8000;

}/* encode_text */

/*
 * write_char
 *
 * High level character output routine. The write_char routine is slightly
 * complicated by the fact that the output can be limited by a fixed character
 * count, as well as, filling up the buffer.
 *
 */

#ifdef __STDC__
void write_char (char c)
#else
void write_char (c)
char c;
#endif
{
    char *cp;
    int cc;

    /* Only do if text formatting is turned on */

    if (format_mode == ON) {

        /* Put the character into the buffer and count it */

        line[line_pos++] = c;
        char_count--;

        /* Check to see if we have reached the right margin or exhausted our
           buffer space */

        if (fit_line (line, line_pos, screen_cols - RIGHT_MARGIN) == 0 || char_count == 0) {

            /* Null terminate the line */

            line[line_pos] = '\0';

            /* Find the last space character */

            cp = strrchr (line, ' ');

            /* If no space or space at the beginning of the line just output the
               whole line */

            if (cp == NULL || cp == line) {

                /* If character count exhausted then just output the line,
                   otherwise preserve the character count */

                if (char_count == 0) {
                    line[0] = '\0';
                    flush_buffer (TRUE);
                } else {
                    cc = char_count;
                    flush_buffer (TRUE);
                    char_count = cc;
                }

                /* Don't bother printing a space at the start of the line */

                if (c == ' ')
                    return;
            } else {

                /* Output up to the space and then put the remainder of the
                   line at the beginning of the buffer */

                *cp++ = '\0';
                cc = &line[line_pos] - cp;
                flush_buffer (TRUE);
                line_pos = cc;
                memmove (line, cp, line_pos);
                char_count = (screen_cols - RIGHT_MARGIN) - line_pos;
            }
        }
    } else if (story_redirect == ON) {

        /* If redirect is on then write the character to the status line for V3
           games or into the writeable data area for V4+ games */

        if (h_type == V3)
            status_line[status_pos++] = c;
        else {
            set_byte (story_pos++, c);
            story_count++;
        }
    } else

        /* No formatting or output redirection, so just output the character */

        output_char (c);

}/* write_char */

/*
 * set_video_attribute
 *
 * Set a video attribute. Write the video mode, from 0 to 4, incremented.
 * This is so the output routines don't confuse video attribute 0 as the
 * end of the string.
 *
 */

#ifdef __STDC__
void set_video_attribute (zword_t mode)
#else
void set_video_attribute (mode)
zword_t mode;
#endif
{

    write_char ((char) ++mode);

}/* set_video_attribute */

/*
 * write_string
 *
 * Output a string
 *
 */

#ifdef __STDC__
void write_string (const char *s)
#else
void write_string (s)
const char *s;
#endif
{

    while (*s)
        write_char (*s++);

}/* write_string */

/*
 * flush_buffer
 *
 * Send output buffer to the screen.
 *
 */

#ifdef __STDC__
void flush_buffer (int flag)
#else
void flush_buffer (flag)
int flag;
#endif
{

    /* Terminate the line */

    line[line_pos] = '\0';

    /* If flag is set then output followed by a new line */

    if (flag == TRUE)
        output_stringnl (line);
    else
        output_string (line);

    /* Reset the buffer pointer and character count */

    line_pos = 0;
    char_count = screen_cols - RIGHT_MARGIN;

}/* flush_buffer */

/*
 * set_format_mode
 *
 * Set the format mode flag. Formatting disables writing into the output buffer.
 *
 */

#ifdef __STDC__
void set_format_mode (zword_t flag)
#else
void set_format_mode (flag)
zword_t flag;
#endif
{

    /* If flag is set then turn on formatting */

    if (flag)
        format_mode = ON;
    else {

        /* If the flag is clear then turn off formatting and output the current
           line buffer without resetting the character count */

        format_mode = OFF;
        line[line_pos] = '\0';
        output_string (line);
        line_pos = 0;
    }

}/* set_format_mode */

/*
 * set_print_modes
 *
 * Set various printing modes. These can be: disabling output, scripting and
 * redirecting output. Redirection is peculiar. I use it to format the status
 * line for V3 games, otherwise it wasn't used. V4 games format the status line
 * themselves in an internal buffer in the writeable data area. To use the normal
 * text decoding routines they have to redirect output to the writeable data
 * area. This is done by passing in a buffer pointer. The first word of the
 * buffer will receive the number of characters written since the output was
 * redirected. The remainder of the buffer will contain the redirected text.
 *
 */

#ifdef __STDC__
void set_print_modes (zword_t type, zword_t option)
#else
void set_print_modes (type, option)
zword_t type;
zword_t option;
#endif
{

    if ((short) type == 1) {

        /* Turn on text output */

        output_enable = ON;
    } else if ((short) type == 2) {

        /* Turn on scripting */

        if ((get_word (H_FLAGS) & SCRIPTING_FLAG) == OFF)
            open_script ();
        set_word (H_FLAGS, SCRIPTING_FLAG);
    } else if ((short) type == 3) {

        /* Redirect text output */

        /* Disable text formatting during redirection */

        saved_format_mode = format_mode;
        format_mode = OFF;

        /* Enable text redirection */

        story_redirect = ON;

        /* Set up the redirection pointers */

        if (h_type == V3)
            status_pos = 0;
        else {
            story_count = 0;
            story_buffer = option;
            story_pos = option + 2;
        }
    } else if ((short) type == -1) {

        /* Turn off text output */

        output_enable = OFF;
    } else if ((short) type == -2) {

        /* Turn off scripting */

        if ((get_word (H_FLAGS) & SCRIPTING_FLAG) == ON)
            close_script ();
        set_word (H_FLAGS, get_word (H_FLAGS) & (~SCRIPTING_FLAG));
    } else if ((short) type == -3) {

        /* Cancel text output redirection */

        if (story_redirect == ON) {

            /* Restore the format mode and turn off redirection */

            format_mode = saved_format_mode;
            story_redirect = OFF;

            /* Terminate the redirection buffer and store the count of character
               in the buffer into the first word of the buffer */

            if (h_type != V3) {
                set_word (story_buffer, story_count);
                set_byte (story_pos, '\0');
            }
        }
    }

}/* set_print_modes */

/*
 * print_character
 *
 * Write a character.
 *
 */

#ifdef __STDC__
void print_character (zword_t c)
#else
void print_character (c)
zword_t c;
#endif
{

    write_char ((char) c);

}/* print_character */

/*
 * print_number
 *
 * Write a signed number.
 *
 */

#ifdef __STDC__
void print_number (zword_t num)
#else
void print_number (num)
zword_t num;
#endif
{
    int i, count;
    char buffer[10];

    i = (short) num;
    sprintf (buffer, "%d", i);
    count = strlen (buffer);
    for (i = 0; i < count; i++)
        write_char (buffer[i]);

}/* print_number */

/*
 * print_address
 *
 * Print using a packed address. Packed addresses are used to save space and
 * reference addresses outside of the data region.
 *
 */

#ifdef __STDC__
void print_address (zword_t packed_address)
#else
void print_address (packed_address)
zword_t packed_address;
#endif
{
    unsigned long address;

    /* Convert packed address to real address */

    address = (unsigned long) packed_address * story_scaler;

    /* Decode and output text at address */

    decode_text (&address);

}/* print_address */

/*
 * print_offset
 *
 * Print using a real address. Real addresses are just offsets into the
 * data region.
 *
 */

#ifdef __STDC__
void print_offset (zword_t offset)
#else
void print_offset (offset)
zword_t offset;
#endif
{
    unsigned long address;

    address = offset;

    /* Decode and output text at address */

    decode_text (&address);

}/* print_offset */

/*
 * print_object
 *
 * Print an object description. Object descriptions are stored as ASCIC
 * strings at the front of the property list for the object.
 *
 */

#ifdef __STDC__
void print_object (zword_t obj)
#else
void print_object (obj)
zword_t obj;
#endif
{
    zword_t offset;
    unsigned long address;

    /* Calculate address of property list */

    offset = get_object_address (obj);
    offset += (h_type == V3) ? O3_PROPERTY_OFFSET : O4_PROPERTY_OFFSET;

    /* Read the property list address and skip the count byte */

    address = (unsigned long) get_word (offset) + 1;

    /* Decode and output text at address */

    decode_text (&address);

}/* print_object */

/*
 * print_literal
 *
 * Print the string embedded in the instruction stream at this point. All
 * strings that do not need to be referenced by address are embedded in the
 * instruction stream. All strings that can be refered to by address are placed
 * at the end of the code region and referenced by packed address.
 *
 */

#ifdef __STDC__
void print_literal (void)
#else
void print_literal ()
#endif
{

    /* Decode and output text at PC */

    decode_text (&pc);

}/* print_literal */

/*
 * println_return
 *
 * Print a string embedded in the instruction stream as with print_literal,
 * except flush the output buffer and write a new line. After this return from
 * the current subroutine with a status of true.
 *
 */

#ifdef __STDC__
void println_return (void)
#else
void println_return ()
#endif
{

    print_literal ();
    new_line ();
    ret (TRUE);

}/* println_return */

/*
 * new_line
 *
 * Simply flush the current contents of the output buffer followed by a new
 * line.
 *
 */

#ifdef __STDC__
void new_line (void)
#else
void new_line ()
#endif
{

    flush_buffer (TRUE);

}/* new_line */

/*
 * print_time
 *
 * Print the time as HH:MM [am|pm]. This is a bit language dependent and can
 * quite easily be changed. If you change the size of the time string output
 * then adjust the status line position in display_status_line.
 *
 */

#ifdef __STDC__
void print_time (int hours, int minutes)
#else
void print_time (hours, minutes)
int hours;
int minutes;
#endif
{
    int pm_indicator;

    /* Remember if time is pm */

    pm_indicator = (hours < 12) ? OFF : ON;

    /* Convert 24 hour clock to 12 hour clock */

    hours %= 12;
    if (hours == 0)
        hours = 12;

    /* Write hour right justified */

    if (hours < 10)
        write_char (' ');
    print_number (hours);

    /* Write hours/minutes separator */

    write_char (':');

    /* Write minutes zero filled */

    if (minutes < 10)
        write_char ('0');
    print_number (minutes);

    /* Write the am or pm string */

    if (pm_indicator == ON)
        write_string (" pm");
    else
        write_string (" am");

}/* print_time */
