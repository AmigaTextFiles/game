***************************************************************
*COPYRIGHT                                                    *
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*
* This Game can only be redistributed in its original form.   *
* If you update this game do not release it till I have       *
* approved it.                                                *
*                                                             *
* If you wish to sell this game or a game based on this for   *
* profit then contact me.                                     *
***************************************************************

Make sure  you  rename the  disk fireflies is on as "fireflies"
and not "fireflys". If the disk is not called  "fireflies" then
it will not load. However  if on  a  hard drive you must add an
assign statment to your start up assigning the directory it  is
in as fireflies.

FIREFLIES

As far as I  know  this  game  is  totally  original due to the 
obscure nature of  its  conception.  The  game  is deliberately 
simple so I could get  it  finished  working on my own.

In this game you have to kill  all your rival male Fireflies to
further your chances of mating.

On your first go I  suggest  you  ignore the options just press 
return many times on the options screen.

You should be on the game screen  now, in fact if you are still 
reading this then you are probably  dead. Press return to start 
the next round.


CONTROLS:

                  fly up                      /----\
                                              |Fire|  dive down
                    ^                         \----/  on the
                    I                                 closest
     fly left   <---+--->   have a guess              opponent
                    I
                    v

                 fly down


There should be  two  fireflies   on  the  screen  one computer 
controlled and the other controlled  by  you. You must kill the 
computers one to do this you must  fly above him then dive down 
on him.

When two Fireflies collide the  one  moving  down fasted at the 
time of  collision  will  knock  the  other  unconscious.  If a 
firefly flies to close to  the  water  it  may  be eaten by the 
fish. The kingfisher on  the  branch  indicates the position of 
the fish.  The frog will also kill if you are not careful. Just 
see that you opponent comes to  some serious harm. Keep playing 
until you can beat the computer.

You can have up  to  five  players.  As you play you might find 
it fun to punch  your  opponent if  he kills you. For more than 
three players  you  will  need   a  four player adaptor in your 
parallel port. I have  not tested  this option yet because I do 
not own an adaptor  or    four    working  joysticks (so it may 
not work).  The fire  button  will  allow  you to swoop towards 
the nearest attackable firefly.

New in version 1.2

The frog is optional: Turning the frog off will produce a slite
speed up.

Adjustable tail length: this is in response to comments that it
easy enough to tell which is your firefly.It will also speed up
the game a lot if  you  have  slow  Amiga  allowing you to have
more players. By setting the tail length to 0 you can make your
player invisible this can be a lot of fun.

I have included the source  code if any one wants to expand the
game here are a few ideas:
 
1) Females in mating mode: These  will fly above the lake, when 
they are ready to mate  they  will  flash  a sequence of pulses 
using their light.  You  must  repeat  this  sequence with your 
light. You must then fly up to the top of the screen as fast as 
you can. The female will follow you and mate with you.

But your worries  are   not   over   yet,   after   mating  the 
fireflies remain joined end to  end. This inhibits their flying 
ability so that they can  not  maintain  a constant  height and 
slip down the screen.   To  disengage  the fireflies  you  must 
try to find the  correct  combination of  joystick  manoeuvres. 
If  you  can not disengage before you get to the water then you 
will be eaten by my fish or my frog.

2) Glow-worms:  After mating the female will fly to a tree, the 
bank or a bull rush and  lay   her  eggs  which hatch into glow 
worms (represented by pixels the  same  colour  (but at a lower 
intensity) as their father).

3) Intelligence: Have  about  ten or twenty male  fireflies  to
choose   from.  Each   with  its  own  personality.  This  will
include  differing  tale lengths,  different  masses, different
acceleration,  different  AI  routines  and  varying amounts of
sexual magnetism.

The females will  have  varying  intelligence. More intelligent 
females will give  a  longer  sequence  of  flashes  which need 
repeating.

They    will     also     require     a     more    complicated 
disengagement sequence which has  more  steps  (I will actually 
make it so that the  females  series  of flashes can be decoded 
to give away the disentanglement  sequence  (but it will take a 
die hard player to work this out)).

After the male has given the  correct sequence of flashes there 
will be a docking manoeuvre, ie  male and female fireflies must 
collide. The tarty females  will  head  for  you  like a bullet 
(depending on your  sexual  magnetism)    barely   giving   you 
time to reach the top   of   the  screen.  Intelligent  females 
may be a little more shy  and  back  off  when you make a move. 
Intelligent females will be  more  reluctant   to   mate   with 
aggressive males who  murder   other   males,  where  as  tarty 
females find nothing  more   appealing.   you can increase your 
social     standing    by tormenting the  fish  making it  jump 
without catching you or irritating the frog so it jumps off its 
lily pad.

More intelligent females give  birth  to more intelligent glow- 
worms which stand a better chance  of  survival. If all but one 
human firefly dies then after  a  short  time the game will end 
and the number of surviving  glow   worms  will be totalled up. 
The  winner  will  be  the   player  with  the  most  surviving 
offspring.

