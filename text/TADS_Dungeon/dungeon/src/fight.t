/* stuff for fighting */

diagnoseVerb: deepverb
    verb = 'diagnose'
    sdesc = "diagnose"
    action( actor ) =
    {
	/* Not very accurate (damage isn't scaled), but... */
	local ht, tmp;
	tmp := ht := -Me.strength;
	if (ht > 4) ht := 4;
	switch(ht) {
	case 0:
	    "You are in perfect health.\n"; break;
	case 1:
	    "You have a light wound.\n"; break;
	case 2:
	    "You have a serious wound.\n"; break;
	case 3:
	    "You have several wounds.\n"; break;
	case 4:
	    "You have serious wounds.\n"; break;
	}

	ht := getfuse(Me, &healme);
	if (ht) {
	    ht += 30*(tmp-1);
	    "You will be cured after <<ht>> turns.\n";
	}
	ht := Me.defendstr(nil);
	if (ht > 4) ht := 4;
	switch(ht) {
	case 0:
	    "You are at death's door.\n"; break;
	case 1:
	   "You can be killed by one more light wounds.\n"; break;
	case 2:
	   "You can be killed by a serious wound.\n"; break;
	case 3:
	   "You can survive one serious wound.\n"; break;
	case 4:
	   "You are strong enough to take several wounds.\n"; break;
	}
	if (global.numdeaths = 1)
	    "You have been killed once.\n";
	else if (global.numdeaths = 2)
	    "You have been killed twice.\n";
    }
;

/* Assuming here that the only fighters are the villains and the
 * player (ie, not the robot, gamemaster, etc */

/* This is inherited by Me and villain.  Most of the stuff would
 * be very similar, except that Player strength depends upon
 * the score, and villains don't (and have their own quirks).
 */

class fighter: object
    curweapon = nil
    pblose = 10
    staggered = nil
    strength = 0
    
    fightstr =
    {
	/* for player; strmax = 7, strmin = 2 */
	return( 2+ ((5*global.score+global.maxscore/2)/global.maxscore) );
    }
    defendstr(o) = ( fightstr + strength )
    attackstr(o) =
    {
	local tmp;
	tmp := self.defendstr(o);
	if (tmp < 1)
	    return( 1 );
	else
	    return( tmp );
    }

    /* Called to get result of attack (plus special checks) */
    doattack(att, def, v) =
    {
        if (v.unconscious) {
	    "The unconscious <<v.sdesc>> cannot defend himself:  he dies.\n";
	    v.hitme(10000);	/* killem */
	    return -1;		/* no action */
	} else
	    return( combat.getresult(att, def) );
    }

    /* Choose a weapon to fight with */
    pickweapon = {
	local list, cur;
	if (curweapon and curweapon.location = self)
	    return( curweapon );
	list := self.contents;
	while( cur := car(list) ) {
	    if (isclass(cur, weapon)) {
		curweapon := cur;
		return;
	    }
	    list := cdr(list);
	}
	curweapon := nil;
    }
    loseweapon =
    {
	local list, cur;
	curweapon.moveInto(self.location);
	curweapon := nil;
	list := self.contents;
	while( cur := car(list) ) {
	    if (isclass(cur, weapon)) {
		"Fortunately, you still have <<cur.adesc>>.\n";
		return;
	    }
	    list := cdr(list);
	}
    }

    stagger = { staggered := true; }
    unstagger =
    {
	"You are still recovering from that last blow, so your
	attack is ineffective.\n";
	staggered := nil;
    }
    
    outcold =
    {
	unconscious := true;
	self.outfor := 1 + rand(3);
    }
    wakeup = { unconscious := nil; }
    wakeup_hack =
    {
	/* We have this, because if the player is knocked out, villains
	 * get multiple swings.  This may be overkill now that you can
	 * do incturn with higher arguments in tads 2.2.
	 */
	if ( not unconscious )
	    return( nil );
	self.outfor--;
	if ( self.outfor = 0 )
	    self.wakeup;
	return( unconscious );
    }
    
    hitme( howmuch ) =
    {
	/* strength starts at 0 and goes negative */
	self.strength -= howmuch;
	if (self.defendstr(nil) <= 0) {
	    "It appears that the last blow was too much for you.  I'm afraid
	    that you are dead.\n";
	    self.unconscious := nil;
	    self.strength := 1 - self.fightstr;
	    Me.died;
	} else {
	    if (getfuse(self, &healme) = nil)
		notify(self, &healme, 30);
	}
    }

    healme =
    {
	if (strength < 0) {
	    strength++;
	    if (strength < 0)	/* heal some more */
		notify(self, &healme, 30);
	}
    }
    
    /* Messages for player only.  Passes along to weapon. */
    missMsg(d) = ( self.curweapon.missMsg(d) )
    outMsg(d) = ( self.curweapon.outMsg(d) )
    killMsg(d) = ( self.curweapon.killMsg(d) )
    lightMsg(d) = ( self.curweapon.lightMsg(d) )
    seriousMsg(d) = ( self.curweapon.seriousMsg(d) )
    staggerMsg(d) = ( self.curweapon.staggerMsg(d) )
    loseweapMsg(d,w) = ( self.curweapon.loseweapMsg(d,w) )
