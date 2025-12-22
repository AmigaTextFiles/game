/*
** Amiga_Serial
** Amiga serial i/o stuff
**
** $Id: amiga_serial.c,v 1.5 1998/07/14 20:59:02 nobody Exp $
** $Revision: 1.5 $
** $Author: nobody $
** $Date: 1998/07/14 20:59:02 $
*/

#include <stdio.h>
#include <utility/tagitem.h>
#include <exec/exec.h>
#include <proto/exec.h>
#include <proto/utility.h>
#include <devices/serial.h>
#include "amiga_serial.h"

#include "types.h"
#include "newmenu.h"
#include "args.h"
#include "multi.h"

struct MsgPort *SerialMP,   *SerialMPWrite;
struct IOExtSer *SerialIO,  *SerialIOWrite;
short amiserial_write_IO = 0;                      //  Which IORequest to use

#define SEIO struct IOExtSer *
#define STIO struct IORequest *

#define MAXSERIAL   128
#define SERFLAGS    (SERF_7WIRE | SERF_RAD_BOOGIE | SERF_XDISABLED)

#define db_printf(a) /* printf a */

int amiserial_unit;
char amiserial_device[MAXSERIAL];
int amiserial_up=0;
UBYTE amiserial_busy_write = 0;

extern int Inferno_verbose;
extern int com_speed;
extern int com_open;

UBYTE sendbuffer[512];

#define RCVBUFSIZE 4096
UBYTE ReceiveBuffer[RCVBUFSIZE];
int BufferPos=0;
int BufferFill=0;

#define CARRIER_SIGNAL (1<<5)

void amiserial_do(struct IOExtSer *io, ULONG command)
{
	io->IOSer.io_Command = command;
	DoIO((STIO)io);
}

void amiserial_close(void)
// shut down serial port
{
	if (!amiserial_up)
		return;
	if (!CheckIO((STIO)SerialIO)) {
		AbortIO((STIO)SerialIO);
		WaitIO((STIO)SerialIO);
	}
	if (!CheckIO((STIO)SerialIOWrite)) {
		AbortIO((STIO)SerialIOWrite);
		WaitIO((STIO)SerialIOWrite);
	}
	CloseDevice((STIO)SerialIO);

	DeleteExtIO((STIO)SerialIO);
	DeleteExtIO((STIO)SerialIOWrite);

	DeleteMsgPort(SerialMP);
	DeleteMsgPort(SerialMPWrite);
	amiserial_up=0;

	if (Inferno_verbose) printf("Init_serial: Serial communication subsystem shut down\n");

	return;
}

int amiserial_init(void)
// Initialize the serial port
{
	int i;
	int ioerr;

	if (amiserial_up)
		return 0;

	atexit(amiserial_close);

	if (Inferno_verbose) printf("Init_serial: Attempting to initialize serial hardware\n");

	i=FindArg("-serialname");
	if (i) strncpy(amiserial_device, Args[i+1], MAXSERIAL);
	else   strcpy (amiserial_device, "serial.device");


	i=FindArg("-serialunit");
	if (i) amiserial_unit = atoi(Args[i+1]);
	else   amiserial_unit = 0;

	if (Inferno_verbose) printf("Init_serial: Serial device name %s, unit %d\n", amiserial_device, amiserial_unit);

	SerialMP = CreateMsgPort();
	if (!SerialMP) return -1;

	SerialMPWrite = CreateMsgPort();
	if (!SerialMPWrite) goto cleanup;

	if (Inferno_verbose) printf("Init_serial: Created serial message port\n");

	SerialIO = (SEIO)CreateExtIO(SerialMP, sizeof(struct IOExtSer));
	if (!SerialIO) goto cleanup;

	SerialIOWrite = (SEIO)CreateExtIO(SerialMPWrite, sizeof(struct IOExtSer));
	if (!SerialIOWrite) goto cleanup;

	if (Inferno_verbose) printf("Init_serial: Created IOExtSer for Read and Write\n");

	SerialIO->io_SerFlags = SERFLAGS;
	SerialIO->io_SerFlags &= ~SERF_PARTY_ON;

	ioerr = OpenDevice(amiserial_device, 0L, (STIO)SerialIO, 0);
	if (ioerr) goto cleanup;

	memcpy(SerialIOWrite, SerialIO, sizeof(struct IOExtSer));
	SerialIOWrite->IOSer.io_Message.mn_ReplyPort = SerialMPWrite;
	SerialIOWrite->IOSer.io_Message.mn_Node.ln_Type = 0;

	// Make sure those two babies have been used
	amiserial_do(SerialIO,         CMD_CLEAR);
	amiserial_do(SerialIOWrite,    CMD_CLEAR);

	if (Inferno_verbose) printf("Init_serial: Successful\n");

	amiserial_up = 1;
	return 0;

cleanup:
	if (SerialIO)           DeleteExtIO((STIO)SerialIO);
	if (SerialIOWrite)      DeleteExtIO((STIO)SerialIOWrite);
	if (SerialMP)           DeleteMsgPort(SerialMP);
	if (SerialMPWrite)      DeleteMsgPort(SerialMPWrite);
	return -1;
}

