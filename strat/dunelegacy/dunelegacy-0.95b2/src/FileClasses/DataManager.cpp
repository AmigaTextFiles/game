/*
 *  This file is part of Dune Legacy.
 *
 *  Dune Legacy is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  Dune Legacy is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Dune Legacy.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <FileClasses/DataManager.h>

#include <globals.h>

#include <FileClasses/FileManager.h>
#include <FileClasses/Shpfile.h>
#include <FileClasses/Cpsfile.h>
#include <FileClasses/Icnfile.h>
#include <FileClasses/Wsafile.h>
#include <FileClasses/Vocfile.h>

#include <misc/draw_util.h>

extern SDL_Palette* palette;

DataManager::DataManager() {
	WindTrapColorTimer = -139;

	// init whole ObjPic array
	for(int i = 0; i < NUM_OBJPICS; i++) {
		for(int j = 0; j < (int) NUM_HOUSES; j++) {
			ObjPic[i][j] = NULL;
		}
	}

	// init whole SmallDetailPics array
	for(int i = 0; i < NUM_SMALLDETAILPICS; i++) {
		SmallDetailPic[i] = NULL;
	}

	// init whole UIGraphic array
	for(int i = 0; i < NUM_UIGRAPHICS; i++) {
		for(int j = 0; j < (int) NUM_HOUSES; j++) {
			UIGraphic[i][j] = NULL;
		}
	}

	// init whole MapChoicePieces array
	for(int i = 0; i < NUM_MAPCHOICEPIECES; i++) {
		for(int j = 0; j < (int) NUM_HOUSES; j++) {
			MapChoicePieces[i][j] = NULL;
		}
	}

	// init whole MapChoiceArrows array
	for(int i = 0; i < NUM_MAPCHOICEARROWS; i++) {
		MapChoiceArrows[i] = NULL;
	}

	// init whole Anim array
	for(int i = 0; i < NUM_ANIMATION; i++) {
		Anim[i] = NULL;
	}

	Shpfile *units;
	Shpfile *units1;
	Shpfile *units2;
	Shpfile *mouse;
	Shpfile *shapes;
	Icnfile *icon;
	Wsafile *radar;
	Shpfile *menshpa;
	Shpfile *menshph;
	Shpfile *menshpo;
	Shpfile *choam;
	Shpfile *bttn;
	Cpsfile *bigplan;
	Cpsfile* herald;
	Cpsfile* mentata;
	Cpsfile* mentato;
	Cpsfile* mentath;
	Shpfile* mentat;
	Cpsfile* dunemap;
	Cpsfile* dunergn;
	Cpsfile* rgnclk;
	Shpfile* pieces;
	Shpfile* arrows;
	SDL_RWops *units_shp;
	SDL_RWops *units1_shp;
	SDL_RWops *units2_shp;
	SDL_RWops *mouse_shp;
	SDL_RWops *shapes_shp;
	SDL_RWops *icon_icn;
	SDL_RWops *icon_map;
	SDL_RWops *static_wsa;
	SDL_RWops *menshpa_shp;
	SDL_RWops *menshph_shp;
	SDL_RWops *menshpo_shp;
	SDL_RWops *choam_lng;
	SDL_RWops *bttn_lng;
	SDL_RWops *bigplan_cps;
	SDL_RWops *herald_lng;
	SDL_RWops *mentata_cps;
	SDL_RWops *mentato_cps;
	SDL_RWops *mentath_cps;
	SDL_RWops *mentat_lng;
	SDL_RWops *dunemap_cps;
	SDL_RWops *dunergn_cps;
	SDL_RWops *rgnclk_cps;
	SDL_RWops *pieces_shp;
	SDL_RWops *arrows_shp;


	// open all files
	units_shp = pFileManager->OpenFile("UNITS.SHP");
	if((units = new Shpfile(units_shp)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open UNITS.SHP!\n");
		exit(EXIT_FAILURE);
	}

	units1_shp = pFileManager->OpenFile("UNITS1.SHP");
	if((units1 = new Shpfile(units1_shp)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open UNITS1.SHP!\n");
		exit(EXIT_FAILURE);
	}

	units2_shp = pFileManager->OpenFile("UNITS2.SHP");
	if((units2 = new Shpfile(units2_shp)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open UNITS2.SHP!\n");
		exit(EXIT_FAILURE);
	}

	mouse_shp = pFileManager->OpenFile("MOUSE.SHP");
	if((mouse = new Shpfile(mouse_shp)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open MOUSE.SHP!\n");
		exit(EXIT_FAILURE);
	}

	shapes_shp = pFileManager->OpenFile("SHAPES.SHP");
	if((shapes = new Shpfile(shapes_shp)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open SHAPES.SHP!\n");
		exit(EXIT_FAILURE);
	}

	icon_icn = pFileManager->OpenFile("ICON.ICN");
	icon_map = pFileManager->OpenFile("ICON.MAP");
	if((icon = new Icnfile(icon_icn,icon_map)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open ICON.ICN or ICON.MAP!\n");
		exit(EXIT_FAILURE);
	}

	static_wsa = pFileManager->OpenFile("STATIC.WSA");
	if((radar = new Wsafile(static_wsa)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open STATIC.WSA!\n");
		exit(EXIT_FAILURE);
	}

	menshpa_shp = pFileManager->OpenFile("MENSHPA.SHP");
	if((menshpa = new Shpfile(menshpa_shp)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open MENSHPA.SHP!\n");
		exit(EXIT_FAILURE);
	}

	menshph_shp = pFileManager->OpenFile("MENSHPH.SHP");
	if((menshph = new Shpfile(menshph_shp)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open MENSHPH.SHP!\n");
		exit(EXIT_FAILURE);
	}

	menshpo_shp = pFileManager->OpenFile("MENSHPO.SHP");
	if((menshpo = new Shpfile(menshpo_shp)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open MENSHPO.SHP!\n");
		exit(EXIT_FAILURE);
	}

	choam_lng = pFileManager->OpenFile("CHOAM." + settings.General.LanguageExt);
	if((choam = new Shpfile(choam_lng)) == NULL) {
		fprintf(stdout,("DataManager::DataManager(): Cannot open CHOAM."+settings.General.LanguageExt+"!\n").c_str());
		exit(EXIT_FAILURE);
	}

	bttn_lng = pFileManager->OpenFile("BTTN." + settings.General.LanguageExt);
	if((bttn = new Shpfile(bttn_lng)) == NULL) {
		fprintf(stdout,("DataManager::DataManager(): Cannot open BTTN."+settings.General.LanguageExt+"!\n").c_str());
		exit(EXIT_FAILURE);
	}

	bigplan_cps = pFileManager->OpenFile("BIGPLAN.CPS");
	if((bigplan = new Cpsfile(bigplan_cps)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open BIGPLAN.CPS!\n");
		exit(EXIT_FAILURE);
	}

	herald_lng = pFileManager->OpenFile("HERALD." + settings.General.LanguageExt);
	if((herald = new Cpsfile(herald_lng)) == NULL) {
		fprintf(stdout,("DataManager::DataManager(): Cannot open HERALD." + settings.General.LanguageExt + "!\n").c_str());
		exit(EXIT_FAILURE);
	}

	mentata_cps = pFileManager->OpenFile("MENTATA.CPS");
	if((mentata = new Cpsfile(mentata_cps)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open MENTATA.CPS!\n");
		exit(EXIT_FAILURE);
	}

	mentato_cps = pFileManager->OpenFile("MENTATO.CPS");
	if((mentato = new Cpsfile(mentato_cps)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open MENTATO.CPS!\n");
		exit(EXIT_FAILURE);
	}

	mentath_cps = pFileManager->OpenFile("MENTATH.CPS");
	if((mentath = new Cpsfile(mentath_cps)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open MENTATH.CPS!\n");
		exit(EXIT_FAILURE);
	}

	mentat_lng = pFileManager->OpenFile("MENTAT." + settings.General.LanguageExt);
	if((mentat = new Shpfile(mentat_lng)) == NULL) {
		fprintf(stdout,("DataManager::DataManager(): Cannot open MENTAT." + settings.General.LanguageExt + "!\n").c_str());
		exit(EXIT_FAILURE);
	}

	dunemap_cps = pFileManager->OpenFile("DUNEMAP.CPS");
	if((dunemap = new Cpsfile(dunemap_cps)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open DUNEMAP.CPS!\n");
		exit(EXIT_FAILURE);
	}

	dunergn_cps = pFileManager->OpenFile("DUNERGN.CPS");
	if((dunergn = new Cpsfile(dunergn_cps)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open DUNERGN.CPS!\n");
		exit(EXIT_FAILURE);
	}

	rgnclk_cps = pFileManager->OpenFile("RGNCLK.CPS");
	if((rgnclk = new Cpsfile(rgnclk_cps)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open RGNCLK.CPS!\n");
		exit(EXIT_FAILURE);
	}

	pieces_shp = pFileManager->OpenFile("PIECES.SHP");
	if((pieces = new Shpfile(pieces_shp)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open PIECES.SHP!\n");
		exit(EXIT_FAILURE);
	}

	arrows_shp = pFileManager->OpenFile("ARROWS.SHP");
	if((arrows = new Shpfile(arrows_shp)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot open ARROWS.SHP!\n");
		exit(EXIT_FAILURE);
	}

	//create PictureFactory
	PictureFactory *PicFactory;
    if((PicFactory = new PictureFactory()) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot create PictureFactory!\n");
		exit(EXIT_FAILURE);
	}

	// load Object pics
	ObjPic[ObjPic_Tank_Base][HOUSE_HARKONNEN] = units2->getPictureArray(8,1,GROUNDUNIT_ROW(0));
	ObjPic[ObjPic_Tank_Gun][HOUSE_HARKONNEN] = units2->getPictureArray(8,1,GROUNDUNIT_ROW(5));
	ObjPic[ObjPic_Siegetank_Base][HOUSE_HARKONNEN] = units2->getPictureArray(8,1,GROUNDUNIT_ROW(10));
	ObjPic[ObjPic_Siegetank_Gun][HOUSE_HARKONNEN] = units2->getPictureArray(8,1,GROUNDUNIT_ROW(15));
	ObjPic[ObjPic_Devastator_Base][HOUSE_HARKONNEN] = units2->getPictureArray(8,1,GROUNDUNIT_ROW(20));
	ObjPic[ObjPic_Devastator_Gun][HOUSE_HARKONNEN] = units2->getPictureArray(8,1,GROUNDUNIT_ROW(25));
	ObjPic[ObjPic_Sonictank_Gun][HOUSE_HARKONNEN] = units2->getPictureArray(8,1,GROUNDUNIT_ROW(30));
	ObjPic[ObjPic_Launcher_Gun][HOUSE_HARKONNEN] = units2->getPictureArray(8,1,GROUNDUNIT_ROW(35));
	ObjPic[ObjPic_Quad][HOUSE_HARKONNEN] = units->getPictureArray(8,1,GROUNDUNIT_ROW(0));
	ObjPic[ObjPic_Trike][HOUSE_HARKONNEN] = units->getPictureArray(8,1,GROUNDUNIT_ROW(5));
	ObjPic[ObjPic_Harvester][HOUSE_HARKONNEN] = units->getPictureArray(8,1,GROUNDUNIT_ROW(10));
	ObjPic[ObjPic_Harvester_Sand][HOUSE_HARKONNEN] = units1->getPictureArray(8,3,HARVESTERSAND_ROW(72),HARVESTERSAND_ROW(73),HARVESTERSAND_ROW(74));
	ObjPic[ObjPic_MCV][HOUSE_HARKONNEN] = units->getPictureArray(8,1,GROUNDUNIT_ROW(15));
	ObjPic[ObjPic_Carryall][HOUSE_HARKONNEN] = units->getPictureArray(8,2,AIRUNIT_ROW(45),AIRUNIT_ROW(48));
	ObjPic[ObjPic_Frigate][HOUSE_HARKONNEN] = units->getPictureArray(8,1,AIRUNIT_ROW(60));
	ObjPic[ObjPic_Ornithopter][HOUSE_HARKONNEN] = units->getPictureArray(8,3,ORNITHOPTER_ROW(51),ORNITHOPTER_ROW(52),ORNITHOPTER_ROW(53));
	ObjPic[ObjPic_Trooper][HOUSE_HARKONNEN] = units->getPictureArray(4,3,INFANTRY_ROW(82),INFANTRY_ROW(83),INFANTRY_ROW(84));
	ObjPic[ObjPic_Infantry][HOUSE_HARKONNEN] = units->getPictureArray(4,3,INFANTRY_ROW(73),INFANTRY_ROW(74),INFANTRY_ROW(75));
	ObjPic[ObjPic_Saboteur][HOUSE_HARKONNEN] = units->getPictureArray(4,3,INFANTRY_ROW(63),INFANTRY_ROW(64),INFANTRY_ROW(65));
	ObjPic[ObjPic_Sandworm][HOUSE_HARKONNEN] = units1->getPictureArray(1,5,67|TILE_NORMAL,68|TILE_NORMAL,69|TILE_NORMAL,70|TILE_NORMAL,71|TILE_NORMAL);
	ObjPic[ObjPic_ConstructionYard][HOUSE_HARKONNEN] = icon->getPictureArray(17);
	ObjPic[ObjPic_Windtrap][HOUSE_HARKONNEN] = icon->getPictureArray(19);
	ObjPic[ObjPic_Refinery][HOUSE_HARKONNEN] = icon->getPictureArray(21);
	ObjPic[ObjPic_Barracks][HOUSE_HARKONNEN] = icon->getPictureArray(18);
	ObjPic[ObjPic_WOR][HOUSE_HARKONNEN] = icon->getPictureArray(16);
	ObjPic[ObjPic_Radar][HOUSE_HARKONNEN] = icon->getPictureArray(26);
	ObjPic[ObjPic_LightFactory][HOUSE_HARKONNEN] = icon->getPictureArray(12);
	ObjPic[ObjPic_Silo][HOUSE_HARKONNEN] = icon->getPictureArray(25);
	ObjPic[ObjPic_HeavyFactory][HOUSE_HARKONNEN] = icon->getPictureArray(13);
	ObjPic[ObjPic_HighTechFactory][HOUSE_HARKONNEN] = icon->getPictureArray(14);
	ObjPic[ObjPic_IX][HOUSE_HARKONNEN] = icon->getPictureArray(15);
	ObjPic[ObjPic_Palace][HOUSE_HARKONNEN] = icon->getPictureArray(11);
	ObjPic[ObjPic_RepairYard][HOUSE_HARKONNEN] = icon->getPictureArray(22);
	ObjPic[ObjPic_Starport][HOUSE_HARKONNEN] = icon->getPictureArray(20);
	ObjPic[ObjPic_GunTurret][HOUSE_HARKONNEN] = icon->getPictureArray(23);
	ObjPic[ObjPic_RocketTurret][HOUSE_HARKONNEN] = icon->getPictureArray(24);
	ObjPic[ObjPic_Wall][HOUSE_HARKONNEN] = icon->getPictureArray(6,1,1,75);
	ObjPic[ObjPic_Bullet_SmallRocket][HOUSE_HARKONNEN] = units->getPictureArray(16,1,ROCKET_ROW(35));
	ObjPic[ObjPic_Bullet_MediumRocket][HOUSE_HARKONNEN] = units->getPictureArray(16,1,ROCKET_ROW(20));
	ObjPic[ObjPic_Bullet_LargeRocket][HOUSE_HARKONNEN] = units->getPictureArray(16,1,ROCKET_ROW(40));
	ObjPic[ObjPic_Bullet_Small][HOUSE_HARKONNEN] = units1->getPicture(23);
	ObjPic[ObjPic_Bullet_Medium][HOUSE_HARKONNEN] = units1->getPicture(24);
	ObjPic[ObjPic_Bullet_Sonic][HOUSE_HARKONNEN] = units1->getPicture(9);
	ObjPic[ObjPic_Hit_Gas][HOUSE_HARKONNEN] = units1->getPictureArray(5,1,57|TILE_NORMAL,58|TILE_NORMAL,59|TILE_NORMAL,60|TILE_NORMAL,61|TILE_NORMAL);
	ObjPic[ObjPic_Hit_Shell][HOUSE_HARKONNEN] = units1->getPictureArray(3,1,2|TILE_NORMAL,3|TILE_NORMAL,4|TILE_NORMAL);
	ObjPic[ObjPic_ExplosionSmall][HOUSE_HARKONNEN] = units1->getPictureArray(5,1,32|TILE_NORMAL,33|TILE_NORMAL,34|TILE_NORMAL,35|TILE_NORMAL,36|TILE_NORMAL);
	ObjPic[ObjPic_ExplosionMedium1][HOUSE_HARKONNEN] = units1->getPictureArray(5,1,47|TILE_NORMAL,48|TILE_NORMAL,49|TILE_NORMAL,50|TILE_NORMAL,51|TILE_NORMAL);
	ObjPic[ObjPic_ExplosionMedium2][HOUSE_HARKONNEN] = units1->getPictureArray(5,1,52|TILE_NORMAL,53|TILE_NORMAL,54|TILE_NORMAL,55|TILE_NORMAL,56|TILE_NORMAL);
	ObjPic[ObjPic_ExplosionLarge1][HOUSE_HARKONNEN] = units1->getPictureArray(5,1,37|TILE_NORMAL,38|TILE_NORMAL,39|TILE_NORMAL,40|TILE_NORMAL,41|TILE_NORMAL);
	ObjPic[ObjPic_ExplosionLarge2][HOUSE_HARKONNEN] = units1->getPictureArray(5,1,42|TILE_NORMAL,43|TILE_NORMAL,44|TILE_NORMAL,45|TILE_NORMAL,46|TILE_NORMAL);
	ObjPic[ObjPic_ExplosionSmallUnit][HOUSE_HARKONNEN] = units1->getPictureArray(2,1,0|TILE_NORMAL,1|TILE_NORMAL);
	ObjPic[ObjPic_ExplosionFlames][HOUSE_HARKONNEN] = units1->getPictureArray(21,1,11|TILE_NORMAL,12|TILE_NORMAL,13|TILE_NORMAL,17|TILE_NORMAL,18|TILE_NORMAL,19|TILE_NORMAL,17|TILE_NORMAL,18|TILE_NORMAL,19|TILE_NORMAL,17|TILE_NORMAL,18|TILE_NORMAL,19|TILE_NORMAL,17|TILE_NORMAL,18|TILE_NORMAL,19|TILE_NORMAL,17|TILE_NORMAL,18|TILE_NORMAL,19|TILE_NORMAL,20|TILE_NORMAL,21|TILE_NORMAL,22|TILE_NORMAL);
	ObjPic[ObjPic_DeadInfantry][HOUSE_HARKONNEN] = icon->getPictureArray(4,1,1,6);
	ObjPic[ObjPic_DeadAirUnit][HOUSE_HARKONNEN] = icon->getPictureArray(3,1,1,6);
	ObjPic[ObjPic_Smoke][HOUSE_HARKONNEN] = units1->getPictureArray(3,1,29|TILE_NORMAL,30|TILE_NORMAL,31|TILE_NORMAL);
	ObjPic[ObjPic_SandwormShimmerMask][HOUSE_HARKONNEN] = units1->getPicture(10);
	ObjPic[ObjPic_Terrain][HOUSE_HARKONNEN] = icon->getPictureRow(124,209);
	ObjPic[ObjPic_RockDamage][HOUSE_HARKONNEN] = icon->getPictureRow(1,6);
	ObjPic[ObjPic_SandDamage][HOUSE_HARKONNEN] = units1->getPictureArray(3,1,5|TILE_NORMAL,6|TILE_NORMAL,7|TILE_NORMAL);
	ObjPic[ObjPic_Terrain_Hidden][HOUSE_HARKONNEN] = icon->getPictureRow(108,123);
	ObjPic[ObjPic_Terrain_Tracks][HOUSE_HARKONNEN] = icon->getPictureRow(25,32);

	// load small detail pics
	SmallDetailPic[Picture_Barracks] = ExtractSmallDetailPic("BARRAC.WSA");
	SmallDetailPic[Picture_ConstructionYard] = ExtractSmallDetailPic("CONSTRUC.WSA");
	SmallDetailPic[Picture_Carryall] = ExtractSmallDetailPic("CARRYALL.WSA");
	SmallDetailPic[Picture_Devastator] = ExtractSmallDetailPic("HARKTANK.WSA");
	SmallDetailPic[Picture_Deviator] = ExtractSmallDetailPic("ORDRTANK.WSA");
	SmallDetailPic[Picture_DeathHand] = ExtractSmallDetailPic("GOLD-BB.WSA");
	SmallDetailPic[Picture_Fremen] = ExtractSmallDetailPic("FREMEN.WSA");
	SmallDetailPic[Picture_GunTurret] = ExtractSmallDetailPic("TURRET.WSA");
	SmallDetailPic[Picture_Harvester] = ExtractSmallDetailPic("HARVEST.WSA");
	SmallDetailPic[Picture_HeavyFactory] = ExtractSmallDetailPic("HVYFTRY.WSA");
	SmallDetailPic[Picture_HighTechFactory] = ExtractSmallDetailPic("HITCFTRY.WSA");
	SmallDetailPic[Picture_Soldier] = ExtractSmallDetailPic("INFANTRY.WSA");
	SmallDetailPic[Picture_IX] = ExtractSmallDetailPic("IX.WSA");
	SmallDetailPic[Picture_Launcher] = ExtractSmallDetailPic("RTANK.WSA");
	SmallDetailPic[Picture_LightFactory] = ExtractSmallDetailPic("LITEFTRY.WSA");
	SmallDetailPic[Picture_MCV] = ExtractSmallDetailPic("MCV.WSA");
	SmallDetailPic[Picture_Ornithopter] = ExtractSmallDetailPic("ORNI.WSA");
	SmallDetailPic[Picture_Palace] = ExtractSmallDetailPic("PALACE.WSA");
	SmallDetailPic[Picture_Quad] = ExtractSmallDetailPic("QUAD.WSA");
	SmallDetailPic[Picture_Radar] = ExtractSmallDetailPic("HEADQRTS.WSA");
	SmallDetailPic[Picture_Raider] = ExtractSmallDetailPic("OTRIKE.WSA");
	SmallDetailPic[Picture_Refinery] = ExtractSmallDetailPic("REFINERY.WSA");
	SmallDetailPic[Picture_RepairYard] = ExtractSmallDetailPic("REPAIR.WSA");
	SmallDetailPic[Picture_RocketTurret] = ExtractSmallDetailPic("RTURRET.WSA");
	SmallDetailPic[Picture_Saboteur] = ExtractSmallDetailPic("SABOTURE.WSA");
	SmallDetailPic[Picture_Sardaukar] = ExtractSmallDetailPic("SARDUKAR.WSA");
	SmallDetailPic[Picture_SiegeTank] = ExtractSmallDetailPic("HTANK.WSA");
	SmallDetailPic[Picture_Silo] = ExtractSmallDetailPic("STORAGE.WSA");
	SmallDetailPic[Picture_Slab1] = ExtractSmallDetailPic("SLAB.WSA");
	SmallDetailPic[Picture_Slab4] = ExtractSmallDetailPic("4SLAB.WSA");
	SmallDetailPic[Picture_SonicTank] = ExtractSmallDetailPic("STANK.WSA");
	SmallDetailPic[Picture_StarPort] = ExtractSmallDetailPic("STARPORT.WSA");
	SmallDetailPic[Picture_Tank] = ExtractSmallDetailPic("LTANK.WSA");
	SmallDetailPic[Picture_Trike] = ExtractSmallDetailPic("TRIKE.WSA");
	SmallDetailPic[Picture_Trooper] = ExtractSmallDetailPic("HYINFY.WSA");
	SmallDetailPic[Picture_Wall] = ExtractSmallDetailPic("WALL.WSA");
	SmallDetailPic[Picture_WindTrap] = ExtractSmallDetailPic("WINDTRAP.WSA");
	SmallDetailPic[Picture_WOR] = ExtractSmallDetailPic("WOR.WSA");
	// unused: FRIGATE.WSA, WORM.WSA, FARTR.WSA, FHARK.WSA, FORDOS.WSA

	// load animations
	Anim[Anim_AtreidesEyes] = menshpa->getAnimation(0,4,true,true);
	Anim[Anim_AtreidesEyes]->setFrameRate(0.5);
	Anim[Anim_AtreidesMouth] = menshpa->getAnimation(5,9,true,true);
	Anim[Anim_AtreidesMouth]->setFrameRate(5.0);
	Anim[Anim_AtreidesShoulder] = menshpa->getAnimation(10,10,true,true);
	Anim[Anim_AtreidesShoulder]->setFrameRate(1.0);
	Anim[Anim_AtreidesBook] = menshpa->getAnimation(11,12,true,true);
	Anim[Anim_AtreidesBook]->setFrameRate(0.1);
	Anim[Anim_HarkonnenEyes] = menshph->getAnimation(0,4,true,true);
	Anim[Anim_HarkonnenEyes]->setFrameRate(0.3);
	Anim[Anim_HarkonnenMouth] = menshph->getAnimation(5,9,true,true);
	Anim[Anim_HarkonnenMouth]->setFrameRate(5.0);
	Anim[Anim_HarkonnenShoulder] = menshph->getAnimation(10,10,true,true);
	Anim[Anim_HarkonnenShoulder]->setFrameRate(1.0);
	Anim[Anim_OrdosEyes] = menshpo->getAnimation(0,4,true,true);
	Anim[Anim_OrdosEyes]->setFrameRate(0.5);
	Anim[Anim_OrdosMouth] = menshpo->getAnimation(5,9,true,true);
	Anim[Anim_OrdosMouth]->setFrameRate(5.0);
	Anim[Anim_OrdosShoulder] = menshpo->getAnimation(10,10,true,true);
	Anim[Anim_OrdosShoulder]->setFrameRate(1.0);
	Anim[Anim_OrdosRing] = menshpo->getAnimation(11,14,true,true);
	Anim[Anim_OrdosRing]->setFrameRate(6.0);
	Anim[Anim_AtreidesPlanet] = LoadAnimationFromWsa("FARTR.WSA");
	Anim[Anim_AtreidesPlanet]->setFrameRate(12);
	Anim[Anim_HarkonnenPlanet] = LoadAnimationFromWsa("FHARK.WSA");
	Anim[Anim_HarkonnenPlanet]->setFrameRate(12);
	Anim[Anim_OrdosPlanet] = LoadAnimationFromWsa("FORDOS.WSA");
	Anim[Anim_OrdosPlanet]->setFrameRate(12);
	Anim[Anim_Win1] = LoadAnimationFromWsa("WIN1.WSA");
	Anim[Anim_Win2] = LoadAnimationFromWsa("WIN2.WSA");
	Anim[Anim_Lose1] = LoadAnimationFromWsa("LOSTBILD.WSA");
	Anim[Anim_Lose2] = LoadAnimationFromWsa("LOSTVEHC.WSA");
	Anim[Anim_Barracks] = LoadAnimationFromWsa("BARRAC.WSA");
	Anim[Anim_Carryall] = LoadAnimationFromWsa("CARRYALL.WSA");
	Anim[Anim_ConstructionYard] = LoadAnimationFromWsa("CONSTRUC.WSA");
	Anim[Anim_Fremen] = LoadAnimationFromWsa("FREMEN.WSA");
	Anim[Anim_DeathHand] = LoadAnimationFromWsa("GOLD-BB.WSA");
	Anim[Anim_Devastator] = LoadAnimationFromWsa("HARKTANK.WSA");
	Anim[Anim_Harvester] = LoadAnimationFromWsa("HARVEST.WSA");
	Anim[Anim_Radar] = LoadAnimationFromWsa("HEADQRTS.WSA");
	Anim[Anim_HighTechFactory] = LoadAnimationFromWsa("HITCFTRY.WSA");
	Anim[Anim_SiegeTank] = LoadAnimationFromWsa("HTANK.WSA");
	Anim[Anim_HeavyFactory] = LoadAnimationFromWsa("HVYFTRY.WSA");
	Anim[Anim_Trooper] = LoadAnimationFromWsa("HYINFY.WSA");
	Anim[Anim_Infantry] = LoadAnimationFromWsa("INFANTRY.WSA");
	Anim[Anim_IX] = LoadAnimationFromWsa("IX.WSA");
	Anim[Anim_LightFactory] = LoadAnimationFromWsa("LITEFTRY.WSA");
	Anim[Anim_Tank] = LoadAnimationFromWsa("LTANK.WSA");
	Anim[Anim_MCV] = LoadAnimationFromWsa("MCV.WSA");
	Anim[Anim_Deviator] = LoadAnimationFromWsa("ORDRTANK.WSA");
	Anim[Anim_Ornithopter] = LoadAnimationFromWsa("ORNI.WSA");
	Anim[Anim_Raider] = LoadAnimationFromWsa("OTRIKE.WSA");
	Anim[Anim_Palace] = LoadAnimationFromWsa("PALACE.WSA");
	Anim[Anim_Quad] = LoadAnimationFromWsa("QUAD.WSA");
	Anim[Anim_Refinery] = LoadAnimationFromWsa("REFINERY.WSA");
	Anim[Anim_RepairYard] = LoadAnimationFromWsa("REPAIR.WSA");
	Anim[Anim_Launcher] = LoadAnimationFromWsa("RTANK.WSA");
	Anim[Anim_RocketTurret] = LoadAnimationFromWsa("RTURRET.WSA");
	Anim[Anim_Saboteur] = LoadAnimationFromWsa("SABOTURE.WSA");
	Anim[Anim_Slab1] = LoadAnimationFromWsa("SLAB.WSA");
	Anim[Anim_SonicTank] = LoadAnimationFromWsa("STANK.WSA");
	Anim[Anim_StarPort] = LoadAnimationFromWsa("STARPORT.WSA");
	Anim[Anim_Silo] = LoadAnimationFromWsa("STORAGE.WSA");
	Anim[Anim_Trike] = LoadAnimationFromWsa("TRIKE.WSA");
	Anim[Anim_GunTurret] = LoadAnimationFromWsa("TURRET.WSA");
	Anim[Anim_Wall] = LoadAnimationFromWsa("WALL.WSA");
	Anim[Anim_WindTrap] = LoadAnimationFromWsa("WINDTRAP.WSA");
	Anim[Anim_WOR] = LoadAnimationFromWsa("WOR.WSA");
	Anim[Anim_Sandworm] = LoadAnimationFromWsa("WORM.WSA");
	Anim[Anim_Sardaukar] = LoadAnimationFromWsa("SARDUKAR.WSA");
	Anim[Anim_Frigate] = LoadAnimationFromWsa("FRIGATE.WSA");
	Anim[Anim_Slab4] = LoadAnimationFromWsa("4SLAB.WSA");

	for(int i = Anim_Barracks; i <= Anim_Slab4; i++) {
		Anim[i]->setFrameRate(15.0);
	}

	// load UI graphics
	UIGraphic[UI_RadarAnimation][HOUSE_HARKONNEN] = DoublePicture(radar->getAnimationAsPictureRow());
	UIGraphic[UI_CursorShape][HOUSE_HARKONNEN] = mouse->getPictureArray(7,1,0|TILE_NORMAL,1|TILE_NORMAL,2|TILE_NORMAL,3|TILE_NORMAL,4|TILE_NORMAL,5|TILE_NORMAL,6|TILE_NORMAL);
	SDL_SetColorKey(UIGraphic[UI_CursorShape][HOUSE_HARKONNEN], SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	UIGraphic[UI_CreditsDigits][HOUSE_HARKONNEN] = shapes->getPictureArray(10,1,2|TILE_NORMAL,3|TILE_NORMAL,4|TILE_NORMAL,5|TILE_NORMAL,6|TILE_NORMAL,
																				7|TILE_NORMAL,8|TILE_NORMAL,9|TILE_NORMAL,10|TILE_NORMAL,11|TILE_NORMAL);
	UIGraphic[UI_GameBar][HOUSE_HARKONNEN] = PicFactory->createGameBar();
	UIGraphic[UI_Indicator][HOUSE_HARKONNEN] = units1->getPictureArray(3,1,8|TILE_NORMAL,9|TILE_NORMAL,10|TILE_NORMAL);
	SDL_SetColorKey(UIGraphic[UI_Indicator][HOUSE_HARKONNEN], SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	UIGraphic[UI_InvalidPlace][HOUSE_HARKONNEN] = PicFactory->createInvalidPlace();
	UIGraphic[UI_ValidPlace][HOUSE_HARKONNEN] = PicFactory->createValidPlace();
	UIGraphic[UI_MenuBackground][HOUSE_HARKONNEN] = PicFactory->createMainBackground();
	UIGraphic[UI_Background][HOUSE_HARKONNEN] = PicFactory->createBackground();
	UIGraphic[UI_SelectionBox][HOUSE_HARKONNEN] = SDL_LoadBMP_RW(pFileManager->OpenFile("UI_SelectionBox.bmp"),true);
	SDL_SetColorKey(UIGraphic[UI_SelectionBox][HOUSE_HARKONNEN], SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	UIGraphic[UI_TopBar][HOUSE_HARKONNEN] = PicFactory->createTopBar();
	UIGraphic[UI_ButtonUp][HOUSE_HARKONNEN] = choam->getPicture(0);
	UIGraphic[UI_ButtonUp_Pressed][HOUSE_HARKONNEN] = choam->getPicture(1);
	UIGraphic[UI_ButtonDown][HOUSE_HARKONNEN] = choam->getPicture(2);
	UIGraphic[UI_ButtonDown_Pressed][HOUSE_HARKONNEN] = choam->getPicture(3);
	UIGraphic[UI_MessageBox][HOUSE_HARKONNEN] = PicFactory->createMessageBoxBorder();
	UIGraphic[UI_Mentat][HOUSE_HARKONNEN] = bttn->getPicture(0);
	UIGraphic[UI_Mentat_Pressed][HOUSE_HARKONNEN] = bttn->getPicture(1);
	UIGraphic[UI_Options][HOUSE_HARKONNEN] = bttn->getPicture(2);
	UIGraphic[UI_Options_Pressed][HOUSE_HARKONNEN] = bttn->getPicture(3);
	UIGraphic[UI_Upgrade][HOUSE_HARKONNEN] = choam->getPicture(4);
	SDL_SetColorKey(UIGraphic[UI_Upgrade][HOUSE_HARKONNEN], SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	UIGraphic[UI_Upgrade_Pressed][HOUSE_HARKONNEN] = choam->getPicture(5);
	SDL_SetColorKey(UIGraphic[UI_Upgrade_Pressed][HOUSE_HARKONNEN], SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	UIGraphic[UI_Repair][HOUSE_HARKONNEN] = SDL_LoadBMP_RW(pFileManager->OpenFile("Button_Repair.bmp"),true);
	UIGraphic[UI_Repair_Pressed][HOUSE_HARKONNEN] = SDL_LoadBMP_RW(pFileManager->OpenFile("Button_RepairPushed.bmp"),true);
	UIGraphic[UI_Difficulty][HOUSE_HARKONNEN] = SDL_LoadBMP_RW(pFileManager->OpenFile("Menu_Difficulty.bmp"),true);
	SDL_Rect dest1 = { 0,0,UIGraphic[UI_Difficulty][HOUSE_HARKONNEN]->w,30};
	PicFactory->drawFrame(UIGraphic[UI_Difficulty][HOUSE_HARKONNEN],PictureFactory::DecorationFrame1,&dest1);
	SDL_SetColorKey(UIGraphic[UI_Difficulty][HOUSE_HARKONNEN], SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	UIGraphic[UI_Dif_Easy][HOUSE_HARKONNEN] = SDL_LoadBMP_RW(pFileManager->OpenFile("Difficulty_Easy.bmp"),true);
	UIGraphic[UI_Dif_Hard][HOUSE_HARKONNEN] = SDL_LoadBMP_RW(pFileManager->OpenFile("Difficulty_Hard.bmp"),true);
	UIGraphic[UI_Dif_Medium][HOUSE_HARKONNEN] = SDL_LoadBMP_RW(pFileManager->OpenFile("Difficulty_Medium.bmp"),true);
	UIGraphic[UI_Minus][HOUSE_HARKONNEN] = SDL_LoadBMP_RW(pFileManager->OpenFile("Button_Minus.bmp"),true);
	UIGraphic[UI_Minus_Pressed][HOUSE_HARKONNEN] = SDL_LoadBMP_RW(pFileManager->OpenFile("Button_MinusPushed.bmp"),true);
	UIGraphic[UI_Plus][HOUSE_HARKONNEN] = SDL_LoadBMP_RW(pFileManager->OpenFile("Button_Plus.bmp"),true);
	UIGraphic[UI_Plus_Pressed][HOUSE_HARKONNEN] = SDL_LoadBMP_RW(pFileManager->OpenFile("Button_PlusPushed.bmp"),true);
	UIGraphic[UI_MissionSelect][HOUSE_HARKONNEN] = SDL_LoadBMP_RW(pFileManager->OpenFile("Menu_MissionSelect.bmp"),true);
	PicFactory->drawFrame(UIGraphic[UI_MissionSelect][HOUSE_HARKONNEN],PictureFactory::SimpleFrame,NULL);
	SDL_SetColorKey(UIGraphic[UI_MissionSelect][HOUSE_HARKONNEN], SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	UIGraphic[UI_OptionsMenu][HOUSE_HARKONNEN] = PicFactory->createOptionsMenu();
	SDL_Surface* tmp;
	if((tmp = SDL_CreateRGBSurface(SDL_HWSURFACE,192,27,8,0,0,0,0)) == NULL) {
		fprintf(stdout,"DataManager::DataManager(): Cannot create surface!\n");
		exit(EXIT_FAILURE);
	}
	SDL_SetColors(tmp, palette->colors, 0, palette->ncolors);
	SDL_FillRect(tmp,NULL,133);
	UIGraphic[UI_LoadSaveWindow][HOUSE_HARKONNEN] = PicFactory->createMenu(tmp,208);
	SDL_FreeSurface(tmp);
	UIGraphic[UI_DuneLegacy][HOUSE_HARKONNEN] = SDL_LoadBMP_RW(pFileManager->OpenFile("DuneLegacy.bmp"),true);
	UIGraphic[UI_GameMenu][HOUSE_HARKONNEN] = PicFactory->createMenu(UIGraphic[UI_DuneLegacy][HOUSE_HARKONNEN],158);
	PicFactory->drawFrame(UIGraphic[UI_DuneLegacy][HOUSE_HARKONNEN],PictureFactory::SimpleFrame);

	UIGraphic[UI_PlanetBackground][HOUSE_HARKONNEN] = bigplan->getPicture();
	PicFactory->drawFrame(UIGraphic[UI_PlanetBackground][HOUSE_HARKONNEN],PictureFactory::SimpleFrame);
	UIGraphic[UI_MenuButtonBorder][HOUSE_HARKONNEN] = PicFactory->createFrame(PictureFactory::DecorationFrame1,190,123,false);

	PicFactory->drawFrame(UIGraphic[UI_DuneLegacy][HOUSE_HARKONNEN],PictureFactory::SimpleFrame);

	UIGraphic[UI_MentatBackground][HOUSE_ATREIDES] = DoublePicture(mentata->getPicture());
	UIGraphic[UI_MentatBackground][HOUSE_FREMEN] = DoublePicture(mentata->getPicture());
	UIGraphic[UI_MentatBackground][HOUSE_ORDOS] = DoublePicture(mentato->getPicture());
	UIGraphic[UI_MentatBackground][HOUSE_MERCENARY] = DoublePicture(mentato->getPicture());
	UIGraphic[UI_MentatBackground][HOUSE_HARKONNEN] = DoublePicture(mentath->getPicture());
	UIGraphic[UI_MentatBackground][HOUSE_SARDAUKAR] = DoublePicture(mentath->getPicture());
	UIGraphic[UI_MentatYes][HOUSE_HARKONNEN] = DoublePicture(mentat->getPicture(0));
	UIGraphic[UI_MentatYes_Pressed][HOUSE_HARKONNEN] = DoublePicture(mentat->getPicture(1));
	UIGraphic[UI_MentatNo][HOUSE_HARKONNEN] = DoublePicture(mentat->getPicture(2));
	UIGraphic[UI_MentatNo_Pressed][HOUSE_HARKONNEN] = DoublePicture(mentat->getPicture(3));
	UIGraphic[UI_MentatExit][HOUSE_HARKONNEN] = DoublePicture(mentat->getPicture(4));
	UIGraphic[UI_MentatExit_Pressed][HOUSE_HARKONNEN] = DoublePicture(mentat->getPicture(5));
	UIGraphic[UI_MentatProcced][HOUSE_HARKONNEN] = DoublePicture(mentat->getPicture(6));
	UIGraphic[UI_MentatProcced_Pressed][HOUSE_HARKONNEN] = DoublePicture(mentat->getPicture(7));
	UIGraphic[UI_MentatRepeat][HOUSE_HARKONNEN] = DoublePicture(mentat->getPicture(8));
	UIGraphic[UI_MentatRepeat_Pressed][HOUSE_HARKONNEN] = DoublePicture(mentat->getPicture(9));
	UIGraphic[UI_HouseChoiceBackground][HOUSE_HARKONNEN] = herald->getPicture();
	UIGraphic[UI_HouseSelect][HOUSE_HARKONNEN] = PicFactory->createHouseSelect(UIGraphic[UI_HouseChoiceBackground][HOUSE_HARKONNEN]);
	UIGraphic[UI_HeraldAtre_Coloured][HOUSE_HARKONNEN] = GetSubPicture(UIGraphic[UI_HouseChoiceBackground][HOUSE_HARKONNEN],20,54,83,91);
	UIGraphic[UI_HeraldOrd_Coloured][HOUSE_HARKONNEN] = GetSubPicture(UIGraphic[UI_HouseChoiceBackground][HOUSE_HARKONNEN],117,54,83,91);
	UIGraphic[UI_HeraldHark_Coloured][HOUSE_HARKONNEN] = GetSubPicture(UIGraphic[UI_HouseChoiceBackground][HOUSE_HARKONNEN],215,54,82,91);
	UIGraphic[UI_HouseChoiceBackground][HOUSE_HARKONNEN] = DoublePicture(UIGraphic[UI_HouseChoiceBackground][HOUSE_HARKONNEN]);

	UIGraphic[UI_MapChoiceScreen][HOUSE_ATREIDES] = PicFactory->createMapChoiceScreen(HOUSE_ATREIDES);
	UIGraphic[UI_MapChoiceScreen][HOUSE_ORDOS] = PicFactory->createMapChoiceScreen(HOUSE_ORDOS);
	UIGraphic[UI_MapChoiceScreen][HOUSE_HARKONNEN] = PicFactory->createMapChoiceScreen(HOUSE_HARKONNEN);
	UIGraphic[UI_MapChoiceMapOnly][HOUSE_HARKONNEN] = DoublePicture(dunemap->getPicture());
	SDL_SetColorKey(UIGraphic[UI_MapChoiceMapOnly][HOUSE_HARKONNEN], SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	UIGraphic[UI_MapChoiceMap][HOUSE_HARKONNEN] = DoublePicture(dunergn->getPicture());
	SDL_SetColorKey(UIGraphic[UI_MapChoiceMap][HOUSE_HARKONNEN], SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	UIGraphic[UI_MapChoiceClickMap][HOUSE_HARKONNEN] = DoublePicture(rgnclk->getPicture());

	delete  PicFactory;


	// load map choice pieces
	for(int i = 0; i < NUM_MAPCHOICEPIECES; i++) {
		MapChoicePieces[i][HOUSE_HARKONNEN] = DoublePicture(pieces->getPicture(i));
		SDL_SetColorKey(MapChoicePieces[i][HOUSE_HARKONNEN], SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	}

	// load map choice arrows
	for(int i = 0; i < NUM_MAPCHOICEARROWS; i++) {
		MapChoiceArrows[i] = DoublePicture(arrows->getPicture(i));
		SDL_SetColorKey(MapChoiceArrows[i], SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	}

	// delete all fileclasses and close all files
	delete units;
	delete units1;
	delete units2;
	delete mouse;
	delete shapes;
	delete icon;
	delete radar;
	delete menshpa;
	delete menshph;
	delete menshpo;
	delete choam;
	delete bttn;
	delete bigplan;
	delete herald;
	delete mentata;
	delete mentato;
	delete mentath;
	delete mentat;
	delete dunemap;
	delete dunergn;
	delete rgnclk;
	delete pieces;
	delete arrows;
	SDL_RWclose(units_shp);
	SDL_RWclose(units1_shp);
	SDL_RWclose(units2_shp);
	SDL_RWclose(mouse_shp);
	SDL_RWclose(shapes_shp);
	SDL_RWclose(icon_icn);
	SDL_RWclose(icon_map);
	SDL_RWclose(static_wsa);
	SDL_RWclose(menshpa_shp);
	SDL_RWclose(menshph_shp);
	SDL_RWclose(menshpo_shp);
	SDL_RWclose(choam_lng);
	SDL_RWclose(bttn_lng);
	SDL_RWclose(bigplan_cps);
	SDL_RWclose(herald_lng);
	SDL_RWclose(mentata_cps);
	SDL_RWclose(mentato_cps);
	SDL_RWclose(mentath_cps);
	SDL_RWclose(mentat_lng);
	SDL_RWclose(dunemap_cps);
	SDL_RWclose(dunergn_cps);
	SDL_RWclose(rgnclk_cps);
	SDL_RWclose(pieces_shp);
	SDL_RWclose(arrows_shp);

	for(int i = 0; i < NUM_OBJPICS; i++) {
		for(int j = 0; j < (int) NUM_HOUSES; j++) {
			if(ObjPic[i][j] != NULL) {
				SDL_SetColorKey(ObjPic[i][j], SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
				SDL_Surface* tmp;
				tmp = ObjPic[i][j];
				if((ObjPic[i][j] = SDL_DisplayFormat(tmp)) == NULL) {
					fprintf(stdout,"DataManager: SDL_DisplayFormat() failed!\n");
					exit(EXIT_FAILURE);
				}
				SDL_FreeSurface(tmp);
			}
		}
	}

	for(int i = 0; i < NUM_SMALLDETAILPICS; i++) {
		if(SmallDetailPic[i] != NULL) {
			SDL_Surface* tmp;
			tmp = SmallDetailPic[i];
			if((SmallDetailPic[i] = SDL_DisplayFormat(tmp)) == NULL) {
				fprintf(stdout,"DataManager: SDL_DisplayFormat() failed!\n");
				exit(EXIT_FAILURE);
			}
			SDL_FreeSurface(tmp);
		}
	}


	for(int i = 0; i < NUM_UIGRAPHICS; i++) {
		for(int j = 0; j < (int) NUM_HOUSES; j++) {
			if(UIGraphic[i][j] != NULL) {
				SDL_Surface* tmp;
				tmp = UIGraphic[i][j];
				if((UIGraphic[i][j] = SDL_DisplayFormat(tmp)) == NULL) {
					fprintf(stdout,"DataManager: SDL_DisplayFormat() failed!\n");
					exit(EXIT_FAILURE);
				}
				SDL_FreeSurface(tmp);
			}
		}
	}

	// load voice and language specific sounds
	switch(settings.General.Language) {
		case LNG_ENG:
			LoadVoice_English();
			break;
		case LNG_GER:
			LoadVoice_German();
			break;
		default:
			fprintf(stdout,"DataManager: Unknown language!\n");
			exit(EXIT_FAILURE);
	}

	// load all language unspecific sounds
	// TODO

	for(int i = 0; i < NUM_SOUNDCHUNK; i++) {
		if(SoundChunk[i] == NULL) {
			fprintf(stdout,"DataManager::DataManager: Not all sounds could be loaded\n");
			exit(EXIT_FAILURE);
		}
	}

	for(int i = 0; i < NUM_ANIMATION; i++) {
		if(Anim[i] == NULL) {
			fprintf(stdout,"DataManager::DataManager: Not all animations could be loaded\n");
			exit(EXIT_FAILURE);
		}
	}

	// now load all texts
	SDL_RWops* text_lng[3];
	switch(settings.General.Language) {
		case LNG_ENG:
			text_lng[0] = pFileManager->OpenFile("TEXTA.ENG");
			text_lng[1] = pFileManager->OpenFile("TEXTO.ENG");
			text_lng[2] = pFileManager->OpenFile("TEXTH.ENG");
			break;
		case LNG_GER:
			text_lng[0] = pFileManager->OpenFile("TEXTA.GER");
			text_lng[1] = pFileManager->OpenFile("TEXTO.GER");
			text_lng[2] = pFileManager->OpenFile("TEXTH.GER");
			break;
		default:
			fprintf(stdout,"DataManager: Unknown language!\n");
			exit(EXIT_FAILURE);
	}

	for(int i=0;i<3;i++) {
		if(text_lng[i] == NULL) {
			fprintf(stdout,"DataManager::DataManager: Can not open language file\n");
			exit(EXIT_FAILURE);
		}
		BriefingStrings[i] = new BriefingText(text_lng[i]);
		SDL_RWclose(text_lng[i]);
	}
}

DataManager::~DataManager() {
	for(int i = 0; i < NUM_OBJPICS; i++) {
		for(int j = 0; j < (int) NUM_HOUSES; j++) {
			if(ObjPic[i][j] != NULL) {
				SDL_FreeSurface(ObjPic[i][j]);
				ObjPic[i][j] = NULL;
			}
		}
	}

	for(int i = 0; i < NUM_SMALLDETAILPICS; i++) {
		if(SmallDetailPic[i] != NULL) {
				SDL_FreeSurface(SmallDetailPic[i]);
				SmallDetailPic[i] = NULL;
		}
	}

	for(int i = 0; i < NUM_UIGRAPHICS; i++) {
		for(int j = 0; j < (int) NUM_HOUSES; j++) {
			if(UIGraphic[i][j] != NULL) {
					SDL_FreeSurface(UIGraphic[i][j]);
					UIGraphic[i][j] = NULL;
			}
		}
	}

	for(int i = 0; i < NUM_MAPCHOICEPIECES; i++) {
		for(int j = 0; j < (int) NUM_HOUSES; j++) {
			if(MapChoicePieces[i][j] != NULL) {
					SDL_FreeSurface(MapChoicePieces[i][j]);
					MapChoicePieces[i][j] = NULL;
			}
		}
	}

	for(int i = 0; i < NUM_MAPCHOICEARROWS; i++) {
		if(MapChoiceArrows[i] != NULL) {
				SDL_FreeSurface(MapChoiceArrows[i]);
				MapChoiceArrows[i] = NULL;
		}
	}

	for(int i = 0; i < NUM_ANIMATION; i++) {
		if(Anim[i] != NULL) {
				delete Anim[i];
				Anim[i] = NULL;
		}
	}

	// unload voice
	for(int i = 0; i < Num_Lng_Voice; i++) {
		if(Lng_Voice[i] != NULL) {
			Mix_FreeChunk(Lng_Voice[i]);
			Lng_Voice[i] = NULL;
		}
	}

	free(Lng_Voice);

	// unload sound
	for(int i = 0; i < NUM_SOUNDCHUNK; i++) {
		if(SoundChunk[i] != NULL) {
			Mix_FreeChunk(SoundChunk[i]);
			SoundChunk[i] = NULL;
		}
	}

	//unload briefing texts
	for(int i=0;i<3;i++) {
		delete BriefingStrings[i];
	}
}

SDL_Surface* DataManager::getObjPic(unsigned int id, int house) {
	if(id >= NUM_OBJPICS) {
		fprintf(stdout,"DataManager::GetUnitPic(): Unit Picture with id %d is not available!\n",id);
		exit(EXIT_FAILURE);
	}

	if(ObjPic[id][house] == NULL) {
		// remap to this color
		if(ObjPic[id][HOUSE_HARKONNEN] == NULL) {
			fprintf(stdout,"DataManager::GetUnitPic(): Unit Picture with id %d is not loaded!\n",id);
			exit(EXIT_FAILURE);
		}

		ObjPic[id][house] = MapImageHouseColor(ObjPic[id][HOUSE_HARKONNEN],house, COLOUR_HARKONNEN);
	}

	return ObjPic[id][house];
}


SDL_Surface* DataManager::getSmallDetailPic(unsigned int id) {
	if(id >= NUM_SMALLDETAILPICS) {
		return NULL;
	}
	return SmallDetailPic[id];
}


SDL_Surface* DataManager::getUIGraphic(unsigned int id, int house) {
	if(id >= NUM_UIGRAPHICS) {
		fprintf(stdout,"DataManager::getUIGraphic(): UI Graphic with id %d is not available!\n",id);
		exit(EXIT_FAILURE);
	}

	if(UIGraphic[id][house] == NULL) {
		// remap to this color
		if(UIGraphic[id][HOUSE_HARKONNEN] == NULL) {
			fprintf(stdout,"DataManager::getUIGraphic(): UI Graphic with id %d is not loaded!\n",id);
			exit(EXIT_FAILURE);
		}

		UIGraphic[id][house] = MapImageHouseColor(UIGraphic[id][HOUSE_HARKONNEN],house, COLOUR_HARKONNEN);
		//UIGraphic[id][house] = SDL_ConvertSurface(UIGraphic[id][HOUSE_HARKONNEN],UIGraphic[id][HOUSE_HARKONNEN]->format,SDL_HWSURFACE);
	}

	return UIGraphic[id][house];
}

SDL_Surface* DataManager::getMapChoicePiece(unsigned int num, int house) {
	if(num >= NUM_MAPCHOICEPIECES) {
		fprintf(stdout,"DataManager::getMapChoicePiece(): Map Piece with number %d is not available!\n",num);
		exit(EXIT_FAILURE);
	}

	if(MapChoicePieces[num][house] == NULL) {
		// remap to this color
		if(MapChoicePieces[num][HOUSE_HARKONNEN] == NULL) {
			fprintf(stdout,"DataManager::getMapChoicePiece(): Map Piece with number %d is not loaded!\n",num);
			exit(EXIT_FAILURE);
		}

		MapChoicePieces[num][house] = MapImageHouseColor(MapChoicePieces[num][HOUSE_HARKONNEN],house, COLOUR_HARKONNEN);
		//MapChoicePieces[num][house] = SDL_ConvertSurface(MapChoicePieces[num][HOUSE_HARKONNEN],MapChoicePieces[num][HOUSE_HARKONNEN]->format,SDL_HWSURFACE);
	}

	return MapChoicePieces[num][house];
}

SDL_Surface* DataManager::getMapChoiceArrow(unsigned int num) {
	if(num >= NUM_MAPCHOICEARROWS) {
		fprintf(stdout,"DataManager::getMapChoiceArrow(): Arrow number %d is not available!\n",num);
		exit(EXIT_FAILURE);
	}

	return MapChoiceArrows[num];
}

Animation* DataManager::getAnimation(unsigned int id) {
	if(id >= NUM_ANIMATION) {
		fprintf(stdout,"DataManager::getAnimation(): Animation with id %d is not available!\n",id);
		exit(EXIT_FAILURE);
	}

	return Anim[id];
}

Mix_Chunk* DataManager::GetVoice(unsigned int id, int house) {
	switch(settings.General.Language) {
		case LNG_ENG:
			return GetVoice_English(id,house);
			break;
		case LNG_GER:
			return GetVoice_German(id,house);
			break;
		default:
			fprintf(stdout,"DataManager: Unknown language!\n");
			exit(EXIT_FAILURE);
	}
}

Mix_Chunk* DataManager::GetSound(unsigned int id) {
	if(id >= NUM_SOUNDCHUNK)
		return NULL;

	return SoundChunk[id];
}

std::string	DataManager::GetBriefingText(unsigned int mission, unsigned int texttype, int house) {
	switch(house) {
		case HOUSE_ATREIDES:
		case HOUSE_FREMEN:
			return BriefingStrings[0]->getString(mission,texttype);
			break;
		case HOUSE_ORDOS:
		case HOUSE_MERCENARY:
			return BriefingStrings[1]->getString(mission,texttype);
			break;
		case HOUSE_HARKONNEN:
		case HOUSE_SARDAUKAR:
		default:
			return BriefingStrings[2]->getString(mission,texttype);
			break;
		}
}


void DataManager::DoWindTrapPalatteAnimation() {

	int oldWindTrapColorTimer = WindTrapColorTimer;
	if (++WindTrapColorTimer >= 140)
		WindTrapColorTimer = -139;

	if (oldWindTrapColorTimer/20 != WindTrapColorTimer/20) {
		for(int h = 0; h < NUM_HOUSES; h++) {
			SDL_Surface* graphic = ObjPic[ObjPic_Windtrap][h];

			if(graphic == NULL)
				continue;

			if (settings.Video.DoubleBuffered && (graphic->format->BitsPerPixel == 8)) {
				if (!SDL_MUSTLOCK(graphic) || (SDL_LockSurface(graphic) == 0)) {
					Uint8	*pixel;
					int		i, j;

					for (i = 0; i < graphic->w; i++) {
						for (j = 0; j < graphic->h; j++) {
							pixel = &((Uint8*)graphic->pixels)[j * graphic->pitch + i];
								if (*pixel == 223)
									*pixel = 128 + abs(WindTrapColorTimer/20);
						}
					}
					SDL_UnlockSurface(graphic);
				}
			} else {
				SDL_SetColors(graphic, &graphic->format->palette->colors[128 + abs(WindTrapColorTimer/20)], 223, 1);
			}
		}
	}
}

SDL_Surface* DataManager::ExtractSmallDetailPic(char* filename) {
	Wsafile* myWsafile;
	SDL_RWops* myFile;

	if((myFile = pFileManager->OpenFile(filename)) == NULL) {
		fprintf(stdout,"DataManager::ExtractSmallDetailPic: Cannot open %s!\n",filename);
		exit(EXIT_FAILURE);
	}

	if((myWsafile = new Wsafile(myFile)) == NULL) {
		fprintf(stdout,"DataManager::ExtractSmallDetailPic: Cannot open %s!\n",filename);
		exit(EXIT_FAILURE);
	}

	SDL_Surface* tmp;

	if((tmp = myWsafile->getPicture(0)) == NULL) {
		fprintf(stdout,"DataManager::ExtractSmallDetailPic: Cannot decode first frame in file %s!\n",filename);
		exit(EXIT_FAILURE);
	}

	if((tmp->w != 184) || (tmp->h != 112)) {
		fprintf(stdout,"DataManager::ExtractSmallDetailPic: Picture %s is not 184x112!\n",filename);
		exit(EXIT_FAILURE);
	}

	SDL_Surface* returnPic;

	// create new picture surface
	if((returnPic = SDL_CreateRGBSurface(SDL_HWSURFACE,91,55,8,0,0,0,0))== NULL) {
		fprintf(stdout,"DataManager::ExtractSmallDetailPic: Cannot create new Picture for %s!\n",filename);
		exit(EXIT_FAILURE);
	}

	SDL_SetColors(returnPic, palette->colors, 0, palette->ncolors);
	SDL_LockSurface(returnPic);
	SDL_LockSurface(tmp);

	//Now we can copy pixel by pixel
	for(int y = 0; y < 55;y++) {
		for(int x = 0; x < 91; x++) {
			*( ((char*) (returnPic->pixels)) + y*returnPic->pitch + x)
				= *( ((char*) (tmp->pixels)) + ((y*2)+1)*tmp->pitch + (x*2)+1);
		}
	}

	SDL_UnlockSurface(tmp);
	SDL_UnlockSurface(returnPic);

	SDL_FreeSurface(tmp);
	delete myWsafile;
	SDL_RWclose(myFile);

	return returnPic;
}

Animation* DataManager::LoadAnimationFromWsa(std::string filename) {
	SDL_RWops* file;
	if((file = pFileManager->OpenFile(filename)) == NULL) {
		fprintf(stdout,"DataManager::LoadmAniationFromWsa(): Cannot open %s!\n",filename.c_str());
		exit(EXIT_FAILURE);
	}

	Wsafile* wsafile;
	if((wsafile = new Wsafile(file)) == NULL) {
		fprintf(stdout,"DataManager::LoadAnimationFromWsa(): Cannot open %s!\n",filename.c_str());
		exit(EXIT_FAILURE);
	}

	Animation* ret = wsafile->getAnimation(0,wsafile->getNumFrames() - 1,true,false);
	delete wsafile;
	SDL_RWclose(file);
	return ret;
}


Mix_Chunk* DataManager::GetChunkFromFile(std::string Filename) {
	Mix_Chunk* returnChunk;
	SDL_RWops* rwop;

	if((rwop = pFileManager->OpenFile(Filename)) == NULL) {
		fprintf(stdout,"DataManager::GetChunkFromFile(): Cannot open %s!\n",Filename.c_str());
		exit(EXIT_FAILURE);
	}

	if((returnChunk = LoadVOC_RW(rwop, 0)) == NULL) {
		fprintf(stdout,"DataManager::GetChunkFromFile(): Cannot load %s!\n",Filename.c_str());
		exit(EXIT_FAILURE);
	}

	SDL_RWclose(rwop);
	return returnChunk;
}

Mix_Chunk* DataManager::Concat2Chunks(Mix_Chunk* sound1, Mix_Chunk* sound2)
{
	Mix_Chunk* returnChunk;
	if((returnChunk = (Mix_Chunk*) malloc(sizeof(Mix_Chunk))) == NULL) {
		return NULL;
	}

	returnChunk->allocated = 1;
	returnChunk->volume = sound1->volume;
	returnChunk->alen = sound1->alen + sound2->alen;

	if((returnChunk->abuf = (Uint8 *)malloc(returnChunk->alen)) == NULL) {
		free(returnChunk);
		return NULL;
	}

	memcpy(returnChunk->abuf, sound1->abuf, sound1->alen);
	memcpy(returnChunk->abuf + sound1->alen, sound2->abuf, sound2->alen);

	return returnChunk;
}

Mix_Chunk* DataManager::Concat3Chunks(Mix_Chunk* sound1, Mix_Chunk* sound2, Mix_Chunk* sound3)
{
	Mix_Chunk* returnChunk;
	if((returnChunk = (Mix_Chunk*) malloc(sizeof(Mix_Chunk))) == NULL) {
		return NULL;
	}

	returnChunk->allocated = 1;
	returnChunk->volume = sound1->volume;
	returnChunk->alen = sound1->alen + sound2->alen + sound3->alen;

	if((returnChunk->abuf = (Uint8 *)malloc(returnChunk->alen)) == NULL) {
		free(returnChunk);
		return NULL;
	}

	memcpy(returnChunk->abuf, sound1->abuf, sound1->alen);
	memcpy(returnChunk->abuf + sound1->alen, sound2->abuf, sound2->alen);
	memcpy(returnChunk->abuf + sound1->alen + sound2->alen, sound3->abuf, sound3->alen);

	return returnChunk;
}

Mix_Chunk* DataManager::CreateEmptyChunk()
{
	Mix_Chunk* returnChunk;
	if((returnChunk = (Mix_Chunk*) malloc(sizeof(Mix_Chunk))) == NULL) {
		return NULL;
	}

	returnChunk->allocated = 1;
	returnChunk->volume = 0;
	returnChunk->alen = 0;
	returnChunk->abuf = NULL;

	return returnChunk;
}

void DataManager::LoadVoice_English() {
	Num_Lng_Voice = NUM_VOICE*3;

	if((Lng_Voice = (Mix_Chunk**) malloc(sizeof(Mix_Chunk*) * Num_Lng_Voice)) == NULL) {
		fprintf(stdout,"DataManager::LoadVoice_English: Cannot allocate memory!\n");
		exit(EXIT_FAILURE);
	}

	for(int i = 0; i < Num_Lng_Voice; i++) {
		Lng_Voice[i] = NULL;
	}

	// now we can load
	for(int house = 0; house < 3; house++) {
		Mix_Chunk* HouseNameChunk;

		std::string HouseString;
		int VoiceNum;
		switch(house) {
			case HOUSE_ATREIDES:
			case HOUSE_FREMEN:
				VoiceNum = 0;
				HouseString = "A";
				HouseNameChunk = GetChunkFromFile(HouseString + "ATRE.VOC");
				break;
			case HOUSE_ORDOS:
			case HOUSE_MERCENARY:
				VoiceNum = 1;
				HouseString = "O";
				HouseNameChunk = GetChunkFromFile(HouseString + "ORDOS.VOC");
				break;
			case HOUSE_HARKONNEN:
			case HOUSE_SARDAUKAR:
			default:
				VoiceNum = 2;
				HouseString = "H";
				HouseNameChunk = GetChunkFromFile(HouseString + "HARK.VOC");
				break;
		}

		// "... Harvester deployed"
		Mix_Chunk* Harvester = GetChunkFromFile(HouseString + "HARVEST.VOC");
		Mix_Chunk* Deployed = GetChunkFromFile(HouseString + "DEPLOY.VOC");
		Lng_Voice[HarvesterDeployed*3+VoiceNum] = Concat3Chunks(HouseNameChunk, Harvester, Deployed);
		Mix_FreeChunk(Harvester);
		Mix_FreeChunk(Deployed);

		// "Contruction complete"
		Lng_Voice[ConstructionComplete*3+VoiceNum] = GetChunkFromFile(HouseString + "CONST.VOC");

		// "Vehicle repaired"
		Mix_Chunk* Vehicle = GetChunkFromFile(HouseString + "VEHICLE.VOC");
		Mix_Chunk* Repaired = GetChunkFromFile(HouseString + "REPAIR.VOC");
		Lng_Voice[VehicleRepaired*3+VoiceNum] = Concat2Chunks(Vehicle, Repaired);
		Mix_FreeChunk(Vehicle);
		Mix_FreeChunk(Repaired);

		// "Frigate has arrived"
		Mix_Chunk* FrigateChunk = GetChunkFromFile(HouseString + "FRIGATE.VOC");
		Mix_Chunk* HasArrivedChunk = GetChunkFromFile(HouseString + "ARRIVE.VOC");
		Lng_Voice[FrigateHasArrived*3+VoiceNum] = Concat2Chunks(FrigateChunk, HasArrivedChunk);
		Mix_FreeChunk(FrigateChunk);
		Mix_FreeChunk(HasArrivedChunk);

		// "Your mission is complete"
		Lng_Voice[YourMissionIsComplete*3+VoiceNum] = GetChunkFromFile(HouseString + "WIN.VOC");

		// "You have failed your mission"
		Lng_Voice[YouHaveFailedYourMission*3+VoiceNum] = GetChunkFromFile(HouseString + "LOSE.VOC");

		// "Radar activated"/"Radar deactivated"
		Mix_Chunk* RadarChunk = GetChunkFromFile(HouseString + "RADAR.VOC");
		Mix_Chunk* RadarActivatedChunk = GetChunkFromFile(HouseString + "ON.VOC");
		Mix_Chunk* RadarDeactivatedChunk = GetChunkFromFile(HouseString + "OFF.VOC");
		Lng_Voice[RadarActivated*3+VoiceNum] = Concat2Chunks(RadarChunk, RadarActivatedChunk);
		Lng_Voice[RadarDeactivated*3+VoiceNum] = Concat2Chunks(RadarChunk, RadarDeactivatedChunk);
		Mix_FreeChunk(RadarChunk);
		Mix_FreeChunk(RadarActivatedChunk);
		Mix_FreeChunk(RadarDeactivatedChunk);

		Mix_FreeChunk(HouseNameChunk);
	}

	for(int i = 0; i < Num_Lng_Voice; i++) {
		if(Lng_Voice[i] == NULL) {
			fprintf(stdout,"DataManager::LoadVoice_English: Not all voice sounds could be loaded\n");
			exit(EXIT_FAILURE);
		}
	}

	// "Yes Sir"
	SoundChunk[YesSir] = GetChunkFromFile("ZREPORT1.VOC");

	// "Reporting"
	SoundChunk[Reporting] = GetChunkFromFile("ZREPORT2.VOC");

	// "Acknowledged"
	SoundChunk[Acknowledged] = GetChunkFromFile("ZREPORT3.VOC");

	// "Affirmative"
	SoundChunk[Affirmative] = GetChunkFromFile("ZAFFIRM.VOC");

	// "Moving out"
	SoundChunk[MovingOut] = GetChunkFromFile("ZMOVEOUT.VOC");

	// "Infantry out"
	SoundChunk[InfantryOut] = GetChunkFromFile("ZOVEROUT.VOC");

	// "Somthing's under the sand"
	SoundChunk[SomethingUnderTheSand] = GetChunkFromFile("SANDBUG.VOC");

	// "House Atreides"
	SoundChunk[HouseAtreides] = GetChunkFromFile("MATRE.VOC");

	// "House Ordos"
	SoundChunk[HouseOrdos] = GetChunkFromFile("MORDOS.VOC");

	// "House Harkonnen"
	SoundChunk[HouseHarkonnen] = GetChunkFromFile("MHARK.VOC");

	// Sfx
	SoundChunk[PlaceStructure] = GetChunkFromFile("EXDUD.VOC");
	SoundChunk[ButtonClick] = GetChunkFromFile("BUTTON.VOC");
	SoundChunk[InvalidAction] = Mix_LoadWAV_RW(pFileManager->OpenFile("CANNOT.WAV"),1);
	SoundChunk[CreditsTick] = Mix_LoadWAV_RW(pFileManager->OpenFile("CREDIT.WAV"),1);
	SoundChunk[RadarNoise] = GetChunkFromFile("STATICP.VOC");
	SoundChunk[Sound_ExplosionGas] = GetChunkFromFile("EXGAS.VOC");
	SoundChunk[Sound_ExplosionTiny] = GetChunkFromFile("EXTINY.VOC");
	SoundChunk[Sound_ExplosionSmall] = GetChunkFromFile("EXSMALL.VOC");
	SoundChunk[Sound_ExplosionMedium] = GetChunkFromFile("EXMED.VOC");
	SoundChunk[Sound_ExplosionLarge] = GetChunkFromFile("EXLARGE.VOC");
	SoundChunk[Sound_ExplosionStructure] = GetChunkFromFile("CRUMBLE.VOC");
	SoundChunk[Sound_WormAttack] = GetChunkFromFile("WORMET3P.VOC");
	SoundChunk[Sound_Gun] = GetChunkFromFile("GUN.VOC");
	SoundChunk[Sound_Rocket] = GetChunkFromFile("ROCKET.VOC");
	SoundChunk[Sound_Bloom] = GetChunkFromFile("EXSAND.VOC");
	SoundChunk[Sound_Scream1] = GetChunkFromFile("VSCREAM1.VOC");
	SoundChunk[Sound_Scream2] = GetChunkFromFile("VSCREAM1.VOC");
	SoundChunk[Sound_Scream3] = GetChunkFromFile("VSCREAM1.VOC");
	SoundChunk[Sound_Scream4] = GetChunkFromFile("VSCREAM1.VOC");
	SoundChunk[Sound_Scream5] = GetChunkFromFile("VSCREAM1.VOC");
	SoundChunk[Sound_Squashed] = GetChunkFromFile("SQUISH2.VOC");
	SoundChunk[Sound_MachineGun] = GetChunkFromFile("GUNMULTI.VOC");
	SoundChunk[Sound_Sonic] = Mix_LoadWAV_RW(pFileManager->OpenFile("SONIC.WAV"),1);
	SoundChunk[Sound_RocketSmall] = GetChunkFromFile("MISLTINP.VOC");
}


Mix_Chunk* DataManager::GetVoice_English(unsigned int id, int house) {
	if((int) id >= Num_Lng_Voice)
		return NULL;

	int VoiceNum;
	switch(house) {
		case HOUSE_ATREIDES:
		case HOUSE_FREMEN:
			VoiceNum = 0;
			break;
		case HOUSE_ORDOS:
		case HOUSE_MERCENARY:
			VoiceNum = 1;
			break;
		case HOUSE_HARKONNEN:
		case HOUSE_SARDAUKAR:
		default:
			VoiceNum = 2;
			break;
	}

	return Lng_Voice[id*3 + VoiceNum];
}

void DataManager::LoadVoice_German() {
	Num_Lng_Voice = NUM_VOICE;

	if((Lng_Voice = (Mix_Chunk**) malloc(sizeof(Mix_Chunk*) * NUM_VOICE)) == NULL) {
		fprintf(stdout,"DataManager::LoadVoice_German: Cannot allocate memory!\n");
		exit(EXIT_FAILURE);
	}

	for(int i = 0; i < NUM_VOICE; i++) {
		Lng_Voice[i] = NULL;
	}


	Lng_Voice[HarvesterDeployed] = GetChunkFromFile("GHARVEST.VOC");

	// "Contruction complete"
	Lng_Voice[ConstructionComplete] = GetChunkFromFile("GCONST.VOC");

	// "Vehicle repaired"
	Lng_Voice[VehicleRepaired] = GetChunkFromFile("GREPAIR.VOC");

	// "Frigate has arrived"
	Lng_Voice[FrigateHasArrived] = GetChunkFromFile("GFRIGATE.VOC");

	// "Your mission is complete" (No german voc available)
	Lng_Voice[YourMissionIsComplete] = CreateEmptyChunk();

	// "You have failed your mission" (No german voc available)
	Lng_Voice[YouHaveFailedYourMission] = CreateEmptyChunk();

	// "Radar activated"/"Radar deactivated"
	Lng_Voice[RadarActivated] = GetChunkFromFile("GON.VOC");
	Lng_Voice[RadarDeactivated] = GetChunkFromFile("GOFF.VOC");

	for(int i = 0; i < Num_Lng_Voice; i++) {
		if(Lng_Voice[i] == NULL) {
			fprintf(stdout,"DataManager::LoadVoice_German: Not all voice sounds could be loaded\n");
			exit(EXIT_FAILURE);
		}
	}

	// "Yes Sir"
	SoundChunk[YesSir] = GetChunkFromFile("GREPORT1.VOC");

	// "Reporting"
	SoundChunk[Reporting] = GetChunkFromFile("GREPORT2.VOC");

	// "Acknowledged"
	SoundChunk[Acknowledged] = GetChunkFromFile("GREPORT3.VOC");

	// "Affirmative"
	SoundChunk[Affirmative] = GetChunkFromFile("GAFFIRM.VOC");

	// "Moving out"
	SoundChunk[MovingOut] = GetChunkFromFile("GMOVEOUT.VOC");

	// "Infantry out"
	SoundChunk[InfantryOut] = GetChunkFromFile("GOVEROUT.VOC");

	// "Somthing's under the sand"
	SoundChunk[SomethingUnderTheSand] = GetChunkFromFile("SANDBUG.VOC");

	// "House Atreides"
	SoundChunk[HouseAtreides] = GetChunkFromFile("GATRE.VOC");

	// "House Ordos"
	SoundChunk[HouseOrdos] = GetChunkFromFile("GORDOS.VOC");

	// "House Harkonnen"
	SoundChunk[HouseHarkonnen] = GetChunkFromFile("GHARK.VOC");

	// Sfx
	SoundChunk[PlaceStructure] = GetChunkFromFile("EXDUD.VOC");
	SoundChunk[ButtonClick] = GetChunkFromFile("BUTTON.VOC");
	SoundChunk[InvalidAction] = Mix_LoadWAV_RW(pFileManager->OpenFile("CANNOT.WAV"),1);
	SoundChunk[CreditsTick] = Mix_LoadWAV_RW(pFileManager->OpenFile("CREDIT.WAV"),1);
	SoundChunk[RadarNoise] = GetChunkFromFile("STATICP.VOC");
	SoundChunk[Sound_ExplosionGas] = GetChunkFromFile("EXGAS.VOC");
	SoundChunk[Sound_ExplosionTiny] = GetChunkFromFile("EXTINY.VOC");
	SoundChunk[Sound_ExplosionSmall] = GetChunkFromFile("EXSMALL.VOC");
	SoundChunk[Sound_ExplosionMedium] = GetChunkFromFile("EXMED.VOC");
	SoundChunk[Sound_ExplosionLarge] = GetChunkFromFile("EXLARGE.VOC");
	SoundChunk[Sound_ExplosionStructure] = GetChunkFromFile("CRUMBLE.VOC");
	SoundChunk[Sound_WormAttack] = GetChunkFromFile("WORMET3P.VOC");
	SoundChunk[Sound_Gun] = GetChunkFromFile("GUN.VOC");
	SoundChunk[Sound_Rocket] = GetChunkFromFile("ROCKET.VOC");
	SoundChunk[Sound_Bloom] = GetChunkFromFile("EXSAND.VOC");
	SoundChunk[Sound_Scream1] = GetChunkFromFile("VSCREAM1.VOC");
	SoundChunk[Sound_Scream2] = GetChunkFromFile("VSCREAM1.VOC");
	SoundChunk[Sound_Scream3] = GetChunkFromFile("VSCREAM1.VOC");
	SoundChunk[Sound_Scream4] = GetChunkFromFile("VSCREAM1.VOC");
	SoundChunk[Sound_Scream5] = GetChunkFromFile("VSCREAM1.VOC");
	SoundChunk[Sound_Squashed] = GetChunkFromFile("SQUISH2.VOC");
	SoundChunk[Sound_MachineGun] = GetChunkFromFile("GUNMULTI.VOC");
	SoundChunk[Sound_Sonic] = Mix_LoadWAV_RW(pFileManager->OpenFile("SONIC.WAV"),1);
	SoundChunk[Sound_RocketSmall] = GetChunkFromFile("MISLTINP.VOC");
}

Mix_Chunk* DataManager::GetVoice_German(unsigned int id, int house) {
	if((int)id >= Num_Lng_Voice)
		return NULL;

	return Lng_Voice[id];
}
