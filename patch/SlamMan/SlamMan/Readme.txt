**
** SlamMan -- The SlamTilt HighScore Manager
**

Becouse, SlamTilt can store 5 highscores, but maybe all from the same
person. If two or more person - with different skill - playing with
SlamTilt, it's unavoidable to slip off some of them from the highscore
table. To avoid this effect, I wrote this little util. With this manager,
you have to only one item on the highscore table. But you have to pay
attention to write the same name every time.

The usage is very very simple. Just start it without any parameter. From the
SlamTilt's directory. (You have to 'cd' there, if you don't want it,
recompile it.)

You have to start it every time, before start the game. You may create a
script to start it before you start the game:

cd Games:slamtilt
Assign SYS: System:
Assign C: SYS:C
shm
start


If something goes wrong, you'll see a nice (?) requester.

WARNING!
Make a backup copy from your original highscore table, before use it!
Freeware, no warranty!
Files to modify:
	Demon.Dat
	Mean.Dat
	Pirate.Dat
	Space.Dat
WARNING!

