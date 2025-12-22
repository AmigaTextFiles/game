/*
THE COMPUTER CODE CONTAINED HEREIN IS THE SOLE PROPERTY OF PARALLAX
SOFTWARE CORPORATION ("PARALLAX").  PARALLAX, IN DISTRIBUTING THE CODE TO
END-USERS, AND SUBJECT TO ALL OF THE TERMS AND CONDITIONS HEREIN, GRANTS A
ROYALTY-FREE, PERPETUAL LICENSE TO SUCH END-USERS FOR USE BY SUCH END-USERS
IN USING, DISPLAYING,  AND CREATING DERIVATIVE WORKS THEREOF, SO LONG AS
SUCH USE, DISPLAY OR CREATION IS FOR NON-COMMERCIAL, ROYALTY OR REVENUE
FREE PURPOSES.  IN NO EVENT SHALL THE END-USER USE THE COMPUTER CODE
CONTAINED HEREIN FOR REVENUE-BEARING PURPOSES.  THE END-USER UNDERSTANDS
AND AGREES TO THE TERMS HEREIN AND ACCEPTS THE SAME BY USE OF THIS FILE.  
COPYRIGHT 1993-1998 PARALLAX SOFTWARE CORPORATION.  ALL RIGHTS RESERVED.
*/
/*
 * $Source: /usr/CVS/descent/main/texmerge.c,v $
 * $Revision: 1.5 $
 * $Author: nobody $
 * $Date: 1998/09/26 15:11:54 $
 * 
 * Routines to cache merged textures.
 * 
 * $Log: texmerge.c,v $
 * Revision 1.5  1998/09/26 15:11:54  nobody
 * Added Warp3D support
 *
 * Revision 1.4  1998/03/22 15:41:05  hfrieden
 * conflict resolved
 *
 * Revision 1.3  1998/03/22 15:26:38  tfrieden
 * removed lots of warning messages
 *
 * Revision 1.2  1998/03/22 01:53:30  tfrieden
 * Removed silly least_recently_used = 0
 *
 * Revision 1.1.1.1  1998/03/03 15:12:31  nobody
 * reimport after crash from backup
 *
 * Revision 1.1.1.1  1998/02/13  20:20:58  hfrieden
 * Initial Import
 */

#pragma off (unreferenced)
static char rcsid[] = "$Id: texmerge.c,v 1.5 1998/09/26 15:11:54 nobody Exp $";
#pragma on (unreferenced)

#include <stdlib.h>
#include <stdio.h>

#include "gr.h"
#include "error.h"
#include "game.h"
#include "textures.h"
#include "mono.h"
#include "rle.h"
#include "piggy.h"

#ifdef VIRGIN
#include "VirgeTexture.h"
#include "gauges.h"
#endif

#define MAX_NUM_CACHE_BITMAPS 50

#ifdef DEBUG_PROFILE
extern fix profile_mtn_time;
extern fix profile_mtsx_time;
extern int profile_mtn_called;
extern int profile_mtsx_called;
#endif

//static grs_bitmap * cache_bitmaps[MAX_NUM_CACHE_BITMAPS];                     

typedef struct  {
	grs_bitmap * bitmap;
	grs_bitmap * bottom_bmp;
	grs_bitmap * top_bmp;
	int         orient;
	int     last_frame_used;
} TEXTURE_CACHE;

static TEXTURE_CACHE Cache[MAX_NUM_CACHE_BITMAPS];

static int num_cache_entries = 0;

static int cache_hits = 0;
static int cache_misses = 0;

void merge_textures_new( int type, grs_bitmap * bottom_bmp, grs_bitmap * top_bmp, ubyte * dest_data );
void merge_textures_super_xparent( int type, grs_bitmap * bottom_bmp, grs_bitmap * top_bmp, ubyte * dest_data );


void texmerge_close();

//----------------------------------------------------------------------

int texmerge_init(int num_cached_textures)
{
	int i;

	if ( num_cached_textures <= MAX_NUM_CACHE_BITMAPS )
		num_cache_entries = num_cached_textures;
	else
		num_cache_entries = MAX_NUM_CACHE_BITMAPS;
	
	for (i=0; i<num_cache_entries; i++ )    {
			// Make temp tmap for use when combining
		Cache[i].bitmap = gr_create_bitmap( 64, 64 );

		//if (get_selector( Cache[i].bitmap->bm_data, 64*64,  &Cache[i].bitmap->bm_selector))
		//  Error( "ERROR ALLOCATING CACHE BITMAP'S SELECTORS!!!!" );

		Cache[i].last_frame_used = -1;
		Cache[i].top_bmp = NULL;
		Cache[i].bottom_bmp = NULL;
		Cache[i].orient = -1;
	}
	atexit( texmerge_close );

	return 1;
}

