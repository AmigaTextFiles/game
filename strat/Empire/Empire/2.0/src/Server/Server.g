/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

/*
 * Server.g - include file for Empire server - define functions.
 */

extern

    /* fileIO.d */

    log(*char message)void,
    logN(*char m1; ulong n; *char m2)void,
    abort(*char message)void,
    closeFiles()void,
    openFiles(*char path; *[150] char pHelpDir, pDocDir)void,
    readWorld(*World_t pWorld; *[COUNTRY_MAX] Country_t pCountry)bool,
    writeWorld(*World_t pWorld; *[COUNTRY_MAX] Country_t pCountry)void,
    readSector(uint rowCol; *Sector_t s)void,
    writeSector(uint rowCol; *Sector_t s)void,
    readShip(uint shipNumber; *Ship_t sh)void,
    writeShip(uint shipNumber; *Ship_t sh)void,
    readFleet(uint fleetNumber; *Fleet_t fl)void,
    writeFleet(uint fleetNumber; *Fleet_t fl)void,
    readLoan(uint loanNumber; *Loan_t loan)void,
    writeLoan(uint loanNumber; *Loan_t loan)void,
    readOffer(uint offerNumber; *Offer_t offer)void,
    writeOffer(uint offerNumber; *Offer_t offer)void,

    /* ServerMain.d */

    setAborting()void;
