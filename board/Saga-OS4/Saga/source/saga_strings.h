#ifndef SAGA_STRINGS_H
#define SAGA_STRINGS_H


/****************************************************************************/


/* This file was created automatically by CatComp.
 * Do NOT edit by hand!
 */


#ifndef EXEC_TYPES_H
#include <exec/types.h>
#endif

#ifdef CATCOMP_ARRAY
#undef CATCOMP_NUMBERS
#undef CATCOMP_STRINGS
#define CATCOMP_NUMBERS
#define CATCOMP_STRINGS
#endif

#ifdef CATCOMP_BLOCK
#undef CATCOMP_STRINGS
#define CATCOMP_STRINGS
#endif


/****************************************************************************/


#ifdef CATCOMP_NUMBERS

#define FILENAME_MANUAL 0
#define MSG_ABOUT 1
#define MSG_ABOUT2 2
#define MSG_ADVANCED_MODE 3
#define MSG_AIDS_HERO 4
#define MSG_AMSIR_1 5
#define MSG_AMSIR_2 6
#define MSG_A_P_O_L_F_H_D 7
#define MSG_AS_A_GIFT 8
#define MSG_AS_DUE_TRIBUTE 9
#define MSG_ATLANTIC_OCEAN 10
#define MSG_ATTACKERS 11
#define MSG_ATTACKERS_FLEE 12
#define MSG_ATTACKERS_KILLED 13
#define MSG_ATTACKERS_WOUNDED 14
#define MSG_ATTACKING 15
#define MSG_ATTACKS 16
#define MSG_BALMUNG_1 17
#define MSG_BALMUNG_2 18
#define MSG_BALMUNG_3 19
#define MSG_BALMUNG_4 20
#define MSG_BALMUNG_5 21
#define MSG_BALTIC_SEA 22
#define MSG_BROSUNG_NECKLACE 23
#define MSG_BUT_IT_FIZZLES 24
#define MSG_BY 25
#define MSG_BY_ADDING_1_TO_HIS_STRENGTH 26
#define MSG_BY_ADDING_2_TO_HIS_STRENGTH 27
#define MSG_BY_ADDING_3_TO_HIS_STRENGTH 28
#define MSG_B_A_1_T_T_S_O_E_P_O_H_S 29
#define MSG_B_E_W_H_G_2_G 30
#define MSG_B_S_T_H_G_1_G 31
#define MSG_CALL_FOR_AID 32
#define MSG_CANCEL 33
#define MSG_CANT_OPEN 34
#define MSG_CANT_READ_FROM 35
#define MSG_CANT_WRITE_TO 36
#define MSG_CASTS 37
#define MSG_CHAR_DEAD 38
#define MSG_CHAR_GLORY 39
#define MSG_CHAR_HEALTHY 40
#define MSG_CHAR_HUMAN 41
#define MSG_CHAR_LUCK 42
#define MSG_CHAR_NO 43
#define MSG_CHAR_RESTART 44
#define MSG_CHAR_TRANSFER 45
#define MSG_CHAR_WITHDRAW 46
#define MSG_CHAR_WOUNDED 47
#define MSG_CHAR_YES 48
#define MSG_COAT_1 49
#define MSG_COAT_2 50
#define MSG_COAT_3 51
#define MSG_COMBAT_STRENGTH 52
#define MSG_CONQUERED_KINGDOMS 53
#define MSG_CONSIDERS_ATTACKS 54
#define MSG_CONTENTS 55
#define MSG_CONTROL 56
#define MSG_DEAD_HERO 57
#define MSG_DECIDES_THAT_HERO 58
#define MSG_D_T_T_F_I_B_F 59
#define MSG_DEFENDERS 60
#define MSG_DEFENDERS_FLEE 61
#define MSG_DEFENDERS_KILLED 62
#define MSG_DEFENDERS_WOUNDED 63
#define MSG_DEFENDING 64
#define MSG_DESERVES_NO_REWARD 65
#define MSG_DRAGON 66
#define MSG_DRINK_THE 67
#define MSG_DROW 68
#define MSG_ENGLISH_CHANNEL 69
#define MSG_EON_1 70
#define MSG_EXCHANGE_THE 71
#define MSG_FAXI_1 72
#define MSG_FAXI_2 73
#define MSG_FAXI_3 74
#define MSG_FINDS 75
#define MSG_FINDS_THE 76
#define MSG_FINISH 77
#define MSG_FLEEING 78
#define MSG_FOR 79
#define MSG_FOR_READING 80
#define MSG_FOR_WRITING 81
#define MSG_FROM 82
#define MSG_F_T_B_S_N_T 83
#define MSG_FURY 84
#define MSG_GADGET_NONE 85
#define MSG_GAIN 86
#define MSG_GAME_OVER 87
#define MSG_GAME_SUMMARY 88
#define MSG_GAME_SUMMARY2 89
#define MSG_GEOFU_1 90
#define MSG_GEOFU_2 91
#define MSG_GEOFU_3 92
#define MSG_GEOFU_4 93
#define MSG_GIANT 94
#define MSG_GAVE 95
#define MSG_GIVES 96
#define MSG_GHOST 97
#define MSG_GOD 98
#define MSG_GOLDEN_MARKS 99
#define MSG_GOLDEN_MARKS_FROM_HERO 100
#define MSG_GOLDEN_MARKS_TO_HERO 101
#define MSG_HAS_THE_SWORD 102
#define MSG_HEALING_POTION 103
#define MSG_HEALTHY 104
#define MSG_HYDRA 105
#define MSG_GLORY 106
#define MSG_GRANTS_HERO 107
#define MSG_HAGALL_1 108
#define MSG_HAGALL_2 109
#define MSG_HAGALL_3 110
#define MSG_HAGALL_4 111
#define MSG_HAGALL_5 112
#define MSG_HAIL 113
#define MSG_H_A_F 114
#define MSG_HAS_BEEN_OVERRUN 115
#define MSG_HAS_CONQUERED_KINGDOM 116
#define MSG_HEALING 117
#define MSG_HEALS 118
#define MSG_HEARD_THE_PRAYER_OF_HERO 119
#define MSG_HELP_1 120
#define MSG_HELP_2 121
#define MSG_HELP_3 122
#define MSG_HELP_4 123
#define MSG_HERO 124
#define MSG_HERO2 125
#define MSG_HERO_NAME 126
#define MSG_HOMELAND 127
#define MSG_HONOURS_HERO 128
#define MSG_HRUNTING_1 129
#define MSG_HRUNTING_2 130
#define MSG_HRUNTING_3 131
#define MSG_HUMAN 132
#define MSG_ICE 133
#define MSG_IN 134
#define MSG_INFORMATION 135
#define MSG_ING_1 136
#define MSG_ING_2 137
#define MSG_INTERVENES_PERSONALLY 138
#define MSG_IRISH_SEA 139
#define MSG_IS_1 140
#define MSG_IS_2 141
#define MSG_IS_3 142
#define MSG_IS_BEING_ROUTED 143
#define MSG_IS_COVERED_WITH_ICE 144
#define MSG_IS_KILLED 145
#define MSG_ISLAND 146
#define MSG_IS_MOVING 147
#define MSG_I_N_A_V_S_G_F 148
#define MSG_IS_ROUTED 149
#define MSG_IS_WOUNDED 150
#define MSG_JARA_1 151
#define MSG_JARL 152
#define MSG_JARL2 153
#define MSG_JARL_NAME 154
#define MSG_KING 155
#define MSG_KINGDOM 156
#define MSG_KINGDOM2 157
#define MSG_KINGDOM_NAME 158
#define MSG_KING_NONE 159
#define MSG_KRAKEN 160
#define MSG_LAND 161
#define MSG_LEARNS_THE_RUNE 162
#define MSG_LOAD_GAME 163
#define MSG_LOADED 164
#define MSG_LOADING 165
#define MSG_LOCATION 166
#define MSG_LOSE 167
#define MSG_LOSE_TURN 168
#define MSG_LOSE_NEXT_TURN 169
#define MSG_LOVI_1 170
#define MSG_LOVI_2 171
#define MSG_LOVI_3 172
#define MSG_LUCK 173
#define MSG_LUCK2 174
#define MSG_MAIL_COAT 175
#define MSG_MAGIC_SHIRT 176
#define MSG_MAGIC_TREASURES 177
#define MSG_MAIDENS 178
#define MSG_M_N_T_B_S_T_T 179
#define MSG_MESSAGE_DELAY 180
#define MSG_MONSTER_NAME 181
#define MSG_MONSTER_SPECIES 182
#define MSG_MOVE 183
#define MSG_MOVE2 184
#define MSG_MOVE_BY_SEA 185
#define MSG_MOVEMENT_FACTOR 186
#define MSG_N_A 187
#define MSG_NECKLACE_1 188
#define MSG_NECKLACE_2 189
#define MSG_NECKLACE_3 190
#define MSG_NECKLACE_4 191
#define MSG_NECKLACE_5 192
#define MSG_NECKLACE_6 193
#define MSG_NECKLACE_7 194
#define MSG_NIED_1 195
#define MSG_NIED_2 196
#define MSG_NIED_3 197
#define MSG_NO 198
#define MSG_NONE 199
#define MSG_NO_RESULT 200
#define MSG_N_R_A_L_N_T 201
#define MSG_NORTH_SEA 202
#define MSG_NO_SPECIAL_POWERS 203
#define MSG_OF 204
#define MSG_OGAL_1 205
#define MSG_OK 206
#define MSG_OR 207
#define MSG_PENINSULA 208
#define MSG_POTION_1 209
#define MSG_POTION_2 210
#define MSG_POTION_3 211
#define MSG_PREVENTS_HERO 212
#define MSG_PROMOTES_JARL 213
#define MSG_PROPERTY 214
#define MSG_MENU_QUITWB 215
#define MSG_READ_THE 216
#define MSG_RECRUITED_JARLS 217
#define MSG_RECRUIT_JARL 218
#define MSG_RECRUITS_JARL 219
#define MSG_RESTART 220
#define MSG_RESTARTS 221
#define MSG_RETURN_START_GAME 222
#define MSG_REWARDS_HERO 223
#define MSG_RIDE 224
#define MSG_RIDES 225
#define MSG_RIDES2 226
#define MSG_RIDE_THE 227
#define MSG_ROLL 228
#define MSG_ROUT 229
#define MSG_ROUTED 230
#define MSG_RUNE 231
#define MSG_S 232
#define MSG_SAVED 233
#define MSG_SAVE_GAME 234
#define MSG_SAVING 235
#define MSG_SCROLL_1 236
#define MSG_SCROLL_2 237
#define MSG_SCROLL_3 238
#define MSG_SEA 239
#define MSG_SEA_SERPENT 240
#define MSG_SENDS_A_MAIDEN_TO_HEAL_HERO 241
#define MSG_SENDS_A_WOLF_TO_AID_HERO 242
#define MSG_SELECT 243
#define MSG_SELECT_ATTACKERS 244
#define MSG_SELECT_DEFENDER 245
#define MSG_SELECT_DESTINATION 246
#define MSG_SELECT_PASSENGERS 247
#define MSG_S_W_J_T_P 248
#define MSG_S_ENEMY 249
#define MSG_S_E_B_A_1_T_T_S 250
#define MSG_S_E_B_A_3_T_T_S 251
#define MSG_S_HERO 252
#define MSG_SHIRT_1 253
#define MSG_SHIRT_2 254
#define MSG_SHIRT_3 255
#define MSG_SHORTCUT_GAME_SUMMARY 256
#define MSG_SHORTCUT_S_T_B 257
#define MSG_SHOW_TITLEBAR 258
#define MSG_S_JARL 259
#define MSG_S_KINGDOM 260
#define MSG_S_M_R 261
#define MSG_S_NEXT_WOUND 262
#define MSG_S_NEXT_TWO_WOUNDS 263
#define MSG_SPECIAL 264
#define MSG_S_R_A_S_B_H_T_O_T_B 265
#define MSG_S_RUNE_PROTECTS_HIM 266
#define MSG_STATUS 267
#define MSG_S_A_P_O_L_F_H 268
#define MSG_SUMMARYLINE 269
#define MSG_SWORD 270
#define MSG_SWORD_NAME 271
#define MSG_S_WOUND 272
#define MSG_SYGIL_1 273
#define MSG_SYGIL_2 274
#define MSG_SYGIL_3 275
#define MSG_SYGIL_4 276
#define MSG_TAKES 277
#define MSG_TAKES_SWORD 278
#define MSG_TAKES_THE 279
#define MSG_TAKE_SWORD 280
#define MSG_TAKE_THE 281
#define MSG_TAXATION_FACTOR 282
#define MSG_TELEPORT_SCROLL 283
#define MSG_THE 284
#define MSG_THE_GODS 285
#define MSG_THE_SUN 286
#define MSG_THIS_TURN 287
#define MSG_TIME 288
#define MSG_TO_MOVE_BY_SEA_NEXT_TURN 289
#define MSG_TREASURE 290
#define MSG_TREASURE2 291
#define MSG_TREASURE_NAME 292
#define MSG_TROLL 293
#define MSG_TURN 294
#define MSG_TURNS 295
#define MSG_TYPE 296
#define MSG_UNCHAR_GLORY 297
#define MSG_UNCHAR_LUCK 298
#define MSG_UNCHAR_NO 299
#define MSG_UNCHAR_RESTART 300
#define MSG_UNCHAR_TRANSFER 301
#define MSG_UNCHAR_WITHDRAW 302
#define MSG_UNCHAR_YES 303
#define MSG_UNKNOWN 304
#define MSG_UNKNOWN_JARL 305
#define MSG_USAGE 306
#define MSG_USED 307
#define MSG_USE_LUCK 308
#define MSG_WEALTH 309
#define MSG_W_S_A_M_T_H_H 310
#define MSG_WINS 311
#define MSG_WITCH 312
#define MSG_WITH 313
#define MSG_WITHDRAW 314
#define MSG_WITHDRAWS_FROM_PLAY 315
#define MSG_WOUNDED 316
#define MSG_WOUNDING 317
#define MSG_WYNN_1 318
#define MSG_WYNN_2 319
#define MSG_YES 320
#define MSG_YOU_MUST_FIGHT_A_MONSTER 321
#define MSG_YR_1 322
#define MSG_YR_2 323
#define MSG_YR_3 324
#define MSG_TRANSLATOR1 325
#define MSG_TRANSLATOR2 326
#define MSG_PRESS_HELP_FOR_INFO 327
#define MSG_PROCESSNUMBER 328
#define MSG_QUITTITLE 329
#define MSG_RIDES_THE 330
#define MSG_DRINKS_THE 331
#define MSG_SCORE 332
#define MSG_INVISIBILITYRING 333
#define MSG_RING_1 334
#define MSG_RING_2 335
#define MSG_RING_3 336
#define MSG_MAGICCROWN 337
#define MSG_CROWN_1 338
#define MSG_CROWN_2 339
#define MSG_CROWN_3 340
#define MSG_WEAR_THE 341
#define MSG_WEARS_THE 342
#define MSG_ESCAPES 343
#define MSG_FAILS_TO_ESCAPE 344
#define MSG_W_A_M 345
#define MSG_SHORTCUT_W_A_M 346
#define MSG_HELPHAIL_1 347
#define MSG_HELPHAIL_2 348
#define MSG_HELPHAIL_3 349
#define MSG_HELPHAIL_4 350
#define MSG_APPDESC 351
#define MSG_COMPILEDFOR 352
#define MSG_RUNNINGON 353
#define MSG_PRIORITY 354
#define MSG_RECOVERABLE 355
#define MSG_FATAL 356
#define MSG_QUIT2 357
#define MSG_PILES 358
#define MSG_LMB 359
#define MSG_RMB 360
#define MSG_INFINITE 361
#define MSG_SECS 362
#define MSG_WHATSCREEN 363
#define MSG_CUSTOMWB 364
#define MSG_PUBSCREEN 365
#define MSG_BACKSPACE 366
#define MSG_CANTLOCK_NAMED 367
#define MSG_CANTLOCK_DEFAULT 368
#define MSG_MENU_PROJECT 369
#define MSG_MENU_NEW 370
#define MSG_KEY_NEW 371
#define MSG_MENU_OPEN 372
#define MSG_KEY_OPEN 373
#define MSG_MENU_SAVE1 374
#define MSG_KEY_SAVE 375
#define MSG_MENU_SAVEAS 376
#define MSG_KEY_SAVEAS 377
#define MSG_KEY_QUIT 378
#define MSG_MENU_SETTINGS 379
#define MSG_MENU_HELP 380
#define MSG_MENU_MANUAL 381
#define MSG_KEY_MANUAL 382
#define MSG_KEY_ABOUT 383

