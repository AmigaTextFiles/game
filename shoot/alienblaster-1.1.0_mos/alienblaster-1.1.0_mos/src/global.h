/*************************************************************************** 
  alienBlaster 
  Copyright (C) 2004 
  Paul Grathwohl, Arne Hormann, Daniel Kuehn, Soenke Schwardt

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2, or (at your option)
  any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
***************************************************************************/
#ifndef GLOBAL_H
#define GLOBAL_H

#ifdef __MORPHOS__
#define PATH ""
#else
#define PATH "./"
#endif

#include <string>

class Racers;
class Enemys;
class Shots;
class Explosions;
class Items;
class Wrecks;
class Banners;
class SmokePuffs;
class Options;

extern Racers *racers;
extern Enemys *enemys;
extern Shots *shots;
extern Explosions *explosions;
extern Items *items;
extern Wrecks *wrecks;
extern Banners *banners;
extern SmokePuffs *smokePuffs;
extern Options *levelConf;

extern int GAME_LENGTH;
extern bool scrollingOn;
extern bool nukeIsInPlace;
extern bool playMusicOn;
extern bool onePlayerGame;
extern bool arcadeGame;
extern int difficultyLevel;
extern float actBackgroundPos;

void parseGlobalConfigValues( int difficultyLevel );
int getRandValue( const int *choicesWeights, int nrChoices, int sumWeights=0 );
void initAllSurfaces();

// screen options
const int SCREEN_WIDTH = 640;
const int SCREEN_HEIGHT = 480;
const int BIT_DEPTH = 24;

const int MAX_PLAYER_CNT = 2;

// the speed of the background scrolling
const float SCROLL_SPEED = 20;

// where is the absolute border of no return for the heatseeker?
// they have a chance to return within SCREEN_BORDER pixels outside the screen...
// outside this area shots are deleted
const int SHOT_SCREEN_BORDER = 50;


/********************************* ARCADE MODE ***********************************/

const int ARCADE_DIFFICULTY_LEVEL = 4;
const int ARCADE_POINTS_PER_TEN_SECONDS = 30;

// BANNER_RANDOM: no real mode, just the value to choose one randomly
enum BannerModes { BANNER_MODE_FLY_FROM_LEFT=0, 
		   BANNER_MODE_FROM_TOP,
		   BANNER_MODE_ITEM_COLLECTED_SINGLE_PLAYER,
		   BANNER_MODE_ITEM_COLLECTED_PLAYER_ONE,
		   BANNER_MODE_ITEM_COLLECTED_PLAYER_TWO,
		   BANNER_MODE_RANDOM=1000 };
const int BANNER_MODE_LIFETIME[] = { 5000, 5000, 2000, 2000, 2000 };
const int NR_BANNER_MODES = 2;

enum BannerTexts { BANNER_EXCELLENT=0, BANNER_YOU_RULE, BANNER_HEIHO,
		   BANNER_HEALTH, BANNER_ENEMYS_KILLED, 
		   BANNER_ITEM_HEALTH_COLLECTED,
		   BANNER_ITEM_PRIMARY_UPGRADE_COLLECTED,
		   BANNER_ITEM_DUMBFIRE_DOUBLE_COLLECTED,
		   BANNER_ITEM_KICK_ASS_ROCKET_COLLECTED,
		   BANNER_ITEM_HELLFIRE_COLLECTED,
		   BANNER_ITEM_MACHINE_GUN_COLLECTED,
		   BANNER_ITEM_HEATSEEKER_COLLECTED,
		   BANNER_ITEM_NUKE_COLLECTED,
		   BANNER_ITEM_DEFLECTOR_COLLECTED,
		   BANNER_ITEM_ENERGY_BEAM_COLLECTED,
		   BANNER_ITEM_LASER_COLLECTED };
const std::string FN_BANNER_TEXTS[] =
{ PATH"images/bannerExcellent.bmp",
  PATH"images/bannerYouRule.bmp",
  PATH"images/bannerHeiho.bmp",
  PATH"images/bannerHealth.bmp",
  PATH"images/bannerEnemysKilled.bmp",
  PATH"images/bannerItemHealthCollected.bmp",
  PATH"images/bannerItemPrimaryUpgradeCollected.bmp",
  PATH"images/bannerItemDumbfireDoubleCollected.bmp",
  PATH"images/bannerItemKickAssRocketCollected.bmp",
  PATH"images/bannerItemHellfireCollected.bmp",
  PATH"images/bannerItemMachineGunCollected.bmp",
  PATH"images/bannerItemHeatseekerCollected.bmp",
  PATH"images/bannerItemNukeCollected.bmp",
  PATH"images/bannerItemDeflectorCollected.bmp",
  PATH"images/bannerItemEnergyBeamCollected.bmp",
  PATH"images/bannerItemLaserCollected.bmp" };
const int NR_BANNER_TEXTS = 3;

enum BannerBoni { BANNER_BONUS_100=0, 
		  BANNER_BONUS_200,
		  BANNER_BONUS_NONE=1000 };
