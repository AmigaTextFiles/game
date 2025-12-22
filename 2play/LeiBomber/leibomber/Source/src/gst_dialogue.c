#include <assert.h>
#include <string.h>
#include <SDL/SDL.h>
#include <SDL/SDL_thread.h>

#include "gst_directions.h"
#include "gst_dialogue.h"
#include "gst_caracteres.h"
#include "gst_sons.h"
#include "gst_divers.h"

static struct type_dialogue dialogue_info;

struct type_flamme_dialogue 
{
  SDL_Surface * images [NBRE_FLAMMES];
  int ecart;
  int position;
  SDL_Rect coord, pos1, pos2;
};

struct type_choix_dialogue
{
  SDL_Surface * images [NBRE_CHOIX];
  SDL_Rect coord, pos;
  int num;
  int etat;
};
  
struct type_dialogue
{
  SDL_Surface * screen, * fondImg;
  SDL_Surface * derriere_le_panneau;
  SDL_Surface * panneau;
  SDL_Rect coord, pos;
  struct type_flamme_dialogue flammes;
  struct type_choix_dialogue choix;
};

static void
dialogue_fond_transparent (SDL_Surface * surface)
{
  SDL_SetColorKey (surface, SDL_SRCCOLORKEY, SDL_MapRGB (surface->format, 0, 255, 255));
}


static void
dialogue_cree_flamme (struct type_flamme_dialogue * flammes)
{
  char nom_fichier [50];
  char flammes_fichier [15] = FLAMMES_DIALOGUE;
  int i;
  for (i = 0; i < NBRE_FLAMMES; i++)
    {
      nom_fichier [0] = 0;
      flammes_fichier [CHIFFRE_FLAMMES] = 49 + i;
      strcat (nom_fichier, ACCES_DIALOGUE);
      strcat (nom_fichier, flammes_fichier);
      flammes->images [i] = img_secure_load (nom_fichier);
      dialogue_fond_transparent (flammes->images [i]);
    }
  RECT_AFFECTE ((*flammes).coord, 0, 0, flammes->images [0]->w, flammes->images [0]->h);
  flammes->pos1 = flammes->pos2 = flammes->coord;
}

static void
dialogue_cree_choix (struct type_choix_dialogue * choix)
{
  char nom_fichier [50];
  char choix_fichier [15] = CHOIX_DIALOGUE;
  int i;
  for (i = 0; i < NBRE_CHOIX; i++)
    {
      nom_fichier [0] = 0;
      choix_fichier [CHIFFRE_CHOIX] = 49 + i;
      strcat (nom_fichier, ACCES_DIALOGUE);
      strcat (nom_fichier, choix_fichier);
      choix->images [i] = img_secure_load (nom_fichier);
      dialogue_fond_transparent (choix->images [i]);
    }
  choix->num = 0;
  RECT_AFFECTE ((*choix).coord, 0, 0, choix->images [0]->w, choix->images [0]->h);
  choix->pos = choix->coord;
  
}

void 
dialogue_cree (SDL_Surface * screen, SDL_Surface * fondImg)
{
  dialogue_info.screen = screen;
  dialogue_info.fondImg = fondImg;
  dialogue_info.panneau = img_secure_load (ACCES_DIALOGUE PANNEAU_DIALOGUE);
  dialogue_fond_transparent (dialogue_info.panneau);
  RECT_AFFECTE (dialogue_info.pos, 0, 0, dialogue_info.panneau->w, dialogue_info.panneau->h);
  dialogue_info.coord = dialogue_info.pos;    
  dialogue_info.derriere_le_panneau = SDL_AllocSurface (SDL_HWSURFACE, 
							dialogue_info.coord.w, dialogue_info.coord.h,
							screen->format->BitsPerPixel,
							screen->format->Rmask, screen->format->Gmask,
							screen->format->Bmask, screen->format->Amask);
  dialogue_cree_flamme (&(dialogue_info.flammes));
  dialogue_cree_choix (&(dialogue_info.choix));
}

static void
dialogue_flamme_update (SDL_Rect * pos)
{
  SDL_UpdateRects (dialogue_info.screen, 1, pos);
}

