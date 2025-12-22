/*
 *  Bubble Train
 *  Copyright (C) 2004  
 *  					Adam Child (adam@dwarfcity.co.uk)
 * 						Craig Marshall (craig@craigmarshall.org)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */
 
#include "Cannon.h"

Cannon::Cannon()
{
	this->position.set(400,575);
	this->cannonMagazine = new BulletFactory();
	this->loadedBullet = NULL;
	this->nextBullet = NULL;
	this->bulletRate = 0;
	this->bulletSpeed = 0;
	this->angle = 0;
	this->useMouse = Options::Instance()->getMouseEnabled();
	this->mouseSensitivity = Options::Instance()->getMouseSensitivity();
}

Cannon::Cannon(Point position)
{
	this->position = position;
	this->cannonMagazine = new BulletFactory();
	this->cannonMagazine->resetFactory(3);
	this->loadedBullet = this->cannonMagazine->popBullet();
	this->nextBullet = this->cannonMagazine->popBullet();
	this->bulletRate = 500;
	this->bulletSpeed = 8;
	this->angle = 0;
	this->useMouse = Options::Instance()->getMouseEnabled();	
	this->mouseSensitivity = Options::Instance()->getMouseSensitivity();
}

Cannon::~Cannon()
{
	if (this->cannonMagazine != NULL)
		delete this->cannonMagazine;
	
	if (this->loadedBullet)
		delete this->loadedBullet;
	
	if (this->nextBullet)
		delete this->nextBullet;
}

void Cannon::load(xmlDocPtr doc, xmlNodePtr cur)
{
	
	//<cannon type="rotation" pos="400,575" bulletreloadtime="1000" bulletspeed="8">
	//	<carriages random="1" colour-num="2"/>
	//</cannon>
	
	// Make sure this is a cannon node
	if (strcmp((const char*)cur->name, "cannon"))
		Log::Instance()->die(1,SV_ERROR,"Cannon: node trying to load is not cannon but %s\n", (const char*)cur->name);
	
	// Find the position of the cannon
	char* posText = (char*)xmlGetProp(cur, (const xmlChar*)"pos");
	if (posText != NULL or !strcmp(posText, ""))
		this->position.set(posText);
	else
		Log::Instance()->die(1,SV_ERROR,"Cannon: position not found\n");
	
	// Find the bullet speed px/frame of the cannon
	char* speedText = (char*)xmlGetProp(cur, (const xmlChar*)"bulletspeed");
	if (speedText != NULL or !strcmp(speedText, ""))
		this->bulletSpeed = atoi(speedText);
	else
	{
		this->bulletSpeed = 8;
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING,"Cannon: bulletspeed found but not correct defaulting to %d", this->bulletSpeed);	
	}
	
	// Find the bullet rate of the cannon firing in ms between reloads
	char* reloadText = (char*)xmlGetProp(cur, (const xmlChar*)"bulletreloadtime");
	if (reloadText != NULL or !strcmp(reloadText, ""))
		this->bulletRate = atoi(reloadText);
	else
	{
		this->bulletRate = 500;
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING,"Cannon: bulletrate found but not correct defaulting to %d", this->bulletRate);	
	}
	
	// load the cannon magazine
	cur = cur->xmlChildrenNode;
	while (cur != NULL)
	{
		if (strcmp((const char*)cur->name, "bullets"))
		{
			cur = cur->next;
			continue;
		}
	
		this->cannonMagazine->load(doc,cur);
		break;
	}
	
	// Load the bullets
	this->loadedBullet = this->cannonMagazine->popBullet();
	this->nextBullet = this->cannonMagazine->popBullet(); 
	Cannon::setLoadedBulletPos();
	Cannon::setNextBulletPos();
	
}

void Cannon::load(const char* path, const char* filename)
{
	// We don't support this form of loading but must support the interface
}

void Cannon::save(xmlDocPtr doc, xmlNodePtr cur)
{
	// We don't need to save anything but must support the interface
}

void Cannon::save(const char* path, const char* filename)
{
	// We don't need to save anything but must support the interface
}

void Cannon::animate(LevelState state)
{
	// 
	if (state != LS_RUNNING)
		return;
		
	// Re-load the next bullet
	if (this->loadedBullet == NULL && (SDL_GetTicks() - this->lastBulletFired > this->bulletRate))
	{
		this->loadedBullet = this->nextBullet;
	    this->nextBullet = this->cannonMagazine->popBullet();	
		Cannon::setLoadedBulletPos();
	    Cannon::setNextBulletPos();
	    
	    Theme::Instance()->playSound(SND_CANNONRELOAD);
	}
	if (this->loadedBullet)
		this->loadedBullet->animate();
		
	if (this->nextBullet)
		this->nextBullet->animate();
	
	if (this->useMouse)
		Cannon::moveMouse();
}

