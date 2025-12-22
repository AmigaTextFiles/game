#include "types.h"

#define		TRANSPARENT_IDX		0x00

static int screenwidth = 16;
static int screenheight = 16;

// This seems OK...
void putsprite(int x, int y, s_sprite *frame, s_screen *screen){

	int width, height;

	unsigned char *dest_c;

	int start_x, start_y, new_width, _x, _y;

	// Get screen size
	screenwidth = screen->width;
	screenheight = screen->height;

	dest_c = (void*)screen->data;

	// Adjust coords for centering
	x -= frame->centerx;
	y -= frame->centery;


	// Get sprite dimensions
	width = frame->width;
	height = frame->height;

    if (x + width < 0 )
    {
        //printf("<x\n");
        return;
    }

    if (x > screenwidth )
    {
        //printf(">x\n");
        return;
    }

	// Check if sprite dimensions are valid
	if(width<=0 || height<=0) return;

    start_x = 0; start_y = 0;

	//printf("Sprite %d, %d - %dx%d -> ", x, y, width, height);

	// Check clipping, vertical first
	if(y < 0){
		// Clip top
		height += y;		// Make sprite shorter
		if(height <=0 ) return;
        start_y -= y;
		y = 0;
	}

	if(y+height > screenheight){
		// Clip bottom (make sprite shorter)
		height = screenheight - y;
		if(height <= 0) return;
	}

	new_width = width;

	if(x < 0){
		// Clip left
        start_x -= x;
        x = 0;
        new_width -= start_x;
    }

	if(x + new_width > screenwidth){
		// Clip right
        new_width = screenwidth - x;
	}

    //printf("%d %d %d %d\n", x, y, width, height);


    //printf("%d(%d)...%d, %d(%d)...%d\n", x, start_x, new_width, y, start_y, height);

    for ( _y = 0; _y < height; _y++ )
    {
		char* src;

		dest_c = (char*)screen->data + (y + _y) * screenwidth + x;

		src = (char*)frame->data + (start_y + _y) * width + start_x;

        for ( _x = 0; _x < new_width; _x++, dest_c++, src++ )
        {
            if ( *src != TRANSPARENT_IDX )
            	*dest_c = *src;
        }
    }
}



unsigned int fakey_encodesprite(s_bitmap *bitmap)
{
    return ( 32 + bitmap->width * bitmap->height );
}


// To know size of sprite without actually creating one
/*unsigned int fakey_encodesprite(s_bitmap *bitmap){
	unsigned int width, height, s, d;
	unsigned int vispix, xpos, ypos, pos;

	if(bitmap->width <= 0 || bitmap->height <= 0){
		// Image is empty (or bad), return size of empty sprite
		return 8*4;
	}

	width = bitmap->width;
	height = bitmap->height;

	xpos=0;
	ypos=0;

	s = 0;			// Source pixels start pos
	d = 16+(height<<2);	// Destination pixels start pos

ctn:
	while(ypos<height){
		while(bitmap->data[s]==TRANSPARENT_IDX){
			++s;
			++xpos;
			if(xpos==width){
				d += 8;
				xpos = 0;
				++ypos;
				goto ctn;		// Re-enter loop
			}
		}

		d+=4;

		pos = s;
		vispix = 0;

		while(bitmap->data[pos]!=TRANSPARENT_IDX && xpos<width){
			++vispix;
			++xpos;
			++pos;
		}
		d+=4;

		d += vispix;
		s += vispix;

		// Add alignment
		while(d&3) d++;

		if(xpos>=width){		// Stopped at end of line?
			d += 8;
			xpos = 0;
			++ypos;
		}
	}
	return d;		// Return size of encoded sprite
}*/


unsigned int encodesprite(int centerx, int centery, s_bitmap *bitmap, s_sprite *dest)
{
	dest->width = bitmap->width;
	dest->height = bitmap->height;
	dest->centerx = centerx;
	dest->centery = centery;

    //printf("copying %d * %d = %d\n", sp->width, sp->height, sp->width*sp->height);
	memcpy( dest->data, bitmap->data, dest->width * dest->height );

    return ( 32 + bitmap->width * bitmap->height );
}


