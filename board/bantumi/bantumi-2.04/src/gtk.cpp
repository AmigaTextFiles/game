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
#include "gui.h"
#include "tcpip.h"
#include <gtk/gtk.h>
#include <string.h>
#ifdef HAVE_BLUETOOTH
#include "bluez.h"
#endif

#define BLUETOOTH_SERVICE_CLASS 0x10273929

void initGui() {
	g_thread_init(NULL);
	gtk_init(NULL, NULL);
}

static void closeDialog(GtkWidget *widget, gpointer data) {
	gtk_main_quit();
}

static void responseDialog(GtkDialog *dialog, gint arg1, gpointer data) {
	gtk_widget_destroy(GTK_WIDGET(dialog));
}

void showWarning(const char *str) {
	GtkWidget *dialog = gtk_message_dialog_new(NULL, (GtkDialogFlags) 0, GTK_MESSAGE_WARNING, GTK_BUTTONS_OK, "%s", str);
	g_signal_connect(G_OBJECT(dialog), "response", G_CALLBACK(responseDialog), NULL);
	g_signal_connect(G_OBJECT(dialog), "destroy", G_CALLBACK(closeDialog), NULL);
	gtk_widget_show_all(dialog);
	gtk_main();
}


static GtkWidget *connectButton;
static GtkWidget *refreshButton;
static GtkWidget *cancelButton;
static GtkEntry *hostEntry;
static GtkEntry *portEntry;
static SocketConnection *conn;
static GtkProgressBar *progress;
static char lastHost[200] = "";
static int lastPort = DEFAULT_TCP_PORT;
static bool keepConn;
static guint timer;
static bool hosting;
enum { NAME_COLUMN = 0, TYPE_COLUMN, ADDR_COLUMN, DEVICE_COLUMNS };
static GtkListStore *deviceListStore;
static GtkWidget *deviceList;

#ifdef HAVE_BLUETOOTH
static vector<BTConnection::Device> deviceVector;
static bdaddr_t connectAddr;
#endif

static GThread *scanThread = NULL;
static bool scanDone;
static const char *scanError;
static bool scanCancelled;

static GThread *lookupThread = NULL;
static bool lookupDone;
static const char *lookupError;
static bool lookupCancelled;

void clearDeviceList() {
	GtkTreeIter iter;
	if (gtk_tree_model_get_iter_first(GTK_TREE_MODEL(deviceListStore), &iter)) {
		do {
			char *name, *type, *addr;
			gtk_tree_model_get(GTK_TREE_MODEL(deviceListStore), &iter, NAME_COLUMN, &name, TYPE_COLUMN, &type, ADDR_COLUMN, &addr, -1);
			free(name);
			free(type);
			free(addr);
		} while (gtk_tree_model_iter_next(GTK_TREE_MODEL(deviceListStore), &iter));
	}
	gtk_list_store_clear(deviceListStore);

}

#ifdef HAVE_BLUETOOTH
void updateDeviceList(vector<BTConnection::Device>& devices) {
	clearDeviceList();
	for (int i = 0; i < int(devices.size()); i++) {
		GtkTreeIter iter;
		gtk_list_store_append(deviceListStore, &iter);
		char addr[18];
		ba2str(&devices[i].addr, addr);
		const char *type = "Other";
		if (devices[i].type == BTConnection::COMPUTER)
			type = "Computer";
		else if (devices[i].type == BTConnection::PHONE)
			type = "Phone";
		gtk_list_store_set(deviceListStore, &iter, NAME_COLUMN, devices[i].name, TYPE_COLUMN, strdup(type), ADDR_COLUMN, strdup(addr), -1);
	}
	devices.clear();
}
#endif

static void destroy(GtkWidget *widget, gpointer data) {
	if (!keepConn) {
		delete conn;
		conn = NULL;
	}
	if (timer > 0)
		g_source_remove(timer);
	gtk_main_quit();
}

