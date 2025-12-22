// 05/02/1998 trance

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

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/types.h>

#include "types.h"
#include "ipx.h"

#ifdef WANT_IPX

#include <proto/exec.h>
#include <inline/amipx.h>

struct Library *AMIPX_Library = NULL;

#define RETURN_NET_ERRORS { neterrors++; return; }

#define FALSE 0
#define TRUE 1

#define NO_SOCKET 0

#define NO_EVENT 0
#define EVENT_LISTEN 29

#define PACKET_FREE -1

void got_new_packet( ecb_header * ecb );
void ipx_listen_for_packet( ecb_header * ecb );

#define NO_USER 0
#define MAX_USERS 64
int ipx_users = NO_USER;
user_address ipx_user[MAX_USERS];

#define NO_NETWORK 0
#define MAX_NETWORKS 64
int ipx_networks = NO_NETWORK;
network_address ipx_network[MAX_NETWORKS];

#define NO_PACKET 0
#define MAX_PACKETS 64
int ipx_packets = NO_PACKET;
packet ipx_packet[MAX_PACKETS];

static int largest_packet_index = NO_PACKET;
static packet_data packet_buffers[MAX_PACKETS];
static short packet_free_list[MAX_PACKETS];
static short packet_size[MAX_PACKETS];

#define NO_ERROR 0
int neterrors = NO_ERROR;

ubyte ipx_available = FALSE;
ushort ipx_socket = NO_SOCKET;

int ipx_current_packet = NO_PACKET;

node_address ipx_node_address;
network_address ipx_network_address;



int ipx_init( word socket_number, bool show_address );
void ipx_close();

void free_packet( int packet )
	{
	packet_buffers[ packet ].packet = PACKET_FREE;
	packet_free_list[ --ipx_packets ] = packet;

	if ( largest_packet_index == packet )
		{
		while ( ( --largest_packet_index > NO_PACKET ) && ( packet_buffers[ largest_packet_index ].packet == PACKET_FREE ) );
		};
	};

int ipx_get_packet_data( byte *data )
	{
	int i, size;
	int n = 0, best = PACKET_FREE, best_id = PACKET_FREE;

	for ( i = 1; i < MAX_PACKETS; i++ )
		{
		if ( !ipx_packet[i].ecb.in_use )
			{
			got_new_packet( &ipx_packet[i].ecb );

			ipx_packet[i].ecb.in_use = NO_EVENT;
			ipx_listen_for_packet( &ipx_packet[i].ecb );
			};
		};

	for (i=0; i<=largest_packet_index; i++ )
		{
		if ( packet_buffers[i].packet > PACKET_FREE )
			{
			n++;
			if ( ( best == PACKET_FREE ) || ( packet_buffers[i].packet < best ) )
				{
				best = packet_buffers[i].packet;
				best_id = i;
				};
			};
		};

	printf( "Best id = %d, pn = %d, ne = %d\n", best_id, best, neterrors );

	if ( best_id < NO_PACKET )
		{
		return NO_PACKET;
		};

	size = packet_size[best_id];
	memcpy( data, packet_buffers[best_id].data, size );
	free_packet(best_id);

	return size;
	};

void got_new_packet( ecb_header * ecb )
	{
	packet * p;
	int id;
	unsigned short size=0;

	p = (packet *)ecb;

	if ( ( p->ecb.in_use ) || ( p->ecb.completion_code ) ) RETURN_NET_ERRORS;

	printf( "Receive error %d for completion code", p->ecb.completion_code );

	if ( memcmp( &p->ipx.source.node, &ipx_node_address, 6 ) )
		{
		size = p->ipx.length;
		size -= sizeof(ipx_header);

		// Find slot to put packet in...
		if ( size > 0 && size <= sizeof(packet_data) )
			{
			if ( ipx_packets >= MAX_PACKETS )
				{
				printf( "IPX: Packet buffer overrun!!!\n" );
				RETURN_NET_ERRORS;
				};

			id = packet_free_list[ ipx_packets++ ];
			if (id > largest_packet_index ) largest_packet_index = id;
			packet_size[id] = size - sizeof( int );
			packet_buffers[id].packet =  p->pd.packet;
			if ( packet_buffers[id].packet < NO_PACKET ) RETURN_NET_ERRORS;
			memcpy( packet_buffers[id].data, p->pd.data, packet_size[id] );
			}
		else RETURN_NET_ERRORS;
		};

	// Repost the ecb
	p->ecb.in_use = NO_EVENT;
	//ipx_listen_for_packet(&p->ecb);
	};

