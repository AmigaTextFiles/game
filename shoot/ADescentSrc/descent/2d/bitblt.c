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
#include "gr.h"
#include "grdef.h"
#include "error.h"
#include <stdio.h>
#include "byteswap.h"
int gr_bitblt_dest_step_shift = 0;
int gr_bitblt_double = 0;
ubyte *gr_bitblt_fade_table=NULL;

#ifdef VIRGIN
#include <exec/types.h>
#include "VirgeTexture.h"
extern UWORD BitValues[256];

//extern void gr_direct_linear_rep_movsdm(ubyte *src __asm("a0"), UWORD *dest __asm("a1"), uint num_pixels __asm("d0"));
//extern void gr_direct_linear_movsd(ubyte *src __asm("a0"), UWORD *dest __asm("a1"), int num_pixels __asm("d0"));


#endif

#ifdef WARP3D
#include "Warp3D.h"
#endif

#define THRESHOLD   8

#ifdef DEBUG_PROFILE
#include "fix.h"
#include "timer.h"
extern fix profile_glrm_time;
extern fix profile_glrmf_time;
extern int profile_glrm_called;
extern int profile_glrmf_called;
#endif

void gr_linear_movsd(ubyte * src, ubyte * dest, uint num_pixels )   
{
	int i;

	memcpy((void *)dest, (void *)src, num_pixels);
}

#if defined(VIRGIN) || defined(WARP3D)
void gr_direct_linear_movsd(ubyte * src, UWORD * dest, uint num_pixels )
{
	int i;

	for (i=0; i<num_pixels; i++)
		*dest++=BitValues[*src++];

}
#endif

void gr_linear_movsd_double(ubyte *src, ubyte *dest, int num_pixels)
{
	int i;


	for (i=0; i<num_pixels; i++) {
		*dest++ = *src;
		*dest++ = *src++;
	}
}

void gr_linear_rep_movsdm(ubyte * src, ubyte * dest, int num_pixels )
{
	int i;
#ifdef DEBUG_PROFILE
	fix start_time = timer_get_fixed_seconds();
	profile_glrm_called++;
#endif


	for (i=0; i<num_pixels; i++ )   {
		if (*src != TRANSPARENCY_COLOR )
			*dest = *src;
		dest++;
		src++;  
	}
#ifdef DEBUG_PROFILE
	profile_glrm_time += timer_get_fixed_seconds() - start_time;
#endif

}

void gr_linear_rep_movsdm_faded(ubyte * src, ubyte * dest, uint num_pixels, ubyte fade_value )  
{
	int i;
	ubyte source;
	ubyte *fade_base;
#ifdef DEBUG_PROFILE
	fix start_time = timer_get_fixed_seconds();
	profile_glrmf_called ++;
#endif
	
	fade_base = gr_fade_table + (fade_value * 256);
	
	for (i=num_pixels; i != 0; i-- )
	{
		source = *src;
		if (source != (ubyte)TRANSPARENCY_COLOR )
			*dest = *(fade_base + source);
		dest++;
		src++;  
	}
#ifdef DEBUG_PROFILE
	profile_glrmf_time += timer_get_fixed_seconds() - start_time;
#endif

}

#if defined(VIRGIN) || defined(WARP3D)
void gr_direct_linear_rep_movsdm(ubyte * src, UWORD * dest, int num_pixels )
{
	int i;

	for (i=0; i<num_pixels; i++ )   {
		if (*src != TRANSPARENCY_COLOR )
			*dest = BitValues[*src];
		dest++;
		src++;
	}
}

void gr_direct_linear_rep_movsdm_faded(ubyte * src, UWORD * dest, uint num_pixels, ubyte fade_value )
{
	int i;
	ubyte source;
	ubyte *fade_base;


	fade_base = gr_fade_table + (fade_value * 256);

	for (i=num_pixels; i != 0; i-- )
	{
		source = *src;
		if (source != (ubyte)TRANSPARENCY_COLOR )
			*dest = BitValues[*(fade_base + source)];
		dest++;
		src++;
	}

}
#endif

