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

#define _WIN32_IE 0x0300
#define WINVER 0x0501
#include <windows.h>
#include <windowsx.h>

#include <commctrl.h>

#include <stdio.h>
#include <stdlib.h>
#include "resource.h"
#include "tcpip.h"
#include "winbt.h"
#include <SDL_syswm.h>
#include "gui.h"

#include <ws2bth.h>
#include <BluetoothAPIs.h>

#define BLUETOOTH_SERVICE_CLASS 0x10273929

HWND getWindow() {
	SDL_SysWMinfo info;
	SDL_VERSION(&info.version);
	if (SDL_GetWMInfo(&info) > 0) {
		return info.window;
	} else {
		return GetForegroundWindow();
	}
}

static HWND sdlWindow;
static HHOOK hook;
LRESULT CALLBACK windowHook(int nCode, WPARAM wParam, LPARAM lParam) {
	if (nCode == HC_ACTION) {
		CWPSTRUCT *ptr = (CWPSTRUCT*) lParam;
		if (ptr->hwnd == sdlWindow) {
			if (ptr->message == WM_PAINT || ptr->message == WM_ERASEBKGND) {
				redraw();
			}
/*			if (ptr->message == WM_PAINT)
				printf("WM_PAINT\n");
			if (ptr->message == WM_NCPAINT)
				printf("WM_NCPAINT\n");
			if (ptr->message == WM_SYNCPAINT)
				printf("WM_SYNCPAINT\n");
			if (ptr->message == WM_ERASEBKGND)
				printf("WM_ERASEBKGND\n");
*/
		}

/*		if (ptr->message == WM_SETFOCUS) {
			redraw();
		}
*/
	}
	return CallNextHookEx(0, nCode, wParam, lParam);
}

void initRedrawHook() {
	sdlWindow = getWindow();
	hook = SetWindowsHookEx(WH_CALLWNDPROC, windowHook, NULL, GetCurrentThreadId());
}

void removeRedrawHook() {
	UnhookWindowsHookEx(hook);
}

void flushMessageQueue() {
	MSG msg;
	while (PeekMessage(&msg, NULL, 0, 0, PM_REMOVE)) {
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}
}

void showWarning(const char *str) {

	initRedrawHook();
	MessageBox(getWindow(), str, "Communication error", MB_OK | MB_ICONWARNING);
	removeRedrawHook();
}

static char buffer1[100], buffer2[100];
static const char *lastPort = NULL;
static const char *lastHost = NULL;
static bool client = false;
static bool tcpip = true;

BOOL CALLBACK TCPDialogProc(HWND hDlg, UINT uMsg, WPARAM wParam, LPARAM lParam) {
	switch (uMsg) {
	case WM_INITDIALOG:
		if (lastPort == NULL) {
			sprintf(buffer1, "%d", DEFAULT_TCP_PORT);
			Edit_SetText(GetDlgItem(hDlg, DIALOG_PORT), buffer1);
		} else
			Edit_SetText(GetDlgItem(hDlg, DIALOG_PORT), lastPort);
		if (client && lastHost)
			Edit_SetText(GetDlgItem(hDlg, DIALOG_HOST), lastHost);
//		ghDialog = hDlg;
		return TRUE;
	case WM_SYSCOMMAND:
		if (wParam == SC_CLOSE) {
			EndDialog(hDlg, 0);
			return TRUE;
		}
	case WM_COMMAND:
		if (LOWORD(wParam) == DIALOG_CANCEL) {
			EndDialog(hDlg, 0);
			return TRUE;
		} else if (LOWORD(wParam) == DIALOG_CONNECT_BUTTON) {
			Edit_GetText(GetDlgItem(hDlg, DIALOG_PORT), buffer1, sizeof(buffer1));
			lastPort = buffer1;
			if (client) {
				Edit_GetText(GetDlgItem(hDlg, DIALOG_HOST), buffer2, sizeof(buffer2));
				lastHost = buffer2;
			}
			EndDialog(hDlg, 1);
			return TRUE;
		}
		break;
	case WM_DESTROY:
//		ghDialog = NULL;
		break;
	}
	return FALSE;
}

Connection *showConnectDialog() {
	client = true;
	initRedrawHook();
	int retval = DialogBoxParam(GetModuleHandle(NULL), MAKEINTRESOURCE(DIALOG_CONNECT), getWindow(), TCPDialogProc, 0);
	removeRedrawHook();
	if (retval) {
		const char *err;
		int port = atoi(lastPort);
		TCPConnection *conn = TCPConnection::startConnect(lastHost, port, &err);
		if (conn == NULL)
			showWarning(err);
		return conn;
	}
	return NULL;
}

