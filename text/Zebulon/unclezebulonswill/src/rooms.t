/* $Id: rooms.t 1.14 96/04/16 21:56:39 mol Exp $
 **********************************************************************
 *
 * Uncle Zebulon's Will, version 2.0
 *
 * An adventure game, written in TADS 2.2.
 *
 * rooms.t - Most of the rooms
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

#include "z_std.t"

#ifdef __DEBUG 
// Define some debugging verbs. wizard.t is available from ftp.gmd.de.
// If you don't have wizard.t, you can simply delete the following line.
#include <wizard.t> 
#endif

#include "shed.t"
#include "demon.t"

	    
/*
 * Modify decorations and distantItems so they aren't included in "all".
 */
modify decoration
    no_all(verb, prep, io) = {
        return true;
    }
;

modify distantItem
    no_all(verb, prep, io) = { 
        return true; 
    }
;


/*
 * Modify doorway class to let the player throw things through doors.
 */
modify doorway 
    ioThrowAt(actor, dobj) = {
        if (self.isopen) {
	    "\^<< dobj.thedesc >> flies 
	    through the open << self.sdesc >> and lands on the 
	    other side. ";
	    dobj.moveInto(self.doordest);
	}
	else {
	    "\^<< dobj.thedesc >> hits the closed << self.sdesc >> with 
	    a crash and falls to the ground. ";
	    dobj.moveInto(self.location);
        }
    }
    verIoThrowThru(actor) = {
        if (not self.isopen) 
	    "%You% can't throw anything through a closed door! ";
    }
    ioThrowThru(actor, dobj) = {
        self.ioThrowAt(actor, dobj);
    }
    verDoEnter(actor) = { }
    doEnter(actor) = {
        actor.travelTo(self);
    }
;    
	
/*
 * building - a subclass of fixedItem used for the exterior of buildings
 */
class building : fixeditem
    noun = 'building'
    no_all(verb, prep, io) = { 
        return true; 
    }
    verDoTake(actor) = {
        "What a concept! ";
    }
    verDoEnter(actor) = { }
;

/*
 ******* Uncle Zebulon's Garden *******
 */
startroom : room
    noun = 'garden'
    sdesc = "Garden"
    ldesc = "You are standing just inside the gate of uncle Zebulon's 
        garden, on the weed-infested gravel path that leads east up 
	to the porch of the house. On the north side of the lawn, 
	almost hidden behind the huge, unkempt rosebushes, is the garden shed. 
	The bright summer sun glistens on the wet grass, and the air, fresh
        from the recent rain, is alive with the	buzzing of insects
        and filled with sweet fragrances. "

    north = shed_door_s
    east = {
   	if (Me.inheritance <> nil)
	    "As you step onto the porch, the demon looks pointedly at you.
	    \"What? Back already? Aren't you satisfied with 
	    your << Me.inheritance.sdesc >>? Remember that you're not 
	    allowed to change your mind!\"\b";
	return porch;
    }
    west = {
        if (Me.inheritance = nil) {
 	    "You shouldn't leave now - you haven't even claimed your 
	    inheritance yet! ";
	    return nil;
	}

        "Are you certain that you want to go home now?\n>";
	if (yorn()) {
	    "\bYou decide that you've seen enough of uncle Zebulon's
	    house. Content with your 
	    inherited << Me.inheritance.sdesc >> you walk home, and
	    try to forget that you'd really expected more from your
	    favourite uncle.\n";
	    fail();
	}
	else {
	    "Ok. ";
  	    return nil;
	}
    }
    out = { 
        return(self.west); 
    }
    in = { 
        askdo; 
    }
    noexit = {
        "You can either enter the porch (to the east) or the shed (to the
	north), or leave the garden via the gate (to the west). ";
	return nil;
    }
;

path : decoration
    noun = 'path' 
    adjective = 'gravel' 'garden' 'weed-infested'
    sdesc = "garden path"
    ldesc = "I'm not leading you up the garden path here: it just leads
        from the gate to the porch. "
    location = startroom