void gr_bm_ubitblt_rle(int w, int h, int dx, int dy, int sx, int sy, grs_bitmap * src, grs_bitmap * dest)
{
	unsigned char * dbits;
	unsigned char * sbits;

	int i;

#ifdef BLT_DEBUG
	fprintf(stderr, "gr_bm_ubitblt_rle\n");
#endif

	sbits = &src->bm_data[4 + src->bm_h];
	for (i=0; i<sy; i++ )
		sbits += (int)src->bm_data[4+i];

	dbits = dest->bm_data + (dest->bm_rowsize * dy) + dx;

	// No interlacing, copy the whole buffer.
	for (i=0; i < h; i++ )    {
		gr_rle_expand_scanline( dbits, sbits, sx, sx+w-1 );
		sbits += (int)src->bm_data[4+i+sy];
		dbits += dest->bm_rowsize << gr_bitblt_dest_step_shift;
	}
}

#ifdef VIRGIN
extern void gr_direct_rle_expand_scanline(UWORD *, char *, int, int);
void gr_direct_bm_ubitblt_rle(int w, int h, int dx, int dy, int sx, int sy, grs_bitmap * src, grs_bitmap * dest)
{
	UWORD * dbits;
	unsigned char * sbits;
	extern int VirgePixelsPerRow;
	extern UWORD BitValues[256];
	UWORD *RenderBuffer = VirgeGetBuffer();

	int i;


	sbits = &src->bm_data[4 + src->bm_h];
	for (i=0; i<sy; i++ )
		sbits += (int)src->bm_data[4+i];

	dbits = RenderBuffer + VirgePixelsPerRow*dy+dx;
	//dbits = dest->bm_data + (dest->bm_rowsize * dy) + dx;

	// No interlacing, copy the whole buffer.
	for (i=0; i < h; i++ )    {
		gr_direct_rle_expand_scanline( dbits, sbits, sx, sx+w-1 );
		sbits += (int)src->bm_data[4+i+sy];
		dbits += VirgePixelsPerRow; //dest->bm_rowsize << gr_bitblt_dest_step_shift;
	}
}
#endif

#ifdef WARP3D
extern void gr_direct_rle_expand_scanline(UWORD *, char *, int, int);
void gr_direct_bm_ubitblt_rle(int w, int h, int dx, int dy, int sx, int sy, grs_bitmap * src, grs_bitmap * dest)
{
	UWORD * dbits;
	unsigned char * sbits;
	UWORD *RenderBuffer = WARP_GetBufferAddress();

	int i;


	sbits = &src->bm_data[4 + src->bm_h];
	for (i=0; i<sy; i++ )
		sbits += (int)src->bm_data[4+i];

	dbits = RenderBuffer + VirgePixelsPerRow*dy+dx;
	//dbits = dest->bm_data + (dest->bm_rowsize * dy) + dx;

	// No interlacing, copy the whole buffer.
	for (i=0; i < h; i++ )    {
		gr_direct_rle_expand_scanline( dbits, sbits, sx, sx+w-1 );
		sbits += (int)src->bm_data[4+i+sy];
		dbits += VirgePixelsPerRow; //dest->bm_rowsize << gr_bitblt_dest_step_shift;
	}
}
#endif

void gr_bitblt_cockpit_dead_code(grs_bitmap *bm)
{
	unsigned char *dbits;
	unsigned char *sbits;
	int i, h, w;
	ushort s;
	
	w = bm->bm_w;
	h = bm->bm_h;
	sbits = &bm->bm_data[4 + (2 * h)];          // integer size at beginning of bitmap
	dbits = grd_curcanv->cv_bitmap.bm_data;

	for (i = 0; i < h; i++) {
		gr_rle_expand_scanline( dbits, sbits, 0, w-1 );
		s = swapshort(*((short *)&(bm->bm_data[4+(i*2)]))); // *endian*
		sbits += (int)s;
		dbits += (int)grd_curcanv->cv_bitmap.bm_rowsize;
	}
}

