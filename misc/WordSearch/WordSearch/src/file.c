#include <stdio.h>
#include <exec/types.h>
#include <exec/libraries.h>
#include "wsearch.h"
#include "interface.h"
#include <proto/req.h>
#include "funcs.h"

char file[DSIZE+FCHARS] = "";

struct ReqFileRequester	MyFileReqStruct;
char filename[FCHARS] = "";
char directoryname[DSIZE] = "";

BOOL filerequest(file)
	char *file;
{
	BOOL result;
	
	file[0] = 0;

		/* Initialize the 'PathName' field so that the file requester will */
		/* construct a complete path name for me.  It will also put the two */
		/* parts of the answer (directory and file name) into the directory */
		/* file name which I also decided to supply it with.  Since the */
		/* directory and file name arrays are present, it will use their */
		/* initial contents as the initial file and directory.  If they aren't */
		/* present it will leave both blank to start. */
	MyFileReqStruct.PathName = file;
	MyFileReqStruct.Dir = directoryname;
	MyFileReqStruct.File = filename;

		/* The directory caching of this file requester is one of its nice */
		/* features, so I decided to show it off.  It is completely optional */
		/* though, so if you don't want it, don't set this flag.  If you do */
		/* want it, don't forget to call PurgeFiles() when you are done. */
	MyFileReqStruct.Flags = FRQCACHINGM;

		/* Initialize a few colour fields.  Not strictly necessary, but */
		/* personally, I like having my files a different colour from my */
		/* directories. */
	MyFileReqStruct.dirnamescolor = 2;
	MyFileReqStruct.devicenamescolor = 2;
		/* I could also make it larger, pass it a file and/or directory */
		/* name, set the window title, set various flags and customize */
		/* in many other ways, but I wanted to show that it can be easily */
		/* used without having to fill in a lot of fields. */
	result = FileRequester(&MyFileReqStruct);
	PurgeFiles(&MyFileReqStruct);
		
	return(result);
}

/* BOOL filerequest(file)
 char *file;
 {
    printf("Enter filename:\n",file);
    scanf("%s",file);
    return(TRUE);
 }
 */
 
BOOL loadfile()
{
    FILE *ptr;
    int i,j;
    int tpx, tpy, tw, trot, tfilter;
    
    tpx = px; tpy=py; tw = w; trot = rot; tfilter = filter;

    if(filerequest(file)==FALSE) return(FALSE);
    if(file[0]==0) return(FALSE);

    ptr = fopen(file,"r");
    if(ptr<=0)
        return(FALSE);
    else
    {
        fscanf(ptr,"%d %d %d %d %d",&px,&py,&w,&rot,&filter);
	fgets(word[0],MAXSIZE,ptr); /* get rid of eol */
        for(i=0;i<=w;i++)
	{
                fgets(word[i],MAXSIZE,ptr);
		if(word[i][strlen(word[i])-1]=='\n')
			word[i][strlen(word[i])-1]=0;
	}
	if(AllocDims()==FALSE)
	{
		px = tpx; py = tpy; w = tw; rot = trot; filter = tfilter;
		return(FALSE);
	}
        for(i=0;i<=px;i++)
                for(j=0;j<=py;j++)
                        fscanf(ptr,"%c%c",&Key(i,j),&Puzzle(i,j));
        fclose(ptr);

        if(rot==0) rot=1;
        for(i=0;i<8;i++)
                M2I2[i].Flags=M2I2[i].Flags&~CHECKED;
        M2I2[rot].Flags=M2I2[i].Flags|CHECKED;

        if(filter==0) filter=255;
        for(i=0;i<8;i++)
                if((filter&1<<i)!=0)
                        M1I2[i].Flags=M1I2[i].Flags|CHECKED;
                else
                        M1I2[i].Flags=M1I2[i].Flags&~CHECKED;

        return(TRUE);
    }
}

BOOL savefile()
{
    FILE *ptr;
    int i,j;

    if(file[0]==0)
        if(saveasfile()==FALSE) return(FALSE);
    else
    {
        ptr = fopen(file,"w");
        if(ptr<=0)
                return(FALSE);
        else
        {
                fprintf(ptr,"%d %d %d %d %d\n",px,py,w,rot,filter);
                for(i=0;i<=w;i++)
                        fprintf(ptr,"%s\n",word[i]);
                for(i=0;i<=px;i++)
                        for(j=0;j<=py;j++)
                                fprintf(ptr,"%c%c",Key(i,j),Puzzle(i,j));
                fclose(ptr);
                return(TRUE);
        }
    }
}

BOOL saveasfile()
{
        if(filerequest(file)==FALSE)
                return(FALSE);
        else if(file[0]!=0)
                return(savefile());
}


void printlist()
{
    FILE *ptr;
    int i,w;
    static char file[100]="";

    if((M0I5[0].Flags&CHECKED)!=0)
    {
        if(filerequest(file)==FALSE) return;
    }
    else
    {
        strcpy(file,"PRT:");
    }

    ptr = fopen(file,"w");
    if( ptr>0 )
     {
        w=MAXWORD-1;
        while(word[w][0]==0 && w!=-1)
            w--;
        i = 0;
        while(i<=w)
        {
            fprintf(ptr,"%s\n",word[i]);
            i++;
        }
        fclose(ptr);
     }
}

void printpuz()
{
    FILE *ptr;
    int i,w;
    static char file[100]="";

    if((M0I5[0].Flags&CHECKED)!=0)
    {
        if(filerequest(file)==FALSE) return;;
    }
    else
    {
        strcpy(file,"PRT:");
    }

    ptr = fopen(file,"w");
    if( ptr>0 )
     {
        if(rot<5) w=py; else w = py;
        i = 0;
        while(i<=w)
        {
            fprintf(ptr,"%s\n",&Display(i,0));
            i++;
        }
        fclose(ptr);
     }
}

