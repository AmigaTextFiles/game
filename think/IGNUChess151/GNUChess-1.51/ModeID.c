/************************************************************************/
/*																		*/
/* ULONG ModeID( char * )												*/
/*																		*/
/* Returns the display mode identifier of a	given monitor:mode name.	*/
/* E.g. ModeID( "NTSC:HighRes Lace" ) resolves to 0x00019004.			*/
/*																		*/
/************************************************************************/

#include <graphics/displayinfo.h>

#include <proto/graphics.h>

#include <string.h>

ULONG ModeID( char *name )
{
	ULONG				id	= INVALID_ID;
	DisplayInfoHandle	dih;
	struct NameInfo		ni;

	while ( ( id = NextDisplayInfo( id ) ) != INVALID_ID ) {
		if ( ! ModeNotAvailable( id ) ) {
			if ( dih = FindDisplayInfo( id ) ) {
				if ( GetDisplayInfoData( dih, (UBYTE *) &ni, sizeof( struct NameInfo ), DTAG_NAME, 0 ) ) {
					if ( ! stricmp( name, ni.Name ) ) {
						break;
					}
				}
			}
		}
	}
	return id;
}
