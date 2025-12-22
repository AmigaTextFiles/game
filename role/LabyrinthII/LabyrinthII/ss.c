
/* Scanshort takes string as argument and returns short integer from beginning
 * of string - will not scan through string looking for numbers. If invalid,
 * returns 32767 and puts '\0' in first char of string. (C) 1987 Russell
 * Wallace - this routine may be freely distributed and used for program
 * development. Use +L compile option with Aztec C. */

short scanshort (string)
char *string;
{
	register short i;
	register long number=0L;
	register short digit=1;
	register short minus=0;
	while ((string[0]<'0' || string[0]>'9')&& string[0] && string[0]!='-')
		string++;
	if (string[0]=='-')
	{
		minus++;
		string[0]='0';
	}
	for (i=0;string[i]>='0' && string[i]<='9';i++)
		;
	if (i==0 || i>6)
	{
		string[0]='\0';
		return (32767);
	}
	do
	{
		number+=(string[--i]-'0')*digit;
		digit*=10;
	}
	while (i);
	if ((number-minus) & (long)(0xFFFF8000))
	{
		string[0]='\0';
		return (32767);
	}
	if (minus)
		number=(~number)+1;		/* 2's complement sign change */
	return ((short)number);
}
