/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.3"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 1

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     IF_PREC = 258,
     ELSE_TOK = 259,
     OR_TOK = 260,
     AND_TOK = 261,
     LE_TOK = 262,
     GE_TOK = 263,
     NE_TOK = 264,
     EQ_TOK = 265,
     BIS_TOK = 266,
     BITUNSET_ATOK = 267,
     BITSET_ATOK = 268,
     NEG_PREC = 269,
     INCLUDE_TOK = 270,
     BEGIN_CODE_TOK = 271,
     END_CODE_TOK = 272,
     SWITCH_TOK = 273,
     IF_TOK = 274,
     VAR_TOK = 275,
     BUSY_TOK = 276,
     ADD_TOK = 277,
     SUB_TOK = 278,
     MUL_TOK = 279,
     DIV_TOK = 280,
     MOD_TOK = 281,
     BITSET_TOK = 282,
     BITUNSET_TOK = 283,
     RND_TOK = 284,
     GGT_TOK = 285,
     BONUS_TOK = 286,
     MESSAGE_TOK = 287,
     SOUND_TOK = 288,
     EXPLODE_TOK = 289,
     DEFAULT_TOK = 290,
     DA_KIND_TOK = 291,
     FREMD_TOK = 292,
     REINWORT_TOK = 293,
     WORT_TOK = 294,
     NACHBAR8_TOK = 295,
     NACHBAR6_TOK = 296,
     NULLEINS_TOK = 297,
     ZAHL_TOK = 298,
     HALBZAHL_TOK = 299,
     BUCHSTABE_TOK = 300,
     PFEIL_TOK = 301
   };
#endif
/* Tokens.  */
#define IF_PREC 258
#define ELSE_TOK 259
#define OR_TOK 260
#define AND_TOK 261
#define LE_TOK 262
#define GE_TOK 263
#define NE_TOK 264
#define EQ_TOK 265
#define BIS_TOK 266
#define BITUNSET_ATOK 267
#define BITSET_ATOK 268
#define NEG_PREC 269
#define INCLUDE_TOK 270
#define BEGIN_CODE_TOK 271
#define END_CODE_TOK 272
#define SWITCH_TOK 273
#define IF_TOK 274
#define VAR_TOK 275
#define BUSY_TOK 276
#define ADD_TOK 277
#define SUB_TOK 278
#define MUL_TOK 279
#define DIV_TOK 280
#define MOD_TOK 281
#define BITSET_TOK 282
#define BITUNSET_TOK 283
#define RND_TOK 284
#define GGT_TOK 285
#define BONUS_TOK 286
#define MESSAGE_TOK 287
#define SOUND_TOK 288
#define EXPLODE_TOK 289
#define DEFAULT_TOK 290
#define DA_KIND_TOK 291
#define FREMD_TOK 292
#define REINWORT_TOK 293
#define WORT_TOK 294
#define NACHBAR8_TOK 295
#define NACHBAR6_TOK 296
#define NULLEINS_TOK 297
#define ZAHL_TOK 298
#define HALBZAHL_TOK 299
#define BUCHSTABE_TOK 300
#define PFEIL_TOK 301




/* Copy the first part of user declarations.  */
#line 2 "parser.yy"


/***************************************************************************
                          parser.yy  -  description
                             -------------------
    begin                : Mit Jul 12 22:54:51 MEST 2000
    copyright            : (C) 2000 by Immi
    email                : cuyo@pcpool.mathematik.uni-freiburg.de
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#include <cstdlib>

#include "cuyointl.h"
#include "code.h"
#include "fehler.h"
#include "knoten.h"
#include "variable.h"
#include "ort.h"
#include "version.h"
#include "global.h"
#include "leveldaten.h"
#include "sound.h"

#define YYMALLOC malloc
#define YYFREE free


/***********************************************************************/
/* Globale Parse-Variablen */

/** Für Fehlerausgabe: Aktueller Dateiname */
Str gDateiName;
/** Für Fehlerausgabe: Aktuelle Zeilen-Nummer */
int gZeilenNr;

/** True, wenn es während des Parsens (mindestens) einen Fehler gab. */
bool gGabFehler;


/** Wenn der Parser aufgerufen wird, muss in DefKnoten schon ein DefKnoten
    stehen, an den alles geparste angefügt wird. Normalerweise erzeugt man
    einen neuen Defknoten. Beim Includen will man da aber schon was drin
    haben.
    Siehe auch %type <defknoten> alles */
static DefKnoten * gAktDefKnoten;

//#define MAX_INCLUDE_TIEFE 16
/** YY_BUFFER_STATE ist ein flex-Datentyp für eine Datei, an der grade
    geparst wird. */
//static YY_BUFFER_STATE gIncludeStack[MAX_INCLUDE_TIEFE];
/** Aktuelle Include-Tiefe. (0 bei Hauptdatei) */
//static int gIncludeTiefe;

//static DefKnoten * gIncludeMerk;


/* Beim Erzeugen eines Codes müssen einige Variablen jedes Mal übergeben
   werden:
   - der zugehörige DefKnoten, damit ggf. noch Variablen reserviert werden
     können (genauer: die Busy-Variable).
   - Dateiname und Zeilennummer, damit der Code schönere Fehlermeldungen
     ausgeben kann.
   Damit ich das aber nicht jedes Mal eintippen muss, hier ein paar Macros:
 */
#define newCode0(ART) new Code(\
  gAktDefKnoten, gDateiName, gZeilenNr, ART)
#define newCode1(ART, X1) new Code(\
  gAktDefKnoten, gDateiName, gZeilenNr, ART, X1)
#define newCode2(ART, X1, X2) new Code(\
  gAktDefKnoten, gDateiName, gZeilenNr, ART, X1, X2)
#define newCode3(ART, X1, X2, X3) new Code(\
  gAktDefKnoten, gDateiName, gZeilenNr, ART, X1, X2, X3)
#define newCode4(ART, X1, X2, X3, X4) new Code(\
  gAktDefKnoten, gDateiName, gZeilenNr, ART, X1, X2, X3, X4)



/***********************************************************************/


#define VIEL 32767


/* PBEGIN_TRY und PEND_TRY() fangen Fehler ab und geben sie aus, damit
   weitergeparst werden kann und mehrere Fehler gleichzeitig ausgegeben
   werden können. Sie werden in fehler.h definiert. */


#define YYDEBUG 1


/* Bug in Bison? Er scheint den Stack nicht automatisch vergrößern zu wollen,
   wenn er voll ist. Es sieht so aus, als hätte er angst, dass da c++-Variablen
   vorkommen, wo er (wegen constructor und so) nicht einfach so rumalloziieren
   kann. (Ich weiß nicht, was der LTYPE ist, von dem er nicht festgestellt hat,
   das er trivial ist.) */
#define YYLTYPE_IS_TRIVIAL 1



/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 113 "parser.yy"
{
  Code * code;
  Code * codepaar[2];
  Str * str;
  int zahl;
  int zahlpaar[2];
  Knoten * knoten;
  DefKnoten * defknoten;
  ListenKnoten * listenknoten;
  WortKnoten * wortknoten;
  Variable * variable;
  Ort * ort;
  Version * version;
  CodeArt codeart;
  OrtHaelfte haelfte;
}
/* Line 187 of yacc.c.  */
#line 314 "parser.cc"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */
#line 208 "parser.yy"

int yyerror(const char * s);
int yylex(YYSTYPE * lvalPtr);

/** Wechselt die Lex-Datei temporär. Liefert was zurück, was an popLex
    übergeben werden muss, um wieder zurückzuschalten. Throwt evtl.
    setzdefault wird an den Pfaditerator übergeben.
    Wird in lex.ll definiert, weil da die nötigen Lex-Dinge definiert sind. */
void * pushLex(const char * na, bool setzdefault = false);
void popLex(void * merkBuf);


/* Line 216 of yacc.c.  */
#line 338 "parser.cc"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int i)
#else
static int
YYID (i)
    int i;
