Me: Player
	ldesc = "You <<t.are>> better than the rest. "
	
	noun = 'me' 'self' 'myself' 'body'
	adjective = 'my'
	
	location = startroom
	locationtype = 'in'
	position = 'standing'

	starvationcheck = nil
	dehydrationcheck = nil
	sleepcheck = nil
	
	verDoRub(actor) = { "There <<t.will>> be time for that later. "; }
	verDoEat(actor) = { "Auto-canibalism <<t.is>> not the answer. "; }
	
	putmessage(dobj, loctype) = {
		if ((dobj = jumpStick) and (not (jumpStick.taken))) {
			jumpStick.taken := true;
			"\^<<t.itis>> very heavy and cold to the touch. ";
		}
		else {"Taken. "; }
	}
	
	speech_handler(s) = {
		"\^<<self.subjthedesc>> <<t.sayH>>\ 
		\"<<s>>.\" ";
		if ((s = 'put the chunky tofu into the river') 
			or (s = 'put the chunky tofu in the river')
			or (s = 'put the tofu into the river')
			or (s = 'put the tofu in the river')) {
			spy.spyMsg;
		}
	}
	
	
;

class Appendage: Item
	bulk = 0
	
	location = Me
	
	isnoticeable(actor) = { return nil; }
	
	doTake(actor) = {
		"That <<t.is>> just as productive as milking a dead cow. ";
	}
	verDoDrop(actor) = { 
		"For some reason you <<t.cant>> seem to remove 
		 <<self.sdesc>> from your body. ";
	}
	verDoPutX(actor, io, loctype) = {
		"Keep <<self.sdesc>> to yourself. ";
	}
	verDoEat(actor) = {actor.verDoEat(actor);}
;

myFingers: Appendage
	sdesc = "your finger"
	ldesc = "Your fingers <<t.are>> all firmly attached to your hand. \n"

	isdetermined = true
	noun = 'digit' 'fingers' 'finger'
	adjective = 'my' 'your'
	
	verDoEat(actor) = { "I've heard of \"finger-food\", but that's disgusting! "; }
;

myHands: Appendage
	sdesc = "your hands"
	ldesc = "You <<t.pride>> yourself on your normalcy; there was one at the end of each arm. "
	
	isdetermined = true
	noun = 'hand' 'hands'
	adjective = 'my' 'your'
;

myArms: Appendage
	sdesc = "your arms"
	ldesc = "Yes, you <<t.have>> two arms, all the better to carry things with. "
	
	isdetermined = true
	noun = 'arm' 'arms'
	adjective = 'my' 'yours'
;

myLegs: Appendage
	sdesc = "your legs"
	ldesc = "Your legs <<t.look>> just fine. "
	
	isdetermined = true
	noun = 'leg' 'legs'
	adjective = 'my' 'your'
;

myHead: Appendage
	sdesc = "your head"
	ldesc = "What a silly idea.  Now maybe if you had a removable eyeball..."
	
	isdetermined = true
	noun = 'head'
	adjective = 'my' 'your'
;
