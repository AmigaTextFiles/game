unsigned int x, w = 11 , h = 11;
Uint8 *grille, *refresh;
Uint8 quit = 0, joueur = 1, fulldraw = 1, ai = 0;
Uint32 color;
SDL_Event event;
SDL_Surface *screen;
SDL_Rect dest;
SDL_Surface *fond, *jeton, *bleus, *rouges;
struct move {
    Uint8 srcx, srcy, dstx, dsty, atak, dist;
};

Uint8 voisins(Uint8 posx, Uint8 posy, Uint8 bad, Uint8 dist); /* renvoies le nombre de voisins */
void virus(Uint8 posX, Uint8 posY); /* infecte les pions voisins */
struct move voisin(Uint8 posx, Uint8 posy, Uint8 bad); /* renvoies le meilleur proche */
struct move best_move(int play); /* renvoies le meilleur coup */
void affiche(); /* affiche les cases à raffraichir */
