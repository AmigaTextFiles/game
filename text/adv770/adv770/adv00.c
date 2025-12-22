/* Copyleft Mike Arnautov, 31 Jul 2005 */
#define l142 "11.87, MLA - 30 Jul 2005"
#include "adv1.h"
#ifdef g003
#undef g003
#endif 
#ifdef v154
#undef v154
#endif 
#ifdef MEMORY
#ifdef q008
#undef q008
#endif
#endif 
#ifdef FILE
#undef FILE
#define n142
#ifdef SWAP
#undef SWAP
#endif
#ifdef MEMORY
#undef MEMORY
#endif
#ifdef q008
#undef q008
#endif
#endif 
#ifdef SWAP
#ifdef MEMORY
#undef MEMORY
#endif
#ifdef q008
#undef q008
#endif
#endif 
#ifdef q008
#if q008 == 0
#define v154
#endif
#if q008 == 1
#define MEMORY
#endif
#if q008 == 2
#define SWAP 32
#endif
#if q008 == 3
#define n142
#endif
#endif 
#ifdef SWAP
#if SWAP < 16
#undef SWAP
#define SWAP 16
#endif 
#if SWAP > 128
#undef SWAP
#define SWAP 128
#endif 
#endif 
#ifndef v154
#define g003
#endif
#include <stdio.h>
#include <time.h>
#include <ctype.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#ifdef NEED_UNISTD
#include <unistd.h>
#else
int unlink(char *); 
#endif
#if defined(unix) || defined(__CYGWIN__)
#define s163 '/'
#else
#if defined(MSDOS) || defined(_WIN32)
#define s163 '\\'
#else
#ifdef __50SERIES
#define s163 '>'
#else
#define s163 '?'
#endif
#endif
#endif
#ifdef __50SERIES
extern int time (); 
#define f158 "i"
#define e148 "o"
#define unlink delete
#else 
#ifdef vms
#define unlink delete
#include <time.h>
#else 
#include <sys/types.h>
#include <sys/stat.h>
#endif 
#define f158 "rb"
#define e148 "wb"
#endif 
#ifdef __STDC__
void s164 (char *); void u168 (char *, int); 
#else
void s164(); void u168(); 
#endif
#ifdef READLINE
#include <readline/readline.h>
#include <readline/history.h>
char *j157; char *l143; 
#endif
FILE *q140; FILE *i157; FILE *x163 = NULL; char o124 [32]; 
#ifdef LOG
int y159 = 1; 
#else
int y159 = 0; 
#endif
FILE *c180 = NULL; char *t159 = NULL; char *x164 = NULL; 
#include "adv0.h"
#ifndef g003
#include "adv6.h"
#endif 
#define i158 '\377'
#define x165 '\376'
#define o125 '\375'
#define v155 '\373'
#if j002 >= 10
#define x166 '\372'
#define x167 '\371'
#define t160 '\370'
#define j158 '\367'
#define m145 '\366'
#define w162 '\365'
#define d167 '\364'
#define s165 '\363'
#ifdef y009
#define y160 '\362'
#endif 
#if j002 >= 11
#define s166 '\361'
#endif
#endif 
#ifdef GLK
#define putchar(X) glk_put_char(X)
#else
#ifdef READLINE
#define putchar(X) *j157++=X;if (*(j157-1)=='\n')\
 {*j157='\0';printf(l143);j157=l143;}
