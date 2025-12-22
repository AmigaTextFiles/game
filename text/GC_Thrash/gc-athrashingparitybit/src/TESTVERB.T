/*
 * TEST VERBS
 */

gimmeVerb: TESTVERB /* Testing Only */
	sdesc = "gimme"
	verb = 'gimme'
	doAction = 'Gimme'
;

gotoVerb: TESTVERB /* Testing Only */
	sdesc = "goto"
	verb = 'goto'
	doAction = 'Goto'
;

locationVerb: TESTVERB /* Testing Only */
	sdesc = "locate"
	verb = 'location' 'locate'
	doAction = 'Locate'
;

aspirateVerb: TESTVERB /* Testing Only */
	verb = 'aspir'
	sdesc = "aspirate"
	doAction = 'Aspirate'
;

turingVerb: TESTVERB /* Testing Only */
	verb = 'turify'
	sdesc = "turify"
	action(actor) = { arpa.haseaten := true; "\nYou cheater!\n"; }
;

