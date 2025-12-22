/*
*	@(#)zmachine.c	2.24
*/

# include "zmachine.h"
#ifdef AMIGA
#include <intuition/intuition.h>
#include <dos/dosextens.h>
#include <dos/dostags.h>
#include <exec/memory.h>

#include <clib/exec_protos.h>
#include <clib/dos_protos.h>

enum	{	ARG_PROTOCOL,ARG_WIDTH,ARG_STORY,ARG_RESTORE,ARG_CUSTOMSCREEN,ARG_COLOUR0,ARG_COLOUR1,ARGCOUNT };

extern struct DosLibrary	*DOSBase;
extern UWORD			 TwoColours[2];

UBYTE				*ProgramName = NULL;
BPTR				 StdOut;

#define TRACE

#define printf DPrintf

#endif

#define div foo

#include <string.h>
#include <stdlib.h>

#undef div

#if defined(AMIGA) && defined(AZTEC_C)

short			getanyop(int d0);
short			getvarorsp(int d0);
short			getvar(int d0);
void			putvarorsp(int d0, int d1);
void			putsomewhere(int d0);
void			putsomewhereb(int d0);
void			jump(int d1);
unsigned char 		*objectp(int d0);
unsigned char 		*firstprop(unsigned char *a0);
unsigned char 		*nextprop(unsigned char *a0);
void			illegal(void);
void			ret_1(void);
void			ret_0(void);
void			print_im(void);
void			printcr_im(void);
void			nop(void);
void			save_g(void);
int			save_gf(char *p);
void			restore_g(void);
int			restore_gf(char *p);
void			restart_g(void);
void			ret_sp(void);
void			inc_sp(void);
void			halt(void);
void			newline(void);
void			status(void);
void			verify(void);
void			bne(int d0);
void			nextinv(int d0);
void			firstinv(int d0);
void			environment(int d0);
void			l11a7e(int d0);
void			incr(int d0);
void			decr(int d0);
void			print_near(int d0);
void			destructobj(int d1);
void			objshort(int d0);
void			ret(int d0);
void			bra(int d0);
void			print_far(int d0);
void			mov(int d0);
void			not(int d0);
void			sound(int d0,int d1,int d2);
void			bifnotoneof(short *a0);
void			cbge(int d0, int d1);
void			cble(int d0, int d1);
void			dcbge(int d0, int d1);
void			icble(int d0, int d1);
void			bnotcontent(int d0, int d1);
void			bifthen(int d0, int d1);
void			or(int d0, int d1);
void			and(int d0, int d1);
void			tstbit_jz(int d0, int d1);
void			setbit(int d0, int d1);
void			clrbit(int d0, int d1);
void			store(int d0, int d1);
void			moveobj(int d0, int d1);
void			getarrayw(int d0, int d1);
void			getarrayb(int d0, int d1);
void			querypropn(int d0, int d1);
void			getpropnaddr(int d0, int d1);
void			nextpropn(int d0, int d1);
void			add(int d0, int d1);
void			sub(int d0, int d1);
void			mul(int d0, int d1);
void			div(int d0, int d1);
void			mod(int d0, int d1);
void			call(short *a0);
void			putarrayw(int d0, int d1, int d2);
void			putarrayb(int d0, int d1, int d2);
void			setpropn(int d0, int d1, int d2);
unsigned short		findword(unsigned short *a0);
char			*wordend(int c);
void			input(short *a0);
void			print_char(int d0);
void			write_num(int d0);
void			rnd(int d0);
void			push(int d0);
void			pop(int d0);
void			setstatuslen(int d0);
void			gotopos(int d0);
void			run(void);
void			no_mem_error(void);
void			main(int argc, char **argv);

#endif

char *story_name;
struct dev *printer;

jmp_buf restart_buf;

/************************************************************************/
int release;
int status_type;

UBYTE *ff0;
UBYTE *fec;
char *terms, *my_terms;		/* word terminators		*/
UBYTE *first_word, *last_word;
UWORD word_len, word_num;

char *line;			/* line buffer during status	*/
int use_line = 0;		/* line output			*/
UWORD *stack, *framep, *sp;	/* stack management		*/

#ifdef DEBUG
UWORD ops_ix = 0;
struct {
	UBYTE c_op;
	struct address c_pc;
	UWORD c_sp;
	UWORD c_fp;
} ops[256];
#endif

UBYTE *short_cuts;
int save_len;
int status_len;			/* number of status lines	*/

int line_cnt;

int in_status = 1;

/************************************************************************/

WORD getanyop(d0)
register WORD d0;
{
	WORD getvar();
	WORD op;

	if (--d0 < 0) {
		op = fetchw_op();
#ifdef TRACE
		printf("#%04lx.W ",op);
#endif
		return(op);
		}
	else if (d0 == 0) {
		op = fetchb_op();
#ifdef TRACE
		printf("#%02lx.B ",op);
#endif
		return(op);
		}
	else if ((d0 = fetchb_op()) != 0)
		return(getvar(d0));
	else {
#ifdef TRACE
		printf("(SP)+ ");
#endif
		return((WORD)*(sp++));
		}
}

WORD getvarorsp(d0)
WORD d0;
{
	WORD getvar();

	if (!d0)
		{
#ifdef TRACE
		printf("(SP) ");
#endif
		return((WORD)*sp);
		}
	else
		return(getvar(d0));
}

WORD getvar(d0)
WORD d0;
{
	if (d0 < 0x10) {
#ifdef TRACE
		printf("v[%lx] ", d0);
#endif
		return((WORD)framep[- d0 + 1]);
		}
	else {
#ifdef TRACE
		printf("V[%lx] ", d0-0x10);
#endif
		return((WORD)word_get(&fec[(d0 - 0x10)*2]));
		}
}

void putvarorsp(d0, d1)
WORD d0, d1;
{
	if (!d0) {
#ifdef TRACE
		printf("->(SP) ");
#endif
		*sp = d1;
		}
	else
		if (d0 < 0x10) {
#ifdef TRACE
			printf("->v[%lx] ", d0);
#endif
			framep[- d0 + 1] = d1;
			}
		else {
			word_put(&fec[(d0 - 0x10)*2], d1);
#ifdef TRACE
			printf("->V[%lx] ", d0-0x10);
#endif
			}
}

void putsomewhere(d0)
WORD d0;
{
	WORD d1;

	if (d1 = fetchb_op())
		putvarorsp(d1, d0);
	else {
#ifdef TRACE
		printf("->-(SP) ");
#endif
		*(--sp) = d0;
		}
}

void putsomewhereb(d0)
WORD d0;
{
	putsomewhere(d0 & 0xff);
}

