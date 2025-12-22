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
#include <sys/types.h>
#include <sys/time.h>
#include <netinet/in.h> /* for htons & co. */

#include "types.h"
#include "config.h"

#include "ipx_ldescent.h"
#include "ipx_helper.h"
#ifdef WANT_KALI
#include "ipx_kali.h"
#endif

#define MAX_IPX_DATA 576

int ipx_fd;
ipx_socket_t ipx_socket_data;
ubyte ipx_installed=0;
extern ushort ipx_socket;
uint ipx_network = 0;
ubyte ipx_MyAddress[10];
int ipx_packetnum = 0;          /* Sequence number */

/* User defined routing stuff */
typedef struct user_address {
	ubyte network[4];
	ubyte node[6];
	ubyte address[6];
} user_address;
#define MAX_USERS 64
int Ipx_num_users = 0;
user_address Ipx_users[MAX_USERS];

#define MAX_NETWORKS 64
int Ipx_num_networks = 0;
uint Ipx_networks[MAX_NETWORKS];


int ipx_general_PacketReady(ipx_socket_t *s) {
	fd_set set;
	struct timeval tv;
	
	FD_ZERO(&set);
	FD_SET(s->fd, &set);
	tv.tv_sec = tv.tv_usec = 0;
	if (select(s->fd + 1, &set, NULL, NULL, &tv) > 0)
		return 1;
	else
		return 0;
}


struct ipx_helper ipx_kali = {
	ipx_kali_GetMyAddress,
	ipx_kali_OpenSocket,
	ipx_kali_CloseSocket,
	ipx_kali_SendPacket,
	ipx_kali_ReceivePacket,
	ipx_general_PacketReady
};

struct ipx_helper *helper = &ipx_kali;

ubyte * ipx_get_my_server_address_kali()
{
	return (ubyte *)&ipx_network;
}

ubyte * ipx_get_my_local_address_kali()
{
	return (ubyte *)(ipx_MyAddress + 4);
}

//---------------------------------------------------------------
// Initializes all IPX internals. 
// If socket_number==0, then opens next available socket.
// Returns: 0  if successful.
//              -1 if socket already open.
//              -2  if socket table full.
//              -3 if IPX not installed.
//              -4 if couldn't allocate low dos memory
//              -5 if error with getting internetwork address
int ipx_init_kali( int socket_number, int show_address )
{
#ifdef WANT_KALI
	if (*config_kali_server)    /* kali configured? */
		helper = &ipx_kali;
	else {
		printf("No kali server given\n");
		return -3;
	}

#endif      

	if (helper->OpenSocket(&ipx_socket_data, socket_number)) {
		return -3;
	}
	helper->GetMyAddress();
	ipx_installed = 1;
	memcpy(&ipx_network, ipx_MyAddress, 4);
	Ipx_num_networks = 0;
	memcpy( &Ipx_networks[Ipx_num_networks++], &ipx_network, 4 );
	return 0;
}

void ipx_close_kali()
{
	helper->CloseSocket(&ipx_socket_data);
	ipx_installed = 0;
}

int ipx_get_packet_data_kali( ubyte * data )
{
	struct ipx_recv_data rd;
	char buf[MAX_IPX_DATA];
	uint best_id = 0;
	uint pkt_num;
	int size;
	int best_size = 0;
	
	// Like the original, only take latest packet, throw away rest
	while (helper->PacketReady(&ipx_socket_data)) {
		if ((size = 
			 helper->ReceivePacket(&ipx_socket_data, buf, 
			  sizeof(buf), &rd)) > 4) {
			 if (!memcmp(rd.src_network, ipx_MyAddress, 10)) 
				continue;   /* don't get own pkts */
			 pkt_num = *(uint *)buf;
			 if (pkt_num >= best_id) {
				memcpy(data, buf + 4, size - 4);
				best_id = pkt_num;
				best_size = size - 4;
			 }
		}
	}
	return best_size;
}

void ipx_send_packet_data_kali( ubyte * data, int datasize, ubyte *network, ubyte *address, ubyte *immediate_address )
{
	u_char buf[MAX_IPX_DATA];
	IPXPacket_t ipx_header;
	
	memcpy(ipx_header.Destination.Network, network, 4);
	memcpy(ipx_header.Destination.Node, immediate_address, 6);
	*(u_short *)ipx_header.Destination.Socket = htons(ipx_socket_data.socket);
	ipx_header.PacketType = 4; /* Packet Exchange */
	*(uint *)buf = ipx_packetnum++;
	memcpy(buf + 4, data, datasize);
	helper->SendPacket(&ipx_socket_data, &ipx_header, buf, datasize + 4);
}

void ipx_get_local_target_kali( ubyte * server, ubyte * node, ubyte * local_target )
{
	// let's hope Linux know how to route it
	memcpy( local_target, node, 6 );
}

