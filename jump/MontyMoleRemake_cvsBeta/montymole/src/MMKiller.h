

#ifndef __MMKILLER_H
#define __MMKILLER_H


#include "MMObject.h"
#include "MMDataDefs.h"


class MMKiller : public MMObject, private PCKILLER
{

public:

	enum {
					STATUS_BASIC = 0,			// Type of killer... Basic moves left/right or up/down
					STATUS_HOMING,				// Homes in on Monty Mole
					STATUS_COUNT,					// Disabled when counter reaches zero, being replaced by indexed object
					STATUS_LINKED=2,
					STATUS_DISABLED,			// Disabled.. Not shown...
					STATUS_MASK = 3,
					STATUS_NO_ANIM = 4,		// Disable animation
					STATUS_NO_KILL = 8,		// Killer will not kill and can be collected without helper object..
					STATUS_ATTR_MASK = 0x8C
	};

	void Init(PCKILLER *killer);
	int Move();											// returns indexed of linked killer

	void					Kill();									// Kill off killer
	void					SetStatus(int newStatus);
	inline int		GetStatus() { return status; };
	inline Uint8	GetX() { return x;};
	inline Uint8	GetY() { return y;};
private:

};

#endif
