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

#include "items.h"

void addItem()
{
	Item *item = new Item();
	
	item->set(Math::rrand(50, 750), Math::rrand(50, 550), ITEM_POWER, graphics.getSprite("ItemPower", true)->getCurrentFrame());

	if ((rand() % 7) == 0)
		item->set(Math::rrand(50, 750), Math::rrand(50, 550), ITEM_CLOCK, graphics.getSprite("ItemClock", true)->getCurrentFrame());

	if ((rand() % 25) == 0)
		item->set(Math::rrand(50, 750), Math::rrand(50, 550), ITEM_BOMB, graphics.getSprite("ItemBomb", true)->getCurrentFrame());

	gameData.addItem(item);
}

void doBulletItemCollisions()
{
	int mouseX = engine.getMouseX() - 2;
	int mouseY = engine.getMouseY() - 2;

	Item *item = (Item*)gameData.itemList.getHead();

	while (item->next != NULL)
	{
		item = (Item*)item->next;

		if (item->type == ITEM_TEXT)
			continue;
		
		if (Collision::collision(item->x - 16, item->y - 16, 32, 32, mouseX, mouseY, 4, 4))
		{
			gameData.roundItemsCollected++;

			switch (item->type)
			{
				case ITEM_BOMB:
					item->health = 0;
					nukeAllViruses();
					break;
				
				case ITEM_CLOCK:
					item->health = 200;
					item->type = ITEM_TEXT;
					graphics.setFontColor(0x00, 0xff, 0x00, 0x00, 0x00, 0x00);
					item->image = graphics.getString(true, "+1 Thread Stop");
					audio.playSound(SND_POWERUP, 0);
					gameData.threadStops++;
					break;

				case ITEM_POWER:
					item->health = 200;
					graphics.setFontColor(0x00, 0xff, 0x00, 0x00, 0x00, 0x00);
					item->image = graphics.getString(true, "+Kernel Power Max");
					audio.playSound(SND_POWERUP, 0);
					item->type = ITEM_TEXT;
					gameData.kernelPower = 300;
					break;
			}
		}
	}
}

void doItems()
{
	Item *item = (Item*)gameData.itemList.getHead();
	Item *previous = item;
	gameData.itemList.resetTail();

	while (item->next != NULL)
	{
		item = (Item*)item->next;

		item->health -= (int)(1 * engine.getTimeDifference());

		if (gameData.activeViruses == 0)
			if (item->type == ITEM_TEXT)
				item->health = 0;

		graphics.blit(item->image, item->x, item->y, graphics.screen, true);

		if (item->health > 0)
		{
			previous = item;
			gameData.itemList.setTail(item);
		}
		else
		{
			gameData.itemList.remove(previous, item);
			item = previous;
		}
	}
}
