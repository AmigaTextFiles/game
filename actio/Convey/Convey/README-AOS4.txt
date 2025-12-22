CONVEYSDL VERSION 1.3 august 2005

This is convey sdl (c) cloudsprinter.com

add -fullscreen on exe to enable fullscreen

I knocked this game up over a couple of days, and can't be
bothered coming up with a suitable story line.

The objective of the game is to collect all blue blobs on
the conveyer belt and then cross the finish line, if you
miss any you will be taken around again.

KEYS:

arrow left=left	arrow right=right	<space>=jump

q=exit

you cant jump right after you land!

enjoy.

-----------------------------------------------------------

Currently the games has -7- levels 
updated august 2005
deigned by :-

Me.

-----------------------------------------------------------


LEVEL DESIGNER

yes, you can design you own levels with this game!

I'm hoping people who like this game will design some levels
and mail them to me so it can be a nice big game.

If you look in the levels directory you will find some files
called level suffixed with their number, also a file called
info, info is the ammount of levels there are in the
directory, this number must be 3 digits so for one level 001
for 13 levels 013 or for 873 levels 872, i dont think 872
will happen due to directory objects constraints, if people
do make more than 70 levels i will alter the code to handle
it and add a password system.

In the level files the first line is the ammount of lines
of tiles there are, the following lines are the actuall
level each part must be 6 characters wide and end with a 
return, i use zap with logical line numbers displayed to
make levels, this way i can tell if i have the return and
can easily tell how long the level is.

the numbers represent as follows

1-floor	
2-hole
3-red blob
4-finnish line
5-jump pad
6-shift right
7-shift left
8-cracked tile
9-speed up
0-slow down

the finish lines pads can go anywhere, only if you have 
collected all the red blobs and go over a finish square will
you advance a level

shifting to off the level will not do anything, you will
remain on the track

jump pads will make you land 2 squares further up the level
so you can have a jump pad followed by a hole and land the
other side safely, assuming there is floor to land on!

cracked tiles have the same effect as holes, they are just
not as visible


currently the maximum lenght for a level is 1000.

if that makes any sence well done!

-----------------------------------------------------------

email: N.White@moose.co.uk - send your levels!

http://www.cloudsprinter.com/software/

-----------------------------------------------------------
LOG:

started writing this afternoon

finished off today (started yesterday)

converted to C & SDL

8/5 improvements

ENDLOG
-----------------------------------------------------------
TO DO

ok, i've improved the gfx and stuff a bit for this game
but i really cant be arsed with a high score thing so
if you want you can do that and mail it to me, there you
go.


-----------------------------------------------------------

this game is released under the GPL if you didnt get a copy of the gpl with this game it's because i didnt include one.


N.White@moose.co.uk

   .___________________________________________________________.
   |                                                           |
   |       A M I G A   O S   4 . 0   C O M P I L E   B Y       |
  ._______                                        .______.     |
  |  ____/________________________________________|      |__   .
._|____._         |      ._       |      ._       |       _/______.
|      |/         |      |/       |      |/       |      |/       |
|                 |      _________|               |               |
|_________________|______|spt/up  |_______________|_______________| 
   .                                                           .
   |                                                           | 
   |   I am in a shitty economical situation, so if you feel   | 
   |  that what I do is  worth anything, use paypal to donate  |  
   |         to my email addy, spotATtriadDOTse, thanx!        | 
   |                                                           | 
   |                    Spot / Up Rough 2006                   | 
   |___________________________________________________________|
