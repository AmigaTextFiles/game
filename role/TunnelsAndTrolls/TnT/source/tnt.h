#define DECIMALVERSION    "4.53"
#define INTEGERVERSION    "4.53"
#define VERSIONBYTE       72 // means V4.51+
#define VERSIONSTRING     "\0$VER: TnT " INTEGERVERSION " (6.3.2025)" // always d.m.yyyy format
#define RELEASEDATE       "6 March 2025" // full month
#define COPYRIGHT         "© 2008-2025 James Jacobs of Amigan Software"
#define TITLEBARTEXT      "T&T " DECIMALVERSION

#define ABILITIES         (169 + 1) // 0..ABILITIES-1
#define ITEMS             (950 + 1)
#define MONSTERS          (663 + 1)

#define OC                openconsole()
#define AGENOW            (age + (minutes / ONE_YEAR))
#define HOURNOW           ((minutes % ONE_DAY) / 60)

#define MISCPIX           42

#define DICEY             13 // rows of dice imagery

#define EMPTY            (-1)
#define GRE                0
#define THB                1 // two-handed broadsword
#define HAN                2 // hand-and-a-half sword
#define BRO                3
#define GLA                4
#define SHO                5 // short sword
#define GRA                6 // grand shamsheer
#define GRS                7 // great shamsheer
#define FAL                8
#define SCI                9
#define SAB               10
#define SSB               11 // Short SaBre
#define FLA               12
#define RAP               16
#define SWC               19 // SWord Cane
#define EST               21
#define DOU               22 // double bladed axe
#define GRX               23 // great axe
#define BRA               25 // broadaxe
#define HAT               29 // hatchet
#define BEC               30
#define PIC               33 // pick axe
#define HEM               34 // heavy mace
#define WAR               35 // war hammer
#define HEA               37 // heavy flail
#define LIG               38 // light flail
#define CLU               40
#define PTH               42 // PiTon Hammer
#define POL               44 // poleaxe
#define HAB               47 // halbard
#define PIK               48 // pike
#define PIL               59 // pilum
#define SPE               64
#define JAV               66
#define SAX               68
#define KUK               69
#define HAL               71
#define BAN               72
#define KRI               74
#define JAM               75 // jambiya
#define DRK               76 // DIR is reserved
#define MIS               77 // misericorde
#define MAG               78 // main gauche
#define PON               79
#define STI               81 // stiletto
#define CRA               82 // cranequin
#define CRO               84 // crossbow
#define PRD               87 // prodd
#define QUR               88 // quarrel
#define STO               89 // stone
#define XSB               90 // extra-heavy self bow
#define LSB               93 // light self bow
#define VSB               94 // very light self bow
#define MLB              112 // medium longbow
#define BOW              MLB
#define ARR              113 // arrow
#define DAR              120 // dart
#define QUA              125 // quarterstaff
#define PLA              128
#define MAI              129
#define LAM              130
#define SCA              131
#define RIN              132
#define LEA              133
#define QUI              134
#define CUI              135 // cuirass
#define ADB              136 // arming doublet
#define JER              137 // leather jerkin
#define CAP              142 // steel cap
#define TOW              144 // tower shield
#define KNI              145 // knight's shield
#define TAR              146 // target shield
#define BUC              147 // buckler
#define VIK              148 // Viking spike shield
#define MAD              149 // madu
#define CLO              150 // warm dry clothing & pack
#define PRO              151 // provisions
#define DEP              152 // delver pack
#define TOR              153 // torch
#define SIL              154 // silk rope
#define ROP              155 // hemp rope
#define LAN              156 // LANtern
#define OIL              157 // flask of OIL
#define COM              158 // magnetic COMpass
#define KNE              159 // KNEe-high boots
#define CAL              160 // CALf-high boots
#define SAN              161 // SANdals
#define PIT              162 // PITon
#define ORD              163 // ORDinaire staff
#define ORQ              164 // ORdinaire Quarterstaff
#define DEL              165 // DELuxe staff
#define MAK              166 // MAKeshift staff
#define CUR              373 // CURare
#define SPI              374 // SPIder venom
#define DRA              375 // DRAgon's venom
#define JUI              376 // hellfire JUIce
#define POW              386 // black POWder

#define ITEM_BS_UWTORCH    187
#define ITEM_DE_PEARL      193
#define ITEM_AS_SKULL      414
#define ITEM_AS_ROBE       430
#define ITEM_AS_SDELUXE    436
#define ITEM_SO_HORSE      559
#define ITEM_OK_DELUXER    622
#define ITEM_CI_SLINGSTONE 793
#define ITEM_CI_CRYSTAL    796
#define ITEM_IC_LANTERN    812
#define ITEM_HH_DIRK       819
#define ITEM_GK_CDELUXE    832
#define ITEM_NS_HOMUNCULUS 839
#define ITEM_BW_DELUXEI    872

#define ITEM_DT_RATIONS    875
#define ITEM_DT_KEY        876
#define ITEM_DT_MAP        877
#define ITEM_DT_ROBE       882

#define CORGI
// whether to use Corgi or Flying Buffalo for non-censorship-related issues

