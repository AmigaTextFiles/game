/******************************************************************************************************/
/* Online-Script für AmiTCP mit Arexx                                                                 */
/* 	© by Martin Wolf / Eternity Hard & Software	                                              */
/*				                                                                      */
/*                                                                                                    */
/*      First Bit set: 22.10.1998                                                                     */
/*      Last Bit set : 09.11.1999                                                                     */
/******************************************************************************************************/

OPTIONS RESULTS
OPTIONS FAILAT 31
SIGNAL ON ERROR

ADDRESS COMMAND
	'SetEnv ToT:Data/TOT_ONLINE 0'				/* AmiTCP-EnvVar resetten              */
	counter_MW=0
	DO UNTIL SHOW('P','AMITCP')				/* Auf AmiTCP warten                   */
	  SIGNAL OFF ERROR
	  'WaitForPort AMITCP'
	  SIGNAL ON ERROR
	  IF counter_MW=3 THEN EXIT
	  counter_MW=counter_MW+1
	END
 	IF SHOW('P','AMITCP') THEN
	DO
	  'SetEnv ToT:Data/TOT_ONLINE 1'    			/* AmiTCP-Port wurde gefunden          */
	  genesisport = AMITCP					/* ist auf jeden Fall der aktive Port   */
	END
	IF ~SHOW('P','AMITCP') THEN
	DO
	  'SetEnv ToT:Data/TOT_ONLINE 0'    			/* Konnte AmiTCP nicht finden          */
	  EXIT
	END


/******************************************************************************************************/
/* Erklärung zu den Env-Variablen                                                                     */
/* 	TOT_ONLINE   					                                              */
/*				                                                                      */
/*	-3=Fehler beim AmiTCP-Login						                      */
/*	-2=Konnte AmiTCP-Port nicht finden						              */
/*	-1=Fehler im Script						                              */
/*       0=AmiTCP-Port wurde nicht gefunden                                                          */
/*       1=AmiTCP-Port gefunden und Script versucht online zu gehen                                  */
/*	 2=AmiTCP ist online 	                                                                      */
/*	 3=AmiTCP war schon online !	                                                              */
/*                                                                                                    */
/******************************************************************************************************/
