/*
** Amiga_socket
** Amiga socket i/o stuff for point-to-point
**
** $Id: amiga_socket.c,v 1.3 1998/04/25 08:39:20 nobody Exp $
** $Revision: 1.3 $
** $Author: nobody $
** $Date: 1998/04/25 08:39:20 $
**
** $Log: amiga_socket.c,v $
** Revision 1.3  1998/04/25 08:39:20  nobody
** Changed configuration settings
**
** Revision 1.2  1998/04/24 14:20:24  tfrieden
** Some stuff added
**
** Revision 1.1  1998/04/14 23:58:01  tfrieden
** Initial checkin
**
*/

#include <sys/types.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <netinet/in.h>
#include <errno.h>
#include <fcntl.h>
#include <netdb.h>
#include <exec/types.h>
#include "types.h"
#include "args.h"
#include "multi.h"
#include "newmenu.h"

extern int errno;
extern int message_length[];
#define db_printf(a) /*  printf a */

#define DESCENT_DEFAULT_PORT    2345
#define BUFFERLEN  1024
#define ADD_ITEM(t,value,key)  do { m[num_options].type=NM_TYPE_MENU; menu_choice[num_options]=value; m[num_options].text=t; num_options++; } while (0)

int socket_fd = 0;                          //  Socket to opponent
short socket_port = DESCENT_DEFAULT_PORT;   //  Port to use
short socket_opened = 0;                    //  Is socket open ?
short socket_other_valid = 0;               //  Set if opponents address is valid
struct sockaddr_in socket_me;               //  My address
struct sockaddr_in socket_other;            //  My opponents address
UBYTE socket_buffer[BUFFERLEN];             //  used to send and receive data
char socket_hostname[256];                  //  Host name for opponent
int socket_timeout = 10;                    //  timeout for connection in seconds


/*  socket_address_prepare
****************************
**  fill in a struct sockaddr_in
*/
void socket_prepare_address(struct sockaddr_in *address, short port, struct hostent *he)
{
		address->sin_family         = AF_INET;
		address->sin_port           = htons(socket_port);
		address->sin_addr           = *((struct in_addr *)he->h_addr);
		bzero(&(address->sin_zero[0]), sizeof(struct sockaddr_in));
}


/*  socket_close
******************
**  close socket and adjust flags
*/
void socket_close(void)
{

	if (socket_opened) {
		close(socket);
		socket_opened = 0;
		db_printf(("socket_close: socket closed\n"));
	}
}



/*  socket_init
*****************
**  Init: get hostnames (and stuff)
*/
void socket_init(void)
{
	int i;
	struct hostent *he;

	if (i = FindArg("-ip_port")) {                      //  user supplied port
		socket_port = atoi(Args[i+1]);
	} else {
		socket_port = DESCENT_DEFAULT_PORT;             //  use default
	}
	db_printf(("socket_init: Using port %d\n", socket_port));

	bzero(&(socket_me), sizeof(struct sockaddr_in));    //  fill up socket struct
	socket_me.sin_family        = AF_INET;
	socket_me.sin_port          = htons(socket_port);
	socket_me.sin_addr.s_addr   = INADDR_ANY;
	db_printf(("socket_init: Got local address\n"));

	if (i = FindArg("-ip_target")) {                    //  target given on  command line
		strcpy(socket_hostname, Args[i+1]);
		if (!(he = gethostbyname((char *)Args[i+1]))) { //  try getting it
			printf("Warning: cannot get address for host %s\n",
				Args[i+1]);
			socket_other_valid = 0;
		} else {
			socket_prepare_address(&socket_other, socket_port, he);
			socket_other_valid = 1;
			db_printf(("socket_init: Set target host %s address to %lx\n", Args[i+1],
				socket_other.sin_addr.s_addr));
		}
	} else {
		strcpy(socket_hostname, "*NONE*");
	}

	atexit(socket_close);
}


/*  socket_open
*****************
**  open socket to given host
**  returns:
**      >0  ok
**      0   no host, and no default
**      -1  can`t create socket
**      -2  can`t bind
**      -3  can`t connect
**      -4  unknown host
*/
int socket_open(char *host)
{

	int sin_size;
	struct hostent *he;
	struct timeval tv = { 10,0 };                       //  10 seconds timeout for socket

	if (socket_opened != 0) return 1;                   //  We are open, so assume all is set

	if (host == NULL && socket_other_valid == 0) {      //  No host, and no default *shrug*
		db_printf(("socket_open: No host to open\n"));
		return(0);
	}

	if (host) {                                         //  If a host is given, use it
		if (he = gethostbyname(host)) {                 //  Get host address
			db_printf(("socket_init: Set target host address to %lx\n", socket_other.sin_addr.s_addr));
			socket_prepare_address(&socket_other, socket_port, he);
			socket_other_valid              = 1;
		} else {
			return(-4);
		}
	}

	// if we got here, we either got a valid host, or a default host

	db_printf(("socket_open: opening socket..."));
	if ((socket_fd = socket(AF_INET, SOCK_DGRAM, 0)) == -1) {
		db_printf(("can`t open socket (%d)\n", errno));
		return(-1);
	}
	db_printf(("OK\n"));

	db_printf(("socket_open: trying to bind..."));
	if ((bind(socket_fd, (struct sockaddr *)&socket_me, sizeof(struct sockaddr))) == -1) {
		db_printf(("failed: %d\n", errno));
		close(socket_fd);
		return(-2);
	}
	db_printf(("OK\n"));

	//  set timeouts
//    setsockopt(socket_fd, SOL_SOCKET, SO_SNDTIMEO, (void *)&tv, sizeof(struct timeval));
//    setsockopt(socket_fd, SOL_SOCKET, SO_RCVTIMEO, (void *)&tv, sizeof(struct timeval));


	db_printf(("socket_open: trying to connect..."));
	if (connect(socket_fd, (struct sockaddr *)&socket_other, sizeof(struct sockaddr)) == -1) {
		db_printf(("failed: %d\n", errno));
		close(socket_fd);
		return(-3);
	}
	db_printf(("OK\n"));

	socket_opened = 1;                                  //  Indicate we have an open socket
	fcntl(socket_fd, F_SETFL, O_NONBLOCK);              //  to avoid hangups

	return(1);
}