// #define CENSORED
// whether to use Corgi censored versions or Flying Buffalo uncensored versions

#ifdef AMIGA
    #define MAX_PATH       256 // that's all that's supported by OS3
#endif
#ifndef TRUE
    #define TRUE (~0)
#endif
#define MODULE static
#define PERSIST static
#define EXPORT
#define IMPORT extern
#define TRANSIENT auto
#define acase break; case
#define adefault break; default
#define DISCARD (void)
#define elif else if
#define EOS '\0'
typedef signed char FLAG;
#define FALSE 0
#define USED
#define ENDOF(x) &x[strlen(x)]

#ifdef AMIGA
    #ifndef EXEC_TYPES_H
        #include <exec/types.h>
    #endif
    #ifdef __MORPHOS__
        #if EXIT_FAILURE == 1
            #undef  EXIT_FAILURE
            #define EXIT_FAILURE 20
        #endif
    #else
        #define EXIT_SUCCESS  0
        #define EXIT_FAILURE 20
    #endif
#else
    typedef char*          STRPTR;
    typedef unsigned char  UBYTE;
    typedef unsigned short UWORD;
    typedef unsigned long  ULONG;
    typedef unsigned char  TEXT;
#endif
typedef signed char        SBYTE;
typedef signed short       SWORD;
typedef signed long        SLONG;

#define LF              10
#define CR              13

#define WARRIOR          0
#define WIZARD           1
#define WARRIORWIZARD    2
#define ROGUE            3
#define CLASSES          4

// player races
#define HUMAN            0
#define DWARF            1
#define ELF              2
#define FAIRY            3
#define GOBLIN           4
#define WHITEHOBBIT      5
#define LEPRECHAUN       6
#define TROLL            7
// NPC races
#define DRAGON           8
#define OGRE             9
#define ORC             10
#define GIANT           11
#define WEREWOLF        12
#define DEMON           13
#define HALFORC         14
#define VAMPIRE         15
#define GREMLIN         16
#define LAMIA           17
#define STATUE          18
#define GHOUL           19
#define GORGON          20
#define HARPY           21
#define MUMMY           22
#define ZOMBIE          23
#define SPHINX          24
#define MINOTAUR        25
#define BALROG          26
#define GHOST           27
#define CENTAUR         28
#define SKELETON        29
#define MERMAN          30
#define SLUG            31
#define SHOGGOTH        32
#define WURM            33
#define CHIMERA         34
#define BASILISK        35
#define WARG            36
#define UNICORN         37
#define WYVERN          38
#define SPIDER          39
#define HYDRA           40
#define GRIFFIN         41
#define MANTICORE       42
#define DAEMON1         43
#define DAEMON2         44
#define WEREBEAR        45
#define WERETIGER       46
#define YOUWARKEE       47
#define SIREN           48
#define SATYR           49
#define IMP             50
#define BLACKHOBBIT     51
#define BROWNIE         52
#define FOX             53
#define DARKELF         54
#define ELEMENTAL       55
#define GNOME           56
#define GORILLA         57
#define GROXNAR         58
#define LIZARDMAN       59
#define NAGA            60
#define GAUNT           61
#define NEANDERTHAL     62
#define ROCKMAN         63
#define SCURVEXI        64
#define SHADOWJACK      65
#define SLIME           66
#define SNOLLYGOSTER    67
#define SNARK           68
#define SYLVANELF       69
#define WOLF            70
#define YETI            71
#define ANIMAL          72
#define UNDEAD          73
#define OTHER           74
#define PHOENIX         75
#define CYCLOPS         76
#define HALFELF         77
#define SUCCUBUS        78
#define WERERAT         79
#define RACES           80
EXPORT struct RacesStruct
{   const UBYTE  st1,  st2,
                 iq1,  iq2,
                 lk1,  lk2,
                 con1, con2,
                 dex1, dex2,
                 chr1, chr2,
                 spd1, spd2,
                 ht1,  ht2,
                 wt1,  wt2;
    const FLAG   humanoid,
                 undead;
    const UBYTE  size;
    const STRPTR singular,
                 plural,
                 desc;
};

#define MALE             0
#define FEMALE           1
#define THING            2

#define EXITS            8

#define QUARTZ           0
#define ENAMEL           1
#define TOPAZ            2
#define GARNET           3
#define TURQUOISE        4
#define AMETHYST         5
#define IVORY            6
#define CARNELIAN        7
#define OPAL             8
#define FIREOPAL         9
#define AQUAMARINE      10
#define JADE            11
#define SERPENTINE      12
#define PEARL           13
#define RUBY            14
#define SAPPHIRE        15
#define DIAMOND         16
#define EMERALD         17

// this is for creatures in missile combat
#define SIZE_TINY        0
#define SIZE_VSMALL      1
#define SIZE_SMALL       2
#define SIZE_AVERAGE     3
#define SIZE_LARGE       4
#define SIZE_LARGER      5
#define SIZE_VLARGE      6
#define SIZE_HUGE        7