void gr_bm_ubitbltm_rle(int w, int h, int dx, int dy, int sx, int sy, grs_bitmap * src, grs_bitmap * dest)
{
	unsigned char * dbits;
	unsigned char * sbits;

	int i;

	sbits = &src->bm_data[4 + src->bm_h];
	for (i=0; i<sy; i++ )
		sbits += (int)src->bm_data[4+i];

	dbits = dest->bm_data + (dest->bm_rowsize * dy) + dx;

	// No interlacing, copy the whole buffer.
	for (i=0; i < h; i++ )    {
		gr_rle_expand_scanline_masked( dbits, sbits, sx, sx+w-1 );
		sbits += (int)src->bm_data[4+i+sy];
		dbits += dest->bm_rowsize << gr_bitblt_dest_step_shift;
	}
}

#ifdef VIRGIN

extern gr_direct_rle_expand_scanline_masked(UWORD *, char *, int, int);
void gr_direct_bm_ubitbltm_rle(int w, int h, int dx, int dy, int sx, int sy, grs_bitmap * src, grs_bitmap * dest)
{
	UWORD * dbits;
	unsigned char * sbits;
	extern int VirgePixelsPerRow;
	extern UWORD BitValues[256];
	UWORD *RenderBuffer = VirgeGetBuffer();
	int i;

	sbits = &src->bm_data[4 + src->bm_h];
	for (i=0; i<sy; i++ )
		sbits += (int)src->bm_data[4+i];

	dbits = RenderBuffer + VirgePixelsPerRow*dy+dx;
	//dest->bm_data + (dest->bm_rowsize * dy) + dx;

	// No interlacing, copy the whole buffer.
	for (i=0; i < h; i++ )    {   // Modify for direct
		gr_direct_rle_expand_scanline_masked( dbits, sbits, sx, sx+w-1 );
		sbits += (int)src->bm_data[4+i+sy];
		dbits += VirgePixelsPerRow;//dest->bm_rowsize << gr_bitblt_dest_step_shift;
	}
}
#endif

#ifdef WARP3D
extern gr_direct_rle_expand_scanline_masked(UWORD *, char *, int, int);
void gr_direct_bm_ubitbltm_rle(int w, int h, int dx, int dy, int sx, int sy, grs_bitmap * src, grs_bitmap * dest)
{
	UWORD * dbits;
	unsigned char * sbits;
	UWORD *RenderBuffer = WARP_GetBufferAddress();
	int i;

	sbits = &src->bm_data[4 + src->bm_h];
	for (i=0; i<sy; i++ )
		sbits += (int)src->bm_data[4+i];

	dbits = RenderBuffer + VirgePixelsPerRow*dy+dx;
	//dest->bm_data + (dest->bm_rowsize * dy) + dx;

	// No interlacing, copy the whole buffer.
	for (i=0; i < h; i++ )    {   // Modify for direct
		gr_direct_rle_expand_scanline_masked( dbits, sbits, sx, sx+w-1 );
		sbits += (int)src->bm_data[4+i+sy];
		dbits += VirgePixelsPerRow;//dest->bm_rowsize << gr_bitblt_dest_step_shift;
	}
}
#endif


