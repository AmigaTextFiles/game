#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Official errata:
 Initial introduction paragraph, first choice is supposed to be PARA 10, not PARA 2.
 Paragraph 5: "if you decide to try further magic, return to the Magic Matrix for paragraph 34" not 21.
*/

MODULE const STRPTR wc_desc[WC_ROOMS] = {
{ // 0
"INTRODUCTION\n" \
"  It was bound to happen, you muse as you half-heartedly shove the moth-eaten mop over the cold, seemingly endless stone floor. Still, after three years of apprenticeship, you were beginning to wonder if the old goat would *ever* leave. Sure, he'd left once or twice before, but only to borrow a cup of wolfsbane, or try out a new flying carpet. And he'd always managed to find some endless task for you just before he left. Be just like him to cast a spell on the floor to *really* make it endless.\n" \
"  You dunk the mop in the bucket, ignoring its struggles, and steal a glance at your master's familiar. The blue ferrid, a sort of furred snake-lizard, opens one eye and yawns, exposing long, sharp fangs. The yawn changes to an unpleasant smile as you catch its eye, and get a vision of the wizard feeding smoking-hot slivers of you to the beast.\n" \
"  You break eye contact, trying to control your shudders. Because of their minor magical talents, ferrids make good familiars. Such good familiars, in fact, that their masters tend to overlook some of their other traits, including an intense hunting instinct and a truly malicious sense of humour. You've found it best not think too loud or long about your master in its presence. In fact, you prefer not to do *anything* in its presence, but that's not always possible. Unfortunately, at least for your ego, your master insists that the miserable snake-on-lizard's-legs be present whenever you practice your spells. Never mind your complaints about the way it snickers when things go a little wrong. Okay, a whole lot wrong. Or that the way it has of picking its all-too-pointy teeth with its claws plays havoc with your concentration. \"Thinking under pressure is good for you,\" is all your master would say, as he scratched the brute's small furry ears. Hmmph. You glance over at the beast again. Roughly as tall as a medium-sized dog, you figure that its soft dense pelt would be just the right size for a nice bedside rug. Or something to stretch out on in front of a fire.\n" \
"  The object of your regard opens both eyes, and fixes you with a calculating stare. The kind of look a tiger gives a fawn when it's just starting to think about what's for dinner. Your comfortable thoughts of plush ferrid-hide rugs change to a picture of the ferrid lounging on a rug made of you, complete with head. You look quickly away, shoving the mop into the floor so hard that it squeals in protest.\n" \
"  The ferrid settles back down and resumes its nap. You ease up on the mop, and continue on at a more regular pace. Back and forth, making sure to get all the cracks, nooks and crannies as you go. You mop your way around the corner, keeping a cautious eye/ear out for the beast. Silence. You mop a bit further. Still silence. Good! You know that Servald, your master, will be gone for at least a week, since he is attending the Triennial Conjurers' Convention. Now's your chance to explore all those things he never let you mess with. Let's see. There's that secret room at the end of the eastern corridor (go to {10}). Or his private study - you think you can manage the lock (go to {21}). If not, there's always that door in the dungeon from which those strange noises come (go to {182}). You rinse the mop off and set it carefully against the wall. Now for adventure!"
},
{ // 1
"The statue is made of the purest obsidian and carved with extreme attention to detail. It is approximately 3' tall and depicts the ugliest dwarf you've ever seen (not that you've seen that many. And they were pictures, not in the flesh. But it's *still* ugly). Its expression is one of malicious amusement, which doesn't add a thing to its looks. The vial itself is made of crystal and closed with a faceted crystal stopper. When you gently touch the surface of the vial, you find that it is cool and loose enough to be removed from the statue's hand without too much trouble. If you take the vial, go to {22}. If you let well enough alone and explore the curtained doorway, go to {68}."
},
{ // 2
"As you start to step inside, you find out just how slippery tile can be. Whoops! Make a L1-SR on Luck (20 - LK). If you are successful, you regain your balance and go to {32}. If not, go to {26}."
},
{ // 3
"The statue crushes you to its chest. Each breath you take feels like a tongue of flame, and the time between those breaths is getting longer mighty fast. There's time for one last spell. For your sake, it better be a good gone. Go to the Magic Matrix."
},
{ // 4
"The room ceases its spinning. Wow, that stuff's got quite a kick. No wonder old Servald likes it. In fact, you feel better than you have in a long time. If your Strength was down, it's now back to normal. Even if it wasn't, you also gain 1 point to your CON. Maybe mum was right about the benefits of eating well. You return the stoppered, but now empty vial to the statue. There's only the curtained doorway left to inspect. Go to {28}."
},
{ // 5
"The door is still locked. The lock opens an eye and sneers at you. \"Aw, come on! Can't you do better than that?\" You reply that it was a perfectly good spell and should have worked. \"Uh-uh,\" the lock says, \"you forgot the magic word and I won't let you in without it!\" If you wish to talk further with this none-too-bright lock, go to {25}. If you decide to try further magic, return to the Magic Matrix for paragraph {34}. If non-magical methods are your choice for getting past the lock, make a L2-SR on DEX (25 - DEX). If you make it, go to {196}. If not, go to {206}." \
},
{ // 6
"You walk around the structure, noting that the door will fit neatly flush with the side of the structure when closed (the thick section fills the opening, while the thinner extension allows for a good seal). Peering in, you see a 2' deep circular pit (8' diameter) in the structure's centre. It is surrounded by a 1½' wide ledge at the same level as the top step of the dais. From the centre of this pit rises a fountain sculpted from 6 long (5') metal sections. Each section is 2' wide and gently arches over the ledge. What is this thing, you wonder, some sort of sauna or tub where your master comes to enjoy a nice glass of juice and soak his old bones? After the state of the dwarf, the metal 'fountain' looks positively lovely. If you step inside for a closer look, go to {2}. If you would rather look over the rest of the chamber, go to {30}."
},
{ // 7
"The conversation starts slowly, but you soon find the skull to be rather witty and well worth talking to, if a bit condescending. You also learn a few amusing tidbits about your master (he does *what* at those conventions?! No wonder he seems tired when he gets back). It does occur to you that the skull might know something about the other magical items in the room, so you ask it. The skull stiffens and a glazed look enters its sockets as it replies:\n" \
"  \"Age and wisdom oft go hand in hand,\n" \
"  And travel, too, may broaden what you know.\n" \
"  A source of wisdom you may find the tome\n" \
"  For in it  many pearls of wisdom glow.\n" \
"  Curtains veil a plane within a pane,\n" \
"  Sufficient to itself, and yet beyond\n" \
"  Does lie another plane, both foul and fair.\n" \
"  The three alike by magic held in bond.\n" \
"  One may see with more than just the eye,\n" \
"  And see abominations and delight\n" \
"  Or, with a sure swift glance, call to one seen\n" \
"  By hawk-surpassing crystal-aided sight.\"\n" \
"  The skull falls silent and will say no more. If you decide to use your new knowledge to examine: the tome, go to {45}; the curtains, go to {82}; the crystal ball, go to {159}. If you feel you have learned enough for one day, pick up 50 ap and ponder the skull's words as you return to your mop (go to {115})."
},
{ // 8
"Click! You look around, and see that the door to the crystal structure is now closed. You walk back up to the dais, and find that pulling on it does nothing - it remains closed. This may be because it fits tightly into the side of the structure, and you just can't get a good grip on the narrow outer flange. Going back to the pedestal, you see a projection that you think will open it. If you want to try this so that you can explore the inside of the structure on the dais, go to {20}. If you want to push a few more projections, go to {39}."
},
{ // 9
"Your eyes are drawn to the beautifully illuminated page before you, and you get a surprise. Your own face is staring back from a border of elaborate design. Fascinated, you lean closer, the better to see the incredible detail of the picture. Like a sparrow gazing into the eyes of a snake, you are mesmerized, unable to look away. As you watch, your face ages, slowly at first, then more rapidly. Your knees grow weak, and you slump forward onto the picture as the spell takes effect. Soon there is nothing to see but a dried, wizened body clutching the reading stand. There is no strength to its hold, and it turns into dust, which floats silently down and comes to rest in a pile at the stand's foot. The tome closes, sending up a small puff of dust, some of which was an over-curious apprentice. For you, this adventure has reached the end."
},
{ // 10
"You sneak cautiously through the halls (no telling what might be slithering around) until you reach the end of the eastern corridor, pull back a tapestry and expose the door, which is undistinguished save for silver runes etched on its oak surface. You know they're silver because you've polished them often enough. They read either 'Golden Dew Pool' or 'Go Back, You Fool'. You're not sure which, but you suspect the latter. Just why this spellroom is off-limits you've never been able to figure out. You don't even know if the runes on the door have anything to do with what's behind it. Servald likes a bargain as well as the next tight-fisted wizard and he may have picked the door up cheap at a sale. Still, you've never been on the other side of it, and that's reason enough to enter. However, your master often has very good reasons for what he does. If you decide to try the study after all, go to {21}. If the door of strange noises is more to your liking, go to {182}. If you want to open the eastern corridor door anyway, go to {15}."
},
{ // 11
"No wonder the room spun. You've been grabbed by the dwarf. \"Not so fast, youngling,\" it chortles. The magic vibes it's giving out are rather nasty, so you suspect it isn't interested in your welfare. As its smile widens and its grip tightens on you, you realize that if you don't get loose, and soon, you'll be juice yourself. If you try a spell to free yourself, go to the Magic Matrix. If you try brute force, make a L2-SR on ST (25 - ST). If you succeed, you break free. Go to {18}. If you fail by less than 5, make a L1-SR on LK (20 - LK). If you succeed at this his grasp slips and you wiggle out of it. You hit the floor running and don't stop 'til you reach your mop. Go to {260}. If you fail the Strength roll or the Luck roll by 5 or more, go to {3}."
},
{ // 12
"Your stomach does a last flip-flop and lies quivering. As well it might, for you are now standing in front of a sharp-eyed old man with a full, neat beard - your master, Servald. Oops. You smile weakly and shrug. Servald raises his eyebrows a bit and remarks, \"As long as you're here, you might as well be of use.\" A wave of his hand converts you into a hassock, which he pulls up to his chair and props his feet on. The others in the room take no notice of the incident. You will remain as such until the end of the convention. Upon your master's return home, you will be changed back and lectured concerning the fruits of meddling with things of which you know nothing. Pick up 100 ap, gain 1 IQ point, and consider your adventure at an end."
},
{ // 13
"Click! You rush to the door and find it closed. Peering through the crystal, you see a smiling ferrid reach up and press a projection on the pedestal. The fountain sections swing down as they rapidly begin to spin. They look remarkably like blades. Chopchopchopchiirrrrr. That's it for you."
},
{ // 14
"You muster all the power of your mind, all the sparkle of your charisma, and all the luck you can lay claim. If the sum of this force (IQ + CHR + LK) exceeds 34, go to {18}. If it is less, go to {48}."
},
{ // 15
"This may be your only chance to see what waits beyond, and you're going to take it. To your surprise, the door is unlocked. You cautiously open it, and wait. Nothing leaps out at you. You walk in, and are immediately aware of three things: 1) You sense an increase in the ambient level of magic; 2) You see a circular room (25' diameter) with a doorway partially curtained off to your left; 3) In the centre of the chamber you see an obsidian statue. It is a statue of a dwarf and is holding a vial of orangish liquid in its outstretched right hand. A very ugly dwarf. If you want to inspect this attempt at art more closely, go to {1}. If you ignore the statue and go to inspect the curtained doorway, go to {28}."
},
{ // 16
"You walk up onto the dais and around the structure. Roof, walls and door are of frosted crystal. Peering inside, you see a 1½' shelf of stone around the base of the wall at the level of the dais. This surrounds a 2' deep circular pit that is 8' in diameter in the structure's centre. From this pit rises a 'fountain' composed of six 5' long metal sections. Each section is 2' wide and arches gently upward. The whole thing smells faintly of fruit. Aah! You have it! \"It's a sauna,\" you think. \"Old Servald must lie in here with a glass of his favourite juice for relaxation.\" If you want to take a closer look at the fountain, go to {2}. If you'd rather return to the statue, go to {1}. If the mop is more to your liking, go to {260}."
},
{ // 17
"You place your hand in the demon's and step into the glass. After a moment's disorientation, you realize that neither beach, booze, nor companions are to be found. Instead, you are floating in a multicoloured void. When you turn to look out at the study, the demon grins, waves, and vanishes with a \"Thanks, fool!\" Worst of all, it closed the curtains almost entirely before it left. When you try to get out of the glass, you find that there is an invisible barrier between you and the study. Since this barrier presumably held the demon, you suspect that your only hope of escape lies in changing places with an unsuspecting person in the study. Or, if you're lucky, your master might notice where you've gone and let you out. Judging from the layers of dust on the windowsill that doesn't seem likely. Still, anything's possible. Make a L3-SR on LK (30 - LK). If you succeed, go to {178}. If you don't, looks like you'll be here for a *very* long time. You've been had."
},
{ // 18
"The first thing you notice as you stagger back is that the statue isn't following. No doubt it would like to, but it seems to be fixed in place. All it can do now is make rude gestures and insulting noises. As long as you stay out of reach, you're safe (you hope). If you go back to mopping the floor, go to {260}. If you stay, you decide to explore the curtained doorway. \"You'll be sorry,\" taunts the statue, but you ignore it. Go to {28}."
},
{ // 19
"A massive force presses down on you. Every breath is harder to draw than the last, and if you don't get free soon, it *will* be your last. You draw upon all your strength in a desperate attempt to break free. Make a L2-SR on Strength (25 - ST). If you succeed, go to {36}. If you fail, go to {57}."
},
{ // 20
"You push the projection marked 'open', and the structure's door does just that. You walk over and step inside. Walking up to the metal fountain, you notice the incredible edge on its sections. Make a L2-SR on Dexterity (25 - DEX). If you are indeed agile (not to mention lucky) go to {32}. If you fail, go to {13}."
},
{ // 21
"The door to the study lies at the top of the longest, shakiest spiral staircase you've ever seen. But, you remind yourself, you've come here for adventure, not to criticize the structural integrity of the architecture. You set one foot on the bottom step and start your ascent. At first, you blame the shuddering of the steps on poor workmanship. As you climb higher, you're not so sure. There's conscious effort behind its attempts to throw you off. And your stomach isn't too happy, either. If you decide to let the study alone, and try your fortune elsewhere, go to {10} (if the secret room in the eastern corridor is your choice) or {182} (if you prefer the door of strange noises). If you are dead-set on reaching the study, make a L1-SR on Dexterity (20 - DEX). If you succeed, go to {34}. If you fail, you lose your balance and fall (go to {190})."
},
{ // 22
"You grab the vial, unstopper it, and carefully sniff. It smells rather like the strange southern fruits your master likes to eat chilled with breakfast. Occasionally, he squeezes them and enjoys their juice. Since those fruits are expensive, you suspect that you've found a secret cache of that very juice, which you've always wanted to taste. Surely he wouldn't use his favourite drink in a potion? You drain the vial. Or...would he? The room certainly wasn't spinning like this before you took your drink. Roll 1d6. If you roll 1 or 2, go to {4}. If 3 or 4, go to {11}. If 5 or 6, go to {19}."
},
{ // 23
"You step cautiously inside and feel one of the metal sections. Ouch! It's extremely sharp. Make a L2-SR on Dexterity (25 - DEX). If you are successful, go to {32}. If not, go to {40}."
},
{ // 24
"You experience extreme disorientation, to the dismay of your stomach. This makes the trip up the stairs look like a piece of c-...er, as easy as p-...Oh, just forget the food references. Your poor, abused stomach isn't up to it. Roll 1d6. If you get 1-3, go to {29}. If 4-5, go to {12}. If 6, go to {27}."
},
{ // 25
"\"What is the magic word?\" you ask, feigning innocence. \"Why, it's pl- hey! I can't tell you that!\" It squints at you, and a worried expression crosses its face. \"Say, if you're ol' Servald, you sure look different. Hmmmmm.\" The lock pauses suspiciously. You have no idea what it will do when it realizes you aren't Servald, and you have no desire to find out. If you wish one more attempt at magic to solve this, return to the Magic Matrix for paragraph {34}. If you decide to pick the lock, make a L2-SR on Dexterity (25 - DEX). If it succeeds, go to {196}. If it fails, go to {206}."
},
{ // 26
"You stumble inside, catching yourself on the floor in time to avoid the pit and stop with your face just inches from the metal sculpture. Wow, that sculptor sure put an edge on those metal sections. In fact, most knives you've seen don't have that good an edge. Click! You spin around, but the door has already closed. As you press against it, you see the ferrid smile toothily beside the pedestal as it presses a projection marked 'puree'. The fountain sections start spinning rapidly and swing down as they gather speed. The motion pushes you up and into what you see now are all-to-obviously blades. Wwwhhiirrrr. Looks like Servald will have to find a new apprentice, as you are no longer in any shape to handle even the smallest of tasks, much less the one of cleaning up the mess you've just become. Better luck next time."
},
{ // 27
"You struggle to breathe, but everything seems flat. No matter how hard you try, you just can't draw any air into your hungry lungs. No wonder, for you've been teleported into the page you were reading, and are now merely an embellishment on its lower left-hand corner. The tome closes softly with the faintest of laughs. It's the end for you."
},
{ // 28
"You push the curtain out of the way and step into the chamber. It is also circular (20' diameter), has a tiled floor with an intricate grapevine design, and smells faintly like your master's favourite fruit juice. At its centre is a 10' high circular (10' diameter) structure with walls and roof of frosted crystal. There appears to be something inside it, but you can't make out any details through the frosted crystal. The structure is set on a two-level dais. The floor motif continues up the dais and gets more involved. A door (2½' wide by 5' high), also of frosted crystal, is set in the side nearest you. It is slightly ajar. You notice that the edge of the door becomes thin and extends 3\" further from the outer surface of the door than from its inner surface. Near the wall to your right is a pedestal with many raised projections on its topmost surface. If you wish to examine the crystal structure, go to {6}. If you prefer the pedestal, go to {62}."
},
{ // 29
"It takes you a while to calm your stomach and reorient yourself, for you are now standing in total darkness. When you are able to act, you stretch out your hand and touch wood - a door. A firmly locked door, from which absolutely *no* magic vibes come. You hear a strange gibbering behind you, and realize at last where you are...*behind* the door of strange noises. From your master's hints, you remember that this door is impervious to magic. You turn slowly to face the noise. Go to {135}."
},
{ // 30
"You wander around the chamber, admiring the tile work and, other than the aforementioned pedestal, find nothing else of interest. Going over to the pedestal, you note that it is waist high, and that its top surface contains a group of 20 or so crystal projections. Each projection has an inscription neatly written beneath it in common tongue. Most say things like 'shred', 'chop', or 'puree'. There is a small bronze plate on the left side of the pedestal with 'Trollworks, Inc. Pat. pend.' engraved on it. If you want to fiddle with the projections, go to {35}. If you'd rather check out the inside of the crystal structure on the dais, go to {2}. If you wish to return to your mop, go to {260}."
},
{ // 31
"At the last moment, you wiggle free of the ferrid's jaws, leaving a bit of skin and fluff behind. Spying a large crack in the wall, you dodge into it. It's not much, but it saves you from the ferrid's jaws long enough for Servald to come home and set things right. He calls the beast off and you get healed, lectured, and sent back to your mop. Pick up 75 ap and resume mopping."
},
{ // 32
"You catch a flash of movement out of the corner of your eye and leap for the door. You get pinched a bit, but make it outside just in time to see the ferrid grin at you from beside the pedestal and vanish. That was close. If you want to go back and look at the statue, go to {1}. If you're finished with the whole thing, go to {260}."
},
{ // 33
"The ferrid's smile gets bigger and nastier. Then it vanishes, reappears at the bottom of the stairs and slinks off. You find out what it was smiling about when your master returns and seems to have full knowledge of all you've done in his absence. As punishment, you're put on short rations for a week, and have the new task of tending the ferrid. Pick up 100 ap for the adventure, and get to work."
},
{ // 34
"You keep both your balance and the contents of your stomach and reach the top of the staircase. The door confronting you is made of oak, with ornate iron hinges. It is also (not surprisingly) locked. You study the lock itself. It is a fist-sized piece of iron carefully set into the door and cast to resemble a cheeky bald face. Its eyes are closed, and the keyhole is between its pursed lips, so that it would appear to be sucking on the key (if you had a key to use, which you don't). If you wish to use magic to correct this oversight, go to the Magic Matrix. If you think it might be wiser to use non-magical means, make a L2-SR on Dexterity (25 - DEX). If you succeed, go to {196}. If not, go to {206}."
},
{ // 35
"You push a random projection. It goes down with only slight resistance, and stays depressed until you press another. That's all that happens...or is it? Make a L2-SR on Luck (25 - LK). If you succeed, go to {8}. If not, go to {56}."
},
{ // 36
"You push back against the force, straining every muscle. Suddenly, at the very end of your strength, the force is gone. Add 3 points (permanently) to your Strength. You return the vial, now empty, to the statue and stride towards the curtained chamber. Go to {28}."
},
{ // 37
"Turn as it may it can't escape and you manage to strike home. The ferrid squeals in pain and vanishes, to reappear near the bottom of the stairs. It glares viciously up at you, then slinks off snarling to itself. You clean up the signs of the counter as best you can. Closing the study door carefully behind you, you hear the lock relock itself with a muffled hmmph! The stairs are much quieter on your way down. Pick up 15 ap and return to your mop (go to {260})."
},
{ // 38
"Just as you are about to pass out, you sense vibrations that seem to be coming nearer. Piff! You resume your proper shape and look up to see your master standing over you. Servald carries you to your room, puts you to bed, and gives you things to drink until you rehydrate. Then he scolds you for getting into his study. Pick up 110 ap for the adventure, and be thankful you're alive."
},
{ // 39
"You push a projection marked 'mince' and hear a low whirring sound start. Looking at the 'sauna', you see that the fountain's sections have begun to spin, and have lowered so that they almost touch the walls. Soon they are moving too fast to be seen. You push the projection marked 'off'. The sections stop spinning and slowly return to their former height. Pressing the projection marked 'open' opens the door. If you want to take a closer look at the 'fountain', go to {23}. If you're through with this chamber and want to go back and check out the statue, go to {1}. If you'd rather go back to mopping, go to {260}."
},
{ // 40
"You're too slow. The door closes before you reach it. You see the ferrid push a projection on the pedestal and watch in horror as the metal blades (yes, blades) start to spin and reach down for you. Wwwwhhiirrrr! Sploooch! It's all over for this character."
},
{ // 41
"Your mind can't take what you're seeing and runs wildly around in your skull seeking escape. On your master's return, he finds you sitting on the floor of his study holding your head and gibbering. He sighs and goes to make arrangements to send you to the Happyvale Home for the Mentally Unwell. It's over..."
},
{ // 42
"You gather every iota of your mental force, then hurl it at the statue - and strike nothing! After all, this thing may be moving, but it's not truly alive. The statue cackles gleefully as it squeezes your life essence into a vial very much like the one it was previously holding. Your broken form drops to its base, to be found and sampled later by the ferrid. You are very, very dead."
},
{ // 43
"You weren't quick enough. The ferrid catches you in its jaws and crunches down, doing enough damage to paralyze you. The second bite finishes you, and the ferrid enjoys a fine meal. Servald comes home to a happy ferrid and a heap of bunny fur. It doesn't take him long to figure out what happened. He sighs. Now he'll have to look for a new apprentice, and you, for a new character."
},
{ // 44
"\"Would you like a totally new perspective of the world? I'm sure you would.\" Before you can answer yea or nay, she casts a spell on you. When the smoke clears, your first impressions is that she has suddenly grown very large. Your depth perception is lousy, and you find it hard to focus on things directly in front of you. But the meadow smells great. As she picks you up by the scruff of your neck, you kick out - and realize the truth! You are now a rabbit.\n" \
"  \"There you go,\" she says, as she places you back in the study. \"I'm sure you'll enjoy all those new scents and sounds. And don't worry - Servald can change you back - if he remembers to. Have a good time.\" She laughs and closes the window. You stare up at the window and sigh. Might as well head back to your mop, or better still, your room. Then a sixth sense (or perhaps just a rabbit's hearing) causes you to look towards the door. You freeze. The ferrid is standing in the doorway, a predatory gleam in its eyes. You have no doubt that it sees you. It licks what passes for its lips and begins to stalk forward. There's no real hiding place in here. If you stay, you'll be ferrid chow. Your only chance lies in dodging past the ferrid and reaching the staircase. Make a L1-SR on Dexterity (20 - DEX). If you succeed, go to {63}. If not, go to {89}."
},
{ // 45
"You step silently up to the reading stand and stare at the tome. It is half as long as your arm, nearly as wide as it is long, and very thick. It is bound in thick, black hide decorated with a complex spiral pattern picked out in tarnished silver. Surprisingly enough, its ornate lock has not been properly closed, and the tome can be easily opened. If you choose to open it, go to {54}. If you'd like to take it elsewhere (like that nice comfy chair by the fireplace) for a thorough reading at your leisure, go to {235}."
},
{ // 46
"The ferrid yelps and stumbles when your spell hits. It has an MR of 30. If your spell didn't kill it outright, make a L1-SR on Luck (20 - LK). If you succeed, the ferrid rolls to the bottom of the stairs and stays hidden until your master returns. Thereafter, it is a *lot* more polite to you. Pick up 100 ap and exit this adventure. If you fail your luck roll, the ferrid falls off the staircase and splatters at the base of the stairs. There's teeth, blue fur, and less identifiable bits everywhere (not that you really *want* to look that closely at what's left). If you killed it with your spell, the effect is the same, just less of a mess. In either case, your master is greatly displeased with your wanton slaying of his pet. He changes *you* into a ferrid and starts looking for another apprentice."
},
{ // 47
"Dodging wildly, you avoid the ferrid's jaws. The ferrid recovers and lunges after you. But rabbits aren't built for endurance, and you won't be able to keep this up forever. The ferrid is too fast. The gaping jaws come closer and closer, no matter how you turn. Just when you think you can't run another inch, a blinding light appears. When you can see again, you master is just completing the spell that restores you to your normal form. He points to the door. You leave. Somehow, you get the feeling that there's going to be a lot of drudgery to do for a long time. Pick up 75 ap for your pains and start mopping."
},
{ // 48
"The statue howls in fury. In one savage move it crushes your chest like an egg. The world goes violently red. Then - darkness. Your shattered body falls to lie at the statue's base, mute sign to your master that he now needs a new, less curious apprentice."
},
{ // 49
"You strike hard and fatally. The ferrid falls at your feet, its blue fur stained with blood. It glares at you and its jaws close in a last, futile attempt to do you harm before it dies.\n" \
"  Pick up 30 ap for killing the ferrid and 100 ap for the entire adventure. You are now left with the problem of disposing of its body and explaining its death to your master who was rather fond of the beast. Good luck. I'm sure you'll think of something."
},
{ // 50
"The demon is not affected. His spell fails and does you no harm. However, the glass can't handle your spell and breaks with a high-pitched, glassy scream. You are slammed backwards by the forces released. Take 2d6 hit points. If you survive, go to {64}. If you don't, your master finds your broken body upon his return, assuming, of course, that the ever-hungry ferrid doesn't eat it first."
},
{ // 51
"You were a model of obedience (or very, very sneaky). She is pleased with your service, and teaches you Dis-Spell (third level) as a parting gift. Gain 2 IQ points and 150 ap. Of course, Servald won't take you back as apprentice after the way you left, so it's time for this character to adventure elsewhere."
},
{ // 52
"Whether you couldn't get the gestures right, forgot a word, or the spell simply failed will never be known. You have time for one last scream before everything goes suddenly and terminally black. Your twisted corpse falls to the base of the statue with a very final-sounding thud."
},
{ // 53
"You zip down towards the thoroughly confused ferrid and land a kick on its rump. It yelps and vanishes.\n" \
"  You don't see it again until your master gets back, and it's a lot less annoying. Can't say that it's respectful, but at least it doesn't snicker at you nearly as much. Pick up 100 ap and an enjoyable memory."
},
{ // 54
"Licking suddenly dry lips, you open the tome. The cover is heavy and the binding stiff, but with a little careful effort it responds to your touch. Although you meant to open it to the beginning, the pages seem uncommonly sticky and the tome opens to a random page. Roll 1d6. If you roll a 1, go to {9}. If 2-4, go to {65}. If 5-6, go to {24}."
},
{ // 55
"Guess it just doesn't pay to talk to strangers, no matter how friendly they seem. You feel the full, fatal power of the ferrid's bite, and manage one final rabbity squeal before everything goes dark. But the day hasn't been a total loss. You make the best meal the ferrid's had in a long time.\n" \
"  Burp."
},
{ // 56
"Nothing happens. You quickly get bored with this. If you want to examine the inside of the 'sauna', go to {2}. If you want to go back and check out that statue, go to {1}. If you'd rather mop, pick up 10 ap and go to {260}."
},
{ // 57
"You push against the force - to no avail. All those days sitting around and study have taken their toll. You simply aren't strong enough to break free. The force crushes down upon you, and passes on. Subtract 3 points (permanently) from your CON. If you want to go back to your mop, go to {260}. If you still feel up to exploring the chamber, go to {28}."
},
{ // 58
"You have better things to do with your time than fool with this obnoxious lock. Zzuush! If your IQ exceeds 12, the force of your wrath scorches the lock and leaves a long mark on the door. \"Yipe!\" The lock squeals, and opens. You'll have to do something about the mess before your master returns, but later. Right now you'd rather explore the study (go to {70}).\n" \
"  If your IQ is 12 or less, you leave a scorch mark on the door, and lock starts howling \"Help! Fire! Foes! There's a crazed apprentice up here abusing me! Help! Heeellllpppp!\" You turn to run - and see the ferrid on the stairs 5' away. You glance over the side of the stairs at the 80' drop, and decide that running is out. If you decide to fight, go to {92}. However, ferrids are chancy creatures. It might not attack. If you decide to wait and see what is will do, roll 1d6: 1-2, go to {158}; 3-4, go to {171}; 5-6, go to {144}."
},
{ // 59
"It's dead, and what a mess it is, with all that bloody blue fur all over the place. Pick up 30 ap for killing the ferrid and another 100 ap for the adventure. Then get your mop and tidy things up before your master gets home. And think up a really good explanation for when he asks you just what happened to his favourite familiar."
},
{ // 60
"You refuse to die without a fight. Gathering every scrap of will and intellect you can muster, you send a bolt of power at your foe. If your IQ is 20 or higher, go to {50}. If it is less than 20, go to {94}."
},
{ // 61
"You conjure up the image of a huge, hairy, multi-eyed monster with even more teeth than the ferrid right behind the pesky beast. The ferrid looks over its shoulder, stares a moment, then lets out a blood-curdling scream. It leaves your sight in a blur of speed. You don't see it again until your master's been home a few days - and it still seems anxious. Pick up 100 ap and an enjoyable memory."
},
{ // 62
"This pedestal is 2' by 2', and comes up to your waist. The top of the pedestal contains 20 projections. Each is slightly raised from its surface, and has an inscription in common tongue written beneath it. These inscriptions say things like 'mix', 'chop' and 'liquefy'. The rest of the pedestal has a flat surface, much like a table. A small bronze plate on the left side of the pedestal states: 'Trollworks, Inc. Pat. pend.' If you wish to inspect the structure of frosted crystal, go to {16}. If you want to push a projection or two, go to {35}. If you've had enough exploring for today (after all, that nosy ferrid may be lurking about), go to {260}."
},
{ // 63
"It's now or never. You catch the ferrid by surprise as you bounce high over its head and take off down the stairs. You practically fly down the staircase, the ferrid in hot pursuit. Clearing the last five steps in one leap, you race off down the corridor trying to put as many twists and turns into your trail as you can. And the ferrid's right behind. Now comes the hard part - eluding the aroused beast until your master comes home. Make a L1-SR on Dexterity (20 - DEX). If you are successful, go to {98}. If you fail, go to {106}."
},
{ // 64
"You roll to a halt against the opposite wall and watch stars for a while. When your private light show stops, you see the scattered wreckage of the window, and nary a sign of the demon. You climb stiffly to your feet, and dust yourself off. If your curiosity is satisfied, clean up the mess as best you can, draw back the curtains, pick up 50 ap, and limp back to your mop (go to {260}). If you still want to explore, you may examine the skull (go to {77}), peruse the tome (go to {45}), or look at the crystal ball (go to {159})."
},
{ // 65
"The tome opens to a page illustrated by a master craftsman. For a moment, you can see nothing but its beauty. Then, amid the swirls of vines and twisting creatures, you see the writing. Roll 1d6. If you roll 1-2, go to {73}. If 3-4, go to {80}. If 5-6, go to {86}."
},
{ // 66
"\"Sounds great!\" you say, with vision of well-endowed members of the opposite sex and sandy beaches strolling through your mind. Your studies have been hard, and you'd like a vacation. \"How do I get in there?\" The demon takes a swig and sighs, then looks back at you. \"Just take my hand and step on in,\" he says. He reaches a hand towards you. You pause, remembering a lecture your master gave you concerning demons. If you'd still like to see the beach, etc., go to {17}. If you're beginning to have second thoughts, and want to pass on this offer, go to {75}."
},
{ // 67
"You manage to find and corner the ferrid. You've remembered all the nasty little things it's ever done to you while you were looking for it. Now it's payback time. You grin as you close in on the cowering beast. It senses what you have planned for it, tosses its head back and wails. You feel a draft and sense an increase in the local magic level. An all-too-familiar increase. \"Can't I leave you two alone without having a fight start?\" You turn, and see your master, who is none-too-happy about being called away from the convention. He glares. \"I won't ask who started this. Instead...\" He changes both you and the ferrid into small stone figurines and puts you on a bookshelf. Then he returns to his convention. Pick up 75 ap and collect dust until he returns (in roughly a week) and changes you both back."
},
{ // 68
"Pushing through the curtain, you step into a circular room (20' diameter). The floor is filed in an intricate pattern of grapevines. In its centre is a 10' high circular structure of frosted crystal, set on a two-level dais. The floor pattern continues itself on the steps of the dais. A door, slightly smaller than normal, is set in one side of the structure. This door is open. Next to the wall to your right is a pedestal with many raised projections on its topmost surface. If you want to check out the crystal structure on the dais, go to {6}. If you'd rather check the pedestal, go to {30}."
},
{ // 69
"You come to in your own bed, in your own proper form. It takes three days before you fully recover. You learn that Servald returned in the nick of time and saved your life. When you're back to normal, you get a lecture on the dangers of curiosity. Pick up 100 ap, 1 IQ point, and a little more caution."
},
{ // 70
"You push the door aside and step into the study, sink an inch into the plush green carpet, and pause a moment to get your bearings. The study is oval (roughly 30' long by 20' wide) with the door set into the middle of one of the long sides. By candlelight, you see built-in bookcases crafted of intricately carved oak flanking the door and covering much of the walls. There is a black stone fireplace in the wall to your left, with two small window slits set high up to either side of it. On the mantelpiece, you see a humanoid skull resting between a pair of silver candlesticks, each containing a fat, yellowish candle. A plump, green chair with a small table beside it is in front of the fireplace.\n" \
"  Directly across from you is a reading stand upon which rests a large closed tome. Behind the stand you see a pair of green curtains on the wall, parted slightly to reveal a sliver of stained glass. To your right, 7' away, is your master's desk, a massive oak affair with carved feet. It is placed so as to watch both door and curtained window. On the desk is a small candelabra containing three thin white candles, and a crystal ball on a carved silver stand. Along the wall behind the desk are two small window slits.\n" \
"  You find all this quite fascinating, and feel (not surprisingly) the presence of magic. This feeling is strongest from the skull, the tome, the curtains behind the reading stand, and the crystal ball. If you wish to examine: the skull, go to {77}; tome, go to {45}; curtains, go to {82}; crystal ball, go to {159}."
},
{ // 71
"You climb through the window and walk over the grass to the woman, who rises and leads you to a small table set for two beneath a large hemlock at the edge of the meadow. The many-coloured threads of the embroidery in the hems of her gown flashes in the sunlight as she seats herself. Uncertain of what to do, you remain standing. \"Go ahead,\" she says, smiling. \"Please be seated. Help yourself.\" The tea is good and the small seedcakes she serves with it are even better. But you could be eating mouldy crusts and swamp water for all the thought you pay them, for she is witty and intelligent, and the conversation holds all your attention. You speak of many things, both trivial and not, and the time slips past unnoticed. After you make a particularly good (you think) answer to something she said, she leans back and laughs. \"You *are* clever,\" she says with another of those dazzling smiles. Are you, now? Make a L1-SR on Intelligence (20 - IQ). If you succeed, go to {79}. If not, go to {165}."
},
{ // 72
"You keep your balance. When you can see again, Servald is standing in front of you. He is definitely displeased. \"Since you like my study so much, you can stay there!\" He turns you into a candlestick and puts you on the mantle, then returns to his convention. Make a L2-SR on Luck (25 - LK). If you succeed, Servald remembers to change you back when he returns. Pick up 75 ap and continue your studies. If you fail, you remain a candlestick in the shape of a wide-eyed apprentice, with a fat candle stuck in your mouth and your hands holding it upright, collecting dust on the mantle."
},
{ // 73
"As you begin to read, you lose track of the words themselves. Instead, you seem to be looking at the entire world from above. No thing of magic escapes your sight, and you comprehend their nature and power with clarity. When you come to yourself, you find that you now know the second level spell, Omnipotent Eye. If your IQ and/or DEX were not sufficient to cast this spell, they have been raised to the minimum level necessary (IQ 12, DEX 9). The tome closes by itself and will not open again. If you wish to examine: the skull, go to {77}; the curtains, go to {82}; the crystal ball, go to {159}. (Note: no item will work more than once. If you have already dealt with an item don't go back.) If you wish to adventure elsewhere, try the east corridor door ({10}) or the door of strange noises ({182}). If you've had enough, return to your mop at {260}."
},
{ // 74
"Servald glares at you. \"I haven't time to deal with you now. So...\" He casts a spell you know only too well. You smile apologetically as he turns you into a small throw rug, and settle to the floor. The ferrid comes in and curls up on you with a toothy snicker. When your master returns, you'll receive your own shape, 100 ap, and bread and water for a week."
},
{ // 75
"\"Uh, thanks, but no thanks,\" you say, stepping back from the window. \"I sunburn easily.\" The demon's smile vanishes and he draws back his hand. \"Die, then!\" he snarls, making a magical gesture towards you. There's no time to run. If you want to defend yourself with magic, go to the Magic Matrix. If you resort to weapons, be they enchanted or not, go to {140}. If you cower and hope he misses, go to {162}."
},
{ // 76
"You aren't up to this, and faint at the first touch of the knife. When you come to, Servald is standing over you, having just released you from the ball. \"Out!\" he says. You slink down the stairs. Pick up 50 ap and the task of thoroughly cleaning the castle."
},
{ // 77
"You cross the room to the fireplace. Now that you are closer, you note that the skull has a decidedly elvish look, perhaps due to its stretched, narrow features and the prominent ear ridges. This might explain the magic you feel. Knowing your master, however, you suspect something more. As you continue to scrutinize the skull, it seems to blink (pretty good trick without eyes or eyelids) and speaks, \"Well, curious one, aren't you going to say something?\" If you wish to talk with the skull, go to {7}. If you remain silent and continue to examine it, go to {120}."
},
{ // 78
"Whether you were slow in obeying or got caught doing something you shouldn't have, your mistress is displeased. She cancels your agreement and sends you back to Servald's castle. Servald isn't too pleased with you either, and sends you packing. Pick up 100 ap and look for someplace else to adventure."
},
{ // 79
"\"Yes, you're quite clever. So clever, in fact, I'm going to make you an offer.\" She pats you on the head. You wonder what she has in mind. You've covered so many topics in your conversation with her that you don't have a clue to what she intends. Roll 1d6. If you get 1-2, go to {107}. If 3-4, go to {44}. If 5-6, go to {87}."
},
{ // 80
"The words bear you up like wings, until you fly like the birds of the air. You soar through unknown skies experiencing the intricacies of controlled flight. When you finish reading, you realize that you have just learned the third level spell Wings. If your IQ and/or DEX were not high enough to cast this (IQ 14, DEX 10), they have been raised to the minimal level required. The tome closes itself with a final-sounding thud and can no longer be opened. If you wish to examine: the skull, go to {77}; the curtains, go to {82}; the crystal ball, go to {159}. (Note: the four items of interest in the study will respond to you, visual exam excepted, only once. It is therefore useless to return to a given item.) If you're through with the study and would like to explore: the east corridor door, go to {10}; the door of strange noises, go to {182}. If your curiosity is satisfied, return to your mop at {260}."
},
{ // 81
"You scream once before you land at the bottom of the stairs. There you splatter leaving a big, tasty mess. By the time the ferrid's finished with it, there's nothing but a faint red stain and your apprentice's ring, mute sign to Servald of your unfortunate fate."
},
{ // 82
"You walk over to the curtains and pause. They are dark green and of a fabric that is heavy, yet soft to the touch. You pull them aside to reveal a magnificent window of stained glass. It is round, roughly 4' in diameter, and set in a golden frame which can be opened if you so desire. Depicted in glass of red and yellows is a most life-like demon. You have never seen an image so perfectly wrought. The magic you felt earlier originates from the window. If you wish to touch the glass, go to {90}. If you want to see what lies beyond the window, go to {102}. If you are finished with the study, and would like to return to your mop, go to {115}."
},
{ // 83
"Servald pops in to see what's going on and finds you, badly scorched, by his study door. He heals you, gives you the lecture on staying-out-of-things-you-shouldn't-get-into, and sets you back to mopping. Pick up 30 ap and be thankful you're alive."
},
{ // 84
"Yipe! The ferrid yelps as your spell takes effect. It has an MR of 30. If you have reduced its MR to 15 or less, go to {37}. If its reduced MR is still greater than 15, your may repeat this spell or choose another (see Magic Matrix for paragraph {92}), and continue until you have reduced its MR to 15 or less, killed it, or been killed by it (after your first spell, it will be attacking you. It starts out with 4d6). If you kill the ferrid, go to {59}. If it kills you, you don't have to worry about what your master will say when he sees what you've done to his study."
},
{ // 85
"You fall 60', screaming all the way. Make a L1-SR on Constitution (20 - CON). If you succeed, you live but are badly injured. You lie on the floor fading in and out of consciousness. In your more coherent moments you keep an eye out for the ferrid. Servald finds you on his return and heals you. Pick up 30 ap, but lose 1 CON point (you now walk with a slight limp). If you fail, your master finds your broken body at the foot of the stairs."
},
{ // 86
"The words reveal secrets common to all living things and hint at the meaning of life itself. You now know how to preserve any life from the ravages of disease, as per the third level spell Healing Feeling. If your IQ and/or DEX were not high enough to cast this, they have been raised to the minimal level necessary (IQ 14, DEX 10). The tome closes and cannot be reopened. If you wish to examine: the skull, go to {77}; the curtains, go to {82}; the crystal ball, go to {159}. (Note: no object will work more than once, so if you've done more than look at something, don't bother going back to it.) If you're finished with the study, but still wish to explore, go to the east corridor door at {10}, or the door of strange noises at {182}. If you'd rather return to your mop, go to {260}."
},
{ // 87
"\"I could use a good apprentice,\" she says, smiling. \"And I'm sure Servald doesn't half appreciate your value. Would you like to be my apprentice?\" She seems to be a lot easier to get along with than your current master. If you'd like to take her up on her offer, go to {113}. Still, Servald took you in when nobody else would. He may be a grouch with lousy taste in familiars, but he knows his magic. If you'd rather stay with him, go to {125}."
},
{ // 88
"Desperately, you dive for the rapidly shrinking opening. The door grazes your heels as you fly through, then crashes shut behind you, tearing a small piece from your clothing. You land roughly on the floor. Looking back, you see no sign of pursuit - and a solidly shut door. If you wait a bit and try to open it, it refuses to budge. Pick up 25 ap and several bruises. As you head back up the stairs to your mop, you hear a small chuckle. Then the gibbering begins again. Oh, well. Maybe your master will tell you what's actually in there when he gets home. Which will probably be anytime now, so that's it for adventuring."
},
{ // 89
"Quick as you are, the ferrid is quicker. As you try to zip around it, it chomps down on your tender little body. Take 1d6 hits on CON (any armour you may have been wearing doesn't help while you're a rabbit). If this kills you, the ferrid dines. If not, make a L2-SR on Luck (25 - LK). If you succeed, go to {47}. If you don't, go to {55}."
},
{ // 90
"You reach out, gently touch the glass - and get the surprise of your life as your fingertips go past its surface! As you jerk your hand back, a deep, harsh voice remarks, \"Neat trick, eh?\" You glance wildly around for its source but see nothing. \"Hey you! Apprentice! I'm up here - in the window!\" You look back towards the window and meet the glass demon's eyes. It blinks. You stare. \"Did you want to talk, or were you just sticking your fingers in here for fun?\" You've *heard* about demons. However, this one seems safe enough for the moment. If you'd like to talk with it, go to {99}. If you'd rather not and wish nothing more to do with the window or its occupant, go to {151}. If you'd like to open the window, go to {102}."
},
{ // 91
"He holds out a hand and helps you into the window. Your mind does a flip-flop, then reorients to your surroundings - a multicoloured void, lacking beach, booze and everything else the demon told you about. Speaking of whom, *he* isn't here, either. You turn back to the study just in time to see him wave to you and vanish, leaving you stuck in his former prison. Unless, of course, you can trick an unsuspecting person into changing places with you. Otherwise, you're in for a very long stay. Make a L3-SR on Luck (30 - LK). If you succeed, go to {178}. If not, you're stuck 'til starvation, thirst or insanity claim you."
},
{ // 92
"You get the first shot. You know that ferrids are somewhat magical by nature. You also know that they are amazingly quick, both in dodging and attacking. And they have lots of very sharp teeth. Very nasty teeth, which they are all too eager to use on anything that bothers them. Especially if it's potentially edible. You gulp once, then choose your best shot. If you decide to use a weapon of any kind, go to {103}. If you use magic, go to the Magic Matrix."
},
{ // 93
"This particular brand of poker just isn't your style. You lose 2/3 of the money you were carrying. [If you had no money, you lose 1/3 of the stuff you were carrying - rope, clothes, etc. ]Insi accompanies you to the door and invites you to come again. You just might do that. Maybe you could even win back your stuff. Hmmmm. Was that a book on poker variants you remember seeing in your master's library? You'll have to check. For now, it's back to chores. Pick up 50 ap and return to your mop."
},
{ // 94
"The demon's spell fails, unable to breach the glass. Your spell causes the glass to shudder but does no damage to either it or the demon, who snarls and glares before turning his back to you. He seems content to ignore you and that suits you just fine. If you'd like to see what lies *beyond* the window, go to {102}. If you'd rather examine: the skull, go to {77}; the tome, go to {45}; the crystal ball, go to {159}. If you wish to return to your mop, go to {115}."
},
{ // 95
"The cards slide easily through your fingers. It's simple - once you know how. You find that you have a knack for this sort of thing. Pick up 1 DEX point and some knowledge of card tricks. Insi takes you back to the door and invites you to return some time. Pick up 75 ap and go back to your mop."
},
{ // 96
"Quicker than your eyes can follow the ferrid leaps forward and snaps its slavering jaws shut - on the air 1\" from your nose. Then it squeals in glee and takes off down the stairs. You wipe the slaver off your face and tell your knees to stop shaking. If you choose to ignore the beast, return to your mop (go to {260}). If you are fed up with the ferrid's insolence and want to teach it a lesson, either choose a spell and go to the Magic Matrix or hunt it down with weapons (go to {138})."
},
{ // 97
"Easily in, but not so easily out. The curtain reacts to your presence by sending a powerful shock through your body. You are thrown down the corridor and slide to a halt against the wall. Take 13 points of damage directly on your CON. If you yet live, you manage to crawl back down the passage and upstairs to your bed. Pick up 40 ap and a few scars. If not, the master finds your scorched remains on his return."
},
{ // 98
"After a merry chase, you manage to squeeze yourself into a spot where the ferrid can't reach you. And just in time, because it's been a long run and bunnies just don't have much staying power. Even so, the ferrid's teeth snap down on the tip of your tail and pull loose a tuft of fur. So you tuck yourself further into your refuge and stay there, panting, until you hear your master's voice. \"Well now, what have you got?\" Servald peers into the crack, does a double-take, then gets up and orders the ferrid back. It goes with ill grace. All you can see now are your master's feet. \"You can come out now.\" You wriggle free and look up hopefully at Servald. A wave of his hand restores you to your proper form. However, he's none-too-pleased with your extra-curricular activities. You get a lecture on keeping your nose out of places it shouldn't be. Then it's back to your mop, with the scullery to clean afterwards. And from the way the ferrid is looking at you, it's got something unpleasant and annoying planned the moment Servald turns his back. Pick up 75 ap and start cleaning. The fun's over for now."
},
{ // 99
"  \"I was just curious,\" you answer. \"Say, how'd you get in there? I thought you were just a work of art.\" The demon scowls. \"I don't know anything about this 'Art' of yours. Never met him. As for being 'in here', I was bored with my usual activities, and your master suggested it was a nice vacation spot.\" He leers down at you. \"Whoooeeeey! You should see the females here! And the males! Not to mention the beach and the booze! Come on in and see!\" He slips on a pair of mirrored spectacles and opens a small metal container, obviously cold, from which starts foaming an interesting brew. If you wish to take him up on his offer, go to {66}. If you'd like to talk further, go to {176}. If you're still curious as to what lies beyond the window, go to {102}."
},
{ // 100
"Slipping her autographed copy of Karner's Konjurations out of the library for further study in your room was *not* a good idea. Getting caught with it was worse. Getting bread crumbs in it was the last straw. She ignores your excuses. \"Since you like my books so much, stay with them, and, for once, be useful!\" She turns you into a bookend and puts you on a shelf, right next to the book that got you into this. That's it for this character."
},
{ // 101
"Did I say almost? Your heart couldn't take the strain. You die with a beatific smile on your face, which puzzles your master no end when he comes home and finds you slumped on the floor of his study."
},
{ // 102
"Carefully keeping your fingers away from the glass, you undo the latch and push the window open. The demon in the glass watches you covertly, but otherwise ignores you. You look outside and gasp. Instead of clouds and cliffs, you see a green meadow surrounded by hemlock and pine trees. Seated in the meadow on a large black stone is a very beautiful woman gowned in green, plaiting her long red held. \"Servald?\" she murmurs, then looks up and sees you. \"Ah, you must be Servald's apprentice. Come, join me for tea - that is, if your master can spare you a moment.\" Things seem safe enough. And you might learn something of interest about your master if you talk to her (sly old dog - you never guessed he had someone like *her* on the side!). If you wish to talk, go to {71}. If you'd rather not (meddling with your master's things is one thing. Dealing with someone he knows could be really bizarre), go to {173}."
},
{ // 103
"You lunge towards the ferrid, which realizes what you're up to and tries to twist away. Make a L1-SR on Dexterity (20 - DEX) each time you attack the beast, which has a Monster Rating of 30 (4d6 attack. Did I mention how tough ferrids are?). If you succeed in dropping its MR to 15 or less, go to {37}. If you kill it outright, go to {49}. If it kills you, Servald finds a fat, happy ferrid and no apprentice upon his return."
},
{ // 104
"You make yourself as comfortable as possible and wait for Servald. He shows up after a day or so and isn't at all pleased when he sees you. You are put on bread and water for 2 weeks and set to cleaning every inch of his castle, inside and out. Pick up 100 ap, 1 DEX point, and many, many blisters."
},
{ // 105
"You blew it, big time. You not only lost all your money, but pretty nearly everything else as well. In fact, it's only because Insi likes you that you have anything decent to wear back to the door. You leave with the clothes on your back. Pick up 50 ap and get back to mopping."
},
{ // 106
"You make the mistake of running straight for too long a stretch and the ferrid makes the most of it. You feel its hot, fetid breath as you dodge, and bounce to one side. The wrong one. The ferrid snaps - and connects. Take 1d6 hits on CON (armour you were wearing in human form doesn't count in this one). If this kills you, the ferrid has a tasty, though now boring (you stopped moving), snack, and Servald will have to go apprentice-shopping. If you survive, make a L2-SR on Dexterity (25 - DEX). If you make this, go to {31}. If not, go to {43}."
},
{ // 107
"She offers to teach you a spell. For free. Just because she likes your style, and she knows how difficult your master can be when it comes to getting new spells out of him. [If your IQ is less than that required for the spell, she will place it in your mind, where it will remain until such time as your IQ is sufficient to use it. ]If you already know the spell, roll again. If you know the second spell you roll, she is impressed with your knowledge, and you gain 1 IQ points. Now roll 1d6 to determine the spell you learn:\n" \
"    1) Mirage (level 2)\n" \
"    2) Restoration (level 2)\n" \
"    3) Concealing Cloak (level 2)\n" \
"    4) Omnipotent Eye (level 2)\n" \
"    5) Dis-Spell (level 3)\n" \
"    6) Wings (level 3)\n" \
"After teaching you, she bids you goodbye. You go back to the window (which looks rather strange standing in the meadow by itself, especially since it's floating about 2' off the ground), and reenter the study. After stepping through, you carefully close the window behind you. Yu stop to pick up the leaf or two that you tracked onto the rug, and close the curtain, trying to make sure that you leave everything as close to the way it was as possible. Pick up 50 ap. If you want to examine: the skull, go to {77}; the tome, go to {45}; the crystal ball, go to {159}. If you want to go back to your mop, go to {115}."
},
{ // 108
"The card won't fall right for you. Try as you may, you just don't have any skill at this. However, you do understand enough of what Insi is doing to have a good chance at spotting anyone else trying such tricks. Pick up 1 IQ point and 75 ap, and return to your mop, with Insi's invitation to stop by anytime."
},
{ // 109
"You were a little slow reaching the curtain. The whatever-it-is behind you is close enough to trigger the room's defences. This results in you receiving a powerful shock when you jump out of the room. You take a nose dive into the floor, but you made it out of there. Take 13 points of damage directly on your CON. If you are still alive, you retreat to the door and out as fast as you can. Pick up 60 ap and a well-earned nap. If not, an appendage forces its way past the curtain and drags your body back into the room to serve as the main course in a rather messy repast."
},
{ // 110
"If the sum of your IQ, Luck and Charisma is greater than or equal to 30 (the ferrid's MR), the force of your personality is too much for it, and it slinks off down the stairs. You breathe a sigh of relief and return to your mop (go to {260}). If the sum is less than 30, the ferrid is not impressed, and viciously attacks you using 4d6. If you survive its attack, you may choose another spell (return to the Magic Matrix), or use a weapon (go to {103})."
},
{ // 111
"You maintain enough awareness of your surroundings to take the passage to the door when your reach the fork in the path. The thing(s) behind you slavering at your heels, you race towards the door and freedom. 8' from your goal, the door starts to swing shut. If you want to try to leap through before it closes, make a L1-SR on Dexterity (20 - DEX). If success is yours, go to {88}. If you fail, go to {136}. If you stop and face your pursuers, go to {249}."
},
{ // 112
"You come up with a truly amazing, but plausible, explanation, mostly true. You are not certain if your master believes you, but he does seem impressed, both with the death of the whatsit and your tale. Pick up 100 ap and start cleaning up the mess under Servald's watchful eyes."
},
{ // 113
"You agree to be her apprentice. The window through which you left the study vanishes with a soft 'pop'. You feel a sudden chill, and suddenly her smile doesn't look quite as friendly as it did. Then you find out what being her apprentice means. You will serve her for one year. She expects complete and immediate obedience. No arguments. No questions. Most of all, no back talk. To see how well you do, make a L3-SR on Luck (30 - LK). If you make it, go to {51}. If you miss by 5 or less, go to {78}. If you miss by more than 5, go to {100}."
},
{ // 114
"A flash of light, a cloud of smoke, and a powerful spell later, you find yourself on the floor of the room, sans monster, at the feet of your master. You feel a strong temptation to kiss those feet, and, if you can find the strength, you probably do. Servald isn't too happy about having to leave his convention to rescue you and gives you a number of tedious tasks (such as cleaning this room) as punishment. Right now, you're so grateful to be alive that you don't care. Pick up 100 ap and start working."
},
{ // 115
"You make some attempt to straighten up the study so that your visit won't be immediately obvious. After one last look around, you start for the stairs - and meet the ferrid just outside the door. It smiles toothily, and runs a thin tongue over its lips. You don't like the look on its face and you definitely don't trust its mood but there's no place to run. And ferrids are notoriously unpredictable. If you decide to fight it, go to {92}. If you decide to wait and take a chance on its behaviour, roll 1d6. If you get: 1-2, go to {33}; 3-4, go to {96}; 5-6, go to {144}."
},
{ // 116
"This is one difficult beast to pin down. Make a L1-SR on Dexterity (20 - DEX) each time you attack the ferrid. If you fail this, you miss. If you reduce the ferrid's MR to 15 or less, go to {37}. If you kill it, go to {49}. If it kills you, Servald is minus an apprentice and you need to roll up a new character. You're ferrid chewies."
},
{ // 117
"Impossibly large red fingers graze your chest, but don't get a firm grip, and slide off. You plaster yourself against a wall and watch as the hand gropes futilely. To your great relief, it finally withdraws back through the pentagram. It takes you a moment to catch your breath. Pick up 30 ap for avoiding the hell-hand. If you just want to leave, go to {239}. If you are still interested in exploring this room, go to {258}."
},
{ // 118
"You cast the light-ball into his eyes and momentarily distract him. His spell does absolutely nothing. You suspect that the power holding him in the glass also keeps him from doing any harm to you, an idea that finds support when the demon snarls and turns his back on you. If you'd like to see what's behind the window, go to {102}. If you'd rather look over: the skull, go to {77}; the tome, go to {45}; the crystal ball, go to {159}. If you want to return to your mop, go to {115}."
},
{ // 119
"You approach the reading stand. The tome is bound in black leather adorned only by a line of runes on its spine in a script you have never before seen. It is as long as your forearm and as thick as your wrist. It also gives off magical vibes of no apparent alignment. If you wish to open it, go to {131}. If you would rather examine: the apparatus, go to {259}; the shelves, go to {189}."
},
{ // 120
"\"Ouch!\" the skull says as you prod its face, and tries to squeeze the eyes it doesn't have shut. \"You'll be sorry!\" It makes no further attempts to communicate. It is indeed an elf skull. You cease your examination, curiosity satisfied. If you want to examine: the tome, go to {45}; the curtains, go to {82}; the crystal ball, go to {159}."
},
{ // 121
"You vanish. The ferrid sniffs about for a bit, looking for you. Make a L1-SR on Luck (20 - LK). If you succeed, the ferrid gets bored and leaves. You slip downstairs and return to your mop (go to {260}). If you fail, the ferrid bumps into you or catches your scent and attacks (MR 30, 4d6). If you survive the attack, you may attack using magic (return to the Magic Matrix) or weapons (go to {103}). If you do use a weapon, make a L1-SR on Dexterity (20 - DEX) each time you attack it. If you don't survive, your worries (and this character) are over."
},
{ // 122
"Somehow, you killed it - and you still have no idea what it was. The major monster bits turn into oily smoke and seep back to where it came from. Pick up 86 ap for doing away with it. However, even with most of the gore gone, this room, to put it mildly, is a mess. Servald isn't going to be at all pleased. You can either try to straighten it up (go to {139}) or come up with a convincing story to tell your master (go to {216})."
},
{ // 123
"The palm of your hand is a bloody mess, but you were able to free yourself from the ball. The tatters of skin you leave on it shrivel and fall off even as you watch. You bind your hand up to stop the bleeding. Take 2 hits. If you want to leave, go to {115}. If you wish to examine: the skull, go to {77}; the tome, go to {45}; the curtains, go to {82}."
},
{ // 124
"Oh, well. Some days things just don't go your way. You are mashed into writhing pulp and absorbed, body and soul, by the black thing. Servald, arriving moments later, hears only a deep belch from the shadows. Of you, his apprentice, there is not a trace. He shrugs and returns to the convention, faced with the problem of finding your replacement."
},
{ // 125
"Your master may be tough to deal with at times, but at least you know where you stand with him. Besides, her smile reminds you of the way the ferrid looks at dinner. Still, she's not someone you want to offend. \"Well, my time with Servald isn't up yet,\" you say. \"So I can't take you up on your offer. Not that I don't want to. It's just that he's...uh...kind of used to having me around. In fact, he should be back any time now. I probably should be going. Thanks for the tea.\" You smile ingratiatingly and edge for the window. She doesn't look at all pleased. Make a L1-SR on Luck (20 - LK). If you make it, go to {134}. If not, go to {147}."
},
{ // 126
"You don't care where you run, so long as as you escape the source of that noise. Thus, you run straight instead of turning for the exit. The passage widens to 6'. Bouncing into the walls a few times causes a green glow to dimly light your way. This is a good thing, as it enables you to see the sudden turn ahead. You make the turn and almost run into the red silken curtain that completely blocks the passage at this point. Stopping, you notice also that you don't hear the noise anymore. You also notice a design woven into the curtain in gold and black, which resembles either a number of arrows pointing away from a common origin or a stylized flower. There are magic vibes coming from the curtain. If you wish to pass through it, go to {180}. If not, go to {129}."
},
{ // 127
"You vanish. The demon's spell does nothing, and he turns and sulks, paying no further attention to you, even when you reappear. You strongly suspect that it can't harm you. If you want to see what lies beyond the window, go to {102}. If you'd rather check out: the skull, go to {77}; the tome, go to {45}; the crystal ball, go to {159}. If you want to get back to your mop, go to {115}."
},
{ // 128
"You tell a truly incredible story...and Servald doesn't believe a word of it. Still, he is impressed by the death of the thing, and he thinks your skill at storytelling may improve. Pick up 75 ap and start on the task your master gives you: sorting out the various spilled powders, grain by grain. Sigh. Well, at least you've got these tweezers he gave you. You start on your task. And there's still the mopping to do when you finish."
},
{ // 129
"You decide that you've explored enough for one day and turn around to find the ferrid right behind you, grinning. If you try to move around it, it moves to block you but makes no attempt to attack unless you try to pass. Then it snaps at you. It seems quite content to keep you here. Even worse, it seems to have activated the curtain behind you, which is now a force field. You strongly suspect it would take more magic than you command to pass *that*. The ferrid, however, is another matter entirely. If you want to try magic to handle the beast, go to the Magic Matrix. If you strike it with a weapon, go to {223}. If you decide to sit and wait, go to {237}."
},
{ // 130
"Whether you slow it or speeded up yourself, you get an extra turn on it. If you want to slip by it and return to your mop, you may do so: go to {260}. Or, you can attack with magic: go to the Magic Matrix, or weapon: go to {103}, but ignore the L1-SR on DEX on your first attack."
},
{ // 131
"The front cover is cold to touch as you open the tome and look within. A musty smell rises. The pages are thick parchment of a type you haven't come across before. Written upon them in a crabbed, uneven hand is an assortment of spells which appear to involve the summoning of beings. If you wish to try out one of the spells, go to {141}. If you would rather take the tome back to your room for some serious reading in more comfortable surroundings, go to {257}. If you would rather leave the tome entirely alone, go to {258}."
},
{ // 132
"You look more closely at its slimed surface and notice two very strange things about the door itself: it gives forth absolutely *no* magic vibrations of any kind and it isn't locked! In fact, it swings slowly open at your touch. Inside, it's very dark. The wail writhes into a shriek, then fades to a soft muttering. You swallow noisily and wipe the slime from your hand. Since you are set on entering, you will need a light. If you choose to take a torch from the passage or use a Will-o-wisp spell as your light source, go to {198}. If you would rather use a Cateyes spell, go to {233}."
},
{ // 133
"You avoided it - this time. But it's between you and the curtain, and it's still coming. Tentacles grope about the room, seeking your tender flesh. You can either try a spell (go to the Magic Matrix, using the paragraph for {146}) or keep dodging (go to {207})."
},
{ // 134
"She lets you go without further conversation. You head for the window as fast as you dare and climb back into the study. Closing the window behind you, you draw the curtains back over it and breathe a sigh of relief. Pick up 10 ap for loyalty. If you want to check out: the skull, go to {77}; the tome, go to {45}; the crystal ball, go to {159}. If you just want to leave, go to {115}."
},
{ // 135
"Since you are in darkness, creating a light would probably be a good idea. If you cast Will-o-wisp, or light a torch, go to {198}. If Cateyes is more to your liking, go to {233}. If you can't make a light or prefer exploring in the dark, go to {242}."
},
{ // 136
"Mid-leap, you realize that you aren't going to make it. At least, not all of you. And that door is very heavy. Twisting desperately, you try to change direction in the air. Make a L1-SR on Luck (20 - LK). If you succeed, go to {152}. If you fail, go to {145}."
},
{ // 137
"With the ferrid this intent you can't do anything but sit because it snaps at your slightest move and you have little desire to be chewed. When Servald gets back, he finds you sitting in front of the curtain, the ferrid's jaws scant inches from your tender body. He listens to both of you, then calls the ferrid off and sends you back to your mop with a warning to stay on the other side of the door in the future. Pick up 30 ap and start mopping."
},
{ // 138
"Whether your weapon is magical or not, you draw it and take off after the ferrid with blood in your eye. It sees you coming and makes itself scarce. You never knew anything could move that fast. Make a L3-SR on Luck (30 - LK). If you make it, go to {67}. If not, you fail to find the beast and go back to mopping (go to {260})."
},
{ // 139
"You do the best you can to put the room into a semblance of order. As you are wearily surveying your handiwork, you hear a slight cough behind you. You guessed it - it's Servald. \"Care to tell me what happened?\" he asks in a deceptively calm tone. You gulp. You can either tell the truth (go to {153}) or come up with a quick lie (go to {252})."
},
{ // 140
"Mumbling the spell, you draw your weapon and strike. Or maybe you just strike. The demon grins nastily and calls up a spell of its own. You're just a hair quicker. If your weapon does 20 or more points of damage, go to {149}. If it does less, go to {154}."
},
{ // 141
"Turning the pages, you come at last to a spell you find more interesting (and, perhaps, more legible) than the others you have seen. You begin to read it aloud. As you continue, you sense a building of magical force in the centre of the pentagram. At last, the spell is complete - but did you perform it correctly? Make a L1-SR on Intelligence (20 - IQ). If you make it, go to {164}. If you fail, go to {253}."
},
{ // 142
"A faint purple glow forms on a small projection on the lock's lower left. \"Hey, that tickles!\" says the lock as you press, twist and jiggle this button. You hear a small click as the lock releases. The door swings slightly open. Go to {70}."
},
{ // 143
"Its strength is greater than the best you can muster. The thing's black tentacles squeeze with relentless force. You are jellied by its power and devoured."
},
{ // 144
"The ferrid leaps forward and takes a bite out of you. It has an MR of 30 (4d6). If this kills you, the ferrid has an early lunch. If not, you are, to say the least, very annoyed. If you choose to chastise it with weapons, go to {116}. If magic is your choice, go to the Magic Matrix."
},
{ // 145
"So close, but not quite good enough. You make it halfway through the door before it slams shut. It has a bit of trouble getting completely closed, but manages, cutting you completely in half. Your crushed and mangled remains fall to the floor half in and half outside of the door. You are very, very dead."
},
{ // 146
"Before your horrified eyes, the shadows come together to form a black, writhing mass. A black, writhing, intelligent mass which glares at you malevolently. As it takes form, the curtain guarding the room's entrance becomes a wall of light. From your master's lessons, you strongly suspect that it has become a force field - with you on the wrong side. You may either cast a spell (go to the Magic Matrix), try to avoid the thing (go to {241}), or, if you have a weapon, fight back (go to {195})."
},
{ // 147
"\"So Servald has need of you, eh? Let's see how much use he can get from a worm!\" So saying, she changes you into a foot-long earthworm, and throws you back into the study. You sense her laughter as she closes the window behind you. Now you've got a serious problem. The carpet is very dry, and is quickly sucking the moisture from your delicate body. Make a L1-SR on Constitution (20 - CON). If you make it, go to {38}. If not, go to {156}."
},
{ // 148
"Fine. You are invisible. Unfortunately, you are not unsmellable. The ferrid is not impressed. Servald turns up shortly afterwards, and isn't pleased to find you where you are. He puts you back to work and rewards the ferrid with a small, lively snack. Pick up 30 ap and start mopping."
},
{ // 149
"Whatever the demon's spell was, it fails. Your blow, however, shatters the glass and releases quite a bit of power. Take 2d6 hit points. If you still live, go to {64}. If not, your shattered body slides to a halt against the far wall, to be found on your master's return."
},
{ // 150
"You cast your spell. Unless your IQ is 86 (the thing's MR) or greater, it uses the opportunity to grab you with its long black tentacles. Go to {175}. Otherwise, it drops dead. You breathe a sigh of relief and set about the task of removing its body. Pick up 86 ap for killing it and start chopping. As you sever a piece, it turns into oily black smoke and vanishes. When finished, return to your mop (go to {260})."
},
{ // 151
"You drop the curtains back across the window and back away. You hear some muffled snarling, then all is quiet. If you want to examine: the skull, go to {77}; the tome, go to {45}; the crystal ball, go to {159}. If you prefer to leave the study, go to {115}."
},
{ // 152
"Good news: you weren't crushed by the door. Bad news: you weren't able to control your landing and crashed head first into the wall. Take 2d6 hits on your CON[ (only head protection counts vs this damage)]. If you live, go to {193}. If you are slain, things best left nameless slither out of the walls and slurp up your remains."
},
{ // 153
"He listens in silence as you relate the whole sad tale. Then he compliments you on your martial skill. However, you made a real mess of his lab. Not to mention spilling several rare substances. Very expensive, rare substances. You pick up 100 ap for the adventure, and are put on bread and water for a week, while he finishes tidying things - and conjuring up a new monster to guard his lab. And you *still* haven't gotten that mopping done."
},
{ // 154
"Your weapon strikes the glass and bounces off. Not that it matters, since the demon's spell failed. He turns and sulks, paying no further attention to what's in the study. It occurs to you that he probably can't harm you. If you want to see what lies beyond the window, go to {102}. If you want to check out: the skull, go to {77}; the tome, go to {45}; the crystal ball, go to {159}. If you'd rather go back to your mop, go to {115}."
},
{ // 155
"Slowly, you turn right and approach the source of the noise. Then you see it. Crouched in the shadows is a small, brown, furry creature with a worried face. Using the corridor's acoustics to maximum effect, it is producing the mysterious noise.\n" \
"  It looks up and sees you. \"You're supposed to run,\" it says. \"Please run. I could get into big trouble if you don't.\" Further conversation reveals that Insi, the creature, is employed by your master to make noises to discourage unwanted visitors. Insi is relieved to find out that you are Servald's apprentice, and invites you to its home. If you decide to go, go to {222}. If you prefer to explore the left passage, go to {227}."
},
{ // 156
"You feel drier than you ever thought possible. Squirm as you might, you can't move an inch and merely succeed in getting lint all over yourself, which hastens the drying process. Finally you pass out from lack of water. Make a L4-SR on Luck (35 - LK). If you happen to succeed, go to {69}. If you fail the roll, Servald finds your body on his return, so shrivelled that the ferrid wouldn't even touch it."
},
{ // 157
"You work a hand free, take the corner of your tunic, and make a few clumsy passes at the ball. \"I could do a much better job of this if you'd free my other hand,\" you say. \"Oh, I suppose so,\" it replies, \"but remember to finish dusting me.\" It frees you. You can either finish cleaning it (go to {166}) or leave the study (go to {188})."
},
{ // 158
"The ferrid stalks up to you, fangs agleam. Then it sets down and yawns in your face. Moving towards the door, it silences it with a touch and pushes it open. Glancing back at you, it smiles and vanishes. Go to {70}."
},
{ // 159
"You walk over to the desk and look at the ball. It is the size of a cat's head and clear, pale, grey in colour. It rests on a small three-legged silver stand. The legs are in the shape of serpents, with the ball resting on their entwined tails. If you wish to look into the ball, roll 1d6. If you get: 1-2, go to {169}; 3-4, go to {184}; 5-6, go to {200}. If you want to take it back to your room to play with later, go to {218}."
},
{ // 160
"The sudden flash causes you to lose your balance. You fall off the stairs and plunge to your death at their foot, 80' below. Kersplatt! Servald shrugs and goes up the stairs to set his study to rights. Maybe he can get a new apprentice at the convention."
},
{ // 161
"Your host looks none too happy about your plans but accompanies you back to the split in the corridor. \"That way leads back to the door. If you must go the other way, touch the wall for light.\" It stares up at you with sorrowful eyes. \"Please don't go there. Please.\" Insi looks away. With no further ado, the furry creature hurries back to its lair. Ignoring the passage back to the door, you set off down the other corridor, which widens out to 6'. Touching the walls yields a sickly greenish light. The corridor turns. Suddenly, you confront a red silken curtain hanging across the passage. At eye level is a design resembling a stylized flower or a number of arrows pointing away from a common point worked into the fabric with gold and black thread. You sense much magic ahead. If you wish to continue, go to {180}. If you'd rather leave (after all, Insi did seem concerned for your safety), go to {129}."
},
{ // 162
"Nothing happens. You open your eyes and uncrouch. The demon snarls and turns away, obviously wanting no more to do with you. If you want to see what waits beyond the window, go to {102}. If you'd rather look over: the skull, go to {77}; the tome, go to {45}; the crystal ball, go to {159}. If you just want to leave, go to {115}."
},
{ // 163
"You answer not. The ball utters a small \"Humph!\" and goes dark. You are left with your original options. If you want to await Servald's return, go to {104}. If you want to cut yourself free, go to {228}."
},
{ // 164
"You have succeeded in conjuring up a very small, thoroughly annoyed imp. It looks around, notes that the pentagram is intact and in force, and sighs. Glaring at you, it demands, \"Well, out with it. I haven't got all night.\" A hasty glance at the spell's title reminds you that you have summoned an imp of information, usually called up to teach a low-level spell. At your request, it will teach you the third level spell of your choice, whether you can use it now or not. When finished, it makes a rude noise and leaves. If you are through exploring and would like to leave, go to {239}. If you wish to explore further, go to {258}."
},
{ // 165
"\"But not clever enough to bother spending any more time with. Now, run along.\" She turns to other pursuits as you trudge back towards the window and reenter the study. Pick up 20 ap for an interesting conversation. You may examine: the skull, go to {77}; the tome, go to {45}; the crystal ball, go to {159}. Or you can leave the study (go to {115})."
},
{ // 166
"\"Thanks,\" it says, and goes dark. It won't respond to either your voice or peering, and you certainly don't want to touch the thing again. Pick up 25 ap. If you want to look at: the skull, go to {77}; the tome, go to {45}; the curtains, go to {82}. If you'd rather leave, go to {115}."
},
{ // 167
"The horrid shriek comes so suddenly that you are unable to react. In the silence that follows, you hear a small voice say, \"You're supposed to run. Now what am I going to do?\" Then a small, brown, furry creature with a worried face and very large feet steps into your light. Further conversation reveals that its name is Insi, and that it was only doing its job, which is making the scary noises. It then invites you to its home, just down this corridor. If you accept, go to {222}. If you'd rather explore the left passage, go to {191}."
},
{ // 168
"The ball seems to be a perfectly ordinary piece of grey crystal, set on a carved silver stand a hand's width tall. The stand's three legs are carved to resemble serpents whose entwined tails for the resting place for the ball. No secret release button here, at least not that you can find. You sigh. \"Really put your foot, er, hand in it this time, eh?\" a voice inquires. \"Huh?\" you say, looking for its source. \"Well, if you're going to grab someone, you certainly can't blame them for defending themselves, now can you?\" You realize then that the ball itself is speaking. If you want to talk to it, go to {181}. If you'd rather ignore it (you remember what the lock was like), go to {163}."
},
{ // 169
"You stare for a moment. The ball grows cloudy, then reveals a scene of sulphurous pits, flame and writhing shapes. Everything you see seems subtly different, almost twisted. As you continue to stare, the scene explodes into chaos. Make a L1-SR on Intelligence (20 - IQ). If you succeed, go to {179}. If not, {41} is your fate."
},
{ // 170
"Nice try. Unless the total of your IQ, LK and CHR ratings is greater than 86, you don't even slow it down. And if the total is 86 or greater, the thing \"grelps!\" but keeps coming, because the magic that binds it to this spellroom is not something your spell was meant to compete with. Make a L2-SR on Dexterity (25 - DEX). If you succeed, you may fight it with weapons (go to {195}), or keep dodging (go to {207}) as it is now after you from too many sides for you to effectively cast more spells."
},
{ // 171
"The ferrid glances from you to the now quiet lock and grins nastily. Then it saunters down the stairs. Return to the Magic Matrix (paragraph {34}) and choose a new action."
},
{ // 172
"You travel back down the corridor, and thence into the left-hand passage, which widens to 6'. Touching the walls here causes them to give off a sickly green light. The corridor goes on a ways, then turns. You find the way blocked by a red silken curtain with a design woven into it in gold and black resembling a flower of a number of arrows pointing away from a common origin. You sense magic. If you wish to continue, go to {180}. If not, go to {129}."
},
{ // 173
"Talking to strangers isn't generally a good idea. Talking to those you meet when you're where you've been warned not to be (and they're obviously magical) can be worse. \"Thanks, but I've got to get back to my mop.\" She laughs as you shut the window. You may now examine: the skull, go to {77}; the tome, go to {45}; the crystal ball, go to {159}. If you really do want to go back to your mop, go to {115}."
},
{ // 174
"Regardless of the spell, your speed is enhanced vs that of the fiend. You nimbly avoid its lunge and escape through the door. Once outside, the ferrid grumbles and hisses, but leaves you alone. It seems disappointed. Oh, well. Back to your mop. Go to {260}."
},
{ // 175
"Struggle as you might, you can't wriggle free. The slime of the thing eats into your flesh like acid, while the stench of it almost drives you insane. Worse still, your arms are pinned down by its many limbs. If you want to gather your strength for one frantic lunge, make a L3-SR on Strength (30 - ST). If you succeed, go to {248}. If you don't, go to {143}. If you scream for help, go to {211}."
},
{ // 176
"\"Sounds like a really nice place,\" you say, \"but I don't know if I can take you up on your offer now. Perhaps some other time?\" The demon sadly shakes his head. \"Sorry, kid. This is a once-in-a-lifetime deal. Who know when you'll be able to contact me again. Now, are you coming or not?\" If you decide to go with him, go to {91}. If you'd rather not, go to {75}."
},
{ // 177
"\"Sorry,\" you say, \"I'd rather not.\" Insi looks disappointed, then starts a conversation. You discuss things of minor importance and give Insi an idea of what goes on 'up there'. This does get boring though. If you want to explore the left passage, go to {161}. If you just want to leave and explore elsewhere, you may go to the eastern corridor (go to {10}), or to the study (go to {21})."
},
{ // 178
"You are one lucky pup. After what seems like a very long time, you notice movement in the study. It's the ferrid, and you never thought you'd ever want to see that pesky beast as much as you do now. \"Help! Help!\" you scream, banging soundlessly on the barrier. The ferrid slowly glances your way, runs a long pink tongue over its teeth, and smiles. A question mark appears in your mind, and you realize that it wants to know what enticements you'll offer if it gets you out. \"Anything...within reason,\" you think back at it. The ferrid shakes its head and starts to turn away. \"And let Servald decide what's reasonable!\" you add frantically. It stops. With infuriating slowness, it ambles over to the curtain, wraps a piece around one paw, and extends the wrapped paw to you. You grab, and you're back in the study again. As you are escorted out, visions of you feeding wiggling tidbits to a smiling ferrid and otherwise attending to its comfort flash through your mind. Pick up 50 ap and start paying your debt to that smug blue beast. Oh, yes. There's still the mopping to do, if the ferrid will ever let you get to it."
},
{ // 179
"Your mind panics for a moment at the strangeness and horror that you're viewing, but you control your fear and look away from the ball. You have just viewed a section of hell and maintained your sanity. Pick up 1 IQ point. If you wish to examine: the skull, go to {77}; the tome, go to {45}; the curtains, go to {82}. If you are finished with the study, go to {115}."
},
{ // 180
"You push past the curtain. A faint tingle runs through your body. Fortunately, nothing else happens. You find yourself in a roughly 15' by 15' chamber lit by the same faint light as the corridor. Along its walls are a number of shelves and benches covered with bottles, books and a bizarre apparatus. On the floor at the room's centre is a large pentagram. To one side of that is a reading stand with a large black-bound tome resting upon it. If you wish to examine the shelves, go to {189}. If you prefer to study the apparatus on the bench, go to {259}. If the tome is more to your liking, go to {119}."
},
{ // 181
"\"Uh, since I was just curious, could you let me go?\" you ask. \"Well, I'm not supposed to let me go,\" it says, then pauses a moment. \"But, if you did something for me, I might free you.\" This doesn't sound good, but you're in no position to bargain. \"Do what?\" you ask eagerly. \"A bit of polishing,\" it says. \"Servald isn't much of a housekeeper, and I don't like being dusty.\" It's better than just waiting for Servald, so you agree to dust the ball. Make a L1-SR on Intelligence (20 - IQ). If you are successful, go to {157}. If not, go to {203}."
},
{ // 182
"Leading down into the depth of Servald's castle is a narrow stone staircase. You tread warily on its slick steps, avoiding the occasional large rat or other, less identifiable creature, as it skitters out of your way. Coming to the bottom, you pass along a narrow corridor until you reach the door. From behind its slimed surface comes a strange gibbering wail, much louder than you remember. If you'd rather explore more quiet surroundings, you may go to the east corridor (go to {10}) or the study (go to {21}). If you're set on opening the door of strange noises, go to {132}."
},
{ // 183
"The apparatus groans, but nothing comes out. In fact, whatever you put in has gummed up the thing so badly that it explodes from the internal pressure, sending shards of glass, scorching hot liquids, etc., all over the room. Take 6 hits on your CON. If you survive, go to {258}. If not, Servald finds your glass-riddled body upon his return."
},
{ // 184
"A cloudiness forms in the ball's depths as you watch. Then all becomes clear and you see beautiful maidens, rich fruit, and other delicacies. Indeed, all that anyone could wish for lies revealed. Just when you think there is nothing more, you see something so beautiful, so magnificent, that it is almost more than you can bear. Make a L1-SR on Constitution (20 - CON). If you are successful, go to {192}. If not, go to {101}."
},
{ // 185
"You pass through the curtain without incident and make it safely back to the door, which lies slightly open. You slip out. Before you can close it, it shuts on its own. Pick up 25 ap and return to your mop (go to {260})."
},
{ // 186
"Phuuph! The sudden light, regardless of your reasons for casting it, startles the lock. It gasps and jerks, losing its hold on the doorjamb. \"Oh, rust!\" it says, and falls silent as the door swings slightly ajar. Pick up 10 ap for inventive spell use and go to {70}."
},
{ // 187
"You encounter no problems in making it back to the door, which is open. Keeping an eye out for that pesky ferrid, you sneak the tome into your room and close the door. You curl up on the bed, and settle down for a good read. Though the legibility of the writing is often questionable, what you can read you find fascinating. Make a L1-SR on Luck (20 - LK). If you make it, go to {251}. If you fail, go to {199}."
},
{ // 188
"\"Bye,\" you say, and start for the door. \"Hey! You didn't finish!\" \"That's right,\" you answer, and head down the stairs. \"Okay. You asked for it,\" the ball says, then shouts \"Help, master! Thieves, here to rob you!\" A blinding light flashes before you. Make a L1-SR on Dexterity (20 - DEX). If you make it, go to {72}. If not, go to {160}."
},
{ // 189
"The shelves are laden with numerous jars, bottles and vials, with labels such as 'mummy dust', 'oil of infant', and 'lizard extract'. There are a few unlabelled vials among them. A small selection of books is also present, ranging in subject from Thaumaturgy Made Easy to Edmund's Esoteric Evocations. If you care to examine the unlabelled vials, go to {202}. If you would like to examine the apparatus on the bench, go to {259}. If the tome is more to your liking, go to {119}."
},
{ // 190
"You scream and flail your arms wildly, trying to grasp anything you can to stop your fall. Make a L1-SR on DEX to halt your descent and/or land safely. If you are successful, go to {201}. If you aren't, go to {194}."
},
{ // 191
"You decide that you'd rather not follow what was frightening you back to its lair. Instead, you say goodbye to Insi and head off down the left-hand passage, which widens out to 6'. When your hand brushes the wall, it begins to give off a greenish light. Then the corridor turns. You turn with it, and find yourself facing a red silken curtain hung from wall to wall across your path. On it is a design, either of a stylized flower or a number of arrows pointed away from a common point, woven into the fabric in gold and black. You sense magic, both in the curtain itself and beyond. If you want to go on, go to {180}. If you'd rather leave, go to {129}."
},
{ // 192
"You are left in awe by what you have seen - a piece of heaven. You look away from the ball and ponder what you have been privileged to view. Pick up 1 IQ point. If you wish to check out: the skull, go to {77}; the tome, go to {45}; the curtains, go to {82}. If you've had enough of the study and want to leave, go to {115}."
},
{ // 193
"When you regain consciousness, you become of small, furry hands gently rubbing your cheeks. A timid voice says, \"Oh, *do* be alright! I didn't mean any harm.\" By the dim glow of a small ball of light, you see a strange creature. It is roughly 3' high, with a round, furry body, a timid, worried-looking face, and feet three sizes too big. Seeing that you are awake, it backs off, picks up the light-ball, and smiles nervously. You take stock of the situation. The door is totally impervious to magic. There is also no handle or latch on this side, so you can't open it from here. If you want to talk to the creature (does it know a way out?), go to {208}. If you want to explore on your own, go to {204}."
},
{ // 194
"You scream until you land at the bottom of the stairs. Kerthump! But how far did you fall? Roll 1d6. If you roll 1-2, go to {205}. If 3-4, go to {85}. If 5-6, you were almost at the top when you fell (some 80'), and are now quite dead. The ferrid saunters over and starts sampling your remains."
},
{ // 195
"[Only enchanted weapons affect this thing, which has an MR of 86 (9 hit dice). If your weapon is magical, ]keep hacking until it kills and eats you, body and soul, or you kill it (go to {122}).[ If you have ensorcelled your own weapon (Vorpal Blade or Enhance), and don't kill the thing in one combat round, or you didn't have a magical weapon to begin with, you are in a heap o' trouble. Make a L3-SR on Dexterity (30 - DEX). If you make it, go to {133}. If not, you are grabbed by this unspeakably loathsome thing. Go to {175}.]"
},
{ // 196
"You take a long, thin piece of metal you just happen to have in your belt pouch (your 'good luck piece', right?) and proceed to pick the lock. It isn't too happy about being poked, but there's nothing it can do about it in so short a time. The door swings open. Go to {70}."
},
{ // 197
"Ignoring the noise, you set off down the wider passage. Touching the walls here causes them to give off a greenish light. You travel on for a bit. Then the passage turns. Across the way at this point is red silk curtain hung so as to completely block the passage. This curtain has a design woven into it resembling a stylized flower or a group of arrows pointing away from a common point. You sense much magic. If you want to pass the curtain, go to {180}. If you would rather not, go to {129}."
},
{ // 198
"With your flickering flame, you venture into the darkness beyond the door. The floor is uneven stone, quite wet in spots. A smell of damp decay fills the air, and grows stronger with every step. The corridor itself is rough-hewn from the rock, about 4' wide and 6' high. Slowly you move forward trying to avoid the worst of the puddles. The muttering gets louder as you proceed. Then the corridor branches. To your right lies the source of the muttering. To your left, the passage widens out to about 6'. If you wish to go right, go to {215}. If left, go to {197}."
},
{ // 199
"The tome is so interesting that you don't notice your master's return. You remain unaware of that fact until you hear a low cough. You look up, and see your master standing in the doorway. He doesn't look at all pleased. He extends one hand for the tome, which you give him. Then he leads you by the ear to the moat, which hasn't been cleaned in a long time, and hands you a scrub brush. A small one. Pick up 80 ap and have fun cleaning te moat. Oh, and don't forget to finish the mopping when you're done."
},
{ // 200
"As you stare, the centre of the ball clouds and darkens. A picture slowly forms within. You see a neatly bearded old man seated in a comfortable chair reading a large book. As you watch, he glances up and stares straight at you. You recognize your master about the same time that he recognizes you. He frowns. Make a L1-SR on Luck (20 - LK). If you make it, go to {209}. If luck fails you, go to {74}."
},
{ // 201
"That was close. You managed to claw your way back onto the stairs and pant for a moment. But adventure still beckons. If you want to visit the east corridor room, go to {10}. If you prefer the door of strange noises, go to {182}. If you still want to visit the study, you crawl to the top of the stairs. Go to {212}."
},
{ // 202
"You gingerly pick up one of the unlabelled vials and examine it without opening it. After looking at all of these vials, you note that none of them appear to be empty. If you wish to open one of them (they are all sealed with wax) make a L1-SR on Luck (20 - LK). If you make it, go to {213}. If not, go to {230}. If you would rather not open one, go to {258}."
},
{ // 203
"You do your best to dust the ball off with your free hand. You even manage to get most of the dust out of the intertwined snakes that form the stand. \"I'm finished. Now let me go.\" \"I'll think about it,\" the ball says. Roll 1d6. If you roll an odd number, go to {210}. If you roll even, go to {220}."
},
{ // 204
"The creature seems harmless enough. Giving your head a final shake, you decide to ignore it, and go back to the fork in the corridor. The creature, which has been following you, dodges off down the right-hand passage. Shortly afterwards, you hear a door slam off in that direction. Exploration down the right passage reveals a small, closed door which refuses to open to brute force or magic. Exploring the left passage may bring better results. Go to {172}."
},
{ // 205
"Fortunately, you hadn't gotten very far. You fall about 30'. Take 6 hits. You can crawl back to your mop and forget the whole thing. In that case, pick up 50 ap. When Servald gets home he notices your injuries. After consulting the ferrid, the story is out. He heals you, and gives you the lecture on staying-out-of-places-you-shouldn't-be. Or you can cast a Restoration on yourself, rest up a bit, and then: a) attempt the stairs (return to {21}); b) go check out the east corridor room (go to {10}); c) try the door of strange noises (go to {182}). If you can't cast Restoration, ignore the rest and go directly to option a, b or c."
},
{ // 206
"Your improvised lockpick isn't very good and you spend quite a bit of time fumbling with the lock. It gets madder and madder. Suddenly it yells, \"Okay, you asked for it!\" Roll 2d6 and make at least a 5. If you are successful, go to {224}. If not, go to {214})."
},
{ // 207
"This spellroom is too small for dodging to be successful for long. And does the thing really have more tentacles now than it had when you started? You jump when you should have ducked and get thoroughly grabbed by the hideous black thing. Go to {175}."
},
{ // 208
"\"Who are you?\" you ask. The creature scrunches down, trying to look smaller than it already is. \"I'm Insi,\" it replies, curling into a ball of brown fluff. You try to speak in a quieter voice. \"Well, Insi, did you see where that thing that was chasing me went?\" \"Uh, that was me,\" it says, smiling sheepishly. \"I'm the one who makes the noise. The master wants me to. I didn't want to hurt anyone, though. Really, I didn't.\" You frown and rub your head gently. Further questioning reveals that Insi doesn't know of another way out. If you want to follow Insi back to its lair down the right-hand passage, go to {222}. If you want to explore the left passage, go to {191}."
},
{ // 209
"Servald stares at you a moment longer. Then he says \"Apprentice, get back to that mop NOW!\" You take off down the stairs, knocking over the surprised ferrid in your haste, and don't stop until you reach your mop. Pick up 75 ap. Back in the study, the figure in the crystal ball fades out with a faint chuckle."
},
{ // 210
"After an uncomfortably long pause, it sighs. \"Oh, alright. You can go.\" It frees you and goes dark. You back away. Pick up 25 ap. If you wish to examine: the skull, go to {77}; the tome, go to {45}; the curtains, go to {82}. If you'd rather just leave the study, go to {115}."
},
{ // 211
"You've done your best. Now you can only hope that the stories you've heard from other apprentices are true. \"Servald!\" you scream desperately as the thing prepares for the kill. \"Heeeeeelllp!!\" Make a L1-SR on Luck (20 - LK). If you are successful, go to {114}. If you are not, go to {124}."
},
{ // 212
"The study door is oak, with ornate iron hinges and lock. The lock is cast in the shape of a fat, round face with pursed lips and is, not surprisingly, locked. The keyhole lies between its lips. If you want to use magic to open it, choose a spell and go to the Magic Matrix. If you want to try picking the lock, make a L2-SR on Dexterity (25 - DEX). If success is yours, go to {196}. If you fail, go to {206}."
},
{ // 213
"The wax crumbles easily as you pry the stopper loose. Nothing leaps out at you. Your vial contains a clear, oily liquid that smells faintly of herbs. You may either touch/taste the contents of the vial (go to {229}) or leave well enough alone and examine the apparatus (go to {259}) or the tome (go to {119})."
},
{ // 214
"Why it never dawned on you that a wizard's study would have stronger safeguards than a mouthy lock will probably never be known. You smell ozone a second before you're hit by an incredibly powerful bolt of pure magical energy. Take 30 hits. If you still live, go to {83}. If not, you are a crispy critter, and very dead. Sorry, for you the story ends here."
},
{ // 215
"You cautiously make your way down the right-hand passage. The muttering grows louder as you approach. Then, suddenly, it stops. The silence is deafening as you pause. \"Yaaaiiiii!\" Almost in your ear, a loud scream shatters the stillness. If you run back the way you came, go to {226}. If you freeze in place, go to {167}."
},
{ // 216
"There is no way that you are going to keep your master from noticing that something's happened in here. You go back upstairs and greet Servald when he returns. He then goes promptly to his lab. This is followed by an immediate summons for you. Make a L2-SR on Intelligence (25 - IQ). If you make it, go to {112}. If you fail, go to {128}."
},
{ // 217
"\"Who are you?\" you ask, looking over the frightened creature. It is 3' high, covered with brown fur, with a round, worried face, and feet three sizes too big for it.\n" \
"  \"I'm Insi,\" it finally says. \"The master wants me to scare things away. I'm supposed to make a lot of noise, and they're supposed to run.\n" \
"  Further questioning yields little information, save that there is no other way out. Insi then invites you back to its home in the right-hand passage. If you accept the invitation, go to {222}. If you want to check out the left-hand passage, go to {191}."
},
{ // 218
"You grab the ball. It is pleasantly cool to touch. It is also immovable, and now you're stuck to it. Several futile attempts to escape prove that brute strength isn't enough. Since you can't use one hand (at the very least), magic is also out (your DEX is greatly impaired). If you wish to stay here until your master returns, go to {104}. If you want to examine the ball more closely, go to {168}. If you absolutely must get free and wish to cut yourself loose (assuming that you have a knife or other cutting tool), go to {228})."
},
{ // 219
"You should have suspected this room would be guarded against theft. The curtain reacts to the tome's presence by sending a bolt of raw power through your body. The tome falls to the floor, unharmed. You, however, have been thoroughly crisped, and are very dead."
},
{ // 220
"\"I said 'might',\" it says and keeps its hold. It also refuses to answer any of the curses, pleas, etc. that you direct at it. You can either wait for Servald's return (go to {181}), or, if you are truly desperate (assuming you have a cutting tool), cut yourself loose (go to {228})."
},
{ // 221
"Whether you increased your own speed or decreased the thing's matters little, the overall effect being the same. You may now try another spell (go to the Magic Matrix for paragraph {146}), fight it with weapons (go to {195}), or dodge (go to {256})."
},
{ // 222
"You follow your strange companion down the right-hand passage and into a small (7' diameter) room. At its centre are a low-set table and two cushions. \"It may be a while before the door will let you out,\" Insi explains. \"Meanwhile, would you care for a game of cards?\" It pulls out a deck of colourful cards, not much different from others you have seen as far as the suits used. If you want to play cards, go to {231}. If you're not interested, go to {177}."
},
{ // 223
"Whether you zapped your weapon with a spell, have an enchanted weapon, or are using an ordinary once, the result is the same. Before you can strike, the ferrid runs back to the door. You follow and find the door locked against you. When Servald returns, he finds a cheerful ferrid and a rather hungry apprentice. He lets you out, gives you something tedious to do, and goes off with the ferrid. Pick up 30 ap for the experience and get to work."
},
{ // 224
"It doesn't take much intelligence to realize the lock isn't bluffing. You jump quickly away from the door, in time to avoid the bolt of energy that scorches the spot where you were. You smell lots of ozone and scorched hair (yours). But which way did you jump? This landing is pretty narrow. Make a L1-SR on Luck (20 - LK). If you make it, go to {234}. If not, go to {244}."
},
{ // 225
"You lift the vial from its resting place and sample the liquid within. Roll 1d6. If you get:\n" \
"  1-2) You get a cloud of butterflies, which fly 'round your entire body, surrounding you with a glorious mantle of colour. All too soon it dissolves into mist. When you next look in a mirror, you have trouble recognizing yourself. Pick up 3 CHR points.\n" \
"  3-4) You receive a cat-type tail, which springs suddenly from your rump, furred to matched the colour of your hair. It isn't prehensile, but should, with practice, add to your chances of making any long leaps you try. You start wondering how you'll explain this development to your master. (Requires a 5th level Dis-Spell to remove.)\n" \
"  5-6) You are hit with an attack of the shakes - which leaves your muscles somewhat worse for wear. You do, however, avoid biting your tongue. Lose 1 ST point.\n" \
"  My, wasn't that interesting. You wish you could get that cinnamon-whatsit taste out of your mouth. Later, perhaps. If you want to explore a bit more, go to {258}. If you'd rather leave, go to {239}."
},
{ // 226
"With a tremendous leap, you jump away from the noise and land running. Slipping and stumbling on the rough, wet floor, you run faster than you ever thought you could. The terrible wail seems to be right on your heels. Make a L1-SR on Intelligence (20 - IQ). If you make it, go to {111}. If you don't, go to {126}."
},
{ // 227
"You decline the invitation and head back to the left passage. \"Touch the wall,\" says Insi, \"and it will give you light. And do be careful, won't you? Please? It's not very nice down that way.\"\n" \
"  The left passage widens to 6'. Touching the walls does produce a greenish light. The corridor goes on a while, then turns. Around that turn, a red silken curtain completely blocks further progress. It is plain, save for a design woven into the fabric in gold and black at eye level that is either a stylized flower or a group of arrows pointing away from a common point. You sense magic ahead. If you want to pass the curtain anyway, go to {180}. If you'd rather leave, go to {129}."
},
{ // 228
"You work a hand loose enough and draw your knife. Taking a deep breath, you gather your courage and try to slip the blade between your hand and the ball. You just *know* this is going to hurt. Make a L1-SR on Constitution (20 - CON). If you succeed, go to {123}. If you don't, go to {76}."
},
{ // 229
"Nothing ventured, nothing gained. Or should that be, 'no pain, no gain'? You gather up your courage and either sip or pour some of the vial's contents into your hand. Either way, the effect is the same. Roll 1d6 to determine what happens.\n" \
"  1) Super-strength vitamins: You feel much better now. Add 1 point to your CON.\n" \
"  2) Hair tonic: Your entire body, excepting face, palms and soles, is now covered with short, thick hair. Have fun explaining this to your master. If you do a good job and/or he's feeling nice, he might get rid of it for you. (Required a 4th level Dis-Spell to remove.)\n" \
"  3) Swamp muck extract: This one doesn't agree with you at all. You throw up everything you even *thought* of eating. Lose 1 CON point, permanently.\n" \
"  4) Essence of leprechaun: Gain a fondness for shamrocks and add 3 points to your Luck.\n" \
"  5) Tincture of light: Your entire body now glows faintly, but noticeably, in the dark. (Requires a 4th level Dis-Spell to remove.)\n" \
"  6) Snake venom: You writhe on the floor, feeling utterly miserable, for much too long. When the shakes and cramps stop, you are left with slight muscular tremors. Servald probably won't be asking you to polish his leaded crystal goblets anymore. Lose 1 point of DEX permanently.\n" \
"  After a few minutes to cope with what's happened to you, you consider your options. If you have finished your explorations and would like to leave, go to {239}. If you want to stay a bit longer, go to {258}."
},
{ // 230
"A sharp hiss follows the breaking of the vial's wax seal. You are enveloped in a blue mist that quickly fills your lungs. This should alarm you but it's such a soft, gentle mist. You fall into a very deep sleep and pass into death without even noticing. Rest in peace."
},
{ // 231
"\"Anything to pass the time,\" you say, and sit down on one of the cushions. The game Insi wants to play is an odd variant of poker, with betting. Anything of value (coins, clothes, etc.) can be bet. The rules seem fairly simple. If you still want to play, go to {238}. If you're not into gambling, go to {250}."
},
{ // 232
"You manage the spell without a single problem and are instantly invisible. It grabs you anyway as it has an excellent sense of smell. Not to mention touch. It wraps its long, black tentacles around your body. Go to {175}."
},
{ // 233
"Leaving the door open behind you, you are able to see almost as well as in daylight. The floor is rough and wet. The damp, musty odour of the place is strong, but doesn't bother you once you get used to it. The corridor itself is 4' wide and 6' high. As you continue, you notice that the muttering gets louder. Then the corridor divides. To your right, the source of the noise. To your left, the passage widens to 6' and continues on out of sight. If you want to go right, go to {155}. If Left, go to {197}."
},
{ // 234
"You land squarely on the step just below. The lock laughs. \"Try it again, and you'll get the same. I'm ready for you now!\" You decide that you didn't really want to visit the study after all. Pick up 10 ap. If you want to check out the secret room in the east corridor, go to {10}. If you'd rather explore the door of strange noises, go to {182}."
},
{ // 235
"Your hands gently caress the leather binding as you lift the tome from its stand and turn towards the door. Make a L5-SR on Luck (40 - LK). If you fail this, you are dead, dust, and gone. If you make it, you come to, face down on the floor. The tome is back on its stand. You have no desire to mess with it further (it wouldn't open if you tried, anyway). If you still wish to check out: the skull, go to {77}; the curtains, go to {82}; the crystal ball, go to {159}. If you want to leave the study, go to {115}."
},
{ // 236
"You look at the tray of powder-filled dishes, select the one that meets your fancy and add it to the main opening. The apparatus bubbles and hisses, shakes a bit, and finally prepares to pour something into the smoky glass vial. Make a L1-SR on Luck (20 - LK). If you succeed, go to {245}. If not, go to {183}."
},
{ // 237
"You sigh, and settle down for a long wait on the cold, uncomfortable floor. When Servald comes, you complain about the ferrid (\"It chased me!\"). Then the ferrid has its say. Servald listens to both of you, then sends you back to your mop, and the ferrid back to the fireside rug. Pick up 35 ap."
},
{ // 238
"Insi flexes its fingers and starts shuffling the deck. Then your companion deals out the cards. It's time to play. Gambling requires skill - and luck - to win. Make a L2-SR on Luck (25 - LK). If you succeed, go to {246}. If you fail, make a L1-SR on Luck (20 - LK). If you make this, go to {255}. If you don't, go to (93}. If you failed critically (ie. rolled less than 5), go to {105}."
},
{ // 239
"Much as you'd like to stay, you've been down here quite a while and should probably leave to avoid having your master catch you here. And something tells you that wouldn't be a good thing. Make a L1-SR on Luck (20 - LK). If you succeed, go to {185}. If not, go to {97}."
},
{ // 240
"If the total of your IQ, LK and CHR is greater than or equal to 30, the ferrid takes off down the corridor at a dead run, finally stopping under Servald's bed. It stays there for a long time. In fact, you don't see it again until your master gets home. You reach the door and leave. Pick up 20 ap and return to your mop (go to {260}). If the total is less than 30, the ferrid only becomes more intent on keeping you here. Go to {137}."
},
{ // 241
"This thing has lots of limbs, so it's going to be difficult to evade. In fact, it seems to be growing more tentacles as you watch. Make a L2-SR on Dexterity (25 - DEX). If you make it, go to {133}. If not, you get grabbed. Go to {175}."
},
{ // 242
"You grope your way down the corridor until you come to a branching of ways. The floor is rough and you occasionally step in a puddle as you proceed. A musty smell fills the air. The noise, which has been growing in volume as you came further in, seems to be coming from the right-hand passage. To your left, the passage feels wider. If you go right, go to {215}. If left, go to {197}."
},
{ // 243
"There's something nasty in here and you don't want to see what it is! You dive for the curtain, which emits a blinding flash of light after you pass through, and run for the exit. Stumbling along, you make it back to the door, which is slightly open. You dive through and head up the stairs, barely registering the sound of the door closing behind you. Pick up 30 ap. Mopping never felt so good. Go to {260}."
},
{ // 244
"This is definitely not your day. You jumped off the staircase entirely. Scrabbling madly, you grasp for purchase on anything remotely in reach. Make a L3-SR on Luck (30 - LK). If you make this, go to {254}. If not, go to {81}."
},
{ // 245
"With a final belch, the apparatus produces a liquid, which dribbles into the vial. It smells very strange, sort of cinnamon, with a hint of...fish? If you wish to taste/touch this liquid, go to {255}. If you'd rather let it alone and examine the rest of the room, go to {258}. If you're finished exploring and want to leave, go to {239}."
},
{ // 246
"You were very successful. Your winnings include 20 silver pieces, 50 copper pieces, and a small bag of dust[ which (so Insi says) will blind any living thing for 7 turns if it is thrown into its eyes]. Insi walks you back to the door, which can now be opened, and waves goodbye as you head back up the stairs. \"If you want to stop by and play cards again, just knock three times,\" the little creature calls after you. Then the door swings shut, and the wailing starts again. You smile, and think you might just take Insi up on that offer. Pick up 100 ap and return to mopping."
},
{ // 247
"You try to dodge, but you zig when you should have zagged. The hell-hand seizes you in its incredibly powerful, hot, scaly grip and slides back through the pentagram to its place of origin, where you meet its owner. The meeting is brief - and fatal - for you. Your final scream echoes through the lab for a long, long time."
},
{ // 248
"You tense every muscle to its limit and lunge for freedom. Surprised by your sudden strength, the thing flinches, allowing you to slip free. Take 5 hits on your CON from abrasions caused by contact with the thing's 'skin'. If you survive, you may use magic against it (go to the Magic Matrix for paragraph {146}) or yell for help (go to {211}). If you are killed, you are spared having to worry about escaping this room."
},
{ // 249
"Stopping suddenly, you turn - and a small furry creature runs into you with a squeak. It bounces back against a wall and watches you warily. Meanwhile, the door has closed, and no amount of pushing can budge it. The creature seems harmless enough. If you want to talk to it, go to {217}. If you would rather ignore it and explore b yourself, go to {204}."
},
{ // 250
"Insi is a bit disappointed, but offers to show you some card tricks instead. Those nimble furry fingers can do some amazing things with cards. Even on the back streets of home you've never seen anything like it. Then Insi offers to teach a few tricks to you. Make a L2-SR on Dexterity (25 - DEX). If you succeed, go to {95}. If not, go to {108}."
},
{ // 251
"Fortunately, you hear your master enter the main door. Slamming the tome shut, you grab it and bolt for the door of strange noises. You make it to the reading stand in record time, replace the tome, and run back to your room. Just before you reach it, you hear Servald call your name, and change course to meet him. \"Sleeping?\" he asks, handing you his cloak. \"No,\" you say, \"I was doing a little studying.\" Pick up 100 ap and 1 IQ point, and hope your master doesn't find out just *what* you were studying."
},
{ // 252
"\"Ah - I heard an awful shrieking down here, so I came to see what it was, and - uh - I just found it like this,\" you say, not meeting his eyes. \"I was trying to clean it up before - you - got - back?\" Servald isn't buying a word of this. \"Stupidity is one thing I don't tolerate,\" he says. \"If you're going to lie, do it right, or don't bother.\" He turns you into a bookend and puts you on a shelf, then sets about fixing up his lab. He might eventually change you back to your normal form - in a few hundred years or so."
},
{ // 253
"You just couldn't maintain the proper cadence in your chanting. Or maybe it was that unfortunate sneezing fit. As a consequence, the pentagram fails to activate fully. Whatever the spell normally calls up is swept aside by an immense, scaly, red hand that rises up out of the pentagram's centre and reaches for you. Make a L2-SR on Dexterity (25 - DEX). If you are successful, go to {117}. If you fail, go to {247}."
},
{ // 254
"'Lucky' should be your middle name, 'cause you really are. You grab onto the staircase a half spiral down from the landing. Shaking, you drag yourself back to safer ground. You sense a great increase in the level of magic at the door and decide not to push your luck by fooling with it again. If you want to explore the east corridor room, go to {10}. If you'd like to check out the door of strange noises, go to {182}."
},
{ // 255
"You did slightly better than break even. Pick up 30 coppers. Insi walks with you to the now-open door and tells you to feel free to drop in any time. \"Just knock three times,\" it calls as you leave. The door closes, and you head back to your mop. Pick up 50 ap."
},
{ // 256
"The spell helps your movement tremendously, but it doesn't compensate for the size of the room. Is it just your imagination, or does the thing have more tentacles now than it started with? Make a L2-SR on Dexterity (25 - DEX). If you make it, go to {133}. If not, you are grabbed. Go to {175}."
},
{ // 257
"You gingerly lift the tome from its stand, and tuck it under one arm. Then you lose no time heading for the exit. Make a L2-SR on Luck (25 - LK). If you succeed, go to {187}. If you don't, go to {219}."
},
{ // 258
"As you turn away from the former object of your interest, you notice that the room seems much darker than when you entered, almost as if the shadows were thickening and pressing in upon you. You sense some very bad magic vibes. If you bolt for the exit, make a L1-SR on Dexterity (20 - DEX). If you make it, go to {243}. If you fail, go to {109}. If you wait to see what's causing all of this, go to {146}."
},
{ // 259
"Upon the bench, which follows the wall halfway 'round the room, is a collection of glass, metal tubing, and other, less identifiable things which defies description. Along its length various vials bubble, gurgle and steam. There is one smoky glass vial at what appears to be the end of the apparatus, perhaps for collection of the final product. If you wish to add something to the apparatus (there are a number of powder samples next to it), go to {236}. If you would rather examine: the shelves, go to {189}; the tome, go to {119}."
},
{ // 260
"You are diligently mopping the corridor when Servald returns from his convention. He pats the ferrid as he drops his cloak on a chair for you to put away later, then asks, \"Anything unusual happen while I was out?\" \"Not a thing, sir,\" you say, somehow managing to keep a straight face. \"Fine, fine. Keep up the good work,\" he says, and heads for his favourite chair in front of the fire. The ferrid catches your eye and slowly winks one of its own, then curls up at Servald's feet. You suppress a chuckle. Pick up 100 ap and start thinking of things to do the *next* time your master's away."
},
};

