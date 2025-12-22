/*	MakeNames  V1.0  -  Creates randomly somewhat useable names */
/*	© copyright 1997 Henning Peters  -  use for free in your programs */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <sys/types.h>
#include <time.h>	/* Just for "srand(time(0))" */

const char
	*cons="bdfghklmnpqrstvwz",
	*end="nlrdstqk",
	*vocal="aeiou",
	*start="dgtskpvfrqj",
	*spaces="                                                                                "; /* 80 spaces */

int mins = 2, maxs = 4; /* MINimum Syllables, MAXimum Syllables */
int yps = 0;	/* Don't use 'y' to often and don't let follow one to ner */
int cols = 0, width = 0; /* Number and width of columns to output */

char follow(char ch) {	/* Some consonants sound "ugly" after some other,
													 ie "dp" - this func gives "good-sounding" ones */
	if (ch != 'y' && yps == 0 && rand() % 5 == 0) {
		yps = 3;
		return 'y'; /* return 'y' not too often */
	}

	switch (ch) {
		case 'd':
			return "sdnfrj"[rand() % 6];
		case 't':
		case 'g':
		case 'q':
		case 'k':
			return "dstnfrj"[rand() % 7];
		case 'f':
			return "stdnfrgj"[rand() % 8];
		case 'v':
			return "stdnvrgj"[rand() % 8];
		default:
			return start[rand() % 11];
	}
}

char *makename() {
	int s, p=0, nc=strlen(cons), ne=strlen(end), nv=strlen(vocal), x=0;
	char *name;

	name = malloc(maxs * 3);

	for (s = (random() % (maxs - mins)) + mins; s > 0; s--) {

		if (yps)
			yps--;

		if (x == 0)
			name[p] = cons[random() % nc];
		else
			name[p] = follow(name[p-1]);

		if (name[p] == 'q') {
			p++;
			name[p] = 'u';
		}
		p++;

		if (yps == 0 && rand() % 5 == 0) {
			yps = 3;
			name[p] = 'y';
		} else
			name[p] = vocal[random() % nv];
		p++;

		if (random() % 3 == 2 || s == 1) {
			name[p] = end[random() % ne];
			p++;
			x = 1;
		} else
			x = 0;
	}
	name[p] = '\0';
	name[0] = toupper(name[0]);
	strncat(name, spaces, width-p);
	return (char *)strdup(name);
}


int main(int argc, char *argv[]) {
	int x, max = 48;

	srandom(time(0)); 

	if (argc > 1) {
		if (argv[1][0] == '?' || argv[1][0] == 'h' ||
				argv[1][1] == '?' || argv[1][1] == 'h') {
			fprintf(stderr,"   %s [min.syl [max.syl [number [cols]]]]\n",
							argv[0]);
			return 5;
		}
		mins = atoi(argv[1]);
		if (argc > 2) {
			maxs = atoi(argv[2]);
			if (argc > 3) {
				max = atoi(argv[3]);
				if (argc > 4) {
					cols = atoi(argv[4]);
				}
			}
		}
	}

	if (maxs == mins)
		maxs++;
	else if (maxs < mins) {
		x = maxs;
		maxs = mins;
		mins = x;
	}

	if (cols == 0)
		cols = 78;

	width = maxs * 4;

	if (cols > 10) /* We assume cols = chars per line */
		cols /= width;

	for (x = 1; x <= max; x++)
		printf("%s%s",makename(), x % cols == 0 ? "\n" : "  ");

	if ((x-1) % cols != 0)
		printf("\n");

	return 0;
}



