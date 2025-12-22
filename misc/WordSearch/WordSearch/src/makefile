flags = -d0 -ma -O

wordsearch:	wordsearch.o puzzle.o interctrl.o interface.o file.o words.o wsearch.o request.o
		lc -Lt -M wordsearch puzzle interctrl interface file words wsearch request reqglue

# CLI stdio based original program
wsearch1:	wsearch1.o wsearch.o request.o
		lc -Lt -M wsearch1 wsearch request
			
wordsearch.o:	wordsearch.c
		lc $(flags) wordsearch.c

puzzle.o:	puzzle.c
		lc $(flags) puzzle.c

interctrl.o:	interctrl.c
		lc $(flags) interctrl.c

interface.o:	interface.c
		lc $(flags) interface.c

file.o:		file.c
		lc $(flags) file.c

words.o:	words.c
		lc $(flags) words.c

wsearch1.o:	wsearch1.c
		lc $(flags) wsearch1.c
		
wsearch.o:	wsearch.c
		lc $(flags) wsearch.c

request.o:	request.c
		lc $(flags) request.c

reqglue.o:	reqglue.asm
		a68k reqglue.asm -oreqglue.o -iinclude:

