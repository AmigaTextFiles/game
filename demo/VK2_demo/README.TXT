##############################################################################


VIRTUAL KARTING II:
  Copyright Fabio Bizzetti 1998
  Licensed by Islona Games, distributed exclusively by Epic Marketing
  Design,Program,Graphics,SoundFX by Fabio Bizzetti
  Music by Ruben Monteiro
  Tracksdisk1 design by Fabio Bizzetti
  Tracksdisk2 design by Jonny Johansson

  Release date: 16th May 1998


##############################################################################

This is the demo of Virtual Karting II, you can play it for 3 minutes and 30
seconds max, then only the auto-driving demo will be available. You must re-run
the game in order to play more.
NOTE: the sales version full game *can* quit to AmigaDos/Workbench, but this
feature has been disabled in this demo (the Quit option in the Options Menu
just makes you return to the Main Menu). This to avoid that the "3 minutes and
half" time limitation becomes useless (now you have to reboot in order to play
the game again).
Why this? Because the aim of this demo is to let you try the game and decide
if it's worth buying or not. Please remember that if you like the game, to buy
it means to support who spends his time to support the Amiga (the developers)
and who invests their money (the publishers and the users that buy originals).
The sales version full game isn't even protected, because those who bought
the original shouldn't be bothered with copy/manual protections and such. If
you use a pirate copy, remember you're fully responsible (as the others like
you, but not less) of the death of the Amiga, because the Amiga developers
and publishers have to leave the Amiga, considering the market situation that
piracy causes. We can still develop for a small market, but we can't develop
for pirates.

Note: in the sales version full game (but only in the CD version) you find
as extra another 3D videogame, CyberMan. It includes sources and other extras.


##############################################################################

List of VK2 features:

#Six Tracks, from easy ones to professional.

#Up to 50fps on unexpanded A1200's. Exploits also faster CPU's and fastram.

#Can be ran from hard disk, cdrom or floppy drives (disk swapping occurs
 only if you select another tracks disk).

#Both 3D and 2D modes.

#The 3D engine supports objects on the road, reflections on the water, and more.

Two karts types are simulated:
 125cc: 2 stroke engine (38 HP / 14700 r.p.m. ), 7 gears.
        It has a rotating disc valve in the intake and it doesn't have
        an exhaust valve; this gives more power but a very nervous
        erogation, expecially in the peak r.p.m. It has no real useful
        torque under 8000 r.p.m. These characteristics make it a very
        hard kart to drive with manual gears, and a difficult one even
        with automatic gears. But a very powerful kart also, ideal if
        you're a skilled driver.
  80cc: 2 stroke engine (25HP / 13800 r.p.m. ), 6 gears.
        It has a reed valve in the intake and an exhaust valve; this
        gives less power but better torque erogation, and makes it be
        a very simple kart to drive.

#Both manual and automatic gears are available, and a special "easy mode".

#This game is realistic, so don't expect to pass all the karts easily.
 All the karts (including yours) have the same, identical performance.
 The difference is made uniquely by the skills of the driver (i.e. you
 or the 5 karts piloted by the computer).
 The game includes realistic wake simulation routines. Thus when you
 follow a kart and you are near to it you have better aerodynamics and
 you can more easily pass by, just like in real life. Skilled drivers
 will pass the opponents delaying as much as possible the use of the
 brake before a bend.

---

VK2 main improvements over VK:

# Twice as many tracks.
# 2x1 resolution, and improved dithering (interlaced mask).
# Objects on the road.
# Reflections on the water.
# Easy mode for beginner players.
# Fire-button-to-accelerate option for who prefers it. Keyboard option.
# Now the karts are 80cc and 125cc, more logical than 100cc and 125cc.
# Faster (now 50fps on unexpanded A1200's using old VK detail, or 25fps 2x1).
# Engine sound slightly deeper.
# Bugfixes.
# No need to enter protection's manual colour codes anymore.

---

