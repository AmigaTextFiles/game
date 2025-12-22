packageAh: ahPuzzle
	// This puzzle ends when the door is unlocked
	ahDesc = "building"
	title = "What can I do about the package?"
	seen = true
	
	value = 2
;

packageH1: ahHintList
	owner = packageAh
	ahTell = [
		'Have you looked at the mailing address on the package?',
		'The package was delivered to you by mistake.',
		'Apartment 13 is just upstairs.'
	]
	ahAvail = { return (true); }
;

doorAh: ahPuzzle
	// This puzzle ends when the door is unlocked
	ahDesc = "door"
	title = "How can I open the door to apartment 13B?"
	value = 2
;

doorH1: doorAh
	owner = doorAh
	ahTell = [
		'Maybe you should open the mysterious package.'
	]
	ahAvail = { return ((doorAh.seen) and (package.firstTime)); }
;

doorH2: ahHintList
	owner = doorAh
	ahTell = [
		'The door has a keyless entry system.',
		'What do you suppose is used instead of a key?',
		'Have you tried putting your finger in the hole in the door?'
		'Maybe someone else\'s finger would work better.'
	]
	ahAvail = { return ((doorAh.seen) and (not (package.firstTime))); }
;


robotAh: ahPuzzle
	// This puzzle begins when the player first encounters the robot and ends
	// when they enter the archives.
	ahDesc = "building"
	title = "How can I get past the seeker-bot?"
;

robotH1: ahHintList
	owner = robotAh
	ahTell = [
		'The seeker-bot follows your motion.',
		'There might be a way to distract the seeker-bot long enough to get past it.'
	]
	ahAvail = { return (robotAh.seen); }
;
robotH2: ahHintList
	owner = robotAh
	ahTell = [
		'All that flying popcorn might have been useful to confuse the seeker-bot.'
	]
	ahAvail = { return (popcorn.isknownto(Me)); }
;

warmerAh: ahPuzzle
	// This puzzle begins when the player first encounters the handwarmer
	// when they enter the rub it when it is ready.
	ahDesc = "handwarmer"
	title = "How can I get the handwarmer to work?"
;

warmerH1: ahHintList
	owner = warmerAh
	ahTell = [
		'The instructions say that you need to put it in boiling water.'
	]
	ahAvail = { return (warmerAh.seen); }
;

warmerH2: ahHintList
	owner = warmerAh
	ahTell = [
		'Have you examined the metal thing in the lab?',
		'If only you had something to catch the water in.',
		'There is a beaker on the shelf in the store room.',
		'Put the beaker on the drain and pull the handle.'
	]
	ahAvail = { return ((warmerH1.seen) and (water.location = nil)); }
;

warmerH3: ahHintList
	owner = warmerAh
	ahTell = [
		'Now you need to find some way to heat the water.',
		'What about the Bunsen burner on the lab table?',
		'Put the beaker on the Bunsen burner and turn it on.'
	]
	ahAvail = { return ((warmerAh.seen) and (water.location = beaker)); }
;

popcornAh: ahPuzzle
	// This puzzle begins when the player first encounters the robot and ends
	// when they enter the archives.
	ahDesc = "popcorn"
	title = "How can I pop the popcorn?"
	seen = true
;

popcornH1: ahHintList
	owner = popcornAh
	ahTell = [
		'You\'re going to need a heat source if you want to pop the popcorn.'
	]
	ahAvail = { return (popcornBag.isknownto(Me)); }
;

popcornH2: ahHintList
	owner = popcornAh
	ahTell = [
		'The Bunsen burner on the lab table might pop the popcorn.',
		'The handwarmer is a better source of heat, because it is portable.'
	]
	ahAvail = { return ((popcornH1.seen) and burner.isknownto(Me)); }
;

safeAh: ahPuzzle
	ahDesc = "safe"
	title = "How can I open the safe?"
;
