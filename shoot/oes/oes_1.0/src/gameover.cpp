///////////////////////////////////////////////
// 
//  Snipe2d ludum dare 48h compo entry
//
//  Jari Komppa aka Sol 
//  http://iki.fi/sol
// 
///////////////////////////////////////////////
// License
///////////////////////////////////////////////
// 
//     This software is provided 'as-is', without any express or implied
//     warranty.    In no event will the authors be held liable for any damages
//     arising from the use of this software.
// 
//     Permission is granted to anyone to use this software for any purpose,
//     including commercial applications, and to alter it and redistribute it
//     freely, subject to the following restrictions:
// 
//     1. The origin of this software must not be misrepresented; you must not
//        claim that you wrote the original software. If you use this software
//        in a product, an acknowledgment in the product documentation would be
//        appreciated but is not required.
//     2. Altered source versions must be plainly marked as such, and must not be
//        misrepresented as being the original software.
//     3. This notice may not be removed or altered from any source distribution.
// 
// (eg. same as ZLIB license)
//
///////////////////////////////////////////////
//
// Houses are taken from a satellite picture of glasgow.
//
// The sources are a mess, as I didn't even try to do anything
// really organized here.. and hey, it's a 48h compo =)
//
#include "snipe2d.h"

extern PREFS gPrefs;

void fillrect(int x1, int y1, int x2, int y2, int color)
{
    SDL_Rect r;
    r.x = x1;
    r.y = y1;
    r.w = x2-x1;
    r.h = y2-y1;
    int sdlcolor = SDL_MapRGB(Game.Screen->format, 
                              (color >> 16) & 0xff,
                              (color >> 8) & 0xff,
                              (color >> 0) & 0xff);
    SDL_FillRect(Game.Screen, &r, sdlcolor);
}