node_address *ipx_get_my_local_address()
	{
	return &ipx_node_address;
	};

network_address *ipx_get_my_server_address()
	{
	return &ipx_network_address;
	};

void ipx_listen_for_packet( ecb_header * ecb )
	{
	word error;

	ecb->in_use = EVENT_LISTEN;

	if ( ( error = AMIPX_ListenForPacket( ecb ) ) )
		{
		printf("IPX: ListenForPacket failed return code %d.\n", error);
		};
	};

void ipx_cancel_listen_for_packet(ecb_header * ecb )
	{
	AMIPX_RelinquishControl();
	};

void ipx_send_packet(ecb_header * ecb )
	{
	word error;

	if ( ( error = AMIPX_SendPacket( ecb ) ) )
		{
		printf("IPX: SendPacket failed return code %d.\n", error);
		};
	};

void ipx_get_local_target( network_address *network, node_address *node, node_address *address )
	{
	net_address ipx_net_address;
	node_address ipx_node_address;

	memcpy( &ipx_net_address.network, &network, NETWORK_SPACE );
	memcpy( &ipx_net_address.node, &node, ADDRESS_SPACE );
	ipx_net_address.socket = NO_SOCKET;

	if ( ( AMIPX_GetLocalTarget( &ipx_net_address, &ipx_node_address ) ) )
		{
		printf("IPX: unable to get local target!\n");
		}
	else
		{
		// Save the local target...
		memcpy( &address, &ipx_node_address, ADDRESS_SPACE );
		};
	};

void ipx_close()
	{
	if ( ipx_available )
		{
		AMIPX_CloseSocket( ipx_socket );
		ipx_available = FALSE;
		};

	if ( AMIPX_Library )
		{
		CloseLibrary( AMIPX_Library );
		AMIPX_Library = NULL;
		};
	};

//---------------------------------------------------------------
// Initializes all IPX internals.
// If socket_number==0, then opens next available socket.
// Returns: 0  if successful.
//              -1 if socket already open.
//              -2 if socket table full.
//              -3 if IPX not installed.
//              -4 if couldn't allocate low dos memory
//              -5 if error with getting internetwork address

