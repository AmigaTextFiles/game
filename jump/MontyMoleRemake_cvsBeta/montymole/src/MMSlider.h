

#ifndef __MMSLIDER_H
#define __MMSLIDER_H


#include "MMObject.h"
#include "MMDataDefs.h"


class MMSlider : public MMObject, private PCSLIDER
{

public:

	void Init(PCSLIDER *slider);
	void Move();											// returns indexed of linked killer
	virtual void Update();						// overid update as we need two blits

	bool Collision(KJLine baseLine);	// Check to see if basline is within objects rect
private:

	Uint8			rightStartX;
	SDL_Rect	rcDestR,								// right hand blit
						rcSrcR;
};

#endif
