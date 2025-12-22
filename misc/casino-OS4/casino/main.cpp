#include <Fl/Fl.h>
#include <Fl/fl_ask.h>

#include "mainwindow.h"
#include "cards.h"

#ifdef __amigaos4__
#include <exec/types.h>

CONST STRPTR __attribute__((used)) VerStr = "$VER:Casino 0.1 26-May-2005";
CONST STRPTR __attribute__((used)) Stack  = "$STACK:65536\n";
#endif

char card_path[256]="cards/default/";
//char card_path[256]="cards\\default\\";

int main(int argc,char *argv[])
{
    if (!init_cards(card_path)){
        fl_alert("Error loading cards!");
        return 1;
    }

    Fl_Window *w=make_window();
    w->size_range(480,400);
    w->show(argc,argv);

    init_boxes();
    init_game();

    return Fl::run();
}

