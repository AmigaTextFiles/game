/*
 * extern.c
 *
 * Global data.
 *
 * Mark Howell 28-Jul-1992 V1.0
 *
 */

#include "ztypes.h"

/* Game header data */

zbyte_t h_type = 0;
zword_t h_version = 0;
zword_t h_data_size = 0;
zword_t h_start_pc = 0;
zword_t h_words_offset = 0;
zword_t h_objects_offset = 0;
zword_t h_globals_offset = 0;
zword_t h_restart_size = 0;
zword_t h_synonyms_offset = 0;
zword_t h_file_size = 0;
zword_t h_checksum = 0;

/* Game version specific data */

int story_scaler = 0;
int story_shift = 0;
int property_mask = 0;
int property_size_mask = 0;

/* Stack and PC data */

zword_t stack[STACK_SIZE];
zword_t sp = STACK_SIZE;
zword_t fp = STACK_SIZE - 1;
unsigned long pc = 0;

/* Data region data */

unsigned int data_size = 0;
zbyte_t *datap = NULL;

/* Dictionary data */

int entry_size = 0;
unsigned int dictionary_size = 0;
unsigned int dictionary_offset = 0;
char punctuation[16];

/* Screen size data */

int screen_rows = 24;
int screen_cols = 80;

/* Current window data */

int window = TEXT_WINDOW;

/* Formatting and output control data */

int format_mode = ON;
int output_enable = ON;
int scripting_disable = OFF;

/* Status region data */

int status_active = OFF;
int status_size = 0;

/* Text output buffer data */

int lines_written = 0;
int char_count = 0;
int status_pos = 0;

/* Dynamic buffer data */

char *line = NULL;
char *input = NULL;
char *status_line = NULL;

/* Name of the file to restore at the start of a game */

char *restore_name = NULL;
