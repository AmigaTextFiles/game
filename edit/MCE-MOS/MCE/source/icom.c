// 1. INCLUDES -----------------------------------------------------------

#ifdef __amigaos4__
    #ifndef __USE_INLINE__
        #define __USE_INLINE__ // define this as early as possible
    #endif
#endif
#ifdef __LCLINT__
    typedef char* STRPTR;
    typedef char* CONST_STRPTR;
    typedef char  TEXT;
    #define ASM
    #define REG(x)
    #define __inline
#endif

#include <exec/types.h>
#include <exec/memory.h>
#include <dos/dos.h>
#include <intuition/intuition.h>
#define ALL_REACTION_CLASSES
#define ALL_REACTION_MACROS
#include <reaction/reaction.h>

#include <proto/dos.h>
#include <proto/exec.h>
#include <proto/intuition.h>
#include <clib/alib_protos.h>

#include <ctype.h>
#include <stdio.h>                           /* FILE, printf() */
#include <stdlib.h>                          /* EXIT_SUCCESS, EXIT_FAILURE */
#include <string.h>
#include <assert.h>

#ifdef LATTICE
    #include <dos.h>                         // geta4()
#endif

#include "mce.h"

// 2. DEFINES ------------------------------------------------------------

// main window
#define GID_ICOM_LY1    0 // root layout
#define GID_ICOM_SB1    1 // toolbar
#define GID_ICOM_CH1    2 // game
#define GID_ICOM_LB2    3

// location subwindow
#define GID_ICOM_LY2    4
#define GID_ICOM_LB1    5

#define GIDS_DV      GID_ICOM_LB1

#define DEJAVU1       0
#define DEJAVU2       1
#define SHADOWGATE    2
#define UNINVITED     3

#define DV1_ITEMS        223
#define DV1_LASTITEM   0x262

#define DV2_ITEMS        311
#define DV2_LASTITEM   0x4C3

#define SG_ITEMS       0x1C6 // 454. not including you
#define SG_LOCATIONS    0x31 // not including nowhere
#define SG_LASTEXIT     0xC0 // container code of last exit
#define SG_LASTITEM    0x286 // container code of last item

#define UI_ITEMS         455 // not including you
#define UI_LOCATIONS     109 // not including nowhere
#define UI_LASTEXIT     0xEC // container code of last exit
#define UI_LASTITEM      691 // container code of last item

#define ITEMS_MAX      UI_ITEMS
#define LASTITEM_MAX   DV2_LASTITEM

// 3. MODULE FUNCTIONS ---------------------------------------------------

MODULE void readgadgets(void);
MODULE void writegadgets(void);
MODULE void serialize(void);
MODULE void eithergadgets(void);
MODULE void locationwindow(void);
MODULE void makemainlist(void);

/* 4. EXPORTED VARIABLES -------------------------------------------------

(none)

5. IMPORTED VARIABLES ------------------------------------------------- */

IMPORT int                  function,
                            gadmode,
                            loaded,
                            page,
                            serializemode;
IMPORT LONG                 gamesize,
                            whitepen;
IMPORT TEXT                 pathname[MAX_PATH + 1];
IMPORT ULONG                offset,
                            showtoolbar;
IMPORT UBYTE                IOBuffer[IOBUFFERSIZE];
IMPORT struct Hook          ToolHookStruct,
                            ToolSubHookStruct;
IMPORT struct HintInfo*     HintInfoPtr;
IMPORT struct Menu*         MenuPtr;
IMPORT struct IBox          winbox[FUNCTIONS + 1];
IMPORT struct List          SpeedBarList;
IMPORT struct DiskObject*   IconifiedIcon;
IMPORT struct MsgPtr*       AppPort;
IMPORT struct Image*        image[BITMAPS];
IMPORT struct Gadget*       gadgets[GIDS_MAX + 1];
IMPORT struct Screen       *CustomScreenPtr,
                           *ScreenPtr;
IMPORT struct Window       *MainWindowPtr,
                           *SubWindowPtr;
IMPORT Object              *WinObject,
                           *SubWinObject;

// function pointers
IMPORT FLAG (* tool_open)      (FLAG loadas);
IMPORT void (* tool_save)      (FLAG saveas);
IMPORT void (* tool_close)     (void);
IMPORT void (* tool_loop)      (ULONG gid, ULONG code);
IMPORT void (* tool_exit)      (void);
IMPORT FLAG (* tool_subgadget) (ULONG gid, UWORD code);

// 6. MODULE VARIABLES ---------------------------------------------------

MODULE int                  whichitem;
MODULE ULONG                game,
                            itemlocation[ITEMS_MAX + 1];
MODULE TEXT                 liststring[ITEMS_MAX + 1][32 + 1],
                            substring[LASTITEM_MAX + 1][32 + 1];
MODULE struct List          MainList,
                            SubList;