#ifdef DEBUG
void zcore_dump()
{
	int i, ix;
	FILE *fp;

	fp = fopen("zcore", "w");
	if (!fp)
		fp = stderr;

	fprintf(fp, "sp = %04lx  fp = %04lx\n", sp-stack, framep-stack);

	fprintf(fp, "Stack:");
	for (i = 0; i < 256; i++)
	{
		if (!(i % 8))
			fprintf(fp, "\n%04lx: ", i);

		fprintf(fp, "%04lx ", stack[i]);
	}

	fprintf(fp, "\nLast instructions(fp:sp:addr:op):\n");
	for (i = 256; i; i--)
	{
		ix = (ops_ix++ & 0xff);
		if (!(i % 4))
			fprintf(fp, "\n");

		fprintf(fp, "%02lx:%02lx:%05lx:%02lx ", ops[ix].c_fp, ops[ix].c_sp,
		(long)ops[ix].c_pc.offset|((long)ops[ix].c_pc.segment<<9),
		ops[ix].c_op);
	}
	fprintf(fp, "\n");
	unlink("zcore.save");
	save_gf("zcore.save");
}
#endif

/************************************************************************/
/*				op-codes				*/

/************************************************************************/
/*			op-code utilities				*/

# define dojmp()	jump(0)
# define dontjmp()	jump(1)

void jump(d1)
register WORD d1;
{
	register WORD d0;
	void ret_0(), ret_1();

	d0 = fetchb_op();
	if(d0 & 0x80)
		d1++;

	d0 &= ~0x80;

	if (!(d0 & 0x40))
	{
		d0 &= ~0x40;
		d0 <<= 8;
		d0 |= fetchb_op();
		if (d0 & 0x2000)
			d0 |= ~0x3fff;
	}
	else
		d0 &= ~0x40;

	if (--d1)
	{
		if (!d0)
			ret_0();
		else if (!(--d0))
			ret_1();
		else
		{
			pc.offset += (d0 - 1);
			load_code();
		}
	}
}

UBYTE *objectp(d0)
WORD d0;
{
	return(ff0+9*d0+0x35);
}

UBYTE *firstprop(a0)
UBYTE *a0;
{
	register UBYTE *p;
	register WORD d;

	p = main_p + word_get(a0+7);
	d = *(p++)*2;
	return(p + d);
}

UBYTE *nextprop(a0)
UBYTE *a0;
{
	register WORD d;

	d = (*(a0++)>>5) + 1;
	return(a0 + d);
}

void illegal()
{
#ifdef DEBUG
	zcore_dump();
#endif
	fatal("Bad operation", story_name);
}

/************************************************************************/
/*				class 0					*/

void ret_1()
{
	void ret();
	ret(1);
}

void ret_0()
{
	void ret();
	ret(0);
}

void print_im()
{
#ifdef TRACE
	printf("{\"");
	pdecode(&pc);
	printf("\"} ");
#endif
	decode(&pc);
	load_code();
}

void printcr_im()
{
	void newline();
	print_im();
	newline();
	ret_1();
}

void nop()
{
}

void save_g()
{
	char *name;
	int save_gf();

	if (!(name = read_sname()))
		dojmp();
	else
	{
#ifdef AMIGA
		AdjustTitle(FilePart((UBYTE *)name));
#endif	/* AMIGA */
		jump(save_gf(name));
	}
}

int save_gf(p)
char *p;
{
	extern char *iovers;
	UWORD *csp;

	if (open_save_w(p))
		return(0);

	csp = sp;
	*(--sp) = pc.segment;
	*(--sp) = pc.offset;
#ifdef GEMDOS
	/* sorry, its awful but compatibel to infocom's interpreter */
	*(--((long *)sp)) = (UBYTE *)framep - (UBYTE *)stack;
	*(--sp) = release;
	*(((long *)stack)) = (UBYTE *)sp - (UBYTE *)stack;
	*(stack + sizeof(long)/sizeof(UWORD)) = atoi(iovers);
#else
	*(--sp) = framep - stack;
	*(--sp) = release;
	*stack = sp - stack;
	*(stack + 1) = atoi(iovers);
#endif
	sp = csp;

	if (write_save(0, 1, stack))
		return(0);

	if (write_save(1, save_len, main_p))
		return(0);

	if (save_keys())
		return(0);

	if (close_save())
		return(0);
#ifdef AMIGA
	saveicon(p);
#endif
	return(1);
}

void restore_g()
{
	char *name;
	int restore_gf();

	if (!(name = read_rname()))
		dojmp();
	else
	{
#ifdef AMIGA
		AdjustTitle(FilePart((UBYTE *)name));
#endif	/* AMIGA */
		jump(restore_gf(name));
	}
}

int restore_gf(p)
char *p;
{
	extern char *iovers;
	int sv;

	if (open_save_r(p))
		return(0);

	if (read_save(0, 1, stack))
		fatal("Save file read error", p);

#ifdef GEMDOS
	sp = (UWORD *)((UBYTE *)stack + *((long *)stack));
#else
	sp = stack + *stack;
#endif

	if (*sp++ != release)
		fatal("Wrong save file version", p);

#ifdef GEMDOS
	framep = (UBYTE *)stack + *(((long *)sp)++);
#else
	framep = stack + *sp++;
#endif
	pc.offset = *(sp++);
	pc.segment = *(sp++);

	sv = word_get(main_h->reserved5);
	if (read_save(1, save_len, main_p))
		fatal("Save file read error", p);
	word_put(main_h->reserved5, sv);

#ifdef GEMDOS
	if (*(stack + sizeof(long)/sizeof(UWORD)) == atoi(iovers))
#else
	if (*(stack + 1) == atoi(iovers))
#endif
		if (restore_keys())
			fatal("Save file read error", p);

	close_save();
	load_code();

	return(1);
}

void restart_g()
{
	line_cnt = 0;
	output_chr('\n');
	longjmp(restart_buf,1);
}

void ret_sp()
{
	void ret();
	ret(*(sp++));
}

void inc_sp()
{
	sp++;
}

void halt()
{
	clean_up();
	exit(userexit(0));
}

void newline()
{
	output_chr('\n');
}

