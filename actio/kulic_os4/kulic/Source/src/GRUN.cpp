// GRun.cpp: implementation of the GRun class.
//
//////////////////////////////////////////////////////////////////////

#include "stdh.h"

#include "GSoldier.h"
#include "GView.h"
#include "GMap.h"
#include "GRun.h"
#include "zbrane.h"
#include "iostream.h"

//#include "MultiPlay.h"

#include "inifile.h"
extern st_inifile ini;



BITMAP *b_pause;  // obrazek pri stisknuti pause

#define MSG_SOLD_STAT    1
#define MSG_CONTROL_STAT 2
/*
#define AI_NAMES  70
const char ai_names[AI_NAMES][40] = {
	"HIPPO",     "DOOM",     "KULATOR",   "QUAKOSH",       "STUPIDIO",     "ZEUS",       "TERMINATOR",
	"GATES",     "LINUX",    "ERROR",     "HANZ",          "HITLER",       "STALIN",     "GORBACOV",
	"ZEMAN",     "VUL",      "VINETOU",   "BILL",          "SAM",          "MOLOCH",     "RAMBO", 
	"PRASAK",    "LENIN",    "WINZIP",    "MIRCOSOFT",     "VETRELEC",     "KULIC",      "RAYEN",  
   "ROBOCOP",   "KUDLANKA", "KRAKATICE", "ZRALOK",        "PREDATOR",     "JAMES BOND", "DART VADER",
	"SKYWALKER", "NAPOLEON", "CEZAR",     "CISAR",         "PAPEZ",        "LEWINSKA",   "GOLEM", 
	"RADEGAST",  "SVATOVIT", "PERUN",     "GAMBRINUS",     "IMPERATOR",    "BUDWAR",     "STAROPRAMEN",
	"NEPTUN",    "ROLAND",   "MR. BEAN",  "KING KONG",     "KAREL IV.",    "KOMUNISTA",  "DEWIL",
	"CARTMAN",   "KENNY",    "KYLE",      "HOMER SIMPSON", "BART SIMPSON", "ESMERLANDA", "LUNETIC",
	"HANIBAL",   "KYKLOP",   "KLEOPATRA", "ODYSSEUS",      "NAUTILUS",     "LIKVIDATOR", "ALEXANDR VELIKY",
};
*/

#define AI_NAMES  299