Connection *showAcceptDialog() {
	client = false;
	initRedrawHook();
	int retval = DialogBoxParam(GetModuleHandle(NULL), MAKEINTRESOURCE(DIALOG_ACCEPT), getWindow(), TCPDialogProc, 0);
	removeRedrawHook();
	if (retval) {
		const char *err;
		int port = atoi(lastPort);
		TCPConnection *conn = TCPConnection::startAccept(port, &err);
		if (conn == NULL)
			showWarning(err);
		return conn;
	}
	return NULL;
}

BOOL CALLBACK typeDialogProc(HWND hDlg, UINT uMsg, WPARAM wParam, LPARAM lParam) {
	switch (uMsg) {
	case WM_INITDIALOG:
		{
		int defctl = 0;
		if (lParam == DIALOG_TCPIP_BUTTON || lParam == DIALOG_BLUETOOTH_BUTTON)
			defctl = client ? DIALOG_JOIN_BUTTON : DIALOG_HOST_BUTTON;
		else
			defctl = tcpip ? DIALOG_TCPIP_BUTTON : DIALOG_BLUETOOTH_BUTTON;
		SendMessage(hDlg, DM_SETDEFID, defctl, 0);
		SendMessage(hDlg, WM_NEXTDLGCTL, (WPARAM)GetDlgItem(hDlg, defctl), TRUE);
		char title[400];
		GetWindowText(hDlg, title, sizeof(title));
		if (lParam == DIALOG_TCPIP_BUTTON)
			strcat(title, " - TCP/IP");
		else if (lParam == DIALOG_BLUETOOTH_BUTTON)
			strcat(title, " - Bluetooth");
		SetWindowText(hDlg, title);
		}
		return FALSE; // to indicate that default keyboard focus shouldn't be set
	case WM_SYSCOMMAND:
		if (wParam == SC_CLOSE) {
			EndDialog(hDlg, 0);
			return TRUE;
		}
	case WM_COMMAND:
		if (LOWORD(wParam) == DIALOG_CANCEL) {
			EndDialog(hDlg, 0);
			return TRUE;
		} else if (LOWORD(wParam) == DIALOG_HOST_BUTTON) {
			EndDialog(hDlg, DIALOG_HOST_BUTTON);
			return TRUE;
		} else if (LOWORD(wParam) == DIALOG_JOIN_BUTTON) {
			EndDialog(hDlg, DIALOG_JOIN_BUTTON);
			return TRUE;
		} else if (LOWORD(wParam) == DIALOG_TCPIP_BUTTON) {
			EndDialog(hDlg, DIALOG_TCPIP_BUTTON);
			return TRUE;
		} else if (LOWORD(wParam) == DIALOG_BLUETOOTH_BUTTON) {
			EndDialog(hDlg, DIALOG_BLUETOOTH_BUTTON);
			return TRUE;
		}
		break;
	case WM_DESTROY:
		break;
	}
	return FALSE;
}

static HMODULE btdll = NULL;
static BOOL WINAPI (*ptr_BluetoothSelectDevices)(BLUETOOTH_SELECT_DEVICE_PARAMS* pbtsdp) = NULL;
static BOOL WINAPI (*ptr_BluetoothSelectDevicesFree)(BLUETOOTH_SELECT_DEVICE_PARAMS* pbtsdp) = NULL;

static HBLUETOOTH_RADIO_FIND WINAPI (*ptr_BluetoothFindFirstRadio)(BLUETOOTH_FIND_RADIO_PARAMS* pbtfrp, HANDLE* phRadio) = NULL;
static BOOL WINAPI (*ptr_BluetoothFindNextRadio)(HBLUETOOTH_RADIO_FIND hFind, HANDLE* phRadio) = NULL;
static BOOL WINAPI (*ptr_BluetoothFindRadioClose)(HBLUETOOTH_RADIO_FIND hFind) = NULL;




