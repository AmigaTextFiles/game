/*
   ATAKKS!
licence: GPL version 2 (ou supérieure)
type: Jeu de reflexion chinoi, ATAXX-like. (connu aussi sous le nom de VIRUS)
librairie(s) necessaire(s): SDL [www.libsdl.org]
date de création: Juillet 2001
OS supportés: tous ceux disposant d'un port de gcc et de SDL
		(*BSD, Linux (OS POSIX), Win32, MacOS ?, Playstation 2, etc...)
		[jouer à ataxx sur une PS2 ca déchire ;) ]
Createur: Devaux Fabien (fab@gcu-squad.org)
Site: http://team.gcu-squad.org/~fab
   */
#include<sdl/SDL.h>
#include<unistd.h>
#include<stdlib.h>		/* atexit */
#include "defs.h"
#define US
void virus(Uint8 posX, Uint8 posY)
{
    Uint8 minx, miny,n;
    SDL_Rect src,dst;
    src.w=43;
    src.h=43;
    src.y=0;
    affiche();
    for (minx = posX - 1 > 0 ? posX - 1 : 0; minx <= posX + 1 && minx < w;
	 minx++)
	for (miny = posY - 1 > 0 ? posY - 1 : 0;
	     miny <= posY + 1 && miny < h; miny++)
	    if (grille[w * miny + minx] > 0) {
		if(grille[w * miny + minx]!=joueur) { /* si pion énemi */
		    dst.x=minx*fond->w;
		    dst.y=miny*fond->h;
		    if(joueur==1) { /* si joueur rouge lire a l'endroit */
			for(n=0;n<16;n++) {
			    src.x=(15-n)*43;
			    SDL_BlitSurface(jeton,&src,screen,&dst);
			    SDL_UpdateRect(screen,dst.x,dst.y,43,43);
			    SDL_Delay(50);
			}
		    }
		    if(joueur==2) { /* sinon lire à l'envers */
			for(n=0;n<16;n++) {
			    src.x=n*43;
			    SDL_BlitSurface(jeton,&src,screen,&dst);
			    SDL_UpdateRect(screen,dst.x,dst.y,43,43);
			    SDL_Delay(50);
			}

		    }
		}
		grille[w * miny + minx] = joueur;
		refresh[w * miny + minx] = 1;
	    }
}