void ipx_send_broadcast_packet_data_kali( ubyte * data, int datasize )
{
	int i, j;
	ubyte broadcast[] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
	ubyte local_address[6];

	// Set to all networks besides mine
	for (i=0; i<Ipx_num_networks; i++ ) {
		if ( memcmp( &Ipx_networks[i], &ipx_network, 4 ) )  {
			ipx_get_local_target_kali( (ubyte *)&Ipx_networks[i], broadcast, local_address );
			ipx_send_packet_data_kali( data, datasize, (ubyte *)&Ipx_networks[i], broadcast, local_address );
		} else {
			ipx_send_packet_data_kali( data, datasize, (ubyte *)&Ipx_networks[i], broadcast, broadcast );
		}
	}

	//OLDipx_send_packet_data( data, datasize, (ubyte *)&ipx_network, broadcast, broadcast );

	// Send directly to all users not on my network or in the network list.
	for (i=0; i<Ipx_num_users; i++ )    {
		if ( memcmp( Ipx_users[i].network, &ipx_network, 4 ) )  {
			for (j=0; j<Ipx_num_networks; j++ )     {
				if (!memcmp( Ipx_users[i].network, &Ipx_networks[j], 4 ))
					goto SkipUser;
			}
			ipx_send_packet_data_kali( data, datasize, Ipx_users[i].network, Ipx_users[i].node, Ipx_users[i].address );
SkipUser:
			j = 0;
		}
	}
}

// Sends a non-localized packet... needs 4 byte server, 6 byte address
void ipx_send_internetwork_packet_data_kali( ubyte * data, int datasize, ubyte * server, ubyte *address )
{
	ubyte local_address[6];

	if ( (*(uint *)server) != 0 )   {
		ipx_get_local_target_kali( server, address, local_address );
		ipx_send_packet_data_kali( data, datasize, server, address, local_address );
	} else {
		// Old method, no server info.
		ipx_send_packet_data_kali( data, datasize, server, address, address );
	}
}

int ipx_change_default_socket_kali( ushort socket_number )
{
	if ( !ipx_installed ) return -3;

	ipx_close_kali();
	return ipx_init_kali(socket_number, 0);
}

void ipx_read_user_file_kali(char * filename)
{
	FILE * fp;
	user_address tmp;
	char temp_line[132], *p1;
	int n, ln=0;

	if (!filename) return;

	Ipx_num_users = 0;

	fp = fopen( filename, "rt" );
	if ( !fp ) return;

	printf( "Broadcast Users:\n" );

	while (fgets(temp_line, 132, fp)) {
		ln++;
		p1 = strchr(temp_line,'\n'); if (p1) *p1 = '\0';
		p1 = strchr(temp_line,';'); if (p1) *p1 = '\0';
		n = sscanf( temp_line, "%2x%2x%2x%2x/%2x%2x%2x%2x%2x%2x", &tmp.network[0], &tmp.network[1], &tmp.network[2], &tmp.network[3], &tmp.node[0], &tmp.node[1], &tmp.node[2],&tmp.node[3], &tmp.node[4], &tmp.node[5] );
		if ( n != 10 ) continue;
		if ( Ipx_num_users < MAX_USERS )    {
			ubyte * ipx_real_buffer = (ubyte *)&tmp;
			ipx_get_local_target_kali( tmp.network, tmp.node, tmp.address );
			Ipx_users[Ipx_num_users++] = tmp;
			printf( "%02X%02X%02X%02X/", ipx_real_buffer[0],ipx_real_buffer[1],ipx_real_buffer[2],ipx_real_buffer[3] );
			printf( "%02X%02X%02X%02X%02X%02X\n", ipx_real_buffer[4],ipx_real_buffer[5],ipx_real_buffer[6],ipx_real_buffer[7],ipx_real_buffer[8],ipx_real_buffer[9] );
		} else {
			printf( "Too many addresses in %s! (Limit of %d)\n", filename, MAX_USERS );
			fclose(fp);
			return;
		}
	}
	fclose(fp);
}


void ipx_read_network_file_kali(char * filename)
{
	FILE * fp;
	user_address tmp;
	char temp_line[132], *p1;
	int i, n, ln=0;

	if (!filename) return;

	fp = fopen( filename, "rt" );
	if ( !fp ) return;

	printf( "Using Networks:\n" );
	for (i=0; i<Ipx_num_networks; i++ )     {
		ubyte * n1 = (ubyte *)&Ipx_networks[i];
		printf("* %02x%02x%02x%02x\n", n1[0], n1[1], n1[2], n1[3] );
	}

	while (fgets(temp_line, 132, fp)) {
		ln++;
		p1 = strchr(temp_line,'\n'); if (p1) *p1 = '\0';
		p1 = strchr(temp_line,';'); if (p1) *p1 = '\0';
		n = sscanf( temp_line, "%2x%2x%2x%2x", &tmp.network[0], &tmp.network[1], &tmp.network[2], &tmp.network[3] );
		if ( n != 4 ) continue;
		if ( Ipx_num_networks < MAX_NETWORKS  ) {
			int j;
			for (j=0; j<Ipx_num_networks; j++ ) 
				if ( !memcmp( &Ipx_networks[j], tmp.network, 4 ) )
					break;
			if ( j >= Ipx_num_networks )    {
				memcpy( &Ipx_networks[Ipx_num_networks++], tmp.network, 4 );
				printf("  %02x%02x%02x%02x\n", tmp.network[0], tmp.network[1], tmp.network[2], tmp.network[3] );
			}
		} else {
			printf( "Too many networks in %s! (Limit of %d)\n", filename, MAX_NETWORKS );
			fclose(fp);
			return;
		}
	}
	fclose(fp);
}
