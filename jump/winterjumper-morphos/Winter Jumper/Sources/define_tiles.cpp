#include "_variables.h"


TileTypesDefinition TileTypes[1000];
SDL_Rect TileSrcRect[10000];
AnimationDefinition TileAnimation[1000];

void defineTiles()
{
	fprintf(stdout,"\nattempting to define tiles...\n");
	int j, i, k, l;

	for(j=1;j<34;j++)
	{
		for(i=1;i<25;i++)
		{
		k=(i-1)+(j-1)*24;
		if(k < 168){TileTypes[k].solid = 0;}
		if(k > 167){TileTypes[k].solid = 1;}
		
		TileSrcRect[k].x = (i-1)*8;
		TileSrcRect[k].y = (j-1)*8;
		TileSrcRect[k].w = 8;
		TileSrcRect[k].h = 8;
		//TileAnimation[k].animated = 0;
		//TileAnimation[k].nexttile = 0;
		TileTypes[k].isexit = 0;
		TileTypes[k].lethal = 0;
		}
	}
	
	// BEGIN ANIMATED STAR-TILE
	for(l=240;l<258;l++){TileAnimation[l].animated = 1;}
	for(l=264;l<282;l++){TileAnimation[l].animated = 1;}
	for(l=648;l<666;l++){TileAnimation[l].animated = 1;}
	for(l=672;l<690;l++){TileAnimation[l].animated = 1;}
	TileAnimation[240].nexttile = 243;	TileAnimation[241].nexttile = 244;	TileAnimation[242].nexttile = 245;
	TileAnimation[243].nexttile = 246;	TileAnimation[244].nexttile = 247;	TileAnimation[245].nexttile = 248;
	TileAnimation[246].nexttile = 249;	TileAnimation[247].nexttile = 250;	TileAnimation[248].nexttile = 251;
	TileAnimation[249].nexttile = 252;	TileAnimation[250].nexttile = 253;	TileAnimation[251].nexttile = 254;
	TileAnimation[252].nexttile = 255;	TileAnimation[253].nexttile = 256;	TileAnimation[254].nexttile = 257;
	TileAnimation[255].nexttile = 240;	TileAnimation[256].nexttile = 241;	TileAnimation[257].nexttile = 242;

	TileAnimation[264].nexttile = 267;	TileAnimation[265].nexttile = 268;	TileAnimation[266].nexttile = 269;
	TileAnimation[267].nexttile = 270;	TileAnimation[268].nexttile = 271;	TileAnimation[269].nexttile = 272;
	TileAnimation[270].nexttile = 273;	TileAnimation[271].nexttile = 274;	TileAnimation[272].nexttile = 275;
	TileAnimation[273].nexttile = 276;	TileAnimation[274].nexttile = 277;	TileAnimation[275].nexttile = 278;
	TileAnimation[276].nexttile = 279;	TileAnimation[277].nexttile = 280;	TileAnimation[278].nexttile = 281;
	TileAnimation[279].nexttile = 264;	TileAnimation[280].nexttile = 265;	TileAnimation[281].nexttile = 266;

	TileAnimation[648].nexttile = 651;	TileAnimation[649].nexttile = 652;	TileAnimation[650].nexttile = 653;
	TileAnimation[651].nexttile = 654;	TileAnimation[652].nexttile = 655;	TileAnimation[653].nexttile = 656;
	TileAnimation[654].nexttile = 657;	TileAnimation[655].nexttile = 658;	TileAnimation[656].nexttile = 659;
	TileAnimation[657].nexttile = 660;	TileAnimation[658].nexttile = 661;	TileAnimation[659].nexttile = 662;
	TileAnimation[660].nexttile = 663;	TileAnimation[661].nexttile = 664;	TileAnimation[662].nexttile = 665;
	TileAnimation[663].nexttile = 648;	TileAnimation[664].nexttile = 649;	TileAnimation[665].nexttile = 650;

	TileAnimation[672].nexttile = 675;	TileAnimation[673].nexttile = 676;	TileAnimation[674].nexttile = 677;
	TileAnimation[675].nexttile = 678;	TileAnimation[676].nexttile = 679;	TileAnimation[677].nexttile = 680;
	TileAnimation[678].nexttile = 681;	TileAnimation[679].nexttile = 682;	TileAnimation[680].nexttile = 683;
	TileAnimation[681].nexttile = 684;	TileAnimation[682].nexttile = 685;	TileAnimation[683].nexttile = 686;
	TileAnimation[684].nexttile = 687;	TileAnimation[685].nexttile = 688;	TileAnimation[686].nexttile = 689;
	TileAnimation[687].nexttile = 672;	TileAnimation[688].nexttile = 673;	TileAnimation[689].nexttile = 674;

	// BEGIN ANIMATED SPECIAL-STAR-TILE
	for(l=456;l<471;l++){TileAnimation[l].animated = 1;}
	for(l=480;l<495;l++){TileAnimation[l].animated = 1;}
	for(l=516;l<519;l++){TileAnimation[l].animated = 1;}
	for(l=540;l<543;l++){TileAnimation[l].animated = 1;}

	TileAnimation[456].nexttile = 459;	TileAnimation[457].nexttile = 460;	TileAnimation[458].nexttile = 461;
	TileAnimation[459].nexttile = 462;	TileAnimation[460].nexttile = 463;	TileAnimation[461].nexttile = 464;
	TileAnimation[462].nexttile = 465;	TileAnimation[463].nexttile = 466;	TileAnimation[464].nexttile = 467;	
	TileAnimation[465].nexttile = 468;	TileAnimation[466].nexttile = 469;	TileAnimation[467].nexttile = 470;
	TileAnimation[468].nexttile = 516;	TileAnimation[469].nexttile = 517;	TileAnimation[470].nexttile = 518;
	TileAnimation[516].nexttile = 456;	TileAnimation[517].nexttile = 457;	TileAnimation[518].nexttile = 458;

	TileAnimation[480].nexttile = 483;	TileAnimation[481].nexttile = 484;	TileAnimation[482].nexttile = 485;
	TileAnimation[483].nexttile = 486;	TileAnimation[484].nexttile = 487;	TileAnimation[485].nexttile = 488;	
	TileAnimation[486].nexttile = 489;	TileAnimation[487].nexttile = 490;	TileAnimation[488].nexttile = 491;	
	TileAnimation[489].nexttile = 492;	TileAnimation[490].nexttile = 493;	TileAnimation[491].nexttile = 494;
	TileAnimation[492].nexttile = 540;	TileAnimation[493].nexttile = 541;	TileAnimation[494].nexttile = 542;
	TileAnimation[540].nexttile = 480;	TileAnimation[541].nexttile = 481;	TileAnimation[542].nexttile = 482;
	// END ANIMATED SPECIAL-STAR-TILE
	// END ANIMATED STAR-TILE

	// BEGIN CRUMBLING GROUND
	for(l=170;l<176;l++){TileAnimation[l].animated = 1;}
	TileAnimation[170].nexttile = 172;
	TileAnimation[171].nexttile = 173;
	TileAnimation[172].nexttile = 174;
	TileAnimation[173].nexttile = 175;
	TileAnimation[174].nexttile = 0;
	TileAnimation[175].nexttile = 0;
	// END CRUMBLING GROUND


	// BEGIN EXIT-TILE
	for(l=288;l<294;l++){TileTypes[l].solid = 0;}  
	for(l=312;l<318;l++){TileTypes[l].solid = 0;}  
	for(l=336;l<342;l++){TileTypes[l].solid = 0;}  
	for(l=360;l<366;l++){TileTypes[l].solid = 0;}  
	TileTypes[293].isexit = 1;  
	TileTypes[317].isexit = 1;  
	TileTypes[341].isexit = 1;  
	TileTypes[365].isexit = 1;  

	for(l=496;l<499;l++){TileTypes[l].solid = 0;}
	for(l=520;l<523;l++){TileTypes[l].solid = 0;}
	for(l=544;l<547;l++){TileTypes[l].solid = 0;}
	for(l=568;l<571;l++){TileTypes[l].solid = 0;}
	for(l=592;l<595;l++){TileTypes[l].solid = 0;}
	TileTypes[498].isexit = 1;
	TileTypes[522].isexit = 1;
	TileTypes[546].isexit = 1;
	TileTypes[580].isexit = 1;
	TileTypes[594].isexit = 1;


	for(l=696;l<702;l++){TileTypes[l].solid = 0;}
	for(l=720;l<726;l++){TileTypes[l].solid = 0;}
	for(l=744;l<750;l++){TileTypes[l].solid = 0;}
	for(l=768;l<774;l++){TileTypes[l].solid = 0;}
	TileTypes[701].isexit = 1;
	TileTypes[725].isexit = 1;
	TileTypes[749].isexit = 1;
	TileTypes[773].isexit = 1;
	// END EXIT-TILE

	//BEGIN LETHAL TILES
	TileTypes[789].solid = 0;
	TileTypes[790].solid = 0;
	TileTypes[791].solid = 0;
	TileTypes[789].lethal = 1;
	TileTypes[790].lethal = 1;
	TileTypes[791].lethal = 1;
	//END LETHAL TILES

	//BEGIN LETHAL TILES
	TileTypes[302].solid = 0;
	TileTypes[303].lethal = 1;
	TileTypes[304].solid = 0;
	TileTypes[326].lethal = 1;
	TileTypes[327].lethal = 1;
	TileTypes[328].lethal = 1;
	TileTypes[350].lethal = 1;
	TileTypes[351].lethal = 1;
	TileTypes[352].lethal = 1;
	//END LETHAL TILES

	//BEGIN BREAKABLE TILES
	TileTypes[192].breakable = 1;
	TileTypes[193].breakable = 1;
	TileTypes[194].breakable = 1;
	TileTypes[216].breakable = 1;
	TileTypes[217].breakable = 1;
	TileTypes[218].breakable = 1;
	TileTypes[600].breakable = 1;
	TileTypes[601].breakable = 1;
	TileTypes[602].breakable = 1;
	TileTypes[624].breakable = 1;
	TileTypes[625].breakable = 1;
	TileTypes[626].breakable = 1;

	TileAnimation[225].animated = 1;	TileAnimation[226].animated = 1;	TileAnimation[227].animated = 1;
	TileAnimation[228].animated = 1;	TileAnimation[229].animated = 1;	TileAnimation[230].animated = 1;
	TileAnimation[201].animated = 1;	TileAnimation[202].animated = 1;	TileAnimation[203].animated = 1;
	TileAnimation[204].animated = 1;	TileAnimation[205].animated = 1;	TileAnimation[206].animated = 1;
	TileAnimation[225].nexttile = 228;	TileAnimation[228].nexttile = 0;
	TileAnimation[226].nexttile = 229;	TileAnimation[229].nexttile = 0;
	TileAnimation[227].nexttile = 230;	TileAnimation[230].nexttile = 0;
	TileAnimation[201].nexttile = 204;	TileAnimation[204].nexttile = 0;
	TileAnimation[202].nexttile = 205;	TileAnimation[205].nexttile = 0;
	TileAnimation[203].nexttile = 206;	TileAnimation[206].nexttile = 0;

	//END BREAKABLE TILES

fprintf(stdout,"succesfully defined tiles...\n");
}