void status()
{
	char	room[256];
	char	*score;
	char	am_pm;
	int	hour;

	void	write_num();
	void	objshort();

	use_line = 1;
	line = room;

	*line++ = ' ';
	objshort(getvarorsp(0x10));
	*(line++) = '\0';
	score = line;
	if (!status_type)
	{
		strcpy(line, "Score: ");
		write_num(getvarorsp(0x11));
		*line++ = '/';
		write_num(getvarorsp(0x12));
	}
	else
	{
		if ((hour = getvarorsp(0x11)) > 12)
		{
			hour -= 12;
			am_pm = 'p';
		}
		else
			am_pm = 'a';

		if (hour == 0)
			hour = 12;

		strcpy(line, "Time: ");
		line += strlen(line);
		if (hour < 10)
			*line++ = ' ';
		write_num(hour);
		*line++ = ':';
		if (getvarorsp(0x12) < 10)
			*line++ = '0';
		write_num(getvarorsp(0x12));
		*line++ = ' ';
		*line++ = am_pm;
		*line++ = 'm';
	}
	*line++ = ' ';
	*line++ = '\0';
	output_status(room, score);
	use_line = 0;
}

void verify()
{
	struct address a, end;
	int m_len;
	long sum;

	output_str("Z-Code 3 interpreter V2.24 for ");
	output_str(sysname);
	output_str("\n");

	m_len = main_l;
	main_l = 0;

	a.segment = 0;
	a.offset = 0x40;
	sum = 0;
	waddr_to_vaddr(&end, word_get(main_h->len));

	while(a.segment != end.segment || a.offset != end.offset)
		sum += fetchb_data(&a);

	main_l = m_len;

	jump((UWORD)sum == word_get(main_h->checksum));
}

/************************************************************************/
/*				class 1					*/

/* for tracing purpose: pdecode prints a decoded string to stdout */

#ifdef TRACE
void pobjshort(d0)
WORD d0;
{
	struct address a;

	if (d0) {
		baddr_to_vaddr(&a, word_get(objectp(d0)+7) + 1);
		pdecode(&a);
		}
	else
		printf("NULL");
}
#endif

void bne(d0)
WORD d0;
{
#ifdef TRACE
	printf("{%lx} ",d0);
#endif
	if(d0)
		dojmp();
	else
		dontjmp();
}

void nextinv(d0)
WORD d0;
{
	register UBYTE d1;

#ifdef TRACE
	printf("{OBJ(");
	pobjshort(d0);
	printf(")->OBJ(");
	pobjshort(objectp(d0)[5]);
	printf(")} ");
#endif
	putsomewhere(d1 = objectp(d0)[5]);

	if (d1)
		dontjmp();
	else
		dojmp();
}

void firstinv(d0)
WORD d0;
{
	register UBYTE d1;

#ifdef TRACE
	printf("{OBJ(");
	pobjshort(d0);
	printf(")->OBJ(");
	pobjshort(objectp(d0)[6]);
	printf(")} ");
#endif
	putsomewhere(d1 = objectp(d0)[6]);

	if (d1)
		dontjmp();
	else
		dojmp();
}

void environment(d0)
WORD d0;
{
#ifdef TRACE
	printf("{OBJ(");
	pobjshort(d0);
	printf(")->OBJ(");
	pobjshort(objectp(d0)[4]);
	printf(")} ");
#endif TRACE
	putsomewhere(objectp(d0)[4]);
}

void l11a7e(d0)
WORD d0;
{
	putsomewhere((main_p[d0-1]>>5)+1);
}

void incr(d0)
WORD d0;
{
	putvarorsp(d0,getvarorsp(d0)+1);
}

void decr(d0)
WORD d0;
{
	putvarorsp(d0,getvarorsp(d0)-1);
}

void print_near(d0)
WORD d0;
{
	struct address a;
	baddr_to_vaddr(&a,d0);
	decode(&a);
}

void destructobj(d1)
WORD d1;
{
	register UBYTE *a0, *a1;
	register UWORD d0;

#ifdef TRACE
	printf("{OBJ(");
	pobjshort(d1);
	printf(")} ");
#endif

	a1 = objectp(d1);
	if (d0 = a1[4])
	{
		d0 = (a0 = objectp(d0))[6];
		if (d1 == d0)
			a0[6] = a1[5];
		else
		{
			while ((d0 = (a0 = objectp(d0))[5]) != d1)
				;
			a0[5] = a1[5];
		}
		a1[4] = a1[5] = 0;
	}
}

void objshort(d0)
WORD d0;
{
	struct address a;

#ifdef TRACE
	printf("{OBJ(");
	pobjshort(d0);
	printf(")} ");
#endif

	baddr_to_vaddr(&a, word_get(objectp(d0)+7) + 1);
	decode(&a);
}

void ret(d0)
WORD d0;
{
	sp = framep + 1;
#ifdef GEMDOS
	framep = (UBYTE *)stack + *(((long *)sp)++);
#else
	framep = stack + *sp++;
#endif
	pc.offset = *(sp++);
	pc.segment = *(sp++);
	load_code();
	putsomewhere(d0);
}

void bra(d0)
WORD d0;
{
	pc.offset += (d0 - 2);
	load_code();
}

void print_far(d0)
WORD d0;
{
	struct address a;
	waddr_to_vaddr(&a, d0);
	decode(&a);
}

void mov(d0)
WORD d0;
{
	putsomewhere(getvarorsp(d0));
}

void not(d0)
WORD d0;
{
	putsomewhere(~d0);
}

/************************************************************************/
/*				class 2					*/

void
sound(d0,d1,d2)
int d0,d1,d2;
{
	PlaySound(d0,d2);

	/* d0 -> Soundnummer */
	/* d1 -> Flags? */
	/* d2 -> Lautstärke (0 .. 8) */
}

void bifnotoneof(a0)
register WORD *a0;
{
	register WORD d0, d1;

	d1 = *(a0++) - 1;
	d0 = *(a0++);

	for(;;)
		if(*(a0++) == d0)
		{
			dontjmp();
			break;
		}
		else if (!--d1)
		{
			dojmp();
			break;
		}
}

void cbge(d0, d1)
WORD d0, d1;
{
	jump(d0 < d1);
}

void cble(d0, d1)
WORD d0, d1;
{
	jump(d0 > d1);
}

void dcbge(d0, d1)		/* decrement, compare and jump greater equal */
WORD d0, d1;			/* dcbge */
{
	register WORD d2;

	d2 = getvarorsp(d0) - 1;
	putvarorsp(d0,d2);
	if (d2 < d1)
		dontjmp();
	else
		dojmp();
}

void icble(d0, d1)		/* increment, compare and jump less equal */
WORD d0, d1;			/* icble */
{
	register WORD d2;

	d2 = getvarorsp(d0) + 1;
	putvarorsp(d0,d2);
	if (d2 > d1)
		dontjmp();
	else
		dojmp();
}

void bnotcontent(d0, d1)	/* branch if d0 is not contained in d1 */
WORD d0, d1;
{
#ifdef TRACE
	printf("{OBJ(");
	pobjshort(d0);
	printf(")<OBJ(");
	pobjshort(d1);
	printf(")?->%lx} ",objectp(d0)[4]==d1);
#endif

	if (objectp(d0)[4] == d1)
		dontjmp();
	else
		dojmp();
}