;

sun : distantItem
    noun = 'sun' 'above'
    adjective = 'sun' 'above'
    sdesc = "sun above"
    ldesc = "The sun shines down from the blue sky, on sinners and
        saints alike. "
	
    dobjGen(a, v, i, p) = {
        if (v <> inspectVerb) {
            "Come on, get real! ";
            exit;
        }
    }
    location = startroom
;    

sky : distantItem
    noun = 'sky'
    adjective = 'blue'
    sdesc = "sky"
    ldesc = "There's nothing unusual about the sky."
    location = startroom
;
    
plants : decoration
    noun = 'rose' 'roses' 'rosebush' 'rosebushes' 'lawn' 'grass'
    	'bush' 'bushes' 'shrub' 'shrubs' 'plant' 'plants' 'garden'
	'weed' 'weeds' 'flower' 'flowers' 'bed' 'beds'
    adjective = 'garden' 'rose' 'flower'
    sdesc = "garden"
    thedesc = "that"
    ldesc = "Uncle Zebulon wasn't very much of a gardener, so the garden
        isn't exactly a showpiece: the lawn is shaggy, the flower beds
	full of weeds, the rose bushes would need some trimming. Still,
	it's a pleasant place on a summer morning like this. "
    location = startroom
;


shed_outside : building
    noun = 'shed' 'outhouse'
    adjective = 'garden'
    sdesc = "garden shed"
    ldesc = "There's nothing unusual about Uncle Zebulon's garden shed:
        it's a windowless, ramshackle building that could do with a new
	coat of paint. "
    doEnter(actor) = {
        actor.travelTo(shed_door_s);
    }
    location = startroom
;

porch_outside : building
    noun = 'porch' 'verandah' 'veranda'
    sdesc = "porch"
    ldesc = "The porch of the house is just up the garden path, to your
        east. There appears to be someone sitting on it. "
    doEnter(actor) = {
        actor.travelTo(startroom.east);
    }
    location = startroom
;

house_outside : building
    noun = 'house' 'cottage' 'home' 
    sdesc = "Uncle Zebulon's house"
    ldesc = "The house is neither big nor luxurious. Perhaps uncle Zeb
        wasn't so rich after all? "
    adesc = { self.sdesc; }
    thedesc = { self.sdesc; }
    doEnter(actor) = {
        actor.travelTo(startroom.east);
    }
    location = startroom
;

/*
 ******* Porch *******
 */
porch : room
    noun = 'porch'
    sdesc = "Porch"
    ldesc = "On this rickety porch, uncle Zebulon used to spend the long summer 
        evenings, relaxing in his rocking chair and smoking his pipe.
	Your parents used to sneer at his laziness; why couldn't
        he use all that spare time to make his garden look a little more
        respectable?\n
        \tThe rocking chair is still there, right outside the front door
        of the house. It is not occupied by uncle Zebulon,
        though, but by a sneering, rather mean-looking demon. "
	
    west = {
        return demon.pass_w;
    }
    out =  {
        return demon.pass_w;
    }
    east = {
        return demon.pass_e;
    }
    in = {
        return demon.pass_e;
    }
    noexit = {
        "You can either enter the house, to the east, or go back into the
	garden, to the west. ";
	return nil;
    }
;

porch_door_w : doorway
    noun = 'door' 'entrance' 'house' 'cottage'
    adjective = 'front' 'house' 'entrance'
    sdesc = "front door"
    otherside = porch_door_e
    doordest = hall
    doEnter(actor) = {
        actor.travelTo(self.location.east);
    }
    location = porch
;

rocking_chair : decoration
    noun = 'chair' 'rocking-chair' 'seat'
    adjective = 'rocking'
    sdesc = "rocking chair"
    location = porch
;

