CC=ppc-morphos-gcc
CCFLAGS =

all:    $(OBJS)
	@echo Compiling XQuiz 1.2
	$(CC) -o xquiz xquiz-1.2.c
	@echo If you want xquiz global, run make install too!
	@echo Done, run ./xquiz and start guessing!
        

install: $(OBJS)
	 @echo Installing xquiz in /usr/local/bin/
	 cp xquiz /usr/local/bin/
