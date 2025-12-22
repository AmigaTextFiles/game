/* Solve Knight by Ventzislav Tzvetkov © 2002-04

                   http://drhirudo.hit.bg
                   drHirudo@amigascne.org

First bulgarian. English text below.

Български:

  Една от най-древните занимателни задачи е преминаването на коня през
всички възможни полета на шахматната дъска. Тя се формулира по следния
начин:
  Може ли конят, започвайки от произволно поле на шахматната дъска, да
направи 63 хода по такъв начин, че да посети всяко поле точно един път?
  Такъв маршрут на коня се нарича тур на коня. Маршрутът е отворен, ако
започва от едно поле, а завършва в друго. Маршрутът е затворен, ако конят
след като обходи всички полета на дъската, се връща в началото.
  Най-ранния опит за математически анализ на проблема прави Ойлер в 1759
г. По-късно изящно решение предлага Варнсдорф (1823 г.). Правилото на
Варнсдорф дава следната стратегия: конят прави всеки следващ ход на това
поле, от което атакува най-малък брой непосетени полета.
  Тъй като засега обаче не разполагаме с математическа теория, която би
помогнала бързо да решим поставената задача, единствената ни възможност е
да проверим всички възможни маршрути. И тогава се сблъскваме с известния
комбинаторен взрив: само затворените маршрути на шахматната дъска са
3 456 235 672.
  Избираме следната стратегия:
  Ще генерираме последователно възможните маршрути на коня, докато сред
тях не се окаже и тур на коня.
  На шахматната дъска съпоставяме правоъгълна координатна система 
(фиг. 1). С N е означен номерът на текущия ход, а с X1, X2,......, X8
възможните следващи ходове на коня.
  На всяко поле съпоставяме координатите на долния му ляв връх.
Например поле a1 има координати (1, 1). В общия случай, стъпвайки на поле
с координати i,j (0<i,j<9), конят има 8 възможни хода (фиг. 1).
Координатите на възможните ходове от поле с координати (i, j) са дадени
на фиг. 2. Те трябва да бъдат по-големи от 0 и по-малки от 9, за да не
напуска конят шахматната дъска.
  Идеята на алгоритъма, реализиран с програма на C за всички компютри от
фамилията Amiga, е следната:
  Тръгвайки от произволно поле, се движим по незаетите полета, докато не
обходим дъската или не стъпим на поле, от което не може да се продължи.
На всяко поле ще проверяваме кое поред от осемте възможни полета е
свободно (фиг. 1). В случай че няма такова, ще анулираме последния
направен ход на коня и ще избираме друго поле за този ход. Ако отново
няма свободно поле, ще анулираме и този ход. Фактически правим пълно
изследване на всички маршрути, кандидати за тур на коня, с връщане назад
(често използуван подход при решаване на комбинаторни задачи).
  За да съкратим времето за проверка, е удобно предварително да знаем
броя и възможните ходове на коня за вско поле от шахматната дъска.
Например от поле a8 има 2 възможни хода, докато от поле d5 - осем.
 Дори и след тази подготовка броят на възможните маршрути, сред които са
туровете на коня (ако има такива), е равен на астрономическото число
(2^4)*(3^8)*(4^20)*(6^16)*(8^16). За да се изчисли в явен вид, се налага
създаване на специфични програми, с които се получава числото
91653624689233987245068783089656480594395136.
  Основните стъпки на описаната идея са дадени по-долу (Алгоритъм). Ще
отбележим, че описаният подход е валиден за шахматна дъска с произволни
размери.

                                АЛГОРИТЪМ

  1. Въвеждане на координатите на началното поле.
  2. Пресмятане на възможните ходове от всяко поле.
  3. Има ли свободно поле? Ако има, премини към 4, иначе премини към 5.
  4. Пореден ход. Стъпи на поредното свободно от възможните полета. Ако
     дъската е обходена, премини към 6, иначе премини на 3.
  5. Връщане назад. Анулирай последния направен ход. Ако са генерирани
     всички маршрути, премини на 7, иначе се върни на 3.
  6. Изведи получения тур и премини на 5.
  7. Край.

  Съществените стъпки са 3-5. На стандартна шахматна дъска, тръгвайки от
поле с координати (1, 8) на фиг. 3а, на 57-ия ход конят е стъпил на
поле с координати (5, 8), откъдето е невъзможно да продължи. Следвайки
стъпки 4-5 на алгоритъма, конят трябва да се върне два хода назад и на
55-ия ход вместо на поле (3, 4) да стъпи на (3, 6) на фиг. 3б. В
посочения маршрут на игралното поле (1, 8) е присвоен номер N = 1.
  При изследване на работата на посочения алгоритъм се оказа, че е
целесъобразно полетата, кандидати за следващ ход на коня, предварително
да се подредят съгласно правилото на Варнсдорф.
  Стъпките на алгоритъма са отбелязани в програмата със съответен етикет
(Step1..7).
  В програмата се използват следните масиви и променливи:

                OX,OY - размери на дъската;

                  I,J - координати на текущия ход;

                  XY  - дължина на тура;

           BO[10][10] - Номер на ход в поле с координати (I, J);

          IM[8],JM[8] - стойности, добавяни към текущите координати за
                        получаване на координатите на следващо поле;
            X[10][10] - Брой възможни полета за следващ ход;

                    L - Брой на възможните полета за N+1-ия ход;

PX[100][8],PY[100][8] - Стойности, добавяни към координатите на текущото
                        поле за генериране на следващ ход;
                IN,IJ - координати на поле, кандидат за следващ ход на
                        коня;
              BI[100] - абсциса и ордината на поредните ходове;

              BJ[100] - (BI[1], BJ[1]) са координатите на поле 1;

              SS[100] - кое поред от възможните полета е избрано на N-ия
                        ход;
                    K - кое поред от възможните полета е избрано за
                        следващия ход;
                   QQ - брой на туровете;

               SN[10] - помощен масив;

    II,JJ,IS,JS,KK,XR - работни променливи;

         YR,S,R,L,M,S - работни променливи.

Фиг. 1. Възможни ходове на коня

  0  1  2  3  4  5  6  7  8
   .------------------------->X
   |  |  |  |  |  |  |  |  |
  8|-----------------------|
   |  |  |  |X8|  |X1|  |  |
  7|-----------------------|
   |  |  |  |  |  |  |X2|  |
  6|-----------------------|
   |  |  |  |  |N |  |  |  |
  5|-----------------------|
   |  |  |X6|  |  |  |X3|  |
  4|-----------------------|
   |  |  |  |X5|  |X4|  |  |
  3|-----------------------|
   |  |  |  |  |  |  |  |  |
  2|-----------------------|
   |  |  |  |  |  |  |  |  |
  1|-----------------------'
   |A  B  C  D  E  F  G  H
   Y

Фиг. 2. Координати на възможните ходове от поле N(I,J)

  .-----------------------.
  | Възможно | Координати |
  |          |------------|
  |  поле    |   X  |  Y  |
  |----------|------|-----|
  |    X1    |  i+1 | j-2 |
  |    X2    |  i+2 | j-1 |
  |    X3    |  i+2 | j+1 |
  |    X4    |  i+1 | j+2 |
  |    X5    |  i-1 | j+2 |
  |    X6    |  i-2 | j+1 |
  |    X7    |  i-2 | j-1 |
  |    X8    |  i-1 | j-2 |
  `-----------------------'

Фиг.3 Връщане назад

             а)                                       б)

   .-----------------------.             .-----------------------.
   | 1| 4|37|20|57| 6|45|22|             | 1| 4|37|20|  | 6|45|22|
   |-----------------------|             |-----------------------|
   |38|19| 2| 5|  |21|50| 7|             |38|19| 2| 5|  |21|50| 7|
   |-----------------------|             |-----------------------|
   | 3|36|  |56|  |44|23|46|             | 3|36|55|  |  |44|23|46|
   |-----------------------|             |-----------------------|
   |18|39|  |  |54|49| 8|51|             |18|39|  |  |54|49| 8|51|
   |-----------------------|             |-----------------------|
   |35|14|55|  |43|52|47|24|             |35|14|  |  |43|52|47|24|
   |-----------------------|             |-----------------------|
   |40|17|  |53|48|27|30| 9|             |40|17|  |53|48|27|30| 9|
   |-----------------------|             |-----------------------|
   |13|34|15|42|11|32|25|28|             |13|34|15|42|11|32|25|28|
   |-----------------------|             |-----------------------|
   |16|41|12|33|26|29|10|31|             |16|41|12|33|26|29|10|31|
   `-----------------------'             `-----------------------'

English:

  One of the ancientest time-wasting tasks is to go with the knight to
all the squares of a chess board. It can be defined by this way:
  Can the knight, starting at any square of chess board, make 63 moves by
passing only one time each of the squares? Such travel of the knight
is called "Knight travel". The travel is open, if it starts at one
square, and ends at another. The travel is closed, if the knight after
going to all squares, returns at the start.
  The earliest try for mathematical analysis of the problem makes Oiler
in 1759. Later an fine solution offers Varnsdorf (1823). The rule of 
Varnsdorf gives the following strategy: the knight makes every next move
at such square, from which he attacks smallest number of unvisited
squares.
  Since currently we don't have such mathematical theory, which can help
for fast solution of the given task, the only possibility is to check
every possible travels. And then we face the known combinatory explosion:
only the closed travels on the chess board are 3 456 235 672.
  We choose the following strategy:
  We will generate sequently the possible travels of the knight, until
some of them came as "Knight travel".
  For the chess board we make square coordinate system (fig. 1). With N
is noted the number of the current move, and with X1, X2,......, X8
the possible next moves of the knight.
  For each square we set coordinates relative to the bottom-left corner.
For example square a1 have coordinates (1, 1). In the common occasion,
stepping at square with coordinates i,j (0<i,j<9), the knight have 8
possible moves (fig. 1). Coordinates of the possible moves from square
with coordinates (i, j) are given at fig. 2. They must be bigger from 0
and less from 9, for the knight not leaving the chess board.
  The idea of the algorithm, realised with program in C for all range of
Amiga computers, is the following: 
  Starting from random square, we move to the free squares, until we
travel through the board or we step at square, from which we can't
continue. At every square we will check which one from the eight possible
squares is free (fig. 1). In case there is no such, we will anulate the
last move and will choose another square for this move. If again there 
is no free square, we will anulate this move also. In fact we make full
exploration of every travel, candidates for "Knight travel", with move
back (often used method for solving combinatory tasks).
  To reduce the time for check, it is good to know at first place
the number and the possible moves of the knight for every square on the
chess board. For example square a8 have 2 possible moves, but from sqyare
d5 - eight.
  Even after this preparations the number of the possible travels, some
of which are "Knight travels" (if there are any), is equal to the
astronomical number (2^4)*(3^8)*(4^20)*(6^16)*(8^16). To calculate it
in viewable from, special programs are needed, which show the number
91653624689233987245068783089656480594395136.
  The basic steps of the described idea are given below (Algorithm). Note
that the listed method is valid for chess board with any dimensions.


                                ALGORITHM

  1. Input the coordinates for start square.
  2. Calculates the possible moves from every square.
  3. Is there any free square? If yes, go to 4, else go to 5.
  4. Current move. Step at the next free from the possible squares. If
     the board is travelled, go to 6, else go to 3.
  5. Move back. Anulate the last made move. If all the travels are
     generated, go to 7, else go back to 3.
  6. Show the computed travel and go to 5.
  7. End.

  The essential steps are 3-5. On standart chess board, starting from
square with coordinates (1, 8) at fig. 3a, at the  57th move the knight
have stepped on square with coordinates (5, 8), from where it's
impossible to continue. Following the steps 4-5 of the algorithm, knight
have to move back two moves and at the 55th move instead of square (3, 4)
to step at square (3, 6) at fig. 3b. In the shown travel on the playing
board (1, 8) have assigned number N = 1.
  When analysing the work of the shown algorithm it came up, that it is
better choise the square candidates for next move of the knight, to
be sorted according to the rule of Varnsdorf.
  The steps of the algorithm are signed in the program with the according
label (Step1..7).
  In the program the following variables and arrays are used:

                OX,OY - dimensions of the board;

                  I,J - coordinates of the current move;

                  XY  - how many moves are needed for solve;

           BO[10][10] - Number of the move on the board with
                        coordinates (I, J);
          IM[8],JM[8] - Values which are added for getting
                        the coordinates of next square;
            X[10][10] - Number possible squares for next move;

                    L - Number of possible squares for N+1th move;

PX[100][8],PY[100][8] - Values added to the coordinates of the
                        current square for getting next move;
                IN,IJ - Coordinates of the square, candidate for
                        next move;
              BI[100] - X and Y of the queued moves;

              BJ[100] - (BI[1], BJ[1]) are the coordinates of the square
                        1;
              SS[100] - Which number of the possible square have
                        been choosen at Nth move;
                    K - Which number of the possible squares have
                        been choosen for next move;
                   QQ - Number of the solution;

               SN[10] - help array;

    II,JJ,IS,JS,KK,XR - work variables;

         YR,S,R,L,M,S - work variables.

Fig. 1. Possible moves of the knight

  0  1  2  3  4  5  6  7  8
   .------------------------->X
   |  |  |  |  |  |  |  |  |
  8|-----------------------|
   |  |  |  |X8|  |X1|  |  |
  7|-----------------------|
   |  |  |  |  |  |  |X2|  |
  6|-----------------------|
   |  |  |  |  |N |  |  |  |
  5|-----------------------|
   |  |  |X6|  |  |  |X3|  |
  4|-----------------------|
   |  |  |  |X5|  |X4|  |  |
  3|-----------------------|
   |  |  |  |  |  |  |  |  |
  2|-----------------------|
   |  |  |  |  |  |  |  |  |
  1|-----------------------'
   |A  B  C  D  E  F  G  H
   Y

Fig. 2. Coordinates of the possible moves from square N(I,J)

  .-----------------------.
  | Possible | Coordinates|
  |          |------------|
  |  square  |   X  |  Y  |
  |----------|------|-----|
  |    X1    |  i+1 | j-2 |
  |    X2    |  i+2 | j-1 |
  |    X3    |  i+2 | j+1 |
  |    X4    |  i+1 | j+2 |
  |    X5    |  i-1 | j+2 |
  |    X6    |  i-2 | j+1 |
  |    X7    |  i-2 | j-1 |
  |    X8    |  i-1 | j-2 |
  `-----------------------'

Fig.3 Move back.

             a)                                       b)

   .-----------------------.             .-----------------------.
   | 1| 4|37|20|57| 6|45|22|             | 1| 4|37|20|  | 6|45|22|
   |-----------------------|             |-----------------------|
   |38|19| 2| 5|  |21|50| 7|             |38|19| 2| 5|  |21|50| 7|
   |-----------------------|             |-----------------------|
   | 3|36|  |56|  |44|23|46|             | 3|36|55|  |  |44|23|46|
   |-----------------------|             |-----------------------|
   |18|39|  |  |54|49| 8|51|             |18|39|  |  |54|49| 8|51|
   |-----------------------|             |-----------------------|
   |35|14|55|  |43|52|47|24|             |35|14|  |  |43|52|47|24|
   |-----------------------|             |-----------------------|
   |40|17|  |53|48|27|30| 9|             |40|17|  |53|48|27|30| 9|
   |-----------------------|             |-----------------------|
   |13|34|15|42|11|32|25|28|             |13|34|15|42|11|32|25|28|
   |-----------------------|             |-----------------------|
   |16|41|12|33|26|29|10|31|             |16|41|12|33|26|29|10|31|
   `-----------------------'             `-----------------------'


*/

