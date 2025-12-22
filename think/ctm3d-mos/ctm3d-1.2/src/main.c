/*
	ColorTileMatch 3D
      Written by Bl0ckeduser
*/

#include "main.h"

int main(int argc, char *argv[])
{
	SDL_Surface *display;
	SDL_VideoInfo* video_info;
	Uint32 sdlflags;

	/* Set up SDL and game screen */
	Require(InitSDL(), "SDL initialization");

	video_info = SDL_GetVideoInfo();

	SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);

	sdlflags = SDL_GL_DOUBLEBUFFER | SDL_OPENGL | SDL_HWSURFACE | SDL_HWACCEL;

	/* check for fullscreen mode flag */
	if(argc > 1)
		if(!strcmp(argv[1], "-f"))
		{
			sdlflags |= SDL_FULLSCREEN;
			printf("Fullscreen mode\n");
		}


	display = SDL_SetVideoMode(
		640, 480,
		video_info -> vfmt -> BitsPerPixel,
		sdlflags);

	Require(display != NULL, "SDL display creation");

	glClearColor (0.0, 0.0, 0.0, 0.0);

	/* GL viewport */
	glViewport(0, 0, 640, 480);

	/* Setup projection matrix */
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(45.0f, (GLdouble)640.0f/480.0f, 0.1f, 100.0f);

	/* Setup model view matrix */
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();

	/* Z-buffering, smooth shading */
	glEnable (GL_DEPTH_TEST);
	glShadeModel (GL_SMOOTH);

	/* Run the game */
	RunGame(&display);

	/* Clean up and exit */
	SDL_FreeSurface(display);
	SDL_Quit();
	return 0;
}
