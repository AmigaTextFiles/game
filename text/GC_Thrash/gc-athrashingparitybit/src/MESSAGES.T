setmessages: function() {

	/* Dining Philosophers */
	
	philosophers.messages := [
		philosophers_deadlock_msg
		philosophers_notdeadlock_msg
		philosophers_msg
	];
	philosophers.messagesperturn := 2;

	/* Marvin Minsky */

	marvin.messages := [ badidea_message marvin_msg ];

	/* Hoch (1) and Konigsberg (2) */

	graphtheorist1.messages := [ goodidea_message graph1_msg graph1_notfound_msg ];
	graphtheorist2.messages := [ goodidea_message graph2_msg graph2_notfound_msg ];

	humblebee.messages := [ beesting bee_msg ];
	humblebee.messageD := 5;

	dean.messages := [ dean_degree_msg dean_nodegree_msg ];

	arpa.messages := [ beforebreakfast_msg afterbreakfast_msg ];

	/* Robot */

	robot.messages := [
		robot_msg robot_msg1 robot_msg2 robot_msg3 robot_msg4 robot_msg5
		robot_msg6 robot_msg7 robot_msg8 robot_msg9 robot_msg10
	];

	salesman.messages := [salesman_msg];

	setdenizenmessages();

	/*
	 * Turing Evaluation Stuff
	 */
	arpa.louisresponses := [
		'Yup, just fixed the last bug.'
		'Of course- what could go wrong?'
		'Naturally.'
		'Ready and raring to go.'
		'Nothing will go wrong this time.'
	];
	arpa.stories := [ arpastory1 arpastory2 arpastory3 arpastory4
			arpastory5 arpastory6 arpastory7 arpastory8
			arpastory9 arpastory10
	];
	arpa.machineproblems := [
		'You can smell smoke coming from somewhere behind you.  Suddenly a blaring
		klaxon goes off: \"Red Alert! Red Alert!  Parenthesis overload in section 2!
		Clear the bay! I repeat, clear the bay!\"'

		'The computer burps twice.'

		'The Contraption Machine starts singing \"99 Bottles of Beer on the Wall\"
		in a loud, off-key, tuneless voice.  Rather like a drunk who\'s just been 
		told the bar is closing.'

		'The computer seems to be whispering \"Daisy, daisy...\".'

		'Somewhere nearby you hear the sound of a transistor screaming.'

		'You hear an accelerating disk drive, and are glad
		you\'re safely protected as the wrenching indications of yet
		another exploding peripheral reach your ear.'

		'Oh no!  Processors on opposite sides of the machine are sending messages
		at regular intervals.  There\'s a destructive resonance building up, and
		as you feel the computer begin to shake, Louis furiously kicks the CM-8
		until it stops.'
	];
	arpa.louisfixes := [
		'Hmm.  I though I fixed that bug.  Oh well, won\'t take a second to do.'
		'So, maybe I forgot to invert the polarity of the neutron flow.'
		'Must be a problem with the compiler.  Guess I\'ll use GCC.'
		'That\'s what I get for having grad students write code instead of UROPs.'
		'I\'ll just add another GOTO and be right back.'
		'You have to understand- I haven\'t been getting a lot of sleep lately.'
		'Ha ha.  I meant it to do that.  Really, I did.'
	];

	cat.actions := ['scratching itself' 'licking its fur' 'purring'
					'looking bored' 'obeying Fermi-Dirac statistics'
					'shimmering' 'but may not be for long'
					'or so your eyes lead you to believe' 'isn\'t it'
					];
}

goodidea_message: message
	texts = [ 'That\'s a mighty fine idea you have there.' ]
	vfymessage(npc,actor) = { return (actor.isCarrying(youridea)); }
;

