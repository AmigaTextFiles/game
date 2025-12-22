/* $Id: shed.t 1.20 96/04/16 21:56:42 mol Exp $
 **********************************************************************
 *
 * Uncle Zebulon's Will, version 2.0
 *
 * An adventure game, written in TADS 2.2.
 *
 * shed.t - The shed and related objects.
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
 * Doors shouldn't be matched by "all"
 */
modify doorway
    no_all(verb, prep, io) = { return true; }
;

/* 
 * The interior of the shed and some objects that are to be found there.
 */
shed : room
    noun = 'shed'
    sdesc = "Shed"
    ldesc = {
	"This shed was used by uncle Zebulon for his goldmaking: 
 	strange experiments that could often be smelt from across town,
	even occasional explosions.  Your uncle spoke 
	very little of his experiments, and never showed any
	signs of making money out of them, yet people generally 
	assumed that they were successful and a source of great wealth. 
	In all other matters, your family regarded uncle Zebulon 
	as a useless dreamer, even an embarrassment, but they took a 
	certain reluctant pride in his reputation as a goldmaker.\n\b\t

	As a consequence of your relatives' frantic search for 
	valuables, the place is in an even greater mess 
	than you remember. The workbench has been cleared of the 
	usual odds and ends, and all even remotely useful tools
	or utensils have been removed. Large heaps of junk 
	and broken glass remain in the corners, and in the centre of 
	the room is a large, hideous statue of a 
	three-eyed dog - probably some exotic idol brought home from
	your uncle's travels. You can't remember ever seeing
	it before. ";
	
	if (hole.activated)
	    "\bThere is a mysterious dark hole in the middle of
	    the workbench. ";
	    
	if (dog.isactive) 
	    "Powerful beams of coloured light emerge from the statue's
	    eyes, forming an image on the workbench. ";

	if (itemcnt(workbench.contents))
            "\b"; // A list of what's on the workbench will follow.
    }
    south = {
        if (gold_ball.activated) {
	    "You start moving towards the door, but ";
	    if (gold_ball.light_turns < 2)
	        "something about << gold_ball.thedesc >> catches
		your attention";
	    else 
	        "the strange things happening 
		to << gold_ball.thedesc >> are too hard to ignore";
	    ". ";
	    return nil;
	}
	else 
	    return shed_door_n;
    }
    out = {
        return self.south;
    }
    down = hole 
    in = {
        if (hole.activated)
	    askdo;
	else {
	    "But you're already inside! ";
	    return nil;
	}
    }
	 
    noexit = {
    	"The only exit is to the south, back into the garden";
	if (hole.activated)
	    " (unless you count the hole in the workbench, of course)";
	". ";
	return nil;
    }
;

scrap_paper : readable
    noun = 'scrap' 'paper' 'note' 'page' 'lines' 'text' 'writing' 
    adjective = 'torn-out' 'paper'  
    sdesc = "scrap of paper"
    ldesc = "It seems to be a torn-out page from a notebook, with
        a few lines of writing on it. "
    readdesc = "\t\"I'm a great step closer to the goal: I have discovered
	an acid that actually transmutes noble metals into base ones.
	If only the process could be reversed!\" "
    bulk = 0
    location = workbench
;


junk : decoration
    noun = 'junk' 'pile' 'piles' 'heap' 'heaps' 'glass' 
    	'garbage' 'refuse' 'wood' 'glassware' 'newspaper' 'newspapers'
	'clumps' 'slag'   
    adjective = 'junk' 'glass' 'broken' 'large' 'huge' 'big' 'burned' 
    	'old'
    sdesc = "junk"
    adesc = "junk"
    ldesc = "You search through the junk for a while, but find nothing
        interesting, just lots of broken glassware, old newspapers,
	fragments of burned wood, large clumps of slag, you name it. "

    verDoSearch(actor) = {
        self.ldesc;
    }
    
    dobjGen(a, v, i, p) = {
        if (v <> inspectVerb and v <> searchVerb) {
            "\^<<self.thedesc>> isn't important.";
	    exit;
	}
    }
    location = shed
;    


shed_door_n : doorway
    noun = 'door' 'exit'
    sdesc = "door"
    otherside = shed_door_s
    doordest = startroom
    location = shed
;

