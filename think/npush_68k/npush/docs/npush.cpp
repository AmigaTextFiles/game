/*
#
# Copyright 2008 The nPush Developers
#
# This file is part of nPush (http://npush.sourceforge.net).
#
# nPush is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# nPush is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with nPush in file COPYING; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
*/
#include <stdio.h>
#include <sys/types.h>
#include <dirent.h>
#include <pdcurses/curses.h>

#include <set>
#include <stack>
#include <string>
#include <vector>
#include <algorithm>
#include <map>
//-----------------------------------------------------------------------------
//kUnknown must be at start so it's value is 0.
typedef enum { kUnknown, kUp, kDown, kLeft, kRight, kButton, kSwitchPlayer, kQuitGame,
               kUndo
             } KeyType;
typedef enum { paMoved, paLevelComplete, paNone } PlayerAction;
typedef enum { fMenu, fGame } Font;
//-----------------------------------------------------------------------------
void
Box (int x0, int y0, int x1, int y1, bool clear) {
    attrset (A_BOLD);
    if (clear) {
        for (int y = y0; y < y1; y++) {
            move (y, x0);
            for (int x = x0; x < x1; x++)
                addch (' ');
        }
    }

    for (int x = x0; x < x1; x++) {
        mvaddch (y0, x, ACS_HLINE);
        mvaddch (y1, x, ACS_HLINE);
    }

    for (int y = y0; y < y1; y++) {
        mvaddch (y, x0, ACS_VLINE);
        mvaddch (y, x1, ACS_VLINE);
    }

    mvaddch (y0, x0, ACS_ULCORNER);
    mvaddch (y0, x1, ACS_URCORNER);
    mvaddch (y1, x0, ACS_LLCORNER);
    mvaddch (y1, x1, ACS_LRCORNER);
}

//-----------------------------------------------------------------------------
bool
Message (const char *text, bool wait = true) {
    int len = 0;
    while (text[len])
        len++;

    int maxx, maxy;
    getmaxyx (stdscr, maxy, maxx);

    int x0 = (maxx - len - 2) / 2;
    int y0 = (maxy - 5) / 2;

    Box (x0, y0, x0 + len + 3, y0 + 5, true);
    attrset (A_BOLD);
    mvprintw (y0 + 1, x0 + 2, (char *) text);

    if (!wait)
        return false;

    attrset (A_REVERSE);
    mvprintw (y0 + 3, x0 + len / 2, " OK");
    attrset (A_NORMAL);
    while (true) {
        int ch = getch ();
        if (ch == KEY_F (12))
            return false;
        if (ch == KEY_ENTER || ch == '\n')
            return true;
    }
}

int
Prompt (const char *text) {
    int len = 0;
    while (text[len])
        len++;

    int maxx, maxy;
    getmaxyx (stdscr, maxy, maxx);

    int x0 = (maxx - len - 2) / 2;
    int y0 = (maxy - 5) / 2;

    Box (x0, y0, x0 + len + 3, y0 + 5, true);
    attrset (A_BOLD);
    mvprintw (y0 + 1, x0 + 2, (char *) text);
    attrset (A_NORMAL);
    int ch = getch ();
    return ch;
}

class Config {
private:
    std::map < int, KeyType > charBind;
public:
    Config ();
    void bind (KeyType t, int toBind);
    KeyType lookup (int boundChar);
    void clear ();
    void eraseKey (KeyType erase);
};

Config::Config () {
    charBind[KEY_UP] = kUp;
    charBind[KEY_DOWN] = kDown;
    charBind[KEY_LEFT] = kLeft;
    charBind[KEY_RIGHT] = kRight;
    charBind['\t'] = kSwitchPlayer;
    charBind['q'] = kQuitGame;
    charBind['u'] = kUndo;
    charBind[KEY_ENTER] = kButton;
    charBind['\n'] = kButton;
}

void
Config::bind (KeyType t, int toBind) {
    charBind[toBind] = t;
}

KeyType
Config::lookup (int boundChar) {
    return charBind[boundChar];
}

void
Config::clear () {
    charBind.clear ();
}

void
Config::eraseKey (KeyType erase) {
    for (std::map < int, KeyType >::iterator it = charBind.begin ();
            it != charBind.end (); it++) {
        if ((*it).second == erase) {
            charBind.erase (it);
            return;
        }
    }
}