const char ai_names[AI_NAMES][40] = {
      // 70
	"HIPPO",    "ROB",      "HELMUT",  "SLAYER",  "DUKE",      "PSYCHO",     "SCOTY",
	"GATES",    "SNOOPY",   "PIGSY",   "HANZ",    "ALF",       "HAWKING",    "JIGGLE",
	"CROOK",    "BUCKET",   "ROCKY",   "BILL",    "SAM",       "RAZZO",      "FLAPPER", 
	"RAYMAN",   "CHUCKIE",  "DENNIS",  "FLUFFIE", "GAMBIT",    "KULIC",      "RAYEN",  
	"JESSIE",   "BLUBBER",  "LEMMY",   "STOOFER", "ERIC",      "JAMES",      "ISAAC",
	"LOUISE",   "WALTER",   "WOODY",   "MUMPS",   "CHUCKY",    "BETY",       "HUTCH", 
	"RADEGAST", "SVATOVIT", "PERUN",   "MOOSE",   "IMPERATOR", "BUSTER",     "CHEGWIN",
	"KIRA",     "ROLAND",   "KNUCKLE", "ARTHUR",  "JIMMY",     "THOMAS",     "DEWIL",
	"CARTMAN",  "KENNY",    "KYLE",    "HOMER",   "BART",      "ESMERLANDA", "CALIN",
	"HANIBAL",  "CAGNEY",   "DOYLE",   "TIKKA",   "YIRRA",     "ITCHY",      "SCRATCHY",

     // 80
        "GUSTER",   "LOONEY",    "GORDON",  "DONALD",   "SPANNER",      "RITCHIE", "MEEKER",
        "ALICE",    "DREW",      "MIKE",    "STAN",     "MR. GARRISON", "RAY",     "ARNIE",
        "GLOOMY",   "PERRY",     "DANETTE", "SLIM",     "JACK",         "KIRBY",   "DIPPY"
        "LISTER",   "FRED",      "DAX",     "PAUL",     "SLAVE",        "LUKE",    "FRANK",
        "SQUASHER", "SLAMMER",   "SMASHER", "SQUEZZER", "BOMBER",       "SVEN",    "MOOWOO",
        "RICK",     "NICK",      "JEREMY",  "THUMPER",  "STUNNER",      "MITCH",   "ROGER",
        "CLINKY",   "GAZ",       "PEON",    "PIPE",     "PINKY",        "BILLY",   "FONZ",
        "CARVEY",   "UNCLE SAM", "SLASHER", "BEAVER",   "EDDY",         "MONKEY",  "SKINNER",
        "VICTOR",   "JERKY",     "NOEL",    "MAKUMBA",  "JEWELL",       "MARRY",   "JACQUELINE",
        "SLAPPER",  "FLOYD",     "CHICO",   "VEA",      "GURNEY",       "SYDNEY",  "STAVROS"
        "FLAMER",   "LEMMING",   "BRED",    "SANDRA",   "GRABBER",      "RIPPER",  "DONUT",
        "DETROIT",  "SUZANNE",   "FOX",

     // 70
        "ELIS",       "SKULLCRUSHER", "BEAWIS",      "BUTHEAD",    "KHALIS",    "GEOFREY",     "GOOFY",
	"DAEMON",     "CRIPSY",       "WAVEY",       "MARVIN",     "SCREAMER",  "VANILA ICE",  "JIBSEY",
	"TWISTER",    "QUICKEN",      "SPEEDWALKER", "SOULHUNTER", "BUZZ",      "HARDY",       "CHIP",
	"DAYLAN",     "ROBBIE",       "QUIGLEY",     "ABDUL",      "NORMAN",    "JOE",         "JACKIE",
	"DEATH HEAD", "FLICKER",      "STONECUTTER", "SNIF",       "JERRY",     "TIMMY",       "NICHOLAS",
	"DIKE",       "WIMPY",        "FATMAN",      "BIRDEYE",    "MORGG",     "NEWBIE",      "POWEWOWE", 
	"GRUNT",      "MOUSER",       "JOSHUA",      "FIREFLY",    "BUMBLEBEE", "GRASSHOPPER", "CHERRY",
	"ALEX",       "DAVISON",      "FREDDY",      "GRISOLD",    "NIGHTMARE", "KATE",        "RIKKI",
	"JUMPER",     "STUART",       "ALFRED",      "RAPSEY",     "ASHKEN",    "AMOEBA",      "URUBAMBA",
	"WILFRED",    "CAGLES",       "EARTHWORM",   "SHIVA",      "BLAZE",     "MAX",         "TICKER",

     // 80
        "GASTON",     "BRELL",    "VOREMUS",  "SWAP",     "CRAWLER",  "WILLIAM",  "YETTI",
        "SASQUOCH",   "BIGFOOT",  "SINCLAIR", "BIKER",    "YUPPIE",   "WORMY",    "BLACKIE",
        "HERBERT",    "HOBBIE",   "THOBIAS",  "HAM",      "STARWING", "GEORGE",   "GERRY"
        "LUCAS",      "LAMBERT",  "LAMER",    "DEBBIE",   "SLOWMAN",  "WENDY",    "MEOWMAN",
        "PITFALL",    "JONES",    "ADAM",     "EVE",      "KERBEROS", "DANN",     "KAINE",
        "ROMEO",      "JULLIET",  "HAMLET",   "DUCKMAN",  "BECKMAN",  "CORIN",    "PASCO",
        "PEDRO",      "THEODOR",  "MOOMY",    "ZIKKIE",   "JACOB",    "EFRAIM",   "KURT",
        "BOMBUR",     "BIFUR",    "THORIN",   "EFFENDI",  "HAROLD",   "ROY",      "DIANA",
        "HUGO",       "JASON",    "BIVOJ",    "PETE",     "GIMME",    "MICKEY",   "CHARLIE",
        "VANDA",      "YODDA",    "PHORTOS",  "ATHOS",    "ARAMIS",   "KIRK",     "JEAN-LUC"
        "JEHOVA",     "CUTHBERT", "ETHEL",    "MC.BROWN", "JOAN",     "MICHAEL",  "SNAKE",
        "SHAKER",     "HARRY",    "SEAN",

};

/*////////////////////////////////////////////////////////////////////////////////
	NULL-ovaci konstruktor
*/
GRun::GRun()
{
	m_autorun = false;

	m_game_speed = 5; // rychlost 20 snimku za sekundu

	m_doruststrel = true; // strely dorustaji
	m_maxstrel    = 50;   // na zacatku dostane vojak 50 % vybaveni
	m_gfx_loaded = GFX_LOADED_NO;

	m_maps = 0;
	m_effects = false;
}