void texmerge_flush()
{
	int i;

	for (i=0; i<num_cache_entries; i++ )    {
	#ifdef VIRGIN
		VirgeInvalidCacheEntry(Cache[i].bitmap);
	#endif
	#ifdef WARP3D
		WARP_InvalidCacheEntry(Cache[i].bitmap);
	#endif
		Cache[i].last_frame_used = -1;
		Cache[i].top_bmp = NULL;
		Cache[i].bottom_bmp = NULL;
		Cache[i].orient = -1;
	}
}


//-------------------------------------------------------------------------
void texmerge_close()
{
	int i;

	for (i=0; i<num_cache_entries; i++ )    {
		gr_free_bitmap( Cache[i].bitmap );
		Cache[i].bitmap = NULL;
	}
}

//--unused-- int info_printed = 0;

grs_bitmap * texmerge_get_cached_bitmap( int tmap_bottom, int tmap_top )
{
	grs_bitmap *bitmap_top, *bitmap_bottom;
	int i, orient;
	int lowest_frame_count;
	int least_recently_used;

//  if ( ((FrameCount % 1000)==0) && ((cache_hits+cache_misses)>0) && (!info_printed) ) {
//      mprintf( 0, "Texmap caching:  %d hits, %d misses. (Missed=%d%%)\n", cache_hits, cache_misses, (cache_misses*100)/(cache_hits+cache_misses)  );
//      info_printed = 1;
//  } else {
//      info_printed = 0;
//  }

	bitmap_top = &GameBitmaps[Textures[tmap_top&0x3FFF].index];
	bitmap_bottom = &GameBitmaps[Textures[tmap_bottom].index];
	
	orient = ((tmap_top&0xC000)>>14) & 3;

	least_recently_used = 0;
	lowest_frame_count = Cache[0].last_frame_used;
	
	for (i=0; i<num_cache_entries; i++ )    {
		if ( (Cache[i].last_frame_used > -1) && (Cache[i].top_bmp==bitmap_top) && (Cache[i].bottom_bmp==bitmap_bottom) && (Cache[i].orient==orient ))   {
			cache_hits++;
			Cache[i].last_frame_used = FrameCount;
			return Cache[i].bitmap;
		}   
		if ( Cache[i].last_frame_used < lowest_frame_count )    {
			lowest_frame_count = Cache[i].last_frame_used;
			least_recently_used = i;
		}
	}
	
	//---- Page out the LRU bitmap;
	cache_misses++;

	// Make sure the bitmaps are paged in...
#ifdef PIGGY_USE_PAGING
	piggy_page_flushed = 0;

	PIGGY_PAGE_IN(Textures[tmap_top&0x3FFF]);
	PIGGY_PAGE_IN(Textures[tmap_bottom]);
	if (piggy_page_flushed) {
		// If cache got flushed, re-read 'em.
		piggy_page_flushed = 0;
		PIGGY_PAGE_IN(Textures[tmap_top&0x3FFF]);
		PIGGY_PAGE_IN(Textures[tmap_bottom]);
	}
	Assert( piggy_page_flushed == 0 );
#endif

	if (bitmap_top->bm_flags & BM_FLAG_SUPER_TRANSPARENT)   {
		merge_textures_super_xparent( orient, bitmap_bottom, bitmap_top, Cache[least_recently_used].bitmap->bm_data );
		Cache[least_recently_used].bitmap->bm_flags = BM_FLAG_TRANSPARENT;
		Cache[least_recently_used].bitmap->avg_color = bitmap_top->avg_color;
	} else  {
		merge_textures_new( orient, bitmap_bottom, bitmap_top, Cache[least_recently_used].bitmap->bm_data );
		Cache[least_recently_used].bitmap->bm_flags = bitmap_bottom->bm_flags & (~BM_FLAG_RLE);
		Cache[least_recently_used].bitmap->avg_color = bitmap_bottom->avg_color;
	}
		
	Cache[least_recently_used].top_bmp = bitmap_top;
	Cache[least_recently_used].bottom_bmp = bitmap_bottom;
	Cache[least_recently_used].last_frame_used = FrameCount;
	Cache[least_recently_used].orient = orient;
#ifdef VIRGIN
	VirgeInvalidCacheEntry(Cache[least_recently_used].bitmap);
#endif
#ifdef WARP3D
	WARP_InvalidCacheEntry(Cache[least_recently_used].bitmap);
#endif
	return Cache[least_recently_used].bitmap;
}

