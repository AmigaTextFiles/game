# include "stdio.h"
# define U(x) ((x)&0377)
# define NLSTATE yyprevious=YYNEWLINE
# define BEGIN yybgin = yysvec + 1 +
# define INITIAL 0
# define YYLERR yysvec
# define YYSTATE (yyestate-yysvec-1)
# define YYOPTIM 1
# define YYLMAX 200
# define output(c) putc(c,yyout)
# define input() (((yytchar=yysptr>yysbuf?U(*--yysptr):getc(yyin))==10?(yylineno++,yytchar):yytchar)==EOF?0:yytchar)
# define unput(c) {yytchar= (c);if(yytchar=='\n')yylineno--;*yysptr++=yytchar;}
# define yymore() (yymorfg=1)
# define ECHO fprintf(yyout, "%s",yytext)
# define REJECT { nstr = yyreject(); goto yyfussy;}
int yyleng; extern unsigned char yytext[];
int yymorfg;
extern unsigned char *yysptr, yysbuf[];
int yytchar;
FILE *yyin = {stdin}, *yyout = {stdout};
extern int yylineno;
struct yysvf { 
	struct yywork *yystoff;
	struct yysvf *yyother;
	int *yystops;};
struct yysvf *yyestate;
extern struct yysvf yysvec[], *yybgin;
/*
 * parser.l -- lex parser of algebraic chess moves for XBoard
 * $Id: parser.l,v 1.27 1995/07/28 05:23:42 mann Exp $
 *
 * Copyright 1991 by Digital Equipment Corporation, Maynard, Massachusetts.
 * Enhancements Copyright 1992-95 Free Software Foundation, Inc.
 *
 * The following terms apply to Digital Equipment Corporation's copyright
 * interest in XBoard:
 * ------------------------------------------------------------------------
 * All Rights Reserved
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose and without fee is hereby granted,
 * provided that the above copyright notice appear in all copies and that
 * both that copyright notice and this permission notice appear in
 * supporting documentation, and that the name of Digital not be
 * used in advertising or publicity pertaining to distribution of the
 * software without specific, written prior permission.
 *
 * DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
 * ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
 * DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
 * ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
 * WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
 * ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
 * SOFTWARE.
 * ------------------------------------------------------------------------
 *
 * The following terms apply to the enhanced version of XBoard distributed
 * by the Free Software Foundation:
 * ------------------------------------------------------------------------
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 * ------------------------------------------------------------------------
 */

/* This parser handles all forms of promotion.
 * The parser resolves ambiguous moves by searching and check-testing.
 * It also parses comments of the form [anything] or (anything).
 */

#include <config.h>

#define NO_CONSTRAINT	-1
#undef YYLMAX
#define YYLMAX			4096
#define UNPUT_BUF_SIZE		YYLMAX

#ifdef FLEX_SCANNER
/* typeof(yytext) == "char *" */
/* yy_text is set in YY_DECL below */
char *yy_text;
#else /*!FLEX_SCANNER*/
/* typeof(yytext) == "char []" */
char *yy_text = (char *) yytext;
#endif

#ifdef FLEX_SCANNER
/* This is flex */
#undef YY_INPUT
#define YY_INPUT(buf, result, max_size) my_yy_input(buf, &result, max_size)
#undef YY_DECL
#define YY_DECL                     \
    int _yylex YY_PROTO((void));    \
    int yylex YY_PROTO((void))      \
    {                               \
	int result = _yylex();      \
	yy_text = (char *) yytext;  \
	return(result);             \
    }                               \
    int _yylex YY_PROTO((void))
#else
/* This is lex */
#undef input
#undef output
#undef unput
#endif

/* The includes must be here, below the #undef input */

#include <ctype.h>

# if HAVE_STRING_H
#  include <string.h>
# else /* not HAVE_STRING_H */
#  include <strings.h>
# endif /* not HAVE_STRING_H */

#if HAVE_UNISTD_H
# include <unistd.h>
#endif

#if defined(_amigados)
# include <errno.h>
# if HAVE_FCNTL_H
#  include <fcntl.h>    /*  isatty() prototype  */
# endif /*  HAVE_FCNTL_H        */
#endif  /*  defined(_amigados)  */

#include "common.h"
#include "backend.h"
#include "frontend.h"
#include "parser.h"
#include "moves.h"

#define FakeFlags(index) \
    (((((index) % 2) == 0) ? F_WHITE_ON_MOVE : 0) | F_ALL_CASTLE_OK)

extern Board	boards[MAX_MOVES];
int		yyboardindex;
int             yyskipmoves = FALSE;
char		currentMoveString[YYLMAX];
#ifndef FLEX_SCANNER
char		unputBuffer[UNPUT_BUF_SIZE];
int		unputCount = 0;
#endif

#ifdef FLEX_SCANNER
void my_yy_input P((char *buf, int *result, int max_size));
#else /*!FLEX_SCANNER*/
static int input P((void));
static void output P((int ch));
static void unput P((int ch));
int yylook P((void));
int yyback P((int *, int));
#endif
#undef yywrap
int yywrap P((void));
extern void CopyBoard P((Board to, Board from));

# define YYNEWLINE 10
yylex(){
int nstr; extern int yyprevious;
while((nstr = yylook()) >= 0)
yyfussy: switch(nstr){
case 0:
if(yywrap()) return(0); break;
case 1:
{
    /*
     * Fully-qualified algebraic move, possibly with promotion
     */
    int skip1 = 0, skip2 = 0;
    ChessSquare piece;
    ChessMove result;
    
    if (yyskipmoves) return (int) AmbiguousMove; /* not disambiguated */

    /* remove the / */
    if (yytext[1] == '/') skip1 = 1;
    
    /* remove the [xX:-] */
    if ((yytext[3+skip1] == 'x') || (yytext[3+skip1] == 'X') ||
	(yytext[3+skip1] == '-') || (yytext[3+skip1] == ':')) skip2 = 1;
    
    currentMoveString[0] = yytext[1+skip1];
    currentMoveString[1] = yytext[2+skip1];
    currentMoveString[2] = yytext[3+skip1+skip2];
    currentMoveString[3] = yytext[4+skip1+skip2];
    currentMoveString[4] = NULLCHAR;
    
    if (yyleng-skip1-skip2 > 5) {
	if (yytext[yyleng-1] == ')') {
	    currentMoveString[4] = ToLower(yytext[yyleng-2]);
	} else {
	    currentMoveString[4] = ToLower(yytext[yyleng-1]);
	}
	currentMoveString[5] = NULLCHAR;
    }

    piece = boards[yyboardindex]
      [currentMoveString[1] - '1'][currentMoveString[0] - 'a'];
    if (ToLower(yytext[0]) != ToLower(PieceToChar(piece)))
      return (int) BadMove;

    result = LegalityTest(boards[yyboardindex],
			  FakeFlags(yyboardindex), EP_UNKNOWN,
			  currentMoveString[1] - '1',
			  currentMoveString[0] - 'a',
			  currentMoveString[3] - '1',
			  currentMoveString[2] - 'a',
			  currentMoveString[4]);

    if (currentMoveString[4] == NULLCHAR &&
	(result == WhitePromotionQueen || result == BlackPromotionQueen)) {
	currentMoveString[4] = 'q';
	currentMoveString[5] = NULLCHAR;
    }

    return (int) result;
}
break;
case 2:
{
    /*
     * Simple algebraic move, possibly with promotion
     */
    int skip = 0;
    ChessMove result;

    if (yyskipmoves) return (int) AmbiguousMove; /* not disambiguated */

    /* remove the [xX:-] */
    if ((yytext[2] == 'x') || (yytext[2] == 'X') ||
	(yytext[2] == '-') || (yytext[2] == ':')) skip = 1;

    currentMoveString[0] = yytext[0];
    currentMoveString[1] = yytext[1];
    currentMoveString[2] = yytext[2+skip];
    currentMoveString[3] = yytext[3+skip];
    currentMoveString[4] = NULLCHAR;

    if (yyleng-skip > 4) {
	if (yytext[yyleng-1] == ')') {
	    currentMoveString[4] = ToLower(yytext[yyleng-2]);
	} else {
	    currentMoveString[4] = ToLower(yytext[yyleng-1]);
	}
	currentMoveString[5] = NULLCHAR;
    }

    result = LegalityTest(boards[yyboardindex],
			  FakeFlags(yyboardindex), EP_UNKNOWN,
			  currentMoveString[1] - '1',
			  currentMoveString[0] - 'a',
			  currentMoveString[3] - '1',
			  currentMoveString[2] - 'a',
			  currentMoveString[4]);

    if (currentMoveString[4] == NULLCHAR &&
	(result == WhitePromotionQueen || result == BlackPromotionQueen)) {
	currentMoveString[4] = 'q';
	currentMoveString[5] = NULLCHAR;
    }

    return (int) result;
}
break;
case 3:
{
    /*
     * Pawn move, possibly with promotion
     */
    DisambiguateClosure cl;
    int skip = 0;

    if (yyskipmoves) return (int) AmbiguousMove; /* not disambiguated */

    /* remove the =() */
    if (yytext[2] == '=') skip++;
    if (yytext[2+skip] == '(') skip++;

    cl.pieceIn = WhiteOnMove(yyboardindex) ? WhitePawn : BlackPawn;
    cl.rfIn = -1;
    cl.ffIn = yytext[0] - 'a';
    cl.rtIn = yytext[1] - '1';
    cl.ftIn = yytext[0] - 'a';
    cl.promoCharIn = yytext[2+skip];
    Disambiguate(boards[yyboardindex],
		 FakeFlags(yyboardindex), EP_UNKNOWN, &cl);

    currentMoveString[0] = cl.ff + 'a';
    currentMoveString[1] = cl.rf + '1';
    currentMoveString[2] = cl.ft + 'a';
    currentMoveString[3] = cl.rt + '1';
    currentMoveString[4] = cl.promoChar;
    currentMoveString[5] = NULLCHAR;

    return (int) cl.kind;
}
break;
case 4:
{
    /*
     * Pawn capture, possibly with promotion, possibly ambiguous
     */
    DisambiguateClosure cl;
    int skip1 = 0, skip2 = 0;

    if (yyskipmoves) return (int) AmbiguousMove; /* not disambiguated */

    /* remove the [xX:-] and =() */
    if ((yytext[1] == 'x') || (yytext[1] == 'X')
	|| (yytext[1] == ':') || (yytext[1] == '-')) skip1 = 1;
    if (yytext[2+skip1] == '=') skip2++;
    if (yytext[2+skip1+skip2] == '(') skip2++;

    cl.pieceIn = WhiteOnMove(yyboardindex) ? WhitePawn : BlackPawn;
    cl.rfIn = -1;
    cl.ffIn = yytext[0] - 'a';
    cl.rtIn = -1;
    cl.ftIn = yytext[1+skip1] - 'a';
    cl.promoCharIn = yytext[2+skip1+skip2];
    Disambiguate(boards[yyboardindex],
		 FakeFlags(yyboardindex), EP_UNKNOWN, &cl);

    currentMoveString[0] = cl.ff + 'a';
    currentMoveString[1] = cl.rf + '1';
    currentMoveString[2] = cl.ft + 'a';
    currentMoveString[3] = cl.rt + '1';
    currentMoveString[4] = cl.promoChar;
    currentMoveString[5] = NULLCHAR;

    return (int) cl.kind;
}
break;
case 5:
{
    /*
     * unambiguously abbreviated Pawn capture, possibly with promotion
     */
    int skip = 0;
    ChessMove result;

    if (yyskipmoves) return (int) AmbiguousMove; /* not disambiguated */

    /* remove the [xX:-] */
    if ((yytext[1] == 'x') || (yytext[1] == 'X')
	|| (yytext[1] == ':') || (yytext[1] == '-')) skip = 1;

    currentMoveString[0] = yytext[0];
    currentMoveString[2] = yytext[1+skip];
    currentMoveString[3] = yytext[2+skip];
    if (WhiteOnMove(yyboardindex)) {
	if (yytext[2+skip] == '1') return (int) BadMove;
	currentMoveString[1] = yytext[2+skip] - 1;
    } else {
	if (yytext[2+skip] == '8') return (int) BadMove;
	currentMoveString[1] = yytext[2+skip] + 1;
    }
    if (yyleng-skip > 3) {
	if (yytext[yyleng-1] == ')')
	  currentMoveString[4] = ToLower(yytext[yyleng-2]);
	else
	  currentMoveString[4] = ToLower(yytext[yyleng-1]);
	currentMoveString[5] = NULLCHAR;
    } else {
	currentMoveString[4] = NULLCHAR;
    }

    result = LegalityTest(boards[yyboardindex],
			  FakeFlags(yyboardindex), EP_UNKNOWN,
			  currentMoveString[1] - '1',
			  currentMoveString[0] - 'a',
			  currentMoveString[3] - '1',
			  currentMoveString[2] - 'a',
			  currentMoveString[4]);

    if (currentMoveString[4] == NULLCHAR &&
	(result == WhitePromotionQueen || result == BlackPromotionQueen)) {
	currentMoveString[4] = 'q';
	currentMoveString[5] = NULLCHAR;
    }

    if (result != BadMove) return (int) result;

    /* Special case: improperly written en passant capture */
    if (WhiteOnMove(yyboardindex)) {
	if (currentMoveString[3] == '5') {
	    currentMoveString[1] = '5';
	    currentMoveString[3] = '6';
	} else {
	    return (int) BadMove;
	}
    } else {
	if (currentMoveString[3] == '4') {
	    currentMoveString[1] = '4';
	    currentMoveString[3] = '3';
	} else {
	    return (int) BadMove;
	}
    }

    result = LegalityTest(boards[yyboardindex],
			  FakeFlags(yyboardindex), EP_UNKNOWN,
			  currentMoveString[1] - '1',
			  currentMoveString[0] - 'a',
			  currentMoveString[3] - '1',
			  currentMoveString[2] - 'a',
			  currentMoveString[4]);

    if (result == WhiteCapturesEnPassant || result == BlackCapturesEnPassant)
      return (int) result;
    else
      return (int) BadMove;
}
break;
case 6:
 {
    /*
     * piece move, possibly ambiguous
     */
    DisambiguateClosure cl;
    int skip = 0;

    if (yyskipmoves) return (int) AmbiguousMove; /* not disambiguated */

    /* remove the [xX:-] */
    if ((yytext[1] == 'x') || (yytext[1] == 'X')
	|| (yytext[1] == ':') || (yytext[1] == '-')) skip = 1;

    if (WhiteOnMove(yyboardindex)) {
	cl.pieceIn = CharToPiece(ToUpper(yytext[0]));
    } else {
	cl.pieceIn = CharToPiece(ToLower(yytext[0]));
    }
    cl.rfIn = -1;
    cl.ffIn = -1;
    cl.rtIn = yytext[2+skip] - '1';
    cl.ftIn = yytext[1+skip] - 'a';
    cl.promoCharIn = NULLCHAR;
    Disambiguate(boards[yyboardindex],
		 FakeFlags(yyboardindex), EP_UNKNOWN, &cl);

    currentMoveString[0] = cl.ff + 'a';
    currentMoveString[1] = cl.rf + '1';
    currentMoveString[2] = cl.ft + 'a';
    currentMoveString[3] = cl.rt + '1';
    currentMoveString[4] = cl.promoChar;
    currentMoveString[5] = NULLCHAR;

    return (int) cl.kind;
}
break;
case 7:
{
    /*
     * piece move with rank or file disambiguator
     */
    DisambiguateClosure cl;
    int skip = 0;

    if (yyskipmoves) return (int) AmbiguousMove; /* not disambiguated */

    /* remove the [xX:-] */
    if ((yytext[2] == 'x') || (yytext[2] == 'X')
	|| (yytext[2] == ':') || (yytext[2] == '-')) skip = 1;

    if (WhiteOnMove(yyboardindex)) {
	cl.pieceIn = CharToPiece(ToUpper(yytext[0]));
    } else {
	cl.pieceIn = CharToPiece(ToLower(yytext[0]));
    }
    if (isalpha(yytext[1])) {
	cl.rfIn = -1;
	cl.ffIn = yytext[1] - 'a';
    } else {
	cl.rfIn = yytext[1] - '1';
	cl.ffIn = -1;
    }
    cl.rtIn = yytext[3+skip] - '1';
    cl.ftIn = yytext[2+skip] - 'a';
    cl.promoCharIn = NULLCHAR;
    Disambiguate(boards[yyboardindex],
		 FakeFlags(yyboardindex), EP_UNKNOWN, &cl);

    currentMoveString[0] = cl.ff + 'a';
    currentMoveString[1] = cl.rf + '1';
    currentMoveString[2] = cl.ft + 'a';
    currentMoveString[3] = cl.rt + '1';
    currentMoveString[4] = cl.promoChar;
    currentMoveString[5] = NULLCHAR;

    return (int) cl.kind;
}
break;
case 8:
{
    int rf, ff, rt, ft;

    if (yyskipmoves) return (int) AmbiguousMove; /* not disambiguated */

    if (WhiteOnMove(yyboardindex)) {
	if (boards[yyboardindex][0][3] == WhiteKing) {
	    /* ICS wild castling */
	    strcpy(currentMoveString, "d1f1");
	    rf = 0;
	    ff = 3;
	    rt = 0;
	    ft = 5;
	} else {
	    strcpy(currentMoveString, "e1c1");
	    rf = 0;
	    ff = 4;
	    rt = 0;
	    ft = 2;
	}
    } else{ 
	if (boards[yyboardindex][7][3] == BlackKing) {
	    /* ICS wild castling */
	    strcpy(currentMoveString, "d8f8");
	    rf = 7;
	    ff = 3;
	    rt = 7;
	    ft = 5;
	} else {
	    strcpy(currentMoveString, "e8c8");
	    rf = 7;
	    ff = 4;
	    rt = 7;
	    ft = 2;
	}
    }
    return (int) LegalityTest(boards[yyboardindex],
			      FakeFlags(yyboardindex), EP_UNKNOWN,
			      rf, ff, rt, ft, NULLCHAR);
}
break;
case 9:
{
    int rf, ff, rt, ft;

    if (yyskipmoves) return (int) AmbiguousMove; /* not disambiguated */

    if (WhiteOnMove(yyboardindex)) {
	if (boards[yyboardindex][0][3] == WhiteKing) {
	    /* ICS wild castling */
	    strcpy(currentMoveString, "d1b1");
	    rf = 0;
	    ff = 3;
	    rt = 0;
	    ft = 1;
	} else {
	    strcpy(currentMoveString, "e1g1");
	    rf = 0;
	    ff = 4;
	    rt = 0;
	    ft = 6;
	}
    } else {
	if (boards[yyboardindex][7][3] == BlackKing) {
	    /* ICS wild castling */
	    strcpy(currentMoveString, "d8b8");
	    rf = 7;
	    ff = 3;
	    rt = 7;
	    ft = 1;
	} else {
	    strcpy(currentMoveString, "e8g8");
	    rf = 7;
	    ff = 4;
	    rt = 7;
	    ft = 6;
	}
    }
    return (int) LegalityTest(boards[yyboardindex],
			      FakeFlags(yyboardindex), EP_UNKNOWN,
			      rf, ff, rt, ft, NULLCHAR);
}
break;
case 10:
 {
    if (WhiteOnMove(yyboardindex))
      return (int) BlackWins;
    else
      return (int) WhiteWins;
}
break;
case 11:
 {
    return (int) BlackWins;
}
break;
case 12:
 {
    return (int) WhiteWins;
}
break;
case 13:
 {
    return (int) WhiteWins;
}
break;
case 14:
 {
    return (int) BlackWins;
}
break;
case 15:
{
    return (int) GameUnfinished;
}
break;
case 16:
 {
    return (int) GameIsDrawn;
}
break;
case 17:
 {
    return (int) GameIsDrawn;
}
break;
case 18:
 {
    if (WhiteOnMove(yyboardindex))
      return (int) BlackWins;
    else
      return (int) WhiteWins;
}
break;
case 19:
 {
    if (WhiteOnMove(yyboardindex))
      return (int) BlackWins;
    else
      return (int) WhiteWins;
}
break;
case 20:
 {
    return (int) GameIsDrawn;
}
break;
case 21:
{
    return (int) GameIsDrawn;
}
break;
case 22:
 {
    return (int) GameIsDrawn;
}
break;
case 23:
{ 
    return (int) WhiteWins;
}
break;
case 24:
{ 
    return (int) BlackWins;
}
break;
case 25:
{ 
    return (int) BlackWins;
}
break;
case 26:
{ 
    return (int) WhiteWins;
}
break;
case 27:
{ 
    return (int) WhiteWins;
}
break;
case 28:
{ 
    return (int) BlackWins;
}
break;
case 29:
{
    return (int) GameIsDrawn;
}
break;
case 30:
{
    return (int) GameUnfinished;
}
break;
case 31:
   {
    /* move numbers */
    if ((yyleng == 1) && (yytext[0] == '1'))
      return (int) MoveNumberOne;
}
break;
case 32:
{
    /* elapsed time indication, e.g. (0:12) */ 
    return (int) ElapsedTime;
}
break;
case 33:
{
    /* position diagram enclosed in [-- --] */
    return (int) PositionDiagram;
}
break;
case 34:
{
    /* position diagram enclosed in {-- --} */
    return (int) PositionDiagram;
}
break;
case 35:
{
    return (int) PGNTag;
}
break;
case 36:
{
    return (int) GNUChessGame;
}
break;
case 37:
{
    return (int) XBoardGame;
}
break;
case 38:
{        			/* anything in {} */
    return (int) Comment; 
}
break;
case 39:
{                                          /* ; to end of line */
    return (int) Comment;
}
break;
case 40:
{        			/* anything in [] */
    return (int) Comment; 
}
break;
case 41:
 { 	  	/* nested () */
    return (int) Comment; 
}
break;
case 42:
  { 				/* >=2 chars in () */
    return (int) Comment; 
}
break;
case 43:
 {
        /* Skip mail headers */
}
break;
case 44:
		{
        /* Skip random words */
}
break;
case 45:
			{
        /* Skip everything else */
}
break;
case -1:
break;
default:
fprintf(yyout,"bad switch yylook %d",nstr);
} return(0); }
/* end of yylex */


static char *StringToLex;

#ifndef FLEX_SCANNER
static FILE *lexFP;

static int input()
{
    int ret;
    
    if (StringToLex != NULL) {
	ret = *StringToLex;
	if (ret == NULLCHAR)
	  ret = EOF;
	else
	  StringToLex++;
    } else if (unputCount > 0) {
	ret = unputBuffer[--unputCount];
    } else {
	ret = fgetc(lexFP);
    }    

    if (ret == EOF) 
      return 0;
    else
      return ret;
}

/*
 * Return offset of next pattern within current file
 */
int yyoffset()
{
    int offset = ftell(lexFP) - unputCount;

    if (offset < 0) {
	offset = 0;
    }
    return(offset);
}
 
static void output(ch)
     int ch;
{
    fprintf(stderr, "PARSER BUG: unmatched character '%c' (0%o)\n",
	    ch, ch);
}

static void unput(ch)
     int ch;
{
    if (ch == 0) return;
    if (StringToLex != NULL) {
	StringToLex--;
    } else {
	if (unputCount >= UNPUT_BUF_SIZE)
	  fprintf(stderr, "PARSER BUG: unput buffer overflow '%c' (0%o)\n",
		  ch, ch);
	unputBuffer[unputCount++] = ch;
    }
}

