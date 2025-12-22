#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_mixer.h>
#include <assert.h>

#include "gst_divers.h"
#include "gst_sons.h"

static Mix_Chunk * * son_tinks;
static int son_volume = -1;
static int son_modulateur [nbre_de_sons] = { 10, 50, 0, 
					     0, 0, 0, 
					     25, 0, 0, 
					     0, 0, 0,
					     0, 0, 0,
					     0, 0};
static char * son_nom_fichiers [nbre_de_sons] = { "Explose.wav", "PoseBombe.wav", "Ramasse.wav", 
						  "Plainte.wav", "Mort0.wav", "Mort1.wav",
						  "RoqTir.wav", "RoqExplose.wav", "Glisse.wav",
						  "Choix.wav", "MonstrePlainte.wav", "MonstreMort.wav",
						  "MonstreApparition.wav", "MonstreFrotte.wav", "Tink.wav",
						  "PoseLettre.wav", "Fondu.wav"};

static char *
fabrique_nom_son (char * buff, char * nom) 
{
  sprintf (buff, "./Sons/%s", nom);
  return buff;
}


void
son_cree (int volume)
{
  char nom_fichier [64];
  int i;
  /* Ouvre le canal audio */
  Mix_OpenAudio (MIX_DEFAULT_FREQUENCY, MIX_DEFAULT_FORMAT, 2, 512);
  son_tinks = (Mix_Chunk * *) malloc (sizeof (Mix_Chunk *) * nbre_de_sons);
  for (i = 0; i < nbre_de_sons; i++)
    son_tinks [i] = mix_secure_load (fabrique_nom_son (nom_fichier, son_nom_fichiers [i]));
  son_ajuste_volume (volume);
}

void 
son_ajuste_volume (int nouveau_volume)
{
  if (nouveau_volume != son_volume)
    {
      int i;
      son_volume = nouveau_volume;
      for (i = 0; i < nbre_de_sons; i++)
	Mix_VolumeChunk (son_tinks [i], abs (son_volume - son_modulateur [i]));
    }
}

void
son_joue (type_enum_sons son)
{
  Mix_PlayChannel (-1, son_tinks [son], 0);
}


