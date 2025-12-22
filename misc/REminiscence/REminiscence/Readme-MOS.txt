                        REminiscence 0.1.8R2 - MorphOS
                        ------------------------------
                        

 This is the MorphOS port of REminiscence, 
 the open-source engine of Flashback.

 Requirements
 ------------

  . MorphOS 1.4
  . PowerSDL 10.5
  . Original Flashback MS-DOS version data files
  . Amiga version mods (optional)


 What's new ?
 ----------

  Enhancements in the engine:

  - fixed crash in MOD player 
  - fixed minor glitch with in-game save switches


  MorphOS specific:

  - removed un-needed VERSION tooltype
  - fixed path problem


 Usage
 -----

  1) From Ambient, REminiscence understands the following tooltypes:
  ---------------

   .DATAPATH: specify the directory containing the datafiles (must *not*
              include the ending '/')

    => default: PROGDIR:Data 

   .SAVEPATH: specify the directory where to put saves (must *not*
              include the ending '/')

    => default: PROGDIR:Saves



  2) From CLI, REminiscence understands the following arguments:
  -----------

   --datapath=<DIR> : directory containing the datafiles (must *not*
                      include the ending '/')
   
   Default is PROGDIR:Data
   Example: --datapath=games:Flashback

   --savepath=<DIR> : directory where to put the savefiles (must *not*
                      include the ending '/')
   Default is PROGDIR:Saves

 
  NOTE: When playing cutscenes, REminiscence will look for the following mod files
        and will play them if present: (they must be put in the same directory as the
        other data files)

        mod.flashback-ascenseur
        mod.flashback-ceinturea
        mod.flashback-chute    
        mod.flashback-desintegr
        mod.flashback-donneobjt
        mod.flashback-fin
        mod.flashback-fin2
        mod.flashback-game_over
        mod.flashback-holocube
        mod.flashback-introb
        mod.flashback-jungle
        mod.flashback-logo
        mod.flashback-memoire
        mod.flashback-missionca
        mod.flashback-options1
        mod.flashback-options2
        mod.flashback-reunion
        mod.flashback-taxi
        mod.flashback-teleport2
        mod.flashback-teleporta
        mod.flashback-voyage

 A compatible set of MODS is available here: 
 http://exotica.fix.no/tunes/unexotica/games/Flashback.html

 Just download the archive, uncompress it, and move mod#? files in
 the directory where your Flashback datas are stored.

  
 In-game keys
 ------------

  Arrow Keys      move Conrad
  Enter           use the current inventory object 
  Shift           talk / use / run / shoot
  Backspace       display the inventory
  Alt Enter       toggle windowed/fullscreen mode
  Alt + and -     change video scaler
  Ctrl S          save game state
  Ctrl L          load game state
  Ctrl + and -    change game state slot



 Known-Problems
 --------------

  1. Switching from/to Fullscreen mode may crash. This is a known PowerSDL problem and
     I cannot do anything about it :(

  
 Licence
 -------

  REminiscence is distributed under the terms of the GNU GPL.
  See included COPYING file for more information.

  Full Sources can be downloaded at: 
  http://nogfx.free.fr/warpdesign/soft_mos.php3


 Thanks to
 ---------

 .Delphine Software for their amazing game :)
 .Gregory Montoir, for his work on REminiscence (cyx@users.sourceforge.net)
 .PowerSDL team 


 Contact
 -------

  Nicolas RAMZ - http://nogfx.free.fr - leo.nard@free.fr
