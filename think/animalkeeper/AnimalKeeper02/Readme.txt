Animal Keeper 0.2


Background

Animal Keeper is a clone of a popular Flash game called Zoo Keeper. There are
some Zoo Keeper clones for other platforms like Monsterz and Bejeweled.

Animal Keeper for AmigaOS is still work in progress and it's lacking in many
essential areas like music and general polish but it's quite playable already.
The main purpose is not to make a 1:1 copy of the original, I just wanted to
write something similar for AmigaOS.


Playing the Game

The main idea is to swap two animals horizontally or vertically so that there is
at least 3 adjacent animals (of the same kind) in a row or column. After that
the animals will disappear and new ones will drop to the board.

At the same time, the timebar is reducing so you can't think your moves too long.
Some extra time is be gained by connecting similar pieces on the board.

Select a piece by left-clicking it. It should start flashing now, and choosing a
left/right/up/down neighbor of the flashing piece attempts to swap the
pieces. Only swaps that lead to an animal triplet, are succesful.

Sometimes there is a special piece on the board that is cycling between all
possible animals. Clicking this piece with the left mouse button will remove all
of that kind animal pieces from the board! The probability for this piece to
appear is 1:5.

If there are no moves left on the current board, it will be resetted.

If time runs out, player's score is checked against highscores and good players
will get their names to the list. Use keyboard to enter your name (max 8 chars)
and ENTER to finish, BACKSPACE to delete previous character.

The game will be auto-paused if the input focus shifts to another window. The
view will be faded out to prevent cheating on time.

If there is more than one tileset available, you can use SPACE to swap between
them.


Customizing GFX

Currently the graphics are loaded from 256*32 bitmaps. The game supports multiple
tilesets. These must be stored in the "gfx" directory.

Animation & bigger tiles are on the TODO list. At this time, a tileset may
consist of 8 pieces (size 32*32). Graphics are loaded with datatype support.


Customizing SOUND

Sound samples are in "sounds" directory. There are currently 9 samples for
different purposes. The list follows:

gameover
highscore
joker
key
levelup
new
remove
select
swap

Samples are loaded with datatype support.


Changes to 0.1:
- highscore
- levels
- sounds
- additional tileset by "Herewegoagain"
- animal stat view (goes from red to green when enough)
- auto pause
- 8th piece
- support for multiple tilesets
- bugfixes
- more bugs


TODO

- font system
- full screen?
- music
- contributed gfx
- menus
- optimization
- ...


Credits:

Original idea - Author of Zoo Keeper!

Coding - Juha "capehill" Niemimäki
Tileset + icons - Martin "mason" Merz
Additional tileset, gfx and ideas - "herewegoagain"
Testing - Tony "ToAks" Aksnes