static gboolean timeoutFunc(gpointer data) {
#ifdef HAVE_BLUETOOTH
	if (scanThread) {
		if (scanDone) {
			scanThread = NULL;
			if (scanError) {
				showWarning(scanError);
			} else {
				updateDeviceList(deviceVector);
			}
			gtk_widget_set_sensitive(refreshButton, TRUE);
			gtk_widget_set_sensitive(connectButton, TRUE);
			gtk_widget_set_sensitive(deviceList, TRUE);
			gtk_widget_set_sensitive(cancelButton, TRUE);
			gtk_progress_bar_set_fraction(progress, 0);
			timer = 0;
			return FALSE;
		} else {
			gtk_progress_bar_pulse(progress);
			return TRUE;
		}
	} else if (lookupThread) {
		if (lookupDone) {
			lookupThread = NULL;
			gtk_widget_set_sensitive(cancelButton, TRUE);
			if (!conn) {
				showWarning(lookupError);
				gtk_widget_set_sensitive(refreshButton, TRUE);
				gtk_widget_set_sensitive(connectButton, TRUE);
				gtk_widget_set_sensitive(deviceList, TRUE);
				gtk_progress_bar_set_fraction(progress, 0);
				timer = 0;
				return FALSE;
			}
			return TRUE;
		} else {
			gtk_progress_bar_pulse(progress);
			return TRUE;
		}
	} else
#endif
	if (conn) {
		const char *err;
		int retval;
		if (!hosting)
			retval = conn->pollConnect(0, &err);
		else
			retval = conn->pollAccept(0, &err);
		if (retval > 0) {
			keepConn = true;
			timer = 0;
			gtk_widget_destroy(GTK_WIDGET(data));
			return FALSE;
		} else if (retval < 0) {
			showWarning(err);
			delete conn;
			conn = NULL;
			gtk_progress_bar_set_fraction(progress, 0);
			gtk_widget_set_sensitive(connectButton, TRUE);
			if (hostEntry)
				gtk_widget_set_sensitive(GTK_WIDGET(hostEntry), TRUE);
			if (portEntry)
				gtk_widget_set_sensitive(GTK_WIDGET(portEntry), TRUE);
			if (refreshButton)
				gtk_widget_set_sensitive(refreshButton, TRUE);
			if (deviceList)
				gtk_widget_set_sensitive(deviceList, TRUE);
			timer = 0;
			return FALSE;
		} else {
			gtk_progress_bar_pulse(progress);
			return TRUE;
		}
	} else {
		timer = 0;
		return FALSE;
	}
}

static gpointer scanMain(gpointer data) {
#ifdef HAVE_BLUETOOTH
	vector<BTConnection::Device> devices;
	if (BTConnection::getDevices(devices, &scanError))
		scanError = NULL;
	if (!scanCancelled) {
		deviceVector = devices;
	} else {
		for (int i = 0; i < int(devices.size()); i++)
			free((void*) devices[i].name);
	}
	scanDone = true;
#endif
	return NULL;
}

static gpointer lookupMain(gpointer data) {
#ifdef HAVE_BLUETOOTH
	SocketConnection *localconn = BTConnection::startConnect(connectAddr, BLUETOOTH_SERVICE_CLASS, &lookupError);
	if (!lookupCancelled) {
		conn = localconn;
	}
	lookupDone = true;
#endif
	return NULL;
}

