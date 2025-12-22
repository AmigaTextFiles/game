/*
 * ipx_kali.c
 *
 * Kali compatible support for DOSEMU/LDescent IPX.
 * Arne de Bruijn, 1998
 */

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <string.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <stdlib.h>
#include <sys/time.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>

#include "ipx_ldescent.h"
#include "ipx_helper.h"
#include "config.h"

#include "kali_serv.h"
#include "getextip.h"

extern unsigned char ipx_MyAddress[10];

struct kali_client {
	int fd;
	struct sockaddr_in server;
	char node[6];
};

static int open_sockets = 0;
static int dynamic_socket = 0x401;
static int pkt_seq = 0;
static u_char ipx_broadcast_node[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
static struct kali_client *kali_client = NULL;
static int last_socket = 0;

static inline void bufs_to_node(u_char *addr, u_char *port, u_char *node) {
#ifdef __i386__ /* littleendian && free_alignment */
	*(u_long *)(node) = ntohl(*(u_long *)addr);
	*(u_short *)(node + 4) = ntohs(*(u_short *)port);
#else
	node[0] = addr[3]; node[1] = addr[2]; node[2] = addr[1]; node[3] = addr[0];
	node[4] = port[1]; node[5] = port[0];   
#endif
}

static inline void node_to_bufs(u_char *node, u_char *addr, u_char *port) {
#ifdef __i386__
	*(u_long *)(addr) = ntohl(*(u_long *)node);
	*(u_short *)(port) = ntohs(*(u_short *)(node + 4));
#else
	addr[0] = node[3]; addr[1] = node[2]; addr[2] = node[1]; addr[3] = node[0];
	port[0] = node[5]; port[1] = node[4];   
#endif
}

static void addr_to_node(struct sockaddr_in *addr, u_char *node) {
	bufs_to_node((u_char *)&(addr->sin_addr), (u_char *)&(addr->sin_port),
	 node);
}

static void node_to_addr(u_char *node, struct sockaddr_in *addr) {
	addr->sin_family = AF_INET;
	node_to_bufs(node, (u_char *)&(addr->sin_addr.s_addr),
	 (u_char *)&(addr->sin_port));
}

struct kali_client *kali_open(struct sockaddr_in *local) {
	struct kali_client *c;
	struct sockaddr_in addr;
	int i;
	
	if (!(c = malloc(sizeof(*c))))
		return NULL;
	memset(c, 0, sizeof(*c));

	if ((c->fd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
		free(c);
		return NULL;
	}
	fcntl(c->fd, F_SETFL, fcntl(c->fd, F_GETFL) | O_NONBLOCK);

/*
	if (!local->sin_addr.s_addr && !local->sin_port) {
		ipx_kali_GetMyAddress();
		node_to_addr(ipx_MyAddress + 4, local);
	}
*/
	if ((bind(c->fd, (struct sockaddr *)local, sizeof(*local))) < 0) {
		close(c->fd);
		free(c);
		return NULL;
	}
	if ((getsockname(c->fd, (struct sockaddr *)&addr, &i)) < 0) {
		close(c->fd);
		free(c);
		return NULL;
	}

	addr_to_node(&addr, c->node);

	return c;
}

static void tv_add(struct timeval *tv, long sec, long usec) {
	if ((tv->tv_usec += usec) >= 1000000) {
		tv->tv_usec -= 1000000;
		sec++;
	}
	if (tv->tv_usec < 0) {
		tv->tv_usec += 1000000;
		sec--;
	}
	tv->tv_sec += sec;
}

int kali_send_recv(struct kali_client *c,
 char *sendbuf, int sendlen, char *recvbuf, int recvlen, int *gotlen) {
	struct sockaddr_in addr;
	int i;
	fd_set rec;
	struct timeval tvtemp, tvend, tv;
	
	if (gotlen) *gotlen = 0;
	FD_ZERO(&rec);
	FD_SET(c->fd, &rec);
	gettimeofday(&tvend, NULL);
	tv_add(&tvend, 10, 0); /* timeout: 10 sec */
	
	while (1) {
		while (sendto(c->fd, sendbuf, sendlen, 0, (struct sockaddr *)&c->server, 
		 sizeof(c->server)) < 0) {
			if (errno == EINTR)
				continue;
			return -1;
		}
		gettimeofday(&tv, NULL);
		tvtemp = tvend;
		tv_add(&tvtemp, -tv.tv_sec, -tv.tv_usec);
		if (tvtemp.tv_sec < 0) {
			errno = ETIMEDOUT;
			return -1;
		}
		tv.tv_sec = 1;
		tv.tv_usec = 0;
		while ((i = select(c->fd + 1, &rec, NULL, NULL, &tv)) < 0) {
			if (errno == EINTR)
				continue;
			return -1;
		}
		if (i == 0) n_printf("IPX_kali: kali_send_recv() timeout\n");
		if (i > 0) {
			i = sizeof(addr);
			while ((i = recvfrom(c->fd, recvbuf, recvlen, 0, 
			 (struct sockaddr *)&addr, &i)) < 0) {
				if (errno == EINTR)
					continue;
				return -1;
			}
#if 1 /* verbose */
			if ((addr.sin_addr.s_addr != c->server.sin_addr.s_addr) ||
				(addr.sin_port != c->server.sin_port)) {
				n_printf("IPX_kali: (connect) recv invalid address %s:%d\n",
				 inet_ntoa(addr.sin_addr), ntohs(addr.sin_port));
				continue;
			}
			if ((i <= 4) || (memcmp(recvbuf, "KALI", 4))) {
				n_printf("IPX_kali: (connect) recv invalid header "
				 "%c%c%c%c (%d)\n",
				 recvbuf[0], recvbuf[1], recvbuf[2], recvbuf[3], i);
				continue;
			}
			if (recvbuf[4] == '6') {
				n_printf("IPX_kali: KALI6 in send_recv\n");
				continue;
			}
#else
			if ((addr.sin_addr.s_addr == c->server.sin_addr.s_addr) &&
				(addr.sin_port == c->server.sin_port) &&
				(i > 4) &&
				(!strncmp(recvbuf, "KALI", 4) &&
				(recvbuf[4] != '6'))
#endif              
				if (gotlen) *gotlen = i;
				return 0;
		}
	}
}

int kali_recv(struct kali_client *c, char *buf, int buflen, int *reclen,
 char *node) {
	int i;
	struct sockaddr_in addr;
	
	if (reclen) *reclen = 0;
	i = sizeof(addr);
	if ((i = recvfrom(c->fd, buf, buflen, 0, 
	 (struct sockaddr *)&addr, &i)) < 0)
		return -1;
	if (reclen) *reclen = i;
	if (node) addr_to_node(&addr, node);
	return 0;
}

int kali_connect(struct kali_client *c,
 struct sockaddr_in *server) {
	char buf[342];
	char resp[128];
	int resplen;
/*
	struct hostent *h;
	struct sockaddr_in addr;
*/
	
	memcpy(&c->server, server, sizeof(*server));
	memset(buf, 0, 342);
	strcpy(buf, "KALI1");
	strcpy(buf+0x05, "ld_"); /* FIXME: get real kali name */
	strcpy(buf+0x08, config_last_player);
	strcpy(buf+0x1b, "1.2xs");
/*
	strcpy(buf+0x2d, "<email>");
	strcpy(buf+0x78, "<fullname>");
	strcpy(buf+0x11a, "<location>");
*/
/*
	node_to_addr(ipx_MyAddress + 4, &addr);
	if ((h = gethostbyaddr((char *)&addr.sin_addr.s_addr, 4, AF_INET))) {
		strncpy(buf+0x12e, h->h_name, 39);
	}
*/

	n_printf("IPX_kali: connecting to server...\n");
	if (kali_send_recv(c, buf, 342, resp, 128, &resplen) < 0)
		return -1;
	if (resp[4] == '5') {
		resp[resplen - 1] = 0;
		n_printf("IPX_kali: connection refused: \"%s\"\n", resp + 5);
		return -1;
	}
	if (/*(resplen != 11) ||*/ (resp[4] != '2')) {
		n_printf("IPX_kali: invalid connect response %c%c%c%c%c (%d)\n",
		 resp[0], resp[1], resp[2], resp[3], resp[4], resplen);
		return -1;
	}
	bufs_to_node(resp + 5, resp + 9, c->node);
	return 0;    
}

int kali_send_server(struct kali_client *c, char *buf, int buflen) {
	return sendto(c->fd, buf, buflen, 0,
	 (struct sockaddr *)&c->server, sizeof(c->server));
}

int kali_disconnect(struct kali_client *c) {
	char buf[5], recvbuf[5];

	memcpy(buf, "KALI3", 5);
	if (kali_send_recv(c, buf, 5, recvbuf, 5, NULL) < 0) {
		n_printf("IPX_kali: error %d sending close\n", errno);
		return -1;
	}
	if (recvbuf[4] != '4') {
		n_printf("IPX_kali: (disconnect) recv invalid pkt: %c\n", recvbuf[4]);
		return -1;
	}

	return 0;
}

int kali_close(struct kali_client *c) {
	close(c->fd);
	free(c);
	return 0;
}

static int get_server_addr(struct sockaddr_in *addr) {
	char *p, server[SERVER_NAME_LEN];

	addr->sin_family = AF_INET;
	if ((p = strchr(config_kali_server, ':'))) {
		addr->sin_port = htons(atol(p + 1));
		strncpy(server, config_kali_server, p - config_kali_server);
		server[p - config_kali_server] = 0;
		p = server;
	} else {
		addr->sin_port = htons(2213);
		p = config_kali_server;
	}
	if (!strchr(p, '.') || !inet_aton(p, &addr->sin_addr)) {
		n_printf("IPX_kali: invalid server address\n");
		return -1;
	}
	return 0;
}

int ipx_kali_GetMyAddress(void) {
	int i;
	int s;
	struct sockaddr_in addr;
	unsigned char empty_address[10];
	
	memset(empty_address, 0, sizeof(empty_address));
	if (memcmp(ipx_MyAddress, empty_address, 10))
		return 0;

	if ((s = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
		n_printf("IPX_kali: (getaddr) error opening socket\n");
		return -1;
	}
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = 0;
	addr.sin_port = htons(2213);
	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		n_printf("IPX_kali: (getaddr) error %d binding to 2213\n", errno);
		close(s);
		return -1;
	}
	if (get_server_addr(&addr) < 0) {
#ifdef NO_SERVER
		return -1;
	}
#else
		if (get_external_ip(&addr.sin_addr) < 0)
			return -1;
	} else {
#endif  
	while (connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		if (errno == EINTR)
			continue;
		n_printf("IPX_kali: (getaddr) error %d in connect()\n", errno);
		close(s);
		return -1;
	}
	i = sizeof(addr);
	if (getsockname(s, (struct sockaddr *)&addr, &i) < 0) {
		n_printf("IPX_kali: (getaddr) error %d in getscokname()\n", errno);
		close(s);
		return -1;
	}
#ifndef NO_SERVER
	}
#endif  
	close(s);
	memset(ipx_MyAddress, 0, 4);
	addr_to_node(&addr, ipx_MyAddress + 4);
	return 0;
}

int ipx_kali_OpenSocket(ipx_socket_t *sk, int port) {
	struct sockaddr_in local, server;
	int i;

	if (!open_sockets) {
		if (kali_client) {
			kali_disconnect(kali_client);
			kali_close(kali_client);
			kali_client = NULL;
		}
		for (i = 0; i < 10 && !ipx_MyAddress[i]; i++) ;
		if (i == 10)
			ipx_kali_GetMyAddress();
		node_to_addr(ipx_MyAddress + 4, &local);
		n_printf("local: %s\n", inet_ntoa(local.sin_addr));
		if (!(kali_client = kali_open(&local))) {
			n_printf("IPX_kali: error connecting to server\n");
			return -1;
		}
		if (!get_server_addr(&server))
			if (kali_connect(kali_client, &server) < 0) {
				n_printf("IPX_kali: kali_connect failed (%d)\n", errno);
				kali_close(kali_client);
				kali_client = NULL;
				return -1;
			}
	}
	open_sockets++;
	if (!port)
		port = dynamic_socket++;
	last_socket = port;
	sk->fd = kali_client->fd;
	sk->socket = port;
	return 0;
}

void ipx_kali_CloseSocket(ipx_socket_t *mysock) {
	if (!open_sockets) {
		n_printf("IPX_kali: close w/o open\n");
		return;
	}
	if (--open_sockets) {
		n_printf("IPX_kali: (closesocket) %d sockets left\n", open_sockets);
		return;
	}
	if (kali_client) {
		if (kali_client->server.sin_port)
			if (kali_disconnect(kali_client) < 0)
				n_printf("IPX_kali: (closesocket) error disconnecting\n");
		kali_close(kali_client);
		kali_client = NULL;
	}
}

int ipx_kali_SendPacket(ipx_socket_t *mysock, IPXPacket_t *IPXHeader,
 u_char *data, int dataLen) {
	struct sockaddr_in *addr, destaddr;
	char newdata[MAX_PACKET_DATA + 14];
	int i;
 
	if (!kali_client)
		return -1;
	memcpy(newdata, "KALIB", 5);
	addr = &kali_client->server;
	if (memcmp(IPXHeader->Destination.Node, ipx_broadcast_node, 6)) {
		newdata[4] = '0';
		node_to_addr(IPXHeader->Destination.Node, &destaddr);
		addr = &destaddr;
	}
	newdata[5] = pkt_seq & 255;
	newdata[6] = pkt_seq >> 8;
	newdata[7] = 0x80; /* ? */
	newdata[8] = 0x00; /* ? */
	memcpy(newdata + 9, IPXHeader->Destination.Socket, 2);
	memcpy(newdata + 11, IPXHeader->Source.Socket, 2);
	memcpy(newdata + 13, data, dataLen);
	pkt_seq++;

	if (!addr->sin_port) {
		struct sockaddr_in laddr;
		node_to_addr(kali_client->node, &laddr);
		kali_server_bcast(mysock->fd, newdata + 5, dataLen + 8, &laddr);
	}
		
	while ((i = sendto(mysock->fd, newdata, dataLen + 13, 0,
		 (struct sockaddr *)addr, sizeof(*addr))) < 0) {
		if (errno == EINTR)
			continue;
		return -1;
	}
	return (i < 13) ? 0 : i - 13;
}

static int kali0_to_ipx(char *buf, int size, 
 char *outbuf, int outbufsize, struct ipx_recv_data *rd) {
	if ((size -= 8) < 0)
		n_printf("IPX_kali: KALI0 too small\n");
	else {
		memcpy(&rd->dst_socket, buf + 4, 2);
		memcpy(&rd->src_socket, buf + 6, 2);
		if (size > outbufsize) size = outbufsize;
		memcpy(outbuf, buf + 8, size);
		return size;
	}
	return -1;
}

static int decomp(unsigned char *outbuf, int outbufsize, unsigned char *buf, 
 int size) {
	int i;
	unsigned char *p = outbuf, c;

	if (!outbufsize) return 0;
	while (size--) {
		if ((((*p = *(buf++)) + 1) & 0xfe) != 0xfe) {
			p++;
			if (!(--outbufsize))
				break;
			continue;
		}
		if (*p == 0xfd) {
			i = (outbufsize >= 3) ? 3 : outbufsize;
			c = 0;
		} else {
			if ((size -= 2) < 0)
				return -1;
			if (outbufsize < (i = *(buf++)))
				i = outbufsize; 
			c = *(buf++);
		}
		memset(p, c, i);
		p += i;
		if (!(outbufsize -= i))
			break;
	}
	return (p - outbuf);
}

static int kaliext_to_ipx(unsigned char *buf, int size, 
 unsigned char *outbuf, int outbufsize, struct ipx_recv_data *rd) {
	unsigned char *p;
	int i;
	
	if ((size -= 6) < 0)
		n_printf("IPX_kali: KALIext too small\n");
	else {
		memcpy(&rd->dst_socket, buf + 1, 2);
		memcpy(&rd->src_socket, buf + 3, 2);
		p = buf + 6;
		if (!(i = buf[5]) && (size)) {
			i = buf[6] + (buf[7] << 8);
			p += 2;
			size -= 2;
		}
		if (i > outbufsize) i = outbufsize;
		if (buf[0] & 0x80)
			i = decomp(outbuf, i, p, size);
		else {
			if (i > size) i = size;
			memcpy(outbuf, p, i);
		}
		return i;
	}
	return -1;
}

int ipx_kali_ReceivePacket(ipx_socket_t *s, char *outbuf, int outbufsize, 
 struct ipx_recv_data *rd) {
	char buf[MAX_PACKET_DATA + 30];
	int i, size;
	struct sockaddr_in addr;
	int allowpkt = 16;
 
	if (!kali_client)
		return -1;
	while (allowpkt--) {
		i = sizeof(addr);
		while ((size = recvfrom(kali_client->fd, buf, MAX_PACKET_DATA + 30, 0,
			 (struct sockaddr *) &addr, &i)) < 0) {
			if (errno == EINTR)
				continue;
			return -1;
		}
		/*  n_printf("IPX_kali: received %c%c%c%c%c, %d from %s:%d\n",
		 buf[0], buf[1], buf[2], buf[3], buf[4], size, inet_ntoa(addr.sin_addr),
		 ntohs(addr.sin_port));*/
		memset(rd->src_network, 0, 4);
		rd->pkt_type = 0;
		if ((size < 5) || (memcmp(buf, "KALI", 4))) {
			addr_to_node(&addr, rd->src_node);
			return kaliext_to_ipx(buf, size, outbuf, outbufsize, rd);
		}
		switch (buf[4]) {
			case '0':
				addr_to_node(&addr, rd->src_node);
				return kali0_to_ipx(buf + 5, size - 5, outbuf, outbufsize, rd);
			case 'P':
				if (size < 11)
					n_printf("IPX_kali: KALIP too small (%d)\n", size);
				else {
					bufs_to_node(buf + 5, buf + 9, rd->src_node);
					if ((size >= 16) && (!strncmp(buf + 11, "KALI0", 5))) {
						return kali0_to_ipx(buf + 16, size - 16, 
						 outbuf, outbufsize, rd);
					} else
						return kaliext_to_ipx(buf + 11, size - 11, 
						 outbuf, outbufsize, rd);
				}
				continue; /*break;*/
			case '6':
				memcpy(buf, "KALIALinux\0\0\0\0", 14);
				buf[18] = last_socket >> 8;
				buf[19] = last_socket & 255;
				kali_send_server(kali_client, buf, 20);
				continue; /*break;*/
			case '1':
				kali_server_add(kali_client->fd, buf + 5, size - 5, &addr);
				continue;
			case '3':
				kali_server_close(kali_client->fd, buf + 5, size - 5, &addr);
				continue;
			case 'B':
				kali_server_bcast(kali_client->fd, buf + 5, size - 5, &addr);
				addr_to_node(&addr, rd->src_node);
				return kali0_to_ipx(buf + 5, size - 5, outbuf, outbufsize, rd);
			case 'M':
				kali_server_msg(kali_client->fd, buf + 5, size - 5, &addr);
				continue;
			default:
				n_printf("IPX_kali: unknown pkt KALI%c\n", buf[4]);
		}
	}
	return -1;
}
