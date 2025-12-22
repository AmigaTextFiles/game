/* $Id: endgame.t 1.9 96/04/16 21:56:32 mol Exp $
 **********************************************************************
 *
 * Uncle Zebulon's Will, version 2.0
 *
 * An adventure game, written in TADS 2.2.
 *
 * endgame.t - You guessed it: the endgame
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
 * The "featureless plain" (just a wee bit hackneyed, perhaps) of the
 * endgame.
 */
endgame : room
    noun = 'endgame'
    sdesc = "Plain"
    ldesc = {
  	// The place looks different depending on how much you've
	// sacrificed.
	switch (statues.state) {
 	    case 0:
		"Around you, a seemingly limitless expanse of flat, 
        	greyish ground, stretching away in all directions,
		uninterrupted by any mountains or even hills, unadorned by
		any tree, flower or even a blade of grass.
		Above you, the uniformly overcast sky, like the inside
		of a perfect leaden bowl, merging with the plain at the
		curiously indistinct horizon, a horizon that could be a 
		mile away or a million. 
		The air is still and dry, almost dead, with a faint
		smell of timeless dust. Not even the faintest breath of 
		wind breaks the absolute silence. Nothing moves, 
		nothing changes, nothing happens.\n\t
		In front of you, seemingly in the exact centre of this 
		dismal world, is a perfectly round, marble basin, 
		filled with still, clear water. In the centre of the 
		basin three colossal Greek statues stand looking out over 
		the plain with their unseeing
		eyes, backs together, faces forever fixed in expressions
		of serene detachment. ";
		break;
		
	    case 1:
	        "Around you, the same limitless, greyish plain stretches
		away to the horizon, meeting the same featureless, leaden
		sky; in front of you, you see the same marble basin and the 
		same statues. The air has changed, though. It feels fresher,
		and smells faintly of salt, and above all it's started to
		move: a faint breeze ripples the surface of the water. ";
		break;
		
	    case 2:
	    	"The grayish plain still surrounds you in all directions,
		and the statues still stand motionless in the centre of
		the marble basin.
		Above you, however, the sky is not unnaturally leaden 
		as before, but dark and spangled with thousands of brilliant
		stars that provide enough light to read by. ";
	}
    }
    
    noexit = {
        "There doesn't seem to be anywhere to go in this place. ";
	return nil;
    }
;