#define JEWELLEDITEM_JEWEL    0
#define JEWELLEDITEM_NECKLACE 1
#define JEWELLEDITEM_HEADGEAR 2
#define JEWELLEDITEM_BRACELET 3
#define JEWELLEDITEM_RING     4
#define JEWELLEDITEM_BELT     5
#define JEWELLEDITEM_WEAPON   6 // not supported

#define SETTING_NONE          0
#define SETTING_LEATHER       1
#define SETTING_COPPER        2
#define SETTING_BRONZE        3
#define SETTING_IRON          4
#define SETTING_SILVER        5
#define SETTING_GOLD          6
#define SETTING_STEEL         7 // not supported

#define LIGHT_NONE            0
#define LIGHT_TORCH           1
#define LIGHT_LANTERN         2
#define LIGHT_WO              3
#define LIGHT_CE              4
#define LIGHT_UWTORCH         5
#define LIGHT_CRYSTAL         6

#define NONWEAPON        0
#define WEAPON_SWORD     1
#define FIRSTWEAPON      WEAPON_SWORD
#define WEAPON_HAFTED    2
#define WEAPON_POLE      3
#define WEAPON_SPEAR     4
#define WEAPON_DAGGER    5
#define WEAPON_BOW       6
#define WEAPON_XBOW      7
#define WEAPON_POWDER    8
#define WEAPON_SLING     9
#define WEAPON_THROWN   10
#define WEAPON_STAFF    11
#define WEAPON_GUNNE    12
#define WEAPON_ARROW    13
#define WEAPON_STONE    14
#define WEAPON_OTHER    15
#define WEAPON_QUARREL  16
#define WEAPON_DART     17
#define WEAPON_BLOWPIPE 18
#define LASTWEAPON      WEAPON_QUARREL
#define ARMOUR_COMPLETE 19
#define ARMOUR          ARMOUR_COMPLETE
#define SHIELD          20
#define POTION          21
#define RING            22
#define SLAVE           23
#define POISON          24
#define JEWEL           25
#define ARMOUR_ARMS     26
#define ARMOUR_HEAD     27
#define ARMOUR_LEGS     28
#define ARMOUR_CHEST    29
#define ITEMCATEGORIES  30

#define LANG_COMMON      0
#define LANG_ELF         1
#define LANG_DWARF       2
#define LANG_TROLL       3
#define LANG_ORC         4
#define LANG_HOBBIT      5
#define LANG_GIANT       6
#define LANG_BALROG      7
#define LANG_OGRE        8
#define LANG_GOBLIN      9
#define LANG_GREMLIN    10
#define LANG_DRAGON     11
#define LANG_WIZARD     12
#define LANG_DOG        13
#define LANG_CAT        14
#define LANG_SNAKE      15
#define LANG_BIRD       16
#define LANG_BEAR       17
#define LANG_CATTLE     18
#define LANG_DINOSAUR   19
#define LANG_APE        20
#define LANG_RAT        21
#define LANG_HORSE      22
#define LANG_ELEPHANT   23
#define LANG_PIG        24
#define LANG_DOLPHIN    25
#define LANG_OTHER      26
#define LANG_ANTHELIAN  27
#define LANG_WEASEL     28
#define LANGUAGES       29

#define SPELL_CIRCLE      1 // %01
#define SPELL_TRIANGLE    2 // %10
#define SPELL_BOTH      (SPELL_CIRCLE | SPELL_TRIANGLE) // 3 (%11)

#define MAX_MONSTERS    50 // max. simultaneous enemies

#define MODULE_RB        0 // RuleBook
#define MODULE_AB        1 // Abyss
#define MODULE_AS        2 // Amulet of the Salkti
#define MODULE_AK        3 // Arena of Khazan
#define MODULE_BS        4 // Beyond the Silvered Pane
#define MODULE_BW        5 // Beyond the Wall of Tears
#define MODULE_BF        6 // Blue Frog Tavern
#define MODULE_BC        7 // Buffalo Castle
#define MODULE_CD        8 // Captif d'Yvoire
#define MODULE_CA        9 // Caravan to Tiern
#define MODULE_CI       10 // Circle of Ice
#define MODULE_CT       11 // City of Terrors
#define MODULE_DD       12 // Dargon's Dungeon
#define MODULE_DT       13 // Dark Temple
#define MODULE_DE       14 // Deathtrap Equalizer
#define MODULE_EL       15 // Elven Lords
#define MODULE_GK       16 // Gamesmen of Kasar
#define MODULE_GL       17 // Goblin Lake
#define MODULE_HH       18 // Hela's House of Dark Delights
#define MODULE_IC       19 // Solo for Spastics
#define MODULE_LA       20 // Labyrinth
#define MODULE_MW       21 // Mistywood
#define MODULE_ND       22 // Naked Doom
#define MODULE_NS       23 // New Sorcerer Solitaire
#define MODULE_OK       24 // Overkill
#define MODULE_RC       25 // Red Circle
#define MODULE_SM       26 // Sea of Mystery
#define MODULE_SO       27 // Sewers of Oblivion
#define MODULE_OS       28 // Old Sorcerer Solitaire
#define MODULE_SS       MODULE_OS
#define MODULE_SH       29 // Sword for Hire
#define MODULE_TC       30 // Trollstone Caverns
#define MODULE_WW       31 // Weirdworld
#define MODULE_WC       32 // When the Cat's Away
#define MODULES         33 // (0..MODULES-1): ie. this includes the RuleBook
#define MODULE_MS       34 // "Mini rules from Solos" (ie. the abbreviated rules included with Corgi solos)
#define MODULE_MM       35 // Monsters! Monsters! 4th Edition
#define MODULE_CK       36 // Crusaders of Khazan

