/*
 * ztypes.h
 *
 * Any global stuff required by the C modules.
 *
 */

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <ctype.h>

/* Configuration options */

#define RIGHT_MARGIN 0 /* # of characters in right margin */
#define TOP_MARGIN 2   /* # of lines left on screen before [MORE] message */

/* Global defines */

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#ifndef FILENAME_MAX
#define FILENAME_MAX 255
#endif

#ifndef EXIT_SUCCESS
#define EXIT_SUCCESS 0
#endif

#ifndef EXIT_FAILURE
#define EXIT_FAILURE 1
#endif

#ifndef SEEK_SET
#define SEEK_SET 0
#endif

#ifndef SEEK_END
#define SEEK_END 2
#endif

#ifdef unix

#define strchr(a, b) index (a, b)
#define memmove(a, b, c) bcopy (b, a, c)

#define const

#endif /* unix */

/* Z types */

typedef unsigned char zbyte_t;  /* unsigned 1 byte quantity */
typedef unsigned short zword_t; /* unsigned 2 byte quantity */

/* Data file header format */

typedef struct zheader {
    zbyte_t type;
    zbyte_t config;
    zword_t version;
    zword_t data_size;
    zword_t start_pc;
    zword_t words_offset;
    zword_t objects_offset;
    zword_t globals_offset;
    zword_t restart_size;
    zword_t flags;
    zbyte_t release_data[6];
    zword_t synonyms_offset;
    zword_t file_size;
    zword_t checksum;
    zbyte_t interpreter;
    zbyte_t interpreter_version;
    zbyte_t screen_rows;
    zbyte_t screen_columns;
    zword_t filler[15];
} zheader_t;

#define H_TYPE 0
#define H_CONFIG 1

#define CONFIG_BYTE_SWAPPED 0x01 /* Game data is byte swapped */
#define CONFIG_TIME         0x02 /* Status line displays time */
#define CONFIG_TANDY        0x08 /* Tandy licensed game         - V3 games */
#define CONFIG_UNDERSCORE   0x08 /* Screen supports underscores - V4 games */
#define CONFIG_NOSTATUSLINE 0x10 /* Interpreter cannot support a status line */
#define CONFIG_WINDOWS      0x20 /* Interpreter supports windows */

#define H_VERSION 2
#define H_DATA_SIZE 4
#define H_START_PC 6
#define H_WORDS_OFFSET 8
#define H_OBJECTS_OFFSET 10
#define H_GLOBALS_OFFSET 12
#define H_RESTART_SIZE 14
#define H_FLAGS 16

#define SCRIPTING_FLAG 0x01
#define FIXED_FONT_FLAG 0x02
#define SAVE_RESTORE_OK_FLAG 0x04
#define SOUND_FLAG 0x10
#define COLOUR_FLAG 0x40

#define H_RELEASE_DATE 18
#define H_SYNONYMS_OFFSET 24
#define H_FILE_SIZE 26
#define H_CHECKSUM 28
#define H_INTERPRETER 30
#define H_INTERPRETER_VERSION 31
#define H_SCREEN_ROWS 32
#define H_SCREEN_COLUMNS 33

/* Version 3 object format */

#define V3 3

typedef struct zobjectv3 {
    zword_t attributes[2];
    zbyte_t parent;
    zbyte_t next;
    zbyte_t child;
    zword_t property_offset;
} zobjectv3_t;

#define O3_ATTRIBUTES 0
#define O3_PARENT 4
#define O3_NEXT 5
#define O3_CHILD 6
#define O3_PROPERTY_OFFSET 7

#define O3_SIZE 9

#define PARENT3(offset) (offset + O3_PARENT)
#define NEXT3(offset) (offset + O3_NEXT)
#define CHILD3(offset) (offset + O3_CHILD)

#define P3_MAX_PROPERTIES 0x20

/* Version 4 object format */

#define V4 4

typedef struct zobjectv4 {
    zword_t attributes[3];
    zword_t parent;
    zword_t next;
    zword_t child;
    zword_t property_offset;
} zobjectv4_t;

#define O4_ATTRIBUTES 0
#define O4_PARENT 6
#define O4_NEXT 8
#define O4_CHILD 10
#define O4_PROPERTY_OFFSET 12

#define O4_SIZE 14

#define PARENT4(offset) (offset + O4_PARENT)
#define NEXT4(offset) (offset + O4_NEXT)
#define CHILD4(offset) (offset + O4_CHILD)

#define P4_MAX_PROPERTIES 0x40

/* Local defines */

#define PAGE_SIZE 512
#define PAGE_MASK 511
#define PAGE_SHIFT 9

#define STACK_SIZE 512

#define ON 1
#define OFF 0
#define RESET -1

#define TEXT_WINDOW 0
#define STATUS_WINDOW 1

