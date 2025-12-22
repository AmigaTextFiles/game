/*
 * Find external ip of this host:
 * - try to find a default route, if found return address of associated iface
 * - otherwise return address of first iface without 127.x.x.x address.
 * There must be a better way to do this...
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <net/if.h>
#include <arpa/inet.h>
#include <netdb.h>


int get_external_ip(struct in_addr *addr) {

	FILE *rt;
	char buf[256];
	struct hostent *he;

	if ((rt = popen("hostname", "r"))) {
		fgets(buf, sizeof(buf), rt);
		pclose(rt);
	} else {
		return -1;
	}

	if (!(he = gethostbyname(buf))) {
		printf("Error: could not get address for local host\n");
	} else {
		*addr = *((struct in_addr *)he->h_addr);
		return 0;
	}
	return -1;
}


int old_get_external_ip(struct in_addr *addr) {
	char buf[256], *p, *ifname = NULL;
	int i, s, nodev;
	struct ifconf ifc;
	struct ifreq devs[16];
	FILE *rt;
	
	if ((rt = popen("route -n", "r"))) {
		while (fgets(buf, sizeof(buf), rt)) {
			i = 2;
			strtok(buf, "\t ");
			while (i-- && (p = strtok(NULL, "\t ")))
				;
			if (!strcmp(p, "0.0.0.0")) {
				i = 5;
				while (i-- && (p = strtok(NULL, "\t\r\n ")))
					;
				ifname = p;
				break;
			}
		}
		pclose(rt);
	}
	s = socket(AF_INET, SOCK_DGRAM, 0);
	ifc.ifc_len = sizeof(devs);
	ifc.ifc_req = devs;
	i = ioctl(s, SIOCGIFCONF, &ifc);
	close(s);
	if (i < 0)
		return -1;
	nodev = ifc.ifc_len / sizeof(struct ifreq);
	for (i = 0; i < nodev; i++) {
		if (((ntohl(((struct sockaddr_in *)&devs[i].ifr_addr)->sin_addr.s_addr)
		 & 0xff000000) != 0x7f000000) && 
		 (!ifname || (!strcmp(devs[i].ifr_name, ifname)))) {
			*addr = ((struct sockaddr_in *)&devs[i].ifr_addr)->sin_addr;
			return 0;
		}
	}
	return -1;
}