MODULE const STRPTR dv1_LocationNames[0x4D + 1] = {
"Nowhere",                     // $0000
"Carried",                     // $0001
"room #2",
"room #3",
"room #4",
"room #5",
"room #6",
"room #7",
"room #8",                     // $0008
"room #9",
"room #10",
"room #11",
"room #12",
"You have Died!",
"Congratulations!",
"Justice",
"sewer #16",                   // $0010
"casino",
"hidden room",
"bathroom stall",
"office #20",
"kitchen",
"office #22",
"hall",
"guest room",                  // $0018
"sewer #25",
"newsstand",
"run-down bungalow",
"wall #28",
"hallway #29",
"men's washroom",
"lobby #31",
"estate",                      // $0020
"nice looking lady",
"street #34",
"street #35",
"street #36",
"police station",
"yellow cab",
"fire escape #39",
"car interior",                // $0028
"door #41",
"street #42",
"street #43",
"blue cab",
"lobby #45",
"fire escape #46",
"alley #47",
"hallway #48",                 // $0030
"back of the car",
"gun palace",
"dusty wine cellar",
"elevator #52",
"lobby #53",
"street #54",
"shaft under the manhole #55",
"shaft under the manhole #56", // $0038
"sewer section #57",
"door #58",
"street #59",
"office #60",
"wall #61",
"elevator #62",
"sewer section #63",
"bedroom",                     // $0040
"women's washroom",
"office #66",
"sidewalk",
"weird room",
"stall",
"Joe's Bar",
"hallway #71",
"apartment",                   // $0048
"sewer tunnel",
"alley #74",
"street #75",
"construction area",
"altar"                        // $004D
// no NULL is required
}, dv2_LocationNames[74 + 1] = {
"Nowhere",
"Carried",
"dummy",
"bathroom",
"bedroom",
"corridor #5",
"elevator",
"corridor #7",
"corridor #8",
"dumpster",
"corridor #10",
"corridor #11",
"Malone's office",
"Ventini's office",
"lobby",
"cashier's room",
"blackjack room #16",
"blackjack room #17",
"slot machine room #18",
"blackjack room #19",
"blackjack room #20",
"slot machine room #21",
"blackjack room #22",
"casino entryway",
"train station entryway #24",
"laundry room",
"hallway",
"office",
"secret office",
"laundry entryway",
"train station",
"baggage claim department",
"track 2 platform",
"track 3 platform",
"track 4 platform",
"track 5 platform",
"track 6 platform",
"track 7 platform",
"track 8 platform",
"track 9 platform",
"train #40",
"train #41",
"train station",
"train station entryway #43",
"taxi",
"apartment entryway #45",
"hall #46",
"your apartment",
"morgue entrance",
"morgue",
"freezer",
"apartment entryway #51",
"Sugar's apartment",
"Joe's Bar's entrance",
"alley",
"fire escape",
"Siegel's office",
"back alley",
"hall #58",
"bar room",
"hall #60",
"wine cellar",
"secret room",
"casino",
"police station",
"cemetery",
"empty lot",
"desert #67",
"arrested",
"death",
"storage",
"congratulations!",
"desert #72",
"desert #73",
"desert #74"
// no NULL is required
}, GameOptions[4 + 1] =
{ "Deja Vu 1",
  "Deja Vu 2",
  "Shadowgate",
  "Uninvited",
  NULL
}, dv1_PropNames[180] = {
"window #208",                 // $00D0
"Mercedes",
"front door",
"bum",
"clutch #212",
"clutch #213",
"window #214",
"lamppost #215",
"lamppost #216",               // $00D8
"sign #217",
"ceiling light #218",
"door latch",
"ceiling light #220",
"mirror #221",
"sink #222",
"puddle #223",
"puddle #224",                 // $00E0
"ceiling light #225",
"mirror #226",
"sink #227",
"toilet #228",
"toilet #229",
"toilet crank handle",
"poster #231",
"poster #232",                 // $00E8
"poster #233",
"desk #234",
"window #235",
"window #236",
"desk lamp",
"phone",
"typewriter",
"desk #240",                   // $00F0
"wall safe",
"safe door",
"telephone",
"corpse",
"old wall phone",
"chandelier #246",
"button #247",
"button #248",                 // $00F8
"top button",
"second button",
"third button",
"bottom button",
"barrel of wine",
"wine bottle",
"light bulb",
"spigot #256",                 // $0100
"spigot #257",
"picture #258",
"picture #259",
"slot machine #260",
"slot machine #261",
"roulette table",
"lamp #263",
"lamp #264",                   // $0108
"dice table",
"whirling mess",
"sewer pipe",
"handle #268",
"handle #269",
"shelf",
"chair #271",
"button #272",                 // $0110
"man #273",
"back door",
"tyre",
"trunk lid #276",
"trunk lid #277",
"ignition",
"hood release",
"radio",                       // $0118
"steering wheel",
"hood",
"glove compartment",
"gas pedal",
"woman",
"trunk lid #286",
"trunk lid #287",
"keyhole #288",                // $0120
"window #289",
"newsboy",
"window #291",
"newsstand",
"nice looking lady",
"purse",
"knocked-out woman",
"clerk",                       // $0128
"sign #297",
"trash can",
"cab driver #299",
"latch #300",
"pay slot #301",
"cab driver #302",
"latch #303",
"pay slot #304",               // $0130
"cab driver #305",
"cab driver's arm #306",
"cab driver #307",
"cab driver's arm #308",
"meter #309",
"meter #310",
"meter #311",
"meter #312",                  // $0138
"slot #313",
"slot #314",
"picture #315",
"table #316",
"bookcase",
"fireplace",
"chandelier #319",
"mirror #320",                 // $0140
"sofa #321",
"chair #322",
"bed #323",
"table #324",
"window #325",
"window #326",
"shadow",
"keyhole #328",                // $0148
"lock #329",
"window #330",
"file cabinet #331",
"man #332",
"dead man",
"desk #334",
"keyhole #335",
"lock #336",                   // $0150
"file cabinet #337",
"shot up cabinet",
"file drawer #339",
"medicine cabinet",
"eye chart",
"knocker",
"door handle",
"keyhole #344",                // $0158
"mailbox #345",
"mailbox #346",
"flag #347",
"flag #348",
"butler",
"table #350",
"nightstand #351",
"lamp #352",                   // $0160
"bed #353",
"sleeping man",
"cover #355",
"nightstand #356",
"lamp #357",
"mirror #358",
"bed #359",
"sleeping woman",              // $0168
"cover #361",
"bare light bulb",
"toilet paper #363",
"toilet paper #364",
"nothing #365",
"nothing #366",
"nothing #367",
"nothing #368",                // $0170
"nothing #369",
"nothing #370",
"nothing #371",
"nothing #372",
"nothing #373",
"nothing #374",
"nothing #375",
"nothing #376",                // $0178
"nothing #377",
"nothing #378",
"nothing #379",
"nothing #380",
"nothing #381",
"bullet hole #382",
"bullet hole #383",
"bullet hole #384",            // $0180
"garbage",
"fly",
"Holy Grail"                   // $0183
// no NULL is required
}, dv1_ItemNames[DV1_ITEMS + 1] = {
"holster",                     // $0184 ($308..$309)
"trench coat",
"notepad",
"wastebasket #391",
"wastebasket #392",            // $0188
"Luger #393",
"gun #394",
"gun #395",
"pair of dark glasses #396",
"handkerchief #397",
"pack of cigarettes #398",
"file #399",
"file #400",                   // $0190
"file #401",
"file #402",
"file #403",
"file #404",
"file #405",
"file #406",
"file #407",
"file #408",                   // $0198
"file #409",
"file #410",
"file #411",
"file #412",
"file #413",
"file #414",
"file #415",
"photo #416",                  // $01A0
"street map",
"gun #418",
"Luger #419",
"gun #420",
"envelope #421",
"envelope #422",
"envelope #423",
"wok",                         // $01A8
"jug",
"car registration",
"receipt",
"sheet of paper",
"pan #429",
"pan #430",
"pan #431",
"jar #432",                    // $01B0
"jar #433",
"jar #434",
"sugar",
"flour",
"letter #437",
"pair of dark glasses #438",
"pair of glasses",
"handkerchief #440",           // $01B8
"leather wallet",
"photograph",
"woman's purse",
"box",
"tissue",
"key #446",
"pack of cigarettes #447",
"key #448",                    // $01C0
"$20 bill #449",
"$20 note #450",
"plastic card",
"key #452",
"shot glass",
"cigarette lighter",
"key #455",
"manila folder",               // $01C8
"pile of cheques",
"cardboard box",
"letter #459",
"diary",
"briefcase #461",
"briefcase #462",
"newspaper #463",
"newspaper #464",              // $01D0
"newspaper #465",
"newspaper #466",
"newspaper #467",
"newspaper #468",
"newspaper #469",
"newspaper #470",
"newspaper #471",
"newspaper #472",              // $01D8
"newspaper #473",
"newspaper #474",
"newspaper #475",
"makeup kit",
"key #477",
"piece of paper",
"bookmark",
"pen",                         // $01E0
"pencil",
"ammo kit",
"gag",
"food",
"magazine",
"quarter #486",
"quarter #487",
"quarter #488",                // $01E8
"quarter #489",
"quarter #490",
"quarter #491",
"quarter #492",
"quarter #493",
"quarter #494",
"quarter #495",
"quarter #496",                // $01F0
"quarter #497",
"quarter #498",
"quarter #499",
"quarter #500",
"quarter #501",
"quarter #502",
"quarter #503",
"quarter #504",                // $01F8
"quarter #505",
"quarter #506",
"quarter #507",
"quarter #508",
"quarter #509",
"quarter #510",
"quarter #511",
"quarter #512",                // $0200
"quarter #513",
"quarter #514",
"quarter #515",
"quarter #516",
"quarter #517",
"quarter #518",
"quarter #519",
"quarter #520",                // $0208
"quarter #521",
"quarter #522",
".38 cartridge #523",
".38 cartridge #524",
".38 cartridge #525",
".38 cartridge #526",
".38 cartridge #527",
".38 cartridge #528",          // $0210
".38 cartridge #529",
".38 cartridge #530",
".38 cartridge #531",
".38 cartridge #532",
".38 cartridge #533",
".38 cartridge #534",
".38 cartridge #535",
".38 cartridge #536",          // $0218
".38 cartridge #537",
".38 cartridge #538",
".38 cartridge #539",
".38 cartridge #540",
".38 cartridge #541",
".38 cartridge #542",
".38 cartridge #543",
".38 cartridge #544",          // $0220
".38 cartridge #545",
".38 cartridge #546",
".38 shell #547",
".38 shell #548",
".38 shell #549",
".38 shell #550",
".38 shell #551",
".38 shell #552",              // $0228
".38 shell #553",
".38 shell #554",
".38 shell #555",
".38 shell #556",
".38 shell #557",
".38 shell #558",
".38 shell #559",
".38 shell #560",              // $0230
".38 shell #561",
".38 shell #562",
".38 shell #563",
".38 shell #564",
".38 shell #565",
".38 shell #566",
".38 shell #567",
".38 shell #568",              // $0238
".38 shell #569",
".38 shell #570",
"9mm cartridge #571",
"9mm cartridge #572",
"9mm cartridge #573",
"9mm cartridge #574",
"9mm cartridge #575",
"9mm cartridge #576",          // $0240
"9mm shell #577",
"9mm shell #578",
"9mm shell #579",
"9mm shell #580",
"9mm shell #581",
"9mm shell #582",
"specimen bottle",
"vial #584",                   // $0248
"vial #585",
"vial #586",
"vial #587",
"vial #588",
"vial #589",
"vial #590",
"vial #591",
"vial #592",                   // $0250
"vial #593",
"vial #594",
"vial #595",
"vial #596",
"vial #597",
"vial #598",
"vial #599",
"empty syringe",               // $0258
"pearl earring #601",
"pearl earring #602",
"candy #603",
"candy #604",
"candy #605",
"candy #606",
"candy #607",
"candy #608",                  // $0260
"candy #609",
"candy #610",                  // $0262 ($4C4..$4C5)
"You"                          // $0263
// no NULL is required
}, dv2_PropNames[101] = {
"bed #808",             // $0328 ($650..$651)
"blanket",
"plate",
"awning",
"lamp post #812",
"lamp post #813",
"fire escape",
"bunch of boards #815",
"bunch of boards #816", // $0330
"bunch of boards #817",
"bunch of boards #818",
"set of blinds #819",
"set of blinds #820",
"safe #821",
"safe #822",
"phone #823",
"desk #824",
"bunch of boards #825",
"window #826",
"broken window #827",
"bar",
"poster #829",
"poster #830",
"poster #831",
"wine rack",            // $0340
"bottle #833",
"keg",
"spigot",
"light",
"wheel of fortune",
"slot machine #838",
"slot machine #839",
"picture #840",
"picture #841",
"lamp #842",
"lamp #843",
"roulette table",
"craps table",
"sign #846",
"tombstone #847",
"broken window #848",    // $0350
"window #849",
"broken window #850",
"flight of stairs",
"bunch of policemen",
"lamp post #853",
"lamp post #854",
"window #855",
"tombstone #856",
"tombstone #857",
"tombstone #858",
"tombstone #859",
"tombstone #860",
"tombstone #861",
"tombstone #862",
"tombstone #863",
"gate",                  // $0360
"sign #865",
"tree #866",
"pile of ruins",
"tree #868",
"fence #869",
"fence #870",
"taxi",
"railing #872",
"railing #873",
"bum",
"sign #875",
"sign #876",
"sign #877",
"sign #878",
"sign #879",
"sign #880",             // $0370
"sign #881",
"sign #882",
"coat rack",
"chair #884",
"desk #885",
"phone #886",
"pair of drapes #887",
"pair of drapes #888",
"chair #889",
"desk #890",
"phone #891",
"chair #892",
"desk #893",
"phone #894",
"chair #895",
"desk #896",             // $0380
"phone #897",
"table #898",
"dresser",
"night table #900",
"lamp #901",
"dumpster",
"chandelier",
"slab",
"picture #905",
"pile of clothes #906",
"plant #907",
"plant #908"             // $038C ($718..$719)
// no NULL is required
}, dv2_ItemNames[DV2_ITEMS + 1] = {
"ledger #909",                 // $038D ($71A..$71B)
"wastebasket #910",
"ledger #911",
"plant #912",                  // $0390
"coat",
"night table #914",
"dress #915",
"uniform #916",
"dress #917",
"pile of clothes #918",
"ledger #919",
"ledger #920",                 // $0398
"box #921",
"box #922",
"box #923",
"chair #924",
"chair #925",
"carton #926",
"carton #927",
"paper #928",                  // $03A0
"key #929",
"pizza",
"Peking duck",
"plant #932",
"overcoat",
"table #934",
"table #935",
"table #936",
"table #937",
"table #938",
"table #939",
"plank",
"vacuum",
"suitcase #942",
"skull",
"table #944",                  // $03B0
"blotter",
"trenchcoat",
"Bible #947",
"Bible #948",
"log #949",
"log #950",
"table #951",
"newspaper #952",
"envelope #953",
"envelope #954",
"letter #955",
"letter #956",
"letter #957",
"letter #958",
"newsclip #959",
"detergent",                   // $03C0
"plant #961",
"plant #962",
"plant #963",
"lamp #964",
"plant #965",
"plant #966",
"plant #967",
"wallet #968",
"wallet #969",
"drawer",
"garbage can #971",
"garbage can #972",
"garbage can #973",
"paperweight",
"envelope #975",
"envelope #976",               // $03D0
"briefcase",
"nothing #978",
"nothing #979",
"box #980",
"box #981",
"box #982",
"box #983",
"banana peel",
"pencil",
"newsclip #986",
"$1 bill #987",
"$1 bill #988",
"$5 bill #989",
"$5 bill #990",
"$5 bill #991",
"$5 bill #992",                // $03E0
"$5 bill #993",
"$5 bill #994",
"$5 bill #995",
"$5 bill #996",
"$5 bill #997",
"$5 bill #998",
"$5 bill #999",
"$5 bill #1000",
"$5 bill #1001",
"$5 bill #1002",
"$5 bill #1003",
"$5 bill #1004",
"$5 bill #1005",
"$5 bill #1006",
"$5 bill #1007",
"$5 bill #1008",               // $03F0
"$10 bill #1009",
"$10 bill #1010",
"$10 bill #1011",
"$10 bill #1012",
"$10 bill #1013",
"$20 bill #1014",
"$20 bill #1015",
"$20 bill #1016",
"vacuum bag",
"slashed vacuum bag",
"plant #1019",
"pair of pants",
"banana #1021",
"cobweb #1022",
"cobweb #1023",
"cobweb #1024",                // $0400
"cobweb #1025",
"cobweb #1026",
"cobweb #1027",
"cobweb #1028",
"cobweb #1029",
"cobweb #1030",
"cobweb #1031",
"cobweb #1032",
"cobweb #1033",
"cobweb #1034",
"cobweb #1035",
"cobweb #1036",
"cobweb #1037",
"cobweb #1038",
"cobweb #1039",
"cobweb #1040",                // $0410
"paper #1041",
"gun",
"newspaper #1043",
"newspaper #1044",
"newspaper #1045",
"newspaper #1046",
"newspaper #1047",
"box #1048",
"litter #1049",
"paper #1050",
"envelope #1051",
"envelope #1052",
"envelope #1053",
"envelope #1054",
"box #1055",
"pillow #1056",                // $0420
"pillow #1057",
"pillow #1058",
"pillow #1059",
"racing form",
"banana #1061",
"wallet #1062",
"wallet #1063",
"litter #1064",
"base",
"matchbox #1066",
"driver's licence #1067",
"driver's licence #1068",
"licence",
"perfume",
"pack of cigarettes #1071",
"towel #1072",                 // $0430
"towel #1073",
"table #1074",
"table #1075",
"table #1076",
"table #1077",
"table #1078",
"shoe #1079",
"matchbox #1080",
"box #1081",
"box #1082",
"dart #1083",
"business card",
"flashlight",
"letter opener",
"watch",
"broken watch",                // $0440
"pile of clothes #1089",
"spitoon",
"shoe #1091",
"penknife #1092",
"sandwich",
"bottle #1094",
"broken bottle #1095",
"plant #1096",
"box #1097",
"bottle #1098",
"broken bottle #1099",
"tissue",
"plant #1101",
"plant #1102",
"plant #1103",
"wastebasket #1104",           // $0450
"dart #1105",
"plant #1106",
"plant #1107",
"letter #1108",
"envelope #1109",
"envelope #1110",
"envelope #1111",
"envelope #1112",
"picture #1113",
"bag #1114",
"bag #1115",
"can",
"bottle #1117",
"broken bottle #1118",
"bottle #1119",
"broken bottle #1120",         // $0460
"bottle #1121",
"broken bottle #1122",
"schedule #1123",
"schedule #1124",
"schedule #1125",
"schedule #1126",
"schedule #1127",
"schedule #1128",
"bundle of deposit slips #1129",
"bundle of deposit slips #1130",
"box #1131",
"penknife #1132",
"battery #1133",
"battery #1134",
"key #1135",
"key #1136",                   // $0470
"key #1137",
"key #1138",
"key #1139",
"key #1140",
"key #1141",
"lit match #1142",
"lit match #1143",
"lit match #1144",
"lit match #1145",
"lit match #1146",
"lit match #1147",
"match #1148",
"match #1149",
"match #1150",
"match #1151",
"match #1152",                 // $0480
"match #1153",
"burnt-out match #1154",
"burnt-out match #1155",
"burnt-out match #1156",
"burnt-out match #1157",
"burnt-out match #1158",
"burnt-out match #1159",
"coconut #1160",
"coconut #1161",
"coconut #1162",
"coconut #1163",
"coconut #1164",
"coconut #1165",
"coconut #1166",
"coconut #1167",
"identification tag",          // $0490
"toe-tag",
"ID tag",
"picture #1171",
"glass",
"bullet #1173",
"bullet #1174",
"bullet #1175",
"bullet #1176",
"bullet #1177",
"bullet #1178",
"shell #1179",
"shell #1180",
"casing #1181",
"casing #1182",
"shell #1183",
"shell #1184",                 // $04A0
"ashtray #1185",
"cigar ring #1186",
"cigar ring #1187",
"cigar ring #1188",
"cigar ring #1189",
"cigar ring #1190",
"cigar ring #1191",
"cigar ring #1192",
"ashtray #1193",
"quarter #1194",
"quarter #1195",
"quarter #1196",
"magnet",
"$5 chip #1198",
"$5 chip #1199",
"$5 chip #1200",               // $04B0
"$5 chip #1201",
"$5 chip #1202",
"$5 chip #1203",
"$5 chip #1204",
"$5 chip #1205",
"$5 chip #1206",
"$5 chip #1207",
"$5 chip #1208",
"$5 chip #1209",
"$5 chip #1210",
"$5 chip #1211",
"$5 chip #1212",
"$5 chip #1213",
"$5 chip #1214",
"$5 chip #1215",
"$5 chip #1216",               // $04C0
"$5 chip #1217",
"pair of dice",
"baggage claim ticket",        // $04C3 ($986..$987)
"You"                          // $04C4
// no NULL is required
}, sg_LocationNames[SG_LOCATIONS + 1] = {
"Nowhere",                     // $0000
"Carried",                     // $0001
"room #2",
"entrance",
"hallway #4",
"closet",
"hallway #6",
"chamber #7",
"hallway #8",                  // $0008
"lake #9",
"waterfall",
"alcove #11",
"pedestal room",
"lair",
"tomb #14",
"mirror room",
"bridge #16",                  // $0010
"crevice",
"bridge room",
"alcove #19",
"cave #20",
"chamber #21",
"cave #22",
"courtyard",
"hallway #24",                 // $0018
"library",
"study",
"laboratory",
"garden",
"armory",
"banquet hall",
"chamber #31",
"turret #32",                  // $0020
"chamber #33",
"observatory",
"turret #35",
"hallway #36",
"balcony",
"lookout",
"throne room",
"hallway #40",                 // $0028
"cave #41",
"cavern #42",
"cave #43",
"wellroom",
"river",
"vault",
"cavern #47",
"Thou Art Dead!",              // $0030
"Congratulations!"             // $0031
// no NULL is required
}, sg_ItemNames[SG_ITEMS + 1] = { // $C1..$287
"slab #193",
"slab #194",
"slab #195",
"thing #196",
"nothing #197",
"nothing #198",
"nothing #199",
"stone #200",
"stone #201",
"floor",
"thing #203",
"stone #204",
"stone #205",
"bottle #206",
"unselectable #207",
"lever #208",
"lever #209",
"lever #210",
"lever #211",
"lever #212",
"lever #213",
"cylinder #214",
"silver orb #215",
"cylinder #216",
"cylinder #217",
"unselectable #218",
"lake #219",
"nothing #220",
"frozen lake",
"unselectable #222",
"skeleton #223",
"skeleton #224",
"shark",
"tomb #226",
"tomb #227",
"tomb #228",
"tomb #229",
"tomb #230",
"fire #231",
"bridge #232",
"bridge #233",
"rug #234",
"rug #235",
"rubble",
"ledge",
"broken ledge",
"rock #239",
"unselectable #240",
"brazier #241",
"brazier #242",
"mirror #243",
"broken mirror #244",
"mirror #245",
"broken mirror #246",
"mirror #247",
"broken mirror #248",
"rope #249",
"sign",
"nothing #251",
"nothing #252",
"nothing #253",
"cage door",
"mummy",
"slime",
"unselectable #257",
"unselectable #258",
"cyclops #259",
"cyclops #260",
"well #261",
"bucket",
"rope #263",
"rope #264",
"troll #265",
"troll #266",
"unselectable #267",
"wall",
"unselectable #269",
"rock #270",
"nothing #271",
"nothing #272",
"unselectable #273",
"rug #274",
"globe #275",
"globe #276",
"fire #277",
"firewood",
"goblet",
"shelf",
"thing #281",
"thing #282",
"thing #283",
"thing #284",
"unselectable #285",
"tree #286",
"tree #287",
"tree #288",
"hole",
"unselectable #290",
"fountain",
"nothing #292",
"nothing #293",
"wyvern #294",
"wyvern #295",
"nothing #296",
"pole stand",
"nothing #298",
"star map",
"shooting star #300",
"table #301",
"telescope",
"rug #303",
"Doogan #304",
"Doogan #305",
"nothing #306",
"ring #307",
"panel",
"shield #309",
"spear #310",
"bow",
"shield #312",
"quiver",
"table #314",
"Trogg #315",
"Crag #316",
"Grot #317",
"Gort #318",
"Trogg #319",
"Crag #320",
"Grot #321",
"Gort #322",
"lit torch #323",
"burned out torch #324",
"rug #325",
"mirror #326",
"broken mirror #327",
"tapestry",
"gargoyle #329",
"gargoyle #330",
"gargoyle #331",
"gargoyle #332",
"brick #333",
"brick #334",
"well #335",
"crank #336",
"crank #337",
"nothing #338",
"cover #339",
"cover #340",
"cover #341",
"ferryman",
"gong",
"stand",
"Behemoth #345",
"Behemoth #346",
"Behemoth #347",
"Behemoth #348",
"ground",
"platform",
"Warlock Lord #351",
"Warlock Lord #352",
"brazier #353",
"brazier #354",
"brazier #355",
"brazier #356",
"brazier #357",
"brazier #358",
"beam #359",
"beam #360",
"werewolf #361",
"pretty lady",
"dead werewolf",
"chain",
"kettle",
"lit torch #366",
"burned out torch #367",
"lit torch #368",
"burned out torch #369",
"lit torch #370",
"burned out torch #371",
"sphinx",
"book #373",
"book #374",
"book #375",
"book #376",
"book #377",
"book #378",
"book #379",
"book #380",
"book #381",
"book #382",
"book #383",
"book #384",
"book #385",
"book #386",
"book #387",
"book #388",
"book #389",
"book #390",
"book #391",
"book #392",
"book #393",
"book #394",
"book #395",
"book #396",
"book #397",
"book #398",
"book #399",
"book #400",
"skull #401",
"encyclopedia set",
"book holder",
"bookcase",
"desk",
"map",
"book #407",
"book #408",
"book #409",
"unselectable #410",
"unselectable #411",
"thing #412",
"thing #413",
"thing #414",
"thing #415",
"unselectable #416",
"wand #417",
"hand",
"unselectable #419",
"unselectable #420",
"unselectable #421",
"unselectable #422",
"unselectable #423",
"horn",
"hellhound",
"fire #426",
"firedrake #427",
"key #428",
"skull #429",
"lit torch #430",
"unlit torch #431",
"burned out torch #432",
"lit torch #433",
"unlit torch #434",
"burned out torch #435",
"lit torch #436",
"unlit torch #437",
"burned out torch #438",
"lit torch #439",
"unlit torch #440",
"burned out torch #441",
"lit torch #442",
"unlit torch #443",
"burned out torch #444",
"lit torch #445",
"unlit torch #446",
"burned out torch #447",
"lit torch #448",
"unlit torch #449",
"burned out torch #450",
"lit torch #451",
"unlit torch #452",
"burned out torch #453",
"lit torch #454",
"unlit torch #455",
"burned out torch #456",
"lit torch #457",
"unlit torch #458",
"burned out torch #459",
"snake #460",
"snake #461",
"snake #462",
"snake #463",
"snake #464",
"snake #465",
"snake #466",
"snake #467",
"statue",
"staff #469",
"staff #470",
"staff #471",
"shield #472",
"spear #473",
"pedestal",
"chest",
"cloak",
"lit torch #477",
"unlit torch #478",
"burned out torch #479",
"lit torch #480",
"unlit torch #481",
"burned out torch #482",
"lit torch #483",
"burned out torch #484",
"lit torch #485",
"unlit torch #486",
"burned out torch #487",
"lit torch #488",
"unlit torch #489",
"burned out torch #490",
"lit torch #491",
"unlit torch #492",
"burned out torch #493",
"lit torch #494",
"unlit torch #495",
"burned out torch #496",
"lit torch #497",
"unlit torch #498",
"burned out torch #499",
"lit torch #500",
"unlit torch #501",
"burned out torch #502",
"lit torch #503",
"unlit torch #504",
"burned out torch #505",
"lit torch #506",
"unlit torch #507",
"burned out torch #508",
"lit torch #509",
"unlit torch #510",
"burned out torch #511",
"lit torch #512",
"unlit torch #513",
"burned out torch #514",
"scepter",
"rod",
"helmet",
"bone",
"skull #519",
"skull #520",
"jar #521",
"jar #522",
"jar #523",
"jar #524",
"jar #525",
"jar #526",
"jar #527",
"jar #528",
"test tube holder",
"jar #530",
"jar #531",
"jar #532",
"jar #533",
"jar #534",
"jar #535",
"jar #536",
"jar #537",
"sword",
"arrow",
"pouch",
"hammer",
"bellows",
"poker",
"flute",
"gauntlet",
"broom",
"scroll #547",
"scroll #548",
"scroll #549",
"scroll #550",
"scroll #551",
"scroll #552",
"scroll #553",
"scroll #554",
"scroll #555",
"scroll #556",
"rope #557",
"horseshoe",
"bowl",
"bag #560",
"shield #561",
"mallet",
"skull #563",
"vial #564",
"vial #565",
"vial #566",
"vial #567",
"vial #568",
"vial #569",
"vial #570",
"vial #571",
"coin #572",
"shield #573",
"club",
"talisman",
"shooting star #576",
"shooting star #577",
"shooting star #578",
"spike",
"bottle #580",
"bottle #581",
"bottle #582",
"bottle #583",
"silver orb #584",
"sphere",
"sling",
"bag #587",
"pair of glasses",
"blue gem",
"red gem",
"white gem",
"key #592",
"key #593",
"key #594",
"key #595",
"wand #596",
"bottle #597",
"bottle #598",
"bottle #599",
"bottle #600",
"key #601",
"stone #602",
"stone #603",
"stone #604",
"stone #605",
"stone #606",
"stone #607",
"stone #608",
"stone #609",
"stone #610",
"stone #611",
"key #612",
"coin #613",
"coin #614",
"coin #615",
"coin #616",
"coin #617",
"coin #618",
"coin #619",
"coin #620",
"coin #621",
"coin #622",
"coin #623",
"coin #624",
"coin #625",
"ring #626",
"fire #627",
"fire #628",
"creature",
"guardian",
"banshee #631",
"banshee #632",
"gargoyles",
"Grot #634",
"werewolf #635",
"wyvern #636",
"troll #637",
"firedrake #638",
"wraith #639",
"wraith #640",
"rat #641",
"rat #642",
"cat #643",
"cat #644",
"rat #645",
"rat #646",                    // $286
"You"                          // $287
// no NULL is required
}, ui_LocationNames[UI_LOCATIONS + 1] = {
"Nowhere",                     // $0000
"Carried",                     // $0001
"room #2",
"car",
"front yard",
"library",
"entrance hall",
"parlor",
"veranda",                     // $0008
"congratulations",
"hall",
"study",
"dining room",
"rec room",
"pantry",
"kitchen",
"bedroom #16",                 // $0010
"trophy room",
"master bedroom",
"bedroom #19",
"bathroom #20",
"upstairs hallway",
"bathroom #22",
"storage closet",
"stairwell",                   // $0018
"bedroom #25",
"tower",
"trapped",
"secret room",
"backyard",
"entrance #30",
"room #31",
"laboratory",                  // $0020
"observatory",
"cave #34",
"cave #35",
"ice cave #36",
"ice cave #37",
"cave #38",
"stairway #39",
"entrance #40",                // $0028
"greenhouse",
"chapel entrance",
"chapel",
"church grounds",
"maze #45",
"maze #46",
"maze #47",
"maze #48",
"maze #49",
"maze #50",
"maze #51",
"maze #52",
"maze #53",
"maze #54",
"maze #55",
"maze #56",
"maze #57",
"maze #58",
"maze #59",
"maze #60",
"maze #61",
"maze #62",
"maze #63",
"maze #64",
"maze #65",
"maze #66",
"maze #67",
"maze #68",
"maze #69",
"maze #70",
"maze #71",
"maze #72",
"maze #73",
"maze #74",
"maze #75",
"maze #76",
"maze #77",
"maze #78",
"maze #79",
"maze #80",
"maze #81",
"maze #82",
"maze #83",
"maze #84",
"maze #85",
"maze #86",
"maze #87",
"maze #88",
"maze #89",
"maze #90",
"maze #91",
"maze #92",
"maze #93",
"maze #94",
"maze #95",
"maze #96",
"maze #97",
"maze #98",
"maze #99",
"maze #100",
"maze #101",
"maze #102",
"maze #103",
"maze #104",
"maze #105",
"maze #106",
"I've got you!", // 107
"art gallery",   // 108
"mansion"        // 109
// no NULL is required
}, ui_ItemNames[UI_ITEMS + 1] = { // 237..712
"rug #237",
"rug #238",
"rug #239",
"rug #240",
"rug #241",
"rug #242",
"rug #243",
"rug #244",
"window #245",
"broken window #246",
"window #247",
"broken window #248",
"window #249",
"broken window #250",
"window #251",
"broken window #252",
"window #253",
"broken window #254",
"window #255",
"broken window #256",
"window #257",
"broken window #258",
"window #259",
"broken window #260",
"broken window #261",
"window #262",
"window #263",
"broken window #264",
"window #265",
"broken window #266",
"window #267",
"broken window #268",
"window #269",
"broken window #270",
"window #271",
"broken window #272",
"mirror #273",
"broken mirror #274",
"mirror #275",
"broken mirror #276",
"mirror #276",
"broken mirror #278",
"drapery #279",
"drapery #280",
"drapery #281",
"drapery #282",
"picture #283",
"picture #284",
"picture #285",
"picture #286",
"picture #287",
"picture #288",
"picture #289",
"picture #290",
"picture #291",
"picture #292",
"picture #293",
"picture #294",
"picture #295",
"picture #296",
"picture #297",
"picture #298",
"picture #299",
"picture #300",
"diary #301",
"picture #302",
"plaque",
"mounted fish",
"bookcase",
"shelf #306",
"shelf #307",
"shelf #308",
"shelf #309",
"rack",
"shelf #311",
"shelf #312",
"shelf #313",
"shelf #314",
"shelf #315",
"shelf #316",
"shelf #317",
"shelf #318",
"shelf #319",
"fireplace #320",
"fire #321",
"firewood #322",
"fireplace #323",
"fireplace #324",
"firewood #325",
"fire #326",
"cauldron",
"broken windshield",
"dashboard",
"rear view mirror",
"flame #331",
"flame #332",
"flame #333",
"flame #334",
"flame #335",
"flame #336",
"flame #337",
"steering wheel",
"closed mailbox",
"open mailbox",
"statue #341",
"statue #342",
"star map",
"table #344",
"globe",
"statue #346",
"couch #347",
"chair #348",
"ripped chair #349",
"chair #350",
"ripped chair #351",
"light #352",
"chair #353",
"railing",
"nothing #355",
"unselectable #356",
"couch #357",
"desk",
"chandelier",
"chair #360",
"chair #361",
"chair #362",
"chair #363",
"chair #364",
"chair #365",
"chair #366",
"chair #367",
"table #368",
"light #369",
"potholder",
"cabinet #371",
"cabinet #372",
"cabinet #373",
"cabinet #374",
"cabinet #375",
"cabinet #376",
"cabinet #377",
"oven #378",
"oven #379",
"bed #380",
"dresser #381",
"light #382",
"spear #383",
"spear #384",
"shield",
"gun rack",
"rifle #387",
"rifle #388",
"rifle #389",
"stuffed bear",
"tiger skin",
"boar head",
"moose head",
"cabinet #394",
"cabinet #395",
"chair #396",
"chair #397",
"chess table",
"cabinet #399",
"cabinet #400",
"light #401",
"bed #402",
"table #403",
"closet #404",
"closet #405",
"closet #406",
"light #407",
"bed #408",
"nightstand",
"tub #410",
"tub #411",
"faucet",
"hot water knob",
"cold water knob",
"sink #415",
"stream of water #416",
"stream of water #417",
"fish tank",
"broken fish tank",
"hook",
"hamper",
"tub #422",
"sink #423",
"stream of water #424",
"stream of water #425",
"towel rod",
"light #427",
"dresser #428",
"light #429",
"bed #430",
"kid brother #431",
"kid brother #432",
"kid brother #433",
"kid brother #434",
"hatch #435",
"hatch #436",
"unselectable #437",
"cross #438",
"altar",
"statue head #440",
"statue head #441",
"Doric column",
"pew #443",
"pew #444",
"nothing #445",
"ornament #446",
"ornament #447",
"light #448",
"safe",
"table #450",
"experiment #451",
"experiment #452",
"telescope",
"map",
"table #455",
"stool",
"table #457",
"table #458",
"spider #459",
"stairway #460",
"gem #461",
"unselectable #462",
"unselectable #463",
"bouncing creature #464",
"bouncing creature #465",
"cage #466",
"cage #467",
"cage #468",
"cage #469",
"cage #470",
"cage #471",
"cage #472",
"cage #473",
"cage #474",
"keyhole",
"nothing #476",
"tombstone #477",
"tombstone #478",
"tombstone #479",
"tombstone #480",
"coffin #481",
"coffin #482",
"picture #483",
"picture #484",
"picture #485",
"statue #486",
"urn",
"bowl #488",
"plate #489",
"plant #490",
"evil genius",
"wheelchair",
"nothing #493",
"demon #494",
"demon #495",
"demon #496",
"demon #497",
"broom",
"mop",
"vase",
"candleholder #501",
"candleholder #502",
"phonograph",
"rice",
"flour",
"detergent",
"battle axe",
"snake #508",
"cage #509",
"book #510",
"book #511",
"watering pot",
"blotter",
"tarp",
"plate #515",
"plant #516",
"plant #517",
"plant #518",
"cat #519",
"papyrus #520",
"papyrus #521",
"papyrus #522",
"scroll #523",
"scroll #524",
"scroll #525",
"bag #526",
"bag #527",
"cat #528",
"radio",
"plant #530",
"snake #531",
"letter",
"plant #533",
"amulet",
"sugar",
"bird",
"doll",
"towel #538",
"towel #539",
"plant #540",
"salami",
"diary #542",
"diary #543",
"plant #544",
"plant #545",
"book #546",
"book #547",
"bowl #548",
"bag #549",
"box #550",
"plant #551",
"plant #552",
"clay pot",
"towel #554",
"towel #555",
"towel #556",
"towel #557",
"voodoo doll",
"voodoo mask #559",
"voodoo mask #560",
"voodoo mask #561",
"bowl #562",
"salt",
"plate #564",
"book #565",
"book #566",
"cross #567",
"card #568",
"card #569",
"card #570",
"card #571",
"card #572",
"card #573",
"card #574",
"card #575",
"card #576",
"card #577",
"hat box",
"bouquet",
"jar #580",
"star #581",
"pillow #582",
"pot #583",
"pillow #584",
"pan #585",
"pan #586",
"pot #587",
"beater",
"pot #589",
"bottle #590",
"bottle #591",
"tray",
"lit match #593",
"lit match #594",
"lit match #595",
"lit match #596",
"lit match #597",
"lit match #598",
"hat",
"bag #600",
"envelope",
"pepper mill",
"baster",
"towel #604",
"towel #605",
"box #606",
"pillow #607",
"pan #608",
"spatula",
"box #610",
"box #611",
"lit candle #612",
"candle #613",
"banana #614",
"banana #615",
"can",
"spider #617",
"spider #618",
"matchbox",
"pillow #620",
"jar #621",
"jar #622",
"lamp #623",
"lamp #624",
"key #625",
"knife #626",
"knife #627",
"gem #628",
"gem #629",
"bottle #630",
"knife #631",
"lit candle #632",
"candle #633",
"key #634",
"bottle #635",
"bottle #636",
"spray can",
"brush",
"match #639",
"match #640",
"match #641",
"match #642",
"match #643",
"match #644",
"knife #645",
"jar #646",
"jar #647",
"jar #648",
"book #649",
"book #650",
"star #651",
"thermometer",
"apple #653",
"apple #654",
"knife #655",
"paintbrush #656",
"cookie",
"bottle #658",
"bottle #659",
"bottle #660",
"bottle #661",
"bottle #662",
"bottle #663",
"bottle #664",
"bottle #665",
"bottle #666",
"bottle #667",
"bottle #668",
"bottle #669",
"burnt out match #670",
"burnt out match #671",
"burnt out match #672",
"burnt out match #673",
"burnt out match #674",
"burnt out match #675",
"bottle #676",
"bottle #677",
"bottle #678",
"bottle #679",
"bottle #680",
"bottle #681",
"bottle #682",
"bottle #683",
"plum #684",
"plum #685",
"soap",
"bottle #687",
"bottle #688",
"bottle #689",
"bottle #680",
"black hole",
"You"
// no NULL is required
};

