
/* Routine to print an unsigned short integer by Russell Wallace 1987. You may
 * copy it freely and use it in your own programs. Requires linkage to my
 * set of console routines, console.o. Use short integer compile option. */

printshort (n)
register unsigned short n;
{
	char digits[6];	/* Extra one to hold null to terminate string. */
	register short i;
	register short j=0;
	register short column=10000;
	register char notzero=0;
	for (i=0;i<5;i++)
	{
		digits[j]=(char)(n/column)+'0';
		if (digits[j]!='0')
			notzero++;
		if (notzero)	/* To avoid leading zeros */
			j++;
		n=n%column;
		column/=10;
	}
	if (!notzero)
		digits[j++]='0';
	digits[j]='\0';	/* Print()ed all digits at once rather than use */
	print (digits);	/* writechar() for each so as to get formatted print. */
}
