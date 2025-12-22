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

#include "osxbt.h"


BTConnection::BTConnection(IOBluetoothSDPUUIDRef uuid, CFStringRef name, CFStringRef desc) {
	bufferPos = 0;
	serviceUuid = uuid;
	serviceName = name;
	serviceDescription = desc;
	device = NULL;
	channel = NULL;
	recordHandle = 0;
	notification = NULL;
	opened = false;
	closed = false;
	err = false;
	if (serviceUuid)
		IOBluetoothObjectRetain(serviceUuid);
	if (serviceName)
		CFRetain(serviceName);
	if (serviceDescription)
		CFRetain(serviceDescription);
	client = false;
}

/*
 * Note, if the channel opening is aborted (by the destructor)
 * when the opening actually has started but isn't complete
 * (the example which is easy to replicate is when connecting
 * to a series 60 phone, where the user hasn't accepted the
 * connection yet) - the channel isn't actually released
 * (it is probably retained by some other object somewhere?)
 * but is still alive. Therefore, we will explicitly close it again
 * if it happens to be opened.
 */
void closedChannelEvent(IOBluetoothRFCOMMChannelRef channel, void* ref, IOBluetoothRFCOMMChannelEvent* event) {
	/*
	 * We only close it, but don't release it
	 * since it has already been released by the
	 * destructor. No matter what event is received,
	 * just try to close it, since this channel has
	 * been abandoned.
	 */
	IOBluetoothRFCOMMChannelCloseChannel(channel);
}

BTConnection::~BTConnection() {
	if (serviceUuid) IOBluetoothObjectRelease(serviceUuid);
	if (serviceName) CFRelease(serviceName);
	if (serviceDescription) CFRelease(serviceDescription);
	if (recordHandle) {
		IOBluetoothRemoveServiceWithRecordHandle(recordHandle);
	}
	if (notification) {
		IOBluetoothUserNotificationUnregister(notification);
	}
	if (channel) {
		IOBluetoothRFCOMMChannelRegisterIncomingEventListener(channel, closedChannelEvent, NULL);
		IOBluetoothRFCOMMChannelCloseChannel(channel);
		IOBluetoothObjectRelease(channel);
	}
	if (device) {
		IOBluetoothDeviceCloseConnection(device);
		IOBluetoothObjectRelease(device);
	}
}

bool BTConnection::isClient() {
	return client;
}

int BTConnection::ready(const char **errString) {
	sendEvents();
	if (err) {
		*errString = errorBuffer;
		return -1;
	}
	if (closed) {
		if (opened)
			*errString = "Connection closed";
		else
			*errString = "Connection refused";
		return -1;
	}
	if (opened) {
		return 1;
	}
	return 0;
}

bool BTConnection::read(const char **errString) {
	if (cb && bufferPos > 0) {
		cb->received(initialBuffer, bufferPos);
		bufferPos = 0;
	}
	sendEvents();
	return true;
}

void BTConnection::sendEvents() {
	while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) == kCFRunLoopRunHandledSource);
}

bool BTConnection::write(const unsigned char *ptr, int n, const char **errString) {
	int mtu = IOBluetoothRFCOMMChannelGetMTU(channel);
	while (n > 0) {
		int min = n;
		if (mtu < min)
			min = mtu;
		IOReturn ret = IOBluetoothRFCOMMChannelWriteSync(channel, (void*) ptr, min);
		if (ret != kIOReturnSuccess) {
			err = true;
			sprintf(errorBuffer, "Send error %d", ret);
			*errString = errorBuffer;
			return false;
		}
		ptr += min;
		n -= min;
	}

	return true;
}

void BTConnection::received(const unsigned char *ptr, int n) {
	if (cb) {
		if (bufferPos > 0) {
			cb->received(initialBuffer, bufferPos);
			bufferPos = 0;
		}
		cb->received(ptr, n);
	} else {
		int bufferSize = sizeof(initialBuffer)/sizeof(initialBuffer[0]);
		if (n + bufferPos > bufferSize)
			n = bufferSize - bufferPos;
		memcpy(initialBuffer + bufferPos, ptr, n);
		bufferPos += n;
	}
}

bool BTConnection::connect(IOBluetoothDeviceRef dev, const char **errString, bool query) {
	client = true;
	device = dev;
	IOBluetoothObjectRetain(device);
	if (query) {
		IOBluetoothDevicePerformSDPQuery(device, sdpQueryDone, this);
		return true;
	} else {
		sdpQueryDone(this, device, kIOReturnSuccess);
		if (err) {
			*errString = errorBuffer;
			return false;
		}
		return true;
	}
}

void BTConnection::sdpQueryDone(void *ref, IOBluetoothDeviceRef dev, IOReturn status) {
	BTConnection* conn = (BTConnection*) ref;
	if (status != kIOReturnSuccess) {
		sprintf(conn->errorBuffer, "SDP query failed");
		conn->err = true;
		return;
	}
	IOBluetoothSDPServiceRecordRef record = IOBluetoothDeviceGetServiceRecordForUUID(dev, conn->serviceUuid);
	if (!record) {
		sprintf(conn->errorBuffer, "Service not found");
		conn->err = true;
		return;
	}

	BluetoothRFCOMMChannelID channelID;
	if (IOBluetoothSDPServiceRecordGetRFCOMMChannelID(record, &channelID) != kIOReturnSuccess) {
		sprintf(conn->errorBuffer, "RFCOMM channel not found");
		conn->err = true;
		return;
	}

	if (IOBluetoothDeviceOpenRFCOMMChannelAsync(dev, &conn->channel, channelID, channelEvent, conn) != kIOReturnSuccess) {
		sprintf(conn->errorBuffer, "Unable to open RFCOMM channel");
		conn->err = true;
		return;
	}

//	IOBluetoothObjectRetain(channel); // according to ...OpenRFCOMMChannelAsync, we must release channel after this, thus we don't have to retain it
}