const std::string FN_BANNER_BONUS[] = 
{ PATH"images/bannerBonus100.bmp", 
  PATH"images/bannerBonus200.bmp" };
const int NR_BANNER_BONI = 2;

const float ARCADE_POINTS_FOR_FORMATION_DESTRUCTION = 100;
const BannerBoni ARCADE_BONUS_FOR_FORMATION_DESTRUCTION = BANNER_BONUS_100;

const float ARCADE_POINTS_FOR_ENEMYS_KILLED = 200;
const BannerBoni ARCADE_BONUS_FOR_ENEMYS_KILLED = BANNER_BONUS_200;

const int NR_ARCACE_POINTS_FOR_HEALTH_ITEM = 7;
const float ARCADE_POINTS_FOR_HEALTH_ITEM[ NR_ARCACE_POINTS_FOR_HEALTH_ITEM ] = 
{ 2000, 5000, 10000, 15000, 25000, 35000, 50000 };


/********************************** ITEMS ****************************************/

enum ItemTypes { ITEM_PRIMARY_UPGRADE=0,
		 ITEM_DUMBFIRE_DOUBLE,
		 ITEM_KICK_ASS_ROCKET,
		 ITEM_HELLFIRE,
		 ITEM_MACHINE_GUN,
		 ITEM_HEALTH,
		 ITEM_HEATSEEKER,
		 ITEM_NUKE,
		 ITEM_DEFLECTOR,
		 ITEM_LASER,
		 ITEM_ENERGY_BEAM };

const int NR_ITEM_TYPES = 11;
 
extern int ITEM_LIFETIME; // ms
extern int ITEM_APPEAR_DELAY; // ms
extern int ITEM_APPEAR_RAND_DELAY; // ms

// ITEM_HEALTH_REPAIR_AMOUNT points are restored, if collected
extern int ITEM_HEALTH_REPAIR_AMOUNT;
// if collected by heavy fighter the amount will be multiplied by this factor
const float ITEM_HEALTH_REPAIR_FACTOR_HEAVY_FIGHTER = 2.0;

// if collected ITEM_HEATSEEKER_AMMO rockets can be fired
extern int ITEM_HEATSEEKER_AMMO;
extern int ITEM_NUKE_AMMO;
extern int ITEM_DEFLECTOR_AMMO;

extern int ITEM_DEFLECTOR_DURATION;
extern int ITEM_DEFLECTOR_ACTIVATION_DIST;
extern int ITEM_DEFLECTOR_POWER;

// the items have different probabilities to appear.
// bigger number -> greater chance
extern int ITEM_APPEAR_CHANCES[];

enum ExplosionTypes { EXPLOSION_NORMAL_AIR=0, EXPLOSION_NORMAL_GROUND };
const int NR_EXPLOSION_TYPES = 2;
const int LIFETIME_EXPL_NORMAL = 1500;

const int NUKE_EFFECT_DURATION = 1000;
const int NUKE_QUAKE_EFFECT = 40;

enum ShipTypes { LIGHT_FIGHTER=0, HEAVY_FIGHTER };
const int NR_SHIPS = 2;


/*********************************** SHOTS ********************************/


enum ShotTypes { SHOT_NORMAL=0,
		 SHOT_NORMAL_HEAVY,
		 SHOT_DOUBLE,
		 SHOT_DOUBLE_HEAVY, 
		 SHOT_TRIPLE, 
		 SHOT_HF_NORMAL,
		 SHOT_HF_DOUBLE,
		 SHOT_HF_TRIPLE,
		 SHOT_HF_QUATTRO,
		 SHOT_HF_QUINTO,
		 SHOT_DUMBFIRE=100,
		 SHOT_DUMBFIRE_DOUBLE,
		 SHOT_KICK_ASS_ROCKET,
		 SHOT_HELLFIRE,
		 SHOT_MACHINE_GUN,
		 SHOT_ENERGY_BEAM,
		 SHOT_HF_DUMBFIRE,
		 SHOT_HF_DUMBFIRE_DOUBLE,
		 SHOT_HF_KICK_ASS_ROCKET,
		 SHOT_HF_LASER,
		 ENEMY_SHOT_NORMAL=1000,
		 ENEMY_SHOT_TANK_ROCKET,
		 SPECIAL_SHOT_HEATSEEKER=10000,
		 SPECIAL_SHOT_NUKE };
const int NR_SECONDARY_WEAPONS = 10;

enum SpecialTypes { SPECIAL_NONE=0, SPECIAL_NUKE, SPECIAL_HEATSEEKER, SPECIAL_DEFLECTOR };
const int NR_SPECIALS = 4;

// after that many ms the shot is expired
const int LIFETIME_SHOT_NORMAL = 5000;
const int LIFETIME_SHOT_NORMAL_HEAVY = 5000;
const int LIFETIME_SHOT_DOUBLE = 5000;
const int LIFETIME_SHOT_DOUBLE_HEAVY = 5000;
const int LIFETIME_SHOT_TRIPLE = 5000;
const int LIFETIME_SHOT_HF_NORMAL = 6000;
const int LIFETIME_SHOT_HF_DOUBLE = 6000;
const int LIFETIME_SHOT_HF_TRIPLE = 6000;
const int LIFETIME_SHOT_HF_QUATTRO = 6000;
const int LIFETIME_SHOT_HF_QUINTO = 6000;

