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

#include "network.h"

int establish_listening_socket (unsigned short port_number, char peer_ip_address[20])
{
  int sockfd, new_fd;
  int sin_size;
  int BACKLOG = 2;
  struct sockaddr_in my_addr;
  struct sockaddr_in their_addr;

  my_addr.sin_family = AF_INET;
  my_addr.sin_port = htons (port_number);
  my_addr.sin_addr.s_addr = INADDR_ANY;
  bzero (&(my_addr.sin_zero), 8);

 if ((sockfd = socket (AF_INET, SOCK_STREAM, 0)) == -1)
    {
       perror ("socket");
       fprintf (stderr, "Peer error: (socket). Quitting...\n\n");
      exit (1);
    }

 if (bind (sockfd, (struct sockaddr *) &my_addr, sizeof (struct sockaddr)) == -1)
    {
      /* perror ("bind"); */

       printf("\n##########################################################\n");
         printf("# NETWORK ERROR:                                         #\n");
         printf("# (bind: address already in use or permission is denied).#\n");
         printf("#                                                        #\n");
        printf ("# INFOS:                                                 #\n");
         printf("# This often happens when the ports used by netToe to    #\n");
        printf ("# comunicate, are busy                                   #\n");
        printf ("# Just wait a minute before running netToe again.        #\n");
       printf  ("##########################################################\n");
      printf ("Quitting...\n\n");
      exit (1);
    }
 if (listen (sockfd, BACKLOG) == -1)
    {
       perror ("listen");
      fprintf (stderr, "Peer error: (bind: address already in use or permission is denied).\nQuitting...\n\n");
      exit (1);
    }

   sin_size = sizeof (struct sockaddr_in);
   if ((new_fd = accept (sockfd, (struct sockaddr *) &their_addr, &sin_size)) == -1)
	{
	  perror ("accept");
	  fprintf (stderr, "Peer error: (accept). continuing:\n\n");
	}
   strcpy (peer_ip_address, inet_ntoa(their_addr.sin_addr));

  return(new_fd);
}

int connect_to_socket (char host_ip_number[20],  unsigned short port_number)
{

  int sockfd;
  struct hostent *he;
  struct sockaddr_in their_addr;	/* connector's address information */

  if ((he = gethostbyname (host_ip_number)) == NULL)
      { /* get the host info */
        /* herror ("gethostbyname"); */
       printf("\n##########################################################\n");
         printf("# NETWORK ERROR:                                         #\n");
         printf("# Wrong IP number give !                                .#\n");
         printf("#                                                        #\n");
        printf ("# INFOS:                                                 #\n");
         printf("# This happens when the type wrong IP numbers, an IP     #\n");
        printf ("# should be typed likethat ex: 192.168.0.1               #\n");
        printf ("# You can also give hostnames.                           #\n");
       printf  ("##########################################################\n");
      printf ("Quitting...\n\n");
      exit (1);
      }
       if ((sockfd = socket (AF_INET, SOCK_STREAM, 0)) == -1)
      {
       /* perror ("socket"); */
        /* printf ("\n  Do you want to try again [y/n] ?: "); */
      }

      their_addr.sin_family = AF_INET;	/* host byte order */
      their_addr.sin_port = htons (port_number);	/* short, network byte order */
      their_addr.sin_addr = *((struct in_addr *)he->h_addr);
      bzero (&(their_addr.sin_zero), 8);	/* zero the rest of the struct */

      if (connect (sockfd, (struct sockaddr *) &their_addr,sizeof (struct sockaddr)) == -1)
      {
        printf ("   No game found at: %s\n\n", host_ip_number);
        printf ("Try again if the host IP was typed correctly, maybe host\n");
        printf ("it is not ready yet.\n\n");
        exit (1);
      }

   return (sockfd);
 }


int read_from_socket ( int connected_socket, char *buffer, int bytes )
{
  int bytescount;
  int bytesread;

  bytescount = 0;
  bytesread  = 0;

  while (bytescount < bytes) {
    if ((bytesread = read(connected_socket, buffer, bytes-bytescount)) > 0) {
      bytescount += bytesread;
      buffer += bytesread;
    }
    else if (bytesread < 0)
      return(-1);
  }
  return( bytescount );
}

int write_to_socket ( int connected_socket, char *buffer, int bytes )
{
  int bytescount;
  int byteswrote;

  bytescount = 0;
  byteswrote  = 0;

  while (bytescount < bytes) {
    if ((byteswrote = write(connected_socket, buffer, bytes-bytescount)) > 0) {
      bytescount += byteswrote;
      buffer += byteswrote;
       }
    else if (byteswrote < 0)
      return(-1);
  }
  return( bytescount );
}




const char *give_local_IP ( void )
 {
  char hostname[100];
  struct hostent *h;

  gethostname ( hostname, 100);
  if ((h=gethostbyname(hostname)) == NULL)
      {
    herror("gethostbyname");
    }
  return( inet_ntoa(*((struct in_addr *)h->h_addr)));

}


/* NOT USED */
/* ==================================
const char *give_local_hostname( void )
 {
  char hostname[100];
  struct hostent *h;

  gethostname ( hostname, 100);

  if ((h=gethostbyname(hostname)) == NULL) {
            herror("gethostbyname");
        }
        strcpy(hostname, h->h_name );
        return ( hostname );
}
*/









