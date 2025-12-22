/* Generated Mon Jan  2 23:20:30 2006 by buildworlds.pl from WorldsData.txt */

#include <stdlib.h>
#include <string.h>
#include "game.h"



void loadWorlds()
{
int nextPlatformRef;
int nextPowerup;
int i;

numWorlds=0;
for(i=0; i<MAX_NUM_WORLDS; i++) { worlds[i]=NULL; }

/*
    NEW WORLD: 'jungleJ'
*/
currentWorld = (world*) calloc(1,sizeof(world));

currentWorld->order = numWorlds;

strcpy(currentWorld->name, "jungleJ");

/* Set all the backgrounds, platform refs, powerups to NULL/0 */
for(i=0; i<8; i++ ) currentWorld->backgrounds[i]=NULL;
for(i=0; i<16; i++) currentWorld->platformRefs[i]=NULL;
for(i=0; i<8; i++) currentWorld->powerups[i]=NO_POWERUP;
for(i=0; i<8; i++) currentWorld->powerupFrequencies[i]=0;

/* Zero some variables */
currentWorld->frequencyTotal=0;
currentWorld->highScore = 0;
nextPlatformRef=0;
currentWorld->ceilingAnimFrame=0;
currentWorld->ceilingAnimLastFrameTime=0;
nextPowerup=0;

/* Frame graphic */
currentWorld->frameGraphic = loadGraphic("junglej/frame.bmp");

/* Ceiling animation */
currentWorld->ceilingAnimFramePeriod = 50;
loadAnimation("ceilingSpikes.bmp", 2, &currentWorld->ceilingAnim);

/* Ambient sound effect loop */
currentWorld->ambientSnd = loadSound("AmbienceJungle.ogg");

/* BACKGROUND LAYER 2: */
currentWorld->backgrounds[2] = loadGraphic("junglej/background.bmp");
currentWorld->scrollSpeeds[2] = 2;

/* BACKGROUND LAYER 3: */
currentWorld->backgrounds[3] = loadGraphic("junglej/backTrees.bmp");
currentWorld->scrollSpeeds[3] = 3;

/* BACKGROUND LAYER 4: */
currentWorld->backgrounds[4] = loadGraphic("junglej/vines.bmp");
currentWorld->scrollSpeeds[4] = 4;

/* BACKGROUND LAYER 5: */
currentWorld->backgrounds[5] = loadGraphic("junglej/sideTrunks.bmp");
currentWorld->scrollSpeeds[5] = 5;

/* PLATFORM TYPE 1: */
/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 1;

/* Load animation */
loadAnimation("branch.bmp", 1, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 500;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 2;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = NULL;

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 7;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* PLATFORM TYPE 20: */
/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 20;

/* Load animation */
loadAnimation("springRope.bmp", 4, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 50;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 2;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = NULL;

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 2;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* PLATFORM TYPE 100: */
/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 100;

/* Load animation */
loadAnimation("evilBranch.bmp", 1, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 40;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 4;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = NULL;

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 3;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* POWERUP */
/* Type */
currentWorld->powerups[nextPowerup] = (powerupType) 10;

/* Frequency */
currentWorld->powerupFrequencies[nextPowerup] = 0.04;

nextPowerup++;

/* Score required to complete level */
currentWorld->completeScore = 100;

/* Scores required to get 1-5 stars */
currentWorld->starScore[0] = 120;
currentWorld->starScore[1] = 160;
currentWorld->starScore[2] = 200;
currentWorld->starScore[3] = 250;
currentWorld->starScore[4] = 300;

/* Type code of start platform */
currentWorld->startPlatform = (platformType) 1;

/* Scrolling speed */
currentWorld->scrollSpeed = 20;

/* Gravity */
currentWorld->gravity = 0.26;

/* Store this newly created world in the worlds array */
worlds[numWorlds] = currentWorld;

/* Increase variable holding running total number of worlds in game */
numWorlds++;


/*
    NEW WORLD: 'crumble'
*/
currentWorld = (world*) calloc(1,sizeof(world));

currentWorld->order = numWorlds;

strcpy(currentWorld->name, "crumble");

/* Set all the backgrounds, platform refs, powerups to NULL/0 */
for(i=0; i<8; i++ ) currentWorld->backgrounds[i]=NULL;
for(i=0; i<16; i++) currentWorld->platformRefs[i]=NULL;
for(i=0; i<8; i++) currentWorld->powerups[i]=NO_POWERUP;
for(i=0; i<8; i++) currentWorld->powerupFrequencies[i]=0;

/* Zero some variables */
currentWorld->frequencyTotal=0;
currentWorld->highScore = 0;
nextPlatformRef=0;
currentWorld->ceilingAnimFrame=0;
currentWorld->ceilingAnimLastFrameTime=0;
nextPowerup=0;

/* Frame graphic */
currentWorld->frameGraphic = loadGraphic("crumble/frame.bmp");

/* Ceiling animation */
currentWorld->ceilingAnimFramePeriod = 50;
loadAnimation("ceilingSpikes.bmp", 2, &currentWorld->ceilingAnim);

/* Ambient sound effect loop */
currentWorld->ambientSnd = loadSound("AmbienceWind.ogg");

/* BACKGROUND LAYER 0: */
currentWorld->backgrounds[0] = loadGraphic("crumble/largeBackground.bmp");
currentWorld->scrollSpeeds[0] = 0;

/* BACKGROUND LAYER 4: */
currentWorld->backgrounds[4] = loadGraphic("crumble/medRocks.bmp");
currentWorld->scrollSpeeds[4] = 4;

/* BACKGROUND LAYER 5: */
currentWorld->backgrounds[5] = loadGraphic("crumble/nearRocks.bmp");
currentWorld->scrollSpeeds[5] = 5;

/* PLATFORM TYPE 1: */
/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 1;

/* Load animation */
loadAnimation("moltenm/normal.bmp", 2, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 100;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 0;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = NULL;

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 4;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* PLATFORM TYPE 30: */

/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 30;

/* Load animation */
loadAnimation("moltenm/rockFallApart.bmp", 5, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 100;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 0;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = loadSound("BreakingRock.ogg");

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 4;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* PLATFORM TYPE 100: */

/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 100;

/* Load animation */
loadAnimation("spikeRock.bmp", 1, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 100;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 7;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 70;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = loadSound("LandingOnSpikes.ogg");

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 2;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* POWERUP */
/* Type */
currentWorld->powerups[nextPowerup] = (powerupType) 30;

/* Frequency */
currentWorld->powerupFrequencies[nextPowerup] = 0.03;

nextPowerup++;

/* Score required to complete level */
currentWorld->completeScore = 150;

/* Scores required to get 1-5 stars */
currentWorld->starScore[0] = 200;
currentWorld->starScore[1] = 300;
currentWorld->starScore[2] = 400;
currentWorld->starScore[3] = 500;
currentWorld->starScore[4] = 600;

/* Type code of start platform */
currentWorld->startPlatform = (platformType) 1;

/* Scrolling speed */
currentWorld->scrollSpeed = 18;

/* Gravity */
currentWorld->gravity = 0.40;

/* Store this newly created world in the worlds array */
worlds[numWorlds] = currentWorld;

/* Increase variable holding running total number of worlds in game */
numWorlds++;


/*
    NEW WORLD: 'frenzie'
*/
currentWorld = (world*) calloc(1,sizeof(world));

currentWorld->order = numWorlds;

strcpy(currentWorld->name, "frenzie");

/* Set all the backgrounds, platform refs, powerups to NULL/0 */
for(i=0; i<8; i++ ) currentWorld->backgrounds[i]=NULL;
for(i=0; i<16; i++) currentWorld->platformRefs[i]=NULL;
for(i=0; i<8; i++) currentWorld->powerups[i]=NO_POWERUP;
for(i=0; i<8; i++) currentWorld->powerupFrequencies[i]=0;

/* Zero some variables */
currentWorld->frequencyTotal=0;
currentWorld->highScore = 0;
nextPlatformRef=0;
currentWorld->ceilingAnimFrame=0;
currentWorld->ceilingAnimLastFrameTime=0;
nextPowerup=0;

/* Frame graphic */
currentWorld->frameGraphic = loadGraphic("frenzie/frame.bmp");

/* Ceiling animation */
currentWorld->ceilingAnimFramePeriod = 50;
loadAnimation("ceilingSpikes.bmp", 2, &currentWorld->ceilingAnim);

/* Ambient sound effect loop */
currentWorld->ambientSnd = loadSound("AmbienceWaterFall.ogg");

/* BACKGROUND LAYER 0: */
currentWorld->backgrounds[0] = loadGraphic("frenzie/background.bmp");
currentWorld->scrollSpeeds[0] = 0;

/* BACKGROUND LAYER 4: */
currentWorld->backgrounds[4] = loadGraphic("frenzie/cliff.bmp");
currentWorld->scrollSpeeds[4] = 5;

/* BACKGROUND LAYER 5: */
currentWorld->backgrounds[5] = loadGraphic("frenzie/waterBack.bmp");
currentWorld->scrollSpeeds[5] = 8;

/* BACKGROUND LAYER 6: */
currentWorld->backgrounds[6] = loadGraphic("frenzie/waterFront.bmp");
currentWorld->scrollSpeeds[6] = 9;

/* PLATFORM TYPE 1: */
/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 1;

/* Load animation */
loadAnimation("branch.bmp", 1, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 500;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 2;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = NULL;

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 6;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* PLATFORM TYPE 20: */
/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 20;

/* Load animation */
loadAnimation("springRope.bmp", 4, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 50;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 2;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = NULL;

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 1;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* PLATFORM TYPE 30: */

/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 30;

/* Load animation */
loadAnimation("log.bmp", 1, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 500;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 2;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = loadSound("BreakingTree.ogg");

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 4;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* PLATFORM TYPE 111: */

/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 111;

/* Load animation */
loadAnimation("piranha.bmp", 4, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 80;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 0;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 40;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = loadSound("Piranha.ogg");

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 4;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* Score required to complete level */
currentWorld->completeScore = 120;

/* Scores required to get 1-5 stars */
currentWorld->starScore[0] = 150;
currentWorld->starScore[1] = 170;
currentWorld->starScore[2] = 200;
currentWorld->starScore[3] = 250;
currentWorld->starScore[4] = 300;

/* Type code of start platform */
currentWorld->startPlatform = (platformType) 1;

/* Scrolling speed */
currentWorld->scrollSpeed = 22;

/* Gravity */
currentWorld->gravity = 0.24;

/* Store this newly created world in the worlds array */
worlds[numWorlds] = currentWorld;

/* Increase variable holding running total number of worlds in game */
numWorlds++;


/*
    NEW WORLD: 'moltenM'
*/
currentWorld = (world*) calloc(1,sizeof(world));

currentWorld->order = numWorlds;

strcpy(currentWorld->name, "moltenM");

/* Set all the backgrounds, platform refs, powerups to NULL/0 */
for(i=0; i<8; i++ ) currentWorld->backgrounds[i]=NULL;
for(i=0; i<16; i++) currentWorld->platformRefs[i]=NULL;
for(i=0; i<8; i++) currentWorld->powerups[i]=NO_POWERUP;
for(i=0; i<8; i++) currentWorld->powerupFrequencies[i]=0;

/* Zero some variables */
currentWorld->frequencyTotal=0;
currentWorld->highScore = 0;
nextPlatformRef=0;
currentWorld->ceilingAnimFrame=0;
currentWorld->ceilingAnimLastFrameTime=0;
nextPowerup=0;

/* Frame graphic */
currentWorld->frameGraphic = loadGraphic("moltenm/frame.bmp");

/* Ceiling animation */
currentWorld->ceilingAnimFramePeriod = 50;
loadAnimation("ceilingSpikes.bmp", 2, &currentWorld->ceilingAnim);

/* Ambient sound effect loop */
currentWorld->ambientSnd = loadSound("AmbienceVolcano.ogg");

/* BACKGROUND LAYER 0: */
currentWorld->backgrounds[0] = loadGraphic("moltenm/background.bmp");
currentWorld->scrollSpeeds[0] = 0;

/* BACKGROUND LAYER 2: */
currentWorld->backgrounds[2] = loadGraphic("moltenm/distant.bmp");
currentWorld->scrollSpeeds[2] = 2;

/* BACKGROUND LAYER 4: */
currentWorld->backgrounds[4] = loadGraphic("moltenm/middleRocks.bmp");
currentWorld->scrollSpeeds[4] = 4;

/* BACKGROUND LAYER 5: */
currentWorld->backgrounds[5] = loadGraphic("moltenm/sides.bmp");
currentWorld->scrollSpeeds[5] = 5;

/* PLATFORM TYPE 1: */
/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 1;

/* Load animation */
loadAnimation("moltenm/normal.bmp", 2, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 100;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 0;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = NULL;

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 4;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* PLATFORM TYPE 30: */

/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 30;

/* Load animation */
loadAnimation("moltenm/rockFallApart.bmp", 5, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 100;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 0;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = loadSound("BreakingRock.ogg");

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 2;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* PLATFORM TYPE 110: */

/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 110;

/* Load animation */
loadAnimation("moltenm/hotRocks.bmp", 1, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 40;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 0;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = loadSound("BurningMonkeyHands.ogg");

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 8;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* PLATFORM TYPE 111: */

/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 111;

/* Load animation */
loadAnimation("moltenm/veryHotPlatform.bmp", 2, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 80;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 0;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = loadSound("BurningMonkeyHandsEvenMore.ogg");

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 3;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* POWERUP */
/* Type */
currentWorld->powerups[nextPowerup] = (powerupType) 50;

/* Frequency */
currentWorld->powerupFrequencies[nextPowerup] = 0.1;

nextPowerup++;

/* Score required to complete level */
currentWorld->completeScore = 160;

/* Scores required to get 1-5 stars */
currentWorld->starScore[0] = 200;
currentWorld->starScore[1] = 220;
currentWorld->starScore[2] = 250;
currentWorld->starScore[3] = 300;
currentWorld->starScore[4] = 350;

/* Type code of start platform */
currentWorld->startPlatform = (platformType) 1;

/* Scrolling speed */
currentWorld->scrollSpeed = 26;

/* Gravity */
currentWorld->gravity = 0.38;

/* Store this newly created world in the worlds array */
worlds[numWorlds] = currentWorld;

/* Increase variable holding running total number of worlds in game */
numWorlds++;


/*
    NEW WORLD: 'skyScra'
*/
currentWorld = (world*) calloc(1,sizeof(world));

currentWorld->order = numWorlds;

strcpy(currentWorld->name, "skyScra");

/* Set all the backgrounds, platform refs, powerups to NULL/0 */
for(i=0; i<8; i++ ) currentWorld->backgrounds[i]=NULL;
for(i=0; i<16; i++) currentWorld->platformRefs[i]=NULL;
for(i=0; i<8; i++) currentWorld->powerups[i]=NO_POWERUP;
for(i=0; i<8; i++) currentWorld->powerupFrequencies[i]=0;

/* Zero some variables */
currentWorld->frequencyTotal=0;
currentWorld->highScore = 0;
nextPlatformRef=0;
currentWorld->ceilingAnimFrame=0;
currentWorld->ceilingAnimLastFrameTime=0;
nextPowerup=0;

/* Frame graphic */
currentWorld->frameGraphic = loadGraphic("skyscra/frame.bmp");

/* Ceiling animation */
currentWorld->ceilingAnimFramePeriod = 50;
loadAnimation("ceilingSpikes.bmp", 2, &currentWorld->ceilingAnim);

/* Ambient sound effect loop */
currentWorld->ambientSnd = loadSound("AmbienceRain.ogg");

/* BACKGROUND LAYER 0: */
currentWorld->backgrounds[0] = loadGraphic("skyscra/background.bmp");
currentWorld->scrollSpeeds[0] = 0;

/* BACKGROUND LAYER 2: */
currentWorld->backgrounds[2] = loadGraphic("skyscra/pipesBack.bmp");
currentWorld->scrollSpeeds[2] = 2;

/* BACKGROUND LAYER 3: */
currentWorld->backgrounds[3] = loadGraphic("skyscra/pipesMid.bmp");
currentWorld->scrollSpeeds[3] = 3;

/* BACKGROUND LAYER 5: */
currentWorld->backgrounds[5] = loadGraphic("skyscra/pipesFore.bmp");
currentWorld->scrollSpeeds[5] = 5;

/* BACKGROUND LAYER 7: */
currentWorld->backgrounds[7] = loadGraphic("skyscra/rain.bmp");
currentWorld->scrollSpeeds[7] = 9;

/* PLATFORM TYPE 1: */

/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 1;

/* Load animation */
loadAnimation("pipe.bmp", 1, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 500;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 1;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = loadSound("LandMetal.ogg");

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 1;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* PLATFORM TYPE 60: */

/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 60;

/* Load animation */
loadAnimation("conveyorright.bmp", 2, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 80;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 1;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = loadSound("LandMetal.ogg");

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 1;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* PLATFORM TYPE 61: */

/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 61;

/* Load animation */
loadAnimation("conveyorleft.bmp", 2, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 80;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 1;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = loadSound("LandMetal.ogg");

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 1;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* PLATFORM TYPE 70: */
/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 70;

/* Load animation */
loadAnimation("antiGrav.bmp", 2, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 80;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 0;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = NULL;

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 1;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* PLATFORM TYPE 100: */

/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 100;

/* Load animation */
loadAnimation("rustSpikes.bmp", 1, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 100;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 6;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = loadSound("LandingOnSpikes.ogg");

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 3;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* PLATFORM TYPE 111: */
/* Create new */
currentWorld->platformRefs[nextPlatformRef] = (worldPlatformRef*) calloc(1,sizeof(worldPlatformRef));

/* Platform type */
currentWorld->platformRefs[nextPlatformRef]->typeCode = (platformType) 111;

/* Load animation */
loadAnimation("laser.bmp", 4, &currentWorld->platformRefs[nextPlatformRef]->anim);

/* Frame period */
currentWorld->platformRefs[nextPlatformRef]->framePeriod = 80;

/* y offset of physical surface */
currentWorld->platformRefs[nextPlatformRef]->yOffset = 7;

/* collision width of platform */
currentWorld->platformRefs[nextPlatformRef]->width = 60;

/* Special sound file to play when Monkey lands on platform, if any */
currentWorld->platformRefs[nextPlatformRef]->snd = NULL;

/* Platform frequency */
currentWorld->platformRefs[nextPlatformRef]->frequency = 2;
currentWorld->frequencyTotal += currentWorld->platformRefs[nextPlatformRef]->frequency;

/* Increase platformRef count */
nextPlatformRef++;

/* POWERUP */
/* Type */
currentWorld->powerups[nextPowerup] = (powerupType) 40;

/* Frequency */
currentWorld->powerupFrequencies[nextPowerup] = 0.2;

nextPowerup++;

/* Score required to complete level */
currentWorld->completeScore = 200;

/* Scores required to get 1-5 stars */
currentWorld->starScore[0] = 220;
currentWorld->starScore[1] = 240;
currentWorld->starScore[2] = 260;
currentWorld->starScore[3] = 300;
currentWorld->starScore[4] = 350;

/* Type code of start platform */
currentWorld->startPlatform = (platformType) 1;

/* Scrolling speed */
currentWorld->scrollSpeed = 26;

/* Gravity */
currentWorld->gravity = 0.25;

/* Store this newly created world in the worlds array */
worlds[numWorlds] = currentWorld;

/* Increase variable holding running total number of worlds in game */
numWorlds++;



currentWorld=NULL;
}

