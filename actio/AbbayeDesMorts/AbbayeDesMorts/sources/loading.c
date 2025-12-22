/* loading.c */

# include "abbaye.h"
# include <stdio.h>
# include <stdlib.h>

void loaddata(struct game *G){

	FILE *datafile = NULL;
	int i,j,k,data;
	char line[129],temp[4],line2[61];
	temp[3] = 0;

	/* Loading file */
	datafile = fopen("data/map.txt", "r");
	fgets (line, 129, datafile);
	fgets (line, 129, datafile);

	/* Cargamos los datos del fichero en el array */
	for (i=0; i<=24; i++) {
		for (j=0; j<=21; j++) {
			for (k=0; k<=31; k++) {
				temp[0] = line[k*4];
				temp[1] = line[(k*4) + 1];
				temp[2] = line[(k*4) + 2];
				sscanf (temp, "%d", &data);
				G->map.stagedata[i][j][k]=data;
			}
			fgets (line, 129, datafile);
		}
		fgets (line, 129, datafile);
	}

	/* Cerramos fichero */
	fclose (datafile);

	datafile = fopen("data/enemies.txt", "r");
	fgets (line2, 61, datafile);
	fgets (line2, 61, datafile);

	/* Cargamos los datos del fichero en el array */
	for (i=0; i<=24; i++) {
		for (j=0; j<7; j++) {
			for (k=0; k<15; k++) {
				temp[0] = line2[k*4];
				temp[1] = line2[(k*4) + 1];
				temp[2] = line2[(k*4) + 2];
				sscanf (temp, "%d", &data);
				G->map.enemydata[i][j][k]=data;
			}
			fgets (line2, 61, datafile);
		}
		fgets (line2, 61, datafile);
	}

	fclose (datafile);

}

void loadingmusic(struct game *G){

	/* Musics */
	G->bso[0] = AB_LoadMusic(G,"sounds/PrayerofHopeN.ogg");
	G->bso[1] = AB_LoadMusic(G,"sounds/AreaIChurchN.ogg");
	G->bso[2] = AB_LoadMusic(G,"sounds/GameOverV2N.ogg");
	G->bso[3] = AB_LoadMusic(G,"sounds/HangmansTree.ogg");
	G->bso[4] = AB_LoadMusic(G,"sounds/AreaIICavesV2N.ogg");
	G->bso[5] = AB_LoadMusic(G,"sounds/EvilFightN.ogg");
	G->bso[6] = AB_LoadMusic(G,"sounds/AreaIIIHellN.ogg");
	G->bso[7] = AB_LoadMusic(G,"sounds/ManhuntwoodN.ogg");

	/* Fxs */
	G->fx[0] = AB_LoadSound(G,"sounds/shoot.ogg");
	G->fx[1] = AB_LoadSound(G,"sounds/doorfx.ogg");
	G->fx[2] = AB_LoadSound(G,"sounds/Item.ogg");
	G->fx[3] = AB_LoadSound(G,"sounds/jump.ogg");
	G->fx[4] = AB_LoadSound(G,"sounds/slash.ogg");
	G->fx[5] = AB_LoadSound(G,"sounds/mechanismn.ogg");
	G->fx[6] = AB_LoadSound(G,"sounds/onedeathn.ogg");

}

