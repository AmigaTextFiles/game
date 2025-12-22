#ifndef DISPLAY_H
#define DISPLAY_H

struct PDisplay
{
	int width;
	int height;
	int depth;
	struct Screen *screen;
	struct Window *window;
	struct ScreenBuffer *screenbuf1;
	struct ScreenBuffer *screenbuf2;
	struct ScreenBuffer *screenbuf3;
};

extern struct PDisplay *aktdisplay;
#endif