int ipx_init( word socket_number, bool show_address )
	{
	net_address ipx_net_address;
	int i;

	ipx_current_packet = NO_PACKET;

	// init packet buffers.
	for ( i = 0; i < MAX_PACKETS; i++ )
		{
		packet_buffers[i].packet = PACKET_FREE;
		packet_free_list[i] = i;
		};

	ipx_packets = largest_packet_index = NO_PACKET;

	if ( ( AMIPX_Library = (void *)OpenLibrary( AMIPXNAME, AMIPXVERSION ) ) )
		{
		atexit(ipx_close);

		// Open a socket for IPX
		ipx_socket = AMIPX_OpenSocket( socket_number );

		if ( ipx_socket == NO_SOCKET )
			{
			printf( "IPX error opening channel %d\n", socket_number - IPX_DEFAULT_SOCKET );
			return -2;
			};

		ipx_available = TRUE;

		// Find our internetwork address
		AMIPX_GetLocalAddress( &ipx_net_address );

		memcpy( &ipx_network_address, &ipx_net_address.network, NETWORK_SPACE );
		memcpy( &ipx_node_address, &ipx_net_address.node, ADDRESS_SPACE );

		ipx_networks = NO_NETWORK;
		memcpy( &ipx_network[ ipx_networks++ ], &ipx_network_address, NETWORK_SPACE );

		if ( show_address )
			{
			printf( "My IPX addresss is " );
			printf( "%02X%02X%02X%02X/", ipx_net_address.network.address[0],ipx_net_address.network.address[1],ipx_net_address.network.address[2],ipx_net_address.network.address[3] );
			printf( "%02X%02X%02X%02X%02X%02X\n", ipx_net_address.node.address[0],ipx_net_address.node.address[1],ipx_net_address.node.address[2],ipx_net_address.node.address[3],ipx_net_address.node.address[4],ipx_net_address.node.address[5] );
			printf( "\n" );
			};

		memset( ipx_packet, 0, sizeof( packet ) * MAX_PACKETS );

		for ( i = 1; i < MAX_PACKETS; i++ )
			{
			ipx_packet[i].ecb.in_use = EVENT_LISTEN;
			ipx_packet[i].ecb.socket = ipx_socket;
			ipx_packet[i].ecb.fragment_count = 1;
			ipx_packet[i].ecb.fragment_pointer = (byte *)&ipx_packet[i].ipx;
			ipx_packet[i].ecb.fragment_size = sizeof( packet ) - sizeof( ecb_header );

			ipx_listen_for_packet( &ipx_packet[i].ecb );
			};

		ipx_packet[0].ecb.socket = ipx_socket;
		ipx_packet[0].ecb.fragment_count = 1;
		ipx_packet[0].ecb.fragment_pointer = (byte *)&ipx_packet[0].ipx;
		ipx_packet[0].ipx.packet_type = PACKET_IPX;
		ipx_packet[0].ipx.destination.socket = ipx_socket;
		}
	else
		{
		printf("IPX: unable to open network library.\n");
		};

	return 0;
	};

void ipx_send_packet_data( byte *data, int size, network_address *network, node_address *node, node_address *address )
	{
	assert( ipx_available );

	if ( size >= IPX_MAX_DATA_SIZE )
		{
		printf( "Data too big\n" );

		exit(1);
		};

	// Make sure no one is already sending something
	while( ipx_packet[0].ecb.in_use );

	if ( ipx_packet[0].ecb.completion_code )
		{
		printf( "Send error %d for completion code\n", ipx_packet[0].ecb.completion_code );

		exit(1);
		};

	// Fill in destination address
	if ( memcmp( network->address, ipx_network_address.address, NETWORK_SPACE ) )
		{
		memcpy( ipx_packet[0].ipx.destination.network.address, network, NETWORK_SPACE );
		}
	else
		{
		memset( ipx_packet[0].ipx.destination.network.address, 0, NETWORK_SPACE );
		};

	memcpy( ipx_packet[0].ipx.destination.node.address, node, ADDRESS_SPACE );
	memcpy( ipx_packet[0].ecb.immediate_address.address, address, ADDRESS_SPACE );
	ipx_packet[0].pd.packet = ipx_current_packet++;

	// Fill in data to send
	ipx_packet[0].ecb.fragment_size = sizeof( ipx_header ) + sizeof( int ) + size;

	assert( size > 1 );
	assert( ipx_packet[0].ecb.fragment_size <= MAX_DATAGRAM_SIZE );

	memcpy( ipx_packet[0].pd.data, data, size );

	// Send it
	ipx_send_packet( &ipx_packet[0].ecb );
	};

