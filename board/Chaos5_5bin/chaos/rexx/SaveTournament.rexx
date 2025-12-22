/*RX

	$RCSFile: $
	$Revision: 2.1 $
	$Date: 1993/11/08 16:39:15 $

	This script tells Chaos to save the current tournament to the given
	tournament file.

	Usage:	LoadTournament tfile [icons]

	The icons option tells Chaos to create a project icon.

	Note, that this can only be used, when Chaos is able to accept
	commands, i.e. if menuitems can be selected.
*/

PARSE ARG filename force

ADDRESS 'CHAOS.1'

'LoadTournament 'filename' 'force
