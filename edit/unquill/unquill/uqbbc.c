/* UnQuill [BBC]: Disassemble games written with the "Quill" adventure game 
 *                system (BBC micro version) 
 *  Copyright (C) 2017  John Elliott <seasip.webmaster@gmail.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define VERSION "0.1.0"

/* BBC Quill is sufficiently different internally that trying to add 
 * support for it to the existing UnQuill is impossible without major
 * refactoring (essentially, encapsulating the database behind an
 * abstraction layer). So instead, write a stripped-down UnQuill that just 
 * handles the BBC format. Similar to unplad and unphipps in concept. */ 

/* The file format supported is BeebEm snapshot: 
 * 00000 DB 'BEMSNAP1'	; Magic, 8 bytes
 * 00008 DB model		; BBC model
 * 00009 DB cpu_state
 * 00016 DB ramregs		; Last write to #FE30 and #FE34
 * 00018 DB bbc_ram		; 64k
 * 10018 DB bbc_rom		; 256k 
 * State records for other devices follow, but we don't
 * really care about them. */

/* BBC Quill database format: 
 * In the two examples I have given, the database is at 3500h:
 *	
 * 	DW	vocab		;Vocab table
 *	DW	messages	;Message table (BBC Quill does not distinguish
 *				;between system and non-system messages)
 *	DW	locations	;Location description table
 *	DW	objects		;Object description table
 *	DW	obnames		;Object names / initial locations table
 * 	DW	connections	;Connections table
 *	DW	response	;Response table
 *	DW	process		;Process table
 *	DW	top		;First byte beyond end of database
 *	DB	maxmsg		;Highest message number used 
 *	DB	maxloc		;Highest location number used 
 *	DB	maxobj		;Highest object number used 
 *
 * Vocab format:
 * 	DB	'word', wordid	;4 bytes ASCII, 1 byte word id
 * 	DB	'word', wordid	;4 bytes ASCII, 1 byte word id
 *	... 
 *	No end marker; compare address with base of message table.
 *
 * Message / location / object format:
 * 
 *	DB	length, text	;Item 0
 *	DB	length, text	;Item 1
 *	...
 *	etc.
 *	The length byte is the length of the entire record; so
 *	the string 'OK.' is held as 4,'O','K','.'
 *
 *	In a text record, the top bit is set if the character is followed 
 * 	by a space. Characters 0-31 are expanded to two-character 
 *	sequences; '@' is rendered as space, and '>' as newline.
 *
 * Object names / initial locations table format:
 *
 *	DB	name0,name1,name2...	;One byte for each object up to maxobj
 *					;Each byte is a word ID from vocab 
 *	DB	loc0,loc1,loc2...	;One byte for each object up to maxobj
 *					;Value is location number, or:
 *					; 0FFh => not created
 *					; 0FEh => carried
 *					; 0FDh => worn 
 * Connections table format:
 *	DB	length, data	;Item 0
 *	DB	length, data	;Item 1
 *	...
 *	etc.
 * As with messages and location descriptions, the length is the length of
 * the complete record including the length byte.
 * The data will be in the form:
 *	DB	wordid,location,{wordid,location ...}, 0FFh
 *
 * Response/process table format:
 *	DB 	verb, noun	;If both are 0FFh, end of table
 *	DB	length		;Length of bytecode record that follows, 
 *				;including this length byte
 *	DB	...bytecode...
 *
 * Unlike in other versions of the Quill, but like PAW, no distinction is 
 * made between the 'condition' and 'action' sections of the bytecode; 
 * conditions and actions can be interleaved.
 *
 * This is my best guess at the meanings of the condition / action bytes. 
 * There's a certain amount of guesswork here (seeing how they're used in 
 * a couple of sample games, and then comparing the disassembly of used 
 * opcodes to unused ones). So I may well have incorrect definitions for
 * some of them, or have them in the wrong order.
 *
 *	00	INV		;List player's inventory
 *	01	DESC		;Describe current location, cease processing
 *				;bytecode
 *	02	DROPALL		;Transfer any carried or worn objects to the
 *				;player's current location.
 *	03	DONE		;Cease processing bytecode, prompt for new 
 *				;input.
 *	04	OK		;Print "OK." and behave as DONE.
 *	05	KEY		;Print "Press any key to continue", wait for
 *				;a keypress
 *	06	AUTOG		;Find an object matching the current noun and
 *				;attempt to GET it.
 *	07	AUTOD		;Find an object matching the current noun and
 *				;attempt to DROP it.
 *	08	AUTOW		;Find an object matching the current noun and
 *				;attempt to WEAR it.
 *	09	AUTOR		;Find an object matching the current noun and
 *				;attempt to REMOVE it.
 *	0A	SAVE		;Save the game state
 *	0B	LOAD		;Load the game state
 *	0C	QUIT		;Ask 'Yes or no?'. If answer is 'Yes', 
 *				;continue; if 'No', move to next condition
 *	0D	CLS		;Clear the screen
 *	0E	END		;End the game
 *	0F	ATLT nn		;Continue if the current room number < nn.
 *	10	ATGT nn		;Continue if the current room number > nn.
 *	11	NOTAT nn	;Continue if the current room number != nn.
 *	12	AT nn		;Continue if the current room number == nn.
 *	13	PRESENT nn	;Continue if the specified object is present.
 *	14	ABSENT nn	;Continue if the specified object is absent.
 *	15	NOTWORN nn	;Continue if the specified object isn't worn.
 *	16	WORN nn		;Continue if the specified object is worn.
 *	17	NOTCARR nn	;Continue if the specified object isn't carried.
 *	18	CARRIED nn	;Continue if the specified object is carried.
 *	19	CREATED nn	;Continue if the specified object exists.
 *	1A	DESTROYED nn	;Continue if the specified object doesn't exist.
 *	1B	CREATE nn	;Move the specified object to the current room.
 *	1C	DESTROY nn	;Move the specified object to location 0xFF.
 *	1D	MESSAGE nn	;Print the specified message followed by CR/LF.
 *	1E	CHANCE nn	;Continue if a random number 0-99 < nn.
 *	1F	GET nn		;Attempt to get the specified object.
 *	20	DROP nn		;Attempt to drop the specified object.
 *	21	WEAR nn		;Attempt to don the specified object.
 *	22	REMOVE nn	;Attempt to doff the specified object.
 *	23	NOTZERO nn	;Continue if flag nn is not zero.
 *	24	ZERO nn		;Continue if flag nn is zero.
 *	25	PAUSE nn	;Delay for nn/50 seconds.
 * 	26	GOTO nn		;Move the player to location nn.
 *	27	MES nn		;Print message nn, not followed by CR/LF.
 *	28	SET nn		;Set flag nn to 0xFF.
 *	29	CLEAR nn	;Set flag nn to 0x00.
 *	2A	PRINT nn	;Print the value of flag nn.
 *	2B	STAR nn		;Execute message nn as an operating system
 *				;command (it must start with '*').
 *	2C	PLUS nn mm	;Add mm to the value of flag nn.
 *	2D	MINUS nn mm	;Subtract mm from the value of flag nn.
 *	2E	LET nn mm	;Set flag nn to mm.
 *	2F	ADD nn mm	;Add flag mm to the value of flag nn.
 *	30	SUB nn mm	;Subtract flag mm from the value of flag nn.
 *	31	SWAP nn mm	;Exchange the locations of objects nn and mm.
 *	32	PLACE nn mm	;Place object nn in location mm.
 *	33	NOTEQ nn mm	;Continue if flag nn != mm.
 *	34	EQ nn mm	;Continue if flag nn == mm.
 *	35	LT nn mm	;Continue if flag nn < mm.
 *	36	GT nn mm	;Continue if flag nn > mm.
 *	37	JSR nn mm	;Call a machine-code routine at mm*256+nn.
 *	38	SOUND nn mm	;Play a beep (nn=pitch, mm=duration).
*/
#if (CPM || __PACIFIC__)
#define AV0 "UNQBBC"
#else
#define AV0 argv[0]
#endif

