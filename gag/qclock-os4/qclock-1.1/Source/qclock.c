/* yeahyeah i know this is really poorly coded by hey, it's
 * not exactly a quality program or anything, is it? :)
 *
 *       -mrq
 *
 * qclock 1.1
 *		Right, well i've tidied it up a little so no-one can complain
 *		about it, and changed the logic and time descriptions slightly.
 *
 *		- caf (23/6/2000)
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

#define randomize() srand((unsigned)time(NULL))
#define random(n) (rand() % n)
#define nexthour(n) ((n<23)?(n+1):0)

#define NGREETS 7
#define NVAGUES 7
#define NPREFCS 6

char *greeting[] = {
	"hi.  ",
	"hello.  ",
	"greetings.  ",
	"salutations.  ",
	"yo!  ",
	"hey.  ",
	"Segmentation fau--*cough*, er, i mean, "
};

char *vague[] = {
	" or something",
	" or thereabouts",
	".  i think.  maybe",
	".  thank you, please drive through",
	".  and incidentally, can i interest you in these fine steak knives..",
	", and dont blame me if i\'m wrong",
	".  now go away, im plotting my world domination",
};

char *preface[] = {
	"current time:  ",
	"the time is probably ",
	"the time is now ",
	"if you must know, the time is ", 
	"and lo, ye olde tyme was thus: ",
	"it\'s "
};

char *roman[] = {
	"XII", "I", "II", "III", "IV", "V",
	"VI", "VII", "VIII", "IX", "X", "XI"
};

char *word[] = {
	"twelve", "one", "two", "three", "four", "five",
	"six", "seven", "eight", "nine", "ten", "eleven"
};

char *altword[] = {
	"midnight", "one", "two", "too bloody early", "bloody early",
	"sparrow\'s fart", "sunrise", "breakfast time", "ate, er, i mean eight",
	"time to be at work", "ten", "time for a coffee break", "noon",
	"one", "two", "beer o'clock", "four", "knock-off time", "six",
	"food time", "eight", "nine", "ten", "eleven...it goes to eleven"
};

char *getword(int n) {
	randomize();
	switch (random(3)) {
	case 0:
   		return roman[n % 12];
	case 1:
		return word[n % 12];
	case 2:
		return altword[n];
	}
}

int main(int argc, char **argv) {
	int mins, hours, secs;
	time_t t;
	struct tm *lt;
	char *prefix = "";

  	time(&t);	
	lt = localtime(&t);
	hours = lt->tm_hour;
	mins = lt->tm_min;
	secs = lt->tm_sec;

	randomize();
	printf("%s %s", prefix, greeting[random(NGREETS)]);

	if (random(5) == 0) {
	  randomize();
	  switch(random(5)) {
		 case 0:
		 	if (hours < 6)
		 		printf("its too sodding early, go away.\n");
		 	else if (hours < 12)
		    	printf("its morning.\n");
		  	else if (hours < 17)
		    	printf("its the afternoon.\n");
		    else if (hours < 20)
		    	printf("its the evening.\n");
		    else
		    	printf("its nighttime.\n");
		  break;
		 case 1:
		  printf("i think its around %s.\n", word[(hours + random(4) + 10) % 12]);
		  printf("%s (but actually i just made that up)\n", prefix);
		  break;
		 case 2:
		  printf("i\'ve got no clue what the time is, go get a watch.\n");
		  break;
		 case 3:
		  printf("the time is an abstract concept which attempts to give names to different periods of the day or night.\n");
		  break;
		 case 4:
		  printf("go away, i\'m depressed.\n");
		  break;
	  }
	  exit(0);  
	}

	printf("%s", preface[random(NPREFCS)]);

	if (mins == 0)
		printf("dead on %s", getword(hours));
	else if (mins <= 3) 
		printf("%s", getword(hours));
 	else if (mins <= 7) 
		printf("a bit after %s", getword(hours));
	else if (mins <= 11)
		printf("ten past %s", getword(hours));
	else if (mins <= 14) 
		printf("nearly quarter past %s", getword(hours));
	else if (mins <= 16) 
		printf("quarter past %s", getword(hours));
	else if (mins <= 19) 
		printf("around twenty past %s", getword(hours));
	else if (mins <= 23) 
		printf("just after twenty past %s", getword(hours));
	else if (mins <= 29) 
		printf("half past %s-ish", getword(hours));
	else if (mins <= 34) 
		printf("half past %s", getword(hours)); 
	else if (mins <= 36) 
		printf("twenty five to %s", getword(nexthour(hours)));
	else if (mins <= 39) 
		printf("getting close to twenty to %s", getword(nexthour(hours)));
	else if (mins <= 41) 
		printf("20 to %s", getword(nexthour(hours)));
	else if (mins <= 44) 
		printf("almost quarter to %s", getword(nexthour(hours)));
	else if (mins <= 46) 
		printf("1/4 to %s", getword(nexthour(hours)));
	else if (mins <= 49) 
		printf("somewhere between %s fourty seven and %s fourty nine", getword(hours), getword(hours));
	else if (mins <= 51) 
		printf("ten to %s", getword(nexthour(hours)));
	else if (mins <= 54) 
		printf("getting close to 5 minutes to %s", getword(nexthour(hours)));
	else if (mins <= 56) 
		printf("five to %s", getword(nexthour(hours)));
	else
		printf("close enough to %s that it doesnt make a difference", getword(nexthour(hours)));
	
	if (random(2) == 0) {
		printf("%s",vague[random(NVAGUES)]);
	}
	printf(".\n");
	/*printf("%d:%d:%d\n",hours,mins,secs);*/
}
