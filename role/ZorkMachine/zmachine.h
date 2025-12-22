/*
*	@(#)zmachine.h	2.24
*/

# include <stdio.h>
#undef NULL
#define NULL ((char *)0)
# include <setjmp.h>
# include "config.h"

/*char *lmalloc(), *malloc(), *realloc();*/

struct dev {
		char *buffer;
		int width;
		int height;
		char *bp;
		int count;
		void (*out_f)();
		int wrap;
		void (*crlf_f)();
	};

struct hist_buf {
			int len;
			char *hb;
			char *undo;
		};

struct header
	{
		UBYTE zmachine;			/* 00		*/
		UBYTE flags;			/* 01		*/
		ZWORD release;			/* 02		*/
		ZWORD minmem;			/* 04		*/
		ZWORD initial_pc;		/* 06		*/
		ZWORD vocabulary;		/* 08		*/
		ZWORD reserved2;		/* 0a	?	*/
		ZWORD reserved3;		/* 0c	?	*/
		ZWORD save_len;			/* 0e		*/
		ZWORD reserved5;		/* 10	zero	*/
		UBYTE serial[6];			/* 12		*/
		ZWORD short_cuts;		/* 18		*/
		ZWORD len;			/* 1a		*/
		ZWORD checksum;			/* 1c		*/
		ZWORD reserved8;		/* 1e	zero	*/
		ZWORD reserved9[16];		/* 20	zero	*/
	};


struct virt_page {
		WORD page;
		unsigned long lru;
		UBYTE *paddr;
	};

struct address
	{
		WORD segment;
		WORD offset;		/* MUST be signed		*/
	};

# define FLUSH		0x7f		/* Flush output buffer		*/

extern char *story_name;		/* Name of story file		*/
extern char print_name[256];
extern int printer_width;		/* Character-width of protocol
					   file				*/
extern struct dev *screen, *printer;	/* screen and protocol device
					   structures			*/

extern int main_l;			/* len of main memory in pages	*/
extern UBYTE *main_p;			/* start of main memory		*/
extern struct header *main_h;		/* pointer to header structure
					   in main memory		*/
extern struct address pc;		/* programcounter		*/
extern struct virt_page *pc_page;	/* currently executed page	*/

extern char *sysname;			/* system name			*/

/*		from io.c		*/

struct dev *init_dev();
void	scr_write();
void	prot_write();
void	prot_crlf();
void	output_status();
void	output_chr();
void	output_str();
char	*read_str();
int	save_keys();
int	restore_keys();

extern int pfile;

/*		from zbios.c		*/

long	zrandom();
void	con_flush();
void	con_chr();
void	con_str1();
void	con_str2();
void	con_crlf();
void	reverseON();		
void	reverseOFF();
void	cursorON();
void	cursorOFF();
void	gotoXY();
void	storeXY();
int	con_getc();
void	init_con();

int	open_story();
int	close_story();
void	read_story();
void	read_header();

char	*read_sname();
char	*read_rname();
int	open_save_w();
int	open_save_r();
int	close_save();
int	write_save();
int	read_save();
void	fatal();
void	clean_up();
int	userexit();

/*		from mem.c		*/

void	load_code();
UBYTE	*load_page();
long	ptob();
UWORD	btob();
UWORD	word_get();
void	word_put();
UBYTE	fetchb_data();
UWORD	fetchw_data();
UBYTE	fetchb_op();
UWORD	fetchw_op();
void	baddr_to_vaddr();
void	waddr_to_vaddr();

/*		from code.c		*/

void	decode();
void	encode();

#ifdef AMIGA

void	ConPutC(unsigned char c);
unsigned char	ConGetC(void);
void	ConPutS(unsigned char *s);
void	ConPutS2(unsigned char *a,unsigned char *b);
void	ConCleanup(void);
char	OpenConsoleStuff(void);
#endif
