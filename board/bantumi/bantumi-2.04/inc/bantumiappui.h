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

#ifndef __BANTUMIAPPUI_H
#define __BANTUMIAPPUI_H

#include "glappui.h"

#ifdef UIQ3
#include <qikmenupopout.h>
#endif

class CBantumiAppView;
class CConnectionWrapper;

class CBantumiAppUi : public CGLAppUi {
public:
	void ConstructL();
	CBantumiAppUi();
	~CBantumiAppUi();

	void HandleCommandL(TInt aCommand);

	void SetEmphasis(CCoeControl* aMenuControl, TBool aEmphasis);

	void DoExit();

	void SetConnection(CConnectionWrapper* aConn);

	void ProcessCommandL(TInt aCommand);

	CBantumiAppView* AppView() const;

	const TDesC& GetHostname() const;
	TInt GetPortNumber() const;
	void SetHostname(const TDesC& aName);
	void SetPortNumber(TInt aNumber);

#ifdef UIQ3
	void ShowMenuL(TInt aResource);
	void HandleCommandL(CQikCommand& aCommand);
	static TInt StaticCallback(TAny* aPtr);
#endif

private:
	void DoSave();

	CConnectionWrapper* iConn;
	TBool iMenuSelected;
	TInt iConnectionType;

	TBuf<100> iHostname;
	TInt iPortNumber;

#ifdef UIQ3
	CQikMenuPopout* iMenuPopout;
	CPeriodic* iMenuClosedTimer;
#endif
};

#endif
