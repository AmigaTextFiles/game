/* netToe Version 1.1.0
 * Release date: 22 July 2001
 * Copyright 2000,2001 Gabriele Giorgetti <g.gabriele@europe.com>
 *		
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#ifdef HAVE_CONFIG_H
#  include <config.h>
#endif
#include <stdio.h>
#include <string.h> 
#include <errno.h>
#include <signal.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/wait.h>
#include <netdb.h>

                     
extern int establish_listening_socket ( unsigned short port_number, char peer_ip_address[20]);
extern int connect_to_socket ( char host_ip_number[20], unsigned short port_number );
extern int write_to_socket ( int connected_socket, char *buffer, int bytes );
extern int read_from_socket (int connected_socket, char *buffer, int bytes);

extern const char *give_local_IP ( void );

/* extern const char *give_local_hostname ( void ); */ /* NOT USED */