;

class villain: Actor, fighter
    isvillain = true
    wakeupprob = 0
    fighting = nil
    pblose = 50
    bestweap = nil

    verDoSqueeze( a ) = "\^<<self.thedesc>> does not understand this. "
    verDoJump( a ) = "\^<<self.thedesc>> is too big to jump over. "
    verDoShake( a ) = "This seems to have no effect. "
    verDoPlay( a ) =
    {
	"You are so engrossed in the role of <<self.thedesc>> that you kill
	yourself, just as he would have done! ";
	a.died;
    }
    
    verDoAttackWith( actor, io ) =
    {
	if (not isclass(io, weapon))
	    "Trying to attack <<self.adesc>> with <<io.adesc>> is very
	    self-destructive.\n";
    }
    doAttackWith( actor, weap ) =
    {
	actor.curweapon := weap;
	combat.blow(actor, self);
    }
    doSynonym('Attack') = 'Break'
    doSynonym('AttackWith') = 'BreakWith'
    
    attackstr(o) =
    {
	local tmp;
	tmp := self.strength;
	if (o.knockedout)
	    return( -tmp );
	
	/* Pain in the butt to isolate this engrossed stuff */
	if (self = thief and self.engrossed) {
	    engrossed := nil;
	    if (tmp > 2)
		tmp := 2;
	}

	if (o.curweapon) {
	    tmp--;
	    if (tmp < 1)
		tmp := 1;
	}
	return tmp;
    }
    defendstr(o) =
    {
	local ret;
	ret := self.attackstr(o);
	if (ret = 0)
	    "Attacking <<self.thedesc>> is pointless.\n";
	return( ret );
    }

    doattack(att, def, h) =
    {
	local res;
	res := combat.getresult(att, def);
	if (h.unconscious) {
	    if (res = 5) {	/* if hero staggered */
		self.hesoutMsg( h );
	    } else {
		self.sittingduckMsg( h );
		h.hitme(10000);	/* killem */
	    }
	    return -1;
	} else
	    return( res );
    }
    
    loseweapon =
    {
	curweapon.moveInto(self.location);
	curweapon := nil;
    }

    outcold = { unconscious := true; }
    wakeup = { unconscious := nil; }
    unstagger =
    {
	"\^<<self.thedesc>> slowly regains his feet.\n";
	staggered := nil;
    }
    
    hitme( howmuch ) =
    {
	/* strength in villains starts positive, dies when = 0 */
	self.strength -= howmuch;
	if (strength <= 0)
	    self.died;
    }
    died =
    {
	"Almost as soon as <<self.thedesc>> breathes his last, a cloud of
	sinister black smoke envelops him, and when the fog lifts, the
	carcass has disappeared.\n";
	self.moveInto(nil);
	unnotify(self, &heartbeat);
    }

    checkfight = nil		/* do we want to start fighting or not */
    checkweapon = true		/* try to recover weapon if disarmed */
    
    /* called each turn */
    heartbeat =
    {
	if (Me.isdead)
	    return;
	if (Me.location = self.location) { /* player's here */
	    if (self = thief and self.engrossed)
		return;		/* oblivious */

	    if (unconscious) {	/* see if we wake up */
		if ( prob(wakeupprob, wakeupprob) ) {
		    wakeupprob := 0;
		    self.wakeup;
		} else {
		    wakeupprob += 10; /* more chance to wake up */
		}
		return;  /* no fighting */
	    } else if (not fighting) { /* see if we get aggressive */
		if (self.checkfight)
		    fighting := true;
	    }
	} else {		/* player's not around */
	    if (fighting) {
		self.checkweapon;
		if (self = thief) self.engrossed := nil;
		Me.staggered := nil;
		self.staggered := nil;
		self.fighting := nil;
		if (unconscious)
		    self.wakeup;
	    }
	}

	/* now, if we're in the fighting mood, let em have it */
	if (fighting) {
	    do {
	        if ( self.checkweapon )
		    combat.blow(self, Me);
	    } while ( Me.wakeup_hack );
	}

	/* abort if Me.staggered or Me.unconscious? */
    }