shed_door_s : doorway
    noun = 'door' 'entrance'
    adjective = 'shed' 'shed\'s' 'garden'
    sdesc = "shed door"
    isopen = nil
    destination = {
        if (not self.isopen) {
	    self.isopen := true;
	    if (self.otherside) 
	        self.otherside.isopen := true;
	    "The shed door opens only reluctantly, with a creaking sound
	    from the rusty hinges.\b ";
	    return(self.doordest );
	}
	else
	    pass destination;
    }
    otherside = shed_door_n
    doordest = shed
    location = startroom
;

workbench : fixeditem, surface
    noun = 'workbench' 'bench' 'surface' 'table'
    adjective = 'work' 'marble'
    sdesc = "workbench"
    ldesc = {
	if (not hole.isIn(self))
            "The marble surface of the workbench is pitted by acids,
            discoloured by strange chemicals and still sooty in places
	    from the explosions that all too often ended uncle Zeb's
	    experiments. ";
	else
	    "There is a dark hole, about a meter in diameter, right
	    in the middle of it. ";

	if (shed_stand.isIn(self)) {
	    "In the exact centre of the workbench, a small
	     bronze stand has been fastened to the surface. ";
	    if (itemcnt(shed_stand.contents))
	        "On the stand is << listcont(shed_stand) >>. ";
	}
        if (itemcnt(self.contents))
            "\bThere << itemcnt(self.contents) = 1 ? "is" : "are" >>\ 
    	     also << listcont(self) >> on the bench. ";
	if (dog.isactive)
	    "The light beams from the dog's eyes are focused on
	    the surface near the bronze stand, forming an image. ";
    }
    location = shed
;

shed_stand : fixeditem, surface
    noun = 'stand' 'support'
    adjective = 'small' 'bronze'
    sdesc = "bronze stand"

    no_all(verb, prep, io) = { 
        return true;
    }

    verDoTake(actor) = {
        "It's fixed to the surface of the workbench. ";
    }    
    verIoPutOn(actor) = {
        if (length(contents) > 0)
	    "But there's already << contents[1].adesc >> on the stand! ";
    }
    ioPutOn(actor, dobj) = {
        if (dobj.bulk > 0)
	    "%You% can't fit that on << self.thedesc >>! ";
	else if (image.isIn(shed) and image.status = 6) {
	    "You place << dobj.thedesc >> right in the middle
	    of the image of the moon, whose light reflects
	    off it with a weird glitter. ";

	    dobj.moveInto(self);
	    if (dobj = gold_ball)
  	        dobj.start_demon;
	}
	else
	    pass ioPutOn;
    }	    
    location = workbench
    maxbulk = 0
;

/*
 * The dog idol.
 */  
dog : fixeditem
    noun = 'dog' 'statue' 'idol'
    adjective = 'large' 'hideous' 'three-eyed'
    sdesc = "statue"
    ldesc = {
        "The statue is made of some dark, hard wood that must once have 
        been nicely polished but is now rather scratched and dented. It
	depicts a huge, hideous dog - even though it's sitting on 
	its haunches, it's still taller than you are - that seems to be 
	staring in a slightly melancholy way at the workbench, as if  
	lamenting the mess. It looks very much out of place in this shed.\n 
	\tApart from its general ugliness, one thing about the dog immediately
	catches your attention: for some unfathomable reason, it has three 
	eyes - two in the normal places, and one in the centre of its 
	forehead. There is also something very strange about its ears.\b
	The centre eye socket contains a blue glass lens.\n";
	
	if (left_eye.isactive) 
	    "The left eye socket contains a red glass lens.\n";
	if (right_eye.isactive) 
	    "The right eye socket contains a green glass lens.\n";
	
	blue_lens.seen;
    }
    location = shed

    // Flags for the internal state of the dog.
    enabled = true    
    isactive = nil
    first_activation = true
    
    eyes = [ centre_eye ] // A list containing the eyes that have lenses
    
    // This method is called to turn on or off the projector.
    onoff = {
        if (not self.enabled)
	    "Nothing further happens, though. ";
	else {
            if (self.isactive) {
     	        "The humming noise stops and the light beams dissappear. ";
	        isactive := nil;
	        image.moveInto(nil);
	    }
	    else {
	        local n_eyes := length(eyes);
	    
	        "A loud humming noise comes from inside the statue, and
	        a beam of blue light shoots out from its centre eye, 
	        illuminating a circle in the centre of the workbench";

	        if (gold_ball.isIn(shed_stand))
	            ", and reflecting off << gold_ball.thedesc >>";
	        ". ";	

	        if (n_eyes > 1) {
	            "The blue beam is immediately joined by 
		     a << eyes[2].colour >> one from << eyes[2].thedesc >>";

		    if (n_eyes > 2) {
		        " and a << eyes[3].colour >> one from the 
			third eye, all focusing on the same area.
		        \b\tThe beams flicker for a few moments, and then
		        seem to gain in brightness. To your great astonishment,
		        a clear, sharp image of your uncle Zebulon forms in 
		        the centre of the illuminated circle. This must surely
		        be some powerful magic at work! ";
		        if (first_activation) {		    
 		            incscore(5);
			    first_activation := nil;
		        }
		    }
		else
		    ". ";
	        }
	        if (n_eyes > 2) {
  	            isactive := true;
		    image.moveInto(shed);
		    image.status := 0;
	        }
	        else
	            "After a while, however, the light flickers and goes 
		    out, and the humming sound stops. ";
	    }
	}
    }