void gr_ubitmap( int x, int y, grs_bitmap *bm )
{
	register int y1;
	int dest_rowsize;

	unsigned char * dest;
	unsigned char * src;
#ifdef BLT_DEBUG
	fprintf(stderr, "gr_ubitmap\n");
#endif

	if ( bm->bm_flags & BM_FLAG_RLE )   {
		gr_bm_ubitblt_rle(bm->bm_w, bm->bm_h, x, y, 0, 0, bm, &grd_curcanv->cv_bitmap );
		return;
	}

	dest_rowsize=grd_curcanv->cv_bitmap.bm_rowsize << gr_bitblt_dest_step_shift;
	dest = &(grd_curcanv->cv_bitmap.bm_data[ dest_rowsize*y+x ]);

	src = bm->bm_data;

	for (y1=0; y1 < bm->bm_h; y1++ )    {
		gr_linear_movsd( src, dest, bm->bm_w );
		src += bm->bm_rowsize;
		dest+= (int)(dest_rowsize);
	}
}

void gr_ubitmapm( int x, int y, grs_bitmap *bm )
{
	register int y1;
	int dest_rowsize;

	unsigned char * dest;
	unsigned char * src;
#ifdef BLT_DEBUG
	fprintf(stderr, "gr_ubitmapm\n");
#endif

	if ( bm->bm_flags & BM_FLAG_RLE )   {
		gr_bm_ubitbltm_rle(bm->bm_w, bm->bm_h, x, y, 0, 0, bm, &grd_curcanv->cv_bitmap );
		return;
	}

	dest_rowsize=grd_curcanv->cv_bitmap.bm_rowsize << gr_bitblt_dest_step_shift;
	dest = &(grd_curcanv->cv_bitmap.bm_data[ dest_rowsize*y+x ]);

	src = bm->bm_data;

	if (gr_bitblt_fade_table==NULL) {
		for (y1=0; y1 < bm->bm_h; y1++ )    {
			gr_linear_rep_movsdm( src, dest, bm->bm_w );
			src += bm->bm_rowsize;
			dest+= (int)(dest_rowsize);
		}
	} else {
		for (y1=0; y1 < bm->bm_h; y1++ )    {
			gr_linear_rep_movsdm_faded( src, dest, bm->bm_w, gr_bitblt_fade_table[y1+y] );
			src += bm->bm_rowsize;
			dest+= (int)(dest_rowsize);
		}
	}
}

#if defined(VIRGIN) || defined(WARP3D)
void gr_direct_ubitmapm( int x, int y, grs_bitmap *bm )
{
	register int y1;
	int dest_rowsize;

	UWORD * dest;
	unsigned char * src;

#ifdef VIRGIN
	extern int VirgePixelsPerRow;
	extern UWORD BitValues[256];
#endif
	UWORD *RenderBuffer = VirgeGetBuffer();

	if ( bm->bm_flags & BM_FLAG_RLE )   {
		gr_direct_bm_ubitbltm_rle(bm->bm_w, bm->bm_h, x, y, 0, 0, bm, &grd_curcanv->cv_bitmap );
		return;
	}

	//dest_rowsize=grd_curcanv->cv_bitmap.bm_rowsize << gr_bitblt_dest_step_shift;
	dest = RenderBuffer+VirgePixelsPerRow*y+x;
		//&(grd_curcanv->cv_bitmap.bm_data[ dest_rowsize*y+x ]);

	src = bm->bm_data;

	if (gr_bitblt_fade_table==NULL) {
		for (y1=0; y1 < bm->bm_h; y1++ )    {
			gr_direct_linear_rep_movsdm( src, dest, bm->bm_w );
			src += bm->bm_rowsize;
			dest+= VirgePixelsPerRow;//(int)(dest_rowsize);
		}
	} else {
		for (y1=0; y1 < bm->bm_h; y1++ )    {
			gr_direct_linear_rep_movsdm_faded( src, dest, bm->bm_w, gr_bitblt_fade_table[y1+y] );
			src += bm->bm_rowsize;
			dest+= VirgePixelsPerRow;//(int)(dest_rowsize);
		}
	}
}
#endif

extern void BlitLargeAlign(ubyte *draw_buffer, int dstRowBytes, ubyte *dstPtr, int w, int h, int modulus);

