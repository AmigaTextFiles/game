
/* Readfile scans a file from disk and prints it out using the formatted
 * print routine in console.c. Written 1987 by Russell Wallace. */

#include <libraries/dos.h>

#define BUFLEN 256L
#define EOF '\0'

char inbuffer[BUFLEN];
char prbuf[BUFLEN];

char charin (fp)
struct FileInfoBlock *fp;
{
	static LONG inpoint=BUFLEN-1;
	static LONG maxin=BUFLEN-1;
	LONG Read ();
	char ch;
	if (++inpoint>=maxin)
	{
		maxin=Read (fp,inbuffer,BUFLEN);
		inpoint=0;
	}
	if (maxin==0)
		return (0);	/* End of file */
	ch=inbuffer[inpoint];
	if (ch<' ' && ch!='\0' && ch!='\n')
		ch=' ';		/* Don't give any weird characters like some WPs put in */
	return (ch);
}

short readfile (filename)
char *filename;
{
	struct FileInfoBlock *fp,*Open ();
	char charin ();
	int endoffile=0;
	short i;
	if (!(fp=Open (filename,MODE_OLDFILE)))
		return (1);	/* Error */
	do
	{
		i=0;
		do
			prbuf[i++]=charin (fp);
		while (prbuf[i-1]!=EOF && i<200);
	if (prbuf[i-1]!=EOF)
		{
		do
			prbuf[i++]=charin (fp);
		while (prbuf[i-1]!=EOF && i<250 && prbuf[i-1]!=' ');
		}
	if (prbuf[i-1]!=EOF)
		prbuf[i]='\0';
			else
				endoffile++;
		print (prbuf);
	}
	while (endoffile==0);
	Close (fp);
	return (0);
}
