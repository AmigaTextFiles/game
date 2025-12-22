// MORTAR images (C) 1998-1999 by Eero Tamminen

#include "colors.inc"
#include "textures.inc"

// mortar angle
#declare head = clock


#declare pipe =
merge {
	difference {
		sphere {
			<0, 0, 0>, 2
			scale <3, 1, 1>
		}
		box {
			// remove butt...
			<-8, -8, -8>, <0, 8, 8>
		}
		sphere {
			// ...and head
			<6, 0, 0>, 3
		}
	}
	sphere {
		// round off the butt
		<0, 0, 0>, 2
	}
	rotate  -15 * y
	rotate head * z
}


#declare base =
superellipsoid {
	<0.36, 0.36>
	/* to make cannon dropping look realistic, base should be as wide as
	 * the resulting image because function doing the dropping and
	 * ground leveling doesn't know about the image looks.
	 */
	scale <3, 0.2, 1.6>
}


union {
	object {
		pipe
		translate 2 * y
	}
	object { base }

	texture {
		/* Brass below looks very good indeed, but on smaller sizes
		 * it's better to use just the brightest color possible (=
		 * white) instead.
		 */
		//New_Brass
		pigment { color White }
	}
	finish { Metal }
}

camera {
	location <0, 0.5, -6.2>
	look_at  <0, 2.8, 0>
}

light_source {
	<-5, 4, -8>
	color White
}