const int LIFETIME_SHOT_DUMBFIRE = 6000;
const int LIFETIME_SHOT_DUMBFIRE_DOUBLE = 6000;
const int LIFETIME_SHOT_KICK_ASS_ROCKET = 7000;
const int LIFETIME_SHOT_HELLFIRE = 6000;
const int LIFETIME_SHOT_MACHINE_GUN = 5000;
const int LIFETIME_SHOT_ENERY_BEAM = 5000;

const int LIFETIME_SHOT_HF_DUMBFIRE = 6000;
const int LIFETIME_SHOT_HF_DUMBFIRE_DOUBLE = 6000;
const int LIFETIME_SHOT_HF_KICK_ASS_ROCKET = 7000;
const int LIFETIME_SHOT_HF_LASER = 2000;

const int LIFETIME_SPECIAL_SHOT_HEATSEEKER = 10000;
const int LIFETIME_SPECIAL_SHOT_NUKE = 10000;

const int VEL_SHOT_NORMAL = 150;
const int VEL_SHOT_NORMAL_HEAVY = 150;
const int VEL_SHOT_DOUBLE = 150;
const int VEL_SHOT_DOUBLE_HEAVY = 150;
const int VEL_SHOT_TRIPLE = 150;

const int VEL_SHOT_HF_NORMAL = 180;
const int VEL_SHOT_HF_DOUBLE = 180;
const int VEL_SHOT_HF_TRIPLE = 180;
const int VEL_SHOT_HF_QUATTRO = 180;
const int VEL_SHOT_HF_QUINTO = 180;

const int VEL_SHOT_DUMBFIRE = 100;
const int VEL_SHOT_DUMBFIRE_DOUBLE = 100;
const int VEL_SHOT_KICK_ASS_ROCKET = 80;
const int VEL_SHOT_HELLFIRE = 110;
const int VEL_SHOT_MACHINE_GUN = 130;
const int VEL_SHOT_ENERGY_BEAM = 105;

const int VEL_SHOT_HF_DUMBFIRE = 160;
const int VEL_SHOT_HF_DUMBFIRE_DOUBLE = 160;
const int VEL_SHOT_HF_KICK_ASS_ROCKET = 80;
const int VEL_SHOT_HF_LASER = 600;

const int VEL_SPECIAL_SHOT_HEATSEEKER = 130;
const int VEL_SPECIAL_SHOT_NUKE = 180;

const float DAMAGE_SHOT_NORMAL = 5;
const float DAMAGE_SHOT_NORMAL_HEAVY = 8;
const float DAMAGE_SHOT_DOUBLE = 5;
const float DAMAGE_SHOT_DOUBLE_HEAVY = 8;
const float DAMAGE_SHOT_TRIPLE = 7;

const int DAMAGE_SHOT_HF_NORMAL = 20;
const int DAMAGE_SHOT_HF_DOUBLE = 20;
const int DAMAGE_SHOT_HF_TRIPLE = 20;
const int DAMAGE_SHOT_HF_QUATTRO = 20;
const int DAMAGE_SHOT_HF_QUINTO = 20;

const float DAMAGE_SHOT_DUMBFIRE = 40;
const float DAMAGE_SHOT_DUMBFIRE_DOUBLE = 30;
const float DAMAGE_SHOT_KICK_ASS_ROCKET = 151; // should kill a tank/turret with one shot
const float DAMAGE_SHOT_HELLFIRE = 50;
const float DAMAGE_SHOT_MACHINE_GUN = 8;
const float DAMAGE_SHOT_ENERGY_BEAM = 80;

const int DAMAGE_SHOT_HF_DUMBFIRE = 40;
const int DAMAGE_SHOT_HF_DUMBFIRE_DOUBLE = 40;
const int DAMAGE_SHOT_HF_KICK_ASS_ROCKET = 151;
const int DAMAGE_SHOT_HF_LASER = 70;

const float DAMAGE_SPECIAL_SHOT_HEATSEEKER = 20;
const float DAMAGE_SPECIAL_SHOT_NUKE = 250;

const int SPREAD_ANGLE_SHOT_NORMAL = 6;

const int LIFETIME_ENEMY_SHOT_NORMAL = 6000;
const int LIFETIME_ENEMY_SHOT_TANK_ROCKET = 10000;

const int VEL_ENEMY_SHOT_NORMAL = 130;
const int VEL_ENEMY_SHOT_TANK_ROCKET = 70;

const float DAMAGE_ENEMY_SHOT_NORMAL = 8;
const float DAMAGE_ENEMY_SHOT_TANK_ROCKET = 25;

/***************************** SMOKE PUFFS ***************************/

