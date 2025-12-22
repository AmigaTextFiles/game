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


#include "parser.h"

#ifdef WIN32
#define strcasecmp stricmp
#endif

parser::parser(){
}
parser::~parser(){
}

bool parser::same(char *a, char *b) {
	if ( strcasecmp(a, b) == 0) return 1;
	else return 0;
}

void parser::GetHost(char *host, char *inpacket, int *i) {
	int j=0;
	while (1) {
		if (inpacket[*i] == ' ') break;
		if (inpacket[*i] != ':') host[j++] = inpacket[*i];
		(*i)++;
	}
	host[j]='\0';
	(*i)++;
}

void parser::GetNick(char *nick, char *host) {
	int k;
	for (k=0; k<MAXNICKNAMELENGTH; k++) {
		if (host[k] == '!' || host[k] == ' ') break;
		nick[k]=host[k];
	}
	nick[k]='\0';
}

char *parser::GetFirstParam(char *msg, int *j) {
	int k=*j;

	while (1) {
		if (*j >= 512 || msg[*j]==' ' || ( (*j) >=1 && msg[(*j)-1]=='\r' && msg[*j]=='\n') ) break;
		(*j)++;
	}

	char *ret = new char[(*j)+1-k];
	strncpy (ret, &(msg[k]), (*j)-k);
	ret[(*j)-k]='\0';

	(*j)++;

	return ret;
}

char *parser::GetParam(char *msg, int *j) {
	int k=*j;
	if (msg[*j]==':') {
		while (1) {
			if (*j >= 512 || ( (*j)>=1 && msg[(*j)-1]=='\r' && msg[(*j)]=='\n' ) ) break;
			(*j)++;
		}
		char *ret = new char[(*j)-k];

		strncpy (ret, &(msg[k+1]), (*j)-k);

		ret[(*j)-k-2]='\0';

		(*j)++;

		return ret;
	} else {
		return GetFirstParam(msg, j);
	}
}

int parser::GetNumber(char *str) {
	char *arvo = new char[strlen(str)+2];
	if (str[0]!='-')	sprintf (arvo, "+%s", str);
	else sprintf (arvo, "%s", str);
	return strtol(arvo, (char**)NULL, 10);
}