int amiserial_chars(void)
// Query the number of pending characters at the serial port for reading
{
	SerialIO->IOSer.io_Command = SDCMD_QUERY;
	SerialIO->IOSer.io_Actual  = 0;
	DoIO((STIO)SerialIO); // used to be SendIO
	return (int)(SerialIO->IOSer.io_Actual);
}

int amiserial_read(char *where, int chars)
{
	SerialIO->IOSer.io_Data     = (APTR)where;
	SerialIO->IOSer.io_Length   = chars;
	amiserial_do(SerialIO, CMD_READ);
	return SerialIO->IOSer.io_Actual;
}

void amiserial_flush(void)
{
	SerialIO->IOSer.io_Command = CMD_CLEAR;
	DoIO((STIO)SerialIO);
	return;
}

PORT * PortOpenGreenleafFast(int port, int baud,char parity,int databits, int stopbits)
// Used by Descent to open a port
// We use it to set serial parameters (port is opened at the start
// by amiserial_init
{
	PORT *n;

	if (Inferno_verbose)
		db_printf(("serial_open_port: Port %d (ignored), baud %d, format %1d %c %1d\n",
			port, baud, databits, parity, stopbits));

	db_printf(("serial_open_port: bufsizes (%d, %d)\n", SerialIO->io_RBufLen,
				SerialIOWrite->io_RBufLen));

	n=(PORT *)malloc(sizeof(PORT));
	if (n) {
		n->status=0;
		SerialIO->io_Baud       = (ULONG)baud;
		SerialIO->io_ReadLen    = (UBYTE)databits;
		SerialIO->io_WriteLen   = (UBYTE)databits;
		SerialIO->io_StopBits   = (UBYTE)stopbits;
		SerialIO->IOSer.io_Command = SDCMD_SETPARAMS;
		if (Inferno_verbose) printf("serial_open_port: Setting serial device parameters for read\n");
		DoIO((STIO)SerialIO);
		SerialIOWrite->io_Baud       = (ULONG)baud;
		SerialIOWrite->io_ReadLen    = (UBYTE)databits;
		SerialIOWrite->io_WriteLen   = (UBYTE)databits;
		SerialIOWrite->io_StopBits   = (UBYTE)stopbits;
		SerialIOWrite->IOSer.io_Command = SDCMD_SETPARAMS;
		if (Inferno_verbose) printf("serial_open_port: Setting serial device parameters for write\n");
		DoIO((STIO)SerialIOWrite);

		if (Inferno_verbose) printf("serial_open_port: Done\n");
	}
	return n;
}

void SetDtr(PORT *port,int state) // not used
{
	return;
}

void SetRts(PORT *port,int state) // not used
{
	return;
}

void UseRtsCts(PORT *port,int state) // 7WIRE handshake by default
{
	return;
}

