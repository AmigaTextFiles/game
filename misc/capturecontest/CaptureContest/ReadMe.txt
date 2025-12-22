
Capture Programming Challenge for Amiga                         May 3, 2011

Last year I came upon a programming challenge/contest, run by the
ACM Queue magazine, that seemed like it might be fun.

From their description:

   Beginning January 11th, 2010, ACM Queue is offering an online programming competition
   based on the 2009 ACM International Collegiate Programming Competition (ICPC)
   Challenge problem.
   
   The Game of Capture is played on a [2D] field playing field 
   populated with many pucks. Each player controlls three playing pieces, a sled
   and two bumpers, The point is to use your sled to a draw closed loop around groups
   of pucks in an effort to convert as many as you can to your own color.
   The player with the most pucks at the end of a 90-second match is the winner. 

There are no mice, joy-sticks, or keystrokes involved, the two opposing players are
entirely controlled by opposing user-written programs sending control commands to their
moving "sleds" and "bumpers" via the game engine. The game engine in turn supplies
each player to the entire game state - sleds, bumpers, and the 112 movable pucks.

Unfortunately, Amiga programmers were almost locked out of the game, since

   "Participants will get to code a player in C++, C#, or Java
   and compete with others in a game called Capture."

Even if you worked in C++, you could not do any testing on the Amiga since the game engine
was a Java program.

Now I've generated an independent implementation of the game engine to run on AOS 4.1, to
see if I could do it, and to see if we could have some fun programming.

I think it is ready to have a go. The engine does the physics and graphics, so programming
your own player is not beyond a beginning or a rusty programmer, but programming a really
good player is a challenge for the best programmer.

The players and the engine are separate processes, communicating via Amiga pipes, so
it is open to anyone's favorite Amiga language, C, C++, E, Modula-2, etc.

Since I used my Aglet Modula-2 compiler to do the engine and also am supplying
sources for some simple example players in Modula-2, I'm hoping to spark some interest
in my favorite language.

I've also included however, as proof of concept, a working C source version of the RandomPlayer
in my doubtful C.

By now, a year has passed and the Queue 2011 contest was a different game. However,
as of now all their material for the 2010 game is still on-line. Their write-up of
the rules of the game and the format of the information that passes between the players
and the the game engine are well written and detailed.

See especially these URLs:

   http://queue.acm.org/icpc/game_description/main.cfm
   http://queue.acm.org/icpc/game_description/overview.cfm
   http://queue.acm.org/icpc/game_description/rules.cfm
   http://queue.acm.org/icpc/game_description/environment.cfm

The game runs pretty satisfactorily with the few example player programs I've written.
All testing has been done on a A1 and a Sam-Flex 440, both with Radeon 9250. 

Deviations from the Queue Descriptions
    The turn time runs at 100 msec as in the Queue description, but my implementation is
    a bit more relaxed about the timing. In the Queue version, if a player does not respond
    within 100 msec of the start of the turn, it simply continued the game without his move.
    The Amiga version will wait a bit for a late response, but will simply end the game immediately
    if it streches on to 250 msec.
    
    Instead of using standard input and output for communicating with the players, the Amiga version
    uses separately named pipes, which works well and seemed to be necessary for performance.
    
Players supplied:
    StaticPlayer            does no moving, keeps out of the way to make it easier to see what your player is doing.
    RandomPlayer            moves his sled and bumpers randomly, but can get in your way.
    RancomPlayer_C          as noted 
    RandomChasePlayer       moves his sled randomly, sends his bumpers manically after yours to no purpose.
    HerdPlayer              the only player I've written who makes real effort to use his sled and bumpers to effect.

    Note: even HerdPlayer has a few seconds of random moving at the start, in order to avoid exact game duplicates
          when playing this small number of opponents.
    
Executables
    <the above players>
    Capture                 
    CapturePlayback         a run of Capture can produce a trace file of the game, after which CapturePlayback will
                            simply display what happened. 
Traces
    test.trace              a trace of a sample game between RandomPlayer and HerdPlayer
    trace-Final.txt         a trace of the Queue contest's final match for the championship

Sources
    <the above players Modula-2 sources>
    C sources for my attempt to duplicate M2 RandomPlayer
    PlayerLib M2 module
    Capture game controller program
        
Tom Breeden
tmb@virginia.edu