void gr_bm_ubitblt_double(int w, int h, int dx, int dy, int sx, int sy, grs_bitmap *src, grs_bitmap *dest)
{
	ubyte * dbits;
	ubyte * sbits;
	int dstep, i;
#ifdef BLT_DEBUG
	fprintf(stderr, "gr_bm_ubitblt_double\n");
#endif


	sbits = src->bm_data  + (src->bm_rowsize * sy) + sx;
	dbits = dest->bm_data + (dest->bm_rowsize * dy) + dx;
	dstep = dest->bm_rowsize << gr_bitblt_dest_step_shift;
	for (i=0; i < h; i++ )    {
		gr_linear_movsd_double(sbits, dbits, w);
		dbits += dstep;
		gr_linear_movsd_double(sbits, dbits, w);
		dbits += dstep;
		sbits += src->bm_rowsize;
	}
}

// From Linear to Linear
void gr_bm_ubitblt(int w, int h, int dx, int dy, int sx, int sy, grs_bitmap * src, grs_bitmap * dest)
{
	unsigned char * dbits;
	unsigned char * sbits;
	//int   src_bm_rowsize_2, dest_bm_rowsize_2;
	int dstep;

	int i;
#ifdef BLT_DEBUG
	fprintf(stderr, "gr_bm_ubitblt\n");
#endif

	if ( src->bm_flags & BM_FLAG_RLE )  {
		gr_bm_ubitblt_rle( w, h, dx, dy, sx, sy, src, dest );
		return ;
	}

	sbits =   src->bm_data  + (src->bm_rowsize * sy) + sx;
	dbits =   dest->bm_data + (dest->bm_rowsize * dy) + dx;

	dstep = dest->bm_rowsize << gr_bitblt_dest_step_shift;

	// No interlacing, copy the whole buffer.
	for (i=0; i < h; i++ )    {
		gr_linear_movsd( sbits, dbits, w );
		sbits += src->bm_rowsize;
		dbits += dstep;
	}
}

#ifdef VIRGIN
// From Linear to Linear
void gr_direct_bm_ubitblt(int w, int h, int dx, int dy, int sx, int sy, grs_bitmap * src, grs_bitmap * dest)
{
	unsigned char * dbits;
	UWORD * sbits;
	//int   src_bm_rowsize_2, dest_bm_rowsize_2;
	int dstep;
	extern int VirgePixelsPerRow;
	extern UWORD BitValues[256];
	UWORD *RenderBuffer = VirgeGetBuffer();

	int i;

	if ( src->bm_flags & BM_FLAG_RLE )  {
		gr_direct_bm_ubitblt_rle( w, h, dx, dy, sx, sy, src, dest );
		return ;
	}

	sbits =   src->bm_data  + (src->bm_rowsize * sy) + sx;
	dbits =   RenderBuffer  +  VirgePixelsPerRow*dy+dx;

	dstep = dest->bm_rowsize << gr_bitblt_dest_step_shift;

	// No interlacing, copy the whole buffer.
	for (i=0; i < h; i++ )    {
		gr_direct_linear_movsd( sbits, dbits, w );
		sbits += src->bm_rowsize;
		dbits += VirgePixelsPerRow;
	}
}
#endif

#ifdef WARP3D
// From Linear to Linear
void gr_direct_bm_ubitblt(int w, int h, int dx, int dy, int sx, int sy, grs_bitmap * src, grs_bitmap * dest)
{
	unsigned char * dbits;
	UWORD * sbits;
	//int   src_bm_rowsize_2, dest_bm_rowsize_2;
	int dstep;
	UWORD *RenderBuffer = WARP_GetBufferAddress();

	int i;

	if ( src->bm_flags & BM_FLAG_RLE )  {
		gr_direct_bm_ubitblt_rle( w, h, dx, dy, sx, sy, src, dest );
		return ;
	}

	sbits =   src->bm_data  + (src->bm_rowsize * sy) + sx;
	dbits =   RenderBuffer  +  VirgePixelsPerRow*dy+dx;

	dstep = dest->bm_rowsize << gr_bitblt_dest_step_shift;

	// No interlacing, copy the whole buffer.
	for (i=0; i < h; i++ )    {
		gr_direct_linear_movsd( sbits, dbits, w );
		sbits += src->bm_rowsize;
		dbits += VirgePixelsPerRow;
	}
}
#endif