#define NORMAL 0
#define REVERSE 1
#define BOLD 2
#define BLINK 3
#define UNDERSCORE 4
#define NONE 5

#define GAME_RESTORE 0
#define GAME_SAVE 1
#define GAME_SCRIPT 2

/* Data access macros */

#define get_byte(offset) ((zbyte_t) datap[offset])
#define get_word(offset) ((zword_t) (((zword_t) datap[offset] << 8) + (zword_t) datap[offset + 1]))
#define set_byte(offset,value) datap[offset] = (zbyte_t) (value)
#define set_word(offset,value) datap[offset] = (zbyte_t) ((zword_t) (value) >> 8), datap[offset + 1] = (zbyte_t) ((zword_t) (value) & 0xff)

/* External data */

extern zbyte_t h_type;
extern zword_t h_version;
extern zword_t h_data_size;
extern zword_t h_start_pc;
extern zword_t h_words_offset;
extern zword_t h_objects_offset;
extern zword_t h_globals_offset;
extern zword_t h_restart_size;
extern zword_t h_synonyms_offset;
extern zword_t h_file_size;
extern zword_t h_checksum;

extern int story_scaler;
extern int story_shift;
extern int property_mask;
extern int property_size_mask;

extern zword_t stack[STACK_SIZE];
extern zword_t sp;
extern zword_t fp;
extern unsigned long pc;

extern unsigned int data_size;
extern zbyte_t *datap;

extern int entry_size;
extern unsigned int dictionary_size;
extern unsigned int dictionary_offset;
extern char punctuation[];

extern int screen_rows;
extern int screen_cols;

extern int window;

extern int format_mode;
extern int output_enable;
extern int scripting_disable;

extern int status_active;
extern int status_size;

extern int lines_written;
extern int char_count;
extern int status_pos;

extern char *line;
extern char *input;
extern char *status_line;

extern char *restore_name;

/* Global routines */

/* control.c */

#ifdef __STDC__
void call (int, zword_t *);
void jump (zword_t);
void pop (void);
void pop_ret (void);
void restart (void);
void ret (zword_t);
#else
void call ();
void jump ();
void pop ();
void pop_ret ();
void restart ();
void ret ();
#endif

/* fileio.c */

#ifdef __STDC__
int get_story_size (void);
int restore (void);
int save (void);
int save_restore (const char *, int);
void close_script (void);
void close_story (void);
void open_script (void);
void open_story (const char *);
void read_page (int, void *);
void script_char (char);
void script_line (const char *);
void script_nl (void);
void verify (void);
#else
int get_story_size ();
int restore ();
int save ();
int save_restore ();
void close_script ();
void close_story ();
void open_script ();
void open_story ();
void read_page ();
void script_char ();
void script_line ();
void script_nl ();
void verify ();
#endif

/* input.c */

#ifdef __STDC__
void read_character (int, zword_t *);
void read_line (int, zword_t *);
#else
void read_character ();
void read_line ();
#endif

/* interpre.c */

#ifdef __STDC__
void interpret (void);
#else
void interpret ();
#endif

/* math.c */

#ifdef __STDC__
void add (zword_t, zword_t);
void and (zword_t, zword_t);
void compare_je (int, zword_t *);
void compare_jg (zword_t, zword_t);
void compare_jl (zword_t, zword_t);
void compare_zero (zword_t);
void divide (zword_t, zword_t);
void multiply (zword_t, zword_t);
void not (zword_t);
void or (zword_t, zword_t);
void random (zword_t);
void remainder (zword_t, zword_t);
void subtract (zword_t, zword_t);
void test (zword_t, zword_t);
#else
void add ();
void and ();
void compare_je ();
void compare_jg ();
void compare_jl ();
void compare_zero ();
void divide ();
void multiply ();
void not ();
void or ();
void random ();
void remainder ();
void subtract ();
void test ();
#endif

/* memory.c */

#ifdef __STDC__
void load_cache (void);
void unload_cache (void);
zbyte_t read_code_byte (void);
zbyte_t read_data_byte (unsigned long *);
zword_t read_code_word (void);
zword_t read_data_word (unsigned long *);
#else
void load_cache ();
void unload_cache ();
zbyte_t read_code_byte ();
zbyte_t read_data_byte ();
zword_t read_code_word ();
zword_t read_data_word ();
#endif

/* object.c */

#ifdef __STDC__
void clear_attr (zword_t, zword_t);
void compare_parent_object (zword_t, zword_t);
void insert_object (zword_t, zword_t);
void load_child_object (zword_t);
void load_next_object (zword_t);
void load_parent_object (zword_t);
void remove_object (zword_t);
void set_attr (zword_t, zword_t);
void test_attr (zword_t, zword_t);
zword_t get_object_address (zword_t);
#else
void clear_attr ();
void compare_parent_object ();
void insert_object ();
void load_child_object ();
void load_next_object ();
void load_parent_object ();
void remove_object ();
void set_attr ();
void test_attr ();
zword_t get_object_address ();
#endif

