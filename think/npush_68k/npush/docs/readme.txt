nPush

Compiling and running the game
------------------------------

You need a C++ compiler (GCC 3.2 or higher probably) and development version
of ncurses library. When ready, just type:

make

and if you get no errors, run the game:

./npush


How to create levels
--------------------

- Levels are simple textual files without any extension in the file name.
- Just name your level file Level* and the game will pick it up.
- Level files are sorted alphabetically in the menu.

Some rules:

- make sure you have at least one player(@), gold($) and exit(x) in the level
- there can be multiple of all of those (players are switched with TAB key)

- since level characters are automatically detected, you can use , and ; marks
  if you just want to print those characters on the screen (as comments)
- Comma (,) is used for regular comment, and semi-color (;) for bold letters
- Rest of the line after those two characters is ignored by the game

If you make some levels, make sure you contact us at:
richmondavid@users.sourceforge.net

Also feel free to contact me regarding any bug reports or ideas.


License
-------

nPush is released under GPL version 2 or above. See file COPYING for details.


