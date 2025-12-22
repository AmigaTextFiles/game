ROOT = $(shell pwd)

EXECUTABLE = leibomber
INCLUDE_DIR = $(ROOT)/include
SRC_DIR = $(ROOT)/src

install :
	cd $(SRC_DIR) ;\
	make ;\
	mv $(EXECUTABLE) $(ROOT) ;\

clean :
	rm $(EXECUTABLE) ;\
	cd $(SRC_DIR) ;\
	make clean ;\
