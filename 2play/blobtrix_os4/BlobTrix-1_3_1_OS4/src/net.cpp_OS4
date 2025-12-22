/*
    Copyright (c) 2004-2005 Markus Kettunen

    This file is part of Blobtrix.

    Blobtrix is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Blobtrix is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Blobtrix; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/


#include "net.h"

int net::Start(){
	if (SDLNet_Init()==-1) {
		cout << "Couldn't initialize network.\n";
		exit(0);
	}
	cout << "Network initialized.\n";

	return 1;
}

int net::Stop(){
	SDLNet_Quit();
//	cout << "Network halted.\n";
	return 1;
}

Uint32 net::ConvIP(Uint8 ip1, Uint8 ip2, Uint8 ip3, Uint8 ip4) {
//	return (ip1 <<24) | (ip2<<16) | (ip3<<8) | ip4;
#if SDL_BYTEORDER == SDL_LIL_ENDIAN
	return (ip4 <<24) | (ip3<<16) | (ip2<<8) | (ip1);
#else
	return (ip4) | (ip3<<8) | (ip2<<16) | (ip1);
#endif
}

void net::GetIP(Uint32 ip, Uint8 *ip1, Uint8 *ip2, Uint8 *ip3, Uint8 *ip4) {
#if SDL_BYTEORDER == SDL_LIL_ENDIAN
	*ip1 = (Uint8)ip;
	*ip2 = (Uint8)(ip>>8);
	*ip3 = (Uint8)(ip>>16);
	*ip4 = (Uint8)(ip>>24);
#else
	*ip1 = (Uint8)(ip>>24);
	*ip2 = (Uint8)(ip>>16);
	*ip3 = (Uint8)(ip>>8);
	*ip4 = (Uint8)ip;
#endif
}


Uint16 net::ConvPort(Uint16 port) {
#if SDL_BYTEORDER == SDL_LIL_ENDIAN
	return (port>>8) | (port<<8);
#else
	return port;
#endif
}

bool net::SendUDPpacket(UDPsocket sock, int channel, char *data) {
	UDPpacket packet;
	packet.data = (Uint8*)data;
	packet.len = strlen(data)+1;
	if (! SDLNet_UDP_Send(sock, channel, &packet) ) {
		return 0;
	}
	return 1;
}

bool net::SendUDPpacket_unbound(UDPsocket sock, IPaddress address, char *data) {
	SDLNet_UDP_Bind(sock, SDLNET_MAX_UDPCHANNELS-1, &address);
	bool ret = SendUDPpacket(sock, SDLNET_MAX_UDPCHANNELS-1, data);
	SDLNet_UDP_Unbind(sock, SDLNET_MAX_UDPCHANNELS-1);
	return ret;
}

Uint32 net::TCP_SendMSG(TCPsocket sock, char *msg) {
	int len = strlen(msg);
	msg[len]='\r';
	msg[len+1]='\n';
	msg[len+2]='\0';
	len+=4;

	return SDLNet_TCP_Send(sock, msg, len);
}