// From Linear to Linear Masked
void gr_bm_ubitbltm(int w, int h, int dx, int dy, int sx, int sy, grs_bitmap * src, grs_bitmap * dest)
{
	unsigned char * dbits;
	unsigned char * sbits;

	int i;

	sbits =   src->bm_data  + (src->bm_rowsize * sy) + sx;
	dbits =   dest->bm_data + (dest->bm_rowsize * dy) + dx;

	// No interlacing, copy the whole buffer.

	if (gr_bitblt_fade_table==NULL) {
		for (i=0; i < h; i++ )    {
			gr_linear_rep_movsdm( sbits, dbits, w );
			sbits += src->bm_rowsize;
			dbits += dest->bm_rowsize;
		}
	} else {
		for (i=0; i < h; i++ )    {
			gr_linear_rep_movsdm_faded( sbits, dbits, w, gr_bitblt_fade_table[dy+i] );
			sbits += src->bm_rowsize;
			dbits += dest->bm_rowsize;
		}
	}
}

#ifdef VIRGIN
void gr_direct_bm_ubitbltm(int w, int h, int dx, int dy, int sx, int sy, grs_bitmap * src, grs_bitmap * dest)
{
	unsigned char * dbits;
	unsigned char * sbits;
	extern int VirgePixelsPerRow;
	extern UWORD BitValues[256];
	UWORD *RenderBuffer = VirgeGetBuffer();

	int i;

	sbits =   src->bm_data  + (src->bm_rowsize * sy) + sx;
	//dbits =   dest->bm_data + (dest->bm_rowsize * dy) + dx;
	dbits = RenderBuffer + VirgePixelsPerRow*dy+dx;

	// No interlacing, copy the whole buffer.

	if (gr_bitblt_fade_table==NULL) {
		for (i=0; i < h; i++ )    {
			gr_direct_linear_rep_movsdm( sbits, dbits, w );
			sbits += src->bm_rowsize;
			dbits += dest->bm_rowsize;
		}
	} else {
		for (i=0; i < h; i++ )    {
			gr_direct_linear_rep_movsdm_faded( sbits, dbits, w, gr_bitblt_fade_table[dy+i] );
			sbits += src->bm_rowsize;
			dbits += dest->bm_rowsize;
		}
	}
}

#endif

#ifdef WARP3D
void gr_direct_bm_ubitbltm(int w, int h, int dx, int dy, int sx, int sy, grs_bitmap * src, grs_bitmap * dest)
{
	unsigned char * dbits;
	unsigned char * sbits;
	UWORD *RenderBuffer = WARP_GetBufferAddress();

	int i;

	sbits =   src->bm_data  + (src->bm_rowsize * sy) + sx;
	//dbits =   dest->bm_data + (dest->bm_rowsize * dy) + dx;
	dbits = RenderBuffer + VirgePixelsPerRow*dy+dx;

	// No interlacing, copy the whole buffer.

	if (gr_bitblt_fade_table==NULL) {
		for (i=0; i < h; i++ )    {
			gr_direct_linear_rep_movsdm( sbits, dbits, w );
			sbits += src->bm_rowsize;
			dbits += dest->bm_rowsize;
		}
	} else {
		for (i=0; i < h; i++ )    {
			gr_direct_linear_rep_movsdm_faded( sbits, dbits, w, gr_bitblt_fade_table[dy+i] );
			sbits += src->bm_rowsize;
			dbits += dest->bm_rowsize;
		}
	}
}

#endif


