SUBDIRS = src

ACLOCAL_AMFLAGS = -I m4

EXTRA_DIST = include \
             IDE/codeblocks/dunelegacy.cbp \
             IDE/xCode \
             data/LEGACY.PAK \
             Doxyfile \
             ToDo.txt \
             SoftwareDesign.txt \
             buildlocal.sh \
             builddebug.sh \
             clean.sh \
             icon1.ico


datafiles_DATA = data/LEGACY.PAK
datafilesdir = $(dunelegacydatadir)

dist-hook:
	rm -rf `find $(distdir) -name .svn`
	rm -rf $(distdir)/IDE/xCode/Dune\ Legacy.xcodeproj/.svn
