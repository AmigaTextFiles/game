// Minimal dll example

#include "dll.h"
#include <iostream.h>
#include <stdio.h>
#include "server.h"

class Client
{
public:
	Client()
	{
		printf("Client constructor\n");         //Using cout in global constructors is not possible with
		                                        //PPC iostream at the moment :(
//		cout << "Client constructor" << endl;
	};

	~Client()
	{
		cout << "Client destructor" << endl;
	};
};


Client testclient;

__saveds Server::Server()
{
	cout << "Server constructor" << endl;
}

__saveds Server::~Server()
{
	cout << "Server destructor" << endl;
}

__saveds int Server::Test(int a, int b)
{
	return a+b;
}



Server * __saveds CreateServer()
{
	return new Server;
};

void * __saveds FindResource(int a,char *b)
{
	return 0L;
}

void * __saveds LoadResource(void *a)
{
	return 0L;
}

void __saveds FreeResource(void *a)
{
}

dll_tExportSymbol DLL_ExportSymbols[]=
{
	{FindResource,"dllFindResource"},
	{LoadResource,"dllLoadResource"},
	{FreeResource,"dllFreeResource"},
	{CreateServer,"CreateServer"},
	{0,0}
};

dll_tImportSymbol DLL_ImportSymbols[]=
{
	{0,0,0,0}
};

int __saveds DLL_Init(void)
{
	return 1L;
}

void __saveds DLL_DeInit(void)
{
}