// 7. MODULE STRUCTURES --------------------------------------------------

MODULE struct ColumnInfo TheColumnInfo[] =
{ { 0,                 /* WORD   ci_Width */
    NULL,              /* STRPTR ci_Title */
    CIF_FIXED          /* ULONG  ci_Flags */
  },
  { 0,
    NULL,
    CIF_WEIGHTED
  },
  { -1,
    (STRPTR) ~0,
    -1
} };

// 8. CODE ---------------------------------------------------------------

EXPORT void icom_main(void)
{   PERSIST FLAG first = TRUE;

    if (first)
    {   first = FALSE;

        // icom_preinit()
        NewList(&MainList);
        NewList(&SubList);
    }

    tool_open      = icom_open;
    tool_loop      = icom_loop;
    tool_save      = icom_save;
    tool_close     = icom_close;
    tool_exit      = icom_exit;
    tool_subgadget = icom_subgadget;

    if (loaded != FUNC_ICOM && !icom_open(TRUE))
    {   function = page = FUNC_MENU;
        return;
    } // implied else
    loaded = FUNC_ICOM;

    makemainlist();

    make_speedbar_list(GID_ICOM_SB1);
    InitHook(&ToolHookStruct, (ULONG (*)()) ToolHookFunc, NULL);
    lockscreen();

    if (!(WinObject =
    NewToolWindow,
        WA_SizeGadget,                                     TRUE,
        WA_ThinSizeGadget,                                 TRUE,
        WINDOW_Position,                                   SPECIALWPOS,
        WINDOW_ParentGroup,                                gadgets[GID_ICOM_LY1] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                             TRUE,
            LAYOUT_DeferLayout,                            TRUE,
            AddHLayout,
                AddToolbar(GID_ICOM_SB1),
                AddSpace,
                CHILD_WeightedWidth,                       50,
                AddHLayout,
                    LAYOUT_VertAlignment,                  LALIGN_CENTER,
                    LAYOUT_AddChild,                       gadgets[GID_ICOM_CH1] = (struct Gadget*)
                    PopUpObject,
                        GA_ID,                             GID_ICOM_CH1,
                        GA_Disabled,                       TRUE,
                        CHOOSER_LabelArray,                &GameOptions,
                    ChooserEnd,
                    Label("Game:"),
                    CHILD_WeightedHeight,                  0,
                LayoutEnd,
                CHILD_WeightedWidth,                       0,
                AddSpace,
                CHILD_WeightedWidth,                       50,
            LayoutEnd,
            CHILD_WeightedHeight,                          0,
            AddVLayout,
                LAYOUT_VertAlignment,                      LALIGN_CENTER,
                LAYOUT_BevelStyle,                         BVS_GROUP,
                LAYOUT_Label,                              "Item Locations",
                LAYOUT_SpaceOuter,                         TRUE,
                LAYOUT_SpaceInner,                         TRUE,
                LAYOUT_AddChild,                           gadgets[GID_ICOM_LB2] = (struct Gadget*)
                ListBrowserObject,
                    GA_ID,                                 GID_ICOM_LB2,
                    GA_RelVerify,                          TRUE,
                    LISTBROWSER_ColumnInfo,                (ULONG) &TheColumnInfo,
                    LISTBROWSER_Labels,                    (ULONG) &MainList,
                    LISTBROWSER_MinVisible,                1,
                    LISTBROWSER_ShowSelected,              TRUE,
                    LISTBROWSER_ColumnTitles,              FALSE,
                    LISTBROWSER_AutoFit,                   TRUE,
                    LISTBROWSER_Striping,                  LBS_ROWS,
                    LISTBROWSER_AutoWheel,                 FALSE,
                ListBrowserEnd,
            LayoutEnd,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    openwindow(GID_ICOM_SB1);
    writegadgets();
    loop();
    readgadgets();
    closewindow();
}

EXPORT void icom_loop(ULONG gid, UNUSED ULONG code)
{   switch (gid)
    {
    case GID_ICOM_LB2:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_ICOM_LB2], (ULONG*) &whichitem);
        locationwindow();
}   }

