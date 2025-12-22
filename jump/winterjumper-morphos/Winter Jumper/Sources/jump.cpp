#include "_variables.h"

void jumpUp()
	{
		for(RepeatCounter = 0; RepeatCounter < 3; RepeatCounter++)
		{
		getCurrentTile();
		if(TileTypes[TileArray[CurrentTileTopX[1]][CurrentTileTopY[1]]].solid == 1 ||
			TileTypes[TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]]].solid == 1 ||
			TileTypes[TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]]].solid == 1 ||
			TileTypes[TileArray[CurrentTileTopX[4]][CurrentTileTopY[4]]].solid == 1)
		{Giana.jumpcounter = 0; Giana.y++;}

		if(TileTypes[TileArray[CurrentTileTopX[1]][CurrentTileTopY[1]]].solid == 0 &&
			TileTypes[TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]]].solid == 0 &&
			TileTypes[TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]]].solid == 0 &&
			TileTypes[TileArray[CurrentTileTopX[4]][CurrentTileTopY[4]]].solid == 0)
		{
				Giana.y--;
				Giana.jumpcounter--;
				if(Giana.y < 0){Giana.y = 0;}
				if(Giana.jumpcounter < 1){Giana.jumpcounter=0;}
		}
		

		// *** HITTING A DESTRUCTABLE BLOCK BLOCK ***
		if(Giana.weapon > 0)
		{
		if(CurrentTileTopX[2] < 2){CurrentTileTopX[2] = 2;} // prevents crashes
		if(CurrentTileTopX[4] < 2){CurrentTileTopX[2] = 2;} // prevents crashes
		if(CurrentTileTopX[1] < 2){CurrentTileTopX[2] = 2;} // prevents crashes

		if(TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 217 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 625)
		{
			TileArray[CurrentTileTopX[2]]  [CurrentTileTopY[2]] = 226;
			TileArray[CurrentTileTopX[2]-1][CurrentTileTopY[2]] = 225;
			TileArray[CurrentTileTopX[2]+1][CurrentTileTopY[2]] = 227;
			TileArray[CurrentTileTopX[2]]  [CurrentTileTopY[2]-1] = 202;
			TileArray[CurrentTileTopX[2]-1][CurrentTileTopY[2]-1] = 201;
			TileArray[CurrentTileTopX[2]+1][CurrentTileTopY[2]-1] = 203;
			Giana.jumpcounter = 0;
			Giana.y++;

		}
		
		if(TileArray[CurrentTileTopX[4]][CurrentTileTopY[2]] == 217 ||
			TileArray[CurrentTileTopX[4]][CurrentTileTopY[2]] == 625)
		{
			TileArray[CurrentTileTopX[4]]  [CurrentTileTopY[2]] = 226;
			TileArray[CurrentTileTopX[4]-1][CurrentTileTopY[2]] = 225;
			TileArray[CurrentTileTopX[4]+1][CurrentTileTopY[2]] = 227;
			TileArray[CurrentTileTopX[4]]  [CurrentTileTopY[2]-1] = 202;
			TileArray[CurrentTileTopX[4]-1][CurrentTileTopY[2]-1] = 201;
			TileArray[CurrentTileTopX[4]+1][CurrentTileTopY[2]-1] = 203;
			Giana.jumpcounter = 0;
			Giana.y++;

		}

		if(TileArray[CurrentTileTopX[1]][CurrentTileTopY[2]] == 217 ||
			TileArray[CurrentTileTopX[1]][CurrentTileTopY[2]] == 625)
		{
			TileArray[CurrentTileTopX[1]]  [CurrentTileTopY[2]] = 226;
			TileArray[CurrentTileTopX[1]-1][CurrentTileTopY[2]] = 225;
			TileArray[CurrentTileTopX[1]+1][CurrentTileTopY[2]] = 227;
			TileArray[CurrentTileTopX[1]]  [CurrentTileTopY[2]-1] = 202;
			TileArray[CurrentTileTopX[1]-1][CurrentTileTopY[2]-1] = 201;
			TileArray[CurrentTileTopX[1]+1][CurrentTileTopY[2]-1] = 203;
			Giana.jumpcounter = 0;
			Giana.y++;

		}
		}

		// *** HITTING THE BLING BLOCK ***
		if(	TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 265 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 268 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 271 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 274 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 277 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 280)
		{
			TileArray[CurrentTileTopX[2]-1][CurrentTileTopY[2]-1] = 207;
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]-1] = 208;
			TileArray[CurrentTileTopX[2]+1][CurrentTileTopY[2]-1] = 209;
			TileArray[CurrentTileTopX[2]-1][CurrentTileTopY[2]] = 231;
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] = 232;
			TileArray[CurrentTileTopX[2]+1][CurrentTileTopY[2]] = 233;
			intBonus++;
			intPoints += POINTSPERBLING;
			setBling((CurrentTileTopX[2])*8, Giana.y - 24);
		}

		// *** HITTING THE BLING BLOCK ***
		if(	TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]] == 265 ||
			TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]] == 268 ||
			TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]] == 271 ||
			TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]] == 274 ||
			TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]] == 277 ||
			TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]] == 280)
		{
			TileArray[CurrentTileTopX[3]-1][CurrentTileTopY[3]-1] = 207;
			TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]-1] = 208;
			TileArray[CurrentTileTopX[3]+1][CurrentTileTopY[3]-1] = 209;
			TileArray[CurrentTileTopX[3]-1][CurrentTileTopY[3]] = 231;
			TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]] = 232;
			TileArray[CurrentTileTopX[3]+1][CurrentTileTopY[3]] = 233;
			intBonus++;
			intPoints += POINTSPERBLING;
			setBling((CurrentTileTopX[3])*8, Giana.y - 24);
		}

		// *** HITTING THE BLING BLOCK ***
		if(	TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 673 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 676 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 679 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 682 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 685 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 688)
		{
			TileArray[CurrentTileTopX[2]-1][CurrentTileTopY[2]-1] = 615;
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]-1] = 616;
			TileArray[CurrentTileTopX[2]+1][CurrentTileTopY[2]-1] = 617;
			TileArray[CurrentTileTopX[2]-1][CurrentTileTopY[2]] = 639;
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] = 640;
			TileArray[CurrentTileTopX[2]+1][CurrentTileTopY[2]] = 641;
			intBonus++;
			intPoints += POINTSPERBLING;
			setBling((CurrentTileTopX[2])*8, Giana.y - 24);
		}

		// *** HITTING THE BLING BLOCK ***
		if(	TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]] == 673 ||
			TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]] == 676 ||
			TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]] == 679 ||
			TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]] == 682 ||
			TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]] == 685 ||
			TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]] == 688)
		{
			TileArray[CurrentTileTopX[3]-1][CurrentTileTopY[3]-1] = 615;
			TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]-1] = 616;
			TileArray[CurrentTileTopX[3]+1][CurrentTileTopY[3]-1] = 617;
			TileArray[CurrentTileTopX[3]-1][CurrentTileTopY[3]] = 639;
			TileArray[CurrentTileTopX[3]][CurrentTileTopY[3]] = 640;
			TileArray[CurrentTileTopX[3]+1][CurrentTileTopY[3]] = 641;
			intBonus++;
			setBling((CurrentTileTopX[3])*8, Giana.y - 24);
		}

		// *** HITTING THE GOODIE BLOCK ***
		if(	TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 481 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 484 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 487 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 490 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 493 ||
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] == 541)
		{
			TileArray[CurrentTileTopX[2]-1][CurrentTileTopY[2]-1] = 207;
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]-1] = 208;
			TileArray[CurrentTileTopX[2]+1][CurrentTileTopY[2]-1] = 209;
			TileArray[CurrentTileTopX[2]-1][CurrentTileTopY[2]] = 231;
			TileArray[CurrentTileTopX[2]][CurrentTileTopY[2]] = 232;
			TileArray[CurrentTileTopX[2]+1][CurrentTileTopY[2]] = 233;
			//intBonus++;
			//setBling((CurrentTileTopX[3])*8, Giana.y - 24);
			
			GoodieX = CurrentTileTopX[2] * 8 - 6;
			GoodieY = Giana.y - 31;
		}

	}
	if(Giana.y < 1){Giana.jumpcounter = 0;}
}

