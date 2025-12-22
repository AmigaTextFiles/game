/*
##########################################
#         TriMines version 1.3.0         #
#                                        #
#         menu.c - game menu.            #
#                                        #
##########################################
*/

void menu()
{
SDL_Event event;

int mode;


screen = SDL_SetVideoMode(640, 480, 24, SDL_SWSURFACE);
    if ( screen == NULL ) {
        fprintf(stderr, "Unable to set 640x480 video: %s\n", SDL_GetError());
        exit(1);
    }

ShowBMP(Imenu, screen, 0,0);
ShowBMP(Imenu_newgame, screen, 40,178);


mode = 1;

out = 0;

drawcounter(boardx,502,195);
drawcounter(boardy,502,254);
drawcounter(mines,502,313);

while (SDL_WaitEvent(&event) != 0 && out == 0){

// MOUSE CLICKS:

	switch (event.type) {

      case SDL_KEYDOWN:
		switch (event.key.keysym.sym) {
			
			case SDLK_UP:
					
					switch (mode) {
					case 2: mode = 1; break;
					case 3: mode = 2; break;
					case 5: mode = 4; break;
					case 6: mode = 5; break;
					case 1: mode = 3; break;
					case 4: mode = 6; break;
					}					
					
					break;
					
			case SDLK_DOWN:
					
					switch (mode) {
					case 1: mode = 2; break;
					case 2: mode = 3; break;
					case 4: mode = 5; break;
					case 5: mode = 6; break;
					case 3: mode = 1; break;
					case 6: mode = 4; break;
					}
						
					break;
					
			case SDLK_RETURN:
					
					switch (mode) {
					case 1: out = 1; break;
					case 2: mode = 4; break;
					case 3: exit(0); break;
					case 4: mode = 2; break;
					case 5: mode = 2; break;
					case 6: mode = 2; break;
					}
					
					break;
			
			case SDLK_ESCAPE: exit(0); break;
					
			case SDLK_RIGHT:
			
					if (mode == 4) {if (boardx < 66)
					{boardx++; mines = (boardx * boardy) * minesprecents;}
				} else {
					if (mode == 5) {if (boardy < 26)
						{boardy++; mines = (boardx * boardy) * minesprecents;}
					} else {
						if (mode == 6) {if (mines < ((boardx * boardy) * minesprecents)-1){mines++;}
																																							}}}
					break;
					
			case SDLK_LEFT:
			
					if (mode == 4) {if (boardx > 23)
					{boardx--; mines = (boardx * boardy) * minesprecents;}
					} else {
					if (mode == 5) {if (boardy > 10)
						{boardy--; mines = (boardx * boardy) * minesprecents;}
					} else {
						if (mode == 6) {if (mines != 1){mines--;}
																												}}}
					break;
			
			default:
					
					break;
			}


	
		drawcounter(boardx,502,195);
		drawcounter(boardy,502,254);
		drawcounter(mines,502,313);
		
		switch (mode) {
		case 1: ShowBMP(Imenu_newgame, screen, 40, 178); break;
		case 2: ShowBMP(Imenu_options, screen, 40, 178); break;
		case 3: ShowBMP(Imenu_quit, screen, 40, 178); break;
		case 4: ShowBMP(Imenu_width, screen, 40, 178); break;
		case 5: ShowBMP(Imenu_height, screen, 40, 178); break;
		case 6: ShowBMP(Imenu_mines, screen, 40, 178); break;
		}
		
		break; // end case SDL_KEYDOWN
		case SDL_QUIT:
		exit(0);
		break;
		
	}
}

}