void bifthen(d0, d1)
WORD d0, d1;
{
	jump((d1 & ~d0) == 0);
}

void or(d0, d1)
WORD d0, d1;
{
	putsomewhere(d0 | d1);
}

void and(d0, d1)
{
	putsomewhere(d0 & d1);
}

#define tst(a0, d0)	(a0[d0 >> 3] & (1<<((~d0)&7)))
#define clr(a0, d0)	(a0[d0 >> 3] &= ~(1<<((~d0)&7)))
#define set(a0, d0)	(a0[d0 >> 3] |= (1<<((~d0)&7)))
/* these are bits in an object */

void tstbit_jz(d0, d1)
WORD d0, d1;
{
#ifdef TRACE
	printf("{OBJ(");
	pobjshort(d0);
	printf(").%lx->%lx} ",d1,tst(objectp(d0), d1));
#endif

	if (tst(objectp(d0), d1))
		dontjmp();
	else
		dojmp();
}

void setbit(d0, d1)
WORD d0, d1;
{
#ifdef TRACE
	printf("{OBJ(");
	pobjshort(d0);
	printf(").%lx=1} ",d1);
#endif

	set(objectp(d0), d1);
}

void clrbit(d0, d1)
WORD d0, d1;
{
#ifdef TRACE
	printf("{OBJ(");
	pobjshort(d0);
	printf(").%lx=0} ",d1);
#endif

	clr(objectp(d0), d1);
}

void store(d0, d1)
WORD d0, d1;
{
	putvarorsp(d0, d1);
}

void moveobj(d0, d1)
WORD d0, d1;
{
	register UBYTE *a0, *a1;
	void destructobj();

#ifdef TRACE
	printf("{OBJ(");
	pobjshort(d0);
	printf(")->OBJ(");
	pobjshort(d1);
	printf(")} ");
#endif

	destructobj(d0);
	a1 = objectp(d1);
	a0 = objectp(d0);

	a0[5] = a1[6];
	a0[4] = d1;
	a1[6] = d0;
}

void getarrayw(d0, d1)
WORD d0, d1;
{
	struct address a;
	baddr_to_vaddr(&a, d0 + d1 * 2);
	putsomewhere(fetchw_data(&a));
}

void getarrayb(d0, d1)
WORD d0, d1;
{
	struct address a;
	baddr_to_vaddr(&a, d0 + d1);
	putsomewhereb(fetchb_data(&a));
}

void querypropn(d0, d1)
register WORD d0, d1;
{
	register UBYTE *a0;

#ifdef TRACE
	printf("{OBJ(");
	pobjshort(d0);
	printf(")::%lx->",d1);
#endif

	for (a0 = firstprop(objectp(d0)); d1 < (d0 = *a0 & 0x1f); a0 = nextprop(a0))
		;

	if (d1 == d0)
	{
		if (!(*(a0++) & 0x20)) {
#ifdef TRACE
			printf("%02lx.B} ",*a0);
#endif
			putsomewhereb(*a0);
			}
		else {
#ifdef TRACE
			printf("%04lx.W} ",word_get(a0));
#endif
			putsomewhere(word_get(a0));
			}
	}
	else
		{
#ifdef TRACE
		printf("%04lx.I} ",word_get(&ff0[(d1-1) * 2]));
#endif
		putsomewhere(word_get(&ff0[(d1-1) * 2]));
		}

}

void getpropnaddr(d0, d1)
register WORD d0, d1;
{
	register UBYTE *a0;

#ifdef TRACE
	printf("{OBJ(");
	pobjshort(d0);
	printf(")::%lx}",d1);
#endif

	for (a0 = firstprop(objectp(d0)); d1 < (d0 = *a0 & 0x1f); a0 = nextprop(a0))
		;

	if (d1 != d0)
		putsomewhere(0);
	else
		putsomewhere(++a0 - main_p);
}

void nextpropn(d0, d1)
register WORD d0, d1;
{
	register UBYTE *a0;

#ifdef TRACE
	printf("{OBJ(");
	pobjshort(d0);
	printf(")::%lx}",d1);
#endif

	a0 = firstprop(objectp(d0));

	if (d1)
	{
		for(;  d1 < (d0 = *a0 & 0x1f); a0 = nextprop(a0))
			;
		if (d1 != d0)
			fatal("Non-existant next property", story_name);
		else
			a0 = nextprop(a0);
	}
	putsomewhere(*a0 & 0x1f);
}

void add(d0, d1)
WORD d0, d1;
{
	putsomewhere(d0 + d1);
}

void sub(d0, d1)
WORD d0, d1;
{
	putsomewhere(d0 - d1);
}

void mul(d0, d1)
WORD d0, d1;
{
	putsomewhere(d0 * d1);
}

void div(d0, d1)
WORD d0, d1;
{
	putsomewhere(d0 / d1);
}

void mod(d0, d1)
WORD d0, d1;
{
	putsomewhere(d0 % d1);
}

void call(a0)
register WORD *a0;
{
	register WORD d0, d1, d2;

	d2 = *(a0++);
	if ((d0 = *(a0++)) == 0)
		putsomewhere(0);
	else
	{
		d2--;
		*(--sp) = pc.segment;
		*(--sp) = pc.offset;
#ifdef GEMDOS
		*(--((long *)sp)) = (UBYTE *)framep - (UBYTE *)stack;
#else
		*(--sp) = framep - stack;
#endif
		waddr_to_vaddr(&pc,d0);
		load_code();
		framep = sp - 1;
		if (d1 = fetchb_op())
		{
			do
			{
				d0 = fetchw_op();
				if (--d2 >= 0)
					d0 = *(a0++);
				*(--sp) = d0;
			}
			while (--d1 > 0);
		}
	}
}

void putarrayw(d0, d1, d2)
WORD d0, d1, d2;
{
	word_put(&main_p[d0 + d1 * 2], d2);
}


void putarrayb(d0, d1, d2)
WORD d0, d1; WORD d2;
{
	main_p[d0+d1] = (UBYTE)d2;
}

void setpropn(d0, d1, d2)
register WORD d0, d1; WORD d2;
{
	register UBYTE *a0;

#ifdef TRACE
	printf("{OBJ(");
	pobjshort(d0);
	printf(")::%lx=",d1);
#endif

	for (a0 = firstprop(objectp(d0)); d1 < (d0 = *a0 & 0x1f); a0 = nextprop(a0))
		;

	if (d1 != d0)
		fatal("Non-existant put property", story_name);

	if (*(a0++) & 0x20) {
#ifdef TRACE
		printf("%04lx.W} ",d2);
#endif
		word_put(a0, d2);
		}
	else {
#ifdef TRACE
		printf("%02lx.B} ",d2);
#endif
		*a0 = d2;
		}
}

