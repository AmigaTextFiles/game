// A SAS-C example with Cxx (SAS/C++)
// It uses the X-System, wich is a collection of classes for use with
// the Amiga. If you are interrested the classes, feel free to mail me:
// steffen.mars@stenloese.mail.telia.com
// Note that this will not compile if you don't have the X-System
// Thanks to Allan TNT

#include <CXX:Protos/FileSysX.cxx>
#include <CXX:Protos/StringX.cxx>
#include <CXX:Protos/DisplayX.cxx>
#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/asl.h>

char*	version="$VER:SlamtiltJudge v1.4 (© The Hanged Man)";
char*	title=(version+5);

class	HighScore
{
	private:
	unsigned char	Score[6];
	unsigned char	Initials[3];
	
	public:
	HighScore();
	HighScore(HighScore& hs2);
	~HighScore(){}
	void	Clear();
	void	Peek(void* addr);
	void	Poke(void* addr);
	void	Swap(HighScore& hs2);
	int		operator== (HighScore& hs2);
	int		operator<  (HighScore& hs2);
};
HighScore::HighScore()
{
	Clear();
}
HighScore::HighScore(HighScore& hs2)
{
	int i;
	for (i=0; i<6; i++) Score[i]=hs2.Score[i];
	for (i=0; i<3; i++) Initials[i]=hs2.Initials[i];
}
void HighScore::Clear()
{
	int i;
	for (i=0; i<6; i++) Score[i]=0;
	for (i=0; i<3; i++) Initials[i]=0;
}
void HighScore::Peek(void* addr)
{
	unsigned char*	cptr;
	int	i;
	
	cptr = (unsigned char*)addr;
	for (i=0; i<6; i++, cptr++) Score[i]=*cptr;
	for (i=0; i<3; i++, cptr++) Initials[i]=*cptr;
}
void HighScore::Poke(void* addr)
{
	unsigned char*	cptr;
	int	i;
	
	cptr = (unsigned char*)addr;
	for (i=0; i<6; i++, cptr++) *cptr=Score[i];
	for (i=0; i<3; i++, cptr++) *cptr=Initials[i];
}
void HighScore::Swap(HighScore& hs2)
{
	unsigned char	chr;
	int i;
	
	for (i=0; i<6; i++)
	{
		chr=Score[i];
		Score[i] = hs2.Score[i];
		hs2.Score[i] = chr;
	}
	for (i=0; i<3; i++)
	{
		chr=Initials[i];
		Initials[i] = hs2.Initials[i];
		hs2.Initials[i] = chr;
	}
}
int	HighScore::operator== (HighScore& hs2)
{
	int i;
	for (i=0; i<6; i++) if (Score[i] != hs2.Score[i]) return 0;
	for (i=0; i<3; i++) if (Initials[i] != hs2.Initials[i]) return 0;
	return 1;
}
int	HighScore::operator< (HighScore& hs2)
{
	int i;
	
	for (i=0; i<6; i++)
	{
		if (Score[i] < hs2.Score[i]) return 1;
		if (Score[i] > hs2.Score[i]) return 0;
	}
	return 0;
}

int	Judge(char* name1, char* name2, int offset)
{
	FileX 		fil1,fil2;	// FileX is used for file manipulation
	HighScore	score[10];	// Array of 10 highscore objects
	void*		mem_array;	// For use with AllocMem()
	int			i,j;		// General purpose counters
	
	// Check if the needed files exists via DosX class
	if (!DosX::Exists(name1)) return 1;
	if (!DosX::Exists(name2)) return 1;

	// Use exec to allocate 16 bytes(nice round number) memory area
	mem_array = ::AllocMem(16,0);

	// Load the two files into two FileX objects
	fil1.Load(name1);
	fil2.Load(name2);

	// Copy a part of the file used for highscore information to mem
	// Then give the HighScore objects the information
	for (i=0; i<5; i++)
	{
		fil1.Read(mem_array,offset+i*14,14);
		score[i].Peek(mem_array);
		fil2.Read(mem_array,offset+i*14,14);
		score[i+5].Peek(mem_array);
	}

	// Remove duplicates
	for (i=0; i<9; i++) for (j=i+1; j<10; j++)
	{
		if (score[i]==score[j]) {score[i].Clear(); break;}
	}

	// Do the good ol' bubble sort
	for (i=0; i<10; i++) for (j=0; j<10; j++)
		if (score[j]<score[i]) score[j].Swap(score[i]);

	// 'Poke' the 5 best highscores to a mem-block
	// and write the memblock to FileX
	for (i=0; i<5; i++)
	{
		score[i].Poke(mem_array);
		fil2.Write(mem_array,offset+i*14,14);
	}

	// Save the file
	fil2.Save(name2);
	::FreeMem(mem_array,16);
	return 0;
}

int main(int argc, char** argv)
{
	StringX		path1,path2,file1,file2;
	char		path[256];
	WinX		window(title,0,0,32,32);
	window.SizeText(29,8);
	UWORD		moenster[]={0x5555,0xAAAA};
	BPTR		lock;
	int			x;

	::SetProgramName("SlamtiltJudge");

	window.Pattern(moenster,1);
	window.GraphicsPenA(2);
	window.GraphicsPenB(-1);
	
	lock = ::Lock("",ACCESS_READ);
	::NameFromLock(lock,path,255);
	path2 = path;
	path2 += "/";
	::UnLock(lock);

	window.WaitIDCMP(IDCMP_NEWSIZE|IDCMP_CHANGEWINDOW);
	if (argc < 2)
	{
		window.Rectangle(0,0,16384,16384);
		window.Print("Where",1);
		window.Print("is",2);
		window.Print("highscores",3);
		window.Print("?",4);
		TagItem	tags[]=
		{
			ASLFR_TitleText,(ULONG)"Where's new highscores ?",
			ASLFR_InitialDrawer,(ULONG)"RAM:",
			TAG_END,0
		};
		do
		{
			if (window.ReqDrawer(path,255,tags))
			{
				window.Rectangle(0,0,320,80);
				window.Print("ABORTED",3);
				window.WaitClose();
				return 5;
			}
			path1 = path;
			for (x=0;path[x]!=0;x++);
			x--;
			if (path[x] != ':') path1 += "/";
		}while (path1 == path2);
	}
	else path1 = argv[1];
	if (argc >2) path2 = argv[2];

	window.Rectangle(0,0,320,80);
	
	file1 = path1+"Demon.dat";
	file2 = path2+"Demon.dat";
	window.Print("Night of The Demon",1,1);
	if (Judge(file1.Pointer(),file2.Pointer(),0x76))
		window.Print("FAIL",22,1);
	else
		window.Print("OK",22,1);

	file1 = path1+"Pirate.dat";
	file2 = path2+"Pirate.dat";
	window.Print("The Pirate",1,2);
	if (Judge(file1.Pointer(),file2.Pointer(),0x94))
		window.Print("FAIL",22,2);
	else
		window.Print("OK",22,2);

	file1 = path1+"Mean.dat";
	file2 = path2+"Mean.dat";
	window.Print("Mean Machines",1,3);
	if (Judge(file1.Pointer(),file2.Pointer(),0x90))
		window.Print("FAIL",22,3);
	else
		window.Print("OK",22,3);

	file1 = path1+"Space.dat";
	file2 = path2+"Space.dat";
	window.Print("Ace of Space",1,4);
	if (Judge(file1.Pointer(),file2.Pointer(),0x90))
		window.Print("FAIL",22,4);
	else
		window.Print("OK",22,4);

	window.WaitClose();
	return 0;
}
