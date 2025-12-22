# Makefile used for compiling flare 0.15 using & for AmigaOS 4.
CC		= gcc
CXX		= g++
STRIP		= strip
CFLAGS	= -mcrt=newlib -Wall -O3 -I/sdk/local/newlib/include/SDL -I/sdk/local/common/include/SDL -I/sdk/local/newlib/include -I/sdk/local/common/include
LDFLAGS	= -lSDL_image -ltiff -lpng14 -ljpeg -lz -lSDL_mixer -lmikmod -lpthread -lsmpeg -lm -lvorbisfile -lvorbis -logg -lFLAC -lstdc++ -lz -lsdl_ttf -lfreetype -lsdlmain -lsdl -lauto
SRC	= 		src/WidgetTooltip.cpp \
			src/WidgetLabel.cpp \
			src/WidgetInput.cpp \
			src/WidgetButton.cpp \
			src/UtilsParsing.cpp \
			src/UtilsFileSystem.cpp \
			src/Utils.cpp \
			src/TileSet.cpp \
			src/StatBlock.cpp \
			src/SharedResources.cpp \
			src/Settings.cpp \
			src/SaveLoad.cpp \
			src/QuestLog.cpp \
			src/PowerManager.cpp \
			src/NPCManager.cpp \
			src/NPC.cpp \
			src/ModManager.cpp \
			src/MessageEngine.cpp \
			src/MenuVendor.cpp \
			src/MenuTalker.cpp \
			src/MenuPowers.cpp \
			src/MenuMiniMap.cpp \
			src/MenuManager.cpp \
			src/MenuLog.cpp \
			src/MenuItemStorage.cpp \
			src/MenuInventory.cpp \
			src/MenuHUDLog.cpp \
			src/MenuHPMP.cpp \
			src/MenuExperience.cpp \
			src/MenuExit.cpp \
			src/MenuEnemy.cpp \
			src/MenuConfirm.cpp \
			src/MenuCharacter.cpp \
			src/MenuActionBar.cpp \
			src/Menu.cpp \
			src/MapIso.cpp \
			src/MapCollision.cpp \
			src/main.cpp \
			src/LootManager.cpp \
			src/ItemStorage.cpp \
			src/ItemManager.cpp \
			src/InputState.cpp \
			src/HazardManager.cpp \
			src/Hazard.cpp \
			src/GetText.cpp \
			src/GameSwitcher.cpp \
			src/GameStateTitle.cpp \
			src/GameStatePlay.cpp \
			src/GameStateNew.cpp \
			src/GameStateLoad.cpp \
			src/GameState.cpp \
			src/FontEngine.cpp \
			src/FileParser.cpp \
			src/Entity.cpp \
			src/EnemyManager.cpp \
			src/EnemyGroupManager.cpp \
			src/Enemy.cpp \
			src/CampaignManager.cpp \
			src/Avatar.cpp \
			src/Animation.cpp
OBJS	= 	build/WidgetTooltip.o \
			build/WidgetLabel.o \
			build/WidgetInput.o \
			build/WidgetButton.o \
			build/UtilsParsing.o \
			build/UtilsFileSystem.o \
			build/Utils.o \
			build/TileSet.o \
			build/StatBlock.o \
			build/SharedResources.o \
			build/Settings.o \
			build/SaveLoad.o \
			build/QuestLog.o \
			build/PowerManager.o \
			build/NPCManager.o \
			build/NPC.o \
			build/ModManager.o \
			build/MessageEngine.o \
			build/MenuVendor.o \
			build/MenuTalker.o \
			build/MenuPowers.o \
			build/MenuMiniMap.o \
			build/MenuManager.o \
			build/MenuLog.o \
			build/MenuItemStorage.o \
			build/MenuInventory.o \
			build/MenuHUDLog.o \
			build/MenuHPMP.o \
			build/MenuExperience.o \
			build/MenuExit.o \
			build/MenuEnemy.o \
			build/MenuConfirm.o \
			build/MenuCharacter.o \
			build/MenuActionBar.o \
			build/Menu.o \
			build/MapIso.o \
			build/MapCollision.o \
			build/main.o \
			build/LootManager.o \
			build/ItemStorage.o \
			build/ItemManager.o \
			build/InputState.o \
			build/HazardManager.o \
			build/Hazard.o \
			build/GetText.o \
			build/GameSwitcher.o \
			build/GameStateTitle.o \
			build/GameStatePlay.o \
			build/GameStateNew.o \
			build/GameStateLoad.o \
			build/GameState.o \
			build/FontEngine.o \
			build/FileParser.o \
			build/Entity.o \
			build/EnemyManager.o \
			build/EnemyGroupManager.o \
			build/Enemy.o \
			build/CampaignManager.o \
			build/Avatar.o \
			build/Animation.o
OUTPUT	= flare

