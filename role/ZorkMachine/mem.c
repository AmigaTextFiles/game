/*
*	@(#)mem.c	2.24
*/

# include "zmachine.h"

#ifdef AMIGA

#undef NULL
#define NULL 0L

#endif

# define LOCK	0xffffffffL

UBYTE *main_p;		/* main memory pointer				*/
int main_l;		/* main memory len in pages			*/
struct header *main_h;	/* header pointer				*/

struct virt_page *pc_page;	/* page of current pc			*/
struct virt_page main_page;	/* page control for main memory		*/
struct virt_page *c_page; 	/* current active page			*/
struct virt_page *virt_p;	/* the virtual memory array		*/
struct address	pc;		/* program counter			*/

unsigned long lruc =  0;	/* LRU counter				*/

/************************************************************************/

/* find free page */

struct virt_page *find_page()
{
	register struct virt_page *u, *v;
	register long t;

	for(v = virt_p, t = LOCK; v->page != -1; v++)
		if (v->lru < t)
		{
			t = v->lru;
			u = v;
		}

	return(u);
}


/* load a page */

UBYTE *load_page(page)
register WORD page;
{
	register struct virt_page *v;

	if (page != c_page->page)
	{
		lruc++;
		for (v = virt_p; v->page != -1; v++)
		{
			if (v->page == page)
			{
				if (pc_page->page != page)
					v->lru = lruc;

				c_page = v;
				return(c_page->paddr);
			}
		}
		c_page = find_page();
		c_page->page = page;
		c_page->lru = lruc;
		read_story(c_page->page, 1, c_page->paddr);
	}
	return(c_page->paddr);
}


/* load page for current pc */

void load_code()
{
	pc.segment += pc.offset >> 9;	/* pc.offset may be negative	*/
	pc.offset &= 0x1ff;
	if (pc.segment != pc_page->page)
	{
		pc_page->lru = lruc;

		if (pc.segment >= main_l)
		{
			load_page(pc.segment);
			pc_page = c_page;
			pc_page->lru = LOCK;
		}
		else
		{
			main_page.page = pc.segment;
			main_page.paddr = main_p+ptob(pc.segment);
			pc_page = &main_page;
		}
	}
}


/* page to byte address */

long ptob(page)
UWORD page;
{
	return(((long)page << (long)9) & 0x1ffffL);
}


/* byte to page address */

UWORD btop(byte)
long byte;
{
	return((byte & 0x1ff ? (byte >> 9)+1:(byte >> 9)) & 0xff);
}


/* get word */

UWORD word_get(p)
UBYTE *p;
{
	register UWORD i;
	i = *p++ << 8;
	return(i | *p);
}


/* put word */

void word_put(p, d)
UBYTE *p; register UWORD d;
{
	p[1] = d & 0xff;
	p[0] = d >> 8;
}


/* fetch byte data */

UBYTE fetchb_data(a)
register struct address *a;
{
	UBYTE *load_page();
	register UBYTE r;

	if (a->segment < main_l)
		r = main_p[ptob(a->segment) | a->offset];
	else
		r = load_page(a->segment)[a->offset];

	if (++(a->offset) == 0x200)
	{
		a->offset = 0;
		(a->segment)++;
	}
	return(r);
}


/* fetch word data */

UWORD fetchw_data(a)
struct address *a;
{
	register UWORD r;
	r = fetchb_data(a);
	return((r << 8) | fetchb_data(a));
}


/* fetch next byte from pc */

UBYTE fetchb_op()
{
	register UBYTE r;

	r = pc_page->paddr[pc.offset];
	if (++pc.offset >= 0x200)
		load_code();

	return(r);
}


/* fetch next word from pc */

UWORD fetchw_op()
{
	register UWORD r;

	r = fetchb_op() << 8;
	return(r | fetchb_op());
}


/* byte address to virtual address */

void baddr_to_vaddr(vaddress, baddress)
register struct address *vaddress; register UWORD baddress;
{
	vaddress->segment = (baddress >> 9) & 0xff;
	vaddress->offset = baddress & 0x1ff;
}


/* word address to virtual address */

void waddr_to_vaddr(vaddress, waddress)
struct address *vaddress; register UWORD waddress;
{
	vaddress->segment = (waddress >> 8) & 0xff;
	vaddress->offset = (waddress & 0xff) * 2;
}


/* initialize mmu */

#if defined(minix)
extern int brk();
extern char *sbrk();
static char *oldbrk = NULL;
static char *lmalloc(s)
long s;
{
	char *m;
	if (!oldbrk)
		oldbrk = sbrk(0);

	m = sbrk(0);
	if (brk(m + s + 0x2000) != 0)
	{
		brk(m);
		return(NULL);
	}
	else
	{
		brk(m + s);
		return(m);
	}
}

static free(p)
char *p;
{
	brk(oldbrk);
}
#endif

void mmu_init(h)
struct header *h;
{
	long virt_l;
	int i;

	if (main_p = (UBYTE *)lmalloc(btop((long)word_get(h->len) * 2L) * 512L))
	{
		main_l = btop((long)word_get(h->len) * 2L);
		virt_l = 2;
		if (!(virt_p = (struct virt_page *)lmalloc((0x200L +
					sizeof(struct virt_page)) * 2 +
					sizeof(struct virt_page))))
		{
			free(main_p);
			goto low_mem;
		}
	}
	else
	{
low_mem:
		if ((main_p = (UBYTE *)
			lmalloc((long)btop((long)word_get(h->minmem)) * 512L))
		   	== NULL)
			no_mem_error();

		main_l = btop((long)word_get(h->minmem));

		for (virt_l = btop((long)word_get(h->len) * 2L -
			(long)word_get(h->minmem));
				virt_l >= 2 && virt_p == NULL; virt_l--)
			virt_p = (struct virt_page *)lmalloc((long)
				(virt_l * (0x200L +
				sizeof(struct virt_page)) +
				sizeof(struct virt_page)));

		if (virt_l < 2)
			no_mem_error();
	}

	for (i = 0; i < virt_l; i++)
	{
		virt_p[i].page = -2;
		virt_p[i].lru = 0L;
		virt_p[i].paddr = (UBYTE *)virt_p +
				(long)(sizeof(struct virt_page) *
				(virt_l + 1L) + 0x200L * (long)i);
	}
	virt_p[i].page = -1;

	pc_page = c_page = virt_p;
	main_h = (struct header *)main_p;
}
