SRC = \
  sge_blib.cpp sge_bm_text.cpp sge_collision.cpp sge_misc.cpp sge_primitives.cpp \
  sge_rotation.cpp sge_shape.cpp sge_surface.cpp sge_textpp.cpp sge_tt_text.cpp

OBJ = $(SRC:.cpp=.o)

CFLAGS = -O3 -newlib -Wall -Isdk:local/newlib/include/SDL -Isdk:Local/freetype/include/ -D_SGE_HAVE_IMG -c

LIB = libsge.a

$(LIB): $(OBJ)
	ar -ru $(LIB) $(OBJ)
	ranlib $(LIB)

%.o: %.cpp %.h
	g++ $(CFLAGS) $<

clean:
	delete $(LIB)
	delete #?.o
