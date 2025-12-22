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

#include "bantumiapp.h"
#include "bantumidoc.h"

EXPORT_C CApaApplication* NewApplication() {
	return static_cast<CApaApplication*>(new CBantumiApplication());
}

CApaDocument* CBantumiApplication::CreateDocumentL() {
	return static_cast<CApaDocument*>(CBantumiDocument::NewL(*this));
}

TUid CBantumiApplication::AppDllUid() const {
	return KUidBantumiApp;
}

#ifdef EKA2
#include <eikstart.h>

GLDEF_C TInt E32Main() {
	return EikStart::RunApplication(NewApplication);
}

#else

GLDEF_C TInt E32Dll(TDllReason aReason) {
	return KErrNone;
}

#endif