/*////////////////////////////////////////////////////////////////////////////////
	Rusi ruzne dinamicke obekty
*/
GRun::~GRun()
{
}

/*////////////////////////////////////////////////////////////////////////////////
	Hlavni fce, diky ketre bezi samotna hra ( vsechno to kloubi dohromady )
*/
void GRun::Run()
{
   clear_keybuf();
   hscreen.m_mouse = false;

/*	net->ScanForPlayers();

	if(m_net.m_connected) {
		m_soldiers = 1;
		m_multi = true;
	}
	else m_multi = false;
*/	
	m_multi = false;

	m_monsol = 0;

	StartEffect();
//	cdplay.Play();
	m_map.StartGame();

	tmr  = 5; // 50 ms; -> 20 refreshu za sekundu
	do {

		// send data
		if (m_multi) {
//			m_net.UpdateSoldiers(this);
//			m_net.Send(this);
		}

		// zobrazeni
		Draw();

		// animace
		Animate();

		// nastaveni pocitace
		CompMove();

		UpdateInput(); // akualizace vstupu

		// zprava klaves
		ProcessKeys();

		// takhle hraje nas hrac
		SetCurPlCtrl();


		// a jedem
		Move();
		Crash();


//	 	if (m_multi)
//			m_net.Receive(this);

		while (tmr > 0);
		tmr = 5; // 50 ms; -> 20 refreshu za sekundu

//		if (m_multi)
//			m_net.Receive(this);


   } while (!key[KEY_ESC]);

//	cdplay.Pause();
	m_map.StopGame();


	hscreen.FadeDown();
}

/*////////////////////////////////////////////////////////////////////////////////
	Rusi vsechny bitmapy
*/
void GRun::Destroy()
{
	DestroyRunBitmaps();

	m_view.Destroy();
	m_map.Destroy();

	// smazani svetel
	DestroyBitmaps(&b_lights_mask[0], MAX_LIGHTS_MASKS);

	// mazani masek
	DestroyBitmaps(&b_strely_mask[0], MAX_STREL_MASKS);

	// svelta zablesku
	DestroyBitmaps(&b_zbrane_fire_l[0], MAX_ZBRANE_FIRE);

	// kour - polopruhledny
	DestroyBitmaps(&b_kour_mask[0], MAX_KOUR_MASKS);

	// vojaci do menu
	DestroyBitmaps(&b_solds_big[0], MAX_SOLD_BITMAPS);

	// mazani fontu
	DestroyFont();

	// bitmapa pauzy
	if (b_pause != NULL) {
		destroy_bitmap(b_pause);
		b_pause = NULL;
	}

	m_sshoots.DestroySFX();


	unload_datafile(fonts);
}

/*////////////////////////////////////////////////////////////////////////////////
	zaridi nacteni bitmap ( vraci false pri neuspechu )
*/
bool GRun::LoadGFX()
{
	draw_loading();

	Destroy(); // radsi to nejrve zlikvidujem ( pro jistotu )

	if (!UpdateGFX(m_svetlo)) return false;
	
/////////////
// Ostatni //
/////////////
	if (!m_map.LoadGFX()) return false;
	if (!m_view.LoadGFX(this)) return false;

	// svetelne masky
	if (!LoadMasksBitmaps(&b_lights_mask[0], MAX_LIGHTS_MASKS, 0, "gfx/lights/LMASK%d.BMP")) return false;

	// svetelne masky zablesku zbrani
	if (!LoadMasksBitmaps(&b_zbrane_fire_l[0], MAX_ZBRANE_FIRE, 0, "gfx/gun/FMASK%d.BMP")) return false;

	// polopruhledne masky strel
	if (!LoadBitmaps(&b_strely_mask[0], MAX_STREL_MASKS, 0, "gfx/shoots/SMASK%d.BMP")) return false;

	// kour
	if (!LoadMasksBitmaps(&b_kour_mask[0], MAX_KOUR_MASKS, 1, "gfx/fog/KOUR%dM.BMP")) return false;

	// vojaci do menu
	if (!LoadBitmaps(&b_solds_big[0], MAX_SOLD_BITMAPS, 1, "gfx/sold/sold%dm.bmp")) return false;


	// font
	if (!LoadFontGFX()) return false;

	// bitmapa pauzy
	if ((b_pause = hload_bitmap("gfx/other/pause.bmp")) == NULL) {
		allegro_message("Chybi soubor : gfx/other/pause.bmp");
		return false;
	}


	fonts = load_datafile("gfx/view/fonts.dat");
	if (fonts == NULL) 
		if ((fonts = load_datafile("/usr/local/share/kulic/gfx/view/fonts.dat")) == NULL)
			if ((fonts = load_datafile("/usr/share/kulic/gfx/view/fonts.dat")) == NULL) {
				allegro_message("chybi fonts.dat");
				return false;
			}

	if (!m_sshoots.LoadSFX()) {
		allegro_message("Chybi soubor shoots.dat");
		return false;
	}

	return true;
}