enum SmokePuffTypes { SMOKE_PUFF_SMALL=0, SMOKE_PUFF_MEDIUM };
const int NR_SMOKE_PUFF_TYPES = 2;
const std::string FN_SMOKE_PUFF[ NR_SMOKE_PUFF_TYPES ] =
{ PATH"images/smokePuffSmall.bmp", 
  PATH"images/smokePuffMedium.bmp" };
const int LIFETIME_SMOKE_PUFF[ NR_SMOKE_PUFF_TYPES ] = { 500, 1000 };
const int SMOKE_PUFF_DELAY_TO_NEXT_PUFF[ NR_SMOKE_PUFF_TYPES ] = { 100, 100 };
const float SMOKE_PUFF_VELOCITY_FACTOR = 0.3;
const bool SMOKE_PUFF_ALPHA_BLENDING = true;

/********************************** ENEMIES ********************************/


enum EnemyTypes {
      FIGHTER=0,
      BOMBER,
      TANK, 
		  BOSS_1_MAIN_GUN,
      BOSS_1_ROCKET_LAUNCHER,
		  BOSS_1_SHOT_BATTERY_RIGHT,
      BOSS_1_SHOT_BATTERY_LEFT,
      BOSS_2};
const int NR_ENEMY_TYPES = 8;
const int NR_ENEMY_TYPES_NORMAL = 3;
const int NR_ENEMY_TYPES_BOSS_1 = 4;

const float BOSS_1_END_Y = 110;

enum WreckTypes {
      WRECK_FIGHTER=0,
      WRECK_BOMBER,
      WRECK_TANK, 
		  WRECK_BOSS_1_MAIN_GUN,
		  WRECK_BOSS_1_ROCKET_LAUNCHER,
		  WRECK_BOSS_1_BATTERY_RIGHT,
		  WRECK_BOSS_1_BATTERY_LEFT,
		  WRECK_BOSS_1_BACKGROUND, 
      WRECK_BOSS_1_DESTROYED,
      WRECK_BOSS_2_DESTROYED }; 
const int NR_WRECK_TYPES = 10;
const WreckTypes WRECK_FOR_ENEMYTYPE[] = {
             WRECK_FIGHTER,
             WRECK_BOMBER, 
					   WRECK_TANK, 
					   WRECK_BOSS_1_MAIN_GUN,
					   WRECK_BOSS_1_ROCKET_LAUNCHER,
					   WRECK_BOSS_1_BATTERY_RIGHT,
					   WRECK_BOSS_1_BATTERY_LEFT,
             WRECK_BOSS_2_DESTROYED };

extern int GENERATE_ENEMY_DELAY;
extern int GENERATE_ENEMY_RAND_DELAY;

extern int ENEMY_HITPOINTS[];
//const float ENEMY_HITPOINTS[] = { 80, 120, 150, 10, 10, 10, 10 };
const bool ENEMY_FLYING[] = {true, true, false, false, false, false, false, true};
// determines the difference between shadow and enemy plane
const int ENEMY_FLYING_HEIGHT[] = {10, 15, 0, 0, 0, 0, 0, 10};
const int ENEMY_POINTS_FOR_DEST[] = {10,20,20,0,0,0,0,0};

extern int ENEMY_COLLISION_DAMAGE[];

// the enemys have different probabilities to appear in the different levels.
// bigger number -> greater chance
extern int ENEMY_APPEAR_CHANCES[];

// on average one of that many enemys carries an item 
extern int ENEMY_DIES_ITEM_APPEAR_CHANCE[];

// minimal waittime (ms) between two shots
extern int ENEMY_COOLDOWN_PRIMARY[];
extern int ENEMY_COOLDOWN_SECONDARY[];
// random additional waittime between two shots
extern int ENEMY_RAND_WAIT_PRIMARY[];
extern int ENEMY_RAND_WAIT_SECONDARY[];



/******************************** FORMATION ***************************************/


enum FormationTypes { FORMATION_V=0, FORMATION_REVERSE_V,
		      FORMATION_BLOCK,
		      FORMATION_LINE };

const int NR_FORMATION_TYPES = 4;

const int FORMATION_MAX_NR_ENEMYS_HARD_LIMIT[] = {7,7,7,6};
extern int FORMATION_MAX_NR_ENEMYS[];

enum FormationEnemySets { FORMATION_ENEMY_SET_DEFAULT=0,
			  FORMATION_ENEMY_SET_FIGHTER,
			  FORMATION_ENEMY_SET_BOMBER,
			  FORMATION_ENEMY_SET_FIGHTER_BOMBER };
const int NR_FORMATION_ENEMY_SETS = 4;

const int FORMATION_CHANGE_ON_KILL = 1;
const int FORMATION_CHANGE_SPONTANEOUS = 2;
const int FORMATION_CHANGE_SELDOM = 4;
const int FORMATION_CHANGE_OFTEN = 8;

const int FORMATION_CHANGE_OFTEN_DELAY = 3000;
const int FORMATION_CHANGE_OFTEN_RAND_DELAY = 8000;
const int FORMATION_CHANGE_SELDOM_DELAY = 4000;
const int FORMATION_CHANGE_SELDOM_RAND_DELAY = 15000;


