#drinc:libraries/dos.g
#drinc:util.g
#/Include/Empire.g
#Server.g

/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

uint
    OS_BLOCK_SIZE = 512,
    SECTOR_CACHE_SIZE = 300,
    SHIP_CACHE_SIZE = 300;

type
    SectorCache_t = struct {
	*SectorCache_t sc_next, sc_prev;	/* next, prev in LRU chain */
	uint sc_rowCol; 			/* row & column, encoded */
	bool sc_dirty;				/* needs writing to disk */
	Sector_t sc_sector;			/* the sector data */
    },

    ShipCache_t = struct {
	*ShipCache_t shc_next, shc_prev;
	uint shc_shipNumber;
	bool shc_dirty;
	Ship_t shc_ship;
    };

[SECTOR_CACHE_SIZE] SectorCache_t SectorCache;	/* the sector cache */
uint SectorFree;				/* next unused slot */
*SectorCache_t SectorHead;			/* head of LRU chain */
*SectorCache_t SectorTail;			/* tail of LRU chain */

[SHIP_CACHE_SIZE] ShipCache_t ShipCache;
uint ShipFree;
*ShipCache_t ShipHead;
*ShipCache_t ShipTail;

Handle_t
    FileFd,
    LogFd,
    WorldFd,
    CountryFd,
    SectorFd,
    ShipFd,
    FleetFd,
    LoanFd,
    OfferFd;

[150] char FileName;				/* buffer when opening */
[150] char LogFileName;
*char Path;

bool Aborting;

/*
 * closeEmpireFiles - do the actual file closing.
 */

proc closeEmpireFiles()void:

    if OfferFd ~= 0 then
	Close(OfferFd);
	OfferFd := 0;
    fi;
    if LoanFd ~= 0 then
	Close(LoanFd);
	LoanFd := 0;
    fi;
    if FleetFd ~= 0 then
	Close(FleetFd);
	FleetFd := 0;
    fi;
    if ShipFd ~= 0 then
	Close(ShipFd);
	ShipFd := 0;
    fi;
    if SectorFd ~= 0 then
	Close(SectorFd);
	SectorFd := 0;
    fi;
    if CountryFd ~= 0 then
	Close(CountryFd);
	CountryFd := 0;
    fi;
    if WorldFd ~= 0 then
	Close(WorldFd);
	WorldFd := 0;
    fi;
corp;

/*
 * logString - write a string to the log file.
 */

proc logString(*char message)void:
    register *char p;

    p := message;
    while p* ~= '\e' do
	p := p + sizeof(char);
    od;
    ignore Write(LogFd, message, p - message);
corp;

/*
 * logOpen - write the time and a separator to the log file.
 */

proc logOpen()bool:
    [30] char timeBuffer;

    LogFd := Open(&LogFileName[0], MODE_OLDFILE);
    if LogFd = 0 then
	LogFd := Open(&LogFileName[0], MODE_NEWFILE);
    else
	if Seek(LogFd, 0, OFFSET_END) = -1 then
	    Close(LogFd);
	    LogFd := 0;
	fi;
    fi;
    if LogFd ~= 0 then
	ConvTime(GetCurrentTime(), &timeBuffer[0]);
	logString(&timeBuffer[0]);
	logString(" - ");
	true
    else
	false
    fi
corp;

/*
 * log - write a message, with current time, to the log file.
 */

proc log(*char message)void:

    if logOpen() then
	logString(message);
	logString("\n");
	Close(LogFd);
    fi;
corp;

/*
 * logN - write a message, built from 2 strings and an integer.
 */

proc logN(register *char m1; register ulong n; *char m2)void:
    [11] char buffer;

    if logOpen() then
	logString(m1);
	m1 := &buffer[10];
	m1* := '\e';
	while
	    m1 := m1 - sizeof(char);
	    m1* := n % 10 + '0';
	    n := n / 10;
	    n ~= 0
	do
	od;
	logString(m1);
	logString(m2);
	logString("\n");
	Close(LogFd);
    fi;
corp;

/*
 * abort - abort with a message.
 */

proc abort(*char message)void:

    if logOpen() then
	logString("*** ");
	logString(message);
	logString(" - aborting\n");
	Close(LogFd);
    fi;
    closeEmpireFiles();
    Aborting := true;
    setAborting();
/*
    Exit(RETURN_FAIL);
*/
corp;

