/* $Id: items.t 1.16 96/04/16 21:56:36 mol Exp $
 **********************************************************************
 *
 * Uncle Zebulon's Will, version 2.0
 *
 * An adventure game, written in TADS 2.2.
 *
 * items.t - Sundry items
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
 * The letter you get from the demon.
 */
letter : readable
    noun = 'letter'
    sdesc = "letter"
    ldesc = "I suggest you read it."

    readdesc = "The letter is written in uncle Zebulon's familiar hand.
    \n\t\"My dear Richard,\n
    When you read this, I'm afraid I'll have left this world for good.
    By now you should have heard of my will and of the little 
    jokes I have played on your relatives. I am sure they are all furious;
    they had hoped for far more. Perhaps you too are angry with me, 
    perhaps you think I should have been more generous towards you?\n
    \tWell, let me tell you this: you've always been my favourite
    nephew, because we share (I hope) the same basic outlook on life:
    it's all a rather cruel game, with rules that are there to be 
    circumvented. Playing fair doesn't mean you shouldn't do the unexpected!
    I don't want to openly favour you before your cousins, but I think
    you're far more likely than they are to exploit the advantages
    of the situation. You may call it a little test, or game, or
    whatever. My final advice to you is: follow the rules 
    by the letter and you may find that new possibilities open up.
    \b\t\t\t\tYour affectionate uncle, Zeb.\"\b"

    verDoOpen(actor) = {
        "It's already open. Just go ahead and read it! ";
    }
    verDoThrow(actor) = {
        "Throwing << self.adesc >> would be a futile exercise - 
	the air resistance is far too high. ";
    }
    verDoThrowAt(actor, io) = {
        self.verDoThrow(actor);
    }


    isread = nil
    doRead(actor) = {
 	inherited.doRead(actor);
	if (not isread) {
	    incscore(5);
	    isread := true;
	}
    }
    
    location = nil
;

/*
 * The sheet of paper with Zebulon's poem.
 */
paper : readable, treasure
    noun = 'paper' 'sheet' 'note' 'poem' 'text' 'writing'
    adjective = 'writing'
    sdesc = "sheet of writing paper"
    ldesc = "On the paper, the following text is written in uncle
        Zebulon's neat, regular hand:\b
	
	\tThe FIRST PORTAL deceives us all\n
	\tBy making pairs of singles\n
	\tA perfect match! Yet all illusion\n
	\tA total likeness! And yet\n
	\tAs different as left from right\n
	\tForever kept apart by glass\n
	\tUntil the touch of magic stars\n
	\tTurns glass to air\n
	\tAnd image to reality\n\b

 	\tWhen the light of the Moon illuminates\n
	\tThe Sun that never shines\n
	\tThen open will the SECOND PORTAL\n
	\tA dark, forbidding one, that scares\n
	\tAnd rightly so! Yet victory\n
	\tAwaits the one who enters it\n\b
		
        \tThe THIRD and FINAL PORTAL stands\n
	\tIn a lone and dreary waste beyond the worlds\n
	\tGateway to great adventures\n
	\tGuarded by Gods of Time and War and Love\n
	\tAn offering for each, and you may pass\n
	\tEach gift should match one guardian.\n\b

        You can't help thinking that while Uncle Zebulon may have been 
	a great storyteller, he was clearly an inferior poet. "
	
    doRead(actor) = { self.ldesc; }
    verDoThrow(actor) = {
        "Throwing << self.adesc >> would be a futile exercise - 
	the air resistance is far too high. ";
    }
    verDoThrowAt(actor, io) = {
        self.verDoThrow(actor);
    }
;

    

/*
 * "Interactive fiction" has a slightly different meaning in this
 * world...
 */