#define AB_ROOMS   ( 57 + 1)
#define AS_ROOMS   (210 + 1)
#define AK_ROOMS   (193 + 1)
#define BS_ROOMS   (225 + 1)
#define BW_ROOMS   (320 + 1)
#define BF_ROOMS   (175 + 1)
#define BC_ROOMS   (116 + 1)
#define CD_ROOMS   (200 + 1)
#define CA_ROOMS   (316 + 1)
#define CI_ROOMS   ( 69 + 1)
#define CT_ROOMS   (233 + 1)
#define DD_ROOMS   (165 + 1)
#define DT_ROOMS   (413 + 1)
#define DE_ROOMS   (192 + 1)
#define EL_ROOMS   (253 + 1)
#define GK_ROOMS   (213 + 1)
#define GL_ROOMS   ( 79 + 1)
#define HH_ROOMS   ( 57 + 1)
#define IC_ROOMS   ( 40 + 1)
#define LA_ROOMS   (171 + 1)
#define MW_ROOMS   (143 + 1)
#define ND_ROOMS   ( 73 + 1)
#define NS_ROOMS   (232 + 1)
#define OK_ROOMS   (135 + 1)
#define RC_ROOMS   (214 + 1)
#define SM_ROOMS   (159 + 1)
#define SO_ROOMS   (219 + 1)
#define SS_ROOMS   (225 + 1)
#define SH_ROOMS   (157 + 1)
#define TC_ROOMS   ( 18 + 1)
#define WW_ROOMS   (168 + 1)
#define WC_ROOMS   (260 + 1)
#define MOST_ROOMS DT_ROOMS
// 5732 paragraphs total (5700 if not counting paragraph #0)!

#define money ((gp * 100) + (sp * 10) + cp) // in cp

