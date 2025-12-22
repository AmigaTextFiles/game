

#ifndef __KPTRARRAY_H
#define __KPTRARRAY_H


class KPtrArray
{

public:

	KPtrArray();
	~KPtrArray();

	int		AddPtr(long newPtr);			// Add new element to array
	int		DelPtr(int index, bool bDeleteElement);				//! delete pointer @ index
	long	GetAt(int index);					// Get value of element @ index
																	// get number of elements in array
	inline int GetSize() { return nNoOfElements; };
private:

	long		*lpArray;				// Pointer which holds the address to our list
	int			nNoOfElements;	// Keeps count of the number of elements added.

};

#endif
