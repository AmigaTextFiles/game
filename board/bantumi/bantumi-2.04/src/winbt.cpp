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

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "winbt.h"
#include "sdprecord.h"

BTConnection::BTConnection(SOCKTYPE s) : SocketConnection(s) {
	advertising = false;
	serviceInfo = NULL;
}

BTConnection::~BTConnection() {
	if (advertising) {
		WSASetService(&service, RNRSERVICE_DELETE, 0);
	}
	free(serviceInfo);
}

bool BTConnection::available() {
	SOCKET sock = socket(AF_BTH, SOCK_STREAM, BTHPROTO_RFCOMM);
	if (sock == INVALID_SOCKET)
		return false;
	CLOSESOCK(sock);
	return true;
}

BTConnection *BTConnection::startConnect(BTH_ADDR addr, unsigned int uuid, const char **errString) {
	*errString = NULL;

	WSAQUERYSET qs;
	memset(&qs, 0, sizeof(qs));

	BTH_QUERY_SERVICE queryParams;
	memset(&queryParams, 0, sizeof(queryParams));
	queryParams.type = SDP_SERVICE_SEARCH_ATTRIBUTE_REQUEST;
	queryParams.uuids[0].u.uuid32 = uuid;
	queryParams.uuids[0].uuidType = SDP_ST_UUID32;
	memset(&queryParams.uuids[1], 0, sizeof(queryParams.uuids[1]));
	queryParams.numRange = 1;
	queryParams.pRange[0].minAttribute = 0;
	queryParams.pRange[0].maxAttribute = 0xffff;

	BLOB blob;
	blob.cbSize = sizeof(queryParams);
	blob.pBlobData = (BYTE*) &queryParams;
	qs.lpBlob = &blob;

	qs.dwSize = sizeof(WSAQUERYSET);
	qs.dwNameSpace = NS_BTH;
	qs.dwNumberOfCsAddrs = 0;

	SOCKADDR_BTH remote;
	memset(&remote, 0, sizeof(remote));
	remote.addressFamily = AF_BTH;
	remote.btAddr = addr;
	char buffer[100];
	DWORD len = sizeof(buffer);
	WSAAddressToString((SOCKADDR*) &remote, sizeof(remote), NULL, buffer, &len);
	qs.lpszContext = buffer;

	HANDLE query = NULL;
	if (WSALookupServiceBegin(&qs, LUP_FLUSHCACHE, &query)) {
		*errString = getSockError();
		return NULL;
	}
	bool found = false;
	while (!found) {
		DWORD size = 2000;
		WSAQUERYSET* res = (WSAQUERYSET*) malloc(size);
		if (WSALookupServiceNext(query, LUP_RETURN_ADDR, &size, res)) {
			free(res);
			int err = WSAGetLastError();
			if (err == WSA_E_NO_MORE)
				break;
			else {
				*errString = getSockError();
				return NULL;
			}
		}
		CSADDR_INFO* info = (CSADDR_INFO*) res->lpcsaBuffer;
		SOCKADDR_BTH* sa = (SOCKADDR_BTH*) info->RemoteAddr.lpSockaddr;
		memcpy(&remote, sa, sizeof(SOCKADDR_BTH));
//		remote = *(info->RemoteAddr.lpSockaddr);
		found = true;

		free(res);
	}
	WSALookupServiceEnd(query);
	if (!found) {
		*errString = "Service not found";
		return NULL;
	}

	SOCKTYPE sock;
	if ((sock = socket(AF_BTH, SOCK_STREAM, BTHPROTO_RFCOMM)) == INVALID_SOCKET) {
		*errString = getSockError();
		return NULL;
	}


	if (SETNONBLOCK(sock, 1) == -1) {
		*errString = getSockError();
		CLOSESOCK(sock);
		return NULL;
	}

	if (::connect(sock, (sockaddr*) &remote, sizeof(remote)) < 0) {
		int err = CUR_ERROR();
		if (err != EINPROGRESS && err != 0) {
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
	if ((sock = socket(AF_BTH, SOCK_STREAM, BTHPROTO_RFCOMM)) == INVALID_SOCKET) {
		*errString = getSockError();
		return NULL;
	}

	SOCKADDR_BTH addr;
	memset(&addr, 0, sizeof(addr));
	addr.addressFamily = AF_BTH;
	addr.btAddr = 0;
	addr.port = (ULONG) BT_PORT_ANY;

	if (bind(sock, (struct sockaddr*) &addr, sizeof(addr)) < 0) {
		*errString = getSockError();
		CLOSESOCK(sock);
		return NULL;
	}

	if (listen(sock, 2) < 0) {
		*errString = getSockError();
		CLOSESOCK(sock);
		return NULL;
	}

	int len = sizeof(addr);
	if (getsockname(sock, (sockaddr*) &addr, &len) < 0) {
		*errString = getSockError();
		CLOSESOCK(sock);
		return NULL;
	}

	BTConnection *conn = new BTConnection(sock);
	conn->connecting = false;

	memset(&conn->service, 0, sizeof(conn->service));
	conn->service.dwSize = sizeof(conn->service);
	conn->service.dwNameSpace = NS_BTH;


	SdpRecord* recBuilder = new SdpRecord();
	recBuilder
	->startRecord()
		->addAttribute(SDP_ATTRIB_CLASS_ID_LIST)
			->addDES()
				->addUuid32(uuid)
			->endDES()
		->endAttribute()
		->addAttribute(SDP_ATTRIB_PROTOCOL_DESCRIPTOR_LIST)
			->addDES()
				->addDES()
					->addUuid16(L2CAP_PROTOCOL_UUID16)
				->endDES()
				->addDES()
					->addUuid16(RFCOMM_PROTOCOL_UUID16)
					->addUint8(addr.port)
				->endDES()
			->endDES()
		->endAttribute()
		->addAttribute(LANG_DEFAULT_ID + STRING_NAME_OFFSET)
			->addString(serviceName)
		->endAttribute()
	->endRecord();

	int sdpreclen = recBuilder->getLength();
	const unsigned char *sdprec = recBuilder->getData();

	conn->serviceInfo = (BTH_SET_SERVICE*) malloc(sizeof(BTH_SET_SERVICE) + sdpreclen - 1);
	BTH_SET_SERVICE* ptr = conn->serviceInfo;
	memset(conn->serviceInfo, 0, sizeof(BTH_SET_SERVICE));
	conn->sdpVersion = BTH_SDP_VERSION;
	ptr->pSdpVersion = &conn->sdpVersion;
	ptr->fCodService = 0;
	ptr->ulRecordLength = sdpreclen;
	conn->recordHandle = 0;
	ptr->pRecordHandle = &conn->recordHandle;
	memcpy(ptr->pRecord, sdprec, sdpreclen);

	delete recBuilder;

	conn->serviceBlob.cbSize = sizeof(BTH_SET_SERVICE) + sdpreclen - 1;
	conn->serviceBlob.pBlobData = (BYTE*) conn->serviceInfo;
	conn->service.lpBlob = &conn->serviceBlob;

	if (WSASetService(&conn->service, RNRSERVICE_REGISTER, 0)) {
		*errString = getSockError();
		delete conn;
		return NULL;
	}
	conn->advertising = true;

	return conn;
}

int BTConnection::pollAccept(int msec, const char **errString) {
	int retval = SocketConnection::pollAccept(msec, errString);
	if (retval >= 1 && advertising) {
		if (WSASetService(&service, RNRSERVICE_DELETE, 0)) {
			*errString = getSockError();
			return -1;
		}
		advertising = false;
	}
	return retval;
}