#endif /* CATCOMP_NUMBERS */


/****************************************************************************/


#ifdef CATCOMP_STRINGS

#define FILENAME_MANUAL_STR "PROGDIR:Saga_E.guide"
#define MSG_ABOUT_STR "About Saga"
#define MSG_ABOUT2_STR "About Saga..."
#define MSG_ADVANCED_MODE_STR "Advanced Mode?"
#define MSG_AIDS_HERO_STR "aids hero"
#define MSG_AMSIR_1_STR "A hero with this rune has twice the"
#define MSG_AMSIR_2_STR "chance of having the gods notice him."
#define MSG_A_P_O_L_F_H_D_STR "a point of luck for his daring"
#define MSG_AS_A_GIFT_STR "as a gift"
#define MSG_AS_DUE_TRIBUTE_STR "as due tribute"
#define MSG_ATLANTIC_OCEAN_STR "Atlantic Ocean"
#define MSG_ATTACKERS_STR "Attackers"
#define MSG_ATTACKERS_FLEE_STR "Attackers flee"
#define MSG_ATTACKERS_KILLED_STR "Attackers killed"
#define MSG_ATTACKERS_WOUNDED_STR "Attackers wounded"
#define MSG_ATTACKING_STR "Attacking"
#define MSG_ATTACKS_STR "attacks"
#define MSG_BALMUNG_1_STR "In any fight where its wielder is"
#define MSG_BALMUNG_2_STR "attacking an enemy wearing magic armour,"
#define MSG_BALMUNG_3_STR "it cancels out the benefit of the magic"
#define MSG_BALMUNG_4_STR "armour. Thus, the Mail Coat and the Magic"
#define MSG_BALMUNG_5_STR "Shirt provide no protection against it."
#define MSG_BALTIC_SEA_STR "Baltic Sea"
#define MSG_BROSUNG_NECKLACE_STR "Brosung Necklace"
#define MSG_BUT_IT_FIZZLES_STR "but it fizzles"
#define MSG_BY_STR "By"
#define MSG_BY_ADDING_1_TO_HIS_STRENGTH_STR "by adding 1 to his strength"
#define MSG_BY_ADDING_2_TO_HIS_STRENGTH_STR "by adding 2 to his strength"
#define MSG_BY_ADDING_3_TO_HIS_STRENGTH_STR "by adding 3 to his strength"
#define MSG_B_A_1_T_T_S_O_E_P_O_H_S_STR "by adding 1 to the strength of each person on his side"
#define MSG_B_E_W_H_G_2_G_STR "by eating with him, granting 2 glory"
#define MSG_B_S_T_H_G_1_G_STR "by speaking to him, granting 1 glory"
#define MSG_CALL_FOR_AID_STR "call for aid"
#define MSG_CANCEL_STR "Cancel"
#define MSG_CANT_OPEN_STR "Can't open"
#define MSG_CANT_READ_FROM_STR "Can't read from"
#define MSG_CANT_WRITE_TO_STR "Can't write to"
#define MSG_CASTS_STR "casts"
#define MSG_CHAR_DEAD_STR "D"
#define MSG_CHAR_GLORY_STR "G"
#define MSG_CHAR_HEALTHY_STR "H"
#define MSG_CHAR_HUMAN_STR "H"
#define MSG_CHAR_LUCK_STR "L"
#define MSG_CHAR_NO_STR "N"
#define MSG_CHAR_RESTART_STR "R"
#define MSG_CHAR_TRANSFER_STR "T"
#define MSG_CHAR_WITHDRAW_STR "W"
#define MSG_CHAR_WOUNDED_STR "W"
#define MSG_CHAR_YES_STR "Y"
#define MSG_COAT_1_STR "It adds +2 to the combat strength of the"
#define MSG_COAT_2_STR "wearer, but only when the wearer is"
#define MSG_COAT_3_STR "defending."
#define MSG_COMBAT_STRENGTH_STR "Combat Strength"
#define MSG_CONQUERED_KINGDOMS_STR "Conquered Kingdoms"
#define MSG_CONSIDERS_ATTACKS_STR "considers attacks"
#define MSG_CONTENTS_STR "Contents"
#define MSG_CONTROL_STR "Control"
#define MSG_DEAD_HERO_STR "Dead hero"
#define MSG_DECIDES_THAT_HERO_STR "decides that hero"
#define MSG_D_T_T_F_I_B_F_STR "decides that the fight is balanced fairly"
#define MSG_DEFENDERS_STR "Defenders"
#define MSG_DEFENDERS_FLEE_STR "Defenders flee"
#define MSG_DEFENDERS_KILLED_STR "Defenders killed"
#define MSG_DEFENDERS_WOUNDED_STR "Defenders wounded"
#define MSG_DEFENDING_STR "Defending"
#define MSG_DESERVES_NO_REWARD_STR "deserves no reward"
#define MSG_DRAGON_STR "Dragon"
#define MSG_DRINK_THE_STR "drink the"
#define MSG_DROW_STR "Drow"
#define MSG_ENGLISH_CHANNEL_STR "English Channel"
#define MSG_EON_1_STR "+1 to movement factor."
#define MSG_EXCHANGE_THE_STR "exchange the"
#define MSG_FAXI_1_STR "This treasure is a magic horse that can"
#define MSG_FAXI_2_STR "be ridden only 3 times. It doubles the"
#define MSG_FAXI_3_STR "rider's movement factor."
#define MSG_FINDS_STR "finds"
#define MSG_FINDS_THE_STR "finds the"
#define MSG_FINISH_STR "Finish"
#define MSG_FLEEING_STR "fleeing"
#define MSG_FOR_STR "for"
#define MSG_FOR_READING_STR "for reading"
#define MSG_FOR_WRITING_STR "for writing"
#define MSG_FROM_STR "from"
#define MSG_F_T_B_S_N_T_STR "from travelling by sea next turn"
#define MSG_FURY_STR "rune of fury"
#define MSG_GADGET_NONE_STR "None"
#define MSG_GAIN_STR "gain"
#define MSG_GAME_OVER_STR "Game over"
#define MSG_GAME_SUMMARY_STR "Game Summary"
#define MSG_GAME_SUMMARY2_STR "Game summary..."
#define MSG_GEOFU_1_STR "A hero with this rune will have all the"
#define MSG_GEOFU_2_STR "areas in his kingdom yield one additional"
#define MSG_GEOFU_3_STR "mark over and above the tax factor each"
#define MSG_GEOFU_4_STR "turn."
#define MSG_GIANT_STR "Giant"
#define MSG_GAVE_STR "gave"
#define MSG_GIVES_STR "gives"
#define MSG_GHOST_STR "Ghost"
#define MSG_GOD_STR "God"
#define MSG_GOLDEN_MARKS_STR "golden marks"
#define MSG_GOLDEN_MARKS_FROM_HERO_STR "golden marks from hero"
#define MSG_GOLDEN_MARKS_TO_HERO_STR "golden marks to hero"
#define MSG_HAS_THE_SWORD_STR "has the sword"
#define MSG_HEALING_POTION_STR "Healing Potion"
#define MSG_HEALTHY_STR "Healthy"
#define MSG_HYDRA_STR "Hydra"
#define MSG_GLORY_STR "Glory"
#define MSG_GRANTS_HERO_STR "grants hero"
#define MSG_HAGALL_1_STR "Reduces the combat factor of each counter"
#define MSG_HAGALL_2_STR "in the area (including the caster) by one"
#define MSG_HAGALL_3_STR "for the rest of the turn. It also"
#define MSG_HAGALL_4_STR "prevents any of the counters from moving"
#define MSG_HAGALL_5_STR "by sea next turn."
#define MSG_HAIL_STR "hail"
#define MSG_H_A_F_STR "has already fought"
#define MSG_HAS_BEEN_OVERRUN_STR "has been overrun"
#define MSG_HAS_CONQUERED_KINGDOM_STR "has conquered kingdom"
#define MSG_HEALING_STR "rune of healing"
#define MSG_HEALS_STR "heals"
#define MSG_HEARD_THE_PRAYER_OF_HERO_STR "heard the prayer of hero"
#define MSG_HELP_1_STR "Runes..."
#define MSG_HELP_2_STR "Spells..."
#define MSG_HELP_3_STR "Swords..."
#define MSG_HELP_4_STR "Treasures..."
#define MSG_HERO_STR "Hero"
#define MSG_HERO2_STR "hero"
#define MSG_HERO_NAME_STR "Hero Name"
#define MSG_HOMELAND_STR "Homeland"
#define MSG_HONOURS_HERO_STR "honours hero"
#define MSG_HRUNTING_1_STR "The other side must flee instead when the"
#define MSG_HRUNTING_2_STR "combat result would be that the wielder's"
#define MSG_HRUNTING_3_STR "side must flee."
#define MSG_HUMAN_STR "Human"
#define MSG_ICE_STR "ice"
#define MSG_IN_STR "in"
#define MSG_INFORMATION_STR "Information"
#define MSG_ING_1_STR "A hero with this rune can heal his wounds"
#define MSG_ING_2_STR "by spending one turn anywhere at rest."
#define MSG_INTERVENES_PERSONALLY_STR "intervenes personally"
#define MSG_IRISH_SEA_STR "Irish Sea"
#define MSG_IS_1_STR "Makes it impossible for any hero to"
#define MSG_IS_2_STR "found, or continue to have a kingdom in"
#define MSG_IS_3_STR "that country."
#define MSG_IS_BEING_ROUTED_STR "is being routed"
#define MSG_IS_COVERED_WITH_ICE_STR "is covered with ice"
#define MSG_IS_KILLED_STR "is killed"
#define MSG_ISLAND_STR "Island"
#define MSG_IS_MOVING_STR "is moving"
#define MSG_I_N_A_V_S_G_F_STR "is not a valid saved game file"
#define MSG_IS_ROUTED_STR "is routed"
#define MSG_IS_WOUNDED_STR "is wounded"
#define MSG_JARA_1_STR "All in the area lose their next turn."
#define MSG_JARL_STR "Jarl"
#define MSG_JARL2_STR "jarl"
#define MSG_JARL_NAME_STR "Jarl Name"
#define MSG_KING_STR "King"
#define MSG_KINGDOM_STR "Kingdom"
#define MSG_KINGDOM2_STR "kingdom"
#define MSG_KINGDOM_NAME_STR "Kingdom Name"
#define MSG_KING_NONE_STR "None"
#define MSG_KRAKEN_STR "Kraken"
#define MSG_LAND_STR "Land"
#define MSG_LEARNS_THE_RUNE_STR "learns the rune"
#define MSG_LOAD_GAME_STR "Load Game"
#define MSG_LOADED_STR "Loaded"
#define MSG_LOADING_STR "Loading"
#define MSG_LOCATION_STR "Location"
#define MSG_LOSE_STR "lose"
#define MSG_LOSE_TURN_STR "lose turn"
#define MSG_LOSE_NEXT_TURN_STR "lose next turn"
#define MSG_LOVI_1_STR "In any battle against a side including"
#define MSG_LOVI_2_STR "jarls, it adds an additional +2 to the"
#define MSG_LOVI_3_STR "wielder's combat factor."
#define MSG_LUCK_STR "Luck"
#define MSG_LUCK2_STR "luck"
#define MSG_MAIL_COAT_STR "Mail Coat"
#define MSG_MAGIC_SHIRT_STR "Magic Shirt"
#define MSG_MAGIC_TREASURES_STR "Magic Treasures"
#define MSG_MAIDENS_STR "Maidens"
#define MSG_M_N_T_B_S_T_T_STR "may not travel by sea this turn"
#define MSG_MESSAGE_DELAY_STR "Message Delay:"
#define MSG_MONSTER_NAME_STR "Monster Name"
#define MSG_MONSTER_SPECIES_STR "Monster Species"
#define MSG_MOVE_STR "move"
#define MSG_MOVE2_STR "Move"
#define MSG_MOVE_BY_SEA_STR "Move by sea"
#define MSG_MOVEMENT_FACTOR_STR "Movement Factor"
#define MSG_N_A_STR "n/a"
#define MSG_NECKLACE_1_STR "This treasure is worth 20 marks. It may"
#define MSG_NECKLACE_2_STR "be traded for any item in a dragon's"
#define MSG_NECKLACE_3_STR "hoard. The wearer moves into the area"
#define MSG_NECKLACE_4_STR "adjacent to that of the dragon, and gives"
#define MSG_NECKLACE_5_STR "it to the dragon while taking what the"
#define MSG_NECKLACE_6_STR "dragon had. The wearer may then see what"
#define MSG_NECKLACE_7_STR "he had traded for."
#define MSG_NIED_1_STR "Makes the combat result an automatic \"no"
#define MSG_NIED_2_STR "result\" and causes all in the area to"
#define MSG_NIED_3_STR "lose one turn."
#define MSG_NO_STR "No"
#define MSG_NONE_STR "None"
#define MSG_NO_RESULT_STR "No result"
#define MSG_N_R_A_L_N_T_STR "no result and lose next turn"
#define MSG_NORTH_SEA_STR "North Sea"
#define MSG_NO_SPECIAL_POWERS_STR "No special powers"
#define MSG_OF_STR "of"
#define MSG_OGAL_1_STR "+1 to combat strength."
#define MSG_OK_STR "OK"
#define MSG_OR_STR "or"
#define MSG_PENINSULA_STR "Peninsula"
#define MSG_POTION_1_STR "This treasure can be used only once. It"
#define MSG_POTION_2_STR "will heal any wounds that the hero is"
#define MSG_POTION_3_STR "suffering."
#define MSG_PREVENTS_HERO_STR "prevents hero"
#define MSG_PROMOTES_JARL_STR "promotes jarl"
#define MSG_PROPERTY_STR "rune of property"
#define MSG_MENU_QUITWB_STR "Quit Saga"
#define MSG_READ_THE_STR "read the"
#define MSG_RECRUITED_JARLS_STR "Recruited Jarls"
#define MSG_RECRUIT_JARL_STR "recruit jarl"
#define MSG_RECRUITS_JARL_STR "recruits jarl"
#define MSG_RESTART_STR "Restart"
#define MSG_RESTARTS_STR "restarts"
#define MSG_RETURN_START_GAME_STR "Start Game (ENTER/Spacebar)"
#define MSG_REWARDS_HERO_STR "rewards hero"
#define MSG_RIDE_STR "ride"
#define MSG_RIDES_STR "Rides"
#define MSG_RIDES2_STR "rides"
#define MSG_RIDE_THE_STR "ride the"
#define MSG_ROLL_STR "Roll"
#define MSG_ROUT_STR "rout"
#define MSG_ROUTED_STR "Routed"
#define MSG_RUNE_STR "Rune"
#define MSG_S_STR "'s"
#define MSG_SAVED_STR "Saved"
#define MSG_SAVE_GAME_STR "Save Game"
#define MSG_SAVING_STR "Saving"
#define MSG_SCROLL_1_STR "This treasure can be used only once. It"
#define MSG_SCROLL_2_STR "will teleport the user to any desired"
#define MSG_SCROLL_3_STR "location."
#define MSG_SEA_STR "Sea"
#define MSG_SEA_SERPENT_STR "Sea Serpent"
#define MSG_SENDS_A_MAIDEN_TO_HEAL_HERO_STR "sends a maiden to heal hero"
#define MSG_SENDS_A_WOLF_TO_AID_HERO_STR "sends a wolf to aid hero"
#define MSG_SELECT_STR "Select"
#define MSG_SELECT_ATTACKERS_STR "select attackers"
#define MSG_SELECT_DEFENDER_STR "select defender"
#define MSG_SELECT_DESTINATION_STR "select destination"
#define MSG_SELECT_PASSENGERS_STR "select passengers"
#define MSG_S_W_J_T_P_STR "select which jarl to promote"
#define MSG_S_ENEMY_STR "'s enemy"
#define MSG_S_E_B_A_1_T_T_S_STR "'s enemy by adding 1 to their strength"
#define MSG_S_E_B_A_3_T_T_S_STR "'s enemy by adding 3 to their strength"
#define MSG_S_HERO_STR "'s hero"
#define MSG_SHIRT_1_STR "It adds +1 to the combat strength of the"
#define MSG_SHIRT_2_STR "wearer when he is defending. It also adds"
#define MSG_SHIRT_3_STR "+1 to the movement factor of the wearer."
#define MSG_SHORTCUT_GAME_SUMMARY_STR "G"
#define MSG_SHORTCUT_S_T_B_STR "B"
#define MSG_SHOW_TITLEBAR_STR "Show titlebar?"
#define MSG_S_JARL_STR "'s jarl"
#define MSG_S_KINGDOM_STR "'s kingdom"
#define MSG_S_M_R_STR "Screen Mode Requester"
#define MSG_S_NEXT_WOUND_STR "'s next wound"
#define MSG_S_NEXT_TWO_WOUNDS_STR "'s next two wounds"
#define MSG_SPECIAL_STR "Special"
#define MSG_S_R_A_S_B_H_T_O_T_B_STR "'s ravens are sent by him to observe the battle"
#define MSG_S_RUNE_PROTECTS_HIM_STR "'s rune protects him"
#define MSG_STATUS_STR "Status"
#define MSG_S_A_P_O_L_F_H_STR "steals a point of luck from hero"
#define MSG_SUMMARYLINE_STR "Hero Name  C-M J K S T C S R Glry Luck $$$$"
#define MSG_SWORD_STR "Sword"
#define MSG_SWORD_NAME_STR "Sword Name"
#define MSG_S_WOUND_STR "'s wound"
#define MSG_SYGIL_1_STR "Every time a spell is cast at the hero"
#define MSG_SYGIL_2_STR "who has this rune, it may not affect the"
#define MSG_SYGIL_3_STR "hero (though it may affect those in the"
#define MSG_SYGIL_4_STR "same area with him)."
#define MSG_TAKES_STR "takes"
#define MSG_TAKES_SWORD_STR "takes sword"
#define MSG_TAKES_THE_STR "takes the"
#define MSG_TAKE_SWORD_STR "take sword"
#define MSG_TAKE_THE_STR "take the"
#define MSG_TAXATION_FACTOR_STR "Taxation Factor"
#define MSG_TELEPORT_SCROLL_STR "Teleport Scroll"
#define MSG_THE_STR "The"
#define MSG_THE_GODS_STR "rune of the gods"
#define MSG_THE_SUN_STR "rune of the sun"
#define MSG_THIS_TURN_STR "this turn"
#define MSG_TIME_STR "rune of time"
#define MSG_TO_MOVE_BY_SEA_NEXT_TURN_STR "to move by sea next turn"
#define MSG_TREASURE_STR "Treasure"
#define MSG_TREASURE2_STR "treasure"
#define MSG_TREASURE_NAME_STR "Treasure Name"
#define MSG_TROLL_STR "Troll"
#define MSG_TURN_STR "Turn"
#define MSG_TURNS_STR "Turns"
#define MSG_TYPE_STR "Type"
#define MSG_UNCHAR_GLORY_STR "lory"
#define MSG_UNCHAR_LUCK_STR "luck"
#define MSG_UNCHAR_NO_STR "o"
#define MSG_UNCHAR_RESTART_STR "estart"
#define MSG_UNCHAR_TRANSFER_STR "ransfer"
#define MSG_UNCHAR_WITHDRAW_STR "ithdraw"
#define MSG_UNCHAR_YES_STR "es"
#define MSG_UNKNOWN_STR "Unknown"
#define MSG_UNKNOWN_JARL_STR "Unknown jarl"
#define MSG_USAGE_STR "Usage"
#define MSG_USED_STR "used"
#define MSG_USE_LUCK_STR "use luck"
#define MSG_WEALTH_STR "Wealth"
#define MSG_W_S_A_M_T_H_H_STR "will send a maiden to heal hero"
#define MSG_WINS_STR "wins"
#define MSG_WITCH_STR "Witch"
#define MSG_WITH_STR "with"
#define MSG_WITHDRAW_STR "Withdraw"
#define MSG_WITHDRAWS_FROM_PLAY_STR "withdraws from play"
#define MSG_WOUNDED_STR "Wounded"
#define MSG_WOUNDING_STR "wounding"
#define MSG_WYNN_1_STR "Forces all of the heroes and jarls in the"
#define MSG_WYNN_2_STR "area to flee."
#define MSG_YES_STR "Yes"
#define MSG_YOU_MUST_FIGHT_A_MONSTER_STR "you must fight a monster"
#define MSG_YR_1_STR "Causes all counters in the area (except"
#define MSG_YR_2_STR "face down jarls or monster counters) to"
#define MSG_YR_3_STR "be wounded."
#define MSG_TRANSLATOR1_STR "English translation by"
#define MSG_TRANSLATOR2_STR "James Jacobs"
#define MSG_PRESS_HELP_FOR_INFO_STR "Press Help for info."
#define MSG_PROCESSNUMBER_STR "Process number:"
#define MSG_QUITTITLE_STR "Quit to title screen"
#define MSG_RIDES_THE_STR "rides the"
#define MSG_DRINKS_THE_STR "drinks the"
#define MSG_SCORE_STR "Score"
#define MSG_INVISIBILITYRING_STR "Invisibility Ring"
#define MSG_RING_1_STR "The ring gives a half chance of avoiding"
#define MSG_RING_2_STR "a combat, when its wearer is being"
#define MSG_RING_3_STR "attacked."
#define MSG_MAGICCROWN_STR "Magic Crown"
#define MSG_CROWN_1_STR "There is a half chance per turn per"
#define MSG_CROWN_2_STR "kingdom that an abandoned kingdom will"
#define MSG_CROWN_3_STR "remain loyal to the crown's wearer."
#define MSG_WEAR_THE_STR "wear the"
#define MSG_WEARS_THE_STR "wears the"
#define MSG_ESCAPES_STR "escapes"
#define MSG_FAILS_TO_ESCAPE_STR "fails to escape"
#define MSG_W_A_M_STR "Watch Amiga movements?"
#define MSG_SHORTCUT_W_A_M_STR "W"
#define MSG_HELPHAIL_1_STR "Runes"
#define MSG_HELPHAIL_2_STR "Spells"
#define MSG_HELPHAIL_3_STR "Swords"
#define MSG_HELPHAIL_4_STR "Treasures"
#define MSG_APPDESC_STR "Board game"
#define MSG_COMPILEDFOR_STR "Compiled for:"
#define MSG_RUNNINGON_STR "Running on:"
#define MSG_PRIORITY_STR "Priority:"
#define MSG_RECOVERABLE_STR "Recoverable Error"
#define MSG_FATAL_STR "Fatal Error"
#define MSG_QUIT2_STR "Quit"
#define MSG_PILES_STR "Piles"
#define MSG_LMB_STR "LMB="
#define MSG_RMB_STR "RMB="
#define MSG_INFINITE_STR "Infinite"
#define MSG_SECS_STR "%d.%d secs"
#define MSG_WHATSCREEN_STR "What screen do you want to run the game on?"
#define MSG_CUSTOMWB_STR "Custom screen|Workbench screen"
#define MSG_PUBSCREEN_STR "Public screen name:"
#define MSG_BACKSPACE_STR "Backspace to redo"
#define MSG_CANTLOCK_NAMED_STR "Can't lock public screen \"%s\"!"
#define MSG_CANTLOCK_DEFAULT_STR "Can't lock default public screen!"
#define MSG_MENU_PROJECT_STR "Project"
#define MSG_MENU_NEW_STR "New"
#define MSG_KEY_NEW_STR "N"
#define MSG_MENU_OPEN_STR "Open..."
#define MSG_KEY_OPEN_STR "O"
#define MSG_MENU_SAVE1_STR "Save"
#define MSG_KEY_SAVE_STR "S"
#define MSG_MENU_SAVEAS_STR "Save As..."
#define MSG_KEY_SAVEAS_STR "A"
#define MSG_KEY_QUIT_STR "Q"
#define MSG_MENU_SETTINGS_STR "Settings"
#define MSG_MENU_HELP_STR "Help"
#define MSG_MENU_MANUAL_STR "Manual..."
#define MSG_KEY_MANUAL_STR "M"
#define MSG_KEY_ABOUT_STR "?"