;

/*
 * The dog's eyes.
 */
class dog_eye : fixeditem, qcontainer
    noun = 'eye' 'socket'
    plural = 'eyes' 'sockets'
    adjective = 'dog\'s' 'statue\'s' 'eye'
    adesc = { self.sdesc; }
    thedesc = { self.sdesc; }
    ldesc = {
        inherited.ldesc;
	if (dog.isactive)
	    "A powerful beam of << self.colour >> light 
	    emerges from it. ";
    }
    
    isactive = { return(self.contents <> []); }
    location = dog
    my_lens = nil
   
    // You can't remove the lenses once they're in the eyes. 
    verGrab(obj) = {
        "However much you try, you can't pry it loose from the
	statue's eye socket. ";
    }

    // You can just put one lens in each eye, and it must be the correct one.
    verIoPutIn(actor) = {
        if (self.contents <> [])
	    "But there is already << car(self.contents).adesc >> there! ";
	else
	    pass verIoPutIn;
    }
    ioPutIn(actor, dobj) = {
        if (not isclass (dobj, lens))
	    "It doesn't seem to fit in the statue's eye socket. ";
	else if (dobj <> my_lens)
	    "\^<< dobj.thedesc >> fits perfectly in the statue's eye 
	    socket.\n
	    However, after a few seconds it falls out again. Let's see, was
	    it 'red - port, green - starboard' or the other way round? ";
	else {
	    "As you move << dobj.thedesc >> close to the statue's eye
	    socket, you notice that it seems attracted to it with a 
	    surprising force, like a piece of iron to a magnet. 
	    It fits perfectly and stays put - in fact, you doubt that you
	    could remove it again. ";
	    self.isactive := true;
	    dobj.moveInto(self);
	    dog.eyes += self; // Add this eye to the dog's list of active eyes
	    
	    // score 5 points for first eye
	    if (length(dog.eyes) = 2)
	        incscore(5);
	}
    }
    
    // Make "put lens on eye" work the same way as "put lens in eye".
    verIoPutOn(actor) = {
        self.verIoPutIn(actor);
    }
    ioPutOn(actor, dobj) = {
        self.ioPutIn(actor, dobj);
    }    
;

left_eye : dog_eye
    adjective = 'left'
    sdesc = "the dog's left eye socket"
    my_lens = red_lens
    colour = "red"
;

right_eye : dog_eye
    adjective = 'right'
    sdesc = "the dog's right eye socket"
    my_lens = green_lens
    colour = "green"
;
	
centre_eye : dog_eye
    adjective = 'centre'
    sdesc = "the dog's centre eye socket"
    my_lens = blue_lens
    colour = "blue"
;

/*
 * The three lenses.
 */
class lens : seethruItem
    noun = 'lens'
    adjective = 'glass'
    plural = 'lenses'
    ldesc = "It's about ten millimetres in diameter. "
    thrudesc = "You see a magnified, monochrome version of your
        surroundings. "
    bulk = 0
    verDoLookthru(actor) = {
        if (location <> actor)
	    "But %you% %are%n't holding << self.thedesc >>! ";
    }
;

