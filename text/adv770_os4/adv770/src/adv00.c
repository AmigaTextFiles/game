/* Copyleft Mike Arnautov, 21 Jan 2006 */
#define v141 "11.87, MLA - 30 Jul 2005"
#include "adv1.h"
#ifdef o001
#undef o001
#endif 
#ifdef e151
#undef e151
#endif 
#ifdef MEMORY
#ifdef b004
#undef b004
#endif
#endif 
#ifdef FILE
#undef FILE
#define j134
#ifdef SWAP
#undef SWAP
#endif
#ifdef MEMORY
#undef MEMORY
#endif
#ifdef b004
#undef b004
#endif
#endif 
#ifdef SWAP
#ifdef MEMORY
#undef MEMORY
#endif
#ifdef b004
#undef b004
#endif
#endif 
#ifdef b004
#if b004 == 0
#define e151
#endif
#if b004 == 1
#define MEMORY
#endif
#if b004 == 2
#define SWAP 32
#endif
#if b004 == 3
#define j134
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
#ifndef e151
#define o001
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
#define v142 '/'
#else
#if defined(MSDOS) || defined(_WIN32)
#define v142 '\\'
#else
#ifdef __50SERIES
#define v142 '>'
#else
#define v142 '?'
#endif
#endif
#endif
#ifdef __50SERIES
extern int time (); 
#define j135 "i"
#define n162 "o"
#define unlink delete
#else 
#ifdef vms
#define unlink delete
#include <time.h>
#else 
#include <sys/types.h>
#include <sys/stat.h>
#endif 
#define j135 "rb"
#define n162 "wb"
#endif 
#ifdef __STDC__
void l138 (char *); void n163 (char *, int); 
#else
void l138(); void n163(); 
#endif
#ifdef READLINE
#include <readline/readline.h>
#include <readline/history.h>
char *q150; char *y127; 
#endif
FILE *j136; FILE *d169; FILE *i158 = NULL; char o161 [32]; 
#ifdef LOG
int e152 = 1; 
#else
int e152 = 0; 
#endif
FILE *s160 = NULL; char *h163 = NULL; char *j137 = NULL; 
#include "adv0.h"
#ifndef o001
#include "adv6.h"
#endif 
#define a153 '\377'
#define r155 '\376'
#define o162 '\375'
#define r156 '\373'
#if u005 >= 10
#define v143 '\372'
#define w148 '\371'
#define i159 '\370'
#define f168 '\367'
#define g173 '\366'
#define c174 '\365'
#define t143 '\364'
#define l139 '\363'
#ifdef v007
#define k169 '\362'
#endif 
#if u005 >= 11
#define n164 '\361'
#endif
#endif 
#ifdef GLK
#define putchar(X) glk_put_char(X)
#else
#ifdef READLINE
#define putchar(X) *q150++=X;if (*(q150-1)=='\n')\
 {*q150='\0';printf(y127);q150=y127;}
