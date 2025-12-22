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

#ifndef __BLUEZ_H
#define __BLUEZ_H

#include "socketconn.h"
#include <bluetooth/bluetooth.h>

#include <vector>

using std::vector;

class BTConnection : public SocketConnection {
public:
	~BTConnection();

	static BTConnection *startConnect(bdaddr_t addr, unsigned int uuid, const char **errString);
	static BTConnection *startAccept(unsigned int uuid, const char *serviceName, const char **errString);
	int pollAccept(int msec, const char **errString);

	enum deviceType { COMPUTER, PHONE, OTHER };
	class Device {
	public:
		deviceType type;
		const char *name;
		bdaddr_t addr;
	};
	static bool available();
	static bool getCachedDevices(vector<Device>& devices, const char** errString);
	static bool getDevices(vector<Device>& devices, const char** errString);

private:
	BTConnection(SOCKTYPE s);

	bool stopAdvertising(const char **errString);

	bool advertising;
	uint32_t recordHandle;

	static void iterateAccessProtos(void* value, void* userdata);
	static void iterateServiceDesc(void* value, void* userdata);
};

#endif