//-----------------------------------------------------------------------------
class Screen {
private:
public:
    virtual ~ Screen ();
    bool init ();
    void printText (int x, int y, const std::string & text, Font f = fGame);
    void render ();
    void clear ();
    Config config;
    KeyType getChar ();
};
//-----------------------------------------------------------------------------
void
Screen::clear () {
    erase ();
}

//-----------------------------------------------------------------------------
KeyType
Screen::getChar () {
    int ch = getch ();

    return config.lookup (ch);
}

//-----------------------------------------------------------------------------
bool
Screen::init () {
    // currently we have ncurses implementation, but it can be easily changed
    // just by creating instance of another class in main()

    if (!initscr ())        // init curses
        return false;
    start_color ();
    cbreak ();
    keypad (stdscr, TRUE);
    noecho ();

    init_pair (1, COLOR_YELLOW, COLOR_BLACK);
    init_pair (2, COLOR_GREEN, COLOR_BLACK);
    init_pair (3, COLOR_BLUE, COLOR_BLACK);
    init_pair (4, COLOR_RED, COLOR_BLACK);
    return true;
}

//-----------------------------------------------------------------------------
Screen::~Screen () {
    endwin ();
}

//-----------------------------------------------------------------------------
void
Screen::printText (int x, int y, const std::string & text, Font f) {
    if (f == fMenu) {   // weight and such
        attrset (A_NORMAL);
    }

    if (f == fGame) {   // color and such
        attrset (A_BOLD);
    }

    mvprintw (y, x, "%s", text.c_str ());
}

//-----------------------------------------------------------------------------
void
Screen::render () {
    mvprintw (1, 1,
              "-=[ nPush ]=-   -=[ nPush ]=-                 http://npush.sourceforge.net/");
    move (1, 15);
    refresh ();
}

//-----------------------------------------------------------------------------
class Menu {
private:
    typedef std::vector < std::string > ItemList;
    Screen & screenM;
    ItemList itemsM;
    std::string titleM;
    bool showBigLogoM;
    int currentItemM;

    void drawBigLogo ();

public:
    Menu (Screen & s, const std::string & title, bool showBigLogo = false);
    void add (const std::string & item);
    std::string getItemText (int index);
    int count ();
    int show ();
};
//-----------------------------------------------------------------------------
class ControlsConfigurator {
private:
    Screen & screenM;
public:
    ControlsConfigurator (Screen & scr);
};
//-----------------------------------------------------------------------------
ControlsConfigurator::ControlsConfigurator (Screen & scr):screenM (scr) {
    // show menu with current controls and allow changing
    // TODO: needs config() class
    clear ();

    /*int y = 3;
       int x = 3;
       mvprintw(y++, x, "Configure controls");
       mvprintw(y++, x, "");
       mvprintw(y++, x, "This option is not yet implemented. In the meantime use:");
       mvprintw(y++, x, "");
       mvprintw(y++, x, "arrow keys - movement");
       mvprintw(y++, x, "       tab - switch player");
       mvprintw(y++, x, "         u - undo last move (unlimited)");
       mvprintw(y++, x, "         q - quit game");
     */
    Menu
    m (scr, "Configuring Controls", false);
    m.add ("Move Left");
    m.add ("Move Right");
    m.add ("Move Up");
    m.add ("Move Down");
    m.add ("Switch Player");
    m.add ("Undo Last Move");
    m.add ("Quit Game");
    m.add ("Return to Main Menu");
    scr.render ();
    while (true) {
        int
        result = m.show ();
        int
        ch;
        switch (result) {
        case 0:
            ch = Prompt ("Press a key for Left");
            scr.config.eraseKey (kLeft);
            scr.config.bind (kLeft, ch);
            break;
        case 1:
            ch = Prompt ("Press a key for Right");
            scr.config.eraseKey (kRight);
            scr.config.bind (kRight, ch);
            break;
        case 2:
            ch = Prompt ("Press a key for Up");
            scr.config.eraseKey (kUp);
            scr.config.bind (kUp, ch);
            break;
        case 3:
            ch = Prompt ("Press a key for Down");
            scr.config.eraseKey (kDown);
            scr.config.bind (kDown, ch);
            break;
        case 4:
            ch = Prompt ("Press a key for switching the player");
            scr.config.eraseKey (kSwitchPlayer);
            scr.config.bind (kSwitchPlayer, ch);
            break;
        case 5:
            ch = Prompt ("Press a key for undoing moves");
            scr.config.eraseKey (kUndo);
            scr.config.bind (kUndo, ch);
            break;
        case 6:
            ch = Prompt ("Press a key for quiting the game");
            scr.config.eraseKey (kQuitGame);
            scr.config.bind (kQuitGame, ch);
            break;
        case 7:
            return;
        }
    }

}