void WriteChar(PORT *port,char ch)
// Write one character to the serial port. First argument is ignored
// since Descent only uses one port
{
	SerialIOWrite->IOSer.io_Length = 1;
	SerialIOWrite->IOSer.io_Data = (APTR)&ch;
	SerialIOWrite->IOSer.io_Command = CMD_WRITE;
	DoIO((STIO)SerialIOWrite);
}

void ClearRXBuffer(PORT *port) // Not uesd
{
	return;
}

void ReadBufferTimed(PORT *port, char *buf,int a, int b) // not used
{
	return;
}

int Change8259Priority(int a) // just flags success
{
	return ASSUCCESS;
}

int FastSetPortHardware(PORT *port,int IRQ, int baseaddr) // just flags success
{
	return ASSUCCESS;
}

void FastSet16550TriggerLevel(int a)
{
	return;
}

void FastSet16550UseTXFifos(int a)
{
	return;
}


void FastSavePortParameters(PORT *port)
{
	return;
}

int PortClose(PORT *port) // port automatically deallocated by amiserial_close
{
	return ASSUCCESS;
}

void FastRestorePortParameters(int num)
{
	return;
}

int GetCd(PORT *port)
// Query the status of the CARRIER DETECT signal
{
	UWORD Serial_Status;

	SerialIO->IOSer.io_Command = SDCMD_QUERY;
	SendIO((STIO)SerialIO);

	Serial_Status = SerialIO->io_Status;
	if (Serial_Status & CARRIER_SIGNAL) return 0;   // CD is low-active
	else return 1;
}

int ReadCharTimed(PORT *port, int blah) // Only used to flush the device...
{
	SerialIO->IOSer.io_Command = CMD_CLEAR;
	DoIO((STIO)SerialIO);
	return -1; // returns -1 (no more characters)
}

int old_ReadChar(PORT *port)
// Read a character from the serial port
// returns -1 if the port is empty.
{
	int chars;
	unsigned char buffer[20];
	int ret;

	buffer[0]=0;
	chars=amiserial_chars();
	db_printf(("amiga_serial: ReadChar has %d character pending\n", chars));
	if (chars) {    // There are pending characters
		SerialIO->IOSer.io_Command = CMD_READ;
		SerialIO->IOSer.io_Data = (APTR)buffer;
		SerialIO->IOSer.io_Length = 1;
		db_printf(("amiga_serial: ReadChar reads one charachter\n"));
		DoIO((STIO)SerialIO);
		db_printf(("amiga_serial: ReadChar has read %u\n", (unsigned int)buffer[0]));
		ret = (int)buffer[0];
		if (ret<0) ret=-ret;
		return ret;
	} else {        // No characters available
		return ASBUFREMPTY;
	}
}

int ReadChar(PORT *port)
{
	int ret;
	int chars;
	if (BufferPos<=BufferFill && BufferFill!=0) {
		ret = (int)ReceiveBuffer[BufferPos++];
		if (ret<0) ret=-ret;
		return ret;
	} else {
		chars = amiserial_chars();
		if (!chars) return ASBUFREMPTY;
		if (chars>RCVBUFSIZE) chars = RCVBUFSIZE;
		SerialIO->IOSer.io_Command = CMD_READ;
		SerialIO->IOSer.io_Data    = (APTR)ReceiveBuffer;
		SerialIO->IOSer.io_Length  = (ULONG)chars;
		SerialIO->IOSer.io_Flags  |= IOF_QUICK;
		DoIO((STIO)SerialIO);
		BufferFill = (int)(SerialIO->IOSer.io_Actual)-1;
		BufferPos = 0;
		ret = (int)ReceiveBuffer[BufferPos++];
		if (ret<0) ret=-ret;
		return ret;
	}
}