/*////////////////////////////////////////////////////////////////////////////////
	Zajisti vykresleni (+ flip screen)
*/
void GRun::Draw()
{
	hscreen.AcquireBack();

	if(ini.resolution) {
		DF_X = 320;
		DF_Y = 240;

		m_view.UpdateCamera(this);

		if (m_svetlo == GFX_LOADED_NORMAL)
			m_view.DrawAA( this, false, m_effects); // den
		else
			m_view.DrawAA(this, m_lighteffects, false); // noc
	}
	else {
		DF_X = 640;
		DF_Y = 480;

		m_view.UpdateCamera(this);

		if (m_svetlo == GFX_LOADED_NORMAL)
		m_view.Draw(hscreen.m_back, this, false, m_effects); // den
	else
		m_view.Draw(hscreen.m_back, this, m_lighteffects, false); // noc

	}



	hscreen.ReleaseBack();
	hscreen.Flip(true);
}

/*////////////////////////////////////////////////////////////////////////////////
	Zajisti pohnuti vsemi objkety
*/
void GRun::Move()
{
	m_map.Move(this);

	m_map.ShootHits(this);
	m_map.PickPowerUps(this);

	// pocitac
	if (!m_multi)
		for (int i = 1; i < m_soldiers; i++)
			m_sold[i].Move(this);
	// nas hrac
	m_sold[0].Move(this);
}

/*////////////////////////////////////////////////////////////////////////////////
	Testuje narazy
*/
void GRun::Crash()
{
//	int k = 0, // promena cyklu
//		 l = 0; // pocet narazeni
	
}

/*////////////////////////////////////////////////////////////////////////////////
	Pripravi hru na hru hrac vs. pocitace
*/
void GRun::InitSingle(int players)
{
	m_soldiers = players;
	m_sold[0].m_AI_l = -1;
}

/*////////////////////////////////////////////////////////////////////////////////
	Zinicializuje hru
	minAI a maxAI jsou obtiznosti
*/
bool GRun::Init(int minAI, int maxAI)
{
	int i,j;

	bool used[AI_NAMES]; // aby se jmena neopakovala

	UpdateGFX(m_svetlo);

	if (!m_map.LoadMap(m_mapa, m_svetlo)) {
		allegro_message("Nepodarilo se nacist mapu. ");
		return false;
	}

	for (i = 0; i < AI_NAMES; i++)
		used[i] = false;

	// Vojak
	for(i = 0; i < MAX_PLAYERS; i++) {
		if (i != 0) m_sold[i].m_ID = rand()%MAX_SOLDIERS;
		m_sold[i].Init(i, m_map.m_sx, m_map.m_sx, rand()%MAX_ZBRANE, true, 50, &m_map);
		m_sold[i].m_active = true;
		m_sold[i].m_turnspeed = TURNSENSITIVE;

		if (i > 0) {
			m_sold[i].m_AI_l = rand()%(maxAI-minAI+1) + minAI;
			j = rand()%AI_NAMES;
			while (used[j]) j = rand()%AI_NAMES;
			strcpy(m_sold[i].m_name, ai_names[j]);
			used[j] = true;
		}
	}


	m_map.InitDone();
	m_sold[0].m_AI_l = -1;



	m_view.Init(&m_sold[0]);

	m_map.NewPowerUp();
	m_map.NewPowerUp();
	m_map.NewPowerUp();

/*
  if (!m_net.EnterGame(this)) {
		allegro_message("Failed to HOST or JOIN game "); // SMULA !!!!
		return false;
  }
*/
  return true;
}

/*////////////////////////////////////////////////////////////////////////////////
	Hraje za pocitacove hrace
*/
void GRun::CompMove()
{
	int i;
	if (m_multi) return;
	
	for(i = 1; i < m_soldiers; i++)
		m_sold[i].CompMove(this, i);
}


