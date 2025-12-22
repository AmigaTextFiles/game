/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

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
/* Line 1489 of yacc.c.  */
#line 158 "parser.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



