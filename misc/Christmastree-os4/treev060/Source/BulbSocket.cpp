// Copyright Andrew Williams and the University of Bolton
// Do what you like with the program, but please include your 
// sourcecode with any distribution and retain my copyright notices

#include "BulbSocket.h"
#include "stdlib.h"

BulbSocket::BulbSocket(char *fileName, Uint32 hmf) : AWSprite(fileName, hmf) {
	bulbPluggedIn = false;
}

// This function checks to see if a bulb has hit the socket
//  in such a way that it has been plugged in...
// It must hit close to the centre and must not be travelling too fast..
int BulbSocket::check_bulb_insertion(AWSprite *bulb) {
	if(bulbPluggedIn) return false;
	// OK, we have a hit
	if(this->bb_80_collision(bulb)) {
		 if(bulb->get_x() > worldX && bulb->get_y() > worldY) {
		 	if((bulb->get_x()+bulb->get_width() < (worldX + this->get_width())) && 
			   (bulb->get_y()+bulb->get_height() < (worldY + this->get_height())))
			{
				if(bulb->velY < 1.4f && bulb->velY > -1.4f) {
					bulbPluggedIn = true;
					return true;
				}
			}
		}
	}
	return false;
}


