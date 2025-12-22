/*RX

	$RCSFile: $
	$Revision: 2.1 $
	$Date: 1993/11/08 16:39:15 $

	This script tells Chaos to load the given tournament file.

	Usage:	LoadTournament tfile [force]

	The force option suppresses the requester which asks, if the
	current tournament should be saved first.

	Note, that this can only be used, when Chaos is able to accept
	commands, i.e. if menuitems can be selected.
*/

PARSE ARG filename force

ADDRESS 'CHAOS.1'

'LoadTournament 'filename' 'force
