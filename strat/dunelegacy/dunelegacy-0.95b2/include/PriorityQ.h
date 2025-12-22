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

#ifndef PRIORITYQ_H
#define PRIORITYQ_H

// forward declaration
class TerrainClass;
class Coord;

class PriorityQ
{
public:
	PriorityQ(int mx);            // constructor
	~PriorityQ();

	void trickleDown(int index);
	void trickleUp(int index);
	bool insertNode(TerrainClass* newNode);
	bool insertObject(void* newObject);
	TerrainClass* findNodeWithKey(Coord* location);
	TerrainClass* removeNode();           // delete item with max key
	void* remove();           // delete item with max key
	TerrainClass* removeNodeWithKey(Coord* location);

	inline bool isEmpty() { return (currentSize == 0); }

private:
	int currentSize,	// size of array
		maxSize;	// number of items in array

	TerrainClass** heapArray;
};

#endif // PRIORITYQ_H
