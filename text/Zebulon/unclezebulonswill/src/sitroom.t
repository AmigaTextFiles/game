/* $Id: sitroom.t 1.10 96/04/16 21:56:46 mol Exp $
 **********************************************************************
 *
 * Uncle Zebulon's Will, version 2.0
 *
 * An adventure game, written in TADS 2.2.
 *
 * sitroom.t - The Sitting Room and related objects and puzzles
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
 
sitting_room : indoors
    noun = 'sitting-room'
    sdesc = "Sitting room"
    ldesc = "After your relatives have gone over it, uncle Zebulon's 
	sitting room looks curiously empty. Most of the furniture has 
	been removed. Of all the things that used to give the room 
	its atmosphere, just a few, obviously not very valuable ones, 
	remain: the old armchair where you used to sit and watch uncle 
	Zebulon entertain you with his magic (or \"conjuring tricks\", 
	as your down-to-earth parents preferred to call it), your uncle's pipe rack, 
	the large mirror on the north wall. "
    west = hall
    north = mirror
    in = {
 	askdo;
    }
;

pipe_rack : decoration
    noun = 'rack' 'pipe'
    adjective = 'uncle\'s' 'pipe'
    sdesc = "pipe rack"
    ldesc = "It's empty. Apparently, there's a keen smoker among
        your relatives. "
    location = sitting_room
;

/*
 * Modify inVerb so "walk through mirror" means the same as
 * "enter mirror". This will have the side effect of allowing,
 * say, "walk through porch", but we can live with that.
 */
modify inVerb
    verb = 'walk through' 'go through' 'go into'
;

mirror : fixeditem, obstacle
    noun = 'mirror' 'glass' 'frame' 
    adjective = 'large' 'looking'
    sdesc = "mirror"
    ldesc = {
        if (isopen) {
	    "The glass has disappeared from the mirror, leaving just
	    an empty frame. Well, not quite empty, there's something
	    like the wall of a soap bubble, or a water surface, only
	    infinitely thinner - perhaps the interface between two
	    universes? ";
	    if (not moor_gnittis.isseen)
	        "Anyway, it would be possible for you to fulfil your 
		old dream of walking through the mirror now... ";
	}
	else
	    "You're a bit surprised that your relatives left this 
            mirror behind, since it's probably quite valuable, or at least
   	    old. Perhaps its size has something to do with it: it's almost
	    a metre wide and taller than you are. When you were a kid you
	    used to fantasize about this being a magic mirror, and you
	    imagined that when looking into it you could see into another
	    world. ";
    }	    

    isopen = nil

    no_all(verb, prep, io) = {
        return (verb = inVerb and not isopen);
    }
    
    destination = {
        if (isopen) {
	    "Feeling like Alice in Wonderland, you step through the
	    empty mirror frame. A curious wrenching sensation passes
	    through your body, as if you've been disassembled into atoms
	    and then rapidly put together again. ";
	    "\b";
	    return moor_gnittis;
	}
	else
            return sitting_room.noexit;
    }
    
    verDoEnter(actor) = { }
    doEnter(actor) = {
        if (isopen)
	    actor.travelTo(self.destination);
	else    
            "Alas, it's only in fairy tales that one can walk through 
   	    mirrors. ";
    }

    wand_effect = {
        if (not isopen) {
	    ". Amazingly, the stars seem to pass straight through the 
	    mirror. They strike your mirror image, which is standing 
	    there with a wand in its hand, looking at you with a slightly
	    silly expression. With a strange, tearing sound, your
	    mirror image wavers and disappears.\n\t
	    Shocked, you look again. Sure, you can see the mirror image
	    of the room, and everything in it, but not your own image.
	    You take a quick look down at yourself, just to check -
	    yes, you're still visible. Running up to 
	    check the mirror, you realize that the glass is gone; the 
	    empty frame forms a portal into a room behind, where no
	    room ought to be. ";

	    incscore(10);
 	    isopen := true;
	    addword(self, &noun, 'portal');
	    addword(self, &noun, 'hole');
	}
	else 
	    ", which pass through the empty frame into the room
	    beyond, exploding with little popping noises. ";
    }

    verDoLookin(actor) = { }
    doLookin(actor) = {
        if (isopen)
	    "You see a room on the other side of the mirror, a 
	    room that seems exactly like the one you're standing 
	    in - but with north and south reversed. ";
	else
            "The glass is old and slightly flawed, so the image isn't as
   	    crisp as you'd expect from a newer mirror. Your reflection looks
	    like you, yet somehow like a different person, more cynical,
	    with a slightly cunning look. The old glass makes it hard
	    to make out all the detail, but the reflection of the room behind
	    you looks slightly different, too. ";
    }
    verDoLookthru(actor) = { 
        self.verDoLookin(actor);
    }
    doLookthru(actor) = { 
        self.doLookin(actor);
    }
    verDoLookbehind(actor) = {
        "You can't look behind the mirror; 
	it's fastened flush to the wall. ";
    }
    verDoTake(actor) = {
        "The mirror is securely fastened to the wall. ";
    }
    location = sitting_room
;

/*
 * The armchair is a seachHider, since a wand is hidden inside it,
 * but with the extra twist that you can find the wand by sitting on
 * it as well.
 */