Uint8 voisins(Uint8 posx, Uint8 posy, Uint8 bad, Uint8 dist)
{
    unsigned int y, nb = 0, b;
    for (b = posx - dist > 0 ? posx - dist : 0; b <= posx + dist && b < w;
	 b++)
	for (y = posy - dist > 0 ? posy - dist : 0;
	     y <= posy + dist && y < h; y++)
	    if(bad==0) {
		if (grille[w * y + b] == bad) nb++;
	    }
	    else if (grille[w * y + b] == bad || grille[w * y + b] == bad + 2)
		nb++;
    return nb;
}
struct move voisin(Uint8 posx, Uint8 posy, Uint8 bad)
{
    struct move coord;
    unsigned int y;
    coord.dstx = posx;
    coord.dsty = posy;
    if (voisins(posx, posy, bad, 1)) {
	for (x = posx - 1 > 0 ? posx - 1 : 0; x <= posx + 1 && x < w; x++)
	    for (y = posy - 1 > 0 ? posy - 1 : 0; y <= posy + 1 && y < h;
		 y++)
		if (grille[w * y + x] == bad || grille[w * y + x] ==
		    bad + 2) {
		    coord.srcx = x;
		    coord.srcy = y;
		}
    } else {
	for (x = posx - 2 > 0 ? posx - 2 : 0; x <= posx + 2 && x < w; x++)
	    for (y = posy - 2 > 0 ? posy - 2 : 0; y <= posy + 2 && y < h;
		 y++)
		if (grille[w * y + x] == bad || grille[w * y + x] ==
		    bad + 2) {
		    coord.srcx = x;
		    coord.srcy = y;
		}
    }
    return coord;
}
struct move best_move(int play)
{
    Uint8 maxnb = 0, nb, y, bad, bestdist = 2;
    unsigned int a, *np, n = 1;
    struct move mv, *oula;
    oula = calloc(w * h, sizeof(mv));
    np = calloc(n, sizeof(a));
    if (play == 1)
	bad = 2;
    else
	bad = 1;
    for (a = 0; a < w * h; a++) {
	y = (int) (a / w);
	/* trouve la 1ere case vide accessible aux pions */
	/* modifs à faire: se foutre du nombre de pions freres et sellectionner en fonction
	   du nb de pions bad */
	/*
	   maxnb == nb de hits MAXI
	 */
	if (grille[a] == 0 && voisins(a - (y * w), y, play, 2)) {	/* si case vide et accessible */
	    oula[a].atak = voisins(a - (y * w), y, bad, 1);	/* compter les enemis proches */
	    if (maxnb < oula[a].atak)
		bestdist = 2;
	    if (maxnb <= oula[a].atak) {
		maxnb = oula[a].atak;	/* enregistrer le nb de hits MAXI */
	    }
	    oula[a].dstx = a - (y * w);
	    oula[a].dsty = y;
	    oula[a].dist = 2;
	    if (voisins(a - (y * w), y, play, 1)) {	/* si accessible + pres  et fait le meme effet */
		oula[a].dist = 1;
	    }
	}
	if (grille[a] == 0 && voisins(a - (y * w), y, play, 1)) {	/* si case vide et accessible + pres */
	    if (maxnb <= oula[a].atak)
		bestdist = 1;
	    oula[a].dist = 1;
	}
    }
    n = 0;
    for (a = 0; a < w * h; a++) {
	if (maxnb == oula[a].atak && oula[a].dist == bestdist) {
	    n++;
	    np = realloc(np, n * sizeof(a));
	    np[n - 1] = a;	/* np stok les positions des coups */
	}
    }
#ifdef DEBUG
    printf("%d sollutions. rand=%i\n", n,
	   (int) ((n - 1.0) * (float) rand() / RAND_MAX));
#endif
    nb = np[(int) ((n - 1.0) * (float) rand() / RAND_MAX)];
    mv = voisin(nb - (int) (nb / w) * w, (int) (nb / w), play);
    mv.atak = maxnb;
    mv.dist = oula[nb].dist;

    /* si OK chercher le meilleur coup pour la case */
    return mv;
}