void ClearLineStatus(PORT *port)
{
	return;
}
int HMInputLine(PORT *port, int a, char *buf, int b)    // stuff below only used by modem stuff
{
	return 0;
}
void HMWaitForOK(int a, int b)
{
	return;
}
HMSendString(PORT *port, char *msg)
{
	return;
}
void HMReset(PORT *port)
{   
	return;
}
void HMDial(PORT *port, char *pPhoneNum)
{
	return;
}
void HMSendStringNoWait(PORT *port, char *pbuf,int a)
{
	return;
}
void HMAnswer(PORT *port)
{
	return;
}
void ClearTXBuffer(PORT *port) // Not used
{
	return;
}
void WriteBuffer(PORT *port, char *pbuff, int len) // Not used
{
	return;
}

#define EOR_MARK 0xaa

#if 0
void com_send_ptr(char *ptr, int len)
{
	int i=0;
	BYTE error;
	ULONG WaitMask = SIGBREAKF_CTRL_C|SIGBREAKF_CTRL_D|1<<(SerialMPWrite->mp_SigBit);
	ULONG GotSig;

	db_printf(("com_send_ptr_amiga: sending %d characters, packet type %d\n", len, *ptr));

	while (len) {
		sendbuffer[i] = (UBYTE)*ptr++;
		if (sendbuffer[i]==EOR_MARK) {
			i++;
			sendbuffer[i]=EOR_MARK;
		}
		i++;
		len--;
	}
	sendbuffer[i++]=EOR_MARK;
	sendbuffer[i++] = 0;
	db_printf(("com_send_ptr_amiga: prepared package for sending\n"));
	if (CheckIO((STIO)SerialIOWrite) == NULL) {
		error=WaitIO((STIO)SerialIOWrite);
		if (error) printf("com_send_ptr_amiga: Error %d during WaitIO()\n", error);
	}
	db_printf(("com_send_ptr_amiga: sending package\n"));
	SerialIOWrite->IOSer.io_Data    = (APTR)sendbuffer;
	SerialIOWrite->IOSer.io_Length  = (ULONG)i;
	SerialIOWrite->IOSer.io_Command = CMD_WRITE;
	SerialIOWrite->IOSer.io_Flags |= IOF_QUICK;
	SendIO((STIO)SerialIOWrite);
/*    db_printf(("com_send_ptr_amiga: Going to sleep\n"));
	while (1) {
		GotSig = Wait(WaitMask);
		db_printf(("com_send_ptr_amiga: Yawn\n"));
		if (SIGBREAKF_CTRL_D & GotSig) break;               //  ^D to kick it`s ass
		if (SIGBREAKF_CTRL_C & GotSig) exit(1);             //  ^C to kill it
		if (CheckIO(SerialIOWrite)) {
			WaitIO(SerialIOWrite);
			break;
		}
	}*/

	db_printf(("com_send_ptr_amiga: package send ioError code %d\n",
		SerialIOWrite->IOSer.io_Error));
}
#endif

/*
 * com_send_ptr second generation
 ***************************************************************************
 *
 * The package to send is wrapped into a "superpackage" of the following layout:
 * 'PACK'       4 byte header
 * len          ULONG length of package
 * <data>       len bytes of data
 *
 * EOR_MARKS are not doubled, and are not used
 *
 * Caveats: No longer compatible with PC serial stuff
 *          Slightly more overhead due to header
 *
 * PLUS:    Might work.
 *          More efficient because of full package send.
 *
 */
