# This MakeFile obtained from HAK's MOS port & modified for 68k
# by Lorence Lombardo
# gcc 4.x
AR				=	ar
CC				=	gcc -m68020 -m68881
CHMOD			=	chmod
CXX			=	g++ -m68020 -m68881
RANLIB		=	ranlib
RM				=	rm -f
STRIP			=	strip

#------------------------------------------------------------------------------#

DEV			=	0
DIR_DATA		=
DIR_LOCALE	=	locale
FILE_PAK		=	edgar.pak
RELEASE		=	1
VERSION		=	1.03

#------------------------------------------------------------------------------#

CFLAGS		=	-g -O2 -Wall `sdl-config2 --cflags` \
					-DVERSION=$(VERSION) -D_VER=\"$(VERSION)\" -DRELEASE=$(RELEASE) -DDEV=$(DEV) \
					-DINSTALL_PATH=\"$(DIR_DATA)\" -DLOCALE_DIR=\"$(DIR_LOCALE)\" -DPAK_FILE=\"$(FILE_PAK)\"

#LDFLAGS		=	`sdl-config --libs` -lintl -lSDL_image -lSDL_mixer -lSDL_ttf -lSDL_net -lz_shared -lpng_shared
LDFLAGS		=	-lSDL_image -ljpeg -lpng_2 -lz -lSDL_ttf -lfreetype -lSDL_mixer_1 `sdl-config1a --libs` -lintl

#------------------------------------------------------------------------------#

OBJ_CORE		=	animation.o audio.o collisions.o entity.o font.o game.o graphics.o init.o input.o inventory.o \
					lift.o map.o player.o resources.o weather.o sprites.o bat.o properties.o custom_actions.o \
					item.o enemies.o hud.o random.o decoration.o chicken_feed.o chicken.o \
					key_items.o record.o geometry.o chicken_trap.o target.o spawner.o rock.o pressure_plate.o door.o \
					weak_wall.o switch.o line_def.o boulder_boss.o trigger.o music.o coal_pile.o objective.o level_exit.o \
					spider.o grub.o grub_boss.o save_point.o shrub.o projectile.o load_save.o \
					compress.o global_trigger.o fireball.o wasp.o small_boulder.o dialog.o script.o \
					main_menu.o widget.o menu.o options_menu.o npc.o gib.o heart_container.o action_point.o \
					falling_platform.o spitting_plant.o red_grub.o stalactite.o bomb.o explosion.o bomb_pile.o \
					jumping_slime.o egg.o golem_boss.o baby_slime.o snail.o floating_snapper.o snake_boss.o \
					enemy_generator.o flying_bug.o potions.o pak.o control_menu.o label.o sound_menu.o fly_boss.o ant_lion.o \
					io_menu.o inventory_menu.o scorpion.o status_panel.o trap_door.o arrow_target.o eye_stalk.o snail_shell.o \
					flying_maggot.o conveyor_belt.o power_generator.o laser_grid.o ceiling_snapper.o gazer.o \
					teleporter.o sludge.o grabber.o golem_rock_dropper.o yes_no_menu.o about_menu.o summoner.o energy_drainer.o \
					symbol_block.o number_block.o force_field.o gazer_eye_slot.o spring.o centurion.o \
					ice_cube.o vanishing_platform.o armadillo.o bubble_machine.o bubble.o map_trigger.o potion_dispenser.o \
					ceiling_crawler.o tesla_charger.o tesla_pack.o lightning_tortoise.o fire_burner.o high_striker.o containment_unit.o \
					blob_boss.o containment_unit_controls.o ice_spray.o blending_machine.o robot.o anti_gravity_field.o spike_ball.o \
					error.o code_door.o code_display.o skull.o poltergiest.o book.o moveable_lift.o glass_wall.o spike_wall.o \
					whirlwind.o large_book.o tuning_fork.o pedestal.o spike_sphere.o cauldron.o soul_bottle.o exploding_spike_sphere.o \
					thunder_cloud.o instruction_machine.o spirit.o black_book.o mataeus.o mataeus_wall.o mine_cart.o boulder_boss_2.o \
					rock_container.o scale.o lava_geyzer.o large_spider.o crusher.o medal.o repellent.o cloud_geyzer.o \
					ok_menu.o huge_spider.o armour_boss.o slime_container.o final_power_generator.o mirror.o light_source.o light_beam.o \
					light_target.o balloon.o scanner.o fly_trap.o water_purifier.o extend_o_grab.o mouth_stalk.o ground_spear.o \
					dragon_fly.o sliding_puzzle.o sliding_puzzle_display.o auto_spike_ball.o tread_mill.o power_meter.o gold_centurion.o \
					shield_pillar.o crossbow.o crossbow_bolt.o catapult.o stats_menu.o awesome_boss.o awesome_boss_meter.o evil_edgar.o \
					fish.o borer_boss.o light_pillar.o exploding_gazer_eye.o glass_cage.o lab_crusher.o exploding_gazer_eye_dud.o soul_merger.o \
					soul_merger_control_panel.o fire_tortoise.o lava_door.o dark_summoner.o flame_pillar.o phoenix.o pendulum.o extend_o_grab_button.o \
					puzzle_piece.o jigsaw_puzzle.o jigsaw_puzzle_display.o magnet.o ice_tortoise.o splitter.o attractor.o buzz_saw.o cell_bars.o \
					sorceror.o centurion_boss.o sewer_boss.o item_remover.o safe.o ground_snapper.o sasquatch.o icicle.o giant_snowball.o \
					script_menu.o snow_pile.o ceiling_creeper.o gas_plant.o centipede.o spore_crop.o spore.o sludge_pool.o vines.o undead_gazer.o \
					slime_potion_pool.o frog.o master_tortoise.o red_ceiling_creeper.o rampaging_master_tortoise.o cheat_menu.o monster_skull.o \
					cave_boss.o apple_tree.o apple.o one_way_door.o colour_pot.o colour_display.o phase_door.o mastermind_display.o mastermind.o \
					iron_ball.o memory_match.o memory_match_display.o hoover.o black_book_2.o drawbridge_pulley.o drawbridge_anchor.o giant_ceiling_creeper.o \
					baby_salamander.o safe_combination.o grimlore.o grimlore_artifact.o magic_missile.o grimlore_summon_spell.o hidden_passage_wall.o \
					poison_meat.o train.o train_track.o flame_statue.o armour_changer.o credits.o black_book_3.o sorceror_2.o sorceror_dark_summoner.o \
					sorceror_floor.o medals_menu.o skull_door.o ghost.o slug.o portable_save.o crypt_skull.o skeleton.o bell_rope.o \
					music_sheet_display.o title.o azriel.o zombie.o mini_gargoyle.o gargoyle.o chaos.o chaos_vine.o i18n.o azriel_grave.o