[Development history]
The history of the development of this game starts in 1994. I was a kart
driver, but didn't have much money, at all. I had the possibility to race
at quite high levels, but you need much funds for it, you need to go each
weekend in a different town, you need a way to transport your kart, you
need a good kart. All expensive things I couldn't afford, and there was
the school also to make it even more impossible. So, as it happens to
many people I guess, I had to renounce to a dream, that for me was racing
in a real championship.
In the while I was developing some fast 3D routines for my A500, but the
computer just wasn't fast enough to reach neither 8-12fps. I got my A1200,
and started experimenting with the AGA registers to see if some tricks
were possible to speed up any 3D mode. At that time my monitor was broken,
so I had to use a TV, and the video mode I invented looked damn good there.
Months after I got my RGB monitor back, and the video mode looked worse
there, but the speed advantages were so huge that I decided to use this
mode anyway [note: I gave a technical description on Usenet time ago].
It allowed an unexpanded A1200's to handle 3D graphics at 25fps or even
50fps, while the same performances using chunky to planar routines would
have made it from 5 to 10 times slower. I didn't care much about graphics
quality on RGB monitors considering the speed advantages of this invention.
So the first thing that came into my mind has been "I wanna make a kart
game with it!", because I was still dreaming karts almost each night (and
those girls with an umbrella to make shadow on you at the starting line :) ).
I already had material for the kart game. I used to elaborate the engines
of my kart and of my motorbike, and already had written programs to help
me making choices about what to change, etc.. expecially an AmigaBasic
program that, given in input the torque (or power) curve of the engine,
the mass of the vehicle, the cx and section, the gear ratios, etc.. simulated
accurately the behaviour of the engine on a flat road, as acceleration,
speed, etc.. So I could know for example if I needed more torque or peak
power, or if I needed to change the transmission ratio, and how.
I was also working on a programming language and compiler, called HLA
(High Level Assembly), and it took very little time to port that code to
HLA. Some time after I added the 3D engine, and a first demo of the game
was ready. I sent it to many big Amiga publishers of that time.. Virgin,
Psygnosis and many others. Got very positive replyes, and was going to
sign with one of them, but the situation of Commodore was getting worse
and worse, and my game was at the begin of its development. All the big
publishers quickly abandoned the Amiga, and one year after I got a finished
game but no publisher (note: some months after Virgin published a PC game
called "Virtual Karts", and many other karts game have appeared on PC since
then). Only small companies were still interested in publishing Amiga games,
and of the ones that were interested, I chose OTM, because they were making
the best offers, they were the most ambitious, the most fond of the Amiga,
and many other business-men lyes that at that time had a big value to my
eyes and to my passion for the Amiga.
Virtual Karting got published, but due to deadlines (OTM wanted it to be
released before Christmas'95) it didn't have many features I wanted it to
have (the objects feature was ready, but I had time to "physically" place
objects only on one track.. and not even all of it, so this and other features
had to be disabled). After handing over to OTM the "final" version of the game
I anyway kept on working on it, to add all those features I felt it needed.
I loved this game as much as I loved karts. Many problems began when OTM had
to start paying, until the delays became "just won't pay anything anymore".
I had a bad time, and fortunately having an Internet account I managed to
denounce publicly the problem, till OTM has been forced to pay. They didn't
even pay all, and they got bust by other people or other companies. For
personal reasons I stopped the new development, all my enthusiasm for the
Amiga remained as much as my belief that I could get a job out of it instead
diminished more and more, till becoming almost null. In the while I was
developing a new concept of 3D engine, revolutionary, but I thought it was
too precious to even think about making an Amiga game with it and then meet
another OTM. It would have meant to give it for free, and all my professional
hopes were in that 3D technique, I didn't want to distribute an executable
and then get hackers disassemble it and understand all about this technique,
that was totally original and extremely different than the polygon-based
3D engines that were being developed and studied by almost everybody at that
time. Some months after I signed another contract, this one with Guildhall
Leisure, for the distribution of the budget version of Virtual Karting.
There was some money guaranteed, and although the dates were clearly specified
in the contract, I got this money after many months of delay, and only after
a lot of unanswered faxes, phone calls, and the treat to make public damain
of this problem. Still they owe me money for the copies they sold in excess
to those guaranteed. It's clear that the last thing I wanted to make was
any other Amiga game in the future. I just couldn't stand all the stress and
troubles coming from dealing with such kind of publishers. However, I was
getting emails from some publishers interested in the publication of the
new version of Virtual Karting, and I replyed to all them but I couldn't
trust any of them (I heard the usual phrases like "dont worry, it'll sell
10000+ copies", or "we'll pay regularly", etc.. but when I asked for some
concrete guarantees (as money in advance) some didn't even reply anymore..
Anyway, I trusted one of these interested publishers, Islona/Epic, because
it sounded really serious, and I heard only positive things about them
anyway from other developers. So I restarted working on the game, to finish
all the unfinished parts (I got much help from friends, they designed the
new tracks, like Jonny Johansson that designed the 3 new tracks, and other
fellows that designed 2 other tracks I haven't been able to include). I'm
happy about finishing this game, I just hope it has been worth anyway.
I may even restart making completely new games for the Amiga if it pays
back (not only in terms of job, but equally importantly in terms of non
getting into troubles and in getting personal satisfactions from it).
Now a small hint that really few know about this game, and that may interest
some players that really like the game: the "27" on the kart is in honour of
Jean Alesi, when he was racing for the Ferrari.
Anyway, the spirit of this game is speed, speed and speed. The more you
drive by pure instinct, the more you see your lap times improve and improve.
You've to get that fully adrenalinic instinctive feeling that you can get
on a real, professional kart. And, who knows, after becoming a skilled VK2
player you'll want someday to go to a real karts' track, get a good kart and
finally fully understand why I made this game.


Fabio Bizzetti, 7th April 1998

##############################################################################
