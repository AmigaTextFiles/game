/*
 * FAGOT - Fantasia-Aiheisten Good Nimien Oiva Tuottaja
 * by K.Veijalainen <veijalai@cc.lut.fi>
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define VERSION "v1.0"

#define BUFFER_SIZE   1024
#define MAX_SYLLABLES 1024

int main(int argc, unsigned char **argv) {
	/* Temp storage for strings.*/
	unsigned char buffer[BUFFER_SIZE],*t;
	/* Syllables.*/
	unsigned char *syllables[MAX_SYLLABLES];
	int name_n,x,l,n1,n2,n3,sc[3];
	
	srandom((unsigned int)time(NULL));
	
	/* Blah. */
	if(argc!=2)
	  printf("Usage: %s <number_of_names>\n",argv[0]);
	else {
		name_n=atoi(argv[1]);
		if(name_n<1)
		  printf("You must ask for at least one name.\n");
		else {
			x=l=sc[0]=sc[1]=sc[2]=0;
			/* Read the syllables.*/
			while(gets(buffer)) {
				/* asdasd? dsadsad. asdasdsad! */
				if(buffer[0]=='-')
				  sc[++x]=l;
				else {
					/* Malloc space for the string.*/
					t=malloc(strlen(buffer)+1);
					strcpy(t,buffer);
					/* pointer array reblah...*/
					syllables[l++]=t;
					/* inc amount of n1/n2/n3 */
					switch(x) {
					 case 0:
						++n1;
						break;
					 case 1:
						++n2;
						break;
					 case 2:
						++n3;
					}
				}
			}
			
			/* Now make the names out of the syllables.*/
			for(x=0;x<name_n;x++) {
				/* Clear buffer.*/
				buffer[0]=0;
				/* 1 */
				printf("%s",syllables[random()%n1]);
				/* 2 */
				if(random()%100<60)
				  printf("%s",syllables[sc[1]+random()%n2]);
				/* 3 */
				printf("%s\n",syllables[sc[2]+random()%n3]);
			}
		}
	}
	exit(0);
}
