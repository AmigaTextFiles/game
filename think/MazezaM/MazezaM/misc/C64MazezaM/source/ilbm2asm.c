/* Converts ILBM brushes to assember sources. */

#include <stdio.h>
#include <stdlib.h>

#define HEADER 0x56

#define CHARSETLO      0x00
#define CHARSETHI      0x80


main(int argc, char **argv)
{
    unsigned char charbyte,nofcharbyte;
    char *buffer;
    int length,modulo;
    int count1,count2;
    FILE *in;
    if (argc<1) { 
        perror("Usage : BMP2ASM inputfile\n");
        exit(0);
    }
    in=fopen(argv[1],"r");
    if (in==NULL) { perror("Can't open input file\n"); exit(1); }
    fseek(in, 0, SEEK_END);
    length = ftell(in);
    rewind (in);
    length -= HEADER;
    buffer = malloc(length);
    fseek(in, HEADER, SEEK_SET);
    fread(buffer,1,length,in);
    fclose(in);
    modulo=length/8;
 for (count1=0;count1!=modulo;count1++)
{ printf("\n      .byte  ");
 for (count2=0;count2!=7;count2++)
  {nofcharbyte=buffer[count1+count2*modulo];
   /* Here we flip the byte for use on the Apple */

   printf ("%d,",(int) nofcharbyte);

}
   nofcharbyte=buffer[count1+count2*modulo];
   printf ("%d",(int) nofcharbyte);
}
    printf ("\n");
    free (buffer);
    return (0);
}
