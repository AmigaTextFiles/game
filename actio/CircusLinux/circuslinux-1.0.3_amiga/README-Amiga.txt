
CIRCUS LINUX

AN SDL GAME.

CircusLinux homepage at :
http://www.newbreedsoftware.com/circus-linux/

Compiled on Amiga with GCC by Marc 'MaVaTi' Le Douarain , 15 july 2001.
-No sound support- for the moment.

Thanks to Gabriele Greco for the Amiga port of SDL !

The SDL linked needs Cybergraphx V3 (r69+) or CyberGraphX V4
and AHI v3+. Probably it works also with P96 or CGXAga, but it's 
untested.


This game uses 2 libraries : 
SDL_image (http://www.libsdl.org/projects/SDL_image/index.html)
SDL_mixer (http://www.libsdl.org/projects/SDL_mixer/index.html)
I've compiled only the first one for now.
I will try to add sound support next time.

/* You've to add this to the end of circuslinux.c for Amiga */
void kprintf(char * msg)
{
	printf("%s\n",msg);
}