#endif
#endif
#define q151(X) putchar(X); if (i158) (void)fputc(X,i158)
#ifdef t143
#define w149(X) if (*X != t143 && *X != r156) { \
if (i158) (void)fputc(*X,i158); \
putchar(*X++);} else X++
#else
#define w149(X) if (*X != r156) { \
if (i158) (void)fputc(*X,i158); \
putchar(*X++);} else X++
#endif 
void k170 (int); int r003; jmp_buf y000; char c175 [128]; 
#ifdef o001
char *m138 = NULL; 
#endif 
char x187 [128]; char s161; 
#define c176 (f003 * sizeof (int))
#define x188 c176
#define b177 ((a004 + 1) * sizeof (int))
#define h164 (x188 + b177)
#define f169 (w001 * (a004 - w002 + 1) * sizeof (short))
#define s162 (h164 + f169)
#define n165 (e001 * (c005 - s007 + 1) * sizeof (short))
#define x189 (s162 + n165)
#define z130 (v005 * (c006 - w003 + 1) * sizeof (short))
#define x190 (v005 * (m003 - w003 + 1) * sizeof (short))
#define z131 (x189 + z130)
char q152 [z131]; int *d003 = (int *)q152; int *e000 = (int *)(q152 + x188);
short *b001 = (short *)(q152 + h164); short *i001 = (short *)(q152 + s162);
short *f002 = (short *)(q152 + x189); 
#ifdef x005
char n166 [sizeof (q152)]; int q153 [b177]; unsigned char *l140 = NULL;
unsigned char *j138 = NULL; unsigned char *b178; int t144 = 0; 
#ifdef q154
int d170 = -2; 
#else
int d170 = 0; 
#endif 
#endif
char l141 [161] = "\n"; char e153 [161] = "\n"; char r157 [161]; char b179
[161]; int w150, o163; int l142; int y128 [5]; int *b180 = &y128[0]; int
*k171 = &y128 [1]; int *s163 = &y128 [2]; int *f170 = &y128 [3]; int *h165
= &y128 [4]; char t145[160]; 
#define m139 20
char m140 [5 * m139]; char *m141 = m140; char *c177 = m140 + m139; char
j139 [m139]; char *o164 = m140 + 2 * m139; char *b181 = m140 + 3 * m139;
char *i160 = m140 + 4 * m139; char e154 [m139]; 
#if u005 >= 11
#define o165 -1
char b182 [m139]; 
#if defined(r002) && defined(h006)
int s164; int y129 [100]; 
#endif 
#endif 
int e155; int m142 = 0; int r158 = 1; 
#ifdef v007
int j140 = 0; 
#endif
#if defined(JUSTIFY) || u005 == 10
int a154 = 1; 
#else
int a154 = 0; 
#endif
#if defined(v144) || u005 == 1
int a155 = 1; 
#else
int a155 = 0; 
#endif
#if defined(PAUSE) || defined(MSDOS) || defined(_WIN32) || defined (GLK)
int b183 = 1; 
#else
int b183 = 0; 
#endif
#ifdef m004
int t146 = 0; char s165 [160]; char *q155 = ".C.adv"; 
#endif
#include "adv3.h"
#include "adv4.h"
#include "adv2.h"
#include "adv5.h"
#ifdef g004
int s166 = 1; 
#endif 
#ifdef MEMORY
char s006 [d004]; 
#endif 
#ifdef SWAP
#define v145 1024
char s006 [SWAP * v145]; int a156 [SWAP]; int l143 [SWAP]; int b184 [SWAP];
#endif 
char *i161 [100]; char h166 [100]; short q156; 
#ifdef GLK
short x191 = 32767; short u155 = 32767; short v146 = 0; 
#else
#if defined(h167) && (h167 > 5 || h167 == 0)
short x191 = h167; 
#else
short x191 = 24; 
#endif
#if defined(i162) && (i162 > 15 || i162 == 0)
short u155 = i162; 
#else
short u155 = 80; 
#endif
#if defined(MARGIN) && MARGIN >= 0
short v146 = MARGIN; 
#else
short v146 = 1; 
#endif
#endif
short w151; int s167; int q157; int l144; 
#ifdef v147
int j141; int l145; 
#endif 
char *z132; int x192 = 4096; 
#if u005 >= 11
short *e156 = NULL; int j142 = 1; 
#endif
char *x193; int z133 = 0; int l146; int b185; char t147 [80]; int f171;
int t148; int m143 = 0; 
#ifdef i159
int b186 = 0; 
#endif 
char *v148; 
#define y130(X) { char *e157 = X; while (*e157) l001(*e157++); }
#define f172(X) printf(X); if (i158) (void)fprintf(i158,X);
#define f173(X,Y) printf(X,Y); if (i158) (void)fprintf(i158,X,Y);
#define w152(X,Y) for (d171=(char *)X,c178=1; \
(unsigned int)c178<=(unsigned int)Y;c178++,d171++) \
{r159+=(*d171+c178)*(((int)(*d171)+c178)<<4)+Y; \
r159&=07777777777L;} 
#ifdef GLK
#include "glk.h"
static winid_t m144 = NULL; 
#ifdef __STDC__
void m145 (char *q158, int g174) 
#else
void m145 (q158, g174) char *q158; int g174; 
#endif
{ int c179 = 0; event_t d172; memset (q158, '\0', g174); glk_request_line_event(m144,
q158, g174, 0); while (!c179) { glk_select(&d172); switch (d172.type) {
case evtype_LineInput: c179 = 1; (void) strcat(q158,"\n"); default: break;
} } } 
#endif
#if !defined(NOVARARGS) && defined(__STDC__)
int a002 (int u002, ...) { va_list c180; int o166; va_start (c180, u002);
o166 = u002; while (o166 >= 0) { if (e003 (o166)) { va_end (c180); return
(1); } o166 = va_arg (c180, int); } va_end (c180); return (0); } int v003
(int u002, ...) { va_list c180; int o166; va_start (c180, u002); o166 =
u002; while (o166 >= 0) { if (!e003 (o166)) { va_end (c180); return (0);
} o166 = va_arg (c180, int); } va_end (c180); return (1); } 
#else 
#ifdef __STDC__
int a002 (int o167,int r000,int x002,int q001,int s003,int d173,int l147,int
u156, int o168,int k172,int v149,int d174,int n167,int q159,int i163,int
g175) 
#else
int a002 (o167,r000,x002,q001,s003,d173,l147,u156,o168,k172,v149,d174,n167,q159,i163,g175)
int o167,r000,x002,q001,s003,d173,l147,u156,o168,k172,v149,d174,n167,q159,i163,g175;
#endif
{ if (o167 == -1) return (0); if (e003 (o167)) return (1); if (r000 == -1)
return (0); if (e003 (r000)) return (1); if (x002 == -1) return (0); if
(e003 (x002)) return (1); if (q001 == -1) return (0); if (e003 (q001)) return
(1); if (s003 == -1) return (0); if (e003 (s003)) return (1); if (d173 ==
-1) return (0); if (e003 (d173)) return (1); if (l147 == -1) return (0);
if (e003 (l147)) return (1); if (u156 == -1) return (0); if (e003 (u156))
return (1); if (o168 == -1) return (0); if (e003 (o168)) return (1); if
(k172 == -1) return (0); if (e003 (k172)) return (1); if (v149 == -1) return
(0); if (e003 (v149)) return (1); if (d174 == -1) return (0); if (e003 (d174))
return (1); if (n167 == -1) return (0); if (e003 (n167)) return (1); if
(q159 == -1) return (0); if (e003 (q159)) return (1); if (i163 == -1) return
(0); if (e003 (i163)) return (1); if (g175 == -1) return (0); if (e003 (g175))
return (1); return (0); } 
#ifdef __STDC__
int v003 (int o167,int r000,int x002,int q001,int s003,int d173,int l147,int
u156, int o168,int k172,int v149,int d174,int n167,int q159,int i163,int
g175) 
#else
int v003 (o167,r000,x002,q001,s003,d173,l147,u156,o168,k172,v149,d174,n167,q159,i163,g175)
int o167,r000,x002,q001,s003,d173,l147,u156,o168,k172,v149,d174,n167,q159,i163,g175;
#endif
{ if (o167 == -1) return (1); if (!e003 (o167)) return (0); if (r000 ==
-1) return (1); if (!e003 (r000)) return (0); if (x002 == -1) return (1);
if (!e003 (x002)) return (0); if (q001 == -1) return (1); if (!e003 (q001))
return (0); if (s003 == -1) return (1); if (!e003 (s003)) return (0); if
(d173 == -1) return (1); if (!e003 (d173)) return (0); if (l147 == -1) return
(1); if (!e003 (l147)) return (0); if (u156 == -1) return (1); if (!e003
(u156)) return (0); if (o168 == -1) return (1); if (!e003 (o168)) return
(0); if (k172 == -1) return (1); if (!e003 (k172)) return (0); if (v149
== -1) return (1); if (!e003 (v149)) return (0); if (d174 == -1) return
(1); if (!e003 (d174)) return (0); if (n167 == -1) return (1); if (!e003
(n167)) return (0); if (q159 == -1) return (1); if (!e003 (q159)) return
(0); if (i163 == -1) return (1); if (!e003 (i163)) return (0); if (g175
== -1) return (1); if (!e003 (g175)) return (0); return (1); } 
#endif 
#ifdef __STDC__
int u000 (int m001) 
#else
int u000 (m001) int m001; 
#endif
{ e155 = (((e155 << 10) + e155) / 13) & 32767; return (e155 % m001); } 
#ifdef __STDC__
int c003 (int m001) 
#else
int c003 (m001) int m001; 
#endif
{ int e158; e158 = (((e155 << 10) + (int) time (NULL)) / 13) & 32767; return
(e158 % m001); } 
#if u005 >= 11
#define l148 -1
#define c181 1
#define f174 1
#define s168 3
#define j143 4
#define m146 4096
#define r160 *((unsigned short *)(m147 + 2))
short *o169 (short *m147) { if (m147 == NULL) { if ((m147 = (short *)malloc(m146
* sizeof(short))) == NULL) return (NULL); *m147 = 3; *(m147 + 1) = 0; r160
= m146; } else { if ((m147 = (short *)realloc (m147, (*(m147 + 2) + m146)
* sizeof(short))) == NULL) return (NULL); r160 += m146; } return (m147);
} 
#ifdef DEBUG
void j144 (short *m147, char *s006) { short *z134; printf ("Show: %s, free: %hd, root: %hd\n",
s006, *m147, *(m147 + 1)); z134 = m147 + 3; while (z134 < m147 + *m147)
{ fprintf (stderr, "Offset %d: Up %hd, L %hd, R %hd, B %hd, T: %s\n", z134
- m147, *(z134 + c181), *(z134 + c181 + l148), *(z134 + c181 + f174), *(z134
+ s168), (char *)(z134 + j143)); z134 += j143 + 1 + strlen ((char *) (z134
+ j143)) / 2; } } 
#endif 
void e159 (char *z135, int g176, short *g177) { char *d171 = (char *) (g177
+ j143); while (g176--) *d171++ = tolower (*z135++); *d171 = '\0'; } int
c182 (char *h004, char *k173) { int v150, s169; while (*h004) { s169 = tolower
((unsigned char) *h004++); if (!isalpha (s169)) return (*k173 ? -1 : 0);
v150 = (unsigned char) *k173++; if (s169 != v150) return (s169 > v150 ?
1 : -1); } return (0); } void n168 (short *m147, int i164, int n169, int
d175) { int w153 = *(m147 + i164 + c181); int k174 = *(m147 + n169 + c181
- d175); *(m147 + i164 + c181 + d175) = *(m147 + n169 + c181 - d175); *(m147
+ n169 + c181 - d175) = i164; *(m147 + i164 + s168) -= *(m147 + n169 + s168);
*(m147 + n169 + s168) = -(*(m147 + i164 + s168)); if (w153 > 0) *(m147 +
w153 + c181 + (*(m147 + w153 + c181 + l148) == i164 ? l148 : f174)) = n169;
else *(m147 + 1) = n169; *(m147 + n169 + c181) = w153; *(m147 + i164 + c181)
= n169; if (k174) *(m147 + k174 + c181) = i164; } void i165 (short *m147,
int i164, int n169, int d175) { int w153 = *(m147 + i164 + c181); int k174
= *(m147 + n169 + c181 - d175); *(m147 + n169 + c181 - d175) = *(m147 +
k174 + c181 + d175); if (*(m147 + k174 + c181 + d175)) *(m147 + *(m147 +
k174 + c181 + d175) + c181) = n169; *(m147 + i164 + c181 + d175) = *(m147
+ k174 + c181 - d175); if (*(m147 + k174 + c181 - d175)) *(m147 + *(m147
+ k174 + c181 - d175) + c181) = i164; *(m147 + k174 + c181 + d175) = n169;
*(m147 + k174 + c181 - d175) = i164; if (*(m147 + k174 + s168) == *(m147
+ n169 + s168)) *(m147 + n169 + s168) *= -1; else *(m147 + n169 + s168)
= 0; if (*(m147 + k174 + s168) == *(m147 + i164 + s168)) *(m147 + i164 +
s168) *= -1; else *(m147 + i164 + s168) = 0; *(m147 + k174 + s168) = 0;
*(m147 + n169 + c181) = k174; *(m147 + i164 + c181) = k174; *(m147 + k174
+ c181) = w153; if (w153 > 0) *(m147 + w153 + c181 + (*(m147 + w153 + c181
+ l148) == i164 ? l148 : f174)) = k174; else *(m147 + 1) = k174; } short
*l149 (short *m147, char *h004, int g176) { int i164 = 0; int n169 = *(m147
+ 1); int d175; short *g177; int b187 = j143 + 1 + g176 / 2; if (*(m147
+ 1) > 0) { while (n169 > 0) { if ((d175 = c182 (h004, (char *)(m147 + n169
+ j143))) == 0) return (m147); i164 = n169; n169 = *(m147 + n169 + c181
+ d175); } } if (*m147 + b187 > r160 && (r160 > 65535L - b187 || (m147 =
o169 (m147)) == NULL)) return (NULL); g177 = m147 + (n169 = *m147); *(g177
+ c181) = i164; *(g177 + c181 + l148) = *(g177 + c181 + f174) = 0; *(g177
+ s168) = 0; e159 (h004, g176, g177); *m147 += b187; if (i164) { *(m147
+ i164 + c181 + d175) = n169; while (1) { d175 = *(m147 + i164 + c181 +
l148) == n169 ? l148 : f174; if (*(m147 + i164 + s168) == d175) { if (*(m147
+ n169 + s168) == -d175) i165 (m147, i164, n169, d175); else n168 (m147,
i164, n169, d175); break; } if ((*(m147 + i164 + s168) += d175) == 0) break;
n169 = i164; i164 = *(m147 + i164 + c181); if (i164 == 0) break; } } else
*(m147 + 1) = n169; return (m147); } int r161 (short *m147, char *h004)
{ int t149; int d175; if ((t149 = *(m147 + 1)) == 0) return (0); while (t149)
{ if ((d175 = c182 (h004, (char *)(m147 + t149 + j143))) == 0) return (t149);
t149 = *(m147 + t149 + c181 + d175); } return (0); } 
#ifdef __STDC__
void f175 (void) 
#else
void f175 () 
#endif
{ char *f176 = z132; char *x194; while (1) { while (*f176 && ! isalpha (*f176))
f176++; if (*f176 == '\0') break; x194 = f176 + 1; while (*x194 && isalpha
(*x194)) x194++; if (x194 - f176 > 4 && *(x194 - 3) != 'i' && *(x194 - 2)
!= 'n' && *(x194 - 1) != 'g') l149 (e156, f176, x194 - f176); if (*x194
== '\0') break; f176 = x194 + 1; } return; } 
#endif 
#define m148 100
#if defined(PLAIN) && (defined(MEMORY) || defined(e151))
#define x195(X) s006[X]
#else 
#ifdef __STDC__
char x195 (int g178) 
#else
char x195 (g178) int g178; 
#endif
{ 
#ifndef PLAIN
int a157; 
#endif 
#if defined(MEMORY) || defined (e151)
a157 = (g178 >> 4) & 127; if (a157 == 0) a157 = g178 & 127; if (a157 ==
0) a157 = 'X'; a157 = (17 * a157 + 13) & 127; return (a157 ^ s006 [g178]
^ t147 [g178 % f171]); 
#endif 
#ifdef SWAP
int q160; char *w154; int r162; int a158; void v151 (); r162 = 0; w154 =
s006; for (q160 = 0; q160 < SWAP; q160++) { if (g178 >= a156 [q160] && g178
< l143 [q160]) goto v152; w154 += v145; } for (q160 = 0; q160 < SWAP; q160++)
{ if (l143 [q160] == 0) goto z136; if (b184 [r162] > b184 [q160]) r162 =
q160; } q160 = r162; z136: q157++; w154 = s006 + v145 * q160; a158 = (g178
/ v145) * v145 ; if (fseek (j136, a158, 0)) v151 (); a156 [q160] = a158;
l143 [q160] = fread (w154, sizeof (char), v145, j136) + a158; 
#ifdef v147
(void) printf ("Wanted %ld.  Buffer %d: from %ldK.\n", g178, q160, a158
/ v145); 
#endif 
if (a156 [q160] > l143 [q160]) v151 (); v152: b184 [q160] = l144; 
#ifdef PLAIN
return (*(w154 + g178 - a156 [q160])); 
#else 
a157 = (g178 >> 4) & 127; if (a157 == 0) a157 = g178 & 127; if (a157 ==
0) a157 = 'X'; a157 = (17 * a157 + 13) & 127; return (*(w154 + g178 - a156
[q160]) ^ a157 ^ t147 [g178 % f171]); 
#endif 
#endif 
#ifdef j134
void v151 (); static int d176 = -1; char e160; if (d176 != g178) { q157++;
if (fseek (j136, g178, 0)) v151 (); d176 = g178; } e160 = fgetc (j136);
d176++; 
#ifdef PLAIN
return (e160); 
#else 
a157 = (g178 >> 4) & 127; if (a157 == 0) a157 = g178 & 127; if (a157 ==
0) a157 = 'X'; a157 = (17 * a157 + 13) & 127; return (e160 ^ a157 ^ t147
[g178 % f171]); 
#endif 
#endif 
} 
#if defined(SWAP) || defined(j134)
#ifdef __STDC__
void v151 (void) 
#else
void v151 () 
#endif
{ y130 ("\n \nUnable to retrieve required data! Sorry...\n"); k170 (1);
(void) fclose (j136); if (i158) (void) fclose (i158); exit (0); } 
#endif 
#endif 
#ifdef __STDC__
void m002 (int h004, int s001, int l003, int c183) 
#else
void m002 (h004, s001, l003, c183) int h004; int s001; int l003; int c183;
#endif
{ int q160; int n170; static int b188 = 0; if (h004 == 0) { b188 = 0; return;
} if (s001 == 0) s001 = h004; if (l003 >0 && m000 (s001, l003) == 0) return;
if (b188++ > 0) { l001 (','); l001 (' '); } q160 = (c183 == 0) ? h004 :
c183; s167 = k168 [q160]; n170 = x195 (s167); if (n170 == '!') n170 = x195
(++s167); while (n170 != '\0') { l001 (n170); n170 = x195 (++s167); } }
#ifdef __STDC__
int w155 (int e161) 
#else
int w155 (e161) int e161; 
#endif
{ 
#ifdef GLK
return (0); 
#else 
static int k175 = 0; char l150 [160]; int j145; 
#ifdef m004
if (t146) return (0); 
#endif
if (e161 || h163) k175 = 0; else if (++k175 >= x191) { j145 = v146; while
(j145--) putchar (' '); f172 ("[More?] "); fgets (l150, sizeof (l150) -
1, s160 ? s160 : stdin); if (i158) fprintf (i158, "\nREPLY: %s", l150);
k175 = 1; if (*l150 == 'n' || *l150 == 'N' || *l150 == 'q' || *l150 == 'Q')
{ x193 = z132; strcpy (z132,"OK.\n"); if (!a155) strcat (z132, "\n"); strcat
(z132, "? "); return (1); } } return (0); 
#endif 
} 
#ifdef t143
#ifdef __STDC__
char *i166 ( char type, char* w156) 
#else
char *i166 (type, w156) char type; char *w156; 
#endif
{ int s170 = 0; int u157 = 1000; int x196; int k176; int g176; int o170;
char *f176 = w156; 
#ifdef m004
if (t146) { printf ("<center>"); if (type == c174) printf ("<table><tr><td>");
putchar ('\n'); } 
#endif
while (*f176 && *f176 != t143) { k176 = 0; while (*f176 == ' ' || *f176
== '\t') { k176++; f176++; } o170 = g176 = k176; while (*f176 && *f176 !=
'\n' && *f176 != t143) { g176++; if (*f176 != ' ' && *f176 != '\t') o170
= g176; f176++; } if (k176 < g176) { if (k176 < u157) u157 = k176; if (o170
> s170) s170 = o170; } if (*f176 == t143) break; f176++; } s170 -= u157;
x196 = -u157; if (s170 < u155) x196 += (u155 - s170 + 1) / 2; if (a154 ==
0 && x196 > 1) x196 = (9 * x196) / 10; 
#ifdef GLK
glk_set_style (style_Preformatted); x196 = 0; 
#endif
while (*w156 && *w156 != t143) { w155 (0); 
#ifdef GLK
w156 += u157; 
#endif
if (x196 < 0) w156 -= x196; else if (x196 > 0) { for (g176 = 0; g176 < x196;
g176++) { q151 (' '); } } while (*w156 && *w156 != '\n' && *w156 != t143)
{ w149 (w156); } if (*w156 == '\n') { 
#ifdef m004
if (t146) { if (type == c174) printf ("<block>"); else printf ("<br>");
} 
#endif
w149 (w156); } 
#if defined(m004)
if (t146 && *w156 == t143) printf ("<br>"); 
#endif
} 
#ifdef m004
if (t146) { if (type == c174) printf ("</td></tr></table>"); printf ("</center>\n");
} 
#endif
#ifdef GLK
glk_set_style (style_Normal); 
#endif
if (*w156) w156++; return (w156); } 
#endif 
#ifdef __STDC__
void k170 (int f177) 
#else
void k170 (f177) int f177; 
#endif
{ int q161; int d002; char *w156 = z132; char n171 = '\0'; int u158 = 0;
int q162 = 0; int x197 = 0; char w157 = '\0'; char h003; int f178; m143
= 0; f178 = 1; x193--; while (*x193 == ' ' || *x193 == '\n') { if (*x193
== '\n') f178 = 0; x193--; z133--; } 
#ifdef t143
if (*x193 == t143 && *(x193 - 1) == '\n') f178 = -1; 
#endif 
x193++; if (f178 <= 0) { if (! f177) { 
#if u005 > 1
if (!a155 && f178 == 0) { y130 ("\n "); } 
#endif 
y130 ("\n? ") } } else { *x193++ = ' '; z133++; } *x193 = '\0'; if (*w156
== '\n') { while (*w156 == '\n') w156++; if (!a155) w156--; } x193 = w156;
q161 = 0; d002 = -1; 
#if u005 >= 11
if (d003 [d006] < z004 && d003 [z003] < z004) f175 (); 
#endif 
while ((h003 = *w156++)) { if (h003 == r156) { x197 = 1; q162++; continue;
} if (h003 == '\n' && x197) { *(w156 - 1) = r156; x197 = 0; q162++; continue;
} if (h003 == ' ' && u158 && q162 == 0) { u158 = 0; while ((h003 = *w156++)
== ' '); x193 = --w156; w157 = ' '; } else q162++; 
#ifdef c174
if (h003 == c174 || h003 == l139) { x193 = w156 = i166 (h003, w156); if
((h003 = *w156++) == '\0') break; q162 = 0; } 
#endif 
if (h003 == '\n') { if (*w156 == '\n' && *(w156 + 1) == '\n') continue;
if (q162 > 0) { x193 = c001 (x193, q162, 0, 0); q162 = 0; w156 = x193; }
else if (!u158) { q151 ('\n'); x193 = w156; } q161 = 0; d002 = -1; w157
= ' '; q162 = 0; u158 = 0; 
#ifdef m004
if (t146) printf ("<br>"); 
#endif
continue; } u158 = 0; if (h003 == ' ' || h003 == '-') { if (w157 != h003)
{ q161 = q162 - (h003 == ' ' ? 1 : 0); d002++; } if (q162 >= w151) { while
(*w156 == ' ') w156++; x193 = c001 (x193, q161, d002, 1); q161 = 0; d002
= -1; q151 ('\n'); q162 = 0; w156 = x193; u158 = 1; w157 = ' '; continue;
} w157 = h003; continue; } if (q162 >= w151) { if (d002 < 0) { x193 = c001
(x193, w151, 0, 0); } else { x193 = c001 (x193, q161, d002, 1); q151 ('\n');
u158 = 1; } n171 = '\0'; q161 = 0; d002 = -1; q162 = 0; w156 = x193; } else
w157 = h003; } if (q162 > 0) (void) c001 (x193, q162, 0, 0); x193 = z132;
*x193++ = '\n'; *x193 = '\0'; z133 = 1; fflush (stdout); } 
#define t150 128
#define n172 64
#if defined(v008) || u005 >= 11
#define h168 32
#endif
#ifdef a009
#define n173 16
#else
#define n173 0
#endif
#define k177 8
#define h169 4
#define u159 2
#define o171 1
#ifdef v143
#ifdef __STDC__
void l151 (int s005, int s000, int q000) 
#else
void l151 (s005, s000, q000) int s005; int s000; int q000; 
#endif
{ int h170; int type; if (s000 &= 14) s000 = 8; type = x195 (s005++); h170
= x195 (s005++) << 8; h170 |= (x195 (s005) & 255); if (type == 0) { h170
+= w002; s000 = t150; } else if (type == 1) { h170 += s007; s000 = t150;
} else if (type == 2) h170 += w003; else if (type == 3) { h170 += g003;
s000 = u159 | t150; q000 = 0; } else h170 += a005; if (type < 2) q000 =
0; k000 (s000, h170, q000); s167 = s005; } 
#endif 
#ifdef __STDC__
void k000 (int s000, int s001, int q000) 
#else
void k000 (s000, s001, q000) int s000; int s001; int q000; 
#endif
{ int q160; int r163; int j146; int l152; int d177; int v153; int x198;
int l153 = 0; int r164; 
#ifdef a009
int o172; 
#endif 
#if defined(v008) || u005 >= 11
int h171; 
#endif 
int r165; int a159; int x199; int y131; int s171 = s000; char m149 [m139];
int u160; int j147; char *j148; char n170; char r166 = 0; if (x193 == NULL)
x193 = z132; l144++; x198 = s000 & n172; 
#if defined(v008) || u005 >= 11
h171 = s000 & h168; 
#endif
#ifdef a009
o172 = s000 & n173; 
#endif
l152 = s000 & k177; v153 = s000 & h169; d177 = s000 & u159; j146 = s000
& o171; r164 = s000 & t150; 
#ifdef q163
#ifdef a009
if (m000 (r004, r007)) o172 = 0; else if (m000 (r004, a009) || (m000 (r004,
r007) == 0 && m000 (r004, f005) == 0)) o172 = 1; else if (m000 (r004, f005))
o172 = m000 (d003 [w004], q002) ? 0 : 1; 
#endif 
#endif 
if (d177) s001 = d003 [s001]; y131 = q000; if (v153 && ((q000 != d006 &&
q000 != z003 && q000 != v006) || j146)) q000 = d003 [q000]; if (s001 > c005
|| r164) { if (r164 && (s001 == d006 || s001 == z003)) { if (s001 == d006)
j148 = m141; else if (s001 == z003) j148 = c177; else j148 = j139; while
(*j148 != '\0') l001 (*j148++); return; } s167 = k168 [s001]; } else if
(s001 >= s007) { 
#if defined(r007) && defined(a009) && defined(q002)
if (m000 (r004, r007) || (! m000 (r004, a009) && m000 (s001, q002))) s167
= l137 [s001]; else 
#endif
s167 = d168 [s001]; } else if (s001 >= w002) { 
#if defined(v008)
if (h171 || m000 (r004, v008)) s167 = i157 [s001]; else 
#endif
if (e000 [s001] == i002) { l153 = 1; s167 = l137 [s001]; } else s167 = d168
[s001]; } if ((n170 = x195 (s167)) == '\0') goto c184; 
#define e162 1
#define z137 2
#define t151 3
#define r167 4
#define g179 5
if (s001 >= a005) { int m150 = 2 * (s001 - a005); a159 = q000; if (s159
[m150] == e162) { a159 = s159 [m150 + 1]; if (a159 <= 1) a159 = 0; else
a159 = u000 (a159); } else if (s159 [m150] == z137) { a159 = d003 [s001];
if (d003 [s001] < s159 [m150 + 1] - 1) d003[s001]++; } else if (s159 [m150]
== t151) { a159 = d003 [s001]; if (d003 [s001] < s159 [m150 + 1] - 1) d003[s001]++;
else d003 [s001] = 0; } else if (s159 [m150] == r167) a159 = d003 [s001];
else if (s159 [m150] == g179) a159 = d003 [d003 [s001]]; else if (q000 ==
z003 && d003 [z003] < z004) a159 = d003 [d003 [q000]]; } if (!l152) q000
= (s001 <= c005) ? d003 [s001] : s001; while (n170 != '\0') { r166 = n170;
#ifdef v143
if (n170 == v143) { l151 (s167 + 1, s171, q000); n170 = x195 (++s167); continue;
} 
#endif 
#ifdef v007
if (n170 == k169) { j140 ^= 1; goto g180; } 
#endif 
if (n170 == a153) { r165 = x195 (++s167); j147 = s167 + 2 * r165 -1; x199
= (s001 >= a005) ? a159 : q000; 
#if u005 == 1
if (l153) x199 = (x199 == 1 || r165 == 1) ? 0 : 1; if (x199 <= 0 || (x199
== 1 && s001 >= a005)) 
#else 
if (x199 <= 0) 
#endif 
s167 = j147 + 1; else { s167 = s167 - 1 + 2 * 
#if u005 == 1
((x199 > r165) ? r165 - 1 : x199 - 1); if (s001 < a005) s167 += 2; 
#else 
((x199 >= r165) ? r165 - 1 : x199); 
#endif 
r163 = x195 (s167 + 1); if (r163 < 0) r163 += 256; s167 = j147 + 256 * x195
(s167) + r163 + 1; } r163 = x195 (j147 + 1); if (r163 < 0) r163 += 256;
j147 = j147 + 256 * x195 (j147) + r163 + 1; n170 = x195 (s167); } else if
(n170 == r155) { n170 = x195 (s167 = j147++); if (n170 == r155) goto g180;
} 
#if u005 >= 11
else if (n170 == o162 || n170 == n164) { if (j142) j142 = 2; if (j146 ||
n170 == n164) 
#else
else if (n170 == o162) { if (j146) 
#endif
{ (void) sprintf (m149, "%d", q000); j148 = m149 - 1; while (*(++j148) !=
'\0') l001 (*j148); goto g180; } 
#if u005 >= 11
else if (q000 == d006 || q000 == z003 || q000 == v006) { if (q000 == d006)
j148 = m141; else if (q000 == z003) j148 = c177; else j148 = j139; while
(*j148 != '\0') l001 (*j148++); goto g180; } else if (q000 == o165) { j148
= b182; while (*j148 != '\0') l001 (*j148++); goto g180; } 
#else 
else if (q000 == d006 || q000 == z003) { j148 = (q000 == d006 ? m141 : c177);
while (*j148 != '\0') l001 (*j148++); goto g180; } 
#endif 
else { q160 = (v153 && y131 <= c005) ? y131 : q000; u160 = s167; l144++;
s167 = k168 [q160]; n170 = x195 (s167); if (n170 == '!') n170 = x195 (++s167);
while (n170 != '\0') { l001 (n170); n170 = x195 (++s167); } s167 = u160;
} } else l001 (n170); g180: n170 = x195 (++s167); } c184: if (x198) longjmp
(y000, 1); return; } 
#ifdef __STDC__
void l001 (int h003) 
#else
void l001 (h003) int h003; 
#endif
{ 
#ifdef i159
if (b186) { if (h003 == f168) b186 = 0; return; } if (h003 == i159) { b186
= 1; return; } 
#endif 
if (h003 == '\n') { m143++; if (m143 > 2) return; } 
#ifdef t143
else if (h003 && h003 != t143 && m143) 
#else
else if (h003 && m143) 
#endif 
m143 = 0; 
#ifdef g173
if (h003 == g173) h003 = ' '; 
#endif 
#if u005 >= 11
if (isalpha (h003)) { if (j142 == 2) h003 = toupper (h003); j142 = 0; }
else if (isdigit (h003)) j142 = 0; else if (strchr (".!?", h003)) j142 =
1; 
#endif 
if (z133 == x192 - 3) { x192 += 1024; if ((z132 = (char *) realloc (z132,
x192)) == NULL) { puts ("*** Unable to extend text buffer! ***"); exit (0);
} x193 = z132 + z133; } 
#ifdef m004
if (t146 && (h003 == '<' || h003 == '>')) { *x193++ = '&'; *x193++ = (h003
== '<') ? 'l' : 'g'; *x193++ = 't'; *x193 = ';'; z133 += 4; } else { z133++;
*x193 = h003; } 
#else
z133++; *x193 = h003; 
#endif 
#ifdef v007
if (d003 [v007] || j140) l138 (x193); 
#endif 
x193++; return; } 
#ifdef x005
#ifdef __STDC__
void u161 (void) 
#else
void u161 (); 
#endif
{ char *z134; char *w158; unsigned int c178; int z138 = 0; if (d003 [d006]
>= z004 || d003 [z003] >= z004 || 
#ifdef m004
d003 [m004] > 1 || t146 == 'y' || 
#endif
d003 [d006] == x005 || d003 [d006] == r005) return; if (j138 > b178) j138
= b178; if (l140 == NULL) { if ((l140 = (unsigned char *)malloc(8192)) ==
NULL) { printf ("GLITCH: Unable to allocate diffs array!\n"); return; }
else { t144 = 8192; memset (l140, '\0', 4); b178 = j138 = l140 + 4; } }
else { for (c178 = 0, w158 = n166, z134 = q152; c178 < sizeof (q152); c178++,
w158++, z134++) { if (*w158 != *z134 && ! ((c178 >= d006*sizeof(int) &&
c178 < (d006 + 1)*sizeof(int)) || (c178 >= z003*sizeof(int) && c178 < (z003
+ 1)*sizeof(int)) || (c178 >= r004*sizeof(int) && c178 < (r004 + 1)*sizeof(int))))
{ if (j138 - l140 + 8 >= t144) { int d178 = j138 - l140; if ((l140 = (unsigned
char *)realloc(l140, t144 + 8192)) == NULL) { printf ("GLITCH: Unable to re-allocate diffs array!\n");
return; } t144 += 8192; j138 = l140 + d178; } if (c178 || t146 == 0) { *j138++
= c178 / 256; *j138++ = c178 % 256; *j138++ = *w158; *j138++ = *z134; z138
= 1; } } } if (z138) { for (c178 = 0; c178 < 4; c178++) *j138++ = '\0';
b178 = j138; } } memcpy (n166, q152, sizeof (q152)); } 
#endif 
#ifdef __STDC__
void i167 (char *c185, int y132) 
#else
void i167 (c185, y132) char *c185; int y132; 
#endif
{ 
#ifdef READLINE
char *h172; 
#endif
char *d171; char q164 [170]; *c185 = '\0'; 
#ifdef v007
j140 = 0; 
#endif 
if (z133) k170 (0); w155 (1); 
#if u005 >= 11
j142 = 1; 
#endif 
#ifdef x005
if (d003 [l004] >= 0) u161 (); else if (l140 && j138 > l140) b178 = j138
= l140; 
#endif 
#ifdef m004
if (t146 == 'x' || t146 == 'z') { x000 (998, &d003 [0]); if (e156) free
(e156); exit (d003 [m004]); } if (t146 == 'y') { strncpy (c185, s165, y132
- 1); t146 = 'z'; } else 
#endif 
if (s160) { while (1) { if (fgets (q164, y132, s160) == NULL || strncmp
(q164, "INTERACT", 8) == 0) { fclose (s160); s160 = NULL; 
#ifdef READLINE
h172 = readline (y127); memcpy (c185, h172, y132); add_history (h172); free
(h172); *(c185 + y132 - 1) = 0; 
#else 
#ifdef GLK
m145 (c185, y132); 
#else
fgets (c185, y132, stdin); 
#endif
#endif 
break; } if (strncmp (q164, "REPLY: ", 7) == 0) { strncpy (c185, q164 +
7, y132); printf (c185); d171 = c185 + strlen (c185) - 2; if (*c185 != '\n'
&& *d171 == '\r') { *d171++ = '\n'; *d171 = '\0'; } break; } } } else if
(s160 == NULL) 
#ifdef READLINE
{ h172 = readline (y127); memcpy (c185, h172, y132); add_history (h172);
free (h172); *(c185 + y132 - 1) = 0; } 
#else 
#ifdef GLK
m145 (c185, y132 - 1); 
#else
fgets (c185, y132, stdin); 
#endif
#endif 
#ifdef m004
if (t146 == 'x') t146 = 'z'; 
#endif
*(c185 + y132 - 1) = '\0'; *(c185 + y132 - 2) = '\n'; d171 = c185; while
(*d171) { if (strchr ("\"\'", *d171)) *d171 = ' '; d171++; } if (i158) fprintf
(i158,"\nREPLY: %s\n", c185); } 
#ifdef __STDC__
char *c001 (char *f176, int b000, int d002, int z002) 
#else
char *c001 (f176, b000, d002, z002) char *f176; int d002; int b000; int
z002; 
#endif
{ int q160; int s172; int x200; int j145; int q161; char w157; static int
z139 = 1; if (z133 - (x193 - z132) >= w151 && w155 (0) != 0) return x193;
if ((j145 = v146)) while (j145--) q151 (' '); if (d002 <= 0 || z002 == 0
|| b000 == w151) while (b000-- > 0) { w149 (f176); } else { j145 = w151
- b000; x200 = (j145 - z139) / d002 + z139; s172 = 1 - 2 * z139; q161 =
j145 % d002; if (!z139) q161 = d002 - q161; z139 = 1 - z139; w157 = '\0';
while (b000-- > 0) { if (a154 && w157 == ' ' && *f176 != ' ') { q160 = x200;
while (q160-- > 0) { q151 (' '); } if (--q161 ==0) x200 = x200 + s172; }
w157 = *f176; w149 (f176); } } 
#ifdef READLINE
*q150 = '\0'; if (*f176) printf (y127); q150 = y127; 
#endif
fflush (stdout); return (f176); } 
#ifdef __STDC__
void k178 (char *x201, int w159) 
#else
void k178 (x201, w159) char *x201; int w159; 
#endif
{ int k179; if (x195 (w159) == '!') w159++; for (k179 = 1; k179 <= 20; k179++)
if ((*x201++ = x195 (w159++)) == '\0') return; } 
#ifdef __STDC__
void z005 (int r168, int h170) 
#else
void z005 (r168, h170) int r168; int h170; 
#endif
{ int h004; for (h004 = 0; h004 < s008; h004++) { if (i005 [h004] == h170)
{ (void) k178 (r168 == 1 ? m141 : c177, r008 [h004]); return; } } strcpy
(r168 == 1 ? m141 : c177, "*GLITCH*"); return; } 
#ifdef __STDC__
void x003 (int s000, int c002, int type) 
#else
void x003 (s000, c002, type) int s000; int c002; int type; 
#endif
{ int q160; int j149; int u002; if (s000 == 0 && d003 [r004] != 1) return;
j149 = -1; 
#ifdef r002
u002 = (s000 == 2) ? r003 + 1 : w002; if (u002 > a004) goto g181; for (q160
= u002; q160 <= a004; q160++) { 
#if u005 >= 11
if (s164 > 0) { int i, j; j = 0; for (i = 0; i < s164; i++) if (q160 ==
y129 [i]) { y129 [i] = y129 [s164 - 1]; s164--; j = 1; break; } if (j) continue;
} 
#endif 
#else 
for (q160 = w002; q160 <= a004; q160++) { 
#endif 
#ifdef l007
if ((e000 [q160] == c002 || (c002 != i002 && m000 (q160, l007) && e000 [q160]
+ 1 == c002)) && 
#else
if (e000 [q160] == c002 && 
#endif
(type < 0 || m000 (q160, type))) { if (j149 >= 0) return; j149 = q160; if
(s000) break; } } if (j149 >= 0) { d003 [z003] = j149; (void) k178 (c177,
k168 [j149]); 
#ifdef v007
if (d003 [v007] || j140) { char *b189 = c177; while (*b189) l138 (b189++);
} 
#endif 
c177 [19] = '\0'; d003 [r004] = 2; 
#ifdef o003
d003 [o003] = j149; 
#endif
#ifdef r002
if (s000 > 0) r003 = j149; if (s000 == 1) { l146 = c002; b185 = type; }
#endif 
return; } 
#ifdef r002
g181: if (s000 > 0) r003 = 0; 
#endif 
return; } 
#if u005 >= 11
#ifdef t005
#ifdef __STDC__
void v154 (int x202, int t152) 
#else
void v154 (x202, t152) int x202; int t152; 
#endif
{ char y133; (void) strncpy (b182, i161 [q156], m139); 
#ifdef v007
if (d003 [v007]) n163 (b182, m139); 
#endif
k000 (k177, t005, o165); k178 (b182, x202); y133 = *(b182 + t152); *(b182
+ t152) = '\0'; k000 (k177, t005, o165); *(b182 + t152) = y133; if ((unsigned
int)t152 >= strlen (b182)) d003 [t005]++; else k000 (k177, t005, o165);
k000 (0, t005, 0); *b182 = '\0'; y130("\n\n"); } 
#endif
#ifdef __STDC__
void d179 (int *type, int *h170, int *s173, int r168, int r169) 
#else
void d179 (type, h170, s173, r168, r169) int *type; int *h170; int *s173;
int r168; int r169; 
#endif
#else
#ifdef __STDC__
void d179 (int *type, int *h170, int *s173, int r168) 
#else
void d179 (type, h170, s173, r168) int *type; int *h170; int *s173; int
r168; 
#endif
#endif
{ int v155, z140, d180; int b190; 
#if u005 > 1
int v156; int z141; 
#endif 
#if u005 >= 11
int x202; int t152; 
#endif
int a160; int z142; char *b189; int j150; char e163 [m139]; strcpy (e163,
i161 [q156]); 
#ifdef v007
if (d003 [v007]) n163 (e163, m139); 
#endif 
if (*e163 == '\0') { *type = u004; goto z143; } v155 = -1; d180 = s008 +
1; while (d180 > v155 + 1) { l144++; z140 = (v155 + d180) / 2; if (x195
(z142 = j003 [z140]) == '!') z142++; b189 = e163; while (x195 (z142) ==
*b189) if (*b189 != '\0') { b189++; z142++; } else break; if (x195 (z142)
< *b189 && *b189 != '\0') v155 = z140; else d180 = z140; } *h170 = z004;
v155++; d180 = s008; b190 = z004; while (v155 < d180) { b189 = e163; if
(x195 (z142 = j003 [v155]) == '!') { z142++; a160 = 1; } else a160 = 0;
j150 = z142; while (*b189 == x195 (j150)) { if (*b189 == '\0') break; else
{ j150++; b189++; } } if (*b189 != '\0') break; 
#if u005 > 1
if (!a160 || (a160 && x195 (j150) == '\0')) 
#else
if (x195 (j150) == '\0' || j150 - z142 >= 5) 
#endif
{ *type = o006 [v155]; *h170 = i005 [v155]; *s173 = r008 [v155]; if (x195
(j150) == '\0') 
#if u005 == 1
{ if (j150 - z142 <= 2) { b189 = e163; while (++v155 < d180) if (*h170 ==
i005 [v155] && *b189 == x195 (j003 [v155])) *s173 = r008 [v155]; } goto
z143; } 
#else 
goto z143; if (b190 != z004 && *h170 != b190) 
#if u005 >= 11
{ 
#define s174(X) (r168 == 1 ? X > a004 : (X <= a004 && \
(e000 [X] == i002 || e000 [X] == d003 [w004])))
int w160 = s174 (b190); int t153 = s174 (*h170); if ((t153 && w160) || (!t153
&& !w160)) { *h170 = r006; goto z143; } if (!t153 && w160) { *h170 = b190;
*s173 = z141; *type = v156; v155++; continue; } if (t153 && !w160) { b190
= *h170; if (x195 (z142) == '\0') break; } } 
#endif 
z141 = *s173; v156 = *type; 
#endif 
b190 = *h170; if (x195 (z142) == '\0') break; } v155++; } 
#if u005 >= 11
if (*h170 == z004 && r158 > 0) { char *r170 = NULL; int v157 = 0; b190 =
-1; for (v155 = 0; v155 < s008; v155++) { if (x195 (z142 = j003 [v155])
== '!') continue; b189 = e163; while (*b189 == x195 (z142)) { b189++; z142++;
} if (*b189 == '\0' && x195 (z142 + 1) == 0 && o006 [v155] != u004) { if
(b190 >= 0 && i005 [b190] != i005 [v155]) {b190 = a007; break;} b190 = v155;
x202 = j003 [v155]; t152 = z142 - x202; continue; } r170 = b189; v157 =
z142; if (*b189 == x195 (z142 + 1) && *(b189 + 1) == x195 (z142)) { z142
+= 2; b189 += 2; while (*b189 && *b189 == x195 (z142)) {b189++; z142++;}
if (*b189 == '\0' && x195 (z142) == '\0' && o006 [v155] != u004) { if (b190
>= 0 && i005 [b190] != i005 [v155]) {b190 = a007; break;} b190 = v155; x202
= j003 [v155]; t152 = z142 - x202; continue; } b189 = r170; z142 = v157;
} if (*(b189 + 1) == x195 (z142 + 1)) { b189++; z142++; while (*b189 &&
*b189 == x195 (z142)) {b189++; z142++;} if (*b189 == '\0' && x195 (z142)
== '\0' && o006 [v155] != u004) { if (b190 >= 0 && i005 [b190] != i005 [v155])
{b190 = a007; break;} b190 = v155; x202 = j003 [v155]; t152 = z142 - x202;
continue; } b189 = r170; z142 = v157; } if (*b189 == x195 (z142 + 1)) {
z142++; while (*b189 && *b189 == x195 (z142)) {b189++; z142++;} if (*b189
== '\0' && x195 (z142) == '\0' && o006 [v155] != u004) { if (b190 >= 0 &&
i005 [b190] != i005 [v155]) {b190 = a007; break;} b190 = v155; x202 = j003
[v155]; t152 = z142 - x202; continue; } b189 = r170; z142 = v157; } if (*(b189
+ 1) == x195 (z142) || *(b189 + 1) == '\0') { b189++; while (*b189 && *b189
== x195 (z142)) {b189++; z142++;} if (*b189 == '\0' && x195 (z142) == '\0'
&& o006 [v155] != u004) { if (b190 >= 0 && i005 [b190] != i005 [v155]) {b190
= a007; break;} b190 = v155; x202 = j003 [v155]; t152 = z142 - x202; continue;
} } } if (b190 == a007) *h170 = a007; else if (b190 >= 0) { 
#ifdef t005
*type = o006 [b190]; *h170 = i005 [b190]; *s173 = r008 [b190]; if (r169)
v154 (x202, t152); 
#else
*h170 = z004; 
#endif
} } 
#endif 
z143: 
#if u005 >= 11
if (r168 > 1 && (*h170 == z004 || *h170 == a007) && r161 (e156, i161 [q156]))
d003 [z003] = v009; 
#endif 
if (r168 == 1) b189 = m141; else if (r168 == 2) b189 = c177; else b189 =
j139; if (*h170 >= z004) { (void) strncpy (b189, i161 [q156], m139); if
(r168 <= 2 && strlen (i161 [q156]) > 16) (void) strcpy (b179, i161[q156]);
} else { (void) k178 (b189, *s173); 
#ifdef v007
if (d003 [v007] || j140) { char *j148 = b189; while (*j148) l138 (j148++);
} 
#endif 
} if (*h170 >= z004 && r158 != -1) i161 [q156 + 1] = NULL; 
#if defined(g005) && defined(n005) 
else if ((*h170 > g005 && *h170 < n005) && h166 [q156 + 1] == ' ') h166
[q156 + 1] = ';'; 
#endif
return; } 
#ifdef __STDC__
void d181 (void) 
#else
void d181 () 
#endif
{ 
#ifndef q165
char *d171, *x193; char u162; for (d171 = l141; *d171; d171++) *d171 = tolower
(*d171); d171 = x193 = l141; while (*d171 == ' ' || *d171 == ',' || *d171
== ';' || (*d171 == '.' && *(d171 + 1) != '.' && *(d171 + 1) != '/' && *(d171
+ 1) != '\\')) d171++; while (*d171) { if (*d171 == '.' && (*(d171 + 1)
== '.' || *(d171 + 1) == '/' || *(d171 + 1) == '\\')) { *x193++ = *d171++;
continue; } while (*d171 && *d171 != ' ' && *d171 != ',' && *d171 != ';'
&& *d171 != '.' && *d171 != '\n') *x193++ = *d171++; u162 = ' '; while (*d171
== ' ' || *d171 == ',' || *d171 == ';' || *d171 == '\n' || (*d171 == '.'
&& *(d171 + 1) != '.' && *(d171 + 1) != '/' && *(d171 + 1) != '\\')) { if
(*d171 == '.') *d171 = ';'; if (u162 == ' ' || *d171 == '\n') u162 = *d171;
else if ((u162 == ' ' || u162 == ',') && (*d171 == ';' || *d171 == '\n'))
u162 = *d171; d171++; } if (*d171) *x193++ = u162; } if (u162 != '\n') *x193++
= '\n'; *x193++ = '\0'; *x193 = '\0'; 
#ifdef q166
printf ("+++ Comline: %s", l141); 
#endif
q156 = 0; d171 = l141; while (*d171) { if (*d171 == '\n') break; i161 [q156]
= d171; while (*d171 && *d171 != ' ' && *d171 != ',' && *d171 != ';' &&
*d171 != '\n') d171++; h166 [q156 + 1] = *d171; *d171++ = '\0'; if (strcmp
(i161 [q156], c004) == 0) h166 [q156] = ','; else if (strcmp (i161 [q156],
u003) == 0) h166 [q156] = ';'; else q156++; } i161 [q156] = NULL; h166 [q156]
= '\n'; 
#else
char *v148 = l141; char *g182 = NULL; int q156 = 0; int u162; int f179;
int u002; u002 = (l142 == 0); while (*v148) { i161 [q156] = NULL; u162 =
0; while (1) { f179 = 0; switch (*v148) { case ' ': if (u162 == 0) u162
= ' '; break; case ',': if (u162 == 0 || u162 == ' ') u162 = ','; break;
case ';': case '.': if (u162 != ';') u162 = ';'; break; case '\n': case
0: f179 = -1; u162 = '\n'; break; default: f179 = 1; break; } if (f179)
{ if (g182) *g182 = '\0'; break; } v148++; } if (q156 > 0) { if (strcmp
(i161 [q156 - 1], c004) == 0) { q156--; if (u162 == ' ') u162 = ','; } else
if (strcmp(i161 [q156 - 1], u003) == 0) { q156--; if (u162 == ' ' || u162
== ',') u162 = ';'; } } if (q156) { if (u002 && u162 == ',') u162 = ';';
u002 = (u162 == ';'); h166 [q156] = u162; } if (h166 [q156] == ' ' && h166
[q156 - 1] == ',') h166 [q156 - 1] = ';'; if (f179 < 0) break; i161 [q156]
= v148; while (*v148 && ! strchr (" ,.;\n", *v148)) v148++; u162 = 0; g182
= v148; if (strcmp (i161 [q156], c004) == 0) { if (q156 >= 0 && h166 [q156
- 1] == ' ') h166 [q156 - 1] = ','; } else if (strcmp (i161 [q156], u003)
== 0) { if (q156 >= 0 && h166 [q156 - 1] == ' ') h166 [q156 - 1] = ';';
} else q156++; } i161 [q156] = NULL; 
#endif
#if defined(q165) || defined(q166)
{ int n = 0; while (1) { printf ("+++ %d: %s (%c)\n", n, i161 [n], h166
[n]); if (i161 [n] == NULL) break; n++; } } 
#endif
return; } 
#ifdef __STDC__
void u001 (int v000) 
#else
void u001 (v000) int v000; 
#endif
{ int type; int h170; int s173; int x203; if (d003[r004] == -1 && d003 [v006]
== -1) { printf ("\nSorry... This game does not support command line restore.\n\n");
exit (1); } if (d003 [r004] < 90 || d003 [r004] >= f003) r158 = 1; else
if (d003 [r004] == 99) r158 = 0; else r158 = -1; 
#if u005 >= 11
#ifdef r002
if (r003 == 0) s164 = 0; 
#endif
*b182 = '\0'; 
#endif
*h002 (d006) = -1; *h002 (z003) = -1; 
#ifdef r002
if (r003) { x003 (2, l146, b185); if (h166 [q156] == ',') w150 = d003 [d006];
if (r003) return; } else { w150 = d003 [d006]; o163 = d003 [z003]; } 
#else 
w150 = d003 [d006]; o163 = d003 [z003]; 
#endif 
#ifdef f004
if (m000 ((r004), (f004))) { l142 = w150; (void) strncpy (o164, m141, 20);
} else l142 = 0; v002 ('c', (r004), (f004)); 
#endif 
x203 = (q156 != 0 && i161 [q156] && h166 [q156] == ','); if (h166 [q156]
== ';') { d003 [d006] = -1; d003 [z003] = -1; l001 ('\n'); } h173: if (i161
[q156] == NULL) { if (r157 [0] != '\0' && r157 [0] != '\n') (void) strncpy
(e153, r157, 160); l141 [0] = '\0'; while (l141 [0] == '\0' || l141 [0]
== '\n') { 
#ifdef g004
s166 = 1; 
#endif 
#ifdef v147
(void) printf ("\n(Locates: demanded %ld (+%ld), faults %ld (+%ld))", l144,
l144 - l145, q157, q157 - j141); l145 = l144; j141 = q157; 
#endif 
(void) w155 (1); if (v000) (void) k000 (0, v000, 0); if (! x193) x193 =
z132; i167 (l141, 160); 
#ifdef vms
(void) putchar ('\n'); 
#endif 
(void) strncpy (r157, l141, 160); 
#ifdef m004
if (d003 [m004] && (*l141 == '\n' || *l141 == '\0')) { d003 [r004] = 0;
d003 [d006] = -1; d003 [z003] = -1; return; } 
#endif 
} (void) w155 (1); a161: d181 (); q156 = 0; d003 [d006] = -1; d003 [z003]
= -1; d003 [r004] = 0; } if (i161[q156] == NULL) goto h173; w161: 
#if u005 >= 11
*b182 = '\0'; d179 (&type, &h170, &s173, h166 [q156] == ',' ? 2 : 1, 1);
#else
d179 (&type, &h170, &s173, h166 [q156] == ',' ? 2 : 1); 
#endif
q156++; if (type == u004) { if (i161 [q156] == NULL) goto h173; if (h166
[q156] == ' ' || h166 [q156] == ',') goto w161; } 
#ifdef g004
#if u005 >= 11
if (h170 == g004 && ! ((h166 [q156] == ' ' || h166 [q156] == ',') && i161[q156-1][0]
== 'r' && i161[q156-1][1] == '\0')) { if (h166 [q156] == ' ' || h166 [q156]
== ',') { d003 [d006] = -g004; goto a162; } else 
#else
if (h170 == g004) { 
#endif 
if (s166) { if (*e153 == '\n') goto h173; (void) strncpy (l141, e153, 160);
(void) strncpy (r157, e153, 160); goto a161; } else { q156--; while (h166
[++q156] == ' '); d003 [d006] = w150; d003 [z003] = o163; return; } } 
#endif 
#ifdef f004
if ((m000 (r004, f004) && h170 <= c005) || x203) { d003 [d006] = w150; d003
[z003] = h170; d003 [r004] = 2; goto y134; } 
#endif 
d003 [d006] = h170; d003 [r004] = 1; a162: if (h166 [q156] == ' ' && i161
[q156]) { 
#if defined(i003) && defined(y001)
int a163 = r158; if (r158 == 1) r158 = (d003 [d006] < i003 || d003 [d006]
> y001); 
#endif
#if defined(o004) && defined (c007)
if (d003 [d006] > o004 && d003 [d006] < c007) { h166 [q156] = ';'; goto
y134; } 
#endif
#if u005 >= 11
#ifdef a006
if (d003 [d006] == a006) { int i = q156; strcpy (t145, i161 [i]); while
(i161 [i] && (h166[i + 1] == ' ' || h166[i + 1] == ',')) { strcat (t145,
" "); strcat (t145, i161 [i + 1]); if (h166 [i + 1] == ' ') h166 [i + 1]
= ','; i++; } } 
#endif 
*b182 = '\0'; d179 (&type, &h170, &s173, 2, 1); 
#else
d179 (&type, &h170, &s173, 2); 
#endif
#if defined(i003) && defined(y001)
r158 = a163; 
#endif
q156++; if (type == u004) goto a162; d003 [z003] = h170; d003 [r004] = 2;
} y134: 
#ifdef g004
s166 = 0; 
#endif 
if (d003 [r004] == 1 && l142) { if ((l142 > a004 && d003 [d006] < a004)
|| (l142 < a004 && d003 [d006] > a004)) { d003 [r004] = 2; d003 [z003] =
l142; (void) strncpy (c177, o164, 20); } l142 = 0; } if ( d003 [d006] ==
z004 || d003 [z003] == z004 
#if u005 > 1
|| d003 [d006] == r006 || d003 [z003] == r006 
#endif
#if u005 >= 11
|| d003 [d006] == a007 || d003 [z003] == a007 
#endif
) i161 [q156] = NULL; 
#if u005 < 11
else if (d003 [r004] == 2 && (m000 (d003 [z003], a008)) && !(m000 (d003
[d006], a008))) 
#else 
else if (d003 [r004] == 2 && d003 [z003] != v009 && (m000 (d003 [z003],
a008)) && !(m000 (d003 [d006], a008))) 
#endif 
{ int v158; v158 = d003 [d006]; d003 [d006] = d003 [z003]; d003 [z003] =
v158; (void) strncpy (e154, m141, 20); (void) strncpy (m141, c177, 20);
(void) strncpy (c177, e154, 20); } m141 [19] = '\0'; c177 [19] = '\0'; 
#ifdef k169
if (d003[v007]) { n163 (m141, m139); n163 (c177, m139); } 
#endif
if (h166 [q156] == ' ') { 
#if u005 >= 11 && defined(r002) && defined (h006)
if (i161 [q156]) { d179 (&type, &h170, &s173, 3, 0); if (h170 == h006) {
q156++; while (h170 < z004 && (h166 [q156] == ' ' || h166 [q156] == ','))
{ if (strcmp (i161 [q156], c004) != 0) { d179 (&type, &h170, &s173, 3, 1);
if (h170 >= z004) break; else if (h170 > a004) { h170 = o005; break; } else
{ (void) k178 (j139, s173); y129 [s164++] = h170; } } q156++; } d003 [v006]
= -1; if (h170 >= z004) return; } } 
#endif 
if (i161 [q156] && strcmp (i161 [q156], c004) == 0 && h166 [q156] == ' ')
h166 [++q156] = ','; else if (h166[q156] != ';') { 
#if u005 >= 11
if (d003 [r004] > 1 && (h166 [q156] == ' ' || h166 [q156] == ',')) d003
[r004] = o005; if (i161 [q156]) while (h166 [++q156] == ' '); } } 
#ifdef g004
if (d003 [d006] == -g004 && d003 [r004] > 1) { d003 [d006] = g004; d003
[r004] = o005; } 
#endif 
if (d003 [r004] == o005 || d003 [d006] > r004 || d003 [z003] > r004) i161
[q156 + 1] = NULL; 
#else 
while (h166 [++q156] == ' '); } } 
#endif 
if (d003 [r004] == 1) d003 [z003] = -1; 
#if u005 >= 11
else if (d003 [r004] == o005) { d003 [z003] = -1; } 
#endif
return; } 
#ifdef __STDC__
int j000 (int v000) 
#else
int j000 (v000) int v000; 
#endif
{ char l150 [10]; char *o173; int v159 = 0; if (v000 >= 0) k000 (0, v000,
0); else (void) w155 (1); w162: i167 (l150, 10); (void) w155 (1); 
#ifdef v007
if (d003 [v007]) n163 (l150, 10); 
#endif 
o173 = l150; if (*o173 == '\0' || *o173 == '\n') return (1); while (*o173
== ' ') o173++; if (*o173 == 'y' || *o173 == 'Y') return (1); if (*o173
== 'n' || *o173 == 'N') return (0); if (*o173 == 'q' || *o173 == 'Q') return
(0); if (v159) { y130 ("(OK, smartass... I'll assume you mean YES - so there!)\n \n");
return (1); } y130 ("Eh? Do me a favour and answer yes or no!\nWhich will it be? ");
v159 = 1; goto w162; } 
#ifdef __STDC__
void u163 (char *y135, char *r171) 
#else
void u163 (y135, r171) char *y135; char *r171; 
#endif
{ char *d171; (void) strcpy (r171, y135); d171 = r171; while (*d171) { if
(*d171 == '\n') { *d171 = '\0'; break; } 
#if defined (MSDOS) || defined (vms) || defined (_WIN32)
if (*d171 == '.') *d171 = '-'; 
#endif 
d171++; } 
#ifdef MSDOS
*(r171 + 8) = '\0'; 
#else 
#if !defined(unix) && ! defined(__CYGWIN__)
*(r171 + 16) = '\0'; 
#endif
#endif 
if (strcmp (r171 + strlen (r171) - 4, ".adv") != 0) (void) strcat (r171,
".adv"); return; } 
#ifdef __STDC__
int w163 (FILE *a164) 
#else
int w163 (a164) FILE *a164; 
#endif
{ int q167 = 0; int f180 = 0; int e164 = 0; int q168 = 0; char *z144 = n004;
char a165 = fgetc (a164); while (1) { if (*z144 == '\0' && a165 == '\n')
return (0); if (! isalnum (a165) && ! isalnum(*z144)) break; if (a165 !=
*z144) return (1); z144++; a165 = fgetc (a164); } while (*z144 && ! isdigit
(*z144)) z144++; while (a165 != '\n' && ! isdigit (a165)) a165 = fgetc (a164);
if (a165 == '\n' && *z144 == '\0') return (0); while (isdigit (*z144) ||
*z144 == '.') { if (*z144 == '.') { q167 = f180; f180 = 0; } else f180 =
10 * f180 + *z144 - '0'; z144++; } while (isdigit (a165) || a165 == '.')
{ if (a165 == '.') { e164 = q168; q168 = 0; } else q168 = 10 * q168 + a165
- '0'; a165 = fgetc (a164); } if (q167 != e164) return (1); if (f180 < q168)
return (1); while (a165 != '\n') a165 = fgetc (a164); return (0); } 
#ifdef __STDC__
void k180 (void) 
#else
void k180 () 
#endif
{ if (s160) fclose (s160); if (i158) { int c178; fprintf (i158, "\nINTERACT\n");
for (c178 = 0; c178 < 39; c178++) fprintf (i158, "*-"); fprintf (i158, "*\n");
fclose (i158); } 
#if u005 >= 11
if (e156) free (e156); 
#endif
} 
#ifdef __STDC__
int r001 (int s000) 
#else
int r001 (s000) int s000; 
#endif
{ FILE *q169 = NULL; static char *x204 = NULL; static char *r172 = NULL;
char *h174; 
#ifdef m004
char *r173 = (char *)(s000 < 2 ? ".M.adv" : ".T.adv"); 
#endif
int g183 = 1; if (s000 < 0) { 
#ifdef m004
if (t146) { if ((q169 = fopen (r173, j135)) != NULL) { fclose (q169); g183
= 0; } return (g183); } 
#endif
return (x204 ? 0 : 1); } h174 = s000 < 2 ? x204 : r172; if (s000 == 0 ||
s000 == 2) { if (h174 == NULL) { h174 = (char *) malloc (z131); if (h174
== NULL) return (1); if (s000 == 0) x204 = h174; else r172 = h174; } memcpy
(h174, q152, z131); 
#ifdef m004
if (t146) { if ((q169 = fopen (r173, n162)) != NULL && fwrite (x204, 1,
z131, q169) == z131) g183 = 0; if (q169) fclose (q169); return (g183); }
#endif
return (0); } else { 
#ifdef m004
if (t146) { if ((h174 = (char *) malloc (z131)) != NULL && (q169 = fopen
(r173, j135)) != NULL && (fread (h174, 1, z131, q169)) == z131) g183 = 0;
if (q169) fclose (q169); if (g183) return (1); } else if (h174 == NULL)
return (1); 
#else
if (h174 == NULL) return (1); 
#endif 
memcpy (q152, h174, z131); return (0); } } 
#if u005 >= 11
#include <dirent.h>
#ifdef __STDC__
int o174 (int w164, char *f181) 
#else
int o174 (w164, f181) int w164; char *f181; 
#endif
{ int c178 = 0; char q158[16]; DIR *y136; struct dirent *x205; char *c186;
#ifdef m004
if (t146) return (-1); 
#endif
*(q158 + 15) = '\0'; if ((y136 = opendir("."))) { while ((x205 = readdir
(y136))) { if (*(x205->d_name) != '.' && strcmp (c186 = x205->d_name + strlen(x205->d_name)
- 4, ".adv") == 0) { *c186 = '\0'; if (w164) { if (c178) y130 (", ") y130
(x205 -> d_name); } else if (f181) strncpy (q158, x205 -> d_name, 15); c178++;
} } closedir (y136); if (w164) y130 (".\n") if (f181 && c178 == 1) { d003
[z003] = 0; strcpy (f181, q158); } } return (c178); } 
#endif
#ifdef __STDC__
int x000 (int s000, int *x001) 
#else
int x000 (s000, x001) int s000; int *x001; 
#endif
{ static char r171 [168]; static char *b191; char *h174; char y135 [168];
FILE *x206; int o166, e165; int w165; char m151 [12]; static int b192 =
sizeof (time_t); int r159; int s175; char *d171; int c178; int i168, z145,
i169, e166, b193; static int b194; static long m152; void f182 (); void
t154 (); switch (s000) { case 1: case 2: o166 = d003 [z003]; 
#ifndef m004
w162: 
#endif
if (o166 >= 0) { if (*b179 && strncmp (b179, c177, 16) == 0) (void) strcpy
(y135, b179); else (void) strcpy (y135, c177); } else 
#ifdef m004
{ printf ("*** Glitch! No save/restore name specified!\n"); *x001 = 3; return
(0); } case 999: case 997: if (s000 > 2) { strncpy (c177, q155, m139 - 1);
(void) u163 (q155, r171); } else (void) u163 (y135, r171); 
#else
{ if (s000 == 1) { y130 ("\nName to save game under: "); } else { 
#if u005 >= 11
int c178 = o174 (0, y135); if (c178 == 0) y130 ( "Can't see any saved games here, but you may know of some elsewhere.\n")
else if (c178 == 1) { goto n174; } else { y130 ("You have the following saved games: ")
(void) o174 (1, NULL); } 
#endif
y130 ("\nName of saved game to restore: "); } i167 (y135, 16); w155(1);
#ifdef v007
if (d003 [v007]) n163 (y135, 16); 
#endif 
if (y135 [0] == '\0' || y135 [0] == '\n') { y130 ("\nChanged your mind, eh?  Fine by me...\n");
*x001 = 3; return (0); } } 
#if u005 >= 11
n174: 
#endif
(void) u163 (y135, r171); 
#endif 
if ((x206 = fopen (r171, j135)) != NULL) { if (s000 == 2 || s000 == 999
|| s000 == 997) goto h175; (void) fclose (x206); y130 ("\nThere's already a game dumped under that name.\n");
#ifdef m004
*x001 = 2; return (0); 
#else
y130 ("Do you really mean to overwrite it? "); if (!j000 (-1)) { o166 =
-1; goto w162; } y130 ("\nAs you wish...\n"); 
#endif 
} if (s000 == 2) { *x001 = 1; return (0); } 
#ifdef m004
case 998: if (s000 == 998) { u163 (q155, r171); if (d003 [m004] == 0) d003
[m004] = 1; *h165 = d003 [m004]; } else { if (s000 != 1) return (0); } 
#endif 
if ((x206 = fopen (r171, n162)) == NULL) { 
#ifdef m004
if (s000 != 998) *x001 = 1; 
#endif 
return (1); } (void) time ((time_t *) &m151[0]); (void) fprintf (x206, "%s\n",
n004); o166 = w002; (void) fwrite (&o166, sizeof (int), 1, x206); o166 =
a004; (void) fwrite (&o166, sizeof (int), 1, x206); o166 = c005; (void)
fwrite (&o166, sizeof (int), 1, x206); o166 = m003; (void) fwrite (&o166,
sizeof (int), 1, x206); o166 = c006; (void) fwrite (&o166, sizeof (int),
1, x206); o166 = f003; (void) fwrite (&o166, sizeof (int), 1, x206); *d003
= -1; r159 = 0; w152(m151, sizeof(time_t)) w152(q152, c176) w152(q152 +
x188, b177) w152(q152 + h164, f169) w152(q152 + s162, n165) w152(q152 +
x189, z130) 
#ifdef m004
if (t146 && s000 == 998) { w152(m140, sizeof(m140)); w152(y128, sizeof(y128));
} 
#endif 
(void) fwrite (&r159, sizeof (int), 1, x206); (void) fwrite (m151, 1, sizeof(time_t),
x206); (void) fwrite (q152, 1, z131, x206); 
#ifdef m004
if (t146 && s000 == 998) { (void) fwrite (m140, sizeof (char), sizeof (m140),
x206); (void) fwrite (y128, sizeof (char), sizeof (y128), x206); (void)
fwrite (&m142, sizeof (int), 1, x206); (void) fwrite (e156, sizeof (short),
*e156 - 1, x206); (void) fwrite (e153, sizeof (char), sizeof (e153), x206);
(void) fwrite (b179, sizeof (char), sizeof (b179), x206); } 
#endif 
*x001 = (ferror (x206)) ? 1 : 0; (void) fclose (x206); 
#ifdef x005
if (d003 [l004] >= 0 && l140 && (l140 < j138 || t146)) { strcpy (r171 +
strlen(r171) - 3, "adh"); if (((l140 && j138 > l140 + 4) || (t146 && d003
[m004] <= 1)) && (x206 = fopen (r171, n162))) { int g176 = j138 - l140;
fwrite (&g176, 1, sizeof (int), x206); fwrite (l140, 1, j138 - l140, x206);
w152(l140, g176); fwrite (&r159, 1, sizeof (r159), x206); g176 = b178 -
l140; fwrite (&g176, 1, sizeof (int), x206); fclose (x206); } } 
#endif 
return (*x001); h175: 
#ifdef m004
if (t146 == 'x') { fprintf (i158, "\nREPLY: restore %s\n", r171); *k171
= 2; *f170 = d003 [z003]; strncpy (i160, c177, 20); } 
#endif
if (w163 (x206) != 0) { *x001 = 4; return (0); } e165 = 0; (void) fread
(&o166, sizeof (int), 1, x206); 
#ifdef DEBUG
printf ("FOBJECT: image %3d, expected %3d\n", o166, w002); 
#endif 
if (o166 != w002) e165++; (void) fread (&i168, sizeof (int), 1, x206); 
#ifdef DEBUG
printf ("LOBJECT: image %3d, expected %3d\n", i168, a004); 
#endif 
if (i168 > a004) e165++; (void) fread (&z145, sizeof (int), 1, x206); 
#ifdef DEBUG
printf ("LPLACE: image %3d, expected %3d\n", z145, c005); 
#endif 
if (z145 > c005) e165++; (void) fread (&i169, sizeof (int), 1, x206); 
#ifdef DEBUG
printf ("LVERB: image %3d, expected %3d\n", i169, m003); 
#endif 
if (i169 > m003) e165++; (void) fread (&e166, sizeof (int), 1, x206); 
#ifdef DEBUG
printf ("LVARIABLE: image %3d, expected %3d\n", e166, c006); 
#endif 
if (e166 > c006) e165++; (void) fread (&b193, sizeof (int), 1, x206); 
#ifdef DEBUG
printf ("LTEXT: image %3d, expected %3d\n", b193, f003); 
#endif 
if (b193 > f003) e165++; if (e165) { *x001 = 2; (void) fclose (x206); return
(0); } s175 = 0; 
#ifdef m004
if (t146 != 'z' && t146 != 'y' && t146 != 'x') { *x001 = r001 (2); if (*x001
!= 0) return (0); } 
#endif
if (b191 == NULL) { b191 = (char *) malloc (z131); if (b191 == NULL) return
(0); } h174 = b191; 
#ifdef DEBUG
puts ("Reading image..."); 
#endif
(void) fread (&s175, sizeof (int), 1, x206); 
#ifdef DEBUG
f173("CHKSAV %d\n", s175) 
#endif
(void) fread (m151, 1, sizeof (m151), x206); if (*((int *)(m151 + 4)) ==
-1) b192 = 4; else if (*((int *)(m151 + 8)) == -1) b192 = 8; else b192 =
sizeof(time_t); fseek (x206, b192 - 12L, SEEK_CUR); { int d182 = b193 *
sizeof (int); int g184 = (i168 + 1) * sizeof (int); int e167 = d182 + g184;
int u164 = w001 * (i168 - w002 + 1) * sizeof (short); int n175 = e167 +
u164; int y137 = e001 * (z145 - i168) * sizeof (short); int d183 = n175
+ y137; int c187 = v005 * (e166 - z145) * sizeof (short); int u165 = d183
+ c187; (void) fread (b191, 1, u165, x206); } 
#ifdef m004
if (t146 && s000 == 999) { (void) fread (m140, sizeof (char), sizeof (m140),
x206); (void) fread (y128, sizeof (char), sizeof (y128), x206); (void) fread
(&m142, sizeof (int), 1, x206); if (! ferror (x206)) { (void) fread (e156,
sizeof (short), 2, x206); if (ferror (x206)) { *e156 = 3; *(e156 + 1) =
0; } else (void) fread (e156 + 2, sizeof (short), *e156 - 3, x206); } if
(! ferror (x206)) { (void) fread (e153, sizeof (char), sizeof (e153), x206);
} *b179 = '\0'; if (! ferror (x206)) { (void) fread (b179, sizeof (char),
sizeof (b179), x206); } clearerr (x206); } 
#endif 
if (ferror (x206)) { *x001 = 2; return (0); } 
#ifdef DEBUG
puts ("Checking image..."); 
#endif
(void) fclose (x206); r159 = 0; { int d182 = b193 * sizeof (int); int g184
= (i168 + 1) * sizeof (int); int e167 = d182 + g184; int u164 = w001 * (i168
- w002 + 1) * sizeof (short); int n175 = e167 + u164; int y137 = e001 *
(z145 - i168) * sizeof (short); int d183 = n175 + y137; int c187 = v005
* (e166 - z145) * sizeof (short); int k181 = v005 * (i169 - z145) * sizeof
(short); w152(m151, b192); w152(b191, d182) w152(b191 + d182, g184) w152(b191
+ e167, u164) w152(b191 + n175, y137) w152(b191 + d183, c187) if (o166 <
f003) while (o166 < f003) *(d003 + (o166++)) = 0; 
#ifdef m004
if (t146 && s000 == 999) { w152(m140, sizeof(m140)); w152(y128, sizeof(y128));
} 
#endif 
if (s175 != r159) { *x001 = 2; return (0); } if (b192 == sizeof(m152)) memcpy
(&m152, m151, b192); else m152 = 1; memset (q152, '\0', z131); memcpy (d003,
b191, (i168 + 1) * sizeof (int)); memcpy (d003 + s007, b191 + (i168 + 1)
* sizeof (int), (z145 - i168) * sizeof (int)); memcpy (d003 + w003, b191
+ (z145 + 1) * sizeof (int), (i169 - z145) * sizeof (int)); memcpy (d003
+ g003, b191 + (i169 + 1) * sizeof (int), (e166 - i169 - 1) * sizeof (int));
memcpy (d003 + a005, b191 + e166 * sizeof (int), (b193 - e166) * sizeof
(int)); memcpy (e000, b191 + d182, g184); memcpy (b001, b191 + e167, u164);
memcpy (i001, b191 + n175, y137); memcpy (f002, b191 + d183, k181); memcpy
((char *)f002 + x190, b191 + d183 + k181, c187 - k181); } 
#ifdef m004
if (s000 == 997) d003 [m004] = 2; 
#endif
#ifdef x005
if (d003 [l004] >= 0) { strcpy (r171 + strlen(r171) - 3, "adh"); if ((x206
= fopen (r171, j135))) { int g176; int b195 = g176; unsigned char *d; if
(l140) b178 = j138 = l140 + 4; fread (&g176, 1, sizeof (int), x206); if
(g176 > 0) { b195 = 8192 * ((g176 + 8191) / 8192); d = (unsigned char *)malloc(b195);
(void) fread (d, 1, g176, x206); fread (&s175, 1, sizeof (s175), x206);
w152(d, g176); if (r159 == s175) { if (l140) free (l140); l140 = d; t144
= b195; j138 = l140 + g176; memcpy (n166, q152, sizeof(q152)); fread (&g176,
1, sizeof (int), x206); b178 = l140 + g176; } } fclose (x206); } } 
#endif 
*x001 = 0; return (0); case 3: 
#ifdef m004
(void) u163 (c177, r171); 
#endif 
*x001 = unlink (r171); if (*x001) { printf ("Failed: %s - error code: %d<br />\n",
r171, *x001); system ("pwd"); } strcpy (r171 + strlen(r171) - 3, "adh");
(void) unlink (r171); return (0); case 4: case 5: *x001 = 0; return (0);
case 6: b194 = *x001; return (0); case 7: *x001 = b194; return (0); case
8: (void) time ((time_t *) &w165); *x001 = 1 + (w165 - m152) / 60; return
(0); case 9: 
#if u005 < 10
*x001 = 0; 
#else
d003 [d006] = *x001; z005 (1, *x001); 
#endif
return (0); case 10: d003 [z003] = *x001; z005 (2, *x001); return (0); case
11: d003 [z003] = d003 [d006]; strncpy (c177, m141, 20); d003 [r004] = 2;
return (0); case 12: *x001 = (i161[q156] == NULL); return (0); case 14:
if ((*x001 = (d169 = fopen ("adv.vrg", j135)) ? 0 : 1) == 0) fclose (d169);
return (0); case 15: if ((d169 = fopen ("adv.vrg", n162))) fclose (d169);
return (0); case 19: o166 = *x001; a154 = o166 < 2 ? o166 : 1 - a154; *x001
= a154; return (0); case 20: o166 = atoi (c177); *x001 = 0; if (o166 ==
0) return (0); if (o166 < 16) o166 = 16; if (o166 > 1024) o166 = 1024; *x001
= o166; u155 = o166; if (u155 - 2 * v146 < 16) v146 = (u155 - 16) / 2; if
(v146 < 0) v146 = 0; w151 = u155 - 2 * v146; 
#ifdef READLINE
c178 = q150 - y127; y127 = (char *)realloc(y127, 2 * w151 + 1); q150 = y127
+ c178; 
#endif
return (0); case 21: o166 = atoi (c177); *x001 = 0; if (o166 <0) o166 =
0; if (o166 > 9) o166 = 9; if (u155 - o166 - o166 < 16) o166 = (u155 - 16)
/ 2; if (o166 < 0) o166 = 0; *x001 = o166; v146 = o166; w151 = u155 - o166
- o166; 
#ifdef READLINE
c178 = q150 - y127; y127 = (char *)realloc(y127, 2 * w151 + 1); q150 = y127
+ c178; 
#endif
return (0); case 22: o166 = atoi (c177); if (o166 < 4) { *x001 = 0; return
(0); } if (o166 > 1024) o166 = 1024; *x001 = o166; x191 = o166; return (0);
case 23: *b180 = *x001; *k171 = d003 [r004]; *s163 = d003 [d006]; strncpy
(b181, m141, 20); if (*k171 == 2) { *f170 = d003 [z003]; strncpy (i160,
c177, 20); } else { *f170 = -1; *i160 = '\0'; } return (0); case 24: *x001
= *b180; d003 [r004] = *k171; d003 [d006] = *s163; d003 [z003] = *f170;
strncpy (m141, b181, 20); strncpy (c177, i160, 20); return (0); case 27:
*x001 = 1; if (*t145) { y130("\nOk - \"") y130(t145) y130("\"\n") *t145
= '\0'; } return (0); case 28: *x001 = r001 (3); return (0); case 29: *x001
= 0; if (d003 [r004] > 1) { o166 = d003 [d006]; d003 [d006] = d003 [z003];
d003 [z003] = o166; for (c178 = 0; c178 < v005; c178++) { o166 = f002 [d006
- w003 + c178]; f002 [d006 - w003 + c178] = f002 [z003 - w003 + c178]; f002
[z003 - w003 + c178] = o166; } strcpy (e154, m141); strcpy (m141, c177);
strcpy (c177, e154); } return (0); case 32: 
#if u005 >= 11 && defined (r002) && defined (h006)
if (s164 == 0) { *x001 = 0; return (0); } for (c178 = 0; c178 < s164; c178++)
{ if (*x001 == y129 [c178]) { *x001 = 1; return (0); } } 
#endif 
*x001 = 0; return (0); case 33: 
#if u005 >= 11
*x001 = r001 (-1); 
#else
*x001 = 0; 
#endif
return (0); case 34: 
#if u005 >= 11
*x001 = o174 (*x001, c177); 
#else
*x001 = 0; 
#endif
return (0); default: f173 ("\n \nGLITCH! Bad special code: %d\n", s000);
return (1); } } 
#ifdef o001
#ifdef __STDC__
void t155 (char *m153) 
#else
void t155 (m153) char *m153; 
#endif
{ FILE *c188; char r174; int o166 = 0; int t156 = 0; int a166 = 0; if ((c188
= fopen (m153, n162)) == NULL) return; while (fgetc (j136) != '{') if (feof
(j136)) return; while (1) { r174 = fgetc (j136); if (feof (j136)) return;
if (isdigit (r174)) { if (a166 == 0) a166 = 1; o166 = 10 * o166 + r174 -
'0'; } else if (r174 == '-' && a166 == 0) a166 = -1; else if (a166) { if
(a166 == -1) o166 = - o166; fputc (o166 & 255, c188); a166 = 0; o166 = 0;
t156++; } if (r174 == '}') break; } fclose (c188); if (t156 != d004) return;
printf ("\n(Database %s created...)\n", t004); } 
#endif 
#ifdef __STDC__
int f183 (void) 
#else
int f183 () 
#endif
{ 
#ifdef MEMORY
int u166; 
#endif
#ifdef j134
char s006 [100]; 
#endif
int q160; int g176; if ((z132 = (char *) malloc (x192)) == NULL) { (void)
printf ("Can't allocate text buffer!\n"); return (1); } x193 = z132; *x193++
= '\n'; z133 = 1; 
#if u005 >= 11
e156 = o169 (NULL); 
#endif 
#ifndef GLK
#ifdef m004
if (t146 != 'y') 
#else
if (j137 == NULL || *j137 == '\0') 
#endif
#endif 
{ f173 ("\n[A-code kernel version %s]\n", v141); 
#ifdef m004
if (t146) f172 ("<br />\n"); 
#endif
} *c175 = '\0'; if (v142 != '?') { char *e157; e157 = strrchr (x187, v142);
if (e157) { e157++; g176 = e157 - x187; } else { e157 = x187; g176 = 0;
} if (*o161 == '\0' && e152) { strncat (o161, e157, sizeof (o161)); *(o161
+ sizeof (o161) - 1) = '\0'; if (strlen (o161) > 15) *(o161 + 15) = '\0';
strcat (o161, ".log"); } 
#ifdef o001
if (m138) { strncpy (c175, m138, sizeof (c175) - 14); e157 = c175 + strlen
(c175); *e157++ = v142; *e157 = '\0'; } else if (e157) { if ((unsigned int)g176
> sizeof (c175) - 13) g176 = sizeof (c175) - 13; strncpy (c175, x187, g176);
} 
#endif 
} 
#ifdef o001
(void) strcat (c175, t004); if ((j136 = fopen (c175, j135)) == NULL) { if
((j136 = fopen ("adv6.h", j135))) (void) t155 (c175); else { (void) printf
("Sorry, can't find the %s data file.\n", c175); k180 (); return (1); }
if ((j136 = fopen (c175, j135)) == NULL) { (void) printf ("Unable to find or construct the data file %s.\n",
c175); return (1); } } 
#ifdef MEMORY
u166 = fread (s006, sizeof (char), d004+1, j136); (void) clearerr (j136);
(void) fclose (j136); if (u166 != d004) { (void) printf ("Wrong data file length: expected %d, got %d.\n",
d004, u166); return (1); } 
#endif 
#ifdef SWAP
l143 [0] = fread (s006, sizeof (char), v145, j136) - 1; a156 [0] = 0; 
#endif 
#ifdef j134
(void) fread (s006, sizeof (char), sizeof (s006), j136); 
#endif 
#endif 
s161 = *s006; 
#ifdef PLAIN
strcpy (t147, s006 + 1); 
#else
t147 [0] = s006 [1] ^ d005; f171 = 0; while (++f171 < 80) if ((t147 [f171]
= s006 [f171] ^ s006 [f171 + 1]) == '\0') break; 
#endif 
if (strcmp (t147, n004) != 0) { (void) printf ("Version stamp mismatch!\n");
return (1); } i161 [0] = NULL; for (q160 = w002; q160 <= a004; q160++) v002
('s', q160, t006); for (q160 = s007; q160 <= c005; q160++) v002 ('s', q160,
i004); 
#if u005 == 1 && defined(f005)
v002 ('s', r004, f005); 
#endif
if (h163 && *h163 && (s160 = fopen (h163, j135)) == NULL) { (void) printf
("Sorry, unable to open command file '%s'!\n", h163); exit (0); } if (s160)
{ fgets (l141, sizeof (l141), s160); if (strncmp (l141, "Wiz: ", 5) == 0)
m142 = atol (l141 + 5); else if (strncmp (l141, n004, strlen (n004)) !=
0) { printf ("%s: wrong adventure version!\n", h163); exit (0); } else m142
= atol (l141 + strlen (n004) + 1); } if (*o161) { if ((i158 = fopen (o161,
"a+")) == NULL) (void) printf ("(Sorry, unable to open log file...)\n");
else 
#ifdef m004
if (t146 == 0 || t146 == 'x') 
#endif 
(void) fprintf (i158, "%s: %u\n", n004, m142); } for (q160 = 0; (unsigned
int)q160 < sizeof (i005) / sizeof (i005 [0]); q160++) if (i005 [q160] <
0) { i005 [q160] *= -1; v002 ('s', i005 [q160], a008 + 1); } return (0);
} 
#ifdef GLK
int argc = 0; char **argv = NULL; 
#ifdef _WIN32
#include <windows.h>
char* s176[1] = { "" }; int winglk_startup_code(const char* n176) { char
t157[80]; char *c189 = t157; char *d171 = n004; while (isalnum (*d171) &&
(c189 - t157) < 78) *c189++ = *d171++; *c189 = '\0'; winglk_app_set_name(t157);
winglk_window_set_title(n004); argc = 1; argv = s176; return 1; } int WINAPI
WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int
nCmdShow) { if (InitGlk(0x00000601) == 0) exit(0); if (winglk_startup_code(lpCmdLine)
!= 0) { glk_main(); glk_exit(); } return 0; } 
#endif
#if defined(unix) || defined(linux) || defined(t158)
#define glkunix_arg_End (0)
#define glkunix_arg_ValueFollows (1)
#define glkunix_arg_NoValue (2)
#define glkunix_arg_ValueCanFollow (3)
#define glkunix_arg_NumberValue (4)
typedef struct glkunix_argumentlist_struct { char *t157; int u167; char
*f184; } glkunix_argumentlist_t; typedef struct glkunix_startup_struct {
int argc; char **argv; } glkunix_startup_t; 
#ifdef __STDC__
int glkunix_startup_code(glkunix_startup_t *h176) 
#else
int glkunix_startup_code(h176) glkunix_startup_t *h176; 
#endif
{ argc = h176->argc; argv = h176->argv; return 1; } glkunix_argumentlist_t
glkunix_arguments[] = { {"", glkunix_arg_ValueFollows, "[<dumpfile]: game to restore"},
{"-b", glkunix_arg_NoValue, "-b: toggle blank lines around prompt"}, 
#ifdef o001
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
{ char *b196; int o166; char *d171; char *y138 = *argv; char *v160; if (u155
== 0) u155 = 32767; if (x191 == 0) x191 = 32767; w151 = u155 - 2 * v146;
#ifdef GLK
m144 = glk_window_open(0, 0, 0, wintype_TextBuffer, 1); if (!m144) { fprintf
(stderr, "Failed to open main window!\n"); exit (0); } glk_set_window (m144);
#endif
strncpy (x187, *argv, sizeof (x187) - 1); if (argc > 1) while (--argc) {
argv++; if (**argv != '-') { if (! j137) { if (*argv) j137 = *argv; continue;
} if (! o161) { strncpy (o161, *argv, sizeof (o161)); *(o161 + sizeof (o161)
- 1) = '\0'; e152 = 1; continue; } if (! h163) { h163 = *argv; continue;
} } b196 = *argv + 1; if (*b196 == 'j') { a154 = 1 - a154; continue; } else
if (*b196 == 'b') { a155 = 1 - a155; continue; } else if (*b196 == 'p')
{ b183 = 1 - b183; continue; } else if (*b196 == 'l') e152 = 1; else if
(*b196 == 'h') { printf ("\nUsage: %s [options]\n\nOptions:\n", y138); 
#ifndef GLK
printf ("    -w                  invert default wrap/justify setting\n");
printf ("    -b                  invert default setting for blank lines around prompt\n");
printf ("    -s <W>x<H>[-<M>]    set screen size and margin\n"); printf
("    -p                  invert default setting for pause before exiting\n");
#endif 
#ifdef o001
printf ("    -d <dbsdir>         specify dbs directory\n"); 
#endif 
printf ("   [-r] <dumpfile>      restore game from dump\n"); printf ("    -c <cominfile>      replay game from log\n");
printf ("    -l <logfile>        log the game\n"); 
#ifdef x005
if (d170 != -2) printf ("    -u {on|off|forbid}  override default UNDO status\n");
#endif 
printf ("    -h                  print this usage summary\n"); exit (0);
} if (--argc == 0) break; argv++; if (**argv == '-') { argv--; argc++; continue;
} v160 = *argv; switch (*b196) { case 's': o166 = strtol (v160, &d171, 10);
if (o166 == 0) o166 = 32767; if (o166 >= 16 && o166 <= 32767) u155 = o166;
if (*d171++) { o166 = strtol (d171, &d171, 10); if (o166 == 0) o166 = 32767;
if (o166 >= 16 && o166 <= 32767) x191 = o166; if (*d171++) { o166 = strtol
(d171, (char **)NULL, 10); if (o166 >= 0 && o166 < (u155 - 16 )/ 2) v146
= o166; } } w151 = u155 - 2 * v146; break; 
#ifdef o001
case 'd': m138 = v160; break; 
#endif 
case 'l': strncpy (o161, v160, sizeof (o161)); *(o161 + sizeof (o161) -
1) = '\0'; break; case 'c': h163 = v160; break; case 'r': if (*v160) j137
= v160; break; 
#ifdef x005
case 'u': if (d170 == -2) break; if (strcmp (v160, "off") == 0) d170 = -1;
else if (strcmp (v160, "forbid") == 0) d170 = -2; else if (strcmp (v160,
"on") == 0) d170 = 1; break; 
#endif 
#ifdef m004
case 'x': case 'y': t146 = *b196; strncpy (s165, v160, sizeof (s165)); if
(*o161 == '\0') strcpy (o161, "adv770.log"); break; 
#endif 
default: puts ("Bad args!"); exit (0); } } 
#ifdef READLINE
y127 = (char *)malloc(2 * w151 + 1); q150 = y127; 
#endif
#ifdef m004
if (t146) a155 = 1; 
#endif
if (m142 == 0) (void) time ((time_t *) &m142); e155 = m142 %= 32768L; (void)
u000 (1); if (f183 () != 0) { (void) printf ("Sorry, unable to set up the world.\n");
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
d003 [w005] = d003 [w004] = s007; 
#ifdef m004
if (t146 == 'x' && j137 && *j137) { q155 = j137; x000 (997, &d003 [0]);
q155 = ".C.adv"; } else if (t146 == 'y') x000 (999, &d003 [0]); else { if
(j137 && *j137) { g006(); d003 [r004] = -1; d003 [v006] = -1; q156 = 1;
i161[0] = j137; strncpy (c177, j137, m139); *(c177 + m139 - 1) = '\0'; }
else { if (setjmp (y000) == 0) g006 (); } } 
#else
if (j137 && *j137) { g006 (); d003 [r004] = -1; d003 [v006] = -1; strncpy
(c177, j137, m139); *(c177 + m139 - 1) = '\0'; } else { q156 = 0; i161 [0]
= NULL; if (setjmp (y000) == 0) g006 (); } 
#endif 
#ifdef x005
if (d170 == -2) v002 ('s', l004, e002); else if (d170 == 1) v002 ('s', l004,
h005); else if (d170 == -1) { v002 ('s', l004, h005); v002 ('s', l004, l005);
} 
#endif 
(void) setjmp (y000); if (t148) { if (b183) { y130 ("(To exit, press ENTER)");
#ifdef GLK
k170 (1); 
#else 
i167 (l141, 160); putchar ('\n'); 
#endif
} else { if (z133 > 0) k170 (1); putchar ('\n'); 
#ifndef READLINE
putchar ('\n'); 
#endif 
} k180 (); 
#ifdef GLK
glk_exit (); 
#else
return (255); 
#endif
} while (1) { e155 = m142; (void) u000 (1); m142 = e155; e155 = m142 ^ 255;
l009 (); } } 
#ifdef __STDC__
int n002 (int r000,int x002,int q001) 
#else
int n002 (r000,x002,q001) int r000; int x002; int q001; 
#endif
{ if (r000 > a004) return (0); if (e000 [r000] != i002) return (0); if (x002
< 0) return (1); if (x002 == 0) { if (d003 [r000] == q001) return (1); }
else if (m000 (r000, q001)) return (1); return (0); } 
#ifdef __STDC__
int g000 (int r000,int x002,int q001, int s003) 
#else
int g000 (r000,x002,q001,s003) int r000; int x002; int q001; int s003; 
#endif
{ if (r000 > a004) return (0); if (x002 != -1) { if (x002 == 0) { if (d003
[r000] != q001) return (0); } else if (!(m000 (r000, q001))) return (0);
} if (e000 [r000] == s003) return (1); 
#ifdef l007
if (s003 == i002 || !(m000 (r000, l007))) return (0); if (e000 [r000] +
1 == s003) return (1); 
#endif
return (0); } 
#ifdef __STDC__
int s002 (int r000,int x002,int q001) 
#else
int s002 (r000,x002,q001) int r000; int x002; int q001; 
#endif
{ return (g000 (r000, x002, q001, d003 [w004])); } 
#ifdef __STDC__
int a000 (int r000,int x002,int q001) 
#else
int a000 (r000,x002,q001) int r000; int x002; int q001; 
#endif
{ if (n002 (r000,x002,q001)) return (1); if (s002 (r000,x002,q001)) return
(1); return (0); } 
#if !defined(NOVARARGS) && defined(__STDC__)
void g001 (int d000, int v001, ...) { va_list c180; int k182; int b196;
va_start (c180, v001); if (v001 < 0) goto e168; k182 = 0; while (!k182)
{ if ((b196 = va_arg (c180, int)) < 0) { b196 = -b196; k182 = 1; } if (e003
(b196)) goto e168; } va_end (c180); return; e168: va_end (c180); 
#else 
#ifdef __STDC__
void g001 (int d000,int v001,int w000,int j002,int t002,int b197,int s177,int
y139, int q170,int q171,int d184,int u168,int l154,int o175,int v161,int
f185) 
#else
void g001 (d000,v001,w000,j002,t002,b197,s177,y139,q170,q171,d184,u168,l154,o175,v161,f185)
int d000,v001,w000,j002,t002,b197,s177,y139,q170,q171,d184,u168,l154,o175,v161,f185;
#endif
{ int b196; if (v001 < 0) goto e168; if ((b196 = w000) < 0) b196 = -b196;
if (e003 (b196)) goto e168; else if (w000 < 0) return; if ((b196 = j002)
< 0) b196 = -b196; if (e003 (b196)) goto e168; else if (j002 < 0) return;
if ((b196 = t002) < 0) b196 = -b196; if (e003 (b196)) goto e168; else if
(t002 < 0) return; if ((b196 = b197) < 0) b196 = -b196; if (e003 (b196))
goto e168; else if (b197 < 0) return; if ((b196 = s177) < 0) b196 = -b196;
if (e003 (b196)) goto e168; else if (s177 < 0) return; if ((b196 = y139)
< 0) b196 = -b196; if (e003 (b196)) goto e168; else if (y139 < 0) return;
if ((b196 = q170) < 0) b196 = -b196; if (e003 (b196)) goto e168; else if
(q170 < 0) return; if ((b196 = q171) < 0) b196 = -b196; if (e003 (b196))
goto e168; else if (q171 < 0) return; if ((b196 = d184) < 0) b196 = -b196;
if (e003 (b196)) goto e168; else if (d184 < 0) return; if ((b196 = u168)
< 0) b196 = -b196; if (e003 (b196)) goto e168; else if (u168 < 0) return;
if ((b196 = l154) < 0) b196 = -b196; if (e003 (b196)) goto e168; else if
(l154 < 0) return; if ((b196 = o175) < 0) b196 = -b196; if (e003 (b196))
goto e168; else if (o175 < 0) return; if ((b196 = v161) < 0) b196 = -b196;
if (e003 (b196)) goto e168; else if (v161 < 0) return; if ((b196 = f185)
< 0) b196 = -b196; if (e003 (b196)) goto e168; return; e168: 
#endif 
#if u005 >= 11
if (d003 [w005] != d003 [w004]) { *e156 = 3; *(e156 + 1) = 0; } 
#endif 
d003 [w005] = d003 [w004]; *h002 (w005) = -1; d003 [w004] = d000; *h002
(w004) = -1; 
#if defined (l008) && defined (r004)
v002 ('s', r004, l008); 
#endif 
if (v001 < -2) v001 = -v001; if (v001 > 0) k000 (0, v001, 0); if (v001 !=
-1) longjmp (y000, 1); return; } 
#ifdef __STDC__
void f000 (int r000,int x002) 
#else
void f000 (r000,x002) int r000,x002; 
#endif
{ 
#if defined (b003) && defined (r004)
if (e000 [r000] == i002 || x002 == i002) v002 ('s', r004, b003); 
#endif
e000 [r000] = (x002 <= c005 || x002 == i002) ? x002 : d003 [x002]; return;
} 
#ifdef __STDC__
void z000 (char o000, int n000, char l000, int s004, int *f001, short *j001)
#else
void z000 (o000, n000, l000, s004, f001, j001) int o000, n000, l000, s004;
int *f001; short *j001; 
#endif
{ int o166, d185, z146 = 0; if (l000 == 'e') { o166 = d003 [s004]; d185
= 0; } else if (l000 == 'c') { o166 = s004; d185 = 0; } else if (l000 ==
'v') { o166 = d003 [s004]; if (s004 == d006 || s004 == z003) d185 = -1;
else d185 = f002 [v005 * (s004 - w003)]; } else { o166 = f001 [s004]; d185
= j001 [v005 * s004]; } if (o000 == 'V') { d003 [n000] = o166; z146 = f002
[v005 * (n000 - w003)]; } else if (o000 == 'L') { f001 [n000] = o166; z146
= j001 [v005 * n000]; } else d003 [n000] = o166; if (o000 == 'V') { if (d185
== -1 && z146 != -1) f002 [v005 * (n000 - w003)] = -1; else if (d185 !=
-1 && z146 == -1) f002 [v005 * (n000 - w003)] = 0; } else if (o000 == 'L')
{ if (d185 == -1 && z146 != -1) j001 [v005 * n000] = -1; else if (d185 !=
-1 && z146 == -1) j001 [v005 * n000] = 0; } else if (o000 == 'T') { o166
= s159 [2 * (n000 - a005) + 1]; if (o166 <= d003 [n000]) d003 [n000] = o166
- 1; } } 
#ifdef __STDC__
void n001 (int r000, int x002) 
#else
void n001 (r000, x002) int r000,x002; 
#endif
{ d003 [r000] = x002; *h002 (r000) = -1; k168 [r000] = k168 [x002]; return;
} 
#ifdef __STDC__
void t000 (int r000, int x002) 
#else
void t000 (r000, x002) int r000,x002; 
#endif
{ d003 [r000] = d003 [d003 [x002]]; return; } 
#ifdef __STDC__
void h000 (int r000, int x002) 
#else
void h000 (r000, x002) int r000,x002; 
#endif
{ d003 [d003 [r000]] = (x002 > c006 || x002 < g003) ? x002 : d003 [x002];
return; } 
#ifdef __STDC__
void h001 (int r000, int x002) 
#else
void h001 (r000, x002) int r000,x002; 
#endif
{ d003 [r000] = e000 [(x002 < g003 || x002 > c006) ? x002 : d003 [x002]];
*h002 (r000) = -1; return; } 
#ifdef __STDC__
int t001 (int r000) 
#else
int t001 (r000) int r000; 
#endif
{ if (*h002 (r000) == -1) return d003 [r000]; else return r000; } 
#ifdef __STDC__
int c000 (int r000, int *x002, short *q001) 
#else
int c000 (r000, x002, q001) int r000; int *x002; short *q001; 
#endif
{ if (*(q001 + v005 * r000) == -1) return (*(x002 + r000)); else return
r000; } 
#ifdef __STDC__
void a001 (void) 
#else
void a001 () 
#endif
{ 
#if !defined(MEMORY) && !defined(e151)
(void) fclose (j136); 
#endif 
#ifdef v147
(void) printf ("\n(Locates: demanded %ld (+%ld), faults %ld (+%ld))\n",
l144, l144 - l145, q157, q157 - j141); (void) printf ("(Locate ratio %ld%%)\n",
(((1000 * q157) / l144) + 5) / 10); 
#endif 
t148 = 1; longjmp (y000, 1); } 
#ifdef __STDC__
short *h002 (int d000) 
#else
short *h002 (d000) int d000; 
#endif
{ short *y140; y140 = NULL; if (d000 <= a004) y140 = &b001 [w001 * (d000
- w002)]; else if (d000 <= c005) y140 = &i001 [e001 * (d000 - s007)]; else
if (d000 <= c006) y140 = &f002 [v005 * (d000 - w003)]; return (y140); }
#ifdef __STDC__
void v002 (char d000, int v001, int w000) 
#else
void v002 (d000, v001, w000) char d000; int v001; int w000; 
#endif
{ short *x207; if (v001 > c006) { printf ( "*** Run-time glitch! Setting flag on a flagless entity %d! ***\n",
v001); return; } x207 = h002 (v001); while (w000 > 15) { x207++; w000 -=
16; } if (d000 == 's') *x207 |= 1 << w000; else *x207 &= ~(1 << w000); return;
} 
#ifdef __STDC__
void d001 (int z001, char d000, int v001, int w000, int *j002, short *t002)
#else
void d001 (z001, d000, v001, w000, j002, t002) int z001; char d000; int
v001; int w000; int *j002; short *t002; 
#endif
{ short *x207; if (v001 < 0 || v001 >= z001) printf ( "*** Run-time glitch! Local entity %d >= locals %d! ***\n",
v001, z001); if (*(t002 + v005 * v001) == -1) x207 = h002 (*(j002 + v001));
else x207 = t002 + v005 * v001; while (w000 > 15) { x207++; w000 -= 16;
} if (d000 == 's') *x207 |= 1 << w000; else *x207 &= ~(1 << w000); return;
} 
#ifdef __STDC__
int m000 (int d000, int v001) 
#else
int m000 (d000, v001) int d000; int v001; 
#endif
{ short *x207; if (d000 > c006) return (0); if (d000 < g003 && d000 > m003)
return (v001 == a008); x207 = h002 (d000); if (x207 == NULL) return (0);
while (v001 > 15) { x207++; v001 -= 16; } return (*x207 & 1 << v001); }
#ifdef __STDC__
int i000 (int d000, int v001, int *w000, short *j002) 
#else
int i000 (d000, v001, w000, j002) int d000; int v001; int *w000; short *j002;
#endif
{ short *x207; if (*(j002 + v005 * d000) == -1) x207 = h002 (*(w000 + d000));
else x207 = j002 + v005 * d000; if (x207 == NULL) return (0); while (v001
> 15) { x207++; v001 -= 16; } return (*x207 & 1 << v001); } 
#ifdef __STDC__
void l002 (void) 
#else
void l002 () 
#endif
{ r003 = 0; i161 [q156] = NULL; return; } 
#ifdef __STDC__
void l138 (char *f176) 
#else
void l138 (f176) char *f176; 
#endif
{ if ((*f176 >= 'a' && *f176 < 'z') || (*f176 >= 'A' && *f176 < 'Z')) (*f176)++;
else if (*f176 == 'z' || *f176 == 'Z') *f176 -= 25; } 
#ifdef __STDC__
void n163 (char *f176, int s170) 
#else
void n163 (f176, s170) char *f176; int s170; 
#endif
{ char *z147 = f176; while (s170-- && *f176) { if ((*f176 > 'a' && *f176
<= 'z') || (*f176 > 'A' && *f176 <= 'Z')) (*f176)--; else if (*f176 == 'a'
|| *f176 == 'A') *f176 += 25; f176++; } if (i158) fprintf (i158, "TRANSLATION: %s\n",
z147); } 
#ifdef __STDC__
void v004 (int s006, int t003) 
#else
void v004 (s006, t003) int s006; int t003; 
#endif
{ s159 [2 * (s006 - a005)] = g179; d003 [s006] = t003; } 
#ifdef __STDC__
void d186 (int type, int *x001) 
#else
void d186 (type, x001) int type; int *x001; 
#endif
{ time_t r175; struct tm *i161; switch (type) { case 4: case 5: r175 = time
(NULL); i161 = localtime (&r175); *x001 = (type == 4 ? i161 -> tm_hour :
i161 -> tm_min); break; default: (void) f173 ("GLITCH! Bad svar code: %d\n",
type); } return; } 
#ifdef __STDC__
void n003 (void) 
#else
void n003(); 
#endif
{ while (*(x193 - 1) == '\n') x193--; } 
#ifdef __STDC__
void x004 (int t159) 
#else
void x004(t159); int t159; 
#endif
{ if (t159 == d006) strncpy (m141, i161 [q156 - 1], m139); else if (t159
== z003 && d003 [r004] == 2) strncpy (c177, i161 [q156 - 1], m139); else
if (t159 != z003) { (void) f173 ("GLITCH! Bad ARGn indicator: %d\n", t159);
} } 
#ifdef __STDC__
int l003 (char *type) 
#else
int l003 (type); char *type; 
#endif
{ if (strcmp(type, "cgi") == 0) 
#ifdef m004
return (t146); 
#else
return (0); 
#endif
if (strcmp(type, "doall") == 0) return (r003); (void) f173 ("GLITCH! Bad test type: %s\n",
type); return (0); } 
#ifdef x005
#ifdef __STDC__
int t160 (void) 
#else
int t160 () 
#endif
{ char *a; int o166 = 0; v002 ('c', l004, l006); v002 ('c', l004, o002);
v002 ('c', l004, d007); 
#ifdef r002
if (d003 [z003] == r002) o166 = 32767; else if (d003[r004] > 1) 
#else
if (d003[r004] > 1) 
#endif
{ a = c177; while (*a) { if (*a < '0' || *a >'9') { v002 ('s', l004, l006);
return (-1); } o166 = 10 * o166 + *a++ - '0'; } } else o166 = 1; return
(o166); } 
#ifdef __STDC__
int m154 (int y141) 
#else
int m154 (y141) int y141; 
#endif
{ int i; if (y141 == 0) { memcpy (q153, e000, b177 * sizeof(int)); return
(0); } for (i = 0; i <= a004; i++) { if ((q153[i] == i002 && e000[i] !=
i002) || (q153[i] != i002 && e000[i] == i002)) return (1); } return (0);
} 
#ifdef __STDC__
void a003 (void) 
#else
void a003 () 
#endif
{ int c178; int n177; if ((c178 = t160 ()) < 0) return; if (t144 == 0 ||
b178 <= l140 + 4) n177 = 0; else { (void) m154 (0); for (n177 = 0; n177
< c178; n177++) { if (b178 <= l140 + 4) break; b178 -= 4; while (b178 >
l140) { int y140; b178 -= 4; y140 = 256 * (*b178) + *(b178 + 1); if (y140)
*(q152 + y140) = *(b178 + 2); else break; } b178 += 4; } v002 (m154 (1)
? 's' : 'c', l004, d007); } d003 [l004] = n177; 
#ifdef r002
if (d003 [z003] == r002) c178 = n177; 
#endif
v002 (c178 > n177 ? 's' : 'c', l004, o002); return; } 
#ifdef __STDC__
void k001 (void) 
#else
void k001 () 
#endif
{ int n177; int c178; if ((c178 = t160 ()) < 0) return; if (b178 == j138)
n177 = 0; else { (void) m154 (0); for (n177 = 0; n177 < c178; n177++) {
if (b178 > j138) b178 = j138; while (1) { int y140 = 256 * (*b178) + *(b178
+ 1); b178 += 4; if (y140) *(q152 + y140) = *(b178 - 1); else break; } if
(b178 == j138) { n177++; break; } } v002 (m154 (1) ? 's' : 'c', l004, d007);
} d003 [l004] = n177; 
#ifdef r002
if (d003 [z003] == r002) c178 = n177; 
#endif
v002 (c178 > n177 ? 's' : 'c', l004, o002); } 
#endif 

