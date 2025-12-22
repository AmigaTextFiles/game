#ifndef _LINUXNET_H_
#define _LINUXNET_H_

#include <sys/types.h>

ubyte * ipx_get_my_server_address_kali(void);
ubyte * ipx_get_my_local_address_kali(void);
int ipx_init_kali( int socket_number, int show_address );
void ipx_close_kali(void);
int ipx_get_packet_data_kali( ubyte * data );
void ipx_send_packet_data_kali( ubyte * data, int datasize, ubyte *network, ubyte *address, ubyte *immediate_address );
void ipx_get_local_target_kali( ubyte * server, ubyte * node, ubyte * local_target );
void ipx_send_broadcast_packet_data_kali( ubyte * data, int datasize );
void ipx_send_internetwork_packet_data_kali( ubyte * data, int datasize, ubyte * server, ubyte *address );
int ipx_change_default_socket_kali( ushort socket_number );
void ipx_read_user_file_kali(char * filename);
void ipx_read_network_file_kali(char * filename);

#endif










