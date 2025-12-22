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
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "gui.h"
#include "tcpip.h"
#ifdef HAVE_BLUETOOTH
#include "bluez.h"
#endif

#define BLUETOOTH_SERVICE_CLASS 0x10273929

void initGui() {
}

void showWarning(const char *str) {
	printf("%s\n", str);
}

Connection *showConnectDialog() {
	printf("Server host: ");
	fflush(stdout);
	char host[100];
	fgets(host, sizeof(host), stdin);
	int len = strlen(host);
	if (len > 0 && (host[len-1] == '\n' || host[len-1] == '\r'))
		host[--len] = '\0';
	if (len > 0 && (host[len-1] == '\n' || host[len-1] == '\r'))
		host[--len] = '\0';
	printf("Server port: ");
	fflush(stdout);
	char port[100];
	fgets(port, sizeof(port), stdin);
	const char *err;
	TCPConnection *conn = TCPConnection::startConnect(host, atoi(port), &err);
	if (!conn)
		showWarning(err);
	return conn;
}

Connection *showAcceptDialog() {
	printf("Server port: ");
	fflush(stdout);
	char port[100];
	fgets(port, sizeof(port), stdin);
	const char *err;
	TCPConnection *conn = TCPConnection::startAccept(atoi(port), &err);
	if (!conn)
		showWarning(err);
	return conn;
}

#ifdef HAVE_BLUETOOTH
Connection *showSelectDialog() {
	vector<BTConnection::Device> devices;
	const char *err;
	if (!BTConnection::getCachedDevices(devices, &err)) {
		showWarning(err);
		return NULL;
	}
	while (true) {
		printf("Select devices:\n");
		for (int i = 0; i < int(devices.size()); i++) {
			char addr[18];
			const char *type = "Other";
			if (devices[i].type == BTConnection::COMPUTER)
				type = "Computer";
			else if (devices[i].type == BTConnection::PHONE)
				type = "Phone";
			ba2str(&devices[i].addr, addr);
			printf("%d: %s (%s, %s)\n", i, devices[i].name, type, addr);
			free((void*) devices[i].name);
		}
		printf("Enter device number, r to refresh or nothing to cancel: ");
		fflush(stdout);
		char answer[100];
		fgets(answer, sizeof(answer), stdin);
		char *ptr = answer;
		while (*ptr) {
			*ptr = tolower(*ptr);
			ptr++;
		}
		int len = strlen(answer);
		if (len > 0 && (answer[len-1] == '\r' || answer[len-1] == '\n'))
			answer[--len] = '\0';
		if (len > 0 && (answer[len-1] == '\r' || answer[len-1] == '\n'))
			answer[--len] = '\0';
		if (len == 0)
			return NULL;
		if (answer[0] == 'r') {
			devices.clear();
			if (!BTConnection::getDevices(devices, &err)) {
				showWarning(err);
				return NULL;
			}
			continue;
		}
		int n = atoi(answer);
		if (n < 0 || n >= int(devices.size())) {
			printf("Bad device number\n");
			return NULL;
		}
		const char *err;
		Connection *conn = BTConnection::startConnect(devices[n].addr, BLUETOOTH_SERVICE_CLASS, &err);
		if (!conn)
			showWarning(err);
		return conn;
	}
	return NULL;
}
#endif

Connection *showHostJoinDialog(bool tcpip) {
	printf("Host or join? ");
	fflush(stdout);
	char answer[100];
	fgets(answer, sizeof(answer), stdin);
	char *ptr = answer;
	while (*ptr) {
		*ptr = tolower(*ptr);
		ptr++;
	}
	int len = strlen(answer);
	if (len > 0 && (answer[len-1] == '\r' || answer[len-1] == '\n'))
		answer[--len] = '\0';
	if (len > 0 && (answer[len-1] == '\r' || answer[len-1] == '\n'))
		answer[--len] = '\0';
	bool join = !strcmp(answer, "join");
	if (tcpip) {
		if (join)
			return showConnectDialog();
		else
			return showAcceptDialog();
	} else {
#ifdef HAVE_BLUETOOTH
		if (join)
			return showSelectDialog();
		else {
			const char *err;
			Connection* conn = BTConnection::startAccept(BLUETOOTH_SERVICE_CLASS, "Bantumi GL", &err);
			if (!conn)
				showWarning(err);
			return conn;
		}
#else
		return NULL;
#endif
	}
}

Connection *showMultiplayerDialog() {
#ifdef HAVE_BLUETOOTH
        bool bluetooth = BTConnection::available();
#else
        bool bluetooth = false;
#endif
	if (!bluetooth)
		return showHostJoinDialog(true);
	printf("Bluetooth or TCP/IP? ");
	fflush(stdout);
	char answer[100];
	fgets(answer, sizeof(answer), stdin);
	char *ptr = answer;
	while (*ptr) {
		*ptr = tolower(*ptr);
		ptr++;
	}
	int len = strlen(answer);
	if (len > 0 && (answer[len-1] == '\r' || answer[len-1] == '\n'))
		answer[--len] = '\0';
	if (len > 0 && (answer[len-1] == '\r' || answer[len-1] == '\n'))
		answer[--len] = '\0';
	if (len > 0 && answer[0] == 'b')
		return showHostJoinDialog(false);
	else
		return showHostJoinDialog(true);
}