book : readable, treasure
    noun = 'book' 'fiction' 'dork' 'trilogy' 'story' 'tale' 'literature'
    adjective = 'dork' 'interactive'
    sdesc = "book"
    read = nil
    ldesc = {
  	"As you open the book and flip through the pages, you find
        that it's a piece of interactive fiction: a magic, heavily
	enchanted book where the entire story changes in response to
	choices made by the reader.\n
	\tThis particular one happens to be one of the great classics
	of the genre: 'Dork', the story of a young man entering a great
	underground computing centre, vanquishing the evil Hacker of
	Foobar, and finally becoming System Manager. Of course, the 
	story may sound a bit childish - everyone knows that computers
	only exist in fairytales and that hackers are purely 
	mythical creatures - but it's still immensely popular. ";

	if (not read) {
	    "\bAs you close the book again, a sheet of paper falls
	    out of it and flutters to the ground. ";
	    incscore(5);
	    paper.moveInto(Me.location);
	    setit(paper);
	    read := true;
	}
    }
    
    doRead(actor) = { self.ldesc; }
    verDoLookin(actor) = { }
    doLookin(actor) = { self.ldesc; }
    verDoOpen(actor) = { }
    doOpen(actor) = { self.ldesc; }
    verDoClose(actor) = {
        "It's already closed. ";
    }
    verDoFlipThru(actor) = { }
    doFlipThru(actor) = { self.ldesc; }
    
    location = desk
;    


scroll : readable, treasure
    noun = 'scroll' 'paper' 'note' 'text' 'writing' 'piece' 'roll'
    adjective = 'paper' 'thick' 'rolled-up'
    sdesc = "scroll"
    ldesc = "\^<< self.thedesc >> is a rolled-up piece of rather thick 
     	paper. To your amazement, you notice that there's something 
	written on it, and in uncle Zebulon's handwriting (what a 
	surprise!). "

    readdesc = "My dear nephew,\b\t
        I'm glad that you've discovered the way through the mirror, and
	into my secret tower. It's here, in the realm you can see from
	the windows, that I've spent most of my time the last few years,
	the time you and your relatives thought I was just pent up inside 
	my house. I may not have collected much gold and belongings in your
	world, but in the world of Vhyl and the city of Cyr-Dhool are
	treasures beyond belief and adventures that surpass your wildest
	dreams.\b\t
	The portal to Vhyl is hidden, but I have no doubt that you will
	find it. Once you've opened it, and passed the portal that's
	beyond it, your true inheritance awaits you, at the end of a quest
	I shall never have the time to finish. Your relatives have no
	doubt already removed what little there is of value in my house;
	what they have left behind, however, may be of more use to you.
	\b\t\t\tWith hope of your success, 
	\n\t\t\t\tyour affectionate uncle,\n
	\t\t\t\t\t\tZebulon\n"

    location = tower
;

/*
 * A flask of acid.
 */
flask : container, breakable, treasure
    noun = 'flask' 'bottle' 'beaker' 
    adjective = 'small' 'glass'
    sdesc = "small glass flask"
    ldesc = {
        "This is a small glass flask, of the type often found in
        alchemistry labs. ";
	if (itemcnt(contents) > 0) {
	    "It contains ";
  	    listcont(self);
	    ". ";
	}
    }
    location = moor_gnittis
    
    // As long as there is acid in the bottle, we have isqcontainer = true
    // so the acid doesn't get listed. After it has disappeared, we
    // set isqcontainer to nil, since then the flask is like any other
    // container.
    isqcontainer = true 

    ioPutIn(actor, dobj) = {
        if (dobj.bulk > 0) // Only small objects will fit inside
	    "That's too large to fit in << self.thedesc >>. ";
	else if (acid.isIn(self))
	    // Let the acid take care of anything put into it.
	    acid.ioPutIn(actor, dobj);
	else
	    pass ioPutIn;
    }
;

