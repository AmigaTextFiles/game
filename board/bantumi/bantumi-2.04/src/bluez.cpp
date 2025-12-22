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
/* Some parts are heavily based on hcitool and sdptool in BlueZ */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "bluez.h"
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>

#ifndef BLUETOOTH_DIR
#define BLUETOOTH_DIR "/var/lib/bluetooth"
#endif

BTConnection::BTConnection(SOCKTYPE s) : SocketConnection(s) {
	advertising = false;
}

BTConnection::~BTConnection() {
	if (advertising) {
		const char *err;
		stopAdvertising(&err);
	}
}

void BTConnection::iterateServiceDesc(void* value, void* userdata) {
	sdp_data_t* p = (sdp_data_t*) value;
	int proto = 0;
	int* channelptr = (int*) userdata;

	for (; p; p = p->next) {
		switch (p->dtd) {
		case SDP_UUID16:
		case SDP_UUID32:
		case SDP_UUID128:
			proto = sdp_uuid_to_proto(&p->val.uuid);
			break;
		case SDP_UINT8:
			if (proto == RFCOMM_UUID)
				*channelptr = p->val.uint8;
			break;
		default:
			break;
		}
	}
}

void BTConnection::iterateAccessProtos(void* value, void* userdata) {
	sdp_list_foreach((sdp_list_t*) value, iterateServiceDesc, userdata);
}

BTConnection *BTConnection::startConnect(bdaddr_t addr, unsigned int uuid, const char **errString) {
	*errString = NULL;

	bdaddr_t local;
	memset(&local, 0, sizeof(local)); // BDADDR_ANY

	sdp_session_t* session = sdp_connect(&local, &addr, SDP_RETRY_IF_BUSY);
	if (!session) {
		*errString = getSockError();
		return NULL;
	}

	uuid_t service_class;
	sdp_uuid32_create(&service_class, uuid);

	uint32_t range = 0x0000ffff;
	sdp_list_t* attrid, *search, *first;

	attrid = sdp_list_append(0, &range);
	search = sdp_list_append(0, &service_class);
	if (sdp_service_search_attr_req(session, search, SDP_ATTR_REQ_RANGE, attrid, &first)) {
		*errString = getSockError();
		sdp_close(session);
		return NULL;
	}

	sdp_list_free(attrid, 0);
	sdp_list_free(search, 0);

	sdp_list_t* seq = first, *next;
	int channel = -1;
	for (; seq; seq = next) {
		sdp_record_t* rec = (sdp_record_t*) seq->data;

		sdp_list_t* proto;
		if (sdp_get_access_protos(rec, &proto) == 0) {
			sdp_list_foreach(proto, iterateAccessProtos, &channel);
			sdp_list_foreach(proto, (sdp_list_func_t) sdp_list_free, 0);
			sdp_list_free(proto, 0);
		}

		next = seq->next;
		sdp_record_free(rec);
	}
	sdp_list_free(first, 0);

	sdp_close(session);

	if (channel < 0) {
		*errString = "Service not found";
		return NULL;
	}


	SOCKTYPE sock;
	if ((sock = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) == INVALID_SOCKET) {
		printf("socket\n");
		*errString = getSockError();
		return NULL;
	}

	if (SETNONBLOCK(sock, 1) == -1) {
		printf("setnonblock\n");
		*errString = getSockError();
		CLOSESOCK(sock);
		return NULL;
	}

	struct sockaddr_rc sa;
	memset(&sa, 0, sizeof(sa));
	sa.rc_family = AF_BLUETOOTH;
	sa.rc_bdaddr = addr;
	sa.rc_channel = channel;

	if (::connect(sock, (struct sockaddr*) &sa, sizeof(sa)) < 0) {
		int err = CUR_ERROR();
		if (err != EAGAIN && err != EINPROGRESS && err != 0) {
			*errString = getSockError();
			CLOSESOCK(sock);
			return NULL;
		}
	}

	BTConnection *conn = new BTConnection(sock);
	conn->connecting = true;

	return conn;
}

