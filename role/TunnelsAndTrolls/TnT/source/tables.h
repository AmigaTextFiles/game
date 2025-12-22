EXPORT struct AbilityStruct ability[ABILITIES] = {
{"See in the dark",                  MODULE_RB,   -1}, //   0 (CT7/ND3/WW38)
{"Immune to poison",                 MODULE_RB,   -1}, //   1 (ND17/SS209/DT96/EL98)
{"Bitten by vampire",                MODULE_CT,    3}, //   2
{"Soul is in bird",                  MODULE_CT,   35}, //   3
{"Prehensile tail",                  MODULE_CT,    7}, //   4 (CT7/NS36)
{"Bat auditory system",              MODULE_CT,    7}, //   5
{"Dog olfactory nerves",             MODULE_CT,    7}, //   6
{"Gills",                            MODULE_CT,    7}, //   7 - maybe merge with ability 101 (DD146)
{"Giant spider body",                MODULE_CT,    7}, //   8
{"Lobster claw",                     MODULE_CT,    7}, //   9
{"Ape brain",                        MODULE_CT,    7}, //  10
{"Tentacles",                        MODULE_CT,    7}, //  11
{"Bird claws",                       MODULE_CT,    7}, //  12
{"Wings",                            MODULE_CT,    7}, //  13
{"Broken hands",                     MODULE_CT,   16}, //  14
{"Blind and sunburnt",               MODULE_DE,   71}, //  15
{"Man-tiger",                        MODULE_DE,  151}, //  16
{"Poisoned by arrow",                MODULE_ND,   10}, //  17
{"Lost left hand",                   MODULE_RB,   -1}, //  18 (CT160/WW153)
{"Trained archer",                   MODULE_CT,   20}, //  19
{"Gremlin hand",                     MODULE_CT,   37}, //  20
{"Bitten by gargoyle",               MODULE_CD,   35}, //  21
{"Immune to mind spells",            MODULE_CD,   81}, //  22
{"Manacled",                         MODULE_CD,  105}, //  23
{"Metal skin",                       MODULE_BS,  157}, //  24
{"Reincarnatable",                   MODULE_DE,  171}, //  25
{"Yes/no power",                     MODULE_DE,   45}, //  26
{"Diamond hand",                     MODULE_DE,   87}, //  27
{"Stung by scorpion",                MODULE_CT,   38}, //  28
{"Ogre chieftain",                   MODULE_CT,  119}, //  29
{"Steward of Time",                  MODULE_CT,  166}, //  30
{"Branded forehead",                 MODULE_CT,  225}, //  31
{"Permanently invisible",            MODULE_SS,   -1}, //  32 (SS MET)
{"Eyes in back (and front) of head", MODULE_SS,   -1}, //  33 (SS18/35)
{"Permanent smile",                  MODULE_SS,   99}, //  34
{"Eyes in back (only) of head",      MODULE_SS,  193}, //  35
{"Summoning ability",                MODULE_SS,  209}, //  36
{"Tin statue",                       MODULE_DE,  149}, //  37
{"Missing a shoe",                   MODULE_SS,  216}, //  38
{"Lost left eye",                    MODULE_AK,   70}, //  39 (and HH30)
{"Lost right eye",                   MODULE_AK,   70}, //  40
{"Lost an arm",                      MODULE_AK,  123}, //  41 (and AK110)
{"Unicorn butcherer",                MODULE_AK,  145}, //  42
{"Boon of immortality",              MODULE_AK,  170}, //  43
{"Scurvy",                           MODULE_AS,   -1}, //  44 (ASp87)
{"Immune to scurvy",                 MODULE_AS,   -1}, //  45 (ASp85)
{"Poisoned by creature",             MODULE_AS,   21}, //  46
{"Big feet",                         MODULE_AS,  170}, //  47
{"Permanent layer of blood",         MODULE_AS,   40}, //  48
{"Half dead",                        MODULE_AS,   72}, //  49
{"Infected by zombies",              MODULE_AS,  101}, //  50
{"Rabies",                           MODULE_AS,  126}, //  51 (and ASp83)
{"Poisoned by clay",                 MODULE_AS,  142}, //  52
{"Malaria",                          MODULE_AS,  197}, //  53
{"Poisoned by needle",               MODULE_AS,   87}, //  54
{"Green and bald",                   MODULE_SH,   62}, //  55
{"Bitten by skunk mites",            MODULE_SH,  100}, //  56
{"Glowing red eyes",                 MODULE_BF,   78}, //  57
{"Reek of fermented mushrooms",      MODULE_BF,   81}, //  58
{"Tattooed by Gina",                 MODULE_BF,   87}, //  59
{"Elephant foot curse",              MODULE_BF,  166}, //  60
{"Invisible from the neck down",     MODULE_BF,  138}, //  61
{"Hundred warts on face",            MODULE_GK,   58}, //  62
{"Sprayed with skunk oil",           MODULE_GK,   86}, //  63
{"White-haired madman",              MODULE_MW,   43}, //  64
{"Magical left eye",                 MODULE_WW,   38}, //  65
{"Drunk",                            MODULE_WW,   39}, //  66 - different to ability 91 (LA0)
{"Covered in excrement",             MODULE_WW,  113}, //  67
{"Regeneration",                     MODULE_WW,  132}, //  68 - different to abilities 99 (DD128) and 136 (HH52)
{"Resurrectable",                    MODULE_WW,  138}, //  69
{"Lost right hand",                  MODULE_WW,  153}, //  70
{"Lost finger",                      MODULE_AB,   39}, //  71
{"Sense evil undead/demons",         MODULE_AB,   51}, //  72
{"Rodent shapeshifter",              MODULE_SO,  152}, //  73
{"Captain of Count Karken's guard",  MODULE_SO,  184}, //  74
{"Staph",                            MODULE_SO, 2000}, //  75 (SO Disease Chart)
{"Pneumonia",                        MODULE_SO, 2001}, //  76 (SO Disease Chart)
{"Cholera",                          MODULE_SO, 2002}, //  77 (SO Disease Chart)
{"Dysentry",                         MODULE_SO, 2003}, //  78 (SO Disease Chart)
{"Hepatitis",                        MODULE_SO, 2004}, //  79 (SO Disease Chart)
{"Polio",                            MODULE_SO, 2005}, //  80 (SO Disease Chart)
{"Bubonic plague",                   MODULE_SO, 2006}, //  81 (SO Disease Chart)
{"Malaria",                          MODULE_SO, 2007}, //  82 (SO Disease Chart) - different to ability 53 (AS197)
{"Yellow fever",                     MODULE_SO, 2008}, //  83 (SO Disease Chart)
{"Rabies",                           MODULE_SO, 2009}, //  84 (SO Disease Chart) - different to ability 51 (AS126/ASp83)
{"Osteomyelitis",                    MODULE_SO, 2010}, //  85 (SO Disease Chart)
{"Cursed by mummy",                  MODULE_SO,  147}, //  86
{"Fractured shoulder",               MODULE_SO,   35}, //  87
{"Virgin"                          , MODULE_LA,   -1}, //  88 (LA WMT)
{"Gift of prophecy"                , MODULE_LA,   -1}, //  89 (LA WMT)
{"Ring mail skin"                  , MODULE_LA,  158}, //  90
{"Drunk"                           , MODULE_LA,    0}, //  91 - different to ability 66 (WW39)
{"Stinking"                        , MODULE_DD,   16}, //  92
{"Resistant to fire"               , MODULE_DD,    7}, //  93
{"Partially blind"                 , MODULE_DD,   36}, //  94 - different to ability 160 (DT85)
{"Completely blind"                , MODULE_DD,   36}, //  95
{"Electrical"                      , MODULE_DD,   79}, //  96
{"Immune to fire"                  , MODULE_DD,  112}, //  97 - different to ability 114 (RC23)
{"Water control"                   , MODULE_DD,  118}, //  98
{"Regeneration"                    , MODULE_DD,  128}, //  99 - different to abilities 68 (WW132) and 136 (HH52)
{"Stony skin"                      , MODULE_DD,  140}, // 100
{"Gillfish"                        , MODULE_DD,  146}, // 101 - maybe merge with ability 7 (CT7)
{"Always aware of ambushes"        , MODULE_DD,  149}, // 102
{"Chameleon ability"               , MODULE_DD,   84}, // 103
{"Gorgon ability"                  , MODULE_DD,   84}, // 104
{"Troll psionics"                  , MODULE_DD,   84}, // 105
{"Limb regeneration"               , MODULE_DD,   84}, // 106
{"Magical hands"                   , MODULE_DD,   84}, // 107
{"Sub-General"                     , MODULE_OK,   34}, // 108
{"Major"                           , MODULE_OK,   48}, // 109
{"Sub-Captain"                     , MODULE_OK,   71}, // 110
{"Hawk-Colonel"                    , MODULE_OK,   83}, // 111
{"General"                         , MODULE_OK,    9}, // 112
{"Reincarnatable"                  , MODULE_SM,  156}, // 113 (and SM146/58) - different to ability 25 (DE171)
{"Immune to fire"                  , MODULE_RC,   23}, // 114 - different to ability 97 (DD112)
{"Hiding ability"                  , MODULE_RC,   53}, // 115
{"Flame breath"                    , MODULE_RC,   54}, // 116
{"Tiger paw on chest"              , MODULE_RC,  114}, // 117
{"Tiger telepathy"                 , MODULE_RC,  176}, // 118
{"Locating ability"                , MODULE_RC,  177}, // 119
{"Hibernation ability"             , MODULE_RC,  207}, // 120
{"Avoidance ability"               , MODULE_RC,  208}, // 121
{"Knighthood"                      , MODULE_RC,  209}, // 122 (and DT349)
{"Stony bones"                     , MODULE_CA,  302}, // 123
{"Polio in brain"                  , MODULE_SO, 2005}, // 124 (SO Disease Chart)
{"Leech(es)"                       , MODULE_SO,   -1}, //*125 (SO WMT)
{"Fortune smile(s)"                , MODULE_HH,   36}, //*126
{"Burning pain"                    , MODULE_HH,   37}, // 127
{"Masochist"                       , MODULE_HH,   41}, // 128
{"Teleportation power"             , MODULE_HH,   52}, // 129
{"Magic resistance"                , MODULE_HH,   52}, // 130
{"Polymorph self ability"          , MODULE_HH,   52}, // 131
{"Polymorph others to frogs"       , MODULE_HH,   52}, // 132
{"Remove curse/spell ability"      , MODULE_HH,   52}, // 133
{"Walk on any solid surface"       , MODULE_HH,   52}, // 134
{"Flying ability"                  , MODULE_HH,   52}, // 135
{"Regeneration"                    , MODULE_HH,   52}, // 136 - different to abilities 68 (WW132) and 99 (DD128)
{"Incorporeality"                  , MODULE_HH,   52}, // 137
{"Word of Command for dragons"     , MODULE_HH,   52}, // 138
{"Polio in leg"                    , MODULE_SO, 2005}, // 139 (SO Disease Chart)
{"Polio in arm"                    , MODULE_SO, 2005}, // 140 (SO Disease Chart)
{"Polio in chest"                  , MODULE_SO, 2005}, // 141 (SO Disease Chart)
{"Yellow skin and blue hair"       , MODULE_IC,   16}, // 142
{"Short-range teleport"            , MODULE_IC,   16}, // 143
{"Non-prehensile tail"             , MODULE_WC,  225}, // 144
{"Hairy body"                      , MODULE_WC,  229}, // 145
{"Glowing body"                    , MODULE_WC,  229}, // 146
{"Cat person"                      , MODULE_NS,   17}, // 147
{"Fangs"                           , MODULE_NS,   36}, // 148
{"Scaly skin"                      , MODULE_NS,   43}, // 149
{"Cold Touch"                      , MODULE_NS,   46}, // 150
{"Love curse"                      , MODULE_NS,   85}, // 151
{"Green hair/teeth/nails"          , MODULE_NS,  175}, // 152
{"Begrimed"                        , MODULE_DT,   15}, // 153
{"Krestok quest (guilty)"          , MODULE_DT,   40}, // 154 different to 155
{"Krestok quest (innocent)"        , MODULE_DT,   48}, // 155 different to 154
{"Curse of all attributes"         , MODULE_DT,  237}, // 156
{"Captain of the Gheton Company"   , MODULE_DT,  388}, // 157
{"General of the Grey Stalkers"    , MODULE_DT,  394}, // 158
{"Captain of the Grey Stalkers"    , MODULE_DT,  404}, // 159
{"Damaged vision"                  , MODULE_DT,   85}, // 160 - different to ability 94 (DD36)
{"Curse of Luck"                   , MODULE_DT,  277}, // 161
{"Curse of Strength"               , MODULE_DT,  277}, // 162
{"Inverted body parts"             , MODULE_DT,  336}, // 163
{"Witch-mark"                      , MODULE_DT,  338}, // 164
{"Member of the Rangers"           , MODULE_SO,  113}, // 165
{"Addicted to Demregh-mno"         , MODULE_EL,   67}, // 166
{"Knight of Valour"                , MODULE_EL,  242}, // 167
{"Knight of the Kraken"            , MODULE_EL,   99}, // 168
{"Wreathed in fire"                , MODULE_EL,  135}, // 169
}; // * are numeric, the rest are flags

MODULE const int heighttable[16] =
{  48, // 4'
   51, // 4' 3"
   53, // 4' 5"
   56, // 4' 8"
   58, // 4' 10"
   61, // 5' 1"
   63, // 5' 3"
   66, // 5' 6"
   68, // 5' 8"
   71, // 5' 11"
   73, // 6' 1"
   76, // 6' 4"
   78, // 6' 6"
   81, // 6' 9"
   83, // 6' 11"
   86, // 7' 2"
}, weighttable[16] =
{  750,
   900,
  1050,
  1200,
  1350,
  1500,
  1600,
  1700,
  1800,
  1900,
  2000,
  2250,
  2500,
  2800,
  3100,
  3500
}, apreq[] =
{        0,
         0, //  1
      1000, //  2
      3000, //  3
      7000, //  4
     15000, //  5
     25000, //  6
     45000, //  7
     70000, //  8
    100000, //  9
    140000, // 10
    200000, // 11
    280000, // 12
    400000, // 13
    550000, // 14
    750000, // 15
   1000000, // 16
   2000000, // 17
   4000000, // 18
   8000000, // 19
  16000000  // 20
};

EXPORT const int ms_weapons[20] =
{  0,
   3,
   5,
   8,
   9,
  16,
  22,
  34,
  40,
 120,
  41,
  60,
  64,
  67,
  70,
  75,
  83,
 111,
  93,
 112 // really should be 24 arrows, not 1 arrow
};

