CC = g++
INCLUDES = -I.
LIBS = tinyxml/tinyxml.o tinyxml/tinyxmlparser.o tinyxml/tinyxmlerror.o
#CXXFLAGS = -g -W -Wall -ansi -pedantic
#CXXFLAGS = -pg -g -W -Wall -ansi -pedantic
CXXFLAGS = -O2 -W -Wall -ansi -pedantic 
CFLAGS = -O2
OBJS = bulletmlparser-tinyxml.o bulletmlparser.o bulletmltree.o calc.o formula-variables.o bulletmlrunner.o bulletmlrunnerimpl.o

all: libbulletml.a

libbulletml.a: $(OBJS)
	$(MAKE) -C tinyxml
	$(AR) -r libbulletml.a bulletmlparser.o bulletmlparser-tinyxml.o bulletmlrunner.o bulletmlrunnerimpl.o bulletmltree.o calc.o formula-variables.o tinyxml/tinyxml.o tinyxml/tinyxmlerror.o tinyxml/tinyxmlparser.o

clean:
	delete #?.o #?.a
	$(MAKE) -C tinyxml clean

calc.cpp: calc.yy
	bison -y calc.yy && mv y.tab.c calc.cpp

$(OBJS): %.o: %.cpp
	$(CC) $(CXXFLAGS) $(INCLUDES) -c $<

doxy:
	doxygen

distdir:

