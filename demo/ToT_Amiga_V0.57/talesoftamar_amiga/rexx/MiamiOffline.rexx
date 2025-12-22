/******************************************************************************************************/
/* Online-Script mit Arexx                                                                            */
/* 	© by Martin Wolf / Eternity Hard & Software	                                              */
/*      First Bit set: 03.05.1998                                                                     */
/*      Last Bit set :                                                                                */
/******************************************************************************************************/

OPTIONS RESULTS

ADDRESS COMMAND
	DO UNTIL SHOW('P','MIAMI.1')			/* Auf Miami warten */
	  SIGNAL OFF ERROR
	  'WaitForPort MIAMI.1'
	  SIGNAL ON ERROR
	END
        miamiport = MIAMI.1				/* ist auf jeden Fall der aktive Port */

ADDRESS (miamiport)
	OFFLINE
	EXIT