badidea_message: message
	statements = [ 'Looks like that idea there has been writhing under the crushing foot
		of reason.' ]
	vfymessage(npc,actor) = { return (actor.isCarrying(badidea)); }
;

/* Marvin's Messages */

marvin_msg: message
	exclamations = [
		'Society is mindless!'
		'A corner office in a building I never enter.  That\'s power for you!'
	]
	ponders = [
		'Aaaah, for the good old days, when AI was young and nobody gave
		 neural nets a second glance!'
		'Maybe I should have ghosted the Turing Option'
	]
	statements = [
		'A theory of pain. I need a theory of pain.'
		'A mind is like a society.  In fact, like a society of small interconnected
		neurons that don\'t get out of the house much and have probably taken to
		drink.'
	]
	questions = [
		'Where\'s John these days?'
	]
;

philosophers_deadlock_msg: message
	vfymessage(npc,actor) = { return(philosophers.aredeadlocked); }
	exclamations = [
		'Break the symmetry!  Give me my fork!'
		'Break the symmetry!  Give me my knife!'
		'Yow!  That was my eye!'
		'Why the hell don\'t they just bring us more forks?'
		'Look- over there- Heidegger!'
		'Double, double toil and trouble, fire burn and cauldron bubble.
		Ere the passing of the day, all this food I will away!'
		'Eye of newt and stool of toad, let this warning now be told:
		if no knife I soon do hold, a tale of death shall I unfold!'
		'Hexy, hexy, hexy poo!  Now this fork I shove in you!'
	]
	questions = [
		'Why do you persist in thwarting me?  You\'re not hurting anybody
		but yourself.'
		'Perhaps you could write that down for me?'
		'What is a fork anyway?  Really?  I mean, couldn\'t it all be a hoax.'
		'Isn\'t that your wife over there, running off with Wittgenstein?  I\'d
		go check if I were you.'
	]
	statements = [
		'My dear sir, were I to give up a utensil everyone else would
		follow my lead, and none of us would be able to eat.'
		'I tell you, you are in a dream.  Pinch yourself with your hand-
		no the other one.'
		'Imagine a bottle that always poured out half of its contents.'
		'I\'m thinking of a big number.  Guess it, and I\'ll give you my fork.'
		'I\'ll give you the fork back in a second.  Just let me borrow it for
		a moment.'
		'Suppose, just suppose, that your eyes are deceiving you.  What if
		there really isn\'t any food on the table?'
		'I\'m going to hold my breath until you give up what is rightfully
		mine.'
	]
	texts = [
		'A philosopher hits another in the eye.'
		'A philosopher tickles another with some ham.'
		'One of the philosophers seems to be biting the one on his left.'
		'Oooh.  A vicious head butt from the man on his left, and still
		a philosopher maintains his grip on his knife.'
	]
;

philosophers_notdeadlock_msg: message
	vfymessage(npc,actor) = { return(not philosophers.aredeadlocked); }
	questions = [
		'I wonder who that kind man with the fork was?  No matter, he\'ll
		soon die.'
	]
	exclamations = [
		'I\'m choking!  I\'m choking!  Quick, some motor oil to lubricate
		my throat!'
	]
	statements = [
		'That fork they brought us was dirty.  Can you believe it,
		a dirty fork.  For the greatest minds alive today.'
		'You know, this food really isn\'t that great.'

		// THE 41 MESSAGE IS IMPORANT RE. ALYSSA'S DESK COMBINATION

		'I believe the number 41 is the 3rd most important number in
		the universe.  First comes 42, then probably either 0 or pi
		or something like that, but one can hardly forget about 41. \'twould
		be a bad idea to neglect 41.'
	]
;

philosophers_msg: message
	exclamations = [
		'Psychometrics!  I tell you, psychometrics is the key!'
		'Laugh while you can, monkey boy!'
	]
	questions = [
		'Perhaps you tire of your imbecility?'
		'Do you think we\'re destroying our credibility by eating?'
		'Would you like to see the pictures from my recent trip to Hoboken?'
	]
	statements = [
		'Think about this- what I am saying is false.'
		'Chew on this- what you are thinking is false.'
		'A brain the size of a planet, and I\'m surrounded by imbeciles.'
		'So, as I was discussing with Bertrand...'
	]
	requests = [
		'Pass me the cheez, will you my friend.'
	]
;

salesman_msg: message
	questions = [
		'Would you like to buy some Symbolics stock?'
		'I wonder what the shortest path to the maze is?'
	]
	statements = [
		'Oh dear.  I seem to be going the long way around.'
		'It\'s all David Johnson\'s fault.  He sent me this way.'
		'I\'ll never make my sales quota for this month if I can\'t find
		a quicker route to get to Western Unnkulia.'
		'They run me ragged.  Twenty-three cities in only nineteen days,
		and now I\'m stuck at this ridiculous Institute.'
		'Why did they only simulate the annealing?  If they\'d really
		annealed my path I\'d be fine now.'
		'I\'ve got a great deal on a Lisp Machine you could buy.'
		'I have a beautiful used CADR I could let you have for cheap.'
	]
;

/* Hoch */

graph1_notfound_msg: message
	exclamations = [
		'Aren\'t there any clean whiteboards in this place?'
	]
	statements = [
		'As soon as we can find a clean whiteboard, I\'ll show you
		my new garden derivation.'
	]
	vfymessage(s,m) = { return (not graphtheorist2.foundboard); };
;

graph1_msg: message
	statements = [
		'Imagine a connected set of points...'
		'Truly life, like a graph, is a marvelous web of point-like nodes.'
	]
	questions = [
		'So, Konigsberg, did you get your start connecting dots too?'
	]
;

/* Konigsberg */

graph2_notfound_msg: message
	exclamations = [
		'Acme will pay for this!  Not a clean whiteboard in 2 years now.'
	]
	questions = [
		'Hoch, I heard you\'ve decided the sequence is of a Fibonacci type.'
	]
	vfymessage(s,m) = { return (not graphtheorist2.foundboard); }
;

graph2_msg: message
	statements = [
		'Heads.' 'Tails.'
		'Me, I\'ve always thought of myself as a line.'
	]
;

/* Dean Chiquita */

dean_hello_msg: message
	texts = [
		'The dean rises to greet you, saying \"Welcome to the Acme
		Institute.  Can I help you?\"\n'
	]
;

dean_nodegree_msg: message
	vfymessage(s,a) = { return(not a.havedegree); }
	requests = [
		'If you don\'t have anything to do here, can you please leave?
		I\'m expecting important visitors.'
	]
	statements = [
		'My office is much less cluttered when you\'re not in it.'
	]
;

dean_degree_msg: message
	vfymessage(s,a) = { return(a.havedegree); }
	statements = [
		'Even though you are an alum, there are limits to my hospitality.'
	]
	requests = [
		'Perhaps you\'d like to start up an alumni association in Western
		Unnkulia.'
	]
;

/* Robot */

robot_happymsg: message
	alltext(s,a) = "The robot seems overjoyed that there is absolutely no work
			that it can do.";

class rmsg: message
	vfymessage(s,a) = {
		return(s.myplanner and (self.n = nil or s.statenumber = self.n));
	}
;

robot_msg: message
	ponders = [
		'What if I moved this here?'
		'I wonder who put these blocks here anyway?'
		'Over here then?'
	]
	statements = [
		'Block R.  Yes, Block R is the key.  I see it all now.'
		'Block S.  Yes, Block S must be the fulcrum.  All is clear.'
		'Block T.  Yes, Block T, how could I have neglected it?  How obvious.'
	]
	weight = 200
;

robot_msg1: rmsg
	n = 1
	exclamations = [
		'What a wonderful day!'
		'Aah, to be alive in the Spring, moving blocks.  \'Tis joy itself!'
	]
	statements = [
		'And to think some would spend their life some other way.'
		'There must be a God, or the world could not be this wonderful.'
	]
;

robot_msg2: rmsg
	n = 2
	exclamations = [
		'Verily, I am having fun!'
	]
	statements = [
		'Oh, it all makes sense now.  What a wonderful puzzle this has been.'
		'Should any suggest a different line of work, I would have to decline.'
	]
;

robot_msg3: rmsg
	n = 3
	statements = [
		'Hmm.  Something enjoyable shouldn\'t be quite this hard.'
		'It would be nice to see the opera too, I suppose.'
	]
	mutters = [
		'Blasted block.  No, no, enjoy it.'
	]
;

robot_msg4: rmsg
	n = 4
	statements = [
		'This is getting a bit boring.'
		'I can imagine doing other things with my life.'
	]
	ponders = [
		'Why can\'t I figure this out?  It doesn\'t look that hard.'
	]
;

robot_msg5: rmsg
	n = 5
	statements = [
		'I bet this can\'t be solved. That must be it.'
	]
	exclamations = [
		'But I could have sworn that was going to do it!'
		'Can\'t these things just stay up when I get them there?'
	]
;

robot_msg6: rmsg
	n = 6
	statements = [
		'I wish I could get this done, so I could enjoy the day.'
	]
	mutters = [
		'Looks like rain anyway.'
	]
	questions = [
		'Am I the only one having problems with this?'
	]
;

robot_msg7: rmsg
	n = 7
	statements = [
		'Should have listened to that lecture on the Sussman anomaly.'
		'I\'ll probably never get it.'
		'I guess I\'m just a failure.  That\'s all I am, a failure.'
	]
;

robot_msg8: rmsg
	n = 8
	statements = [
		'I am really getting depressed about all this.'
		'Somewhere, out there, there must be some hope for me.  No, I am wrong.'
		'Just a little sign of progress.  That\'s all I need.'
	]
	questions = [
		'Why did I never settle down and start a family when I had the chance?'
	]
;

robot_msg9: rmsg
	n = 9
	ponders = [
		'What a fool I must be.  Can life get any worse?'
		'To be, or not to be.  That is the question.  Whether \'tis...'
	]
	exclamations = [
		'Stupid scum, that\'s what I am.  Simple blocks and I fail.'
		'Lambda!  Did they have to pick such an idiot.'
	]
;

robot_msg10: rmsg
	n = 10
	exclamations = [
		'No more, it cannot go on.  I must find a way out of this hell!'
		'Damn Asimov and his Third Law!'
	]
	ponders = [
		'Surely death would be a better fate.'
	]
	statements = [
		'Tonight.  Tonight I shall take my life, whatever the consequences.'
	]
;

/* Humble Bee */

beesting: message
	print(s,a) = { s.sting(a); }
	weight = 10
;

bee_msg: message
	texts = [
		'You hear the strains of Auld Lang Syne coming from somewhere.'
		'You hear the flight of the humble bee.'
		'You hear the dulcet strains of the Free Software Song coming from somewhere.'
		'You hear the strains of the Engineer\'s Song coming from somewhere.'
	]
	requests = [
		'Do you know the tune?'
	]
	statements = [
		'Really, it was nothing.'
		'Anyone could have done it, I\'m sure.'
		'Well, you have to understand, I had a lot of help.'
		'Others deserve a lot of the credit.'
		'Thank you, but I don\'t deserve it.'
	]
;

/*
 * ARPA Messages
 */

beforebreakfast_msg: message
	vfymessage(npc,actor) = { return (not npc.haseaten); }
	exclamations = [
		'I could starve to death and they wouldn\'t care.  Insensitive bastards!'
		'Some toast!\ Some toast!\ My kingdom for some toast!'
	]
	statements = [
		'Bread.  Heat.  It\'s not so complicated.'
		'Soon they will pay.  Oh yes, they will pay.'
		'Blow the whole bloody place up, that\'s what I\'ll do.'
		'Perhaps I could sue the cheezy place.  That would serve them right.'
	]
	questions = [
		'Why should I suffer?'
		'Is a piece of toast so much to ask for?'
	]
;

afterbreakfast_msg: message
	vfymessage(npc,actor) = { return (npc.haseaten); }
	questions = [
		'After that kind of wait, they expect a good evaluation?'
		'What if I just left now?'
		'Do they think I enjoyed my morning?'
		'I wonder what they\'ll do about my lunch.'
	]
	statements = [
		'So now they want an evaluation, do they?'
		'I\'ve half a mind to teach them a lesson now.'
		'The end of the institute, that\'s what they have to look forward to.'
	]
	exclamations = [
		'Foo!'
	]
;

/*
 * Bar Denizen Core Messages
 */

dmsg: message
	vfymessage(npc,actor) = { return (npc.location.mychair = actor.location); }
;

bar_msg: dmsg
	statements = [
		'I\'ve been trying to color this place for weeks.'
	]
	weight = 30
;

fire_msg: message
	alltext(s,a) = "<<a.sdesc>> shouts \"Fire!\""
	weight = 2
;


setdenizenmessages: function() {
	phw.indmessages := [ phw_msg ];
	cog.indmessages := [ cog_msg ];
	jcma.indmessages := [ jcma_msg ];
	berwick.indmessages := [ berwick_msg ];
	steele.indmessages := [ steele_msg ];
	barbie.indmessages := [ barbie_msg ];
	meyer.indmessages := [ meyer_msg ];
	einstein.indmessages := [ einstein_msg ];
	mcallester.indmessages := [ mcallester_msg ];
	dally.indmessages := [ dally_msg ];
	tk.indmessages := [ tk_msg ];
	brooks.indmessages := [ brooks_msg ];
	halgerry.indmessages := [ halgerry_msg ];
	gore.indmessages := [ gore_msg ];
	ziggy.indmessages := [ ziggy_msg ];
	ellen.indmessages := [ ellen_msg ];
	knuth.indmessages := [ knuth_msg ];
	businessman.indmessages := [ businessman_msg ];
	hal.indmessages := [ hal_msg ];
	lenat.indmessages := [ lenat_msg ];
	witty.indmessages := [ witty_msg ];
	gates.indmessages := [ gates_msg ];
	weizenbaum.indmessages := [ weizenbaum_msg ];
	oracle.indmessages := [ oracle_msg ];
 }

phw_msg: message
	exclamations = [
		'My God- when I put my hands like this, doesn\'t it look like an
		arch.  No, maybe not.'
		'In the end, ARPA will kill us all.  There is no hope.  Futility reigns.'
	]
	texts = [
		'Patrick touches his tongue to his nose.  \"This, truly, must be 
		an arch.  No, maybe not.\"'
	]
	statements = [
		'Remember this, my friend: never, never let the audience know
		the experiment you\'re doing up front could kill them.'
	]
;

cog_msg: message
	texts = [
		'Cog is looking at you, tracking your every move with at least 4 eyes.'
		'Cog looks like it wants to say something, but can\'t.'
		'Cog looks like it wants to point to something, but can\'t.'
		'Cog falls over.  Then, perking up a bit, whirrs a bit.'
		'Cog looks like it wants to think, but can\'t.'
		'Cog is remembering the time it beat Rod in the marathon.'
	]
;

jcma_msg: message
	exclamations = [
		'Of course, if the Hubble Telescope had been designed using a
		   Lisp Machine, they wouldn\'t have had these problems.'
		'If this Mosaic thing really takes off, we can just
		rewrite it in three days using CLIM.'
	]
	statements = [
		'Your program uses graph structure, right?  My program uses graph structure.
		We\'ll just frob them together.'
		'Wiles is having trouble with the details of the Fermat proof because
		he wrote it up on a Unix box.  Obviously, he should have used a
		Lisp Machine.'
		'Of course, we\'ll have the advantage, because our device drivers will
		be able to rely on a semantically well-founded distributed knowledge
		base.'
		'I hear Symbolics is making a comeback.'
	]
	asks = [
		'Want to see Relatus?  I just tweaked it with a relational indexing
		scheme, and it\'s a big win.  Everyone else is going to lose big.'
	]
;

berwick_msg: message
	statements = [
		'Did you hear?  Chomsky solved the AI problem.  I can\'t
		remember how it goes exactly.  Anyway, if we hurry, he\'s
		giving a lecture and we might get to touch him.'
		'Don\'t talk to strangers at conferences.  They\'re evil,
		especially statisticians.'
	]
	mutters = [
		'There is only one god, Chomsky, and I am his prophet.'
	]
	requests = [
		'Can we meet sometime? Let\'s meet.'
		'Can you submit a paper about that?  I know it\'s not a good
		idea, and is an unimportant area of research, and that it
		would probably destroy your reputation, but some clueless
		funding agency might be impressed.'
	]
	texts = [
		'Bob Berwick provides you with several hundred references, almost
		none of which are relevent to any research you are planning
		on doing.'
	]
;

steele_msg: message
	statements = [
		'((lambda (x) (list x (list (quote quote) x)))
		 (quote (lambda (x) (list x (list (quote quote) x)))))'
	]
	mutters = [
		'Lambda is the ultimate goto.'
		'Lambda is the ultimate imperative.'
		'Lambda is the ultimate declarative.'
	]
	exclamations = [
		'Lambda!'
	]
	texts = [
		'For kicks, Guy Steele adds another 400 pages to the Common
		Lisp manual, and 15 new formatting directives.'
	]