blue_lens : lens
    adjective = 'blue'
    sdesc = "blue glass lens"
    ldesc = {
        inherited.ldesc;
	self.seen;
    }

    isseen = nil
    seen = {
	// We don't want to be able to refer to the blue lens
	// with just the word 'glass' until we've examined it - otherwise
	// it may be given away by "Which glass do you mean, the junk
	// or the blue glass lens?"
        if (not isseen) {
  	    addword(self, &noun, 'glass');
	    isseen := true;
	}
    }
    location = centre_eye
;

red_lens : lens, treasure
    noun = 'glass' 
    adjective = 'red'
    sdesc = "red glass lens"
    location = teak_box
;

green_lens : lens, treasure
    noun = 'glass' 
    adjective = 'green'
    sdesc = "green glass lens"
    location = drawer
;

/* 
 * The dog's ears.
 */
class dog_ear : fixeditem
    noun = 'ear' 
    plural = 'ears'
    adjective = 'dog' 'dog\'s' 'statue' 'statue\'s'

    adesc = { self.sdesc; }
    thedesc = { self.sdesc; }
    ldesc = "The dog's ears look as if they don't really belong to 
        the statue, but were added as an afterthought - and in a rather
	curious way as well. In fact, it seems as if both ears are
	fastened so that they can turn around their own axes. 
	Curious indeed. "
    location = dog
    verDoTurn(actor) = { }
;

left_ear : dog_ear
    adjective = 'left'
    sdesc = "the dog's left ear"
    doTurn(actor) = {
        "As you turn the ear there is a distinct click. ";
	dog.onoff;
    }
;

right_ear : dog_ear
    adjective = 'right'
    sdesc = "the dog's right ear"
    doTurn(actor) = {
        if (dog.isactive and dog.enabled) 
	    image.change;
	else
	    "Nothing happens. ";
    }
;

/*
 * The image on the workbench.
 */
image : fixeditem
    noun = 'image' 'picture'
    sdesc = "image"
    status = 0
    first_change = true
    
    ldesc = {
        "The image on the workbench shows ";
	self.describe;
    }
   
    // Describe the current image.  
    describe = {
        switch(status) {
	    case 0:
	        "the smiling face of your uncle Zebulon, crowned by
		the caption TEST PICTURE. ";
		break;
	    case 1:
	        "colourful fish swimming placidly back and forth in an 
		aquarium. It's all very beautiful, but it strikes
		you as being rather pointless. ";
		break;
	    case 2:
	        "a lone adventurer, carrying a sword, a brass lantern
		and a curious collection of sundry items, exploring a 
		great cave system of twisting passages all alike. You
		recognize the scene as one from a popular historic
		novel called 'Zork'. ";
		break;
	    case 3:
	        "a field of stars on a totally black sky. Suddenly, a 
		strange-looking contraption appears in the middle of
		the image: it looks almost, but not quite, like a 
		flattened ellipsoid joined to a flashlight. The
		scene changes to what is apparently the inside of the
		contraption, where people in ugly red and blue 
		jumpsuits are running around. ";
		break;
	    case 4:
	        "again, a field of stars. This time, however, nothing
		more happens. You recognize the constellation of
		Gemini, with the twin stars Castor and Pollux. ";
		break;	
	    case 5:
	        "a huge, purple, dinosaur (or, rather, an actor dressed
		up in a shockingly ugly dinosaur suit) walking around
		with an insipid smile on his face, surrounded by singing
		children. Curiouser and curiouser, indeed! ";
		break;
	    case 6:
	        "the full moon, shining like a giant cheese in the
		middle of a dark, star-studded sky. The moon's image
		falls just on << shed_stand.thedesc >> on the workbench";
		if (shed_stand.contents <> []) {
		    local sscont := car(shed_stand.contents);
		    ", illuminating << sscont.thedesc >>";
		    if (sscont = gold_ball)
		        gold_ball.start_demon;
		}
		". ";
		break;
	    default:
	        "a rapidly changing pattern of small black and white 
		dots. ";
	}
    }
    
    change = {
        if (++status > 6)
	    status := 0;
	    
	if (first_change) {
	    first_change := nil;
	    "To your great astonishment, the image of your uncle 
	    disappears, and is replaced by one of fishes in an
	    aquarium. To your even greater astonishment, the image
	    comes to life, showing the fishes swimming back and forth. ";
	}
	else {
	    "The image changes ";
	    if (status = 0) "back ";
	    "into one of ";
	    self.describe;
	}
    }

    location = nil
