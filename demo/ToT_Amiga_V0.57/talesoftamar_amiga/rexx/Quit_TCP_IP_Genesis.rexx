/******************************************************************************************************/
/* Online-Script mit Arexx                                                                            */
/* 	© by Martin Wolf / Eternity Hard & Software	                                              */
/*      First Bit set: 03.05.1998                                                                     */
/*      Last Bit set :                                                                                */
/*      	                                                                                      */
/*                                                                                                    */
/*      Version 1.01 : Env-Var wird jetzt abgefragt			                              */
/*      Version 1.02 : Env-Var -1 verursacht nun keinen Fehler mehr			              */
/*                                                                                                    */
/******************************************************************************************************/


OPTIONS RESULTS

ADDRESS COMMAND
	IF (OPEN('EnvVar','ToT:Data/TCPIPDeja','R')) THEN
	  DO
	  IF (0=(READCH('EnvVar',1))) THEN
	    DO UNTIL SHOW('P','GENESIS')			/* Auf Genesis warten */
	    SIGNAL OFF ERROR
	    'WaitForPort GENESIS'
	    SIGNAL ON ERROR
	    genesisport = GENESIS				/* ist auf jeden Fall der aktive Port */

ADDRESS (genesisport)
	    QUIT
  	    END
	  END
	EXIT
