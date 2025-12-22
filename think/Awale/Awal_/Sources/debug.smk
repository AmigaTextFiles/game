awale: awale.o awale2.o
    slink FROM lib:c.o+awale.o+awale2.o TO awale LIB lib:sc.lib+lib:amiga.lib

awale.o: awale.c
    sc awale DEBUG=FULL

awale2.o: awale2.s
    asm awale2.s