/* Get ready to lex from a new file.  Kludge below sticks
   an artificial newline at the front of the file, which the
   above grammar ignores, but which makes ^ at start of pattern
   match at the real start of the file.
*/
void yynewfile(f)
     FILE *f;
{
    lexFP = f;
    StringToLex = NULL;
    unputCount = 0;
    unput('\n'); /* kludge */
}

/* Get ready to lex from a string.  ^ at start of pattern WON'T
   match at the start of the string!
*/
void yynewstr(s)
     char *s;
{
    lexFP = NULL;
    StringToLex = s;
    unputCount = 0;
}
#endif /*!FLEX_SCANNER*/

#ifdef FLEX_SCANNER
void my_yy_input(buf, result, max_size)
     char *buf;
     int *result;
     int max_size;
{
    int count;

    if (StringToLex != NULL) {
	count = 0;
	while (*StringToLex != NULLCHAR) {
	    *buf++ = *StringToLex++;
	    count++;
	}
	*result = count;
	return;
    } else {
	count = fread(buf, 1, max_size, yyin);
	if (count == 0) {
	    *result = YY_NULL;
	} else {
	    *result = count;
	}
	return;
    }    
}

static YY_BUFFER_STATE my_file_buffer = NULL;

/*
    Return offset of next pattern in the current file.
*/
int yyoffset()
{
    int pos = yy_c_buf_p - yy_current_buffer->yy_ch_buf;

    return(ftell(yy_current_buffer->yy_input_file) -
         yy_n_chars + pos);
}


void yynewstr(s)
     char *s;
{
    if (my_file_buffer != NULL)
      yy_delete_buffer(my_file_buffer);
    StringToLex = s;
    my_file_buffer = yy_create_buffer(stdin, YY_BUF_SIZE);
    yy_switch_to_buffer(my_file_buffer);
}

void yynewfile(f)
     FILE *f;
{
    if (my_file_buffer != NULL)
      yy_delete_buffer(my_file_buffer);
    StringToLex = NULL;
    my_file_buffer = yy_create_buffer(f, YY_BUF_SIZE);
    yy_switch_to_buffer(my_file_buffer);
}
#endif /*FLEX_SCANNER*/

int yywrap()
{
    return TRUE;
}

