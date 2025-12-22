/*
 *  This file is part of Dune Legacy.
 *
 *  Dune Legacy is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  Dune Legacy is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Dune Legacy.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef COMMANDMANAGER_H
#define COMMANDMANAGER_H

#include <Command.h>

#include <misc/Stream.h>

#include <vector>
#include <list>


class CommandManager {
public:
	CommandManager();
	virtual ~CommandManager();

	void setStream(Stream* pStream) { this->pStream = pStream; };

	Stream* getStream() { return pStream; };

	void setReadOnly(bool bReadOnly) { this->bReadOnly = bReadOnly; };

	bool getReadOnly() { return bReadOnly; };

	void save(Stream& stream) const;

	void load(Stream& stream);

	void addCommand(Command cmd);

	void addCommand(Command cmd, Uint32 CycleNumber);

	void executeCommands(Uint32 CycleNumber);

private:
	std::vector< std::list<Command> > timeslot;
	Stream* pStream;
	bool bReadOnly;
};

#endif // COMMANDMANAGER_H

