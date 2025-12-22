/*
 *  This file is part of Dune Legacy.
 *
 *  Dune Legacy is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  Dune Legacy is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Dune Legacy.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <FileClasses/Pakfile.h>

#include <Definitions.h>

#include <stdlib.h>
#include <string>
#include <SDL_endian.h>
#include <SDL.h>

///	Constructor for Pakfile
/**
	The PAK-File to be read/write is specified by the Pakfilename-parameter. If write==false the file is opened for
	read-only and is closed in the destructor. If write==true the file is opened write-only and written out in the
	destructor.
	\param Pakfilename	Filename of the *.pak-File.
	\param write		Specified if the PAK-File is opened for reading or writing (default is false).
*/
Pakfile::Pakfile(std::string Pakfilename, bool write)
{
	this->write = write;
	FileEntry = NULL;
	NumFileEntry = 0;
	WriteOutData = NULL;
	NumWriteOutData = 0;

	Filename = Pakfilename;

	if(write == false) {
		// Open for reading
		if( (fPakFile = SDL_RWFromFile(Filename.c_str(), "rb")) == NULL) {
			fprintf(stderr,"Pakfile::Pakfile(): Cannot open %s!\n",Pakfilename.c_str());
			exit(EXIT_FAILURE);
		}

		ReadIndex();
	} else {
		// Open for writing
		if( (fPakFile = SDL_RWFromFile(Filename.c_str(), "wb")) == NULL) {
			fprintf(stderr,"Pakfile::Pakfile(): Cannot open %s!\n",Pakfilename.c_str());
			exit(EXIT_FAILURE);
		}
	}
}

/// Destructor
/**
	Closes the filehandle and releases all memory.
*/
Pakfile::~Pakfile()
{
	if(write == true) {
		// calculate header size
		int headersize = 0;
		for(unsigned int i = 0; i < NumFileEntry; i++) {
			headersize += 4;
			headersize += strlen(FileEntry[i].Filename) + 1;
		}
		headersize += 4;

		// write out header
		for(unsigned int i = 0; i < NumFileEntry; i++) {
			#if SDL_BYTEORDER == SDL_BIG_ENDIAN
			Uint32 startoffset = SDL_Swap32(FileEntry[i].StartOffset + headersize);
			#else
			Uint32 startoffset = FileEntry[i].StartOffset + headersize;
			#endif
			SDL_RWwrite(fPakFile,(char*) &startoffset,sizeof(Uint32),1);
			SDL_RWwrite(fPakFile,FileEntry[i].Filename,strlen(FileEntry[i].Filename) + 1,1);
		}
		Uint32 tmp = 0;
		SDL_RWwrite(fPakFile,(char*) &tmp, sizeof(Uint32), 1);

		// write out data
		SDL_RWwrite(fPakFile,WriteOutData,NumWriteOutData,1);
	}

	if(fPakFile != NULL) {
		SDL_RWclose(fPakFile);
	}

	if(WriteOutData != NULL) {
		free(WriteOutData);
		WriteOutData = NULL;
		NumWriteOutData = 0;
	}

	for(unsigned int i=0;i<NumFileEntry;i++) {
		free(FileEntry[i].Filename);
	}

	free(FileEntry);
}

/// Returns the name of the nth file in this pak-File.
/**
	Returns the name of the nth file in this pak-File. index specifies which file.
	\param	index	Index in pak-File
	\return	name of the file specified by index
*/
std::string Pakfile::GetFilename(unsigned int index) {
	if(index >= NumFileEntry)
		return "";

	return FileEntry[index].Filename;
}

