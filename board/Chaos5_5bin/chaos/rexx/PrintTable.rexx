/*RX
	$RCSFile: $
	$Revision: 3.1 $
	$Date: 1994/03/23 15:52:36 $

	This program was created to satisfy the needs of some swiss users.
	They want to have the table output in a slightly another fashion
	than it is originally. Besides that it is a decent example of
	using Chaos via the ARexx port.

	Usage: PrintTable [tabmode [plrmode [linesperpage]]]

	tabmode and plrmode are the tables sorting mode and the player mode
	as documented in the ARexx call 'Table'.
	linesperpage is the number of lines to be printed before a page break.
	0 suppresses page breaks. (This is the default.)


	The original table output looks like this:

	Place Points Buchholz Name

	This should be changed to look like this:

	Place Name		    Chess club		    Points Buchholz

	What we need to do is:

	1) Let Chaos print the table into one file.
	2) Let Chaos print the list of players into another file.
	3) Write the new table to stdout. (We can use redirection, if this
	   should go to another file or the printer.)

	Note, that this can only be used, when Chaos is able to accept
	commands, i.e. if menuitems can be selected.
*/

/*
    Setting up global variables
*/
TableFileName	    = "t:PrintTable.table";
PlayerListFileName  = "t:PrintTable.playerlist";
DefaultTableMode    = "0";
DefaultPlayerMode   = "0";
DefaultLinesPerPage = "0";  /*  0 means no page breaks  */




/*
    Parsing command line arguments.
*/
PARSE ARG TableMode PlayerMode LinesPerPage
IF  TableMode == "?"  THEN DO
    SAY("Usage: PrintTable [tabmode [plrmode [linesperpage]]]");
    SAY("");
    SAY("Uses Chaos to create a table and prints it to stdout in a slightly");
    SAY("different manner. 'Printtable >prt: [args]' prints to the printer.");
    SAY("Note, that Chaos must be running, be ready to accept commands and");
    SAY("must the right tournament must be loaded already.");
    SAY("");
    SAY("Arguments are:");
    SAY("tabmode = the tables sorting mode: 0 = simple (Default), 1 = ");
    SAY("          Buchholz, 2 = extended Buchholz, 3 = Sonneborn-Berger");
    SAY("plrmode = which players to include into the table:");
    SAY("          0 = all (Default), 1 = seniors, 2 = juniors, 3 = women,");
    SAY("          4-8 = juniors A-E");
    SAY("linesperpage = number of lines to print on one page. 0 suppresses");
    SAY("               pagebreaks (Default).");
    exit(0);
END
IF  TableMode == ""  THEN DO
    TableMode = DefaultTableMode;
END
IF  PlayerMode == ""  THEN DO
    PlayerMode = DefaultPlayerMode;
END
IF  LinesPerPage == ""  THEN DO
    LinesPerPage = DefaultLinesPerPage;
END


/*
    Let Chaos write the current table.
*/
ADDRESS "CHAOS.1"   "Table "TableFileName" TABMODE="TableMode" PLRMODE="PlayerMode
IF  RC ~= 0  THEN DO
    SAY("Chaos: Cannot create table. (Chaos not running, no pairings or invalid");
    SAY("table mode");
    EXIT(10);
END;


/*
    Open the table file
*/
IF ~OPEN(.TableFile, TableFileName, "Read") THEN DO
    SAY ("Cannot open table file.");
    EXIT(10)
END


/*
    Read the table header.
*/
TournamentName = READLN(.TableFile);    /*  Read the tournaments name.  */
Line = READLN(.TableFile);              /*  Skip empty line.            */
TitleString = ReadLn(.TableFile);       /*  Read the table title.       */
Line = READLN(.TableFile);              /*  Skip empty line.            */
Line = READLN(.TableFile);              /*  Read the page header.       */
PlaceString = WORD(Line, 1);
PointsString = WORD(Line, 2);
NextString = 3;
IF  TableMode ~= 0  THEN DO
    BuchholzString = WORD(Line, 3);
    NextString = 4;
END;
IF  TableMode == 2  THEN DO
    ExtBuchholzString = WORD(Line, 4);
    NextString = 5;
END;
NameString = WORD(Line, NextString);
Line = READLN(.TableFile);              /*  Skip empty line.            */


/*
    Read the players.
*/
NumPlayers = 0;
DO WHILE ~EOF(.TableFile);
    NumPlayers = NumPlayers + 1;
    Line = READLN(.TableFile);
    Players.NumPlayers.Place = WORD(Line, 1);
    Players.NumPlayers.Points = WORD(Line, 2);
    FirstNameChar = 13;
    IF	TableMode ~= 0	THEN DO
	Players.NumPlayers.Buchholz = WORD(Line, 3);
	FirstNameChar = 22;
    END;
    IF	TableMode == 2	THEN DO
	Players.NumPlayers.ExtBuchholz = WORD(Line, 4);
	FirstNameChar = 32;
    END;
    /*
	Names (and the Chessclubs) may contain blanks and hence must be
	handled in a different manner.
    */
    Players.NumPlayers.Name = STRIP(SUBSTR(Line, FirstNameChar), 'T');
