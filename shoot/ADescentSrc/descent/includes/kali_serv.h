#ifndef _KALI_SERV_H
#define _KALI_SERV_H
#include <netinet/in.h>

void kali_server_add(int sock, char *buf, int buflen, struct sockaddr_in *addr);
void kali_server_close(int sock, char *buf, int buflen,
 struct sockaddr_in *addr);
void kali_server_bcast(int sock, char *buf, int buflen, struct sockaddr_in *addr);
void kali_server_msg(int sock, char *buf, int buflen, struct sockaddr_in *addr);

#endif
