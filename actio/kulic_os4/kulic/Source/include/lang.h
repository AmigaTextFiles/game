#ifndef _KULIC_LANGUAGE_INCLUDE_
#define _KULIC_LANGUAGE_INCLUDE_
/////////////////////////////////////////////////////////
//                        TADY ZEDITOVAT   
//  - podle jazyku, ktery chcete. Ten, ktery chcete, tak tam nesmi
//  byt pred #define //
 
#define _KULIC_ENGLISH_
//#define _KULIC_CZECH_
//#define _KULIC_GERMAN_

#ifdef _KULIC_ENGLISH_
// anglicke texty
// hlavni menu
#define T_MMAIN_NADPIS      "MAIN MENU"
#define T_MMAIN_VICEHRACU   "MULTI PLAYER"
#define T_MMAIN_SINGLE      "SINGLE PLAYER"
#define T_MMAIN_DEMO        "DEMO"
#define T_MMAIN_NASTAVENI   "SETTING"
#define T_MMAIN_KONEC       "EXIT"

#define T_MCREDITS_AUTORI   "- AUTORS -"

#define T_MENU_ZPET         "BACK"

#define T_MSINGLE_NAME      "NAME - %s"
#define T_MSINGLE_POSTAVA   "< CHARACTER >"
#define T_MSINGLE_DEN       " DAY >"
#define T_MSINGLE_NOC       "< NIGHT "

#define T_MPOCITAC_HAR      "PLAY"
#define T_MPOCITAC_AI_DIFF  "< LEVEL %d - %d >" 
#define T_MPOCITAC_PROTI    "ALL VS ALL"
#define T_MPOCITAC_KILLME   "KILL ME"
#define T_MPOCITAC_COMPU    "< %d AI >"

#define T_MESSAGE_FRAGS   "YOU HAVE %d FRAGS"
#define T_MESSAGE_RUN_ON  "AUTORUN ON"
#define T_MESSAGE_RUN_OFF "AUTORUN OFF"
#define T_MESSAGE_CLEAN   "CLEANING GROUND"
#define T_MESSAGE_CDSONG  "NEW CD SONG"
#define T_MESSAGE_WIEV_OK "STANDART GROUND"
#define T_MESSAGE_WIEV_2  "WALK GROUND"
#define T_MESSAGE_ZAM_ON  "DIRECTOR ON"
#define T_MESSAGE_ZAM_OFF "DIRECTOR OFF"

#define T_DABVELSKYNAPIS "You are devil - 666 frags !!"


#define MAX_UKILL 7
const char u_kill[MAX_UKILL][40] = {
	"WAS KILLED BY YOU",
	"WAS TOO WEEK",
	"IS SMASHED TO PEACES",
	"WAS TOTALY DESTROYED",
	"IS DEAD",
	"ISN'T WITH US",
	"IS KICKED OFF"
};

#define MAX_UKILLED 3
const char u_killed[MAX_UKILLED][60] = {
	"KILLED YOU",
	"GOT YOU",
	"DESTROYED YOU, TRY LITTLE BIT MORE",
};

#endif

// ceske texty
#ifdef _KULIC_CZECH_
// hlavni menu
#define T_MMAIN_NADPIS      "HLAVNI MENU"
#define T_MMAIN_VICEHRACU   "VICE HRACU"
#define T_MMAIN_SINGLE      "PROTI POCITACUM"
#define T_MMAIN_DEMO        "UKAZKA"
#define T_MMAIN_NASTAVENI   "NASTAVENI"
#define T_MMAIN_KONEC       "KONEC"

#define T_MCREDITS_AUTORI   "- AUTORI -"

#define T_MENU_ZPET         "ZPET"

#define T_MSINGLE_NAME      "JMENO - %s"
#define T_MSINGLE_POSTAVA   "< POSTAVA >"
#define T_MSINGLE_DEN       " DEN >"
#define T_MSINGLE_NOC       "< NOC "

#define T_MPOCITAC_HAR      "HRA"
#define T_MPOCITAC_AI_DIFF  "< OBTIZNOSTI %d - %d >" 
#define T_MPOCITAC_PROTI    "VSICHNI PROTI VSEM"
#define T_MPOCITAC_KILLME   "POJDTE SI PRO ME"
#define T_MPOCITAC_COMPU    "< OPONENTI - %d  >"

