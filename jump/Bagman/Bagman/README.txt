Bagman remake by JOTD in 2010

Original game by Valadon Automation
ROM strings show that it has been coded by Jacques Brisse (still head of Valadon)

Game has been resourced (Z80) and guard behaviour/speed has been reproduced
as faithfully as possible.

Options:

-a: panoramic 3-screen windowed mode
-s: no sound
-g: direct game
-j: joystick
-i: invincible mode (not working)
-f: full screen (lower part truncated since no HW rescaling)

Keys:

- joystick or cursor keys: directions
- fire or ctrl: action
- P: pause
- ESC: quit current game
- F10: quit program

What's better than the MAME version:

- game is slightly less unfair when you change screens with guards tailgating you (in the original game
  you find guard ahead of you in the next screen and you die). Same thing with the wagons
- guards have some extra animation when killed (same as the player actually)
- sometimes AI seems better than the original, in particular when guard are stuck
- panoramic mode (Windows version only)
- fadein/fadeout effects
- C++/SDL source code included means fully portable
- original Z80 asm source included (not fully resourced, but there's most of the interesting parts)
- settings/DSW that you can save
- eats a lot less CPU than the MAME version
- MAME version needs to hardware scale the screen in full screen mode. This version changes screen layout:
  no need for rescaling => no blurry pixels
- fully credits Jacques Brisse for his work :)

What's better in the MAME version:

- music
- slightly less buggy AI
- high scores


The DS has Bagman running from MarcaDS but the emulator is bug ridden and slow. So I'm happy I could write that one, even
if you have to turn your DS to play
