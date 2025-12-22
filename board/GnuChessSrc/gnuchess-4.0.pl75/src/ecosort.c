#include "gnuchess.h"    
struct gdxecodata
      {
          unsigned long hashbd;
          unsigned long hashkey;
          unsigned int ecoptr;
          utshort cntr;
      };
char strcmd[256];
main()
{
sprintf(strcmd,"./binsort -r %d -k L:a:0:2<step1.eco>step2.eco\n",sizeof(struct gdxecodata));
printf("%s",strcmd);
system(strcmd);
exit(0);
}
