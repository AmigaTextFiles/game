// MORTAR shot image (w) 1998-1999 by Eero Tamminen

#include "colors.inc"
#include "textures.inc"


sphere {
	<0, 0, 0>, 1
	pigment { color White }
	finish { Metal }
}


camera {
	location <0, 0, -2.3>
	look_at  <0, 0, 0>
	right x			// 1:1 aspect ratio
}

light_source {
	<6, 1, -1>
	color Gray50
}

light_source {
	<-5, 5, -8> 
	color White
}
