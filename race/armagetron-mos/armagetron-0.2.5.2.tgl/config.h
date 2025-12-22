/* config.h.  Generated automatically by configure.  */
/* config.h.in.  Generated automatically from configure.in by autoheader.  */


/*

  System Type

 */

/* Windows 95/98/NT/XP */
/* #undef WIN32 */

/* AIX */
/* #undef AIX */

/* LINUX */
/* #undef LINUX */

/* MAC OS X */
/* #undef MACOSX */

/* BEOS */
/* #undef BEOS */

/* SOLARIS */
/* #undef SOLARIS */


/* define if you have the library IMG */
/* #undef HAVE_LIBIMG */


/* Define to empty if the keyword does not work.  */
/* #undef const */

/* Define if you have the ANSI C header files.  */
#define STDC_HEADERS 1

/* Define if your system does not like the pointer tricks in eWall.h.  */
/* #undef CAUTION_WALL */

/* define if you wish to compile a dedicated server */
/* #undef DEDICATED */

/* define if you wish to compile the krawall version */
/* #undef KRAWALL */

/* define if you wish to compile a krawall server with authentification */
/* #undef KRAWALL_SERVER */

/* define if you wish to compile a dedicated server */
/* #undef DIRTY */

/* define if you have the SDL */
#define HAVE_LIBSDL 1

/* Define if you have the SDL_MIXER library  */
/* #undef HAVE_LIBSDL_MIXER */

/* PowerPak 2D debugging output */
/* #undef POWERPAK_DEB */
/* #undef HAVE_LIBPP */

/* Define if you have the select function.  */
#define HAVE_SELECT 1

/* Define if you have the <SDL_opengl.h> header file.  */
/* #undef HAVE_SDL_OPENGL_H */

/* Define if you have the <SDL/SDL_opengl.h> header file.  */
/* #undef HAVE_SDL_SDL_OPENGL_H */

/* Define if you have the <OpenGL/gl.h> header file.  */
/* #undef HAVE_OPENGL_GL_H */

/* Define if you have the <GL/gl.h> header file.  */
/* #undef HAVE_GL_GL_H */

/* Define if you have the <IMG.h> header file.  */
/* #undef HAVE_IMG_H */

/* Define if you have the <SDL/IMG.h> header file.  */
/* #undef HAVE_SDL_IMG_H */

/* Define if you have the <SDL/SDL_image.h> header file.  */
/* #undef HAVE_SDL_SDL_IMAGE_H */

/* Define if you have the <SDL_image.h> header file.  */
#define HAVE_SDL_IMAGE_H 1

/* Define if you have the <unistd.h> header file.  */
#define HAVE_UNISTD_H 1

/* Define if you have the GL library (-lGL).  */
#define HAVE_LIBGL 1

/* Define if you have the GLU library (-lGLU).  */
/* #undef HAVE_LIBGLU */

/* Define if you have the SDL_image library (-lSDL_image).  */
#define HAVE_LIBSDL_IMAGE 1

/* Define if you have the m library (-lm).  */
#define HAVE_LIBM 1

/* Define if you have the png library (-lpng).  */
#define HAVE_LIBPNG 1

/* Define if you have the wsock32 library (-lwsock32).  */
/* #undef HAVE_LIBWSOCK32 */

/* Define if you have the z library (-lz).  */
#define HAVE_LIBZ 1

/* Define if you dont want to use a custom memory manager.  */
#define DONTUSEMEMMANAGER 1


// #ifdef DEDICATED
// #undef HAVE_LIBSDL
// #undef HAVE_FXMESA
// #undef HAVE_LIBIMG
// #undef HAVE_LIBSDL_IMAGE
// #undef POWERPAK_DEB
// #else
// #undef KRAWALL_SERVER
// #endif

#ifdef _DEBUG
#define DEBUG
#endif

#ifndef DEBUG
#define NDEBUG
#endif