UWORD findword(a0)
UWORD *a0;
{
	register UWORD d0, step, code0, code1;
	register UBYTE *word;

	d0 = word_num;
	step = word_len;

	code0 = *a0;
	code1 = *(a0+1);

	for ( d0 >>= 1, step <<= 1; d0 >>= 1; step <<= 1)
		;

	word = &first_word[step - word_len];

	do
	{
		step >>= 1;
		d0 = word_get(word);
		if (code0 <= d0)
		{
			if (code0 != d0)
				word -= step;
			else
			{
				d0 = word_get(word+2);
				if (code1 <= d0)
				{
					if (code1 != d0)
						word -= step;
					else
						return(word - main_p);
				}
				else
				{
					word += step;
					if (last_word < word)
						word = last_word;
				}
			}
		}
		else
		{
			word += step;
			if (last_word < word)
				word = last_word;
		}
	}
	while(word_len <= step);
	return(0);
}

char *wordend(c)
register char c;
{
	register char *p;

	for(p = terms; *p; p++)
		if (*p == c)
			return (p);
	return(NULL);
}

void no_mem_error()
{
	fatal("Out of memory", NULL);
}

void input(a0)
WORD *a0;
{
	char c;
	char *inp;		/* input field				*/
	char *end;		/* end of input line			*/
	UBYTE *out;		/* output field				*/
	UBYTE *outp;		/* pointer into output field		*/
	char src_word[8];	/* source word				*/
	UWORD dst_word[4];	/* word coded in z-code			*/
	register char *lp;	/* pointer into line			*/
	register char *cp;	/* pointer into src_word		*/
	char *ws;		/* pointer into line (start of line)	*/
	register int wc;	/* word count				*/
	register char *p;	/* scratch				*/
	static struct hist_buf history = {I_HIST_LEN, NULL, NULL};
				/* history buffer			*/

	if (!history.hb)
	{
		if (!(history.undo = history.hb = (char *)malloc(history.len)))
			no_mem_error();
		else
			history.hb[0] = history.hb[1] = '\0';
	}

	inp = (char *)&main_p[a0[1]];
	out = &main_p[a0[2]];

	status();
	output_chr(FLUSH);

	end = read_str(inp, &history);

	lp = inp + 1;
	outp = out + 2;
	wc = 0;

	for(;;)
	{
		cp = src_word;
		ws = lp;
		while (lp < end)
		{
			if (p = wordend(c = *lp++))
				break;
			else
				if (cp < src_word + 6)
					*cp++ = c;
		}

		if (lp < end)
		{
			if (cp != src_word)
				lp--;
			else if (p < my_terms)
				*cp++ = c;
			else
				continue;
		}
		else
		{
			if (src_word == cp)
				break;
		}

		if (++wc >= out[0])
		{
			output_chr('\n');
			output_str("too many words for internal buffer\n");
			out[1] = 0;
			return;
		}

		outp[2] = (char)(lp - ws);
		outp[3] = (char)(ws - inp);
		*cp = '\0';
		encode(dst_word, src_word);
		word_put(outp, findword(dst_word));
		outp += 4;
	}
	out[1] = wc;

	if (word_get(main_h->reserved5) & 1)
	{
		for (p = inp; *++p; )
			putc_dev(*p, printer);
		putc_dev('\n', printer);
	}
}

void print_char(d0)
WORD d0;
{
#ifdef TRACE
	printf("{'%lc'} ",d0);
#endif
	output_chr(d0);
}

void write_num(d0)
WORD d0;
{
	char buf[16];
	register char *p;
	int flag;

	flag = 0;
	if (d0 < 0)
	{
		flag = 1;
		d0 = -d0;
	}

	p = buf + 15;
	*p = '\0';
	do
		*--p = d0 % 10 + '0';
	while(d0 /= 10);

	if (flag)
		*--p = '-';

#ifdef TRACE
	printf("{%ls} ",p);
#endif
	output_str(p);
}

void rnd(d0)
WORD d0;
{
	extern long zrandom();
/*
	static UWORD rnd0 = 0xffff, rnd1 = 0;
	register long d1;

	if (rnd0 == 0xffff)
	{
		d1 = Random();
		rnd0 = d1 >> 16;
		rnd1 = d1;
	}

	d1 = rnd0;
	d1 |= (rnd0 = rnd1) << 16;
	d1 >>= 1;
	d1 = (rnd1 ^= d1);
	d1 &= 0x7fff;
	putsomewhere(((UWORD)d1 % d0) + 1);
*/
	putsomewhere((((UWORD)zrandom() & (UWORD)0x7fff) % d0) + 1);
}

void push(d0)
WORD d0;
{
	*(--sp) = d0;
}

void pop(d0)
WORD d0;
{
	putvarorsp(d0, *(sp++));
}

void setstatuslen(d0)
WORD d0;
{
	status_len = d0;
}

void gotopos(d0)
WORD d0;
{
	static int x,y;

	if (d0 == 0)
	{
		if (in_status)
			gotoXY(x,y);

		in_status = 0;
	}
	else if(d0 == 1)
	{
		if (!in_status)
			storeXY(&x, &y);

		in_status = 1;
		gotoXY(0,1);
	}
}

/************************************************************************/
/*			main interpreter loop				*/

void (*class0[])() = {
	ret_1,			/* op 0xb0	*/
	ret_0,			/* op 0xb1	*/
	print_im,			/* op 0xb2	*/
	printcr_im,			/* op 0xb3	*/
	nop,			/* op 0xb4	*/
	save_g,			/* op 0xb5	*/
	restore_g,		/* op 0xb6	*/
	restart_g,		/* op 0xb7	*/
	ret_sp,			/* op 0xb8	*/
	inc_sp,			/* op 0xb9	*/
	halt,			/* op 0xba	*/
	newline,		/* op 0xbb	*/
	status,			/* op 0xbc	*/
	verify,			/* op 0xbd	*/
	illegal,		/* op 0xbe	*/
	illegal			/* op 0xbf	*/
};

char *class0name[] = {
	"ret_1",			/* op 0xb0	*/
	"ret_0",			/* op 0xb1	*/
	"print_im",			/* op 0xb2	*/
	"printcr_im",			/* op 0xb3	*/
	"nop",			/* op 0xb4	*/
	"save_g",			/* op 0xb5	*/
	"restore_g",		/* op 0xb6	*/
	"restart_g",		/* op 0xb7	*/
	"ret_sp",			/* op 0xb8	*/
	"inc_sp",			/* op 0xb9	*/
	"halt",			/* op 0xba	*/
	"newline",		/* op 0xbb	*/
	"status",			/* op 0xbc	*/
	"verify",			/* op 0xbd	*/
	"illegal",		/* op 0xbe	*/
	"illegal"			/* op 0xbf	*/
};