;


combat: object
    blow(attacker, defender) =
    {
	local att, def, dweap;

	"\n";
	if (attacker.staggered) {
	    attacker.unstagger;
	    return;
	}
	if (attacker = defender and attacker = Me) {
	    "Well, you really did it that time.  Is suicide painless?\n";
	    Me.died;
	}
	defender.fighting := true;
	att := attacker.attackstr(defender);
	def := defender.defendstr(attacker);
	dweap := defender.pickweapon;

	if (def = 0)		/* needed? */
	    return;
	switch(attacker.doattack(att, def, defender)) {
	case 0:			/* miss */
	    attacker.missMsg( defender );
	    break;
	case 1:			/* unconscious */
	    attacker.outMsg( defender );
	    defender.outcold;
	    break;
	case 2:			/* kill */
	    attacker.killMsg( defender );
	    defender.hitme(10000);
	    break;
	case 3:			/* light wound */
	    attacker.lightMsg( defender );
	    defender.hitme(1);
	    break;
	case 4:			/* serious wound */
	    attacker.seriousMsg( defender );
	    defender.hitme(2);
	    break;
	case 5:			/* stagger or lose weapon */
	    if (dweap and prob(25, defender.pblose)) {
		attacker.loseweapMsg( defender, dweap );
		defender.loseweapon;
	    } else {
		attacker.staggerMsg( defender );
		defender.stagger;
	    }
	    break;
        /* default: do nothing */
	}
    }

    /* tables */
    def1r = [1, 2, 3]
    def2r = [13, 23, 24, 25]
    def3r = [35, 36, 46, 47, 57]

    /* 0 - miss
     * 1 - out
     * 2 - kill
     * 3 - light
     * 4 - serious
     * 5 - stagger
     * also, can have:
     * 6 - he's out (don't do much)
     * 7 - sitting duck
     */
    rvectr = [0,0,0,0,5,5,1,1,2,2,2,2, /* 1..12 */
	      0,0,0,0,0,5,5,3,3,1,     /* 13..22 */
	      0,0,0,5,5,3,3,3,1,2,2,2, /* 23..34 */
	      0,0,0,0,0,5,5,3,3,4,4,   /* 35..45 */
	      0,0,0,5,5,3,3,3,4,4,4,   /* 46..56 */
	      0,5,5,3,3,3,3,4,4,4 ]    /* 57..66 */

    getresult(att, def) =
    {
	local tbl;
	if (def <= 0) {		/* do nothing */
	    return -1;
	} else if (def < 2) {
	    if (att > 3) att := 3; /* scale */
	    tbl := def1r[att];  /* get offset */
	} else if (def = 2) {
	    if (att > 4) att := 4; /* scale */
	    tbl := def2r[att]; /* get offset */
	} else  {
	    att := att - def;
	    if (att < -2) att := -2; /* scale from -2..+2 */
	    if (att > 2) att := 2;
	    tbl := def3r[att+3];
	}
	return ( rvectr[tbl+rand(10)-1] );
    }
;

/* These get mixed into the various weapon/villain objects later */

/* Is there any possible way to do these using an array that we index into? */