4) Graphics: One thing I have  not  implicated  very  well with 
this demo  is  the  graphics.   The  idea  of  having   a   one 
bitplane playfield for  the  background   was   that  it  could 
feature   superb   full   motion  animation.  There  should  be 
enough  remaining  memory  for  about  100  frames  of animated 
backdrop.

One idea is to digitize real trees  and bull rushes in a gentle 
breeze then play this  in  the  background  rather than have it 
static. This would also allow  us  to  let gusts of wind effect 
the fireflies.

Another idea is to rig up the  pond  in 3D on Imagine III  then
render it in solid black.  Placing  the camera in 100 different 
positions  along  a  horizontal  line.   This   will  give  the 
smoothest 3D animation (50 frames  a  second)  ever scene in an 
Amiga game. The camera  could  then  be  used   to  (appear to) 
track the action in the  game  allowing us  a  slightly  bigger 
lake. The fish and frog would  also  be given around 200 frames 
of animation each.

4) Rare events: we would also  add  about 10 rare events. These 
would add to long term appeal.  So  each time you play the game 
there is a 1 in 500 chance of a duck landing on the water. Or a 
1 in 1000 chance or UFO landing.

5) Date events: The game would  detect  the presence of a clock 
and then wish people happy Christmas,  happy New Year or inform 
them that one of the programming team has a Birthday coming up. 
Perhaps we  could also get a respected astrologer to write down 
events which should be in the  news on certain days and players 
could see if they were coming  true. Perhaps on certain days in 
December the pond could freeze  up  leading  you to skid on the 
ice.

6) I would like to fade in  the gravity and acceleration at the 
beginning  to stop people dying as soon as the game starts. The 
effect would be more smooth than slowing down the frame rate.

A Much Bigger Fireflies Project

This would need to  be  funded  by  advertising or Piracy would 
kill it. If we expand the  game  of Fireflies into 3D and stick 
it on the Internet. The  idea  would  be  that one player would 
play on each terminal.  This   lets   us  to abandon the single 
screen lake allowing us to  have  a  vast  3D lake. The greater 
freedom of moment will  allow  us  to  have perhaps around 2000 
players (if we can share   the   work  out between the machines 
and  some central servers). It   is   very  important that each 
player should only receive   information   about  the  part  of 
the lake relevant to them.

The new rules

1) Male Fireflies must be played my real life males.
2) Females  fireflies must be played by real life females.
3) Your tale  colour  and  length  will  represent  your social 
interests.

Once on the lake you can do what  you like. So if your a female 
Take That fan then you could  go  and  drown some East 17 fans. 
Outer Limits Vs X-files,  PC  Vs  Amigas  and  all Vs The Young 
Conservatives. We could even  hold  political debates where one 
view point kills the other.

Mating would also be different  after  finding a firefly of the 
opposite sex  who's interests  are  similar  to yours you would 
mate however  both  would  be  in  control  of  signalling  and 
decision making. To disentangle you would both have to pull the 
same direction simultaneously a  certain  number of times. Both
Fireflies could then fly  off  to  a  tree  or bank. The screen 
would then split four  ways  as  shown.  One  part would show a 
zoomed in female laying  her  eggs  with  the  male beside her. 
Another would show a quarter screen  version of the game so you 
can look out for rival  males  (or  make  sure the girl you met 
last night does not catch you  with  someone else). The rest of 
the screen would allow you  to  talk  to  each other, view each 
others dubious self portrait or digitized photo and exchange E- 
mail addresses.

Once up and running the  system  would be improved allowing the 
best players to be reincarnated  as  fish, birds, moths, frogs, 
pike & tadpoles. Each with its own life cycle, we would keep on 
upgrading the game until we  have a complete ecosystem. Perhaps 
even a plant simulator, where you  have to decide if you should 
invest energy in new leaves  (and  decide  where you should put 
them) or perhaps more energy  should  be put in to reproduction 
may be your route network needs to be expanded.

Perhaps the most interesting thing about it is that it does not 
require a wild leap of imagination  to see why girls might find 
it interesting. This game is intended to be very social and its 
lack of score and purpose  makes  it  quite different any other 
game.

The game will run in a similar  fashion  to a TV show. With two 
half hour games each evening. The lines  to log on will open 10 
minuets before the game starts and players must log on early to 
be sure they get a place and  to  give us time to set up stuff. 
Before the game starts there will  be adverts from our sponsors 
(perhaps tailored to the  players  personal taste) and trailers 
for your forth coming games then the theme music titles and the
game begins.

Celebrities could also be  invited  to  play imagine what chaos 
there would be if Take  That  were  playing.  I wonder how long 
Salman Rushdi against the fundamentalists would last.


Interests
Mental:

1) Computing -  animation,  programming,  AI,  3D rendering and
just generally replicating and bending physics.
2) Cutting edge science  -  The  future  of  mass storage, nano
technology,  holograms,   pseudo   3D,   super   dense   atoms,
fundamental particles and the workings of the brain.
3) Wildlife - Flying squirrels, ants slow worms & pond life.
4) French bangers -  what haven't we done with them.
5) Performing  -  Although  sometimes  quite  shy  I  do  enjoy
performing  on stage. I have got  through  to the finals of the
school spoken English twice  and  won  it  once.  I would enjoy
pushing products and ideas publicly.
6) Advertising - I have an instinctive desire to impress, would
love influencing people. I would  like  to bring advertising to
the games industry in  a  way  that  the product placement just
adds atmosphere or the ads  are  so  good they just enhance the
product. I firmly  believe  total  sponsorship  to  be the only
sensible way of funding  link up game with hundreds of players.
It also turns Piracy into  a  good  thing  rather than it being 
bad.
8) Space the moon and quantum physics.
9) The paranormal - magnetic resinance, spoon bending & UFO's
10) Dreaming.

Physical:

1) Skiing - I just love it (specially black runs).
2) Climbing - very good fun.
3) Badminton and Squash - good convenient fun.
4) Generally hanging from things - I'd love to do my own motion
capture stunts. I can hang from my arms (only) continuously for
five minuets. I can also hang from  one arm and juggle with two
balls in the other hand.
5) Building and being the first  to  test  a 24 foot high death
slide made from a length  of  rope  and  a plastic  water pipe.
Also 5 people on a rope swing over a stream was fun.
6) Cycling - we live in  the  bottom  of a valley so where ever
you go is up hill I  can  now  cycle  up Kit Hill (two miles of
solid steep up hill) with out stopping.
7) Cycling down Kit Hill.
8) Snorkelling - sea cucumbers, squid, eels and crabs.


I respect:

Animation 
1) Aardman Animation - Loves Me, Loves Me Not
2) Nick park -  A  Grand  Day  Out, Archy's Concrete Nightmare,
Creature Comforts, The Wrong Trousers & A Close Shave.
3) The Sandman - A scary animation  this to horror what a Grand
Day out is to comedy.
4) Blindscape - This depicts  a  blind  man stumbling through a
forest, puts its point across very well.
5) Manipulation - Good Oscar winning stuff.
6) The Cat Came Back - Funny.


MUSIC

[Sleeper]: (Louise Wener),  I should  be going to see them live
at Bristol Anson Rooms.

Crowded House: Private Universe  is  prehaps the best song ever
written.

Pulp: Very good a performing.

Britpop in general.


Comedy
1) Jeremy Hardy - A  public  speaker  just  breaking into TV (a
good friend of Jack Dee). His first book "When did you last see
your father" is incredibly funny.  So  was  the first Radio 1 &
Radio 4 series Jeremy Hardy Speaks To The Nation.
2) Black Adder - This did for sarcasm what Monty Python did for
the surreal.
3) Monty Python - You probably know them.
4) Faulty Towers - Genius
4) Whose Line Is It Anyway - Ryan Styles is very funny.
5) Have I Got News For You - Getting a bit old now.
6) Alan  Partridge,  The  Day  Today  and  The  Saturday  Night
Armistice - all these have the  same  people in and behind them
these people should now make a film.
7) Fist Of Fun  -  The  last  few  episodes  of the first radio
series was brilliant. Then came the new controller of Radio One 
and the next two radio   series   were   not  very good. The TV 
series was OK but  tended  to  repeat  radio material. They are
also good friends with people behind 6).
8) The Young Ones - and Bottom.
9) Red Dwarf - nice.

Film

1) The Dark Crystal - very  strong  story line and just so many
nice touches. A very well conceived world, brilliant characters
(none of the mutant humanoid rubbish which has become so common
now).
2) Monty Python Films - You must have seen them.
3) Jason and The Argonauts & Clash  of The Titans - very strong
stories, told well.
4)  Time  Bandits  -  Brilliant   observational  humour  superb 
escapist plot.
5) Dead Poets Society - Sad.
6) Toy Story
7) Box of Delights - very good BBC drama.

TV Stations
Channel 4 & BBC 2: Good stuff.

Books           
Disk World Novels
Roald Dahl
The Emperors New Mind


CONTACT


I've just made my  A-level grades to go to the university of my
choice which is Bristol  (Maths B,  Chemistry B and Biology C).
However I  do not  know   my  address  yet.  I will  be reading
computer science so you  can  E-Mail me there:
ph5885@bristol.ac.uk.

I have long holidays around Christmas, Easter and Spring. Where
you can send letters to me at home:

Philip Holden
Greenscome Barn
Luckett
Callington
Cornwall

PL17 8LF

My term time address is:

Philip Holden
Goldney Hall
University of Bristol
Lower Clifton Hill
Bristol

BS8 1BH


I've just become a christian  and have discovered that I got to
the same church as Nick Park.