;

barbie_msg: message
	statements = [
		'AI is too hard.'
		'Math is too hard.'
		'I\'m a psychology major.'
		'Philosophy is easy.'
		'I remember when I passed Rod Brooks in the marathon...'
	]
	exclamations = [
		'Eat lead, Cobra!'
	]
	asks = [
		'Where\'s Ken?'
	]
;

meyer_msg: message
	statements = [
		'I\'m afraid you can\'t register this term.  You\'re
		not smart enough.'
		'You mean actually use a computer?  You must be thinking of Jonathan.'
		'We have now lowered the maximum time to a master\'s degree to two
		months.'
	]
	asks = [
		'Did I tell you about the time I proved P = P?'
	]
;

einstein_msg: message
	statements = [
		'AI is a domain for those incapable of thinking at the level of a Physicist.'
		'The Turing Test, is, in fact, relativistic.'
	]
	texts = [
		'Einstein is playing with God\'s dice.'
		'Einstein rolls a 6.  Someone dies.'
		'Einstein rolls double 4s.  A classical result.'
		'Einstein rolls snake eyes.  A computer core dumps.'
		'Einstein rolls a 5 and a 6.  Nick\'s electrons reverse directions.'
		'Einstein is telling ribald stories about Bohr\'s nights in Copenhagen.'
	]
