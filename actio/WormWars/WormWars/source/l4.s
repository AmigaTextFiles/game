;generate WormWars.catalog files based on ww.cd and ww.ct for OS4

SETENV Language german
CATCOMP ww.cd deutsch.ct CATALOG /Catalogs/$Language/WormWars.catalog VERBOSITY=3

SETENV Language italian
CATCOMP ww.cd italiano.ct CATALOG /Catalogs/$Language/WormWars.catalog VERBOSITY=3

SETENV Language spanish
CATCOMP ww.cd español.ct CATALOG /Catalogs/$Language/WormWars.catalog VERBOSITY=3

SETENV Language greek
IF EXISTS greek.ct
 CATCOMP ww.cd greek.ct CATALOG /Catalogs/$Language/WormWars.catalog VERBOSITY=3
ENDIF

SETENV Language polish
CATCOMP ww.cd polski.ct CATALOG /Catalogs/$Language/WormWars.catalog VERBOSITY=3

SETENV Language russian
CATCOMP ww.cd russian.ct CATALOG /Catalogs/$Language/WormWars.catalog VERBOSITY=3

SETENV Language english
