/******************************************************************************************************/
/* Online-Script mit Arexx                                                                            */
/* 	© by Martin Wolf / Eternity Hard & Software	                                              */
/*      First Bit set: 03.05.1998                                                                     */
/*      Last Bit set : 22.07.2002                                                                     */
/*      	                                                                                      */
/*                                                                                                    */
/*      Version 1.01 : Wenn Port schon offen ist wird Script übersprungen                             */
/*      Version 1.02 : Env-Var Deja wird angelegt				                      */
/*      Version 1.03 : Library rexxsupport.library wird jetzt geladen				      */
/*      Version 1.04 : Das Vorhanden sein des Stacks wird jetzt auch überprüft			      */
/*      Version 1.05 : OS 3.9 Genesis wird nun auch abgefragt					      */
/*      Version 1.06 : OS 3.9 Genesis wird nun auch gestartet					      */
/*                                                                                                    */
/******************************************************************************************************/

OPTIONS RESULTS


ADDRESS COMMAND
	IF ~SHOW('L','rexxsupport.library') THEN	/* Library laden, damit			*/
	  CALL ADDLIB('rexxsupport.library',0,-30,0)	/* Assign-Suche ohne Meldung		*/

	IF ~SHOWLIST('A','AMITCP') THEN			/* Wenn kein TCPIP-Assign da ist	*/
	  DO
	    'Setenv ToT:Data/TCPIPDeja -1'		/* direkt raus hier			*/
	    EXIT
	  END

	IF ~EXISTS('AmiTCP:Genesis') THEN		/* Auf rexxsys verzichten		*/
	  DO						/* Üble Sache ! TCP-IP nicht korrekt installiert*/
	    IF ~EXISTS('AmiTCP:GenesisRA') THEN		/* OS3.9 Genesis abfragen...		*/
	      DO
	      'Setenv ToT:Data/TCPIPDeja -1'		/* es wurde wieder rumgepfuscht 	*/ 
	      EXIT
	      END
	  END

	IF SHOW('P','GENESIS') THEN			/* TCPIP-Port da ?			*/
	  'Setenv ToT:Data/TCPIPDeja 1'			/* Env-Var setzen			*/
	ELSE
	  'Setenv ToT:Data/TCPIPDeja 0'			/* keiner gestartet			*/
	IF ~SHOW('P','GENESIS') THEN
	  DO
	    IF EXISTS('AmiTCP:Genesis') THEN		/* Auf rexxsys verzichten		*/
	    DO
	      'run >NIL: AmiTCP:Genesis >NIL:'		/* Existiert TCPIP-Stack überhaupt dort ?*/
	    END
	    IF EXISTS('AmiTCP:GenesisRA') THEN		/* Auf rexxsys verzichten		*/
	    DO
	      'run >NIL: AmiTCP:GenesisRA >NIL:'	/* Existiert TCPIP-Stack überhaupt dort ?*/
	    END
	    DO UNTIL SHOW('P','GENESIS')		/* Auf TCPIP-Stack warten warten	*/
	      SIGNAL OFF ERROR				/* Fehler-Meldung solange auschalten	*/
	      'WaitForPort GENESIS'			/* Isser nu da ?			*/
	      SIGNAL ON ERROR				/* Fehler-Meldungen wieder ein		*/
	    END						
	  END
	ENDIF
        tcpipport = GENESIS				/* ist auf jeden Fall der aktive Port	*/

ADDRESS (tcpipport)
	HIDE
	EXIT
