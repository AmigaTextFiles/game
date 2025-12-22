CC = sc
INSTALLDIR = /bin
CCOPTS = NODEBUG OPTIMIZE
EXES = tr head wc expr wc uniq tail date basename dirname strings
# sort cut (those don't work)

MAKEC = 	$(CC) $< $(CCOPTS)
all : $(EXES)
	@rm -f #?.o #?.lnk #?.lst #?.lst.info

cut: cut.c
	$(MAKEC)

basename: basename.c
	$(MAKEC)

strings: strings.c
	$(MAKEC)

dirname: dirname.c
	$(MAKEC)

tr: tr.c
	$(MAKEC)

head: head.c
	$(MAKEC)

tail: tail.c getopt.c
	$(CC) tail.c $(CCOPTS) NOLINK
	$(CC) getopt.c $(CCOPTS) NOLINK
	$(CC) tail.o getopt.o TO tail
	rm -f tail.o getopt.o

sort: sort.c
	$(MAKEC)

uniq: uniq.c
	$(MAKEC)

wc: wc.c
	$(MAKEC)

expr: expr.c
	$(MAKEC)

date: date.c
	$(MAKEC)


clean:;		rm -f $(EXES) #?.o QUIET FORCE

install:;	copy $(EXES) $(INSTALLDIR)