acid : item
    noun = 'liquid' 'acid' 'poison' 'quantity' 'fluid'
    adjective = 'green' 'greenish' 'poisonous' 'acidic' 'liquid'
    sdesc = "greenish liquid"
    adesc = "a quantity of greenish liquid"
    thedesc = "the greenish liquid"
    ldesc = "The liquid is rather thick, faintly greenish, and has
        a decidedly unpleasant smell. "
 
    islisted = nil
    location = flask
    used_on = nil // The latest object the acid was used on.
        
    verDoDrink(actor) = {
        "\^<< self.thedesc >> looks decidedly noxious. It's probably
	poisonous as well. ";
    }

    verDoPourOn(actor, io) = {
        if (io = flask)
 	    "But << self.thedesc >> is already inside the flask! ";
	else if (io = self)
            "Don't be ridiculous! ";
	else if (io = gold_ball or isclass(io, coin) or isclass(io, lens))
	    "It would probably be safer to 
	    put << io.thedesc >> in << self.thedesc >> instead. ";
	else if (used_on <> nil) {
	    "Considering what happened ";
	    if (used_on = io)
	        "last time";
	    else
	    	"when";
	    " you poured the liquid on << used_on.thedesc >>, you
	    decide not to try this experiment. ";
	}
    }
        
    doPourOn(actor, io) = {
        used_on := io;
	
	"You carefully pour a single drop of << self.thedesc >>\
	on << io.thedesc >>. With a hissing sound and a 
	cloud of acrid, green smoke, the liquid burns a small hole
	in its surface. This must obviously be some strong 
	acid. Nasty stuff! ";
    }

    doSynonym('PourOn') = 'PutOn'

    verIoPutIn(actor) = {
        flask.verIoPutIn(actor);
    }
    ioPutIn(actor, dobj) = {
        if (dobj.bulk > 0) // Only small objects will fit inside
	    "That's too large to fit in << flask.thedesc >>. ";
	else {
	    used_on := dobj;
	    
            "\^<< dobj.thedesc >> falls into << self.thedesc >>, which 
   	    begins to foam and bubble with a hissing sound. Acrid green
	    fumes billow out of the flask, making your eyes water. ";

	    if (dobj <> silver_coin and dobj <> gold_ball) {
   	        "After a while, the reaction subsides, and the liquid stops
	        fuming. No trace remains of << dobj.thedesc >>. ";
	        dobj.moveInto(nil);
	    }
	    else {
	        flask.isqcontainer := nil;
	        "The reaction doesn't stop until all the liquid has boiled
		away. ";
		self.moveInto(nil);
		if (dobj = silver_coin) {
  		    "\^<< dobj.thedesc >> seems to have grown darker and 
		    duller. In fact, it doesn't look like silver at all 
		    any more, but more like iron. ";
		    silver_coin.moveInto(nil);
		    iron_coin.moveInto(flask);
		    setit(iron_coin);
		}
		else if (dobj = gold_ball) {
  		    "\^<< dobj.thedesc >> has been affected in quite a
		    dramatic way by the reaction - it's not golden at
		    all, but a dull, greyish-white colour. In fact, it
		    looks like the gold has turned into zinc. ";
		    dobj.moveInto(nil);
		    zinc_ball.moveInto(flask);
		    setit(zinc_ball);
		}		
	    }    
	}
    }
    
    // Don't let the player take the acid from the flask.
    verifyRemove(actor) = {
        if (used_on = nil)
	    "You've always been careful when handling unknown chemicals,
	    and you're not going to take any risks with this specimen.
	    Prudently, you decide to keep it in its flask. ";
	else
	    "After seeing what happened to << used_on.thedesc >>, you
	    think it prudent to let << self.thedesc >> stay in 
	    its flask. ";
    }
    verDoPour(actor) = {
        self.verifyRemove(actor);
    }

    verDoTake(actor) = {
	flask.verDoTake(actor);
    }
    doTake(actor) = {
	flask.doTake(actor);
    }

    verDoTakeOut(actor, io) = {
        if (io <> nil and not self.isIn(io))
            "\^<< self.thedesc >> isn't in << io.thedesc >>. ";
	inherited.verDoTake(actor);   // ensure object can be taken at all 
    }
;

/* 
 * The vegetables are actually treasures. The demon must be quite literal-
 * minded, mustn't he?
 */    