/*  socket_send_ptr
*******************
**  Send a data packet to our host
**  The package is appended to a header with the following layout:
**  'PACK'  Longword to indicate package start
**  len     unsigned long, giving the length of the package *data*
**  data    len data bytes
*/
void socket_send_ptr(char *ptr, int len)
{
	int nbytes;

	db_printf(("socket_send_ptr: going to send %d byte package\n", len));

	socket_buffer[0] = 'P';                         //  Build header
	socket_buffer[1] = 'A';
	socket_buffer[2] = 'C';
	socket_buffer[3] = 'K';
	*((ULONG *)(&socket_buffer[4])) = (ULONG)len;
	memcpy(&socket_buffer[8], ptr, len);            //  Copy data to be send

	db_printf(("socket_send_ptr: Package ready to send (%d)\n", ptr[0]));

	nbytes = send(socket_fd, socket_buffer, len+8, 0);

	if (nbytes != len+8) {
		db_printf(("socket_send_ptr: Error sending package: %d\n", errno));
	}

	db_printf(("Sent package %d, length %d\n", *ptr, len));
	return;
}


/*  socket_receive_ptr
************************
**  check the socket for an incoming data package
**  returns:
**      0   indicate partial message read
**      -1  no character was available (i.e. nothing to read)
**      -2  a full message has been read
**      -3  "carrier lost"
**  The received data is put into the data area pinted to by ptr,
**  and len is set to the number of data bytes read
*/
int socket_receive_ptr(char *ptr, int *len)
{
	ULONG packhdr = 'P'<<24 | 'A'<<16 | 'C'<<8 | 'K';
	int nbytes, olen;
	ULONG *buf = (ULONG *)&socket_buffer[0];
	ULONG length;

	db_printf(("socket_receive_ptr: trying socket\n"));

	nbytes = recv(socket_fd, socket_buffer, BUFFERLEN, 0);

	if (nbytes == -1 && errno == EWOULDBLOCK) {         //  nothing to receive
		db_printf(("socket_receive_ptr: nothing to get\n"));
		*len = 0;
		return(-1);
	}

	if (nbytes == -1) {                                 //  error
		db_printf(("socket_receive_ptr: Error %d\n", errno));
		*len = 0;
		return(-1);                                     //  perhaps -3 ?
	}

	if (buf[0] != packhdr) {                            //  error, wrong packet
		db_printf(("socket_receive_ptr: Unknown packet received\n"));
		*len = 0;
		return(-1);
	}


	length = buf[1];                                    //  get length from header
	db_printf(("socket_receive_ptr: got packet %x, length %d\n", buf[0], length));
	memcpy(ptr, &socket_buffer[8], length);             //  copy the data bytes
	*len = length;

	db_printf(("got packet %d, length %d (should be %d)\n",
		socket_buffer[8], length-3, message_length[socket_buffer[8]]));
	return -2;
}


/*  socket_param_setup
************************
**  setup parameters for socket game
*/
void socket_param_setup(void) {

	newmenu_item m[10];
	int choice = 0;
	int num_options = 0;
	char text[2][256];
	int i;

	strcpy(text[0], socket_hostname);
	sprintf(text[1], "%d", (int)socket_port);
	db_printf(("socket_param_setup: Host is %s:%s (%hd)\n", text[0], text[1], socket_port));

  /*  do {*/
		m[0].type       = NM_TYPE_TEXT;
		m[0].text       = "Hostname:";
		m[1].type       = NM_TYPE_INPUT;
		m[1].text_len   = 60;
		m[1].text       = text[0];

		m[2].type       = NM_TYPE_TEXT;
		m[2].text       = "Port:";
		m[3].type       = NM_TYPE_INPUT;
		m[3].text_len   = 8;
		m[3].text       = text[1];

		m[4].type       = NM_TYPE_SLIDER;
		m[4].text       = "Connection Timeout";
		m[4].value      = socket_timeout/10;
		m[4].min_value  = 0;
		m[4].max_value  = 10;

		i = newmenu_do1( NULL, "TCP/IP options", 4, m, NULL, i);

/*    } while (i > -1);*/

	strcpy(socket_hostname, text[0]);
	socket_port = atoi(text[1]);

	db_printf(("socket_param_setup: Set target to %s:%ud\n", socket_hostname, socket_port));


}
