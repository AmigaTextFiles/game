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

#ifndef __OSXBT_H
#define __OSXBT_H

#include "connection.h"
#include <CoreFoundation/CoreFoundation.h>
#include <IOBluetooth/IOBluetoothUserLib.h>

class BTConnection : public Connection {
public:
	bool isClient();
	int ready(const char **errString);
	bool read(const char **errString);
	bool write(const unsigned char *ptr, int n, const char **errString);

	void received(const unsigned char *ptr, int n);
	BTConnection(IOBluetoothSDPUUIDRef uuid, CFStringRef name = NULL, CFStringRef desc = NULL);
	~BTConnection();

	bool connect(IOBluetoothDeviceRef device, const char **errString, bool query = false);
	void accept();

	static BTConnection* startConnect(const char *address, unsigned int uuid32, const char **errString, bool query = true);
	static BTConnection* startConnect(IOBluetoothDeviceRef device, unsigned int uuid32, const char **errString, bool query = false);
	static BTConnection* startAccept(unsigned int uuid32, const char *name, const char **errString);

private:

	unsigned char initialBuffer[1024];
	int bufferPos;

	bool client;
	bool err;
	char errorBuffer[1000];
	bool closed;
	bool opened;

	IOBluetoothDeviceRef device;
	CFStringRef serviceName;
	CFStringRef serviceDescription;
	IOBluetoothSDPUUIDRef serviceUuid;
	IOBluetoothRFCOMMChannelRef channel;
	BluetoothSDPServiceRecordHandle recordHandle;
	IOBluetoothUserNotificationRef notification;

	static void sdpQueryDone(void *ref, IOBluetoothDeviceRef dev, IOReturn status);
	static void channelEvent(IOBluetoothRFCOMMChannelRef channel, void* ref, IOBluetoothRFCOMMChannelEvent* event);
	static void userNotification(void *ref, IOBluetoothUserNotificationRef inRef, IOBluetoothObjectRef objectRef);

	void sendEvents();

};


#endif