#define T_MESSAGE_FRAGS   "DOSAHL JSI %d FRAGU"
#define T_MESSAGE_RUN_ON  "AUTOMATICKE BEHANI ZAPNUTO"
#define T_MESSAGE_RUN_OFF "AUTOMATICKE BEHANI VYPNUT"
#define T_MESSAGE_CLEAN   "PROBEHLO CISTENI PODKLADU OD MRTVOL"
#define T_MESSAGE_CDSONG  "NOVA CD SKLADBA"
#define T_MESSAGE_WIEV_OK "STANDARTNI ZOBRAZENI"
#define T_MESSAGE_WIEV_2  "ZOBRAZENI PRUCHODNODTI"
#define T_MESSAGE_ZAM_ON  "ZAMEROVAC ZAPNUT"
#define T_MESSAGE_ZAM_OFF "ZAMEROVAC VYPNUT"

#define T_DABVELSKYNAPIS "Jsi dabel, mas 666 fragu !!"



#define MAX_UKILL 10
const char u_kill[MAX_UKILL][40] = {
	"TI PODLEHL",
	"NEODOLAL TVEMU NAPORU",
	"SE DIKY TOBE VALI V KRVY",
	"NEVYDRZEL TVE VRAZEDNE TEMPO",
	"JE UPLNE LEVEJ A UPLNE MRTVEJ",
	"ODESEL DO VECNYCH LOVIST",
	"UZ NENI MEZI NAMI",

   "TO MA ZA SEBOU",
   "SI TE NAJDE NEKDY JINDY",
   "JE NAPROSTO VYRIZENEJ",
};

#define MAX_UKILLED 10
const char u_killed[MAX_UKILLED][60] = {
	"TE DOSTAL",
	"TE ZABIL",
	"TE UPLNE VYMAZAL, KOUKEJ SE TROCHU SNAZIT",
	"JE PRVNI, KOMU SE POMSTIS",
	"SI TE PODAL",

   "TI TO OPRAVIL",
   "TE PEKNE ZRUBAL",
   "SI TE NASEL",
   "JE HOLT LEPSI NEZ TY",
   "JE TEN, KOHO SI PORADNE PODAS",
};


#endif

#ifdef _KULIC_GERMAN_

#define T_MMAIN_NADPIS      "HAUPTMENU"
#define T_MMAIN_VICEHRACU   "MEHRSPIELER"
#define T_MMAIN_SINGLE      "EINZELSPIELER"
#define T_MMAIN_DEMO        "DEMO"
#define T_MMAIN_NASTAVENI   "EINSTELLUNGEN"
#define T_MMAIN_KONEC       "BEENDEN"

#define T_MCREDITS_AUTORI   "- AUTOREN -"

#define T_MENU_ZPET         "ZURUECK"   // (if You don't have the Ü - use UE)

#define T_MSINGLE_NAME      "NAME - %s"
#define T_MSINGLE_POSTAVA   "< CHARAKTER >"
#define T_MSINGLE_DEN       " TAG >"
#define T_MSINGLE_NOC       "< NACHT "

#define T_MPOCITAC_HAR      "SPIELEN"
#define T_MPOCITAC_AI_DIFF  "< LEVEL %d - %d >" 
#define T_MPOCITAC_PROTI    "JEDER GEGEN JEDEN"
#define T_MPOCITAC_KILLME   "TOETET MICH"  // (if you don't have the Ö - use OE)
#define T_MPOCITAC_COMPU    "< %d KI >"

#define T_MESSAGE_FRAGS   "DU HAST %d TOETUNGEN" // (no Ö ? use OE)
#define T_MESSAGE_RUN_ON  "AUTORUN AN"
#define T_MESSAGE_RUN_OFF "AUTORUN AUS"
#define T_MESSAGE_CLEAN   "BODEN WIRD BERAEUMT" // (no Ä ? use AE)
#define T_MESSAGE_CDSONG  "NEUER CD TITEL"
#define T_MESSAGE_WIEV_OK "STANDART BODEN"
#define T_MESSAGE_WIEV_2  "LAUF BODEN"
#define T_MESSAGE_ZAM_ON  "DIRECTOR AN"
#define T_MESSAGE_ZAM_OFF "DIRECTOR AUS"

#define T_DABVELSKYNAPIS "Du bist der Teufel - 666 Toetungen !!" // (no ö? use oe)


#define MAX_UKILL 7
const char u_kill[MAX_UKILL][40] = {
	"WURDE VON DIR GETOETET",   // (no Ö? use OE)
	"WAR ZU SCHWACH",
	"IST IN STUECKE ZERISSEN", // (no Ü? use UE)
	"WURDE TOTAL ZERSTOERT",   // (no Ö? use OE)
	"IST TOT",
	"WEILT NICHT MEHR UNTER UNS",
	"WURDE RAUSGESCHMISSEN"
};

#define MAX_UKILLED 3
const char u_killed[MAX_UKILLED][60] = {
	"HAT DICH GETOETET",      // (no Ö? use OE)
	"HAT DICH ERWISCHT",
	"HAT DICH VERNICHTET, VERSUCHE BESSER ZU SEIN!",
};

#endif

#endif
