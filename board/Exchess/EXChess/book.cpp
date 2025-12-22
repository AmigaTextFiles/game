/* Book.Cpp functions to construct a book file from
   a pgn-like text */

#include "chess.h"
#include "define.h"
#include "funct.h"
#include "const.h"
#include <stdio.h>
#include <string.h>
#include <iostream.h>
#include <fstream.h>
#include <math.h>
#include <time.h>

// define 64 bit integers
#if !BORLAND
 #define __int64 long long
 #define ZERO 0ULL
#else
 #define ZERO 0ui64
#endif

#if DEC
 #define IOS_OUT ios::out
 #define IOS_IN  ios::in
#else
 #define IOS_OUT ios::out | ios::binary
 #define IOS_IN  ios::in | ios::binary
#endif

// Maximum line depth in ply
#define LINE_DEPTH 30
// Theshold  of move score to use
#define THRESH 3
// Maximum number of book positions in a temp file
#define BOOK_POS 20000
// Maximum number of temp files
#define TEMP_FILES 200

struct book_rec {
 unsigned __int64 pos_code;
 int mcount;
 move_rec bmoves[10];
 int dummy;                    // to make record a multile byte size of 96
};

extern int T, shout_book;      // Turn variable, loud book variable

typedef book_rec TT;
typedef book_rec TblIndex;
#define CompGT(a,b) (a > b)

void QuickSort(TT *Lb, TT *Ub);
void ISort(TT *Lb, TT *Ub);

float ran1(long *idum);           // random number generator
int absl(int);

book_rec learn_book[100];         // book learning array
int learn_count = 0;
int learn_move[100];
int learn_filepos[100];

int chunk_count;
book_rec chunk_record[TEMP_FILES];
fstream chunk_file[TEMP_FILES];

extern char exec_path[100];           // from argv[0]

