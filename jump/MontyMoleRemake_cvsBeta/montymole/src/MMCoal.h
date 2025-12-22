

#ifndef __MMCOAL_H
#define __MMCOAL_H


#include "MMObject.h"
#include "MMDataDefs.h"


class MMCoal : public MMObject, private PCCOAL
{

public:

	void Init(PCCOAL *coal, int room);

	Uint16	inline GetIndex() { return index; }; // Return index of coal

private:

};

#endif
