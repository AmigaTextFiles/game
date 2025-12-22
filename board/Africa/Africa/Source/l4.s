ECHO "Compiling catalogs..."

;generate Africa.catalog files based on africa.cd and africa.ct for OS4

SETENV Language german
CATCOMP africa.cd deutsch.ct CATALOG /Catalogs/$Language/Africa.catalog VERBOSITY=3

SETENV Language italian
CATCOMP africa.cd italiano.ct CATALOG /Catalogs/$Language/Africa.catalog VERBOSITY=3

IF EXISTS greek.ct
 SETENV Language greek
 CATCOMP africa.cd greek.ct CATALOG /Catalogs/$Language/Africa.catalog VERBOSITY=3
ENDIF

SETENV Language english
