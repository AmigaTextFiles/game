/* $Id: demon.t 1.9 96/04/16 21:56:30 mol Exp $
 **********************************************************************
 *
 * Uncle Zebulon's Will, version 2.0
 *
 * An adventure game, written in TADS 2.2.
 *
 * demon.t - The demon and his possessions
 *
 **********************************************************************
 * 
 * Copyright (c) 1995-96 by Magnus Olsson (mol@df.lth.se).
 * All rights reserved.
 *
 * This source code may be copied and distributed freely as long as the 
 * following conditions are met:
 *   - no fee may be charged for the code (a nominal fee may be charged
 *     to cover distribution costs)
 *   - the code is not modified in any way
 *   - this copyright notice is not removed or modified in any way
 *
 * You may use individual parts of this code in your programs
 * as long as they are attributed to the author. You are not allowed
 * to use the plot, story, characters or text of the game without the
 * written permission of the author.
 *
 ***********************************************************************/

/*
 * The demon itself. Note that some of the demon's methods get called
 * when you try to leave the porch. so it acts as some kind of doorway
 * as well as an actor.
 */
demon : Actor
    noun = 'demon' 'daemon' 'imp' 'devil' 'spirit' 'genie' 'jinni' 'familiar'
    adjective = 'sneering' 'mean-looking' 'mean'

    sdesc = "demon"
    ldesc = "If you remember your Basic Demonology classes correctly,
	he must be a member of one of the lower castes of familiar demons,
	usually employed as servants by wizards. As demons go, this one 
	isn't very big or dangerous-looking. 
        Indeed, he looks positively benign (for a demon, that is: he still
	looks pretty mean by human standards). Of course, all this still
	doesn't mean that he's to be messed with. "

    isHim = true
    
    location = porch
    
    first_time = true
    has_letter = nil
    reading = nil
    
    actorDesc = {
        if (has_letter) 
	    "The demon is holding out a letter towards you. ";
	else if (reading) 
	    "The demon is reading a newspaper, occasionally keeping an
	    eye on the door. ";
	else
	    "The demon is picking his claws with a rather nasty-looking
	    dagger. ";
    }

    actorAction(v, d, p, i) = {
        if (v = tellVerb and p = aboutPrep)
	    self.doAskAbout(d, i);
	else 
	    self.answer;
	exit;
    }

    // This method makes the demon change activities: from reading the paper
    // to picking his claws, and vice versa.
    change_activity = {
        if (reading) {
	    reading := nil;
	    newspaper.moveInto(nil);
	    dagger.moveInto(demon);
	} 
	else {
	    reading := true;
	    newspaper.moveInto(demon);
	    dagger.moveInto(nil);
 	}
    }

    answer = {
	"The demon ";
	switch (rand(4)) {
	    case 1:
	        "starts humming a merry little demon song,
	        pretending not to hear you. ";
	        break;
	    case 2:
		if (reading) {
  		    "takes a very sudden interest in some article
		    in his newspaper and doesn't seem to hear you. ";
		}
		else {
		    "puts his dagger away (seemingly into thin air),
		    pulls out a newspaper (also out of thin air)
		    and opens it. \"Sorry, did you say something?\" ";
		    reading := true;
		    newspaper.moveInto(demon);
		    dagger.moveInto(nil);
		}
		break;
	    case 3:
		if (reading) {
		    "rolls up his newspaper into a ball which he throws
		    over his shoulder, where it disappears with a loud
		    pop, and instead pulls out a dagger out of thin air
		    and starts picking his claws. He gives no
		    sign of having heard you. ";
		    reading := nil;
		    newspaper.moveInto(nil);
		    dagger.moveInto(demon);
		}
		else {
		    "suddenly discovers a particularly nasty discolouring
		    in one of his claws, starts to cut it away with
		    his dagger, and doesn't seem to hear you. ";
		}
		break;
	    default:
  	        "quite pointedly ignores you, apparently preferring to 
 	        study some interesting spots on the floor. ";
        }	    
    }

    // Return a list of all the treasures in the argument list.
    pick_treasures(list) = {
        local treasures := [];
	local i;
	for (i := 1; i <= length(list); ++i) {
	    local obj = list[i];
	    
	    if (isclass(obj, treasure) and not obj.inheritance)
	        treasures += obj;
	}
	return treasures;
    }
	                    
    // This method is called when the player is trying to walk west
    // past the demon. It's rather complicated, since the demon
    // has to check not only what you're carrying, but if anything
    // is hidden inside what you're carrying.
    pass_w = {
        local treasures, len;
	
	// Find any treasures the player is carrying
	treasures := self.pick_treasures(Me.contents);
        len := length(treasures);
	
        if (has_letter) {
	    "The demon holds out the letter towards you. \"Don't
	    forget your letter!\" ";
	    return nil;
	}
	else if (Me.inheritance <> nil) {
	    local obj := Me.inheritance;
	    
 	    if (len > 0) {
	        "The demon bars your way with a scaly arm. \"You've 
	        already made your choice: your inheritance 
	        is << obj.thedesc >>, and you're not allowed
	        to take anything more from the house.\" ";
	        return nil;
	    } 
	    else if (obj.isIn(Me) and
		     length(self.pick_treasures(obj.contents))) {
	        "The demon looks hard at what you're carrying.
		\"Hey, there's something hidden inside 
		that << obj.sdesc >>! You're not trying to cheat, are you?\"
		With a scaly arm, he blocks your passage. 
		\"I'm only going to let you carry \(one\) thing through
		this door!\" ";
		return nil;
	    }
        }
	else if (len > 0) {
            local obj := car(treasures);
	    local hidden_treasures := self.pick_treasures(obj.contents);

	    if (len > 1) {
	        "The demon bars your way with a scaly arm. \"You're only 
	        allowed to take \(one\) thing from the house, and you're
	        carrying at least << sayPrefixCount(len) >>!\" ";
	        return nil;
	    } 
	    else if (length(hidden_treasures) > 0) {
	        "The demon looks hard at what you're carrying.
		\"Hey, there's something hidden inside 
		that << obj.sdesc >>! You're not trying to cheat, are you?\"
		With a scaly arm, he blocks your passage. 
		\"I'm only going to let you carry \(one\) thing through
		this door!\" ";
		return nil;
	    }
	    else {
	        "The demon gives you an amused look. \"So, you've made
		your choice, have you?\" Producing a clipboard out of
		thin air, he proceeds to tick off your name. \"Let's
		see... Richard:\ << obj.adesc >>. Well, I suppose that
		might prove useful some day. Or perhaps not. But who
		am I to question your choice?\" With an air of
		seriously doubting your judgement, he lets you pass.
		\"Have a nice day.\"\b";
		
		Me.inheritance := obj;
		obj.inheritance := true;
                return startroom;
  	    }
	}
	
        "The demon gives you a penetrating glance, but lets you pass
        without comment.\b";
        return startroom;
    }
    
    // Called when the player is going east past the demon.
    pass_e = {
        if (first_time) {
	    first_time := nil;
	    "As you walk past the demon (slightly apprehensively, of
	    course, you never know with demons), he nods at you.
	    \"Let's see, you must be Richard, right? My late
	    master hasn't treated you very generously in his 
	    will, has he?\" He quickly checks a list.\n\t 
	    \"Let's see. You're allowed
	    to take \(one\) thing - not more - from the house 
	    through this door. Of course, your relatives have pretty 
	    much scoured the place
	    for valuables, so I'm afraid there's not very much left for 
	    you.\" 
            For a moment, you imagine you can trace some
	    genuine pity in the demon's expression; however, it soon
	    returns to his usual sneer. \"Not that they found very
	    much of value, either. You should have seen their faces
	    when they realized the house wasn't filled with gold...\"\n
	    \tThe demon starts to wave you past, when he suddenly seems
	    to remember something. \"Ah, yes, this is for you,\" he 
	    says off-handedly, holding out a letter towards you. ";

	    letter.moveInto(demon);
	    setit(letter); // "It" should refer to the letter next turn
	    has_letter := true;
	    return nil; 
	}
	else if (has_letter) {
	    "The demon holds out the letter towards you. \"Don't
	    forget your letter!\" ";
	    setit(letter);
	    return nil;
	}
	else if (Me.inheritance = nil)
	    "The demon lets you past with a slightly amused sneer. ";
	else
	    "The demon shrugs and lets you past. ";
	"\b";
	return porch_door_w;
    }
    
    verGrab(item) = {
        if (item <> letter) 
	    pass verGrab;
    }
    Grab(item) = {
        if (item = letter)
	    has_letter := nil;
	pass Grab;
    }

    ioGiveTo(actor, dobj) = {
        "\"Thanks, but I'm not allowed to accept any gifts from you.\" ";
    }	

    doSynonym('Attack') = 'Kick'

    verDoAttack(actor) = {
        "You've got far too much sense of self-preservation to try to
	fight a demon. As demons go, this particular one may be a
	small and benign one; still, he could easily resist a small
	army of humans. ";
    }
    verDoAttackWith(actor, io) = {
        self.verDoAttack(actor);
    }
    
    verDoTake(actor) = {
        "The demon would surely object to that! ";
    }
    verDoEat(actor) = {
        "You crazy or something? ";
    }
    verDoAskAbout(actor, io) = {
    }
    doAskAbout(actor, io) = {
	switch (io) {
	    case uncle:
 	        "\"He wasn't too bad, really, at least not for a human.\" ";
		break;
	    case demon:
	        "\"Oh, don't mind me. Just pretend I'm the milkman or
		something.\" ";
		break;
	    case Me:
	        "The demon looks at you a bit quizzically and starts to
		say something, but changes his mind and just 
		shrugs instead. ";
		break;
	    case will:
	        "\"It's all very simple: you may take one thing, and one
		thing only, from the house. I suppose your uncle wanted
		you to keep some small memento of him.\" ";
		break;
	    case shed:
	    case shed_outside:
	        "\"It says nothing about the shed in the will, so I suppose
		it's OK for you to take anything you want from it. If 
		there's anything left, of course - your cousins carried
		away a lot of tools and things.\" ";
		break;
	    case letter:
	        if (has_letter) {
		    "\"Why don't you just read it?\" ";
		    break;
		}
		// else fall through
	    default:
                self.answer;
	}
    }
    
    verDoTellAbout(actor, io) = {
        "The demon stifles a yawn. ";
	switch (rand(4)) {
	    case 1:
	       "\"Really? How interesting.\" "; 
	       break;
	    case 2:
	       "\"Fascinating. You must tell me more about that some
	       other time.\" ";
	       break;
	    case 3:
	       "\"You don't say.\" ";
	       break;
	    default:
	       "\"I'm only the doorkeeper. Why don't you go talk to 
	       somebody more interesting?\" ";
	}
    }
    
    ioThrowAt(actor, dobj) = {
        "The demon deftly catches << dobj.thedesc >> and throws it
	back at you, hitting you smack in the middle of the forehead. ";
	dobj.moveInto(actor.location);
    }
    verIoThrowTo(actor) = {
        self.verIoThrowAt(actor);
    }
    ioThrowTo(actor, dobj) = {
        self.ioThrowAt(actor, dobj);
    }

    verIoPourOn(actor) = { 
    }
    ioPourOn(actor, dobj) = {
        "I don't think that would be very prudent - demons are
	quite dangerous when angry (and only slightly less
	so when not angry). ";
    }
    
    wand_effect = {
	" that strike the demon, exploding with little popping
	noises. \"Hey! Stop that! It tickles!\" ";
    }
;

/*
 * The will exists as an object, so you can ask the demon about it,
 * but it's not present anywhere.
 */
will : readable
    noun = 'will' 'testament'
    adjective = 'zebulon\'s' 'last'
;

/*
 * The demon's dagger and newspaper 
 */
dagger : decoration
    noun = 'dagger' 'knife' 
    adjective = 'nasty-looking' 'nasty' 'looking' 'demon\'s'
    sdesc = "the demon's dagger"
    adesc = { self.sdesc; }
    thedesc = { self.sdesc; }
    location = demon
;

newspaper : decoration
    noun = 'newspaper' 'paper' 'news'
    adjective = 'demon\'s'
    sdesc = "the demon's newspaper"
    adesc = { self.sdesc; }
    thedesc = { self.sdesc; }
    location = nil
;
