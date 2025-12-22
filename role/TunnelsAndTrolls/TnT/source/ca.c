#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Errata:
 "Paragraph 61 tells you that Sharnalene has an arbalest which gets 8 dice, and leather armour which takes 12 hits, but doesn't tell you the rest of her stats. ST: 12 LK: 19 DX: 22 IQ:12 CN:25 CHR:12 SPD: 12 20 personal adds, 30 adds for missiles. Also has a Grand Shamsheer for 5 dice and a sax for 2d+5."
 This itself seems erroneous, as the adds given don't match the stats, and an arbalest isn't worth 8 dice.
 We have increased her ST to 15 and changed the arbalest to a cranequin to fix this.
Ambiguities (%%):
 CA217 gives him 20 personal adds, CA248 says only 10!
 CA198/201/257/304 pictures might belong to different paragraphs.
Notes:
 CA0 and CAp57 aren't currently used.
*/

MODULE const STRPTR ca_desc[CA_ROOMS] = {
{ // 0
"±`INSTRUCTIONS\n" \
"  Caravan to Tiern is a solo adventure for Tunnels and Trolls. Any single humanoid character may enter this adventure provided he has no more than 72 personal adds. This adventure has been written with the 5th edition of T&T rules in mind, and does include a magic matrix. The rules presented in that book will allow you to play the game with no difficulty.\n" \
"  In addition to the rules presented here you will need many six sided dice, paper and pencils to play. Create your hero and begin.\n"
"~INTRODUCTION\n" \
"  The town of Esturiat has been enjoying several months of peace after its recent war with the Rararadin, the dark warriors of the plain. You have been staying at the Amber Goose çT±avern for weeks. Although it holds pleasant diversions, you realize your supply of gold pieces is dwindling as no adventures have come your way.\n" \
"  Last night while drinking in the tavern, you overheard talk about great riches in tçhe city of Tiern far to the east±. The city is teeming with rich people who might be willing to hire one with your many talents to protect them from pirates, sea monstersç,± and villains. You are determined to set out for Tiern at once. Tiern liesç across the Great Plain of Bijouwar and through the steep mountain pass of Shamishant.±\n" \
"  It is a long journey with many dangers and you've been told that it proves fatal for those who try to make the trip alone. However, a caravan is slow and you are anxious to get there.\n" \
"  You have learned that a caravan will be setting out in a week for Tiern and as they are looking for help to protect it on the journey, you could join this group as a guard and go to {124}, or you could equip yourself for a long trek across the plains and set out alone at {98}.ç"
},
{ // 1
"You search his body and find 10 gold pieces, not much for a night's work, but worth 45 experience points. When you are relieved from your post, go back to your bedroll at {35}."
},
{ // 2
"As you are preparing to fight, two guards rush to the sheik's aid. They each carry a scimitar worth 4 dice and wear leather armour that will take 6 hits. Each guard has 10 personal adds and a Constitution of 10. The sheik will also join them in fighting you. He has a Constitution of 20 and fights with a falchion worth 4 dice plus 4. He has 15 personal adds, but wears no armour. If you kill the guards and wound the sheik by at least one hit, go to {156}. If you lose, your body is tossed out of the tent and you are dead."
},
{ // 3
"Roll one die. You have attracted the attention of the guards and this is the number that come to investigate. They see Narada's body and attack you. You may fight here. They are carrying scimitars worth 4 dice and wear leather armour that will take 6 hits. They all have a Constitution of 10 and 7 personal adds. You may surrender and go to {127}. If you choose to fight and your Constitution drops to 2, you are too weak to continue and must surrender by going to {127}. If you win, go to {188}. If you lose the fight, they kill you."
},
{ // 4
"You convince the sheik that you are already under a curse and can't handle two. He has enjoyed your conversation and his anger cools. He gives you a gift of an emerald worth 500 gold pieces and an invitation to visit him in Tiern. Go to {35}."
},
{ // 5
"Just before dawn, you leave the sheik's tent and add 1 point to your Strength for staying up all night without even yawning. Go to {197} to start the day's work."
},
{ // 6
"The sun shines bright, birds circle the sky above you, and life in general seems to be miserable as you trudge through the sand the next day. You are about to give up hope when you see a well in the distance and a herd of goats. With renewed energy, you scramble toward the well.\n" \
"  As you drop the bucket into the well you hear a thunk. \"There's no water,\" says a small voice behind you. \"It's dry again.\" You turn to see a small girl standing near the goats. \"I could let you have a little of my water, if you'd like,\" and she extends a small flask to you.\n" \
"  After taking a drink, you ask her for directions. She tells you it would be easier for you to catch a caravan than to return to Esturiat, as water is scarce in that direction. Her name is Jasima and she will have to take her herd into the hills for water. She asks if you would like to go with her. She'll pay you all she has - 10 gold pieces. It will only take a day and she'll show you the way back from there. If you aren't interested, go to the caravan route at {124}. If you'd like to help her, go to {191}."
},
{ // 7
"As you finish drinking, you feel strange. Your skin begins to crawl and in no time at all, you're a goat. Jasima will take care of you for the rest of your days."
},
{ // 8
"No one hears you as you arrive in the main hall of the castle. The walls seem to be made of solid sand as hard as rock. Messina takes your arm and whispers that she can sense her sister's presence in a room nearby. When you arrive at a large, green door, she nods that this is the one. If you let Messina open the door, go to {134}. If you open the door, go to {131}."
},
{ // 9
"The wizard laughs and helps you to your feet. Seeing that you are unhurt, he turns his attention to Capristo and Messina. The grey eyes of the wizard glow red and you find you can't move.\n" \
"  \"Welcome to my home,\" the wizard says as he smiles brightly. \"You three will make excellent food for my pet.\" There is a flash of light and you are alone in a pool of water about waist deep. Your weapons and armour are gone. The wizard sits in a balcony overhead with a beautiful woman. To your left you see Messina and her father tied to stakes, their feet in the water. You look again at the wizard's companion and see an exact duplicate of Messina. That must be Yolandra. Except that she has a large pair of butterfly wings strapped to her back. This wizard is strange!\n" \
"  Fereon informs you that if you survive, you may all go free. If you lose, all will lose. Then he says, \"Here, Petunia! Here, girl!\" and a huge pink sea creature rises from the water in front of you. A sword appears in your hand. It gets 6 dice in combat. All you can see of Petunia is teeth. Her MR is 60. Fight for your life. If you win, go to {193}. If you lose, go to {104}."
},
{ // 10
"Fereon deposits you in a caravan at {124}. He keeps both sisters but you get the frog and 100 gold pieces and your belongings."
},
{ // 11
"The gods smile on you and you are able to deflect the spell by grabbing a hand mirror on a nearby table. The spell is reflected back at Fereon and he becomes a tiny glass statue. The women hug and kiss you and the frog croaks happily from outside in the hall. They agree to show you the way to the caravan route at {124}, or they will show you the way to Esturiat if you would like to leave this adventure now. Your weapons and armour are returned and they give you a ring worth 250 gold pieces for a keepsake. If you are a magic user, you may help them cure their father before you go. This will give you an extra 200 experience points for reading old magic spell books. If you choose Esturiat, you are transported there by magic to retire with 250 experience points. If you choose adventure, go to {124} with 150 experience points."
},
{ // 12
"You set off into the night with a full moon to guide you. You walk north for a short time. Nearing a rise in a sand dune, you hear voices, laughter and music coming from the Rararadin camp. You can wait here to see what happens by going to {105} or creep closer for a better look at {166}."
},
{ // 13
"You were so fast you took the warrior by surprise. His name is Falkbar. His leather armour takes 6 hits and his Constitution is 20. You may attack and take your first attack directly off his Constitution, accounting for armour. If you kill him, go to {106}. If he still lives, fight him here. He carries a falchion that gets 4 dice plus 4 and his personal adds are 15. When you kill him, go to {106}. If he kills you, sorry, but you have nowhere to go."
},
{ // 14
"You move past the couple rapidly and near the camp. Make a first level saving roll on Luck (20 - LK). If you make it, go to {198}. If not, go to {138} and ignore the first sentence."
},
{ // 15
"You enjoy your life as a warrior with the Rararadin. The wild rides over the plains on your dark horse, the raids on the rich caravans, and the beautiful Rararadin women help you to pass your time. One of these women, Amara, Lord Shorman's daughter, especially appeals to you and you settle down into marriage until you hear the call for further adventures and go on to something new.\n" \
"  You may leave this adventure here with 350 experience points and Amara. Or, if you still dream of riches in Tiern, grab your weapons and a silver dagger worth 500 gold pieces and head off over the desert to join up with Ali Cambrasna's nest caravan heading east. Go to {141}, ignoring the first sentence."
},
{ // 16
"Cycera praises your skill in battle. Few women can fight as well as you. She invites you to the Rararadin camp and gives you her leather pouch containing jewels worth 1000 gold pieces. To go with her, go to {202}. To go back to the caravan, go to {75}."
},
{ // 17
"His attack takes you totally by surprise. He gets 2 dice plus 5 in combat for his sax, which he has hidden in his robes. His first attack comes right off your Constitution, allowing for any armour you are wearing. If you still live, fight him here. His Constitution is 15 and he has 10 personal adds. He also wears leather armour that will take 6 hits. If you kill him, move on to {166}. If you lose, he kicks your body and returns to his camp."
},
{ // 18
"You recognize the call of a sand demon and stop in your tracks. This demon has probably caused the gritty mess you're wandering around in. It's best if you don't move from this spot until it passes. You may cover yourself with your cloak against the wind and huddle on the ground to wait out the storm by going to {235}, or you may press on to {111}."
},
{ // 19
"You are now close enough to realize you are being honoured by the presence of a sand demon, MR 100. Sand demons eat souls and it wants yours. Please fight it here. [Each combat round make a first level saving roll on Luck (20 - LK) to see if it materialized long enough for you to strike it. If you don't make your saving roll, any hits you got against it didn't count. ]If you win, you get 300 experience points and should go to {80}. If you lose, the sand demon has your soul and goes merrily on its way."
},
{ // 20
"As the form begins to take shape, you scramble out of the water. As your feet touch the ground, you find you can't move. You are now looking at Vivina, goddess of the Great Plain of Bijouwar. She floats above you, her blonde hair blowing in the cool breeze she brought with her.\n" \
"  \"Mortal,\" she whispers, \"You have dared to enter my sacred pool. You must pay for this deed. The only way you can redeem yourself is to fight my champion, Kakanar. It's your choice.\"\n" \
"  If you agree to fight, go to {238}. If you would like to seduce her, go to {145}. If you want to run and think you can now, go to {143}."
},
{ // 21
"The gold chest contains a gold unicorn statue worth 250 gold pieces. Go to {237} with the goddess' blessing, which adds 1 point to your Charisma."
},
{ // 22
"You pick up the lamp and dust it off with your tunic. As you are rubbing it clean, it starts to vibrate and a cloud of smoke rises out of the spout. The smoke rapidly shapes itself into a tall, bald genie with gold earrings.\n" \
"  \"Greetings!\" he says. \"And thank you for coming to my rescue. I've been trapped in this lamp for 500 years by the evil wizard, Pushpah. I must reward you for your assistance. However, there's one small catch. Pushpah felt the lamp should be protected and I'm afraid you'll have to fight for your life. Here it comes now.\"\n" \
"  Pushpah has chosen a large, black Balrog, MR 100, to defend the lamp. Flames leap around him and his whip cracks once at your feet. Fight for your life. If you win, go to {146}. If you happen to die, the genie weeps as the Balrog stuffs him back into the lamp."
},
{ // 23
"After you defeat the Balrog, you search for the lamp, but it is gone. In your searching, you find the Balrog's camp. There is nothing of much value except a leather pouch. It contains 100 gold pieces which you can keep. You also notice a rabbit cooking on his fire. If you're hungry, you may eat it and go to {116}. If you'd just like to meet the caravan, go to {237}."
},
{ // 24
"The oasis swirls before your eyes and when you can see clearly, you are alone standing on a clear white surface. A voice whispers in your ear, \"Mortal, your attributes will be tested here. If you are successful, you will live. If not, your soul is mine.\"\n" \
"  There is a bright flash and you are dangling by one hand from the side of a rock cliff. Below you, way below you, is a small river. Make a first level saving roll on Strength (20 - ST). If you miss, you fall to {85}. If you make it, go to {147}."
},
{ // 25
"Vivina thinks you look like a pincushion. What a pity! You were almost done. Go to {85}."
},
{ // 26
"\"Well done, mortal,\" Vivina says. She returns your weapons and treasure, but keeps your armour. You may keep her blue armour as a gift. It only weighs 10#. Although she keeps the sword, she rewards you further with a blue sapphire worth 300 gold pieces and 150 experience points. You are forgiven and returned to the caravan at {237}."
},
{ // 27
"Make a first level saving roll on Strength (20 - ST) to pull him out. If you make it, you get him to dry land. Go to {149} if this is your 3rd rescue. If not, go to {57} and choose again. If you miss, you are pulled into the bog, so go to {85}."
},
{ // 28
"Vivina rewards you with her flute, which is worth 1000 gold pieces, and sends you back to the caravan at {237}."
},
{ // 29
"You are still struggling with your ropes when the roar of a dragon echoes through the mountains. The extra-large red dragon swoops from the sky, its claws aimed right at you. It is only playing and simply scrapes you with its sword-like nails. Take 1 die roll in hits directly off your Constitution. If you still live, you struggle out of your bonds and go to {91}."
},
{ // 30
"You read all night long. In the morning, Brashnavalva thanks you and gives you a small green bag, and sends you on your way. The bag contains 1000 gold pieces and 10 gems, each worth 15 gold pieces. Continue back to the caravan at {122}."
},
{ // 31
"It has been 7 days now since you've left Esturiat and you are out of water. There is nothing in sight but sand dunes and you are hopelessly lost. In desperation you walk toward the setting sun hoping to find your way back to town. Make a first level saving roll on Luck (20 - LK). If you make it, go to {62}. If not, go to {93}."
},
{ // 32
"As you wait in the shadows, a veiled woman appears before you in the moonlight. You approach her and she tells you her name is Narada. She is a slave of Sheik Poravan, who is a powerful ruler on his way to Tiern to set up a household by the sea. She is bored with harem life and believes you are the one who can help her. Somewhere in the sheik's tent he has hidden the great Eye of Zabulu, a fabulous gem. With this gem she could escape as it has the power to teleport its owner to any destination with the use of a secret magic word. As Narada knows this word, she only needs help to find the gem. She tells you she will teleport to Tiern, sell the gem, and place half the gold she gets from the sale in an account at the Tiern Trust and Savings in your name. The search must be done quickly as the sheik will be returning in an hour's time. If you refuse to help her, go to {218}. If you feel you deserve some adventure and a lot of gold after all your hard work, go to {63}."
},
{ // 33
"Although she wears an amulet that protects her from one magical spell, if you use any spell she will run. She hates magic. However, she throws her kukri at you as she leaves. Make a second level saving roll on Luck (25 - LK) to avoid being hit. If you miss, take the amount you missed your saving roll as hits off your Constitution. Armour will protect you from her throw. If you live, go to {95}. If you made the saving roll, go to {157}."
},
{ // 34
"As the sheik strides past, he notices you standing there. He pauses to invite you to dine with him in his tent in an hour. He must finish some business with the caravan master before he returns. You can refuse and make your excuses by going to {217}, or accept his offer and wait for him in his tent at {158}."
},
{ // 35
"You return to your bedroll and after a good sleep, you rise with the sun and help the merchants prepare to begin another day's journey. When you stop to rest for a moment, one of your fellow guards approaches you and says he has just heard that there's a legend concerning a mystical village that appears every 300 years for a few hours on Zaresday morn. Today is the day. Would you like to go with him to check it out? You have a while before the caravan leaves. If you decide to go check this legend out, go to {255}. If you'd rather forget it and get back to work, go to {197}."
},
{ // 36
"As you grip the box in your slightly shaking hands, you carefully touch the lid and are surprised to find it opens easily. Only aware of the box, you are startled by a flash of silver in the dark. Make a first level saving roll on Luck (20 - LK) to avoid the blade of a dagger. If you miss, take the amount by which you missed your saving roll off your Constitution. If you live or make the saving roll, go to {190}. If you are dead, that's the end."
},
{ // 37
"Smoothly you bring your weapon down on the snake, cutting it in two. It makes a nice meal that evening when you make camp. It also gets you 50 experience points. You may now proceed to the caravan route at {124} or if you are tired of all this adventure business, you can follow the setting sun to Esturiat and leave this tale with 100 experience points."
},
{ // 38
"The warriors take your weapons and armour and carry your bodies into the castle. You can't move, but you can see the high turrets overhead and hear the clink of armour on stone as you enter the courtyard. You hear a deep laugh and someone pinches you. You are carried inside the fortress and catch glimpses of colourful tapestries and suits of armour as you pass along the halls. Rough hands lift you and you find yourself propped up against the wall in a huge crystal room. A handsome man in a long grey robe is looking at you. The wizard Fereon comes closer to inspect you. His hands wander over you as he pokes and pinches. Finally he turns away and speaks in low tones to an attractive young woman. She bows and leaves.\n" \
"  He turns to face you again and says \"Welcome to my home, Capristo. I see you've brought me another of your fine daughters, as well as a morsel for my pet's dinner. You're much too generous.\"\n" \
"  Capristo grumbles and would say more, but the wizard immediately turns him into a frog with a slight wink of one very grey eye.\n" \
"  \"Now,\" Fereon says, \"I've got other plans for the two of you.\"\n" \
"  Messina and you are carried off by armed warriors as the frog hops sadly around the room. You are locked in a small room high in one of the turrets you admired earlier. Messina suggests you escape, but you think it safer to wait to see what Fereon does next. If you take Messina's advice to escape, go to {161}. If you want to wait, go to {71}."
},
{ // 39
"You find a small golden chest and open it. Inside you see a diamond necklace worth 1500 gold pieces. Take it or leave it and go to {192}."
},
{ // 40
"Fereon finds you annoying, a lot like a fly at a picnic, so he turns you into a small bug and stomps you. Better find a new character."
},
{ // 41
"As the wizard dies screaming a curse at you, you all run from the castle. The walls are quivering and just as you reach the open desert, you look back to see a huge pile of sand where the castle once stood. A few feet from this pile, you see Capristo, who has returned to human form at the wizard's death, carrying your weapons and armour.\n" \
"  With much gratitude and 150 experience points, you are shown the way to a caravan at {124} or back to Esturiat for a long rest and the end of this adventure. You notice as you leave that Fereon's curse has reduced your Charisma by 5 points."
},
{ // 42
"The wizard has no real liking for you. He reaches into his grey robes and pulls out a small crystal ball. As you gaze into it, you find that you can't look away. You feel yourself slipping away and soon your mind is owned by Fereon and he uses you as his new butler. What becomes of the women no longer interests you."
},
{ // 43
"As the sentry approaches, silently you jump from your hiding place, weapon in hand. Make a first level saving roll on Dexterity. If you make it, go to {136}. If you miss, go to {108}."
},
{ // 44
"On her body you find a gold ring worth 50 gold pieces, a leather pouch containing jewels worth 1000 gold pieces and a ruby ring worth 200 gold pieces. You may also take her weapon. As you move on, make a first level saving roll on Luck (20 - LK). If you make it, go to {198}. If you miss, go to {139}."
},
{ // 45
"Both Rararadin carry great shamsheers [of silver ]that get 5 dice in combat. They each have 10 personal adds and Constitutions of 15. Fight until you die or kill one of them, then go to {199}. They are not wearing armour, so good luck!"
},
{ // 46
"That was silly. Rararadin have no scruples. Having killed one of their warriors, one of the nastiest fellows raises his bow and neatly end your resistance forever."
},
{ // 47
"Lord Shorman and you are soon married and causing panic in all the merchants who travel the plains. Life is good here in Bijouwar and you stay until you hear the call of other adventures.\n" \
"  You may leave this adventure with 350 experience points. One last chance gives you a quiet night to slip away unnoticed and continue your trip to Tiern at {141}, ignoring the first sentence. If your heart is stone cold, steal a few jewels from your husband to take along with you, worth 250 gold pieces."
},
{ // 48
"Falkbar sees you coming and is ready for you. He attacks as you close in. He is fighting with a falchion that gets 4 dice plus 4 in combat. His Constitution is 20 and he is wearing leather armour that will take 6 hits. His personal adds are 15. [If you survive 2 combat rounds, the woman will come to your aid. She fights with a grand shamsheer that is worth 6 dice plus 2 in the fight. She is protected by leather armour that will take 6 hits. Her personal adds are 30 and her Constitution is 20. ]If you win, go to {140}. If not, Falkbar is delighted to have met you."
},
{ // 49
"You finally make it to the oasis. You are now in one of the most beautiful places in this land. Tall palms stretch high above luscious green grass. In the centre of all this green, you find a bright blue pond looking cool and refreshing. Its surface is as smooth as glass. You may drink your fill by going to {205}, remove your clothing and go for a swim at {112}, or stretch out on the grass to take a nap by going to {206}."
},
{ // 50
"The growl is coming closer to you. You can hear it above the wind. It must be huge. You may stay still and hope it goes away by going to {235}, or run now to {236}."
},
{ // 51
"As you finish drinking, you glance up to see a small, blue stone altar hidden in the rocks by the water. You realize this must be a sacred place. To appease any gods or goddesses who might be around, you may put a flower on the altar at {144}, or you may ignore it and go to {240}."
},
{ // 52
"Make a second level saving roll on Charisma (25 - CHR) and a first level saving roll on Luck (20 - LK). If you make both of them, she decides you have a brain and possibly a few other good points, so she takes you below the water to see her palace. Go to {114}. If you miss one or both saving rolls, go to {208}."
},
{ // 53
"After experimenting with the cloak, you find that when you put the hood over your head, you are invisible. You also find a small pocket inside the cloak that contains an engraved thank-you note and a small mithril statue of a fat genie worth 2000 gold pieces. Now go meet the caravan at {237}."
},
{ // 54
"As you watch, the forms begin to take the shape of a beautiful woman. She floats over the water until she is right above you. Slowly she raises her right arm until her hand points directly at you. Her words seem to whisper on the wind but their meaning is deadly.\n" \
"  She informs you that she is Vivina, goddess of the Great Plain of Bijouwar, and that you have violated her sacred pool. The punishment is death. Make a quick second level saving roll on Charisma (25 - CHR) to save the day. If you make it, go to {150}. If you miss, go to {209}."
},
{ // 55
"As you open the chest, make a first level saving roll on Luck (20 - LK). If you make it, go to {178}. If you miss, go to {210}."
},
{ // 56
"You find yourself standing in the middle of a large blue arena. The sky above you is blue and even the sand you are standing on is blue. The bluest thing you see is the dragon standing in front of you licking his lips.\n" \
"  Vivina's voice whispers that you must defeat Bluking to live. Magic will not work here, as she enjoys a good clean fight. Weapons will be provided. There is a flash of light and you find all your weapons are gone. You also find yourself wearing magical blue leather armour that will take 8 hits. On the other side of the arena you see a silver sword in a stone with a large blue sapphire on the hilt.\n" \
"  Make a first level saving roll on Dexterity (20 - DEX) and a first level saving roll on Luck (20 - LK) to avoid the dragon's flames as you run to the sword. If you miss, go to {117}. If you make both of them, go to {180}."
},
{ // 57
"The world swims before your eyes and when it comes back into focus you are in a strange land of tall pine trees and rocky mountains. \"You must help three people in trouble,\" whispers Vivina. \"You may choose whom you help first, but you must help all three.\"\n" \
"  You see a small child running before you followed by 2 huge white wolves. In the next moment, a young woman screams. You see her surrounded by 3 large men carrying huge axes. And if that's not enough, you hear a man calling for help as he slips into a greenish bog.\n" \
"  To save the child, go to {118}.\n" \
"  To save the woman, go to {243}.\n" \
"  To save the man, go to {212}."
},
{ // 58
"Your storytelling was very good and Vivina sends you on your way back to the caravan after increasing your Charisma by 2. Go to {237}."
},
{ // 59
"As you move forward, you trip over a twig and lose your balance. You have also triggered a trap. A net drops down over you. Although you struggle, you are unable to free yourself. A sharp blow to your head ends your efforts. When you awaken, you are in an iron cage, stripped of your weapons and armour, in a small village of straw huts and muddy paths for streets. This is a bandit village. A young male bandit comes to the cage and stands with his hands on his hips and laughs at you. You may politely ask why you've been treated like this and go to {151}. You may tell him what you think of him and the way you've been treated by going to {244}. If you want to trick him to gain your freedom, go to {90}."
},
{ // 60
"Bad move. You should have gone for the trees. The dragon's fiery breath hits you. You take 2 dice in hits directly off your Constitution. If you still live, go to the woods at {91}. If not, the dragon has his barbecue."
},
{ // 61
"As you stand perfectly still, listening, a shadow comes up behind you. You try to turn, but a rock is tapped on your head and you drop with a thud. Your attacker drags you into the bushes and ties you up. When you open your eyes, you see a tall female warrior standing over you. She is 6' 2\" tall and wears leather armour that will take 12 hits. Her long red hair blows in the breeze and her eyes are as blue as the water at the oasis. She carries a cranequin worth 8 dice in combat. ST: 15, IQ: 12, LK: 19, CON:25, DEX: 22, CHR:12, SPD: 12, 20 personal adds, 30 adds for missiles. Also has a Grand Shamsheer for 5 dice and a sax for 2d+5. She gives you a kick with her foot and grins. Her name is Sharnalene. She is a well-known bandit in these mountains. She asks you to join her in an adventure. To say yes, go to {184}. To decline, go to {247}."
},
{ // 62
"You chance upon a small stagnant water hole and are able to drink enough to keep you alive until you stagger back to Esturiat, where you are wise enough to join the caravan to Tiern. Proceed to {124}."
},
{ // 63
"Narada leads you into the tent. The interior is draped in coloured silk and soft cushions, beautifully woven rugs, and old travelling chests are scattered over the entire tent. It's a silken jungle. Narada sweeps her veil aside and tells you to start looking. You are trying to find a small silver box. Soon you are tossing pillows aside, glancing under woven tapestries and pawing through silk and satin garments in trunks. Make a second level saving roll on Luck (25 - LK). If you make it, go to {94}. If you miss, read on. Your search is fruitless and you are hot and tired. Narada thanks you for your help, but urges you to leave now before the sheik's return. If you have more time to look, go to {125}. If you leave now, go to {35}."
},
{ // 64
"You have attracted the attention of two guards and they attack you immediately. You must fight them here. They wear leather armour that will take 6 hits and carry scimitars worth 4 dice. They each have a Constitution of 10 and 10 personal adds. If you lose, they run you through with their scimitars. If you use magic, write down your spell and go to {249}. If you fight with weapons, fight here. If you win, go to {188}."
},
{ // 65
"Make a first level saving roll on Luck (20 - LK) to cut through the tent and escape to {35} without harm. If you miss, the sheik catches up to you and you must go to {2} to fight for your life."
},
{ // 66
"The sheik does not accept your excuses. He always gets his way. You may change your mind and go to {189} to open the box, or insist on leaving at {220}."
},
{ // 67
"You are able to convince Tallarura that you do not want to be a wife or take the fabulous gem you see resting in blue velvet. She quickly apologizes and offers you her dagger which gets 2 dice plus 5 in combat. The sheik gives you 500 gold pieces as a reward for your bravery. Unaffected by any curse and breathing a sigh of relief, you go on your way to {35}."
},
{ // 68
"You have won. The sheik rewards you with a small locket which contains one gold piece. This is magical[ and once that gold piece is removed another will take its place up to 10 a day]. He then thanks you for opening the box and also hands you a leather pouch containing 500 gold pieces. With a smile, he invites you to have a drink with him before you leave at {5}, or you can go now and stroll off to {35}."
},
{ // 69
"You say you really just want to get out of the desert. The old man's sharp knife suddenly appears at your throat where he convinces you to help them. Go to {223} if you really are convinced, or go to {130} to escape from these people."
},
{ // 70
"Ignoring the curses of Capristo and Messina, you take your weapons and armour, as well as your new magical sword and trudge through the desert to {31}. The magical sword will float on water and hums bawdy tavern songs."
},
{ // 71
"You pass the night in your prison huddled close to Messina. A cold wind blows through the tower and you pray for the hot desert sun to appear quickly. In the morning, three guards come and take you to the castle's crystal room. Fereon is eating breakfast and barely glances up as you enter. If you would like to try to influence him, make a second level saving throw on Charisma (25 - CHR). If you miss, go to {133}. If you make it, go to {226}. If you'd rather wait quietly, go to {195}."
},
{ // 72
"Fereon releases Capristo and his daughters, all in human form, and you live in his castle. If you are a magic user, you learn 4 spells from him at your level or lower. Everyone gets 150 experience points for living in this magical world. When you are tired of this life, sneak out of the castle at night and go to the caravan at {124}. Don't forget to take your wedding present - a jade box worth 300 gold pieces. However, if you are happy here, you may retire from this adventure."
},
{ // 73
"The arrow strikes your neck. It is poisoned. If you are immune to poison, pull the arrow out and go to {225}, ignoring the first sentence. If you're not immune to poison, make a second level saving roll on Constitution (25 - CON). If you make it, Messina is able to heal you with a spell before you die. Go to {225}, ignoring the first sentence. If you miss, you die instantly."
},
{ // 74
"Morning dawns to find the caravan surrounded by Rararadin. With wild cries, they descend on the helpless group by the hundreds. In minutes the caravan is captured and is at their mercy. Make a second level saving roll on Dexterity (25 - DEX) to see if you lived through the fight. If you miss, they didn't miss you. If you make it, you are captured and sold as a slave in the north. However, one sentimental god gives you a chance at freedom, but you lose all weapons, armour, and treasure. Roll 1 die. If you roll an even number, your northern master allows you a chance to gain freedom if you have Arena of Khazan. [You must fight 8 times and give all money and prizes to your master before you will be freed. ]If you roll an odd number, go to {106} in City of Terrors. If you don't have either of these adventures, you must remain a slave in the north, due to lacking a sense of adventure."
},
{ // 75
"On the walk back to the caravan you notice a shiny object in the sand. Make a first level saving roll on Luck (20 - LK). If you miss, go to {137}. If you make it, go to {230}."
},
{ // 76
"You are disarmed and led into the Rararadin camp by Omar. As you approach, the laughter and music die. You look around to see men and women dressed in black. They appear to be a very strong and proud people. You know they're strong by the grip on your arms as you are led into the centre of a huge circle around the fire. A voice booms from the dark, \"A city dweller. Looks rather scrawny to me.\"\n" \
"  \"Oh no, my Lord,\" says Omar as he bows. \"This dweller of towns is a true warrior.\" Lord Shorman comes into the fire's light. He smiles at you and asks. \"So you are a warrior?\" He then offers you a chance to live. You simply fight his champion or die. Go to {168} to fight Kakadoor, champion of Bijouwar."
},
{ // 77
"You are dead. They feed what's left of you to the carrion birds in the morning. \"So I was wrong,\" Omar is heard mumbling as they attack the caravan."
},
{ // 78
"A Rararadin would rather die than ever speak to an enemy. Kill him and go to {166} or drag him along with you to {171}."
},
{ // 79
"As you enter the camp, Cycera tells her followers of your brave deed. Her brother, Lord Shorman, invites you to join them as you must be a great warrior. He offers you his best horse, Makran, and his sister in marriage, as well as 1000 gold pieces to join them. If you agree, go to {170}. If you'd rather not, go to {201}."
},
{ // 80
"With the end of the sand demon, the sandstorm vanishes, leaving you alone under a clear afternoon sky. At your feet you see a small silver chest. You may try to open it and go to {173}, or leave it and press on toward the palm trees you see in the distance at {49}."
},
{ // 81
"Your drinking from the water has disturbed the guardian of the oasis. Vivina is the goddess of the Great Plain of Bijouwar and she doesn't take kindly to intruders who do not honour her. She rises slowly from the water and hovers a few feet above you. She raises her right arm and points an elegant finger at you. You glance around quickly (yes, it's really you she's pointing at).\n" \
"  \"Mortal,\" she says softly, her voice as cool as the water she rose from. \"You have defiled this place.\" You have one minute to explain yourself. Be as charming as you can and make a second level saving roll on Charisma (25 - CHR). Go to {143} if you make it. Go to {175} if you miss."
},
{ // 82
"The silver chest contains a silver statue of the goddess. It is worth 500 gold pieces and will take 1 hit in combat for you if you carry it with you. It weighs 5#. Go to {237} with the goddess' blessing, which adds 1 point to your Charisma."
},
{ // 83
"[The medallion will increase your Constitution by 2 and your IQ by 1 permanently just by carrying it. Vivina asks that you bury it on the beach at Tiern. If you keep it, you will be turned to stone after a night in Tiern. ]Go to {237} with the medallion to meet the caravan."
},
{ // 84
"You are in the power of a goddess. You still can't move and she senses your reluctance to repent. Make a second level saving roll on Luck (25 - LK). If you make it, she decides to let you fight Kakanar. Go to {238}. If you miss, she shrugs her shoulders and turns you into a butterfly. She likes pretty colours and you brighten up the oasis nicely."
},
{ // 85
"You are dead and Vivina has been appeased."
},
{ // 86
"Having survived the arrows, you now face Vivina herself. Make a first level saving roll on Charisma (20 - CHR). If you make it, go to {211}. If you miss, go to {148}."
},
{ // 87
"Vivina is appalled that Bluking roasted you so easily. \"What a wimp,\" she mumbles as she leaves."
},
{ // 88
"Vivina rewards you with a 40' blue rope so light that it only weighs 2#, but so strong that it will never break. Go back to {57} if you haven't rescued all 3 and choose another. If this is your third rescue, go to {149}."
},
{ // 89
"Vivina has a sense of humour. Nothing satisfies her like a good laugh. With a snap of her fingers, [all your clothes are gone and ]you are standing in front of Ali Cambrasna and the entire caravan with your belongings at your feet. Go to {237}."
},
{ // 90
"You quickly discover that his name is Trangen. He has red hair and grey eyes. He really is quite attractive and seems interested in you. Make a first level saving roll on Charisma (20 - CHR). If you make it, go to {214}. If you miss, he merely wants to talk to you; go to {151}."
},
{ // 91
"\"Over here,\" Trangen calls as you limp away from the altar. He carries your weapons and is armed himself with a great sword worth 6 dice. He wears leather armour that will take 6 hits. His personal adds are 25 and his Constitution is 20. He gives you your weapons and belongings and says that he couldn't stand to see you killed like that. While he is talking, make a first level saving roll on Dexterity (20 - DEX) to see if you have time to put on your armour before the dragon attacks. [Trangen will now help you ]fight this dragon, which is rapidly advancing toward you. His MR is 140. If you win, go to {153}. If not, the dragon gets lunch."
},
{ // 92
"You didn't have much room to move. The troll batted you off the ledge with his club and you fell on the rocks below. Your adventuring days are over."
},
{ // 93
"You were told it would be fatal to cross the great plain alone. You cannot find your way out and die alone under the hot sun."
},
{ // 94
"Under a pile of silk shirts your hands close on something hard. You pull a small silver box out of the trunk you were searching. Narada is thrilled. You hand her the box and she gives you a gift for good luck. It's an amulet[ that will protect you from one magical spell cast at you at any level, but then it is worthless]. She invites you to stay and have something cool to drink, go to {125}. Or, you may leave now, dreaming of the gold that will wait for you in Tiern (1000 gps can be added to your treasure when you reach Tiern) and go to {35}."
},
{ // 95
"Remember the old saying about a woman scorned? Perhaps the next time you won't refuse when a lady asks a favour. Go to {157} as you try to slip away into the dark."
},
{ // 96
"Narada's personal adds are 24 and her Constitution is 20. You will have to fight her here. If you lose, you are, of course, dead. She kicks your body and leaves. If you win, go to {250}."
},
{ // 97
"The sheik and his guards have succeeded in getting the best of you. You are taken to his private quarters and forced to wear a very revealing harem girl costume. You are then put in chains and informed that the sheik intends to sell you in Tiern to the highest bidder unless you have 1000 gold pieces to buy your freedom. If you have the money, give it to him and he will release you to {35}. If you don't have it, make a second level saving roll on Charisma (25 - CHR). If you miss, you must spend your life as a slave in Tiern. This was your last adventure, unless you have Arena of Khazan, in which case, the gods smile on you by giving you the opportunity to gain your freedom. You lose all your weapons, armour and treasure, but you can fight 6 times for the sheik, giving all money and prizes won to him and then go on your way to other adventures. If you make the saving roll, go to {159}."
},
{ // 98
"You are beginning to feel that it was a mistake to try such a trek on your own. You're hot, tired, thirsty, and hoping for a cool breeze. However, all you see in any direction is sand and more sand. You decide to return to Esturiat or join up with a caravan, if you can find your way through this. Toward evening, you see a dark silhouette some distance from your position. You head toward it even though you think it might be no more than a mirage. You don't seem to be getting any closer to your mirage, so with the setting of the sun you consider preparing your camp for the night. Then as you glance toward the horizon, you notice the flickering of lights across the sand. So your mirage was real after all and might contain someone who could show you the way to Esturiat or the caravan route. To move out in the direction of the lights, go to {160}. To ignore them and head on your own in the morning, go to {6}."
},
{ // 99
"After a pleasant evening meal of goat's cheese, bread, and a few swallows of water, you turn in for a good night's rest. In the morning, Jasima points out the direction of the caravan route. She hands you your 10 gold pieces and a necklace she was wearing. She explains that the stone is common in her land and is to be worn for good luck. You head off across the desert again. After several hours of walking, you stop for a rest and examine the stone necklace. To your amazement you see you hold a topaz worth 350 gold pieces. Later as you walk along studying the gem, you catch your boot on a rock and fall. Cursing, you start to rise only to stop still. In front of your eyes is a giant snake. It is coiled, ready to strike and you're the closest target. Make a second level saving roll on Luck (25 - LK) to bring your weapon out to strike it before it gets you. If you miss, go to {222}. If you make it, go to {37}."
},
{ // 100
"Having defeated the warriors, your party waits until twilight to sneak into the castle. A large wooden door bars your way. It appears to have pastoral scenes carved on it. A closer look shows you that they are actually scenes depicting a wizard destroying his enemies. You see a wizard and a man with a sword, 6 frogs, 1 snake, and a slightly dead warrior. You may try to open the door by going to {162}, or turn to flee at {135}."
},
{ // 101
"You all run through the castle and escape into the hot sun. Looking around, you see the castle turn into a huge pile of sand. You have earned 250 experience points and your friends show you the caravan route or the way to Esturiat. If you want to join a caravan, go to {124}. If you prefer to return to Esturiat and end your adventure, you may do so by riding in Capristo's wagon back to town. The magic sword floats on water and hums bawdy tavern songs. It's yours."
},
{ // 102
"Fereon will give you a chance to live. Capristo is returned to human form for the occasion and you all go to {9}, ignoring the first three sentences."
},
{ // 103
"Your escape has been detected by the wizard. His laughter echoes in your ears as the world around you begins to spin. When you can see clearly again, Fereon is standing in front of you in a small library. Make a second level saving roll on Charisma (25 - CHR). If you make it, go to {165}. If you miss, go to {254}."
},
{ // 104
"Petunia finds you a delightful meal and happily devours Messina and Capristo for dessert. Fereon has enjoyed the sport immensely and keeps Yolandra forever."
},
{ // 105
"The Rararadin are a cautious lot. They have sentries all over. The moon catches the figure of a tall sentry walking near your hiding place. You may decide to attack this sentry at {43} or remain hidden and hope he'll pass at {138}."
},
{ // 106
"The woman has staggered to her feet. She has watched the fight and as you turn toward her, her hand reaches for her weapon. You may fight her at {167}, or make a friendly gesture at {169}."
},
{ // 107
"\"Good,\" says Lord Shorman. \"As further reward, I now make you my new champion.\" Go to {200} if you are female, or {15} if you are male."
},
{ // 108
"You weren't quite fast enough and he saw you in time to avoid your attack. You must fight him here. He has a Constitution of 10 and carries a great shamsheer worth 5 dice. He wears no armour and his personal adds are 10. If you beat him, go to {232}. If you lose, you're dead."
},
{ // 109
"Following your guide's instructions, you move closer to the camp. A sand dune separates you from your goal when you turn to find your prisoner is gone and you stand alone in the dark. Go to {138} and ignore the first sentence."
},
{ // 110
"He draws a sax worth 2 dice plus 5 in combat from the folds of his robe. You catch a glimpse of his blade and turn to fight. His Constitution is 15 and he has 10 personal adds. Also note that his armour will take 6 hits. If you kill him, go to {166}. If he kills you, go to {172}."
},
{ // 111
"The growl is repeated, only this time it seems to be more like a roar. If you can hear it above the wind and sand, you must be very close. Now you feel that you're not alone. Suddenly you see two glowing, red eyes above you in the swirling sand. To press on, go to {19}. To try to run, go to {236}."
},
{ // 112
"Taking off your armour, weapons, and tunic, you ease your tired body into the cool water. It feels good to get rid of all that grime you've gathered up working with camels. You splash about for a while, when you notice that the water is changing. It begins to bubble over. Then a form rises from the centre of the turmoil to hover a few feet above you. Make a first level saving roll on Luck (20 - LK). If you make it, go to {20}. If you miss, go to {54}."
},
{ // 113
"\"Bravo, mortal,\" Vivina whispers with delight. \"You are a brave hero. You may now leave here in peace. Your foolishness is forgotten.\" A cool breeze blows, the water bubbles, and Vivina disappears back into the water. As you leave the oasis, you notice a small pouch. Picking it up, you open it and find a gift from the goddess, 10 small sapphires worth 100 gold pieces each. You've also picked up 250 experience points. Move out to meet the caravan at {237}."
},
{ // 114
"You have a marvellous time in her blue crystal palace. She shows you many fascinating things and you are awed when she discusses the problems of a goddess stuck out in the plains and that she listens to your tales of adventure with interest. Make a first level saving roll on Charisma (20 - CHR). If you make it, she is impressed and rewards you with a huge blue sapphire worth 1000 gold pieces and raises both your Charisma and Luck by 2. If you miss, she found you rather boring after all, but increases your Charisma by 3 to make you more interesting to the next goddess you meet. Everyone go to {176}."
},
{ // 115
"You kick the battered old lamp aside. It bounces over the ground and you think you heard an \"ouch\" as it hit a sharp rock. You don't have much time to think about this, as you hear a roar coming close behind you. You turn to see a huge black Balrog enveloped in flame. He cracks his whip in the air and comes closer.\n" \
"  \"Puny creature,\" he says. \"You have dared to touch my lamp. Now you must die.\" If you'd rather not, fight him. He has an MR of 100. If you lose, the Balrog was right, but if you win, go to {23}."
},
{ // 116
"The rabbit was delicious. It wasn't an ordinary rabbit, however, and eating it increased your Strength by 3. Stop delaying and get back to the camels at {237}."
},
{ // 117
"Take the amount you missed your saving rolls by from your Constitution. The armour will not protect you in this case. If you still live, go to {180}. If not, go to {87}."
},
{ // 118
"You run after the child and the 2 white wolves turn to face you with a snarl. One leaps at you. Make a first level saving roll on Dexterity to dodge (20 - DEX). If you miss, take the amount you missed by off your Constitution. If you still live or made the saving roll, read on. You must now fight for your life and the child's. The wolves have an MR of 50 each. If you win, go to {88}. If you lose, you are torn to shreds."
},
{ // 119
"While you're fighting, the woman was able to sneak behind one of the men and bashed him on the head with a rock. Now you fight one less, or none at all depending on your combat skill in the first round. When you win, go to {181}."
},
{ // 120
"Make a second level saving roll on Strength (25 - ST) to pull him out with your bare hands. If you make it, you get him to dry land. Go to {149} if this is your third rescue. If not, go to {57} and choose again. If you miss, you are pulled into the bog, so go to {85}."
},
{ // 121
"Trangen patiently waits for you to show him the coin while you plead for his help. He begins to get upset when you don't produce the treasure. You are unaware of his changing attitude as you plead on, so it is easy for him to take you by surprise and pin you against a tree. Twisting your arm behind your back, he forces you to confess that you lied. You are helpless as the angry man binds your arms and drags you back to the village, his poniard against your ribs. In the village Trangen turns you over to a procession of villagers who take you up a hill to a stone altar. He explains you are to ease the hunger of the local dragon as their yearly sacrifice, and lashed to an altar. As the people leave, you notice your bonds are loose. Make a first level saving roll on Luck (20 - LK). If you make it, go to {245}. If not, go to {29}."
},
{ // 122
"Back at the caravan, Ali Cambrasna is upset. You were gone so long that he sent out other scouts. He orders you to get back to work. Go to {253}."
},
{ // 123
"Avoiding the edge of the cliff, you [and Sharnalene ]must battle the troll. If you defeat it, you hear a roar. Make a second level saving roll on Luck (25 - LK). If you miss, go to {251}. If you make it, go to {215}."
},
{ // 124
"The caravan to Tiern moves slowly across the Great Plain of Bijouwar. The days are hot and the nights are cold. For a week now you have been helping to move the torturously slow caravan on its way, dodging the bites of stubborn camels and standing watch at night. It has been a quiet trip so far and you have had time to notice that a very rich sheik is travelling with you. His huge silk tent, which is set up each night, intrigues you and one evening as you are relieved from guard duty, you decide to investigate. Go to {155}."
},
{ // 125
"You take a moment to relax, settling down into a pile of soft pillows as your mind wanders to thoughts of how you'll spend your gold. You fail to notice that the sheik has returned. Make a first level saving roll on Luck (20 - LK). If you make it, you hear him yell, \"Die, thief!\" and are lucky enough to avoid his weapon. You manage to grab your own and proceed to {187}. If you miss, he has slit your throat and you are done."
},
{ // 126
"The guards can't see you and you are able to disappear into the night. Go to {35}."
},
{ // 127
"You are taken to the sheik who is angered that you have killed his best bodyguard. 1000 gold pieces will buy your freedom. If you have it, pay the sheik and go to {35}. Otherwise, you are now the sheik's slave and will have to serve him for the rest of your life as a eunuch in the harem guards.\n" \
"  However, all is not lost, as the gods give you an opportunity to gain your freedom although you lose all weapons, armour and treasure. If you have Arena of Khazan, you can fight [6 times for the sheik, giving all money and prizes won to him, ]and then go on your way to other adventures."
},
{ // 128
"The sheik wants to give you a gift for your bravery. He offers you a sapphire ring worth 500 gold pieces and a silver dagger with a blue sapphire blade worth 1000 gold pieces and with a fighting strength of 2 dice plus 10. He then hands you the box and sits back to watch. If you want to open it, go to {36}. If you'd like to throw the box at the sheik and run out of the tent, go to {35}."
},
{ // 129
"Tallarura is convinced that you wish to steal her anniversary present and possibly her husband, too, and insists on fighting you. The sheik is delighted that two women wish to fight over him. He disarms his wife and insists that you fight without weapons to settle the matter. Tallarura jumps at you immediately. You both get 2 dice plus your personal adds. Tallarura has 10 adds and a Constitution of 25. The first person to have her Constitution reduced to 2 loses consciousness and the contest. [As this is only the result of bruises, after a night's rest all Constitution will go back to what it was before the fight. ]If Tallarura wins, go to {221}. If you win, go to {68} with a smile."
},
{ // 130
"Convinced that you will help them, the couple prepares to break camp. Make a second level saving roll on Luck (25 - LK). If you make it, go to {6}, as you are able to grab your equipment and sneak away without being seen. If you miss, go to {224}."
},
{ // 131
"As the door opens, make a second level saving roll on Dexterity (25 - DEX) to avoid a small silver arrow which whisks toward you from a statue across the room. If you miss, go to {73}. If you make it, go to {225}."
},
{ // 132
"You turn your sword on Fereon in a rapid movement. Make a second level saving roll on Luck (25 - LK). If you make it, go to {194}. If you miss, go to {40}."
},
{ // 133
"The wizard doesn't like you at all. He snaps his fingers and you are turned into a peculiar looking porcelain vase. He keeps Messina and has her pick fresh flowers every week to keep you busy in your new career."
},
{ // 134
"Messina slowly opens the door. As you both peer in, you see Yolandra in the arms of the wizard Fereon. Outraged, the wizard turns and directs a spell at you. Make a first level saving roll on Luck (25 - LK). If you make it, go to {11}. If you miss, go to {196}."
},
{ // 135
"As you turn to run, Messina sticks out her foot and trips you. \"You're going the wrong way,\" she snaps as one delicate hand pulls the latch on the door. It slides open to reveal a long hallway decorated with life-size statues of men and women. The same delicate hand drags you to your feet and shoves you through the door. As the three of you cautiously walk down the hall, you notice that one of the statues is moving. A tall, handsome man in grey robes walks in front of you and fastens his grey eyes on you.\n" \
"  \"Welcome to my home, fools,\" Fereon growls. \"You were stupid to come into my fortress. Yolandra is mine now and all that awaits you is death.\"\n" \
"  Messina's father, Capristo, lunges for the wizard's throat, but is instantly reduced to a small green frog. You try to help, but find you can't move a muscle. The wizard pokes and pinches you, mumbling something about pets and dinner and did you eat a large supper before your visit.\n" \
"  With a nod of his head, several statues come to life, remove your weapons and armour and carry you with no apparent respect up to one of the turrets, throwing you in a heap in a small room. Messina is soon tossed on top of you. Before the door closes, Fereon sticks his head in and tells you he'll be seeing you for breakfast. When the door finally does close, you find you can move. Messina suggests you escape at once. If you agree, go to {161}. If you'd rather wait and see what happens next, go to {71}."
},
{ // 136
"You take the sentry by surprise. After a brief struggle, you subdue him. You may kill him: go to {166}. You may question him at {78}, or take him prisoner and go to {171}."
},
{ // 137
"You reach for the object, but realize too late that it is a silver hrombri desert beetle, very poisonous. Make a second level saving roll on Constitution (25 - CON). If you miss, subtract the amount missed from your Constitution. If you still live or if you made your saving roll, go to {141}."
},
{ // 138
"Staying very still in the dark, the sentry passes by. Your troubles are just beginning when you feel a strong hand on your shoulder. You spin around to see 2 Rararadin, swords drawn. \"Fight or die, city dweller,\" growls the largest one as he advances. You can fight at {45} or die here."
},
{ // 139
"Your luck has run out. A Rararadin sentry saw you attack Cycera and she raises her bow and puts an arrow neatly through your retreating back. You are done now."
},
{ // 140
"The woman's name is Cycera. She is grateful for your help, but after all, she is a Rararadin and can take care of herself. She warns you to leave at once as the camp is getting ready to move further north in the morning. They fear bad weather. You get 45 experience points from this and leave at once by going to {75}."
},
{ // 141
"When you arrive back at the caravan, Ali Cambrasna is pleased with the information you gave him. He gives you a bonus of 200 gold pieces.\n" \
"  The caravan continues on its way until the dark, forbidding mountains of Shamishant are visible on the horizon. Ali approaches you again to go on a special mission. Just ahead is the last oasis before the mountains. The caravan must stop there to replenish its supplies before the pass.\n" \
"  One always rushes through the pass itself and the caravan will not stop in the mountains for fear of the ghost that haunt the dark crags and narrow passes. As the oasis is difficult to find, a scout must be sent ahead. Ali is so impressed with you that you don't really get any choice in the matter.\n" \
"  He gives you a full water flask and off you go, heading east. As you trudge through the sand an hour later you sense a change in the air. The wind seems to be picking up. Before long you are struggling against a strong wind and the sand is whipping past you. You can hardly breathe and can't see anything in front of you. You begin to wonder if you will make it. You can stop and get the stinging sand out of your face by going to {204} or you may continue on. If you want to continue, make a first level Luck saving roll (20 - LK). If you make it, go to {203}. If you miss it, go to {286}."
},
{ // 142
"By squinting your eyes you can just make out the shape of distant palm trees. Plod across the sand to {49}. This must be the oasis you've been looking for. The Shamishant Mountains seem much closer here."
},
{ // 143
"Vivina accepts your story and lowers her arm. \"You have been foolish, mortal,\" she says. \"But your ignorance is understandable as you are new to the plains. I will overlook it this time.\" She gives you leave to depart, which you can do by going to {237}, or you may try to win her friendship by going to {52}. You can also offer to make up for any disrespect you may have shown by going to {239}."
},
{ // 144
"Picking one of the flowers near the water, you place it on the altar and hear harp music. Looking around, you see a lovely vision rising from the water. She smiles at you and beckons you to come closer. This is Vivina, goddess of the Great Plain of Bijouwar, and you have pleased her.\n" \
"  \"Welcome, mortal,\" her cool voice whispers on the air. \"I offer you a boon for your respect.\" At your feet, 3 small chests appear: a gold, a silver, and a blue. You may open one chest. If you pick the gold one, go to {21}. To pick the silver one, go to {82}. If you want the blue one, go to {207}."
},
{ // 145
"Vivina is outraged that you would think she would be interested in a mere mortal. Now you have to fight Kakanar, as she is disgusted and wishes to see your bones bleach in the sun. Go to {238}."
},
{ // 146
"The minute the Balrog dies, the genie roars with laughter. \"Free at last!\" he cries. He flits across the sky. When he finally settles down, he turns to you. \"I did promise you a reward, didn't I?\" You nod your head eagerly. \"Well, now, should I give you three wishes? No,\" he murmurs, \"I think I'll just give you this.\" With a 'poof' he disappears. At your feet, you find a dark green cloak. The lamp has vanished with the genie. You can pick up the cloak and go to {53} or leave it there and go to {237} to meet the caravan, cursing the genie's cheapness."
},
{ // 147
"You pull yourself to the top of the cliff and there is another bright flash. Now you are in a room containing two chests, one of bright gold and one of rough wood. The voice whispers that you must open one to leave. Make a first level saving roll on IQ (20 - IQ). If you miss, open the gold chest and go to {241}. If you make it, you open the wooden one, go to {55}."
},
{ // 148
"Vivina thinks you're a bore and has had enough of you. She reduces your Charisma to 2. You've amused her in the other tests, so the releases you to the caravan in a flash of light. Go to {237}."
},
{ // 149
"\"Well done, mortal,\" Vivina whispers. \"You have done well and may go on your way.\" You get 200 experience points for this and are deposited in a flash of light at the caravan. Go to {237}."
},
{ // 150
"Vivina finds you charming. She leads a lonely life. You must make amends for what you have done, but she will be lenient. Roll one die: if you roll a 1 or 2, go to {213}. If you roll a 3 or 4, go to {89}. If you roll a 5 or 6, go to {182}."
},
{ // 151
"After you ask why you've been brought here, Trangen replies that you are the \"guest\" of his village. Every year, the mountain beast comes to the place of sacrifice and one of the villagers must die. Although they risk danger every day robbing and attacking travellers, none of them likes to be eaten. So this year, they decided to capture someone to be sacrificed. This is you, of course. As he speaks, a procession of people march to the cage. Trangen unlocks the door and you are tied and dragged to a spot above the village where you are secured to an old stone altar. \"Just wait here,\" says Trangen, \"It won't be long now.\" As all the people move away, you notice the ropes are loose. Make a first level saving roll on Luck (20 - LK). If you make it, go to {245}. If you miss, go to {29}."
},
{ // 152
"As Trangen turns his back to make sure no one is watching from the village, you are able to reach a rock with your right hand. You knock him over the head and grab his broadsword worth 3 dice plus 4 in combat and his poniard worth 2 dice, if you like. Run into the woods and go to {246}."
},
{ // 153
"After defeating the dragon, you must make your way back to the caravan. Trangen will travel with you if he survived the battle[ and will fight by your side]. You have gained a friend. Make a second level saving roll on Luck (25 - LK) as you wander through the wilderness. If you make it, go to {246}. If you miss, go to {228}."
},
{ // 154
"Having killed all the trolls, you go into the cave. If Sharnalene survives, she goes with you. You find 3 pouches: a green one containing 2000 gold pieces, a brown one containing 10 rubies each worth 100 gold pieces, and a puce one containing a large green emerald worth 1500 gold pieces. This gem is magical[ and will scream the word \"TROLL!\" whenever one is near]. You think it's about time to head back to the caravan. Go to {122}. Sharnalene will go with you if she is still alive as your companion until she gets tired of your company."
},
{ // 155
"Standing near the tent, you suddenly see the sheik emerge into the torchlight followed by 3 mysterious women in veils. If you are male, go to {186}. If you are female, go to {34}."
},
{ // 156
"The sheik surrenders. He is impressed with your skill in combat and for sparing his life rewards you with 500 gold pieces and his falchion. He shows you the way out to {35}."
},
{ // 157
"Make a first level saving roll on Luck (20 - LK) to avoid being seen by the sheik's guards as you sneak away into the night. If you miss, go to {64}. If you make it, go to {35}."
},
{ // 158
"You are sitting on the silk cushions in his tent enjoying a glass of wine, when the sheik returns. His name is Porovan and he is a powerful ruler on his way to Tiern to build a palace by the sea. His dark, handsome looks make you willing to spend some time with him. You have and exotic meal served by slave girls. During dinner you begin to feel uneasy as one of the servers seems to be watching every move you make. After the meal, the sheik talks to you about his life at some length. You notice it is getting late and prepare to leave when the sheik takes your arm and asks if he can trust you. Without waiting for your reply, he walks over to an old travelling trunk and pulls out an elaborate silver box. Tenderly, he carries the box and returns to his seat beside you. He tells you that the great Eye of Zabulu is kept inside the box. There is a curse on the box that would kill any male who opened it. He has heard that a female could open it safely. However, he's not 100% sure that the rumour is true. He'll pay you handsomely if you will risk your life to open it. If you agree to do so, go to {189}. If you feel you should be going, go to {219}."
},
{ // 159
"You look so cute in your harem outfit that the sheik listens to your plea for mercy and his anger cools. He releases you to {35} with much regret."
},
{ // 160
"You walk toward the light almost all night. When you are close enough, you see a campfire blazing away in front of an old, wooden wagon. A very tired, aged horse is tied nearby and on the ground you can see the huddled shape of someone sleeping.\n" \
"  Being a brave adventurer, you walk into the camp as the sun begins to rise in the east. At the sound of your approach, an old man in brightly coloured clothes throws off his blanket and glares at you. He yells, \"No, Messina!\" just as a black cooking pot is smashed over your head. You hit the sand with a thump.\n" \
"  The sun is high overhead when you cautiously open your eyes. A cool cloth is on your forehead and a young woman with dark hair and eyes is looking into your face. Startled to see that you're awake, she draws back and the face of the old man comes into view.\n" \
"  \"It's good to see you're back from the land of dreams, stranger. You must forgive Messina's rudeness, but this is a dangerous land.\"\n" \
"  \"Think nothing of it,\" you say as you struggle to sit up, your head throbbing. \"If you could give me directions to Esturiat, I'll be on my way.\"\n" \
"  The old man looks you over carefully and says he'll be happy to help you if you'll help him. His youngest daughter, Yolandra, has been kidnapped by a powerful wizard by the name of Fereon. He and his daughter, Messina, have been travelling for days from the woods to the north following to the wizard's fortress. They are close now, but could use the help of someone like you. You may have any treasure you find and the directions you need, if you will help. To help them, go to {223}. To decline, go to {69}."
},
{ // 161
"Using a hairpin Messina picks the lock of your prison and the two of you quietly descend from the turret. Make a first level saving roll on Luck (20 - LK). If you make it, go to {8}. If you miss, go to {103}."
},
{ // 162
"Ignoring the scenes on the door, you run and slam your shoulder against it only to find it unlocked. You fly through the doorway and land in a heap at the feet of the wizard Fereon. Your collision has offended him. Make a first level saving roll on Charisma (20 - CHR). If you make it, go to {9}. If you miss, go to {42}."
},
{ // 163
"The castle tumbles down on top of you. You weren't fast enough on your feet. Make a second level saving throw on Constitution (25 - CON). If you make it, take 1 die off your Constitution. If you miss, take 3 dice off your Constitution. Either way, if you still live, dig your way out of this sand trap and go to {101}, ignoring the first two sentences."
},
{ // 164
"As Messina throws herself at the wizard to beg for mercy, you grab a table knife and attack. Make a second level saving roll on Dexterity (25 - DEX). If you miss, go to {227}. If you make it, go to {41}."
},
{ // 165
"Fereon decides to let you live for now, but you're becoming a pest. He summons Yolandra. When she enters the room, she runs to embrace Messina. As they touch, you feel a surge of power. Fereon senses magic, too, and disappears in a flash of grey light. The women smile at you and invite you to remain here with them, as Fereon has fled. They return your weapons and armour. If you would like to stay here with the two witches, you may retire from this adventure with 250 experience points, or you may ask directions to the caravan and go to {124} with 150 experience points and a pouch of 200 gold pieces. Whatever your choice, you have to help the ladies look for their \"frog\" father before you go. Make a first level saving roll on Luck (20 - LK) to find him. If you make it, go to {124} or stop here. If you miss, the witches take 1 point off your IQ for each time you miss as they are upset at not having their father back. You must make the saving roll, so keep trying until you do."
},
{ // 166
"Staying low among the dunes, you edge closer to the Rararadin camp. Suddenly, you hear angry voices. You move forward cautiously to see a man and a woman arguing a short distance from you. They both wear the black garments of a Rararadin warrior. Without warning, the man strikes the woman with his fist and she falls to the sand. He draws his sword and raises it above his head. To help the lady in distress, go to {229}. To ignore this quarrel, go to {14}."
},
{ // 167
"She's a tough one. Her name is Cycera and she is the sister of Lord Shorman and co-leader of the Rararadin. She is wearing leather armour that will take 6 hits and fights with a grand shamsheer that gets 6 dice plus 2 in combat. She has a Constitution of 20 and her personal adds are 30. After you fight and kill her, go to {44}. If you lose, that's all you do."
},
{ // 168
"Kakadoor enters the circle. He stands 6' 7\" tall and looks like a small mountain. He will fight with a grand shamsheer that gets 6 dice plus 2. He's wearing leather armour[ that'll take 12 hits]. He has a Constitution of 25 and gets 25 personal adds for meanness. Your weapons have been returned to you for the fight, so fight now. If you win, go to {231}. If you lose: {77}."
},
{ // 169
"You lower your weapon and smile. Her name is Cycera and she is the sister of Lord Shorman and co-leader of the Rararadin. She thanks you for your help. Falkbar was trying to force her to marry him to increase his standing in the tribe. When she refused, he got violent. If you are male, go to {233}. If you are female, go to {16}."
},
{ // 170
"Life with the Rararadin is exciting and you are soon a respected leader of the tribe. You retire here until you are called to other adventures and must wander on.\n" \
"  You can leave this adventure now with 350 experience points. However, if the life of a leader isn't to your liking and you yearn for the days when you were on your own with no responsibility, you can still join up with Ali Cambrasna's next caravan by going to {141} and ignoring the first sentence."
},
{ // 171
"As you start to tie up your prisoner, he decides to speak. He offers to show you a safe way into the Rararadin camp, if you spare his life. If you trust him, go to {109}. If not, tie him up and bring him along to {234}."
},
{ // 172
"In the morning, the Rararadin ride past your body on their way to attack the caravan."
},
{ // 173
"Roll one die. If you roll a 1 or 2, you find nothing but sand in the silver chest. If you roll a 3 or 4, the chest yields a ruby worth 300 gold pieces. If you roll a 5 or 6, you find a magic bottle containing a liquid that will restore all Constitution points if you drink it. There is enough for one use only. Now wander east to the palm trees you see in the distance by going to {49}."
},
{ // 174
"You just aren't sure of the way. You set out in a likely direction. Roll one die. This is the number of days you wander around looking for the oasis. For each day, you must make a first level saving roll on Constitution (20 - CON) to survive on very little water under a hot sun. If you miss, take the difference off your Constitution. If you still live, you notice palm trees in the distance and go to {49}."
},
{ // 175
"Your answer wasn't satisfactory. She raises her arm above her head and a whirlpool rises from the water and swirls right at you. You are lifted into the air and hurled above the oasis. The end could be near. Make a second level saving roll on Constitution (25 - CON). If you miss, it is the end. There was too much water and too little air in the whirlpool for you. If you make it, the whirlpool drops you off onto the sand a short distance from the oasis. You may wait here for the caravan after taking 1 point off your Constitution for damage done in the fall. If you still live, go to {237}."
},
{ // 176
"You awaken in the morning beside the water in the oasis. You can hear the sounds of the caravan approaching. Proceed to {237}."
},
{ // 177
"Vivina decides to spare your life. You at least tried to make amends. She makes you her pet mortal and keeps you imprisoned in her blue palace beneath the water for the rest of your life."
},
{ // 178
"In the chest you saw 100 gold pieces and a ruby worth 250 gold pieces. You are able to grab them before a flash of light takes you to {179}."
},
{ // 179
"As you open your eyes, you can see nothing. You seem to be surrounded by leather. In fact, you are in a large pouch being carried by a giant. As he carries you along, he swings the pouch, sometimes dragging it on the ground, and sometimes throwing it in the air. To survive this rough treatment, make a first level saving roll on Constitution (20 - CON). If you miss, the beating was too much for you, go to {85}. If you make it, go to {242}."
},
{ // 180
"You reach the sword, which comes out of the stone easily. It gets 10 dice in battle. Fight Bluking now. He has an MR of 120. His tough scales will take 5 hits. If you win, go to {26}. If you lose, Bluking enjoys an afternoon snack."
},
{ // 181
"The woman kisses you on the cheek and raises your Strength by 2. If you have rescued all three, go to {149}. If you aren't done, return to {57} and choose again."
},
{ // 182
"You must dance for Vivina. Beautiful flute music comes out of nowhere, as you begin to dance. Make a first level saving roll on Dexterity (20 - DEX). If you miss, Vivina thinks you're clumsy and sends you back to the caravan[ with a pair of dance shoes to practice with]. Go to {237}. If you make the saving roll, go to {28}."
},
{ // 183
"Unless you're immune to poison, you're dead. This breed is always fatal. Your death is slow and painful and Trangen smiles through your agony. If you're immune to poison, Trangen admires your strength and says the dragon may find you tasty. A procession of villagers advances on the cage. Trangen explains that the dragon must be fed once a year or he will destroy the village. You've been chosen for this honour. Trangen unlocks the door and you are taken up to a stone altar, bound to that same altar, and left to die. You notice the ropes are loose and work at them frantically. Make a first level saving roll on Luck (20 - LK). If you make it, go to {245}. If you miss, go to {29}."
},
{ // 184
"Sharnalene says she needs the help of a brave soul. She knows where there's a rich treasure, but one warrior, no matter how good, could never get it alone. She unties you and returns your weapons and belongings. As you walk through the wilderness, she explains that a large cave troll has stolen her treasure and all you need to do is help her fight the troll. You come to a cliff and follow a narrow mountain path for what seems like hours. You come to a shelf on the rock and see a cave. In front of the cave is a cave troll, MR 150. It grunts and attacks. Make a first level saving roll on Dexterity (20 - DEX). If you miss, go to {92}. If you make it, go to {123}."
},
{ // 185
"By putting on your cloak, you may take your first combat roll directly off their Constitutions, as they are confused. [If Trangen is with you, he will join you in the fight on the second round. ]Fight normally on the second round, if any bandits still live. If you win, go to {216}."
},
{ // 186
"The sheik strides past you without a second look. However, as the veiled ladies walk by, the last one in line looks at you and winks with one of her big, blue eyes. Brushing past you, she whispers, \"Meet me behind the tent in one hour\". If you ignore her, return to your bedroll at {217}, or else wait an hour and go behind the tent to {32}."
},
{ // 187
"You may fight the sheik by going to {2}, or if you carry a weapon with a sharp edge, you may cut your way through the tent at {65}."
},
{ // 188
"You find 30 gold pieces on each guard. Take the money with you and go to {35}."
},
{ // 189
"The sheik is very pleased with your decision. Make a second level saving roll on Luck (25 - LK). If you miss, go to {36}. If you succeed, go to {128}."
},
{ // 190
"A beautiful woman, silver dagger in hand, is screaming at you in a language you don't understand. This is the same woman who watched you during the meal. Her name is Tallarura and she is the sheik's favourite wife. As she springs to attack you again, the sheik grabs her. He explains that she is very jealous. Make a second level saving roll on IQ (25 - IQ). If you make it, go to {67}. If not, proceed to {129}."
},
{ // 191
"It's a long hot walk to the foothills, but Jasima intrigues you with stories of her nomad people. She's wandered too far for water, but her herd is all she has. By evening you've reached a small waterhole and the goats drink their fill. You're so thirsty that you want a drink badly, but Jasima makes no move to drink. As you head toward the water, she tells you that only animals can drink here as it is protected by an old wizard's spell. If you ignore her words, go to {7}. If you don't drink, go to {99}."
},
{ // 192
"Glancing again at the women, you see them circling the room still chanting and holding each other. A dark hand touches your shoulder and you whirl around to see Capristo. He takes you by the arm and leads you out of the fortress explaining that his daughters are powerful witches, but only when they are together. They have returned him to human form and are now dealing with Fereon himself.\n" \
"  Capristo and you stand on a sand dune watching the castle. It begins to shimmer in the sun and then in a bright flash of light, it crumbles into a hill of sand. The two sisters suddenly appear before you. \"Fereon is gone,\" explains Messina. \"We thank you for your help.\"\n" \
"  As a reward, they each kiss you which increases your Constitution by three for each kiss. All your weapons and armour are also returned. You are given a chance to choose your destination. You can be transported back to Esturiat and out of this adventure with 150 experience points, or you will be placed near a caravan to continue your trip to Tiern by going to {124}."
},
{ // 193
"\"Good fight! \" exclaims Fereon. You untie Capristo and Messina while Fereon and Yolandra descend from the balcony.\n" \
"  \"You may go now, but I keep the women,\" says the wizard when he stands in front of you. If you agree, go to {70}. If you don't like this arrangement, go to {132}."
},
{ // 194
"You take Fereon by surprise and he dies instantly. His body changes into a grey dust that settles on the floor. The castle walls begin to tremble and the whole place is coming down around you. Make a first level saving roll on Luck (20 - LK). If you make it, go to {101}. If you miss, go to {163}."
},
{ // 195
"When Fereon finishes his toast, he claps his hands and Yolandra enters the room. Fereon informs you that he wishes to marry and will have one of the sisters or you, if you happen to be female. If someone will marry him, you will be allowed to leave. If you let one of the sisters have him, go to {10}. If you'll marry him, go to {72}. If you'd rather kill him, go to {164}."
},
{ // 196
"You and Messina are now a part of Fereon's glass statue collection and Yolandra will never be saved."
},
{ // 197
"As the day progresses, the caravan winds its way across the dunes. You keep an ever-watchful eye on the horizon. This is the land of the fierce desert warriors, the Rararadin. They're so fierce that mothers in Esturiat use them to scare their children into obedience. But you aren't scared, at least not at first. Toward afternoon you begin to feel uneasy. Your glances to the horizon come more often. Once or twice you catch a dark shadow which quickly vanishes.\n" \
"  Soon the uneasiness has spread throughout the caravan. Suddenly you hear a shout. Looking north you see a line of dark black horses, their red eyes glowing. Mounted on the horses are the Rararadin, dressed in long black robes, black turbans on their heads, long silver swords at their sides.\n" \
"  The caravan master hurries the merchants on under the gaze of the Rararadin who follow at a distance for the rest of the day.\n" \
"  At dusk, the caravan master, Ali Cambrasna, comes to your fire and asks that you go into the desert and seek the camp of Rararadin to gain information on their strength and plans. It would be dangerous, but if they attack tomorrow it might be the end of everyone. If you agree to spy, go to {12}. If you'd rather stay safe by your fire, go to {74}."
},
{ // 198
"You are able to avoid a passing group of Rararadin and get close enough to the camp to observe the activities. While you are watching, an argument breaks out between two men. They draw swords. From their shouts you learn that there is some disagreement about whether or not they should attack your caravan. The leader, Lord Shorman, quickly wins the contest. The camp becomes quiet and he orders his people to prepare to move on in the morning. They will attack a richer caravan to the south. Hearing this, you quietly back away to {75}."
},
{ // 199
"Seeing his companion lying in the sand, Omar praises your fighting skill. The noise, however, has attracted 5 more of the desert warriors. Omar suggests you surrender and accompany him to camp. If you agree, go to {76}. If you want to fight on, go to {46}."
},
{ // 200
"Lord Shorman and you get along famously. You like the wild life of the Rararadin, raiding caravans and riding like the wind on your black horse. When Lord Shorman asks you to be his wife, you agree and retire here until you get restless and go to other adventures.\n" \
"  You may leave this adventure now with 350 experience points and Lord Shorman. However, if you begin to yearn for the good old days, take your silver jewellery worth 500 gold pieces and steal away into the night to {141} where you meet Ali Cambrasna and another caravan heading for Tiern. Ignore the first sentence."
},
{ // 201
"The Rararadin wine and dine you through the night. Lord Shorman is sorry you won't stay, but gives you safe passage back to the caravan promising that he will let your group pass without harm. Go to {75}."
},
{ // 202
"In the Rararadin camp, Cycera explains how you helped her. You are welcomed as a friend. Even Lord Shorman is impressed. He asks you to stay and fight with them. He offers you his best horse, Makran, if you'll stay and hints that he thinks you're \"his kind of woman\". If you stay, go to {47}. If you want to leave, go to {201}."
},
{ // 203
"Moving forward in what you think is an easterly direction, you hear a low growl above the wind. Make a second level saving roll on Luck (25 - LK). If you make it, go to {18}. If you miss, go to {111}."
},
{ // 204
"Taking off your cloak, you wrap up in it and seek shelter near a cactus which blocks a small portion of the blowing sand. In the distance you hear what sounds like a low growl. Move out to investigate by going to {111}, or remain where you are by going to {50}."
},
{ // 205
"You take long swallows of the cool water. It certainly tastes good after all the sand you've eaten recently. Not only does it taste good, but it also has magical properties that increase your Strength and Constitution by 2. Make a second level saving roll on Luck (25 - LK). If you miss, go to {81}. If you make it, go to {51}."
},
{ // 206
"You stretch out under a palm tree and drift off into a peaceful dream. You awaken 2 hours later with a moan. There is a sharp pain in your back. You get up and search the ground to find that you have been sleeping on an old, battered gold lamp. Make a first level saving roll on IQ (20 - IQ). If you make it, go to {22}. If you miss, go to {115}."
},
{ // 207
"The blue chest contains a blue sapphire worth 750 gold pieces and a silver bracelet containing 1 blue sapphire worth 200 gold pieces. This bracelet will make you immune to poison as long as you are wearing it. Now go to {237} with the goddess' blessing, which adds 1 point to your Charisma."
},
{ // 208
"Vivina laughs and says she doesn't play with children. You may leave by going to {237} or try to make amends by going to {239}."
},
{ // 209
"\"You do not seem like such a bad mortal,\" whispers Vivina. \"I will give you a chance to live by amusing me. If you survive, you may go in peace.\" Roll one die. If you roll a 1 or 2, go to {24}. If you roll a 3 or 4, go to {56}. If you roll a 5 or 6, go to {57}."
},
{ // 210
"You didn't see something moving in the chest. Vivina whispers, \"Your luck has run out, mortal,\" as you are bitten by a scarlet crimiln snake. Once it gets its teeth into you, it slowly drains all your blood. Go to {85}."
},
{ // 211
"Vivina finds you to be a rare treasure. She forgives you for the way you acted in the pool and gives you a large pearl worth 5000 gold pieces and increases each of your attributes by 2. She sends you back to the caravan with a flash of light. Go to {237}."
},
{ // 212
"You run to the man to pull him out. If you have a blue rope, you pull him out with no trouble. Go to {149}, or back to {57} if you haven't rescued everyone. If you have any other type of rope, go to {27}. If you don't have a rope, go to {120}."
},
{ // 213
"You must entertain her with the story of your life and adventures. Make a first level saving roll on IQ (20 - IQ). If you make it, go to {58}, as she was amused. If you miss, you were so boring that she reduces your IQ by 3 and sends you back to the caravan at {237}."
},
{ // 214
"Trangen released you from the cage and takes you off into the woods, where you tell him that you have a coin hidden in your boot that your captors didn't find. It's very valuable and if he'll help you to escape, you'll give it to him. If you look for a chance to escape on your own, go to {152}. If you'd rather wait to see if Trangen will help you, as you have no weapons, go to {121}."
},
{ // 215
"If Sharnalene still survives, she is able to get a bolt into the body of the advancing female troll, MR 140, and reduces its MR to 100. If you also have a cloak that grants invisibility, put it on and take your first combat round directly off the troll's MR. If you have neither of these and have a weapon you can throw, you may take your first combat roll directly off the troll's MR. If none of these apply or if you have already used them, you must fight her in normal combat now. She is angered at the loss of her mate and won't rest until you're dead. If you survive, go to {154}."
},
{ // 216
"You search their bodies and find 200 gold pieces and 5 pearls worth 100 gold pieces apiece. Head back to the caravan at {122}."
},
{ // 217
"You have just dozed off when you are awakened by Farlon, a fellow guard. \"Take my watch,\" he says, \"I'm sick\". With that said, he turns green and hurries off. You drag yourself out from under your warm blanket and take his position near the rear of the caravan. Make a first level saving roll on Luck (20 - LK). If you miss, go to {248}. If you make it, read on. You notice movement and turn to face a desert thief. He stands 6' 3\" tall and fights with a great axe worth 5 dice plus 3 in combat. He wears leather armour which will take 6 hits and his Constitution is 15. With his 20 personal adds, he feels confident enough to fight you here. If he kills you, he gets a chance at the riches in the caravan. If you kill him, you may go to {1}."
},
{ // 218
"Narada's eyes blaze with anger at your refusal. She acts as one of the sheik's bodyguards and no one would suspect a harem girl as being a trained killer. With one hand she tears away her veils to reveal a falchion worth 4 dice plus 4 and a kukri worth 2 dice plus 5. You must fight her. If you use magic, write down your spell and go to {33}. If you fight with weapons, go to {96}."
},
{ // 219
"The sheik is upset that you should reject him. After all, he has the power of life and death over his subjects. Make a first level saving roll on IQ (20 - IQ). If you make it, go to {4}. If you miss, go to {66}."
},
{ // 220
"Enraged, the sheik draws his falchion which gets 4 dice plus 4 in attacks. His Constitution is 20 and he has 15 personal adds. He will fight alone for the first combat round. If you wound him by getting one hit, he will surrender, go to {156}. If your fight goes into a second round, roll one die. This is the number of guards that will come to the sheik's aid. They have scimitars that get 4 dice in combat and wear armour that will take 6 hits. They each have a Constitution of 10. You may surrender at any time by going to {97}. Keep fighting until your Constitution reaches 2 and then you are too weak to continue and must surrender by going to {97}. If you win by killing all the guards and wounding the sheik by getting at least one hit, which should be easy as he doesn't wear any armour, then you should go to {156}. If they should happen to kill you, then this is as far as you go."
},
{ // 221
"Tallarura is victorious and you ache all over. The sheik believes you are a weakling and throws you out of his tent with your belongings. Crawl to {35}.[ If he gave you any gifts, he will keep them.]"
},
{ // 222
"The snake sees your movement and strikes. If you're immune to poison, make a first level saving roll on Constitution (20 - CON) to see if you survive the trauma of snakebite. If you make it, go to {31}, as you are confused after the bite. If you miss, the shock kills you. If you're not immune to poison, it takes 2 days for you to die under the desert sun."
},
{ // 223
"They are pleased with your answer and Messina cooks a fine meal of desert hen for you before you climb into the wagon for the journey to Fereon's fortress. By the end of the day, you are relieved to stretch your cramped legs and are looking at a massive sand castle rising out of the desert, tall turrets almost touching the clouds. It appears deserted, but you and your new friends know better than that. The old man suggests you sneak in during the night and you are starting to argue who's in charge, when there is a large clap of thunder and 7 warriors stand around you. They all carry magical swords worth 5 dice in combat. They have 20 personal adds and Constitutions of 25. They are also wearing magical silver armour that will take 10 hits. They raise their weapons and attack with a hideous war cry. [Messina and her father grab their weapons and will fight with you. She fights with a black dagger enchanted to get 3 dice plus 20 in battle. Her Constitution is 25 and her personal adds are 20. Her father fights with a scimitar that will get 4 dice in combat. He has a Constitution of 10 and 30 personal adds. ]The battle will go on until you [and your companions ]are [all ]wounded with at least 1 hit, which will paralyze you. They will not kill anyone. When you are unable to move, go to {38}. If you happen to kill all the warriors, go to {100}."
},
{ // 224
"Capristo, the old man, is an expert knife thrower and seeing your escape puts his knife neatly in your back as you run, ending your adventure."
},
{ // 225
"You dodge the arrow and it sticks in the wall behind you, barely missing Messina. As you peer into the room, you see a woman standing out on the balcony, her long black hair blowing in the breeze.\n" \
"  \"Yolandra,\" shouts Messina, pushing you aside. The two women embrace and clutch hands. They look so much alike that you couldn't tell them apart except for their clothing. \"Come on,\" you whisper, \"We've got to get out of here.\"\n" \
"  \"That won't be necessary now,\" says Yolandra. \"We can take care of everything.\" The women continue to hold hands and begin to chant softly. However, as you stare at them in astonishment, something golden catches your eye near the bed. To investigate, go to {39}. To ignore the sparkle of possible treasure, go to {192}."
},
{ // 226
"Fereon is impressed with you. He would like to get to know you better. You spend all morning trying to convince him to let you all go. He says he will put you in a caravan if that is what you desire, but the others must remain. If you accept this offer, go to {124} with 150 experience points and the wizard's affection, along with your belongings. If you won't go without the others, go to {102}."
},
{ // 227
"Fereon notices your clumsy attack and you are turned into strawberry jam."
},
{ // 228
"As you go along, you hear a war cry and 3 bandits from the village jump out of the woods at you. They carry broadswords worth 3 dice plus 4 in combat and have personal adds of 10. Their Constitutions are 15. They do not wear armour. Fight for your life here. [If you are travelling with Trangen, he will fight with you. ]If you have a cloak that grants invisibility, go to {185} before the fight begins. If not, fight here until you die or win. If you win, go to {216}."
},
{ // 229
"Weapon drawn, you run over the sand to the couple. Make a first level saving roll on Speed (20 - SPD). (If you don't have a Speed attribute, roll one up now with three dice.) If you make the saving throw, go to {13}. If not, go to {48}."
},
{ // 230
"Just in time you notice a slight movement. You go cautiously toward it and find that it's a silver hrombri desert beetle of the poisonous variety. You neatly step aside and continue back to the caravan at {141}."
},
{ // 231
"\"Congratulations,\" shouts Lord Shorman. \"You are one of us now.\" He rewards you with Kakadoor's sword and armour plus a pouch of gems worth 1000 gold pieces. Lord Shorman invites you to stay with them. If you do, go to {107}. If not, go to {201}."
},
{ // 232
"You trip over a pouch containing 50 gold pieces that was lying in the sand apparently dropped during the fight. You continue to sneak toward camp. Luckily the scuffle did not attract any attention due to the laughter and music from the campsite. As you creep closer, you must make a second level saving roll on Luck (25 - LK). If you make it, go to {198}. If you miss, you are noticed by other sentries and go to {138}, ignoring the first sentence."
},
{ // 233
"Cycera thinks you're cute. She would like you to join her in the camp. You may follow her to {79} or head back to the caravan at {75}."
},
{ // 234
"Rararadin will not allow themselves to be taken alive. As you move across the sand, you fail to notice that your prisoner has loosened his bonds. Make a first level saving roll on Luck (20 - LK). If you make it, go to {110}. If you miss, go to {17}."
},
{ // 235
"Almost 30 minutes have passed, but the wind has finally died down. You shake off the sand, which seems to be in everything you own, and look about. Make a first level saving roll on Luck (20 - LK). If you make it, go to {142}. If you miss, go to {174}."
},
{ // 236
"It's not wise to turn your back on a sand demon. A huge claw reaches for you. Make a first level saving roll on Dexterity (20 - DEX) to avoid its clutches. If you make it, you elude its grasp and turn to fight. It has an MR of 100. [Each combat round, make a first level saving roll on Luck to (20 - LK) see if it materialized long enough for you to strike it. If you don't make your saving roll, any hits you got against it didn't count. ]If you win, you get 300 experience points and should go to {80}. If you lose, the sand demon eats your soul, a rare delight for a sand demon.\n" \
"  If you missed your saving roll on Dexterity, take 2 dice worth of hits from the claws. If you still live, fight as mentioned above and go to {80} if you best the demon."
},
{ // 237
"Ali Cambrasna is delighted to see you again. You inform him there are no bandits about so the caravan fills up on water for the journey over the pass. Ali has a diamond medallion allowing him to use the water in the oasis, which is governed by the goddess Vivina. He asks you if anything odd happened to you (Ali is so perceptive) and when he hears of your adventure he gives you a bonus of 200 gold pieces.\n" \
"  The caravan travels on to the Shamishant Pass. This region is filled with fierce bandits and other horrors. High mountain peaks surround you as you travel on. The air is cool and fresh. You fell relaxed even though you know caravans have disappeared in this area before, without a trace!\n" \
"  One cold morning with the sun just a pink glow in the sky, you are shaken awake and see the pale face of Ali leaning over you. He sends you, his star scout, out in the cold to search the pass ahead. He informs you, this is the worst spot in the trip, and once clear of this area it's all downhill to Tiern. As you wander out into the wilderness looking for trouble, you hear a twig snap. To walk cautiously forward, go to {59}. If you stop and listen for other noises, go to {61}."
},
{ // 238
"As you watch, a \"thing\" rises out of the water and floats to your side. Kakanar cannot be described, as you cannot see much of it. It's like a dense cloud, yet it's solid. You see two blue eyes and the ground shudders as it moves. Its cloudlike skin will take 5 hits. Kakanar has an MR of 100. Make a first level saving roll on Dexterity (20 - DEX) to see if you are able to put on your armour before the fight. Grab your weapons and fight it here. If you kill it, go to {113}. If your Constitution is reduced to 2, go to {177}. If you are killed, go no further."
},
{ // 239
"Vivina is delighted that you wish to show respect, so few people travel the plains these days who are respectful of a goddess. She asks that you carry a medallion over the Shamishant Pass for her. If you agree, go to {83}. If not, why did you read this? Go back to the paragraph you came from and choose again. You obviously weren't sincere."
},
{ // 240
"The angry form of Vivina, goddess of the Great Plain of Bijouwar, rises from the water, cold blue eyes flashing. You have shown disrespect and she zaps you out of existence. You are now one of those attractive flowers near the altar."
},
{ // 241
"The voice whispers, \"All that glitters is not gold,\" as you open the chest. A blue mist pours out of the chest, turning you into a blue sapphire worth 100 gold pieces. Vivina will use you as part of her jewellery collection."
},
{ // 242
"A flash of light brings you back to the white surface, but this time you aren't alone. In a long row in front of you stand 10 archers. \"Run for your life, mortal,\" whispers Vivina. As you run, make a first level saving roll on Dexterity (20 - DEX) to avoid the arrows. If you miss, go to {25}. If you make it, go to {86}."
},
{ // 243
"The woman screams again as the three men move closer. As you approach, they turn to you. They fight with magical axes which get 6 dice[ and cut through all armour except magical armour]. They don't wear armour, as they think they can't be beaten. They each have a Constitution of 20 and 15 personal adds. Fight now. If you survive the first combat round, make a first level saving roll on Luck (20 - LK). If you make it, go to {119}. If you miss, fight here until you win or die. If you win, go to {181}. If you killed them all on the first round, go to {181}."
},
{ // 244
"Trangen is insulted by your words. His face gets as red as his hair. He draws his sword and informs you that being eaten by a dragon isn't good enough death for you. While you're thinking \"Dragon?\" he picks a scorpion up with his sword and drops it into the cage with you. Make a second level saving roll on Luck (25 - LK). If you miss, go to {183}. If you make it, go to {252}."
},
{ // 245
"You hear the distant roar of a dragon. It sounds big. You struggle out of your bonds and leap off the stone altar. As you run to the woods, you see the dragon flying toward the altar and it really is huge. You glimpse a figure near the trees to your right. He is motioning to you. To go toward him, go to {91}. To turn the other way, go to {60}."
},
{ // 246
"You stumble upon a small cabin. Going in, you find an old woman. She will heal any wounds you have. Her name is Brashnavalva. If you will stay and read to her this evening, she will reward you. If you can't read or don't want to, go back to the caravan at {122}. If you'd like to help an old witch with poor eyes, go to {30}."
},
{ // 247
"Sharnalene hates cowards. She plants 2 arrows in your chest. You are a goner."
},
{ // 248
"You are struck from behind by a thief hoping to do a little robbing tonight. Take 1 die roll off your Constitution. If you still live, you must fight him here. He is 6' 3\" tall and is carrying a great axe worth 5 dice plus 3 in this fight. He has 10 personal adds and his Constitution is 15. Under his cloak you catch a glimpse of leather armour which will take 6 hits. If you survive, go to {1}."
},
{ // 249
"If you use Take That You Fiend, the spell will work. Return to {64} and fight them. If you use Concealing Cloak, go to {126}. All other spells were a waste of Strength as the guards have protection against certain spells. Return to {64} and fight."
},
{ // 250
"You find a leather pouch with 150 gold pieces and a ruby ring worth 500 gold pieces on her body. You may take these. Make a first level saving roll on Luck (20 - LK) to avoid being seen by the sheik's guards as you sneak away to your bedroll. If you miss, go to {3}. If you make it, go to {35}."
},
{ // 251
"The troll's mate emerges from the cave. She attacks at once. She has an MR of 140. You must fight on, or die on the rocks. If you survive, go to {154}."
},
{ // 252
"You are able to avoid the deadly sting of the scorpion and kick it out of the cage, only to have Trangen inform you that you are to be sacrificed to the dragon. Go to {151} and ignore the first sentence."
},
{ // 253
"A few days later the mountains are at your back and you can see the ocean and the white buildings of Tiern. A short journey through the grasslands gets you to Tiern and out of this adventure. You get 5000 experience points and a free drink at the Sea Turtle Tavern in Tiern for living to tell about your travels."
},
{ // 254
"Fereon decides to use you like a bookend. He can't think of anything else to do with you. He feeds Messina and the frog to his pet and you sit in his library forever next to a book about the dangers of travel in foreign lands."
},
{ // 255
"You and Marcus trudge over several dunes in the early morning light. Marcus is a rogue from Tiern and tells you all about that thriving port. As you top the third dune, he grips your arm and points. Just ahead of you the air shimmers and a village appears where there was only sand earlier. It has tall spires and gables set at odd angles. You hear the sounds of a busy town life: horses, voices, wagons, and music. Marcus turns to you and says, \"Remember, only two hours. I'll meet you back here in *two hours*. If you don't leave in that time, you'll be trapped and will never get out.\" With that, he moves off to the village, leaving you to choose. If you go into the village, go to {271}. If you would prefer to go back to the caravan and get back to work, go to {141}."
},
{ // 256
"Perina brings you a large, cool ale. It looks so good after your desert hike that you quickly reach for it. Perina is also reaching for your gold piece at the same time. The result is a disaster. Your ale goes flying and lands in the lap of the largest fighter in all of Allivar. Naturally, he takes immediate offence. He snarls, gets up and knocks your table aside, drawing his Great Sword. The entire tavern clears out, as people run in all directions. \"Gregor kill small one,\" he grunts. You have no choice but to fight. He has a MR of 85. If you win, go to {269}. If you lose, go to {278}. Magic will not work against him, as it doesn't work in the village at all, possibly due to the enchantment placed upon it."
},
{ // 257
"The two hours pass quickly. The village begins to vanish for another 300 years and you are going to be trapped here for all time. If you make a third level Luck saving roll (30 - LK), you can escape just in time by praying, and are able to trudge to the caravan and get to work at {141}. Marcus didn't wait. He thought you wouldn't get out. If you miss, you have to stay forever."
},
{ // 258
"You pass out and when you come to, you don't know how much time has passed. Make a second level Luck saving roll (25 - LK). If you make it, you have time to leave. Go to {266}. If you miss, you are trapped in the village for 300 years. But even then, you can't leave as you'll need the enchantment of the village to survive after so long."
},
{ // 259
"The temple is an odd building in the shape of a foot with doors where the toes would be. As you enter, you are greeted by a beige-robed priest. \"Welcome, my child. Are you here to join our faith?\" If you want to join, go to {280}. If you want to know about the Foot of Power, go to {268}."
},
{ // 260
"\"Wait, my child. Let me bless you before you go.\" He raises his arms and prays in a strange tongue. You feel different. Each of your attributes are increased by 1. \"May the gods watch over you,\" he says as you leave. Outside, you see that the time has passed. You hurry out, almost knocking a woman down and sending the bread she was carrying flying in the air. You meet Marcus at the dune and return to the caravan and your job at {141}."
},
{ // 261
"You are judged to be a basically good person and are forgiven for your mistake. You lose 3 on your Luck for good. If you repent and drop the Foot of Power, go to {267}. If you still want to have it, go to {281}."
},
{ // 262
"Roll two dice. Take this amount of your Constitution. If your Constitution is now 0, the drink killed you. If you are still alive, you've had enough of this powerful brew and you leave the tavern by going to {266}. You get 50 experience points for your drinking."
},
{ // 263
"The priest blesses you, raising each of your attributes by 1, and gives you a small foot pin. It's not a diamond, but it's not worthless either. [It adds 10 to your Strength when you wear it. ]You leave the temple and make your way through the streets. Down a side street you see a well. If you feel you are out of time and should leave, go meet Marcus at {276}. If you want to check the well, go to {270}."
},
{ // 264
"You make your way to the temple down the busy main street. As you walk along, someone bumps into you. Make a second level saving roll on Luck (25 - LK). If you miss, go to {277}. If you make it, go to {285}."
},
{ // 265
"The well really does work. Your time is up and the village is vanishing. Your coin allows you to escape the village and arrive back at the caravan, ready for work at {141}. Your Luck increases by 1 and you have 100 experience points for your wish and your adventure."
},
{ // 266
"You leave the tavern and make your way out into the desert. Marcus is waiting for you and you return to work at the caravan after you watch Allivar fade back into the mists of time. Go to {141}."
},
{ // 267
"The priest tells you to leave at once which you quickly do. You don't know how much time has passed, so you hurry out of the village to the dune. Marcus arrives 5 minutes later and the two of you return to the caravan at {141}. Marcus wonders why you won't talk about your morning."
},
{ // 268
"\"Ah,\" he says, \"a visitor to Allivar, city of delays. We never do seem to get much done here. Oh, but that's the way we live here and one must take what the gods send our way. Come, let me show you our most prized possession.\" He takes your hand and shows you to the altar which is also shaped like a foot. But what really catches your eye is the small necklace resting on a velvet cushion. It's a foot, but a foot of pure diamond (worth a fortune). The priest continues, \"I see what you're looking at and know what you're thinking. We don't have to guard the Foot of Power. Our god takes care of that for us.\" To steal the foot, go to {274}. If you've changed your mind and start to leave, go to {260}."
},
{ // 269
"Gregor has no chance against such a skilled foe. As he lies at your feet, the crowd returns and you are bought many free ales. You get 100 experience points. Time has been ticking away. If you feel you should leave now, go to {266}. If you think there's no hurry, go to {257}."
},
{ // 270
"The well is dark and wet. A sign says it is a wishing well. If you put a coin in it, you'll get your wish. If you put in a coin, go to {265}. If you would rather not, go to {272}."
},
{ // 271
"You enter this odd village and are surprised to find cobblestone streets and no sign of sand or desert. The air is cool and fresh. Marcus told you the temple is reported to contain a magical item called the Foot of Power. The temple is at {264}. If you don't want that much adventure, you can go to the tavern at {283}."
},
{ // 272
"You wasted too much time. The village is vanishing. You'll be trapped for 300 years if you can't make a third level saving roll on Luck (30 - LK). If you make it, you get out just as Allivar disappears. Go meet Marcus at the dune and return to the caravan at {141}. If you miss, you're stuck right here."
},
{ // 273
"You feel Perina slapping your face as your senses return. Everyone applauds and cheers at your great ability to hold drink. You gain 5 to your Constitution. They invite you to drink again. If you want to, go to {282}. If you think you should leave, do so by going to {266}."
},
{ // 274
"Greed wins the day for you and you push the priest out of the way and grab the Foot of Power. The priest yells, \"No, my child, don't!\" but you don't listen. You have a chance if you can make a third level saving roll on Luck (30 - LK), twice. If you make both rolls, go to {261}. If you miss any at all, go to {281}."
},
{ // 275
"The surprise of the crowd is apparent. No one has ever done that before. You gain 100 experience points and a free ale. If you want to leave now, go to {266}. If you want to stay longer, even though it feels like hours already, go to {257}."
},
{ // 276
"You leave the village just in time as it glows and vanishes behind you. Marcus calls to you to hurry and you both trudge back to the caravan at {141}. You gain a religion and 100 experience points."
},
{ // 277
"The little urchin who bumped you stole half of your gold. Make the deduction and go to {259}, the temple."
},
{ // 278
"You will never leave Allivar now. The gods regret that your adventure ends here."
},
{ // 279
"Sadly the priest bids you farewell. You leave and return to the dune where Marcus tells you he won 100 gold pieces gambling. You curse the entire way back to the caravan at {141}."
},
{ // 280
"The priest is radiant. He rubs his hands in delight. Then he takes you over to the foot-shaped altar and shows you the small diamond Foot of Power, which rests on a velvet cushion. He tells you that the gods left it in their care to give them the strength to fight against their foes. He proceeds to tell you a long, boring tale about gods and feet. Then he asks you if you are a true believer. If you still want to join this strange faith, go to {263}. If you'd rather not join, go to {279}."
},
{ // 281
"The gods are upset and you feel a surge of power pass through you. You can't move. You've been changed into a small holy relic in the shape of a foot."
},
{ // 282
"Perina brings you another specialty. Make a third level saving roll on Constitution (30 - CON). If you miss, go to {262}. If you make it, go to {275}."
},
{ // 283
"The tavern is just a short walk down a side street. You walk in under the sign proclaiming this the \"Dead Pigeon Inn\". The carved wooden sign portrays a bird on its back, feet in the air. Just like any tavern there are tables filled with people and lovely barmaids passing out large tankards of ale. As you hesitate, a girl approaches and says, \"Welcome to Allivar, city of delays.\"\n" \
"  \"Why do you call it that?\" you ask as she shows you to a table.\n" \
"  \"Well,\" she replies, \"we never seem to have time to get anything accomplished. What'll it be?\"\n" \
"  You have the following choices: order an ale at {256} or the house specialty at {284}."
},
{ // 284
"Perina brings you a small drink. The glass is shaped like a skull. There are about two sips in the drink. \"You drink it in one gulp,\" says Perina. Fearlessly, you grab the glass and drink. The world spins; it feels like you've swallowed lava. Your face goes pale. You dimly realize that Perina is asking you for 4 gold pieces. Make a second level saving roll on Constitution (25 - CON). If you miss, go to {258}. If you make it, go to {273}."
},
{ // 285
"You feel a hand in your pocket and quickly reach down preventing the loss of your gold. A small dirty child looks at you, grins sheepishly, and kicks your shin. While you're yelling, he runs away and is lost in the crowd. Move on to the temple at {259}."
},
{ // 286
"You move at an angle to the wind and drop into a small depression between sand dunes. There the wind has lost most of its bite. The valley continues north and east and fairly quickly you find yourself at the Shamisant Mountains. You've missed the oasis entirely! Oddly, at the base of the mountains, the ? shuns the mountains as strongly as Ali Cambrasna.\n" \
"  If you want to climb up the Sham Jebel, the black fang of rock rising from the desert floor, to try and spot the oasis from above, go to {307}. If you'd prefer to strike out through the storm again and try to find the oasis, go to {293}."
},
{ // 287
"Getting to the bottle will be a problem because of the skeletons doing their best to stop you. It will take a sixth level Dexterity saving roll (45 - DEX) to reach the bottle. [The skeletons trying to grab you have a Monster Rating of 60. Each turn it will be 60 as there is effectively an infinite supply of them. If you fight a combat round you may add the hits you do on the skeletons to your Dexterity for the purpose of making the saving roll, but each combat round fought adds two to the level of the saving roll. The hits done on the skeletons are cumulative adds to your DEX. ]If you ever try the roll and miss it, the skeletons drag you down and kill you.\n" \
"  If you reach the bottle, you manage to hit it. Go to {295}."
},
{ // 288
"You easily find your way through the Dervi tunnels, though you have to stoop because the Dervi are small. The walls, you discover as you feel your way along, are filled with carvings similar to those you saw outside. You turn a final corner and find yourself at the entrance to the Dervi King's audience chamber.\n" \
"  The chamber is so tall the ceiling is shrouded in darkness. Hundreds of Dervi, their grey elven faces ugly in a sharp sort of way no elf you know could match, turn and look in your direction. You sense the presence of other Dervi at your back and you know you are trapped.\n" \
"  \"We are the King of all the Sham Jebel Dervi.\" The King's voice is grating and he whines. \"You have entered our realm unbidden and are most unwelcome. You must offer me tribute or we will exact payment in blood.\"\n" \
"  With his last statement a Dervi, far taller and heavier than the others, steps forward. He is obviously the King's Champion.\n" \
"  If you want to offer tribute, you can offer food at {299}, or money at {308}. If you'd rather fight the champion, go to {316}."
},
{ // 289
"\"Alas,\" says the Djinn, \"there is little I can give you. Still there was some wealth left over from all this.\" He floats toward the cavern ceiling and you see a small pile of gold and jewels.\n" \
"  There is 1d × 1000 gold pieces in that pile and 2 dice worth of gems to be rolled for on the treasure generator.[ If you come up with a magic gem the enchantment is one uniquely appropriate to the desert. If the gem is placed in a bottle or wineskin the vessel will always remain full with whatever liquid was last poured into it. (Flaming oil does not apply. The liquid will only leave the vessel if someone is drinking it.)]\n" \
"  You gather up your treasure and the Djinn flies you out into the desert where you locate the oasis and rejoin your caravan at {237}.\n" \
"  This was worth 300 EPs."
},
{ // 290
"The Champion fights unarmed and gets 4 dice for his sandy talons as well as 46 adds for earthy strength.[ In addition, in any round he gets hits on you, you have to make a saving throw on Luck on a level to the number of hits divided by 10, rounded up of course, or you will be blinded by a sand blast for the next round. Being blinded reduces your fighting ability to half what it normally is, the same as fighting in the dark.]\n" \
"  If you manage to kill this thing, go to {310}."
},
{ // 291
"You follow the trail and discover, to your uneasy horror, that the trail has been carved with steps and the steps are quite well worn. The sides of the trail rise up and conduct you into a cavern burrowed deep into the mountainside. Though the cavern is dark the purplish glow from the walls gives you enough light to see a scene from the very worst of your nightmares.\n" \
"  Surrounding you, lying on beds of gold and jewels and weaponry, are skeletons of men and women still clad in the clothing they wore when they died. You've seen these sorts of sights before, out in the desert, when wind driven sand and the scavengers of the sandsea have stripped flesh from the bones of those who died in the desert. It is an unpleasant scene, to say the least.\n" \
"  Yet more revolting is the creature sitting on a throne form of storm-scoured skulls. It was probably once human, though now its bloated corrupt form denies any humanity. In its right fist there is a half-eaten goat haunch, torn from a steaming, roasted goat lying on a gold platter. Surrounding him are the skeletal remains of what once must have been, judging by the clothing, a king's harem. The skeletons fawn over him in a parody of court life.\n" \
"  The rotund man rises. \"Yet another to join my cortege.\" He laughs, food spilling from his mouth. \"You will never leave.\" Make a second level IQ saving roll (25 - IQ). If you make it, go to {311}. If you miss, go to {300}."
},
{ // 292
"The statuette was made from stone of Sham Jebel and is evil. The mountain's spirit floods through you when you touch the stone and you are unable to resist it. It solidifies your body and dims your mind. The last of your memories, in fact, drains away the very next day when Sham Jebel, with you leading the attack, swallows the caravan in an avalanche.\n" \
"  This character is [not really ]dead[ yet. Keep the character card inside the front cover of this book. If another character ever changes this character back to flesh, you'll be told to take this character out and use it in the current situation. After that situation is resolved, this newly revived character will join the caravan and be part of it until the end of the journey, but he will not be the central figure in this run through the adventure]."
},
{ // 293
"The storm howls and batters you as if it wants to keep you trapped on Sham Jebel. You fight against the storm and the wind actually lets up! Before you can give thanks to any god, though, you learn why the storm abated. The sand drops from the air in front of you and you find yourself within a small arena formed within the storm itself.\n" \
"  Across from you, also herded to this place by the storm, is an 8' tall giant of a man in tattered black robes. He turns to face you and you gasp because his body is nothing but bleached bones polished to an ivory shine by the desert winds. In his hand he has a black shamsheer that glows with arcane sorcery.\n" \
"  The storm contracts the arena and forces you together. The creature you face is utterly evil and the magic sword will make him difficult to fight. [The magic is such that the monster will always get 1-6 (1 die) hits on you, despite armour or your winning the round. ]In addition to the 5 dice for his blade he has 20 combat adds and a CON of 60. You'll literally have to shatter every bone in his body to defeat him. If you kill the monster, go to {305}."
},
{ // 294
"You aim at one of the statues and it turns into flesh! It was once a man turned to stone, and now he looks a bit angry. He crosses to your side and rips your bonds apart. You snatch a haladie from a small table by the altar and turn to face the Spectral Viper!\n" \
"  [If you have any characters who have been turned to stone in the caravan, take one from inside the cover of the book and use him to help you in this combat. If you've not had anyone turned to stone, roll a die. 1-3=human, 4,5=elf, 6=dwarf. Roll up a warrior of this race and arm him with 100 gps worth of weapons and armour. His sword (give him a sword) is enchanted enough from your spell to hurt the Spectral Viper. ]Now go to {306}.\n" \
"  By the way, the Dervi did take your armour off, so you're without your customary protection. Who, after all, ever sent a sacrifice to their god with armour on?"
},
{ // 295
"The bottle cracks then explodes. Dense blue smoke, as blue as the Azure Ocean, billows out and forms itself into a furious Djinn. The skeletons fall in ivory heaps as the Djinn grabs its former master and crushes his throat in its mighty taloned blue hands. It casts the body aside and turns to you.\n" \
"  Its voice echoes and booms. \"I cannot express the depth of my gratitude to you for my freedom. I have been trapped longer than you or any of your line could ever have known and my heart has been sick with the evil my magic wrought upon the world.\" He waves his hands and indicates the scattered bodies. \"Though I am loathe to do it, I must follow my duty. Alas my magic had been sorely taxed so I can offer you only one wish, the fondest wish of your head or your heart.\"\n" \
"  If you wish with your head, go to {314}. If you wish with your heart, go to {303}."
},
{ // 296
"You know Scourge is a 5 dice sword[ that either halves armour or destroys it at 3 hits per point of armour protection. What you didn't realize is that Scourge exacts a price for its service. The sword drains 3 IQ points from its wielder per round its powers are used. This can drop a fighter unconscious if his IQ goes to 1, can kill him if it drops to 0 or below, or will most likely put him in a place where he'll go berserk. The IQ lost will recover at the same rate as Strength recovers for a wizard. (If a warrior goes berserk, the sword's power will activate to destroy armour if a pair of 6s is rolled on the dice, or it will halve armour if a pair of 1s are rolled. If neither of those number pairs comes up, the sword does not activate. And, yes, triples or quads or quints of 1s or 6s do count toward activating the blade.) Selling, trading or otherwise disposing of Scourge will drain the owner of 3 IQ points permanently].\n" \
"  This was worth 300 experience points. From the cave mouth you can see the oasis and the caravan. With the 1000 gps you loot from the treasure you go to {237}."
},
{ // 297
"Your chest tightens as you try to breathe in. Suddenly there is no air for you to breathe and you know you're trapped in a Dervi warding spell. You are in trouble up to your chin.\n" \
"  Make a first level Constitution saving roll (20 - CON). Take hits on your CON equal to what you missed the saving roll by. Then make a second level saving roll on Constitution (25 - CON), taking hits the same way as above. Lastly make a third level Constitution saving roll (30 - CON) and take hits equal to what you missed the roll by. At the end of this third turn the spell will release you. If your character survives, the character is taken, unconscious, to {304}."
},
{ // 298
"\"Alas,\" says the Djinn, \"there is little left from this effort that I can give to you. Still, there was one magical weapon left behind that you might like to have.\"\n" \
"  A beautifully worked Jambiya in a jewelled (roll for 1 jewel on the treasure generator) sheath floats to you. The blade is called Friend[ and will parry any one attack or attacker, magic attacks excepted. This means if you are fighting two people, only one will be able to attack you. Similarly an arrow shot from ambush will be picked off by Friend, though a second or third arrow will not. Where you face only one foe, the blade will take hits equal to its combat roll as armour, with no warriors getting the doubling bonus for that \"armour\"].\n" \
"  The Djinn flies you out into the desert where you locate the oasis and then rejoin your caravan. Go to {237}. This was worth 300 ap."
},
{ // 299
"Good choice. The King is stricken when you offer food because even the Dervi are bound by the unwritten law of the Desert: you shall not harm one who offers you food for at least a lunar month. This means your caravan will be able to pass unimpeded through the mountains.\n" \
"  The Dervi King accepts your gift and has you guided out of his demesne. At the ledge you have the oasis and the caravan pointed out to you. Pleased to have escaped with your life and 150 ap, you return to {237}."
},
{ // 300
"The man is obviously mad. You can't guess at how long this ghoul has lived in this mockery of normal life, but it offends you to your soul and beyond. You draw your weapon and step toward him. He gasps and drops the goat leg. He backs away from you and draws a sword. It is a scimitar and waves of magic wash over you. The blade shimmers and almost appears insubstantial. The sword's name is Scourge[ and it does its damage on the target or the target's armour. If attacking the armour, it does one point for every 3 points of damage done this round. In this fight roll one die. Odd means it attacks armour this round. Even, and it goes for you in this round. It does no damage if you win the combat round, and the sting of the blade feels and sounds like wind-whipped sand in the storm outside].\n" \
"  The man, despite his condition, still gets 40 adds in combat and has a CON of 25. He wears no armour. The Scourge gets 5 dice in combat. If you kill him, go to {309}."
},
{ // 301
"It suddenly dawns on you that this shambling mound of din and dust would probably resent your final \"gift\" from Ali before he sent you on this little outing. With the lusty swing of a barbarian hacking at a dragon, you hit the champion with your waterskin!\n" \
"  It bursts on impact and the King's Champion is stricken. His head melts and mud splatters the floor at your feet. His body wavers, then collapses in a pile of dust. All the Dervi scream in terror and flee, including the King. You laugh menacingly and hope they don't notice you have no more water.\n" \
"  You walk over to the throne and discover the King has left his sceptre behind. It has a solid gold shaft and four jewels (roll on the treasure generator - all the gems are large) on its head. It is a worthy treasure for what you have accomplished here because no Dervi will ever consider attacking a caravan carrying waterskins like yours. This was worth 300 ap. Go to {237}."
},
{ // 302
"You feel an evil presence enter your body from the statuette and try to take you over, but you fight it off and it flees. Still, the bare seconds of your battle have changed you. Your bones are now made of the same stone as Sham Jebel. This instantly triples your weight. Your hands are now worth 3 dice total in unarmed combat and your Strength is increased enough so you can \"lift\" your new weight. (If your Strength is already sufficient to move this increased weight, you get no benefit.)[ You will no longer float as you might have before but all broken bones will heal at one CON point per turn. This increased healing rate does not apply to your flesh or muscles.]\n" \
"  Dazed, you wander down Sham Jebel. You stumble into the oasis, then stagger off to the caravan. You recover your wits when you reach {237}."
},
{ // 303
"The Djinn picks your wish from your brain and smiles. \"A romantic at heart. I admire that.\" He waves his hands. \"Your wish is my command.\"\n" \
"  The sandstorm sweeping across the desert swirls into the cavern and buffets you. You shut your eyes against the stinging sand and feel magic wash over you. Then the wind dies and you open your eyes again. You are not alone.\n" \
"  Of your host there is no sign, but the skeletons have changed. Their clothing is now as it once was, and they are quite alive. You recognize people who could only be long-dead heroes and heroines of the tales told around countless campfires about lovers who fled an evil father or fought the desert to return to families some adventure had carried them away from. The wind again swirls and those people, and their personal wealth, is swept away with them back to their homes.\n" \
"  Though it is over fast, you smile. The Djinn notes this grin of satisfaction and returns the smile. Make a first level Luck saving roll (20 - LK). If you make it, go to {298}. If you miss it, go to {289}."
},
{ // 304
"You awaken bound to a black altar. The Dervi are all lined up in ranks upon ranks back as far as the room goes. Along the walls nearest you are a number of humanoid statues that are carved with even more detail than the Dervi seem to be able to put into their carvings. In the middle of the wall opposite the Dervi is an opening and from it, getting ever closer to you, is a black, shadowy serpent. It looks like a cobra, but is huge and obviously not \"real\" in the biological sense of the word. You know this is very bad magic and you don't like being the focus of it.\n" \
"  If this character has or can somehow cast a Pygmalion spell, go to {294}. If you don't have that sort of magical way out, you will have to break your bonds. Make a Strength saving roll on a level equal to ½ the roll of one die, rounding up. If you make it, go to {313}. If you don't, the Spectral Viper drains your life and uses it to nurture more of its children, the Dervi."
},
{ // 305
"The storm stops instantly! The skeleton reassembles itself and bows to you. Wind rasps through its ribs and you can hear the skeleton speaking to you! \"I once came hunting for my beloved Janis, the woman I loved, who fled from her father's house because she heard I was slain. She died on Sham Jebel and I've killed everything coming from that mountain to avenge her. Your victory proves to me the gods frown on my actions.\"\n" \
"  The skeleton bows and offers you its sword. \"This is Nik-el-Dim, my sword.\" [He explains, as you learned in the fight, that it always gets one die damage on any foe you face, regardless of armour. ]\"It is a noble blade[ and will not accept poison or another enchantment]. Take it, and thank you for ending my weary unlife.\"\n" \
"  From here, you can see the oasis and could easily lead the caravan back to it.\n" \
"  To return to the caravan, go to {237}."
},
{ // 306
"The Spectral Viper is a nasty creature. It has a CON of 300. [Because it is noncorporeal, only magical weapons will hurt it. ]The Viper is said to exist simultaneously in this world and another dimension. It gets 6 dice and 50 adds per combat round.[ You will always do your full damage to it, you and any ally you may have, and it will always do 1/10th of its damage (rounding down) on you. It will concentrate on the character who was the sacrifice if there is more than one in the fight. If you win the combat round, you get to add the amount you won by again to your total.]\n" \
"  You're not going to kill the Spectral Viper, because it is a god, but you can inflict enough damage to drive it from this plane for a while. If you succeed and it retreats, go to {312}."
},
{ // 307
"The Sham Jebel shows no sign of the wear you'd expect in such a harsh environment. You scramble up the rocks and note uncomfortably that the rock feels cold. You know there is evil magic in this mountain. The trail you're on twists like a scar up and around the mountain's face. It splits and continues up, or levels out onto a ledge. If you want to follow the trail up, go to {291}. If you want to reach the ledge, go to {315}."
},
{ // 308
"The Dervi King laughs derisively. \"What use have I for money? I reject your gift.\"\n" \
"  The assembled Dervi close on you. They crowd you and pummel you with weak blows. They are incredibly quick, as they would have to be to run across the sands and leave no tracks, but they are not very strong. You reach out and feel their grainy hides. You push them away.\n" \
"  Make a second level Strength saving roll (25 - ST). If you make it, the crowd is shoved away and you stand across a small opening from the King's Champion. You'll have to fight him at {290}. If you miss the saving roll, they beat you into unconsciousness. You awaken at {304} with half your CON gone."
},
{ // 309
"Your host slides to the ground as dead as the skeletons surrounding him. His sword stills itself and lies there. Where his robe fell open you see an onyx statuette tied around his neck by a leather thong.\n" \
"  If you take the sword, go to {296}. If you take the statuette, make a third level IQ saving roll (30 - IQ). If you make it, go to {302}. If you miss it, go to {292}. If you don't want to take anything but a handful of treasure, roll three dice. You get that roll times 1000 in gold pieces and for every 3 you rolled you get one jewel to be rolled on the jewel generator. None of the jewels are magical.\n" \
"  You walk to the cave mouth and see the storm has abated. You easily locate the oasis and travel back to the caravan, your mission accomplished. This was worth 300 ap. Go to {237}."
},
{ // 310
"The Champion collapses into an inert pile of earth. You dust yourself off and spit contemptuously at the King. You hardly expected the King to let you go after slaying his Champion, but you've shown him how tough you are.\n" \
"  The King screams. Your spittle hit him in the foot and melted a hole through it! He holds his hands up and pleads with you, \"Forgive us, mighty sorcerer, we did not recognize one of great power! Tell us what we must do to be forgiven.\"\n" \
"  You instantly press your advantage and get them to promise safe passage for your caravan. In addition, you demand tribute and they bring you a desert robe. You put it on and can feel the magic in it start working.\n" \
"  [The robe will save you from the rigours of desert travel. Heat up to 130°F (54°C) will seem like 70°F (21°C) to you. You'll still need to drink, but you won't feel hot. It will protect you from your level number in dice worth of damage from a Blasting Power spell, but a warrior may not double this protection. ]This is not, strictly speaking, armour. Temperatures above 130°F (54°C) feel like what they are.\n" \
"  The Dervi guide you back to the oasis and you find your way back to the caravan. Go to {237}."
},
{ // 311
"You instantly realize what is going on here. The madman obviously trapped a Djinn and forced it to give him Wealth, Power, and Eternal Life. Still, the Djinn managed to trap the man here in Sham Jebel. His court is made of those unwary enough to be trapped in the mountains, his wealth is stolen from caravans and his life is sustained in the cave by the goat which replenishes itself when he eats it. His wishes were turned into hellish mockeries of his true intent.\n" \
"  You look around the cavern and you see, back in a niche, a stoppered bottle. The madman catches your glance and shrieks in terror. He raises his hands and the skeletons rise with the gesture. \"Stop the interloper!\"\n" \
"  If you have a weapon you want to shoot or throw at the bottle, make a fourth level Dexterity saving roll (35 - DEX) to hit. If you make it, go to {295}. If you miss, you'll have to wade through the skeletons to reach the bottle and smash it. Similarly if you can't or don't want to throw something you'll have to reach the bottle by fighting through the skeletons. For that, go to {287}."
},
{ // 312
"The Dervi flee in terror. You have done what few ever come close to accomplishing.\n" \
"  The dagger is really a minor magic item, but you'll find its magic very powerful in the desert. [It will produce one gallon of pure water for each Strength point you funnel into it. The Strength is recovered at the same rate wizards recover their Strength. ]In addition to the dagger, you recover your other equipment and 2 dice times 1000 in gold pieces. For each 6 you rolled in those two dice you also get a large jewel to be rolled on the jewel generator in the rules.\n" \
"  You leave Sham Jebel and easily find the oasis. You go from there to the caravan at {237}. This was worth 500 ap."
},
{ // 313
"You snap the bonds binding you to the altar and snatch up a haladie from a table next to the altar. Because your escape surprises the Spectral Viper (it's not used to its meals moving, much less being armed), you'll get one round to do as much damage to it as you can without it fighting back. Do your worst because you know, when it gets the chance, it certainly will.\n" \
"  One more thing, designed to brighten your outlook on life: you have no armour. The Dervi removed it. After all, what god wants to shell its sacrifices before it eats them? Go to {306}."
},
{ // 314
"The Djinn picks your wish from your brain and smiles. \"A wise wish indeed. I am more than pleased to grant it.\"\n" \
"  He waves his hand and the cavern blurs into your sight. The skeletons are swallowed by the earth and the wealth whirls into a cloud in the room's centre. You feel the stone move beneath your feet and close your eyes against the dizzying storm of colour. When you open your eyes again the chamber has been transformed.\n" \
"  The cavern walls are smooth except for the polished black slabs with gold lettering on them. Each tells the tale of the person buried behind it. The ceiling is covered with gold and jewels, each stone placed exactly where stars and planets burn in the night sky. The cavern is no longer a desolate boneyard, but a shrine to those who were trapped by the Djinn's magic.\n" \
"  The Djinn sees the satisfied smile on your face and is pleased. Make a first level Luck saving roll (20 - LK). If you make it, go to {289}. If you miss, go to {298}."
},
{ // 315
"The ledge is flat and very smooth. Back away from it opens a black cave mouth rimmed with obscene and blasphemous carvings. You see all sorts of atrocities and high crimes carved with great care and, perversely, artistry. You make a sign to ward off evil and would flee this place, except that you hear voices behind you. You cross into the cave and hide within the shadows. You hold your breath as two small, sylvan creatures glide by you and go deeper into the cave. You shudder because they are Dervi!\n" \
"  You know Ali Cambrasna would love news of these creatures, for their foul rituals and magicks have caused much trouble for caravans before. You silently slide your weapon into your hand and pad after them. Make a second level Luck (25 - LK) or Dexterity (25 - DEX) saving throw, your choice. If you make the roll, go to {288}. If you miss it, go to {297}."
},
{ // 316
"This Dervi is big! His flesh is grainy and his eyes burn a hollow green. His ears are pointed, as are his teeth, and his arms end in three-fingered, taloned claws. His muscles don't ripple as much as shift like sand dunes and sand trickles from his open jaws like saliva from the mouth of a rabid dog. He moves toward you, sliding forward on powerful legs that polish the chamber's already glassy-smooth floor.\n" \
"  You'd really like to reconsider fighting this gravel brained creature, but none of the Dervi want to offer you this option. Make a third level IQ saving roll (30 - IQ). If you make it, go to {301}. If you miss it, pray to whatever war god appeals to you right now because combat is joined at {290}."
}
};

