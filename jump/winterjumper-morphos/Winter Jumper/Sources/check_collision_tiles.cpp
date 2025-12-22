#include "_variables.h"

int CurrentTileTopX[5];
int CurrentTileTopY[5];
int CurrentTileBottomX[5];
int CurrentTileBottomY[5];
int CurrentTileRightX[6];
int CurrentTileRightY[6];
int CurrentTileLeftX[6];
int CurrentTileLeftY[6];

int MovementSpeed = 1;
int GravitySpeed = 3;
int SlideValue;
int RepeatCounter;

void checkTileCollission()
{
	if(Key_LEFT == 0 && Key_RIGHT == 0)
	{
		if(Giana.accelleration < 0){Giana.accelleration += 1;if(Giana.accelleration > 0){Giana.accelleration = 0;}}
		if(Giana.accelleration > 0){Giana.accelleration -= 1;if(Giana.accelleration < 0){Giana.accelleration = 0;}}
	}
	
	if(Key_LEFT == 1 || Giana.accelleration < 0)
	{
		Giana.xold = Giana.x;
		if(Key_LEFT == 1){Giana.accelleration--;}
		if(Giana.accelleration < -15){Giana.accelleration = -15;}
		if(Giana.accelleration == 0){SlideValue = 0;}
		if(Giana.accelleration < 0){SlideValue = 1;}
		if(Giana.accelleration < -7){SlideValue = 2;}
		if(Button_1 == 1){SlideValue++;}
		for(RepeatCounter = 0; RepeatCounter < SlideValue; RepeatCounter++)
		{
		getCurrentTile();
		if(TileTypes[TileArray[CurrentTileLeftX[1]][CurrentTileLeftY[1]]].solid == 0){
		if(TileTypes[TileArray[CurrentTileLeftX[2]][CurrentTileLeftY[2]]].solid == 0){
		if(TileTypes[TileArray[CurrentTileLeftX[3]][CurrentTileLeftY[3]]].solid == 0){
		if(TileTypes[TileArray[CurrentTileLeftX[4]][CurrentTileLeftY[4]]].solid == 0){
		if(TileTypes[TileArray[CurrentTileLeftX[5]][CurrentTileLeftY[5]]].solid == 0){
		Giana.x--;
		if(Giana.x < 0){Giana.x = 0;}
		}}}}}
		if(Giana.xold == Giana.x){Giana.accelleration = 0;}
		}
	}
	
	if(Key_RIGHT == 1 || Giana.accelleration > 0)
	{
		Giana.xold = Giana.x;
		if(Key_RIGHT == 1){Giana.accelleration++;}
		if(Giana.accelleration > 15){Giana.accelleration = 15;}
		if(Giana.accelleration == 0){SlideValue = 0;}
		if(Giana.accelleration > 0){SlideValue = 1;}
		if(Giana.accelleration > 7){SlideValue = 2;}
		if(Button_1 == 1){SlideValue++;}
		for(RepeatCounter = 0; RepeatCounter < SlideValue; RepeatCounter++)
		{
		getCurrentTile();
		if(TileTypes[TileArray[CurrentTileRightX[1]][CurrentTileRightY[1]]].solid == 0){
		if(TileTypes[TileArray[CurrentTileRightX[2]][CurrentTileRightY[2]]].solid == 0){
		if(TileTypes[TileArray[CurrentTileRightX[3]][CurrentTileRightY[3]]].solid == 0){
		if(TileTypes[TileArray[CurrentTileRightX[4]][CurrentTileRightY[4]]].solid == 0){
		if(TileTypes[TileArray[CurrentTileRightX[5]][CurrentTileRightY[5]]].solid == 0){
		Giana.x++;
		if(Giana.x > (-1) * LEVEL_XPos + 310){Giana.x = (-1) * LEVEL_XPos + 310;}
		}}}}}
		if(Giana.xold == Giana.x){Giana.accelleration = 0;}
		}
	}

	if(JumpKey == 1)//Key_UP == 1)// && JumpButtonRemainedPressed == 0)
	{
		if(Giana.onground == true)
			{
				Giana.jumpcounter = 86;
				Giana.onground = false;
			}
	}

	if(JumpKey == 0) //Key_UP == 0)
	{
		if(Giana.jumpcounter < 55){Giana.jumpcounter = 0;}
	}


	if(Key_DOWN == 1)
	{

	}
	//CheckDiamondCollision();
}