/// Adds a file to this PAK-File
/**
	This methods adds the SDL_RWop File to this PAK-File. The used name is specified by filename. If the Pakfile
	is read-only this method has no effect.
	\param	rwop		Data to add (the SDL_RWop can be read-only but must support seeking)
	\param	filename	This is the filename the data is added with
*/
void Pakfile::AddFile(SDL_RWops* rwop, std::string filename) {
	if(write == false)
		return;

	if(rwop == NULL) {
		fprintf(stderr,"Pakfile::AddFile(): rwop==NULL is not allowed!\n");
		exit(EXIT_FAILURE);
	}


	int filelength = SDL_RWseek(rwop,0,SEEK_END);
	SDL_RWseek(rwop,0,SEEK_SET);

	if((WriteOutData = (char*) realloc(WriteOutData,NumWriteOutData+filelength)) == NULL) {
		perror("realloc()");
		exit(EXIT_FAILURE);
	}

	if(SDL_RWread(rwop,WriteOutData + NumWriteOutData,1,filelength) != filelength) {
		fprintf(stderr,"Pakfile::AddFile(): SDL_RWread failed!\n");
		exit(EXIT_FAILURE);
	}

	if((FileEntry = (PakFileEntry*) realloc(FileEntry,(NumFileEntry+1) * sizeof(PakFileEntry))) == NULL) {
		perror("realloc()");
		exit(EXIT_FAILURE);
	}

	FileEntry[NumFileEntry].StartOffset = NumWriteOutData;
	FileEntry[NumFileEntry].EndOffset = NumWriteOutData + filelength - 1;
	if((FileEntry[NumFileEntry].Filename = (char *) malloc(filename.length() + 1)) == NULL) {
		perror("malloc()");
		exit(EXIT_FAILURE);
	}
	strcpy(FileEntry[NumFileEntry].Filename,filename.c_str());

	NumWriteOutData += filelength;

	NumFileEntry++;
	SDL_RWseek(rwop,0,SEEK_SET);
}

/// Opens a file in this PAK-File.
/**
	This method opens the file specified by filename. It is only allowed if the Pakfile is opened for reading.
	The returned SDL_RWops-structure can be used readonly with SDL_RWread, SDL_RWseek and SDL_RWclose. No writing
	is supported. If the Pakfile is opened for writing this	method returns NULL.<br>
	NOTICE: The returned SDL_RWops-Structure is only valid as long as this Pakfile-Object exists. It gets
	invalid as soon as Pakfile:~Pakfile() is executed.
	\param	filename	The name of this file
	\return	SDL_RWops for this file
*/
SDL_RWops* Pakfile::OpenFile(std::string filename) {

	if(write == true) {
		// reading files is not allowed
		return NULL;
	}


	// find file
	int Index = -1;
	for(unsigned int i=0;i<NumFileEntry;i++) {
		if(filename == FileEntry[i].Filename) {
			Index = i;
			break;
		}
	}


	if(Index == -1) {
		return NULL;
	}

	// alloc RWop
	SDL_RWops *pRWop;
	if((pRWop = SDL_AllocRW()) == NULL) {
		return NULL;
	}

        
	// alloc RWopData
	RWopData* pRWopData;
	if((pRWopData = new RWopData) == NULL) {
		SDL_FreeRW(pRWop);
		return NULL;
	}

	pRWop->type = PAKFILE_RWOP_TYPE;
	pRWopData->curPakfile = this;
	pRWopData->FileOffset = 0;
	pRWopData->FileIndex = Index;

	pRWop->read = pRWop->read2 = Pakfile::ReadFile;
	pRWop->write = pRWop->write2 = Pakfile::WriteFile;
	pRWop->seek = pRWop->seek2 = Pakfile::SeekFile;
	pRWop->close = pRWop->close2 = Pakfile::CloseFile;
	pRWop->hidden.unknown.data1 = (void*) pRWopData;


	return pRWop;
}


int Pakfile::ReadFile(SDL_RWops* pRWop, void *ptr, int size, int n) {
	if((pRWop == NULL) || (ptr == NULL) || (pRWop->hidden.unknown.data1 == NULL)
		|| (pRWop->type != PAKFILE_RWOP_TYPE)) {
			return -1;
	}

	int bytes2read = size*n;

	RWopData * pRWopData = (RWopData*) pRWop->hidden.unknown.data1;
	Pakfile * pPakfile = pRWopData->curPakfile;
	if(pPakfile == NULL) {
		return -1;
	}

	if(pRWopData->FileIndex >= pPakfile->NumFileEntry) {
		return -1;
	}

	int readstartoffset = pPakfile->FileEntry[pRWopData->FileIndex].StartOffset + pRWopData->FileOffset;

	if(readstartoffset > pPakfile->FileEntry[pRWopData->FileIndex].EndOffset) {
		return -1;
	}

	if(readstartoffset + bytes2read > pPakfile->FileEntry[pRWopData->FileIndex].EndOffset) {
		bytes2read = pPakfile->FileEntry[pRWopData->FileIndex].EndOffset + 1 - readstartoffset;
		// round to last full block
		bytes2read /= size;
		bytes2read *= size;
		if(bytes2read == 0) {
			return 0;
		}
	}

	if(SDL_RWseek(pPakfile->fPakFile,readstartoffset,SEEK_SET) < 0) {
		return -1;
	}

	if(SDL_RWread(pPakfile->fPakFile,ptr,bytes2read,1) != 1) {
		return -1;
	}

	pRWopData->FileOffset += bytes2read;
	return bytes2read/size;
}

