/* infocom.h
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
 * $Header: RCS/infocom.h,v 3.0 1992/10/21 16:56:19 pds Stab $
 */

/*
 *      STANDARD SERIES INFOCOM INTERPRETER
 */

#define VERSION     3

#include <stdio.h>

#ifdef USE_DBMALLOC
#include <sys/types.h>
#include "dbmalloc.h"
#endif

/*
 * Universal Type Definitions.
 *
 *  'byte'                  - 8 bits       ; unsigned.
 *  'word'                  - 16 bits      ; unsigned.
 *  'signed_word'           - 16 bits      ; signed.
 *  'long_word'             - 32 bits      ; signed.
 */

#define         byte            unsigned char
#define         word            unsigned short
#define         signed_word     short
#define         long_word       long

/*
 * Constants
 */
#ifndef MAXPATHLEN
#define         MAXPATHLEN              1024
#endif

#define         LOCAL_VARS              0x10
#define         STACK_SIZE              0x0200
#define         BLOCK_SIZE              0x0200
#define         MAX_MEM                 0xFFFF

/*
 * Game State Codes
 */

#define         NOT_INIT                0x00 /* Must be 0 */
#define         INIT_GAME               0x01
#define         PLAY_GAME               0x02
#define         RESTART_GAME            0x03
#define         LOAD_GAME               0x04
#define         QUIT_GAME               0x05

/*
 * scr_*_sf() Type Codes
 */

#define         SF_SAVE                 0x00
#define         SF_RESTORE              0x01
#define         SF_SCRIPT               0x02

/*
 * ANSI C compatibility stuff
 */

#if defined(__STDC__) || defined(__TURBOC__)

typedef void *  ptr_t;
#define P(s)    s

#define A1(t,v) (t v)
#define A2(t1,v1,t2,v2) \
                (t1 v1,t2 v2)
#define A3(t1,v1,t2,v2,t3,v3) \
                (t1 v1,t2 v2,t3 v3)
#define A4(t1,v1,t2,v2,t3,v3,t4,v4) \
                (t1 v1,t2 v2,t3 v3,t4 v4)
#define A5(t1,v1,t2,v2,t3,v3,t4,v4,t5,v5) \
                (t1 v1,t2 v2,t3 v3,t4 v4,t5 v5)
#define A6(t1,v1,t2,v2,t3,v3,t4,v4,t5,v5,t6,v6) \
                (t1 v1,t2 v2,t3 v3,t4 v4,t5 v5,t6 v6)

#else

typedef char *  ptr_t;

#if !defined(sun)
#define void    int
#endif

#define const
#define P(s)    ()

#define A1(t,v) (v) t v;
#define A2(t1,v1,t2,v2) \
                (v1,v2)t1 v1;t2 v2;
#define A3(t1,v1,t2,v2,t3,v3) \
                (v1,v2,v3)t1 v1;t2 v2;t3 v3;
#define A4(t1,v1,t2,v2,t3,v3,t4,v4) \
                (v1,v2,v3,v4)t1 v1;t2 v2;t3 v3;t4 v4;
#define A5(t1,v1,t2,v2,t3,v3,t4,v4,t5,v5) \
                (v1,v2,v3,v4,v5)t1 v1;t2 v2;t3 v3;t4 v4;t5 v5;
#define A6(t1,v1,t2,v2,t3,v3,t4,v4,t5,v5,t6,v6) \
                (v1,v2,v3,v4,v5,v6)t1 v1;t2 v2;t3 v3;t4 v4;t5 v5;t6 v6;

#endif

/*
 * Bitfield Macros:
 *
 * These macros modify the flag bits; they should be used instead of
 * direct bit-twiddling for the header flags fields.  They may only be
 * used after init() has been called.
 */
#define F1_IS_SET(_b)   (base_ptr[1]&(_b))
#define F1_SETB(_b)     (base_ptr[1]|=(_b))
#define F1_RESETB(_b)   (base_ptr[1]&=(~(_b)))

#define F2_IS_SET(_b)   (base_ptr[17]&(_b))
#define F2_SETB(_b)     (base_ptr[17]|=(_b))
#define F2_RESETB(_b)   (base_ptr[17]&=(~(_b)))

/*
 * These are possible bits to be examine in header.flags_1:
 */
#define B_USE_TIME      (0x02)              /* Readonly */
#define B_TANDY         (0x08)
#define B_ALT_PROMPT    (0x10)
#define B_STATUS_WIN    (0x20)

/*
 * These are possible bits to examine in header.flags_2:
 */
#define B_SCRIPTING     (0x01)
#define B_FIXED_FONT    (0x02)
#define B_SOUND         (0x10)


/*
 * Conversion Macros:
 *
 * These macros convert from data file info into the current machine's
 * byte order, etc.
 */