unsigned char beebmem[0x8000];
unsigned short base = 0;
unsigned short vocab = 0;
unsigned short messages = 0;
unsigned short locations = 0;
unsigned short objects = 0;
unsigned short obwords = 0;
unsigned short connections = 0;
unsigned short process = 0;
unsigned short response = 0;

unsigned max_message = 0;
unsigned max_location = 0;
unsigned max_object = 0;

int skipc;
int skipl;
int skipm;
int skipn;
int skipo;
int skipv;
int verbose;

unsigned short peek2(unsigned short addr)
{
	return (beebmem[addr+1] << 8) | beebmem[addr];
}

void dump_vocab()
{
	int n;

	for (n = vocab; n < messages; n += 5)
	{
		printf("%04x: Word %3d: %-4.4s\n", n, 
			beebmem[n+4], beebmem+n);
	}
}

void printword(int w)
{
	int n;

	for (n = vocab; n < messages; n += 5)
	{
		if (beebmem[n+4] == w)
		{
			printf("%-4.4s", beebmem+n);
			return;
		}
	}
	printf("<%02x>", w);
}

void pch(unsigned char c, int *xpos, int indent)
{
	putchar(c);
	++(*xpos);
	if (*xpos == 40)
	{
		printf("\n%-*.*s", indent, indent, "");	
		if (indent > 6) putchar(';');
		*xpos = 0;
	}
}