class weapon_messages: object	/* generic messages for axe/stiletto */
    missMsg(o) = "You missed <<o.thedesc>>.\n"
    outMsg(o) = "Your knock <<o.thedesc>> out cold.\n"
    killMsg(o) = "You give <<o.thedesc>> a killing blow.\n"
    lightMsg(o) = "You nick <<o.thedesc>>.\n"
    seriousMsg(o) = "You hit <<o.thedesc>>.\n"
    staggerMsg(o) = "\^<<o.thedesc>> staggers back.\n"
    loseweapMsg(o,w) =
	"You deftly disarm <<o.thedesc>>, sending his weapon flying.\n"
;

class sword_messages: object
    missMsg(o) =
    {
	switch(rand(5)) {
	case 1: "Your swing misses <<o.thedesc>> by an inch.\n"; break;
	case 2: "A mightly blow, but it misses <<o.thedesc>> by a mile.\n";
		break;
	case 3: "You charge, but <<o.thedesc>> jumps nimbly aside.\n"; break;
	case 4: "Clang!  Crash!  \^<<o.thedesc>> parries.\n"; break;
	case 5: "A good stroke, but it's too slow, <<o.thedesc>> dodges.\n";
		break;
	}
    }
    outMsg(o) =
    {
	switch(rand(3)) {
	case 1: "Your sword crashes down, knocking <<o.thedesc>> into
		dreamland.\n"; break;
	case 2: "\^<<o.thedesc>> is battered into unconsciousness.\n"; break;
	case 3: "A furious exchange, and <<o.thedesc>> is knocked out.\n";
		break;
	}
    }
    killMsg(o) =
    {
	switch(rand(3)) {
	case 1: "It's curtains for <<o.thedesc>> as your sword removes his
		head.\n"; break;
	case 2: "The fatal blow strikes <<o.thedesc>> square in the heart:
		he dies.\n"; break;
	case 3: "\^<<o.thedesc>> takes a final blow and slumps to the floor
		dead.\n"; break;
	}
    }
    lightMsg(o) =
    {
	switch(rand(4)) {
	case 1: "\^<<o.thedesc>> is struck on the arm, blood begins to
		trickle down.\n"; break;
	case 2: "Your sword pinks <<o.thedesc>> on the wrist, but it's not
		serious.\n"; break;
	case 3: "Your stroke lands, but it was only the flat of the blade.\n";
		break;
	case 4: "The blow lands, making a shallow gash in <<o.thedesc>>'s
		arm.\n"; break;
	}
    }
    seriousMsg(o) =
    {
	switch(rand(3)) {
	case 1: "\^<<o.thedesc>> receives a deep gash in his side.\n"; break;
	case 2: " A savage blow on the thigh!
		\^<<o.thedesc>> is stunned but can still fight.\n"; break;
	case 3: "Slash!  Your blow lands!  That one hit an artery,
		it could be serious!\n"; break;
	}
    }
    staggerMsg(o) =
    {
	switch(rand(3)) {
	case 1: "\^<<o.thedesc>> is staggered and drops to his knees.\n";
		break;
	case 2: "\^<<o.thedesc>> is momentarily disoriented and can't fight
		back.\n"; break;
	case 3: "The force of your blow knocks <<o.thedesc>> back, stunned.\n";
		break;
        }
    }
    loseweapMsg(o,w) =
	"\^<<o.thedesc>>'s weapon is knocked to the floor,
	leaving him unarmed.\n"