void affiche()
{

    SDL_Rect src;
    dest.w = fond->w;
    dest.h = fond->h;
    dest.x = 0;
    dest.y = 0;
    src.w=43;
    src.h=43;
    src.y=0;

    /* dessinne la couleur du joueur (rouge/bleu) */
    SDL_FillRect(screen, NULL, color);
    for (x = 0; x < w * h; x++) {
	if (!(dest.x % (w * fond->w)) && dest.x != 0) {
	    dest.x = 0;
	    dest.y += fond->h;
	}
	switch (grille[x]) {
	case 0:
	    SDL_BlitSurface(fond, NULL, screen, &dest);
	    break;
	case 1:
	    src.x=0;
	    SDL_BlitSurface(jeton, &src, screen, &dest);
	    break;
	case 2:
	    src.x=15*43;
	    SDL_BlitSurface(jeton, &src, screen, &dest);
	    break;
	case 3:
	    SDL_BlitSurface(rouges, NULL, screen, &dest);
	    break;
	case 4:
	    SDL_BlitSurface(bleus, NULL, screen, &dest);
	    break;
	}
	if (refresh[x])
	    SDL_UpdateRect(screen, dest.x, dest.y, fond->w, fond->h);
	refresh[x] = 0;
	dest.x += fond->w;
    }
    SDL_UpdateRect(screen, 0, w * fond->w, fond->h * h, 2);
    if (fulldraw) {
	SDL_UpdateRect(screen, 0, 0, 0, 0);
	fulldraw = 0;
    }
}
int main(int argc, char **argv)
{
    struct move hoho;
    Uint8 caseX, caseY,selx, sely, checked = 0,  canmove = 1;
    SDL_Surface *ico;
    int pions1=0, pions2=0;
    if (SDL_Init(SDL_INIT_VIDEO) == -1) {

#ifndef US
	printf("Impossible d'initialiser l'écran.\n");
#else
	printf("Error during screen initialisation.\n");

#endif				/*  */
	return -1;
    }
    for (x = 1; x < argc; x++) {
	if (!strcmp(argv[x], "-ai"))
	    ai = 1;
	if (!strcmp(argv[x], "-t")) {
	    if (argv[x + 1] == NULL || argv[x + 2] == NULL) {
		printf("Syntax error! Try %s -h\n", argv[0]);
		continue;
	    }
	    w = atoi(argv[x + 1]);
	    h = atoi(argv[x + 2]);
	}
	if (!strcmp(argv[x], "-h")) {

#ifndef US
	    printf
		("\nSyntaxe: %s OPTIONS\n\n options:\n-h\t\tAffiche l'aide\n-t n1 n2\tDéfinit largeur=n1 et hauteur=n2\n-ai\t\tActive le mode 1 joueur, touche [i] pendant le jeu.\n\n",
		 argv[0]);
#else
	    printf
		("\nSyntax: %s OPTIONS\n\n options:\n-h\t\tPrint help\n-t n1 n2\tSet width=n1 and height=n2\n-ai\t\tActivate 1 player mode, [i] key during game.\n\n",
		 argv[0]);

#endif				/*  */
	    exit(1);
	}
    }
    atexit(SDL_Quit);
   ico = SDL_LoadBMP("icon.bmp");
    fond = SDL_LoadBMP("fond.bmp");
    jeton = SDL_LoadBMP("jeton.bmp");
    bleus = SDL_LoadBMP("bleus.bmp");
    rouges = SDL_LoadBMP("rouges.bmp");
    
    if (fond == NULL || jeton == NULL || rouges == NULL
	|| bleus == NULL || ico == NULL) {

#ifndef US
	printf("Impossible de charger les images.\n");

#endif				/*  */
#ifdef US
	printf("Error loading pictures.\n");

#endif				/*  */
	exit(-1);
    }
    SDL_WM_SetCaption("Atakks", "Atakks");
    SDL_WM_SetIcon(ico, 0);
    screen =
	SDL_SetVideoMode(fond->w * w, fond->h * h + 2, 16,
			 SDL_SWSURFACE );
    if (screen == NULL) {
	printf("prout!\n");
	exit(-1);
    }
    SDL_ShowCursor(SDL_ENABLE);
    srand(SDL_GetTicks());

    /* initialise la grille */
    if ((grille = (Uint8 *) calloc(w * h, sizeof(Uint8))) == NULL) {
	printf("Memory error.\n");
	exit(-1);
    }
    if ((refresh = (Uint8 *) calloc(w * h, sizeof(Uint8))) == NULL) {
	printf("Memory error.\n");
	exit(-1);
    }

    /*dessinne le fond - position initalle des joueurs */
    grille[0] = 1;
    grille[w - 1] = 1;
    grille[(w * h) - 1] = 2;
    grille[(w * h) -w] = 2;

    /******** MAIN LOOP *********/
    while (!quit) {
	/* comptage des pions des joueurs */

    pions1=pions2=0;
	for (x = 0; x < w * h; x++)
	    switch (grille[x]) {
	    case 1:
		pions1++;
		break;
	    case 3:
		pions1++;
		break;
	    case 2:
		pions2++;
		break;
	    case 4:
		pions2++;
		break;
	    }
	if (joueur == 1) {
	    color = SDL_MapRGB(screen->format, 255, 0, 0);
	} else {
	    color = SDL_MapRGB(screen->format, 0, 0, 255);
	}
	while (SDL_PollEvent(&event))
	    switch (event.type) {
		case SDL_QUIT:
		    if(event.quit.type==SDL_QUIT) quit=1;
	    case SDL_KEYDOWN:
		if (event.key.keysym.sym == SDLK_ESCAPE
		    || event.key.keysym.sym == SDLK_q)
		    quit = 1;
		if (event.key.keysym.sym == SDLK_i) {
		    if (ai == 0)
			ai = 1;

		    else
			ai = 0;
		}
		break;
	    case SDL_MOUSEBUTTONDOWN:
		caseX = (int) event.motion.x / fond->w;
		caseY = (int) event.motion.y / fond->h;
		if (grille[caseY * w + caseX] == joueur) {
		    for (x = 0; x < w * h; x++)
			if (grille[x] > 2) {
			    refresh[x] = 1;
			    grille[x] -= 2;
			}
		    grille[caseY * w + caseX] = joueur + 2;
		    checked = 1;
		    selx = caseX;
		    sely = caseY;
		    refresh[caseY * w + caseX] = 1;
		} else if (grille[caseY * w + caseX] == 0 && checked == 1) {

		    /* si à coté créer nouveau pion */
		    if (abs(selx - caseX) < 2 && abs(sely - caseY) < 2) {
			grille[caseY * w + caseX] = joueur;
			for (x = 0; x < w * h; x++)
			    if (grille[x] > 2) {
				refresh[x] = 1;
				grille[x] -= 2;
			    }
			refresh[caseY * w + caseX] = 1;
			virus(caseX, caseY);
			if (joueur == 1)
			    joueur = 2;

			else
			    joueur = 1;
			checked = 10;
		    }

		    /* si loins déplacer pion */
		    else if (abs(selx - caseX) <= 2
			     && abs(sely - caseY) <= 2) {
			grille[caseY * w + caseX] = joueur;
			grille[sely * w + selx] = 0;
			for (x = 0; x < w * h; x++)
			    if (grille[x] > 2)
				grille[x] -= 2;
			refresh[sely * w + selx] = 1;
			refresh[caseY * w + caseX] = 1;
			virus(caseX, caseY);
			if (joueur == 1)
			    joueur = 2;

			else
			    joueur = 1;
			checked = 10;
		    }
		}
		break;
	    }
	if (joueur == 2 && ai && checked != 10) {	/* si AI alors (attends un tour) ... */
	    hoho = best_move(joueur);
	    if (hoho.dist == 1) {
		grille[hoho.dsty * h + hoho.dstx] = joueur;
		refresh[hoho.dsty * h + hoho.dstx] = 1;
	    } else {
		grille[hoho.srcy * h + hoho.srcx] = 0;
		refresh[hoho.srcy * h + hoho.srcx] = 1;
		grille[hoho.dsty * h + hoho.dstx] = joueur;
		refresh[hoho.dsty * h + hoho.dstx] = 1;
	    }
	    virus(hoho.dstx, hoho.dsty);
	}
#ifdef DEBUG
	if (joueur == 2)
	    printf
		("\rMeilleur coup joueur %d = [%3d;%2d] -> [%2d;%2d] %d HITS",
		 joueur, hoho.srcx, hoho.srcy, hoho.dstx, hoho.dsty,
		 hoho.atak);
#endif				/*  */
	affiche();
	if (joueur == 2 && ai && checked != 10)
	    joueur = 1;
	if (checked == 10 && joueur == 2) {	/* si on joues contre l'AI laisser le tmp de matter */
	    SDL_Delay(100);
	    checked = 0;
	}
	/* qques regles */
	if (pions1 == 0) {
	    printf("Red player is a looser !\n");
	    quit = 1;
	}
	if (pions2 == 0) {
	    printf("Blue player is a looser!\n");
	    quit = 1;
	}

	canmove = 0;
	for (x = 0; x < w * h; x++)
	    if (grille[x] == joueur || grille[x] == joueur + 2)
		    if (voisins(x - (int) (x / w) * w, (int) x / w, 0, 2)) canmove=111;
	if (canmove == 0) {
	    printf("Le joueur %d est immobilisé !\n", joueur);
	    quit = 1;
	}
	/* vérifies si il y a encore des cases vides */
	canmove = 0;
	for (x = 0; x < w * h; x++)
	    if (grille[x] == 0)
		canmove = 1;
	if (canmove == 0) {
	    printf("Le jeu est terminé !\n");
	    quit = 1;
	}
	/* /qques regles */

    }
    /* fin de grosse boucle */

#ifdef DEBUG
    for (x = 0; x < w * h; x++) {
	if (!(x % w))
	    printf("\n");
	printf("[%d]", grille[x]);
    }
    printf("\n");

#endif				/*  */
    printf("\nScore: Red %d ; Blue %d\n\nPress any key to exit.\n", pions1,
	   pions2);
    while (event.type != SDL_KEYDOWN)
	SDL_PollEvent(&event);
    return 0;
}
