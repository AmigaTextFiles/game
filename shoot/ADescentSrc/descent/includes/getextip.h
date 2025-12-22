#ifndef _GETEXTIP_H
#define _GETEXTIP_H

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

int get_external_ip(struct in_addr *addr);

#endif
