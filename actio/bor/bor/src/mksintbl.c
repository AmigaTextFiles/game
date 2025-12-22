#include <math.h>

int main()
{
	int i;
	for(i=0;i<256;i++) {
		if ((i&7)==0) printf("\n\t");
		printf("%f,",sin(i*M_PI/128));
	}
}
