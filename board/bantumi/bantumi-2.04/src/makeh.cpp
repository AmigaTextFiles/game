/*
    Bantumi
    Copyright 2005 - 2007 Martin Storsjö

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

    Martin Storsjö
    martin@martin.st
*/

#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
	if (argc < 2) {
		printf("%s file\n", argv[0]);
		return 0;
	}
	char *inname = argv[1];
	FILE *in = fopen(inname, "rb");
	if (!in) {
		perror(inname);
		return 1;
	}
	char dataname[100];
	char outname[100];
	for (int i = 0; inname[i] != '\0'; i++) {
		if (inname[i] == '.')
			dataname[i] = '_';
		else
			dataname[i] = inname[i];
	}
	dataname[strlen(inname)] = '\0';
	strcpy(outname, dataname);
	strcat(outname, ".h");
	FILE *out = fopen(outname, "w");
	if (!out) {
		perror(outname);
		fclose(in);
		return 1;
	}
	fseek(in, 0, SEEK_END);
	int length = ftell(in);
	fseek(in, 0, SEEK_SET);
	fprintf(out, "const int %s_length = %d;\n", dataname, length);
	fprintf(out, "const unsigned char %s[] = {\n", dataname);
	int n = 0;
	int c;
	while ((c = fgetc(in)) != EOF) {
		if (n % 10 == 0)
			fprintf(out, "\t");
		fprintf(out, "0x%02x", c);
		n++;
		if (n < length)
			fprintf(out, ",");
		if (n % 10 == 0)
			fprintf(out, "\n");
		else
			fprintf(out, " ");
	}
	if (n % 10 != 0)
		fprintf(out, "\n");
	fprintf(out, "};\n");
	fclose(out);
	fclose(in);
	return 0;
}

