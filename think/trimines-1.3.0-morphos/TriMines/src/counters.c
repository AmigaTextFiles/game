/*
##########################################
#         TriMines version 1.3.0         #
#                                        #
#         counters.c - count things...   #
#                                        #
##########################################
*/

int countsomething(int i, int j,int a,int brd[66][26])
{
int z,count;

count = 0;



if (i == 1) {
	if (brd[i-1][j] == a){count++;}
	if (brd[i+1][j] == a){count++;}
	if (brd[i+2][j] == a){count++;}
	} else {
		if (i == 0) {
			if (brd[i+1][j] == a){count++;}
			if (brd[i+2][j] == a){count++;}
			} else {
				if (i == (boardx - 2)) {
							if (brd[i-1][j] == a){count++;}
							if (brd[i-2][j] == a){count++;}
							if (brd[i+1][j] == a){count++;}
							} else {
								if (i == boardx-1) {
										if (brd[i-1][j] == a){count++;}
										if (brd[i-2][j] == a){count++;}
										} else {
											if (brd[i-1][j] == a){count++;}
											if (brd[i-2][j] == a){count++;}
											if (brd[i+1][j] == a){count++;}
											if (brd[i+2][j] == a){count++;}
											}}}}


z = 0;
if ((j % 2) != 0){z = 1;}


if ((i % 2) == z){
// image

if (j > 0) {
		if (i == 0) {
				if (brd[i][j-1] == a){count++;}
				if (brd[i+1][j-1] == a){count++;}
				} else {
					if (i == boardx-1) {
							if (brd[i][j-1] == a){count++;}
							if (brd[i-1][j-1] == a){count++;}
							} else {
								if (brd[i][j-1] == a){count++;}
								if (brd[i-1][j-1] == a){count++;}
								if (brd[i+1][j-1] == a){count++;}
								}
									}
										}

if (j < boardy-1) {
		if (i == 0) {
				if (brd[i][j+1] == a){count++;}
				if (brd[i+1][j+1] == a){count++;}
				if (brd[i+2][j+1] == a){count++;}
				} else {
					if (i == boardx-1) {
							if (brd[i][j+1] == a){count++;}
							if (brd[i-1][j+1] == a){count++;}
							if (brd[i-2][j+1] == a){count++;}
							} else {
								if (i == (boardx-2)) {
									if (brd[i][j+1] == a){count++;}
									if (brd[i+1][j+1] == a){count++;}
									if (brd[i-1][j+1] == a){count++;}
									if (brd[i-2][j+1] == a){count++;}
									} else {
										if (i == 1) {
											if (brd[i][j+1] == a){count++;}
											if (brd[i-1][j+1] == a){count++;}
											if (brd[i+1][j+1] == a){count++;}
											if (brd[i+2][j+1] == a){count++;}
											} else {
												if (brd[i][j+1] == a){count++;}
												if (brd[i-1][j+1] == a){count++;}
												if (brd[i-2][j+1] == a){count++;}
												if (brd[i+1][j+1] == a){count++;}
												if (brd[i+2][j+1] == a){count++;}
												}
													}}}}

								
}
else
{
//image2

if (j < boardy-1) {
		if (i == 0) {
				if (brd[i][j+1] == a){count++;}
				if (brd[i+1][j+1] == a){count++;}
				} else {
					if (i == boardx-1) {
							if (brd[i][j+1] == a){count++;}
							if (brd[i-1][j+1] == a){count++;}
							} else {
								if (brd[i][j+1] == a){count++;}
								if (brd[i-1][j+1] == a){count++;}
								if (brd[i+1][j+1] == a){count++;}
								}
									}
										}

if (j > 0) {
		if (i == 0) {
				if (brd[i][j-1] == a){count++;}
				if (brd[i+1][j-1] == a){count++;}
				if (brd[i+2][j-1] == a){count++;}
				} else {
					if (i == boardx-1) {
							if (brd[i][j-1] == a){count++;}
							if (brd[i-1][j-1] == a){count++;}
							if (brd[i-2][j-1] == a){count++;}
							} else {
								if (i == (boardx-2)) {
									if (brd[i][j-1] == a){count++;}
									if (brd[i+1][j-1] == a){count++;}
									if (brd[i-1][j-1] == a){count++;}
									if (brd[i-2][j-1] == a){count++;}
									} else {
										if (i == 1) {
											if (brd[i][j-1] == a){count++;}
											if (brd[i-1][j-1] == a){count++;}
											if (brd[i+1][j-1] == a){count++;}
											if (brd[i+2][j-1] == a){count++;}
											} else {
												if (brd[i][j-1] == a){count++;}
												if (brd[i-1][j-1] == a){count++;}
												if (brd[i-2][j-1] == a){count++;}
												if (brd[i+1][j-1] == a){count++;}
												if (brd[i+2][j-1] == a){count++;}
												}
													}}}}





}


return count;


} //end of function
