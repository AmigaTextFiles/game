ECHO "Compiling catalogs..."

;generate Saga.catalog file based on saga.cd and saga.ct for OS3
SETENV Language deutsch
CATCOMP saga.cd $Language.ct CATALOG /Catalogs/$Language/Saga.catalog VERBOSITY=3
SETENV Language italiano
CATCOMP saga.cd $Language.ct CATALOG /Catalogs/$Language/Saga.catalog VERBOSITY=3

SETENV Language greek
IF EXISTS greek.ct
 CATCOMP saga.cd $Language.ct CATALOG /Catalogs/$Language/Saga.catalog VERBOSITY=3
ENDIF

SETENV Language english
