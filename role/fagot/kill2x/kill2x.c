/*
 * kill2x
 * by K.Veijalainen <veijalai@cc.lut.fi>
 */

#include <stdio.h>
#include <stdlib.h>

#define VERSION "v1.0"

#define BUFFER_SIZE 1024

int main(void) {
	unsigned char buffer[BUFFER_SIZE],old_buffer[BUFFER_SIZE];
	old_buffer[0]=0;
	while(gets(buffer)) {
		/* Is there difference between this and previous line? */
		if(strcmp(buffer,old_buffer)) {
			printf("%s\n",buffer);
			strcpy(old_buffer,buffer);
		}
	}
	exit(0);
}
