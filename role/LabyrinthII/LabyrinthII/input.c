
/* Text input routine by Russell Wallace 1987. Feel free to copy it and use it
 * in your own programs. Requires linkage to my set of console routines,
 * console.o. Backspace and cursor keys can be used. DEL key puts
 * linefeed character in string, RETURN key ends input. Selection of menu
 * item or closewindow gadget will break off input and return -ve number,
 * otherwise length of typed-in string returned. */

long checkinput ();

long input (string,length)
unsigned char *string;	/* Address of buffer to put text */
long length;			/* Length of buffer */
{
	short c;		/* Key pressed */
	short x;		/* Position in buffer */
	long actlen=0;	/* Actual length of typed-in string */
	register short i;
	resetscroll ();
	x=0;
	for (;;)
	{
		do
			c=checkinput ();
		while (!c);
		if (actlen<x)
			actlen=x;
		if (c==1000)	/* Close window ... cancel edit */
		{
			actlen=-1000;
			goto ENDINPUT;
		}
		if (c<0)		/* Menu select ... cancel edit */
		{
			actlen=c;
			goto ENDINPUT;
		}
		if (c=='\r')	/* Pressed CR ... end edit */
			goto ENDINPUT;
		if (c==8 && x)	/* Backspace key */
		{
			for (i=x-1;i<actlen;i++)	/* Delete character in string buffer */
				string[i]=string[i+1];
			writechar ((long)8);
			nprint ((long)(string+(--x)));	/* Delete on screen */
			writechar ((long)' ');
			for (i=x;i<actlen;i++)
				writechar ((long)8);
			actlen--;			/* One fewer characters */
		}
		if (c==155)		/* Code indicating a cursor key etc. */
		{
			do
				c=checkinput ();	/* Find out which one */
			while (!c);
			if (c==67 && x<actlen)	/* Move right */
			{
				writechar ((long)155);
				writechar ((long)67);
				x++;
			}
			if (c==68 && x)			/* Move left */
			{
				writechar ((long)155);
				writechar ((long)68);
				x--;
			}
			if (c==65 && x>7)		/* Up=back 8 spaces */
			{
				x-=8;
				for (i=0;i<8;i++)
				{
					writechar ((long)155);
					writechar ((long)68);
				}
			}
			if (c==66 && x<actlen-7)	/* Down=forward 8 */
			{
				x+=8;
				for (i=0;i<8;i++)
				{
					writechar ((long)155);
					writechar ((long)67);
				}
			}
			c=0;
		}
		if (c>31 && c<128 && actlen<length-1)
		{
			for (i=actlen;i>x;i--)
				string[i]=string[i-1];
			string[++actlen]='\0';
			string[x++]=c;
			nprint ((long)(string+x-1));
			for (i=x;i<actlen;i++)
				writechar ((long)8);
		}
	}
ENDINPUT:
	for (i=0;i<x;i++)
		if (string[i]==127)		/* Convert peculiar characters back into */
			string[i]='\n';			/* CRs for use */
	string[actlen]='\0';		/* Stick null on end of string */
	for (i=x;i<actlen;i++)
	{
		writechar ((long)155);	/* Move cursor to end of string */
		writechar ((long)67);
	}
	writechar ((long)'\n');		/* Print out CR */
	resetscroll ();		/* This has introduced a pause sufficient for any */
	return (actlen);				/* preceding text to have been read */
}