enum FormationShotPatterns { FORMATION_SP_NONE=0,
			     FORMATION_SP_RAND_FAST,
			     FORMATION_SP_RAND_MEDIUM,
			     FORMATION_SP_RAND_SLOW,

			     FORMATION_SP_VOLLEY_FAST,
			     FORMATION_SP_VOLLEY_MEDIUM,
			     FORMATION_SP_VOLLEY_SLOW,

			     FORMATION_SP_LEFT_RIGHT_FAST,
			     FORMATION_SP_LEFT_RIGHT_MEDIUM,
			     FORMATION_SP_RIGHT_LEFT_FAST,
			     FORMATION_SP_RIGHT_LEFT_MEDIUM };			     

const int NR_FORMATION_SP = 11;

extern int FORMATION_SP_CHANCES[];
extern int FORMATION_SP_PRIMARY_DELAY[];
extern int FORMATION_SP_PRIMARY_RAND_DELAY[];

extern int GENERATE_FORMATION_DELAY;
extern int GENERATE_FORMATION_RAND_DELAY;



/************************* RACER *********************************/


// max speed of the racer in pixels per second
const float LIGHT_FIGHTER_VEL_MAX = 90;
const float HEAVY_FIGHTER_VEL_MAX = 60;

// shield recharge points per 100 seconds
extern int LIGHT_FIGHTER_SHIELD_RECHARGE;
extern int HEAVY_FIGHTER_SHIELD_RECHARGE;

// Cooldown rates (in ms) of the weapons
const int RACER_COOLDOWN_SHOT_NORMAL = 100;
const int RACER_COOLDOWN_SHOT_NORMAL_HEAVY = 100;
const int RACER_COOLDOWN_SHOT_DOUBLE = 130;
const int RACER_COOLDOWN_SHOT_DOUBLE_HEAVY = 130;
const int RACER_COOLDOWN_SHOT_TRIPLE = 130;

const int RACER_COOLDOWN_SHOT_HF_NORMAL = 300;
const int RACER_COOLDOWN_SHOT_HF_DOUBLE = 300;
const int RACER_COOLDOWN_SHOT_HF_TRIPLE = 300;
const int RACER_COOLDOWN_SHOT_HF_QUATTRO = 350;
const int RACER_COOLDOWN_SHOT_HF_QUINTO = 400;

const int RACER_COOLDOWN_DUMBFIRE = 600;
const int RACER_COOLDOWN_DUMBFIRE_DOUBLE = 300;
const int RACER_COOLDOWN_KICK_ASS_ROCKET = 1500;
const int RACER_COOLDOWN_HELLFIRE = 600;
const int RACER_COOLDOWN_MACHINE_GUN = 150;
const int RACER_COOLDOWN_ENERGY_BEAM = 500;

const int RACER_COOLDOWN_HF_DUMBFIRE = 600;
const int RACER_COOLDOWN_HF_DUMBFIRE_DOUBLE = 300;
const int RACER_COOLDOWN_HF_KICK_ASS_ROCKET = 1300;
const int RACER_COOLDOWN_HF_LASER = 700;

const int RACER_COOLDOWN_SPECIAL_HEATSEEKER = 400;
const int RACER_COOLDOWN_SPECIAL_NUKE = 3000;

extern int RACER_DEFLECTOR_ACTIVATION_DIST;
extern int RACER_DEFLECTOR_POWER;
extern int RACER_SONIC_ACTIVATION_DIST;
extern int RACER_SONIC_POWER;

// how long (in ms) does the shield glow, when the racer is hit 
const int RACER_SHIELD_DAMAGE_LIFETIME = 200;

// shields
extern int LIGHT_FIGHTER_MAX_SHIELD;
extern int HEAVY_FIGHTER_MAX_SHIELD;
// hitpoints
extern int LIGHT_FIGHTER_MAX_DAMAGE;
extern int HEAVY_FIGHTER_MAX_DAMAGE;

const std::string FN_SOUND_SHOT_PRIMARY = PATH"sound/shotPrimary.wav";
const std::string FN_SOUND_SHOT_SECONDARY = PATH"sound/shotSecondary.wav";
const std::string FN_SOUND_EXPLOSION_NORMAL = PATH"sound/explosion.wav";
const std::string FN_SOUND_EXPLOSION_BOSS = PATH"sound/explosionBoss.wav";
const std::string FN_SOUND_BOSS_ALARM = PATH"sound/alarm.wav";
const std::string FN_SOUND_ARCADE_CONFIRM = PATH"sound/alarm.wav";
const std::string FN_SOUND_ARCADE_CHOOSE = PATH"sound/choose.wav";
const std::string FN_SOUND_INTRO_CONFIRM = PATH"sound/confirm.wav";
const std::string FN_SOUND_INTRO_CHOOSE = PATH"sound/choose.wav";

