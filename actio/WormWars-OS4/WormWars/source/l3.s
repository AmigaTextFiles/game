;generate WormWars.catalog files based on ww.cd and ww.ct

SETENV Language deutsch
CATCOMP ww.cd $Language.ct CATALOG /Catalogs/$Language/WormWars.catalog VERBOSITY=3
COPY /Catalogs/$Language/WormWars.catalog windh_c:games/wormwars/Catalogs/german.iff

SETENV Language italiano
CATCOMP ww.cd $Language.ct CATALOG /Catalogs/$Language/WormWars.catalog VERBOSITY=3
COPY /Catalogs/$Language/WormWars.catalog windh_c:games/wormwars/Catalogs/italian.iff

SETENV Language español
CATCOMP ww.cd $Language.ct CATALOG /Catalogs/$Language/WormWars.catalog VERBOSITY=3
COPY /Catalogs/$Language/WormWars.catalog windh_c:games/wormwars/Catalogs/spanish.iff

SETENV Language greek
IF EXISTS greek.ct
 CATCOMP ww.cd $Language.ct CATALOG /Catalogs/$Language/WormWars.catalog VERBOSITY=3
 COPY /Catalogs/$Language/WormWars.catalog windh_c:games/wormwars/Catalogs/greek.iff
ENDIF

SETENV Language polski
CATCOMP ww.cd $Language.ct CATALOG /Catalogs/$Language/WormWars.catalog VERBOSITY=3
COPY /Catalogs/$Language/WormWars.catalog windh_c:games/wormwars/Catalogs/polish.iff

SETENV Language russian
CATCOMP ww.cd $Language.ct CATALOG /Catalogs/$Language/WormWars.catalog VERBOSITY=3
COPY /Catalogs/$Language/WormWars.catalog windh_c:games/wormwars/Catalogs/russian.iff

SETENV Language english