void gr_bm_bitblt(int w, int h, int dx, int dy, int sx, int sy, grs_bitmap * src, grs_bitmap * dest)
{
	int dx1=dx, dx2=dx+dest->bm_w-1;
	int dy1=dy, dy2=dy+dest->bm_h-1;

	int sx1=sx, sx2=sx+src->bm_w-1;
	int sy1=sy, sy2=sy+src->bm_h-1;
#ifdef BLT_DEBUG
	fprintf(stderr, "gr_bm_bitblt\n");
#endif

	if ((dx1 >= dest->bm_w ) || (dx2 < 0)) return;
	if ((dy1 >= dest->bm_h ) || (dy2 < 0)) return;
	if ( dx1 < 0 ) { sx1 += -dx1; dx1 = 0; }
	if ( dy1 < 0 ) { sy1 += -dy1; dy1 = 0; }
	if ( dx2 >= dest->bm_w )    { dx2 = dest->bm_w-1; }
	if ( dy2 >= dest->bm_h )    { dy2 = dest->bm_h-1; }

	if ((sx1 >= src->bm_w ) || (sx2 < 0)) return;
	if ((sy1 >= src->bm_h ) || (sy2 < 0)) return;
	if ( sx1 < 0 ) { dx1 += -sx1; sx1 = 0; }
	if ( sy1 < 0 ) { dy1 += -sy1; sy1 = 0; }
	if ( sx2 >= src->bm_w ) { sx2 = src->bm_w-1; }
	if ( sy2 >= src->bm_h ) { sy2 = src->bm_h-1; }

	// Draw bitmap bm[x,y] into (dx1,dy1)-(dx2,dy2)
	if ( dx2-dx1+1 < w )
		w = dx2-dx1+1;
	if ( dy2-dy1+1 < h )
		h = dy2-dy1+1;
	if ( sx2-sx1+1 < w )
		w = sx2-sx1+1;
	if ( sy2-sy1+1 < h )
		h = sy2-sy1+1;

	gr_bm_ubitblt(w,h, dx1, dy1, sx1, sy1, src, dest );
}


// Clipped bitmap ... 

void gr_bitmap( int x, int y, grs_bitmap *bm )
{
	int dx1=x, dx2=x+bm->bm_w-1;
	int dy1=y, dy2=y+bm->bm_h-1;
	int sx=0, sy=0;

#ifdef BLT_DEBUG
	fprintf(stderr, "gr_bitmap\n");
#endif

	if ((dx1 >= grd_curcanv->cv_bitmap.bm_w ) || (dx2 < 0)) return;
	if ((dy1 >= grd_curcanv->cv_bitmap.bm_h) || (dy2 < 0)) return;
	if ( dx1 < 0 ) { sx = -dx1; dx1 = 0; }
	if ( dy1 < 0 ) { sy = -dy1; dy1 = 0; }
	if ( dx2 >= grd_curcanv->cv_bitmap.bm_w )   { dx2 = grd_curcanv->cv_bitmap.bm_w-1; }
	if ( dy2 >= grd_curcanv->cv_bitmap.bm_h )   { dy2 = grd_curcanv->cv_bitmap.bm_h-1; }
		
	// Draw bitmap bm[x,y] into (dx1,dy1)-(dx2,dy2)

	gr_bm_ubitblt(dx2-dx1+1,dy2-dy1+1, dx1, dy1, sx, sy, bm, &grd_curcanv->cv_bitmap );

//    gr_update(NULL);
}