void dump_msg(int taddr, int indent)
{
	int n;
	unsigned char ch;
	int xpos = 0;

	static const char letter1[] = "sciieloetehldrncoeitaseaeodlaeag";
	static const char letter2[] = "thendeuehrelsetkratonsstnooydxmh";

	for (n = 1; n < beebmem[taddr]; n++)
	{
		ch = beebmem[taddr + n];

		if ((ch & 0x7F) < 0x20)
		{
			pch(letter1[ch & 0x7F], &xpos, indent);
			pch(letter2[ch & 0x7F], &xpos, indent);
		}
		else if ((ch & 0x7F) == '@')
		{
			pch(' ', &xpos, indent);
		}
		else if ((ch & 0x7F) == '>')
		{
			printf("\n%-*.*s", indent, indent, "");	
			if (indent > 6) putchar(';');
			xpos = 0;
		}
		else
		{
			pch(ch & 0x7F, &xpos, indent);
		}	
		if (ch & 0x80)  pch(' ', &xpos, indent);
	}
	putchar('\n');
}

void dump_msgs(int taddr, int count, const char *type)
{
	int n;

	for (n = 0; n <= count; n++)
	{
		if (!beebmem[taddr]) break;

		printf("%04x: %s %d:\n      ", taddr, type, n);
		dump_msg(taddr, 6);
		taddr += beebmem[taddr];		
	}
}

void singlemsg(int table, int object, int indent)
{
	while (object)
	{
		table += beebmem[table];
		--object;
	}
	putchar(';');
	dump_msg(table, indent);
}

void dump_conn(int taddr, int count)
{
	int n, m;

	for (n = 0; n <= count; n++)
	{
		if (!beebmem[taddr]) break;

		printf("%04x: Connections from %3d: ", taddr, n);
		if (verbose)
		{
			singlemsg(locations, n, 28); 
		}
		else	putchar('\n');

		for (m = 1; m < beebmem[taddr]; m += 2)
		{
			if (beebmem[taddr+m] == 0xFF) break;

			printf("      ");
			printword(beebmem[taddr+m]);
			printf(" to %3d           ", beebmem[taddr+m+1]);
			if (verbose)
			{
				singlemsg(locations, beebmem[taddr+m+1], 28); 
			}
			else	putchar('\n');
		}
		putchar('\n');
		taddr += beebmem[taddr];		
	}
}

void dump_obwords(unsigned short table)
{
	int n;

	for (n = 0; n <= max_object; n++)
	{
		printf("%04x: Object %3d named ", table + n, n);
		printword(beebmem[table + n]);
		printf("     ");
		if (verbose)
		{
			singlemsg(objects, n, 32); 
		}
		else putchar('\n');
	}
	table += (max_object + 1);
	for (n = 0; n <= max_object; n++)
	{
		printf("%04x: Object %3d is initially ", table + n, n);
		switch (beebmem[table + n])
		{
			case 0xFF: printf("not created.\n"); break;
			case 0xFE: printf("worn.\n"); break;
			case 0xFD: printf("carried.\n"); break;
			default: printf("in room %3d.\n", beebmem[table+n]); 
				 break;
		}
		if (verbose)
		{
			printf("%-*.*s", 32,32, "");
			singlemsg(objects, n, 32);
			if (beebmem[table+n] < 0xFD)
			{
				printf("%-*.*s", 32,32, "");
				singlemsg(locations, beebmem[table+n], 32);
			}
		}	
	
	}
	putchar('\n');
}


