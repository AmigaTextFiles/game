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


#include "variable.h"

int variable::Str2Int(char *str, int from) {
	int luku=0;
	int len=strlen(str);
	bool found=false;
	int minus=0;

	for (int i=from; (i<len && !found); i++) {
		if (str[i]=='-') minus++;
		if ( str[i] >='0' && str[i] <= '9' ) {
			from=i;
			found=true;
		}
	}

	if (found==false) return -1;
//	found=false;

	for (int i=from; i<len; i++) {
		char ch=str[i];
		if (ch <'0' || ch >'9') break;
		luku=luku*10+(str[i]-'0');
	}

	if ((minus%2)==1) return -luku;

	return luku;
}

Uint32 variable::Str2IP(char *str, int from) {
	int i=from;
	int len = strlen(str);
	int ip[4]={0};
	int cip=0;

	for (i=from; (i<len && cip<4); i++) {
		if (str[i]=='.') cip++;
		if (str[i]>='0' || str[i]<='9') ip[cip]=ip[cip]*10+str[i]-'0';
	}
	return (ip[3] <<24) | (ip[2]<<16) | (ip[1]<<8) | ip[0];

}

char * variable::IP2Str(Uint32 ip) { // remember to delete! -MG
	char *str = new char[16];
	sprintf (str, "%d.%d.%d.%d", (Uint8)ip, (Uint8)(ip>>8), (Uint8)(ip>>16), (Uint8)(ip>>24) );
	return str;
}

bool variable::Str_CheckLastChars (char *filepath, char *extension) { // Checks, for example, the extension of a file name.
	if ( strcmp ( &filepath[strlen(filepath)-strlen(extension)], extension ) == 0 ) return 1;
	return 0;
}

void variable::ToFile_Int(FILE *stream, Uint32 data) {
	fwrite (&data, sizeof(Uint32), 1, stream);
}

void variable::FromFile_Int(FILE *stream, Uint32 *data) {
	fread (data, sizeof(Uint32), 1, stream);
	*data = SWAP32(*data);
}

void variable::ToFile_ShortInt(FILE *stream, Uint16 data) {
	fwrite (&data, sizeof(Uint16), 1, stream);
	data = SWAP16(data);
}

void variable::FromFile_ShortInt(FILE *stream, Uint16 *data) {
	fread (data, sizeof(Uint16), 1, stream);
}

char *variable::str_split(char *str, char ch, int num) {
	int i=0;
	int len=strlen(str);
	int n=0;

	// search to the beginning of the num'th piece

	for (i=0; n<num; i++) {
		if (i>=len) return 0;

		if (str[i]==ch) {
			n++;
		}
	}
	if (n<num) return 0;

	int start=i;

	// find out how long it is

	while (1) {
		if (str[i]==ch) break;
		if (i>=len) break;
		i++;
	}

	// Now length is i-start. Create the new array and mark it to end at the right place.

	// there's no information?
	if (i-start==0) return 0;

	char *parameter = new char[i-start+1];
	strncpy(parameter, &(str[start]), (i-start));
	parameter[i-start]='\0';

	return parameter;
}

bool variable::str_splitcompare(char *str, int num, char *str2) {
	bool ret;
	char *c = str_split(str, ' ', num);
	if (c) {
		if (strcmp(c, str2)==0) ret=true;
		else ret=false;
		delete[] c;
	} else return false;

	return ret;
}

int variable::str_splitgetint(char *str, char ch, int num) {
	int r=-1;
	char *c = str_split(str, ch, num);
	if (c) {
		r = Str2Int(c, 0);
		delete[] c;
		return r;
	}
	else return -1;

}

char *variable::str_fullsplit(char *str, char ch, int num) {
	int i=0;
	int len=strlen(str);
	int n=0;

	// search to the beginning of the num'th piece

	for (i=0; n<num; i++) {
		if (i>=len) return 0;

		if (str[i]==ch) {
			n++;
		}
	}
	if (n<num) return 0;

	int start=i;

	i = len;

	// Now length is i-start. Create the new array and mark it to end at the right place.

	// there's no information?
	if (i-start==0) return 0;

	char *parameter = new char[i-start+1];
	strncpy(parameter, &(str[start]), (i-start));
	parameter[i-start]='\0';

	return parameter;
}