/*
 * sectorFlush - flush the sector cache. We flush the sectors in increasing
 *	absolute sector order, so as to minimize disk seeking.
 */

proc sectorFlush()void:
    register uint i, minRowCol;
    bool foundDirty;
    register *SectorCache_t sc, lowest;

    if SectorFree ~= 0 then
	while
	    foundDirty := false;
	    minRowCol := 0xffff;
	    sc := &SectorCache[0];
	    for i from SectorFree - 1 downto 0 do
		if sc*.sc_dirty and sc*.sc_rowCol < minRowCol then
		    foundDirty := true;
		    lowest := sc;
		    minRowCol := sc*.sc_rowCol;
		fi;
		sc := sc + sizeof(SectorCache_t);
	    od;
	    foundDirty and not Aborting
	do
	    if Seek(SectorFd, make(minRowCol, ulong) * sizeof(Sector_t),
			OFFSET_BEGINNING) = -1
	    then
		abort("Can't seek to sector");
	    fi;
	    if not Aborting and
		Write(SectorFd, &lowest*.sc_sector, sizeof(Sector_t)) ~=
		    sizeof(Sector_t)
	    then
		abort("Can't write sector");
	    fi;
	    lowest*.sc_dirty := false;
	od;
    fi;
corp;

/*
 * sectorLookup - lookup/enter the requested sector in the sector cache.
 *	Return 'false' if it was already there. Referencing it will always
 *	put it at the head of the chain.
 */

proc sectorLookup(register uint rowCol)bool:
    register uint dirtyCount;
    register *SectorCache_t sc;

    sc := SectorHead;
    while sc ~= nil and sc*.sc_rowCol ~= rowCol do
	sc := sc*.sc_next;
    od;
    if sc = nil then
	/* didn't find the needed sector - add it to the cache. */
	if SectorFree ~= SECTOR_CACHE_SIZE then
	    /* free slot left - just use it */
	    sc := &SectorCache[SectorFree];
	    SectorFree := SectorFree + 1;
	else
	    /* no free slot - look for a non-dirty one */
	    dirtyCount := 0;
	    sc := SectorTail;
	    while sc ~= nil and sc*.sc_dirty do
		sc := sc*.sc_prev;
		dirtyCount := dirtyCount + 1;
	    od;
	    if dirtyCount > SECTOR_CACHE_SIZE * 4 / 5 or sc = nil then
		/* no non-dirty slot left. Flush all and use tail one. */
		sectorFlush();
		sc := SectorTail;
	    fi;
	    /* delete the sector from it's current position in the chain */
	    if sc*.sc_prev = nil then
		SectorHead := sc*.sc_next;
	    else
		sc*.sc_prev*.sc_next := sc*.sc_next;
	    fi;
	    if sc*.sc_next = nil then
		SectorTail := sc*.sc_prev;
	    else
		sc*.sc_next*.sc_prev := sc*.sc_prev;
	    fi;
	fi;
	/* insert it at the head of the chain */
	sc*.sc_prev := nil;
	sc*.sc_next := SectorHead;
	if SectorHead ~= nil then
	    SectorHead*.sc_prev := sc;
	else
	    SectorTail := sc;
	fi;
	SectorHead := sc;
	/* set it to be the requested sector */
	sc*.sc_rowCol := rowCol;
	sc*.sc_dirty := false;
	true
    else
	/* move it to the front of the LRU chain if its not there already */
	if sc*.sc_prev ~= nil then
	    sc*.sc_prev*.sc_next := sc*.sc_next;
	    if sc*.sc_next ~= nil then
		sc*.sc_next*.sc_prev := sc*.sc_prev;
	    else
		SectorTail := sc*.sc_prev;
	    fi;
	    sc*.sc_prev := nil;
	    sc*.sc_next := SectorHead;
	    if SectorHead ~= nil then
		SectorHead*.sc_prev := sc;
	    else
		SectorTail := sc;
	    fi;
	    SectorHead := sc;
	fi;
	false
    fi
corp;

/*
 * shipFlush - flush the ship cache. We flush the ships in increasing
 *	ship number order, so as to minimize disk seeking.
 */