END


/*
    Close the table file.
*/
IF  ~CLOSE(.TableFile)  THEN DO
    SAY("Cannot close tablefile.");
    EXIT(10);
END;


/*
    Let Chaos write the list of players.
*/
ADDRESS "CHAOS.1"  "PlayerList "PlayerListFileName" short"


/*
    Open the file with the list of players.
*/
IF ~OPEN(.PlayerListFile, PlayerListFileName, "Read") THEN DO
    SAY ("Cannot open list of players.");
    EXIT(10)
END


/*
    Read the playerlists header.
*/
DO  i=1  TO  4				/*  Skip the tournamentname and */
    Line = READLN(.PlayerListFile);     /*  the title.                  */
END
Line = READLN(.PlayerListFile);         /*  Read the chessclub string.  */
ChessclubString = WORD(Line, 5);
Line = READLN(.PlayerListFile);         /*  Skip the empty line.        */


/*
    Scan the players to find a players chess club.
*/
DO WHILE  ~EOF(.PlayerListFile)
    Line = READLN(.PlayerListFile);
    CurrentName = STRIP(SUBSTR(Line, 5, 30, ), 'T',);
    DO	i=1  TO  NumPlayers
	IF  CurrentName == Players.i.Name  THEN DO
	    Players.i.ChessClub = STRIP(SUBSTR(Line, 51,,));
	END
    END
END


/*
    Close the file with the player list.
*/
IF  ~CLOSE(.PlayerListFile)  THEN DO
    SAY("Cannot close list of players.");
    EXIT(10);
END;


/*
    Finally print the new table.
*/
IF  TableMode == 0  THEN DO
    HeaderString = RIGHT(PlaceString, 5)" "LEFT(NameString, 30);
    HeaderString = HeaderString" "LEFT(ChessclubString, 30);
    HeaderString = HeaderString" "RIGHT(PointsString, 6);
END
IF  TableMode == 1  |  TableMode == 3  THEN DO
    HeaderString = RIGHT(PlaceString, 5)" "LEFT(NameString, 30);
    HeaderString = HeaderString" "LEFT(ChessclubString, 23);
    HeaderString = HeaderString" "RIGHT(PointsString, 6);
    HeaderString = HeaderString" "RIGHT(BuchholzString, 8);
END
IF  TableMode == 2  THEN DO
    HeaderString = RIGHT(PlaceString, 5)" "LEFT(NameString, 23);
    HeaderString = HeaderString" "LEFT(ChessclubString, 20);
    HeaderString = HeaderString" "RIGHT(PointsString, 6);
    HeaderString = HeaderString" "RIGHT(BuchholzString, 8);
    HeaderString = HeaderString" "RIGHT(ExtBuchholzString, 9);
END


CurrentPageLines = -1;
DO  i=1  TO  NumPlayers
    IF	CurrentPageLines == -1	|  CurrentPageLines = LinesPerPage  THEN DO
	SAY(TournamentName);
	SAY("");
	SAY(TitleString);
	SAY("");
	SAY(HeaderString);
	SAY("");
	CurrentPageLines = 8;
    END
    IF	TableMode == 0	THEN DO
	Line = RIGHT(Players.i.Place, 5)" "LEFT(Players.i.Name, 30);
	Line = Line" "LEFT(Players.i.Chessclub, 30);
	Line = Line" "RIGHT(Players.i.Points, 6);
    END
    IF	TableMode == 1	|  TableMode == 3  THEN DO
	Line = RIGHT(Players.i.Place, 5)" "LEFT(Players.i.Name, 30);
	Line = Line" "LEFT(Players.i.Chessclub, 23);
	Line = Line" "RIGHT(Players.i.Points, 6);
	Line = Line" "RIGHT(Players.i.Buchholz, 8);
    END
    IF	TableMode == 2	THEN DO
	Line = RIGHT(Players.i.Place, 5)" "LEFT(Players.i.Name, 23);
	Line = Line" "LEFT(Players.i.Chessclub, 20);
	Line = Line" "RIGHT(Players.i.Points, 6);
	Line = Line" "RIGHT(Players.i.Buchholz, 8);
	Line = Line" "RIGHT(Players.i.ExtBuchholz, 9);
    END
    SAY(Line);
    CurrentPageLines = CurrentPageLines + 1;
    IF	CurrentPageLines = LinesPerPage  THEN DO
	SAY("");
	SAY("Chaos V5.3     (C) 1993        by  Jochen Wiedmann");
	WRITECH(STDOUT, "0c"x);
    END;
END;
IF  LinesPerPage ~= 0  &  CurrentPageLines ~= LinesPerPage  THEN DO
    DO	i=CurrentPageLines+1  TO  LinesPerPage
	SAY("");
    END;
    SAY("");
    SAY("Chaos V5.3     (C) 1993        by  Jochen Wiedmann");
    WRITECH(STDOUT, "0c"x);
END;