//-----------------------------------------------------------------------------
class
            LevelSelector {
private:
    Screen &
    screenM;
public:
    LevelSelector (Screen & scr);
    void
    start ();
};
//-----------------------------------------------------------------------------
Menu::Menu (Screen & s, const std::string & title, bool showBigLogo):
        screenM (s),
        titleM (title),
        showBigLogoM (showBigLogo),
        currentItemM (0)
{
}

//-----------------------------------------------------------------------------
void
Menu::add (const std::string & item) {
    itemsM.push_back (item);
}

//-----------------------------------------------------------------------------
std::string Menu::getItemText (int index) {
    return itemsM[index];
}

//-----------------------------------------------------------------------------
int
Menu::count () {
    return itemsM.size ();
}

//-----------------------------------------------------------------------------
void
Menu::drawBigLogo () {
    std::string msg[] = {
        "                                        .00OOOOOOOOO'0o            ",
        "                      ..             000OOOOOOOO'88'OOO'0:         ",
        "                  .00OOO00         o0OOOOOOOOOOO':.  %8OOOp        ",
        "                 .'OOOOOOO.      _0OOOOOOOOOOOOOOO'Lu  A8OOp       ",
        "                 )OOOOOOOY      jOOOOOOOOOOOOOOOOOOO'''''08O0      ",
        "                  0'OO'%       jOOOOOOOOOOOOOOOOOOOOOOOOOOO'O',    ",
        "                 _0OOO:00000000'OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO'.   ",
        "                /'OOOOOOO'O'OO'OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO7   ",
        "               /'OO%AAA      0OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo  ",
        "              jOOOy          pOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo  ",
        "             jOO'y           uOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo  ",
        "            EOOO0/           -'OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO[  ",
        "          j'OO'OOO00u         pOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO'  ",
        "        /'OO'%u %'OO'0u       -'OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOy   ",
        "      .0OOO%u     %OOO7        -8OOOOOOOOOOOOOOOOOOOOOOOOOOOOOy    ",
        "     j'OO8'        pOO7         u0'OOOOOOOOOOOOOOOOOOOOOOOOO'y     ",
        "  o0'OO'%          'OO'            08OOOOOOOOOOOOOOOOOOOOO'8'      ",
        "EOOOOO8`          pOOO'p            uO%'OOOOOOOOOOOOOOOO'Y         ",
        "08OOO'y           8''88y                A8'OOOOOOOOOO'8%`          ",
        "                                            -UAA%8%%               "
    };
    color_set (1, 0);
    for (unsigned i = 0; i < sizeof (msg) / sizeof (std::string); ++i)
        mvprintw (i + 3, 13, "%s", msg[i].c_str ());
}

//-----------------------------------------------------------------------------
int
Menu::show () {
    while (true) {
        // render
        screenM.clear ();
        if (showBigLogoM)
            drawBigLogo ();
        screenM.printText (5, 3, titleM, fGame);

        int y = 5;
        for (ItemList::iterator it = itemsM.begin (); it != itemsM.end (); ++it)
            screenM.printText (5, y++, (*it), fMenu);
        screenM.printText (3, 5 + currentItemM, "*", fMenu);    // mark selected item
        move (5 + currentItemM, 3);
        screenM.render ();

        // process keys
        KeyType k = screenM.getChar ();
        if (k == kUp) {
            currentItemM--;
            if (currentItemM < 0)
                currentItemM = itemsM.size () - 1;
        } else if (k == kDown) {
            currentItemM++;
            if (currentItemM >= (int)itemsM.size ())
                currentItemM = 0;
        } else if (k == kButton) {
            return currentItemM;
        }
    }
    return -1;
}

//-----------------------------------------------------------------------------
class Game {
private:
    bool levelCompleteM;
    Screen & screenM;
public:
    Game (Screen & s, const std::string & levelName);
    bool levelComplete ();
};
//-----------------------------------------------------------------------------
bool
Game::levelComplete () {
    return levelCompleteM;
}

