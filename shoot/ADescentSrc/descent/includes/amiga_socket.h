/*
** Amiga_socket
** Amiga socket i/o stuff for point-to-point
**
** $Id: amiga_socket.h,v 1.1 1998/04/15 00:01:42 tfrieden Exp $
** $Revision: 1.1 $
** $Author: tfrieden $
** $Date: 1998/04/15 00:01:42 $
**
** $Log: amiga_socket.h,v $
** Revision 1.1  1998/04/15 00:01:42  tfrieden
** Initial checkin
**
**
*/

#ifndef _AMIGA_SOCKET_H_
#define _AMIGA_SOCKET_H_

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <exec/types.h>

void socket_prepare_address(struct sockaddr_in *address, short port, struct hostent *he);
void socket_close(void);
void socket_init(void);
int socket_open(char *host);
void socket_send_ptr(char *ptr, int len);
int socket_receive_ptr(char *ptr, int *len);

#endif