carrot : treasure, fooditem
    noun = 'carrot' 'vegetable' 'food'
    adjective = 'large' 'big' 'huge' 'dry'
    sdesc = "large carrot"
    ldesc = "It looks rather dry and doesn't seem very appetizing. "

    verDoEat(actor) = {
        if (location <> actor) 
	    "But you're not holding << self.thedesc >>! ";
	else
	    "\^<< self.thedesc >> looks rather dry and doesn't seem 
	    very appetizing. It doesn't smell very appetizing either.
	    Come to think of it, you're not very hungry. ";
    }
    
    wand_effect = {
        local loc = self.location;
	
        ". The stars collect in a cloud around the carrot, which starts
	to undergo a curious transformation, growing smaller and
	rounder and redder and... When the stars 
	gradually fade away, you see that the carrot has turned
	into a big, succulent tomato. Amazing - you must have found
	a wand of Vegetable Polymorphism! ";

	self.moveInto(nil);
	tomato.moveInto(loc);
    }
    location = kitchen
;    

tomato : treasure, fooditem
    noun = 'tomato' 'fruit' 'vegetable' 'food'
    adjective = 'large' 'red' 'juicy' 'succulent' 'big'
    sdesc = "tomato"
    ldesc = "\^ << self.thedesc >> is large, red and looks much more 
    	appetizing than the carrot did. "

    verDoEat(actor) = {
        if (location <> actor) 
	    "But you're not holding << self.thedesc >>! ";
	else
	    pass verDoEat;
    }
    doEat(actor) = {
        "The tomato is just as delicious as it looks. As you take
	the last bite out of it, you feel something hard between
	your teeth. Surprised, you remove << copper_coin.adesc >> from
	your mouth. How on earth did that get into the tomato? ";
	
	copper_coin.moveInto(actor);
	self.moveInto(nil);
	setit(copper_coin);
	incscore(5);
    }
    
    wand_effect = {
        local loc = self.location;
	
        " that strike << self.thedesc >> and explode with little popping
	noises. The tomato starts to elongate, its colour changing into
	orange, and has sooned turned back into a carrot. Those wands of
	Vegetable Polymorphism may be pretty useless, but they are great 
	fun, aren't they? ";
	self.moveInto(nil);
	carrot.moveInto(loc);
    }
;    

/*
 * A crystal ball that makes you see things.
 */    
crystal_ball : treasure
    noun = 'ball' 'crystal' 'orb' 'sphere'
    adjective = 'crystal' 'spherical'
    sdesc = "crystal ball"
    ldesc = "It's about fifteen centimetres in diameter. Unlike ordinary 
	crystal, it doesn't sparkle in the light;
	instead, it seems to glow with a misty radiance. You feel an
	almost irresistible urge to gaze into it, as if you were some
	common fortune-teller. "
    
    verDoLookin(actor) = { }
    doLookin(actor) = {
        "The interior of the crystal ball is surprisingly cloudy, almost
	as if you were looking into murky water. Soon, however, the mist
	seems to clear, giving place to an image of << self.vision >> 
	\n\tPresently, the vision fades away, and the crystal gets 
	cloudy again. ";
    }

    // The vision method prints a new vision the first five times you 
    // look into the ball. Vision_count keeps track of which vision you see.
    vision_count = 0   
    vision = {
        switch (++vision_count) {
	    case 1:
	        "uncle Zebulon putting coins into a bottle. ";
		break;
	    case 2:	
	        "yourself searching through a large packing crate. ";
		break;
	    case 3:
	        "a young girl throwing a coin into a well, making a
		wish with her eyes closed. ";
		break;
	    case 4: 
	        "uncle Zebulon aiming a wand at a large carrot. The
		carrot turns into a very surprised-looking rabbit.
		Uncle Zebulon chuckles. ";
		break;
	    default:
		"yourself looking into a crystal ball. ";
		--vision_count; // To avoid overflow.
	}
    }
    location = desk
;

/*
 * The magic wand. Pointing it at something will cause the wand_effect
 * method of that object to be run.
 */
