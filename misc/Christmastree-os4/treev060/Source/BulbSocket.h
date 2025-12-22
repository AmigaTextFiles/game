// Copyright Andrew Williams and the University of Bolton
// Do what you like with the program, but please include your 
// sourcecode with any distribution and retain my copyright notices

#include "AWSprite.h"

class BulbSocket : public AWSprite {
private:
	bool bulbPluggedIn;
	
	
public:
	BulbSocket(char *fileName, Uint32 hmf);
	int check_bulb_insertion(AWSprite *bulb);

};