/*////////////////////////////////////////////////////////////////////////////////
	Zpracovava vstupy z klavesnice
*/
void GRun::ProcessKeys()
{
	while (keypressed()) {
		int c;
		c = readkey() >> 8;
		switch (c) {
		case KEY_R :
			if ((m_autorun = !m_autorun)==true)
				m_view.AddMessage(T_MESSAGE_RUN_ON);
			else 
				m_view.AddMessage(T_MESSAGE_RUN_OFF);
			break;
		case KEY_F3 :
			m_map.ClearGround();
			m_view.AddMessage(T_MESSAGE_CLEAN);
			break;
		case KEY_F4 :
//			cdplay.NewSong();
//			m_view.AddMessage(T_MESSAGE_CDSONG);
			break;
		case KEY_F5 :
			m_map.m_mode = 0;
			m_view.AddMessage(T_MESSAGE_WIEV_OK);
			break;
		case KEY_F6 :
			m_map.m_mode = 1;
			m_view.AddMessage(T_MESSAGE_WIEV_2);
			break;
		case  KEY_F :
			if ((m_view.m_zamerovac = !m_view.m_zamerovac)==true)
				m_view.AddMessage(T_MESSAGE_ZAM_ON);
			else 
				m_view.AddMessage(T_MESSAGE_ZAM_OFF);
			break;
		case KEY_P : // pauza
			masked_blit(b_pause, hscreen.GetVisible(), 0, 0, 320-b_pause->w/2, 240-b_pause->h/2, b_pause->w, b_pause->h);
			clear_keybuf();
			while (!key[KEY_ENTER]) {
				UpdateInput();
				rest(100);
			}
			break;
		}
	}
}

/*////////////////////////////////////////////////////////////////////////////////
	Zinicializuje demo
*/
void GRun::InitDemo()
{
	int i,j;

	m_multi = false;

	bool used[AI_NAMES]; // aby se jmena neopakovala

	for (i = 0; i < AI_NAMES; i++)
		used[i] = false;

	// Vojak
	for(i = 0; i < MAX_PLAYERS; i++) {
		m_sold[i].Init(i, m_map.m_sx, m_map.m_sx, rand()%MAX_ZBRANE, true, 50, &m_map);
		m_sold[i].m_active = true;
		m_sold[i].m_turnspeed = TURNSENSITIVE;

		m_sold[i].m_AI_l = rand()%COMPAILEVELS;

		if (i > 0) {
			m_sold[i].m_ID = rand()%MAX_SOLDIERS;
			j = rand()%AI_NAMES;
			while (used[j]) j = rand()%AI_NAMES;
			strcpy(m_sold[i].m_name, ai_names[j]);
			used[j] = true;
		}
	}
	m_sold[0].m_AI_l = COMPAILEVELS-1; // demo pocitac bude mit vzdy nejvyssi inteligenci

	m_soldiers = rand()%(10)+10;

	m_map.NewPowerUp();
	m_map.NewPowerUp();
	m_map.NewPowerUp();

	m_view.Init(&m_sold[0]);

}

/*////////////////////////////////////////////////////////////////////////////////
	Nacte pole bitmap (z LoadGFX)
*/
bool GRun::LoadBitmaps(BITMAP **pole, int kolik, int zacatek, char *file)
{
	char s[60];
	int i;

	for( i = 0; i < kolik; i++){
		// objekt
		sprintf(s, file, i+zacatek);
		*pole = hload_bitmap(s);
		if (!*pole) {
			allegro_message("Chybi %s",s);
			return false;
		}
		pole++;
	}
	return true;
}

/*////////////////////////////////////////////////////////////////////////////////
	Rusi pole bitmap (z Destroy)
*/
void GRun::DestroyBitmaps(BITMAP **pole, int kolik)
{
	int i;
	for( i = 0; i < kolik; i++, pole++){
		if (*pole == NULL) continue;
		destroy_bitmap(*pole);
		*pole = NULL;
	}
}

