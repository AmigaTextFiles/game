// 09/02/1998 trance

/*
THE COMPUTER CODE CONTAINED HEREIN IS THE SOLE PROPERTY OF PARALLAX
SOFTWARE CORPORATION ("PARALLAX").  PARALLAX, IN DISTRIBUTING THE CODE TO
END-USERS, AND SUBJECT TO ALL OF THE TERMS AND CONDITIONS HEREIN, GRANTS A
ROYALTY-FREE, PERPETUAL LICENSE TO SUCH END-USERS FOR USE BY SUCH END-USERS
IN USING, DISPLAYING,  AND CREATING DERIVATIVE WORKS THEREOF, SO LONG AS
SUCH USE, DISPLAY OR CREATION IS FOR NON-COMMERCIAL, ROYALTY OR REVENUE
FREE PURPOSES.  IN NO EVENT SHALL THE END-USER USE THE COMPUTER CODE
CONTAINED HEREIN FOR REVENUE-BEARING PURPOSES.  THE END-USER UNDERSTANDS
AND AGREES TO THE TERMS HEREIN AND ACCEPTS THE SAME BY USE OF THIS FILE.
COPYRIGHT 1993-1998 PARALLAX SOFTWARE CORPORATION.  ALL RIGHTS RESERVED.
*/
#ifndef _IPX_H
#define _IPX_H

#include "types.h"

typedef unsigned short word;

#define AMIPXNAME "amipx.library"
#define AMIPXVERSION 0

#define IPX_MAX_DATA_SIZE (546-4)
#define MAX_DATAGRAM_SIZE (576)

#define NETWORK_SPACE 4
#define ADDRESS_SPACE 6

typedef struct network_address
	{
			byte	address[NETWORK_SPACE];
	} network_address;

typedef struct node_address
	{
			byte	address[ADDRESS_SPACE];
	} node_address;

typedef struct net_address
	{
	network_address		network;
	node_address		node;
			word	socket;
	} net_address;

typedef struct user_address
	{
	network_address		network;
	node_address		node;
	node_address		user;
	} user_address;

typedef struct ipx_header
	{
			word	checksum;
			word	length;
			byte	transport_control;
			byte	packet_type;
	net_address		destination;
	net_address		source;
	} ipx_header;

typedef struct ecb_header
	{
			void *	link;
			void *	esr;
			byte	in_use;
			byte	completion_code;
			word	socket;
			byte	reserved[16];
	node_address		immediate_address;
			word	fragment_count;
			byte *	fragment_pointer;
			word	fragment_size;
	} ecb_header;

typedef struct packet_data
	{
			int	packet;
			byte	data[IPX_MAX_DATA_SIZE];
 	} packet_data;

typedef struct packet
	{
	ecb_header		ecb;
	ipx_header		ipx;
	packet_data		pd;
	} packet;

// functions in IPX library
word AMIPX_OpenSocket( word socket );
void AMIPX_CloseSocket( word socket );
word AMIPX_ListenForPacket( ecb_header *ecb );
word AMIPX_SendPacket( ecb_header *ecb );
void AMIPX_GetLocalAddress( net_address *net );
word AMIPX_GetLocalTarget( net_address *net, node_address *node );
void AMIPX_RelinquishControl( void );

#define PACKET_IPX 4

// The default socket to use.
#define IPX_DEFAULT_SOCKET 0x5100

//---------------------------------------------------------------
// Initializes all IPX internals.
// If socket_number==0, then opens next available socket.
// Returns:	0  if successful.
//				-1 if socket already open.
//				-2 if socket table full.
//				-3 if IPX not installed.
//				-4 if couldn't allocate low dos memory
//				-5 if error with getting internetwork address
extern int ipx_init( word socket_number, bool show_address );

extern int ipx_change_default_socket( word socket_number );

// Returns a pointer to 6-byte address
extern node_address *ipx_get_my_local_address();
// Returns a pointer to 4-byte server
extern network_address *ipx_get_my_server_address();

// Determines the local address equivalent of an internetwork address.
void ipx_get_local_target( network_address *network, node_address *node, node_address *address );

// If any packets waiting to be read in, this fills data in with the packet data and returns
// the number of bytes read.  Else returns 0 if no packets waiting.
extern int ipx_get_packet_data( byte *data );

// Sends a broadcast packet to everyone on this socket.
extern void ipx_send_broadcast_packet_data( byte *data, int size );

// Sends a packet to a certain address
extern void ipx_send_packet_data( byte *data, int size, network_address *network, node_address *node, node_address *address );
extern void ipx_send_internetwork_packet_data( byte *data, int size, network_address *network, node_address *node );

extern void ipx_read_user_file( char *filename );
extern void ipx_read_network_file( char *filename );

#endif