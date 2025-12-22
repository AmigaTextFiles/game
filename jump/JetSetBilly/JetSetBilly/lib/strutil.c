/*
 * String utilities
 *
 * char *possessive(char *)	Return a string converted to possessive
 *				(e.g. "John" -> "John's", "Dis" -> "Dis'")
 * char *pluralize(char *)	Return a string converted to plural
 *				e.g. "hand axe" -> "hand axes"
 *				"child of night" -> "children of night"
 *				"steak a la dog" -> "steaks a la dog"
 */

#ifdef _AMIGA
#include <exec/types.h>
#else
#define BOOL short
#endif
#include <stdio.h>
#include <string.h>

static char *vowels = "aeiouy{|";

BOOL
letter(char c)		/* is 'c' a letter?  note: '@' classed as letter */
{
    return((BOOL)(('@' <= c && c <= 'Z') || ('a' <= c && c <= 'z')));
}

char *
eos(register char * s)	/* return the end of a string (pointing at '\0') */
{
    while (*s) s++;	/* s += strlen(s); */
    return s;
}

char *
possessive(const char * s)	/* return a name converted to possessive */
{
    static char buf[80];

    strcpy(buf, s);
    if(!strcmpi(buf, "it"))
	strcat(buf, "s");
    else if(*(eos(buf)-1) == 's')
	strcat(buf, "'");
    else
	strcat(buf, "'s");
    return buf;
}

/* Plural routine from NetHack 3.1.3. Pretty good. */
/*
 * Plural routine; chiefly used for user-defined fruits.  We have to try to
 * account for everything reasonable the player has; something unreasonable
 * can still break the code.  However, it's still a lot more accurate than
 * "just add an s at the end", which Rogue uses...
 *
 * Also used for plural monster names ("Wiped out all homunculi.")
 * and body parts.
 *
 * Also misused by muse.c to convert 1st person present verbs to 2nd person.
 */