wand : hiddenItem, treasure
    noun = 'wand' 'rod'
    adjective = 'magic' 'magical' 'wood' 'ebony' 'narrow' 'tapering'
    sdesc = "magic wand"
    ldesc = "This looks like a typical magic wand of the sort used
        by every wizard around the country: a narrow, tapering rod,
	about thirty centimetres long, and made of some dark 
	wood, probably ebony. Your uncle used to have
	several, and you've often seen him point them at things, with
	various interesting results. "

    verDoWave(actor) = {
        "Wands like this one are most effectively used by pointing
	them at things, not waving them around at random. ";
    }
    verDoPointAt(actor, io) = {
        if (not actor.isCarrying(self))
	    "But %you% %are%n't carrying << self.thedesc >>! ";
	else if (io = self)
	    "Pointing << self.thedesc >> at itself is rather difficult. ";
    }        
    doPointAt(actor, io) = {
        "The wand sputters, emitting a stream of brilliantly shining
        stars"; 
	// An example of object orientation in action: each object knows
	// best itself what happens when you aim the wand at it.
        io.wand_effect;
    }
  
    searchLoc = armchair // hidden in the armchair
    found = nil
;
    
/*
 * Verbs for waving and pointing the wand at things.
 */
waveVerb : deepverb
    verb = 'wave'
    sdesc = "wave"
    doAction = 'Wave'
;

pointVerb : deepverb
    verb = 'point' 'aim'
    sdesc = "point"
    prepDefault = atPrep
    ioAction(atPrep) = 'PointAt'
;

/*
 * Add methods to thing so that objects can be waved and pointed,
 * as well as a default message when you aim the wand at something.
 */
modify thing
    verDoWave(actor) = {
        if (actor.isCarrying(self))
            "Waving << self.thedesc >> about would be absolutely pointless,
            at least in this game. ";
	else
	    "But %you% %are%n't carrying << self.thedesc >>! ";
    }
    verDoPointAt(actor, io) = {
        if (not actor.isCarrying(self))
	    "But %you% %are%n't carrying << self.thedesc >>! ";
	else if (io = self)
	    "Pointing << self.thedesc >> at itself is rather difficult. ";
	else if (isclass(io, movableActor))
            "Pointing things at people isn't polite! ";
	else	
            "Nothing happens. ";
    }        
    verIoPointAt(actor) = { }
    ioPointAt(actor, dobj) = {
        dobj.doPointAt(actor, self);
    }
    wand_effect = {
        " that strike << self.thedesc >> and explode with little popping
	noises, seemingly without affecting it. Quite impressive fireworks,
	but you can't really see the point of it all. Perhaps this is why
	this wand was left lying around? ";
    }
;

/*
 * Aiming the wand at distant items is of course allowed, but not
 * very useful.
 */
modify distantItem
    iobjGen(a, v, d, p) = { 
        if ((v <> pointVerb and v <> throwVerb) or p <> atPrep)
	     self.dobjGen(a, v, d, p); 
    }
    wand_effect = {
        " in the general direction of << self.thedesc >>. Halfway through
	the air, they explode with little popping noises. Quite impressive 
	fireworks, but is it really useful? ";
    }

;

/*
 * Coins - there are several with identical behaviour, 
 * so we make a special class for them.
 */
class coin : treasure
    ldesc = {
   	if (location = basin)
	    self.basin_ldesc;
	else
	    self.ordinary_ldesc;
    }

    ordinary_ldesc = {
        pass ldesc; 
    }
    basin_ldesc = "It's resting on the bottom of << basin.thedesc >>. "

    // We can't reach coins that are in the basin. Note that this method
    // is only needed for the coin class, since the basin doesn't accept
    // any other objects than coins.    	    
    dobjGen(a, v, i, p) = {
        if (location = basin and v <> inspectVerb and v <> takeVerb) {
            "You can't reach it from here. ";
            exit;
        }
	else
	    pass dobjGen;
    }
;

lead_coin : coin
    noun = 'coin' 'money' 
    adjective = 'lead' 'frobnizzian' 'frob' 'quarter-frob' 'grey' 'gray'
           'octagonal'
    plural = 'coins'
    sdesc = "lead coin"
    ordinary_ldesc = "Lead may not the most practical of 
    	materials for coinmaking, but this coin is actually made of 
	grey, soft lead. Not only the metal, but also the shape, 
	of the coin is unusual: it's octagonal.	It bears the image 
	of a trident, surrounded by curious letters you can't read.\n\t
	(In fact, this coin happens to be a genuine
	quarter-frob piece from the country of Frobnizzia. The Frobnizzian
	coins are notable for the great variety of materials used in making
	them; especially notable is the one-gnark coin (one gnark being
	equal to 27 2/3 frobs), which was a granite disk two feet in 
	diameter. The size and weight of this coin were intended to 
	deter purse-snatchers; unfortunately, they had other effects as
	well, such as being the major cause of the collapse of the 
	Frobnizzian economy.) "
	
    bulk = 0
    location = hall
