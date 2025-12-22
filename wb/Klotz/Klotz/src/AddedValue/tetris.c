/* DOS int. 8/92 */

#include <stdio.h>
#include <stdlib.h>
/* ... */
#ifdef __GNUC__
 struct Library*DOSBase;
# include <inline/dos.h>
#endif
int i,j,l,w,r,p,R,F,P,S,W;

char V[] ="01<=/012$/01$01=%01<$0<=$0;<$0<"
	  "H$01</01<$/0<01;</0<=/01;#$0<%/01#/01$%0</01=",
     U[264];
void delay(int timeout) { Delay(1); }
int kbhit()
{
 return WaitForChar(l,6);
}
int getch()
{
 char buffer[10];
 int len,retval=0;
 len=Read(l,buffer,4);
 if(len>0) if((retval=buffer[0])=='\x9b') retval=buffer[1];
 return retval;
}

void gotoxy(int x,int y)
{
 Printf("\x9b%ld;%ld\x48",y,x);
}
void textattr(int c)
{
 if(c==8)   Printf("\x9b" "30;41m");
 else	    Printf("\x9b%ld;%ldm",40+c,30+c);
}
void setcursortype(int mode)
{
 Printf("\x9b\x3e\x31\x6c\x9b\x3f\x37\x6c\x9b\x30\x20\x70");
}
void clrscr()
{
 Printf("\x9bH\x9bJ");
}
void u(int a,int b)
{
 if(a<0) a=0;
 if(b>264) b=264;
 for(i=a;i<b;i++)
 {
  gotoxy(i%12*2+22,i/12+3);
  textattr(U[i]);
  Printf("++");
 }
}
void s(int n)
{
 for(i=0;i<4;i++) U[P+V[4*R+i]-'0']=F*n;
}
int t(int p,int f)
{
 for(i=3;i+1 && !U[p+V[4*f+i]-'0'];i--);
 return i+1;
}
int main()
{
 int d;
 l=Open("raw://400/400/** Tetris **",MODE_OLDFILE);
 d=SelectOutput(l);

 srand(time(NULL));
 setcursortype(0);
 for(;;)
 {
  S=R=0,P=17,W=F=1,memset(U,8,264);
  for(i=1;i<253;i+=12) memset(U+i,0,10);
  clrscr();
  u(0,264);
  while(P)
  {
   s(0);
   for(w=16;w>0;w--)
   {
    delay(14);
    if(kbhit())
    {
     r=R,p=P;
     switch(getch())
     {
      case 52:p--;break;
      case 54:p++;break;
      case 32:r="AHILMNQBJKCDEOPFRSG"[R]-65;break;
      case 27: Close(SelectOutput(d)); exit(0);
      case 50:w=0;
     }
     if(!t(p,r)) P=p,R=r,s(1),u(P-25,P+36),s(0);
    }
   }
   if(!t(P+12,R)) P+=12,s(1),u(P-25,P+36);
   else
   {
    s(1);
    for(i=20;i;i--)
     if(strlen(U+i*12)>11) S++,memmove(U+12,U,i++*12);
    u(0,264);

    Printf("\x9bH\x9b" "31;40m%9ld",S);

    F=(R=((rand()>>4)%7))+(W=1),P=P<24?0:17;
   }
  }
 }
}