void (*class1[])() = {
	bne,
	nextinv,
	firstinv,
	environment,
	l11a7e,
	incr,
	decr,
	print_near,
	illegal,
	destructobj,
	objshort,
	ret,
	bra,
	print_far,
	mov,
	not
};

char *class1name[] = {
	"bne",
	"nextinv",
	"firstinv",
	"environment",
	"l11a7e",
	"inc",
	"dec",
	"print_near",
	"illegal",
	"destructobj",
	"objshort",
	"ret",
	"bra",
	"print_far",
	"mov",
	"not"
};

struct {
	void (*func)();
	UBYTE flag;
	} class2[] = {
		{ illegal,	1 },		/* 00 */
		{ bifnotoneof,	0 },		/* 01 */
		{ cbge,		1 },		/* 02 */
		{ cble,		1 },		/* 03 */
		{ dcbge,	1 },		/* 04 */
		{ icble,	1 },		/* 05 */
		{ bnotcontent,	1 },		/* 06 */
		{ bifthen,	1 },		/* 07 */
		{ or,		1 },		/* 08 */
		{ and,		1 },		/* 09 */
		{ tstbit_jz,	1 },		/* 0a */
		{ setbit,	1 },		/* 0b */
		{ clrbit,	1 },		/* 0c */
		{ store,	1 },		/* 0d */
		{ moveobj,	1 },		/* 0e */
		{ getarrayw,	1 },		/* 0f */
		{ getarrayb,	1 },		/* 10 */
		{ querypropn,	1 },		/* 11 */
		{ getpropnaddr,	1 },		/* 12 */
		{ nextpropn,	1 },		/* 13 */
		{ add,		1 },		/* 14 */
		{ sub,		1 },		/* 15 */
		{ mul,		1 },		/* 16 */
		{ div,		1 },		/* 17 */
		{ mod,		1 },		/* 18 */
		{ illegal,	1 },		/* 19 */
		{ illegal,	1 },		/* 1a */
		{ illegal,	1 },		/* 1b */
		{ illegal,	1 },		/* 1c */
		{ illegal,	1 },		/* 1d */
		{ illegal,	1 },		/* 1e */
		{ illegal,	1 },		/* 1f */
		{ call,	0 },			/* 20 */
		{ putarrayw,	1 },		/* 21 */
		{ putarrayb,	1 },		/* 22 */
		{ setpropn,	1 },		/* 23 */
		{ input,	0 },		/* 24 */
		{ print_char,	1 },		/* 25 */
		{ write_num,	1 },		/* 26 */
		{ rnd,		1 },		/* 27 */
		{ push,	1 },		/* 28 */
		{ pop,	1 },		/* 29 */
		{ setstatuslen,	1 },		/* 2a */
		{ gotopos,	1 },		/* 2b */
		{ illegal,	1 },		/* 2c */
		{ illegal,	1 },		/* 2d */
		{ illegal,	1 },		/* 2e */
		{ illegal,	1 },		/* 2f */
		{ illegal,	1 },		/* 30 */
		{ illegal,	1 },		/* 31 */
		{ illegal,	1 },		/* 32 */
		{ illegal,	1 },		/* 33 */
		{ illegal,	1 },		/* 34 */
#if 0
		{ illegal,	1 },		/* 35 */
#else
		{ sound,	1 },		/* 35 */
#endif
		{ illegal,	1 },		/* 36 */
		{ illegal,	1 },		/* 37 */
		{ illegal,	1 },		/* 38 */
		{ illegal,	1 },		/* 39 */
		{ illegal,	1 },		/* 3a */
		{ illegal,	1 },		/* 3b */
		{ illegal,	1 },		/* 3c */
		{ illegal,	1 },		/* 3d */
		{ illegal,	1 },		/* 3e */
		{ illegal,	1 }		/* 3f */
};

char *class2name[] = {
	"illegal",		/* 00 */
	"bifnotoneof",		/* 01 */
	"cbge",		/* 02 */
	"cble",		/* 03 */
	"dcbge",		/* 04 */
	"icble",		/* 05 */
	"bnotcontent",		/* 06 */
	"bifthen",		/* 07 */
	"or",		/* 08 */
	"and",		/* 09 */
	"tstbit_jz",		/* 0a */
	"setbit",		/* 0b */
	"clrbit",		/* 0c */
	"store",		/* 0d */
	"moveobj",		/* 0e */
	"getarrayw",		/* 0f */
	"getarrayb",		/* 10 */
	"querypropn",		/* 11 */
	"getpropnaddr",		/* 12 */
	"nextpropn",		/* 13 */
	"add",		/* 14 */
	"sub",		/* 15 */
	"mul",		/* 16 */
	"div",		/* 17 */
	"mod",		/* 18 */
	"illegal",		/* 19 */
	"illegal",		/* 1a */
	"illegal",		/* 1b */
	"illegal",		/* 1c */
	"illegal",		/* 1d */
	"illegal",		/* 1e */
	"illegal",		/* 1f */
	"call",			/* 20 */
	"putarrayw",		/* 21 */
	"putarrayb",		/* 22 */
	"setpropn",		/* 23 */
	"input",		/* 24 */
	"print_char",		/* 25 */
	"write_num",		/* 26 */
	"rnd",		/* 27 */
	"push",		/* 28 */
	"pop",		/* 29 */
	"setstatuslen",		/* 2a */
	"gotopos",		/* 2b */
	"illegal",		/* 2c */
	"illegal",		/* 2d */
	"illegal",		/* 2e */
	"illegal",		/* 2f */
	"illegal",		/* 30 */
	"illegal",		/* 31 */
	"illegal",		/* 32 */
	"illegal",		/* 33 */
	"illegal",		/* 34 */
	"illegal",		/* 35 */
	"illegal",		/* 36 */
	"illegal",		/* 37 */
	"illegal",		/* 38 */
	"illegal",		/* 39 */
	"illegal",		/* 3a */
	"illegal",		/* 3b */
	"illegal",		/* 3c */
	"illegal",		/* 3d */
	"illegal",		/* 3e */
	"illegal"		/* 3f */
};

int oc;
int o1;

