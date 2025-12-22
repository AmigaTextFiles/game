#include "stdio.h"

#include "SDL.h"

extern SDLKey THRUST_KEY,ANTITHRUST_KEY,LEFT_KEY,RIGHT_KEY;
extern SDLKey FIRE_KEY,ATRACTOR_KEY;
extern SDLKey PAUSE_KEY;

void load_configuration(void)
{
	int a,b,c,d,e,f,g;
	FILE *fp;

	fp=fopen("transball.cfg","r");

	if (fp==0) return;

	if (7!=fscanf(fp,"%i %i %i %i %i %i %i",&a,&b,&c,&d,&e,&f,&g)) {
		fclose(fp);
		return;
	} /* if */ 

	THRUST_KEY=(SDLKey)a;
	ANTITHRUST_KEY=(SDLKey)b;
	LEFT_KEY=(SDLKey)c;
	RIGHT_KEY=(SDLKey)d;
	FIRE_KEY=(SDLKey)e;
	ATRACTOR_KEY=(SDLKey)f;
	PAUSE_KEY=(SDLKey)g;

	fclose(fp);
} /* load_configuration */ 


void save_configuration(void)
{
	FILE *fp;

	fp=fopen("transball.cfg","w");
	
	if (fp==0) return;

	fprintf(fp,"%i %i %i %i %i %i %i",(int)THRUST_KEY,(int)ANTITHRUST_KEY,(int)LEFT_KEY,(int)RIGHT_KEY,
									  (int)FIRE_KEY,(int)ATRACTOR_KEY,(int)PAUSE_KEY);

	fclose(fp);

} /* save_configuration */ 

