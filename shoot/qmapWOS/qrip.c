#include <stdio.h>
#include <stdlib.h>

int    LittleLong (int l)
{
   unsigned char    b1,b2,b3,b4;

   b1 = l&255;
   b2 = (l>>8)&255;
   b3 = (l>>16)&255;
   b4 = (l>>24)&255;

   return ((int)b1<<24) + ((int)b2<<16) + ((int)b3<<8) + b4;
}

int main()
{
        FILE *f1,*f2;
        int *mem,*mem2;
        int header[3];
        int hoffset,hsize;
        int i;
        f1=fopen("PAK0.PAK","rb");
        fread(header,1,12,f1);
        hoffset=LittleLong(header[1]);
        hsize=LittleLong(header[2]);
        mem=malloc(hsize);
        printf("%x\n",mem);
        fseek(f1,hoffset,SEEK_SET);
        fread(mem,1,hsize,f1);
        for(i=0;i<hsize/64;i++)
        {
                int offset=LittleLong(*(int*)(mem+64*i+56));
                int size=LittleLong(*(int*)(mem+64*i+60));
                printf("%s  ",mem+64*i);
                printf("%d\n",size);
                f2=fopen((char *)mem+64*i,"wb");
                mem2=malloc(size);
                fseek(f1,offset,SEEK_SET);
                fread(mem2,1,size,f1);
                fwrite(mem2,1,size,f2);
                fclose(f2);
                free(mem2);
        }
        free(mem);
        fclose(f1);
}
