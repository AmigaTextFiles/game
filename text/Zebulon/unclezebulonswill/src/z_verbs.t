/* $Id: z_verbs.t 1.12 96/04/16 21:56:49 mol Exp $
 **********************************************************************
 *
 * Uncle Zebulon's Will, version 2.0
 *
 * An adventure game, written in TADS 2.2.
 *
 * z_verbs.t - New verb definitions, and related class modifications.
 *
 * (Note for the picky: some of the verbs defined here are never used
 * in the game. This is because this file was inherited from another
 * project)
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
 * Make 'inside' a synonym for 'in'
 */
modify inPrep
    preposition = 'inside'
;

/*
 * Make 'taste', 'nibble' and 'bite' synonyms for 'eat'
 */
modify eatVerb
    verb = 'taste' 'nibble' 'bite'
;

/*
 * Some old magic words, just for fun
 */
xyzzyVerb : deepverb
    verb = 'xyzzy' 'plugh' 'yoho'  'necken-sway'
    	   'abracadabra' 'hocus' 'pocus' 'shazam'
    // 'xyzzy', 'plugh' from ADVENT, 'necken-sway' from "John's Fire Witch"
    sdesc= "xyzzy"
    action(actor) = {
        "Are you sure you're playing the right game?";
    }
;

frotzVerb : deepverb
    verb = 'frotz'
    sdesc = "frotz"
    action(actor) = {
        xyzzyVerb.action(actor);
    }
    doAction = 'Frotz'
;

lagachVerb : deepverb
    verb = 'lagach'
    sdesc = "lagach"
    action(actor) = {
        xyzzyVerb.action(actor);
    }
    doAction = 'Frotz'
;
        
modify thing
    verDoFrotz(actor) = {
        xyzzyVerb.action(actor);
    }
;

/*
 * Some new system verbs
 */
helpVerb : sysverb
    verb = 'help' 'hint' 'hints'
    sdesc = "help"
    action(actor) = {
        info.helptext;
	abort;
    }
;

infoVerb : sysverb
    verb = 'info' 'credits'
    sdesc = "info"
    action(actor) = {
        info.infotext;
	abort;
    }
;

/*
 * And some new abbreviations
 */
modify takeVerb
    verb = 't'
;

modify quitVerb
    verb = 'q'
;

        
sneezeVerb : deepverb
    // Just for fun, at the suggestion of P. D. Doherty
    verb = 'sneeze'
    sdesc = "sneeze"
    action(actor) = {
        "Gesundheit! ";
    }
;
    
pourVerb : deepverb
    verb = 'pour' 'decant' 'spill'
    sdesc = "pour"
    doAction = 'Pour'
    ioAction(onPrep) = 'PourOn'
    ioAction(inPrep) = 'PutIn'
;

modify thing
    verIoPourOn(actor) = { }
    ioPourOn(actor, dobj) = {
        dobj.doPourOn(actor, self);
    }
;
    
emptyVerb : deepverb
    verb = 'empty' 'evacuate' 'drain'
    sdesc = "empty"
    doAction = 'Empty'
;

flipThruVerb : deepverb
    verb = 'leaf through' 'leaf thru' 'flip through' 'flip thru'
    sdesc = "flip through"
    doAction = 'FlipThru'
;
    
modify throwVerb 
    doAction = 'Throw'
    ioAction(thruPrep) = 'ThrowThru'
    ioAction(inPrep) = 'PutIn'
    rejectMultiDobj(prep) = {
        "You can only throw one thing at a time. ";
        return true;
    }
;


/*
 * Disallow throwing things off the porch
 */
modify thing
    verDoThrow(actor) = {
        if (actor.isCarrying(self) and actor.location = porch)
            "As %you% prepare%s% to throw it, the demon stops %you%. 
  	    \"Please don't throw things around -
	    something might break.\" ";
	else 
	    pass verDoThrow;
    }
    doThrow(actor) = {
        "\^<< self.thedesc >> follows a parabolic arc, landing a 
	short distance away. ";
        self.moveInto(actor.location);
    }
    
    verDoThrowTo(actor, io) = {
        self.verDoThrowAt(actor, io);
    }
    verDoThrowThru(actor, io) = {
        self.verDoThrowAt(actor, io);
    }
    verDoThrowAt(actor, io) = {
        if (not (actor.isCarrying(self) and actor.location = porch
		 and io = demon))
  	    self.verDoThrow(actor);
    }
;

modify fixeditem 
    verDoThrow(actor) = {
        "%You% can't throw << self.thedesc >>. ";
    }