proc shipFlush()void:
    register uint minNum, i;
    bool foundDirty;
    register *ShipCache_t lowest, shc;

    if ShipFree ~= 0 then
	while
	    foundDirty := false;
	    minNum := 0xffff;
	    shc := &ShipCache[0];
	    for i from ShipFree - 1 downto 0 do
		if shc*.shc_dirty and shc*.shc_shipNumber < minNum then
		    foundDirty := true;
		    lowest := shc;
		    minNum := shc*.shc_shipNumber;
		fi;
		shc := shc + sizeof(ShipCache_t);
	    od;
	    foundDirty and not Aborting
	do
	    if Seek(ShipFd, make(minNum, ulong) * sizeof(Ship_t),
		    OFFSET_BEGINNING) = -1
	    then
		abort("Can't seek to ship");
	    fi;
	    if not Aborting and 
		Write(ShipFd, &lowest*.shc_ship, sizeof(Ship_t)) ~=
		    sizeof(Ship_t)
	    then
		abort("Can't write ship");
	    fi;
	    lowest*.shc_dirty := false;
	od;
    fi;
corp;

/*
 * shipLookup - lookup/enter the requested ship in the ship cache.
 *	Return 'false' if it was already there. Referencing it will always
 *	put it at the head of the chain.
 */

proc shipLookup(register uint shipNumber)bool:
    register uint dirtyCount;
    register *ShipCache_t shc;

    shc := ShipHead;
    while shc ~= nil and shc*.shc_shipNumber ~= shipNumber do
	shc := shc*.shc_next;
    od;
    if shc = nil then
	/* didn't find the needed sector - add it to the cache. */
	if ShipFree ~= SHIP_CACHE_SIZE then
	    /* free slot left - just use it */
	    shc := &ShipCache[ShipFree];
	    ShipFree := ShipFree + 1;
	else
	    /* no free slot - look for a non-dirty one */
	    dirtyCount := 0;
	    shc := ShipTail;
	    while shc ~= nil and shc*.shc_dirty do
		shc := shc*.shc_prev;
		dirtyCount := dirtyCount + 1;
	    od;
	    if dirtyCount > SHIP_CACHE_SIZE * 4 / 5 or shc = nil then
		/* no non-dirty slot left. Flush all and use tail one. */
		shipFlush();
		shc := ShipTail;
	    fi;
	    /* delete the ship from it's current position in the chain */
	    if shc*.shc_prev = nil then
		ShipHead := shc*.shc_next;
	    else
		shc*.shc_prev*.shc_next := shc*.shc_next;
	    fi;
	    if shc*.shc_next = nil then
		ShipTail := shc*.shc_prev;
	    else
		shc*.shc_next*.shc_prev := shc*.shc_prev;
	    fi;
	fi;
	/* insert it at the head of the chain */
	shc*.shc_prev := nil;
	shc*.shc_next := ShipHead;
	if ShipHead ~= nil then
	    ShipHead*.shc_prev := shc;
	else
	    ShipTail := shc;
	fi;
	ShipHead := shc;
	/* set it to be the requested ship */
	shc*.shc_shipNumber := shipNumber;
	shc*.shc_dirty := false;
	true
    else
	/* move it to the front of the LRU chain if its not there already */
	if shc*.shc_prev ~= nil then
	    shc*.shc_prev*.shc_next := shc*.shc_next;
	    if shc*.shc_next ~= nil then
		shc*.shc_next*.shc_prev := shc*.shc_prev;
	    else
		ShipTail := shc*.shc_prev;
	    fi;
	    shc*.shc_prev := nil;
	    shc*.shc_next := ShipHead;
	    if ShipHead ~= nil then
		ShipHead*.shc_prev := shc;
	    else
		ShipTail := shc;
	    fi;
	    ShipHead := shc;
	fi;
	false
    fi
corp;

/*
 * closeFiles - flush and close the empire data files.
 */

proc closeFiles()void:

    if not Aborting then
	sectorFlush();
	shipFlush();
	closeEmpireFiles();
    fi;
corp;

/*
 * getFileName - read, into FileName, a data file name from 'empire.files'.
 */

proc getFileName(*char defName)void:
    register uint i;

    if FileFd = 0 then
	CharsCopy(&FileName[0], Path);
	CharsConcat(&FileName[0], defName);
    else
	i := 0;
	while
	    FileName[i] := ' ';
	    Read(FileFd, &FileName[i], 1) = 1 and FileName[i] ~= '\n'
	do
	    i := i + 1;
	od;
	if FileName[i] ~= '\n' then
	    Close(FileFd);
	    FileFd := 0;
	    abort("Bad file name in 'empire.files'");
	fi;
	FileName[i] := '\e';
    fi;