char *
pluralize(const char *oldstr)
{
	/* Note: cannot use strcmpi here -- it'd give MATZot, CAVEMeN,... */
	register char *spot;
	static char str[80];
	const char *excess;
	int len;

	while (*oldstr==' ') oldstr++;
	if (!oldstr || !*oldstr) {
		fprintf(stderr, "makeplural: plural of null?\n");
		strcpy(str, "s");
		return str;
	}
	strcpy(str, oldstr);

	/* Search for common compounds, ex. lump of royal jelly */
	for(excess=(char *)0, spot=str; *spot; spot++) {
		if (!strncmp(spot, " of ", 4)
				|| !strncmp(spot, " labeled ", 9)
				|| !strncmp(spot, " called ", 8)
				|| !strncmp(spot, " named ", 7)
				|| !strcmp(spot, " above") /* lurkers above */
				|| !strncmp(spot, " versus ", 8)
				|| !strncmp(spot, " from ", 6)
				|| !strncmp(spot, " in ", 4)
				|| !strncmp(spot, " on ", 4)
				|| !strncmp(spot, " a la ", 6)
				|| !strncmp(spot, " with", 5)	/* " with "? */
				|| !strncmp(spot, " de ", 4)
				|| !strncmp(spot, " d'", 3)
				|| !strncmp(spot, " du ", 4)
				) {
			excess = oldstr + (int) (spot - str);
			*spot = 0;
			break;
		}
	}
	spot--;
	while (*spot==' ') spot--; /* Strip blanks from end */
	*(spot+1) = 0;
	/* Now spot is the last character of the string */

	len = strlen(str);

	/* Single letters */
	if (len==1 || !letter(*spot)) {
		strcpy(spot+1, "'s");
		goto bottom;
	}

	/* man/men ("Wiped out all cavemen.") */
	if (len >= 3 && !strcmp(spot-2, "man") &&
			(len<6 || strcmp(spot-5, "shaman")) &&
			(len<5 || strcmp(spot-4, "human"))) {
		*(spot-1) = 'e';
		goto bottom;
	}

	/* tooth/teeth */
	if (len >= 5 && !strcmp(spot-4, "tooth")) {
		strcpy(spot-3, "eeth");
		goto bottom;
	}

	/* knife/knives, etc... */
	if (!strcmp(spot-1, "fe"))
		*(spot-1) = 'v';
	else if (*spot == 'f')
		if (strchr("lr", *(spot-1)) || strchr(vowels, *(spot-1)))
			*spot = 'v';
		else if (len >= 5 && !strncmp(spot-4, "staf", 4))
			strcpy(spot-1, "ve");

	/* foot/feet (body part) */
	if (len >= 4 && !strcmp(spot-3, "foot")) {
		strcpy(spot-2, "eet");
		goto bottom;
	}

	/* ium/ia (mycelia, baluchitheria) */
	if (len >= 3 && !strcmp(spot-2, "ium")) {
		*(spot--) = (char)0;
		*spot = 'a';
		goto bottom;
	}

	/* algae, larvae, hyphae (another fungus part) */
	if ((len >= 4 && !strcmp(spot-3, "alga")) ||
	    (len >= 5 &&
	     (!strcmp(spot-4, "hypha") || !strcmp(spot-4, "larva"))))
	if (len >= 5 && (!strcmp(spot-4, "hypha")))
	{
		strcpy(spot, "ae");
		goto bottom;
	}

	/* fungus/fungi, homunculus/homunculi, but wumpuses */
	if (!strcmp(spot-1, "us") && (len < 6 || strcmp(spot-5, "wumpus"))) {
		*(spot--) = (char)0;
		*spot = 'i';
		goto bottom;
	}

	/* vortex/vortices */
	if (len >= 6 && !strcmp(spot-3, "rtex")) {
		strcpy(spot-1, "ices");
		goto bottom;
	}

	/* djinni/djinn (note: also efreeti/efreet) */
	if (len >= 6 && !strcmp(spot-5, "djinni")) {
		*spot = (char)0;
		goto bottom;
	}

	/* mumak/mumakil */
	if (len >= 5 && !strcmp(spot-4, "mumak")) {
		strcpy(spot+1, "il");
		goto bottom;
	}

	/* same singular and plural */
	/* note: also swine, trout, grouse */
	if ((len >= 2 && !strcmp(spot-1, "ai")) || /* samurai, Uruk-hai */
	    (len >= 5 &&
	     (!strcmp(spot-4, "manes") || !strcmp(spot-4, "sheep"))) ||
	    (len >= 4 &&
	     (!strcmp(spot-3, "fish") || !strcmp(spot-3, "tuna") ||
	      !strcmp(spot-3, "deer")))
	    ) goto bottom;

	/* sis/ses (nemesis) */
	if (len >= 3 && !strcmp(spot-2, "sis")) {
		*(spot-1) = 'e';
		goto bottom;
	}

	/* mouse/mice,louse/lice (not a monster, but possible in food names) */
	if (len >= 5 && !strcmp(spot-3, "ouse") && strchr("MmLl", *(spot-4))) {
		strcpy(spot-3, "ice");
		goto bottom;
	}

	/* matzoh/matzot, possible food name */
	if (len >= 6 && (!strcmp(spot-5, "matzoh")
					|| !strcmp(spot-5, "matzah"))) {
		strcpy(spot-1, "ot");
		goto bottom;
	}
	if (len >= 5 && (!strcmp(spot-4, "matzo")
					|| !strcmp(spot-5, "matza"))) {
		strcpy(spot, "ot");
		goto bottom;
	}

	/* child/children (for wise guys who give their food funny names) */
	if (len >= 5 && !strcmp(spot-4, "child")) {
		strcpy(spot, "dren");
		goto bottom;
	}

	/* note: -eau/-eaux (gateau, bordeau...) */
	/* note: ox/oxen, VAX/VAXen, goose/geese */

	/* Ends in z, x, s, ch, sh; add an "es" */
	if (strchr("zxsv", *spot)
			|| (len >= 2 && *spot=='h' && strchr("cs", *(spot-1)))
	/* Kludge to get "tomatoes" and "potatoes" right */
			|| (len >= 4 && !strcmp(spot-2, "ato"))
									) {
		strcpy(spot+1, "es");
		goto bottom;
	}

	/* Ends in y preceded by consonant (note: also "qu") change to "ies" */
	if (*spot == 'y' &&
	    (!strchr(vowels, *(spot-1)))) {
		strcpy(spot, "ies");
		goto bottom;
	}

/* Unneccessary */
#if 0
	/* Japanese words: plurals are the same as singlar */
	if ((len == 2 && !strcmp(str, "ya")) ||
	    (len > 2 && !strcmp(spot-2, " ya")) ||
	    (len >= 5 && (!strcmp(spot-4, "ninja") ||
			!strcmp(spot-4, "ronin") ||
			!strcmp(spot-4, "shito") ||
			!strcmp(spot-4, "tengu"))) ||
	    (len >= 7 && (!strcmp(spot-6, "samurai") ||
			!strcmp(spot-6, "gunyoki"))))
		goto bottom;
#endif

	/* Default: append an 's' */
	strcpy(spot+1, "s");

bottom:	if (excess) strcpy(eos(str), excess);
	return str;
}

#if 0
int
main(int argc, char **argv)
{
	char puff[512] = {0};

	while (gets(puff) != NULL) {
		printf("%s\n", makeplural(puff));
		puff[0] = 0;
	}
}
#endif
