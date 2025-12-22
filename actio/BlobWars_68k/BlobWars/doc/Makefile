AR				=	ar
#CC			=	ppc-morphos-gcc
CC				=	gcc -m68020 -m68881
#CXX			=	ppc-morphos-g++
CXX			=	g++ -m68020 -m68881
CHMOD			=	chmod
RANLIB		=	ranlib
RM				=	rm -f
STRIP			=	strip



VERSION		=	1.14
RELEASE		=	1
USEPAK		=	1

DATADIR		=	Progdir:
DOCDIR		=	Progdir:doc/
LOCALEDIR	=	locale

PROG			=	BlobWars
PAKNAME		=	blobwars.pak

CFLAGS		=	-g -O2 -Wall `sdl-config2 --cflags` -DVERSION=$(VERSION) -DRELEASE=$(RELEASE) -D_VER=\"$(VERSION)\"
CFLAGS		+=	-DUSEPAK=$(USEPAK) -DPAKNAME=\"$(PAKNAME)\" -DPAKLOCATION=\"$(DATADIR)\" -D__MORPHOS__
CFLAGS		+=	-DGAMEPLAYMANUAL=\"$(DOCDIR)index.html\" -DLOCALEDIR=\"$(LOCALEDIR)\"

LDFLAGS		=	-lSDL_image -ljpeg -lpng -lz -lSDL_ttf -lfreetype -lSDL_mixer_1 `sdl-config2 --libs` -lintl #-lmmath 


OBJS			+=	CAudio.o
OBJS			+=	CBoss.o
OBJS			+=	CCollision.o CCutscene.o  CConfig.o
OBJS			+=	CData.o
OBJS			+=	CEffect.o CEngine.o CEntity.o
OBJS			+=	CFileData.o
OBJS			+=	CGame.o CGameData.o CGameObject.o CGraphics.o
OBJS			+=	CHub.o
OBJS			+=	CKeyboard.o
OBJS			+=	CJoystick.o
OBJS			+=	CLineDef.o
OBJS			+=	CList.o
OBJS			+=	CMap.o CMath.o
OBJS			+=	CObjective.o
OBJS			+=	CPak.o CParticle.o CPersistant.o CPersistData.o
OBJS			+=	CRadarBlip.o CReplayData.o
OBJS			+=	CSpawnPoint.o CSprite.o CSwitch.o
OBJS			+=	CTeleporter.o CTrain.o CTrap.o
OBJS			+=	CWeapon.o CWidget.o
OBJS			+=	aquaBoss.o
OBJS			+=	bosses.o bullets.o
OBJS			+=	cutscene.o
OBJS			+=	droidBoss.o
OBJS			+=	effects.o enemies.o entities.o explosions.o
OBJS			+=	finalBattle.o
OBJS			+=	galdov.o game.o graphics.o
OBJS			+=	hub.o
OBJS			+=	info.o init.o intro.o items.o
OBJS			+=	lineDefs.o loadSave.o
OBJS			+=	map.o mapData.o mias.o mission.o
OBJS			+=	objectives.o obstacles.o options.o
OBJS			+=	particles.o player.o
OBJS			+=	resources.o
OBJS			+=	spawnPoints.o switches.o
OBJS			+=	tankBoss.o teleporters.o title.o trains.o traps.o triggers.o
OBJS			+=	weapons.o widgets.o

GAMEOBJS		=	$(OBJS) main.o
#MAPOBJS		=	$(OBJS) mapEditor.o
PAKOBJS		=	CFileData.o pak.o

#LOCALE_MO	=	$(patsubst %.po,%.mo,$(wildcard locale/*.po))



#all:	$(PROG) pak $(LOCALE_MO)
all:	$(PROG) pak


%.o:	%.cpp %.h defs.h defines.h headers.h
		$(CXX) $(CFLAGS) -c $< -o $@


$(PROG):	$(GAMEOBJS)
		$(CXX) $(GAMEOBJS) -o $@.db $(LDFLAGS)
		$(STRIP) --strip-unneeded --remove-section=.comment $@.db -o $@
		$(CHMOD) u+x $@


pak:	$(PAKOBJS)
		$(CXX) $(PAKOBJS) -o $@.db $(LDFLAGS)
		$(STRIP) --strip-unneeded --remove-section=.comment $@.db -o $@
		$(CHMOD) u+x $@


#%.mo:	%.po
#		msgfmt -c -o $@ $<


#mapeditor:	$(MAPOBJS)
#		$(CXX) $(MAPOBJS) -o $@.db $(LDFLAGS)
#		$(STRIP) --strip-unneeded --remove-section=.comment $@.db -o $@
#		$(CHMOD) u+x $@


buildpak:
		pak data gfx music sound $(PAKNAME)

clean:
#		$(RM) $(GAMEOBJS) mapEditor.o pak.o $(PROG) $(PAKNAME) pak mapeditor $(LOCALE_MO)
		$(RM) $(GAMEOBJS) mapEditor.o pak.o $(PROG) $(PROG).db $(PAKNAME) pak pak.db mapeditor
