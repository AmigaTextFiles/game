#include "3dc.h"
#include "inline.h"
#include "module.h"
#include "stratdef.h"
#include "gamedef.h"
#include "bh_types.h"
#include "pldnet.h"

#include "avp_mp_config.h"
#include "avp_envinfo.h"

#include "avp_menus.h"
#include "list_tem.hpp"

#define UseLocalAssert Yes
#include "ourasert.h"

#include "fixer.h"


extern "C"
{
extern void SetDefaultMultiplayerConfig();
extern char MP_SessionName[];
extern char MP_Config_Description[];

#define MP_CONFIG_DIR "MPConfig/"
#define MP_CONFIG_WILDCARD "*.cfg"

#define SKIRMISH_CONFIG_WILDCARD "*.skirmish_cfg"

static List<char*> ConfigurationFilenameList;
static List<char*> ConfigurationLocalisedFilenameList;
char* LastDescriptionFile=0;
char* LastDescriptionText=0;


AVPMENU_ELEMENT* AvPMenu_Multiplayer_LoadConfig=0;

BOOL BuildLoadMPConfigMenu()
{

	int i;
	
	//delete the old list of filenames
	while(ConfigurationFilenameList.size())
	{
		delete [] ConfigurationFilenameList.first_entry();
		ConfigurationFilenameList.delete_first_entry();
	}
	while(ConfigurationLocalisedFilenameList.size())
	{
		ConfigurationLocalisedFilenameList.delete_first_entry();
	}

	//do a search for all the configuration in the configuration directory
	
	const char* load_name=MP_CONFIG_WILDCARD;
	if(netGameData.skirmishMode)
	{
		load_name=SKIRMISH_CONFIG_WILDCARD;
	}
	
	void *gd;
	GameDirectoryFile *gdf;
	
	gd = OpenGameDirectory(MP_CONFIG_DIR, load_name, FILETYPE_CONFIG);
	if (gd == NULL) {
		CreateGameDirectory(MP_CONFIG_DIR); /* maybe it didn't exist.. */
		return FALSE;
	}
	
	while ((gdf = ScanGameDirectory(gd)) != NULL) {		
		if ((gdf->attr & FILEATTR_DIRECTORY) != 0)
			continue;
		if ((gdf->attr & FILEATTR_READABLE) == 0)
			continue;
				
		char* name=new char[strlen(gdf->filename)+1];
		strcpy(name,gdf->filename);
		char* dotpos=strrchr(name,'.');
		if(dotpos) *dotpos=0;
		
		ConfigurationFilenameList.add_entry(name);

		BOOL localisedFilename=FALSE;
			
		//seeif this is one of the default language localised configurations
		if(!strncmp(name,"Config",6))
		{
			if(name[6]>='1' && name[6]<='7' && name[7]=='\0')
			{
				TEXTSTRING_ID string_index=(TEXTSTRING_ID)(TEXTSTRING_MPCONFIG1_FILENAME+(name[6]-'1'));
				ConfigurationLocalisedFilenameList.add_entry(GetTextString(string_index));
				localisedFilename=TRUE;
			}
		}
		if(!localisedFilename)
		{
			ConfigurationLocalisedFilenameList.add_entry(name);
		}
	}
	
	CloseGameDirectory(gd);
	
	//delete the old menu
	if(AvPMenu_Multiplayer_LoadConfig) delete AvPMenu_Multiplayer_LoadConfig;

	AvPMenu_Multiplayer_LoadConfig=0;

	if(!ConfigurationFilenameList.size()) return FALSE;

	//create a new menu from the list of filenames
	AvPMenu_Multiplayer_LoadConfig=new AVPMENU_ELEMENT[ConfigurationFilenameList.size()+1];

	for(i=0;i<ConfigurationFilenameList.size();i++)
	{
		AvPMenu_Multiplayer_LoadConfig[i].ElementID=AVPMENU_ELEMENT_LOADMPCONFIG;	
		AvPMenu_Multiplayer_LoadConfig[i].a.TextDescription=TEXTSTRING_BLANK;	
		AvPMenu_Multiplayer_LoadConfig[i].b.MenuToGoTo=AVPMENU_MULTIPLAYER_CONFIG;	
		AvPMenu_Multiplayer_LoadConfig[i].c.TextPtr=ConfigurationLocalisedFilenameList[i];	
		AvPMenu_Multiplayer_LoadConfig[i].HelpString=TEXTSTRING_LOADMULTIPLAYERCONFIG_HELP; 
	}

	AvPMenu_Multiplayer_LoadConfig[i].ElementID=AVPMENU_ELEMENT_ENDOFMENU;	

	return TRUE;
}



const char* GetMultiplayerConfigDescription(int index)
{
	if(index<0 || index>= ConfigurationFilenameList.size()) return 0;
	const char* name = ConfigurationFilenameList[index];
	//see if we have already got the description for this file
	if(LastDescriptionFile)
	{
		if(!strcmp(LastDescriptionFile,name))
		{
			return LastDescriptionText;
		}
		else
		{
			delete [] LastDescriptionFile;
			delete [] LastDescriptionText;
			LastDescriptionFile=0;
			LastDescriptionText=0;
		}
	}

	LastDescriptionFile=new char[strlen(name)+1];
	strcpy(LastDescriptionFile,name);
	
	//seeif this is one of the default language localised configurations
	if(!strncmp(name,"Config",6))
	{
		if(name[6]>='1' && name[6]<='7' && name[7]=='\0')
		{
			TEXTSTRING_ID string_index=(TEXTSTRING_ID)(TEXTSTRING_MPCONFIG1_DESCRIPTION+(name[6]-'1'));
			LastDescriptionText=new char[strlen(GetTextString(string_index))+1];
			strcpy(LastDescriptionText,GetTextString(string_index));
			
			return LastDescriptionText;
		}
	}
	
	
	FILE* file;
	char filename[200];
	if(netGameData.skirmishMode)
		sprintf(filename,"%s%s.skirmish_cfg",MP_CONFIG_DIR,name);
	else
		sprintf(filename,"%s%s.cfg",MP_CONFIG_DIR,name);

	file= OpenGameFile(filename, FILEMODE_READONLY, FILETYPE_CONFIG);
	if(!file)
	{
		return 0;
	}

	//skip to the part of the file containing the description
	fseek(file,169,SEEK_SET);

	int description_length=0;
	fread(&description_length,sizeof(int),1,file);
	BYTESWAP4(description_length);
	
	if(description_length)
	{
		LastDescriptionText=new char[description_length];
		fread(LastDescriptionText,1,description_length,file);
	}

	fclose(file);
	
	return LastDescriptionText;
}

void LoadMultiplayerConfigurationByIndex(int index)
{
	if(index<0 || index>= ConfigurationFilenameList.size()) return;

	LoadMultiplayerConfiguration(ConfigurationFilenameList[index]);	
}



void LoadMultiplayerConfiguration(const char* name)
{
	FILE* file;
	char filename[200];
	if(netGameData.skirmishMode)
		sprintf(filename,"%s%s.skirmish_cfg",MP_CONFIG_DIR,name);
	else
		sprintf(filename,"%s%s.cfg",MP_CONFIG_DIR,name);

	file= OpenGameFile(filename, FILEMODE_READONLY, FILETYPE_CONFIG);
	if(!file) return;

		
	//set defaults first , in case there are entries not set by this file
	SetDefaultMultiplayerConfig();

	fread(&netGameData.gameType,sizeof(int),1,file);
	BYTESWAP4(netGameData.gameType);
	
	fread(&netGameData.levelNumber,sizeof(int),1,file);					BYTESWAP4(netGameData.levelNumber);
	fread(&netGameData.scoreLimit,sizeof(int),1,file);					BYTESWAP4(netGameData.scoreLimit);
	fread(&netGameData.timeLimit,sizeof(int),1,file);					BYTESWAP4(netGameData.timeLimit);
	fread(&netGameData.invulnerableTime,sizeof(int),1,file);			BYTESWAP4(netGameData.invulnerableTime);
	fread(&netGameData.characterKillValues[0],sizeof(int),1,file);		BYTESWAP4(netGameData.characterKillValues[0]);
	fread(&netGameData.characterKillValues[1],sizeof(int),1,file);		BYTESWAP4(netGameData.characterKillValues[1]);
	fread(&netGameData.characterKillValues[2],sizeof(int),1,file);		BYTESWAP4(netGameData.characterKillValues[2]);
	fread(&netGameData.baseKillValue,sizeof(int),1,file);				BYTESWAP4(netGameData.baseKillValue);
	fread(&netGameData.useDynamicScoring,sizeof(BOOL),1,file);			BYTESWAP4(netGameData.useDynamicScoring);
	fread(&netGameData.useCharacterKillValues,sizeof(BOOL),1,file);		BYTESWAP4(netGameData.useCharacterKillValues);

	fread(&netGameData.maxMarine,sizeof(int),1,file);					BYTESWAP4(netGameData.maxMarine);
	fread(&netGameData.maxAlien,sizeof(int),1,file);					BYTESWAP4(netGameData.maxAlien);
	fread(&netGameData.maxPredator,sizeof(int),1,file);					BYTESWAP4(netGameData.maxPredator);
	fread(&netGameData.maxMarineGeneral,sizeof(int),1,file);			BYTESWAP4(netGameData.maxMarineGeneral);
	fread(&netGameData.maxMarinePulseRifle,sizeof(int),1,file);			BYTESWAP4(netGameData.maxMarinePulseRifle);
	fread(&netGameData.maxMarineSmartgun,sizeof(int),1,file);			BYTESWAP4(netGameData.maxMarineSmartgun);
	fread(&netGameData.maxMarineFlamer,sizeof(int),1,file);				BYTESWAP4(netGameData.maxMarineFlamer);
	fread(&netGameData.maxMarineSadar,sizeof(int),1,file);				BYTESWAP4(netGameData.maxMarineSadar);
	fread(&netGameData.maxMarineGrenade,sizeof(int),1,file);			BYTESWAP4(netGameData.maxMarineGrenade);
	fread(&netGameData.maxMarineMinigun,sizeof(int),1,file);			BYTESWAP4(netGameData.maxMarineMinigun);

	fread(&netGameData.allowSmartgun,sizeof(BOOL),1,file);				BYTESWAP4(netGameData.allowSmartgun);
	fread(&netGameData.allowFlamer,sizeof(BOOL),1,file);				BYTESWAP4(netGameData.allowFlamer);
	fread(&netGameData.allowSadar,sizeof(BOOL),1,file);					BYTESWAP4(netGameData.allowSadar);
	fread(&netGameData.allowGrenadeLauncher,sizeof(BOOL),1,file);		BYTESWAP4(netGameData.allowGrenadeLauncher);
	fread(&netGameData.allowMinigun,sizeof(BOOL),1,file);				BYTESWAP4(netGameData.allowMinigun);
	fread(&netGameData.allowDisc,sizeof(BOOL),1,file);					BYTESWAP4(netGameData.allowDisc);
	fread(&netGameData.allowPistol,sizeof(BOOL),1,file);				BYTESWAP4(netGameData.allowPistol);
	fread(&netGameData.allowPlasmaCaster,sizeof(BOOL),1,file);			BYTESWAP4(netGameData.allowPlasmaCaster);
	fread(&netGameData.allowSpeargun,sizeof(BOOL),1,file);				BYTESWAP4(netGameData.allowSpeargun);
	fread(&netGameData.allowMedicomp,sizeof(BOOL),1,file);				BYTESWAP4(netGameData.allowMedicomp);
	fread(&MP_SessionName[0],sizeof(char),13,file);
	

	fread(&netGameData.maxLives,sizeof(int),1,file);					BYTESWAP4(netGameData.maxLives);
	fread(&netGameData.useSharedLives,sizeof(BOOL),1,file);				BYTESWAP4(netGameData.useSharedLives);

	fread(&netGameData.pointsForRespawn,sizeof(int),1,file);			BYTESWAP4(netGameData.pointsForRespawn);
	fread(&netGameData.timeForRespawn,sizeof(int),1,file);				BYTESWAP4(netGameData.timeForRespawn);

	fread(&netGameData.aiKillValues[0],sizeof(int),1,file);				BYTESWAP4(netGameData.aiKillValues[0]);
	fread(&netGameData.aiKillValues[1],sizeof(int),1,file);				BYTESWAP4(netGameData.aiKillValues[1]);
	fread(&netGameData.aiKillValues[2],sizeof(int),1,file);				BYTESWAP4(netGameData.aiKillValues[2]);

	fread(&netGameData.gameSpeed,sizeof(int),1,file);					BYTESWAP4(netGameData.gameSpeed);

	int description_length=0;
	fread(&description_length,sizeof(int),1,file);
	BYTESWAP4(description_length);

	fread(MP_Config_Description,1,description_length,file);

	fread(&netGameData.preDestroyLights,sizeof(BOOL),1,file);			BYTESWAP4(netGameData.preDestroyLights);
	fread(&netGameData.disableFriendlyFire,sizeof(BOOL),1,file);		BYTESWAP4(netGameData.disableFriendlyFire);
	fread(&netGameData.fallingDamage,sizeof(BOOL),1,file);				BYTESWAP4(netGameData.fallingDamage);
	#if LOAD_NEW_MPCONFIG_ENTRIES
	if(fread(&netGameData.maxMarineSmartDisc,sizeof(int),1,file) > 0)
		BYTESWAP4(netGameData.maxMarineSmartDisc);
		
	if(fread(&netGameData.maxMarinePistols,sizeof(int),1,file) > 0)
		BYTESWAP4(netGameData.maxMarinePistols);
		
	if(fread(&netGameData.allowSmartDisc,sizeof(BOOL),1,file) > 0)
		BYTESWAP4(netGameData.allowSmartDisc);
		
	if(fread(&netGameData.allowPistols,sizeof(BOOL),1,file) > 0)
		BYTESWAP4(netGameData.allowPistols);
		
	if(fread(&netGameData.pistolInfiniteAmmo,sizeof(BOOL),1,file) > 0)
		BYTESWAP4(netGameData.pistolInfiniteAmmo);
		
	if(fread(&netGameData.specialistPistols,sizeof(BOOL),1,file) > 0)
		BYTESWAP4(netGameData.specialistPistols);
	#endif

	//read the custom level name
	int length=0;
	fread(&length,sizeof(int),1,file);
	if(length)
	{
		BYTESWAP4(length);
		fread(netGameData.customLevelName,1,length,file);
	}
	else
	{
		netGameData.customLevelName[0] = 0;
	}
	
	fclose(file);

	//if the custom level name has been set , we need to find the index
	if(netGameData.customLevelName[0])
	{
		netGameData.levelNumber = GetCustomMultiplayerLevelIndex(netGameData.customLevelName,netGameData.gameType);

		if(netGameData.levelNumber <0)
		{
			//we don't have the level
			netGameData.levelNumber = 0;
			netGameData.customLevelName[0] = 0;
		}
	}
}

void SaveMultiplayerConfiguration(const char* name)
{
	FILE* file;
	char filename[200];
	if(netGameData.skirmishMode)
		sprintf(filename,"%s%s.skirmish_cfg",MP_CONFIG_DIR,name);
	else
		sprintf(filename,"%s%s.cfg",MP_CONFIG_DIR,name);
	
	
	file = OpenGameFile(filename, FILEMODE_WRITEONLY, FILETYPE_CONFIG);
	if (file == NULL) {
		CreateGameDirectory(MP_CONFIG_DIR); /* try again */
		file = OpenGameFile(filename, FILEMODE_WRITEONLY, FILETYPE_CONFIG);
		if (file == NULL)
			return;
	}
	
	NETGAME_GAMEDATA tempNetGameData;
	memcpy(&tempNetGameData, &netGameData, sizeof(NETGAME_GAMEDATA));
	
	
	BYTESWAP4(tempNetGameData.gameType);				fwrite(&tempNetGameData.gameType,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.levelNumber);				fwrite(&tempNetGameData.levelNumber,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.scoreLimit);				fwrite(&tempNetGameData.scoreLimit,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.timeLimit);				fwrite(&tempNetGameData.timeLimit,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.invulnerableTime);		fwrite(&tempNetGameData.invulnerableTime,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.characterKillValues[0]);	fwrite(&tempNetGameData.characterKillValues[0],sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.characterKillValues[1]);	fwrite(&tempNetGameData.characterKillValues[1],sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.characterKillValues[2]);	fwrite(&tempNetGameData.characterKillValues[2],sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.baseKillValue);			fwrite(&tempNetGameData.baseKillValue,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.useDynamicScoring);		fwrite(&tempNetGameData.useDynamicScoring,sizeof(BOOL),1,file);
	BYTESWAP4(tempNetGameData.useCharacterKillValues);	fwrite(&tempNetGameData.useCharacterKillValues,sizeof(BOOL),1,file);

	BYTESWAP4(tempNetGameData.maxMarine);				fwrite(&tempNetGameData.maxMarine,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.maxAlien);				fwrite(&tempNetGameData.maxAlien,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.maxPredator);				fwrite(&tempNetGameData.maxPredator,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.maxMarineGeneral);		fwrite(&tempNetGameData.maxMarineGeneral,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.maxMarinePulseRifle);		fwrite(&tempNetGameData.maxMarinePulseRifle,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.maxMarineSmartgun);		fwrite(&tempNetGameData.maxMarineSmartgun,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.maxMarineFlamer);			fwrite(&tempNetGameData.maxMarineFlamer,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.maxMarineSadar);			fwrite(&tempNetGameData.maxMarineSadar,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.maxMarineGrenade);		fwrite(&tempNetGameData.maxMarineGrenade,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.maxMarineMinigun);		fwrite(&tempNetGameData.maxMarineMinigun,sizeof(int),1,file);

	BYTESWAP4(tempNetGameData.allowSmartgun);			fwrite(&tempNetGameData.allowSmartgun,sizeof(BOOL),1,file);
	BYTESWAP4(tempNetGameData.allowFlamer);				fwrite(&tempNetGameData.allowFlamer,sizeof(BOOL),1,file);
	BYTESWAP4(tempNetGameData.allowSadar);				fwrite(&tempNetGameData.allowSadar,sizeof(BOOL),1,file);
	BYTESWAP4(tempNetGameData.allowGrenadeLauncher);	fwrite(&tempNetGameData.allowGrenadeLauncher,sizeof(BOOL),1,file);
	BYTESWAP4(tempNetGameData.allowMinigun);			fwrite(&tempNetGameData.allowMinigun,sizeof(BOOL),1,file);
	BYTESWAP4(tempNetGameData.allowDisc);				fwrite(&tempNetGameData.allowDisc,sizeof(BOOL),1,file);
	BYTESWAP4(tempNetGameData.allowPistol);				fwrite(&tempNetGameData.allowPistol,sizeof(BOOL),1,file);
	BYTESWAP4(tempNetGameData.allowPlasmaCaster);		fwrite(&tempNetGameData.allowPlasmaCaster,sizeof(BOOL),1,file);
	BYTESWAP4(tempNetGameData.allowSpeargun);			fwrite(&tempNetGameData.allowSpeargun,sizeof(BOOL),1,file);
	BYTESWAP4(tempNetGameData.allowMedicomp);			fwrite(&tempNetGameData.allowMedicomp,sizeof(BOOL),1,file);
	fwrite(&MP_SessionName[0],sizeof(char),13,file);

	BYTESWAP4(tempNetGameData.maxLives);				fwrite(&tempNetGameData.maxLives,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.useSharedLives);			fwrite(&tempNetGameData.useSharedLives,sizeof(BOOL),1,file);

	BYTESWAP4(tempNetGameData.pointsForRespawn);		fwrite(&tempNetGameData.pointsForRespawn,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.timeForRespawn);			fwrite(&tempNetGameData.timeForRespawn,sizeof(int),1,file);
	
	BYTESWAP4(tempNetGameData.aiKillValues[0]);			fwrite(&tempNetGameData.aiKillValues[0],sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.aiKillValues[1]);			fwrite(&tempNetGameData.aiKillValues[1],sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.aiKillValues[2]);			fwrite(&tempNetGameData.aiKillValues[2],sizeof(int),1,file);

	BYTESWAP4(tempNetGameData.gameSpeed);				fwrite(&tempNetGameData.gameSpeed,sizeof(int),1,file);

	//write the description of the config
	//first the length
	int length=strlen(MP_Config_Description)+1;
	int tempLength = length;
	BYTESWAP4(tempLength);
	fwrite(&tempLength,sizeof(int),1,file);
	fwrite(MP_Config_Description,1,length,file);

	BYTESWAP4(tempNetGameData.preDestroyLights);		fwrite(&tempNetGameData.preDestroyLights,sizeof(BOOL),1,file);
	BYTESWAP4(tempNetGameData.disableFriendlyFire);		fwrite(&tempNetGameData.disableFriendlyFire,sizeof(BOOL),1,file);
	BYTESWAP4(tempNetGameData.fallingDamage);			fwrite(&tempNetGameData.fallingDamage,sizeof(BOOL),1,file);
	#if SAVE_NEW_MPCONFIG_ENTRIES
	BYTESWAP4(tempNetGameData.maxMarineSmartDisc);		fwrite(&tempNetGameData.maxMarineSmartDisc,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.maxMarinePistols);		fwrite(&tempNetGameData.maxMarinePistols,sizeof(int),1,file);
	BYTESWAP4(tempNetGameData.allowSmartDisc);			fwrite(&tempNetGameData.allowSmartDisc,sizeof(BOOL),1,file);
	BYTESWAP4(tempNetGameData.allowPistols);			fwrite(&tempNetGameData.allowPistols,sizeof(BOOL),1,file);
	BYTESWAP4(tempNetGameData.pistolInfiniteAmmo);		fwrite(&tempNetGameData.pistolInfiniteAmmo,sizeof(BOOL),1,file);
	BYTESWAP4(tempNetGameData.specialistPistols);		fwrite(&tempNetGameData.specialistPistols,sizeof(BOOL),1,file);
	#endif

	//write the custom level name (if relevant)
	//first the length
	length=strlen(netGameData.customLevelName)+1;
	tempLength = length;
	BYTESWAP4(tempLength);
	fwrite(&tempLength,sizeof(int),1,file);
	fwrite(netGameData.customLevelName,1,length,file);
	

	fclose(file);

	//clear the last description stuff
	delete [] LastDescriptionFile;
	delete [] LastDescriptionText;
	LastDescriptionFile=0;
	LastDescriptionText=0;
}


void DeleteMultiplayerConfigurationByIndex(int index)
{
	if(index<0 || index>= ConfigurationFilenameList.size()) return;

	char filename[200];
	if(netGameData.skirmishMode)
		sprintf(filename,"%s%s.skirmish_cfg",MP_CONFIG_DIR,ConfigurationFilenameList[index]);
	else
		sprintf(filename,"%s%s.cfg",MP_CONFIG_DIR,ConfigurationFilenameList[index]);

	DeleteGameFile(filename);
}


#define IP_ADDRESS_DIR "IP_Address/"
#define IP_ADDRESS_WILDCARD "*.IP Address"

static List<char*> IPAddFilenameList;

AVPMENU_ELEMENT* AvPMenu_Multiplayer_LoadIPAddress=0;

BOOL BuildLoadIPAddressMenu()
{
	int i;
	
	//delete the old list of filenames
	while(IPAddFilenameList.size())
	{
		delete [] IPAddFilenameList.first_entry();
		IPAddFilenameList.delete_first_entry();
	}

	//do a search for all the addresses in the address directory

	void *gd;
	GameDirectoryFile *gdf;
	gd = OpenGameDirectory(IP_ADDRESS_DIR, IP_ADDRESS_WILDCARD, FILETYPE_CONFIG);
	if (gd == NULL) {
		CreateGameDirectory(IP_ADDRESS_DIR); /* maybe it didn't exist.. */
		return FALSE;
	}
	
	while ((gdf = ScanGameDirectory(gd)) != NULL) {
		if ((gdf->attr & FILEATTR_DIRECTORY) != 0)
			continue;
		if ((gdf->attr & FILEATTR_READABLE) == 0)
			continue;
		
		char* name=new char[strlen(gdf->filename)+1];
		strcpy(name,gdf->filename);
		char* dotpos=strchr(name,'.');
		if(dotpos) *dotpos=0;
		IPAddFilenameList.add_entry(name);
	}
	
	CloseGameDirectory(gd);
	
	//delete the old menu
	if(AvPMenu_Multiplayer_LoadIPAddress) delete [] AvPMenu_Multiplayer_LoadIPAddress;

	
	//create a new menu from the list of filenames
	AvPMenu_Multiplayer_LoadIPAddress=new AVPMENU_ELEMENT[IPAddFilenameList.size()+1];

	for(i=0;i<IPAddFilenameList.size();i++)
	{
		AvPMenu_Multiplayer_LoadIPAddress[i].ElementID=AVPMENU_ELEMENT_LOADIPADDRESS;	
		AvPMenu_Multiplayer_LoadIPAddress[i].a.TextDescription=TEXTSTRING_BLANK;	
		AvPMenu_Multiplayer_LoadIPAddress[i].b.MenuToGoTo=AVPMENU_MULTIPLAYERSELECTSESSION;	
		AvPMenu_Multiplayer_LoadIPAddress[i].c.TextPtr=IPAddFilenameList[i];	
		AvPMenu_Multiplayer_LoadIPAddress[i].HelpString=TEXTSTRING_MULTIPLAYER_LOADADDRESS_HELP;	
	}

	AvPMenu_Multiplayer_LoadIPAddress[i].ElementID=AVPMENU_ELEMENT_ENDOFMENU;	
	return (IPAddFilenameList.size()>0); 
}


void SaveIPAddress(const char* name,const char* address)
{
	if(!name) return;
	if(!address) return;
	if(!strlen(name)) return;
	if(!strlen(address)) return;

	FILE* file;
	char filename[200];
	sprintf(filename,"%s%s.IP Address",IP_ADDRESS_DIR,name);
	
	file = OpenGameFile(filename, FILEMODE_WRITEONLY, FILETYPE_CONFIG);
	if (file == NULL) {
		CreateGameDirectory(IP_ADDRESS_DIR); /* try again */
		file = OpenGameFile(filename, FILEMODE_WRITEONLY, FILETYPE_CONFIG);
		if (file == NULL)
			 return;
	}

	fwrite(address,1,strlen(address)+1,file);
	
	fclose(file);
}

void LoadIPAddress(const char* name)
{
	extern char IPAddressString[]; 
		
	if(!name) return;

	FILE* file;
	char filename[200];
	sprintf(filename,"%s%s.IP Address",IP_ADDRESS_DIR,name);

	file=OpenGameFile(filename, FILEMODE_READONLY, FILETYPE_CONFIG);
	if(!file) return;
	
	fread(IPAddressString,1,16,file);
	IPAddressString[15]=0;
	
	fclose(file);
}



extern AVPMENU_ELEMENT AvPMenu_Multiplayer_Config[];
extern AVPMENU_ELEMENT AvPMenu_Skirmish_Config[];
extern AVPMENU_ELEMENT AvPMenu_Multiplayer_Config_Join[];


int NumCustomLevels = 0;
int NumMultiplayerLevels = 0;
int NumCoopLevels = 0;

char** MultiplayerLevelNames = 0;
char** CoopLevelNames = 0;

List<char*> CustomLevelNameList;

void BuildMultiplayerLevelNameArray()
{
	char buffer[256];

	//only want to do this once
	if(MultiplayerLevelNames) return;

	//first do a search for custom level rifs
	// allow a wildcard search
	void *gd;
	GameDirectoryFile *gdf;
	
	/* TODO: Have to use PERM until the load_rif code can handle CONFIG */
	if ((gd = OpenGameDirectory("avp_rifs/Custom/", "*.rif", FILETYPE_PERM)) != NULL) {
		char* custom_string = GetTextString(TEXTSTRING_CUSTOM_LEVEL);
		int cs_len = strlen(custom_string);
		
		while ((gdf = ScanGameDirectory(gd)) != NULL) {
			if ((gdf->attr & FILEATTR_DIRECTORY) != 0)
				continue;
			if ((gdf->attr & FILEATTR_READABLE) == 0)
				continue;
		
			char* name=new char[strlen(gdf->filename)+cs_len+3+1];
				
			strcpy(name, gdf->filename);
			char* dotpos=strrchr(name,'.');
			if(dotpos) *dotpos=0;
			strcat(name," (");
			strcat(name,custom_string);
			strcat(name,")");
			CustomLevelNameList.add_entry(name);				
		}
		CloseGameDirectory(gd);
	} else {
		CreateGameDirectory("Custom/"); /* maybe it didn't exist.. */
	}
	
	NumCustomLevels = CustomLevelNameList.size();


	NumMultiplayerLevels = MAX_NO_OF_MULTIPLAYER_EPISODES + NumCustomLevels;
	NumCoopLevels = MAX_NO_OF_COOPERATIVE_EPISODES + NumCustomLevels;

	MultiplayerLevelNames = (char**) AllocateMem(sizeof(char*)* NumMultiplayerLevels);

	int i;
	//first the standard multiplayer levels
	for(i=0;i<MAX_NO_OF_MULTIPLAYER_EPISODES;i++)
	{
		char* level_name = GetTextString((TEXTSTRING_ID)(i+TEXTSTRING_MULTIPLAYERLEVELS_1));
		if(i>=5)
		{
			//a new level
			char* new_string = GetTextString(TEXTSTRING_NEW_LEVEL);
			sprintf(buffer,"%s (%s)",level_name,new_string);

			//allocate memory and copy the string.
			MultiplayerLevelNames[i] = (char*) AllocateMem(strlen(buffer)+1);
			strcpy(MultiplayerLevelNames[i],buffer);
			
		}
		else
		{
			MultiplayerLevelNames[i] = level_name;
		}
	}
	

	CoopLevelNames = (char**) AllocateMem(sizeof(char*)* NumCoopLevels);

	//and the standard coop levels
	for(i=0;i<MAX_NO_OF_COOPERATIVE_EPISODES;i++)
	{
		char* level_name = GetTextString((TEXTSTRING_ID)(i+TEXTSTRING_COOPLEVEL_1));
		if(i>=5)
		{
			//a new level
			char* new_string = GetTextString(TEXTSTRING_NEW_LEVEL);
			sprintf(buffer,"%s (%s)",level_name,new_string);

			//allocate memory and copy the string.
			CoopLevelNames[i] =(char*) AllocateMem(strlen(buffer)+1);
			strcpy(CoopLevelNames[i],buffer);
			
		}
		else
		{
			CoopLevelNames[i] = level_name;
		}
	}

	//now add the custom level names
	for(i=0;i<NumCustomLevels;i++)
	{
		CoopLevelNames[i+MAX_NO_OF_COOPERATIVE_EPISODES] = CustomLevelNameList[i];
		MultiplayerLevelNames[i+MAX_NO_OF_MULTIPLAYER_EPISODES] = CustomLevelNameList[i];
	}
	
	
	//now initialise the environment name entries for the various configuration menus
	AVPMENU_ELEMENT *elementPtr;


	elementPtr = AvPMenu_Multiplayer_Config;
	//search for the level name element
	while(elementPtr->a.TextDescription!=TEXTSTRING_MULTIPLAYER_ENVIRONMENT)
	{
		GLOBALASSERT(elementPtr->ElementID!=AVPMENU_ELEMENT_ENDOFMENU);
		elementPtr++;

	}
	elementPtr->b.MaxSliderValue = NumMultiplayerLevels-1;
	elementPtr->d.TextSliderStringPointer = MultiplayerLevelNames;
	
	elementPtr = AvPMenu_Multiplayer_Config_Join;
	//search for the level name element
	while(elementPtr->a.TextDescription!=TEXTSTRING_MULTIPLAYER_ENVIRONMENT)
	{
		GLOBALASSERT(elementPtr->ElementID!=AVPMENU_ELEMENT_ENDOFMENU);
		elementPtr++;

	}
	elementPtr->b.MaxSliderValue = NumMultiplayerLevels-1;
	elementPtr->d.TextSliderStringPointer = MultiplayerLevelNames;

	elementPtr = AvPMenu_Skirmish_Config;
	//search for the level name element
	while(elementPtr->a.TextDescription!=TEXTSTRING_MULTIPLAYER_ENVIRONMENT)
	{
		GLOBALASSERT(elementPtr->ElementID!=AVPMENU_ELEMENT_ENDOFMENU);
		elementPtr++;

	}
	elementPtr->b.MaxSliderValue = NumMultiplayerLevels-1;
	elementPtr->d.TextSliderStringPointer = MultiplayerLevelNames;
}


//returns local index of a custom level (if it is a custom level)
int GetCustomMultiplayerLevelIndex(char* name,int gameType)
{
	char buffer[256];
	//tack ( custom) onto the end of the name , before doing the string compare
	char* custom_string = GetTextString(TEXTSTRING_CUSTOM_LEVEL); 
	sprintf(buffer,"%s (%s)",name,custom_string);

	//find the index of a custom level from its name
	if(gameType==NGT_Coop)
	{
		for(int i=MAX_NO_OF_COOPERATIVE_EPISODES;i<NumCoopLevels;i++)
		{
			if(!_stricmp(buffer,CoopLevelNames[i]))
			{
				return i;
			}
		}
	}
	else
	{
		for(int i=MAX_NO_OF_MULTIPLAYER_EPISODES;i<NumMultiplayerLevels;i++)
		{
			if(!_stricmp(buffer,MultiplayerLevelNames[i]))
			{
				return i;
			}
		}
	}
	return -1;
}

//returns name of custom level (without stuff tacked on the end)
char* GetCustomMultiplayerLevelName(int index,int gameType)
{
	static char return_string[100];
	return_string[0] = 0;
	
	//find the index of a custom level from its name
	if(gameType==NGT_Coop)
	{
		if(index>=MAX_NO_OF_COOPERATIVE_EPISODES)
		{
			strcpy(return_string,CoopLevelNames[index]);
		}
	}
	else
	{
		if(index>=MAX_NO_OF_MULTIPLAYER_EPISODES)
		{
			strcpy(return_string,MultiplayerLevelNames[index]);
		}
	}

	//need to remove ' (custom)' from the end of the level name
	char* bracket_pos = strrchr(return_string,'(');
	if(bracket_pos)
	{
		bracket_pos --; //to get back to the space
		*bracket_pos = 0;
		
	}

	return return_string;
}


int GetLocalMultiplayerLevelIndex(int index,char* customLevelName,int gameType)
{
	if(customLevelName[0] == 0)
	{
		//not a custom level , just need to check to see if the level index is in range
		if(gameType==NGT_Coop)
		{
			if(index<MAX_NO_OF_COOPERATIVE_EPISODES)
			{
				return index;
			}
		}
		else
		{
			if(index<MAX_NO_OF_MULTIPLAYER_EPISODES)
			{
				return index;
			}
		}
 	}
	else
	{
		//see if we have the named level
		return GetCustomMultiplayerLevelIndex(customLevelName,gameType);
	}
	return -1;
}

};
