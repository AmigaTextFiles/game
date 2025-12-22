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

#ifndef __BANTUMIDOC_H
#define __BANTUMIDOC_H

class CBantumiAppUi;
class CEikApplication;

#ifdef UIQ3
#include <qikdocument.h>
class CBantumiDocument : public CQikDocument {
#else
#include <akndoc.h>
class CBantumiDocument : public CAknDocument {
#endif
public:
	static CBantumiDocument* NewL(CEikApplication& aApp);
	static CBantumiDocument* NewLC(CEikApplication& aApp);
	~CBantumiDocument();
public:
	CEikAppUi* CreateAppUiL();

	CFileStore* OpenFileL(TBool aDoOpen, const TDesC& aFilename, RFs& aFs);
	void StoreL(CStreamStore& aStore, CStreamDictionary& aStreamDic) const;
	void RestoreL(const CStreamStore& aStore, const CStreamDictionary& aStreamDic);

private:
	void ConstructL();
	CBantumiDocument(CEikApplication& aApp);
};

#endif