void ipx_send_broadcast_packet_data( byte *data, int size )
	{
	int i, j;
	node_address broadcast = { { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff } };
	node_address node;

	// Set to all networks besides mine
	for ( i = 0; i < ipx_networks; i++ )
		{
		if ( memcmp( &ipx_network[i], &ipx_network_address, 4 ) )
			{
			ipx_get_local_target( &ipx_network[i], &broadcast, &node );
			ipx_send_packet_data( data, size, &ipx_network[i], &broadcast, &node );
			}
		else
			{
			ipx_send_packet_data( data, size, &ipx_network[i], &broadcast, &broadcast );
			};
		};

	// Send directly to all users not on my network or in the network list.
	for ( i = 0; i < ipx_users; i++ )
		{
		if ( memcmp( &ipx_user[i].network, &ipx_network_address, NETWORK_SPACE ) )
			{
			for ( j = 0; j < ipx_networks; j++ )
				{
				if ( !memcmp( &ipx_user[i].network, &ipx_network[j], NETWORK_SPACE ) )
					goto SkipUser;
				};

			ipx_send_packet_data( data, size, &ipx_user[i].network, &ipx_user[i].node, &ipx_user[i].user );
SkipUser:
			j = 0;
			};
		};
	};

// Sends a non-localized packet... needs 4 byte server, 6 byte address
void ipx_send_internetwork_packet_data( byte *data, int size, network_address *network, node_address *node )
	{
	node_address address;

	if ( (*(long *)network) != NULL )
		{
		ipx_get_local_target( network, node, &address );
		ipx_send_packet_data( data, size, network, node, &address );
		}
	else
		{
		// Old method, no server info.
		ipx_send_packet_data( data, size, network, node, node );
		};
	};

int ipx_change_default_socket( word socket_number )
	{
	int i;
	word new_ipx_socket;

	if ( !ipx_available ) return -3;

	// Open a new socket
	new_ipx_socket = AMIPX_OpenSocket( socket_number );

	if ( ipx_socket == NO_SOCKET )
		{
		printf( "IPX error opening channel %d\n", socket_number - IPX_DEFAULT_SOCKET );

		return -2;
		};

	for ( i = 1; i < MAX_PACKETS; i++ )
		{
		ipx_cancel_listen_for_packet( &ipx_packet[i].ecb );
		};

	// Close existing socket...
	AMIPX_CloseSocket( ipx_socket );

	ipx_socket = new_ipx_socket;

	// Repost all listen requests on the new socket...
	for ( i = 1; i < MAX_PACKETS; i++ )
		{
		ipx_packet[i].ecb.in_use = NO_EVENT;
		ipx_packet[i].ecb.socket = ipx_socket;

		ipx_listen_for_packet( &ipx_packet[i].ecb );
		};

	ipx_packet[0].ecb.socket = ipx_socket;
	ipx_packet[0].ipx.destination.socket = ipx_socket;

	ipx_current_packet = NO_PACKET;

	// init packet buffers.
	for ( i = 0; i < MAX_PACKETS; i++ )
		{
		packet_buffers[i].packet = PACKET_FREE;
		packet_free_list[i] = i;
		};

	ipx_packets = largest_packet_index = NO_PACKET;

	return 0;
	};

