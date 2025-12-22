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

#import "cocoa.h"

#include "connection.h"

@interface AlertController : NSObject {
@public
	int choice;
}
- (void) alertDidEnd: (NSAlert*) alert returnCode: (int) returnCode contextInfo: (void*) contextInfo;
@end

@implementation AlertController
- (void) alertDidEnd: (NSAlert*) alert returnCode: (int) returnCode contextInfo: (void*) contextInfo {
	switch (returnCode) {
	case NSAlertFirstButtonReturn:
		choice = 1;
		break;
	case NSAlertSecondButtonReturn:
		choice = 2;
		break;
	case NSAlertThirdButtonReturn:
		choice = 0;
		break;
	}
	[NSApp stopModal];
}
@end

NSWindow *getMainWindow() {
	NSWindow *window = [NSApp mainWindow];
	if (window)
		return window;
	NSArray *windows = [NSApp windows];
	if ([windows count] > 0)
		return [windows objectAtIndex: 0];
	return nil;
}

void showWarning(const char *str) {
	NSWindow *sdlWindow = getMainWindow();
	AlertController *controller = [[AlertController alloc] init];
	NSAlert *alert = [[NSAlert alloc] init];
	[alert setAlertStyle: NSInformationalAlertStyle];
	[alert setMessageText: @"Communication error"];
	[alert setInformativeText: [NSString stringWithCString: str]];
	[alert addButtonWithTitle: @"OK"];
	[alert beginSheetModalForWindow: sdlWindow modalDelegate: controller didEndSelector: @selector(alertDidEnd:returnCode:contextInfo:) contextInfo: NULL];

	unsetenv("SDL_ENABLEAPPEVENTS");

//	[alert runModal];
	[NSApp runModalForWindow: [alert window]];
	[alert release];

	setenv("SDL_ENABLEAPPEVENTS", "1", 1);
	[controller release];
}

Connection *showTcpDialog(NSString *nibName, BOOL client);
Connection *showBluetoothDialog(BOOL client);

static Connection *showHostJoinDialog(BOOL bluetooth) {
	NSWindow *sdlWindow = getMainWindow();

	AlertController *controller = [[AlertController alloc] init];
	NSAlert *alert = [[NSAlert alloc] init];
	[alert setAlertStyle: NSInformationalAlertStyle];
	[alert setMessageText: @"Select connection type"];
	[alert setInformativeText: @"Select whether you want to host the game or join a game hosted on another machine"];
	[alert addButtonWithTitle: @"Host"];
	[alert addButtonWithTitle: @"Join"];
	[alert addButtonWithTitle: @"Cancel"];
//	[alert runModal];
	[alert beginSheetModalForWindow: sdlWindow modalDelegate: controller didEndSelector: @selector(alertDidEnd:returnCode:contextInfo:) contextInfo: NULL];
	[alert release];

	unsetenv("SDL_ENABLEAPPEVENTS");
	[NSApp runModalForWindow: [alert window]];
	setenv("SDL_ENABLEAPPEVENTS", "1", 1);

	int choice = controller->choice;
	[controller release];
	switch (choice) {
	case 1: // host
		if (bluetooth)
			return showBluetoothDialog(NO);
		else
			return showTcpDialog(@"TCPServerGui", NO);
	case 2: // join
		if (bluetooth)
			return showBluetoothDialog(YES);
		else
			return showTcpDialog(@"TCPClientGui", YES);

	case 0:
	default:
		return NULL;
	}
}
Connection *showMultiplayerDialog() {
	NSWindow *sdlWindow = getMainWindow();

	AlertController *controller = [[AlertController alloc] init];
	NSAlert *alert = [[NSAlert alloc] init];
	[alert setAlertStyle: NSInformationalAlertStyle];
	[alert setMessageText: @"Select communication type"];
	[alert setInformativeText: @"Select which type of communication you want to use for the multiplayer game"];
	[alert addButtonWithTitle: @"TCP/IP"];
	[alert addButtonWithTitle: @"Bluetooth"];
	[alert addButtonWithTitle: @"Cancel"];
//	[alert runModal];
	[alert beginSheetModalForWindow: sdlWindow modalDelegate: controller didEndSelector: @selector(alertDidEnd:returnCode:contextInfo:) contextInfo: NULL];
	[alert release];

	unsetenv("SDL_ENABLEAPPEVENTS");
	[NSApp runModalForWindow: [alert window]];
	setenv("SDL_ENABLEAPPEVENTS", "1", 1);

	int choice = controller->choice;
	[controller release];
	switch (choice) {
	case 1:
		return showHostJoinDialog(NO);
	case 2:
		return showHostJoinDialog(YES);

	case 0:
	default:
		return NULL;
	}
}

void initGui() {
}