;

	
class knife_messages: object
    missMsg(o) =
    {
	switch(rand(5)) {
	case 1: "Your stab misses <<o.thedesc>> by an inch.\n"; break;
	case 2: "A good slash, but it misses <<o.thedesc>> by a mile.\n"; break;
	case 3: "You charge, but <<o.thedesc>> jumps nimbly aside.\n"; break;
	case 4: "A quick stroke, but <<o.thedesc>> is on guard.\n"; break;
	case 5: "A good stroke, but it's too slow, <<o.thedesc>> dodges.\n";
		break;
        }
    }
    outMsg(o) =
    {
	switch(rand(3)) {
	case 1: "The haft of your blade knocks out <<o.thedesc>>.\n"; break;
	case 2: "\^<<o.thedesc>> drops to his knees, unconscious.\n"; break;
	case 3: "\^<<o.thedesc>> is knocked out!\n"; break;
        }
    }
    killMsg(o) =
    {
	switch(rand(3)) {
	case 1: "It's the end for <<o.thedesc>> as your knife severs his
		jugular.\n"; break;
	case 2: "The fatal thrust strikes <<o.thedesc>> square in the heart:
		he dies.\n"; break;
	case 3: "\^<<o.thedesc>> takes a final blow and slumps to the
		floor dead.\n"; break;
        }
    }
    lightMsg(o) =
    {
	switch(rand(4)) {
	case 1: "\^<<o.thedesc>> is slashed on the arm, blood begins to
		trickle down.\n"; break;
	case 2: "Your knife point pinks <<o.thedesc>> on the wrist,
		but it's not serious.\n"; break;
	case 3: "Your stroke lands, but it was only the flat of the blade.\n";
		break;
	case 4: "The blow lands, making a shallow gash in
		<<o.thedesc>>'s arm.\n"; break;
        }
    }
    seriousMsg(o) =
    {
	switch(rand(3)) {
	case 1: "\^<<o.thedesc>> receives a deep gash in his side.\n"; break;
	case 2: "A savage cut on the leg stuns <<o.thedesc>>,
		but he can still fight.\n"; break;
	case 3: "Slash!  Your stroke connects!
		\^<<o.thedesc>> could be in serious trouble!\n"; break;
        }
    }
    staggerMsg(o) =
    {
	switch(rand(3)) {
	case 1: "\^<<o.thedesc>> drops to his knees, staggered.\n"; break;
	case 2: "\^<<o.thedesc>> is confused and can't fight back.\n"; break;
	case 3: "The quickness of your thrust knocks <<o.thedesc>> back,
		stunned.\n"; break;
        }
    }
    loseweapMsg(o,w) =
	"\^<<o.thedesc>> is disarmed by a subtle feint past his guard.\n"
;

class cyclops_messages: object
    missMsg(o) =
    {
	switch(rand(4)) {
	case 1: "The cyclops misses, but the backwash almost knocks
		you over.\n"; break;
	case 2: "The cyclops rushes you but runs into the wall.\n"; break;
	case 3: "The cyclops trips over his feet trying to get at you.\n";
	        break;
	case 4: "The cyclops unleashes a roundhouse punch, but you have
		time to dodge.\n"; break;
        }
    }
    outMsg(o) =
    {
	if (rand(2) = 1)
	    "The cyclops knocks you unconscious.\n";
	else
	    "The cyclops sends you crashing to the floor, unconscious.\n";
    }
    killMsg(o) =
    {
	switch(rand(4)) {
	case 1: "The cyclops raises his arms and crushes your skull.\n"; break;
	case 2: "The cyclops has just essentially ripped you to shreds.\n";
		break;
	case 3: "The cyclops decks you.  In fact, you are dead.\n"; break;
	case 4: "The cyclops breaks your neck with a massive smash.\n"; break;
        }
    }
    lightMsg(o) =
    {
	switch(rand(4)) {
	case 1: "A quick punch, but it was only a glancing blow.\n"; break;
	case 2: "The cyclops grabs but you twist free, leaving part of
		your cloak.\n"; break;
	case 3: "A glancing blow from the cyclops' fist.\n"; break;
	case 4: "The cyclops chops at you with the side of his hand and
		connects, but not solidly.\n"; break;
        }
    }
    seriousMsg(o) =
    {
	switch(rand(5)) {
	case 1: "The cyclops gets a good grip and breaks your arm.\n"; break;
	case 2: "The cyclops knocks the wind out of you with a quick punch.\n";
		break;
	case 3: "The monster smashes his huge fist into your chest, breaking
		several ribs.\n"; break;
	case 4: "A flying drop kick breaks your jaw.\n"; break;
	case 5: "The cyclops breaks your leg with a staggering blow.\n"; break;
        }
    }
    staggerMsg(o) =
    {
	switch(rand(4)) {
	case 1: "The cyclops knocks you silly, and you reel back.\n"; break;
	case 2: "The cyclops grabs you and almost strangles you before you
		wiggle free, breathless.\n"; break;
	case 3: "Heedless of your weapons, the cyclops tosses you against the
		rock wall of the room.\n"; break;
	case 4: "The cyclops lands a punch that knocks the wind out of you.\n";
		break;
        }
    }
    loseweapMsg(o,w) =
    {
	switch(rand(4)) {
	case 1: "The cyclops grabs you by the arm, and you drop your
		<<w.sdesc>>.\n"; break;
	case 2: "The cyclops kicks your <<w.sdesc>> out of your hand.\n";
		break;
	case 3: "The monster grabs you on the wrist, squeezes, and you drop
		your <<w.sdesc>> in pain.\n"; break;
	case 4: "The cyclops grabs your <<w.sdesc>>, tastes it, and throws
		it to the ground in disgust.\n"; break;
        }
    }
    hesoutMsg(o) =
    {
	switch(rand(3)) {
	case 1: "The cyclops is so excited by his success that he neglects to
		kill you.\n"; break;
	case 2: "The cyclops, momentarily overcome by remorse, holds back.\n";
		break;
	case 3: "The cyclops seems unable to decide whether to broil or stew
		his dinner.\n"; break;
        }
    }
    sittingduckMsg(o) =
	"The cyclops, no sportsman, dispatches his unconscious victim.\n"