#define Z_TO_BYTE(_p)   ((byte)((_p)[0]&0xff))
#define Z_TO_WORD(_p)   ((word)((((_p)[0]&0xff)<<8)+((_p)[1]&0xff)))

#define Z_TO_BYTE_I(_p) ((byte)(*(_p++)&0xff))
#define Z_TO_WORD_I(_p) ((_p)+=2,((word)(((_p)[-2]&0xff)<<8)+((_p)[-1]&0xff)))

/*
 * Speed Macros:
 *
 * These macro-ize certain bottlenecks (discovered using the UNIX
 * utility prof(1)).  Use NEXT_BYTE() like a function returning void.
 */
#define NEXT_BYTE(_v) do{ extern word pc_offset; extern byte *prog_block_ptr;\
                          (_v)=Z_TO_BYTE(prog_block_ptr+pc_offset++);\
                          if(pc_offset==BLOCK_SIZE)fix_pc(); }while (0)

/*
 * Type Definitions
 */

typedef int     Bool;
typedef byte    *property;

/*
 * Global Flags Structure
 *
 * Contains flags and other information used globally by both the
 * interpreter and the terminal interface.
 */
typedef struct gflags
{
    const char  *filenm;                    /* Game file name */
    int         game_state;                 /* Game state */
    Bool        pr_attr;                    /* Print obj attr assignments */
    Bool        pr_atest;                   /* Print obj attr tests */
    Bool        pr_xfers;                   /* Print obj location xfers */
    Bool        pr_status;                  /* Print status line */
    Bool        paged;                      /* Page long output */
    Bool        echo;                       /* Echo input lines */
} gflags_t;

/*
 * File Information Structure
 *
 * This structure contains various interesing bits of information
 * related to the file we're examining.
 */
typedef struct file
{
    word    pages;
    word    offset;
} file_t;

/*
 * Object Structure Definition.
 *
 * Since version 4/5/6 objects are a different size than version 3
 * objects, we define both styles here.  The obj_addr() function will
 * use the information in the obj_info_t structure to find the object
 * list correctly.
 *
 * The interpreter code assumes ver. 3 style objects, but the higher
 * versions are understood for object listings.
 */
typedef struct obj_info
{
    byte    *obj_base;                      /* Start of obj table */
    int     obj_size;                       /* Size of each obj entry */
    int     obj_offset;                     /* start of objs */
    int     is_eobj;                        /* 0==v3 obj : 1==v4,5,6 obj */
} obj_info_t;

typedef struct object
{
    byte    attributes[4];
    byte    parent;
    byte    sibling;
    byte    child;
    byte    data[2];
} object_t;

typedef struct eobject
{
    byte    attributes[6];
    byte    parent[2];
    byte    sibling[2];
    byte    child[2];
    byte    data[2];
} eobject_t;

/*
 * Print Buffer Structure
 *
 *  buf     Points to the buffer to be filled in
 *  len     Current length of filled-in data
 *  max     The maximum size of the buffer (not including the nul char)
 */
typedef struct print_buf
{
    byte    *buf;
    int     len;
    int     max;
} print_buf_t;

/*
 * Infocom Game Header Structure
 *
 *  The 'z_version' byte has the following meaning:
 *      00 : Game compiled for an early version of the interpreter
 *      01 : Game compiled for an early version of the interpreter
 *      02 : Game compiled for an early version of the interpreter
 *      03 : Standard Series Interpreter
 *      04 : Plus Series Interpreter
 *      05 : Solid Gold Interactive Fiction
 *      06 : Graphic Interactive Fiction
 *
 *  The 'flags_1' byte contains the following information:
 *      Bit #   Usage                   CLEAR       SET
 *      -----   ---------------------   -----       -----
 *        0     Game Header             OK          Error
 *        1     Status Bar display      SCORE       TIME
 *        5     Save file indicator      ??          ??
 *
 *  The 'flags_2' word is used by Z-CODE to set printing modes
 *  for use by the interpreter:
 *      Bit #   Usage                   CLEAR       SET
 *      -----   ---------------------   -----       -----
 *       0      Script mode             OFF         ON
 *       1      Font type               -any-       fixed-width
 *       4      Sound                   NO          YES
 */

typedef struct header
{
        byte    z_version;              /* Game's Z-CODE Version Number    */
        byte    flags_1;                /* Status indicator flags          */
        word    release;                /* Game Release Number             */
        word    resident_bytes;         /* No. bytes in the Resident Area  */
        word    game_o;                 /* Offset to Start of Game         */
        word    vocab_o;                /* Offset to Vocab List            */
        word    object_o;               /* Offset to Object/Room List      */
        word    variable_o;             /* Offset to Global Variables      */
        word    save_bytes;             /* No. bytes in the Save Game Area */
        word    flags_2;                /* Z-CODE printing modes           */
        char    serial_no[6];           /* Game's Serial Number            */
        word    common_word_o;          /* Offset to Common Word List      */
        word    verify_length;          /* No. words in the Game File      */
        word    verify_checksum;        /* Game Checksum - used by Verify  */
        word    padding1[8];
        word    fkey_o;                 /* Fkey offset (?)                 */
        word    padding2[2];
        word    alphabet_o;             /* Offset of alternate alphabets   */
        word    padding3[5];
} header_t;