int Pakfile::WriteFile(SDL_RWops *pRWop, const void *ptr, int size, int n) {
	return -1;
}

int Pakfile::SeekFile(SDL_RWops *pRWop, int offset, int whence) {
	if((pRWop == NULL) || (pRWop->hidden.unknown.data1 == NULL)
		|| (pRWop->type != PAKFILE_RWOP_TYPE)) {
		return -1;
	}

	RWopData * pRWopData = (RWopData*) pRWop->hidden.unknown.data1;
	Pakfile * pPakfile = pRWopData->curPakfile;
	if(pPakfile == NULL) {
		return -1;
	}

	if(pRWopData->FileIndex >= pPakfile->NumFileEntry) {
		return -1;
	}

	int NewOffset;

	switch(whence) {
		case SEEK_SET:
		{
			NewOffset = offset;
		} break;

		case SEEK_CUR:
		{
			NewOffset = pRWopData->FileOffset + offset;
		} break;

		case SEEK_END:
		{
			NewOffset = pPakfile->FileEntry[pRWopData->FileIndex].EndOffset - pPakfile->FileEntry[pRWopData->FileIndex].StartOffset + 1 + offset;
		} break;

		default:
		{
			return -1;
		} break;
	}

	if((NewOffset < 0) || (NewOffset > (pPakfile->FileEntry[pRWopData->FileIndex].EndOffset + 1))) {
		return -1;
	}

	pRWopData->FileOffset = NewOffset;
	return NewOffset;
}

int Pakfile::CloseFile(SDL_RWops *pRWop) {
	if((pRWop == NULL) || (pRWop->hidden.unknown.data1 == NULL)
		|| (pRWop->type != PAKFILE_RWOP_TYPE)) {
		return -1;
	}

	RWopData* pRWopData = (RWopData*) pRWop->hidden.unknown.data1;
	delete pRWopData;
	pRWop->hidden.unknown.data1 = NULL;
	SDL_FreeRW(pRWop);
	return 0;
}

void Pakfile::ReadIndex()
{
	int i;
	int startoffset;
	char name[512];

	while(1) {
		if(SDL_RWread(fPakFile,(void*) &startoffset, 4, 1) != 1) {
			fprintf(stderr,"Pakfile::ReadIndex(): SDL_RWread() failed!\n");
			exit(EXIT_FAILURE);
		}

		//pak-files are always little endian encoded
		startoffset = SDL_SwapLE32(startoffset);


		if(startoffset == 0) {
			break;
		}

		if((FileEntry = (PakFileEntry*) realloc(FileEntry,(NumFileEntry+1) * sizeof(PakFileEntry))) == NULL) {
			perror("realloc()");
			exit(EXIT_FAILURE);
		}

		FileEntry[NumFileEntry].StartOffset = startoffset;

		i = 0;
		while(1) {
			if(SDL_RWread(fPakFile,&name[i],1,1) != 1) {
				fprintf(stderr,"Pakfile::ReadIndex(): SDL_RWread() failed!\n");
				exit(EXIT_FAILURE);
			}

			i++;

			if(name[i-1] == '\0') {
				break;
			}

			if(i >= 512) {
				fprintf(stderr,"Pakfile::readIndex(): Filename in Pakfile too long\n");
				exit(EXIT_FAILURE);
			}
		}

		if((FileEntry[NumFileEntry].Filename = (char *) malloc(i)) == NULL) {
				perror("malloc()");
				exit(EXIT_FAILURE);
		}

		strcpy(FileEntry[NumFileEntry].Filename,name);

		if(NumFileEntry > 0) {
			FileEntry[NumFileEntry - 1].EndOffset = startoffset - 1;
		}

		NumFileEntry++;
	}

	if((FileEntry[NumFileEntry-1].EndOffset = (SDL_RWseek(fPakFile,0,SEEK_END) - 1)) < 0) {
		fprintf(stderr,"Pakfile::ReadIndex(): SDL_RWseek() failed!\n");
		exit(EXIT_FAILURE);
	}
}