void build_book(position ipos)
{
  book_rec *record, *record_place;

  chunk_count = 1;  int p, pp;

  record = new book_rec[BOOK_POS];

  // initialize record structure
  for(p = 0; p < BOOK_POS; p++) {
   record[p].pos_code = ZERO;
   record[p].mcount = 0;
   for(pp = 0; pp < 10; pp++) {
    record[p].bmoves[pp].m.t = 0;
    record[p].bmoves[pp].score = 0;
   }
  }

  char file[20], instring[100], line[100], chunk[10];
  position temp_pos;
  move bmove;
  unsigned __int64 pcode;
  int i = -1, j = 0, k = 0, count = 0;

  cout << " Enter name of book text file: ";
  cin >> file;

  cout << " Building book.... please wait.\n";

  ifstream infile(file);

  if(!infile) { cout << "File not found!\n"; return; }

  infile.seekg(0,ios::end);
  unsigned long file_size = infile.tellg();
  infile.seekg(0,ios::beg);

  while(!infile.eof()) {
    infile >> instring;
    switch(instring[0]) {
     case '[':
      i++; count=0; infile.getline(line,99); temp_pos = ipos; break;
     case '1': break;
     case '2': break;
     case '3': break;
     case '4': break;
     case '5': break;
     case '6': break;
     case '7': break;
     case '8': break;
     case '9': break;
     default :
       count++; if(count > LINE_DEPTH) break;
       bmove = parse_move(temp_pos, instring);
       if(!bmove.t) { count = LINE_DEPTH; break; }
       pcode = ZERO;
       pcode = pcode|temp_pos.hcode.key;
       pcode = (pcode<<32)|(temp_pos.hcode.address);
       record_place = record;

       for(j = 0; ; j++) {
          if(record_place->pos_code == pcode ||
              !record_place->pos_code) break;
          record_place++;
        }

       if(!(j%1000) && j) {
         cout << "Adding " << j << "th record to chunk " 
              << chunk_count << ", " << (infile.tellg()*100)/file_size << "% done\n";
         cout.flush();
       }
       record_place->pos_code = pcode;
       for(k = 0; k < 10; k++)
        { if(record_place->bmoves[k].m.t == bmove.t
             || !record_place->bmoves[k].m.t) break; }
       if(k < 10) {
        record_place->bmoves[k].m.t = bmove.t;
        record_place->bmoves[k].score++;
        for(k = 0; k < 10; k++)
         { if(!record_place->bmoves[k].m.t) break; }
        record_place->mcount = k;
       }
       exec_move(&temp_pos, bmove, 1);
       break;
    }

    if (j>=BOOK_POS-1) {
      if(chunk_count >= TEMP_FILES) break;
      cout << "Sorting records for chunk " << chunk_count << "\n";
      for(j = 0; j < BOOK_POS-1; j++)
       { record_place = record+j;
         if(!record_place->pos_code) break; }
      QuickSort(record, record_place-1);
      sprintf(chunk, "temp_bk.%i", chunk_count);
      chunk_file[chunk_count-1].open(chunk, IOS_IN | IOS_OUT);
      for(i = 0; i < j; i++) {
       record_place = record+i;
       Sort(&record_place->bmoves[0],&record_place->bmoves[record_place->mcount-1]);
       chunk_file[chunk_count-1].write((char *) record_place, sizeof(book_rec));
      } 
      chunk_count++;     
        // initialize record structure
      for(p = 0; p < BOOK_POS; p++) {
       record[p].pos_code = ZERO;
       record[p].mcount = 0;
       for(pp = 0; pp < 10; pp++) {
        record[p].bmoves[pp].m.t = 0;
        record[p].bmoves[pp].score = 0;
       }
      }
      j = 0; 
    }
  }

  for(j = 0; j < BOOK_POS-1; j++)
   { record_place = record+j;
     if(!record_place->pos_code) break; }

  cout << "Sorting records for last chunk\n ";
  cout.flush();
  QuickSort(record, record_place-1);

      sprintf(chunk, "temp_bk.%i", chunk_count);
      chunk_file[chunk_count-1].open(chunk, IOS_IN | IOS_OUT);
      for(i = 0; i < j; i++) {
       record_place = record+i;
       Sort(&record_place->bmoves[0],&record_place->bmoves[record_place->mcount-1]);
       chunk_file[chunk_count-1].write((char *) record_place, sizeof(book_rec));
      } 

  ofstream out("open_bk.dat", IOS_OUT);
  cout << "Writing book file...\n";
  int min;

   min = 0;

   // first reading in a record from each chunk
   for(i = 0; i < chunk_count; i++) {
      if(chunk_file[i].eof()) { chunk_file[i].close(); break; }
      chunk_file[i].seekg(0,ios::beg);
      chunk_file[i].read((char *) &chunk_record[i], sizeof(book_rec));
   }

 while(1) {

   // Now probe for minimum entry
   min = 0;
   for(i = 0; i < chunk_count; i++) {
     if(min == i && !chunk_record[i].pos_code) { min++; continue; }
     if(chunk_record[min].pos_code > chunk_record[i].pos_code &&
        chunk_record[i].pos_code) min = i;
   }  

   if(min == chunk_count) break;     
       
   // merge all minimum records together - reading in more when necessary
   for(i = 0; i < chunk_count; i++) {
     if(i == min) continue;
     if(chunk_record[min].pos_code == chunk_record[i].pos_code) {
         // merging records
         for(j = 0; j < chunk_record[min].mcount; j++) {
          for(k = 0; k < chunk_record[i].mcount; k++) {
            if(chunk_record[min].bmoves[j].m.t == chunk_record[i].bmoves[k].m.t) {
             chunk_record[min].bmoves[j].score += chunk_record[i].bmoves[k].score;
             chunk_record[i].bmoves[k].score = -1;  // flag it as merged
             break;
            }
          }               
         }
         for(k = 0 ; k < chunk_record[i].mcount; k++) { 
            if(chunk_record[i].bmoves[k].score > 0 && j < 10) {
               chunk_record[min].bmoves[j].m.t = chunk_record[i].bmoves[k].m.t;
               chunk_record[min].bmoves[j].score = chunk_record[i].bmoves[k].score;
               j++;
            }
         } 
         chunk_record[min].mcount = j;
         Sort(&chunk_record[min].bmoves[0],&chunk_record[min].bmoves[j-1]);
         if(!chunk_file[i].eof())
          chunk_file[i].read((char *) &chunk_record[i], sizeof(book_rec));
         else chunk_record[i].pos_code = ZERO;
     }
   }
   
   if (chunk_record[min].bmoves[0].score >= THRESH)
    out.write((char *) &chunk_record[min], sizeof(book_rec));

   if(!chunk_file[min].eof())
       chunk_file[min].read((char *) &chunk_record[min], sizeof(book_rec));
   else chunk_record[min].pos_code = ZERO;
   
  
  }
  
  // remove temporary files
  for(j = 1; j <= chunk_count; j++) {
     chunk_file[j-1].close();
     sprintf(chunk, "temp_bk.%i", j);
     if(remove(chunk) == -1) cout << "Error deleting " << chunk << "\n";
  }

  out.close();
  delete [] record;
}

