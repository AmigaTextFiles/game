/* ==== testcos.c ==== */
/* test harness */
#include "cosmap.h"

int main()
{
    int deg;
    for (deg=0;deg<10;deg++)
       printf("pos %d: Pcos %d\n",deg,calc_cos(10,16,deg));
}