bool Cannon::getUseMouse()
{
	return this->useMouse;
}

void Cannon::setUseMouse(bool mouse)
{
	this->useMouse = mouse;
}

float Cannon::getAngle()
{
	return this->angle;
}

Point Cannon::getPosition()
{
	return this->position;
}

void Cannon::setBulletRate(Uint32 rate)
{
	this->bulletRate = rate;
}

void Cannon::setBulletSpeed(Uint32 speed)
{
	this->bulletSpeed = speed;
}

Bullet* Cannon::peakNextBullet()
{
	return this->loadedBullet;
}

bool Cannon::canFireBullet()
{
	return (this->loadedBullet != NULL);
}

Bullet* Cannon::fireBullet()
{
	this->lastBulletFired = SDL_GetTicks();
	Bullet* fired = this->loadedBullet;
	// Re-map the zero of the angle. The cannon treats zero as pointing upwards
	// where as everything else has zero pointing right.
	fired->velocity.setSpeed(this->bulletSpeed);
	fired->velocity.setAngle(this->angle + M_PI_2);

	Theme::Instance()->playSound(SND_FIREBULLET);

	this->loadedBullet = NULL;
	return fired;	
}

void Cannon::rotateLeft()
{
	this->angle += ROTATION_STEP;
	if (this->angle > 0.0 && this->angle > LEFT_LIMIT)
		this->angle = LEFT_LIMIT;
	else // Only play the sound if we haven't hit the end stop	
		Theme::Instance()->playSound(SND_CANNONMOVE);
	
	Cannon::setLoadedBulletPos();
}

void Cannon::rotateRight()
{
	this->angle -= ROTATION_STEP;
	if (this->angle < 0.0 && this->angle < RIGHT_LIMIT)
		this->angle = RIGHT_LIMIT;
	else // Only play the sound if we haven't hit the end stop
		Theme::Instance()->playSound(SND_CANNONMOVE);
		
	Cannon::setLoadedBulletPos();
}

void Cannon::draw(SDL_Surface* screen)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Cannon::draw");
	
	if (this->nextBullet != NULL)
	    this->nextBullet->draw(screen);
	
	// Draw the next colour bullet
	// Only draw when the bullet had re-loaded
	if (Cannon::canFireBullet())
		this->loadedBullet->draw(screen);

	Point cannonPos = this->position;
	Theme::Instance()->drawOffsetSurface(GFX_CANNON, cannonPos, this->angle, 50, 80);
	
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Cannon::finsihed draw");
}

void Cannon::setLoadedBulletPos()
{
	if (this->loadedBullet == NULL)
		return;

	// Translate the bullet so that it looks like it's coming out of the cannon end
	Point bulletPoint;
	bulletPoint.x = this->position.x - CANNON_LENGTH * sin(this->angle);
	bulletPoint.y = this->position.y - CANNON_LENGTH * cos(this->angle);
	this->loadedBullet->bubble->setPosition(bulletPoint);
}

void Cannon::setNextBulletPos()
{
	Point cannonPos = this->position;
	cannonPos.x += 40;
	cannonPos.y = APP_HEIGHT - BUBBLE_RAD;
	this->nextBullet->bubble->setPosition(cannonPos);
}

void Cannon::moveMouse()
{
	int x;
	int y;
	double ang;
	SDL_GetMouseState(&x, &y);

	// Calculate the angle of the cannon by making the complete width of the screen 
	// the same as the full range of angle movement in the cannon.
	// i.e. x = 0 , angle = Left limit
	// 		x = screen, angle = Right limit
	// This is also assumed that the sensitivity is set to the slowest setting.
	// i.e. sensitivity = 1;
	// when sensitivity = max; then it should take a smaller portion of the screen to move the same angle range

	// position to angle ratio = (Right angle - left angle) / screen width
	
	// Also zero angle is the cannon pointing up. So should calculate the distance from
	// the cannon centre instead of the left edge.
	
	double ratio = fabs(RIGHT_LIMIT - LEFT_LIMIT) / SDL_GetVideoSurface()->w;
	
	ang = (this->position.x - x) * ratio * this->mouseSensitivity;
	
	
	// If the angle hasn't moved then don't bother updating again.
	if (fabs(this->angle - ang) < CANNON_ROUND_ERROR)
		return;
	
	this->angle = ang;
	
	if (this->angle < 0.0 && this->angle < RIGHT_LIMIT)
		this->angle = RIGHT_LIMIT;
	else if (this->angle > 0.0 && this->angle > LEFT_LIMIT)
		this->angle = LEFT_LIMIT;
	else // Only play the sound if we haven't hit the end stop
		Theme::Instance()->playSound(SND_CANNONMOVE);
	
	Cannon::setLoadedBulletPos();
}
