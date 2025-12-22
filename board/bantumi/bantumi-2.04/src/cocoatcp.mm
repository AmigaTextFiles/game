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

#import "TCPGuiController.h"

#include "tcpip.h"

NSWindow *getMainWindow();
static NSString *lastHost = nil;
static NSString *lastPort = nil;

void showWarning(NSWindow *window, NSString *err) {
	NSAlert *alert = [[NSAlert alloc] init];
	[alert setAlertStyle: NSWarningAlertStyle];
	[alert addButtonWithTitle: @"OK"];
	[alert setMessageText: @"Communication error"];
	[alert setInformativeText: err];
//	[alert runModal];
	[alert beginSheetModalForWindow: window modalDelegate: nil didEndSelector: nil contextInfo: NULL];
	[alert release];
}

@implementation TCPGuiController

- (void) terminate: (id) sender {
	exit(0);
}

- (IBAction) cancel: (id) sender {
	if (started) {
		stop = true;
	} else {
		[self close: sender];
	}
}

- (void) close: (id) sender {
	[NSApp endSheet: window];
	[window orderOut: self];

//	[NSApp stop: nil];
	[NSApp stopModal];
}

- (void) timer: (NSTimer*) timerObj {
	if (!started) {
		[timerObj invalidate];
		return;
	}
	if (failure) {
		conn = NULL;
		started = NO;
		[progress setHidden: YES];
		[host setEditable: YES];
		[port setEditable: YES];
		if (client)
			[connectButton setEnabled: YES];
		else
			[hostButton setEnabled: YES];
	
		if (errString) {
			NSString *err;
			if (hostString)
				err = [NSString stringWithFormat: @"%@: %s", hostString, errString];
			else
				err = [NSString stringWithFormat: @"%s", errString];

			showWarning(window, err);
		}

		if (hostString)
			[hostString autorelease];
		[timerObj invalidate];
		return;
	}
	if (success) {
		if (hostString)
			[hostString autorelease];
		[self close: nil];
		[timerObj invalidate];

		// post an empty event, otherwise the run loop sticks waiting for events without terminating immediately
		NSPoint point = { 0, 0 };
		[NSApp postEvent: [NSEvent otherEventWithType: NSApplicationDefined location: point modifierFlags: 0 timestamp: 0 windowNumber: 0 context: nil subtype: 0 data1: 0 data2: 0] atStart: YES];
		return;
	}
}

- (void) threadMain: (id) arg {

	[[NSAutoreleasePool alloc] init];

	if (client) {
		const char *hostName = [hostString cStringUsingEncoding: NSISOLatin1StringEncoding];
		conn = TCPConnection::connect(hostName, portNumber, &errString, &stop);
	} else {
		conn = TCPConnection::accept(portNumber, &errString, &stop);
	}

	if (conn)
		success = YES;
	else
		failure = YES;

}

- (IBAction) startConnect: (id) sender {
	started = YES;
	failure = NO;
	success = NO;
	stop = false;
	errString = NULL;
	[progress startAnimation: sender];
	[progress setHidden: NO];
	[host setEditable: NO];
	[port setEditable: NO];
	lastPort = [[port stringValue] copy];
	if (client) {
		lastHost = [[host stringValue] copy];
		[connectButton setEnabled: NO];
	} else
		[hostButton setEnabled: NO];

	if (client)
		hostString = [[host stringValue] retain];
	else
		hostString = nil;
	portNumber = [port intValue];
	[NSThread detachNewThreadSelector: @selector(threadMain:) toTarget: self withObject: nil];
	id timer = [NSTimer scheduledTimerWithTimeInterval: 0.05 target: self selector: @selector(timer:) userInfo: nil repeats: YES];
	[[NSRunLoop currentRunLoop] addTimer: timer forMode: NSModalPanelRunLoopMode];
}

- (void) awakeFromNib {
	if (lastPort == nil)
		[port setStringValue: [NSString stringWithFormat: @"%d", DEFAULT_TCP_PORT]];
	else
		[port setStringValue: lastPort];
	if (host && lastHost != nil)
		[host setStringValue: lastHost];
//	[window center];
//	[window makeKeyAndOrderFront: nil];
	started = NO;
	conn = NULL;
}

@end

Connection *showTcpDialog(NSString *nibName, BOOL client) {
	NSWindow *sdlWindow = getMainWindow();

	NSNib *nib = [[NSNib alloc] initWithNibNamed: nibName bundle: [NSBundle mainBundle]];
	NSArray *array;
	[nib instantiateNibWithOwner: nil topLevelObjects: &array];

	TCPGuiController *controller = nil;
	NSWindow *window = nil;
	for (int i = 0; i < int([array count]); i++)
		if ([[array objectAtIndex: i] isKindOfClass: [TCPGuiController class]])
			controller = [array objectAtIndex: i];
		else if ([[array objectAtIndex: i] isKindOfClass: [NSWindow class]])
			window = [array objectAtIndex: i];

	controller->client = client;

	NSMenu *mainMenu = [NSApp mainMenu];
	NSMenu *appMenu = [[[mainMenu itemArray] objectAtIndex: 0] submenu];
	NSArray *menuArray = [appMenu itemArray];
	id <NSMenuItem> quitItem = [menuArray objectAtIndex: [menuArray count] - 1];

	id oldTarget = [quitItem target];
	SEL oldAction = [quitItem action];
	[quitItem setTarget: controller];
	[quitItem setAction: @selector(terminate:)];
	[quitItem setRepresentedObject: window];

	unsetenv("SDL_ENABLEAPPEVENTS");
	[NSApp beginSheet: window modalForWindow: sdlWindow modalDelegate: nil didEndSelector: nil contextInfo: NULL];
//	[NSApp run];
	[NSApp runModalForWindow: window];
//	[NSApp endSheet: window];
//	[window orderOut: nil];
	setenv("SDL_ENABLEAPPEVENTS", "1", 1);

	TCPConnection *conn = controller->conn;

	[window setExcludedFromWindowsMenu: YES];
	[NSApp removeWindowsItem: window];
	[window close];
	[nib release];
	[quitItem setTarget: oldTarget];
	[quitItem setAction: oldAction];

	[sdlWindow makeKeyAndOrderFront: nil];

	return conn;
}