all: $(SRC)
			$(CXX) $(CFLAGS) -c src/WidgetTooltip.cpp -o build/WidgetTooltip.o
			$(CXX) $(CFLAGS) -c src/WidgetLabel.cpp -o build/WidgetLabel.o
			$(CXX) $(CFLAGS) -c src/WidgetInput.cpp -o build/WidgetInput.o
			$(CXX) $(CFLAGS) -c src/WidgetButton.cpp -o build/WidgetButton.o
			$(CXX) $(CFLAGS) -c src/UtilsParsing.cpp -o build/UtilsParsing.o
			$(CXX) $(CFLAGS) -c src/UtilsFilesystem.cpp -o build/UtilsFileSystem.o
			$(CXX) $(CFLAGS) -c src/Utils.cpp -o build/Utils.o
			$(CXX) $(CFLAGS) -c src/TileSet.cpp -o build/TileSet.o
			$(CXX) $(CFLAGS) -c src/StatBlock.cpp -o build/StatBlock.o
			$(CXX) $(CFLAGS) -c src/SharedResources.cpp -o build/SharedResources.o
			$(CXX) $(CFLAGS) -c src/Settings.cpp -o build/Settings.o
			$(CXX) $(CFLAGS) -c src/SaveLoad.cpp -o build/SaveLoad.o
			$(CXX) $(CFLAGS) -c src/QuestLog.cpp -o build/QuestLog.o
			$(CXX) $(CFLAGS) -c src/PowerManager.cpp -o build/PowerManager.o
			$(CXX) $(CFLAGS) -c src/NPCManager.cpp -o build/NPCManager.o
			$(CXX) $(CFLAGS) -c src/NPC.cpp -o build/NPC.o
			$(CXX) $(CFLAGS) -c src/ModManager.cpp -o build/ModManager.o
			$(CXX) $(CFLAGS) -c src/MessageEngine.cpp -o build/MessageEngine.o
			$(CXX) $(CFLAGS) -c src/MenuVendor.cpp -o build/MenuVendor.o
			$(CXX) $(CFLAGS) -c src/MenuTalker.cpp -o build/MenuTalker.o
			$(CXX) $(CFLAGS) -c src/MenuPowers.cpp -o build/MenuPowers.o
			$(CXX) $(CFLAGS) -c src/MenuMiniMap.cpp -o build/MenuMiniMap.o
			$(CXX) $(CFLAGS) -c src/MenuManager.cpp -o build/MenuManager.o
			$(CXX) $(CFLAGS) -c src/MenuLog.cpp -o build/MenuLog.o
			$(CXX) $(CFLAGS) -c src/MenuItemStorage.cpp -o build/MenuItemStorage.o
			$(CXX) $(CFLAGS) -c src/MenuInventory.cpp -o build/MenuInventory.o
			$(CXX) $(CFLAGS) -c src/MenuHUDLog.cpp -o build/MenuHUDLog.o
			$(CXX) $(CFLAGS) -c src/MenuHPMP.cpp -o build/MenuHPMP.o
			$(CXX) $(CFLAGS) -c src/MenuExperience.cpp -o build/MenuExperience.o
			$(CXX) $(CFLAGS) -c src/MenuExit.cpp -o build/MenuExit.o
			$(CXX) $(CFLAGS) -c src/MenuEnemy.cpp -o build/MenuEnemy.o
			$(CXX) $(CFLAGS) -c src/MenuConfirm.cpp -o build/MenuConfirm.o
			$(CXX) $(CFLAGS) -c src/MenuCharacter.cpp -o build/MenuCharacter.o
			$(CXX) $(CFLAGS) -c src/MenuActionBar.cpp -o build/MenuActionBar.o
			$(CXX) $(CFLAGS) -c src/Menu.cpp -o build/Menu.o
			$(CXX) $(CFLAGS) -c src/MapIso.cpp -o build/MapIso.o
			$(CXX) $(CFLAGS) -c src/MapCollision.cpp -o build/MapCollision.o
			$(CXX) $(CFLAGS) -c src/main.cpp -o build/main.o
			$(CXX) $(CFLAGS) -c src/LootManager.cpp -o build/LootManager.o
			$(CXX) $(CFLAGS) -c src/ItemStorage.cpp -o build/ItemStorage.o
			$(CXX) $(CFLAGS) -c src/ItemManager.cpp -o build/ItemManager.o
			$(CXX) $(CFLAGS) -c src/InputState.cpp -o build/InputState.o
			$(CXX) $(CFLAGS) -c src/HazardManager.cpp -o build/HazardManager.o
			$(CXX) $(CFLAGS) -c src/Hazard.cpp -o build/Hazard.o
			$(CXX) $(CFLAGS) -c src/GetText.cpp -o build/GetText.o
			$(CXX) $(CFLAGS) -c src/GameSwitcher.cpp -o build/GameSwitcher.o
			$(CXX) $(CFLAGS) -c src/GameStateTitle.cpp -o build/GameStateTitle.o
			$(CXX) $(CFLAGS) -c src/GameStatePlay.cpp -o build/GameStatePlay.o
			$(CXX) $(CFLAGS) -c src/GameStateNew.cpp -o build/GameStateNew.o
			$(CXX) $(CFLAGS) -c src/GameStateLoad.cpp -o build/GameStateLoad.o
			$(CXX) $(CFLAGS) -c src/GameState.cpp -o build/GameState.o
			$(CXX) $(CFLAGS) -c src/FontEngine.cpp -o build/FontEngine.o
			$(CXX) $(CFLAGS) -c src/FileParser.cpp -o build/FileParser.o
			$(CXX) $(CFLAGS) -c src/Entity.cpp -o build/Entity.o
			$(CXX) $(CFLAGS) -c src/EnemyManager.cpp -o build/EnemyManager.o
			$(CXX) $(CFLAGS) -c src/EnemyGroupManager.cpp -o build/EnemyGroupManager.o
			$(CXX) $(CFLAGS) -c src/Enemy.cpp -o build/Enemy.o
			$(CXX) $(CFLAGS) -c src/CampaignManager.cpp -o build/CampaignManager.o
			$(CXX) $(CFLAGS) -c src/Avatar.cpp -o build/Avatar.o
			$(CXX) $(CFLAGS) -c src/Animation.cpp -o build/Animation.o
			$(CXX) $(CFLAGS) $(OBJS) $(LDFLAGS) -o $(OUTPUT)
link:
			$(CXX) $(CFLAGS) $(OBJS) $(LDFLAGS) -o $(OUTPUT)
	