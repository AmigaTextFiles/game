// Some texture functions (nothing special)
// Last update: saturday, 10 jan 2004
// To do: optimize


#include "types.h"
#include <math.h>
#include "asmcopy.h"


#ifndef M_PI
#define		M_PI		3.1415926
#endif


static int distortion[256];



// Fill the distortion table
#if 1
const static float sintbl[] = {
	0.000000,0.024541,0.049068,0.073565,0.098017,0.122411,0.146730,0.170962,
	0.195090,0.219101,0.242980,0.266713,0.290285,0.313682,0.336890,0.359895,
	0.382683,0.405241,0.427555,0.449611,0.471397,0.492898,0.514103,0.534998,
	0.555570,0.575808,0.595699,0.615232,0.634393,0.653173,0.671559,0.689541,
	0.707107,0.724247,0.740951,0.757209,0.773010,0.788346,0.803208,0.817585,
	0.831470,0.844854,0.857729,0.870087,0.881921,0.893224,0.903989,0.914210,
	0.923880,0.932993,0.941544,0.949528,0.956940,0.963776,0.970031,0.975702,
	0.980785,0.985278,0.989177,0.992480,0.995185,0.997290,0.998795,0.999699,
	1.000000,0.999699,0.998795,0.997290,0.995185,0.992480,0.989177,0.985278,
	0.980785,0.975702,0.970031,0.963776,0.956940,0.949528,0.941544,0.932993,
	0.923880,0.914210,0.903989,0.893224,0.881921,0.870087,0.857729,0.844854,
	0.831470,0.817585,0.803208,0.788346,0.773010,0.757209,0.740951,0.724247,
	0.707107,0.689541,0.671559,0.653173,0.634393,0.615232,0.595699,0.575808,
	0.555570,0.534998,0.514103,0.492898,0.471397,0.449611,0.427555,0.405241,
	0.382683,0.359895,0.336890,0.313682,0.290285,0.266713,0.242980,0.219101,
	0.195090,0.170962,0.146730,0.122411,0.098017,0.073565,0.049068,0.024541,
	0.000000,-0.024541,-0.049068,-0.073565,-0.098017,-0.122411,-0.146730,-0.170962,
	-0.195090,-0.219101,-0.242980,-0.266713,-0.290285,-0.313682,-0.336890,-0.359895,
	-0.382683,-0.405241,-0.427555,-0.449611,-0.471397,-0.492898,-0.514103,-0.534998,
	-0.555570,-0.575808,-0.595699,-0.615232,-0.634393,-0.653173,-0.671559,-0.689541,
	-0.707107,-0.724247,-0.740951,-0.757209,-0.773010,-0.788346,-0.803208,-0.817585,
	-0.831470,-0.844854,-0.857729,-0.870087,-0.881921,-0.893224,-0.903989,-0.914210,
	-0.923880,-0.932993,-0.941544,-0.949528,-0.956940,-0.963776,-0.970031,-0.975702,
	-0.980785,-0.985278,-0.989177,-0.992480,-0.995185,-0.997290,-0.998795,-0.999699,
	-1.000000,-0.999699,-0.998795,-0.997290,-0.995185,-0.992480,-0.989177,-0.985278,
	-0.980785,-0.975702,-0.970031,-0.963776,-0.956940,-0.949528,-0.941544,-0.932993,
	-0.923880,-0.914210,-0.903989,-0.893224,-0.881921,-0.870087,-0.857729,-0.844854,
	-0.831470,-0.817585,-0.803208,-0.788346,-0.773010,-0.757209,-0.740951,-0.724247,
	-0.707107,-0.689541,-0.671559,-0.653173,-0.634393,-0.615232,-0.595699,-0.575808,
	-0.555570,-0.534998,-0.514103,-0.492898,-0.471397,-0.449611,-0.427555,-0.405241,
	-0.382683,-0.359895,-0.336890,-0.313682,-0.290285,-0.266713,-0.242980,-0.219101,
	-0.195090,-0.170962,-0.146730,-0.122411,-0.098017,-0.073565,-0.049068,-0.024541,
};

void texture_set_wave(float amp){
	int i;
	for(i=0;i<256;i++) distortion[i] = amp*(sintbl[i]+1)+0.5;
}

#else

void texture_set_wave(float amp){
	int i;
	for(i=0;i<256;i++) distortion[i] = amp*(sin(i*M_PI/128)+1)+0.5;
}

#endif


