Eremit v 1.0 Made by Andreas Henningsson
Distributed as GPL software. THIS SOFTWARE COMES WITH ABSOLUTELY 
NO WARRANTY! USE AT YOUR OWN RISK! Send bug reports to <andreas.henningsson@telia.com>

ABOUT:
This is a rewrite of an old game that I made using Clanlib(www.clanlib.org)
in C++. This time it's written in C and using another game library
called SDL(www.libsdl.org). 

Reported working on:
Linux Fedora Core 1 
Linux Suse 9.0 

COMPILING:
To compile you need this installed
	SDL
	SDL-devel
	SDL_image 
	SDL_image-devel 

On a redhat system simply use up2date, eles get it from the SDL homepage(www.libsdl.org)
	'up2date SDL'
	'up2date SDL-devel'
	'up2date SDL_image'
	'up2date SDL_image-devel'

When cd into the Eremit dir and type 'make'

Run game by typeing './eremit'

HOW TO PLAY:
Select the ball you want to move with the mouse 
(a green frame will surround it) then select 
an empty square thatyou want to move the ball to. You can only jump 
over one ball at a timen and only balls that are left/right/up/down 
from the selected ball.The goal with the game is that you in the 
end only should have one ballleft( then you win ).

KEYS:
	Space	reset the game
	Esc	quit the game