#endif
{
  return i;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  2
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   828

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  69
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  46
/* YYNRULES -- Number of rules.  */
#define YYNRULES  159
/* YYNRULES -- Number of states.  */
#define YYNSTATES  279

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   301

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    17,     2,     2,     2,    23,    24,     2,
      66,    67,    21,    18,     7,    19,    29,    22,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    20,     3,
      10,    62,    11,     2,    68,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    63,     2,     4,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    64,    25,    65,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     5,     6,
       8,     9,    12,    13,    14,    15,    16,    26,    27,    28,
      30,    31,    32,    33,    34,    35,    36,    37,    38,    39,
      40,    41,    42,    43,    44,    45,    46,    47,    48,    49,
      50,    51,    52,    53,    54,    55,    56,    57,    58,    59,
      60,    61
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     4,    10,    15,    19,    21,    23,    25,
      29,    30,    34,    36,    40,    41,    46,    48,    50,    54,
      56,    58,    62,    64,    66,    70,    73,    77,    81,    85,
      89,    93,    94,    97,   103,   107,   111,   113,   115,   117,
     121,   123,   127,   128,   131,   135,   137,   139,   141,   145,
     150,   152,   156,   161,   166,   173,   181,   185,   189,   191,
     193,   196,   198,   201,   202,   204,   211,   213,   218,   223,
     228,   230,   234,   236,   238,   240,   242,   244,   246,   248,
     250,   252,   255,   258,   260,   263,   265,   270,   278,   284,
     286,   290,   294,   296,   298,   300,   302,   306,   308,   310,
     314,   318,   321,   325,   329,   333,   337,   341,   345,   349,
     353,   357,   361,   365,   369,   373,   377,   381,   384,   388,
     392,   396,   401,   408,   411,   414,   418,   420,   422,   424,
     427,   429,   431,   433,   435,   437,   439,   440,   442,   443,
     445,   449,   451,   455,   461,   462,   464,   465,   467,   471,
     473,   477,   483,   486,   489,   491,   493,   495,   498,   500
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      70,     0,    -1,    -1,    70,    97,    73,    62,    75,    -1,
      70,    31,    80,    32,    -1,    70,    30,    97,    -1,    98,
      -1,   112,    -1,    71,    -1,    71,     7,    72,    -1,    -1,
      63,    72,     4,    -1,   114,    -1,    10,    79,    11,    -1,
      -1,    64,    76,    70,    65,    -1,    77,    -1,    78,    -1,
      77,     7,    78,    -1,    97,    -1,    74,    -1,    97,    21,
      74,    -1,   112,    -1,    98,    -1,    66,    79,    67,    -1,
      19,    79,    -1,    79,    18,    79,    -1,    79,    19,    79,
      -1,    79,    21,    79,    -1,    79,    22,    79,    -1,    79,
      23,    79,    -1,    -1,    80,    81,    -1,    82,    73,    62,
      91,     3,    -1,    35,    83,     3,    -1,    50,    88,     3,
      -1,    97,    -1,    60,    -1,    86,    -1,    83,     7,    86,
      -1,    79,    -1,    79,    20,    51,    -1,    -1,    62,    84,
      -1,    87,    73,    85,    -1,    98,    -1,    60,    -1,    89,
      -1,    88,     7,    89,    -1,    87,    73,    62,    84,    -1,
      91,    -1,    91,     3,    90,    -1,    33,    64,    96,    65,
      -1,    34,    99,    61,    91,    -1,    34,    99,    61,    91,
       6,    91,    -1,    34,    99,    61,    91,     6,    61,    91,
      -1,    64,    90,    65,    -1,    91,     7,    91,    -1,   112,
      -1,    95,    -1,   112,    95,    -1,    97,    -1,    24,    97,
      -1,    -1,    92,    -1,    63,   101,    62,    99,     4,    91,
      -1,    36,    -1,    46,    66,    99,    67,    -1,    47,    66,
      97,    67,    -1,    48,    66,    97,    67,    -1,    49,    -1,
     102,    93,    99,    -1,    62,    -1,    37,    -1,    38,    -1,
      39,    -1,    40,    -1,    41,    -1,    42,    -1,    43,    -1,
      21,    -1,    21,   111,    -1,   111,    21,    -1,    60,    -1,
      60,    94,    -1,    94,    -1,    99,    61,    91,     3,    -1,
      99,    61,    91,     3,    61,    91,     3,    -1,    99,    61,
      91,     3,    96,    -1,    98,    -1,    97,    29,    98,    -1,
      97,    29,    60,    -1,    54,    -1,    53,    -1,   102,    -1,
     112,    -1,    66,    99,    67,    -1,    55,    -1,    56,    -1,
      99,    20,    99,    -1,    99,    18,    99,    -1,    19,    99,
      -1,    99,    19,    99,    -1,    99,    21,    99,    -1,    99,
      22,    99,    -1,    99,    23,    99,    -1,    99,    27,    99,
      -1,    99,    26,    99,    -1,    99,    29,    99,    -1,    99,
      15,    99,    -1,    99,    14,    99,    -1,    99,    13,    99,
      -1,    99,    12,    99,    -1,    99,    11,    99,    -1,    99,
      10,    99,    -1,    99,    24,    99,    -1,    99,    25,    99,
      -1,    17,    99,    -1,    99,     9,    99,    -1,    99,     8,
      99,    -1,    99,    15,   100,    -1,    44,    66,    99,    67,
      -1,    45,    66,    99,     7,    99,    67,    -1,    99,    16,
      -1,    16,    99,    -1,    99,    16,    99,    -1,    98,    -1,
      60,    -1,   101,    -1,    98,   111,    -1,    99,    -1,   113,
      -1,    62,    -1,    17,    -1,    10,    -1,    11,    -1,    -1,
      57,    -1,    -1,    99,    -1,   103,     7,   103,    -1,   105,
      -1,    66,   106,    67,    -1,    66,   106,     3,   104,    67,
      -1,    -1,    57,    -1,    -1,    99,    -1,   103,     7,   103,
      -1,   108,    -1,    66,   109,    67,    -1,    66,   109,     3,
     104,    67,    -1,    68,   110,    -1,    52,   107,    -1,    58,
      -1,    57,    -1,    59,    -1,    19,    59,    -1,   112,    -1,
      19,   112,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   229,   229,   230,   238,   249,   292,   293,   299,   304,
     312,   313,   317,   318,   321,   321,   337,   340,   344,   350,
     353,   356,   362,   363,   378,   379,   380,   381,   382,   383,
     384,   393,   394,   397,   402,   403,   413,   414,   424,   425,
     429,   430,   434,   435,   439,   449,   450,   461,   462,   466,
     485,   486,   490,   491,   496,   504,   512,   513,   514,   515,
     516,   519,   528,   538,   539,   540,   549,   550,   553,   557,
     561,   567,   577,   578,   579,   580,   581,   582,   583,   584,
     589,   590,   591,   595,   596,   600,   605,   610,   615,   626,
     627,   631,   637,   638,   645,   654,   655,   656,   659,   666,
     667,   668,   669,   670,   671,   672,   673,   674,   675,   676,
     677,   678,   679,   680,   681,   682,   683,   684,   685,   686,
     687,   690,   693,   700,   701,   702,   706,   717,   727,   728,
     741,   742,   746,   747,   748,   749,   753,   754,   758,   759,
     760,   764,   765,   766,   773,   774,   778,   779,   780,   784,
     785,   786,   793,   794,   801,   802,   808,   812,   815,   816
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "';'", "']'", "IF_PREC", "ELSE_TOK",
  "','", "OR_TOK", "AND_TOK", "'<'", "'>'", "LE_TOK", "GE_TOK", "NE_TOK",
  "EQ_TOK", "BIS_TOK", "'!'", "'+'", "'-'", "':'", "'*'", "'/'", "'%'",
  "'&'", "'|'", "BITUNSET_ATOK", "BITSET_ATOK", "NEG_PREC", "'.'",
  "INCLUDE_TOK", "BEGIN_CODE_TOK", "END_CODE_TOK", "SWITCH_TOK", "IF_TOK",
  "VAR_TOK", "BUSY_TOK", "ADD_TOK", "SUB_TOK", "MUL_TOK", "DIV_TOK",
  "MOD_TOK", "BITSET_TOK", "BITUNSET_TOK", "RND_TOK", "GGT_TOK",
  "BONUS_TOK", "MESSAGE_TOK", "SOUND_TOK", "EXPLODE_TOK", "DEFAULT_TOK",
  "DA_KIND_TOK", "FREMD_TOK", "REINWORT_TOK", "WORT_TOK", "NACHBAR8_TOK",
  "NACHBAR6_TOK", "NULLEINS_TOK", "ZAHL_TOK", "HALBZAHL_TOK",
  "BUCHSTABE_TOK", "PFEIL_TOK", "'='", "'['", "'{'", "'}'", "'('", "')'",
  "'@'", "$accept", "alles", "versionsmerkmal", "versionierung", "version",
  "ld_konstante", "rechts_von_def", "@1", "def_liste", "def_liste_eintrag",
  "konstante", "code_modus", "code_zeile", "proc_def_wort", "var_liste",
  "echter_default", "unechter_default", "var_def", "var_def_wort",
  "default_liste", "default_def", "code", "code_1", "set_zeile",
  "zuweisungs_operator", "stern_at", "buch_stern", "auswahl_liste",
  "punktwort", "wort", "ausdruck", "intervall", "lokale_variable",
  "variable", "halbort", "haelften_spez", "absort_klammerfrei",
  "absort_geklammert", "absort", "relort_klammerfrei", "relort_geklammert",
  "relort", "ort", "zahl", "halbzahl", "vorzeichen_zahl", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,    59,    93,   258,   259,    44,   260,   261,
      60,    62,   262,   263,   264,   265,   266,    33,    43,    45,
      58,    42,    47,    37,    38,   124,   267,   268,   269,    46,
     270,   271,   272,   273,   274,   275,   276,   277,   278,   279,
     280,   281,   282,   283,   284,   285,   286,   287,   288,   289,
     290,   291,   292,   293,   294,   295,   296,   297,   298,   299,
     300,   301,    61,    91,   123,   125,    40,    41,    64
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    69,    70,    70,    70,    70,    71,    71,    72,    72,
      73,    73,    74,    74,    76,    75,    75,    77,    77,    78,
      78,    78,    79,    79,    79,    79,    79,    79,    79,    79,
      79,    80,    80,    81,    81,    81,    82,    82,    83,    83,
      84,    84,    85,    85,    86,    87,    87,    88,    88,    89,
      90,    90,    91,    91,    91,    91,    91,    91,    91,    91,
      91,    91,    91,    91,    91,    91,    91,    91,    91,    91,
      91,    92,    93,    93,    93,    93,    93,    93,    93,    93,
      94,    94,    94,    95,    95,    95,    96,    96,    96,    97,
      97,    97,    98,    98,    99,    99,    99,    99,    99,    99,
      99,    99,    99,    99,    99,    99,    99,    99,    99,    99,
      99,    99,    99,    99,    99,    99,    99,    99,    99,    99,
      99,    99,    99,   100,   100,   100,   101,   101,   102,   102,
     103,   103,   104,   104,   104,   104,   105,   105,   106,   106,
     106,   107,   107,   107,   108,   108,   109,   109,   109,   110,
     110,   110,   111,   111,   112,   112,   113,   113,   114,   114
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     0,     5,     4,     3,     1,     1,     1,     3,
       0,     3,     1,     3,     0,     4,     1,     1,     3,     1,
       1,     3,     1,     1,     3,     2,     3,     3,     3,     3,
       3,     0,     2,     5,     3,     3,     1,     1,     1,     3,
       1,     3,     0,     2,     3,     1,     1,     1,     3,     4,
       1,     3,     4,     4,     6,     7,     3,     3,     1,     1,
       2,     1,     2,     0,     1,     6,     1,     4,     4,     4,
       1,     3,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     2,     2,     1,     2,     1,     4,     7,     5,     1,
       3,     3,     1,     1,     1,     1,     3,     1,     1,     3,
       3,     2,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     2,     3,     3,
       3,     4,     6,     2,     2,     3,     1,     1,     1,     2,
       1,     1,     1,     1,     1,     1,     0,     1,     0,     1,
       3,     1,     3,     5,     0,     1,     0,     1,     3,     1,
       3,     5,     2,     2,     1,     1,     1,     2,     1,     2
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       2,     0,     1,     0,    31,    93,    92,    10,    89,     5,
       0,     0,     0,     0,     4,     0,     0,    37,    32,    10,
      36,    91,    90,   155,   154,     8,     0,     6,     7,     0,
      46,     0,    38,    10,    45,    10,     0,    47,     0,     0,
      11,     0,     0,    14,    20,     3,    16,    17,    19,   158,
      12,    34,     0,    42,     0,    35,     0,    63,     9,     0,
       0,     0,    23,    22,   159,     2,     0,     0,    39,     0,
      44,     0,    48,    80,     0,     0,     0,    66,     0,     0,
       0,    70,   136,   127,     0,    63,   144,     0,    64,    85,
      59,    61,   126,   128,     0,     0,    58,    25,     0,    13,
       0,     0,     0,     0,     0,     0,    18,    21,    40,    43,
      49,    81,    62,     0,     0,     0,     0,     0,    97,    98,
     127,     0,   126,     0,    94,    95,     0,     0,     0,   137,
     138,   141,   153,    84,   126,     0,     0,    50,   145,   146,
     149,   152,    33,    63,   129,    73,    74,    75,    76,    77,
      78,    79,    72,     0,    82,    83,    60,    24,    26,    27,
      28,    29,    30,    15,     0,     0,     0,   117,   101,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,    63,     0,     0,     0,     0,   156,   139,     0,     0,
     131,     0,    56,    63,   147,     0,     0,    57,    71,    41,
      52,    63,     0,     0,    96,   119,   118,   114,   113,   112,
     111,   110,     0,   109,   120,   100,   102,    99,   103,   104,
     105,   115,   116,   107,   106,   108,    53,    67,    68,    69,
     157,     0,     0,   142,     0,    51,     0,     0,   150,     0,
     121,     0,   124,   123,    63,   130,   140,   134,   135,   133,
     132,     0,    63,   148,     0,    86,     0,   125,    63,    54,
     143,    65,   151,    63,    88,   122,    55,     0,    87
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     1,    25,    26,    13,    44,    45,    65,    46,    47,
     108,    10,    18,    19,    31,   109,    70,    32,    33,    36,
      37,   136,   137,    88,   153,    89,    90,   165,    91,   122,
     166,   224,    93,   124,   198,   261,   131,   199,   132,   140,
     206,   141,    95,   125,   200,    50
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -135
static const yytype_int16 yypact[] =
{
    -135,    85,  -135,   168,  -135,  -135,  -135,   -10,  -135,    38,
     153,   105,   238,    14,  -135,   108,   108,  -135,  -135,    33,
      38,  -135,  -135,  -135,  -135,    98,   107,  -135,  -135,   122,
    -135,    20,  -135,    33,  -135,    33,    39,  -135,    55,   238,
    -135,    94,   -32,  -135,  -135,  -135,   112,  -135,     1,  -135,
    -135,  -135,   108,    73,    82,  -135,   108,   597,  -135,    94,
      94,   255,  -135,  -135,  -135,  -135,   124,   135,  -135,    94,
    -135,    94,  -135,   -31,   168,    86,   544,  -135,    89,   123,
     125,  -135,   -37,    88,   198,   597,   -14,    54,  -135,  -135,
    -135,    38,    68,  -135,   316,   190,   173,  -135,    26,  -135,
      94,    94,    94,    94,    94,   216,  -135,  -135,   365,  -135,
    -135,  -135,    38,   544,   544,   544,   150,   179,  -135,  -135,
    -135,   544,   -31,   455,  -135,  -135,   544,   168,   168,  -135,
     469,  -135,  -135,  -135,  -135,   172,   109,   111,  -135,   469,
    -135,  -135,  -135,   597,  -135,  -135,  -135,  -135,  -135,  -135,
    -135,  -135,  -135,   544,  -135,   163,  -135,  -135,   174,   174,
    -135,  -135,  -135,  -135,   203,   184,   483,   342,   227,   544,
     544,   323,   544,   544,   544,   544,   544,   544,   544,   182,
     544,   544,   544,   544,   544,   544,   544,   544,   544,   544,
     544,   597,   383,   -28,   -13,   498,  -135,   681,   250,     5,
    -135,   544,  -135,   597,   681,   253,    15,  -135,   726,  -135,
    -135,   597,   405,   704,  -135,   747,   767,   342,   342,   342,
     342,   342,   544,   779,  -135,   789,   789,   799,   261,   261,
     261,   227,   227,   227,   227,   233,   223,  -135,  -135,  -135,
    -135,   469,    24,  -135,   658,  -135,   469,    24,  -135,   160,
    -135,   544,   342,   544,   559,   726,  -135,  -135,  -135,  -135,
    -135,   196,   597,  -135,   197,   515,   433,   342,   597,   258,
    -135,   258,  -135,   597,  -135,  -135,   258,   180,  -135
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -135,   206,  -135,   240,   185,   213,  -135,  -135,  -135,   218,
      69,  -135,  -135,  -135,  -135,   222,  -135,   245,     8,  -135,
     244,   117,   -45,  -135,  -135,   -76,   225,    57,     3,    -1,
     129,  -135,   239,   -54,  -134,    78,  -135,  -135,  -135,  -135,
    -135,  -135,   -56,    21,  -135,  -135
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -131
static const yytype_int16 yytable[] =
{
       8,    11,     8,    94,     7,   205,     9,   133,   242,     8,
      22,    27,    87,    20,    34,    34,    11,   111,   247,    11,
     129,    82,    67,    51,    35,    23,    24,    52,     8,   130,
      11,    94,    48,    28,   257,   258,   144,    86,    27,   238,
      62,   259,    55,   138,   100,   101,    56,   102,   103,   104,
      49,    34,   139,    12,   239,    34,    92,   142,    62,    62,
      28,   143,    63,    64,    35,     8,   144,    11,    62,    48,
      62,   -89,   243,     8,   -89,   -89,    29,   112,    96,   133,
      63,    63,   248,   134,    92,     2,   260,    49,    49,    94,
      63,   -83,    63,   157,   -83,   -83,    12,   -89,   207,    62,
      62,    62,    62,    62,     8,    39,    96,   256,     7,    73,
      61,    40,   263,    59,   203,     3,     4,    57,   143,    66,
      82,    63,    63,    63,    63,    63,     8,     8,    97,    98,
     193,   194,    41,   -89,    41,    69,    86,    94,     5,     6,
      82,    42,    92,    42,    71,    41,   236,     5,     6,    94,
     113,    23,    24,   -83,    42,   126,    86,    94,     5,     6,
      60,     5,     6,   265,    96,    21,   249,   143,    30,   158,
     159,   160,   161,   162,   202,     5,     6,     5,     6,    23,
      24,    23,    24,   278,    73,    14,    43,   143,    15,   127,
      92,   128,    23,    24,    73,   102,   103,   104,   222,   114,
      94,   115,    92,    16,    38,   123,     5,     6,    94,   269,
      92,   154,    96,    17,    94,    82,   169,   271,    53,    94,
      54,     5,     6,   276,    96,    82,   116,   117,   277,   254,
     143,    86,    96,   155,   201,     5,     6,   118,   119,    23,
      24,    86,   120,   167,   168,   170,     3,     4,   121,   210,
     171,     5,     6,    92,   209,   192,   190,   241,   120,   197,
     246,    92,  -131,   270,   272,   143,    99,    92,   204,     5,
       6,   105,    92,   100,   101,    96,   102,   103,   104,    58,
     107,   163,   208,    96,   106,   186,   187,   188,   189,    96,
     190,     5,     6,   110,    96,    23,    24,    68,   212,   213,
      72,   215,   216,   217,   218,   219,   220,   221,   223,   225,
     226,   227,   228,   229,   230,   231,   232,   233,   234,   235,
     245,   156,   274,   135,   168,   264,     0,     0,     0,     0,
     244,   172,   173,   174,   175,   176,   177,   178,   179,     0,
       0,   180,   181,   182,   183,   184,   185,   186,   187,   188,
     189,   252,   190,   145,   146,   147,   148,   149,   150,   151,
     180,   181,   182,   183,   184,   185,   186,   187,   188,   189,
     255,   190,     0,     0,     0,   255,     0,     0,   152,     0,
     266,     0,   267,   100,   101,   164,   102,   103,   104,     0,
     214,   172,   173,   174,   175,   176,   177,   178,   179,     0,
       0,   180,   181,   182,   183,   184,   185,   186,   187,   188,
     189,     0,   190,   172,   173,   174,   175,   176,   177,   178,
     179,     0,     0,   180,   181,   182,   183,   184,   185,   186,
     187,   188,   189,     0,   190,     0,     0,     0,     0,     0,
       0,   172,   173,   174,   175,   176,   177,   178,   179,     0,
     237,   180,   181,   182,   183,   184,   185,   186,   187,   188,
     189,     0,   190,   172,   173,   174,   175,   176,   177,   178,
     179,     0,   250,   180,   181,   182,   183,   184,   185,   186,
     187,   188,   189,     0,   190,     0,   114,     0,   195,     0,
       0,   172,   173,   174,   175,   176,   177,   178,   179,     0,
     275,   180,   181,   182,   183,   184,   185,   186,   187,   188,
     189,     0,   190,   116,   117,   114,   191,   115,     0,     0,
       0,     0,     5,     6,   118,   119,    23,    24,   196,   120,
       0,     0,   114,     0,   115,   121,     0,     0,     0,     0,
       0,     0,   116,   117,   211,     0,     0,     0,     0,     0,
       0,     5,     6,   118,   119,    23,    24,   240,   120,   116,
     117,   114,     0,   115,   121,     0,     0,     0,     5,     6,
     118,   119,    23,    24,     0,   120,   273,     0,     0,     0,
      73,   121,     0,    74,     0,     0,     0,     0,   116,   117,
       0,     0,    75,    76,     0,    77,     0,     5,     6,   118,
     119,    23,    24,     0,   120,    78,    79,    80,    81,     0,
     121,    82,     5,     6,     0,     0,    23,    24,    73,    83,
     268,    74,    84,    85,     0,     0,     0,    86,     0,     0,
      75,    76,     0,    77,     0,     0,     0,     0,     0,     0,
       0,     0,     0,    78,    79,    80,    81,     0,     0,    82,
       5,     6,     0,     0,    23,    24,     0,    83,     0,     0,
      84,    85,   262,     0,     0,    86,   172,   173,   174,   175,
     176,   177,   178,   179,     0,     0,   180,   181,   182,   183,
     184,   185,   186,   187,   188,   189,     0,   190,  -130,   172,
     173,   174,   175,   176,   177,   178,   179,     0,     0,   180,
     181,   182,   183,   184,   185,   186,   187,   188,   189,     0,
     190,   251,   172,   173,   174,   175,   176,   177,   178,   179,
       0,     0,   180,   181,   182,   183,   184,   185,   186,   187,
     188,   189,     0,   190,   172,   173,   174,   175,   176,   177,
     178,   179,     0,     0,   180,   181,   182,   183,   184,   185,
     186,   187,   188,   189,     0,   190,   173,   174,   175,   176,
     177,   178,   179,     0,     0,   180,   181,   182,   183,   184,
     185,   186,   187,   188,   189,     0,   190,   174,   175,   176,
     177,   178,   179,     0,     0,   180,   181,   182,   183,   184,
     185,   186,   187,   188,   189,   253,   190,   180,   181,   182,
     183,   184,   185,   186,   187,   188,   189,     0,   190,   182,
     183,   184,   185,   186,   187,   188,   189,     0,   190,  -131,
     183,   184,   185,   186,   187,   188,   189,     0,   190
};

static const yytype_int16 yycheck[] =
{
       1,    29,     3,    57,     1,   139,     3,    83,     3,    10,
      11,    12,    57,    10,    15,    16,    29,    73,     3,    29,
      57,    52,    21,     3,    16,    57,    58,     7,    29,    66,
      29,    85,    29,    12,    10,    11,    92,    68,    39,    67,
      41,    17,     3,    57,    18,    19,     7,    21,    22,    23,
      29,    52,    66,    63,    67,    56,    57,     3,    59,    60,
      39,     7,    41,    42,    56,    66,   122,    29,    69,    66,
      71,     3,    67,    74,     6,     7,    62,    74,    57,   155,
      59,    60,    67,    84,    85,     0,    62,    66,    67,   143,
      69,     3,    71,    67,     6,     7,    63,    29,   143,   100,
     101,   102,   103,   104,   105,     7,    85,   241,   105,    21,
      41,     4,   246,    19,     3,    30,    31,    62,     7,     7,
      52,   100,   101,   102,   103,   104,   127,   128,    59,    60,
     127,   128,    10,    65,    10,    62,    68,   191,    53,    54,
      52,    19,   143,    19,    62,    10,   191,    53,    54,   203,
      64,    57,    58,    65,    19,    66,    68,   211,    53,    54,
      66,    53,    54,     3,   143,    60,   211,     7,    60,   100,
     101,   102,   103,   104,    65,    53,    54,    53,    54,    57,
      58,    57,    58,     3,    21,    32,    64,     7,    35,    66,
     191,    66,    57,    58,    21,    21,    22,    23,    16,    17,
     254,    19,   203,    50,    19,    76,    53,    54,   262,   254,
     211,    21,   191,    60,   268,    52,    66,   262,    33,   273,
      35,    53,    54,   268,   203,    52,    44,    45,   273,     6,
       7,    68,   211,    60,    62,    53,    54,    55,    56,    57,
      58,    68,    60,   114,   115,    66,    30,    31,    66,    65,
     121,    53,    54,   254,    51,   126,    29,     7,    60,   130,
       7,   262,    29,    67,    67,     7,    11,   268,   139,    53,
      54,    65,   273,    18,    19,   254,    21,    22,    23,    39,
      67,    65,   153,   262,    66,    24,    25,    26,    27,   268,
      29,    53,    54,    71,   273,    57,    58,    52,   169,   170,
      56,   172,   173,   174,   175,   176,   177,   178,   179,   180,
     181,   182,   183,   184,   185,   186,   187,   188,   189,   190,
     203,    96,   265,    84,   195,   247,    -1,    -1,    -1,    -1,
     201,     8,     9,    10,    11,    12,    13,    14,    15,    -1,
      -1,    18,    19,    20,    21,    22,    23,    24,    25,    26,
      27,   222,    29,    37,    38,    39,    40,    41,    42,    43,
      18,    19,    20,    21,    22,    23,    24,    25,    26,    27,
     241,    29,    -1,    -1,    -1,   246,    -1,    -1,    62,    -1,
     251,    -1,   253,    18,    19,    20,    21,    22,    23,    -1,
      67,     8,     9,    10,    11,    12,    13,    14,    15,    -1,
      -1,    18,    19,    20,    21,    22,    23,    24,    25,    26,
      27,    -1,    29,     8,     9,    10,    11,    12,    13,    14,
      15,    -1,    -1,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    -1,    29,    -1,    -1,    -1,    -1,    -1,
      -1,     8,     9,    10,    11,    12,    13,    14,    15,    -1,
      67,    18,    19,    20,    21,    22,    23,    24,    25,    26,
      27,    -1,    29,     8,     9,    10,    11,    12,    13,    14,
      15,    -1,    67,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    -1,    29,    -1,    17,    -1,    19,    -1,
      -1,     8,     9,    10,    11,    12,    13,    14,    15,    -1,
      67,    18,    19,    20,    21,    22,    23,    24,    25,    26,
      27,    -1,    29,    44,    45,    17,    61,    19,    -1,    -1,
      -1,    -1,    53,    54,    55,    56,    57,    58,    59,    60,
      -1,    -1,    17,    -1,    19,    66,    -1,    -1,    -1,    -1,
      -1,    -1,    44,    45,    61,    -1,    -1,    -1,    -1,    -1,
      -1,    53,    54,    55,    56,    57,    58,    59,    60,    44,
      45,    17,    -1,    19,    66,    -1,    -1,    -1,    53,    54,
      55,    56,    57,    58,    -1,    60,    61,    -1,    -1,    -1,
      21,    66,    -1,    24,    -1,    -1,    -1,    -1,    44,    45,
      -1,    -1,    33,    34,    -1,    36,    -1,    53,    54,    55,
      56,    57,    58,    -1,    60,    46,    47,    48,    49,    -1,
      66,    52,    53,    54,    -1,    -1,    57,    58,    21,    60,
      61,    24,    63,    64,    -1,    -1,    -1,    68,    -1,    -1,
      33,    34,    -1,    36,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    46,    47,    48,    49,    -1,    -1,    52,
      53,    54,    -1,    -1,    57,    58,    -1,    60,    -1,    -1,
      63,    64,     4,    -1,    -1,    68,     8,     9,    10,    11,
      12,    13,    14,    15,    -1,    -1,    18,    19,    20,    21,
      22,    23,    24,    25,    26,    27,    -1,    29,     7,     8,
       9,    10,    11,    12,    13,    14,    15,    -1,    -1,    18,
      19,    20,    21,    22,    23,    24,    25,    26,    27,    -1,
      29,     7,     8,     9,    10,    11,    12,    13,    14,    15,
      -1,    -1,    18,    19,    20,    21,    22,    23,    24,    25,
      26,    27,    -1,    29,     8,     9,    10,    11,    12,    13,
      14,    15,    -1,    -1,    18,    19,    20,    21,    22,    23,
      24,    25,    26,    27,    -1,    29,     9,    10,    11,    12,
      13,    14,    15,    -1,    -1,    18,    19,    20,    21,    22,
      23,    24,    25,    26,    27,    -1,    29,    10,    11,    12,
      13,    14,    15,    -1,    -1,    18,    19,    20,    21,    22,
      23,    24,    25,    26,    27,    16,    29,    18,    19,    20,
      21,    22,    23,    24,    25,    26,    27,    -1,    29,    20,
      21,    22,    23,    24,    25,    26,    27,    -1,    29,    20,
      21,    22,    23,    24,    25,    26,    27,    -1,    29
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    70,     0,    30,    31,    53,    54,    97,    98,    97,
      80,    29,    63,    73,    32,    35,    50,    60,    81,    82,
      97,    60,    98,    57,    58,    71,    72,    98,   112,    62,
      60,    83,    86,    87,    98,    87,    88,    89,    73,     7,
       4,    10,    19,    64,    74,    75,    77,    78,    97,   112,
     114,     3,     7,    73,    73,     3,     7,    62,    72,    19,
      66,    79,    98,   112,   112,    76,     7,    21,    86,    62,
      85,    62,    89,    21,    24,    33,    34,    36,    46,    47,
      48,    49,    52,    60,    63,    64,    68,    91,    92,    94,
      95,    97,    98,   101,   102,   111,   112,    79,    79,    11,
      18,    19,    21,    22,    23,    70,    78,    74,    79,    84,
      84,   111,    97,    64,    17,    19,    44,    45,    55,    56,
      60,    66,    98,    99,   102,   112,    66,    66,    66,    57,
      66,   105,   107,    94,    98,   101,    90,    91,    57,    66,
     108,   110,     3,     7,   111,    37,    38,    39,    40,    41,
      42,    43,    62,    93,    21,    60,    95,    67,    79,    79,
      79,    79,    79,    65,    20,    96,    99,    99,    99,    66,
      66,    99,     8,     9,    10,    11,    12,    13,    14,    15,
      18,    19,    20,    21,    22,    23,    24,    25,    26,    27,
      29,    61,    99,    97,    97,    19,    59,    99,   103,   106,
     113,    62,    65,     3,    99,   103,   109,    91,    99,    51,
      65,    61,    99,    99,    67,    99,    99,    99,    99,    99,
      99,    99,    16,    99,   100,    99,    99,    99,    99,    99,
      99,    99,    99,    99,    99,    99,    91,    67,    67,    67,
      59,     7,     3,    67,    99,    90,     7,     3,    67,    91,
      67,     7,    99,    16,     6,    99,   103,    10,    11,    17,
      62,   104,     4,   103,   104,     3,    99,    99,    61,    91,
      67,    91,    67,    61,    96,    67,    91,    91,     3
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (&yylval, YYLEX_PARAM)
#else
# define YYLEX yylex (&yylval)
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
#else
static void
yy_stack_print (bottom, top)
    yytype_int16 *bottom;
    yytype_int16 *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      fprintf (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      fprintf (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */






/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  /* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;

  int yystate;
  int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Look-ahead token as an internal (translated) token number.  */
  int yytoken = 0;
#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  yytype_int16 yyssa[YYINITDEPTH];
  yytype_int16 *yyss = yyssa;
  yytype_int16 *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  YYSTYPE *yyvsp;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     look-ahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to look-ahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 229 "parser.yy"
    { /* Nix zu tun. */ }
    break;

  case 3:
#line 230 "parser.yy"
    {
	
      PBEGIN_TRY
        gAktDefKnoten->fuegeEin(*(yyvsp[(2) - (5)].str), *(yyvsp[(3) - (5)].version), (yyvsp[(5) - (5)].knoten));
        delete (yyvsp[(2) - (5)].str);
        delete (yyvsp[(3) - (5)].version);
      PEND_TRY(;);
    }
    break;

  case 4:
#line 238 "parser.yy"
    {
			   
      /* Nix zu tun; die Codes speichern sich von alleine nach
         gAktDefKnoten */
    }
    break;

  case 5:
#line 249 "parser.yy"
    {
      PBEGIN_TRY
      
        /* Lex auf neue Datei umschalten */
	void * merkBuf = pushLex((yyvsp[(3) - (3)].str)->data());


        /***** Bison-Aufruf für include-Datei *****/
        /* Hier muss man aufpassen, dass mit allen globalen Variablen
	   das richtige passiert. Nichts zu tun ist bei:
	   - gGabFehler (Fehler in include-Datei ist halt auch Fehler)
	   - gAktDefKnoten (Die Include-Datei speichert ihre Ergebnisse
	     auch einfach da mit rein.)
	   */

	
	/* Datei und Zeilennummer zwischenspeichern. */
	Str merkDat = gDateiName;
	gDateiName = *(yyvsp[(3) - (3)].str);
	int merkZNr = gZeilenNr;
	gZeilenNr = 1;
	
	/* Der rekursive Aufruf! Hier! Live! (Die Ergebnisse werden in
	   gAktDefKnoten eingefügt.) */
	if ((yyparse()) && !gGabFehler) {
	  fprintf(stderr, "Unknown error during file inclusion!\n");
	  gGabFehler = true;
	}
	
	gDateiName = merkDat;
	gZeilenNr = merkZNr;
		
	/* Lex auf alte Datei zurückschalten */
	popLex(merkBuf);
	
      PEND_TRY(;);
    }
    break;

  case 6:
#line 292 "parser.yy"
    { (yyval.str) = (yyvsp[(1) - (1)].str); }
    break;

  case 7:
#line 293 "parser.yy"
    { (yyval.str) = new Str(_sprintf("%d",(yyvsp[(1) - (1)].zahl))); }
    break;

  case 8:
#line 299 "parser.yy"
    {
      (yyval.version) = new Version();
      (yyval.version)->nochEinMerkmal(*(yyvsp[(1) - (1)].str));
      delete (yyvsp[(1) - (1)].str);
    }
    break;

  case 9:
#line 304 "parser.yy"
    {
      (yyval.version) = (yyvsp[(3) - (3)].version);
      (yyval.version)->nochEinMerkmal(*(yyvsp[(1) - (3)].str));
      delete (yyvsp[(1) - (3)].str);
    }
    break;

  case 10:
#line 312 "parser.yy"
    { (yyval.version) = new Version(); }
    break;

  case 11:
#line 313 "parser.yy"
    { (yyval.version) = (yyvsp[(2) - (3)].version); }
    break;

  case 12:
#line 317 "parser.yy"
    { (yyval.zahl) = (yyvsp[(1) - (1)].zahl); }
    break;

  case 13:
#line 318 "parser.yy"
    { (yyval.zahl) = (yyvsp[(2) - (3)].zahl); }
    break;

  case 14:
#line 321 "parser.yy"
    {
      /* OK, hier wird ein neuer Defknoten eröffnet. Der alte wird
         auf dem Bison-Stack zwischengespeichert... */
      DefKnoten * merk = gAktDefKnoten;
      /* Neuen Defknoten erzeugen, mit dem alten als Vater */
      gAktDefKnoten = new DefKnoten(gDateiName, gZeilenNr, merk);
      (yyval.defknoten) = merk;

                    }
    break;

  case 15:
#line 329 "parser.yy"
    {
		    
      /* Jetzt wurde gAktDefKnoten mit Inhalt gefüllt, den wir
         zurückliefern */
      (yyval.knoten) = gAktDefKnoten;
      /* POP DefKnoten */
      gAktDefKnoten = (yyvsp[(2) - (4)].defknoten);
    }
    break;

  case 16:
#line 337 "parser.yy"
    { (yyval.knoten) = (yyvsp[(1) - (1)].listenknoten); }
    break;

  case 17:
#line 340 "parser.yy"
    {
      (yyval.listenknoten) = new ListenKnoten(gDateiName, gZeilenNr);
      (yyval.listenknoten)->fuegeEin((yyvsp[(1) - (1)].knoten));
    }
    break;

  case 18:
#line 344 "parser.yy"
    {
      (yyval.listenknoten) = (yyvsp[(1) - (3)].listenknoten);
      (yyval.listenknoten)->fuegeEin((yyvsp[(3) - (3)].knoten));
    }
    break;

  case 19:
#line 350 "parser.yy"
    {
      (yyval.knoten) = new WortKnoten(gDateiName, gZeilenNr, *(yyvsp[(1) - (1)].str)); delete (yyvsp[(1) - (1)].str);
    }
    break;

  case 20:
#line 353 "parser.yy"
    {
      (yyval.knoten) = new ZahlKnoten(gDateiName, gZeilenNr, (yyvsp[(1) - (1)].zahl));
    }
    break;

  case 21:
#line 356 "parser.yy"
    {
      (yyval.knoten) = new VielfachheitKnoten(gDateiName, gZeilenNr, *(yyvsp[(1) - (3)].str), (yyvsp[(3) - (3)].zahl)); delete (yyvsp[(1) - (3)].str);
    }
    break;

  case 22:
#line 362 "parser.yy"
    { (yyval.zahl) = (yyvsp[(1) - (1)].zahl); }
    break;

  case 23:
#line 363 "parser.yy"
    {
      Knoten * def = gAktDefKnoten->getVerwandten(*(yyvsp[(1) - (1)].str), ld->mVersion, false);
      const DatenKnoten * datum = 0;
      switch (def->type()) {
        case type_DatenKnoten:
          datum=(const DatenKnoten *) def;
          break;
        case type_ListenKnoten:
          datum=((ListenKnoten*) def)->getEinzigesDatum();
          break;
        default: throw Fehler(_("%s not a number"),(yyvsp[(1) - (1)].str)->data());
      }
      (yyval.zahl) = datum->assert_datatype(type_ZahlDatum)->getZahl();
      delete (yyvsp[(1) - (1)].str);
    }
    break;

  case 24:
#line 378 "parser.yy"
    { (yyval.zahl) = (yyvsp[(2) - (3)].zahl); }
    break;

  case 25:
#line 379 "parser.yy"
    { (yyval.zahl) = -(yyvsp[(2) - (2)].zahl); }
    break;

  case 26:
#line 380 "parser.yy"
    { (yyval.zahl) = (yyvsp[(1) - (3)].zahl) + (yyvsp[(3) - (3)].zahl); }
    break;

  case 27:
#line 381 "parser.yy"
    { (yyval.zahl) = (yyvsp[(1) - (3)].zahl) - (yyvsp[(3) - (3)].zahl); }
    break;

  case 28:
#line 382 "parser.yy"
    { (yyval.zahl) = (yyvsp[(1) - (3)].zahl) * (yyvsp[(3) - (3)].zahl); }
    break;

  case 29:
#line 383 "parser.yy"
    { (yyval.zahl) = divv((yyvsp[(1) - (3)].zahl),(yyvsp[(3) - (3)].zahl)); }
    break;

  case 30:
#line 384 "parser.yy"
    { (yyval.zahl) = modd((yyvsp[(1) - (3)].zahl),(yyvsp[(3) - (3)].zahl)); }
    break;

  case 33:
#line 397 "parser.yy"
    {
      gAktDefKnoten->speicherDefinition(namespace_prozedur, *(yyvsp[(1) - (5)].str),
                                        *(yyvsp[(2) - (5)].version), (yyvsp[(4) - (5)].code));
      delete (yyvsp[(1) - (5)].str); delete (yyvsp[(2) - (5)].version);
    }
    break;

  case 36:
#line 413 "parser.yy"
    { (yyval.str) = (yyvsp[(1) - (1)].str); }
    break;

  case 37:
#line 414 "parser.yy"
    {
      /* Wie gibt man einen Fehler möglichst umständlich aus?
         (Aber so, dass er genauso aussieht wie die anderen Fehler. */
      PBEGIN_TRY
        throw Fehler(_("Procedure names can't be single letters."));
      PEND_TRY((yyval.str) = new Str());
    }
    break;

  case 40:
#line 429 "parser.yy"
    { (yyval.zahlpaar)[0]=(yyvsp[(1) - (1)].zahl); (yyval.zahlpaar)[1]=da_init; }
    break;

  case 41:
#line 430 "parser.yy"
    { (yyval.zahlpaar)[0]=(yyvsp[(1) - (3)].zahl); (yyval.zahlpaar)[1]=da_kind; }
    break;

  case 42:
#line 434 "parser.yy"
    { (yyval.zahlpaar)[0]=0;  (yyval.zahlpaar)[1]=da_init; }
    break;

  case 43:
#line 435 "parser.yy"
    { (yyval.zahlpaar)[0]=(yyvsp[(2) - (2)].zahlpaar)[0];  (yyval.zahlpaar)[1]=(yyvsp[(2) - (2)].zahlpaar)[1];}
    break;

  case 44:
#line 439 "parser.yy"
    {
      PBEGIN_TRY
        gAktDefKnoten->neueVarDefinition(*(yyvsp[(1) - (3)].str), *(yyvsp[(2) - (3)].version), (yyvsp[(3) - (3)].zahlpaar)[0], (yyvsp[(3) - (3)].zahlpaar)[1]);
        delete (yyvsp[(1) - (3)].str); delete (yyvsp[(2) - (3)].version);
      PEND_TRY(;)
    }
    break;

  case 45:
#line 449 "parser.yy"
    { (yyval.str) = (yyvsp[(1) - (1)].str); }
    break;

  case 46:
#line 450 "parser.yy"
    {
      /* Wie gibt man einen Fehler möglichst umständlich aus?
         (Aber so, dass er genauso aussieht wie die anderen Fehler. */
      PBEGIN_TRY
        throw Fehler(_("Variable names can't be single letters."));
      PEND_TRY((yyval.str) = new Str());
    }
    break;

  case 49:
#line 466 "parser.yy"
    {
      PBEGIN_TRY
        gAktDefKnoten->neuerDefault(
          ((VarDefinition*)
              (gAktDefKnoten->getDefinition(namespace_variable,*(yyvsp[(1) - (4)].str),*(yyvsp[(2) - (4)].version),false)))
            -> mNummer,
          (yyvsp[(4) - (4)].zahlpaar)[0], (yyvsp[(4) - (4)].zahlpaar)[1]);
        delete (yyvsp[(1) - (4)].str); delete (yyvsp[(2) - (4)].version);
      PEND_TRY(;)
    }
    break;

  case 50:
#line 485 "parser.yy"
    { (yyval.code) = (yyvsp[(1) - (1)].code); }
    break;

  case 51:
#line 486 "parser.yy"
    { (yyval.code) = newCode2(stapel_code, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 52:
#line 490 "parser.yy"
    { (yyval.code) = (yyvsp[(3) - (4)].code); }
    break;

  case 53:
#line 491 "parser.yy"
    {
      (yyval.code) = newCode4(bedingung_code, (yyvsp[(2) - (4)].code), (yyvsp[(4) - (4)].code),
                     newCode0(nop_code),
                     (yyvsp[(3) - (4)].zahl) + 2 * ohne_merk_pfeil);
    }
    break;

  case 54:
#line 496 "parser.yy"
    {
      if ((yyvsp[(3) - (6)].zahl)==ohne_merk_pfeil)
        (yyval.code) = newCode4(bedingung_code, (yyvsp[(2) - (6)].code), (yyvsp[(4) - (6)].code),
                      (yyvsp[(6) - (6)].code),
                      3*ohne_merk_pfeil);
      else
        throw Fehler("Please specify \"else ->\" or \"else =>\"");
    }
    break;

  case 55:
#line 504 "parser.yy"
    {
      /* Nach else kann, muss aber kein Pfeil stehen.
         (Kein Pfeil will man vermutlich, wenn dann gleich das
	 nächste if kommt.) */
      (yyval.code) = newCode4(bedingung_code, (yyvsp[(2) - (7)].code), (yyvsp[(4) - (7)].code),
                     (yyvsp[(7) - (7)].code),
                     (yyvsp[(3) - (7)].zahl) + 2 * (yyvsp[(6) - (7)].zahl));
    }
    break;

  case 56:
#line 512 "parser.yy"
    { (yyval.code) = (yyvsp[(2) - (3)].code); }
    break;

  case 57:
#line 513 "parser.yy"
    { (yyval.code) = newCode2(folge_code, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 58:
#line 514 "parser.yy"
    { (yyval.code) = newCode1(zahl_code, (yyvsp[(1) - (1)].zahl)); }
    break;

  case 59:
#line 515 "parser.yy"
    { (yyval.code) = (yyvsp[(1) - (1)].code); }
    break;

  case 60:
#line 516 "parser.yy"
    {
      (yyval.code) = newCode2(stapel_code, newCode1(zahl_code, (yyvsp[(1) - (2)].zahl)), (yyvsp[(2) - (2)].code));
    }
    break;

  case 61:
#line 519 "parser.yy"
    {
      PBEGIN_TRY
        /* Kopie erzeugen...) */
        (yyval.code) = new Code(gAktDefKnoten, * (Code*)
               gAktDefKnoten->getDefinition(namespace_prozedur, *(yyvsp[(1) - (1)].str),
                                            ld->mVersion, false), true);
        delete (yyvsp[(1) - (1)].str);
      PEND_TRY((yyval.code) = newCode0(undefiniert_code))
    }
    break;

  case 62:
#line 528 "parser.yy"
    {
      PBEGIN_TRY
        /* Kopie erzeugen...) */
        (yyval.code) = newCode1(weiterleit_code,
	      new Code(gAktDefKnoten, * (Code*)
                gAktDefKnoten->getDefinition(namespace_prozedur, *(yyvsp[(2) - (2)].str),
                                             ld->mVersion, false), false));
        delete (yyvsp[(2) - (2)].str);
      PEND_TRY((yyval.code) = newCode0(undefiniert_code))
    }
    break;

  case 63:
#line 538 "parser.yy"
    { (yyval.code) = newCode0(nop_code); }
    break;

  case 64:
#line 539 "parser.yy"
    { (yyval.code) = (yyvsp[(1) - (1)].code); }
    break;

  case 65:
#line 540 "parser.yy"
    {
      PBEGIN_TRY
        if ((yyvsp[(2) - (6)].variable)->istKonstante())
          throw Fehler(_sprintf(_("%s is a constant. (Variable expected.)"),
                     (yyvsp[(2) - (6)].variable)->getName().data()));
        (yyval.code) = newCode3(push_code, (yyvsp[(4) - (6)].code), (yyvsp[(6) - (6)].code), (yyvsp[(2) - (6)].variable));
        
      PEND_TRY((yyval.code) = newCode0(undefiniert_code))
    }
    break;

  case 66:
#line 549 "parser.yy"
    { (yyval.code) = newCode0(busy_code); }
    break;

  case 67:
#line 550 "parser.yy"
    {
      (yyval.code) = newCode1(bonus_code, (yyvsp[(3) - (4)].code));
    }
    break;

  case 68:
#line 553 "parser.yy"
    {
      (yyval.code) = newCode1(message_code, *(yyvsp[(3) - (4)].str));
      delete (yyvsp[(3) - (4)].str);
    }
    break;

  case 69:
#line 557 "parser.yy"
    {
      (yyval.code) = newCode1(sound_code, Sound::ladSample(*(yyvsp[(3) - (4)].str)));
      delete (yyvsp[(3) - (4)].str);
    }
    break;

  case 70:
#line 561 "parser.yy"
    {
      (yyval.code) = newCode0(explode_code);
    }
    break;

  case 71:
#line 567 "parser.yy"
    {
      PBEGIN_TRY
        if ((yyvsp[(1) - (3)].variable)->istKonstante())
          throw Fehler(_sprintf(_("%s is a constant. (Variable expected.)"),
                     (yyvsp[(1) - (3)].variable)->getName().data()));
        (yyval.code) = newCode2((yyvsp[(2) - (3)].codeart), (yyvsp[(3) - (3)].code), (yyvsp[(1) - (3)].variable));
      PEND_TRY((yyval.code) = newCode0(undefiniert_code))
    }
    break;

  case 72:
#line 577 "parser.yy"
    { (yyval.codeart) = set_code; }
    break;

  case 73:
#line 578 "parser.yy"
    { (yyval.codeart) = add_code; }
    break;

  case 74:
#line 579 "parser.yy"
    { (yyval.codeart) = sub_code; }
    break;

  case 75:
#line 580 "parser.yy"
    { (yyval.codeart) = mul_code; }
    break;

  case 76:
#line 581 "parser.yy"
    { (yyval.codeart) = div_code; }
    break;

  case 77:
#line 582 "parser.yy"
    { (yyval.codeart) = mod_code; }
    break;

  case 78:
#line 583 "parser.yy"
    { (yyval.codeart) = bitset_code; }
    break;

  case 79:
#line 584 "parser.yy"
    { (yyval.codeart) = bitunset_code; }
    break;

  case 80:
#line 589 "parser.yy"
    { (yyval.code) = newCode0(mal_code); }
    break;

  case 81:
#line 590 "parser.yy"
    { (yyval.code) = newCode2(mal_code_fremd, (yyvsp[(2) - (2)].ort), 1); }
    break;

  case 82:
#line 591 "parser.yy"
    { (yyval.code) = newCode2(mal_code_fremd, (yyvsp[(1) - (2)].ort), -1); }
    break;

  case 83:
#line 595 "parser.yy"
    { (yyval.code) = newCode1(buchstabe_code, (yyvsp[(1) - (1)].zahl)); }
    break;

  case 84:
#line 596 "parser.yy"
    {
      (yyval.code) = newCode2(stapel_code, newCode1(buchstabe_code, (yyvsp[(1) - (2)].zahl)),
                     (yyvsp[(2) - (2)].code));
    }
    break;

  case 85:
#line 600 "parser.yy"
    { (yyval.code) = (yyvsp[(1) - (1)].code); }
    break;

  case 86:
#line 605 "parser.yy"
    {
      (yyval.code) = newCode4(bedingung_code, (yyvsp[(1) - (4)].code), (yyvsp[(3) - (4)].code),
                     newCode0(nop_code),
                     (yyvsp[(2) - (4)].zahl) + 2 * ohne_merk_pfeil);
    }
    break;

  case 87:
#line 610 "parser.yy"
    {
      (yyval.code) = newCode4(bedingung_code, (yyvsp[(1) - (7)].code), (yyvsp[(3) - (7)].code),
                     (yyvsp[(6) - (7)].code),
                     (yyvsp[(2) - (7)].zahl) + 2 * (yyvsp[(5) - (7)].zahl));
    }
    break;

  case 88:
#line 615 "parser.yy"
    {
      (yyval.code) = newCode4(bedingung_code, (yyvsp[(1) - (5)].code), (yyvsp[(3) - (5)].code),
                     (yyvsp[(5) - (5)].code),
                     (yyvsp[(2) - (5)].zahl) + 2 * mit_merk_pfeil);
    }
    break;

  case 89:
#line 626 "parser.yy"
    { (yyval.str) = (yyvsp[(1) - (1)].str); }
    break;

  case 90:
#line 627 "parser.yy"
    {
      *(yyvsp[(1) - (3)].str) += '.';  *(yyvsp[(1) - (3)].str) += *(yyvsp[(3) - (3)].str);  (yyval.str) = (yyvsp[(1) - (3)].str);
      delete (yyvsp[(3) - (3)].str);
    }
    break;

  case 91:
#line 631 "parser.yy"
    {
      *(yyvsp[(1) - (3)].str) += '.';  *(yyvsp[(1) - (3)].str) += ((yyvsp[(3) - (3)].zahl)>=26 ? 'a'+(yyvsp[(3) - (3)].zahl)-26 : 'A'+(yyvsp[(3) - (3)].zahl));  (yyval.str) = (yyvsp[(1) - (3)].str);
    }
    break;

  case 92:
#line 637 "parser.yy"
    { (yyval.str) = (yyvsp[(1) - (1)].str); }
    break;

  case 93:
#line 638 "parser.yy"
    { (yyval.str) = (yyvsp[(1) - (1)].str); }
    break;

  case 94:
#line 645 "parser.yy"
    {
      if ((yyvsp[(1) - (1)].variable)->istKonstante()) {
        /* Wenn die Variable in Wirklichkeit eine Konstante ist,
           dann gleich die Konstante einsetzen. */
        (yyval.code) = newCode1(zahl_acode, (yyvsp[(1) - (1)].variable)->getDefaultWert());
        delete (yyvsp[(1) - (1)].variable);
      } else
        (yyval.code) = newCode1(variable_acode, (yyvsp[(1) - (1)].variable));
    }
    break;

  case 95:
#line 654 "parser.yy"
    { (yyval.code) = newCode1(zahl_acode, (yyvsp[(1) - (1)].zahl)); }
    break;

  case 96:
#line 655 "parser.yy"
    { (yyval.code) = (yyvsp[(2) - (3)].code); }
    break;

  case 97:
#line 656 "parser.yy"
    {
      (yyval.code) = newNachbarCode(gAktDefKnoten, gDateiName, gZeilenNr, (yyvsp[(1) - (1)].str));
    }
    break;

  case 98:
#line 659 "parser.yy"
    {
      (yyval.code) = newNachbarCode(gAktDefKnoten, gDateiName, gZeilenNr, (yyvsp[(1) - (1)].str));
    }
    break;

  case 99:
#line 666 "parser.yy"
    { (yyval.code) = newCode2(manchmal_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 100:
#line 667 "parser.yy"
    { (yyval.code) = newCode2(add_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 101:
#line 668 "parser.yy"
    { (yyval.code) = newCode1(neg_acode, (yyvsp[(2) - (2)].code));}
    break;

  case 102:
#line 669 "parser.yy"
    { (yyval.code) = newCode2(sub_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 103:
#line 670 "parser.yy"
    { (yyval.code) = newCode2(mul_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 104:
#line 671 "parser.yy"
    { (yyval.code) = newCode2(div_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 105:
#line 672 "parser.yy"
    { (yyval.code) = newCode2(mod_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 106:
#line 673 "parser.yy"
    { (yyval.code) = newCode2(bitset_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 107:
#line 674 "parser.yy"
    { (yyval.code) = newCode2(bitunset_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 108:
#line 675 "parser.yy"
    { (yyval.code) = newCode2(bittest_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 109:
#line 676 "parser.yy"
    { (yyval.code) = newCode2(eq_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 110:
#line 677 "parser.yy"
    { (yyval.code) = newCode2(ne_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 111:
#line 678 "parser.yy"
    { (yyval.code) = newCode2(ge_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 112:
#line 679 "parser.yy"
    { (yyval.code) = newCode2(le_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 113:
#line 680 "parser.yy"
    { (yyval.code) = newCode2(gt_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 114:
#line 681 "parser.yy"
    { (yyval.code) = newCode2(lt_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 115:
#line 682 "parser.yy"
    { (yyval.code) = newCode2(bitand_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 116:
#line 683 "parser.yy"
    { (yyval.code) = newCode2(bitor_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 117:
#line 684 "parser.yy"
    { (yyval.code) = newCode1(not_acode, (yyvsp[(2) - (2)].code));}
    break;

  case 118:
#line 685 "parser.yy"
    { (yyval.code) = newCode2(und_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 119:
#line 686 "parser.yy"
    { (yyval.code) = newCode2(oder_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code));}
    break;

  case 120:
#line 687 "parser.yy"
    {
      (yyval.code) = newCode3(intervall_acode, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].codepaar)[0], (yyvsp[(3) - (3)].codepaar)[1]);
    }
    break;

  case 121:
#line 690 "parser.yy"
    {
      (yyval.code) = newCode1(rnd_acode, (yyvsp[(3) - (4)].code));
    }
    break;

  case 122:
#line 693 "parser.yy"
    {
      (yyval.code) = newCode2(ggt_acode, (yyvsp[(3) - (6)].code), (yyvsp[(5) - (6)].code));
    }
    break;

  case 123:
#line 700 "parser.yy"
    { (yyval.codepaar)[0]=(yyvsp[(1) - (2)].code); (yyval.codepaar)[1]=newCode1(zahl_acode, VIEL); }
    break;

  case 124:
#line 701 "parser.yy"
    { (yyval.codepaar)[0]=newCode1(zahl_acode, -VIEL); (yyval.codepaar)[1]=(yyvsp[(2) - (2)].code); }
    break;

  case 125:
#line 702 "parser.yy"
    { (yyval.codepaar)[0]=(yyvsp[(1) - (3)].code); (yyval.codepaar)[1]=(yyvsp[(3) - (3)].code); }
    break;

  case 126:
#line 706 "parser.yy"
    {
      PBEGIN_TRY
        (yyval.variable) = new Variable(//gDateiName, gZeilenNr,
               (VarDefinition*) gAktDefKnoten->
                     getDefinition(namespace_variable, *(yyvsp[(1) - (1)].str),
                                   ld->mVersion, false),
               0
             );
      PEND_TRY((yyval.variable) = new Variable())
      delete (yyvsp[(1) - (1)].str);
    }
    break;

  case 127:
#line 717 "parser.yy"
    {
      /* Wie gibt man einen Fehler möglichst umständlich aus?
         (Aber so, dass er genauso aussieht wie die anderen Fehler. */
      PBEGIN_TRY
        throw Fehler(_("Variable names can't be single letters."));
      PEND_TRY((yyval.variable) = new Variable());
    }
    break;

  case 128:
#line 727 "parser.yy"
    { (yyval.variable) = (yyvsp[(1) - (1)].variable); }
    break;

  case 129:
#line 728 "parser.yy"
    {
      PBEGIN_TRY
        (yyval.variable) = new Variable(//gDateiName, gZeilenNr,
               (VarDefinition*) gAktDefKnoten->
                     getDefinition(namespace_variable, *(yyvsp[(1) - (2)].str),
                                   ld->mVersion, false),
               (yyvsp[(2) - (2)].ort));
      PEND_TRY((yyval.variable) = new Variable())
      delete (yyvsp[(1) - (2)].str);
    }
    break;

  case 130:
#line 741 "parser.yy"
    { (yyval.code) = (yyvsp[(1) - (1)].code); }
    break;

  case 131:
#line 742 "parser.yy"
    { (yyval.code) = newCode1(zahl_acode, (yyvsp[(1) - (1)].zahl)); }
    break;

  case 132:
#line 746 "parser.yy"
    { (yyval.haelfte) = haelfte_hier; }
    break;

  case 133:
#line 747 "parser.yy"
    { (yyval.haelfte) = haelfte_drueben; }
    break;

  case 134:
#line 748 "parser.yy"
    { (yyval.haelfte) = haelfte_links; }
    break;

  case 135:
#line 749 "parser.yy"
    { (yyval.haelfte) = haelfte_rechts; }
    break;

  case 136:
#line 753 "parser.yy"
    { (yyval.ort) = new Ort(absort_semiglobal); }
    break;

  case 137:
#line 754 "parser.yy"
    { (yyval.ort) = new Ort(absort_fall, newCode1(zahl_acode, (yyvsp[(1) - (1)].zahl))); }
    break;

  case 138:
#line 758 "parser.yy"
    { (yyval.ort) = new Ort(absort_semiglobal); }
    break;

  case 139:
#line 759 "parser.yy"
    { (yyval.ort) = new Ort(absort_fall, (yyvsp[(1) - (1)].code)); }
    break;

  case 140:
#line 760 "parser.yy"
    { (yyval.ort) = new Ort(absort_feld, (yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code)); }
    break;

  case 141:
#line 764 "parser.yy"
    { (yyval.ort) = (yyvsp[(1) - (1)].ort); }
    break;

  case 142:
#line 765 "parser.yy"
    { (yyval.ort) = (yyvsp[(2) - (3)].ort); }
    break;

  case 143:
#line 766 "parser.yy"
    {
      (yyvsp[(2) - (5)].ort)->setzeHaelfte((yyvsp[(4) - (5)].haelfte));
      (yyval.ort) = (yyvsp[(2) - (5)].ort);
    }
    break;

  case 144:
#line 773 "parser.yy"
    { (yyval.ort) = new Ort(absort_global); }
    break;

  case 145:
#line 774 "parser.yy"
    { (yyval.ort) = new Ort(newCode1(zahl_acode, (yyvsp[(1) - (1)].zahl))); }
    break;

  case 146:
#line 778 "parser.yy"
    { (yyval.ort) = new Ort(absort_global); }
    break;

  case 147:
#line 779 "parser.yy"
    { (yyval.ort) = new Ort((yyvsp[(1) - (1)].code)); }
    break;

  case 148:
#line 780 "parser.yy"
    { (yyval.ort) = new Ort((yyvsp[(1) - (3)].code), (yyvsp[(3) - (3)].code)); }
    break;

  case 149:
#line 784 "parser.yy"
    { (yyval.ort) = (yyvsp[(1) - (1)].ort); }
    break;

  case 150:
#line 785 "parser.yy"
    { (yyval.ort) = (yyvsp[(2) - (3)].ort); }
    break;

  case 151:
#line 786 "parser.yy"
    {
      (yyvsp[(2) - (5)].ort)->setzeHaelfte((yyvsp[(4) - (5)].haelfte));
      (yyval.ort) = (yyvsp[(2) - (5)].ort);
    }
    break;

  case 152:
#line 793 "parser.yy"
    { (yyval.ort) = (yyvsp[(2) - (2)].ort); }
    break;

  case 153:
#line 794 "parser.yy"
    { (yyval.ort) = (yyvsp[(2) - (2)].ort); }
    break;

  case 154:
#line 801 "parser.yy"
    { (yyval.zahl) = (yyvsp[(1) - (1)].zahl); }
    break;

  case 155:
#line 802 "parser.yy"
    { (yyval.zahl) = (yyvsp[(1) - (1)].zahl); }
    break;

  case 156:
#line 808 "parser.yy"
    {
       /* Halbzahlen sollen intern aufgerundet gespeichert werden... */
       (yyval.zahl) = (yyvsp[(1) - (1)].zahl) + 1;
     }
    break;

  case 157:
#line 812 "parser.yy"
    { (yyval.zahl) = -(yyvsp[(2) - (2)].zahl); }
    break;

  case 158:
#line 815 "parser.yy"
    { (yyval.zahl) = (yyvsp[(1) - (1)].zahl); }
    break;

  case 159:
#line 816 "parser.yy"
    { (yyval.zahl) = -(yyvsp[(2) - (2)].zahl); }
    break;


/* Line 1267 of yacc.c.  */
#line 2920 "parser.cc"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse look-ahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEOF && yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


#line 820 "parser.yy"

/*****************************************************************************/






extern FILE * yyin;
int yyparse();
//void initLex();



int yyerror (const char * s)  /* Called by yyparse on error */
{
  PBEGIN_TRY
   throw Fehler(Str(s));
  PEND_TRY(;)
  return 0;
}


/* Öffnet die Datei mit dem angegebenen Namen und parst sie. Das
   Ergebnis wird in den Defknoten erg geschrieben. */
/** Komplettbeschreibung vom Parse-Vorgang siehe leveldaten.h */
void parse(const Str & name, DefKnoten * erg) {

  /* Datei öffnen, Lex initialisieren. Eigentlich bräuchte man
     kein pushLex und popLex ganz außen; aber es ist irgendwie
     sauberer. Vor allem ist dann sicher, dass ein Fehler in einem
     früheren Parsen keine Auswirkungen auf ein späteres Parsen
     hat.
     true = Default-Pfad merken für die Includes. (wird an den
            Pfaditerator weitergegeben.) */
  void * merkBuf = pushLex(name.data(), true);

  gDateiName = name;
  gZeilenNr = 1;
  gGabFehler = false;  /* Wenn es denn mal ein bison-Fehler-recovery gibt,
                         sollte gGabFehler dort auf true gesetzt werden */

  /* Das Parse-Ergebnis soll in den Knoten erg geschrieben werden. */
  gAktDefKnoten = erg;
  
  /* Hier findet das Parsen statt. Man beachte: Um Flex und Bison nicht
     zu verwirren, kann yyparse() nicht mit throw verlassen werden.
     Deshalb brauchen wir nix zu catchen, um alles wieder aufräumen zu
     können. */
  int perg = yyparse();
  
  /* Datei schließen, lex zurücksetzen. */
  popLex(merkBuf);
  
  
  /* Hier werden vermutlich mehr Bedingungen getestet als nötig. */
  if (perg || gGabFehler)
    throw Fehler(_("There have been errors parsing the level description files."));
  
}


