#ifndef MOG_AUXILIAR
#define MOG_AUXILIAR

#ifndef _WIN32
char *strupr(char *ptr);
#endif

void putpixel(SDL_Surface *surface, int x, int y, Uint32 pixel);
Uint32 getpixel(SDL_Surface *surface, int x, int y);
void rectangle(SDL_Surface *surface, int x, int y, int w, int h, Uint32 pixel);

void surface_fader(SDL_Surface *surface,float r_factor,float g_factor,float b_factor);

SDL_Surface *load_maskedimage(char *image,char *mask,char *path);


#endif


