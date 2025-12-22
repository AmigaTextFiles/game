I wrote sg2ishi to convert go game files written in the
popular "mgt" format into ones that would be compatible with
the Ishi-standard format used by the Many Faces of Go program.
Actually, sg2ishi uses the subset of Smart-Go commands that
are supported by mgt and that have equivalent commands in the
Ishi-standard formt. (See table 1 below..)

Certain "features" of the mgt format could not be incorporated
into the Ishi-standard as it is represented by Many Faces of GO.

1. If multiple games or problems are contained in one mgt file,
Many Faces of Go will play only the first "event" in that file
after it is converted to the Ishi-standard format by sg2ishi.
This problem is apparently a limitation of the way that Many
Faces of Go incorporates the Ishi-standard format.

2. Variations are not incorporated into sg2ishi yet. The
program will only work for single game records in this version. 

3. The comments in mgt formatted files sometimes include
references to the goban's coordinates using the standard A->T
and 1->19 coordinate system. The board used by Many Faces of Go
does not show coordinates. It's on my "to-do" list to abstract
such information from the comments and actually mark the
points on the goban referred to by the comments.

4. Some mgt files contain problems or partially-played game
situations starting out with some number of stones already
played on the goban. If the mgt file uses the AB (AddBlack) or
AW (AddWhite) notation, then sg2ishi will place all of the
stones on the board at once. However, if the mgt file used the
format:

Black[pd][dp][op][lp]
;
White[qp][dc][po][pl]
;	

the stones will be placed with eight sequential "moves" when
the game is played by Many Faces of Go.


TABLE 1.

mgt notation supported by sg2ishi:
--------------------------------------
AB: add black stones     [point list] 
AW: add white stones     [point list] 
B : Black move           [move]       
BR: Black's rank         [text]       
C : Comment              [Text]       
DT: date                 [text]       
EV: event (tournament)   [text]       
GC: game comment         [text]       
GN: game name            [text]       
KM: komi                 [real]       
L : letters on points    [point list] 
M : marked points        [point list] 
N : Node Name            [Text]       
PB: black player name    [text]       
PC: place                [text]       
PW: white player name    [text]       
RE: result, outcome      [text]       
SZ: board size           [number]     
US: who entered game     [text]
W : White move           [move]       
WR: White's rank         [text]       


mgt notation not supported by sg2ishi
--------------------------------------
AE: add empty stones     [point list] 
GM: game                 [number]     
HA: handicap             [number]     
PL: player to play first [color]      
RO: round                [text]       
SO: source (book, journa [text]       
TM: time limit per playe [text]       
VW: view                              


This program is in a true beta version; I have tested it on
mgt files that I have downloaded from milton.u.washington.edu
and that were created by a variety of players, but I am sure
that there are some input files that will break the program
somewhere. All suggestions, comments, etc., are solicited and
should be sent via email to:
junger@mtn.er.usgs.gov
or, if email is unavailable, I read the Usenet group:
rec.games.go regularly.

As you can see from the source code, I used a very
straightforward approach to writing this program; no tables,
no yacc, no lex, just some switch, case, and if statements. It
should be easy to follow the logic of the code from top to
bottom, as they used to say... Furthermore, nothing in the
program is OS-specific; it should compile and run on any
hardware that has a C compiler. If you want to add some of the
unsupported mgt features, have at it.

The MS-DOS executible in the zipped file was generated with
Borland C++, version 2.0. Since I have not included a Makefile
with the code, perhaps for non-programmers I should add that
to compile sg2ishi on a Unix system you must type the line:

cc sg2ishi.c -o sg2ishi

at the shell prompt. 

The program expects two command line arguements, one for the
input file name and one for the output file name. So to run
the program you type:

sg2ishi mgt_file manyface.go

Note that Many Faces of Go needs the suffix .go so that it can
recognize the file as a game file.