void addGravity()
{
		for(RepeatCounter = 0; RepeatCounter < GravitySpeed; RepeatCounter++)
		{
			if(GianaDied==0)
			{
				getCurrentTile();
				{
				Giana.onground = true;
				//Key_UP = 0;
				if(TileTypes[TileArray[CurrentTileBottomX[1]][CurrentTileBottomY[1]]].solid == 0){
				if(TileTypes[TileArray[CurrentTileBottomX[2]][CurrentTileBottomY[2]]].solid == 0){
				if(TileTypes[TileArray[CurrentTileBottomX[3]][CurrentTileBottomY[3]]].solid == 0){
				if(TileTypes[TileArray[CurrentTileBottomX[4]][CurrentTileBottomY[4]]].solid == 0){
					Giana.y++;
					Giana.onground = false;
						if(Giana.y > 219)
						{
							Giana.y = 219;
							Giana.onground = 1;
						}
				}}}}
				if(TileArray[CurrentTileBottomX[1]][CurrentTileBottomY[1]]==168){TileArray[CurrentTileBottomX[1]][CurrentTileBottomY[1]]=170;}
				if(TileArray[CurrentTileBottomX[1]][CurrentTileBottomY[1]]==169){TileArray[CurrentTileBottomX[1]][CurrentTileBottomY[1]]=171;}
				if(TileArray[CurrentTileBottomX[2]][CurrentTileBottomY[2]]==168){TileArray[CurrentTileBottomX[2]][CurrentTileBottomY[2]]=170;}
				if(TileArray[CurrentTileBottomX[2]][CurrentTileBottomY[2]]==169){TileArray[CurrentTileBottomX[2]][CurrentTileBottomY[2]]=171;}
				if(TileArray[CurrentTileBottomX[3]][CurrentTileBottomY[3]]==168){TileArray[CurrentTileBottomX[3]][CurrentTileBottomY[3]]=170;}
				if(TileArray[CurrentTileBottomX[3]][CurrentTileBottomY[3]]==169){TileArray[CurrentTileBottomX[3]][CurrentTileBottomY[3]]=171;}
				if(TileArray[CurrentTileBottomX[4]][CurrentTileBottomY[4]]==168){TileArray[CurrentTileBottomX[4]][CurrentTileBottomY[4]]=170;}
				if(TileArray[CurrentTileBottomX[4]][CurrentTileBottomY[4]]==169){TileArray[CurrentTileBottomX[4]][CurrentTileBottomY[4]]=171;}
			}
		}
	}
}

void getCurrentTile()
{
/* width = 15  */
/* height = 21 */

CurrentTileTopX[1] = ((Giana.x + 0) / 8); 
CurrentTileTopY[1] = ((Giana.y - 0) / 8); //0
CurrentTileTopX[2] = ((Giana.x + 5) / 8); 
CurrentTileTopY[2] = ((Giana.y - 0) / 8); //5
CurrentTileTopX[3] = ((Giana.x + 10) / 8); 
CurrentTileTopY[3] = ((Giana.y - 0) / 8); //10
CurrentTileTopX[4] = ((Giana.x + 14) / 8); 
CurrentTileTopY[4] = ((Giana.y - 0) / 8); //15

CurrentTileBottomX[1] = ((Giana.x + 0) / 8); 
CurrentTileBottomY[1] = ((Giana.y + 21) / 8); //0
CurrentTileBottomX[2] = ((Giana.x + 5) / 8); 
CurrentTileBottomY[2] = ((Giana.y + 21) / 8); //5
CurrentTileBottomX[3] = ((Giana.x + 10) / 8); 
CurrentTileBottomY[3] = ((Giana.y + 21) / 8); //10
CurrentTileBottomX[4] = ((Giana.x + 14) / 8); 
CurrentTileBottomY[4] = ((Giana.y + 21) / 8); //15

CurrentTileLeftX[1] = ((Giana.x - 1) / 8);
CurrentTileLeftY[1] = ((Giana.y + 0) / 8); //0
CurrentTileLeftX[2] = ((Giana.x - 1) / 8);
CurrentTileLeftY[2] = ((Giana.y + 5) / 8); //5
CurrentTileLeftX[3] = ((Giana.x - 1) / 8);
CurrentTileLeftY[3] = ((Giana.y + 10) / 8); //10
CurrentTileLeftX[4] = ((Giana.x - 1) / 8);
CurrentTileLeftY[4] = ((Giana.y + 15) / 8); //15
CurrentTileLeftX[5] = ((Giana.x - 1) / 8);
CurrentTileLeftY[5] = ((Giana.y + 20) / 8); //21

CurrentTileRightX[1] = ((Giana.x + 15) / 8);
CurrentTileRightY[1] = ((Giana.y + 0) / 8);  //0
CurrentTileRightX[2] = ((Giana.x + 15) / 8);
CurrentTileRightY[2] = ((Giana.y + 5) / 8);  //5
CurrentTileRightX[3] = ((Giana.x + 15) / 8);
CurrentTileRightY[3] = ((Giana.y + 10) / 8); //10
CurrentTileRightX[4] = ((Giana.x + 15) / 8);
CurrentTileRightY[4] = ((Giana.y + 15) / 8); //15
CurrentTileRightX[5] = ((Giana.x + 15) / 8);
CurrentTileRightY[5] = ((Giana.y + 20) / 8); //21

}
