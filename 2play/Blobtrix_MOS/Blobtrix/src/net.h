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


#ifndef _NET_H_
#define _NET_H_

#include <stdlib.h>
#include <string.h>
#include <iostream>

#include "SDL.h"
#include "SDL_net.h"

#include "config.h"

using std::cout;

namespace net {

		int Start();
		int Stop();

		Uint32 ConvIP(Uint8 ip1, Uint8 ip2, Uint8 ip3, Uint8 ip4);
		void GetIP(Uint32 ip, Uint8 *ip1, Uint8 *ip2, Uint8 *ip3, Uint8 *ip4);

		bool SendUDPpacket(UDPsocket sock, int channel, char *data);
		bool SendUDPpacket_unbound(UDPsocket sock, IPaddress address, char *data);

		Uint32 TCP_SendMSG(TCPsocket sock, char *msg);
		Uint16 ConvPort(Uint16 port);

};



#endif
