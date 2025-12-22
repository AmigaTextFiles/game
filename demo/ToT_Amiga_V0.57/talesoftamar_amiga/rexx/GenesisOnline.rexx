/******************************************************************************************************/
/* Online-Script für Genesis mit Arexx                                                                */
/* 	© by Martin Wolf / Eternity Hard & Software	                                              */
/*				                                                                      */
/*                                                                                                    */
/*      First Bit set: 22.10.1998                                                                     */
/*      Last Bit set : 22.07.2002                                                                     */
/*                                                                                                    */
/*      Version 1.00 : Erste Version aus der grauen Vergangenheit                                     */
/*      Version 1.01 : Undokumentierte Befehle eingebaut                                              */
/*                                                                                                    */
/******************************************************************************************************/


/* ACHTUNG Wichtig ! Bis zur Genesis-Version 1.06 ist der Arexx-Port extrem buggy. Deshalb            */
/*                   dieses Script nur mit einem Interface names PPP (also Modem-Config)              */


InterfaceName ='PPP'  /* Setze hier deinen Interface-Namen / Put in your preferred InterfaceName here */


OPTIONS RESULTS
OPTIONS FAILAT 31
SIGNAL ON ERROR

ADDRESS COMMAND
	'SetEnv ToT:Data/TOT_ONLINE 0'				/* Genesis-EnvVar resetten             */
	counter_MW=0
	DO UNTIL SHOW('P','GENESIS')				/* Auf Genesis warten                  */
	  SIGNAL OFF ERROR
	  'WaitForPort GENESIS'
	  SIGNAL ON ERROR
	  IF counter_MW=3 THEN EXIT	
	  counter_MW=counter_MW+1
	END
 	IF SHOW('P','GENESIS') THEN
	DO
	  'SetEnv ToT:Data/TOT_ONLINE 1'    			/* Genesis-Port wurde gefunden         */
	  genesisport = GENESIS					/* ist auf jeden Fall der aktive Port  */
	END
	IF ~SHOW('P','GENESIS') THEN
	DO
	  'SetEnv ToT:Data/TOT_ONLINE -1'    			/* Konnte Genesis nicht finden         */
	  EXIT
	END		

ADDRESS (genesisport)
	SIGNAL OFF ERROR
 	ISONLINE InterfaceName
	SIGNAL ON ERROR
	status_MW=rc

	IF (status_MW=0) THEN
	DO
	  SIGNAL OFF ERROR
	  ONLINE InterfaceName
	  DO FOREVER 						/*warten für den LogIN                 */
	    ISONLINE InterfaceName
	    status_MW=rc
	    IF status_MW=1 THEN LEAVE
	    IF status_MW=0 THEN LEAVE
            END
	  ISONLINE InterfaceName
	  status_MW=rc
	  SIGNAL ON ERROR

ADDRESS COMMAND
	  IF (rc=0) THEN
	  DO
	    'RequestChoice >NIL: "ToT-Message" "The interface name in the rexx-script GenesisOnline.rexx is wrong!" "Ok"'
	    'SetEnv ToT:Data/TOT_ONLINE -3'			/* Fehler beim LogIn		      */
	  END
  	  ELSE 'SetEnv ToT:Data/TOT_ONLINE 2'
	END
	ELSE ADDRESS COMMAND 'SetEnv ToT:Data/TOT_ONLINE 3'/* Genesis war schon Online !	      */

	EXIT

ERROR:
ADDRESS COMMAND
	'SetEnv ToT:Data/TOT_ONLINE -1'				/* Message : Found Miami              */
	EXIT	

/******************************************************************************************************/
/* Erklärung zu den Env-Variablen                                                                     */
/* 	TOT_ONLINE   					                                              */
/*				                                                                      */
/*	-3=Fehler beim Genesis-Login						                      */
/*	-2=Konnte Genesis-Port nicht finden						              */
/*	-1=Fehler im Script						                              */
/*       0=Genesis-Port wurde nicht gefunden                                                          */
/*       1=Genesis-Port gefunden und Script versucht online zu gehen                                  */
/*	 2=Genesis ist online 	                                                                      */
/*	 3=Genesis war schon online !	                                                              */
/*                                                                                                    */
/******************************************************************************************************/
