/***************************************************************************
 *  img_manager.cpp  -  Image Handler/Manager                              *
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/ 

#include "include/globals.h"

SDL_Surface *cImageManager :: GetPointer( string nPath )
{
	for(unsigned int i = 0; i < ImageItems.size(); i++)
	{
		if( ImageItems[i].Path.compare( nPath ) == 0 )
		{
			return ImageItems[i].Item;	// the first found
		}
	}

	return NULL; // not found
}

SDL_Surface *cImageManager :: GetPointer( const char *nPath )
{
	for( unsigned int i = 0; i < ImageItems.size(); i++ )
	{
		if( ImageItems[i].Path.compare( nPath ) == 0 )
		{
			return ImageItems[i].Item;	// the first found
		}
	}

	return NULL; // not found
}

SDL_Surface *cImageManager :: GetPointer( unsigned int nId )
{
	if( Count >= nId ) 
	{
		for( unsigned int i = 0; i < ImageItems.size(); i++ )
		{
			if( ImageItems[i].CountId == nId ) 
			{
				return ImageItems[i].Item;
			}
		}
	}

	return NULL; // not found
}

SDL_Surface *cImageManager :: GetPointer_array( unsigned int nId )
{
	if( GetSize() > nId && ImageItems[nId].Item ) 
	{
		return ImageItems[nId].Item;
	}

	return NULL; // not found
}

SDL_Surface *cImageManager :: Copy( string nPath )
{
	for( unsigned int i = 0; i < ImageItems.size(); i++ )
	{
		if( ImageItems[i].Path.compare( nPath ) == 0 )	// The first matching
		{
			return SDL_ConvertSurface( ImageItems[i].Item, ImageItems[i].Item->format, ImageItems[i].Item->flags );
		}
	}

	return NULL; // not found
}

string cImageManager :: GetPath( SDL_Surface *nItem )
{
	for(unsigned int i = 0; i < ImageItems.size(); i++)
	{
		if( ImageItems[i].Item == nItem )
		{
			return ImageItems[i].Path; // the first found
		}
	}

	return NULL; // not found
}

string cImageManager :: GetPath( unsigned int nId )
{
	if( Count >= nId ) 
	{
		for(unsigned int i = 0; i < ImageItems.size(); i++)
		{
			if( ImageItems[i].CountId == nId ) 
			{
				return ImageItems[i].Path;
			}
		}
	}
	
	return NULL; // not found
}

const char *cImageManager :: GetPathC( SDL_Surface *nItem )
{
	for(unsigned int i = 0; i < ImageItems.size(); i++)
	{
		if( ImageItems[i].Item == nItem )
		{
			return ImageItems[i].Path.c_str(); // the first found
		}
	}

	return NULL; // not found
}

const char *cImageManager :: GetPathC( unsigned int nId )
{
	if( Count >= nId ) 
	{
		for(unsigned int i = 0; i < ImageItems.size(); i++)
		{
			if( ImageItems[i].CountId == nId ) 
			{
				return ImageItems[i].Path.c_str();
			}
		}
	}
	
	return NULL; // not found
}

unsigned int cImageManager :: GetSize( void )
{
	return ImageItems.size();
}

void cImageManager :: Add( SDL_Surface *nItem, string nPath )
{
	Count++;

	ImageItem tItem;
	tItem.Item = nItem;
	tItem.Path = nPath;
	tItem.CountId = Count;

	ImageItems.push_back( tItem );
}

/**
 * Call this function to reload all images.
 *
 * step: 0 = complete reload
 *       1 = only delete bitmap surfaces
 *       2 = only load the bitmap surfaces
 */
void cImageManager :: ReloadImages( unsigned int step )
{
	if( step == 1 ) 
	{
		DeleteImages(  );
	}
	else if( step == 2 ) 
	{
		for( unsigned int i = 0; i < ImageItems.size(); i++ )
		{
			if( !ImageItems[i].Item && ImageItems[i].Path.length() > 4 ) 
			{
				SDL_Surface *temp = IMG_Load( ImageItems[i].Path.c_str() );
				if( temp )
				{
					ImageItems[i].Item = SDL_DisplayFormat( temp );
					SDL_FreeSurface( temp );
					SDL_SetColorKey( ImageItems[i].Item, SDL_SRCCOLORKEY | SDL_RLEACCEL, magenta );
				}
				else
				{
					printf( "Error loading file : %s\n", ImageItems[i].Path.c_str() );
				}
			}
		}
	}
	else if( !step ) 
	{
		ReloadImages( 1 );
		ReloadImages( 2 );
	}
}


/**
 * Free all bitmap surfaces, but keep ImageItems vector entries
 */
void cImageManager :: DeleteImages( void )
{
	for( unsigned int i = 0; i < ImageItems.size(); i++ )
	{
		if( ImageItems[i].Item ) 
		{
			SDL_FreeSurface( ImageItems[i].Item );
			ImageItems[i].Item = NULL;
		}
	}
}


/**
 * Delete all ImageItems completely.
 */
void cImageManager :: DeleteAll( void )
{
	for(unsigned int i = 0; i < ImageItems.size(); i++)
	{
		if( ImageItems[i].Item ) 
		{
			SDL_FreeSurface( ImageItems[i].Item );
			ImageItems[i].Item = NULL;
		}
	}

	ImageItems.clear();
}

