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

#include "resources.h"

void loadResources()
{
	Sprite *sprite;

	debug(("Loading Resources...\n"));

	/* load all the graphics */

	graphics.quickSprite("TitleLogo", graphics.loadImage("gfx/main/title.png"));
	graphics.quickSprite("PRLogo", graphics.loadImage("gfx/main/prlogo.gif"));
	graphics.setFontSize(3);
	graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);
	graphics.quickSprite("Presents", graphics.getString(true, "Presents"));
	graphics.quickSprite("SDL", graphics.getString(true, "An SDL Game"));

	graphics.quickSprite("BlueDirectory", graphics.loadImage("gfx/dirs/blueDir.png"));
	graphics.quickSprite("GreenDirectory", graphics.loadImage("gfx/dirs/greenDir.png"));
	graphics.quickSprite("GreyDirectory", graphics.loadImage("gfx/dirs/greyDir.png"));
	graphics.quickSprite("RedDirectory", graphics.loadImage("gfx/dirs/redDir.png"));
	graphics.quickSprite("VioletDirectory", graphics.loadImage("gfx/dirs/violetDir.png"));
	graphics.quickSprite("YellowDirectory", graphics.loadImage("gfx/dirs/yellowDir.png"));

	graphics.quickSprite("Binary", graphics.loadImage("gfx/fileTypes/binary.png"));
	graphics.quickSprite("HTML", graphics.loadImage("gfx/fileTypes/html.png"));
	graphics.quickSprite("Image", graphics.loadImage("gfx/fileTypes/image.png"));
	graphics.quickSprite("Video", graphics.loadImage("gfx/fileTypes/video.png"));
	graphics.quickSprite("PDF", graphics.loadImage("gfx/fileTypes/pdf.png"));
	graphics.quickSprite("QuickTime", graphics.loadImage("gfx/fileTypes/quicktime.png"));
	graphics.quickSprite("RPM", graphics.loadImage("gfx/fileTypes/rpm.png"));
	graphics.quickSprite("Office", graphics.loadImage("gfx/fileTypes/soffice.png"));
	graphics.quickSprite("Sound", graphics.loadImage("gfx/fileTypes/sound.png"));
	graphics.quickSprite("C", graphics.loadImage("gfx/fileTypes/source_c.png"));
	graphics.quickSprite("CPP", graphics.loadImage("gfx/fileTypes/source_cpp.png"));
	graphics.quickSprite("H", graphics.loadImage("gfx/fileTypes/source_h.png"));
	graphics.quickSprite("Java", graphics.loadImage("gfx/fileTypes/source_java.png"));
	graphics.quickSprite("O", graphics.loadImage("gfx/fileTypes/source_o.png"));
	graphics.quickSprite("Zip", graphics.loadImage("gfx/fileTypes/tgz.png"));
	graphics.quickSprite("Text", graphics.loadImage("gfx/fileTypes/txt.png"));
	graphics.quickSprite("WordProcessing", graphics.loadImage("gfx/fileTypes/wordprocessing.png"));

	graphics.quickSprite("Base1", graphics.loadImage("gfx/sprites/ie.png"));
	graphics.quickSprite("Base2", graphics.loadImage("gfx/sprites/bin.png"));
	graphics.quickSprite("Base3", graphics.loadImage("gfx/sprites/outlook.png"));
	graphics.quickSprite("Base4", graphics.loadImage("gfx/sprites/msn.png"));

	graphics.quickSprite("ItemBomb", graphics.loadImage("gfx/sprites/bomb.png"));
	graphics.quickSprite("ItemClock", graphics.loadImage("gfx/sprites/clock.png"));
	graphics.quickSprite("ItemPower", graphics.loadImage("gfx/sprites/battery.png"));

	graphics.quickSprite("Targeter", graphics.loadImage("gfx/sprites/targeter.png"));

	sprite = graphics.addSprite("Virus1");
	sprite->setFrame(0, graphics.loadImage("gfx/sprites/virus1-1.png"), 10);
	sprite->setFrame(1, graphics.loadImage("gfx/sprites/virus1-2.png"), 10);
	sprite->setFrame(2, graphics.loadImage("gfx/sprites/virus1-3.png"), 10);
	sprite->setFrame(3, graphics.loadImage("gfx/sprites/virus1-4.png"), 10);

	sprite = graphics.addSprite("Virus2");
	sprite->setFrame(0, graphics.loadImage("gfx/sprites/virus2-1.png"), 8);
	sprite->setFrame(1, graphics.loadImage("gfx/sprites/virus2-2.png"), 8);
	sprite->setFrame(2, graphics.loadImage("gfx/sprites/virus2-3.png"), 8);

	sprite = graphics.addSprite("Virus3");
	sprite->setFrame(0, graphics.loadImage("gfx/sprites/virus3-1.png"), 5);
	sprite->setFrame(1, graphics.loadImage("gfx/sprites/virus3-2.png"), 5);
	sprite->setFrame(2, graphics.loadImage("gfx/sprites/virus3-3.png"), 5);
	sprite->setFrame(3, graphics.loadImage("gfx/sprites/virus3-4.png"), 5);

	graphics.loadBackground("gfx/main/backdrop.png");

	audio.loadSound(SND_VIRUSLAUGH1, "sound/virusLaugh1.wav");
	audio.loadSound(SND_VIRUSLAUGH2, "sound/virusLaugh2.wav");
	audio.loadSound(SND_VIRUSLAUGH3, "sound/virusLaugh2.wav");
	audio.loadSound(SND_VIRUSLAUGH4, "sound/virusLaugh5.wav");
	audio.loadSound(SND_VIRUSLAUGH5, "sound/virusLaugh5.wav");
	audio.loadSound(SND_VIRUSLAUGH6, "sound/virusLaugh6.wav");
	
	audio.loadSound(SND_VIRUSDESTROYDIR, "sound/virusDestroyDir.wav");
	
	audio.loadSound(SND_VIRUSKILLED1, "sound/virusKilled1.wav");
	audio.loadSound(SND_VIRUSKILLED2, "sound/virusKilled2.wav");
	audio.loadSound(SND_VIRUSKILLED3, "sound/virusKilled3.wav");

	audio.loadSound(SND_VIRUSEATFILE, "sound/virusEatFile.wav");

	audio.loadSound(SND_DIRDESTROYED1, "sound/dirDestroyed1.wav");
	audio.loadSound(SND_DIRDESTROYED2, "sound/dirDestroyed2.wav");
	audio.loadSound(SND_DIRDESTROYED3, "sound/dirDestroyed3.wav");
	audio.loadSound(SND_DIRDESTROYED4, "sound/dirDestroyed4.wav");
	audio.loadSound(SND_DIRDESTROYED5, "sound/dirDestroyed5.wav");
	audio.loadSound(SND_DIRDESTROYED6, "sound/dirDestroyed6.wav");

	audio.loadSound(SND_FILEDESTROYED1, "sound/fileDestroyed1.wav");
	audio.loadSound(SND_FILEDESTROYED2, "sound/fileDestroyed2.wav");
	audio.loadSound(SND_FILEDESTROYED3, "sound/fileDestroyed3.wav");
	
	audio.loadSound(SND_KERNALBEAM, "sound/kernelBeam.wav");

	audio.loadSound(SND_POWERUP, "sound/powerup.wav");
	audio.loadSound(SND_CLOCK, "sound/clock.wav");
	audio.loadSound(SND_EXPLOSION, "sound/explosion.wav");

	audio.loadSound(SND_GAMEOVER, "sound/gameOver.wav");

	gameData.base[0].image = graphics.getSprite("Base1", true)->getCurrentFrame();
	gameData.base[1].image = graphics.getSprite("Base2", true)->getCurrentFrame();
	gameData.base[2].image = graphics.getSprite("Base3", true)->getCurrentFrame();
	gameData.base[3].image = graphics.getSprite("Base4", true)->getCurrentFrame();

	debug(("Finished Resources...\n"));
}
