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

#ifndef __SDPRECORD_H
#define __SDPRECORD_H

#include <stack>

using std::stack;

class SdpRecord {
public:
	SdpRecord();
	~SdpRecord();

	SdpRecord* addNil();

	SdpRecord* addUint8(unsigned char);
	SdpRecord* addUint16(unsigned short);
	SdpRecord* addUint32(unsigned int);
	SdpRecord* addUint64(unsigned long long);
	SdpRecord* addUint(unsigned long long);

	SdpRecord* addSint8(signed char);
	SdpRecord* addSint16(signed short);
	SdpRecord* addSint32(signed int);
	SdpRecord* addSint64(signed long long);
	SdpRecord* addSint(signed long long);

	SdpRecord* addUuid16(unsigned short);
	SdpRecord* addUuid32(unsigned int);
	SdpRecord* addUuid128(const unsigned char*);

	SdpRecord* addString(const char*);

	SdpRecord* addBoolean(bool);

	SdpRecord* addDES();
	SdpRecord* endDES();

	SdpRecord* addDEA();
	SdpRecord* endDEA();

	SdpRecord* addUrl(const char*);

	SdpRecord* startRecord();
	SdpRecord* endRecord();

	SdpRecord* addAttribute(unsigned int id);
	SdpRecord* endAttribute();

	const unsigned char* getData();
	int getLength();

private:
	class Context {
	public:
		Context(int l);
		Context(const Context& c);
		Context& operator=(const Context& c);
		~Context();
		void assureSpace(int s);
		void writeByte(unsigned char b);
		void writeBytes(const unsigned char* bytes, int len);
		const unsigned char* getData();
		int getLength();

	private:
		unsigned char* array;
		int pos;
		int len;
	};

	stack<Context> contexts;
	Context& top();
	void writeType(int type, int size);
	void writeUint8(unsigned char value);
	void writeUint16(unsigned short value);
	void writeUint32(unsigned int value);
	void writeData(int type, const unsigned char* data, int len);
};

#endif