Connection *showBluetoothConnectDialog() {
	client = true;
	BLUETOOTH_SELECT_DEVICE_PARAMS btsdp;

	btsdp.dwSize = sizeof(btsdp);
	btsdp.cNumOfClasses = 0;
	btsdp.prgClassOfDevices = NULL;
	btsdp.pszInfo = NULL;
	btsdp.hwndParent = getWindow();
	btsdp.fForceAuthentication = FALSE;
	btsdp.fShowAuthenticated = TRUE;
	btsdp.fShowRemembered = TRUE;
	btsdp.fShowUnknown = TRUE;
	btsdp.fAddNewDeviceWizard = FALSE;
	btsdp.pfnDeviceCallback = NULL;
	btsdp.cNumDevices = 1;
	btsdp.pDevices = NULL;

	initRedrawHook();
	BOOL ok = ptr_BluetoothSelectDevices(&btsdp);
	removeRedrawHook();
	if (ok) {
		if (btsdp.cNumDevices) {
			BLUETOOTH_DEVICE_INFO* btdi = btsdp.pDevices;
			const char *err = NULL;
			Connection* conn = BTConnection::startConnect(btdi->Address.ullLong, BLUETOOTH_SERVICE_CLASS, &err);
			if (conn == NULL)
				showWarning(err);
			ptr_BluetoothSelectDevicesFree(&btsdp);
			return conn;
		}
		ptr_BluetoothSelectDevicesFree(&btsdp);
	}


	return NULL;
}

Connection *showMultiplayerDialog(bool tcpip) {
	::tcpip = tcpip;
	initRedrawHook();
	int retval = DialogBoxParam(GetModuleHandle(NULL), MAKEINTRESOURCE(DIALOG_TYPE), getWindow(), typeDialogProc, tcpip ? DIALOG_TCPIP_BUTTON : DIALOG_BLUETOOTH_BUTTON);
	removeRedrawHook();
	if (retval != 0) {
		if (tcpip) {
			if (retval == DIALOG_HOST_BUTTON)
				return showAcceptDialog();
			else
				return showConnectDialog();
		} else {
			if (retval == DIALOG_HOST_BUTTON) {
				client = false;
				const char *err = NULL;
				Connection* conn = BTConnection::startAccept(BLUETOOTH_SERVICE_CLASS, "Bantumi GL", &err);
				if (conn == NULL)
					showWarning(err);
				return conn;
			} else {
				return showBluetoothConnectDialog();
			}
		}
	}
	return NULL;
}


bool btAvailable() {
	if (!BTConnection::available())
		return false;
	if (!ptr_BluetoothSelectDevices || !ptr_BluetoothSelectDevicesFree || !ptr_BluetoothFindFirstRadio || !ptr_BluetoothFindNextRadio || !ptr_BluetoothFindRadioClose)
		return false;

	HANDLE radio;
	BLUETOOTH_FIND_RADIO_PARAMS btfrp;
	btfrp.dwSize = sizeof(btfrp);
	HBLUETOOTH_RADIO_FIND find = ptr_BluetoothFindFirstRadio(&btfrp, &radio);
	if (find) {
		CloseHandle(radio);
		ptr_BluetoothFindRadioClose(find);
		return true;
	}

	return false;
}

Connection *showMultiplayerDialog() {
	if (!btAvailable())
		return showMultiplayerDialog(true);
	initRedrawHook();
	int retval = DialogBoxParam(GetModuleHandle(NULL), MAKEINTRESOURCE(DIALOG_CONN_TYPE), getWindow(), typeDialogProc, 0);
	removeRedrawHook();
	if (retval != 0) {
		if (retval == DIALOG_TCPIP_BUTTON)
			return showMultiplayerDialog(true);
		else
			return showMultiplayerDialog(false);
	}
	return NULL;
}

void initGui() {
	INITCOMMONCONTROLSEX controls;
	controls.dwSize = sizeof(controls);
	controls.dwICC = ICC_STANDARD_CLASSES;
	InitCommonControlsEx(&controls);

	btdll = LoadLibrary("irprops.cpl"); // this is never freed...
	if (btdll) {
		ptr_BluetoothSelectDevices = (BOOL WINAPI (*)(BLUETOOTH_SELECT_DEVICE_PARAMS*)) GetProcAddress(btdll, "BluetoothSelectDevices");
		ptr_BluetoothSelectDevicesFree = (BOOL WINAPI (*)(BLUETOOTH_SELECT_DEVICE_PARAMS*)) GetProcAddress(btdll, "BluetoothSelectDevicesFree");
		ptr_BluetoothFindFirstRadio = (HBLUETOOTH_RADIO_FIND WINAPI (*)(BLUETOOTH_FIND_RADIO_PARAMS*,HANDLE*)) GetProcAddress(btdll, "BluetoothFindFirstRadio");
		ptr_BluetoothFindNextRadio = (BOOL WINAPI (*)(HBLUETOOTH_RADIO_FIND,HANDLE*)) GetProcAddress(btdll, "BluetoothFindNextRadio");
		ptr_BluetoothFindRadioClose = (BOOL WINAPI (*)(HBLUETOOTH_RADIO_FIND)) GetProcAddress(btdll, "BluetoothFindRadioClose");
	}
}