EXPORT FLAG icom_open(FLAG loadas)
{   if (gameopen(loadas))
    {   switch (gamesize)
        {
        case 9812:
            game = DEJAVU1;
        acase 10158:
            game = SHADOWGATE;
        acase 11020:
            game = UNINVITED;
        acase 20032:
            game = DEJAVU2;
        adefault:
            DisplayBeep(NULL);
            return FALSE;
    }   }
    else
    {   return FALSE;
    }

    serializemode = SERIALIZE_READ;
    serialize();
    writegadgets();
    return TRUE;
}

MODULE void writegadgets(void)
{   if
    (   page != FUNC_ICOM
     || !MainWindowPtr
    )
    {   return;
    } // implied else

    gadmode = SERIALIZE_WRITE;
    eithergadgets();
}

MODULE void eithergadgets(void)
{   if (gadmode == SERIALIZE_WRITE)
    {   either_ch(GID_ICOM_CH1, &game); // this autorefreshes

        DISCARD SetGadgetAttrs(gadgets[GID_ICOM_LB2], MainWindowPtr, NULL, LISTBROWSER_Labels, ~0,        TAG_END);
        makemainlist();
        DISCARD SetGadgetAttrs(gadgets[GID_ICOM_LB2], MainWindowPtr, NULL, LISTBROWSER_Labels, &MainList, TAG_END);
        RefreshGadgets((struct Gadget*) gadgets[GID_ICOM_LB2], MainWindowPtr, NULL);
}   }

