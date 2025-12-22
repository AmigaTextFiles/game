/*RX
	$RCSFile: $
	$Revision: 2.1 $
	$Date: 1993/12/12 13:22:15 $

	This program is intended to support the use of a tournament file as
	a database. It should be called from Chaos itself to update the
	DWZ numbers in a previously saved tournament file.

	Usage: UpdateRatings [filename]

	<filename> is the name of a database file. This argument is not
	required if you have RequestFile or a similar command: The script
	brings up a requester to select a file in that case. (The commands
	name can be changed below in the script. However, it must write the
	filename to stdout.) I don't know, if RequestFile is available below
	of Workbench 39, sorry.

	Important notes:
	- This script must not be used, if Chaos isn't ready to receive
	  commands. Chaos shows that it is ready by enabling the menu bar in
	  its main window. The best way to ensure this, is to call it from
	  the menu bar itself by including the script into s/ChaosMenu.
	- It is assumed, that the player names in the tournament and in the
	  database file are identical. The best way to ensure this is, to
	  use the menu item "Import".
*/


/*
    Setting up global variables
*/
DWZFileName		= "t:UpdateRatings.DWZoutput";
PlayerListFileName	= "t:UpdateRatings.PlayerList";
CurrentTournamentName	= "t:CurrentTournament.cdat";



/*
    Parsing command line arguments.
*/
PARSE ARG FileName
IF  FileName == "?" THEN DO
    SAY("Usage: UpdateRatings [filename]");
    SAY("");
    SAY("Uses Chaos to create a listing of the current tournaments DWZ numbers.");
    SAY("These numbers will be updated in the tournament file <filename>.");
    SAY("If filename isn't present, ",RequestCommand," will be used to");
    SAY("select a file.");
    exit(0);
END;
IF FileName == "" THEN DO
    ADDRESS COMMAND RequestFile ">t:UpdateRatings.FileName #?.cdat";
    IF ~OPEN(.FileNameFile, "t:UpdateRatings.FileName", "Read") THEN DO
	SAY ("Cannot get database name.");
	EXIT(10);
    END;
    FileName = READLN(.FileNameFile);
    IF	~CLOSE(.FileNameFile)  THEN DO
	SAY("Cannot get database name.");
	EXIT(10);
    END;
    IF FileName == ""  THEN DO
	EXIT(0);    /*  User selected "Cancel"  */
    END;
END;


/*
    Let Chaos write the list of DWZ numbers.
*/
ADDRESS "CHAOS.1"   "DWZReport "DWZFileName
IF  RC ~= 0  THEN DO
    SAY("Chaos: Cannot create table. (Chaos not ready, not running or no pairings?)");
    EXIT(10);
END;


/*
    Open the list of DWZ numbers.
*/
IF ~OPEN(.DWZFile, DWZFileName, "Read") THEN DO
    SAY ("Cannot open DWZ list.");
    EXIT(10)
END;


/*
    Read the table header.
*/
Line = READLN(.DWZFile);                /*  Skip the tournament name.   */
Line = READLN(.DWZFile);                /*  Skip empty line.            */
Line = READLN(.DWZFile);                /*  Skip report title.          */
Line = READLN(.DWZFile);                /*  Skip empty line.            */
Line = READLN(.DWZFile);                /*  Skip page header. (2 lines) */
Line = READLN(.DWZFile);
Line = READLN(.DWZFile);                /*  Skip empty line.            */


/*
    Read the players.
*/
NumPlayers = 0;
DO UNTIL EOF(.DWZFile);
    Line = READLN(.DWZFile);
    IF ~EOF(.DWZFILE) THEN DO
	NumPlayers = NumPlayers + 1;
	/*
	    Names (and the Chessclubs) may contain blanks and hence must be
	    handled in a different manner than numbers.
	*/
	Players.NumPlayers.Name = STRIP(SUBSTR(Line, 1, 30), 'B');
	Players.NumPlayers.DWZ = WORD(SUBSTR(Line, 31), 6);
	Line = READLN(.DWZFile);            /*  Skip birthday line.     */
    END;
END;


/*
    Close the DWZ list.
*/
IF  ~CLOSE(.DWZFile)  THEN DO
    SAY("Cannot close DWZ list.");
    EXIT(10);
END;


/*
    Let Chaos save the current tournament to ensure, that we can load
    another and restore the current state.
*/
ADDRESS "CHAOS.1" "SaveTournament "CurrentTournamentName


/*
    Let Chaos load the database file.
*/
ADDRESS "CHAOS.1" "LoadTournament "FileName


/*
    Let Chaos write the list of players to find, which players should be
    updated.
*/
ADDRESS "CHAOS.1" "PlayerList "PlayerListFileName" short"


/*
    Open the list of players.
*/
IF ~OPEN(.PlayerListFile, PlayerListFileName, "Read") THEN DO
    SAY ("Cannot open player list.");
    EXIT(10)
END;


/*
    Read the player list header.
*/
Line = READLN(.PlayerListFile);         /*  Skip the tournament name.   */
Line = READLN(.PlayerListFile);         /*  Skip empty line.            */
Line = READLN(.PlayerListFile);         /*  Skip list title.            */
Line = READLN(.PlayerListFile);         /*  Skip empty line.            */
Line = READLN(.PlayerListFile);         /*  Skip page header.           */
Line = READLN(.PlayerListFile);         /*  Skip empty line.            */


/*
    Read the players and update them, if they were present in the DWZ
    report.
    (Sorry, this is not an example of very good programming. We could use
    the fact, that both lists are sorted alphabetically in order to enhance
    speed. But I doubt, we would win that much.)
*/
DO UNTIL EOF(.PlayerListFile);
    Line = READLN(.PlayerListFile);
    IF	~EOF(.PlayerListFile)  THEN DO
	CurrentPlayerName = STRIP(SUBSTR(Line, 6, 30), 'B');
	/*
	    Check, if we find the current player in the DWZ report.
	*/
	DO  i = 1   TO	NumPlayers;
	    IF	CurrentPlayerName == Players.i.Name  THEN  DO
		ADDRESS "CHAOS.1" 'ModifyPlayer "'CurrentPlayerName'" RATING 'Players.i.DWZ
	    END;
	END;
    END;
END;


/*
    Close the player list.
*/
IF  ~CLOSE(.PlayerListFile)  THEN DO
    SAY("Cannot close player list. Current tournament is saved in "CurrentTournamentName);
    EXIT(10);
END;


/*
    Save the database.
*/
ADDRESS "CHAOS.1" "SaveTournament "FileName


/*
    Restore the current tournament.
*/
ADDRESS "CHAOS.1" "LoadTournament "CurrentTournamentName


/*
    Well, guys, thats it! :-)
*/