void merge_textures_new( int type, grs_bitmap * bottom_bmp, grs_bitmap * top_bmp, ubyte * dest_data )
{
	ubyte c;
	int x,y;
	ubyte * top_data, *bottom_data;
#ifdef DEBUG_PROFILE
	fix start_time = timer_get_fixed_seconds();
	profile_mtn_called++;
#endif

	if ( top_bmp->bm_flags & BM_FLAG_RLE )
		top_bmp = rle_expand_texture(top_bmp);

	if ( bottom_bmp->bm_flags & BM_FLAG_RLE )
		bottom_bmp = rle_expand_texture(bottom_bmp);

//  Assert( bottom_bmp != top_bmp );

	top_data = top_bmp->bm_data;
	bottom_data = bottom_bmp->bm_data;

//  Assert( bottom_data != top_data );

	// mprintf( 0, "Type=%d\n", type );

	switch( type )  {
		case 0:
			// Normal
			// gr_merge_textures( bottom_data, top_data, dest_data );
			for (y=0;y<64;y++) for (x=0;x<64;x++) {
				c=top_data[64*y+x];
				if (c==TRANSPARENCY_COLOR)
					c=bottom_data[64*y+x];
				*dest_data++=c;
			}
			break;
		case 1:
			// gr_merge_textures_1( bottom_data, top_data, dest_data );

			for (y=0; y<64; y++ )
				for (x=0; x<64; x++ )   {
					c = top_data[ 64*x+(63-y) ];        
					if (c==TRANSPARENCY_COLOR)
						c = bottom_data[ 64*y+x ];
					*dest_data++ = c;
				}
			break;
		case 2:
			// gr_merge_textures_2( bottom_data, top_data, dest_data );
			for (y=0; y<64; y++ )
				for (x=0; x<64; x++ )   {
					c = top_data[ 64*(63-y)+(63-x) ];
					if (c==TRANSPARENCY_COLOR)
						c = bottom_data[ 64*y+x ];
					*dest_data++ = c;
				}
			break;
		case 3:
			// gr_merge_textures_3( bottom_data, top_data, dest_data );
			for (y=0; y<64; y++ )
				for (x=0; x<64; x++ )   {
					c = top_data[ 64*(63-x)+y  ];
					if (c==TRANSPARENCY_COLOR)
						c = bottom_data[ 64*y+x ];
					*dest_data++ = c;
				}
			break;
	}

#ifdef DEBUG_PROFILE
	profile_mtn_time += timer_get_fixed_seconds() - start_time;
#endif

}

void merge_textures_super_xparent( int type, grs_bitmap * bottom_bmp, grs_bitmap * top_bmp, ubyte * dest_data )
{
	ubyte c;
	int x,y;
	ubyte * top_data, *bottom_data;
#ifdef DEBUG_PROFILE
	fix start_time = timer_get_fixed_seconds();
	profile_mtsx_called++;
#endif


	if ( top_bmp->bm_flags & BM_FLAG_RLE )
		top_bmp = rle_expand_texture(top_bmp);

	if ( bottom_bmp->bm_flags & BM_FLAG_RLE )
		bottom_bmp = rle_expand_texture(bottom_bmp);

//  Assert( bottom_bmp != top_bmp );

	top_data = top_bmp->bm_data;
	bottom_data = bottom_bmp->bm_data;

//  Assert( bottom_data != top_data );

	//mprintf( 0, "SuperX remapping type=%d\n", type );
	//Int3();
	 
	switch( type )  {
		case 0:
			// Normal
			for (y=0; y<64; y++ )
				for (x=0; x<64; x++ )   {
					c = top_data[ 64*y+x ];     
					if (c==TRANSPARENCY_COLOR)
						c = bottom_data[ 64*y+x ];
					else if (c==254)
						c = TRANSPARENCY_COLOR;
					*dest_data++ = c;
				}
			break;
		case 1:
			// 
			for (y=0; y<64; y++ )
				for (x=0; x<64; x++ )   {
					c = top_data[ 64*x+(63-y) ];        
					if (c==TRANSPARENCY_COLOR)
						c = bottom_data[ 64*y+x ];
					else if (c==254)
						c = TRANSPARENCY_COLOR;
					*dest_data++ = c;
				}
			break;
		case 2:
			// Normal
			for (y=0; y<64; y++ )
				for (x=0; x<64; x++ )   {
					c = top_data[ 64*(63-y)+(63-x) ];
					if (c==TRANSPARENCY_COLOR)
						c = bottom_data[ 64*y+x ];
					else if (c==254)
						c = TRANSPARENCY_COLOR;
					*dest_data++ = c;
				}
			break;
		case 3:
			// Normal
			for (y=0; y<64; y++ )
				for (x=0; x<64; x++ )   {
					c = top_data[ 64*(63-x)+y  ];
					if (c==TRANSPARENCY_COLOR)
						c = bottom_data[ 64*y+x ];
					else if (c==254)
						c = TRANSPARENCY_COLOR;
					*dest_data++ = c;
				}
			break;
	}

#ifdef DEBUG_PROFILE
	profile_mtsx_time += timer_get_fixed_seconds() - start_time;
#endif

}