void listcond(unsigned short table)
{
	int n;
	int cond;
	int p1, p2;

	for (n = 1; n < beebmem[table]; n++)
	{
		cond = beebmem[table + n];
		p1 = beebmem[table + n+1];
		p2 = beebmem[table + n+2];

		printf("%04x:           ", n+table);
		switch (cond)
		{
			case  0: printf("INV\n"); break;
			case  1: printf("DESC\n"); break;
			case  2: printf("DROPALL\n"); break;
			case  3: printf("DONE\n"); break;
			case  4: printf("OK\n"); break;
			case  5: printf("KEY\n"); break;
			case  6: printf("AUTOG\n"); break;
			case  7: printf("AUTOD\n"); break;
			case  8: printf("AUTOW\n"); break;
			case  9: printf("AUTOR\n"); break;
			case 10: printf("SAVE\n"); break;
			case 11: printf("LOAD\n"); break;
			case 12: printf("QUIT\n"); break;
			case 13: printf("CLS\n"); break;
			case 14: printf("END\n"); break;
			case 15: printf("ATLT    %3d     ", p1);
				if (verbose)
				{
					singlemsg(locations, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 16: printf("ATGT    %3d     ", p1);
				if (verbose)
				{
					singlemsg(locations, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 17: printf("NOTAT   %3d     ", p1);
				if (verbose)
				{
					singlemsg(locations, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 18: printf("AT      %3d     ", p1);
				if (verbose)
				{
					singlemsg(locations, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 19: printf("PRESENT %3d     ", p1);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 20: printf("ABSENT  %3d     ", p1);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 21: printf("NOTWORN %3d     ", p1);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 22: printf("WORN    %3d     ", p1);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 23: printf("NOTCARR %3d     ", p1);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 24: printf("CARRIED %3d     ", p1);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 25: printf("CREATED %3d     ", p1);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 26: printf("DESTROYED %3d   ", p1);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 27: printf("CREATE  %3d     ", p1);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 28: printf("DESTROY %3d     ", p1);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 29: printf("MES    %3d     ", p1);
				if (verbose)
				{
					singlemsg(messages, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 30: printf("CHANCE  %3d     \n", p1);
				++n;
				break;
			case 31: printf("GET     %3d     ", p1);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 32: printf("DROP    %3d     ", p1);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 33: printf("WEAR    %3d     ", p1);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 34: printf("REMOVE  %3d     ", p1);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 35: printf("NOTZERO %3d\n", p1);
				++n;
				break;
			case 36: printf("ZERO    %3d\n", p1);
				++n;
				break;
			case 37: printf("PAUSE   %3d\n", p1);
				++n;
				break;
			case 38: printf("GOTO    %3d     ", p1);
				if (verbose)
				{
					singlemsg(locations, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 39: printf("MESS    %3d     ", p1);
				if (verbose)
				{
					singlemsg(messages, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 40: printf("SET     %3d\n", p1);
				++n;
				break;
			case 41: printf("CLEAR   %3d\n", p1);
				++n;
				break;
			case 42: printf("PRINT   %3d\n", p1);
				++n;
				break;
			case 43: printf("STAR    %3d     ", p1);
				if (verbose)
				{
					singlemsg(messages, p1, 32); 
				}
				else putchar('\n');
				++n;
				break;
			case 44: printf("PLUS    %3d %3d\n", p1, p2);
				n += 2;
				break;
			case 45: printf("MINUS   %3d %3d\n", p1, p2);
				n += 2;
				break;
			case 46: printf("LET     %3d %3d\n", p1, p2);
				n += 2;
				break;
			case 47: printf("ADD     %3d %3d\n", p1, p2);
				n += 2;
				break;
			case 48: printf("SUB     %3d %3d\n", p1, p2);
				n += 2;
				break;
			case 49: printf("SWAP    %3d %3d ", p1, p2);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
					printf("%-32.32s", "");
					singlemsg(objects, p2, 32); 
				}
				else putchar('\n');
				n += 2;
				break;

			case 50: printf("PLACE   %3d %3d ", p1, p2);
				if (verbose)
				{
					singlemsg(objects, p1, 32); 
					printf("%-32.32s", "");
					singlemsg(locations, p2, 32); 
				}
				else putchar('\n');
				n += 2;
				break;
			case 51: printf("NOTEQ   %3d %3d\n", p1, p2);
				n += 2;
				break;
			case 52: printf("EQ      %3d %3d\n", p1, p2);
				n += 2;
				break;
			case 53: printf("LT      %3d %3d\n", p1, p2);
				n += 2;
				break;
			case 54: printf("GT      %3d %3d\n", p1, p2);
				n += 2;
				break;
			case 55: printf("JSR     0x%04x\n", 
					p2 * 256 + p1);
				n += 2;
				break;
			case 56: printf("SOUND   %3d %3d\n", p1, p2);
				n += 2;
				break;
			default: printf("<%02x>\n", cond); break;
		}
	}

}

void dump_cond(unsigned short table, const char *title)
{
	unsigned char verb, noun;

	printf("%04x: %s table\n", table, title);

	while (1)	
	{
		verb = beebmem[table];
		noun = beebmem[table + 1];
		if (verb == 0xFF && noun == 0xFF) break;
		
		printf("%04x: ", table);
		printword(verb);			
		putchar(' ');
		printword(noun);
		putchar('\n');
		table += 2;
		listcond(table);
		table += beebmem[table];
	}
}



void dump_game()
{
	printf("      ; Generated by UnQBBC " VERSION "\n");
	printf("      ; Quill signature found at %04x\n", base - 0x67);
	printf("%04x: Player can carry %d objects.\n", base + 21,
					beebmem[base+21]);

	vocab = peek2(base);
	messages = peek2(base + 2);
	locations = peek2(base + 4);
	objects = peek2(base + 6);
	obwords = peek2(base + 8);
	connections = peek2(base+10);
	response = peek2(base+12);
	process = peek2(base+14);
	/* base+16 = top of database */
	max_message  = beebmem[base + 18];
	max_location = beebmem[base + 19];
	max_object   = beebmem[base + 20];

	if (!skipv) dump_vocab();
	if (!skipm) dump_msgs(messages,  max_message,  "Message");
	if (!skipl) dump_msgs(locations, max_location, "Location");
	if (!skipo) 
	{
		dump_msgs(objects,   max_object,   "Object");
		dump_obwords(obwords);
	}
	if (!skipn) dump_conn(connections, max_location);
	if (!skipc) 
	{
		dump_cond(response, "Response");
		dump_cond(process, "Process");
	}

}

void syntax(const char *a0, const char *arg)
{
	fprintf(stderr, "%s: Unrecognised option '%s'\n", a0, arg);

	fprintf(stderr, "Syntax: %s { options } snapshot\n\n"
		"Options are:\n"
		"-sc: Skip conditions\n"
		"-sl: Skip locations\n"
		"-sm: Skip messages\n"
		"-sn: Skip connections\n"
		"-so: Skip objects\n"
		"-sv: Skip vocabulary\n", a0);
	exit(1);
}

int signature_at(int addr)
{
	return !memcmp(beebmem + addr, "~   The Quill\r", 14);
}


int main(int argc, char **argv)
{
	char *infile = NULL;
	int n;
	int endopt = 0;
	FILE *fp;
	unsigned char header[0x18];

	for (n = 1; n < argc; n++)
	{
		if (argv[n][0] == '-' && !endopt)
		{
			switch (argv[n][1])
			{
				case '-':
					if (argv[n][2] == 0) endopt = 1;
					break;
				case 'v': case 'V':
					verbose = 1;
					break;
				case 's': case 'S':
					switch(argv[n][2])
					{
						case 'c': case 'C': 
							skipc = 1; break;
						case 'l': case 'L': 
							skipl = 1; break;
						case 'm': case 'M': 
							skipm = 1; break;
						case 'n': case 'N': 
							skipn = 1; break;
						case 'o': case 'O': 
							skipo = 1; break;
						case 'v': case 'V': 
							skipv = 1; break;
						default: syntax(AV0, argv[n]);
					}
					break;
				default:
					syntax(AV0, argv[n]);
					break;
			}

		}
		else if (!infile)
		{
			infile = argv[n];
		}
	}
	if (!infile)
	{
		fprintf(stderr, "%s: No input filename provided.\n", AV0);
		return 1;
	}
	fp = fopen(infile, "rb");
	if (!fp)
	{
		perror(infile);
		exit(1);
	}
	if (fread(header, 1, sizeof(header), fp) < sizeof(header) ||
	    memcmp(header, "BEMSNAP1", 8))
	{
		fprintf(stderr, "%s: File is not in BeebEm snapshot format\n",
			infile);
		fclose(fp);
		exit(1);
	}
	if (fread(beebmem, 1, sizeof(beebmem), fp) < sizeof(beebmem))
	{
		fprintf(stderr, "%s: Unexpected end of file\n", infile);
		fclose(fp);
		exit(1);
	}
	fclose(fp);
	/* Start by looking for the signature where it is in the examples 
	 * I've been given */
	if (signature_at(0x349A))
	{
		base = 0x3500;
	}
	/* According to the manual the database is always at 0x3500 (cassette
 	 * versions) or 0x2500 (disk versions). Hope that the disk versions
  	 * have the same signature at 0x249A in that case. */
	else if (signature_at(0x249A))
	{
		base = 0x2500;
	}
	else for (n = 0; n < 0x7FF0; n++)
	{
		if (signature_at(n))
		{
			base = n + 0x67;
			break;
		}
	}
	if (!base)
	{
		fprintf(stderr, "%s: Quill signature not found in file\n", infile);
		exit(1);
	}
	dump_game();
	return 0;
}


