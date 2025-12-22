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
#import "BluetoothGuiController.h"
#include "osxbt.h"


void showWarning(const char *str);
NSWindow *getMainWindow();


@implementation BluetoothGuiController
- (void) sheetDidEnd: (IOBluetoothDeviceSelectorController*) controller returnCode: (int) returnCode contextInfo: (void*) contextInfo {
	if (returnCode != kIOBluetoothUISuccess) {
		[NSApp stopModal];
		return;
	}
	device = [[controller getResults] objectAtIndex: 0];
	[device retain];

	[NSApp stopModal];
}

- (BTConnection*) connect {

	IOBluetoothDeviceSelectorController *controller = [[IOBluetoothDeviceSelectorController alloc] init];
	if (serviceUuid)
		[controller addAllowedUUID: serviceUuid];
//	[controller setOptions: kSearchOptionsAlwaysStartInquiry];
//	[controller setOptions: kSearchOptionsDiscardCachedResults];
	[controller setPrompt: @"Connect"];
	[controller setTitle: @"Connect to game host"];
	[controller setDescriptionText: @"Select a bluetooth device hosting the game. To find devices in range of your computer, click the Search button."];
//	[[controller window] setShowsResizeIndicator: NO];
//	[controller runModal];

	if (parentWindow) {
		[controller beginSheetModalForWindow: parentWindow modalDelegate: self didEndSelector: @selector(sheetDidEnd:returnCode:contextInfo:) contextInfo: NULL];
		[NSApp runModalForWindow: [controller window]];
	} else {
		if ([controller runModal] == kIOBluetoothUISuccess) {
			device = [[controller getResults] objectAtIndex: 0];
			[device retain];
		}
	}
	[controller release];

	if (device == nil)
		return NULL;

	conn = new BTConnection([serviceUuid getSDPUUIDRef], (CFStringRef) serviceName, (CFStringRef) serviceDescription);
	const char *err = NULL;
	if (!conn->connect([device getDeviceRef], &err)) {
		[device release];
		device = nil;
		showWarning(err);
		delete conn;
		return NULL;
	}
	[device release];
	device = nil;

	nib = [[NSNib alloc] initWithNibNamed: @"BluetoothWait" bundle: [NSBundle mainBundle]];
	[nib instantiateNibWithOwner: self topLevelObjects: nil];
	[connectingLabel setHidden: NO];
	[waitingLabel setHidden: YES];
	[progress startAnimation: self];
	[NSApp beginSheet: window modalForWindow: parentWindow modalDelegate: nil didEndSelector: nil contextInfo: NULL];

	timer = [NSTimer scheduledTimerWithTimeInterval: 0.05 target: self selector: @selector(timer:) userInfo: nil repeats: YES];
	[[NSRunLoop currentRunLoop] addTimer: timer forMode: NSModalPanelRunLoopMode];

	[NSApp runModalForWindow: window];

	err = NULL;
	int ready = conn->ready(&err);
	if (ready > 0)
		return conn;
	delete conn;
	return NULL;
}

- (BTConnection*) accept {
	conn = new BTConnection([serviceUuid getSDPUUIDRef], (CFStringRef) serviceName, (CFStringRef) serviceDescription);
	conn->accept();

	nib = [[NSNib alloc] initWithNibNamed: @"BluetoothWait" bundle: [NSBundle mainBundle]];
	[nib instantiateNibWithOwner: self topLevelObjects: nil];
	[connectingLabel setHidden: YES];
	[waitingLabel setHidden: NO];
	[progress startAnimation: self];
	[NSApp beginSheet: window modalForWindow: parentWindow modalDelegate: nil didEndSelector: nil contextInfo: NULL];

	timer = [NSTimer scheduledTimerWithTimeInterval: 0.05 target: self selector: @selector(timer:) userInfo: nil repeats: YES];
	[[NSRunLoop currentRunLoop] addTimer: timer forMode: NSModalPanelRunLoopMode];

	[NSApp runModalForWindow: window];

	const char *err = NULL;
	int ready = conn->ready(&err);
	if (ready > 0)
		return conn;
	delete conn;
	return NULL;
}

- (id) init {
	if ((self = [super init]) != nil) {
		device = nil;
		parentWindow = nil;
		serviceUuid = nil;
		serviceName = nil;
		serviceDescription = nil;
	}
	return self;
}

- (void) dealloc {
	[serviceUuid release];
	[serviceName release];
	[serviceDescription release];
	[super dealloc];
}

- (void) setService: (IOBluetoothSDPUUID*) uuid {
	[serviceUuid release];
	serviceUuid = uuid;
	[serviceUuid retain];
}

- (void) setServiceName: (NSString*) name description: (NSString*) desc {
	[serviceName release];
	serviceName = name;
	[serviceName retain];
	[serviceDescription release];
	serviceDescription = desc;
	[serviceDescription retain];
}

- (void) setParentWindow: (NSWindow*) parent {
	parentWindow = parent;
}

- (IBAction) cancel: (id) sender {
	[timer invalidate];
	[NSApp endSheet: window];
	[window orderOut: self];
	[nib release];
	nib = nil;

	[NSApp stopModal];
}

- (void) postEmptyEvent {
	// post an empty event, otherwise the run loop sticks waiting for events without terminating immediately
	NSPoint point = { 0, 0 };
	[NSApp postEvent: [NSEvent otherEventWithType: NSApplicationDefined location: point modifierFlags: 0 timestamp: 0 windowNumber: 0 context: nil subtype: 0 data1: 0 data2: 0] atStart: YES];
}

- (void) timer: (NSTimer*) timerObj {
	const char *err = NULL;
	int ready = conn->ready(&err);
	if (ready != 0) {
		[self cancel: self];
		[self postEmptyEvent];

		if (ready > 0)
			return;

		showWarning(err);
	}
}
@end

Connection *showBluetoothDialog(BOOL client) {
	BluetoothGuiController* ui = [[BluetoothGuiController alloc] init];
	[ui setService: [IOBluetoothSDPUUID uuid32: 0x10273929]];
	[ui setServiceName: @"Bantumi GL" description: @"Bantumi GL multiplayer game"];
	[ui setParentWindow: getMainWindow()];


	unsetenv("SDL_ENABLEAPPEVENTS");
	BTConnection* conn = NULL;
	if (client) {
		conn = [ui connect];
	} else {
		conn = [ui accept];
	}
	setenv("SDL_ENABLEAPPEVENTS", "1", 1);

	[ui release];

	return conn;
}



