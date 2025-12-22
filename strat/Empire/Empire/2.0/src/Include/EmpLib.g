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

/*
 * Note for programmers:
 *
 * The Empire.library completely follows the standards for AmigaDOS shared,
 * disk-resident libraries, so it can be used from any programming language,
 * including assembler, C, BASIC, etc. Some specifics on the fields in the
 * shared EmpireState_t structure:
 *
 * fields of type 'ulong' are 32 bit unsigned integers
 * fields of type 'uint' are 16 bit unsigned integers
 * the enumeration field, 'rq_type' is an 8 bit field, with value 0 used
 *     for 'rt_nop', 1 for 'rt_log', etc.
 * the various 'proc' fields are pointers to functions supplied by the
 *     client code. They are called using the register conventions of
 *     AmigaDOS. This means that they CANNOT be simple C, Draco, Modula,
 *     etc., functions, since those languages do not normally follow that
 *     convention. See 'Empire.d' for how to meet that convention in Draco.
 *     Similar techniques are available for other languages. If all else
 *     fails, you can use an assembler interface routine.
 *
 * serverRequest - a server request is set up in the Request_t field of
 *     the EmpireState_t structure. This should be passed as a message to
 *     the server's message port, and 'serverRequest' should return when
 *     the reply is received.
 * writeUser - the 'es_textOutPos' characters in 'es_textOut' should be
 *	written to the player. The buffer may contain newlines.
 * readUser - an input line from the user should be read into 'es_textIn'.
 *     'es_textInPos' should be set to point to the beginning of that buffer.
 *     The string read should not contain a terminating newline, but should
 *     be terminated by a nul (0) character. If no input is available,
 *     'readUser' should return 0 (the low order byte of D0 is sufficient),
 *     otherwise it should return non-zero.
 * echoOff - the library is about to read a password, so echoing should
 *     be disabled.
 * echoOn - the password read is done, so echoing should be re-enabled.
 * gotControlC - return non-zero (low order byte of D0 is sufficient) if
 *     an interrupt from the user has arrived. Only indicate that interrupt
 *     once. Return zero otherwise.
 * sleep - the 32 bit value passed in D0 is the number of 10ths of a second
 *     to delay. This is used to time the '@' and '!' characters displayed
 *     during fights. You should disable this feature only on agreement of
 *     those who will be playing.
 * log - A0 points to a nul (0) terminated filename which the user has
 *     requested be used for logging the session. A 32 bit 0 value indicates
 *     that any current logging should be turned off. If you wish to deny
 *     logging, or the given filename cannot be opened, return zero in D0,
 *     otherwise return non-0 in D0 to indicate success. Do not attempt to
 *     free the filename - it is in 'es_textIn'.
 */

*char
    EMPIRE_PORT_NAME = "Empire port",
    TEST_PORT_NAME = "Empire test port";

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
	/* version 0 is fine for now */
    Empire(*EmpireState_t es)void,
	/* the struct should be in MEMF_PUBLIC memory, since it is shared
	   between the client and the server. A single call to 'Empire'
	   will perform a full Empire session. No routines outside of
	   'Empire.library' will be called, other than those provided by
	   the client program via the 'EmpireState_t' structure. */
    CloseEmpireLibrary()void;
