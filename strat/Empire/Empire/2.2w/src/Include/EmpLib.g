/*
 * Amiga Empire
 *
 * Copyright (c) 1990 by Chris Gray
 *
 * Feel free to modify and use these sources however you wish, so long
 * as you preserve this copyright notice.
 */

/*
 * EmpLib.g - definitions for using the Empire library.
 */

*char EMPIRE_PORT_NAME = "Empire port";

uint
    INPUT_BUFFER_SIZE = 500,
    OUTPUT_BUFFER_SIZE = 500,
    REQUEST_PRIVATE_SIZE = 1000,
    EMPIRE_PRIVATE_SIZE = 1500;

type
    RequestType_t = enum {
	rt_nop, 			/* no operation */
	rt_log, 			/* log a string */
	rt_startClient, 		/* start a new client */
	rt_stopClient,			/* stop this client */
	rt_shutDown,			/* shut down the server */
	rt_flush,			/* request flush of all data */
	rt_poll,			/* check to see if we should exit */
	rt_writeWorld,  		/* write out the world buffer   */
	rt_manyOthersThatArePrivate
    },

    Request_t = struct {
	Message_t rq_message;		/* EXEC message structure */
	ulong rq_clientId;		/* id of this client */
	ulong rq_time;			/* time from server */
	uint rq_whichUnit;		/* unit identifier */
	uint rq_otherUnit;		/* identifier of other in pair */
	RequestType_t rq_type;		/* type of request */
	byte rq_pad;			/* pad to align rq_private */
	[REQUEST_PRIVATE_SIZE] char rq_private;
	/* rq_private is 'char' so we can use it for rt_log requests */
    },

    EmpireState_t = struct {

	/* fields used to interface to the library caller */

	proc()void es_serverRequest;
	proc()void es_writeUser;
	proc()bool es_readUser;
	proc()void es_echoOff;
	proc()void es_echoOn;
	proc()bool es_gotControlC;
	proc(/* uint tenthsOfSecond */)void es_sleep;
	proc(/* *char fileName */)bool es_log;
	Request_t es_request;
	[INPUT_BUFFER_SIZE] char es_textIn;
	[OUTPUT_BUFFER_SIZE] char es_textOut;
	*char es_textInPos;
	uint es_textOutPos;

	/* fields private to the Empire library itself */

	[EMPIRE_PRIVATE_SIZE] byte es_empirePrivate;
    };

extern
    OpenEmpireLibrary(ulong version)*Library_t,
    Empire(*EmpireState_t es)void,
    CloseEmpireLibrary()void;