move opening_book(h_code hash_code, position *p)
{
  unsigned __int64 pcode = ZERO;
  book_rec record;
  int file_size, jump, mflag = 0, j;
  int file_pos = 0;
  move_list list;
  move nomove; nomove.t = 0;
  long seed = -time(NULL);
  char book_file[100];   // file name for the book
  ifstream in;           // in file for the book

  pcode = pcode|hash_code.key;
  pcode = (pcode<<32)|(hash_code.address);

  // generate legal moves
  legalmoves(p, &list);

  // look for book
  strcpy(book_file, exec_path);  // try executable directory
  strcat(book_file, BOOK_FILE);

  in.open(book_file, IOS_IN);

  if(!in) {
   in.open(BOOK_FILE, IOS_IN);  // try working directory
  }
  if(!in) return nomove;   // if no book is found

  in.seekg(0,ios::end);
  file_size = in.tellg()/sizeof(book_rec);
  in.seekg(0,ios::beg);

  jump = int(file_size/2);

  while(jump && !in.eof())
  {
    in.seekg(jump*sizeof(book_rec), ios::cur);
    file_pos += jump;
    in.read((char *) &record, sizeof(book_rec));
    in.seekg(-sizeof(book_rec), ios::cur);
    if(record.pos_code == pcode)
      { mflag = 1; jump = 0; break; }
    if(jump == 1) {
      in.seekg(-10*sizeof(book_rec), ios::cur);
      file_pos -= 10;
      for(int i = 0; i < 21; i++) {
        in.read((char *) &record, sizeof(book_rec));
        if(record.pos_code == pcode)
          { mflag = 1; jump = 0; break; }
        file_pos++;
      }
      jump = 0;
    } else {
      jump = int(absl(jump)/2); if(!jump) jump = 1;
      if(record.pos_code > pcode) jump = -jump;
    }
  }

  in.close();

  // if loud book variable is on, list this book position
  if(shout_book) {
    char mstring[10];
    cout << "\nBook moves: ";
    for(j = 0; j < record.mcount; j++) {
          print_move(*p, record.bmoves[j].m, mstring);
          cout << mstring << ":" << record.bmoves[j].score << " ";
          if(j == 5) cout << "\n            ";
    }
    cout << "\n";
  }

  int ran_thresh, count = 0;

  if(mflag) {
    if (record.bmoves[0].score < THRESH) return nomove;
    for(j = 0; j < record.mcount; j++)
     count += record.bmoves[j].score;
    ran_thresh = int(count*ran1(&seed));
    count = 0;
    for(j = 0; j < record.mcount; j++) {
     count += record.bmoves[j].score;
     if(count >= ran_thresh) {
      if(record.bmoves[j].score < THRESH) j = 0;
      for(int z = 0; z < list.count; z++) {
       if(record.bmoves[j].m.t == list.mv[z].m.t)
         { learn_book[learn_count] = record;
           learn_move[learn_count] = j;
           learn_filepos[learn_count] = file_pos;
           learn_count++;
           return list.mv[z].m; }
      }
      return nomove;
     }
    }
  }

  return nomove;
}