statues : fixeditem
    noun = 'statue' 'statues' 'god' 'gods' 'venus' 'mars' 'saturn'
	'aphrodite' 'ares' 'chronos' 'pedestal' 'crown' 'circlet'
	'spear' 'armour' 'robe' 'robes' 
    adjective = 'colossal' 'greek' 'giant' 'marble'
    sdesc = "statues"
    adesc = "statues"

    ldesc = "The three statues stand with their backs together, forever
        looking out over the desolate plain with unseeing eyes. 
	Letters chiseled into the pedestal give their names: Venus, 
	with robes flowing in an imagined breeze, long hair 
	held together by a copper circlet; Mars, stony-faced, muscular,
	dressed in armour, an iron spear in his hand; Saturn, older than time,
	grim-faced under a dull leaden crown. "
	
	    
    state = 0
    
    // This method is called when a coin (except the silver coin, which
    // does nothing) is put into the water.
    wake(coin) = {
        "\b\t";
        if (++state = 1)
	    "As soon as the coin has come to rest on the bottom, something
	    strange happens: ";
	else
	    "\^";
	    
        switch (coin) {
	    case lead_coin: 
	        "the statue of Saturn comes to life. The marble seems 
		to soften somewhat; the aged head turns towards you, 
		and Saturn speaks in a deep, hoarse voice. ";
		self.talk('he');
		break;
	    case iron_coin:
	        "the statue of Mars comes to life with a clanging of
		armour. Mars' gaze remains as hard as before
		as he looks at you, saying in an incredibly powerful
		voice: ";
		self.talk('he');
		break;
	    case copper_coin: 
	        "the statue of Venus undergoes a startling transformation:
		hard, white marble turning into soft, pale-olive flesh,
		frozen stone hair starting to flow like a waterfall,
		white, unseeing eyes suddenly filled with life. ";
		self.talk('she');
		break;
	    default:
	        "Internal error: unrecognized coin (this can't happen). ";
	}

	if (state = 1)
   	    incscore(10);
	if (state < 3) 
	    "\bThe statue returns to its previous form, flesh hardening
	    into stone again, the colour draining away. ";
	else
	    Me.travelTo(desert);
    }
    
    // The various speeches of the gods. pronoun is 'he' or 'she' depending
    // on the sex of the speaker.    
    talk(pronoun) = { 
	switch (state) {
	    case 1:
	        "\"Welcome, stranger, to the Portal between Worlds.
		A long way hast thou come, and yet the way
		that lies before thee is even longer.\" 
		\n\t\^"; say(pronoun);
		" makes a gesture with one hand, and a sound like a whisper
		is heard; a faint breeze sets the still air in motion,
		carrying a smell of salt to your nostrils. For a moment
		you imagine hearing booming surf in the distance. ";
		break;
	    case 2:
	        "\"Thou hast come to claim thy inheritance, and claim
		it thou shalt; but know that thy quest has barely begun.\"
		\n\tRaising both arms towards the leaden sky, ";
		say(pronoun);
		" brings them down again in a motion that somehow seems 
		to tear the sky down as a curtain. The leaden overcast is gone,
		replaced by a glorious night sky, sprinkled with thousands
		of stars bright enough to read by. ";
		endgame_stars.moveInto(endgame);
		break;
	    case 3:
	        "\"The end of the beginning has come. The land of
		Vhyl awaits thee!\"\n\t\^";
		say(pronoun);
		" makes a sweeping gesture with one arm. Around you, the
		plain starts to fade away, as when a painting is washed
		from a glass pane. Gradually, another landscape takes
		shape in front of your eyes: the greyish plain is replaced
		by sand dunes, the featureless horizon becomes dotted with
		palms...
		\b\b[ Press any key to continue ]\b";
		inputkey();
	        break;
	}
    }	
        
    
    verDoAskAbout(actor, iobj) = {
        "Talking to statues is said to be a sign of impending 
	mental collapse. ";
    }
    
    dobjGen(a, v, i, p) = {
        if (v <> inspectVerb and v <> askVerb) {
            "You can't reach the statues from here. ";
            exit;
        }
    }
    
    location = basin
;

endgame_stars : distantItem
    noun = 'star' 'stars' 'constellations' 'constellation'
    adjective = 'sparkling' 'brilliant'
    sdesc = "stars"
    adesc = "stars"
    ldesc = "The stars cover the night sky like diamonds spilled 
        onto a piece of black velvet, arranged into constellations
	you don't recognize. "
;

endgame_sky : distantItem
    noun = 'sky' 
    adjective = 'black' 'leaden' 'overcast' 'night' 'velvet'
    sdesc = "sky"
    ldesc = {
        if (statues.state < 2)
	    "The sky is uniformly grey, like the inside of a great
	    leaden bowl. ";
	else
	    endgame_stars.ldesc;
    }
    location = endgame	    
;	   
	
    
    