MODULE const STRPTR rb_weapondesc[RB_WEAPONDESCS] = {
/*   0 Adze                   */ "Essentially a carpenter's tool shaped like an axe but with the blade at right angles to the handle.",
/*   1 African throwing knife */ "A multi-branched, incredibly nasty-looking weapon meant to be thrown horizontally, not overhand like an axe. Any of several sharpened blades may strike which accounts for its power.",
/*   2 Ankus                  */ "Basically an elephant goad. Usually has a sharpened point with a recurved side hook. Some had short hafts (used when riding elephants) but longer ones could be used while walking beside the animal.",
/*   3 Arbalest               */ "Some of the larger crossbows had a stirrup at the fore to place the foot to obtain leverage in cocking the bow. A lever arrangement (belt or claw, or cord and pulley) could be used to aid in drawing back the cord. See Crossbow.",
/*   4 Arming doublet         */ "Padded leather vest-sized garment. Sometimes worn under heavy armour to cushion blows. (In complete sets of armour as noted, this is already assumed.)",
/*   5 Assegai                */ "Spear with a leaf-shaped head on a fairly light wooden staff. The shaft may be reinforced with iron to strengthen it, but it loses flight capabilities in this case and should not be thrown.",
/*   6 Atl-atl                */ "The name is Mexican but many spear-wielding cultures used them. The common form is a straight flat stick with cord loops at the handle end, and a notch upong which to rest the butt of the spear. Acts by effectively extending the thrower's arm length to impart greater force.",
/*   7 Double-bladed axe      */ "Two huge crescent-shaped blades faced away from each other on a relatively short thick haft.",
/*   8 Great axe              */ "Large heavy axe with a less curved blade, balanced with a small knob on the opposite side. Longer haft.",
/*   9 Broadaxe               */ "Single smaller crescent blade, middle-length haft.",
/*  10 Taper axe              */ "Narrow, one-edged curved blade.",
/*  11 Back & breast          */ "Metal cuirass which covers torso from upper shoulders to hips, fastened with side and shoulder straps.",
/*  12 Bagh nakh              */ "Name means \"tiger claws\". Four or five curved iron spikes affixed to crossbar; held in hand, the spikes extend in front of fist. Holes or rings at the end of the crossbar allow a good grip. Easily concealed in palm, was a favourite assassination weapon.",
/*  13 Bank                   */ "Dagger with strongly curved, sickle-shaped blade and straight handle.",
/*  14 Baton                  */ "Light truncheon like a policeman's billyclub.",
/*  15 Bec de corbin          */ "A type of war hammer on a mid-length haft. The name means \"crow's beak\" and refers to the primary piercing head. This is balanced behind with a small clawed hammer; many also had a short stabbing point at the top in line with the haft.",
/*  16 Bhuj                   */ "A shorter heavy single-edged knife blade mounted in line with a straight handle; about 20\" long.",
/*  17 Bich'wa                */ "Doubly curved, double-edged blade with a loop hilt. Shape dereived from the curve of the (flying) buffalo horns from which they were originally made; name, however, refers to a scorpion's sting which it also resembles. [Were sometimes built to include bagh nakh (in gameplay if this is used, pay for both separately)].",
/*  18 Billhook               */ "Originally an agricultural implement, but was modified easily to a weapon. A broad blade with a single cutting edge and a variety of spikes and hooks projecting from the back and end, all mounted on a long shaft. This is the original weapon from which guisarmes and fauchards were derived.",
/*  19 Blowpipe               */ "A long tube of wood, reed, or cane through which darts are propelled by the breath of the user. Because darts are light and are not propelled with much force, it is common to poison them in order to make them effective.",
/*  20 Bludgeon               */ "This is your common heavy wooden club. It may be bound with iron to prevent splintering, but is otherwise just your standard bashing weapon.",
/*  21 Hunting bola           */ "A long cord on thong to which either 2 or 3 stones are attached. Whirled around the head and released at victim's legs, will entangle the limbs and disable small prey.",
/*  22 War bola               */ "Thin flexible wire-wrapped cord is used and the stones are replaced with small spiked balls. Besides entangling, the wires may cut and the spikes puncture or slash. User must wear gauntlets of some kind to protect the fingers.",
/*  23 Brandestock            */ "A long hafted weapon with a small axehead on one side and short spike on the other. Has a long sword blade concealed in the handle which may be readily extended.",
/*  24 Two-handed broadsword  */ "A long straight wide blade which may be single- or double-edged. May or may not have an elaborate hilt. Hilt accommodates both hands.",
/*  25 Hand-and-a-half sword  */ "A long straight wide blade which may be single- or double-edged. May or may not have an elaborate hilt. Hilt accommodates one hand and a partial grip to aid in directing the blows.",
/*  26 One-handed broadsword  */ "A long straight wide blade which may be single- or double-edged. May or may not have an elaborate hilt. Common broadsword.",
/*  27 Buckler                */ "Small round shield used to deflect rather than catch opponent's blade. Usually held in centre back, at arm's length.",
/*  28 Bullova                */ "A long-handled axe with a wide variety of single-bladed heads available. As a game standard, axe-heads should be considered slightly curved, about 10\" long.",
/*  29 Caltrops               */ "Four spikes radiating from a common point so that in any position one spike stands upright. Small ones have spikes about 4\" high; large ones are assumed to be about 8\"-10\" (for very large-footed monsters). War jacks...",
/*  30 Chakram                */ "The original war frisbee. A flat steel inch-wide ring 5\"-12\" in diameter which could be thrown like a frisbee or whirled around the finger before release. The outer edge is sharpened.",
/*  31 Chauves souris         */ "Polearm with a long broad triangular blade, with 2 similar but shorter blades projecting at 45° from the base.",
/*  32 Cranequin              */ "Rack & pinion cocking mechanism on powerful arbalest. See Crossbow.",
/*  33 Crossbow               */ "The most common heavy bow, mounted on a stock with a groove on top for the arrow and a mechanical arrangement for holding and releasing the string. Much more punch than a longbow, but the shorter heavier arrows (called quarrels) somewhat lessened the range.",
/*  34 Common sling           */ "A strip of flexible material (leather is good) with a pocket near the middle. A stone or lead ball is placed in the pocket; one end of the sling is tightly wound around the hand, the other end is held loosely. The sling is whirled and one end released, sending the missile at considerable velocity.",
/*  35 Crowbar                */ "A prying tool which has enough heft to make a fairly effective metal clubbing weapon.",
/*  36 Common spear           */ "A shaft with a simple metal head, sturdy enough for thrusting and light enough for throwing.",
/*  37 Demi-lune              */ "A polearm with a crescent-shaped blade at right angles to the shaft.",
/*  38 Dirk                   */ "Short thick-bladed dagger tapering uniformly from hilt to tip. Usually single-edged.",
/*  39 Dokyu                  */ "The name means \"frequently bow\", derived from the Chinese \"Chu-Ko-Nu\". A repeating crossbow. The bolts are contained in a box sliding on top of the stock, and moved by a lever pivoted to both. Throwing the lever forward and back will draw the bow, place a bolt in position, and discharge the weapon. Magazine holds 5 bolts, fired one at a time.",
/*  40 Epée                   */ "Thin blade used primarily for thrusting, but heavier than a foil and less flexible. Also a fencing weapon, but with a larger hand guard.",
/*  41 Estok                  */ "Sword with a very long narrow blade intended solely for thrusting, having no sharp edges.",
/*  42 Face mask              */ "Largely decorative light metal piece to be attached to helmets which do not protect the face. May be metal mesh or incised/perforated to permit airflow. Sometimes fashioned in demonic likeness.",
/*  43 Falchion               */ "Usually considered a broad curved single-edged blade wide near the point, with the back joining the edge in a concave curve.",
/*  44 Fauchard               */ "Considered to be a polearm with a long single-edged curved blade with ornamental prong(s) on the back.",
/*  45 Heavy flail            */ "Originally an agricultural implement; weights or spikes could be added, or chains substituted for the swinging arm. Compare to Morningstar. Stout haft with swinging arm bound with spiked iron rings.",
/*  46 Light flail            */ "Originally an agricultural implement; weights or spikes could be added, or chains substituted for the swinging arm. Compare to Morningstar. More slender shaft with two or three swinging chains having small weights attached at the end.",
/*  47 Flamberge              */ "A large sword with undulating or waved edges. (From the French word for \"flame\".) Does not refer to the later usage of \"flamberge\" as a special rapier type.",
/*  48 Foil                   */ "Thin flexible swordblade only used as a thrusting weapon. Essentially a fencing weapon, it has a very small guard.",
/*  49 Francisca              */ "Small battle axe used throughout northern Europe. (Named by the Romans for its common use by the Franks.) Balanced for throwing.",
/*  50 Gauntlets              */ "Leather gloves covered with thin articulating metal plates. May also be obtained as leather covered with mail or scales, or simply with heavy leather backs. (For game purposes, if gauntlets are bought as separate pieces, assume the first definition. The other types presumably come with full sets of appropriate armour.)",
/*  51 Grand shamsheer        */ "Curve-bladed cutting sword not suitable for thrusting but excellent for the draw cut. Use this in game terms to classify any very long single-edged, narrow-bladed curved sword. Heavy curved sword traditionally 25% longer than the ordinary sword blade. Often had to be carried over the shoulder.",
/*  52 Great shamsheer        */ "Like the grand shamsheer but somewhat shorter. Use this in game terms to classify any rather long single-edged narrow-bladed curved sword.",
/*  53 Great sword            */ "A very long, heavy, straight wide blade, double-edged. Can be used for cutting or thrusting, although its primary use was for cutting due to the weight and momentum of the blade. This same momentum makes it hard to change the direction of a blow once begun. Use this basic definition to classify any very long, heavy, double-edged blade.",
/*  54 Greaves                */ "Armour for the leg below the knee. For game purposes, assume a solid piece of metal covering the front and sides of the leg only, with straps for attachment in the back of the leg.",
/*  55 Greek helmet           */ "Protects crown and back of head, back of neck, and may curve somewhat forward to protect cheeks and usually includes noseguard.",
/*  56 Guisarme               */ "Name applied to a variety of pole weapons. Used here to refer to a slender incurved swordblade from the back edge of which a sharp hook issues. This elongated hook runs parallel to the back of the blade, or diverges at a slight angle.",
/*  57 Haladie                */ "Double dagger with 2 short curved or straight daggers fastened to opposite ends of a straight handle.",
/*  58 Halbard                */ "Polearm with long shaft topped by axe blade with a beak or point on the opposite side. Usually surmounted with a long spike of blade.",
/*  59 Heavy mace             */ "Club-like weapon all of metal or with a metal head. Heads were knob-like or with several blunt flanges or spikes.",
/*  60 Helm                   */ "Complete head, face, and neck protection. Face covering may be hinged to swing back or to the side, or it may be a solid piece.",
/*  61 Hoko                   */ "Spear with a long, rather wide straight point, with a secondary blade set at right angles to the first.",
/*  62 Jambiya                */ "Blade is curved and double-edged. Some were so curved that the end pointed upward; if chosen in this form, should not be thrown. Blade may be rather wide or fairly narrow.",
/*  63 Javelin                */ "A light throwing spear with a simple head. Balanced to be thrown with considerable accuracy.",
/*  64 Katar                  */ "Also called a punch dagger, as it was effectively used toburst mail links in armour. Blade rather broad at base, tapering evenly to the point. The pecularity of this dagger lies in its hilt, which is shaped like an H with 2 flat side bars and a single or double crossbar. It is held in the clenched fist to be thrust forward, the blade leading the knuckles. For game purposes, the blade is assumed to be double-edged and between 9\"-12\" long.",
/*  65 Knight's shield        */ "Large square-ish shield with triangular base. Carried on arm. Sometimes slightly convex.",
/*  66 Kris                   */ "This dagger comes in many traditional shapes; the common concept is a blade of several undulations. For game purposes, it has been theorized that the blades are forged with a significant portion of meteoric iron in combination with special secret spells which dampen low-level magic.[ This effect is two-edged, however, and a kris-bearer cannot cast magic. GMs may also insist that no low-level magic can be cast by anyone standing next to a kris-bearer.]",
/*  67 Kukri                  */ "A heavy curved single-edged blade sharp on the concave side.",
/*  68 Kumade                 */ "A pole weapon on a heavy shaft. Head is a grappling hook with 2 or 3 prongs, and a spike or pick facing the opposite direction.",
/*  69 Lamellar armour        */ "Strips of metal tied (not stapled) to leather base, decreasing weight without sacrificing protection. (Best examples are Japanese samurai armour.) Metal cap with lamellar neck guard included. Often a lacquered leather surcoat was worn to waterproof the lamellar underneath.",
/*  70 Leather armour         */ "Complete suit of thick leather which protects all of body except face and feet. A reinforced leather head-covering and leather gauntlets are considered included. Leather strips articulate over joints and moving parts.",
/*  71 Leather jerkin         */ "Unpadded leather tunic covering chest, and extending to hips. Heavier and thicker than ordinary jerkin, but less so than arming doublet.",
/*  72 Longbow                */ "A self bow made as long as the user of the best materials available, preferably yew or hazel. Ash, ironwood and osage make suitable substitutes. Historically called a \"long\" bow to differentiate it from the shorter arbalest/crossbow.",
/*  73 Madu                   */ "Small (7\") round shield with two long antelope horns extending 14\" to front and back of shield. Horns reinforced with steel tips.",
/*  74 Mail armour            */ "Joined rings or chains in often complex interlinking patterns. To be effective it had to be heavy with multiple links per ring, but afforded better mobility and ventilation than the more solid plate. An arming doublet or its equivalent is assumed beneath the ring to cushion blows and prevent chafing. A mail coif is assumed beneath an open-faced helmet.",
/*  75 Main gauche            */ "The left-handed dagger used to guard and parry while using a sword in the right hand. Blade usually straight and double-edged with a short grip but elaborate hand-guard.",
/*  76 Manople                */ "A short sword affixed to a hand and wrist gauntlet. Blade is about 30\" long, with two 10\" blades to either side.",
/*  77 Misericorde            */ "A long narrow-bladed dagger intended for thrusting.",
/*  78 Mitre                  */ "Hafted weapon with enlarged head studded with spikes. Usually lighter and less club-like than a heavy mace.",
/*  79 Morningstar            */ "Short-hafted weapon with heavy iron chain connecting the haft and an iron ball studded with spikes.",
/*  80 Oxtongue               */ "Long shafted spear with broad, straight, double-edged blade. Suitable for use as a horse-lance.",
/*  81 Partizan               */ "A broad-bladed polearm which usually has short curved sidebranches at the base of the blade. Often highly ornamental.",
/*  82 Pata                   */ "A katar evolved into a sword with an attached gauntlet. Blade is straight, long and double-edged. Rather awkward in melee because the gauntlet deprives one of the use of the wrist (as is the case with the manople also). [GMs may feel inclined to penalize players using this weapon if they are engaged in infighting.]",
/*  83 Pick axe               */ "A pick axe. (What did you expect?) [Human-sized characters may chop through stone at 5'/turn, and dwarves may go through at 10'/turn. This will open the wall in a small space (at GM's discretion) but additional work would be required to clear an open passageway.]",
/*  84 Pike                   */ "Plain spear-head on a very long shaft.",
/*  85 Pilum                  */ "Historically, the Roman legionnaire's spear. A long neck between spearhead and shaft attachment.",
/*  86 Piton hammer           */ "Small hammer used especially to pound in spikes used by mountain climbers (\"pitons\").",
/*  87 Plate armour           */ "Classical knight's armour. Many large solid pieces which overlap but rarely articulate except at joints. Includes full helm, light ring shirt underneath as well as padding similar to arming doublet. May or may not include sollerets (articulating metal shoes).",
/*  88 Poleaxe                */ "A long-shafted polearm with an axe-blade on one side, and a spike or hammer opposite, but no spike at the top.",
/*  89 Poniard                */ "A small straight dagger without sharp edges; used primarily for thrusting or throwing.",
/*  90 Prodd                  */ "A light crossbow of ordinary construction except the string has been made double with a pouch to accommodate stone, lead or clay pellets.",
/*  91 Quarrel                */ "The arrows, or bolts, used in most of the crossbow-class bows. The quarrels were very much shorter and far stockier, often with minimal fletching if any. The power of the crossbow gives a quarrel considerable impact, but the bolts are less aerodynamic than an ordinary arrow, shortening the effective range with a good aim.",
/*  92 Quilted silk/cotton    */ "As used in T&T, refers to a complete set of cloth body armour covering everything but face and feet. Padded cloth covers neck and is attached to steel cap for head protection; cuffs and lower legs may have light metal strips for protection. Quilting held by small metal studs.",
/*  93 Quarterstaff           */ "Long stout staff of heavy wood. Could be used as a staff when walking (or here, to throw magic if enchanted) and as a club for infighting.",
/*  94 Ranseur                */ "A polearm with a long sharp narrow blade with two short lateral blades at the base. Compare to Chauvres souris.",
/*  95 Rapier                 */ "Long (sometimes very long) stiff blade which was used primarily for thrusting. Some had double-edged blades for slashing as well as thrusting. Most had elaborate guards.",
/*  96 Ring-jointed plate     */ "As the name indicates, rather large strips and squares of plate held together by rings to permit freedom of movement. Included a cap with mail neck and cheek protection. Plates cover areas with minor movement - upper chest, back, upper arm and leg, shins and forearms. The rest is mail. The plate is usually thinner and of poorer quality than standard plate.",
/*  97 Normal sabre           */ "A sword with a slight curve, single-edged. Intended for cutting; can be used for thrusting. As used in the context of the game, refers to a small cavalry sabre.",
/*  98 Short sabre            */ "A sword with a slight curve, single-edged. Intended for cutting; can be used for thrusting. Shorter than a normal sabre.",
/*  99 Sax                    */ "Also called \"scramasax\". A very large broad single-edged dagger almost big enough to be considered a short sword. A Bowie Knife (the original design) would be contemporary near-equivalent, allowing for differences in quality of forging.",
/* 100 Scale armour           */ "Scales or flattened rings stapled onto a leather base. Included steel cap with articulating scales protecting neck.",
/* 101 Scimitar               */ "A strongly curved sabre-like blade, single-edged.",
/* 102 Self-bow               */ "Any bow held upright, pulled and released by hand. As such, also refers to the longbow. However, to differentiate between the visible differences and quality, we have divided the bows into the two classes.",
/* 103 Short sword            */ "Here refers to any relatively short, broad-bladed, straight double-edged sword. In game use, use this to classify any similar sword.",
/* 104 Shotel                 */ "A very long double-edged blade curved almost to a half-circle. Extremely awkward, it can be used to strike over or around a shield.",
/* 105 Shuriken               */ "In contemporary usage, refers to the throwing stars used in the Orient, specifically Japan. Some were very small, the size of a ten pence piece (UK) or half-dollar (USA), to about 6\" across. To maintain flight abilities, star points could not be longer. An excellent nuisance weapon, especially if poisoned, but insufficient power to do great damage.",
/* 106 Scythe                 */ "A sickle-shaped blade mounted in line on a long relatively slender pole.",
/* 107 Sickle                 */ "Originally an agricultural weapon, the blade is set long on the shaft as with a scythe, instead of at right angles.",
/* 108 Spontoon               */ "A fairly elaborate spear head on a stout 8' long staff. Some look like small partizans.",
/* 109 Staff sling            */ "An ordinary sling mounted on a pole to increase the momentum of the stone.",
/* 110 Steel cap              */ "Simple metal hat which protects crown and back of head. Does not protect back of neck, but may include a noseguard.",
/* 111 Stiletto               */ "A very small dagger intended primarily for thrusting. Can be thrown effectively.",
/* 112 Swordbreaker           */ "A weapon with a short heavy blade with many teeth on the back to catch the opponent's blade and snap it.",
/* 113 Sword cane             */ "A 2'-3' long cane or crutch which holds a 1½'-2½' thin swordblade concealed within.",
/* 114 Target shield          */ "Medium-sized circular shield. Usually has 2 rather wide-set loops through which the arm is passed.",
/* 115 Terbutje               */ "A wooden weapon with shark's teeth lashed to both sides to create a ripping slicing edge. Useless for thrusting.",
/* 116 Tower shield           */ "Very large convex rectangular shield.",
/* 117 Trident                */ "A spear with three parallel (or nearly parallel) prongs.",
/* 118 Viking spike shield    */ "Round target shield with a 6\" spike affixed to the centre.",
/* 119 Voulge                 */ "A polearm with a broad axe-like head elongated to a spike at the top.",
/* 120 War hammer             */ "Traditionally, a sturdy hafted weapon with a relatively small blunt or clawed head, with a small spike in the back. (Does not refer to something like Thor's hammer from Marvel comics.)",
/* 121 Zaghnal                */ "An axe-like weapon with a broad heavy knife-like blade.",
/* 122 provisions             */ "(food, drink, matches)",
/* 123 delver's package       */ "(small bronze mirror, a few sticks of wax, some chalk, salt, short length of twine, and more matches)",
/* 124 curare                 */ "Doubles effectiveness of any *edged* weapon[ before personal adds are computed].",
/* 125 spider venom           */ "[Temporarily paralyses victims. After 1 combat turn (2 minutes) a poisoned creature should be at half effectiveness. After 2 combat turns, victims are unable to move. After 5 combat turns the poison wears off. ]Spider venom is [generally ]not powerful enough[ to affect monsters much larger than humans (such as trolls and dragons)].",
/* 126 dragon's venom         */ "Quadruples effectiveness on *edged* weapons[ before personal adds].",
/* 127 hellfire juice         */ "Adds half again to the weapon's effectiveness. Can be used on edged weapons or blunt weapons equally.",
/* 128 hand cannon            */ "Most primitive gun, a barrel on a stock without a lock.",
/* 129 matchlock pistol       */ "A gun operated with a burning match cord held by a serpentine. A small gun, capable of being held and fired in one hand, shorter than a musket or rifle, using less powder and generally doing less damage.",
/* 130 matchlock musket       */ "A gun operated with a burning match cord held by a serpentine. Early, heavy matchlock requiring a fork; later, a smoothbore infantry flintlock.",
/* 131 wheel lock pistol      */ "A gun operated with a serrated wheel rubbing on pyrites. A small gun, capable of being held and fired in one hand, shorter than a musket or rifle, using less powder and generally doing less damage.",
/* 132 wheel lock musket      */ "A gun operated with a serrated wheel rubbing on pyrites. Early, heavy matchlock requiring a fork; later, a smoothbore infantry flintlock.",
/* 133 snaphaunce pistol      */ "Predecessor of true flintlock with separate steel and pan cover. A small gun, capable of being held and fired in one hand, shorter than a musket or rifle, using less powder and generally doing less damage.",
/* 134 snaphaunce musket      */ "Predecessor of true flintlock with separate steel and pan cover. Early, heavy matchlock requiring a fork; later, a smoothbore infantry flintlock.",
/* 135 flintlock pistol       */ "Gun using flint and steel for the ignition of the powder. A small gun, capable of being held and fired in one hand, shorter than a musket or rifle, using less powder and generally doing less damage.",
/* 136 flintlock musket       */ "Gun using flint and steel for the ignition of the powder. Early, heavy matchlock requiring a fork; later, a smoothbore infantry flintlock.",
/* 137 black powder           */ "Gunpowder made with charcoal, saltpeter, and sulphur.",
/* 138 powder horn            */ "A container for gunpowder.",
/* 139 match                  */ "Twisted vegetable fibres soaked in saltpeter."
}; // These weapons don't have descriptions: arrow, dart, gladius, stone.
// Single percentage signs are fine in this text (they aren't interpreted as format specifiers).