// engine.c
EXPORT FLAG madeit(int throwlevel, int stat);
EXPORT FLAG saved(int throwlevel, int stat);
EXPORT int madeitby(int throwlevel, int stat);
EXPORT int misseditby(int throwlevel, int stat);
EXPORT void getsavingthrow(FLAG you);
EXPORT int dice(int number);
EXPORT int anydice(int number, int dicetype);
EXPORT void fight(void);
EXPORT void save_man(void);
EXPORT FLAG give(int which);
EXPORT void give_multi(int which, int amount);
EXPORT void give_multi_always(int which, int amount);
EXPORT void give_cp(int amount);
EXPORT void give_sp(int amount);
EXPORT void give_gp(int amount);
EXPORT void award(int value);
EXPORT void lefthand(void);
EXPORT void righthand(void);
EXPORT void bothhands(void);
EXPORT void view_man(void);
EXPORT void victory(int bonus);
EXPORT FLAG castspell(int maxlevel, int takeeffect);
EXPORT void gain_st(int amount);
EXPORT void gain_iq(int amount);
EXPORT void gain_dex(int amount);
EXPORT void gain_con(int amount);
EXPORT void gain_lk(int amount);
EXPORT void gain_chr(int amount);
EXPORT void gain_spd(int amount);
EXPORT void heal_st(int amount);
EXPORT void heal_con(int amount);
EXPORT void healall_st(void);
EXPORT void healall_con(void);
EXPORT void permlose_st(int amount);
EXPORT void lose_iq(int amount);
EXPORT void lose_dex(int amount);
EXPORT void permlose_con(int amount);
EXPORT void lose_lk(int amount);
EXPORT void lose_chr(int amount);
EXPORT void lose_spd(int amount);
EXPORT void templose_st(int amount);
EXPORT void templose_con(int amount);
EXPORT void permchange_st(int amount);
EXPORT void change_iq(int amount);
EXPORT void change_dex(int amount);
EXPORT void permchange_con(int amount);
EXPORT void change_lk(int amount);
EXPORT void change_chr(int amount);
EXPORT void change_spd(int amount);
EXPORT void tempchange_st(int amount);
EXPORT void tempchange_con(int amount);
EXPORT void die(void);
EXPORT void rb_givecoins(void);
EXPORT void rb_givejewel(int type, int size, int generosity);
EXPORT void rb_givejewels(int type, int size, int generosity, int howmany);
EXPORT void rb_treasure(int generosity);
EXPORT void thewait(int turns);
EXPORT void destroy(int which);
EXPORT void checkhands(void);
EXPORT void goodattack(void);
EXPORT void evilattack(void);
EXPORT int create_monster(int which);
EXPORT void create_monsters(int which, int howmany);
EXPORT int countfoes(void);
EXPORT void oneround(void);
EXPORT void good_freeattack(void);
EXPORT void good_takehits(int damage, FLAG doublable);
EXPORT void evil_missileattack(int range, int who);
EXPORT void evil_freeattack(void);
EXPORT void evil_takemissilehits(int which);
EXPORT int evil_getneeded(int range);
EXPORT void evil_takehits(int which, int damage);
EXPORT int calc_personaladds(int st, int lk, int dex);
EXPORT int calc_missileadds(int st, int lk, int dex);
EXPORT FLAG cast(int which, int takeeffect);
EXPORT void encumbrance(void);
EXPORT void drop_all(void);
EXPORT void drop_armour(void);
EXPORT void drop_clothing(void);
EXPORT void drop_weapons(void);
EXPORT void payload(FLAG now);
EXPORT void rebound(FLAG quiet);
EXPORT void endofmodule(void);
EXPORT void passturn(void);
EXPORT int getnumber(STRPTR prompt, int min, int max);
EXPORT int getyn(STRPTR prompt);
EXPORT TEXT getletter(STRPTR prompt, STRPTR allowed, STRPTR opt_0, STRPTR opt_1, STRPTR opt_2, STRPTR opt_3, STRPTR opt_4, STRPTR opt_5, STRPTR opt_6, STRPTR opt_7, TEXT defletter);
EXPORT TEXT getletterornumber(STRPTR allowed, TEXT defletter);
EXPORT void use(int choice);
EXPORT void aprintf(const char* format, ...);
EXPORT void listitems(FLAG numbered, FLAG showall, int percent_standard, int percent_treasure);
EXPORT int makelight(void);
EXPORT FLAG pay_gp(int bill);
EXPORT FLAG pay_cp(int bill);
EXPORT FLAG pay_cp_only(int bill);
EXPORT FLAG pay_sp_only(int bill);
EXPORT FLAG pay_gp_only(int bill);
EXPORT void drop_jewel(int which);
EXPORT void gain_flag_ability(int which);
EXPORT void gain_numeric_abilities(int which, int howmany);
EXPORT void lose_flag_ability(int which);
EXPORT void lose_numeric_abilities(int which, int howmany);
EXPORT void dispose_npcs(void);
EXPORT void learnspell(int which);
EXPORT void to_cp(void);
EXPORT void to_gp(void);
EXPORT void kill_npc(int which);
EXPORT void kill_npcs(void);
EXPORT int gettarget(void);
EXPORT void waitforever(void);
EXPORT int getspell(STRPTR prompt);
EXPORT int getmodule(STRPTR prompt);
EXPORT void owe_st(int amount);
EXPORT void owe_iq(int amount);
EXPORT void owe_lk(int amount);
EXPORT void owe_con(int amount);
EXPORT void owe_dex(int amount);
EXPORT void owe_chr(int amount);
EXPORT void owe_spd(int amount);
EXPORT void options(void);
EXPORT void dropitems(int which, int howmany);
EXPORT void dropitem(int which);
EXPORT void elapse(int amount, FLAG healable);
EXPORT void makeclone(int which);
EXPORT void npc_templose_hp(int which, int amount);
EXPORT void npc_permlose_hp(int which, int amount);
EXPORT void npc_templose_st(int which, int amount);
EXPORT void npc_permlose_st(int which, int amount);
EXPORT void npc_lose_iq(int which, int amount);
EXPORT void npc_lose_lk(int which, int amount);
EXPORT void npc_lose_dex(int which, int amount);
EXPORT void npc_lose_chr(int which, int amount);
EXPORT void npc_lose_spd(int which, int amount);
EXPORT void give_money(int amount);
EXPORT void recalc_ap(int which);
EXPORT int best3of4(void);
EXPORT void savedrooms(int throwlevel, int stat, int yesroom, int noroom);
EXPORT FLAG shooting(void);
EXPORT int getmissileweapon(void);
EXPORT int useammo(void);
EXPORT void give_money(int amount);
EXPORT int highesthp(void);
EXPORT int daro(void);
EXPORT int taro(void);
EXPORT FLAG enchanted_melee(void);
EXPORT FLAG enchantedorsilver_melee(void);
EXPORT FLAG enchanted_missile(void);
EXPORT FLAG enchantedorsilver_missile(void);
EXPORT void damage_enemies(int damage);
EXPORT void victory_level(int amount);
EXPORT FLAG armed(void);
EXPORT void shop(void);
EXPORT int shop_give(int mode);
EXPORT int shop_buy(int percent, TEXT letter);
EXPORT void shop_sell(int percent_standard, int percent_treasure);
EXPORT int damageof(int which);
EXPORT FLAG isarmour(int which);
EXPORT FLAG isweapon(int which);
EXPORT void damage_enemies(int damage);
EXPORT void buy_spells(int mode, int amount);
EXPORT FLAG gotrope(int length);
EXPORT FLAG canfly(FLAG askspell);
EXPORT FLAG can_breathewater(FLAG askspell);
EXPORT void edit_man(void);
EXPORT void borrow_all(void);
EXPORT void borrow_weaponsandarmour(void);
EXPORT void return_all(void);
EXPORT void noeffect(void);
EXPORT void halfeffect(void);
EXPORT void fulleffect(void);
EXPORT void doublecost(void);
EXPORT void triplecost(void);
EXPORT void thresholdeffect(void);
EXPORT void maybeeffect(int chance);
EXPORT void powereffect(int power);
EXPORT void halfpowereffect(int power);
EXPORT void doublepowereffect(int power);
EXPORT void maybepowereffect(int chance, int power);
EXPORT void leveleffect(int minlevel);
EXPORT void doubleeffect(void);
EXPORT void spell_cf(int effectlevel);
EXPORT void spell_hf(void);
EXPORT void spell_tt(void);
EXPORT void guild(void);
EXPORT FLAG can_makefire(void);
EXPORT void become_warrior(void);
EXPORT int throwcoin(void);
EXPORT void listspell(int whichspell, FLAG full);
EXPORT void changerace(void);
EXPORT FLAG immune_hb(void);
EXPORT FLAG immune_poison(void);
EXPORT FLAG immune_fire(void);
EXPORT void set_language(int which, int fluency);
EXPORT FLAG maybespend(int price, STRPTR question);
EXPORT void dicerooms(int first, int second, int third, int fourth, int fifth, int sixth);
EXPORT void oddeven(int odd, int even);
EXPORT void weararmour(int choice);
EXPORT void rb_givejewelleditem(int itemtype);
EXPORT TEXT getsymbol(int whichitem);
EXPORT int lightsource(void);
EXPORT FLAG shot(int range, int size, FLAG doubled);
EXPORT void manualshowpic(STRPTR thepathname, STRPTR newtitlestring);
EXPORT void autoshowpic(void);
EXPORT void showitempic(int whichitem);
EXPORT void drop_or_get(FLAG getting, FLAG dropanything);
EXPORT int divide_roundup(int value1, int value2);
EXPORT FLAG alive(int whichnpc);
EXPORT void advance(FLAG learnable);
EXPORT int carrying(void);
EXPORT void engine_main(void);
EXPORT void quit(SBYTE rc);
EXPORT void help_about(void);
EXPORT void help_update(void);
EXPORT double zatof(STRPTR inputstr);
EXPORT void engine_init(void);
EXPORT FLAG showansi(int which);
EXPORT void enterkey(FLAG force);
EXPORT FLAG isedged(int which);
EXPORT void failmodule(void);
EXPORT void getrank(void);
EXPORT int getlimit(void);
EXPORT int code_to_colour(TEXT thechar);
EXPORT void zstrncpy(char* to, const char* from, size_t n);
EXPORT void wrappass(STRPTR inputbuffer, int wraplength);
EXPORT void hourofday(int hour);