;

class troll_messages: object
    missMsg(o) =
    {
	switch(rand(4)) {
	case 1: "The troll swings his axe, but it misses.\n"; break;
	case 2: "The troll's axe barely misses your ear.\n"; break;
	case 3: "The axe sweeps past you as you jump aside.\n"; break;
	case 4: "The axe crashes against the rock, throwing sparks.\n"; break;
        }
    }
    outMsg(o) =
	"The flat of the troll's axe hits you delicately on the head,
	knocking you out.\n"
    killMsg(o) =
    {
	switch(rand(4)) {
	case 1: "The troll lands a killing blow.  You are dead.\n"; break;
	case 2: "The troll neatly removes your head.\n"; break;
	case 3: "The troll's axe stroke cleaves you from the nave to the
		chops.\n"; break;
	case 4: "The troll's axe bashes in your skull.\n"; break;
        }
    }
    lightMsg(o) =
    {
	switch(rand(4)) {
	case 1: "The axe gets you right in the side.  Ouch!\n"; break;
	case 2: "The flat of the troll's axe skins across your forearm.\n";
		break;
	case 3: "The troll's swing almost knocks you over as you barely parry
		in time.\n"; break;
	case 4: "The troll swings his axe, and it nicks your arm as you
		dodge.\n"; break;
        }
    }
    seriousMsg(o) =
    {
	switch(rand(4)) {
	case 1: "The troll charges, and his axe slashes you on your
		<<o.sdesc>> arm.\n"; break;
	case 2: "The troll's axe swings down, gashing your shoulder.\n"; break;
	case 3: "An axe stroke makes a deep wound in your leg.\n"; break;
	case 4: "The troll sees a hole in your defense, and a lightning
		stroke opens a wound in your left side.\n"; break;
        }
    }
    staggerMsg(o) =
    {
	switch(rand(4)) {
	case 1: "The troll hits you with a glancing blow, and you are
		momentarily stunned.\n"; break;
	case 2: "The troll swings;  the blade turns on your armor but crashes
		broadside into your head.\n"; break;
	case 3: "You stagger back under a hail of axe strokes.\n"; break;
	case 4: "The troll's mighty blow drops you to your knees.\n"; break;
        }
    }
    loseweapMsg(o,w) =
    {
	switch(rand(4)) {
	case 1: "The axe hits your <<w.sdesc>> and sends it spinning.\n";
		break;
	case 2: "The troll swings.  You parry, but the force of his blow
		disarms you.\n"; break;
	case 3: "The axe knocks your <<w.sdesc>> out of your hand.
		It falls to the floor.\n"; break;
	case 4: "The <<w.sdesc>> is knocked from your hand,
		but you parry the blow.\n"; break;
        }
    }
    hesoutMsg(o) =
    {
	switch(rand(4)) {
	case 1: "The troll strikes at your unconscious form but misses
		in his rage.\n"; break;
	case 2: "The troll hesitates, fingering his axe.\n"; break;
	case 3: "The troll scratches his head ruminatively.
		Might you be magically protected, he wonders?\n"; break;
	case 4: "The troll seems afraid to approach your crumpled form.\n";
		break;
        }
    }
    sittingduckMsg(o) = "Conquering his fears, the troll puts you to death.\n"