void run()
{
	register UWORD d0, d1, d2, d3, d4;
	register UWORD *argp, *bp;
	UWORD args[6];
	UWORD bits[4];

	argp = args;
	for(;;)
	{
#ifdef DEBUG
		ops[ops_ix].c_pc.offset = pc.offset;
		ops[ops_ix].c_pc.segment = pc.segment;
		ops[ops_ix].c_sp = sp - stack;
		ops[ops_ix].c_fp = framep - stack;
		ops[ops_ix].c_op = d0 = fetchb_op();

#ifdef TRACE
		printf("%02lx:%03lx:%05lx:%02lx ", ops[ops_ix].c_fp, ops[ops_ix].c_sp,
		(long)ops[ops_ix].c_pc.offset|((long)ops[ops_ix].c_pc.segment<<9),
		ops[ops_ix].c_op);
#endif

		ops_ix = (ops_ix + 1) & 0xff;
#else
		d0 = fetchb_op();
#endif
		if (d0 < 0x80)
		{
#ifdef TRACE
			printf("%-16s ",class2name[d0 & 0x1f]);
#endif

			d1 = getanyop((d0 & 0x40)?2:1);

#ifdef TRACE
			printf("%ld:%04lx ",(d0 & 0x40)?2:1, d1);
#endif

			d2 = getanyop((d0 & 0x20)?2:1);
#ifdef TRACE
			printf("%ld:%04lx ",(d0 & 0x20)?2:1, d2);
#endif

			if (class2[d0 & 0x1f].flag)
			{
/*				if(class2[d0 & 0x1f].func == illegal)*/
/*					DPrintf("\n1) Class2 %ld Illegal!\a\n",d0 & 0x1f);*/

				(*class2[d0 & 0x1f].func)(d1, d2);
			}
			else
			{
				argp[0] = 2;
				argp[1] = d1;
				argp[2] = d2;

/*				if(class2[d0 & 0x1f].func == illegal)*/
/*					DPrintf("\n2) Class2 %ld Illegal!\a\n",d0 & 0x1f);*/

				(*class2[d0 & 0x1f].func)(argp);
			}
		}
		else if (d0 < 0xb0)
		{
#ifdef TRACE
			printf("%-16s ",class1name[d0 & 0x0f]);
#endif
			d1 = getanyop((d0 >> 4) & 0x03);
#ifdef TRACE
			printf("%ld:%04lx ", (d0>>4)&0x03, d1);
#endif
/*			if(class1[d0 & 0x0f] == illegal)*/
/*				DPrintf("\n3) Class1 %ld Illegal!\a\n",d0 & 0x0f);*/

			(*class1[d0 & 0x0f])(d1);
		}
		else if (d0 < 0xc0)
		{
#ifdef TRACE
			printf("%-16s ",class0name[d0 & 0x0f]);
#endif
/*			if(class0[d0 & 0x0f] == illegal)*/
/*				DPrintf("\n4) Class0 %ld Illegal!\a\n",d0 & 0x0f);*/

			(*class0[d0 & 0x0f])();
		}
		else
		{
			d2 = d0;
			bp = &bits[4];
			d0 = fetchb_op();
			*(--bp) = d0;
			*(--bp) = (d0 >>= 2);
			*(--bp) = (d0 >>= 2);
			*(--bp) = (d0 >>= 2);
#ifdef TRACE
			printf("%-16s ",class2name[d2 & 0x3f]);
#endif
			for (d4 = 0, d3 = 4; d3; d3--)
			{
#ifdef TRACE
				printf("%ld:", *bp & 3);
#endif
				if ((d0 = *(bp++) & 3) == 3)
					break;
				argp[++d4] = getanyop(d0);
#ifdef TRACE
				printf("%04lx ",argp[d4]);
#endif
			}
			argp[0] = d4;

/*			if(class2[d2 & 0x3f].func == illegal)*/
/*				DPrintf("\n5) Class2 %ld Illegal!\a\n",d2 & 0x3f);*/

			if (class2[d2 & 0x3f].flag)
				(*class2[d2 & 0x3f].func)
					(argp[1],argp[2],argp[3],argp[4]);
			else
				(*class2[d2 & 0x3f].func)(argp);
		}
#ifdef TRACE
		printf("\n");
#endif
	}
}

/************************************************************************/
/*				initializiation				*/