MODULE void readgadgets(void)
{   gadmode = SERIALIZE_READ;
    eithergadgets();
}

MODULE void serialize(void)
{   int i;

    offset = 2;

    switch (game)
    {
    case DEJAVU1:
        serialize2ulong(&itemlocation[DV1_ITEMS]);

        offset = 0x308; // start of items
        for (i = 0; i <= 222; i++)
        {   serialize2ulong(&itemlocation[i]);
        }
    acase DEJAVU2:
        serialize2ulong(&itemlocation[DV2_ITEMS]);

        offset = 0x71A; // start of items
        for (i = 0; i <= 310; i++)
        {   serialize2ulong(&itemlocation[i]);
        }
    acase SHADOWGATE:
        serialize2ulong(&itemlocation[SG_ITEMS]); // $002..$003

        offset = 0x182; // start of items
        for (i = 0; i < SG_ITEMS; i++)
        {   serialize2ulong(&itemlocation[i]);
        }
    acase UNINVITED:
        serialize2ulong(&itemlocation[UI_ITEMS]); // $002..$003

        offset = 0x1DA; // start of items
        for (i = 0; i < UI_ITEMS; i++)
        {   serialize2ulong(&itemlocation[i]);
}   }   }

EXPORT void icom_save(FLAG saveas)
{   readgadgets();
    serializemode = SERIALIZE_WRITE;
    serialize();
    switch (game)
    {
    case  DEJAVU1:    gamesave("#?", "Deja Vu 1" , saveas, gamesize, FLAG_S, FALSE);
    acase DEJAVU2:    gamesave("#?", "Deja Vu 2" , saveas, gamesize, FLAG_S, FALSE);
    acase SHADOWGATE: gamesave("#?", "Shadowgate", saveas, gamesize, FLAG_S, FALSE);
    acase UNINVITED:  gamesave("#?", "Uninvited" , saveas, gamesize, FLAG_S, FALSE);
}   }