// amiga|ibm.c
EXPORT void loop(FLAG onekeyable);
EXPORT void show_output(void);
EXPORT void open_sheet(void);
EXPORT void update_sheet(void);
EXPORT void close_sheet(void);
EXPORT void open_gfx(void);
EXPORT void close_gfx(FLAG zeroname);
EXPORT void system_die1(void);
EXPORT void system_die2(void);
EXPORT void setconcolour(int fg);
EXPORT FLAG Exists(STRPTR name);
EXPORT void help_manual(void);
EXPORT void openconsole(void);
// EXPORT void say(STRPTR thestring);
// EXPORT void msg(STRPTR thestring);
EXPORT void enable_spells(FLAG enabled);
EXPORT void enable_items(FLAG enabled);
EXPORT void do_opts(void);
EXPORT void undo_opts(void);
EXPORT void openurl(STRPTR command);
EXPORT ULONG getsize(const STRPTR filename);
EXPORT void showfiles(void);
EXPORT void busypointer(void);
EXPORT void normalpointer(void);
EXPORT void maybelf(void);
EXPORT void cls(void);
EXPORT FLAG istrouble(TEXT thechar);
EXPORT FLAG asl_load(void);
EXPORT FLAG asl_import(void);
EXPORT FLAG asl_delete(void);
// EXPORT void make_tips(void);
EXPORT FLAG confirmed(void);
#ifdef AMIGA
    EXPORT void close_about(void);
    EXPORT void __regargs _CXBRK(void);
#endif

EXPORT void ab_magicmatrix(void);
EXPORT void as_magicmatrix(void);
EXPORT void ak_magicmatrix(void);
EXPORT void bw_magicmatrix(void);
EXPORT void cd_magicmatrix(void);
EXPORT void ca_magicmatrix(void);
EXPORT void ci_magicmatrix(void);
EXPORT void dd_magicmatrix(void);
EXPORT void ns_magicmatrix(void);
EXPORT void ok_magicmatrix(void);
EXPORT void sm_magicmatrix(void);
EXPORT void wc_magicmatrix(void);

EXPORT void as_viewman(void);
EXPORT void ak_viewman(void);
EXPORT void cd_viewman(void);
EXPORT void ct_poker(void);
EXPORT void dt_gamble(void);
EXPORT void sm_viewman(void);
EXPORT void so_diseasechart(FLAG drowning);
EXPORT void so_drowning(int harder);