/* Parse a move from the given string s */
/* ^ at start of pattern WON'T work here unless using flex */
ChessMove yylexstr(boardIndex, s)
     int boardIndex;
     char *s;
{
    ChessMove ret;
    char *oldStringToLex;
#ifdef FLEX_SCANNER
    YY_BUFFER_STATE buffer, oldBuffer;
#endif
    
    yyboardindex = boardIndex;
    oldStringToLex = StringToLex;
    StringToLex = s;
#ifdef FLEX_SCANNER
    buffer = yy_create_buffer(stdin, YY_BUF_SIZE);
    oldBuffer = YY_CURRENT_BUFFER;
    yy_switch_to_buffer(buffer);
#endif /*FLEX_SCANNER*/

    ret = (ChessMove) yylex();

#ifdef FLEX_SCANNER
    if (oldBuffer != NULL) 
      yy_switch_to_buffer(oldBuffer);
    yy_delete_buffer(buffer);
#endif /*FLEX_SCANNER*/
    StringToLex = oldStringToLex;

    return ret;
}
int yyvstop[] = {
0,

45,
0,

44,
45,
0,

45,
0,

30,
45,
0,

45,
0,

44,
45,
0,

44,
45,
-31,
0,

44,
45,
-31,
0,

45,
-39,
0,

24,
44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

23,
44,
45,
0,

45,
0,

44,
45,
0,

24,
44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

45,
0,

45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
-31,
0,

44,
45,
-31,
0,

45,
-39,
0,

24,
44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

23,
44,
45,
0,

44,
45,
0,

24,
44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

44,
45,
0,

45,
0,

44,
0,

19,
0,

44,
0,

9,
44,
0,

44,
0,

44,
-31,
0,

31,
44,
0,

-39,
0,

39,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

9,
44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

40,
0,

44,
0,

3,
44,
0,

44,
0,

44,
0,

4,
44,
0,

44,
0,

3,
44,
0,

44,
0,

4,
44,
0,

44,
0,

44,
0,

44,
0,

9,
44,
0,

38,
0,

44,
0,

43,
0,

44,
0,

9,
44,
0,

43,
0,

44,
0,

44,
-31,
0,

43,
0,

31,
44,
0,

-39,
0,

44,
0,

44,
0,

43,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

9,
44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

3,
44,
0,

43,
0,

44,
0,

44,
0,

4,
44,
0,

44,
0,

3,
44,
0,

43,
0,

44,
0,

4,
44,
0,

44,
0,

44,
0,

44,
0,

9,
44,
0,

17,
0,

9,
44,
0,

28,
44,
0,

28,
0,

8,
44,
0,

31,
0,

27,
44,
0,

27,
0,

29,
0,

44,
0,

44,
0,

44,
0,

44,
0,

6,
44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

9,
44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

4,
44,
0,

44,
0,

3,
44,
0,

44,
0,

3,
44,
0,

4,
0,

5,
44,
0,

4,
44,
0,

4,
44,
0,

44,
0,

44,
0,

3,
44,
0,

4,
0,

4,
44,
0,

5,
6,
44,
0,

4,
44,
0,

9,
44,
0,

38,
0,

9,
44,
0,

28,
44,
0,

8,
44,
0,

28,
43,
0,

27,
44,
0,

27,
43,
0,

39,
0,

-39,
0,

44,
0,

44,
0,

43,
0,

44,
0,

43,
0,

44,
0,

6,
44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

9,
44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

4,
44,
0,

44,
0,

43,
0,

3,
44,
0,

44,
0,

3,
44,
0,

4,
43,
0,

5,
44,
0,

4,
44,
0,

4,
44,
0,

44,
0,

43,
0,

44,
0,

3,
44,
0,

4,
43,
0,

4,
44,
0,

5,
6,
44,
0,

4,
44,
0,

9,
44,
0,

42,
0,

42,
0,

41,
0,

30,
0,

30,
0,

44,
0,

6,
44,
0,

7,
44,
0,

6,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

22,
44,
0,

44,
0,

18,
44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

40,
0,

3,
0,

3,
0,

2,
44,
0,

5,
0,

4,
0,

5,
44,
0,

4,
0,

2,
7,
44,
0,

5,
6,
0,

5,
6,
44,
0,

5,
44,
0,

44,
0,

30,
0,

43,
0,

44,
0,

43,
0,

43,
0,

-39,
0,

-39,
0,

6,
44,
0,

43,
0,

7,
44,
0,

6,
43,
0,

44,
0,

44,
0,

43,
0,

44,
0,

44,
0,

44,
0,

44,
0,

22,
44,
0,

44,
0,

18,
44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

43,
0,

2,
44,
0,

43,
0,

5,
43,
0,

43,
0,

4,
43,
0,

5,
44,
0,

43,
0,

2,
7,
44,
0,

5,
6,
43,
0,

5,
6,
44,
0,

5,
44,
0,

44,
0,

24,
0,

7,
0,

24,
44,
0,

1,
44,
0,

44,
0,

22,
44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

23,
0,

23,
44,
0,

35,
40,
0,

2,
0,

2,
44,
0,

5,
0,

5,
0,

2,
7,
0,

43,
0,

43,
0,

43,
0,

43,
0,

43,
0,

-39,
0,

-39,
0,

7,
43,
0,

24,
44,
0,

43,
0,

1,
44,
0,

44,
0,

22,
44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

44,
0,

23,
44,
0,

2,
43,
0,

2,
44,
0,

43,
0,

43,
0,

5,
43,
0,

4,
43,
0,

2,
7,
43,
0,

32,
42,
0,

28,
0,

28,
0,

27,
0,

27,
0,

29,
0,

29,
0,

26,
0,

24,
0,

1,
0,

1,
44,
0,

44,
0,

44,
0,

44,
0,

10,
44,
0,

44,
0,

44,
0,

25,
0,

23,
0,

33,
40,
0,

35,
0,

2,
0,

2,
0,

32,
38,
0,

28,
43,
0,

28,
43,
0,

27,
43,
0,

27,
43,
0,

-39,
0,

-39,
0,

1,
43,
0,

1,
44,
0,

44,
0,

44,
0,

44,
0,

10,
44,
0,

44,
0,

44,
0,

43,
0,

43,
0,

2,
43,
0,

5,
43,
0,

29,
0,

24,
0,

1,
0,

1,
0,

22,
0,

44,
0,

44,
0,

44,
0,

10,
44,
0,

44,
0,

44,
0,

23,
0,

-39,
0,

-39,
0,

43,
0,

43,
0,

1,
43,
0,

44,
0,

44,
0,

44,
0,

10,
44,
0,

44,
0,

44,
0,

2,
43,
0,

12,
0,

24,
0,

44,
0,

44,
0,

44,
0,

11,
0,

23,
0,

-39,
0,

-39,
0,

1,
43,
0,

44,
0,

44,
0,

44,
0,

12,
0,

44,
0,

16,
44,
0,

11,
0,

-39,
0,

-39,
0,

43,
0,

44,
0,

16,
44,
0,

21,
0,

44,
0,

44,
0,

-39,
0,

-39,
0,

43,
0,

44,
0,

44,
0,

21,
0,

44,
0,

44,
0,

-39,
0,

-39,
0,

43,
0,

43,
0,

44,
0,

44,
0,

36,
44,
0,

-37,
0,

-37,
-39,
0,

-39,
0,

43,
0,

43,
0,

36,
44,
0,

14,
0,

20,
0,

24,
0,

36,
0,

13,
0,

23,
0,

37,
0,

37,
39,
0,

-39,
0,

36,
43,
0,

26,
0,

20,
0,

25,
0,

-39,
0,

-39,
0,

15,
0,

38,
-34,
0,

34,
0,
0};
# define YYTYPE unsigned short
struct yywork { YYTYPE verify, advance; } yycrank[] = {
0,0,	0,0,	1,3,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	1,3,	1,3,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	1,3,	0,0,	1,3,	
1,3,	0,0,	1,3,	0,0,	
1,4,	1,5,	1,3,	1,6,	
1,7,	0,0,	1,4,	1,3,	
1,3,	1,8,	1,9,	1,10,	
1,10,	1,10,	1,10,	1,10,	
1,10,	1,10,	1,10,	1,3,	
1,11,	6,65,	1,3,	34,132,	
39,142,	0,0,	1,4,	1,12,	
1,13,	1,14,	1,4,	1,4,	
1,15,	1,4,	1,4,	18,98,	
1,16,	1,4,	1,17,	1,16,	
1,18,	1,19,	1,16,	1,20,	
1,21,	1,4,	46,157,	60,181,	
1,22,	1,4,	1,4,	7,66,	
1,23,	7,67,	1,3,	8,68,	
1,3,	67,190,	1,24,	1,25,	
1,26,	1,27,	1,28,	1,29,	
1,30,	1,31,	13,90,	32,126,	
8,69,	18,99,	8,70,	8,71,	
1,32,	69,194,	69,195,	2,34,	
1,21,	2,34,	65,188,	70,196,	
46,158,	8,72,	2,6,	59,179,	
1,33,	2,35,	1,3,	71,197,	
2,36,	2,37,	2,38,	2,38,	
2,38,	2,38,	2,38,	2,38,	
2,38,	2,38,	13,91,	2,39,	
14,92,	2,3,	15,94,	75,202,	
17,96,	2,35,	2,40,	2,41,	
2,42,	2,35,	2,35,	2,43,	
2,35,	2,35,	21,103,	2,44,	
2,35,	2,45,	2,44,	2,46,	
2,47,	2,44,	2,48,	2,49,	
2,35,	41,149,	42,151,	2,50,	
2,35,	2,35,	78,203,	2,23,	
14,93,	32,127,	15,95,	2,3,	
17,97,	2,51,	2,52,	2,53,	
2,54,	2,55,	2,56,	2,57,	
2,58,	43,153,	21,104,	45,155,	
49,162,	59,180,	76,203,	2,59,	
76,204,	87,218,	89,220,	2,49,	
4,61,	41,150,	42,152,	90,221,	
91,222,	65,189,	4,61,	2,60,	
92,223,	4,61,	4,61,	4,61,	
4,61,	4,61,	4,61,	4,61,	
4,61,	4,61,	4,61,	93,224,	
94,225,	43,154,	95,225,	45,156,	
49,163,	96,226,	4,61,	4,61,	
4,61,	4,61,	4,61,	4,61,	
4,61,	4,61,	4,61,	4,61,	
4,61,	4,61,	4,61,	4,61,	
4,61,	4,61,	4,61,	4,61,	
4,61,	4,61,	4,61,	4,61,	
4,61,	4,61,	4,61,	4,61,	
19,84,	97,227,	98,228,	22,105,	
99,197,	101,230,	4,61,	4,61,	
4,61,	4,61,	4,61,	4,61,	
4,61,	4,61,	4,61,	4,61,	
4,61,	4,61,	4,61,	4,61,	
4,61,	4,61,	4,61,	4,61,	
4,61,	4,61,	4,61,	4,61,	
4,61,	4,61,	4,61,	4,61,	
5,62,	36,68,	68,191,	103,232,	
68,192,	104,233,	106,240,	107,241,	
5,62,	5,62,	109,108,	22,106,	
50,105,	126,267,	36,135,	68,193,	
36,70,	36,136,	19,100,	19,100,	
19,100,	19,100,	19,100,	19,100,	
19,100,	19,100,	127,197,	36,137,	
74,199,	130,269,	74,200,	5,62,	
131,270,	5,62,	5,62,	136,275,	
5,62,	138,277,	5,62,	5,63,	
5,0,	74,201,	5,62,	22,107,	
5,62,	5,62,	5,62,	5,64,	
5,64,	128,128,	128,128,	140,278,	
50,164,	146,286,	47,84,	148,288,	
5,64,	5,62,	128,128,	135,273,	
135,274,	149,289,	150,290,	151,291,	
5,62,	5,62,	5,62,	5,62,	
5,62,	5,62,	5,62,	5,62,	
5,62,	152,292,	5,62,	5,62,	
5,62,	5,62,	5,62,	5,62,	
5,62,	5,62,	5,62,	5,62,	
50,165,	153,293,	5,62,	5,62,	
5,62,	9,73,	9,73,	154,293,	
5,62,	155,294,	156,295,	157,296,	
5,62,	5,62,	5,62,	5,62,	
5,62,	5,62,	5,62,	5,62,	
47,159,	47,159,	47,159,	47,159,	
47,159,	47,159,	47,159,	47,159,	
9,74,	158,275,	5,62,	83,212,	
83,212,	83,212,	83,212,	83,212,	
83,212,	83,212,	83,212,	160,298,	
5,62,	9,75,	9,73,	9,76,	
9,77,	9,77,	9,77,	9,77,	
9,77,	9,77,	9,77,	9,77,	
9,77,	9,77,	9,78,	162,300,	
64,0,	163,301,	164,302,	165,303,	
179,322,	180,275,	9,79,	64,186,	
64,186,	182,324,	183,325,	191,332,	
192,333,	193,334,	194,335,	9,79,	
64,186,	64,187,	9,79,	195,336,	
9,79,	9,79,	9,79,	10,73,	
10,73,	84,213,	84,213,	84,213,	
84,213,	84,213,	84,213,	84,213,	
84,213,	196,336,	199,337,	200,338,	
201,339,	9,79,	9,79,	9,79,	
9,79,	9,79,	9,79,	9,79,	
9,79,	181,323,	10,73,	9,79,	
181,128,	181,128,	9,79,	202,340,	
9,79,	9,79,	9,79,	203,340,	
218,360,	181,128,	205,343,	206,345,	
10,73,	220,364,	10,77,	10,77,	
10,77,	10,77,	10,77,	10,77,	
10,77,	10,77,	10,77,	10,77,	
86,217,	86,217,	86,217,	86,217,	
86,217,	86,217,	86,217,	86,217,	
10,79,	100,229,	100,229,	100,229,	
100,229,	100,229,	100,229,	100,229,	
100,229,	10,79,	205,344,	206,346,	
10,79,	186,324,	10,79,	10,79,	
10,79,	221,365,	11,80,	222,366,	
186,186,	186,186,	223,367,	207,347,	
224,367,	226,370,	11,80,	11,81,	
227,370,	186,186,	186,187,	10,79,	
10,79,	10,79,	10,79,	10,79,	
10,79,	10,79,	10,79,	208,348,	
209,350,	10,79,	228,371,	230,372,	
10,79,	225,368,	10,79,	10,79,	
10,79,	11,80,	231,373,	11,80,	
11,80,	232,374,	11,80,	207,347,	
11,80,	11,80,	11,80,	210,352,	
11,80,	187,324,	11,80,	11,80,	
11,80,	11,80,	11,80,	233,375,	
187,329,	187,329,	240,386,	208,349,	
209,351,	241,387,	11,80,	11,80,	
234,376,	187,329,	249,246,	235,378,	
225,369,	236,380,	11,80,	11,80,	
11,80,	11,80,	11,80,	11,80,	
11,80,	11,80,	11,80,	210,353,	
11,80,	11,80,	11,80,	11,80,	
11,80,	11,80,	11,80,	11,80,	
11,80,	11,80,	111,243,	111,243,	
11,80,	11,80,	11,80,	250,393,	
234,377,	204,341,	11,80,	235,379,	
225,369,	236,380,	11,80,	11,80,	
11,80,	11,80,	11,80,	11,80,	
11,80,	11,80,	204,342,	256,255,	
257,400,	111,243,	12,82,	111,244,	
111,111,	237,381,	238,383,	267,406,	
11,80,	273,414,	274,336,	204,342,	
111,111,	276,415,	111,111,	12,83,	
272,413,	12,84,	11,80,	12,85,	
12,85,	12,85,	12,85,	12,85,	
12,85,	12,85,	12,85,	277,340,	
12,86,	113,245,	113,245,	113,245,	
113,245,	113,245,	113,245,	113,245,	
113,245,	237,382,	238,384,	272,413,	
278,416,	285,422,	286,423,	16,83,	
288,427,	16,84,	12,87,	16,85,	
16,85,	16,85,	16,85,	16,85,	
16,85,	16,85,	16,85,	289,428,	
16,86,	290,429,	12,83,	115,253,	
115,253,	115,253,	115,253,	115,253,	
115,253,	115,253,	115,253,	12,88,	
12,88,	12,88,	12,88,	12,88,	
12,88,	12,88,	12,88,	269,407,	
269,407,	291,430,	12,89,	292,430,	
271,411,	270,408,	280,417,	294,432,	
269,407,	295,432,	16,83,	270,409,	
270,410,	271,412,	12,83,	280,418,	
296,433,	298,434,	299,435,	16,88,	
16,88,	16,88,	16,88,	16,88,	
16,88,	16,88,	16,88,	20,83,	
300,436,	20,84,	301,437,	20,85,	
20,85,	20,85,	20,85,	20,85,	
20,85,	20,85,	20,85,	302,438,	
20,86,	303,439,	16,83,	116,118,	
116,118,	116,118,	116,118,	116,118,	
116,118,	116,118,	116,118,	20,101,	
293,368,	307,393,	312,400,	322,452,	
211,354,	323,453,	326,0,	23,108,	
323,128,	323,128,	211,354,	330,0,	
331,0,	335,197,	343,463,	23,109,	
23,109,	323,128,	20,83,	117,254,	
117,254,	117,254,	117,254,	117,254,	
117,254,	117,254,	117,254,	20,88,	
20,88,	20,88,	20,88,	20,102,	
20,88,	20,88,	20,88,	293,431,	
211,354,	336,455,	23,109,	340,457,	
23,108,	23,108,	211,354,	23,108,	
342,461,	23,108,	23,108,	23,108,	
344,464,	23,108,	20,83,	23,110,	
23,108,	23,108,	23,111,	23,111,	
345,465,	346,466,	348,468,	239,385,	
347,467,	342,462,	349,469,	23,111,	
23,108,	239,385,	350,470,	293,431,	
351,471,	352,472,	353,473,	23,111,	
23,111,	23,111,	23,111,	23,111,	
23,111,	23,111,	23,111,	23,111,	
360,477,	23,111,	23,111,	23,111,	
23,111,	23,111,	23,111,	23,111,	
23,111,	23,111,	23,111,	239,385,	
347,467,	23,111,	23,111,	23,111,	
364,477,	239,385,	365,479,	23,112,	
366,479,	354,474,	368,482,	23,111,	
23,111,	23,111,	23,111,	23,111,	
23,111,	23,111,	23,111,	119,258,	
119,258,	119,258,	119,258,	119,258,	
119,258,	119,258,	119,258,	24,113,	
336,456,	23,111,	340,458,	24,114,	
24,114,	24,114,	24,114,	24,114,	
24,114,	24,114,	24,114,	23,108,	
24,115,	354,474,	368,482,	25,82,	
121,263,	121,263,	121,263,	121,263,	
121,263,	121,263,	121,263,	121,263,	
367,480,	371,197,	372,485,	373,486,	
25,119,	374,487,	25,84,	375,488,	
25,120,	25,120,	25,120,	25,120,	
25,120,	25,120,	25,120,	25,120,	
369,483,	25,121,	24,116,	122,264,	
122,264,	122,264,	122,264,	122,264,	
122,264,	122,264,	122,264,	24,117,	
24,118,	24,117,	24,117,	24,117,	
24,117,	24,117,	24,117,	25,87,	
376,489,	125,254,	125,254,	125,254,	
125,254,	125,254,	125,254,	125,254,	
125,254,	377,490,	367,481,	25,122,	
369,484,	378,491,	24,116,	379,492,	
381,494,	382,495,	383,496,	384,497,	
25,123,	25,124,	25,123,	25,124,	
25,124,	25,124,	25,124,	25,124,	
26,113,	386,499,	387,499,	25,89,	
26,114,	26,114,	26,114,	26,114,	
26,114,	26,114,	26,114,	26,114,	
391,393,	26,115,	367,481,	25,122,	
137,276,	137,134,	137,134,	137,134,	
137,134,	137,134,	137,134,	137,134,	
27,113,	125,222,	396,400,	26,90,	
27,114,	27,114,	27,114,	27,114,	
27,114,	27,114,	27,114,	27,114,	
380,493,	27,115,	385,498,	398,397,	
399,509,	406,197,	411,515,	26,116,	
143,281,	143,281,	143,281,	143,281,	
143,281,	143,281,	143,281,	143,281,	
26,117,	26,118,	26,117,	26,118,	
26,117,	26,117,	26,117,	26,125,	
412,516,	27,92,	407,511,	407,511,	
414,275,	417,522,	418,523,	27,116,	
380,493,	420,524,	385,498,	407,511,	
423,525,	415,518,	416,520,	26,116,	
27,117,	27,117,	27,118,	27,117,	
27,118,	27,117,	27,117,	27,117,	
145,285,	145,285,	145,285,	145,285,	
145,285,	145,285,	145,285,	145,285,	
427,525,	27,93,	428,528,	429,528,	
28,113,	433,275,	434,532,	27,116,	
28,114,	28,114,	28,114,	28,114,	
28,114,	28,114,	28,114,	28,114,	
409,68,	28,115,	159,297,	159,297,	
159,297,	159,297,	159,297,	159,297,	
159,297,	159,297,	435,533,	436,534,	
29,113,	409,512,	437,535,	409,70,	
29,114,	29,114,	29,114,	29,114,	
29,114,	29,114,	29,114,	29,114,	
438,536,	29,115,	409,72,	431,530,	
439,536,	440,537,	445,542,	28,116,	
166,304,	166,304,	166,304,	166,304,	
166,304,	166,304,	166,304,	166,304,	
28,117,	28,117,	28,117,	28,118,	
28,117,	28,118,	28,117,	28,117,	
415,519,	416,521,	446,509,	447,543,	
452,275,	454,545,	461,462,	29,116,	
430,480,	463,554,	464,555,	431,531,	
410,513,	465,556,	466,557,	28,116,	
29,117,	29,117,	29,117,	29,117,	
29,118,	29,117,	29,118,	29,117,	
30,113,	410,514,	468,560,	410,76,	
30,114,	30,114,	30,114,	30,114,	
30,114,	30,114,	30,114,	30,114,	
462,552,	30,115,	410,78,	29,116,	
168,310,	168,310,	168,310,	168,310,	
168,310,	168,310,	168,310,	168,310,	
469,561,	470,562,	471,563,	462,553,	
472,564,	473,565,	430,529,	31,113,	
477,569,	30,94,	246,391,	31,114,	
31,114,	31,114,	31,114,	31,114,	
31,114,	31,114,	31,114,	30,116,	
31,115,	479,573,	246,391,	481,480,	
482,578,	246,391,	246,391,	483,580,	
30,117,	30,117,	30,117,	30,117,	
30,117,	30,118,	30,117,	30,118,	
329,324,	484,581,	430,529,	33,128,	
485,582,	30,95,	246,391,	329,454,	
329,454,	486,582,	474,566,	33,128,	
33,129,	487,583,	31,116,	30,116,	
329,454,	479,573,	246,391,	488,584,	
482,579,	246,391,	246,391,	31,117,	
31,117,	31,117,	31,117,	31,117,	
31,117,	31,118,	31,117,	489,585,	
490,586,	491,587,	33,128,	341,459,	
33,128,	33,128,	492,588,	33,128,	
341,342,	33,128,	33,128,	33,128,	
494,591,	33,128,	31,116,	33,128,	
33,128,	33,128,	33,130,	33,130,	
453,544,	341,342,	495,592,	453,128,	
453,128,	496,593,	497,594,	33,130,	
33,128,	474,567,	499,597,	506,505,	
453,128,	507,601,	508,509,	33,128,	
33,128,	33,128,	33,128,	33,128,	
33,128,	33,128,	33,128,	33,128,	
515,603,	33,128,	33,128,	33,128,	
33,128,	33,128,	33,128,	33,128,	
33,128,	33,128,	33,128,	516,604,	
498,595,	33,128,	33,128,	33,128,	
522,609,	474,567,	523,610,	33,128,	
525,569,	526,611,	529,480,	33,128,	
33,128,	33,128,	33,128,	33,128,	
33,128,	33,128,	33,128,	169,171,	
169,171,	169,171,	169,171,	169,171,	
169,171,	169,171,	169,171,	530,614,	
531,615,	33,128,	341,460,	35,61,	
532,616,	533,616,	534,617,	535,618,	
536,597,	35,133,	467,558,	33,131,	
35,133,	35,133,	35,133,	35,133,	
35,133,	35,133,	35,133,	35,133,	
35,133,	35,133,	35,134,	498,596,	
538,601,	467,559,	528,613,	541,622,	
546,0,	35,133,	35,133,	35,133,	
35,133,	35,133,	35,133,	35,133,	
35,133,	35,133,	35,133,	35,133,	
35,133,	35,133,	35,133,	35,133,	
35,133,	35,133,	35,133,	35,133,	
35,133,	35,133,	35,133,	35,133,	
35,133,	35,133,	35,133,	498,596,	
467,558,	467,559,	528,613,	547,0,	
548,0,	35,133,	35,133,	35,133,	
35,133,	35,133,	35,133,	35,133,	
35,133,	35,133,	35,133,	35,133,	
35,133,	35,133,	35,133,	35,133,	
35,133,	35,133,	35,133,	35,133,	
35,133,	35,133,	35,133,	35,133,	
35,133,	35,133,	35,133,	37,73,	
37,73,	170,311,	170,311,	170,311,	
170,311,	170,311,	170,311,	170,311,	
170,311,	172,313,	172,313,	172,313,	
172,313,	172,313,	172,313,	172,313,	
172,313,	549,0,	513,199,	550,0,	
513,200,	551,0,	37,74,	174,318,	
174,318,	174,318,	174,318,	174,318,	
174,318,	174,318,	174,318,	513,201,	
552,624,	553,625,	554,626,	37,138,	
37,73,	37,76,	37,139,	37,139,	
37,139,	37,139,	37,139,	37,139,	
37,139,	37,139,	37,139,	37,139,	
37,140,	555,627,	556,628,	557,629,	
493,589,	558,559,	559,630,	560,631,	
37,141,	175,319,	175,319,	175,319,	
175,319,	175,319,	175,319,	175,319,	
175,319,	37,141,	561,631,	493,590,	
37,141,	562,632,	37,141,	37,141,	
37,141,	38,73,	38,73,	178,311,	
178,311,	178,311,	178,311,	178,311,	
178,311,	178,311,	178,311,	563,633,	
564,634,	558,559,	565,635,	37,141,	
37,141,	37,141,	37,141,	37,141,	
37,141,	37,141,	37,141,	85,214,	
38,73,	37,141,	493,589,	493,590,	
37,141,	567,566,	37,141,	37,141,	
37,141,	571,570,	572,640,	578,647,	
85,215,	579,648,	38,73,	580,649,	
38,139,	38,139,	38,139,	38,139,	
38,139,	38,139,	38,139,	38,139,	
38,139,	38,139,	581,650,	569,639,	
573,96,	442,445,	583,653,	178,290,	
575,642,	584,654,	38,141,	585,655,	
586,656,	566,636,	511,128,	511,128,	
587,657,	442,445,	85,214,	38,141,	
442,445,	442,445,	38,141,	511,128,	
38,141,	38,141,	38,141,	85,216,	
85,216,	85,216,	85,216,	85,216,	
85,216,	85,216,	85,216,	569,639,	
573,97,	442,445,	503,503,	503,503,	
575,643,	38,141,	38,141,	38,141,	
38,141,	38,141,	38,141,	38,141,	
38,141,	40,82,	85,214,	38,141,	
566,637,	576,644,	38,141,	577,645,	
38,141,	38,141,	38,141,	588,658,	
590,659,	503,503,	40,143,	591,660,	
40,84,	592,660,	40,144,	40,144,	
40,144,	40,144,	40,144,	40,144,	
40,144,	40,144,	593,661,	40,145,	
212,355,	212,355,	212,355,	212,355,	
212,355,	212,355,	212,355,	212,355,	
566,637,	576,644,	594,662,	577,646,	
596,595,	600,601,	44,143,	511,602,	
44,84,	40,146,	44,144,	44,144,	
44,144,	44,144,	44,144,	44,144,	
44,144,	44,144,	589,590,	44,145,	
603,665,	40,143,	213,356,	213,356,	
213,356,	213,356,	213,356,	213,356,	
213,356,	213,356,	40,147,	40,147,	
40,147,	40,147,	40,147,	40,147,	
40,147,	40,147,	503,599,	544,623,	
604,666,	40,148,	544,128,	544,128,	
609,667,	610,668,	612,640,	614,672,	
613,155,	44,143,	589,590,	544,128,	
615,673,	40,143,	617,676,	618,677,	
621,678,	624,680,	44,147,	44,147,	
44,147,	44,147,	44,147,	44,147,	
44,147,	44,147,	48,143,	625,681,	
48,84,	595,663,	48,144,	48,144,	
48,144,	48,144,	48,144,	48,144,	
48,144,	48,144,	626,682,	48,145,	
613,156,	44,143,	214,216,	214,216,	
214,216,	214,216,	214,216,	214,216,	
214,216,	214,216,	48,160,	51,166,	
627,683,	628,684,	629,685,	51,167,	
51,167,	51,167,	51,167,	51,167,	
51,167,	51,167,	51,167,	630,686,	
51,168,	632,687,	633,687,	634,688,	
595,664,	48,143,	215,357,	215,357,	
215,357,	215,357,	215,357,	215,357,	
215,357,	215,357,	48,147,	48,147,	
48,147,	48,147,	48,161,	48,147,	
48,147,	48,147,	216,358,	216,358,	
216,358,	216,358,	216,358,	216,358,	
216,358,	216,358,	51,169,	630,686,	
635,688,	638,640,	52,82,	641,0,	
595,664,	48,143,	642,693,	51,170,	
51,171,	51,170,	51,170,	51,170,	
51,170,	51,170,	51,170,	52,172,	
643,694,	52,84,	644,695,	52,173,	
52,173,	52,173,	52,173,	52,173,	
52,173,	52,173,	52,173,	645,696,	
52,174,	646,697,	51,169,	217,359,	
217,359,	217,359,	217,359,	217,359,	
217,359,	217,359,	217,359,	647,698,	
648,699,	649,700,	650,700,	653,701,	
637,690,	639,691,	52,146,	247,251,	
247,251,	247,251,	247,251,	247,251,	
247,251,	247,251,	247,251,	651,652,	
654,702,	655,703,	52,175,	248,392,	
248,392,	248,392,	248,392,	248,392,	
248,392,	248,392,	248,392,	52,176,	
52,177,	52,176,	52,177,	52,177,	
52,177,	52,177,	52,177,	53,166,	
637,690,	639,692,	52,148,	53,167,	
53,167,	53,167,	53,167,	53,167,	
53,167,	53,167,	53,167,	651,652,	
53,168,	656,704,	52,175,	251,394,	
251,394,	251,394,	251,394,	251,394,	
251,394,	251,394,	251,394,	54,166,	
657,705,	658,706,	53,149,	54,167,	
54,167,	54,167,	54,167,	54,167,	
54,167,	54,167,	54,167,	252,393,	
54,168,	659,707,	661,708,	662,708,	
664,710,	665,711,	53,169,	252,394,	
252,394,	252,394,	252,394,	252,394,	
252,394,	252,394,	252,394,	53,170,	
53,171,	53,170,	53,171,	53,170,	
53,170,	53,170,	53,178,	623,679,	
54,151,	666,712,	623,128,	623,128,	
667,713,	668,714,	54,169,	671,715,	
672,716,	659,707,	673,716,	623,128,	
664,710,	676,717,	53,169,	54,170,	
54,170,	54,171,	54,170,	54,171,	
54,170,	54,170,	54,170,	259,261,	
259,261,	259,261,	259,261,	259,261,	
259,261,	259,261,	259,261,	677,718,	
54,152,	682,720,	683,720,	55,166,	
684,688,	681,459,	54,169,	55,167,	
55,167,	55,167,	55,167,	55,167,	
55,167,	55,167,	55,167,	685,688,	
55,168,	260,401,	260,401,	260,401,	
260,401,	260,401,	260,401,	260,401,	
260,401,	687,722,	689,0,	56,166,	
690,725,	691,726,	692,727,	56,167,	
56,167,	56,167,	56,167,	56,167,	
56,167,	56,167,	56,167,	674,675,	
56,168,	686,721,	693,728,	694,729,	
696,730,	697,731,	55,169,	261,402,	
261,402,	261,402,	261,402,	261,402,	
261,402,	261,402,	261,402,	55,170,	
55,170,	55,170,	55,171,	55,170,	
55,171,	55,170,	55,170,	679,719,	
698,732,	699,732,	679,128,	679,128,	
701,734,	702,734,	56,169,	674,675,	
703,735,	686,721,	704,735,	679,128,	
705,708,	706,708,	55,169,	56,170,	
56,170,	56,170,	56,170,	56,171,	
56,170,	56,171,	56,170,	57,166,	
681,460,	255,396,	480,574,	57,167,	
57,167,	57,167,	57,167,	57,167,	
57,167,	57,167,	57,167,	262,393,	
57,168,	255,396,	56,169,	582,651,	
255,396,	255,396,	707,736,	262,402,	
262,402,	262,402,	262,402,	262,402,	
262,402,	262,402,	262,402,	480,575,	
480,576,	582,652,	58,166,	709,0,	
57,153,	255,396,	58,167,	58,167,	
58,167,	58,167,	58,167,	58,167,	
58,167,	58,167,	57,169,	58,168,	
480,577,	255,396,	710,739,	582,651,	
255,396,	255,396,	707,736,	57,170,	
57,170,	57,170,	57,170,	57,170,	
57,171,	57,170,	57,171,	480,575,	
480,576,	582,652,	62,182,	711,740,	
57,154,	539,541,	712,741,	713,742,	
714,743,	717,746,	62,182,	62,182,	
718,746,	58,169,	57,169,	720,748,	
480,577,	539,541,	721,749,	726,752,	
539,541,	539,541,	58,170,	58,170,	
58,170,	58,170,	58,170,	58,170,	
58,171,	58,170,	722,750,	727,753,	
723,724,	62,182,	728,754,	62,182,	
62,182,	539,541,	62,182,	729,754,	
62,182,	62,183,	62,0,	730,755,	
62,182,	58,169,	62,182,	62,182,	
62,182,	62,182,	62,182,	719,747,	
731,756,	735,760,	719,128,	719,128,	
736,761,	740,763,	62,182,	62,182,	
725,751,	616,674,	722,750,	719,128,	
723,724,	737,738,	62,182,	62,182,	
62,182,	62,182,	62,182,	62,182,	
62,182,	62,182,	62,182,	616,675,	
62,182,	62,182,	62,182,	62,182,	
62,182,	62,182,	62,182,	62,182,	
62,182,	62,182,	741,764,	742,765,	
62,182,	62,182,	62,182,	245,255,	
725,751,	616,674,	62,182,	688,723,	
743,766,	737,738,	62,182,	62,182,	
62,182,	62,182,	62,182,	62,182,	
62,182,	62,182,	63,183,	616,675,	
752,778,	688,724,	753,779,	695,575,	
245,256,	755,783,	63,183,	63,183,	
62,182,	245,257,	263,403,	263,403,	
263,403,	263,403,	263,403,	263,403,	
263,403,	263,403,	62,182,	688,723,	
695,577,	245,257,	756,784,	763,794,	
245,257,	245,257,	739,762,	764,795,	
749,773,	63,183,	765,796,	63,183,	
63,183,	688,724,	63,183,	695,575,	
63,183,	63,184,	63,185,	748,771,	
63,183,	245,257,	63,183,	63,183,	
63,183,	63,183,	63,183,	747,770,	
766,797,	733,0,	747,128,	747,128,	
695,577,	245,257,	63,183,	63,183,	
245,257,	245,257,	739,762,	747,128,	
749,773,	748,772,	63,183,	63,183,	
63,183,	63,183,	63,183,	63,183,	
63,183,	63,183,	63,183,	748,771,	
63,183,	63,183,	63,183,	63,183,	
63,183,	63,183,	63,183,	63,183,	
63,183,	63,183,	73,73,	73,73,	
63,183,	63,183,	63,183,	771,803,	
774,808,	759,0,	63,183,	775,809,	
254,397,	748,772,	63,183,	63,183,	
63,183,	63,183,	63,183,	63,183,	
63,183,	63,183,	310,442,	708,737,	
733,758,	73,73,	750,774,	776,810,	
777,811,	619,621,	751,776,	310,443,	
63,183,	254,398,	761,791,	82,205,	
778,812,	708,738,	254,399,	73,73,	
82,206,	619,621,	63,183,	310,444,	
619,621,	619,621,	82,207,	82,208,	
310,445,	82,209,	254,399,	762,792,	
82,210,	254,399,	254,399,	708,737,	
733,759,	82,211,	750,775,	73,198,	
310,445,	619,621,	751,777,	310,445,	
310,445,	779,813,	761,791,	82,205,	
73,198,	708,738,	254,399,	73,198,	
82,206,	73,198,	73,198,	73,198,	
77,73,	77,73,	82,207,	82,208,	
310,445,	82,209,	254,399,	762,793,	
82,210,	254,399,	254,399,	781,814,	
782,815,	82,211,	73,198,	73,198,	
73,198,	73,198,	73,198,	73,198,	
73,198,	73,198,	783,816,	77,73,	
73,198,	144,282,	784,817,	73,198,	
789,821,	73,198,	73,198,	73,198,	
759,788,	792,826,	793,827,	794,828,	
795,829,	77,73,	144,283,	77,77,	
77,77,	77,77,	77,77,	77,77,	
77,77,	77,77,	77,77,	77,77,	
77,77,	796,830,	797,831,	804,836,	
788,0,	772,804,	88,214,	773,806,	
787,0,	77,79,	88,219,	88,219,	
88,219,	88,219,	88,219,	88,219,	
88,219,	88,219,	77,79,	88,215,	
144,282,	77,79,	790,822,	77,79,	
77,79,	77,79,	805,836,	806,837,	
807,838,	144,284,	144,284,	144,284,	
144,284,	144,284,	144,284,	144,284,	
144,284,	772,805,	808,839,	773,807,	
77,79,	77,79,	77,79,	77,79,	
77,79,	77,79,	77,79,	77,79,	
758,0,	88,214,	77,79,	809,839,	
144,282,	77,79,	790,823,	77,79,	
77,79,	77,79,	88,216,	88,216,	
88,216,	88,216,	88,216,	88,216,	
88,216,	88,216,	102,214,	787,820,	
669,671,	810,840,	102,219,	102,219,	
102,219,	102,219,	102,219,	102,219,	
102,219,	102,219,	266,400,	102,215,	
669,671,	88,214,	811,840,	669,671,	
669,671,	812,841,	266,358,	266,358,	
266,358,	266,358,	266,358,	266,358,	
266,358,	266,358,	105,234,	788,820,	
813,842,	814,843,	815,844,	105,235,	
669,671,	219,361,	791,824,	799,744,	
444,442,	105,236,	105,237,	803,772,	
816,845,	102,214,	817,846,	105,238,	
820,0,	822,848,	219,362,	758,787,	
105,239,	397,508,	102,216,	102,216,	
102,216,	102,216,	102,216,	102,216,	
102,216,	102,216,	105,234,	108,108,	
108,108,	397,508,	444,445,	105,235,	
397,508,	397,508,	791,825,	799,833,	
102,231,	105,236,	105,237,	803,772,	
823,848,	102,214,	444,445,	105,238,	
219,361,	444,445,	444,445,	758,700,	
105,239,	397,508,	108,108,	824,849,	
825,850,	219,363,	219,363,	219,363,	
219,363,	219,363,	219,363,	219,363,	
219,363,	397,508,	444,445,	108,108,	
397,508,	397,508,	108,108,	108,108,	
770,802,	826,851,	802,835,	770,128,	
770,128,	802,128,	802,128,	108,108,	
219,361,	821,790,	827,851,	829,853,	
770,128,	831,855,	802,128,	108,108,	
108,108,	108,108,	108,108,	108,108,	
108,108,	108,108,	108,108,	108,108,	
837,858,	108,108,	108,108,	108,108,	
108,108,	108,108,	108,108,	108,108,	
108,108,	108,108,	108,108,	110,108,	
110,108,	108,108,	108,108,	108,108,	
838,858,	821,790,	840,860,	841,861,	
839,859,	842,862,	754,780,	108,108,	
108,108,	108,108,	108,108,	108,108,	
108,108,	108,108,	108,108,	754,781,	
835,857,	760,789,	110,108,	835,128,	
835,128,	843,780,	844,780,	845,863,	
846,864,	108,108,	849,865,	850,865,	
835,128,	851,866,	853,867,	110,242,	
855,868,	860,636,	110,108,	110,108,	
839,859,	861,870,	754,780,	760,790,	
862,871,	863,780,	864,780,	110,108,	
866,663,	867,872,	868,873,	754,782,	
870,875,	760,789,	871,875,	110,108,	
110,108,	110,108,	110,108,	110,108,	
110,108,	110,108,	110,108,	110,108,	
873,830,	110,108,	110,108,	110,108,	
110,108,	110,108,	110,108,	110,108,	
110,108,	110,108,	110,108,	760,790,	
879,880,	110,108,	110,108,	110,108,	
114,246,	880,881,	881,882,	877,878,	
882,883,	114,247,	883,884,	110,108,	
110,108,	110,108,	110,108,	110,108,	
110,108,	110,108,	110,108,	884,885,	
885,886,	886,887,	114,248,	887,888,	
888,889,	114,249,	889,890,	890,891,	
891,892,	110,108,	114,250,	281,419,	
281,419,	281,419,	281,419,	281,419,	
281,419,	281,419,	281,419,	877,878,	
892,893,	893,894,	114,250,	894,895,	
0,0,	114,250,	114,250,	0,0,	
0,0,	0,0,	0,0,	0,0,	
114,247,	282,284,	282,284,	282,284,	
282,284,	282,284,	282,284,	282,284,	
282,284,	114,251,	114,252,	114,251,	
114,251,	114,251,	114,251,	114,251,	
114,251,	857,869,	229,361,	0,0,	
857,128,	857,128,	114,250,	0,0,	
118,255,	114,250,	114,250,	0,0,	
0,0,	857,128,	0,0,	229,362,	
114,247,	118,254,	118,254,	118,254,	
118,254,	118,254,	118,254,	118,254,	
118,254,	0,0,	120,246,	0,0,	
0,0,	118,256,	0,0,	120,259,	
0,0,	874,876,	118,257,	283,420,	
283,420,	283,420,	283,420,	283,420,	
283,420,	283,420,	283,420,	0,0,	
120,260,	229,361,	118,257,	120,249,	
0,0,	118,257,	118,257,	0,0,	
120,250,	0,0,	229,363,	229,363,	
229,363,	229,363,	229,363,	229,363,	
229,363,	229,363,	0,0,	0,0,	
120,250,	0,0,	118,257,	120,250,	
120,250,	0,0,	0,0,	874,128,	
874,128,	0,0,	120,259,	0,0,	
0,0,	229,361,	118,257,	540,539,	
874,128,	118,257,	118,257,	120,261,	
120,262,	120,261,	120,261,	120,261,	
120,261,	120,261,	120,261,	0,0,	
0,0,	0,0,	0,0,	0,0,	
120,250,	0,0,	123,255,	120,250,	
120,250,	0,0,	0,0,	123,214,	
0,0,	540,541,	120,259,	123,265,	
123,265,	123,265,	123,265,	123,265,	
123,265,	123,265,	123,265,	0,0,	
123,215,	540,541,	0,0,	123,256,	
540,541,	540,541,	0,0,	0,0,	
123,257,	284,421,	284,421,	284,421,	
284,421,	284,421,	284,421,	284,421,	
284,421,	0,0,	0,0,	0,0,	
123,257,	540,541,	0,0,	123,257,	
123,257,	0,0,	0,0,	0,0,	
0,0,	0,0,	123,214,	305,308,	
305,308,	305,308,	305,308,	305,308,	
305,308,	305,308,	305,308,	123,216,	
123,266,	123,216,	123,216,	123,216,	
123,216,	123,216,	123,216,	0,0,	
0,0,	0,0,	0,0,	0,0,	
123,257,	0,0,	0,0,	123,257,	
123,257,	0,0,	0,0,	124,214,	
0,0,	0,0,	123,214,	124,265,	
124,265,	124,265,	124,265,	124,265,	
124,265,	124,265,	124,265,	0,0,	
124,215,	306,440,	306,440,	306,440,	
306,440,	306,440,	306,440,	306,440,	
306,440,	308,441,	308,441,	308,441,	
308,441,	308,441,	308,441,	308,441,	
308,441,	869,874,	0,0,	129,129,	
869,128,	869,128,	0,0,	309,393,	
0,0,	0,0,	0,0,	129,129,	
0,0,	869,128,	124,214,	309,441,	
309,441,	309,441,	309,441,	309,441,	
309,441,	309,441,	309,441,	124,216,	
124,216,	124,216,	124,216,	124,216,	
124,216,	124,216,	124,216,	0,0,	
0,0,	0,0,	129,129,	0,0,	
129,129,	129,129,	0,0,	129,129,	
0,0,	129,129,	129,129,	129,129,	
0,0,	129,129,	124,214,	129,129,	
129,129,	129,129,	129,129,	129,129,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	129,129,	
129,129,	0,0,	875,877,	0,0,	
0,0,	0,0,	0,0,	129,129,	
129,129,	129,129,	129,129,	129,129,	
129,129,	129,129,	129,129,	129,129,	
875,878,	129,129,	129,129,	129,129,	
129,129,	129,129,	129,129,	129,129,	
129,129,	129,129,	129,129,	0,0,	
0,0,	129,129,	129,129,	129,129,	
304,255,	0,0,	875,877,	129,129,	
0,0,	0,0,	0,0,	129,129,	
129,129,	129,129,	129,129,	129,129,	
129,129,	129,129,	129,129,	132,132,	
875,878,	0,0,	0,0,	0,0,	
0,0,	304,256,	0,0,	132,132,	
132,132,	129,129,	304,312,	314,316,	
314,316,	314,316,	314,316,	314,316,	
314,316,	314,316,	314,316,	129,268,	
0,0,	0,0,	304,312,	0,0,	
0,0,	304,312,	304,312,	0,0,	
0,0,	0,0,	132,271,	0,0,	
132,132,	132,132,	0,0,	132,132,	
0,0,	132,132,	132,132,	132,132,	
0,0,	132,132,	304,312,	132,132,	
132,132,	132,132,	132,132,	132,132,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	304,312,	132,132,	
132,132,	304,312,	304,312,	0,0,	
0,0,	0,0,	0,0,	132,132,	
132,132,	132,132,	132,132,	132,132,	
132,132,	132,132,	132,132,	132,132,	
0,0,	132,132,	132,132,	132,132,	
132,132,	132,132,	132,132,	132,132,	
132,132,	132,132,	132,132,	0,0,	
0,0,	132,132,	132,132,	132,132,	
311,397,	0,0,	0,0,	132,132,	
0,0,	0,0,	0,0,	132,132,	
132,132,	132,132,	132,132,	132,132,	
132,132,	132,132,	132,132,	134,134,	
0,0,	0,0,	0,0,	0,0,	
0,0,	311,398,	0,0,	134,134,	
134,272,	132,132,	311,446,	315,447,	
315,447,	315,447,	315,447,	315,447,	
315,447,	315,447,	315,447,	132,132,	
0,0,	0,0,	311,446,	0,0,	
0,0,	311,446,	311,446,	0,0,	
0,0,	0,0,	134,134,	0,0,	
134,134,	134,134,	0,0,	134,134,	
0,0,	134,134,	134,134,	134,134,	
0,0,	134,134,	311,446,	134,134,	
134,134,	134,134,	134,134,	134,134,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	311,446,	134,134,	
134,134,	311,446,	311,446,	0,0,	
0,0,	0,0,	0,0,	134,134,	
134,134,	134,134,	134,134,	134,134,	
134,134,	134,134,	134,134,	134,134,	
0,0,	134,134,	134,134,	134,134,	
134,134,	134,134,	134,134,	134,134,	
134,134,	134,134,	134,134,	0,0,	
0,0,	134,134,	134,134,	134,134,	
139,73,	139,73,	0,0,	134,134,	
0,0,	0,0,	287,424,	134,134,	
134,134,	134,134,	134,134,	134,134,	
134,134,	134,134,	134,134,	0,0,	
0,0,	0,0,	0,0,	287,425,	
0,0,	0,0,	0,0,	139,73,	
0,0,	134,134,	316,448,	316,448,	
316,448,	316,448,	316,448,	316,448,	
316,448,	316,448,	0,0,	134,134,	
0,0,	139,73,	505,600,	139,139,	
139,139,	139,139,	139,139,	139,139,	
139,139,	139,139,	139,139,	139,139,	
139,139,	287,424,	505,600,	0,0,	
0,0,	505,600,	505,600,	0,0,	
0,0,	139,141,	287,426,	287,426,	
287,426,	287,426,	287,426,	287,426,	
287,426,	287,426,	139,141,	0,0,	
0,0,	139,141,	505,600,	139,141,	
139,141,	139,141,	0,0,	142,142,	
0,0,	0,0,	0,0,	0,0,	
0,0,	287,424,	505,600,	142,142,	
142,279,	505,600,	505,600,	0,0,	
139,141,	139,141,	139,141,	139,141,	
139,141,	139,141,	139,141,	139,141,	
0,0,	0,0,	139,141,	0,0,	
0,0,	139,141,	0,0,	139,141,	
139,141,	139,141,	142,280,	0,0,	
142,142,	142,142,	0,0,	142,142,	
0,0,	142,142,	142,142,	142,142,	
0,0,	142,142,	0,0,	142,142,	
142,142,	142,142,	142,142,	142,142,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	142,142,	
142,142,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	142,142,	
142,142,	142,142,	142,142,	142,142,	
142,142,	142,142,	142,142,	142,142,	
0,0,	142,142,	142,142,	142,142,	
142,142,	142,142,	142,142,	142,142,	
142,142,	142,142,	142,142,	0,0,	
0,0,	142,142,	142,142,	142,142,	
0,0,	0,0,	0,0,	142,142,	
0,0,	0,0,	0,0,	142,142,	
142,142,	142,142,	142,142,	142,142,	
142,142,	142,142,	142,142,	357,476,	
357,476,	357,476,	357,476,	357,476,	
357,476,	357,476,	357,476,	147,282,	
0,0,	142,142,	0,0,	147,287,	
147,287,	147,287,	147,287,	147,287,	
147,287,	147,287,	147,287,	142,142,	
147,283,	361,363,	361,363,	361,363,	
361,363,	361,363,	361,363,	361,363,	
361,363,	0,0,	0,0,	161,282,	
0,0,	0,0,	0,0,	161,287,	
161,287,	161,287,	161,287,	161,287,	
161,287,	161,287,	161,287,	317,393,	
161,283,	0,0,	0,0,	0,0,	
0,0,	0,0,	147,282,	317,448,	
317,448,	317,448,	317,448,	317,448,	
317,448,	317,448,	317,448,	147,284,	
147,284,	147,284,	147,284,	147,284,	
147,284,	147,284,	147,284,	0,0,	
0,0,	0,0,	0,0,	318,442,	
0,0,	167,246,	161,282,	0,0,	
0,0,	0,0,	167,305,	0,0,	
318,449,	0,0,	147,282,	161,284,	
161,284,	161,284,	161,284,	161,284,	
161,284,	161,284,	161,284,	167,306,	
318,444,	0,0,	167,249,	0,0,	
0,0,	318,445,	0,0,	167,307,	
0,0,	161,299,	0,0,	0,0,	
0,0,	0,0,	161,282,	0,0,	
0,0,	318,445,	0,0,	167,307,	
318,445,	318,445,	167,307,	167,307,	
0,0,	0,0,	0,0,	0,0,	
0,0,	167,305,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	318,445,	167,308,	167,309,	
167,308,	167,308,	167,308,	167,308,	
167,308,	167,308,	0,0,	297,424,	
0,0,	0,0,	0,0,	167,307,	
0,0,	171,255,	167,307,	167,307,	
0,0,	0,0,	0,0,	0,0,	
297,425,	167,305,	171,311,	171,311,	
171,311,	171,311,	171,311,	171,311,	
171,311,	171,311,	0,0,	173,246,	
321,400,	0,0,	171,256,	0,0,	
173,314,	0,0,	0,0,	171,312,	
321,421,	321,421,	321,421,	321,421,	
321,421,	321,421,	321,421,	321,421,	
0,0,	173,315,	297,424,	171,312,	
173,249,	0,0,	171,312,	171,312,	
0,0,	173,307,	0,0,	297,426,	
297,426,	297,426,	297,426,	297,426,	
297,426,	297,426,	297,426,	0,0,	
0,0,	173,307,	0,0,	171,312,	
173,307,	173,307,	0,0,	0,0,	
0,0,	0,0,	0,0,	173,314,	
0,0,	0,0,	297,424,	171,312,	
620,619,	0,0,	171,312,	171,312,	
173,316,	173,317,	173,316,	173,316,	
173,316,	173,316,	173,316,	173,316,	
0,0,	0,0,	0,0,	0,0,	
0,0,	173,307,	0,0,	176,255,	
173,307,	173,307,	0,0,	0,0,	
176,282,	0,0,	620,621,	173,314,	
176,320,	176,320,	176,320,	176,320,	
176,320,	176,320,	176,320,	176,320,	
0,0,	176,283,	620,621,	0,0,	
176,256,	620,621,	620,621,	0,0,	
0,0,	176,312,	362,475,	362,475,	
362,475,	362,475,	362,475,	362,475,	
362,475,	362,475,	0,0,	0,0,	
0,0,	176,312,	620,621,	0,0,	
176,312,	176,312,	0,0,	0,0,	
0,0,	0,0,	0,0,	176,282,	
363,478,	363,478,	363,478,	363,478,	
363,478,	363,478,	363,478,	363,478,	
176,284,	176,321,	176,284,	176,284,	
176,284,	176,284,	176,284,	176,284,	
0,0,	0,0,	0,0,	0,0,	
0,0,	176,312,	0,0,	0,0,	
176,312,	176,312,	0,0,	0,0,	
177,282,	0,0,	0,0,	176,282,	
177,320,	177,320,	177,320,	177,320,	
177,320,	177,320,	177,320,	177,320,	
0,0,	177,283,	392,504,	392,504,	
392,504,	392,504,	392,504,	392,504,	
392,504,	392,504,	401,510,	401,510,	
401,510,	401,510,	401,510,	401,510,	
401,510,	401,510,	0,0,	0,0,	
184,184,	0,0,	0,0,	0,0,	
405,509,	0,0,	0,0,	0,0,	
184,184,	184,184,	0,0,	177,282,	
405,478,	405,478,	405,478,	405,478,	
405,478,	405,478,	405,478,	405,478,	
177,284,	177,284,	177,284,	177,284,	
177,284,	177,284,	177,284,	177,284,	
0,0,	0,0,	0,0,	184,184,	
0,0,	184,184,	184,184,	0,0,	
184,184,	0,0,	184,184,	0,0,	
184,324,	0,0,	184,184,	177,282,	
184,184,	184,184,	184,184,	184,184,	
184,184,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
184,184,	184,184,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
184,184,	184,184,	184,184,	184,184,	
184,184,	184,184,	184,184,	184,184,	
184,184,	0,0,	184,184,	184,184,	
184,184,	184,184,	184,184,	184,184,	
184,184,	184,184,	184,184,	184,184,	
0,0,	0,0,	184,184,	184,184,	
184,184,	394,505,	0,0,	0,0,	
184,184,	0,0,	0,0,	0,0,	
184,184,	184,184,	184,184,	184,184,	
184,184,	184,184,	184,184,	184,184,	
185,326,	0,0,	0,0,	0,0,	
0,0,	0,0,	394,506,	0,0,	
185,326,	185,326,	184,184,	394,507,	
424,426,	424,426,	424,426,	424,426,	
424,426,	424,426,	424,426,	424,426,	
184,184,	0,0,	0,0,	394,507,	
0,0,	0,0,	394,507,	394,507,	
0,0,	0,0,	0,0,	185,326,	
0,0,	185,326,	185,326,	0,0,	
185,326,	0,0,	185,326,	185,327,	
185,328,	0,0,	185,326,	394,507,	
185,326,	185,326,	185,326,	185,326,	
185,326,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	394,507,	
185,326,	185,326,	394,507,	394,507,	
0,0,	0,0,	0,0,	0,0,	
185,326,	185,326,	185,326,	185,326,	
185,326,	185,326,	185,326,	185,326,	
185,326,	0,0,	185,326,	185,326,	
185,326,	185,326,	185,326,	185,326,	
185,326,	185,326,	185,326,	185,326,	
0,0,	0,0,	185,326,	185,326,	
185,326,	395,397,	0,0,	0,0,	
185,326,	0,0,	0,0,	0,0,	
185,326,	185,326,	185,326,	185,326,	
185,326,	185,326,	185,326,	185,326,	
188,188,	0,0,	0,0,	0,0,	
0,0,	0,0,	395,398,	0,0,	
188,188,	188,0,	185,326,	395,508,	
425,526,	425,526,	425,526,	425,526,	
425,526,	425,526,	425,526,	425,526,	
185,326,	0,0,	0,0,	395,508,	
0,0,	0,0,	395,508,	395,508,	
0,0,	0,0,	0,0,	188,188,	
0,0,	188,188,	188,188,	0,0,	
188,188,	0,0,	188,188,	188,188,	
188,330,	0,0,	188,188,	395,508,	
188,188,	188,188,	188,188,	188,188,	
188,188,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	395,508,	
188,188,	188,188,	395,508,	395,508,	
0,0,	0,0,	0,0,	0,0,	
188,188,	188,188,	188,188,	188,188,	
188,188,	188,188,	188,188,	188,188,	
188,188,	0,0,	188,188,	188,188,	
188,188,	188,188,	188,188,	188,188,	
188,188,	188,188,	188,188,	188,188,	
0,0,	0,0,	188,188,	188,188,	
188,188,	402,505,	0,0,	0,0,	
188,188,	0,0,	0,0,	0,0,	
188,188,	188,188,	188,188,	188,188,	
188,188,	188,188,	188,188,	188,188,	
189,189,	0,0,	0,0,	0,0,	
0,0,	0,0,	402,506,	0,0,	
189,189,	189,0,	188,188,	402,507,	
426,527,	426,527,	426,527,	426,527,	
426,527,	426,527,	426,527,	426,527,	
188,188,	0,0,	0,0,	402,507,	
0,0,	0,0,	402,507,	402,507,	
0,0,	0,0,	0,0,	189,189,	
0,0,	189,189,	189,189,	0,0,	
189,189,	0,0,	189,189,	189,189,	
189,189,	0,0,	189,189,	402,507,	
189,189,	189,189,	189,189,	189,189,	
189,189,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	402,507,	
189,189,	189,189,	402,507,	402,507,	
0,0,	0,0,	0,0,	0,0,	
189,189,	189,189,	189,189,	189,189,	
189,189,	189,189,	189,189,	189,189,	
189,189,	0,0,	189,189,	189,189,	
189,189,	189,189,	189,189,	189,189,	
189,189,	189,189,	189,189,	189,189,	
0,0,	0,0,	189,189,	189,189,	
189,189,	404,397,	0,0,	0,0,	
189,189,	0,0,	0,0,	0,0,	
189,189,	189,189,	189,189,	189,189,	
189,189,	189,189,	189,189,	189,189,	
242,242,	0,0,	0,0,	0,0,	
451,509,	0,0,	404,398,	0,0,	
242,242,	242,242,	189,189,	404,399,	
451,527,	451,527,	451,527,	451,527,	
451,527,	451,527,	451,527,	451,527,	
189,331,	0,0,	0,0,	404,399,	
0,0,	0,0,	404,399,	404,399,	
0,0,	0,0,	0,0,	242,242,	
0,0,	242,242,	242,242,	0,0,	
242,242,	0,0,	242,242,	242,242,	
242,242,	0,0,	242,242,	404,399,	
242,388,	242,242,	242,242,	242,242,	
242,242,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	404,399,	
242,242,	242,242,	404,399,	404,399,	
0,0,	0,0,	0,0,	0,0,	
242,242,	242,242,	242,242,	242,242,	
242,242,	242,242,	242,242,	242,242,	
242,242,	0,0,	242,242,	242,242,	
242,242,	242,242,	242,242,	242,242,	
242,242,	242,242,	242,242,	242,242,	
0,0,	0,0,	242,242,	242,242,	
242,242,	0,0,	243,243,	243,243,	
0,0,	0,0,	0,0,	0,0,	
242,242,	242,242,	242,242,	242,242,	
242,242,	242,242,	242,242,	242,242,	
475,568,	475,568,	475,568,	475,568,	
475,568,	475,568,	475,568,	475,568,	
0,0,	243,243,	242,242,	243,244,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
242,242,	0,0,	243,108,	0,0,	
0,0,	243,108,	243,108,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	243,108,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	243,108,	243,108,	
243,108,	243,108,	243,108,	243,108,	
243,108,	243,108,	243,108,	0,0,	
243,108,	243,108,	243,108,	243,108,	
243,108,	243,108,	243,108,	243,108,	
243,108,	243,108,	244,244,	0,0,	
243,108,	243,108,	243,108,	0,0,	
0,0,	0,0,	244,244,	244,244,	
0,0,	570,638,	243,108,	243,108,	
243,108,	243,108,	243,108,	243,108,	
243,108,	243,108,	0,0,	0,0,	
0,0,	570,638,	0,0,	0,0,	
570,638,	570,638,	0,0,	0,0,	
243,108,	244,244,	0,0,	244,389,	
244,244,	0,0,	244,244,	0,0,	
244,244,	244,244,	244,244,	0,0,	
244,244,	570,638,	244,244,	244,244,	
244,244,	244,244,	244,244,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	570,638,	244,244,	244,244,	
570,638,	570,638,	0,0,	0,0,	
0,0,	0,0,	244,244,	244,244,	
244,244,	244,244,	244,244,	244,244,	
244,244,	244,244,	244,244,	0,0,	
244,244,	244,244,	244,244,	244,244,	
244,244,	244,244,	244,244,	244,244,	
244,244,	244,244,	0,0,	0,0,	
244,244,	244,244,	244,244,	670,669,	
0,0,	0,0,	244,390,	0,0,	
0,0,	253,255,	244,244,	244,244,	
244,244,	244,244,	244,244,	244,244,	
244,244,	244,244,	253,395,	253,395,	
253,395,	253,395,	253,395,	253,395,	
253,395,	253,395,	0,0,	0,0,	
244,244,	670,671,	253,256,	0,0,	
0,0,	0,0,	0,0,	253,396,	
0,0,	0,0,	244,244,	0,0,	
0,0,	670,671,	0,0,	258,255,	
670,671,	670,671,	0,0,	253,396,	
0,0,	0,0,	253,396,	253,396,	
258,355,	258,355,	258,355,	258,355,	
258,355,	258,355,	258,355,	258,355,	
0,0,	670,671,	0,0,	0,0,	
258,256,	0,0,	0,0,	253,396,	
0,0,	258,257,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	264,255,	0,0,	253,396,	
0,0,	258,257,	253,396,	253,396,	
258,257,	258,257,	264,404,	264,404,	
264,404,	264,404,	264,404,	264,404,	
264,404,	264,404,	0,0,	0,0,	
0,0,	0,0,	264,256,	0,0,	
0,0,	258,257,	443,539,	264,257,	
265,397,	0,0,	0,0,	0,0,	
0,0,	265,361,	0,0,	0,0,	
0,0,	258,257,	0,0,	264,257,	
258,257,	258,257,	264,257,	264,257,	
0,0,	0,0,	265,362,	443,540,	
0,0,	265,398,	0,0,	0,0,	
443,541,	0,0,	265,399,	0,0,	
0,0,	0,0,	0,0,	264,257,	
0,0,	0,0,	0,0,	0,0,	
443,541,	0,0,	265,399,	443,541,	
443,541,	265,399,	265,399,	264,257,	
0,0,	0,0,	264,257,	264,257,	
265,361,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
443,541,	265,363,	265,405,	265,363,	
265,363,	265,363,	265,363,	265,363,	
265,363,	0,0,	0,0,	0,0,	
0,0,	0,0,	265,399,	0,0,	
313,255,	265,399,	265,399,	0,0,	
0,0,	0,0,	0,0,	0,0,	
265,361,	313,419,	313,419,	313,419,	
313,419,	313,419,	313,419,	313,419,	
313,419,	0,0,	319,255,	0,0,	
0,0,	313,256,	0,0,	0,0,	
0,0,	0,0,	313,312,	319,450,	
319,450,	319,450,	319,450,	319,450,	
319,450,	319,450,	319,450,	0,0,	
0,0,	0,0,	313,312,	319,256,	
0,0,	313,312,	313,312,	441,505,	
319,312,	320,397,	0,0,	0,0,	
0,0,	0,0,	320,424,	0,0,	
0,0,	0,0,	0,0,	0,0,	
319,312,	0,0,	313,312,	319,312,	
319,312,	0,0,	0,0,	320,425,	
441,506,	0,0,	320,398,	0,0,	
0,0,	441,538,	313,312,	320,446,	
0,0,	313,312,	313,312,	0,0,	
319,312,	0,0,	0,0,	0,0,	
0,0,	441,538,	0,0,	320,446,	
441,538,	441,538,	320,446,	320,446,	
319,312,	0,0,	327,327,	319,312,	
319,312,	320,424,	0,0,	0,0,	
0,0,	0,0,	327,327,	327,327,	
0,0,	441,538,	320,426,	320,451,	
320,426,	320,426,	320,426,	320,426,	
320,426,	320,426,	0,0,	0,0,	
0,0,	441,538,	0,0,	320,446,	
441,538,	441,538,	320,446,	320,446,	
0,0,	327,327,	0,0,	327,327,	
327,327,	320,424,	327,327,	0,0,	
327,327,	327,0,	0,0,	0,0,	
327,327,	0,0,	327,327,	327,327,	
327,327,	327,327,	327,327,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	327,327,	327,327,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	327,327,	327,327,	
327,327,	327,327,	327,327,	327,327,	
327,327,	327,327,	327,327,	0,0,	
327,327,	327,327,	327,327,	327,327,	
327,327,	327,327,	327,327,	327,327,	
327,327,	327,327,	449,539,	0,0,	
327,327,	327,327,	327,327,	0,0,	
0,0,	356,362,	327,327,	0,0,	
0,0,	537,619,	327,327,	327,327,	
327,327,	327,327,	327,327,	327,327,	
327,327,	327,327,	356,362,	449,540,	
0,0,	0,0,	0,0,	0,0,	
449,541,	0,0,	0,0,	0,0,	
327,327,	0,0,	537,620,	0,0,	
0,0,	0,0,	0,0,	537,621,	
449,541,	388,242,	327,327,	449,541,	
449,541,	0,0,	0,0,	0,0,	
0,0,	388,242,	388,242,	537,621,	
356,362,	0,0,	537,621,	537,621,	
0,0,	0,0,	0,0,	0,0,	
449,541,	356,475,	356,475,	356,475,	
356,475,	356,475,	356,475,	356,475,	
356,475,	0,0,	0,0,	537,621,	
388,242,	0,0,	388,242,	388,242,	
0,0,	388,242,	0,0,	388,242,	
388,242,	388,242,	0,0,	388,242,	
356,362,	388,500,	388,242,	388,242,	
388,242,	388,242,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	388,242,	388,242,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	388,242,	388,242,	388,242,	
388,242,	388,242,	388,242,	388,242,	
388,242,	388,242,	0,0,	388,242,	
388,242,	388,242,	388,242,	388,242,	
388,242,	388,242,	388,242,	388,242,	
388,242,	0,0,	543,619,	388,242,	
388,242,	388,242,	389,389,	389,389,	
0,0,	0,0,	0,0,	0,0,	
0,0,	388,242,	388,242,	388,242,	
388,242,	388,242,	388,242,	388,242,	
388,242,	0,0,	0,0,	543,620,	
0,0,	0,0,	0,0,	0,0,	
543,621,	389,389,	0,0,	388,242,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
543,621,	388,242,	389,108,	543,621,	
543,621,	389,108,	389,108,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	389,108,	0,0,	
0,0,	0,0,	0,0,	0,0,	
543,621,	0,0,	389,108,	389,108,	
389,108,	389,108,	389,108,	389,108,	
389,108,	389,108,	389,108,	0,0,	
389,108,	389,108,	389,108,	389,108,	
389,108,	389,108,	389,108,	389,108,	
389,108,	389,108,	0,0,	390,502,	
389,108,	389,108,	389,108,	0,0,	
0,0,	0,0,	389,501,	390,502,	
390,502,	0,0,	389,108,	389,108,	
389,108,	389,108,	389,108,	389,108,	
389,108,	389,108,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
389,108,	0,0,	390,502,	0,0,	
390,503,	390,502,	0,0,	390,502,	
0,0,	390,502,	390,502,	390,502,	
0,0,	390,502,	0,0,	390,502,	
390,502,	390,502,	390,502,	390,502,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	390,502,	
390,502,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	390,502,	
390,502,	390,502,	390,502,	390,502,	
390,502,	390,502,	390,502,	390,502,	
0,0,	390,502,	390,502,	390,502,	
390,502,	390,502,	390,502,	390,502,	
390,502,	390,502,	390,502,	0,0,	
0,0,	390,502,	390,502,	390,502,	
448,505,	0,0,	0,0,	390,502,	
0,0,	0,0,	0,0,	390,502,	
390,502,	390,502,	390,502,	390,502,	
390,502,	390,502,	390,502,	413,517,	
0,0,	0,0,	0,0,	0,0,	
0,0,	448,506,	0,0,	413,413,	
0,0,	390,502,	448,538,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	390,502,	
0,0,	0,0,	448,538,	0,0,	
0,0,	448,538,	448,538,	0,0,	
0,0,	0,0,	413,413,	0,0,	
413,517,	413,517,	0,0,	413,517,	
0,0,	413,517,	413,517,	413,517,	
0,0,	413,517,	448,538,	413,517,	
413,517,	413,517,	413,517,	413,517,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	448,538,	413,517,	
413,517,	448,538,	448,538,	0,0,	
0,0,	0,0,	0,0,	413,517,	
413,517,	413,517,	413,517,	413,517,	
413,517,	413,517,	413,517,	413,517,	
0,0,	413,517,	413,517,	413,517,	
413,517,	413,517,	413,517,	413,517,	
413,517,	413,517,	413,517,	450,397,	
0,0,	413,517,	413,517,	413,517,	
0,0,	0,0,	611,669,	413,517,	
0,0,	0,0,	0,0,	413,517,	
413,517,	413,517,	413,517,	413,517,	
413,517,	413,517,	413,517,	0,0,	
450,398,	0,0,	0,0,	0,0,	
0,0,	450,446,	0,0,	611,670,	
0,0,	413,517,	0,0,	0,0,	
611,671,	0,0,	0,0,	0,0,	
0,0,	450,446,	0,0,	413,517,	
450,446,	450,446,	0,0,	455,455,	
611,671,	0,0,	0,0,	611,671,	
611,671,	0,0,	0,0,	455,455,	
455,0,	0,0,	0,0,	0,0,	
0,0,	450,446,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
611,671,	0,0,	0,0,	0,0,	
0,0,	450,446,	0,0,	0,0,	
450,446,	450,446,	455,455,	0,0,	
455,455,	455,455,	0,0,	455,455,	
0,0,	455,455,	455,455,	455,546,	
0,0,	455,455,	0,0,	455,455,	
455,455,	455,455,	455,455,	455,455,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	455,455,	
455,455,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	455,455,	
455,455,	455,455,	455,455,	455,455,	
455,455,	455,455,	455,455,	455,455,	
0,0,	455,455,	455,455,	455,455,	
455,455,	455,455,	455,455,	455,455,	
455,455,	455,455,	455,455,	0,0,	
0,0,	455,455,	455,455,	455,455,	
478,570,	0,0,	0,0,	455,455,	
0,0,	0,0,	0,0,	455,455,	
455,455,	455,455,	455,455,	455,455,	
455,455,	455,455,	455,455,	456,456,	
0,0,	0,0,	0,0,	0,0,	
0,0,	478,571,	0,0,	456,456,	
456,0,	455,455,	478,572,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	455,455,	
0,0,	0,0,	478,572,	0,0,	
0,0,	478,572,	478,572,	0,0,	
0,0,	0,0,	456,456,	0,0,	
456,456,	456,456,	0,0,	456,456,	
0,0,	456,456,	456,456,	456,456,	
0,0,	456,456,	478,572,	456,456,	
456,456,	456,456,	456,456,	456,456,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	478,572,	456,456,	
456,456,	478,572,	478,572,	0,0,	
0,0,	0,0,	0,0,	456,456,	
456,456,	456,456,	456,456,	456,456,	
456,456,	456,456,	456,456,	456,456,	
0,0,	456,456,	456,456,	456,456,	
456,456,	456,456,	456,456,	456,456,	
456,456,	456,456,	456,456,	0,0,	
0,0,	456,456,	456,456,	456,456,	
504,505,	0,0,	0,0,	456,456,	
0,0,	0,0,	0,0,	456,456,	
456,456,	456,456,	456,456,	456,456,	
456,456,	456,456,	456,456,	457,457,	
0,0,	0,0,	0,0,	0,0,	
0,0,	504,506,	0,0,	457,457,	
457,0,	456,456,	504,600,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	456,547,	
0,0,	0,0,	504,600,	0,0,	
0,0,	504,600,	504,600,	0,0,	
0,0,	0,0,	457,457,	0,0,	
457,457,	457,457,	0,0,	457,457,	
0,0,	457,457,	457,457,	457,548,	
0,0,	457,457,	504,600,	457,457,	
457,457,	457,457,	457,457,	457,457,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	504,600,	457,457,	
457,457,	504,600,	504,600,	0,0,	
0,0,	0,0,	0,0,	457,457,	
457,457,	457,457,	457,457,	457,457,	
457,457,	457,457,	457,457,	457,457,	
0,0,	457,457,	457,457,	457,457,	
457,457,	457,457,	457,457,	457,457,	
457,457,	457,457,	457,457,	0,0,	
0,0,	457,457,	457,457,	457,457,	
527,570,	0,0,	0,0,	457,457,	
0,0,	0,0,	0,0,	457,457,	
457,457,	457,457,	457,457,	457,457,	
457,457,	457,457,	457,457,	458,458,	
0,0,	0,0,	0,0,	0,0,	
0,0,	527,571,	0,0,	458,458,	
458,0,	457,457,	527,612,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	457,457,	
0,0,	0,0,	527,612,	0,0,	
0,0,	527,612,	527,612,	0,0,	
0,0,	0,0,	458,458,	0,0,	
458,458,	458,458,	0,0,	458,458,	
0,0,	458,458,	458,458,	458,458,	
0,0,	458,458,	527,612,	458,458,	
458,458,	458,458,	458,458,	458,458,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	527,612,	458,458,	
458,458,	527,612,	527,612,	0,0,	
0,0,	0,0,	0,0,	458,458,	
458,458,	458,458,	458,458,	458,458,	
458,458,	458,458,	458,458,	458,458,	
0,0,	458,458,	458,458,	458,458,	
458,458,	458,458,	458,458,	458,458,	
458,458,	458,458,	458,458,	0,0,	
0,0,	458,458,	458,458,	458,458,	
568,570,	0,0,	0,0,	458,458,	
0,0,	0,0,	0,0,	458,458,	
458,458,	458,458,	458,458,	458,458,	
458,458,	458,458,	458,458,	459,459,	
0,0,	0,0,	0,0,	0,0,	
0,0,	568,571,	0,0,	459,459,	
459,0,	458,458,	568,638,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	458,549,	
0,0,	0,0,	568,638,	0,0,	
0,0,	568,638,	568,638,	0,0,	
0,0,	0,0,	459,459,	0,0,	
459,459,	459,459,	0,0,	459,459,	
0,0,	459,459,	459,459,	459,550,	
0,0,	459,459,	568,638,	459,459,	
459,459,	459,459,	459,459,	459,459,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	568,638,	459,459,	
459,459,	568,638,	568,638,	0,0,	
0,0,	0,0,	0,0,	459,459,	
459,459,	459,459,	459,459,	459,459,	
459,459,	459,459,	459,459,	459,459,	
0,0,	459,459,	459,459,	459,459,	
459,459,	459,459,	459,459,	459,459,	
459,459,	459,459,	459,459,	0,0,	
0,0,	459,459,	459,459,	459,459,	
0,0,	0,0,	0,0,	459,459,	
0,0,	0,0,	0,0,	459,459,	
459,459,	459,459,	459,459,	459,459,	
459,459,	459,459,	459,459,	460,460,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	460,460,	
460,0,	459,459,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	459,459,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	460,460,	0,0,	
460,460,	460,460,	0,0,	460,460,	
0,0,	460,460,	460,460,	460,460,	
0,0,	460,460,	0,0,	460,460,	
460,460,	460,460,	460,460,	460,460,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	460,460,	
460,460,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	460,460,	
460,460,	460,460,	460,460,	460,460,	
460,460,	460,460,	460,460,	460,460,	
0,0,	460,460,	460,460,	460,460,	
460,460,	460,460,	460,460,	460,460,	
460,460,	460,460,	460,460,	0,0,	
0,0,	460,460,	460,460,	460,460,	
0,0,	0,0,	0,0,	460,460,	
0,0,	0,0,	0,0,	460,460,	
460,460,	460,460,	460,460,	460,460,	
460,460,	460,460,	460,460,	500,242,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	500,242,	
500,242,	460,460,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	460,551,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	500,242,	0,0,	
500,242,	500,242,	0,0,	500,242,	
0,0,	500,242,	500,242,	500,242,	
0,0,	500,242,	0,0,	500,500,	
500,242,	500,242,	500,242,	500,242,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	500,242,	
500,242,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	500,242,	
500,242,	500,242,	500,242,	500,242,	
500,242,	500,242,	500,242,	500,242,	
0,0,	500,242,	500,242,	500,242,	
500,242,	500,242,	500,242,	500,242,	
500,242,	500,242,	500,242,	0,0,	
0,0,	500,242,	500,242,	500,242,	
0,0,	0,0,	0,0,	500,598,	
0,0,	0,0,	0,0,	500,242,	
500,242,	500,242,	500,242,	500,242,	
500,242,	500,242,	500,242,	517,517,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	517,517,	
0,0,	500,242,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	500,242,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	517,517,	0,0,	
517,517,	517,517,	0,0,	517,517,	
0,0,	517,517,	517,517,	517,517,	
0,0,	517,517,	0,0,	517,517,	
517,517,	517,517,	517,517,	517,517,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	517,517,	
517,517,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	517,517,	
517,517,	517,517,	517,517,	517,517,	
517,517,	517,517,	517,517,	517,517,	
0,0,	517,517,	517,517,	517,517,	
517,517,	517,517,	517,517,	517,517,	
517,517,	517,517,	517,517,	0,0,	
0,0,	517,517,	517,517,	517,517,	
0,0,	0,0,	0,0,	517,517,	
0,0,	0,0,	0,0,	517,517,	
517,517,	517,517,	517,517,	517,517,	
517,517,	517,517,	517,517,	518,518,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	518,518,	
0,0,	517,517,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	517,517,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	518,518,	0,0,	
518,518,	518,518,	0,0,	518,518,	
0,0,	518,518,	518,518,	518,605,	
0,0,	518,518,	0,0,	518,518,	
518,518,	518,518,	518,518,	518,518,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	518,518,	
518,518,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	518,518,	
518,518,	518,518,	518,518,	518,518,	
518,518,	518,518,	518,518,	518,518,	
0,0,	518,518,	518,518,	518,518,	
518,518,	518,518,	518,518,	518,518,	
518,518,	518,518,	518,518,	0,0,	
0,0,	518,518,	518,518,	518,518,	
0,0,	0,0,	0,0,	518,518,	
0,0,	0,0,	0,0,	518,518,	
518,518,	518,518,	518,518,	518,518,	
518,518,	518,518,	518,518,	519,519,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	519,519,	
0,0,	518,518,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	518,518,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	519,519,	0,0,	
519,519,	519,519,	0,0,	519,519,	
0,0,	519,519,	519,519,	519,519,	
0,0,	519,519,	0,0,	519,519,	
519,519,	519,519,	519,519,	519,519,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	519,519,	
519,519,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	519,519,	
519,519,	519,519,	519,519,	519,519,	
519,519,	519,519,	519,519,	519,519,	
0,0,	519,519,	519,519,	519,519,	
519,519,	519,519,	519,519,	519,519,	
519,519,	519,519,	519,519,	0,0,	
0,0,	519,519,	519,519,	519,519,	
0,0,	0,0,	0,0,	519,519,	
0,0,	0,0,	0,0,	519,519,	
519,519,	519,519,	519,519,	519,519,	
519,519,	519,519,	519,519,	520,520,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	520,520,	
0,0,	519,519,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	519,606,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	520,520,	0,0,	
520,520,	520,520,	0,0,	520,520,	
0,0,	520,520,	520,520,	520,607,	
0,0,	520,520,	0,0,	520,520,	
520,520,	520,520,	520,520,	520,520,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	520,520,	
520,520,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	520,520,	
520,520,	520,520,	520,520,	520,520,	
520,520,	520,520,	520,520,	520,520,	
0,0,	520,520,	520,520,	520,520,	
520,520,	520,520,	520,520,	520,520,	
520,520,	520,520,	520,520,	0,0,	
0,0,	520,520,	520,520,	520,520,	
0,0,	0,0,	0,0,	520,520,	
0,0,	0,0,	0,0,	520,520,	
520,520,	520,520,	520,520,	520,520,	
520,520,	520,520,	520,520,	521,521,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	521,521,	
0,0,	520,520,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	520,520,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	521,521,	0,0,	
521,521,	521,521,	0,0,	521,521,	
0,0,	521,521,	521,521,	521,521,	
0,0,	521,521,	0,0,	521,521,	
521,521,	521,521,	521,521,	521,521,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	521,521,	
521,521,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	521,521,	
521,521,	521,521,	521,521,	521,521,	
521,521,	521,521,	521,521,	521,521,	
0,0,	521,521,	521,521,	521,521,	
521,521,	521,521,	521,521,	521,521,	
521,521,	521,521,	521,521,	0,0,	
0,0,	521,521,	521,521,	521,521,	
0,0,	0,0,	0,0,	521,521,	
0,0,	0,0,	0,0,	521,521,	
521,521,	521,521,	521,521,	521,521,	
521,521,	521,521,	521,521,	574,574,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	574,574,	
574,0,	521,521,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	521,608,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	574,574,	0,0,	
574,574,	574,574,	0,0,	574,574,	
0,0,	574,574,	574,574,	574,641,	
0,0,	574,574,	0,0,	574,574,	
574,574,	574,574,	574,574,	574,574,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	574,574,	
574,574,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	574,574,	
574,574,	574,574,	574,574,	574,574,	
574,574,	574,574,	574,574,	574,574,	
0,0,	574,574,	574,574,	574,574,	
574,574,	574,574,	574,574,	574,574,	
574,574,	574,574,	574,574,	0,0,	
0,0,	574,574,	574,574,	574,574,	
0,0,	0,0,	0,0,	574,574,	
0,0,	0,0,	0,0,	574,574,	
574,574,	574,574,	574,574,	574,574,	
574,574,	574,574,	574,574,	597,234,	
0,0,	0,0,	597,639,	0,0,	
597,235,	0,0,	0,0,	0,0,	
0,0,	574,574,	597,236,	597,237,	
0,0,	597,209,	0,0,	0,0,	
597,238,	0,0,	605,518,	574,574,	
0,0,	597,239,	0,0,	0,0,	
0,0,	0,0,	605,518,	0,0,	
0,0,	0,0,	0,0,	597,234,	
0,0,	0,0,	597,639,	0,0,	
597,235,	0,0,	0,0,	0,0,	
0,0,	0,0,	597,236,	597,237,	
0,0,	597,209,	0,0,	0,0,	
597,238,	605,518,	0,0,	605,518,	
605,518,	597,239,	605,518,	0,0,	
605,518,	605,518,	605,605,	0,0,	
605,518,	0,0,	605,518,	605,518,	
605,518,	605,518,	605,518,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	605,518,	605,518,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	605,518,	605,518,	
605,518,	605,518,	605,518,	605,518,	
605,518,	605,518,	605,518,	0,0,	
605,518,	605,518,	605,518,	605,518,	
605,518,	605,518,	605,518,	605,518,	
605,518,	605,518,	0,0,	0,0,	
605,518,	605,518,	605,518,	0,0,	
0,0,	0,0,	605,518,	0,0,	
0,0,	0,0,	605,518,	605,518,	
605,518,	605,518,	605,518,	605,518,	
605,518,	605,518,	606,519,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	606,519,	0,0,	
605,518,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	605,518,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	606,519,	0,0,	606,519,	
606,519,	0,0,	606,519,	0,0,	
606,519,	606,519,	606,519,	0,0,	
606,519,	0,0,	606,519,	606,519,	
606,519,	606,519,	606,519,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	606,519,	606,519,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	606,519,	606,519,	
606,519,	606,519,	606,519,	606,519,	
606,519,	606,519,	606,519,	0,0,	
606,519,	606,519,	606,519,	606,519,	
606,519,	606,519,	606,519,	606,519,	
606,519,	606,519,	0,0,	0,0,	
606,519,	606,519,	606,519,	0,0,	
0,0,	0,0,	606,519,	0,0,	
0,0,	0,0,	606,519,	606,519,	
606,519,	606,519,	606,519,	606,519,	
606,519,	606,519,	607,520,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	607,520,	0,0,	
606,519,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	606,606,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	607,520,	0,0,	607,520,	
607,520,	0,0,	607,520,	0,0,	
607,520,	607,520,	607,607,	0,0,	
607,520,	0,0,	607,520,	607,520,	
607,520,	607,520,	607,520,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	607,520,	607,520,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	607,520,	607,520,	
607,520,	607,520,	607,520,	607,520,	
607,520,	607,520,	607,520,	0,0,	
607,520,	607,520,	607,520,	607,520,	
607,520,	607,520,	607,520,	607,520,	
607,520,	607,520,	0,0,	0,0,	
607,520,	607,520,	607,520,	0,0,	
0,0,	0,0,	607,520,	0,0,	
0,0,	0,0,	607,520,	607,520,	
607,520,	607,520,	607,520,	607,520,	
607,520,	607,520,	608,521,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	608,521,	0,0,	
607,520,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	607,520,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	608,521,	0,0,	608,521,	
608,521,	0,0,	608,521,	0,0,	
608,521,	608,521,	608,521,	0,0,	
608,521,	0,0,	608,521,	608,521,	
608,521,	608,521,	608,521,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	608,521,	608,521,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	608,521,	608,521,	
608,521,	608,521,	608,521,	608,521,	
608,521,	608,521,	608,521,	0,0,	
608,521,	608,521,	608,521,	608,521,	
608,521,	608,521,	608,521,	608,521,	
608,521,	608,521,	0,0,	0,0,	
608,521,	608,521,	608,521,	0,0,	
0,0,	0,0,	608,521,	0,0,	
0,0,	0,0,	608,521,	608,521,	
608,521,	608,521,	608,521,	608,521,	
608,521,	608,521,	636,636,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	636,636,	636,0,	
608,521,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	608,608,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	636,636,	0,0,	636,636,	
636,636,	0,0,	636,636,	0,0,	
636,636,	636,636,	636,689,	0,0,	
636,636,	0,0,	636,636,	636,636,	
636,636,	636,636,	636,636,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	636,636,	636,636,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	636,636,	636,636,	
636,636,	636,636,	636,636,	636,636,	
636,636,	636,636,	636,636,	0,0,	
636,636,	636,636,	636,636,	636,636,	
636,636,	636,636,	636,636,	636,636,	
636,636,	636,636,	0,0,	0,0,	
636,636,	636,636,	636,636,	0,0,	
0,0,	0,0,	636,636,	0,0,	
0,0,	0,0,	636,636,	636,636,	
636,636,	636,636,	636,636,	636,636,	
636,636,	636,636,	663,663,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	663,663,	663,0,	
636,636,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	636,636,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	663,663,	0,0,	663,663,	
663,663,	0,0,	663,663,	0,0,	
663,663,	663,663,	663,709,	0,0,	
663,663,	0,0,	663,663,	663,663,	
663,663,	663,663,	663,663,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	663,663,	663,663,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	663,663,	663,663,	
663,663,	663,663,	663,663,	663,663,	
663,663,	663,663,	663,663,	0,0,	
663,663,	663,663,	663,663,	663,663,	
663,663,	663,663,	663,663,	663,663,	
663,663,	663,663,	0,0,	0,0,	
663,663,	663,663,	663,663,	0,0,	
0,0,	0,0,	663,663,	0,0,	
0,0,	0,0,	663,663,	663,663,	
663,663,	663,663,	663,663,	663,663,	
663,663,	663,663,	700,732,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	700,732,	700,0,	
663,663,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	663,663,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	700,732,	0,0,	700,732,	
700,732,	0,0,	700,732,	0,0,	
700,700,	700,732,	700,732,	0,0,	
700,732,	0,0,	700,700,	700,732,	
700,732,	700,700,	700,700,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	700,700,	700,732,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	700,700,	700,700,	
700,700,	700,700,	700,700,	700,700,	
700,733,	700,700,	700,700,	716,0,	
700,700,	700,700,	700,700,	700,700,	
700,700,	700,700,	700,700,	700,700,	
700,700,	700,700,	0,0,	0,0,	
700,700,	700,700,	700,700,	0,0,	
0,0,	0,0,	700,732,	0,0,	
0,0,	0,0,	700,700,	700,700,	
700,700,	700,700,	700,700,	700,700,	
700,733,	700,700,	0,0,	0,0,	
0,0,	0,0,	716,716,	0,0,	
0,0,	716,716,	716,716,	0,0,	
700,700,	0,0,	0,0,	0,0,	
0,0,	0,0,	716,716,	716,744,	
0,0,	0,0,	700,732,	0,0,	
0,0,	0,0,	716,716,	716,716,	
716,716,	716,716,	716,716,	716,716,	
716,745,	716,716,	716,716,	0,0,	
716,716,	716,716,	716,716,	716,716,	
716,716,	716,716,	716,716,	716,716,	
716,716,	716,716,	732,0,	0,0,	
716,716,	716,716,	716,716,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	716,716,	716,716,	
716,716,	716,716,	716,716,	716,716,	
716,745,	716,716,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	732,732,	
716,716,	0,0,	0,0,	0,0,	
0,0,	732,732,	0,0,	0,0,	
732,732,	732,732,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	732,732,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	732,732,	732,732,	732,732,	
732,732,	732,732,	732,732,	732,757,	
732,732,	732,732,	0,0,	732,732,	
732,732,	732,732,	732,732,	732,732,	
732,732,	732,732,	732,732,	732,732,	
732,732,	744,744,	0,0,	732,732,	
732,732,	732,732,	0,0,	0,0,	
0,0,	744,744,	0,0,	0,0,	
0,0,	732,732,	732,732,	732,732,	
732,732,	732,732,	732,732,	732,757,	
732,732,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	732,732,	
744,744,	0,0,	744,744,	744,744,	
0,0,	744,744,	0,0,	744,744,	
744,744,	744,744,	0,0,	744,744,	
0,0,	744,744,	744,744,	744,744,	
744,744,	744,744,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	744,744,	744,744,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	744,744,	744,744,	744,744,	
744,744,	744,744,	744,744,	744,767,	
744,744,	744,744,	745,0,	744,744,	
744,744,	744,744,	744,744,	744,744,	
744,744,	744,744,	744,744,	744,744,	
744,744,	0,0,	0,0,	744,744,	
744,744,	744,744,	0,0,	0,0,	
0,0,	744,744,	0,0,	0,0,	
0,0,	744,744,	744,744,	744,744,	
744,744,	744,744,	744,744,	744,767,	
744,744,	0,0,	0,0,	0,0,	
0,0,	745,716,	0,0,	0,0,	
745,716,	745,716,	0,0,	744,744,	
0,0,	0,0,	0,0,	0,0,	
0,0,	745,716,	745,744,	0,0,	
0,0,	744,744,	0,0,	0,0,	
0,0,	745,768,	745,716,	745,716,	
745,716,	745,716,	745,716,	745,745,	
745,716,	745,716,	0,0,	745,716,	
745,716,	745,716,	745,716,	745,716,	
745,716,	745,716,	745,716,	745,716,	
745,716,	757,0,	0,0,	745,716,	
745,716,	745,716,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	745,769,	745,716,	745,716,	
745,716,	745,716,	745,716,	745,745,	
745,716,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	757,732,	745,716,	
0,0,	0,0,	0,0,	0,0,	
757,732,	0,0,	0,0,	757,732,	
757,732,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
757,732,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
757,785,	757,732,	757,732,	757,732,	
757,732,	757,732,	757,757,	757,732,	
757,732,	0,0,	757,732,	757,732,	
757,732,	757,732,	757,732,	757,732,	
757,732,	757,732,	757,732,	757,732,	
767,744,	0,0,	757,732,	757,732,	
757,732,	0,0,	0,0,	0,0,	
767,744,	0,0,	0,0,	0,0,	
757,786,	757,732,	757,732,	757,732,	
757,732,	757,732,	757,757,	757,732,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	757,732,	767,744,	
0,0,	767,744,	767,744,	0,0,	
767,744,	0,0,	767,744,	767,744,	
767,744,	0,0,	767,744,	0,0,	
767,744,	767,744,	767,744,	767,744,	
767,744,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
767,744,	767,744,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
767,798,	767,744,	767,744,	767,744,	
767,744,	767,744,	767,767,	767,744,	
767,744,	768,0,	767,744,	767,744,	
767,744,	767,744,	767,744,	767,744,	
767,744,	767,744,	767,744,	767,744,	
0,0,	0,0,	767,744,	767,744,	
767,744,	0,0,	0,0,	0,0,	
767,744,	0,0,	0,0,	0,0,	
767,799,	767,744,	767,744,	767,744,	
767,744,	767,744,	767,767,	767,744,	
0,0,	0,0,	0,0,	0,0,	
768,716,	0,0,	0,0,	768,716,	
768,716,	0,0,	767,744,	0,0,	
0,0,	0,0,	0,0,	0,0,	
768,716,	768,744,	0,0,	0,0,	
767,744,	0,0,	0,0,	0,0,	
768,716,	768,716,	768,716,	768,716,	
768,716,	768,716,	768,745,	768,716,	
768,716,	0,0,	768,716,	768,716,	
768,800,	768,716,	768,716,	768,716,	
768,716,	768,716,	768,716,	768,716,	
769,0,	0,0,	768,716,	768,716,	
768,716,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
768,716,	768,716,	768,716,	768,716,	
768,716,	768,716,	768,745,	768,716,	
0,0,	0,0,	0,0,	0,0,	
768,716,	0,0,	0,0,	0,0,	
0,0,	0,0,	768,716,	0,0,	
0,0,	0,0,	0,0,	769,716,	
0,0,	0,0,	769,716,	769,716,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	769,716,	
769,744,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	769,716,	
769,716,	769,716,	769,716,	769,716,	
769,716,	769,745,	769,716,	769,716,	
0,0,	769,716,	769,716,	769,716,	
769,716,	769,716,	769,716,	769,716,	
769,716,	769,716,	769,716,	785,0,	
0,0,	769,716,	769,716,	769,716,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	769,716,	
769,716,	769,716,	769,716,	769,716,	
769,716,	769,745,	769,716,	0,0,	
0,0,	0,0,	0,0,	769,801,	
0,0,	0,0,	0,0,	0,0,	
785,732,	769,716,	0,0,	0,0,	
0,0,	0,0,	785,732,	0,0,	
0,0,	785,732,	785,732,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	785,732,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	785,732,	785,732,	
785,732,	785,732,	785,732,	785,732,	
785,757,	785,732,	785,732,	0,0,	
785,732,	785,732,	785,818,	785,732,	
785,732,	785,732,	785,732,	785,732,	
785,732,	785,732,	786,0,	0,0,	
785,732,	785,732,	785,732,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	785,732,	785,732,	
785,732,	785,732,	785,732,	785,732,	
785,757,	785,732,	0,0,	0,0,	
0,0,	0,0,	785,732,	0,0,	
0,0,	0,0,	0,0,	786,732,	
785,732,	0,0,	0,0,	0,0,	
0,0,	786,732,	0,0,	0,0,	
786,732,	786,732,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	786,732,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	786,732,	786,732,	786,732,	
786,732,	786,732,	786,732,	786,757,	
786,732,	786,732,	0,0,	786,732,	
786,732,	786,732,	786,732,	786,732,	
786,732,	786,732,	786,732,	786,732,	
786,732,	798,744,	0,0,	786,732,	
786,732,	786,732,	0,0,	0,0,	
0,0,	798,744,	798,272,	0,0,	
0,0,	786,732,	786,732,	786,732,	
786,732,	786,732,	786,732,	786,757,	
786,732,	0,0,	0,0,	0,0,	
0,0,	786,819,	0,0,	0,0,	
0,0,	0,0,	0,0,	786,732,	
798,744,	0,0,	798,744,	798,744,	
0,0,	798,744,	0,0,	798,744,	
798,744,	798,744,	0,0,	798,744,	
0,0,	798,744,	798,744,	798,744,	
798,744,	798,744,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	798,744,	798,744,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	798,744,	798,744,	798,744,	
798,744,	798,744,	798,744,	798,767,	
798,744,	798,744,	0,0,	798,744,	
798,744,	798,832,	798,744,	798,744,	
798,744,	798,744,	798,744,	798,744,	
798,744,	800,0,	0,0,	798,744,	
798,744,	798,744,	0,0,	0,0,	
0,0,	798,744,	0,0,	0,0,	
0,0,	798,744,	798,744,	798,744,	
798,744,	798,744,	798,744,	798,767,	
798,744,	0,0,	0,0,	0,0,	
0,0,	798,744,	0,0,	0,0,	
0,0,	0,0,	0,0,	798,744,	
0,0,	0,0,	0,0,	0,0,	
800,716,	0,0,	0,0,	800,716,	
800,716,	798,744,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
800,716,	800,744,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
800,716,	800,716,	800,716,	800,716,	
800,834,	800,716,	800,745,	800,716,	
800,716,	801,0,	800,716,	800,716,	
800,716,	800,716,	800,716,	800,716,	
800,716,	800,716,	800,716,	800,716,	
0,0,	0,0,	800,716,	800,716,	
800,716,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
800,716,	800,716,	800,716,	800,716,	
800,716,	800,716,	800,745,	800,716,	
0,0,	0,0,	0,0,	0,0,	
801,716,	0,0,	0,0,	801,716,	
801,716,	0,0,	800,716,	0,0,	
0,0,	0,0,	0,0,	0,0,	
801,716,	801,744,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
801,716,	801,716,	801,716,	801,716,	
801,716,	801,716,	801,745,	801,716,	
801,716,	0,0,	801,716,	801,716,	
801,716,	801,716,	801,716,	801,716,	
801,716,	801,716,	801,716,	801,716,	
818,0,	0,0,	801,716,	801,716,	
801,716,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
801,716,	801,716,	801,716,	801,716,	
801,834,	801,716,	801,745,	801,716,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	818,732,	801,716,	0,0,	
0,0,	0,0,	0,0,	818,732,	
0,0,	0,0,	818,732,	818,732,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	818,732,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	818,732,	
818,732,	818,732,	818,732,	818,847,	
818,732,	818,757,	818,732,	818,732,	
0,0,	818,732,	818,732,	818,732,	
818,732,	818,732,	818,732,	818,732,	
818,732,	818,732,	818,732,	819,0,	
0,0,	818,732,	818,732,	818,732,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	818,732,	
818,732,	818,732,	818,732,	818,732,	
818,732,	818,757,	818,732,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
819,732,	818,732,	0,0,	0,0,	
0,0,	0,0,	819,732,	0,0,	
0,0,	819,732,	819,732,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	819,732,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	819,732,	819,732,	
819,732,	819,732,	819,732,	819,732,	
819,757,	819,732,	819,732,	0,0,	
819,732,	819,732,	819,732,	819,732,	
819,732,	819,732,	819,732,	819,732,	
819,732,	819,732,	828,828,	0,0,	
819,732,	819,732,	819,732,	0,0,	
0,0,	0,0,	828,828,	828,852,	
0,0,	0,0,	819,732,	819,732,	
819,732,	819,732,	819,847,	819,732,	
819,757,	819,732,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
819,732,	828,828,	0,0,	828,828,	
828,828,	0,0,	828,828,	0,0,	
828,828,	828,828,	828,828,	0,0,	
828,828,	0,0,	828,828,	828,828,	
828,828,	828,828,	828,828,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	828,828,	828,828,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	828,828,	828,828,	
828,828,	828,828,	828,828,	828,828,	
828,828,	828,828,	828,828,	0,0,	
828,828,	828,828,	828,828,	828,828,	
828,828,	828,828,	828,828,	828,828,	
828,828,	828,828,	0,0,	0,0,	
828,828,	828,828,	828,828,	0,0,	
0,0,	0,0,	828,828,	0,0,	
0,0,	0,0,	828,828,	828,828,	
828,828,	828,828,	828,828,	828,828,	
828,828,	828,828,	830,830,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	830,830,	830,854,	
828,828,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	828,828,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	830,830,	0,0,	830,830,	
830,830,	0,0,	830,830,	0,0,	
830,830,	830,830,	830,830,	0,0,	
830,830,	0,0,	830,830,	830,830,	
830,830,	830,830,	830,830,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	830,830,	830,830,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	830,830,	830,830,	
830,830,	830,830,	830,830,	830,830,	
830,830,	830,830,	830,830,	0,0,	
830,830,	830,830,	830,830,	830,830,	
830,830,	830,830,	830,830,	830,830,	
830,830,	830,830,	0,0,	0,0,	
830,830,	830,830,	830,830,	0,0,	
0,0,	0,0,	830,830,	0,0,	
0,0,	0,0,	830,830,	830,830,	
830,830,	830,830,	830,830,	830,830,	
830,830,	830,830,	832,744,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	832,744,	0,0,	
830,830,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	830,830,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	832,744,	0,0,	832,744,	
832,744,	0,0,	832,744,	0,0,	
832,744,	832,744,	832,744,	0,0,	
832,744,	0,0,	832,744,	832,744,	
832,744,	832,744,	832,744,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	832,744,	832,744,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	832,744,	832,744,	
832,744,	832,744,	832,856,	832,744,	
832,767,	832,744,	832,744,	0,0,	
832,744,	832,744,	832,744,	832,744,	
832,744,	832,744,	832,744,	832,744,	
832,744,	832,744,	0,0,	0,0,	
832,744,	832,744,	832,744,	0,0,	
0,0,	0,0,	832,744,	0,0,	
0,0,	0,0,	832,744,	832,744,	
832,744,	832,744,	832,744,	832,744,	
832,767,	832,744,	833,744,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	833,744,	0,0,	
832,744,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	832,744,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	833,744,	0,0,	833,744,	
833,744,	0,0,	833,744,	0,0,	
833,744,	833,744,	833,744,	0,0,	
833,744,	0,0,	833,744,	833,744,	
833,744,	833,744,	833,744,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	833,744,	833,744,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	833,744,	833,744,	
833,744,	833,744,	833,744,	833,744,	
833,767,	833,744,	833,744,	834,0,	
833,744,	833,744,	833,744,	833,744,	
833,744,	833,744,	833,744,	833,744,	
833,744,	833,744,	0,0,	0,0,	
833,744,	833,744,	833,744,	0,0,	
0,0,	0,0,	833,744,	0,0,	
0,0,	0,0,	833,744,	833,744,	
833,744,	833,744,	833,856,	833,744,	
833,767,	833,744,	0,0,	0,0,	
0,0,	0,0,	834,716,	0,0,	
0,0,	834,716,	834,716,	0,0,	
833,744,	0,0,	0,0,	0,0,	
0,0,	0,0,	834,716,	834,744,	
0,0,	0,0,	833,744,	0,0,	
0,0,	0,0,	834,716,	834,716,	
834,716,	834,716,	834,716,	834,716,	
834,745,	834,716,	834,716,	0,0,	
834,716,	834,716,	834,716,	834,716,	
834,716,	834,716,	834,716,	834,716,	
834,716,	834,716,	847,0,	0,0,	
834,716,	834,716,	834,716,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	834,716,	834,716,	
834,716,	834,716,	834,716,	834,716,	
834,745,	834,716,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	847,732,	
834,716,	0,0,	0,0,	0,0,	
0,0,	847,732,	0,0,	0,0,	
847,732,	847,732,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	847,732,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	847,732,	847,732,	847,732,	
847,732,	847,732,	847,732,	847,757,	
847,732,	847,732,	0,0,	847,732,	
847,732,	847,732,	847,732,	847,732,	
847,732,	847,732,	847,732,	847,732,	
847,732,	856,744,	0,0,	847,732,	
847,732,	847,732,	0,0,	0,0,	
0,0,	856,744,	0,0,	0,0,	
0,0,	847,732,	847,732,	847,732,	
847,732,	847,732,	847,732,	847,757,	
847,732,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	847,732,	
856,744,	0,0,	856,744,	856,744,	
0,0,	856,744,	0,0,	856,744,	
856,744,	856,744,	0,0,	856,744,	
0,0,	856,744,	856,744,	856,744,	
856,744,	856,744,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	856,744,	856,744,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	856,744,	856,744,	856,744,	
856,744,	856,744,	856,744,	856,767,	
856,744,	856,744,	0,0,	856,744,	
856,744,	856,744,	856,744,	856,744,	
856,744,	856,744,	856,744,	856,744,	
856,744,	0,0,	0,0,	856,744,	
856,744,	856,744,	0,0,	0,0,	
0,0,	856,744,	0,0,	0,0,	
0,0,	856,744,	856,744,	856,744,	
856,744,	856,744,	856,744,	856,767,	
856,744,	876,876,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	876,876,	876,879,	856,744,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	856,744,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
876,876,	0,0,	876,876,	876,876,	
0,0,	876,876,	0,0,	876,876,	
876,876,	876,876,	0,0,	876,876,	
0,0,	876,876,	876,876,	876,876,	
876,876,	876,876,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	876,876,	876,876,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	876,876,	876,876,	876,876,	
876,876,	876,876,	876,876,	876,876,	
876,876,	876,876,	0,0,	876,876,	
876,876,	876,876,	876,876,	876,876,	
876,876,	876,876,	876,876,	876,876,	
876,876,	0,0,	0,0,	876,876,	
876,876,	876,876,	0,0,	0,0,	
0,0,	876,876,	0,0,	0,0,	
0,0,	876,876,	876,876,	876,876,	
876,876,	876,876,	876,876,	876,876,	
876,876,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	876,876,	
0,0,	0,0,	0,0,	0,0,	
0,0,	0,0,	0,0,	0,0,	
0,0,	876,268,	0,0,	0,0,	
0,0};
struct yysvf yysvec[] = {
0,	0,	0,
yycrank+-1,	0,		0,	
yycrank+-80,	yysvec+1,	0,	
yycrank+0,	0,		yyvstop+1,
yycrank+157,	0,		yyvstop+3,
yycrank+-279,	0,		yyvstop+6,
yycrank+29,	0,		yyvstop+8,
yycrank+48,	0,		yyvstop+11,
yycrank+63,	yysvec+4,	yyvstop+13,
yycrank+360,	yysvec+4,	yyvstop+16,
yycrank+434,	yysvec+4,	yyvstop+20,
yycrank+-517,	0,		yyvstop+24,
yycrank+594,	yysvec+4,	yyvstop+27,
yycrank+34,	yysvec+4,	yyvstop+31,
yycrank+58,	yysvec+4,	yyvstop+34,
yycrank+64,	yysvec+4,	yyvstop+37,
yycrank+622,	yysvec+4,	yyvstop+40,
yycrank+79,	yysvec+4,	yyvstop+43,
yycrank+30,	yysvec+4,	yyvstop+46,
yycrank+201,	yysvec+4,	yyvstop+49,
yycrank+682,	yysvec+4,	yyvstop+52,
yycrank+70,	yysvec+4,	yyvstop+55,
yycrank+219,	yysvec+4,	yyvstop+58,
yycrank+-758,	0,		yyvstop+62,
yycrank+826,	yysvec+4,	yyvstop+64,
yycrank+855,	yysvec+4,	yyvstop+67,
yycrank+915,	yysvec+4,	yyvstop+71,
yycrank+939,	yysvec+4,	yyvstop+74,
yycrank+1011,	yysvec+4,	yyvstop+77,
yycrank+1035,	yysvec+4,	yyvstop+80,
yycrank+1095,	yysvec+4,	yyvstop+83,
yycrank+1126,	yysvec+4,	yyvstop+86,
yycrank+62,	yysvec+4,	yyvstop+89,
yycrank+-1202,	0,		yyvstop+92,
yycrank+31,	0,		yyvstop+94,
yycrank+1280,	0,		yyvstop+96,
yycrank+249,	yysvec+35,	yyvstop+99,
yycrank+1394,	yysvec+35,	yyvstop+102,
yycrank+1468,	yysvec+35,	yyvstop+106,
yycrank+-32,	yysvec+11,	yyvstop+110,
yycrank+1541,	yysvec+35,	yyvstop+113,
yycrank+93,	yysvec+35,	yyvstop+117,
yycrank+84,	yysvec+35,	yyvstop+120,
yycrank+107,	yysvec+35,	yyvstop+123,
yycrank+1569,	yysvec+35,	yyvstop+126,
yycrank+122,	yysvec+35,	yyvstop+129,
yycrank+41,	yysvec+35,	yyvstop+132,
yycrank+287,	yysvec+35,	yyvstop+135,
yycrank+1629,	yysvec+35,	yyvstop+138,
yycrank+104,	yysvec+35,	yyvstop+141,
yycrank+260,	yysvec+35,	yyvstop+144,
yycrank+1654,	yysvec+35,	yyvstop+148,
yycrank+1714,	yysvec+35,	yyvstop+151,
yycrank+1774,	yysvec+35,	yyvstop+155,
yycrank+1798,	yysvec+35,	yyvstop+158,
yycrank+1870,	yysvec+35,	yyvstop+161,
yycrank+1894,	yysvec+35,	yyvstop+164,
yycrank+1954,	yysvec+35,	yyvstop+167,
yycrank+1985,	yysvec+35,	yyvstop+170,
yycrank+78,	yysvec+35,	yyvstop+173,
yycrank+-42,	yysvec+33,	yyvstop+176,
yycrank+0,	yysvec+4,	yyvstop+178,
yycrank+-2061,	0,		0,	
yycrank+-2165,	0,		0,	
yycrank+-379,	yysvec+62,	0,	
yycrank+78,	0,		0,	
yycrank+0,	0,		yyvstop+180,
yycrank+54,	0,		0,	
yycrank+237,	0,		0,	
yycrank+65,	yysvec+4,	yyvstop+182,
yycrank+70,	0,		0,	
yycrank+79,	yysvec+4,	yyvstop+184,
yycrank+0,	yysvec+70,	0,	
yycrank+2241,	0,		0,	
yycrank+263,	yysvec+73,	0,	
yycrank+95,	yysvec+4,	yyvstop+187,
yycrank+142,	0,		0,	
yycrank+2315,	yysvec+4,	yyvstop+189,
yycrank+122,	0,		0,	
yycrank+0,	yysvec+4,	yyvstop+192,
yycrank+0,	yysvec+11,	yyvstop+195,
yycrank+0,	0,		yyvstop+197,
yycrank+2218,	0,		0,	
yycrank+298,	yysvec+4,	yyvstop+199,
yycrank+348,	0,		0,	
yycrank+1454,	yysvec+4,	yyvstop+201,
yycrank+395,	0,		0,	
yycrank+128,	yysvec+4,	yyvstop+203,
yycrank+2333,	yysvec+4,	yyvstop+205,
yycrank+97,	yysvec+4,	yyvstop+207,
yycrank+130,	yysvec+4,	yyvstop+209,
yycrank+99,	yysvec+4,	yyvstop+211,
yycrank+139,	yysvec+4,	yyvstop+213,
yycrank+118,	yysvec+4,	yyvstop+215,
yycrank+131,	yysvec+4,	yyvstop+217,
yycrank+101,	yysvec+4,	yyvstop+219,
yycrank+137,	yysvec+4,	yyvstop+221,
yycrank+133,	yysvec+4,	yyvstop+223,
yycrank+171,	yysvec+4,	yyvstop+225,
yycrank+173,	yysvec+4,	yyvstop+227,
yycrank+452,	yysvec+4,	yyvstop+230,
yycrank+170,	yysvec+4,	yyvstop+232,
yycrank+2393,	yysvec+4,	yyvstop+234,
yycrank+218,	yysvec+4,	yyvstop+236,
yycrank+188,	yysvec+4,	yyvstop+238,
yycrank+2401,	yysvec+82,	0,	
yycrank+213,	yysvec+4,	yyvstop+240,
yycrank+182,	yysvec+4,	yyvstop+242,
yycrank+-2490,	yysvec+23,	0,	
yycrank+-245,	yysvec+23,	0,	
yycrank+-2566,	yysvec+23,	0,	
yycrank+-593,	yysvec+23,	0,	
yycrank+0,	0,		yyvstop+244,
yycrank+556,	yysvec+4,	yyvstop+246,
yycrank+2616,	yysvec+4,	yyvstop+248,
yycrank+586,	0,		0,	
yycrank+646,	yysvec+4,	yyvstop+251,
yycrank+722,	yysvec+4,	yyvstop+253,
yycrank+2688,	yysvec+4,	yyvstop+255,
yycrank+766,	yysvec+4,	yyvstop+258,
yycrank+2706,	yysvec+4,	yyvstop+260,
yycrank+791,	0,		0,	
yycrank+818,	yysvec+4,	yyvstop+263,
yycrank+2778,	yysvec+4,	yyvstop+265,
yycrank+2850,	yysvec+4,	yyvstop+268,
yycrank+884,	yysvec+4,	yyvstop+270,
yycrank+182,	yysvec+4,	yyvstop+272,
yycrank+195,	yysvec+4,	yyvstop+274,
yycrank+-281,	yysvec+33,	0,	
yycrank+-2926,	yysvec+33,	0,	
yycrank+-251,	yysvec+33,	0,	
yycrank+280,	0,		yyvstop+277,
yycrank+-3030,	0,		0,	
yycrank+0,	yysvec+35,	yyvstop+279,
yycrank+-3134,	0,		yyvstop+281,
yycrank+291,	yysvec+35,	yyvstop+283,
yycrank+267,	yysvec+35,	yyvstop+285,
yycrank+-927,	yysvec+134,	yyvstop+288,
yycrank+269,	yysvec+35,	yyvstop+290,
yycrank+3215,	yysvec+35,	yyvstop+292,
yycrank+-283,	yysvec+134,	yyvstop+295,
yycrank+0,	yysvec+35,	yyvstop+297,
yycrank+-3298,	0,		yyvstop+300,
yycrank+907,	yysvec+35,	yyvstop+302,
yycrank+2304,	yysvec+35,	yyvstop+304,
yycrank+-947,	yysvec+134,	yyvstop+306,
yycrank+268,	yysvec+35,	yyvstop+308,
yycrank+3366,	yysvec+35,	yyvstop+310,
yycrank+238,	yysvec+35,	yyvstop+312,
yycrank+272,	yysvec+35,	yyvstop+314,
yycrank+241,	yysvec+35,	yyvstop+316,
yycrank+278,	yysvec+35,	yyvstop+318,
yycrank+256,	yysvec+35,	yyvstop+320,
yycrank+280,	yysvec+35,	yyvstop+322,
yycrank+254,	yysvec+35,	yyvstop+324,
yycrank+289,	yysvec+35,	yyvstop+326,
yycrank+258,	yysvec+35,	yyvstop+328,
yycrank+296,	yysvec+35,	yyvstop+330,
yycrank+314,	yysvec+35,	yyvstop+332,
yycrank+1021,	yysvec+35,	yyvstop+335,
yycrank+320,	yysvec+35,	yyvstop+337,
yycrank+3390,	yysvec+35,	yyvstop+339,
yycrank+354,	yysvec+35,	yyvstop+341,
yycrank+324,	yysvec+35,	yyvstop+343,
yycrank+349,	yysvec+35,	yyvstop+345,
yycrank+318,	yysvec+35,	yyvstop+347,
yycrank+1003,	yysvec+35,	yyvstop+349,
yycrank+3437,	yysvec+35,	yyvstop+351,
yycrank+-1059,	yysvec+134,	yyvstop+354,
yycrank+1210,	yysvec+35,	yyvstop+356,
yycrank+1356,	yysvec+35,	yyvstop+358,
yycrank+3509,	yysvec+35,	yyvstop+360,
yycrank+1316,	yysvec+35,	yyvstop+363,
yycrank+3527,	yysvec+35,	yyvstop+365,
yycrank+-1330,	yysvec+134,	yyvstop+368,
yycrank+1364,	yysvec+35,	yyvstop+370,
yycrank+3599,	yysvec+35,	yyvstop+372,
yycrank+3671,	yysvec+35,	yyvstop+375,
yycrank+1430,	yysvec+35,	yyvstop+377,
yycrank+313,	yysvec+35,	yyvstop+379,
yycrank+314,	yysvec+35,	yyvstop+381,
yycrank+-420,	yysvec+33,	0,	
yycrank+-388,	yysvec+62,	0,	
yycrank+-389,	yysvec+63,	0,	
yycrank+-3747,	yysvec+63,	0,	
yycrank+-3851,	0,		0,	
yycrank+-472,	yysvec+62,	0,	
yycrank+-520,	yysvec+62,	0,	
yycrank+-3955,	0,		0,	
yycrank+-4059,	0,		0,	
yycrank+0,	0,		yyvstop+384,
yycrank+399,	0,		0,	
yycrank+400,	0,		0,	
yycrank+401,	0,		0,	
yycrank+389,	yysvec+4,	yyvstop+386,
yycrank+407,	yysvec+4,	yyvstop+389,
yycrank+421,	0,		yyvstop+392,
yycrank+0,	yysvec+4,	yyvstop+394,
yycrank+0,	0,		yyvstop+397,
yycrank+422,	0,		0,	
yycrank+423,	0,		0,	
yycrank+424,	0,		0,	
yycrank+439,	yysvec+4,	yyvstop+399,
yycrank+443,	0,		yyvstop+402,
yycrank+577,	0,		yyvstop+404,
yycrank+395,	0,		0,	
yycrank+400,	0,		0,	
yycrank+444,	0,		0,	
yycrank+474,	0,		0,	
yycrank+470,	0,		0,	
yycrank+490,	0,		0,	
yycrank+683,	0,		0,	
yycrank+1551,	yysvec+4,	yyvstop+406,
yycrank+1581,	0,		0,	
yycrank+1593,	yysvec+4,	yyvstop+408,
yycrank+1621,	0,		0,	
yycrank+1685,	yysvec+4,	yyvstop+410,
yycrank+1726,	0,		0,	
yycrank+409,	yysvec+4,	yyvstop+412,
yycrank+2428,	yysvec+4,	yyvstop+414,
yycrank+382,	yysvec+4,	yyvstop+417,
yycrank+450,	yysvec+4,	yyvstop+419,
yycrank+420,	yysvec+4,	yyvstop+421,
yycrank+435,	yysvec+4,	yyvstop+423,
yycrank+405,	yysvec+4,	yyvstop+425,
yycrank+513,	yysvec+4,	yyvstop+427,
yycrank+456,	yysvec+4,	yyvstop+429,
yycrank+427,	yysvec+4,	yyvstop+431,
yycrank+497,	yysvec+4,	yyvstop+433,
yycrank+2677,	yysvec+4,	yyvstop+436,
yycrank+470,	yysvec+4,	yyvstop+438,
yycrank+445,	yysvec+4,	yyvstop+440,
yycrank+477,	yysvec+4,	yyvstop+442,
yycrank+459,	yysvec+4,	yyvstop+444,
yycrank+493,	0,		0,	
yycrank+500,	0,		0,	
yycrank+502,	0,		0,	
yycrank+564,	0,		0,	
yycrank+561,	0,		0,	
yycrank+738,	0,		0,	
yycrank+486,	yysvec+4,	yyvstop+446,
yycrank+457,	yysvec+4,	yyvstop+448,
yycrank+-4163,	yysvec+23,	0,	
yycrank+-4245,	yysvec+23,	0,	
yycrank+-4329,	0,		0,	
yycrank+2111,	yysvec+4,	yyvstop+450,
yycrank+1108,	0,		0,	
yycrank+1694,	yysvec+4,	yyvstop+453,
yycrank+1706,	0,		0,	
yycrank+538,	yysvec+246,	0,	
yycrank+566,	yysvec+4,	yyvstop+455,
yycrank+1786,	yysvec+4,	yyvstop+458,
yycrank+1814,	yysvec+4,	yyvstop+460,
yycrank+4385,	0,		yyvstop+463,
yycrank+2220,	yysvec+4,	yyvstop+465,
yycrank+1935,	0,		0,	
yycrank+583,	yysvec+255,	0,	
yycrank+583,	yysvec+4,	yyvstop+468,
yycrank+4419,	yysvec+4,	yyvstop+471,
yycrank+1806,	yysvec+4,	yyvstop+474,
yycrank+1832,	0,		0,	
yycrank+1910,	yysvec+4,	yyvstop+476,
yycrank+1970,	yysvec+4,	yyvstop+478,
yycrank+2129,	yysvec+253,	yyvstop+481,
yycrank+4453,	yysvec+4,	yyvstop+483,
yycrank+4480,	yysvec+4,	yyvstop+486,
yycrank+2409,	yysvec+4,	yyvstop+490,
yycrank+586,	yysvec+4,	yyvstop+493,
yycrank+0,	0,		yyvstop+496,
yycrank+-651,	yysvec+33,	0,	
yycrank+663,	0,		0,	
yycrank+601,	0,		0,	
yycrank+631,	0,		0,	
yycrank+588,	yysvec+35,	yyvstop+498,
yycrank+602,	yysvec+35,	yyvstop+501,
yycrank+0,	yysvec+35,	yyvstop+504,
yycrank+-605,	yysvec+134,	yyvstop+507,
yycrank+619,	yysvec+35,	yyvstop+510,
yycrank+-632,	yysvec+134,	yyvstop+513,
yycrank+0,	yysvec+132,	yyvstop+516,
yycrank+-603,	yysvec+11,	yyvstop+518,
yycrank+2634,	yysvec+35,	yyvstop+520,
yycrank+2608,	yysvec+35,	yyvstop+522,
yycrank+-2658,	yysvec+134,	yyvstop+524,
yycrank+2796,	yysvec+35,	yyvstop+526,
yycrank+-616,	yysvec+134,	yyvstop+528,
yycrank+599,	yysvec+35,	yyvstop+530,
yycrank+3185,	yysvec+35,	yyvstop+532,
yycrank+569,	yysvec+35,	yyvstop+535,
yycrank+612,	yysvec+35,	yyvstop+537,
yycrank+582,	yysvec+35,	yyvstop+539,
yycrank+614,	yysvec+35,	yyvstop+541,
yycrank+584,	yysvec+35,	yyvstop+543,
yycrank+720,	yysvec+35,	yyvstop+545,
yycrank+638,	yysvec+35,	yyvstop+547,
yycrank+608,	yysvec+35,	yyvstop+549,
yycrank+671,	yysvec+35,	yyvstop+551,
yycrank+3498,	yysvec+35,	yyvstop+554,
yycrank+644,	yysvec+35,	yyvstop+556,
yycrank+613,	yysvec+35,	yyvstop+558,
yycrank+652,	yysvec+35,	yyvstop+560,
yycrank+622,	yysvec+35,	yyvstop+562,
yycrank+655,	yysvec+35,	yyvstop+564,
yycrank+625,	yysvec+35,	yyvstop+566,
yycrank+2976,	yysvec+35,	yyvstop+568,
yycrank+2770,	yysvec+35,	yyvstop+571,
yycrank+-2812,	yysvec+134,	yyvstop+573,
yycrank+712,	yysvec+35,	yyvstop+575,
yycrank+2868,	yysvec+35,	yyvstop+578,
yycrank+2890,	yysvec+35,	yyvstop+580,
yycrank+-2230,	yysvec+134,	yyvstop+583,
yycrank+3080,	yysvec+35,	yyvstop+586,
yycrank+713,	yysvec+35,	yyvstop+589,
yycrank+4552,	yysvec+35,	yyvstop+592,
yycrank+2946,	yysvec+35,	yyvstop+595,
yycrank+-3050,	yysvec+134,	yyvstop+597,
yycrank+3201,	yysvec+35,	yyvstop+599,
yycrank+3406,	yysvec+35,	yyvstop+601,
yycrank+-3435,	yysvec+134,	yyvstop+604,
yycrank+4570,	yysvec+35,	yyvstop+607,
yycrank+4597,	yysvec+35,	yyvstop+610,
yycrank+3527,	yysvec+35,	yyvstop+614,
yycrank+710,	yysvec+35,	yyvstop+617,
yycrank+-712,	yysvec+33,	0,	
yycrank+0,	0,		yyvstop+620,
yycrank+0,	yysvec+185,	yyvstop+622,
yycrank+-718,	yysvec+185,	0,	
yycrank+-4681,	yysvec+63,	0,	
yycrank+0,	0,		yyvstop+624,
yycrank+-1159,	yysvec+62,	0,	
yycrank+-753,	yysvec+188,	yyvstop+626,
yycrank+-754,	yysvec+189,	yyvstop+628,
yycrank+0,	yysvec+70,	0,	
yycrank+0,	yysvec+70,	0,	
yycrank+0,	yysvec+70,	0,	
yycrank+717,	yysvec+4,	yyvstop+630,
yycrank+749,	0,		0,	
yycrank+0,	yysvec+78,	0,	
yycrank+0,	yysvec+76,	0,	
yycrank+0,	yysvec+78,	0,	
yycrank+751,	0,		0,	
yycrank+1195,	0,		0,	
yycrank+764,	0,		0,	
yycrank+683,	0,		0,	
yycrank+685,	0,		0,	
yycrank+726,	0,		0,	
yycrank+695,	0,		0,	
yycrank+729,	0,		0,	
yycrank+726,	0,		0,	
yycrank+698,	0,		0,	
yycrank+748,	0,		0,	
yycrank+718,	0,		0,	
yycrank+738,	0,		0,	
yycrank+707,	0,		0,	
yycrank+775,	0,		0,	
yycrank+0,	yysvec+4,	yyvstop+632,
yycrank+4728,	0,		0,	
yycrank+3354,	0,		0,	
yycrank+0,	yysvec+4,	yyvstop+635,
yycrank+0,	0,		yyvstop+638,
yycrank+757,	yysvec+4,	yyvstop+640,
yycrank+3328,	yysvec+4,	yyvstop+642,
yycrank+3569,	0,		0,	
yycrank+3639,	yysvec+4,	yyvstop+644,
yycrank+741,	yysvec+4,	yyvstop+646,
yycrank+775,	yysvec+4,	yyvstop+648,
yycrank+745,	yysvec+4,	yyvstop+650,
yycrank+864,	yysvec+4,	yyvstop+652,
yycrank+787,	0,		0,	
yycrank+840,	yysvec+4,	yyvstop+655,
yycrank+0,	yysvec+4,	yyvstop+657,
yycrank+818,	yysvec+4,	yyvstop+660,
yycrank+827,	yysvec+4,	yyvstop+662,
yycrank+796,	yysvec+4,	yyvstop+664,
yycrank+832,	yysvec+4,	yyvstop+666,
yycrank+802,	yysvec+4,	yyvstop+668,
yycrank+849,	0,		0,	
yycrank+826,	0,		0,	
yycrank+863,	0,		0,	
yycrank+833,	0,		0,	
yycrank+913,	0,		0,	
yycrank+864,	0,		0,	
yycrank+833,	0,		0,	
yycrank+867,	0,		0,	
yycrank+836,	0,		0,	
yycrank+920,	0,		0,	
yycrank+892,	yysvec+4,	yyvstop+670,
yycrank+861,	yysvec+4,	yyvstop+672,
yycrank+-4804,	yysvec+23,	0,	
yycrank+-4885,	yysvec+23,	0,	
yycrank+-4970,	0,		yyvstop+674,
yycrank+931,	0,		yyvstop+676,
yycrank+3681,	0,		0,	
yycrank+0,	0,		yyvstop+678,
yycrank+3797,	yysvec+4,	yyvstop+680,
yycrank+3901,	0,		yyvstop+683,
yycrank+945,	0,		yyvstop+685,
yycrank+2423,	0,		0,	
yycrank+959,	yysvec+397,	0,	
yycrank+959,	yysvec+4,	yyvstop+687,
yycrank+0,	0,		yyvstop+690,
yycrank+3689,	0,		0,	
yycrank+4005,	yysvec+4,	yyvstop+692,
yycrank+0,	yysvec+395,	yyvstop+696,
yycrank+4109,	yysvec+4,	yyvstop+699,
yycrank+3711,	yysvec+4,	yyvstop+703,
yycrank+890,	yysvec+4,	yyvstop+706,
yycrank+-974,	yysvec+33,	0,	
yycrank+0,	yysvec+6,	yyvstop+708,
yycrank+1036,	0,		0,	
yycrank+1096,	0,		0,	
yycrank+905,	0,		0,	
yycrank+909,	0,		0,	
yycrank+-5074,	yysvec+134,	yyvstop+710,
yycrank+976,	yysvec+35,	yyvstop+712,
yycrank+-993,	yysvec+134,	yyvstop+714,
yycrank+-994,	yysvec+134,	yyvstop+716,
yycrank+-928,	yysvec+11,	yyvstop+718,
yycrank+-915,	yysvec+11,	yyvstop+720,
yycrank+0,	yysvec+35,	yyvstop+722,
yycrank+-980,	yysvec+134,	yyvstop+725,
yycrank+0,	yysvec+35,	yyvstop+727,
yycrank+0,	yysvec+134,	yyvstop+730,
yycrank+957,	yysvec+35,	yyvstop+733,
yycrank+3767,	yysvec+35,	yyvstop+735,
yycrank+-3871,	yysvec+134,	yyvstop+737,
yycrank+4023,	yysvec+35,	yyvstop+739,
yycrank+945,	yysvec+35,	yyvstop+741,
yycrank+979,	yysvec+35,	yyvstop+743,
yycrank+948,	yysvec+35,	yyvstop+745,
yycrank+1092,	yysvec+35,	yyvstop+747,
yycrank+1023,	yysvec+35,	yyvstop+750,
yycrank+0,	yysvec+35,	yyvstop+752,
yycrank+978,	yysvec+35,	yyvstop+755,
yycrank+987,	yysvec+35,	yyvstop+757,
yycrank+975,	yysvec+35,	yyvstop+759,
yycrank+1010,	yysvec+35,	yyvstop+761,
yycrank+981,	yysvec+35,	yyvstop+763,
yycrank+1023,	yysvec+35,	yyvstop+765,
yycrank+995,	yysvec+35,	yyvstop+767,
yycrank+-1048,	yysvec+134,	yyvstop+769,
yycrank+4595,	yysvec+35,	yyvstop+771,
yycrank+-1463,	yysvec+134,	yyvstop+774,
yycrank+-4478,	yysvec+134,	yyvstop+776,
yycrank+-2436,	yysvec+134,	yyvstop+779,
yycrank+-1057,	yysvec+134,	yyvstop+781,
yycrank+1077,	yysvec+35,	yyvstop+784,
yycrank+-1070,	yysvec+134,	yyvstop+787,
yycrank+5020,	yysvec+35,	yyvstop+789,
yycrank+-4726,	yysvec+134,	yyvstop+793,
yycrank+5119,	yysvec+35,	yyvstop+797,
yycrank+4127,	yysvec+35,	yyvstop+801,
yycrank+1009,	yysvec+35,	yyvstop+804,
yycrank+-1207,	yysvec+33,	0,	
yycrank+-1080,	yysvec+62,	0,	
yycrank+-5202,	0,		0,	
yycrank+-5306,	0,		0,	
yycrank+-5410,	0,		0,	
yycrank+-5514,	0,		0,	
yycrank+-5618,	0,		0,	
yycrank+-5722,	0,		0,	
yycrank+1073,	0,		0,	
yycrank+1120,	0,		0,	
yycrank+1056,	0,		0,	
yycrank+1025,	0,		0,	
yycrank+1059,	0,		0,	
yycrank+1028,	0,		0,	
yycrank+1257,	0,		0,	
yycrank+1073,	0,		0,	
yycrank+1063,	0,		0,	
yycrank+1096,	0,		0,	
yycrank+1065,	0,		0,	
yycrank+1095,	0,		0,	
yycrank+1064,	0,		0,	
yycrank+1178,	0,		yyvstop+806,
yycrank+4219,	0,		0,	
yycrank+0,	0,		yyvstop+808,
yycrank+1140,	yysvec+4,	yyvstop+810,
yycrank+5252,	yysvec+4,	yyvstop+813,
yycrank+1108,	yysvec+4,	yyvstop+816,
yycrank+1962,	0,		0,	
yycrank+1155,	yysvec+4,	yyvstop+818,
yycrank+1116,	0,		0,	
yycrank+1122,	yysvec+4,	yyvstop+821,
yycrank+1100,	yysvec+4,	yyvstop+823,
yycrank+1126,	yysvec+4,	yyvstop+825,
yycrank+1099,	yysvec+4,	yyvstop+827,
yycrank+1136,	yysvec+4,	yyvstop+829,
yycrank+1110,	yysvec+4,	yyvstop+831,
yycrank+1162,	0,		0,	
yycrank+1131,	0,		0,	
yycrank+1163,	0,		0,	
yycrank+1136,	0,		0,	
yycrank+1387,	0,		0,	
yycrank+1175,	0,		0,	
yycrank+1153,	0,		0,	
yycrank+1184,	0,		0,	
yycrank+1153,	0,		0,	
yycrank+1256,	0,		yyvstop+833,
yycrank+1230,	yysvec+4,	yyvstop+835,
yycrank+-5826,	0,		0,	
yycrank+0,	0,		yyvstop+838,
yycrank+0,	yysvec+390,	0,	
yycrank+1553,	0,		0,	
yycrank+5356,	0,		yyvstop+841,
yycrank+3196,	0,		0,	
yycrank+1223,	yysvec+505,	0,	
yycrank+1224,	yysvec+4,	yyvstop+843,
yycrank+1225,	0,		yyvstop+846,
yycrank+0,	0,		yyvstop+848,
yycrank+0,	yysvec+504,	yyvstop+850,
yycrank+-1490,	yysvec+33,	0,	
yycrank+0,	yysvec+70,	0,	
yycrank+1377,	0,		0,	
yycrank+0,	yysvec+78,	0,	
yycrank+1167,	0,		0,	
yycrank+1172,	0,		0,	
yycrank+-5930,	yysvec+134,	yyvstop+853,
yycrank+-6034,	yysvec+134,	yyvstop+855,
yycrank+-6138,	yysvec+134,	yyvstop+857,
yycrank+-6242,	yysvec+134,	yyvstop+859,
yycrank+-6346,	yysvec+134,	yyvstop+861,
yycrank+-1183,	yysvec+11,	yyvstop+863,
yycrank+-1179,	yysvec+11,	yyvstop+865,
yycrank+0,	yysvec+134,	yyvstop+867,
yycrank+1264,	yysvec+35,	yyvstop+870,
yycrank+-1248,	yysvec+134,	yyvstop+873,
yycrank+5460,	yysvec+35,	yyvstop+875,
yycrank+1265,	yysvec+35,	yyvstop+878,
yycrank+1266,	yysvec+35,	yyvstop+880,
yycrank+1246,	yysvec+35,	yyvstop+883,
yycrank+1215,	yysvec+35,	yyvstop+885,
yycrank+1242,	yysvec+35,	yyvstop+887,
yycrank+1211,	yysvec+35,	yyvstop+889,
yycrank+1245,	yysvec+35,	yyvstop+891,
yycrank+1214,	yysvec+35,	yyvstop+893,
yycrank+1292,	yysvec+35,	yyvstop+895,
yycrank+-4737,	yysvec+134,	yyvstop+898,
yycrank+1299,	yysvec+35,	yyvstop+901,
yycrank+-1999,	yysvec+134,	yyvstop+904,
yycrank+-2759,	yysvec+134,	yyvstop+906,
yycrank+-1302,	yysvec+134,	yyvstop+908,
yycrank+0,	yysvec+134,	yyvstop+911,
yycrank+-4850,	yysvec+134,	yyvstop+914,
yycrank+-1602,	yysvec+33,	0,	
yycrank+0,	0,		yyvstop+918,
yycrank+-1334,	yysvec+455,	yyvstop+921,
yycrank+-1365,	yysvec+456,	yyvstop+923,
yycrank+-1366,	yysvec+457,	yyvstop+925,
yycrank+-1411,	yysvec+458,	yyvstop+927,
yycrank+-1413,	yysvec+459,	yyvstop+929,
yycrank+-1415,	yysvec+460,	yyvstop+931,
yycrank+1389,	0,		0,	
yycrank+1387,	0,		0,	
yycrank+1356,	0,		0,	
yycrank+1339,	0,		0,	
yycrank+1385,	0,		0,	
yycrank+1354,	0,		0,	
yycrank+1374,	0,		0,	
yycrank+1426,	0,		yyvstop+933,
yycrank+1376,	0,		0,	
yycrank+1355,	0,		0,	
yycrank+1391,	0,		0,	
yycrank+1373,	0,		0,	
yycrank+1417,	0,		0,	
yycrank+1387,	0,		0,	
yycrank+1497,	0,		0,	
yycrank+1473,	0,		yyvstop+935,
yycrank+5564,	0,		yyvstop+937,
yycrank+1459,	yysvec+82,	0,	
yycrank+4275,	0,		0,	
yycrank+1469,	yysvec+570,	0,	
yycrank+1469,	yysvec+4,	yyvstop+939,
yycrank+1463,	yysvec+4,	yyvstop+942,
yycrank+-6450,	0,		0,	
yycrank+1461,	0,		0,	
yycrank+1488,	0,		0,	
yycrank+1510,	0,		0,	
yycrank+1442,	0,		0,	
yycrank+1412,	0,		0,	
yycrank+1432,	yysvec+4,	yyvstop+944,
yycrank+1411,	yysvec+4,	yyvstop+946,
yycrank+1946,	yysvec+4,	yyvstop+948,
yycrank+1465,	yysvec+4,	yyvstop+951,
yycrank+1436,	yysvec+4,	yyvstop+953,
yycrank+1453,	0,		0,	
yycrank+1422,	0,		0,	
yycrank+1471,	0,		0,	
yycrank+1482,	0,		0,	
yycrank+1543,	0,		0,	
yycrank+1552,	0,		yyvstop+955,
yycrank+1504,	0,		0,	
yycrank+1474,	0,		0,	
yycrank+1527,	0,		0,	
yycrank+1507,	0,		0,	
yycrank+1637,	0,		0,	
yycrank+1580,	0,		yyvstop+957,
yycrank+6490,	0,		0,	
yycrank+0,	0,		yyvstop+959,
yycrank+0,	0,		yyvstop+962,
yycrank+1572,	0,		yyvstop+964,
yycrank+0,	0,		yyvstop+966,
yycrank+0,	yysvec+131,	yyvstop+968,
yycrank+1527,	0,		0,	
yycrank+1543,	0,		0,	
yycrank+-6573,	yysvec+134,	yyvstop+971,
yycrank+-6677,	yysvec+134,	yyvstop+974,
yycrank+-6781,	yysvec+134,	yyvstop+977,
yycrank+-6885,	yysvec+134,	yyvstop+980,
yycrank+-1551,	yysvec+11,	yyvstop+983,
yycrank+-1548,	yysvec+11,	yyvstop+985,
yycrank+-5126,	yysvec+134,	yyvstop+987,
yycrank+1613,	yysvec+35,	yyvstop+990,
yycrank+1591,	yysvec+35,	yyvstop+993,
yycrank+1572,	yysvec+35,	yyvstop+995,
yycrank+1545,	yysvec+35,	yyvstop+997,
yycrank+2052,	yysvec+35,	yyvstop+999,
yycrank+1597,	yysvec+35,	yyvstop+1002,
yycrank+1566,	yysvec+35,	yyvstop+1004,
yycrank+-2211,	yysvec+134,	yyvstop+1006,
yycrank+-3580,	yysvec+134,	yyvstop+1008,
yycrank+-1623,	yysvec+134,	yyvstop+1010,
yycrank+0,	yysvec+134,	yyvstop+1013,
yycrank+-1834,	yysvec+33,	0,	
yycrank+1633,	0,		0,	
yycrank+1643,	0,		yyvstop+1016,
yycrank+1602,	0,		0,	
yycrank+1584,	0,		0,	
yycrank+1628,	0,		0,	
yycrank+1597,	0,		0,	
yycrank+1632,	0,		0,	
yycrank+0,	0,		yyvstop+1018,
yycrank+1630,	0,		0,	
yycrank+1599,	0,		0,	
yycrank+1637,	0,		0,	
yycrank+1634,	0,		0,	
yycrank+-6989,	0,		0,	
yycrank+1710,	0,		0,	
yycrank+1704,	0,		yyvstop+1020,
yycrank+1716,	0,		0,	
yycrank+0,	0,		yyvstop+1022,
yycrank+-1737,	yysvec+574,	yyvstop+1024,
yycrank+1668,	0,		0,	
yycrank+1646,	0,		0,	
yycrank+1730,	0,		0,	
yycrank+1691,	0,		0,	
yycrank+1661,	0,		0,	
yycrank+1700,	0,		0,	
yycrank+1669,	0,		0,	
yycrank+1702,	yysvec+4,	yyvstop+1026,
yycrank+1671,	yysvec+4,	yyvstop+1028,
yycrank+1731,	yysvec+4,	yyvstop+1030,
yycrank+0,	yysvec+4,	yyvstop+1032,
yycrank+1703,	yysvec+4,	yyvstop+1035,
yycrank+1684,	yysvec+4,	yyvstop+1037,
yycrank+1717,	0,		0,	
yycrank+1717,	0,		0,	
yycrank+1771,	0,		0,	
yycrank+1740,	0,		0,	
yycrank+1778,	0,		0,	
yycrank+0,	0,		yyvstop+1039,
yycrank+1780,	0,		0,	
yycrank+1749,	0,		0,	
yycrank+-7093,	0,		0,	
yycrank+1782,	0,		0,	
yycrank+1829,	0,		0,	
yycrank+1765,	0,		0,	
yycrank+-1852,	yysvec+11,	yyvstop+1041,
yycrank+-1769,	yysvec+11,	yyvstop+1043,
yycrank+-2374,	yysvec+134,	yyvstop+1045,
yycrank+-4379,	yysvec+134,	yyvstop+1047,
yycrank+-1846,	yysvec+134,	yyvstop+1049,
yycrank+1805,	yysvec+35,	yyvstop+1052,
yycrank+1775,	yysvec+35,	yyvstop+1054,
yycrank+1883,	yysvec+35,	yyvstop+1056,
yycrank+0,	yysvec+35,	yyvstop+1058,
yycrank+1809,	yysvec+35,	yyvstop+1061,
yycrank+1795,	yysvec+35,	yyvstop+1063,
yycrank+0,	yysvec+134,	yyvstop+1065,
yycrank+-1930,	yysvec+33,	0,	
yycrank+0,	yysvec+553,	0,	
yycrank+1877,	0,		0,	
yycrank+1830,	0,		0,	
yycrank+1799,	0,		0,	
yycrank+1832,	0,		0,	
yycrank+1811,	0,		0,	
yycrank+1875,	0,		0,	
yycrank+1905,	0,		0,	
yycrank+2086,	0,		yyvstop+1068,
yycrank+-1928,	yysvec+636,	yyvstop+1070,
yycrank+1908,	0,		0,	
yycrank+1858,	0,		0,	
yycrank+1827,	0,		0,	
yycrank+1885,	0,		0,	
yycrank+1854,	0,		0,	
yycrank+2106,	0,		0,	
yycrank+1887,	0,		0,	
yycrank+1856,	0,		0,	
yycrank+1893,	0,		0,	
yycrank+1862,	0,		0,	
yycrank+-7197,	0,		yyvstop+1072,
yycrank+1911,	yysvec+4,	yyvstop+1074,
yycrank+1880,	yysvec+4,	yyvstop+1076,
yycrank+1901,	0,		0,	
yycrank+1871,	0,		0,	
yycrank+1904,	0,		0,	
yycrank+1873,	0,		0,	
yycrank+1940,	0,		0,	
yycrank+2202,	0,		yyvstop+1078,
yycrank+-2021,	yysvec+663,	yyvstop+1080,
yycrank+2014,	0,		0,	
yycrank+1961,	0,		0,	
yycrank+1961,	0,		0,	
yycrank+-1965,	yysvec+11,	yyvstop+1082,
yycrank+-1963,	yysvec+11,	yyvstop+1084,
yycrank+0,	yysvec+134,	yyvstop+1086,
yycrank+-7261,	yysvec+700,	yyvstop+1089,
yycrank+2000,	yysvec+35,	yyvstop+1091,
yycrank+1971,	yysvec+35,	yyvstop+1093,
yycrank+-2066,	yysvec+33,	0,	
yycrank+2043,	0,		0,	
yycrank+2046,	0,		0,	
yycrank+2022,	0,		0,	
yycrank+2024,	0,		0,	
yycrank+0,	0,		yyvstop+1095,
yycrank+2036,	0,		0,	
yycrank+2012,	0,		0,	
yycrank+1992,	0,		0,	
yycrank+2025,	0,		0,	
yycrank+1998,	0,		0,	
yycrank+2019,	0,		0,	
yycrank+1996,	0,		0,	
yycrank+-7336,	yysvec+700,	0,	
yycrank+-2207,	yysvec+700,	yyvstop+1097,
yycrank+0,	yysvec+4,	yyvstop+1099,
yycrank+2081,	0,		0,	
yycrank+2084,	0,		0,	
yycrank+2057,	0,		0,	
yycrank+0,	0,		yyvstop+1102,
yycrank+2110,	0,		0,	
yycrank+2012,	0,		0,	
yycrank+2035,	0,		0,	
yycrank+-2042,	yysvec+11,	yyvstop+1104,
yycrank+-2045,	yysvec+11,	yyvstop+1106,
yycrank+-7420,	yysvec+134,	yyvstop+1108,
yycrank+-7484,	yysvec+700,	yyvstop+1110,
yycrank+0,	yysvec+35,	yyvstop+1112,
yycrank+-2170,	yysvec+33,	0,	
yycrank+2142,	0,		0,	
yycrank+2112,	0,		0,	
yycrank+2192,	0,		0,	
yycrank+2205,	0,		0,	
yycrank+2089,	0,		0,	
yycrank+2059,	0,		0,	
yycrank+2518,	0,		yyvstop+1115,
yycrank+2100,	0,		0,	
yycrank+2085,	0,		0,	
yycrank+-7559,	yysvec+700,	0,	
yycrank+-2410,	yysvec+700,	yyvstop+1117,
yycrank+-2247,	yysvec+700,	yyvstop+1119,
yycrank+2532,	0,		0,	
yycrank+2198,	0,		0,	
yycrank+2226,	0,		0,	
yycrank+2083,	0,		0,	
yycrank+2085,	0,		0,	
yycrank+-2090,	yysvec+11,	yyvstop+1121,
yycrank+-2106,	yysvec+11,	yyvstop+1123,
yycrank+-7643,	yysvec+134,	yyvstop+1125,
yycrank+-7707,	yysvec+700,	yyvstop+1127,
yycrank+-7782,	yysvec+700,	yyvstop+1129,
yycrank+-2495,	yysvec+33,	0,	
yycrank+2223,	0,		0,	
yycrank+2304,	0,		0,	
yycrank+2306,	0,		0,	
yycrank+2191,	0,		0,	
yycrank+2162,	0,		0,	
yycrank+2198,	0,		0,	
yycrank+2167,	0,		0,	
yycrank+2206,	0,		0,	
yycrank+2203,	0,		0,	
yycrank+0,	0,		yyvstop+1131,
yycrank+2266,	0,		0,	
yycrank+2235,	0,		0,	
yycrank+2262,	0,		0,	
yycrank+2234,	0,		0,	
yycrank+-7857,	yysvec+700,	0,	
yycrank+-7932,	yysvec+700,	0,	
yycrank+-2370,	yysvec+700,	yyvstop+1133,
yycrank+-2366,	yysvec+700,	yyvstop+1135,
yycrank+2320,	0,		0,	
yycrank+2321,	0,		0,	
yycrank+2401,	0,		0,	
yycrank+2280,	0,		0,	
yycrank+2249,	0,		0,	
yycrank+2258,	0,		0,	
yycrank+2328,	0,		0,	
yycrank+-2272,	yysvec+11,	yyvstop+1137,
yycrank+-2342,	yysvec+11,	yyvstop+1139,
yycrank+-8016,	0,		yyvstop+1141,
yycrank+-2398,	yysvec+798,	yyvstop+1143,
yycrank+-8091,	yysvec+700,	yyvstop+1145,
yycrank+-8155,	yysvec+700,	yyvstop+1147,
yycrank+-2497,	yysvec+33,	0,	
yycrank+2392,	0,		0,	
yycrank+2297,	0,		0,	
yycrank+2288,	0,		0,	
yycrank+2322,	0,		0,	
yycrank+2291,	0,		0,	
yycrank+2323,	0,		0,	
yycrank+2304,	0,		0,	
yycrank+2372,	0,		0,	
yycrank+2353,	0,		0,	
yycrank+2379,	0,		0,	
yycrank+2358,	0,		0,	
yycrank+2391,	0,		0,	
yycrank+2360,	0,		0,	
yycrank+2407,	0,		0,	
yycrank+2377,	0,		0,	
yycrank+-8230,	yysvec+700,	0,	
yycrank+-8305,	yysvec+700,	0,	
yycrank+-2474,	yysvec+700,	yyvstop+1149,
yycrank+2462,	0,		0,	
yycrank+2407,	0,		0,	
yycrank+2402,	0,		0,	
yycrank+2446,	0,		0,	
yycrank+2415,	0,		0,	
yycrank+2472,	0,		0,	
yycrank+2449,	0,		0,	
yycrank+-8389,	0,		yyvstop+1152,
yycrank+2449,	0,		0,	
yycrank+-8493,	0,		yyvstop+1154,
yycrank+-2451,	yysvec+11,	yyvstop+1157,
yycrank+-8597,	yysvec+134,	yyvstop+1159,
yycrank+-8701,	yysvec+134,	yyvstop+1161,
yycrank+-8765,	yysvec+700,	yyvstop+1163,
yycrank+-2551,	yysvec+33,	0,	
yycrank+0,	0,		yyvstop+1166,
yycrank+2495,	0,		0,	
yycrank+2479,	0,		0,	
yycrank+2506,	0,		yyvstop+1168,
yycrank+2550,	0,		yyvstop+1170,
yycrank+2514,	0,		0,	
yycrank+2484,	0,		0,	
yycrank+2517,	0,		0,	
yycrank+2486,	0,		0,	
yycrank+2524,	0,		0,	
yycrank+2493,	0,		0,	
yycrank+-8840,	yysvec+700,	yyvstop+1172,
yycrank+0,	0,		yyvstop+1174,
yycrank+2537,	0,		0,	
yycrank+2506,	0,		0,	
yycrank+2577,	0,		yyvstop+1176,
yycrank+0,	0,		yyvstop+1178,
yycrank+2505,	0,		0,	
yycrank+0,	0,		yyvstop+1180,
yycrank+-2507,	yysvec+11,	yyvstop+1183,
yycrank+-8924,	yysvec+134,	yyvstop+1185,
yycrank+-2676,	yysvec+33,	0,	
yycrank+0,	0,		yyvstop+1188,
yycrank+0,	0,		yyvstop+1190,
yycrank+2573,	0,		0,	
yycrank+2550,	0,		0,	
yycrank+2521,	0,		0,	
yycrank+2543,	0,		0,	
yycrank+2512,	0,		0,	
yycrank+0,	0,		yyvstop+1192,
yycrank+2584,	0,		0,	
yycrank+2517,	0,		0,	
yycrank+-2518,	yysvec+11,	yyvstop+1194,
yycrank+-2880,	yysvec+33,	0,	
yycrank+2544,	0,		0,	
yycrank+2514,	0,		0,	
yycrank+0,	yysvec+794,	0,	
yycrank+-2539,	yysvec+11,	yyvstop+1196,
yycrank+-2743,	yysvec+33,	0,	
yycrank+2917,	0,		0,	
yycrank+-9028,	0,		0,	
yycrank+2591,	0,		0,	
yycrank+0,	0,		yyvstop+1198,
yycrank+-2607,	yysvec+876,	0,	
yycrank+-2612,	yysvec+876,	0,	
yycrank+-2613,	yysvec+876,	0,	
yycrank+-2615,	yysvec+876,	0,	
yycrank+-2617,	yysvec+876,	0,	
yycrank+-2626,	yysvec+876,	0,	
yycrank+-2627,	yysvec+876,	0,	
yycrank+-2628,	yysvec+876,	0,	
yycrank+-2630,	yysvec+876,	0,	
yycrank+-2631,	yysvec+876,	0,	
yycrank+-2633,	yysvec+876,	0,	
yycrank+-2634,	yysvec+876,	0,	
yycrank+-2635,	yysvec+876,	0,	
yycrank+-2647,	yysvec+876,	0,	
yycrank+-2568,	yysvec+876,	0,	
yycrank+2685,	0,		yyvstop+1200,
yycrank+0,	0,		yyvstop+1203,
0,	0,	0};
struct yywork *yytop = yycrank+9153;
struct yysvf *yybgin = yysvec+1;
unsigned char yymatch[] = {
00  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,011 ,012 ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
' ' ,01  ,'"' ,'#' ,01  ,'%' ,01  ,047 ,
'(' ,')' ,01  ,'+' ,01  ,'-' ,'.' ,'/' ,
'0' ,'1' ,'1' ,'1' ,'1' ,'1' ,'1' ,'1' ,
'1' ,'9' ,':' ,'%' ,01  ,'+' ,01  ,01  ,
01  ,'A' ,'B' ,'C' ,'D' ,'E' ,'F' ,'G' ,
'H' ,'I' ,'H' ,'K' ,'L' ,'M' ,'N' ,'O' ,
'P' ,'Q' ,'R' ,'S' ,'T' ,'H' ,'H' ,'W' ,
'X' ,'Y' ,'H' ,01  ,01  ,']' ,01  ,'+' ,
01  ,'a' ,'b' ,'c' ,'d' ,'e' ,'f' ,'g' ,
'h' ,'I' ,'H' ,'K' ,'L' ,'M' ,'N' ,'O' ,
'P' ,'Q' ,'R' ,'s' ,'T' ,'H' ,'H' ,'W' ,
'X' ,'Y' ,'H' ,01  ,01  ,'}' ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
01  ,01  ,01  ,01  ,01  ,01  ,01  ,01  ,
0};
unsigned char yyextra[] = {
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,1,
0,0,1,0,0,1,0,1,
0,0,0,0,0,0,0,0,
0};
/*
 * (c) Copyright 1990, OPEN SOFTWARE FOUNDATION, INC.
 * ALL RIGHTS RESERVED
 */