BTConnection *BTConnection::startAccept(unsigned int uuid, const char *serviceName, const char **errString) {
	SOCKTYPE sock;
	if ((sock = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) == INVALID_SOCKET) {
		*errString = getSockError();
		return NULL;
	}

	struct sockaddr_rc sa;
	memset(&sa, 0, sizeof(sa));
	sa.rc_family = AF_BLUETOOTH;
	memset(&sa.rc_bdaddr, 0, sizeof(sa.rc_bdaddr)); // BDADDR_ANY
	sa.rc_channel = 0;

	if (bind(sock, (struct sockaddr*) &sa, sizeof(sa)) < 0) {
		*errString = getSockError();
		CLOSESOCK(sock);
		return NULL;
	}

	if (listen(sock, 2) < 0) {
		*errString = getSockError();
		CLOSESOCK(sock);
		return NULL;
	}

	socklen_t len = sizeof(sa);
	if (getsockname(sock, (sockaddr*) &sa, &len) < 0) {
		*errString = getSockError();
		CLOSESOCK(sock);
		return NULL;
	}

	uuid_t service_class, browse_group, l2cap_uuid, rfcomm_uuid;
	sdp_uuid32_create(&service_class, uuid);
	sdp_uuid16_create(&browse_group, PUBLIC_BROWSE_GROUP);
	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
	sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);

	bdaddr_t anydevice;
	memset(&anydevice, 0, sizeof(anydevice));
	bdaddr_t local = { { 0, 0, 0, 0xff, 0xff, 0xff } };
	sdp_session_t* session = sdp_connect(&anydevice, &local, SDP_RETRY_IF_BUSY);
	if (!session) {
		*errString = getSockError();
		CLOSESOCK(sock);
		return NULL;
	}

	sdp_record_t *record = sdp_record_alloc();
	record->handle = 0;

	sdp_list_t* browse_group_list = sdp_list_append(NULL, &browse_group);
	sdp_set_browse_groups(record, browse_group_list);
	sdp_list_free(browse_group_list, 0);


	sdp_list_t* l2cap_list = sdp_list_append(NULL, &l2cap_uuid);

	uint8_t channel = sa.rc_channel;
	sdp_data_t* channelData = sdp_data_alloc(SDP_UINT8, &channel);
	
	sdp_list_t* rfcomm_list = sdp_list_append(sdp_list_append(NULL, &rfcomm_uuid), channelData);
	sdp_list_t* proto_list = sdp_list_append(sdp_list_append(NULL, l2cap_list), rfcomm_list);
	sdp_list_t* proto_list2 = sdp_list_append(NULL, proto_list);
	sdp_set_access_protos(record, proto_list2);
	sdp_list_free(proto_list2, 0);
	sdp_list_free(proto_list, 0);
	sdp_list_free(rfcomm_list, 0);
	sdp_data_free(channelData);
	sdp_list_free(l2cap_list, 0);

	sdp_list_t* service_list = sdp_list_append(NULL, &service_class);
	sdp_set_service_classes(record, service_list);
	sdp_list_free(service_list, 0);

	sdp_set_info_attr(record, serviceName, NULL, NULL);

	if (sdp_device_record_register(session, &anydevice, record, SDP_RECORD_PERSIST) < 0) {
		*errString = getSockError();
		CLOSESOCK(sock);
		sdp_record_free(record);
		sdp_close(session);
		return NULL;
	}
	sdp_close(session);

	BTConnection *conn = new BTConnection(sock);
	conn->connecting = false;

	conn->advertising = true;
	conn->recordHandle = record->handle;
	sdp_record_free(record);

	return conn;
}

int BTConnection::pollAccept(int msec, const char **errString) {
	int retval = SocketConnection::pollAccept(msec, errString);
	if (retval >= 1 && advertising) {
		advertising = false;
		if (!stopAdvertising(errString))
			return -1;
	}
	return retval;
}

bool BTConnection::stopAdvertising(const char **errString) {
	bdaddr_t anydevice;
	memset(&anydevice, 0, sizeof(anydevice));
	bdaddr_t local = { { 0, 0, 0, 0xff, 0xff, 0xff } };
	sdp_session_t* session = sdp_connect(&anydevice, &local, SDP_RETRY_IF_BUSY);
	if (!session) {
		*errString = getSockError();
		return false;
	}

	uint32_t range = 0x0000ffff;
	sdp_list_t* attr = sdp_list_append(NULL, &range);
	sdp_record_t* rec = sdp_service_attr_req(session, recordHandle, SDP_ATTR_REQ_RANGE, attr);
	sdp_list_free(attr, 0);

	if (sdp_device_record_unregister(session, &anydevice, rec)) {
		*errString = getSockError();
		return false;
	}
	sdp_close(session);
	return true;
}

bool BTConnection::available() {
	int dev_id = hci_get_route(NULL);
	if (dev_id < 0)
		return false;
	return true;
}