/*////////////////////////////////////////////////////////////////////////////////
	Rusi pole bitmap (z Destroy)
*/
void GRun::SetCurPlCtrl()
{

	switch(ini.ovladani) {

		// ovladani klavensnici
	case CTRL_KEYB :
		m_sold[0].SetKeys(key[KEY_UP]||key[KEY_8_PAD], 
								key[KEY_DOWN]||key[KEY_2_PAD], 
								key[KEY_LEFT]||key[KEY_4_PAD],
								key[KEY_RIGHT]||key[KEY_6_PAD], 
						      key[KEY_A]||key[KEY_J], 
								key[KEY_S]||key[KEY_K], 
								key[KEY_RSHIFT]||key[KEY_LSHIFT]||m_autorun, 
								key[KEY_RCONTROL]||key[KEY_LCONTROL], 
								key[KEY_L]||key[KEY_X],
								key[KEY_ENTER]||key[KEY_SPACE]);

		m_sold[0].m_turnspeed = TURNSENSITIVE;
		break;

		// ovladani mysi
	case CTRL_KEYMOUS :
		int dx = mouse_x - 320;

		m_sold[0].SetKeys(key[KEY_UP]||key[KEY_8_PAD]||key[KEY_W], 
								key[KEY_DOWN]||key[KEY_2_PAD]||key[KEY_S], 
								false,
								false,
								key[KEY_LEFT]||key[KEY_4_PAD]||key[KEY_A]||key[KEY_J],
								key[KEY_RIGHT]||key[KEY_6_PAD]||key[KEY_D]||key[KEY_K], 
								key[KEY_RSHIFT]||key[KEY_LSHIFT]||m_autorun, 
								key[KEY_RCONTROL]||key[KEY_LCONTROL]||(mouse_b & 1), 
								key[KEY_L]||key[KEY_X]||key[KEY_Q]||key[KEY_E],
								key[KEY_ENTER]||key[KEY_SPACE]||(mouse_b & 2));
		if (dx > 0) m_sold[0].m_right = true;
		if (dx < 0) m_sold[0].m_left  = true;
		m_sold[0].m_turnspeed = abs(dx);
		position_mouse(320, 240);
		break;
	}
}

/*////////////////////////////////////////////////////////////////////////////////
	Provede animovani postavicek (vojaku)
*/
void GRun::Animate()
{
	for (int i = 0; i < m_soldiers; i++)
		m_sold[i].Animate();
}

/*////////////////////////////////////////////////////////////////////////////////
	nektery systemy potrebuji updatnout vstupy (DOS,..) win32 ne
*/
void GRun::UpdateInput()
{
	poll_keyboard();
	poll_mouse();
}

/*////////////////////////////////////////////////////////////////////////////////
	zaridi ztmaveni bitmap hry
*/
bool GRun::DarkGFX()
{
	if (m_gfx_loaded == GFX_LOADED_DARK) return true;

	if (m_gfx_loaded == GFX_LOADED_NO) if (!LightGFX()) return false;
 
	DarkBitmaps(&b_solds[0], MAX_SOLD_BITMAPS);    // ztmaveni vojaku
	DarkBitmaps(&b_s_run[0], MAX_RUN_BITMAPS);     // ztmaveni nohou pri behu
	DarkBitmaps(&b_s_walk[0], MAX_WALK_BITMAPS);   // ztmaveni nohou za chuze
	DarkBitmaps(&b_s_water[0], MAX_WATER_BITMAPS); // ztmaveni strikajici vody
	DarkBitmaps(&b_kour[0], MAX_KOUR);             // ztmaveni koure
	DarkBitmaps(&b_krev[0], MAX_KREV_ANIM);        // ztmaveni animace krve
	DarkBitmaps(&b_powerups[0], MAX_POWERUPS);     // ztmaveni powrupu

	int i;
	for(i = 0; i < MAX_ZBRANE; i++)
		DarkBitmaps(&b_zbrane[i][0], Zparams[i].anim); // ztmaveni malych zbranicek

	for(i = 0; i < MAX_SOLD_BITMAPS; i++)
	DarkBitmaps(&b_deads[i][0], MAX_DEADS_BITMAPS);   // ztmaveni mrtvol

	// tohle se netmavi, protoze by to nemleo smysl
//	DarkBitmaps(&b_strel[0], MAX_STREL);           // ztmaveni strel
//	DarkBitmaps(&b_stit[0], MAX_STIT_ANIM);        // ztmaveni blikajiciho stitu
//	DarkBitmaps(&b_zbraneB[0], MAX_ZBRANE);        // ztmaveni velkych zbrani
//	DarkBitmaps(&b_s_bonus[0], MAX_BONUS, 1);      // ztmaveni bonusu u vojaku
	


	m_gfx_loaded = GFX_LOADED_DARK;
	return true;
}

