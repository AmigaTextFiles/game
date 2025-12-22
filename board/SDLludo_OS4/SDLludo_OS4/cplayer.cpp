#include "cbrick.h"
#include "cplayer.h"

cplayer::cplayer() {
}

void cplayer::set(const char* name, int number) {
	this->playername = name;
	this->playernumber = number;
	this->onField = 0;

	this->bricks[0].set(number, 1);
	this->bricks[1].set(number, 2);
	this->bricks[2].set(number, 3);
	this->bricks[3].set(number, 4);
}

cplayer::~cplayer() {

}
