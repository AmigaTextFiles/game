/*

$VER: solitaire.e 1.1 (1999.09.02) © Claude Heiland-Allen

Solves the game solitaire, involving jumping pieces until one remains.

*/

OPT PREPROCESS

OBJECT square
	x : CHAR
	y : CHAR
ENDOBJECT

OBJECT move
	from : square
	over : square
	to   : square
ENDOBJECT

OBJECT board
	data[81] : ARRAY OF CHAR
ENDOBJECT
-> bug in EC?: doesn't work if renamed B instead of D
#define D(x,y) data[(x)+((y)*9)]
#define S(square) D(square.x,square.y)

DEF _mask : PTR TO board, moves : PTR TO move, count = 0, best = 10
#define mask(x,y) _mask.D(x,y)

PROC main() HANDLE
	_mask := {boardmask}
	moves := {movetab}
	genmoves({startboard})
EXCEPT DO
	WriteF('\d positions considered\n', count)
ENDPROC

PROC genmoves(board : PTR TO board, pieces = 32)
	DEF move : PTR TO move, i, newboard : board, ret = FALSE
	IF CtrlC() THEN Raise("^C")
	count++
	IF pieces < best THEN WriteF('\d\n', best := pieces)
	-> check done
	IF pieces = 1
		IF board.D(4,4)
			printboard(board)
			RETURN TRUE
		ENDIF
	ENDIF
	-> check key pieces
	IF (board.D(2,4) OR
	    board.D(4,2) OR
	    board.D(4,4) OR
	    board.D(4,6) OR
	    board.D(6,4)) = 0
		RETURN FALSE
	ENDIF
	-> do moves
	move := moves
	FOR i := 0 TO 81-1 DO newboard.data[i] := board.data[i]
	WHILE move.from.x
		IF board.S(move.from)
			IF board.S(move.over)
				IF board.S(move.to) = 0
					newboard.S(move.from) := 0
					newboard.S(move.over) := 0
					newboard.S(move.to)   := 1
					IF genmoves(newboard, pieces - 1)
						printmove(move)
						ret := TRUE
					ENDIF
					newboard.S(move.from) := 1
					newboard.S(move.over) := 1
					newboard.S(move.to)   := 0
					IF ret THEN RETURN TRUE
				ENDIF
			ENDIF
		ENDIF
		move++
	ENDWHILE
ENDPROC FALSE

PROC printmove(move : PTR TO move)
	printsquare(move.from)
	WriteF('->')
	printsquare(move.to)
	WriteF(' [')
	printsquare(move.over)
	WriteF(']\n')
ENDPROC

PROC printsquare(sqr : PTR TO square) IS WriteF('(\d,\d)', sqr.x, sqr.y)

PROC printboard(board : PTR TO board)
	DEF x, y
	FOR y := 1 TO 7
		FOR x := 1 TO 7
			IF mask(x,y)
				WriteF('')
				IF board.D(x,y)
					WriteF('0')
				ELSE
					WriteF('·')
				ENDIF
			ELSE
				WriteF(' ')
			ENDIF
		ENDFOR
		WriteF('\n')
	ENDFOR
	WriteF('\n')
ENDPROC

/*
-> generate move table
PROC main() IS genmovetab()
PROC genmovetab()
	DEF x, y, d
	mask := {boardmask}
#define _move(x0,y0,x1,y1,x2,y2) \
WriteF('\t\d,\d,\d,\d,\d,\d,\n',x0,y0,x1,y1,x2,y2)
	WriteF('movetab: CHAR\n')
	FOR x := 1 TO 7
		FOR y := 1 TO 7
			IF mask(x,y)
				FOR d := -1 TO 1 STEP 2
					IF mask(x+d,y)
						IF mask(x+d+d,y)
							_move(x,y,x+d,y,x+d+d,y)
						ENDIF
					ENDIF
				ENDFOR
				FOR d := -1 TO 1 STEP 2
					IF mask(x,y+d)
						IF mask(x,y+d+d)
							_move(x,y,x,y+d,x,y+d+d)
						ENDIF
					ENDIF
				ENDFOR
			ENDIF
		ENDFOR
	ENDFOR
	WriteF('\t0\n\n')
ENDPROC
*/