EXPORT void ab_preinit(void);
EXPORT void as_preinit(void);
EXPORT void ak_preinit(void);
EXPORT void bs_preinit(void);
EXPORT void bw_preinit(void);
EXPORT void bf_preinit(void);
EXPORT void bc_preinit(void);
EXPORT void cd_preinit(void);
EXPORT void ca_preinit(void);
EXPORT void ci_preinit(void);
EXPORT void ct_preinit(void);
EXPORT void dd_preinit(void);
EXPORT void dt_preinit(void);
EXPORT void de_preinit(void);
EXPORT void el_preinit(void);
EXPORT void gk_preinit(void);
EXPORT void gl_preinit(void);
EXPORT void hh_preinit(void);
EXPORT void ic_preinit(void);
EXPORT void la_preinit(void);
EXPORT void mw_preinit(void);
EXPORT void nd_preinit(void);
EXPORT void ns_preinit(void);
EXPORT void ok_preinit(void);
EXPORT void rc_preinit(void);
EXPORT void sm_preinit(void);
EXPORT void so_preinit(void);
EXPORT void ss_preinit(void);
EXPORT void sh_preinit(void);
EXPORT void tc_preinit(void);
EXPORT void ww_preinit(void);
EXPORT void wc_preinit(void);

EXPORT void ab_init(void);
EXPORT void as_init(void);
EXPORT void ak_init(void);
EXPORT void bs_init(void);
EXPORT void bw_init(void);
EXPORT void bf_init(void);
EXPORT void bc_init(void);
EXPORT void cd_init(void);
EXPORT void ca_init(void);
EXPORT void ci_init(void);
EXPORT void ct_init(void);
EXPORT void dd_init(void);
EXPORT void dt_init(void);
EXPORT void de_init(void);
EXPORT void el_init(void);
EXPORT void gk_init(void);
EXPORT void gl_init(void);
EXPORT void hh_init(void);
EXPORT void ic_init(void);
EXPORT void la_init(void);
EXPORT void mw_init(void);
EXPORT void nd_init(void);
EXPORT void ns_init(void);
EXPORT void ok_init(void);
EXPORT void rc_init(void);
EXPORT void sm_init(void);
EXPORT void so_init(void);
EXPORT void ss_init(void);
EXPORT void sh_init(void);
EXPORT void tc_init(void);
EXPORT void ww_init(void);
EXPORT void wc_init(void);

#define CALC_DICE                1
#define USE_DICE                 2
#define CALC_ADDS                4
#define USE_ADDS                 8
#define CALC_AP                 16
#define USE_AP                  32

#define ONE_HOUR               (60     ) // in minutes
#define ONE_DAY                (60 * 24) // in minutes
#define ONE_MONTH         (ONE_DAY * 30) // in minutes
#define ONE_YEAR         (ONE_DAY * 365) // in minutes

// L0
#define SPELL_BG   0
#define SPELL_DH   2
#define SPELL_FD   3
#define SPELL_OW   7
#define SPELL_RH   8
#define SPELL_RB   9
// L1
#define SPELL_DM  14
#define SPELL_D1  16
#define SPELL_HP  17
#define SPELL_LT  19
#define SPELL_PA  21
#define SPELL_RE  22
#define SPELL_S1  24
#define SPELL_TF  26
#define SPELL_TE  27
#define SPELL_KK  28
#define SPELL_VB  29
#define SPELL_WO  32
// L2
#define SPELL_AR  34
#define SPELL_CE  36
#define SPELL_CC  38
#define SPELL_CY  40
#define SPELL_DE  41
#define SPELL_EH  42
#define SPELL_FF  43
#define SPELL_MF  47
#define SPELL_MI  48
#define SPELL_OE  52
#define SPELL_RS  55
#define SPELL_SF  58
#define SPELL_YM  60
// L3
#define SPELL_BP  63
#define SPELL_BM  64
#define SPELL_CF  66
#define SPELL_DS  67
#define SPELL_DW  68
#define SPELL_DT  70
#define SPELL_FI  71
#define SPELL_HA  72
#define SPELL_HF  73
#define SPELL_IF  75
#define SPELL_SW  83
#define SPELL_WY  95
#define SPELL_WI  96
#define SPELL_ZX 100
// L4
#define SPELL_CU 101
#define SPELL_DD 104
#define SPELL_GF 108
#define SPELL_KR 113
#define SPELL_PP 116
#define SPELL_SG 119
#define SPELL_TT 123
#define SPELL_T1 124
#define SPELL_UP 125
#define SPELL_WG 130
#define SPELL_WL 131
// L5
#define SPELL_ES 136
#define SPELL_FR 140
#define SPELL_HG 142
#define SPELL_MP 144
#define SPELL_SE 150
#define SPELL_T2 153
#define SPELL_TM 154
// L6
#define SPELL_BI 157
#define SPELL_E1 161
#define SPELL_WF 171
#define SPELL_WA 172
#define SPELL_WN 173
#define SPELL_W1 174
#define SPELL_W2 175
#define SPELL_WS 176
#define SPELL_WT 177
#define SPELL_W3 178
#define SPELL_W4 179
#define SPELL_W5 180
// L7
#define SPELL_E2 184
#define SPELL_IW 188
#define SPELL_WW 197
#define SPELL_ZA 199
// L8
#define SPELL_EW 203
#define SPELL_W6 210
#define SPELL_ZP 211
// L9
#define SPELL_D9 214
#define SPELL_EM 216
#define SPELL_E3 217
#define SPELL_FA 218
#define SPELL_ME 222
#define SPELL_MM 223
#define SPELL_PY 224
#define SPELL_W7 226
// L10
#define SPELL_BT 229
#define SPELL_HB 232
// L11
#define SPELL_BB 238
// L12
#define SPELL_CR 247
#define SPELL_IU 249
// L13
#define SPELL_FM 260
#define SPELL_GH 261
#define SPELL_IN 262
#define SPELL_WZ 266
// L14
#define SPELL_FS 268
// L15
#define SPELL_DB 270
#define SPELL_EA 271
// L16
#define SPELL_AM 272
#define SPELL_EX 273
// L17
#define SPELL_BN 275
#define SPELL_DX 276
#define SPELL_SU 278
// L18
#define SPELL_DN 279
#define SPELL_SH 280
#define SPELL_SR 281
#define SPELL_HS 282
// L19
#define SPELL_OF 283
// L20
#define SPELL_BA 285
// new
#define SPELL_D2 286
#define SPELLS   287

