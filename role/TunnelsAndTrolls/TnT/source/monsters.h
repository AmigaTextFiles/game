#define ZE 1 // monsters with a ZEro attribute (because otherwise we would set it to 12).
// 0-attribute monsters aren't supposed to be possible because any being with a zero attribute (except Charisma) is supposed to die.

EXPORT struct MonsterStruct monsters[MONSTERS] = {
//                                      st  iq   lk  con  dex chr spd dice adds  mr   ht   rt   lt armour ap skinFlags                          lvl  reference           race       sex
{"Marek the Master Rogue"              ,22, 16,  32,  11,  15, 10, 12,  0,   0,   0,  71, BEC,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CT14/SO48"       , HUMAN    , MALE   },
{"Guard"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CT18"            , HUMAN    , MALE   },
{"Acolyte"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CT34"            , HUMAN    , MALE   },
{"The Netmaster"                       ,25, 20,  25,  20,  40, 15, 12,  5,  63,   0,   0, HEA, SAX,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "CT46"            , HUMAN    , MALE   },
{"Flar"                                ,26, 13,   7,  26,  14, 13, 12,  0,   0,   0,   0, 180,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CT47"            , OGRE     , MALE   },
{"The Stalker"                         ,12, 12,  12,  20,  12, 12, 12,  6,  48,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "CT50/133"        , HUMAN    , MALE   },
{"Tiger"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CT51"            , ANIMAL   , THING  },
{"Barth Bladehand"                     ,18, 13,  12,  25,  25,  8, 12,  6,   0,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | CALC_ADDS | CALC_AP, 0, "CT52"            , HUMAN    , MALE   },
{"Orc"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CT60/70/76/87/199/210",ORC  , MALE   },
{"Blue Beetle God"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0, 200,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CT61/159"        , OTHER    , THING  },
{"Slaver"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CT67"            , HUMAN    , MALE   },
{"Jackal guard"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  80,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CT74"            , OTHER    , THING  }, // %%: perhaps ANIMAL
{"Achmed"                              ,12, 12,  12,  15,  12, 12, 12,  0,  27,   0,   0, SCI, SAX,  -1,  70, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "CT90"            , HUMAN    , MALE   },
{"Warrior"                             ,12, 12,  12,  25,  12, 12, 12,  0,  15,   0,   0, SAX,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CT92"            , HUMAN    , MALE   },
{"Ran"                                 ,35, 18,  20,   5,  18, 15, 12,  0,  37,   0,   0, 170,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CT95"            , HUMAN    , MALE   }, // %%: perhaps OTHER (ALIEN)?
{"D'Icsta"                             ,12, 12,  12,  40,  12, 12, 12,  0,  31,   0,   0, FLA,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CT101"           , HUMAN    , MALE   },
{"Ralf"                                ,26, 13,   7,  26,  14, 13, 12,  0,   0,   0,   0, 180,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CT126"           , OGRE     , MALE   },
{"Champion of the Future"              ,12,277,  12,  25,  12, 12, 12,  0, 150,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "CT128"           , HUMAN    , MALE   }, // %%: perhaps OTHER (ALIEN)?
{"Archer"                              ,12, 12,  12,   5,  12, 12, 12,  2,   5,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "CT209"           , HUMAN    , MALE   },
{"Tyrannosaurus rex"                   , 0,  0,   0,   0,   0,  0,  0,  0,   0, 300,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CT214"           , ANIMAL   , THING  },
{"Ogara"                               ,60, 16,   8,  20,   7, 10, 12,  3,  45,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "CT218"           , OGRE     , MALE   },
{"Cronus"                             ,112, 40, 112,  25, 112, 13, 12,  0, 300,   0,   0, 245,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CT223"           , HUMAN    , MALE   },
{"Nathan the Tax Collector"            ,12, 14,  14,  15,  10,  8, 12,  0,   0,   0,   0,  -1,  -1,  -1,  25, 0, CALC_DICE | CALC_ADDS | USE_AP,  1, "CTp95"           , HUMAN    , MALE   },
{"Mardoc the Medic"                    ,14, 15,  10,  12,  12, 15, 12,  0,   0,   0,   0,  -1,  -1,  -1,  25, 0, CALC_DICE | CALC_ADDS | USE_AP,  1, "CTp95"           , HUMAN    , MALE   },
{"Dar the Bully"                       ,13,  7,  13,  10,  13,  9, 12,  0,   0,   0,   0, PIL,  -1,  -1,  20, 0, CALC_DICE | CALC_ADDS | USE_AP,  1, "CTp95"           , HUMAN    , MALE   },
{"Uriah the Trader"                    ,10, 16,  10,  13,  12, 12, 12,  0,   0,   0,   0,  -1,  -1,  -1,  20, 0, CALC_DICE | CALC_ADDS | USE_AP,  2, "CTp96"           , HUMAN    , MALE   },
{"Pietr the Pickpocket"                ,14, 13,  22,  15,  25, 13, 12,  0,   0,   0,   0, FAL, MAD,  -1,  27, 0, CALC_DICE | CALC_ADDS | USE_AP,  4, "CTp96"           , HUMAN    , MALE   },
{"Seth the Slaver"                     ,16, 12,  14,  12,  16,  9, 12,  0,   0,   0,   0, WAR, KNI, LEA,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 2, "CTp96"           , HUMAN    , MALE   },
{"Mingor Diamondfist"                  ,60, 20, 106,  20,  20, 20, 20,  0,   0,   0,   0, PIL,  -1, MAI,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 8, "CTp96"           , HUMAN    , MALE   },
{"Zaarg the Vampire"                   ,37, 12,  15,   8,   8, 15, 12,  3,   0,   0,   0,  -1,  -1,  -1,  52, 0, USE_DICE  | CALC_ADDS | USE_AP,  1, "CTp96"           , VAMPIRE  , MALE   },
{"Inram the Wizard"                    ,40, 42,  30,   8,  16, 12, 12,  0,   0,   0,   0,  -1, DEL,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 9, "CTp96"           , HUMAN    , MALE   },
{"Jokar the Small"                     ,18,  7,  19,   7,   8, 11, 12,  0,   0,   0,   0, BEC, TOW, MAI,  25, 0, CALC_DICE | CALC_ADDS | USE_AP,  4, "CTp96"           , HUMAN    , MALE   },
{"Dar's friend"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CTp95"           , HUMAN    , MALE   },
{"Goblin"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  16,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "TCp147"          , GOBLIN   , MALE   },
{"Warg"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  28,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "TCp147"          , WARG     , THING  },
{"Bloodbat"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "TCp147"          , ANIMAL   , THING  },
{"Giant Lizard"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  24,   0,  -1,  -1,  -1,   0, 7, CALC_DICE | CALC_ADDS | CALC_AP, 0, "TCp147"          , ANIMAL   , THING  },
{"Shadow Ghost"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "TCp147"          , GHOST    , THING  },
{"Red Orc"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  22,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "TCp147"          , ORC      , MALE   },
{"Silver Serpent"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "TC8"             , ANIMAL   , THING  },
{"Sphinx"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0, 200,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "TC13"            , SPHINX   , THING  },
{"Cave Troll"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  36, 144,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "TC17"            , TROLL    , MALE   },  // 5' wide
{"Goblin with spear"                   ,12, 12,  12,   7,  12, 12, 12,  0,   0,   0,   0, 172,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "ND14"            , GOBLIN   , MALE   },
{"Naked rock troll"                    ,12, 12,  12,  25,  12, 12, 12,  2,   0,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "ND19"            , TROLL    , MALE   },
{"Goblin with dagger"                  ,12, 12,  12,   9,  12, 12, 12,  1,   5,   0,   0, PON,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "ND35"            , GOBLIN   , MALE   },
{"Balrog"                              ,12, 12,  12,  84,  12, 12, 12,  8,  96,   0, 144, 205,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "ND45"            , BALROG   , THING  },
{"Big man"                             ,12, 12,  12,  15,  12, 12, 12,  4,  12,   0,   0, SPE,  -1, MAI,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "ND55/59"         , HUMAN    , MALE   },
{"Big man's fellow"                    ,12, 12,  12,  15,  12, 12, 12,  3,  10,   0,   0, BRO, TAR, MAI,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "ND55/59"         , HUMAN    , MALE   },
{"Guard leader"                        ,12, 12,  12,  15,  12, 12, 12,  3,  10,   0,   0, BRO,  -1, SCA,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "ND67"            , HUMAN    , MALE   },
{"Guard"                               ,12, 12,  12,  12,  12, 12, 12,  3,  10,   0,   0, BRO,  -1, SCA,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "ND67"            , HUMAN    , MALE   },
{"Cave dragon"                         ,12, 12,  12, 225,  12, 12, 12, 15, 104,   0,  96,  -1,  -1,  -1, 600, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "NDp103"          , DRAGON   , THING  },
{"Balrog"                              ,12, 12,  12,  98,  12, 12, 12,  8,  77,   0, 144, 205,  -1,  -1, 500, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "NDp103"          , BALROG   , THING  },
{"Troll"                               ,12, 12,  12,  39,  12, 12, 12,  3,  12,   0,  96,  -1,  -1,  -1, 200, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "NDp103"          , TROLL    , MALE   },
{"Giant cockroach"                     ,12, 12,  12,  15,  12, 12, 12,  2,   5,   0,  72,  -1,  -1,  -1, 100, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "NDp103"          , ANIMAL   , THING  },
{"Evil dwarf"                          ,12, 12,  12,  20,  12, 12, 12,  2,  17,   0,  48, PIC,  -1,  -1,  80, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "NDp103"          , DWARF    , MALE   },
{"Naked human with a bamboo spear"     ,13, 12,  12,  20,  12, 12, 12,  0,   0,   0,  96, 367,  -1,  -1,  40, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "NDp103"          , HUMAN    , MALE   },
{"Goblin"                              ,12, 12,  12,   7,  12, 12, 12,  0,  -4,   0,   0, 367,  -1,  -1,  40, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "NDp103"          , GOBLIN   , MALE   },
{"Two-headed ogre"                     ,12, 12,  12,  20,  12, 12, 12,  2,   3,   0,   0,  -1,  -1,  -1, 100, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "NDp103"          , OGRE     , MALE   },
{"Ghoul"                               ,12, 12,  12,  51,  12, 12, 12,  3,  10,   0,   0,  -1,  -1,  -1, 150, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "NDp103"          , GHOUL    , THING  },
{"Chimera"                             ,12, 12,  12,  27,  12, 12, 12,  4,  16,   0,   0,  -1,  -1,  -1, 400, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "NDp103-104"      , CHIMERA  , THING  },
{"Shoggoth"                            ,12, 12,  12, 850,  12, 12, 12, 20, 267,   0,   0,  -1,  -1,  -1,5000, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "NDp104"          , SHOGGOTH , THING  },
{"Centaur"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  54,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BS17/75/117/151" , CENTAUR  , MALE   },
{"Vampire"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  35,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BS19"            , VAMPIRE  , FEMALE },
{"Young giant octopus"                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  45,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BS26/104/208/223", ANIMAL   , THING  },
{"Dwarf"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  21,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BS31/173"        , DWARF    , MALE   },
{"Amazon"                              ,19, 12,  20,  40,  19, 18, 12,  0,   0,   0,   0, FLA, 207,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BS43/135"        , HUMAN    , MALE   },
{"Goblin"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  15,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BS70"            , GOBLIN   , MALE   },
{"Black hobbit"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  17,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BS92/108/207"    , BLACKHOBBIT, MALE },
{"Mummy"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  53,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BS124/133"       , MUMMY    , THING  }, // %%: BS124 says MR of 54, BS133 says 53!
{"Ogre"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  66,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 6, "BS131/138"       , OGRE     , MALE   },
{"Rodansk"                             ,12, 12,  12,  20,  12,  8, 12,  3,  12,   0,  70, GRE,  -1,  -1,   0, 0,  USE_DICE |  USE_ADDS | CALC_AP, 0, "BS11/134/196"    , HUMAN    , MALE   },
{"Valkum"                              ,12, 12,  12,  20,  12,  8, 12,  3,  12,   0,  76, LIG,  -1,  -1,   0, 0,  USE_DICE |  USE_ADDS | CALC_AP, 0, "BS11/134/196"    , HUMAN    , MALE   },
{"Dragon"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  75,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BS146"           , DRAGON   , THING  },
{"Nevet"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  25,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BS152"           , OTHER    , MALE   }, // %%: what race is Nevet?
{"Soulsucker"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  53,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BS178"           , SUCCUBUS , FEMALE },
{"Hippolyta"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  25+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA21"            , HUMAN    , FEMALE }, //  75
{"Haksum"                              ,12, 12,  12,  10,  12, 12, 12,  6,  15,   0,  78, BRO, DOU,  -1,   0, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "DE20/29"         , HUMAN    , MALE   }, //  76
{"Tavashtri"                           ,63, 13,  15,  77,  28,  0, 12,  8,  67,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "DE21"            , STATUE   , THING  }, //  77
{"White bear"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  47,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DE23/81"         , ANIMAL   , THING  }, //  78
{"Female troll"                        ,12, 12,  12,  50,  12, 12, 12,  7,  20,   0,   0, CLU,  -1,  -1,  50, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "DE28/186"        , TROLL    , FEMALE }, //  79
{"Enormous black widow spider"         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DE64"            , SPIDER   , THING  }, //  80
{"Blood bat"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DE42/65"         , ANIMAL   , THING  }, //  81
{"Vokal the Necromancer"               ,12, 12,  12, 100,  12, 12, 12,  0,  22,   0,   0, 194,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "DE77"            , HUMAN    , MALE   }, //  82
{"Giant"                               ,12, 12,  12,  50,  12, 12, 12, 12,  38,   0, 360, CLU,  -1,  -1, 200, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "DE135"           , GIANT    , MALE   }, //  83
{"Cannibal ape-demon"                  , 0,  0,   0,   0,   0,  0,  0,  0,   0,  25,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DE128/133"       , GORILLA  , THING  }, //  84 %%: perhaps is also DEMON?
{"Giant demon blood bat"               , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DE25/155"        , ANIMAL   , THING  }, //  85 %%: perhaps is also DEMON?
{"K'dhaz Vytyl"                        ,35, 30,  24,  24,  30, 20, 12,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 4, "CDp75"           , HUMAN    , MALE   }, //  86
{"La Miaverte"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0, 120,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "CDp75"           , SUCCUBUS , FEMALE }, //  87
{"Ornalac"                             ,26, 30,  17,  20,  21, 16, 12,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 3, "CDp76"           , HUMAN    , MALE   }, //  88
{"T'ah Shash'n adept"                  ,20, 30,  12,  17,  17,  8, 12,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CDp76"           , HUMAN    , MALE   }, //  89
{"Villager"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  25,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CDp76"           , HUMAN    , MALE   }, //  90
{"Servant"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CDp76"           , HUMAN    , MALE   }, //  91
{"T'ah guard"                          ,14,  6,  10,  17,  23,  5, 12,  0,   0,   0,   0, HAB, SCI, QUI,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CDp76-77"        , HUMAN    , MALE   }, //  92
{"Yeoman"                              ,18,  9,  12,  18,  24,  6, 12,  0,   0,   0,   0, PIK,  -1, QUI,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CDp77"           , HUMAN    , MALE   }, //  93
{"T'ah officer"                        ,20, 26,  18,  18,  18, 15, 12,  0,   0,   0,   0, 335, 313, RIN,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CDp77"           , HUMAN    , MALE   }, //  94
{"Grazide Lazier"                      ,29, 21,  22,  21,  19, 23, 12,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CDp77"           , HUMAN    , MALE   }, //  95
{"Ildrac T'ahlyst"                     ,41, 17,  31,  34,  35, 14, 12,  0,   0,   0,   0, BRO,  -1, LAM,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CDp77-78"        , HUMAN    , MALE   }, //  96
{"Vuissane Testoniere"                 ,33, 22,  27,  24,  35, 27, 12,  0,   0,   0,   0, RAP, DRK, LAM,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CDp78"           , HUMAN    , MALE   }, //  97
{"Boy"                                 ,15, 18,  11,  12,  21, 10, 12,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 1, "CD8/29"          , HUMAN    , MALE   }, //  98
{"Bruit Fors"                          ,21, 22,  30,  20,  19, 20, 12,  0,   0,   0,  47,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 3, "CD12"            , HUMAN    , MALE   }, //  99 // >200#
{"Bat"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  11,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CD33/153"        , ANIMAL   , THING  }, // 100
{"Delverdinger"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0, 150,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CD103"           , TROLL    , MALE   }, // 101
{"Jhani"                               ,12, 12,  16,   9,  26, 12, 12,  0,   0,   0,   0, PON,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 1, "CD146"           , HUMAN    , FEMALE }, // 102
{"Gargoyle"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CD166"           , OTHER    , THING  }, // 103
{"Demon stallion"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1, 150, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "CD192"           , DEMON    , THING  }, // 104
{"Gargoyle piece"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CD194"           , OTHER    , THING  }, // 105
{"Rabid rabbit"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SS"              , ANIMAL   , THING  }, // 106
{"Poisonous lizard"                    , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SS"              , ANIMAL   , THING  }, // 107
{"Ghost"                               ,12, 12,  12,   3,  12, 12, 12,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "SS14"            , GHOST    , THING  }, // 108
{"Henry"                               ,12, 12,  12,   3,  12, 12, 12,  2,   4,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "SS41"            , HUMAN    , MALE   }, // 109
{"Immense green troll"                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SS90"            , TROLL    , MALE   }, // 110
{"Ghost"                               ,12, 12,  12,  17,  12, 12, 12,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "SS94"            , GHOST    , THING  }, // 111
{"Jumping tarantula"                   , 0,  0,   0,   0,   0,  0,  0,  2,   0,   1,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "SS143"           , SPIDER   , THING  }, // 112
{"Scorpion"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SS150"           , ANIMAL   , THING  }, // 113
{"Demon"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0, 500,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SS150"           , DEMON    , THING  }, // 114
{"Demon"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,1250,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SS150"           , DEMON    , THING  }, // 115
{"Frog"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  15,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SS201"           , ANIMAL   , THING  }, // 116
{"Gnome"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SS225"           , GNOME    , MALE   }, // 117
{"Scarred rogue"                       ,12, 12,  12,  12,  12,  3, 12,  2,  12,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "SS125"           , HUMAN    , MALE   }, // 118
{"Rabid rabbit"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SS"              , ANIMAL   , THING  }, // 119
{"Poisonous lizard"                    , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SS"              , ANIMAL   , THING  }, // 120
{"Giant"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  80+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC"              , GIANT    , MALE   }, // 121 BC WMT
{"Blood bat"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC"              , ANIMAL   , THING  }, // 122 BC WMT
{"Swarm of killer bees"                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC"              , ANIMAL   , THING  }, // 123 BC WMT
{"Ogre"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC"              , OGRE     , MALE   }, // 124 BC WMT
{"Giant snake"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  16+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC"              , ANIMAL   , THING  }, // 125 BC WMT
{"Mummy"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  16+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC"              , MUMMY    , THING  }, // 126 BC WMT
{"Giant jellyfish"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC"              , ANIMAL   , THING  }, // 127 BC WMT
{"Giant spider"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  16+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC"              , SPIDER   , THING  }, // 128 BC WMT
{"Giant rat"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC"              , ANIMAL   , THING  }, // 129 BC WMT
{"Troll"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  24+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC"              , TROLL    , MALE   }, // 130 BC WMT
{"Rabid dog"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  18+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC"              , ANIMAL   , THING  }, // 131 BC WMT
{"Octopus"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  80+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC25"            , ANIMAL   , THING  }, // 132
{"Tree"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  25+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC85"            , OTHER    , THING  }, // 133
{"Buffalo"                             , 0,  0,   0,   0,   0,  0,  0,  2,   7,   5+10,0,  -1,  -1,  -1,  15, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "BC97"            , ANIMAL   , THING  }, // 134
{"Evil man"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20+10,0,  -1,  -1, LEA,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC70/108"        , HUMAN    , MALE   }, // 135
{"Strong man"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC43/82"         , HUMAN    , MALE   }, // 136 %%: since he is immortal he is unlikely to be truly human
{"Troll"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BC111"           , TROLL    , MALE   }, // 137
{"Cave lion"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  80,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK62"            , ANIMAL   , THING  }, // 138
{"Giant constrictor snake"             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK68"            , ANIMAL   , THING  }, // 139
{"Very big eagle"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK72"            , ANIMAL   , THING  }, // 140
{"Crocodile"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK85"            , ANIMAL   , THING  }, // 141
{"Elephant"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0, 200,   0,  -1,  -1,  -1,   0,10, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK89"            , ANIMAL   , THING  }, // 142
{"Carnivorous great ape"               , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK100"           , GORILLA  , THING  }, // 143
{"Giant"                               ,30,  0,   0,  50,   0,  0,  0,  0,   0,   0, 360, 343,  -1,  -1,   0,10, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK7"             , GIANT    , MALE   }, // 144
{"Male gremlin"                        , 7,  8,  17,   7,   9,  7, 12,  0,   0,   0,   0, 337, 338,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK13"            , GREMLIN  , MALE   }, // 145
{"Female gremlin"                      , 8,  9,  18,   8,  10,  8, 13,  0,   0,   0,   0, 337, 338,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK13"            , GREMLIN  , FEMALE }, // 146
{"Hobbit"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,   0,   0, 339,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK19"            , WHITEHOBBIT, MALE }, // 147
{"Dwarf"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0, BRA,  -1, MAI,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK25"            , DWARF    , MALE   }, // 148
{"Man"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,   0,   0, BRO, TAR, LEA,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK31"            , HUMAN    , MALE   }, // 149
{"Death-Uruk orc"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,   0,   0, SCI, VIK, CUI,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK38"            , ORC      , MALE   }, // 150
{"One-headed ogre"                     , 0,  0,   0,   0,   0,  0,  0,  2,   3,   0, 144, 342,  -1,  -1, 100, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK44"            , OGRE     , MALE   }, // 151
{"Troll"                               ,40,  8,  14,  40,  12,  5, 12,  0,  12,  30, 179,  -1,  -1,  -1,   0, 5, USE_DICE  | USE_ADDS  | CALC_AP, 0, "AK49"            , TROLL    , MALE   }, // 152
{"L1 wizard"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,   0,   0, 313, ORD,  -1, 100, 0, CALC_DICE | CALC_ADDS | USE_AP , 1, "AK26"            , HUMAN    , MALE   }, // 153
{"L2 warrior-wizard"                   , 0,  0,   0,   0,   0,  0,  0,  0,   0,   0,   0, GRS,  -1, SCA, 200, 0, CALC_DICE | CALC_ADDS | USE_AP , 2, "AK40"            , ORC      , MALE   }, // 154
{"L3 wizardess"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,   0,   0, 345,  -1, 344, 300, 0, CALC_DICE | CALC_ADDS | USE_AP , 3, "AK51"            , ELF      , FEMALE }, // 155
{"Boron"                               ,17, 12,  17,   1,  17, 12, 12,  0,   0,   0,   0, 340,  -1,  -1, 400, 0, CALC_DICE | CALC_ADDS | USE_AP , 4, "AK101"           , DWARF    , MALE   }, // 156
{"L5 wizard"                           ,70, 12,  12,  30,  12, 12, 12,  0,   0,   0,   0, 393, SAX, 392, 500, 0, CALC_DICE | CALC_ADDS | USE_AP , 5, "AK165"           , HUMAN    , MALE   }, // 157
{"L6 wizardess"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,   0,   0, 341,  -1,  -1, 600,20, CALC_DICE | CALC_ADDS | USE_AP , 6, "AK32"            , HUMAN    , FEMALE }, // 158
{"Giant spider"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK10"            , SPIDER   , THING  }, // 159
{"Balrog"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0, 500,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK21"            , BALROG   , THING  }, // 160
{"Manticore"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0, 250,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK56"            , MANTICORE, THING  }, // 161
{"Unicorn"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0, 200,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK57"            , UNICORN  , THING  }, // 162
{"Werewolf"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0, 150,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK64"            , WEREWOLF , THING  }, // 163
{"Shoggoth"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,1000,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AK91"            , SHOGGOTH , THING  }, // 164
{"Balrog"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , BALROG   , THING  }, // 165
{"Black hobbit"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , BLACKHOBBIT, MALE }, // 166
{"Centaur"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  29,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , CENTAUR  , MALE   }, // 167
{"Dragon (with flame)"                 , 0,  0,   0,   0,   0,  0,  0,  0,   0, 110,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , DRAGON   , THING  }, // 168
{"Dragon (without flame)"              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  60,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , DRAGON   , THING  }, // 169
{"Flame demon"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  45,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , DEMON    , THING  }, // 170
{"Ghoul"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  28,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , GHOUL    , THING  }, // 171
{"Goblin"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , GOBLIN   , MALE   }, // 172
{"Giant spider"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  16,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , SPIDER   , THING  }, // 173
{"Half-orc"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  74,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , HALFORC  , MALE   }, // 174
{"Jubjub bird"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  36,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , ANIMAL   , THING  }, // 175
{"Leopard"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  34,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , ANIMAL   , THING  }, // 176
{"Ogre"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  26,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , OGRE     , MALE   }, // 177
{"Orc"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , ORC      , MALE   }, // 178
{"Rat"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,   8,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , ANIMAL   , THING  }, // 179
{"Tiger"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  44,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , ANIMAL   , THING  }, // 180
{"Troll"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , TROLL    , MALE   }, // 181
{"Unicorn"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , UNICORN  , THING  }, // 182
{"Vampire"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , VAMPIRE  , THING  }, // 183
{"Werewolf"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "RB38"            , WEREWOLF , THING  }, // 184
{"Rat"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  13,   0,  -1,  -1,  -1,  40, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "ASp83"           , ANIMAL   , THING  }, // 185
{"Skeleton"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,  50, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "ASp83"           , SKELETON , THING  }, // 186
{"Zombie"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  65,   0,  -1,  -1,  -1, 200, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "ASp84"           , ZOMBIE   , THING  }, // 187
{"Demon"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  45,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "ASp84"           , DEMON    , THING  }, // 188
{"Tall man"                            ,24, 12,  24,  30,  23, 12, 12,  0,   0,   0,   0, 401, 402, SCA,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AS36"            , HUMAN    , MALE   }, // 189 %%: AS74 implies he is a demon?
{"Skeleton"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  26,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AS65"            , SKELETON , THING  }, // 190
{"Zombie"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,   3,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AS101"           , ZOMBIE   , THING  }, // 191
{"Demon"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  80,   0,  -1,  -1,  -1,   0, 5, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AS102"           , DEMON    , THING  }, // 192
{"Orange humanoid"                     ,14, 12,  14,  36,  13, 12, 12,  0,   0,   0,   0, 418,  -1, 419,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AS109"           , HUMAN    , MALE   }, // 193 %%: what species are these?
{"Minor demon"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  38,   0,  -1,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AS114"           , DEMON    , THING  }, // 194
{"Blob"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  52,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AS119"           , SLIME    , THING  }, // 195 %%: we're assuming it's SLIME
{"40' tall orc"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,   1, 480,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AS121"           , OTHER    , THING  }, // 196 he's not a real ORC
{"Orc"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  29,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AS92/125"        , ORC      , MALE   }, // 197
{"Snake"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  48,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AS196"           , ANIMAL   , THING  }, // 198
{"Giant mosquito"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  90,   0,  -1,  -1,  -1, 150, 0, CALC_DICE | CALC_ADDS | USE_AP , 0, "AS197"           , ANIMAL   , THING  }, // 199
{"Ghost pirate"                        ,12, 12,  12,  50,  12, 12, 12,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | USE_AP , 0, "ASp87"           , GHOST    , THING  }, // 200
{"Octopus tentacle"                    , 0,  0,   0,   0,   0,  0,  0,  0,   0,  18,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AS80"            , ANIMAL   , THING  }, // 201
{"Skeleton"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0, 120,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AS168"           , SKELETON , THING  }, // 202
{"Fire demon"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  75,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AS193"           , DEMON    , THING  }, // 203
{"Ice giant"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  48, 120,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp65"           , GIANT    , MALE   }, // 204
{"Crystal demon"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,  72,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp65"           , DEMON    , THING  }, // 205
{"Manticore"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  66,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp65"           , MANTICORE, THING  }, // 206
{"Wild dog"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp65"           , ANIMAL   , THING  }, // 207
{"Blood bat"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,   8,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SH124/p65"       , ANIMAL   , THING  }, // 208
{"Werewolf"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  32,  60,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp65"           , WEREWOLF , THING  }, // 209
{"Giant spider"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,   6,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp66"           , SPIDER   , THING  }, // 210
{"Toad warrior"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  26,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp66"           , OTHER    , THING  }, // 211
{"Ghoul"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp66"           , GHOUL    , THING  }, // 212
{"Stone man"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  22,  72,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp66"           , ROCKMAN  , MALE   }, // 213
{"Minotaur"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  60,  84,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp66"           , MINOTAUR , THING  }, // 214
{"Fire giant"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  52, 108,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp66"           , GIANT    , MALE   }, // 215
{"Shadow demon"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  68,  84,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp66"           , DEMON    , THING  }, // 216
{"Enchanted warrior"                   , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp66"           , UNDEAD   , THING  }, // 217
{"Rat"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,   2,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp66"           , ANIMAL   , THING  }, // 218
{"Sphinx"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  54,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp66"           , SPHINX   , FEMALE }, // 219
{"Cave lion"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  24,  48,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp66"           , ANIMAL   , THING  }, // 220
{"Warrior of the undead"               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  28,  72,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SHp66"           , UNDEAD   , THING  }, // 221
{"Six Pack"                            , 0,  0,   0,  20,   0,  0,  0,  4,  18,   0,   0,  -1,  -1,  -1,   0,12, USE_DICE  | USE_ADDS  | CALC_AP, 0, "SH56"            , DEMON    , MALE   }, // 222
{"Minidragon"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  68,   0,  -1,  -1,  -1, 100, 0, CALC_DICE | CALC_ADDS | USE_AP , 0, "SH72"            , DRAGON   , THING  }, // 223
{"Knuckle Duster"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  26,  96,  -1,  -1,  -1,   0, 8, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SH96"            , OTHER    , THING  }, // 224
{"Warrior statue"                      , 0,  0,   0,  10,   0,  0,  0,  3,  10,   0,   0,  -1,  -1,  -1,  50, 5, USE_DICE  | USE_ADDS  | USE_AP , 0, "SH98"            , STATUE   , THING  }, // 225
{"Gardener"                            , 0,  0,   0,  50,   0,  0,  0,  6,  30,   0,   0,  -1,  -1,  -1, 400, 0, USE_DICE  | USE_ADDS  | USE_AP , 0, "SH110"           , GIANT    , MALE   }, // 226
{"Red Robed Priest"                    , 0,  0,   0,  20,   0,  0,  0,  3,  12,   0,   0,  -1,  -1,  -1, 400, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "SH9"             , HUMAN    , MALE   }, // 227
{"Black hobbit"                        , 0,  0,   0,  12,   0,  0,  0,  4,   0,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "BFp117"          , BLACKHOBBIT, MALE }, // 228
{"Dwarf giant"                         , 0,  0,   0,  45,   0,  0,  0,  8,   0,   0,   0,  -1,  -1,  -1,  50, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "BFp117"          , GIANT    , MALE   }, // 229
{"Shadow demon"                        , 0,  0,   0,  60,   0,  0,  0,  5,   0,   0,   0,  -1,  -1,  -1,  80, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "BFp117"          , DEMON    , THING  }, // 230
{"Crystal demon"                       , 0,  0,   0,  60,   0,  0,  0,  5,   0,   0,   0,  -1,  -1,  -1,  80, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "BFp117"          , DEMON    , THING  }, // 231
{"Vampire"                             , 0,  0,   0,  40,   0,  0,  0,  6,  20,   0,   0,  -1,  -1,  -1,  20, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "BFp117"          , VAMPIRE  , THING  }, // 232
{"Red Robed Priest"                    , 0,  0,   0,  20,   0,  0,  0,  4,  22,   0,   0,  -1,  -1,  -1,  30, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "BFp117"          , HUMAN    , MALE   }, // 233
{"Hobgoblin"                           , 0,  0,   0,  45,   0,  0,  0,  8,  30,   0,   0,  -1,  -1,  -1,  60, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "BF3"             , GOBLIN   , MALE   }, // 234
{"Warrior of the undead"               , 0,  0,   0,  10,   0,  0,  0,  4,  20,   0,   0,  -1,  -1,  -1,   0, 2, USE_DICE  | USE_ADDS  | USE_AP,  0, "BF6"             , ZOMBIE   , THING  }, // 235 %%: undead (but not really zombies)
{"Troll"                               , 0,  0,   0,  60,   0,  0,  0,  7,  50,   0,   0,  -1,  -1,  -1,  45, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "BF51"            , TROLL    , MALE   }, // 236
{"King cobra"                          , 0,  0,   0,  60,   0,  0,  0,  0,   0,   0, 360,  -1,  -1,  -1,   0,40, USE_DICE  | USE_ADDS  | CALC_AP, 0, "BF102"           , ANIMAL   , THING  }, // 237
{"Goblin"                              , 0,  0,   0,  12,   0,  0,  0,  2,   3,   0,   0,  -1,  -1,  -1,   6, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "BF122"           , GOBLIN   , MALE   }, // 238
{"Sword cane"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BF139"           , OTHER    , THING  }, // 239
{"Golden warrior"                      , 0,  0,   0,  30,   0,  0,  0,  6,  50,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "BF145"           , OTHER    , THING  }, // 240
{"Fat man"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0, 200,   0,  -1,  -1,  -1,   0,11, CALC_DICE | CALC_ADDS | USE_AP,  0, "GK8"             , OTHER    , MALE   }, // 241 alien. 800#
{"10' tall warrior"                    , 0,  0,   0,  12,   0,  0,  0,  0,   0,   0, 120, POL,  -1, LAM,   0, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "GK61"            , GIANT    , MALE   }, // 242 %%: it doesn't actually say he is a giant
{"Card Shark"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 5, CALC_DICE | CALC_ADDS | USE_AP,  0, "GK89"            , OTHER    , THING  }, // 243
{"Troll"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "GK116"           , TROLL    , MALE   }, // 244
{"Robot guard"                         , 0,  0,   0,  25,   0,  0,  0,  0,  36,   0,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "GK120"           , OTHER    , THING  }, // 245 robot
{"Giant spider"                        , 0,  0,   0,  25,   0,  0,  0,  0,   0,   9,   0,  -1,  -1,  -1, 250, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "GK167/181"       , SPIDER   , THING  }, // 246
{"Red knight"                          , 0,  0,   0,  20,   0,  0,  0,  5,  15,   0,   0,  -1,  -1,  -1,   0,20, USE_DICE  | USE_ADDS  | USE_AP,  0, "MW10"            , HUMAN    , MALE   }, // 247
{"Elf knight"                          , 0,  0,   0,  22,   0,  0,  0,  6,  18,   0,   0,  -1,  -1,  -1,   0,20, USE_DICE  | USE_ADDS  | USE_AP,  0, "MW10"            , ELF      , MALE   }, // 248
{"Black knight"                        , 0,  0,   0,  25,   0,  0,  0,  8,  21,   0,   0,  -1,  -1,  -1,   0,20, USE_DICE  | USE_ADDS  | USE_AP,  0, "MW10"            , HUMAN    , MALE   }, // 249
{"Barghest"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0, 200,   0,  -1,  -1,  -1,   0,14, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW12"            , OTHER    , THING  }, // 250
{"Goblin"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,  45, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW13"            , GOBLIN   , MALE   }, // 251
{"Huge brown bear"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1, 100, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW15"            , ANIMAL   , THING  }, // 252
{"Snake"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0, 160,   0,  -1,  -1,  -1, 240, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW19"            , ANIMAL   , THING  }, // 253
{"Barghest"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0, 150,   0,  -1,  -1,  -1,   0, 7, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW20"            , OTHER    , THING  }, // 254
{"Giant hunting spider"                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  60,   0,  -1,  -1,  -1, 150, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW21"            , SPIDER   , THING  }, // 255
{"Skinny pirate"                       , 0,  0,   0,  30,   0,  0,  0,  0,   0,   0,   0, SAX,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW33"            , HUMAN    , MALE   }, // 256
{"Barghest"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW40"            , OTHER    , THING  }, // 257
{"Boar"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  90,   0,  -1,  -1,  -1, 145, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW52"            , ANIMAL   , THING  }, // 258
{"Huge carnivorous frog"               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,  30, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW61"            , ANIMAL   , THING  }, // 259
{"Shaggy grey wolf"                    , 0,  0,   0,   0,   0,  0,  0,  0,   0,  26,   0,  -1,  -1,  -1,  26, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW77"            , ANIMAL   , THING  }, // 260
{"Tentacle"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  18,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW81"            , ANIMAL   , THING  }, // 261
{"Muckman"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,  60, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW83"            , OTHER    , MALE   }, // 262
{"Grisix the Troll"                    , 0,  0,   0,   0,   0,  0,  0,  0,   0,  90,   0,  -1,  -1,  -1, 135, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW84"            , TROLL    , MALE   }, // 263
{"Leading retainer"                    , 0,  0,   0,  13,   0,  0,  0,  0,  11,   0,   0, SCI,  -1, MAI,   0, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "MW88"            , HUMAN    , MALE   }, // 264
{"2nd retainer"                        , 0,  0,   0,  13,   0,  0,  0,  0,  10,   0,   0, SCI,  -1, RIN,   0, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "MW88"            , HUMAN    , MALE   }, // 265
{"3rd retainer"                        , 0,  0,   0,  12,   0,  0,  0,  0,   3,   0,   0, SCI,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "MW88"            , HUMAN    , MALE   }, // 266
{"4th retainer"                        , 0,  0,   0,  16,   0,  0,  0,  0,   6,   0,   0, SCI,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "MW88"            , HUMAN    , MALE   }, // 267
{"Bloodworm"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,  45, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW93"            , ANIMAL   , THING  }, // 268
{"Harpy"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,  75, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW95"            , HARPY    , FEMALE }, // 269 or arguably THING
{"Wyvern"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1, 270, 7, CALC_DICE | CALC_ADDS | USE_AP,  0, "MW101"           , WYVERN   , THING  }, // 270
{"1st man-at-arms"                     , 0,  0,   0,  16,   0,  0,  0,  0,   8,   0,   0, SCI,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "MW107"           , HUMAN    , MALE   }, // 271
{"2nd man-at-arms"                     , 0,  0,   0,  14,   0,  0,  0,  0,   4,   0,   0, SCI,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "MW107"           , HUMAN    , MALE   }, // 272
{"Zombie"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  25,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "MW38/48/97"      , ZOMBIE   , THING  }, // 273
{"Ogre"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  80,   0,  -1,  -1,  -1, 120, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "MW108"           , OGRE     , MALE   }, // 274
{"Large carnivorous plant"             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  80,   0,  -1,  -1,  -1, 120, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "MW112"           , OTHER    , THING  }, // 275
{"Giant crocodile"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0,  90,   0,  -1,  -1,  -1, 135, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "MW127"           , ANIMAL   , THING  }, // 276
{"Red knight"                          , 0,  0,   0,  20,   0,  0,  0,  5,  12,   0,   0,  -1,  -1,  -1, 250,28, USE_DICE  | USE_ADDS  | USE_AP,  0, "MW137"           , HUMAN    , MALE   }, // 277
{"Leading man-at-arms"                 , 0,  0,   0,  16,   0,  0,  0,  0,  26,   0,   0, SCI,  -1, LAM,   0, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "MW117"           , HUMAN    , MALE   }, // 278
{"2nd man-at-arms"                     , 0,  0,   0,  16,   0,  0,  0,  0,  19,   0,   0, SCI,  -1, SCA,   0, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "MW117"           , HUMAN    , MALE   }, // 279
{"3rd man-at-arms"                     , 0,  0,   0,  12,   0,  0,  0,  0,  10,   0,   0, SCI,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "MW117"           , HUMAN    , MALE   }, // 280
{"4th man-at-arms"                     , 0,  0,   0,  16,   0,  0,  0,  0,  13,   0,   0, SCI,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "MW117"           , HUMAN    , MALE   }, // 281
{"Goblin"                              , 0,  0,   0,   8,   0,  0,  0,  1,   3,   0,   0, 829,  -1,  -1,  22, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "GL6/28/71"       , GOBLIN   , MALE   }, // 282
{"King Snorkin"                        , 0,  0,   0,  12,   0,  0,  0,  0,  15,   0,   0, 950,  -1,  -1,  88, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "GL53"            , GOBLIN   , MALE   }, // 283
{"Giant devilfish"                     , 0,  0,   0, 100,   0,  0,  0,  8,  50,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "GL9/73"          , ANIMAL   , THING  }, // 284 aka giant octopus
{"Small red dragon"                    , 0,  0,   0,   0,   0,  0,  0,  0,   0, 200,   0,  -1,  -1,  -1, 500, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "WW42"            , DRAGON   , THING  }, // 285
{"Very large worm"                     ,45,  2,  12, 100,   8, -2,  0,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | CALC_ADDS | CALC_AP, 0, "WW47"            , ANIMAL   , THING  }, // 286
{"Leprechaun"                          , 5, 15,  18,   5, 153, 18,  0,  1,  50,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "WW116"           , LEPRECHAUN, MALE  }, // 287
{"Giant amoeba"                        , 0,  0,   0, 100,   0,  0,  0,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "WW141"           , OTHER    , THING  }, // 288 %%: or perhaps ANIMAL?
{"Painted sword"                       , 0,  0,   0,  10,   0,  0,  0,  2,  25,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "WW154"           , OTHER    , THING  }, // 289
{"Beast-head"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  15,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AB25/29"         , DEMON    , THING  }, // 290
{"Abaddon"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  55,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AB28"            , DEMON    , THING  }, // 291
{"Young bird"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AB32"            , ANIMAL   , THING  }, // 292
{"False prophet"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  69,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AB53"            , DEMON    , THING  }, // 293
{"Horse beast"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  33,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AB55"            , DEMON    , THING  }, // 294
{"Iscariot"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AB5"             , HUMAN    , MALE   }, // 295
{"Giant black bird"                    , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "AB17"            , ANIMAL   , THING  }, // 296
{"Tentacle beast"                      , 0,  0,   0, 100,   0,  0,  0, 12, 150,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "SO2"             , OTHER    , THING  }, // 297
{"Wraith"                              , 0,  0,   0, 100,   0,  0,  0,  9, 500,   0, 144,  -1,  -1,  -1,   0,12, CALC_DICE | CALC_ADDS | USE_AP,  0, "SO5/111"         , UNDEAD   , THING  }, // 298 we aren't implementing Hellblade as a real item
{"Crocodile"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0, 210,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO7/36"          , ANIMAL   , THING  }, // 299
{"Wooden warrior"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | USE_AP,  0, "SO96/162/193/218", OTHER    , THING  }, // 300 also SO12/43
{"Ex-husband (with rapier and sax)"    , 0,  0,   0,  25,   0,  0,  0,  0, 115,   0,   0, RAP, SAX,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SO14"            , HUMAN    , MALE   }, // 301
{"Spider Cult warrior"                 , 0,  0,   0,  30,   0,  0,  0,  0,  75,   0,   0, SCI,  -1, QUI,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SO19"            , HUMAN    , MALE   }, // 302
{"Rat"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO35/90/153"     , ANIMAL   , THING  }, // 303
{"Sea snake"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  60,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO WMT"          , ANIMAL   , THING  }, // 304
{"Spider"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0, 450,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO28"            , SPIDER   , THING  }, // 305
{"Wooden warrior"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO34"            , OTHER    , THING  }, // 306
{"Guard"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  90,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO45"            , HUMAN    , MALE   }, // 307
{"Guard"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO45"            , HUMAN    , MALE   }, // 308
{"Briah"                               , 0,  0,   0,  50,   0,  0,  0,  0, 154,   0,   0, PIL, TOW,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SO50/135"        , HUMAN    , MALE   }, // 309
{"Ogre"                                , 0,  0,   0,  45,   0,  0,  0,  6, 124,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "SO53"            , OGRE     , MALE   }, // 310
{"Peasant"                             , 0,  0,   0,  27,   0,  0,  0,  0, 115,   0,   0, SCI, BUC,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SO78"            , HUMAN    , MALE   }, // 311
{"Morgo (with sax)"                    , 0,  0,   0,  20,   0,  0,  0,  0, 151,   0,   0, SAX,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SO100/213"       , HUMAN    , MALE   }, // 312
{"Leo Felis (cat-form)"                , 0,  0,   0,   0,   0,  0,  0,  0,   0, 350,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO104"           , OTHER    , THING  }, // 313 or arguably MALE
{"Spider Cult member"                  , 0,  0,   0,  28,   0,  0,  0,  0, 110,   0,   0, SCI,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SO106"           , HUMAN    , MALE   }, // 314
{"Count Karken"                        , 0,  0,   0,  45,   0,  0,  0,  0, 240,   0,   0, SAB, BUC, LEA,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SO108"           , HUMAN    , MALE   }, // 315
{"Ex-husband (with rapier and dirk)"   , 0,  0,   0,  25,   0,  0,  0,  0, 115,   0,   0, RAP, DRK,  -1, 115, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "SO112/201"       , HUMAN    , MALE   }, // 316
{"Spider Cult youth"                   , 0,  0,   0,  18,   0,  0,  0,  0,  70,   0,   0, GLA, SAX,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SO116"           , HUMAN    , MALE   }, // 317
{"Marsimbar (without flame)"           , 0,  0,   0, 500,   0,  0,  0, 10, 371,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "SO117"           , DRAGON   , THING  }, // 318 or arguably MALE
{"Earth elemental"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0,  25,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD20"            , ELEMENTAL, THING  }, // 319
{"Giant"                               , 0,  0,   0, 100,   0,  0,  0, 20, 245,   0,   0,  -1,  -1, MAI,   0, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "SO126"           , GIANT    , MALE   }, // 320
{"Guard"                               , 0,  0,   0,  22,   0,  0,  0,  0, 130,   0,   0, SCI, KNI, RIN,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SO130"           , HUMAN    , MALE   }, // 321
{"Mummy"                               , 0,  0,   0,  30,   0,  0,  0,  2, 221,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "SO134"           , MUMMY    , THING  }, // 322
{"Guard"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  80,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO166"           , HUMAN    , MALE   }, // 323
{"Al-Dajjal mercenary"                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  75,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO171"           , HUMAN    , MALE   }, // 324
{"Marsimbar (with flame)"              , 0,  0,   0, 500,   0,  0,  0, 25, 371,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "SO181"           , DRAGON   , THING  }, // 325 or arguably MALE
{"Ranger"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  80,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO139/211"       , HUMAN    , MALE   }, // 326
{"Rabid bat"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO WMT"          , ANIMAL   , THING  }, // 327
{"Zombie"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  80,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO59/182"        , ZOMBIE   , THING  }, // 328
{"Morgo (barehanded)"                  , 0,  0,   0,  20,   0,  0,  0,  0, 151,   0,   0,  -1,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SO186/213"       , HUMAN    , MALE   }, // 329
{"Rat with fleas"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO WMT"          , ANIMAL   , THING  }, // 330
{"Alligator"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO WMT"          , ANIMAL   , THING  }, // 331
{"Merman"                              , 0,  0,   0,  30,   0,  0,  0,  0,  10,   0,   0, SAX,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SO WMT"          , MERMAN   , MALE   }, // 332
{"Mermaid"                             , 0,  0,   0,  30,   0,  0,  0,  0,  10,   0,   0, SAX,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SO WMT"          , MERMAN   , FEMALE }, // 333
{"Ex-husband (with rapier)"            , 0,  0,   0,  25,   0,  0,  0,  0, 115,   0,   0, RAP,  -1,  -1, 115, 0, CALC_DICE | USE_ADDS  | USE_AP,  0, "SO168"           , HUMAN    , MALE   }, // 334
{"Leo Felis (man-form)"                , 0,  0,   0,  40,   0,  0,  0,  0, 225,   0,   0, SAX, BUC,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO194"           , OTHER    , MALE   }, // 335 or arguably THING
{"Infantryman"                         , 0,  0,   0,  40,   0,  0,  0,  0,  19,   0,   0, SAX,  -1,  -1, 150, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "SO197"           , HUMAN    , MALE   }, // 336
{"Jellyfish"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SO WMT"          , ANIMAL   , THING  }, // 337
{"Theseus"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  29+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA21"            , HUMAN    , MALE   }, // 338
{"Centaur"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  25+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA58"            , CENTAUR  , MALE   }, // 339
{"Pan"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA96"            , OTHER    , MALE   }, // 340
{"Beautiful woman"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA111"           , HUMAN    , FEMALE }, // 341
{"Fatherly man"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  15+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA111"           , HUMAN    , MALE   }, // 342
{"Giant"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA111"           , GIANT    , MALE   }, // 343
{"She-wolf"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  25+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA111"           , ANIMAL   , THING  }, // 344
{"Demon-child"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA111"           , DEMON    , THING  }, // 345
{"Polyphemus"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  35+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA115"           , CYCLOPS  , MALE   }, // 346
{"Eagle"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  25+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "LA119"           , ANIMAL   , THING  }, // 347
{"Lion"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  15+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA120"           , ANIMAL   , THING  }, // 348
{"Dirty old man"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA120"           , HUMAN    , MALE   }, // 349
{"Spartan warrior"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0,  15+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA120"           , HUMAN    , MALE   }, // 350
{"Ares"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA WMT"          , OTHER    , MALE   }, // 351
{"Athena"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA WMT"          , OTHER    , FEMALE }, // 352
{"Poseidon"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA WMT"          , OTHER    , MALE   }, // 353
{"Dionysus"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA WMT"          , OTHER    , MALE   }, // 354
{"Minotaur"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  86+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA WMT"          , MINOTAUR , THING  }, // 355
{"Menaeds"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA150"           , OTHER    , FEMALE }, // 356 %%: what are menaeds? or arguably THING
{"Hydra head"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA169"           , HYDRA    , THING  }, // 357
{"Hydra"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12+10,0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "LA83"            , HYDRA    , THING  }, // 358
{"Gargoyle"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  70,   0,  -1,  -1,  -1,  70, 0, CALC_DICE | CALC_ADDS | USE_AP,  0, "DD2"             , OTHER    , THING  }, // 359
{"Centaur"                             , 0,  0,   0,  30,  30,  0,  0,  0,  44,   0,   0, KRI,  -1,  -1,  92,22, CALC_DICE | USE_ADDS  | USE_AP , 0, "DD24/68/77"      , CENTAUR  , MALE   }, // 360
{"Demon"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD14"            , DEMON    , OTHER  }, // 361
{"Merman"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,   5,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD15"            , MERMAN   , MALE   }, // 362
{"Ulogulo"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  15,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD34"            , OTHER    , THING  }, // 363
{"Zombie warrior"                      , 0,  0,   0,  20,   0,  0,  0,  0,   0,   0,   0, 581,  -1, LEA,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD37/92"         , ZOMBIE   , THING  }, // 364 perhaps their hide armour should be done as a separate item
{"Fencing dummy"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD37/92"         , OTHER    , THING  }, // 365
{"Lesser priest"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  15,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD64"            , HUMAN    , MALE   }, // 366
{"High priest/sorcerer"                , 0,  0,   0,  15,   0,  0,  0,  0,  30,   0,   0, 600,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "DD64"            , HUMAN    , MALE   }, // 367
{"Giant octopus"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD65"            , ANIMAL   , THING  }, // 368
{"Dry mummy"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  75,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD83"            , MUMMY    , THING  }, // 369
{"Entak"                               , 0,  0,   0,  60,   0,  0,  0,  0,  45,   0,   0, 612,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD132"           , HUMAN    , MALE   }, // 370
{"Ogilvy"                              , 0,  0,   0,  30,   0,  0,  0,  0,  18,   0,   0, SAX,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD139"           , OGRE     , MALE   }, // 371
{"Wet mummy"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD161"           , MUMMY    , THING  }, // 372
{"Giant rat"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  15,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD WMT"          , ANIMAL   , THING  }, // 373
{"Giant wolf"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD WMT"          , ANIMAL   , THING  }, // 374
{"Ugly orc"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD WMT"          , ORC      , MALE   }, // 375
{"Goblin"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD WMT"          , GOBLIN   , MALE   }, // 376
{"Mummy"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  45,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD WMT"          , MUMMY    , THING  }, // 377
{"Minotaur"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,  96,  -1,  -1,  -1,   0, 5, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD WMT"          , MINOTAUR , THING  }, // 378
{"Cave bear"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  65,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD WMT"          , ANIMAL   , THING  }, // 379
{"Troll with the roofing beam"         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  70,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD WMT"          , TROLL    , MALE   }, // 380
{"Demented dwarf"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  75,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD WMT"          , DWARF    , MALE   }, // 381
{"Demon"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD WMT"          , DEMON    , THING  }, // 382
{"Giant serpent"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0, 120,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD WMT"          , ANIMAL   , THING  }, // 383
{"Air elemental"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  25,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD75"            , ELEMENTAL, THING  }, // 384
{"Mercury-covered skeleton"            , 0,  0,   0, 100,   0,  0,  0, 12,  38,   0,   0,  -1,  -1,  -1, 100, 0, CALC_DICE | CALC_ADDS | USE_AP , 0, "DD147"           , SKELETON , THING  }, // 385
{"Rumm"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0,   8,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DD84"            , DEMON    , THING  }, // 386
{"Frost giant"                         , 0,  0,   0,  40,  42,  0,  0,  5,  70,   0,   0,  -1,  -1,  -1,  90, 0, USE_DICE  | USE_ADDS  | USE_AP , 0, "DD19/126"        , GIANT    , MALE   }, // 387
{"Water sprite"                        , 0,  0,   0,  40,   0,  0,  0,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "DD153"           , OTHER    , THING  }, // 388
{"Zombie with sword"                   , 0,  0,   0,   0,   0,  0,  0,  0,   0, 200,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK WMT"          , ZOMBIE   , THING  }, // 389
{"Grey werewolf"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0, 150,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK WMT"          , WEREWOLF , THING  }, // 390
{"Two-headed ogre with club"           , 0,  0,   0,   0,   0,  0,  0,  0,   0, 125,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK WMT"          , OGRE     , MALE   }, // 391
{"Ghoul"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK WMT"          , GHOUL    , THING  }, // 392
{"Living skeleton"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0,  75,   0,  -1,  -1,  -1,   0,12, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK WMT"          , SKELETON , THING  }, // 393
{"Human warrior"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0,22, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK WMT"          , HUMAN    , MALE   }, // 394
{"Centaur with ring mail"              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  75,   0,  -1,  -1,  -1,   0,14, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK WMT"          , CENTAUR  , MALE   }, // 395
{"Cyclops"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100, 360,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK WMT"          , CYCLOPS  , MALE   }, // 396
{"Naga"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0, 150,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK WMT"          , NAGA     , THING  }, // 397 30' long
{"Troll with roofing beam"             , 0,  0,   0,   0,   0,  0,  0,  0,   0, 200,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK WMT"          , TROLL    , MALE   }, // 398
{"Balrog"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0, 300,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK WMT"          , BALROG   , THING  }, // 399
{"Marionarsis"                         , 0,  0,   0,  25,   0,  0,  0,  0, 170,   0,   0, 619,  -1, 620,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "OK13"            , HUMAN    , MALE   }, // 400
{"Zombie"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  60,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK14/35"         , ZOMBIE   , THING  }, // 401
{"Door demon"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0, 150,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK16"            , DEMON    , THING  }, // 402
{"Zombie"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  80,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK22"            , ZOMBIE   , THING  }, // 403
{"Defender"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK30"            , HUMAN    , MALE   }, // 404
{"Fire demon"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK38"            , DEMON    , THING  }, // 405
{"Flame demon leader"                  , 0,  0,   0,   0,   0,  0,  0,  0,   0, 200,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK42/77"         , DEMON    , THING  }, // 406
{"Flame demon"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK42/77"         , DEMON    , THING  }, // 407
{"Zombie"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  45,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK43/59"         , ZOMBIE   , THING  }, // 408
{"Guard"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0, 150,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK6/68"          , HUMAN    , MALE   }, // 409
{"Zombie"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK72"            , ZOMBIE   , THING  }, // 410
{"Shang"                               , 0,  0,   0, 100,   0,  0,  0,  0, 215,   0,   0, 625,  -1, PLA,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "OK8/115/117"     , HUMAN    , MALE   }, // 411
{"Sub-captain"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK117"           , HUMAN    , MALE   }, // 412
{"Captain"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK117"           , HUMAN    , MALE   }, // 413
{"Major"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  60,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK117"           , HUMAN    , MALE   }, // 414
{"Sub-colonel"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  70,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK117"           , HUMAN    , MALE   }, // 415
{"Hawk-colonel"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  80,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK117"           , HUMAN    , MALE   }, // 416
{"Sub-general"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0, 120,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK117"           , HUMAN    , MALE   }, // 417
{"Crossbowman"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "OK8"             , HUMAN    , MALE   }, // 418
{"Shark"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  45,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SM13"            , ANIMAL   , THING  }, // 419
{"Eel-like creature"                   , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SM56"            , ANIMAL   , THING  }, // 420
{"Eunuch guard"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,   8,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SM19"            , HUMAN    , MALE   }, // 421 or arguably THING
{"First mate"                          , 0,  0,   0,  18,   0,  0,  0,  0,  30,   0,   0, 632,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SM23"            , HUMAN    , MALE   }, // 422
{"Amazon crowd"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SM24"            , HUMAN    , FEMALE }, // 423
{"Horned beast"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SM48/80/124"     , ANIMAL   , THING  }, // 424
{"Tentacle beast"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SM72"            , ANIMAL   , THING  }, // 425 or perhaps OTHER?
{"Aristerion"                          , 0,  0,   0,  16,   0,  0,  0,  0,   9,   0,   0, DRK,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SM78"            , HUMAN    , MALE   }, // 426
{"Guard"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SM83/91/131/136" , HUMAN    , MALE   }, // 427
{"Raider"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,   9,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SM90"            , HUMAN    , MALE   }, // 428
{"Slaver"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SM92"            , HUMAN    , MALE   }, // 429
{"Ape"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SM95"            , GORILLA  , THING  }, // 430
{"Sordor"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SM102"           , HUMAN    , MALE   }, // 431
{"Sailor"                              , 0,  0,   0,  18,   0,  0,  0,  0,  14,   0,   0, DRK,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SM104"           , HUMAN    , MALE   }, // 432
{"Koula"                               , 0,  0,   0,  16,   0,  0,  0,  0,   9,   0,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "SM114"           , HUMAN    , FEMALE }, // 433
{"Nomad"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,   7,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SM115"           , HUMAN    , MALE   }, // 434
{"Fungus creature"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "SM140"           , OTHER    , THING  }, // 435
{"Dhesiri Worker"                      , 0,  0,   0,   5,   0,  0,  0,  2,   2,   0,  48,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "RC7/84/100/134/165",LIZARDMAN, MALE  },// 436
{"Guard"                               , 0,  0,   0,  12,   0,  0,  0,  0,   6,   0,   0, SCI,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "RC29/120"        , HUMAN    , MALE   }, // 437 or arguably FEMALE or THING
{"Dhesiri Warrior"                     , 0,  0,   0,   4,   0,  0,  0,  6,   3,   0,  96,  -1,  -1,  -1, 100, 3, USE_DICE  | USE_ADDS  | USE_AP , 0, "RC39/43/73/164"  , LIZARDMAN, MALE   }, // 438
{"Guard"                               , 0,  0,   0,  16,   0,  0,  0,  0,   3,   0,   0, SCI,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "RC57"            , HUMAN    , MALE   }, // 439 or arguably FEMALE or THING
{"Dhesiri Queen"                       , 0,  0,   0,   6,   0,  0,  0,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "RC70"            , LIZARDMAN, FEMALE }, // 440 12' long. or arguably THING
{"Guard"                               , 0,  0,   0,  10,   0,  0,  0,  0,   3,   0,   0, PON,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "RC78"            , HUMAN    , MALE   }, // 441
{"Guard"                               , 0,  0,   0,  10,   0,  0,  0,  0,   3,   0,   0, BRO,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "RC79"            , HUMAN    , MALE   }, // 442
{"Guard"                               , 0,  0,   0,  15,   0,  0,  0,  1,   4,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "RC146"           , HUMAN    , MALE   }, // 443
{"Sergeant"                            , 0,  0,   0,  15,   0,  0,  0,  0,  10,   0,   0, BRO,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "RC169"           , HUMAN    , MALE   }, // 444
{"Baron Valdemar"                      , 0,  0,   0,  12,   0,  0,  0,  0,   6,   0,   0, 645,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "RC182"           , HUMAN    , MALE   }, // 445
{"Rider"                               , 0,  0,   0,  10,   0,  0,  0,  6, 2+3,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "RC205"           , HUMAN    , MALE   }, // 446
{"Red Circle youth"                    , 0,  0,   0,   3,   0,  0,  0,  0,   1,   0,   0, BAN,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "RC211"           , HUMAN    , MALE   }, // 447
{"Guard"                               , 0,  0,   0,  12,   0,  0,  0,  0,   3,   0,   0, SCI,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "RC212"           , HUMAN    , MALE   }, // 448
{"Sand demon"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1, 300, 0, CALC_DICE | CALC_ADDS | USE_AP , 0, "CA19/236"        , DEMON    , THING  }, // 449
{"Guard"                               , 0,  0,   0,  10,   0,  0,  0,  0,  10,   0,   0, SCI,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA2/64"          , HUMAN    , MALE   }, // 450
{"Porovan"                             , 0,  0,   0,  20,   0,  0,  0,  0,  15,   0,   0, FAL,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA2/220"         , HUMAN    , MALE   }, // 451
{"Guard"                               , 0,  0,   0,  10,   0,  0,  0,  0,   7,   0,   0, SCI,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA3"             , HUMAN    , MALE   }, // 452
{"Petunia"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  60,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CA9"             , OTHER    , THING  }, // 453 or perhaps ANIMAL?
{"Falkbar"                             , 0,  0,   0,  20,   0,  0,  0,  0,  15,   0,   0, FAL,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA13/48"         , HUMAN    , MALE   }, // 454
{"Rarardin"                            , 0,  0,   0,  15,   0,  0,  0,  0,  10,   0,   0, SAX,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA17/45"         , HUMAN    , MALE   }, // 455
{"Balrog"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CA22/115"        , BALROG   , THING  }, // 456
{"Rarardin"                            , 0,  0,   0,  15,   0,  0,  0,  0,  10,   0,   0, GRS,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA45"            , HUMAN    , MALE   }, // 457
{"Extra-large red dragon"              , 0,  0,   0,   0,   0,  0,  0,  0,   0, 140,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CA91"            , DRAGON   , THING  }, // 458
{"Narada"                              , 0,  0,   0,  20,   0,  0,  0,  0,  24,   0,   0, FAL, KUK,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA96/218"        , HUMAN    , FEMALE }, // 459
{"Sentry"                              , 0,  0,   0,  10,   0,  0,  0,  0,  10,   0,   0, GRS,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA108"           , HUMAN    , MALE   }, // 460
{"White wolf"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CA118"           , ANIMAL   , THING  }, // 461
{"Male cave troll"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0, 150,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CA123/184"       , TROLL    , MALE   }, // 462
{"Tallarura"                           , 0,  0,   0,  25,   0,  0,  0,  0,  10,   0,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CA109"           , HUMAN    , FEMALE }, // 463
{"Cycera"                              , 0,  0,   0,  20,   0,  0,  0,  0,  30,   0,   0, GRA,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA167"           , HUMAN    , FEMALE }, // 464
{"Kakadoor"                            , 0,  0,   0,  25,   0,  0,  0,  0,  25,   0,  79, GRA,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA168"           , HUMAN    , MALE   }, // 465
{"Bluking"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0, 120,   0,  -1,  -1,  -1,   0, 5, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CA170"           , DRAGON   , THING  }, // 466
{"Desert thief"                        , 0,  0,   0,  15,   0,  0,  0,  0,  20,   0,  75, GRX,  -1, LEA,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA217/248"       , HUMAN    , MALE   }, // 467
{"Kakanar"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0, GRA,  -1, LEA,   0, 5, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CA238"           , OTHER    , THING  }, // 468
{"Female cave troll"                   , 0,  0,   0,   0,   0,  0,  0,  0,   0, 140,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CA215/251"       , TROLL    , FEMALE }, // 469
{"Gregor"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  85,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "CA256"           , HUMAN    , MALE   }, // 470
{"Ghoul"                               , 0,  0,   0,  25,   0,  0,  0,  0,  40,   0,   0, 772,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA300"           , GHOUL    , THING  }, // 471
{"Spectral Viper"                      , 0,  0,   0, 300,   0,  0,  0,  6,  50,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "CA306"           , OTHER    , THING  }, // 472
{"Bandit"                              , 0,  0,   0,  15,   0,  0,  0,  0,  10,   0,   0, BRO,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA228"           , HUMAN    , MALE   }, // 473
{"Skeleton"                            , 0,  0,   0,  60,   0,  0,  0,  0,  20,   0,  96, 776,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA293"           , SKELETON , THING  }, // 474
{"Warrior"                             , 0,  0,   0,  25,   0,  0,  0,  0,  20,   0,   0, 653,  -1, 778,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA223"           , HUMAN    , MALE   }, // 475
{"Dervi King's Champion"               , 0,  0,   0,  20,   0,  0,  0,  4,  46,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "CA290/316"       , OTHER    , THING  }, // 476
{"Large man"                           , 0,  0,   0,  20,   0,  0,  0,  0,  15,   0,   0, 781,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CA243"           , HUMAN    , MALE   }, // 477
{"Mazs kukainis"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,  10, 0, CALC_DICE | USE_ADDS  |  USE_AP, 0, "CI36"            , OTHER    , THING  }, // 478 or perhaps ANIMAL?
{"Cinity statue"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  83,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CI37"            , STATUE   , MALE   }, // 479
{"Red worm"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,   5,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CI38"            , OTHER    , MALE   }, // 480 or perhaps ANIMAL?
{"Kukainis sarkans"                    , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "CI51"            , OTHER    , THING  }, // 481 or perhaps ANIMAL?
{"Ferrid"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,  30, 0, CALC_DICE | CALC_ADDS |  USE_AP, 0, "WC0/92"          , ANIMAL   , THING  }, // 482 or perhaps OTHER?
{"Glass demon"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS |  USE_AP, 0, "WC75"            , DEMON    , THING  }, // 483
{"Black writhing mass"                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  86,   0,  -1,  -1,  -1,  86, 0, CALC_DICE | CALC_ADDS |  USE_AP, 0, "WC146"           , OTHER    , THING  }, // 484
{"Demon-wizard"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS |  USE_AP, 0, "HH55"            , DEMON    , MALE   }, // 485
{"Troll"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,  65, 2, CALC_DICE | CALC_ADDS |  USE_AP, 0, "NS18"            , TROLL    , MALE   }, // 486
{"Ghost"                               ,ZE, 11,  18,  22,  ZE, 22, 28,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  |  USE_AP, 0, "NS48"            , GHOST    , MALE   }, // 487
{"Ghoul"                               ,23,  4,  12,  22,  12,  1, 12,  2,  11,   0,   0,  -1,  -1,  -1,  68, 0, USE_DICE  | USE_ADDS  |  USE_AP, 0, "NS46/76"         , GHOUL    , THING  }, // 488
{"Ghost"                               ,ZE, 11,  18,  17,  ZE, 22, 28,  0,   0,   0,   0,  -1,  -1,  -1, 100, 0, USE_DICE  | USE_ADDS  |  USE_AP, 0, "NS77"            , GHOST    , MALE   }, // 489
{"The Initiate"                        ,10, 28,  12,  22,  18, 12, 18,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS |  USE_AP, 0, "NS94"            , HUMAN    , FEMALE }, // 490
{"Zombie"                              ,20,  4,   8,  22,  10,  1, 10,  1,   8,   0,   0,  -1,  -1,  -1,  55, 0, USE_DICE  | USE_ADDS  |  USE_AP, 0, "NS109"           , ZOMBIE   , MALE   }, // 491
{"Captain Guy l'Webbe"                 ,14, 13,  15,  11,  12, 10, 13,  0,   0,   0,   0, DRK,  -1, JER,  88, 0, CALC_DICE | CALC_ADDS |  USE_AP, 0, "NS130"           , HUMAN    , MALE   }, // 492
{"Calla"                               ,16, 10,  13,  16,  12, 11, 12,  0,   0,   0,   0, SHO, CRO, LEA,   0, 0, CALC_DICE | CALC_ADDS |  USE_AP, 0, "NS178"           , HUMAN    , MALE   }, // 493
{"Ogre"                                , 0,  0,   0,   0,   0,  0, 10,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW WMT"          , OGRE     , THING  }, // 494
{"Giant rat"                           , 0,  0,   0,   0,   0,  0, 16,  0,   0,   3,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW WMT"          , ANIMAL   , THING  }, // 495
{"Tiger"                               , 0,  0,   0,   0,   0,  0, 28,  0,   0,  45,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW WMT"          , ANIMAL   , THING  }, // 496
{"Giant spider"                        , 0,  0,   0,   0,   0,  0, 15,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW WMT"          , SPIDER   , THING  }, // 497
{"Zombie"                              , 0,  0,   0,   0,   0,  0,  7,  0,   0,   4,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW WMT"          , ZOMBIE   , THING  }, // 498
{"Leopard"                             , 0,  0,   0,   0,   0,  0, 25,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW WMT"          , ANIMAL   , THING  }, // 499
{"Flame demon"                         , 0,  0,   0,   0,   0,  0, 12,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW WMT"          , DEMON    , THING  }, // 500
{"Dire wolf"                           , 0,  0,   0,   0,   0,  0, 18,  0,   0,   5,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW WMT"          , ANIMAL   , THING  }, // 501
{"Manticore"                           , 0,  0,   0,   0,   0,  0, 20,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW WMT"          , MANTICORE, THING  }, // 502
{"Kobold"                              , 0,  0,   0,   0,   0,  0, 10,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW WMT"          , OTHER    , THING  }, // 503
{"Hobgoblin"                           , 0,  0,   0,   0,   0,  0, 12,  0,   0,   5,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW WMT"          , GOBLIN   , THING  }, // 504
{"Giant crab"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,   5,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW3"             , ANIMAL   , THING  }, // 505
{"Azoth"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  48,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW55"            , DRAGON   , MALE   }, // 506
{"Large scaly beast"                   , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW66"            , OTHER    , THING  }, // 507 or perhaps ANIMAL?
{"Fire elemental"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  47,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW68"            , ELEMENTAL, THING  }, // 508
{"Skeleton"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,   8,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW69"            , SKELETON , THING  }, // 509
{"Shacath"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW73"            , OTHER    , THING  }, // 510 or perhaps ANIMAL?
{"Spiny beast"                         , 0,  0,   0,   0,   0,  0,  5,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW89"            , OTHER    , THING  }, // 511
{"Spiny beast"                         , 0,  0,   0,   0,   0,  0,  5,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW268"           , OTHER    , THING  }, // 512
{"Dark Wraith"                        ,100,  0,   0,  30,   0,  0,  0,  0,   0,  44,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW95"            , UNDEAD   , THING  }, // 513
{"Slimy black evil thing"              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW119"           , OTHER    , THING  }, // 514
{"Six-armed wolf-headed nightmare"     , 0,  0,   0,  50,   0,  0,  0,  0,   0,  45, 240,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW123"           , OTHER    , THING  }, // 515
{"Hobgoblin"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 5, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW125/157/189/218/298",GOBLIN,THING  }, // 516
{"Elf"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,   4,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW127"           , ELF      , THING  }, // 517
{"Fire elemental"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  35,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW142"           , ELEMENTAL, THING  }, // 518
{"Black leopard with ruby eyes"        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW155/241"       , ANIMAL   , THING  }, // 519
{"Blood red insect"                    , 0,  0,   0,   0,   0,  0,  0,  0,   0,   2,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW200"           , ANIMAL   , THING  }, // 520
{"Dark Wraith"                        , 59,  0,   0,  30,   0,  0, 21,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW209/311"       , UNDEAD   , THING  }, // 521
{"Pit Demon"                          , 59,  0,   0,  10,   0,  0, 18,  0,   0,  15,   0,  -1,  -1,  -1,   0, 8, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW209"           , DEMON    , THING  }, // 522
{"Skeleton"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,   5,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW229"           , SKELETON , THING  }, // 523
{"Giant snake"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW237"           , ANIMAL   , FEMALE }, // 524
{"Sand shark"                          , 0,  0,   0,   0,   0,  0, 40,  0,   0,   6,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW214/246"       , ANIMAL   , THING  }, // 525
{"Giant slug"                          , 0,  0,   0,   0,   0,  0, 20,  0,   0,  35,  72,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW9/38/255"      , ANIMAL   , THING  }, // 526 30' long
{"Dark Wraith and Shacath"             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW258"           , UNDEAD   , THING  }, // 527 UNDEAD only applies to the rider
{"Goblin"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,   5,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW260/275"       , GOBLIN   , THING  }, // 528
{"Orc"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,   7,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW264/282"       , ORC      , THING  }, // 529
{"Sectional monster"                   , 0,  0,   0,   0,   0,  0,  0,  0,   0,  45,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW285"           , OTHER    , THING  }, // 530
{"Timberwolf"                          , 0,  0,   0,   0,   0,  0, 35,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW133/295"       , WEREWOLF , THING  }, // 531
{"Aza-zel"                             ,30,  0,   0,   0,   0,  0,  0,  0,   0,  35,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW299"           , HUMAN    , MALE   }, // 532
{"Ghost"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30, 480,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "BW99/300"        , GHOST    , THING  }, // 533
{"Human miner"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT6"             , HUMAN    , MALE   }, // 534
{"Human miner"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  14,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT6"             , HUMAN    , MALE   }, // 535
{"Dwarven miner"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  24,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT6"             , DWARF    , MALE   }, // 536
{"Dwarven miner"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  36,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT6"             , DWARF    , MALE   }, // 537
{"Gambler"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | USE_AP , 0, "DT353"           , HUMAN    , MALE   }, // 538
{"Gambler"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  13,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | USE_AP , 0, "DT353"           , HUMAN    , MALE   }, // 539
{"Gambler"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  14,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | USE_AP , 0, "DT353"           , HUMAN    , MALE   }, // 540
{"Old soldier"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 8, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT30"            , HUMAN    , MALE   }, // 541
{"Orcish bowman"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  24,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT39"            , ORC      , MALE   }, // 542
{"Cave beast"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,  84,  -1,  -1,  -1,   0, 6, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT44"            , OTHER    , THING  }, // 543 or perhaps ANIMAL?
{"Green-robed guard"                   , 0,  0,   0,   0,   0,  0,  0,  0,   0,  24,   0,  -1,  -1,  -1,   0, 6, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT47"            , HUMAN    , MALE   }, // 544
{"Bandit"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT58/360"        , HUMAN    , MALE   }, // 545
{"Cultist"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  16,   0,  -1,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT80"            , HUMAN    , MALE   }, // 546
{"Priest"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT80"            , HUMAN    , MALE   }, // 547
{"Cultist"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT93/118"        , HUMAN    , MALE   }, // 548 also DT WMT D.2
{"Temple guard"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  16,   0,  -1,  -1,  -1,   0, 5, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT98/118"        , HUMAN    , MALE   }, // 549
{"Orcish sentry"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT104"           , ORC      , MALE   }, // 550
{"Orcish sentry"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT104"           , ORC      , MALE   }, // 551
{"Guard"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  16,   0,  -1,  -1,  -1,   0, 8, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT122"           , HUMAN    , MALE   }, // 552
{"Old wizard"                          ,18,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT122"           , HUMAN    , MALE   }, // 553
{"Jailer"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  32,   0,  -1,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT130"           , HUMAN    , MALE   }, // 554
{"Green dragon"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0, 120,   0,  -1,  -1,  -1,   0, 8, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT135/308"       , DRAGON   , THING  }, // 555 or perhaps MALE? (referred to as both "it" and "him")
{"Griffin"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT149"           , GRIFFIN  , THING  }, // 556
{"Yastri Kroll"                        ,17, 14,  13,  24,  16, 25,  0,  0,  10,   0,   0, THB,  -1, 888,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "DT151/190/198"   , HUMAN    , MALE   }, // 557
{"Barbarian"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  15,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT152"           , HUMAN    , MALE   }, // 558
{"Purple hobbit"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  22,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT163"           , WHITEHOBBIT, MALE }, // 559
{"Temple warrior"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  16,   0,  -1,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT80/82/93"      , HUMAN    , MALE   }, // 560
{"Acolyte"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT189"           , HUMAN    , MALE   }, // 561
{"Ogre"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  60,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT209"           , OGRE     , MALE   }, // 562
{"Bat"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,   8,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT217"           , ANIMAL   , THING  }, // 563
{"Huge limb-snake"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,  30, 4, CALC_DICE | CALC_ADDS | USE_AP , 0, "DT236"           , ANIMAL   , THING  }, // 564
{"Rolgan the Surgeon"                  ,15, 12,  15,  19,  24, 17,  0,  0,  18,  30,   0, SWC,  -1, ADB,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "DT257"           , HUMAN    , MALE   }, // 565
{"Temple warrior"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  16,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT198"           , HUMAN    , MALE   }, // 566
{"Tentacle beast"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  80,   0,  -1,  -1,  -1,   0, 6, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT199"           , OTHER    , THING  }, // 567
{"Merchant"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  18,   0,  -1,  -1,  -1,   0, 3, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT280"           , HUMAN    , MALE   }, // 568
{"Baron Ulkara"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  48,   0,  -1,  -1, LEA,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT323/376"       , HUMAN    , MALE   }, // 569
{"Guard"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  14,   0,  -1,  -1,  -1,   0,10, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT328"           , HUMAN    , MALE   }, // 570
{"Mortol"                              , 0,  0,   0,  18,   0,  0,  0,  0,   6,   0,   0, 899,  -1, CLO,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "DT339/376/390"   , HUMAN    , MALE   }, // 571
{"Warrior"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  18,   0,  -1,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT340"           , HUMAN    , MALE   }, // 572
{"Mercenary"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  18,   0,  -1,  -1,  -1,   0, 6, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT370"           , HUMAN    , MALE   }, // 573
{"Guard"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  14,   0,  -1,  -1,  -1,   0, 6, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT379"           , HUMAN    , MALE   }, // 574
{"Giant"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT380"           , GIANT    , MALE   }, // 575
{"Officer"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  24,   0,  -1,  -1,  -1,   0,10, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT389"           , HUMAN    , MALE   }, // 576
{"Ogre-like creature"                  , 0,  0,   0,   0,   0,  0,  0,  0,   0,  58,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT396"           , OGRE     , THING  }, // 577 %%: perhaps not really an OGRE? more of a golem?
{"Old wizard"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT397"           , HUMAN    , MALE   }, // 578
{"Guard"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  18,   0,  -1,  -1,  -1,   0, 6, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT397"           , HUMAN    , MALE   }, // 579
{"Soldier"                             , 0,  0,   0,   0,  15,  0,  0,  0,   0,  16,   0, MLB,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT412"           , HUMAN    , MALE   }, // 580
{"Soldier"                             , 0,  0,   0,   0,  15,  0,  0,  0,   0,  16,   0,  -1,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT412"           , HUMAN    , MALE   }, // 581
{"Cultist"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  16,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT82/93"         , HUMAN    , MALE   }, // 582
{"Wizard-spirit"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  70,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | USE_AP , 0, "DT391"           , GHOST    , THING  }, // 583
{"Yastri Kroll"                        ,17, 14,  13,  24,  16, 25,  0,  0,  10,   0,   0, HEM,  -1, 888,   0, 0, CALC_DICE | USE_ADDS  | CALC_AP, 0, "DT406"           , HUMAN    , MALE   }, // 584
{"Three-eyed ogre"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT225"           , OGRE     , THING  }, // 585
{"Bridge troll"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  35,   0,  -1,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT225"           , TROLL    , THING  }, // 586
{"Emaciated adventurer"                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1, TAR,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT225"           , HUMAN    , MALE   }, // 587
{"Malformed wolf"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  24,   0,  -1,  -1,  -1,   0, 6, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT225"           , ANIMAL   , THING  }, // 588
{"Bandit"                              , 0,  0,   0,   0,  14,  0,  0,  0,   0,  12,   0, BOW,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT"              , HUMAN    , MALE   }, // 589 DT WMT A.2
{"Slaver"                              , 0,  0,   0,   0,  14,  0,  0,  0,   0,  12,   0, 122,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT"              , HUMAN    , MALE   }, // 590 DT WMT A.3
{"Horseman"                            , 0,  0,   0,   0,  14,  0,  0,  0,   0,  16,   0, BOW,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT"              , HUMAN    , MALE   }, // 591 DT WMT A.4
{"Horse"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  16,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT"              , ANIMAL   , MALE   }, // 592 DT WMT A.4
{"Highwayman"                          , 0,  0,   0,   0,  16,  0,  0,  0,   0,  16,   0, CRO, BUC,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT"              , HUMAN    , MALE   }, // 593 DT WMT A.6
{"Wandering mercenary"                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  24,   0,  -1,  -1,  -1,   0, 8, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT"              , HUMAN    , MALE   }, // 594 DT WMT A.7
{"Grizzled fighter"                    , 0,  0,   0,   0,   0,  0,  0,  0,   0,  24,   0,  -1,  -1,  -1,   0, 8, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT"              , HUMAN    , MALE   }, // 595 DT WMT A.8
{"Amazon"                              , 0,  0,   0,   0,  15,  0,  0,  0,   0,  20,   0, MLB,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT"              , HUMAN    , FEMALE }, // 596 DT WMT A.11
{"Troll"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT"              , TROLL    , MALE   }, // 597 DT WMT C.4
{"Orcish bandit"                       , 0,  0,   0,   0,  14,  0,  0,  0,   0,  16,   0, JAV,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT"              , ORC      , MALE   }, // 598 DT WMT C.6
{"Wolf"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT"              , ANIMAL   , THING  }, // 599 DT WMT C.7
{"Werewolf"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  48,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT"              , WEREWOLF , THING  }, // 600 DT WMT C.12
{"Guard"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  14,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT"              , HUMAN    , MALE   }, // 601 DT WMT D.2
{"Blue wizard"                         ,30, 18,  14,  18,  13, 15,  0,  0,  10,   0,   0, SAX,  -1, LEA,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "DT258/268"       , HUMAN    , MALE   }, // 602
{"Bandit"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  14,   0,  -1,  -1,  -1,   0, 4, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT259"           , HUMAN    , MALE   }, // 603
{"Horseman"                            ,18, 14,  19,  23,  12, 19,  0,  0,   0,   0,   0, BRO, KNI, MAI,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT269"           , HUMAN    , MALE   }, // 604
{"Famous rogue"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT275"           , HUMAN    , MALE   }, // 605
{"Bandit leader"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  24,   0,  -1,  -1,  -1,   0, 8, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT281"           , HUMAN    , MALE   }, // 606
{"Bandit guard"                        , 0,  0,   0,   0,   0,  0,  0,  0,   0,  14,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT281/285"       , HUMAN    , MALE   }, // 607
{"Muscular bandit"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 6, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT285"           , HUMAN    , MALE   }, // 608
{"Faerie knight"                       ,12, 30,  20,  20,  18,  9,  0,  7,   0,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "DT291"           , FAIRY    , MALE   }, // 609 %%: maybe do his weasel whip as a proper item?
{"Cultist"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,  18, 0, CALC_DICE | CALC_ADDS | USE_AP , 0, "DT292"           , HUMAN    , MALE   }, // 610
{"Elf captain"                         ,17, 16,  13,  14,  21, 25,  0,  0,   0,   0,   0, 912,  -1, MAI,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT297"           , ELF      , MALE   }, // 611
{"Pegasus"                             , 0,  0,   0,  20,   0,  0,  0,  3,   0,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "DT297"           , OTHER    , THING  }, // 612
{"Warrior-mystic"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  24,   0,  -1,  -1,  -1,  30, 4, CALC_DICE | CALC_ADDS | USE_AP , 0, "DT299"           , HUMAN    , MALE   }, // 613
{"Dancer"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT302"           , HUMAN    , MALE   }, // 614
{"Dancer"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  12,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT302"           , HUMAN    , FEMALE }, // 615
{"Wight"                               , 0,  0,   0,  25,   0,  0,  0,  0,   0,   0,   0,  -1,  -1,  -1,   0,12, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT321"           , UNDEAD   , THING  }, // 616
{"Myrean soldier"                      , 0,  0,   0,   0,   0,  0,  0,  0,   0,  14,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT"              , HUMAN    , MALE   }, // 617 DT WMT A.5
{"Whirlwind of green dust"             , 0,  0,   0,  50,   0,  0,  0,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "DT313"           , ELEMENTAL, THING  }, // 618
{"Gargoyle"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  45,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL7"             , OTHER    , THING  }, // 619
{"Spy"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  48,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL15"            , HUMAN    , MALE   }, // 620
{"Orc"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  15,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL21/132"        , ORC      , THING  }, // 621
{"Man"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0, 100,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL23"            , HUMAN    , MALE   }, // 622
{"Wizard"                              , 0,  0,   0,  12,   0,  0,  0,  0,   0,   0,   0, DRK,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL24"            , HUMAN    , MALE   }, // 623
{"Dockworker"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  55,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL25"            , HUMAN    , MALE   }, // 624
{"Shark"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL27"            , ANIMAL   , THING  }, // 625
{"Warrior"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL39/70"         , HUMAN    , MALE   }, // 626
{"Goblin"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL42/247"        , GOBLIN   , THING  }, // 627
{"Warrior"                             , 0,  0,   0,   0,   0,  0,  0,  0,   0,  50,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL46"            , HUMAN    , MALE   }, // 628
{"Man"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL50"            , HUMAN    , MALE   }, // 629
{"Warrior"                             , 0,  0,   0,  15,   0,  0,  0,  4,  17,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "EL51"            , HUMAN    , MALE   }, // 630
{"Magicker"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL53"            , HUMAN    , MALE   }, // 631
{"Assassin"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  60,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL53"            , HUMAN    , MALE   }, // 632
{"Centauroid"                          , 0,  0,   0,  45,   0,  0,  0, 12,  58,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | CALC_AP, 0, "EL88"            , CENTAUR  , THING  }, // 633 %%: or perhaps ANIMAL or OTHER?
{"Man"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL90"            , HUMAN    , MALE   }, // 634
{"Hybrid puma/squirrel"                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL107"           , ANIMAL   , THING  }, // 635 %%: or perhaps OTHER?
{"Centauroid warrior"                  , 0,  0,   0,   0,   0,  0,  0,  0,   0,  45,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL107"           , CENTAUR  , THING  }, // 636
{"Dwarven warrior"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0,  35,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL107"           , DWARF    , THING  }, // 637
{"Elven warrior maid"                  , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL107"           , ELF      , FEMALE }, // 638
{"Hobbit-naga"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  25,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL107"           , NAGA     , FEMALE }, // 639 %%: or perhaps HOBBIT?
{"Hybrid cockroach/wolf"               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL107"           , ANIMAL   , THING  }, // 640 %%: or perhaps OTHER?
{"Rogue"                               , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL117"           , HUMAN    , MALE   }, // 641
{"Chief of the Klorven"                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL118"           , HUMAN    , MALE   }, // 642
{"Ranger"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  25,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL123"           , HUMAN    , MALE   }, // 643
{"Orc"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL200"           , ORC      , THING  }, // 644
{"Wraith"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  45,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL145"           , UNDEAD   , THING  }, // 645
{"Dragon's tongue"                     , 0,  0,   0,  55,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0,10, USE_DICE  | USE_ADDS  | CALC_AP, 0, "EL154"           , DRAGON   , THING  }, // 646
{"Ursula"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL158/170"       , HUMAN    , FEMALE }, // 647
{"Attendee"                            , 0,  0,   0,   0,   0,  0,  0,  0,   0,  15,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL158"           , HUMAN    , MALE   }, // 648
{"Tiger-cat"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  35,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL162"           , ANIMAL   , THING  }, // 649
{"Grub-worm"                           , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL167"           , ANIMAL   , THING  }, // 650 %%: or perhaps OTHER?
{"Ursula & urchin"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0,  35,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL170"           , HUMAN    , THING  }, // 651
{"Mist"                                , 0,  0,   0,   0,   0,  0,  0,  0,   0,  30,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL172"           , DRAGON   , THING  }, // 652
{"Dragon's stomach"                    , 0,  0,   0,   0,   0,  0,  0,  0,   0,  15,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL181"           , DRAGON   , THING  }, // 653
{"Goblin"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  42,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL190"           , GOBLIN   , MALE   }, // 654
{"Orc shaman"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  35,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL208"           , ORC      , MALE   }, // 655
{"Rat"                                 , 0,  0,   0,   0,   0,  0,  0,  0,   0,   5,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL219"           , ANIMAL   , THING  }, // 656
{"Goblin"                              , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL237"           , GOBLIN   , MALE   }, // 657
{"Goblin leader"                       , 0,  0,   0,   0,   0,  0,  0,  0,   0,  15,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL237"           , GOBLIN   , MALE   }, // 658
{"Worker orc"                          , 0,  0,   0,   0,   0,  0,  0,  0,   0,  10,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL21/175/224"    , ORC      , THING  }, // 659
{"Ursula & urchin"                     , 0,  0,   0,   0,   0,  0,  0,  0,   0,  40,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL241"           , HUMAN    , THING  }, // 660
{"Windlass"                            , 0,  0,   0, 100,   0,  0,  0,  0,   0,   0,   0,  -1,  -1,  -1,   0, 0, USE_DICE  | USE_ADDS  | USE_AP , 0, "EL224"           , OTHER    , THING  }, // 661
{"Orc trooper"                         , 0,  0,   0,   0,   0,  0,  0,  0,   0,  16,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL224"           , ORC      , THING  }, // 662
{"Spy"                                 ,20,  0,   0,   0,   0,  0,  0,  0,   0,  20,   0,  -1,  -1,  -1,   0, 0, CALC_DICE | CALC_ADDS | CALC_AP, 0, "EL85"            , HUMAN    , MALE   }, // 663
};