const std::string FN_ENEMY_FIGHTER = PATH"images/fighter.bmp";
const std::string FN_ENEMY_FIGHTER_SHADOW = PATH"images/fighterShadow.bmp";
const std::string FN_ENEMY_BOMBER = PATH"images/bomber.bmp";
const std::string FN_ENEMY_BOMBER_SHADOW = PATH"images/bomberShadow.bmp";
const std::string FN_ENEMY_TANK = PATH"images/tank.bmp";
const std::string FN_ENEMY_BOSS_1_MAIN_GUN = PATH"images/boss1MainGun.bmp";
const std::string FN_ENEMY_BOSS_1_ROCKET_LAUNCHER = PATH"images/boss1RocketLauncher.bmp";
const std::string FN_ENEMY_BOSS_1_SHOT_BATTERY_LEFT = PATH"images/boss1ShotBatteryLeft.bmp";
const std::string FN_ENEMY_BOSS_1_SHOT_BATTERY_RIGHT = PATH"images/boss1ShotBatteryRight.bmp";
const std::string FN_ENEMY_BOSS_2 = PATH"images/boss2.bmp";
const std::string FN_ENEMY_BOSS_2_SHADOW = PATH"images/boss2Shadow.bmp";

const std::string FN_WRECK_FIGHTER = PATH"images/wreckFighter.bmp";
const std::string FN_WRECK_BOMBER = PATH"images/wreckBomber.bmp";
const std::string FN_WRECK_TANK = PATH"images/wreckTank.bmp";
const std::string FN_WRECK_BOSS_1 = PATH"images/wreckBoss1.bmp";
const std::string FN_WRECK_BOSS_1_BACKGROUND = PATH"images/wreckBossBackground.bmp";
const std::string FN_WRECK_BOSS_1_DESTROYED = PATH"images/boss.bmp";
const std::string FN_WRECK_BOSS_2_DESTROYED = PATH"images/wreckBoss2.bmp";

const std::string FN_SHOT_NORMAL = PATH"images/normalShot.bmp";
const std::string FN_SHOT_NORMAL_HEAVY = PATH"images/heavyShot.bmp";
const std::string FN_SHOT_DOUBLE = PATH"images/normalShot.bmp";
const std::string FN_SHOT_DOUBLE_HEAVY = PATH"images/heavyShot.bmp";
const std::string FN_SHOT_TRIPLE = PATH"images/heavyShot.bmp";

const std::string FN_SHOT_HF_NORMAL = PATH"images/normalShotHF.bmp";
const std::string FN_SHOT_HF_DOUBLE = PATH"images/normalShotHF.bmp";
const std::string FN_SHOT_HF_TRIPLE = PATH"images/normalShotHF.bmp";
const std::string FN_SHOT_HF_QUATTRO = PATH"images/normalShotHF.bmp";
const std::string FN_SHOT_HF_QUINTO = PATH"images/normalShotHF.bmp";

const std::string FN_SHOT_DUMBFIRE = PATH"images/dumbfire.bmp";
const std::string FN_SHOT_DUMBFIRE_DOUBLE = PATH"images/dumbfire.bmp";
const std::string FN_SHOT_KICK_ASS_ROCKET = PATH"images/kickAssRocket.bmp";
const std::string FN_SHOT_KICK_ASS_ROCKET_SHADOW = PATH"images/kickAssRocketShadow.bmp";
const std::string FN_SHOT_HELLFIRE = PATH"images/hellfire.bmp";
const std::string FN_SHOT_HELLFIRE_SHADOW = PATH"images/hellfireShadow.bmp";
const std::string FN_SHOT_MACHINE_GUN = PATH"images/machineGun.bmp";
const std::string FN_SHOT_ENERGY_BEAM = PATH"images/energyBeam.bmp";

const std::string FN_SHOT_HF_DUMBFIRE = PATH"images/dumbfire.bmp";
const std::string FN_SHOT_HF_DUMBFIRE_DOUBLE = PATH"images/dumbfire.bmp";
const std::string FN_SHOT_HF_KICK_ASS_ROCKET = PATH"images/kickAssRocket.bmp";
const std::string FN_SHOT_HF_KICK_ASS_ROCKET_SHADOW = PATH"images/kickAssRocketShadow.bmp";
const std::string FN_SHOT_HF_LASER = PATH"images/laser.bmp";

const std::string FN_ENEMY_SHOT_NORMAL = PATH"images/enemyShotNormal.bmp";
const std::string FN_ENEMY_SHOT_TANK_ROCKET = PATH"images/tankRocket.bmp";
const std::string FN_ENEMY_SHOT_TANK_ROCKET_SHADOW = PATH"images/tankRocketShadow.bmp";

const std::string FN_SPECIAL_SHOT_HEATSEEKER = PATH"images/heatseeker.bmp";
const std::string FN_SPECIAL_SHOT_NUKE = PATH"images/shotNuke.bmp";
const std::string FN_SPECIAL_SHOT_NUKE_SHADOW = PATH"images/shotNukeShadow.bmp";
const std::string FN_NUKE_EFFECT = PATH"images/nukeEffect.bmp";
const std::string FN_SONIC_EFFECT = PATH"images/sonic.bmp";

