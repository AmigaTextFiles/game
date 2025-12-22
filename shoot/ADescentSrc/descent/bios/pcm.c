// PCM's addons to make this actually compile under Linux.

#include <stdio.h>
#include <ctype.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>

#include "fix.h"


// String stuff
int o_strnicmp(char *moo1,char *moo2,int amount) {
	if (!moo1||!moo2||amount<0) return 1;
	
	while (amount&&*moo1&&*moo2&&tolower(*moo1)==tolower(*moo2)) moo1++,moo2++,amount--;
	
	if (!amount) return 0;
	
	return 1;
}

int o_stricmp(char *moo1,char *moo2) {
	if (!moo1||!moo2) return 1;
	
	while (*moo1&&*moo2&&tolower(*moo1)==tolower(*moo2)) moo1++,moo2++;
	
	if (!*moo1&&!*moo2) return 0;
	return 1;
}

int strcmpi(char *moo1, char *moo2) {
	return stricmp(moo1,moo2);
}

void strlwr(char *str) {
	if (!str) return;
	while (*str) *str=tolower(*str),str++;
	return;
}

void strrev(char *str) {

	int i,j;
	char c;

	j = strlen(str) - 1;
	i = 0;

	while (j>i) {
		c = str[i];
		str[i] = str[j];
		str[j] = c;
		i++; j--;
	}

}

char *itoa(int num, char *str, int base) {
	sprintf(str,"%d",num);
	return str;
}

// File IO
int filelength(int fileno) {
	struct stat stats;
	if (fstat(fileno,&stats)) return 0;
	return stats.st_size;
}

/*
void timer_init(void) {
}

void timer_set_rate(int time) {
}

fix timer_get_fixed_seconds(void) {
	struct timeval moo;
	fix time;
	
	gettimeofday(&moo,NULL);
	time=(fix)(moo.tv_sec&0xffff)<<16;
	time=(fix)(((float)moo.tv_usec/1000000.0)*65536.0)+time;
	
	return time;
}

fix timer_get_fixed_secondsX(void) {
	return timer_get_fixed_seconds();
}

fix timer_get_approx_seconds(void) {
	return timer_get_fixed_seconds();
}
*/
int myrand(void) {
	return random()&0x7fff;
}