boardmask:
   CHAR 0,0,0,0,0,0,0,0,0,
        0,0,0,1,1,1,0,0,0,
        0,0,0,1,1,1,0,0,0,
        0,1,1,1,1,1,1,1,0,
        0,1,1,1,1,1,1,1,0,
        0,1,1,1,1,1,1,1,0,
        0,0,0,1,1,1,0,0,0,
        0,0,0,1,1,1,0,0,0,
        0,0,0,0,0,0,0,0,0

startboard:
   CHAR 0,0,0,0,0,0,0,0,0,
        0,0,0,1,1,1,0,0,0,
        0,0,0,1,1,1,0,0,0,
        0,1,1,1,1,1,1,1,0,
        0,1,1,1,0,1,1,1,0,
        0,1,1,1,1,1,1,1,0,
        0,0,0,1,1,1,0,0,0,
        0,0,0,1,1,1,0,0,0,
        0,0,0,0,0,0,0,0,0

movetab:
   CHAR 1,3,2,3,3,3,
        1,3,1,4,1,5,
        1,4,2,4,3,4,
        1,5,2,5,3,5,
        1,5,1,4,1,3,
        2,3,3,3,4,3,
        2,3,2,4,2,5,
        2,4,3,4,4,4,
        2,5,3,5,4,5,
        2,5,2,4,2,3,
        3,1,4,1,5,1,
        3,1,3,2,3,3,
        3,2,4,2,5,2,
        3,2,3,3,3,4,
        3,3,2,3,1,3,
        3,3,4,3,5,3,
        3,3,3,2,3,1,
        3,3,3,4,3,5,
        3,4,2,4,1,4,
        3,4,4,4,5,4,
        3,4,3,3,3,2,
        3,4,3,5,3,6,
        3,5,2,5,1,5,
        3,5,4,5,5,5,
        3,5,3,4,3,3,
        3,5,3,6,3,7,
        3,6,4,6,5,6,
        3,6,3,5,3,4,
        3,7,4,7,5,7,
        3,7,3,6,3,5,
        4,1,4,2,4,3,
        4,2,4,3,4,4,
        4,3,3,3,2,3,
        4,3,5,3,6,3,
        4,3,4,2,4,1,
        4,3,4,4,4,5,
        4,4,3,4,2,4,
        4,4,5,4,6,4,
        4,4,4,3,4,2,
        4,4,4,5,4,6,
        4,5,3,5,2,5,
        4,5,5,5,6,5,
        4,5,4,4,4,3,
        4,5,4,6,4,7,
        4,6,4,5,4,4,
        4,7,4,6,4,5,
        5,1,4,1,3,1,
        5,1,5,2,5,3,
        5,2,4,2,3,2,
        5,2,5,3,5,4,
        5,3,4,3,3,3,
        5,3,6,3,7,3,
        5,3,5,2,5,1,
        5,3,5,4,5,5,
        5,4,4,4,3,4,
        5,4,6,4,7,4,
        5,4,5,3,5,2,
        5,4,5,5,5,6,
        5,5,4,5,3,5,
        5,5,6,5,7,5,
        5,5,5,4,5,3,
        5,5,5,6,5,7,
        5,6,4,6,3,6,
        5,6,5,5,5,4,
        5,7,4,7,3,7,
        5,7,5,6,5,5,
        6,3,5,3,4,3,
        6,3,6,4,6,5,
        6,4,5,4,4,4,
        6,5,5,5,4,5,
        6,5,6,4,6,3,
        7,3,6,3,5,3,
        7,3,7,4,7,5,
        7,4,6,4,5,4,
        7,5,6,5,5,5,
        7,5,7,4,7,3,
        0

version:
	CHAR '$VER: solitaire 1.1 (1999.09.02) © Claude Heiland-Allen',0
