#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

MODULE const STRPTR tc_desc[TC_ROOMS] = {
{ // 0
"The dungeon which follows is of the \"house and home\" variety - the monsters here are guardians of the places in which they actually live."
},
{ // 1
"If there is anyone in the party of 3rd level or higher, the ghost of a Troll appears and warns them to turn back. Anyone of level 3 or higher who disregards the warning and passes {2} loses all ap and has each attribute divided by his or her level number. The ghost is immune to all magic."
},
{ // 2
"Iron door: An iron door 10' high and 10' wide blocks the passage. It is curiously designed. Near the top is a painted eye, which sometimes blinks. At the bottom is an open mouth. In the centre is what appears to be a mighty arm, 4' long and very well-muscled, protruding from the door. Above the arm, below the eye, is a line of writing in Dwarvish runes, but the language is Orcish.\n" \
"  In order to make this door open, a character must do one of two things. He - or she - must either beat the door in armwrestling (make L2-SR on ST (25 - ST): if made, the door opens; if missed, character takes amount missed by in hits on CON) or throw at least 1 gp for each party member through the open mouth. All gold fed to the door becomes part of the Trolls' treasure in {15}.\n" \
"  M1: One Guardian Monster for each member of the party will be standing at this point, so that each character will be engaged in 1:1 combat. (Randomize on the Guardian Monster Chart.) Monsters will break and run after 3 combat turns, unless they are dead or have won all the fights.\n" \
"  However, when the delvers return to M1 just inside the enchanted door, if they have succeeded in taking any of the treasures in the caves they will be confronted with 10 Orcs (MR of 22 each) who will attempt to bar their exit.\n" \
"  The door can easily be opened from this side, but the Orcs will let the delvers out only if they give up all their treasure, defeat them in combat[, or trick them somehow].\n" \
"  If the delvers are poorer than when you started, or have none of the Trollstone Cavern treasure, the 10 Orcs will merely escort them out (unless they foolishly attack the Orcs...)"
},
{ // 3
"The Pool of Darkness: The path descends into what appears to be a large puddle or small pool of black water. Around the edges it is only 1'-2' deep. The water is poisonous. If the pool water is drunk, roll 2 dice (doubles add and roll over) and subtract that number from that character's CON and CHR.[\n" \
"  If characters try to walk around the edges of the pool, each must make a L1-SR on LK (20 - LK) to see if they fell into the 10' deep pothole. If they fell in, the water will get into their eyes and blind them for 1-6 turns. (Roll 1 die.)\n" \
"  Weapons immersed in pool water will begin to rust immediately. Subtract 2 points from the adds of each weapon dunked.]"
},
{ // 4
"Secret Door: Takes a L1-SR on IQ (20 - IQ) to find it if the characters in the tunnel specifically state they are looking for secret doors - otherwise, L3-SR on LK (30 - LK) is needed. It will require an Unlock spell to be opened."
},
{ // 5
"Guardian Monster Village: No treasure here, but if characters enter the village they will be attacked by 1-6 Guardian Monsters (from the chart). If they remain in the village for up to 10 combat turns, a new group of Guardian Monsters appears every turn. After 10 combat turns the monster supply runs out and no more Guardian Monsters will appear."
},
{ // 6
"Secret Door: Takes Takes a L1-SR on LK (20 - LK) to find it if players say they are searching for secret doors. Otherwise, it won't be found."
},
{ // 7
"Secret Exit: This secret exit from Trollstone Caverns is used by monsters such as Red Orcs who must leave the caves from time to time. Make a L1-SR on LK to find it, if players say they're looking for secret doors. Otherwise, it won't be discovered."
},
{ // 8
"The Silver Room: Here lives a giant silver-scaled serpent with a Monster Rating of 100. It exhales a blast of freezing cold air. To avoid freezing, anyone fighting it must make progressively higher saving rolls on CON (starting at 1st level).\n" \
"  Here also are all of the Silver Serpent's victims - jumbled up in a heap of skeletons. Their weapons and armour have been scavenged by Orcs and sold or disposed of."
},
{ // 9
"Treasure pile: The treasure pile of the Silver Serpent, 2000 silver nuggets at 1 weight unit each[, plus any other silver the Game Master has collected from previous (and presumably defunct) delvers].[ (GM should make a pencilled-in treasure card for this room and add any newly-captured silver to the treasure stored here.)]"
},
{ // 10
"Scrapheap Chasm: The path is broken by a chasm about 20' wide and 50' deep. It is used as a place to throw garbage by the monsters who live in Trollstone Caverns.\n" \
"  To jump across the chasm, a character must make a SR on ST. Figure weight possible and weight carried.\n" \
"  - If weight carried is less than ¼ weight possible, the jumper needs only a L1-SR on ST to cross;\n" \
"  - If weight carried is between ¼ and ½ the weight possible, the jumper needs a L2-SR on ST;\n" \
"  - If weight carried is between ½ and ¾ the weight possible, a L3-SR on ST is needed to cross;\n" \
"  - If weight carried is over ¾ the weight possible, a L4-SR on ST is required.\n" \
"  Failing to make the jump is always fatal. Any character who can make a L1-SR on IQ will think of throwing equipment across first and then making the jump at the lowest possible saving roll.\n" \
"  M2: Roll 1 die. On 1 or 6, a Guardian Monster attacks the first character who jumps the chasm. No one else is allowed to cross without falling in unless the monster has been defeated."
},
{ // 11
"Bloodbat Cavern: Several dozen bloodbats (MR = 10) live here. Each character must roll 1 die to see how many (1-6) attack. [To beat them off a character need only beat their combined attack. To inflict any damage he or she must also make a L1-SR on DEX. ]There is a small hole in the roof 200' above allowing sun and moonlight to enter dimly.[ Bats attack as long as there are any players in their chamber.]"
},
{ // 12
"Corridor of Traps: The hallway slopes upward from the Cave of the Bloodbats. Spears are spring-loaded in walls, floors, and ceiling. Each character must make a L1-SR, L2-SR and L3-SR on Luck. Each time he or she misses, the difference is taken in hits. (Armour will help here.) The spears are 8' long and have chipped obsidian heads. Each spear weighs 30 weight units, with the obsidian head weighing 20 of the total 30. Each spear is worth 3 dice in combat, and the obsidian raises its value by 5 gp. Each surviving character interested in retrieving spears should roll 3 dice for the number of spears with undamaged heads he or she can locate."
},
{ // 13
"Pedestal of the Sphinx: A living winged sphinx with a MR of 200 sit atop a 20' tall marble pillar. Between her paws is a block of obsidian carved to look like a crouching troll. This is the Trollstone, the key to the Troll's treasure trove. Behind the sphinx is a door with a niche-lock that exactly fits the Trollstone key.\n" \
"  The sphinx will give the Trollstone to the first character who can answer her riddle. [(GM should find or invent a supply of good riddles. For example: Why do dragons sleep days? Because they fight knights!) ]The sphinx explains that only the riddle-answerer is allowed to go through the door (the party may attack her if they decide to send more through). After one character has entered the trolls' cavern, the sphinx speaks, the door closes, and the Trollstone teleports back to her feet. [Another character must answer another riddle to enter the Troll's treasure chamber peacefully.\n" \
"  If the sphinx is attacked by more than 3 people, it will run away, flying straight up a dark shaft above the marble pedestal. ]In any case, it will not fight more than 1 combat turn even if it is winning.\n" \
"  Inside the 20' pedestal, hidden by the sphinx, is a cavity containing 1 or more jewels. Start with a diamond worth 180 gp. Each time the sphinx asks another unanswered riddle add 1 more gem to its treasure (create them from the Jewel Generator in section 3.2).\n" \
"  Every other jewel created will have a single magic gift which can be used but once; after it is gone, the jewel is non-magical but still of full value. The magic gift adds to a Prime Attribute. Roll 1 die: 1 = ST, 2 = IQ, 3 = LK, 4 = CON, 5 = DEX, 6 = CHR. Roll 1 die again and add that amount to the attribute indicated."
},
{ // 14
"Niche: This is a niche in the cave wall (in a hidden door, actually) that exactly fits the Trollstone. This is also the only entrance to the Troll's cavern. In order for the hidden door to open, the Trollstone must be fitted into the niche."
},
{ // 15
"Trolls Cavern and Golden Treasure: All the [golden ]treasure lost in Trollstone Caverns winds up here as part of the Troll's hoard. He starts with 500 gold rings at 2 weight units each. [(GM should make a treasure card for this room and ]whenever delvers pay gold to gain entry, [or die with unsalvaged gold on their bodies, ]the GM should add it to the Troll's treasure."
},
{ // 16
"This is a pile of skeletons and armour, previous victims of the Troll. All metal is rusty and ruined, and the Troll doesn't allow anyone or anything to pick over these bones."
},
{ // 17
"The Troll of Trollstone Caverns: This is a Cave Troll of the classic type[ - direct sunlight will change him into stone]. He's small as Trolls go, standing only about 12' tall and 5' wide. (MR of 36.)\n" \
"  Wizards will be able to sense enchantment on the Troll. It would take 3 Omnipotent Eye spells to learn the whole story, however.\n" \
"  - OE1 will tell that there are 2 spells on the Troll.\n" \
"  - OE2 will tell that the Troll must stay nearby and guard the golden treasure.\n" \
"  [- OE3 will show that whoever slays the Troll will be transformed into a replacement Cave Troll (with a MR of 3 times his or her ST attribute) who must stay and guard the treasure.\n" \
"  ]The Troll will attack whoever enters his cavern. (You're his lunch.) If he doesn't win the first combat round, he will break off the fight and beg for mercy in the Common Tongue. He can't explain about the enchantments on himself, but he knows he can't allow you to take any of the gold. He will offer to buy you off and tell you where you where you can find better treasure.\n" \
"  If the bargain is accepted, the Troll tells about the sphinx's enchanted gems hidden in the pillar (see {13}). At this point the Troll may be attacked by magic and Yassa-Massa'ed to obey a magic-user's commands. If he is commanded to leave the cave, he will have to do so, and the delvers can take the gold.\n" \
"  [If the Troll is slain, the character who killed him becomes the next guardian Troll as previously mentioned. ]On the cave wall where the delver entered is a black handprint of a Troll. Pushing this causes the entrance to open again.\n" \
"  If delvers insist on trying to take the gold, the Troll will fight to the bitter end."
},
{ // 18
"If you wish to expand this dungeon, it is very easily done. Near {18} is a secret door leading to a shaft with a rung ladder in it, descending to deeper levels. Of course, these levels are only there is you as GM wish to design them."
}
}, tc_wandertext[6] = {
{ // 0
"1. Goblins          MR = 16."
},
{ // 1
"2. Wargs            MR = 28."
},
{ // 2
"3. Bloodbats        MR = 10.[ Takes a L1-SR on DEX (20 - DEX) to score hits on them.]"
},
{ // 3
"4. Giant Lizard     MR = 24. Its skin takes 7 hits as if it was armour."
},
{ // 4
"5. Shadow Ghosts    MR = 12.[ Their attack is mental and comes off both IQ and CON. They are vulnerable only to magic.]"
},
{ // 5
"6. Red Orcs         MR = 22."
}
};