;
	
/*
 * The gold ball. This object contains the demon that makes things happen
 * "When the light of the Moon illuminates / The Sun that never shines".
 */
gold_ball : treasure
    noun = 'ball' 'sun'
    adjective = 'gold' 'golden'
    sdesc = "gold ball"
    bulk = 0

    light_turns = 0    
    activated = nil

    ldesc = { 
    	if (not activated)
	    "It's the size of a large marble - about a centimetre and
	    a half in diameter - and surprisingly heavy. Surely it
	    can't be made of solid gold? ";
	else 
	    "It's shining with a warm, golden light. ";
    }
    
    start_demon = {
        if (not activated) {
	    activated := true;
	    notify(self, &light_demon, 0);
	}
    }
    
    light_demon = {
 	if (not self.isIn(shed_stand) or not image.isIn(shed) 
				      or image.status <> 6) {
            if (light_turns > 1) 
    	        "\bThe gold ball stops glowing.\b";
	    self.remove_demon;
	}
	else 
	    switch(light_turns++) {
	        case 0: 
		    "\bYou notice
		    a sudden, cold draught";
		    if (shed_door_n.isopen) {
		        ", and a gust of wind slams the door shut";
		        shed_door_n.isopen := nil;
		        shed_door_s.isopen := nil;
		    }
		    ".\b";
		    break;
		case 1:
		    "\bThe light from the image of the moon seems to
		    have a strange effect on the gold ball: it's almost
 		    as if it had started to glow by itself.\b";
		    break;
		case 2:
		    "\bThe gold ball is most definitely glowing, with
		    a warm, golden, slightly pulsating light.\b";
		    break;
		case 3:
		    "\bThe light from the gold ball has reached an
		    almost painful intensity, and continues to grow
		    stronger and stronger. Suddenly, there's a small
		    explosion, and you're temporarily blinded. When
		    you can see again, the dog has stopped shining,
		    the gold ball is gone, and in the centre of the 
		    workbench there's a large hole.\b";

		    // The dog statue won't work anymore
		    dog.enabled := nil;
		    dog.isactive := nil;

		    // Remove everything that was on the bench
		    while (workbench.contents <> [])
		        car(workbench.contents).moveInto(nil);

		    image.moveInto(nil);
		    hole.activate;

		    self.remove_demon;
		    incscore(15);
		    break;
	    }	    
		
    }
    remove_demon = {
        light_turns := 0;
	activated := nil;
	unnotify(self, &light_demon);
    }
    location = bronze_stand
;

zinc_ball : treasure
    noun = 'ball' 'sun'
    adjective = 'zinc' 'dull' 'dullish' 'white'
    sdesc = "zinc ball"
    bulk = 0

    ldesc = { 
       "It's the size of a large marble - about a centimetre and
       a half in diameter - and seems to be made of pure zinc. ";
    }
;    

/*
 * The hole left after the explosion.
 */
hole : fixeditem, obstacle
    noun = 'hole' 'opening' 'portal'
    adjective = 'mysterious' 'dark' 'black' 'large'
    sdesc = "dark hole"
    ldesc = "The hole is almost a metre in diameter and seems
        very deep. Inside is just darkness; you try to look down
	into it but can't see a thing. What's even stranger is that
	the hole doesn't extend through the workbench - the lower
	surface of the workbench is intact. You've read of
	gateways into other universes, but only in fantasy books.
	For a moment, you get a crazy notion that you should enter
	the hole to see where it leads..."

    activated = nil
    destination = {
        if (activated) {
  	    "As you enter the hole, you are engulfed by total darkness.
	    For what seems like an eternity, you sink through a dark
	    void, until, finally, your feet touch solid ground. The 
	    darkness is replaced by greyish light, and you find yourself
	    in a strange place...\b";
            return endgame;
	}
	else
	    return shed.noexit;
    }
    verDoEnter(actor) = { }
    doEnter(actor) = {
        actor.travelTo(self.destination);
    }

    verDoLookin(actor) = { }
    doLookin(actor) = {
        self.doInspect(actor);
    }    
    verDoLookthru(actor) = { }
    doLookthru(actor) = {
        self.doInspect(actor);
    }    

    activate = {
        activated := true;
        self.moveInto(workbench);
    }
;