basin : fixeditem, readable, qcontainer
    noun = 'basin' 'pool' 'fountain' 'well' 'water' 'liquid' 'surface' 'rim'
    adjective = 'still' 'round' 'marble' 'clear'
    sdesc = "basin"
    ldesc = "The basin is about ten metres across and is filled with
        crystal clear water. At its centre there is a low 
	pedestal with three marble statues. 
	The surface of the water is perfectly still, like a sheet of glass
	through which you can see << listcont(self) >> resting on the bottom. 
	There is an inscription on the rim of the basin. "

    verDoRead(actor) = {
        inscription.verDoRead(actor);
    }
    doRead(actor) = {
        inscription.doRead(actor);
    }
    
    verGrab(item) = {
        "An invisible force prevents you from touching the water. ";
    }
    
    verDoDrink(actor) = { }
    doDrink(actor) = {    
        "You scoop up some water in your hand and drink it. It's quite
	tasteless. After a short while, your head starts to spin. Reeling,
	you grasp for support, but find yourself sinking through an 
	endless, grey void, recalling the last day's happenings backwards,
	realizing that your memories are being erased...
	\b\b\b
	You regain consciousness to find yourself walking the road home
	from uncle Zebulon's house. Just as you suspected, there was nothing
	worth having in the house; your parents were right after all, and
	your uncle was just an ordinary old man with a vivid imagination.\b";
	fail();
    }
    verDoEnter(actor) = {
        "An invisible force stops you from entering the water. ";
    }
    verIoPutIn(actor) = { }
    ioPutIn(actor, dobj) = {
        if (isclass(dobj, coin)) {
            "\^<< dobj.thedesc >> falls into the water with a faint splash
  	    and sinks to the bottom. ";
            dobj.moveInto(self);
	    if (dobj = silver_coin) 
                "You wait for a while, but nothing exciting happens. ";
	    else
	        statues.wake(dobj);
        }
	else {
	    "As << dobj.thedesc >> touches the surface of the 
	    water it bounces off it, and falls to the ground outside
	    the basin. Apparently,
	    this basin is picky about what offerings it accepts. ";
	    dobj.moveInto(endgame);
	}
    }	
    location = endgame
;


/*
 * This coin is just there to provide a clue to the fountain.
 */
gold_coin : coin
    noun = 'coin' 'money' 
    adjective = 'gold' 'golden'
    plural = 'coins'
    sdesc = "gold coin"
    basin_ldesc = "Through the clear water, you can see it 
	shimmering on the
        bottom of the basin. Have there been other visitors before you
	to this place? Has somebody thrown in the coin to have
	a wish granted? "
        
    location = basin
;

inscription : fixeditem, readable
    noun = 'inscription' 'letters' 'text' 'writing'
    sdesc = "inscription"
    ldesc = "\"IN THIS BASIN, O STRANGER, IS BOTH OBLIVION AND ADVENTURE;
        DRINK MY WATER AND THY QUEST SHALL END IN SAFETY; SACRIFICE AND 
	THOU SHALT CONQUER.\""	
    rdesc = { self.ldesc; }
    verDoRead(actor) = { }
    location = basin
;

/*
 * The following location can only be visited once, since printing
 * out its ldesc wins the game.
 */
desert : room
    noun = 'desert' 
    sdesc = "Desert"
    ldesc = {
        "You find yourself standing on a desert road under a magnificent, 
    	star-studded night sky.	Your hair is ruffled by a cold wind that 
	smells of sand and salt; in the distance you hear the booming sound 
	of surf. You recognize the view from uncle Zebulon's tower.
	Not a trace remains of your previous surroundings.\b\t
        You let your gaze wander around the distant horizon, where palm
	trees are outlined against the starry sky.  It is drawn to 
	the silhouette of the fabulous city of Cyr-Dhool,
        a dreamlike mirage 
	at the far end of a narrow road that winds across the desert
	of Noori. Drawn by a strong feeling that your inheritance awaits you
	inside the city, you start walking along the road, through
	the strange country of Vhyl.\b\t

	You walk for an hour or so, feeling the cold, invigorating 
	breeze against your face, letting the dry smells of the
	desert and the salty tang of the distant sea fill your nostrils.
	In front of you, now and then obscured by intervening dunes, 
	steadily growing larger, you see the city of Cyr-Dhool,
	its many spires and cupolas glittering in the starlight like
	some gigantic piece of jewelry. As you get closer, you begin
	to wonder about the total stillness of Cyr-Dhool; not a single
	light shows in its windows, not a single movement is seen. Yet
	the city somehow doesn't seem dead, but rather asleep.\b\t
	
	Finally, you reach the end of the road, in an open place
	just in front of the city's gates. The polished marble walls 
	tower above you, gleaming coolly with reflected starlight. Not
	a single sentry hails you.
	As you approach the tall bronze gates, they swing open to
	leave the passage open into a broad, empty street. With a
	feeling of elation you enter the city to claim your
	inheritance.\b";

    	incscore(10);
	
        "\b\tAnd thus ends the story of uncle Zebulon's will. Many
        adventures await you in the city of Cyr-Dhool, but they belong to a
        different game.\b
	***** You have won *****\b";
	    
    	game_over();
    }
;
