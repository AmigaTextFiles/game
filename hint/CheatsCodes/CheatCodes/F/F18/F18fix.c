/*
 *	f18fix.c by Sean Casey, PUBLIC DOMAIN.
 */

#include "fcntl.h"

main()
{
	char s[8], zero = 0;
	char *fn = "df0:F-18 Interceptor";
	int fp;

	puts("Insert copy of F-18 Interceptor into DF0: and press RETURN:\n");
	gets(s);

	if ((fp = open(fn, O_RDWR)) < 0) {
		puts("Couldn't open file \"DF0:F-18 Interceptor\"\n");
		exit(-1);
	}

	lseek(fp, (long) 0x1cd8d, 0);
	write(fp, &zero, 1);
	lseek(fp, (long) 0x1cd9d, 0);
	write(fp, &zero, 1);
	lseek(fp, (long) 0x1cdad, 0);
	write(fp, &zero, 1);
	lseek(fp, (long) 0x1cdbb, 0);
	write(fp, &zero, 1);
	close(fp);
}