EXPORT void icom_exit(void)
{   lb_clearlist(&MainList);
    lb_clearlist(&SubList);
}

EXPORT void icom_close(void) { ; }

MODULE void locationwindow(void)
{   int          i;
    struct Node* ListBrowserNodePtr;

    switch (game)
    {
    case DEJAVU1:
        for (i =     0; i <=    1; i++)
        {   strcpy(substring[i], dv1_LocationNames[i]);
        }
        for (i =     2; i <= 0x4D; i++)
        {   sprintf(substring[i], "At %s", dv1_LocationNames[i]);
        }
        for (i =  0x4E; i <= 0xCF; i++)
        {   sprintf(substring[i], "At exit #%d", i);
        }
        for (i =  0xD0; i <= 0x183; i++)
        {   sprintf(substring[i], "In %s", dv1_PropNames[i -  0xD0]);
        }
        for (i = 0x184; i <= DV1_LASTITEM; i++)
        {   sprintf(substring[i], "In %s", dv1_ItemNames[i - 0x184]);
        }
        for (i =     0; i <= DV1_LASTITEM; i++)
        {   if (!(ListBrowserNodePtr = AllocListBrowserNode
            (    1,              /* columns, */
                 LBNA_Column,    0,
                 LBNCA_Text,     substring[i],
            TAG_END)))
            {   rq("Can't create listbrowser.gadget node(s)!");
            }
            AddTail(&SubList, ListBrowserNodePtr); /* AddTail() has no return code */
        }
    acase DEJAVU2:
        for (i =     0; i <=     1; i++)
        {   strcpy(substring[i], dv2_LocationNames[i]);
        }
        for (i =     2; i <=    74; i++)
        {   sprintf(substring[i], "At %s", dv2_LocationNames[i]);
        }
        for (i =    75; i <= 0x327; i++)
        {   sprintf(substring[i], "Exit/prop #%d", i);
        }
        for (i = 0x328; i <= 0x38C; i++)
        {   sprintf(substring[i], "In %s", dv2_PropNames[i - 0x328]);
        }
        for (i = 0x38D; i <= DV2_LASTITEM; i++)
        {   sprintf(substring[i], "In %s", dv2_ItemNames[i - 0x38D]);
        }

        for (i =     0; i <= DV2_LASTITEM; i++)
        {   if (!(ListBrowserNodePtr = AllocListBrowserNode
            (    1,              /* columns, */
                 LBNA_Column,    0,
                 LBNCA_Text,     substring[i],
            TAG_END)))
            {   rq("Can't create listbrowser.gadget node(s)!");
            }
            AddTail(&SubList, ListBrowserNodePtr); /* AddTail() has no return code */
        }
    acase SHADOWGATE:
        for (i =             0; i <=         1; i++)
        {   strcpy(substring[i], sg_LocationNames[i]);
        }
        for (i =             2; i <= SG_LOCATIONS; i++)
        {   sprintf(substring[i], "At %s", sg_LocationNames[i]);
        }
        for (i = SG_LOCATIONS + 1; i <= SG_LASTEXIT ; i++)
        {   sprintf(substring[i], "At exit #%d", i);
        }
        for (i = SG_LASTEXIT  + 1; i <= SG_LASTITEM ; i++)
        {   sprintf(substring[i], "In %s", sg_ItemNames[i - SG_LASTEXIT - 1]);
        }
        for (i =             0; i <= SG_LASTITEM ; i++)
        {   if (!(ListBrowserNodePtr = AllocListBrowserNode
            (   1,              /* columns, */
                LBNA_Column,    0,
                LBNCA_Text,     substring[i],
            TAG_END)))
            {   rq("Can't create listbrowser.gadget node(s)!");
            }
            AddTail(&SubList, ListBrowserNodePtr); /* AddTail() has no return code */
        }
    acase UNINVITED:
        for (i =             0; i <=         1; i++)
        {   strcpy(substring[i], ui_LocationNames[i]);
        }
        for (i =             2; i <= UI_LOCATIONS; i++)
        {   sprintf(substring[i], "At %s", ui_LocationNames[i]);
        }
        for (i = UI_LOCATIONS + 1; i <= UI_LASTEXIT ; i++)
        {   sprintf(substring[i], "At exit #%d", i);
        }
        for (i = UI_LASTEXIT  + 1; i <= UI_LASTITEM ; i++)
        {   sprintf(substring[i], "In %s", ui_ItemNames[i - UI_LASTEXIT - 1]);
        }
        for (i =             0; i <= UI_LASTITEM ; i++)
        {   if (!(ListBrowserNodePtr = AllocListBrowserNode
            (   1,              /* columns, */
                LBNA_Column,    0,
                LBNCA_Text,     substring[i],
            TAG_END)))
            {   rq("Can't create listbrowser.gadget node(s)!");
            }
            AddTail(&SubList, ListBrowserNodePtr); /* AddTail() has no return code */
    }   }

    InitHook(&ToolSubHookStruct, (ULONG (*)()) ToolSubHookFunc, NULL);
    lockscreen();

    if (!(SubWinObject =
    NewSubWindow,
        WA_SizeGadget,                         TRUE,
        WA_ThinSizeGadget,                     TRUE,
        WA_Title,                              "Choose Location",
        WINDOW_Position,                       WPOS_CENTERMOUSE,
        WINDOW_UniqueID,                       "icom-1",
        WINDOW_ParentGroup,                    gadgets[GID_ICOM_LY2] = (struct Gadget*)
        VLayoutObject,
            LAYOUT_SpaceOuter,                 TRUE,
            LAYOUT_DeferLayout,                TRUE,
            LAYOUT_AddChild,                   gadgets[GID_ICOM_LB1] = (struct Gadget*)
            ListBrowserObject,
                GA_ID,                         GID_ICOM_LB1,
                GA_RelVerify,                  TRUE,
                LISTBROWSER_Labels,            (ULONG) &SubList,
                LISTBROWSER_MinVisible,        1,
                LISTBROWSER_ShowSelected,      TRUE,
                LISTBROWSER_AutoWheel,         FALSE,
            ListBrowserEnd,
            CHILD_MinWidth,                    300,
            CHILD_MinHeight,                   512,
        LayoutEnd,
    WindowEnd))
    {   rq("Can't create gadgets!");
    }
    unlockscreen();
    if (!(SubWindowPtr = (struct Window*) RA_OpenWindow(SubWinObject)))
    {   rq("Can't open window!");
    }

    DISCARD SetGadgetAttrs(         gadgets[GID_ICOM_LB1], SubWindowPtr, NULL, LISTBROWSER_Selected,    (ULONG) itemlocation[whichitem], TAG_END);
    DISCARD SetGadgetAttrs(         gadgets[GID_ICOM_LB1], SubWindowPtr, NULL, LISTBROWSER_MakeVisible, (ULONG) itemlocation[whichitem], TAG_END);
    RefreshGadgets((struct Gadget*) gadgets[GID_ICOM_LB1], SubWindowPtr, NULL);

    subloop();

    DisposeObject(SubWinObject);
    SubWinObject = NULL;
    SubWindowPtr = NULL;

    lb_clearlist(&SubList);
}

