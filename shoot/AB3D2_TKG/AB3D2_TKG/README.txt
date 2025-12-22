Alien Breed 3D II - The Killing Grounds
---------------------------------------

This is the complete original version by Team 17, bundled with the TKG Rebuilt
Engine. No additional files are required. I put this archive together because
the source code release contains a large number of files that are not actually
required to actually run the game and I have noticed that other distributions
tend to include those unnecessarily.


Requirements
------------

You will need a 68020 or better, with at least 4MB of RAM. A 50MHz 68030 with
4MB of Fast RAM is considered the minimum spec. Either an AGA system or an
ECS/OCS machine with RTG is required.


Starting the game
-----------------

Simply double click the AB3D2 icon. The script will attempt to detect your CPU
in order to choose the engine build best suited for your hardware. The game
will ask you to choose a screenmode. The game was designed for a 320x256 8-bit
display, but will work at 320x240. You will have to adjust the display margin
in order to see the status bar at this resolution. For now, only 256-colour
modes can be used.


Custom Options Menu
-------------------

The Custom Options menu provides the following options:

   * Original Mouse:
      * Uses the original Team17 release mouse behaviour, with Right Mouse to
        move forwards.
   * Always run.
   * Show Messages.
      * This can be disabled if on-screen messages are distracting or for a
        very minor performance boost. 
   * Show FPS:
      * Shows the current FPS and frame cap.
   * No Auto Aim:
      * Disables the use of automatic aiming for projectile weapons
      * When in use, a crosshair is shown that can have it's colour changed
        between a number of high visibility options, or removed.
   * Hide Weapon:
      * Disables the player weapon model, for an additional performance boost.


Default Controls
----------------

When starting the game for the first time, the input defaults to keyboard and
mouse. The controls have been modernised since the original Team17 release:

   * W/A/S/D for movement and sidestep.
   * C for crouch/stand.
   * F to use/activate.
   * Space to jump/fly.
   * Left Shift to walk/run
   * Left Mouse to fire.
   
These keys are user-definable.


Fixed Keys
----------

Note that these keys may change in subsequent releases as various options are
consolidated. The following keys are fixed and not user-definable:

   * Esc to exit the current level.
   * F1 / F2 Adjust automap zoom.
   * F3 to cycle audio options.
   * F4 toggles dynamic lighting effects.
   * F6 toggles wall render quality
   * F7 cycles frame rate cap
   * F8 toggles between full and simplified shading:
      * Simplified shading gives can give a modest performance boost.
   * F9 toggles pixel mode.:
      * Presently this is only 1x1 or 1x2.
   * F10 toggles between 2/3 and full screen size.
   * Tab toggles Automap display.
   * K chooses keyboard-only input.
   * M chooses keyboard and mouse input.
      * Repeated selection chooses between normal and inverted mouse mode.
   * J chooses joystick/joypad input.
   * Numeric Pad +/- adjust vertical border size.
   * Numeric Pad * exits to the desktop.
      * Note this happens whether in the game or in the menu. Handy for
        rage-quit!
   
When the Automap is displayed:

   * Numeric Pad 5 centres on the player.
   * Numeric Pad 1/2/3/4/6/7/8/9 scrolls the map in the implied direction.
   * Numeric Pad . (period) toggles green/transparent overlay mode.

When the Automap is not displayed:

   * Numeric Pad 7/8/9 adjust gamma (7 decreases, 8 resets, 9 increases)
   * Numeric Pad 4/5/6 adjust contrast (4 decreases, 5 resets, 6 increases)
   * Numeric Pad 1/2/3 adjust black point (1 decreases, 2 resets, 3 increases)

All options are persisted on clean exist. Display options are persisted
independently for AGA and RTG screenmodes.


Configuration File
------------------

When the game is exited, the current settings are written to a text file,
'prefs.cfg'. This contains the key bindings and a number of other settings.
Generally, you shouldn't edit the settings in this file. However, if you have
an Akiko equipped system (CD32 or FPGA) without RTG, the following settings
may be of interest for the 68030+ binary:

   * vid.prefer_akiko
      * Set this true to use Akiko for C2P if available.
   * vid.akiko_mirror
      * Setting this to true tells the C2P code to read and write from mirror
        addresses. This can help if the display becomes garbled.
   * vid.akiko_030_fix
      * For 030, this option freezes writes to the datacache during C2P. This
        can help in some cases if the mirror option doesn't work, but is
        considered dangerous.


Known Issues
------------

Intermission screens are not shown. The original game switched between a hires
and lowres display mode in order to show the text introduction and end game
narrative. While this worked well on PAL monitors of the day, Resolution
switching is not ideal for RTG, particularly with CRT displays. A future
update will reintroduce intermission displays without changing the screenmode. 

In AGA fullscreen 1x2, messages are not rendered. This is due to a limitation
of the pixel doubling method. There may also be some instability at this
resolution.


Updating the Engine
-------------------

From time to time, there will be updates to the Rebuilt binaries. Simply
replace the contents of the Bin directory with newer versions. Use the
standard AmigaDOS Version command to find out exactly which you have.
For example:

   Version FILE FULL tkg_release_030
   tkg 1.0 (15/11/2025)
   68030+ build #12: commit 99495ed 

This corresponds to version 1.0.12.

The latest stable updates will always be posted to aminet, at:

https://aminet.net/package/game/patch/AB3D2_TKG_Rebuilt


