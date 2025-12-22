#include <stdio.h>

#include <stdlib.h>
#include <string.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>

#include "ipx_ldescent.h"
#include "kali_serv.h"

#define NICK_SIZE 22
typedef struct client {
	struct client *next;
	char nick[NICK_SIZE];
	struct sockaddr_in addr;
} client;

client *firstclient = NULL;

void kali_server_add(int sock, char *buf, int buflen, struct sockaddr_in *addr) {
	client *p = firstclient;
	char resp[11];
	
	_mprintf(1,"add req from %s\n", buf);
	while (p && strcasecmp(p->nick, buf) && (addr->sin_addr.s_addr != 
	 p->addr.sin_addr.s_addr || addr->sin_port != p->addr.sin_port))
		p = p->next;
	if (p && strcasecmp(p->nick, buf) && (addr->sin_addr.s_addr != 
	 p->addr.sin_addr.s_addr || addr->sin_port != p->addr.sin_port)) {
		sendto(sock, "KALI5Duplicate nick", 17, 0, (struct sockaddr *)addr,
		 sizeof(addr));
		return;
	}
	if (!p) {
		if (!(p = malloc(sizeof(client))))
			return;
		p->next = firstclient;
		firstclient = p;
	}
	strncpy(p->nick, buf, NICK_SIZE);
	p->nick[NICK_SIZE - 1] = 0;
	p->addr = *addr;
	
	memcpy(resp, "KALI2", 5);
	memcpy(resp + 5, &addr->sin_addr.s_addr, 4);
	memcpy(resp + 9, &addr->sin_port, 2);
	if (sendto(sock, resp, 11, 0, (struct sockaddr *)addr, sizeof(*addr)) < 0)
		_mprintf(1,"err %d sending resp\n", errno);
}

void kali_server_close(int sock, char *buf, int buflen,
 struct sockaddr_in *addr) {
	client *p, **last = (client **)&firstclient;
	
	if ((p = *last)) {
		while (p && (addr->sin_addr.s_addr != p->addr.sin_addr.s_addr ||
		 addr->sin_port != p->addr.sin_port))
			p = *(last = &p->next);
		if (p)
			(*last)->next = p->next;
	}
	sendto(sock, "KALI4", 5, 0, (struct sockaddr *)addr, sizeof(*addr));
}

void kali_server_bcast(int sock, char *buf, int buflen, struct sockaddr_in *addr) {
	char nbuf[MAX_PACKET_DATA + 16 + 8];
	client *p;
	
	if (buflen > MAX_PACKET_DATA + 8)
		return;
	memcpy(nbuf, "KALIP", 5);
	memcpy(nbuf + 5, &addr->sin_addr.s_addr, 4);
	memcpy(nbuf + 7, &addr->sin_port, 2);
	memcpy(nbuf + 11, "KALI0", 5);
	memcpy(nbuf + 16, buf, buflen);

	for (p = firstclient; p; p = p->next)
		sendto(sock, nbuf, buflen + 16, 0, (struct sockaddr *)&p->addr, 
		 sizeof(struct sockaddr_in));
	
}

void kali_server_msg(int sock, char *buf, int buflen, struct sockaddr_in *addr) {
	sendto(sock, "KALIwldescent local kali compatible server", 42, 0, 
	 (struct sockaddr *)addr, sizeof(* addr));
}