/*

void texture_wave(s_screen *screen, int x, int y, int width, int height, int offsx, int offsy, s_bitmap *bitmap, int offsd, int step){

	int i;
	char *src;
	char *dest;
	int s;
	int sy;
	int xmask, ymask;
	int twidth;


	// Check dimensions
	if(x >= screen->width) return;
	if(y >= screen->height) return;
	if(x<0){
		width += x;
		x = 0;
	}
	if(y<0){
		height += y;
		y=0;
	}
	if(x+width > screen->width){
		width = screen->width - x;
	}
	if(y+height > screen->height){
		height = screen->height - y;
	}
	if(width<=0) return;
	if(height<=0) return;


	// Fill area
	xmask = bitmap->width-1;
	ymask = bitmap->height-1;

	sy = offsy;

	dest = screen->data + (y * screen->width) + x;
	do{
		// Get source line pointer
		sy &= ymask;
		src = bitmap->data + (sy*256);
		++sy;

		// Get start offset (distortion)
		offsd &= 255;
		s = offsx + distortion[offsd];
		offsd += step;

		// Copy pixels
		twidth = width;
		do{
			s &= xmask;
			*dest = src[s];
			++dest;
			++s;
		}while(--twidth);

		// Advance destination line pointer
		dest -= width;
		dest += screen->width;

	}while(--height);
}

*/



void texture_wave(s_screen *screen, int x, int y, int width, int height, int offsx, int offsy, s_bitmap *bitmap, int offsd, int step){

	int i;
	char *src;
	char *dest;
	int s;
	int sy;
	int twidth;
	int tx;


	// Check dimensions
	if(x >= screen->width) return;
	if(y >= screen->height) return;
	if(x<0){
		width += x;
		x = 0;
	}
	if(y<0){
		height += y;
		y=0;
	}
	if(x+width > screen->width){
		width = screen->width - x;
	}
	if(y+height > screen->height){
		height = screen->height - y;
	}
	if(width<=0) return;
	if(height<=0) return;




	// Dest ptr
	dest = screen->data + (y * screen->width) + x;

	// Fill area
	do{
		// Source line ptr
		sy = offsy % bitmap->height;
		src = bitmap->data + (sy * bitmap->width);
		offsy++;


		// Adjust distortion stuff
		offsd &= 255;
		s = (offsx + distortion[offsd]) % bitmap->width;
		offsd += step;

		// Copy loop
		tx = 0;
		twidth = bitmap->width - s;
		if(twidth > width) twidth = width;
		while(twidth > 0){
			asm_copy(dest+tx, src+s, twidth);
			s = 0;
			tx += twidth;
			twidth = width - tx;
			if(twidth > bitmap->width) twidth = bitmap->width;
		}

		// Advance destination line pointer
		dest += screen->width;
	}while(--height);

}








static void draw_plane_line(char *destline, char *srcline, int destlen, int srclen, int stretchto, int texture_offset){
	int i;
	unsigned int s, s_pos, s_step;
	int center_offset = destlen / 2;

	s_pos = texture_offset + (256 * srclen);
	s_step = srclen * 256 / stretchto;
	s_pos -= center_offset * s_step;

	for(i=0; i<destlen; i++){
		s = s_pos >> 8;
		if(s > srclen){
			s %= srclen;
			s_pos = (s_pos & 0xFF) | (s << 8);
		}
		destline[i] = srcline[s];
		s_pos += s_step;
	}
}



// Draw a plane (like the sea)
void texture_plane(s_screen *screen, int x, int y, int width, int height, int fixp_offs, int factor, s_bitmap *bitmap){

	int i;
	char *dest;
	char *src;
	int sy;
	int cur_fixp_step;
	int cur_fixp_offs;

	if(factor < 0) return;
	factor++;


	// Check dimensions
	if(x >= screen->width) return;
	if(y >= screen->height) return;
	if(x<0){
		width += x;
		x = 0;
	}
	if(y<0){
		height += y;
		y=0;
	}
	if(x+width > screen->width){
		width = screen->width - x;
	}
	if(y+height > screen->height){
		height = screen->height - y;
	}
	if(width<=0) return;
	if(height<=0) return;
	

	dest = screen->data + (y*screen->width) + x;
	sy = 0;
	for(i=0; i<height; i++){

		sy = i % bitmap->height;
		src = bitmap->data + (sy * bitmap->width);

		draw_plane_line(dest,src, width,bitmap->width, bitmap->width + ((bitmap->width * i) / factor), fixp_offs);

		dest += screen->width;
	}
}