//-----------------------------------------------------------------------------
class Level;
class Player {
private:
    int xM;
    int yM;
public:
    Player (int x, int y);
    void render ();
    PlayerAction handleInput (KeyType key, Level & level);
};
//-----------------------------------------------------------------------------
class Level {
private:
    int goldNeededM;
    std::vector < std::string > mapM;
public:
    Level (const std::string & name, std::vector < Player > &players);
    void render ();
    void moveField (int x, int y, int dx, int dy);
    void setField (int x, int y, char f);
    char getField (int x, int y);
    int goldNeeded ();
    void addGold (int count);
};
//-----------------------------------------------------------------------------
Player::Player (int x, int y):
        xM (x),
        yM (y) {
}

//-----------------------------------------------------------------------------
void
Player::render () {
    attrset (A_BOLD);
    color_set (3, 0);
    mvprintw (yM + 3, xM + 3, "@");
    attrset (A_NORMAL);
}

//-----------------------------------------------------------------------------
PlayerAction
Player::handleInput (KeyType key, Level & level) {
    int dx = 0, dy = 0;
    switch (key) {
    case kUp:
        dy = -1;
        break;
    case kDown:
        dy = 1;
        break;
    case kLeft:
        dx = -1;
        break;
    case kRight:
        dx = 1;
        break;
    default:
        return paNone;
    }
    switch (level.getField (xM + dx, yM + dy)) {
    case '$':
        level.addGold (-1);
    case ' ':
        level.moveField (xM, yM, dx, dy);
        xM += dx;
        yM += dy;
        return paMoved;
    case 'O':
        // look beyond if we can push it
        if (level.getField (xM + 2 * dx, yM + 2 * dy) == ' ') {
            level.moveField (xM + dx, yM + dy, dx, dy); // move rock
            level.moveField (xM, yM, dx, dy);   // move player
            xM += dx;
            yM += dy;
            return paMoved;
        }
        return paNone;
    case 'h': {
        char c = level.getField (xM + 2 * dx, yM + 2 * dy);
        if (c == 'O' || c == 'h') {
            level.setField (xM + 2 * dx, yM + 2 * dy, ' '); // explode
            level.moveField (xM, yM, dx, dy);   // move player
            xM += dx;
            yM += dy;
            return paMoved;
        }
        if (c == ' ') {
            level.moveField (xM + dx, yM + dy, dx, dy); // move dynamite
            level.moveField (xM, yM, dx, dy);   // move player
            xM += dx;
            yM += dy;
            return paMoved;
        }
        return paNone;
    }
    case 'x':
        if (level.goldNeeded () < 1)
            return paLevelComplete;
        return paNone;
    }
    return paNone;
}

//-----------------------------------------------------------------------------
void
Level::setField (int x, int y, char f) {
    mapM[y][x] = f;
}

//-----------------------------------------------------------------------------
char
Level::getField (int x, int y) {
    return mapM[y][x];
}

//-----------------------------------------------------------------------------
void
Level::moveField (int x, int y, int dx, int dy) {
    char field = getField (x, y);
    setField (x, y, ' ');
    setField (x + dx, y + dy, field);
}

//-----------------------------------------------------------------------------
int
Level::goldNeeded () {
    return goldNeededM;
}

//-----------------------------------------------------------------------------
void
Level::addGold (int count) {
    goldNeededM += count;
    if (goldNeededM < 0)
        goldNeededM = 0;
}

//-----------------------------------------------------------------------------
Level::Level (const std::string & name, std::vector < Player > &players) {
    // load level from file, for each player found, create instance of Player
    players.clear ();
    mapM.clear ();
    goldNeededM = 0;
    std::string fileName = "levels/" + name;
    FILE *fp = fopen (fileName.c_str (), "rb");
    if (!fp) {
        Message ("Cannot open level file!");
        return;
    }
    int y = 0;
    char buffer[80];
    while (!feof (fp)) {
        if (!fgets (buffer, 80, fp))
            break;
        for (int x = 0; x < 80 && buffer[x] != '\n' && buffer[x] != '\0'; x++) {
            if (buffer[x] == ',')   // comments, ignore rest of the line
                break;
            if (buffer[x] == '@') {
                Player p (x, y);
                players.push_back (p);
            }
            if (buffer[x] == '$')
                goldNeededM++;
        }
        mapM.push_back (buffer);
        y++;
    }
}