porch_garden : distantItem
    noun = 'garden'
    sdesc = "garden"
    ldesc = "The garden is just outside the porch. "
    
    dobjGen(a, v, i, p) = {
        if (v <> inspectVerb and v <> inVerb)
            pass dobjGen;
    }
    iobjGen(a, v, d, p) = { 
        if (v <> throwVerb and v <> askVerb and v <> tellVerb)
            pass iobjGen;
    }
    
    verDoEnter(actor) = { }
    doEnter(actor) = {
        actor.travelTo(startroom);
    }
    location = porch
;
        
        
/*
 ******* Hall *******
 */   
hall : indoors
    noun = 'hall'
    sdesc = "Hall"
    ldesc = "Uncle Zeb's house isn't large enough to warrant
        a large entrance hall, but at least there is this small room,
        with just enough space for a coathanger and a narrow staircase
        up to a trapdoor in the ceiling. Wooden doors lead north, east, 
	west and south. "

    firstseen = "\bAs soon as you enter you realize, with a sinking feeling,
   	just how thoroughly your relatives have searched the house for
	valuables - basically everything of value has been removed. The
	coin on the floor must have been dropped there by oversight. "
		
    west = {
    	if (rand(10) > 5)
	    demon.change_activity;
	return porch_door_e;
    }
    out = {
        return self.west;
    }
    north = kitchen_door_s
    east = sitting_door_w
    south = study_door_n
    up = trapdoor_d
;

sitting_door_w : doorway
    noun = 'door'
    plural = 'doors'    
    adjective = 'east' 'eastern' 'wooden' 'wood' 'sitting-room'
    sdesc = "east door"
    otherside = sitting_door_e
    doordest = sitting_room
    location = hall
;

sitting_door_e : doorway
    noun = 'door'
    plural = 'doors'    
    adjective = 'west' 'western' 'wooden' 'wood' 'hall'
    sdesc = "door"
    otherside = sitting_door_w
    doordest = hall
    location = sitting_room
;

kitchen_door_s : doorway
    noun = 'door'
    plural = 'doors'    
    adjective = 'north' 'northern' 'wooden' 'wood' 'kitchen'
    sdesc = "kitchen door"
    otherside = kitchen_door_n
    doordest = kitchen
    location = hall
;

porch_door_e : doorway
    noun = 'door' 'entrance'
    plural = 'doors'    
    adjective = 'front' 'house' 'entrance' 'wooden' 'wood' 'west' 'western' 
    sdesc = "front door"
    otherside = porch_door_w
    doordest = porch
    location = hall
    
    ioThrowAt(actor, dobj) = {
        if (self.isopen) {
	    "As << dobj.thedesc >> flies through the 
	    open << self.sdesc >>, the demon outside reaches out with
	    a clawed hand and catches it in mid-air. \"Don't throw
	    things around like that, something might break!\" he bellows,
	    carefully putting it on the porch. As an afterthought, the 
	    demon adds \"Like, for example, your head.\" ";
	    dobj.moveInto(porch);
	}    
	else
	    pass ioThrowAt;
    }  
    ioThrowThru(actor, dobj) = {
        self.ioThrowAt(actor, dobj);
    }
;

coathanger : decoration
    noun = 'hanger' 'rack' 'coathanger' 'coatrack' 'clothesrack' 
    adjective = 'coat' 
    sdesc = "coat hanger"
    location = hall
;

staircase : fixeditem
    noun = 'stairs' 'stair' 'staircase' 'case' 'ladder'
    adjective = 'stair' 'narrow'
    sdesc = "staircase"
    ldesc = "The narrow staircase (actually, it's more like a ladder 
        fastened to the wall than a proper staircase) leads up to 
        a trapdoor in the ceiling. "
    location = hall
    
    verDoClimb(actor) = { }
    doClimb(actor) = {
        actor.travelTo(trapdoor_d);
    }
;

