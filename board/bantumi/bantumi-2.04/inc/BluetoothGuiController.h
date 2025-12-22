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

#import <IOBluetoothUI/objc/IOBluetoothDeviceSelectorController.h>
#import <IOBluetooth/objc/IOBluetoothSDPUUID.h>
#import <IOBluetooth/objc/IOBluetoothRFCOMMChannel.h>
#include "connection.h"

class BTConnection;

@interface BluetoothGuiController : NSObject {
	IBOutlet id connectingLabel;
	IBOutlet id waitingLabel;
	IBOutlet id window;
	IBOutlet id progress;
	NSNib *nib;

	BTConnection* conn;
	IOBluetoothDevice *device;
	NSTimer* timer;

	NSWindow* parentWindow;

	IOBluetoothSDPUUID* serviceUuid;
	NSString* serviceName;
	NSString* serviceDescription;
}
- (id) init;
- (void) dealloc;
- (void) sheetDidEnd: (IOBluetoothDeviceSelectorController*) alert returnCode: (int) returnCode contextInfo: (void*) contextInfo;
- (BTConnection*) connect;
- (BTConnection*) accept;

- (void) setService: (IOBluetoothSDPUUID*) uuid;
- (void) setServiceName: (NSString*) name description: (NSString*) desc;
- (void) setParentWindow: (NSWindow*) window;

- (IBAction) cancel: (id) sender;
- (void) postEmptyEvent;
- (void) timer: (NSTimer*) timerObj;
@end