#if defined(VIRGIN) || defined(WARP3D)
void gr_direct_bitmap( int x, int y, grs_bitmap *bm )
{
	int dx1=x, dx2=x+bm->bm_w-1;
	int dy1=y, dy2=y+bm->bm_h-1;
	int sx=0, sy=0;

	if ((dx1 >= grd_curcanv->cv_bitmap.bm_w ) || (dx2 < 0)) return;
	if ((dy1 >= grd_curcanv->cv_bitmap.bm_h) || (dy2 < 0)) return;
	if ( dx1 < 0 ) { sx = -dx1; dx1 = 0; }
	if ( dy1 < 0 ) { sy = -dy1; dy1 = 0; }
	if ( dx2 >= grd_curcanv->cv_bitmap.bm_w )   { dx2 = grd_curcanv->cv_bitmap.bm_w-1; }
	if ( dy2 >= grd_curcanv->cv_bitmap.bm_h )   { dy2 = grd_curcanv->cv_bitmap.bm_h-1; }

	// Draw bitmap bm[x,y] into (dx1,dy1)-(dx2,dy2)

	gr_direct_bm_ubitblt(dx2-dx1+1,dy2-dy1+1, dx1, dy1, sx, sy, bm, &grd_curcanv->cv_bitmap );

//    gr_update(NULL);
}
#endif

void gr_bitmapm( int x, int y, grs_bitmap *bm )
{
	int dx1=x, dx2=x+bm->bm_w-1;
	int dy1=y, dy2=y+bm->bm_h-1;
	int sx=0, sy=0;

	if ((dx1 >= grd_curcanv->cv_bitmap.bm_w ) || (dx2 < 0)) return;
	if ((dy1 >= grd_curcanv->cv_bitmap.bm_h) || (dy2 < 0)) return;
	if ( dx1 < 0 ) { sx = -dx1; dx1 = 0; }
	if ( dy1 < 0 ) { sy = -dy1; dy1 = 0; }
	if ( dx2 >= grd_curcanv->cv_bitmap.bm_w )   { dx2 = grd_curcanv->cv_bitmap.bm_w-1; }
	if ( dy2 >= grd_curcanv->cv_bitmap.bm_h )   { dy2 = grd_curcanv->cv_bitmap.bm_h-1; }
		
	// Draw bitmap bm[x,y] into (dx1,dy1)-(dx2,dy2)
	if ( bm->bm_flags & BM_FLAG_RLE )   
		gr_bm_ubitbltm_rle(dx2-dx1+1,dy2-dy1+1, dx1, dy1, sx, sy, bm, &grd_curcanv->cv_bitmap );
	else
		gr_bm_ubitbltm(dx2-dx1+1,dy2-dy1+1, dx1, dy1, sx, sy, bm, &grd_curcanv->cv_bitmap );

//    gr_update(NULL);
}

#if defined(WARP3D) || defined(VIRGIN)
void gr_direct_bitmapm( int x, int y, grs_bitmap *bm )
{
	int dx1=x, dx2=x+bm->bm_w-1;
	int dy1=y, dy2=y+bm->bm_h-1;
	int sx=0, sy=0;

	if ((dx1 >= grd_curcanv->cv_bitmap.bm_w ) || (dx2 < 0)) return;
	if ((dy1 >= grd_curcanv->cv_bitmap.bm_h) || (dy2 < 0)) return;
	if ( dx1 < 0 ) { sx = -dx1; dx1 = 0; }
	if ( dy1 < 0 ) { sy = -dy1; dy1 = 0; }
	if ( dx2 >= grd_curcanv->cv_bitmap.bm_w )   { dx2 = grd_curcanv->cv_bitmap.bm_w-1; }
	if ( dy2 >= grd_curcanv->cv_bitmap.bm_h )   { dy2 = grd_curcanv->cv_bitmap.bm_h-1; }

	// Draw bitmap bm[x,y] into (dx1,dy1)-(dx2,dy2)
	if ( bm->bm_flags & BM_FLAG_RLE )
		gr_direct_bm_ubitbltm_rle(dx2-dx1+1,dy2-dy1+1, dx1, dy1, sx, sy, bm, &grd_curcanv->cv_bitmap );
	else
		gr_direct_bm_ubitbltm(dx2-dx1+1,dy2-dy1+1, dx1, dy1, sx, sy, bm, &grd_curcanv->cv_bitmap );

//    gr_update(NULL);
}
#endif
