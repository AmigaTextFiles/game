/******************************************************************************************************/
/* Online-Script mit Arexx                                                                            */
/* 	© by Martin Wolf / Eternity Hard & Software	                                              */
/*				                                                                      */
/*      V1.01 Env-Vars eingebaut                                                                      */
/*      V1.02 Script verfeinert                                                                       */
/*                                                                                                    */
/*      First Bit set: 03.05.1998                                                                     */
/*      Last Bit set : 01.09.1999                                                                     */
/******************************************************************************************************/

OPTIONS RESULTS
OPTIONS FAILAT 31
SIGNAL ON ERROR

ADDRESS COMMAND
	'SetEnv ToT:Data/TOT_ONLINE 0'				/* Miami-EnvVar resetten              */
	counter_MW=0
	DO UNTIL SHOW('P','MIAMI.1')				/* Auf Miami warten                   */
	  SIGNAL OFF ERROR
	  'WaitForPort MIAMI.1'
	  SIGNAL ON ERROR
	  IF counter_MW=3 THEN
	     DO
	       'SetEnv ToT:Data/TOT_ONLINE -3'			/* Miami-EnvVar auf Fehler setzten */
	       EXIT
	     END
	  counter_MW=counter_MW+1
	END
 	IF SHOW('P','MIAMI.1') THEN
	DO
	  'SetEnv ToT:Data/TOT_ONLINE 1'    			/* Miami-Port wurde gefunden          */
	  miamiport = MIAMI.1					/* ist auf jeden Fall der aktive Port */
	END
	IF ~SHOW('P','MIAMI.1') THEN
	DO
	  'SetEnv ToT:Data/TOT_ONLINE -1'    			/* Konnte Miami nicht finden          */
	  EXIT
	END

ADDRESS (miamiport)
	SIGNAL OFF ERROR
	ISONLINE
	SIGNAL ON ERROR
	status_MW=rc

	IF (status_MW=0) THEN
	DO
	  SIGNAL OFF ERROR
	  ONLINE
	  ISONLINE
	  SIGNAL ON ERROR

ADDRESS COMMAND
	  IF (rc=0) THEN 'SetEnv ToT:Data/TOT_ONLINE -3'	/* Fehler beim LogIn		      */
  	  ELSE 'SetEnv ToT:Data/TOT_ONLINE 2'
	END
	ELSE ADDRESS COMMAND 'SetEnv ToT:Data/TOT_ONLINE 3'	/* Miami war schon Online !	      */

	EXIT

ERROR:
ADDRESS COMMAND
	'SetEnv ToT:Data/TOT_ONLINE -1'				/* Message : Found Miami              */
	EXIT

/******************************************************************************************************/
/* Erklärung zu den Env-Variablen                                                                     */
/* 	TOT_ONLINE   					                                              */
/*				                                                                      */
/*	-3=Fehler beim Miami-Login						                      */
/*	-2=Konnte Miami-Port nicht finden						              */
/*	-1=Fehler im Script						                              */
/*       0=Miami-Port wurde nicht gefunden                                                            */
/*       1=Miami-Port gefunden und Script versucht online zu gehen                                    */
/*	 2=Miami ist online 	                                                                      */
/*	 3=Miami war schon online !	                                                              */
/*                                                                                                    */
/******************************************************************************************************/
