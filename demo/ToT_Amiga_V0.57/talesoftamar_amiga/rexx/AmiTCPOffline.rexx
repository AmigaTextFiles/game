/******************************************************************************************************/
/* Online-Script für AmiTCP mit Arexx                                                                */
/* 	© by Martin Wolf / Eternity Hard & Software	                                              */
/*												      */
/*      First Bit set: 22.10.1999                                                                     */
/*      Last Bit set : 22.10.1999                                                                     */
/******************************************************************************************************/

OPTIONS RESULTS

ADDRESS COMMAND
	counter_MW=0
	DO UNTIL SHOW('P','AMITCP')			/* Auf AmiTCP warten */
	  SIGNAL OFF ERROR
	  'WaitForPort AMITCP'
	  SIGNAL ON ERROR
	  IF counter_MW=3 THEN EXIT	
	  counter_MW=counter_MW+1
	END
	'SetEnv ToT:Data/TOT_ONLINE 0'
        miamiport = AMITCP				/* ist auf jeden Fall der aktive Port */

ADDRESS (miamiport)
	DISCONNECT PPP
	EXIT