trapdoor_d : doorway
    noun = 'door' 'trapdoor' 'manhole' 'hatch'
    plural = 'doors'    
    adjective = 'trap'
    sdesc = "trapdoor"
    ldesc = { 
        "The trapdoor leads up to the attic. ";
	pass ldesc;
    }
    doordest = attic
    otherside = trapdoor_u
    location = hall
    
    doClose(actor) = {
        "You climb up the ladder, close the trapdoor, and climb down
	again. ";
	isopen := nil;
	if (otherside)
	    otherside.isopen := nil;
    }
    verDoOpen(actor) = {
        "You can't reach it from down on the floor. ";
    }
;

/*
 ******* Attic *******
 */
attic : indoors
    noun = 'attic'
    sdesc = "Attic"
    ldesc = "You remember spending long hours as a child exploring the 
        mysterious treasures of uncle Zebulon's attic: looking through old 
        sea-chests full of exotic souvenirs from your uncle's travels,
        trying on curious old clothes, hiding under strange pieces
        of furniture - and upsetting your mother when returning home
	covered in dust and with cobwebs in your hair. 
	That was long ago, however; now, the attic just seems
        like a depressingly untidy storage space full of old junk and
        devoid of any mystery. Besides, it seems as if anything even 
        remotely interesting or valuable has been carried away. 
	A trapdoor in the floor leads down. "

    firstseen = {
        "\bAs your head emerges through the trapdoor, you are greeted by
	a cloud of dust that makes you sneeze. ";
    }
    down = trapdoor_u
;

attic_dust : decoration
    noun = 'dust'
    sdesc = "dust"
    location = attic
;

attic_junk : decoration
    noun = 'junk' 'garbage' 'chest' 'chests' 'furniture'
    adjective = 'strange' 'old'
    sdesc = "junk"
    location = attic
;
    
trapdoor_u : doorway
    noun = 'door' 'trapdoor' 'manhole' 'hatch'
    adjective = 'trap'
    sdesc = "trapdoor"
    doordest = hall
    otherside = trapdoor_d
    location = attic
;

/*
 ******* Kitchen *******    
 */
kitchen : indoors
    noun = 'kitchen'
    sdesc = "Kitchen"
    ldesc = {
        "The kitchen is probably tidier now than it ever was during
        uncle Zebulon's lifetime. The well-worn pine table and the large
        cupboard are still there, but all traces of atmosphere seem 
	to have vanished along with the piles of unwashed dishes.
        Your relatives have evidently been hard at work, 
	removing all the kitchenware and utensils, even the iron stove. 
	They've left the kitchen sink behind, though - probably by oversight. ";
    }
    south = kitchen_door_n
    noexit = {
        "The only exit is the door back to the hall, to the south. ";
	return nil;
    }
;

kitchen_table : decoration
    noun = 'table'
    adjective = 'pine' 'wood' 'wooden' 'worn' 'well-worn' 'kitchen'
    sdesc = "kitchen table"
    location = kitchen
;

kitchen_sink : fixeditem, container, surface
    noun = 'sink'
    adjective = 'kitchen' 'old' 'dirty'
    sdesc = "kitchen sink"
    ldesc = {
	"It's just an old, rather dirty, kitchen sink of galvanized
        iron. There are no taps - uncle Zebulon never bothered to install
	running water, but used to fetch his from the village well. ";
	if (itemcnt(contents)) {
	    "In the sink you see ";
	    listcont(self);
	    ". ";
	}
    }	    
    issurface = nil // We inherit from surface just to be able to "put on"
    location = kitchen
;

cupboard : openable, fixeditem
    noun = 'cupboard' 'cabinet' 'closet'
    adjective = 'large' 'wood' 'wooden'
    sdesc = "cupboard"
    ldesc = {
        if (not isopen)
	    "Uncle Zebulon used to keep his plates and his kitchen utensils
	    in this large, wood cupboard - when he didn't just leave them
	    lying around, of course.\n";
	pass ldesc;
    }	 
    isopen = nil
    location = kitchen
;

kitchen_door_n : doorway
    noun = 'door'
    adjective = 'wooden' 'wood' 'kitchen'
    sdesc = "door"
    otherside = kitchen_door_s
    doordest = hall
    location = kitchen
