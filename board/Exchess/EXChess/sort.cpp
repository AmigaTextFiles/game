/*-------------------------- Sorting Routines ------------------------*/
//  This is a collection of sorting routines from various sources
//  The Insert Sort seems to be the fastest for these applications
//  and it is also a "stable" sort - which is desirable

#include "chess.h"
#include "define.h"
#include "const.h"
#include "funct.h"

typedef move_rec T;
typedef move_rec TblIndex;
#define CompGT(a,b) (a < b)

void InsertSort(T *Lb, T *Ub);
void ShellSort(T *Lb, T *Ub);
void QuickSort(T *Lb, T *Ub);


void Sort(move_rec *Lb, move_rec *Ub)
{
   InsertSort(Lb, Ub);
}

/* -------------- Insert Sort Routine ---------------------*/

void InsertSort (T *Lb, T *Ub) {
   T V, *I, *J, *Jmin;
   /**********************
   *  Sort Array(Lb..Ub) *
   **********************/
   Jmin = Lb - 1;
   for (I = Lb + 1; I <= Ub; I++) {
       V = *I;
       for ( J = I-1; J != Jmin && CompGT(J->score,V.score); J--)
	   *(J+1) = *J;
       *(J+1) = V;
   }
}

void ShellSort (T *Lb, T *Ub) {
  int inc = 1; T V, *I, *J;
  do {
     inc *= 3;
     inc++;
  } while (inc <= Ub - Lb);
  do {
     inc /= 3;
     for (I = Lb+inc; I <= Ub; I++) {
         V = *I;
         J = I;
         while ((J-inc)->score < V.score) {
             *J = *(J-inc);
              J -= inc;
              if ((J-Lb) < inc) break;
         }
         *J = V;
     }
  } while (inc > 1);
}

/*------------------- Quick Sort Routine --------------------*/

T *Partition(T *Lb, T *Ub) {
    T  V, Pivot, *I, *J, *P;

    unsigned int Offset;

    Offset = (Ub - Lb)>>1;
    P = Lb + Offset;
    Pivot = *P;
    *P = *Lb;

    I = Lb + 1;
    J = Ub;
    while (1) {
	while (I < J && CompGT(Pivot.score, I->score)) I++;
	while (J >= I && CompGT(J->score, Pivot.score)) J--;

	if (I >= J) break;
	V = *I;
	*I = *J;
	*J = V;
	J--; I++;
    }

    *Lb = *J;
    *J = Pivot;

    return J;
}

void QuickSort(T *Lb, T *Ub) {
    T *M;

    while (Lb < Ub) {

      M = Partition (Lb, Ub);

      if (M - Lb <= Ub - M) {
	  QuickSort(Lb, M-1);
	  Lb = M+1;
      } else {
	  QuickSort(M+1, Ub);
	  Ub = M - 1;
      }
   }
}


