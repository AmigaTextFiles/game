/*
Copyright (C) 2004 Parallel Realities

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/

#include "highscores.h"

int getHighScorePosition(unsigned int score)
{
	for (int i = 0 ; i < 10 ; i++)
	{
		if (score > gameData.highScore[gameData.skill][i].score)
			return i;
	}

	return -1;
}

void showHighScores(int skill, int startY)
{
	graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);
	graphics.setFontSize(2);
	graphics.drawString(400, startY, TXT_CENTERED, graphics.screen, "Highscores - %s Mode", gameModes[skill]);
	graphics.setFontSize(1);
	
	startY += 60;

	graphics.drawString(175, startY, TXT_LEFT, graphics.screen, "Name");
	graphics.drawString(375, startY, TXT_LEFT, graphics.screen, "Score");
	graphics.drawString(475, startY, TXT_LEFT, graphics.screen, "Kills");
	graphics.drawString(575, startY, TXT_LEFT, graphics.screen, "Level");

	startY += 40;

	for (int i = 0 ; i < 10 ; i++)
	{
		graphics.drawString(175, startY + (25 * i), TXT_LEFT, graphics.screen, "%s", gameData.highScore[skill][i].name);
		graphics.drawString(375, startY + (25 * i), TXT_LEFT, graphics.screen, "%.8d", gameData.highScore[skill][i].score);
		graphics.drawString(475, startY + (25 * i), TXT_LEFT, graphics.screen, "%.5d", gameData.highScore[skill][i].kills);
		graphics.drawString(575, startY + (25 * i), TXT_LEFT, graphics.screen, "%.3d", gameData.highScore[skill][i].level);
	}
}

int addHighScore()
{
	if (gameData.score < 0)
		return SECTION_TITLE;

	int position = getHighScorePosition(gameData.score);

	if (position == -1)
		return SECTION_TITLE;

	audio.loadMusic("music/Highscore.mod");

	addTitleViruses();

	graphics.clearScreen(graphics.black);
	graphics.delay(500);

	char place[5];

	switch (position + 1)
	{
		case 1:
			strcpy(place, "1st");
			break;
		case 2:
			strcpy(place, "2nd");
			break;
		case 3:
			strcpy(place, "3rd");
			break;
		default:
			sprintf(place, "%dth", position + 1);
			break;
	}

	strcpy(engine.lastInput, "");

	engine.resetTimeDifference();
	
	graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);

	audio.playMusic();

	while (true)
	{
		engine.doTimeDifference();

		engine.getInput();

		if ((engine.keyState[SDLK_RETURN]) || (engine.keyState[SDLK_ESCAPE]))
			break;

		graphics.updateScreen();
		graphics.clearScreen(graphics.black);

		doTitleViruses();

		graphics.setFontSize(2);

		graphics.drawString(400, 80, TXT_CENTERED, graphics.screen, "!! Congratulations !!");

		graphics.setFontSize(1);

		graphics.drawString(400, 150, TXT_CENTERED, graphics.screen, "Even though your system has been completely destroyed and viruses are");
		graphics.drawString(400, 175, TXT_CENTERED, graphics.screen, "now spreading all your personal information around the internet via MSN,");
		graphics.drawString(400, 200, TXT_CENTERED, graphics.screen, "you scored enough points to make it to the highscore board!", gameData.score);

		graphics.setFontSize(2);

		graphics.drawString(400, 250, TXT_CENTERED, graphics.screen, "%s Place with %d Points!!", place, gameData.score);

		graphics.drawString(400, 325, TXT_CENTERED, graphics.screen, "Please Enter Your Name");

		if (strlen(engine.lastInput) > 0)
			graphics.drawString(400, 375, TXT_CENTERED, graphics.screen, "%s_", engine.lastInput);
		else
			graphics.drawString(400, 375, TXT_CENTERED, graphics.screen, "_");
	}

	graphics.clearScreen(graphics.black);
	graphics.delay(500);

	for (int i = 8 ; i != (position - 1) ; i--)
	{
		debug(("Replacing %s with %s\n", gameData.highScore[gameData.skill][i + 1].name, gameData.highScore[gameData.skill][i].name));
		gameData.highScore[gameData.skill][i + 1] = gameData.highScore[gameData.skill][i];
	}

	if (strlen(engine.lastInput) == 0)
		strcpy(engine.lastInput, "Anonymous");

	gameData.highScore[gameData.skill][position].set(engine.lastInput, gameData.score, gameData.virusesKilled, gameData.level);

	engine.clearInput();
	engine.flushInput();
	engine.resetTimeDifference();
	
	graphics.setFontSize(1);

	while (true)
	{
		engine.doTimeDifference();

		engine.getInput();

		if (engine.userAccepts())
			break;

		graphics.updateScreen();
		graphics.clearScreen(graphics.black);

		doTitleViruses();

		showHighScores(gameData.skill, 100);
	}
	
	audio.stopMusic();
	gameData.clear();

	graphics.clearScreen(graphics.black);
	graphics.delay(500);

	return SECTION_TITLE;
}
