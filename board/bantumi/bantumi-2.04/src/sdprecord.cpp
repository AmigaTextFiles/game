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

#include "sdprecord.h"
#include <string.h>

#define SDP_TYPE_NIL	0
#define SDP_TYPE_UINT	1
#define SDP_TYPE_SINT	2
#define SDP_TYPE_UUID	3
#define SDP_TYPE_STRING	4
#define SDP_TYPE_BOOL	5
#define SDP_TYPE_DES	6
#define SDP_TYPE_DEA	7
#define SDP_TYPE_URL	8

#define SDP_TYPE_SHIFT	3

#define SDP_SIZE_1	0
#define SDP_SIZE_2	1
#define SDP_SIZE_4	2
#define SDP_SIZE_8	3
#define SDP_SIZE_16	4
#define SDP_SIZE_8BIT	5
#define SDP_SIZE_16BIT	6
#define SDP_SIZE_32BIT	7

SdpRecord::SdpRecord() {
	contexts.push(Context(200));
}

SdpRecord::~SdpRecord() {
}

SdpRecord* SdpRecord::addNil() {
	writeType(SDP_TYPE_NIL, 0);
	return this;
}

SdpRecord* SdpRecord::addUint8(unsigned char val) {
	writeType(SDP_TYPE_UINT, SDP_SIZE_1);
	writeUint8(val);
	return this;
}

SdpRecord* SdpRecord::addUint16(unsigned short val) {
	writeType(SDP_TYPE_UINT, SDP_SIZE_2);
	writeUint16(val);
	return this;
}

SdpRecord* SdpRecord::addUint32(unsigned int val) {
	writeType(SDP_TYPE_UINT, SDP_SIZE_4);
	writeUint32(val);
	return this;
}

SdpRecord* SdpRecord::addUint64(unsigned long long val) {
	writeType(SDP_TYPE_UINT, SDP_SIZE_8);
	writeUint32((val >> 32) & 0xffffffff);
	writeUint32((val >> 0) & 0xffffffff);
	return this;
}

SdpRecord* SdpRecord::addUint(unsigned long long val) {
	if (val <= 0xFF)
		return addUint8(val);
	else if (val <= 0xFFFF)
		return addUint16(val);
	else if (val <= 0xFFFFFFFF)
		return addUint32(val);
	else
		return addUint64(val);
}

SdpRecord* SdpRecord::addSint8(signed char val) {
	writeType(SDP_TYPE_SINT, SDP_SIZE_1);
	writeUint8(val);
	return this;
}

SdpRecord* SdpRecord::addSint16(signed short val) {
	writeType(SDP_TYPE_SINT, SDP_SIZE_2);
	writeUint16(val);
	return this;
}

SdpRecord* SdpRecord::addSint32(signed int val) {
	writeType(SDP_TYPE_SINT, SDP_SIZE_4);
	writeUint32(val);
	return this;
}

SdpRecord* SdpRecord::addSint64(signed long long val) {
	writeType(SDP_TYPE_SINT, SDP_SIZE_8);
	writeUint32((val >> 32) & 0xffffffff);
	writeUint32((val >> 0) & 0xffffffff);
	return this;
}

SdpRecord* SdpRecord::addSint(signed long long val) {
	if (-0x80 <= val && val <= 0x7F)
		return addSint8(val);
	else if (-0x8000 <= val && val <= 0x7FFF)
		return addSint16(val);
	else if (-0x80000000 <= val && val <= 0x7FFFFFFF)
		return addSint32(val);
	else
		return addSint64(val);
}

SdpRecord* SdpRecord::addUuid16(unsigned short uuid) {
	writeType(SDP_TYPE_UUID, SDP_SIZE_2);
	writeUint16(uuid);
	return this;
}

SdpRecord* SdpRecord::addUuid32(unsigned int uuid) {
	writeType(SDP_TYPE_UUID, SDP_SIZE_4);
	writeUint32(uuid);
	return this;
}

SdpRecord* SdpRecord::addUuid128(const unsigned char* uuid) {
	writeType(SDP_TYPE_UUID, SDP_SIZE_16);
	top().writeBytes(uuid, 16);
	return this;
}