void com_send_ptr(char *ptr, int len)
{
	ULONG packlen = (ULONG)len;

	db_printf(("amiserial_com_send_ptr: about to send package length %d type %u\n", len, (unsigned int)*ptr));
	sendbuffer[0] = 'P';                    // Write header
	sendbuffer[1] = 'A';
	sendbuffer[2] = 'C';
	sendbuffer[3] = 'K';
	*(ULONG *)(&sendbuffer[4]) = packlen;   // Write length
	memcpy(&sendbuffer[8], ptr, len);       // Copy bytes into send buffer

	db_printf(("amiserial_com_send_ptr: Package prepared, verifying accessability\n"));

	if (amiserial_busy_write) {
		db_printf(("amiserial_com_send_ptr: Wait for receive device\n"));
		if (!(CheckIO((STIO)SerialIO))) {   //  Check if we need to receive first
			WaitIO((STIO)SerialIO);
		}
		db_printf(("amiserial_com_send_ptr: Wait for send device\n"));
		WaitIO((STIO)SerialIOWrite);
		amiserial_busy_write = 0;
	}

	db_printf(("amiserial_com_send_ptr: Sending data...\n"));

	SerialIOWrite->IOSer.io_Data    = (APTR)sendbuffer;
	SerialIOWrite->IOSer.io_Length  = (ULONG)len+8;
	SerialIOWrite->IOSer.io_Command = CMD_WRITE;
	SerialIOWrite->IOSer.io_Flags |= IOF_QUICK;
//    SendIO((STIO)SerialIOWrite);
	DoIO((STIO)SerialIOWrite);

//    amiserial_busy_write = 1;
	db_printf(("amiserial_com_send_ptr: After-send error codes are %d on %d\n",
			SerialIOWrite->IOSer.io_Error, amiserial_write_IO));

//    amiserial_write_IO = (amiserial_write_IO+1)%2;
}

/*
 * com_receive_ptr
 ***************************************************************************
 *
 * Try to receive a package from the serial interface
 * ptr points to the receive buffer
 *
 *
 * RETURNS:
 *      -1 to indicate that no character was available
 *      -2 to indicate full message read
 *       0 to indicate partial message read (currently never)
 *
 *      len is set to the number of characters read, i.e. the package length
 */
int com_receive_ptr(char *ptr, int *len)
{
	ULONG packhdr = 'P'<<24 | 'A'<<16 | 'C'<<8 | 'K';
	int chars, rchars;
	ULONG buffer[3];
	static int amiserial_sync = 0;
	ULONG length;
	UBYTE c;

	db_printf(("com_receive_ptr: Trying to get package\n"));

	*len=0;
	if (amiserial_sync != 0) {                  // Try to find the next package header
		db_printf(("com_receive_prt: Trying sync\n"));
		//  To resync, we search for the sequence PACK.
		//  We do this letter by letter, until we`ve found them all in sequence.
		//  In other words, this implements a finite state machine.
		while (amiserial_sync != 0) {
			if (amiserial_chars()==0) return -1;
			SerialIO->IOSer.io_Command = CMD_READ;          //  Read one character
			SerialIO->IOSer.io_Data    = (ULONG *)buffer;
			SerialIO->IOSer.io_Length  = 1;
			SerialIO->IOSer.io_Flags  |= IOF_QUICK;
			DoIO((STIO)SerialIO);
			c = (char)((char *)buffer)[0];
			switch (amiserial_sync) {                       //  Try to find out which it must be
				case 1:
					if (c == 'P') {
						amiserial_sync++;                   //  It`s a P, so advance
						db_printf(("com_receive_prt: Sync 'P' -> %d\n",amiserial_sync));
					} else {
						amiserial_sync = 1;              //  No P, start over again
						return -1;
					}
					break;
				case 2:
					if (c == 'A') {
						amiserial_sync++;                   //  It`s a A, go on
						db_printf(("com_receive_prt: Sync 'A' -> %d\n",amiserial_sync));
					} else {
						amiserial_sync = 1;              //  No A, we start again at P
						return -1;
					}
					break;
				case 3:
					if (c == 'C') {
						amiserial_sync++;                   //  A 'C'
						db_printf(("com_receive_prt: Sync 'C' -> %d\n",amiserial_sync));
					} else {
						amiserial_sync = 1;
						return -1;
					}
					break;
				case 4:
					if (c == 'K') {
						amiserial_sync++;                   //  A 'K'
						db_printf(("com_receive_prt: Sync 'K' -> %d\n",amiserial_sync));
					} else {
						amiserial_sync = 1;
						return -1;
					}
					break;
				default:                                    //  Shouldn`t need this, but just in case
					amiserial_sync = 1;
					break;
			}
			//  We now check amiserial_sync for a 5. If we have one, all of the above came in
			//  Sequence, and we can continue to read the length of the package.
			//  Otherwise, we do it over again (We have no other choice. Possible future
			//  extension: count how many times we looped, and break if it exceeds a given threshold.
			if (amiserial_sync == 5) {                      //  got a valid PACK header
				if (amiserial_chars() < 4) return -1;       //  return an empty-buffer-mark if too few chars.
				db_printf(("com_receive_prt: sync'ed'\n"));
				SerialIO->IOSer.io_Command = CMD_READ;      //  Read the package length
				SerialIO->IOSer.io_Data    = (ULONG *)&length;
				SerialIO->IOSer.io_Length  = 4;
				SerialIO->IOSer.io_Flags  |= IOF_QUICK;
				db_printf(("com_receive_prt: reading length\n"));
				DoIO((STIO)SerialIO);
				amiserial_sync = 0;                         //  Stop resync
				*len = amiserial_read(ptr, length);         //  Read the package
				db_printf(("com_receive_ptr: Received %d characters resynced (expected %d)\n", *len, length));
				return -2;                                  //  Tell the caller we`ve got a package for him
			}
		}
		return -1;
	}

	chars = amiserial_chars();
	db_printf(("com_receive_ptr: %d characters available\n", chars));
	if (chars<8)
		return -1;                               // 8 is minumum package length

	rchars = amiserial_read((char *)buffer, 8); // Read Package header and length
												// Should really check this return value
	db_printf(("com_receive_ptr: Got %d characters\n", rchars));
	if (buffer[0] != packhdr) {                 // Difficult case: invalid message
		db_printf(("com_receive_ptr: Error - package header not found\n"));
		amiserial_sync = 1;
		return -1;                              // Say that the buffer was empty
	}

	*len = amiserial_read(ptr, buffer[1]);      // Read the message
	db_printf(("com_receive_ptr: Received %d characters (expected %d)\n", *len, buffer[1]));
	return -2;                                  // Indicate full message has been read
}

