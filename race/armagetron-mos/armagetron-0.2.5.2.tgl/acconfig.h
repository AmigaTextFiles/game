

/* define if you have the library IMG */
#undef HAVE_LIBIMG

@TOP@

/* define if you have OpenGL (just to make autoheader happy...)
#define HAVE_LIBGL 1
*/

/* define if you have the Mesa 3DFX implementation of OpenGL */
#undef HAVE_FXMESA

/* define if you wish to compile a dedicated server */
#undef DEDICATED

/* define if you wish to use the dirty initialisation method */
#undef DIRTY

/* define if you have the SDL */
#undef HAVE_LIBSDL


/* PowerPak 2D debugging output */
#undef POWERPAK_DEB 
#undef HAVE_LIBPP   

@BOTTOM@
#ifdef DEDICATED
#undef HAVE_LIBSDL
#undef HAVE_FXMESA
#undef HAVE_LIBIMG
#undef HAVE_LIBSDL_IMAGE
#undef POWERPAK_DEB
#endif