MODULE SWORD wc_exits[WC_ROOMS][EXITS] =
{ {  10,  21, 182,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  22,  68,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3
  {  28,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4
  {  25,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5
  {   2,  30,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6
  {  45,  82, 159,  -1,  -1,  -1,  -1,  -1 }, //   7
  {  20,  39,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9
  {  21, 182,  15,  -1,  -1,  -1,  -1,  -1 }, //  10
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14
  {   1,  28,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15
  {   2,   1, 260,  -1,  -1,  -1,  -1,  -1 }, //  16
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17
  { 260,  28,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20
  {  10, 182,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27
  {   6,  62,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29
  {  35,   2, 260,  -1,  -1,  -1,  -1,  -1 }, //  30
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31
  {   1, 260,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35
  {  28,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36
  { 260,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38
  {  23,   1, 260,  -1,  -1,  -1,  -1,  -1 }, //  39
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44
  {  54, 235,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49
  {  64,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55
  {   2,   1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56
  { 260,  28,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61
  {  16,  35, 260,  -1,  -1,  -1,  -1,  -1 }, //  62
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63
  {  77,  45, 159,  -1,  -1,  -1,  -1,  -1 }, //  64
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65
  {  17,  75,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67
  {   6,  30,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69
  {  77,  45,  82, 159,  -1,  -1,  -1,  -1 }, //  70
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72
  {  77,  82, 159,  10, 182, 260,  -1,  -1 }, //  73
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76
  {   7, 120,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79
  {  77,  82, 159,  10, 182, 260,  -1,  -1 }, //  80
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81
  {  90, 102, 115,  -1,  -1,  -1,  -1,  -1 }, //  82
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85
  {  77,  82, 159,  10, 182, 260,  -1,  -1 }, //  86
  { 113, 125,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89
  {  99, 151, 102,  -1,  -1,  -1,  -1,  -1 }, //  90
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93
  { 102,  77,  45, 159, 115,  -1,  -1,  -1 }, //  94
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98
  {  66, 176, 102,  -1,  -1,  -1,  -1,  -1 }, //  99
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101
  {  71, 173,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106
  {  77,  45, 159, 115,  -1,  -1,  -1,  -1 }, // 107
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110
  { 249,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114
  {  92,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116
  { 239, 258,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117
  { 102,  77,  45, 159, 115,  -1,  -1,  -1 }, // 118
  { 131, 259, 189,  -1,  -1,  -1,  -1,  -1 }, // 119
  {  45,  82, 159,  -1,  -1,  -1,  -1,  -1 }, // 120
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121
  { 139, 216,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122
  { 115,  77,  45,  82,  -1,  -1,  -1,  -1 }, // 123
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125
  { 180, 129,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126
  { 102,  77,  45, 159, 115,  -1,  -1,  -1 }, // 127
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130
  { 141, 257, 258,  -1,  -1,  -1,  -1,  -1 }, // 131
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133
  {  77,  45, 159, 115,  -1,  -1,  -1,  -1 }, // 134
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138
  { 153, 252,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141
  {  70,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148
  {  64,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150
  {  77,  45, 159, 115,  -1,  -1,  -1,  -1 }, // 151
  { 193,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153
  { 102,  77,  45, 159, 115,  -1,  -1,  -1 }, // 154
  { 222, 227,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156
  { 166, 188,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157
  {  70,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158
  { 218,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160
  { 180, 129,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161
  { 102,  77,  45, 159, 115,  -1,  -1,  -1 }, // 162
  { 104, 228,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163
  { 239, 258,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164
  {  77,  45, 159, 115,  -1,  -1,  -1,  -1 }, // 165
  {  77,  45,  82, 115,  -1,  -1,  -1,  -1 }, // 166
  { 222, 191,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167
  { 181, 163,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171
  { 180, 129,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172
  {  77,  45, 159, 115,  -1,  -1,  -1,  -1 }, // 173
  { 260,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 174
  { 211,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 175
  {  91,  75,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176
  { 161,  10,  21,  -1,  -1,  -1,  -1,  -1 }, // 177
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 178
  {  77,  45,  82, 115,  -1,  -1,  -1,  -1 }, // 179
  { 189, 259, 119,  -1,  -1,  -1,  -1,  -1 }, // 180
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181
  {  10,  21, 132,  -1,  -1,  -1,  -1,  -1 }, // 182
  { 258,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 183
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 184
  { 260,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 185
  {  70,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 186
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 187
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 188
  { 202, 259, 119,  -1,  -1,  -1,  -1,  -1 }, // 189
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 190
  { 180, 129,  -1,  -1,  -1,  -1,  -1,  -1 }, // 191
  {  77,  45,  82, 115,  -1,  -1,  -1,  -1 }, // 192
  { 208, 204,  -1,  -1,  -1,  -1,  -1,  -1 }, // 193
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 194
  { 122,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 195
  {  70,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 196
  { 180, 129,  -1,  -1,  -1,  -1,  -1,  -1 }, // 197
  { 215, 197,  -1,  -1,  -1,  -1,  -1,  -1 }, // 198
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 199
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 200
  {  10, 182, 212,  -1,  -1,  -1,  -1,  -1 }, // 201
  { 258,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 202
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 203
  { 172,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 204
  {  21,  10, 182,  -1,  -1,  -1,  -1,  -1 }, // 205
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 206
  { 175,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 207
  { 222, 191,  -1,  -1,  -1,  -1,  -1,  -1 }, // 208
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 209
  {  77,  45,  82, 115,  -1,  -1,  -1,  -1 }, // 210
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 211
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 212
  { 229, 259, 119,  -1,  -1,  -1,  -1,  -1 }, // 213
  {  83,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 214
  { 226, 167,  -1,  -1,  -1,  -1,  -1,  -1 }, // 215
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 216
  { 222, 191,  -1,  -1,  -1,  -1,  -1,  -1 }, // 217
  { 104, 168,  -1,  -1,  -1,  -1,  -1,  -1 }, // 218
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 219
  { 181,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 220
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 221
  { 231, 177,  -1,  -1,  -1,  -1,  -1,  -1 }, // 222
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 223
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 224
  { 258, 239,  -1,  -1,  -1,  -1,  -1,  -1 }, // 225
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 226
  { 180, 129,  -1,  -1,  -1,  -1,  -1,  -1 }, // 227
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 228
  { 239, 258,  -1,  -1,  -1,  -1,  -1,  -1 }, // 229
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 230
  { 238, 250,  -1,  -1,  -1,  -1,  -1,  -1 }, // 231
  { 175,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 232
  { 155, 197,  -1,  -1,  -1,  -1,  -1,  -1 }, // 233
  {  10, 182,  -1,  -1,  -1,  -1,  -1,  -1 }, // 234
  {  77,  82, 159, 115,  -1,  -1,  -1,  -1 }, // 235
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 236
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 237
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 238
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 239
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 240
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 241
  { 215, 197,  -1,  -1,  -1,  -1,  -1,  -1 }, // 242
  { 260,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 243
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 244
  { 225, 258, 239,  -1,  -1,  -1,  -1,  -1 }, // 245
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 246
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 247
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 248
  { 217, 204,  -1,  -1,  -1,  -1,  -1,  -1 }, // 249
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 250
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 251
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 252
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 253
  {  10, 182,  -1,  -1,  -1,  -1,  -1,  -1 }, // 254
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 255
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 256
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 257
  { 146,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 258
  { 236, 189, 119,  -1,  -1,  -1,  -1,  -1 }, // 259
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 260
};

MODULE STRPTR wc_pix[WC_ROOMS] =
{ "", //   0
  "",
  "",
  "",
  "",
  "", //   5
  "",
  "",
  "",
  "",
  "wc10", //  10
  "",
  "",
  "",
  "",
  "", //  15
  "",
  "",
  "",
  "",
  "", //  20
  "wc21",
  "",
  "",
  "",
  "", //  25
  "",
  "",
  "",
  "",
  "", //  30
  "",
  "",
  "",
  "",
  "", //  35
  "",
  "",
  "",
  "",
  "wc40", //  40
  "",
  "",
  "",
  "",
  "", //  45
  "",
  "",
  "",
  "",
  "wc50", //  50
  "",
  "",
  "",
  "",
  "", //  55
  "",
  "",
  "",
  "",
  "", // 60
  "",
  "",
  "",
  "",
  "", // 65
  "",
  "wc67",
  "",
  "",
  "wc70", // 70
  "",
  "",
  "",
  "",
  "", // 75
  "",
  "",
  "",
  "wc79",
  "", // 80
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "", // 90
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "", // 100
  "",
  "",
  "",
  "",
  "",
  "", // 106
  "wc107",
  "",
  "",
  "", // 110
  "",
  "",
  "",
  "",
  "",
  "",
  "wc117", // %%: this illustration might conceivably belong to a different paragraph
  "wc118",
  "",
  "", // 120
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "", // 130
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "", // 140
  "",
  "",
  "",
  "",
  "",
  "",
  "wc147",
  "",
  "",
  "", // 150
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "", // 160
  "wc161", // we could use this for various additional paragraphs also
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "wc169",
  "", // 170
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "wc178",
  "",
  "", // 180
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "", // 190
  "",
  "",
  "",
  "",
  "wc195",
  "",
  "",
  "",
  "",
  "", // 200
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "wc208",
  "",
  "", // 210
  "",
  "",
  "",
  "wc-p33",
  "",
  "",
  "",
  "",
  "wc-p33",
  "", // 220
  "",
  "",
  "",
  "wc224",
  "",
  "",
  "",
  "",
  "",
  "", // 230
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "wc240", // 240
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "wc249",
  "", // 250
  "",
  "",
  "wc253",
  "",
  "",
  "",
  "",
  "",
  "",
  "wc260", // 260
};

IMPORT TEXT                   name[80 + 1];
IMPORT int                    age,
                              armour,
                              bankcp,
                              been[MOST_ROOMS + 1],
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              good_attacktotal,
                              good_damagetaken,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              prevroom, room, module,
                              round,
                              spellchosen,
                              spellcost,
                              spelllevel,
                              spellpower,
                              thethrow;
IMPORT const int              races_table[37];
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR*          descs[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct RacesStruct     races[RACES];
IMPORT struct SpellStruct     spell[SPELLS];

IMPORT void (* enterroom) (void);

MODULE void wc_enterroom(void);
// MODULE void wc_wandering(FLAG mandatory);

EXPORT void wc_preinit(void)
{   descs[MODULE_WC]   = wc_desc;
 // wanders[MODULE_WC] = wc_wandertext;
}

EXPORT void wc_init(void)
{   int i;

    exits     = &wc_exits[0][0];
    enterroom = wc_enterroom;
    for (i = 0; i < WC_ROOMS; i++)
    {   pix[i] = wc_pix[i];
}   }

MODULE void wc_enterroom(void)
{   int result;

    switch (room)
    {
    case 2:
        savedrooms(1, lk, 32, 26);
    acase 3:
        castspell(-1, FALSE);
    acase 4:
        healall_st();
        gain_con(1);
    acase 5:
        while (castspell(-1, FALSE) && room == 5)
        {   ;
        }
        if (room == 5)
        {   if (!getyn("Talk to lock"))
            {   savedrooms(2, dex, 196, 206);
        }   }
    acase 7:
        if (!getyn("Examine"))
        {   award(50);
            room = 115;
        }
    acase 9:
        die();
    acase 11:
        if (!castspell(-1, FALSE))
        {   getsavingthrow(TRUE);
            result = madeitby(2, st);
            if (result >= 0)
            {   room = 18;
            } elif (result > -5)
            {   getsavingthrow(TRUE);
                result = madeitby(1, lk);
                if (result >= 0)
                {   room = 260;
                } else
                {   room = 3; // %%: it doesn't say what happens if you fail the LK roll by less than 5
            }   }
            else
            {   room = 3;
        }   }
    acase 12:
        gain_iq(1);
        victory(100);
    acase 13:
        die();
    acase 14:
        if (iq + chr + lk >= 34) // %%: it's ambiguous about what to do if it is exactly equal
        {   room = 18;
        } else
        {   room = 48;
        }
    acase 17:
        savedrooms(3, lk, 178, -1);
    acase 19:
        savedrooms(2, st, 36, 57);
    acase 20:
        savedrooms(2, dex, 32, 13);
    acase 21:
        if (getyn("Enter study"))
        {   savedrooms(1, dex, 34, 190);
        }
    acase 22:
        dicerooms(4, 4, 11, 11, 19, 19);
    acase 23:
        savedrooms(2, dex, 32, 40);
    acase 24:
        dicerooms(29, 29, 29, 12, 12, 27);
    acase 25:
        DISCARD castspell(-1, FALSE);
        if (room == 25)
        {   savedrooms(2, dex, 196, 206);
        }
    acase 26:
    case 27:
        die();
    acase 31:
        victory(75);
    acase 33:
        victory(100);
    acase 34:
        while (castspell(-1, FALSE) && room == 34)
        {   ;
        }
        if (room == 34)
        {   savedrooms(2, dex, 196, 206);
        }
    acase 35:
        savedrooms(2, lk, 8, 56);
    acase 36:
        gain_st(3);
    acase 37:
        dispose_npcs();
        award(15);
    acase 38:
        victory(110);
    acase 40:
    case 41:
    case 42:
    case 43:
        die();
    acase 44:
        savedrooms(1, dex, 63, 89);
    acase 46:
        // assert(npc[0].mr);
        payload(TRUE);
        if (countfoes() && saved(1, lk))
        {   dispose_npcs();
            victory(100);
        } else
        {   die(); // calls dispose_npcs()
        }
    acase 47:
        victory(75);
    acase 48:
        die();
    acase 49:
        // we already awarded 30 ap when it died (via USE_AP)
        victory(100);
    acase 50:
        good_takehits(dice(2), TRUE);
        dispose_npcs();
    acase 51:
        learnspell(SPELL_DS);
        gain_iq(2);
        victory(150);
    acase 52:
        die();
    acase 53:
        dispose_npcs();
        victory(100);
    acase 54:
        dicerooms(9, 65, 65, 65, 24, 24);
    acase 55:
        die();
    acase 56:
        if (getyn("Mop"))
        {   award(10);
            room = 260;
        }
    acase 57:
        permlose_con(3);
    acase 58:
        if (iq > 12)
        {   room = 70;
        } elif (getyn("Fight"))
        {   room = 92;
        } else
        {   dicerooms(158, 158, 171, 171, 144, 144);
        }
    acase 59:
        // we already awarded 30 ap when it died (via USE_AP)
        victory(100);
    acase 60:
        room = (iq >= 20) ? 50 : 94;
    acase 61:
        victory(100);
    acase 63:
        savedrooms(1, dex, 98, 106);
    acase 64:
        if (getyn("Mop"))
        {   award(50);
            room = 260;
        }
    acase 65:
        dicerooms(73, 73, 80, 80, 86, 86);
    acase 67:
        dispose_npcs();
        elapse(ONE_DAY * 7, FALSE); // %%: we're assuming this is unhealable time
        victory(75);
    acase 69:
        elapse(ONE_DAY * 3, TRUE);
        gain_iq(1);
        victory(100);
    acase 71:
        savedrooms(1, iq, 79, 165);
    acase 72:
        if (saved(2, lk))
        {   victory(75);
        } else
        {   die();
        }
    acase 73:
        if (iq < 12)
        {   change_iq(12);
        }
        if (dex < 9)
        {   change_dex(9);
        }
        learnspell(SPELL_OE);
    acase 74:
        elapse(ONE_DAY * 7, TRUE);
        victory(100);
    acase 75:
        create_monster(483);
        if (!castspell(-1, FALSE))
        {   if (getyn("Fight"))
            {   room = 140;
            } else
            {   room = 162;
        }   }
    acase 76:
        victory(50);
    acase 78:
        victory(100);
    acase 79:
        dicerooms(107, 107, 44, 44, 87, 87);
    acase 80:
        if (iq < 14)
        {   change_iq(14);
        }
        if (dex < 10)
        {   change_dex(10);
        }
        learnspell(SPELL_WI);
    acase 81:
        die();
    acase 83:
        healall_con();
        victory(30);
    acase 84:
        // assert(npc[0].mr);
        payload(TRUE);
        if (!countfoes())
        {   room = 59;
        } elif (npc[0].mr <= 15)
        {   room = 37;
        } else
        {   do
            {   oneround();
                if (!countfoes())
                {   room = 59;
                } elif (npc[0].mr <= 15)
                {   room = 37;
            }   }
            while (room == 84 && con > 0);
        }
    acase 85:
        if (saved(1, con))
        {   healall_con();
            permlose_con(1);
            victory(30);
        } else
        {   die();
        }
    acase 86:
        if (iq < 14)
        {   change_iq(14);
        }
        if (dex < 10)
        {   change_dex(10);
        }
        learnspell(SPELL_HF);
    acase 88:
        victory(25);
    acase 89:
        templose_con(dice(1));
        savedrooms(2, lk, 47, 55);
    acase 91:
        savedrooms(3, lk, 178, -1);
    acase 92:
        create_monster(482);
        if (!castspell(-1, FALSE))
        {   room = 103;
        }
    acase 93:
        if (money)
        {   pay_cp_only((cp / 3) * 2);
            pay_sp_only((sp / 3) * 2);
            pay_gp_only((gp / 3) * 2);
        }
        victory(50);
    acase 95:
        gain_dex(1);
    acase 96:
        create_monster(482);
        if (!castspell(-1, FALSE))
        {   if (getyn("Return to mop"))
            {   dispose_npcs();
                room = 260;
            } else
            {   room = 138;
        }   }
    acase 97:
        templose_con(13);
        victory(40);
    acase 98:
        victory(75);
    acase 100:
    case 101:
        die();
    acase 103:
        {   FLAG first = TRUE;

            // assert(npc[0].mr);

            do
            {   if ((prevroom == 130 && first) || saved(1, dex))
                {   first = FALSE;
                    oneround();
                } else
                {   evil_freeattack();
                }
                if (!countfoes())
                {   room = 49;
                } elif (npc[0].mr <= 15)
                {   room = 37;
            }   }
            while (room == 103 && con > 0);
        }
    acase 104:
        elapse(ONE_DAY, TRUE);
        gain_dex(1);
        victory(100);
    acase 105:
        drop_all();
        victory(50);
    acase 106:
        templose_con(dice(1));
        savedrooms(2, dex, 31, 43);
    acase 107:
        {   const int dietospell[6] = { SPELL_MI, SPELL_RS, SPELL_CC, SPELL_OE, SPELL_DS, SPELL_WI };
                  int result;

            result = dietospell[dice(1)];
            if (spell[result].known)
            {   result = dietospell[dice(1)];
                if (spell[result].known)
                {   gain_iq(1);
                } else
                {   learnspell(result);
            }   }
            else
            {   learnspell(result);
            }

            award(50);
        }
    acase 108:
        gain_iq(1);
        victory(75);
    acase 109:
        templose_con(13);
        victory(60);
    acase 110:
        // assert(npc[0].mr);
        if (iq + lk + chr >= 30)
        {   dispose_npcs();
            room = 260;
        } else
        {   evil_freeattack();
            if (!castspell(-1, FALSE))
            {   room = 103;
        }   }
    acase 111:
        if (getyn("Leap through door"))
        {   savedrooms(1, dex, 88, 136);
        }
    acase 112:
        victory(100);
    acase 113:
        elapse(ONE_YEAR, TRUE);
        getsavingthrow(TRUE);
        result = madeitby(3, lk);
        if (result >= 0)
        {   room = 51;
        } elif (result >= -5)
        {   room = 78;
        } else
        {   room = 100;
        }
    acase 114:
        dispose_npcs();
        victory(100);
    acase 115:
        if (getyn("Wait"))
        {   dicerooms(33, 33, 96, 96, 144, 144);
        }
    acase 116:
        // assert(npc[0].mr);
        do
        {   if (saved(1, dex))
            {   oneround();
            } else
            {   evil_freeattack();
            }
            if (!countfoes())
            {   room = 49;
            } elif (npc[0].mr <= 15)
            {   room = 37;
        }   }
        while (room == 116 && con > 0);
    acase 117:
        award(30);
    acase 121:
        // assert(npc[0].mr);
        if (saved(1, lk))
        {   dispose_npcs();
            room = 260;
        } else
        {   evil_freeattack();
            if (!castspell(-1, FALSE))
            {   room = 103;
        }   }
    acase 122:
        ; // we already awarded 86 ap when it died (via USE_AP)
    acase 123:
        templose_con(2);
    acase 124:
        die();
    acase 125:
        savedrooms(1, lk, 134, 147);
    acase 128:
        // we could implement tweezers as an item
        victory(75);
    acase 129:
        create_monster(482);
        if (!castspell(-1, FALSE))
        {   if (getyn("Fight"))
            {   room = 223;
            } else
            {   room = 237;
        }   }
    acase 130:
        if (getyn("Return to mop"))
        {   dispose_npcs();
            room = 260;
        } else
        {   if (!castspell(-1, FALSE))
            {   room = 103;
        }   }
    acase 132:
        do
        {   give(TOR);
            result = makelight();
            if (result == LIGHT_CE)
            {   room = 233;
            } elif (result != LIGHT_NONE)
            {   room = 198;
        }   }
        while (room == 132);
    acase 133:
        // assert(npc[0].mr);
        if (!castspell(-1, FALSE))
        {   room = 207;
        }
    acase 134:
        award(10);
    acase 135:
        result = makelight();
        if (result == LIGHT_CE)
        {   room = 233;
        } elif (result == LIGHT_NONE)
        {   room = 242;
        } else
        {   room = 198;
        }
    acase 136:
        savedrooms(1, lk, 152, 145);
    acase 137:
        dispose_npcs();
        victory(30);
    acase 138:
        savedrooms(3, lk, 67, 260);
    acase 140:
        // assert(npc[0].mr);
        good_freeattack();
        if (!countfoes())
        {   room = 149;
        } else
        {   room = 154;
        }
    acase 141:
        savedrooms(1, iq, 164, 253);
    acase 143:
        die();
    acase 144:
        create_monster(482);
        evil_freeattack();
        if (!castspell(-1, FALSE))
        {   room = 116;
        }
    acase 145:
        die();
    acase 146:
        create_monster(484);
        if (!castspell(-1, FALSE))
        {   if (getyn("Fight"))
            {   room = 195;
            } else
            {   room = 241;
        }   }
    acase 147:
        savedrooms(1, con, 38, 156);
    acase 148:
        dispose_npcs();
        victory(30);
    acase 149:
        good_takehits(dice(2), TRUE);
        dispose_npcs();
    acase 150:
        // assert(npc[0].mr);
        if (iq >= 86)
        {   kill_npcs();
            room = 260;
        } else
        {   room = 175;
        }
    acase 152:
        good_takehits(dice(2), TRUE);
    acase 153:
        elapse(ONE_DAY * 7, TRUE);
        victory(100);
    acase 154:
        dispose_npcs();
    acase 156:
        savedrooms(4, lk, 69, -1);
    acase 159:
        if (getyn("Look into ball"))
        {   dicerooms(169, 169, 184, 184, 200, 200);
        }
    acase 160:
        die();
    acase 164:
        do
        {   result = getspell("Learn which spell (ªENTERª key for none, ª?ª for list)");
            if (result != -1)
            {   if (spell[result].known)
                {   aprintf("You already know that spell!\n");
                } elif (spell[result].level != 3)
                {   aprintf("That is not a level 3 spell!\n");
                } else
                {   learnspell(result);
                    result = -1;
        }   }   }
        while (result != -1);
    acase 165:
        award(20);
    acase 166:
        award(25);
    acase 169:
        savedrooms(1, iq, 179, 41);
    acase 170:
        if (saved(2, dex))
        {   if (getyn("Fight"))
            {   room = 195;
            } else
            {   room = 207;
        }   }
        else
        {   die(); // %%: it doesn't say what happens if you miss the saving roll
        }
    acase 171:
        do
        {   castspell(-1, FALSE);
        } while (room == 171);
    acase 174:
        dispose_npcs();
    acase 175:
        if (getyn("Lunge"))
        {   savedrooms(3, st, 248, 143);
        }
    acase 178:
        victory(50);
    acase 179:
        gain_iq(1);
    acase 181:
        savedrooms(1, iq, 157, 203);
    acase 183:
        good_takehits(6, TRUE);
    acase 184:
        savedrooms(1, con, 192, 101);
    acase 185:
        award(25);
    acase 186:
        award(10);
    acase 187:
        savedrooms(1, lk, 251, 199);
    acase 188:
        savedrooms(1, dex, 72, 160);
    acase 190:
        savedrooms(1, dex, 201, 194);
    acase 192:
        gain_iq(1);
    acase 194:
        dicerooms(205, 205, 85, 85, -1, -1);
    acase 195:
        fight();
    acase 199:
        victory(80);
    acase 200:
        savedrooms(1, lk, 209, 74);
    acase 202:
        if (getyn("Open a vial"))
        {   savedrooms(1, lk, 213, 230);
        }
    acase 203:
        dicerooms(210, 220, 210, 220, 210, 220);
    acase 205:
        good_takehits(6, TRUE);
        cast(SPELL_RS, TRUE);
    acase 206:
        if (dice(2) >= 5) room = 224; else room = 214;
    acase 209:
        victory(75);
    acase 210:
        award(25);
    acase 211:
        savedrooms(1, lk, 114, 124);
    acase 212:
        if (!castspell(-1, FALSE))
        {   savedrooms(2, dex, 196, 206);
        }
    acase 214:
        good_takehits(30, TRUE);
    acase 216:
        savedrooms(2, iq, 212, 128);
    acase 218:
        {   FLAG ok = FALSE;
            int  i;

            for (i = 0; i < ITEMS; i++)
            {   if (items[i].owned && items[i].type == WEAPON_DAGGER)
                {   ok = TRUE;
                    break; // for speed
            }   }
            if (ok && getyn("Cut yourself loose"))
            {   room = 228;
        }   }
    acase 219:
        die();
    acase 220:
        {   FLAG ok = FALSE;
            int  i;

            for (i = 0; i < ITEMS; i++)
            {   if (items[i].owned && items[i].type == WEAPON_DAGGER)
                {   ok = TRUE;
                    break; // for speed
            }   }
            if (ok && getyn("Cut yourself loose"))
            {   room = 228;
        }   }
    acase 221:
        if (!castspell(-1, FALSE))
        {   if (getyn("Fight"))
            {   room = 195;
            } else
            {   room = 256;
        }   }
    acase 223:
        dispose_npcs();
        victory(30);
    acase 224:
        savedrooms(1, lk, 234, 244);
    acase 225:
        switch (dice(1))
        {
        case 1:
        case 2:
            gain_chr(3);
        acase 3:
        case 4:
            gain_flag_ability(144);
        acase 5:
        case 6:
            permlose_st(1); // %%: we are assuming this is permanent
        }
    acase 226:
        savedrooms(1, iq, 111, 126);
    acase 228:
        savedrooms(1, con, 123, 76);
    acase 229:
        switch (dice(1))
        {
        case 1:
            gain_con(1); // %%: we assume this is permanent
        acase 2:
            gain_flag_ability(145);
        acase 3:
            permlose_con(1);
        acase 4:
            gain_lk(3);
        acase 5:
            gain_flag_ability(146);
        acase 6:
            lose_dex(1);
        }
    acase 230:
        die();
    acase 234:
        award(10);
    acase 235:
        if (!saved(5, lk))
        {   die();
        }
    acase 236:
        savedrooms(1, lk, 245, 183);
    acase 237:
        dispose_npcs();
        victory(35);
    acase 238:
        if (saved(2, lk))
        {   room = 246;
        } else
        {   getsavingthrow(TRUE);
            result = madeitby(1, lk);
            if (result >= 0)
            {   room = 255;
            } elif (thethrow < 5)
            {   room = 105;
            } else
            {   room = 93;
        }   }
    acase 239:
        savedrooms(1, lk, 185, 97);
    acase 240:
        if (iq + lk + chr >= 30)
        {   dispose_npcs();
            award(20);
            room = 260;
        } else
        {   room = 137;
        }
    acase 241:
        savedrooms(2, dex, 133, 175);
    acase 243:
        award(30);
    acase 244:
        savedrooms(3, lk, 254, 81);
    acase 246:
        give_sp(20);
        give_cp(50);
        give(813);
        victory(100);
    acase 247:
        die();
    acase 248:
        good_takehits(5, TRUE);
        if (!castspell(-1, FALSE))
        {   room = 211;
        }
    acase 250:
        savedrooms(2, dex, 95, 108);
    acase 251:
        gain_iq(1);
        victory(100);
    acase 252:
        die(); // %%: perhaps we should elapse(300 * ONE_YEAR, FALSE); victory(0); instead?
        // If they continued to age, they would die of old age first.
    acase 253:
        savedrooms(2, dex, 117, 247);
    acase 255:
        give_cp(30);
        victory(50);
    acase 256:
        savedrooms(2, dex, 133, 175);
    acase 257:
        savedrooms(2, lk, 187, 219);
    acase 258:
        if (getyn("Bolt for the exit"))
        {   savedrooms(1, dex, 243, 109);
        }
    acase 260:
        victory(100);
}   }

#define is ==
#define or ||
EXPORT void wc_magicmatrix(void)
{   int spellroom;

    if
    (   (room == 132 && (spellchosen == SPELL_WO || spellchosen == SPELL_CE))
     || (room == 135 && (spellchosen == SPELL_WO || spellchosen == SPELL_CE))
     || (room == 205 &&  spellchosen == SPELL_RS)
    )
    {   fulleffect();
        return;
    } // implied else

    aprintf(
"`MAGIC MATRIX\n" \
"  Find the number of the paragraph that sent you here (or the one to which you were referred) in the extreme left-hand column. Then find the spell you cast, and read the result.\n~"
    );

    if
    (   room is 5
     or room is 25
     or room is 171
    )
    {   spellroom = 34;
    } elif (room is 84)
    {   spellroom = 92;
    } elif
    (   room is 133
     or room is 221
     or room is 248
    )
    {   spellroom = 146;
    } else
    {   spellroom = room;
    }

    switch (spellchosen)
    {
    case SPELL_TF:
        if
        (   spellroom is 11
         or spellroom is 3
        )
        {   room = 42;
        } elif
        (   spellroom is 34
         or spellroom is 212
        )
        {   room = 58;
        } elif (spellroom is 75)
        {   room = 60;
        } elif
        (   spellroom is 92
         or spellroom is 110
         or spellroom is 121
         or spellroom is 130
         or spellroom is 144
        )
        {   room = 84;
        } elif (spellroom is 96)
        {   room = 46;
        } elif (spellroom is 146)
        {   room = 150;
        } elif (spellroom is 129)
        {   noeffect();
        } else noeffect();
    acase SPELL_PA: // "OGA"
        if
        (   spellroom is 11
         or spellroom is 3
        )
        {   room = 14;
        } elif
        (   spellroom is 34
         or spellroom is 75
         or spellroom is 96
         or spellroom is 212
        )
        {   noeffect();
        } elif
        (   spellroom is 92
         or spellroom is 121
         or spellroom is 130
         or spellroom is 144
        )
        {   room = 110;
        } elif (spellroom is 146)
        {   room = 170;
        } elif (spellroom is 129)
        {   room = 240;
        } else noeffect();
    acase SPELL_KK:
        if
        (   spellroom is 11
         or spellroom is 3
        )
        {   room = 52;
        } elif (spellroom is 34)
        {   room = 5;
        } elif
        (   spellroom is 75
         or spellroom is 92
         or spellroom is 110
         or spellroom is 121
         or spellroom is 130
         or spellroom is 96
         or spellroom is 144
         or spellroom is 146
         or spellroom is 129
        )
        {   noeffect();
        } elif (spellroom is 212)
        {   room = 35;
        } else noeffect();
    acase SPELL_RE: // "OTIS"
        if
        (   spellroom is 11
         or spellroom is 3
        )
        {   room = 52;
        } elif
        (   spellroom is 34
         or spellroom is 212
        )
        {   room = 142;
        } elif
        (   spellroom is 75
         or spellroom is 92
         or spellroom is 110
         or spellroom is 121
         or spellroom is 130
         or spellroom is 96
         or spellroom is 144
         or spellroom is 146
         or spellroom is 129
        )
        {   noeffect();
        } else noeffect();
    acase SPELL_WO: // "WOW"
        if
        (   spellroom is 11
         or spellroom is 3
        )
        {   room = 52;
        } elif
        (   spellroom is 34
         or spellroom is 212
        )
        {   room = 186;
        } elif (spellroom is 75)
        {   room = 118;
        } elif
        (   spellroom is 92
         or spellroom is 110
         or spellroom is 121
         or spellroom is 130
         or spellroom is 96
         or spellroom is 144
         or spellroom is 146
         or spellroom is 129
        )
        {   noeffect();
        } else noeffect();
    acase SPELL_VB:
        if
        (   spellroom is 11
         or spellroom is 3
        )
        {   room = 52;
        } elif
        (   spellroom is 34
         or spellroom is 212
        )
        {   noeffect();
        } elif (spellroom is 75)
        {   room = 140;
        } elif
        (   spellroom is 92
         or spellroom is 110
         or spellroom is 121
         or spellroom is 130
        )
        {   room = 103;
        } elif (spellroom is 96)
        {   room = 138;
        } elif (spellroom is 144)
        {   room = 116;
        } elif (spellroom is 146)
        {   room = 195;
        } elif (spellroom is 129)
        {   room = 223;
        } else noeffect();
    acase SPELL_CC: // "HH"
        if
        (   spellroom is 11
         or spellroom is 3
        )
        {   room = 52;
        } elif
        (   spellroom is 34
         or spellroom is 121
         or spellroom is 96
         or spellroom is 212
        )
        {   noeffect();
        } elif (spellroom is 75)
        {   room = 127;
        } elif
        (   spellroom is 92
         or spellroom is 110
         or spellroom is 130
         or spellroom is 144
        )
        {   room = 121;
        } elif (spellroom is 146)
        {   room = 232;
        } elif (spellroom is 129)
        {   room = 148;
        } else noeffect();
    acase SPELL_DE: // "GL"
    case SPELL_SF: // "LF"
        if
        (   spellroom is 11
         or spellroom is 3
        )
        {   room = 52;
        } elif
        (   spellroom is 34
         or spellroom is 75
         or spellroom is 130
         or spellroom is 212
        )
        {   noeffect();
        } elif
        (   spellroom is 92
         or spellroom is 110
         or spellroom is 121
         or spellroom is 144
        )
        {   room = 130;
        } elif (spellroom is 96)
        {   room = 53;
        } elif (spellroom is 146)
        {   room = 221;
        } elif (spellroom is 129)
        {   room = 174;
        } else noeffect();
    acase SPELL_MI:
        if
        (   spellroom is 11
         or spellroom is 3
        )
        {   room = 52;
        } elif
        (   spellroom is 34
         or spellroom is 75
         or spellroom is 92
         or spellroom is 110
         or spellroom is 121
         or spellroom is 130
         or spellroom is 144
         or spellroom is 212
         or spellroom is 146
         or spellroom is 129
        )
        {   noeffect();
        } elif (spellroom is 96)
        {   room = 61;
        } else noeffect();
    acase SPELL_EH: // "W"
        if
        (   spellroom is 11
         or spellroom is 3
        )
        {   room = 52;
        } elif
        (   spellroom is 34
         or spellroom is 212
        )
        {   noeffect();
        } elif (spellroom is 75)
        {   room = 140;
        } elif
        (   spellroom is 92
         or spellroom is 110
         or spellroom is 121
         or spellroom is 130
        )
        {   room = 103;
        } elif (spellroom is 96)
        {   room = 138;
        } elif (spellroom is 144)
        {   room = 116;
        } elif (spellroom is 146)
        {   room = 195;
        } elif (spellroom is 129)
        {   room = 223;
        } else noeffect();
    adefault:
        noeffect();
}   }