#include <stdio.h>

#define OX 8 /* X dimension of the board */

#define OY 8 /* Y dimension of the board */

char BO[10][10],IM[10],IJ[10],PX[100][8],PY[100][8],X[10][10],
SS[100],BI[100],BJ[100],SN[10];

main () {
double QQ=0;

char IM[]={0,1,2,2,1,-1,-2,-2,-1},JM[]={0,-2,-1,1,2,2,1,-1,-2};

char J,I,II,JJ,S,KK,L,M,R,XR,YR,N,IS,JS,K,XY,IN,JN;

printf ("SolveKnight by Ventzislav Tzvetkov © 2002-04\nPress Ctrl+C to stop or some other key to pause!\n\n");
/* Step 1 */
do {printf("Start position:");
scanf("%c%c",&J,&I);
if (J>('A'-1) && J<('H'+1)) J=(J-('A'))+'1'; /* Convert the chess  */
if (J>'a'-1 && J<'h'+1) J=(J-('a'))+'1';}    /* coordinate letters */
while (J<'1' || J>'8' || I<'1' || I>'8');    /* to numbers.        */
I=9-(I-'0');
J-='0';
printf("Searching for solution....");

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
 }
goto Step4;

Step5: BO[BI[N]][BJ[N]]=0;
SS[N]=0;
N--;
L=X[BI[N]][BJ[N]];
K=SS[N];
if (N==1 && K==L) {/* Step 7 */ if (QQ==0) printf("\nBoard %dX%d, start position at %d,%d have no full solution!\n",OX,OY,BI[1],BJ[1]);else
 printf("\nTotal %G solutions.\n",QQ);exit (0);}
