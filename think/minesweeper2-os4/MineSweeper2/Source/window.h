#ifndef _MS2_WINDOW_H_
#define _MS2_WINDOW_H_

class Window
{
  public:
    Window(Options options);
    void drawTile(SDL_Surface *image, const char tile,
            unsigned short int x, unsigned short int y);
    void writeInBlack(unsigned short int xcoord, std::string text);
    void writeInBlack(unsigned short int xcoord, unsigned short int number);
    void redrawScreen();
    static const short unsigned int FONT_SIZE = 14;
  private:
    SDL_Surface *screen;
    const short unsigned int WINDOW_WIDTH;
    const short unsigned int WINDOW_HEIGHT;
    static const short unsigned int SCREEN_BPP = 32;
    SDL_Surface *font2;
};

#endif
