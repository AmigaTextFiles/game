#ifndef CPLAYER_H
#define CPLAYER_H

#include "cbrick.h"

class cplayer {

	public:
		cplayer();
		~cplayer();

		void set(const char* name, int number);
		const char* playername;
		int playernumber;
		int onField;
		cbrick bricks[4];
};
#endif
