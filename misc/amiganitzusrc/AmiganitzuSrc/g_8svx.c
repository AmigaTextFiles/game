// g_8svx.c
#include <stdio.h>
#include <stdlib.h>
#include <exec/exec.h>
#include <exec/types.h>
#include <clib/exec_protos.h>

#include "g_8svx.h"



int load_sample(char *fname, struct sample_struct *s)
{
	ULONG chunk_size, file_size;
	int i;
	FILE *file = NULL;
	char form[4];
	int done = 0, chunk_unknown = 1;
	struct VHDR_struct VHDR;

	file = fopen(fname, "rb");
	if(!file) {
		printf("could not open file %s\n", fname);
		return 0;
	}
	// read in form
	for(i = 0; i < 4; i++) form[i] = fgetc(file);
	
	if(!(form[0] == 'F' && form[1] == 'O' && form[2] == 'R' && form[3] == 'M')) {
		printf("FORM not found, quitting\n");
		fclose(file);
	}
	// read file size
	fread(&file_size, sizeof(file_size), 1, file);
	//printf("file size is %u\n", file_size);
	// read the file type
	for(i = 0; i < 4; i++) form[i] = fgetc(file);
	
	if(!(form[0] == '8' && form[1] == 'S' && form[2] == 'V' && form[3] == 'X')) {
		printf("not 8SVX file type, quitting\n");
		fclose(file);
	}

	// read through all the chunks
	while(!done) {
		// read the ID
		for(i = 0; i < 4; i++) form[i] = fgetc(file);
		if(form[0] == 'V' && form[1] == 'H' && form[2] == 'D' && form[3] == 'R') {
			// read the chunk size
			fread(&chunk_size, sizeof(chunk_size), 1, file);
			//printf("VHDR size %u\n", chunk_size);
			// read chunk
			fread(&VHDR, sizeof(struct VHDR_struct), 1, file);
			/*
			if(VHDR.sCompression != 0) printf("compressed\n");
			else printf("not compressed\n");
			printf("ctOctave is %u\n", VHDR.ctOctave);
			printf("oneShotHiSamples is %u\n", VHDR.oneShotHiSamples);
			printf("repeatHiSamples is %u\n", VHDR.repeatHiSamples);
			printf("samplesPerHiCycle is %u\n", VHDR.samplesPerHiCycle);
			printf("sample rate is %u\n", VHDR.samplesPerSec);
			*/
			s->sample_rate = VHDR.samplesPerSec;
			chunk_unknown = 0;
		}
		if(form[0] == 'B' && form[1] == 'O' && form[2] == 'D' && form[3] == 'Y') {
			// read the chunk size
			fread(&chunk_size, sizeof(chunk_size), 1, file);
			//printf("BODY size %u\n", chunk_size);

			s->data_size = chunk_size;
			s->data = AllocMem(s->data_size, MEMF_CHIP|MEMF_PUBLIC);
			if(!s->data) {
				printf("could not allocate memory for wave form\n");
				fclose(file);
				return 0;
			}

			if(fread(s->data, s->data_size, 1, file) != 1) printf("error reading data\n");
			//else printf("data read\n");

			chunk_unknown = 0;
			done = 1;
		}
		if(chunk_unknown) {
			// read the chunk size
			fread(&chunk_size, sizeof(chunk_size), 1, file);
			//printf("chunk unknown, size %u\n", chunk_size);
			// skip chunk
			for(i = 0; i < chunk_size; i++) fgetc(file);
			//printf("read unknwon chunk\n");
			chunk_unknown = 0;
		}
		chunk_unknown = 1;
	}
	fclose(file);
	//printf("%s\n", fname);
	return 1;
}

void free_sample(struct sample_struct *s)
{
	if(s->data) FreeMem(s->data, s->data_size);
}