static void
dialogue_flamme_affiche (SDL_Rect * pos, int inverse)
{
  SDL_BlitSurface (dialogue_info.flammes.images [abs (inverse - dialogue_info.flammes.position)],
		   &(dialogue_info.flammes.coord),
		   dialogue_info.screen, pos);
  dialogue_flamme_update (pos);
}

static void
dialogue_flamme_efface (SDL_Rect * pos)
{
  SDL_BlitSurface (dialogue_info.fondImg, pos, dialogue_info.screen, pos);
}

static int
dialogue_actionne_flammes_thread (void * info)
{
  int tmp;
  while (*((int *) info) != 0)
    {
      dialogue_flamme_affiche (&(dialogue_info.flammes.pos1), 0);
      dialogue_flamme_affiche (&(dialogue_info.flammes.pos2), NBRE_FLAMMES - 1);
      SDL_Delay (DELAI_FLAMMES);
      //dialogue_info.flammes.position = (dialogue_info.flammes.position + 1) % NBRE_FLAMMES;
      while ((tmp = (int) ((double) NBRE_FLAMMES * rand()/(RAND_MAX+1.0))) == dialogue_info.flammes.position)
	;
      dialogue_info.flammes.position = tmp;
      dialogue_flamme_efface (&(dialogue_info.flammes.pos1));
      dialogue_flamme_efface (&(dialogue_info.flammes.pos2));
    }	
  dialogue_flamme_update (&(dialogue_info.flammes.pos1));
  dialogue_flamme_update (&(dialogue_info.flammes.pos2));
  return 0;
}

/* Tant que "*actif" vaut 1, les flammes s'agitent */
static void
dialogue_actionne_flammes (int x, int y, int * actif)
{
  SDL_Thread * dialogue_flammes_thread;
  dialogue_info.flammes.pos1.y = dialogue_info.flammes.pos2.y = y + 125;
  dialogue_info.flammes.pos1.x = x + 10;
  dialogue_info.flammes.pos2.x = x + dialogue_info.panneau->w - 10 - 17;
  dialogue_info.flammes.position = 0;
  dialogue_flammes_thread = SDL_CreateThread (dialogue_actionne_flammes_thread, (void *) actif); 
}


void 
dialogue_panneau_update ()
{
  SDL_UpdateRects (dialogue_info.screen, 1, &(dialogue_info.pos));
}

static void
dialogue_panneau_positionne (int x, int y)
{
  dialogue_info.pos.x = x;
  dialogue_info.pos.y = y;
}

static void
dialogue_panneau_affiche ()
{
  SDL_BlitSurface (dialogue_info.fondImg, &(dialogue_info.pos), 
		   dialogue_info.derriere_le_panneau, &(dialogue_info.coord));
  SDL_BlitSurface (dialogue_info.panneau, &(dialogue_info.coord), dialogue_info.fondImg, &(dialogue_info.pos));
  SDL_BlitSurface (dialogue_info.panneau, &(dialogue_info.coord), dialogue_info.screen, &(dialogue_info.pos));
  dialogue_panneau_update ();
}

static void
dialogue_panneau_efface ()
{
  SDL_BlitSurface (dialogue_info.derriere_le_panneau, &(dialogue_info.coord), 
		   dialogue_info.fondImg, &(dialogue_info.pos));
  SDL_BlitSurface (dialogue_info.fondImg, &(dialogue_info.pos), dialogue_info.screen, &(dialogue_info.pos));
}

/* Retourne la position (x, y) de la fin de la dernière ligne */
static type_position
dialogue_affiche_texte (int x, int y, int frappe, int ecart_titre, 
			int ecart_lignes, int delai_frappe, char * * texte)
{
  char * * curseur = texte;
  type_position pos;
  y += ECART_MARGE_Y;
  x += ECART_MARGE_X;
  while (*curseur != NULL)
    {
      if (frappe)
	{
	  frappe--;
	  car_frappe_texte (car_centre_x (x, dialogue_info.coord.w - 2 * ECART_MARGE_X, *curseur), 
			    y += ecart_lignes, *curseur, delai_frappe);
	}
      else
	pos.x = car_affiche_texte (car_centre_x (x, dialogue_info.coord.w - 2 * ECART_MARGE_X, *curseur),
				   y += ecart_lignes, *curseur);
      if (curseur == texte)
	y += ecart_titre;
      curseur++;
    }
  pos.y = y;
  return pos;
}

