
#include <time.h> // pro random
#include "stdh.h"
#include <iostream.h>

#include "soldiers.h"

// Gincludes
#include "GClasses.h"
#include "GRun.h"
#include "GView.h"
#include "GMap.h"

// #include "MultiPlay.h"

#include "GMenu.h"

#include "inifile.h"

#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <time.h>
#include <strings.h>
#include <errno.h>
#include <sys/file.h>

// globalni unikatni identifikator vytvorny pomoci GuidGen
// {6B3F19A0-417A-11d4-8F75-BB50F7F77D1D}
/* Win
GUID guid = 
{ 0x6b3f19a0, 0x417a, 0x11d4, { 0x8f, 0x75, 0xbb, 0x50, 0xf7, 0xf7, 0x7d, 0x1d } };
*/

st_inifile ini;
bool load_inifile(GRun *run);
void save_inifile(GRun *run);

BITMAP *b_loading;


void timer_procedure()
{
	if (tmr > 0) tmr--;
}

END_OF_FUNCTION(timer_procedure);



int main(int argc, char *argv[])
{
   allegro_init();
   install_keyboard();
	install_timer();
	install_mouse();


	GRun run;
	
	// prohledani map
	run.m_maps = run.SearchForMaps("");
	    int m2 = run.SearchForMaps("/usr/local/share/kulic/");
	    int m3 = run.SearchForMaps("/usr/share/kulic/");
	if (m2 > run.m_maps) run.m_maps = m2; 
	if (m3 > run.m_maps) run.m_maps = m3; 
		
	if (run.m_maps == 0) {
		allegro_message("Nenalezeny zadne mapy !");
		return 0;
	}	

	load_inifile(&run);

	if (ini.zvuky)
		reserve_voices(8, 0);

	if (ini.hudba || ini.zvuky)
		if (install_sound(DIGI_AUTODETECT, MIDI_NONE, argv[0]) != 0) {
	      allegro_message("Error initialising sound system\n%s\n", allegro_error);
			return 1;
		}


#ifdef _DEBUG
	set_window_title("Kulic - 0.70 - DEBUG");
#else 
	set_window_title("Kulic - Linux - port of 0.70");
#endif

	// pripraveni timeru
	LOCK_VARIABLE(tmr);
	LOCK_FUNCTION(timer_procedure);
	install_int(timer_procedure, 10 + ini.rychlost);

/* 
	net = new NDX_Connect;
	if (net == NULL) {
		allegro_message("new failed"); // SMULA !!!!
		return 2;
	}

	if (!net->Create(&guid)) {
		allegro_message("Cannot create Conn"); // SMULA !!!!
		return 2;
	}
*/
	srand(time(NULL));
	DF_X = 640;
	DF_Y = 480;

	hscreen.Install();

/*
	if (!hscreen.Init(640, 480, GFX_BPP[ini.bpp], ini.flipmode+1, GFX_AUTODETECT, true)) { // DLE INI SOUBORU 
			allegro_message("Nepodarilo se nastavit rozliseni %d*%d*%d !!!\n Spustte setup.exe a vyberte jinou barevnou hloubku", DF_X, DF_Y, GFX_BPP[ini.bpp]); // SMULA !!!!
			return 1;
		}
	GFX_AUTODETECT_WINDOWED	
	GFX_XWINDOWS	
*/		
	if (!hscreen.Init(640, 480, ini.bpp, ini.flipmode+1, GFX_AUTODETECT, true)) { // DLE INI SOUBORU 
			allegro_message("Nepodarilo se nastavit rozliseni %d*%d*%d !!!\n Spustte setup a vyberte jinou barevnou hloubku\n", DF_X, DF_Y, ini.bpp); // SMULA !!!!
			return 1;
		}

		
	text_mode(-1);

	if ((b_loading = hload_bitmap("gfx/other/loading.bmp")) == NULL) {
		allegro_message("Chybi soubor : gfx/other/loading.bmp");
		exit(1);
	}


	hscreen.m_mouse = false;

	// grafika - nacteni
	if(!run.LoadGFX()) {
		allegro_message("Failed in loading GFX !\n  File %s is missing\n", errch); // SMULA !!!!
		return false;
	}


	GMenu menu;
	menu.LoadGFX(&run);


// HLAVNI HERNI SMYCKA
	menu.Run(&run);
// KONEC HLAVNI SMYCKY 


	save_inifile(&run);


	menu.Destroy(&run);

	
	run.Destroy();



	if (b_loading) destroy_bitmap(b_loading);
	b_loading = NULL;


	hscreen.Destroy();


	clear_keybuf();

	allegro_exit();

   return 0;
}

END_OF_MAIN();

//////////
//  nakresli znak nacitani vpravo dole
void draw_loading()
{
	masked_blit(b_loading, hscreen.GetVisible(), 0,0, 640-b_loading->w, 480-b_loading->h, b_loading->w, b_loading->h);
}