MODULE SWORD ca_exits[CA_ROOMS][EXITS] =
{ { 124,  98,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  35,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2
  { 188,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3
  {  35,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4
  { 197,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5
  { 124, 191,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7
  { 134, 131,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9
  { 124,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10
  { 124,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11
  { 105, 166,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12
  { 106,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15
  { 202,  75,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16
  { 166,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17
  { 235, 111,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18
  {  80,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19
  { 238, 145, 143,  -1,  -1,  -1,  -1,  -1 }, //  20
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21
  { 146,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22
  { 116, 237,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24
  {  85,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28
  {  91,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29
  { 122,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31
  { 218,  63,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33
  { 217, 158,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34
  { 255, 197,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35
  { 190,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36
  { 124,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37
  { 161,  71,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38
  { 192,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40
  { 124,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44
  { 199,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47
  { 140,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48
  { 205, 112, 206,  -1,  -1,  -1,  -1,  -1 }, //  49
  { 235, 236,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50
  { 144, 240,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58
  { 151, 244,  90,  -1,  -1,  -1,  -1,  -1 }, //  59
  {  91,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60
  { 184, 247,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61
  { 124,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62
  { 125,  35,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65
  { 189, 220,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66
  {  35,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67
  {   5,  35,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68
  { 223, 130,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69
  {  31,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70
  { 195,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71
  { 124,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72
  { 223,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75
  { 168,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77
  { 166, 171,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78
  { 170, 201,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79
  { 173,  49,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90
  { 153,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93
  { 125,  35,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94
  { 157,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95
  { 250,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97
  { 160,   6,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99
  { 162, 135,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100
  { 124,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101
  {   9,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104
  {  43, 138,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105
  { 167, 169,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107
  { 232,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108
  { 138,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109
  { 166,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110
  {  19, 236,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113
  { 176,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114
  {  23,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116
  { 180,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117
  {  88,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118
  { 181,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121
  { 253,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123
  { 155,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125
  {  35,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127
  {  36,  35,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134
  { 161,  71,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135
  { 166,  78, 171,  -1,  -1,  -1,  -1,  -1 }, // 136
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137
  {  45,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139
  {  75,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141
  {  49,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142
  { 237,  52, 239,  -1,  -1,  -1,  -1,  -1 }, // 143
  {  21,  82, 207,  -1,  -1,  -1,  -1,  -1 }, // 144
  { 238,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145
  {  53, 237,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151
  { 246,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153
  { 122,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155
  {  35,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157
  { 189, 219,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158
  {  35,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159
  { 223,  69,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162
  { 101,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164
  { 124,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165
  { 229,  14,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166
  {  44,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167
  { 231,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170
  { 109, 234,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172
  {  49,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 173
  {  49,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 174
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 175
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 177
  { 179,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 178
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 179
  {  26,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 180
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 182
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 183
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 184
  { 216,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 185
  { 217,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 186
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 187
  {  35,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 188
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 189
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 190
  {   7,  99,  -1,  -1,  -1,  -1,  -1,  -1 }, // 191
  { 124,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 192
  {  70, 132,  -1,  -1,  -1,  -1,  -1,  -1 }, // 193
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 194
  {  10, 164,  -1,  -1,  -1,  -1,  -1,  -1 }, // 195
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 196
  {  12,  74,  -1,  -1,  -1,  -1,  -1,  -1 }, // 197
  {  75,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 198
  {  76,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, // 199
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 200
  {  75,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 201
  {  47, 201,  -1,  -1,  -1,  -1,  -1,  -1 }, // 202
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 203
  { 111,  50,  -1,  -1,  -1,  -1,  -1,  -1 }, // 204
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 205
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 206
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 207
  { 237, 239,  -1,  -1,  -1,  -1,  -1,  -1 }, // 208
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 209
  {  85,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 210
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 211
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 212
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 213
  { 152, 121,  -1,  -1,  -1,  -1,  -1,  -1 }, // 214
  { 154,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 215
  { 122,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 216
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 217
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 218
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 219
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 220
  {  35,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 221
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 222
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 223
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 224
  {  39, 192,  -1,  -1,  -1,  -1,  -1,  -1 }, // 225
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 226
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 227
  { 216,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 228
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 229
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 230
  { 107, 201,  -1,  -1,  -1,  -1,  -1,  -1 }, // 231
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 232
  {  79,  75,  -1,  -1,  -1,  -1,  -1,  -1 }, // 233
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 234
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 235
  {  80,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 236
  {  59,  61,  -1,  -1,  -1,  -1,  -1,  -1 }, // 237
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 238
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 239
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 240
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 241
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 242
  { 181,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 243
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 244
  {  91,  60,  -1,  -1,  -1,  -1,  -1,  -1 }, // 245
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 246
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 247
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 248
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 249
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 250
  { 154,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 251
  { 151,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 252
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 253
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 254
  { 271, 141,  -1,  -1,  -1,  -1,  -1,  -1 }, // 255
  { 269,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 256
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 257
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 258
  { 280, 268,  -1,  -1,  -1,  -1,  -1,  -1 }, // 259
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 260
  { 267, 281,  -1,  -1,  -1,  -1,  -1,  -1 }, // 261
  { 266,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 262
  { 276, 270,  -1,  -1,  -1,  -1,  -1,  -1 }, // 263
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 264
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 265
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 266
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 267
  { 274, 260,  -1,  -1,  -1,  -1,  -1,  -1 }, // 268
  { 266, 257,  -1,  -1,  -1,  -1,  -1,  -1 }, // 269
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 270
  { 264, 283,  -1,  -1,  -1,  -1,  -1,  -1 }, // 271
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 272
  { 282, 266,  -1,  -1,  -1,  -1,  -1,  -1 }, // 273
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 274
  { 266, 257,  -1,  -1,  -1,  -1,  -1,  -1 }, // 275
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 276
  { 259,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 277
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 278
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 279
  { 263, 279,  -1,  -1,  -1,  -1,  -1,  -1 }, // 280
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 281
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 282
  { 256, 284,  -1,  -1,  -1,  -1,  -1,  -1 }, // 283
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 284
  { 259,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 285
  { 307, 293,  -1,  -1,  -1,  -1,  -1,  -1 }, // 286
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 287
  { 299, 308, 316,  -1,  -1,  -1,  -1,  -1 }, // 288
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 289
  { 310,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 290
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 291
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 292
  { 305,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 293
  { 306,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 294
  { 314, 303,  -1,  -1,  -1,  -1,  -1,  -1 }, // 295
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 296
  { 304,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 297
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 298
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 299
  { 309,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 300
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 301
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 302
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 303
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 304
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 305
  { 312,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 306
  { 291, 315,  -1,  -1,  -1,  -1,  -1,  -1 }, // 307
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 308
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 309
  { 237,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 310
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 311
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 312
  { 306,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 313
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 314
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 315
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  // 316
};

MODULE STRPTR ca_pix[CA_ROOMS] =
{ "", //   0
  "",
  "",
  "",
  "",
  "", //   5
  "",
  "",
  "",
  "ca9",
  "", //  10
  "",
  "",
  "",
  "",
  "", //  15
  "",
  "",
  "",
  "",
  "ca20", //  20
  "ca21",
  "",
  "",
  "",
  "ca25", //  25
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
  "ca39",
  "ca40", //  40
  "",
  "",
  "",
  "ca44",
  "", //  45
  "",
  "",
  "",
  "",
  "", //  50
  "",
  "",
  "",
  "",
  "", //  55
  "ca56",
  "",
  "",
  "",
  "", //  60
  "",
  "",
  "",
  "",
  "", //  65
  "ca66",
  "",
  "",
  "",
  "", //  70
  "",
  "",
  "",
  "",
  "", //  75
  "",
  "",
  "",
  "",
  "", //  80
  "",
  "",
  "ca83",
  "ca84",
  "", //  85
  "",
  "",
  "",
  "",
  "", //  90
  "",
  "",
  "",
  "ca94",
  "", //  95
  "",
  "",
  "ca98",
  "",
  "", // 100
  "",
  "",
  "",
  "",
  "", // 105
  "",
  "",
  "",
  "",
  "", // 110
  "",
  "",
  "",
  "",
  "", // 115
  "ca116",
  "",
  "",
  "",
  "", // 120
  "",
  "",
  "",
  "ca124",
  "", // 125
  "",
  "",
  "",
  "",
  "", // 130
  "",
  "",
  "ca133",
  "",
  "", // 135
  "",
  "ca137",
  "",
  "",
  "", // 140
  "",
  "",
  "",
  "",
  "", // 145
  "",
  "ca147",
  "",
  "",
  "", // 150
  "",
  "ca152",
  "",
  "ca154",
  "", // 155
  "",
  "",
  "",
  "",
  "", // 160
  "",
  "",
  "",
  "",
  "", // 165
  "ca166",
  "",
  "",
  "ca169",
  "", // 170
  "",
  "",
  "",
  "",
  "ca175", // 175
  "",
  "",
  "",
  "",
  "", // 180
  "",
  "",
  "",
  "",
  "", // 185
  "",
  "",
  "",
  "",
  "", // 190
  "",
  "",
  "ca192",
  "",
  "", // 195
  "",
  "",
  "ca198",
  "",
  "", // 200
  "ca201",
  "",
  "",
  "",
  "", // 205
  "",
  "ca207",
  "",
  "",
  "", // 210
  "",
  "",
  "ca213",
  "",
  "", // 215
  "",
  "",
  "",
  "",
  "", // 220
  "",
  "",
  "ca223",
  "",
  "", // 225
  "",
  "",
  "",
  "",
  "ca230", // 230
  "",
  "",
  "",
  "",
  "", // 235
  "",
  "",
  "",
  "",
  "ca240", // 240
  "",
  "",
  "",
  "",
  "ca245", // 245
  "",
  "",
  "",
  "",
  "ca250", // 250
  "",
  "",
  "",
  "ca254",
  "", // 255
  "ca256",
  "ca257",
  "",
  "",
  "", // 260
  "",
  "",
  "",
  "",
  "", // 265
  "",
  "",
  "ca268",
  "",
  "", // 270
  "",
  "",
  "",
  "",
  "", // 275
  "",
  "",
  "",
  "",
  "ca280", // 280
  "",
  "",
  "",
  "ca284",
  "", // 285
  "",
  "ca287",
  "",
  "",
  "", // 290
  "",
  "",
  "ca293",
  "",
  "", // 295
  "",
  "",
  "ca298",
  "",
  "", // 300
  "ca301",
  "",
  "",
  "ca304",
  "", // 305
  "ca306",
  "",
  "",
  "",
  "", // 310
  "ca311",
  "",
  "",
  "",
  "ca315", // 315
  ""  // 316
};

IMPORT FLAG                   usedweapons;
IMPORT int                    armour,
                              bankcp,
                              been[MOST_ROOMS + 1],
                              evil_damagetaken,
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              good_attacktotal,
                              good_damagetaken,
                              good_shocktotal,
                              gp, sp, cp, rt, lt, both,
                              height, weight, sex, race, class, size,
                              missileammo,
                              room, prevroom, module,
                              round,
                              spellchosen,
                              spelllevel,
                              spellpower;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR          *descs[MODULES],
                             *treasures[MODULES],
                             *wanders[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct RacesStruct     races[RACES];
IMPORT struct SpellStruct     spell[SPELLS];

IMPORT void (* enterroom) (void);

MODULE void ca_enterroom(void);

EXPORT void ca_preinit(void)
{   descs[MODULE_CA] = ca_desc;
}

EXPORT void ca_init(void)
{   int i;

    exits      = &ca_exits[0][0];
    enterroom  = ca_enterroom;
    for (i = 0; i < CA_ROOMS; i++)
    {   pix[i] = ca_pix[i];
}   }

MODULE void ca_enterroom(void)
{   TRANSIENT FLAG ok;
    TRANSIENT int  i,
                   result,
                   result1,
                   result2;
    PERSIST   int  oldstat;

    switch (room)
    {
    case 0:
        give(804);
    acase 1:
        give_gp(10);
        award(45);
    acase 2:
        create_monsters(450, 2);
        create_monster(451);
        do
        {   oneround();
            if (!npc[0].con && !npc[1].con && npc[2].con < 20)
            {   room = 156;
        }   }
        while (room == 2);
    acase 3:
        oldstat = dice(1);
        create_monsters(452, oldstat);
        while (room == 3 && countfoes())
        {   if (con <= 2 || getyn("Surrender (otherwise fight)"))
            {   dispose_npcs();
                room = 127;
            } else
            {   oneround();
        }   }
    acase 4:
        give(646);
    acase 5:
        gain_st(1);
    acase 7:
        die();
    acase 9:
        borrow_weaponsandarmour();
        give(777);
        rt = 777;
        create_monster(453);
        fight();
        if (con >= 1)
        {   room = 193;
        } else
        {   room = 104;
        }
    acase 10:
        give(647);
        give_gp(100);
        return_all();
    acase 11:
        return_all();
        give(648);
        if (class != WARRIOR)
        {   award(200);
        }
        if (getyn("Leave adventure"))
        {   victory(250);
        } else
        {   award(150);
        }
    acase 13:
        create_monster(454);
        good_freeattack();
        fight();
    acase 14:
        savedrooms(1, lk, 198, 138);
    acase 15:
        if (getyn("Leave adventure"))
        {   give(649);
            victory(350);
        } else
        {   give(650);
        }
    acase 16:
        give(651);
    acase 17:
        create_monster(455);
        evil_freeattack();
        fight();
    acase 19:
        create_monster(449);
        fight();
    acase 21:
        give(652);
        gain_chr(1);
    acase 22:
        create_monster(456);
        fight();
    acase 23:
        give_gp(100);
    acase 24:
        savedrooms(1, st, 147, 85);
    acase 26:
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].type == ARMOUR && items[i].borrowed)
            {   items[i].borrowed = 0;
        }   }
        return_all();
        give(663);
        give(654);
        award(150);
    acase 27:
        if (saved(1, st))
        {   if (been[118] && been[243] && been[212])
            {   room = 149;
            } else
            {   room = 57;
        }   }
        else
        {   room = 85;
        }
    acase 28:
        give(655);
    acase 29:
        templose_con(dice(1));
    acase 30:
        give_gp(1000);
        give_multi(656, 10);
    acase 31:
        elapse(ONE_DAY * 7, TRUE);
        savedrooms(1, lk, 62, 93);
    acase 33:
        if (!saved(2, lk))
        {   good_takehits(misseditby(2, lk), TRUE);
            room = 95;
        } else
        {   room = 157;
        }
        dispose_npcs();
    acase 36:
        if (!saved(1, lk))
        {   good_takehits(misseditby(1, lk), TRUE); // %%: does armour help?
        }
    acase 37:
        award(50);
        if (getyn("Leave adventure"))
        {   victory(100);
        }
    acase 38:
        borrow_weaponsandarmour();
    acase 39:
        give(657);
    acase 40:
        die();
    acase 41:
        return_all();
        award(150);
        lose_chr(5);
        if (getyn("Leave adventure"))
        {   victory(0);
        }
    acase 42:
        die();
    acase 43:
        savedrooms(1, dex, 136, 108);
    acase 44:
        give(214);
        give(651);
        give(658);
        savedrooms(1, lk, 198, 139);
    acase 45:
        create_monsters(457, 2);
        do
        {   oneround();
        } while (countfoes() == 2);
    acase 46:
        die();
    acase 47:
        give(ITEM_SO_HORSE);
        if (getyn("Leave adventure"))
        {   victory(350);
        } elif (getyn("Steal jewels"))
        {   give(659);
        }
    acase 48:
        create_monster(454);
        fight();
    acase 52:
        if (saved(2, chr) && saved(1, lk))
        {   room = 114;
        } else
        {   room = 208;
        }
    acase 53:
        give(660);
        give(661);
        give(662);
    acase 54:
        savedrooms(2, chr, 150, 209);
    acase 55:
        savedrooms(1, lk, 178, 210);
    acase 56:
        borrow_weaponsandarmour();
        give(663);
        armour = 663;
        if (saved(1, dex))
        {   if (saved(1, lk))
            {   room = 180;
            } else
            {   oldstat = misseditby(1, lk);
                room = 117;
        }   }
        else
        {   oldstat = misseditby(1, dex);
            if (!saved(1, lk))
            {   oldstat += misseditby(1, lk);
            }
            room = 117;
        }
    acase 57:
        if (!been[118] && getyn("Save child"))
        {   room = 118;
        } elif (!been[243] && getyn("Save woman"))
        {   room = 243;
        } else
        {   // assert(!been[212]);
            room = 212;
        }
    acase 58:
        gain_chr(2);
    acase 59:
        borrow_weaponsandarmour(); // is it possible to regain these? Otherwise dropitems() them.
    acase 60:
        templose_con(dice(2));
    acase 63:
        if (saved(2, lk))
        {   room = 94;
        }
    acase 64:
        if (prevroom == 249)
        {   fight();
            room = 188;
        } else
        {   oldstat = 2;
            create_monsters(450, 2);
            if (castspell(-1, FALSE))
            {   room = 249;
            } else
            {   fight();
                room = 188;
        }   }
    acase 65:
        savedrooms(1, lk, 35, 2);
    acase 67:
        give(SAX);
        give_gp(500);
    acase 68:
        give(664);
        give_gp(500);
    acase 70:
        return_all();
    acase 71:
        if (getyn("Influence Fereon"))
        {   savedrooms(2, chr, 226, 133);
        }
    acase 72:
        if (class != WARRIOR)
        {   for (i = 0; i < SPELLS; i++)
            {   if (!spell[i].known && spell[i].level <= level)
                {   listspell(i, TRUE);
            }   }
            result2 = 0;
            do
            {   result1 = getnumber("Learn which spell (0 for none)", 0, SPELLS) - 1;
                if (result1 == -1)
                {   result2 = 4;
                } elif (spell[result1].known)
                {   aprintf("You already know %s!\n", spell[result1].corginame);
                } elif (spell[result1].level > level)
                {   aprintf("Only 1st-%dth level spells!\n", level);
                } else
                {   learnspell(result1);
                    result2++;
            }   }
            while (result2 < 4);
        }
        award(150);
        give(665);
        if (getyn("Leave adventure"))
        {   victory(0);
        }
    acase 73:
        if (!immune_poison() && !saved(2, con))
        {   die();
        }
    acase 74:
        if (saved(2, dex))
        {   drop_all();
            if (dice(1) % 2 == 0)
            {   module = MODULE_AK;
                room = 0;
            } else
            {   module = MODULE_CT;
                room = 106;
        }   }
        else
        {   die();
        }
    acase 75:
        savedrooms(1, lk, 230, 137);
    acase 77:
        die();
    acase 81:
        savedrooms(2, chr, 143, 175);
    acase 82:
        // %%: we could give them the silver box; how much is it worth?
        give(667);
        gain_chr(1);
    acase 83:
        give(668);
    acase 84:
        savedrooms(2, lk, 238, -1);
    acase 85:
        die();
    acase 86:
        savedrooms(1, chr, 211, 148);
    acase 87:
        die();
    acase 88:
        give(669);
        if (been[118] && been[243] && been[212])
        {   room = 149;
        } else
        {   room = 57;
        }
    acase 89:
        return_all();
    acase 90:
        savedrooms(1, chr, 214, 151);
    acase 91:
        return_all();
        if (saved(1, dex) && armour == -1)
        {   weararmour(-1);
        }
        create_monster(458);
        fight();
    acase 92:
    case 93:
        die();
    acase 94:
        give(670);
        bankcp += 100000; // %%: do you get this even if going to CA125?
    acase 96:
        // she is created at paragraph #218
        fight();
    acase 97:
        dispose_npcs();
        if (pay_gp(1000))
        {   room = 35;
        } elif (saved(2, chr))
        {   room = 159;
        } else
        {   module = MODULE_AK;
            room = 0;
        }
    acase 99:
        give_gp(10);
        give(671);
        savedrooms(2, lk, 37, 222);
    acase 101:
        award(250);
        if (getyn("Leave adventure"))
        {   victory(0);
        }
    acase 103:
        savedrooms(2, chr, 165, 254);
    acase 104:
        die();
    acase 107:
        if (sex == MALE)
        {   room = 15;
        } else
        {   room = 200;
        }
    acase 108:
        create_monster(460);
        fight();
    acase 110:
        create_monster(455);
        fight();
        if (con <= 0)
        {   room = 172;
        }
    acase 112:
        borrow_weaponsandarmour();
        savedrooms(1, lk, 20, 54);
    acase 113:
        give_multi(672, 10);
        award(250);
    acase 114:
        if (saved(1, chr))
        {   give(632);
            gain_chr(2);
            gain_lk(2);
        } else
        {   gain_chr(3);
        }
    acase 115:
        create_monster(456);
        fight();
    acase 116:
        gain_st(3);
    acase 117:
        templose_con(oldstat);
        if (con <= 0)
        {   room = 87;
        }
    acase 118:
        if (!saved(1, dex))
        {   templose_con(misseditby(1, dex));
        }
        create_monsters(461, 2);
    acase 119:
        for (i = 0; i < MAX_MONSTERS; i++)
        {   if (npc[i].con || npc[i].mr)
            {   npc[i].con = npc[i].mr = 0;
                break;
        }   }
        fight();
    acase 120:
        if (saved(2, st))
        {   if (been[118] && been[243] && been[212])
            {   room = 149;
            } else
            {   room = 57;
        }   }
        else
        {   room = 85;
        }
    acase 121:
        savedrooms(1, lk, 245, 29);
    acase 123:
        create_monster(462);
        fight();
        savedrooms(2, lk, 215, 251);
    acase 124:
        elapse(ONE_DAY * 7, TRUE);
    acase 125:
        savedrooms(1, lk, 187, -1);
    acase 127:
        if (pay_gp(1000))
        {   room = 35;
        } else
        {   drop_all();
            module = MODULE_AK;
            room = 0;
        }
    acase 128:
        give(674);
        give(675);
    acase 129:
        both = rt = lt = EMPTY;
        create_monster(463);
        do
        {   oneround();
            if (!countfoes() || npc[0].con <= 2)
            {   dispose_npcs();
                room = 68;
            } elif (con <= 2)
            {   dispose_npcs();
                room = 221;
        }   }
        while (room == 129);
    acase 130:
        if (saved(2, lk))
        {   return_all();
            room = 6;
        } else
        {   room = 224;
        }
    acase 131:
        savedrooms(2, dex, 225, 73);
    acase 132:
        savedrooms(2, lk, 194, 40);
    acase 133:
        die();
    acase 134:
        savedrooms(1, lk, 11, 196);
    acase 135:
        borrow_weaponsandarmour();
    acase 137:
        if (!saved(2, con))
        {   templose_con(misseditby(2, con));
        }
    acase 139:
        die();
    acase 140:
        award(45);
    acase 141:
        give_gp(200);
        if (getyn("Continue"))
        {   savedrooms(1, lk, 203, 286);
        }
    acase 147:
        savedrooms(1, iq, 55, 241);
    acase 148:
        change_chr(2);
    acase 149:
        award(200);
    acase 150:
        dicerooms(213, 213, 89, 89, 182, 182);
    acase 151:
        savedrooms(1, lk, 245, 29);
    acase 152:
        give(BRO);
        give(PON);
    acase 153:
        savedrooms(2, lk, 246, 228);
    acase 154:
        give_gp(2000);
        give_multi(537, 10);
        give(676);
    acase 155:
        if (sex == MALE) room = 186; else room = 34;
    acase 156:
        dispose_npcs();
        give_gp(500);
        give(FAL);
    acase 157:
        savedrooms(1, lk, 35, 64);
    acase 158:
        elapse(60, TRUE);
    acase 161:
        savedrooms(1, lk, 8, 103);
    acase 162:
        savedrooms(1, chr, 9, 42);
    acase 163:
        if (saved(2, con))
        {   templose_con(dice(1));
        } else
        {   templose_con(dice(3));
        }
    acase 164:
        savedrooms(2, dex, 41, 227);
    acase 165:
        return_all();
        while (!saved(1, lk))
        {   lose_iq(1);
        }
        if (getyn("Leave adventure"))
        {   victory(250);
        } else
        {   award(150);
            give_gp(200);
        }
    acase 167:
        create_monster(464);
        fight();
    acase 168:
        return_all();
        create_monster(465);
        fight();
        if (con <= 0)
        {   room = 77;
        }
    acase 169:
        if (sex == MALE)
        {   room = 233;
        } else
        {   room = 16;
        }
    acase 170:
        give(ITEM_SO_HORSE);
        give(666);
        give_gp(1000);
        if (getyn("Leave adventure"))
        {   victory(350);
        }
    acase 172:
        die();
    acase 173:
        result = dice(1);
        if (result == 3 || result == 4)
        {   give(539);
        } elif (result >= 5)
        {   give(246);
        }
    acase 174:
        result = dice(1);
        for (i = 1; i <= result; i++)
        {   elapse(ONE_DAY, TRUE);
            if (!saved(1, con))
            {   templose_con(misseditby(1, con));
        }   }
    acase 175:
        if (saved(2, con))
        {   templose_con(1);
        } else
        {   die();
        }
    acase 177:
        die();
    acase 178:
        give_gp(100);
        give(314);
    acase 179:
        savedrooms(1, con, 242, 85);
    acase 180:
        give(464);
        create_monster(466);
        fight();
    acase 181:
        gain_st(2);
        if (been[118] && been[243] && been[212])
        {   room = 149;
        } else
        {   room = 57;
        }
    acase 182:
        savedrooms(1, dex, 28, 237);
    acase 183:
        if (immune_poison())
        {   savedrooms(1, lk, 245, 29);
        } else
        {   die();
        }
    acase 184:
        return_all();
        savedrooms(1, dex, 123, 92);
    acase 185:
        good_freeattack();
        fight();
    acase 186:
        if (getyn("Meet her"))
        {   elapse(60, TRUE);
            room = 32;
        }
    acase 187:
        ok = FALSE;
        for (i = 0; i < ITEMS; i++)
        {   if
            (   items[i].owned
             && (items[i].type == WEAPON_SWORD || items[i].type == WEAPON_DAGGER || items[i].type == WEAPON_HAFTED || items[i].type == WEAPON_POLE)
            )
            {   ok = TRUE;
                break; // for speed
        }   }
        if (ok && getyn("Cut tent"))
        {   room = 65;
        }
    acase 188:
        give_gp(30 * oldstat);
    acase 189:
        savedrooms(2, lk, 128, 36);
    acase 190:
        savedrooms(2, iq, 67, 129);
    acase 192:
        gain_con(6);
        return_all();
        if (getyn("Leave adventure"))
        {   victory(150);
        }
    acase 194:
        savedrooms(1, lk, 101, 163);
    acase 195:
        if (sex == FEMALE && getyn("Marry him"))
        {   room = 72;
        }
    acase 196:
        die();
    acase 199:
        dispose_npcs();
    acase 200:
        if (getyn("Leave adventure"))
        {   give(774);
            victory(350);
        } else
        {   give(775);
        }
    acase 203:
        savedrooms(2, lk, 18, 111);
    acase 205:
        gain_st(2);
        gain_con(2);
        savedrooms(2, lk, 51, 81);
    acase 206:
        elapse(120, TRUE);
        savedrooms(1, iq, 22, 115);
    acase 207:
        give(767);
        give(768);
        gain_chr(1);
    acase 209:
        dicerooms(24, 24, 56, 56, 57, 57);
    acase 211:
        give(769);
        gain_st(2);
        gain_iq(2);
        gain_lk(2);
        gain_con(2);
        gain_dex(2);
        gain_chr(2);
        gain_spd(2);
    acase 212:
        if (items[669].owned)
        {   if (been[118] && been[243])
            {   room = 149;
            } else
            {   room = 57;
        }   }
        elif (gotrope(1)) // %%: how long of a rope is needed? 40'?
        {   room = 27;
        } else
        {   room = 120;
        }
    acase 213:
        if (saved(1, iq))
        {   room = 58;
        } else
        {   lose_iq(3);
            room = 237;
        }
    acase 215:
        create_monster(469);
        npc[0].mr = 100;
        if (items[660].owned)
        {   good_freeattack();
        }
        fight();
    acase 216:
        give_gp(200);
        give_multi(466, 5);
    acase 217:
        if (saved(1, lk))
        {   create_monster(467);
            fight();
            room = 1;
        } else
        {   room = 248;
        }
    acase 218:
        create_monster(459);
        if (castspell(-1, FALSE))
        {   room = 33;
        } else
        {   room = 96;
        }
    acase 219:
        savedrooms(1, iq, 4, 66);
    acase 220:
        create_monster(451);
        oneround();
        if (evil_damagetaken >= 1)
        {   room = 156;
        } else
        {   oldstat = dice(1);
            create_monsters(450, oldstat); // %%: how many personal adds do these have?
            do
            {   if (con <= 2 || getyn("Surrender"))
                {   room = 97;
                } else
                {   oneround();
                    if (countfoes() == 1 && npc[0].con >= 1 && npc[0].con < 20)
                    {   room = 156;
            }   }   }
            while (room == 220);
        }
    acase 221:
        dispose_npcs();
        return_all();
    acase 222:
        if (immune_poison())
        {   savedrooms(1, con, 31, -1);
        } else
        {   elapse(ONE_DAY * 2, FALSE);
            die();
        }
    acase 223:
        create_monsters(475, 7);
        do
        {   oneround();
            if (!countfoes())
            {   room = 100;
            } elif (good_damagetaken >= 1)
            {   dispose_npcs();
                room = 38;
        }   }
        while (room == 223);
    acase 224:
        die();
    acase 226:
        if (getyn("Accept offer"))
        {   award(150);
            return_all();
            room = 124;
        } else
        {   room = 102;
        }
    acase 227:
        die();
    acase 228:
        create_monsters(473, 3);
        if (items[660].owned)
        {   room = 185;
        } else
        {   fight();
        }
    acase 229:
        savedrooms(1, spd, 13, 48);
    acase 231:
        give(637);
    acase 232:
        give_gp(50);
        savedrooms(2, lk, 198, 138);
    acase 234:
        savedrooms(1, lk, 110, 17);
    acase 235:
        elapse(29, TRUE);
        savedrooms(1, lk, 142, 174);
    acase 236:
        if (!saved(1, dex))
        {   good_takehits(dice(2), TRUE);
        }
        create_monster(449);
        fight();
    acase 237:
        give_gp(200);
    acase 238:
        create_monster(468);
        return_all();
        if (saved(1, dex))
        {   weararmour(-1);
        }
        do
        {   oneround();
            if (!countfoes())
            {   room = 113;
            } elif (con <= 2)
            {   dispose_npcs();
                room = 177;
        }   }
        while (room == 238);
    acase 239:
        if (getyn("Agree"))
        {   room = 83;
        } else
        {   room = prevroom;
        }
    acase 240:
        die();
    acase 241:
        die();
    acase 242:
        savedrooms(1, dex, 86, 25);
    acase 243:
        create_monsters(477, 3);
        oneround();
        if (countfoes())
        {   if (saved(1, lk))
            {   room = 119;
            } else
            {   fight();
        }   }
    acase 244:
        savedrooms(2, lk, 252, 183);
    acase 246:
        healall_con();
        if (!ability[15].known && !ability[95].known && getyn("Read to her"))
        {   room = 30;
        } else
        {   room = 122;
        }
    acase 247:
        die();
    acase 248:
        templose_con(dice(1));
        create_monster(467);
        fight();
    acase 249:
        if (spellchosen == SPELL_TF)
        {   payload(FALSE);
            room = 64;
        } elif (spellchosen == SPELL_CC)
        {   room = 126;
        } else
        {   room = 64;
        }
    acase 250:
        give_gp(150);
        give(770);
        savedrooms(1, lk, 35, 3);
    acase 251:
        create_monster(469);
        fight();
    acase 253:
        elapse(ONE_DAY * 3, TRUE);
        victory(5000);
    acase 254:
        die();
    acase 256:
        create_monster(470);
        fight();
        if (con <= 0)
        {   room = 278;
        } else
        {   give(GRE);
        }
    acase 257:
        elapse(120, TRUE);
        savedrooms(3, lk, 141, -1);
    acase 258:
        savedrooms(2, lk, 266, -1);
    acase 260:
        gain_st(1);
        gain_iq(1);
        gain_lk(1);
        gain_con(1);
        gain_dex(1);
        gain_chr(1);
        gain_spd(1);
    acase 261:
        lose_lk(3);
    acase 262:
        templose_con(dice(2));
        award(50);
    acase 263:
        gain_st(1);
        gain_iq(1);
        gain_lk(1);
        gain_con(1);
        gain_dex(1);
        gain_chr(1);
        gain_spd(1);
        give(771);
    acase 264:
        savedrooms(2, lk, 285, 277);
    acase 265:
        gain_lk(100);
        award(100);
    acase 267:
        elapse(5, TRUE);
    acase 269:
        award(100);
    acase 270:
        if (throwcoin())
        {   room = 265;
        } else
        {   room = 272;
        }
    acase 272:
        if (!saved(3, lk))
        {   elapse(300 * ONE_YEAR, TRUE);
        }
    acase 273:
        gain_con(5);
    acase 274:
        if (saved(3, lk) && saved(3, lk))
        {   room = 261;
        } else
        {   room = 281;
        }
    acase 275:
        award(100);
    acase 276:
        award(100);
    acase 277:
        pay_gp(gp / 2);
    acase 278:
        die();
    acase 281:
        die();
    acase 282:
        savedrooms(3, con, 275, 262);
    acase 284:
        // %%: "Perina is asking you for 4 gold pieces" but it doesn't say we have to pay it.
        savedrooms(2, con, 273, 258);
    acase 287:
        savedrooms(6, dex, 295, -1);
    acase 289:
        give(dice(1) * 1000);
        rb_givejewels(-1, -1, 1, dice(2));
        // %%: "If you come up with a magic gem...": how is this even possible? Maybe in 4th edition rules?
        award(300);
    acase 290:
        // %%: what is his CON? We have chosen 20.
        create_monster(476);
        fight();
    acase 291:
        savedrooms(2, iq, 311, 300);
    acase 292:
        die();
    acase 293:
        create_monster(474);
    acase 294:
        give(780);
    acase 296:
        award(300);
        give_gp(1000);
    acase 297:
        if (!saved(1, con))
        {   templose_con(misseditby(1, con));
        }
        if (!saved(2, con))
        {   templose_con(misseditby(2, con));
        }
        if (!saved(3, con))
        {   templose_con(misseditby(3, con));
        }
        // %%: "At the end of this third turn": does this mean 30 minutes elapse?
    acase 298:
        give(779);
        rb_givejewel(-1, -1, 1);
        award(300);
    acase 299:
        award(150);
    acase 300:
        create_monster(471);
        fight();
    acase 301:
        give(773);
        award(300);
    acase 302:
        gain_flag_ability(123);
    acase 303:
        savedrooms(1, lk, 298, 289);
    acase 304:
        borrow_weaponsandarmour();
        if (cast(SPELL_PY, FALSE))
        {   room = 294;
        } else
        {   result = dice(1);
            result = (result / 2) + (result % 2);
            savedrooms(result, st, 313, -1);
        }
    acase 306:
        create_monster(472);
        if (prevroom == 313)
        {   good_freeattack();
        }
        fight();
    acase 308:
        if (saved(2, st))
        {   room = 290;
        } else
        {   templose_con(con / 2);
            room = 304;
        }
    acase 309:
        if (getyn("Take sword"))
        {   room = 296;
        } elif (getyn("Take statuette"))
        {   savedrooms(3, iq, 302, 292);
        } elif (getyn("Take treasure"))
        {   for (i = 1; i <= 3; i++)
            {   result = dice(1);
                give_gp(result * 1000);
                if (result == 3)
                {   rb_givejewel(-1, -1, 1);
            }   }
            award(300); // %%: only if we take the treasure, apparently...
            room = 237;
        }
    acase 310:
        give(239);
    acase 311:
        if (shooting() && shot(RANGE_POINTBLANK, SIZE_VSMALL, FALSE))
        {   room = 295;
        } else
        {   room = 287;
        }
    acase 312:
        return_all();
        result1 = dice(1);
        result2 = dice(1);
        give_gp((result1 + result2) * 1000);
        if (result1 == 6)
        {   rb_givejewel(-1, SIZE_LARGE, 1);
        }
        if (result2 == 6)
        {   rb_givejewel(-1, SIZE_LARGE, 1);
        }
        award(500);
    acase 313:
        give(780);
        if (armour >= 0)
        {   dropitem(armour);
        }
    acase 314:
        savedrooms(1, lk, 289, 298);
    acase 315:
        if (getyn("Luck (otherwise Dexterity)"))
        {   savedrooms(2, lk, 288, 297);
        } else
        {   savedrooms(2, dex, 288, 297);
        }
    acase 316:
        savedrooms(3, iq, 301, 290);
}   }

#define is ==
#define or ||

EXPORT void ca_magicmatrix(void)
{   aprintf(
"`MAGIC MATRIX\n" \
"  When you want to use a spell, write it down, then check the table below to see what the results of using that spell are. If the paragraph where you wish to use a spell is not listed, the spell has failed and the appropriate amount of strength should be deducted from the character before continuing.\n~"
    );

    switch (spellchosen)
    {
    case SPELL_TF:
        if
        (   room is 2
         or room is 3
         or room is 13
         or room is 17
         or room is 22
         or room is 45
         or room is 48
         or room is 91
         or room is 108
         or room is 110
         or room is 115
         or room is 118
         or room is 119
         or room is 123
         or room is 167
         or room is 168
         or room is 185
         or room is 215
         or room is 217
         or room is 220
         or room is 228
         or room is 238
         or room is 243
         or room is 248
         or room is 251
        )
        {   fulleffect();
        } elif (room is 9)
        {   maybeeffect(2);
        } elif (room is 19)
        {   maybeeffect(4);
        } elif (room is 236)
        {   maybeeffect(3);
        } else
        {   noeffect();
        }
    acase SPELL_VB:
        if
        (   room is 2
         or room is 48
         or room is 217
         or room is 220
        )
        {   maybeeffect(3);
        } elif
        (   room is 3
         or room is 13
         or room is 167
        )
        {   maybeeffect(4);
        } elif
        (   room is 19
         or room is 168
         or room is 236
        )
        {   maybeeffect(5);
        } elif
        (   room is 22
         or room is 91
         or room is 115
         or room is 118
         or room is 119
         or room is 123
         or room is 185
         or room is 215
         or room is 119
         or room is 223
         or room is 228
         or room is 238
         or room is 243
         or room is 251
        )
        {   fulleffect();
        } elif
        (   room is 45
         or room is 248
        )
        {   maybeeffect(2);
        } else
        {   noeffect();
        }
    acase SPELL_PA:
        if
        (   room is 19
         or room is 118
         or room is 236
        )
        {   fulleffect();
        } else
        {   noeffect();
        }
    acase SPELL_CC:
        if   (room is   2 && dice(1) <= 3) room =  35;
        elif (room is   3 && dice(1) <= 2) room =  35;
        elif (room is 228                ) room = 185;
        elif (room is 248                ) room =  35;
        else                               noeffect();
    acase SPELL_DE:
        if
        (   room is 2
         or room is 3
         or room is 13
         or room is 17
         or room is 22
         or room is 45
         or room is 48
         or room is 91
         or room is 108
         or room is 110
         or room is 115
         or room is 118
         or room is 119
         or room is 123
         or room is 167
         or room is 168
         or room is 185
         or room is 215
         or room is 217
         or room is 220
         or room is 228
         or room is 243
         or room is 248
         or room is 251
        )
        {   fulleffect();
        } else
        {   noeffect();
        }
    acase SPELL_SF:
        if
        (   room is 2
         or room is 3
         or room is 13
         or room is 17
         or room is 19
         or room is 22
         or room is 45
         or room is 48
         or room is 91
         or room is 108
         or room is 110
         or room is 115
         or room is 118
         or room is 119
         or room is 123
         or room is 167
         or room is 168
         or room is 185
         or room is 215
         or room is 217
         or room is 220
         or room is 223
         or room is 228
         or room is 236
         or room is 238
         or room is 243
         or room is 248
         or room is 251
        )
        {   fulleffect();
        } else
        {   noeffect();
        }
    acase SPELL_EH:
        if
        (   room is 2
         or room is 45
         or room is 217
         or room is 220
        )
        {   maybeeffect(3);
        } elif
        (   room is 3
         or room is 168
        )
        {   maybeeffect(5);
        } elif
        (   room is 13
         or room is 19
         or room is 167
         or room is 236
        )
        {   maybeeffect(4);
        } elif
        (   room is 22
         or room is 91
         or room is 115
         or room is 118
         or room is 119
         or room is 123
         or room is 185
         or room is 215
         or room is 223
         or room is 228
         or room is 238
         or room is 243
         or room is 251
        )
        {   fulleffect();
        } else
        {   noeffect();
        }
    acase SPELL_DW:
        if
        (   room is 19
         or room is 22
         or room is 91
         or room is 115
         or room is 119
         or room is 123
         or room is 215
         or room is 236
         or room is 238
         or room is 251
        )
        {   fulleffect();
        } else
        {   noeffect();
        }
    acase SPELL_BP:
        if
        (   room is 2
         or room is 3
         or room is 13
         or room is 17
         or room is 19
         or room is 45
         or room is 48
         or room is 108
         or room is 110
         or room is 118
         or room is 119
         or room is 123
         or room is 167
         or room is 168
         or room is 185
         or room is 215
         or room is 217
         or room is 220
         or room is 228
         or room is 236
         or room is 238
         or room is 243
         or room is 248
         or room is 251
        )
        {   fulleffect();
        } else
        {   noeffect();
        }
    acase SPELL_IF:
        if
        (   room is 2
         or room is 3
         or room is 13
         or room is 17
         or room is 19
         or room is 22
         or room is 45
         or room is 48
         or room is 91
         or room is 108
         or room is 110
         or room is 115
         or room is 118
         or room is 119
         or room is 123
         or room is 167
         or room is 168
         or room is 185
         or room is 215
         or room is 217
         or room is 220
         or room is 228
         or room is 236
         or room is 238
         or room is 243
         or room is 248
         or room is 251
        )
        {   fulleffect();
        } elif (room is 9)
        {   maybeeffect(3);
        } else
        {   noeffect();
}   }   }