void
dialogue_texte (int x, int y, int frappe, int ecart_lignes, char * * texte)
{
  int actif = 1;
  dialogue_panneau_positionne (x, y);
  dialogue_panneau_affiche ();
  dialogue_actionne_flammes (x, y, &actif);
  dialogue_affiche_texte (x, y, frappe, 0, ecart_lignes, DIALOGUE_TEXTE_DELAI_FRAPPE, texte);
  attend_action_clavier_ou_clique (1);
  actif = 0;
  SDL_Delay (DELAI_FLAMMES);
  dialogue_panneau_efface ();
}

static void
dialogue_choix_affiche (int ecart_titre, int ecart_lignes)
{
  struct type_choix_dialogue * choix = &(dialogue_info.choix);
  dialogue_info.choix.pos.y = (dialogue_info.pos.y + 
			       ECART_MARGE_Y + ecart_titre + (dialogue_info.choix.num + 2) * ecart_lignes - 5);
  
  SDL_BlitSurface (choix->images [choix->etat], &(choix->coord), 
		   dialogue_info.screen, &(choix->pos));
  SDL_UpdateRects (dialogue_info.screen, 1, &(choix->pos));
}

static void
dialogue_choix_efface ()
{
  son_joue (son_choix);
  SDL_BlitSurface (dialogue_info.fondImg, &(dialogue_info.choix.pos), 
		   dialogue_info.screen, &(dialogue_info.choix.pos));
  SDL_UpdateRects (dialogue_info.screen, 1, &(dialogue_info.choix.pos));
}

int
dialogue_question (int x, int y, int frappe, int ecart_titre, int ecart_lignes, char * * texte)
{
  SDL_Event event;
  int actif = 1;
  char * * curseur = texte;
  int nbre_choix;
  dialogue_info.choix.num = 0;
  dialogue_info.choix.etat = 0;
  dialogue_panneau_positionne (x, y);
  dialogue_panneau_affiche ();
  dialogue_info.choix.pos.x = 50 + x;
  dialogue_actionne_flammes (x, y, &actif);
  y += ECART_MARGE_Y;
  x += ECART_MARGE_X;
  while (*curseur != NULL)
    {
      nbre_choix++;
      if (frappe)
	{
	  frappe--;
	  car_frappe_texte (x, y += ecart_lignes, *curseur, 55);
	}
      else
	car_affiche_texte (x, y += ecart_lignes, *curseur);
      if (curseur == texte)
	{
	  nbre_choix = 0;
	  y += ecart_titre;
	  x += ECART_CHOIX_MARGE_X;
	}
      curseur++;
    }
  dialogue_choix_affiche (ecart_titre, ecart_lignes);
  while (! dialogue_info.choix.etat)
    if (SDL_PollEvent (&event) > 0 && event.type == SDL_KEYDOWN)
      {
	int key = event.key.keysym.sym;
	if (key == SDLK_UP)
	  {
	    dialogue_choix_efface ();
	    if (--dialogue_info.choix.num < 0)
	      dialogue_info.choix.num = nbre_choix - 1;
	  }
	else if (key == SDLK_DOWN)
	  {
	    dialogue_choix_efface ();
	    if (++dialogue_info.choix.num == nbre_choix)
	      dialogue_info.choix.num = 0;
	  }
	else if (key == SDLK_RETURN || key == SDLK_SPACE || key == SDLK_KP_ENTER)
	  dialogue_info.choix.etat = 1;
	else if (key == SDLK_ESCAPE)
	  {
	    dialogue_info.choix.num = -1;
	    break;
	  }
	dialogue_choix_affiche (ecart_titre, ecart_lignes);
      }
  son_joue (son_roq_explose);
  SDL_Delay (500);
  actif = 0;
  SDL_Delay (DELAI_FLAMMES);
  dialogue_panneau_efface ();
  return dialogue_info.choix.num;
}

