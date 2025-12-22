#include "wsearch.h"

void CleanUp()
{
	int i,j;
	
	j=0;
	for(i=0;i<MAXWORD;i++)
	{
		if(word[i][0]!=0)
		{
			if(i!=j)
			{
				strcpy(word[j],word[i]);
			}
			j++;
		}
	}
	for(i=j;i<MAXWORD;i++)
		word[i][0] = 0;
}
			
void UpperCase()
{
	int i,j;
	
	for(i=0;i<MAXWORD;i++)
	{
		j=0;
		while(word[i][j]!=0)
		{
			if(word[i][j]>='a' && word[i][j]<='z')
				word[i][j]=word[i][j]-('a'-'A');
			j++;
		}
	}
}

void Sort()
{
	int i,j,ls;
	char buffer[MAXSIZE+1];
	
	ls=MAXWORD-1;
	while(ls>0)
	{
		j=0;
		for(i=0;i<ls;i++)
		{
			if((strncmp(word[i],word[i+1],MAXSIZE)>0
			    && word[i+1][0]!=0) ||
			    (word[i][0]==0 && word[i+1][0]!=0))
			    {
				j=i;
				strcpy(buffer,word[i]);
				strcpy(word[i],word[i+1]);
				strcpy(word[i+1],buffer);
			    }
		}
		ls = j;
	}
}
