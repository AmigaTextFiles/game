#ifndef _MS2_GAME_H_
#define _MS2_GAME_H_

class Game
{
  public:
    Game(Options options);
    ~Game();
    void updateHoverTile(unsigned short int x, unsigned short int y,
            bool leftmousebuttondown);
    void clearTileAt(unsigned short int x, unsigned short int y);
    void setFlagAt(unsigned short int x, unsigned short int y);
    void generateMines(unsigned short int x, unsigned short int y);
    void handleDoubleClick(unsigned short int x, unsigned short int y);
    void showCurrentTime();
    bool started;
    bool gameover;
    Window *gamewindow;
    unsigned int time_started;
  private:
    void initImages();
    void initGrid();
    void loseGame(unsigned short int mousepos_x, unsigned short int mousepos_y);
    void winGame();
    const unsigned short int countAdjacentMinesAt(unsigned short int mousepos_x,
            unsigned short int mousepos_y);
    const unsigned short int showAdjacentMinesAt(unsigned short int mousepos_x,
            unsigned short int mousepos_y);
    const unsigned short int countAdjacentFlagsAt(unsigned short int mousepos_x,
            unsigned short int mousepos_y);
    void clearAdjacentTilesAt(unsigned short int mousepos_x, unsigned short int mousepos_y);
    const Options gameoptions;
    static const unsigned short int FONT_SIZE = 14;
    std::vector< std::vector<Tile> > grid;
    SDL_Surface *font1;
    SDL_Rect hover_tile;
    unsigned short int flags;
};

#endif