#define RANGE_POINTBLANK   0
#define RANGE_NEAR         1
#define RANGE_FAR          2
#define RANGE_EXTREME      3

#define TEXTPEN_BLACK             0
#define TEXTPEN_DARKRED           1
#define TEXTPEN_DARKGREEN         2
#define TEXTPEN_BROWN             3 //               implemented text
#define TEXTPEN_DARKBLUE          4 //               (unused)
#define TEXTPEN_DARKPURPLE        5 //               (unused)
#define TEXTPEN_DARKCYAN          6 //               unimplemented text
#define TEXTPEN_LIGHTGREY         7
#define TEXTPEN_DARKGREY          8
#define TEXTPEN_PINK              9 // bright red
#define TEXTPEN_GREEN            10 // bright green  list headings
#define TEXTPEN_YELLOW           11 // bright yellow lists
#define TEXTPEN_BLUE             12 // bright blue   "-- More (ENTER) --", "Press ENTER key to continue."
#define TEXTPEN_PURPLE           13 // bright purple list bodies
#define TEXTPEN_CYAN             14 // bright cyan   allowable input
#define TEXTPEN_WHITE            15
#define TEXTPEN_BLACKONDARKCYAN  16
#define TEXTPEN_YELLOWONDARKBLUE 17
#define TEXTPEN_BLACKONDARKRED   18

EXPORT struct ItemStruct
{   const STRPTR name;
    const int    hands,
                 dice,
                 adds,
                 str,
                 dex,
                 cp,
                 weight,
                 range,
                 hits; // hits taken (for armour etc.)
    const FLAG   magical;
    const int    type,
                 module,
                 room1,
                 room2,
                 defcharges;
          int    owned,
                 banked,
                 borrowed,
                 here,
                 lookup,
                 poisontype,
                 poisondoses,
                 charges;
          FLAG   inuse;
};
EXPORT struct LanguageStruct
{   const STRPTR name;
    const int    freq;
          int    fluency;
};
EXPORT struct ModuleInfoStruct
{   const int    rooms,
                 wanderers,
                 treasures;
    const FLAG   castable;
    const STRPTR name,
                 longname,
                 desc;
};
EXPORT struct MonsterStruct
{   STRPTR name;
    int    st,
           iq,
           lk,
           con,
           dex,
           chr,
           spd,
           dice,
           adds,
           mr,
           height, // height of 0 means "unknown"
           rt,
           lt,
           armour,
           ap,
           skin,
           flags,
           level;
    STRPTR reference;
    int    race,
           sex,
           created;
};
EXPORT struct NPCStruct
{   TEXT   name[50 + 1];
    int    dice,
           adds,
           st,  max_st,
           iq,
           con, max_con,
           lk,
           dex,
           chr,
           spd,
           lt,
           rt,
           both,
           ap,
           mr,
           armour,
           skin,
           flags,
           level,
           module,
           race,
           who,
           height;
};
EXPORT struct SpellStruct
{   const int    level,
                 module;
    const STRPTR corginame,
                 fbname;
    const int    st,
                 range;
    const FLAG   combat;
    const int    flags,
                 duration;
    const STRPTR abbrev;
    const int    race;
    const STRPTR desc;
          FLAG   known;
          int    active,
                 power,
                 lookup;
};
EXPORT struct SpellInfoStruct
{   int iq,
        dex,
        gp;
};
EXPORT struct AbilityStruct
{   const STRPTR text;
    const int    module,
                 room;
          UBYTE  known;
          SWORD  st, iq, lk, con, dex, chr, spd;
};