const std::string FN_ITEM_PRIMARY_UPGRADE = PATH"images/itemPrimaryUpgrade.bmp";
const std::string FN_ITEM_DUMBFIRE_DOUBLE = PATH"images/itemDumbfireDouble.bmp";
const std::string FN_ITEM_KICK_ASS_ROCKET = PATH"images/itemKickAssRocket.bmp";
const std::string FN_ITEM_HELLFIRE = PATH"images/itemHellfire.bmp";
const std::string FN_ITEM_MACHINE_GUN = PATH"images/itemMachineGun.bmp";
const std::string FN_ITEM_HEALTH = PATH"images/itemHealth.bmp";
const std::string FN_ITEM_HEATSEEKER = PATH"images/itemHeatseeker.bmp";
const std::string FN_ITEM_NUKE = PATH"images/itemNuke.bmp";
const std::string FN_ITEM_DEFLECTOR = PATH"images/itemDeflector.bmp";
const std::string FN_ITEM_ENERGY_BEAM = PATH"images/itemEnergyBeam.bmp";
const std::string FN_ITEM_LASER = PATH"images/itemLaser.bmp";

const std::string FN_ALIENBLASTER_INTRO = PATH"images/alienblasterintro.bmp";
const std::string FN_ALIENBLASTER_ICON = PATH"images/alienblastericon.bmp";
const std::string FN_BACKGROUND = PATH"images/background.bmp";
const std::string FN_PAUSED = PATH"images/paused.bmp";
const std::string FN_YOU_LOSE = PATH"images/youLose.bmp";
const std::string FN_YOU_WIN = PATH"images/youWin.bmp";
const std::string FN_GAME_OVER = PATH"images/gameOver.bmp";
const std::string FN_ARCADE_LOGO = PATH"images/arcadeLogo.bmp";

// numbers of images (animation-frames) per racer
const int RACER_IMAGE_CNT = 9;

const std::string FN_LIGHT_FIGHTER_1 = PATH"images/lightFighter1.bmp";
const std::string FN_LIGHT_FIGHTER_2 = PATH"images/lightFighter2.bmp";
const std::string FN_LIGHT_FIGHTER_SHADOW = PATH"images/lightFighterShadow.bmp";
const std::string FN_LIGHT_FIGHTER_SHIELD_DAMAGED = PATH"images/lightFighterShieldDamaged.bmp";
const std::string FN_LIGHT_FIGHTER_1_ICON = PATH"images/lightFighter1Icon.bmp";
const std::string FN_LIGHT_FIGHTER_2_ICON = PATH"images/lightFighter2Icon.bmp";
const std::string FN_LIGHT_FIGHTER_1_SMALL = PATH"images/lightFighter1Small.bmp";
const std::string FN_LIGHT_FIGHTER_2_SMALL = PATH"images/lightFighter2Small.bmp";

const std::string FN_HEAVY_FIGHTER_1 = PATH"images/heavyFighter1.bmp";
const std::string FN_HEAVY_FIGHTER_2 = PATH"images/heavyFighter2.bmp";
const std::string FN_HEAVY_FIGHTER_SHADOW = PATH"images/heavyFighterShadow.bmp";
const std::string FN_HEAVY_FIGHTER_SHIELD_DAMAGED = PATH"images/heavyFighterShieldDamaged.bmp";
const std::string FN_HEAVY_FIGHTER_DEFLECTOR = PATH"images/heavyFighterDeflector.bmp";
const std::string FN_HEAVY_FIGHTER_1_ICON = PATH"images/heavyFighter1Icon.bmp";
const std::string FN_HEAVY_FIGHTER_2_ICON = PATH"images/heavyFighter2Icon.bmp";
const std::string FN_HEAVY_FIGHTER_1_SMALL = PATH"images/heavyFighter1Small.bmp";
const std::string FN_HEAVY_FIGHTER_2_SMALL = PATH"images/heavyFighter2Small.bmp";

const std::string FN_ICONS_SPECIALS = PATH"images/iconsSpecials.bmp";
const std::string FN_ICONS_SECONDARY_WEAPONS = PATH"images/iconsSecondaryWeapons.bmp";

const std::string FN_HITPOINTS_STAT = PATH"images/hpStat.bmp";

const std::string FN_INTRO_SHOW_CHOICE      = PATH"images/menuIcon.bmp";

const std::string FN_FONT_PATH = PATH"images/";
const std::string FN_FONT_SUFFIX_SURFACE = ".bmp";
const std::string FN_FONT_INTRO = PATH"images/font-20white.bmp";
const std::string FN_FONT_INTRO_HIGHLIGHTED = PATH"images/font-20lightblue.bmp";
const std::string FN_FONT_NUMBERS_TIME = PATH"images/font-20red.bmp";
const std::string FN_FONT_NUMBERS_LEFT = PATH"images/font-20red.bmp";
const std::string FN_FONT_NUMBERS_RIGHT = PATH"images/font-20blue.bmp";
const std::string FN_FONT_SETTINGS = PATH"images/font-20white.bmp";
const std::string FN_FONT_SETTINGS_HIGHLIGHTED = PATH"images/font-20lightblue.bmp";
const std::string FN_FONT_SETTINGS_SMALL = PATH"images/font-14white.bmp";
const std::string FN_FONT_SETTINGS_SMALL_BLUE = PATH"images/font-14lightblue.bmp";
const std::string FN_FONT_SETTINGS_SMALL_HIGHLIGHTED = PATH"images/font-14red.bmp";

