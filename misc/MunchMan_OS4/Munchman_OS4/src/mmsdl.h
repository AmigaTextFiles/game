#include<SDL/SDL.h>

Uint16 tmppal[256];
char keypress[256];
char key[512];

int ticks;
unsigned char psuedopal[768];
int scr_size;

struct {
        int x;
        int x2;
        int y;
        int y2;
} clip;

struct {
        int width;
        int height;
} gscr;

SDL_Surface *screen;

Uint8 rshift, gshift, bshift;
Uint32 rmask, gmask, bmask;
void sdl_init(int size, int fullscreen)
{
        Uint8  video_bpp;
        Uint32 videoflags;
        int n;

        clip.x = 0;
        clip.y = 0;
        clip.x2 = 319;
        clip.y2 = 199;

        gscr.width = 320;
        gscr.height = 200;

        /* Initialize SDL */
        if ( SDL_Init(SDL_INIT_VIDEO) < 0 ) {
                fprintf(stderr, "Couldn't initialize SDL: %s\n",SDL_GetError());
                exit(1);
        }
        atexit(SDL_Quit);

        video_bpp = 16;
        videoflags = SDL_HWSURFACE | SDL_DOUBLEBUF;
        if(fullscreen)
                videoflags |= SDL_FULLSCREEN;

        if(size == 0) {
                /* Set 320x200 video mode */
                if ( (screen=SDL_SetVideoMode(320,200,video_bpp,videoflags)) == NULL ) {
                        fprintf(stderr, "Couldn't set 320x200x%d video mode: %s\n", video_bpp, SDL_GetError());
                        exit(2);
                }
        }
        else {
                /* Set 640x480 video mode */
                if ( (screen=SDL_SetVideoMode(640,480,video_bpp,videoflags)) == NULL ) {
                        fprintf(stderr, "Couldn't set 640x480x%d video mode: %s\n", video_bpp, SDL_GetError());
                        exit(2);
                }
        }

	SDL_ShowCursor(0);

        rshift = screen->format->Rshift;
        gshift = screen->format->Gshift;
        bshift = screen->format->Bshift;
        rmask = screen->format->Rmask >> rshift;
        gmask = screen->format->Gmask >> gshift;
        bmask = screen->format->Bmask >> bshift;
        if(rmask > 31)
                rshift++;
        if(gmask > 31)
                gshift++;
        if(bmask > 31)
                bshift++;

        SDL_WM_SetCaption("MunchMan", NULL);

        for(n = 0; n < 256; ++n)
                keypress[n] = 0;

	scr_size = size;
}

void sdl_deinit()
{
}

void updatekeys()
{
        int n;
        int done;
        SDL_Event event;

        if(SDL_PollEvent(&event)) {
                done = 0;
                switch(event.type) {
                        case SDL_QUIT:
                                done = 1;
                                break;
                        default:
                                break;
                }
                if(done)
                        exit(3);
        }

        n = 512;
        memcpy(key, SDL_GetKeyState(&n), 512);
        keypress[72] = key[SDLK_UP] == SDL_PRESSED || key[SDLK_KP8] == SDL_PRESSED;
        keypress[80] = key[SDLK_DOWN] == SDL_PRESSED || key[SDLK_KP2] == SDL_PRESSED;
        keypress[75] = key[SDLK_LEFT] == SDL_PRESSED || key[SDLK_KP4] == SDL_PRESSED;
        keypress[77] = key[SDLK_RIGHT] == SDL_PRESSED || key[SDLK_KP6] == SDL_PRESSED;
        keypress[28] = key[SDLK_RETURN] == SDL_PRESSED || key[SDLK_KP_ENTER] == SDL_PRESSED;
        keypress[1]  = key[SDLK_ESCAPE] == SDL_PRESSED;
	keypress[2]  = key[SDLK_HOME] == SDL_PRESSED;
}


Uint16 *zap_target;
char *zap_src;