/*////////////////////////////////////////////////////////////////////////////////
	zaridi svelte bitmapy hry
*/
bool GRun::LightGFX()
{
	if (m_gfx_loaded == GFX_LOADED_NORMAL) return true;

	draw_loading();

	DestroyRunBitmaps(); // radsi to nejrve zlikvidujem ( pro jistotu )
	int i;
	char s[60];

	// vojaci
	if (!LoadBitmaps(&b_solds[0], MAX_SOLD_BITMAPS, 1, "gfx/sold/sold%d.bmp")) return false;

	// nacteni nohou  pri behu
	if (!LoadBitmaps(&b_s_run[0], MAX_RUN_BITMAPS, 0, "gfx/anim/sr%.2d.bmp")) return false;

	// normalni nohy
	if (!LoadBitmaps(&b_s_walk[0], MAX_WALK_BITMAPS, 0, "gfx/anim/s%d.bmp")) return false;

	// animace wody
	if (!LoadBitmaps(&b_s_water[0], MAX_WATER_BITMAPS, 1, "gfx/anim/awoda%d.bmp")) return false;

	// strely
	if (!LoadBitmaps(&b_strel[0], MAX_STREL, 1, "gfx/shoots/GSTRELA%d.BMP")) return false;

	// kour za raketou
	if (!LoadBitmaps(&b_kour[0], MAX_KOUR, 1, "gfx/shoots/GKOUR%d.BMP")) return false;
	
	// strikajici krev
	if (!LoadBitmaps(&b_krev[0], MAX_KREV_ANIM, 1, "gfx/anim/akrev%d.bmp")) return false;

	// blikajici stit
	if (!LoadBitmaps(&b_stit[0], MAX_STIT_ANIM, 1, "gfx/anim/astit%d.bmp")) return false;

	// power-upy
	if (!LoadBitmaps(&b_powerups[0], MAX_POWERUPS, 1, "gfx/pup/PUP%d.BMP")) return false;

	// velke zbrane
	if (!LoadBitmaps(&b_zbraneB[0], MAX_ZBRANE, 1, "gfx/gun/GZBRANB%d.BMP")) return false;

	// bonusy u vojaku
	if (!LoadBitmaps(&b_s_bonus[0], MAX_BONUS, 1, "gfx/pup/BON_%d.BMP")) return false;
	
	// zablesky u hlavne
	if (!LoadBitmaps(&b_zbrane_fire[0], MAX_ZBRANE_FIRE, 0, "gfx/gun/FIRE%d.BMP")) return false;

	// plameny
	if (!LoadBitmaps(&b_plamen[0], MAX_PLAMENU, 0, "gfx/shoots/FIRE%d.BMP")) return false;


	// animace malych zbrani
	for( i = 0; i < MAX_ZBRANE; i++){
		sprintf(s,"gfx/gun/GZBRAN%d%%d.BMP",i+1);
		if (!LoadBitmaps(&b_zbrane[i][0], Zparams[i].anim, 0, s)) return false;
	}

	// mrtvoly
	if (!LoadBitmaps(&b_deads[0][0], MAX_DEADS_BITMAPS, 1, "gfx/deads/DEAD1%d.BMP")) return false;
	if (!LoadBitmaps(&b_deads[1][0], MAX_DEADS_BITMAPS, 1, "gfx/deads/DEAD2%d.BMP")) return false;
	if (!LoadBitmaps(&b_deads[2][0], MAX_DEADS_BITMAPS, 1, "gfx/deads/DEAD3%d.BMP")) return false;

	m_gfx_loaded = GFX_LOADED_NORMAL;
	return true;
}

/*////////////////////////////////////////////////////////////////////////////////
	zaridi aktyalni svetlost bitmap hry
*/
bool GRun::UpdateGFX(int type)
{
	if (type == GFX_LOADED_DARK) return DarkGFX();
	else return LightGFX();
}

/*////////////////////////////////////////////////////////////////////////////////
	ztmavi pole bitmap
*/
void GRun::DarkBitmaps(BITMAP **pole, int kolik)
{
	draw_loading();
	for( int i = 0; i < kolik; i++) {
		 hfade_sprite(*pole);
		 pole++;
	}
}

/*////////////////////////////////////////////////////////////////////////////////
	hleda mapy
*/
int GRun::SearchForMaps(char * path)
{
	FILE *file;
	char s[50];
	int i = 1;
	int maps = 0;
	for (;;) {
		sprintf(s, "%smaps/map%d.jpg",path, i);
		if ((file = fopen(s, "rb")) == NULL)
			break;
		fclose(file);

		sprintf(s, "%smaps/map%db.pcx",path, i);
		if ((file = fopen(s, "rb")) == NULL)
			break;
		fclose(file);
		maps++;
		i++;
	}
	return maps;
}

