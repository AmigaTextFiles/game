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

/* TCPGuiController */

#import "cocoa.h"

class TCPConnection;

@interface TCPGuiController : NSObject
{
	IBOutlet id connectButton;
	IBOutlet id hostButton;
	IBOutlet id host;
	IBOutlet id port;
	IBOutlet id progress;
	IBOutlet id window;


	BOOL started;
	BOOL failure;
	BOOL success;
	bool stop;
	NSString *hostString;
	const char *errString;
	int portNumber;
@public
	BOOL client;
	TCPConnection *conn;
}
- (IBAction) cancel: (id) sender;
- (IBAction) startConnect: (id) sender;
- (void) terminate: (id) sender;
- (void) close: (id) sender;
- (void) threadMain: (id) arg;
- (void) timer: (NSTimer*) timerObj;
@end