;

copper_coin : coin
    noun = 'coin' 'money'
    plural = 'coins' 
    adjective = 'round' 'copper' 'frobnizzian' 'frob'
    sdesc = "copper coin"
    ordinary_ldesc = "Even though it's from Frobnizzia, a country that's 
        renowned for its curious currency, there's nothing remarkable
	whatsoever about this coin (in fact, it's remarkable for being
	the only non-remarkable Frobnizzian coin). It's small, round,
 	made of copper, and bears the picture of a heart. "
    bulk = 0
;    

iron_coin : coin
    noun = 'coin' 'money'
    adjective = 'iron' 'hexagonal' 'two-frob' 'frob' 'frobnizzian'
    plural = 'coins' 
    sdesc = "iron coin"
    adesc = "an iron coin"
    
    ordinary_ldesc = "This coin, a Frobnizzian two-frob piece, is 
	hexagonal and made of iron. It bears the picture of a sword. "
    bulk = 0
;
 
silver_coin : coin
    noun = 'coin' 'money'
    adjective = 'silver' 'hexagonal' 'nineteen-frob' 'frob' 'frobnizzian'
    plural = 'coins' 
    sdesc = "silver coin"
    ordinary_ldesc = "This coin, a Frobnizzian nineteen-frob piece, is 
	hexagonal and made of silver. It bears the picture of a crescent. "
    bulk = 0
    location = receive_bottle
;

/*
 * Some containers to hide the last lens.
 */
teak_box : openable, treasure, hiddenItem
    noun = 'box' 'container'
    adjective = 'small' 'teak' 'polished' 'wood' 'wooden' 
    sdesc = "small teak box"
    ldesc = {
        "This small box is made of exquisitely crafted teak wood,
    	with a highly polished surface. 
	It is << isopen ? "open" : "closed" >>. ";
	if (isopen and itemcnt(contents) > 0) {
	    "Inside it, %you% see%s% "; 
	    listcont(self);
	    ". ";
	}
    }
    isopen = nil
    maxbulk = 0
    searchLoc = wood_shavings
;

packing_crate : openable, treasure
    noun = 'crate' 'box' 
    adjective = 'packing' 'wood' 'wooden'
    sdesc = "packing crate"
    
    verifyRemove(actor) = {
        "It's far too heavy and bulky for a single person to 
	carry around. ";
    }
    doOpen(actor) = {
        if (wood_shavings.isIn(self))
	    setit(wood_shavings);
	pass doOpen;
    }
    verDoSearch(actor) = {
        if (self.isopen)
	    wood_shavings.verDoSearch(actor);
	else
	    pass verDoSearch;
    }
    doSearch(actor)  = {
        if (self.isopen)
	    wood_shavings.doSearch(actor);
	else
	    pass doSearch;
    }

    isopen = nil
    location = attic
;

