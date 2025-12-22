Syobon Action
=============
This is an improved version of the SDL version of Syobon Action (also
known as Cat Mario or Neko Mario). The original website is at:
http://www.geocities.jp/z_gundam_tanosii/home/Main.html (if you
understand japanese). The port is based on David Gerber's improved
Open Syobon Action.

Control and keys:
-----------------
The game plays either with the keyboard or a joystick.

F1 = main menu (press during play)
K = suicide (kill)
space = speed mode
1-9 durning main menu = stage select
0 during main menu = randomized level

Changes:
--------
- added AROS port
- added fullscreen mode (by default)
- added '-window' argument to run the game in a window instead of fullscreen
- fixed sound lag introduced in SDL version
- improved sound quality
- added game over effect on exit
- fixed "off by one" pixel bug when blitting reversed sprites introduced in SDL version
- pressing 'k' will commit suicide, instead of 'o'
- translated japanese text to english
- prints which stage is selected when pressing 1-9 on the main menu
- fixed joystick code which was completely broken on windows
- added more joystick buttons for jump
