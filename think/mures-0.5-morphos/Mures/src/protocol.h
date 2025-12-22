/*

Mures
Copyright (C) 2001 Adam D'Angelo

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

Contact information:

Adam D'Angelo
dangelo@ntplx.net
P.O. Box 1155
Redding, CT 06875-1155
USA

*/

#ifndef PROTOCOL_H
#define PROTOCOL_H

#include <memory.h>

#define PROTOCOL_VERSION 2

typedef unsigned char packet_type;

/* server to client */
#define S_WELCOME       200
#define S_NOT_WELCOME   201
#define S_JOINED        202
#define S_NOT_JOINED    203
#define S_MAP           204
#define S_PLAYER_UPDATE 205

#define S_OKAY_TO       100
#define S_GAME_EVENT    101

/*
full
already started
banned
*/


/* client to server */
#define C_PROBE         200
#define C_JOIN          201
#define C_PROCESS_INPUT 202
#define C_QUIT          203

/*

standard connection goes:

client: PROBE
server: WELCOME version
client: JOIN (# players, 0 to observe)
server: JOINED (player numbers) or FULL

*/

#define PUSH(var) memcpy(&packet->data[d], &var, sizeof(var)); d += sizeof(var)
#define PULL(var) memcpy(&var, &packet->data[d], sizeof(var)); d += sizeof(var);


#endif