I=BI[N];
J=BJ[N];
goto Step3;
}

/*

Fig. 4. "Knight travel": a) open;  b) closed.
Фиг. 4. Тур на коня:     a) отворен; b) затворен.


             a)                                       b)

   .-----------------------.             .-----------------------.
   | 1| 4|37|20|59| 6|45|22|             |35|14|33|30| 1|16|45|20|
   |-----------------------|             |-----------------------|
   |38|19| 2| 5|50|21|60| 7|             |32|29|36|15|46|19| 2|17|
   |-----------------------|             |-----------------------|
   | 3|36|51|58|53|44|23|46|             |13|34|31|62|55|64|21|44|
   |-----------------------|             |-----------------------|
   |18|39|54|63|56|49| 8|61|             |28|37|52|47|58|61|18| 3|
   |-----------------------|             |-----------------------|
   |35|14|57|52|43|62|47|24|             |51|12|59|56|63|54|43|22|
   |-----------------------|             |-----------------------|
   |40|17|64|55|48|27|30| 9|             |38|27|48|53|60|57| 4| 7|
   |-----------------------|             |-----------------------|
   |13|34|15|42|11|32|25|28|             |11|50|25|40| 9| 6|23|42|
   |-----------------------|             |-----------------------|
   |16|41|12|33|26|29|10|31|             |26|39|10|49|24|41| 8| 5|
   `-----------------------'             `-----------------------'
*/