#if 0
void gameoverscreen(int aReason)
{
    Game.BGM.depress();
    process_hiscore();
    Game.GameState = 0;
    SDL_ShowCursor (1);
    fillrect(0,0,640,480,0);
    fillrect(159,59,437,421,0x007f00);
    fillrect(160,60,436,420,0x003f00);
    fillrect(159,80,437,81,0x007f00);
    print(290, 68, COLOR_GREEN, "game over");
    print(260 + 12, 412, COLOR_GREEN, "press ESC to quit");
    int row = 88 + 40;
    bool vertical_buttons = true;
    switch (aReason)
    {
    case 0:
        printShadow(240, row, "You left your post!"); row += 8;
        break;
    case 1:
        printShadow(240, row, "You shot a VIP!"); row += 8;
        break;
    case 2:
        printShadow(240, row, "You let a VIP die!"); row += 8;
        break;
    }
    row += 8;
    printShadow(240, row, "The VIP protection bureau has found your "); row += 8;
    printShadow(240, row, "actions unacceptable, and thus has decided"); row += 8;
    printShadow(240, row, "to let you go."); row += 8;
    row += 8;
    print(240, row, (Game.Score<=0)?COLOR_RED:COLOR_GREEN, "Your final score was: %d", Game.Score); row += 8;
    row += 8;
    row += 8;
    row += 8;
    switch (gPrefs.difficulty)
	{
	case 1:
	    printShadow(240, row, "Difficulty: Easy");
	    break;
	case 2:
	    printShadow(240, row, "Difficulty: Medium");
	    break;
	case 3:
	    printShadow(240, row, "Difficulty: Hard");
	    break;
	}
    row += 8;
    printShadow(240, row, "Based on your score, your retirement will be:"); row += 8;
    row += 8;
    if (Game.Score < -10000)
        printShadow(240, row, "Slow and extremely painful."); 
    else
    if (Game.Score < 0)
        printShadow(240, row, "Quick and painless."); 
    else
    if (Game.Score < 25000)
        printShadow(240, row, "Poor."); 
    else
    if (Game.Score < 50000)
        printShadow(240, row, "Decent."); 
    else
    if (Game.Score < 100000)
        printShadow(240, row, "Above average."); 
    else
        printShadow(240, row, "Welcome to heaven, baby!"); 
    row += 8;
    row += 8;
    row += 8;
    row += 8;
    printShadow(240, row, "Stats:"); row += 8;
    row += 8;
    printShadow(240, row, "Threats neutralized:%4d", Game.baddy.dead); row += 8;
    printShadow(240, row, "VIPs with safe trip:%4d", Game.vip.goal); row += 8;
    printShadow(240, row, "Pedestrians wasted: %4d", Game.pedestrian.dead); row += 8;
    printShadow(240, row, "Game time:         %02d:%02d", ((SDL_GetTicks() -
    Game.GameStartTick) / 60000), ((SDL_GetTicks() - Game.GameStartTick) / 1000)%60); row += 8;




    int i = 0;
    for (i = 0; i < 56; i++)
        print(162, 83 + i * 6, COLOR_YELLOW, "%u%u", rand(), rand());
    SDL_Flip(Game.Screen);    
    int startTick = SDL_GetTicks();
    while (1)
    {
        SDL_Event event;
        while ( SDL_PollEvent(&event) ) 
        {
            switch (event.type) 
            {
            case SDL_KEYUP:
                if (event.key.keysym.sym == SDLK_ESCAPE)
                    exit(0);
	    case SDLK_F12:
		show_hiscores();
                break;
            case SDL_MOUSEBUTTONUP:
                if (!((SDL_GetTicks() - startTick) > 500))
		    continue;
		if (vertical_buttons)
		    {
			if (hovering (456, 166, 174, 24))
			    {
				return;
			    }
			if (hovering (456, 328, 174, 24))
			    {
				std::cout<< "Exiting normally\n";
				exit (0);
			    }
			if (hovering (456, 274, 174, 24))
			    {
				show_hiscores();
				vertical_buttons = false;
			    }
			if (hovering (456, 220, 174, 24))
			    {
				// create prefs window here
			    }
		    } else {
			if (hovering (29, 446, 174, 24))
			    {
				return;
			    }
			if (hovering (238, 446, 174, 24))
			    {
				// create prefs window (again, hehe)
			    }
			if (hovering (437, 446, 174, 24))
			    {
				std::cout<<"Exiting normally\n";
				exit (0);
			    }
		    }
                break;
            case SDL_QUIT:
                exit(0);
            }
	    if (vertical_buttons)
		{
		    if (!hovering (456, 166, 174, 24))
			draw_button (gButton.startgame, 440, 160);
		    else
			draw_button (gButton.startgameh, 440, 160);
		    if (!hovering (456, 220, 174, 24))
			draw_button (gButton.prefs, 440, 214);
		    else
			draw_button (gButton.prefsh, 440, 214);
		    if (!hovering (456, 274, 174, 24))
			draw_button (gButton.hiscores, 440, 268);
		    else
			draw_button (gButton.hiscoresh, 440, 268);
		    if (!hovering (456, 328, 174, 24))
			draw_button (gButton.quit, 440, 322);
		    else
			draw_button (gButton.quith, 440, 322);
		} else {
		    if (!hovering (29, 446, 174, 24))
			draw_button (gButton.startgame, 13, 440);
		    else
			draw_button (gButton.startgameh, 13, 440);
		    if (!hovering (238, 446, 174, 24))
			draw_button (gButton.prefs, 222, 440);
		    else
			draw_button (gButton.prefsh, 222, 440);
		    if (!hovering (437, 446, 174, 24))
			draw_button (gButton.quit, 431, 440);
		    else
			draw_button (gButton.quith, 431, 440);
		}
	    SDL_Flip (Game.Screen);
        }
    }
}
#endif /* 0 */


