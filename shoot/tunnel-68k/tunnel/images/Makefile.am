BALLS_IMAGES = crawler.png crawler_frag.png crawler_thrower.png        \
               crazy.png crazy_frag.png crazy_thrower.png              \
               def_weapon.png fast_weap_pickup.png fast_weapon.png     \
               icon16.png icon32.png icon48.png icon64.png multics.png \
               normal_bullet.png punch.png punch_frag.png              \
               punch_thrower.png shield_pickup.png ship.png            \
               ship_frag.png speedy.png speedy_frag.png                \
               speedy_thrower.png strength_pickup.png                  \
               strong_bullet.png strong_fast_weap_pickup.png           \
               strong_fast_weapon.png strong_weap_pickup.png           \
               strong_weapon.png tickler.png tickler_frag.png          \
               tickler_thrower.png weap_pickup.png

FRAME_IMAGES = frame_b.png frame_bl.png frame_br.png frame_c.png \
               frame_h.png frame_l.png frame_r.png frame_t.png   \
               frame_tl.png frame_tr.png frame_v.png

LINES_IMAGES = blank.png dial.png tunnel_gradient.png

SCREENS_IMAGES = paused.png splash.png wait.png

TEXT_IMAGES = ammo.png depth.png number0.png number1.png number2.png   \
              number3.png number4.png number5.png number6.png          \
              number7.png number8.png number9.png score.png shield.png \
              strength.png time.png velocity.png

SCMS = all.scm balls.scm frame.scm lines.scm screens.scm text.scm

IMAGES = $(BALLS_IMAGES) $(FRAME_IMAGES) $(LINES_IMAGES) $(SCREENS_IMAGES) \
         $(TEXT_IMAGES)

imagesi_DATA = $(IMAGES) game_index

if BUILD_IMAGES

$(BALLS_IMAGES) : all.scm balls.scm
	$(SHELL) run.sh tunnel-balls

$(FRAME_IMAGES) : all.scm frame.scm
	$(SHELL) run.sh tunnel-frame

$(LINES_IMAGES) : all.scm lines.scm
	$(SHELL) run.sh tunnel-lines

$(SCREENS_IMAGES) : all.scm screens.scm
	$(SHELL) run.sh tunnel-screens

$(TEXT_IMAGES) : all.scm text.scm
	$(SHELL) run.sh tunnel-text

# all images at once
# $(IMAGES) : $(SCMS)
# 	$(SHELL) run.sh tunnel-all

endif

EXTRA_DIST = $(IMAGES) $(SCMS) run.sh game_index

CLEANFILES = *~
DISTCLEANFILES = .deps/*.P
