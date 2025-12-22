/* Solve Knight by Ventzislav Tzvetkov  (c) 2002-04

                http://drhirudo.hit.bg
                drHirudo@amigascne.org
 
MS-DOS modifications and port on 21/12/2003

More info about the algorithm is in the Amiga Source - SolveKnight.c

*/

#include <stdio.h>

#define OX 8 /* X dimension of the board */

#define OY 8 /* Y dimension of the board */

char BO[10][10],IM[10],IJ[10],PX[100][8],PY[100][8],X[10][10],
SS[100],BI[100],BJ[100],SN[10];

main () {
double QQ=0;

char IM[]={0,1,2,2,1,-1,-2,-2,-1},JM[]={0,-2,-1,1,2,2,1,-1,-2};

char J,I,II,JJ,S,KK,L,M,R,XR,YR,N,IS,JS,K,XY,IN,JN,B;

printf ("SolveKnight by Ventzislav Tzvetkov (c) 2002\nPorted to MS-DOS on 21/12/2003\n\n");
/* Step 1 */
do {printf("Start position:");
scanf("%c%c",&J,&I);
if (J>('A'-1) && J<('H'+1)) J=(J-('A'))+'1';
if (J>'a'-1 && J<'h'+1) J=(J-('a'))+'1';
}
while (J<'1' || J>'8' || I<'1' || I>'8');
I=9-(I-'0');
J-='0';
printf("Searching for solution....");
scanf("%c",&B);
 /* Calculations (Step 2)*/
 for (II=1;II<OX+1;II++){
  for (JJ=1;JJ<OY+1;JJ++){S=0;
   for (KK=1;KK<9;KK++){L=II+JM[KK];M=JJ+IM[KK];
    if (L<1 || L>OX || M<1 || M>OY) continue;
    S++;
    PX[(II-1)*OY+JJ][S]=IM[KK];
    PY[(II-1)*OY+JJ][S]=JM[KK];
   }
  X[II][JJ]=S;
  }
 }
 for(XR=1;XR<OX+1;XR++){
  for(YR=1;YR<OY+1;YR++){
   N=(XR-1)*OY+YR;
   S=X[XR][YR];
   for (K=1;K<S+1;K++)SN[K]=X[XR+PY[N][K]][YR+PX[N][K]];
   for (IS=1;IS<S+1;IS++){
    for (JS=IS+1;JS<S+1;JS++){
    if (JS>S) continue;
    if (SN[IS]<=SN[JS]) continue;
    R=SN[IS];SN[IS]=SN[JS];SN[JS]=R;
    R=PX[N][IS];PX[N][IS]=PX[N][JS];PX[N][JS]=R;
    R=PY[N][IS];PY[N][IS]=PY[N][JS];PY[N][JS]=R;
    }
   }
  }
 }
N=1;
L=X[I][J];
K=0;
BI[1]=I;
BJ[1]=J;
BO[I][J]=1;
XY=OX*OY;

Step3: K++;

Step4: if (K>L) goto Step5;
M=(I-1)*OY+J;
IN=I+PY[M][K];
JN=J+PX[M][K];
if (BO[IN][JN]) goto Step3;
SS[N]=K;
N++;
BI[N]=IN;
BJ[N]=JN;
BO[IN][JN]=N;
L=X[IN][JN];
I=IN;
J=JN;
K=1;

if (N==XY) {/*Shows the result - Step 6 */
  QQ++;
  printf("\nBoard %dX%d solution: %G\n.-----------------------.\n",OX,OY,QQ);
  for (XR=1;XR<OX+1;XR++) 
  {for (YR=1;YR<OY+1;YR++)
   {if (BO[XR][YR]<10) printf ("| "); else printf("|");
    printf("%d",BO[XR][YR]);
}
  printf("|\n");
  }printf("`-----------------------'\n");

printf("\nPress Q for quit, other for more:");
while (!bioskey(1));
B=bioskey(0);
if (B=='Q' || B=='q') goto Step8;
 }
goto Step4;

Step5: BO[BI[N]][BJ[N]]=0;
SS[N]=0;
N--;
L=X[BI[N]][BJ[N]];
K=SS[N];
if (N==1 && K==L) {/* Step 7 */ if (QQ==0)
 printf("\nBoard %dX%d, start position at %d,%d have no full solution!\n",OX,OY,BI[1],BJ[1]);
 else printf("\nTotal %G solutions.\n",QQ);return (0);}
I=BI[N];
J=BJ[N];
goto Step3;
Step8:
 if (QQ<2) printf("\nShown one solution.\n");
 else printf("\nShown %G solutions.",QQ);
return (0);
}