#endif
#endif
#define m146(X) putchar(X); if (x163) (void)fputc(X,x163)
#ifdef d167
#define n143(X) if (*X != d167 && *X != v155) { \
if (x163) (void)fputc(*X,x163); \
putchar(*X++);} else X++
#else
#define n143(X) if (*X != v155) { \
if (x163) (void)fputc(*X,x163); \
putchar(*X++);} else X++
#endif 
void j159 (int); int w002; jmp_buf b004; char t161 [128]; 
#ifdef g003
char *t162 = NULL; 
#endif 
char b144 [128]; char o126; 
#define e149 (a004 * sizeof (int))
#define m147 e149
#define e150 ((k004 + 1) * sizeof (int))
#define n144 (m147 + e150)
#define j160 (y007 * (k004 - k003 + 1) * sizeof (short))
#define v156 (n144 + j160)
#define n145 (g004 * (j001 - w003 + 1) * sizeof (short))
#define n146 (v156 + n145)
#define o127 (n004 * (g005 - e006 + 1) * sizeof (short))
#define l144 (n004 * (k005 - e006 + 1) * sizeof (short))
#define y161 (n146 + o127)
char n147 [y161]; int *z002 = (int *)n147; int *e005 = (int *)(n147 + m147);
short *s003 = (short *)(n147 + n144); short *b005 = (short *)(n147 + v156);
short *m003 = (short *)(n147 + n146); 
#ifdef t001
char a144 [sizeof (n147)]; int t163 [e150]; unsigned char *k154 = NULL;
unsigned char *z164 = NULL; unsigned char *n148; int w163 = 0; 
#ifdef l145
int k155 = -2; 
#else
int k155 = 0; 
#endif 
#endif
char a145 [161] = "\n"; char g152 [161] = "\n"; char i159 [161]; char s167
[161]; int t164, y162; int d168; int n149 [5]; int *t165 = &n149[0]; int
*e151 = &n149 [1]; int *c181 = &n149 [2]; int *y163 = &n149 [3]; int *t166
= &n149 [4]; char i160[160]; 
#define n150 20
char c182 [5 * n150]; char *e152 = c182; char *b145 = c182 + n150; char
q141 [n150]; char *v157 = c182 + 2 * n150; char *o128 = c182 + 3 * n150;
char *r159 = c182 + 4 * n150; char i161 [n150]; 
#if j002 >= 11
#define o129 -1
char j161 [n150]; 
#if defined(l001) && defined(r008)
int w164; int r160 [100]; 
#endif 
#endif 
int y164; int s168 = 0; int e153 = 1; 
#ifdef y009
int i162 = 0; 
#endif
#if defined(JUSTIFY) || j002 == 10
int u169 = 1; 
#else
int u169 = 0; 
#endif
#if defined(k156) || j002 == 1
int t167 = 1; 
#else
int t167 = 0; 
#endif
#if defined(PAUSE) || defined(MSDOS) || defined(_WIN32) || defined (GLK)
int n151 = 1; 
#else
int n151 = 0; 
#endif
#ifdef z004
int e154 = 0; char t168 [160]; char *r161 = ".C.adv"; 
#endif
#include "adv3.h"
#include "adv4.h"
#include "adv2.h"
#include "adv5.h"
#ifdef m005
int u170 = 1; 
#endif 
#ifdef MEMORY
char c003 [j000]; 
#endif 
#ifdef SWAP
#define m148 1024
char c003 [SWAP * m148]; int x168 [SWAP]; int z165 [SWAP]; int k157 [SWAP];
#endif 
char *q142 [100]; char j162 [100]; short a146; 
#ifdef GLK
short u171 = 32767; short q143 = 32767; short d169 = 0; 
#else
#if defined(k158) && (k158 > 5 || k158 == 0)
short u171 = k158; 
#else
short u171 = 24; 
#endif
#if defined(k159) && (k159 > 15 || k159 == 0)
short q143 = k159; 
#else
short q143 = 80; 
#endif
#if defined(MARGIN) && MARGIN >= 0
short d169 = MARGIN; 
#else
short d169 = 1; 
#endif
#endif
short t169; int b146; int u172; int j163; 
#ifdef m149
int s169; int a147; 
#endif 
char *m150; int l146 = 4096; 
#if j002 >= 11
short *f159 = NULL; int v158 = 1; 
#endif
char *g153; int q144 = 0; int q145; int u173; char w165 [80]; int j164;
int n152; int t170 = 0; 
#ifdef t160
int w166 = 0; 
#endif 
char *k160; 
#define s170(X) { char *i163 = X; while (*i163) h003(*i163++); }
#define d170(X) printf(X); if (x163) (void)fprintf(x163,X);
#define b147(X,Y) printf(X,Y); if (x163) (void)fprintf(x163,X,Y);
#define i164(X,Y) for (x169=(char *)X,s171=1; \
(unsigned int)s171<=(unsigned int)Y;s171++,x169++) \
{n153+=(*x169+s171)*(((int)(*x169)+s171)<<4)+Y; \
n153&=07777777777L;} 
#ifdef GLK
#include "glk.h"
static winid_t j165 = NULL; 
#ifdef __STDC__
void e155 (char *g154, int m151) 
#else
void e155 (g154, m151) char *g154; int m151; 
#endif
{ int a148 = 0; event_t t171; memset (g154, '\0', m151); glk_request_line_event(j165,
g154, m151, 0); while (!a148) { glk_select(&t171); switch (t171.type) {
case evtype_LineInput: a148 = 1; (void) strcat(g154,"\n"); default: break;
} } } 
#endif
#if !defined(NOVARARGS) && defined(__STDC__)
int m002 (int e004, ...) { va_list a149; int s172; va_start (a149, e004);
s172 = e004; while (s172 >= 0) { if (w005 (s172)) { va_end (a149); return
(1); } s172 = va_arg (a149, int); } va_end (a149); return (0); } int i002
(int e004, ...) { va_list a149; int s172; va_start (a149, e004); s172 =
e004; while (s172 >= 0) { if (!w005 (s172)) { va_end (a149); return (0);
} s172 = va_arg (a149, int); } va_end (a149); return (1); } 
#else 
#ifdef __STDC__
int m002 (int v159,int y001,int b000,int s000,int n000,int m152,int e156,int
c183, int k161,int k162,int t172,int c184,int g155,int r162,int l147,int
w167) 
#else
int m002 (v159,y001,b000,s000,n000,m152,e156,c183,k161,k162,t172,c184,g155,r162,l147,w167)
int v159,y001,b000,s000,n000,m152,e156,c183,k161,k162,t172,c184,g155,r162,l147,w167;
#endif
{ if (v159 == -1) return (0); if (w005 (v159)) return (1); if (y001 == -1)
return (0); if (w005 (y001)) return (1); if (b000 == -1) return (0); if
(w005 (b000)) return (1); if (s000 == -1) return (0); if (w005 (s000)) return
(1); if (n000 == -1) return (0); if (w005 (n000)) return (1); if (m152 ==
-1) return (0); if (w005 (m152)) return (1); if (e156 == -1) return (0);
if (w005 (e156)) return (1); if (c183 == -1) return (0); if (w005 (c183))
return (1); if (k161 == -1) return (0); if (w005 (k161)) return (1); if
(k162 == -1) return (0); if (w005 (k162)) return (1); if (t172 == -1) return
(0); if (w005 (t172)) return (1); if (c184 == -1) return (0); if (w005 (c184))
return (1); if (g155 == -1) return (0); if (w005 (g155)) return (1); if
(r162 == -1) return (0); if (w005 (r162)) return (1); if (l147 == -1) return
(0); if (w005 (l147)) return (1); if (w167 == -1) return (0); if (w005 (w167))
return (1); return (0); } 
#ifdef __STDC__
int i002 (int v159,int y001,int b000,int s000,int n000,int m152,int e156,int
c183, int k161,int k162,int t172,int c184,int g155,int r162,int l147,int
w167) 
#else
int i002 (v159,y001,b000,s000,n000,m152,e156,c183,k161,k162,t172,c184,g155,r162,l147,w167)
int v159,y001,b000,s000,n000,m152,e156,c183,k161,k162,t172,c184,g155,r162,l147,w167;
#endif
{ if (v159 == -1) return (1); if (!w005 (v159)) return (0); if (y001 ==
-1) return (1); if (!w005 (y001)) return (0); if (b000 == -1) return (1);
if (!w005 (b000)) return (0); if (s000 == -1) return (1); if (!w005 (s000))
return (0); if (n000 == -1) return (1); if (!w005 (n000)) return (0); if
(m152 == -1) return (1); if (!w005 (m152)) return (0); if (e156 == -1) return
(1); if (!w005 (e156)) return (0); if (c183 == -1) return (1); if (!w005
(c183)) return (0); if (k161 == -1) return (1); if (!w005 (k161)) return
(0); if (k162 == -1) return (1); if (!w005 (k162)) return (0); if (t172
== -1) return (1); if (!w005 (t172)) return (0); if (c184 == -1) return
(1); if (!w005 (c184)) return (0); if (g155 == -1) return (1); if (!w005
(g155)) return (0); if (r162 == -1) return (1); if (!w005 (r162)) return
(0); if (l147 == -1) return (1); if (!w005 (l147)) return (0); if (w167
== -1) return (1); if (!w005 (w167)) return (0); return (1); } 
#endif 
#ifdef __STDC__
int n002 (int o000) 
#else
int n002 (o000) int o000; 
#endif
{ y164 = (((y164 << 10) + y164) / 13) & 32767; return (y164 % o000); } 
#ifdef __STDC__
int d002 (int o000) 
#else
int d002 (o000) int o000; 
#endif
{ int l148; l148 = (((y164 << 10) + (int) time (NULL)) / 13) & 32767; return
(l148 % o000); } 
#if j002 >= 11
#define j166 -1
#define h159 1
#define d171 1
#define s173 3
#define k163 4
#define h160 4096
#define c185 *((unsigned short *)(j167 + 2))
short *b148 (short *j167) { if (j167 == NULL) { if ((j167 = (short *)malloc(h160
* sizeof(short))) == NULL) return (NULL); *j167 = 3; *(j167 + 1) = 0; c185
= h160; } else { if ((j167 = (short *)realloc (j167, (*(j167 + 2) + h160)
* sizeof(short))) == NULL) return (NULL); c185 += h160; } return (j167);
} 
#ifdef DEBUG
void r163 (short *j167, char *c003) { short *u174; printf ("Show: %s, free: %hd, root: %hd\n",
c003, *j167, *(j167 + 1)); u174 = j167 + 3; while (u174 < j167 + *j167)
{ fprintf (stderr, "Offset %d: Up %hd, L %hd, R %hd, B %hd, T: %s\n", u174
- j167, *(u174 + h159), *(u174 + h159 + j166), *(u174 + h159 + d171), *(u174
+ s173), (char *)(u174 + k163)); u174 += k163 + 1 + strlen ((char *) (u174
+ k163)) / 2; } } 
#endif 
void h161 (char *z166, int g156, short *i165) { char *x169 = (char *) (i165
+ k163); while (g156--) *x169++ = tolower (*z166++); *x169 = '\0'; } int
s174 (char *q002, char *g157) { int a150, q146; while (*q002) { q146 = tolower
((unsigned char) *q002++); if (!isalpha (q146)) return (*g157 ? -1 : 0);
a150 = (unsigned char) *g157++; if (q146 != a150) return (q146 > a150 ?
1 : -1); } return (0); } void w168 (short *j167, int g158, int s175, int
i166) { int t173 = *(j167 + g158 + h159); int m153 = *(j167 + s175 + h159
- i166); *(j167 + g158 + h159 + i166) = *(j167 + s175 + h159 - i166); *(j167
+ s175 + h159 - i166) = g158; *(j167 + g158 + s173) -= *(j167 + s175 + s173);
*(j167 + s175 + s173) = -(*(j167 + g158 + s173)); if (t173 > 0) *(j167 +
t173 + h159 + (*(j167 + t173 + h159 + j166) == g158 ? j166 : d171)) = s175;
else *(j167 + 1) = s175; *(j167 + s175 + h159) = t173; *(j167 + g158 + h159)
= s175; if (m153) *(j167 + m153 + h159) = g158; } void k164 (short *j167,
int g158, int s175, int i166) { int t173 = *(j167 + g158 + h159); int m153
= *(j167 + s175 + h159 - i166); *(j167 + s175 + h159 - i166) = *(j167 +
m153 + h159 + i166); if (*(j167 + m153 + h159 + i166)) *(j167 + *(j167 +
m153 + h159 + i166) + h159) = s175; *(j167 + g158 + h159 + i166) = *(j167
+ m153 + h159 - i166); if (*(j167 + m153 + h159 - i166)) *(j167 + *(j167
+ m153 + h159 - i166) + h159) = g158; *(j167 + m153 + h159 + i166) = s175;
*(j167 + m153 + h159 - i166) = g158; if (*(j167 + m153 + s173) == *(j167
+ s175 + s173)) *(j167 + s175 + s173) *= -1; else *(j167 + s175 + s173)
= 0; if (*(j167 + m153 + s173) == *(j167 + g158 + s173)) *(j167 + g158 +
s173) *= -1; else *(j167 + g158 + s173) = 0; *(j167 + m153 + s173) = 0;
*(j167 + s175 + h159) = m153; *(j167 + g158 + h159) = m153; *(j167 + m153
+ h159) = t173; if (t173 > 0) *(j167 + t173 + h159 + (*(j167 + t173 + h159
+ j166) == g158 ? j166 : d171)) = m153; else *(j167 + 1) = m153; } short
*c186 (short *j167, char *q002, int g156) { int g158 = 0; int s175 = *(j167
+ 1); int i166; short *i165; int e157 = k163 + 1 + g156 / 2; if (*(j167
+ 1) > 0) { while (s175 > 0) { if ((i166 = s174 (q002, (char *)(j167 + s175
+ k163))) == 0) return (j167); g158 = s175; s175 = *(j167 + s175 + h159
+ i166); } } if (*j167 + e157 > c185 && (c185 > 65535L - e157 || (j167 =
b148 (j167)) == NULL)) return (NULL); i165 = j167 + (s175 = *j167); *(i165
+ h159) = g158; *(i165 + h159 + j166) = *(i165 + h159 + d171) = 0; *(i165
+ s173) = 0; h161 (q002, g156, i165); *j167 += e157; if (g158) { *(j167
+ g158 + h159 + i166) = s175; while (1) { i166 = *(j167 + g158 + h159 +
j166) == s175 ? j166 : d171; if (*(j167 + g158 + s173) == i166) { if (*(j167
+ s175 + s173) == -i166) k164 (j167, g158, s175, i166); else w168 (j167,
g158, s175, i166); break; } if ((*(j167 + g158 + s173) += i166) == 0) break;
s175 = g158; g158 = *(j167 + g158 + h159); if (g158 == 0) break; } } else
*(j167 + 1) = s175; return (j167); } int z167 (short *j167, char *q002)
{ int y165; int i166; if ((y165 = *(j167 + 1)) == 0) return (0); while (y165)
{ if ((i166 = s174 (q002, (char *)(j167 + y165 + k163))) == 0) return (y165);
y165 = *(j167 + y165 + h159 + i166); } return (0); } 
#ifdef __STDC__
void s176 (void) 
#else
void s176 () 
#endif
{ char *i167 = m150; char *h162; while (1) { while (*i167 && ! isalpha (*i167))
i167++; if (*i167 == '\0') break; h162 = i167 + 1; while (*h162 && isalpha
(*h162)) h162++; if (h162 - i167 > 4 && *(h162 - 3) != 'i' && *(h162 - 2)
!= 'n' && *(h162 - 1) != 'g') c186 (f159, i167, h162 - i167); if (*h162
== '\0') break; i167 = h162 + 1; } return; } 
#endif 
#define w169 100
#if defined(PLAIN) && (defined(MEMORY) || defined(v154))
#define d172(X) c003[X]
#else 
#ifdef __STDC__
char d172 (int u175) 
#else
char d172 (u175) int u175; 
#endif
{ 
#ifndef PLAIN
int f160; 
#endif 
#if defined(MEMORY) || defined (v154)
f160 = (u175 >> 4) & 127; if (f160 == 0) f160 = u175 & 127; if (f160 ==
0) f160 = 'X'; f160 = (17 * f160 + 13) & 127; return (f160 ^ c003 [u175]
^ w165 [u175 % j164]); 
#endif 
#ifdef SWAP
int f161; char *e158; int i168; int y166; void y167 (); i168 = 0; e158 =
c003; for (f161 = 0; f161 < SWAP; f161++) { if (u175 >= x168 [f161] && u175
< z165 [f161]) goto q147; e158 += m148; } for (f161 = 0; f161 < SWAP; f161++)
{ if (z165 [f161] == 0) goto a151; if (k157 [i168] > k157 [f161]) i168 =
f161; } f161 = i168; a151: u172++; e158 = c003 + m148 * f161; y166 = (u175
/ m148) * m148 ; if (fseek (q140, y166, 0)) y167 (); x168 [f161] = y166;
z165 [f161] = fread (e158, sizeof (char), m148, q140) + y166; 
#ifdef m149
(void) printf ("Wanted %ld.  Buffer %d: from %ldK.\n", u175, f161, y166
/ m148); 
#endif 
if (x168 [f161] > z165 [f161]) y167 (); q147: k157 [f161] = j163; 
#ifdef PLAIN
return (*(e158 + u175 - x168 [f161])); 
#else 
f160 = (u175 >> 4) & 127; if (f160 == 0) f160 = u175 & 127; if (f160 ==
0) f160 = 'X'; f160 = (17 * f160 + 13) & 127; return (*(e158 + u175 - x168
[f161]) ^ f160 ^ w165 [u175 % j164]); 
#endif 
#endif 
#ifdef n142
void y167 (); static int e159 = -1; char y168; if (e159 != u175) { u172++;
if (fseek (q140, u175, 0)) y167 (); e159 = u175; } y168 = fgetc (q140);
e159++; 
#ifdef PLAIN
return (y168); 
#else 
f160 = (u175 >> 4) & 127; if (f160 == 0) f160 = u175 & 127; if (f160 ==
0) f160 = 'X'; f160 = (17 * f160 + 13) & 127; return (y168 ^ f160 ^ w165
[u175 % j164]); 
#endif 
#endif 
} 
#if defined(SWAP) || defined(n142)
#ifdef __STDC__
void y167 (void) 
#else
void y167 () 
#endif
{ s170 ("\n \nUnable to retrieve required data! Sorry...\n"); j159 (1);
(void) fclose (q140); if (x163) (void) fclose (x163); exit (0); } 
#endif 
#endif 
#ifdef __STDC__
void n003 (int q002, int y000, int g002, int u176) 
#else
void n003 (q002, y000, g002, u176) int q002; int y000; int g002; int u176;
#endif
{ int f161; int n154; static int b149 = 0; if (q002 == 0) { b149 = 0; return;
} if (y000 == 0) y000 = q002; if (g002 >0 && h002 (y000, g002) == 0) return;
if (b149++ > 0) { h003 (','); h003 (' '); } f161 = (u176 == 0) ? q002 :
u176; b146 = m144 [f161]; n154 = d172 (b146); if (n154 == '!') n154 = d172
(++b146); while (n154 != '\0') { h003 (n154); n154 = d172 (++b146); } }
#ifdef __STDC__
int j168 (int j169) 
#else
int j168 (j169) int j169; 
#endif
{ 
#ifdef GLK
return (0); 
#else 
static int j170 = 0; char c187 [160]; int s177; 
#ifdef z004
if (e154) return (0); 
#endif
if (j169 || t159) j170 = 0; else if (++j170 >= u171) { s177 = d169; while
(s177--) putchar (' '); d170 ("[More?] "); fgets (c187, sizeof (c187) -
1, c180 ? c180 : stdin); if (x163) fprintf (x163, "\nREPLY: %s", c187);
j170 = 1; if (*c187 == 'n' || *c187 == 'N' || *c187 == 'q' || *c187 == 'Q')
{ g153 = m150; strcpy (m150,"OK.\n"); if (!t167) strcat (m150, "\n"); strcat
(m150, "? "); return (1); } } return (0); 
#endif 
} 
#ifdef d167
#ifdef __STDC__
char *d173 ( char type, char* o130) 
#else
char *d173 (type, o130) char type; char *o130; 
#endif
{ int c188 = 0; int f162 = 1000; int v160; int b150; int g156; int d174;
char *i167 = o130; 
#ifdef z004
if (e154) { printf ("<center>"); if (type == w162) printf ("<table><tr><td>");
putchar ('\n'); } 
#endif
while (*i167 && *i167 != d167) { b150 = 0; while (*i167 == ' ' || *i167
== '\t') { b150++; i167++; } d174 = g156 = b150; while (*i167 && *i167 !=
'\n' && *i167 != d167) { g156++; if (*i167 != ' ' && *i167 != '\t') d174
= g156; i167++; } if (b150 < g156) { if (b150 < f162) f162 = b150; if (d174
> c188) c188 = d174; } if (*i167 == d167) break; i167++; } c188 -= f162;
v160 = -f162; if (c188 < q143) v160 += (q143 - c188 + 1) / 2; if (u169 ==
0 && v160 > 1) v160 = (9 * v160) / 10; 
#ifdef GLK
glk_set_style (style_Preformatted); v160 = 0; 
#endif
while (*o130 && *o130 != d167) { j168 (0); 
#ifdef GLK
o130 += f162; 
#endif
if (v160 < 0) o130 += v160; else if (v160 > 0) { for (g156 = 0; g156 < v160;
g156++) { m146 (' '); } } while (*o130 && *o130 != '\n' && *o130 != d167)
{ n143 (o130); } if (*o130 == '\n') { 
#ifdef z004
if (e154) { if (type == w162) printf ("<block>"); else printf ("<br>");
} 
#endif
n143 (o130); } 
#if defined(z004)
if (e154 && *o130 == d167) printf ("<br>"); 
#endif
} 
#ifdef z004
if (e154) { if (type == w162) printf ("</td></tr></table>"); printf ("</center>\n");
} 
#endif
#ifdef GLK
glk_set_style (style_Normal); 
#endif
if (*o130) o130++; return (o130); } 
#endif 
#ifdef __STDC__
void j159 (int n155) 
#else
void j159 (n155) int n155; 
#endif
{ int m154; int a001; char *o130 = m150; char l149 = '\0'; int l150 = 0;
int q148 = 0; int h163 = 0; char t174 = '\0'; char b002; int x170; t170
= 0; x170 = 1; g153--; while (*g153 == ' ' || *g153 == '\n') { if (*g153
== '\n') x170 = 0; g153--; q144--; } 
#ifdef d167
if (*g153 == d167 && *(g153 - 1) == '\n') x170 = -1; 
#endif 
g153++; if (x170 <= 0) { if (! n155) { 
#if j002 > 1
if (!t167 && x170 == 0) { s170 ("\n "); } 
#endif 
s170 ("\n? ") } } else { *g153++ = ' '; q144++; } *g153 = '\0'; if (*o130
== '\n') { while (*o130 == '\n') o130++; if (!t167) o130--; } g153 = o130;
m154 = 0; a001 = -1; 
#if j002 >= 11
if (z002 [q004] < f001 && z002 [x002] < f001) s176 (); 
#endif 
while ((b002 = *o130++)) { if (b002 == v155) { h163 = 1; q148++; continue;
} if (b002 == '\n' && h163) { *(o130 - 1) = v155; h163 = 0; q148++; continue;
} if (b002 == ' ' && l150 && q148 == 0) { l150 = 0; while ((b002 = *o130++)
== ' '); g153 = --o130; t174 = ' '; } else q148++; 
#ifdef w162
if (b002 == w162 || b002 == s165) { g153 = o130 = d173 (b002, o130); if
((b002 = *o130++) == '\0') break; q148 = 0; } 
#endif 
if (b002 == '\n') { if (*o130 == '\n' && *(o130 + 1) == '\n') continue;
if (q148 > 0) { g153 = b003 (g153, q148, 0, 0); q148 = 0; o130 = g153; }
else if (!l150) { m146 ('\n'); g153 = o130; } m154 = 0; a001 = -1; t174
= ' '; q148 = 0; l150 = 0; 
#ifdef z004
if (e154) printf ("<br>"); 
#endif
continue; } l150 = 0; if (b002 == ' ' || b002 == '-') { if (t174 != b002)
{ m154 = q148 - (b002 == ' ' ? 1 : 0); a001++; } if (q148 >= t169) { while
(*o130 == ' ') o130++; g153 = b003 (g153, m154, a001, 1); m154 = 0; a001
= -1; m146 ('\n'); q148 = 0; o130 = g153; l150 = 1; t174 = ' '; continue;
} t174 = b002; continue; } if (q148 >= t169) { if (a001 < 0) { g153 = b003
(g153, t169, 0, 0); } else { g153 = b003 (g153, m154, a001, 1); m146 ('\n');
l150 = 1; } l149 = '\0'; m154 = 0; a001 = -1; q148 = 0; o130 = g153; } else
t174 = b002; } if (q148 > 0) (void) b003 (g153, q148, 0, 0); g153 = m150;
*g153++ = '\n'; *g153 = '\0'; q144 = 1; fflush (stdout); } 
#define l151 128
#define b151 64
#if defined(f000) || j002 >= 11
#define w170 32
#endif
#ifdef x004
#define j171 16
#else
#define j171 0
#endif
#define r164 8
#define w171 4
#define o131 2
#define s178 1
#ifdef x166
#ifdef __STDC__
void q149 (int h004, int m000, int r000) 
#else
void q149 (h004, m000, r000) int h004; int m000; int r000; 
#endif
{ int c189; int type; if (m000 &= 14) m000 = 8; type = d172 (h004++); c189
= d172 (h004++) << 8; c189 |= (d172 (h004) & 255); if (type == 0) { c189
+= k003; m000 = l151; } else if (type == 1) { c189 += w003; m000 = l151;
} else if (type == 2) c189 += e006; else if (type == 3) { c189 += n005;
m000 = o131 | l151; r000 = 0; } else c189 += a003; if (type < 2) r000 =
0; q000 (m000, c189, r000); b146 = h004; } 
#endif 
#ifdef __STDC__
void q000 (int m000, int y000, int r000) 
#else
void q000 (m000, y000, r000) int m000; int y000; int r000; 
#endif
{ int f161; int v161; int c190; int l152; int e160; int e161; int f163;
int h164 = 0; int v162; 
#ifdef x004
int j172; 
#endif 
#if defined(f000) || j002 >= 11
int o132; 
#endif 
int t175; int l153; int t176; int i169; int a152 = m000; char g159 [n150];
int w172; int q150; char *n156; char n154; char o133 = 0; if (g153 == NULL)
g153 = m150; j163++; f163 = m000 & b151; 
#if defined(f000) || j002 >= 11
o132 = m000 & w170; 
#endif
#ifdef x004
j172 = m000 & j171; 
#endif
l152 = m000 & r164; e161 = m000 & w171; e160 = m000 & o131; c190 = m000
& s178; v162 = m000 & l151; 
#ifdef m155
#ifdef x004
if (h002 (d005, g007)) j172 = 0; else if (h002 (d005, x004) || (h002 (d005,
g007) == 0 && h002 (d005, q007) == 0)) j172 = 1; else if (h002 (d005, q007))
j172 = h002 (z002 [b006], q006) ? 0 : 1; 
#endif 
#endif 
if (e160) y000 = z002 [y000]; i169 = r000; if (e161 && ((r000 != q004 &&
r000 != x002 && r000 != u002) || c190)) r000 = z002 [r000]; if (y000 > j001
|| v162) { if (v162 && (y000 == q004 || y000 == x002)) { if (y000 == q004)
n156 = e152; else if (y000 == x002) n156 = b145; else n156 = q141; while
(*n156 != '\0') h003 (*n156++); return; } b146 = m144 [y000]; } else if
(y000 >= w003) { 
#if defined(g007) && defined(x004) && defined(q006)
if (h002 (d005, g007) || (! h002 (d005, x004) && h002 (y000, q006))) b146
= u167 [y000]; else 
#endif
b146 = d166 [y000]; } else if (y000 >= k003) { 
#if defined(f000)
if (o132 || h002 (d005, f000)) b146 = b143 [y000]; else 
#endif
if (e005 [y000] == a005) { h164 = 1; b146 = u167 [y000]; } else b146 = d166
[y000]; } if ((n154 = d172 (b146)) == '\0') goto c191; 
#define q151 1
#define k165 2
#define l154 3
#define i170 4
#define g160 5
if (y000 >= a003) { int a153 = 2 * (y000 - a003); l153 = r000; if (b142
[a153] == q151) { l153 = b142 [a153 + 1]; if (l153 <= 1) l153 = 0; else
l153 = n002 (l153); } else if (b142 [a153] == k165) { l153 = z002 [y000];
if (z002 [y000] < b142 [a153 + 1] - 1) z002[y000]++; } else if (b142 [a153]
== l154) { l153 = z002 [y000]; if (z002 [y000] < b142 [a153 + 1] - 1) z002[y000]++;
else z002 [y000] = 0; } else if (b142 [a153] == i170) l153 = z002 [y000];
else if (b142 [a153] == g160) l153 = z002 [z002 [y000]]; else if (r000 ==
x002 && z002 [x002] < f001) l153 = z002 [z002 [r000]]; } if (!l152) r000
= (y000 <= j001) ? z002 [y000] : y000; while (n154 != '\0') { o133 = n154;
#ifdef x166
if (n154 == x166) { q149 (b146 + 1, a152, r000); n154 = d172 (++b146); continue;
} 
#endif 
#ifdef y009
if (n154 == y160) { i162 ^= 1; goto c192; } 
#endif 
if (n154 == i158) { t175 = d172 (++b146); q150 = b146 + 2 * t175 -1; t176
= (y000 >= a003) ? l153 : r000; 
#if j002 == 1
if (h164) t176 = (t176 == 1 || t175 == 1) ? 0 : 1; if (t176 <= 0 || (t176
== 1 && y000 >= a003)) 
#else 
if (t176 <= 0) 
#endif 
b146 = q150 + 1; else { b146 = b146 - 1 + 2 * 
#if j002 == 1
((t176 > t175) ? t175 - 1 : t176 - 1); if (y000 < a003) b146 += 2; 
#else 
((t176 >= t175) ? t175 - 1 : t176); 
#endif 
v161 = d172 (b146 + 1); if (v161 < 0) v161 += 256; b146 = q150 + 256 * d172
(b146) + v161 + 1; } v161 = d172 (q150 + 1); if (v161 < 0) v161 += 256;
q150 = q150 + 256 * d172 (q150) + v161 + 1; n154 = d172 (b146); } else if
(n154 == x165) { n154 = d172 (b146 = q150++); if (n154 == x165) goto c192;
} 
#if j002 >= 11
else if (n154 == o125 || n154 == s166) { if (v158) v158 = 2; if (c190 ||
n154 == s166) 
#else
else if (n154 == o125) { if (c190) 
#endif
{ (void) sprintf (g159, "%d", r000); n156 = g159 - 1; while (*(++n156) !=
'\0') h003 (*n156); goto c192; } 
#if j002 >= 11
else if (r000 == q004 || r000 == x002 || r000 == u002) { if (r000 == q004)
n156 = e152; else if (r000 == x002) n156 = b145; else n156 = q141; while
(*n156 != '\0') h003 (*n156++); goto c192; } else if (r000 == o129) { n156
= j161; while (*n156 != '\0') h003 (*n156++); goto c192; } 
#else 
else if (r000 == q004 || r000 == x002) { n156 = (r000 == q004 ? e152 : b145);
while (*n156 != '\0') h003 (*n156++); goto c192; } 
#endif 
else { f161 = (e161 && i169 <= j001) ? i169 : r000; w172 = b146; j163++;
b146 = m144 [f161]; n154 = d172 (b146); if (n154 == '!') n154 = d172 (++b146);
while (n154 != '\0') { h003 (n154); n154 = d172 (++b146); } b146 = w172;
} } else h003 (n154); c192: n154 = d172 (++b146); } c191: if (f163) longjmp
(b004, 1); return; } 
#ifdef __STDC__
void h003 (int b002) 
#else
void h003 (b002) int b002; 
#endif
{ 
#ifdef t160
if (w166) { if (b002 == j158) w166 = 0; return; } if (b002 == t160) { w166
= 1; return; } 
#endif 
if (b002 == '\n') { t170++; if (t170 > 2) return; } 
#ifdef d167
else if (b002 && b002 != d167 && t170) 
#else
else if (b002 && t170) 
#endif 
t170 = 0; 
#ifdef m145
if (b002 == m145) b002 = ' '; 
#endif 
#if j002 >= 11
if (isalpha (b002)) { if (v158 == 2) b002 = toupper (b002); v158 = 0; }
else if (isdigit (b002)) v158 = 0; else if (strchr (".!?", b002)) v158 =
1; 
#endif 
if (q144 == l146 - 3) { l146 += 1024; if ((m150 = (char *) realloc (m150,
l146)) == NULL) { puts ("*** Unable to extend text buffer! ***"); exit (0);
} g153 = m150 + q144; } 
#ifdef z004
if (e154 && (b002 == '<' || b002 == '>')) { *g153++ = '&'; *g153++ = (b002
== '<') ? 'l' : 'g'; *g153++ = 't'; *g153 = ';'; q144 += 4; } else { q144++;
*g153 = b002; } 
#else
q144++; *g153 = b002; 
#endif 
#ifdef y009
if (z002 [y009] || i162) s164 (g153); 
#endif 
g153++; return; } 
#ifdef t001
#ifdef __STDC__
void z168 (void) 
#else
void z168 (); 
#endif
{ char *u174; char *e162; unsigned int s171; int x171 = 0; if (z002 [q004]
>= f001 || z002 [x002] >= f001 || 
#ifdef z004
z002 [z004] > 1 || e154 == 'y' || 
#endif
z002 [q004] == t001 || z002 [q004] == i004) return; if (z164 > n148) z164
= n148; if (k154 == NULL) { if ((k154 = (unsigned char *)malloc(8192)) ==
NULL) { printf ("GLITCH: Unable to allocate diffs array!\n"); return; }
else { w163 = 8192; memset (k154, '\0', 4); n148 = z164 = k154 + 4; } }
else { for (s171 = 0, e162 = a144, u174 = n147; s171 < sizeof (n147); s171++,
e162++, u174++) { if (*e162 != *u174 && ! ((s171 >= q004*sizeof(int) &&
s171 < (q004 + 1)*sizeof(int)) || (s171 >= x002*sizeof(int) && s171 < (x002
+ 1)*sizeof(int)) || (s171 >= d005*sizeof(int) && s171 < (d005 + 1)*sizeof(int))))
{ if (z164 - k154 + 8 >= w163) { int b152 = z164 - k154; if ((k154 = (unsigned
char *)realloc(k154, w163 + 8192)) == NULL) { printf ("GLITCH: Unable to re-allocate diffs array!\n");
return; } w163 += 8192; z164 = k154 + b152; } if (s171 || e154 == 0) { *z164++
= s171 / 256; *z164++ = s171 % 256; *z164++ = *e162; *z164++ = *u174; x171
= 1; } } } if (x171) { for (s171 = 0; s171 < 4; s171++) *z164++ = '\0';
n148 = z164; } } memcpy (a144, n147, sizeof (n147)); } 
#endif 
#ifdef __STDC__
void s179 (char *c193, int h165) 
#else
void s179 (c193, h165) char *c193; int h165; 
#endif
{ 
#ifdef READLINE
char *x172; 
#endif
char *x169; char j173 [170]; *c193 = '\0'; 
#ifdef y009
i162 = 0; 
#endif 
if (q144) j159 (0); j168 (1); 
#if j002 >= 11
v158 = 1; 
#endif 
#ifdef t001
if (z002 [t002] >= 0) z168 (); else if (k154 && z164 > k154) n148 = z164
= k154; 
#endif 
#ifdef z004
if (e154 == 'x' || e154 == 'z') { d000 (998, &z002 [0]); if (f159) free
(f159); exit (z002 [z004]); } if (e154 == 'y') { strncpy (c193, t168, h165
- 1); e154 = 'z'; } else 
#endif 
if (c180) { while (1) { if (fgets (j173, h165, c180) == NULL || strncmp
(j173, "INTERACT", 8) == 0) { fclose (c180); c180 = NULL; 
#ifdef READLINE
x172 = readline (l143); memcpy (c193, x172, h165); add_history (x172); free
(x172); *(c193 + h165 - 1) = 0; 
#else 
#ifdef GLK
e155 (c193, h165); 
#else
fgets (c193, h165, stdin); 
#endif
#endif 
break; } if (strncmp (j173, "REPLY: ", 7) == 0) { strncpy (c193, j173 +
7, h165); printf (c193); x169 = c193 + strlen (c193) - 2; if (*c193 != '\n'
&& *x169 == '\r') { *x169++ = '\n'; *x169 = '\0'; } break; } } } else if
(c180 == NULL) 
#ifdef READLINE
{ x172 = readline (l143); memcpy (c193, x172, h165); add_history (x172);
free (x172); *(c193 + h165 - 1) = 0; } 
#else 
#ifdef GLK
e155 (c193, h165 - 1); 
#else
fgets (c193, h165, stdin); 
#endif
#endif 
#ifdef z004
if (e154 == 'x') e154 = 'z'; 
#endif
*(c193 + h165 - 1) = '\0'; *(c193 + h165 - 2) = '\n'; x169 = c193; while
(*x169) { if (strchr ("\"\'", *x169)) *x169 = ' '; x169++; } if (x163) fprintf
(x163,"\nREPLY: %s\n", c193); } 
#ifdef __STDC__
char *b003 (char *i167, int r001, int a001, int i001) 
#else
char *b003 (i167, r001, a001, i001) char *i167; int a001; int r001; int
i001; 
#endif
{ int f161; int c194; int h166; int s177; int m154; char t174; static int
b153 = 1; if (q144 - (g153 - m150) >= t169 && j168 (0) != 0) return g153;
if ((s177 = d169)) while (s177--) m146 (' '); if (a001 <= 0 || i001 == 0
|| r001 == t169) while (r001-- > 0) { n143 (i167); } else { s177 = t169
- r001; h166 = (s177 - b153) / a001 + b153; c194 = 1 - 2 * b153; m154 =
s177 % a001; if (!b153) m154 = a001 - m154; b153 = 1 - b153; t174 = '\0';
while (r001-- > 0) { if (u169 && t174 == ' ' && *i167 != ' ') { f161 = h166;
while (f161-- > 0) { m146 (' '); } if (--m154 ==0) h166 = h166 + c194; }
t174 = *i167; n143 (i167); } } 
#ifdef READLINE
*j157 = '\0'; if (*i167) printf (l143); j157 = l143; 
#endif
fflush (stdout); return (i167); } 
#ifdef __STDC__
void x173 (char *v163, int u177) 
#else
void x173 (v163, u177) char *v163; int u177; 
#endif
{ int f164; if (d172 (u177) == '!') u177++; for (f164 = 1; f164 <= 20; f164++)
if ((*v163++ = d172 (u177++)) == '\0') return; } 
#ifdef __STDC__
void w006 (int v164, int c189) 
#else
void w006 (v164, c189) int v164; int c189; 
#endif
{ int q002; for (q002 = 0; q002 < x001; q002++) { if (t005 [q002] == c189)
{ (void) x173 (v164 == 1 ? e152 : b145, f002 [q002]); return; } } strcpy
(v164 == 1 ? e152 : b145, "*GLITCH*"); return; } 
#ifdef __STDC__
void v003 (int m000, int c002, int type) 
#else
void v003 (m000, c002, type) int m000; int c002; int type; 
#endif
{ int f161; int c195; int e004; if (m000 == 0 && z002 [d005] != 1) return;
c195 = -1; 
#ifdef l001
e004 = (m000 == 2) ? w002 + 1 : k003; if (e004 > k004) goto b154; for (f161
= e004; f161 <= k004; f161++) { 
#if j002 >= 11
if (w164 > 0) { int i, j; j = 0; for (i = 0; i < w164; i++) if (f161 ==
r160 [i]) { r160 [i] = r160 [w164 - 1]; w164--; j = 1; break; } if (j) continue;
} 
#endif 
#else 
for (f161 = k003; f161 <= k004; f161++) { 
#endif 
#ifdef q005
if ((e005 [f161] == c002 || (c002 != a005 && h002 (f161, q005) && e005 [f161]
+ 1 == c002)) && 
#else
if (e005 [f161] == c002 && 
#endif
(type < 0 || h002 (f161, type))) { if (c195 >= 0) return; c195 = f161; if
(m000) break; } } if (c195 >= 0) { z002 [x002] = c195; (void) x173 (b145,
m144 [c195]); 
#ifdef y009
if (z002 [y009] || i162) { char *m156 = b145; while (*m156) s164 (m156++);
} 
#endif 
b145 [19] = '\0'; z002 [d005] = 2; 
#ifdef c006
z002 [c006] = c195; 
#endif
#ifdef l001
if (m000 > 0) w002 = c195; if (m000 == 1) { q145 = c002; u173 = type; }
#endif 
return; } 
#ifdef l001
b154: if (m000 > 0) w002 = 0; 
#endif 
return; } 
#if j002 >= 11
#ifdef y008
#ifdef __STDC__
void s180 (int q152, int z169) 
#else
void s180 (q152, z169) int q152; int z169; 
#endif
{ char u178; (void) strncpy (j161, q142 [a146], n150); 
#ifdef y009
if (z002 [y009]) u168 (j161, n150); 
#endif
q000 (r164, y008, o129); x173 (j161, q152); u178 = *(j161 + z169); *(j161
+ z169) = '\0'; q000 (r164, y008, o129); *(j161 + z169) = u178; if ((unsigned
int)z169 >= strlen (j161)) z002 [y008]++; else q000 (r164, y008, o129);
q000 (0, y008, 0); *j161 = '\0'; s170("\n\n"); } 
#endif
#ifdef __STDC__
void h167 (int *type, int *c189, int *k166, int v164, int i171) 
#else
void h167 (type, c189, k166, v164, i171) int *type; int *c189; int *k166;
int v164; int i171; 
#endif
#else
#ifdef __STDC__
void h167 (int *type, int *c189, int *k166, int v164) 
#else
void h167 (type, c189, k166, v164) int *type; int *c189; int *k166; int
v164; 
#endif
#endif
{ int t177, t178, k167; int v165; 
#if j002 > 1
int u179; int q153; 
#endif 
#if j002 >= 11
int q152; int z169; 
#endif
int v166; int x174; char *m156; int h168; char x175 [n150]; strcpy (x175,
q142 [a146]); 
#ifdef y009
if (z002 [y009]) u168 (x175, n150); 
#endif 
if (*x175 == '\0') { *type = i003; goto e163; } t177 = -1; k167 = x001 +
1; while (k167 > t177 + 1) { j163++; t178 = (t177 + k167) / 2; if (d172
(x174 = j003 [t178]) == '!') x174++; m156 = x175; while (d172 (x174) ==
*m156) if (*m156 != '\0') { m156++; x174++; } else break; if (d172 (x174)
< *m156 && *m156 != '\0') t177 = t178; else k167 = t178; } *c189 = f001;
t177++; k167 = x001; v165 = f001; while (t177 < k167) { m156 = x175; if
(d172 (x174 = j003 [t177]) == '!') { x174++; v166 = 1; } else v166 = 0;
h168 = x174; while (*m156 == d172 (h168)) { if (*m156 == '\0') break; else
{ h168++; m156++; } } if (*m156 != '\0') break; 
#if j002 > 1
if (!v166 || (v166 && d172 (h168) == '\0')) 
#else
if (d172 (h168) == '\0' || h168 - x174 >= 5) 
#endif
{ *type = d007 [t177]; *c189 = t005 [t177]; *k166 = f002 [t177]; if (d172
(h168) == '\0') 
#if j002 == 1
{ if (h168 - x174 <= 2) { m156 = x175; while (++t177 < k167) if (*c189 ==
t005 [t177] && *m156 == d172 (j003 [t177])) *k166 = f002 [t177]; } goto
e163; } 
#else 
goto e163; if (v165 != f001 && *c189 != v165) 
#if j002 >= 11
{ 
#define h169(X) (v164 == 1 ? X > k004 : (X <= k004 && \
(e005 [X] == a005 || e005 [X] == z002 [b006])))
int i172 = h169 (v165); int j174 = h169 (*c189); if ((j174 && i172) || (!j174
&& !i172)) { *c189 = v005; goto e163; } if (!j174 && i172) { *c189 = v165;
*k166 = q153; *type = u179; t177++; continue; } if (j174 && !i172) { v165
= *c189; if (d172 (x174) == '\0') break; } } 
#endif 
q153 = *k166; u179 = *type; 
#endif 
v165 = *c189; if (d172 (x174) == '\0') break; } t177++; } 
#if j002 >= 11
if (*c189 == f001 && e153 > 0) { char *r165 = NULL; int j175 = 0; v165 =
-1; for (t177 = 0; t177 < x001; t177++) { if (d172 (x174 = j003 [t177])
== '!') continue; m156 = x175; while (*m156 == d172 (x174)) { m156++; x174++;
} if (*m156 == '\0' && d172 (x174 + 1) == 0 && d007 [t177] != i003) { if
(v165 >= 0 && t005 [v165] != t005 [t177]) {v165 = w004; break;} v165 = t177;
q152 = j003 [t177]; z169 = x174 - q152; continue; } r165 = m156; j175 =
x174; if (*m156 == d172 (x174 + 1) && *(m156 + 1) == d172 (x174)) { x174
+= 2; m156 += 2; while (*m156 && *m156 == d172 (x174)) {m156++; x174++;}
if (*m156 == '\0' && d172 (x174) == '\0' && d007 [t177] != i003) { if (v165
>= 0 && t005 [v165] != t005 [t177]) {v165 = w004; break;} v165 = t177; q152
= j003 [t177]; z169 = x174 - q152; continue; } m156 = r165; x174 = j175;
} if (*(m156 + 1) == d172 (x174 + 1)) { m156++; x174++; while (*m156 &&
*m156 == d172 (x174)) {m156++; x174++;} if (*m156 == '\0' && d172 (x174)
== '\0' && d007 [t177] != i003) { if (v165 >= 0 && t005 [v165] != t005 [t177])
{v165 = w004; break;} v165 = t177; q152 = j003 [t177]; z169 = x174 - q152;
continue; } m156 = r165; x174 = j175; } if (*m156 == d172 (x174 + 1)) {
x174++; while (*m156 && *m156 == d172 (x174)) {m156++; x174++;} if (*m156
== '\0' && d172 (x174) == '\0' && d007 [t177] != i003) { if (v165 >= 0 &&
t005 [v165] != t005 [t177]) {v165 = w004; break;} v165 = t177; q152 = j003
[t177]; z169 = x174 - q152; continue; } m156 = r165; x174 = j175; } if (*(m156
+ 1) == d172 (x174) || *(m156 + 1) == '\0') { m156++; while (*m156 && *m156
== d172 (x174)) {m156++; x174++;} if (*m156 == '\0' && d172 (x174) == '\0'
&& d007 [t177] != i003) { if (v165 >= 0 && t005 [v165] != t005 [t177]) {v165
= w004; break;} v165 = t177; q152 = j003 [t177]; z169 = x174 - q152; continue;
} } } if (v165 == w004) *c189 = w004; else if (v165 >= 0) { 
#ifdef y008
*type = d007 [v165]; *c189 = t005 [v165]; *k166 = f002 [v165]; if (i171)
s180 (q152, z169); 
#else
*c189 = f001; 
#endif
} } 
#endif 
e163: 
#if j002 >= 11
if (v164 > 1 && (*c189 == f001 || *c189 == w004) && z167 (f159, q142 [a146]))
z002 [x002] = c008; 
#endif 
if (v164 == 1) m156 = e152; else if (v164 == 2) m156 = b145; else m156 =
q141; if (*c189 >= f001) { (void) strncpy (m156, q142 [a146], n150); if
(v164 <= 2 && strlen (q142 [a146]) > 16) (void) strcpy (s167, q142[a146]);
} else { (void) x173 (m156, *k166); 
#ifdef y009
if (z002 [y009] || i162) { char *n156 = m156; while (*n156) s164 (n156++);
} 
#endif 
} if (*c189 >= f001 && e153 != -1) q142 [a146 + 1] = NULL; 
#if defined(a007) && defined(d006) 
else if ((*c189 > a007 && *c189 < d006) && j162 [a146 + 1] == ' ') j162
[a146 + 1] = ';'; 
#endif
return; } 
#ifdef __STDC__
void g161 (void) 
#else
void g161 () 
#endif
{ 
#ifndef n157
char *x169, *g153; char f165; for (x169 = a145; *x169; x169++) *x169 = tolower
(*x169); x169 = g153 = a145; while (*x169 == ' ' || *x169 == ',' || *x169
== ';' || (*x169 == '.' && *(x169 + 1) != '.' && *(x169 + 1) != '/' && *(x169
+ 1) != '\\')) x169++; while (*x169) { if (*x169 == '.' && (*(x169 + 1)
== '.' || *(x169 + 1) == '/' || *(x169 + 1) == '\\')) { *g153++ = *x169++;
continue; } while (*x169 && *x169 != ' ' && *x169 != ',' && *x169 != ';'
&& *x169 != '.' && *x169 != '\n') *g153++ = *x169++; f165 = ' '; while (*x169
== ' ' || *x169 == ',' || *x169 == ';' || *x169 == '\n' || (*x169 == '.'
&& *(x169 + 1) != '.' && *(x169 + 1) != '/' && *(x169 + 1) != '\\')) { if
(*x169 == '.') *x169 = ';'; if (f165 == ' ' || *x169 == '\n') f165 = *x169;
else if ((f165 == ' ' || f165 == ',') && (*x169 == ';' || *x169 == '\n'))
f165 = *x169; x169++; } if (*x169) *g153++ = f165; } if (f165 != '\n') *g153++
= '\n'; *g153++ = '\0'; *g153 = '\0'; 
#ifdef m157
printf ("+++ Comline: %s", a145); 
#endif
a146 = 0; x169 = a145; while (*x169) { if (*x169 == '\n') break; q142 [a146]
= x169; while (*x169 && *x169 != ' ' && *x169 != ',' && *x169 != ';' &&
*x169 != '\n') x169++; j162 [a146 + 1] = *x169; *x169++ = '\0'; if (strcmp
(q142 [a146], r004) == 0) j162 [a146] = ','; else if (strcmp (q142 [a146],
d003) == 0) j162 [a146] = ';'; else a146++; } q142 [a146] = NULL; j162 [a146]
= '\n'; 
#else
char *k160 = a145; char *k168 = NULL; int a146 = 0; int f165; int j176;
int e004; e004 = (d168 == 0); while (*k160) { q142 [a146] = NULL; f165 =
0; while (1) { j176 = 0; switch (*k160) { case ' ': if (f165 == 0) f165
= ' '; break; case ',': if (f165 == 0 || f165 == ' ') f165 = ','; break;
case ';': case '.': if (f165 != ';') f165 = ';'; break; case '\n': case
0: j176 = -1; f165 = '\n'; break; default: j176 = 1; break; } if (j176)
{ if (k168) *k168 = '\0'; break; } k160++; } if (a146 > 0) { if (strcmp
(q142 [a146 - 1], r004) == 0) { a146--; if (f165 == ' ') f165 = ','; } else
if (strcmp(q142 [a146 - 1], d003) == 0) { a146--; if (f165 == ' ' || f165
== ',') f165 = ';'; } } if (a146) { if (e004 && f165 == ',') f165 = ';';
e004 = (f165 == ';'); j162 [a146] = f165; } if (j162 [a146] == ' ' && j162
[a146 - 1] == ',') j162 [a146 - 1] = ';'; if (j176 < 0) break; q142 [a146]
= k160; while (*k160 && ! strchr (" ,.;\n", *k160)) k160++; f165 = 0; k168
= k160; if (strcmp (q142 [a146], r004) == 0) { if (a146 >= 0 && j162 [a146
- 1] == ' ') j162 [a146 - 1] = ','; } else if (strcmp (q142 [a146], d003)
== 0) { if (a146 >= 0 && j162 [a146 - 1] == ' ') j162 [a146 - 1] = ';';
} else a146++; } q142 [a146] = NULL; 
#endif
#if defined(n157) || defined(m157)
{ int n = 0; while (1) { printf ("+++ %d: %s (%c)\n", n, q142 [n], j162
[n]); if (q142 [n] == NULL) break; n++; } } 
#endif
return; } 
#ifdef __STDC__
void s002 (int v000) 
#else
void s002 (v000) int v000; 
#endif
{ int type; int c189; int k166; int q154; if (z002[d005] == -1 && z002 [u002]
== -1) { printf ("\nSorry... This game does not support command line restore.\n\n");
exit (1); } if (z002 [d005] < 90 || z002 [d005] >= a004) e153 = 1; else
if (z002 [d005] == 99) e153 = 0; else e153 = -1; 
#if j002 >= 11
#ifdef l001
if (w002 == 0) w164 = 0; 
#endif
*j161 = '\0'; 
#endif
*y004 (q004) = -1; *y004 (x002) = -1; 
#ifdef l001
if (w002) { v003 (2, q145, u173); if (j162 [a146] == ',') t164 = z002 [q004];
if (w002) return; } else { t164 = z002 [q004]; y162 = z002 [x002]; } 
#else 
t164 = z002 [q004]; y162 = z002 [x002]; 
#endif 
#ifdef l002
if (h002 ((d005), (l002))) { d168 = t164; (void) strncpy (v157, e152, 20);
} else d168 = 0; h001 ('c', (d005), (l002)); 
#endif 
q154 = (a146 != 0 && q142 [a146] && j162 [a146] == ','); if (j162 [a146]
== ';') { z002 [q004] = -1; z002 [x002] = -1; h003 ('\n'); } x176: if (q142
[a146] == NULL) { if (i159 [0] != '\0' && i159 [0] != '\n') (void) strncpy
(g152, i159, 160); a145 [0] = '\0'; while (a145 [0] == '\0' || a145 [0]
== '\n') { 
#ifdef m005
u170 = 1; 
#endif 
#ifdef m149
(void) printf ("\n(Locates: demanded %ld (+%ld), faults %ld (+%ld))", j163,
j163 - a147, u172, u172 - s169); a147 = j163; s169 = u172; 
#endif 
(void) j168 (1); if (v000) (void) q000 (0, v000, 0); if (! g153) g153 =
m150; s179 (a145, 160); 
#ifdef vms
(void) putchar ('\n'); 
#endif 
(void) strncpy (i159, a145, 160); 
#ifdef z004
if (z002 [z004] && (*a145 == '\n' || *a145 == '\0')) { z002 [d005] = 0;
z002 [q004] = -1; z002 [x002] = -1; return; } 
#endif 
} (void) j168 (1); e164: g161 (); a146 = 0; z002 [q004] = -1; z002 [x002]
= -1; z002 [d005] = 0; } if (q142[a146] == NULL) goto x176; i173: 
#if j002 >= 11
*j161 = '\0'; h167 (&type, &c189, &k166, j162 [a146] == ',' ? 2 : 1, 1);
#else
h167 (&type, &c189, &k166, j162 [a146] == ',' ? 2 : 1); 
#endif
a146++; if (type == i003) { if (q142 [a146] == NULL) goto x176; if (j162
[a146] == ' ' || j162 [a146] == ',') goto i173; } 
#ifdef m005
#if j002 >= 11
if (c189 == m005 && ! ((j162 [a146] == ' ' || j162 [a146] == ',') && q142[a146-1][0]
== 'r' && q142[a146-1][1] == '\0')) { if (j162 [a146] == ' ' || j162 [a146]
== ',') { z002 [q004] = -m005; goto y169; } else 
#else
if (c189 == m005) { 
#endif 
if (u170) { if (*g152 == '\n') goto x176; (void) strncpy (a145, g152, 160);
(void) strncpy (i159, g152, 160); goto e164; } else { a146--; while (j162
[++a146] == ' '); z002 [q004] = t164; z002 [x002] = y162; return; } } 
#endif 
#ifdef l002
if ((h002 (d005, l002) && c189 <= j001) || q154) { z002 [q004] = t164; z002
[x002] = c189; z002 [d005] = 2; goto a154; } 
#endif 
z002 [q004] = c189; z002 [d005] = 1; y169: if (j162 [a146] == ' ' && q142
[a146]) { 
#if defined(h005) && defined(z005)
int s181 = e153; if (e153 == 1) e153 = (z002 [q004] < h005 || z002 [q004]
> z005); 
#endif
#if defined(c007) && defined (t004)
if (z002 [q004] > c007 && z002 [q004] < t004) { j162 [a146] = ';'; goto
a154; } 
#endif
#if j002 >= 11
#ifdef x003
if (z002 [q004] == x003) { int i = a146; strcpy (i160, q142 [i]); while
(q142 [i] && (j162[i + 1] == ' ' || j162[i + 1] == ',')) { strcat (i160,
" "); strcat (i160, q142 [i + 1]); if (j162 [i + 1] == ' ') j162 [i + 1]
= ','; i++; } } 
#endif 
*j161 = '\0'; h167 (&type, &c189, &k166, 2, 1); 
#else
h167 (&type, &c189, &k166, 2); 
#endif
#if defined(h005) && defined(z005)
e153 = s181; 
#endif
a146++; if (type == i003) goto y169; z002 [x002] = c189; z002 [d005] = 2;
} a154: 
#ifdef m005
u170 = 0; 
#endif 
if (z002 [d005] == 1 && d168) { if ((d168 > k004 && z002 [q004] < k004)
|| (d168 < k004 && z002 [q004] > k004)) { z002 [d005] = 2; z002 [x002] =
d168; (void) strncpy (b145, v157, 20); } d168 = 0; } if ( z002 [q004] ==
f001 || z002 [x002] == f001 
#if j002 > 1
|| z002 [q004] == v005 || z002 [x002] == v005 
#endif
#if j002 >= 11
|| z002 [q004] == w004 || z002 [x002] == w004 
#endif
) q142 [a146] = NULL; 
#if j002 < 11
else if (z002 [d005] == 2 && (h002 (z002 [x002], e007)) && !(h002 (z002
[q004], e007))) 
#else 
else if (z002 [d005] == 2 && z002 [x002] != c008 && (h002 (z002 [x002],
e007)) && !(h002 (z002 [q004], e007))) 
#endif 
{ int k169; k169 = z002 [q004]; z002 [q004] = z002 [x002]; z002 [x002] =
k169; (void) strncpy (i161, e152, 20); (void) strncpy (e152, b145, 20);
(void) strncpy (b145, i161, 20); } e152 [19] = '\0'; b145 [19] = '\0'; 
#ifdef y160
if (z002[y009]) { u168 (e152, n150); u168 (b145, n150); } 
#endif
if (j162 [a146] == ' ') { 
#if j002 >= 11 && defined(l001) && defined (r008)
if (q142 [a146]) { h167 (&type, &c189, &k166, 3, 0); if (c189 == r008) {
a146++; while (c189 < f001 && (j162 [a146] == ' ' || j162 [a146] == ','))
{ if (strcmp (q142 [a146], r004) != 0) { h167 (&type, &c189, &k166, 3, 1);
if (c189 >= f001) break; else if (c189 > k004) { c189 = n006; break; } else
{ (void) x173 (q141, k166); r160 [w164++] = c189; } } a146++; } z002 [u002]
= -1; if (c189 >= f001) return; } } 
#endif 
if (q142 [a146] && strcmp (q142 [a146], r004) == 0 && j162 [a146] == ' ')
j162 [++a146] = ','; else if (j162[a146] != ';') { 
#if j002 >= 11
if (z002 [d005] > 1 && (j162 [a146] == ' ' || j162 [a146] == ',')) z002
[d005] = n006; if (q142 [a146]) while (j162 [++a146] == ' '); } } 
#ifdef m005
if (z002 [q004] == -m005 && z002 [d005] > 1) { z002 [q004] = m005; z002
[d005] = n006; } 
#endif 
if (z002 [d005] == n006 || z002 [q004] > d005 || z002 [x002] > d005) q142
[a146 + 1] = NULL; 
#else 
while (j162 [++a146] == ' '); } } 
#endif 
if (z002 [d005] == 1) z002 [x002] = -1; 
#if j002 >= 11
else if (z002 [d005] == n006) { z002 [x002] = -1; } 
#endif
return; } 
#ifdef __STDC__
int w000 (int v000) 
#else
int w000 (v000) int v000; 
#endif
{ char c187 [10]; char *i174; int m158 = 0; if (v000 >= 0) q000 (0, v000,
0); else (void) j168 (1); e165: s179 (c187, 10); (void) j168 (1); 
#ifdef y009
if (z002 [y009]) u168 (c187, 10); 
#endif 
i174 = c187; if (*i174 == '\0' || *i174 == '\n') return (1); while (*i174
== ' ') i174++; if (*i174 == 'y' || *i174 == 'Y') return (1); if (*i174
== 'n' || *i174 == 'N') return (0); if (*i174 == 'q' || *i174 == 'Q') return
(0); if (m158) { s170 ("(OK, smartass... I'll assume you mean YES - so there!)\n \n");
return (1); } s170 ("Eh? Do me a favour and answer yes or no!\nWhich will it be? ");
m158 = 1; goto e165; } 
#ifdef __STDC__
void u180 (char *k170, char *a155) 
#else
void u180 (k170, a155) char *k170; char *a155; 
#endif
{ char *x169; (void) strcpy (a155, k170); x169 = a155; while (*x169) { if
(*x169 == '\n') { *x169 = '\0'; break; } 
#if defined (MSDOS) || defined (vms) || defined (_WIN32)
if (*x169 == '.') *x169 = '-'; 
#endif 
x169++; } 
#ifdef MSDOS
*(a155 + 8) = '\0'; 
#else 
#if !defined(unix) && ! defined(__CYGWIN__)
*(a155 + 16) = '\0'; 
#endif
#endif 
if (strcmp (a155 + strlen (a155) - 4, ".adv") != 0) (void) strcat (a155,
".adv"); return; } 
#ifdef __STDC__
int l155 (FILE *f166) 
#else
int l155 (f166) FILE *f166; 
#endif
{ int y170 = 0; int t179 = 0; int e166 = 0; int e167 = 0; char *c196 = v004;
char o134 = fgetc (f166); while (1) { if (*c196 == '\0' && o134 == '\n')
return (0); if (! isalnum (o134) && ! isalnum(*c196)) break; if (o134 !=
*c196) return (1); c196++; o134 = fgetc (f166); } while (*c196 && ! isdigit
(*c196)) c196++; while (o134 != '\n' && ! isdigit (o134)) o134 = fgetc (f166);
if (o134 == '\n' && *c196 == '\0') return (0); while (isdigit (*c196) ||
*c196 == '.') { if (*c196 == '.') { y170 = t179; t179 = 0; } else t179 =
10 * t179 + *c196 - '0'; c196++; } while (isdigit (o134) || o134 == '.')
{ if (o134 == '.') { e166 = e167; e167 = 0; } else e167 = 10 * e167 + o134
- '0'; o134 = fgetc (f166); } if (y170 != e166) return (1); if (t179 < e167)
return (1); while (o134 != '\n') o134 = fgetc (f166); return (0); } 
#ifdef __STDC__
void n158 (void) 
#else
void n158 () 
#endif
{ if (c180) fclose (c180); if (x163) { int s171; fprintf (x163, "\nINTERACT\n");
for (s171 = 0; s171 < 39; s171++) fprintf (x163, "*-"); fprintf (x163, "*\n");
fclose (x163); } 
#if j002 >= 11
if (f159) free (f159); 
#endif
} 
#ifdef __STDC__
int a002 (int m000) 
#else
int a002 (m000) int m000; 
#endif
{ FILE *t180 = NULL; static char *z170 = NULL; static char *v167 = NULL;
char *i175; 
#ifdef z004
char *g162 = (char *)(m000 < 2 ? ".M.adv" : ".T.adv"); 
#endif
int j177 = 1; if (m000 < 0) { 
#ifdef z004
if (e154) { if ((t180 = fopen (g162, f158)) != NULL) { fclose (t180); j177
= 0; } return (j177); } 
#endif
return (z170 ? 0 : 1); } i175 = m000 < 2 ? z170 : v167; if (m000 == 0 ||
m000 == 2) { if (i175 == NULL) { i175 = (char *) malloc (y161); if (i175
== NULL) return (1); if (m000 == 0) z170 = i175; else v167 = i175; } memcpy
(i175, n147, y161); 
#ifdef z004
if (e154) { if ((t180 = fopen (g162, e148)) != NULL && fwrite (z170, 1,
y161, t180) == y161) j177 = 0; if (t180) fclose (t180); return (j177); }
#endif
return (0); } else { 
#ifdef z004
if (e154) { if ((i175 = (char *) malloc (y161)) != NULL && (t180 = fopen
(g162, f158)) != NULL && (fread (i175, 1, y161, t180)) == y161) j177 = 0;
if (t180) fclose (t180); if (j177) return (1); } else if (i175 == NULL)
return (1); 
#else
if (i175 == NULL) return (1); 
#endif 
memcpy (n147, i175, y161); return (0); } } 
#if j002 >= 11
#include <dirent.h>
#ifdef __STDC__
int t181 (int t182, char *z171) 
#else
int t181 (t182, z171) int t182; char *z171; 
#endif
{ int s171 = 0; char g154[16]; DIR *q155; struct dirent *z172; char *j178;
#ifdef z004
if (e154) return (-1); 
#endif
*(g154 + 15) = '\0'; if ((q155 = opendir("."))) { while ((z172 = readdir
(q155))) { if (*(z172->d_name) != '.' && strcmp (j178 = z172->d_name + strlen(z172->d_name)
- 4, ".adv") == 0) { *j178 = '\0'; if (t182) { if (s171) s170 (", ") s170
(z172 -> d_name); } else if (z171) strncpy (g154, z172 -> d_name, 15); s171++;
} } closedir (q155); if (t182) s170 (".\n") if (z171 && s171 == 1) { z002
[x002] = 0; strcpy (z171, g154); } } return (s171); } 
#endif
#ifdef __STDC__
int d000 (int m000, int *m001) 
#else
int d000 (m000, m001) int m000; int *m001; 
#endif
{ static char a155 [168]; static char *o135; char *i175; char k170 [168];
FILE *z173; int s172, c197; int z174; char k171 [12]; static int o136 =
sizeof (time_t); int n153; int f167; char *x169; int s171; int g163, z175,
i176, s182, g164; static int i177; static long k172; void k173 (); void
m159 (); switch (m000) { case 1: case 2: s172 = z002 [x002]; 
#ifndef z004
e165: 
#endif
if (s172 >= 0) { if (*s167 && strncmp (s167, b145, 16) == 0) (void) strcpy
(k170, s167); else (void) strcpy (k170, b145); } else 
#ifdef z004
{ printf ("*** Glitch! No save/restore name specified!\n"); *m001 = 3; return
(0); } case 999: case 997: if (m000 > 2) { strncpy (b145, r161, n150 - 1);
(void) u180 (r161, a155); } else (void) u180 (k170, a155); 
#else
{ if (m000 == 1) { s170 ("\nName to save game under: "); } else { 
#if j002 >= 11
int s171 = t181 (0, k170); if (s171 == 0) s170 ( "Can't see any saved games here, but you may know of some elsewhere.\n")
else if (s171 == 1) { goto q156; } else { s170 ("You have the following saved games: ")
(void) t181 (1, NULL); } 
#endif
s170 ("\nName of saved game to restore: "); } s179 (k170, 16); j168(1);
#ifdef y009
if (z002 [y009]) u168 (k170, 16); 
#endif 
if (k170 [0] == '\0' || k170 [0] == '\n') { s170 ("\nChanged your mind, eh?  Fine by me...\n");
*m001 = 3; return (0); } } 
#if j002 >= 11
q156: 
#endif
(void) u180 (k170, a155); 
#endif 
if ((z173 = fopen (a155, f158)) != NULL) { if (m000 == 2 || m000 == 999
|| m000 == 997) goto a156; (void) fclose (z173); s170 ("\nThere's already a game dumped under that name.\n");
#ifdef z004
*m001 = 2; return (0); 
#else
s170 ("Do you really mean to overwrite it? "); if (!w000 (-1)) { s172 =
-1; goto e165; } s170 ("\nAs you wish...\n"); 
#endif 
} if (m000 == 2) { *m001 = 1; return (0); } 
#ifdef z004
case 998: if (m000 == 998) { u180 (r161, a155); if (z002 [z004] == 0) z002
[z004] = 1; *t166 = z002 [z004]; } else { if (m000 != 1) return (0); } 
#endif 
if ((z173 = fopen (a155, e148)) == NULL) { 
#ifdef z004
if (m000 != 998) *m001 = 1; 
#endif 
return (1); } (void) time ((time_t *) &k171[0]); (void) fprintf (z173, "%s\n",
v004); s172 = k003; (void) fwrite (&s172, sizeof (int), 1, z173); s172 =
k004; (void) fwrite (&s172, sizeof (int), 1, z173); s172 = j001; (void)
fwrite (&s172, sizeof (int), 1, z173); s172 = k005; (void) fwrite (&s172,
sizeof (int), 1, z173); s172 = g005; (void) fwrite (&s172, sizeof (int),
1, z173); s172 = a004; (void) fwrite (&s172, sizeof (int), 1, z173); *z002
= -1; n153 = 0; i164(k171, sizeof(time_t)) i164(n147, e149) i164(n147 +
m147, e150) i164(n147 + n144, j160) i164(n147 + v156, n145) i164(n147 +
n146, o127) 
#ifdef z004
if (e154 && m000 == 998) { i164(c182, sizeof(c182)); i164(n149, sizeof(n149));
} 
#endif 
(void) fwrite (&n153, sizeof (int), 1, z173); (void) fwrite (k171, 1, sizeof(time_t),
z173); (void) fwrite (n147, 1, y161, z173); 
#ifdef z004
if (e154 && m000 == 998) { (void) fwrite (c182, sizeof (char), sizeof (c182),
z173); (void) fwrite (n149, sizeof (char), sizeof (n149), z173); (void)
fwrite (&s168, sizeof (int), 1, z173); (void) fwrite (f159, sizeof (short),
*f159 - 1, z173); (void) fwrite (g152, sizeof (char), sizeof (g152), z173);
(void) fwrite (s167, sizeof (char), sizeof (s167), z173); } 
#endif 
*m001 = (ferror (z173)) ? 1 : 0; (void) fclose (z173); 
#ifdef t001
if (z002 [t002] >= 0 && k154 && (k154 < z164 || e154)) { strcpy (a155 +
strlen(a155) - 3, "adh"); if (((k154 && z164 > k154 + 4) || (e154 && z002
[z004] <= 1)) && (z173 = fopen (a155, e148))) { int g156 = z164 - k154;
fwrite (&g156, 1, sizeof (int), z173); fwrite (k154, 1, z164 - k154, z173);
i164(k154, g156); fwrite (&n153, 1, sizeof (n153), z173); g156 = n148 -
k154; fwrite (&g156, 1, sizeof (int), z173); fclose (z173); } } 
#endif 
return (*m001); a156: 
#ifdef z004
if (e154 == 'x') { fprintf (x163, "\nREPLY: restore %s\n", a155); *e151
= 2; *y163 = z002 [x002]; strncpy (r159, b145, 20); } 
#endif
if (l155 (z173) != 0) { *m001 = 4; return (0); } c197 = 0; (void) fread
(&s172, sizeof (int), 1, z173); 
#ifdef DEBUG
printf ("FOBJECT: image %3d, expected %3d\n", s172, k003); 
#endif 
if (s172 != k003) c197++; (void) fread (&g163, sizeof (int), 1, z173); 
#ifdef DEBUG
printf ("LOBJECT: image %3d, expected %3d\n", g163, k004); 
#endif 
if (g163 > k004) c197++; (void) fread (&z175, sizeof (int), 1, z173); 
#ifdef DEBUG
printf ("LPLACE: image %3d, expected %3d\n", z175, j001); 
#endif 
if (z175 > j001) c197++; (void) fread (&i176, sizeof (int), 1, z173); 
#ifdef DEBUG
printf ("LVERB: image %3d, expected %3d\n", i176, k005); 
#endif 
if (i176 > k005) c197++; (void) fread (&s182, sizeof (int), 1, z173); 
#ifdef DEBUG
printf ("LVARIABLE: image %3d, expected %3d\n", s182, g005); 
#endif 
if (s182 > g005) c197++; (void) fread (&g164, sizeof (int), 1, z173); 
#ifdef DEBUG
printf ("LTEXT: image %3d, expected %3d\n", g164, a004); 
#endif 
if (g164 > a004) c197++; if (c197) { *m001 = 2; (void) fclose (z173); return
(0); } f167 = 0; 
#ifdef z004
if (e154 != 'z' && e154 != 'y' && e154 != 'x') { *m001 = a002 (2); if (*m001
!= 0) return (0); } 
#endif
if (o135 == NULL) { o135 = (char *) malloc (y161); if (o135 == NULL) return
(0); } i175 = o135; 
#ifdef DEBUG
puts ("Reading image..."); 
#endif
(void) fread (&f167, sizeof (int), 1, z173); 
#ifdef DEBUG
b147("CHKSAV %d\n", f167) 
#endif
(void) fread (k171, 1, sizeof (k171), z173); if (*((int *)(k171 + 4)) ==
-1) o136 = 4; else if (*((int *)(k171 + 8)) == -1) o136 = 8; else o136 =
sizeof(time_t); fseek (z173, o136 - 12L, SEEK_CUR); { int b155 = g164 *
sizeof (int); int k174 = (g163 + 1) * sizeof (int); int b156 = b155 + k174;
int w173 = y007 * (g163 - k003 + 1) * sizeof (short); int u181 = b156 +
w173; int j179 = g004 * (z175 - g163) * sizeof (short); int h170 = u181
+ j179; int m160 = n004 * (s182 - z175) * sizeof (short); int c198 = h170
+ m160; (void) fread (o135, 1, c198, z173); } 
#ifdef z004
if (e154 && m000 == 999) { (void) fread (c182, sizeof (char), sizeof (c182),
z173); (void) fread (n149, sizeof (char), sizeof (n149), z173); (void) fread
(&s168, sizeof (int), 1, z173); if (! ferror (z173)) { (void) fread (f159,
sizeof (short), 2, z173); if (ferror (z173)) { *f159 = 3; *(f159 + 1) =
0; } else (void) fread (f159 + 2, sizeof (short), *f159 - 3, z173); } if
(! ferror (z173)) { (void) fread (g152, sizeof (char), sizeof (g152), z173);
} *s167 = '\0'; if (! ferror (z173)) { (void) fread (s167, sizeof (char),
sizeof (s167), z173); } clearerr (z173); } 
#endif 
if (ferror (z173)) { *m001 = 2; return (0); } 
#ifdef DEBUG
puts ("Checking image..."); 
#endif
(void) fclose (z173); n153 = 0; { int b155 = g164 * sizeof (int); int k174
= (g163 + 1) * sizeof (int); int b156 = b155 + k174; int w173 = y007 * (g163
- k003 + 1) * sizeof (short); int u181 = b156 + w173; int j179 = g004 *
(z175 - g163) * sizeof (short); int h170 = u181 + j179; int m160 = n004
* (s182 - z175) * sizeof (short); int i178 = n004 * (i176 - z175) * sizeof
(short); i164(k171, o136); i164(o135, b155) i164(o135 + b155, k174) i164(o135
+ b156, w173) i164(o135 + u181, j179) i164(o135 + h170, m160) if (s172 <
a004) while (s172 < a004) *(z002 + (s172++)) = 0; 
#ifdef z004
if (e154 && m000 == 999) { i164(c182, sizeof(c182)); i164(n149, sizeof(n149));
} 
#endif 
if (f167 != n153) { *m001 = 2; return (0); } if (o136 == sizeof(k172)) memcpy
(&k172, k171, o136); else k172 = 1; memset (n147, '\0', y161); memcpy (z002,
o135, (g163 + 1) * sizeof (int)); memcpy (z002 + w003, o135 + (g163 + 1)
* sizeof (int), (z175 - g163) * sizeof (int)); memcpy (z002 + e006, o135
+ (z175 + 1) * sizeof (int), (i176 - z175) * sizeof (int)); memcpy (z002
+ n005, o135 + (i176 + 1) * sizeof (int), (s182 - i176 - 1) * sizeof (int));
memcpy (z002 + a003, o135 + s182 * sizeof (int), (g164 - s182) * sizeof
(int)); memcpy (e005, o135 + b155, k174); memcpy (s003, o135 + b156, w173);
memcpy (b005, o135 + u181, j179); memcpy (m003, o135 + h170, i178); memcpy
((char *)m003 + l144, o135 + h170 + i178, m160 - i178); } 
#ifdef z004
if (m000 == 997) z002 [z004] = 2; 
#endif
#ifdef t001
if (z002 [t002] >= 0) { strcpy (a155 + strlen(a155) - 3, "adh"); if ((z173
= fopen (a155, f158))) { int g156; int f168 = g156; unsigned char *d; if
(k154) n148 = z164 = k154 + 4; fread (&g156, 1, sizeof (int), z173); if
(g156 > 0) { f168 = 8192 * ((g156 + 8191) / 8192); d = (unsigned char *)malloc(f168);
(void) fread (d, 1, g156, z173); fread (&f167, 1, sizeof (f167), z173);
i164(d, g156); if (n153 == f167) { if (k154) free (k154); k154 = d; w163
= f168; z164 = k154 + g156; memcpy (a144, n147, sizeof(n147)); fread (&g156,
1, sizeof (int), z173); n148 = k154 + g156; } } fclose (z173); } } 
#endif 
*m001 = 0; return (0); case 3: 
#ifdef z004
(void) u180 (b145, a155); 
#endif 
*m001 = unlink (a155); if (*m001) { printf ("Failed: %s - error code: %d<br />\n",
a155, *m001); system ("pwd"); } strcpy (a155 + strlen(a155) - 3, "adh");
(void) unlink (a155); return (0); case 4: case 5: *m001 = 0; return (0);
case 6: i177 = *m001; return (0); case 7: *m001 = i177; return (0); case
8: (void) time ((time_t *) &z174); *m001 = 1 + (z174 - k172) / 60; return
(0); case 9: 
#if j002 < 10
*m001 = 0; 
#else
z002 [q004] = *m001; w006 (1, *m001); 
#endif
return (0); case 10: z002 [x002] = *m001; w006 (2, *m001); return (0); case
11: z002 [x002] = z002 [q004]; strncpy (b145, e152, 20); z002 [d005] = 2;
return (0); case 12: *m001 = (q142[a146] == NULL); return (0); case 14:
if ((*m001 = (i157 = fopen ("adv.vrg", f158)) ? 0 : 1) == 0) fclose (i157);
return (0); case 15: if ((i157 = fopen ("adv.vrg", e148))) fclose (i157);
return (0); case 19: s172 = *m001; u169 = s172 < 2 ? s172 : 1 - u169; *m001
= u169; return (0); case 20: s172 = atoi (b145); *m001 = 0; if (s172 ==
0) return (0); if (s172 < 16) s172 = 16; if (s172 > 1024) s172 = 1024; *m001
= s172; q143 = s172; if (q143 - 2 * d169 < 16) d169 = (q143 - 16) / 2; if
(d169 < 0) d169 = 0; t169 = q143 - 2 * d169; 
#ifdef READLINE
s171 = j157 - l143; l143 = (char *)realloc(l143, 2 * t169 + 1); j157 = l143
+ s171; 
#endif
return (0); case 21: s172 = atoi (b145); *m001 = 0; if (s172 <0) s172 =
0; if (s172 > 9) s172 = 9; if (q143 - s172 - s172 < 16) s172 = (q143 - 16)
/ 2; if (s172 < 0) s172 = 0; *m001 = s172; d169 = s172; t169 = q143 - s172
- s172; 
#ifdef READLINE
s171 = j157 - l143; l143 = (char *)realloc(l143, 2 * t169 + 1); j157 = l143
+ s171; 
#endif
return (0); case 22: s172 = atoi (b145); if (s172 < 4) { *m001 = 0; return
(0); } if (s172 > 1024) s172 = 1024; *m001 = s172; u171 = s172; return (0);
case 23: *t165 = *m001; *e151 = z002 [d005]; *c181 = z002 [q004]; strncpy
(o128, e152, 20); if (*e151 == 2) { *y163 = z002 [x002]; strncpy (r159,
b145, 20); } else { *y163 = -1; *r159 = '\0'; } return (0); case 24: *m001
= *t165; z002 [d005] = *e151; z002 [q004] = *c181; z002 [x002] = *y163;
strncpy (e152, o128, 20); strncpy (b145, r159, 20); return (0); case 27:
*m001 = 1; if (*i160) { s170("\nOk - \"") s170(i160) s170("\"\n") *i160
= '\0'; } return (0); case 28: *m001 = a002 (3); return (0); case 29: *m001
= 0; if (z002 [d005] > 1) { s172 = z002 [q004]; z002 [q004] = z002 [x002];
z002 [x002] = s172; for (s171 = 0; s171 < n004; s171++) { s172 = m003 [q004
- e006 + s171]; m003 [q004 - e006 + s171] = m003 [x002 - e006 + s171]; m003
[x002 - e006 + s171] = s172; } strcpy (i161, e152); strcpy (e152, b145);
strcpy (b145, i161); } return (0); case 32: 
#if j002 >= 11 && defined (l001) && defined (r008)
if (w164 == 0) { *m001 = 0; return (0); } for (s171 = 0; s171 < w164; s171++)
{ if (*m001 == r160 [s171]) { *m001 = 1; return (0); } } 
#endif 
*m001 = 0; return (0); case 33: 
#if j002 >= 11
*m001 = a002 (-1); 
#else
*m001 = 0; 
#endif
return (0); case 34: 
#if j002 >= 11
*m001 = t181 (*m001, b145); 
#else
*m001 = 0; 
#endif
return (0); default: b147 ("\n \nGLITCH! Bad special code: %d\n", m000);
return (1); } } 
#ifdef g003
#ifdef __STDC__
void b157 (char *t183) 
#else
void b157 (t183) char *t183; 
#endif
{ FILE *w174; char d175; int s172 = 0; int x177 = 0; int v168 = 0; if ((w174
= fopen (t183, e148)) == NULL) return; while (fgetc (q140) != '{') if (feof
(q140)) return; while (1) { d175 = fgetc (q140); if (feof (q140)) return;
if (isdigit (d175)) { if (v168 == 0) v168 = 1; s172 = 10 * s172 + d175 -
'0'; } else if (d175 == '-' && v168 == 0) v168 = -1; else if (v168) { if
(v168 == -1) s172 = - s172; fputc (s172 & 255, w174); v168 = 0; s172 = 0;
x177++; } if (d175 == '}') break; } fclose (w174); if (x177 != j000) return;
printf ("\n(Database %s created...)\n", y006); } 
#endif 
#ifdef __STDC__
int n159 (void) 
#else
int n159 () 
#endif
{ 
#ifdef MEMORY
int n160; 
#endif
#ifdef n142
char c003 [100]; 
#endif
int f161; int g156; if ((m150 = (char *) malloc (l146)) == NULL) { (void)
printf ("Can't allocate text buffer!\n"); return (1); } g153 = m150; *g153++
= '\n'; q144 = 1; 
#if j002 >= 11
f159 = b148 (NULL); 
#endif 
#ifndef GLK
#ifdef z004
if (e154 != 'y') 
#else
if (x164 == NULL || *x164 == '\0') 
#endif
#endif 
{ b147 ("\n[A-code kernel version %s]\n", l142); 
#ifdef z004
if (e154) d170 ("<br />\n"); 
#endif
} *t161 = '\0'; if (s163 != '?') { char *i163; i163 = strrchr (b144, s163);
if (i163) { i163++; g156 = i163 - b144; } else { i163 = b144; g156 = 0;
} if (*o124 == '\0' && y159) { strncat (o124, i163, sizeof (o124)); *(o124
+ sizeof (o124) - 1) = '\0'; if (strlen (o124) > 15) *(o124 + 15) = '\0';
strcat (o124, ".log"); } 
#ifdef g003
if (t162) { strncpy (t161, t162, sizeof (t161) - 14); i163 = t161 + strlen
(t161); *i163++ = s163; *i163 = '\0'; } else if (i163) { if ((unsigned int)g156
> sizeof (t161) - 13) g156 = sizeof (t161) - 13; strncpy (t161, b144, g156);
} 
#endif 
} 
#ifdef g003
(void) strcat (t161, y006); if ((q140 = fopen (t161, f158)) == NULL) { if
((q140 = fopen ("adv6.h", f158))) (void) b157 (t161); else { (void) printf
("Sorry, can't find the %s data file.\n", t161); n158 (); return (1); }
if ((q140 = fopen (t161, f158)) == NULL) { (void) printf ("Unable to find or construct the data file %s.\n",
t161); return (1); } } 
#ifdef MEMORY
n160 = fread (c003, sizeof (char), j000+1, q140); (void) clearerr (q140);
(void) fclose (q140); if (n160 != j000) { (void) printf ("Wrong data file length: expected %d, got %d.\n",
j000, n160); return (1); } 
#endif 
#ifdef SWAP
z165 [0] = fread (c003, sizeof (char), m148, q140) - 1; x168 [0] = 0; 
#endif 
#ifdef n142
(void) fread (c003, sizeof (char), sizeof (c003), q140); 
#endif 
#endif 
o126 = *c003; 
#ifdef PLAIN
strcpy (w165, c003 + 1); 
#else
w165 [0] = c003 [1] ^ z003; j164 = 0; while (++j164 < 80) if ((w165 [j164]
= c003 [j164] ^ c003 [j164 + 1]) == '\0') break; 
#endif 
if (strcmp (w165, v004) != 0) { (void) printf ("Version stamp mismatch!\n");
return (1); } q142 [0] = NULL; for (f161 = k003; f161 <= k004; f161++) h001
('s', f161, g006); for (f161 = w003; f161 <= j001; f161++) h001 ('s', f161,
v006); 
#if j002 == 1 && defined(q007)
h001 ('s', d005, q007); 
#endif
if (t159 && *t159 && (c180 = fopen (t159, f158)) == NULL) { (void) printf
("Sorry, unable to open command file '%s'!\n", t159); exit (0); } if (c180)
{ fgets (a145, sizeof (a145), c180); if (strncmp (a145, "Wiz: ", 5) == 0)
s168 = atol (a145 + 5); else if (strncmp (a145, v004, strlen (v004)) !=
0) { printf ("%s: wrong adventure version!\n", t159); exit (0); } else s168
= atol (a145 + strlen (v004) + 1); } if (*o124) { if ((x163 = fopen (o124,
"a+")) == NULL) (void) printf ("(Sorry, unable to open log file...)\n");
else 
#ifdef z004
if (e154 == 0 || e154 == 'x') 
#endif 
(void) fprintf (x163, "%s: %u\n", v004, s168); } for (f161 = 0; (unsigned
int)f161 < sizeof (t005) / sizeof (t005 [0]); f161++) if (t005 [f161] <
0) { t005 [f161] *= -1; h001 ('s', t005 [f161], e007 + 1); } return (0);
} 
#ifdef GLK
int argc = 0; char **argv = NULL; 
#ifdef _WIN32
#include <windows.h>
char* d176[1] = { "" }; int winglk_startup_code(const char* u182) { char
q157[80]; char *n161 = q157; char *x169 = v004; while (isalnum (*x169) &&
(n161 - q157) < 78) *n161++ = *x169++; *n161 = '\0'; winglk_app_set_name(q157);
winglk_window_set_title(v004); argc = 1; argv = d176; return 1; } int WINAPI
WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int
nCmdShow) { if (InitGlk(0x00000601) == 0) exit(0); if (winglk_startup_code(lpCmdLine)
!= 0) { glk_main(); glk_exit(); } return 0; } 
#endif
#if defined(unix) || defined(linux) || defined(l156)
#define glkunix_arg_End (0)
#define glkunix_arg_ValueFollows (1)
#define glkunix_arg_NoValue (2)
#define glkunix_arg_ValueCanFollow (3)
#define glkunix_arg_NumberValue (4)
typedef struct glkunix_argumentlist_struct { char *q157; int w175; char
*w176; } glkunix_argumentlist_t; typedef struct glkunix_startup_struct {
int argc; char **argv; } glkunix_startup_t; 
#ifdef __STDC__
int glkunix_startup_code(glkunix_startup_t *y171) 
#else
int glkunix_startup_code(y171) glkunix_startup_t *y171; 
#endif
{ argc = y171->argc; argv = y171->argv; return 1; } glkunix_argumentlist_t
glkunix_arguments[] = { {"", glkunix_arg_ValueFollows, "[<dumpfile]: game to restore"},
{"-b", glkunix_arg_NoValue, "-b: toggle blank lines around prompt"}, 
#ifdef g003
{"-d", glkunix_arg_ValueFollows, "-d <dirname>: dbs directory"}, 
#endif 
{"-r", glkunix_arg_ValueFollows, "[-r] <savefile>: restore game"}, {"-c",
glkunix_arg_ValueFollows, "-c <comfile>: replay game from log"}, {"-log",
glkunix_arg_ValueCanFollow, "-log [<logfile>]: log the game"}, {"-h", glkunix_arg_NoValue,
"-h: print help text"}, {NULL, glkunix_arg_End, NULL } }; 
#endif 
void glk_main (void) 
#else
#ifdef __STDC__
int main (int argc, char **argv) 
#else
int main (argc, argv) int argc; char **argv; 
#endif
#endif
{ char *h171; int s172; char *x169; char *i179 = *argv; char *n162; if (q143
== 0) q143 = 32767; if (u171 == 0) u171 = 32767; t169 = q143 - 2 * d169;
#ifdef GLK
j165 = glk_window_open(0, 0, 0, wintype_TextBuffer, 1); if (!j165) { fprintf
(stderr, "Failed to open main window!\n"); exit (0); } glk_set_window (j165);
#endif
strncpy (b144, *argv, sizeof (b144) - 1); if (argc > 1) while (--argc) {
argv++; if (**argv != '-') { if (! x164) { if (*argv) x164 = *argv; continue;
} if (! o124) { strncpy (o124, *argv, sizeof (o124)); *(o124 + sizeof (o124)
- 1) = '\0'; y159 = 1; continue; } if (! t159) { t159 = *argv; continue;
} } h171 = *argv + 1; if (*h171 == 'j') { u169 = 1 - u169; continue; } else
if (*h171 == 'b') { t167 = 1 - t167; continue; } else if (*h171 == 'p')
{ n151 = 1 - n151; continue; } else if (*h171 == 'l') y159 = 1; else if
(*h171 == 'h') { printf ("\nUsage: %s [options]\n\nOptions:\n", i179); 
#ifndef GLK
printf ("    -w                  invert default wrap/justify setting\n");
printf ("    -b                  invert default setting for blank lines around prompt\n");
printf ("    -s <W>x<H>[-<M>]    set screen size and margin\n"); printf
("    -p                  invert default setting for pause before exiting\n");
#endif 
#ifdef g003
printf ("    -d <dbsdir>         specify dbs directory\n"); 
#endif 
printf ("   [-r] <dumpfile>      restore game from dump\n"); printf ("    -c <cominfile>      replay game from log\n");
printf ("    -l <logfile>        log the game\n"); 
#ifdef t001
if (k155 != -2) printf ("    -u {on|off|forbid}  override default UNDO status\n");
#endif 
printf ("    -h                  print this usage summary\n"); exit (0);
} if (--argc == 0) break; argv++; if (**argv == '-') { argv--; argc++; continue;
} n162 = *argv; switch (*h171) { case 's': s172 = strtol (n162, &x169, 10);
if (s172 == 0) s172 = 32767; if (s172 >= 16 && s172 <= 32767) q143 = s172;
if (*x169++) { s172 = strtol (x169, &x169, 10); if (s172 == 0) s172 = 32767;
if (s172 >= 16 && s172 <= 32767) u171 = s172; if (*x169++) { s172 = strtol
(x169, (char **)NULL, 10); if (s172 >= 0 && s172 < (q143 - 16 )/ 2) d169
= s172; } } t169 = q143 - 2 * d169; break; 
#ifdef g003
case 'd': t162 = n162; break; 
#endif 
case 'l': strncpy (o124, n162, sizeof (o124)); *(o124 + sizeof (o124) -
1) = '\0'; break; case 'c': t159 = n162; break; case 'r': if (*n162) x164
= n162; break; 
#ifdef t001
case 'u': if (k155 == -2) break; if (strcmp (n162, "off") == 0) k155 = -1;
else if (strcmp (n162, "forbid") == 0) k155 = -2; else if (strcmp (n162,
"on") == 0) k155 = 1; break; 
#endif 
#ifdef z004
case 'x': case 'y': e154 = *h171; strncpy (t168, n162, sizeof (t168)); if
(*o124 == '\0') strcpy (o124, "adv770.log"); break; 
#endif 
default: puts ("Bad args!"); exit (0); } } 
#ifdef READLINE
l143 = (char *)malloc(2 * t169 + 1); j157 = l143; 
#endif
#ifdef z004
if (e154) t167 = 1; 
#endif
if (s168 == 0) (void) time ((time_t *) &s168); y164 = s168 %= 32768L; (void)
n002 (1); if (n159 () != 0) { (void) printf ("Sorry, unable to set up the world.\n");
#ifdef GLK
glk_exit (); 
#else
return (0); 
#endif
} 
#ifdef GLK
glk_stylehint_set (wintype_TextBuffer, style_Normal, stylehint_Justification,
stylehint_just_LeftFlush); glk_set_style (style_Normal); 
#endif
z002 [d004] = z002 [b006] = w003; 
#ifdef z004
if (e154 == 'x' && x164 && *x164) { r161 = x164; d000 (997, &z002 [0]);
r161 = ".C.adv"; } else if (e154 == 'y') d000 (999, &z002 [0]); else { if
(x164 && *x164) { i005(); z002 [d005] = -1; z002 [u002] = -1; a146 = 1;
q142[0] = x164; strncpy (b145, x164, n150); *(b145 + n150 - 1) = '\0'; }
else { if (setjmp (b004) == 0) i005 (); } } 
#else
if (x164 && *x164) { i005 (); z002 [d005] = -1; z002 [u002] = -1; strncpy
(b145, x164, n150); *(b145 + n150 - 1) = '\0'; } else { a146 = 0; q142 [0]
= NULL; if (setjmp (b004) == 0) i005 (); } 
#endif 
#ifdef t001
if (k155 == -2) h001 ('s', t002, t003); else if (k155 == 1) h001 ('s', t002,
r006); else if (k155 == -1) { h001 ('s', t002, r006); h001 ('s', t002, r005);
} 
#endif 
(void) setjmp (b004); if (n152) { if (n151) { s170 ("(To exit, press ENTER)");
#ifdef GLK
j159 (1); 
#else 
s179 (a145, 160); putchar ('\n'); 
#endif
} else { if (q144 > 0) j159 (1); putchar ('\n'); 
#ifndef READLINE
putchar ('\n'); 
#endif 
} n158 (); 
#ifdef GLK
glk_exit (); 
#else
return (255); 
#endif
} while (1) { y164 = s168; (void) n002 (1); s168 = y164; y164 = s168 ^ 255;
w007 (); } } 
#ifdef __STDC__
int s001 (int y001,int b000,int s000) 
#else
int s001 (y001,b000,s000) int y001; int b000; int s000; 
#endif
{ if (y001 > k004) return (0); if (e005 [y001] != a005) return (0); if (b000
< 0) return (1); if (b000 == 0) { if (z002 [y001] == s000) return (1); }
else if (h002 (y001, s000)) return (1); return (0); } 
#ifdef __STDC__
int a000 (int y001,int b000,int s000, int n000) 
#else
int a000 (y001,b000,s000,n000) int y001; int b000; int s000; int n000; 
#endif
{ if (y001 > k004) return (0); if (b000 != -1) { if (b000 == 0) { if (z002
[y001] != s000) return (0); } else if (!(h002 (y001, s000))) return (0);
} if (e005 [y001] == n000) return (1); 
#ifdef q005
if (n000 == a005 || !(h002 (y001, q005))) return (0); if (e005 [y001] +
1 == n000) return (1); 
#endif
return (0); } 
#ifdef __STDC__
int g000 (int y001,int b000,int s000) 
#else
int g000 (y001,b000,s000) int y001; int b000; int s000; 
#endif
{ return (a000 (y001, b000, s000, z002 [b006])); } 
#ifdef __STDC__
int y002 (int y001,int b000,int s000) 
#else
int y002 (y001,b000,s000) int y001; int b000; int s000; 
#endif
{ if (s001 (y001,b000,s000)) return (1); if (g000 (y001,b000,s000)) return
(1); return (0); } 
#if !defined(NOVARARGS) && defined(__STDC__)
void z001 (int g001, int e002, ...) { va_list a149; int h172; int h171;
va_start (a149, e002); if (e002 < 0) goto j180; h172 = 0; while (!h172)
{ if ((h171 = va_arg (a149, int)) < 0) { h171 = -h171; h172 = 1; } if (w005
(h171)) goto j180; } va_end (a149); return; j180: va_end (a149); 
#else 
#ifdef __STDC__
void z001 (int g001,int e002,int e003,int i000,int b001,int b158,int k175,int
h173, int v169,int u183,int o137,int j181,int x178,int a157,int o138,int
a158) 
#else
void z001 (g001,e002,e003,i000,b001,b158,k175,h173,v169,u183,o137,j181,x178,a157,o138,a158)
int g001,e002,e003,i000,b001,b158,k175,h173,v169,u183,o137,j181,x178,a157,o138,a158;
#endif
{ int h171; if (e002 < 0) goto j180; if ((h171 = e003) < 0) h171 = -h171;
if (w005 (h171)) goto j180; else if (e003 < 0) return; if ((h171 = i000)
< 0) h171 = -h171; if (w005 (h171)) goto j180; else if (i000 < 0) return;
if ((h171 = b001) < 0) h171 = -h171; if (w005 (h171)) goto j180; else if
(b001 < 0) return; if ((h171 = b158) < 0) h171 = -h171; if (w005 (h171))
goto j180; else if (b158 < 0) return; if ((h171 = k175) < 0) h171 = -h171;
if (w005 (h171)) goto j180; else if (k175 < 0) return; if ((h171 = h173)
< 0) h171 = -h171; if (w005 (h171)) goto j180; else if (h173 < 0) return;
if ((h171 = v169) < 0) h171 = -h171; if (w005 (h171)) goto j180; else if
(v169 < 0) return; if ((h171 = u183) < 0) h171 = -h171; if (w005 (h171))
goto j180; else if (u183 < 0) return; if ((h171 = o137) < 0) h171 = -h171;
if (w005 (h171)) goto j180; else if (o137 < 0) return; if ((h171 = j181)
< 0) h171 = -h171; if (w005 (h171)) goto j180; else if (j181 < 0) return;
if ((h171 = x178) < 0) h171 = -h171; if (w005 (h171)) goto j180; else if
(x178 < 0) return; if ((h171 = a157) < 0) h171 = -h171; if (w005 (h171))
goto j180; else if (a157 < 0) return; if ((h171 = o138) < 0) h171 = -h171;
if (w005 (h171)) goto j180; else if (o138 < 0) return; if ((h171 = a158)
< 0) h171 = -h171; if (w005 (h171)) goto j180; return; j180: 
#endif 
#if j002 >= 11
if (z002 [d004] != z002 [b006]) { *f159 = 3; *(f159 + 1) = 0; } 
#endif 
z002 [d004] = z002 [b006]; *y004 (d004) = -1; z002 [b006] = g001; *y004
(b006) = -1; 
#if defined (m004) && defined (d005)
h001 ('s', d005, m004); 
#endif 
if (e002 < -2) e002 = -e002; if (e002 > 0) q000 (0, e002, 0); if (e002 !=
-1) longjmp (b004, 1); return; } 
#ifdef __STDC__
void y003 (int y001,int b000) 
#else
void y003 (y001,b000) int y001,b000; 
#endif
{ 
#if defined (b007) && defined (d005)
if (e005 [y001] == a005 || b000 == a005) h001 ('s', d005, b007); 
#endif
e005 [y001] = (b000 <= j001 || b000 == a005) ? b000 : z002 [b000]; return;
} 
#ifdef __STDC__
void h000 (char n001, int e000, char t000, int q001, int *c000, short *c001)
#else
void h000 (n001, e000, t000, q001, c000, c001) int n001, e000, t000, q001;
int *c000; short *c001; 
#endif
{ int s172, v170, k176 = 0; if (t000 == 'e') { s172 = z002 [q001]; v170
= 0; } else if (t000 == 'c') { s172 = q001; v170 = 0; } else if (t000 ==
'v') { s172 = z002 [q001]; if (q001 == q004 || q001 == x002) v170 = -1;
else v170 = m003 [n004 * (q001 - e006)]; } else { s172 = c000 [q001]; v170
= c001 [n004 * q001]; } if (n001 == 'V') { z002 [e000] = s172; k176 = m003
[n004 * (e000 - e006)]; } else if (n001 == 'L') { c000 [e000] = s172; k176
= c001 [n004 * e000]; } else z002 [e000] = s172; if (n001 == 'V') { if (v170
== -1 && k176 != -1) m003 [n004 * (e000 - e006)] = -1; else if (v170 !=
-1 && k176 == -1) m003 [n004 * (e000 - e006)] = 0; } else if (n001 == 'L')
{ if (v170 == -1 && k176 != -1) c001 [n004 * e000] = -1; else if (v170 !=
-1 && k176 == -1) c001 [n004 * e000] = 0; } else if (n001 == 'T') { s172
= b142 [2 * (e000 - a003) + 1]; if (s172 <= z002 [e000]) z002 [e000] = s172
- 1; } } 
#ifdef __STDC__
void w001 (int y001, int b000) 
#else
void w001 (y001, b000) int y001,b000; 
#endif
{ z002 [y001] = b000; *y004 (y001) = -1; m144 [y001] = m144 [b000]; return;
} 
#ifdef __STDC__
void u000 (int y001, int b000) 
#else
void u000 (y001, b000) int y001,b000; 
#endif
{ z002 [y001] = z002 [z002 [b000]]; return; } 
#ifdef __STDC__
void v001 (int y001, int b000) 
#else
void v001 (y001, b000) int y001,b000; 
#endif
{ z002 [z002 [y001]] = (b000 > g005 || b000 < n005) ? b000 : z002 [b000];
return; } 
#ifdef __STDC__
void e001 (int y001, int b000) 
#else
void e001 (y001, b000) int y001,b000; 
#endif
{ z002 [y001] = e005 [(b000 < n005 || b000 > g005) ? b000 : z002 [b000]];
*y004 (y001) = -1; return; } 
#ifdef __STDC__
int v002 (int y001) 
#else
int v002 (y001) int y001; 
#endif
{ if (*y004 (y001) == -1) return z002 [y001]; else return y001; } 
#ifdef __STDC__
int l000 (int y001, int *b000, short *s000) 
#else
int l000 (y001, b000, s000) int y001; int *b000; short *s000; 
#endif
{ if (*(s000 + n004 * y001) == -1) return (*(b000 + y001)); else return
y001; } 
#ifdef __STDC__
void z000 (void) 
#else
void z000 () 
#endif
{ 
#if !defined(MEMORY) && !defined(v154)
(void) fclose (q140); 
#endif 
#ifdef m149
(void) printf ("\n(Locates: demanded %ld (+%ld), faults %ld (+%ld))\n",
j163, j163 - a147, u172, u172 - s169); (void) printf ("(Locate ratio %ld%%)\n",
(((1000 * u172) / j163) + 5) / 10); 
#endif 
n152 = 1; longjmp (b004, 1); } 
#ifdef __STDC__
short *y004 (int g001) 
#else
short *y004 (g001) int g001; 
#endif
{ short *d177; d177 = NULL; if (g001 <= k004) d177 = &s003 [y007 * (g001
- k003)]; else if (g001 <= j001) d177 = &b005 [g004 * (g001 - w003)]; else
if (g001 <= g005) d177 = &m003 [n004 * (g001 - e006)]; return (d177); }
#ifdef __STDC__
void h001 (char g001, int e002, int e003) 
#else
void h001 (g001, e002, e003) char g001; int e002; int e003; 
#endif
{ short *s183; if (e002 > g005) { printf ( "*** Run-time glitch! Setting flag on a flagless entity %d! ***\n",
e002); return; } s183 = y004 (e002); while (e003 > 15) { s183++; e003 -=
16; } if (g001 == 's') *s183 |= 1 << e003; else *s183 &= ~(1 << e003); return;
} 
#ifdef __STDC__
void k000 (int k001, char g001, int e002, int e003, int *i000, short *b001)
#else
void k000 (k001, g001, e002, e003, i000, b001) int k001; char g001; int
e002; int e003; int *i000; short *b001; 
#endif
{ short *s183; if (e002 < 0 || e002 >= k001) printf ( "*** Run-time glitch! Local entity %d >= locals %d! ***\n",
e002, k001); if (*(b001 + n004 * e002) == -1) s183 = y004 (*(i000 + e002));
else s183 = b001 + n004 * e002; while (e003 > 15) { s183++; e003 -= 16;
} if (g001 == 's') *s183 |= 1 << e003; else *s183 &= ~(1 << e003); return;
} 
#ifdef __STDC__
int h002 (int g001, int e002) 
#else
int h002 (g001, e002) int g001; int e002; 
#endif
{ short *s183; if (g001 > g005) return (0); if (g001 < n005 && g001 > k005)
return (e002 == e007); s183 = y004 (g001); if (s183 == NULL) return (0);
while (e002 > 15) { s183++; e002 -= 16; } return (*s183 & 1 << e002); }
#ifdef __STDC__
int y005 (int g001, int e002, int *e003, short *i000) 
#else
int y005 (g001, e002, e003, i000) int g001; int e002; int *e003; short *i000;
#endif
{ short *s183; if (*(i000 + n004 * g001) == -1) s183 = y004 (*(e003 + g001));
else s183 = i000 + n004 * g001; if (s183 == NULL) return (0); while (e002
> 15) { s183++; e002 -= 16; } return (*s183 & 1 << e002); } 
#ifdef __STDC__
void d001 (void) 
#else
void d001 () 
#endif
{ w002 = 0; q142 [a146] = NULL; return; } 
#ifdef __STDC__
void s164 (char *i167) 
#else
void s164 (i167) char *i167; 
#endif
{ if ((*i167 >= 'a' && *i167 < 'z') || (*i167 >= 'A' && *i167 < 'Z')) (*i167)++;
else if (*i167 == 'z' || *i167 == 'Z') *i167 -= 25; } 
#ifdef __STDC__
void u168 (char *i167, int c188) 
#else
void u168 (i167, c188) char *i167; int c188; 
#endif
{ char *i180 = i167; while (c188-- && *i167) { if ((*i167 > 'a' && *i167
<= 'z') || (*i167 > 'A' && *i167 <= 'Z')) (*i167)--; else if (*i167 == 'a'
|| *i167 == 'A') *i167 += 25; i167++; } if (x163) fprintf (x163, "TRANSLATION: %s\n",
i180); } 
#ifdef __STDC__
void r002 (int c003, int o001) 
#else
void r002 (c003, o001) int c003; int o001; 
#endif
{ b142 [2 * (c003 - a003)] = g160; z002 [c003] = o001; } 
#ifdef __STDC__
void t184 (int type, int *m001) 
#else
void t184 (type, m001) int type; int *m001; 
#endif
{ time_t f169; struct tm *q142; switch (type) { case 4: case 5: f169 = time
(NULL); q142 = localtime (&f169); *m001 = (type == 4 ? q142 -> tm_hour :
q142 -> tm_min); break; default: (void) b147 ("GLITCH! Bad svar code: %d\n",
type); } return; } 
#ifdef __STDC__
void q003 (void) 
#else
void q003(); 
#endif
{ while (*(g153 - 1) == '\n') g153--; } 
#ifdef __STDC__
void k002 (int l157) 
#else
void k002(l157); int l157; 
#endif
{ if (l157 == q004) strncpy (e152, q142 [a146 - 1], n150); else if (l157
== x002 && z002 [d005] == 2) strncpy (b145, q142 [a146 - 1], n150); else
if (l157 != x002) { (void) b147 ("GLITCH! Bad ARGn indicator: %d\n", l157);
} } 
#ifdef __STDC__
int g002 (char *type) 
#else
int g002 (type); char *type; 
#endif
{ if (strcmp(type, "cgi") == 0) 
#ifdef z004
return (e154); 
#else
return (0); 
#endif
if (strcmp(type, "doall") == 0) return (w002); (void) b147 ("GLITCH! Bad test type: %s\n",
type); return (0); } 
#ifdef t001
#ifdef __STDC__
int m161 (void) 
#else
int m161 () 
#endif
{ char *a; int s172 = 0; h001 ('c', t002, a006); h001 ('c', t002, c005);
h001 ('c', t002, r007); 
#ifdef l001
if (z002 [x002] == l001) s172 = 32767; else if (z002[d005] > 1) 
#else
if (z002[d005] > 1) 
#endif
{ a = b145; while (*a) { if (*a < '0' || *a >'9') { h001 ('s', t002, a006);
return (-1); } s172 = 10 * s172 + *a++ - '0'; } } else s172 = 1; return
(s172); } 
#ifdef __STDC__
int v171 (int z176) 
#else
int v171 (z176) int z176; 
#endif
{ int i; if (z176 == 0) { memcpy (t163, e005, e150 * sizeof(int)); return
(0); } for (i = 0; i <= k004; i++) { if ((t163[i] == a005 && e005[i] !=
a005) || (t163[i] != a005 && e005[i] == a005)) return (1); } return (0);
} 
#ifdef __STDC__
void x000 (void) 
#else
void x000 () 
#endif
{ int s171; int a159; if ((s171 = m161 ()) < 0) return; if (w163 == 0 ||
n148 <= k154 + 4) a159 = 0; else { (void) v171 (0); for (a159 = 0; a159
< s171; a159++) { if (n148 <= k154 + 4) break; n148 -= 4; while (n148 >
k154) { int d177; n148 -= 4; d177 = 256 * (*n148) + *(n148 + 1); if (d177)
*(n147 + d177) = *(n148 + 2); else break; } n148 += 4; } h001 (v171 (1)
? 's' : 'c', t002, r007); } z002 [t002] = a159; 
#ifdef l001
if (z002 [x002] == l001) s171 = a159; 
#endif
h001 (s171 > a159 ? 's' : 'c', t002, c005); return; } 
#ifdef __STDC__
void u001 (void) 
#else
void u001 () 
#endif
{ int a159; int s171; if ((s171 = m161 ()) < 0) return; if (n148 == z164)
a159 = 0; else { (void) v171 (0); for (a159 = 0; a159 < s171; a159++) {
if (n148 > z164) n148 = z164; while (1) { int d177 = 256 * (*n148) + *(n148
+ 1); n148 += 4; if (d177) *(n147 + d177) = *(n148 - 1); else break; } if
(n148 == z164) { a159++; break; } } h001 (v171 (1) ? 's' : 'c', t002, r007);
} z002 [t002] = a159; 
#ifdef l001
if (z002 [x002] == l001) s171 = a159; 
#endif
h001 (s171 > a159 ? 's' : 'c', t002, c005); } 
#endif 