SdpRecord* SdpRecord::addString(const char* str) {
	writeData(SDP_TYPE_STRING, (const unsigned char*) str, strlen(str));
	return this;
}

SdpRecord* SdpRecord::addBoolean(bool val) {
	writeType(SDP_TYPE_BOOL, SDP_SIZE_1);
	writeUint8(val ? 1 : 0);
	return this;
}

SdpRecord* SdpRecord::addDES() {
	contexts.push(Context(200));
	return this;
}

SdpRecord* SdpRecord::endDES() {
	Context child = top();
	contexts.pop();
	writeData(SDP_TYPE_DES, child.getData(), child.getLength());
	return this;
}

SdpRecord* SdpRecord::addDEA() {
	contexts.push(Context(200));
	return this;
}

SdpRecord* SdpRecord::endDEA() {
	Context child = top();
	contexts.pop();
	writeData(SDP_TYPE_DEA, child.getData(), child.getLength());
	return this;
}

SdpRecord* SdpRecord::addUrl(const char* url) {
	writeData(SDP_TYPE_URL, (const unsigned char*) url, strlen(url));
	return this;
}

SdpRecord* SdpRecord::startRecord() {
	return addDES();
}

SdpRecord* SdpRecord::endRecord() {
	return endDES();
}

SdpRecord* SdpRecord::addAttribute(unsigned int id) {
	return addUint16(id);
}

SdpRecord* SdpRecord::endAttribute() {
	return this;
}

const unsigned char* SdpRecord::getData() {
	return top().getData();
}

int SdpRecord::getLength() {
	return top().getLength();
}

SdpRecord::Context& SdpRecord::top() {
	return contexts.top();
}

void SdpRecord::writeType(int type, int size) {
	writeUint8((type << SDP_TYPE_SHIFT) | size);
}

void SdpRecord::writeUint8(unsigned char value) {
	top().writeByte(value);
}

void SdpRecord::writeUint16(unsigned short value) {
	top().writeByte((value >> 8) & 0xff);
	top().writeByte((value >> 0) & 0xff);
}

void SdpRecord::writeUint32(unsigned int value) {
	top().writeByte((value >> 24) & 0xff);
	top().writeByte((value >> 16) & 0xff);
	top().writeByte((value >> 8) & 0xff);
	top().writeByte((value >> 0) & 0xff);
}

void SdpRecord::writeData(int type, const unsigned char* data, int len) {
	if (len <= 0xff) {
		writeType(type, SDP_SIZE_8BIT);
		writeUint8(len);
	} else if (len <= 0xffff) {
		writeType(type, SDP_SIZE_16BIT);
		writeUint16(len);
	} else {
		writeType(type, SDP_SIZE_32BIT);
		writeUint32(len);
	}
	top().writeBytes(data, len);
}



SdpRecord::Context::Context(int l) {
	array = new unsigned char[l];
	pos = 0;
	len = l;
}

SdpRecord::Context::Context(const Context& c) {
	pos = c.pos;
	len = c.len;
	array = new unsigned char[len];
	memcpy(array, c.array, len);
}

SdpRecord::Context& SdpRecord::Context::operator=(const Context& c) {
	pos = c.pos;
	len = c.len;
	delete [] array;
	array = new unsigned char[len];
	memcpy(array, c.array, len);
	return *this;
}

SdpRecord::Context::~Context() {
	delete [] array;
}

void SdpRecord::Context::assureSpace(int s) {
	if (pos + s <= len)
		return;
	while (pos + s > len) {
		len *= 2;
	}
	unsigned char* newarray = new unsigned char[len];
	memcpy(newarray, array, pos);
	delete [] array;
	array = newarray;
}

void SdpRecord::Context::writeByte(unsigned char b) {
	assureSpace(1);
	array[pos++] = b;
}

void SdpRecord::Context::writeBytes(const unsigned char* bytes, int len) {
	assureSpace(len);
	memcpy(&array[pos], bytes, len);
	pos += len;
}

const unsigned char* SdpRecord::Context::getData() {
	return array;
}

int SdpRecord::Context::getLength() {
	return pos;
}