armchair : chairitem, searchHider
    noun = 'armchair' 'arm chair' 'chair' 'furniture'
    adjective = 'old' 'large' 'comfy' 'comfortable' 'battered' 'fave'
    sdesc = "armchair" 
    ldesc = {
        "It may not be a great looker, but this battered old armchair
        has always been your fave piece of furniture. On stormy autumn
	nights you'd relax in its comfy depths, cosy in front of the 
	roaring fire, while your uncle would tell you the most hair-raising
	ghost stories or entertain you with some magic tricks (which you
	steadfastly insisted were real magic, even though your parents 
	tried hard to convince you they were just sleight of hand). ";
	
	if (not self.visited) {
	    "\n\tEven today, a decade later, you feel an almost irresistible 
	    urge to sit in that armchair once more, just to recall the 
	    feeling of those long-gone days. ";
	}
    }
    
    autoTake = nil
    location = sitting_room
    visited = nil // true if player has sat on it.
    
    searchObj(actor, list) = {
        local found := list;
	
	list := nil;
        if (length(found) > 0) {
	    local obj := car(found);
	    
	    "You find << obj.adesc >> hidden deep inside the armchair. ";
	    obj.found := true;
	    obj.moveInto(self);
	    setit(obj);
	}
	return nil;
    }

    doSearch(actor) = {
	if (self.searchCont = nil)
	    "You search for a while, but find nothing else hidden
	    in <<self.thedesc>>. ";
	else {
	    self.searchCont := self.searchObj(actor, self.searchCont);
	    "\b(Don't feel too smug about it, though; I suppose nobody
	    could have sat in the armchair without feeling the wand.) ";
	}
    }
    doLookin(actor) = {
	if (self.searchCont = nil)
	    pass doLookin;
	else
	    self.doSearch(actor);
    }

    doSiton(actor) = {
        actor.travelTo(self);
	self.visited := true;
	
	"You lower yourself into the cosy armchair and relax with a
	contented sigh. ";
	
	if (self.searchCont <> nil) {
  	    "However, it doesn't seem as comfortable as you
	    recall it. Strange...\n\t
	    After a while, you realize that you're sitting
	    on something hard. There seems to be something
	    hidden within the armchair. ";
  	}
    }	
;

moor_gnittis : indoors
    noun = 'moor-gnittis'
    sdesc = "Moor gnittis"
    ldesc = "Well, what do you call a perfect mirror image of a sitting 
	room?  Superficially, this room looks exactly like its
        counterpart on the other side of the mirror, except for the eerie
        fact that everything's inverted, of course; there's an armchair,
	and a pipe rack, an empty mirror frame on the south wall, and
	a wooden door leading west. "
    west = tower_door_e
    south = mirror2
    noexit = {
        "You could go back through the mirror (to the south), or 
	you could leave via the door (to the west). ";
	return nil;
    }
    firstseen = {
        "\b\tThis room shouldn't be here at all. After all, you've
	seen your uncle's house from the outside many times, and
	it simply isn't large enough to accommodate one more room... ";
    }
;


pipe_rack2 : decoration
    noun = 'rack' 'pipe'
    adjective = 'uncle\'s' 'pipe'
    sdesc = "pipe rack"
    ldesc = "It looks exactly like its counterpart on the other side
        of the mirror. "
    location = moor_gnittis
;

mirror2 : fixeditem, obstacle
    noun = 'mirror' 'glass' 'frame' 'hole' 'portal'
    adjective = 'large' 'looking'
    sdesc = "mirror"
    ldesc = "The glass has disappeared from the mirror, leaving just
	an empty frame. Well, not quite empty, there's something
	like the wall of a soap bubble, or a water surface, only
	infinitely thinner - perhaps the interface between two
	universes? "
	    
    destination = {
        "Feeling like Alice in Wonderland, you step through the
        empty mirror frame. A curious wrenching sensation passes
        through your body, as if you've been disassembled into atoms
        and then rapidly put together again. ";

	"\b";
	return sitting_room;
    }
    
    verDoEnter(actor) = { }
    doEnter(actor) = {
        actor.travelTo(self.destination);
    }

    wand_effect = {
        ", which pass through the empty frame into the room
        beyond, where they explode with little popping noises. ";
    }

    verDoLookin(actor) = { }
    doLookin(actor) = {
        "You see a room on the other side of the mirror, a 
        room that seems exactly like the one you're standing 
        in - but with north and south reversed. ";
    }
    verDoLookthru(actor) = { 
        self.verDoLookin(actor);
    }
    doLookthru(actor) = { 
        self.doLookin(actor);
    }
    verDoLookbehind(actor) = {
        "You can't look behind the mirror; 
	it's fastened flush to the wall. ";
    }
    verDoTake(actor) = {
        "The mirror is securely fastened to the wall. ";
    }
    location = moor_gnittis
;

armchair2 : decoration
    noun = 'armchair' 'arm chair' 'chair' 'furniture'
    adjective = 'old' 'large' 'comfy' 'comfortable' 'battered' 'fave'
    sdesc = "armchair" 
    ldesc = "It looks exactly as its counterpart on the other side
        of the mirror, only inverted. For example, the large stain
	on the right armrest is on the left one - or is it the
	other way round? "
    location = moor_gnittis
;