void
main(argc,argv)
int argc; char **argv;
{
	struct header h;
	register UBYTE *p, *q, *r;
	register int i;

	char space[128];
	extern int optind;
	extern char *optarg;

	int c, rflag;
	char *restore_name;
	char *strchr(), *strrchr();

#ifndef AMIGA
	char *usage;
# if defined(OSK)
	usage = "\15\12Usage:\tzmachine [ -p protocolfile ] [ -w protocol linewith ]\
\15\12\t[ -s storyfile ] [ -r restorefile ] [ <storyfile>.data ]\
\15\12\t[ <restorefile>.save ]\15\12";
# else
	usage = "\r\nUsage:\tzmachine [ -p protocolfile ] [ -w protocol linewith ]\
\r\n\t[ -s storyfile ] [ -r restorefile ] [ <storyfile>.data ]\
\r\n\t[ <restorefile>.save ]\r\n";
# endif
#endif	/* AMIGA */

	story_name = restore_name = NULL;

	rflag = 0;

#ifdef AMIGA
	if(DOSBase -> dl_lib . lib_Version < 37)
		exit(20);

	if (argc == 0)
	{
		extern BYTE CustomScreen;

		wbtocli(&argc, &argv);

		while ((c = getopt(argc, argv, "s:p:r:w:k:l:c")) != EOF)
		{
			switch(c)
			{
				case 'k':
					TwoColours[0] = ahtoi(optarg);
					break;

				case 'l':
					TwoColours[1] = ahtoi(optarg);
					break;

				case 'c':
					CustomScreen = TRUE;
					break;

				case 's':
					story_name = optarg;
					break;

				case 'p':
					strcpy(print_name,optarg);
					break;

				case 'r':
					restore_name = optarg;
					rflag++;
					break;

				case 'w':
					if (!(printer_width = atoi(optarg)))
						printer_width = 80;

					break;
			}
		}
	}
	else
	{
		UBYTE **ArgArray;

		StdOut = Output();

		if(ArgArray = (UBYTE **)AllocVec(sizeof(UBYTE *) * (ARGCOUNT),MEMF_ANY | MEMF_CLEAR))
		{
			struct RDArgs *ArgsPtr;

			if(ArgsPtr = (struct RDArgs *)AllocDosObjectTags(DOS_RDARGS,TAG_DONE))
			{
				if(ProgramName = (UBYTE *)malloc(400))
				{
					UBYTE Buffer[400];

					if(!GetProgramName(Buffer,400))
					{
						free(ProgramName);

						ProgramName = NULL;
					}
					else
					{
						strcpy((char *)ProgramName,(char *)FilePart(Buffer));

						ArgsPtr -> RDA_ExtHelp = &ProgramName[40];
					}
				}

				if(!ProgramName)
					ArgsPtr -> RDA_ExtHelp = (UBYTE *)"\nUsage: ZorkMachine [Protocol <Protocol file>, Default = PRT:]\n\
                   [Width <Protocol file line width>, Default = 80 characters]\n\
                   [Story <Story file>, Default = Story.Data]\n\
                   [Restore <Saved game file>]\n\
                   [Customscreen]\n\
                   [Colour0 <Background colour>] [Colour1 <Text colour>]\n";
				else
					sprintf((char *)ArgsPtr -> RDA_ExtHelp,"\nUsage: %s [Protocol <Protocol file>, Default = PRT:]\33[B\33[42D\
[Width <Protocol file line width>, Default = 80 characters]\33[B\33[59D\
[Story <Story file>, Default = Story.Data]\33[B\33[42D\
[Restore <Saved game file>]\33[B\33[27D\
[Customscreen]\33[B\33[14D\
[Colour0 <Background colour>] [Colour1 <Text colour>]\n",ProgramName);

				if(ArgsPtr = ReadArgs((UBYTE *)"P=PROTOCOL/K,W=WIDTH/K/N,S=STORY/K,R=RESTORE/K,C=CUSTOMSCREEN/S,C0=COLOUR0/K,C1=COLOUR1/K",(LONG *)ArgArray,ArgsPtr))
				{
					if(ArgArray[ARG_COLOUR0])
						TwoColours[0] = ahtoi(ArgArray[ARG_COLOUR0]);

					if(ArgArray[ARG_COLOUR1])
						TwoColours[1] = ahtoi(ArgArray[ARG_COLOUR1]);

					if(ArgArray[ARG_PROTOCOL])
						strcpy(print_name,(char *)ArgArray[ARG_PROTOCOL]);

					if(ArgArray[ARG_WIDTH])
					{
						printer_width = *(LONG *)ArgArray[ARG_WIDTH];

						if(printer_width < 1)
							printer_width = 80;
					}

					if(ArgArray[ARG_STORY])
					{
						if(story_name = malloc(strlen((char *)ArgArray[ARG_STORY]) + 1))
							strcpy(story_name,(char *)ArgArray[ARG_STORY]);
					}

					if(ArgArray[ARG_RESTORE])
					{
						if(restore_name = malloc(strlen((char *)ArgArray[ARG_RESTORE]) + 1))
							strcpy(restore_name,(char *)ArgArray[ARG_RESTORE]);
					}

					if(ArgArray[ARG_CUSTOMSCREEN])
					{
						extern BYTE CustomScreen;

						CustomScreen = TRUE;
					}

					FreeArgs(ArgsPtr);
				}
				else
				{
					PrintFault(IoErr(),(UBYTE *)"ZorkMachine");

					FreeDosObject(DOS_RDARGS,ArgsPtr);

					FreeVec(ArgArray);

					exit(RETURN_ERROR);
				}

				FreeDosObject(DOS_RDARGS,ArgsPtr);
			}

			FreeVec(ArgArray);
		}
	}

#else
	while ((c = getopt(argc, argv, "s:p:r:w:")) != EOF)
	{
		switch(c)
		{
			case 's':
				story_name = optarg;
				break;

			case 'p':
				strcpy(print_name,optarg);
				break;

			case 'r':
				restore_name = optarg;
				rflag++;
				break;

			case 'w':
				if (!(printer_width = atoi(optarg)))
					printer_width = 80;
				break;

			default:
				exit(userexit(1));
		}
	}

	while (optind < argc)
	{
		char *tmp;

		if ((tmp = strrchr(argv[optind],'.')) &&
			(!stricmp(tmp,".data") || !stricmp(tmp, ".dat")))
			story_name = argv[optind];
		else if (tmp && (!stricmp(tmp, ".Save") || !stricmp(tmp, ".sav")))
		{
			rflag++;
			restore_name = argv[optind];
		}
		else
		{
			fatal("Unknown filetype", argv[optind]);
		}
		optind++;
	}
#endif	/* AMIGA */

	if (!story_name && restore_name && strchr(restore_name,'.'))
	{
		strcpy(space, restore_name);
		strcpy(strchr(space, '.'), ".data");

		if (access(space,0))
		{
			strcpy(strchr(space, '.'), ".dat");

			if (access(space,0))
				story_name = "Story.Data";
		}
		else
			story_name = space;
	}

	if (!story_name)
		story_name = "Story.Data";

	if (open_story())
		fatal("Can't open", story_name);

	read_header(&h);

	if (h.zmachine != 3)
		fatal("Wrong Z-machine version", story_name);

	mmu_init(&h);

	read_story(0, main_l, main_p);

	in_status = 0;

	release = word_get(h.release);
#ifdef TRACE
	printf("Release: %ld\n", release);
#endif

	status_type = (h.flags & 2) >> 1;
#ifdef TRACE
	printf("Flags: %08lx\n", h.flags);
#endif

	ff0 = main_p + word_get(h.reserved2);
	fec = main_p + word_get(h.reserved3);
	short_cuts = main_p + word_get(h.short_cuts);
	save_len = btop((long)word_get(h.save_len));
	if (!(stack = (UWORD *)malloc(0x100 * sizeof(WORD))))
		no_mem_error();

	printer = init_dev(prot_write, prot_crlf, printer_width, 0, 0);

	if (!(terms = (char *)malloc(0x40)))
		no_mem_error();

	q = main_p + word_get(h.vocabulary);
	for(p = (UBYTE *)terms, i = *(q++); i; i--)
		*p++ = *q++;		/* copy terminators	*/

	my_terms = (char *)p;
	for(r = (UBYTE *)" \011\015.,?"; *p++ = *r++;)
		;			/* copy my terminators	*/

	word_len = *q++;		/* word-len		*/
	word_num = word_get(q);		/* number of words	*/
	q += 2;

	first_word = q;			/* start of words	*/
	last_word = (word_num - 1) * word_len + first_word;
					/* end of words		*/

	if (setjmp(restart_buf))
	{
		rflag = 0;
		i = word_get(main_h->reserved5);
		read_story(0, save_len, main_p);
		word_put(main_h->reserved5, i);
	}

	printer->bp = printer->buffer;
	printer->count = 0;
	main_h->flags |= 32;

	status_len = 1;
	init_con();
	if (!rflag)
	{
		sp = &stack[0x100];
		framep = sp - 1;
		baddr_to_vaddr(&pc, word_get(h.initial_pc));
		load_code();
	}
	else
	{
		if (restore_gf(restore_name))
			jump(1);
		else
			fatal("Cannot load restore file", restore_name);
	}
	run();
}