/*
 * OSF/1 Release 1.0
*/
/*
#
# IBM CONFIDENTIAL
# Copyright International Business Machines Corp. 1989
# Unpublished Work
# All Rights Reserved
# Licensed Material - Property of IBM
#
#
# US Government Users Restricted Rights - Use, duplication or
# disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
# 
*/
/* @(#)ncform	1.3  com/lib/l,3.1,8951 9/7/89 18:48:47 */
int yylineno =1;
# define YYU(x) x
# define NLSTATE yyprevious=YYNEWLINE
unsigned char yytext[YYLMAX];
struct yysvf *yylstate [YYLMAX], **yylsp, **yyolsp;
unsigned char yysbuf[YYLMAX];
unsigned char *yysptr = yysbuf;
int *yyfnd;
extern struct yysvf *yyestate;
int yyprevious = YYNEWLINE;
yylook(){
	register struct yysvf *yystate, **lsp;
	register struct yywork *yyt;
	struct yysvf *yyz;
	int yych, yyfirst;
	struct yywork *yyr;
# ifdef LEXDEBUG
	int debug;
# endif
	unsigned char *yylastch;
	/* start off machines */
# ifdef LEXDEBUG
	debug = 0;
# endif
	yyfirst=1;
	if (!yymorfg)
		yylastch = yytext;
	else {
		yymorfg=0;
		yylastch = yytext+yyleng;
		}
	for(;;){
		lsp = yylstate;
		yyestate = yystate = yybgin;
		if (yyprevious==YYNEWLINE) yystate++;
		for (;;){
# ifdef LEXDEBUG
			if(debug)fprintf(yyout,"state %d\n",yystate-yysvec-1);
# endif
			yyt = yystate->yystoff;
			if(yyt == yycrank && !yyfirst){  /* may not be any transitions */
				yyz = yystate->yyother;
				if(yyz == 0)break;
				if(yyz->yystoff == yycrank)break;
				}
			*yylastch++ = yych = input();
			yyfirst=0;
		tryagain:
# ifdef LEXDEBUG
			if(debug){
				fprintf(yyout,"char ");
				allprint(yych);
				putchar('\n');
				}
# endif
			yyr = yyt;
			if ( yyt > yycrank){
				yyt = yyr + yych;
				if (yyt <= yytop && yyt->verify+yysvec == yystate){
					if(yyt->advance+yysvec == YYLERR)	/* error transitions */
						{unput(*--yylastch);break;}
					*lsp++ = yystate = yyt->advance+yysvec;
					goto contin;
					}
				}
# ifdef YYOPTIM
			else if(yyt < yycrank) {		/* r < yycrank */
				yyt = yyr = yycrank+(yycrank-yyt);
# ifdef LEXDEBUG
				if(debug)fprintf(yyout,"compressed state\n");
# endif
				yyt = yyt + yych;
				if(yyt <= yytop && yyt->verify+yysvec == yystate){
					if(yyt->advance+yysvec == YYLERR)	/* error transitions */
						{unput(*--yylastch);break;}
					*lsp++ = yystate = yyt->advance+yysvec;
					goto contin;
					}
				yyt = yyr + YYU(yymatch[yych]);
# ifdef LEXDEBUG
				if(debug){
					fprintf(yyout,"try fall back character ");
					allprint(YYU(yymatch[yych]));
					putchar('\n');
					}
# endif
				if(yyt <= yytop && yyt->verify+yysvec == yystate){
					if(yyt->advance+yysvec == YYLERR)	/* error transition */
						{unput(*--yylastch);break;}
					*lsp++ = yystate = yyt->advance+yysvec;
					goto contin;
					}
				}
			if ((yystate = yystate->yyother) && (yyt= yystate->yystoff) != yycrank){
# ifdef LEXDEBUG
				if(debug)fprintf(yyout,"fall back to state %d\n",yystate-yysvec-1);
# endif
				goto tryagain;
				}
# endif
			else
				{unput(*--yylastch);break;}
		contin:
# ifdef LEXDEBUG
			if(debug){
				fprintf(yyout,"state %d char ",yystate-yysvec-1);
				allprint(yych);
				putchar('\n');
				}
# endif
			;
			}
# ifdef LEXDEBUG
		if(debug){
			fprintf(yyout,"stopped at %d with ",*(lsp-1)-yysvec-1);
			allprint(yych);
			putchar('\n');
			}
# endif
		while (lsp-- > yylstate){
			*yylastch-- = 0;
			if (*lsp != 0 && (yyfnd= (*lsp)->yystops) && *yyfnd > 0){
				yyolsp = lsp;
				if(yyextra[*yyfnd]){		/* must backup */
					while(yyback((*lsp)->yystops,-*yyfnd) != 1 && lsp > yylstate){
						lsp--;
						unput(*yylastch--);
						}
					}
				yyprevious = YYU(*yylastch);
				yylsp = lsp;
				yyleng = yylastch-yytext+1;
				yytext[yyleng] = 0;
# ifdef LEXDEBUG
				if(debug){
					fprintf(yyout,"\nmatch ");
					sprint(yytext);
					fprintf(yyout," action %d\n",*yyfnd);
					}
# endif
				return(*yyfnd++);
				}
			unput(*yylastch);
			}
		if (yytext[0] == 0  /* && feof(yyin) */)
			{
			yysptr=yysbuf;
			return(0);
			}
		yyprevious = yytext[0] = input();
		if (yyprevious>0)
			output(yyprevious);
		yylastch=yytext;
# ifdef LEXDEBUG
		if(debug)putchar('\n');
# endif
		}
	}
yyback(p, m)
	int *p;
{
if (p==0) return(0);
while (*p)
	{
	if (*p++ == m)
		return(1);
	}
return(0);
}
	/* the following are only used in the lex library */
yyinput(){
	return(input());
	}
yyoutput(c)
  int c; {
	output(c);
	}
yyunput(c)
   int c; {
	unput(c);
	}
