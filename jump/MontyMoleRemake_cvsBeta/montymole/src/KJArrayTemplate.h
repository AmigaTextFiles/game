/*! 
	\defgroup KTools
	@{
*/

/*!

	
	\class KJArrayTemplate<TYPE>
	\author Kevan Thurstans

	\date 17/05/01

	\brief Template for creating array storing classes.

	If the first constructor is used then an empty array is created and
	flag is set to __ARRAYCREATED. This tells the destructor it needs to
	delete the array.
	Alternatively an array can be passed to this object, which will not be
	destroyed by 'this'.

*/


#ifndef __KJARRAYTEMPLATE_H

#define __KJARRAYTEMPLATE_H


template <class TYPE>
class KJArrayTemplate
{

public:

	//! flag types available
	enum ARRAYFLAG { __NOARRAY, __ARRAYCREATED, __ARRAYPASSED };

	KJArrayTemplate(Uint16 noItems);		// create empty array
	KJArrayTemplate(Uint16 noItems, TYPE *array);				// pass pointer of an existing array
	~KJArrayTemplate();

	TYPE*				GetAt(Uint16 index);										// return ptr to item[index]
	bool				SetAt(Uint16 index, TYPE value);				// set new value of item[index]

protected:

	TYPE*				lpArray;								//!< return ptr to stored object[index]
	Uint16			iNoItems;								//!< max number of items in array
	ARRAYFLAG		flag;										//!< how array was created

};



/*!****************************************************************************
 *                                                                            *
 *	\brief Create an empty array                                              *
 *                                                                            *
 *	@param Uint16		noItems		- number of items to create											*
 *                                                                            *
 *	 EXIT	:																			                              *
 *                                                                            *
 ******************************************************************************/

template <class TYPE>
KJArrayTemplate<TYPE>::KJArrayTemplate(Uint16 noItems)
{
	if(noItems > 0)
	{
		lpArray = new TYPE[noItems];
		iNoItems = noItems;
		flag = __ARRAYCREATED;
	}
}


/*!****************************************************************************
 *                                                                            *
 *	\brief Pass a pointer to an existing array                                *
 *                                                                            *
 *	@param Uint16		noItems		- number of items to create					            *
 *	@param TYPE			*array		- pointer to existing array									    *
 *                                                                            *
 *	 EXIT	:																			                              *
 *                                                                            *
 ******************************************************************************/

template <class TYPE>
KJArrayTemplate<TYPE>::KJArrayTemplate(Uint16 noItems, TYPE *array)
{
	if(array != NULL)
	{
		iNoItems = noItems;
		lpArray = array;
		flag = __ARRAYPASSED;
	}
}


template <class TYPE>
KJArrayTemplate<TYPE>::~KJArrayTemplate()
{
	if(flag == __ARRAYCREATED)
		delete lpArray;
}



/*!****************************************************************************
 *                                                                            *
 *	\brief GetAt					                                                    *
 *  Get pointer to item[n]																										*
 *                                                                            *
 *	@param Uint16		index		- index of item required							            *
 *                                                                            *
 *	@return TYPE*		-	pointer to item required.	                              *
 *										will return a NULL if out of bounds                     *
 *                                                                            *
 ******************************************************************************/

template <class TYPE>
TYPE* KJArrayTemplate<TYPE>::GetAt(Uint16 index)
{
	TYPE	*lpFound = NULL;

	if(index>0 && index<iNoItems)
	{
		lpFound = &lpArray[index];
	}

	return lpFound;
}


/*!****************************************************************************
 *                                                                            *
 *	\brief SetAt					                                                    *
 *  Set value of item[index]																									*
 *                                                                            *
 *	@param Uint16		index		- index of item required							            *
 *	@param TYPE			value		- TYPE holding new value						              *
 *                                                                            *
 *	@return bool		-	true = item set ok.				                              *
 *                                                                            *
 ******************************************************************************/

template <class TYPE>
bool KJArrayTemplate<TYPE>::SetAt(Uint16 index, TYPE value)
{
	bool	fSuccess = false;

	if(index>0 && index<iNoItems && value != NULL)
	{
		lpArray[index] = value;
		fSuccess = true;
	}

	return fSuccess;
}


/*
		\brief Get the size of the array

	@param Uint16 - number of items in array.

*/
template <class TYPE>
inline Uint16 GetSize()
	{ return iNoItems; };


//! type KJRect array
typedef KJArrayTemplate<SDL_Rect> KJRectArray;
//! type KJSurface array
typedef KJArrayTemplate<SDL_Surface>	KJSurfaceArray;



#endif
/*@}*/