static void click(GtkWidget *widget, gpointer data) {
	if (widget == connectButton) {
		const char *host = NULL;
		if (hostEntry) {
			host = gtk_entry_get_text(hostEntry);
			strncpy(lastHost, host, sizeof(lastHost)-1);
			lastHost[sizeof(lastHost)-1] = '\0';
#ifdef HAVE_BLUETOOTH
		} else if (deviceList) {
			GtkTreeIter iter;
			GtkTreeSelection* selection = gtk_tree_view_get_selection(GTK_TREE_VIEW(deviceList));
			if (gtk_tree_selection_get_selected(selection, NULL, &iter)) {
				char *addr;
				gtk_tree_model_get(GTK_TREE_MODEL(deviceListStore), &iter, ADDR_COLUMN, &addr, -1);
				str2ba(addr, &connectAddr);

				lookupDone = false;
				lookupCancelled = false;
				lookupThread = g_thread_create(lookupMain, NULL, FALSE, NULL);
				gtk_widget_set_sensitive(refreshButton, FALSE);
				gtk_widget_set_sensitive(connectButton, FALSE);
				gtk_widget_set_sensitive(deviceList, FALSE);
				gtk_widget_set_sensitive(cancelButton, FALSE);
				timer = g_timeout_add(30, timeoutFunc, data);
				gtk_progress_bar_pulse(progress);
				return;
			} else {
				showWarning("No device selected");
				return;
			}
#endif
		}
		int port = 0;
		if (portEntry)
			port = atoi(gtk_entry_get_text(portEntry));
		lastPort = port;
		const char *err;
		if (hostEntry)
			conn = TCPConnection::startConnect(host, port, &err);
#ifdef HAVE_BLUETOOTH
		else if (deviceList)
			conn = BTConnection::startConnect(connectAddr, BLUETOOTH_SERVICE_CLASS, &err);
#endif
		else
			conn = TCPConnection::startAccept(port, &err);
		if (conn) {
			timer = g_timeout_add(30, timeoutFunc, data);
			gtk_widget_set_sensitive(connectButton, FALSE);
			if (hostEntry)
				gtk_widget_set_sensitive(GTK_WIDGET(hostEntry), FALSE);
			if (portEntry)
				gtk_widget_set_sensitive(GTK_WIDGET(portEntry), FALSE);
			if (refreshButton)
				gtk_widget_set_sensitive(refreshButton, FALSE);
			if (deviceList)
				gtk_widget_set_sensitive(deviceList, FALSE);
			gtk_progress_bar_pulse(progress);
		} else {
			showWarning(err);
		}
	} else if (widget == refreshButton) {
		scanDone = false;
		scanCancelled = false;
		scanThread = g_thread_create(scanMain, NULL, FALSE, NULL);
		gtk_widget_set_sensitive(refreshButton, FALSE);
		gtk_widget_set_sensitive(connectButton, FALSE);
		gtk_widget_set_sensitive(deviceList, FALSE);
		gtk_widget_set_sensitive(cancelButton, FALSE);
		timer = g_timeout_add(30, timeoutFunc, data);
		gtk_progress_bar_pulse(progress);
	} else {
		if (scanThread || lookupThread) {
			scanThread = NULL;
			scanCancelled = true;
			lookupThread = NULL;
			lookupCancelled = true;
			gtk_widget_set_sensitive(refreshButton, TRUE);
			gtk_widget_set_sensitive(connectButton, TRUE);
			gtk_widget_set_sensitive(deviceList, TRUE);
			gtk_widget_set_sensitive(cancelButton, TRUE);
			gtk_progress_bar_set_fraction(progress, 0);
			if (timer > 0)
				g_source_remove(timer);
			timer = 0;
		} else if (conn) {
			delete conn;
			conn = NULL;
			gtk_progress_bar_set_fraction(progress, 0);
			gtk_widget_set_sensitive(connectButton, TRUE);
			if (hostEntry)
				gtk_widget_set_sensitive(GTK_WIDGET(hostEntry), TRUE);
			if (portEntry)
				gtk_widget_set_sensitive(GTK_WIDGET(portEntry), TRUE);
			if (refreshButton)
				gtk_widget_set_sensitive(refreshButton, TRUE);
			if (deviceList)
				gtk_widget_set_sensitive(deviceList, TRUE);
			if (timer > 0)
				g_source_remove(timer);
			timer = 0;
		} else {
			gtk_widget_destroy(GTK_WIDGET(data));
		}
	}
}


