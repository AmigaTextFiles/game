/*
    Bantumi
    Copyright 2005 - 2007 Martin Storsjö

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

    Martin Storsjö
    martin@martin.st
*/

#ifndef __SOCKETCONN_H
#define __SOCKETCONN_H

#include "connection.h"

#ifdef WIN32

#include <winsock2.h>
#define SOCKTYPE SOCKET
#define CLOSESOCK closesocket

static inline int SETNONBLOCK(SOCKTYPE s, int b) {
	u_long arg = b;
	return ioctlsocket(s, FIONBIO, &arg);
}
#define CUR_ERROR() WSAGetLastError()

#define EINPROGRESS WSAEWOULDBLOCK
#define EAFNOSUPPORT WSAEAFNOSUPPORT

#else

#include <netinet/in.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/select.h>
#include <errno.h>

#define SOCKTYPE int
#define CLOSESOCK close
#define SETNONBLOCK(s, b) fcntl(s, F_SETFL, (b ? O_NONBLOCK : 0))
#define CUR_ERROR() errno
#define INVALID_SOCKET -1


#endif

void initSockets();
void closeSockets();

const char *getSockError();
const char *getSockError(int error);

class SocketConnection : public Connection {
public:
	~SocketConnection();

	bool isClient();
	int ready(const char **errString);
	bool read(const char **errString);
	bool write(const unsigned char *ptr, int n, const char **errString);

	virtual int pollConnect(int msec, const char **errString);
	virtual int pollAccept(int msec, const char **errString);


protected:
	SocketConnection(SOCKTYPE s);
	SOCKTYPE sock;
	int status;
	bool connecting;

};

#endif