bool BTConnection::getCachedDevices(vector<Device>& devices, const char** errString) {
	int dev_id = hci_get_route(NULL);
	if (dev_id < 0) {
		*errString = "Device not available";
		// getSockError()
		return false;
	}
	struct hci_dev_info di;
	if (hci_devinfo(dev_id, &di) < 0) {
		*errString = "Can't get device info";
		// getSockError()
		return false;
	}

	char filename[PATH_MAX+1], addr[18];
	ba2str(&di.bdaddr, addr);
	snprintf(filename, PATH_MAX, "%s/%s/names", BLUETOOTH_DIR, addr);

	FILE *in = fopen(filename, "r");
	if (in == NULL) {
		*errString = getSockError();
		return false;
	}

	char row[1000];
	while (fgets(row, sizeof(row), in)) {
		int len = strlen(row);
		if (row[len-1] == '\n' || row[len-1] == '\r')
			row[--len] = '\0';
		if (row[len-1] == '\n' || row[len-1] == '\r')
			row[--len] = '\0';

		strncpy(addr, row, 17);
		addr[17] = '\0';
		Device dev;
		str2ba(addr, &dev.addr);
		dev.name = strdup(row + 18);
		dev.type = OTHER;
		devices.push_back(dev);
	}

	fclose(in);

	ba2str(&di.bdaddr, addr);
	snprintf(filename, PATH_MAX, "%s/%s/classes", BLUETOOTH_DIR, addr);

	in = fopen(filename, "r");
	if (in == NULL) {
		*errString = getSockError();
		return false;
	}

	while (fgets(row, sizeof(row), in)) {
		int len = strlen(row);
		if (row[len-1] == '\n' || row[len-1] == '\r')
			row[--len] = '\0';
		if (row[len-1] == '\n' || row[len-1] == '\r')
			row[--len] = '\0';

		strncpy(addr, row, 17);
		addr[17] = '\0';
		bdaddr_t bdaddr;
		str2ba(addr, &bdaddr);

		for (int i = 0; i < int(devices.size()); i++) {
//			if (bdaddr == devices[i].addr) {
			if (!memcmp(&bdaddr, &devices[i].addr, sizeof(bdaddr))) {
				uint32_t devclass;
				sscanf(row + 18, "%x", &devclass);
				uint8_t majorclass = (devclass >> 8) & 0x07;
				if (majorclass == 1)
					devices[i].type = COMPUTER;
				else if (majorclass == 2)
					devices[i].type = PHONE;
			}
		}
	}

	fclose(in);

	return true;
}

bool BTConnection::getDevices(vector<Device>& devices, const char **errString) {
	int dev_id = hci_get_route(NULL);
	if (dev_id < 0) {
		*errString = "Device not available";
		// getSockError()
		return false;
	}
	struct hci_dev_info di;
	if (hci_devinfo(dev_id, &di) < 0) {
		*errString = "Can't get device info";
		// getSockError()
		return false;
	}

	int flags = 0;
	flags |= IREQ_CACHE_FLUSH;
	uint8_t lap[] = { 0x33, 0x8b, 0x9e };
	inquiry_info* info = NULL;
	int found = hci_inquiry(dev_id, 8, 0, lap, &info, flags);

	if (found < 0) {
		*errString = "Inquiry failed";
		return false;
	}

	int device = hci_open_dev(dev_id);
	if (device < 0) {
		*errString = "HCI device open failed";
		bt_free(info);
		return false;
	}

	vector<Device> cached;
	if (!getCachedDevices(cached, errString))
		return false;

	for (int i = 0; i < found; i++) {
		char name[249];
		Device dev;
		dev.addr = info[i].bdaddr;
		dev.name = NULL;
		if (hci_read_remote_name_with_clock_offset(device, &info[i].bdaddr, info[i].pscan_rep_mode, info[i].clock_offset | 0x8000, sizeof(name), name, 10000) == 0) {
			dev.name = strdup(name);
		} else {
			for (int j = 0; j < int(cached.size()); j++) {
				if (!memcmp(&cached[j].addr, &dev.addr, sizeof(dev.addr))) {
					dev.name = strdup(cached[j].name);
					break;
				}
			}
			if (!dev.name) {
				char addr[18];
				ba2str(&info[i].bdaddr, addr);
				dev.name = strdup(addr);
			}
		}

		uint8_t majorclass = info[i].dev_class[1] & 0x07;
		if (majorclass == 1)
			dev.type = COMPUTER;
		else if (majorclass == 2)
			dev.type = PHONE;

		devices.push_back(dev);
	}

	for (int i = 0; i < int(cached.size()); i++)
		free((void*) cached[i].name);

	bt_free(info);
	hci_close_dev(device);

	return true;
}

