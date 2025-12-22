/* 
	manager.h  -  Image Handler/Manager

	V 1.5

	LGPL (c) FluXy
*/


#ifndef __IMG_MANAGER_H__
#define __IMG_MANAGER_H__

#include "include/globals.h"

class cImageManager
{
public:	
	cImageManager()
	{
		Count = 0;
	}

	~cImageManager()
	{
		DeleteAll();
	}

	// Returns the Surface
	SDL_Surface *GetPointer( string nPath );
	SDL_Surface *GetPointer( const char *nPath );
	SDL_Surface *GetPointer( unsigned int nId );

	SDL_Surface *GetPointer_array( unsigned int nId );

	// Returns the copied image
	SDL_Surface *Copy( string nPath );

	// Returns the image Path in a string
	string GetPath( SDL_Surface *nItem );
	string GetPath( unsigned int nId );

	// Returns the image Path in a char*
	const char *GetPathC( SDL_Surface *nItem );
	// Returns the image Path in a char*
	const char *GetPathC( unsigned int nId );

	/*	
	 *	Returns the Current Size/Count of the Items
	 */
	unsigned int GetSize( void );

	/*	Adds an Image
	 *	Should always have a Path
	 */
	void Add( SDL_Surface *nItem, string nPath );

	SDL_Surface *operator [] ( unsigned int nId )
	{
		return GetPointer( nId );
	}
	
	SDL_Surface *operator [] ( string nPath )
	{
		return GetPointer( nPath );
	}
	
	string operator [] ( SDL_Surface *nItem )
	{
		return GetPath( nItem );
	}

	/**
	* Call this function to reload all images.
	*
	* step: 0 = complete reload
	*       1 = only delete bitmap surfaces
	*       2 = only load the bitmap surfaces
	*/
	void ReloadImages( unsigned int step = 0 );

	/**
	* Free all bitmap surfaces, but keep ImageItems vector entries
	*/
	void DeleteImages( void );

	/**
	* Delete all ImageItems completely.
	*/
	void DeleteAll( void );

private:
	// The Imageitem Structure
	struct ImageItem 
	{
		SDL_Surface *Item;
		string Path;
		unsigned int CountId;
	};

	// How much images loaded since initialization
	unsigned int Count;
	// The ImageItems Array
	vector<ImageItem> ImageItems;
};

#endif