;

/*
 ******* Study *******
 */
study : indoors
    noun = 'study'
    sdesc = "Study"
    ldesc = "You are in what uncle Zebulon used to call his study, 
    	but which also doubled as his bedroom. You remember this room 
	as being full of books: bookshelves crammed with them, 
	books on the overflowing desk, stacks of books on the floor.\n\t 
	Now, the bookshelves gape empty; the narrow, rickety bed is gone, 
	as are the soft carpets. Only your uncle's desk remains, 
	along with the smell of old books and stale 
	tobacco smoke. The only door leads north, back into the 
	hall. "

    north = study_door_s
;

study_door_s : doorway
    noun = 'door'
    adjective = 'only' 'wooden' 'wood'
    sdesc = "door"
    otherside = study_door_n
    doordest = hall
    location = study
;

study_door_n : doorway
    noun = 'door'
    plural = 'doors'    
    adjective = 'wooden' 'wood' 'study' 'southern' 'south'
    sdesc = "south door"
    otherside = study_door_s
    doordest = study
    location = hall
;

bookshelf : fixeditem, surface
    noun = 'shelf' 'shelves' 'bookshelf' 'bookshelves'
    adjective = 'book'
    
    found = nil
    
    sdesc = "bookshelves"
    adesc = { self.sdesc; }
    pluraldesc = { self.sdesc; }
    
    verDoLookin(actor) = { }
    verDoSearch(actor) = { }
    doLookin(actor) = {
        self.ldesc;
    }
    doSearch(actor) = {
        self.ldesc;
    }
    location = study;
;

desk : fixeditem, surface
    noun = 'desk' 'table' 
    adjective = 'oak' 'writing' 'uncle\'s'
    sdesc = "desk"
    ldesc = {
        "The desk looks rather bare without all the stacks of
        papers and books that used to cover it (uncle Zebulon always
	had to clear off part of it when he wanted to write). 
	It is made of oak and has a single drawer, which 
	is << drawer.isopen ? "open" : "closed" >>. ";
	if (itemcnt(contents) > 0) {
	    "\n\t";
	    showcontcont(self);
	}
    }
    
    verDoSearch(actor) = { }
    doSearch(actor) = {
        self.doInspect(actor);
    }
    verDoOpen(actor) = {
        drawer.verDoOpen(actor);
    }
    verDoClose(actor) = {
        drawer.verDoClose(actor);
    }
    doOpen(actor) = {
        drawer.doOpen(actor);
    }
    doClose(actor) = {
        drawer.doClose(actor);
    }
    location = study
;

drawer : fixeditem, openable
    noun = 'drawer'
    adjective = 'desk'
    sdesc = "drawer"

    isopen = nil
    
    verDoSearch(actor) = { }
    doSearch(actor) = {
        self.doInspect(actor);
    }

    location = desk
;

tower : indoors
    noun = 'tower'
    sdesc = "Tower room"
    ldesc = "You are in a rather small, circular room that seems to be
        the top floor of a high tower. Four large windows, one in each
        compass direction, give you a panoramic view of a wild and marvellous
        landscape: a mountain range of impossibly steep crags to the north;
	to the west, the sea; to the south and east a wide, sandy desert.
	Far away to the southwest, where the sea meets the desert, stands
	a fantastic fairy-tale city of marble and shimmering gold,
	needle-sharp spires and bulbous crystal domes. The scene is 
	illuminated not by the sun, but by cold	starlight from a sky like 
	black velvet studded with diamonds; nameless stars in constellations 
	you don't recognize.\b
	\tIn the centre of the room is a narrow marble pedestal that 
	supports a curious mechanism. A spiral staircase leads down. "
    down = moor_gnittis
    out = moor_gnittis
    noexit = {
        "The only way out is via the stairs. ";
	return nil;
    }
;