void com_param_setup(void) {

	newmenu_item m[10];
	int choice = 0;
	int num_options = 0;
	char text[256];
	int i;
	int was_on = 0;

	sprintf(text, "%d", com_speed);

	if (com_open) {
		was_on = 1;
		com_disable();
	}

	db_printf(("com_param_setup: Baud rate is %s\n", text));

/*    do { */
		m[0].type       = NM_TYPE_TEXT;
		m[0].text       = "Baud rate:";
		m[1].type       = NM_TYPE_INPUT;
		m[1].text_len   = 60;
		m[1].text       = text;

		i = newmenu_do1( NULL, "Serial port options", 2, m, NULL, i);

/*    while (i > -1); */

	com_speed = atoi(text);

	if (was_on)
		com_enable();

	SerialIO->io_Baud       = (ULONG)com_speed;
	SerialIO->io_ReadLen    = (UBYTE)8;
	SerialIO->io_WriteLen   = (UBYTE)8;
	SerialIO->io_StopBits   = (UBYTE)1;
	SerialIO->IOSer.io_Command = SDCMD_SETPARAMS;
	if (Inferno_verbose) printf("com_param_setup: Setting serial device parameters for read: %d\n", com_speed);
	DoIO((STIO)SerialIO);
	SerialIOWrite->io_Baud       = (ULONG)com_speed;
	SerialIOWrite->io_ReadLen    = (UBYTE)8;
	SerialIOWrite->io_WriteLen   = (UBYTE)8;
	SerialIOWrite->io_StopBits   = (UBYTE)1;
	SerialIOWrite->IOSer.io_Command = SDCMD_SETPARAMS;
	if (Inferno_verbose) printf("com_param_setup: Setting serial device parameters for write: %d\n", com_speed);
	DoIO((STIO)SerialIOWrite);

	db_printf(("com_param_setup: Baud rate now %d\n", com_speed));

}