;

class thief_messages: object
    missMsg(o) =
    {
	switch(rand(4)) {
	case 1: "The thief stabs nonchalantly with his stiletto and
		misses.\n"; break;
	case 2: "You dodge as the thief comes in low.\n"; break;
	case 3: "You parry a lightning thrust, and the thief salutes you with
		a grim nod.\n"; break;
	case 4: "The thief tries to sneak past your guard, but you
		twist away.\n"; break;
        }
    }
    outMsg(o) =
    {
	if (rand(2) = 1)
	    "Shifting in the midst of a thrust, the thief knocks you
	    unconscious with the haft of his stiletto.\n";
	else
	    "The thief knocks you out.\n";
    }
    killMsg(o) =
    {
	switch(rand(4)) {
	case 1: "Finishing you off, a lightning throw right to the heart.\n";
		break;
	case 2: "The stiletto severs your jugular.  It looks like the end.\n";
		break;
	case 3: "The thief comes in from the side, feints, and slips the blade
		between your ribs.\n"; break;
	case 4: "The thief bows formally, raises his stiletto, and with a wry
		grin ends the battle and your life.\n"; break;
        }
    }
    lightMsg(o) =
    {
	switch(rand(4)) {
	case 1: "A quick thrust pinks your left arm, and blood starts to
		trickle down.\n"; break;
	case 2: "Raking his stiletto across your arm, the thief draws
		blood.\n"; break;
	case 3: "The stiletto flashes faster than you can follow, and blood
		wells from your leg.\n"; break;
	case 4: "The thief slowly approaches, strikes like a snake, and leaves
		you wounded.\n"; break;
        }
    }
    seriousMsg(o) =
    {
	switch(rand(4)) {
	case 1: "The thief strikes like a snake!  The resulting wound is
		serious.\n"; break;
	case 2: "The thief stabs a deep cut in your upper arm.\n"; break;
	case 3: "The stiletto touches your forehead, and the welling blood
		obscures your vision.\n"; break;
	case 4: "The thief strikes at your wrist, and suddenly your grip is
		slippery with blood.\n"; break;
        }
    }
    staggerMsg(o) =
    {
	switch(rand(4)) {
	case 1: "The butt of his stiletto cracks you on the skull, and you
		stagger back.\n"; break;
	case 2: "You are forced back and trip over your own feet, falling
		heavily to the floor.\n"; break;
	case 3: "The thief rams the haft of his blade into your stomach,
		leaving you out of breath.\n"; break;
	case 4: "The thief attacks, and you fall back desperately.\n"; break;
        }
    }
    loseweapMsg(o,w) =
    {
	switch(rand(4)) {
	case 1: "A long theatrical slash.  You parry it desperately, but the
		thief twists his knife, and your <<w.sdesc>> goes flying.\n";
		break;
	case 2: "The thief neatly flips your <<w.sdesc>> out of your hands,
		and it drops to the floor.\n"; break;
	case 3: "You parry a low thrust, and your <<w.sdesc>> slips out of
		your hand.\n"; break;
	case 4: "Avoiding the thief's stiletto, you stumble to the floor,
		dropping your <<w.sdesc>>.\n"; break;
        }
    }
    hesoutMsg(o) =
    {
	switch(rand(3)) {
	case 1: "The thief, a man of good breeding, refrains from attacking a
		helpless opponent.\n"; break;
	case 2: "The thief amuses himself by searching your pockets.\n"; break;
	case 3: "The thief entertains himself by rifling your pack.\n"; break;
        }
    }
    sittingduckMsg(o) =
    {
	switch(rand(3)) {
	case 1: "The thief, noticing you beginning to stir, reluctantly
		finishes you off.\n"; break;
	case 2: "The thief, forgetting his essentially genteel upbringing,
		cuts your throat.\n"; break;
	case 3: "The thief, who is essentially a pragmatist, dispatches you
		as a threat to his livelihood.\n"; break;
        }
    }
;