;

class breakable : item
    verDoThrow(actor) = {
        "\^<< self.thedesc >> is too fragile to throw. ";
    }
    verDoThrowAt(actor, io) = {
        self.verDoThrow(actor);
    }
;

/*
 * Allow "attack demon" without any indirect object - silly to ask for
 * one when no weapon is sufficient anyway.
 */
modify attackVerb 
    doAction = 'Attack'
;

modify thing 
    verDoAttack(actor) = {
        "Attacking "; self.thedesc; " doesn't appear productive. ";
    }
;

acceptVerb : deepverb
    verb = 'accept'
    sdesc = "accept"
    doAction = 'Take'
    ioAction(fromPrep) = 'TakeOut'
;
    
fillVerb : deepverb
    verb = 'fill'
    sdesc = "fill"
    doAction = 'Fill'
;

modify container
    verDoFill(actor) = {
        "%You% must tell me what %you% want to put in << self.thedesc >>. ";
    }
;

kickVerb : deepverb
    verb = 'kick' 
    sdesc = "kick"
    doAction = 'Kick'
;

modify thing
    verDoKick(actor) =
    {
        "Attacking "; self.thedesc; " doesn't appear productive. ";
    }
;    
    
    
untwistVerb : deepverb
    verb = 'untwist' 'untangle'
    sdesc = "untwist"
    doAction = 'Untwist'
;

insertVerb : deepverb
    verb = 'insert'
    sdesc = "insert"
    prepDefault = inPrep
    ioAction(inPrep) = 'PutIn'
    doDefault(actor, prep, io) = {
        return(takeVerb.doDefault( actor, prep, io ) + actor.contents);
    }
    rejectMultiDobj(prep) = {
        "You can't use multiple direct objects with the verb 'insert' "; 
        return true;
    }
;

modify putVerb
    rejectMultiDobj(prep) = {
        if (prep <> inPrep)
	    return nil;
	   
        "You can only do that to one thing at a time. ";
        return true;
    }
;
    
modify lookInVerb
    verb = 'look inside' 'l inside' 'gaze into' 
;

modify plugVerb 
    verb = 'plug in'
;

modify wearVerb
    verb = 'don'
;

modify removeVerb
    verb = 'doff'
;

undressVerb : deepverb
    verb = 'undress' 'strip'
    sdesc = "undress"
    action(actor) = {
        "There's no reason why you should undress in this game. ";
    }
    doAction = 'Undress'
;

dressVerb : deepverb
    verb = 'dress'
    sdesc = "dress"
    action(actor) = {
        "%You% will have to tell me what %you% want to wear. ";
    }
    doAction = 'Dress'
;

unwrapVerb : deepverb
    verb = 'unwrap' 'unwind'
    sdesc = "unwrap"
    doAction = 'Unwrap'
;


modify attachVerb 
    verb = 'join'
    doAction = 'Attach'
;

modify detachVerb
    verb = 'separate'
;
    
modify breakVerb
    verb =  'smash'
;


modify lookInVerb
    verb = 'look into' 'l into'
;

modify inspectVerb
    rejectMultiDobj(prep) = {
        "You can only look at one thing at a time. ";
        return true;
    }
;

modify turnVerb
    rejectMultiDobj(prep) = {
        "You can only turn one thing at a time. ";
        return true;
    }
;

modify openVerb
    rejectMultiDobj(prep) = {
        "You can only << self.sdesc >> one thing at a time. ";
        return true;
    }
;

modify searchVerb
    rejectMultiDobj(prep) = {
        "You can only << self.sdesc >> one thing at a time. ";
        return true;
    }
;

modify removeVerb
    doDefault(actor, prep, io) = {
    	if (objwords(1) = ['A']) {
            global.allMessage := 'You can\'t use "all" with this verb.';
	    return [];
	}
	pass doDefault;
    }
;


replace parseError : function(str, num)
{
    if (global.allMessage <> nil) {
        local r;
	
	r := global.allMessage;
	global.allMessage := nil;
	return r;
    }
    else
        return nil;
}

knockOnVerb : deepverb
    verb = 'knock on' 'knock at'
    sdesc = "knock on"
    doAction = 'KnockOn'
;

modify thing
    verDoKnockOn(actor) = { 
    }
    doKnockOn(actor) = {
        "Nothing happens. ";
    }
;

modify movableActor
    verDoKnockOn(actor) = {
        "I don't think << self.thedesc >> would appreciate that. ";
    }
;

