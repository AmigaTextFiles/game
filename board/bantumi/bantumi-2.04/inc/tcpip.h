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

#ifndef __TCPIP_H
#define __TCPIP_H

#include "socketconn.h"
#ifdef WIN32
#include <ws2tcpip.h>
#else
#include "getaddrinfo.h"
#define AF_INET6 0
#define IN6ADDR_ANY_INIT {0}
#define pg_gai_strerror(x) ""
#define pg_freeaddrinfo(x)
#define pg_getaddrinfo(x, y, z, a) 0
struct in6_addr {
};
struct sockaddr_in6 {
	int sin6_family;
	int sin6_port;
	struct in6_addr sin6_addr;
};
#endif

#define DEFAULT_TCP_PORT 8471

void initTCPIP();
void closeTCPIP();

class TCPConnection : public SocketConnection {
public:
	~TCPConnection();

	static TCPConnection *_connect(const char *hostName, int port, const char **errString, bool *stop, bool join = false);
	static TCPConnection *_accept(int port, const char **errString, bool *stop);
	static TCPConnection *startConnect(const char *hostName, int port, const char **errString, bool join = false);
	static TCPConnection *startAccept(int port, const char **errString);
	static TCPConnection *startAcceptV4(int port, const char **errString);
	static TCPConnection *startAcceptV6(int port, const char **errString, bool requireV6 = true);

	int pollConnect(int msec, const char **errString);

protected:
	TCPConnection(SOCKTYPE s);

	bool joinResolver;
	void* resolveThread;
	char *hostname;
	int port;
	const char *hosterror;
	struct addrinfo* addrlist, *nextaddr;
	bool resolved;
	bool connectStarted;

	static void staticResolve(void *arg);
	void resolve();

	static bool doStartAccept(struct sockaddr* sa, int salen, SOCKTYPE sock, const char **errString);
	bool doStartConnect(const char **errString);
};

#endif
