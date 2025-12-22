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

#include "particles.h"

void addVirusDeathParticles(int x, int y, int virusType)
{
	Particle *particle;
	
	int color[5];

	switch (virusType)
	{
		case VIRUS_THIEF:
			color[0] =  graphics.yellow;
			color[1] =  graphics.lightestGreen;
			color[2] =  graphics.lightGreen;
			color[3] =  graphics.green;
			color[4] =  graphics.white;
			break;

		case VIRUS_EAT:
			color[0] =  graphics.red;
			color[1] =  graphics.white;
			color[2] =  graphics.green;
			color[3] =  graphics.red;
			color[4] =  graphics.blue;
			break;

		case VIRUS_DESTROY:
			color[0] =  graphics.red;
			color[1] =  graphics.yellow;
			color[2] =  graphics.white;
			color[3] =  graphics.yellow;
			color[4] =  graphics.red;
			break;
	}

	for (int i = 0 ; i < 500 ; i++)
	{
		particle = new Particle();
		particle->x = x;
		particle->y = y;
		particle->dx = Math::rrand(-500, 500);
		particle->dy = Math::rrand(-500, 500);

		if (particle->dx != 0)
			particle->dx /= (100 * Math::rrand(1, 3));

		if (particle->dy != 0)
			particle->dy /= (100 * Math::rrand(1, 3));

		particle->health = Math::rrand(100, 300);

		particle->color = color[rand() % 5];

		gameData.addParticle(particle);
	}
}

void addBulletParticle()
{
	Particle *particle;
	
	for (int i = 0 ; i < 5 ; i++)
	{
		particle = new Particle();
		particle->x = engine.getMouseX();
		particle->y = engine.getMouseY();
		particle->dx = Math::rrand(-100, 100);
		particle->dy = Math::rrand(-100, 100);

		if (particle->dx != 0)
			particle->dx /= (100 * Math::rrand(1, 3));

		if (particle->dy != 0)
			particle->dy /= (100 * Math::rrand(1, 3));

		particle->health = Math::rrand(50, 75);
		particle->color = graphics.white;

		gameData.addParticle(particle);
	}
	
	graphics.lock(graphics.background);
	for (int i = 0 ; i < 5 ; i++)
		graphics.putPixel(engine.getMouseX() + Math::rrand(-1, 1), engine.getMouseY() + Math::rrand(-1, 1), graphics.black, graphics.background);
	graphics.unlock(graphics.background);
}

void addDirectoryDeathParticles(int x, int y)
{
	Particle *particle;

	for (int i = 0 ; i < 100 ; i++)
	{
		particle = new Particle();
		particle->x = x;
		particle->y = y;
		particle->dx = Math::rrand(-500, 500);
		particle->dy = Math::rrand(-500, 500);

		if (particle->dx != 0)
			particle->dx /= (100 * Math::rrand(1, 3));

		if (particle->dy != 0)
			particle->dy /= (100 * Math::rrand(1, 3));

		particle->health = Math::rrand(100, 300);

		switch (rand() % 9)
		{
			case 0:
				particle->color = graphics.red;
				break;
			case 1:
				particle->color = graphics.yellow;
				break;
			case 2:
				particle->color = graphics.lightGreen;
				break;
			case 3:
				particle->color = graphics.green;
				break;
			case 4:
				particle->color = graphics.cyan;
				break;
			case 5:
				particle->color = graphics.skyBlue;
				break;
			case 6:
				particle->color = graphics.blue;
				break;
			case 7:
				particle->color = graphics.lightGrey;
				break;
			case 8:
				particle->color = graphics.grey;
				break;
		}

		gameData.addParticle(particle);
	}
}

void doParticles()
{
	Particle *particle = (Particle*)gameData.particleList.getHead();
	Particle *previous = particle;
	gameData.particleList.resetTail();

	graphics.lock(graphics.screen);

	while (particle->next != NULL)
	{
		particle = (Particle*)particle->next;

		graphics.putPixel((int)particle->x, (int)particle->y, particle->color, graphics.screen);

		particle->health -= (int)(1 * engine.getTimeDifference());
		particle->x += particle->dx;
		particle->y += particle->dy;

		if (particle->health > 0)
		{
			previous = particle;
			gameData.particleList.setTail(particle);
		}
		else
		{
			gameData.particleList.remove(previous, particle);
			particle = previous;
		}
	}

	graphics.unlock(graphics.screen);
}