static Connection *showDialog(bool host) {
	hosting = host;
	GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
	const char *title = "Bantumi GL - TCP/IP - Connect";
	if (host)
		title = "Bantumi GL - TCP/IP - Host";
	gtk_window_set_title(GTK_WINDOW(window), title);
	g_signal_connect(G_OBJECT(window), "destroy", G_CALLBACK(destroy), NULL);

	gtk_container_set_border_width(GTK_CONTAINER(window), 10);

	GtkContainer *vbox = GTK_CONTAINER(gtk_vbox_new(FALSE, 10));
	gtk_container_add(GTK_CONTAINER(window), GTK_WIDGET(vbox));

	GtkWidget *label2 = gtk_label_new("Server port:");
	portEntry = GTK_ENTRY(gtk_entry_new());

	char buf[50];
	sprintf(buf, "%d", lastPort);
	gtk_entry_set_text(portEntry, buf);

	GtkTable *table = GTK_TABLE(gtk_table_new(2, 2, FALSE));
	gtk_table_set_row_spacings(table, 10);
	gtk_table_set_col_spacings(table, 10);
	if (!host) {
		GtkWidget *label1 = gtk_label_new("Server host:");
		hostEntry = GTK_ENTRY(gtk_entry_new());
		gtk_entry_set_text(hostEntry, lastHost);
		gtk_table_attach_defaults(table, label1, 0, 1, 0, 1);
		gtk_table_attach_defaults(table, GTK_WIDGET(hostEntry), 1, 2, 0, 1);
	} else {
		hostEntry = NULL;
	}
	gtk_table_attach_defaults(table, label2, 0, 1, 1, 2);
	gtk_table_attach_defaults(table, GTK_WIDGET(portEntry), 1, 2, 1, 2);
	gtk_container_add(vbox, GTK_WIDGET(table));

	gtk_container_add(vbox, gtk_hseparator_new());

	GtkContainer *hbox = GTK_CONTAINER(gtk_hbox_new(FALSE, 10));

	progress = GTK_PROGRESS_BAR(gtk_progress_bar_new());
	gtk_progress_bar_set_pulse_step(progress, 0.03);

	if (host) {
		connectButton = gtk_button_new_with_label("Host");
		gtk_button_set_image(GTK_BUTTON(connectButton), gtk_image_new_from_stock(GTK_STOCK_CONNECT, GTK_ICON_SIZE_BUTTON));
//		gtk_button_set_label(GTK_BUTTON(connectButton), "Host");
	} else {
		connectButton = gtk_button_new_from_stock(GTK_STOCK_CONNECT);
	}
	g_signal_connect(G_OBJECT(connectButton), "clicked", G_CALLBACK(click), window);
	cancelButton = gtk_button_new_from_stock(GTK_STOCK_CANCEL);
	g_signal_connect(G_OBJECT(cancelButton), "clicked", G_CALLBACK(click), window);
	gtk_container_add(GTK_CONTAINER(hbox), GTK_WIDGET(progress));
	gtk_container_add(GTK_CONTAINER(hbox), connectButton);
	gtk_container_add(GTK_CONTAINER(hbox), cancelButton);

	gtk_container_add(vbox, GTK_WIDGET(hbox));

	gtk_widget_show_all(window);

	conn = NULL;
	keepConn = false;
	timer = 0;
	refreshButton = NULL;
	deviceList = NULL;
	deviceListStore = NULL;
	gtk_main();

	return conn;
}

static gboolean btTimeoutFunc(gpointer data) {
	if (conn) {
		const char *err;
		int retval;
		if (!hosting)
			retval = conn->pollConnect(0, &err);
		else
			retval = conn->pollAccept(0, &err);
		if (retval > 0) {
			keepConn = true;
			timer = 0;
			gtk_widget_destroy(GTK_WIDGET(data));
			return FALSE;
		} else if (retval < 0) {
			showWarning(err);
			delete conn;
			conn = NULL;
			timer = 0;
			return FALSE;
		} else {
			gtk_progress_bar_pulse(progress);
			return TRUE;
		}
	} else {
		timer = 0;
		return FALSE;
	}
}
static void btClick(GtkWidget *widget, gpointer data) {
	delete conn;
	conn = NULL;
	if (timer > 0)
		g_source_remove(timer);
	timer = 0;
	gtk_widget_destroy(GTK_WIDGET(data));
}

