Welcome to the Jake and Peppy alpha playable preview!

Please view the game manual in this archive (PDF file).
This has details on controls, requirements, etc. You can view the PDF on
the V4 Standalone, V4 FIREBIRD, V4 ICEDRAKE, or V4 MANTICORE with the
appropriate software, or on any other minor platform you
wish to use.

NOTE: 10k core is highly recommended! The game runs silky smooth on this core.
Users on the old R5 core will only have keyboard support, as extra USB
functionality arrived with the R6 core.

All game graphics and sound for Jake and Peppy is original, except for
the few royalty-free or public domain assets below which have been 
modified for the game:

dreamstime.com: Dinosaur bones
craftpix.net: Medieval block set
datafont.com: M04 Fatal Future font
Zapsplat.com: for a few extra sounds
Opengameart.org: crate graphic

QSEC Team.


CHANGELOG
---------
V0.90 05/05/2024
- NEW: Integration with the Ultimate Expansion Board! "Jake and Peppy" shown on LCD screen. The glowing "V4" logo on the board lights up when your ship takes a hit!
- NEW WEAPON added: The BFG!
- NEW ENEMY type: The red eye-blob
- NEW LEVEL added: The Red Menace
- NEW BACKGROUND (lava)
- IMPROVEMENT: Changed fire buttons on the gamepad: A is primary weapon; B is secondary weapon.
- IMPROVED weapon balance.
- BUG FIX for some audio channel configuration.
- BUG FIX for enemy counters when using the HAMMER.
- The obligatory "more stability for improved user experience".

V0.85 29/12/2021
- NEW WEAPON added: The HAMMER.
- NEW FEATURE added: Rewriting of game engine object handler to allow for compound objects.
- NEW BOSS added: Lazy Eye, with new sounds and graphics
- NEW SUBGAME function added: Gem puzzle.
- NEW FEATURE for subgame: added 'easy' and 'hard' modes.
- NEW FEATURE added: health bar to boss enemies.
- IMPROVEMENT: added sin tables for speed optimisation.
- NEW FEATURE: Screen shake implemented for large impacts.
- NEW AUDIO TRACK added from SampleMind: Math Max
- BUG FIX for player ressurection. Still a gremlin in here, but not critical.
- BUG FIX for collision detection on walls, to stop players getting 'stuck'. 
- BUG FIX for collisition detection on players/enemies for a rare condition which resulted in player health being continually drained.
- BUG FIX for the v0.70 level 2, which broke the warp gate (couldn't finished the map).
- BUG FIX for some mis-placed graphic tiles in levels.
- BUG FIX for player flashing upon multiple hits, resulting in a conitnual white graphic.
- BUG FIX for crate explosion sounds.
- BUG FIX for a font offset error for one character.
- IMPROVEMENT to HUD layout. Added level goals, and rearranged positioning.
- IMPROVEMENT: Added code for ensuring sequential levels play different music tracks.
- NEW LEVEL 1 for v0.85 created (Lazy Eye boss)
- NEW LEVEL 2 for v0.85 created (Gem puzzle)
- NEW LEVEL 3 for v0.85 created (Large Euler level, with hammer weapon)
- Multiple other fixes and improvements ("General game stability improvements to enhance the user's experience", or "This software update improves system performance", if you prefer to use the modern terms!)

V0.80B 13/08/2021
- NEW ENEMY Fire turrets added.
- NEW ENEMY flames added using AMMX accelerated transparency.
- NEW FEATURE added: Spot-light mode, accelerated using AMMX.
- NEW high-resolution ship rotations added! This was the most requested feature from feedback.
- IMPROVEMENT to ship flame gfx: fully antialiased now using AMMX.
- IMPROVEMENT to game engine: Optimisations has resulted in a 30-40% framerate increase!
- NEW explosions added to hit enemies using AMMX accelerated transparency.
- IMPROVEMENT to bullet graphics; tidied up.
- CHANGE to default ship loadout; tweaked graphics and parameters for better 'Arcade' style gameplay.
- NEW Critical hit Changes and Critical Hit damage implemented.
- IMPROVEMENT Some further optimisation to the asm graphics code.
- IMPROVEMENT to management of WARPS and addition of further level editor options.
- IMPROVEMENT to animation management.
- NEW LEVEL 1 for 0.80 created.
- NEW LEVEL 2 for 0.80 created.
- NEW tileset colour variation added
- BUGFIX to start of level bug where the previous thrust direction was undefined/not reset.
- NEW FEATURE added: hit-stats added to enemies when hit.
- NEW FEATURE added: small explosions when player bullets hit walls and other objects that are not enemies.
- CHANGE to control system: ship now moves with direction (no thrust button-press required)
- NEW FEATURE added: press 'M' in game to start/stop music playback. Also, this feature is available in the in-game menu (ESC).
- Many, many, small BUGFIXES, core IMPROVEMENTS, and tweaks.

V0.75B 29/05/2021
- BUG FIX in controller input management (couldn't select items with gamepad properly when changing build). A new button press is required when hovering over items now when in the hub.
- BUG FIX in Level 3 map, which had an invisible enemy on the map which caused damage when hovering over it.
- BUG FIXES to the game engine and memory management.
- IMPROVEMENT to tile graphics. Cleaned up discontinuities.
- IMPROVEMENT of various graphical elements, such as little explosions when bullets hit walls.
- IMPROVEMENT to multi-shot scatter to maximise area coverage with 8-way directional play. This is now the base loadout for the ship.
- IMPROVEMENT to map editing/loading for setting of properties of all in-game objects.
- NEW FEATURE added: mini-map, with fog-of-war and transparent overlay.
- NEW FEATURE added to graphic functionality: 24-way directional sprite handling added.
- NEW ENEMY added: fireball wall turrets.
- NEW WEAPON added: homing missiles.

V0.7E: Minor improvements
- Default to 'KID MODE' on, for new players who struggle with the default difficulty.
- Tweaked audio playback, to accomodate changes in audio for the upcoming core R6.
- Fixed some typos in the game text.

V0.7D: First public release 09/04/2021