void putsprite_remap(int x, int y, s_sprite *frame, s_screen *screen, char *lut){
	int width, height;

	unsigned char *dest_c;

	int start_x, start_y, new_width, _x, _y;

	// Get screen size
	screenwidth = screen->width;
	screenheight = screen->height;

	dest_c = (void*)screen->data;

	// Adjust coords for centering
	x -= frame->centerx;
	y -= frame->centery;


	// Get sprite dimensions
	width = frame->width;
	height = frame->height;

    if (x + width < 0 )
    {
        //printf("<x rm\n");
        return;
    }

    if (x > screenwidth )
    {
        //printf(">x rm\n");
        return;
    }



	// Check if sprite dimensions are valid
	if(width<=0 || height<=0) return;

	start_x = 0, start_y = 0;

	// Check clipping, vertical first
	if(y < 0){
		// Clip top
		height += y;		// Make sprite shorter
		if(height <=0 ) return;
        start_y -= y;
		y = 0;
	}

	if(y+height > screenheight){
		// Clip bottom (make sprite shorter)
		height = screenheight - y;
		if(height <= 0) return;
	}

	new_width = width;

	if(x < 0){
		// Clip left
        start_x -= x;
        x = 0;
        new_width -= start_x;
	}

	if(x + new_width > screenwidth){
		// Clip right
        new_width = screenwidth - x;
	}

    //printf("%d %d %d %d\n", x, y, width, height);

    for ( _y = 0; _y < height; _y++ )
    {
		char* src;

		dest_c = (char*)screen->data + (y + _y) * screenwidth + x;

		src = (char*)frame->data + (start_y + _y) * width + start_x;

        for ( _x = 0; _x < new_width; _x++, dest_c++, src++ )
        {
            if ( *src != TRANSPARENT_IDX )
            	*dest_c = lut[ *src ];
        }
    }
}


void putsprite_blend(int x, int y, s_sprite *frame, s_screen *screen, char *lut){

	int width, height;

	unsigned char *dest_c;

	int start_x, start_y, new_width, _x, _y;

	// Get screen size
	screenwidth = screen->width;
	screenheight = screen->height;

	dest_c = (void*)screen->data;

	// Adjust coords for centering
	x -= frame->centerx;
	y -= frame->centery;


	// Get sprite dimensions
	width = frame->width;
	height = frame->height;

    if (x + width < 0 )
    {
        //printf("<x b\n");
        return;
    }

    if (x > screenwidth )
    {
        //printf(">x b\n");
        return;
    }


	// Check if sprite dimensions are valid
	if(width<=0 || height<=0) return;

	start_x = 0, start_y = 0;

	// Check clipping, vertical first
	if(y < 0){
		// Clip top
		height += y;		// Make sprite shorter
		if(height <=0 ) return;
        start_y -= y;
		y = 0;
	}

	if(y+height > screenheight){
		// Clip bottom (make sprite shorter)
		height = screenheight - y;
		if(height <= 0) return;
	}

	new_width = width;

	if(x < 0){
		// Clip left
        start_x -= x;
        x = 0;
        new_width -= start_x;
	}

	if(x + new_width > screenwidth){
		// Clip right
        new_width = screenwidth - x;
	}

    //printf("%d %d %d %d\n", x, y, width, height);

    for ( _y = 0; _y < height; _y++ )
    {
		char* src;

		dest_c = (char*)screen->data + (y + _y) * screenwidth + x;

		src = (char*)frame->data + (start_y + _y) * width + start_x;

        for ( _x = 0; _x < new_width; _x++, dest_c++, src++ )
        {
            if ( *src != TRANSPARENT_IDX )
            	*dest_c = lut[ ( *src << 8 ) | *dest_c ];
        }
    }
}

