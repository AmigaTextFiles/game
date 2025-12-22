ECHO "Compiling catalogs..."

;generate Saga.catalog files based on saga.cd and saga.ct for OS4

SETENV Language german
CATCOMP saga.cd deutsch.ct CATALOG /Catalogs/$Language/Saga.catalog VERBOSITY=3

IF EXISTS greek.ct
 SETENV Language greek
 CATCOMP saga.cd greek.ct CATALOG /Catalogs/$Language/Saga.catalog VERBOSITY=3
ENDIF

SETENV Language italian
CATCOMP saga.cd italiano.ct CATALOG /Catalogs/$Language/Saga.catalog VERBOSITY=3

SETENV Language english