static Connection *showProgress(SocketConnection *localconn, bool host) {
	hosting = host;
	conn = localconn;
	GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
	gtk_window_set_title(GTK_WINDOW(window), host ? "Awaiting connection" : "Connecting");
	g_signal_connect(G_OBJECT(window), "destroy", G_CALLBACK(destroy), NULL);

	gtk_container_set_border_width(GTK_CONTAINER(window), 10);

	GtkContainer *vbox = GTK_CONTAINER(gtk_vbox_new(FALSE, 10));
	gtk_container_add(GTK_CONTAINER(window), GTK_WIDGET(vbox));

	GtkContainer *hbox = GTK_CONTAINER(gtk_hbox_new(FALSE, 10));

	progress = GTK_PROGRESS_BAR(gtk_progress_bar_new());
	gtk_progress_bar_set_pulse_step(progress, 0.03);

	GtkWidget *cancel = gtk_button_new_from_stock(GTK_STOCK_CANCEL);
	g_signal_connect(G_OBJECT(cancel), "clicked", G_CALLBACK(btClick), window);
	gtk_container_add(GTK_CONTAINER(hbox), GTK_WIDGET(progress));
	gtk_container_add(GTK_CONTAINER(hbox), cancel);

	gtk_container_add(vbox, GTK_WIDGET(hbox));

	gtk_widget_show_all(window);

	timer = g_timeout_add(30, btTimeoutFunc, window);
	gtk_progress_bar_pulse(progress);
	keepConn = false;
	gtk_main();

	return conn;
}

Connection* showBluetoothSelectDialog() {
	hosting = false;
	GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
	gtk_window_set_title(GTK_WINDOW(window), "Bantumi GL - Select device");
	g_signal_connect(G_OBJECT(window), "destroy", G_CALLBACK(closeDialog), NULL);

	gtk_container_set_border_width(GTK_CONTAINER(window), 10);

	GtkContainer *vbox = GTK_CONTAINER(gtk_vbox_new(FALSE, 10));
	gtk_container_add(GTK_CONTAINER(window), GTK_WIDGET(vbox));

	deviceListStore = gtk_list_store_new(3, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING);

#ifdef HAVE_BLUETOOTH
	const char *err;
	deviceVector.clear();
	if (!BTConnection::getCachedDevices(deviceVector, &err)) {
		showWarning(err);
		return NULL;
	}
	updateDeviceList(deviceVector);
#endif


	deviceList = gtk_tree_view_new_with_model(GTK_TREE_MODEL(deviceListStore));

	GtkCellRenderer *renderer = gtk_cell_renderer_text_new();
//	g_object_set(G_OBJECT(renderer), "foreground", "red", NULL);

	GtkTreeViewColumn *column;
	column = gtk_tree_view_column_new_with_attributes("Name", renderer, "text", NAME_COLUMN, NULL);
	gtk_tree_view_append_column(GTK_TREE_VIEW(deviceList), column);
	column = gtk_tree_view_column_new_with_attributes("Type", renderer, "text", TYPE_COLUMN, NULL);
	gtk_tree_view_append_column(GTK_TREE_VIEW(deviceList), column);
	column = gtk_tree_view_column_new_with_attributes("Address", renderer, "text", ADDR_COLUMN, NULL);
	gtk_tree_view_append_column(GTK_TREE_VIEW(deviceList), column);

	GtkWidget* scroll = gtk_scrolled_window_new(NULL, NULL);
//	gtk_container_add(GTK_CONTAINER(scroll), deviceList);
	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scroll), GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
	gtk_widget_set_size_request(scroll, -1, 200);
	gtk_scrolled_window_add_with_viewport(GTK_SCROLLED_WINDOW(scroll), deviceList);

	gtk_container_add(vbox, scroll);

	gtk_container_add(vbox, gtk_hseparator_new());

	GtkContainer *hbox = GTK_CONTAINER(gtk_hbox_new(FALSE, 10));

	progress = GTK_PROGRESS_BAR(gtk_progress_bar_new());
	gtk_progress_bar_set_pulse_step(progress, 0.03);

	refreshButton = gtk_button_new_from_stock(GTK_STOCK_REFRESH);
	connectButton = gtk_button_new_from_stock(GTK_STOCK_CONNECT);
	g_signal_connect(G_OBJECT(refreshButton), "clicked", G_CALLBACK(click), window);
	g_signal_connect(G_OBJECT(connectButton), "clicked", G_CALLBACK(click), window);
	cancelButton = gtk_button_new_from_stock(GTK_STOCK_CANCEL);
	g_signal_connect(G_OBJECT(cancelButton), "clicked", G_CALLBACK(click), window);
	gtk_container_add(GTK_CONTAINER(hbox), GTK_WIDGET(progress));
	gtk_container_add(GTK_CONTAINER(hbox), refreshButton);
	gtk_container_add(GTK_CONTAINER(hbox), connectButton);
	gtk_container_add(GTK_CONTAINER(hbox), cancelButton);

	gtk_container_add(vbox, GTK_WIDGET(hbox));

	gtk_widget_show_all(window);

	conn = NULL;
	keepConn = false;
	timer = 0;
	hostEntry = NULL;
	portEntry = NULL;
	gtk_main();

	clearDeviceList();
	g_object_unref(G_OBJECT(deviceListStore));

	return conn;
}