bool load_inifile(GRun *run) 
{
	FILE *infile;

	char filepath[255];
	sprintf(filepath, "%s%s", "PROGDIR:", INIFILE);
	
	if ((infile = fopen( filepath, "rt" )) == NULL ) {
		// defaultni ini
		ini.bpp = 32; ini.flipmode = 1; ini.resolution = 0; ini.antialaising = 1;
		ini.effects = 1; ini.seffects = 1; ini.meffects = 1; ini.feffect = 0;
		ini.zvuky = 1; ini.zvuky_vol = 255; ini.hudba = 1; ini.hudba_vol = 255;
		ini.ovladani = 1; ini.rychlost = 0; ini.turnsen = 10.0;
		ini.nesmrt = 1; ini.mrtvol = 100; ini.fps = 0;
		ini.postava = 0; ini.mapa = 1; ini.pocitacu = 10; ini.autorun = 1; ini.zamerovac = 1; ini.svetlo = 1; ini.minAI = 0; ini.maxAI = 0;
		strcpy(ini.jmeno, "NAME");
	}
	else {
		// grafika
		fscanf(infile, " %d (bpp 8,15,16,24,34)\n %d (flipmode 0 , 1)\n %d (resolution 0 - 640*480, 1 - 320*240)\n %d (antialias 0, 1)\n",
				 &ini.bpp, &ini.flipmode, &ini.resolution, &ini.antialaising);

		fscanf(infile, " %d (effects 0,1)\n %d (screen effects 0,1)\n %d (menu effects 1,0)\n %d (menu fading effects 1,0)\n", 
				&ini.effects, &ini.seffects, &ini.meffects, &ini.feffect );
	
		fscanf(infile, " %d (sound 0,1)\n %d (soundvolume 0..255)\n %d (music 0,1)\n %d (musicvolume 0..255)\n",
				&ini.zvuky, &ini.zvuky_vol, &ini.hudba, &ini.hudba_vol);

		fscanf(infile, " %d (controls 0-keyboard, 1-keboarb & mouse)\n %d (dame speed 0-normal...10-slow)\n %f (mouse sen: good: 10.0)\n",
				&ini.ovladani, &ini.rychlost, &ini.turnsen);

		fscanf(infile, " %d (immortal for 1 sec 0,1)\n %d (cleaning after X deads good : 100, no celaning - 0)\n %d (show fps 1,0)\n",
				&ini.nesmrt, &ini.mrtvol, &ini.fps);
	
		fscanf(infile, " game setting\n %d %s %d %d %d %d %d %d %d\n",
				&ini.postava, &ini.jmeno[0], &ini.mapa, &ini.pocitacu, &ini.autorun, &ini.zamerovac, &ini.svetlo, &ini.minAI, &ini.maxAI);

		fclose(infile);
	}


	// zpracovani ini souboru
	// zda budeme pouzivat CD
//	if (!ini.cd) cdplay.m_use = false; 

	// zamerovac, autorun
	if (ini.zamerovac) run->m_view.m_zamerovac = true;
	if (ini.autorun)   run->m_autorun = true;
	if (run->m_maps > ini.mapa) run->m_mapa = ini.mapa;
	else run->m_mapa = 0;
	strcpy(run->m_sold[0].m_name, ini.jmeno);
	run->m_sold[0].m_ID = ini.postava;
	run->m_svetlo = ini.svetlo;

	if (ini.bpp != 8) run->m_effects = ini.effects;
	else run->m_effects = false;
	run->m_lighteffects = ini.effects;

	run->m_kill_mee = ini.killme;

	if (ini.ovladani == CTRL_KEYMOUS)
		turnsensitive = ini.turnsen;
	else 
		turnsensitive = TURNSENSITIVE;

	if (turnsensitive == 0) 
		turnsensitive = TURNSENSITIVE;

	hscreen.m_fad_allowed = ini.seffects;
	hscreen.m_aa_enabled  = ini.antialaising;
	hscreen.m_fps_draw = ini.fps;


	return true;
}


void save_inifile(GRun *run) 
{
	// ulozeni nastaveni
	FILE *infile;
	strcpy(ini.jmeno, run->m_sold[0].m_name);
	ini.postava  = run->m_sold[0].m_ID;
	ini.mapa     = run->m_mapa;
	ini.svetlo   = run->m_svetlo;
	ini.killme   = run->m_kill_mee;
	
	char filepath[255];
	sprintf(filepath, "%s%s", "PROGDIR:", INIFILE);

	if ((infile = fopen( filepath, "wt" )) == NULL ) {
		allegro_message("Unable to open ini file for write!!");
		return;    // nepodarilo se otevrit soubor
	}

//	infile = fopen( filepath, "wt" )
	
//		fprintf(infile, "HAOJ\n");
//	fwrite(&ini, sizeof(ini), 1, infile); // ulozi inifile

		fprintf(infile, " %d (bpp 8,15,16,24,34)\n %d (flipmode 0 , 1)\n %d (resolution 0 - 640*480, 1 - 320*240)\n %d (antialias 0, 1)\n",
				 ini.bpp, ini.flipmode, ini.resolution, ini.antialaising);

		fprintf(infile, " %d (effects 0,1)\n %d (screen effects 0,1)\n %d (menu effects 1,0)\n %d (menu fading effects 1,0)\n", 
				ini.effects, ini.seffects, ini.meffects, ini.feffect );
	
		fprintf(infile, " %d (sound 0,1)\n %d (soundvolume 0..255)\n %d (music 0,1)\n %d (musicvolume 0..255)\n",
				ini.zvuky, ini.zvuky_vol, ini.hudba, ini.hudba_vol);

		fprintf(infile, " %d (controls 0-keyboard, 1-keboarb & mouse)\n %d (dame speed 0-normal...10-slow)\n %f (mouse sen: good: 10.0)\n",
				ini.ovladani, ini.rychlost, ini.turnsen);

		fprintf(infile, " %d (immortal for 1 sec 0,1)\n %d (cleaning after X deads good : 100, no celaning - 0)\n %d (show fps 1,0)\n",
				ini.nesmrt, ini.mrtvol, ini.fps);
	
		fprintf(infile, " game setting\n %d %s %d %d %d %d %d %d %d\n",
				ini.postava, ini.jmeno, ini.mapa, ini.pocitacu, ini.autorun, ini.zamerovac, ini.svetlo, ini.minAI, ini.maxAI);
	
	
	fclose(infile);
}