void
attend_action_clavier_ou_clique (int clique_dans_le_panneau)
{
  SDL_Event event;
  while (SDL_PollEvent (&event) > 0);	// on attend d'abord que tout se soit calmé
  while (1)
    if (SDL_PollEvent (&event) > 0)
      {
	if (event.type == SDL_KEYDOWN)
	  break;
	if  (event.type == SDL_MOUSEBUTTONDOWN)
	  {
	    if (clique_dans_le_panneau)
	      {
		int x, y;
		SDL_GetMouseState (&x, &y);
		if (x >= dialogue_info.pos.x && x <= dialogue_info.pos.x + dialogue_info.pos.w &&
		    y >= dialogue_info.pos.y && y <= dialogue_info.pos.y + dialogue_info.pos.h)
		  break;
	      }
	    else
	      break;
	  }
      }
}

static void
dialogue_modifie_reponse (char * * curseur, int car)
{
  son_joue (son_choix);
  *((*curseur)++) = car;
}

char * dialogue_saisie (int x, int y, int frappe, int ecart_titre, int ecart_lignes,
			type_saisie saisie, int nbre_car_max, char * * texte)
{
  SDL_Event event;
  int actif = 1;
  char * reponse = (char *) calloc (sizeof (char *), nbre_car_max + 1);
  char * curseur = reponse;
  type_position pos;
  dialogue_panneau_positionne (x, y);
  dialogue_panneau_affiche ();
  dialogue_actionne_flammes (x, y, &actif);
  pos = dialogue_affiche_texte (x, y, frappe, ecart_titre, ecart_lignes, DIALOGUE_SAISIE_DELAI_FRAPPE, texte);
  y = pos.y + ecart_lignes;
  x += (dialogue_info.coord.w - nbre_car_max * 15) / 2;
  while (actif)
    {
      if (SDL_PollEvent (&event) > 0 && event.type == SDL_KEYDOWN)
	{
	  int key = event.key.keysym.sym;
	  if (key == SDLK_RETURN || key == SDLK_KP_ENTER)
	    break;
	  else if (key == SDLK_ESCAPE)
	    {
	      free (reponse);
	      reponse = NULL;
	      break;
	    }
	  else if (key == SDLK_BACKSPACE && curseur > reponse)
	    {
	      *(--curseur) = 0;
	      car_efface (x + car_longueur_texte (reponse), y, 2);
	    }
	  else if (curseur - reponse < nbre_car_max)
	    {
	      if (saisie == saisie_key)	// on prend n'importe quelle touche
		{
		  printf ("N° key : %d\n", key);
		  dialogue_modifie_reponse (&curseur, key);
		  sprintf (reponse, "%d", key);
		  car_affiche_texte (x, y, SDL_GetKeyName (key));	// on affiche son équivalent SDL
		  SDL_Delay (450);
		  break;
		}
	      if (key >= SDLK_0 && key <= SDLK_9)
		dialogue_modifie_reponse (&curseur, key);
	      else if (key >= SDLK_KP0 && key <= SDLK_KP9)
		dialogue_modifie_reponse (&curseur, 48 + key - SDLK_KP0);
	      else if (saisie == saisie_alphanum && (key == SDLK_SPACE || (key >= SDLK_a && key <= SDLK_z)))
		dialogue_modifie_reponse (&curseur, key);
	      else
		son_joue (son_tink);
		
	    }	  
	  car_affiche_texte (x, y, reponse);
	}
    }
  actif = 0;
  SDL_Delay (DELAI_FLAMMES);
  dialogue_panneau_efface ();
  return reponse;
}


void
dialogue_texte_arg (int x, int y, int frappe, int ecart_lignes, char * premier, ...)
{
  int max, cpt = 0;
  char * * tab_chaines;
  va_list liste_chaines;
  va_start (liste_chaines, premier);
  while (va_arg (liste_chaines, char *) != NULL)
    cpt++;
  max = cpt + 2;	// on compte le premier et le dernier (NULL) en plus
  tab_chaines = (char * *) malloc (sizeof (char *) * max);
  va_start (liste_chaines, premier);
  for (tab_chaines [0] = premier, cpt = 1; cpt < max; cpt++)
    tab_chaines [cpt] = va_arg (liste_chaines, char *);
  va_end (liste_chaines);
  dialogue_texte (x, y, frappe, ecart_lignes, tab_chaines);
  free (tab_chaines);
}
