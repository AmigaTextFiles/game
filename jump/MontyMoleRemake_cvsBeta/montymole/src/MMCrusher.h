

#ifndef __MMCRUSHER_H
#define __MMCRUSHER_H


#include "MMObject.h"
#include "MMDataDefs.h"


class MMCrusher : public MMObject, private MMCRUSHER
{

public:

	enum { UP, DOWN };

	void Init(MMCRUSHER *crusher);
	void Move();

	inline Uint8 GetDirection() { return direction; };
private:

};

#endif