pedestal : fixeditem
    noun = 'pedestal' 'support' 'stand' 'pillar'
    adjective = 'marble' 'narrow'
    sdesc = "marble pedestal"
    ldesc = "The pedestal is about a metre high and not very interesting;
        the mechanism that's resting on top of it is, though. "
    location = tower
;

mechanism : fixeditem, surface
    noun = 'mechanism' 'model' 'clockwork' 'system' 'machinery' 'clock'
    	'disk' 'orbits' 'orbit' 'planet' 'planets'
    adjective = 'solar' 'intricate' 'marble' 'black'
    sdesc = "mechanism"
    ldesc = {
        self.isseen := true;
        "This beautiful piece of intricate machinery seems to be
        a model of the solar system. On a large disk of black marble, 
	studded with silver stars, the orbits of the planets are laid
	out as narrow tracks. The planets are represented by small disks
	of precious stones that move, ever so slowly, along their tracks,
	driven by some hidden clockwork. In the centre of the disk is ";
	if (gold_ball.isIn(bronze_stand)) 
	    "the sun: a golden ball, resting on a small bronze stand. ";
	else
	    "a small bronze stand. ";
    }
    ioPutOn(actor, dobj) = {
        "It would be a shame to put << dobj.adesc >> on top of
	this marvellous mechanism! ";
    }
    
    isseen = nil
    isqsurface = true
    location = tower
;

bronze_stand : fixeditem, surface
    noun = 'stand' 'support'
    adjective = 'small' 'bronze'
    sdesc = "bronze stand"

    no_all(verb, prep, io) = { 
        return true;
    }
    
    verIoPutOn(actor) = {
        if (length(contents) > 0)
	    "But there's already << contents[1].adesc >> on the stand! ";
    }
    ioPutOn(actor, dobj) = {
        if (dobj.bulk > 0)
	    "%You% can't fit that on << self.thedesc >>! ";
	else
	    pass ioPutOn;
    }	    
    location = mechanism
    isqsurface = true
    maxbulk = 0
;
       
   
windows : decoration, seethruItem
    noun = 'window' 'windows' 
    sdesc = "windows"
    adesc = "windows"
    ldesc = "The windows aren't important. What you can see through
        them is. "
    isplural = true
    thrudesc = {
        landscape.ldesc;
    }
    location = tower
;
    
landscape : distantItem
    noun = 'mountain' 'mountains' 'range' 'crags' 'desert' 'sea' 'view'
    	   'landscape' 'water' 'vhyl'
    adjective = 'steep' 'wild'
    sdesc = "landscape"
    ldesc = "There are no mountains like that within a thousand miles
        of your home, and the sea is quite far away as well - and there
	is certainly no desert even on the same continent. "
    location = tower
;

stars : distantItem
    noun = 'stars' 'star' 'constellation' 'constellations' 'sky'
    adjective = 'night' 'black' 'velvet'
    sdesc = "sky"
    ldesc = "You don't recognize the constellations. You must
        be very far indeed from home. "
    location = tower
;

city : distantItem
    noun = 'city' 'town' 'settlement' 'cupolas' 'cupola' 'buildings'
    	   'building' 'spires' 'spire' 'port' 'cyr-dhool'
    adjective = 'crystal' 'marvellous' 'shimmering'
    sdesc = "city"
    ldesc = "The city is too far away for you to see very much detail,
        but it doesn't resemble any city you've ever seen. Despite its
	breathtaking beauty, something about it seems wrong; it's
	brightly lit, yet seems curiously devoid of life. If only
	you could get there to investigate..."
    location = tower
;


tower_door_e : doorway
    noun = 'door'
    adjective = 'wooden' 'wood' 'west' 'western'
    sdesc = "west door"
    doordest = {
        if (not tower.isseen)
	    "You are quite a bit surprised to find that the door leads not to
	    a mirror image of the hall, but to a narrow spiral staircase
	    that leads up a circular stairwell with stone walls,
	    and through a hole in the ceiling.\b";
	return tower;
    }
    location = moor_gnittis
;