void ipx_read_user_file(char * filename)
	{
	FILE * fp;
	user_address tmp;
	char temp_line[132], *p1;
	int n, ln=0;

	if ( !filename ) return;

	ipx_users = NO_USER;

	fp = fopen( filename, "rt" );
	if ( !fp ) return;

	printf( "Broadcast Users:\n" );

	while ( fgets( temp_line, 132, fp ) )
		{
		ln++;
		p1 = strchr(temp_line,'\n'); if (p1) *p1 = '\0';
		p1 = strchr(temp_line,';'); if (p1) *p1 = '\0';
		n = sscanf( temp_line, "%2x%2x%2x%2x/%2x%2x%2x%2x%2x%2x", (int *)&tmp.network.address[0], (int *)&tmp.network.address[1], (int *)&tmp.network.address[2], (int *)&tmp.network.address[3], (int *)&tmp.node.address[0], (int *)&tmp.node.address[1], (int *)&tmp.node.address[2], (int *)&tmp.node.address[3], (int *)&tmp.node.address[4], (int *)&tmp.node.address[5] );
		if ( n != 10 ) continue;
		if ( ipx_users < MAX_USERS )
			{
			ipx_get_local_target( &tmp.network, &tmp.node, &tmp.user );
			ipx_user[ipx_users++] = tmp;
			printf( "%02X%02X%02X%02X/", tmp.network.address[0],tmp.network.address[1],tmp.network.address[2],tmp.network.address[3] );
			printf( "%02X%02X%02X%02X%02X%02X\n", tmp.node.address[0],tmp.node.address[1],tmp.node.address[2],tmp.node.address[3],tmp.node.address[4],tmp.node.address[5] );
			}
		else
			{
			printf( "Too many addresses in %s! (Limit of %d)\n", filename, MAX_USERS );
			fclose(fp);
			return;
			};
		};

	fclose(fp);
	};

void ipx_read_network_file(char * filename)
	{
	FILE * fp;
	user_address tmp;
	char temp_line[132], *p1;
	int i, n, ln=0;

	if ( !filename ) return;

	fp = fopen( filename, "rt" );
	if ( !fp ) return;

	printf( "Using Networks:\n" );

	for ( i = 0; i < ipx_networks; i++ )
		{
		printf("* %02x%02x%02x%02x\n", ipx_network[i].address[0], ipx_network[i].address[1], ipx_network[i].address[2], ipx_network[i].address[3] );
		};

	while (fgets(temp_line, 132, fp))
		{
		ln++;
		p1 = strchr(temp_line,'\n'); if (p1) *p1 = '\0';
		p1 = strchr(temp_line,';'); if (p1) *p1 = '\0';
		n = sscanf( temp_line, "%2x%2x%2x%2x", (int *)&tmp.network.address[0], (int *)&tmp.network.address[1], (int *)&tmp.network.address[2], (int *)&tmp.network.address[3] );
		if ( n != 4 ) continue;
		if ( ipx_networks < MAX_NETWORKS  )
			{
			int j;

			for (j=0; j<ipx_networks; j++ )
				if ( !memcmp( &ipx_network[j], &tmp.network, NETWORK_SPACE ) )
					break;

			if ( j >= ipx_networks )
				{
				memcpy( &ipx_network[ipx_networks++], &tmp.network, NETWORK_SPACE );
				printf("  %02x%02x%02x%02x\n", tmp.network.address[0], tmp.network.address[1], tmp.network.address[2], tmp.network.address[3] );
				};
			}
		else
			{
			printf( "Too many networks in %s! (Limit of %d)\n", filename, MAX_NETWORKS );
			fclose(fp);
			return;
			};
		};

	fclose(fp);
	};

#else
void free_packet( int packet ) { };
int ipx_get_packet_data( byte *data ) { return 0; };
void got_new_packet( ecb_header * ecb ) { };
node_address *ipx_get_my_local_address() { return 0; };
network_address *ipx_get_my_server_address() { return 0; };
void ipx_listen_for_packet( ecb_header * ecb ) { };
void ipx_cancel_listen_for_packet(ecb_header * ecb ) { };
void ipx_send_packet(ecb_header * ecb ) { };
void ipx_get_local_target( network_address *network, node_address *node, node_address *address ) { };
void ipx_close() { };
int ipx_init( word socket_number, bool show_address ) { return -3; };
void ipx_send_packet_data( byte *data, int size, network_address *network, node_address *node, node_address *address ) { };
void ipx_send_broadcast_packet_data( byte *data, int size ) { };
void ipx_send_internetwork_packet_data( byte *data, int size, network_address *network, node_address *node ) { };
int ipx_change_default_socket( word socket_number ) { return 0; };
void ipx_read_user_file(char * filename) { };
void ipx_read_network_file(char * filename) { };
#endif