int
draw_gameover (SDL_Surface *screen, const SDL_Rect *r)
{
  bool vertical_buttons = true;
  int row, i, min, sec, ticks;
  const char *reason;
  const char *pension;
  int x, y, w, h;
  int xp, xq, yp, yq;  /* horizontal, vertical scaling (p/q) */

  x = r->x; y = r->y; w = r->w; h = r->h;
  /* map  640 * p/q  =>  screen->w */
  xp = screen->w;
  yp = screen->h;
  xq = 640;
  yq = 480;
//  Game.GameOverTicks = SDL_GetTicks();
  process_hiscore();
//  Game.BGM.depress();
  Game.GameState = 0;
  SDL_ShowCursor (1);
#define X(n) (x + n * xp / xq)
#define Y(n) (y + n * yp / yq)
  oes_fillrect(screen, X(0), Y(0), X(640), Y(480), 0);
  oes_fillrect(screen, X(159), Y(59), X(437), Y(421), 0x007f00);
  oes_fillrect(screen, X(160), Y(60), X(436), Y(420), 0x003f00);
  oes_fillrect(screen, X(159), Y(80), X(437), Y(81), 0x007f00);
  print(X(290), Y(68), COLOR_GREEN, "game over");
  print(X(260 + 12), Y(412), COLOR_GREEN, "press ESC to quit");
  row = 88 + 40;

  switch (Game.GameOverReason)
    {
      case OESREASON_AWOL: reason = "You left your post!";      break;
      case OESREASON_FRAG: reason = "You shot a VIP!";          break;
      case OESREASON_NEGLIGENT: reason = "You let a VIP die!";  break;
      default: reason = "(invalid)"; break;
    }
  printShadow(X(240), Y(row), reason); row += 8;
  row += 8;
  printShadow(X(240), Y(row), "The VIP protection bureau has found your "); row += 8;
  printShadow(X(240), Y(row), "actions unacceptable, and thus has decided"); row += 8;
  printShadow(X(240), Y(row), "to let you go."); row += 8;
  row += 8;
  print(X(240), Y(row), (Game.Score<=0)?COLOR_RED:COLOR_GREEN, "Your final score was: %d", Game.Score); row += 8;
  row += 8;
  row += 8;
  row += 8;
  switch (gPrefs.difficulty)
    {
      case 1:
        printShadow(X(240), Y(row), "Difficulty: Easy");
        break;
      case 2:
        printShadow(X(240), Y(row), "Difficulty: Medium");
        break;
      case 3:
        printShadow(X(240), Y(row), "Difficulty: Hard");
        break;
    }
  row += 8;
  printShadow(X(240), Y(row), "Based on your score, your retirement will be:"); row += 8;
  row += 8;
  if (0);
  else if (Game.Score < -10000) pension = "Slow and extremely painful.";
  else if (Game.Score < 0) pension = "Quick and painless.";
  else if (Game.Score < 25000) pension = "Poor.";
  else if (Game.Score < 50000) pension = "Decent.";
  else if (Game.Score < 100000) pension = "Above average.";
  else pension = "Welcome to heaven, baby!";
  printShadow(X(240), Y(row), pension); row += 8;
  row += 8;
  row += 8;
  row += 8;
  printShadow(X(240), Y(row), "Stats:"); row += 8;
  row += 8;
  printShadow(X(240), Y(row), "Threats neutralized:%4d", Game.baddy.dead); row += 8;
  printShadow(X(240), Y(row), "VIPs with safe trip:%4d", Game.vip.goal); row += 8;
  printShadow(X(240), Y(row), "Pedestrians wasted: %4d", Game.pedestrian.dead); row += 8;
  ticks = Game.GameOverTicks - Game.GameStartTick;
  min = ticks / 60000;
  sec = (ticks % 1000) % 60;
  printShadow(240, row, "Game time:         %02d:%02d", min, sec); row += 8;

  for (i = 0; i < 56; i++)
      print(X(162), Y(83 + i * 6), COLOR_YELLOW, "%u%u", rand(), rand());

#undef X
#undef Y
  return 1;
}