/* operand.c */

#ifdef __STDC__
void conditional_jump (int);
void store_operand (zword_t);
void store_variable (int, zword_t);
zword_t load_operand (int);
zword_t load_variable (int);
#else
void conditional_jump ();
void store_operand ();
void store_variable ();
zword_t load_operand ();
zword_t load_variable ();
#endif

/* osdepend.c */

#ifdef __STDC__
void process_arguments (int, char *[]);
void file_cleanup (const char *, int);
void sound (int, zword_t *);
int get_file_name (char *, char *, int);
#else
void process_arguments ();
void file_cleanup ();
void sound ();
int get_file_name ();
#endif

/* property.c */

#ifdef __STDC__
void load_byte (zword_t, zword_t);
void load_next_property (zword_t, zword_t);
void load_property (zword_t, zword_t);
void load_property_address (zword_t, zword_t);
void load_property_length (zword_t);
void load_word (zword_t, zword_t);
void scan_word (zword_t, zword_t, zword_t);
void store_byte (zword_t, zword_t, zword_t);
void store_property (zword_t, zword_t, zword_t);
void store_word (zword_t, zword_t, zword_t);
#else
void load_byte ();
void load_next_property ();
void load_property ();
void load_property_address ();
void load_property_length ();
void load_word ();
void scan_word ();
void store_byte ();
void store_property ();
void store_word ();
#endif

/* screen.c */

#ifdef __STDC__
void blank_status_line (void);
void display_status_line (void);
void erase_line (zword_t);
void erase_window (zword_t);
void output_char (char);
void output_nl (void);
void output_string (const char *);
void output_stringnl (const char *);
void select_window (zword_t);
void set_cursor_position (zword_t, zword_t);
void set_status_size (zword_t);
#else
void blank_status_line ();
void display_status_line ();
void erase_line ();
void erase_window ();
void output_char ();
void output_nl ();
void output_string ();
void output_stringnl ();
void select_window ();
void set_cursor_position ();
void set_status_size ();
void set_video_attribute ();
#endif

/* screenio.c */

#ifdef __STDC__
char input_character (void);
void clear_line (void);
void clear_screen (void);
void clear_status_window (void);
void clear_text_window (void);
void create_status_window (void);
void delete_status_window (void);
void display_char (int);
void fatal (const char *);
int fit_line (const char *, int, int);
void initialize_screen (void);
void input_line (void);
void move_cursor (int, int);
int print_status (int, char *[]);
void reset_screen (void);
void restart_screen (void);
void restore_cursor_position (void);
void save_cursor_position (void);
void scroll_line (void);
void select_status_window (void);
void select_text_window (void);
void set_attribute (int);
#else
char input_character ();
void clear_line ();
void clear_screen ();
void clear_status_window ();
void clear_text_window ();
void create_status_window ();
void delete_status_window ();
void display_char ();
void fatal ();
int fit_line ();
void initialize_screen ();
void input_line ();
void move_cursor ();
int print_status ();
void reset_screen ();
void restart_screen ();
void restore_cursor_position ();
void save_cursor_position ();
void scroll_line ();
void select_status_window ();
void select_text_window ();
void set_attribute ();
#endif

/* text.c */

#ifdef __STDC__
void decode_text (unsigned long *);
void encode_text (int, const char *, short *);
void flush_buffer (int);
void new_line (void);
void print_address (zword_t);
void print_character (zword_t);
void print_literal (void);
void print_number (zword_t);
void print_object (zword_t);
void print_offset (zword_t);
void print_time (int, int);
void println_return (void);
void set_format_mode (zword_t);
void set_print_modes (zword_t, zword_t);
void set_video_attribute (zword_t);
void write_char (char);
void write_string (const char *);
#else
void decode_text ();
void encode_text ();
void flush_buffer ();
void new_line ();
void print_address ();
void print_character ();
void print_literal ();
void print_number ();
void print_object ();
void print_offset ();
void print_time ();
void println_return ();
void set_format_mode ();
void set_print_modes ();
void set_video_attribute ();
void write_char ();
void write_string ();
#endif

/* variable.c */

#ifdef __STDC__
void decrement (zword_t);
void decrement_check (zword_t, zword_t);
void increment (zword_t);
void increment_check (zword_t, zword_t);
void load (zword_t);
void pop_var (zword_t);
void push_var (zword_t);
#else
void decrement ();
void decrement_check ();
void increment ();
void increment_check ();
void load ();
void pop_var ();
void push_var ();
#endif