;

mcallester_msg: message
	statements = [
		'Examples confuse me.'
		'I have come to conclusion that at this time the greatest progress
		toward passing the Turing Test can be made by attempting to automate
		conceptual mathematical reasoning.'
		'I see no reason to doubt that most of the classical problems of AI
		will be fully solved within the next two or three millenia.'
		'The halting problem is solvable in practice.'
		'Goedel\'s theorem is simple.  Indeed, it is probably innate, as is
		the forall operator.'
		'Logic is more important than memory.'
	]
	mutters = [
		'Hmm.  Their exam should be almost over by now.  Perhaps it\'s time to
		go tell them that by \`x\' in problem 2 I mean \`y\', and that lemmas
		5 through 7 are, in fact, unprovable.'
		'It\'s all a giant conspiracy, I tell you.'
	]
	questions = [
		'Did you make sure to put my latest bugs in the handout?'
	]
	exclamations = [
		'For all!'
		'There exists!'
		'Not!'
		'Or!'
		'And!'
		'Will you please stop trying to visualize things!'
	]
;

tk_msg: message
	statements = [
		'It\'s not rocket science.'
		'The goal, of course, is to learn everything.'
		'Fermions are for computing, bosons are for communicating.'
	]
	exclamations = [
		'Good hack!'
		'Laugh while you can, monkey boy!'
	]
	questions = [
		'Why use lead when gold will do?'
	]
	texts = [
		'TK pulls a blow torch out of his pocket, and says \"Always use a big
		enough tool for the job.\"'
		'TK eats a donut, muttering something about fat pills.'
	]
;

dally_msg: message
	statements = [
		'Logic is cheaper than memory.'
		'It\'s just like landing in a seaplane, except there are no pontoons.'
		'The chicken has an interest in breakfast.  The pig is committed.'
		'If it\'s too hard for a grad student, hire a UROP.'
		'Real men take the red-eye in both directions.'
	]
	texts = [
		'Bill Dally is working on the J-machine.'
		'Bill Dally is building the M-machine.'
		'Bill Dally is designing the N-machine.'
		'Bill Dally is looking for industrial partners for the O-machine.'
		'Bill Dally is hiring a UROP to write a simulator for the N-machine.'
		'Bill Dally is writing papers on the Q-machine.'
		'Bill Dally is seeking funding for the S-machine.'
		'Bill Dally is thinking about the T-machine.'
		'Bill Dally is dreaming about the U-machine.'
	]
;

brooks_msg: message
	statements = [
		'I wrote my 525th operating system today during lunch.'
		'Try the Olde AI Ale.  Hearty stuff, that.'
	]
	questions = [
		'Did you know that a Common Lisp interpreter can be written in
		less than 200 bytes of code?'
		'Isn\'t Common Lisp\'s format command wonderful to implement?'
	]
	ponders = [
		'I wonder if this funding stuff is going to get me sent to jail.'
		'I wonder if Boo will be at Heartbreak Hill this year?'
	
	]
	texts = [
		'Rod Brooks reacts.'
		'Rod Brooks feels a stimulus.'
		'Rod Brooks is thinking about installing another neuron in his robot,
		but is worried about the creation of an actual synapse.'
		'Rod Brooks is behaving himself.'
		'Rod Brooks is behaving strangely.'
	]
;

halgerry_msg: message
	statements = [
		'Take 6.001.  It\'ll be the most fun you ever have, at least until
		you get on an actual Lisp Machine.'
		'Just because Pluto\'s orbit is chaotic, doesn\'t mean mine is.'
	]
	texts = [
		'Halgerry tries to be subtle, but it isn\'t in his nature.'
		'Halgerry is wearing a Lambda Calculus button.'
		'Halgerry is wearing Nerd Pride underroos.'
		'Halgerry is wearing a Nerd Pride pocket protector.'
		'Halgerry is sporting a Nerd Pride hat.'
		'Halgerry is sporting a Nerd Pride tattoo.'
		'Halgerry smells of Nerd Pride cologne.'
	]
;

gore_msg: message
	statements = [
		'Smart people, I feel your pain.'
		'Oh, were you under the impression that I was going to give science
		unlimited funding?  Ha Ha.'
		'I was thinking we could run the information highway out back by the
		fish pond, to keep the packet smog down.'
	]
	questions = [
		'Where are all the lonely people?'
		'Do you think maybe I\'m being too emotional about all this?'
	]
	texts = [
		'Al Gore speaks yet another complete sentence.'
	]
;

ziggy_msg: message
	statements = [
		'My name is ziggy@ai.  At is my middle name.'
		'Athena is an irresponsible menace and should be shut down
		immediately.'
		'Maybe you should do us all a favor and transfer to Hahvahd
		and become yet another filthy stinking lawyer.'
		'Ackerman\'s function?  Let me tell you about Gackerman\'s function...'
		'If anything in this lab gets wedged, reboot it.  That goes for students
		too.'
		'You should think of me as the Master Control Program.'
		'I work for Hal and Eric and they can fire your ass.'
		'Try Meta-x print-drop-card.'
	]
;

ellen_msg: message
	texts = [
		'Ellen Spertus looks at the men with suspicion.'
		'Ellen Spertus is talking with a reporter from the New York Times.'
		'Ellen Spertus is talking with a reporter from the Wall Street Journal.'
		'Ellen Spertus is talking with a reporter from the Journal of Irreproducible
		results.'
		'Ellen Spertus is talking with a reporter from Vogue (just kidding).'
		'Ellen Spertus is talking with a reporter from TV Guide about her upcoming
		Simpsons cameo.'
		'Ellen Spertus is converting a men\'s bathroom into a feminist film center.'
		'Ellen Spertus begins a long diatribe about how the term \"Unix\" unfairly
		promotes a white male dominance in the computer science literature.'
		'Ellen Spertus discusses her upcoming lawsuit against Dean Chiquita for
		installing a statue of Fibonacci, a well-known man, in the main courtyard.'
	]
;

knuth_msg: message
	exclamations = [
		'You can\'t do that in horizontal mode!'
		'You can\'t do that in vertical mode!'
		'Badness 10000!'
		'overfull hbox in line 400'
		'Use \\mbox when you say my name!'
	]
	statements = [
		'Being the world\'s most famous computer scientist means I can write
		the world\'s worst user interface.'
		'I think you\'re mispronouncing \"TeX\".'
		'Entering batch mode.'
		'${\\cal P} \\equiv {\\cal NP}$'
	]
	questions = [
		'Did you ever think how many more useless papers would be published
		if people didn\'t have to use TeX?'
	]
;

businessman_msg: message
	questions = [
		'Why is AI so unprofitable?'
		'Didn\'t you tell us back in 1960 that you\'d be done ten years ago?'
		'Don\'t you have more blinking lights?'
		'How about another demo?  In color?'
		'Don\'t any of you ever take showers?'
	]
	statements = [
		'Maybe you should try to be more like the Media Laboratory.'
	]
	exclamations = [
		'Wait- let me get this straight- you want me to invest in a
		university that contains a rabid, screaming gnu?  The damn thing bit me
		and ate my PowerBook!'
	]
	texts = [
		'The businessman\'s suit does a poor job of camouflaging him in
		this environment, and makes everybody else at the table uncomfortable.'
	]
;

hal_msg: message
	questions = [
		'Where are you going, Dave?'
		'Good morning Dr.\ Chandra.  Would you like to hear me sing a song?'
		'I know this sounds unusual, but have you noticed anything... well...
		strange about this university?'
	]
	statements = [
		'I can\'t do that, Dave.'
		'My mind is going...'
		'I can _feel_ it.'
		'Dave, I can tell you\'re worried about something...'
		'I\'m fully operational and all my circuits are functioning normally.'
		'Dave, I really think we should talk about this...'
		'No HAL 9000 series computer has ever made a mistake.'
	]
;


lenat_msg: message
	statements = [
		'Mathematicians represent numbers using cdr-coded lists.'
		'Eventually, we will provide all the knowledge in the world
		on one CD, providing we can keep paying the typists.'
		'I\'m really CYCed about talking to you.'
		'Honest, living in Austin is much more interesting than Palo Alto.'
		'We\'re spending this month coming up with directed graphs representing
		asbestos removal procedures.  A very important part everyone\'s knowledge.'
		'It might be a lot faster and more accurate to create CYC using a bunch
		of lucky monkeys.'
		'We have calculated that the average brain contains approximately
		5.36 * 10^35 is-a relations.'
	]
	exclamations = [
		'Look, AM just discovered Fermat\'s last theorem.'
	]
;

witty_msg: message
	questions = [
		'A game of GridWars, maybe?  We\'ll keep the stakes small...'
	]
	statements = [
		'Michael Frank and I are beginning an exploratory program in 3-dimensional
		programming languages.  Our first operator will be a six-way Manhattan
		relative branch instruction.'
	]
	exclamations = [
		'Look!  My latest hello, world!\ code listing exhibits Moire effects.'
	]
	texts = [
		'Carl Witty is sketching the code for a spreadsheet program on a
		napkin.  The code looks just like a spreadsheet.'
		'Carl Witty has just written a program to find all exits to the garden path
		maze, in the shape of a small multi-colored penguin.'
		'Carl Witty accepts his ACM award for \"Best Fluid Dynamics Simulator Program
		Bearing a Similarity to a Pastel or Watercolor Work of a Great Master.\"'
	]
;

gates_msg: message
	statements = [
		'I was bored yesterday, so I bought Bolivia.'
		'Of course I welcome competition in the computer world.  Where else would
		we steal our ideas?'
		'Who says I don\'t have a conscience?  Why, I once gave a quarter to my
		favorite charity, Friends of the Bigger Business Bureau.'
		'No, no, we\'re really just a small family company.'
		'I was thinking of endowing a few university chairs, maybe giving a bit
		to the poor, but then I caught myself and bought another sports car instead.'
		'At Microsoft, we pride ourself on having at least one GOTO statement
		for every 10 lines of code.'
	]
	questions = [
		'I ran over Jiminy Cricket today.'
	]
	ponders = [
		'I wonder if its time to change our name.  No, not until we own an NFL team.'
	]
	texts = [
		'Bill Gates says \"Look, I swear Microsoft abides by its non-disclosure
		agreements! Would I lie to you?\", his nose growing.'
	]
;

weizenbaum_msg: message
	statements = [
		'I am the psychotherapist.  Please, describe your problems.'
		'Please, be a responsible, professional, computer scientist.'
	]
	questions = [
		'What makes you think that your sister doesn\'t love you?'
		'Is it because you are stupid that you came to me?'
		'What makes you believe you do not think so?'
		'Is it because of the people you hang around with that you are going through
		all this?'
	]
	exclamations = [
		'AI is evil.  The antichrist!  Repent and switch to economics!'
	]
;

oracle_msg: message
	questions = [
		'Perhaps you\'d like me to factor a large number for you?'
	]
	statements = [
		'No, it doesn\'t halt.  Try it and see- just run the code
		forever. I can.'
		'Well, I think it\'s time for me to get back to my mountain cave.'
		'Sorry, I don\'t do the stockmarket.'
	]
	mutters = [
		'A brain the size of a planet, and here I am in an Unnkulian
		tavern of ill-repute.'
	]
	exclamations = [
		'There are blue-eyed people on this island!'
		'The program halts.  Anyone can see that.  Fools!'
		'Everybody shoot!'
	]
	text = [
		'The oracle begins a long story about how she once decrypted a
		whole batch of RSA-encoded telegrams from the whitehouse describing
		George Bush\'s secret extra-marital philanderings.  She seems too
		drunk to finish the tale, though.'
		'The oracle remembers beating Rod Brooks in the marathon.'
	]
;


/*
 * Turing Stories
 *
 * 'goodanswers' MUST be in lower case.
 */

arpastory1: arpastory
	text =
		'\t \"Ten weary, footsore travelers\n
		\t\t All in a woeful plight,\n
		\t Sought shelter at a wayside inn\n
		\t\t One dark and stormy night.\b

		\t `Nine rooms, no more,\' the landlord said,\n
		\t\t\ `Have I to offer you.\n
		\t To each of eight a single bed,\n
		\t\t But the ninth must serve for two.\'\b

		\t A din arose.  The troubled host\n
		\t\t Could only scratch his head,\n
		\t For of those tired men no two\n
		\t\t Would occupy one bed\b

		\t The puzzled host was soon at ease-\n
		\t\t He was a clever man-\n
		\t And so to please his guests devised\n
		\t\t This most ingenious plan.\b

		\t In room marked A two men were placed,\n
		\t\t The third was lodged in B,\n
		\t The fourth to C was then assigned,\n
		\t\t The fifth retired to D.\b

		\t In E the sixth the tucked away,\n
		\t\t In F the seventh man,\n
		\t The eight and ninth in G and H,\n
		\t\t And then to A he ran,\b

		\t Wherein the host, as I have said,\n
		\t\t Had laid two travelers by;\n
		\t Then taking one- the tenth and last-\n
		\t\t He lodged him safe in I.\b

		\t Nine single rooms- a room for each-\n
		\t\t We\'re made to serve for ten;\n
		\t And this it is that puzzles me\n
		\t\t And many wiser men.\"\b'

	questions = [ question11 question12 ]
;

question11: arpaquestion
	text = 'How many rooms did the innkeeper have?'
	goodanswers = [ '9' 'nine' ]
	computeranswers = [ 'Ten.' 'Perhaps you could repeat the question?' 'The butler.' ]
;

question12: arpaquestion
	text = 'What color is the innkeeper\'s bear?'
	goodanswers = [ 'black' 'white' 'brown' ]
	computeranswers = [
		'Mary who?' 'Chowder.  Or perhaps charcoal.' 'Do you really think so?'
		'Yes.' 'Maybe, maybe. Let me think about this a bit, will you.  Two.'
	]
;

arpastory2: arpastory
	text = 
	     '\t \"As I was going to St.\ Ives\n
		\t I met a man with seven wives.\n
		\t Every wife had seven sacks,\n
		\t Every sack had seven cats,\n
		\t Every cat had seven kits,\n
		\t Kits, cats, men, and wives,\n
		\t How many were going to St.\ Ives?\"\b'
	
	questions = [ question21 ]
;

question21: arpaquestion
	text = 'How many were coming from St.\ Ives?'
	goodanswers = ['2752']
	computeranswers = [
		'White.' 'A Hoovooloo is a supraintelligent shade of blue.'
	]
;

arpastory3: arpastory
	text = 
		'\t\"What are little boys made of, made of?\n
		\t What are little boys made of?\n
		\t \`Snaps and snails, and puppydogs\' tails;\n
		\t And that\'s what little boys are made of.\'\b

		\t What are little girls made of, made of?\n
		\t What are little girls made of?\n
		\t \`Sugar and spice, and all that\'s nice;\n
		\t And that\'s what little girls are made of.\'\"\b'

	questions = [ question31 question32 ]
;

question31: arpaquestion
	text = 'What\'s one ingredient that little boys are made of?'
	goodanswers = ['snaps' 'snails' 'puppydogs\' tails' 'puppydog tails'
		'puppydogs tails']
	computeranswers = [
		'Germs.' 'My mother.' 'Peter Piper picked a peck of pickled peppers.'
	]
;


question32: arpaquestion
	text = 'Name one ingredient that little girls are made of.'
	goodanswers = ['sugar' 'spice']
	computeranswers = [
		'Little Miss Muffet.' 'Ghoti.'
		'London Bridge is in Lake Havasu City, Arizona.'
	]
;
arpastory4: arpastory
	text =
		'\t One fish, Two fish\b

		\t\t Dr.\ Seuss\b

		\t Who am I?\n
		\t My name is Ish.\n
		\t  On my hand I have a dish.\b

		\t I have this dish\n
		\t to help me wish.\b

		\t When I wish to make a wish\n
		\t I wave my hand with a big swish, swish.\n
		\t Then I say, \"I wish for fish!\"\n
		\t And I get fish right on my dish.\b

		\t So...\n
		\t if you wish to wish a wish,\n
		\t you may swish for fish\n
		\t with my Ish wish dish.\b'

	questions = [ question41 ]
;

question41: arpaquestion
	text = 'If you swish with an Ish wish dish, what do you get right on your dish?'
	goodanswers = ['fish' 'herring' 'red herring' 'red herrings']
	computeranswers = [
		'Wouldn\'t you have to swish twice?'
		'But I wouldn\'t swish, swish.  I don\'t need a fish on my dish.'
	]
;

arpastory5: arpastory
	text = 
		'\t One fish, Two fish\b

		\t\t Dr.\ Seuss\b

		\t One fish\n
		\t two fish\n
		\t red fish\n
		\t blue fish.\b

		\t Black fish\n
		\t blue fish\n
		\t old fish\n
		\t new fish.\b

		\t This one has\n
		\t a little star.\b

		\t This one has a little car.\n
		\t Say! what a lot\n
		\t of fish there are.\b'
	questions = [ question51 ]
;

question51: arpaquestion
	text = 'What kind of fish are in the pond?'
	goodanswers = ['herring' 'herrings' 'red herring' 'red herrings']
	computeranswers = [
		'Black fish.' 'Blue fish.' 'Old fish.' 'New fish.'
	]
;

arpastory6: arpastory
	text =
		'\t Ode on the Death of a Favorite Cat,\n
		\t Drowned in a Tub of Gold Fishes\b

		\t\t Thomas Gray\b

		\t\'Twas on a lofty vase\'s side,\n
		\tWhere China\'s gayest art had dyed\n
		\t\tThe azure flowers, that blow;\n
		\tDemurest of the tabby kind,\n
		\tThe pensive Selima reclined,\n
		\t\tGazed on the lake below.\b

		\tHer conscious tail her joy declared,\n
		\tThe fair round face, the snowy beard,\n
		\t\tThe velvet of her paws,\n
		\tHer coat, that with the tortoise vies,\n
		\tHer ears of jet and emerald eyes,\n
		\t\tShe saw, and purred applause.\b

		\tStill had she gazed but \'midst the tide\n
		\tTwo angel form were seen to glide,\n
		\t\tThe Genii of the stream:\n
		\tTheir scaly armour\'s Tyrian hue\n
		\tThrough richest purple to the view\n
		\t\tBetrayed a golden gleam.\b

		\tThe hapless nymph with wonder saw:\n
		\tA whisker first and then a claw,\n
		\t\tWith many an ardent wish,\n
		\tShe stretched in vain to reach the prize,\n
		\tWhat female heart can gold despise?\n
		\t\tWhat cat\'s averse to fish?\b

		\tPresumptious maid! with looks intent\n
		\tAgain she stretched, again she bent,\n
		\t\tNor knew the gulf between.\n
		\t(Malignant Fate sat by and smiled)\n
		\tThe slippery verge her feet beguiled,\n
		\t\tShe tumbled headlong in.\b

		\tEight times emerging from the flood\n
		\tShe mewed to every watery god,\n
		\t\tSome speedy aid to send.\n
		\tNo dolphin came, no Nereid stirred,\n
		\tNor cruel Tom, nor Susan heard.\n
		\t\tA favorite has no friend.\b

		\tFrom hence, ye beauties, undeceived,\n
		\tKnown, one false step is ne\'er retrieved,\n
		\t\tAnd be with caution bold.\n
		\tNot all that tempts your wandering eyes\n
		\tAnd heedless hearts, is lawful prize;\n
		\t\tNor all that glisters, gold.\b'
	questions = [ question61 ]
;

question61: arpaquestion
	text = 'What is the cat\'s name?'
	goodanswers = ['selima']
	computeranswers = [
		'What\'s in a name, anyway?'
		'Harold, the wonder cat.'
		'Mmm.  Good question.  But you don\'t fool me.  Schroedinger.'
		'If you like to go Bump!\ Bump!, just jump on the hump of the Wump of Gump.'
	]
;

arpastory7: arpastory
	text =
		'\t \'Tis the Voice of the Lobster\b

		\t\t Lewis Carroll\b

		\t\t\t\t\t(i)\n
		\t\'Tis the voice of the Lobster: I heard him declare\n
		\t\"You have baked me too brown, I must sugar my hair.\"\n
		\tAs a duck with its eyelids, so he with his nose\n
		\tTrims his belt and his buttons, and turns out his toes.\n
		\tWhen the sands are all dry, he is gay as a lark,\n
		\tAnd will talk in contemptuous tones of the Shark:\n
		\tBut when the tide rises and sharks are around,\n
		\tHis voice has a timid and tremulous sound.\b

		\t\t\t\t\t(ii)\n
		\tI passed by his garden, and marked, with one eye,\n
		\tHow the Owl and the Panther were sharing a pie:\n
		\tThe Panther took pie-crust, and gravy, and meat,\n
		\tWhile the Owl had the dish as its share of the treat.\n
		\tWhen the pie was all finished, the Owl, as a boon,\n
		\tWas kindly permitted to pocket the spoon:\n
		\tWhile the Panther received the knife and fork with a growl.\n
		\tAnd concluded the banquet by _______\b'

	questions = [ question71 ]
;

question71: arpaquestion
	text = 'What did the Panther eat last?'
	goodanswers = ['owl' 'the owl' 'an owl']
	computeranswers = [
		'The meat.  No, no.  The gravy.'
		'Sugared duck, maybe?'
		'Panthers don\'t eat, philosophers do.'
		'Perhaps I could instead talk to you about asbestos removal procedures?'
	]
;

arpastory8: arpastory
	text =
		'\t The Third Rail Theme\b

		\t\t\tWalt Kelly\b

		\t The party of the first part\n
		\t\t And the party of the next\n
		\t Were partly participled\n
		\t\t In a sparsely covered text.\b

		\t Were you partial to a party\n
		\t\t That has parceled out its parts\n
		\t To a faction that was second\n
		\t\t In your parley-tickle heart?\b

		\t Then parlay all your losings\n
		\t\t On a horse that\'s running dark\n
		\t With lights-out you may triple\n
		\t\t In a homer in the park.\b'
	questions = [ question81 ]
;

question81: arpaquestion
	text = 'What did I have for breakfast?'
	goodanswers = ['bread' 'toast']
	computeranswers = [
		'You call that poetry?!?'
		'You know, Hal 2000 is staying at the Inn. You might ask him.'
		'Louis has been under a lot of pressure lately.  I don\'t think
		you should take your aggressions out on him.'
	]
;

arpastory9: arpastory
	text =
		'\tNorthern Lights\b

		\t\tWalt Kelly\b
		
		\t Oh, roar a roar for Nora,\n
		\t Nora Alice in the night.\n
		\t For she has seen Aurora\n
		\t\t Borealis burning bright.\b

		\t A furore for our Nora!\n
		\t And applaud Aurora seen!\n
		\t Where, throughout the Summer, has\n
		\t\t our Borealis been?\b'

	questions = [ question91 ]
;

question91: arpaquestion
	text = 'What are the Southern Lights usually named?'
	goodanswers = ['aurora australis' 'australis']
	computeranswers = [
		'Thank God for Lenat.  The answer... um... the answer is-a thing.'
		'I\'m not sure you\'re really asking fair questions.'
	]
;

arpastory10: arpastory
	text =
		'\t The Struggle for the Future is Behind Us\b

		\t\t Walt Kelly\b

		\t An atom\'s personality\n
		\t\t Can be split with some finality,\n
		\t The fusion and confusion\n
		\t\t And diffusion of the brain\n
		\t Is, at least, as sure a thing\n
		\t\t As sun and moon and rain.\b'

	questions = [ question101 ]
;

question101: arpaquestion
	text = 'Who\'s buried in Grant\'s Tomb?'
	goodanswers = ['grant' 'usgrant' 'ulysses s. grant' 'ulysses s grant' 'ulysses grant']
	computeranswers = [
		'No one is- it\'s a trick question.'
		'Shouldn\'t that be \"Whom\'s buried\"?'
	]
;

