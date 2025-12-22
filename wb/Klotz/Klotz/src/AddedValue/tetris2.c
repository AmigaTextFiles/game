/* cryptic tetris from iocc 89 */
/*   $VER: CrypTetris 0.1 (22.3.98) AMIGA Version EP */
/* compile with:
gcc -noixemul -m68020 -O2 -Wall -fbaserel tetris2.c -s	-o tetris.gcc
vc -sc -sd -O2 -cpu=68020 tetris2.c -Ii: -o tetris.vbcc
dcc -mRR -020 tetris2.c vbcc:libsrc/AmigaLib/RangeRand.c -o tetris.dcc
*/

#include <clib/alib_protos.h>
#include <proto/dos.h>
#include <proto/exec.h>

int h;
void t (int d)
{
  h -= h / 3000;
}
int c, d, l, ll,
w, s, I, K = 0, i = 276, j, k, q[276], Q[276], *n = q, *m, x = 17,
f[] =
{
  7, -13, -12, 1,
  8, -11, -12, -1,
  9 ,-1, 1, 12,
  3, -13, -12, -1,
  12, -1, 11, 1,
  15, -1, 13, 1,
  18, -1, 1, 2,
  0, -12, -1, 11,
  1, -12, 1, 13,
  10, -12, 1, 12,
  11, -12, -1, 1,
  2, -12, -1, 12,
  13, -12, 12, 13,
  14, -11, -1, 1,
  4, -13, -12, 12,
  16, -11, -12, 12,
  17, -13, 1, -1,
  5, -12, 12, 11,
  6, -12, 12, 24
};
int GetC( int l) { char b[10]; return Read(l,b,9)?  *b:-1; }
int AToI(char *b){ long x; return StrToLong(b,&x)? x : 1; }
void u (void)
{
  for (i = 11; ++i < 264;)
    if ((k = q[i]) - Q[i])
      {
	Q[i] = k;
	if (i - ++I || i % 12 < 1)
	  Printf ("\033[%ld;%ldH", (I = i) / 12, i % 12 * 2 + 28),Flush(l);
	Printf ("\033[%ldm  " + (K - k ? 0 : 6), k),Flush(l);
	K = k;
      }
  Q[263] = c = (!~WaitForChar(l,h)) ? GetC (l) : -1;
}
int G (int b)
{
  for (i = 4; i--;)
    if (q[i ? b + n[i] : b])
      return 0;
  return 1;
}
void g (int b)
{
  for (i = 4; i--; q[i ? x + n[i] : x] = b);
}
extern int RangeSeed; /* from amiga.lib */
int main (int C, char**V)
{
  char *a;

  h = 1000000 / (ll =  C > 1 ? AToI (V[1]) : 2);
  for (a = C > 2 ? V[2] : "jkl pq"; i; i--)
    *n++ = i < 25 || i % 12 < 2 ? 7 : 0;
  l=Open("raw://400/400/** Tetris ** Left: j, Turn: k, Right: l, Drop: space",MODE_OLDFILE);
  d=SelectOutput(l);
  RangeSeed=(int)FindTask (NULL);
  PutStr ("\033[H\033[J"),Flush(l);
  for (n = f + RangeRand (7) * 4;; g (7), u (), g (0))
    {
      if (c < 0)
	{
	  if (G (x + 12))
	    x += 12;
	  else
	    {
	      g (7);
	      ++w;
	      for (j = 0; j < 252; j = 12 * (j / 12 + 1))
		for (; q[++j];)
		  if ( j % 12 == 10)
		    {
		      for (; j % 12; q[j--] = 0);
		      u ();
		      for (; --j; q[j + 12] = q[j]);
		      u ();
		    }
	      n = f + RangeRand (7) * 4;
	      if(!G (x = 17))  c = a[5];
	    }
	}
      if (c == a[0])
	{ if(!G(--x))  ++x;}
      else if (c == a[1])
	n = f + 4 ** (m = n), G (x) || (n = m);
      else if (c == a[2])
	{ if(!G(++x)) --x;}
      else if (c == a[3])
	for (; G (x + 12); ++w)
	  x += 12;
      else if (c == a[4] || c == a[5])
	{
	  Printf ("\033[H\033[J\033[0m%ld\n", w),Flush(l);
	  if (c == a[5])
	    break;
	  for (j = 264; j--; Q[j] = 0);
	  while (FGetC (l) - a[4]);
	  PutStr ("\033[H\033[J\033[7m"),Flush(l);
	}
    }
    Close(SelectOutput(d));
    Printf("%4ld on level %1ld\n",w,ll);
}