const std::string FN_SETTINGS_BLUE = PATH"images/bluePlain.bmp";
const std::string FN_SETTINGS_WHITE = PATH"images/whitePlain.bmp";

const std::string FN_EXPLOSION_NORMAL = PATH"images/explosion.bmp";
const std::string FN_EXPLOSION_ENEMY = PATH"images/explosionEnemy.bmp";

const std::string FN_LOADING = PATH"images/loading.bmp";

const std::string FN_SETTINGS = PATH"cfg/alienBlaster.cfg";

const std::string FN_DIFFICULTY_CONFIG = PATH"cfg/alienBlasterDifficulty";
const std::string FN_DIFFICULTY_CONFIG_SUFFIX = ".cfg";

const std::string FN_HIGHSCORE = PATH"cfg/highscore.dat";

enum MusicTracks { MUSIC_INTRO=0, MUSIC_PLAYON, MUSIC_BOSS1, MUSIC_NONE };
const int NR_MUSIC_TRACKS = 3;
const std::string FN_MUSIC[] = { PATH"sound/intro.wav",
				 PATH"sound/playon.wav",
				 PATH"sound/intro.wav" };

const std::string FN_LEVEL_ONE_PLAYER = PATH"cfg/level1.cfg";
const std::string FN_LEVEL_TWO_PLAYER = PATH"cfg/level2.cfg";
const std::string FN_LEVEL_ARCADEMODE = PATH"cfg/levelArcade.cfg";

const std::string FN_SCREENSHOT0 =  PATH"intro/HellShot0.bmp";
const std::string FN_SCREENSHOT1 =  PATH"intro/HellShot1.bmp";
const std::string FN_SCREENSHOT2 =  PATH"intro/HellShot2.bmp";
const std::string FN_SCREENSHOT3 =  PATH"intro/HellShot3.bmp";
const std::string FN_SCREENSHOT4 =  PATH"intro/HellShot5.bmp";
const std::string FN_SCREENSHOT5 =  PATH"intro/HellShot4.bmp";
const std::string FN_SCREENSHOT6 =  PATH"intro/HellShot6.bmp";
const std::string FN_SCREENSHOT7 =  PATH"intro/HellShot7.bmp";
const std::string FN_SCREENSHOT8 =  PATH"intro/HellShot8.bmp";
const std::string FN_SCREENSHOT9 =  PATH"intro/HellShot9.bmp";

const std::string LVL_BACKG_TILE_CNT = "BACKG_TILES";
const std::string LVL_BACKG_TILE     = "BACKG_TILE";
const std::string LVL_BACKG_LENGTH   = "BACKG_LENGTH";

const std::string LVL_ENEMY_FIGHTER  = "ENEMY_FIGHTER";
const std::string LVL_ENEMY_BOMBER   = "ENEMY_BOMBER";
const std::string LVL_ENEMY_TANK     = "ENEMY_TANK";
const std::string LVL_ENEMY_BOSS_BACKGROUND = "ENEMY_BOSS_BACKGROUND";
const std::string LVL_ENEMY_BOSS_DESTROYED  = "ENEMY_BOSS_DESTROYED";

const std::string LVL_WRECK_FIGHTER  = "WRECK_FIGHTER";
const std::string LVL_WRECK_BOMBER   = "WRECK_BOMBER";
const std::string LVL_WRECK_TANK     = "WRECK_TANK";
const std::string LVL_WRECK_BOSS_BACKGROUND = "WRECK_BOSS_BACKGROUND";
const std::string LVL_WRECK_BOSS_DESTROYED  = "WRECK_BOSS_DESTROYED";

const std::string LVL_ENEMY_BOSS_1_SHOT_BATTERY_RIGHT = "ENEMY_BOSS_1_SHOT_BATTERY_RIGHT";
const std::string LVL_ENEMY_BOSS_1_SHOT_BATTERY_LEFT  = "ENEMY_BOSS_1_SHOT_BATTERY_LEFT";
const std::string LVL_ENEMY_BOSS_1_ROCKET_LAUNCHER    = "ENEMY_BOSS_1_ROCKET_LAUNCHER";
const std::string LVL_ENEMY_BOSS_1_MAIN_GUN           = "ENEMY_BOSS_1_MAIN_GUN";

const std::string LVL_ENEMY_FIGHTER_SHADOW            = "ENEMY_FIGHTER_SHADOW";
const std::string LVL_ENEMY_BOMBER_SHADOW             = "ENEMY_BOMBER_SHADOW";

#endif