EXPORT FLAG icom_subgadget(ULONG gid, UNUSED UWORD code)
{   ULONG temp;

    switch (gid)
    {
    case GID_ICOM_LB1:
        DISCARD GetAttr(LISTBROWSER_Selected, (Object*) gadgets[GID_ICOM_LB1], (ULONG*) &temp);
        itemlocation[whichitem] = temp;
        writegadgets();
        return TRUE;
    }

    return FALSE;
}

MODULE void makemainlist(void)
{   int          i;
    struct Node* ListBrowserNodePtr;

    lb_clearlist(&MainList);

    switch (game)
    {
    case DEJAVU1:
        for (i = 0; i <= DV1_ITEMS; i++)
        {   if   (itemlocation[i] <=            1) strcpy( liststring[i], dv1_LocationNames[itemlocation[i]]);
            elif (itemlocation[i] <=         0x4D) sprintf(liststring[i], "At %s", dv1_LocationNames[itemlocation[i]]);
            elif (itemlocation[i] <=         0xCF) sprintf(liststring[i], "At exit #%d", (int) itemlocation[i]);
            elif (itemlocation[i] <=        0x183) sprintf(liststring[i], "In %s", dv1_PropNames[itemlocation[i] -  0xD0]);
            else                                   sprintf(liststring[i], "In %s", dv1_ItemNames[itemlocation[i] - 0x184]);
            if (!(ListBrowserNodePtr = AllocListBrowserNode
            (    2,              /* columns, */
                 LBNA_Column,    0,
                 LBNCA_CopyText, TRUE,
                 LBNCA_Text,     dv1_ItemNames[i],
                 LBNA_Column,    1,
                 LBNCA_CopyText, TRUE,
                 LBNCA_Text,     liststring[i],
            TAG_END)))
            {   rq("Can't create listbrowser.gadget node(s)!");
            }
            AddTail(&MainList, ListBrowserNodePtr); /* AddTail() has no return code */
        }
    acase DEJAVU2:
        for (i = 0; i <= DV2_ITEMS; i++)
        {   if   (itemlocation[i] <=            1) strcpy( liststring[i], dv2_LocationNames[itemlocation[i]]);
            elif (itemlocation[i] <=           75) sprintf(liststring[i], "At %s", dv2_LocationNames[itemlocation[i]]);
            elif (itemlocation[i] <         0x328) sprintf(liststring[i], "Exit/prop #%d", (int) itemlocation[i]);
            elif (itemlocation[i] <         0x38D) sprintf(liststring[i], "In %s", dv2_PropNames[itemlocation[i] - 0x328]);
            else                                   sprintf(liststring[i], "In %s", dv2_ItemNames[itemlocation[i] - 0x38D]);
            if (!(ListBrowserNodePtr = AllocListBrowserNode
            (    2,              /* columns, */
                 LBNA_Column,    0,
                 LBNCA_CopyText, TRUE,
                 LBNCA_Text,     dv2_ItemNames[i],
                 LBNA_Column,    1,
                 LBNCA_CopyText, TRUE,
                 LBNCA_Text,     liststring[i],
            TAG_END)))
            {   rq("Can't create listbrowser.gadget node(s)!");
            }
            AddTail(&MainList, ListBrowserNodePtr); /* AddTail() has no return code */
        }
    acase SHADOWGATE:
        for (i = 0; i <= SG_ITEMS; i++)
        {   if   (itemlocation[i] <= 1           ) strcpy( liststring[i], sg_LocationNames[itemlocation[i]]);
            elif (itemlocation[i] <= SG_LOCATIONS) sprintf(liststring[i], "At %s", sg_LocationNames[itemlocation[i]]);
            elif (itemlocation[i] <= SG_LASTEXIT ) sprintf(liststring[i], "At exit #%d", (int) itemlocation[i]);
            elif (itemlocation[i] <= SG_LASTITEM ) sprintf(liststring[i], "In %s", sg_ItemNames[itemlocation[i] - SG_LASTEXIT - 1]);
            // else panic?
            if (!(ListBrowserNodePtr = AllocListBrowserNode
            (   2,              /* columns, */
                LBNA_Column,    0,
                LBNCA_CopyText, TRUE,
                LBNCA_Text,     sg_ItemNames[i],
                LBNA_Column,    1,
                LBNCA_CopyText, TRUE,
                LBNCA_Text,     liststring[i],
            TAG_END)))
            {   rq("Can't create listbrowser.gadget node(s)!");
            }
            AddTail(&MainList, ListBrowserNodePtr); /* AddTail() has no return code */
        }
    acase UNINVITED:
        for (i = 0; i <= UI_ITEMS; i++)
        {   if   (itemlocation[i] <= 1           ) strcpy( liststring[i], ui_LocationNames[itemlocation[i]]);
            elif (itemlocation[i] <= UI_LOCATIONS) sprintf(liststring[i], "At %s", ui_LocationNames[itemlocation[i]]);
            elif (itemlocation[i] <= UI_LASTEXIT ) sprintf(liststring[i], "At exit #%d", (int) itemlocation[i]);
            elif (itemlocation[i] <= UI_LASTITEM ) sprintf(liststring[i], "In %s", ui_ItemNames[itemlocation[i] - UI_LASTEXIT - 1]);
            // else panic?
            if (!(ListBrowserNodePtr = AllocListBrowserNode
            (   2,              /* columns, */
                LBNA_Column,    0,
                LBNCA_CopyText, TRUE,
                LBNCA_Text,     ui_ItemNames[i],
                LBNA_Column,    1,
                LBNCA_CopyText, TRUE,
                LBNCA_Text,     liststring[i],
            TAG_END)))
            {   rq("Can't create listbrowser.gadget node(s)!");
            }
            AddTail(&MainList, ListBrowserNodePtr); /* AddTail() has no return code */
}   }   }

