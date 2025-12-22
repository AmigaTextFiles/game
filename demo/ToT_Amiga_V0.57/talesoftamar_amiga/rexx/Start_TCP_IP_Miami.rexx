/******************************************************************************************************/
/* Online-Script mit Arexx                                                                            */
/* 	© by Martin Wolf / Eternity Hard & Software	                                              */
/*      First Bit set: 03.05.1998                                                                     */
/*      Last Bit set :                                                                                */
/*      	                                                                                      */
/*                                                                                                    */
/*      Version 1.01 : Wenn Port schon offen ist wird Script übersprungen                             */
/*      Version 1.02 : Env-Var Deja wird angelegt				                      */
/*      Version 1.03 : Library rexxsupport.library wird jetzt geladen				      */
/*      Version 1.04 : Das Vorhanden sein des Stacks wird jetzt auch überprüft			      */
/*                                                                                                    */
/******************************************************************************************************/

OPTIONS RESULTS


ADDRESS COMMAND
	IF ~SHOW('L','rexxsupport.library') THEN	/* Library laden, damit			*/
	  CALL ADDLIB('rexxsupport.library',0,-30,0)	/* Assign-Suche ohne Meldung		*/

	IF ~SHOWLIST('A','MIAMI') THEN			/* Wenn kein TCPIP-Assign da ist	*/
	  DO
	    'Setenv ToT:Data/TCPIPDeja -1'		/* direkt raus hier			*/
	    EXIT
	  END

	IF SHOW('P','MIAMI.1') THEN			/* TCPIP-Port da ?			*/
	  'Setenv ToT:Data/TCPIPDeja 1'			/* Env-Var setzen			*/
	ELSE
	  'Setenv ToT:Data/TCPIPDeja 0'			/* keiner gestartet			*/
	IF ~SHOW('P','MIAMI.1') THEN
	  DO
	    IF ~EXISTS('Miami:Miami') THEN		/* Auf rexxsys verzichten		*/
	      DO					/* Üble Sache ! TCP-IP nicht korrekt installiert*/
	        'Setenv ToT:Data/TCPIPDeja -1'		/* es wurde wieder rumgefuscht 		*/ 
	        EXIT
	      END	    
	    ELSE
	      'run >NIL: Miami:Miami NOGUI >NIL:'		/* Existiert TCPIP-Stack überhaupt dort ?*/
	    DO UNTIL SHOW('P','MIAMI.1')		/* Auf TCPIP-Stack warten warten	*/
	      SIGNAL OFF ERROR				/* Fehler-Meldung solange auschalten	*/
	      'WaitForPort MIAMI.1'			/* Isser nu da ?			*/
	      SIGNAL ON ERROR				/* Fehler-Meldungen wieder ein		*/
	    END						
	  END
	ENDIF
        tcpipport = MIAMI.1				/* ist auf jeden Fall der aktive Port	*/

ADDRESS (tcpipport)
	HIDE
	EXIT
