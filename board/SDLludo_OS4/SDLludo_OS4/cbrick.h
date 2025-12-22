#ifndef CBRICK_H
#define CBRICK_H

class cbrick {
	public:
		cbrick();
		~cbrick();

		bool doMove(int target);
		void set(int pnumber, int bnumber);
		int field,
			playernumber,
			bricknumber,
			fieldsmoved;
		bool home;
};

#endif
