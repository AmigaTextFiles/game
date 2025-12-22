bin_PROGRAMS = montymole


# set the include path found by configure
INCLUDES= $(all_includes)

# the library search path.
montymole_LDFLAGS = $(all_libraries) $(LIBSDL_RPATH)
montymole_CXXFLAGS = $(LIBSDL_CFLAGS)
montymole_LDADD = $(LIBSDL_LIBS)
montymole_SOURCES = KFile.cpp KFile.h KGrowSurface.h KJArrayTemplate.h\
	KJBackground.cpp KJBackground.h KJ.h KJText.cpp KJText.h KPtrArray.cpp\
	KPtrArray.h KScreen.cpp KScreen.h KSurface.cpp KSurface.h main.cpp\
	MMCoal.cpp MMCoal.h MMCrusher.cpp MMCrusher.h MMDataDefs.h MMHelper.cpp\
	MMHelper.h MMKiller.cpp MMKiller.h MMMonty.cpp MMMonty.h MMObject.cpp\
	MMObject.h MMRoom.cpp MMRoom.h MMRoomTests.cpp MMRoomTests.h\
	MMSlider.cpp MMSlider.h MontyMap.cpp MontyMap.h MontyScreen.cpp\
	MontyScreen.h
