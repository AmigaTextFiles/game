#ifndef _MS2_SESSION_H_
#define _MS2_SESSION_H_

class Session
{
  public:
    Session(Options options);
    ~Session();
    void newGame();
    void handleLeftMouseButtonDown(unsigned short int x, unsigned short int y);
    void handleLeftMouseButtonUp(unsigned short int x, unsigned short int y);
    void handleRightMouseButtonDown(unsigned short int x, unsigned short int y);
    void handleRightMouseButtonUp(unsigned short int x, unsigned short int y);
    void handleMouseMotion(unsigned short int x, unsigned short int y);
    Game *current_game;
  private:
    Options current_options;
    bool leftmousebuttondown;
    bool rightmousebuttondown;
    bool mouseovernewgameicon;
    static const short unsigned int FONT_SIZE = 14;
};

#endif