void BTConnection::accept() {
	client = false;
	CFURLRef url = CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("SDPRecord"), CFSTR("plist"), NULL);
	CFDataRef data;
	SInt32 err;
	CFURLCreateDataAndPropertiesFromResource(kCFAllocatorDefault, url, &data, NULL, NULL, &err);
	CFStringRef errString;
	CFPropertyListRef plist = CFPropertyListCreateFromXMLData(kCFAllocatorDefault, data, kCFPropertyListImmutable, &errString);
	CFRelease(data);
	CFRelease(url);

	CFMutableDictionaryRef dictionary = CFDictionaryCreateMutableCopy(kCFAllocatorDefault, 0, (CFDictionaryRef) plist);
	CFRelease(plist);

	CFArrayRef serviceClass = CFArrayCreate(kCFAllocatorDefault, (const void**) &serviceUuid, 1, NULL);
	CFDictionarySetValue(dictionary, CFSTR("0001 - ServiceClassIDList"), serviceClass);

	if (serviceName)
		CFDictionaryAddValue(dictionary, CFSTR("0100 - ServiceName"), serviceName);
	if (serviceDescription)
		CFDictionaryAddValue(dictionary, CFSTR("0101 - ServiceDescription"), serviceDescription);

	IOBluetoothSDPServiceRecordRef record;
	IOBluetoothAddServiceDict(dictionary, &record);

	BluetoothRFCOMMChannelID channelID = 0;
	IOBluetoothSDPServiceRecordGetRFCOMMChannelID(record, &channelID);
	IOBluetoothSDPServiceRecordGetServiceRecordHandle(record, &recordHandle);
	IOBluetoothObjectRelease(record);

	CFRelease(serviceClass);
	CFRelease(dictionary);

	notification = IOBluetoothRegisterForFilteredRFCOMMChannelOpenNotifications(userNotification, this, channelID, kIOBluetoothUserNotificationChannelDirectionIncoming);
}

void BTConnection::channelEvent(IOBluetoothRFCOMMChannelRef channel, void* ref, IOBluetoothRFCOMMChannelEvent* event) {
	BTConnection* conn = (BTConnection*) ref;
	switch (event->eventType) {
	case kIOBluetoothRFCOMMChannelEventTypeData:
		conn->received((const unsigned char*) event->u.newData.dataPtr, event->u.newData.dataSize);
		break;

	case kIOBluetoothRFCOMMChannelEventTypeClosed:
		conn->closed = true;
		break;

	case kIOBluetoothRFCOMMChannelEventTypeOpenComplete:
		if (event->status == kIOReturnSuccess) {
			conn->opened = true;
		} else {
			sprintf(conn->errorBuffer, "Connection refused");
			conn->err = true;
		}
		break;

	default:
		break;
	}
}

void BTConnection::userNotification(void* ref, IOBluetoothUserNotificationRef inRef, IOBluetoothObjectRef objectRef) {
	BTConnection* conn = (BTConnection*) ref;

	IOBluetoothRemoveServiceWithRecordHandle(conn->recordHandle);
	conn->recordHandle = 0;

	IOBluetoothUserNotificationUnregister(conn->notification);
	conn->notification = NULL;

	conn->channel = objectRef;
	CFRetain(conn->channel);

	IOBluetoothRFCOMMChannelRegisterIncomingEventListener(conn->channel, channelEvent, conn);
}


BTConnection* BTConnection::startConnect(const char *addr, unsigned int uuid32, const char **errString, bool query) {
	BluetoothDeviceAddress addrStruct;
	sscanf(addr, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &addrStruct.data[0], &addrStruct.data[1], &addrStruct.data[2], &addrStruct.data[3], &addrStruct.data[4], &addrStruct.data[5]);
	IOBluetoothDeviceRef device = IOBluetoothDeviceCreateWithAddress(&addrStruct);
	return startConnect(device, uuid32, errString, query);
}

BTConnection* BTConnection::startConnect(IOBluetoothDeviceRef device, unsigned int uuid32, const char **errString, bool query) {
	IOBluetoothSDPUUIDRef uuid = IOBluetoothSDPUUIDCreateUUID32(uuid32);
	BTConnection* conn = new BTConnection(uuid, NULL, NULL);
	if (conn->connect(device, errString, query))
		return conn;
	delete conn;
	return NULL;
}

BTConnection* BTConnection::startAccept(unsigned int uuid32, const char *name, const char **errString) {
	*errString = NULL;
	IOBluetoothSDPUUIDRef uuid = IOBluetoothSDPUUIDCreateUUID32(uuid32);
	CFStringRef cfname = NULL;
	if (name)
		cfname = CFStringCreateWithCString(kCFAllocatorDefault, name, kCFStringEncodingASCII);
	BTConnection* conn = new BTConnection(uuid, cfname, NULL);
	conn->accept();
	return conn;
}


