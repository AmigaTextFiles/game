#ifndef IPX_KALI_H_
#define IPX_KALI_H_
#include <sys/types.h>
#include "ipx_helper.h"
int ipx_kali_GetMyAddress(void);
int ipx_kali_OpenSocket(ipx_socket_t *sk, int port);
void ipx_kali_CloseSocket(ipx_socket_t *mysock);
int ipx_kali_SendPacket(ipx_socket_t *mysock, IPXPacket_t *IPXHeader,
 u_char *data, int dataLen);
int ipx_kali_ReceivePacket(ipx_socket_t *s, char *buffer, int bufsize,
 struct ipx_recv_data *rd);

#endif