// %%: CD module seems to expect Unlock, Panic, etc. to be able to be cast at a higher level, contrary to RB.
// %%: Arguably there are many more MODULE_MM spells that should be regarded as combat spells.
EXPORT struct SpellStruct spell[SPELLS] = {
// lvl module    corgi name                 fb name                   st range combat flags                   duration abbrev race      desc
{ 0, MODULE_MM, "Bat Wings"              , "Bat Wings"              , 15,   0, FALSE, 0                            ,30, "BG", DEMON  , "Demons can put Bat Wings on any monster or human. These wings last for 3 turns and allow the wearer to fly." },
{ 0, MODULE_MM, "Brimstone Blip"         , "Brimstone Blip"         ,  0,   0, FALSE, 0                            , 0, "BO", GREMLIN, "[A teleport spell, worth 5' in distance for each IQ point the gremlin uses to generate it. Costs no Strength but diminishes IQ of gremlin for the rest of the adventure, as each point used to generate distance is temporarily lost.]" },
{ 0, MODULE_MM, "Darkest Hour"           , "Darkest Hour"           ,  2,   0, FALSE, 0                            ,10, "DH", GOBLIN , "[This spell drains light from any natural source except the sun. Furthermore, the goblin casting the spell will glow with the drained light for one turn after he ceases to cast the spell.]" },
{ 0, MODULE_MM, "Finagle's Demons"       , "Finagle's Demons"       ,  5,   0, FALSE, 0                            , 0, "FD", GREMLIN, "[Causes anything in the vicinity that can go wrong to do so, in favor of the gremlin and his friends. The GM will determine what happens, but players are free to make suggestions. A gremlin may only use this spell once per adventure.]" },
// { 2, MODULE_CK, "Finagle's Demons"    , "Finagle's Demons"       ,  4,   0, TRUE , 0                            , 2, "FD", -1     , "[Confuses the monster for one combat round.]" },
{ 0, MODULE_MM, "Going Batty"            , "Going Batty"            , 10,   0, FALSE, 0                            , 0, "GB", VAMPIRE, "[Lets vampire turn into a gigantic bat, which can fly at normal flying speed but cannot fight. However, the bat can speak and cast its spells. If a vampire is attacked while in bat form, it takes only half the hits that it would otherwise, because it is so hard to hit. The vampire may reverse this spell at will, but may not use it again until the next night.]" },
{ 0, MODULE_MM, "Ha, Ha, Ya Mist Me"     , "Ha, Ha, Ya Mist Me"     ,  5,   0, FALSE, 0                            , 0, "HY", VAMPIRE, "[Turns vampire into a patch of mist, which cannot speak, fight, or be harmed in any way except by sunlight which kills the vampire. It travels at normal walking pace, and is not blown by the wind. This spell may not be used more than once per night, and always lasts for as many turns as the vampire specifies when he casts the spell - no changes either way.]" },
{ 0, MODULE_MM, "Oh Boy, Obey"           , "Oh Boy, Obey"           , 10,   0, FALSE, 0                            , 0, "OB", VAMPIRE, "[Saps the will of any human or other manlike creature whose total IQ, Strength, and Dexterity is less than the vampire's. The vampire may use this spell on only one character per turn, but anyone so enchanted will remain enslaved until the death of the vampire. (A Curses Foiled spell will nullify it, though.) Vampires unlucky or unwise enough to try this spell on characters with higher totals than their own will become the slaves of their intended victims.]" },
{ 0, MODULE_MM, "Ole Stonewall"          , "Ole Stonewall"          ,  0,  50, TRUE , 0                            , 0, "OW", TROLL  , "Creates a stone wall, raised out of the earth or any other available solid, containing 100 times the troll's Strength in cubic feet of granite. This wall will appear anywhere within 50' of the troll, and its creation will halve the troll's Strength permanently." },
{ 0, MODULE_MM, "Reconstr-yuch-tion"     , "Reconstr-yuch-tion"     , 10,   0, FALSE, 0                            , 0, "RH", TROLL  , "Has the same effect as a human Bog and Mire spell." },
{ 0, MODULE_MM, "Rock-a-bye-bye"         , "Rock-a-bye-bye"         , 15,  20, FALSE, 0                            , 0, "RB", TROLL  , "If a character's Strength, Luck, and IQ total less than the troll's, this spell turns them to stone. However, should the troll attempt to use it on a character with higher totals than his own, he himself will turn to stone. This petrification is permanent [in the case of other victims; if the troll is stoned by his own backlash, he will recover at midnight]." },
{ 0, MODULE_MM, "Wise Disguise"          , "Wise Disguise"          , 10,   0, FALSE, 0                            ,30, "X0", OGRE   , "[Lets ogre disguise himself or any other living thing in any human, animal, or monstrous form. The cost is ten Strength points for each individual so disguised. The spell will last as long as the ogre remembers to say, in a voice audible to the spirits (ie. the GM), \"wise disguise\" every three turns. This spell will not fool any character with an IQ higher than that of the ogre.]" },
{ 1, MODULE_MM, "Alarums"                , "Alarums"                ,  4,   0, FALSE, 0                         , 6000, "AU", -1     , "[This is placed across an opening, on an object, or on an areas of 10' radius. If the areas is disturbed or crossed, the caster will be alerted.]" },
{ 1, MODULE_MM, "Clot"                   , "Clot"                   ,  1,  10, FALSE, 0                            , 0, "CL", -1     , "[Stops external bleeding. (This includes blood drain by a monster, requiring the monster to attack again to restart the drain.)]" },
{ 1, MODULE_MM, "Cloud o' Dust"          , "Cloud o' Dust"          ,  4,  30, FALSE, 0                            ,10, "CD", -1     , "[Raises a 10' wide cloud of dust which reduces visibility by half and chokes the breathing of all within (L3-SR on Constitution (30 - CON) or lose half Strength while in the cloud).]" },
{ 1, MODULE_MS, "Detect Magic"           , "Detect Magic"           ,  0,  30, FALSE, 0                            , 0, "DM", -1     , "Inherent power of magic-users, detects good/bad magical vibes." },
{ 1, MODULE_MM, "Detect Miracle"         , "Detect Miracle"         ,  2,  30, FALSE, 0                            , 0, "DI", -1     , "[Detects priestly and divine miracles. Works much like Detect Magic.]" },
{ 1, MODULE_CK, "Double Trouble"         , "Double Trouble"         ,  8,   0, TRUE , 0                            , 2, "D1", -1     , "[Doubles the damage inflicted by bows for one combat round.]" },
{ 1, MODULE_RB, "Hocus Pocus"            , "Hocus Pocus"            ,  1,   0, FALSE, 0                            , 0, "HP", -1     , "Enchants an ordinary piece of wood into a makeshift magic staff. Does not test wood's suitability (must make L1-SR on Luck (20 - LK) [when first used]). No makeshift staff lasts beyond burn-out: it cannot be re-enchanted." },
{ 1, MODULE_MM, "Hotfoot"                , "Hotfoot"                ,  7,  30, FALSE, SPELL_CIRCLE                 , 0, "HO", -1     , "[This causes one target to experience the momentary sensation of having a lit match stuck between the toes. This can affect any number of targets, so long as the combined CHR (or MR) does not exceed the caster's IQ. Higher levels double this limit.]" },
{ 1, MODULE_MS, "Lock Tight"             , "Lock Tight"             ,  1,  10, FALSE, 0                            ,30, "LT", -1     , "Locks and holds any door shut[ for 3 turns unless higher level magic is used to open it]." },
{ 1, MODULE_MM, "No-Feel-ums"            , "No-Feel-ums"            ,  3,   0, FALSE, 0                            , 2, "NF", -1     , "[Renders all others incapable of feeling the thief's activities on their person, such as pocket picking or even poison injecting.]" },
{ 1, MODULE_MS, "Panic"                  , "Oh-Go-Away"             ,  5,  50, TRUE , SPELL_CIRCLE                 , 0, "PA", -1     , "Combines totals of IQ, Luck and Charisma rating of user to drive away monsters/foes with a lower Monster Rating. Must be decided upon before MR is announced. If it fails, the monster chases the magic-user to the exclusion of his or her comrades." }, // Circle because of CD magic matrix.
{ 1, MODULE_MS, "Revelation"             , "Oh There It Is"         ,  4,  10, FALSE, 0                            , 0, "RE", -1     , "Usually detects invisible or concealed doors or things by surrounding them with a purple glow which fades slowly." },
{ 1, MODULE_MM, "Skyhole"                , "Skyhole"                ,  3,   0, FALSE, 0                            ,10, "SL", -1     , "[This will pierce overcast or clouds, creating a hole directly between your position and the sun (or moon, or directly overhead if only starlight is available).]" },
{ 1, MODULE_MM, "Sparkler"               , "Sparkler"               ,  3,  30, FALSE, 0                            ,10, "S1", -1     , "Creates a 3'-wide sphere of glowing motes, which moves about at the caster's direction. It will weakly illuminate a 5' radius. Lasts one turn or until dismissed." },
{ 1, MODULE_MM, "Sticky Foot"            , "Sticky Foot"            ,  3,  30, FALSE, 0                            , 0, "SI", -1     , "[This will glue one target's foot to the ground for a second only (thus if they are not moving, they may never notice). The target's CHR cannot exceed the caster's IQ.]" },
{ 1, MODULE_MS, "Take That You Fiend"    , "Take That You Fiend"    ,  6, 250, TRUE , SPELL_CIRCLE                 , 0, "TF", -1     , "Uses IQ as a weapon against foe, inflicting hits equal to the IQ of the caster. On higher levels, multiply the IQ rating by the level of the spell to get total hits inflicted. It is a singular spell and must be directed against a single foe. It has no effect upon inanimate objects." },
{ 1, MODULE_RB, "Teacher"                , "Teacher"                ,  3,   0, FALSE, 0                            , 0, "TE", -1     , "Used to teach rogues (only) 1 spell of teacher's choice." },
{ 1, MODULE_MS, "Unlock"                 , "Knock Knock"            ,  2,   0, FALSE, SPELL_CIRCLE                 , 0, "KK", -1     , "Opens locked doors (usually)." }, // Circle because of CD15
{ 1, MODULE_MS, "Vorpal Blade"           , "Vorpal Blade"           ,  5,   0, TRUE , SPELL_TRIANGLE               , 2, "VB", -1     , "Doubles basic attack die roll for swords and daggers for one combat turn." },
{ 1, MODULE_MM, "Wedgie"                 , "Wedgie"                 ,  5,  30, FALSE, 0                            , 2, "WE", -1     , "[This forcibly yanks one person's pants or underpants up into their personal regions. This will halve their adds for at least one round.]" },
{ 1, MODULE_MM, "Whisper"                , "Whisper"                ,  5,  10, FALSE, SPELL_CIRCLE                 , 0, "WH", -1     , "[Originally a message spell of limited utility (note the short range), it was eventually used merely for starting brawls. It allows the caster to \"project\" his voice so that it seems to be coming from a point right next to the target's ear. The spoken message cannot be longer than (caster's ST) words. Higher levels double the range.]" },
{ 1, MODULE_MS, "Will-o-the-Wisp"        , "Will-o-wisp"            ,  1, 225, FALSE, SPELL_TRIANGLE               ,10, "WO", -1     , "Lights up finger of staff in lieu of torch, 1 candlepower worth. Cannot be projected onto anything, but can throw up to 225' away. Must be renewed each turn for continuing effect." }, // Triangle for our purposes so it doesn't have to be recast each turn
{ 2, MODULE_MM, "Antsy"                  , "Antsy"                  ,  7,  30, FALSE, 0                            , 0, "AN", -1     , "[This gives any one person the sensation of ants in the pants; it requires a L2-SR on IQ to ignore.]" },
{ 2, MODULE_CK, "Arrow Arrow"            , "Arrow Arrow"            ,  8,   0, TRUE , 0                            , 2, "AR", -1     , "[Doubles the number of attacks that a character can make with a bow during combat.]" },
{ 2, MODULE_MM, "Arse-o-Light"           , "Ass-o-Light"            ,  8,  30, FALSE, 0                            , 2, "AS", -1     , "[This causes one target's posterior to burst into flames. The fire is purely visual effect and can do no actual damage; the pain, however, is real. The whole event is but momentary, but will cause complete preoccupation for at least one round. The target can completely deflect this spell with a L2-SR on IQ.]" },
{ 2, MODULE_MS, "Cateyes"                , "Cateyes"                ,  6,   0, FALSE, SPELL_TRIANGLE               ,30, "CE", -1     , "Allows one to see in the dark." },
{ 2, MODULE_MM, "Chameleon"              , "Chameleon"              ,  5,   0, FALSE, 0                            ,10, "CH", -1     , "[The person will blend into any background and be harder to hit (double missile SR) & easier to hide (halve hiding SR). In melee, this will halve the attacker's adds.]" },
{ 2, MODULE_MS, "Concealing Cloak"       , "Hidey Hole"             , 10,   0, FALSE, SPELL_TRIANGLE               ,30, "CC", -1     , "Makes user and his party invisible for 3 turns. One magician cannot hide more than 10 beings including himself. Mage may cancel his own spell at any time, but cannot negate someone else's without the use of dispelling magic. Persons leaving the area of a CC return to visibility. People covered by the same CC are visible to each other, but not visible to those in a second CC. (Note: some solos treat this as a level 1 spell.)" },
{ 2, MODULE_CK, "Cure You"               , "Cure You"               ,  2,   0, TRUE , 0                            , 2, "C1", -1     , "[Drains one point of an attribute for every two points of ST that the caster expends.]" },
{ 2, MODULE_RB, "Curse You"              , "Curse You"              ,  2,   0, TRUE , 0                            , 0, "CY", -1     , "Subtract the level number of the caster from any prime attribute of a victim, or MR of a rated monster. The spell lasts until it is removed by magic. If the curse causes death, removal of the curse will not bring the victim back to life." },
{ 2, MODULE_MS, "Delay"                  , "Glue-You"               ,  8,  30, TRUE , SPELL_CIRCLE                 ,10, "DE", -1     , "Impedes movement/travel of victim's speed by ½ for 1 turn. In combat, this means you get 2 combat rounds to their one." },
{ 2, MODULE_MS, "Enhance"                , "Whammy"                 , 10,   0, TRUE , 0                            , 2, "EH", -1     , "Triples dice roll for any weapon for 1 combat turn." },
{ 2, MODULE_MM, "Flame Flick"            , "Flame Flick"            ,  5,  15, TRUE , 0                            , 0, "FF", -1     , "A small spurt of flame from the finger[, which may be \"flicked\" up to 15' away]. It may [ignite dry combustibles, or] do 1-2 points of damage." },
{ 2, MODULE_MM, "Fresh Breath"           , "Fresh Breath"           ,  8,   0, FALSE, 0                            ,60, "FB", -1     , "[Creates enough air for one person to breathe for one hour. It will not create excessive air pressure, and the air will not be contained, but is free to bubble or blow away.]" },
{ 2, MODULE_MM, "Giggles"                , "Giggles"                , 10,  30, FALSE, 0                            , 2, "GI", -1     , "[This affects only one target, inflicting a giggle fit that lasts one round. This reduces all personal adds to zero and increases all SRs by two levels. If the target is under stress at the moment, they are allowed a L2-SR on IQ to deflect the spell.]" },
{ 2, MODULE_MM, "Jack Frost"             , "Jack Frost"             ,  6, 100, FALSE, 0                            , 0, "JF", -1     , "[Causes a layer of light frost to cover everything within 100' of the caster.]" },
{ 2, MODULE_MS, "Magic Fangs"            , "Magic Fangs"            ,  1,   0, TRUE , 0                            , 2, "MF", -1     , "Changes a belt or staff (quarterstaff, ordinaire or makeshift staff, *not* deluxe) into a small poisonous serpent with MR not greater than magician's CHR. Cannot \"communicate\" with mage, but does obey mage's commands. Lasts as long as mage puts ST into it at time of creation (ie. for 5 ST to create, will last 1 regular turn). Does not work on spare twigs or torches unless they are first enchanted into a makeshift staff." },
{ 2, MODULE_MS, "Mirage"                 , "Mirage"                 ,  8, 100, FALSE, 0                            , 0, "MI", -1     , "Projects visual, non-auditory, unmoving image as an hallucination. Destroyed by physical contact. Cannot make something \"invisible\" by a mirage of \"not being there\"." },
{ 2, MODULE_MM, "Moonbeams in a Jar"     , "Moonbeams in a Jar"     ,  7,  50, FALSE, SPELL_BOTH                   ,10, "MJ", -1     , "[Creates light - moonlight intensity - over a 10' radius area; lasts one turn. Higher levels may increase the duration or radius.]" },
{ 2, MODULE_MM, "Night Blight"           , "Night Blight"           ,  7,  50, FALSE, SPELL_BOTH                   ,10, "NB", -1     , "[Creates darkness over a 10' radius - not total darkness, but as an overcast night; lasts one turn. Higher levels may either double the duration or the radius.]" },
{ 2, MODULE_MM, "No-Hear-ums"            , "No-Hear-ums"            ,  5,   0, FALSE, 0                            ,10, "NH", -1     , "[Completely silences any activity done directly by the caster. You can drag a table silently, but if a lamp falls off it, there will be a noise.]" },
{ 2, MODULE_MS, "Omnipotent Eye"         , "Omnipotent Eye"         ,  5,   0, FALSE, 0                            , 0, "OE", -1     , "Determines nature of spell and/or level of spell on persons/objects (at discretion of GM)." },
{ 2, MODULE_MM, "Pepperload"             , "Pepperload"             ,  5,  30, FALSE, SPELL_CIRCLE                 , 2, "PL", -1     , "[This will affect one target whose IQ + LK + CHR cannot exceed the caster's (higher levels increase this limit). Their next mouthful of food or drink (if taken within the next round) will be a pure mixture of curry, tabasco, and jalapeño.]" },
{ 2, MODULE_MM, "Portal Picture"         , "Portal Picture"         ,  4,   0, FALSE, 0                            ,10, "PR", -1     , "[This creates a perfect three dimensional illusion of a passage through a wall or similar barrier. Lasts one (10 minute) turn or until someone bumps into it.]" },
{ 2, MODULE_MS, "Restoration"            , "Poor Baby"              ,  2,   0, FALSE, 0                            , 0, "RS", -1     , "Magical healing of wounds or injuries. Cannot raise level above original." },
{ 2, MODULE_MM, "Sleep Tight"            , "Sleep Tight"            ,  9,  30, FALSE, 0                            ,60, "ST", -1     , "[Cast on a sleeping person, it will keep him asleep for one hour. Only a Dis-spell can awaken him.]" },
{ 2, MODULE_MM, "Snuff"                  , "Snuff"                  , 10,  30, FALSE, SPELL_CIRCLE                 , 2, "SN", -1     , "[This can affect any number of targets, so long as the total CHR (or MR) does not exceed the caster's IQ (higher levels double this limit). They are inflicted with a sneezing fit that prevents any action for one round.]" },
{ 2, MODULE_MS, "Swiftfoot"              , "Little Feets"           ,  8,   0, TRUE , SPELL_TRIANGLE               ,10, "SF", -1     , "Rapid travel. Doubles speed for 1 turn. In combat you get two rounds to opponent's one." },
{ 2, MODULE_MM, "Weathercast"            , "Weathercast"            ,  7,   0, FALSE, 0                      , ONE_DAY, "WC", -1     , "[Will give the caster accurate knowledge of the general weather conditions in this region over the next 24 hours.]" },
{ 2, MODULE_RB, "Yassa-Massa"            , "Yassa-Massa"            ,  8,   0, FALSE, 0                            , 0, "YM", -1     , "Can be cast only on previously-subdued monsters/foes. Will permanently enslave if victim's total ST, IQ and CHR are less than that of wizard, of if MR is less (and remains so)." },
{ 3, MODULE_MM, "All Leathered-Up"       , "All Leathered-Up"       ,  4,   0, FALSE, 0                            , 0, "AL", -1     , "[(4 ST per 1 hit repaired) Repairs damage done to non-metal armour or weapons. Over 50% of the original material must be present for the spell to work.]" },
{ 3, MODULE_MM, "Assay"                  , "Assay"                  ,  6,   0, FALSE, 0                            , 0, "AY", -1     , "[Accurately determines the value of precious metals & stones; also spots fakes and worthless items.]" },
{ 3, MODULE_MS, "Blasting Power"         , "Blasting Power"         ,  8,  70, TRUE , 0                            , 0, "BP", -1     , "Throws bolt of fire (only) at foes. This blast gets same number of dice as user's level number, plus caster's combat adds." },
{ 3, MODULE_MS, "Bog and Mire"           , "Slush Yuck"             , 15,  40, FALSE, SPELL_BOTH                   ,20, "BM", -1     , "Converts rock to mud or quicksand, up to 1000 cubic feet. Can adjust dimensions as desired, but must be a regular geometric solid, and not require more than 1000 cubic feet." },
{ 3, MODULE_MM, "Crossed Tracks"         , "Crossed Tracks"         ,  8,   0, FALSE, 0                            , 0, "CT", -1     , "[Hopelessly confuses any trail left by the caster and up to 9 other people. Can only be followed by using a Second Sight spell.]" },
{ 3, MODULE_MS, "Curses Foiled"          , "Curses Foiled"          ,  7,   0, FALSE, SPELL_CIRCLE                 , 0, "CF", -1     , "Removes evil spells and curses of lower orders." },
{ 3, MODULE_MS, "Dis-Spell"              , "Dis-Spell"              , 11,  50, FALSE, SPELL_CIRCLE                 , 0, "DS", -1     , "Negates magic of same or lower orders." },
{ 3, MODULE_MS, "Dreamweaver"            , "Rock-a-Bye"             , 11,  50, FALSE, 0                            ,10, "DW", -1     , "Puts monsters/foes to sleep for 1-6 turns if user's ST, IQ and CHR exceed the MR (or opponent's ST, IQ, and CHR if rated)." },
{ 3, MODULE_MM, "Drop"                   , "Drop"                   , 10,  50, FALSE, SPELL_CIRCLE                 , 0, "DR", -1     , "[This can affect any number of targets, so long as the total CHR (or MR) does not exceed the caster's IQ (higher levels double this limit). They experience a sudden loss of pantaloon security. This will cause pants or skirts to drop about the ankles; any sort of clothing that fastens about the waist will do - this won't work on robes, togas, etc.]" },
{ 3, MODULE_MM, "Dummy Talk"             , "Dummy Talk"             ,  8,  30, TRUE , 0                            , 0, "DT", -1     , "The caster can supply [up to (caster's level)] words that the target will then speak out loud. The target first gets a L1-SR on IQ to resist the impulse; even if the target speaks the words, it will have no effect on the attitude or frame of mind, and he can immediately countermand it. Some things, however, once said, are difficult to take back." },
{ 3, MODULE_MM, "Fireball"               , "Fireball"               ,  6, 100, TRUE , SPELL_CIRCLE                 , 0, "FI", -1     , "A glowing red 6\" sphere hurtles to the target and explodes. [The caster must make the appropriate Dexterity saving roll to hit, or specify a terminal range for explosion.] Damage is 2 dice, no adds. Higher levels [either] double the damage [or the range]." },
{ 3, MODULE_RB, "Hard Stuff"             , "Hard Stuff"             , 15,  40, FALSE, SPELL_BOTH                   ,20, "HA", -1     , "Does the reverse of a Bog and Mire, with the same parameters and limits." },
{ 3, MODULE_MS, "Healing Feeling"        , "Healing Feeling"        , 14,   0, FALSE, 0                            , 0, "HF", -1     , "Cures any kind of disease." },
{ 3, MODULE_MM, "Hide This"              , "Hide This"              , 15,  25, FALSE, 0                            , 0, "HT", -1     , "[Used to hide any non-living object from sight only and will not mask any magical vibes, sound, or smells. Dispels when touched.]" },
{ 3, MODULE_MS, "Icefall"                , "Freeze Pleeze"          ,  8,  70, TRUE , 0                            , 0, "IF", -1     , "Throws sheet of ice at foes. This blast of ice gets same number of dice as user's level number, plus caster's combat adds." },
{ 3, MODULE_MM, "Miasmal Fart"           , "Miasmal Fart"           ,  6,  30, FALSE, SPELL_CIRCLE                 , 0, "ML", -1     , "[This creates a 10' diameter cloud of the foulest smelling abdominal gases. It is not contained and will dissipate normally. Higher levels double the diameter of the cloud.]" },
{ 3, MODULE_MM, "No-See-ums"             , "Noo-See-ums"            , 12,   0, FALSE, 0                            ,10, "NS", -1     , "[Renders the caster invisible for one turn. The caster may move around freely.]" },
{ 3, MODULE_MM, "Palm Objects"           , "Palm Objects"           ,  8,   0, FALSE, 0                            ,30, "PO", -1     , "[This illusionary spell can be mentally cast. When cast it grants the user the ability to pick any item (which he or she could normally pick up) which is fist sized or smaller, and cause the item to magically disappear as if by sleight of hand. Anyone touching or searching the caster's hands or body will find nothing. This spell lasts for 3 turns, after which the item magically returns to the caster's hand.]" },
{ 3, MODULE_MM, "Peekaboo"               , "Peekaboo"               , 15,   0, FALSE, 0                            ,10, "PB", -1     , "[Allows the caster to see inside a Concealing Cloak for one turn. Without the spell being dispelled.]" },
{ 3, MODULE_MM, "Pretty Ugly"            , "Pretty Ugly"            ,  6,   0, FALSE, 0                            ,60, "PU", -1     , "[Will double or halve CHR for 1 hour.]" },
{ 3, MODULE_MM, "Say Cheese"             , "Say Cheese"             ,  6,   0, FALSE, 0                            , 0, "SC", -1     , "[Produces a flash of intense light from the caster's palm - anyone looking that direction (or anywhere in the vicinity if at night) must make an L3-SR on LK or be dazzled (halve their combat roll, double their saving rolls, etc.). If at night, anyone looking directly at the flash will be night-blinded for one turn if they fail an L6-SR on LK.]" },
{ 3, MODULE_MM, "Scalpel, Please"        , "Scalpel, Please"        ,  2,   0, FALSE, 0                            , 0, "SP", -1     , "[(2 ST per 1 CON) The caster's finger cuts a clean incision, doing 1 (or more) points of damage. Can be used as a weapon, or to do crude surgery (arrow removal, etc.) without excessive blood loss or risk of further infection.]" },
{ 3, MODULE_MM, "Schwahh"                , "Schwahh"                , 17,   0, FALSE, 0                            , 2, "SW", -1     , "[This spell causes all non-magical armour to lose its protection completely] for 1d6 combat rounds. [There is also a 2 in 6 chance that it will cause an additional 10% in hits inflicted on the wearer due to the unknown vulnerability of the armour.]" },
{ 3, MODULE_MM, "Slip Slidin' Away"      , "Slip Slidin' Away"      , 16,  30, FALSE, 0                            , 0, "SA", -1     , "[Negates a lower level Delay spell.]" },
{ 3, MODULE_MM, "Snowball"               , "Snowball"               ,  4,  30, FALSE, SPELL_CIRCLE                 , 0, "SB", -1     , "[Hurls an ordinary snowball; caster must make the appropriate Dexterity saving roll to hit the target. (The snow sublimates almost immediately after hitting the target.) Higher levels double the number of snowballs - they may be \"thrown\" separately or all at once.]" },
{ 3, MODULE_MM, "Splint & Knit"          , "Splint & Knit"          ,  7,   0, FALSE, 0                            , 0, "SK", -1     , "[Sets and heals one broken bone instantly.]" },
{ 3, MODULE_MM, "Sploosh"                , "Sploosh"                , 10,  50, FALSE, 0                            , 0, "S2", -1     , "[Summons 20 gallons of water from the nearest source (if within a mile or so) and dumps it atop the target.]" },
{ 3, MODULE_MM, "Stop That"              , "Stop That"              , 18,  20, FALSE, 0                            , 0, "S3", -1     , "[Stops a single foe in their tracks. If there are more than one foe in the area, the caster will become confused and immobilize himself. Your foe will remain stuck for as long as you don't move suddenly and can still see them and they you for up to 50'.]" },
{ 3, MODULE_MM, "Take it Back"           , "Take it Back"           , 12, 250, TRUE , SPELL_CIRCLE                 , 0, "TB", -1     , "[This is used to reverse a Take That You Fiend back to the caster. You must first make a saving roll on Intelligence at the level of the caster to see if you are successful. If you fail your saving roll you take the full blast. This spell must be cast at two levels above the Take That You Fiend.]" },
{ 3, MODULE_MM, "Tinkle"                 , "Tinkle"                 , 11,  30, FALSE, 0                            , 2, "TI", -1     , "[This causes one target, whose CHR cannot exceed the caster's IQ, to immediately lose bladder control. The effect may depend on the target's character, and on how full the bladder was (they get a L3-SR on LK to avoid any real distraction). If in combat, they will lose all personal adds for one round.]" },
{ 3, MODULE_MM, "True-Tongue"            , "True-Tongue"            ,  8,   0, FALSE, 0                            ,10, "TR", -1     , "[Forces one person to speak the truth, the whole truth, and nothing but the truth.]" },
{ 3, MODULE_MM, "Twinkle Foolish Gold"   , "Twinkle Foolish Gold"   , 12,  50, FALSE, 0                            ,10, "TW", -1     , "[This illusion cause all round stones within 15' of the target point to assume the appearance of gold nuggets and coins. Once a person starts picking them up, they get a L3-SR on IQ to discover the illusion.]" },
{ 3, MODULE_MM, "Waterclean"             , "Waterclean"             , 10,   0, FALSE, 0                            , 0, "WR", -1     , "[Completely purifies a quantity of water of all contaminants (including poisons); up to (the caster's level squared) quarts.]" },
{ 3, MODULE_MM, "Web"                    , "Web"                    ,  8,  50, FALSE, 0                            , 0, "WB", -1     , "[Creates a 1-layer mass of strong, sticky strands 20' × 40'.]" },
{ 3, MODULE_MM, "Whimpy"                 , "Whimpy"                 , 20,  10, FALSE, 0                            , 2, "WY", -1     , "Divides by three the foes' weapon attack die roll for one combat turn." }, // %%: it actually says "foes", which could mean "foe's" or "foes'"
{ 3, MODULE_MS, "Wings"                  , "Fly Me"                 ,  7,   0, FALSE, SPELL_TRIANGLE               ,10, "WI", -1     , "[Allows user to fly at running speed for 1 turn.]" },
{ 3, MODULE_MM, "Wraith Mist"            , "Wraith Mist"            , 10,   0, FALSE, 0                            ,30, "WM", -1     , "[Causes the caster and everything carried to become an insubstantial but visible wavy mist. You can move about as normal, and pass through cracks or key holes in doors. You cannot touch anything, only view your surroundings. This spell does not give you any special vision to see in the dark. Airtight locations cannot be entered.]" },
{ 3, MODULE_MM, "Zap"                    , "Zap"                    ,  8, 150, FALSE, 0                            , 0, "ZX", -1     , "A lightning bolt leaps from the caster's finger to the target. Does dice damage equal to the caster's level plus missile adds." },
{ 4, MODULE_MM, "Ask for Directions"     , "Ask for Directions"     , 30,   0, FALSE, 0                            , 0, "AD", -1     , "[Reads the minds of every creature within a structure. Gets general directions (N, E, S, W, NE, etc.) on the way to escape or leave that structure. May only be cast once per game. A second casting will be too strenuous for the caster's mind causing a fatal stroke.]" },
{ 4, MODULE_MM, "Bat Eyes"               , "Bat Eyes"               , 20,  75, FALSE, 0                            ,10, "BE", -1     , "[Will make an enclosed room pitch black, that only the caster can see in.]" },
{ 4, MODULE_MM, "Clumsy"                 , "Clumsy"                 ,  8,  20, TRUE , 0                            , 0, "CU", -1     , "Reduces victim's Dexterity to 1. If this spell fails [for some reason] the caster's Dexterity is affected instead. The victim is allowed a saving roll on Dexterity at the caster's level and if made the caster must make a saving roll on Dexterity at one level higher to prevent the spell from failing. [The effect of the spell can be negated by saying the spell backwards costing 12 ST.]" },
{ 4, MODULE_MM, "Chill"                  , "Chill"                  , 10,  20, FALSE, 0                            ,10, "CI", -1     , "[Cools the temperature of a small object (up to hobbit size) by 20°F." },
{ 4, MODULE_MM, "Ding-a-Ling"            , "Ding-a-Ling"            ,  8,  50, FALSE, 0                            , 0, "DL", -1     , "[Negates a Dreamweaver spell.]" },
{ 4, MODULE_MS, "Double-Double"          , "Double-Double"          , 18,   0, TRUE , SPELL_TRIANGLE               ,50, "DD", -1     , "[Can double any one prime attribute of any character for up to 5 turns, at caster's option. When spell wears off, attribute is halved for the same number of turns.]" },
{ 4, MODULE_MM, "Eeek"                   , "Eeek"                   , 18,  30, FALSE, 0                            ,10, "EE", -1     , "[This causes one target, whose CHR cannot exceed the caster's IQ, to be suddenly convinced they are completely naked.]" },
{ 4, MODULE_MM, "Essential Fart"         , "Essential Fart"         , 10,  50, FALSE, SPELL_CIRCLE                 , 0, "EF", -1     , "[Even worse than Miasmal Fart, more equivalent to tear gas. Any being caught in the effect will have to fight at ½ effectiveness or surrender. (This can be considered previously subdued.)]" }, // %%: we assume SPELL_CIRCLE based on MF spell
{ 4, MODULE_MM, "Flame Out"              , "Flame Out"              , 10,  50, FALSE, SPELL_CIRCLE                 , 0, "FO", -1     , "[Extinguishes a campfire sized fire (or up to four torches). Higher levels put out larger fires (eg. a bonfire = L6, a house fire = L8).]" },
{ 4, MODULE_MM, "Gill Frill"             , "Gill Frill"             , 16,   0, FALSE, 0                            ,60, "GF", -1     , "Allows a person to breathe underwater." },
{ 4, MODULE_MM, "Hot Stuff"              , "Hot Stuff"              , 10,  20, FALSE, 0                            ,10, "HU", -1     , "[Raises the temperature of an object (up to hobbit size) by 20°F.]" },
{ 4, MODULE_MM, "House Call"             , "House Call"             , 50,   0, FALSE, 0                            ,10, "HC", -1     , "[Works like a Restoration spell only faster. Can restore up to 25 Constitution points within 1 turn. This rapid healing is very painful. The patient must have all broken bones already set, have foreign objects removed (arrows, stones, gravel, etc.), and stay still for the entire turn for the healing to work. Failure to properly prep the patient will result in at best no healing, and at worse improper healing (a broken bone knitting at a right angle, skin growing over an imbedded arrow, etc.)]" },
{ 4, MODULE_MM, "Instant Banking"        , "Instant Banking"        , 20,   0, FALSE, 0           , ONE_YEAR + ONE_DAY, "IB", -1     , "[When cast upon a collection of loot (not exceeding the caster's IQ in pounds), the goods will sink without a trace into the ground beneath. It will stay there, safe from water, worms, and other natural hazards (but not from discovery by others). The caster may recall it to the surface at any time, but after one year and a day, the spell dissolves and the treasure reappears.]" },
{ 4, MODULE_MM, "Invincible Flame"       , "Invincible Flame"       , 14,  20, FALSE, 0                            ,60, "IV", -1     , "[Cast on an existing fire (up to bonfire size), this will cause it to continue burning as long as the fuel remains, regardless of presence of oxygen, high winds, even underwater, etc.]" },
{ 4, MODULE_MM, "Ker-Rack"               , "Ker-Rack"               , 10,  30, TRUE , 0                            , 0, "KR", -1     , "If the caster's IQ is at least half the victim's CON or MR, he will cause one selected limb bone to shatter (this rarely kills, damage is usually 1-3 dice plus loss of use of limb)." },
{ 4, MODULE_MM, "Mystic Woollies"        , "Mystic Woollies"        , 15,   0, FALSE, 0                            ,60, "MW", -1     , "[Causes the caster or one other person to be impervious to cold and immune to cold damage for one hour.]" },
{ 4, MODULE_MM, "Protective Charm"       , "Protective Charm"       ,  8,   0, FALSE, 0                            , 0, "PC", -1     , "[Caster takes any coin and places it on a wrist and casts the spell; a 2' diameter shield will appear. Nothing can penetrate this shield as long as you can get/keep it between you and the weapon or projectile.]" },
{ 4, MODULE_MS, "Protective Pentagram"   , "Protective Pentagram"   , 12,   0, TRUE , SPELL_CIRCLE                 ,20, "PP", -1     , "Puts up a protective barrier 3' in diameter (protects 2 people) for 2 turns that no spell or weapon will penetrate (going in *or* out). Higher levels increase the size." },
{ 4, MODULE_MM, "Sixth Sense"            , "Sixth Sense"            , 10,   0, FALSE, 0                            ,60, "SX", -1     , "[Renders a person quite incapable of being surprised by anything.]" },
{ 4, MODULE_MM, "Slamshut"               , "Slamshut"               , 10,  30, FALSE, SPELL_CIRCLE                 ,60, "S4", -1     , "[Will close an opening of window (half-door) size; the surrounding material closes in and has its ordinary resistance to breakage, etc. Lasts one hour if not smashed. Increased levels increase the size of the opening allowed.]" },
{ 4, MODULE_MS, "Smog"                   , "Smog"                   , 11,  50, TRUE , 0                            , 0, "SG", -1     , "Enables you to project a cloud of poison gas at foes. [If they breathe, ]they lose [at least ]half power[, and may die at GM's option]." },
{ 4, MODULE_MM, "Snooze Alarm"           , "Snooze Alarm"           , 12, 150, FALSE, 0                           ,720, "SZ", -1     , "[This is a simple ward; placed on a container or across a threshold, will instantly awaken and alert the caster when it is triggered. Lasts for 12 hours or until triggered.]" },
{ 4, MODULE_MM, "Stay-Cool"              , "Stay-Cool"              , 15,   0, FALSE, 0                            ,60, "S5", -1     , "[This renders the caster or one other person impervious to heat and immune to all fire damage (except magical flames created by a magic user (or dragon) with greater Intelligence than this spell's caster).]" },
{ 4, MODULE_MM, "Sunlight in a Bottle"   , "Sunlight in a Bottle"   , 12,  50, FALSE, SPELL_BOTH                   ,10, "S6", -1     , "[Creates full daylight in a 10' radius area; lasts one turn. Higher levels may double the duration or the radius.]" },
{ 4, MODULE_MS, "Too-Bad Toxin"          , "Too-Bad Toxin"          ,  7,   0, FALSE, 0                            , 0, "TT", -1     , "Cures the effect of any poison and nullifies it from further effect. Does *not* heal wound from the weapon/fang that delivered the poison (requires Restoration)." },
{ 4, MODULE_CK, "Twine Time"             , "Twine Time"             , 10,   0, TRUE , 0                            , 0, "T1", -1     , "[Forces the grass to grow in a sudden burst and tangles up your foes.]" },
{ 4, MODULE_MS, "Upsidaisy"              , "Upsidaisy"              ,  9,   0, FALSE, SPELL_BOTH                   ,10, "UP", -1     , "Allows you to levitate and move objects/beings up to your own weight." },
{ 4, MODULE_MM, "Vapour Maker"           , "Vapour Maker"           , 10,   0, FALSE, SPELL_CIRCLE                 ,35, "VM", -1     , "[Creates high level clouds; they form within five minutes and last three turns. (If cast at L5 (cost = 20), the clouds will be at ground level - fog.)]" },
{ 4, MODULE_MM, "Ward Warn"              , "Ward Warn"              , 18,   0, FALSE, 0                            , 0, "WD", -1     , "[Placed across an opening, on an object, or an area of 10' radius with one other spell (which adds its ST cost to this); that encapsulated spell will go off on the first being to cross/disturb the warded area. Lasts until triggered or cancelled.]" },
{ 4, MODULE_MM, "Water Puppet"           , "Water Puppet"           , 15,   0, FALSE, 0                            ,10, "WP", -1     , "[Animates a body of water or vapour (up to one quart per level of caster); it has movement ability within its natural capacity and will act under the conscious direction of the caster. The range of control is not limited, but it will not act independently or upon instructions.]" },
{ 4, MODULE_MM, "Whoopie Curses"         , "Whoopie Curses"         , 12,  30, FALSE, SPELL_TRIANGLE     , ONE_DAY / 2, "WU", -1     , "[This curse causes one target to emit loud farts whenever they sit down - they are allowed a saving roll on IQ at the caster's level to deflect it completely. The effect lasts until the next sunrise. Higher levels double the number of days.]" },
{ 4, MODULE_MS, "Wink-Wing"              , "Wink-Wing"              , 14,   0, FALSE, SPELL_CIRCLE                 , 0, "WG", -1     , "Allows you to transport yourself (only) up to 50' in direction of choice without crossing intervening space." },
{ 4, MODULE_MS, "Witless"                , "Dum-Dum"                ,  8,  20, FALSE, 0                            , 0, "WL", -1     , "Reduces foe's IQ to 3[, or if spell fails for *any* reason, your IQ is reduced to 3]." },
{ 5, MODULE_MM, "Bomb Lock"              , "Bomb Lock"              , 20,   0, FALSE, 0                            , 0, "BL", -1     , "[Used to lock anything with a lock. When someone tries to open this locked lock, it will explode with a force equal to the caster's Intelligence.]" },
{ 5, MODULE_MM, "Cool It"                , "Cool It"                , 10,  50, FALSE, 0                            ,10, "CO", -1     , "[Drops the temperature within a 25' radius by 10°F.]" },
{ 5, MODULE_MS, "Dear God"               , "Dear God"               , 30,   0, FALSE, 0                            , 0, "DG", -1     , "[Allows one to ask 3 yes-or-no questions of the GM which he must answer truthfully.]" },
{ 5, MODULE_MM, "Defrost"                , "Defrost"                ,  8,   0, FALSE, 0                            , 0, "DF", -1     , "[Heals any cold damage done to a living creature including a victim of cold spells, if cast at the same level as the spell. This healing must occur within 2 combat rounds of the cold damage.]" },
{ 5, MODULE_MS, "ESP"                    , "ESP"                    , 20,  20, FALSE, 0                            , 0, "ES", -1     , "Detects the true *intent* of a man or monster. Won't reveal knowledge or concrete information, just emotions and/or intentions. Won't work on creatures without a living brain." },
{ 5, MODULE_MM, "Fire Vision"            , "Fire Vision"            , 26,   0, FALSE, 0                            ,10, "FV", -1     , "[The caster may look into one fire and \"see out of\" any other fire within five miles.]" },
{ 5, MODULE_MM, "Float Feet"             , "Float Feet"             , 15,   0, FALSE, 0                            ,10, "FL", -1     , "[Allows a person to walk on water.]" },
{ 5, MODULE_MM, "Flower Power"           , "Flower Power"           , 28,  50, FALSE, 0                            ,10, "FP", -1     , "[Causes all within 50' (including the caster) to desire nothing but peace, sweetness and harmony for one turn.]" },
{ 5, MODULE_MS, "Fracture"               , "Breaker Breaker"        , 35,  50, FALSE, 0                            , 0, "FR", -1     , "[Shatters a weapon or piece of armour by causing it to become as brittle as glass (though not as dangerous as glass) so it will break upon first impact. Any magic on item will protect it (ie. Vorpal Blade, or any inherently magical blade).]" },
{ 5, MODULE_MM, "Glow"                   , "Glow"                   , 10,   0, FALSE, 0                            , 2, "GL", -1     , "[The caster glows with torchlight intensity. Those touching him will take 1d6 heat damage. Those grappling or being grappled take 3d6.]" },
{ 5, MODULE_MM, "Hell Gloves"            , "Hell Gloves"            , 20,   0, FALSE, 0                            , 2, "HG", -1     , "[Envelops the caster's hands in flames. The caster will then do 1 die damage by touch (each hand) [as well as ignite flammables. This will also grow to envelop any hand-held weapons and add one die to their combat damage as well as render the attack magical.]" },
{ 5, MODULE_MM, "Hot Time"               , "Hot Time"               , 10,  50, FALSE, 0                            ,10, "HI", -1     , "[Raises the temperature in a 25' radius by 10°F.]" },
{ 5, MODULE_MS, "Mind Pox"               , "Mind Pox"               , 39, 100, FALSE, 0                            ,30, "MP", -1     , "Causes mental confusion so that the ensorcelled being cannot attack or defend itself. Wears off after 3 turns. Will affect any number of beings equal to or less than the level number of the caster." },
{ 5, MODULE_MM, "Moon Banish"            , "Moon Banish"            , 20,   0, FALSE, SPELL_CIRCLE                 ,60, "MB", -1     , "[A lunar eclipse affecting the area within one mile of the caster; lasts for one hour or until dismissed. Higher levels double the radius.]" },
{ 5, MODULE_MM, "Moxi-Toxi"              , "Moxi-Toxi"              , 15,  45, FALSE, 0                            , 0, "MT", -1     , "[Negates a Smog, but not the effect if one has already breathed the gas.]" },
{ 5, MODULE_MM, "Peekaboo II"            , "Peekaboo II"            , 15,   0, FALSE, SPELL_CIRCLE                 ,10, "PK", -1     , "[Renders any material (less than 1' thick) transparent for one turn. The area of transparency can be up to (level) inches in diameter.]" }, // can't use ][ to represent II
{ 5, MODULE_MM, "Perfect Portal Picture" , "Perfect Portal Picture" , 22,  30, FALSE, 0                            ,10, "PE", -1     , "[This creates the illusion of a passage as in the Portal Picture spell, except that the caster and party may actually pass through it. It disappears when anyone else tries to use it, or after one turn.]" },
{ 5, MODULE_MM, "Rag Doll"               , "Rag Doll"               , 20,   0, FALSE, 0                            , 0, "RD", -1     , "[Cause paralysis. Denies victim all motor control below the neck. The effect is permanent but can be dispelled.]" },
{ 5, MODULE_MS, "Second Sight"           , "Second Sight"           , 25, 100, FALSE, SPELL_TRIANGLE               ,10, "SE", -1     , "[Allows a person to distinguish between illusion and reality for 1 person, and to see things as they \"really\" are.]" },
{ 5, MODULE_MM, "Stone You"              , "Stone You"              , 20,  70, FALSE, 0                            , 0, "S7", -1     , "[All throwing-sized rocks within 50' will leap off the ground and hurl themselves at the target. Damage depends on the surrounding terrain, but is at least 2d6 and at most 10d6.]" },
{ 5, MODULE_MM, "Think Throw"            , "Think Throw"            , 20, 500, FALSE, SPELL_BOTH                   , 2, "TH", -1     , "Allows the caster to telepathically converse with one person. Target must be known to the caster or within line of sight. Lasts one round. (Higher levels increase range or duration.)" },
{ 5, MODULE_CK, "Thunderbolt"            , "Thunderbolt"            , 15,   0, TRUE , 0                            , 0, "T2", -1     , "[Hurls a thunderclap at the caster's target.]" },
{ 5, MODULE_MM, "Trust Me"               , "Trust Me"               , 30,  10, FALSE, 0                            ,60, "TM", -1     , "[If cast upon a victim whose IQ + LK + CHR (or MR) is less than the caster's, will cause the victim to believe completely whatever the caster says.] Lasts 1d6 hours. [However, if the intended victim proves to have too high attributes, the victim then conceives a great loathing for the caster and seek to denounce him to the authorities or just pound his face in.]" },
{ 5, MODULE_RB, "Zingum"                 , "Zingum"                 , 36,  50, FALSE, SPELL_CIRCLE                 , 0, "ZI", -1     , "[Allows one to transport double one's weight 50' in any direction. Works on non-living matter only.]" },
{ 6, MODULE_MM, "Animation"              , "Animation"              , 20,  50, FALSE, 0                            ,10, "AT", -1     , "[Animates any inanimate object in a cartoony fashion; it sprouts legs and arms as necessary, and can manipulate objects and obey simple commands. Its effective Strength and Dexterity depends on its original composition and form.]" },
{ 6, MODULE_MM, "Bridge of Ice"          , "Bridge of Ice"          , 30,   0, TRUE , 0                            ,10, "BI", -1     , "Creates a bridge spanning at most 50' and capable of supporting (Intelligence × Level) × 100#. (This is a variant Wall spell and otherwise conforms to those standards.)" },
{ 6, MODULE_MM, "Broken Pentagram"       , "Broken Pentagram"       , 24,   0, FALSE, 0                            ,10, "BR", -1     , "[Negates a Protective Pentagram. Takes one turn to effect.]" },
{ 6, MODULE_MM, "Clairaudience"          , "Mystic Ears"            , 16,   0, FALSE, 0                            ,10, "MY", -1     , "[The caster can hear what is going on in another known location (clairaudience).]" },
{ 6, MODULE_MM, "Dig Dig Dug"            , "Dig Dig Dug"            , 16,   0, FALSE, 0                            ,10, "DU", -1     , "[The caster can move aside or remove earth (not solid rock) at the rate of 50 cubic ft/Level/round for one turn (five combat rounds). (A tunnel a man can move through at a crouch is 100 cubic feet per 4' length.)]" },
{ 6, MODULE_CK, "Elemental Earth"        , "Elemental Earth"        , 42,   0, TRUE , 0                            ,10, "E1", -1     , "[Allows the caster to summon an earth elemental to use as a servant for one normal round.]" }, // %% by "normal round", we assume they mean "turn"
{ 6, MODULE_MM, "Goldnose"               , "Goldnose"               , 15,   0, FALSE, 0                            ,10, "GN", -1     , "[Allows the caster to smell the scent of gold.]" },
{ 6, MODULE_MM, "Ice Storm"              , "Ice Storm"              , 16, 100, FALSE, SPELL_CIRCLE                 , 2, "IS", -1     , "[Causes an instant hailstorm over a 20' radius; it lasts one round and does little real damage (except to crops, etc.). Higher levels increase the radius.]" },
{ 6, MODULE_MM, "Impotent Eye"           , "Impotent Eye"           , 15,   0, FALSE, 0                            , 0, "IE", -1     , "[Hides nature and/or level from others who may use an Omnipotent Eye.]" },
{ 6, MODULE_RB, "Mystic Visions"         , "Mystic Visions"         , 15,   0, FALSE, 0                            , 0, "MV", -1     , "[Clairvoyance spell. Allows one to see what is happening anywhere else by getting a mental picture of it. Must have some knowledge of an object, person, or the place to key into - one cannot see into a totally strange place. Vision is like a still photograph; cannot scan a whole area.]" },
{ 6, MODULE_MM, "Panic II"               , "Panic II"               , 32,  50, FALSE, 0                            , 0, "P2", -1     , "[All living beings within 50' of the caster must make an Intelligence saving roll at the caster' level or flee in terror.]" }, // can't use ][
{ 6, MODULE_RB, "Porta Vision"           , "Porta Vision"           , 30, 100, FALSE, SPELL_TRIANGLE               ,50, "PV", -1     , "[Similar to Mirage spell, allows some movement of image projected. No sound, however, and movement for only short distances. Can determine its unreality by the fact it can't be touched, but touch will not cause it to vanish. Lasts up to 5 turns, at caster's option.]" },
{ 6, MODULE_MM, "Stand Up & Walk"        , "Stand Up & Walk"        , 25,   0, FALSE, 0                            , 0, "SD", -1     , "[Cures paralysis from any cause except a severed spinal cord (a Clone Grown spell will have to be combined with this to cure that condition).]" },
{ 6, MODULE_MM, "Superglue"              , "Superglue"              , 26,  30, FALSE, 0                            ,10, "S8", -1     , "[This is an amplified and concentrated Delay spell. The victim cannot move at all for one turn; but is subject to normal time events (he can be moved, hurt, etc.).]" },
{ 6, MODULE_MM, "Serve-a-Curve"          , "Serve-a-Curve"          , 22, 100, FALSE, 0                            , 0, "S9", -1     , "[Will cause a Wind Whistle to curve back upon the caster.]" },
{ 6, MODULE_MS, "Wall of Fire"           , "Wall of Fire"           , 26,   0, TRUE , SPELL_CIRCLE           , ONE_DAY, "WF", -1     , "Puts sheet of flames between you and foe. To pass through, must be immune to flame or take hits equal to IQ times user's level number.\n" \
                                                                                                                                       "  All the Wall spells are immobile once created. All appear at the immediate distance of the magicker's reach (ie. the end of his fingertips or staff). Can only be formed in the shape of a regular geometric solid, such as a rectangle or square. Can be dispelled, but if not the wall will disappear after 1 day. Its size cannot surpass 1000 cubic feet." },
{ 6, MODULE_MS, "Wall of Ice"            , "Wall of Ice"            , 26,   0, TRUE , SPELL_CIRCLE           , ONE_DAY, "WA", -1     , "Puts wall of ice between you and foe. To pass through, must melt or cut through. To cut through, must be able to deliver hits equal to IQ times user's level number.\n" \
                                                                                                                                       "  All the Wall spells are immobile once created. All appear at the immediate distance of the magicker's reach (ie. the end of his fingertips or staff). Can only be formed in the shape of a regular geometric solid, such as a rectangle or square. Can be dispelled, but if not the wall will disappear after 1 day. Its size cannot surpass 1000 cubic feet." },
{ 6, MODULE_MS, "Wall of Iron"           , "Wall of Iron"           , 23,   0, TRUE , 0                      , ONE_DAY, "WN", -1     , "Puts wall of iron between you and foe. Impassable unless one has the power to melt, change, or destroy iron.\n" \
                                                                                                                                       "  All the Wall spells are immobile once created. All appear at the immediate distance of the magicker's reach (ie. the end of his fingertips or staff). Can only be formed in the shape of a regular geometric solid, such as a rectangle or square. Can be dispelled, but if not the wall will disappear after 1 day. Its size cannot surpass 1000 cubic feet." },
{ 6, MODULE_MM, "Wall of Gloom"          , "Wall of Gloom"          , 12,   0, TRUE , 0                      , ONE_DAY, "W1", -1     , "Within the wall area there is total darkness; those entering must make an L6-SR on IQ or panic and flee.\n" \
                                                                                                                                       "  All the Wall spells are immobile once created. All appear at the immediate distance of the magicker's reach (ie. the end of his fingertips or staff). Can only be formed in the shape of a regular geometric solid, such as a rectangle or square. Can be dispelled, but if not the wall will disappear after 1 day. Its size cannot surpass 1000 cubic feet." },
{ 6, MODULE_MM, "Wall of Light"          , "Wall of Light"          , 22,   0, TRUE , 0                      , ONE_DAY, "W2", -1     , "The wall glows very brightly, illuminating the area within 50'. Anyone entering must take heat damage equal to the caster's IQ and make an L3-SR on LK be blinded for 1d6 turns.\n" \
                                                                                                                                       "  All the Wall spells are immobile once created. All appear at the immediate distance of the magicker's reach (ie. the end of his fingertips or staff). Can only be formed in the shape of a regular geometric solid, such as a rectangle or square. Can be dispelled, but if not the wall will disappear after 1 day. Its size cannot surpass 1000 cubic feet." },
{ 6, MODULE_MS, "Wall of Stone"          , "Wall of Stone"          , 20,   0, TRUE , 0                      , ONE_DAY, "WS", -1     , "Wall of stone between you and foe. Impassable unless one can penetrate or chop through stone.\n" \
                                                                                                                                       "  All the Wall spells are immobile once created. All appear at the immediate distance of the magicker's reach (ie. the end of his fingertips or staff). Can only be formed in the shape of a regular geometric solid, such as a rectangle or square. Can be dispelled, but if not the wall will disappear after 1 day. Its size cannot surpass 1000 cubic feet." },
{ 6, MODULE_MS, "Wall of Thorns"         , "Wall of Thorns"         , 14,   0, TRUE , SPELL_CIRCLE           , ONE_DAY, "WT", -1     , "Puts wall of thorns between you and foe. Can safely be cut or burnt, but to walk through, must make saving roll on LK at caster's level to avoid falling asleep for 1-6 days.\n" \
                                                                                                                                       "  All the Wall spells are immobile once created. All appear at the immediate distance of the magicker's reach (ie. the end of his fingertips or staff). Can only be formed in the shape of a regular geometric solid, such as a rectangle or square. Can be dispelled, but if not the wall will disappear after 1 day. Its size cannot surpass 1000 cubic feet." },
{ 6, MODULE_MM, "Wall of Water"          , "Wall of Water"          , 12,   0, TRUE , 0                      , ONE_DAY, "W3", -1     , "It is just a wall of ordinary water. (Drinking it will do no good, any water removed from the wall area disappears. It does, however, make a heck of a swimming pool.)\n" \
                                                                                                                                       "  All the Wall spells are immobile once created. All appear at the immediate distance of the magicker's reach (ie. the end of his fingertips or staff). Can only be formed in the shape of a regular geometric solid, such as a rectangle or square. Can be dispelled, but if not the wall will disappear after 1 day. Its size cannot surpass 1000 cubic feet." },
{ 6, MODULE_MM, "Wall of Wind"           , "Wall of Wind"           , 18,   0, TRUE , 0                      , ONE_DAY, "W4", -1     , "Within the wall's volume, the air is hurtling around at hurricane velocity. Anyone entering it must make a Strength saving roll at the caster's level or be hurled back (damage = ½ the caster's level in dice).\n" \
                                                                                                                                       "  All the Wall spells are immobile once created. All appear at the immediate distance of the magicker's reach (ie. the end of his fingertips or staff). Can only be formed in the shape of a regular geometric solid, such as a rectangle or square. Can be dispelled, but if not the wall will disappear after 1 day. Its size cannot surpass 1000 cubic feet." },
{ 6, MODULE_MM, "Wall of Wood"           , "Wall of Wood"           , 16,   0, TRUE , 0                      , ONE_DAY, "W5", -1     , "This one is made of 1'-thick oak beams.\n" \
                                                                                                                                       "  All the Wall spells are immobile once created. All appear at the immediate distance of the magicker's reach (ie. the end of his fingertips or staff). Can only be formed in the shape of a regular geometric solid, such as a rectangle or square. Can be dispelled, but if not the wall will disappear after 1 day. Its size cannot surpass 1000 cubic feet." },
{ 7, MODULE_MM, "Brain Strain"           , "Brain Strain"           , 24,   0, FALSE, 0                            , 0, "BS", -1     , "[Causes permanent insanity. The nature of the insanity - subtle disorientation to raging lunacy - is up to the GM, but the experience difference between caster and victim should be taken into account. A 15th level wizard should be able to induce any desired type of insanity in a 1st level warrior.]" },
{ 7, MODULE_MM, "Bread & Water"          , "Bread & Water"          , 15,   0, FALSE, 0                  , 3 * ONE_DAY, "BW", -1     , "[Suppresses a person's need for food and water for up to three days, after which the lack will have to be made up.]" },
{ 7, MODULE_MM, "Darkmeld"               , "Darkmeld"               , 15,   0, FALSE, 0                            ,10, "DK", -1     , "[The caster becomes a part of the night or deep shadow. They are nearly invisible when motionless and only silver or enchanted weapons can strike them (however, a successful Medusa spell on a person in this state will still kill them). The effect is dispelled by any strong light.]" },
{ 7, MODULE_CK, "Elemental Air"          , "Elemental Air"          , 42,   0, TRUE , 0                            ,10, "E2", -1     , "[Allows you to conjure an air elemental to use as a servant for one normal round.]" }, // %% by "normal round", we assume they mean "turn"
{ 7, MODULE_MM, "Exchange"               , "Exchange"               , 30,   0, FALSE, 0                            , 0, "EG", -1     , "[This spell transmutes precious metals (including coins) into gems and vice versa. The total value in the exchange cannot exceed the caster's (IQ × 1000) in gp; no value is lost in the exchange. The gems thus created will be uncut and unexceptional, of random types, weighing a hundredth of what the metal weighed (roughly). The reverse process will create the equivalent value in (roll 1d6):\n" \
                                                                                                                                       "     1     gold dust\n    2-3    gold nuggets\n    4-5    silver nuggets\n     6     gold coins]" },
{ 7, MODULE_MM, "Forge-ery"              , "Forge-ery"              , 10,   0, FALSE, 0                            , 0, "FG", -1     , "[(10 ST per 1 hit repaired) Repairs damage done to metal armour or weapons. Over 50% of the original material must be present for the spell to work.]" },
{ 7, MODULE_MM, "Icicle"                 , "Icicle"                 , 20, 100, TRUE , SPELL_CIRCLE                 , 0, "IC", -1     , "Hurls a spear-like icicle into one target. Damage only equals the caster's Intelligence, but anyone taking hits must make a Luck saving roll at the caster's level or lose half their Dexterity (due to chills) for one turn. Higher levels increase the number of icicles - which may be thrown separately, at different targets, or all at once." },
{ 7, MODULE_RB, "Invisible Wall"         , "Invisible Wall"         , 27,  50, FALSE, SPELL_CIRCLE                 , 0, "IW", -1     , "Allows you to erect a force field from floor to ceiling that nothing but higher level magic can penetrate. Cannot be moved once created, nor shaped to specifications."              }, // -- WA -- 50 --
{ 7, MODULE_MM, "Jemnose"                , "Jemnose"                , 20,   0, FALSE, 0                            ,10, "JN", -1     , "[Allows the caster to smell the scent of precious gems.]" },
{ 7, MODULE_MM, "Mist"                   , "Mist"                   , 20,   0, FALSE, 0                            ,30, "MS", -1     , "[The caster turns into steam - it lasts three (ten minute) turns or until dispelled, or dismissed by the caster. Use with caution; you have no voluntary movement in this form, you are at the mercy of the winds (and temperature).]" },
{ 7, MODULE_MM, "Nobody Home"            , "Nobody Home"            , 25,   0, FALSE, 0                            ,60, "NO", -1     , "[To any mystic or psychic probes, the caster's mind will appear as \"not there\"; a complete blank. His mind cannot be read or even detected. Lasts one hour or until dispelled, or dismissed by the caster.]" },
{ 7, MODULE_MM, "Older"                  , "Older"                  , 25,  25, FALSE, 0                            , 0, "OL", -1     , "[Adds five years to the age of one person or object (living beings are allowed an L3-SR on LK; objects get no saving roll).]" },
{ 7, MODULE_MM, "Open Sesame"            , "Open Sesame"            , 15,   0, FALSE, 0                            ,60, "OS", -1     , "[Creates an opening in a physical barrier about 5' across. The depth/length of the passage may be up to the caster's level in feet. If the barrier is thicker than that, the spell fails completely. Will last for one hour unless dispelled.]" },
{ 7, MODULE_MM, "Rubble Crumble"         , "Rubble Crumble"         , 25, 100, FALSE, 0                            ,10, "RC", -1     , "[Causes stone to slowly crumble into dust at the rate of 100 cubic feet per round for one turn (total volume = 8 foot cube). Will not work on magical stone (golems, medusa victims, Walls of, etc.).]" },
{ 7, MODULE_MM, "Speedy Me"              , "Speedy Me"              , 25,   0, FALSE, 0                            ,60, "X1", -1     , "[Elevates the caster's (or another's) time factor by six. The person operates six times faster, thus \"disappearing\" to normal time perception (beings in normal time will be unable to see them, although they might sense their smell or psychic presence). They react to gravity, mass, etc., in a way that is \"normal\" to their perception (thus they would fall six times faster but still take normal damage for the distance fallen). Small objects held in their hand would share their time factor, but living beings would not. This spell, therefore, is worthless for combat, as a speeded warrior is unable to do real damage to normal time people (although he might steal their swords).]" }, // %%: duration isn't really specified
{ 7, MODULE_MM, "Speedy Them"            , "Speedy Them"            , 25,   0, FALSE, 0                            ,60, "X2", -1     , "[Reduces the caster's (or another's) time factor by six. They \"disappear\" to normal time perception and experience 10 minutes of time while the world goes through one hour. They may see stationary objects and people, but someone moving at walking speed would be invisible to the slowed person. Use with caution, as collisions with unseen horses, etc., can be very dangerous.]" }, // %%: duration isn't really specified
// { 7, MODULE_CK, "Wall of Water"       , "Wall of Water"          , 22,   0, TRUE , 0                            ,10, "W0", -1     , "[Forms a wall of water for one normal round.]" }, // %% by "normal round", we assume they mean "turn"
{ 7, MODULE_RB, "Wind Whistle"           , "Wind Whistle"           , 14, 100, FALSE, SPELL_BOTH                   ,10, "WW", -1     , "[Calls up a breeze with a speed up to 10 mph, lasts 1 turn. Higher levels increase velocity of wind or duration (not both). Caster must specify wind direction while casting the spell. Opposing winds of equal velocity will cancel each other; a stiffer breeze will be partially negated by a lesser one but not completely nullified.]" },
{ 7, MODULE_MM, "You Will Talk"          , "You Will Talk"          , 25,   0, FALSE, 0                            ,30, "YT", -1     , "[Endows an inanimate object with a mouth and the power of speech for 3 turns. The apparent intelligence of the object will be very rudimentary, but depending upon GM's determination, effective IQ will actually increase with fine workmanship and greater age of the object (eg. a cheap, new leather belt will be a useless dimwit, but a finely wrought antique chair may be very erudite).]" },
{ 7, MODULE_MS, "Zappathingum"           , "Zappathingum"           , 24,   0, TRUE , SPELL_TRIANGLE               ,60, "ZA", -1     , "Enchants any weapons to 3 times its ordinary effectiveness. Effect lasts 1-6 hours (roll 1 die to determine)."                                                                       }, // ZP ZA CS 51 *-
{ 8, MODULE_MM, "Alas, Poor Stiff"       , "Alas, Poor Stiff"       , 24,   0, FALSE, 0                            , 2, "AP", -1     , "[Allows the caster to speak with a dead person; the corpse or at least a skull must be present. This does not actually recall the spirit, but merely reactivates the memory and consciousness lying dormant in the remains.]" },
{ 8, MODULE_MM, "Armour of Flame"        , "Armour of Flame"        , 35,   0, TRUE , 0                            ,10, "AF", -1     , "[Swaths the caster's entire body in flames. This has all the same effects as the Hell Gloves spell. It also does 6 dice damage if grappling or being grappled. It also heats up any melee weapon used against the caster by 20°F per round.]" },
{ 8, MODULE_MM, "Early Grave"            , "Early Grave"            , 30,  30, FALSE, 0                            , 0, "EY", -1     , "[For all practical purposes, the victim of this spell will appear to nature (and non-intelligent creatures) to be dead. Scavengers may attempt to eat him as he sleeps, and worst of all he will actually begin to decompose - losing one point of Constitution each day. Also, no healing of any wounds is possible except by magic. There is no save and the effect is permanent, although it may be removed like any curse.]" },
{ 8, MODULE_CK, "Elemental Water"        , "Elemental Water"        , 42,   0, TRUE , 0                            ,10, "EW", -1     , "[Allows the caster to summon a water elemental to use as a servant for one normal round.]" }, // %% by "normal round", we assume they mean "turn"
{ 8, MODULE_MM, "Head Shrink"            , "Head Shrink"            , 30,   0, FALSE, 0                            , 0, "HK", -1     , "[Will cure all insanity, except that from a divine cause.]" },
{ 8, MODULE_RB, "Mutatum Mutandis"       , "Mutatum Mutandis"       , 24,   0, FALSE, 0                            ,10, "MU", -1     , "[Enables you to change yourself into any other form of being/creature with a MR no higher than your combined prime attributes. Gives you all the powers and abilities of that creature. Only lasts 1-6 turns at user's option, at which time creature returns to original shape before the enchantment. Any hits taken to Monster Rating must be taken proportionately on original Constitution.]" },
{ 8, MODULE_MM, "Rippin' Stitchin'"      , "Rippin' Stitchin'"      , 20,  60, FALSE, 0                            , 0, "RI", -1     , "[Will cause all wounds received (and previously healed) in the past 24 hours to instantly re-open.]" },
//{8,MODULE_CD, "Rustler-Holding"        , "Rustler-Holding"        ,  0,   0, FALSE, 0                            , 0, "RU", -1     , "See CD192." },
{ 8, MODULE_MM, "Statuesque"             , "Statuesque"             , 20,   0, FALSE, 0                            ,60, "SQ", -1     , "[Allows the caster to petrify himself. He retains vision and hearing and may cancel the spell at any time.]" },
{ 8, MODULE_MM, "Sun Screen"             , "Sun Screen"             , 35,   0, FALSE, SPELL_CIRCLE                 ,60, "X3", -1     , "[A solar eclipse affecting the area within one mile of the caster. Higher levels double the radius.]" },
{ 8, MODULE_MM, "Twister"                , "Twister"                , 35, 100, FALSE, 0                            , 4, "TS", -1     , "[Creates a small cyclone under the direction of the caster; anything weighing less than (100 × caster's IQ) in pounds will be picked up and thrown around. Can move at up to 40' per round.]" },
{ 8, MODULE_MM, "Water Spout"            , "Water Spout"            , 35, 300, FALSE, 0                            , 4, "W6", -1     , "[Creates a water twister that moves at the caster's direction (up to 40' per round). It will destroy small boats and swamp larger ones, and pick up and hurl about any object weighing less than (IQ × 100) pounds. This spell works only at sea or within 300' of a large lake or sea.]" },
{ 8, MODULE_MS, "Zapparmour"             , "Zapparmour"             , 30,   0, TRUE , SPELL_TRIANGLE               ,60, "ZP", -1     , "Enchants any armour or shield to 3 times ordinary protection. Lasts for 1-6 hours."                                                                                                  }, // ZP ZP CS 53 *-
{ 8, MODULE_MS, "Zombie Zonk"            , "Zombie Zonk"            , 36,   0, FALSE, 0                            ,50, "ZZ", -1     , "[Makes zombies of any corpses which are under user's control. Have double previous ST and CON (or MR), but no IQ, LK, or CHR. Cannot be slain but can be stopped by dismemberment. Effect lasts 5 turns. Zombies die if the master is slain.]" },
{ 9, MODULE_MM, "Cube You"               , "Cube You"               , 25,  50, FALSE, 0                            , 0, "CB", -1     , "[Entraps one man-sized victim in a cube of solid ice. The cube takes (caster's Intelligence × level) points of damage to smash. Meanwhile, the victim is subject to the normal effects of freezing and suffocation.]" },
{ 9, MODULE_MS, "Death Spell #9"         , "Death Spell #9"         , 40, 100, TRUE , 0                            , 0, "D9", -1     , "Will kill anything which misses its L9-SR on Luck (60 - LK). Only works on one being at a time."                                                                                     }, // -- D9 -- 59 *-
{ 9, MODULE_MM, "Diabolic Pet"           , "Diabolic Pet"           , 35,   0, FALSE, 0                     , ONE_YEAR, "DP", -1     , "[Summons up a familiar that will serve the caster for 1 die years or until banished. It is almost always an Imp, with an MR no higher than the caster's Intelligence. In addition to their regular abilities, they can also function as a Deluxe Staff for their wizard (although they cannot remember spells requiring a higher IQ than they possess). They must feed daily upon the wizard's blood. (Caution: familiar or not, these creatures are still servants of Hell.)]" },
{ 9, MODULE_MM, "Earth Merge"            , "Earth Merge"            , 25,   0, FALSE, 0                            ,10, "EM", -1     , "The caster merges with the ground and may move through it at walking pace; even through solid rock. Lasts for one turn or until the caster \"surfaces\"." },
{ 9, MODULE_CK, "Elemental Fire"         , "Elemental Fire"         , 42,   0, TRUE , 0                            ,10, "E3", -1     , "[Allows you to conjure a fire elemental to use as your servant for one normal round.]" }, // %% by "normal round", we assume they mean "turn"
{ 9, MODULE_MM, "Fall of Light"          , "Fall of Light"          , 30, 100, FALSE, 0                            , 0, "FA", -1     , "[This spell works only under direct, unobscured sunlight.] It causes a shaft of greatly magnified sunlight to fall upon a 5' radius area. [All flammables will catch fire and] the heat damage to all in the area equals the caster's Intelligence × 10." },
{ 9, MODULE_MM, "Fire Portal"            , "Fire Portal"            , 25,   0, FALSE, 0                            , 0, "FE", -1     , "[Allows the caster to step into one fire and out of another up to five miles away.]" },
{ 9, MODULE_MM, "Ice Merge"              , "Ice Merge"              , 22,   0, FALSE, 0                            ,30, "IM", -1     , "[The caster can become one with a body of ice and move through it at walking speed. Lasts three (ten minute) turns, or until the caster leaves the ice.]" },
{ 9, MODULE_MM, "Living Dead"            , "Living Dead"            , 40,   0, FALSE, 0                            , 0, "LD", -1     , "[This functions exactly like Zombie Zonk, except that the zombies created will last indefinitely.]" },
{ 9, MODULE_MS, "Medusa"                 , "Medusa"                 , 30,  40, FALSE, 0                            , 0, "ME", -1     , "Changes flesh to unliving stone. Can be restored to life with the Pygmalion spell." },
{ 9, MODULE_RB, "Mutatum Mutandorum"     , "Mutatum Mutandorum"     , 26,  20, FALSE, 0                            ,10, "MM", -1     , "Enables you to change others into any form with a Monster Rating no higher than combined prime attributes (as much lower as you wish but not less than 5). Lasts 1-6 turns (caster's option), whereupon being reverts to original form. Any hits taken on MR must be taken proportionately on original CON." },
{ 9, MODULE_RB, "Pygmalion"              , "Pygmalion"              , 28,  40, FALSE, 0                            , 0, "PY", -1     , "Changes stone beings, statues, etc. to living flesh. GM should determine attributes for such, according to the Peters-McAllister chart or Monster Table, if possible." },
{ 9, MODULE_MM, "Seance"                 , "Seance"                 , 25,   0, FALSE, 0                            ,60, "X4", -1     , "[Recalls the ghost of a deceased person if the spirit resides in the Asphodel Fields (not Tarterus or Elysium) (note: in other worlds, this translates to a limitation of only being able to call spirits that are in limbo, not those who have been raised to Heaven or cast into Hell). A particular person may be specified, or a random ghost will come. A cup of blood must be ready for the ghost to consume; it will then converse for up to one hour (the ghost merely refuses to come if there is no blood; these are shades only, with no substance or powers).]" },
{ 9, MODULE_MM, "Watch Stop"             , "Watch Stop"             , 40,  50, FALSE, 0                            ,10, "W7", -1     , "This prevents the target from experiencing any time (and therefore, change) at all. They can be moved like a statue, but their posture, etc., will not change, and they are totally invulnerable as the state of their bodies cannot be altered (as by stabbing or crushing)." },
{ 9, MODULE_MM, "Water Way"              , "Water Way"              , 20,   0, FALSE, 0                            ,60, "W8", -1     , "[Allows the caster to merge with a body of water and move along within it at a rapid (up to 40 mph) speed. Lasts one hour or until the caster exits the water.]" },
{ 9, MODULE_MM, "Weather Master"         , "Weather Master"         , 30,   0, FALSE, 0                            ,20, "W9", -1     , "[The caster may do one of two things: (a) Control what extant weather there is (rain, wind, lightning, etc.) in a limited way for two turns; or (b) command what the weather will be like on the following day (must not be too unseasonal).]" },
{10, MODULE_RB, "Blow Me To..."          , "Blow Me To..."          , 28,   0, FALSE, 0                            , 0, "BT", -1     , "Teleports you and a weight [up to 200#] to any specific place you wish to go. Range limited to world you're on."                                                          }, // -- OT -- 61 --
{10, MODULE_MM, "Dry Up"                 , "Dry Up"                 , 30, 100, FALSE, SPELL_CIRCLE                 , 0, "DY", -1     , "[Completely dehydrates one victim (man-sized or smaller); Strength immediately drops to one, and the victim must receive at least one quart of water for each of the next four hours or will perish. Higher levels double either the size or number of victims allowed.]" },
{10, MODULE_MM, "Ground Grip"            , "Ground Grip"            , 35,   0, FALSE, 0                            ,60, "GR", -1     , "[The caster becomes \"rooted\" to the earth and cannot be moved; lasts for one hour or until dismissed by the caster. However, the caster also becomes of the same consistency as the ground he is standing on; use with caution.]" },
{10, MODULE_MS, "Hellbomb Bursts"        , "Hellbomb Bursts"        , 36, 150, TRUE , SPELL_CIRCLE                 , 0, "HB", -1     , "Disintegrates up to 100 cubic feet of anything. Releases a lot of heat when doing so."                                                                                               }, // -- HB -- 60 *-
{10, MODULE_RB, "Hollow Vision"          , "Hollow Vision"          , 50, 100, FALSE, SPELL_TRIANGLE               ,50, "HV", -1     , "[Like Mirage spell, creates hallucination. Permits movement, auditory senses to be included. Touch will determine unrealness, but will not cause the vision to vanish. Lasts up to 5 turns.]" },
{10, MODULE_MM, "Life Spell #10"         , "Life Spell #10"         , 60, 100, TRUE , 0                            , 0, "LS", -1     , "[The caster must make an L9-SR on LK. If successful, this spell reverses Death Spell #9. The caster of the Death Spell #9 then has to make his L10-SR on LK to keep from dying.]" },
{10, MODULE_RB, "Smaller is Smarter"     , "Smaller is Smarter"     , 33,  50, FALSE, 0                      , ONE_DAY, "SS", -1     , "[Decreases size and value of any creature or object. Roll 1 dice and add 1, then divide current attributes by that number. If a being with Prime Attributes is being decreased, only divide his or her ST, CON, and size. May not be used cumulatively.]" },
{10, MODULE_MM, "Stone Mould"            , "Stone Mould"            , 30,   0, FALSE, 0                            ,60, "SM", -1     , "[The caster may shape stone as if it were soft clay (does not work on magical stone).]" },
{10, MODULE_MM, "Weakling"               , "Weakling"               , 35,  25, TRUE , 0                            , 0, "WK", -1     , "[When cast, your foe's total attack is divided by three.]" },
{11, MODULE_MS, "Bigger is Better"       , "Bigger is Better"       , 33,  50, FALSE, 0                      , ONE_DAY, "BB", -1     , "Increases size and value of any creature or object. Roll one die and add 1, then multiply by that number (if a being with Prime Attributes in enlarged, multiply only ST, CON and size). May not be used cumulatively. Lasts only 1 day." },
{11, MODULE_MM, "Blink"                  , "Blink"                  , 30,   0, FALSE, SPELL_CIRCLE                 , 0, "BK", -1     , "[The caster disappears and reappears in the same spot six seconds later. (If another person is now standing there, he will be pushed aside with great force.) You are actually hurling yourself into the future, but maintaining the same \"coordinates\". This spell can theoretically be cast at higher levels, but it can be suicide to do so. The longer you \"hurl\", the wider you frame of reference for your coordinates will become. Thus instead of being positioned relative to the ground at your feet, you may be positioned relative to the mass of the world (regardless of how it has rotated or moved in the meantime), or even relative to the ether (which may long since have swept past the world).]" },
{11, MODULE_RB, "Blow You To..."         , "Blow You To..."         , 35,  10, FALSE, 0                            , 0, "BY", -1     , "[Allows you to teleport one other person plus a weight of up to 2000 weight units to any place you specify. If the character does not wish to go, he or she should try to make a saving roll on IQ; determine the level of the roll by the difference between the victim's level and that of the caster. (Example: a 12th level magician tries to Blow Away a 4th level character; to prevent this, the 4th level character must make a L8-SR on IQ (55 - IQ).) If the victim consents to being sent, no roll is required. Range limited to the world you are on.]"                                                                                                                                                                   }, // -- OT -- 65 --
{11, MODULE_MM, "Clone Grown"            , "Clone Grown"            , 40,   0, FALSE, 0                 , ONE_DAY * 10, "CG", -1     , "[Limb regeneration. The stump must not have been cauterized, and the spell must be cast within three days of the severing. The limb will require 10 days to fully regrow.]" },
{11, MODULE_RB, "Ghostly Going"          , "Ghostly Going"          , 45,   0, FALSE, 0                            , 0, "GG", -1     , "[Astral projection a la Dr. Strange: Leave your body comatose behind you and roam in an immaterial form, still able to cast spells.]"                                                  }, // -- OT -- 64 --
{11, MODULE_MM, "Holy Hell"              , "Holy Hell"              , 45,   0, FALSE, 0                            , 0, "HH", -1     , "[Traps anyone using a Ghostly Going in the wall or door they try to pass through.]" },
{11, MODULE_MM, "Shadow Valet"           , "Shadow Valet"           , 40,   0, FALSE, 0                      , ONE_DAY, "SV", -1     , "[This calls forth a harmless, invisible spirit that can perform all butler and cook functions for the caster for one full day.]" },
{11, MODULE_MM, "Spontaneous Combustion" , "Spontaneous Combustion" , 40,  80, TRUE , 0                            , 0, "X5", -1     , "[Cause one victim to burst into flames and be instantly reduced to ashes. The target is allowed a SR on IQ at (the caster's level minus their level); if they succeed, they still take damage equal to the caster's IQ and their clothing is on fire.]" },
{11, MODULE_MM, "Stars Out"              , "Stars Out"              , 40,   0, FALSE, SPELL_CIRCLE                 ,60, "SO", -1     , "[Eclipses all starlight and moonlight within one mile of the caster. Higher levels double the radius.]" },
{12, MODULE_MM, "Circle of Binding"      , "Circle of Binding"      , 35,   0, FALSE, 0                            ,60, "CR", -1     , "Create a circle on the ground which will contain any ghosts, demons, undead, etc. that may be lured or conjured into it. Only spirits with an MR greater than (caster's Intelligence × Level) may break free." },
{12, MODULE_MM, "Head Gauge"             , "Head Gauge"             , 40, 100, FALSE, 0                            , 0, "HE", -1     , "[Reveals to the caster the deepest thoughts and inmost motivations of one target. It will reveal demonic possession, psychic control, mental illness, etc.]" },
{12, MODULE_MM, "Instant Burial"         , "Instant Burial"         , 28,  50, TRUE , SPELL_CIRCLE                 , 0, "IU", -1     , "The ground will open up beneath one target [(of up to ogre size)], swallow him and slam shut. Damage done [depends on the ground consistency, but usually] runs 20 to 120[, not to mention suffocation. Higher levels double the number or size of targets]." },
{12, MODULE_MM, "Limbo Trip"             , "Limbo Trip"             , 40,  50, FALSE, 0                            ,30, "LP", -1     , "[Casts one victim into a dimension (plane) of absolute sensory deprivation. Roll 2 dice; on a snake-eyes, he is consumed by the unknown monsters there. Otherwise, he will return to the same spot three turns (30 minutes) later. If he fails an L1-SR on IQ, he will have been driven stark staring looney by the experience. Even the sturdiest of persons usually return screaming and take several minutes to recover.]" },
{12, MODULE_RB, "Nefarious Necromancy"   , "Nefarious Necromancy"   , 60, 150, FALSE, 0                            , 0, "NN", -1     , "[Temporarily restores the dead to life. A person brought back to life this way lives for as many turns as the restorer's Luck rating.]"                                                }, // -- OT -- 67 --
{12, MODULE_MM, "Return Ye"              , "Return Ye"              , 75,   0, FALSE, 0                            , 0, "RY", -1     , "[Returns your body and possessions to your stable. Trigger must be specified (possibilities include: moment of death, 1 hour, first attack, etc.).]" },
{12, MODULE_RB, "Seek Ye"                , "Seek Ye"                , 30,  50, FALSE, 0                            , 0, "SY", -1     , "[May be used to force any sentient being to go on a quest at the wizard's command. GM must agree that the quest is a reasonable one and fulfillable within the conditions specified.]" }, // -- OT -- 68 --
{12, MODULE_MM, "White Out"              , "White Out"              , 40,   0, FALSE, SPELL_BOTH                   ,10, "X6", -1     , "[A blinding blizzard springs up, covering the area within 100' of the caster. All within (except the caster) must make an L3-SR on CON or lose three Dexterity per round to the freezing cold; Lasts one full turn. Higher levels double the radius or the duration.]" },
{12, MODULE_MM, "World Goes By"          , "World Goes By"          , 45,   0, FALSE, 0                  , ONE_DAY / 2, "X7", -1     , "[Reduces the caster's (or another's) time factor by 72. See Speedy Them for the basic effects. The person will experience only 10 minutes of subjective time while the world goes through 12 hours. A person under this spell must be moved very carefully; if, for example, you straightened out their arm, their muscles might not be able to keep up with such \"rapid\" motion and the tendons could snap.]" },
{12, MODULE_MM, "World Stop"             , "World Stop"             , 45,   0, FALSE, 0                            ,10, "X8", -1     , "[Increases the caster's (or another's) time factor by 72. See Speedy Me for the basic effects. The speeded person will live through 12 hours of time in only 10 minutes; to their perception the entire world has stopped dead still. However, at this level the isolation of the altered time factor is a bit blurry and imperfect. Rapid movement can actually cause windburn; hitting something hard can demolish your hand (because it was moving at several hundred mph); and it can take quite a \"long\" time to open a large door (the fraction of a second it takes to overcome the door's inertia).]" },
{13, MODULE_MM, "Aurora"                 , "Aurora"                 , 40,   0, TRUE , 0                            , 2, "AA", -1     , "[The caster gains a prismatic aura; all seeing it must make an L3-SR on LK or be dazzled (halve their combat rolls, double their SR levels, etc.). The caster is immune to spells cast be dazzled opponents and does touch damage equal to Charisma × 1d6.]" },
{13, MODULE_MM, "Brain Repair"           , "Brain Repair"           , 45,   0, FALSE, 0                            , 0, "X9", -1     , "[Heals points of IQ lost due to illness, injury, magic, poison, or monsters. Will restore all lost IQ, but not to a higher total than the caster's IQ.]" },
{13, MODULE_MM, "Door #13"               , "Door #13"               , 75,   0, FALSE, 0                            , 0, "DO", -1     , "[Opens a portal to another plane. (There are no known limits to this spell, except that the other plane must be personally known to the caster. So to open a door to Tarterus, you must first have traveled to Tarterus and returned.)]" },
{13, MODULE_MM, "Fire Storm"             , "Fire Storm"             , 55,   0, TRUE , SPELL_CIRCLE                 , 0, "FM", -1     , "A circular wave of raging flames spreads outward from the caster to a radius of 50', doing (Intelligence × caster's level) damage and igniting everything that might conceivably burn. Higher levels double the damage [or the radius]." },
{13, MODULE_MM, "Ghost Glue"             , "Ghost Glue"             , 60,   0, FALSE, 0                  , ONE_DAY * 7, "GH", -1     , "[Temporarily] binds a ghost [(or the stolen spirit of a living person) into an object. The victim retains consciousness, but cannot employ or exhibit any powers. Lasts one week]." },
{13, MODULE_RB, "Invisible Fiend"        , "Invisible Fiend"        , 50,   0, FALSE, 0                            , 0, "IN", -1     , "[Invokes a demonic fiend with a MR equal to your combined Prime Attributes plus 20. Fights with poisoned teeth and claws unless given a weapon. If the Fiend gets any hits on a character, roll 1 die for every 10 points of CON; the result is the number of turns the character has to obtain a Too-Bad Toxin before dying. The GM should \"play\" the Fiend as devious, treacherous, and double-dealing. Tasks set for an Invisible Fiend should always include bloodletting. Each time the Fiend completes a task, its master must make a L13-SR on CHR (80 - CHR) to avoid attack. If the SR is made, its master can send it away or set another task.]" },
{13, MODULE_MM, "Mole Hole"              , "Mole Hole"              , 50,   0, FALSE, 0                            , 0, "MH", -1     , "[Casts a hole large enough to walk through in a Force Shield on a roll of 1 or 2 on a 1d6 or an Invisible Wall as long as that wall was cast at 13th level or lower.]" },
{13, MODULE_MM, "Summon Ice Demon"       , "Summon Ice Demon"       , 70,   0, FALSE, 0                            ,60, "ID", -1     , "[Summons one Ice Demon that will serve for 1d6 hours. Use an ordinary demon made of ice with an MR of 2d6 × 20.]" },
{13, MODULE_MM, "Summon Kobolds"         , "Summon Kobolds"         , 45,   0, FALSE, 0                            ,10, "KO", -1     , "[Kobolds are minor earth elementals and usually have MRs well below 10. The number appearing (popping out of the ground) will have a total MR not more than the caster's CHR. They will obey the caster's commands for one turn, after which they will return to the ground or seek revenge for being commanded to do something really stupid.]" },
{13, MODULE_RB, "Wizard Speech"          , "Wizard Speech"          , 90, 100, FALSE, 0                            ,60, "WZ", -1     , "[The universal translator. Spell allows whoever it is cast upon to understand, and be understood in, all the High and Low Languages.]" },
{14, MODULE_MM, "Cast Ye Out"            , "Cast Ye Out"            , 60,   0, FALSE, SPELL_CIRCLE                 , 0, "CA", -1     , "[Drives a possessing demon out of its victim (it may then be free to possess another, or attack, etc.). If the demon's MR exceeds the caster's total attributes, or if its Intelligence is greater than the caster's, it will pass from the victim and possess the caster! (That's what higher casting levels are for, they double the above limits.)]" },
{14, MODULE_RB, "Force Shield"           , "Force Shield"           , 42, 100, FALSE, 0                            , 0, "FS", -1     , "[Wall of coloured light that cannot be pentrated by any lower-level magic or weapons. Wizard can shape and move the Force Shield. If a being trapped behind or within one can make a L14-SR on ST or IQ (85 - ST/IQ) (GM's choice), he or she can shatter it.]" },
{14, MODULE_MM, "Master of Corruption"   , "Master of Corruption"   , 50, 100, FALSE, 0                  , ONE_DAY / 2, "MC", -1     , "[The caster can control all ordinary forms of undead, so long as the individual Intelligence does not exceed his own, and the total MR does not exceed (caster's level × (IQ + CHR)).]" },
{15, MODULE_MM, "Demon Binding"          , "Demon Binding"          , 85,   0, FALSE, 0                            , 0, "DB", -1     , "Permanently binds a demon [into an enchanted object; it adds the demon's powers to that object, and the caster can then utilize any of the demon's mystic powers through the object. (Example: an ordinary demon is bound into a sword - the sword gets normal dice, but the regular adds are replaced by the demon's adds, and its attacks are magical.) The demon's proper name must be known and used in the spell]. The victim demon's Intelligence may not exceed the caster's, nor may its MR exceed the caster's (level × Intelligence)." },
{15, MODULE_RB, "Earth, Air, Fire, Water", "Earth, Air, Fire, Water", 42,   0, FALSE, 0                            ,50, "EA", -1     , "[Allows you to conjure an elemental to use as a servant for 5 turns. Its MR will equal the total of your attributes, times two. Elementals can be fought, but can be easily nullified by sending the opposite type against it (fire vs. water, earth vs. air).]" },
{16, MODULE_RB, "Anti-Magic Spell"       , "Anti-Magic Spell"       , 65, 500, FALSE, SPELL_TRIANGLE               ,30, "AM", -1     , "[Can be used selectively to negate and cancel any lower level magic in the wizard's area of view. Lasts 3 turns once set in motion.]" },
{16, MODULE_RB, "Exorcism"               , "Exorcism"               ,  0, 150, FALSE, 0                            , 0, "EX", -1     , "The caster may use this spell to negate the power of the undead. It will dissipate ghosts, slay vampires, withdraw the power of movement from zombies, etc. Works only on undead forms, however. MR should not be revealed prior to spell's use." },
{16, MODULE_MM, "Greater Elements"       , "Greater Elements"       , 68,   0, FALSE, 0                            ,10, "GE", -1     , "[Conjures up a greater Elemental - it will serve for one turn or one task. It will have an MR of (caster's Intelligence × level) and have mystic powers to control its element as appropriate.]" },
{17, MODULE_RB, "Banishing"              , "Banishing"              ,150, 500, FALSE, SPELL_CIRCLE                 , 0, "BN", -1     , "Returns demons, invisible fiends, imps and the like back where they came from. [The Banishing must be at the level of the person who originally summoned the demon, to be effective.]" },
{17, MODULE_RB, "Deluxe Staff"           , "Deluxe Staff"           ,  0,   0, FALSE, 0                            , 0, "DX", -1     , "This is a spell you can't do, folks. You may buy deluxe staves from the Guild (5000 gp), but they are made by a small, very secretive clan of wizards who like their privacy. There is no such thing as \"deluxe staff material\" for weapons or armour." },
{17, MODULE_MM, "Demon Calling"          , "Demon Calling"          ,120,   0, FALSE, 0                            , 0, "DC", -1     , "[As per the Summoning spell, but if the caster makes an Intelligence saving roll, he may specify the type of demon summoned. The level of the saving roll is based on the desired demon's class or level number if it has one, or equals the average MR ÷ 20.]" },
{17, MODULE_RB, "Summoning"              , "Summoning"              ,100,   0, TRUE , 0                            ,60, "SU", -1     , "[Summons a demon with a MR equal to the magician's combined ST, LK, IQ and CHR. If the demon is used simply as a monster, the MR will suffice. If he is used as a character, however, the MR should be distributed among 6 attributes. A demon's form must be specified upong the Summoning, and if he is asked to change form the spell will be broken and the demon will be released. Demons will serve from 1-6 hours (roll 1 die). Demons know and can cast any spell their IQ, DEX and ST will permit them to, but they suffer the same ST loss as a wizard for doing so; however, they recuperate ST at 10/turn.]" },
{18, MODULE_MM, "Demon Dumping"          , "Demon Dumping"          ,165,   0, FALSE, 0                            , 0, "DN", -1     , "A [more powerful] form of Banishing. It will dismiss any demon whose Intelligence is not greater than the caster's, or whose MR is not greater than the caster's (Intelligence × Level). [Bound demons must first be freed in order to be dismissed.]" },
{18, MODULE_RB, "Shatterstaff"           , "Shatterstaff"           , 14, 100, FALSE, 0                            , 0, "SH", -1     , "[Used to destroy deluxe staves. Requires twice the total attributes of the wizard whose staff you are trying to destroy.] To attempt this spell [(with its variable cost)] is fatal if the caster doesn't have the ST to succeed." },
{18, MODULE_RB, "Slyway Robbery"         , "Slyway Robbery"         ,  5, 100, TRUE , 0                            ,10, "SR", -1     , "Enables caster to drain attribute points from a victim and add those points directly to his own (of the same attribute). Only 1 attribute may be affected per spell. If the one drained has a MR instead of attributes, the drain comes off the MR but can only go onto ST or CON (at caster's choice). [Effects last 1-6 turns.] Victim does not get his points back."},
{18, MODULE_RB, "Hidey Soul"             , "Hidey Soul"             , 42,   0, FALSE, 0                            , 0, "HS", -1     , "[Allows wizard to hide his life force in any object, and send his spirit out to take over any weaker living being. Though his vehicle is slain or destroyed, the wizard can only be harmed if the foe finds the receptacle for his life force.]" },
{19, MODULE_RB, "Omniflex"               , "Omniflex"               ,186,   0, FALSE, 0                            , 0, "OF", -1     , "[Permits user to rearrange his own (or another being's) attributes as decided upon, so long as the total of all 6 attributes remains the same (neither higher nor lower). No attribute may be put below 1. ST cost occurs before change.]" },
{19, MODULE_MM, "Soul Snatch"            , "Soul Snatch"            ,150,   0, FALSE, 0                            , 0, "S0", -1     , "[Steals the spirit of one victim (must be within line of sight; or may be up to one mile away if the caster possesses a lock of hair or such). Unless imprisoned or bound, the spirit is immediately free to seek out its body again. If the soul is gone for 21 days, the body will die.]" },
{20, MODULE_RB, "Born Again"             , "Born Again"             ,208,   0, FALSE, 0                            , 0, "BA", -1     , "Allows magic-user to reincarnate himself or another in a new (but pre-prepared) body. [Does not occur where you died. Spell is triggered by personal death. No items or implements follow the spirit body, only attributes, knowledge, and ap.]" },
{ 1, MODULE_DT, "Disfigure"              , "Disfigure"              ,  5,  30, TRUE , 0                            , 0, "D2", -1     , "Allows the caster to make a person's face grow a huge crop of warts and pimples. Reduce Charisma to 4." },
};