corp;

/*
 * tryToOpen - attempt to open one empire data file.
 */

proc tryToOpen(*char defName)Handle_t:
    Handle_t fd;

    if Aborting then
	fd := 0;
    else
	getFileName(defName);
	fd := Open(&FileName[0], MODE_OLDFILE);
	if fd = 0 then
	    if logOpen() then
		logString("*** ");
		logString("can't open file ");
		logString(&FileName[0]);
		logString(" - aborting\n");
		Close(LogFd);
	    fi;
	    closeEmpireFiles();
	    if FileFd ~= 0 then
		Close(FileFd);
		FileFd := 0;
	    fi;
	    Aborting := true;
	    setAborting();
/*
	    Exit(RETURN_FAIL);
*/
	fi;
    fi;
    fd
corp;

/*
 * openFiles - open the empire data files.
 */

proc openFiles(*char path; *[150] char pHelpDir, pDocDir)void:

    Aborting := false;
    Path := path;
    /* if we can't open "empire.files", we use some default names */
    CharsCopy(&FileName[0], path);
    CharsConcat(&FileName[0], "empire.files");
    FileFd := Open(&FileName[0], MODE_OLDFILE);

    WorldFd := 0;
    CountryFd := 0;
    SectorFd := 0;
    ShipFd := 0;
    FleetFd := 0;
    LoanFd := 0;
    OfferFd := 0;
    getFileName("empire.log");
    LogFileName := FileName;
    WorldFd := tryToOpen("empire.world");
    CountryFd := tryToOpen("empire.country");
    SectorFd := tryToOpen("empire.sector");
    ShipFd := tryToOpen("empire.ship");
    FleetFd := tryToOpen("empire.fleet");
    LoanFd := tryToOpen("empire.loan");
    OfferFd := tryToOpen("empire.offer");
    getFileName("/Help/");
    pHelpDir* := FileName;
    getFileName("/Doc/");
    pDocDir* := FileName;
    if FileFd ~= 0 then
	Close(FileFd);
	FileFd := 0;
    fi;
    SectorFree := 0;
    SectorHead := nil;
    SectorTail := nil;
    ShipFree := 0;
    ShipHead := nil;
    ShipTail := nil;
corp;

/*
 * readWorld - read the world header and country information
 */

proc readWorld(*World_t pWorld; *[COUNTRY_MAX] Country_t pCountry)bool:

    if Read(WorldFd, pWorld, sizeof(World_t)) ~= sizeof(World_t) then
	return(false);
    fi;
    if Read(CountryFd, pCountry, COUNTRY_MAX * sizeof(Country_t)) ~=
	    COUNTRY_MAX * sizeof(Country_t)
    then
	return(false);
    fi;
    true
corp;

/*
 * writeWorld - write the world header and country information
 */

proc writeWorld(*World_t pWorld; *[COUNTRY_MAX] Country_t pCountry)void:

    if not Aborting and Seek(CountryFd, 0, OFFSET_BEGINNING) = -1 then
	abort("Can't rewrite countries");
    fi;
    if not Aborting and
	Write(CountryFd, pCountry, COUNTRY_MAX * sizeof(Country_t)) ~=
	    COUNTRY_MAX * sizeof(Country_t)
    then
	abort("Can't write countries");
    fi;
    if not Aborting and Seek(WorldFd, 0, OFFSET_BEGINNING) = -1 then
	abort("Can't rewrite world file");
    fi;
    if not Aborting and
	Write(WorldFd, pWorld, sizeof(World_t)) ~= sizeof(World_t)
    then
	abort("Can't write world");
    fi;
corp;

/*
 * readSector - read the given sector into a given buffer.
 */

proc readSector(uint rowCol; *Sector_t s)void:

    if sectorLookup(rowCol) then
	if Seek(SectorFd, make(rowCol, ulong) * sizeof(Sector_t),
		OFFSET_BEGINNING) = -1
	then
	    abort("Can't seek to sector");
	fi;
	if not Aborting and
	    Read(SectorFd, &SectorHead*.sc_sector, sizeof(Sector_t)) ~=
		sizeof(Sector_t)
	then
	    abort("Can't read sector");
	fi;
    fi;
    s* := SectorHead*.sc_sector;