void book_learn(int flag)
{

  int gcount = 0, bi = 0, bj;

  // if we are winning add one to the score of each of the book moves played
  if(flag == 1) {
    for(bi = 0; bi < learn_count; bi++) {
       learn_book[bi].bmoves[learn_move[bi]].score += LEARN_FACTOR;
    }
  }

  // If we are losing subtract one from the score of the last move
  // played where we had a choice...
  if(flag == 0) {
    for(bi = learn_count-1; bi >= 0; bi--) {
       gcount = 0;
       for(bj = 0; bj < learn_book[bi].mcount; bj++) {
         if(learn_book[bi].bmoves[bj].score >= THRESH) gcount++;
         if(gcount > 1) {
            learn_book[bi].bmoves[learn_move[bi]].score -= LEARN_FACTOR;
            break;
         }
       }
       if(gcount > 1) break;
     }
   }

  // if we learned this opening as winning, but it goes south on us
  // unlearn it..
  if(flag == -1) {
    for(bi = 0; bi < learn_count; bi++) {
       learn_book[bi].bmoves[learn_move[bi]].score -= LEARN_FACTOR;
    }
  }

  // Now write the changes to the file...
  fstream out(BOOK_FILE, IOS_IN|IOS_OUT);

  if(!out) { cout << "\nError(NoBookUpdate)"; out.close(); return; }

  if(flag == 1 || flag == -1) {
    for(bi = 0; bi < learn_count; bi++) {
       out.seekp(learn_filepos[bi]*sizeof(book_rec), ios::beg);
       Sort(&learn_book[bi].bmoves[0],&learn_book[bi].bmoves[learn_book[bi].mcount-1]);
       out.write((char *) &learn_book[bi], sizeof(book_rec));
    }
   } else if(!flag) {
       out.seekp(learn_filepos[bi]*sizeof(book_rec), ios::beg);
       Sort(&learn_book[bi].bmoves[0],&learn_book[bi].bmoves[learn_book[bi].mcount-1]);
       out.write((char *) &learn_book[bi], sizeof(book_rec));
   }            

   out.seekp(0,ios::end);
   out.close();

}


// random number generator
#define IA 16807
#define IM 2147483647
#define AM (1.0/IM)
#define IQ 127773
#define IR 2836
#define NTAB 32
#define NDIV (1+(IM-1)/NTAB)
#define EPS 1.2e-7
#define RNMX (1.0-EPS)

float ran1(long *idum)
{
   int j;
   long k;
   static long iy=0;
   static long iv[NTAB];
   float temp;

   if (*idum <= 0 || !iy) {
       if (-(*idum) < 1) *idum=1;
       else *idum = -(*idum);
       for (j=NTAB+7; j>=0;j--) {
           k=(*idum)/IQ;
           *idum=IA*(*idum-k*IQ)-IR*k;
           if (*idum < 0) *idum += IM;
           if (j < NTAB) iv[j] = *idum;
       }
       iy=iv[0];
   }
   k=(*idum)/IQ;
   *idum=IA*(*idum-k*IQ)-IR*k;
   if (*idum < 0) *idum += IM;
   j=iy/NDIV;
   iy =iv[j];
   iv[j] = *idum;
   if ((temp=AM*iy) > RNMX) return RNMX;
   else return temp;
}


/*------------- Insert Sort Routine -----------------*/

void ISort (TT *Lb, TT *Ub) {
   TT V, *I, *J, *Jmin;
   /**********************
   *  Sort Array(Lb..Ub) *
   **********************/
   Jmin = Lb - 1;
   for (I = Lb + 1; I <= Ub; I++) {
       V = *I;
       for ( J = I-1; J != Jmin && CompGT(J->pos_code,V.pos_code); J--)
	   *(J+1) = *J;
       *(J+1) = V;
   }
}





/*------------------- Quick Sort Routine --------------------*/

TT *Partition(TT *Lb, TT *Ub) {
    TT  V, Pivot, *I, *J, *P;

    unsigned int Offset;

    Offset = (Ub - Lb)>>1;
    P = Lb + Offset;
    Pivot = *P;
    *P = *Lb;

    I = Lb + 1;
    J = Ub;
    while (1) {
	while (I < J && CompGT(Pivot.pos_code, I->pos_code)) I++;
	while (J >= I && CompGT(J->pos_code, Pivot.pos_code)) J--;

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

void QuickSort(TT *Lb, TT *Ub) {
    TT *M;

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


