#include <clib/asyncio_protos.h>
#include <clib/dos_protos.h>

struct
{
char *from,*to;
} args;

int main(int argc,char **argv)
{
struct AsyncFile *rf,*wf;
if(argc>0)
	{
	struct RDArgs *rd;
	if(rd=ReadArgs("FROM/A,TO/A",(LONG *)&args,0L))
		{
		FreeArgs(rd);
		}
	else return RETURN_ERROR;
	}
else return RETURN_ERROR;
if(rf=OpenAsync(args.from,MODE_READ,8192))
	{
	if(wf=OpenAsync(args.to,MODE_WRITE,8192))
		{
		int skip=0;
		for(;;)
			{
			long c=ReadCharAsync(rf);
			if(c<0) break;
			if(c=='{'||c=='(')
				{
				skip++;
				continue;
				}
			if(c=='}'||c==')')
				{
				skip--;
				continue;
				}
			if(c=='\r') continue;
			if(!skip)
				{
				if(WriteCharAsync(wf,c)<0) break;
				}
			}
		CloseAsync(wf);
		}
	CloseAsync(rf);
	}
return 0;
}
