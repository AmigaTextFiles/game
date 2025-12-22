.SUFFIXES: .cpp .o .a
.PRECIOUS: ligSGU.so

CC=gcc -mcrt=newlib
LINK=gcc -mcrt=newlib
CFLAGS= -I/sdk/local/newlib/include/SDL -I/sdk/local/common/include/SDL -I../include -O2
LFLAGS= -mcrt=newlib -lSDL_gfx -lSDL_net -lSDL_image -ltiff -lpng -ljpeg -lz -lSDL_mixer -lsmpeg -lm -lvorbisfile -lvorbis -logg -lstdc++ -lSDL_ttf -lfreetype -lz -lsdlmain -lsdl -lauto -lpthread -lm -lunix

OBJ_FILES= SGU_GenUtils.o SGU_List.o SGU_Sprite.o SGU_UI_Base.o SGU_UI_SDB.o \
	SGU_UI_Theme.o SGU_UI_WGButton.o SGU_UI_WGFile.o SGU_UI_WGIntBar.o \
	SGU_UI_WGList.o SGU_UI_WGScrollBar.o SGU_UI_WGText.o SGU_UI_WGValueBar.o			

libSGU.a: 	$(OBJ_FILES)
		mkdir -p lib/
		ar -ru lib/libSGU.a SGU_GenUtils.o SGU_List.o SGU_Sprite.o SGU_UI_Base.o SGU_UI_SDB.o SGU_UI_Theme.o SGU_UI_WGButton.o SGU_UI_WGFile.o SGU_UI_WGIntBar.o SGU_UI_WGList.o SGU_UI_WGScrollBar.o SGU_UI_WGText.o SGU_UI_WGValueBar.o 
		ranlib lib/libSGU.a

.cpp.o:
	$(CC) $(CFLAGS) -c $< 

clean:
	rm *.o ../lib/libSGU.a