static int typeResponse;
static void responseTypeDialog(GtkDialog *dialog, gint arg1, gpointer data) {
	gtk_widget_destroy(GTK_WIDGET(dialog));
	typeResponse = arg1;
}

Connection *showHostJoinDialog(bool tcpip) {
	typeResponse = GTK_RESPONSE_CANCEL;
	char title[200];
	sprintf(title, "Bantumi GL - Multiplayer - %s", tcpip ? "TCP/IP" : "Bluetooth");
	GtkWidget *dialog = gtk_dialog_new_with_buttons(title, NULL, (GtkDialogFlags) 0, "Host", 1, "Join", 0, GTK_STOCK_CANCEL, GTK_RESPONSE_CANCEL, NULL);
	// FIXME: icons for buttons
	g_signal_connect(G_OBJECT(dialog), "response", G_CALLBACK(responseTypeDialog), NULL);
	g_signal_connect(G_OBJECT(dialog), "destroy", G_CALLBACK(closeDialog), NULL);

	GtkWidget *label = gtk_label_new("Select whether you want\nto host the game or join a game\nhosted on another machine");
	gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_CENTER);
	GtkWidget *alignment = gtk_alignment_new(0.5, 0.5, 1, 1);
	gtk_alignment_set_padding(GTK_ALIGNMENT(alignment), 10, 10, 10, 10);
	gtk_container_add(GTK_CONTAINER(alignment), label);
	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), alignment);

	gtk_widget_show_all(dialog);
	gtk_main();

	if (typeResponse == GTK_RESPONSE_CANCEL || typeResponse == GTK_RESPONSE_DELETE_EVENT)
		return NULL;

	if (tcpip)
		return showDialog(typeResponse);
	else {
#ifdef HAVE_BLUETOOTH
		if (typeResponse) {
			const char *err = NULL;
			SocketConnection* conn = BTConnection::startAccept(BLUETOOTH_SERVICE_CLASS, "Bantumi GL", &err);
			if (conn == NULL)
				showWarning(err);
			else
				return showProgress(conn, "Awaiting connection");
			return NULL;
		} else {
			return showBluetoothSelectDialog();
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
	typeResponse = GTK_RESPONSE_CANCEL;
	GtkWidget *dialog = gtk_dialog_new_with_buttons("Bantumi GL - Multiplayer", NULL, (GtkDialogFlags) 0, "TCP/IP", 1, "Bluetooth", 0, GTK_STOCK_CANCEL, GTK_RESPONSE_CANCEL, NULL);
	// FIXME: icons for buttons
	g_signal_connect(G_OBJECT(dialog), "response", G_CALLBACK(responseTypeDialog), NULL);
	g_signal_connect(G_OBJECT(dialog), "destroy", G_CALLBACK(closeDialog), NULL);

	GtkWidget *label = gtk_label_new("Select which type of\ncommunication you want to\nuse for the multiplayer game");
	gtk_label_set_justify(GTK_LABEL(label), GTK_JUSTIFY_CENTER);
	GtkWidget *alignment = gtk_alignment_new(0.5, 0.5, 1, 1);
	gtk_alignment_set_padding(GTK_ALIGNMENT(alignment), 10, 10, 10, 10);
	gtk_container_add(GTK_CONTAINER(alignment), label);
	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), alignment);

	gtk_widget_show_all(dialog);
	gtk_main();

	if (typeResponse == GTK_RESPONSE_CANCEL || typeResponse == GTK_RESPONSE_DELETE_EVENT)
		return NULL;

	return showHostJoinDialog(typeResponse);
}