//-----------------------------------------------------------------------------
void
Level::render () {
    clear ();
    int xpos = 3;
    int ypos = 3;
    for (std::vector < std::string >::iterator it = mapM.begin ();
            it != mapM.end (); ++it, ypos++) {
        // if (black&white)
        //mvprintw(ypos++, xpos, "%s", (*it).c_str());

        move (ypos, xpos);
        bool comment = false;
        bool bold = false;
        for (unsigned i = 0; i < (*it).length (); i++) {
            char c = (*it)[i];
            attrset (A_NORMAL);
            if (!comment) {
                switch (c) {
                case ',':
                    c = ' ';
                    comment = true;
                    break;
                case ';':
                    c = ' ';
                    comment = bold = true;
                    break;
                case '#':
                    color_set (1, 0);
                    break;
                case 'x':
                    color_set (2, 0);
                    break;
                case '@':
                    color_set (3, 0);
                    break;
                case 'h':
                    color_set (4, 0);
                    break;
                case '$':
                    attrset (A_BOLD);
                    color_set (1, 0);
                    break;
                };
            } else if (bold)    // bold comment
                attrset (A_BOLD);
            printw ("%c", c);
        }
    }
}

//-----------------------------------------------------------------------------
class GameState {
public:
    Level level;
    std::vector < Player > players;
    GameState (const Level & l, const std::vector < Player > &p):level (l),
            players (p) {
    }
};
//-----------------------------------------------------------------------------
Game::Game (Screen & s, const std::string & levelName):
        levelCompleteM (false),
        screenM (s)
{
    std::vector < Player > players; // there can be multiple on the screen
    // load levelName
    Level level (levelName, players);
    if (players.size () == 0) {
        Message ("Bad level, no players found!");
        return;
    }

    std::stack < GameState > undo;
    undo.push (GameState (level, players));

    std::vector < Player >::iterator currentPlayer = players.begin ();
    while (true) {
        level.render ();
        (*currentPlayer).render ();
        s.render ();

        // handle key press
        KeyType key = s.getChar ();
        switch (key) {
            // handle game-wide keys (like player switching)
        case kSwitchPlayer:
            if (++currentPlayer == players.end ())
                currentPlayer = players.begin ();
            break;

        case kQuitGame:
            return;

        case kUndo:
            if (undo.size () > 1) {
                undo.pop ();    // remove current state
                level = undo.top ().level;
                players = undo.top ().players;
            }
            break;
        default:        // handle player movement keys
            PlayerAction pa = (*currentPlayer).handleInput (key, level);
            if (pa == paLevelComplete) {
                levelCompleteM = true;
                Message ("Well done. Level completed.");
                return;
            }
            if (pa == paMoved) {
                // store undo buffer
                undo.push (GameState (level, players));
            }
        };
    }
}

//-----------------------------------------------------------------------------
LevelSelector::LevelSelector (Screen & s):screenM (s) {
    Menu
    m (s, "Select a level");
    // TODO: load all levels from 'levels' directory and sort them alphabetical
    /*
       m.add("Level 1 - Gold and Exit");
       m.add("Level 2 - Rocks");
       m.add("Level 3 - Dynamite");
       m.add("Level 4 - The Show Starts");
     */
    std::set < std::string > files;
    DIR *
    dir = opendir ("levels");
    if (!dir) {
        Message ("Cannot read levels from directory");
        return;
    }
    while (true) {
        struct dirent *
                    de = readdir (dir);
        if (!de)
            break;
        std::string filename (de->d_name);
        if (filename.find ("Level") == 0)   // starts with
            files.insert (filename);
    }
    closedir (dir);
    for (std::set < std::string >::iterator it = files.begin ();
            it != files.end (); ++it) {
        m.add (*it);
    }

    m.add ("Back to main menu");
    int
    result = m.show ();
    if (result == -1 || result >= m.count () - 1)
        return;

    while (true) {
        Game
        g (s, m.getItemText (result));
        if (g.levelComplete ()) {   // level completed
            result++;
            if (result < (m.count () - 1))
                continue;
            Message ("No more levels");
            return;
        } else          // exited
            return;
    }
}

//-----------------------------------------------------------------------------
int
main () {
    Screen
    s;
    if (!s.init ())
        return 1;

    Menu
    m (s, "Welcome to nPush", true);
    m.add ("Start a new game");
    m.add ("Configure controls");
    m.add ("Quit");

    while (true) {
        int
        result = m.show ();
        if (result == 0) {
            LevelSelector
            ls (s);
            continue;
        } else if (result == 1) {
            ControlsConfigurator
            cc (s);
            continue;
        }
        break;
    }
    return 0;
}

//-----------------------------------------------------------------------------