MODULE SWORD tc_exits[TC_ROOMS][EXITS] =
{ {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1
  {  10,   3,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2
  {   2,  18,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3
  {  18,   8,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4
  {   4,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5
  {   5,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7
  {   4,   9,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8
  {   8,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9
  {   2,  11,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10
  {  10,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11
  {  11,  13,  18,  -1,  -1,  -1,  -1,  -1 }, //  12
  {  12,  18,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13
  {  13,  17,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14
  {  16,  17,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15
  {  15,  17,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16
  {  14,  15,  16,  -1,  -1,  -1,  -1,  -1 }, //  17
  {   3,   4,  12,  13,  -1,  -1,  -1,  -1 }  //  18
};

MODULE STRPTR tc_pix[TC_ROOMS] =
{ "", //   0
  "",
  "tc2",
  "",
  "",
  "", //   5
  "",
  "",
  "",
  "",
  "", //  10
  "tc11",
  "",
  "tc13",
  "",
  "", //  15
  "tc16",
  "",
  ""  //  18
};

IMPORT       FLAG             ask;
IMPORT       int              been[MOST_ROOMS + 1],
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              evil_attacktotal,
                              good_attacktotal,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              room, prevroom, module,
                              round;
IMPORT       SWORD*           exits;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR*          descs[MODULES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct LanguageStruct  language[LANGUAGES];

MODULE FLAG                   answered_riddle,
                              killed_troll,
                              killed_sphinx;

IMPORT void (* enterroom) (void);

MODULE void tc_enterroom(void);
MODULE void tc_guardian(int amount);

EXPORT void tc_preinit(void)
{   descs[MODULE_TC] = tc_desc;
}

EXPORT void tc_init(void)
{   int i;

    exits     = &tc_exits[0][0];
    enterroom = tc_enterroom;
    for (i = 0; i < TC_ROOMS; i++)
    {   pix[i] = tc_pix[i];
}   }

MODULE void tc_enterroom(void)
{   TRANSIENT int  amount,
                   choice,
                   i,
                   result;
    TRANSIENT FLAG done,
                   found;
    PERSIST   int  hoard,
                   tc_gems;
    PERSIST   FLAG inside;

    switch (room)
    {
    case 0:
        hoard = 0;
        inside = FALSE;
        tc_gems = 0;
        answered_riddle = killed_troll = killed_sphinx = FALSE;
        ask = FALSE; // otherwise they might refuse the map and then become lost in the caverns
        give(803); // they can always drop it later if they really don't want it
        ask = TRUE;
    acase 1: // 8A
        if     (inside     && getyn("Leave adventure"))
        {   victory(100);
        } elif (level >= 3 && getyn("Leave adventure"))
        {   victory(0);
        }
    acase 2:
        if (language[2].fluency == 2) // Dwarvish
        {   aprintf("Strakk glee glim drim urr uruksmagk nitz utorr.\n");
            if (language[4].fluency >= 1 || items[945].owned) // Orcish
            {   aprintf("\"This door yields to gold or force, nothing else!\"\n");
        }   }
        if (!inside)
        {   do
            {   choice = getnumber("1) Armwrestle door\n2) Give gold to door\n3) Leave caverns\nWhich", 1, 3);
                switch (choice)
                {
                case 1:
                    if (!saved(2, st))
                    {   templose_con(misseditby(2, st));
                    } else
                    {   inside = TRUE;
                    }
                acase 2:
                    amount = getnumber("How many gp", 0, gp);
                    if (amount >= 1)
                    {   pay_gp(amount);
                        hoard += amount;
                        inside = TRUE;
                    }
                acase 3:
                    room = 1;
            }   }
            while (room == 2 && !inside);
            if (room == 2)
            {   if (level >= 3) // %%: we penalize them each time they walk through the door going inwards
                {   award(-xp); // %%: it doesn't say whether we actually lose levels though; we assume not.
                    // otherwise this would be order-dependent

                    permchange_st( divide_roundup(max_st , level));
                        change_iq( divide_roundup(    iq , level));
                        change_lk( divide_roundup(    lk , level));
                        change_dex(divide_roundup(    dex, level));
                    permchange_con(divide_roundup(max_con, level));
                        change_chr(divide_roundup(    chr, level));
                        change_spd(divide_roundup(    spd, level));
                }
                tc_guardian(1);
                oneround();
                oneround();
                oneround();
                dispose_npcs();
        }   }
        else
        {   if (getyn("Leave caverns"))
            {   if (getyn("Fight orcs"))
                {   create_monsters(38, 10);
                    fight();
                } else
                {   drop_all();
                }
                room = 1;
        }   }
    acase 3:
        if (getyn("Drink water (otherwise walk)"))
        {   result = daro();
            templose_con(result);
            lose_chr(result);
        }
    acase 4:
        // %%: is this necessary every time (eg. does it get rehidden and relocked)?
        found = FALSE;
        if (getyn("Look for secret doors"))
        {   if (saved(1, iq))
            {   found = TRUE;
        }   }
        elif (saved(3, lk))
        {   found = TRUE;
        }
        if (found)
        {   aprintf("Found a secret door.\n");
            if (cast(SPELL_KK, FALSE))
            {   room = 5;
        }   }
    acase 5:
        for (i = 1; i <= 10; i++)
        {   tc_guardian(dice(1));
            oneround();
            if (!countfoes())
            {   break;
        }   }
        while (countfoes())
        {   oneround();
        }
        if (getyn("Look for secret doors") && saved(1, lk))
        {   aprintf("Found a secret door.\n");
            room = 6;
        }
    acase 6:
        if (getyn("Look for secret doors") && saved(1, lk))
        {   aprintf("Found a secret door.\n");
            room = 7;
        }
    acase 7:
        victory(100);
    acase 8:
        if (!been[8])
        {   create_monster(39);
            amount = 1;
            do
            {   if (!saved(amount++, con))
                {   die();
                } else
                {   oneround();
            }   }
            while (con >= 1 && countfoes());
        }
    acase 9:
        if (!been[9])
        {   give_sp(2000);
        }
    acase 10:
        if (saved(1, iq) && saved(1, st))
        {   encumbrance();
            room = (prevroom == 11) ? 2 : 11;
        } elif (carrying() < st * 25) // less than ¼
        {   if (saved(1, st))
            {   room = (prevroom == 11) ? 2 : 11;
        }   }
        elif (carrying() < st * 50) // less than ½
        {   if (saved(2, st))
            {   room = (prevroom == 11) ? 2 : 11;
        }   }
        elif (carrying() < st * 75) // less than ¾
        {   if (saved(3, st))
            {   room = (prevroom == 11) ? 2 : 11;
        }   }
        else
        {   if (saved(4, st))
            {   room = (prevroom == 11) ? 2 : 11;
        }   }
        if (room == 10)
        {   die();
        } else
        {   result = dice(1);
            if (result == 1 || result == 6)
            {   tc_guardian(1);
                fight();
        }   }
    acase 11:
        create_monsters(35, dice(1));
        fight();
    acase 12:
        if (!saved(1, lk))
        {   good_takehits(misseditby(1, lk), TRUE);
        }
        if (!saved(2, lk))
        {   good_takehits(misseditby(2, lk), TRUE);
        }
        if (!saved(3, lk))
        {   good_takehits(misseditby(3, lk), TRUE);
        }
        give_multi(235, dice(3));
        // %%: "The obsidian raises its value to 5 gp" should presumably be
        // "by 5 gp" instead, as a common spear is worth 22 gp.
    acase 13:
        if (!killed_sphinx)
        {   done = FALSE;
            while (!done)
            {   if (!answered_riddle && getyn("Answer riddle (otherwise fight)"))
                {   // %%: we have made this a L1-SR on IQ (20 - IQ)
                    if (saved(1, iq))
                    {   room = 14;
                        done = answered_riddle = TRUE;
                    } else
                    {   tc_gems++;
                }   }
                else
                {   create_monster(40);
                    oneround();
                    if (countfoes())
                    {   dispose_npcs();
                    } else
                    {   killed_sphinx = TRUE;
                    }
                    done = TRUE;
                    give(248);
                    if (tc_gems >= 1)
                    {   for (i = 1; i < tc_gems; i++)
                        {   if (i % 2 == 1)
                            {   // better if we didn't force these to be used immediately
                                switch (dice(1))
                                {
                                case  1: gain_st( dice(1));
                                acase 2: gain_iq( dice(1));
                                acase 3: gain_lk( dice(1));
                                acase 4: gain_con(dice(1));
                                acase 5: gain_dex(dice(1));
                                acase 6: gain_chr(dice(1));
                            }   }
                            rb_givejewel(-1, -1, 1);
        }   }   }   }   }
        if (prevroom != 14)
        {   room = 14;
        }
    acase 15:
        if (!been[15])
        {   give_multi(236, 500);
            give_gp(hoard);
        }
    acase 17:
        if (cast(SPELL_OE, FALSE))
        {   aprintf("There are 2 spells on the Troll.\n");
            if (cast(SPELL_OE, FALSE))
            {   aprintf("The Troll must stay nearby and guard the golden treasure.\n");
                if (cast(SPELL_OE, FALSE))
                {   aprintf("[Whoever slays the Troll will be transformed into a replacement Cave Troll (with a MR of 3 times his or her ST attribute) who must stay and guard the treasure.]\n");
        }   }   }
        if (!killed_troll)
        {   create_monster(41);
            oneround();
            if (countfoes())
            {   if (good_attacktotal > evil_attacktotal)
                {   if (getyn("Accept bargain (otherwise fight)"))
                    {   dispose_npcs();
                        if (cast(SPELL_YM, FALSE) && st + iq + chr > npc[0].mr)
                        {   give_gp(hoard);
                            hoard = 0;
                    }   }
                    else
                    {   fight();
                        killed_troll = TRUE;
                        give_gp(hoard);
                        hoard = 0;
                }   }
                else
                {   fight();
                    killed_troll = TRUE;
                    give_gp(hoard);
                    hoard = 0;
}   }   }   }   }

MODULE void tc_guardian(int amount)
{   int result;

    aprintf(
"GUARDIAN MONSTER TABLE\n" \
"  When delvers reach a spot marked M1 or M2, roll 1 die to see which of these monsters they encounter. Then roll 1 die again to see how many (between 1 and 6) they actually meet there. The monsters will always attack unless the dungeon instructions state otherwise.\n"
    );
    result = dice(1);
    aprintf("%s\n", tc_wandertext[result - 1]);

    create_monsters(32 + result, amount); // 33..38
}
