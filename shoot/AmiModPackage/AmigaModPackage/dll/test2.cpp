#include "dll.h"
#include <iostream.h>
#include "server.h"

Server *server;

int main()
{
	void *hinst;
	Server *(*CreateServer)();


	hinst = dllLoadLibrary("server.dll", 0);

	CreateServer = (Server * (*)()) dllGetProcAddress(hinst, "CreateServer");

	server = CreateServer();

	cout << "2 + 3 = " << server->Test(2, 3) << endl;

	delete server;

	dllFreeLibrary(hinst);
}
