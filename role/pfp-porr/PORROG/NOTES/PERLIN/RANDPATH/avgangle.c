/* ==== avgangle.c ==== */

int avgangle(int a,int b)
{
   int c,use;
   c=b-a;
   use=(c>180)?(c-360):((c<-180)?(360+c):c);
   return (b+(use/2))%360;
}