wood_shavings : searchHider
    noun = 'shavings' 'shaving' 'wood'
    adjective = 'wood'
    sdesc = "wood shavings"
    adesc = "some wood shavings"
    ldesc = "It's just some ordinary wood shavings of the kind used as 
        packing material. Obviously, this crate used to contain something 
	fragile, perhaps something valuable. If anything still remains hidden
	in the wood shavings, it must be pretty small. "
    article = 'some'

    verifyRemove(actor) = {
        "You take a few wood shavings from the crate, and then change
	your mind: you don't really want them. ";
    }


    verDoLookin(actor) = {
        self.verDoSearch(actor);
    }
    doLookin(actor) = {
        self.doSearch(actor);
    }    
    verDoLookunder(actor) = {
        self.verDoSearch(actor);
    }
    doLookunder(actor) = {
        self.doSearch(actor);
    }
    
    searchObj(actor, list) = {
	local found, dest, i, tot;

        found := list;
	list := nil;

	// set it to the found item(s)
        if (length(found) = 1)
	    setit(found[1]);    // only one item - set 'it'
	else
	    setit(found);       // multiple items - set 'them'

	// figure destination 
	dest := self.location;
	
	// Note what we found, and move it to destination 
	"You burrow through << self.thedesc >>, raising a lot of dust
	in the process, when your hand touches something hard. It seems
	you've found ";
	
	tot := length(found);
	i := 1;	
	while (i <= tot) {
	    found[i].adesc;
	    if (i+1 < tot) ", ";
	    else if (i = 1 and tot = 2) " and ";
	    else if (i+1 = tot and tot > 2) ", and ";
	    
	    found[i].moveInto(dest);
	    i := i + 1;
	}

        ". ";

	if (list<>nil and length(list)=0) list := nil;
	return(list);
    }
    
    location = packing_crate
;


/*
 * The magic bottles
 */
class magic_bottle : breakable, container, treasure
    noun = 'bottle'
    
    ioPutIn(actor, dobj) = {
        if (dobj.bulk > 0) // Only small objects will fit inside
	    "That's too large to fit in << self.thedesc >>. ";
	else 
	    pass ioPutIn;
    }
    
    verDoEmpty(actor) = {
 	if (length(self.contents) = 0)
	    "\^<< self.thedesc >> is empty. ";
	else
	    pass verDoEmpty;
    }
;

receive_bottle : magic_bottle
    adjective = 'blue'
    sdesc = "blue bottle"
    ldesc = {
        "This bottle has an unusually wide neck - almost two centimetres 
	in diameter - and is made of thick glass of a 
	beautiful, deep blue colour. You estimate that it will
	hold about half a litre of liquid. ";
	if (itemcnt(contents) > 0) 
	    "It seems to contain << listcont(self) >>. ";
	else 
	    "It is empty. ";
    }

    location = cupboard
;

send_bottle : magic_bottle
    adjective = 'green'
    sdesc = "green bottle"
    ldesc = {
        "This bottle has an unusually wide neck - almost two centimetres 
	in diameter - and is made of thick glass of a 
	beautiful, sea-green colour. You estimate that it will
	hold about half a litre of liquid. A neatly handwritten
	label says 'FILL ME'. The bottle is empty. ";
    }
    location = sitting_room
    used = nil
    
    ioPutIn(actor, dobj) = {
        if (dobj.bulk > 0) // Only small objects will fit inside
	    "That's too large to fit in << self.thedesc >>. ";
	else {
	    "As soon as it hits the bottom of the bottle, 
	    << dobj.thedesc >> vanishes with a popping sound. The
	    bottle is now empty. ";
	    if (receive_bottle.isVisible(actor.location))
	        "A split second later, %you% hear%s% a pinging noise
		from << receive_bottle.thedesc >>. ";
	    dobj.moveInto(receive_bottle);
	    if (not used) {
	        incscore(5);
		used := true;
	    }
	}
    }
;


plate : readable, treasure
    noun = 'plate' 'brass'
    adjective = 'brass' 'old'
    sdesc = "old brass plate"
    adesc = "an old brass plate"
    ldesc = "It's an old, rather thin plate of Indian brass, slightly dented 
        and probably not worth very much. On the tarnished surface you can
	just barely make out a rather clumsy depiction of a scorpion and
	some stars - probably an astrological reference, since the
	following text is engraved on the back side:\b
	\tGOLD\tThe Sun, Ruler of the Daylit Sky\n
	\tSILVER\tLuna, Mistress of the Night\n
	\tMERCURY\tWing-footed Messenger of the Gods\n
	\tCOPPER\tVenus, Carnal Love\n
	\tIRON\tMars, Blood-red Bringer of War\n
	\tTIN\t\tJupiter, Ruler of the Gods\n
	\tLEAD\tSaturn, Lord of Time Itself "

    doRead(actor) = { self.ldesc; }
    location = attic
;

