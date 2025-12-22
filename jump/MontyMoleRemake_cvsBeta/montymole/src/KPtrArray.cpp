/*! 
	\defgroup KTools
	@{
*/

/*!

	\class KPtrArray
	\author Kevan Thurstans

	\brief Derive as an additional class to object to add a growing 
	       array of longs.

	\date 11/10/01

*/


#include <SDL/SDL.h>
#include "KPtrArray.h"


KPtrArray::KPtrArray()
{
	lpArray = NULL;
	nNoOfElements = 0x00;
}


/*!
		\brief Destroy all elements
		All elements added are deleted from here. So once an object is added
		there is no need to destroy by the user.
*/
KPtrArray::~KPtrArray()
{
	//while(nNoOfElements)
	//DelPtr(nNoOfElements-1, true);

	if(lpArray != NULL)
	{
		for(int l=0; l<nNoOfElements; l++)
			delete (void*)(lpArray[l]);

		if(lpArray != NULL)					// Delete the array
			delete lpArray;
	}
}



/*!

	\brief Add an object pointer to array list.

	Will grow array by one.

	@param void			*newPtr		-	pointer to add to array

	@return  int - index of new pointer.
								( -1 = not added to array (

*/

int KPtrArray::AddPtr(long newPtr)
{
	long	*lpPrevArray;												// tempory store of existing array
	int		l;

	lpPrevArray = lpArray;										// keep a record of old array memory
																						// and create a new memory with additional space
	if(lpArray = new long[nNoOfElements+1])
	{
		if(lpPrevArray != NULL)
		{
			for(l=0; l<nNoOfElements; l++)			// copy existing array into new
				lpArray[l] = lpPrevArray[l];			// memory
		}
		else
			l=0;																// set to first element to be added

		lpArray[l] = newPtr;									// store new pointer
		if(lpPrevArray)
			delete lpPrevArray;										// delete original memory
		return ++nNoOfElements;								// increase count
	}
	else
	{		// if we have a problem with creating a new memory
			// go back to how we were
		lpArray = lpPrevArray;
		return -1;
	}
}



/*!

	\brief Delete Pointer
	
	Deletes an object from array. The object itself is destroyed.

	@param int			index - index of ptr we wish to delete
	@param bool			bDeleteElement - TRUE delete object as well.

	@return int - number of elements left
								( -1 = not done )

*/

int KPtrArray::DelPtr(int index, bool bDeleteElement)
{
	long *prevPtr = lpArray;
	void *element;
	int		size = GetSize(),
				l;

	if(index >= 0 && index < size)
	{
		if(bDeleteElement)
		{
			element = (void*)lpArray[index];
			delete element;
		}

		size--;
		if((lpArray = new long[size]) != NULL)
		{
			for(l=0; l<index; l++)
				lpArray[l] = prevPtr[l];

			for(l=index; l<size; l++)
				lpArray[l] = prevPtr[l+1];
			
			if(prevPtr)
				delete prevPtr;
			return --nNoOfElements;
		}
	}

	return -1;
}



/*!

	\brief Get an object at a given index.

	Returns the value of an element at a given index.

	@param int			index - index wanted

	@return long - value of element/object ptr.
								 (-1 = no element at given index)

*/

long KPtrArray::GetAt(int index)
{

	if(index >= 0 && index < GetSize())
	{
		return lpArray[index];
	}

	return -1;
}

/*!@}*/
