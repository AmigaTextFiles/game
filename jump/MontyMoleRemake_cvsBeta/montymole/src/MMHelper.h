

#ifndef __MMHELPER_H
#define __MMHELPER_H


#include "MMDataDefs.h"
#include "MMObject.h"


class MMHelper : public MMObject, private MMHELPER
{

public:

	void Init(MMHELPER *helper);

};

#endif
