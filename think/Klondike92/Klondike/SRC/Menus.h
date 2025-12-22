struct IntuiText text1 =
{ 0, 1, JAM2, 0, 1, NULL, "Quit", NULL };
struct IntuiText text2 =
{ 0, 1, JAM2, 0, 1, NULL, "About", NULL };
struct IntuiText text3 =
{ 0, 1, JAM2, 0, 1, NULL, "New", NULL };
struct IntuiText text4 =
{ 0, 1, JAM2, 0, 1, NULL, "Play", NULL };

struct MenuItem item1 =
{ NULL,   0, 36, 100, 12, ITEMTEXT|ITEMENABLED|COMMSEQ|HIGHCOMP, 0, (APTR) &text1, NULL, 'Q', NULL, 0 };
struct MenuItem item2 =
{ &item1, 0, 24, 100, 12, ITEMTEXT|ITEMENABLED|HIGHCOMP, 0, (APTR) &text2, NULL, NULL, NULL, 0 };
struct MenuItem item3 =
{ &item2, 0, 12, 100, 12, ITEMTEXT|ITEMENABLED|COMMSEQ|HIGHCOMP, 0, (APTR) &text3, NULL, 'N', NULL, 0 };
struct MenuItem item4 =
{ &item3, 0, 0,  100, 12, ITEMTEXT|ITEMENABLED|COMMSEQ|HIGHCOMP, 0, (APTR) &text4, NULL, 'P', NULL, 0 };

struct IntuiText text11 =
{ 0, 1, JAM2, CHECKWIDTH, 1, NULL, "1 At A Time", NULL };
struct IntuiText text12 =
{ 0, 1, JAM2, CHECKWIDTH, 1, NULL, "Cycle Deck", NULL };
struct IntuiText text13 =
{ 0, 1, JAM2, CHECKWIDTH, 1, NULL, "Extra Sounds", NULL };
struct IntuiText text14 =
{ 0, 1, JAM2, CHECKWIDTH, 1, NULL, "Card Sounds", NULL };

struct MenuItem item11 =
{ NULL,    0, 36, 150, 12, ITEMTEXT|ITEMENABLED|CHECKIT|CHECKED|MENUTOGGLE|COMMSEQ|HIGHCOMP, 0, (APTR) &text11, NULL, 'D', NULL, 0 };
struct MenuItem item12 =
{ &item11, 0, 24, 150, 12, ITEMTEXT|ITEMENABLED|CHECKIT|CHECKED|MENUTOGGLE|COMMSEQ|HIGHCOMP, 0, (APTR) &text12, NULL, 'C', NULL, 0 };
struct MenuItem item13 =
{ &item12, 0, 12, 150, 12, ITEMTEXT|ITEMENABLED|CHECKIT|CHECKED|MENUTOGGLE|COMMSEQ|HIGHCOMP, 0, (APTR) &text13, NULL, 'E', NULL, 0 };
struct MenuItem item14 =
{ &item13, 0,  0, 150, 12, ITEMTEXT|ITEMENABLED|CHECKIT|CHECKED|MENUTOGGLE|COMMSEQ|HIGHCOMP, 0, (APTR) &text14, NULL, 'S', NULL, 0 };



struct Menu menu2 =
{ NULL, 80, 0, 60, 0, MENUENABLED, "Options", &item14, 0, 0, 0, 0 };

struct Menu my_menu =
{ &menu2, 0, 0, 60, 0, MENUENABLED, "Project", &item4, 0, 0, 0, 0 };