/*////////////////////////////////////////////////////////////////////////////////
	Zrusi jen ty bitmapy, ktere nacital objekt run
*/
void GRun::DestroyRunBitmaps()
{
	int i;

	// Ruseni vojaku
	DestroyBitmaps(&b_solds[0], MAX_SOLD_BITMAPS);

	// Ruseni bonusu
	DestroyBitmaps(&b_s_bonus[0], MAX_BONUS);

	//  Ruseni mrtvol
	DestroyBitmaps(&b_deads[0][0], MAX_DEADS_BITMAPS);
	DestroyBitmaps(&b_deads[1][0], MAX_DEADS_BITMAPS);
	DestroyBitmaps(&b_deads[2][0], MAX_DEADS_BITMAPS);

	// Ruseni nohou
	DestroyBitmaps(&b_s_run[0], MAX_RUN_BITMAPS);
	DestroyBitmaps(&b_s_walk[0], MAX_WALK_BITMAPS);

	// Ruseni wody
	DestroyBitmaps(&b_s_water[0], MAX_WATER_BITMAPS);

	// Ruseni strel
	DestroyBitmaps(&b_strel[0], MAX_STREL);
	DestroyBitmaps(&b_kour[0], MAX_KOUR);

	// ruseni zbrani
	DestroyBitmaps(&b_zbraneB[0], MAX_ZBRANE);

	// zablesky u hlavne
	DestroyBitmaps(&b_zbrane_fire[0], MAX_ZBRANE_FIRE);

	// ruseni plamenu
	DestroyBitmaps(&b_plamen[0], MAX_PLAMENU);

	for( i = 0; i < MAX_ZBRANE; i++)
		DestroyBitmaps(&b_zbrane[i][0], MAX_ZBRAN_ANIM);

	// ruseni powerupu
	DestroyBitmaps(&b_powerups[0], MAX_POWERUPS);

	// ruseni animaci
	DestroyBitmaps(&b_krev[0], MAX_KREV_ANIM);
	DestroyBitmaps(&b_stit[0], MAX_STIT_ANIM);

}

/*////////////////////////////////////////////////////////////////////////////////
	Nacte pole svetelnych masek
*/
bool GRun::LoadMasksBitmaps(BITMAP **pole, int kolik, int zacatek, char *file)
{
	char s[60];
	int i;

	for( i = 0; i < kolik; i++){
		// objekt
		sprintf(s, file, i+zacatek);
		*pole = hload_shadow_bitmap(s);
		if (!*pole) {
			allegro_message("Chybi %s",s);
			return false;
		}
		pole++;
	}
	return true;
}

/*////////////////////////////////////////////////////////////////////////////////
	Demo hra
*/
void GRun::Demo()
{
	bool kill_me_old = m_kill_mee;
	m_kill_mee = false;
	UpdateGFX(m_svetlo);
	m_map.LoadMap(m_mapa, m_svetlo);

	InitDemo();

	tmr  = 5; // 50 ms; -> 20 refreshu za sekundu
	m_monsol = 0;

	clear_keybuf();
	m_map.StartGame();

	do {

		// zobrazeni
		Draw();

		// animace
		Animate();

		// nastaveni pocitace
		CompMove();
		m_sold[0].CompMove(this, 0);

		UpdateInput(); // akyualizace vstupu

		// a jedem
		Move();

		Crash();

		while (tmr > 0);
		tmr = 5; // 50 ms; -> 20 refreshu za sekundu

   } while (!keypressed());
	m_kill_mee = kill_me_old;
	m_map.StopGame();
	hscreen.FadeDown();
}

/*////////////////////////////////////////////////////////////////////////////////
	Efekt pri zahajeni hry
*/
void GRun::StartEffect()
{
	if (!m_effects) return;


	BITMAP *tmp = create_bitmap(1280, 960);
	if (!tmp) return;

	int dx;
	if(ini.resolution) dx = 320;
	else dx = 640;


	int i,j;
	for (i = 1280, j = 960; i > dx; i -= 20, j -= 15) {
		tmr = 5;
		DF_X = i;
		DF_Y = j;

		m_view.UpdateCamera(this);

		if (m_svetlo == GFX_LOADED_NORMAL)
			m_view.Draw(tmp, this, false, m_effects); // den
		else
			m_view.Draw(tmp, this, m_effects, false); // noc

		hscreen.AcquireBack();
		stretch_blit(tmp, hscreen.m_back, 0, 0, i, j, 0, 0, 640, 480);
		hscreen.ReleaseBack();
		hscreen.Flip();
		while(tmr);
	}

	destroy_bitmap(tmp);
}