/*
 * Global Variables
 */

extern obj_info_t   objd;
extern gflags_t     gflags;
extern byte *       base_ptr;

/*
 * Function Prototypes
 */

#define E extern

/*
 * file.c
 */
E void          f_error P((int, const char *, const char *));
E void          read_header P((header_t *));
E const char *  open_file P((const char *));
E void          close_file P((void));
E void          load_page P((word, word, byte *));
E void          save P((void));
E void          restore P((void));
/*
 * funcs.c
 */
E void          plus P((word, word));
E void          minus P((word, word));
E void          multiply P((word, word));
E void          divide P((word, word));
E void          mod P((word, word));
E void          pi_random P((word));
E void          LTE P((word, word));
E void          GTE P((word, word));
E void          bit P((word, word));
E void          or P((word, word));
E void          not P((word));
E void          and P((word, word));
E void          compare P((word, const word *));
E void          cp_zero P((word));
/*
 * infocom.c
 */
E void          seed_random P((void));
/*
 * init.c
 */
E void          init P((void));
/*
 * input.c
 */
E void          ti_escape P((char *));
E void          input P((word, word));
/*
 * interp.c
 */
E void          interp P((void));
/*
 * jump.c
 */
E void          gosub P((word, const word *));
E void          rtn P((word));
E void          jump P((word));
E void          rts P((void));
E void          pop_stack P((void));
/*
 * object.c
 */
E void          transfer P((word, word));
E void          remove_obj P((word));
E void          test_attr P((word, word));
E void          set_attr P((word, word));
E void          clr_attr P((word, word));
E void          get_loc P((word));
E void          get_holds P((word));
E void          get_link P((word));
E void          check_loc P((word, word));
E object_t *    obj_addr P((word));
/*
 * options.c
 */
E void          check_version P((void));
E void          options P((Bool, Bool, Bool, Bool, Bool));
/*
 * page.c
 */
E void          pg_init P((void));
E byte *        fetch_page P((word));
E void          fix_pc P((void));
/*
 * print.c
 */
E const char *  chop_buf P((const char *, int));
E void          print_init P((void));
E void          print_num P((word));
E char *        print_hnum P((word));
E void          print_str P((const char *));
E void          print2 P((word));
E void          print1 P((word));
E void          p_obj P((word));
E void          wrt P((void));
E void          writeln P((void));
E void          new_line P((void));
E void          print_char P((word));
E void          prt_coded P((word *, word *));
E void          decode P((word));
E void          set_score P((void));
/*
 * property.c
 */
E void          next_prop P((word, word));
E void          put_prop P((word, word, word));
E void          get_prop P((word, word));
E void          get_prop_addr P((word, word));
E void          get_prop_len P((word));
E void          load_word_array P((word, word));
E void          load_byte_array P((word, word));
E void          save_word_array P((word, word, word));
E void          save_byte_array P((word, word, word));
/*
 * support.c
 */
E ptr_t         xmalloc P((unsigned int));
E ptr_t         xrealloc P((ptr_t, unsigned int));
E void          null P((void));
E void          change_status P((void));
E void          restart P((void));
E void          quit P((void));
E Bool          do_verify P((void));
E void          verify P((void));
E void          store P((word));
E void          ret_value P((word));
E void          error P((const char *, int));
E void          askq P((int));
E byte          get_byte P((word *, word *));
E word          get_word P((word *, word *));
E word          next_word P((void));
/*
 * variable.c
 */
E void          get_var P((word));
E word          load_var P((word));
E void          put_var P((word, word));
E void          push P((word));
E void          pop P((word));
E void          inc_var P((word));
E void          dec_var P((word));
E void          inc_chk P((word, word));
E void          dec_chk P((word, word));
E word          load P((int));
/*
 * Terminal interface functions
 */
E int           scr_cmdarg P((int, char ***));
E void          scr_getopt P((int, const char *));
E int           scr_setup P((int, int, int, int));
E void          scr_begin P((void));
E void          scr_putline P((const char *));
E void          scr_putscore P((void));
E void          scr_putsound P((int, int, int, int));
E void          scr_putmesg P((const char *, Bool));
E int           scr_getline P((const char *, int, char *));
E void          scr_window P((int));
E void          scr_set_win P((int));
E FILE *        scr_open_sf P((int, char *, int));
E void          scr_close_sf P((const char *, FILE *, int));
E void          scr_end P((void));
E void          scr_shutdown P((void));

#undef E