/* Unimplemented (rules from MM):
DEMONS: "Demons can also use all human magic up to and including fourth level."
DRAGONS, WORMS & WYVERNS: "Although not usually magic-users themselves, dragons and their relatives
possess a tremendously high IQ, which endows them with a great understanding of sorcery. They are immune to any
spell cast by a character of an IQ lower than their own, and can, if they wish, negate any spell cast by such a
character merely by touching the enchanted object."
{ 2, MODULE_MM, "Premonition"            , "Oh Dread"               ,  3,   0, FALSE, 0                            , 0, "OD", -1     , "Premonition spell. Used to predict the next peril that will threaten you, but does not tell when or where." }, // from Monsters! Monsters! 1st Edition (only)
{13, MODULE_MM, "Summon Ice Demon"       , "Summon Ice Demon"       , 70,   0, FALSE, 0                            ,60, "ID", -1     , "Summons one Ice Demon that will serve for 1d6 hours. (Refer to Demonology School.) Roll a die for which type you get:\n" \
                                                                                                                                       "    1-3    Class I\n    4-5    Class II\n     6     Class III" }, // can't use ][ nor ]|[
*/

EXPORT struct LanguageStruct language[LANGUAGES] = {
{ "Common",         50 }, //  0
{ "Elvish",         60 }, //  1
{ "Dwarvish",       70 }, //  2
{ "Trollish",       73 }, //  3
{ "Orcish",         76 }, //  4
{ "Hobbitish",      79 }, //  5
{ "Giantish",       80 }, //  6
{ "Balrog",         81 }, //  7
{ "Ogrish",         82 }, //  8
{ "Goblin",         83 }, //  9
{ "Gremlin",        84 }, // 10
{ "Dragon",         85 }, // 11
{ "Wizard Speech",  86 }, // 12
{ "Canine",         87 }, // 13
{ "Feline",         88 }, // 14
{ "Serpentine",     89 }, // 15
{ "Avian",          90 }, // 16
{ "Ursine",         91 }, // 17
{ "Bovine",         92 }, // 18
{ "Saurian",        93 }, // 19
{ "Simian",         94 }, // 20
{ "Rodent",         95 }, // 21
{ "Equine",         96 }, // 22
{ "Pachyderm",      97 }, // 23
{ "Porker",         98 }, // 24
{ "Cetacean",       99 }, // 25
{ "Other",         100 }, // 26
{ "Anthelian",     101 }, // 27 SM70
{ "Weasel",        102 }, // 28 DT87
};

