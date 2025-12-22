#include "cbrick.h"
#include <stdio.h>

cbrick::cbrick() {
}

void cbrick::set(int pnumber, int bnumber) {
	playernumber = pnumber;
	bricknumber = bnumber;
	field = 0;
	home = false;
	fieldsmoved = 0;
}

cbrick::~cbrick() {
}

bool cbrick::doMove(int target) {
	if (field == 0 && target == 6) {
		switch (playernumber) {
			case 1: field = 1; break;
			case 2: field = 14; break;
			case 3: field = 27; break;
			case 4: field = 40; break;
		}
	} else {
		fieldsmoved += target;
		if (fieldsmoved >= 52) {
			switch(playernumber) {
				case 1: field = fieldsmoved + 2; break;
				case 2: field = 58 + fieldsmoved - 50; break;
				case 3: field = 64 + fieldsmoved - 50; break;
				case 4: field = 70 + fieldsmoved - 50; break;
			}
		} 
		if (field + target > 52 && playernumber != 1) {
			field = (field+target)-52;
		} else {
			field = field + target;
		}
	}

	// If brick is on a star then jump to next
	//--------------------------------------------
	switch (field) {
		case 6:
			field = 12;
			fieldsmoved += 6;
			break;

		case 12:
			field = 19;
			fieldsmoved += 7;
			if (playernumber == 2) {
				home = true;
			}
			break;

		case 19:
			field = 25;
			fieldsmoved += 6;
			break;

		case 25:
			field = 32;
			fieldsmoved += 7;
			if (playernumber == 3) {
				home = true;
			}
			break;

		case 32:
			field = 38;
			fieldsmoved += 6;
			break;

		case 38:
			field = 45;
			fieldsmoved += 7;
			if (playernumber == 4) {
				home = true;
			}
			break;

		case 45:
			field = 51;
			fieldsmoved += 6;
			break;

		case 51:
			field = 6;
			fieldsmoved += 7;
			if (playernumber == 1) {
				home = true;
			}
			break;
	}

	switch(playernumber) {
		case 1:
  			if (fieldsmoved > 57) {
     			home = true;
        	} else if (fieldsmoved > 50) {
        		field = 52 + fieldsmoved - 50;
        		if (field > 58) {
        			home = true;
    			}
        		//fprintf(stderr, "Field: %d\n", field);
         	}
          	break;

		case 2:
  			if (fieldsmoved > 57) {
     			home = true;
        	} else if (fieldsmoved > 50) {
        		field = 58 + fieldsmoved - 50;
        		if (field > 64) {
        			home = true;
    			}
        		//fprintf(stderr, "Field: %d\n", field);
         	}
          	break;

		case 3:
  			if (fieldsmoved > 57) {
     			home = true;
        	} else if (fieldsmoved > 50) {
        		field = 64 + fieldsmoved - 50;
        		if (field > 70) {
        			home = true;
    			}
        		//fprintf(stderr, "Field: %d\n", field);
         	}
          	break;

		case 4:
  			if (fieldsmoved > 57) {
     			home = true;
        	} else if (fieldsmoved > 50) {
        		field = 70 + fieldsmoved - 50;
        		if (field > 76) {
        			home = true;
    			}
        		//fprintf(stderr, "Field: %d\n", field);
         	}
          	break;
	}

	if (home) {
		printf("\tPlayer %d brick %d came home using a star.\n", playernumber, bricknumber);
		return true;
	}

	return false;
}