#endif /* CATCOMP_STRINGS */


/****************************************************************************/


#ifdef CATCOMP_ARRAY

struct CatCompArrayType
{
    LONG   cca_ID;
    STRPTR cca_Str;
};

static const struct CatCompArrayType CatCompArray[] =
{
    {FILENAME_MANUAL,(STRPTR)FILENAME_MANUAL_STR},
    {MSG_ABOUT,(STRPTR)MSG_ABOUT_STR},
    {MSG_ABOUT2,(STRPTR)MSG_ABOUT2_STR},
    {MSG_ADVANCED_MODE,(STRPTR)MSG_ADVANCED_MODE_STR},
    {MSG_AIDS_HERO,(STRPTR)MSG_AIDS_HERO_STR},
    {MSG_AMSIR_1,(STRPTR)MSG_AMSIR_1_STR},
    {MSG_AMSIR_2,(STRPTR)MSG_AMSIR_2_STR},
    {MSG_A_P_O_L_F_H_D,(STRPTR)MSG_A_P_O_L_F_H_D_STR},
    {MSG_AS_A_GIFT,(STRPTR)MSG_AS_A_GIFT_STR},
    {MSG_AS_DUE_TRIBUTE,(STRPTR)MSG_AS_DUE_TRIBUTE_STR},
    {MSG_ATLANTIC_OCEAN,(STRPTR)MSG_ATLANTIC_OCEAN_STR},
    {MSG_ATTACKERS,(STRPTR)MSG_ATTACKERS_STR},
    {MSG_ATTACKERS_FLEE,(STRPTR)MSG_ATTACKERS_FLEE_STR},
    {MSG_ATTACKERS_KILLED,(STRPTR)MSG_ATTACKERS_KILLED_STR},
    {MSG_ATTACKERS_WOUNDED,(STRPTR)MSG_ATTACKERS_WOUNDED_STR},
    {MSG_ATTACKING,(STRPTR)MSG_ATTACKING_STR},
    {MSG_ATTACKS,(STRPTR)MSG_ATTACKS_STR},
    {MSG_BALMUNG_1,(STRPTR)MSG_BALMUNG_1_STR},
    {MSG_BALMUNG_2,(STRPTR)MSG_BALMUNG_2_STR},
    {MSG_BALMUNG_3,(STRPTR)MSG_BALMUNG_3_STR},
    {MSG_BALMUNG_4,(STRPTR)MSG_BALMUNG_4_STR},
    {MSG_BALMUNG_5,(STRPTR)MSG_BALMUNG_5_STR},
    {MSG_BALTIC_SEA,(STRPTR)MSG_BALTIC_SEA_STR},
    {MSG_BROSUNG_NECKLACE,(STRPTR)MSG_BROSUNG_NECKLACE_STR},
    {MSG_BUT_IT_FIZZLES,(STRPTR)MSG_BUT_IT_FIZZLES_STR},
    {MSG_BY,(STRPTR)MSG_BY_STR},
    {MSG_BY_ADDING_1_TO_HIS_STRENGTH,(STRPTR)MSG_BY_ADDING_1_TO_HIS_STRENGTH_STR},
    {MSG_BY_ADDING_2_TO_HIS_STRENGTH,(STRPTR)MSG_BY_ADDING_2_TO_HIS_STRENGTH_STR},
    {MSG_BY_ADDING_3_TO_HIS_STRENGTH,(STRPTR)MSG_BY_ADDING_3_TO_HIS_STRENGTH_STR},
    {MSG_B_A_1_T_T_S_O_E_P_O_H_S,(STRPTR)MSG_B_A_1_T_T_S_O_E_P_O_H_S_STR},
    {MSG_B_E_W_H_G_2_G,(STRPTR)MSG_B_E_W_H_G_2_G_STR},
    {MSG_B_S_T_H_G_1_G,(STRPTR)MSG_B_S_T_H_G_1_G_STR},
    {MSG_CALL_FOR_AID,(STRPTR)MSG_CALL_FOR_AID_STR},
    {MSG_CANCEL,(STRPTR)MSG_CANCEL_STR},
    {MSG_CANT_OPEN,(STRPTR)MSG_CANT_OPEN_STR},
    {MSG_CANT_READ_FROM,(STRPTR)MSG_CANT_READ_FROM_STR},
    {MSG_CANT_WRITE_TO,(STRPTR)MSG_CANT_WRITE_TO_STR},
    {MSG_CASTS,(STRPTR)MSG_CASTS_STR},
    {MSG_CHAR_DEAD,(STRPTR)MSG_CHAR_DEAD_STR},
    {MSG_CHAR_GLORY,(STRPTR)MSG_CHAR_GLORY_STR},
    {MSG_CHAR_HEALTHY,(STRPTR)MSG_CHAR_HEALTHY_STR},
    {MSG_CHAR_HUMAN,(STRPTR)MSG_CHAR_HUMAN_STR},
    {MSG_CHAR_LUCK,(STRPTR)MSG_CHAR_LUCK_STR},
    {MSG_CHAR_NO,(STRPTR)MSG_CHAR_NO_STR},
    {MSG_CHAR_RESTART,(STRPTR)MSG_CHAR_RESTART_STR},
    {MSG_CHAR_TRANSFER,(STRPTR)MSG_CHAR_TRANSFER_STR},
    {MSG_CHAR_WITHDRAW,(STRPTR)MSG_CHAR_WITHDRAW_STR},
    {MSG_CHAR_WOUNDED,(STRPTR)MSG_CHAR_WOUNDED_STR},
    {MSG_CHAR_YES,(STRPTR)MSG_CHAR_YES_STR},
    {MSG_COAT_1,(STRPTR)MSG_COAT_1_STR},
    {MSG_COAT_2,(STRPTR)MSG_COAT_2_STR},
    {MSG_COAT_3,(STRPTR)MSG_COAT_3_STR},
    {MSG_COMBAT_STRENGTH,(STRPTR)MSG_COMBAT_STRENGTH_STR},
    {MSG_CONQUERED_KINGDOMS,(STRPTR)MSG_CONQUERED_KINGDOMS_STR},
    {MSG_CONSIDERS_ATTACKS,(STRPTR)MSG_CONSIDERS_ATTACKS_STR},
    {MSG_CONTENTS,(STRPTR)MSG_CONTENTS_STR},
    {MSG_CONTROL,(STRPTR)MSG_CONTROL_STR},
    {MSG_DEAD_HERO,(STRPTR)MSG_DEAD_HERO_STR},
    {MSG_DECIDES_THAT_HERO,(STRPTR)MSG_DECIDES_THAT_HERO_STR},
    {MSG_D_T_T_F_I_B_F,(STRPTR)MSG_D_T_T_F_I_B_F_STR},
    {MSG_DEFENDERS,(STRPTR)MSG_DEFENDERS_STR},
    {MSG_DEFENDERS_FLEE,(STRPTR)MSG_DEFENDERS_FLEE_STR},
    {MSG_DEFENDERS_KILLED,(STRPTR)MSG_DEFENDERS_KILLED_STR},
    {MSG_DEFENDERS_WOUNDED,(STRPTR)MSG_DEFENDERS_WOUNDED_STR},
    {MSG_DEFENDING,(STRPTR)MSG_DEFENDING_STR},
    {MSG_DESERVES_NO_REWARD,(STRPTR)MSG_DESERVES_NO_REWARD_STR},
    {MSG_DRAGON,(STRPTR)MSG_DRAGON_STR},
    {MSG_DRINK_THE,(STRPTR)MSG_DRINK_THE_STR},
    {MSG_DROW,(STRPTR)MSG_DROW_STR},
    {MSG_ENGLISH_CHANNEL,(STRPTR)MSG_ENGLISH_CHANNEL_STR},
    {MSG_EON_1,(STRPTR)MSG_EON_1_STR},
    {MSG_EXCHANGE_THE,(STRPTR)MSG_EXCHANGE_THE_STR},
    {MSG_FAXI_1,(STRPTR)MSG_FAXI_1_STR},
    {MSG_FAXI_2,(STRPTR)MSG_FAXI_2_STR},
    {MSG_FAXI_3,(STRPTR)MSG_FAXI_3_STR},
    {MSG_FINDS,(STRPTR)MSG_FINDS_STR},
    {MSG_FINDS_THE,(STRPTR)MSG_FINDS_THE_STR},
    {MSG_FINISH,(STRPTR)MSG_FINISH_STR},
    {MSG_FLEEING,(STRPTR)MSG_FLEEING_STR},
    {MSG_FOR,(STRPTR)MSG_FOR_STR},
    {MSG_FOR_READING,(STRPTR)MSG_FOR_READING_STR},
    {MSG_FOR_WRITING,(STRPTR)MSG_FOR_WRITING_STR},
    {MSG_FROM,(STRPTR)MSG_FROM_STR},
    {MSG_F_T_B_S_N_T,(STRPTR)MSG_F_T_B_S_N_T_STR},
    {MSG_FURY,(STRPTR)MSG_FURY_STR},
    {MSG_GADGET_NONE,(STRPTR)MSG_GADGET_NONE_STR},
    {MSG_GAIN,(STRPTR)MSG_GAIN_STR},
    {MSG_GAME_OVER,(STRPTR)MSG_GAME_OVER_STR},
    {MSG_GAME_SUMMARY,(STRPTR)MSG_GAME_SUMMARY_STR},
    {MSG_GAME_SUMMARY2,(STRPTR)MSG_GAME_SUMMARY2_STR},
    {MSG_GEOFU_1,(STRPTR)MSG_GEOFU_1_STR},
    {MSG_GEOFU_2,(STRPTR)MSG_GEOFU_2_STR},
    {MSG_GEOFU_3,(STRPTR)MSG_GEOFU_3_STR},
    {MSG_GEOFU_4,(STRPTR)MSG_GEOFU_4_STR},
    {MSG_GIANT,(STRPTR)MSG_GIANT_STR},
    {MSG_GAVE,(STRPTR)MSG_GAVE_STR},
    {MSG_GIVES,(STRPTR)MSG_GIVES_STR},
    {MSG_GHOST,(STRPTR)MSG_GHOST_STR},
    {MSG_GOD,(STRPTR)MSG_GOD_STR},
    {MSG_GOLDEN_MARKS,(STRPTR)MSG_GOLDEN_MARKS_STR},
    {MSG_GOLDEN_MARKS_FROM_HERO,(STRPTR)MSG_GOLDEN_MARKS_FROM_HERO_STR},
    {MSG_GOLDEN_MARKS_TO_HERO,(STRPTR)MSG_GOLDEN_MARKS_TO_HERO_STR},
    {MSG_HAS_THE_SWORD,(STRPTR)MSG_HAS_THE_SWORD_STR},
    {MSG_HEALING_POTION,(STRPTR)MSG_HEALING_POTION_STR},
    {MSG_HEALTHY,(STRPTR)MSG_HEALTHY_STR},
    {MSG_HYDRA,(STRPTR)MSG_HYDRA_STR},
    {MSG_GLORY,(STRPTR)MSG_GLORY_STR},
    {MSG_GRANTS_HERO,(STRPTR)MSG_GRANTS_HERO_STR},
    {MSG_HAGALL_1,(STRPTR)MSG_HAGALL_1_STR},
    {MSG_HAGALL_2,(STRPTR)MSG_HAGALL_2_STR},
    {MSG_HAGALL_3,(STRPTR)MSG_HAGALL_3_STR},
    {MSG_HAGALL_4,(STRPTR)MSG_HAGALL_4_STR},
    {MSG_HAGALL_5,(STRPTR)MSG_HAGALL_5_STR},
    {MSG_HAIL,(STRPTR)MSG_HAIL_STR},
    {MSG_H_A_F,(STRPTR)MSG_H_A_F_STR},
    {MSG_HAS_BEEN_OVERRUN,(STRPTR)MSG_HAS_BEEN_OVERRUN_STR},
    {MSG_HAS_CONQUERED_KINGDOM,(STRPTR)MSG_HAS_CONQUERED_KINGDOM_STR},
    {MSG_HEALING,(STRPTR)MSG_HEALING_STR},
    {MSG_HEALS,(STRPTR)MSG_HEALS_STR},
    {MSG_HEARD_THE_PRAYER_OF_HERO,(STRPTR)MSG_HEARD_THE_PRAYER_OF_HERO_STR},
    {MSG_HELP_1,(STRPTR)MSG_HELP_1_STR},
    {MSG_HELP_2,(STRPTR)MSG_HELP_2_STR},
    {MSG_HELP_3,(STRPTR)MSG_HELP_3_STR},
    {MSG_HELP_4,(STRPTR)MSG_HELP_4_STR},
    {MSG_HERO,(STRPTR)MSG_HERO_STR},
    {MSG_HERO2,(STRPTR)MSG_HERO2_STR},
    {MSG_HERO_NAME,(STRPTR)MSG_HERO_NAME_STR},
    {MSG_HOMELAND,(STRPTR)MSG_HOMELAND_STR},
    {MSG_HONOURS_HERO,(STRPTR)MSG_HONOURS_HERO_STR},
    {MSG_HRUNTING_1,(STRPTR)MSG_HRUNTING_1_STR},
    {MSG_HRUNTING_2,(STRPTR)MSG_HRUNTING_2_STR},
    {MSG_HRUNTING_3,(STRPTR)MSG_HRUNTING_3_STR},
    {MSG_HUMAN,(STRPTR)MSG_HUMAN_STR},
    {MSG_ICE,(STRPTR)MSG_ICE_STR},
    {MSG_IN,(STRPTR)MSG_IN_STR},
    {MSG_INFORMATION,(STRPTR)MSG_INFORMATION_STR},
    {MSG_ING_1,(STRPTR)MSG_ING_1_STR},
    {MSG_ING_2,(STRPTR)MSG_ING_2_STR},
    {MSG_INTERVENES_PERSONALLY,(STRPTR)MSG_INTERVENES_PERSONALLY_STR},
    {MSG_IRISH_SEA,(STRPTR)MSG_IRISH_SEA_STR},
    {MSG_IS_1,(STRPTR)MSG_IS_1_STR},
    {MSG_IS_2,(STRPTR)MSG_IS_2_STR},
    {MSG_IS_3,(STRPTR)MSG_IS_3_STR},
    {MSG_IS_BEING_ROUTED,(STRPTR)MSG_IS_BEING_ROUTED_STR},
    {MSG_IS_COVERED_WITH_ICE,(STRPTR)MSG_IS_COVERED_WITH_ICE_STR},
    {MSG_IS_KILLED,(STRPTR)MSG_IS_KILLED_STR},
    {MSG_ISLAND,(STRPTR)MSG_ISLAND_STR},
    {MSG_IS_MOVING,(STRPTR)MSG_IS_MOVING_STR},
    {MSG_I_N_A_V_S_G_F,(STRPTR)MSG_I_N_A_V_S_G_F_STR},
    {MSG_IS_ROUTED,(STRPTR)MSG_IS_ROUTED_STR},
    {MSG_IS_WOUNDED,(STRPTR)MSG_IS_WOUNDED_STR},
    {MSG_JARA_1,(STRPTR)MSG_JARA_1_STR},
    {MSG_JARL,(STRPTR)MSG_JARL_STR},
    {MSG_JARL2,(STRPTR)MSG_JARL2_STR},
    {MSG_JARL_NAME,(STRPTR)MSG_JARL_NAME_STR},
    {MSG_KING,(STRPTR)MSG_KING_STR},
    {MSG_KINGDOM,(STRPTR)MSG_KINGDOM_STR},
    {MSG_KINGDOM2,(STRPTR)MSG_KINGDOM2_STR},
    {MSG_KINGDOM_NAME,(STRPTR)MSG_KINGDOM_NAME_STR},
    {MSG_KING_NONE,(STRPTR)MSG_KING_NONE_STR},
    {MSG_KRAKEN,(STRPTR)MSG_KRAKEN_STR},
    {MSG_LAND,(STRPTR)MSG_LAND_STR},
    {MSG_LEARNS_THE_RUNE,(STRPTR)MSG_LEARNS_THE_RUNE_STR},
    {MSG_LOAD_GAME,(STRPTR)MSG_LOAD_GAME_STR},
    {MSG_LOADED,(STRPTR)MSG_LOADED_STR},
    {MSG_LOADING,(STRPTR)MSG_LOADING_STR},
    {MSG_LOCATION,(STRPTR)MSG_LOCATION_STR},
    {MSG_LOSE,(STRPTR)MSG_LOSE_STR},
    {MSG_LOSE_TURN,(STRPTR)MSG_LOSE_TURN_STR},
    {MSG_LOSE_NEXT_TURN,(STRPTR)MSG_LOSE_NEXT_TURN_STR},
    {MSG_LOVI_1,(STRPTR)MSG_LOVI_1_STR},
    {MSG_LOVI_2,(STRPTR)MSG_LOVI_2_STR},
    {MSG_LOVI_3,(STRPTR)MSG_LOVI_3_STR},
    {MSG_LUCK,(STRPTR)MSG_LUCK_STR},
    {MSG_LUCK2,(STRPTR)MSG_LUCK2_STR},
    {MSG_MAIL_COAT,(STRPTR)MSG_MAIL_COAT_STR},
    {MSG_MAGIC_SHIRT,(STRPTR)MSG_MAGIC_SHIRT_STR},
    {MSG_MAGIC_TREASURES,(STRPTR)MSG_MAGIC_TREASURES_STR},
    {MSG_MAIDENS,(STRPTR)MSG_MAIDENS_STR},
    {MSG_M_N_T_B_S_T_T,(STRPTR)MSG_M_N_T_B_S_T_T_STR},
    {MSG_MESSAGE_DELAY,(STRPTR)MSG_MESSAGE_DELAY_STR},
    {MSG_MONSTER_NAME,(STRPTR)MSG_MONSTER_NAME_STR},
    {MSG_MONSTER_SPECIES,(STRPTR)MSG_MONSTER_SPECIES_STR},
    {MSG_MOVE,(STRPTR)MSG_MOVE_STR},
    {MSG_MOVE2,(STRPTR)MSG_MOVE2_STR},
    {MSG_MOVE_BY_SEA,(STRPTR)MSG_MOVE_BY_SEA_STR},
    {MSG_MOVEMENT_FACTOR,(STRPTR)MSG_MOVEMENT_FACTOR_STR},
    {MSG_N_A,(STRPTR)MSG_N_A_STR},
    {MSG_NECKLACE_1,(STRPTR)MSG_NECKLACE_1_STR},
    {MSG_NECKLACE_2,(STRPTR)MSG_NECKLACE_2_STR},
    {MSG_NECKLACE_3,(STRPTR)MSG_NECKLACE_3_STR},
    {MSG_NECKLACE_4,(STRPTR)MSG_NECKLACE_4_STR},
    {MSG_NECKLACE_5,(STRPTR)MSG_NECKLACE_5_STR},
    {MSG_NECKLACE_6,(STRPTR)MSG_NECKLACE_6_STR},
    {MSG_NECKLACE_7,(STRPTR)MSG_NECKLACE_7_STR},
    {MSG_NIED_1,(STRPTR)MSG_NIED_1_STR},
    {MSG_NIED_2,(STRPTR)MSG_NIED_2_STR},
    {MSG_NIED_3,(STRPTR)MSG_NIED_3_STR},
    {MSG_NO,(STRPTR)MSG_NO_STR},
    {MSG_NONE,(STRPTR)MSG_NONE_STR},
    {MSG_NO_RESULT,(STRPTR)MSG_NO_RESULT_STR},
    {MSG_N_R_A_L_N_T,(STRPTR)MSG_N_R_A_L_N_T_STR},
    {MSG_NORTH_SEA,(STRPTR)MSG_NORTH_SEA_STR},
    {MSG_NO_SPECIAL_POWERS,(STRPTR)MSG_NO_SPECIAL_POWERS_STR},
    {MSG_OF,(STRPTR)MSG_OF_STR},
    {MSG_OGAL_1,(STRPTR)MSG_OGAL_1_STR},
    {MSG_OK,(STRPTR)MSG_OK_STR},
    {MSG_OR,(STRPTR)MSG_OR_STR},
    {MSG_PENINSULA,(STRPTR)MSG_PENINSULA_STR},
    {MSG_POTION_1,(STRPTR)MSG_POTION_1_STR},
    {MSG_POTION_2,(STRPTR)MSG_POTION_2_STR},
    {MSG_POTION_3,(STRPTR)MSG_POTION_3_STR},
    {MSG_PREVENTS_HERO,(STRPTR)MSG_PREVENTS_HERO_STR},
    {MSG_PROMOTES_JARL,(STRPTR)MSG_PROMOTES_JARL_STR},
    {MSG_PROPERTY,(STRPTR)MSG_PROPERTY_STR},
    {MSG_MENU_QUITWB,(STRPTR)MSG_MENU_QUITWB_STR},
    {MSG_READ_THE,(STRPTR)MSG_READ_THE_STR},
    {MSG_RECRUITED_JARLS,(STRPTR)MSG_RECRUITED_JARLS_STR},
    {MSG_RECRUIT_JARL,(STRPTR)MSG_RECRUIT_JARL_STR},
    {MSG_RECRUITS_JARL,(STRPTR)MSG_RECRUITS_JARL_STR},
    {MSG_RESTART,(STRPTR)MSG_RESTART_STR},
    {MSG_RESTARTS,(STRPTR)MSG_RESTARTS_STR},
    {MSG_RETURN_START_GAME,(STRPTR)MSG_RETURN_START_GAME_STR},
    {MSG_REWARDS_HERO,(STRPTR)MSG_REWARDS_HERO_STR},
    {MSG_RIDE,(STRPTR)MSG_RIDE_STR},
    {MSG_RIDES,(STRPTR)MSG_RIDES_STR},
    {MSG_RIDES2,(STRPTR)MSG_RIDES2_STR},
    {MSG_RIDE_THE,(STRPTR)MSG_RIDE_THE_STR},
    {MSG_ROLL,(STRPTR)MSG_ROLL_STR},
    {MSG_ROUT,(STRPTR)MSG_ROUT_STR},
    {MSG_ROUTED,(STRPTR)MSG_ROUTED_STR},
    {MSG_RUNE,(STRPTR)MSG_RUNE_STR},
    {MSG_S,(STRPTR)MSG_S_STR},
    {MSG_SAVED,(STRPTR)MSG_SAVED_STR},
    {MSG_SAVE_GAME,(STRPTR)MSG_SAVE_GAME_STR},
    {MSG_SAVING,(STRPTR)MSG_SAVING_STR},
    {MSG_SCROLL_1,(STRPTR)MSG_SCROLL_1_STR},
    {MSG_SCROLL_2,(STRPTR)MSG_SCROLL_2_STR},
    {MSG_SCROLL_3,(STRPTR)MSG_SCROLL_3_STR},
    {MSG_SEA,(STRPTR)MSG_SEA_STR},
    {MSG_SEA_SERPENT,(STRPTR)MSG_SEA_SERPENT_STR},
    {MSG_SENDS_A_MAIDEN_TO_HEAL_HERO,(STRPTR)MSG_SENDS_A_MAIDEN_TO_HEAL_HERO_STR},
    {MSG_SENDS_A_WOLF_TO_AID_HERO,(STRPTR)MSG_SENDS_A_WOLF_TO_AID_HERO_STR},
    {MSG_SELECT,(STRPTR)MSG_SELECT_STR},
    {MSG_SELECT_ATTACKERS,(STRPTR)MSG_SELECT_ATTACKERS_STR},
    {MSG_SELECT_DEFENDER,(STRPTR)MSG_SELECT_DEFENDER_STR},
    {MSG_SELECT_DESTINATION,(STRPTR)MSG_SELECT_DESTINATION_STR},
    {MSG_SELECT_PASSENGERS,(STRPTR)MSG_SELECT_PASSENGERS_STR},
    {MSG_S_W_J_T_P,(STRPTR)MSG_S_W_J_T_P_STR},
    {MSG_S_ENEMY,(STRPTR)MSG_S_ENEMY_STR},
    {MSG_S_E_B_A_1_T_T_S,(STRPTR)MSG_S_E_B_A_1_T_T_S_STR},
    {MSG_S_E_B_A_3_T_T_S,(STRPTR)MSG_S_E_B_A_3_T_T_S_STR},
    {MSG_S_HERO,(STRPTR)MSG_S_HERO_STR},
    {MSG_SHIRT_1,(STRPTR)MSG_SHIRT_1_STR},
    {MSG_SHIRT_2,(STRPTR)MSG_SHIRT_2_STR},
    {MSG_SHIRT_3,(STRPTR)MSG_SHIRT_3_STR},
    {MSG_SHORTCUT_GAME_SUMMARY,(STRPTR)MSG_SHORTCUT_GAME_SUMMARY_STR},
    {MSG_SHORTCUT_S_T_B,(STRPTR)MSG_SHORTCUT_S_T_B_STR},
    {MSG_SHOW_TITLEBAR,(STRPTR)MSG_SHOW_TITLEBAR_STR},
    {MSG_S_JARL,(STRPTR)MSG_S_JARL_STR},
    {MSG_S_KINGDOM,(STRPTR)MSG_S_KINGDOM_STR},
    {MSG_S_M_R,(STRPTR)MSG_S_M_R_STR},
    {MSG_S_NEXT_WOUND,(STRPTR)MSG_S_NEXT_WOUND_STR},
    {MSG_S_NEXT_TWO_WOUNDS,(STRPTR)MSG_S_NEXT_TWO_WOUNDS_STR},
    {MSG_SPECIAL,(STRPTR)MSG_SPECIAL_STR},
    {MSG_S_R_A_S_B_H_T_O_T_B,(STRPTR)MSG_S_R_A_S_B_H_T_O_T_B_STR},
    {MSG_S_RUNE_PROTECTS_HIM,(STRPTR)MSG_S_RUNE_PROTECTS_HIM_STR},
    {MSG_STATUS,(STRPTR)MSG_STATUS_STR},
    {MSG_S_A_P_O_L_F_H,(STRPTR)MSG_S_A_P_O_L_F_H_STR},
    {MSG_SUMMARYLINE,(STRPTR)MSG_SUMMARYLINE_STR},
    {MSG_SWORD,(STRPTR)MSG_SWORD_STR},
    {MSG_SWORD_NAME,(STRPTR)MSG_SWORD_NAME_STR},
    {MSG_S_WOUND,(STRPTR)MSG_S_WOUND_STR},
    {MSG_SYGIL_1,(STRPTR)MSG_SYGIL_1_STR},
    {MSG_SYGIL_2,(STRPTR)MSG_SYGIL_2_STR},
    {MSG_SYGIL_3,(STRPTR)MSG_SYGIL_3_STR},
    {MSG_SYGIL_4,(STRPTR)MSG_SYGIL_4_STR},
    {MSG_TAKES,(STRPTR)MSG_TAKES_STR},
    {MSG_TAKES_SWORD,(STRPTR)MSG_TAKES_SWORD_STR},
    {MSG_TAKES_THE,(STRPTR)MSG_TAKES_THE_STR},
    {MSG_TAKE_SWORD,(STRPTR)MSG_TAKE_SWORD_STR},
    {MSG_TAKE_THE,(STRPTR)MSG_TAKE_THE_STR},
    {MSG_TAXATION_FACTOR,(STRPTR)MSG_TAXATION_FACTOR_STR},
    {MSG_TELEPORT_SCROLL,(STRPTR)MSG_TELEPORT_SCROLL_STR},
    {MSG_THE,(STRPTR)MSG_THE_STR},
    {MSG_THE_GODS,(STRPTR)MSG_THE_GODS_STR},
    {MSG_THE_SUN,(STRPTR)MSG_THE_SUN_STR},
    {MSG_THIS_TURN,(STRPTR)MSG_THIS_TURN_STR},
    {MSG_TIME,(STRPTR)MSG_TIME_STR},
    {MSG_TO_MOVE_BY_SEA_NEXT_TURN,(STRPTR)MSG_TO_MOVE_BY_SEA_NEXT_TURN_STR},
    {MSG_TREASURE,(STRPTR)MSG_TREASURE_STR},
    {MSG_TREASURE2,(STRPTR)MSG_TREASURE2_STR},
    {MSG_TREASURE_NAME,(STRPTR)MSG_TREASURE_NAME_STR},
    {MSG_TROLL,(STRPTR)MSG_TROLL_STR},
    {MSG_TURN,(STRPTR)MSG_TURN_STR},
    {MSG_TURNS,(STRPTR)MSG_TURNS_STR},
    {MSG_TYPE,(STRPTR)MSG_TYPE_STR},
    {MSG_UNCHAR_GLORY,(STRPTR)MSG_UNCHAR_GLORY_STR},
    {MSG_UNCHAR_LUCK,(STRPTR)MSG_UNCHAR_LUCK_STR},
    {MSG_UNCHAR_NO,(STRPTR)MSG_UNCHAR_NO_STR},
    {MSG_UNCHAR_RESTART,(STRPTR)MSG_UNCHAR_RESTART_STR},
    {MSG_UNCHAR_TRANSFER,(STRPTR)MSG_UNCHAR_TRANSFER_STR},
    {MSG_UNCHAR_WITHDRAW,(STRPTR)MSG_UNCHAR_WITHDRAW_STR},
    {MSG_UNCHAR_YES,(STRPTR)MSG_UNCHAR_YES_STR},
    {MSG_UNKNOWN,(STRPTR)MSG_UNKNOWN_STR},
    {MSG_UNKNOWN_JARL,(STRPTR)MSG_UNKNOWN_JARL_STR},
    {MSG_USAGE,(STRPTR)MSG_USAGE_STR},
    {MSG_USED,(STRPTR)MSG_USED_STR},
    {MSG_USE_LUCK,(STRPTR)MSG_USE_LUCK_STR},
    {MSG_WEALTH,(STRPTR)MSG_WEALTH_STR},
    {MSG_W_S_A_M_T_H_H,(STRPTR)MSG_W_S_A_M_T_H_H_STR},
    {MSG_WINS,(STRPTR)MSG_WINS_STR},
    {MSG_WITCH,(STRPTR)MSG_WITCH_STR},
    {MSG_WITH,(STRPTR)MSG_WITH_STR},
    {MSG_WITHDRAW,(STRPTR)MSG_WITHDRAW_STR},
    {MSG_WITHDRAWS_FROM_PLAY,(STRPTR)MSG_WITHDRAWS_FROM_PLAY_STR},
    {MSG_WOUNDED,(STRPTR)MSG_WOUNDED_STR},
    {MSG_WOUNDING,(STRPTR)MSG_WOUNDING_STR},
    {MSG_WYNN_1,(STRPTR)MSG_WYNN_1_STR},
    {MSG_WYNN_2,(STRPTR)MSG_WYNN_2_STR},
    {MSG_YES,(STRPTR)MSG_YES_STR},
    {MSG_YOU_MUST_FIGHT_A_MONSTER,(STRPTR)MSG_YOU_MUST_FIGHT_A_MONSTER_STR},
    {MSG_YR_1,(STRPTR)MSG_YR_1_STR},
    {MSG_YR_2,(STRPTR)MSG_YR_2_STR},
    {MSG_YR_3,(STRPTR)MSG_YR_3_STR},
    {MSG_TRANSLATOR1,(STRPTR)MSG_TRANSLATOR1_STR},
    {MSG_TRANSLATOR2,(STRPTR)MSG_TRANSLATOR2_STR},
    {MSG_PRESS_HELP_FOR_INFO,(STRPTR)MSG_PRESS_HELP_FOR_INFO_STR},
    {MSG_PROCESSNUMBER,(STRPTR)MSG_PROCESSNUMBER_STR},
    {MSG_QUITTITLE,(STRPTR)MSG_QUITTITLE_STR},
    {MSG_RIDES_THE,(STRPTR)MSG_RIDES_THE_STR},
    {MSG_DRINKS_THE,(STRPTR)MSG_DRINKS_THE_STR},
    {MSG_SCORE,(STRPTR)MSG_SCORE_STR},
    {MSG_INVISIBILITYRING,(STRPTR)MSG_INVISIBILITYRING_STR},
    {MSG_RING_1,(STRPTR)MSG_RING_1_STR},
    {MSG_RING_2,(STRPTR)MSG_RING_2_STR},
    {MSG_RING_3,(STRPTR)MSG_RING_3_STR},
    {MSG_MAGICCROWN,(STRPTR)MSG_MAGICCROWN_STR},
    {MSG_CROWN_1,(STRPTR)MSG_CROWN_1_STR},
    {MSG_CROWN_2,(STRPTR)MSG_CROWN_2_STR},
    {MSG_CROWN_3,(STRPTR)MSG_CROWN_3_STR},
    {MSG_WEAR_THE,(STRPTR)MSG_WEAR_THE_STR},
    {MSG_WEARS_THE,(STRPTR)MSG_WEARS_THE_STR},
    {MSG_ESCAPES,(STRPTR)MSG_ESCAPES_STR},
    {MSG_FAILS_TO_ESCAPE,(STRPTR)MSG_FAILS_TO_ESCAPE_STR},
    {MSG_W_A_M,(STRPTR)MSG_W_A_M_STR},
    {MSG_SHORTCUT_W_A_M,(STRPTR)MSG_SHORTCUT_W_A_M_STR},
    {MSG_HELPHAIL_1,(STRPTR)MSG_HELPHAIL_1_STR},
    {MSG_HELPHAIL_2,(STRPTR)MSG_HELPHAIL_2_STR},
    {MSG_HELPHAIL_3,(STRPTR)MSG_HELPHAIL_3_STR},
    {MSG_HELPHAIL_4,(STRPTR)MSG_HELPHAIL_4_STR},
    {MSG_APPDESC,(STRPTR)MSG_APPDESC_STR},
    {MSG_COMPILEDFOR,(STRPTR)MSG_COMPILEDFOR_STR},
    {MSG_RUNNINGON,(STRPTR)MSG_RUNNINGON_STR},
    {MSG_PRIORITY,(STRPTR)MSG_PRIORITY_STR},
    {MSG_RECOVERABLE,(STRPTR)MSG_RECOVERABLE_STR},
    {MSG_FATAL,(STRPTR)MSG_FATAL_STR},
    {MSG_QUIT2,(STRPTR)MSG_QUIT2_STR},
    {MSG_PILES,(STRPTR)MSG_PILES_STR},
    {MSG_LMB,(STRPTR)MSG_LMB_STR},
    {MSG_RMB,(STRPTR)MSG_RMB_STR},
    {MSG_INFINITE,(STRPTR)MSG_INFINITE_STR},
    {MSG_SECS,(STRPTR)MSG_SECS_STR},
    {MSG_WHATSCREEN,(STRPTR)MSG_WHATSCREEN_STR},
    {MSG_CUSTOMWB,(STRPTR)MSG_CUSTOMWB_STR},
    {MSG_PUBSCREEN,(STRPTR)MSG_PUBSCREEN_STR},
    {MSG_BACKSPACE,(STRPTR)MSG_BACKSPACE_STR},
    {MSG_CANTLOCK_NAMED,(STRPTR)MSG_CANTLOCK_NAMED_STR},
    {MSG_CANTLOCK_DEFAULT,(STRPTR)MSG_CANTLOCK_DEFAULT_STR},
    {MSG_MENU_PROJECT,(STRPTR)MSG_MENU_PROJECT_STR},
    {MSG_MENU_NEW,(STRPTR)MSG_MENU_NEW_STR},
    {MSG_KEY_NEW,(STRPTR)MSG_KEY_NEW_STR},
    {MSG_MENU_OPEN,(STRPTR)MSG_MENU_OPEN_STR},
    {MSG_KEY_OPEN,(STRPTR)MSG_KEY_OPEN_STR},
    {MSG_MENU_SAVE1,(STRPTR)MSG_MENU_SAVE1_STR},
    {MSG_KEY_SAVE,(STRPTR)MSG_KEY_SAVE_STR},
    {MSG_MENU_SAVEAS,(STRPTR)MSG_MENU_SAVEAS_STR},
    {MSG_KEY_SAVEAS,(STRPTR)MSG_KEY_SAVEAS_STR},
    {MSG_KEY_QUIT,(STRPTR)MSG_KEY_QUIT_STR},
    {MSG_MENU_SETTINGS,(STRPTR)MSG_MENU_SETTINGS_STR},
    {MSG_MENU_HELP,(STRPTR)MSG_MENU_HELP_STR},
    {MSG_MENU_MANUAL,(STRPTR)MSG_MENU_MANUAL_STR},
    {MSG_KEY_MANUAL,(STRPTR)MSG_KEY_MANUAL_STR},
    {MSG_KEY_ABOUT,(STRPTR)MSG_KEY_ABOUT_STR},
};

#endif /* CATCOMP_ARRAY */


/****************************************************************************/


struct LocaleInfo
{
    APTR li_LocaleBase;
    APTR li_Catalog;
};



#endif /* SAGA_STRINGS_H */
