/*
	host_string.h
	internationalized string resource shared between client and server

	$Id: host_string.h 4076 2011-06-23 16:25:49Z sezero $
*/

#ifndef HOST_STRING_H
#define HOST_STRING_H

extern	char		*host_strings;
extern	int		*host_string_index;
extern	int		host_string_count;

void Host_LoadStrings (void);

#endif	/* HOST_STRING_H */
