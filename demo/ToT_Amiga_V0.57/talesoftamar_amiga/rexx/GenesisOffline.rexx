/******************************************************************************************************/
/* Online-Script für Genesis mit Arexx                                                                */
/* 	© by Martin Wolf / Eternity Hard & Software	                                              */
/*												      */
/*      First Bit set: 22.10.1999                                                                     */
/*      Last Bit set : 22.10.1999                                                                     */
/*                                                                                                    */
/*      Version 1.00 : Erste Version aus der grauen Vergangenheit                                     */
/*      Version 1.01 : Undokumentierte Befehle eingebaut                                              */
/*                                                                                                    */
/******************************************************************************************************/


OPTIONS RESULTS

ADDRESS COMMAND
	DO UNTIL SHOW('P','GENESIS')			/* Auf Genesis warten */
	  SIGNAL OFF ERROR
	  'WaitForPort GENESIS'
	  SIGNAL ON ERROR
	END
        genesisport = GENESIS				/* ist auf jeden Fall der aktive Port */

ADDRESS (genesisport)
	OFFLINE
	EXIT