void zap32(unsigned char *dbuf)
{
        int n, n2, deep, x, y;
        unsigned char r, g, b, c;
        Uint16 val;

        if(SDL_LockSurface(screen) < 0 ) {
                fprintf(stderr, "Couldn't lock the display surface: %s\n", SDL_GetError());
                exit(2);
        }

        for(n = 0; n < 256; ++n) {
                r = psuedopal[n * 3] >> 1;
                g = psuedopal[n * 3 + 1] >> 1;
                b = psuedopal[n * 3 + 2] >> 1;
                tmppal[n] = (r << rshift) + (g << gshift) + (b << bshift);
        }

        zap_src = dbuf;
        zap_target = (Uint16 *)screen->pixels;

#ifdef USE_C_ONLY
        if(scr_size == 0) {
                for(n = 0; n < 64000; ++n) {
                        zap_target[n] = tmppal[dbuf[n]];
                }
        }
        else {
		for(deep = 0; deep < 40*640; ++deep)
			zap_target[deep++] = 0;

                for(n2 = 0; n2 < 400; ++n2) {
                        for(n = 0; n < 640; ++n) {
                                x = n >> 1;
                                y = n2 >> 1;
                                zap_target[deep++] = tmppal[dbuf[y * 320 + x]];
                        }
                }
		for(; deep < 40*640; ++deep)
			zap_target[deep++] = 0;
        }
#else
        if(scr_size == 0) {
                asm ("
                        pushw   %es
                        movw    %ds, %ax
                        movw    %ax, %es

                        movl    zap_target, %edi
                        movl    $tmppal, %esi
                        movl    zap_src, %edx
                        movl    $32000, %ecx

                        zapla1:
                        movzbl  1(%edx), %ebx
                        movzbl  (%edx), %eax

                        movw    (%esi,%ebx,2), %bx
                        shll    $16, %ebx
                        movw    (%esi,%eax,2), %bx

                        movl    %ebx, (%edi)
                        addl    $4, %edi
                        addl    $2, %edx

                        decl    %ecx
                        jnz     zapla1

                        popw    %es
                ");
        }
        else {
                asm ("
                        pushw   %es
                        movw    %ds, %ax
                        movw    %ax, %es

                        movl    zap_target, %edi

                        movl	$640*20, %ecx
                        xorl	%eax,%eax
                        rep ; stosl

                        movl    $tmppal, %esi
                        movl    zap_src, %edx
                        movl	$199*0x10000, %ecx

                        zapl2:
                        movw	$320, %cx

                        zapl1:
                        movzbl  (%edx), %eax

                        movw    (%esi,%eax,2), %ax
                        shrdl	$16, %eax, %ebx
                        movw	%ax,%bx

                        movl    %ebx, (%edi)
                        movl	%ebx, 1280(%edi,1)
                        addl    $4, %edi
                        incl	%edx

                        decw    %cx
                        jnz     zapl1
                        addl	$1280, %edi
                        subl	$0x00010000, %ecx
                        jns	zapl2

                        movl	$640*20, %ecx
                        xorl	%eax,%eax
                        rep ; stosl

                        popw    %es
                ");
        }
#endif

        SDL_UnlockSurface(screen);
        SDL_Flip(screen);
}


#ifdef USE_C_ONLY

void put(int x, int y, int l, int h, char *image, char *screen)
{
        int n, n2;
        int px, py;

        for(n2 = 0; n2 < h; ++n2) {
                for(n = 0; n < l; ++n) {
                        px = n + x;
                        py = n2 + y;
                        if(py >= clip.y && py <= clip.y2 && px >= clip.x && px <= clip.x2)
                                screen[py * gscr.width + px] = *image;
                        ++image;
                }
        }
}

void place(int x, int y, int l, int h, unsigned char *image, unsigned char *screen)
{
        int n, n2;
        int px, py;

        for(n2 = 0; n2 < h; ++n2) {
                for(n = 0; n < l; ++n) {
                        px = n + x;
                        py = n2 + y;
                        if(py >= clip.y && py <= clip.y2 && px >= clip.x && px <= clip.x2 && *image)
                                screen[py * gscr.width + px] = *image;
                        ++image;
                }
        }
}

#else

int putd, putl, puth, putr;
char *putp, *putscr;
int ptabb, ptabe;       /* tab lengthwise for beginning and end */

void put(int x, int y, int l, int h, char *image, char *screen) {
        putd = x + y * gscr.width;
        putl = l;
        puth = h;
        putr = gscr.width - l;
        putp = image;
        putscr = screen;

        if(x + l - 1 < clip.x)
                return;
        if(x > clip.x2)
                return;
        if(y + h - 1 < clip.y)
                return;
        if(y > clip.y2)
                return;

        /* x-tabs */
        if(x < clip.x)
                ptabb = clip.x - x;
        else
                ptabb = 0;
        if(x + l - 1 > clip.x2)
                ptabe = (x + l - 1) - clip.x2;
        else
                ptabe = 0;

        putl -= ptabb + ptabe;  /* make new length based on tabs */
        /*   4            2
           |----|        |--|
           +----------------+
           |       25       |      ptabb = 4;
           |                |      ptabe = 2;
           |     (pic)      |      putl = 25 - (4+2) = 25 - (6) = 19;
           |                |
           +----------------+
        */

        /* y-tabs (no need for a special variable, like the x-tabs) */
        if(y < clip.y) {
                putscr += (clip.y - y) * gscr.width; /* skip to see-able part */
                putp += (clip.y - y) * l;            /* tab into the image */
                puth -= (clip.y - y);                /* height is decreased */
        }
        if(y + h - 1 > clip.y2) {
                puth -= (y + h - 1) - clip.y2;      /* height is decreased */
        }
        asm ("
                pushw   %es
                movw    %ds, %ax
                movw    %ax, %es

                movl    putscr, %edi
                addl    putd, %edi
                movl    putp, %esi
                movl    puth, %ecx

                putl1:
                pushl   %ecx
                movl    putl, %ecx

                addl    ptabb, %esi
                addl    ptabb, %edi

                rep  ;  movsb

                addl    ptabe, %esi
                addl    ptabe, %edi

                addl    putr, %edi
                popl    %ecx
                loop    putl1

                popw    %es
        ");
}


void place(int x, int y, int l, int h, char *image, char *screen) {
        putd = x + y * gscr.width;
        putl = l;
        puth = h;
        putr = gscr.width - l;
        putp = image;
        putscr = screen;

        if(x + l - 1 < clip.x)
                return;
        if(x > clip.x2)
                return;
        if(y + h - 1 < clip.y)
                return;
        if(y > clip.y2)
                return;

        /* x-tabs */
        if(x < clip.x)
                ptabb = clip.x - x;
        else
                ptabb = 0;
        if(x + l - 1 > clip.x2)
                ptabe = (x + l - 1) - clip.x2;
        else
                ptabe = 0;

        putl -= ptabb + ptabe;  /* make new length based on tabs */
        /*   4            2
           |----|        |--|
           +----------------+
           |       25       |      ptabb = 4;
           |                |      ptabe = 2;
           |     (pic)      |      putl = 25 - (4+2) = 25 - (6) = 19;
           |                |
           +----------------+
        */

        /* y-tabs (no need for a special variable, like the x-tabs) */
        if(y < clip.y) {
                putscr += (clip.y - y) * gscr.width; /* skip to see-able part */
                putp += (clip.y - y) * l;            /* tab into the image */
                puth -= (clip.y - y);                /* height is decreased */
        }
        if(y + h - 1 > clip.y2) {
                puth -= (y + h - 1) - clip.y2;      /* height is decreased */
        }
        asm ("
                pushw   %es
                movw    %ds, %ax
                movw    %ax, %es

                movl    putscr, %edi
                addl    putd, %edi
                movl    putp, %esi
                movl    puth, %ecx

                placel1:
                pushl   %ecx
                movl    putl, %ecx

                addl    ptabb, %esi
                addl    ptabb, %edi

                placel2:
                movb    (%esi), %al
                cmpb    $0, %al
                je      no_place

                movb    %al, (%edi)

                no_place:
                incl    %edi
                incl    %esi
                loop    placel2

                addl    ptabe, %esi
                addl    ptabe, %edi

                addl    putr, %edi
                popl    %ecx
                loop    placel1

                popw    %es
        ");
}

#endif


void setpale(unsigned char pale, char red, char green, char blue);

void setpal(unsigned char *pal)
{
        int n;

        memcpy(psuedopal, pal, 768);
//        for(n = 0; n < 256; ++n)
//                setpale(n, pal[n * 3], pal[n * 3 + 1], pal[n * 3 + 2]);
}

void setpale(unsigned char pale, char red, char green, char blue)
{
        psuedopal[pale * 3] = red;
        psuedopal[pale * 3 + 1] = green;
        psuedopal[pale * 3 + 2] = blue;
}

void wait_r(void)
{
}

int get_ticks()
{
        return SDL_GetTicks();
}