OBJ_EDIT		=	draw_editor.o main_editor.o cursor.o

OBJ_MAIN		=	draw.o main.o

OBJ_PAK		=	pak_creator.o

OBJ_PO		=	po_creator.o

OBJ_TILE		=	tile_creator.o save_png.o


BIN_ED		=	MapEditor

BIN_PAK		=	pak

BIN_PO		=	po_creator

BIN_PRG		=	Edgar

BIN_TILE		=	tile_creator

#------------------------------------------------------------------------------#

all:		$(BIN_ED) $(BIN_PAK) $(BIN_PO) $(BIN_PRG) $(BIN_TILE) makefile.dep



$(BIN_ED):	$(OBJ_EDIT) $(OBJ_CORE)
			$(CC) $(OBJ_EDIT) $(OBJ_CORE) -o $@.db $(LDFLAGS)
			$(STRIP) --strip-unneeded --remove-section=.comment $@.db -o $@
			$(CHMOD) u+x $@


$(BIN_PAK):	$(OBJ_PAK)
			$(CC) $(OBJ_PAK) -o $@.db $(LDFLAGS)
			$(STRIP) --strip-unneeded --remove-section=.comment $@.db -o $@
			$(CHMOD) u+x $@


$(BIN_PO):	$(OBJ_PO)
			$(CC) $(OBJ_PO) -o $@.db $(LDFLAGS)
			$(STRIP) --strip-unneeded --remove-section=.comment $@.db -o $@
			$(CHMOD) u+x $@


$(BIN_PRG):	$(OBJ_MAIN) $(OBJ_CORE)
			$(CC) $(OBJ_MAIN) $(OBJ_CORE) -o $@.db $(LDFLAGS)
			$(STRIP) --strip-unneeded --remove-section=.comment $@.db -o $@
			$(CHMOD) u+x $@


$(BIN_TILE):	$(OBJ_TILE)
			$(CC) $(OBJ_TILE) -o $@.db $(LDFLAGS)
			$(STRIP) --strip-unneeded --remove-section=.comment $@.db -o $@
			$(CHMOD) u+x $@


%.o:
			$(CC) $(CFLAGS) -c $< -o $@


buildpak:	$(BIN_PAK)
			./$(BIN_PAK) data gfx music sound font $(FILE_PAK)


makefile.dep:	src/*/*.h src/*.h
			for i in src/*.c src/*/*.c; do $(CC) -MM "$${i}"; done > $@

#------------------------------------------------------------------------------#

clean:
		$(RM) $(BIN_ED) $(BIN_ED).db $(BIN_PAK) $(BIN_PAK).db $(BIN_PO) $(BIN_PO).db $(BIN_PRG) $(BIN_PRG).db \
		$(BIN_TILE) $(BIN_TILE).db $(FILE_PAK) $(OBJ_CORE) $(OBJ_EDIT) $(OBJ_MAIN) $(OBJ_PAK) $(OBJ_PO) $(OBJ_TILE) \
		makefile.dep

#------------------------------------------------------------------------------#

include makefile.dep
