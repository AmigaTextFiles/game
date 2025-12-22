ECHO "Compiling catalogs..."

;generate Africa.catalog file based on africa.cd and africa.ct for OS3
SETENV Language deutsch
CATCOMP africa.cd $Language.ct CATALOG /Catalogs/$Language/Africa.catalog VERBOSITY=3
SETENV Language italiano
CATCOMP africa.cd $Language.ct CATALOG /Catalogs/$Language/Africa.catalog VERBOSITY=3

SETENV Language greek
IF EXISTS greek.ct
 CATCOMP africa.cd $Language.ct CATALOG /Catalogs/$Language/Africa.catalog VERBOSITY=3
ENDIF

SETENV Language english