corp;

/*
 * writeSector - write the given sector from a given buffer.
 */

proc writeSector(uint rowCol; *Sector_t s)void:

    ignore sectorLookup(rowCol);
    SectorHead*.sc_sector := s*;
    SectorHead*.sc_dirty := true;
corp;

/*
 * readShip - read the given ship into a given buffer.
 */

proc readShip(uint shipNumber; *Ship_t ship)void:

    if shipLookup(shipNumber) then
	if Seek(ShipFd, make(shipNumber, ulong) * sizeof(Ship_t),
		OFFSET_BEGINNING) = -1
	then
	    abort("Can't seek to ship");
	fi;
	if not Aborting and
	    Read(ShipFd, &ShipHead*.shc_ship, sizeof(Ship_t)) ~= sizeof(Ship_t)
	then
	    abort("Can't read ship");
	fi;
    fi;
    ship* := ShipHead*.shc_ship;
corp;

/*
 * writeShip - write the given ship from a given buffer.
 */

proc writeShip(uint shipNumber; *Ship_t ship)void:

    ignore shipLookup(shipNumber);
    ShipHead*.shc_ship := ship*;
    ShipHead*.shc_dirty := true;
corp;

/*
 * readFleet - read the given fleet into a given buffer.
 */

proc readFleet(uint fleetNumber; *Fleet_t fleet)void:

    if Seek(FleetFd, make(fleetNumber, ulong) * sizeof(Fleet_t),
	    OFFSET_BEGINNING) = -1
    then
	abort("Can't seek to fleet");
    fi;
    if not Aborting and
	Read(FleetFd, fleet, sizeof(Fleet_t)) ~= sizeof(Fleet_t)
    then
	abort("Can't read fleet");
    fi;
corp;

/*
 * writeFleet - write the given fleet from a given buffer.
 */

proc writeFleet(uint fleetNumber; *Fleet_t fleet)void:

    if Seek(FleetFd, make(fleetNumber, ulong) * sizeof(Fleet_t),
	    OFFSET_BEGINNING) = -1
    then
	abort("Can't seek to fleet");
    fi;
    if not Aborting and
	Write(FleetFd, fleet, sizeof(Fleet_t)) ~= sizeof(Fleet_t)
    then
	abort("Can't write fleet");
    fi;
corp;

/*
 * readLoan - read the given loan into a given buffer.
 */

proc readLoan(uint loanNumber; *Loan_t loan)void:

    if Seek(LoanFd, make(loanNumber, ulong) * sizeof(Loan_t),
	    OFFSET_BEGINNING) = -1
    then
	abort("Can't seek to loan");
    fi;
    if not Aborting and Read(LoanFd, loan, sizeof(Loan_t)) ~= sizeof(Loan_t)
    then
	abort("Can't read loan");
    fi;
corp;

/*
 * writeLoan - write the given loan from a given buffer.
 */

proc writeLoan(uint loanNumber; *Loan_t loan)void:

    if Seek(LoanFd, make(loanNumber, ulong) * sizeof(Loan_t),
	    OFFSET_BEGINNING) = -1
    then
	abort("Can't seek to loan");
    fi;
    if not Aborting and Write(LoanFd, loan, sizeof(Loan_t)) ~= sizeof(Loan_t)
    then
	abort("Can't write loan");
    fi;
corp;

/*
 * readOffer - read the given offer into a given buffer.
 */

proc readOffer(uint offerNumber; *Offer_t offer)void:

    if Seek(OfferFd, make(offerNumber, ulong) * sizeof(Offer_t),
	    OFFSET_BEGINNING) = -1
    then
	abort("Can't seek to offer");
    fi;
    if not Aborting and 
	Read(OfferFd, offer, sizeof(Offer_t)) ~= sizeof(Offer_t)
    then
	abort("Can't read offer");
    fi;
corp;

/*
 * writeOffer - write the given offer from a given buffer.
 */

proc writeOffer(uint offerNumber; *Offer_t offer)void:

    if Seek(OfferFd, make(offerNumber, ulong) * sizeof(Offer_t),
	    OFFSET_BEGINNING) = -1
    then
	abort("Can't seek to offer");
    fi;
    if not Aborting and
	Write(OfferFd, offer, sizeof(Offer_t)) ~= sizeof(Offer_t)
    then
	abort("Can't write offer");
    fi;
corp;