EXPORT struct RacesStruct races[RACES] =
{
//  ST   IQ   LK  CON  DEX  CHR  SPD Height  Wt   Humand Undead  Size
{  1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1, 1, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Human"         , "Humans"     , "" }, //  0 HUMAN
{  2,1, 1,1, 1,1, 2,1, 1,1, 1,1, 1,1, 2, 3, 8, 7, TRUE,  FALSE , SIZE_SMALL, "Dwarf"         , "Dwarves"    , "To make a dwarf evil you need only show him enough gold. Dwarves have always been neutrals in fairy wars, with individuals found on both sides. Dwarves are shorter than men, and much stronger than most. They generally have a gnarled and rugged appearance. At home in caves and tunnels, they dislike open spaces, but fear nothing but dragons; this taste is mutual, since dwarves and dragons war constantly for gold." }, //  1 DWARF
{  1,1, 3,2, 1,1, 2,3, 3,2, 2,1, 1,1,11,10, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Elf"           , "Elf"        , "" }, //  2 ELF
{  1,4, 1,1, 3,2, 1,4, 3,2, 2,1, 1,1, 1,10, 1,200,TRUE,  FALSE , SIZE_VSMALL,"Fairy"         , "Fairies"    , "" }, //  3 FAIRY
{  3,4, 1,1, 1,1, 3,4, 3,2, 1,2, 1,1, 3, 4, 3, 4, TRUE,  FALSE , SIZE_SMALL, "Goblin"        , "Goblins"    , "They are manlike, but slightly undersized. Goblins use all manner of human weapons, and display an insatiable craving for fish. They are usually green and scaly, though some have tough leathery hides. They also sport pointy ears and teeth." }, //  8 GOBLIN (on both charts but same for both)
{  1,2, 1,1, 1,1, 2,1, 3,2, 1,1, 1,1, 1, 2, 1, 2, TRUE,  FALSE , SIZE_SMALL, "Hobbit"        , "Hobbits"    , "Small sturdy humanoids with large hairy feet and potbellies, who live in holes in the ground." }, //  4 WHITEHOBBIT
{  1,2, 3,2, 3,2, 1,1, 3,2, 1,1, 1,1, 1, 3, 1, 4, TRUE,  FALSE , SIZE_SMALL, "Leprechaun"    , "Leprechauns", "" }, //  5 LEPRECHAUN
#ifdef AUXILIARY
{  7,1, 1,1, 1,1, 7,1, 1,1, 2,1, 1,1, 4, 1, 8, 1, TRUE,  FALSE , SIZE_HUGE , "Troll"         , "Trolls"     , "Basically rock spirits in human form, trolls are twice human size and much more massive; they are often handsome, in a craggy sort of way. Adept with most weaponry, they prefer maces, warhammers and clubs. Trolls are not always dumb, though few need cultivate strategy in view of their great strength. Their favourite foods are beef and long pig. If struck by direct sunlight, they will turn to stone or gold. However, if they are not smashed or melted down before midnight, they come alive again." }, //  6 TROLL
#else
{  3,1, 1,1, 1,1, 3,1, 1,1, 1,1, 1,1, 2, 1, 4, 1, TRUE,  FALSE , SIZE_HUGE , "Troll"         , "Trolls"     , "Basically rock spirits in human form, trolls are twice human size and much more massive; they are often handsome, in a craggy sort of way. Adept with most weaponry, they prefer maces, warhammers and clubs. Trolls are not always dumb, though few need cultivate strategy in view of their great strength. Their favourite foods are beef and long pig. If struck by direct sunlight, they will turn to stone or gold. However, if they are not smashed or melted down before midnight, they come alive again." }, //  6 TROLL
#endif
{ 25,1, 5,1, 1,2,50,1, 3,1, 2,3, 1,1, 0, 0,50, 1, FALSE, FALSE , SIZE_HUGE , "Dragon"        , "Dragons"    , "A large lizard, usually with batlike wings, and possessed of 2, 4 or 6 sets of claws. Some have lock necks, others resemble alligators. They breathe fire and are nearly indestructible, save for one vulnerable spot. Dragons are extremely intelligent, almost always evil, have a great love for treasure and human virgins, and are immune to spells cast by anyone with an IQ lower than their own." }, //  7 DRAGON
#ifdef AUXILIARY
{  5,1, 1,1, 1,1, 5,1, 1,1, 3,2, 1,1, 2, 1, 3, 1, TRUE,  FALSE , SIZE_HUGE , "Ogre"          , "Ogres"      , "Large, brutish beings, twice the size of a man or larger, they can wield human weapons but prefer crude bludgeons. They are always ugly, featuring such adornments as prominent warts and blemishes. Ogres may have a number of heads, not always with a mere 2 eyes apiece. Usually sullen and stupid, they are distressingly enthusiastic about mutton." }, //  9 OGRE
#else
{  2,1, 1,1, 1,1, 2,1, 1,1, 3,2, 1,1, 3, 2, 2, 1, TRUE,  FALSE , SIZE_HUGE , "Ogre"          , "Ogres"      , "Large, brutish beings, twice the size of a man or larger, they can wield human weapons but prefer crude bludgeons. They are always ugly, featuring such adornments as prominent warts and blemishes. Ogres may have a number of heads, not always with a mere 2 eyes apiece. Usually sullen and stupid, they are distressingly enthusiastic about mutton." }, //  9 OGRE
#endif
{  1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1, 1, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Orc"           , "Orcs"       , "If you want an army of monsters, orcs are the customary cannon fodder. They prefer long, cruelly-curved scimitars. Sunlight hurts and blinds them, but they function well on cloudy days. They often wear armour, and rarely use magic." }, // 10 ORC (on both charts but same for both)
#ifdef AUXILIARY
{ 20,1, 1,1, 1,1,20,1, 1,2, 4,1, 1,1, 5, 1,10, 1, TRUE,  FALSE , SIZE_HUGE , "Giant"         , "Giants"     , "Five times the height and ten times the weight of a man, giants are the most feared of all humanoid monsters. Usually considered loners, they may sometimes be found as heavy support in large armies. They live in tumble-down castles, and are usually rather dull-witted, although a few clever ones have turned up. Smart giants use any and all weapons, generally with devastating effect - dull ones prefer uprooted trees." }, // 11 GIANT
{  3,1, 1,2, 1,1, 2,1, 1,2, 2,1, 1,1, 1, 1, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Werewolf"      , "Werewolves" , "In their human guise these creatures are quite normal, but in their beast forms they gain superhuman strength and near-invulnerability at the cost of half their Intellingence and nearly all their Dexterity. Silver is deadly to them, but ordinary wounds heal with amazing swiftness." }, // 12 WEREWOLF
#else
{  5,1, 1,2, 1,1, 5,1, 1,1, 5,1, 1,1, 5, 1,10, 1, TRUE,  FALSE , SIZE_HUGE , "Giant"         , "Giants"     , "Five times the height and ten times the weight of a man, giants are the most feared of all humanoid monsters. Usually considered loners, they may sometimes be found as heavy support in large armies. They live in tumble-down castles, and are usually rather dull-witted, although a few clever ones have turned up. Smart giants use any and all weapons, generally with devastating effect - dull ones prefer uprooted trees." }, // 11 GIANT
{  5,2, 1,2, 2,3, 3,1, 3,0, 4,1, 1,1, 0, 0, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Werewolf"      , "Werewolves" , "In their human guise these creatures are quite normal, but in their beast forms they gain superhuman strength and near-invulnerability at the cost of half their Intellingence and nearly all their Dexterity. Silver is deadly to them, but ordinary wounds heal with amazing swiftness." }, // 12 WEREWOLF
#endif
{  9,2, 2,1, 1,4, 9,2, 3,2, 5,1, 1,1, 3, 2, 2, 1, TRUE,  FALSE , SIZE_LARGE, "Demon"         , "Demons"     , "Four times the strength of a man, with vaguely reptilian physiognomy, demons come from a different dimension and control powerful magic. To reach our world, demons must be summoned across the dimensional barrier by a mage. A demon may be subdued if it is trapped within a pentagram. Demons may have various individual powers." }, // 13 DEMON
#ifdef AUXILIARY
{  2,1, 1,1, 1,1, 2,1, 1,1, 1,1, 1,1, 1, 1, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Half-Orc"      , "Half-Orcs"  , "A hybrid of orc and human. They are orcish in appearance and behaviour, but are unaffected by sunlight. Those with sufficient Intelligence are strongly drawn to magic."}, // 14 HALFORC
{  2,1, 3,2, 1,1, 5,1, 1,1, 1,1, 1,1, 1, 1, 1, 1, TRUE,  TRUE  , SIZE_LARGE, "Vampire"       , "Vampires"   , "These classic monsters fear holy things, especially silver crosses. Garlic and sunlight do not go down well with them, either. They cannot cross running water under their own power, nor enter a house without once being invited in by a resident. They cannot be permanently killed except by sunlight or a stake through the heart. Special abilities of vampires include the ability to change into either bats or mist and the power to hypnotized any one person at a time of a lower IQ. A vampire's victims, if slain, become vampires themselves, and are the servants of the original vampire." }, // 15 VAMPIRE
{  1,2, 1,1, 1,1, 1,2, 3,2, 1,2, 1,1, 1, 3, 1, 3, TRUE,  FALSE , SIZE_SMALL, "Gremlin"       , "Gremlins"   , "The smallest of humanoid monsters, gremlins have green, scaly skin, tall pointed ears, bulging yellow eyes, and a great fondness for malicious pranks. They are magic-users, albeit of limited power. Their favourite foods are chickens, fish, and lady fingers." }, // 16 GREMLIN
{  3,1, 3,2, 1,1, 2,1, 1,1, 1,1, 1,1, 1, 1, 3, 2, FALSE, FALSE , SIZE_LARGE, "Lamia"         , "Lamias"     , "These beautiful maidens have a peculiar affliction - from the waist down they are huge serpents. They could be called Daughters of Set, but actually resemble more closely the Nagas of Hindu mythology. They may or may not be evil, but tend towards cold-bloodedness." }, // 17 LAMIA
#else
{  3,2, 1,1, 1,1, 3,2, 1,1, 1,1, 1,1, 5, 4, 3, 2, TRUE,  FALSE , SIZE_LARGE, "Half-Orc"      , "Half-Orcs"  , "A hybrid of orc and human. They are orcish in appearance and behaviour, but are unaffected by sunlight. Those with sufficient Intelligence are strongly drawn to magic."}, // 14 HALFORC
{  5,2, 3,2, 3,2, 1,1, 1,1, 1,1, 1,1, 1, 1, 1, 1, TRUE,  TRUE  , SIZE_LARGE, "Vampire"       , "Vampires"   , "These classic monsters fear holy things, especially silver crosses. Garlic and sunlight do not go down well with them, either. They cannot cross running water under their own power, nor enter a house without once being invited in by a resident. They cannot be permanently killed except by sunlight or a stake through the heart. Special abilities of vampires include the ability to change into either bats or mist and the power to hypnotized any one person at a time of a lower IQ. A vampire's victims, if slain, become vampires themselves, and are the servants of the original vampire." }, // 15 VAMPIRE
{  1,2, 1,1, 3,2, 1,2, 1,1, 1,2, 1,1, 1, 3, 1, 3, TRUE,  FALSE , SIZE_SMALL, "Gremlin"       , "Gremlins"   , "The smallest of humanoid monsters, gremlins have green, scaly skin, tall pointed ears, bulging yellow eyes, and a great fondness for malicious pranks. They are magic-users, albeit of limited power. Their favourite foods are chickens, fish, and lady fingers." }, // 16 GREMLIN
{  5,2, 1,1, 1,2, 2,1, 1,1, 2,1, 1,1, 1, 1, 3, 2, FALSE, FALSE , SIZE_LARGE, "Lamia"         , "Lamias"     , "These beautiful maidens have a peculiar affliction - from the waist down they are huge serpents. They could be called Daughters of Set, but actually resemble more closely the Nagas of Hindu mythology. They may or may not be evil, but tend towards cold-bloodedness." }, // 17 LAMIA
#endif
{  2,1, 1,1, 1,1,10,1, 1,3, 4,1, 1,1, 1, 1,10, 1, TRUE,  FALSE , SIZE_LARGE, "Statue"        , "Statues"    , "Just what the name implies: animated stone or metal figures. Chop at them with a sword, and the sword chips. Rather hard to deal with." }, // 18 living STATUE
#ifdef AUXILIARY
{  3,1, 1,2, 1,1, 1,1, 1,1, 1,1, 1,1, 1, 1, 1, 1, TRUE,  TRUE  , SIZE_LARGE, "Ghoul"         , "Ghouls"     , "Vaguely humanoid in appearance, but pallid and shambling, these inhabitants of another plane are famous for their diet of putrefying corpses. They do not use weapons, but rend their victims limb from limb. Ghouls wear no clothing; they have baboonish faces with immense canines and peculiar tufts of hair." }, // 19 GHOUL (Lovecraft)
#else
{  3,1, 1,4, 1,2, 3,1, 1,1, 4,1, 1,1, 2, 3, 1, 1, TRUE,  TRUE  , SIZE_LARGE, "Ghoul"         , "Ghouls"     , "Vaguely humanoid in appearance, but pallid and shambling, these inhabitants of another plane are famous for their diet of putrefying corpses. They do not use weapons, but rend their victims limb from limb. Ghouls wear no clothing; they have baboonish faces with immense canines and peculiar tufts of hair." }, // 19 GHOUL
#endif
{  1,1, 1,1, 3,4, 5,4, 3,2, 3,1, 1,1, 1, 1, 1, 1, FALSE, FALSE , SIZE_LARGE, "Gorgon"        , "Gorgons"    , "Remember Medusa? Snakes for hair, turns people into stone - yeah, that's the one. Typical gorgon. Gorgons can only team up effectively with living statues and rock people; other monsters also tend to petrify." }, // 20 GORGON
{  3,2, 2,3, 1,1, 3,2, 3,0, 2,1, 1,1, 1, 1, 1, 2, FALSE, FALSE , SIZE_LARGE, "Harpy"         , "Harpies"    , "No, not your mother-in-law. Harpiest have female heads and torsoes, but the bodies and talons of large, ferocious birds. They are always hungry." }, // 21 HARPY
{  2,1, 3,0,10,0, 3,1, 3,0, 1,1, 1,1, 1, 1, 1, 1, TRUE,  TRUE  , SIZE_LARGE, "Mummy"         , "Mummies"    , "Wrapped in mouldering linen, filled with malignant purpose, these beings rise from the dead to plague mankind with their superhuman strength. They overcome the superstitious and fear naught save the lighted match." }, // 22 MUMMY
{  2,1, 3,0, 1,4, 3,1, 3,0, 1,1, 1,1, 1, 1, 1, 1, TRUE,  TRUE  , SIZE_LARGE, "Zombie"        , "Zombies"    , "Undead bodies animated by magic, exceptionally hard to destroy, these serve as servants in the netherworld. They cannot think for themselves or use weapons. They have bad luck; if they didn't, they wouldn't be zombies. They can only be re-slain by putting salt on their tongues, but may be effectively destroyed by hacking them into small pieces. Large pieces will continue to obey their last order. Zombies cannot change masters in midgame." }, // 23 ZOMBIE
#ifdef AUXILIARY
{  3,1, 3,2, 1,1, 2,1, 1,1, 1,1, 1,1, 1, 1, 2, 1, FALSE, FALSE , SIZE_LARGE, "Sphinx"        , "Sphinxes"   , "Human heads, shoulders, and chests - but no arms - these creatures have the bodies of lions. They are twice as smart as most men, and are addicted to riddles, but do not use magic." }, // 24 Greek SPHINX (winged)
{  3,1, 1,2, 1,1, 3,1, 3,4, 1,1, 1,1, 5, 4, 3, 2, TRUE,  FALSE , SIZE_LARGE, "Minotaur"      , "Minotaurs"  , "Picture a bovine head on the body of a powerful man or woman. They are flesh-eaters, with bad tempers. Not too bright, but as strong as a bull." }, // 25 MINOTAUR
{ 15,1, 2,1, 1,1,25,1, 2,1, 3,1, 1,1, 3, 1, 4, 1, TRUE,  FALSE , SIZE_HUGE , "Balrog"        , "Balrogs"    , "Imagine a tall black shadow in the shape of a man, wreathed in flames and swinging a whip. They are both magic-users and fighters, and extremely gruesome in their personal habits. Balrogs can command the obedience of dwarves, orcs, half-orcs, and goblins." }, // 26 BALROG
#else
{  3,2, 2,1, 1,1, 1,1, 3,0, 2,1, 1,1, 1, 1, 2, 1, FALSE, FALSE , SIZE_LARGE, "Sphinx"        , "Sphinxes"   , "Human heads, shoulders, and chests - but no arms - these creatures have the bodies of lions. They are twice as smart as most men, and are addicted to riddles, but do not use magic." }, // 24 SPHINX
{  5,2, 3,4, 1,1, 5,2, 3,4, 5,1, 1,1, 5, 4, 3, 2, TRUE,  FALSE , SIZE_LARGE, "Minotaur"      , "Minotaurs"  , "Picture a bovine head on the body of a powerful man or woman. They are flesh-eaters, with bad tempers. Not too bright, but as strong as a bull." }, // 25 MINOTAUR
{ 10,1, 2,1, 1,1, 7,1, 2,1, 5,1, 1,1, 3, 1, 4, 1, TRUE,  FALSE , SIZE_HUGE , "Balrog"        , "Balrogs"    , "Imagine a tall black shadow in the shape of a man, wreathed in flames and swinging a whip. They are both magic-users and fighters, and extremely gruesome in their personal habits. Balrogs can command the obedience of dwarves, orcs, half-orcs, and goblins." }, // 26 BALROG
#endif
{  1,0, 1,1, 2,1, 1,1, 1,0, 4,1, 1,1, 1, 1, 0, 0, TRUE,  TRUE  , SIZE_LARGE, "Ghost"         , "Ghosts"     , "Disembodied spirits of once-living beings. Instead of passing on to the afterlife, they remain in this world, driven by some purpose so desperate they cannot rest (although sometimes they, themselves, have forgotten it). They are immune to material attack, but not to magic." }, // 27 GHOST
{  3,1, 1,1, 1,1, 3,1, 1,1, 1,1, 3,2, 3, 2, 3, 1, FALSE, FALSE , SIZE_LARGE, "Centaur"       , "Centaurs"   , "The bodies of horses, with the heads, arms, and torsos of men. Lusty by name, centaurs are overfond of alcoholic beverages. When sober,they have the gift of healing (a natural Restoration) but are otherwise not usually magicians. Their favourite weapons are spears." }, // 28 CENTAUR (on both charts but same for both)
#ifdef AUXILIARY
{  1,1, 1,1, 1,1, 1,1, 1,1, 2,1, 1,1, 1, 1, 1, 1, TRUE,  TRUE  , SIZE_LARGE, "Skeleton"      , "Skeletons"  , "They are human, but their flesh and internal organs are perfectly transparent - only their bones show. Anthropophagy is one of their less disgusting customs." }, // 29 living SKELETON
{  3,2, 1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1, 1, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Merman"        , "Mermen"     , "Covered with scales, possessing gills, with webbed fingers and toes. They can breathe air, but must remain damp. They throw spears and knives." }, // 30 MERMAN
#else
{  1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1, 1, 1, 1, TRUE,  TRUE  , SIZE_LARGE, "Skeleton"      , "Skeletons"  , "They are human, but their flesh and internal organs are perfectly transparent - only their bones show. Anthropophagy is one of their less disgusting customs." }, // 29 living SKELETON
{  3,2, 5,4, 1,1, 1,1, 3,2, 1,1, 1,1, 1, 1, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Merman"        , "Mermen"     , "Covered with scales, possessing gills, with webbed fingers and toes. They can breathe air, but must remain damp. They throw spears and knives." }, // 30 MERMAN
#endif
{  2,1, 3,0, 1,4,10,1, 3,0, 1,2, 1,1, 2, 1,10, 1, TRUE,  FALSE , SIZE_HUGE , "Slug"          , "Slugs"        , "(or other molluscs) What can you say about a hungry mound of protoplasm with no central nervous system? Unless you have a vast quantity of salt (which dehydrates them), you're in a heap of trouble." }, // 31 giant SLUG
{ 20,1, 5,0, 1,1,50,1, 1,1, 4,1, 1,1, 5, 1,10, 1, TRUE,  FALSE , SIZE_HUGE , "Shoggoth"      , "Shoggoths"    , "Apparently huge, blind, hairy creatures, nearly mindless as we understand the term. Possibly they lead out their strange lives underground, dancing ponderously to the tune of strange piccolos, except when they venture to the surface in search of treasure or new piccolo players." }, // 32 SHOGGOTH
{ 15,1, 5,1, 1,2,25,1, 3,0, 5,1, 1,1, 0, 0,25, 1, FALSE, FALSE , SIZE_HUGE , "Wurm"          , "Wurms"        , "Imagine a dragon without wings and fire, but just as tough, and you have a wurm. It is believed that these saurians metamorphose into dragons; however, since their lifespan must be in the thousands of years, nobody has yet caught one changing. This is the type of 'dragon' St. George thought. Except for the lack of fire, they have the same abilities and limitations." }, // 33 WURM
{  4,1, 6,5, 1,4, 3,1, 3,0, 5,1, 1,1, 4, 3, 9, 2, FALSE, FALSE , SIZE_LARGE, "Chimera"       , "Chimerae"     , "The classic Greek compendia of horrors - lion's head, goat's body, serpent's tail, and wolf's claws. It breathes either fire or poison, and lurks in caves, coming out only to devour sheep and maidens." }, // 34 CHIMERA
{  1,4, 2,1, 1,1, 1,4, 2,3, 1,2, 1,1, 1,10, 1,10, FALSE, FALSE , SIZE_SMALL, "Basilisk"      , "Basilisks"    , "Not fighters, they are still the most poisonous things in the world. Their venomous blood will run up the weapon that pierces them and cause instant mortification, and to look one in the eye will turn you stone. However, if you see the basilisk before it sees you, it will be so angry it will turn to stone itself. A basilisk is a small lizard, hatched from a rooster's egg and raised by a toad on a dungheap, which explains its perversity." }, // 35 BASILISK
{  5,2, 3,4, 1,1, 5,2, 3,0, 2,1, 1,1, 0, 0, 3, 2, FALSE, FALSE , SIZE_LARGE, "Warg"          , "Wargs"        , "Large, malevolently intelligent wolves who made the grade. Goblins sometimes ride them into battle - but only if the wargs want to cooperate." }, // 36 WARG
{  2,1, 1,1, 3,2, 3,1, 3,0, 3,1, 1,1, 1, 1, 2, 1, FALSE, FALSE , SIZE_LARGE, "Unicorn"       , "Unicorns"     , "Beautiful, goat-hooved horses with one spiralled horn. Fierce and wild, they are immortal but susceptible to weapons - their own weapon is the spearlike horn. However, they can be tamed and controlled by a virgin, since they have a self-destructive urge to lay their heads in said virgin's lap." }, // 37 UNICORN
{  3,1, 3,1, 1,2, 5,1, 3,0, 4,1, 1,1, 3, 2, 2, 1, TRUE,  FALSE , SIZE_HUGE , "Wyvern"        , "Wyverns"      , "The \"lesser dragons\". Imagine an eagle with lizards for parents, standing on large hind legs. They do not breathe fire, but enjoy fighting, and are sometimes found as servants or familiars of powerful magic-users." }, // 38 WYVERN
{  2,1, 1,1, 1,2, 1,1, 2,1, 4,1, 1,1, 1, 1, 1, 2, TRUE,  FALSE , SIZE_LARGE, "Spider"        , "Spiders"      , "(or other crawlies) Bigger than regular spiders. *Much* bigger..." }, // 39 giant SPIDER
{ 15,1, 9,0, 1,1, 1,1, 3,0, 5,1, 1,1, 2, 1, 3, 1, TRUE,  FALSE , SIZE_HUGE , "Hydra"         , "Hydrae"       , "Serpents with seven to nine heads. Cut one off, and two take its place, unless the stumps are burned quickly. One head is immortal, too." }, // 40 HYDRA // "Hydras" plural form is also correct
{ 10,1, 1,1, 1,1,10,1, 3,0, 5,1, 1,1, 3, 2, 9, 1, TRUE,  FALSE , SIZE_LARGE, "Griffin"       , "Griffins"     , "The most beautiful of all Greek monsters - not so much evil as above human judgement. A griffin has the head of an eagle, the body of a lion, and magnificant wings. It is four times the size of a lion." }, // 41 GRIFFIN
{  4,1, 3,4, 3,4, 4,1, 3,0, 5,1, 1,1, 4, 3, 2, 1, TRUE,  FALSE , SIZE_LARGE, "Manticore"     , "Manticores"   , "Another classic, with a lion's body, scorpion's tail, and a human face which houses three rows of shark-like teeth." }, // 42 MANTICORE
{  3,1, 1,1, 1,2, 4,1, 3,2, 1,1, 1,1, 1, 1, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Daemon"        , "Daemons"      , "" }, // 43 DAEMON (de Camp)
{  1,1, 1,1, 2,1, 1,1, 1,1, 1,1, 1,1, 1, 1, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Chinese Daemon", "Chinese Daemons", "" }, // 44 DAEMON (Chinese)
{  7,2, 1,2, 1,1, 5,1, 1,2, 3,1, 1,1, 1, 1, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Werebear"      , "Werebears"    , "In their human guise these creatures are quite normal, but in their beast forms they gain superhuman strength and near-invulnerability at the cost of half their Intellingence and nearly all their Dexterity. Silver is deadly to them, but ordinary wounds heal with amazing swiftness." }, // 45 WEREBEAR
{  7,2, 1,2, 1,1, 3,1, 1,2, 3,1, 1,1, 1, 1, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Weretiger"     , "Weretigers"   , "In their human guise these creatures are quite normal, but in their beast forms they gain superhuman strength and near-invulnerability at the cost of half their Intellingence and nearly all their Dexterity. Silver is deadly to them, but ordinary wounds heal with amazing swiftness." }, // 46 WERETIGER
{  1,1, 1,1, 1,1, 1,1, 1,1, 2,1, 1,1, 1, 1, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Youwarkee"     , "Youwarkees"   , "" }, // 47 YOUWARKEE
{  1,1, 1,1, 1,1, 1,2, 1,1, 2,1, 1,1, 1, 1, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Siren"         , "Sirens"       , "" }, // 48 SIREN
{  3,4, 1,1, 1,1, 1,1, 3,2, 1,1, 1,1, 1, 1, 1, 1, FALSE, FALSE , SIZE_LARGE, "Satyr"         , "Satyrs"       , "" }, // 49 SATYR (Faun)
{  1,4, 2,1, 1,1, 1,2, 3,2, 1,1, 1,1, 1, 4, 1, 4, TRUE,  FALSE , SIZE_SMALL, "Imp"           , "Imps"         , "" }, // 50 IMP
// Monsters! Monsters! (MM)
{  1,2, 1,1, 1,1, 2,1, 2,1, 1,1, 1,1, 1, 2, 1, 2, TRUE,  FALSE , SIZE_SMALL, "Black Hobbit"  , "Black Hobbits", "This does not refer to their skin tone, but rather to their political affiliations. They are physically the same as regular hobbits, but are not nice people." }, // 51 BLACKHOBBIT
{  1,4, 3,4, 1,1, 3,1, 1,1, 1,1, 1,1, 1,10, 1,20, TRUE,  FALSE , SIZE_SMALL, "Brownie"       , "Brownies"     , "" }, // 52 BROWNIE
{  1,1, 1,1, 1,1, 1,1, 3,1, 1,1, 2,1, 1, 1, 1, 1, FALSE, FALSE , SIZE_LARGE, "Chinese Fox"   , "Chinese Foxes", "They look like foxes in their own form, but speak to humans, luring them into a trap. A fox will take the shape and knowledge of its victim, and often his/her place in society. The Chinese fox seldom kills its victim, but instead screws up his/her life before letting the human return to face the music." }, // 53 FOX (Chinese)
{  1,1, 3,2, 3,2, 1,1, 3,2, 2,1, 3,2, 2, 3, 1, 2, TRUE,  FALSE , SIZE_LARGE, "Dark Elf"      , "Dark Elves"   , "Just elves who sold out. The black-elven possess all elvish powers, but work for the other side." }, // 54 DARKELF
{  2,1, 1,2, 2,1, 1,1, 1,1, 3,1, 1,1, 1, 1, 1, 1, FALSE, FALSE , SIZE_LARGE, "Elemental"     , "Elementals"   , "The spirits of the basic forms of matter - earth, air, fire and water. They control their own element and may be countered by their opposite elements - earth to air, fire to water. They are shape-changers and may be vulnerable to weapons if in human or near-human form. Not always evil." }, // 55 ELEMENTAL
{  2,3, 3,2, 3,2, 2,1, 1,1, 1,1, 1,1, 2, 3, 2, 3, TRUE,  FALSE , SIZE_SMALL, "Gnome"         , "Gnomes"       , "" }, // 56 GNOME
{  3,1, 1,4, 1,1, 3,1, 1,1, 1,1, 1,1, 1, 1, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Gorilla"       , "Gorillas"     , "" }, // 57 GORILLA (%%: 4x IQ, this must be a misprint!?)
{  3,2, 1,1, 3,4, 3,2, 3,2, 1,2, 1,1, 1, 1, 1, 1, FALSE, FALSE , SIZE_LARGE, "Groxnar"       , "Groxnars"     , "" }, // 58 GROXNAR (%%: what is this? is it humanoid?)
{  3,2, 1,2, 1,1, 2,1, 3,2, 1,2, 1,1,11,10, 3, 2, TRUE,  FALSE , SIZE_LARGE, "Lizard Man"    , "Lizard Men"   , "" }, // 59 LIZARDMAN
{  2,1, 3,1, 1,1, 3,1, 2,1, 1,1, 1,2, 1, 1, 1, 1, FALSE, FALSE , SIZE_LARGE, "Naga"          , "Nagas"        , "" }, // 60 NAGA
{  3,1, 3,1, 7,1, 3,1, 3,1, 1,2, 1,1, 1, 1, 1, 1, FALSE, FALSE , SIZE_SMALL, "Night-Gaunt"   , "Night-Gaunts" , "These creatures are roughly the size of a small eagle, with dead-black rubbery bodies, featureless heads, and long prehensile toes. All this gangly silliness is borne by leathery wings. They prefer to attack en masse, flying off with their prey." }, // 61 GAUNT
{  3,2, 3,4, 1,1, 2,1, 3,4, 1,1, 1,1, 1, 1, 1, 1, TRUE,  FALSE , SIZE_LARGE, "Neanderthal"   , "Neanderthals" , "" }, // 62 NEANDERTHAL aka "Primitive"
{  2,1, 1,1, 1,1, 2,1, 1,1, 1,2, 1,1, 1, 1, 5, 1, TRUE,  FALSE , SIZE_LARGE, "Rock Man"      , "Rock Men"     , "Living stone beings with a silicon metabolism, somewhere between the Yiddish golem and the ever-lovin', blue-eyed Thing. They are immune to most ordinary weapons and Bog and Mire spells, but have musical inclinations." }, // 63 ROCKMAN
{  2,3, 3,2, 1,1, 1,1, 3,2, 1,1, 1,1, 1, 1, 5, 6, TRUE,  FALSE , SIZE_LARGE, "Scurvexi"      , "Scurvexi"     , "" }, // 64 SCURVEXI (%%: what is this? is it humanoid?) Height is meant to be -2" (unimplemented).
{  1,1, 3,2, 1,2, 1,1, 1,1, 3,2, 1,1, 1, 1, 1, 2, TRUE,  FALSE , SIZE_LARGE, "Shadowjack"    , "Shadowjacks"  , "These beings can melt into any shadow - and reappear from any connected shadow. Furthermore, if the shadowjack's own shadow lies across you, none of your magic can affect him. A second-level shadowjack can use all *first*-level human magic, a third-level shadowjack second-level magic, etc. However, although powerful, they are rather noble villains; they are kind to women, only kill in fair fights, etc. However, if you make a personal enemy of a shadowjack, his revenge will be fiendish." }, // 65 SHADOWJACK
{  2,1, 1,2, 1,2, 4,1, 1,1, 4,1, 1,1, 1, 1, 1, 1, FALSE, FALSE , SIZE_LARGE, "Slime Mutant"  , "Slime Mutants", "Sinister clumps of primordial ooze. These are virtually indestructible, though they become immobile if dried out. They prefer the swamps." }, // 66 SLIME (%%: 4x CHR, this must be misprint!?)
{  2,1, 3,2, 1,1, 1,1, 3,1, 1,2, 1,1, 1, 1, 1, 1, FALSE, FALSE , SIZE_LARGE, "Snollygoster"  , "Snollygosters", "No one is sure of their lineage, but they resemble large green four-footed lizards with sharp beaks and a nasty horn protruding from the back of their skull. Occasionally these beings will consent to being mounts for orcs and such. (Contrary descriptions proved to be unfounded rumour...)" }, // 67 SNOLLYGOSTER
{  1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1, 1, 1, 1, FALSE, FALSE , SIZE_LARGE, "Snark"         , "Snarks"       , "Lewis Carroll's hunters never caught him - because this cop-out can take the shape and abilities of any other monster on this list with a Strength multiplier of 3 or less. It can only change shape once per turn." }, // 68 SNARK (polymorphism is not implemented)
{  2,3, 1,1, 1,1, 2,3, 2,1, 2,1, 1,1, 2, 3, 1, 2, TRUE , FALSE , SIZE_LARGE, "Sylvan Elf"    , "Sylvan Elves" , "" }, // 69 SYLVANELF
{  1,1, 2,1, 1,1, 2,1, 3,0, 2,1, 1,1, 1, 1, 1, 1, FALSE, FALSE , SIZE_LARGE, "Wolf"          , "Wolves"       , "" }, // 70 WOLF
{  4,1, 5,1, 2,1, 4,1, 1,1, 1,1, 2,1, 3, 2, 2, 1, FALSE, FALSE , SIZE_HUGE , "Yeti"          , "Yetis"        , "These may be Ramapithecus Gigantus or only wandering snow apes, but they are vested with extraordinary luck, being about the only monsters still on active duty even in the real world." }, // 71 YETI
// non-rulebook
{  1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1, 1, 1, 1, FALSE, FALSE , SIZE_LARGE, "Animal"        , "Animals"      , "" }, // 72 miscellaneous ANIMALs
{  1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1, 1, 1, 1, FALSE, TRUE  , SIZE_LARGE, "Undead"        , "Undead"       , "" }, // 73 miscellaneous UNDEAD
{  1,1, 1,1, 1,1, 1,2, 1,1, 1,1, 1,1, 1, 1, 1, 1, FALSE, FALSE , SIZE_LARGE, "Other"         , "Others"       , "" }, // 74 anything OTHER
{  1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 1, 1, 1, 1, FALSE, FALSE , SIZE_HUGE , "Phoenix"       , "Phoenixes"    , "" }, // 75 PHOENIX. %%: size is just a guess
// T&T Character Generator
{  5,1, 1,2, 1,1, 5,1, 1,1, 2,1, 3,2, 5, 1,10, 1, TRUE , FALSE , SIZE_HUGE , "Cyclops"       , "Cyclopes"     , "" }, // 76 CYCLOPS
{  1,1, 5,4, 1,1, 5,6, 5,4, 3,2, 1,1,21,20, 1, 1, TRUE , FALSE , SIZE_LARGE, "Half-Elf"      , "Half-Elves"   , "" }, // 77 HALFELF
{  3,4, 2,1, 1,1, 3,4, 3,2, 5,1, 1,1, 1, 1, 1, 1, TRUE , FALSE , SIZE_LARGE, "Succubus"      , "Succubi"      , "" }, // 78 SUCCUBUS
{  2,1, 1,2, 1,1, 2,1, 1,2, 3,1, 1,1, 5, 6, 3, 4, TRUE , FALSE , SIZE_LARGE, "Wererat"       , "Wererats"     , "" }, // 79 WERERAT
//  ST   IQ   LK  CON  DEX  CHR  SPD Height  Wt   Humand Undead
};

EXPORT struct SpellInfoStruct spellinfo[20 + 1] =
{    0,  0,    0, //  0
    10,  8,    0, //  1
    12,  9,  500, //  2
    14, 10, 1000, //  3
    16, 11, 1500, //  4
    18, 12, 2000, //  5
    20, 13, 2500, //  6
    22, 14, 3000, //  7
    24, 15, 3500, //  8
    26, 16, 4000, //  9
    28, 17, 4500, // 10
    30, 18, 5000, // 11
    32, 19, 5500, // 12
    34, 20, 6000, // 13
    36, 21, 6500, // 14
    38, 22, 7000, // 15
    40, 23, 7500, // 16
    42, 24, 8000, // 17
    44, 25, 8500, // 18
    46, 26, 9000, // 19
    48, 27, 9500  // 20
};

EXPORT struct ModuleInfoStruct moduleinfo[MODULES] = {
   { 0,         0,  0, TRUE , "RB", "RULEBOOK"                , "" },
   { AB_ROOMS,  0,  0, FALSE, "AB", "ABYSS"                   , "Where only the dead may enter: Abyss is based on medieval Christian mythology, and also owes a large debt to the structure of the ancient Greek underworld. Treasures are usually found in groups of seven, and evil fortune occurs in patterns of three. The foremost quality of the Abyss is a propensity for illusion - the masters Hermes and Hephaistos enjoy deception..." },
   { AS_ROOMS, 17,  0, FALSE, "AS", "AMULET OF THE SALKTI"    , "Deep beneath your home town of Freegore, cloaked in perpetual darkness, past bloody and merciless guardians, lies the Amulet of the Salkti, the only talisman that will avert the evil of the risen demon, Sxelba the Slayer! Will you be able to find it before Sxelba lays all to waste?" },
   { AK_ROOMS,  0, 20, FALSE, "AK", "ARENA OF KHAZAN"         , "Khazan, City of Death, where the dark sands of the arena are saturated with the blood of slick swordsmen and crafty magicians, where men are forced to battle inhuman hordes of Orcs, Trolls, Dwarves and Ogres under the cold eyes of Khazan's merciless ruler, Khara Khang. Will you survive to win fame and fortune where others have perished?" },
   { BS_ROOMS,  0,  0, FALSE, "BS", "BEYOND THE SILVERED PANE", "Step through the enchanted Mirror of Marcelanius and enter a world ruled by magic and strife! Barter or battle with dragons, living statues, bandits and behemoths - will you fulfill your quest or be vanquished by your foes?" },
   { BW_ROOMS,  0,  0, TRUE , "BW", "BEYOND THE WALL OF TEARS", "" },
   { BF_ROOMS,  6,  0, FALSE, "BF", "BLUE FROG TAVERN"        , "Little did you know when you came across the inn standing at a crossroads by a dark wood that you would be plunged into a bitter struggle within minutes of entering: first there was the fight between an outcast Troll and a blue-eyed rock demon, next sinister red-robed priests burst in carrying deadly rune staffs glowing with occult energy...: if this is only the *beginning* of your adventure, what are the chances of your survival?" },
   { BC_ROOMS, 11,  0, FALSE, "BC", "BUFFALO CASTLE"          , "" },
   { CD_ROOMS, 11,  0, FALSE, "CD", "CAPTIF D'YVOIRE"         , "Taken by surprise, you have been chained up and left to rot in a filthy cell deep in the castle d'Yvoire - you have only your wits with which to escape your sinister jailers! You will need to battle past the guards to face the dark forces rallied by the evil Duke. Fight them or remain forever in the dank dungeons of the castle!" },
   { CA_ROOMS,  0,  0, FALSE, "CA", "CARAVAN TO TIERN"        , "" },
   { CI_ROOMS,  0,  0, FALSE, "CI", "CIRCLE OF ICE"           , "" },
   { CT_ROOMS, 10,  0, FALSE, "CT", "CITY OF TERRORS"         , "Terror has a name: the City of Gull where you will come face to face with a thousand Orcs in the city sewers, where you will meet Cronus the Steward of Time in his marbled hall, where you will grip the deadly vampire sword and do battle with the taloned Stalker, where you will armwrestle in the Black Dragon Tavern over scorpions, where you will barter with Marek the Master Rogue: The City of Terrors, *where just walking in the streets is an adventure*!" },
   { DD_ROOMS, 11, 11, FALSE, "DD", "DARGON'S DUNGEON"        , "" },
   { DT_ROOMS, 39,  0, FALSE, "DT", "DARK TEMPLE"             , "" },
   { DE_ROOMS,  0,  0, FALSE, "DE", "DEATHTRAP EQUALIZER"     , "Designed by a death-dealing madman in the City of Khosht, the Deathtrap Equalizer is reached through a teleport gate that will plunge you into a hundred different adventures! Are you clever enough to survive your trip?" },
   { EL_ROOMS,  0,  0, FALSE, "EL", "ELVEN LORDS"             , "" },
   { GK_ROOMS,  0,  0, FALSE, "GK", "GAMESMEN OF KASAR"       , "The Proclamation has gone out, daring you to enter the dungeons of Kasar. You will win your weight in gold if you battle through to the end of it, but are you fast enough to dodge razor-sharp blades, quick enough to evade the fangs of giant serpents and brave enough to pass through the Gauntlet of Doom?" },
   { GL_ROOMS,  0,  0, FALSE, "GL", "GOBLIN LAKE"             , "Knee-deep in chill water, the goblin squeezed through the small rock cleft that led to the underground caverns of his kinfolk. He seeks the legendary Goblin Lake, and the possibility ofpersonal gain is never far from his tiny mind. Hitching his lizardskin loincloth higher on his scaly hip with a final grunt, he slips past the slimed rocks barring his way, to step quietly into the vast caves.\n  Death or wealth, base slavery or power beyond all imagination - who can tell what lies ahead for those who venture into Goblin Lake? This at least is certain: while life remains, adventure beckons!" },
   { HH_ROOMS,  0,  0, FALSE, "HH", "HELA'S HOUSE OF DARK DELIGHTS"         , "" },
   { IC_ROOMS,  0,  0, FALSE, "IC", "SOLO FOR THE INTELLECTUALLY CHALLENGED", "" },
   { LA_ROOMS, 12,  0, FALSE, "LA", "LABYRINTH"               , "" },
   { MW_ROOMS,  0,  0, FALSE, "MW", "MISTYWOOD"               , "You are on the run from Kasar, accused of killing the Grand Duke's son; nothing would have made you stop at the village of Bumley on the edge of the evil and legend-haunted Mistywood apart from the onset of dark night and extreme hunger. You wake from a nightmare in which a hideous dog-faced demon had been chasing you through mist-wreathed woods. An eerie howling shatters the quiet of the night. It comes from Mistywood: will you enter it tomorrow or allow your pursuers to catch up with you and return you for execution?" },
   { ND_ROOMS, 11,  0, FALSE, "ND", "NAKED DOOM"              , "Although innocent, the courts have condemned you to the catacombs beneath the city...a fate to which many would have preferred death at the executioner's hand! Will you fall prey to the terrifying monsters that lurk below - or will you be able to make your way back to the light of day and freedom?" },
   { NS_ROOMS,  0,  0, FALSE, "NS", "NEW SORCERER SOLITAIRE"  , "" },
   { OK_ROOMS, 11,  0, FALSE, "OK", "OVERKILL"                , "" },
   { RC_ROOMS,  0,  0, FALSE, "RC", "RED CIRCLE"              , "" },
   { SM_ROOMS,  0,  0, FALSE, "SM", "SEA OF MYSTERY"          , "" },
   { SO_ROOMS, 11, 11, FALSE, "SO", "SEWERS OF OBLIVION"      , "" },
   { SS_ROOMS,  0,  0, FALSE, "OS", "OLD SORCERER SOLITAIRE"  , "" },
   { SH_ROOMS, 18,  0, FALSE, "SH", "SWORD FOR HIRE"          , "Word is around that Mongo the Wizard is looking for a Sword for Hire; the tower that he has recently acquired has a basement full of dangerous monsters and cunning traps. All you have to do is make your way through the intricate maze beneath the ground and find an exit. Will you win the magic sword that Mongo is offering you to complete your mission?" },
   { TC_ROOMS,  6,  0, TRUE , "TC", "TROLLSTONE CAVERNS"      , "" },
   { WW_ROOMS,  0,  0, FALSE, "WW", "WEIRDWORLD"              , "" },
   { WC_ROOMS,  0,  0, FALSE, "WC", "WHEN THE CAT'S AWAY"     , "" },
};

EXPORT const int races_table[37] = {
DRAGON,
GOBLIN,
OGRE,
ORC,
TROLL,
GIANT,
WEREWOLF,
DEMON,
HALFORC,
VAMPIRE,
GREMLIN,
LAMIA,
STATUE,
GHOUL,
GORGON,
HARPY,
MUMMY,
ZOMBIE,
SPHINX,
MINOTAUR,
BALROG,
GHOST,
CENTAUR,
SKELETON,
MERMAN,
SLUG,
SHOGGOTH,
WURM,
CHIMERA,
BASILISK,
WARG,
UNICORN,
WYVERN,
SPIDER,
HYDRA,
GRIFFIN,
MANTICORE,
};