EXPORT FLAG icom_subkey(UWORD code, UWORD qual)
{   ULONG max;

    switch (game)
    {
    case  DEJAVU1:    max = DV1_LASTITEM;
    acase DEJAVU2:    max = DV2_LASTITEM;
    acase SHADOWGATE: max = SG_LASTITEM;
    acase UNINVITED:  max = UI_LASTITEM;
    adefault:         max = 0; // initialized to avoid a spurious SAS/C warning
    }

    switch (code)
    {
    case SCAN_RETURN:
    case SCAN_ENTER:
        return TRUE;
    acase SCAN_UP:
    case NM_WHEEL_UP:
        if (lb_move_up(GID_ICOM_LB1, SubWindowPtr, qual, &itemlocation[whichitem], 0, 62))
        {   writegadgets();
        }
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        if (lb_move_down(GID_ICOM_LB1, SubWindowPtr, qual, &itemlocation[whichitem], max, 62))
        {   writegadgets();
    }   }

    return FALSE;
}

EXPORT void icom_key(UBYTE scancode, UWORD qual)
{   switch (scancode)
    {
    case SCAN_UP:
    case NM_WHEEL_UP:
        lb_scroll_up(GID_ICOM_LB2, MainWindowPtr, qual);
    acase SCAN_DOWN:
    case NM_WHEEL_DOWN:
        lb_scroll_down(GID_ICOM_LB2, MainWindowPtr, qual);
}   }
