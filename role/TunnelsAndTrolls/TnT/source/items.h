#define UK 1 // items with UnKnown weight (because not specified in module); we assume them to weigh 0.1# each.
// %%: "slaves" that need to be carried should weigh something.

EXPORT struct ItemStruct items[ITEMS] = {
// Swords (0..21)                   hnds d6 add st dex cost  weight range hit magic  type           module     prgrphs chrgs
{"Great sword (6')"                 , 2, 6,  0, 21, 18, 12000,  170,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  53,  -1,  0}, //   0* aka claymore (BS11)
{"Two-handed broadsword (5')"       , 2, 5,  2, 17, 14, 11000,  160,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  24,  -1,  0}, //   1-
{"Hand-and-a-half sword (4')"       , 1, 5,  0, 16, 12,  9000,  150,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  25,  -1,  0}, //   2-
{"Broadsword (3'-4')"               , 1, 3,  4, 15, 10,  7000,  120,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  26,  -1,  0}, //   3*
{"Gladius (2½'-3')"                 , 1, 3,  2, 10,  7,  5000,   70,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  -1,  -1,  0}, //%  4-
{"Short sword (2'-2½')"             , 1, 3,  0,  7,  3,  3500,   30,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB, 103,  -1,  0}, //   5*
{"Grand shamsheer (No-datchi) (6')" , 2, 6,  2, 22, 18, 13500,  150,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  51,  -1,  0}, //%  6-
{"Great shamsheer (4½'-5')"         , 2, 5,  0, 15, 15, 10000,  130,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  52,  -1,  0}, //   7-
{"Falchion (4')"                    , 1, 4,  4, 12, 13,  7500,  110,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  43,  -1,  0}, //%  8*
{"Scimitar (3')"                    , 1, 4,  0, 10, 11,  6000,  100,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB, 101,  -1,  0}, //%  9*
{"Sabre (3')"                       , 1, 3,  4,  9, 10,  5500,   60,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  97,  -1,  0}, //% 10-
{"Short sabre (2'-2½')"             , 1, 3,  1,  7,  5,  4000,   30,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  98,  -1,  0}, //  11-
{"Flamberge (6')"                   , 2, 6,  1, 21, 18, 12500,  165,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  47,  -1,  0}, //% 12-
{"Pata (long katar) (3'-4')"        , 1, 4,  0, 14, 14, 10000,   90,   0,  1, FALSE, WEAPON_SWORD , MODULE_RB,  82,  -1,  0}, //  13-
{"Shotel (3'-4')"                   , 1, 3,  3, 10, 17,  5000,   75,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB, 104,  -1,  0}, //% 14-
{"Manople (2'-3')"                  , 1, 2,  2, 10, 10,  8500,   80,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  76,  -1,  0}, //% 15-
{"Rapier (3'-5')"                   , 1, 3,  4, 10, 14,  8000,   20,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  95,  -1,  0}, //  16*
#ifdef WIN32
{"Epee (3'-5')"                     , 1, 3,  2,  9, 15,  7500,   25,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  40,  -1,  0}, //  17-
#endif
#ifdef AMIGA
{"Epée (3'-5')"                     , 1, 3,  2,  9, 15,  7500,   25,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  40,  -1,  0}, //  17-
#endif
{"Foil (3'-4')"                     , 1, 2,  1,  7, 14,  5000,   15,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  48,  -1,  0}, //  18-
{"Sword cane (2'-3')"               , 1, 3,  0, 10, 12,  5000,   10,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB, 113,  -1,  0}, //% 19-
{"Terbutje"                         , 1, 3,  5,  6, 10,  6500,   35,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB, 115,  -1,  0}, //% 20-
{"Estok"                            , 1, 3,  0, 12, 10,  8000,   75,   0,  0, FALSE, WEAPON_SWORD , MODULE_RB,  41,  -1,  0}, //  21-
// Hafted Weapons (22..43)
{"Double-bladed broad axe"          , 2, 6,  3, 21, 10, 14000,  220,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,   7,  -1,  0}, //  22* aka double-bladed war axe (DE29), doublebitted axe (MS)
{"Great axe"                        , 2, 5,  3, 20, 10, 11000,  190,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,   8,  -1,  0}, //  23-
{"Bullova"                          , 2, 4,  3, 16,  9, 10000,  200,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,  28,  -1,  0}, //  24-
{"Broadaxe"                         , 1, 4,  0, 17,  8, 10000,  150,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,   9,  -1,  0}, //  25-
{"Sickle (3')"                      , 1, 4,  1, 11,  7, 11000,  130,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB, 107,  -1,  0}, //% 26-
{"Bhuj"                             , 1, 3,  4, 15,  7, 10000,  160,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,  16,  -1,  0}, //  27-
{"Francisca"                        , 1, 3,  2,  9,  5,  7000,   60,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,  49,  -1,  0}, //% 28-
{"Taper axe"                        , 1, 3,  0,  8,  4,  5000,   70,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,  10,  -1,  0}, //  29-
{"Bec de corbin"                    , 2, 6,  0, 18, 10, 12500,  175,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,  15,  -1,  0}, //% 30-
{"Zaghnal"                          , 1, 3,  4, 10,  8,  8500,  170,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB, 121,  -1,  0}, //% 31-
{"Adze"                             , 1, 3,  0,  9,  5,  5000,  100,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,   0,  -1,  0}, //% 32-
{"Pick axe"                         , 1, 3,  0, 15, 10,  1500,  160,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,  83,  -1,  0}, //  33-
{"Heavy mace"                       , 2, 5,  2, 17,  3, 12000,  200,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,  59,  -1,  0}, //% 34*
{"War hammer"                       , 1, 5,  1, 16,  3,  8500,  300,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB, 120,  -1,  0}, //% 35-
{"Morningstar"                      , 1, 5,  0, 17, 11, 14000,  110,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,  79,  -1,  0}, //% 36-
{"Heavy flail"                      , 1, 4,  4, 20, 15,  5500,  160,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,  45,  -1,  0}, //% 37-
{"Light flail"                      , 1, 3,  4, 19, 13,  7000,  140,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,  46,  -1,  0}, //  38-
{"Mitre"                            , 1, 3,  0,  8,  3,  5000,   90,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,  78,  -1,  0}, //  39-
{"Bludgeon (club)"                  , 1, 3,  0,  5,  2,  1500,   50,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,  20,  -1,  0}, //  40*
{"Baton"                            , 1, 2,  0,  2,  1,  1000,   20,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,  14,  -1,  0}, //  41*
{"Piton hammer"                     , 1, 1,  0,  5,  1,   400,   25,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,  86,  -1,  0}, //  42-
{"Crowbar"                          , 1, 2,  0, 10,  1,   500,   35,   0,  0, FALSE, WEAPON_HAFTED, MODULE_RB,  35,  -1,  0}, //  43-
// Pole Weapons (44..58)
{"Poleaxe (10')"                    , 2, 7,  0, 14, 13, 21000,  300,   0,  0, FALSE, WEAPON_POLE  , MODULE_RB,  88,  -1,  0}, //% 44-
{"Chauves souris (12')"             , 2, 6,  5, 15, 12, 25000,  190,   0,  0, FALSE, WEAPON_POLE  , MODULE_RB,  31,  -1,  0}, //  45-
{"Ranseur (runka) (12')"            , 2, 6,  4, 15, 10, 17000,  180,   0,  0, FALSE, WEAPON_POLE  , MODULE_RB,  94,  -1,  0}, //% 46-
{"Halbard (10')"                    , 2, 6,  0, 16, 12, 20000,  250,   0,  0, FALSE, WEAPON_POLE  , MODULE_RB,  58,  -1,  0}, //% 47-
{"Pike (12')"                       , 2, 6,  0, 15, 12, 16000,  100,   0,  0, FALSE, WEAPON_POLE  , MODULE_RB,  84,  -1,  0}, //% 48-
{"Demi-lune (halfmoon) (12')"       , 2, 5,  4, 12, 20, 10000,  150,   0,  0, FALSE, WEAPON_POLE  , MODULE_RB,  37,  -1,  0}, //% 49-
{"Voulge (10')"                     , 2, 5,  1, 15,  9, 16000,  200,   0,  0, FALSE, WEAPON_POLE  , MODULE_RB, 119,  -1,  0}, //% 50-
{"Fauchard (12')"                   , 2, 5,  0, 13, 10, 16000,  180,   0,  0, FALSE, WEAPON_POLE  , MODULE_RB,  44,  -1,  0}, //% 51-
{"Partizan (8')"                    , 2, 4,  5, 15,  9, 14000,  200,   0,  0, FALSE, WEAPON_POLE  , MODULE_RB,  81,  -1,  0}, //% 52-
{"Guisarme (9')"                    , 2, 4,  4, 14, 10, 13500,  200,   0,  0, FALSE, WEAPON_POLE  , MODULE_RB,  56,  -1,  0}, //% 53-
{"Scythe (long) (6')"               , 2, 4,  2, 11,  7,  8000,  150,   0,  0, FALSE, WEAPON_POLE  , MODULE_RB, 106,  -1,  0}, //% 54-
{"Billhook (11')"                   , 2, 4,  0, 14,  8, 12000,  190,   0,  0, FALSE, WEAPON_POLE  , MODULE_RB,  18,  -1,  0}, //% 55-
{"Kumade (rake) (5')"               , 2, 3,  3, 10, 12,  7500,   90,   0,  0, FALSE, WEAPON_POLE  , MODULE_RB,  68,  -1,  0}, //  56-
{"Brandestock (6')"                 , 2, 3,  1, 17, 10, 20000,  150,   0,  0, FALSE, WEAPON_POLE  , MODULE_RB,  23,  -1,  0}, //  57-
{"Extended Brandestock (9')"        , 2, 4,  0, 19, 12, 28000,  200,   0,  0, FALSE, WEAPON_POLE  , MODULE_RB,  23,  -1,  0}, //  58-
// Spears (59..67)
{"Pilum (5'-8')"                    , 1, 5,  0, 12,  8,  7500,  100,  20,  0, FALSE, WEAPON_SPEAR , MODULE_RB,  85,  -1,  0}, //  59-
{"Trident (6')"                     , 1, 4,  3, 10, 10,  6000,   75,  10,  0, FALSE, WEAPON_SPEAR , MODULE_RB, 117,  -1,  0}, //% 60*
{"Hoko (6')"                        , 1, 4,  1, 10, 12,  5500,   90,   0,  0, FALSE, WEAPON_SPEAR , MODULE_RB,  61,  -1,  0}, //  61-
{"Oxtongue (hasta) (6')"            , 1, 4,  0, 10,  5,  8000,   70,   0,  0, FALSE, WEAPON_SPEAR , MODULE_RB,  80,  -1,  0}, //% 62-
{"Spontoon (8')"                    , 2, 3,  3,  9,  9,  3000,  100,   0,  0, FALSE, WEAPON_SPEAR , MODULE_RB, 108,  -1,  0}, //  63-
{"Common spear (6')"                , 1, 3,  1,  8,  8,  2200,   50,  40,  0, FALSE, WEAPON_SPEAR , MODULE_RB,  36,  -1,  0}, //% 64*
{"Assegai (6')"                     , 1, 2,  3,  7, 12,  2000,   50,  30,  0, FALSE, WEAPON_SPEAR , MODULE_RB,   5,  -1,  0}, //% 65-
{"Javelin (6')"                     , 1, 2,  0,  5,  7,  1000,   30,  40,  0, FALSE, WEAPON_THROWN, MODULE_RB,  63,  -1,  0}, //  66-
{"Atl-atl"                          , 1, 0,  0,  8, 10,   500,  100,   0,  0, FALSE, WEAPON_OTHER , MODULE_RB,   6,  -1,  0}, //% 67
// Daggers (68..81)
{"Sax"                              , 1, 2,  5,  7, 10,  3000,   25,   0,  0, FALSE, WEAPON_DAGGER, MODULE_RB,  99,  -1,  0}, //  68* aka scramasax
{"Kukri"                            , 1, 2,  5,  6,  6,  3000,   20,  15,  0, FALSE, WEAPON_DAGGER, MODULE_RB,  67,  -1,  0}, //% 69-
{"Katar"                            , 1, 2,  4,  2,  8,  1800,   22,   0,  0, FALSE, WEAPON_DAGGER, MODULE_RB,  64,  -1,  0}, //% 70-
{"Haladie"                          , 1, 2,  4,  2,  4,  2500,   15,   0,  0, FALSE, WEAPON_DAGGER, MODULE_RB,  57,  -1,  0}, //% 71*
{"Bank"                             , 1, 2,  3,  1,  1,  1800,   20,   0,  0, FALSE, WEAPON_DAGGER, MODULE_RB,  13,  -1,  0}, //% 72-
{"Bich'wa"                          , 1, 2,  3,  1,  4,  2000,   33,  10,  0, FALSE, WEAPON_DAGGER, MODULE_RB,  17,  -1,  0}, //% 73-
{"Kris"                             , 1, 2,  3,  8,  5, 12000,   50,  10,  0, FALSE, WEAPON_DAGGER, MODULE_RB,  66,  -1,  0}, //% 74-
{"Jambiya"                          , 1, 2,  2,  2,  8,  2100,   12,  10,  0, FALSE, WEAPON_DAGGER, MODULE_RB,  62,  -1,  0}, //  75-
{"Dirk"                             , 1, 2,  1,  1,  4,  1800,   16,  10,  0, FALSE, WEAPON_DAGGER, MODULE_RB,  38,  -1,  0}, //% 76*
{"Misericorde"                      , 1, 2,  1,  1,  2,  1400,   14,  10,  0, FALSE, WEAPON_DAGGER, MODULE_RB,  77,  -1,  0}, //% 77-
{"Main gauche"                      , 1, 2,  0, 10, 12,  2500,   25,   0,  1, FALSE, WEAPON_DAGGER, MODULE_RB,  75,  -1,  0}, //  78-
{"Poniard"                          , 1, 2,  0,  1,  3,  1000,   10,  10,  0, FALSE, WEAPON_DAGGER, MODULE_RB,  89,  -1,  0}, //  79-
{"Swordbreaker"                     , 1, 2,  0, 10, 12,  1500,   15,   0,  0, FALSE, WEAPON_DAGGER, MODULE_RB, 112,  -1,  0}, //% 80-
{"Stiletto"                         , 1, 2, -2,  1,  1,   500,   10,   5,  0, FALSE, WEAPON_DAGGER, MODULE_RB, 111,  -1,  0}, //  81-
// Projectile Weapons (82..122)
{"Cranequin"                        , 2, 8,  0, 15, 10, 60000,  250, 100,  0, FALSE, WEAPON_XBOW  , MODULE_RB,  32,  -1,  0}, //% 82-
{"Arbalest"                         , 2, 6,  3, 17, 10, 40000,  220, 100,  0, FALSE, WEAPON_XBOW  , MODULE_RB,   3,  -1,  0}, //% 83-
{"Crossbow"                         , 2, 5,  0, 15, 10, 25000,  180, 100,  0, FALSE, WEAPON_XBOW  , MODULE_RB,  33,  -1,  0}, //  84*
{"Light crossbow"                   , 2, 4,  0, 12, 10, 17000,  120,  90,  0, FALSE, WEAPON_XBOW  , MODULE_RB,  33,  -1,  0}, //  85-
{"Dokyu"                            , 2, 4,  0, 15, 16, 30000,  200,  75,  0, FALSE, WEAPON_XBOW  , MODULE_RB,  39,  -1,  0}, //  86-
{"Prodd"                            , 2, 8,  0, 15, 10, 60000,  250, 100,  0, FALSE, WEAPON_XBOW  , MODULE_RB,  90,  -1,  0}, //  87-
{"Quarrel(s)"                       , 0, 0,  0,  0,  0,    50,    1,   0,  0, FALSE, WEAPON_QUARREL,MODULE_RB,  91,  -1,  0}, //% 88-
{"Stone(s)"                         , 0, 0,  0,  0,  0,     3,    1,   0,  0, FALSE, WEAPON_STONE , MODULE_RB,  -1,  -1,  0}, //  89- Really weighs 0.5cn (0.05#)
{"Extra-heavy self-bow"             , 2, 6,  0, 25, 17, 20000,   70, 100,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //% 90-
{"Heavy self-bow"                   , 2, 5,  0, 20, 16, 13500,   60,  90,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //% 91-
{"Medium self-bow"                  , 2, 4,  0, 15, 15,  8000,   50,  80,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //% 92-
{"Light self-bow"                   , 2, 3,  0, 12, 15,  6000,   40,  70,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //% 93-
{"Very light self-bow"              , 2, 2,  0,  9, 15,  5000,   30,  60,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //% 94*
{"Extra-heavy built self-bow"       , 2, 6,  1, 25, 17, 30000,   70, 110,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //% 95-
{"Heavy built self-bow"             , 2, 5,  1, 20, 16, 20250,   60, 100,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //% 96-
{"Medium built self-bow"            , 2, 4,  1, 15, 15, 12000,   50,  90,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //% 97-
{"Light built self-bow"             , 2, 3,  1, 12, 15,  9000,   40,  80,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //% 98-
{"Very light built self-bow"        , 2, 2,  1,  9, 15,  7500,   30,  70,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //% 99-
{"Extra-heavy backed self-bow"      , 2, 6,  2, 25, 17, 30000,   70, 120,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //%100-
{"Heavy backed self-bow"            , 2, 5,  2, 20, 16, 20250,   60, 110,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //%101-
{"Medium backed self-bow"           , 2, 4,  2, 15, 15, 12000,   50, 100,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //%102-
{"Light backed self-bow"            , 2, 3,  2, 12, 15,  9000,   40,  90,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //%103-
{"Very light backed self-bow"       , 2, 2,  2,  9, 15,  7500,   30,  80,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //%104-
{"Extra-heavy built backed self-bow", 2, 6,  3, 25, 17, 40000,   70, 130,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //%105-
{"Heavy built backed self-bow"      , 2, 5,  3, 20, 16, 27000,   60, 120,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //%106-
{"Medium built backed self-bow"     , 2, 4,  3, 15, 15, 16000,   50, 110,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //%107-
{"Light built backed self-bow"      , 2, 3,  3, 12, 15, 12000,   40, 100,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //%108-
{"Very light built backed self-bow" , 2, 2,  3,  9, 15, 10000,   30,  90,  0, FALSE, WEAPON_BOW   , MODULE_RB, 102,  -1,  0}, //%109-
{"Extra-heavy longbow"              , 2, 6,  3, 25, 17, 25000,   80, 160,  0, FALSE, WEAPON_BOW   , MODULE_RB,  72,  -1,  0}, //%110-
{"Heavy longbow"                    , 2, 5,  3, 20, 16, 17500,   70, 150,  0, FALSE, WEAPON_BOW   , MODULE_RB,  72,  -1,  0}, //%111-
{"Medium longbow"                   , 2, 4,  3, 15, 15, 10000,   60, 140,  0, FALSE, WEAPON_BOW   , MODULE_RB,  72,  -1,  0}, //%112*
{"Arrow(s)"                         , 0, 0,  0,  0,  0,   160,    1,   0,  0, FALSE, WEAPON_ARROW , MODULE_RB,  -1,  -1,  0}, // 113* Really weighs about 0.4cn (0.04#)
{"Staff sling"                      , 2, 3,  0,  5, 11,   500,  100, 150,  0, FALSE, WEAPON_SLING , MODULE_RB, 109,  -1,  0}, // 114-
{"Common sling"                     , 1, 2,  0,  3,  5,   100,   10, 100,  0, FALSE, WEAPON_SLING , MODULE_RB,  34,  -1,  0}, // 115-
{"African throwing knife"           , 1, 4,  0,  8, 15, 18000,  125,  30,  0, FALSE, WEAPON_THROWN, MODULE_RB,   1,  -1,  0}, //%116-
{"Chakram"                          , 1, 2,  0,  4, 14,   280,    4,  30,  0, FALSE, WEAPON_THROWN, MODULE_RB,  30,  -1,  0}, //%117-
{"Shuriken"                         , 1, 1,  0,  2, 10,  1000,    3,  10,  0, FALSE, WEAPON_THROWN, MODULE_RB, 105,  -1,  0}, //%118- Really weighs 3.3'cn (0.3'#)
{"Blowpipe"                         , 1, 0,  1,  1,  1,  1000,   30,  35,  0, FALSE, WEAPON_BLOWPIPE,MODULE_RB, 19,  -1,  0}, // 119
{"Dart"                             , 1, 0,  0,  8, 10,   500,    5,   0,  0, FALSE, WEAPON_DART  , MODULE_RB,  -1,  -1,  0}, // 120  Can't be thrown, according to the rulebook
{"Hunting bola"                     , 1, 0,  0,  5,  8,  3500,   50,  30,  0, FALSE, WEAPON_THROWN, MODULE_RB,  21,  -1,  0}, //%121
{"War bola"                         , 1, 2,  0,  7,  8, 10000,   80,  30,  0, FALSE, WEAPON_THROWN, MODULE_RB,  22,  -1,  0}, // 122
// Others (123..127)
{"Ankus"                            , 1, 2,  1,  2, 11,  2700,   50,   0,  0, FALSE, WEAPON_OTHER , MODULE_RB,   2,  -1,  0}, //%123-
{"Bagh Nakh (tiger claw)"           , 1, 1,  0,  2, 10,  3000,   15,   0,  0, FALSE, WEAPON_OTHER , MODULE_RB,  12,  -1,  0}, //%124-
{"Quarterstaff"                     , 2, 2,  0,  2,  8,  1000,   50,   0,  0, FALSE, WEAPON_STAFF , MODULE_RB,  93,  -1,  0}, // 125*
{"Large caltrop"                    , 2, 2,  0,  0,  0,   300,   20,   0,  0, FALSE, WEAPON_OTHER , MODULE_RB,  29,  -1,  0}, //%126
{"Small caltrop"                    , 2, 1,  0,  0,  0,   100,    6,   0,  0, FALSE, WEAPON_OTHER , MODULE_RB,  29,  -1,  0}, //%127
// Armour
{"Complete plate"                   , 0, 0,  0, 11,  0, 50000, 1000,   0, 14, FALSE, ARMOUR       , MODULE_RB,  87,  -1,  0}, // 128-
{"Complete mail"                    , 0, 0,  0, 12,  0, 30000, 1200,   0, 11, FALSE, ARMOUR       , MODULE_RB,  74,  -1,  0}, // 129*
{"Complete lamellar"                , 0, 0,  0,  5,  0, 40000,  900,   0, 10, FALSE, ARMOUR       , MODULE_RB,  69,  -1,  0}, // 130-
{"Complete scale"                   , 0, 0,  0,  7,  0,  8000,  750,   0,  8, FALSE, ARMOUR       , MODULE_RB, 100,  -1,  0}, // 131-
{"Complete ring-joined plate"       , 0, 0,  0,  4,  0, 10000,  300,   0,  7, FALSE, ARMOUR       , MODULE_RB,  96,  -1,  0}, // 132-
{"Complete leather"                 , 0, 0,  0,  2,  0,  5000,  200,   0,  6, FALSE, ARMOUR       , MODULE_RB,  70,  -1,  0}, // 133*
{"Complete quilted silk/cotton"     , 0, 0,  0,  1,  0,  4000,  100,   0,  3, FALSE, ARMOUR       , MODULE_RB,  92,  -1,  0}, // 134-
{"Back & breast"                    , 0, 0,  0,  3,  0, 25000,  200,   0,  5, FALSE, ARMOUR_CHEST , MODULE_RB,  11,  -1,  0}, // 135- aka cuirass (AK38)
{"Arming doublet"                   , 0, 0,  0,  1,  0,  4000,   75,   0,  3, FALSE, ARMOUR_CHEST , MODULE_RB,   4,  -1,  0}, // 136*
{"Leather jerkin"                   , 0, 0,  0,  1,  0,  1500,   15,   0,  1, FALSE, ARMOUR_CHEST , MODULE_RB,  71,  -1,  0}, // 137-
{"Gauntlets (pair)"                 , 0, 0,  0,  1,  0,  1000,   25,   0,  2, FALSE, ARMOUR_ARMS  , MODULE_RB,  50,  -1,  0}, // 138-
{"Greaves (pair)"                   , 0, 0,  0,  1,  0,  2500,   40,   0,  2, FALSE, ARMOUR_LEGS  , MODULE_RB,  54,  -1,  0}, // 139-
{"Full helm"                        , 0, 0,  0,  1,  0,  2000,   50,   0,  3, FALSE, ARMOUR_HEAD  , MODULE_RB,  60,  -1,  0}, // 140-
{"Greek (open face) helm"           , 0, 0,  0,  1,  0,  1500,   35,   0,  2, FALSE, ARMOUR_HEAD  , MODULE_RB,  55,  -1,  0}, // 141-
{"Steel cap"                        , 0, 0,  0,  1,  0,  1000,   25,   0,  1, FALSE, ARMOUR_HEAD  , MODULE_RB, 110,  -1,  0}, // 142*
{"Face mask"                        , 0, 0,  0,  1,  0,  1000,   25,   0,  1, FALSE, ARMOUR_HEAD  , MODULE_RB,  42,  -1,  0}, // 143-
{"Tower shield"                     , 1, 0,  0,  6,  0, 10000,  550,   0,  6, FALSE, SHIELD       , MODULE_RB, 116,  -1,  0}, // 144
{"Knight's shield"                  , 1, 0,  0,  5,  0,  6500,  450,   0,  5, FALSE, SHIELD       , MODULE_RB,  65,  -1,  0}, // 145-
{"Target shield"                    , 1, 0,  0,  5,  0,  3500,  300,   0,  4, FALSE, SHIELD       , MODULE_RB, 114,  -1,  0}, // 146*
{"Buckler"                          , 1, 0,  0,  1,  0,  1000,   75,   0,  3, FALSE, SHIELD       , MODULE_RB,  27,  -1,  0}, // 147-
{"Viking spike shield"              , 1, 2,  0,  5,  5,  9000,  450,   0,  4, FALSE, SHIELD       , MODULE_RB, 118,  -1,  0}, //%148-
{"Madu (shield)"                    , 1, 1,  3,  1, 15,  1500,   20,   0,  1, FALSE, SHIELD       , MODULE_RB,  73,  -1,  0}, // 149-
// Supplies
{"Warm dry clothing and pack"       , 0, 0,  0,  0,  0,   500,   10,   0,  0, FALSE, NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 150*
{"Provisions for 1 day"             , 0, 0,  0,  0,  0,  1000,   20,   0,  0, FALSE, NONWEAPON    , MODULE_RB, 122,  -1,  0}, // 151*
{"Delver's Package"                 , 0, 0,  0,  0,  0,  2000,   20,   0,  0, FALSE, NONWEAPON    , MODULE_RB, 123,  -1,  0}, // 152-
{"Ordinary torch"                   , 1, 0,  0,  0,  0,    10,   10,   0,  0, FALSE, NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 153*
{"Silk rope (1')"                   , 0, 0,  0,  0,  0,   100,    1,   0,  0, FALSE, NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 154-
{"Hemp rope (1')"                   , 0, 0,  0,  0,  0,    10,    5,   0,  0, FALSE, NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 155*
{"Lantern"                          , 1, 0,  0,  0,  0,  1000,   10,   0,  0, FALSE, NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 156
{"Skin of oil"                      , 0, 0,  0,  0,  0,  1000,   15,   0,  0, FALSE, NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 157-
{"Magnetic compass"                 , 0, 0,  0,  0,  0,   500,    1,   0,  0, FALSE, NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 158-
{"Knee-high boots"                  , 0, 0,  0,  0,  0,  1000,   40,   0,  0, FALSE, NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 159-
{"Calf-high boots"                  , 0, 0,  0,  0,  0,  1000,   20,   0,  0, FALSE, NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 160*
{"Sandals"                          , 0, 0,  0,  0,  0,   200,    2,   0,  0, FALSE, NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 161-
{"Piton"                            , 0, 0,  0,  0,  0,   100,    2,   0,  0, FALSE, NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 162- Really weighs 2.5cn (#0.25)
{"Ordinaire magic staff"            , 0, 0,  0,  0,  0, 10000,   30,   0,  0, TRUE , NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 163*
{"Ordinaire magic quarterstaff"     , 2, 2,  0,  2,  8, 10000,   50,   0,  0, TRUE , WEAPON_STAFF , MODULE_RB,  -1,  -1,  0}, // 164*
{"Deluxe magic staff"               , 0, 0,  0,  0,  0,500000,   30,   0,  0, TRUE , NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 165-
{"Makeshift magic staff"            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 166
// Module-specific
{"Box of Magic Powder"              , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_ND,  47,  -1,  0}, // 167
{"Hopeless Sword"                   , 1, 0,200,  1,  1,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_ND,   7,  -1,  0}, // 168
{"Wombat venom"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, POISON       , MODULE_CT,   6,  -1,  0}, // 169
{"Sonic sword"                      , 1, 3,  5,  0,  0, 10000,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_CT,  66,  -1,  0}, // 170 %%: this is alien, but perhaps not "magic"
{"Amulet of the Red Ogre"           , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CT, 170,  -1,  0}, // 171
{"Goblin spear"                     , 1, 2, -2,  1,  1,   0  ,   UK,   0,  0, FALSE, WEAPON_SPEAR , MODULE_ND,  14,  -1,  0}, // 172
{"Vampire sword"                    , 1, 3,  4, 15, 10,   0  ,  120,   0,  0, TRUE,  WEAPON_SWORD , MODULE_CT,  18,  -1,  0}, // 173
{"Pouch"                            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_ND,  38,  -1,  0}, // 174
{"Crude belt"                       , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_ND,  38,  -1,  0}, // 175
{"Gold chain"                       , 0, 0,  0,  0,  0, 55000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_CT, 122,  -1,  0}, // 176
{"Emerald ring"                     , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, RING         , MODULE_CT, 122,  -1,  0}, // 177
{"Female slave"                     , 0, 0,  0,  0,  0, 50000,    0,   0,  0, FALSE, SLAVE        , MODULE_CT, 122,  -1,  0}, // 178
{"Male slave"                       , 0, 0,  0,  0,  0, 50000,    0,   0,  0, FALSE, SLAVE        , MODULE_CT, 122,  -1,  0}, // 179
{"Ogre's pilum"                     , 2,10,  0,  0,  0,   0  ,  100,   0,  0, FALSE, WEAPON_SPEAR , MODULE_CT, 126, 145,  0}, // 180
{"Sacred Scarab amulet"             , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CT,  53,  -1,  0}, // 181
{"Palantir"                         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CT, 215,  -1,  0}, // 182
{"Self-cloning ring"                , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_DE, 179,  -1,  0}, // 183
{"Dawn purse"                       , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DE,  39,  -1,  0}, // 184
{"3-dice sword"                     , 1, 3,  0,  7,  3,   0  ,   30,   0,  0, TRUE , WEAPON_SWORD , MODULE_DE,  39,  -1,  0}, // 185
{"Bear-claw necklace"               , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DE,  39,  -1,  0}, // 186
{"Underwater torch"                 , 1, 0,  0,  0,  0,   0  ,   10,   0,  0, FALSE, NONWEAPON    , MODULE_BS, 187,  -1,  0}, // 187
{"Caliburn"                         , 1, 4,  0,  0,  0,  1000,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_DE, 137,  -1,  0}, // 188
{"Golden apple"                     , 0, 0,  0,  0,  0,   500,    5,   0,  0, FALSE, NONWEAPON    , MODULE_LA,   4, 115,  0}, // 189
{"Yuurrk"                           , 1, 0,  0,  0,  0,   0  ,   UK,   0,100, 17   , WEAPON_SWORD , MODULE_DE, 103,  -1,  0}, // 190
{"Nothing Sword"                    , 1, 2,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_DE, 152,  -1,  0}, // 191
{"Charm"                            , 0, 0,  0,  0,  0,   0  ,   UK,   0, 30, TRUE , JEWEL        , MODULE_DE,  56,  -1,  0}, // 192
{"Magical black pearl"              , 0, 0,  0,  0,  0, 50000,    1,   0,  0, TRUE , JEWEL        , MODULE_DE,  96,  -1,  0}, // 193
{"Vokal's scimitar"                 , 1, 4,  0, 10, 11,  6000,  100,   0,  0, TRUE , WEAPON_SWORD , MODULE_DE,  45,  77,  0}, // 194
{"Enchanted rope"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, 4    , NONWEAPON    , MODULE_CT, 137,  -1,  0}, // 195
{"Charm"                            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , JEWEL        , MODULE_CT,  80,  -1,  0}, // 196
{"Magic ruby"                       , 0, 0,  0,  0,  0,100000,   UK,   0,  0, TRUE , JEWEL        , MODULE_CT,  80,  -1,  0}, // 197
{"Jewel of belief"                  , 0, 0,  0,  0,  0, 25000,   10,   0,  0, TRUE , JEWEL        , MODULE_CD, 122,  -1,  0}, // 198
{"Tarnhelm"                         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CD,  79,  -1,  0}, // 199
{"Goatskin of wine"                 , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_CD,  92,  -1,  0}, // 200
{"Magic batshit"                    , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CD, 135,  -1,  0}, // 201
{"Meat cleaver"                     , 1, 3,  1,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_HAFTED, MODULE_CD, 149, 193,  0}, // 202
{"Knife"                            , 1, 2,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_DAGGER, MODULE_CD, 193,  -1,  0}, // 203
{"Amulet of Proteus"                , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CD, 159,  -1,  0}, // 204
{"Whip"                             , 1, 2,  2,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_OTHER , MODULE_CD, 175,  -1,  0}, // 205
{"Jewel-encrusted goblet"           , 0, 0,  0,  0,  0,150000,   UK,   0,  0, FALSE, JEWEL        , MODULE_BS,  13,  -1,  0}, // 206
{"Ornate shield"                    , 0, 0,  0,  0,  0,   0  ,   UK,   0,  3, FALSE, SHIELD       , MODULE_BS,  21,  -1,  0}, // 207
{"Ring of water breathing"          , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_BS,  50,  -1,  0}, // 208
{"Ornamental sword"                 , 0, 0,  0,  0,  0,195000,   UK,   0,  0, FALSE, WEAPON_SWORD , MODULE_BS,  51,  -1,  0}, // 209
{"Potion of double strength"        , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_BS,  66,  -1,  0}, // 210
{"Medallion"                        , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_BS,  82,  -1,  0}, // 211
{"Cat's head ring"                  , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_BS,  82,  -1,  0}, // 212
{"Ring of daggers"                  , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_BS, 200,  -1,  0}, // 213
{"Gold ring"                        , 0, 0,  0,  0,  0,  5000,   UK,   0,  0, FALSE, RING         , MODULE_BS, 205,  -1,  0}, // 214 also CA44
{"Necklace"                         , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_BS, 206,  -1,  0}, // 215
{"Magically balanced dirk"          , 1, 2,  1,  1,  4,  1800,   16,  10,  0, TRUE , WEAPON_DAGGER, MODULE_BS, 206,  -1,  0}, // 216
{"Animal ring"                      , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_BS, 210,  -1,  0}, // 217
{"Magic acorn"                      , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_SS,  -1,  -1,  0}, // 218 SS SET
{"Sleep potion"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_BS, 141,  -1,  0}, // 219
{"Jewel-encrusted gold necklace"    , 0, 0,  0,  0,  0,300000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_BS, 145,  -1,  0}, // 220
{"Black flamberge"                  , 2, 6,  3, 20, 20,   0  ,  100,   0,  0, TRUE , WEAPON_SWORD , MODULE_BS, 150,  -1,  0}, // 221
{"Eye of Kassamax"                  , 0, 0,  0,  0,  0,150000,   UK,   0,  0, FALSE, JEWEL        , MODULE_BS, 186,  -1,  0}, // 222
{"Strong shield"                    , 0, 0,  0,  0,  0,   0  ,  427,   0,  5, FALSE, SHIELD       , MODULE_BS, 188,  -1,  0}, // 223
{"Light shield"                     , 0, 0,  0,  0,  0,   0  ,  200,   0,  4, FALSE, SHIELD       , MODULE_BS, 194,  -1,  0}, // 224
{"Indian Head penny"                , 0, 0,  0,  0,  0,   0  ,    1,   0,  0, TRUE , NONWEAPON    , MODULE_DE, 121,  -1,  0}, // 225
{"Bloodlover"                       , 1, 3,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_DE, 142,  -1,  0}, // 226
{"Glitterglint"                     , 1, 2,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_SWORD , MODULE_DE, 147,  -1,  0}, // 227
{"Oiving"                           , 1, 6,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_DE, 158,  -1,  0}, // 228
{"Mithril troll statue"             , 0, 0,  0,  0,  0,100000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DE, 169,  -1,  0}, // 229
{"Block of mithril"                 , 0, 0,  0,  0,  0,100000,  100,   0,  0, FALSE, NONWEAPON    , MODULE_DE,  88, 171,  0}, // 230
{"Star diamond"                     , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, JEWEL        , MODULE_DE,  87,  -1,  0}, // 231
{"Broadleaf"                        , 1, 6,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_DE,  92,  -1,  0}, // 232
{"Ring"                             , 0, 0,  0,  0,  0, 15000,    1,   0,  0, FALSE, RING         , MODULE_CT, 102,  -1,  0}, // 233
{"Golden buckle"                    , 0, 0,  0,  0,  0, 20000,    1,   0,  0, FALSE, NONWEAPON    , MODULE_CT, 102,  -1,  0}, // 234
{"Obsidian spear (8')"              , 1, 3,  0,  8,  8,  2700,   30,  40,  0, FALSE, WEAPON_SPEAR , MODULE_TC,  12,  -1,  0}, // 235
{"Gold ring"                        , 0, 0,  0,  0,  0, 10000,    2,   0,  0, FALSE, RING         , MODULE_TC,  15,  -1,  0}, // 236
{"Pair of wristlets"                , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CT,  83,  -1,  0}, // 237 %%: these are alien, but perhaps not "magic"
{"Gem "                             , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, FALSE, JEWEL        , MODULE_CT,  42,  -1,  0}, // 238
{"Desert robe"                      , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CA, 310,  -1,  0}, // 239 this isn't armour
{"Castle ring"                      , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_CT, 107,  -1,  0}, // 240
{"Diamond ring of gold detection"   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_CT, 107,  -1,  0}, // 241
{"Royal baton"                      , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_CT, 123,  -1,  0}, // 242
{"Gold chain"                       , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_CT, 154,  -1,  0}, // 243
{"War Gauntlet"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , ARMOUR       , MODULE_CT, 178,  -1,  0}, // 244 %%: this is alien, but perhaps not "magic"
{"Sare"                             , 1, 5,  5,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_POLE  , MODULE_CT, 166, 223,  0}, // 245
{"Healing potion"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_CT, 228,  -1,  0}, // 246 also CA173/BW33/BW65
{"Charm"                            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CT, 228,  -1,  0}, // 247
{"Diamond"                          , 0, 0,  0,  0,  0, 18000,    2,   0,  0, FALSE, JEWEL        , MODULE_TC,  13,  -1,  0}, // 248
{"Magic topaz"                      , 0, 0,  0,  0,  0,   800,    8,   0,  0, TRUE , JEWEL        , MODULE_SS,  -1,  -1,  0}, // 249 SS SET
{"Antique marble"                   , 0, 0,  0,  0,  0, 23100,   UK,   0,  0, FALSE, JEWEL        , MODULE_SS,  -1,  -1,  0}, // 250 SS SET
{"Inscribed golden trinket"         , 0, 0,  0,  0,  0,  4900,   UK,   0,  0, FALSE, JEWEL        , MODULE_SS,  -1,  -1,  0}, // 251 SS SET
{"Pewter dinner fork"               , 1, 1,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_DAGGER, MODULE_SS,  -1,  -1,  0}, // 252 SS SET
{"Diamond"                          , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 253 SS3/DD54/NS148
{"Chartreuse dragon"                , 0, 0,  0,  0,  0,   0,      0,   0,  0, FALSE, SLAVE        , MODULE_SS,   6,  -1,  0}, // 254
{"Magic ring mail"                  , 0, 0,  0,  4,  0, 10000,  300,   0,  7, TRUE , ARMOUR       , MODULE_SS,  24,  29,  0}, // 255 also described in SS168
{"Pearl"                            , 0, 0,  0,  0,  0,   750,    1,   0,  0, FALSE, JEWEL        , MODULE_SS,  24,  -1,  0}, // 256
{"Gold ring of Restoration"         , 0, 0,  0,  0,  0,  3000,   UK,   0,  0, TRUE , RING         , MODULE_SS,  28,  -1, 10}, // 257 also NS9
{"Magical piece of jade"            , 0, 0,  0,  0,  0,  6000,   25,   0,  0, TRUE , JEWEL        , MODULE_SS,  29,  -1,  0}, // 258
{"Sapphire"                         , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SS,  36,  -1,  0}, // 259
{"Gold bar"                         , 0, 0,  0,  0,  0, 20000,  200,   0,  0, TRUE , JEWEL        , MODULE_SS,  46,  -1,  0}, // 260
{"Silver dirk with magic sheath"    , 1, 2,  1,  1,  4,  1800,   16,  10,  0, TRUE , WEAPON_DAGGER, MODULE_SS,  53,  -1,  0}, // 261 perhaps this should be implemented as two separate items
{"Rubies"                           , 0, 0,  0,  0,  0, 21000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SS,  73,  -1,  0}, // 262 perhaps this should be implemented as separate items (but how many?)
{"Magic marble"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , JEWEL        , MODULE_SS,  73,  -1,  0}, // 263
{"Ring of Will-o-Wisps"             , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_SS,  73,  -1,  0}, // 264
{"Magic vase"                       , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_SS,  92,  -1,  0}, // 265
{"Gold collar"                      , 0, 0,  0,  0,  0, 12500,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_SS, 105,  -1,  0}, // 266
{"Glowing green diamond"            , 0, 0,  0,  0,  0,  4000,   UK,   0,  0, TRUE , JEWEL        , MODULE_SS, 111,  -1,  0}, // 267
{"Diamond dust"                     , 0, 0,  0,  0,  0,  1000,    1,   0,  0, FALSE, JEWEL        , MODULE_SS, 115,  -1,  0}, // 268
{"Jewel"                            , 0, 0,  0,  0,  0,  2000,    2,   0,  0, FALSE, JEWEL        , MODULE_SS, 118,  -1,  0}, // 269
{"Gold chains"                      , 0, 0,  0,  0,  0,  1500,   UK,   0,  0, FALSE, JEWEL        , MODULE_SS, 124,  -1,  0}, // 270
{"Diamond"                          , 0, 0,  0,  0,  0,  1000,    1,   0,  0, FALSE, JEWEL        , MODULE_SS, 129, 225,  0}, // 271
{"Rubies"                           , 0, 0,  0,  0,  0, 24500,   30,   0,  0, FALSE, JEWEL        , MODULE_SS, 130,  -1,  0}, // 272
{"Lucky rabbit's foot"              , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_SS, 139,  -1,  0}, // 273 %%: we assume it is magic, but perhaps it is not
{"Topaz"                            , 0, 0,  0,  0,  0,  5000,    5,   0,  0, FALSE, JEWEL        , MODULE_SS, 142,  -1,  0}, // 274
{"Dagger of Krwonsku"               , 1, 2,  5,  7, 10,  3000,   25,   0,  0, TRUE , WEAPON_DAGGER, MODULE_SS, 149,  -1,  0}, // 275 %%: we based this on a sax, but it doesn't actually say what kind of dagger it is
{"Too-Bad Toxin liquid"             , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_SS, 150,  -1,  0}, // 276
{"Cateyes liquid"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_SS, 150,  -1,  0}, // 277
{"Arsenic"                          , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, POTION       , MODULE_SS, 150,  -1,  0}, // 278
{"Flawless sapphire"                , 0, 0,  0,  0,  0,  2000,    1,   0,  0, FALSE, JEWEL        , MODULE_SS, 150,  -1,  0}, // 279
{"Battered medallion"               , 0, 0,  0,  0,  0,   200,   20,   0,  0, FALSE, NONWEAPON    , MODULE_SS, 160,  -1,  0}, // 280
{"Emerald"                          , 0, 0,  0,  0,  0,  1500,    2,   0,  0, FALSE, JEWEL        , MODULE_SS, 160,  -1,  0}, // 281
{"Amethyst"                         , 0, 0,  0,  0,  0,  2000,    5,   0,  0, FALSE, JEWEL        , MODULE_SS, 160,  -1,  0}, // 282
{"Magic ruby"                       , 0, 0,  0,  0,  0,  7500,   10,   0,  0, TRUE , JEWEL        , MODULE_SS, 160,  -1,  0}, // 283
{"Magic sapphire"                   , 0, 0,  0,  0,  0,  9000,   10,   0,  0, TRUE , JEWEL        , MODULE_SS, 160,  -1,  0}, // 284
{"Magic topaz"                      , 0, 0,  0,  0,  0, 10500,   15,   0,  0, TRUE , JEWEL        , MODULE_SS, 160,  -1,  0}, // 285
{"Gold nugget"                      , 0, 0,  0,  0,  0,  5000,   50,   0,  0, FALSE, NONWEAPON    , MODULE_SS, 165,  -1,  0}, // 286
{"Bottle of cobra venom"            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, POISON       , MODULE_SS, 168,  -1,  0}, // 287 %%: it doesn't say what this does
{"Gold box"                         , 0, 0,  0,  0,  0,  9000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_SS, 170,  -1,  0}, // 288
{"Pouch of jewels"                  , 0, 0,  0,  0,  0, 13500,   40,   0,  0, FALSE, JEWEL        , MODULE_SS, 171,  -1,  0}, // 289
{"Ruby"                             , 0, 0,  0,  0,  0,   800,    1,   0,  0, FALSE, JEWEL        , MODULE_SS, 172,  -1,  0}, // 290
{"Diamond"                          , 0, 0,  0,  0,  0,  1000,    1,   0,  0, FALSE, JEWEL        , MODULE_SS, 172,  -1,  0}, // 291
{"Silver box"                       , 0, 0,  0,  0,  0,  1000,  100,   0,  0, FALSE, NONWEAPON    , MODULE_SS, 175,  -1,  0}, // 292
{"Golden sceptre"                   , 1, 1,  0,  0,  0, 10000,   50,   0,  0, FALSE, WEAPON_STAFF , MODULE_SS, 187,  -1,  0}, // 293
{"Inflatable air mattress"          , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_SS, 189,  -1,  0}, // 294
{"Beryl"                            , 0, 0,  0,  0,  0, 10000,   20,   0,  0, FALSE, JEWEL        , MODULE_SS, 189,  -1,  0}, // 295
{"Magic ring"                       , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_SS, 189,  -1,  0}, // 296
{"Poison capsule"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_SS, 189,  -1,  0}, // 297
{"Samson's hair amulet"             , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_SS, 189,  -1,  0}, // 298
{"Royal bracelet"                   , 0, 0,  0,  0,  0, 12500,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_SS, 198,  -1,  0}, // 299
{"EverRite Quill Pen"               , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_SS, 201,  -1,  0}, // 300 %%: this might be magical
{"Gold nugget"                      , 0, 0,  0,  0,  0,   100,    1,   0,  0, FALSE, NONWEAPON    , MODULE_SS, 206,  -1,  0}, // 301
{"Blackie"                          , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, FALSE, SLAVE        , MODULE_SS, 212,  -1,  0}, // 302
{"Jade"                             , 0, 0,  0,  0,  0,  7500,   10,   0,  0, FALSE, JEWEL        , MODULE_SS, 214,  -1,  0}, // 303
{"Moonstone"                        , 0, 0,  0,  0,  0, 10000,    5,   0,  0, FALSE, JEWEL        , MODULE_SS, 225,  -1,  0}, // 304
{"Vial of mercury"                  , 0, 0,  0,  0,  0, 10000,   50,   0,  0, FALSE, NONWEAPON    , MODULE_SS, 225,  -1,  0}, // 305
{"Bag of sulfur"                    , 0, 0,  0,  0,  0,  1000,  100,   0,  0, FALSE, NONWEAPON    , MODULE_SS, 225,  -1,  0}, // 306
{"Gambling stone"                   , 0, 0,  0,  0,  0,  2000,   UK,   0,  0, TRUE , JEWEL        , MODULE_BC,  11,  -1,  0}, // 307
{"Jewel"                            , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, FALSE, JEWEL        , MODULE_BC,  13,  27,  0}, // 308
{"Bracelet"                         , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_BC,   7,  72,  0}, // 309
{"Scorpion"                         , 0, 0,  0,  0,  0,  1000,    0,   0,  0, FALSE, SLAVE        , MODULE_BC,  14,  -1,  0}, // 310
{"Diploma"                          , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_BC,  23,  -1,  0}, // 311
{"Magic wand of strength doubling"  , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_BC,  29,  -1,  0}, // 312
{"Dagger"                           , 1, 2,  0,  0,  0,  3000,   10,   0,  0, FALSE, WEAPON_DAGGER, MODULE_BC,  36,  -1,  0}, // 313 also eg. AK26
{"Ruby"                             , 0, 0,  0,  0,  0, 25000,   UK,   0,  0, FALSE, JEWEL        , MODULE_CA, 178,  -1,  0}, // 314
{"Crystal ball"                     , 0, 0,  0,  0,  0,  2000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_BC,  42,  -1,  0}, // 315
{"Jewel"                            , 0, 0,  0,  0,  0, 30000,   UK,   0,  0, FALSE, JEWEL        , MODULE_BC,  55,  62,  0}, // 316
{"Fake emeralds"                    , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, JEWEL        , MODULE_BC,  60,  -1,  0}, // 317
{"Magic aspirin"                    , 0, 0,  0,  0,  0,  5000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_BC,  81,  -1,  0}, // 318
{"Magic vitamin pill"               , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_BC,  84,  -1,  0}, // 319
{"Stocks and bonds"                 , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_BC,  88,  -1,  0}, // 320
{"Buffalo hide"                     , 0, 0,  0,  0,  0,   500,   10,   0,  0, FALSE, NONWEAPON    , MODULE_BC,  97,  -1,  0}, // 321
{"Magic wand of killing"            , 0, 0,  0,  0,  0,   500,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_BC,  98,  -1,  0}, // 322
{"Potion of strength tripling"      , 0, 0,  0,  0,  0,  5000,   UK,   0,  0, TRUE , POTION       , MODULE_BC,  98,  -1,  0}, // 323
{"Antidote vs strength tripling"    , 0, 0,  0,  0,  0,  5000,   UK,   0,  0, TRUE , POTION       , MODULE_BC,  98,  -1,  0}, // 324
{"Cursed ruby"                      , 0, 0,  0,  0,  0,100000,   UK,   0,  0, TRUE , JEWEL        , MODULE_BC,  98,  -1,  0}, // 325
{"Emrld ncklce of monster charming" , 0, 0,  0,  0,  0, 20000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_BC,  98,  -1,  0}, // 326
{"Crystal ball"                     , 0, 0,  0,  0,  0,  2500,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_BC, 102,  -1,  0}, // 327
{"Dhesiri amulet"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_RC,  24,  -1,  0}, // 328
{"Exploring kit"                    , 0, 0,  0,  0,  0,  1000,    5,   0,  0, FALSE, NONWEAPON    , MODULE_BC,   0,  -1,  0}, // 329
{"Potion of attribute raising"      , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_CD,  44,  -1,  0}, // 330
{"Potion of strength healing"       , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_CD,  91,  -1,  0}, // 331
{"Jewellery"                        , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, FALSE, JEWEL        , MODULE_BS, 141,  -1,  0}, // 332
{"Armband and necklaces"            , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_BS, 158,  -1,  0}, // 333
{"Meteoric metal torc"              , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_CD,1007,1009,  0}, // 334
{"Mithril rapier"                   , 1, 4,  9, 10, 14, 20000,   20,   0,  0, FALSE, WEAPON_SWORD , MODULE_CD,1007,  -1,  0}, // 335
{"Huge bat-shaped emerald"          , 0, 0,  0,  0,  0,1000000,  50,   0,  0, FALSE, JEWEL        , MODULE_DE,  47,  -1,  0}, // 336
{"Barbed fish-spear"                , 1, 3,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_SPEAR , MODULE_AK,  13,  -1,  0}, // 337
{"Short curved dagger"              , 1, 2,  1,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_DAGGER, MODULE_AK,  13,  -1,  0}, // 338
{"Long thin flensing knife"         , 1, 2,  4,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_DAGGER, MODULE_AK,  19,  -1,  0}, // 339
{"Magic pickaxe"                    , 1,12,  0, 15, 10,  1500,  160,   0,  0, TRUE , WEAPON_HAFTED, MODULE_AK,  30,  96,  0}, // 340
{"Enchanter spear"                  , 1,21,  0,  8,  8,  2200,   50,  40,  0, TRUE , WEAPON_SPEAR , MODULE_AK,  32,  -1,  0}, // 341
{"Large knotty ogre club"           , 1, 9,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_HAFTED, MODULE_AK,  44,  -1,  0}, // 342 %%: we probably couldn't use this ourselves if we're not an ogre
{"Silver/wood giant club (10'-15')" , 1,10,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_HAFTED, MODULE_AK,   7,  -1,  0}, // 343 %%: we probably couldn't use this ourselves
{"Enchanted robe of woven silver"   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  7, TRUE , ARMOUR       , MODULE_AK,  51,  -1,  0}, // 344
{"Great elm-wood staff"             , 2, 2,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_STAFF , MODULE_AK,  51,  74,  0}, // 345
{"Egil's Bow"                       , 2,30,  0, 16,  0,   0  ,   UK, 100,  0, TRUE , WEAPON_BOW   , MODULE_AK,2000,  -1,  0}, // 346 AKp163 (TEW)
{"Bronze Bodkin"                    , 1,66,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_DAGGER, MODULE_AK,2001,  -1,  0}, // 347 AKp164 (TEW)
{"Gold Armband"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , JEWEL        , MODULE_AK,2002,  -1,  0}, // 348 AKp164 (TEW)
{"Dagger of Speed"                  , 1, 1,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_DAGGER, MODULE_AK,2003,  -1,  0}, // 349 AKp164 (TEW)
{"Deth (7')"                        , 2,21,  0,  9,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_AK,2004,  -1,  0}, // 350 AKp164 (TEW) %%: we assume this is 2-handed and magical
{"Hellslice"                        , 1,42,  4, 12, 13,  7500,  110,   0,  0, TRUE , WEAPON_SWORD , MODULE_AK,2005,  -1,  0}, // 351 AKp164 (TEW)
{"Finnegan's Flail"                 , 1, 3,  4, 20, 15,   0  ,   UK,   0,  0, TRUE , WEAPON_HAFTED, MODULE_AK,2006,  -1,  0}, // 352 AKp164 (TEW)
{"The Heavy Flail"                  , 1,36,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_HAFTED, MODULE_AK,2007,  -1,  0}, // 353 AKp164 (TEW)
{"Frog Axe"                         , 1, 6,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_HAFTED, MODULE_AK,2008,  -1,  0}, // 354 AKp164 (TEW)
{"Nevermiss"                        , 2, 5,  0,  0,  0,   0  ,   UK, 100,  0, TRUE , WEAPON_XBOW  , MODULE_AK,2009,  -1,  0}, // 355 AKp164 (TEW)
{"Silver-tipped arrow(s)"           , 0,33,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_ARROW , MODULE_AK,2010,  -1,  0}, // 356 AKp164 (TEW)
{"Levity"                           , 2, 3,  0,  0,  0,   0  ,   UK, 100,  0, TRUE , WEAPON_XBOW  , MODULE_AK,2011,  -1,  0}, // 357 AKp164 (TEW)
{"Trollbow"                         , 2,42,  0, 45,  0,   0  ,   UK, 100,  0, TRUE , WEAPON_XBOW  , MODULE_AK,2012,  -1,  0}, // 358 AKp164 (TEW)
{"Little Silver Thunderstick"       , 1, 8, 25, 20, 15,300000,   UK,  50,  0, TRUE , WEAPON_GUNNE , MODULE_AK,2013,  -1,  0}, // 359 AKp164 (TEW) %%: might not really be magical
{"Daggered Boots"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AK,2014,  -1,  0}, // 360 AKp164 (TEW)
{"Cross Kris"                       , 1, 9,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_AK,2015,  -1,  0}, // 361 AKp165 (TEW)
{"Great Sword Carrot"               , 1, 8,  0,  0,  0,   0  ,   UK,   0,  0, 9    , WEAPON_SWORD , MODULE_AK,2016,  -1,  0}, // 362 AKp165 (TEW)
{"Bottle of Warrior Juice"          , 0, 0,  0,  0,  0,200000,   UK,   0,  0, TRUE , POTION       , MODULE_AK,2017,  -1,  0}, // 363 AKp165 (TEW)
{"Hardpull the Longbow"             , 2,48,  0, 48,  0,   0  ,   UK,1760,  0, TRUE , WEAPON_BOW   , MODULE_AK,2018,  -1,  0}, // 364 AKp165 (TEW) 1 mile == 1760 yards
{"Long Golden Thunderstick"         , 1,12, 40,  0,  0,700000,   UK, 200,  0, TRUE , WEAPON_GUNNE , MODULE_AK,2019,  -1,  0}, // 365 AKp165 (TEW) %%: might not really be magical
{"Hero Sword (6')"                  , 2, 0,100,  1,  1,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_ND,   8,  -1,  0}, // 366
{"Bamboo spear (ND18/p103)"         , 1, 2,  0,  8,  8,   0  ,   UK,  50,  0, TRUE , WEAPON_SPEAR , MODULE_ND,  18,1005,  0}, // 367
{"Robes of Tuchmi K'nott"           , 0, 0,  0,  0,  0,   0  ,   UK,   0,200, TRUE , ARMOUR       , MODULE_ND,  47,  -1,  0}, // 368 %%: do these count as armour? We assume so.
{"Ring of Fire"                     , 0, 0,100,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_ND,  47,  -1,  0}, // 369
{"20th Level Anti-Magic Belt"       , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, 20   , NONWEAPON    , MODULE_ND,  47,  -1,  0}, // 370
{"The Dagger \"Drainer\""           , 2, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_DAGGER, MODULE_ND,  47,  -1,  0}, // 371
{"Funny-Once Gem"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , JEWEL        , MODULE_ND,  47,  -1,  0}, // 372
// Generic (poison, gunnes)
{"Curare"                           , 0, 0,  0,  0,  0,  3300,    1,   0,  0, FALSE, POISON       , MODULE_RB, 124,  -1,  0}, // 373
{"Spider venom"                     , 0, 0,  0,  0,  0,  5000,    1,   0,  0, FALSE, POISON       , MODULE_RB, 125,  -1,  0}, // 374
{"Dragon's venom"                   , 0, 0,  0,  0,  0, 33300,    1,   0,  0, FALSE, POISON       , MODULE_RB, 126,  -1,  0}, // 375
{"Hellfire juice"                   , 0, 0,  0,  0,  0,  6600,    1,   0,  0, FALSE, POISON       , MODULE_RB, 127,  -1,  0}, // 376
{"Hand cannon"                      , 2,10, 40, 18, 12, 50000,  200,   5,  0, FALSE, WEAPON_GUNNE , MODULE_RB, 128,  -1,  0}, //%377
{"Matchlock pistol"                 , 2, 5, 15, 12,  8,100000,   60, 100,  0, FALSE, WEAPON_GUNNE , MODULE_RB, 129,  -1,  0}, // 378
{"Matchlock musket"                 , 2, 8, 25, 15,  8,125000,  120, 100,  0, FALSE, WEAPON_GUNNE , MODULE_RB, 130,  -1,  0}, // 379
{"Wheel lock pistol"                , 2, 5, 15, 10,  8,150000,   60, 100,  0, FALSE, WEAPON_GUNNE , MODULE_RB, 131,  -1,  0}, // 380
{"Wheel lock musket"                , 2, 7, 20, 12,  8,180000,  120, 100,  0, FALSE, WEAPON_GUNNE , MODULE_RB, 132,  -1,  0}, // 381
{"Snaphaunce pistol"                , 2, 5, 15, 10,  8,200000,   60, 100,  0, FALSE, WEAPON_GUNNE , MODULE_RB, 133,  -1,  0}, // 382
{"Snaphaunce musket"                , 2, 7, 25, 10,  8,250000,  120, 100,  0, FALSE, WEAPON_GUNNE , MODULE_RB, 134,  -1,  0}, // 383
{"Flintlock pistol"                 , 2, 5, 15,  8,  8,300000,   60, 100,  0, FALSE, WEAPON_GUNNE , MODULE_RB, 135,  -1,  0}, // 384
{"Flintlock musket"                 , 2, 8, 30, 10,  8,350000,  120, 100,  0, FALSE, WEAPON_GUNNE , MODULE_RB, 136,  -1,  0}, // 385
{"Black powder"                     , 0, 0,  0,  0,  0,   100,    1,   0,  0, FALSE, WEAPON_POWDER, MODULE_RB, 137,  -1,  0}, // 386 real weight is 0.25cn each
{"Powder horn"                      , 0, 0,  0,  0,  0,  1000,   20,   0,  0, FALSE, NONWEAPON    , MODULE_RB, 138,  -1,  0}, // 387
{"Ramrod"                           , 0, 0,  0,  0,  0,   200,   10,   0,  0, FALSE, NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 388
{"Lead ball(s)"                     , 0, 0,  0,  0,  0,    10,    1,   0,  0, FALSE, NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 389
{"Swabbing"                         , 0, 0,  0,  0,  0,     1,    1,   0,  0, FALSE, NONWEAPON    , MODULE_RB,  -1,  -1,  0}, // 390 real cost is 0.1cp each, real weight is 0.1cn each
{"Match(es)"                        , 0, 0,  0,  0,  0,    10,    1,   0,  0, FALSE, NONWEAPON    , MODULE_RB, 139,  -1,  0}, // 391
// Module-specific
{"Enchanted mail"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0, 33, TRUE , ARMOUR       , MODULE_AK, 165,  -1,  0}, // 392
{"Silver-tipped staff (8')"         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AK, 165,  -1,  0}, // 393 %%: we're not given any details about this! is it for combat or spellcasting?
{"Unicorn"                          , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, FALSE, SLAVE        , MODULE_AK, 186,  -1,  0}, // 394
{"Elven girlfriend"                 , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, FALSE, SLAVE        , MODULE_AK, 147,  -1,  0}, // 395
{"Load of fish"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AS,1007,  -1,  0}, // 396
{"¼ of a fire extinguisher"         , 0, 0,  0,  0,  0,  2500,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AS,   5,  -1,  0}, // 397
{"Snake's head grappling hook"      , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AS,  13,  -1,  0}, // 398
{"Egg"                              , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AS,  13,  90,  0}, // 399
{"Magic fishing net"                , 0, 0,  0,  0,  0, 25000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS,  23,  -1,  0}, // 400
{"Obsidian dagger"                  , 1, 2,  7,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_DAGGER, MODULE_AS,  36, 145,  0}, // 401
{"1-handed staff"                   , 1, 2,  0,  2,  8,   0  ,   UK,   0,  0, FALSE, WEAPON_STAFF , MODULE_AS,  36,  -1,  0}, // 402
{"Arrow(s) of accuracy"             , 0, 0,  0,  0,  0,  2000,   UK,   0,  0, TRUE , WEAPON_ARROW , MODULE_AS,  46,  -1,  0}, // 403
{"Arrow(s) of damage"               , 0, 0,  0,  0,  0,  2000,   UK,   0,  0, TRUE , WEAPON_ARROW , MODULE_AS,  46,  -1,  0}, // 404
{"Thin gold sheet"                  , 0, 0,  0,  0,  0,  5000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AS,  63,  -1,  0}, // 405
{"Small very unusual key"           , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AS,  63,  -1,  0}, // 406
{"Red liquid"                       , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AS,  66,  -1,  0}, // 407
{"Medallion of demagnetization"     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AS,  69,  -1,  0}, // 408 %%: we assume this isn't magical
{"Meat preserver"                   , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AS,  77,  -1,  0}, // 409
{"Half-gold piece"                  , 0, 0,  0,  0,  0,    50,    1,   0,  0, FALSE, NONWEAPON    , MODULE_AS,  79,  -1,  0}, // 410
{"Dead jajuk bird"                  , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AS,  98, 191,  0}, // 411
{"Diadem"                           , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS,  98,  -1,  0}, // 412
{"Gold skull with diamond eyes"     , 0, 0,  0,  0,  0,200000,   UK,   0,  0, FALSE, JEWEL        , MODULE_AS,  91,  -1,  0}, // 413 and ASp82
{"Skull"                            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS,  94,  -1,  0}, // 414
{"Anti-poison gloves"               , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS, 106,  -1,  0}, // 415 %%: perhaps not magical
{"Medallion of breathing poison gas", 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS, 106,  -1,  0}, // 416
{"Boots of speed"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS, 106,  -1,  0}, // 417
{"Sharp spear"                      , 1, 4,  6,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_SPEAR , MODULE_AS, 109,  -1,  0}, // 418
{"Green metal armour"               , 0, 0,  0,  0,  0,   0  ,   UK,   0,  5, FALSE, ARMOUR       , MODULE_AS, 109,  -1,  0}, // 419
{"Quilted silk Throfd Worm armour"  , 0, 0,  0,  0,  0,   0  ,   UK,   0, 15, FALSE, ARMOUR       , MODULE_AS, 123,  -1,  0}, // 420
{"Werqus"                           , 2, 9, 20,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_SWORD , MODULE_AS, 123,  -1,  0}, // 421
{"Amulet of secret doors"           , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS, 124,  -1,  0}, // 422
{"Mortus ointment"                  , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AS, 127,  -1,  0}, // 423
{"Magic door knocker"               , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS, 136,  -1,  0}, // 424
{"Divine gold ring w/ large emerald", 0, 0,  0,  0,  0,150000,   UK,   0,  0, TRUE , RING         , MODULE_AS, 138,  -1,  0}, // 425
{"Small gold statue of yourself"    , 0, 0,  0,  0,  0,  5000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AS, 142,  -1,  0}, // 426
{"Clay scimitar (3')"               , 1, 4, 30, 10, 11,   0  ,  100,   0,  0, FALSE, WEAPON_SWORD , MODULE_AS, 142,  -1,  0}, // 427 %%: we assume this is non-magical
{"Salve of curing disease"          , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS, 142,  -1,  0}, // 428
{"Small funny looking bird"         , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, FALSE, SLAVE        , MODULE_AS, 142,  -1,  0}, // 429
{"Black robe of Sxelba"             , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AS, 145,  -1,  0}, // 430
{"Grtaz"                            , 1,11, 25,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_AS, 146,  -1,  0}, // 431
{"Extra-heavy longbow with runes"   , 2, 8,  3, 25, 17, 25000,   80, 160,  0, TRUE , WEAPON_BOW   , MODULE_AS, 154,  -1,  0}, // 432
{"Dagger of accuracy"               , 1, 2,  0,  0,  0,   0  ,   UK,  10,  0, TRUE , WEAPON_DAGGER, MODULE_AS, 154,  -1,  0}, // 433 %%: it doesn't say the range (nor weight, etc.)
{"Suit of leather armour"           , 0, 0,  0,  2,  0,   0  ,  200,   0, 10, TRUE , ARMOUR       , MODULE_AS, 154,  -1,  0}, // 434 %%: is this magical?
{"Lickum & Stickum dagger"          , 1, 2,  5,  0,  0, 27500,   UK,   0,  0, TRUE , WEAPON_DAGGER, MODULE_AS, 156,  -1,  0}, // 435 %%: can this be thrown? We assume not.
{"Special deluxe staff"             , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS, 157,  -1,  0}, // 436
{"Diamond ring"                     , 0, 0,  0,  0,  0, 12000,   UK,   0,  0, FALSE, RING         , MODULE_AS, 158,  -1,  0}, // 437
{"Zombie Control Amulet"            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS, 187, 112,  0}, // 438 (and AS177)
{"Amulet of Krepmn"                 , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS,  91,  -1,  0}, // 439
{"Axe of Frietoc"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS,  89,  -1,  0}, // 440 %%: can this be used as a weapon? If so, what are its stats? Is it magical?
{"Staff of Frietoc"                 , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS,  89,  -1,  0}, // 441
{"Gold symbol of Sxelba"            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS,  86, 153,  0}, // 442
{"Vial of healing and curing liquid", 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_AS,1013,  -1,  0}, // 443
{"Emerald"                          , 0, 0,  0,  0,  0, 35000,   UK,   0,  0, FALSE, JEWEL        , MODULE_AS,1013,  -1,  0}, // 444
{"Silk sheet with gold interwoven"  , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AS,1015,  -1,  0}, // 445
{"Gold necklace"                    , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AS, 120, 153,  0}, // 446 %%: what is its value?
{"Preserved jajuk bird"             , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AS,  98, 191,  0}, // 447
{"Ruby amulet"                      , 0, 0,  0,  0,  0,120000,   UK,   0,  0, TRUE , JEWEL        , MODULE_SH,  22,  -1, 10}, // 448
{"Red poppy"                        , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POISON       , MODULE_SH,  79,  29,  0}, // 449
{"Black poppy"                      , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_SH,  79,  -1,  0}, // 450
{"Magic war axe"                    , 1, 4,  5, 15,  0,   0  ,   UK,   0,  3, TRUE , WEAPON_HAFTED, MODULE_SH,  47,  29,  0}, // 451 %%: we assume this is 1-handed (unlike a normal war axe)
{"Magic longsword"                  , 1, 4,  0,  9,  0,   0  ,   UK,   0,  8, TRUE , WEAPON_SWORD , MODULE_SH,  89,  29,  0}, // 452
{"Magic blade"                      , 1, 4,  8,  0,  0,   0  ,   UK,   0, 10, TRUE , WEAPON_DAGGER, MODULE_SH, 112,  29,  0}, // 453
{"Liquid of poison immunity"        , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_SH,  73,  -1,  0}, // 454
{"Grey Elf cloak"                   , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_SH,  77,  -1,  0}, // 455 %%: is this considered to be armour?
{"Jade Knuckle Duster statue (8\")" , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SH,  91,  -1,  0}, // 456
{"Emerald"                          , 0, 0,  0,  0,  0, 20000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SH,  91,  -1,  0}, // 457
{"Magic piggy bank"                 , 0, 0,  0,  0,  0, 10000,   10,   0,  0, TRUE , NONWEAPON    , MODULE_SH,  93,  -1,  0}, // 458
{"Blue Elf armour"                  , 0, 0,  0,  0,  0,200000,   20,   0, 10, TRUE , ARMOUR       , MODULE_SH,  93,  -1,  0}, // 459
{"Never-empty beer keg"             , 0, 0,  0,  0,  0,500000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_SH, 137,  28,  0}, // 460
{"Flying carpet"                    , 0, 0,  0,  0,  0,200000,  500,   0,  0, TRUE , NONWEAPON    , MODULE_BF,   1,  -1,  0}, // 461
{"Silver shield"                    , 1, 0,  1,  0,  0,   0  ,   UK,   0,  5, TRUE , SHIELD       , MODULE_BF,   2,  -1,  0}, // 462
{"30' magic green rope"             , 0, 0,  0,  0,  0, 60000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_BF,   8,  -1,  0}, // 463
{"Silver sword"                     , 1,10,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_CA,  56, 180,  0}, // 464 %%: is this magical?
{"Talking mirror"                   , 0, 0,  0,  0,  0, 50000,  500,   0,  0, TRUE , NONWEAPON    , MODULE_BF,  28,  -1,  0}, // 465
{"Pearl"                            , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, FALSE, JEWEL        , MODULE_BF,  42,  -1,  0}, // 466 also CA216
{"Magic target shield"              , 1, 0,  0,  5,  0,  3500,  300,   0,  5, TRUE , SHIELD       , MODULE_BF,  54,  -1,  0}, // 467
{"Emerald"                          , 0, 0,  0,  0,  0, 40000,   UK,   0,  0, FALSE, JEWEL        , MODULE_BF,  66,  -1,  0}, // 468
{"Candlestick"                      , 1, 2,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_HAFTED, MODULE_BF,  76,  -1,  0}, // 469
{"Invisible silver scale mail shirt", 0, 0,  0,  0,  0,   0  ,   UK,   0, 10, TRUE , ARMOUR       , MODULE_BF,  87,  -1,  0}, // 470 // %%: does this count as armour?
{"Magic scale mail shirt"           , 0, 0,  0,  0,  0,   0  ,   UK,   0, 10, TRUE , ARMOUR       , MODULE_BF, 115,  -1,  0}, // 471 // %%: does this count as armour?
{"Bumbershoot"                      , 0, 0,  0,  0,  0,  1000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_BF, 117,  -1,  0}, // 472 // %%: are these magical?
{"Magic sword"                      , 1, 6,  5,  0,  0, 50000,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_BF, 125,  -1,  0}, // 473
{"Death Vortex Blade"               , 1, 6, 24,  0,  0,100000,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_BF, 153,  -1,  0}, // 474
{"Light mail"                       , 0, 0,  0,  0,  0,   0  ,    1,   0, 11, TRUE , ARMOUR       , MODULE_BF, 168,  -1,  0}, // 475
{"Light shield"                     , 1, 0,  0,  0,  0,   0  ,    1,   0,  8, TRUE , SHIELD       , MODULE_BF, 168,  -1,  0}, // 476
{"Bright black leather amour"       , 0, 0,  0,  0,  0,   0  ,   UK,   0, 12, TRUE , ARMOUR       , MODULE_BF, 171,  -1,  0}, // 477
{"Knee-high leather boots of speed" , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_BF, 171,  -1,  0}, // 478
{"Small mushroom"                   , 0, 0,  0,  0,  0,     1,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_BF, 173,  -1,  0}, // 479 really should be ½ cp each (200 mushrooms = 1 gp)
{"Magic whip"                       , 1, 2,  2,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_OTHER , MODULE_BF, 171,  -1,  0}, // 480
{"Wineskin"                         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, POTION       , MODULE_BF,  67,  -1,  0}, // 481
{"Crying infants potion"            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_GK,   7, 209,  6}, // 482 (flawable)
{"Magical broadsword"               , 1, 6,  8,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_GK,  19,  -1,  0}, // 483
{"Dr Bob's Healing Potion"          , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_GK,  29,  -1,  0}, // 484
{"Footprints potion (cursed)"       , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_GK,  33, 177,  0}, // 485
{"No-See-Me Grease"                 , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_GK,  82, 160,  0}, // 486
{"Ankh ointment (cursed)"           , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_GK,  84,  21,  0}, // 487
{"STX2 potion (cursed)"             , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_GK,  93, 203,  0}, // 488
{"Alloy longsword"                  , 1, 3,  3,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_SWORD , MODULE_GK, 107,  -1,  0}, // 489
{"Ace card"                         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_GK, 122,  -1,  0}, // 490
{"Ankh ointment"                    , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_GK, 132, 141,  0}, // 491
{"Footprints potion"                , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_GK, 154, 185,  0}, // 492
{"Dagger"                           , 1, 2,  2,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_DAGGER, MODULE_GK, 170,  -1,  0}, // 493
{"Big brass skeleton key"           , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_GK, 186,  -1,  0}, // 494
{"Crying infants potion (unflawed)" , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_GK, 199,  43,  5}, // 495
{"No-See-Me Grease (cursed)"        , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_GK, 202, 157,  0}, // 496
{"STX2 potion"                      , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_GK, 204, 153,  0}, // 497
{"Witch's amulet"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_GK, 183,  -1,  0}, // 498
{"Crying infants potion (flawed)"   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_GK,   7, 209,  5}, // 499
{"Sword of Voronir"                 , 1,10,  0, 15, 10,  7000,  120,   0,  0, TRUE , WEAPON_SWORD , MODULE_MW,   4,  23,  0}, // 500
{"Healing potion"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_MW,  14,  -1,  5}, // 501
{"Diamond"                          , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, JEWEL        , MODULE_MW,  50,  -1,  0}, // 502
{"Antiseptic ointment"              , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_MW,  92,  -1,  0}, // 503 perhaps not magical
{"Necklace"                         , 0, 0,  0,  0,  0,800000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_MW,  98,  -1,  0}, // 504
{"Sapphire Cateyes ring"            , 0, 0,  0,  0,  0,700000,   UK,   0,  0, TRUE , RING         , MODULE_MW,  98,  -1,  0}, // 505
{"Ring of poison resistance"        , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_MW, 100,  -1,  0}, // 506
{"Elf-medallion"                    , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_MW, 134,  -1,  0}, // 507
{"Pouch of small diamonds"          , 0, 0,  0,  0,  0,200000,   UK,   0,  0, FALSE, JEWEL        , MODULE_GL,  11,  -1,  0}, // 508
{"Ring of attribute doubling"       , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_GL,  14,  -1,  0}, // 509
{"½ of a silver coin"               , 0, 0,  0,  0,  0,     5,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_GL,  57,  -1,  0}, // 510
{"Glitterglim dagger"               , 1, 1,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_DAGGER, MODULE_GL,  57,  61,  0}, // 511
{"Broken mirror"                    , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_GL,  57,  -1,  0}, // 512
{"Issue of Goblin Gazette magazine" , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_GL,  57,  -1,  0}, // 513
{"Magical amulet"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_WW,  48,  -1,  0}, // 514
{"Light-sabre (3')"                 , 1, 3,  4,  9, 10,  5500,   60,   0,  0, FALSE, WEAPON_SWORD , MODULE_WW,  49,  -1,  0}, // 515
{"Battleaxe"                        , 1, 4,  0, 15,  8, 10000,  150,   0,  0, FALSE, WEAPON_HAFTED, MODULE_WW,  51,  -1,  0}, // 516
{"Magical foldbox"                  , 0, 0,  0,  0,  0,   0  ,  100,   0,  0, TRUE , NONWEAPON    , MODULE_WW,  54,  -1,  0}, // 517
{"Fred the Head"                    , 0, 0,  0,  0,  0,   0  ,   50,   0,  0, TRUE , SLAVE        , MODULE_WW,  57,  -1,  0}, // 518
{"Golden gun"                       , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_WW,  58,  -1,  0}, // 519 %%: is it usable as a weapon?
{"Foil-wrapped chocolate dagger"    , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_WW,  69,  -1,  0}, // 520 %%: is it usable as a weapon?
{"Diamond ring"                     , 0, 0,  0,  0,  0,200000,   UK,   0,  0, FALSE, RING         , MODULE_WW,  70,  -1,  0}, // 521
{"Gem"                              , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, FALSE, JEWEL        , MODULE_WW,  72,  -1,  0}, // 522
{"Portable hole (3')"               , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_WW,  84,  -1,  0}, // 523
{"Ring controlling portable hole"   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_WW,  84,  -1,  0}, // 524
{"Golden page"                      , 0, 0,  0,  0,  0, 70000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_WW,  90,  -1,  0}, // 525
{"Arrow pointing to danger"         , 0, 0,  0,  0,  0,   160,    1,   0,  0, TRUE , WEAPON_ARROW , MODULE_WW, 102,  -1,  0}, // 526
{"Large diamond"                    , 0, 0,  0,  0,  0,1000000,  UK,   0,  0, TRUE , JEWEL        , MODULE_WW, 110,  -1,  0}, // 527
{"Automatically hitting arrow"      , 0, 0,  0,  0,  0,   160,    1,   0,  0, TRUE , WEAPON_ARROW , MODULE_WW, 114,  -1,  0}, // 528
{"Piece of jewellery"               , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, JEWEL        , MODULE_WW, 160, 119,  0}, // 529
{"Magical hand"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_WW,  28,  -1,  0}, // 530
{"Viper tail"                       , 1, 3,  0,  0,  0, 50000,   UK,   0,  0, FALSE, WEAPON_OTHER , MODULE_AB,  12,  -1,  0}, // 531
{"Silver arrow with a cursed tip"   , 0, 0, 33,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_ARROW , MODULE_AB,  24,  -1,  0}, // 532
{"Locust gem"                       , 0, 0,  0,  0,  0,100000,   UK,   0,  0, TRUE , JEWEL        , MODULE_AB,  35,  -1,  0}, // 533
{"Small gem"                        , 0, 0,  0,  0,  0,  3300,   UK,   0,  0, FALSE, JEWEL        , MODULE_AB,  35,  37,  0}, // 534
{"Black pebble charm"               , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_AB,   2,  -1,  0}, // 535
{"Crown"                            , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_AB,   4,  -1,  0}, // 536
{"Ruby"                             , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SO,1003,  -1,  0}, // 537 also BC38 and CA154
{"Ruby"                             , 0, 0,  0,  0,  0, 20000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SO,1003,  -1,  0}, // 538 also BF9  and CI18
{"Ruby"                             , 0, 0,  0,  0,  0, 30000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SO,1003,  -1,  0}, // 539 also DE96 and CA173
{"Ruby"                             , 0, 0,  0,  0,  0, 40000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SO,1003,  -1,  0}, // 540
{"Ruby"                             , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SO,1003,  -1,  0}, // 541
{"Ruby"                             , 0, 0,  0,  0,  0, 60000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SO,1003,  -1,  0}, // 542
{"Gauntlets of Rex Sunwolf"         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , ARMOUR       , MODULE_RC,  36,  67,  0}, // 543 these have different powers depending on how they were acquired!
{"Fanirfang"                        , 1, 9,150,  0,  0,300000,  150,   0,  0, TRUE , WEAPON_SWORD , MODULE_SO,  25,  72,  0}, // 544
{"Silver service"                   , 0, 0,  0,  0,  0, 15000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_SO,  54,  -1,  0}, // 545
{"\"Do Unto Others\" shield"        , 1, 0,  0,  0,  0,   0  ,  400,   0,  0, TRUE , SHIELD       , MODULE_SO,  72,  83,  0}, // 546
{"Gem"                              , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SO,  73, 127,  0}, // 547 also CT151
{"Gold necklace set with a ruby"    , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SO,  73,  -1,  0}, // 548
{"Portable loot"                    , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_SO,  94, 124,  0}, // 549
{"Ranger ring"                      , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, RING         , MODULE_SO, 113,  -1,  0}, // 550
{"Silver flame-shaped dagger"       , 1, 3,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_DAGGER, MODULE_SO, 138,  -1,  0}, // 551
{"Crocodile skin"                   , 0, 0,  0,  0,  0,  2500,   50,   0,  0, FALSE, NONWEAPON    , MODULE_SO, 148,  -1,  0}, // 552
{"Amulet of breath invisibility"    , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_SO, 158, 184,  0}, // 553 (and SO27)
{"Cat ring"                         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_SO, 165,  -1,  0}, // 554
{"Diamond"                          , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SO, 167,  -1,  0}, // 555
{"Gems"                             , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SO, 192,  -1,  0}, // 556
{"Gem"                              , 0, 0,  0,  0,  0,  5000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SO,  10,  -1,  0}, // 557
{"Silver circlet"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_SO, 103,  -1,  0}, // 558
{"Horse"                            , 0, 0,  0,  0,  0, 20000,    0,   0,  0, FALSE, SLAVE        , MODULE_SO, 197,  -1,  0}, // 559 (and ND64)
{"Blasting Power amulet"            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_SO, 203,  -1,  0}, // 560
{"Silver tiara"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, JEWEL        , MODULE_SO, 187,  -1,  0}, // 561
{"Magic ball of string"             , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_LA,  22,  -1,  0}, // 562
{"Invincible Achilles shield"       , 1, 0,  0,  0,  0, 75000,  350,   0,  2, TRUE , SHIELD       , MODULE_LA,  54,  69,  0}, // 563 %%: is this magical?
{"Centaur medicine"                 , 0, 0,  0,  0,  0,  2000,   10,   0,  0, FALSE, POTION       , MODULE_LA,  76,  -1,  0}, // 564 %%: is this magical?
{"Labyrinth Special shield"         , 1, 0,  0,  0,  0,  1500,   50,   0,  2, TRUE , SHIELD       , MODULE_LA,  54,  69,  0}, // 565 %%: is this magical?
{"Alcibades Joy-of-Death sword"     , 1, 3,  3,  0,  0,  7500,  150,   0,  2, TRUE , WEAPON_SWORD , MODULE_LA,  98, 163,  0}, // 566
{"Poultice of Prometheus"           , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_LA, 119,  -1,  0}, // 567 %%: is this magical?
{"Doric Silencer sword"             , 1, 3,  0,  0,  0,  5000,   70,   0,  0, TRUE , WEAPON_SWORD , MODULE_LA, 134, 163,  0}, // 568
{"Golden leaf"                      , 0, 0,  0,  0,  0,    10,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_LA, 164,  -1,  0}, // 569
{"Chastity charm"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_LA,1001,  -1,  0}, // 570
{"Golden lyre of Apollo"            , 0, 0,  0,  0,  0,   0  ,   10,   0,  0, TRUE , NONWEAPON    , MODULE_LA,1002,  -1,  0}, // 571 %%: is this magical?
{"Shell-Sea charm"                  , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_LA,1006,  -1,  0}, // 572
{"Necklace of Theseus"              , 0, 0,  0,  0,  0,   500,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_LA,  86,  -1,  0}, // 573
{"Earth elemental"                  , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, FALSE, SLAVE        , MODULE_DD,  20,  -1,  0}, // 574
{"Chariot and steeds"               , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, TRUE , SLAVE        , MODULE_DD,  22,  -1,  0}, // 575
{"Magic dirk"                       , 1, 2,  1,  1,  4,  1800,   16,  10,  0, TRUE , WEAPON_DAGGER, MODULE_DD,  23,  -1,  0}, // 576
{"Silver fragments"                 , 0, 0,  0,  0,  0,  2500,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DD,  28,  89,  0}, // 577
{"Gold-and-amber bracelet"          , 0, 0,  0,  0,  0,200000,   UK,   0,  0, FALSE, JEWEL        , MODULE_DD,  14,  -1,  0}, // 578
{"Cockatrice statue"                , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DD,  16,  62,  0}, // 579
{"Magic sax"                        , 1, 2,  5,  7, 10,  3000,   25,   0,  0, TRUE , WEAPON_DAGGER, MODULE_DD,  35,  -1,  0}, // 580
{"Wooden club edged with obsidian"  , 1, 3,  4,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_SWORD , MODULE_DD,  97,  -1,  0}, // 581
{"Bronzed skullcap of D'Savoc"      , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DD,1000,  -1,  0}, // 582
{"High-impact helmet"               , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , ARMOUR_HEAD  , MODULE_DD,1001,  -1,  0}, // 583
{"Copper ring"                      , 0, 0,  0,  0,  0,   0  ,   UK,   0,  4, TRUE , RING         , MODULE_DD,1002,  -1,  0}, // 584
{"Ring of levitation"               , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_DD,1003,  -1,  0}, // 585
{"Gilded amulet"                    , 0, 0,  0,  0,  0,   0  ,   UK,   0, 10, TRUE , NONWEAPON    , MODULE_DD,1004,  -1,  0}, // 586
{"Skull-shaped amulet"              , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DD,1005,  -1,  0}, // 587
{"Winged boots"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DD,1006,  -1,  0}, // 588
{"Magic shuriken"                   , 1, 1,  0,  2, 10,  1000,    3,  10,  0, TRUE , WEAPON_THROWN, MODULE_DD,1007,  -1,  0}, // 589- Really weighs 3.3'cn (0.3'#)
{"Magic sword"                      , 1, 6,  6,  0,  0,   0  ,   50,   0,  0, TRUE , WEAPON_SWORD , MODULE_DD,1008,  -1,  0}, // 590
{"Indestructible spear"             , 1, 5,  0,  8,  8,  2200,   50,  40,  0, TRUE , WEAPON_SPEAR , MODULE_DD,1009,  -1,  0}, // 591
{"War hammer of Moe"                , 1, 5,  1, 17,  3,  8500,  100,   0,  0, FALSE, WEAPON_HAFTED, MODULE_DD,1010,  -1,  0}, // 592
{"Jewelled dagger"                  , 1, 1,  1,  0,  0, 50000,   UK,   0,  0, FALSE, WEAPON_DAGGER, MODULE_BC,  -1,  -1,  0}, // 593
{"Jar of insect repellant ointment" , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_BC,  -1,  -1,  0}, // 594
{"Strength potion"                  , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_BC,  -1,  -1,  0}, // 595
{"Healing potion"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_BC,  -1,  -1,  0}, // 596 also DT30
{"Goblet of gold and jewels"        , 0, 0,  0,  0,  0, 30000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DD,  43,  -1,  0}, // 597
{"Ghost Hawk arrow(s)"              , 0, 0,  0,  0,  0,   0  ,    1,   0,  0, TRUE , WEAPON_ARROW , MODULE_DD,  46,  -1,  0}, // 598
{"Sword of Dargon"                  , 0, 0,  0,  0,  0,   0  ,    1,   0,  0, TRUE , WEAPON_SWORD , MODULE_DD,  52,  -1,  0}, // 599
{"Obsidian dagger"                  , 1, 2, -1,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_DAGGER, MODULE_DD,  64,  -1,  0}, // 600
{"Magic broadsword"                 , 1, 3,  3, 15, 10,  7000,  120,   0,  0, TRUE , WEAPON_SWORD , MODULE_DD,  70,  -1,  0}, // 601
{"Air elemental"                    , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, FALSE, SLAVE        , MODULE_DD,  75,  -1,  0}, // 602
{"Amulet of Dargon"                 , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DD,  85,  -1,  0}, // 603
{"Gold box"                         , 0, 0,  0,  0,  0, 25000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DD,  86,  -1,  0}, // 604
{"Gold and jade pectoral"           , 0, 0,  0,  0,  0, 75000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DD,  87,  -1,  0}, // 605
{"Gloves of Dargon"                 , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, 5    , NONWEAPON    , MODULE_DD,  96,  -1,  0}, // 606
{"Magical broadsword"               , 1, 6,  8,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_DD, 105,  -1,  0}, // 607
{"Tarot cards"                      , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DD, 117,  -1,  0}, // 608
{"Metals and rings"                 , 0, 0,  0,  0,  0, 24000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DD, 123,  -1,  0}, // 609
{"Gold baton"                       , 0, 0,  0,  0,  0,  5000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DD, 124,  -1,  0}, // 610
{"Jewels and soft gold"             , 0, 0,  0,  0,  0,250000,   UK,   0,  0, FALSE, JEWEL        , MODULE_DD, 131,  -1,  0}, // 611
{"Entak's broadsword"               , 1, 6,  0, 15, 11,  7000,  150,   0,  0, TRUE , WEAPON_SWORD , MODULE_DD, 132, 120,  0}, // 612
{"Silver box"                       , 0, 0,  0,  0,  0, 15000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DD, 133,  -1,  0}, // 613
{"Ring of lightning"                , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_DD, 133,  -1,  0}, // 614
{"Magic haladie"                    , 1, 2,  4,  2,  4,  2500,   15,   0,  0, TRUE , WEAPON_DAGGER, MODULE_DD, 136,  -1,  0}, // 615
{"Witch's ring"                     , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, TRUE , RING         , MODULE_DD, 143,  -1,  0}, // 616
{"Rumm"                             , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, FALSE, SLAVE        , MODULE_DD,  84,  -1,  0}, // 617
{"Attuned gem"                      , 0, 0,  0,  0,  0,  1000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DD, 101,  -1,  0}, // 618
{"\"Wizard's Wand\" sword"          , 1, 1, 30,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_OK,  13,  -1,  0}, // 619
{"Robes of Marionarsis"             , 0, 0,  0,  0,  0,   0  ,   UK,   0, 20, TRUE , ARMOUR       , MODULE_OK,  13,  -1,  0}, // 620
{"Talisman of zombie decay"         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_OK,  44,  -1,  0}, // 621
{"Deluxe staff ring"                , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_OK,  78,  -1,  0}, // 622
{"Icefall ring"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_OK,  79,  -1,  0}, // 623
{"Ring of Hellbomb Burst absorption", 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_OK,  92,  -1,  0}, // 624
{"Enchanted great sword"            , 2, 6,  0, 21, 18, 12000,  170,   0,  0, TRUE , WEAPON_SWORD , MODULE_OK, 115,  -1,  0}, // 625
{"Gems"                             , 0, 0,  0,  0,  0,1000000,  UK,   0,  0, FALSE, JEWEL        , MODULE_OK,   4,  -1,  0}, // 626
{"Sunshard (6')"                    , 1, 8,  0,  5,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_RC,  37,  69,  0}, // 627 also RC130/161. This has different powers depending on how it was acquired!
{"Helmet of Rex Sunwolf"            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , ARMOUR_HEAD  , MODULE_RC,  68,  99,  0}, // 628 This has different powers depending on how it was acquired!
{"Amulet of Shang"                  , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_OK,   8, 115,  0}, // 629 also OK118
{"Spellbook"                        , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_OK,   7,  -1,  0}, // 630
{"Scroll"                           , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_OK, 130,  -1,  0}, // 631
{"Boarding pike"                    , 2, 4,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_POLE  , MODULE_SM,  23,  -1,  0}, // 632
{"Native spear"                     , 1, 3,  1,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_SPEAR , MODULE_SM,  55,  -1,  0}, // 633
{"Sharp rock"                       , 1, 2,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_OTHER , MODULE_SM,  95,  -1,  0}, // 634
{"Hammer"                           , 1, 4,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_HAFTED, MODULE_SM, 102,  -1,  0}, // 635
{"Broken bottle"                    , 1, 1,  3,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_DAGGER, MODULE_SM, 136,  -1,  0}, // 636
{"Gems"                             , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SM,  67,  -1,  0}, // 637 also CA231
{"Gems"                             , 0, 0,  0,  0,  0,200000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SM,  67,  -1,  0}, // 638 also BS222
{"Gems"                             , 0, 0,  0,  0,  0,300000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SM,  67,  -1,  0}, // 639 also SO25/113
{"Gems"                             , 0, 0,  0,  0,  0,400000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SM,  67,  -1,  0}, // 640
{"Gems"                             , 0, 0,  0,  0,  0,500000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SM,  67,  -1,  0}, // 641 also OK7
{"Gems"                             , 0, 0,  0,  0,  0,600000,   UK,   0,  0, FALSE, JEWEL        , MODULE_SM,  67,  -1,  0}, // 642 also OK104
{"Silver armband"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_RC,  86,  -1,  0}, // 643
{"Runeshield"                       , 1, 0,  0,  0,  0,   0  ,   UK,   0,  6, TRUE , SHIELD       , MODULE_RC, 193,  -1,  0}, // 644
{"Special broadsword (3'-4')"       , 1, 5,  0, 15, 10,   0  ,  120,   0,  0, FALSE, WEAPON_SWORD , MODULE_RC, 182,  -1,  0}, // 645
{"Emerald"                          , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, FALSE, JEWEL        , MODULE_CA,   4,  -1,  0}, // 646
{"Frog"                             , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, FALSE, SLAVE        , MODULE_CA,  10,  -1,  0}, // 647
{"Ring"                             , 0, 0,  0,  0,  0, 25000,   UK,   0,  0, FALSE, RING         , MODULE_CA,  11,  -1,  0}, // 648
{"Amara"                            , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, FALSE, SLAVE        , MODULE_CA,  15,  -1,  0}, // 649
{"Silver dagger"                    , 1, 2,  0,  0,  0, 50000,   UK,   0,  0, FALSE, WEAPON_DAGGER, MODULE_CA,  15,  -1,  0}, // 650 %%: how many dice+adds?
{"Jewels"                           , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, JEWEL        , MODULE_CA,  16,  44,  0}, // 651
{"Gold unicorn statue"              , 0, 0,  0,  0,  0, 25000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_CA,  21,  -1,  0}, // 652
{"Magical sword"                    , 1, 5,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_CA, 100,  -1,  0}, // 653
{"Sapphire"                         , 0, 0,  0,  0,  0, 30000,   UK,   0,  0, FALSE, JEWEL        , MODULE_CA,  26,  -1,  0}, // 654
{"Flute"                            , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_CA,  28,  -1,  0}, // 655
{"Gem"                              , 0, 0,  0,  0,  0,  1500,   UK,   0,  0, FALSE, JEWEL        , MODULE_CA,  30,  -1,  0}, // 656
{"Diamond necklace"                 , 0, 0,  0,  0,  0,150000,   UK,   0,  0, FALSE, JEWEL        , MODULE_CA,  39,  -1,  0}, // 657
{"Ruby ring"                        , 0, 0,  0,  0,  0, 20000,   UK,   0,  0, FALSE, RING         , MODULE_CA,  44,  -1,  0}, // 658
{"Jewels"                           , 0, 0,  0,  0,  0, 25000,   UK,   0,  0, FALSE, JEWEL        , MODULE_CA,  47,  -1,  0}, // 659
{"Cloak of invisibility"            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CA,  53,  -1,  0}, // 660
{"Engraved thank-you note"          , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_CA,  53,  -1,  0}, // 661
{"Small mithril statue of fat genie", 0, 0,  0,  0,  0,200000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_CA,  53,  -1,  0}, // 662
{"Magical blue leather armour"      , 0, 0,  0,  0,  0,   0  ,   UK,   0,  8, TRUE , ARMOUR       , MODULE_CA,  56,  26,  0}, // 663
{"Small locket"                     , 0, 0,  0,  0,  0,   100,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CA,  68,  -1,  0}, // 664
{"Jade box"                         , 0, 0,  0,  0,  0, 30000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_CA,  72,  -1,  0}, // 665
{"Cycera"                           , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, FALSE, SLAVE        , MODULE_CA,  79, 170,  0}, // 666
{"Silver statue of Vivina"          , 0, 0,  0,  0,  0, 50000,   50,   0,  1, TRUE , NONWEAPON    , MODULE_CA,  82,  -1,  0}, // 667
{"Medallion of Vivina"              , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CA,  83,  -1,  0}, // 668
{"40' blue rope"                    , 0, 0,  0,  0,  0,   0  ,   UK,  20,  0, TRUE , NONWEAPON    , MODULE_CA,  88,  -1,  0}, // 669
{"Amulet of Narada"                 , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CA,  94,  -1,  0}, // 670
{"Topaz necklace"                   , 0, 0,  0,  0,  0, 35000,   UK,   0,  0, FALSE, JEWEL        , MODULE_CA,  99,  -1,  0}, // 671
{"Small sapphire"                   , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, FALSE, JEWEL        , MODULE_CA, 113,  -1,  0}, // 672
{"Huge sapphire"                    , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, JEWEL        , MODULE_CA, 114,  -1,  0}, // 673
{"Sapphire ring"                    , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, FALSE, RING         , MODULE_CA, 128,  -1,  0}, // 674
{"Silver dagger with sapphire blade", 1, 2, 10,  0,  0,100000,   UK,   0,  0, FALSE, WEAPON_DAGGER, MODULE_CA, 128,  -1,  0}, // 675
{"Large green emerald"              , 0, 0,  0,  0,  0,150000,    4,   0,  0, TRUE , JEWEL        , MODULE_CA, 154,  -1,  0}, // 676
// Generic (jewels)
{"Small quartz"                     , 0, 0,  0,  0,  0,   500,    1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 677
{"Average quartz"                   , 0, 0,  0,  0,  0,  1000,    2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 678
{"Large quartz"                     , 0, 0,  0,  0,  0,  2000,    4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 679
{"Larger quartz"                    , 0, 0,  0,  0,  0,  5000,   10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 680
{"Huge quartz"                      , 0, 0,  0,  0,  0, 10000,   20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 681
{"Small enamel"                     , 0, 0,  0,  0,  0,   500*2,  1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 682
{"Average enamel"                   , 0, 0,  0,  0,  0,  1000*2,  2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 683
{"Large enamel"                     , 0, 0,  0,  0,  0,  2000*2,  4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 684
{"Larger enamel"                    , 0, 0,  0,  0,  0,  5000*2, 10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 685
{"Huge enamel"                      , 0, 0,  0,  0,  0, 10000*2, 20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 686
{"Small topaz"                      , 0, 0,  0,  0,  0,   500*3,  1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 687
{"Average topaz"                    , 0, 0,  0,  0,  0,  1000*3,  2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 688
{"Large topaz"                      , 0, 0,  0,  0,  0,  2000*3,  4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 689
{"Larger topaz"                     , 0, 0,  0,  0,  0,  5000*3, 10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 690
{"Huge topaz"                       , 0, 0,  0,  0,  0, 10000*3, 20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 691
{"Small garnet"                     , 0, 0,  0,  0,  0,   500*4,  1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 692
{"Average garnet"                   , 0, 0,  0,  0,  0,  1000*4,  2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 693
{"Large garnet"                     , 0, 0,  0,  0,  0,  2000*4,  4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 694
{"Larger garnet"                    , 0, 0,  0,  0,  0,  5000*4, 10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 695
{"Huge garnet"                      , 0, 0,  0,  0,  0, 10000*4, 20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 696
{"Small turquoise"                  , 0, 0,  0,  0,  0,   500*5,  1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 697
{"Average turquoise"                , 0, 0,  0,  0,  0,  1000*5,  2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 698
{"Large turquoise"                  , 0, 0,  0,  0,  0,  2000*5,  4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 699
{"Larger turquoise"                 , 0, 0,  0,  0,  0,  5000*5, 10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 700
{"Huge turquoise"                   , 0, 0,  0,  0,  0, 10000*5, 20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 701
{"Small amethyst"                   , 0, 0,  0,  0,  0,   500*6,  1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 702
{"Average amethyst"                 , 0, 0,  0,  0,  0,  1000*6,  2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 703
{"Large amethyst"                   , 0, 0,  0,  0,  0,  2000*6,  4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 704
{"Larger amethyst"                  , 0, 0,  0,  0,  0,  5000*6, 10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 705
{"Huge amethyst"                    , 0, 0,  0,  0,  0, 10000*6, 20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 706
{"Small ivory"                      , 0, 0,  0,  0,  0,   500*7,  1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 707
{"Average ivory"                    , 0, 0,  0,  0,  0,  1000*7,  2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 708
{"Large ivory"                      , 0, 0,  0,  0,  0,  2000*7,  4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 709
{"Larger ivory"                     , 0, 0,  0,  0,  0,  5000*7, 10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 710
{"Huge ivory"                       , 0, 0,  0,  0,  0, 10000*7, 20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 711
{"Small carnelian"                  , 0, 0,  0,  0,  0,   500*8,  1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 712
{"Average carnelian"                , 0, 0,  0,  0,  0,  1000*8,  2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 713
{"Large carnelian"                  , 0, 0,  0,  0,  0,  2000*8,  4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 714
{"Larger carnelian"                 , 0, 0,  0,  0,  0,  5000*8, 10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 715
{"Huge carnelian"                   , 0, 0,  0,  0,  0, 10000*8, 20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 716
{"Small opal"                       , 0, 0,  0,  0,  0,   500*9,  1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 717
{"Average opal"                     , 0, 0,  0,  0,  0,  1000*9,  2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 718
{"Large opal"                       , 0, 0,  0,  0,  0,  2000*9,  4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 719
{"Larger opal"                      , 0, 0,  0,  0,  0,  5000*9, 10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 720
{"Huge opal"                        , 0, 0,  0,  0,  0, 10000*9, 20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 721
{"Small fire-opal"                  , 0, 0,  0,  0,  0,   500*10, 1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 722
{"Average fire-opal"                , 0, 0,  0,  0,  0,  1000*10, 2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 723
{"Large fire-opal"                  , 0, 0,  0,  0,  0,  2000*10, 4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 724
{"Larger fire-opal"                 , 0, 0,  0,  0,  0,  5000*10,10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 725
{"Huge fire-opal"                   , 0, 0,  0,  0,  0, 10000*10,20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 726 also BW105/269
{"Small aquamarine"                 , 0, 0,  0,  0,  0,   500*11, 1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 727
{"Average aquamarine"               , 0, 0,  0,  0,  0,  1000*11, 2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 728
{"Large aquamarine"                 , 0, 0,  0,  0,  0,  2000*11, 4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 729
{"Larger aquamarine"                , 0, 0,  0,  0,  0,  5000*11,10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 730
{"Huge aquamarine"                  , 0, 0,  0,  0,  0, 10000*11,20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 731
{"Small jade"                       , 0, 0,  0,  0,  0,   500*12, 1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 732
{"Average jade"                     , 0, 0,  0,  0,  0,  1000*12, 2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 733
{"Large jade"                       , 0, 0,  0,  0,  0,  2000*12, 4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 734
{"Larger jade"                      , 0, 0,  0,  0,  0,  5000*12,10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 735
{"Huge jade"                        , 0, 0,  0,  0,  0, 10000*12,20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 736
{"Small serpentine"                 , 0, 0,  0,  0,  0,   500*13, 1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 737
{"Average serpentine"               , 0, 0,  0,  0,  0,  1000*13, 2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 738
{"Large serpentine"                 , 0, 0,  0,  0,  0,  2000*13, 4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 739
{"Larger serpentine"                , 0, 0,  0,  0,  0,  5000*13,10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 740
{"Huge serpentine"                  , 0, 0,  0,  0,  0, 10000*13,20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 741
{"Small pearl"                      , 0, 0,  0,  0,  0,   500*14, 1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 742
{"Average pearl"                    , 0, 0,  0,  0,  0,  1000*14, 2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 743
{"Large pearl"                      , 0, 0,  0,  0,  0,  2000*14, 4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 744
{"Larger pearl"                     , 0, 0,  0,  0,  0,  5000*14,10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 745
{"Huge pearl"                       , 0, 0,  0,  0,  0, 10000*14,20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 746
{"Small ruby"                       , 0, 0,  0,  0,  0,   500*15, 1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 747
{"Average ruby"                     , 0, 0,  0,  0,  0,  1000*15, 2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 748
{"Large ruby"                       , 0, 0,  0,  0,  0,  2000*15, 4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 749
{"Larger ruby"                      , 0, 0,  0,  0,  0,  5000*15,10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 750
{"Huge ruby"                        , 0, 0,  0,  0,  0, 10000*15,20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 751
{"Small sapphire"                   , 0, 0,  0,  0,  0,   500*16, 1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 752
{"Average sapphire"                 , 0, 0,  0,  0,  0,  1000*16, 2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 753
{"Large sapphire"                   , 0, 0,  0,  0,  0,  2000*16, 4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 754
{"Larger sapphire"                  , 0, 0,  0,  0,  0,  5000*16,10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 755
{"Huge sapphire"                    , 0, 0,  0,  0,  0, 10000*16,20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 756
{"Small diamond"                    , 0, 0,  0,  0,  0,   500*17, 1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 757
{"Average diamond"                  , 0, 0,  0,  0,  0,  1000*17, 2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 758
{"Large diamond"                    , 0, 0,  0,  0,  0,  2000*17, 4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 759
{"Larger diamond"                   , 0, 0,  0,  0,  0,  5000*17,10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 760
{"Huge diamond"                     , 0, 0,  0,  0,  0, 10000*17,20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 761
{"Small emerald"                    , 0, 0,  0,  0,  0,   500*18, 1,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 762
{"Average emerald"                  , 0, 0,  0,  0,  0,  1000*18, 2,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 763
{"Large emerald"                    , 0, 0,  0,  0,  0,  2000*18, 4,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 764
{"Larger emerald"                   , 0, 0,  0,  0,  0,  5000*18,10,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 765
{"Huge emerald"                     , 0, 0,  0,  0,  0, 10000*18,20,   0,  0, FALSE, JEWEL        , MODULE_RB,  -1,  -1,  0}, // 766
// Module-specific
{"Sapphire"                         , 0, 0,  0,  0,  0, 75000,    1,   0,  0, FALSE, JEWEL        , MODULE_CA, 207,  -1,  0}, // 767
{"Silver bracelet with sapphire"    , 0, 0,  0,  0,  0, 20000,    1,   0,  0, TRUE , JEWEL        , MODULE_CA, 207,  -1,  0}, // 768
{"Large pearl"                      , 0, 0,  0,  0,  0,500000,    1,   0,  0, FALSE, JEWEL        , MODULE_CA, 211,  -1,  0}, // 769
{"Ruby ring"                        , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, FALSE, RING         , MODULE_CA, 250,  -1,  0}, // 770
{"Small foot pin"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , JEWEL        , MODULE_CA, 263,  -1,  0}, // 771
{"Scourge (3')"                     , 1, 5,  0, 10, 11,  6000,  100,   0,  0, TRUE , WEAPON_SWORD , MODULE_CA, 300, 296,  0}, // 772
{"Gold sceptre"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_CA, 301,  -1,  0}, // 773
{"Lord Shorman"                     , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, FALSE, SLAVE        , MODULE_CA, 200,  -1,  0}, // 774
{"Silver jewellery"                 , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, FALSE, JEWEL        , MODULE_CA, 200,  -1,  0}, // 775
{"Nik-El-Dim"                       , 1, 5,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_CA, 305, 293,  0}, // 776
{"Magical sword"                    , 1, 6,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_CA,   9,  70,  0}, // 777 also CA101
{"Magical silver armour"            , 0, 0,  0,  0,  0,   0  ,   UK,   0, 10, TRUE , ARMOUR       , MODULE_CA, 100,  -1,  0}, // 778
{"Friend"                           , 1, 2,  2,  2,  8,  2100,   12,  10,  0, TRUE , WEAPON_DAGGER, MODULE_CA, 298,  -1,  0}, // 779
{"Water-producing haladie"          , 1, 2,  4,  2,  4,  2500,   15,   0,  0, TRUE , WEAPON_DAGGER, MODULE_CA, 312,  -1,  0}, // 780
{"Magical axe"                      , 1, 6,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_HAFTED, MODULE_CA, 243,  -1,  0}, // 781
{"Matchlock rifle"                  , 2, 8, 25, 15,  8,375000,  120, 100,  0, FALSE, WEAPON_GUNNE , MODULE_RB, 130,  -1,  0}, // 782
{"Wheel lock rifle"                 , 2, 7, 20, 12,  8,540000,  120, 100,  0, FALSE, WEAPON_GUNNE , MODULE_RB, 132,  -1,  0}, // 783
{"Snaphaunce rifle"                 , 2, 7, 25, 10,  8,750000,  120, 100,  0, FALSE, WEAPON_GUNNE , MODULE_RB, 134,  -1,  0}, // 784
{"Flintlock rifle"                  , 2, 8, 30, 10,  8,1050000, 120, 100,  0, FALSE, WEAPON_GUNNE , MODULE_RB, 136,  -1,  0}, // 785
{"Krieviski snowblade"              , 2, 4,  0, 15, 16,   0  ,   UK,   0,  0, FALSE, WEAPON_SWORD , MODULE_CI,   5,  -1,  0}, // 786
{"Clear blue gemstone of cold"      , 0, 0,  0,  0,  0,   0  ,    1,   0,  0, TRUE , JEWEL        , MODULE_CI,  20,  -1,  0}, // 787
{"Dark crystal"                     , 0, 0,  0,  0,  0,100000,    1,   0,  0, TRUE , JEWEL        , MODULE_CI,  27,  -1,  0}, // 788
{"Ice spider"                       , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, FALSE, SLAVE        , MODULE_CI,  29,  -1,  0}, // 789
{"Soul-eating dirk (and sheath)"    , 1, 2, 13,  1,  4,   0  ,   16,  10,  0, TRUE , WEAPON_DAGGER, MODULE_CI,  31,  -1,  0}, // 790
{"Dragon's tooth dirk (and sheath)" , 1, 2, 13,  1,  4,   0  ,   16,  10,  0, TRUE , WEAPON_DAGGER, MODULE_CI,  31,  -1,  0}, // 791
{"Locket of Lady Clairelichte"      , 0, 0,  0,  0,  0,100000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CI,  33,  -1,  0}, // 792
{"Cinity sling stone"               , 0, 0,  0,  0,  0,   0  ,    1,   0,  0, TRUE , WEAPON_STONE , MODULE_CI,  40,  -1,  0}, // 793
{"Goldfire cane"                    , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CI,  43,  -1,  0}, // 794
{"Woven metallic headband"          , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CI,  49,  -1,  0}, // 795
{"Ruby-red crystal"                 , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, TRUE , JEWEL        , MODULE_CI,  50,  -1,  0}, // 796
{"Fiery red glowing crystal"        , 0, 0,  0,  0,  0,100000,   UK,   0,  0, TRUE , JEWEL        , MODULE_CI,  57,  -1,  0}, // 797 %%: we assume it is magical
{"Liels Kukainis sarkans egg"       , 0, 0,  0,  0,  0, 10000,    0,   0,  0, TRUE , SLAVE        , MODULE_CI,  58,  -1,  0}, // 798
{"Silver locket and chain"          , 0, 0,  0,  0,  0, 20000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_CI,  60,  -1,  0}, // 799
{"Ring of black ivory"              , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_CI,  67,  -1,  0}, // 800
{"Vial of lunar pollen"             , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_CI,  68,  -1,  0}, // 801 %%: we assume it is magical
{"Serpent statue"                   , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DD,  62,  -1,  0}, // 802
{"Map of Trollstone Caverns"        , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_TC,   0,  -1,  0}, // 803
{"Map of caravan route"             , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_CA,   0,  -1,  0}, // 804
{"Lunch"                            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_IC,   1,  -1,  0}, // 805
{"Water sack"                       , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_IC,   1,  -1,  0}, // 806
{"Glowing lock"                     , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_IC,   3,   4,  0}, // 807
{"Skull and crossbones potion"      , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, TRUE , POTION       , MODULE_IC,   6,  -1,  0}, // 808 if we tell them about IC11 it will be a spoiler
{"Mousetrap"                        , 0, 0,  0,  0,  0,    10,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_IC,  24,  -1,  0}, // 809
{"Emerald"                          , 0, 0,  0,  0,  0, 45000,   UK,   0,  0, FALSE, JEWEL        , MODULE_IC,  28,  -1,  0}, // 810
{"Rock of illusion"                 , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_IC,  31,  -1,  0}, // 811
{"Magic lantern"                    , 1, 0,  0,  0,  0,  1000,   10,   0,  0, TRUE , NONWEAPON    , MODULE_IC,  40,  -1,  0}, // 812
{"Small bag of dust"                , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_WC, 246,  -1,  0}, // 813 %%: we assume it is non-magical
{"Small golden earring"             , 0, 0,  0,  0,  0,  1500,   UK,   0,  0, FALSE, JEWEL        , MODULE_NS,  55,  -1,  0}, // 814
{"Short length of silver chain"     , 0, 0,  0,  0,  0,   100,   UK,   0,  0, FALSE, JEWEL        , MODULE_NS,  55,  -1,  0}, // 815
{"Heart of Edualc"                  , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE,  NONWEAPON    , MODULE_NS,  64,  -1,  0}, // 816
{"Diamond stud"                     , 0, 0,  0,  0,  0, 25000,   UK,   0,  0, FALSE, JEWEL        , MODULE_NS,  84,  -1,  0}, // 817
{"Copper ring of health"            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_HH,  13,  -1,  0}, // 818
{"Glowing dirk"                     , 1, 2,  1,  1,  4,  1800,   16,  10,  0, TRUE , WEAPON_DAGGER, MODULE_HH,  27,  -1,  0}, // 819
{"Magic steel cap"                  , 0, 0,  0,  1,  0,  1000,   25,   0,  3, TRUE , ARMOUR       , MODULE_HH,  28,  -1,  0}, // 820
{"Perfect friend"                   , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, FALSE, SLAVE        , MODULE_HH,  31,  -1,  0}, // 821
{"Flaming Cherry's ticket"          , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_HH,  38,  -1,  0}, // 822
{"Banquet of Champions ticket"      , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_HH,  39,  -1,  0}, // 823
{"Queen's Folly ticket"             , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_HH,  40,  -1,  0}, // 824
{"Arena of Khazan pass"             , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_HH,  40,  -1,  0}, // 825
{"Enchanted steel armour"           , 0, 0,  0, 11,  0,3000000, 500,   0,100, TRUE , ARMOUR       , MODULE_HH,  50,  -1,  0}, // 826 %%: we assume it is compared to complete plate
{"Fantasy armour"                   , 0, 0,  0,  0,  0,50000000, UK,   0,  0, TRUE , ARMOUR       , MODULE_HH,  51,  -1,  0}, // 827
{"Glass"                            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, JEWEL        , MODULE_HH,  16,  -1,  0}, // 828
{"Goblin dagger"                    , 1, 1,  3,  1,  1,   0  ,   UK,   0,  0, FALSE, WEAPON_DAGGER, MODULE_GL,  71,  -1,  0}, // 829
{"Special gold coin(s)"             , 0, 0,  0,  0,  0,   100,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_GK,  99,  12,  0}, // 830
{"Priest robes"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, ARMOUR       , MODULE_BF,  22,  -1,  0}, // 831
{"Cursed broadsword"                , 1, 6,  8,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_GK,  19,  -1,  0}, // 832
{"Cursed deluxe magic staff"        , 0, 0,  0,  0,  0,   0  ,   30,   0,  0, TRUE , NONWEAPON    , MODULE_GK,  52,  -1,  0}, // 833
{"Clay replica Doric Silencer sword", 1, 3,  0,  0,  0,  5000,   70,   0,  0, TRUE , WEAPON_SWORD , MODULE_LA, 134, 163,  0}, // 834
{"Crystal orb on a chain"           , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, JEWEL        , MODULE_NS,  85,  -1,  0}, // 835
{"Silver and gold signet ring"      , 0, 0,  0,  0,  0, 17500,   UK,   0,  0, FALSE, RING         , MODULE_NS,  85,  -1,  0}, // 836
{"Silver locket"                    , 0, 0,  0,  0,  0,  8000,   UK,   0,  0, FALSE, JEWEL        , MODULE_NS,  85,  -1,  0}, // 837
{"Armour ring"                      , 0, 0,  0,  0,  0,  8000,   UK,   0,  6, TRUE , RING         , MODULE_NS,  96, 111,  0}, // 838
{"Homunculus"                       , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, TRUE , SLAVE        , MODULE_NS,  97,  -1,  0}, // 839
{"Homunculus egg"                   , 0, 0,  0,  0,  0, 30000,    0,   0,  0, TRUE , SLAVE        , MODULE_NS,  97,  -1,  0}, // 840
{"Pouch of diamonds"                , 0, 0,  0,  0,  0, 30000,   UK,   0,  0, FALSE, JEWEL        , MODULE_NS, 109,  -1,  0}, // 841
{"Clear crystal (diamond)"          , 0, 0,  0,  0,  0,  1000,    1,   0,  0, FALSE, JEWEL        , MODULE_NS, 114, 154,  0}, // 842
{"Rubies"                           , 0, 0,  0,  0,  0, 21000,   UK,   0,  0, FALSE, JEWEL        , MODULE_NS, 134,  -1,  0}, // 843
{"Magic marble"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , JEWEL        , MODULE_NS, 134,  -1,  0}, // 844
{"Will-o-Wisp ring"                 , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_NS, 134,  -1,  0}, // 845
{"Red stone (ruby)"                 , 0, 0,  0,  0,  0,   800,    1,   0,  0, FALSE, JEWEL        , MODULE_NS, 136, 129,  0}, // 846
{"Too-Bad Toxin ring"               , 0, 0,  0,  0,  0,  2000,   UK,   0,  0, TRUE , RING         , MODULE_NS, 137,  -1,  0}, // 847
{"Finger bone"                      , 0, 0,  0,  0,  0,   0  ,   UK,   0, 10, TRUE , ARMOUR       , MODULE_NS, 144,  -1,  0}, // 848
{"Copper eating dagger"             , 0, 0,  0,  0,  0,   800,   UK,   0,  0, TRUE , WEAPON_DAGGER, MODULE_NS, 148,  -1,  0}, // 849
{"Locket"                           , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, JEWEL        , MODULE_NS, 156,  -1,  0}, // 850
{"Book about fire elementals"       , 0, 0,  0,  0,  0, 80000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_NS, 159,  -1,  0}, // 851
{"Small golden orb"                 , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , JEWEL        , MODULE_NS, 182,  -1,  0}, // 852
{"Book about fire elementals"       , 0, 0,  0,  0,  0,180000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_NS, 184,  -1,  0}, // 853
{"Second Sight ring"                , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_NS, 184,  -1,  0}, // 854
{"Bit of unicorn horn"              , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_NS, 184,  -1,  0}, // 855 %%: we assume it is non-magical
{"Bag of Plenty"                    , 0, 0,  0,  0,  0,   0  ,   50,   0,  0, TRUE , NONWEAPON    , MODULE_NS, 184,  -1,  0}, // 856
{"Dwarven dirk"                     , 1, 3,  1,  1,  4,  5400,   16,  10,  0, FALSE, WEAPON_DAGGER, MODULE_NS, 197,  -1,  0}, // 857
{"Small bronze salt shaker"         , 0, 0,  0,  0,  0,  1200,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_NS, 197,  -1,  0}, // 858
{"Box of jewels"                    , 0, 0,  0,  0,  0, 30000,   UK,   0,  0, FALSE, JEWEL        , MODULE_NS, 200,  -1,  0}, // 859
{"Magic compass"                    , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_NS, 218,  -1,  0}, // 860
{"Bit of quartz"                    , 0, 0,  0,  0,  0,    12,   UK,   0,  0, FALSE, JEWEL        , MODULE_NS, 221,  -1,  0}, // 861
{"Purple Dragon Egg crystal"        , 0, 0,  0,  0,  0, 30000,   UK,   0,  0, TRUE , JEWEL        , MODULE_NS, 222,  -1,  0}, // 862
{"Lasso"                            , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_NS, 118, 223,  0}, // 863
{"Toe bone"                         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_NS, 228,  -1,  0}, // 864
{"Piece of jewellery"               , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, FALSE, JEWEL        , MODULE_NS, 230,  -1,  0}, // 865
{"Tiny gold chain"                  , 0, 0,  0,  0,  0,    50,   UK,   0,  0, FALSE, JEWEL        , MODULE_BW,  60,  -1,  0}, // 866
{"Shiny gold nugget"                , 0, 0,  0,  0,  0,   100,   UK,   0,  0, FALSE, JEWEL        , MODULE_BW,  88,  -1,  0}, // 867 %%: it doesn't actually say what they are worth
{"11th level spellbook"             , 0, 0,  0,  0, 0,5000000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_BW, 102,  -1,  0}, // 868
{"Dragonscale shield"               , 0, 0,  0,  0,  0,   0  ,   UK,   0,  9, FALSE, SHIELD       , MODULE_BW, 135,  -1,  0}, // 869
{"Ghost Breaker amulet"             , 0, 0,  0,  0,  0, 50000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_BW, 235,  -1,  0}, // 870
{"Hellbomb Bursts shield"           , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , SHIELD       , MODULE_BW, 280,  -1,  0}, // 871 %%: how many hits does this take?
{"Idol"                             , 0, 0,  0,  0,  0,500000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_BW, 290,  -1,  0}, // 872
{"Straight sword \"Dreamreaver\""   , 1, 4,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_SWORD , MODULE_BW,   1,  -1,  0}, // 873
{"Ahnit"                            , 1, 8,  0,  0,  0,   0  ,   10,   0,  0, TRUE , WEAPON_OTHER , MODULE_BW,  58, 121,  0}, // 874
{"Ration bag"                       , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT,   0,  -1,  0}, // 875
{"Triangular key"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT,  12,  -1,  0}, // 876 also DT40/48/292/299/329
{"Adventurer's map"                 , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT,  25,  -1,  0}, // 877 also DT12/18/40/48
{"Magic liquor"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_DT,  34,  51,  0}, // 878
{"Gold ore"                         , 0, 0,  0,  0,  0, 30000,  300,   0,  0, FALSE, JEWEL        , MODULE_DT,  44,  -1,  0}, // 879
{"Dwarven rock-pick"                , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DT,  44,  -1,  0}, // 880
{"Witch's powder"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DT,  51,  -1,  0}, // 881
{"Green robe"                       , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT,  74,  -1,  0}, // 882 also various other paragraphs
{"Small amulet"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , JEWEL        , MODULE_DT, 126,  -1,  0}, // 883
{"Yastri's map"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT, 126,  -1,  0}, // 884
{"Jail keys"                        , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT, 130,  -1,  0}, // 885
{"Bucket"                           , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT, 140,  -1,  0}, // 886
{"Balsa wood club"                  , 1, 2,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_HAFTED, MODULE_DT, 140,  -1,  0}, // 887
{"Yastri's armour"                  , 0, 0,  0,  0,  0,   0  ,   UK,   0, 20, TRUE , ARMOUR       , MODULE_DT, 151, 406,  0}, // 888 also DT198. %%: It is definitely magical AND alien (see DT198 and DT406)
{"Gold cup"                         , 0, 0,  0,  0,  0, 25000,   20,   0,  0, FALSE, JEWEL        , MODULE_DT, 154, 200,  0}, // 889
{"Ogre's gloves"                    , 2, 3,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, WEAPON_OTHER , MODULE_DT, 154, 200,  0}, // 890
{"Phoenix Scroll"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DT, 228,  -1,  0}, // 891
{"Pipe of pipeweed"                 , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT, 165,  -1,  0}, // 892
{"Tarnished copper dagger"          , 1, 2,  0,  1,  3,  1000,   10,  10,  0, FALSE, WEAPON_DAGGER, MODULE_DT, 166,  -1,  0}, // 893 %%: it doesn't give stats for this!
{"Limestone carving"                , 0, 0,  0,  0,  0,   0  ,  300,   0,  0, FALSE, NONWEAPON    , MODULE_DT, 166,  -1,  0}, // 894 %%: it doesn't give a value for this!
{"Peddler's map"                    , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT, 185, 197,  0}, // 895 %%: just because we paid 100 gp for it doesn't necessarily mean we could sell it for that?
{"Glowing alabaster"                , 0, 0,  0,  0,  0,100000,   UK,   0,  0, TRUE , JEWEL        , MODULE_DT, 218,  -1,  0}, // 896
{"Vorpal Blade rapier"              , 1, 6,  4, 10, 14,  8000,   20,   0,  0, TRUE , WEAPON_SWORD , MODULE_DT, 231,  -1,  0}, // 897
{"Noble garb"                       , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT, 280,  -1,  0}, // 898
{"Magic katar"                      , 1, 2,  4,  2,  8,  1800,   22,   0,  0, TRUE , WEAPON_DAGGER, MODULE_DT, 362, 390,  0}, // 899
{"Complete mithril plate"           , 0, 0,  0, 11,  0,500000, 1000,   0, 21, FALSE, ARMOUR       , MODULE_DT, 394,  -1,  0}, // 900 and see also section 3.12 of the rulebook
{"Huge grey warhorse"               , 0, 0,  0,  0,  0, 20000,    0,   0,  0, FALSE, SLAVE        , MODULE_DT, 394,  -1,  0}, // 901 %%: we assume it is worth at least as much as a normal horse
{"Complete nickel plate"            , 0, 0,  0, 11,  0, 50000, 1000,   0, 14, FALSE, ARMOUR       , MODULE_DT, 404,  -1,  0}, // 902 %%: we assume it is similar to normal plate
{"Papers"                           , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT,  74,  -1,  0}, // 903
{"Myrean adventurer's clothing"     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT, 344,  -1,  0}, // 904
{"Potion vs. curses/diseases"       , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_DT, 225,  -1,  0}, // 905
{"Gold cup"                         , 0, 0,  0,  0,  0, 20000,   20,   0,  0, FALSE, JEWEL        , MODULE_DT, 225,  -1,  0}, // 906 %%: we assume it weighs the same as the other gold cup (the one from DT154/DT200)
{"Mithril poniard"                  , 1, 3,  0,  1,  3, 10000,   10,  10,  0, FALSE, WEAPON_DAGGER, MODULE_DT, 225,  -1,  0}, // 907 and see also section 3.12 of the rulebook
{"Wolf's ears"                      , 0, 0,  0,  0,  0,   800,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT,1028,  -1,  0}, // 908
{"Amulet studded with magic gems"   , 0, 0,  0,  0,  0, 30000,   15,   0,  0, TRUE , JEWEL        , MODULE_DT, 256, 274,  0}, // 909
{"Set of golden pipes"              , 0, 0,  0,  0,  0, 10000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT, 258,  -1,  0}, // 910 %%: or perhaps JEWEL?
{"Enchanted sax"                    , 1, 4, 10,  7, 10,  3000,   25,   0,  0, TRUE , WEAPON_DAGGER, MODULE_DT, 288,  -1,  0}, // 911
{"Enchanted hand-and-a-half sword"  , 1, 5,  0, 16, 12,  9000,  150,   0,  0, TRUE , WEAPON_SWORD , MODULE_DT, 297,  -1,  0}, // 912
{"Herbal tea of curse removal"      , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , POTION       , MODULE_DT, 329,  -1,  0}, // 913
{"Mithril ring"                     , 0, 0,  0,  0,  0, 15000,   UK,   0,  0, FALSE, RING         , MODULE_DT, 329,  -1,  0}, // 914
{"Enchanted bronze gladius"         , 1, 3,  2, 10,  7,  6500,   70,   0,  0, TRUE , WEAPON_SWORD , MODULE_DT, 299,  -1,  0}, // 915 and see also section 3.12 of the rulebook
{"Scrap of paper with charm"        , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DT, 327,  -1,  0}, // 916
{"Herbal poultice"                  , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT, 341,  -1,  0}, // 917
{"Dragon's ears"                    , 0, 0,  0,  0,  0,100000,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_DT, 343,  -1,  0}, // 918
{"Magic arrow(s)"                   , 0, 0,  0,  0,  0,   160,    1,   0,  0, TRUE , WEAPON_ARROW , MODULE_DT, 348,  -1,  0}, // 919
{"Bottle of magic wine"             , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DT, 348,  -1,  0}, // 920
{"Elf-wafer"                        , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DT, 348,  -1,  0}, // 921 %%: we assume they are magic as they are supposed to be "theft-proof" (although that isn't implemented)
{"Bridge troll"                     , 0, 0,  0,  0,  0,   0  ,    0,   0,  0, FALSE, SLAVE        , MODULE_DT, 355,  -1,  0}, // 922
{"Crow's leg deluxe wand"           , 0, 0,  0,  0,  0,600000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_DT, 288, 324,  0}, // 923
{"Magic sword"                      , 1, 5,  4,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_SWORD , MODULE_EL,   5,  -1,  0}, // 924
{"Token #1"                         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_EL, 111,  -1,  0}, // 925
{"Token #2"                         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_EL,  51,  -1,  0}, // 926
{"Token #3"                         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_EL,   5,  -1,  0}, // 927
{"Token #4"                         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_EL,  24,  -1,  0}, // 928
{"Token #5"                         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_EL,  78,  -1,  0}, // 929
{"Token #6"                         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_EL, 118,  -1,  0}, // 930
{"Token #7"                         , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, FALSE, NONWEAPON    , MODULE_EL,  39,  -1,  0}, // 931
{"Magic dagger"                     , 1, 2,  2,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_DAGGER, MODULE_EL,  38,  -1,  0}, // 932
{"Flaming dagger"                   , 1, 4,  8,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_DAGGER, MODULE_EL,  45,  -1,  0}, // 933
{"Magic dagger"                     , 1, 2,  5,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_DAGGER, MODULE_EL,  60,  -1,  0}, // 934 %%: it doesn't give stats for this, so we gave it 2+5 like a sax
{"Golden cord (4')"                 , 1, 4,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , WEAPON_OTHER , MODULE_EL,  62,  -1,  0}, // 935
{"Demregh-mno"                      , 0, 0,  0,  0,  0,  5000,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_EL,  67,  -1,  0}, // 936
{"Magical leather armour"           , 0, 0,  0,  2,  0,   0  ,  200,   0, 17, TRUE , ARMOUR       , MODULE_EL,  89,  -1,  0}, // 937
{"Magical tower shield"             , 1, 0,  0,  6,  0,   0  ,  550,   0, 10, TRUE , SHIELD       , MODULE_EL,  89,  -1,  0}, // 938
{"Demon Death dirk"                 , 1, 2,  1,  1,  4,  1800,   16,  10,  0, TRUE , WEAPON_DAGGER, MODULE_EL, 106,  -1,  0}, // 939
{"Silver ring set with emerald"     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_EL, 108,  -1,  0}, // 940
{"Healthy youth"                    , 0, 0,  0,  0, 15,   0  ,    0,   0,  0, FALSE, SLAVE        , MODULE_EL, 109,  -1,  0}, // 941
{"Gold-coloured toga"               , 0, 0,  0,  0,  0,   0  ,   UK,   0,  3, TRUE , ARMOUR       , MODULE_EL, 111,  -1,  0}, // 942 %%: can this be worn in conjunction with other armour? We assume not.
{"Electraglide sandals"             , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_EL, 111,  -1,  0}, // 943 %%: we don't have a "foot armour" category
{"Slender silver cord"              , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_EL, 114,  -1,  0}, // 944
{"Orcish stone"                     , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , JEWEL        , MODULE_EL, 136,  -1,  0}, // 945
{"Cat's Eye ring"                   , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_EL, 241,  -1,  0}, // 946
{"Ring of water breathing"          , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , RING         , MODULE_EL, 248,  -1,  0}, // 947
{"Goblin headband"                  , 0, 0,  0,  0,  0,   0  ,   UK,   0,  0, TRUE , NONWEAPON    , MODULE_EL, 252,  -1,  0}, // 948
{"Black bow chased with gold"       , 2, 4,  3, 15, 15,   0  ,   60, 140,  0, TRUE , WEAPON_BOW   , MODULE_EL, 252,  -1,  0}, // 949 %%: we have based this on a medium longbow
{"Goblin trident"                   , 1, 2,  0,  1,  1,   0  ,   UK,   0,  0, FALSE, WEAPON_SPEAR , MODULE_GL,  53,  -1,  0}, // 950
}; // % means it has a weapon illustration
